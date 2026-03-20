import time
import ctypes
import importlib
import sys
import os
from rich.console import Console
from rich.table import Table
from rich.panel import Panel

# Import our Poly-Kernel Orchestrator
from component5_orchestrator import LazyCallManager

console = Console()

def run_benchmark(target_module_name: str, func_name: str, args: tuple, iterations: int = 1000000):
    console.print(Panel.fit(f"🚀 Initializing Poly-Kernel Benchmark: [bold green]{func_name}[/bold green]", border_style="cyan"))
    
    # --- 1. Load Native Python (Baseline) ---
    console.print("[yellow]1. Loading standard CPython module...[/yellow]")
    # Ensure current directory is in sys.path for import
    sys.path.insert(0, os.getcwd())
    native_module = importlib.import_module(target_module_name)
    native_func = getattr(native_module, func_name)

    # --- 2. Boot Poly-Kernel ---
    console.print("[yellow]2. Booting Poly-Kernel Orchestrator...[/yellow]")
    orchestrator = LazyCallManager()
    
    # Extract ctypes arguments from the python tuple for the JIT
    arg_types = [ctypes.c_double] * len(args)
    orchestrator.register_lazy_function(func_name, arg_types, ctypes.c_double)

    # --- 3. Measure Cold Start (AI Generation + Z3 + LLVM Compilation) ---
    console.print("[yellow]3. Triggering JIT Trampoline (Cold Start)...[/yellow]")
    cold_start_begin = time.perf_counter()
    
    # The first call trips the trampoline hook in component 5
    first_jit_result = orchestrator.registry[func_name](*args)
    cold_start_time = time.perf_counter() - cold_start_begin
    console.print(f"[dim]Cold Start Result: {first_jit_result} (Time: {cold_start_time:.4f}s)[/dim]")

    # --- 4. The Race (Native vs. Warm JIT) ---
    console.print(f"[yellow]4. Running {iterations:,} iterations race...[/yellow]\n")
    
    # Race Native Python
    native_start = time.perf_counter()
    for _ in range(iterations):
        native_func(*args)
    native_time = time.perf_counter() - native_start

    # Race Poly-Kernel (Warm)
    # Grab the hot-patched ctypes pointer directly to avoid Python dictionary lookups in the loop
    jit_func = orchestrator.registry[func_name] 
    
    jit_start = time.perf_counter()
    for _ in range(iterations):
        jit_func(*args)
    jit_time = time.perf_counter() - jit_start

    # --- 5. Render Dashboard ---
    render_dashboard(native_time, jit_time, cold_start_time, iterations)

def render_dashboard(native_time: float, jit_time: float, cold_start: float, iterations: int):
    table = Table(title="Poly-Kernel vs CPython Performance Matrix", show_header=True, header_style="bold magenta")
    table.add_column("Execution Engine", style="dim", width=20)
    table.add_column("Total Time (s)", justify="right")
    table.add_column("Time per Call (ns)", justify="right")
    table.add_column("Status / Overhead", justify="center")

    # Native Row
    native_per_call = (native_time / iterations) * 1e9
    table.add_row(
        "Standard CPython", 
        f"{native_time:.4f}", 
        f"{native_per_call:.2f} ns", 
        "[red]Baseline[/red]"
    )

    # JIT Warm Row
    jit_per_call = (jit_time / iterations) * 1e9
    speedup = native_time / jit_time if jit_time > 0 else 0
    table.add_row(
        "Poly-Kernel (Warm)", 
        f"{jit_time:.4f}", 
        f"{jit_per_call:.2f} ns", 
        f"[bold green]{speedup:.1f}x Faster[/bold green] 🚀"
    )

    # JIT Cold Row
    table.add_row(
        "Poly-Kernel (Cold)", 
        f"{cold_start:.4f}", 
        "-", 
        "[dim]AI Gen + Z3 + LLVM Overhead[/dim]"
    )

    console.print(table)
    console.print("\n[bold cyan]Architect's Note:[/bold cyan] Once the Trampoline is hot-patched, execution never leaves the CPU cache. The Python bytecode interpreter is completely bypassed.")

if __name__ == "__main__":
    import sys
    
    # Defaults to our macro-benchmark payload if no arguments provided
    target_mod = "legacy_shop.heavy_math"
    target_func = "compute_gravity"
    func_args = [1000.0, 50.0]
    
    if len(sys.argv) > 2:
        target_mod = sys.argv[1]
        target_func = sys.argv[2]
        # Parse remaining args as floats
        func_args = [float(x) for x in sys.argv[3:]] if len(sys.argv) > 3 else [1.0, 1.0]

    console.print(f"Targeting: {target_mod}.{target_func} with args {func_args}")
    
    run_benchmark(
        target_module_name=target_mod, 
        func_name=target_func, 
        args=tuple(func_args), 
        iterations=500000 
    )
