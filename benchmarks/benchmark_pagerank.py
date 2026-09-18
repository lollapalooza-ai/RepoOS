import torch
import torch_mlir
import networkx as nx
import numpy as np
import os
import sys
import subprocess
import asyncio
import ctypes
import time
import psutil
from component2_smt import generate_inference_transforms
from component9_aot import apply_ai_transform_and_compile
from component10_dynamo import to_true_dps, CACHE_DIR

# Enterprise AI workload parameters
MATRIX_SIZE = 2048
BENCHMARK_ITERATIONS = 100

class PageRankLayer(torch.nn.Module):
    def forward(self, adj_dense, x, p, dangling_mask, alpha, one_minus_alpha):
        x_out = torch.mm(adj_dense, x)
        dangling_sum = torch.sum(x * dangling_mask)
        teleport = (alpha * dangling_sum) + one_minus_alpha
        x_next = (alpha * x_out) + (teleport * p)
        return x_next

def measure_isolated_execution(dylib_path: str):
    """
    Runs an isolated micro-benchmark inside this specific process.
    Returns (avg_time_ms, cpu_percent, memory_mb, val, is_correct)
    """
    torch.set_num_threads(1)
    process = psutil.Process(os.getpid())
    
    # 1. Setup inputs
    G = nx.fast_gnp_random_graph(MATRIX_SIZE, 0.05, seed=42, directed=True)
    adj_np = nx.to_numpy_array(G, weight=None)
    sums = adj_np.sum(axis=0)
    sums[sums == 0] = 1.0
    adj_np = adj_np / sums
    
    adj_dense_arr = adj_np.T.astype(np.float32)
    x_arr = np.full((MATRIX_SIZE, 1), 1.0/MATRIX_SIZE, dtype=np.float32)
    p_arr = np.full((MATRIX_SIZE, 1), 1.0/MATRIX_SIZE, dtype=np.float32)
    out_degrees = np.array([d for n, d in G.out_degree()])
    dangling_mask_arr = (out_degrees == 0).astype(np.float32).reshape(MATRIX_SIZE, 1)
    alpha_arr = np.array([0.85], dtype=np.float32)
    one_minus_alpha_arr = np.array([0.15], dtype=np.float32)
    
    out_arr = np.zeros((MATRIX_SIZE, 1), dtype=np.float32)
    
    # 2. Load Kernel
    lib = ctypes.CDLL(dylib_path)
    k_func = lib._mlir_ciface_main if hasattr(lib, "_mlir_ciface_main") else lib.main
    k_func.restype = ctypes.c_void_p
    
    args = [
        adj_dense_arr.ctypes.data_as(ctypes.c_void_p),
        x_arr.ctypes.data_as(ctypes.c_void_p),
        p_arr.ctypes.data_as(ctypes.c_void_p),
        dangling_mask_arr.ctypes.data_as(ctypes.c_void_p),
        alpha_arr.ctypes.data_as(ctypes.c_void_p),
        one_minus_alpha_arr.ctypes.data_as(ctypes.c_void_p),
        out_arr.ctypes.data_as(ctypes.c_void_p)
    ]
    
    # 3. Warmup & Correctness Check
    k_func(*args)
    
    # Calculate ground truth expected output
    x_out = adj_dense_arr @ x_arr
    dangling_sum = np.sum(x_arr * dangling_mask_arr)
    teleport = (0.85 * dangling_sum) + 0.15
    expected_out = (0.85 * x_out) + (teleport * p_arr)
    
    is_correct = bool(np.allclose(out_arr, expected_out, rtol=1e-3, atol=1e-3))
    
    # 4. Benchmark loop
    start = time.perf_counter()
    start_cpu = time.process_time()
    for _ in range(BENCHMARK_ITERATIONS):
        k_func(*args)
    end = time.perf_counter()
    end_cpu = time.process_time()
    
    avg_time_ms = ((end - start) / float(BENCHMARK_ITERATIONS)) * 1000.0
    avg_cpu_time_ms = ((end_cpu - start_cpu) / float(BENCHMARK_ITERATIONS)) * 1000.0
    mem_mb = process.memory_info().rss / (1024 * 1024)
    
    return avg_time_ms, avg_cpu_time_ms, mem_mb, float(out_arr[0,0]), is_correct

async def compile_variants():
    """Generates and compiles all variants ahead-of-time."""
    print("--- [AOT Compilation Phase] ---")
    model = PageRankLayer()
    
    # Setup standard inputs for MLIR tracing
    G = nx.fast_gnp_random_graph(MATRIX_SIZE, 0.05, seed=42, directed=True)
    adj_np = nx.to_numpy_array(G, weight=None)
    sums = adj_np.sum(axis=0)
    sums[sums == 0] = 1.0
    adj_np = adj_np / sums
    
    adj_dense = torch.from_numpy(adj_np.T).float()
    x = torch.full((MATRIX_SIZE, 1), 1.0/MATRIX_SIZE)
    p = torch.full((MATRIX_SIZE, 1), 1.0/MATRIX_SIZE)
    out_degrees = np.array([d for n, d in G.out_degree()])
    dangling_mask = torch.from_numpy((out_degrees == 0).astype(np.float32)).view(MATRIX_SIZE, 1)
    alpha = torch.tensor([0.85], dtype=torch.float32)
    one_minus_alpha = torch.tensor([0.15], dtype=torch.float32)

    from torch_mlir.fx import export_and_import
    gm = torch.fx.symbolic_trace(model)
    base_mlir_module = export_and_import(gm, adj_dense, x, p, dangling_mask, alpha, one_minus_alpha, output_type="linalg-on-tensors")
    base_mlir_text = to_true_dps(str(base_mlir_module))
    
    print("1. Querying AI for 3 Scheduling Variants...")
    scripts = await generate_inference_transforms(base_mlir_text, "x86_64 Linux")
    
    dylibs = []
    
    # Compile base
    base_dylib = os.path.join(CACHE_DIR, "bench_pagerank_base.so")
    print("\n2. Compiling Baseline MLIR...")
    await apply_ai_transform_and_compile(base_mlir_text, "", base_dylib, is_gpu=False)
    if os.path.exists(base_dylib): dylibs.append(("Baseline", base_dylib))
    
    # Compile variants
    from component9_aot import RepoOSSchedule, safe_execute_schedule
    for idx, script in enumerate(scripts):
        print(f"\n3. Compiling Variant {idx+1}...")
        dylib_path = os.path.join(CACHE_DIR, f"bench_pagerank_v{idx+1}.so")
        try:
            schedule = RepoOSSchedule()
            safe_execute_schedule(script, schedule)
            transform_mlir = schedule.build_mlir()
            await apply_ai_transform_and_compile(base_mlir_text, transform_mlir, dylib_path, is_gpu=False)
            if os.path.exists(dylib_path):
                dylibs.append((f"Variant {idx+1}", dylib_path))
        except Exception as e:
            print(f"Skipping Variant {idx+1} due to error: {e}")
            
    return dylibs

if __name__ == "__main__":
    # If called as a subprocess to measure a specific library
    if len(sys.argv) == 3 and sys.argv[1] == "--measure":
        dylib_path = sys.argv[2]
        avg_time, cpu, mem, val, is_correct = measure_isolated_execution(dylib_path)
        print(f"{avg_time},{cpu},{mem},{val},{is_correct}")
        sys.exit(0)
        
    # Main orchestrator
    print("🚀 Starting Isolated PageRank Benchmarking Suite...")
    dylibs = asyncio.run(compile_variants())
    
    print(f"\n[Dynamo] 🏁 Racing {len(dylibs)} compiled kernels to find the Speed of Light (SoL)...")
    for name, path in dylibs:
        print(f"🏎️  {os.path.basename(path)}")
    
    print("\n\n--- [Isolated Benchmarking Phase] ---")
    print(f"{'Variant Name':<15} | {'Speed (ms)':<10} | {'CPU Time (ms)':<13} | {'Memory (MB)':<12} | {'Output[0,0]'}")
    print("-" * 85)
    
    for name, path in dylibs:
        # Spawn a fresh process for each library to prevent memory/state bleeding
        env = os.environ.copy()
        env["OMP_NUM_THREADS"] = "1"
        env["MKL_NUM_THREADS"] = "1"
        env["OPENBLAS_NUM_THREADS"] = "1"
        env["VECLIB_MAXIMUM_THREADS"] = "1"
        env["NUMEXPR_NUM_THREADS"] = "1"
        # Ensure PYTHONPATH includes torch_mlir
        cmd = [sys.executable, __file__, "--measure", path]
        res = subprocess.run(cmd, capture_output=True, text=True, env=env)
        
        if res.returncode == 0:
            avg_time, cpu, mem, val, is_correct = res.stdout.strip().split(",")
            is_correct_bool = is_correct.strip() == "True"
            result_str = f"{float(val):.6f} (Match)" if is_correct_bool else f"{float(val):.6f} (Mismatch)"
            print(f"{name:<15} | {float(avg_time):10.4f} | {float(cpu):13.4f} | {float(mem):12.2f} | {result_str}")
        else:
            print(f"{name:<15} | {'CRASHED':<10} | {'-':<10} | {'-':<12} | False")
            print(f"  -> Error: {res.stderr.strip()}")
