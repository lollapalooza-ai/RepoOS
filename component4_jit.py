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
        def resolve_arg(arg_str):
            if arg_str in variables:
                return variables[arg_str]
            try:
                # Try to parse as float literal
                return ir.Constant(ir.DoubleType(), float(arg_str))
            except ValueError:
                # If not a known variable and not a float, default to 0.0 or raise error
                # For MVP, let's just use 0.0
                return ir.Constant(ir.DoubleType(), 0.0)

        val1 = resolve_arg(instruction.args[0])
        val2 = resolve_arg(instruction.args[1])
        
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
        
    # If no operations, return 0.0 or something sensible
    if last_res is None:
        last_res = builder.constant(ir.DoubleType(), 0.0)
        
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
