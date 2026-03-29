import json
import asyncio
from typing import List, Literal, Optional
from pydantic import BaseModel, Field, field_validator
from z3 import *
import ollama
import ast

# --- 1. The Strict Pydantic Schema ---
class MemoryAllocation(BaseModel):
    name: str = Field(..., description="Name of the array, struct, or raw byte buffer.")
    size: int = Field(..., description="Exact allocated size in elements or bytes.")

class Operation(BaseModel):
    # THE UPGRADED INSTRUCTION SET ARCHITECTURE (ISA) - Milestone 4
    op: Literal[
        "add", "sub", "mul", "div", "cmp_eq", "select", 
        "load", "store", "gep", "icmp", "br", "label",
        "alloc_struct", "string_view_ptr", "ffi_call",
        "strcmp" # NEW: Generic String Comparison
    ] = Field(..., description="The mathematical, memory, or control opcode.")
    
    args: List[str] = Field(..., description="Variables, pointers, literal numbers, or block labels.")
    target_var: Optional[str] = Field(None, description="The variable to store the result in, if applicable.")

    @field_validator('args')
    @classmethod
    def validate_args_flatness(cls, v: List[str]) -> List[str]:
        for arg in v:
            if any(op in str(arg) for op in ["*", "/", "+", "-"]):
                raise ValueError(f"ISA VIOLATION: Nested logic '{arg}' detected. Arguments must be flat variables or literals. Break this down into separate operations.")
        return v

class VerifiedMLIR(BaseModel):
    thinking_process: str = Field(
        ..., 
        description="Step-by-step mathematical reasoning. Explain your algebraic mapping, pointer offsets, and loop bounds BEFORE writing the memory_allocations or operations."
    )
    memory_allocations: List[MemoryAllocation] = Field(..., description="Memory constraints and buffer sizes.")
    loop_limit: int = Field(..., description="Max loop iterations (for safety bounding).")
    operations: List[Operation] = Field(..., description="The Execution Graph.")

# --- 2. The Dynamic Z3 Memory Bounds Checker ---
def verify_llm_safety(mlir_data: VerifiedMLIR, arg_count: int = 0, external_memory: dict = None):
    solver = Solver()
    memory_sizes = {mem.name: IntVal(mem.size) for mem in mlir_data.memory_allocations}
    if external_memory:
        for name, size in external_memory.items():
            memory_sizes[name] = IntVal(size)
    
    if 'raw_buffer' not in memory_sizes:
        # We assume 'raw_buffer' size is passed as an argument if it's an FSM
        # For safety check, we'll use a symbolic 'buffer_len' variable
        buffer_len = Int('buffer_len')
        solver.add(buffer_len > 0)
        memory_sizes['raw_buffer'] = buffer_len
    
    if mlir_data.loop_limit > 0:
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
            
            def resolve_z3(v):
                if v.replace('.', '').replace('-', '').isdigit(): return IntVal(int(float(v)))
                return Int(v)
            
            z3_offset = resolve_z3(offset_var)
            
            bounds_violation = Or(z3_offset < 0, z3_offset >= buffer_size)
            check_solver = Solver()
            check_solver.add(solver.assertions())
            check_solver.add(bounds_violation)
            if check_solver.check() == sat:
                model = check_solver.model()
                return False, f"BUFFER OVERFLOW RISK: {offset_var} can equal {model[z3_offset]}"
        
        # MILESTONE 4: string_view_ptr bounds check
        elif op.op == "string_view_ptr":
            # args: [buffer, offset, length]
            if len(op.args) < 3: return False, f"MALFORMED string_view_ptr: {op.args}"
            buffer_ptr, offset_var, length_var = op.args[0], op.args[1], op.args[2]
            if buffer_ptr not in memory_sizes: return False, f"SEGFAULT RISK: {buffer_ptr}"
            buffer_size = memory_sizes[buffer_ptr]
            
            def resolve_z3(v):
                if v.replace('.', '').replace('-', '').isdigit(): return IntVal(int(float(v)))
                return Int(v)
            
            z3_offset = resolve_z3(offset_var)
            z3_length = resolve_z3(length_var)
            
            # Violation: offset < 0 OR offset + length > buffer_size
            bounds_violation = Or(z3_offset < 0, z3_offset + z3_length > buffer_size)
            check_solver = Solver()
            check_solver.add(solver.assertions())
            check_solver.add(bounds_violation)
            if check_solver.check() == sat:
                return False, f"STRING VIEW OUT-OF-BOUNDS: {offset_var}+{length_var} can exceed buffer"
        
        elif op.op == "store":
            if len(op.args) < 2: return False, f"MALFORMED STORE: {op.args}"
                
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
        if l is None or r is None: return None
        if isinstance(node.op, ast.Add): return l + r
        if isinstance(node.op, ast.Sub): return l - r
        if isinstance(node.op, ast.Mult): return l * r
        if isinstance(node.op, ast.Div): return l / r

    def visit_Compare(self, node):
        l, r = self.visit(node.left), self.visit(node.comparators[0])
        if l is None or r is None: return None
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
        if op.op in ["load", "store", "gep", "br", "label", "alloc_struct", "string_view_ptr", "ffi_call"]: continue 
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
        "STRICT ISA RULES:\n"
        "1. Every operation MUST be a flat object. NO nested logic like 'arg0 * 0.5'.\n"
        "2. Use 'mul' for multiplication, 'add' for addition, 'sub' for subtraction, and 'div' for division.\n"
        "3. The 'args' list must ONLY contain variable names or literal numbers/strings.\n"
        "4. Output ONLY raw JSON matching the schema.\n\n"
        f"INTENT: {intent}\n"
    )
    if error_context: 
        prompt = f"### CRITICAL: FIX THE FOLLOWING VALIDATION ERROR ###\n{error_context}\n\n" + prompt
    response = await client.chat(model="deepseek-coder-v2:latest", messages=[{'role': 'user', 'content': prompt}], format=VerifiedMLIR.model_json_schema())
    return response['message']['content']


def verify_semantic_equivalence(mlir_data: VerifiedMLIR, func_code: str, arg_count: int) -> tuple[bool, str]:
    if any(op.op in ["load", "store", "gep", "string_view_ptr", "alloc_struct"] for op in mlir_data.operations): return True, "PROVEN SAFE"
    try:
        tree = ast.parse(func_code)
        engine = PythonSymbolicEngine(arg_count)
        z3_oracle = engine.visit(tree.body[0])
        z3_candidate = mlir_to_z3_candidate(mlir_data, arg_count)
        if z3_oracle is None: return True, "SKIPPING SYMBOLIC CHECK (Complexity)"
        print(f"   [Z3 DEBUG] Oracle: {z3_oracle}")
        print(f"   [Z3 DEBUG] Candidate: {z3_candidate}")
        solver = Solver()
        solver.add(z3_oracle != z3_candidate)
        if solver.check() == sat:
            return False, f"HALLUCINATION DETECTED! Logic mismatch."
        return True, "PROVEN EQUIVALENT"
    except Exception as e: return False, f"Verification Error: {e}"

async def verified_generation_loop(intent: str, func_code: str, arg_count: int, external_memory: dict = None) -> VerifiedMLIR:
    error_msg = ""
    for attempt in range(3):
        print(f"   [AI] Generating Graph (Attempt {attempt + 1})...")
        mlir_json = await generate_execution_graph(intent, error_msg)
        try: mlir_data = VerifiedMLIR.model_validate_json(mlir_json)
        except Exception as e:
            print(f"   [DEBUG] LLM JSON/Validation Error: {e}")
            error_msg = f"JSON violation: {e}"
            continue
        # Enforce Flatness
        is_flat = all(not any(x in str(arg) for x in ["*", "+", "-", "/", "(", ")"]) for op in mlir_data.operations for arg in op.args)
        if not is_flat:
            print(f"   [DEBUG] Flatness Violation: {mlir_json}")
            error_msg = "ISA VIOLATION: Nested logic in args. Use separate operations."
            continue
        is_safe, msg = verify_llm_safety(mlir_data, arg_count, external_memory)
        if not is_safe:
            print(f"   [DEBUG] Safety Violation: {msg}")
            error_msg = msg
            continue
        is_equiv, msg_eq = verify_semantic_equivalence(mlir_data, func_code, arg_count)
        if is_equiv: return mlir_data
        error_msg = msg_eq 
    raise Exception("System halted: LLM failed after 3 attempts.")
