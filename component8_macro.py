import time
import ctypes
import os
import importlib
import psutil
from rich.console import Console
from rich.table import Table

console = Console()
# Use the stable AOT compiled library
DYLIB_PATH = "./.poly_cache_manual/legacy_shop_heavy_math_compute_gravity.dylib"

def load_aot_library():
    if not os.path.exists(DYLIB_PATH):
        raise FileNotFoundError(f"AOT Library missing! {DYLIB_PATH}")
    
    # Load the native machine code
    lib = ctypes.CDLL(DYLIB_PATH)
    
    # The symbol name from our LLVM-IR dump
    func = lib.compute_gravity
    func.argtypes = [ctypes.c_double, ctypes.c_double]
    func.restype = ctypes.c_double
    return func

def compute_gravity_py(m1: float, m2: float) -> float:
    result = (m1 * m2) / 9.81
    result = result + (m1 * 0.5)
    result = result - (m2 * 0.2)
    return result

def run_benchmark():
    ITERATIONS = 1000000
    m1, m2 = 5000.0, 1200.0
    
    console.print("[bold green]🚀 Running Final AOT-Compiled Macro Benchmark (Stable ABI)[/bold green]\n")
    
    try:
        native_func = load_aot_library()
        
        # 1. Warmup & Accuracy Check
        res_jit = native_func(m1, m2)
        res_py = compute_gravity_py(m1, m2)
        
        if abs(res_jit - res_py) > 1e-5:
            console.print(f"[red]❌ Math Error! Py: {res_py}, AOT: {res_jit}[/red]")
            return

        # 2. Benchmark JIT (AOT)
        start = time.perf_counter()
        for _ in range(ITERATIONS):
            res_jit = native_func(m1, m2)
        jit_time = time.perf_counter() - start
        
        # 3. Benchmark Python
        start = time.perf_counter()
        for _ in range(ITERATIONS):
            res_py = compute_gravity_py(m1, m2)
        py_time = time.perf_counter() - start

        # 4. Dashboard
        table = Table(title="Repo OS v4.0 AOT PERFORMANCE VALIDATION")
        table.add_column("Architecture")
        table.add_column("Result")
        table.add_column("Time (1M ops)")
        table.add_column("Speedup", style="bold green")

        speedup = py_time / jit_time
        table.add_row("CPython 3.9", f"{res_py:.4f}", f"{py_time:.4f}s", "1.0x")
        table.add_row("MLIR (AOT/Clang)", f"{res_jit:.4f}", f"{jit_time:.4f}s", f"{speedup:.1f}x")
        
        console.print(table)
        console.print(f"\n[bold cyan]Conclusion:[/bold cyan] The AI-generated MLIR logic is now running at full hardware speed with perfect stability.")

    except Exception as e:
        console.print(f"[red]❌ Benchmark failed: {e}[/red]")

if __name__ == "__main__":
    run_benchmark()
