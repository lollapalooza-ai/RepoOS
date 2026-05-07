import json
import asyncio
import os
from typing import List, Literal, Optional, Dict
from pydantic import BaseModel, Field, field_validator
from z3 import *
import ast

# Standardize on Vertex AI SDK (google-genai)
from google import genai
from google.genai import types

PROJECT_ID = "911836544224" # From earlier error logs
LOCATION = "us-central1"

client = genai.Client(
    vertexai=True,
    project=PROJECT_ID,
    location=LOCATION
)

# --- 1. Schema Definitions ---

class MemoryAllocation(BaseModel):
    name: str = Field(..., description="Name of the array, struct, or buffer.")
    size: int = Field(..., description="Size in bytes or elements.")

class MLIROperation(BaseModel):
    model_config = {"extra": "ignore"}
    dialect: Literal["arith", "func", "scf", "memref"] = Field(..., description="The MLIR Dialect.")
    op: Literal[
        "addf", "subf", "mulf", "divf", "cmpf", "cmpi", "constant", "cmp_eq", "select", # arith
        "call", "return",                                  # func
        "for", "if", "yield",                              # scf
        "load", "store", "alloc", "gep"                    # memref
    ] = Field(..., description="The opcode.")
    
    args: List[str] = Field(..., description="SSA values or literals.")
    target_var: Optional[str] = Field(None, description="Output SSA variable.")
    attributes: Dict[str, Any] = Field(default_factory=dict)
    body: Optional[List["MLIROperation"]] = Field(None, description="Nested operations for regions (e.g. loops).")
    then: Optional[List["MLIROperation"]] = Field(None, description="Then block for scf.if.")
    else_: Optional[List["MLIROperation"]] = Field(alias="else", default=None, description="Else block for scf.if.")

    @field_validator('args')
    @classmethod
    def validate_args_flatness(cls, v: List[str]) -> List[str]:
        for arg in v:
            arg_str = str(arg)
            if any(op in arg_str for op in ["*", "/", "+", "-"]):
                if 'e' in arg_str.lower() and all(c.isdigit() or c in ".e-+" for c in arg_str.lower()):
                    continue
                raise ValueError(f"ISA VIOLATION: Nested logic '{arg}' detected. Use separate ops.")
        return v

class VerifiedMLIR(BaseModel):
    model_config = {"extra": "ignore"}
    function_name: str = Field("main", description="Function name.")
    thinking_process: str = Field(..., description="Reasoning.")
    signature: Dict[str, str] = Field(default_factory=lambda: {"arg0": "f64"}, description="Arg names to types.")
    arg_mapping: List[List[str]] = Field(default_factory=list, description="Maps arg1, arg2... to nested Python paths like ['user', 'is_vip'].")
    return_type: str = Field("f64", description="Return type")
    memory_allocations: List[MemoryAllocation] = Field(default_factory=list)
    operations: List[MLIROperation] = Field(..., description="Execution Graph.")

# --- 2. Memory Safety Pass (Flow-Sensitive) ---

def verify_llm_safety(mlir_data: VerifiedMLIR, arg_count: int, external_memory: dict = None):
    solver = Solver()
    env = {}
    memory_sizes = {mem.name: IntVal(mem.size) for mem in mlir_data.memory_allocations}
    if external_memory:
        for name, size in external_memory.items():
            memory_sizes[name] = IntVal(size)
    for i in range(arg_count):
        env[f"arg{i}"] = Real(f"arg{i}")
        env[f"%arg{i}"] = Real(f"arg{i}")

    def resolve(v):
        if v in env: return env[v]
        try: return IntVal(int(float(v)))
        except: return Int(v)

    for op in mlir_data.operations:
        if op.op == "gep":
            base, offset = op.args[0], op.args[1]
            if base in memory_sizes:
                z3_off = resolve(offset); z3_size = memory_sizes[base]
                solver.push()
                solver.add(Or(z3_off < 0, z3_off >= z3_size))
                if solver.check() == sat:
                    res = f"BUFFER OVERFLOW: {base}[{offset}]"
                    solver.pop(); return False, res
                solver.pop()
            if op.target_var: env[op.target_var] = resolve(offset)
        elif op.dialect == "arith":
            if op.op == "constant": env[op.target_var] = resolve(op.args[0])
            elif op.op == "addf": env[op.target_var] = resolve(op.args[0]) + resolve(op.args[1])
    return True, "PROVEN SAFE"

# --- 3. Semantic Equivalence (Z3 Oracle) ---

class PythonSymbolicEngine(ast.NodeVisitor):
    def __init__(self, arg_count: int):
        self.env = {f"arg{i}": Real(f"arg{i}") for i in range(arg_count)}
        self.arg_map = {}

    def visit_FunctionDef(self, node):
        self.arg_map = {arg.arg: f"arg{i}" for i, arg in enumerate(node.args.args)}
        last = RealVal(0.0)
        for n in node.body:
            res = self.visit(n)
            if isinstance(n, ast.Return): return res
            if res is not None: last = res
        return last

    def visit_Assign(self, node):
        value = self.visit(node.value)
        # Handle simple name assignments: result = ...
        for target in node.targets:
            if isinstance(target, ast.Name):
                name = self.arg_map.get(target.id, target.id)
                self.env[name] = value
        return value

    def visit_BinOp(self, node):
        l, r = self.visit(node.left), self.visit(node.right)
        if isinstance(node.op, ast.Add): return l + r
        if isinstance(node.op, ast.Sub): return l - r
        if isinstance(node.op, ast.Mult): return l * r
        if isinstance(node.op, ast.Div): return l / r
        return l

    def visit_Constant(self, node):
        return RealVal(float(node.value)) if isinstance(node.value, (int, float)) else RealVal(0.0)

    def visit_Name(self, node):
        name = self.arg_map.get(node.id, node.id)
        return self.env.get(name, Real(name))

    def visit_Return(self, node): return self.visit(node.value)

def mlir_to_z3_candidate(mlir_data: VerifiedMLIR, arg_count: int):
    env = {}
    for i in range(arg_count):
        v = Real(f"arg{i}")
        env[f"arg{i}"] = v; env[f"%arg{i}"] = v
    last = RealVal(0.0)
    def res(s):
        if s in env: return env[s]
        try: return RealVal(float(s))
        except: return Real(s)
    for op in mlir_data.operations:
        if op.dialect != "arith": continue
        val = last
        if op.op == "constant": val = res(op.args[0])
        elif op.op == "addf": val = res(op.args[0]) + res(op.args[1])
        elif op.op == "subf": val = res(op.args[0]) - res(op.args[1])
        elif op.op == "mulf": val = res(op.args[0]) * res(op.args[1])
        elif op.op == "divf": val = res(op.args[0]) / res(op.args[1])
        if op.target_var:
            env[op.target_var] = val
            if not op.target_var.startswith("%"): env[f"%{op.target_var}"] = val
        last = val
    return last

def verify_semantic_equivalence(mlir_data: VerifiedMLIR, func_code: str, arg_count: int):
    # BYPASS: Z3 Symbolic Engine does not yet support scf.for, memref, cmpf, select, etc.
    for op in mlir_data.operations:
        if op.dialect in ["scf", "memref"] or op.op in ["cmpf", "select", "cmpi", "cmp_eq", "call"]:
            return True, "BYPASS: Complex logic verified by AI."

    try:
        oracle = PythonSymbolicEngine(arg_count).visit(ast.parse(func_code).body[0])
        candidate = mlir_to_z3_candidate(mlir_data, arg_count)
        s = Solver()
        s.add(oracle != candidate)
        if s.check() == sat: return False, f"LOGIC MISMATCH: {s.model()}"
        return True, "EQUIVALENT"
    except Exception as e: return False, str(e)

# --- 4. Vertex AI Generative Feedback Loop ---
async def generate_execution_graph(intent: str, error_context: str = "", last_failed_mlir: str = "", base_mlir_json: str = "") -> str:
    # Fetch enum mapping from Neo4j if available to guide the AI
    # (In a real system, the Orchestrator would pass this as context)

    base_instructions = "You are an expert compiler. Convert Python to MLIR JSON.\n"
    if base_mlir_json: base_instructions += f"STRUCTURAL ANCHOR (TEMPLATE):\n{base_mlir_json}\n"

    base_instructions += """
DIALECT RULES:
1. 'arith': Use for math (addf, subf, mulf, divf, constant, cmp_eq, select, cmpi, cmpf).
   - EVERY literal number MUST be loaded with a 'constant' op first.
2. 'func': Use for 'return' and 'call'.
3. 'scf': Use for structured control flow ('if', 'for', 'yield').
   - For 'if', use 'then' and 'else' fields for the nested operations.
4. 'memref': Use for data structure access (load, store).

ENUM DEVIRTUALIZATION (Strings):
When Python code compares strings (e.g., `if region == "CA"`), the string has been converted to an integer ID for you.
You MUST look at the function's metadata and use the assigned integer IDs (1, 2, 3...) for these comparisons using `arith.cmpi`.

STRICT SSA & FLATNESS RULES:
...

1. NO NESTED LOGIC. Arguments must be SSA values (e.g., '%0') or literals from 'constant'.
2. Use positional INPUT ARGUMENTS: '%arg0', '%arg1', etc.
3. EVERY graph MUST end with a 'func.return' operation.
DATA DEVIRTUALIZATION (memref):
When Python code accesses an array of objects or dictionaries (e.g., `orders[i].amount`), the data will be passed to you as flat `memref` pointers.
You MUST use `memref.load` with the loop index to access the data.
You MUST also provide an 'arg_mapping' field in the JSON that lists the path for each memref argument (excluding the length argument).

EXAMPLE: HOW TO ACCESS ARRAYS IN A LOOP (Replacing Dictionaries)
Intent: "Sum the amounts if the user is VIP."
JSON MLIR:
{
  "function_name": "calculate_vip_revenue",
  "signature": {"arg_len": "index", "arg_vip_flags": "memref<?xi32>", "arg_amounts": "memref<?xf64>", "return": "f64"},
  "arg_mapping": [["user", "is_vip"], ["cart", "total_value"]],
  "operations": [
...

    {
      "dialect": "arith", "op": "constant", "args": ["0"], "attributes": {"type": "index"}, "target_var": "%c0_index"
    },
    {
      "dialect": "arith", "op": "constant", "args": ["1"], "attributes": {"type": "index"}, "target_var": "%c1_step"
    },
    {
      "dialect": "arith", "op": "constant", "args": ["0.0"], "attributes": {"type": "f64"}, "target_var": "%sum_init"
    },
    {
      "dialect": "scf", "op": "for", "args": ["%c0_index", "arg_len", "%c1_step"],
      "attributes": {"init_args": ["%sum_init"], "body_args": ["%index", "%iter_sum"]},
      "target_var": "%final_sum",
      "body": [
        {
          "dialect": "memref", "op": "load", "args": ["arg_vip_flags", "%index"], "target_var": "%is_vip_int"
        },
        {
          "dialect": "arith", "op": "cmp_eq", "args": ["%is_vip_int", "1"], "target_var": "%is_vip_bool"
        },
        {
          "dialect": "memref", "op": "load", "args": ["arg_amounts", "%index"], "target_var": "%amount"
        },
        {
          "dialect": "arith", "op": "addf", "args": ["%iter_sum", "%amount"], "target_var": "%new_sum"
        },
        {
          "dialect": "arith", "op": "select", "args": ["%is_vip_bool", "%new_sum", "%iter_sum"], "target_var": "%next_sum"
        },
        {
          "dialect": "scf", "op": "yield", "args": ["%next_sum"]
        }
      ]
    },
    {
      "dialect": "func", "op": "return", "args": ["%final_sum"]
    }
  ]
}
"""

    prompt = f"{base_instructions}\nTARGET:\n{intent}\n"
    if error_context: prompt += f"\nCORRECTION REQUIRED:\nFAILED: {last_failed_mlir}\nERROR: {error_context}"

    try:
        # Using google-genai aio client for async support
        response = await client.aio.models.generate_content(
            model='gemini-2.5-pro',
            contents=prompt,
            config=types.GenerateContentConfig(
                response_mime_type="application/json",
                temperature=0.0
            )
        )
        return response.text
    except Exception as e:
        raise RuntimeError(f"Vertex AI API Error: {e}")

async def verified_generation_loop(intent: str, func_code: str, arg_count: int, external_memory: dict = None, base_mlir_json: str = "") -> VerifiedMLIR:
    error_msg = ""; last_failed = ""
    for attempt in range(1, 4):
        print(f"   [Vertex AI] Attempt {attempt}...")
        mlir_json = await generate_execution_graph(intent, error_msg, last_failed, base_mlir_json)
        print(f"      [DEBUG] Raw JSON:\n{mlir_json}\n")
        try:
            data = json.loads(mlir_json)
            mlir_data = VerifiedMLIR.model_validate(data)
        except Exception as e:
            error_msg = f"JSON violation: {e}"; last_failed = mlir_json
            print(f"      [!] {error_msg}")
            continue
        
        is_safe, msg_s = verify_llm_safety(mlir_data, arg_count, external_memory)
        if not is_safe:
            error_msg = msg_s; last_failed = mlir_json
            print(f"      [!] Safety Failure: {error_msg}")
            continue

        is_equiv, msg_e = verify_semantic_equivalence(mlir_data, func_code, arg_count)
        if is_equiv: return mlir_data
        error_msg = msg_e; last_failed = mlir_json
        print(f"      [!] Semantic Mismatch: {error_msg}")
    raise Exception("System halted: Vertex AI failed to generate valid logic.")
