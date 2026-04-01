import llvmlite.ir as ir
import llvmlite.binding as llvm
import ctypes

def test_simple_jit():
    # 1. Initialize
    llvm.initialize()
    llvm.initialize_native_target()
    llvm.initialize_native_asmprinter()
    
    # 2. Create Module
    module = ir.Module(name="test_mod")
    triple = llvm.Target.from_default_triple().triple
    module.triple = triple
    
    # define double @add(double %a, double %b)
    func_type = ir.FunctionType(ir.DoubleType(), [ir.DoubleType(), ir.DoubleType()])
    func = ir.Function(module, func_type, name="add")
    block = func.append_basic_block(name="entry")
    builder = ir.IRBuilder(block)
    res = builder.fadd(func.args[0], func.args[1], name="res")
    builder.ret(res)
    
    print(f"Generated IR:\n{str(module)}")
    
    # 3. Compile
    llvm_mod = llvm.parse_assembly(str(module))
    target_machine = llvm.Target.from_triple(triple).create_target_machine()
    
    # Use newer engine if possible? (mcjit is default)
    with llvm.create_mcjit_compiler(llvm.parse_assembly(""), target_machine) as engine:
        engine.add_module(llvm_mod)
        engine.finalize_object()
        func_ptr = engine.get_function_address("add")
        
        print(f"Function Pointer: {hex(func_ptr)}")
        
        # 4. Call
        add_func = ctypes.CFUNCTYPE(ctypes.c_double, ctypes.c_double, ctypes.c_double)(func_ptr)
        
        print("Calling function...")
        result = add_func(10.5, 20.5)
        print(f"Result: {result}")
        assert result == 31.0
        print("✅ Simple JIT Test Passed!")

if __name__ == "__main__":
    test_simple_jit()
