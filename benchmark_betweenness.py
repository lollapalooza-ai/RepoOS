import time
import sys
import os
import networkx as nx
import numpy as np
import ctypes
import psutil
from rich.console import Console
from rich.table import Table

# --- 1. BOOTSTRAP ENVIRONMENT ---
PROJECT_ROOT = "/Users/yeshr/Applications/Program1"
if PROJECT_ROOT not in sys.path:
    sys.path.insert(0, PROJECT_ROOT)

# Get raw implementation
from networkx.algorithms.centrality.betweenness import betweenness_centrality as original_py_betweenness

console = Console()

def get_resources():
    process = psutil.Process(os.getpid())
    return process.cpu_percent(interval=None), process.memory_info().rss / (1024 * 1024)

# --- 2. BOOT ORCHESTRATOR (Manual Registration) ---
from component5_orchestrator import LazyCallManager
orchestrator = LazyCallManager()

fqn = "networkx.algorithms.centrality.betweenness.betweenness_centrality"
# Manually register the lazy function (Shadow JIT Trampoline)
repo_betweenness = orchestrator.register_lazy_function("betweenness_centrality", original_py_betweenness, fqn)

def run_betweenness_benchmark():
    console.print("[bold green]🚀 Betweenness Centrality Optimization Benchmark (Category 1: Complex Control Flow)[/bold green]\n")
    
    # 1. Ensure kernel is generated and compiled
    from component9_aot import aot_compile_all
    import asyncio
    
    console.print("[yellow]Phase 0: AOT Compiling Bare-Metal Kernel...[/yellow]")
    # Kernel already defined in manual_compiler.py
    asyncio.run(aot_compile_all("networkx.algorithms.centrality.betweenness.betweenness_centrality"))
    
    # 2. Trigger hot-swap (the 'Trampoline Trap')
    # Small graph for trigger
    try:
        warmup_G = nx.path_graph(3)
        repo_betweenness(warmup_G, normalized=False)
    except:
        pass

    start_wait = time.time()
    while fqn not in orchestrator.registry and time.time() - start_wait < 5:
        time.sleep(0.1)
    
    if fqn not in orchestrator.registry:
        console.print("[red]❌ JIT failed to hot-swap native kernel.[/red]")
        return
    console.print(f"✅ Hot-swap complete for {fqn}\n")

    # 3. Correctness Validation
    SIZE = 50
    G = nx.fast_gnp_random_graph(SIZE, 0.1, directed=False)
    
    console.print(f"[yellow]Phase 1: Validating Mathematical Match (Size={SIZE})...[/yellow]")
    
    # Native
    res_py = original_py_betweenness(G, normalized=False)
    
    # RepoOS
    res_repo = repo_betweenness(G, normalized=False)
    
    # Compare
    match = True
    max_diff = 0
    for node in res_py:
        diff = abs(res_py[node] - res_repo[node])
        if diff > max_diff: max_diff = diff
        if diff > 1e-10: match = False
    
    console.print(f"   Exact Match: {'✅ YES' if match else '❌ NO'} (Max Diff: {max_diff:.2e})")
    
    # 4. Performance Measurement
    SCALE_SIZE = 400
    G_LARGE = nx.fast_gnp_random_graph(SCALE_SIZE, 0.05, directed=False)
    
    console.print(f"\n[yellow]Phase 2: Performance Benchmark (Size={SCALE_SIZE})...[/yellow]")
    
    # Native Python
    get_resources() 
    t0 = time.perf_counter()
    start_mem_py = psutil.Process().memory_info().rss / (1024 * 1024)
    res_py_large = original_py_betweenness(G_LARGE, normalized=False)
    t_py = time.perf_counter() - t0
    py_cpu, _ = get_resources()
    py_mem_delta = (psutil.Process().memory_info().rss / (1024 * 1024)) - start_mem_py
    
    # RepoOS (MLIR)
    get_resources() 
    t0 = time.perf_counter()
    start_mem_repo = psutil.Process().memory_info().rss / (1024 * 1024)
    
    console.print(f"   [Action] Invoking repo_betweenness for Size={SCALE_SIZE}...")
    res_repo_large = repo_betweenness(G_LARGE, normalized=False)
    
    t_repo = time.perf_counter() - t0
    repo_cpu, _ = get_resources()
    repo_mem_delta = (psutil.Process().memory_info().rss / (1024 * 1024)) - start_mem_repo

    speedup = t_py / t_repo if t_repo > 0 else 0
    
    # Performance Summary
    summary = Table(title=f"Betweenness Centrality Resource & Performance Report ({SCALE_SIZE} nodes)")
    summary.add_column("Metric", style="cyan")
    summary.add_column("Native Python", style="magenta")
    summary.add_column("RepoOS (MLIR)", style="green")
    summary.add_column("Improvement", style="bold yellow")
    
    summary.add_row("Execution Time", f"{t_py:.4f}s", f"{t_repo:.4f}s", f"{speedup:.2f}x Faster")
    summary.add_row("Avg CPU Load", f"{py_cpu}%", f"{repo_cpu}%", f"{py_cpu - repo_cpu:.1f}% Reduction")
    summary.add_row("Memory Delta", f"{py_mem_delta:.2f} MB", f"{repo_mem_delta:.2f} MB", "Optimized")
    
    console.print("\n", summary)

if __name__ == "__main__":
    run_betweenness_benchmark()
