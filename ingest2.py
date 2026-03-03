import re
import os
import sys
import builtins
import tree_sitter_python as tspython
from tree_sitter import Language, Parser
from neo4j import GraphDatabase
from sentence_transformers import SentenceTransformer

# --- CONFIGURATION ---
NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")

# Initialize "Right Brain" (Parser)
PY_LANGUAGE = Language(tspython.language())
parser = Parser(PY_LANGUAGE)

# Initialize "Right Brain" (Embedding Model)
print("🧠 Loading Embedding Model (Local M4 Optimized)...")
embedder = SentenceTransformer('all-MiniLM-L6-v2')
EMBEDDING_DIM = 384  # Dimension for MiniLM

# Initialize "Left Brain" (Graph DB)
driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)

# Cache builtins for filtering
PYTHON_BUILTINS = set(dir(builtins))

# --- NEW INFRASTRUCTURE PATTERNS (v3) ---
# This dictionary holds regex patterns to detect various infrastructure interactions.
# Each pattern uses named capture groups to extract specific details.
INFRASTRUCTURE_PATTERNS = {
    'SQL_QUERY': re.compile(
        r"(?P<operation>SELECT|UPDATE|DELETE)\s+.*\s+FROM\s+(?P<table>[a-zA-Z0-9_]+)",
        re.IGNORECASE
    ),
    'SQL_INSERT': re.compile(
        r"(?P<operation>INSERT)\s+INTO\s+(?P<table>[a-zA-Z0-9_]+)",
        re.IGNORECASE
    ),
    'API_REQUESTS': re.compile(
        r"requests\.(?P<method>get|post|put|delete)\(\s*f?[\"'](?P<endpoint>[^\"']+)[\"']",
        re.IGNORECASE
    ),
    'API_HTTPX': re.compile(
        r"httpx\.(?P<method>get|post|put|delete)\(\s*f?[\"'](?P<endpoint>[^\"']+)[\"']",
        re.IGNORECASE
    ),
    'BOTO3': re.compile(
        r"boto3\.(?:client|resource)\(\s*[\"'](?P<service>[a-zA-Z0-9_-]+)[\"']",
        re.IGNORECASE
    ),
    'KAFKA': re.compile(
        r"\.(?P<operation>send|poll)\(\s*[\"'](?P<topic>[a-zA-Z0-9_-]+)[\"']",
        re.IGNORECASE
    ),
    'DJANGO_ORM': re.compile(
       r"(?P<model>[a-zA-Z0-9_]+)\.objects\.(?P<method>filter|get|create|update|delete|all)",
       re.IGNORECASE
    ),
    # A simple keyword-based detection for other infra types
    'REDIS': re.compile(r"redis\.Redis"),
    'MONGO': re.compile(r"pymongo\.MongoClient"),
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

def create_vector_indexes():
    """
    Creates the Vector Index in Neo4j (v5.x+ Syntax).
    Allows us to query: "Find code related to 'payment retry logic'"
    """
    query_func = """
    CREATE VECTOR INDEX `function_embeddings` IF NOT EXISTS
    FOR (n:Function) ON (n.embedding)
    OPTIONS {indexConfig: {
      `vector.dimensions`: 384,
      `vector.similarity_function`: 'cosine'
    }}
    """
    # Optional: Index Classes too if needed
    query_class = """
    CREATE VECTOR INDEX `class_embeddings` IF NOT EXISTS
    FOR (n:Class) ON (n.embedding)
    OPTIONS {indexConfig: {
      `vector.dimensions`: 384,
      `vector.similarity_function`: 'cosine'
    }}
    """
    try:
        with driver.session() as session:
            session.run(query_func)
            session.run(query_class)
        print("   ✅ Vector Indexes Configured.")
    except Exception as e:
        print(f"   ⚠️ Vector Index Warning: {e}")


def calculate_complexity(source_code):
    """
    Simple heuristic: Count 'if', 'for', 'while', 'try' statements.
    """
    complexity = 0
    keywords = ['if ', 'for ', 'while ', 'try:', 'except ', 'with ']
    for word in keywords:
        complexity += source_code.count(word)
    return complexity


def write_function_node(func_name, file_path, source_code, docstring, node_type='function'):
    """
    Now includes 'Right Brain' vector generation and complexity calculation.
    We embed: Name + Docstring + First 500 chars of code (Context)
    """
    # 1. Generate the Semantic Fingerprint
    text_representation = f"Function: {func_name}\nDocstring: {docstring}\nCode: {source_code[:500]}"
    vector = embedder.encode(text_representation).tolist()

    # 2. Calculate Complexity
    complexity_score = calculate_complexity(source_code)

    # 3. Write to Graph + Vector Store
    query = """
    MERGE (f:Function {name: $name})
    ON CREATE SET 
        f.file = $file, 
        f.type = $node_type, 
        f.scanned = true,
        f.embedding = $embedding,
        f.complexity = $complexity
    ON MATCH SET 
        f.file = $file, 
        f.type = $node_type, 
        f.scanned = true,
        f.embedding = $embedding,
        f.complexity = $complexity
    """
    with driver.session() as session:
        session.run(query, 
                    name=func_name, 
                    file=file_path, 
                    node_type=node_type, 
                    embedding=vector, 
                    complexity=complexity_score)

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

def create_sql_touch_relationship(func_name, operation, table):
    """
    (:Function)-[:TOUCHES {operation, table}]->(:Infrastructure {type: 'SQL'})
    """
    query = """
    MATCH (f:Function {name: $func_name})
    MERGE (i:Infrastructure {type: 'SQL'})
    MERGE (f)-[r:TOUCHES]->(i)
    ON CREATE SET r.operation = $operation, r.table = $table
    ON MATCH SET r.operation = $operation, r.table = $table
    """
    with driver.session() as session:
        session.run(query, func_name=func_name, operation=operation, table=table)
        print(f"   ⚡ Found SQL: {func_name} -> {operation} on {table}")

def create_api_call_relationship(func_name, method, endpoint):
    """
    Tries to resolve an API endpoint to a specific function in the graph.
    If successful, creates a direct [:CALLS] relationship.
    Otherwise, creates a generic [:CALLS_API] relationship to an Infrastructure node.
    """
    # Extract the path from a potentially complex URL string
    path_match = re.search(r"/(?P<path>[a-zA-Z0-9_-]+)$", endpoint)
    if not path_match:
        # Fallback for non-standard or unresolved paths
        query = """
        MATCH (f:Function {name: $func_name})
        MERGE (i:Infrastructure {type: 'ExternalAPI'})
        MERGE (f)-[r:CALLS_API]->(i)
        SET r.method = $method, r.endpoint = $endpoint
        """
        with driver.session() as session:
            session.run(query, func_name=func_name, method=method, endpoint=endpoint)
            print(f"   ⚡ Found unresolved API Call: {func_name} -> {method} {endpoint}")
        return

    path = "/" + path_match.group("path")

    # Query to find the function with the matching route
    resolve_query = """
    MATCH (caller:Function {name: $func_name})
    MATCH (callee:Function) WHERE callee.route = $path
    MERGE (caller)-[:CALLS]->(callee)
    """
    with driver.session() as session:
        result = session.run(resolve_query, func_name=func_name, path=path)
        summary = result.consume()
        if summary.counters.relationships_created > 0:
            print(f"   ⚡ Found and linked API Call: {func_name} -> {path}")
        else:
            # Fallback if no function with that route is found
            fallback_query = """
            MATCH (f:Function {name: $func_name})
            MERGE (i:Infrastructure {type: 'ExternalAPI'})
            MERGE (f)-[r:CALLS_API]->(i)
            SET r.method = $method, r.endpoint = $endpoint
            """
            session.run(fallback_query, func_name=func_name, method=method, endpoint=endpoint)
            print(f"   ⚡ Found unresolved API Call: {func_name} -> {method} {endpoint}")

def create_aws_touch_relationship(func_name, service):
    """
    (:Function)-[:TOUCHES {service}]->(:Infrastructure {type: 'AWS'})
    """
    query = """
    MATCH (f:Function {name: $func_name})
    MERGE (i:Infrastructure {type: 'AWS'})
    MERGE (f)-[r:TOUCHES]->(i)
    ON CREATE SET r.service = $service
    ON MATCH SET r.service = $service
    """
    with driver.session() as session:
        session.run(query, func_name=func_name, service=service)
        print(f"   ⚡ Found AWS: {func_name} -> service: {service}")

def create_kafka_touch_relationship(func_name, operation, topic):
    """
    (:Function)-[:TOUCHES {operation, topic}]->(:Infrastructure {type: 'Kafka'})
    """
    query = """
    MATCH (f:Function {name: $func_name})
    MERGE (i:Infrastructure {type: 'Kafka'})
    MERGE (f)-[r:TOUCHES]->(i)
    ON CREATE SET r.operation = $operation, r.topic = $topic
    ON MATCH SET r.operation = $operation, r.topic = $topic
    """
    with driver.session() as session:
        session.run(query, func_name=func_name, operation=operation, topic=topic)
        print(f"   ⚡ Found Kafka: {func_name} -> {operation} on topic: {topic}")

def create_other_infra_relationship(func_name, infra_type):
    """
    Creates a generic relationship for other infra types like Boto3, Kafka, etc.
    (:Function)-[:TOUCHES]->(:Infrastructure {type: 'AWS'})
    """
    query = """
    MATCH (f:Function {name: $func_name})
    MERGE (i:Infrastructure {type: $infra_type})
    MERGE (f)-[:TOUCHES]->(i)
    """
    with driver.session() as session:
        session.run(query, func_name=func_name, infra_type=infra_type)
        print(f"   ⚡ Found Infra: {func_name} -> {infra_type}")

def analyze_infra_usage(func_or_method_name, code_snippet):
    """
    Scans code body for Infrastructure signals using the new patterns.
    """
    # SQL Detection
    for pattern_name in ['SQL_QUERY', 'SQL_INSERT']:
        for match in INFRASTRUCTURE_PATTERNS[pattern_name].finditer(code_snippet):
            details = match.groupdict()
            create_sql_touch_relationship(
                func_or_method_name,
                details.get('operation', 'UNKNOWN').upper(),
                details.get('table', 'UNKNOWN')
            )

    # API Detection (Requests)
    for match in INFRASTRUCTURE_PATTERNS['API_REQUESTS'].finditer(code_snippet):
        details = match.groupdict()
        create_api_call_relationship(
            func_or_method_name,
            details.get('method', 'UNKNOWN').upper(),
            details.get('endpoint', 'UNKNOWN')
        )

    # API Detection (HTTPX)
    for match in INFRASTRUCTURE_PATTERNS['API_HTTPX'].finditer(code_snippet):
        details = match.groupdict()
        create_api_call_relationship(
            func_or_method_name,
            details.get('method', 'UNKNOWN').upper(),
            details.get('endpoint', 'UNKNOWN')
        )

    # AWS Boto3 Detection
    for match in INFRASTRUCTURE_PATTERNS['BOTO3'].finditer(code_snippet):
        details = match.groupdict()
        create_aws_touch_relationship(
            func_or_method_name,
            details.get('service', 'UNKNOWN')
        )

    # Kafka Detection
    for match in INFRASTRUCTURE_PATTERNS['KAFKA'].finditer(code_snippet):
        details = match.groupdict()
        create_kafka_touch_relationship(
            func_or_method_name,
            details.get('operation', 'UNKNOWN'),
            details.get('topic', 'UNKNOWN')
        )
    
    # Other keyword-based infrastructure
    other_infra = ['REDIS', 'MONGO']
    for infra_key in other_infra:
        if INFRASTRUCTURE_PATTERNS[infra_key].search(code_snippet):
            # We use the key as the type, e.g., 'REDIS' becomes type 'REDIS'
            create_other_infra_relationship(func_or_method_name, infra_key)

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
                    method_def_node = method_node.parent
                    method_source_code = source_code[method_def_node.start_byte:method_def_node.end_byte]
                    
                    # EXTRACT DOCSTRING (Simple Regex or Tree-sitter check)
                    docstring = ""
                    if method_def_node.child_count > 0:
                        # Simple heuristic: Check if first statement is a string expression
                        body_node = method_def_node.child_by_field_name('body')
                        if body_node and body_node.child_count > 0:
                            first_child = body_node.children[0]
                            if first_child.type == 'expression_statement' and first_child.children[0].type == 'string':
                                docstring = source_code[first_child.start_byte:first_child.end_byte]

                    write_function_node(full_method_name, file_path, method_source_code, docstring, node_type='method')
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
            
            func_def_node = node.parent
            func_source_code = source_code[func_def_node.start_byte:func_def_node.end_byte]
            
            # EXTRACT DOCSTRING (Simple Regex or Tree-sitter check)
            docstring = ""
            if func_def_node.child_count > 0:
                # Simple heuristic: Check if first statement is a string expression
                body_node = func_def_node.child_by_field_name('body')
                if body_node and body_node.child_count > 0:
                    first_child = body_node.children[0]
                    if first_child.type == 'expression_statement' and first_child.children[0].type == 'string':
                        docstring = source_code[first_child.start_byte:first_child.end_byte]

            # Call the new Write Function
            write_function_node(func_name, file_path, func_source_code, docstring, node_type='function')
            print(f"   ➕ Function (with Vector): {func_name}")

            # Check for @app.route decorator
            if func_def_node.prev_sibling and func_def_node.prev_sibling.type == 'decorator':
                decorator_text = source_code[func_def_node.prev_sibling.start_byte:func_def_node.prev_sibling.end_byte]
                route_match = re.search(r"@app\.route\(['\"](.*?)['\"]", decorator_text)
                if route_match:
                    route = route_match.group(1)
                    with driver.session() as session:
                        session.run("MATCH (f:Function {name: $name}) SET f.route = $route", name=func_name, route=route)
                        print(f"      - Route: {route}")
            
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
        if '.venv' in dirs: dirs.remove('.venv')
        if '__pycache__' in dirs: dirs.remove('__pycache__')

        for file in files:
            if file.endswith(".py"):
                full_path = os.path.join(root, file)
                process_file(full_path)
                file_count += 1
                
    print(f"\n✅ Ingestion Complete. Processed {file_count} files.")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python ingest.py <path_to_repo>")
    else:
        target_folder = sys.argv[1]
        create_vector_indexes()
        ingest_folder(target_folder)
        driver.close()
        sys.exit(0)
    # ingest_folder("testRepo")