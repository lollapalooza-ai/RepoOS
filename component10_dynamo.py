import torch
import torch_mlir
import os
import asyncio
import ctypes
import re
from typing import Callable
from component2_smt import generate_inference_transforms
from component9_aot import apply_ai_transform_and_compile
from component5_orchestrator import pack_tensor_to_memref

# --- GLOBAL CONFIGURATION ---
# Set to "NVIDIA H100" for GPU (requires real hardware)
# Set to "x86_64 Linux" for CPU (Bare-metal execution on this machine)
TARGET_DEVICE = "x86_64 Linux"

CACHE_DIR = os.getenv("REPOOS_CACHE_DIR", "./.poly_cache")
os.makedirs(CACHE_DIR, exist_ok=True)

def repoos_inference_backend(gm: torch.fx.GraphModule, example_inputs: list) -> Callable:
    """
    Dynamo Backend: Programmatic Lowering + AI Benchmarking Search.
    This entry point is strictly isolated to the INFERENCE track.
    """
    return asyncio.run(_repoos_inference_backend_async(gm, example_inputs))

def to_true_dps(mlir_text: str) -> str:
    """
    Surgically transforms a standard functional MLIR module into True DPS.
    1. Adds an output tensor as the LAST argument.
    2. Replaces the internal tensor.empty() with that argument.
    """
    # Find the main function signature
    match = re.search(r"func.func @main\((.*?)\)\s*->\s*(tensor<.*?>)", mlir_text)
    if not match: return mlir_text
    
    args = match.group(1)
    ret_type = match.group(2)
    
    # Determine the next argument index
    arg_count = len(re.findall(r"%arg\d+", args))
    out_arg = f"%arg{arg_count}"
    
    # Update signature: add out_arg
    new_args = args + f", {out_arg}: {ret_type}"
    mlir_text = mlir_text.replace(f"func.func @main({args})", f"func.func @main({new_args})")
    
    # Replace internal tensor.empty with the out_arg only if the type matches the return type
    # We use tensor.cast to bridge the argument to the existing SSA name
    # We account for possible dimension arguments in tensor.empty(...) for dynamic shapes
    ret_type_escaped = re.escape(ret_type)
    mlir_text = re.sub(
        r"(%[a-zA-Z0-9_]+) = tensor\.empty\([^)]*\)\s*:\s*" + ret_type_escaped, 
        fr"\1 = tensor.cast {out_arg} : {ret_type} to {ret_type}", 
        mlir_text
    )
    
    return mlir_text

from torch.export import Dim
from torch_mlir.extras.fx_importer import FxImporter

def capture_dynamic_mlir(gm: torch.fx.GraphModule, example_inputs: list) -> str:
    """
    Captures the MLIR graph with strictly symbolic dynamic dimensions.
    """
    from torch_mlir.fx import export_and_import
    from torch.export import Dim
    
    dynamic_shapes = []
    
    # Create a unique Dim for each unique size we see to satisfy PyTorch's constraint solver
    size_to_dim = {}
    dim_counter = 0
    
    # Map symbolic variables to the input tensors
    for i, arg in enumerate(example_inputs):
        if isinstance(arg, torch.Tensor):
            shape_dict = {}
            for d, size in enumerate(arg.shape):
                if size not in size_to_dim:
                    size_to_dim[size] = Dim(f"dim_{dim_counter}")
                    dim_counter += 1
                shape_dict[d] = size_to_dim[size]
            dynamic_shapes.append(shape_dict)
        else:
            dynamic_shapes.append(None)

    base_mlir_module = export_and_import(
        gm, *example_inputs,
        output_type="linalg-on-tensors",
        dynamic_shapes=tuple(dynamic_shapes)
    )
    return str(base_mlir_module)

async def _repoos_inference_backend_async(gm: torch.fx.GraphModule, example_inputs: list) -> Callable:
    print(f"\n[Dynamo] 🧠 Intercepted Graph. Target Device: {TARGET_DEVICE}")
    
    # 1. THE ALGORITHM (Dynamic Symbolic Shapes)
    base_mlir_module_str = capture_dynamic_mlir(gm, example_inputs)
    base_mlir_text = to_true_dps(base_mlir_module_str)
    
    kernel_id = abs(hash(base_mlir_text))
    base_dylib_path = os.path.join(CACHE_DIR, f"kernel_{kernel_id}_base.so")
    
    # 2. VERIFY BASE COMPILABILITY
    print("[Dynamo] 🛡️ Verifying base programmatic MLIR compilability...")
    is_gpu = (TARGET_DEVICE == "NVIDIA H100")
    
    await apply_ai_transform_and_compile(
        base_mlir_text, "", base_dylib_path, is_gpu=is_gpu
    )
    
    if not os.path.exists(base_dylib_path):
        raise RuntimeError("CRITICAL: Base programmatic MLIR failed deterministic lowering.")

    print(f"[Dynamo] 🤖 Base programmatic MLIR compiled successfully. Consulting Oracle for {TARGET_DEVICE} Optimization Schedules...")

    # 3. THE SCHEDULE (AI Heuristics)
    transform_scripts = await generate_inference_transforms(base_mlir_text, TARGET_DEVICE)
    
    # 4. BENCHMARKING SEARCH (EQUALITY SATURATION)
    from component9_aot import safe_execute_schedule, RepoOSSchedule
    import time
    
    compiled_dylibs = []
    
    # Try all AI-generated schedules
    for idx, transform_script in enumerate(transform_scripts):
        variant_dylib = os.path.join(CACHE_DIR, f"kernel_{kernel_id}_v{idx}.so")
        print(f"[Dynamo] Compiling AI Schedule Variant {idx+1}/{len(transform_scripts)}...")
        
        try:
            schedule = RepoOSSchedule()
            safe_execute_schedule(transform_script, schedule)
            transform_mlir = schedule.build_mlir()
        except Exception as e:
            print(f"[Dynamo] ⚠️ Sandbox rejected AI script: {e}")
            continue

        await apply_ai_transform_and_compile(
            base_mlir_text, transform_mlir, variant_dylib, is_gpu=is_gpu
        )
        
        if os.path.exists(variant_dylib):
            compiled_dylibs.append(variant_dylib)
            print(f"[Dynamo] ✅ Variant {idx+1} successfully compiled.")

    # Fallback if AI totally failed
    if not compiled_dylibs:
        print("[Dynamo] ⚠️ All AI schedules failed bufferization. Falling back to programmatic base.")
        compiled_dylibs.append(base_dylib_path)

    # 5. MICRO-BENCHMARK THE SURVIVORS
    print(f"[Dynamo] 🏁 Racing {len(compiled_dylibs)} compiled kernels to find the Speed of Light (SoL)...")
    
    best_dylib = compiled_dylibs[0]
    best_time = float('inf')
    best_kernel_func = None
    
    for dylib in compiled_dylibs:
        try:
            lib = ctypes.CDLL(dylib)
            k_func = lib._mlir_ciface_main if hasattr(lib, "_mlir_ciface_main") else lib.main
            k_func.restype = ctypes.c_void_p
            
            # Prepare args for the micro-benchmark
            kernel_args = []
            numpy_arrays = []
            structs = []
            for arg in example_inputs:
                if not isinstance(arg, torch.Tensor): continue
                arr = arg.detach().cpu().numpy()
                numpy_arrays.append(arr)
                memref = pack_tensor_to_memref(arg)
                structs.append(memref)
                kernel_args.append(ctypes.byref(memref))
            
            # THE FIX: Also pass the output buffer for the benchmark
            bench_res = torch.zeros_like(example_inputs[0])
            bench_arr = bench_res.detach().cpu().numpy()
            numpy_arrays.append(bench_arr)
            memref_out = pack_tensor_to_memref(bench_res)
            structs.append(memref_out)
            kernel_args.append(ctypes.byref(memref_out))
                
            # Warmup
            k_func(*kernel_args)
            
            # Benchmark (10 iterations)
            start_time = time.perf_counter()
            for _ in range(10):
                k_func(*kernel_args)
            avg_time = (time.perf_counter() - start_time) / 10.0
            
            print(f"      🏎️  {os.path.basename(dylib)}: {avg_time*1000:.4f} ms")
            
            if avg_time < best_time:
                best_time = avg_time
                best_dylib = dylib
                best_kernel_func = k_func
                
        except Exception as e:
            print(f"      ❌ Benchmark failed for {dylib}: {e}")

    print(f"[Dynamo] 🏆 Winner: {os.path.basename(best_dylib)} ({best_time*1000:.4f} ms)")
    kernel_func = best_kernel_func

    def optimized_forward(*args):
        is_prod = os.getenv("REPOOS_ENV") == "prod"
        
        # --- SAFE FALLBACK PATH (PROD ONLY) ---
        if not kernel_func:
            if is_prod:
                print("[Runtime] 🛡️ Using Safe Fallback: Executing via Torch FX Graph")
                res = gm(*args)
                return res if isinstance(res, (list, tuple)) else [res]
            else:
                raise RuntimeError("CRITICAL: FFI Binding failed and REPOOS_ENV != 'prod'. Check .so kernel and ctypes mapping.")

        # --- BARE-METAL HARDWARE PATH ---
        try:
            print(f"[Runtime] Invoking Bare-Metal Kernel: {best_dylib}")
            
            # THE FIX: Destination-Passing Style (DPS)
            # We pre-allocate the output buffer in Python and pass it to the kernel.
            # In our 'to_true_dps', we added it as the LAST argument.
            kernel_args = []
            numpy_arrays = []
            structs = []
            
            # 1. Prepare Inputs
            for arg in args:
                if not isinstance(arg, torch.Tensor): continue
                arr = arg.detach().cpu().numpy()
                numpy_arrays.append(arr)
                memref = pack_tensor_to_memref(arg)
                structs.append(memref)
                kernel_args.append(ctypes.byref(memref))
            
            # 2. Allocate and Prepare Output Tensor
            # (Assuming the output shape matches the first input for this demo)
            res_torch = torch.zeros_like(args[0])
            res_arr = res_torch.detach().cpu().numpy()
            numpy_arrays.append(res_arr)
            memref_res = pack_tensor_to_memref(res_torch)
            structs.append(memref_res)
            kernel_args.append(ctypes.byref(memref_res))

            # 3. Execute machine code
            kernel_func(*kernel_args)

            # 4. Sync result back to PyTorch
            res = torch.from_numpy(res_arr)
            return [res]

        except Exception as e:
            if is_prod:
                print(f"[Runtime] ⚠️ Bare-Metal Execution Failed: {e}. Falling back to Torch.")
                res = gm(*args)
                return res if isinstance(res, (list, tuple)) else [res]
            else:
                print(f"[Runtime] ❌ Bare-Metal Execution Failed: {e}")
                raise e
        
    return optimized_forward
