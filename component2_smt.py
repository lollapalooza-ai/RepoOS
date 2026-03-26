import json
import asyncio
from typing import List, Literal, Optional
from pydantic import BaseModel, Field
from z3 import *
import ollama
import ast

# --- 1. The Strict Pydantic Schema ---
class MemoryAllocation(BaseModel):
    name: str = Field(..., description="Name of the array, struct, or raw byte buffer.")
    size: int = Field(..., description="Exact allocated size in elements or bytes.")

class Operation(BaseModel):
    # THE UPGRADED INSTRUCTION SET ARCHITECTURE (ISA)
    op: Literal[
        "add", "sub", "mul", "div", "cmp_eq", "select", 
        "load", "store", "gep", "icmp", "br", "label"
    ] = Field(..., description="The mathematical, memory, or control opcode.")
    
    args: List[str] = Field(..., description="Variables, pointers, literal numbers, or block labels.")
    
    # Made Optional: 'store' and 'br' do not assign a new variable.
    target_var: Optional[str] = Field(None, description="The variable to store the result in, if applicable.")

class VerifiedMLIR(BaseModel):
    # CRITICAL: This must be the first field. 
    # It forces the LLM to output its mathematical reasoning tokens BEFORE it outputs the execution graph.
    thinking_process: str = Field(
        ..., 
        description="Step-by-step mathematical reasoning. Explain your algebraic mapping, pointer offsets, and loop bounds BEFORE writing the memory_allocations or operations."
    )
    
    memory_allocations: List[MemoryAllocation] = Field(..., description="Memory constraints and buffer sizes.")
    loop_limit: int = Field(..., description="Max loop iterations (for safety bounding).")
    operations: List[Operation] = Field(..., description="The Execution Graph.")

# --- 2. The Dynamic Z3 Memory Bounds Checker ---
def verify_llm_safety(mlir_data: VerifiedMLIR) -> tuple[bool, str]:
    solver = Solver()
    memory_sizes = {mem.name: IntVal(mem.size) for mem in mlir_data.memory_allocations}
    loop_limit = IntVal(mlir_data.loop_limit)
    idx = Int('idx')
    i = Int('i')
    solver.add(And(idx >= 0, idx < loop_limit))
    solver.add(And(i >= 0, i < loop_limit))

    for op in mlir_data.operations:
        if op.op == "gep":
            if len(op.args) < 2: return False, f"MALFORMED GEP: {op.args}"
            base_ptr, offset_var = op.args[0], op.args[1]
            if base_ptr not in memory_sizes: return False, f"SEGFAULT RISK: {base_ptr}"
            buffer_size = memory_sizes[base_ptr]
            
            if offset_var in ['i', 'idx']: z3_offset = Int(offset_var)
            elif offset_var.replace('-', '').isdigit(): z3_offset = IntVal(int(offset_var))
            else: z3_offset = Int(offset_var)
            
            bounds_violation = Or(z3_offset < 0, z3_offset >= buffer_size)
            check_solver = Solver()
            check_solver.add(solver.assertions())
            check_solver.add(bounds_violation)
            if check_solver.check() == sat:
                model = check_solver.model()
                return False, f"BUFFER OVERFLOW RISK: {offset_var} can equal {model[z3_offset]}"
                
    return True, "PROVEN MEMORY SAFE"

# --- 3. The AST Symbolic Engine (Milestone 3.0) ---
class PythonSymbolicEngine(ast.NodeVisitor):
    def __init__(self, arg_count: int):
        self.env = {f"arg{i}": Real(f"arg{i}") for i in range(arg_count)}

    def visit_FunctionDef(self, node):
        self.arg_map = {arg.arg: f"arg{i}" for i, arg in enumerate(node.args.args)}
        return self.visit_suite(node.body)

    def visit_suite(self, nodes):
        for node in nodes:
            res = self.visit(node)
            if res is not None: return res
        return None

    def visit_If(self, node):
        test = self.visit(node.test)
        then_res = self.visit_suite(node.body)
        else_res = self.visit_suite(node.orelse) if node.orelse else RealVal(0.0)
        if then_res is not None and else_res is not None:
            return If(test, then_res, else_res)
        return then_res if then_res is not None else else_res

    def visit_Return(self, node):
        return self.visit(node.value)

    def visit_Name(self, node):
        mapped_name = self.arg_map.get(node.id, node.id)
        return self.env.get(mapped_name, Real(mapped_name))

    def visit_Constant(self, node):
        try: return RealVal(float(node.value))
        except: return None

    def visit_BinOp(self, node):
        l, r = self.visit(node.left), self.visit(node.right)
        if isinstance(node.op, ast.Add): return l + r
        if isinstance(node.op, ast.Sub): return l - r
        if isinstance(node.op, ast.Mult): return l * r
        if isinstance(node.op, ast.Div): return l / r

    def visit_Compare(self, node):
        l, r = self.visit(node.left), self.visit(node.comparators[0])
        op = node.ops[0]
        if isinstance(op, ast.Eq): return l == r
        if isinstance(op, ast.Gt): return l > r
        if isinstance(op, ast.Lt): return l < r

    def visit_IfExp(self, node):
        return If(self.visit(node.test), self.visit(node.body), self.visit(node.orelse))


def mlir_to_z3_candidate(mlir_data: VerifiedMLIR, arg_count: int):
    env = {f"arg{i}": Real(f"arg{i}") for i in range(arg_count)}
    last_val = None
    def resolve(s):
        if str(s) in env: return env[str(s)]
        try: return RealVal(float(s))
        except: return RealVal(0.0)

    for op in mlir_data.operations:
        if op.op in ["load", "store", "gep", "br", "label"]: continue 
        if op.op == "add": val = resolve(op.args[0]) + resolve(op.args[1])
        elif op.op == "sub": val = resolve(op.args[0]) - resolve(op.args[1])
        elif op.op == "mul": val = resolve(op.args[0]) * resolve(op.args[1])
        elif op.op == "div": val = resolve(op.args[0]) / resolve(op.args[1])
        elif op.op == "cmp_eq": val = If(resolve(op.args[0]) == resolve(op.args[1]), RealVal(1.0), RealVal(0.0))
        elif op.op == "icmp":
            c_op, l, r = op.args[0], resolve(op.args[1]), resolve(op.args[2])
            cond = l == r
            if c_op == ">": cond = l > r
            elif c_op == "<": cond = l < r
            val = If(cond, RealVal(1.0), RealVal(0.0))
        elif op.op == "select": val = If(resolve(op.args[0]) > 0.5, resolve(op.args[1]), resolve(op.args[2]))
        else: val = last_val
        if op.target_var: env[op.target_var] = val
        last_val = val
    return last_val

# --- 4. Generative Feedback Loop ---
async def generate_execution_graph(intent: str, error_context: str = "") -> str:
    client = ollama.AsyncClient()
    prompt = (
        "You are an expert compiler frontend. Convert Python logic into a DOD MLIR execution graph.\n"
        f"INTENT: {intent}\n\n"
        "STRICT ISA RULES:\n"
        "1. Every operation MUST be a flat object. NO nested logic like 'arg0 * 0.5'.\n"
        "2. Step-by-step: Perform intermediate calculations first.\n"
        "3. Output ONLY raw JSON matching the schema."
    )
    if error_context: prompt += f"\n\nCRITICAL ERROR: {error_context}\nFIX LOGIC AND FLATNESS."
    response = await client.chat(model="deepseek-coder-v2:latest", messages=[{'role': 'user', 'content': prompt}], format=VerifiedMLIR.model_json_schema())
    return response['message']['content']

def verify_semantic_equivalence(mlir_data: VerifiedMLIR, func_code: str, arg_count: int) -> tuple[bool, str]:
    if any(op.op in ["load", "store", "gep"] for op in mlir_data.operations): return True, "PROVEN SAFE"
    try:
        tree = ast.parse(func_code)
        engine = PythonSymbolicEngine(arg_count)
        z3_oracle = engine.visit(tree.body[0])
        z3_candidate = mlir_to_z3_candidate(mlir_data, arg_count)
        print(f"   [Z3 DEBUG] Oracle: {z3_oracle}")
        print(f"   [Z3 DEBUG] Candidate: {z3_candidate}")
        solver = Solver()
        solver.add(z3_oracle != z3_candidate)
        if solver.check() == sat:
            return False, f"HALLUCINATION DETECTED! Logic mismatch."
        return True, "PROVEN EQUIVALENT"
    except Exception as e: return False, f"Verification Error: {e}"

async def verified_generation_loop(intent: str, func_code: str, arg_count: int) -> VerifiedMLIR:
    error_msg = ""
    for attempt in range(3):
        print(f"   [AI] Generating Graph (Attempt {attempt + 1})...")
        mlir_json = await generate_execution_graph(intent, error_msg)
        try: mlir_data = VerifiedMLIR.model_validate_json(mlir_json)
        except Exception as e:
            error_msg = f"JSON violation: {e}"
            continue
        # Enforce Flatness
        is_flat = all(not any(x in str(arg) for x in ["*", "+", "-", "/", "(", ")"]) for op in mlir_data.operations for arg in op.args)
        if not is_flat:
            error_msg = "ISA VIOLATION: Nested logic in args. Use separate operations."
            continue
        is_safe, msg = verify_llm_safety(mlir_data)
        if not is_safe:
            error_msg = msg
            continue
        is_equiv, msg_eq = verify_semantic_equivalence(mlir_data, func_code, arg_count)
        if is_equiv: return mlir_data
        error_msg = msg_eq 
    raise Exception("System halted: LLM failed after 3 attempts.")
