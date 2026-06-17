import os
import ctypes
import numpy as np
import torch
import asyncio
from component9_aot import RepoOSSchedule, apply_ai_transform_and_compile
from component5_orchestrator import to_memref

# 1. BASE MATH MLIR (Updated to true Destination-Passing Style)
# We pass the 'out' tensor as an argument to avoid internal mallocs.
BASE_MLIR = """
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @main(%arg0: tensor<4096x4096xf32>, %arg1: tensor<4096x4096xf32>, %arg2: tensor<4096x4096xf32>) -> tensor<4096x4096xf32> {
    %cst = arith.constant 2.000000e+00 : f32
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : tensor<4096x4096xf32>, tensor<4096x4096xf32>) outs(%arg2 : tensor<4096x4096xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %3 = arith.mulf %in, %in_0 : f32
      linalg.yield %3 : f32
    } -> tensor<4096x4096xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%1 : tensor<4096x4096xf32>) outs(%arg2 : tensor<4096x4096xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.addf %in, %cst : f32
      linalg.yield %3 : f32
    } -> tensor<4096x4096xf32>
    return %2 : tensor<4096x4096xf32>
  }
}
"""

# 2. EXACT AI OUTPUT
AI_PYTHON_SCRIPT = """
def apply_schedule(schedule):
    ops = schedule.match("linalg.generic")
    block_tiled = schedule.tile_to_blocks(ops, tile_sizes=[32, 32])
    inner_op = schedule.match("linalg.generic")
    thread_tiled = schedule.tile_to_threads(inner_op, tile_sizes=[4, 8])
    schedule.lower_to_nvvm(target_chip="x86_64 Linux")
"""

async def verify():
    print("--- 🔍 Isolated AI Schedule Verification (True DPS) ---")
    
    # Step A: Translate Python DSL to MLIR Transform
    print("[1/4] Translating AI Python DSL...")
    schedule = RepoOSSchedule()
    local_scope = {"schedule": schedule}
    exec(AI_PYTHON_SCRIPT, {}, local_scope)
    local_scope["apply_schedule"](schedule)
    transform_mlir = schedule.build_mlir()
    
    # Step B: Compile
    print("\n[2/4] Compiling Base MLIR + AI Schedule...")
    dylib_path = "./verify_kernel.so"
    if os.path.exists(dylib_path): os.remove(dylib_path)
    
    await apply_ai_transform_and_compile(
        BASE_MLIR, transform_mlir, dylib_path, is_gpu=False
    )
    
    if not os.path.exists(dylib_path):
        print("❌ Compilation Failed.")
        return

    print("✅ Compilation Successful.")

    # Step C: FFI Load & Execute
    print("\n[3/4] Loading Kernel and Executing (DPS)...")
    lib = ctypes.CDLL(dylib_path)
    # Check for both symbols
    kernel_func = getattr(lib, "main", getattr(lib, "_mlir_ciface_main", None))
    if not kernel_func:
        print("❌ Symbol not found.")
        return

    # In DPS, we provide 3 pointers: a, b, and the output buffer.
    a = np.ones((4096, 4096), dtype=np.float32)
    b = np.ones((4096, 4096), dtype=np.float32)
    out = np.zeros((4096, 4096), dtype=np.float32)
    
    # Pass them as raw pointers
    kernel_func(
        a.ctypes.data_as(ctypes.c_void_p), 
        b.ctypes.data_as(ctypes.c_void_p), 
        out.ctypes.data_as(ctypes.c_void_p)
    )
    
    # Step D: Result Verification
    print("\n[4/4] Verifying Result...")
    val = out[0, 0]
    print(f"Final Result[0,0]: {val}")
    if np.isclose(val, 3.0):
        print("✨ SUCCESS: Result matches expectation (3.0)")
    else:
        print(f"❌ MISMATCH: Expected 3.0, got {val}")

if __name__ == "__main__":
    asyncio.run(verify())
