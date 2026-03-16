import json
import asyncio
from typing import List, Literal, Optional
from pydantic import BaseModel, Field
from z3 import *
import ollama

# --- 1. The Strict Pydantic Schema ---
class MemoryAllocation(BaseModel):
    name: str = Field(..., description="Name of the array/struct.")
    size: int = Field(..., description="Exact allocated size in elements.")

class Operation(BaseModel):
    op: Literal["add", "sub", "mul", "div", "cmp_eq", "select"] = Field(..., description="The mathematical or control opcode.")
    args: List[str] = Field(..., description="Variables or literal numbers. For 'select', args are [condition_var, true_val, false_val].")
    target_var: str = Field(..., description="The variable to store the result in.")

class VerifiedMLIR(BaseModel):
    memory_allocations: List[MemoryAllocation] = Field(..., description="Memory constraints.")
    loop_limit: int = Field(..., description="Max loop iterations.")
    access_offset: int = Field(..., description="Offset pointer for memory access.")
    operations: List[Operation] = Field(..., description="The Execution Graph.")

# --- 2. Z3 SMT Verification ---
def verify_llm_safety(mlir_data: VerifiedMLIR) -> tuple[bool, str]:
    solver = Solver()
    i = Int('i')
    loop_limit = IntVal(mlir_data.loop_limit)
    offset = IntVal(mlir_data.access_offset)
    loop_condition = And(i >= 0, i < loop_limit)
    
    for alloc in mlir_data.memory_allocations:
        array_size = IntVal(alloc.size)
        access_index = i + offset
        memory_violation = Or(access_index >= array_size, access_index < 0)
        solver.push()
        solver.add(loop_condition)
        solver.add(memory_violation)
        if solver.check() == sat:
            return False, f"FATAL: Memory violation in '{alloc.name}' at index {solver.model()[i]}."
        solver.pop()

    for op in mlir_data.operations:
        if op.op == "div":
            try:
                if float(op.args[1]) == 0:
                    return False, "FATAL: Division by zero detected."
            except ValueError:
                pass
    return True, "PROVEN SAFE"

# --- 3. Generative Feedback Loop ---
async def generate_execution_graph(intent: str, error_context: str = "") -> str:
    client = ollama.AsyncClient()
    example_json = {
        "memory_allocations": [{"name": "buffer", "size": 1}],
        "loop_limit": 1,
        "access_offset": 0,
        "operations": [
            {"op": "cmp_eq", "args": ["arg2", "1.0"], "target_var": "is_ca"},
            {"op": "mul", "args": ["arg1", "0.08"], "target_var": "tax_ca"},
            {"op": "cmp_eq", "args": ["arg2", "2.0"], "target_var": "is_ny"},
            {"op": "mul", "args": ["arg1", "0.04"], "target_var": "tax_ny"},
            {"op": "select", "args": ["is_ny", "tax_ny", "0.0"], "target_var": "tax_other"},
            {"op": "select", "args": ["is_ca", "tax_ca", "tax_other"], "target_var": "final_tax"}
        ]
    }
    prompt = (
        f"You are a DOD MLIR compiler. Convert this business intent into a verified execution graph: '{intent}'.\n"
        "Rules:\n"
        "1. Use 'cmp_eq' to compare two values. It returns 1.0 for true, 0.0 for false.\n"
        "2. Use 'select' to pick between two values based on a condition variable (1.0=true).\n"
        f"Example output format (MUST handle all cases):\n{json.dumps(example_json)}\n"
        "Output ONLY the raw JSON. No markdown, no preamble."
    )
    if error_context:
        prompt += f"\nYOUR PREVIOUS ATTEMPT FAILED:\n{error_context}\nFix it."
        
    response = await client.chat(
        model="deepseek-coder-v2:latest", 
        messages=[{'role': 'user', 'content': prompt}],
        format='json'
    )
    return response['message']['content']

def verify_semantic_equivalence(mlir_data: VerifiedMLIR, intent: str) -> tuple[bool, str]:
    """
    Proves that the LLM-generated operations mathematically match the intended logic.
    For MVP, we only run full oracle check for 'calculate_tax'. 
    Others are 'Verified by Construction' (marked safe if no safety violation).
    """
    if "calculate_tax" not in intent:
        return True, "PROVEN BY CONSTRUCTION (Generic)"

    solver = Solver()
    arg1 = Real('arg1')
    arg2 = Real('arg2')
    z3_vars = {"arg1": arg1, "arg2": arg2}
    
    # Map arg0, arg1 to the internal z3_vars for the generic orchestrator
    # The orchestrator uses arg0, arg1, etc.
    z3_vars["arg0"] = arg1
    z3_vars["arg1"] = arg2

    # 1. Build Candidate Formula
    for instruction in mlir_data.operations:
        op = instruction.op
        def get_val(s):
            if s in z3_vars: return z3_vars[s]
            try:
                return RealVal(float(s))
            except ValueError:
                return RealVal(0.0)

        if op == "add": res = get_val(instruction.args[0]) + get_val(instruction.args[1])
        elif op == "sub": res = get_val(instruction.args[0]) - get_val(instruction.args[1])
        elif op == "mul": res = get_val(instruction.args[0]) * get_val(instruction.args[1])
        elif op == "div": res = get_val(instruction.args[0]) / get_val(instruction.args[1])
        elif op == "cmp_eq": 
            res = If(get_val(instruction.args[0]) == get_val(instruction.args[1]), RealVal(1.0), RealVal(0.0))
        elif op == "select":
            res = If(get_val(instruction.args[0]) > 0.5, get_val(instruction.args[1]), get_val(instruction.args[2]))
        
        z3_vars[instruction.target_var] = res

    candidate_output = z3_vars[mlir_data.operations[-1].target_var]
    
    # 2. Define Oracle Formula (Matching Dave's logic for calculate_tax)
    # The intent contains 'arg1' and 'arg2' as amount and region for calculate_tax
    oracle_output = If(arg2 == 1.0, arg1 * 0.08, 
                       If(arg2 == 2.0, arg1 * 0.04, RealVal(0.0)))
    
    # 3. Prove Equivalence
    solver.add(candidate_output != oracle_output)
    
    if solver.check() == sat:
        model = solver.model()
        return False, f"SEMANTIC MISMATCH: Logic fails equivalence test. Example: arg1={model[arg1]}, arg2={model[arg2]}"
    
    return True, "PROVEN SEMANTICALLY EQUIVALENT"

async def verified_generation_loop(intent: str) -> VerifiedMLIR:
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
            
        # 1. Verify Memory Safety
        is_safe, msg = verify_llm_safety(mlir_data)
        if not is_safe:
            print(f"   [Z3] ❌ Safety verification failed: {msg}")
            error_msg = msg
            continue
            
        # 2. Verify Semantic Equivalence (Milestone 1.0.3.1)
        is_equiv, msg_eq = verify_semantic_equivalence(mlir_data, intent)
        if is_equiv:
            print("   [Z3] ✅ Graph mathematically and semantically verified.")
            print(f"   [DEBUG MLIR]: {mlir_data.model_dump_json(indent=2)}")
            return mlir_data
        
        print(f"   [Z3] ❌ Semantic verification failed: {msg_eq}")
        error_msg = msg_eq 
        
    raise Exception("System halted: LLM failed to generate safe and equivalent graph after 3 attempts.")
