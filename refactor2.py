import argparse # Import argparse
import os
import sys
import json
import ollama
import tree_sitter_python as tspython
from tree_sitter import Language, Parser
from neo4j import GraphDatabase
from validator import validate_code # Import the validator

# --- CONFIGURATION ---
NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
MODEL_NAME = "qwen2.5-coder:14b-instruct-q4_K_M"
MAX_RETRIES = 3 # Max attempts for the self-healing loop

driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
PY_LANGUAGE = Language(tspython.language())
parser = Parser(PY_LANGUAGE)

def get_blast_radius(target_name):
    """
    Fetches the 'Center' node and everything connected to it using a more
    sophisticated graph traversal query.
    """
    print(f"📡 Calculating Blast Radius for '{target_name}'...")

    # This query is more sophisticated. It finds:
    # 1. The target itself.
    # 2. Upstream callers.
    # 3. The parent class of the target method.
    # 4. All subclasses of the parent class (to find overriding methods).
    # 5. Downstream callees for context.
    query = """
    MATCH (target {name: $name})

    // Find direct callers of the target
    OPTIONAL MATCH (caller)-[:CALLS]->(target)

    // Find the parent class and any subclasses
    OPTIONAL MATCH (parent_class)-[:HAS_METHOD]->(target)
    OPTIONAL MATCH (subclass)-[:IMPLEMENTS*]->(parent_class)

    // Find downstream dependencies for context
    OPTIONAL MATCH (target)-[:CALLS]->(downstream)

    // Collect all unique nodes that have a file path
    WITH collect(DISTINCT target) + collect(DISTINCT caller) + collect(DISTINCT subclass) + collect(DISTINCT downstream) as nodes
    UNWIND nodes as n
    WITH n WHERE n.file IS NOT NULL
    RETURN n.file as file_path, collect(DISTINCT n.name) as relevant_items
    """
    
    context_map = {}
    with driver.session() as session:
        result = session.run(query, name=target_name)
        for record in result:
            file_path = record["file_path"]
            items = record["relevant_items"]
            if file_path not in context_map:
                context_map[file_path] = []
            for item in items:
                if item not in context_map[file_path]:
                    context_map[file_path].append(item)
        
    if not context_map:
        return None, "Target not found or has no file associations in Graph."
        
    return context_map, None

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

def orchestrate_refactor(target_name, instruction, auto_confirm=False):
    # 1. Get the Blast Radius
    files_to_context, error = get_blast_radius(target_name)
    if error:
        print(f"❌ {error}")
        return

    # 2. Build the "Mega-Prompt" with full file content
    system_prompt = """
    You are the Repo OS Kernel. You are an expert AI Engineer.
    You are Refactoring a specific part of the system.
    
    RULES:
    1. You will receive the FULL content of multiple files.
    2. You must output a JSON object where keys are filenames and values are the NEW *full content* of that file.
    3. If a file needs no changes, you MUST return its original full content in the JSON.
    4. Ensure all function calls match new signatures across files.
    5. The values in the JSON object (the file contents) MUST be raw code, not wrapped in markdown code blocks (e.g., DO NOT use ```python ... ``` within the JSON values).
    6. ONLY output the JSON object. Do not include any other text or markdown outside the JSON.
    """
    
    initial_user_content = f"Instruction: {instruction}\n\n=== CODEBASE FILES ===\n"
    
    # Store full original file contents for validation and rewrite
    original_files_full_content = {} 
    
    for file_path, relevant_items in files_to_context.items():
        full_content = fetch_file_content(file_path)
        if full_content:
            original_files_full_content[file_path] = full_content
            initial_user_content += f"\n--- FILE: {file_path} ---\n{full_content}\n"
            # Highlight relevant items for the LLM within the full file context
            initial_user_content += f"--- Relevant Items in {os.path.basename(file_path)}: {', '.join(relevant_items)} ---\n"
        else:
            print(f"⚠️ Warning: Could not read full content for {file_path}. Skipping.")


    # 3. ENTER THE SELF-HEALING LOOP
    final_plan = generate_with_retries(system_prompt, initial_user_content, original_files_full_content)

    # 4. Apply
    if final_plan:
        print("\n--- FINAL VALIDATED PLAN ---")
        for f in final_plan:
            print(f"📝 Modifying: {f}")
        
        confirm = input("\nProceed with write? (y/n): ")
        if confirm.lower() == 'y':
            apply_updates(final_plan)
            print("✅ Refactor Complete.")
        else:
            print("🛑 Aborted.")
    else:
        print("❌ Refactor process failed after multiple attempts.")
        
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Repo OS Refactoring Orchestrator.")
    parser.add_argument("target_name", help="The fully qualified name of the function or class to refactor (e.g., Car.start).")
    parser.add_argument("instruction", nargs='+', help="The refactoring instruction for the AI (e.g., 'Rename to ignite_engine').")
    parser.add_argument("-y", "--yes", action="store_true", help="Automatically confirm the write operation.")

    args = parser.parse_args()

    orchestrate_refactor(args.target_name, " ".join(args.instruction), args.yes)