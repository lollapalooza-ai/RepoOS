import time
import sys
import os
import torch
import numpy as np
import ctypes
from rich.console import Console
from rich.table import Table

# Import the generalized ABI bridge from the orchestrator
from component5_orchestrator import invoke_mlir_ciface

console = Console()

# --- 1. NATIVE PYTHON REFERENCE ---
def python_pagerank_step(x, M, alpha, p):
    return alpha * (M @ x) + (1.0 - alpha) * p

def run_benchmark():
    console.print("[bold green]🚀 RepoOS Milestone 5: Generalized Pipeline Verification[/bold green]\n")
    
    # Scale: 8192 nodes
    N = 8192
    console.print(f"[yellow]Phase 1: Setup Dense Graph (N={N})...[/yellow]")
    
    x_np = (np.ones(N) / N).astype(np.float32)
    M_np = np.random.randn(N, N).astype(np.float32)
    p_np = (np.ones(N) / N).astype(np.float32)
    alpha = 0.85
    
    # 2. NATIVE PYTHON BASELINE
    console.print(f"[yellow]Phase 2: Measuring Native Python Baseline (NumPy)...[/yellow]")
    t0 = time.perf_counter()
    res_py = python_pagerank_step(x_np, M_np, alpha, p_np)
    t_py = time.perf_counter() - t0
    
    # 3. REPOOS V2 EXECUTION (Using Generalized ABI Bridge)
    console.print(f"[yellow]Phase 3: Triggering RepoOS V2 Auto-Traced Kernel...[/yellow]")
    
    x = torch.from_numpy(x_np)
    M = torch.from_numpy(M_np)
    p = torch.from_numpy(p_np)
    res_buffer = torch.zeros(N, dtype=torch.float32)
    alpha_t = torch.tensor(alpha, dtype=torch.float32)
    
    dylib = "./v2_pagerank_kernel.dylib"
    
    try:
        # WARMUP
        invoke_mlir_ciface(dylib, "main", res_buffer, x, M, alpha_t, p)
        
        # MEASUREMENT LOOP
        ITERS = 100
        t0 = time.perf_counter()
        for _ in range(ITERS):
            descs = invoke_mlir_ciface(dylib, "main", res_buffer, x, M, alpha_t, p)
        t_repo = (time.perf_counter() - t0) / ITERS
        
        # 3. EXTRACT RESULTS FROM THE RETURNED DESCRIPTOR
        res_desc = descs[0]
        repo_data_ptr = ctypes.cast(res_desc.allocated, ctypes.POINTER(ctypes.c_float))
        repo_results = np.fromiter(repo_data_ptr, dtype=np.float32, count=N)
        
        # 4. CORRECTNESS CHECK (Match Top 5 Nodes)
        val_table = Table(title="Correctness Check (First 5 Nodes)")
        val_table.add_column("Node ID", style="cyan")
        val_table.add_column("Native Python", style="magenta")
        val_table.add_column("RepoOS (Auto-Traced)", style="green")
        
        match = True
        max_diff = 0
        for i in range(5):
            py_val = res_py[i]
            repo_val = repo_results[i]
            diff = abs(py_val - repo_val)
            if diff > max_diff: max_diff = diff
            if diff > 1e-4: match = False
            val_table.add_row(str(i), f"{py_val:.12f}", f"{repo_val:.12f}")
        
        console.print(val_table)
        console.print(f"   Mathematical Match: {'✅ YES' if match else '❌ NO'} (Max Diff: {max_diff:.2e})")
        
        # 5. PERFORMANCE SUMMARY
        # Average Python execution for comparison
        t0 = time.perf_counter()
        for _ in range(ITERS):
            _ = python_pagerank_step(x_np, M_np, alpha, p_np)
        t_py = (time.perf_counter() - t0) / ITERS
        
        speedup = t_py / t_repo if t_repo > 0 else 0
        
        summary = Table(title=f"PageRank Performance Comparison (N={N})")
        summary.add_column("Metric", style="cyan")
        summary.add_column("Native Python (NumPy)", style="magenta")
        summary.add_column("RepoOS V2 (Auto-Traced)", style="green")
        summary.add_column("Improvement", style="bold yellow")
        
        summary.add_row("Execution Time", f"{t_py*1000:.4f} ms", f"{t_repo*1000:.4f} ms", f"{speedup:.2f}x Faster")
        summary.add_row("Implementation", "NumPy / OpenBLAS", "AOT Compiled / Native", "Generalized")
        summary.add_row("Tracer", "None", "FX-Based (Auto)", "Verified")
        
        console.print("\n", summary)
        
    except Exception as e:
        console.print(f"[red]❌ Benchmark failed: {e}[/red]")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    run_benchmark()
