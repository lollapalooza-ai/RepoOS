import time
import ctypes
import os
import sys

# 1. Setup Environment and Bootstrap
PROJECT_ROOT = "/Users/yeshr/Applications/Program1"
if PROJECT_ROOT not in sys.path:
    sys.path.insert(0, PROJECT_ROOT)

import component0_mlir_bootstrap
from component5_orchestrator import LazyCallManager
from legacy_shop.ecommerce import calculate_vip_revenue, generate_payload

# MLIR MemRef Descriptor for 1D arrays
class MemRef1D(ctypes.Structure):
    _fields_ = [
        ("allocated", ctypes.c_void_p),
        ("aligned", ctypes.c_void_p),
        ("offset", ctypes.c_longlong),
        ("size", ctypes.c_longlong),
        ("stride", ctypes.c_longlong),
    ]

def run_validation():
    print("--- 🔬 Poly-Kernel Devirtualization Validation ---")
    
    # 2. Setup Orchestrator (The Trampoline System)
    orchestrator = LazyCallManager()
    
    fqn = "legacy_shop.ecommerce.calculate_vip_revenue"
    
    # 3. Force-load the AOT compiled kernel
    from component4_jit import PolyKernelMLIRJIT
    # Use the dylib path we just compiled
    dylib_path = "./.poly_cache3/legacy_shop_ecommerce_calculate_vip_revenue.dylib"
    if not os.path.exists(dylib_path):
        print(f"❌ Error: AOT Kernel not found at {dylib_path}")
        return

    # Load using ctypes directly to ensure we handle the _mlir_ciface correctly
    lib = ctypes.CDLL(dylib_path)
    # Note the _mlir_ciface_ prefix added by llvm-request-c-wrappers
    kernel_func = getattr(lib, "_mlir_ciface_calculate_vip_revenue")
    kernel_func.restype = ctypes.c_double

    print(f"✅ Loaded AOT Kernel: {dylib_path}")

    # 4. Generate Test Data
    COUNT = 100_000
    print(f"📦 Generating test payload ({COUNT:,} orders)...")
    orders = generate_payload(COUNT)
    
    # 5. Baseline: Python execution
    print("⏱️ Running CPython baseline...")
    start_py = time.perf_counter()
    py_result = calculate_vip_revenue(orders)
    py_time = time.perf_counter() - start_py
    print(f"   Result: ${py_result:,.2f} (Time: {py_time:.4f}s)")

    # 6. Poly-Kernel: Devirtualization + MLIR
    print("🚀 Running Poly-Kernel (Devirtualized SoA + MLIR)...")
    
    # Step A: SoA Projection (Devirtualization)
    start_proj = time.perf_counter()
    length = len(orders)
    vip_flags_raw = (ctypes.c_int32 * length)(*[1 if (o['user']['is_vip']) else 0 for o in orders])
    amounts_raw = (ctypes.c_double * length)(*[float(o['cart']['total_value']) for o in orders])
    
    # Step B: Wrap in MemRef Descriptors
    vip_memref = MemRef1D(
        allocated=ctypes.cast(vip_flags_raw, ctypes.c_void_p),
        aligned=ctypes.cast(vip_flags_raw, ctypes.c_void_p),
        offset=0, size=length, stride=1
    )
    amt_memref = MemRef1D(
        allocated=ctypes.cast(amounts_raw, ctypes.c_void_p),
        aligned=ctypes.cast(amounts_raw, ctypes.c_void_p),
        offset=0, size=length, stride=1
    )
    proj_time = time.perf_counter() - start_proj

    # Step C: Execute bare-metal kernel
    start_jit_exec = time.perf_counter()
    # MLIR C-Interface expects pointers to the descriptors
    pk_result = kernel_func(
        ctypes.c_int64(length),
        ctypes.pointer(vip_memref),
        ctypes.pointer(amt_memref)
    )
    jit_exec_time = time.perf_counter() - start_jit_exec
    
    pk_total_time = proj_time + jit_exec_time
    print(f"   Result: ${pk_result:,.2f} (Total Time: {pk_total_time:.4f}s)")
    print(f"      - Projection: {proj_time:.4f}s")
    print(f"      - MLIR Kernel: {jit_exec_time:.4f}s")

    # 7. Verification
    speedup = py_time / pk_total_time if pk_total_time > 0 else 0
    kernel_speedup = py_time / jit_exec_time if jit_exec_time > 0 else 0
    print(f"\n--- Results ---")
    print(f"Overall Speedup (incl. Projection): {speedup:.1f}x")
    print(f"Raw Kernel Speedup: {kernel_speedup:.1f}x")
    
    if abs(py_result - pk_result) < 0.01:
        print("✅ SUCCESS: Math results match!")
    else:
        print(f"❌ FAILURE: Math mismatch! Diff: {abs(py_result - pk_result)}")

if __name__ == "__main__":
    run_validation()

if __name__ == "__main__":
    run_validation()
