import torch
import os
import time
import psutil
from component10_dynamo import repoos_inference_backend

# Mocking the environment for testing
os.environ["REPOOS_CACHE_DIR"] = "./.poly_cache_test"

class SimpleModel(torch.nn.Module):
    def __init__(self):
        super().__init__()
        self.relu = torch.nn.ReLU()

    def forward(self, x):
        return self.relu(x + 1.0)

def get_metrics():
    process = psutil.Process(os.getpid())
    mem = process.memory_info().rss / (1024 * 1024)  # MB
    return mem

def run_benchmark(label, model_fn, inputs, iterations=100):
    print(f"\n[Benchmark] Running {label} ({iterations} iterations)...")
    
    # Warmup
    model_fn(*inputs)
    
    start_mem = get_metrics()
    start_time = time.perf_counter()
    start_process_time = time.process_time()
    
    result = None
    for _ in range(iterations):
        result = model_fn(*inputs)
        
    end_time = time.perf_counter()
    end_process_time = time.process_time()
    end_mem = get_metrics()
    
    avg_time = (end_time - start_time) / iterations * 1000 # ms
    cpu_usage = (end_process_time - start_process_time) / (end_time - start_time) * 100 # %
    
    # Unbox list result if needed (RepoOS returns list)
    if isinstance(result, (list, tuple)):
        result = result[0]
        
    val_snippet = result[0, 0].item() if hasattr(result, "item") else result
    
    print(f"  - Avg Speed: {avg_time:.4f} ms")
    print(f"  - Final Result[0,0]: {val_snippet:.4f}")
    
    return avg_time, end_mem, cpu_usage, val_snippet

def test_inference_pipeline():
    print("--- 🧪 RepoOS INFERENCE Track: Performance Comparison ---")
    model = SimpleModel()
    # Scaling up to 1024x1024
    example_input = torch.randn(1024, 1024)
    
    # 1. Native Python Run
    native_time, native_mem, native_cpu, native_res = run_benchmark("NATIVE PYTHON", model, [example_input])
    
    # 2. RepoOS Run
    print("\n[Test] Compiling RepoOS Optimized Kernel...")
    # Trigger the Dynamo backend manually for this isolated test
    optimized_fn = repoos_inference_backend(torch.fx.symbolic_trace(model), [example_input])
    
    repoos_time, repoos_mem, repoos_cpu, repoos_res = run_benchmark("REPOOS OPTIMIZED", optimized_fn, [example_input])
    
    # Comparison
    print("\n" + "="*70)
    print(f"{'Metric':20} | {'Native':12} | {'RepoOS':12} | {'Gain/Diff'}")
    print("-"*70)
    speedup = native_time / repoos_time if repoos_time > 0 else 0
    print(f"{'Speed (ms)':20} | {native_time:12.4f} | {repoos_time:12.4f} | {speedup:.2f}x")
    mem_delta = repoos_mem - native_mem
    print(f"{'Memory (MB)':20} | {native_mem:12.2f} | {repoos_mem:12.2f} | {mem_delta:+.2f} MB")
    cpu_delta = repoos_cpu - native_cpu
    print(f"{'CPU Usage (%)':20} | {native_cpu:12.2f} | {repoos_cpu:12.2f} | {cpu_delta:+.2f}%")
    print(f"{'Final Result[0,0]':20} | {native_res:12.4f} | {repoos_res:12.4f} | {'MATCH' if abs(native_res-repoos_res)<1e-5 else 'MISMATCH'}")
    print("="*70)

if __name__ == "__main__":
    test_inference_pipeline()
