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

# --- Pydantic Models (Step 2: Constrained Decoding) ---

class TaskItem(BaseModel):
    task: str = Field(..., description="A clear, actionable description of the refactoring step.")
    context: Dict[str, List[str]] = Field(..., description="A mapping of file paths to the specific functions or classes relevant to this task.")

class TaskList(BaseModel):
    tasks: List[TaskItem] = Field(..., description="A sequential list of tasks to complete the refactor.")

class SearchAndReplace(BaseModel):
    file_path: str = Field(..., description="Path to the file to modify.")
    exact_search_string: str = Field(..., description="The EXACT literal text to find in the file. MUST BE EXACT and unique.")
    proposed_replace_string: str = Field(..., description="The text to replace it with.")

class RefactorProposal(BaseModel):
    patches: List[SearchAndReplace] = Field(..., description="A list of surgical search-and-replace blocks.")

# --- Config ---
MODEL_NAME = "qwen2.5-coder:14b-instruct-q4_K_M"

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

def apply_patches_to_state(master_state: Dict[str, str], patches: List[SearchAndReplace]) -> Dict[str, str]:
    """
    Programmatically applies surgical patches (Step 3: Unified Diffing).
    """
    new_state = master_state.copy()
    for patch in patches:
        path = patch.file_path
        if path not in new_state: continue
        content = new_state[path]
        if patch.exact_search_string in content and content.count(patch.exact_search_string) == 1:
            new_state[path] = content.replace(patch.exact_search_string, patch.proposed_replace_string)
        else:
            print(f"⚠️ Warning: Could not cleanly apply patch to {path} (search string not found or ambiguous).")
    return new_state

def apply_updates(file_updates: Dict[str, str]):
    for path, content in file_updates.items():
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content)

def fetch_file_content(path: str) -> Optional[str]:
    try:
        with open(path, 'r', encoding='utf-8') as f: return f.read()
    except: return None

# --- Graph Engine (Step 1: Deterministic Context via ingest2.py) ---
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
    
    # Workflow A: Load from existing spec
    if args.drive_spec:
        print(f"📂 Loading specification from: {args.drive_spec}")
        try:
            with open(args.drive_spec, 'r') as f:
                spec_data = json.load(f)
            task_list = TaskList.model_validate(spec_data)
        except Exception as e:
            print(f"❌ Error loading spec: {e}")
            return
    # Workflow B: Generate new tasks
    else:
        intent = " ".join(unknown_args) if unknown_args else input("Enter Refactor Intent: ")
        print(f"\n🧠 Gathering context for intent: {intent}")
        context_map = get_hybrid_context(intent)
        
        if not context_map:
            print("No relevant code found.")
            sys.exit(0)

        print(f"   ✅ Found context in files: {list(context_map.keys())}")
        
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

    # --- EXECUTION ENGINE (Unified for both workflows) ---
    
    # 1. Identify all required files
    all_files = set()
    for task in task_list.tasks:
        all_files.update(task.context.keys())

    # 2. Fetch initial file state
    master_state = {path: fetch_file_content(path) for path in all_files if fetch_file_content(path)}
    
    # 3. Process each task
    for i, task in enumerate(task_list.tasks):
        print(f"\n--- Executing Task {i+1}/{len(task_list.tasks)}: {task.task} ---")
        
        step_files = {p: master_state.get(p, "") for p in task.context if p in master_state}
        context_str = "\n\n".join(f"--- FILE: {p} ---\n{c}" for p, c in step_files.items())
        
        sys_prompt = "You are a Principal Engineer. Provide surgical SearchAndReplace patches."
        user_prompt = f"CONTEXT:\n{context_str}\n\nINSTRUCTION:\n{task.task}"
        
        print("🧠 Generating Patches...", end="")
        full_patch_json = ""
        # Step 2: Constrained Decoding ensures valid patches
        async for token in generate_streaming_json(sys_prompt, user_prompt, RefactorProposal):
            full_patch_json += token
        print(" Done.\n")
        
        try:
            proposal = RefactorProposal.model_validate_json(full_patch_json)
            # Step 3: Surgical patch application
            new_state = apply_patches_to_state(master_state, proposal.patches)
            
            # Show diff for verification
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
                    
            confirm = 'y' if args.yes else input(f"\nApply changes for Task {i+1}? (y/n): ").lower()
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
    apply_updates(master_state)
    print("✅ Complete.")

if __name__ == "__main__":
    asyncio.run(main())
