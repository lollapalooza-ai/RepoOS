import time
import ctypes
import json
import os
import llvmlite.ir as ir
import llvmlite.binding as llvm
from rich.console import Console
from rich.table import Table

from component2_smt import VerifiedMLIR
from component4_jit import PolyKernelJIT
from legacy_shop.heavy_math import compute_gravity

console = Console()
CACHE_FILE = "./.poly_cache2/legacy_shop_heavy_math_compute_gravity.json"

def load_compiled_kernel():
    """
    Loads the MLIR JSON and compiles it via PolyKernelJIT.
    """
    if not os.path.exists(CACHE_FILE):
        raise FileNotFoundError(f"MLIR Cache missing! {CACHE_FILE}")
        
    with open(CACHE_FILE, 'r') as f:
        mlir_dict = json.load(f)
    
    mlir_data = VerifiedMLIR.model_validate(mlir_dict)
    
    jit = PolyKernelJIT()
    
    # Signature for compute_gravity(mass1, mass2)
    arg_count = 2
    ir_arg_types = [ir.DoubleType(), ir.DoubleType()]
    CFuncType = ctypes.CFUNCTYPE(ctypes.c_double, ctypes.c_double, ctypes.c_double)
    
    compiled_func = jit.incremental_compile(
        "compute_gravity", 
        mlir_data, 
        CFuncType, 
        arg_count, 
        ir_arg_types=ir_arg_types
    )
    
    return compiled_func

def run_macro_benchmark():
    console.print(f"\n[bold cyan]🚀 Benchmarking Heavy Math: compute_gravity[/bold cyan]")
    
    # Test Data
    m1, m2 = 5000.0, 1200.0
    iterations = 10000000 # 10 Million iterations
    
    console.print(f"[dim]Iterations: {iterations:,}[/dim]\n")
    
    # --- PHASE 1: Native CPython ---
    console.print("[yellow]跑🏃 Racing Standard CPython (Bytecode Interpreter)...[/yellow]")
    start_py = time.perf_counter()
    for _ in range(iterations):
        py_result = compute_gravity(m1, m2)
    py_time = time.perf_counter() - start_py
    
    # --- PHASE 2: Poly-Kernel JIT ---
    console.print("[yellow]⚡ Racing Poly-Kernel JIT (Bare-Metal LLVM)...[/yellow]")
    
    try:
        jit_func = load_compiled_kernel() 
    except Exception as e:
        console.print(f"[bold red]❌ Failed to compile kernel: {e}[/bold red]")
        return
    
    start_jit = time.perf_counter()
    for _ in range(iterations):
        jit_result = jit_func(m1, m2)
    jit_time = time.perf_counter() - start_jit
    
    # --- 3. Render Dashboard ---
    table = Table(title="Performance Benchmark: Python vs Poly-Kernel JIT", style="magenta")
    table.add_column("Architecture", style="dim")
    table.add_column("Result", justify="right")
    table.add_column("Execution Time (1M calls)", justify="right")
    table.add_column("Avg Latency", justify="right")

    table.add_row(
        "CPython", 
        f"{py_result:.4f}", 
        f"{py_time:.4f}s", 
        f"[red]{(py_time/iterations)*1e6:.4f} µs[/red]"
    )
    
    speedup = py_time / jit_time if jit_time > 0 else float('inf')
    
    table.add_row(
        "Poly-Kernel JIT", 
        f"{jit_result:.4f}", 
        f"{jit_time:.4f}s", 
        f"[bold green]{(jit_time/iterations)*1e6:.4f} µs[/bold green] ({speedup:.1f}x Faster)"
    )
    
    console.print("\n")
    console.print(table)
    console.print(f"\n[bold cyan]Architect's Note:[/bold cyan] By compiling Python logic directly to LLVM IR, the Poly-Kernel eliminates the overhead of the Python stack, frame evaluation, and bytecode dispatch.")

if __name__ == "__main__":
    run_macro_benchmark()
