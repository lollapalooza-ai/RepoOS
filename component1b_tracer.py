import torch
import torch_mlir
from torch_mlir.fx import export_and_import
from typing import Callable, Tuple

def trace_to_base_mlir(func: torch.nn.Module, sample_args: Tuple[torch.Tensor, ...]) -> str:
    """
    Generalized Tracer: Captures ANY Python/Torch function into MLIR.
    Now using the source-built torch-mlir library with the stable FX path.
    """
    # This is the exact entry point we verified successful on your Mac!
    module = export_and_import(
        func, 
        *sample_args, 
        output_type="linalg-on-tensors"
    )
    return str(module)
