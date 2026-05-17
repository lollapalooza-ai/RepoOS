import time
import sys
import os
import argparse
import networkx as nx
import numpy as np
import psutil
import threading
from rich.console import Console
from rich.live import Live
from rich.panel import Panel
from rich.table import Table

# --- 1. BOOTSTRAP ENVIRONMENT ---
PROJECT_ROOT = "/Users/yeshr/Applications/Program1"
if PROJECT_ROOT not in sys.path:
    sys.path.insert(0, PROJECT_ROOT)

console = Console()

def monitor_resources(stop_event, stats):
    process = psutil.Process(os.getpid())
    cpu_samples = []
    mem_samples = []
    while not stop_event.is_set():
        cpu_samples.append(process.cpu_percent(interval=0.1))
        mem_samples.append(process.memory_info().rss / (1024 * 1024))
        time.sleep(0.1)
    if cpu_samples:
        stats['cpu_avg'] = sum(cpu_samples) / len(cpu_samples)
        stats['mem_max'] = max(mem_samples)

def run_demo():
    parser = argparse.ArgumentParser()
    parser.add_argument("--mode", choices=["native", "repoos"], required=True)
    parser.add_argument("--nodes", type=int, default=50000)
    parser.add_argument("--iters", type=int, default=20)
    args = parser.parse_args()

    mode_name = "RepoOS (AI-MLIR)" if args.mode == "repoos" else "Native Python (CPython)"
    mode_color = "green" if args.mode == "repoos" else "magenta"

    console.print(Panel(f"[bold {mode_color}]🚀 Starting PageRank: {mode_name}[/bold {mode_color}]\n"
                        f"Graph Size: {args.nodes} nodes | Iterations: {args.iters}", 
                        title="RepoOS Performance Demo", border_style=mode_color))

    # Import orchestrator only if needed to avoid overhead in native mode
    if args.mode == "repoos":
        from component5_orchestrator import LazyCallManager
        orchestrator = LazyCallManager()
        from networkx.algorithms.link_analysis.pagerank_alg import _pagerank_python as original_py_pagerank
        fqn = "networkx.algorithms.link_analysis.pagerank_alg._pagerank_python"
        pagerank_func = orchestrator.register_lazy_function("_pagerank_python", original_py_pagerank, fqn)
        # Give it a second to ensure hot-swap
        time.sleep(1)
    else:
        from networkx.algorithms.link_analysis.pagerank_alg import _pagerank_python as pagerank_func

    # Generate Graph
    console.print(f"[dim]Generating random graph ({args.nodes} nodes)...[/dim]")
    G = nx.fast_gnp_random_graph(args.nodes, 0.002, directed=True, seed=42)
    for u, v in G.edges(): G[u][v]['weight'] = 1.0

    # Setup monitoring
    stats = {'cpu_avg': 0, 'mem_max': 0}
    stop_event = threading.Event()
    monitor_thread = threading.Thread(target=monitor_resources, args=(stop_event, stats))
    monitor_thread.start()

    # Execute
    console.print(f"[bold {mode_color}]Executing {args.iters} Power Iterations...[/bold {mode_color}]")
    t0 = time.perf_counter()
    res = pagerank_func(G, max_iter=args.iters, alpha=0.85, tol=1e-12)
    t_final = time.perf_counter() - t0

    # Stop monitoring
    stop_event.set()
    monitor_thread.join()

    # Final Dashboard
    table = Table(show_header=False, box=None)
    table.add_row(f"[bold {mode_color}]Total Time:[/bold {mode_color}]", f"{t_final:.4f} seconds")
    table.add_row(f"[bold {mode_color}]Avg CPU Usage:[/bold {mode_color}]", f"{stats['cpu_avg']:.1f}%")
    table.add_row(f"[bold {mode_color}]Peak Memory:[/bold {mode_color}]", f"{stats['mem_max']:.2f} MB")
    
    console.print("\n", Panel(table, title="Execution Results", border_style=mode_color))

if __name__ == "__main__":
    run_demo()
