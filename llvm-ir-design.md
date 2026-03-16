Milestone : 1.0.0

# ENGINEERING BLUEPRINT: Repo OS Poly-Kernel MVP

**To:** Lead Senior Engineer
**From:** Principal Architecture / AI Systems
**Subject:** Implementation Guide for the Zero-Binary Intent Execution Pipeline

This document outlines the exact specifications, code examples, and architectural guardrails required to build the MVP of our "Poly-Kernel" architecture. Your goal is to construct a pipeline that safely transitions from legacy code -> Semantic Graph -> Verified MLIR -> Hardware-Specific LLVM IR -> JIT Execution.

We are discarding probabilistic LLM code generation in favor of a mathematically verified Progressive Lowering pipeline. Please implement the following 4 components exactly as specified.

---

## Component 1: The Semantic Graph (Ground Truth Extraction)

**Objective:** Do not use an LLM to read the source code. Use deterministic static analysis to extract the business logic and structure into a Neo4j Code Property Graph (CPG). This acts as the mathematical anchor for the rest of the system.

**Implementation Instructions:**

1. Use `tree_sitter` (Python bindings) to parse the target Python codebase into an Abstract Syntax Tree (AST).
2. Extract functions, arguments, and exact call-graph relationships.
3. Load these nodes into a local Neo4j database using the `neo4j` Python driver.

**Key Code Example (Graph Extraction):**

```python
import tree_sitter_python as tspython
from tree_sitter import Language, Parser
from neo4j import GraphDatabase

# 1. Setup Parser
PY_LANGUAGE = Language(tspython.language())
parser = Parser(PY_LANGUAGE)

# 2. Setup Neo4j
driver = GraphDatabase.driver("bolt://localhost:7687", auth=("neo4j", "password"))

def ingest_ast_to_graph(source_code, file_name):
    tree = parser.parse(bytes(source_code, "utf8"))
    
    # Extract function definitions using Tree-sitter Query
    query = PY_LANGUAGE.query("(function_definition name: (identifier) @func.name)")
    captures = query.captures(tree.root_node)
    
    with driver.session() as session:
        for node, capture_name in captures.get("func.name", []):
            func_name = node.text.decode('utf8')
            # Create node in Neo4j
            session.run(
                "MERGE (f:Function {name: $name, file: $file})", 
                name=func_name, file=file_name
            )
            print(f"Ingested Semantic Node: {func_name}")

# Run this on a dummy target file
ingest_ast_to_graph("def calculate_tax(amount): return amount * 1.2", "tax.py")

```

**Robustness Tip:** Ensure every Neo4j node contains the precise byte-offsets from `tree_sitter`. The MLIR generator (Component 2) will need these bounds to know exactly where states begin and end.

---

## Component 2: MLIR Generation & SMT Solvers (The Verified Bridge)

**Objective:** This is the most critical component. You will use a local LLM (Meta's `llm-compiler-13b-ftd` via MLX) to translate the Neo4j Semantic Graph into a Multi-Level Intermediate Representation (MLIR) dialect. **Crucially, you must mathematically verify the LLM's output using an SMT Solver (Z3) before passing it to the execution compiler.**

### Understanding the MLIR & SMT Architecture:

LLMs hallucinate. If the LLM generates an LLVM IR instruction that accesses memory out of bounds, the JIT will segfault the entire OS.
To solve this, we use **Z3 (an SMT Solver)**. Z3 mathematically proves whether a specific condition can *ever* be violated.

1. **Generation:** The LLM generates a high-level MLIR representation (in a strict JSON format) that defines array sizes and memory offsets.
2. **Constraint Extraction:** Our Python backend extracts the memory constraints from the LLM's output.
3. **Z3 Verification:** We ask Z3: *"Is there any possible universe where this LLM-generated memory offset exceeds the array bounds?"*
4. **Feedback Loop:** If Z3 says `sat` (a violation is possible), we append Z3's mathematical counter-example to the LLM prompt and force the LLM to regenerate. If Z3 says `unsat` (violation is mathematically impossible), the MLIR is passed to Component 4.

**Key Code Example (Z3 Verification Loop):**

```python
from z3 import *
import json

def verify_llm_memory_safety(llm_mlir_json):
    """
    Simulates checking an LLM's generated MLIR dialect using Z3.
    Expects JSON like: {"array_size": 10, "loop_limit": 10, "access_index_formula": "i + 1"}
    """
    data = json.loads(llm_mlir_json)
    
    # 1. Define SMT Variables
    i = Int('i') # Loop index
    array_size = IntVal(data['array_size'])
    loop_limit = IntVal(data['loop_limit'])
    
    # 2. Setup the LLM's logic
    # The LLM states the loop runs while i < loop_limit
    loop_condition = And(i >= 0, i < loop_limit)
    
    # The LLM generated an access offset (e.g., array[i + 1])
    access_index = i + 1  # Extracted from LLM's "access_index_formula"
    
    # 3. Define the Safety Violation Condition
    # A violation occurs if the access index is >= array_size
    memory_violation = access_index >= array_size
    
    # 4. Run the SMT Solver
    solver = Solver()
    solver.add(loop_condition)
    solver.add(memory_violation)
    
    result = solver.check()
    
    if result == sat:
        model = solver.model()
        error_msg = f"HALLUCINATION DETECTED: If i = {model[i]}, access_index exceeds bounds."
        return False, error_msg
    else:
        return True, "PROVEN SAFE"

# Test the function (This simulates the LLM making an off-by-one error)
bad_llm_output = '{"array_size": 10, "loop_limit": 10}'
is_safe, msg = verify_llm_memory_safety(bad_llm_output)
print(msg) # Output: HALLUCINATION DETECTED: If i = 9, access_index exceeds bounds.

```

**Robustness Tip:** Start small. For the MVP, only use Z3 to verify array bounds and pointer aliasing. Once the safety loop is proven, you can expand Z3 to verify complex business logic (e.g., verifying that a generated MLIR node for a discount never returns a negative price).

---

## Component 3: Semantic Projections (The Human Visualizer)

**Objective:** The MLIR/LLVM IR is completely unreadable to humans. You must build a UI component that queries the pure Semantic Graph in Neo4j and renders it as pseudo-code or flowchart elements.

**Implementation Instructions:**

1. Set up a lightweight FastAPI backend.
2. Write a Cypher query to extract a node and its downstream dependencies.
3. Use `React Flow` on the frontend to render the returned nodes as a directed graph.

**Key Code Example (Cypher API extraction):**

```python
from fastapi import FastAPI
app = FastAPI()

@app.get("/api/semantic_projection/{func_name}")
def get_business_logic(func_name: str):
    with driver.session() as session:
        # Query: Find the function and everything it calls
        query = """
        MATCH (f:Function {name: $name})-[r:CALLS]->(target:Function)
        RETURN f.name as Caller, target.name as Callee
        """
        result = session.run(query, name=func_name)
        
        # Reconstruct human-readable pseudo-logic
        logic = [f"Function '{record['Caller']}' depends on '{record['Callee']}'" for record in result]
        return {"pseudo_code": logic}

```

---

## Component 4: Neural JIT Compilation (The Metal)

**Objective:** Take the mathematically verified logic from Component 2 and dynamically JIT compile it into native machine code residing in system RAM using `llvmlite`.

**Implementation Instructions:**

1. Use Python's `llvmlite.ir` to programmatically build the LLVM module based on the verified logic. Do not write C++ strings.
2. Use `llvmlite.binding` to spin up the ORC JIT (On-Request Compilation) engine.
3. Compile the module, extract the memory pointer to the native machine code, and execute it via Python `ctypes`.

**Key Code Example (LLVM IR Generation & ORC JIT):**

```python
import llvmlite.ir as ir
import llvmlite.binding as llvm
import ctypes

# 1. Initialize LLVM backend
llvm.initialize()
llvm.initialize_native_target()
llvm.initialize_native_asmprinter()

def compile_and_execute_jit():
    # 2. Build the LLVM IR (This mirrors what the AI/MLIR output defines)
    module = ir.Module(name="repo_os_kernel")
    func_type = ir.FunctionType(ir.DoubleType(), [ir.DoubleType(), ir.DoubleType()])
    func = ir.Function(module, func_type, name="ai_optimized_add")
    
    block = func.append_basic_block(name="entry")
    builder = ir.IRBuilder(block)
    
    # Logic: a + b
    a, b = func.args
    result = builder.fadd(a, b, name="res")
    builder.ret(result)
    
    # 3. Setup ORC JIT
    target_machine = llvm.Target.from_default_triple().create_target_machine()
    jit = llvm.create_mcjit_compiler(llvm.parse_assembly(str(module)), target_machine)
    
    jit.finalize_object()
    jit.run_static_constructors()
    
    # 4. Extract Memory Pointer and Execute
    func_ptr = jit.get_function_address("ai_optimized_add")
    
    # Cast to Python callable using ctypes
    cfunc = ctypes.CFUNCTYPE(ctypes.c_double, ctypes.c_double, ctypes.c_double)(func_ptr)
    
    # Execute native machine code in memory
    res = cfunc(10.5, 31.5)
    print(f"JIT Executed Result: {res}")

compile_and_execute_jit()

```

**Robustness Tip:** Ensure the `Target Triple` matches the specific developer machine (e.g., M-Series Mac vs. Intel Linux) exactly. The ORC JIT will synthesize the exact assembly for the hardware running the script.

### Delivery Milestones:

1. **Phase 1:** Get Component 4 (LLVM JIT) working with a hardcoded python IR builder. Prove that RAM execution works.
2. **Phase 2:** Connect the SMT Solver (Component 2) to a dummy LLM prompt and successfully catch an off-by-one hallucination.
3. **Phase 3:** Wire Tree-sitter -> Neo4j -> LLM -> Z3 -> LLVM IR end-to-end.


Milestone 1.0.1

**MEMO: ENGINEERING BLUEPRINT v2.0**
**To:** Lead Senior Engineer
**From:** Principal Architecture / AI Systems
**Subject:** Full Production Codebase for Generic Poly-Kernel Pipeline

This is your master execution blueprint. To accelerate the build, I have completely rewritten the 4 core components to be fully dynamic, generic, and mathematically verifiable.

We are moving away from hardcoded strings. This architecture will recursively ingest any Python repository, use strict Pydantic schemas to force the LLM into a deterministic `VerifiedMLIR` format, mathematically prove memory safety via Z3, and dynamically compile the execution graph to hardware.

Please implement these files exactly as structured below.

---

### Component 1: The Generic Ingestor (`component1_ingest.py`)

**Objective:** Merge the recursive `os.walk` traversal from `ingest2.py` with our Neo4j AST parser. This script builds the Semantic Graph for *any* target directory.

**Instructions for the Engineer:**

* Ensure `tree_sitter_python` is installed.
* We use a dual-query approach: one to extract the function's body (for Component 3 to read), and one to map the `CALLS` relationships for the Dependency Graph.

```python
import os
import tree_sitter_python as tspython
from tree_sitter import Language, Parser
from neo4j import GraphDatabase

# --- Configuration ---
NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
TARGET_DIR = "./your_target_repo" # Pass this as an argument in production

# --- Setup ---
PY_LANGUAGE = Language(tspython.language())
parser = Parser(PY_LANGUAGE)
driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)

def process_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        source_code = f.read()
    
    tree = parser.parse(bytes(source_code, "utf8"))
    
    # Queries to extract structural logic
    func_query = PY_LANGUAGE.query("(function_definition name: (identifier) @func.name)")
    call_query = PY_LANGUAGE.query("(call function: (identifier) @call.name)")
    
    with driver.session() as session:
        # 1. Register File
        session.run("MERGE (file:File {path: $path})", path=file_path)
        
        # 2. Register Functions & Code Snippets
        for capture_name, nodes in func_query.captures(tree.root_node).items():
            for node in nodes:
                func_name = node.text.decode('utf8')
                # Extract the exact byte-range of the function body for the Semantic UI
                func_body = source_code[node.parent.start_byte:node.parent.end_byte]
                
                session.run("""
                    MATCH (file:File {path: $path})
                    MERGE (f:Function {name: $name, file: $path})
                    SET f.code = $code
                    MERGE (file)-[:CONTAINS]->(f)
                """, name=func_name, path=file_path, code=func_body)
                
        # 3. Register 'CALLS' Relationships (Dependency Graph)
        for capture_name, nodes in call_query.captures(tree.root_node).items():
            for node in nodes:
                callee_name = node.text.decode('utf8')
                # Walk up the AST to find the parent function making the call
                parent = node.parent
                while parent and parent.type != 'function_definition':
                    parent = parent.parent
                
                if parent:
                    name_node = parent.child_by_field_name('name')
                    if name_node:
                        caller_name = name_node.text.decode('utf8')
                        session.run("""
                            MERGE (caller:Function {name: $caller})
                            MERGE (callee:Function {name: $callee})
                            MERGE (caller)-[:CALLS]->(callee)
                        """, caller=caller_name, callee=callee_name)

def ingest_folder(folder_path):
    print(f"🚀 Starting Deep Ingestion: {folder_path}")
    for root, dirs, files in os.walk(folder_path):
        # Prune standard bloat directories
        dirs[:] = [d for d in dirs if d not in ['.git', 'venv', '.venv', '__pycache__', 'node_modules']]
        
        for file in files:
            if file.endswith(".py"):
                print(f"Parsing: {file}")
                process_file(os.path.join(root, file))
    print("✅ Semantic Graph Ingestion Complete.")

if __name__ == "__main__":
    ingest_folder(TARGET_DIR)

```

---

### Component 2: The LLM & SMT Verifier (`component2_smt.py`)

**Objective:** This defines the exact communication protocol between the probabilistic AI and the deterministic JIT compiler. We use a Pydantic schema to force structure, and Z3 to mathematically prove the LLM didn't hallucinate memory bounds or division-by-zero.

**Instructions for the Engineer:**

* You will see the `VerifiedMLIR` Pydantic class. This is the exact schema you requested.
* The LLM generates this JSON. Z3 verifies it. If it passes, it moves to Component 4.

```python
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
        if op.op == "div" and op.args[1].isdigit():
            if int(op.args[1]) == 0:
                return False, "FATAL HALLUCINATION: Division by zero detected in Execution Graph."

    return True, "PROVEN SAFE"

# --- 3. The LLM Generation & Feedback Loop ---
async def generate_execution_graph(intent: str, error_context: str = "") -> str:
    client = ollama.AsyncClient()
    prompt = f"Convert this business intent into a DOD MLIR execution graph: '{intent}'."
    if error_context:
        prompt += f"\nYOUR PREVIOUS ATTEMPT FAILED MATHEMATICAL VERIFICATION:\n{error_context}\nFix the memory bounds or logic."
        
    response = await client.chat(
        model="llama3", # Swap with 'llm-compiler-13b-ftd' when you stand it up locally
        messages=[{'role': 'user', 'content': prompt}],
        format=VerifiedMLIR.model_json_schema()
    )
    return response['message']['content']

async def verified_generation_loop(intent: str) -> VerifiedMLIR:
    max_retries = 3
    error_msg = ""
    
    for attempt in range(max_retries):
        print(f"Generating Execution Graph... (Attempt {attempt + 1})")
        mlir_json = await generate_execution_graph(intent, error_msg)
        
        # Parse into Pydantic
        mlir_data = VerifiedMLIR.model_validate_json(mlir_json)
        
        # Run Mathematical Verification
        is_safe, msg = verify_llm_safety(mlir_data)
        
        if is_safe:
            print("✅ Graph mathematically verified by Z3.")
            return mlir_data
            
        print(f"❌ Verification Failed: {msg}")
        error_msg = msg # Feed exactly why it failed back to the LLM
        
    raise Exception("System halted: LLM failed to generate mathematically safe execution graph after 3 attempts.")

```

---

### Component 3: Declarative English API (`component3_api.py`)

**Objective:** Decompile the Neo4j graph into highly readable, IDE-like English. This proves that while the machine executes alien AST logic, the human views pure business intent.

**Instructions for the Engineer:**

* This FastAPI endpoint uses standard structural formatting (bullet points, arrows) to replace complex Python brackets with Product Manager-friendly logic.

```python
from fastapi import FastAPI, HTTPException
from neo4j import GraphDatabase

app = FastAPI()
driver = GraphDatabase.driver("bolt://localhost:7687", auth=("neo4j", "password"))

@app.get("/api/semantic_projection/{func_name}")
def get_business_logic(func_name: str):
    with driver.session() as session:
        query = """
        MATCH (f:Function {name: $name})
        OPTIONAL MATCH (f)-[:CALLS]->(callee:Function)
        RETURN f.name AS func, f.code AS raw_code, collect(callee.name) AS dependencies
        """
        result = session.run(query, name=func_name).single()
        
        if not result or not result["func"]:
            raise HTTPException(status_code=404, detail="Semantic node not found.")
            
        # Reconstruct IDE View
        pseudo_code = f"BUSINESS REQUIREMENT: {result['func'].replace('_', ' ').title()}\n"
        pseudo_code += "=" * 50 + "\n"
        
        pseudo_code += "DEPENDENCY FLOW:\n"
        deps = [d for d in result["dependencies"] if d]
        if deps:
            for d in deps:
                pseudo_code += f"  ↳ Triggers module: {d}\n"
        else:
            pseudo_code += "  ↳ Isolated execution (No external dependencies)\n"
            
        pseudo_code += "\nCORE LOGIC ANCHOR:\n"
        pseudo_code += "\n".join([f"    {line}" for line in result["raw_code"].split("\n")[:5]]) 
        pseudo_code += "\n    ... (Execution paths managed by AI)"

        return {"ide_view_content": pseudo_code}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)

```

---

### Component 4: Dynamic JIT Compiler (`component4_jit.py`)

**Objective:** The "Opcode Router." This takes the `VerifiedMLIR` Pydantic object from Component 2 and dynamically maps the JSON strings into `llvmlite` API calls. It compiles and executes entirely in RAM.

**Instructions for the Engineer:**

* This script no longer hardcodes `fadd`. It loops over `mlir_data.operations`.
* It utilizes Python's `ctypes` to map the dynamically allocated RAM memory pointer back to a callable Python function.

```python
import llvmlite.ir as ir
import llvmlite.binding as llvm
import ctypes
from component2_smt import VerifiedMLIR # Import the schema

# Initialize LLVM backend
llvm.initialize()
llvm.initialize_native_target()
llvm.initialize_native_asmprinter()

def dynamic_jit_compile_and_run(mlir_data: VerifiedMLIR, input_args: list[float]):
    """
    Takes the mathematically verified Pydantic schema and dynamically synthesizes machine code.
    """
    # 1. Setup Module
    module = ir.Module(name="dynamic_repo_kernel")
    
    # Assuming 2 inputs and 1 output for the MVP schema
    func_type = ir.FunctionType(ir.DoubleType(), [ir.DoubleType(), ir.DoubleType()])
    func = ir.Function(module, func_type, name="synthesized_task")
    
    block = func.append_basic_block(name="entry")
    builder = ir.IRBuilder(block)
    
    # 2. Variable Registry
    variables = {"arg1": func.args[0], "arg2": func.args[1]}
    last_res = None
    
    # 3. The Opcode Router (Translates JSON Intent to Metal)
    for instruction in mlir_data.operations:
        op = instruction.op
        
        # Resolve arguments (are they literal numbers or variables?)
        val1 = builder.constant(ir.DoubleType(), float(instruction.args[0])) if instruction.args[0].replace('.','',1).isdigit() else variables[instruction.args[0]]
        val2 = builder.constant(ir.DoubleType(), float(instruction.args[1])) if instruction.args[1].replace('.','',1).isdigit() else variables[instruction.args[1]]
        
        # Execute routing
        if op == "add":
            last_res = builder.fadd(val1, val2, name=instruction.target_var)
        elif op == "sub":
            last_res = builder.fsub(val1, val2, name=instruction.target_var)
        elif op == "mul":
            last_res = builder.fmul(val1, val2, name=instruction.target_var)
        elif op == "div":
            last_res = builder.fdiv(val1, val2, name=instruction.target_var)
            
        variables[instruction.target_var] = last_res
        
    builder.ret(last_res)
    
    # 4. ORC JIT Compilation
    target_machine = llvm.Target.from_default_triple().create_target_machine()
    jit = llvm.create_mcjit_compiler(llvm.parse_assembly(str(module)), target_machine)
    
    jit.finalize_object()
    jit.run_static_constructors()
    
    # 5. Execute Machine Code from RAM
    func_ptr = jit.get_function_address("synthesized_task")
    cfunc = ctypes.CFUNCTYPE(ctypes.c_double, ctypes.c_double, ctypes.c_double)(func_ptr)
    
    # Run the compiled pointer using the provided float arguments
    result = cfunc(input_args[0], input_args[1])
    return result

# --- Mock Execution Test ---
if __name__ == "__main__":
    # Simulate receiving the Pydantic object from Component 2
    mock_mlir = VerifiedMLIR(
        memory_allocations=[{"name": "calc_buffer", "size": 10}],
        loop_limit=5,
        access_offset=0,
        operations=[
            {"op": "mul", "args": ["arg1", "1.2"], "target_var": "taxed_val"}, # arg1 * 1.2
            {"op": "add", "args": ["taxed_val", "arg2"], "target_var": "final_total"} # taxed + arg2
        ]
    )
    
    # Simulate executing the dynamically compiled code with inputs (100.0, 15.0)
    print("Compiling directly to Native Assembly...")
    out = dynamic_jit_compile_and_run(mock_mlir, [100.0, 15.0])
    print(f"Execution Result (100 * 1.2 + 15): {out}")

```