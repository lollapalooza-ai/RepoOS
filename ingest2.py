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

# --- TREE-SITTER QUERIES (v4) ---
GLOBAL_FUNC_QUERY = PY_LANGUAGE.query("""
(function_definition
  name: (identifier) @func.name
  (#not-has-parent? class_definition)
) @func.def
""")

CLASS_DEF_QUERY = PY_LANGUAGE.query("""
(class_definition
  name: (identifier) @class.name
  (argument_list
    (identifier) @base.class
  )?
) @class.def
""")

METHOD_DEF_QUERY = PY_LANGUAGE.query("""
(class_definition
  body: (block
    (function_definition
      name: (identifier) @method.name
    ) @method.def
  )
)
""")

# Combined query for calls, attributes, and arguments
INFRA_CALL_QUERY = PY_LANGUAGE.query("""
(call
  function: [
    (attribute 
      object: (identifier) @obj 
      attribute: (identifier) @method)
    (identifier) @func
  ]
  arguments: (argument_list
    (string) @arg
  )?
) @call
""")

# Query for tracking aliases and imports
ALIAS_QUERY = PY_LANGUAGE.query("""
(import_statement
  name: (aliased_import
    name: (dotted_name) @name
    alias: (identifier) @alias))
(import_from_statement
  module_name: (dotted_name) @mod
  name: (aliased_import
    name: (dotted_name) @name
    alias: (identifier) @alias))
(assignment
  left: (identifier) @alias
  right: (identifier) @name)
""")

# SQL Extraction regex (still useful for the string literal itself)
SQL_REGEX = re.compile(r"(?P<operation>SELECT|UPDATE|DELETE|INSERT)\s+.*\s+FROM\s+(?P<table>[a-zA-Z0-9_]+)", re.IGNORECASE)
SQL_INSERT_REGEX = re.compile(r"(?P<operation>INSERT)\s+INTO\s+(?P<table>[a-zA-Z0-9_]+)", re.IGNORECASE)

def create_vector_indexes():
    """Creates the Vector Index in Neo4j."""
    query_func = """
    CREATE VECTOR INDEX `function_embeddings` IF NOT EXISTS
    FOR (n:Function) ON (n.embedding)
    OPTIONS {indexConfig: {
      `vector.dimensions`: 384,
      `vector.similarity_function`: 'cosine'
    }}
    """
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
    complexity = 0
    keywords = ['if ', 'for ', 'while ', 'try:', 'except ', 'with ']
    for word in keywords:
        complexity += source_code.count(word)
    return complexity

def write_function_node(func_name, file_path, source_code, docstring, node_type='function'):
    text_representation = f"Function: {func_name}\nDocstring: {docstring}\nCode: {source_code[:500]}"
    vector = embedder.encode(text_representation).tolist()
    complexity_score = calculate_complexity(source_code)

    query = """
    MERGE (f:Function {name: $name})
    ON CREATE SET 
        f.file = $file, 
        f.type = $node_type, 
        f.scanned = true,
        f.embedding = $embedding,
        f.complexity = $complexity,
        f.docstring = $docstring
    ON MATCH SET 
        f.file = $file, 
        f.type = $node_type, 
        f.scanned = true,
        f.embedding = $embedding,
        f.complexity = $complexity,
        f.docstring = $docstring
    """
    with driver.session() as session:
        session.run(query, name=func_name, file=file_path, node_type=node_type, embedding=vector, complexity=complexity_score, docstring=docstring)

def write_class_node(class_name, file_path, docstring=""):
    text_representation = f"Class: {class_name}\nDocstring: {docstring}"
    vector = embedder.encode(text_representation).tolist()
    
    query = """
    MERGE (c:Class {name: $name}) 
    ON CREATE SET 
        c.file = $file, 
        c.scanned = true, 
        c.docstring = $docstring,
        c.embedding = $embedding
    ON MATCH SET 
        c.file = $file, 
        c.scanned = true, 
        c.docstring = $docstring,
        c.embedding = $embedding
    """
    with driver.session() as session:
        session.run(query, name=class_name, file=file_path, docstring=docstring, embedding=vector)

def create_inheritance_relationship(sub_class_name, super_class_name):
    query = "MATCH (sub:Class {name: $sub_class}) MERGE (super:Class {name: $super_class}) MERGE (sub)-[:IMPLEMENTS]->(super)"
    with driver.session() as session:
        session.run(query, sub_class=sub_class_name, super_class=super_class_name)

def create_has_method_relationship(class_name, method_name):
    query = "MATCH (c:Class {name: $class_name}) MERGE (m:Function {name: $method_name}) MERGE (c)-[:HAS_METHOD]->(m)"
    with driver.session() as session:
        session.run(query, class_name=class_name, method_name=method_name)

def create_dependency(caller_name, callee_name):
    query = "MERGE (a {name: $caller}) MERGE (b {name: $callee}) MERGE (a)-[:CALLS]->(b)"
    with driver.session() as session:
        session.run(query, caller=caller_name, callee=callee_name)

def create_sql_touch_relationship(func_name, operation, table):
    query = """
    MATCH (f:Function {name: $func_name})
    MERGE (i:Infrastructure {type: 'SQL'})
    MERGE (f)-[r:TOUCHES]->(i)
    ON CREATE SET r.operation = $operation, r.table = $table
    ON MATCH SET r.operation = $operation, r.table = $table
    """
    with driver.session() as session:
        session.run(query, func_name=func_name, operation=operation, table=table)

def create_api_call_relationship(func_name, method, endpoint):
    path_match = re.search(r"/(?P<path>[a-zA-Z0-9_-]+)$", endpoint)
    if not path_match:
        query = "MATCH (f:Function {name: $func_name}) MERGE (i:Infrastructure {type: 'ExternalAPI'}) MERGE (f)-[r:CALLS_API]->(i) SET r.method = $method, r.endpoint = $endpoint"
        with driver.session() as session:
            session.run(query, func_name=func_name, method=method, endpoint=endpoint)
        return
    path = "/" + path_match.group("path")
    resolve_query = "MATCH (caller:Function {name: $func_name}) MATCH (callee:Function) WHERE callee.route = $path MERGE (caller)-[:CALLS]->(callee)"
    with driver.session() as session:
        result = session.run(resolve_query, func_name=func_name, path=path)
        if result.consume().counters.relationships_created == 0:
            fallback_query = "MATCH (f:Function {name: $func_name}) MERGE (i:Infrastructure {type: 'ExternalAPI'}) MERGE (f)-[r:CALLS_API]->(i) SET r.method = $method, r.endpoint = $endpoint"
            session.run(fallback_query, func_name=func_name, method=method, endpoint=endpoint)

def create_aws_touch_relationship(func_name, service):
    query = "MATCH (f:Function {name: $func_name}) MERGE (i:Infrastructure {type: 'AWS'}) MERGE (f)-[r:TOUCHES]->(i) SET r.service = $service"
    with driver.session() as session:
        session.run(query, func_name=func_name, service=service)

def create_kafka_touch_relationship(func_name, operation, topic):
    query = "MATCH (f:Function {name: $func_name}) MERGE (i:Infrastructure {type: 'Kafka'}) MERGE (f)-[r:TOUCHES]->(i) SET r.operation = $operation, r.topic = $topic"
    with driver.session() as session:
        session.run(query, func_name=func_name, operation=operation, topic=topic)

def create_other_infra_relationship(func_name, infra_type):
    query = "MATCH (f:Function {name: $func_name}) MERGE (i:Infrastructure {type: $infra_type}) MERGE (f)-[:TOUCHES]->(i)"
    with driver.session() as session:
        session.run(query, func_name=func_name, infra_type=infra_type)

def analyze_ast_infra(node, func_name, source_code, aliases):
    """
    Traverses the AST of a function/method and detects infrastructure usage using aliases.
    """
    captures = INFRA_CALL_QUERY.captures(node)
    if isinstance(captures, dict):
        captures = [(n, c) for c, nodes in captures.items() for n in nodes]
    
    # Restructure captures for easy access
    call_nodes = {}
    for capture_node, capture_name in captures:
        if capture_node not in call_nodes:
            call_nodes[capture_node] = {}
        call_nodes[capture_node][capture_name] = capture_node

    for call_node, data in call_nodes.items():
        obj_node = data.get('obj')
        method_node = data.get('method')
        func_node = data.get('func')
        arg_node = data.get('arg')

        obj_name = source_code[obj_node.start_byte:obj_node.end_byte] if obj_node else None
        method_name = source_code[method_node.start_byte:method_node.end_byte] if method_node else None
        func_call_name = source_code[func_node.start_byte:func_node.end_byte] if func_node else None
        arg_value = source_code[arg_node.start_byte:arg_node.end_byte].strip("'\"") if arg_node else ""

        # Resolve Alias
        resolved_obj = aliases.get(obj_name, obj_name)
        resolved_func = aliases.get(func_call_name, func_call_name)

        # 1. API Calls (Requests / HTTPX)
        if resolved_obj in ['requests', 'httpx'] and method_name in ['get', 'post', 'put', 'delete']:
            create_api_call_relationship(func_name, method_name.upper(), arg_value)
            # print(f"   ⚡ [AST] API: {func_name} -> {method_name.upper()} {arg_value}")

        # 2. AWS Boto3
        elif resolved_obj == 'boto3' and method_name in ['client', 'resource']:
            create_aws_touch_relationship(func_name, arg_value)
            # print(f"   ⚡ [AST] AWS: {func_name} -> {arg_value}")

        # 3. SQL (execute/run)
        elif method_name in ['execute', 'run']:
            match = SQL_REGEX.search(arg_value) or SQL_INSERT_REGEX.search(arg_value)
            if match:
                create_sql_touch_relationship(func_name, match.group('operation').upper(), match.group('table'))
                # print(f"   ⚡ [AST] SQL: {func_name} -> {match.group('operation')} on {match.group('table')}")

        # 4. Kafka
        elif method_name in ['send', 'poll']:
            # Topic is usually the first argument
            create_kafka_touch_relationship(func_name, method_name, arg_value)
            # print(f"   ⚡ [AST] Kafka: {func_name} -> {method_name} on {arg_value}")

        # 5. Django ORM
        # This is trickier as 'objects' is an attribute of a model. 
        # For now, we look for '.objects.filter' etc.
        elif method_name in ['filter', 'get', 'create', 'update', 'delete', 'all']:
            # In node.children[0] (the attribute), child 0 is the 'Model.objects' part
            # This is a bit deep, but we can check if obj_name ends with '.objects'
            if obj_name and obj_name.endswith('.objects'):
                create_other_infra_relationship(func_name, 'DJANGO_ORM')
                # print(f"   ⚡ [AST] Django: {func_name} -> {method_name}")

        # 6. Redis / Mongo
        elif resolved_obj in ['redis', 'pymongo'] or resolved_func in ['Redis', 'MongoClient']:
            infra_type = 'REDIS' if 'redis' in (resolved_obj or resolved_func).lower() else 'MONGO'
            create_other_infra_relationship(func_name, infra_type)
            # print(f"   ⚡ [AST] Infra: {func_name} -> {infra_type}")

def get_file_aliases(tree, source_code):
    """Detects imports and assignments to build an alias map."""
    aliases = {}
    captures = ALIAS_QUERY.captures(tree.root_node)
    if isinstance(captures, dict):
        captures = [(n, c) for c, nodes in captures.items() for n in nodes]
    for node, name in captures:
        # This is a bit simplified, but captures 'alias' and 'name'
        # We need to correlate them by parent node
        pass
    
    # Manual traversal for robust alias mapping
    for node in tree.root_node.children:
        if node.type in ['import_statement', 'import_from_statement']:
            for child in node.children:
                if child.type == 'aliased_import':
                    orig = source_code[child.child_by_field_name('name').start_byte:child.child_by_field_name('name').end_byte]
                    alias = source_code[child.child_by_field_name('alias').start_byte:child.child_by_field_name('alias').end_byte]
                    aliases[alias] = orig
        elif node.type == 'expression_statement':
            assign = node.children[0]
            if assign.type == 'assignment':
                left = assign.child_by_field_name('left')
                right = assign.child_by_field_name('right')
                if left and right and left.type == 'identifier' and right.type == 'identifier':
                    l_val = source_code[left.start_byte:left.end_byte]
                    r_val = source_code[right.start_byte:right.end_byte]
                    if r_val in ['requests', 'httpx', 'boto3', 'redis', 'pymongo']:
                        aliases[l_val] = r_val
    return aliases

def write_file_node(file_path):
    query = "MERGE (f:File {path: $path}) ON CREATE SET f.scanned = true ON MATCH SET f.scanned = true"
    with driver.session() as session:
        session.run(query, path=file_path)

def create_file_import_relationship(importer_path, imported_module):
    # This is heuristic-based; resolving module name to path
    # For now, we'll store the raw module name and a potential match if found
    query = """
    MERGE (f1:File {path: $importer_path})
    MERGE (f2:File {path: $imported_module})
    MERGE (f2)-[:IMPORTED_BY]->(f1)
    """
    with driver.session() as session:
        session.run(query, importer_path=importer_path, imported_module=imported_module)

def create_test_relationship(test_node_name, target_node_name):
    query = """
    MATCH (t {name: $test_node})
    MATCH (target {name: $target_node})
    MERGE (t)-[:TESTS]->(target)
    """
    with driver.session() as session:
        session.run(query, test_node=test_node_name, target_node=target_node_name)

def process_file(file_path):
    # print(f"📄 Scanning: {file_path}")
    write_file_node(file_path)
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            source_code = f.read()
    except Exception as e:
        print(f"   ⚠️ Skipping {file_path}: {e}")
        return

    tree = parser.parse(bytes(source_code, "utf8"))
    aliases = get_file_aliases(tree, source_code)
    
    # Track imports for IMPORTED_BY
    for node in tree.root_node.children:
        if node.type == 'import_statement':
            for child in node.children:
                if child.type == 'dotted_name':
                    mod_name = source_code[child.start_byte:child.end_byte]
                    create_file_import_relationship(file_path, mod_name)
        elif node.type == 'import_from_statement':
            mod_node = node.child_by_field_name('module_name')
            if mod_node:
                mod_name = source_code[mod_node.start_byte:mod_node.end_byte]
                create_file_import_relationship(file_path, mod_name)

    is_test_file = "test" in os.path.basename(file_path).lower() or "/tests/" in file_path
    if is_test_file:
        # Heuristic: File-level TESTS relationship
        impl_candidate = os.path.basename(file_path).replace("test_", "").replace("_test", "")
        # This is very simple; real resolution would check existence
        query = """
        MATCH (t:File {path: $test_file})
        MATCH (impl:File) WHERE impl.path ENDS WITH $impl_candidate
        MERGE (t)-[:TESTS]->(impl)
        """
        with driver.session() as s:
            s.run(query, test_file=file_path, impl_candidate=impl_candidate)

    # if aliases:
    #     print(f"   🆔 Aliases detected: {aliases}")
    
    # --- 1. Classes ---
    class_captures = CLASS_DEF_QUERY.captures(tree.root_node)
    if isinstance(class_captures, dict):
        class_captures = [(n, c) for c, nodes in class_captures.items() for n in nodes]
        
    for node, name in class_captures:
        if name == 'class.name':
            class_name = source_code[node.start_byte:node.end_byte]
            class_def_node = node.parent
            
            # Extract class docstring
            class_doc = ""
            body = class_def_node.child_by_field_name('body')
            if body and body.child_count > 0:
                first = body.children[0]
                if first.type == 'expression_statement' and first.children[0].type == 'string':
                    class_doc = source_code[first.start_byte:first.end_byte].strip("'\"")

            write_class_node(class_name, file_path, docstring=class_doc)
            # print(f"   ➕ Class: {class_name}")

            base_captures = CLASS_DEF_QUERY.captures(class_def_node)
            if isinstance(base_captures, dict):
                base_captures = [(n, c) for c, nodes in base_captures.items() for n in nodes]
            for base_node, base_name in base_captures:
                if base_name == 'base.class':
                    super_name = source_code[base_node.start_byte:base_node.end_byte]
                    create_inheritance_relationship(class_name, super_name)

            method_captures = METHOD_DEF_QUERY.captures(class_def_node)
            if isinstance(method_captures, dict):
                method_captures = [(n, c) for c, nodes in method_captures.items() for n in nodes]
            for method_node, method_name_capture in method_captures:
                if method_name_capture == 'method.name':
                    m_name = source_code[method_node.start_byte:method_node.end_byte]
                    full_m_name = f"{class_name}.{m_name}"
                    m_def_node = method_node.parent
                    m_source = source_code[m_def_node.start_byte:m_def_node.end_byte]
                    
                    doc = ""
                    body = m_def_node.child_by_field_name('body')
                    if body and body.child_count > 0:
                        first = body.children[0]
                        if first.type == 'expression_statement' and first.children[0].type == 'string':
                            doc = source_code[first.start_byte:first.end_byte]

                    write_function_node(full_m_name, file_path, m_source, doc, node_type='method')
                    create_has_method_relationship(class_name, full_m_name)
                    analyze_ast_infra(m_def_node, full_m_name, source_code, aliases)
                    
                    # Dependency tracking
                    call_captures = CALL_QUERY.captures(m_def_node)
                    if isinstance(call_captures, dict):
                        call_captures = [(n, c) for c, nodes in call_captures.items() for n in nodes]
                    for c_node, c_name in call_captures:
                        if c_name == 'call.name':
                            callee = source_code[c_node.start_byte:c_node.end_byte]
                            if callee not in PYTHON_BUILTINS:
                                create_dependency(full_m_name, callee)
                                if is_test_file and full_m_name.startswith("test_") and not callee.startswith("test_"):
                                    create_test_relationship(full_m_name, callee)

    # --- 2. Global Functions ---
    global_captures = GLOBAL_FUNC_QUERY.captures(tree.root_node)
    if isinstance(global_captures, dict):
        global_captures = [(n, c) for c, nodes in global_captures.items() for n in nodes]
    for node, name in global_captures:
        if name == 'func.name':
            f_name = source_code[node.start_byte:node.end_byte]
            f_def_node = node.parent
            f_source = source_code[f_def_node.start_byte:f_def_node.end_byte]
            
            doc = ""
            body = f_def_node.child_by_field_name('body')
            if body and body.child_count > 0:
                first = body.children[0]
                if first.type == 'expression_statement' and first.children[0].type == 'string':
                    doc = source_code[first.start_byte:first.end_byte]

            write_function_node(f_name, file_path, f_source, doc, node_type='function')
            
            # Decorator check (routes)
            if f_def_node.prev_sibling and f_def_node.prev_sibling.type == 'decorator':
                dec_text = source_code[f_def_node.prev_sibling.start_byte:f_def_node.prev_sibling.end_byte]
                r_match = re.search(r"@app\.route\(['\"](.*?)['\"]", dec_text)
                if r_match:
                    with driver.session() as s:
                        s.run("MATCH (f:Function {name: $name}) SET f.route = $route", name=f_name, route=r_match.group(1))

            analyze_ast_infra(f_def_node, f_name, source_code, aliases)

            call_captures = CALL_QUERY.captures(f_def_node)
            if isinstance(call_captures, dict):
                call_captures = [(n, c) for c, nodes in call_captures.items() for n in nodes]
            for c_node, c_name in call_captures:
                if c_name == 'call.name':
                    callee = source_code[c_node.start_byte:c_node.end_byte]
                    if callee not in PYTHON_BUILTINS:
                        create_dependency(f_name, callee)
                        if is_test_file and f_name.startswith("test_") and not callee.startswith("test_"):
                            create_test_relationship(f_name, callee)

def ingest_folder(folder_path):
    if not os.path.exists(folder_path):
        print(f"❌ Error: Folder '{folder_path}' not found.")
        return
    print(f"🚀 Starting Ingestion: {folder_path}")
    for root, dirs, files in os.walk(folder_path):
        for d in ['.git', 'venv', '.venv', '__pycache__']:
            if d in dirs: dirs.remove(d)
        for file in files:
            if file.endswith(".py"):
                process_file(os.path.join(root, file))
    print("\n✅ Ingestion Complete.")

# Mock CALL_QUERY for compatibility with existing code structure
CALL_QUERY = PY_LANGUAGE.query("(call function: (identifier) @call.name) @call")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python ingest2.py <path_to_repo>")
    else:
        create_vector_indexes()
        ingest_folder(sys.argv[1])
        driver.close()
