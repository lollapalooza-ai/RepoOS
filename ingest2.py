import re
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

# --- NEW INFRASTRUCTURE PATTERNS ---
SQL_PATTERN = re.compile(r"(SELECT|INSERT|UPDATE|DELETE)\s+.*?\s+FROM\s+([a-zA-Z0-9_]+)", re.IGNORECASE)

INFRA_KEYWORDS = {
    "boto3.client": "AWS",
    "KafkaProducer": "Kafka",
    "redis.Redis": "Redis",
    "psycopg2": "Postgres",
    "pymongo": "MongoDB",
    "requests.get": "HTTP_API",
    "requests.post": "HTTP_API",
    "requests.put": "HTTP_API",
    "requests.delete": "HTTP_API",
    "httpx.get": "HTTP_API",
    "httpx.post": "HTTP_API",
    "httpx.put": "HTTP_API",
    "httpx.delete": "HTTP_API"
}

# --- QUERIES ---
# Find top-level function definitions (global functions)
GLOBAL_FUNC_QUERY = PY_LANGUAGE.query("""
(function_definition
  name: (identifier) @func.name
  (#not-has-parent? class_definition)
) @func.def
""")

# Find class definitions, including inherited base classes
CLASS_DEF_QUERY = PY_LANGUAGE.query("""
(class_definition
  name: (identifier) @class.name
  (argument_list
    (identifier) @base.class
  )?
) @class.def
""")

# Find method definitions within a class
METHOD_DEF_QUERY = PY_LANGUAGE.query("""
(class_definition
  body: (block
    (function_definition
      name: (identifier) @method.name
    ) @method.def
  )
)
""")

# Find calls inside a function or method
CALL_QUERY = PY_LANGUAGE.query("""
(call
  function: (identifier) @call.name
) @call
""")

def write_function_node(func_name, file_path, node_type='function'):
    """
    Creates or Updates a function/method node.
    'ON MATCH' handles the case where the node was created
    as a 'Ghost' dependency by another file earlier.
    """
    query = """
    MERGE (f:Function {name: $name})
    ON CREATE SET f.file = $file, f.type = $node_type, f.scanned = true
    ON MATCH SET f.file = $file, f.type = $node_type, f.scanned = true
    """
    with driver.session() as session:
        session.run(query, name=func_name, file=file_path, node_type=node_type)

def write_class_node(class_name, file_path):
    """
    Creates or Updates a class node.
    """
    query = """
    MERGE (c:Class {name: $name})
    ON CREATE SET c.file = $file, c.scanned = true
    ON MATCH SET c.file = $file, c.scanned = true
    """
    with driver.session() as session:
        session.run(query, name=class_name, file=file_path)

def create_inheritance_relationship(sub_class_name, super_class_name):
    """
    Links a subclass to its superclass.
    (:Class)-[:IMPLEMENTS]->(:Class)
    """
    query = """
    MATCH (sub:Class {name: $sub_class})
    MERGE (super:Class {name: $super_class})
    MERGE (sub)-[:IMPLEMENTS]->(super)
    """
    with driver.session() as session:
        session.run(query, sub_class=sub_class_name, super_class=super_class_name)

def create_has_method_relationship(class_name, method_name):
    """
    Links a class to its method.
    (:Class)-[:HAS_METHOD]->(:Function)
    """
    query = """
    MATCH (c:Class {name: $class_name})
    MERGE (m:Function {name: $method_name})
    MERGE (c)-[:HAS_METHOD]->(m)
    """
    with driver.session() as session:
        session.run(query, class_name=class_name, method_name=method_name)

def create_dependency(caller_name, callee_name):
    """
    Links Caller -> Callee.
    If Callee doesn't exist yet, it is created as a 'Ghost Node'
    (no file path yet).
    """
    query = """
    MERGE (a {name: $caller})
    MERGE (b {name: $callee})
    MERGE (a)-[:CALLS]->(b)
    """
    with driver.session() as session:
        session.run(query, caller=caller_name, callee=callee_name)

def create_infra_node(func_or_method_name, infra_type, infra_name):
    """
    (:Function)-[:TOUCHES]->(:Infrastructure)
    """
    query = """
    MATCH (f:Function {name: $func_or_method_name})
    MERGE (i:Infrastructure {name: $infra_name, type: $infra_type})
    MERGE (f)-[:TOUCHES]->(i)
    """
    with driver.session() as session:
        session.run(query, func_or_method_name=func_or_method_name, infra_name=infra_name, infra_type=infra_type)
        print(f"   ⚡ Found Infra: {func_or_method_name} -> {infra_type} ({infra_name})")

def analyze_infra_usage(func_or_method_name, code_snippet):
    """
    Scans code body for Infrastructure signals (SQL, AWS, Kafka, Redis, etc.).
    """
    # Check for SQL
    for match in SQL_PATTERN.finditer(code_snippet):
        table_name = match.group(2)
        if table_name:
            create_infra_node(func_or_method_name, "Database", table_name)

    # Check for Libs/APIs
    for keyword, infra_type in INFRA_KEYWORDS.items():
        if keyword in code_snippet:
            # For now, use the keyword itself as the 'name' for simplicity
            create_infra_node(func_or_method_name, infra_type, keyword)

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
    
    # --- 1. Process Class Definitions and their Methods ---
    class_captures = CLASS_DEF_QUERY.captures(tree.root_node)

    # Convert captures to a flat list for easier processing
    if isinstance(class_captures, dict):
        flat_class_captures = []
        for capture_name, nodes in class_captures.items():
            for capture_node in nodes:
                flat_class_captures.append((capture_node, capture_name))
        class_captures = flat_class_captures

    for node, name in class_captures:
        if name == 'class.name':
            class_name = source_code[node.start_byte:node.end_byte]
            write_class_node(class_name, file_path)
            
            print(f"   ➕ Class: {class_name}")

            # Find inherited classes
            class_def_node = node.parent
            # Need to get the full source code for this class definition node to scan for infra
            class_def_source = source_code[class_def_node.start_byte:class_def_node.end_byte]

            base_class_captures = CLASS_DEF_QUERY.captures(class_def_node)

            if isinstance(base_class_captures, dict):
                flat_base_class_captures = []
                for capture_name, nodes in base_class_captures.items():
                    for capture_node in nodes:
                        flat_base_class_captures.append((capture_node, capture_name))
                base_class_captures = flat_base_class_captures

            for base_node, base_name in base_class_captures:
                if base_name == 'base.class':
                    super_class_name = source_code[base_node.start_byte:base_node.end_byte]
                    if super_class_name: # Ensure it's not an empty match
                        create_inheritance_relationship(class_name, super_class_name)
                        print(f"      🔗 Inherits: {super_class_name}")

            # Find methods within this class
            method_captures = METHOD_DEF_QUERY.captures(class_def_node)
            
            if isinstance(method_captures, dict):
                flat_method_captures = []
                for capture_name, nodes in method_captures.items():
                    for capture_node in nodes:
                        flat_method_captures.append((capture_node, capture_name))
                method_captures = flat_method_captures

            for method_node, method_name_capture in method_captures:
                if method_name_capture == 'method.name':
                    method_name = source_code[method_node.start_byte:method_node.end_byte]
                    full_method_name = f"{class_name}.{method_name}" # e.g., MyClass.my_method
                    write_function_node(full_method_name, file_path, node_type='method')
                    create_has_method_relationship(class_name, full_method_name)
                    print(f"      - Method: {full_method_name}")

                    # Get the source code for the method definition for infra analysis
                    method_def_node = method_node.parent
                    method_source_code = source_code[method_def_node.start_byte:method_def_node.end_byte]
                    analyze_infra_usage(full_method_name, method_source_code) # Analyze infra usage for methods
                    
                    call_captures = CALL_QUERY.captures(method_def_node)
                    
                    if isinstance(call_captures, dict):
                        flat_calls = []
                        for capture_name, nodes in call_captures.items():
                            for capture_node in nodes:
                                flat_calls.append((capture_node, capture_name))
                        call_captures = flat_calls

                    for call_node, capture_name in call_captures:
                        if capture_name == 'call.name':
                            callee_name = source_code[call_node.start_byte:call_node.end_byte]
                            if callee_name not in PYTHON_BUILTINS:
                                create_dependency(full_method_name, callee_name)
                                print(f"         ➡️ Calls: {callee_name}")

    # --- 2. Process Global Functions ---
    global_func_captures = GLOBAL_FUNC_QUERY.captures(tree.root_node)

    if isinstance(global_func_captures, dict):
        flat_global_func_captures = []
        for capture_name, nodes in global_func_captures.items():
            for capture_node in nodes:
                flat_global_func_captures.append((capture_node, capture_name))
        global_func_captures = flat_global_func_captures

    for node, name in global_func_captures:
        if name == 'func.name':
            func_name = source_code[node.start_byte:node.end_byte]
            
            # Claim this function in the graph
            write_function_node(func_name, file_path, node_type='function')
            print(f"   ➕ Function: {func_name}")
            
            func_def_node = node.parent
            func_source_code = source_code[func_def_node.start_byte:func_def_node.end_byte]
            analyze_infra_usage(func_name, func_source_code) # Analyze infra usage for global functions

            # Look for dependencies inside this function
            call_captures = CALL_QUERY.captures(func_def_node)
            
            if isinstance(call_captures, dict):
                flat_calls = []
                for capture_name, nodes in call_captures.items():
                    for capture_node in nodes:
                        flat_calls.append((capture_node, capture_name))
                call_captures = flat_calls
            
            for call_node, capture_name in call_captures:
                # Only process the function name identifier, not the entire call expression
                if capture_name == 'call.name':
                    callee_name = source_code[call_node.start_byte:call_node.end_byte]
                    
                    # Filter noise (standard python types)
                    if callee_name not in PYTHON_BUILTINS:
                        create_dependency(func_name, callee_name)
                        print(f"      ➡️ Calls: {callee_name}")

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