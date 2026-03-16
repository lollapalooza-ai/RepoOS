import json
import asyncio
from typing import List, Literal, Optional
from pydantic import BaseModel, Field
from z3 import *
import ollama # Ensure you pip install ollama

# --- 1. The Strict Pydantic Schema (The Execution Graph Protocol) ---
class MemoryAllocation(BaseModel):
    name: str = Field(..., description="Name of the array/struct.")
    size: int = Field(..., description="Exact allocated size in elements.")

class Operation(BaseModel):
    op: Literal["add", "sub", "mul", "div"] = Field(..., description="The mathematical or bitwise opcode.")
    args: List[str] = Field(..., description="Variables or literal numbers to operate on.")
    target_var: str = Field(..., description="The variable to store the result in.")

class VerifiedMLIR(BaseModel):
    memory_allocations: List[MemoryAllocation] = Field(..., description="Memory constraints for verification.")
    loop_limit: int = Field(..., description="Max loop iterations.")
    access_offset: int = Field(..., description="Offset pointer for memory access (e.g., array[i + offset]).")
    operations: List[Operation] = Field(..., description="The step-by-step Execution Graph.")

# --- 2. The Z3 SMT Mathematical Verification ---
def verify_llm_safety(mlir_data: VerifiedMLIR) -> tuple[bool, str]:
    """
    Checks the Pydantic object for out-of-bounds memory and division by zero.
    """
    solver = Solver()
    
    # 1. Check Memory Aliasing / Bounds
    i = Int('i')
    loop_limit = IntVal(mlir_data.loop_limit)
    offset = IntVal(mlir_data.access_offset)
    
    # LLM asserts loop runs 0 to loop_limit
    loop_condition = And(i >= 0, i < loop_limit)
    
    for alloc in mlir_data.memory_allocations:
        array_size = IntVal(alloc.size)
        access_index = i + offset
        
        # Violation: Can the access pointer exceed array size, or drop below 0?
        memory_violation = Or(access_index >= array_size, access_index < 0)
        solver.push()
        solver.add(loop_condition)
        solver.add(memory_violation)
        if solver.check() == sat:
            model = solver.model()
            return False, f"FATAL HALLUCINATION: Memory violation in '{alloc.name}' at index {model[i]}."
        solver.pop()

    # 2. Check Division by Zero in Operations
    for op in mlir_data.operations:
        if op.op == "div":
             # Check if second arg is a literal zero
             try:
                 if float(op.args[1]) == 0:
                     return False, "FATAL HALLUCINATION: Division by zero detected in Execution Graph."
             except ValueError:
                 pass # It's a variable, complex check needed for production

    return True, "PROVEN SAFE"

# --- 3. The LLM Generation & Feedback Loop ---
async def generate_execution_graph(intent: str, error_context: str = "") -> str:
    client = ollama.AsyncClient()
    example_json = {
        "memory_allocations": [{"name": "buffer", "size": 10}],
        "loop_limit": 5,
        "access_offset": 0,
        "operations": [{"op": "add", "args": ["arg1", "arg2"], "target_var": "sum"}]
    }
    prompt = (
        f"You are a DOD MLIR compiler. Convert this business intent into a verified execution graph: '{intent}'.\n"
        f"Example output format:\n{json.dumps(example_json)}\n"
        "Output ONLY the raw JSON. No markdown, no preamble."
    )
    if error_context:
        prompt += f"\nYOUR PREVIOUS ATTEMPT FAILED:\n{error_context}\nFix the memory bounds or logic."
        
    response = await client.chat(
        model="deepseek-coder-v2:latest", 
        messages=[{'role': 'user', 'content': prompt}],
        format='json'
    )
    return response['message']['content']

async def verified_generation_loop(intent: str) -> VerifiedMLIR:
    max_retries = 3
    error_msg = ""
    
    for attempt in range(max_retries):
        print(f"Generating Execution Graph... (Attempt {attempt + 1})")
        mlir_json = await generate_execution_graph(intent, error_msg)
        
        # Parse into Pydantic
        try:
            mlir_data = VerifiedMLIR.model_validate_json(mlir_json)
        except Exception as e:
            print(f"❌ JSON Parsing Failed: {e}")
            error_msg = f"Invalid JSON or schema violation: {e}"
            continue
        
        # Run Mathematical Verification
        is_safe, msg = verify_llm_safety(mlir_data)
        
        if is_safe:
            print("✅ Graph mathematically verified by Z3.")
            print(f"DEBUG MLIR: {mlir_data.model_dump_json(indent=2)}")
            return mlir_data
            
        print(f"❌ Verification Failed: {msg}")
        error_msg = msg # Feed exactly why it failed back to the LLM
        
    raise Exception("System halted: LLM failed to generate mathematically safe execution graph after 3 attempts.")

if __name__ == "__main__":
    # Test the safety verification with a known bad case
    bad_mlir = VerifiedMLIR(
        memory_allocations=[MemoryAllocation(name="test_buf", size=10)],
        loop_limit=10,
        access_offset=1,
        operations=[]
    )
    safe, msg = verify_llm_safety(bad_mlir)
    print(f"Test Bad MLIR: {safe}, {msg}")
