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

def generate_with_retries(system_prompt, initial_user_content, original_files_full_content, max_retries=MAX_RETRIES):
    """
    Attempts to generate a valid refactor plan with retries and self-correction.
    """
    current_user_content = initial_user_content
    for attempt in range(max_retries):
        temp = 0.2 - (attempt * 0.1) # Decrease temp with each attempt
        temp = max(temp, 0.0) # Ensure temperature doesn't go below 0

        print(f"\n🧠 Attempt {attempt + 1}/{max_retries} (Temperature: {temp:.1f})...")
        print("\n--- LLM PROMPT (User Content) ---\n", current_user_content, "\n----------------------------------\n")
        
        response = ollama.chat(
            model=MODEL_NAME,
            messages=[
                {'role': 'system', 'content': system_prompt},
                {'role': 'user', 'content': current_user_content}
            ],
            format='json',
            options={'temperature': temp}
        )
        print("\n--- LLM RAW RESPONSE ---\n", response['message']['content'], "\n--------------------------\n")

        try:
            response_json = json.loads(response['message']['content'])
            
            all_valid = True
            errors_feedback = []
            
            # Create a mutable copy of the original files to apply proposed changes for validation
            current_state_of_files = original_files_full_content.copy()

            # Apply LLM's proposed changes to the current state of files for validation
            for file_path, new_content in response_json.items():
                if file_path not in current_state_of_files:
                    errors_feedback.append(f"Proposed change for '{file_path}' which was not in the original context. This is a hallucination.")
                    all_valid = False
                    continue
                current_state_of_files[file_path] = new_content
            
            # Now validate each file that was part of the original context (whether modified or not)
            for file_path, content_to_validate in current_state_of_files.items():
                file_errors = validate_code(content_to_validate)
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
                error_message_for_llm += "Please correct these issues. Remember to output ONLY a valid JSON object. Ensure that the JSON values contain raw code, not markdown wrappers."
                
                # Append feedback to user content for the next LLM call
                current_user_content += error_message_for_llm

        except json.JSONDecodeError:
            print(f"❌ Attempt {attempt + 1} failed: AI output invalid JSON.")
            error_message_for_llm = (
                "\n\n--- VALIDATION FEEDBACK ---\n"
                "Your previous response was not a valid JSON object. "
                "You MUST output a valid JSON object where keys are filenames and values are the NEW full content of that file. "
                "Ensure strict JSON formatting."
            )
            current_user_content += error_message_for_llm
            
        except Exception as e:
            print(f"An unexpected error occurred during processing LLM response: {e}")
            print("Raw response content:", response['message']['content'])
            break # Exit retry loop on unexpected errors

    print("🛑 Max retries reached. Failed to generate a valid refactor plan.")
    return None

def _parse_and_validate_response(response, filename, attempt):
    """
    Parses the JSON response from the LLM, validates the code, and returns the new code if valid.
    """
    try:
        raw_llm_response_content = response['message']['content'].strip()
        # Attempt to strip markdown code block wrappers
        if raw_llm_response_content.startswith("```json"):
            raw_llm_response_content = raw_llm_response_content[len("```json"):].strip()
            if raw_llm_response_content.endswith("```"):
                raw_llm_response_content = raw_llm_response_content[:-len("```")].strip()
        elif raw_llm_response_content.startswith("```"): # Generic markdown
            raw_llm_response_content = raw_llm_response_content[len("```"):].strip()
            if raw_llm_response_content.endswith("```"):
                raw_llm_response_content = raw_llm_response_content[:-len("```")].strip()
        # response['message']['content'] = response['message']['content'].replace("```json\n?|```/g, ''")

        # Attempt to repair common LLM JSON errors before parsing
        repaired_llm_response_content = _repair_llm_json_string(raw_llm_response_content)

        response_json = json.loads(repaired_llm_response_content)
        plan_report = response_json.get('plan_report', 'No report generated.')
        file_changes = response_json.get('file_changes', {})

        new_code = file_changes.get(filename)
        
        if new_code:
            errors = validate_code(new_code)
            if not errors:
                print(f"   ✅ Finished: {filename}")
                print(f"   📋 Plan Report for {filename}: {plan_report}")
                return new_code
            else:
                print(f"   ⚠️ Syntax Error (Attempt {attempt+1}): {errors}")
                # In a real app, you'd feed the error back to the LLM here
        else:
            print(f"   ❌ No changes returned for {filename} in file_changes (Attempt {attempt+1}).")

    except json.JSONDecodeError:
        print(f"   ❌ Attempt {attempt + 1} failed: AI output invalid JSON.")
        print(f"   Raw LLM Response (Attempt {attempt + 1}):\n{response['message']['content']}")
        # For self-correction, append feedback to the next user message,
        # but for this retry loop, we just log and continue.
    except Exception as e:
        print(f"   An unexpected error occurred during processing LLM response (Attempt {attempt+1}): {e}")
    
    return None

def process_single_file_sync(filename, file_content, instruction, dependencies, constraints, tool_context):
    """
    Synchronous Worker. Refactors ONE file and returns the result.
    """
    print(f"\n🚀 Starting Task: {filename}")

    constraint_str = ""
    if constraints.get('must_use_functions'):
        constraint_str += f"MANDATORY: You must implement the solution using: {', '.join(constraints['must_use_functions'])}. "
    if constraints.get('must_use_libraries'):
        constraint_str += f"MANDATORY: You must use the following libraries: {', '.join(constraints['must_use_libraries'])}."
    if constraints.get('architectural_notes'):
        constraint_str += f"ARCHITECTURAL NOTE: {constraints['architectural_notes']}."

    system_prompt = f"""
    You are a Principal Engineer. Refactor the code for {filename}.

    CRITICAL RULES:
    {constraint_str} (These are hard constraints. You will be penalized for ignoring them.)
    Output a JSON object with TWO fields:
       - "plan_report": A brief explanation of how you satisfied the specific constraints for {filename}.
       - "file_changes": A dictionary with one entry: {{"{filename}": "new_code_for_{filename}"}}.

    Example Output:
    {{
      "plan_report": "I fixed the SQL injection in {filename} by using db.run_raw_sql as requested.",
      "file_changes": {{ "{filename}": "..." }}
    }}

    Context for mandatory tools:
    {tool_context}

    Additional context from dependent files:
    {dependencies}
    """
    
    # Retry Loop (Self-Correction)
    for attempt in range(3):
        # We use standard synchronous chat here
        response = ollama.chat(
            model=MODEL_NAME,
            messages=[
                {'role': 'system', 'content': system_prompt},
                {'role': 'user', 'content': f"CODE for {filename}:\n{file_content}\n\nINSTRUCTION:\n{instruction}"}
            ],
            options={'temperature': 0.1} # Low temp for precision
        )
        
        new_code = _parse_and_validate_response(response, filename, attempt + 1)
        if new_code:
            return new_code

    print(f"   ❌ Failed to refactor {filename} after 3 attempts.")
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
            viz_lines.append(f"    ⚡ Found and linked API Call: {item_name} -> {record['endpoint']}")

    return "\n".join(viz_lines)

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

def orchestrate_sequential_refactor(target_name, instruction, auto_confirm=False, blueprint=False, blueprint_approval=None):
    """
    The Sequential Manager.
    1. Analyze dependencies.
    2. Sort tasks (Critical dependencies first).
    3. Execute one by one.
    """
    # 1. EXTRACT CONSTRAINTS
    print("🕵️ Analyzing Instructions...")
    constraints = extract_constraints(instruction)
    
    if constraints.get('must_use_functions'):
        print(f"🔒 Constraints Detected: Must use functions: {constraints['must_use_functions']}")
    if constraints.get('must_use_libraries'):
        print(f"🔒 Constraints Detected: Must use libraries: {constraints['must_use_libraries']}")
    if constraints.get('architectural_notes'):
        print(f"🔒 Constraints Detected: Architectural notes: {constraints['architectural_notes']}")

    # 2. Get the Blast Radius
    files_to_context, error = get_hybrid_context(instruction, explicit_target=target_name)
    if error:
        print(f"❌ {error}")
        return

    # Generate and review blueprint if requested
    if blueprint:
        approval, generated_blueprint = generate_and_review_blueprint(target_name, instruction, files_to_context, blueprint_approval)
        if approval == 'n':
            print("🛑 Blueprint rejected. Aborting refactoring.")
            return
        elif approval == 'u':
            new_instruction = input("Please provide the updated instruction: ")
            approval, generated_blueprint = generate_and_review_blueprint(target_name, new_instruction, files_to_context, blueprint_approval)
            if approval != 'y':
                print("🛑 Blueprint update rejected or aborted. Aborting refactoring.")
                return
            instruction = new_instruction

    # 2. FETCH MANDATORY TOOL CONTEXT
    tool_context = fetch_mandated_tools(constraints)

    # 3. Load initial file contents
    original_files_full_content = {} 
    for file_path in files_to_context.keys():
        full_content = fetch_file_content(file_path)
        if full_content:
            original_files_full_content[file_path] = full_content
        else:
            print(f"⚠️ Warning: Could not read full content for {file_path}. Skipping.")

    # 3. Topological Sort (Optional but Smart)
    # Ideally, you want to refactor the 'Dependency' (utils.py) before the 'Dependent' (main.py)
    # For MVP, we'll just process them in the order provided or simple alphabetical
    sorted_files = sorted(original_files_full_content.keys()) 
    
    print(f"📋 Sequential Plan: {sorted_files}")
    
    applied_files_content = {} # To store content of files already processed and applied

    for filename in sorted_files:
        content = original_files_full_content[filename]

        # 4. Dynamic Context Building
        # The 'dependencies' context could essentially be the *new* code of files we just finished!
        # This allows 'main.py' to see the *updated* 'utils.py' immediately.
        current_context_str = "Recently Updated Files:\n"
        for finished_file, new_content_for_context in applied_files_content.items():
            current_context_str += f"- {finished_file} (Refactored)\n"

        # 5. Execute
        new_code = process_single_file_sync(filename, content, instruction, current_context_str, constraints, tool_context)

        if new_code:
            print(f"\n--- PROPOSED CHANGE FOR: {filename} ---")
            
            # Create a temporary dict for review_changes to show only this file's change
            single_file_original = {filename: original_files_full_content[filename]}
            single_file_proposed = {filename: new_code}

            if not auto_confirm:
                review_changes(single_file_original, single_file_proposed)

            should_apply = auto_confirm
            if not auto_confirm:
                confirm = input(f"\n{Colors.BOLD}Apply changes to {filename}? (y/n): {Colors.RESET}")
                if confirm.lower().strip() == 'y':
                    should_apply = True
                else:
                    should_apply = False
                    print(f"🛑 Aborted changes for {filename}. Moving to next file.")

            if should_apply:
                apply_updates(single_file_proposed) # Apply only the current file's change
                applied_files_content[filename] = new_code # Add to applied for context in next iteration
                print(f"✅ Changes for {filename} applied.")
                # Simulate a brief cooldown if needed for thermal management
                time.sleep(0.5) 
            else:
                # If not applied, the original content persists for subsequent context if needed,
                # but for simplicity, we just won't add it to applied_files_content.
                pass # Already printed "Aborted"

        else:
            print(f"❌ Failed to refactor {filename}. Aborting sequential refactoring.")
            return # Exit the function immediately

    print("\n--- SEQUENTIAL REFACTORING PROCESS COMPLETE ---")
        
if __name__ == "__main__":
    arg_parser = argparse.ArgumentParser(description="Repo OS Sequential Refactoring Orchestrator.")
    arg_parser.add_argument("target_name", help="The fully qualified name of the function or class to refactor (e.g., Car.start).")
    arg_parser.add_argument("instruction", nargs='+', help="The refactoring instruction for the AI (e.g., 'Rename to ignite_engine').")
    arg_parser.add_argument("-y", "--yes", action="store_true", help="Automatically confirm the write operation.")
    arg_parser.add_argument("--blueprint", action="store_true", help="Generate a blueprint of the changes and ask for approval before applying them.")
    arg_parser.add_argument("--blueprint-approval", choices=['y', 'n', 'u'], help="Approve the blueprint automatically.")

    args = arg_parser.parse_args()
    orchestrate_sequential_refactor(args.target_name, " ".join(args.instruction), args.yes, args.blueprint, args.blueprint_approval)
