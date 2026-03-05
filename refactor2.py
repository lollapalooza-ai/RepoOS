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
from typing import List, Dict, Optional, Union, AsyncGenerator, Literal
import hashlib
import ast
import pyflakes.api
import pyflakes.reporter
import io
import tempfile
import subprocess

# --- Config ---
MODEL_NAME = "qwen2.5-coder:14b-instruct-q4_K_M"
VENV_PYTHON = "./venv/bin/python3"

def validate_virtual_workspace(state: Dict[str, str]) -> tuple[bool, str]:
    """Step 3.2.1: Validates cross-file dependencies using mypy in a virtual workspace."""
    with tempfile.TemporaryDirectory() as tmpdir:
        for path, content in state.items():
            tmp_path = os.path.join(tmpdir, path)
            os.makedirs(os.path.dirname(tmp_path), exist_ok=True)
            with open(tmp_path, 'w', encoding='utf-8') as f:
                f.write(content)
        
        try:
            # We use --ignore-missing-imports and --follow-imports=silent to focus on the files we have
            # and --no-error-summary to keep output clean.
            result = subprocess.run(
                [VENV_PYTHON, "-m", "mypy", tmpdir, "--ignore-missing-imports", "--follow-imports=silent", "--no-error-summary"],
                capture_output=True, text=True, check=False
            )
            if result.returncode != 0:
                # Clean up output to hide temp paths
                errors = result.stdout.replace(tmpdir + "/", "")
                # Only return errors if they are relevant to cross-file attribute/module lookup
                # This is a bit heuristic, but it's what the directive asks for.
                if "has no attribute" in errors or "Module" in errors:
                    return False, f"Cross-file dependency error: {errors.strip()}"
            return True, ""
        except Exception as e:
            return True, f"Type check skipped due to error: {str(e)}"

class ASTCollisionError(Exception):
    pass

def get_namespace_identifiers(file_content: str) -> set:
    """Extracts all function names, class names, and imported aliases from a file's AST."""
    identifiers = set()
    try:
        tree = ast.parse(file_content)
        for node in ast.walk(tree):
            if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef, ast.ClassDef)):
                identifiers.add(node.name)
            elif isinstance(node, ast.Import):
                for alias in node.names:
                    identifiers.add(alias.asname or alias.name)
            elif isinstance(node, ast.ImportFrom):
                for alias in node.names:
                    identifiers.add(alias.asname or alias.name)
    except SyntaxError:
        pass # Handle syntax errors separately in the main loop
    return identifiers

def is_semantically_valid(content: str) -> tuple[bool, str]:
    # 1. Anti-Placeholder Guardrail
    forbidden_phrases = [
        "# placeholder", 
        "# ...", 
        "pass  #", 
        "# rest of code",
        "# existing code"
    ]
    
    content_lower = content.lower()
    for phrase in forbidden_phrases:
        if phrase in content_lower:
            return False, f"Code contains forbidden placeholder: '{phrase}'. Token laziness is strictly prohibited. You MUST write the COMPLETE and executable node."
    
    # 2. Syntax Check
    try:
        ast.parse(content)
    except SyntaxError as e:
        return False, f"SyntaxError during AST parse: {str(e)}"

    # 3. Semantic Check (Catches missing imports / undefined names)
    output = io.StringIO()
    reporter = pyflakes.reporter.Reporter(output, output)
    pyflakes.api.check(content, '', reporter)

    errors = output.getvalue()
    if "undefined name" in errors:
        return False, f"Missing Import detected: {errors.strip()}. You MUST use 'add_import'."

    return True, ""

# --- Pydantic Models (Step 2: Constrained Decoding) ---

class TaskItem(BaseModel):
    task: str = Field(..., description="A clear, actionable description of the refactoring step.")
    context: Dict[str, List[str]] = Field(..., description="A mapping of file paths to the specific functions or classes relevant to this task.")

class TaskList(BaseModel):
    tasks: List[TaskItem] = Field(..., description="A sequential list of tasks to complete the refactor.")

class CreateFile(BaseModel):
    action: Literal["create_file"] = "create_file"
    file_path: str = Field(..., description="Path to the new file.")
    content: str = Field(..., description="The complete content of the new file.")

class DeleteFile(BaseModel):
    action: Literal["delete_file"] = "delete_file"
    file_path: str = Field(..., description="Path to the file to delete.")

class ModifyNode(BaseModel):
    action: Literal["modify_node"] = "modify_node"
    file_path: str = Field(..., description="Path to the file to modify.")
    target_node_signature: str = Field(..., description="The function or class name to replace (e.g., 'my_func' or 'MyClass.my_method').")
    proposed_replace_string: str = Field(..., description="The NEW complete code for that node (function/class).")

class AddImport(BaseModel):
    action: Literal["add_import"] = "add_import"
    file_path: str = Field(..., description="Path to the file to modify.")
    import_statement: str = Field(..., description="The import statement to add (e.g., 'import os' or 'from typing import Any').")

class MoveNode(BaseModel):
    action: Literal["move_node"] = "move_node"
    source_file: str = Field(..., description="Path to the file to move the node FROM.")
    target_file: str = Field(..., description="Path to the file to move the node TO.")
    node_signature: str = Field(..., description="The function or class name to move (e.g., 'my_func' or 'MyClass.my_method').")

class RefactorProposal(BaseModel):
    actions: List[Union[CreateFile, DeleteFile, ModifyNode, AddImport, MoveNode]] = Field(..., description="A list of discrete refactoring actions.")

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

def extract_name_from_signature(signature: str) -> str:
    """Extracts the base name from a signature (e.g., 'MyClass.my_method' -> 'my_method')."""
    return signature.split('.')[-1]

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

def resolve_path(target_path: str, master_state: dict) -> str:
    """
    Repo-agnostic path resolution. Maps an LLM's potentially truncated 
    or relative path to the true workspace path.
    """
    known_paths = list(master_state.keys())
    if not known_paths:
        return target_path

    # 1. Exact Match (The LLM provided the perfect path)
    if target_path in known_paths:
        return target_path

    # 2. Suffix Match (Handles Modification of existing files)
    # If LLM outputs "core/csv_utils.py", we match it to "src/app/core/csv_utils.py"
    suffix_matches = [p for p in known_paths if p.endswith(target_path)]
    if len(suffix_matches) == 1:
        return suffix_matches[0]

    # 3. Path Reconstruction (Handles CreateFile)
    # Infer the working directory from the common path of all files currently in context
    try:
        common_path = os.path.commonpath(known_paths)
        # Fix: Ensure we extract the directory if the common path is actually a file
        # This prevents NotADirectoryError when master_state only has one file
        if common_path in known_paths:
            common_dir = os.path.dirname(common_path)
        else:
            common_dir = common_path
    except ValueError:
        common_dir = "" # Fallback if paths are on different drives

    if common_dir and not target_path.startswith(common_dir):
        # Normalize separators for cross-platform compatibility
        target_parts = target_path.replace('\\', '/').split('/')
        common_parts = common_dir.replace('\\', '/').split('/')

        # Detect overlap to prevent directory duplication 
        # (e.g., common_dir="src/app", target="app/new.py" -> "src/app/new.py")
        overlap_idx = 0
        for i in range(1, min(len(common_parts), len(target_parts)) + 1):
            if common_parts[-i:] == target_parts[:i]:
                overlap_idx = i

        if overlap_idx > 0:
            return os.path.join(common_dir, *target_parts[overlap_idx:])
        else:
            return os.path.join(common_dir, target_path)

    return target_path

def calculate_checksum(content: str) -> str:
    import hashlib
    return hashlib.md5(content.encode('utf-8')).hexdigest()

def apply_actions_to_state(master_state: Dict[str, str], actions: List[Union[CreateFile, DeleteFile, ModifyNode, AddImport, MoveNode]], original_checksums: Dict[str, str] = None, intent: str = "") -> Dict[str, str]:
    """
    Programmatically applies surgical actions (Phase 2 Upgrade).
    """
    new_state = master_state.copy()
    for action in actions:
        # 1. Resolve the path dynamically (Phase 1: Repo-Agnostic Path Resolution)
        path = resolve_path(action.file_path if hasattr(action, 'file_path') else "", master_state)
        
        # Step 3A: Pre-flight checksum check
        if original_checksums and path in original_checksums and path in new_state:
            current_content = fetch_file_content(path)
            if current_content and calculate_checksum(current_content) != original_checksums[path]:
                print(f"❌ STATE_MUTATION_DETECTED: {path} was modified externally. Aborting action.")
                continue

        if action.action == "create_file":
            # 2. Block destructive overwrites (Phase 2: State Machine Guardrails)
            if path in master_state:
                raise ValueError(
                    f"Action Rejected: Cannot use 'create_file' on existing file '{path}'. "
                    f"You MUST use 'modify_node' or 'add_import'."
                )
            new_state[path] = action.content
            print(f"   🆕 Created file: {path}")

        elif action.action == "delete_file":
            # Phase 5: Forbidding Phantom Deletions
            if "delete" not in intent.lower() and "remove" not in intent.lower():
                raise ValueError(
                    f"Action Rejected: 'delete_file' on '{path}' is not allowed unless the intent explicitly mentions deletion. "
                    f"To remove code, use 'modify_node' instead."
                )
            if path in new_state:
                del new_state[path]
                print(f"   🗑️ Deleted file: {path}")

        elif action.action == "modify_node":
            if path not in new_state:
                print(f"❌ Modify Error: File {path} not found in state.")
                continue
            content = new_state[path]
            node_range = find_node_range(content, action.target_node_signature)
            if node_range:
                start, end = node_range
                new_state[path] = content[:start] + action.proposed_replace_string + content[end:]
                print(f"   🎯 Applied AST-targeted replacement to {path} at node '{action.target_node_signature}'")
            else:
                print(f"❌ Modify Error: Node '{action.target_node_signature}' not found in {path}.")

        elif action.action == "move_node":
            source_path = resolve_path(action.source_file, master_state)
            target_path = resolve_path(action.target_file, master_state)
            
            if source_path not in new_state:
                print(f"❌ Move Error: Source file {source_path} not found in state.")
                continue
            
            source_content = new_state[source_path]
            node_range = find_node_range(source_content, action.node_signature)
            if not node_range:
                print(f"❌ Move Error: Node '{action.node_signature}' not found in {source_path}.")
                continue
            
            start, end = node_range
            node_code = source_content[start:end]
            
            # Phase 6: AST Collision Check
            target_content = new_state.get(target_path, "")
            if target_content:
                target_namespace = get_namespace_identifiers(target_content)
                moved_node_name = extract_name_from_signature(action.node_signature)
                if moved_node_name in target_namespace:
                    raise ASTCollisionError(
                        f"Namespace Collision: Cannot move '{moved_node_name}' to '{target_path}'. "
                        f"The target file already contains a class, function, or import with the exact same name. "
                        f"Please use 'modify_node' to alias the existing identifier in the target file before moving."
                    )

            # 1. Pop from source
            new_state[source_path] = source_content[:start] + source_content[end:]
            # Clean up potential double newlines or artifacts (basic)
            new_state[source_path] = new_state[source_path].replace("\n\n\n", "\n\n")
            
            # 2. Append to target
            if target_path not in new_state:
                new_state[target_path] = ""
            new_state[target_path] += "\n\n" + node_code
            print(f"   🚀 Moved node '{action.node_signature}' from {source_path} to {target_path}")

        elif action.action == "add_import":
            if path not in new_state:
                new_state[path] = ""
            content = new_state[path]
            if action.import_statement not in content:
                # Add at the top
                new_state[path] = action.import_statement + "\n" + content
                print(f"   ⚓ Added import to {path}: {action.import_statement}")
        
    return new_state

def apply_updates(file_updates: Dict[str, str], original_checksums: Dict[str, str] = None):
    """Writes changes to disk with strict checksum verification (Step 3A)."""
    for path, content in file_updates.items():
        if original_checksums and path in original_checksums:
            disk_content = fetch_file_content(path)
            if disk_content and calculate_checksum(disk_content) != original_checksums[path]:
                print(f"❌ CRITICAL: State mismatch for {path} just before write. Aborting.")
                continue

        dir_name = os.path.dirname(path)
        if dir_name:
            os.makedirs(dir_name, exist_ok=True)
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"   💾 Persisted changes to {path}")

def fetch_file_content(path: str) -> Optional[str]:
    try:
        with open(path, 'r', encoding='utf-8') as f: return f.read()
    except: return None

# --- Graph Engine ---
NEO4J_URI, NEO4J_AUTH = "bolt://localhost:7687", ("neo4j", "password")
embedder = SentenceTransformer('all-MiniLM-L6-v2')
driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)

def get_hybrid_context(instruction: str) -> Dict[str, List[str]]:
    """Phase 1: Dynamic Context Scoping. Pulls entire file AST if 'audit' intent detected."""
    context_map = {}
    
    # Heuristic for intent-based scoping
    audit_match = re.search(r"(audit|all functions in|all classes in|everything in)\s+([a-zA-Z0-9_\-\./]+)", instruction, re.IGNORECASE)
    
    if audit_match:
        target_path = audit_match.group(2)
        print(f"🔍 Intent Detected: Full-file audit for '{target_path}'. Bypassing vector search.")
        with driver.session() as session:
            # Query all functions and classes for this file
            query = """
            MATCH (n) 
            WHERE (n:Function OR n:Class) AND n.file ENDS WITH $target_path
            RETURN n.name, n.file
            """
            result = session.run(query, target_path=target_path)
            for record in result:
                f = record['n.file']
                if f not in context_map: context_map[f] = []
                context_map[f].append(record['n.name'])
        
        if context_map:
            return context_map

    # Fallback to vector search (K=5)
    query_vector = embedder.encode(instruction).tolist()
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
    intent = ""
    if args.drive_spec:
        print(f"📂 Loading specification from: {args.drive_spec}")
        try:
            with open(args.drive_spec, 'r') as f:
                spec_data = json.load(f)
            task_list = TaskList.model_validate(spec_data)
            intent = spec_data.get('intent', "Executing loaded specification")
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
            if content:
                valid, error = is_semantically_valid(content)
                if not valid:
                    print(f"❌ Syntax/Semantic Error detected in {path}: {error}. Aborting main pipeline for triage.")
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
        
        # Phase 3: Precision Routing via Sub-Tree GraphRAG
        context_blocks = []
        for path, node_names in task.context.items():
            content = master_state.get(path, "")
            if not content: continue
            
            file_block = f'<file_context path="{path}">'
            for node_name in node_names:
                node_range = find_node_range(content, node_name)
                if node_range:
                    start, end = node_range
                    node_code = content[start:end]
                    # In a real implementation, we'd also fetch adjacent docstrings from Neo4j
                    file_block += f'\n<node signature="{node_name}">\n{node_code}\n</node>'
            file_block += "\n</file_context>"
            context_blocks.append(file_block)
        
        context_str = "\n\n".join(context_blocks)
        
        sys_prompt = (
            "You are an elite Principal AI Engineer refactoring a complex Python monolith. "
            "You will be provided with a strict sub-tree of the codebase. "
            "CRITICAL RULES: \n"
            "1. NEVER use the 'create_file' action to modify an existing file. It will wipe the file.\n"
            "2. NO TOKEN LAZINESS. You are strictly forbidden from using placeholders like '# ...' or '# existing code'. "
            "If you use a 'modify_node' action, you MUST output the entire, unbroken, executable code for that node.\n"
            "3. When creating new files, ensure you include ALL necessary imports.\n"
            "4. NEVER use the 'delete_file' action unless the user's prompt explicitly contains the words 'delete' or 'remove' for that specific file. To remove code, use 'modify_node'.\n"
            "5. Use 'move_node' to refactor code between files while preserving integrity."
        )
        user_prompt = f"CONTEXT:\n{context_str}\n\nINSTRUCTION:\n{task.task}\n\nOutput MUST strictly conform to the Pydantic Action Union. DO NOT modify any code outside the provided node bounds."
        
        max_retries = 3
        retry_count = 0
        error_msg = ""
        
        while retry_count < max_retries:
            if error_msg:
                print(f"   🔄 Self-Healing Retry {retry_count}/{max_retries} due to: {error_msg}")
                current_user_prompt = f"{user_prompt}\n\nPREVIOUS ATTEMPT FAILED WITH ERROR: {error_msg}\nPlease correct the indentation or syntax and retry."
            else:
                current_user_prompt = user_prompt
                print("🧠 Generating Actions...", end="")

            full_patch_json = ""
            async for token in generate_streaming_json(sys_prompt, current_user_prompt, RefactorProposal):
                full_patch_json += token
            print(" Done.\n")
            
            try:
                proposal = RefactorProposal.model_validate_json(full_patch_json)
                new_state = apply_actions_to_state(master_state, proposal.actions, master_checksums, intent=intent)
                
                # Step 3: Verification
                syntax_error = False
                for path, content in new_state.items():
                    if path.endswith(".py"):
                        valid, error = is_semantically_valid(content)
                        if not valid:
                            error_msg = f"Verification failed for {path}: {error}"
                            syntax_error = True
                            break
                
                if not syntax_error:
                    # Step 3.2.1: Virtual Workspace Validation (Phase 7)
                    valid, error = validate_virtual_workspace(new_state)
                    if not valid:
                        error_msg = error
                        syntax_error = True

                if not syntax_error:
                    # Show diff and confirm
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
                        print("No changes proposed for this task. Skipping confirmation.")
                        break # Exit retry loop and move to next task
                            
                    print(f"\nApply changes for Task {i+1}? (y/n): ", end="", flush=True)
                    confirm = 'y' if args.yes else sys.stdin.readline().strip().lower()
                    if confirm == 'y':
                        master_state.update(new_state)
                        print("✅ Changes accepted in-memory.")
                        break # Exit retry loop
                    else:
                        print("🛑 Task rejected. Aborting.")
                        return
                else:
                    retry_count += 1
            except Exception as e:
                error_msg = str(e)
                retry_count += 1
        
        if retry_count == max_retries:
            print(f"❌ Failed to generate valid patches for task after {max_retries} attempts. Aborting.")
            return
            
    print("\n💾 Writing all changes to disk...")
    apply_updates(master_state, master_checksums)
    print("✅ Complete.")

if __name__ == "__main__":
    asyncio.run(main())
