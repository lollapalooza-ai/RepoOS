import ctypes
import llvmlite.ir as ir
from component4_jit import map_python_signature_to_llvm

def test_milestone3_abi():
    print("--- [TEST] Milestone 3: Dynamic ABI Mapping ---")
    type_hints = {"val": "float", "name": "str"}
    ir_args, ctypes_args = map_python_signature_to_llvm(type_hints)
    
    print(f"IR Args: {ir_args}")
    print(f"Ctypes Args: {ctypes_args}")
    
    # Check types
    assert isinstance(ir_args[0], ir.DoubleType)
    assert isinstance(ir_args[1], ir.PointerType)
    assert ctypes_args[0] == ctypes.c_double
    assert ctypes_args[1] == ctypes.c_char_p
    
    print("✅ Dynamic ABI Mapping Correct.")

if __name__ == "__main__":
    test_milestone3_abi()
