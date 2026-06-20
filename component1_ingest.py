import sys
import os
import ast
import json
from typing import List, Dict, Any, Optional
import tree_sitter_python as tspython
from tree_sitter import Language, Parser
from neo4j import GraphDatabase

# Configure Neo4j
NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
DEFAULT_TARGET_DIR = "./legacy_shop"

driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
PY_LANGUAGE = Language(tspython.language())
parser = Parser(PY_LANGUAGE)

class SemanticClassifier(ast.NodeVisitor):
    def __init__(self):
        self.scores = {"MATH": 0, "FSM": 0, "TABULAR": 0, "BRANCHING": 0, "CRYPTO": 0}
        self.crypto_keywords = {'hashlib', 'hmac', 'jwt', 'bcrypt', 'AES', 'encrypt', 'verify'}

    def visit_Call(self, node):
        func_name = ""
        # Check for crypto keywords in the entire call chain
        call_str = ast.unparse(node.func).lower()
        if any(crypto in call_str for crypto in self.crypto_keywords):
            self.scores["CRYPTO"] += 100
            
        if isinstance(node.func, ast.Attribute):
            func_name = node.func.attr
            # FSM Heuristics: String/Byte manipulation
            if func_name in ['split', 'replace', 'encode', 'decode', 'loads', 'dumps']:
                self.scores["FSM"] += 5
            # Tabular/ORM Heuristics: Database queries
            elif func_name in ['filter', 'all', 'query', 'execute', 'fetch', 'select', 'where']:
                self.scores["TABULAR"] += 5
        
        self.generic_visit(node)

    def visit_ListComp(self, node):
        # Tabular Heuristics: Filtering collections
        self.scores["TABULAR"] += 2
        self.generic_visit(node)

    def visit_If(self, node):
        # Branching Heuristics: High density of control flow
        self.scores["BRANCHING"] += 2
        self.generic_visit(node)

    def visit_For(self, node):
        # Math/Tabular Heuristics: Heavy looping
        self.scores["MATH"] += 1
        self.scores["TABULAR"] += 1
        self.generic_visit(node)

    def visit_BinOp(self, node):
        # Math Heuristics: Dense arithmetic
        if isinstance(node.op, (ast.Mult, ast.MatMult, ast.Add, ast.Sub)):
            self.scores["MATH"] += 2
        self.generic_visit(node)

def determine_execution_track(func_code: str) -> str:
    """Call 0: The Automated Hotspot Extractor"""
    try:
        tree = ast.parse(func_code)
        classifier = SemanticClassifier()
        classifier.visit(tree)
        
        # Win conditions
        if classifier.scores["CRYPTO"] >= 100: return "CRYPTO"
        
        # Return the track with the highest heuristic score, default to MATH
        best_track = max(classifier.scores, key=classifier.scores.get)
        return best_track if classifier.scores[best_track] > 0 else "MATH"
    except SyntaxError:
        return "FSM" # Fallback for non-standard syntax

def get_arg_info(func_code):
    """
    Extracts number of arguments, type hints, and string-to-enum mappings.
    """
    try:
        tree = ast.parse(func_code)
        func_def = tree.body[0]
        arg_count = len(func_def.args.args)
        hints = {}
        for arg in func_def.args.args:
            if arg.annotation:
                hints[arg.arg] = ast.unparse(arg.annotation)
        
        enum_map = {}
        counter = 0
        for node in ast.walk(tree):
            if isinstance(node, ast.Compare) and isinstance(node.ops[0], (ast.Eq, ast.NotEq)):
                for comparator in node.comparators:
                    if isinstance(comparator, ast.Constant) and isinstance(comparator.value, str):
                        if comparator.value not in enum_map:
                            enum_map[comparator.value] = counter
                            counter += 1
        return arg_count, hints, enum_map
    except:
        return 0, {}, {}

def extract_domain_variables(func_code):
    """
    Extracts domain-specific variables like accumulators and dictionary keys.
    """
    try:
        tree = ast.parse(func_code)
        domain_vars = {"bools": set(), "floats": set()}
        
        for node in ast.walk(tree):
            # Heuristic 1: If it's used in an if condition, it's a bool
            if isinstance(node, ast.If):
                for subnode in ast.walk(node.test):
                    if isinstance(subnode, ast.Subscript) and isinstance(subnode.slice, ast.Constant) and isinstance(subnode.slice.value, str):
                        domain_vars["bools"].add(subnode.slice.value)
            
            # Heuristic 2: If it's used in a math operation (like +=), it's a float/int
            if isinstance(node, ast.AugAssign):
                for subnode in ast.walk(node.value):
                    if isinstance(subnode, ast.Subscript) and isinstance(subnode.slice, ast.Constant) and isinstance(subnode.slice.value, str):
                        domain_vars["floats"].add(subnode.slice.value)

            # Heuristic 3: Explicit initialization (e.g. total_revenue = 0.0)
            if isinstance(node, ast.Assign):
                for target in node.targets:
                    if isinstance(target, ast.Name):
                        if isinstance(node.value, ast.Constant):
                            if isinstance(node.value.value, float):
                                domain_vars["floats"].add(target.id)
                            elif isinstance(node.value.value, bool):
                                domain_vars["bools"].add(target.id)
        
        return {
            "bools": list(domain_vars["bools"]),
            "floats": list(domain_vars["floats"])
        }
    except:
        return {"bools": [], "floats": []}

def normalize_fqn(module_path: str, func_name: str) -> str:
    """
    Surgically generates clean FQNs by stripping machine-specific paths.
    Matches Python's __module__ + __qualname__ identity.
    """
    # Use absolute path to ensure consistent splitting
    abs_path = os.path.abspath(module_path)
    
    if "site-packages/" in abs_path:
        # Handle library code
        clean_module = abs_path.split("site-packages/")[1]
    else:
        # Handle local project code
        clean_module = os.path.relpath(abs_path, os.getcwd())
    
    # Convert to dot notation
    clean_module = clean_module.replace(".py", "").replace("/", ".")
    # Remove leading dots or common artifacts
    if clean_module.startswith("."): clean_module = clean_module[1:]
    
    # STRIP __INIT__: Match Python's runtime module reporting
    if clean_module.endswith(".__init__"):
        clean_module = clean_module[:-9]
    elif clean_module == "__init__":
        clean_module = ""
    
    if not clean_module: return func_name
    return f"{clean_module}.{func_name}"

def process_file(file_path, forced_module_name=None):
    with open(file_path, 'r', encoding='utf-8') as f:
        source_code = f.read()
    
    tree = parser.parse(bytes(source_code, "utf8"))
    class_query = PY_LANGUAGE.query("(class_definition name: (identifier) @class.name) @class.node")
    func_query = PY_LANGUAGE.query("(function_definition name: (identifier) @func.name) @func.node")
    
    # Calculate base module name using same logic as FQN
    if forced_module_name:
        module_name = forced_module_name
    else:
        module_name = normalize_fqn(file_path, "").rstrip(".")
    
    with driver.session() as session:
        session.run("""
            MERGE (m:Module {name: $module})
            SET m.path = $path
        """, module=module_name, path=file_path)

        # Handle Classes
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
            
            def find_methods(node):
                for child in node.children:
                    if child.type == "function_definition":
                        name_node = child.child_by_field_name('name')
                        params_node = child.child_by_field_name('parameters')
                        if name_node and params_node:
                            method_name = name_node.text.decode('utf8')
                            method_params = params_node.text.decode('utf8')
                            # USE NORMALIZED FQN
                            method_fqn = normalize_fqn(file_path, f"{class_name}.{method_name}")
                            method_body = source_code[child.start_byte:child.end_byte]
                            arg_count, hints, enum_map = get_arg_info(method_body)
                            track = determine_execution_track(method_body)
                            arg_names = [a.split('=')[0].strip() for a in method_params.strip("() ").split(',') if a.strip()]
                            domain_vars = extract_domain_variables(method_body)

                            session.run("""
                                MATCH (c:Class {fqn: $class_fqn})
                                MERGE (f:Function {fqn: $fqn})
                                ON CREATE SET f.optimized_dylib_path = "", f.needs_recompile = true, f.base_mlir_path = "", f.ai_transform_script_path = ""
                                ON MATCH SET f.needs_recompile = CASE WHEN f.code <> $code THEN true ELSE f.needs_recompile END,
                                             f.optimized_dylib_path = CASE WHEN f.code <> $code THEN "" ELSE f.optimized_dylib_path END,
                                             f.base_mlir_path = CASE WHEN f.code <> $code THEN "" ELSE f.base_mlir_path END,
                                             f.ai_transform_script_path = CASE WHEN f.code <> $code THEN "" ELSE f.ai_transform_script_path END
                                SET f.name = $name, 
                                    f.code = $code, 
                                    f.arg_count = $arg_count, 
                                    f.type_hints = $hints, 
                                    f.enum_map = $enums, 
                                    f.signature = $sig,
                                    f.execution_track = $track,
                                    f.domain_vars = $domain_vars
                                MERGE (c)-[:HAS_METHOD]->(f)
                            """, class_fqn=class_fqn, fqn=method_fqn, name=method_name, code=method_body, arg_count=arg_count, hints=json.dumps(hints), enums=json.dumps(enum_map), sig=json.dumps(arg_names), track=track, domain_vars=json.dumps(domain_vars))
                    elif child.type == "block":
                        find_methods(child)
            find_methods(class_info["node"])

        # Handle Global Functions
        func_captures = func_query.captures(tree.root_node)
        functions = []
        if isinstance(func_captures, dict):
            func_nodes = func_captures.get("func.node", [])
            for node in func_nodes: functions.append(node)
        else:
            for node, name in func_captures:
                if name == "func.node": functions.append(node)

        for f_node in functions:
            name_node = f_node.child_by_field_name('name')
            params_node = f_node.child_by_field_name('parameters')
            if not name_node or not params_node: continue
            
            f_name = name_node.text.decode('utf8')
            f_params = params_node.text.decode('utf8')
            f_code = source_code[f_node.start_byte:f_node.end_byte]
            
            arg_names = [a.split('=')[0].strip() for a in f_params.strip("() ").split(',') if a.strip()]
            arg_count, hints, _ = get_arg_info(f_code)
            track = determine_execution_track(f_code)
            domain_vars = extract_domain_variables(f_code)
            # USE NORMALIZED FQN
            fqn = normalize_fqn(file_path, f_name)
            
            session.run("""
                MATCH (m:Module {name: $module})
                MERGE (f:Function {fqn: $fqn})
                ON CREATE SET f.optimized_dylib_path = "", f.needs_recompile = true, f.base_mlir_path = "", f.ai_transform_script_path = ""
                ON MATCH SET f.needs_recompile = CASE WHEN f.code <> $code THEN true ELSE f.needs_recompile END,
                             f.optimized_dylib_path = CASE WHEN f.code <> $code THEN "" ELSE f.optimized_dylib_path END,
                             f.base_mlir_path = CASE WHEN f.code <> $code THEN "" ELSE f.base_mlir_path END,
                             f.ai_transform_script_path = CASE WHEN f.code <> $code THEN "" ELSE f.ai_transform_script_path END
                SET f.name = $name, 
                    f.code = $code, 
                    f.arg_count = $count, 
                    f.signature = $sig,
                    f.execution_track = $track,
                    f.domain_vars = $domain_vars
                MERGE (m)-[:CONTAINS]->(f)
            """, module=module_name, fqn=fqn, name=f_name, code=f_code, count=arg_count, sig=json.dumps(arg_names), track=track, domain_vars=json.dumps(domain_vars))

    print(f"✅ Ingested: {file_path}")

def ingest_folder(target_path):
    print(f"🚀 Starting Ingestion: {target_path}")
    
    # Check if target_path is an FQN rather than a filesystem path
    if not os.path.exists(target_path):
        import importlib.util
        import importlib
        try:
            # Try to resolve FQN to path by importing and checking __file__
            parts = target_path.split('.')
            for i in range(len(parts), 0, -1):
                mod_name = ".".join(parts[:i])
                try:
                    spec = importlib.util.find_spec(mod_name)
                    if spec and spec.origin:
                        target_path = spec.origin
                        print(f"      [Resolver] Resolved FQN {mod_name} to: {target_path}")
                        break
                except:
                    continue
        except Exception as e:
            print(f"      [Resolver] FQN Resolution Failed: {e}")

    if os.path.isfile(target_path):
        process_file(target_path)
    elif os.path.isdir(target_path):
        for root, _, files in os.walk(target_path):
            for file in files:
                if file.endswith(".py"):
                    process_file(os.path.join(root, file))
    else:
        print(f"⚠️ Error: Target '{target_path}' not found as file, directory, or FQN.")
        sys.exit(1)
    
    print("✅ Semantic Graph Ingestion Complete.")

if __name__ == "__main__":
    target = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_TARGET_DIR
    ingest_folder(target)
