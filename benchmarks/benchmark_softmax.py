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
from component10_dynamo import to_true_dps, CACHE_DIR, capture_dynamic_mlir
from component5_orchestrator import pack_tensor_to_memref

# AI workload parameters
BATCH_SIZE = 2
SEQ_LEN = 128
HEAD_DIM = 64
BENCHMARK_ITERATIONS = 3

class SoftmaxModel(torch.nn.Module):
    def forward(self, x):
        return torch.nn.functional.softmax(x, dim=-1)

async def compile_variants():
    print("🚀 Starting Softmax Isolated Benchmarking Suite...")
    model = SoftmaxModel()
    x = torch.randn((BATCH_SIZE, SEQ_LEN, HEAD_DIM), dtype=torch.float32)
    
    import torch.fx as fx
    gm = fx.symbolic_trace(model)
    
    print("1. Tracing Softmax block into MLIR...")
    base_mlir_module_str = capture_dynamic_mlir(gm, [x])
    base_mlir_text = to_true_dps(base_mlir_module_str)
    
    print("2. Querying AI for 3 Scheduling Variants...")
    scripts = await generate_inference_transforms(base_mlir_text, "x86_64 Linux")
    
    dylibs = []
    
    # Compile base
    base_dylib = os.path.join(CACHE_DIR, "softmax_base.so")
    print("\n3. Compiling Baseline MLIR...")
    await apply_ai_transform_and_compile(base_mlir_text, "", base_dylib, is_gpu=False)
    if os.path.exists(base_dylib): dylibs.append(("Baseline", base_dylib))
    
    # Compile variants
    from component9_aot import RepoOSSchedule, safe_execute_schedule
    for idx, script in enumerate(scripts):
        print(f"\n4. Compiling Variant {idx+1}...")
        dylib_path = os.path.join(CACHE_DIR, f"softmax_v{idx+1}.so")
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

def measure_isolated_execution(dylib_path: str, seq_len: int):
    torch.set_num_threads(1)
    process = psutil.Process(os.getpid())
    torch.manual_seed(42)
    
    x = torch.randn((BATCH_SIZE, seq_len, HEAD_DIM), dtype=torch.float32)
    out = torch.zeros_like(x)
    
    model = SoftmaxModel()
    expected_out = model(x)
    out_arr = out.detach().cpu().numpy()
    
    lib = ctypes.CDLL(dylib_path)
    k_func = lib._mlir_ciface_main if hasattr(lib, "_mlir_ciface_main") else lib.main
    k_func.restype = ctypes.c_void_p
    
    structs = [
        pack_tensor_to_memref(x),
        pack_tensor_to_memref(out)
    ]
    
    args = [ctypes.byref(s) for s in structs]
    
    k_func(*args)
    is_correct = bool(torch.allclose(torch.from_numpy(out_arr), expected_out, atol=1e-3))
    
    start_time = time.perf_counter()
    start_cpu = process.cpu_times()
    
    for _ in range(BENCHMARK_ITERATIONS):
        k_func(*args)
        
    end_time = time.perf_counter()
    end_cpu = process.cpu_times()
    
    avg_time = ((end_time - start_time) / BENCHMARK_ITERATIONS) * 1000
    cpu_time = (((end_cpu.user - start_cpu.user) + (end_cpu.system - start_cpu.system)) / BENCHMARK_ITERATIONS) * 1000
    mem_usage = process.memory_info().rss / (1024 * 1024)
    
    return avg_time, cpu_time, mem_usage, is_correct

if __name__ == "__main__":
    import argparse
    
    if len(sys.argv) >= 3 and sys.argv[1] == "--measure":
        dylib_path = sys.argv[2]
        seq_len = int(sys.argv[3])
        avg_time, cpu, mem, is_correct = measure_isolated_execution(dylib_path, seq_len)
        
        import torch
        torch.manual_seed(42)
        x = torch.randn((BATCH_SIZE, seq_len, HEAD_DIM), dtype=torch.float32)
        model = SoftmaxModel()
        expected_out = model(x)
        tensor_str = str(expected_out[0, 0, :4].tolist())
        print(f"{avg_time},{cpu},{mem},{is_correct},{tensor_str}")
        sys.exit(0)
        
    parser = argparse.ArgumentParser()
    parser.add_argument('--use-variant', type=str, default=None)
    parser.add_argument('--seq-len', type=int, default=128)
    args = parser.parse_args()

    if args.use_variant:
        dylibs = []
        if args.use_variant in ["all", "all_variants"]:
            for f in sorted(os.listdir(CACHE_DIR)):
                if f.startswith("softmax_") and f.endswith(".so"):
                    dylibs.append((f.replace(".so", ""), os.path.join(CACHE_DIR, f)))
        else:
            dylibs.append((args.use_variant.replace(".so", ""), os.path.join(CACHE_DIR, args.use_variant)))
    else:
        dylibs = asyncio.run(compile_variants())
    
    import subprocess
    for seq_len in [5, 500]:
        print(f"\n\n--- [Isolated Benchmarking Phase - Sequence Length {seq_len}] ---")
        print(f"{'Variant Name':<15} | {'Speed (ms)':<10} | {'CPU Time (ms)':<13} | {'Memory (MB)':<12} | {'Correct'}")
        print("-" * 80)
        
        for name, path in dylibs:
            env = os.environ.copy()
            env["OMP_NUM_THREADS"] = "1"
            env["MKL_NUM_THREADS"] = "1"
            env["OPENBLAS_NUM_THREADS"] = "1"
            env["VECLIB_MAXIMUM_THREADS"] = "1"
            env["NUMEXPR_NUM_THREADS"] = "1"
            
            cmd = [sys.executable, __file__, "--measure", path, str(seq_len)]
            res = subprocess.run(cmd, capture_output=True, text=True, env=env)
            
            if res.returncode == 0:
                parts = res.stdout.strip().split(",", 4)
                avg_time, cpu, mem, is_correct = parts[:4]
                is_correct_bool = is_correct.strip() == "True"
                result_str = "Match" if is_correct_bool else "Mismatch"
                print(f"{name:<15} | {float(avg_time):10.4f} | {float(cpu):13.4f} | {float(mem):12.2f} | {result_str}")
                if len(parts) > 4:
                    print(f"  -> First 4 float values of Output Tensor: {parts[4]}")
            else:
                print(f"{name:<15} | {'CRASHED':<10} | {'-':<10} | {'-':<12} | False")
                print(f"  -> Error: {res.stderr.strip()}")
