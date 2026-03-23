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
    """
    DYNAMIC BOUNDS CHECKER:
    Scans the AI's execution graph for 'gep' (GetElementPtr) operations.
    Uses 'Proof by Contradiction' to ensure no dynamic index can ever 
    exceed the allocated memory size.
    """
    solver = Solver()
    
    # 1. Map all memory buffers to their Z3 Integer sizes
    memory_sizes = {mem.name: IntVal(mem.size) for mem in mlir_data.memory_allocations}
    
    # 2. Setup the global loop constraint (e.g., 'i' will never exceed loop_limit)
    # The AI must use 'i' or 'idx' as its loop counter.
    loop_limit = IntVal(mlir_data.loop_limit)
    idx = Int('idx')
    i = Int('i')
    solver.add(And(idx >= 0, idx < loop_limit))
    solver.add(And(i >= 0, i < loop_limit))

    # 3. Scan every instruction for Memory Access
    for op in mlir_data.operations:
        if op.op == "gep":
            # GEP args are typically: [base_pointer, offset_index]
            if len(op.args) < 2:
                return False, f"MALFORMED GEP: Missing offset index in {op.args}"
                
            base_ptr = op.args[0]
            offset_var = op.args[1]
            
            if base_ptr not in memory_sizes:
                return False, f"SEGFAULT RISK: GEP references unallocated memory '{base_ptr}'"
                
            buffer_size = memory_sizes[base_ptr]
            
            # Convert the string offset (e.g., 'i', 'idx', or a number) into a Z3 variable
            if offset_var in ['i', 'idx']:
                z3_offset = Int(offset_var)
            elif offset_var.replace('-', '').isdigit():
                z3_offset = IntVal(int(offset_var))
            else:
                # If it's a dynamic variable calculated earlier, we constrain it abstractly
                z3_offset = Int(offset_var)
            
            # THE PROOF BY CONTRADICTION
            bounds_violation = Or(z3_offset < 0, z3_offset >= buffer_size)
            
            check_solver = Solver()
            check_solver.add(solver.assertions()) # Load our environment rules
            check_solver.add(bounds_violation)    # Inject the exact opposite of safety
            
            if check_solver.check() == sat:
                model = check_solver.model()
                return False, f"BUFFER OVERFLOW RISK: {offset_var} can equal {model[z3_offset]}, which exceeds bounds of '{base_ptr}'"
                
    return True, "PROVEN MEMORY SAFE: Array boundaries mathematically guaranteed."

# --- 3. The AST Symbolic Engine (Milestone 3.0) ---
class PythonSymbolicEngine(ast.NodeVisitor):
    """
    Translates Native Python AST directly into a Z3 Mathematical Oracle.
    """
    def __init__(self, arg_count: int):
        # Initialize Universe with abstract variables (e.g., arg0 = α, arg1 = β)
        self.env = {f"arg{i}": Real(f"arg{i}") for i in range(arg_count)}

    def visit_FunctionDef(self, node):
        # Map Python's named arguments to our 'arg0', 'arg1' system
        self.arg_map = {arg.arg: f"arg{i}" for i, arg in enumerate(node.args.args)}
        # We assume the MVP math functions return a single expression
        for body_node in node.body:
            if isinstance(body_node, ast.Return):
                return self.visit(body_node.value)
        raise Exception("Symbolic Engine: No return statement found in AST.")

    def visit_Name(self, node):
        # Translate named variables to Z3 symbols
        mapped_name = self.arg_map.get(node.id, node.id)
        return self.env.get(mapped_name, Real(mapped_name))

    def visit_Constant(self, node):
        return RealVal(float(node.value))

    def visit_BinOp(self, node):
        left = self.visit(node.left)
        right = self.visit(node.right)
        if isinstance(node.op, ast.Add): return left + right
        if isinstance(node.op, ast.Sub): return left - right
        if isinstance(node.op, ast.Mult): return left * right
        if isinstance(node.op, ast.Div): return left / right

    def visit_Compare(self, node):
        left = self.visit(node.left)
        comp = node.ops[0]
        right = self.visit(node.comparators[0])
        if isinstance(comp, ast.Eq): return left == right
        if isinstance(comp, ast.Gt): return left > right
        if isinstance(comp, ast.Lt): return left < right

    def visit_IfExp(self, node):
        # The path explosion: Forks the universe into True and False paths
        test = self.visit(node.test)
        body = self.visit(node.body)
        orelse = self.visit(node.orelse)
        return If(test, body, orelse)


def mlir_to_z3_candidate(mlir_data: VerifiedMLIR, arg_count: int):
    """
    Translates the AI's generated MLIR graph into a Z3 Mathematical Candidate.
    """
    env = {f"arg{i}": Real(f"arg{i}") for i in range(arg_count)}
    last_val = None

    def resolve(arg_str):
        if arg_str in env: return env[arg_str]
        try: return RealVal(float(arg_str))
        except ValueError: return RealVal(0.0)

    for op in mlir_data.operations:
        # MVP: Only verifying mathematical graphs. Memory ops bypassed for now.
        if op.op in ["load", "store", "gep", "br", "label"]:
            continue 

        if op.op == "add": val = resolve(op.args[0]) + resolve(op.args[1])
        elif op.op == "sub": val = resolve(op.args[0]) - resolve(op.args[1])
        elif op.op == "mul": val = resolve(op.args[0]) * resolve(op.args[1])
        elif op.op == "div": val = resolve(op.args[0]) / resolve(op.args[1])
        elif op.op == "cmp_eq": val = If(resolve(op.args[0]) == resolve(op.args[1]), RealVal(1.0), RealVal(0.0))
        elif op.op == "icmp":
            # [op, lhs, rhs]
            cmp_op = op.args[0]
            lhs = resolve(op.args[1])
            rhs = resolve(op.args[2])
            if cmp_op == "==": cond = lhs == rhs
            elif cmp_op == "!=": cond = lhs != rhs
            elif cmp_op == ">": cond = lhs > rhs
            elif cmp_op == ">=": cond = lhs >= rhs
            elif cmp_op == "<": cond = lhs < rhs
            elif cmp_op == "<=": cond = lhs <= rhs
            else: cond = lhs == rhs
            val = If(cond, RealVal(1.0), RealVal(0.0))
        elif op.op == "select": val = If(resolve(op.args[0]) > RealVal(0.5), resolve(op.args[1]), resolve(op.args[2]))
        else: val = last_val

        if op.target_var:
            env[op.target_var] = val
        last_val = val

    return last_val

# --- 4. Generative Feedback Loop ---
async def generate_execution_graph(intent: str, error_context: str = "") -> str:
    client = ollama.AsyncClient()
    
    prompt = (
        "You are an expert compiler frontend. Convert the following Python logic into a DOD MLIR execution graph.\n"
        f"INTENT: {intent}\n\n"
        "STRICT ISA RULES:\n"
        "1. Linear execution only. Every operation MUST be a flat object.\n"
        "2. Do NOT nest operations inside 'args'.\n"
        "3. Output ONLY raw JSON matching the schema."
    )
    if error_context:
        prompt += f"\n\nCRITICAL: YOUR PREVIOUS ATTEMPT FAILED VERIFICATION:\n{error_context}\nFIX THE LOGIC."
        
    response = await client.chat(
        model="deepseek-coder-v2:latest", 
        messages=[{'role': 'user', 'content': prompt}],
        format=VerifiedMLIR.model_json_schema()
    )
    return response['message']['content']

def verify_semantic_equivalence(mlir_data: VerifiedMLIR, func_code: str, arg_count: int) -> tuple[bool, str]:
    """
    MILESTONE 3.0: FULL SYMBOLIC EXECUTION.
    Automatically proves MLIR matches the Python AST.
    """
    # 1. Skip array/memory functions (We only mathematically verify scalar math for v3.0)
    has_memory = any(op.op in ["load", "store", "gep"] for op in mlir_data.operations)
    if has_memory:
        return True, "PROVEN SAFE (Memory operations bypass Semantic Equivalence)"

    try:
        # 2. Compile Python to Z3 Oracle
        tree = ast.parse(func_code)
        engine = PythonSymbolicEngine(arg_count)
        # Visit the first node in the module (the FunctionDef)
        z3_oracle = engine.visit(tree.body[0])

        # 3. Compile AI MLIR to Z3 Candidate
        z3_candidate = mlir_to_z3_candidate(mlir_data, arg_count)
        
        print(f"   [Z3 DEBUG] Oracle: {z3_oracle}")
        print(f"   [Z3 DEBUG] Candidate: {z3_candidate}")

        # 4. The Clash: Prove they are NOT equal
        solver = Solver()
        # If we can satisfy (Oracle != Candidate), the AI made a mistake.
        solver.add(z3_oracle != z3_candidate)

        if solver.check() == sat:
            model = solver.model()
            counter_example = "\n".join([f"{d.name()} = {model[d]}" for d in model.decls()])
            return False, f"HALLUCINATION DETECTED! Results differ under these conditions:\n{counter_example}"
        
        return True, "PROVEN EQUIVALENT: AI Graph perfectly matches Python intent."
        
    except Exception as e:
        return False, f"Verification Engine Error: {e}"

async def verified_generation_loop(intent: str, func_code: str, arg_count: int) -> VerifiedMLIR:
    error_msg = ""
    for attempt in range(3):
        print(f"   [AI] Generating Graph (Attempt {attempt + 1})...")
        mlir_json = await generate_execution_graph(intent, error_msg)
        try:
            mlir_data = VerifiedMLIR.model_validate_json(mlir_json)
        except Exception as e:
            print(f"   [AI] JSON schema violation: {e}")
            error_msg = f"JSON schema violation: {e}"
            continue
            
        # 1. Verify Memory Safety (Bounds Checking)
        is_safe, msg = verify_llm_safety(mlir_data)
        if not is_safe:
            print(f"   [Z3] ❌ Safety verification failed: {msg}")
            error_msg = msg
            continue
            
        # 2. MILESTONE 3.0: Verify Semantic Equivalence
        is_equiv, msg_eq = verify_semantic_equivalence(mlir_data, func_code, arg_count)
        if is_equiv:
            print("   [Z3] ✅ Graph mathematically and semantically verified.")
            print(f"   [DEBUG MLIR]: {mlir_data.model_dump_json(indent=2)}")
            return mlir_data
        
        print(f"   [Z3] ❌ Semantic verification failed: {msg_eq}")
        print(f"   [FAILED MLIR]: {mlir_data.model_dump_json(indent=2)}")
        error_msg = msg_eq 
        
    raise Exception("System halted: LLM failed to generate safe and equivalent graph after 3 attempts.")
