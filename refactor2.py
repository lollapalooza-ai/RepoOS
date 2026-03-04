import difflib
import argparse
import os
import sys
import json
import re
import asyncio
import ollama
import tree_sitter_python as tspython
from tree_sitter import Language, Parser
from neo4j import GraphDatabase
from sentence_transformers import SentenceTransformer
from pydantic import BaseModel, Field
from typing import List, Dict, Optional, Union, AsyncGenerator
import hashlib
import ast

# --- Pydantic Models (Step 2: Constrained Decoding) ---

class TaskItem(BaseModel):
    task: str = Field(..., description="A clear, actionable description of the refactoring step.")
    context: Dict[str, List[str]] = Field(..., description="A mapping of file paths to the specific functions or classes relevant to this task.")

class TaskList(BaseModel):
    tasks: List[TaskItem] = Field(..., description="A sequential list of tasks to complete the refactor.")

class SearchAndReplace(BaseModel):
    file_path: str = Field(..., description="Path to the file to modify.")
    target_node_signature: Optional[str] = Field(None, description="Optional: The function or class name where this change occurs (e.g., 'my_func' or 'MyClass.my_method').")
    exact_search_string: str = Field(..., description="The EXACT literal text to find in the file. MUST BE EXACT and unique.")
    proposed_replace_string: str = Field(..., description="The text to replace it with.")

class RefactorProposal(BaseModel):
    patches: List[SearchAndReplace] = Field(..., description="A list of surgical search-and-replace blocks.")

# --- Config ---
MODEL_NAME = "qwen2.5-coder:14b-instruct-q4_K_M"

# Global Parser setup
PY_LANGUAGE = Language(tspython.language())
parser = Parser(PY_LANGUAGE)

async def generate_streaming_json(system_prompt: str, user_prompt: str, response_model: BaseModel) -> AsyncGenerator[str, None]:
    """
    Streams tokens from Ollama while enforcing the Pydantic schema (Step 2: Constrained Decoding).
    """
    client = ollama.AsyncClient()
    schema = response_model.model_json_schema()
    
    async for part in await client.chat(
        model=MODEL_NAME,
        messages=[
            {'role': 'system', 'content': f"{system_prompt}\nReturn ONLY valid JSON matching this schema: {json.dumps(schema)}"},
            {'role': 'user', 'content': user_prompt}
        ],
        format=schema,
        stream=True,
        options={'temperature': 0.1}
    ):
        yield part['message']['content']

def calculate_checksum(content: str) -> str:
    return hashlib.md5(content.encode('utf-8')).hexdigest()

def find_node_range(source_code: str, signature: str) -> Optional[tuple[int, int]]:
    """Uses tree-sitter to find the byte range of a function or class."""
    tree = parser.parse(bytes(source_code, "utf8"))
    
    # Query for functions or classes with the given name
    query = PY_LANGUAGE.query(f"""
    (function_definition name: (identifier) @name (#eq? @name "{signature}")) @def
    (class_definition name: (identifier) @name (#eq? @name "{signature}")) @def
    """)
    
    captures = query.captures(tree.root_node)
    if isinstance(captures, dict):
        nodes = captures.get('def', [])
        if nodes:
            return nodes[0].start_byte, nodes[0].end_byte
    elif captures:
        for node, name in captures:
            if name == 'def':
                return node.start_byte, node.end_byte
    return None

def apply_patches_to_state(master_state: Dict[str, str], patches: List[SearchAndReplace], original_checksums: Dict[str, str] = None) -> Dict[str, str]:
    """
    Programmatically applies surgical patches (Phase 2 Upgrade).
    """
    new_state = master_state.copy()
    for patch in patches:
        path = patch.file_path
        if path not in new_state: continue
        
        # Step 3A: Pre-flight checksum check
        if original_checksums and path in original_checksums:
            current_content = fetch_file_content(path)
            if current_content and calculate_checksum(current_content) != original_checksums[path]:
                print(f"❌ STATE_MUTATION_DETECTED: {path} was modified externally. Aborting patch.")
                continue

        content = new_state[path]
        
        # Strategy 1: Exact Match (Fastest)
        if patch.exact_search_string in content and content.count(patch.exact_search_string) == 1:
            new_state[path] = content.replace(patch.exact_search_string, patch.proposed_replace_string)
            print(f"   ✨ Applied exact match patch to {path}")
            continue

        # Strategy 2: AST Anchor Targeting (Step 1A)
        if patch.target_node_signature:
            node_range = find_node_range(content, patch.target_node_signature)
            if node_range:
                start, end = node_range
                node_content = content[start:end]
                # Try exact match WITHIN the node
                if patch.exact_search_string in node_content:
                    new_node_content = node_content.replace(patch.exact_search_string, patch.proposed_replace_string)
                    new_state[path] = content[:start] + new_node_content + content[end:]
                    print(f"   🎯 Applied AST-targeted patch to {path} at node '{patch.target_node_signature}'")
                    continue
        
        # Strategy 3: Fuzzy / Fallback
        print(f"❌ Patch Error: Search block not found in {path}. Use 'target_node_signature' for better accuracy.")
        
    return new_state

def apply_updates(file_updates: Dict[str, str], original_checksums: Dict[str, str] = None):
    """Writes changes to disk with strict checksum verification (Step 3A)."""
    for path, content in file_updates.items():
        if original_checksums and path in original_checksums:
            disk_content = fetch_file_content(path)
            if disk_content and calculate_checksum(disk_content) != original_checksums[path]:
                print(f"❌ CRITICAL: State mismatch for {path} just before write. Aborting.")
                continue

        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"   💾 Persisted changes to {path}")

def fetch_file_content(path: str) -> Optional[str]:
    try:
        with open(path, 'r', encoding='utf-8') as f: return f.read()
    except: return None

def is_valid_python(content: str) -> bool:
    try:
        ast.parse(content)
        return True
    except SyntaxError:
        return False

# --- Graph Engine ---
NEO4J_URI, NEO4J_AUTH = "bolt://localhost:7687", ("neo4j", "password")
embedder = SentenceTransformer('all-MiniLM-L6-v2')
driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)

def get_hybrid_context(instruction: str) -> Dict[str, List[str]]:
    query_vector = embedder.encode(instruction).tolist()
    context_map = {}
    with driver.session() as session:
        result = session.run("CALL db.index.vector.queryNodes('function_embeddings', 5, $embedding) YIELD node AS anchor, score WHERE score > 0.65 RETURN anchor.name, anchor.file", embedding=query_vector)
        for record in result:
            f = record['anchor.file']
            if f:
                if f not in context_map: context_map[f] = []
                context_map[f].append(record['anchor.name'])
    return context_map

# --- CLI Execution ---
async def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-y", "--yes", action="store_true")
    parser.add_argument("--local", action="store_true")
    parser.add_argument("--blueprint-export", type=str, help="Generate a TaskList JSON and save it to the provided path.")
    parser.add_argument("--drive-spec", type=str, help="Load a TaskList JSON from a file and execute it.")
    args, unknown_args = parser.parse_known_args()

    task_list = None
    if args.drive_spec:
        print(f"📂 Loading specification from: {args.drive_spec}")
        try:
            with open(args.drive_spec, 'r') as f:
                spec_data = json.load(f)
            task_list = TaskList.model_validate(spec_data)
        except Exception as e:
            print(f"❌ Error loading spec: {e}")
            return
    else:
        intent = " ".join(unknown_args) if unknown_args else input("Enter Refactor Intent: ")
        print(f"\n🧠 Gathering context for intent: {intent}")
        context_map = get_hybrid_context(intent)
        
        if not context_map:
            print("No relevant code found.")
            sys.exit(0)

        print(f"   ✅ Found context in files: {list(context_map.keys())}")
        
        # Step 2A: The Native Gatekeeper
        for path in context_map:
            content = fetch_file_content(path)
            if content and not is_valid_python(content):
                print(f"❌ Syntax Error detected in {path}. Aborting main pipeline for triage.")
                return

        task_sys_prompt = "You are a senior architect. Generate a sequential list of refactoring tasks."
        task_user_prompt = f"INSTRUCTION: {intent}\nCONTEXT: {json.dumps(context_map)}"
        
        print("\n🧠 Generating Refactoring Plan...")
        full_task_json = ""
        async for token in generate_streaming_json(task_sys_prompt, task_user_prompt, TaskList):
            full_task_json += token
            print(token, end="", flush=True)
        print("\n")
        
        try:
            task_list = TaskList.model_validate_json(full_task_json)
            if args.blueprint_export:
                with open(args.blueprint_export, 'w', encoding='utf-8') as f:
                    json.dump(task_list.model_dump(), f, indent=2)
                print(f"✅ Blueprint exported to {args.blueprint_export}")
                return
        except Exception as e:
            print(f"❌ Failed to parse tasks: {e}")
            return

    # Extract all files mentioned in the task list
    all_files = set()
    for task in task_list.tasks:
        all_files.update(task.context.keys())

    # Fetch initial file state and checksums (Step 3A)
    master_state = {}
    master_checksums = {}
    for path in all_files:
        content = fetch_file_content(path)
        if content:
            master_state[path] = content
            master_checksums[path] = calculate_checksum(content)
    
    for i, task in enumerate(task_list.tasks):
        print(f"\n--- Executing Task {i+1}/{len(task_list.tasks)}: {task.task} ---")
        
        step_files = {p: master_state.get(p, "") for p in task.context if p in master_state}
        context_str = "\n\n".join(f"--- FILE: {p} ---\n{c}" for p, c in step_files.items())
        
        sys_prompt = "You are a Principal Engineer. Provide surgical SearchAndReplace patches."
        user_prompt = f"CONTEXT:\n{context_str}\n\nINSTRUCTION:\n{task.task}"
        
        print("🧠 Generating Patches...", end="")
        full_patch_json = ""
        async for token in generate_streaming_json(sys_prompt, user_prompt, RefactorProposal):
            full_patch_json += token
        print(" Done.\n")
        
        try:
            proposal = RefactorProposal.model_validate_json(full_patch_json)
            new_state = apply_patches_to_state(master_state, proposal.patches, master_checksums)
            
            # Show diff
            print("\n🔍 REVIEW PROPOSED CHANGES:")
            has_changes = False
            for path, new_content in new_state.items():
                old_content = master_state.get(path, "")
                if old_content == new_content: continue
                has_changes = True
                print(f"\n--- File: {path} ---")
                diff = difflib.unified_diff(old_content.splitlines(keepends=True), new_content.splitlines(keepends=True), fromfile=f"a/{path}", tofile=f"b/{path}", lineterm="")
                for line in diff:
                    print(line.rstrip())
            
            if not has_changes:
                print("No changes proposed for this task.")
                    
            print(f"\nApply changes for Task {i+1}? (y/n): ", end="", flush=True)
            confirm = 'y' if args.yes else sys.stdin.readline().strip().lower()
            if confirm == 'y':
                master_state.update(new_state)
                print("✅ Changes accepted in-memory.")
            else:
                print("🛑 Task rejected. Aborting.")
                return
        except Exception as e:
            print(f"❌ Failed to parse or apply patches: {e}")
            return
            
    print("\n💾 Writing all changes to disk...")
    apply_updates(master_state, master_checksums)
    print("✅ Complete.")

if __name__ == "__main__":
    asyncio.run(main())
