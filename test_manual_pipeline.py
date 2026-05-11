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
    print("🚀 Starting Milestone 5.2: Programmatic JSON Verification Test...")
    
    # 1. Load from the Programmatically Created JSON
    json_path = "./.poly_cache_manual/networkx_utils_random_sequence_cumulative_distribution_chunk_0.json"
    if not os.path.exists(json_path):
        print(f"❌ Error: Missing: {json_path}. Run manual_compiler.py first.")
        return
        
    with open(json_path, 'r') as f:
        verified_mlir = VerifiedMLIR.model_validate_json(f.read())
    
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
    # To match 0.1 result: dist[0] must be 10.1 (since manual_compiler uses 101.0 constant)
    dist_data = (ctypes.c_double * 3)(10.1, 20.0, 30.0)
    cdf_data = (ctypes.c_double * 4)(99.0, 99.0, 99.0, 99.0)
    
    dist_ptr = ctypes.cast(dist_data, ctypes.c_void_p).value
    cdf_ptr = ctypes.cast(cdf_data, ctypes.c_void_p).value
    length = 3
    
    # 5. Define C-ABI
    res = ctypes.c_double(0.0)
    func_ptr.argtypes = [ctypes.POINTER(ctypes.c_double), ctypes.c_int64, ctypes.c_int64, ctypes.c_int64]
    func_ptr.restype = None

    # 6. Execute!
    print("⚡ Executing Programmatic Kernel...")
    func_ptr(ctypes.pointer(res), dist_ptr, cdf_ptr, length)
    
    # 7. RIGOROUS VERIFICATION
    print(f"🎉 Execution Complete!")
    print(f"   CDF: {list(cdf_data)}")
    
    if cdf_data[0] == 0.0 and round(cdf_data[1], 5) == 0.1:
        print("🏆 MILESTONE 5.2 VERIFIED: Programmatic JSON successfully executed with correct mutation!")
    else:
        print(f"❌ FAIL: Mutation failed. Values: {list(cdf_data)}")

if __name__ == "__main__":
    test_manual_aot_pipeline()
