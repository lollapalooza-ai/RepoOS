import os
import tree_sitter_python as tspython
from tree_sitter import Language, Parser
from neo4j import GraphDatabase

# --- Configuration ---
NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
TARGET_DIR = "./legacy_shop" # Generic target

# --- Setup ---
PY_LANGUAGE = Language(tspython.language())
parser = Parser(PY_LANGUAGE)
driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)

def process_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        source_code = f.read()
    
    tree = parser.parse(bytes(source_code, "utf8"))
    
    # Queries to extract structural logic
    func_query = PY_LANGUAGE.query("(function_definition name: (identifier) @func.name)")
    call_query = PY_LANGUAGE.query("(call function: (identifier) @call.name)")
    
    with driver.session() as session:
        # 1. Register File
        session.run("MERGE (file:File {path: $path})", path=file_path)
        
        # 2. Register Functions & Code Snippets
        # Adjust for tree-sitter 0.23.2 dictionary return
        func_captures = func_query.captures(tree.root_node)
        for capture_name, nodes in func_captures.items():
            if capture_name == "func.name":
                for node in nodes:
                    func_name = node.text.decode('utf8')
                    # Extract the exact byte-range of the function body
                    # In tree-sitter, the function_definition is the parent of the name identifier
                    func_node = node.parent
                    func_body = source_code[func_node.start_byte:func_node.end_byte]
                    
                    session.run("""
                        MATCH (file:File {path: $path})
                        MERGE (f:Function {name: $name, file: $path})
                        SET f.code = $code
                        MERGE (file)-[:CONTAINS]->(f)
                    """, name=func_name, path=file_path, code=func_body)
                
        # 3. Register 'CALLS' Relationships (Dependency Graph)
        call_captures = call_query.captures(tree.root_node)
        for capture_name, nodes in call_captures.items():
            if capture_name == "call.name":
                for node in nodes:
                    callee_name = node.text.decode('utf8')
                    # Walk up the AST to find the parent function making the call
                    parent = node.parent
                    while parent and parent.type != 'function_definition':
                        parent = parent.parent
                    
                    if parent:
                        name_node = parent.child_by_field_name('name')
                        if name_node:
                            caller_name = name_node.text.decode('utf8')
                            session.run("""
                                MERGE (caller:Function {name: $caller})
                                MERGE (callee:Function {name: $callee})
                                MERGE (caller)-[:CALLS]->(callee)
                            """, caller=caller_name, callee=callee_name)

def ingest_folder(folder_path):
    print(f"🚀 Starting Deep Ingestion: {folder_path}")
    for root, dirs, files in os.walk(folder_path):
        # Prune standard bloat directories
        dirs[:] = [d for d in dirs if d not in ['.git', 'venv', '.venv', '__pycache__', 'node_modules']]
        
        for file in files:
            if file.endswith(".py"):
                print(f"Parsing: {file}")
                process_file(os.path.join(root, file))
    print("✅ Semantic Graph Ingestion Complete.")

if __name__ == "__main__":
    ingest_folder(TARGET_DIR)
