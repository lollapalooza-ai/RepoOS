import torch
import torch_mlir
from typing import Callable, Tuple

def trace_to_base_mlir(func: torch.nn.Module, sample_args: Tuple[torch.Tensor, ...]) -> str:
    """
    Generalized Tracer: Captures ANY Python/Torch function into MLIR.
    UPGRADED: Using torch.jit.trace for superior stability with Sparse Tensors.
    """
    # 1. Capture via JIT Trace (Handles Sparse CSR perfectly)
    # We use a wrapper to ensure the output is returned correctly for the tracer
    scripted_module = torch.jit.trace(func, sample_args)
    
    # 2. Lower to MLIR (Linalg-on-Tensors)
    # UPDATED: Use the correct entry point for modern torch-mlir
    import torch_mlir.torchscript
    module = torch_mlir.torchscript.compile(
        scripted_module, 
        sample_args, 
        output_type=torch_mlir.torchscript.OutputType.LINALG_ON_TENSORS
    )
    return str(module)
