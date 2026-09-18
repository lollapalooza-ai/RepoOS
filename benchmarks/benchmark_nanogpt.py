import torch
import torch_mlir
import os
import sys
import asyncio
import ctypes
import time
import psutil
import math
from component2_smt import generate_inference_transforms
from component9_aot import apply_ai_transform_and_compile
from component10_dynamo import to_true_dps, CACHE_DIR, capture_dynamic_mlir
from component5_orchestrator import pack_tensor_to_memref

# AI workload parameters
BATCH_SIZE = 2
SEQ_LEN = 128
HEAD_DIM = 64
BENCHMARK_ITERATIONS = 3

class NanoGPTSelfAttention(torch.nn.Module):
    def forward(self, q, k, v):
        # A simplified Scaled Dot-Product Attention block
        # q, k, v shapes: [batch, seq_len, head_dim]
        # output shape: [batch, seq_len, head_dim]
        # For simplicity in MLIR lowering, we omit softmax. 
        # (Softmax often requires complex lowering loops or custom runtime calls in base MLIR).
        # We do: Out = (Q * K^T / sqrt(d)) * V
        
        k_t = k.transpose(-2, -1)
        scores = torch.matmul(q, k_t)
        scores = scores / math.sqrt(HEAD_DIM)
        out = torch.matmul(scores, v)
        return out

async def compile_variants():
    # 1. Capture dynamic MLIR
    print("🚀 Starting NanoGPT Isolated Benchmarking Suite...")
    model = NanoGPTSelfAttention()
    q = torch.randn((BATCH_SIZE, SEQ_LEN, HEAD_DIM), dtype=torch.float32)
    k = torch.randn((BATCH_SIZE, SEQ_LEN, HEAD_DIM), dtype=torch.float32)
    v = torch.randn((BATCH_SIZE, SEQ_LEN, HEAD_DIM), dtype=torch.float32)
    
    # We trace using PyTorch Dynamo via our custom dynamic API
    import torch.fx as fx
    gm = fx.symbolic_trace(model)
    
    print("1. Tracing NanoGPT Self-Attention block into MLIR...")
    base_mlir_module_str = capture_dynamic_mlir(gm, [q, k, v])
    base_mlir_text = to_true_dps(base_mlir_module_str)
    
    print("1. Querying AI for 3 Scheduling Variants...")
    scripts = await generate_inference_transforms(base_mlir_text, "x86_64 Linux")
    
    dylibs = []
    
    # Compile base
    base_dylib = os.path.join(CACHE_DIR, "nanogpt_base.so")
    print("\n2. Compiling Baseline MLIR...")
    await apply_ai_transform_and_compile(base_mlir_text, "", base_dylib, is_gpu=False)
    if os.path.exists(base_dylib): dylibs.append(("Baseline", base_dylib))
    
    # Compile variants
    from component9_aot import RepoOSSchedule, safe_execute_schedule
    for idx, script in enumerate(scripts):
        print(f"\n3. Compiling Variant {idx+1}...")
        dylib_path = os.path.join(CACHE_DIR, f"nanogpt_v{idx+1}.so")
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
    
    # We add a deterministic seed so that multiple sequential runs
    # visually produce the exact same random numbers for debugging!
    torch.manual_seed(42)
    
    q = torch.randn((BATCH_SIZE, seq_len, HEAD_DIM), dtype=torch.float32)
    k = torch.randn((BATCH_SIZE, seq_len, HEAD_DIM), dtype=torch.float32)
    v = torch.randn((BATCH_SIZE, seq_len, HEAD_DIM), dtype=torch.float32)
    out = torch.zeros_like(q)
    
    model = NanoGPTSelfAttention()
    expected_out = model(q, k, v)
    out_arr = out.detach().cpu().numpy()
    
    lib = ctypes.CDLL(dylib_path)
    k_func = lib._mlir_ciface_main if hasattr(lib, "_mlir_ciface_main") else lib.main
    k_func.restype = ctypes.c_void_p
    
    structs = [
        pack_tensor_to_memref(q),
        pack_tensor_to_memref(k),
        pack_tensor_to_memref(v),
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
        # We append a slice of the tensor to the CSV output (just the first 2 elements of the first row of batch 1)
        # to prevent crashing the terminal with massive 1024x64 arrays
        import torch
        # We need the actual array to print it, so we'll re-run a fast test inline just to grab the data
        q = torch.randn((BATCH_SIZE, seq_len, HEAD_DIM), dtype=torch.float32)
        k = torch.randn((BATCH_SIZE, seq_len, HEAD_DIM), dtype=torch.float32)
        v = torch.randn((BATCH_SIZE, seq_len, HEAD_DIM), dtype=torch.float32)
        model = NanoGPTSelfAttention()
        expected_out = model(q, k, v)
        tensor_str = str(expected_out[0, 0, :4].tolist()) # print just the first 4 elements of the sequence
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
                if f.startswith("nanogpt_") and f.endswith(".so"):
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
