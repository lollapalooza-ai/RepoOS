import os
import sys
import tree_sitter_python as tspython
from tree_sitter import Language, Parser
from neo4j import GraphDatabase

# --- CONFIGURATION ---
# Initialize the "Right Brain" (Parser)
PY_LANGUAGE = Language(tspython.language())
parser = Parser(PY_LANGUAGE)

# Initialize the "Left Brain" (Graph DB)
driver = GraphDatabase.driver("neo4j://localhost:7687", auth=("neo4j", "password"))

# --- THE QUERY ENGINE ---
# This is a Tree-Sitter S-Expression. It asks the parser:
# "Find me every function definition, and capture its name."
FUNC_QUERY = PY_LANGUAGE.query("""
(function_definition
  name: (identifier) @func.name
  body: (block) @func.body
) @func.def
""")

# This query looks INSIDE a function body for calls.
# "Find me a call expression where the function being called is a simple name."
CALL_QUERY = PY_LANGUAGE.query("""
(call
  function: (identifier) @call.name
) @call
""")

def ingest_file_with_deps(file_path):
    print(f"Processing {file_path}...")
    
    with open(file_path, 'r') as f:
        source_code = f.read()
    
    tree = parser.parse(bytes(source_code, "utf8"))
    root_node = tree.root_node

    # 1. Execute the Query to find all functions in the file
    captures = FUNC_QUERY.captures(root_node)

    # FIX: Handle API difference between tree-sitter versions
    if isinstance(captures, dict):
        # New API (0.22+): captures is dict[str, list[Node]]
        # Flatten to list of (node, name) to match your existing logic
        flat_captures = []
        for name, nodes in captures.items():
            for node in nodes:
                flat_captures.append((node, name))
        captures = flat_captures
    
    # We need to group captures by function definition. 
    # The 'captures' output is a flat list, so we iterate carefully.
    
    # Simple strategy: Iterate specifically over function definition nodes
    for node, name in captures:
        if name == 'func.name': 
            caller_name = source_code[node.start_byte:node.end_byte]
            
            # A. Create the "Caller" Node
            write_function_node(caller_name, file_path)
            
            # Get the body of this function to look for calls
            # We assume the parent of the name identifier is the function_definition
            func_def_node = node.parent 
            
            # B. Look for "Callees" inside this function
            call_captures = CALL_QUERY.captures(func_def_node)

            # FIX: Apply the same normalization for the inner query
            if isinstance(call_captures, dict):
                flat_calls = []
                for c_name, c_nodes in call_captures.items():
                    for c_node in c_nodes:
                        flat_calls.append((c_node, c_name))
                call_captures = flat_calls

            for call_node, call_tag in call_captures:
                callee_name = source_code[call_node.start_byte:call_node.end_byte]
                
                # Filter out built-ins (print, len) to keep the graph clean? 
                # For MVP, let's keep everything or filter explicitly.
                if callee_name not in ['print', 'len', 'str', 'int']:
                    # C. Create the Relationship
                    create_dependency(caller_name, callee_name)

def write_function_node(func_name, file_name):
    """Ensures the function node exists in the graph."""
    query = """
    MERGE (f:Function {name: $name})
    ON CREATE SET f.file = $file, f.type = 'def'
    """
    with driver.session() as session:
        session.run(query, name=func_name, file=file_name)

def create_dependency(caller, callee):
    """Creates the arrow: (Caller) -> (Callee)"""
    # Note: We MERGE the callee too. 
    # If 'callee' hasn't been scanned yet, we create a placeholder node for it.
    query = """
    MATCH (a:Function {name: $caller})
    MERGE (b:Function {name: $callee})
    MERGE (a)-[:CALLS]->(b)
    """
    with driver.session() as session:
        session.run(query, caller=caller, callee=callee)
        print(f"   └── Link: {caller} -> {callee}")

if __name__ == "__main__":
    try:
        ingest_file_with_deps("test.py")
    finally:
        driver.close()
        sys.exit(0)