import torch
import networkx as nx
import numpy as np
import time
import os
import psutil

# Check if we should use RepoOS backend
USE_REPOOS = os.environ.get("REPOOS_INFERENCE") == "1"

class PageRankLayer(torch.nn.Module):
    def __init__(self, alpha=0.85):
        super().__init__()
        self.alpha = alpha

    def forward(self, adj_dense, x, p, dangling_mask):
        x_out = torch.mm(adj_dense, x)
        dangling_sum = torch.sum(x * dangling_mask)
        teleport = (self.alpha * dangling_sum) + (1.0 - self.alpha)
        x_next = (self.alpha * x_out) + (teleport * p)
        return x_next

def main():
    N = 1024
    G = nx.fast_gnp_random_graph(N, 0.05, seed=42, directed=True)
    
    adj_np = nx.to_numpy_array(G, weight=None)
    sums = adj_np.sum(axis=0)
    sums[sums == 0] = 1.0
    adj_np = adj_np / sums
    
    adj_dense = torch.from_numpy(adj_np.T).float()
    x = torch.full((N, 1), 1.0/N)
    p = torch.full((N, 1), 1.0/N)
    out_degrees = np.array([d for n, d in G.out_degree()])
    dangling_mask = torch.from_numpy((out_degrees == 0).astype(np.float32)).view(N, 1)

    model = PageRankLayer()
    inputs = [adj_dense, x, p, dangling_mask]

    print(f"[Debug] REPOOS_INFERENCE env: {os.environ.get('REPOOS_INFERENCE')}")
    print(f"[Debug] USE_REPOOS: {USE_REPOOS}")

    if USE_REPOOS:
        print("[Debug] Attempting to torch.compile with repoos_inference_backend...")
        from component10_dynamo import repoos_inference_backend
        model = torch.compile(model, backend='repoos_inference_backend')

    # Run Benchmark
    iterations = 5
    # Warmup
    model(*inputs)
    
    start = time.perf_counter()
    for _ in range(iterations):
        result = model(*inputs)
    end = time.perf_counter()
    
    avg_time = (end - start) / iterations * 1000
    if isinstance(result, (list, tuple)): result = result[0]
    val_snippet = result[0, 0].item()
    
    print(f"  - Avg Speed: {avg_time:.4f} ms")
    print(f"  - Final Result[0,0]: {val_snippet:.4f}")

if __name__ == "__main__":
    main()
