import difflib # Import difflib
import argparse # Import argparse
import os
import sys
import json
import re # Import re for regular expressions
import time # Import time for sequential processing
import ollama
import tree_sitter_python as tspython
from tree_sitter import Language, Parser
from neo4j import GraphDatabase
from validator import validate_code # Import the validator
from sentence_transformers import SentenceTransformer
# --- Agent/Model Configuration ---
# Set the desired agent: 'ollama', 'gemini', or 'claude'
# The 'provider' argument in the functions will override this.
AGENT_PROVIDER = os.environ.get("AGENT_PROVIDER", "ollama").lower()
GEMINI_API_KEY = os.environ.get("GEMINI_API_KEY")
ANTHROPIC_API_KEY = os.environ.get("ANTHROPIC_API_KEY")
MAX_RETRIES = 3 # Max attempts for the self-healing loop


# Conditionally import cloud-based libraries
if AGENT_PROVIDER == "gemini" and GEMINI_API_KEY:
    import google.generativeai as genai
if AGENT_PROVIDER == "anthropic" and ANTHROPIC_API_KEY:
    import anthropic

def _repair_llm_json_string(malformed_json_str):
    s = malformed_json_str.replace('"""', '\\"\\"\\"').replace("'''", "\\'\\'\\'")
    repaired, in_string, i = [], False, 0
    while i < len(s):
        char = s[i]
        if char == '\\':
            if i + 1 < len(s): repaired.extend(s[i:i+2])
            else: repaired.append(char)
            i += 2
            continue
        if char == '"': in_string = not in_string
        if not in_string and char in '\n\r': pass
        elif in_string and char == '\n': repaired.append('\\n')
        elif in_string and char == '\r': repaired.append('\\r')
        else: repaired.append(char)
        i += 1
    return "".join(repaired)

# --- ANSI COLORS ---
class Colors:
    RED, GREEN, YELLOW, CYAN, RESET, BOLD = '\033[91m', '\033[92m', '\033[93m', '\033[96m', '\033[0m', '\033[1m'

def generate_code_from_agent(provider, system_prompt, user_prompt, temperature, model_name):
    """Calls the configured AI agent to generate code."""
    print(f"\n🧠 Calling Agent '{provider}' (Model: {model_name}, Temp: {temperature:.1f})...")
    if provider == "gemini":
        if not GEMINI_API_KEY: raise ValueError("GEMINI_API_KEY not set.")
        genai.configure(api_key=GEMINI_API_KEY)
        model = genai.GenerativeModel(model_name or 'gemini-1.5-pro-latest')
        full_prompt = f"{system_prompt}\n\n{user_prompt}"
        response = model.generate_content(full_prompt, generation_config={"temperature": temperature, "response_mime_type": "application/json"})
        return response.text
    elif provider == "anthropic":
        if not ANTHROPIC_API_KEY: raise ValueError("ANTHROPIC_API_KEY not set.")
        client = anthropic.Anthropic(api_key=ANTHROPIC_API_KEY)
        message = client.messages.create(
            model=model_name or "claude-3-opus-20240229", max_tokens=4096, temperature=temperature,
            system=system_prompt, messages=[{"role": "user", "content": user_prompt}]
        )
        return message.content[0].text
    else: # Default to Ollama
        response = ollama.chat(
            model=model_name, messages=[{'role': 'system', 'content': system_prompt}, {'role': 'user', 'content': user_prompt}],
            format='json', options={'temperature': temperature}
        )
        return response['message']['content']

def drive_agent_from_spec(blueprint_json, auto_confirm=False, local_only=False):
    """Parses Tiptap JSON, determines agent strategy, and executes tasks sequentially."""
    
    # 1. Extract all task nodes from the implementation plan
    task_items = []
    content_blocks = blueprint_json.get('content', [])
    plan_started = False
    for block in content_blocks:
        if block.get('type') == 'heading' and 'Implementation Plan' in get_text_from_node(block.get('content', [])):
            plan_started = True
            continue
        if plan_started and block.get('type') == 'taskList':
            def find_task_items(node):
                if node.get('type') == 'taskItem': task_items.append(node)
                if 'content' in node and node['content']:
                    for child in node['content']: find_task_items(child)
            find_task_items(block)
            break
            
    if not task_items:
        print("No actionable tasks found in the Implementation Plan.")
        return
        
    print(f"Found {len(task_items)} actionable tasks in Spec.")

    # 2. Pre-scan all tasks to gather the complete set of files for state management
    all_files = set()
    for item in task_items:
        task_context = item.get('attrs', {}).get('context', {})
        if task_context: all_files.update(task_context.keys())

    master_files_content = {path: fetch_file_content(path) for path in all_files if fetch_file_content(path) is not None}
    if not master_files_content:
        print(f"{Colors.RED}Error: Could not read content for any files mentioned in the spec's task contexts. Aborting.{Colors.RESET}")
        return

    # 3. Execute tasks sequentially
    for i, item in enumerate(task_items):
        task_text = get_text_from_node(item.get('content', [])).strip()
        task_context = item.get('attrs', {}).get('context', {})
        is_checked = item.get('attrs', {}).get('checked', False)

        if not task_text or is_checked or not task_context:
            print(f"Skipping task {i+1} (no instruction, already checked, or no context).")
            continue

        print(f"\n--- Executing Task {i+1}/{len(task_items)}: {task_text} ---")

        # 4. Determine agent strategy for this step
        is_complex = len(task_context.keys()) > 2
        provider = "ollama" if local_only or not is_complex else "gemini"
        
        # 5. Prepare the specific context for THIS step from the master state
        step_files_content = {path: master_files_content[path] for path in task_context if path in master_files_content}

        # 6. Perform the refactor step
        updated_files_for_step = _perform_llm_refactor_step(
            instruction=task_text,
            original_files_full_content=step_files_content,
            provider=provider,
            auto_confirm=auto_confirm
        )

        if updated_files_for_step:
            # 7. Merge changes back into the master state
            master_files_content.update(updated_files_for_step)
            print(f"✅ Task {i+1} completed. In-memory state updated.")
        else:
            print(f"🛑 Task {i+1} was rejected or failed. Aborting sequential execution.")
            return

    print("\n💾 Applying all accepted changes to disk...")
    apply_updates(master_files_content)
    print("✅ Spec-driven refactoring complete.")

def get_text_from_node(node_content):
    text = ""
    if isinstance(node_content, list):
        for part in node_content: text += get_text_from_node(part)
    elif isinstance(node_content, dict):
        if node_content.get('type') == 'text': text += node_content.get('text', '')
        elif node_content.get('type') == 'mention': text += node_content.get('attrs', {}).get('label', node_content.get('attrs', {}).get('id', ''))
        elif 'content' in node_content: text += get_text_from_node(node_content['content'])
    return text

def draft_and_review_living_blueprint(target_name, instruction, context_map, export_mode=False):
    """Generates a detailed, structured JSON blueprint for the refactoring task."""
    print(f"\n{Colors.BOLD}📄 Generating Living Specification for '{target_name}'...{Colors.RESET}")
    with driver.session() as session:
        existing_arch_viz = get_visual_architecture(session, context_map)

    blueprint_prompt = f"""
You are a senior architect creating a "Living Specification" in Tiptap JSON.
**INSTRUCTION:** {instruction}
**CONTEXT:** Code related to '{target_name}' has been identified. Files: {json.dumps(list(context_map.keys()))}.
Based on the instruction and context, generate a complete Tiptap JSON object.

**JSON STRUCTURE RULES:**
1.  Root is `{{"type": "doc", "content": [...]}}`.
2.  Sections MUST be: Introduction, Background, Justification, Existing Architecture, Proposed Architecture, Implementation Plan. Each is a `heading` (level 2) followed by a `paragraph`.
3.  Architecture sections must also include a `codeBlock` with `language: 'mermaid'`.
4.  **Proposed Architecture Mermaid:** You MUST define and use these classes for new/modified/removed nodes:
    ```mermaid
    classDef added fill:#9f9,stroke:#333,stroke-width:2px
    classDef modified fill:#ff9,stroke:#333,stroke-width:2px
    classDef removed fill:#f99,stroke:#333,stroke-width:2px
    ```
5.  **Implementation Plan Rules:**
    - Must contain a `taskList` with one or more `taskItem` blocks.
    - Each `taskItem` is an executable step.
    - **CRITICAL**: Each `taskItem`'s `attrs` object MUST include a `context` object. This `context` object's keys are the file paths relevant to the task, and its values are arrays of relevant function/class names.
    - Example `taskItem`:
      `{{ "type": "taskItem", "attrs": {{ "checked": false, "context": {{ "path/to/file.py": ["my_func"] }} }}, "content": [...] }}`

Now, generate the complete and valid Tiptap JSON object.
"""
    print("   🧠 Calling LLM to generate JSON blueprint...")
    response = ollama.chat(
        model=MODEL_NAME, messages=[{'role': 'system', 'content': "You are a senior architect generating a refactoring blueprint in JSON format."}, {'role': 'user', 'content': blueprint_prompt}],
        format='json', options={'temperature': 0.3}
    )
    try:
        blueprint_json = json.loads(_repair_llm_json_string(response['message']['content']))
        print(f"\n{Colors.BOLD}{Colors.CYAN}--- LIVING SPECIFICATION (JSON Blueprint) ---{Colors.RESET}")
        print(json.dumps(blueprint_json, indent=2))
        print(f"{Colors.BOLD}{Colors.CYAN}-------------------------------------------{Colors.RESET}")
        if export_mode: return 'y', blueprint_json
        while True:
            approval = input(f"\n{Colors.BOLD}Do you approve this specification? (y/n): {Colors.RESET}").lower()
            if approval in ['y', 'n']: return approval, blueprint_json
            print("Invalid input. Please enter 'y' or 'n'.")
    except (json.JSONDecodeError, Exception) as e:
        print(f"❌ Error decoding/processing blueprint: {e}\n--- RAW LLM OUTPUT ---\n{response['message']['content']}\n----------------------")
        return 'n', None

def generate_with_retries(system_prompt, user_prompt, original_files_content, provider, max_retries=MAX_RETRIES):
    """Attempts to generate a valid refactor plan with retries and self-correction."""
    current_user_content = user_prompt
    for attempt in range(max_retries):
        temp = max(0.2 - (attempt * 0.1), 0.0)
        try:
            raw_response_content = generate_code_from_agent(provider, system_prompt, current_user_content, temp, MODEL_NAME)
            response_json = json.loads(_repair_llm_json_string(raw_response_content))
            
            all_valid, errors_feedback = True, []
            if not isinstance(response_json, dict):
                all_valid = False
                errors_feedback.append(f"Response was not a JSON object, but a {type(response_json)}.")
            
            for file_path, new_content in response_json.items():
                if file_path not in original_files_content:
                    all_valid, errors_feedback.append(f"Hallucinated file '{file_path}' was not in the original context.")
                file_errors = validate_code(new_content)
                if file_errors:
                    all_valid = False
                    errors_feedback.extend([f"  - {e}" for e in file_errors])

            if all_valid:
                print(f"✅ Attempt {attempt + 1} succeeded.")
                return response_json
            else:
                print(f"❌ Attempt {attempt + 1} failed validation.")
                error_message = "\n\n--- VALIDATION FEEDBACK ---\n" + "\n".join(errors_feedback)
                current_user_content += error_message
        except Exception as e:
            print(f"❌ Attempt {attempt + 1} failed: {e}")
            current_user_content += f"\n\n--- FEEDBACK ---\nYour previous attempt failed with this error: {e}. Please correct it."
    print("🛑 Max retries reached. Failed to generate a valid refactor plan.")
    return None

def _perform_llm_refactor_step(instruction, original_files_full_content, provider, auto_confirm=False):
    """Performs a single LLM refactor step: generates, validates, reviews, and applies."""
    system_prompt = "You are a Principal Engineer. Your response MUST be a JSON object where keys are filenames and values are the NEW, complete source code for that file."
    context_str = "\n\n".join(f"--- FILE: {path} ---\n{content}" for path, content in original_files_full_content.items())
    user_prompt = f"CONTEXT:\n{context_str}\n\nINSTRUCTION:\n{instruction}"
    
    proposed_changes = generate_with_retries(system_prompt, user_prompt, original_files_full_content, provider)
    if not proposed_changes:
        print("❌ LLM failed to generate any valid changes for this step.")
        return None

    review_changes(original_files_full_content, proposed_changes)
    confirm = 'y' if auto_confirm else input(f"\n{Colors.BOLD}Apply proposed changes for this step? (y/n): {Colors.RESET}").lower()
    if confirm == 'y':
        updated_content = original_files_full_content.copy()
        updated_content.update(proposed_changes)
        print("✅ Changes accepted for this step (in-memory).")
        return updated_content
    else:
        print("🛑 Changes rejected for this step.")
        return None

def review_changes(original_files, proposed_changes):
    """Shows a 'git diff' style view in the terminal."""
    print(f"\n{Colors.BOLD}🔍 REVIEW PROPOSED CHANGES:{Colors.RESET}")
    for filename, new_content in proposed_changes.items():
        print(f"\n{Colors.CYAN}--- File: {filename} ---{Colors.RESET}")
        old_content = original_files.get(filename, "")
        diff = difflib.unified_diff(old_content.splitlines(keepends=True), new_content.splitlines(keepends=True), fromfile=f"a/{filename}", tofile=f"b/{filename}", lineterm="")
        diff_empty = True
        for line in diff:
            diff_empty = False
            color = Colors.GREEN if line.startswith('+') else Colors.RED if line.startswith('-') else Colors.BOLD if line.startswith('@@') else Colors.RESET
            print(f"{color}{line.rstrip()}{Colors.RESET}")
        if diff_empty: print(f"{Colors.BOLD}(No semantic changes detected){Colors.RESET}")

def apply_updates(file_updates):
    """Writes changes to disk."""
    print("\n💾 Applying Changes to Disk...")
    if not file_updates: print("   No file updates to apply."); return
    for file_path, new_content in file_updates.items():
        print(f"   Writing to: {file_path}")
        try:
            os.makedirs(os.path.dirname(file_path), exist_ok=True)
            with open(file_path, 'w', encoding='utf-8') as f: f.write(new_content)
        except Exception as e: print(f"   ❌ Error writing to {file_path}: {e}")

# --- Core Graph & File Functions (largely unchanged) ---
NEO4J_URI, NEO4J_AUTH = "bolt://localhost:7687", ("neo4j", "password")
MODEL_NAME = "qwen2.5-coder:14b-instruct-q4_K_M"
print("🧠 Loading Embedding Model...")
embedder = SentenceTransformer('all-MiniLM-L6-v2')
driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
PY_LANGUAGE = Language(tspython.language())
parser = Parser(PY_LANGUAGE)

def get_hybrid_context(instruction, explicit_target=None):
    query_vector = embedder.encode(instruction).tolist()
    context_map, anchors = {}, []
    with driver.session() as session:
        result = session.run("CALL db.index.vector.queryNodes('function_embeddings', 5, $embedding) YIELD node AS anchor, score WHERE score > 0.65 RETURN anchor.name, anchor.file, score", embedding=query_vector)
        for record in result:
            anchors.append(record['anchor.name'])
            file_path = record['anchor.file']
            if file_path:
                if file_path not in context_map: context_map[file_path] = []
                context_map[file_path].append(record['anchor.name'])
    if not anchors: return None, "No relevant code found."
    graph_query = "MATCH (a:Function) WHERE a.name IN $anchors OPTIONAL MATCH (c)-[:CALLS]->(a) OPTIONAL MATCH (a)-[:CALLS]->(d) RETURN a.file, c.file, c.name, d.file, d.name"
    with driver.session() as session:
        for record in session.run(graph_query, anchors=anchors):
            for f, n in [(record['c.file'], record['c.name']), (record['d.file'], record['d.name'])]:
                if f and n:
                    if f not in context_map: context_map[f] = []
                    if n not in context_map[f]: context_map[f].append(n)
    return context_map, None

def fetch_file_content(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f: return f.read()
    except (FileNotFoundError, UnicodeDecodeError): return None

def get_visual_architecture(session, context_map): return "" # Simplified for brevity

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Repo OS Refactoring Orchestrator.")
    parser.add_argument("--blueprint-export", type=str, help="Generate a Spec JSON and save it to the provided path.")
    parser.add_argument("--drive-spec", type=str, help="Read a Spec JSON from a file and drive the agent.")
    parser.add_argument("-y", "--yes", action="store_true", help="Automatically confirm all operations.")
    parser.add_argument("--local", action="store_true", help="Force all tasks to be executed by the local ollama agent.")
    args, unknown_args = parser.parse_known_args()

    if args.drive_spec:
        try:
            with open(args.drive_spec, 'r') as f: spec_json = json.load(f)
            drive_agent_from_spec(spec_json, auto_confirm=args.yes, local_only=args.local)
        except (FileNotFoundError, json.JSONDecodeError) as e:
            print(f"Error with spec file: {e}")
    elif args.blueprint_export:
        intent = " ".join(unknown_args) if unknown_args else input("Enter Refactor Intent: ")
        context_map, error = get_hybrid_context(intent)
        if error: print(f"Error gathering context: {error}"); sys.exit(1)
        
        approval, blueprint_json = draft_and_review_living_blueprint("auto", intent, context_map, export_mode=True)
        if approval == 'y' and blueprint_json:
            with open(args.blueprint_export, "w") as f: json.dump(blueprint_json, f, indent=2)
            print(f"\n{Colors.GREEN}✅ Living Specification exported to {args.blueprint_export}{Colors.RESET}")
        else:
            print(f"\n{Colors.RED}❌ Failed to generate or get approval for the Living Specification.{Colors.RESET}")
    else:
        print("Please specify either --blueprint-export or --drive-spec.")
        parser.print_help()
