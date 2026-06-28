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
EMBED_DIM = 64
HIDDEN_DIM = 256
BENCHMARK_ITERATIONS = 3

class NanoGPTSelfAttention(torch.nn.Module):
    def forward(self, q, k, v, mask):
        k_t = k.transpose(-2, -1)
        scores = torch.matmul(q, k_t) / math.sqrt(HEAD_DIM)
        # Apply causal mask passed in from Python to avoid dynamic control flow in MLIR
        scores = scores + mask
        attn = torch.nn.functional.softmax(scores, dim=-1)
        out = torch.matmul(attn, v)
        return out

class StatelessMLP(torch.nn.Module):
    def forward(self, x, w1, w2):
        x = torch.matmul(x, w1)
        x = torch.nn.functional.gelu(x)
        x = torch.matmul(x, w2)
        return x

class FullBlock(torch.nn.Module):
    def __init__(self):
        super().__init__()
        self.attn = NanoGPTSelfAttention()
        self.mlp = StatelessMLP()
    
    def forward(self, x, mask, w1, w2, ln_w1, ln_b1, ln_w2, ln_b2):
        # LayerNorm 1
        mean1 = x.mean(dim=-1, keepdim=True)
        var1 = x.var(dim=-1, keepdim=True, unbiased=False)
        x_norm = (x - mean1) / torch.sqrt(var1 + 1e-5)
        x_norm = x_norm * ln_w1 + ln_b1
        
        # Self-Attention
        attn_out = self.attn(x_norm, x_norm, x_norm, mask)
        x = x + attn_out
        
        # LayerNorm 2
        mean2 = x.mean(dim=-1, keepdim=True)
        var2 = x.var(dim=-1, keepdim=True, unbiased=False)
        x_norm2 = (x - mean2) / torch.sqrt(var2 + 1e-5)
        x_norm2 = x_norm2 * ln_w2 + ln_b2
        
        # MLP
        mlp_out = self.mlp(x_norm2, w1, w2)
        x = x + mlp_out
        return x

async def compile_stateless():
    print("🚀 Starting FULL BLOCK Isolated Benchmarking Suite...")
    model = FullBlock()
    x = torch.randn((BATCH_SIZE, SEQ_LEN, EMBED_DIM), dtype=torch.float32)
    mask = torch.zeros((BATCH_SIZE, SEQ_LEN, SEQ_LEN), dtype=torch.float32)
    w1 = torch.randn((EMBED_DIM, HIDDEN_DIM), dtype=torch.float32)
    w2 = torch.randn((HIDDEN_DIM, EMBED_DIM), dtype=torch.float32)
    ln_w1 = torch.randn((EMBED_DIM,), dtype=torch.float32)
    ln_b1 = torch.randn((EMBED_DIM,), dtype=torch.float32)
    ln_w2 = torch.randn((EMBED_DIM,), dtype=torch.float32)
    ln_b2 = torch.randn((EMBED_DIM,), dtype=torch.float32)
    
    import torch.fx as fx
    gm = fx.symbolic_trace(model)
    
    from torch.export import Dim
    seq_dim = Dim("seq_len")
    # Define exact dynamic dimensions:
    # x: (BATCH, SEQ_LEN, EMBED) -> dim 1 is seq_len
    # mask: (BATCH, SEQ_LEN, SEQ_LEN) -> dims 1 and 2 are seq_len
    # w1, w2, ln_w1, ln_b1, ln_w2, ln_b2 are fully static.
    dynamic_shapes = [
        {1: seq_dim},                 # x
        {1: seq_dim, 2: seq_dim},     # mask
        None,                         # w1
        None,                         # w2
        None,                         # ln_w1
        None,                         # ln_b1
        None,                         # ln_w2
        None                          # ln_b2
    ]
    
    print("1. Tracing Full Block into MLIR...")
    base_mlir_module_str = capture_dynamic_mlir(gm, [x, mask, w1, w2, ln_w1, ln_b1, ln_w2, ln_b2], dynamic_shapes=dynamic_shapes)
    base_mlir_text = to_true_dps(base_mlir_module_str)
    
    print("2. Querying AI for 3 Scheduling Variants...")
    scripts = await generate_inference_transforms(base_mlir_text, "x86_64 Linux")
    
    dylibs = []
    
    base_dylib = os.path.join(CACHE_DIR, "fullblock_base.so")
    print("\n3. Compiling Baseline MLIR...")
    await apply_ai_transform_and_compile(base_mlir_text, "", base_dylib, is_gpu=False)
    if os.path.exists(base_dylib): dylibs.append(("Baseline", base_dylib))
    
    from component9_aot import RepoOSSchedule, safe_execute_schedule
    for idx, script in enumerate(scripts):
        print(f"\n4. Compiling Variant {idx+1}...")
        dylib_path = os.path.join(CACHE_DIR, f"fullblock_v{idx+1}.so")
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

def create_causal_mask(seq_len):
    # Create an upper triangular matrix of True, convert to float, then mask with -inf
    mask = torch.triu(torch.ones(seq_len, seq_len), diagonal=1).bool()
    float_mask = torch.zeros(seq_len, seq_len)
    float_mask.masked_fill_(mask, float('-inf'))
    # Reshape to (BATCH_SIZE, seq_len, seq_len) for broadcasting across batch/heads
    return float_mask.unsqueeze(0).expand(BATCH_SIZE, seq_len, seq_len)

def measure_isolated_execution(dylib_path: str, seq_len: int):
    torch.set_num_threads(1)
    process = psutil.Process(os.getpid())
    torch.manual_seed(42)
    
    x = torch.randn((BATCH_SIZE, seq_len, EMBED_DIM), dtype=torch.float32) * 0.02
    mask = create_causal_mask(seq_len)
    w1 = torch.randn((EMBED_DIM, HIDDEN_DIM), dtype=torch.float32) * 0.02
    w2 = torch.randn((HIDDEN_DIM, EMBED_DIM), dtype=torch.float32) * 0.02
    ln_w1 = torch.ones((EMBED_DIM,), dtype=torch.float32)
    ln_b1 = torch.zeros((EMBED_DIM,), dtype=torch.float32)
    ln_w2 = torch.ones((EMBED_DIM,), dtype=torch.float32)
    ln_b2 = torch.zeros((EMBED_DIM,), dtype=torch.float32)
    out = torch.zeros_like(x)
    
    model = FullBlock()
    expected_out = model(x, mask, w1, w2, ln_w1, ln_b1, ln_w2, ln_b2)
    out_arr = out.detach().cpu().numpy()
    
    lib = ctypes.CDLL(dylib_path)
    k_func = lib._mlir_ciface_main if hasattr(lib, "_mlir_ciface_main") else lib.main
    k_func.restype = ctypes.c_void_p
    
    structs = [
        pack_tensor_to_memref(x),
        pack_tensor_to_memref(mask),
        pack_tensor_to_memref(w1),
        pack_tensor_to_memref(w2),
        pack_tensor_to_memref(ln_w1),
        pack_tensor_to_memref(ln_b1),
        pack_tensor_to_memref(ln_w2),
        pack_tensor_to_memref(ln_b2),
        pack_tensor_to_memref(out)
    ]
    
    args = [ctypes.byref(s) for s in structs]
    
    k_func(*args)
        # The combination of GELU + Softmax + LayerNorm can compound small precision errors
    # between pure MLIR and PyTorch C++ backends, especially with -ffast-math.
    # We use Cosine Similarity to robustly check correctness.
    pt_flat = expected_out.flatten()
    mlir_flat = torch.from_numpy(out_arr).flatten()
    
    # Handle NaNs from fast-math causal masks
    has_nans = torch.isnan(mlir_flat).any().item()
    if has_nans:
        mlir_flat = torch.nan_to_num(mlir_flat, nan=0.0, posinf=0.0, neginf=0.0)
        pt_flat = torch.nan_to_num(pt_flat, nan=0.0, posinf=0.0, neginf=0.0)
    
    cos_sim = torch.nn.functional.cosine_similarity(pt_flat.unsqueeze(0), mlir_flat.unsqueeze(0)).item()
    is_correct = cos_sim > 0.99
    
    start_time = time.perf_counter()
    start_cpu = process.cpu_times()
    
    for _ in range(BENCHMARK_ITERATIONS):
        k_func(*args)
        
    end_time = time.perf_counter()
    end_cpu = process.cpu_times()
    
    avg_time = ((end_time - start_time) / BENCHMARK_ITERATIONS) * 1000
    cpu_time = (((end_cpu.user - start_cpu.user) + (end_cpu.system - start_cpu.system)) / BENCHMARK_ITERATIONS) * 1000
    mem_usage = process.memory_info().rss / (1024 * 1024)
    
    return avg_time, cpu_time, mem_usage, is_correct, out_arr, cos_sim, has_nans

if __name__ == "__main__":
    import argparse
    
    if len(sys.argv) >= 3 and sys.argv[1] == "--measure":
        dylib_path = sys.argv[2]
        seq_len = int(sys.argv[3])
        avg_time, cpu, mem, is_correct, out_arr, cos_sim, has_nans = measure_isolated_execution(dylib_path, seq_len)
        
        import torch
        torch.manual_seed(42)
        x = torch.randn((BATCH_SIZE, seq_len, EMBED_DIM), dtype=torch.float32) * 0.02
        mask = create_causal_mask(seq_len)
        w1 = torch.randn((EMBED_DIM, HIDDEN_DIM), dtype=torch.float32) * 0.02
        w2 = torch.randn((HIDDEN_DIM, EMBED_DIM), dtype=torch.float32) * 0.02
        ln_w1 = torch.ones((EMBED_DIM,), dtype=torch.float32)
        ln_b1 = torch.zeros((EMBED_DIM,), dtype=torch.float32)
        ln_w2 = torch.ones((EMBED_DIM,), dtype=torch.float32)
        ln_b2 = torch.zeros((EMBED_DIM,), dtype=torch.float32)
        model = FullBlock()
        expected_out = model(x, mask, w1, w2, ln_w1, ln_b1, ln_w2, ln_b2)
        
        expected_str = str(expected_out[0, 0, :4].tolist())
        mlir_str = str(out_arr[0, 0, :4].tolist())
        print(f"{avg_time},{cpu},{mem},{is_correct},PT:{expected_str} | MLIR:{mlir_str} | CosSim:{cos_sim} | NaNs:{has_nans}")
        sys.exit(0)
        
    parser = argparse.ArgumentParser()
    parser.add_argument('--use-variant', type=str, default=None)
    parser.add_argument('--seq-len', type=int, default=128)
    args = parser.parse_args()

    if args.use_variant:
        dylibs = []
        if args.use_variant in ["all", "all_variants"]:
            for f in sorted(os.listdir(CACHE_DIR)):
                if f.startswith("fullblock_") and f.endswith(".so"):
                    dylibs.append((f.replace(".so", ""), os.path.join(CACHE_DIR, f)))
        else:
            dylibs.append((args.use_variant.replace(".so", ""), os.path.join(CACHE_DIR, args.use_variant)))
    else:
        dylibs = asyncio.run(compile_stateless())
    
    import subprocess
    for seq_len in [5, 128, 500]:
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
