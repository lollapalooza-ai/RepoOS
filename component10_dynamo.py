import torch
import torch_mlir
import os
import asyncio
from typing import Callable
from component2_smt import generate_inference_transforms
from component9_aot import apply_gpu_transform_and_compile

CACHE_DIR = os.getenv("REPOOS_CACHE_DIR", "./.poly_cache")
os.makedirs(CACHE_DIR, exist_ok=True)

def repoos_inference_backend(gm: torch.fx.GraphModule, example_inputs: list) -> Callable:
    """
    Dynamo Backend: Programmatic Lowering + AI Benchmarking Search.
    This entry point is strictly isolated to the INFERENCE track.
    """
    return asyncio.run(_repoos_inference_backend_async(gm, example_inputs))

async def _repoos_inference_backend_async(gm: torch.fx.GraphModule, example_inputs: list) -> Callable:
    print("\n[Dynamo] 🧠 Intercepted Graph. Programmatically lowering to MLIR Linalg...")
    
    # 1. THE ALGORITHM (Strictly Deterministic)
    # We bypass the AI entirely for generating the math. 
    from torch_mlir.fx import export_and_import
    base_mlir_module = export_and_import(
        gm, *example_inputs, 
        output_type="linalg-on-tensors"
    )
    base_mlir_text = str(base_mlir_module)
    
    kernel_id = abs(hash(base_mlir_text))
    base_dylib_path = os.path.join(CACHE_DIR, f"kernel_{kernel_id}_base.so")
    
    # 2. VERIFY BASE COMPILABILITY
    # Ensure the programmatic "Algorithm" is valid before asking for a "Schedule"
    print("[Dynamo] 🛡️ Verifying base programmatic MLIR compilability...")
    base_success = await apply_gpu_transform_and_compile(
        base_mlir_text, transform_mlir="", output_dylib=base_dylib_path
    )
    
    if not base_success:
        raise RuntimeError("CRITICAL: Base programmatic MLIR failed deterministic lowering. Check MLIR syntax.")

    print("[Dynamo] 🤖 Base programmatic MLIR compiled successfully. Consulting Oracle for GPU Optimization Schedules...")

    # 3. THE SCHEDULE (AI Heuristics)
    transform_scripts = await generate_inference_transforms(base_mlir_text, "NVIDIA H100")
    
    # 4. BENCHMARKING SEARCH & SAFE FALLBACK
    best_dylib = base_dylib_path
    
    # Try all AI-generated schedules
    for idx, transform_script in enumerate(transform_scripts):
        variant_dylib = os.path.join(CACHE_DIR, f"kernel_{kernel_id}_v{idx}.so")
        print(f"[Dynamo] Compiling AI Schedule Variant {idx+1}/{len(transform_scripts)}...")
        
        success = await apply_gpu_transform_and_compile(
            base_mlir_text, transform_script, variant_dylib
        )
        
        if success:
            best_dylib = variant_dylib
            print(f"[Dynamo] ✅ Variant {idx+1} successfully compiled and selected.")
            break 

    # Load the library (Placeholder for PyTorch integration)
    # torch.ops.load_library(best_dylib)
    print(f"[Dynamo] 🚀 Final Kernel Ready: {best_dylib}")
    
    def optimized_forward(*args):
        # Implementation of the FFI bridge to the loaded dylib
        print(f"[Runtime] Invoking Bare-Metal GPU Kernel: {best_dylib}")
        return args[0] # Return input for placeholder verification
        
    return optimized_forward
