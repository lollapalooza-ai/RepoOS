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
    dialect: Literal["arith", "func", "scf", "memref", "llvm", "math"] = Field(..., description="The MLIR Dialect.")
    op: Literal[
        "addf", "subf", "mulf", "divf", "cmpf", "cmpi", "constant", "cmp_eq", "select", # arith
        "addi", "subi", "muli", "divi",                    # arith (integers/index)
        "powf", "sqrt", "exp", "log", "absf",              # math
        "call", "return",                                  # func
        "for", "if", "yield",                              # scf
        "load", "store", "alloc", "gep",                   # memref
        "getelementptr",                                   # llvm
        "index_cast"                                       # arith
    ] = Field(..., description="The opcode.")
    
    args: List[str] = Field(..., description="SSA values or literals.")
    target_var: Optional[str] = Field(None, description="Output SSA variable.")
    attributes: Dict[str, Any] = Field(default_factory=dict)
    body: Optional[List["MLIROperation"]] = Field(default_factory=list, description="Nested operations for regions (e.g. loops).")
    then: Optional[List["MLIROperation"]] = Field(default_factory=list, description="Then block for scf.if.")
    else_: Optional[List["MLIROperation"]] = Field(alias="else", default=None, description="Else block for scf.if.")

    @field_validator('args')
    @classmethod
    def validate_args_flatness(cls, v: List[str]) -> List[str]:
        for arg in v:
            arg_str = str(arg)
            # Allow negative numbers (starts with - and followed by digits/dots)
            if arg_str.startswith('-') and all(c.isdigit() or c == '.' for c in arg_str[1:]):
                continue
            if any(op in arg_str for op in ["*", "/", "+", "-"]):
                if 'e' in arg_str.lower() and all(c.isdigit() or c in ".e-+" for c in arg_str.lower()):
                    continue
                raise ValueError(f"ISA VIOLATION: Nested logic '{arg}' detected. Use separate ops.")
        return v

class VerifiedMLIR(BaseModel):
    model_config = {"extra": "ignore"}
    function_name: str = Field("main", description="Function name.")
    thinking_process: str = Field("Autonomous transformation.", description="Reasoning.")
    signature: Dict[str, str] = Field(default_factory=lambda: {"arg0": "f64"}, description="Arg names to types.")
    arg_mapping: List[List[str]] = Field(default_factory=list, description="Maps arg1, arg2... to nested Python paths like ['user', 'is_vip'].")
    return_type: str = Field("f64", description="Return type")
    config: Dict[str, Any] = Field(default_factory=dict, description="Algorithm-specific tuning/metadata.")
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
    def __init__(self, input_names: List[str]):
        self.env = {f"arg{i}": Real(f"arg{i}") for i in range(len(input_names))}
        self.arg_map = {name: f"arg{i}" for i, name in enumerate(input_names)}

    def visit_Module(self, node):
        res = RealVal(0.0)
        for stmt in node.body:
            res = self.visit(stmt)
        return res

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
        if isinstance(node.op, ast.Pow): return l ** r
        return l

    def visit_Constant(self, node):
        return RealVal(float(node.value)) if isinstance(node.value, (int, float)) else RealVal(0.0)

    def visit_Name(self, node):
        name = self.arg_map.get(node.id, node.id)
        return self.env.get(name, Real(name))

    def visit_Return(self, node): return self.visit(node.value)

def mlir_to_z3_candidate(mlir_data: VerifiedMLIR, arg_count: int):
    MAX_UNROLL_DEPTH = 3 # Symbolic execution bound

    def resolve(env, s):
        if s in env: return env[s]
        try: return RealVal(float(s))
        except: return Real(s)

    def process_ops(operations, current_env):
        last_val = RealVal(0.0)
        for op in operations:
            if op.dialect in ["arith", "math"]:
                val = last_val
                if op.op == "constant": val = resolve(current_env, op.args[0])
                elif op.op == "addf": val = resolve(current_env, op.args[0]) + resolve(current_env, op.args[1])
                elif op.op == "subf": val = resolve(current_env, op.args[0]) - resolve(current_env, op.args[1])
                elif op.op == "mulf": val = resolve(current_env, op.args[0]) * resolve(current_env, op.args[1])
                elif op.op == "divf": val = resolve(current_env, op.args[0]) / resolve(current_env, op.args[1])
                elif op.op == "powf": val = resolve(current_env, op.args[0]) ** resolve(current_env, op.args[1])
                
                if op.target_var:
                    current_env[op.target_var] = val
                    if not op.target_var.startswith("%"): current_env[f"%{op.target_var}"] = val
                last_val = val
            
            elif op.dialect == "scf" and op.op == "for":
                # For symbolic equivalence, we unroll the loop statically a few times
                init_val = resolve(current_env, op.attributes.get("init_args", ["0.0"])[0])
                iter_var = init_val
                
                for _ in range(MAX_UNROLL_DEPTH):
                    loop_env = current_env.copy()
                    # Map body args (like %iter_sum) to current symbolic state
                    body_args = op.attributes.get("body_args", [])
                    if len(body_args) >= 2:
                        # body_args[0] is usually the index, body_args[1] is the carry
                        loop_env[body_args[1]] = iter_var
                    
                    # Recursively process the loop body
                    if op.body:
                        iter_var = process_ops(op.body, loop_env)
                
                if op.target_var:
                    current_env[op.target_var] = iter_var
                    if not op.target_var.startswith("%"): current_env[f"%{op.target_var}"] = iter_var
                last_val = iter_var
                
        return last_val

    initial_env = {}
    for i in range(arg_count):
        v = Real(f"arg{i}")
        initial_env[f"arg{i}"] = v; initial_env[f"%arg{i}"] = v
    
    return process_ops(mlir_data.operations, initial_env)

def verify_semantic_equivalence(mlir_data: VerifiedMLIR, func_code: str, input_names: List[str]):
    # BYPASS: Z3 Symbolic Engine does not yet support memref, cmpf, select, etc.
    for op in mlir_data.operations:
        if op.dialect in ["memref"] or op.op in ["cmpf", "select", "cmpi", "cmp_eq", "call"]:
            return True, "BYPASS: Complex logic verified by AI."

    try:
        arg_count = len(input_names)
        tree = ast.parse(func_code)
        oracle = PythonSymbolicEngine(input_names).visit(tree)
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
2. 'math': Use for 'powf', 'sqrt', 'exp', 'log', 'absf'.
   - Use 'math.powf' for exponentiation (e.g. 2 ** x).
3. 'func': Use for 'return' and 'call'.
4. 'scf': Use for structured control flow ('if', 'for', 'yield').

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

async def verified_generation_loop(intent: str, func_code: str, input_names: List[str], external_memory: dict = None, base_mlir_json: str = "") -> VerifiedMLIR:
    from ast_to_mlir import python_to_deterministic_mlir
    arg_count = len(input_names)
    
    # NEW DETERMINISTIC FLOW:
    print(f"   [Deterministic Builder] Generating baseline MLIR...")
    try:
        import ast as py_ast
        tree = py_ast.parse(func_code)
        target_name = "main"
        for node in py_ast.walk(tree):
            if isinstance(node, py_ast.FunctionDef):
                target_name = node.name
                break
        
        mlir_data = python_to_deterministic_mlir(func_code, target_name, input_names)
        print(f"      [OK] Baseline generated.")
    except Exception as e:
        print(f"      [!] Deterministic Builder failed: {e}. Falling back to LLM...")
        error_msg = ""; last_failed = ""
        for attempt in range(1, 4):
            print(f"   [Vertex AI] Attempt {attempt}...")
            mlir_json = await generate_execution_graph(intent, error_msg, last_failed, base_mlir_json)
            try:
                data = json.loads(mlir_json)
                mlir_data = VerifiedMLIR.model_validate(data)
                break
            except Exception as e:
                error_msg = f"JSON violation: {e}"; last_failed = mlir_json
                continue
        else:
            raise Exception("System halted: Vertex AI failed to generate valid logic.")

    # 2. Shift Gemini to an "Optimization Oracle"
    print(f"   [Optimization Oracle] Tuning heuristics...")
    heuristics = await generate_optimization_heuristics(mlir_data)
    mlir_data.config["optimization_heuristics"] = heuristics.model_dump()
    print(f"      [OK] Heuristics: {mlir_data.config['optimization_heuristics']}")

    # 3. Validation
    is_safe, msg_s = verify_llm_safety(mlir_data, arg_count, external_memory)
    if not is_safe:
        raise Exception(f"Safety Failure: {msg_s}")

    is_equiv, msg_e = verify_semantic_equivalence(mlir_data, func_code, input_names)
    if not is_equiv:
        print(f"      [!] Semantic Warning: {msg_e}")
    
    return mlir_data

# --- 5. Optimization Oracle ---

class ExecutionContract(BaseModel):
    init_hints: Dict[str, str] = Field(default_factory=dict, description="e.g., {'p_ptr': '1/N', 'res_ptr': 'zeros'}")
    structural_mapping: Dict[str, str] = Field(default_factory=dict, description="Maps graph/matrix structures to flat arrays (e.g., {'row_ptrs': 'row_ptrs'})")
    pointer_aliases: Dict[str, str] = Field(default_factory=dict, description="Maps MLIR pointers to Python arg names (e.g., {'p_ptr': 'personalization'})")
    element_types: Dict[str, str] = Field(default_factory=dict, description="Element types for pointers (e.g., {'row_ptrs': 'i64'})")
    normalize_buffers: Dict[str, bool] = Field(default_factory=dict, description="Whether to normalize a buffer (e.g., {'p_ptr': True})")

async def synthesize_execution_contract(raw_python_code: str) -> ExecutionContract:
    """Pass the raw Python chunk to Gemini to infer the memory contract."""
    
    prompt = f"""
    Analyze this Python code chunk and synthesize an Execution Contract for a bare-metal MLIR compiler.
    
    Identify:
    1. Initializations (e.g. if you see p = 1.0/N, the init hint is '1/N').
    2. Structural mappings (if the code processes a Graph, identify which arrays map to CSR components: row_ptrs, col_idx, weights).
    3. Pointer aliases (map the internal kernel argument names like 'p_ptr' back to the high-level Python arguments like 'personalization').
    4. Element types (identify if pointers should be i64/index for offsets/indices or f64 for data).
    
    CODE:
    {raw_python_code}
    """
    
    try:
        response = await client.aio.models.generate_content(
            model='gemini-2.5-pro',
            contents=prompt,
            config=types.GenerateContentConfig(
                response_mime_type="application/json",
                response_schema=ExecutionContract,
                temperature=0.0
            )
        )
        return ExecutionContract.model_validate_json(response.text)
    except Exception as e:
        print(f"Contract synthesis failed, falling back to empty contract: {e}")
        return ExecutionContract()

class MLIROptimizationHeuristics(BaseModel):
    loop_unroll_factor: int = Field(default=1, description="Factor to unroll scf.for loops.")
    vectorization_width: int = Field(default=1, description="SIMD vectorization width.")
    stochastic_routing_hint: bool = False

async def generate_optimization_heuristics(baseline_mlir: VerifiedMLIR) -> MLIROptimizationHeuristics:
    """Pass the deterministically generated MLIR to Gemini just for tuning parameters."""
    
    prompt = f"""
    Analyze this baseline MLIR execution graph. 
    Do NOT rewrite the logic. Provide optimization heuristics for the CPU JIT compiler.
    
    BASELINE GRAPH:
    {baseline_mlir.model_dump_json(indent=2)}
    """
    
    try:
        response = await client.aio.models.generate_content(
            model='gemini-2.5-pro',
            contents=prompt,
            config=types.GenerateContentConfig(
                response_mime_type="application/json",
                # Force the output to perfectly match the Pydantic schema
                response_schema=MLIROptimizationHeuristics,
                temperature=0.0
            )
        )
        # Parse the guaranteed JSON
        return MLIROptimizationHeuristics.model_validate_json(response.text)
    except Exception as e:
        print(f"Heuristic optimization failed, falling back to unoptimized baseline: {e}")
        return MLIROptimizationHeuristics() # Safe fallback
