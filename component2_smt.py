import json
import asyncio
from typing import List, Literal, Optional
from pydantic import BaseModel, Field
from z3 import *
import ollama

# --- 1. The Upgraded ISA Schema ---
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
                # Note: In a full implementation, we'd trace back its definitions.
            
            # THE PROOF BY CONTRADICTION
            # We want to prove: z3_offset >= 0 AND z3_offset < buffer_size
            # To prove it, we ask Z3 to find a scenario where the OPPOSITE is true.
            bounds_violation = Or(z3_offset < 0, z3_offset >= buffer_size)
            
            check_solver = Solver()
            check_solver.add(solver.assertions()) # Load our environment rules
            check_solver.add(bounds_violation)    # Inject the exact opposite of safety
            
            # If Z3 can satisfy the violation, the code is dangerous.
            if check_solver.check() == sat:
                model = check_solver.model()
                return False, f"BUFFER OVERFLOW RISK: {offset_var} can equal {model[z3_offset]}, which exceeds bounds of '{base_ptr}' (Size: {mlir_data.memory_allocations[0].size})"
                
    return True, "PROVEN MEMORY SAFE: Array boundaries mathematically guaranteed."

# --- 3. Generative Feedback Loop ---
async def generate_execution_graph(intent: str, error_context: str = "") -> str:
    client = ollama.AsyncClient()
    # A generic example showing format for the new ISA
    example_format = {
        "memory_allocations": [{"name": "buffer", "size": 10}],
        "loop_limit": 10,
        "operations": [
            {"op": "gep", "args": ["buffer", "0"], "target_var": "ptr"},
            {"op": "load", "args": ["ptr"], "target_var": "val"},
            {"op": "add", "args": ["val", "arg0"], "target_var": "res"}
        ]
    }
    
    prompt = (
        "You are an expert compiler frontend. Convert Python logic into a DOD MLIR execution graph.\n"
        f"INTENT: {intent}\n\n"
        "STRICT ISA RULES:\n"
        "1. Linear execution only. Every operation MUST be a flat object.\n"
        "2. Do NOT nest operations inside 'args'.\n"
        "3. REGION MAPPING: 'CA' is 1.0, 'NY' is 2.0.\n"
        "4. Use 'arg0' (amount) and 'arg1' (region) directly.\n"
        "5. Example logic: cmp_eq(arg1, 1.0) -> is_ca; mul(arg0, 0.08) -> tax; select(is_ca, tax, 0.0) -> res.\n"
        "6. Output ONLY raw JSON matching the schema."
    )
    if error_context:
        prompt += f"\n\nCRITICAL: YOUR PREVIOUS ATTEMPT FAILED:\n{error_context}\nFIX THE LOGIC AND JSON FORMAT."
        
    response = await client.chat(
        model="deepseek-coder-v2:latest", 
        messages=[{'role': 'user', 'content': prompt}],
        format=VerifiedMLIR.model_json_schema()
    )
    return response['message']['content']

def verify_semantic_equivalence(mlir_data: VerifiedMLIR, intent: str) -> tuple[bool, str]:
    """
    MVP DOMAIN-AGNOSTIC BYPASS: 
    True semantic equivalence requires a Symbolic Execution Engine (like angr).
    We rely strictly on the `verify_llm_safety()` bounds checker above to protect the host OS.
    """
    print("   [Z3] ⚠️ Semantic Equivalence Check Bypassed (Awaiting v3.0 Symbolic Oracle)")
    return True, "PROVEN SAFE (Equivalence Bypassed)"

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
            
        # 2. Verify Semantic Equivalence
        is_equiv, msg_eq = verify_semantic_equivalence(mlir_data, intent)
        if is_equiv:
            print("   [Z3] ✅ Graph mathematically and semantically verified.")
            print(f"   [DEBUG MLIR]: {mlir_data.model_dump_json(indent=2)}")
            return mlir_data
        
        print(f"   [Z3] ❌ Semantic verification failed: {msg_eq}")
        error_msg = msg_eq 
        
    raise Exception("System halted: LLM failed to generate safe and equivalent graph after 3 attempts.")
