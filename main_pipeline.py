import json
from z3 import *
import llvmlite.ir as ir
import llvmlite.binding as llvm
import ctypes
from neo4j import GraphDatabase
import tree_sitter_python as tspython
from tree_sitter import Language, Parser

# --- Configuration ---
NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")

# --- Component 1 & 2: SMT Verification (Logic from component2_smt.py) ---
def verify_logic(mlir_json):
    data = json.loads(mlir_json)
    i = Int('i')
    array_size = IntVal(data.get('array_size', 10))
    loop_limit = IntVal(data.get('loop_limit', 10))
    
    # Access index formula i + offset
    offset = data.get('offset', 1)
    access_index = i + offset
    
    loop_condition = And(i >= 0, i < loop_limit)
    memory_violation = Or(access_index >= array_size, access_index < 0)
    
    solver = Solver()
    solver.add(loop_condition)
    solver.add(memory_violation)
    
    if solver.check() == sat:
        return False, f"Violation possible at i={solver.model()[i]}"
    return True, "Verified Safe"

# --- Component 4: JIT Compilation (Logic from component4_jit.py) ---
def jit_compile_and_run(a_val, b_val):
    llvm.initialize()
    llvm.initialize_native_target()
    llvm.initialize_native_asmprinter()
    
    module = ir.Module(name="verified_kernel")
    func_type = ir.FunctionType(ir.DoubleType(), [ir.DoubleType(), ir.DoubleType()])
    func = ir.Function(module, func_type, name="kernel_task")
    
    block = func.append_basic_block(name="entry")
    builder = ir.IRBuilder(block)
    
    a, b = func.args
    res = builder.fadd(a, b, name="result")
    builder.ret(res)
    
    target_machine = llvm.Target.from_default_triple().create_target_machine()
    jit = llvm.create_mcjit_compiler(llvm.parse_assembly(str(module)), target_machine)
    jit.finalize_object()
    
    func_ptr = jit.get_function_address("kernel_task")
    cfunc = ctypes.CFUNCTYPE(ctypes.c_double, ctypes.c_double, ctypes.c_double)(func_ptr)
    
    return cfunc(a_val, b_val)

# --- The Pipeline ---
def run_pipeline():
    print("--- Phase 3: End-to-End Pipeline ---")
    
    # 1. Simulate finding a function in Neo4j
    print("1. Fetching Semantic Ground Truth from Neo4j...")
    driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
    with driver.session() as session:
        result = session.run("MATCH (f:Function {name: 'calculate_tax'}) RETURN f.name")
        record = result.single()
        if record:
            print(f"   Found function: {record[0]}")
    
    # 2. Simulate LLM Generating MLIR
    print("2. LLM generating MLIR dialect (Simulated)...")
    # Scenario A: Safe (offset=0, loop=10, size=10 -> passes)
    mlir_output = json.dumps({"array_size": 10, "loop_limit": 10, "offset": 0})
    print(f"   MLIR: {mlir_output}")
    
    # 3. Z3 Verification
    print("3. Verifying MLIR safety via Z3 SMT Solver...")
    is_safe, msg = verify_logic(mlir_output)
    print(f"   Result: {msg}")
    
    if not is_safe:
        print("   ABORTING: Safety check failed.")
        return

    # 4. JIT Compilation
    print("4. Compiling and Executing via Neural JIT...")
    result = jit_compile_and_run(12.5, 2.5)
    print(f"   Success! Native Execution Result: {result}")

if __name__ == "__main__":
    run_pipeline()
