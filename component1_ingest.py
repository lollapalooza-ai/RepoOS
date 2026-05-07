import os
import sys
import ast
import json
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

class AccessPathVisitor(ast.NodeVisitor):
    def __init__(self):
        self.paths = []

    def visit_Subscript(self, node):
        path = self._build_path(node)
        if path: self.paths.append(path)
        self.generic_visit(node)

    def visit_Attribute(self, node):
        path = self._build_path(node)
        if path: self.paths.append(path)
        self.generic_visit(node)

    def _build_path(self, node):
        parts = []
        curr = node
        while isinstance(curr, (ast.Subscript, ast.Attribute)):
            if isinstance(curr, ast.Subscript):
                if isinstance(curr.slice, ast.Constant) and isinstance(curr.slice.value, (str, int)):
                    parts.append(str(curr.slice.value))
                else: return None # Dynamic index
                curr = curr.value
            elif isinstance(curr, ast.Attribute):
                parts.append(curr.attr)
                curr = curr.value
        if isinstance(curr, ast.Name):
            return parts[::-1] # Return from root to leaf
        return None

def get_arg_info(source_code: str):
    try:
        tree = ast.parse(source_code)
        for node in ast.walk(tree):
            if isinstance(node, ast.FunctionDef):
                arg_count = len(node.args.args)
                hints = {}
                # NEW: Find string literals for Enum Devirtualization
                enums = []
                for subnode in ast.walk(node):
                    if isinstance(subnode, ast.Compare):
                        for comparator in subnode.comparators:
                            if isinstance(comparator, ast.Constant) and isinstance(comparator.value, str):
                                enums.append(comparator.value)
                    elif isinstance(subnode, ast.Constant) and isinstance(subnode.value, str):
                        enums.append(subnode.value)
                
                enum_map = {val: i+1 for i, val in enumerate(sorted(list(set(enums))))}

                for arg in node.args.args:
                    if arg.annotation:
                        if isinstance(arg.annotation, ast.Name):
                            hints[arg.arg] = arg.annotation.id
                        elif isinstance(arg.annotation, ast.Constant):
                            hints[arg.arg] = str(arg.annotation.value)
                        elif isinstance(arg.annotation, ast.Subscript):
                            # Handle Optional[str], etc.
                            hints[arg.arg] = ast.unparse(arg.annotation)
                    else:
                        # HEURISTIC: Guess type from variable name if no hint
                        if arg.arg in ['amt', 'amount', 'price', 'surge', 'distance']:
                            hints[arg.arg] = 'float'
                        elif arg.arg in ['region', 'name', 'api_key', 'subj', 'u_id']:
                            hints[arg.arg] = 'str'
                return arg_count, hints, enum_map
    except Exception:
        pass
    return 0, {}, {}

def extract_data_intents(source_code: str):
    """AST pass to find what JSON access paths the business logic actually uses."""
    try:
        tree = ast.parse(source_code)
        visitor = AccessPathVisitor()
        visitor.visit(tree)
        # Deduplicate paths (convert list to tuple for set)
        unique_paths = list(set(tuple(p) for p in visitor.paths))
        return [list(p) for p in unique_paths]
    except Exception:
        return []

def process_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        source_code = f.read()
    
    # 1. NEW: Extract data paths to feed to the AOT Compiler
    data_paths = extract_data_intents(source_code)
    
    # 2. UPGRADED: Tree-Sitter queries for Classes AND Functions
    tree = parser.parse(bytes(source_code, "utf8"))
    class_query = PY_LANGUAGE.query("(class_definition name: (identifier) @class.name) @class.node")
    func_query = PY_LANGUAGE.query("(function_definition name: (identifier) @func.name) @func.node")
    
    # Update Neo4j to use FQNs (Module.Class.Method)
    module_name = file_path.replace('./', '').replace('/', '.').replace('.py', '')
    if module_name.startswith('.'): module_name = module_name[1:]
    
    with driver.session() as session:
        # Push file, module, classes, and extracted JSON keys to the Graph
        session.run("""
            MERGE (m:Module {name: $module})
            SET m.path = $path, m.access_paths = $paths
        """, module=module_name, path=file_path, paths=[json.dumps(p) for p in data_paths])

        # Map Classes and Methods
        class_captures = class_query.captures(tree.root_node)
        classes = {}
        if isinstance(class_captures, dict):
            class_names = class_captures.get("class.name", [])
            class_nodes = class_captures.get("class.node", [])
            for i in range(len(class_names)):
                name = class_names[i].text.decode('utf8')
                node = class_nodes[i]
                classes[node.id] = {"name": name, "node": node}
        else:
            for node, name in class_captures:
                if name == "class.node":
                    name_node = node.child_by_field_name('name')
                    if name_node:
                        classes[node.id] = {"name": name_node.text.decode('utf8'), "node": node}

        for class_id, class_info in classes.items():
            class_name = class_info["name"]
            class_fqn = f"{module_name}.{class_name}"
            session.run("""
                MATCH (m:Module {name: $module})
                MERGE (c:Class {fqn: $fqn})
                SET c.name = $name
                MERGE (m)-[:CONTAINS]->(c)
            """, module=module_name, fqn=class_fqn, name=class_name)
            
            # Find methods in this class
            def find_methods(node):
                for child in node.children:
                    if child.type == "function_definition":
                        name_node = child.child_by_field_name('name')
                        if name_node:
                            method_name = name_node.text.decode('utf8')
                            method_fqn = f"{class_fqn}.{method_name}"
                            method_body = source_code[child.start_byte:child.end_byte]
                            arg_count, hints, enum_map = get_arg_info(method_body)
                            session.run("""
                                MATCH (c:Class {fqn: $class_fqn})
                                MERGE (f:Function {fqn: $fqn})
                                SET f.name = $name, f.code = $code, f.arg_count = $arg_count, f.type_hints = $hints, f.enum_map = $enums
                                MERGE (c)-[:HAS_METHOD]->(f)
                            """, class_fqn=class_fqn, fqn=method_fqn, name=method_name, code=method_body, arg_count=arg_count, hints=json.dumps(hints), enums=json.dumps(enum_map))
                    elif child.type == "block":
                        find_methods(child)
            
            find_methods(class_info["node"])

        # Handle Global Functions
        func_captures = func_query.captures(tree.root_node)
        functions = []
        if isinstance(func_captures, dict):
            func_nodes = func_captures.get("func.node", [])
            for node in func_nodes:
                functions.append(node)
        else:
            for node, name in func_captures:
                if name == "func.node":
                    functions.append(node)

        for func_node in functions:
            is_method = False
            parent = func_node.parent
            while parent:
                if parent.type == 'class_definition':
                    is_method = True
                    break
                parent = parent.parent
            
            if not is_method:
                name_node = func_node.child_by_field_name('name')
                if name_node:
                    func_name = name_node.text.decode('utf8')
                    fqn = f"{module_name}.{func_name}"
                    func_body = source_code[func_node.start_byte:func_node.end_byte]
                    arg_count, hints, enum_map = get_arg_info(func_body)
                    session.run("""
                        MATCH (m:Module {name: $module})
                        MERGE (f:Function {fqn: $fqn})
                        SET f.name = $name, f.code = $code, f.arg_count = $arg_count, f.type_hints = $hints, f.enum_map = $enums
                        MERGE (m)-[:CONTAINS]->(f)
                    """, module=module_name, fqn=fqn, name=func_name, code=func_body, arg_count=arg_count, hints=json.dumps(hints), enums=json.dumps(enum_map))

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
