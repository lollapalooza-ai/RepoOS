import os
import json
import ctypes
import sys
import shutil

# Add project root to path
sys.path.append(os.getcwd())

from component2_smt import VerifiedMLIR, MLIROperation
from component9_aot import build_and_cache_mlir, sanitize_fqn

def test_manual_aot_pipeline():
    print("🚀 Starting Milestone 5.2: Absolute In-Memory Verification Test...")
    
    # 1. Define the kernel IN-MEMORY to avoid stale file issues
    cd_fqn = "networkx.utils.random_sequence.cumulative_distribution.chunk_0"
    verified_mlir = VerifiedMLIR(
        function_name=sanitize_fqn(cd_fqn),
        thinking_process="Direct address mutation verification.",
        signature={
            "dist_ptr": "ptr",
            "cdf_ptr": "ptr", 
            "arg_len": "i64",
            "return": "void"
        },
        arg_mapping=[], 
        operations=[
            # Constants
            MLIROperation(dialect="arith", op="constant", args=["0"], target_var="%c0", attributes={"type": "i64"}),
            MLIROperation(dialect="arith", op="constant", args=["1"], target_var="%c1", attributes={"type": "i64"}),
            MLIROperation(dialect="arith", op="constant", args=["0.0"], target_var="%f0", attributes={"type": "f64"}),
            MLIROperation(dialect="arith", op="constant", args=["0.1"], target_var="%f0_1", attributes={"type": "f64"}),
            
            # Explicit Stores to physical memory
            MLIROperation(dialect="llvm", op="store", args=["%f0", "cdf_ptr"]),
            
            MLIROperation(dialect="llvm", op="getelementptr", args=["cdf_ptr", "%c1"], target_var="%out_ptr"),
            MLIROperation(dialect="llvm", op="store", args=["%f0_1", "%out_ptr"]),
            
            MLIROperation(dialect="func", op="return", args=[])
        ]
    )
    
    # 2. Lower and Compile
    cache_base_path = "./.poly_cache_manual/test_output"
    dylib_path = cache_base_path + ".dylib"
    if os.path.exists(dylib_path): os.remove(dylib_path)
    
    build_and_cache_mlir(verified_mlir, cache_base_path + ".json")
    
    if not os.path.exists(dylib_path):
        print(f"❌ Error: Dylib not generated at {dylib_path}")
        return
        
    # 3. Load the Native Shared Library
    lib = ctypes.CDLL(dylib_path)
    func_ptr = getattr(lib, verified_mlir.function_name)

    # 4. Prepare Data
    dist_data = (ctypes.c_double * 3)(10.0, 20.0, 30.0)
    cdf_data = (ctypes.c_double * 4)(99.0, 99.0, 99.0, 99.0)
    
    dist_ptr = ctypes.cast(dist_data, ctypes.c_void_p).value
    cdf_ptr = ctypes.cast(cdf_data, ctypes.c_void_p).value
    length = 3
    
    # 5. Define C-ABI
    res = ctypes.c_double(0.0)
    func_ptr.argtypes = [ctypes.POINTER(ctypes.c_double), ctypes.c_int64, ctypes.c_int64, ctypes.c_int64]
    func_ptr.restype = None

    # 6. Execute!
    print("⚡ Executing In-Memory Kernel...")
    func_ptr(ctypes.pointer(res), dist_ptr, cdf_ptr, length)
    
    # 7. RIGOROUS VERIFICATION
    print(f"🎉 Execution Complete!")
    print(f"   CDF[0] state: {cdf_data[0]} (Expected: 0.0)")
    print(f"   CDF[1] state: {cdf_data[1]} (Expected: 0.1)")
    
    if cdf_data[0] == 0.0 and round(cdf_data[1], 5) == 0.1:
        print("🏆 MILESTONE 5.2 VERIFIED: In-memory mutation successful!")
    else:
        print(f"❌ FAIL: Mutation failed. Values: [{cdf_data[0]}, {cdf_data[1]}]")

if __name__ == "__main__":
    test_manual_aot_pipeline()
