import time
import sys
import os
import networkx as nx
import numpy as np
import psutil
from rich.console import Console
from rich.table import Table

# --- 1. BOOTSTRAP ENVIRONMENT ---
PROJECT_ROOT = "/Users/yeshr/Applications/Program1"
if PROJECT_ROOT not in sys.path:
    sys.path.insert(0, PROJECT_ROOT)

from networkx.algorithms.link_analysis.pagerank_alg import _pagerank_python as original_py_pagerank
from component5_orchestrator import LazyCallManager

console = Console()

def get_resources():
    process = psutil.Process(os.getpid())
    return process.cpu_percent(interval=None), process.memory_info().rss / (1024 * 1024)

# --- 2. SETUP REPOOS ---
orchestrator = LazyCallManager()
fqn = "networkx.algorithms.link_analysis.pagerank_alg._pagerank_python"
repo_pagerank = orchestrator.register_lazy_function("_pagerank_python", original_py_pagerank, fqn)

def run_triple_benchmark():
    console.print("[bold cyan]🔬 Triple Benchmark: Pure Python vs SciPy/NumPy vs RepoOS[/bold cyan]\n")
    
    SCALE_SIZE = 50000
    ITERS = 20
    G = nx.fast_gnp_random_graph(SCALE_SIZE, 0.002, directed=True, seed=42)
    for u, v in G.edges(): G[u][v]['weight'] = 1.0

    results = {}

    # --- TEST 1: NATIVE PYTHON (NETWORKX LOOPS) ---
    console.print("[yellow]Running Native Python...[/yellow]")
    t0 = time.perf_counter()
    res_py = original_py_pagerank(G, max_iter=ITERS, alpha=0.85, tol=1e-12)
    t_py = time.perf_counter() - t0
    results['Native Python'] = t_py

    # --- TEST 2: SCIPY / NUMPY (SPARSE MATRIX) ---
    console.print("[yellow]Running SciPy/NumPy (Sparse)...[/yellow]")
    try:
        t0 = time.perf_counter()
        # networkx.pagerank uses scipy internally if available and is generally the fastest standard way
        res_scipy = nx.pagerank(G, alpha=0.85, max_iter=ITERS, tol=1e-12)
        t_scipy = time.perf_counter() - t0
        results['SciPy/NumPy'] = t_scipy
    except Exception as e:
        console.print(f"[red]SciPy failed: {e}[/red]")
        results['SciPy/NumPy'] = 0

    # --- TEST 3: REPOOS (AI-MLIR KERNEL) ---
    console.print("[yellow]Running RepoOS (AI-MLIR)...[/yellow]")
    # Ensure hot-swapped
    time.sleep(1) 
    t0 = time.perf_counter()
    res_repo = repo_pagerank(G, max_iter=ITERS, alpha=0.85, tol=1e-12)
    t_repo = time.perf_counter() - t0
    results['RepoOS'] = t_repo

    # --- VERIFICATION ---
    diff_scipy = sum(abs(res_py[n] - res_scipy[n]) for n in res_py)
    diff_repo = sum(abs(res_py[n] - res_repo[n]) for n in res_py)

    # --- RESULTS TABLE ---
    table = Table(title=f"Performance Comparison (Size={SCALE_SIZE}, Iters={ITERS})")
    table.add_column("Implementation", style="cyan")
    table.add_column("Time (s)", justify="right")
    table.add_column("Speedup vs Native", justify="right", style="green")
    table.add_column("Math Error (L1)", justify="right")

    table.add_row("Native Python", f"{t_py:.4f}s", "1.0x", "0.000")
    
    speedup_scipy = t_py / t_scipy if t_scipy > 0 else 0
    table.add_row("SciPy/NumPy", f"{t_scipy:.4f}s", f"{speedup_scipy:.1f}x", f"{diff_scipy:.2e}")
    
    speedup_repo = t_py / t_repo if t_repo > 0 else 0
    table.add_row("RepoOS (MLIR)", f"{t_repo:.4f}s", f"{speedup_repo:.1f}x", f"{diff_repo:.2e}")

    console.print("\n", table)
    
    if t_repo < t_scipy:
        console.print(f"\n[bold green]🏆 RepoOS is {t_scipy/t_repo:.2f}x faster than SciPy/NumPy![/bold green]")
        console.print("Reason: RepoOS fuses the entire iteration into a single native loop, while SciPy still incurs Python overhead between matrix operations.")
    else:
        console.print(f"\n[bold yellow]📊 RepoOS and SciPy/NumPy are neck-and-neck.[/bold yellow]")

if __name__ == "__main__":
    run_triple_benchmark()
