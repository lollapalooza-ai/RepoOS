
import torch
import torch_mlir
import os
import sys
import asyncio
import ctypes
import time
import psutil
from component2_smt import generate_inference_transforms
from component9_aot import apply_ai_transform_and_compile
from component10_dynamo import to_true_dps, CACHE_DIR

# Enterprise AI workload parameters
MATRIX_SIZE = 512
BENCHMARK_ITERATIONS = 10

# We use the same simple workload
class FastModel(torch.nn.Module):
    def forward(self, a, b):
        return torch.matmul(a, b)

def measure_isolated_execution(dylib_path: str):
    """
    Runs an isolated micro-benchmark inside this specific process.
    Returns (avg_time_ms, cpu_percent, memory_mb, is_correct)
    """
    # 1. Measure initial memory
    process = psutil.Process(os.getpid())
    
    # 2. Setup inputs
    a = torch.ones((MATRIX_SIZE, MATRIX_SIZE), dtype=torch.float32)
    b = torch.ones((MATRIX_SIZE, MATRIX_SIZE), dtype=torch.float32)
    out = torch.zeros_like(a)
    
    a_arr = a.detach().cpu().numpy()
    b_arr = b.detach().cpu().numpy()
    out_arr = out.detach().cpu().numpy()
    
    # 3. Load Kernel
    lib = ctypes.CDLL(dylib_path)
    k_func = lib._mlir_ciface_main if hasattr(lib, "_mlir_ciface_main") else lib.main
    k_func.restype = ctypes.c_void_p
    
    args = [
        a_arr.ctypes.data_as(ctypes.c_void_p),
        b_arr.ctypes.data_as(ctypes.c_void_p),
        out_arr.ctypes.data_as(ctypes.c_void_p)
    ]
    
    # 4. Warmup & Correctness Check
    k_func(*args)
    is_correct = bool(torch.allclose(torch.from_numpy(out_arr), torch.tensor(float(MATRIX_SIZE))))
    
    # 5. Benchmark loop (BENCHMARK_ITERATIONS iterations)
    # Reset CPU counter
    process.cpu_percent()
    
    start = time.perf_counter()
    for _ in range(BENCHMARK_ITERATIONS):
        k_func(*args)
    end = time.perf_counter()
    
    avg_time_ms = ((end - start) / float(BENCHMARK_ITERATIONS)) * 1000.0
    cpu_usage = process.cpu_percent()
    mem_mb = process.memory_info().rss / (1024 * 1024)
    
    return avg_time_ms, cpu_usage, mem_mb, float(out_arr[0,0]), is_correct

async def compile_variants():
    """Generates and compiles all variants ahead-of-time."""
    print("--- [AOT Compilation Phase] ---")
    model = FastModel()
    a = torch.ones((MATRIX_SIZE, MATRIX_SIZE), dtype=torch.float32)
    b = torch.ones((MATRIX_SIZE, MATRIX_SIZE), dtype=torch.float32)
    
    from torch_mlir.fx import export_and_import
    gm = torch.fx.symbolic_trace(model)
    base_mlir_module = export_and_import(gm, a, b, output_type="linalg-on-tensors")
    base_mlir_text = to_true_dps(str(base_mlir_module))
    
    print("1. Querying AI for 3 Scheduling Variants...")
    scripts = await generate_inference_transforms(base_mlir_text, "x86_64 Linux")
    
    dylibs = []
    
    # Compile base
    base_dylib = os.path.join(CACHE_DIR, "bench_base.so")
    print("\n2. Compiling Baseline MLIR...")
    await apply_ai_transform_and_compile(base_mlir_text, "", base_dylib, is_gpu=False)
    if os.path.exists(base_dylib): dylibs.append(("Baseline", base_dylib))
    
    # Compile variants
    from component9_aot import RepoOSSchedule, safe_execute_schedule
    for idx, script in enumerate(scripts):
        print(f"\n3. Compiling Variant {idx+1}...")
        dylib_path = os.path.join(CACHE_DIR, f"bench_v{idx+1}.so")
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
    import subprocess
    
    # If called as a subprocess to measure a specific library
    if len(sys.argv) == 3 and sys.argv[1] == "--measure":
        dylib_path = sys.argv[2]
        avg_time, cpu, mem, val, is_correct = measure_isolated_execution(dylib_path)
        print(f"{avg_time},{cpu},{mem},{val},{is_correct}")
        sys.exit(0)
        
    # Main orchestrator
    print("🚀 Starting Isolated Benchmarking Suite...")
    dylibs = asyncio.run(compile_variants())
    
    print(f"\n[Dynamo] 🏁 Racing {len(dylibs)} compiled kernels to find the Speed of Light (SoL)...")
    for name, path in dylibs:
        print(f"🏎️  {os.path.basename(path)}")
    
    print("\n\n--- [Isolated Benchmarking Phase] ---")
    print(f"{'Variant Name':<15} | {'Speed (ms)':<10} | {'CPU (%)':<10} | {'Memory (MB)':<12} | {f'Output (Expected: {float(MATRIX_SIZE)})'}")
    print("-" * 80)
    
    for name, path in dylibs:
        # Spawn a fresh process for each library to prevent memory/state bleeding
        env = os.environ.copy()
        # Ensure PYTHONPATH includes torch_mlir
        cmd = [sys.executable, __file__, "--measure", path]
        res = subprocess.run(cmd, capture_output=True, text=True, env=env)
        
        if res.returncode == 0:
            avg_time, cpu, mem, val, is_correct = res.stdout.strip().split(",")
            is_correct_bool = is_correct.strip() == "True"
            result_str = f"{float(val):.1f} (Match)" if is_correct_bool else f"{float(val):.1f} (Mismatch)"
            print(f"{name:<15} | {float(avg_time):10.4f} | {float(cpu):10.2f} | {float(mem):12.2f} | {result_str}")
        else:
            print(f"{name:<15} | {'CRASHED':<10} | {'-':<10} | {'-':<12} | False")
            print(f"  -> Error: {res.stderr.strip()}")
