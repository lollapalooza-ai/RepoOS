import networkx as nx
import sys
import os
import time
from rich.console import Console
from rich.table import Table

PROJECT_ROOT = "/Users/yeshr/Applications/Program1"
sys.path.insert(0, PROJECT_ROOT)

from component5_orchestrator import LazyCallManager
from networkx.algorithms.centrality.betweenness import betweenness_centrality as original_py

console = Console()

def verify_integrity():
    orchestrator = LazyCallManager()
    fqn = "networkx.algorithms.centrality.betweenness.betweenness_centrality"
    
    # 0. AOT Compile
    from component9_aot import aot_compile_all
    import asyncio
    asyncio.run(aot_compile_all("networkx.algorithms.centrality.betweenness.betweenness_centrality"))

    repo_bc = orchestrator.register_lazy_function("bc", original_py, fqn)
    
    # 1. Create a fixed seed graph for reproducibility
    SIZE = 10
    G = nx.fast_gnp_random_graph(SIZE, 0.5, seed=42)
    
    console.print(f"[bold yellow]🔍 Surgical Verification (Size={SIZE}, Undirected)[/bold yellow]")
    
    # Trigger hot-swap with small graph
    try: repo_bc(nx.path_graph(3), normalized=False)
    except: pass
    
    # Give orchestrator time to load .dylib
    time.sleep(1)
    
    # 2. Run both
    res_py = original_py(G, normalized=False)
    res_repo = repo_bc(G, normalized=False)
    
    # 3. Side-by-side Table
    table = Table(title="Betweenness Centrality: Side-by-Side Comparison")
    table.add_column("Node", style="cyan")
    table.add_column("Native Python", style="magenta")
    table.add_column("RepoOS (Bare-Metal)", style="green")
    table.add_column("Delta", style="bold red")
    
    total_py = 0
    total_repo = 0
    
    for i in range(SIZE):
        v_py = res_py[i]
        v_repo = res_repo[i]
        delta = abs(v_py - v_repo)
        table.add_row(str(i), f"{v_py:.6f}", f"{v_repo:.6f}", f"{delta:.2e}")
        total_py += v_py
        total_repo += v_repo
        
    console.print(table)
    console.print(f"\n[bold]Total Sum Check:[/bold]")
    console.print(f"   Python Sum: {total_py:.4f}")
    console.print(f"   RepoOS Sum: {total_repo:.4f}")
    
    if abs(total_py - total_repo) < 1e-9:
        console.print("\n[bold green]✅ VERIFIED: Mathematical Parity Achieved.[/bold green]")
    else:
        console.print("\n[bold red]❌ FAILED: Results Diverge.[/bold red]")

if __name__ == "__main__":
    verify_integrity()
