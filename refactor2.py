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

def _repair_llm_json_string(malformed_json_str):
    """
    Repairs common LLM JSON output issues by removing newlines outside of
    JSON string values and escaping python's multi-line comments.
    """
    # Heuristically escape python multi-line comments.
    # This is done first as it's a common source of unescaped quotes.
    s = malformed_json_str.replace('"""', '\\"\\"\\"')
    s = s.replace("'''", "\\'\\'\\'")

    repaired = []
    in_string = False
    i = 0
    while i < len(s):
        char = s[i]

        if char == '\\':
            # It's an escape sequence, append it and the next char
            repaired.append(char)
            if i + 1 < len(s):
                repaired.append(s[i+1])
            i += 2
            continue

        if char == '"':
            in_string = not in_string
            repaired.append(char)
        elif in_string and char == '\n': # Found a literal newline inside a string
            repaired.append('\\n')
        elif in_string and char == '\r': # Found a literal carriage return inside a string
            repaired.append('\\r')
        elif not in_string and char in '\n\r':
            # Newline outside string, skip it
            pass
        else:
            repaired.append(char)
        i += 1

    return "".join(repaired)

# --- ANSI COLORS ---
class Colors:
    RED = '\033[91m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    CYAN = '\033[96m'
    RESET = '\033[0m'
    BOLD = '\033[1m'

TIPTAP_SYSTEM_PROMPT = """
You are a Principal Software Architect. Your goal is to design a concrete implementation plan.
DO NOT output conversational text.
DO NOT output Markdown.
Output ONLY a valid JSON object matching the Tiptap schema structure below.

Structure Rules:
1. Root object must be { "type": "doc", "content": [...] }
2. Use "heading" nodes for sections (Level 1: Title, Level 2: Component).
3. Use "paragraph" nodes for architectural reasoning.
4. Use "taskList" and "taskItem" nodes for actionable steps.
5. Use "codeBlock" nodes for crucial snippets (schemas, signatures).

Example Output:
{
  "type": "doc",
  "content": [
    { "type": "heading", "attrs": { "level": 1 }, "content": [{ "type": "text", "text": "Plan: OAuth Migration" }] },
    { "type": "paragraph", "content": [{ "type": "text", "text": "We will replace MD5 with Auth0." }] },
    { "type": "taskList", "content": [
        { "type": "taskItem", "attrs": { "checked": false }, "content": [{ "type": "text", "text": "[Backend] Install Auth0 SDK" }] }
      ]
    }
  ]
}
"""

def clean_json_output(response_text):
    """
    Sanitizes LLM output to extract just the JSON object.
    """
    # Remove markdown code fences if present
    response_text = re.sub(r'```json', '', response_text)
    response_text = re.sub(r'```', '', response_text)
    return response_text.strip()

def generate_blueprint_json(user_intent, context):
    """
    Generates a Tiptap-compatible JSON blueprint.
    """
    prompt = f"""
    CONTEXT:
    {context}

    USER INTENT:
    {user_intent}

    TASK:
    Create a detailed Spec-Driven Development plan for this intent.
    Break it down into:
    1. Executive Summary (Why?)
    2. Architecture Changes (What?)
    3. Step-by-Step Implementation Tasks (How?)
    """
    
    # Call your local LLM (Qwen/Llama)
    # response = llm_client.generate(system=TIPTAP_SYSTEM_PROMPT, user=prompt)
    
    # MOCK RESPONSE (For testing flow without model):
    mock_response = f"""
    {{
      "type": "doc",
      "content": [
        {{ "type": "heading", "attrs": {{ "level": 1 }}, "content": [{{ "type": "text", "text": "Refactor: {user_intent}" }}] }},
        {{ "type": "paragraph", "content": [{{ "type": "text", "text": "This spec defines the migration path." }}] }},
        {{ "type": "taskList", "content": [
            {{ "type": "taskItem", "attrs": {{ "checked": false }}, "content": [{{ "type": "text", "text": "Step 1: Audit legacy code" }}] }},
            {{ "type": "taskItem", "attrs": {{ "checked": false }}, "content": [{{ "type": "text", "text": "Step 2: Create interface adapters" }}] }}
        ]}}
      ]
    }}
    """
    
    try:
        # data = json.loads(clean_json_output(response.text)) # Real Line
        data = json.loads(clean_json_output(mock_response)) # Mock Line
        return data
    except json.JSONDecodeError:
        print("Error: AI did not generate valid JSON.")
        return None

def drive_agent_from_spec(blueprint_json):
    """
    Parses the Tiptap JSON and executes tasks from the "Implementation Plan" section.
    """
    tasks = []
    
    # 1. Find the "Implementation Plan" section
    content_blocks = blueprint_json.get('content', [])
    plan_started = False
    task_list_node = None

    for i, block in enumerate(content_blocks):
        if block.get('type') == 'heading':
            heading_text = ""
            # Ensure content exists and is a list
            if block.get('content') and isinstance(block.get('content'), list) and len(block.get('content')) > 0:
                heading_text = block.get('content', [{}])[0].get('text', '')

            if 'Implementation Plan' in heading_text:
                plan_started = True
                continue # The next block should be the taskList
        
        if plan_started:
            if block.get('type') == 'taskList':
                task_list_node = block
                break # Found the task list, no need to search further

    # 2. Walk the taskList node to find 'taskItem' nodes
    def extract_tasks_from_list(node):
        if node.get('type') == 'taskItem':
            task_text = ""
            if node.get('content'):
                for content_part in node.get('content', []):
                    if content_part.get('type') == 'text':
                        task_text += content_part.get('text', '')

            is_checked = node.get('attrs', {}).get('checked', False)
            
            if task_text and not is_checked:
                tasks.append(task_text.strip())
        
        if 'content' in node and node['content'] is not None:
            for child in node['content']:
                extract_tasks_from_list(child)

    if task_list_node:
        extract_tasks_from_list(task_list_node)
    else:
        print("Could not find a 'taskList' under the 'Implementation Plan' heading.")

    if not tasks:
        print("No actionable tasks found in the Implementation Plan.")
        return

    print(f"Found {len(tasks)} actionable tasks in Spec.")
    
    # 3. Execute with Agent (One by One)
    for i, task in enumerate(tasks):
        print(f"\n--- Executing Task {i+1}/{len(tasks)}: {task} ---")
        
        # Construct the Prompt for the Agent
        agent_prompt = f"""
        You are a coding agent working on a larger refactor.
        
        CURRENT TASK:
        {task}
        
        Adhere strictly to this task. Do not hallucinate extra scope.
        """
        
        # Call your Agent (e.g., Aider, Claude, or local function)
        # execute_agent(agent_prompt)
        print("Agent finished task.")

def extract_constraints(instruction):
    """
    Uses a small, fast prompt to identify 'Must Haves' in the user instruction.
    """
    sys_prompt = """
    You are a Technical Project Manager. 
    Extract specific function calls, libraries, or patterns the user EXPLICITLY requested.
    Output JSON: {"must_use_functions": [], "must_use_libraries": [], "architectural_notes": ""}
    """
    
    response = ollama.chat(
        model=MODEL_NAME_FOR_CONSTRAINTS,
        messages=[
            {'role': 'system', 'content': sys_prompt},
            {'role': 'user', 'content': instruction}
        ],
        format='json',
        options={'temperature': 0.0}
    )
    return json.loads(response['message']['content'])

def review_changes(original_files, proposed_changes):
    """
    Shows a 'git diff' style view in the terminal.
    """
    print(f"\n{Colors.BOLD}🔍 REVIEW PROPOSED CHANGES:{Colors.RESET}")
    
    for filename, new_content in proposed_changes.items():
        print(f"\n{Colors.CYAN}--- File: {filename} ---{Colors.RESET}")
        
        # Get old content (handle new files case)
        old_content = original_files.get(filename, "")
        old_lines = old_content.splitlines(keepends=True)
        new_lines = new_content.splitlines(keepends=True)
        
        # Generate Unified Diff
        diff = difflib.unified_diff(
            old_lines, new_lines, 
            fromfile=f"a/{filename}", 
            tofile=f"b/{filename}",
            lineterm=""
        )
        
        # Print with Color
        diff_empty = True
        for line in diff:
            diff_empty = False
            if line.startswith('+') and not line.startswith('+++'):
                print(f"{Colors.GREEN}{line.rstrip()}{Colors.RESET}")
            elif line.startswith('-') and not line.startswith('---'):
                print(f"{Colors.RED}{line.rstrip()}{Colors.RESET}")
            elif line.startswith('@@'): # Context markers
                print(f"{Colors.BOLD}{line.rstrip()}{Colors.RESET}")
            else:
                print(line.rstrip())
        
        if diff_empty:
            print(f"{Colors.BOLD}(No semantic changes detected - maybe just formatting?){Colors.RESET}")

# --- CONFIGURATION ---
NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
MODEL_NAME = "qwen2.5-coder:14b-instruct-q4_K_M"
MODEL_NAME_FOR_CONSTRAINTS = MODEL_NAME # Using the main model name for consistency
MAX_RETRIES = 3 # Max attempts for the self-healing loop

print("🧠 Loading Embedding Model...")
embedder = SentenceTransformer('all-MiniLM-L6-v2')

driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
PY_LANGUAGE = Language(tspython.language())
parser = Parser(PY_LANGUAGE)

def get_hybrid_context(instruction, explicit_target=None):
    """
    Hybrid RAG Strategy:
    1. VECTOR (Anchor): Find code semantically related to the 'instruction'.
    2. GRAPH (Traverse): Find dependencies (callers/callees) of those anchors.
    """
    print(f"📡  Hybrid RAG: Scanning Graph for intent: '{instruction[:50]}...'")
    
    # 1. Generate Embedding for the User's Instruction
    query_vector = embedder.encode(instruction).tolist()
    
    context_map = {}
    
    # 2. Vector Search (Find the "Anchors")
    # We find the top 5 functions that match the *meaning* of the prompt
    vector_query = """
    CALL db.index.vector.queryNodes('function_embeddings', 5, $embedding)
    YIELD node AS anchor, score
    WHERE score > 0.65  // Threshold to reduce noise
    RETURN anchor.name, anchor.file, score
    """
    
    anchors = []
    with driver.session() as session:
        result = session.run(vector_query, embedding=query_vector)
        for record in result:
            print(f"   ⚓ Found Anchor: {record['anchor.name']} (Score: {record['score']:.2f})")
            anchors.append(record['anchor.name'])
            
            # Add Anchor to Context Map
            file_path = record['anchor.file']
            if file_path:
                if file_path not in context_map: context_map[file_path] = []
                if record['anchor.name'] not in context_map[file_path]:
                    context_map[file_path].append(record['anchor.name'])

    # If the user gave an explicit target (e.g. "search_monolith"), add that too
    if explicit_target and explicit_target != "auto":
        anchors.append(explicit_target)

    if not anchors:
        return None, "No relevant code found for this instruction. Try being more specific."

    # 3. Graph Traversal (The "Blast Radius")
    # Now we find what these anchors touch (Callers, Callees, Tables)
    graph_query = """
    MATCH (anchor:Function)
    WHERE anchor.name IN $anchors
    
    // Find Callers (Who calls these functions? - Critical for your "update callers" request)
    OPTIONAL MATCH (caller)-[:CALLS]->(anchor)
    
    // Find Callees (What do they call?)
    OPTIONAL MATCH (anchor)-[:CALLS]->(callee)
    
    // Find Infrastructure (SQL Tables, API Endpoints they touch)
    OPTIONAL MATCH (anchor)-[:TOUCHES]->(infra)
    
    RETURN 
        anchor.file as anchor_file,
        caller.file as caller_file, caller.name as caller_name,
        callee.file as callee_file, callee.name as callee_name
    """
    
    with driver.session() as session:
        result = session.run(graph_query, anchors=anchors)
        for record in result:
            # Add Callers to Context
            if record['caller_file']:
                if record['caller_file'] not in context_map: context_map[record['caller_file']] = []
                if record['caller_name'] not in context_map[record['caller_file']]:
                    context_map[record['caller_file']].append(record['caller_name'])
                    
            # Add Callees to Context
            if record['callee_file']:
                if record['callee_file'] not in context_map: context_map[record['callee_file']] = []
                if record['callee_name'] not in context_map[record['callee_file']]:
                    context_map[record['callee_file']].append(record['callee_name'])

    return context_map, None

def fetch_mandated_tools(constraints):
    """
    If the user asked for 'db.run_raw_sql', we fetch its signature from the Graph
    and tag it as MANDATORY in the context.
    """
    tool_context = ""
    
    # 1. Look for requested functions
    for func_name in constraints.get('must_use_functions', []):
        # Handle 'module.function' format
        clean_name = func_name.split('.')[-1] 
        
        # Query Graph for this specific function
        query = """
        MATCH (f:Function {name: $name})
        RETURN f.name, f.file
        """
        with driver.session() as session:
            result = session.run(query, name=clean_name).single()
            
        if result:
            function_name = result['f.name']
            file_path = result['f.file']
            
            # Dynamically fetch the function body using get_code_snippet
            function_body, error = get_code_snippet(file_path, function_name)
            
            if function_body:
                tool_context += f"\n!!! MANDATORY TOOL !!!\n"
                tool_context += f"You MUST use the function '{function_name}' defined in '{file_path}':\n"
                # Optimization: Only show signature + docstring, not full body if too large
                tool_context += f"```python\n{function_body[:500]}...\n```\n"
            else:
                print(f"⚠️ Warning: User asked for '{func_name}' but its code could not be retrieved from '{file_path}': {error}")
        else:
            print(f"⚠️ Warning: User asked for '{func_name}' but it was not found in the Graph.")
            
    return tool_context

def fetch_file_content(file_path):
    """Reads full file content."""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            return f.read()
    except FileNotFoundError:
        return None

def get_code_snippet(file_path, item_name):
    """
    Extracts the source code for a specific function or class from a file.
    Uses tree-sitter to accurately locate the code block.
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            source_code = f.read()
    except FileNotFoundError:
        return None, f"File not found: {file_path}"
    except UnicodeDecodeError:
        return None, f"Could not decode file: {file_path}"

    tree = parser.parse(bytes(source_code, "utf8"))

    # Query for function definitions
    func_query = PY_LANGUAGE.query(f"""
    (function_definition
      name: (identifier) @name
      (#eq? @name "{item_name}")
    ) @item
    """)
    # Query for class definitions
    class_query = PY_LANGUAGE.query(f"""
    (class_definition
      name: (identifier) @name
      (#eq? @name "{item_name}")
    ) @item
    """)

    captures = func_query.captures(tree.root_node)
    if not captures:
        captures = class_query.captures(tree.root_node)

    # tree-sitter-python can return captures as a dict in some versions/conditions
    # Normalize to a list of (node, name) tuples
    flat_captures = []
    if isinstance(captures, dict):
        for name, nodes_list in captures.items():
            for node in nodes_list:
                flat_captures.append((node, name))
    else: # Assume it's already a list of (node, name) tuples
        flat_captures = captures

    if flat_captures:
        for node, name in flat_captures:
            if name == 'item':
                return source_code[node.start_byte:node.end_byte], None
    
    # Fallback for methods if item_name is 'ClassName.methodName'
    if '.' in item_name:
        class_name, method_name = item_name.split('.', 1)
        method_query = PY_LANGUAGE.query(f"""
        (class_definition
          name: (identifier) @class_name
          (#eq? @class_name "{class_name}")
          body: (block
            (function_definition
              name: (identifier) @method_name
              (#eq? @method_name "{method_name}")
            ) @item
          )
        )
        """)
        method_captures = method_query.captures(tree.root_node)
        
        flat_method_captures = []
        if isinstance(method_captures, dict):
            for name, nodes_list in method_captures.items():
                for node in nodes_list:
                    flat_method_captures.append((node, name))
        else:
            flat_method_captures = method_captures

        if flat_method_captures:
            for node, name in flat_method_captures:
                if name == 'item':
                    return source_code[node.start_byte:node.end_byte], None

    return None, f"Item '{item_name}' not found in {file_path}."

def get_code_snippet_by_name(item_name):
    """
    Finds a function/class by its name in Neo4j, then extracts its code.
    """
    query = "MATCH (n {name: $name}) RETURN n.file as file_path LIMIT 1"
    with driver.session() as session:
        result = session.run(query, name=item_name).single()
        if result and result['file_path']:
            return get_code_snippet(result['file_path'], item_name)
        else:
            # Fallback for `ClassName.methodName` format if direct match fails
            if '.' in item_name:
                # The get_code_snippet function already has logic for this
                # but we need a file path. This is a limitation if the class isn't in the graph.
                # Assuming for now the item_name is a direct function/class name.
                pass
            return None, f"Item '{item_name}' not found in the graph."

def apply_updates(file_updates):
    """
    Writes changes to disk. 
    REAL WORLD: This should create a Git Branch or a .patch file.
    MVP: Overwrites files (Dangerous but effective).
    """
    print("\n💾 Applying Changes to Disk...")
    if not file_updates:
        print("   No file updates to apply.")
        return

    for file_path, new_content in file_updates.items():
        print(f"   Writing to: {file_path}")
        try:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"   Successfully wrote to {file_path}")
        except Exception as e:
            print(f"   ❌ Error writing to {file_path}: {e}")

def compile_living_spec_to_prompts(tiptap_json):
    """
    Converts a Tiptap JSON document into a list of precise technical prompts.
    This acts as the "Spec Compiler".
    """
    prompts = []
    # Global context from paragraphs
    global_context = ""
    # Find all paragraphs and build a context string
    for block in tiptap_json.get('content', []):
        if block.get('type') == 'paragraph' and block.get('content'):
            for content_item in block.get('content', []):
                if content_item.get('type') == 'text':
                    global_context += content_item.get('text', '') + "\n"

    # Process task items to generate specific prompts
    for block in tiptap_json.get('content', []):
        if block.get('type') == 'taskItem' and block.get('content'):
            task_instruction = ""
            task_context = ""
            
            # Aggregate content within the task item
            for content_item in block.get('content', []):
                if content_item.get('type') == 'text':
                    task_instruction += content_item.get('text', '')
                elif content_item.get('type') == 'mention':
                    # This is a "Smart Reference" to a code asset
                    node_id = content_item.get('attrs', {}).get('id')
                    # Fetch fresh code from Neo4j/file system for this specific node
                    # Assuming file path is stored in the mention's attrs or can be looked up
                    # For now, we'll assume we need a lookup function.
                    # Placeholder for fetching code context
                    code_snippet, error = get_code_snippet_by_name(node_id) # This function needs to be robust
                    if code_snippet and not error:
                        task_context += f"\nREFERENCE CODE for '{node_id}':\n```\n{code_snippet}\n```\n"
                    else:
                        task_context += f"\nWARNING: Could not retrieve code for reference '{node_id}'.\n"

            # Construct the final prompt for this task
            if task_instruction:
                full_prompt = f"""
                **Global Context:**
                {global_context}
                
                **Referenced Code Snippets for this specific task:**
                {task_context}
                
                **Your Task:**
                {task_instruction}
                """
                prompts.append(full_prompt.strip())
                
    return prompts


def generate_with_retries(system_prompt, initial_user_content, original_files_full_content, max_retries=MAX_RETRIES):
    """
    Attempts to generate a valid refactor plan with retries and self-correction.
    """
    current_user_content = initial_user_content
    for attempt in range(max_retries):
        temp = 0.2 - (attempt * 0.1) # Decrease temp with each attempt
        temp = max(temp, 0.0) # Ensure temperature doesn't go below 0

        print(f"\n🧠 Attempt {attempt + 1}/{max_retries} (Temperature: {temp:.1f})...")
        # print("\n--- LLM PROMPT (User Content) ---\n", current_user_content, "\n----------------------------------\n")
        
        response = ollama.chat(
            model=MODEL_NAME,
            messages=[
                {'role': 'system', 'content': system_prompt},
                {'role': 'user', 'content': current_user_content}
            ],
            format='json',
            options={'temperature': temp}
        )
        # print("\n--- LLM RAW RESPONSE ---\n", response['message']['content'], "\n--------------------------\n")

        try:
            repaired_json_str = _repair_llm_json_string(response['message']['content'])
            response_json = json.loads(repaired_json_str)
            
            all_valid = True
            errors_feedback = []
            
            # Create a mutable copy of the original files to apply proposed changes for validation
            current_state_of_files = original_files_full_content.copy()

            if not isinstance(response_json, dict):
                all_valid = False
                errors_feedback.append(f"Your response was not a JSON object (dictionary). It was a {type(response_json)}. Please return a JSON object with filenames as keys.")

            # Apply LLM's proposed changes to the current state of files for validation
            for file_path, new_content in response_json.items():
                if file_path not in current_state_of_files:
                    errors_feedback.append(f"Proposed change for '{file_path}' which was not in the original context. This is a hallucination.")
                    all_valid = False
                    continue
                current_state_of_files[file_path] = new_content
            
            # Now validate each file that was modified
            for file_path, new_content in response_json.items():
                file_errors = validate_code(new_content)
                if file_errors:
                    all_valid = False
                    errors_feedback.append(f"Validation errors in proposed '{file_path}':")
                    errors_feedback.extend([f"  - {e}" for e in file_errors])
            
            if all_valid:
                print(f"✅ Attempt {attempt + 1} succeeded. All proposed changes are valid.")
                # Return only the files that the LLM actually modified
                return response_json
            else:
                print(f"❌ Attempt {attempt + 1} failed validation.")
                error_message_for_llm = "\n\n--- VALIDATION FEEDBACK ---\n" + "\n".join(errors_feedback) + "\n\n"
                error_message_for_llm += "Please correct these issues. Remember to output ONLY a valid JSON object with filenames as keys and the full, raw source code as values."
                
                # Append feedback to user content for the next LLM call
                current_user_content += error_message_for_llm

        except json.JSONDecodeError:
            print(f"❌ Attempt {attempt + 1} failed: AI output invalid JSON.")
            error_message_for_llm = (
                "\n\n--- VALIDATION FEEDBACK ---\n"
                "Your previous response was not a valid JSON object. "
                "You MUST output a valid JSON object where keys are filenames and values are the NEW full content of that file. "
                "Ensure strict JSON formatting. Do not include markdown code block wrappers like ```json."
            )
            current_user_content += error_message_for_llm
            
        except Exception as e:
            print(f"An unexpected error occurred during processing LLM response: {e}")
            print("Raw response content:", response['message']['content'])
            break # Exit retry loop on unexpected errors

    print("🛑 Max retries reached. Failed to generate a valid refactor plan.")
    return None

def _perform_llm_refactor_step(instruction, original_files_full_content, context_map, tool_context, auto_confirm=False):
    """
    Performs a single LLM refactor step: generates changes, validates, reviews, and applies.
    Returns updated files content or None if changes are rejected/failed.
    """
    print("🚀 Starting Refactoring Process for a step...")
    system_prompt = f"""
You are a Principal Engineer. Your primary goal is to successfully refactor the code based on the user's instruction.
Your response MUST be a JSON object where keys are filenames and values are the NEW, complete source code for that file.
You have access to the full content of all relevant files. Modify them as needed.
Ensure your changes fully address the user's instruction.

MANDATORY TOOL CONTEXT:
{tool_context}
    """
    context_str = ""
    for path, content in original_files_full_content.items():
        context_str += f"--- FILE: {path} ---\n{content}\n\n"
    
    user_prompt = f"CONTEXT:\n{context_str}\n\nINSTRUCTION:\n{instruction}"

    proposed_changes = generate_with_retries(system_prompt, user_prompt, original_files_full_content.copy())
    
    if not proposed_changes:
        print("❌ LLM failed to generate any valid changes for this step.")
        return None

    review_changes(original_files_full_content, proposed_changes)
    
    confirm = 'y' if auto_confirm else input(f"\n{Colors.BOLD}Apply proposed changes for this step? (y/n): {Colors.RESET}").lower()
    if confirm == 'y':
        # Create a new dictionary to hold the updated state
        updated_files_content = original_files_full_content.copy()
        updated_files_content.update(proposed_changes)
        print("✅ Changes accepted for this step (in-memory).")
        return updated_files_content
    else:
        print("🛑 Changes rejected for this step.")
        return None

def get_visual_architecture(session, context_map):
    """
    Queries Neo4j to build a textual visualization of the architecture
    based on the context map from get_blast_radius.
    """
    all_items = sorted(list(set(item for sublist in context_map.values() for item in sublist)))
    viz_lines = []

    for item_name in all_items:
        # Get node info
        node_result = session.run("MATCH (n {name: $name}) RETURN n.route as route", name=item_name).single()
        if not node_result:
            # Maybe it's a class or something without a file, skip for viz
            continue

        viz_lines.append(f"➕ Function: {item_name}")
        if node_result['route']:
            viz_lines.append(f"    - Route: {node_result['route']}")

        # Get outgoing CALLS relationships
        calls_result = session.run("MATCH ({name: $name})-[:CALLS]->(m) RETURN m.name as callee_name ORDER BY m.name", name=item_name)
        for record in calls_result:
            viz_lines.append(f"    ➡️ Calls: {record['callee_name']}")

        # Get outgoing CALLS_API relationships
        api_calls_result = session.run("MATCH ({name: $name})-[r:CALLS_API]->() RETURN r.endpoint as endpoint ORDER BY endpoint", name=item_name)
        for record in api_calls_result:
            endpoint = record['endpoint']
            if endpoint:
                cleaned_endpoint = re.sub(r'\{.*?\}', '', endpoint)
                viz_lines.append(f"    ⚡ Found and linked API Call: {item_name} -> {cleaned_endpoint}")

    return "\n".join(viz_lines)

def draft_and_review_living_blueprint(target_name, instruction, context_map, export_mode=False):
    """
    Generates a detailed, structured JSON blueprint for the refactoring task.
    If not in export_mode, it asks for user approval.
    """
    print(f"\n{Colors.BOLD}📄 Generating Living Specification for '{target_name}'...{Colors.RESET}")

    # --- Generate Visual Architecture ---
    with driver.session() as session:
        existing_arch_viz = get_visual_architecture(session, context_map)
    # --- END ---

    blueprint_prompt = f"""
You are a senior architect. Your task is to create a "Living Specification" for a refactoring task
in the Tiptap JSON format. You MUST follow all instructions precisely.

**INSTRUCTION:**
{instruction}

**CONTEXT:**
The user wants to refactor code related to '{target_name}'.
The following files and items have been identified as relevant:
{json.dumps(context_map, indent=2)}

Here is a textual view of the existing architecture based on the context. Use this to create the Mermaid diagrams:
```
{existing_arch_viz}
```

**YOUR TASK:**
Generate a single, valid JSON object that represents the entire specification.
The root of the object MUST be `{{"type": "doc", "content": [...]}}`.

The `content` array MUST contain the following sections in this exact order:
1.  **Introduction:** A `heading` (level 2) followed by a `paragraph`.
2.  **Background:** A `heading` (level 2) followed by a `paragraph`.
3.  **Justification:** A `heading` (level 2) followed by a `paragraph`.
4.  **Existing Architecture:** A `heading` (level 2), followed by a `paragraph` explaining the details, AND THEN a `codeBlock` with `language: 'mermaid'`.
5.  **Proposed Architecture:** A `heading` (level 2), followed by a `paragraph` explaining the details, AND THEN a `codeBlock` with `language: 'mermaid'`.
6.  **Implementation Plan:** A `heading` (level 2) followed by a `taskList` block.

**ARCHITECTURE DIAGRAM RULES:**
- You MUST generate valid Mermaid.js graph syntax.
- **Existing Architecture Diagram:** Visualize the architecture described in the context. All nodes should be default style.
- **Proposed Architecture Diagram:** Visualize the NEW state of the architecture. You MUST define and apply styles to show changes.
- At the top of the **Proposed Architecture** diagram, you MUST define these classes:
  ```mermaid
  classDef added fill:#9f9,stroke:#333,stroke-width:2px
  classDef modified fill:#ff9,stroke:#333,stroke-width:2px
  classDef removed fill:#f99,stroke:#333,stroke-width:2px
  ```
- Apply these classes to nodes that are new, modified, or removed. For example: `NewFunction:::added`, `ChangedFunc:::modified`.

**IMPLEMENTATION PLAN RULES:**
- The `taskList` must contain one or more `taskItem` blocks.
- Each `taskItem` is an executable step.
- Use `mention` nodes to reference code assets like functions or classes. The `id` of the mention MUST be the name of the asset.

Now, generate the complete Tiptap JSON object for the user's instruction, following all rules precisely.
"""

    # Call the LLM to generate the blueprint
    print("   🧠 Calling LLM to generate JSON blueprint...")
    response = ollama.chat(
        model=MODEL_NAME,
        messages=[
            {'role': 'system', 'content': "You are a senior architect generating a refactoring blueprint in JSON format."},
            {'role': 'user', 'content': blueprint_prompt}
        ],
        format='json',
        options={'temperature': 0.3}
    )

    try:
        blueprint_json_str = _repair_llm_json_string(response['message']['content'])
        blueprint_json = json.loads(blueprint_json_str)

        print(f"\n{Colors.BOLD}{Colors.CYAN}--- LIVING SPECIFICATION (JSON Blueprint) ---{Colors.RESET}")
        print(json.dumps(blueprint_json, indent=2))
        print(f"{Colors.BOLD}{Colors.CYAN}-------------------------------------------{Colors.RESET}")
        
        if export_mode:
            return 'y', blueprint_json

        while True:
            approval = input(f"\n{Colors.BOLD}Do you approve this specification? (y/n): {Colors.RESET}").lower()
            if approval in ['y', 'n']:
                return approval, blueprint_json
            print("Invalid input. Please enter 'y' or 'n'.")

    except json.JSONDecodeError as e:
        print(f"❌ Error: Failed to decode the JSON blueprint from the LLM.")
        print(f"   Error details: {e}")
        print("--- RAW LLM OUTPUT ---")
        print(response['message']['content'])
        print("----------------------")
        return 'n', None
    except Exception as e:
        print(f"❌ An unexpected error occurred: {e}")
        return 'n', None


def generate_and_review_blueprint(target_name, instruction, context_map, approval_choice=None):
    """
    Generates a detailed blueprint for the refactoring task and asks for user approval.
    """
    print(f"\n{Colors.BOLD}📄 Generating Blueprint for '{target_name}'...{Colors.RESET}")

    # --- Generate Visual Architecture ---
    existing_arch_viz = ""
    with driver.session() as session:
        existing_arch_viz = get_visual_architecture(session, context_map)
    # --- END ---

    # Construct a detailed prompt for the blueprint
    blueprint_prompt = f"""
    You are a senior architect. Based on the user's instruction and the provided context, generate a detailed blueprint for refactoring. The blueprint must contain the following sections:

    **a. Introduction:**
    Briefly describe the purpose of this refactoring.

    **b. Background:**
    Explain the context of the requested change. What is the current state of the code and why does it need to be changed?

    **c. Justification:**
    Justify the need for this refactoring. What are the benefits of the proposed changes?

    **d. Existing Architecture:**
    This is the current state of the system.
    **Visual representation of the existing system:**
    ```
    {existing_arch_viz}
    ```

    **e. Proposed Architecture:**
    Describe the new architecture after the refactoring.
    **Architectural Delta:**
    Based on the existing architecture, generate a single "Architectural Delta" diagram showing ONLY the changes.
    - Use a `+` prefix for new nodes or relationships (additions).
    - Use a `-` prefix for removed nodes or relationships (deletions).
    - Use a `~` prefix for modified nodes or relationships (modifications).
    - Unchanged items MUST be omitted for brevity.
    ```
    [GENERATE DELTA HERE]
    ```

    **f. Test Plan:**
        **i. How it will be tested by the AI:**
        Describe the steps the AI will take to test the changes.
    
    **User Instruction:**
    {instruction}

    **Affected Files and Items:**
    """
    for file_path, items in context_map.items():
        blueprint_prompt += f"- {file_path}: {', '.join(items)}\n"

    # Call the LLM to generate the blueprint
    response = ollama.chat(
        model=MODEL_NAME,
        messages=[
            {'role': 'system', 'content': "You are a senior architect generating a refactoring blueprint."},
            {'role': 'user', 'content': blueprint_prompt}
        ],
        options={'temperature': 0.3}
    )

    blueprint = response['message']['content']
    
    # --- Colorize the Architectural Delta using Regex ---
    def repl(match):
        colored_lines = []
        # The content of the code block is in match.group(1)
        for line in match.group(1).split('\n'):
            if line.strip().startswith('+'):
                colored_lines.append(f"{Colors.GREEN}{line}{Colors.RESET}")
            elif line.strip().startswith('-'):
                colored_lines.append(f"{Colors.RED}{line}{Colors.RESET}")
            elif line.strip().startswith('~'):
                colored_lines.append(f"{Colors.YELLOW}{line}{Colors.RESET}")
            else:
                colored_lines.append(line)
        return "```" + "\n".join(colored_lines) + "```"

    # Find the "Architectural Delta" header and then apply the regex to the rest of the string
    delta_header_pos = blueprint.find("**Architectural Delta:**")
    if delta_header_pos != -1:
        header_part = blueprint[:delta_header_pos]
        delta_part = blueprint[delta_header_pos:]
        # Apply the regex substitution only to the part of the blueprint after the header
        colored_delta_part = re.sub(r"```(.*?)```", repl, delta_part, count=1, flags=re.DOTALL)
        blueprint = header_part + colored_delta_part
    # --- END ---

    print(f"\n{Colors.BOLD}{Colors.CYAN}--- BLUEPRINT ---{Colors.RESET}")
    print(blueprint)
    print(f"{Colors.BOLD}{Colors.CYAN}-------------------{Colors.RESET}")

    # Ask for approval
    if approval_choice:
        return approval_choice, blueprint

    while True:
        approval = input(f"\n{Colors.BOLD}Do you approve this blueprint? (y/n/u)pdate: {Colors.RESET}").lower()
        if approval in ['y', 'n', 'u']:
            return approval, blueprint
        print("Invalid input. Please enter 'y', 'n', or 'u'.")

def orchestrate_refactor(target_name, instruction, auto_confirm=False, blueprint=False, blueprint_export=None):
    """
    The main orchestrator for the refactoring process.
    Supports three modes:
    1. Direct Refactoring: Immediately attempts to refactor.
    2. Blueprint Generation (--blueprint): Generates a textual blueprint, asks for approval, then refactors.
    3. Blueprint Export (--blueprint-export): Generates a Tiptap JSON blueprint, saves it, and exits.
    """
    # 1. COMMON SETUP: EXTRACT CONSTRAINTS & GET CONTEXT
    print("🕵️ Analyzing Instructions...")
    constraints = extract_constraints(instruction)
    tool_context = fetch_mandated_tools(constraints)

    print("🗺️ Gathering Code Context...")
    context_map, error = get_hybrid_context(instruction, explicit_target=target_name)
    if error:
        print(f"❌ {error}")
        return

    # --- WORKFLOW DECISION ---
    if blueprint_export:
        # WORKFLOW 3: EXPORT JSON BLUEPRINT
        blueprint_json = generate_blueprint_json(instruction, json.dumps(context_map, indent=2))
        if blueprint_json:
            with open(blueprint_export, "w") as f:
                json.dump(blueprint_json, f, indent=2)
            print(f"\n{Colors.GREEN}✅ Tiptap JSON blueprint exported to {blueprint_export}{Colors.RESET}")
        else:
            print(f"\n{Colors.RED}❌ Failed to generate Tiptap JSON blueprint for export.{Colors.RESET}")
        return  # Exit after exporting
    
    if blueprint:
        # WORKFLOW 2: GENERATE AND PRINT JSON BLUEPRINT
        blueprint_json = generate_blueprint_json(instruction, json.dumps(context_map, indent=2))
        if blueprint_json:
            print(json.dumps(blueprint_json, indent=2))
        else:
            print(f"\n{Colors.RED}❌ Failed to generate Tiptap JSON blueprint.{Colors.RESET}")
        return # Exit after printing

    # PROCEED WITH REFACTORING (for direct workflow)
    
    original_files_content = {
        file_path: fetch_file_content(file_path)
        for file_path in context_map.keys()
        if fetch_file_content(file_path) is not None
    }
    if not original_files_content:
        print("❌ Could not read content for any of the context files. Aborting.")
        return

    current_files_content = original_files_content.copy()

    # The logic from the old `orchestrate_sequential_refactor` and the newer `generate_with_retries`
    # are being merged here. We will use a single-shot approach for simplicity as the newer implementation does.
    
    print("🚀 Starting Refactoring Process...")
    system_prompt = f"""
You are a Principal Engineer. Your primary goal is to successfully refactor the code based on the user's instruction.
Your response MUST be a JSON object where keys are filenames and values are the NEW, complete source code for that file.
You have access to the full content of all relevant files. Modify them as needed.
Ensure your changes fully address the user's instruction.

MANDATORY TOOL CONTEXT:
{tool_context}
    """
    context_str = ""
    for path, content in original_files_full_content.items():
        context_str += f"--- FILE: {path} ---\n{content}\n\n"
    
    user_prompt = f"CONTEXT:\n{context_str}\n\nINSTRUCTION:\n{instruction}"

    # Using the robust `generate_with_retries` function for the core refactoring logic
    proposed_changes = generate_with_retries(system_prompt, user_prompt, original_files_content.copy())
    
    if not proposed_changes:
        print("❌ LLM failed to generate any valid changes.")
        return

    review_changes(original_files_content, proposed_changes)
    
    confirm = 'y' if auto_confirm else input(f"\n{Colors.BOLD}Apply all proposed changes? (y/n): {Colors.RESET}").lower()
    if confirm == 'y':
        apply_updates(proposed_changes)
        print("✅ All changes applied.")
    else:
        print("🛑 Changes rejected.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Repo OS Refactoring Orchestrator.")
    parser.add_argument("--blueprint", action="store_true", help="Generate and print a Spec JSON.")
    parser.add_argument("--blueprint-export", type=str, help="Generate a Spec JSON and save it to the provided path.")
    parser.add_argument("--drive-spec", type=str, help="Read a Spec JSON from a file and drive the agent.")
    parser.add_argument("-y", "--yes", action="store_true", help="Automatically confirm write operations in direct refactoring mode.")
    
    args, unknown_args = parser.parse_known_args()

    if args.drive_spec:
        try:
            with open(args.drive_spec, 'r') as f:
                spec_json = json.load(f)
            drive_agent_from_spec(spec_json)
        except FileNotFoundError:
            print(f"Error: Spec file not found at {args.drive_spec}")
        except json.JSONDecodeError:
            print(f"Error: Could not decode JSON from {args.drive_spec}")
    elif args.blueprint or args.blueprint_export:
        instruction_parts = [part for part in unknown_args if part not in (str(args.blueprint), str(args.blueprint_export))]

        if instruction_parts:
            intent = " ".join(instruction_parts)
            print(f"Received Intent: {intent}")
        else:
            intent = input("Enter Refactor Intent: ")

        # For blueprint generation, we use a generic target name and let the context gathering find it.
        target_name = 'auto' 
        context_map, error = get_hybrid_context(intent, explicit_target=target_name)

        if error:
            print(f"Error gathering context: {error}")
        else:
            # Determine if we are in export mode (non-interactive)
            is_export_mode = args.blueprint_export is not None
            
            # Call the real blueprint generation function
            approval, blueprint_json = draft_and_review_living_blueprint(
                target_name, intent, context_map, export_mode=is_export_mode
            )

            if approval == 'y' and blueprint_json:
                if args.blueprint_export:
                    with open(args.blueprint_export, "w") as f:
                        json.dump(blueprint_json, f, indent=2)
                    print(f"\n{Colors.GREEN}✅ Living Specification exported to {args.blueprint_export}{Colors.RESET}")
                else:
                    # The blueprint is already printed to the console by the function
                    print(f"\n{Colors.GREEN}✅ Living Specification generated.{Colors.RESET}")
            elif not blueprint_json:
                 print(f"\n{Colors.RED}❌ Failed to generate a valid Living Specification.{Colors.RESET}")
            else: # Approval was 'n'
                print("\n🛑 Blueprint rejected by user. Aborting.")
    else:
        # Fallback to original refactoring behavior
        # We need to re-parse the other arguments.
        if len(unknown_args) >= 2:
            target_name = unknown_args[0]
            instruction = " ".join(unknown_args[1:])
            orchestrate_refactor(target_name, instruction, args.yes)
        else:
            print("For direct refactoring, please provide a target name and an instruction.")
            parser.print_help()
