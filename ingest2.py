import os
import sys
import builtins
import tree_sitter_python as tspython
from tree_sitter import Language, Parser
from neo4j import GraphDatabase

# --- CONFIGURATION ---
NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")

# Initialize "Right Brain" (Parser)
PY_LANGUAGE = Language(tspython.language())
parser = Parser(PY_LANGUAGE)

# Initialize "Left Brain" (Graph DB)
driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)

# Cache builtins for filtering
PYTHON_BUILTINS = set(dir(builtins))

# --- QUERIES ---
# Find function definitions
FUNC_QUERY = PY_LANGUAGE.query("""
(function_definition
  name: (identifier) @func.name
) @func.def
""")

# Find calls inside a function
CALL_QUERY = PY_LANGUAGE.query("""
(call
  function: (identifier) @call.name
) @call
""")

def write_function_node(func_name, file_path):
    """
    Creates or Updates a function node.
    Crucial: 'ON MATCH' handles the case where the node was created 
    as a 'Ghost' dependency by another file earlier.
    """
    query = """
    MERGE (f:Function {name: $name})
    ON CREATE SET f.file = $file, f.type = 'def', f.scanned = true
    ON MATCH SET f.file = $file, f.type = 'def', f.scanned = true
    """
    with driver.session() as session:
        session.run(query, name=func_name, file=file_path)

def create_dependency(caller_name, callee_name):
    """
    Links Caller -> Callee.
    If Callee doesn't exist yet, it is created as a 'Ghost Node' 
    (no file path yet).
    """
    query = """
    MATCH (a:Function {name: $caller})
    MERGE (b:Function {name: $callee})
    MERGE (a)-[:CALLS]->(b)
    """
    with driver.session() as session:
        session.run(query, caller=caller_name, callee=callee_name)

def process_file(file_path):
    """Parses a single file and pushes it to the Graph."""
    print(f"📄 Scanning: {file_path}")
    
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            source_code = f.read()
    except Exception as e:
        print(f"   ⚠️ Skipping {file_path}: {e}")
        return

    tree = parser.parse(bytes(source_code, "utf8"))
    
    # 1. Find all function definitions first
    captures = FUNC_QUERY.captures(tree.root_node)
    
    if isinstance(captures, dict):
        flat_captures = []
        for capture_name, nodes in captures.items():
            for capture_node in nodes:
                flat_captures.append((capture_node, capture_name))
        captures = flat_captures

    for node, name in captures:
        if name == 'func.name':
            func_name = source_code[node.start_byte:node.end_byte]
            
            # Claim this function in the graph
            write_function_node(func_name, file_path)
            
            # 2. Look for dependencies inside this function
            func_def_node = node.parent
            call_captures = CALL_QUERY.captures(func_def_node)
            
            if isinstance(call_captures, dict):
                flat_calls = []
                for capture_name, nodes in call_captures.items():
                    for capture_node in nodes:
                        flat_calls.append((capture_node, capture_name))
                call_captures = flat_calls
            
            for call_node, capture_name in call_captures:
                # Only process the function name identifier, not the entire call expression
                if capture_name != 'call.name':
                    continue

                callee_name = source_code[call_node.start_byte:call_node.end_byte]
                
                # Filter noise (standard python types)
                if callee_name not in PYTHON_BUILTINS:
                    create_dependency(func_name, callee_name)

def ingest_folder(folder_path):
    """Recursively walks the directory and ingests all Python files."""
    if not os.path.exists(folder_path):
        print(f"❌ Error: Folder '{folder_path}' not found.")
        return

    print(f"🚀 Starting Ingestion for: {folder_path}")
    
    file_count = 0
    for root, dirs, files in os.walk(folder_path):
        # Optional: Skip hidden folders like .git or venv
        if '.git' in dirs: dirs.remove('.git')
        if 'venv' in dirs: dirs.remove('venv')
        if '__pycache__' in dirs: dirs.remove('__pycache__')

        for file in files:
            if file.endswith(".py"):
                full_path = os.path.join(root, file)
                process_file(full_path)
                file_count += 1
                
    print(f"\n✅ Ingestion Complete. Processed {file_count} files.")

if __name__ == "__main__":
    # if len(sys.argv) < 2:
    #     print("Usage: python ingest.py <path_to_repo>")
    # else:
    #     target_folder = sys.argv[1]
    #     ingest_folder(target_folder)
    #     driver.close()
    #     sys.exit(0)
    ingest_folder("testRepo")