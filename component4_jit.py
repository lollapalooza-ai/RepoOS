import ctypes
from mlir.ir import Context, Module
from mlir.execution_engine import ExecutionEngine
from mlir.passmanager import PassManager

# Standardize on f64 for our kernels
TYPE_MAP = {
    'int': ctypes.c_int32,
    'float': ctypes.c_double,
    'double': ctypes.c_double,
    'bool': ctypes.c_bool,
    'void': None
}

def map_python_signature_to_llvm(type_hints: dict):
    # For now, we standardize on double for the formal MLIR transition
    ctypes_args = []
    for arg_name, type_str in type_hints.items():
        c_t = TYPE_MAP.get(type_str.lower(), ctypes.c_double)
        ctypes_args.append(c_t)
    return None, ctypes_args # ir_arg_types is handled by MLIR builtin

class PolyKernelMLIRJIT:
    def __init__(self):
        self.ctx = Context()
        self.engines = [] # Keep references alive to prevent GC crashes

    def load_and_compile(self, mlir_filepath: str, func_name: str, ctypes_signature=None):
        """
        Reads lowered MLIR text, JIT compiles to RAM, and returns a callable Python C-function pointer.
        """
        with open(mlir_filepath, "r") as f:
            mlir_text = f.read()

        with self.ctx:
            # 1. Parse the cached MLIR text
            module = Module.parse(mlir_text)
            
            # 2. Final Execution Engine Lowering (creates machine code in RAM)
            # opt_level=3 gives us the aggressive AVX-512/NEON vectorization
            engine = ExecutionEngine(module, opt_level=3)
            self.engines.append(engine)
            
            # 3. Extract the C-compatible function pointer
            # MLIR ExecutionEngine requires us to pass pointers to pointers for arguments
            def execution_wrapper(*args):
                # Convert Python/ctypes args to pointers for MLIR ABI
                # Ensure we handle various numeric types consistently
                arg_pointers = []
                for arg in args:
                    if isinstance(arg, (int, float)):
                        arg_pointers.append(ctypes.pointer(ctypes.c_double(float(arg))))
                    else:
                        # Handle pointers (like byte buffers or structs)
                        arg_pointers.append(ctypes.pointer(arg))

                result = ctypes.c_double(0.0)
                res_pointer = ctypes.pointer(result)
                
                # Execute the bare-metal code
                # The MLIR ABI: first arg is pointer to result, followed by pointers to arguments
                engine.invoke(func_name, res_pointer, *arg_pointers)
                return result.value

            return execution_wrapper

# Legacy Alias for transition
PolyKernelJIT = PolyKernelMLIRJIT
