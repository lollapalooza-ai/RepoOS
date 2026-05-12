import time
import sys
import os
import psutil
import math
import numpy as np
from rich.console import Console
from rich.table import Table

# --- 1. GET BASELINE BEFORE HIJACKING ---
from networkx.utils.random_sequence import cumulative_distribution as original_py_func

console = Console()

# --- 2. BOOT HIJACKER ---
sys.path.append(os.getcwd())
from component6_hijacker import boot_poly_kernel
# Ensure we reload the module to trigger the hijacker
if "networkx.utils.random_sequence" in sys.modules:
    del sys.modules["networkx.utils.random_sequence"]
if "component8_networkx_helper" in sys.modules:
    del sys.modules["component8_networkx_helper"]

orchestrator = boot_poly_kernel("networkx")

# --- 3. IMPORT HIJACKED TARGETS ---
from networkx.utils.random_sequence import cumulative_distribution
import component8_networkx_helper as helper

def run_benchmark():
    ITERATIONS = 5000
    SIZE = 10000
    
    # 1. Standard Python List
    dist_list = [float(i) for i in range(1, SIZE + 1)]
    
    console.print(f"[bold green]🚀 Running Comprehensive NetworkX Benchmark ({ITERATIONS} iterations, {SIZE} elements)[/bold green]\n")

    # --- PHASE 1: NATIVE PYTHON BASELINE ---
    console.print("[yellow]Phase 1: Measuring Native Python Baseline (List-based)...[/yellow]")
    start_time = time.perf_counter()
    for _ in range(ITERATIONS):
        res_py = original_py_func(dist_list)
    py_time = time.perf_counter() - start_time
    console.print(f"   Native Python Time: {py_time:.4f}s")

    # --- PHASE 2: REPOOS JIT WARMUP ---
    fqn = "networkx.utils.random_sequence.cumulative_distribution"
    console.print("\n[yellow]Phase 2: Triggering RepoOS JIT...[/yellow]")
    
    if fqn not in orchestrator.registry:
        console.print("Waiting for hot-swap...")
        start_wait = time.time()
        while fqn not in orchestrator.registry and time.time() - start_wait < 15:
            time.sleep(0.5)
    
    if fqn not in orchestrator.registry:
        console.print("[red]❌ JIT failed to hot-swap.[/red]")
        return
    console.print(f"✅ Hot-swap complete for {fqn}")

    # --- PHASE 3: MEASURING REPOOS JIT (Standard List) ---
    console.print("\n[yellow]Phase 3: Measuring RepoOS (List-based, O(N) copy)...[/yellow]")
    start_time = time.perf_counter()
    for _ in range(ITERATIONS):
        res_repo_list = cumulative_distribution(dist_list)
    repo_list_time = time.perf_counter() - start_time

    # --- PHASE 4: MEASURING REPOOS JIT (NumPy, Zero-Copy) ---
    console.print("\n[yellow]Phase 4: Measuring RepoOS (NumPy-based, ZERO-COPY)...[/yellow]")
    start_time = time.perf_counter()
    res_repo_np = helper.run_production_logic(SIZE, ITERATIONS)
    repo_np_time = time.perf_counter() - start_time

    # --- FINAL SUMMARY ---
    summary_table = Table(title=f"NetworkX Optimization Summary ({SIZE} elements)")
    summary_table.add_column("Architecture", style="cyan")
    summary_table.add_column("Data Format", style="magenta")
    summary_table.add_column("Total Time", justify="right")
    summary_table.add_column("Speedup", style="bold green")

    summary_table.add_row("Native Python", "Standard List", f"{py_time:.4f}s", "1.0x")
    
    list_speedup = py_time / repo_list_time
    summary_table.add_row("RepoOS (MLIR)", "Standard List", f"{repo_list_time:.4f}s", f"{list_speedup:.2f}x")
    
    np_speedup = py_time / repo_np_time
    summary_table.add_row("RepoOS (MLIR)", "NumPy (Zero-Copy)", f"[bold green]{repo_np_time:.4f}s[/bold green]", f"[bold green]{np_speedup:.2f}x[/bold green]")

    console.print("\n", summary_table)

if __name__ == "__main__":
    run_benchmark()
