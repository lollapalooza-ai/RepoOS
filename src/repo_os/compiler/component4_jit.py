import ctypes
import os
import numpy as np

# --- 1. ABI-compliant MLIR MemRef Struct for 1D arrays ---
class MemRef1D_f64(ctypes.Structure):
    _fields_ = [
        ("allocatedPtr", ctypes.POINTER(ctypes.c_double)),
        ("alignedPtr", ctypes.POINTER(ctypes.c_double)),
        ("offset", ctypes.c_longlong),
        ("sizes", ctypes.c_longlong * 1),
        ("strides", ctypes.c_longlong * 1),
    ]

class MemRef1D_i64(ctypes.Structure):
    _fields_ = [
        ("allocatedPtr", ctypes.POINTER(ctypes.c_longlong)),
        ("alignedPtr", ctypes.POINTER(ctypes.c_longlong)),
        ("offset", ctypes.c_longlong),
        ("sizes", ctypes.c_longlong * 1),
        ("strides", ctypes.c_longlong * 1),
    ]

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
            use_ciface = True
        except AttributeError:
            func_ptr = getattr(lib, func_name)
            use_ciface = False
            
        def execution_wrapper(*args):
            final_args = []
            
            for arg in args:
                if hasattr(arg, '_type_') and issubclass(type(arg), ctypes.Array):
                    # For Bare Pointer ABI, we pass the raw pointer to the first element
                    final_args.append(ctypes.cast(arg, ctypes.POINTER(arg._type_)))
                else:
                    final_args.append(arg)

            # Prepare result buffer
            # Conv: Result is first argument if void return was used in signature but logic returns scalar
            # Our current component9 manual lowering handles return via result pointer
            result = ctypes.c_double(0.0)
            
            if func_ptr.argtypes is None:
                all_call_args = []
                if return_type != "void":
                    all_call_args.append(ctypes.pointer(result))
                all_call_args.extend(final_args)
                
                arg_types = []
                for a in all_call_args:
                    if isinstance(a, (ctypes._Pointer, ctypes.Array, ctypes.c_void_p)):
                        arg_types.append(ctypes.c_void_p)
                    elif isinstance(a, float) or isinstance(a, ctypes.c_double):
                        arg_types.append(ctypes.c_double)
                    elif isinstance(a, int) or isinstance(a, ctypes.c_longlong):
                        arg_types.append(ctypes.c_longlong)
                    else:
                        arg_types.append(type(a))
                func_ptr.argtypes = arg_types
                func_ptr.restype = None 

            if return_type == "void":
                func_ptr(*final_args)
                return None
            
            func_ptr(ctypes.pointer(result), *final_args)
            return result.value

        return execution_wrapper

PolyKernelJIT = PolyKernelMLIRJIT

def map_python_signature_to_llvm(type_hints: dict):
    # Legacy helper for compatibility
    return None, [ctypes.c_double for _ in type_hints]
