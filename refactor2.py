import os
import sys
import ollama
import tree_sitter_python as tspython
from tree_sitter import Language, Parser
from neo4j import GraphDatabase

# --- CONFIGURATION ---
# The "Brain" constraints
NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
# Your Mac's specialized coder
MODEL_NAME = "qwen2.5-coder:14b-instruct-q4_K_M" 

# --- INITIALIZATION ---
try:
    # Setup the "Right Brain" (Parser)
    PY_LANGUAGE = Language(tspython.language())
    parser = Parser(PY_LANGUAGE)
    
    # Setup the "Left Brain" (Graph DB)
    driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
except Exception as e:
    print(f"❌ Initialization Failed: {e}")
    sys.exit(1)

# --- CORE LOGIC ---

def fetch_function_source(file_path, func_name):
    """
    Reads the file from disk and finds the function FRESH.
    This solves the 'Index Drift' problem where line numbers in DB might be stale.
    """
    if not os.path.exists(file_path):
        return None, f"File not found: {file_path}"

    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            code = f.read()
    except UnicodeDecodeError:
        return None, f"Could not decode file: {file_path}"

    # Fast Re-parse (On M4, this takes milliseconds)
    tree = parser.parse(bytes(code, "utf8"))
    
    # Tree-Sitter Query to find the specific function definition
    # This searches the structure, not just string matching
    query = PY_LANGUAGE.query(f"""
    (function_definition
      name: (identifier) @name
      (#eq? @name "{func_name}")
    ) @def
    """)
    
    captures = query.captures(tree.root_node)
    
    # FIX: Handle API difference between tree-sitter versions
    if isinstance(captures, dict):
        flat_captures = []
        for name, nodes in captures.items():
            for node in nodes:
                flat_captures.append((node, name))
        captures = flat_captures
    
    for node, name in captures:
        if name == 'def':
            # We found the function node! Return the text.
            return code[node.start_byte:node.end_byte], None
        
    return None, f"Function '{func_name}' not found in {file_path} (Has it been renamed?)"

def get_context_from_graph(target_func_name):
    """
    1. Ask Neo4j for the File Path and Dependency Names.
    2. Read the actual code from Disk.
    """
    print(f"🔍 Querying Graph for '{target_func_name}' metadata...")
    
    # Cypher: Only get metadata (file path), not the body
    query = """
    MATCH (t:Function {name: $name})
    OPTIONAL MATCH (t)-[:CALLS]->(d:Function)
    RETURN 
        t.file as file_path, 
        collect({name: d.name, file: d.file}) as dependencies
    """
    
    with driver.session() as session:
        result = session.run(query, name=target_func_name).single()
        
    if not result:
        return None, "Function not found in Graph index."

    target_path = result["file_path"]
    dependencies = result["dependencies"]

    if not target_path:
        return None, "Graph node exists but has no file path (Corrupted ingestion?)."

    # --- HYBRID FETCH ---
    print(f"📂 Reading '{target_func_name}' from disk: {target_path}...")
    
    # 1. Get Target Code (Fresh from disk)
    target_code, error = fetch_function_source(target_path, target_func_name)
    if error:
        return None, error

    # 2. Get Dependency Signatures (Fresh from disk)
    # This prevents hallucinating APIs if they changed recently
    dep_context_str = ""
    if dependencies:
        print(f"🔗 Resolving {len(dependencies)} dependencies...")
        dep_context_str = "\n\nDependencies (Available APIs):\n"
        for dep in dependencies:
            d_name = dep.get('name')
            d_file = dep.get('file')
            
            if d_name and d_file:
                d_code, _ = fetch_function_source(d_file, d_name)
                if d_code:
                    # OPTIMIZATION: Just grab the first line (def name(...):)
                    # This saves context window tokens while giving the LLM the signature.
                    signature = d_code.split('\n')[0] 
                    dep_context_str += f"- {signature} # from {os.path.basename(d_file)}\n"
                else:
                    # Fallback if we can't parse the dependency
                    dep_context_str += f"- def {d_name}(...): # Source unavailable\n"
    
    final_context = f"TARGET CODE:\n```python\n{target_code}\n```\n{dep_context_str}"
    return final_context, None

def generate_refactor_proposal(func_name, instruction):
    # 1. Build the Context
    context_str, error = get_context_from_graph(func_name)
    
    if error:
        print(f"❌ Error: {error}")
        return

    # 2. Construct the Prompt
    full_prompt = f"""
    You are a Senior Python Engineer. Refactor the code below based on the instruction.
    
    CONTEXT:
    {context_str}
    
    INSTRUCTION:
    {instruction}
    
    RULES:
    1. Output ONLY the refactored code for '{func_name}'.
    2. Do not include markdown '```python' wrappers unless necessary.
    3. Use the provided dependencies correctly.
    """

    # 3. Call the "Right Brain" (LLM)
    print(f"🧠 Reasoning with {MODEL_NAME}...")
    
    # Streaming response for better UX (feels faster on M4)
    stream = ollama.chat(
        model=MODEL_NAME, 
        messages=[{'role': 'user', 'content': full_prompt}],
        stream=True
    )

    print("\n" + "="*40)
    print("      PROPOSED REFACTOR")
    print("="*40 + "\n")
    
    full_response = ""
    for chunk in stream:
        content = chunk['message']['content']
        print(content, end='', flush=True)
        full_response += content
        
    print("\n\n" + "="*40)
    return full_response

# --- CLI ENTRY POINT ---
if __name__ == "__main__":
    # if len(sys.argv) < 3:
    #     print("Usage: python refactor.py <function_name> <instruction>")
    #     print('Example: python refactor.py process_payment "Add error handling"')
    # else:
    #     fn_name = sys.argv[1]
    #     instr = " ".join(sys.argv[2:])
    #     generate_refactor_proposal(fn_name, instr)
    generate_refactor_proposal("process_payment", "Add error handling")