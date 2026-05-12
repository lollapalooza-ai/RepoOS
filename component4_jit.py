import ctypes
import os

# Milestone 5: High-Stability AOT Kernel Loader
# Bypasses MLIR ExecutionEngine entirely to use Native Shared Libraries (.dylib)

class PolyKernelMLIRJIT:
    def __init__(self):
        self.libraries = [] # Keep references to CDLLs to prevent unloading

    def load_and_compile(self, mlir_filepath: str, func_name: str, return_type="f64"):
        """
        MILESTONE 5: Loads a pre-compiled .dylib and returns a C-compatible caller.
        """
        dylib_path = mlir_filepath.replace('.mlir', '.dylib')
        if not os.path.exists(dylib_path):
            raise FileNotFoundError(f"AOT Kernel not found: {dylib_path}. Run component9_aot.py first.")

        # 1. Load the native shared library
        lib = ctypes.CDLL(dylib_path)
        self.libraries.append(lib)
        
        # 2. Extract the C-interface symbol
        ciface_name = f"_mlir_ciface_{func_name}"
        try:
            func_ptr = getattr(lib, ciface_name)
        except AttributeError:
            func_ptr = getattr(lib, func_name)
            
        def execution_wrapper(*args):
            # Define ABI ONCE
            if func_ptr.argtypes is None:
                arg_types = []
                if return_type != "void":
                    arg_types.append(ctypes.POINTER(ctypes.c_double))
                
                for arg in args:
                    if isinstance(arg, int):
                        arg_types.append(ctypes.c_void_p)
                    elif isinstance(arg, float):
                        arg_types.append(ctypes.c_double)
                    else:
                        arg_types.append(type(arg))
                func_ptr.argtypes = arg_types
                func_ptr.restype = None 
            
            if return_type == "void":
                func_ptr(*args)
                return None
            
            # 1. Prepare result buffer
            result = ctypes.c_double(0.0)
            
            # 2. Execute
            func_ptr(ctypes.pointer(result), *args)
            return result.value

        return execution_wrapper

PolyKernelJIT = PolyKernelMLIRJIT

def map_python_signature_to_llvm(type_hints: dict):
    # Legacy helper for compatibility
    return None, [ctypes.c_double for _ in type_hints]
