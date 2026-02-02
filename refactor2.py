import os
import sys
import json
import ollama
import tree_sitter_python as tspython
from tree_sitter import Language, Parser
from neo4j import GraphDatabase

# --- CONFIGURATION ---
NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
MODEL_NAME = "qwen2.5-coder:14b-instruct-q4_K_M"

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

def apply_updates(file_updates):
    """
    Writes changes to disk. 
    REAL WORLD: This should create a Git Branch or a .patch file.
    MVP: Overwrites files (Dangerous but effective).
    """
    print("\n💾 Applying Changes to Disk...")
    for file_path, new_content in file_updates.items():
        print(f"   Writing: {file_path}")
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_content)

def orchestrate_refactor(target_name, instruction):
    # 1. Get the Blast Radius
    files_to_context, error = get_blast_radius(target_name)
    if error:
        print(f"❌ {error}")
        return

    # 2. Build the "Mega-Prompt"
    # We feed the LLM the FULL content of relevant files.
    # Note: For 14B model, we must be careful with context size.
    # If files are huge, we'd need to only extract relevant functions.
    
    system_prompt = """
    You are the Repo OS Kernel. You are an expert AI Engineer.
    You are Refactoring a specific part of the system.
    
    RULES:
    1. You will receive multiple files.
    2. You must output a JSON object where keys are filenames and values are the NEW full content of that file.
    3. If a file needs no changes, do not include it in the JSON.
    4. Ensure all function calls match new signatures across files.
    """
    
    user_content = f"Instruction: {instruction}\n\n=== CODEBASE ===\n"
    
    original_files = {} # Keep backup
    
    for file_path, relevant_items in files_to_context.items():
        content = fetch_file_content(file_path)
        if content:
            original_files[file_path] = content
            user_content += f"\n--- FILE: {file_path} ---\n{content}\n"
            user_content += f"Relevant Items in this file: {', '.join(relevant_items)}\n"

    # 3. The Inference
    print(f"🧠 Reasoning across {len(original_files)} files...")
    
    response = ollama.chat(
        model=MODEL_NAME,
        messages=[
            {'role': 'system', 'content': system_prompt},
            {'role': 'user', 'content': user_content}
        ],
        format='json', # Force JSON output for easier parsing
        options={'temperature': 0.2} # Low temp for precision
    )

    # 4. Parse and Apply
    try:
        response_json = json.loads(response['message']['content'])
        
        print("\n--- PROPOSED PLAN ---")
        for f, content in response_json.items():
            print(f"📝 Modifying: {f}")
            
        confirm = input("\nProceed with write? (y/n): ")
        if confirm.lower() == 'y':
            apply_updates(response_json)
            print("✅ Refactor Complete.")
        else:
            print("🛑 Aborted.")
            
    except json.JSONDecodeError:
        print("❌ AI output invalid JSON. Raw output:")
        print(response['message']['content'])
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        print("Raw response content:", response['message']['content'])


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python refactor2.py <target_name> \"<instruction>\"")
    else:
        orchestrate_refactor(sys.argv[1], " ".join(sys.argv[2:]))