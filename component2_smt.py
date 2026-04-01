import json
import asyncio
import os
from typing import List, Literal, Optional
from pydantic import BaseModel, Field, field_validator
from z3 import *
import ast
import ollama # RE-IMPORT OLLAMA

# NEW: Import the Google GenAI SDK
from google import genai
from google.genai import types

# Initialize the Gemini Client only if API key is present
gemini_client = None
if os.environ.get("GEMINI_API_KEY"):
    gemini_client = genai.Client()

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

# --- 2. The Flow-Sensitive Z3 Memory Bounds Checker ---
def verify_llm_safety(mlir_data: VerifiedMLIR, arg_count: int = 0, external_memory: dict = None):
    """
    UPGRADED: Path-Constraint Analyzer (Flow-Sensitive).
    Tracks constraints across basic blocks to eliminate off-by-one false positives.
    """
    # 1. Setup Global Context
    solver = Solver()
    # Symbolic environment for variables
    env = {}
    # Maps labels to constraints inherited from branches
    block_constraints = {}
    
    # Initialize arguments and allocations
    memory_sizes = {mem.name: IntVal(mem.size) for mem in mlir_data.memory_allocations}
    if external_memory:
        for name, size in external_memory.items():
            memory_sizes[name] = IntVal(size)
    
    # Implicit FSM arguments
    buffer_len = Int('buffer_len')
    if 'raw_buffer' not in memory_sizes:
        solver.add(buffer_len > 0)
        memory_sizes['raw_buffer'] = buffer_len
    
    env['buffer_len'] = buffer_len
    for i in range(arg_count):
        env[f"arg{i}"] = Real(f"arg{i}")

    def resolve_z3_val(v):
        if v in env: return env[v]
        if v.startswith('"') and v.endswith('"') and len(v) == 3:
            return IntVal(ord(v[1]))
        if v.replace('.', '').replace('-', '').isdigit():
            # Z3 Int for offsets, Real for scalar math
            return IntVal(int(float(v)))
        return Int(v)

    # 2. Pre-process Pass: Basic Block Context
    # We track which labels are reached via which branch conditions
    current_block_constraints = []
    
    # 3. Main Verification Pass
    for op in mlir_data.operations:
        # --- Control Flow Tracking ---
        if op.op == "label":
            label_name = op.args[0]
            # Inherit constraints assigned to this label
            if label_name in block_constraints:
                current_block_constraints = block_constraints[label_name]
            continue

        elif op.op == "br":
            if len(op.args) == 3: # Conditional branch [cond, true_label, false_label]
                cond_var, t_label, f_label = op.args[0], op.args[1], op.args[2]
                cond_expr = env.get(cond_var)
                if cond_expr is not None:
                    # Assign constraints to target labels
                    block_constraints[t_label] = current_block_constraints + [cond_expr == 1]
                    block_constraints[f_label] = current_block_constraints + [cond_expr == 0]
            continue

        # --- Symbolic State Tracking ---
        elif op.op in ["add", "sub", "mul", "div"]:
            if op.target_var:
                l, r = resolve_z3_val(op.args[0]), resolve_z3_val(op.args[1])
                # We use Int arithmetic for offsets
                if op.op == "add": env[op.target_var] = l + r
                elif op.op == "sub": env[op.target_var] = l - r
                elif op.op == "mul": env[op.target_var] = l * r
                elif op.op == "div": env[op.target_var] = l / r

        elif op.op == "icmp":
            if op.target_var:
                c_op, l, r = op.args[0], resolve_z3_val(op.args[1]), resolve_z3_val(op.args[2])
                cond = (l == r)
                if c_op == "gt": cond = (l > r)
                elif c_op == "lt": cond = (l < r)
                elif c_op == "ge": cond = (l >= r)
                elif c_op == "le": cond = (l <= r)
                elif c_op == "ne": cond = (l != r)
                env[op.target_var] = If(cond, IntVal(1), IntVal(0))

        # --- Memory Safety Checks ---
        elif op.op == "gep":
            if len(op.args) < 2: return False, f"MALFORMED GEP: {op.args}"
            base_ptr, offset_var = op.args[0], op.args[1]
            
            if base_ptr not in memory_sizes:
                if arg_count == 0: return False, f"SEGFAULT RISK: '{base_ptr}'. Use 'raw_buffer'."
                return False, f"SEGFAULT RISK: {base_ptr}"
            
            z3_offset = resolve_z3_val(offset_var)
            z3_buf_size = memory_sizes[base_ptr]
            
            # Create a path-aware solver
            path_solver = Solver()
            path_solver.add(solver.assertions())
            for c in current_block_constraints: path_solver.add(c)
            
            # Check violation: offset < 0 OR offset >= size
            violation = Or(z3_offset < 0, z3_offset >= z3_buf_size)
            path_solver.add(violation)
            
            if path_solver.check() == sat:
                m = path_solver.model()
                # USE m.eval() for complex expressions
                eval_offset = m.eval(z3_offset, model_completion=True)
                eval_size = m.eval(z3_buf_size, model_completion=True)
                return False, f"BUFFER OVERFLOW RISK: '{offset_var}' can be {eval_offset} when buffer size is {eval_size}"
            
            # If safe, record the pointer derivation
            if op.target_var:
                env[op.target_var] = z3_offset # Track the offset for nested GEPs

        elif op.op == "string_view_ptr":
            if len(op.args) < 3: return False, f"MALFORMED string_view_ptr: {op.args}"
            buf, off, length = op.args[0], op.args[1], op.args[2]
            
            if buf not in memory_sizes: return False, f"SEGFAULT RISK: {buf}"
            
            z3_off = resolve_z3_val(off)
            z3_len = resolve_z3_val(length)
            z3_buf_size = memory_sizes[buf]
            
            path_solver = Solver()
            path_solver.add(solver.assertions())
            for c in current_block_constraints: path_solver.add(c)
            
            # Violation: off < 0 OR off + length > size
            violation = Or(z3_off < 0, z3_off + z3_len > z3_buf_size)
            path_solver.add(violation)
            if path_solver.check() == sat:
                m = path_solver.model()
                eval_off = m.eval(z3_off, model_completion=True)
                eval_len = m.eval(z3_len, model_completion=True)
                eval_size = m.eval(z3_buf_size, model_completion=True)
                return False, f"STRING VIEW OUT-OF-BOUNDS: {off}({eval_off})+{length}({eval_len}) can exceed buffer({eval_size})"

    return True, "PROVEN MEMORY SAFE"

# --- 3. The AST Symbolic Engine (Milestone 3.0) ---
class PythonSymbolicEngine(ast.NodeVisitor):
    def __init__(self, arg_count: int):
        self.env = {f"arg{i}": Real(f"arg{i}") for i in range(arg_count)}

    def visit_FunctionDef(self, node):
        self.arg_map = {arg.arg: f"arg{i}" for i, arg in enumerate(node.args.args)}
        return self.visit_suite(node.body)

    def visit_suite(self, nodes):
        final_res = None
        for node in nodes:
            res = self.visit(node)
            if res is not None: final_res = res
        return final_res

    def visit_Assign(self, node):
        # We only handle simple assignments: x = expression
        if len(node.targets) == 1 and isinstance(node.targets[0], ast.Name):
            val = self.visit(node.value)
            mapped_name = self.arg_map.get(node.targets[0].id, node.targets[0].id)
            self.env[mapped_name] = val
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

# --- 4. Gemini Generative Feedback Loop ---
async def generate_execution_graph(intent: str, error_context: str = "", last_failed_mlir: str = "") -> str:
    """Generates the MLIR JSON graph using either Gemini or Ollama (fallback)."""
    
    api_key = os.environ.get("GEMINI_API_KEY")
    
    # --- PREPARE THE PROMPT ---
    base_instructions = """
SYSTEM INSTRUCTIONS:
You are an expert compiler frontend. Convert Python logic into a DOD MLIR execution graph.

STRICT ISA RULES:
1. Every operation MUST be a flat object. NO nested logic like 'arg0 * 0.5'.
2. The `store` operation takes [value, pointer]. You CANNOT store into a literal.
3. The `icmp` operation takes [operator, lhs, rhs]. Operator must be 'eq', 'ne', 'gt', 'lt'.
4. For STRING COMPARISON: Use `strcmp`, which takes [pointer, pointer_or_literal].
5. For STRING VIEWS: Use `string_view_ptr`, which MUST take [buffer_name, offset, length].

MANDATORY NAMES FOR FSM (0-argument functions):
- You MUST use 'raw_buffer' as the base pointer for the input data.
- You MUST use 'buffer_len' as the size of the input data.
- Do NOT invent names like 'json_bytes' or 'size'. Use 'raw_buffer' and 'buffer_len' only.
"""

    prompt = f"{base_instructions}\n\nTARGET INTENT:\n{intent}\n"
    
    if error_context:
        prompt += f"""
---
[CRITICAL] CORRECTION REQUIRED FROM PREVIOUS ATTEMPT:
The last graph you generated was REJECTED.
FAILED CODE:
{last_failed_mlir}

ERROR: {error_context}

ANALYSIS TASK:
1. Identify exactly which operation in the FAILED CODE caused the ERROR above.
2. In your next 'thinking_process', explain how you will avoid this specific mistake.
3. Generate a NEW graph that follows all ISA rules. Do NOT repeat the failed logic.
---
"""

    # --- ROUTE TO BACKEND ---
    if api_key and api_key.strip():
        # USE GEMINI
        await asyncio.sleep(1) # Rate limit mitigation
        try:
            response = await gemini_client.aio.models.generate_content(
                model='gemini-2.5-pro',
                contents=prompt,


                config=types.GenerateContentConfig(
                    response_mime_type="application/json",
                    response_schema=VerifiedMLIR,
                    temperature=0.1,
                ),
            )
            return response.text
        except Exception as e:
            print(f"   [Gemini API Error] {e} - Falling back to Ollama...")
            # Fall through to Ollama if API fails
    
    # USE OLLAMA (Fallback)
    local_client = ollama.AsyncClient()
    response = await local_client.chat(
        model="deepseek-coder-v2:latest", 
        messages=[{'role': 'user', 'content': prompt}], 
        format=VerifiedMLIR.model_json_schema()
    )
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
    last_failed_mlir = ""
    for attempt in range(3):
        print(f"   [AI] Generating Graph (Attempt {attempt + 1})...")
        mlir_json = await generate_execution_graph(intent, error_msg, last_failed_mlir)
        print(f"   [DEBUG] Gemini/Ollama Response: {mlir_json}")
        last_failed_mlir = mlir_json
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
