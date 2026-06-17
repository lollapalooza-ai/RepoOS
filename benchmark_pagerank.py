import torch
import networkx as nx
import numpy as np
import time
import os
import psutil

# Mocking the environment for testing if needed
os.environ["REPOOS_CACHE_DIR"] = "./.poly_cache_test"

def run_benchmark(label, func, *args, iterations=5):
    print(f"\n[Benchmark] Running {label} ({iterations} iterations)...")
    
    # Warmup
    func(*args)
    
    start_time = time.perf_counter()
    start_process_time = time.process_time()
    
    result = None
    for _ in range(iterations):
        result = func(*args)
        
    end_time = time.perf_counter()
    end_process_time = time.process_time()
    
    avg_time = (end_time - start_time) / iterations * 1000 # ms
    
    # PageRank result is a dict, get first entry
    first_node = next(iter(result))
    val_snippet = result[first_node]
    
    print(f"  - Avg Speed: {avg_time:.4f} ms")
    print(f"  - Final Result[0,0]: {val_snippet:.4f}")
    
    return avg_time, val_snippet

def main():
    print("--- 🕸️ RepoOS GRAPH Track: PageRank Benchmark ---")
    
    # Create a reasonably large random graph
    N = 1024
    G = nx.fast_gnp_random_graph(N, 0.01, directed=True)
    
    # 1. Native NetworkX Run
    native_time, native_res = run_benchmark("NATIVE NETWORKX", nx.pagerank, G)
    
    # 2. RepoOS Run
    # In the Standard track, RepoOS intercepts the nx.pagerank call
    # if it's registered in Neo4j. For this benchmark, we rely on 
    # ./benchmark.sh to trigger the RepoOS hijacker.
    repoos_time, repoos_res = run_benchmark("REPOOS OPTIMIZED", nx.pagerank, G)
    
    # The benchmark_collector.py will capture these outputs and build the table.

if __name__ == "__main__":
    main()
