import sys
import os
import ast
import json
from typing import List, Dict, Any, Optional
from ast_to_mlir import DeterministicMLIRBuilder # <-- NEW
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

class PureLogicChunker(ast.NodeVisitor):
    def __init__(self, type_hints: Dict[str, str] = None):
        self.chunks = []       # List of valid code chunks
        self.current_chunk = [] # Current contiguous pure block
        self.inputs = set()    # Variables read from outside the chunk
        self.outputs = set()   # Variables mutated inside the chunk
        self.local_vars = set()
        self.type_hints = type_hints or {}

    def _flush_chunk(self):
        """Saves the current pure block, lowers it to MLIR, and resets."""
        if self.current_chunk:
            code = "\n".join([ast.unparse(n) for n in self.current_chunk])
            inputs = list(self.inputs - self.local_vars)
            outputs = list(self.outputs)
            
            # --- NEW: Deterministic Lowering ---
            try:
                # Wrap the chunk in a dummy function AST to process it
                chunk_ast = ast.parse(code)
                builder = DeterministicMLIRBuilder(function_name="chunk", args=inputs, type_hints=self.type_hints)
                builder.visit(chunk_ast)
                
                # Use the builder's build() method to get a VerifiedMLIR object
                verified_mlir = builder.build(chunk_ast)
                baseline_mlir_json = verified_mlir.model_dump_json()
            except Exception as e:
                print(f"Warning: Deterministic lowering failed for chunk, storing empty baseline. Error: {e}")
                baseline_mlir_json = "{}"
            # -----------------------------------

            self.chunks.append({
                "code": code,
                "inputs": inputs,
                "outputs": outputs,
                "baseline_mlir": baseline_mlir_json # <-- NEW payload
            })
            self.current_chunk = []
            self.inputs = set()
            self.outputs = set()
            self.local_vars = set()

    def is_pure(self, node):
        """Heuristic: Is this node safe for MLIR compilation?"""
        ALLOWED_BUILTINS = {'sum', 'len', 'range', 'abs', 'round', 'min', 'max', 'enumerate', 'zip'}
        for child in ast.walk(node):
            if isinstance(child, ast.Call):
                if isinstance(child.func, ast.Name):
                    if child.func.id in ALLOWED_BUILTINS:
                        continue
                elif isinstance(child.func, ast.Attribute):
                    obj_name = ast.unparse(child.func.value)
                    attr_name = child.func.attr
                    if attr_name == 'append' or obj_name == 'math' or obj_name == 'np':
                        continue
                return False
            if isinstance(child, (ast.Yield, ast.YieldFrom, ast.ListComp, ast.DictComp)):
                return False
        return True

    def extract_io(self, node):
        """Finds which variables are read (inputs) and written (outputs)."""
        for child in ast.walk(node):
            if isinstance(child, ast.Name):
                if isinstance(child.ctx, ast.Store):
                    self.outputs.add(child.id)
                    self.local_vars.add(child.id)
                elif isinstance(child.ctx, ast.Load):
                    self.inputs.add(child.id)

    def visit_FunctionDef(self, node):
        # We only want to chunk the body, not the def signature
        for stmt in node.body:
            if isinstance(stmt, (ast.Assign, ast.AugAssign, ast.For, ast.If, ast.While, ast.Return, ast.Expr)) and self.is_pure(stmt):
                self.current_chunk.append(stmt)
                self.extract_io(stmt)
            else:
                # We hit an impure statement. Break the chunk.
                self._flush_chunk()
        
        # Flush any remaining lines at the end of the function
        self._flush_chunk()

def extract_data_intents(source_code):
    """
    Scans the AST for dictionary access patterns like order['items'] or user['id'].
    """
    try:
        tree = ast.parse(source_code)
        visitor = DataIntentVisitor()
        visitor.visit(tree)
        unique_paths = list(set(tuple(p) for p in visitor.paths))
        return [list(p) for p in unique_paths]
    except Exception:
        return []

class DataIntentVisitor(ast.NodeVisitor):
    def __init__(self):
        self.paths = []

    def visit_Subscript(self, node):
        if isinstance(node.slice, ast.Constant) and isinstance(node.slice.value, str):
            path = []
            curr = node
            while isinstance(curr, ast.Subscript) and isinstance(curr.slice, ast.Constant):
                path.insert(0, curr.slice.value)
                curr = curr.value
            if isinstance(curr, ast.Name):
                path.insert(0, curr.id)
                self.paths.append(path)
        self.generic_visit(node)

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

def process_file(file_path, forced_module_name=None):
    with open(file_path, 'r', encoding='utf-8') as f:
        source_code = f.read()
    
    data_paths = extract_data_intents(source_code)
    tree = parser.parse(bytes(source_code, "utf8"))
    class_query = PY_LANGUAGE.query("(class_definition name: (identifier) @class.name) @class.node")
    func_query = PY_LANGUAGE.query("(function_definition name: (identifier) @func.name) @func.node")
    
    if forced_module_name:
        module_name = forced_module_name
    else:
        module_name = file_path.replace('./', '').replace('/', '.').replace('.py', '')
        if module_name.startswith('.'): module_name = module_name[1:]
    
    with driver.session() as session:
        session.run("""
            MERGE (m:Module {name: $module})
            SET m.path = $path, m.access_paths = $paths
        """, module=module_name, path=file_path, paths=[json.dumps(p) for p in data_paths])

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
                            method_fqn = f"{class_fqn}.{method_name}"
                            method_body = source_code[child.start_byte:child.end_byte]
                            arg_count, hints, enum_map = get_arg_info(method_body)
                            arg_names = [a.split('=')[0].strip() for a in method_params.strip("() ").split(',') if a.strip()]
                            
                            # CHUNKING
                            chunker = PureLogicChunker(type_hints=hints)
                            try:
                                f_ast = ast.parse(method_body)
                                chunker.visit(f_ast)
                            except: pass

                            session.run("""
                                MATCH (c:Class {fqn: $class_fqn})
                                MERGE (f:Function {fqn: $fqn})
                                SET f.name = $name, f.code = $code, f.arg_count = $arg_count, f.type_hints = $hints, f.enum_map = $enums, f.signature = $sig
                                MERGE (c)-[:HAS_METHOD]->(f)
                            """, class_fqn=class_fqn, fqn=method_fqn, name=method_name, code=method_body, arg_count=arg_count, hints=json.dumps(hints), enums=json.dumps(enum_map), sig=json.dumps(arg_names))
                            
                            for i, chunk_data in enumerate(chunker.chunks):
                                chunk_fqn = f"{method_fqn}.chunk_{i}"
                                session.run("""
                                    MATCH (f:Function {fqn: $parent_fqn})
                                    MERGE (ch:Chunk {fqn: $chunk_fqn})
                                    SET ch.code = $code, 
                                        ch.inputs = $inputs, 
                                        ch.outputs = $outputs, 
                                        ch.index = $index,
                                        ch.baseline_mlir = $baseline_mlir
                                    MERGE (f)-[:HAS_CHUNK]->(ch)
                                """, parent_fqn=method_fqn, chunk_fqn=chunk_fqn, code=chunk_data["code"], 
                                     inputs=json.dumps(chunk_data["inputs"]), 
                                     outputs=json.dumps(chunk_data["outputs"]), 
                                     index=i,
                                     baseline_mlir=chunk_data["baseline_mlir"])

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
            fqn = f"{module_name}.{f_name}"
            
            # CHUNKING
            chunker = PureLogicChunker(type_hints=hints)
            try:
                f_ast = ast.parse(f_code)
                chunker.visit(f_ast)
            except: pass

            session.run("""
                MATCH (m:Module {name: $module})
                MERGE (f:Function {fqn: $fqn})
                SET f.name = $name, f.code = $code, f.arg_count = $count, f.signature = $sig
                MERGE (m)-[:CONTAINS]->(f)
            """, module=module_name, fqn=fqn, name=f_name, code=f_code, count=arg_count, sig=json.dumps(arg_names))

            for i, chunk_data in enumerate(chunker.chunks):
                chunk_fqn = f"{fqn}.chunk_{i}"
                session.run("""
                    MATCH (f:Function {fqn: $parent_fqn})
                    MERGE (ch:Chunk {fqn: $chunk_fqn})
                    SET ch.code = $code, 
                        ch.inputs = $inputs, 
                        ch.outputs = $outputs, 
                        ch.index = $index,
                        ch.baseline_mlir = $baseline_mlir
                    MERGE (f)-[:HAS_CHUNK]->(ch)
                """, parent_fqn=fqn, chunk_fqn=chunk_fqn, code=chunk_data["code"], 
                     inputs=json.dumps(chunk_data["inputs"]), 
                     outputs=json.dumps(chunk_data["outputs"]), 
                     index=i,
                     baseline_mlir=chunk_data["baseline_mlir"])

    print(f"✅ Ingested: {file_path}")

def ingest_folder(target_path):
    print(f"🚀 Starting Ingestion: {target_path}")
    if os.path.isfile(target_path):
        process_file(target_path)
    else:
        for root, _, files in os.walk(target_path):
            for file in files:
                if file.endswith(".py"):
                    process_file(os.path.join(root, file))
    print("✅ Semantic Graph Ingestion Complete.")

if __name__ == "__main__":
    target = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_TARGET_DIR
    ingest_folder(target)
