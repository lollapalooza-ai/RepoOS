import os
import sys
import ast
import tree_sitter_python as tspython
from tree_sitter import Language, Parser
from neo4j import GraphDatabase

# --- Configuration ---
NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
DEFAULT_TARGET_DIR = "./legacy_shop"

PY_LANGUAGE = Language(tspython.language())
parser = Parser(PY_LANGUAGE)
driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)

def get_arg_count(source_code: str) -> int:
    try:
        # We need to wrap the body if it's not a full function definition 
        # but in our case func_body is the whole 'def ...' block
        tree = ast.parse(source_code)
        for node in ast.walk(tree):
            if isinstance(node, ast.FunctionDef):
                # Count standard arguments (ignoring *args, **kwargs for MVP)
                return len(node.args.args)
    except Exception:
        pass
    return 0

def process_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        source_code = f.read()
    
    tree = parser.parse(bytes(source_code, "utf8"))
    func_query = PY_LANGUAGE.query("(function_definition name: (identifier) @func.name)")
    call_query = PY_LANGUAGE.query("(call function: (identifier) @call.name)")
    
    with driver.session() as session:
        session.run("MERGE (file:File {path: $path})", path=file_path)
        
        # 1. Map Functions & Code
        func_captures = func_query.captures(tree.root_node)
        for capture_name, nodes in func_captures.items():
            if capture_name == "func.name":
                for node in nodes:
                    func_name = node.text.decode('utf8')
                    func_node = node.parent
                    func_body = source_code[func_node.start_byte:func_node.end_byte]
                    arg_count = get_arg_count(func_body) # <--- NEW DYNAMIC EXTRACTION
                    
                    session.run("""
                        MATCH (file:File {path: $path})
                        MERGE (f:Function {name: $name, file: $path})
                        SET f.code = $code, f.arg_count = $arg_count
                        MERGE (file)-[:CONTAINS]->(f)
                    """, name=func_name, path=file_path, code=func_body, arg_count=arg_count)
                
        # 2. Map Dependencies
        call_captures = call_query.captures(tree.root_node)
        for capture_name, nodes in call_captures.items():
            if capture_name == "call.name":
                for node in nodes:
                    callee_name = node.text.decode('utf8')
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
        dirs[:] = [d for d in dirs if d not in ['.git', 'venv', '.venv', '__pycache__']]
        for file in files:
            if file.endswith(".py"):
                process_file(os.path.join(root, file))
    print("✅ Semantic Graph Ingestion Complete.")

if __name__ == "__main__":
    target = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_TARGET_DIR
    ingest_folder(target)
