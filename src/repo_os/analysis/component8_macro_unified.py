import time
import ctypes
import os
import sys
from rich.console import Console
from rich.table import Table

# Setup Environment and Bootstrap
PROJECT_ROOT = "/Users/yeshr/Applications/Program1"
if PROJECT_ROOT not in sys.path:
    sys.path.insert(0, PROJECT_ROOT)

import repo_os.core.component0_mlir_bootstrap as component0_mlir_bootstrap
from repo_os.core.component5_orchestrator import LazyCallManager
from legacy_shop.ecommerce import calculate_vip_revenue, generate_payload
from legacy_shop.utils import calculate_tax, dynamic_pricing
from legacy_shop.heavy_math import compute_gravity

console = Console()

def run_macro_benchmark():
    console.print("[bold green]🚀 Running 100% Generic Poly-Kernel Benchmark (Milestone 3 Final)[/bold green]\n")
    
    # Initialize the Orchestrator (The magic bridge)
    orchestrator = LazyCallManager()
    
    # 1. Force-load our AOT dylibs into the orchestrator's registry
    # In a real system, the 'hijacker' would do this automatically.
    mappings = {
        "legacy_shop.ecommerce.calculate_vip_revenue": "legacy_shop_ecommerce_calculate_vip_revenue.dylib",
        "legacy_shop.heavy_math.compute_gravity": "legacy_shop_heavy_math_compute_gravity.dylib",
        "legacy_shop.utils.calculate_tax": "legacy_shop_utils_calculate_tax.dylib",
        "legacy_shop.utils.dynamic_pricing": "legacy_shop_utils_dynamic_pricing.dylib"
    }
    
    for fqn, dylib in mappings.items():
        path = f"./.poly_cache3/{dylib}"
        if os.path.exists(path):
            lib = ctypes.CDLL(path)
            # The AOT compiler adds _mlir_ciface_ prefix for standard ABI
            func_name = fqn.split('.')[-1]
            try:
                kernel = getattr(lib, f"_mlir_ciface_{func_name}")
                kernel.restype = ctypes.c_double
                orchestrator.registry[fqn] = kernel
            except AttributeError:
                # Some might not have ciface if they don't use memrefs/complex types
                kernel = getattr(lib, func_name)
                kernel.restype = ctypes.c_double
                orchestrator.registry[fqn] = kernel

    # Setup the generic trampolines
    vip_trampoline = orchestrator.register_lazy_function("calculate_vip_revenue", calculate_vip_revenue, "legacy_shop.ecommerce.calculate_vip_revenue")
    gravity_trampoline = orchestrator.register_lazy_function("compute_gravity", compute_gravity, "legacy_shop.heavy_math.compute_gravity")
    tax_trampoline = orchestrator.register_lazy_function("calculate_tax", calculate_tax, "legacy_shop.utils.calculate_tax")
    pricing_trampoline = orchestrator.register_lazy_function("dynamic_pricing", dynamic_pricing, "legacy_shop.utils.dynamic_pricing")

    results = []

    def run_test(name, py_func, trampoline, args):
        # Baseline Python
        start_py = time.perf_counter()
        py_res = py_func(*args)
        py_time = time.perf_counter() - start_py

        # Poly-Kernel (Generic path via Orchestrator)
        start_pk = time.perf_counter()
        pk_res = trampoline(*args)
        pk_time = time.perf_counter() - start_pk

        match = abs(py_res - pk_res) < 0.01
        speedup = py_time / pk_time if pk_time > 0 else 0
        return [name, "✅" if match else "❌", f"{py_time:.6f}s", f"{pk_time:.6f}s", f"{speedup:.1f}x"]

    # --- EXECUTION ---
    
    # Test 1: VIP Revenue (Generic SoA Projection)
    orders = generate_payload(100_000)
    results.append(run_test("VIP Revenue (Loop)", calculate_vip_revenue, vip_trampoline, [orders]))

    # Test 2: Compute Gravity (Pure Math)
    results.append(run_test("Compute Gravity", compute_gravity, gravity_trampoline, [5000.0, 1200.0]))

    # Test 3: Calculate Tax (Generic Enum Devirtualization)
    # NOTE: We pass "NY" as a string! No hardcoded integers.
    results.append(run_test("Calculate Tax (NY)", calculate_tax, tax_trampoline, [1500.0, "NY"]))
    results.append(run_test("Calculate Tax (CA)", calculate_tax, tax_trampoline, [1500.0, "CA"]))

    # Test 4: Dynamic Pricing (Conditionals)
    results.append(run_test("Dynamic Pricing", dynamic_pricing, pricing_trampoline, [10.0, 1.5]))

    # Display Table
    table = Table(title="Poly-Kernel 100% Generic Performance Dashboard")
    table.add_column("Function")
    table.add_column("Match")
    table.add_column("CPython Time")
    table.add_column("MLIR Time (incl. Orchestration)")
    table.add_column("Speedup", style="bold green")

    for r in results:
        table.add_row(*r)

    console.print(table)

if __name__ == "__main__":
    run_macro_benchmark()
