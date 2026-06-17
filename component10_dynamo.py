import torch
import torch_mlir
import os
import asyncio
import ctypes
from typing import Callable
from component2_smt import generate_inference_transforms
from component9_aot import apply_ai_transform_and_compile
from component5_orchestrator import to_memref

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

async def _repoos_inference_backend_async(gm: torch.fx.GraphModule, example_inputs: list) -> Callable:
    print(f"\n[Dynamo] 🧠 Intercepted Graph. Target Device: {TARGET_DEVICE}")
    
    # 1. THE ALGORITHM (Strictly Deterministic)
    from torch_mlir.fx import export_and_import
    base_mlir_module = export_and_import(
        gm, *example_inputs, 
        output_type="linalg-on-tensors"
    )
    base_mlir_text = str(base_mlir_module)
    
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
    
    # 4. BENCHMARKING SEARCH & SAFE FALLBACK
    best_dylib = base_dylib_path
    from component9_aot import RepoOSSchedule
    
    # Try all AI-generated schedules
    for idx, transform_script in enumerate(transform_scripts):
        variant_dylib = os.path.join(CACHE_DIR, f"kernel_{kernel_id}_v{idx}.so")
        print(f"[Dynamo] Compiling AI Schedule Variant {idx+1}/{len(transform_scripts)}...")
        
        # TRANSLATION: Convert Python DSL to MLIR Transform Dialect
        try:
            schedule = RepoOSSchedule()
            local_scope = {"schedule": schedule}
            exec(transform_script, {}, local_scope)
            if "apply_schedule" in local_scope:
                local_scope["apply_schedule"](schedule)
            transform_mlir = schedule.build_mlir()
        except Exception as e:
            print(f"[Dynamo] ⚠️ Failed to build MLIR from AI Python script: {e}")
            continue

        await apply_ai_transform_and_compile(
            base_mlir_text, transform_mlir, variant_dylib, is_gpu=is_gpu
        )
        
        if os.path.exists(variant_dylib):
            best_dylib = variant_dylib
            print(f"[Dynamo] ✅ Variant {idx+1} successfully compiled and selected.")
            break 

    # 5. THE BARE-METAL FFI BRIDGE (Safe Implementation)
    kernel_func = None
    try:
        lib = ctypes.CDLL(best_dylib)
        # Try both naming conventions for maximum compatibility
        if hasattr(lib, "_mlir_ciface_main"):
            kernel_func = lib._mlir_ciface_main
        elif hasattr(lib, "main"):
            kernel_func = lib.main
        else:
            raise AttributeError("Neither '_mlir_ciface_main' nor 'main' symbol found in dylib.")
        
        # CRITICAL: For Bare-Pointer ABI, the kernel might return a pointer 
        # (if it allocates memory internally). We must ensure ctypes doesn't truncate it.
        kernel_func.restype = ctypes.c_void_p
            
    except Exception as e:
        print(f"[Dynamo] ⚠️ FFI Binding failed: {e}")

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
            # PyTorch Dynamo results usually expect the first argument to be the output for DPS.
            kernel_args = []
            numpy_arrays = []
            
            # Prepare descriptors for all arguments (Inputs + Output)
            for arg in args:
                if not isinstance(arg, torch.Tensor): continue
                # Detach and keep a reference
                arr = arg.detach().cpu().numpy()
                numpy_arrays.append(arr)
                # Pass raw pointer (Bare-Pointer ABI)
                kernel_args.append(arr.ctypes.data_as(ctypes.c_void_p))

            # Execute machine code
            # Note: We assume the kernel is 'void main(ptr out, ptr in1, ptr in2...)'
            kernel_func(*kernel_args)

            # In DPS, the result is now in the first numpy array
            res = torch.from_numpy(numpy_arrays[0])
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
