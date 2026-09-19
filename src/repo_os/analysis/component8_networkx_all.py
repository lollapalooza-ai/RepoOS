import time
import sys
import os
import numpy as np
from rich.console import Console
from rich.table import Table

# --- 1. BOOTSTRAP ENVIRONMENT ---
PROJECT_ROOT = "/Users/yeshr/Applications/Program1"
if PROJECT_ROOT not in sys.path:
    sys.path.insert(0, PROJECT_ROOT)

# Import baseline functions BEFORE hijacking
from networkx.utils.random_sequence import cumulative_distribution as py_cd
from networkx.utils.random_sequence import zipf_rv as py_zipf

console = Console()

# --- 2. BOOT REPOOS HIJACKER ---
from component6_hijacker import boot_poly_kernel
# Clear modules to ensure hijacker catches them on reload
for m in ["networkx.utils.random_sequence", "component8_networkx_helper"]:
    if m in sys.modules: del sys.modules[m]

orchestrator = boot_poly_kernel("networkx")

# Import hijacked versions
from networkx.utils.random_sequence import cumulative_distribution, zipf_rv
import component8_networkx_helper as helper

def run_all_benchmarks():
    ITERATIONS = 5000
    SIZE = 10000
    
    console.print(f"[bold green]🚀 Comprehensive NetworkX Suite Benchmark[/bold green]")
    console.print(f"Iterations: {ITERATIONS} | Size: {SIZE}\n")

    results = []

    # --- TEST 1: cumulative_distribution (O(N) Loop) ---
    console.print("[yellow]Benchmarking: cumulative_distribution...[/yellow]")
    dist_list = [float(i) for i in range(1, SIZE + 1)]
    dist_np = np.arange(1, SIZE + 1, dtype=np.float64)

    # Native Baseline
    t0 = time.perf_counter()
    for _ in range(ITERATIONS): py_cd(dist_list)
    py_time_cd = time.perf_counter() - t0

    # RepoOS Zero-Copy
    # Wait for hot-swap
    fqn_cd = "networkx.utils.random_sequence.cumulative_distribution"
    start_wait = time.time()
    while fqn_cd not in orchestrator.registry and time.time() - start_wait < 5:
        time.sleep(0.1)
    
    t0 = time.perf_counter()
    for _ in range(ITERATIONS): cumulative_distribution(dist_np)
    repo_time_cd = time.perf_counter() - t0
    
    speedup_cd = py_time_cd / repo_time_cd if repo_time_cd > 0 else 0
    results.append(["cumulative_distribution", "O(N) Loop", f"{py_time_cd:.3f}s", f"{repo_time_cd:.3f}s", f"{speedup_cd:.1f}x"])

    # --- TEST 2: zipf_rv (Math Chunk) ---
    console.print("[yellow]Benchmarking: zipf_rv (internal math acceleration)...[/yellow]")
    # zipf_rv chunk is: a1 = alpha - 1.0; b = 2 ** a1
    # We measure the whole function, RepoOS only accelerates that small math block.
    
    import random
    seed = random.Random(42)

    # Native Baseline
    t0 = time.perf_counter()
    for _ in range(ITERATIONS * 2): py_zipf(2.5, xmin=1, seed=seed)
    py_time_zipf = time.perf_counter() - t0

    # RepoOS
    # Wait for hot-swap
    fqn_zipf = "networkx.utils.random_sequence.zipf_rv"
    start_wait = time.time()
    while fqn_zipf not in orchestrator.registry and time.time() - start_wait < 5:
        time.sleep(0.1)

    t0 = time.perf_counter()
    for _ in range(ITERATIONS * 2): zipf_rv(2.5, xmin=1, seed=seed)
    repo_time_zipf = time.perf_counter() - t0

    speedup_zipf = py_time_zipf / repo_time_zipf if repo_time_zipf > 0 else 0
    results.append(["zipf_rv", "Scalar Math", f"{py_time_zipf:.3f}s", f"{repo_time_zipf:.3f}s", f"{speedup_zipf:.2f}x"])

    # --- SUMMARY TABLE ---
    table = Table(title="NetworkX Random Sequence Suite: Native vs RepoOS")
    table.add_column("Function", style="cyan")
    table.add_column("Type", style="magenta")
    table.add_column("Python Time")
    table.add_column("RepoOS Time")
    table.add_column("Speedup", style="bold green")

    for r in results:
        table.add_row(*r)

    console.print("\n", table)
    
    console.print("\n[dim]Note: 'powerlaw_sequence' and others use mutable 'Random' state objects that require specialized MLIR state-dialects to accelerate safely, which are planned for Milestone 7.[/dim]")

if __name__ == "__main__":
    run_all_benchmarks()
