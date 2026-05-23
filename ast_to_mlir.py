import ast
from pydantic import BaseModel
from typing import List, Dict, Any, Optional
from component2_smt import MLIROperation, VerifiedMLIR

class DeterministicMLIRBuilder(ast.NodeVisitor):
    def __init__(self, function_name: str, args: List[str], type_hints: Dict[str, str] = None):
        self.operations = []
        self.env = {}
        self.var_counter = 0
        self.function_name = function_name
        self.type_hints = type_hints or {}
        self.signature = {}
        
        for arg in args:
            # Map Python types to MLIR Dialect types
            py_hint = self.type_hints.get(arg, "float").lower() # Default fallback
            if "int" in py_hint or py_hint == "index":
                self.signature[arg] = "i64"
            elif any(t in py_hint for t in ["list", "ndarray", "dict", "ptr", "graph"]):
                self.signature[arg] = "ptr"
            else:
                self.signature[arg] = "f64"

        self.signature["return"] = "f64"
        self.arg_names = args
        for i, arg in enumerate(args):
            self.env[arg] = f"%arg{i}"

    def new_var(self):
        self.var_counter += 1
        return f"%{self.var_counter}"

    def visit_BinOp(self, node):
        left_var = self.visit(node.left)
        right_var = self.visit(node.right)
        
        if left_var is None or right_var is None:
            # Fallback if a sub-visit failed or returned None
            raise ValueError(f"Failed to resolve operands for BinOp: {ast.dump(node)}")

        target = self.new_var()
        
        op_map = {
            ast.Add: "addf", 
            ast.Sub: "subf", 
            ast.Mult: "mulf", 
            ast.Div: "divf"
        }
        mlir_op = op_map.get(type(node.op))
        
        if not mlir_op:
            # Fallback for integer/index ops if needed
            int_op_map = {
                ast.Add: "addi",
                ast.Sub: "subi",
                ast.Mult: "muli",
                ast.Div: "divi"
            }
            mlir_op = int_op_map.get(type(node.op))
            dialect = "arith"
        else:
            dialect = "arith"

        if not mlir_op:
            raise NotImplementedError(f"Op {type(node.op)} not supported deterministically yet.")

        self.operations.append(
            MLIROperation(
                dialect=dialect, op=mlir_op, args=[left_var, right_var], target_var=target
            )
        )
        return target

    def visit_Name(self, node):
        if node.id in self.env:
            return self.env[node.id]
        return f"%{node.id}"

    def visit_Constant(self, node):
        target = self.new_var()
        val = node.value
        dtype = "f64"
        if isinstance(val, int):
            dtype = "i64"
        elif isinstance(val, float):
            dtype = "f64"
        elif isinstance(val, str):
            dtype = "ptr" # String constant placeholder
        
        self.operations.append(
            MLIROperation(
                dialect="arith", op="constant", args=[str(val)], target_var=target,
                attributes={"type": dtype}
            )
        )
        return target

    def generic_visit(self, node):
        """Called if no explicit visitor function exists for a node."""
        for field, value in ast.iter_fields(node):
            if isinstance(value, list):
                for item in value:
                    if isinstance(item, ast.AST):
                        self.visit(item)
            elif isinstance(value, ast.AST):
                self.visit(value)
        return f"%unhandled_{type(node).__name__}"

    def visit_Assign(self, node):
        value_var = self.visit(node.value)
        if value_var is None: return None
        for target in node.targets:
            if isinstance(target, ast.Name):
                self.env[target.id] = value_var
            elif isinstance(target, ast.Subscript):
                # memref.store
                memref_name = self.visit(target.value)
                index_var = self.visit(target.slice)
                if memref_name and index_var:
                    self.operations.append(
                        MLIROperation(
                            dialect="memref", op="store", args=[value_var, memref_name, index_var]
                        )
                    )
        return value_var

    def visit_AugAssign(self, node):
        # x += 1 -> x = x + 1
        target_node = node.target
        value_node = node.value
        
        left = self.visit(target_node)
        right = self.visit(value_node)
        
        if left is None or right is None: return None
        
        res_var = self.new_var()
        op_map = {ast.Add: "addf", ast.Sub: "subf", ast.Mult: "mulf", ast.Div: "divf"}
        mlir_op = op_map.get(type(node.op), "addf")
        
        self.operations.append(
            MLIROperation(dialect="arith", op=mlir_op, args=[left, right], target_var=res_var)
        )
        
        if isinstance(target_node, ast.Name):
            self.env[target_node.id] = res_var
        elif isinstance(target_node, ast.Subscript):
            memref_name = self.visit(target_node.value)
            index_var = self.visit(target_node.slice)
            self.operations.append(
                MLIROperation(dialect="memref", op="store", args=[res_var, memref_name, index_var])
            )
        return res_var

    def visit_Subscript(self, node):
        # memref.load
        memref_name = self.visit(node.value)
        index_var = self.visit(node.slice)
        target = self.new_var()
        self.operations.append(
            MLIROperation(
                dialect="memref", op="load", args=[memref_name, index_var], target_var=target
            )
        )
        return target

    def visit_If(self, node):
        test_var = self.visit(node.test)
        
        # We need to capture operations for then/else blocks
        old_ops = self.operations
        self.operations = []
        for stmt in node.body:
            self.visit(stmt)
        then_ops = self.operations
        
        self.operations = []
        for stmt in node.orelse:
            self.visit(stmt)
        else_ops = self.operations
        
        self.operations = old_ops
        self.operations.append(
            MLIROperation(
                dialect="scf", op="if", args=[test_var],
                then=then_ops,
                else_=else_ops
            )
        )

    def visit_For(self, node):
        # Simplified: assumes range(start, stop, step) or similar
        if isinstance(node.iter, ast.Call) and isinstance(node.iter.func, ast.Name) and node.iter.func.id == "range":
            # For range() we want the values to be index type
            def get_index_val(arg_node):
                if isinstance(arg_node, ast.Constant) and isinstance(arg_node.value, int):
                    target = self.new_var()
                    self.operations.append(
                        MLIROperation(
                            dialect="arith", op="constant", args=[str(arg_node.value)], 
                            target_var=target, attributes={"type": "index"}
                        )
                    )
                    return target
                return self.visit(arg_node)

            range_args = [get_index_val(arg) for arg in node.iter.args]
            
            if len(range_args) == 1:
                # range(stop) -> for i = 0 to stop step 1
                c0 = self.new_var()
                self.operations.append(MLIROperation(dialect="arith", op="constant", args=["0"], target_var=c0, attributes={"type": "index"}))
                c1 = self.new_var()
                self.operations.append(MLIROperation(dialect="arith", op="constant", args=["1"], target_var=c1, attributes={"type": "index"}))
                lower, upper, step = c0, range_args[0], c1
            elif len(range_args) == 2:
                c1 = self.new_var()
                self.operations.append(MLIROperation(dialect="arith", op="constant", args=["1"], target_var=c1, attributes={"type": "index"}))
                lower, upper, step = range_args[0], range_args[1], c1
            else:
                lower, upper, step = range_args[0], range_args[1], range_args[2]
        else:
            # Fallback for generic iterators
            lower = self.new_var()
            upper = self.new_var()
            step = self.new_var()
            self.operations.append(MLIROperation(dialect="arith", op="constant", args=["0"], target_var=lower, attributes={"type": "index"}))
            self.operations.append(MLIROperation(dialect="arith", op="constant", args=["10"], target_var=upper, attributes={"type": "index"}))
            self.operations.append(MLIROperation(dialect="arith", op="constant", args=["1"], target_var=step, attributes={"type": "index"}))

        iter_var = f"%{node.target.id}"
        self.env[node.target.id] = iter_var
        
        old_ops = self.operations
        self.operations = []
        for stmt in node.body:
            self.visit(stmt)
        body_ops = self.operations
        
        self.operations = old_ops
        self.operations.append(
            MLIROperation(
                dialect="scf", op="for", args=[lower, upper, step],
                attributes={"body_args": [iter_var]},
                body=body_ops
            )
        )

    def visit_Compare(self, node):
        left = self.visit(node.left)
        ops = []
        for op, comparator in zip(node.ops, node.comparators):
            right = self.visit(comparator)
            target = self.new_var()
            
            # Simple heuristic for float vs int comparison
            # In MLIR, cmpf is for floats, cmpi is for integers/indices
            is_float = any(x in str(left).lower() or x in str(right).lower() for x in ["%arg", "float", "f64"])
            mlir_op = "cmpf" if is_float else "cmpi"
            
            # Predicate mapping (MLIR arith dialect)
            # Eq -> 0 (cmpi) or 1 (cmpf)
            # Gt -> 4 (cmpi) or 4 (cmpf)
            pred_map = {
                ast.Eq: 0 if mlir_op == "cmpi" else 1,
                ast.Gt: 4,
                ast.Lt: 2
            }
            predicate = pred_map.get(type(op), 0)
            
            self.operations.append(
                MLIROperation(
                    dialect="arith", op=mlir_op, args=[left, right], target_var=target,
                    attributes={"predicate": predicate, "op_name": type(op).__name__}
                )
            )
            ops.append(target)
            left = target # For chained comparisons
        return ops[-1]

    def visit_UnaryOp(self, node):
        operand = self.visit(node.operand)
        if isinstance(node.op, ast.USub):
            # 0.0 - operand
            c0 = self.new_var()
            self.operations.append(MLIROperation(dialect="arith", op="constant", args=["0.0"], target_var=c0, attributes={"type": "f64"}))
            target = self.new_var()
            self.operations.append(MLIROperation(dialect="arith", op="subf", args=[c0, operand], target_var=target))
            return target
        return operand

    def visit_Attribute(self, node):
        value = self.visit(node.value)
        return f"{value}.{node.attr}"

    def visit_Call(self, node):
        func_name = ast.unparse(node.func)
        args = [self.visit(arg) for arg in node.args]
        
        # Built-in handling
        if func_name == "len":
            target = self.new_var()
            # For MLIR, len often needs to be a memref dim or a pre-calculated value
            # Here we just emit a placeholder 'len' op that the AOT can lower
            self.operations.append(MLIROperation(dialect="arith", op="constant", args=["0"], target_var=target, attributes={"type": "index", "note": f"len({args[0]})"}))
            return target
        
        target = self.new_var()
        self.operations.append(
            MLIROperation(dialect="func", op="call", args=[func_name] + args, target_var=target)
        )
        return target

    def visit_Return(self, node):
        val = self.visit(node.value)
        self.operations.append(
            MLIROperation(dialect="func", op="return", args=[val])
        )
        return val

    def build(self, tree) -> VerifiedMLIR:
        self.visit(tree)
        return VerifiedMLIR(
            function_name=self.function_name,
            signature={f"arg{i}": "f64" for i in range(len(self.arg_names))},
            arg_mapping=[[name] for name in self.arg_names],
            operations=self.operations
        )

def python_to_deterministic_mlir(code: str, function_name: str, args: List[str], type_hints: Dict[str, str] = None) -> VerifiedMLIR:
    tree = ast.parse(code)
    # Find the function definition
    for node in ast.walk(tree):
        if isinstance(node, ast.FunctionDef) and node.name == function_name:
            builder = DeterministicMLIRBuilder(function_name, args, type_hints=type_hints)
            return builder.build(node)
    raise ValueError(f"Function {function_name} not found in code.")
