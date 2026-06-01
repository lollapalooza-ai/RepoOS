import time
import os
import networkx as nx
import psutil

def get_resources():
    process = psutil.Process(os.getpid())
    return process.cpu_percent(interval=None), process.memory_info().rss / (1024 * 1024)

def run_native_pagerank_benchmark():
    print("🚀 Running Native PageRank Benchmark (50,000 nodes)...")
    
    # Generate Graph
    SCALE_SIZE = 50000
    print(f"Generating Random Directed Graph (Size={SCALE_SIZE})...")
    G = nx.fast_gnp_random_graph(SCALE_SIZE, 0.002, directed=True)
    for u, v in G.edges():
        G[u][v]['weight'] = 1.0
        
    ITERS = 10
    print(f"Starting PageRank (max_iter={ITERS}, alpha=0.85)...")
    
    # Benchmark
    t0 = time.perf_counter()
    start_mem = psutil.Process().memory_info().rss / (1024 * 1024)
    
    # Native PageRank Execution
    results = nx.pagerank(G, max_iter=ITERS, alpha=0.85, tol=100)
    
    t_py = time.perf_counter() - t0
    py_cpu, _ = get_resources()
    py_mem_delta = (psutil.Process().memory_info().rss / (1024 * 1024)) - start_mem
    
    print("\n--- Performance Report (Pure Python) ---")
    print(f"Execution Time: {t_py:.4f}s")
    print(f"Avg CPU Load:   {py_cpu}%")
    print(f"Memory Delta:   {py_mem_delta:.2f} MB")
    print("---------------------------------------")

if __name__ == "__main__":
    run_native_pagerank_benchmark()
