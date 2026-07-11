import torch
from ukernels.fused_mlp import run_fused_mlp

# 1. Register the Custom Op natively into PyTorch's C++ Dispatcher
@torch.library.custom_op("repo_os::mega_mlp", mutates_args=())
def mega_mlp(x: torch.Tensor, w1: torch.Tensor, w2: torch.Tensor) -> torch.Tensor:
    # Routes directly to our Triton UKernel
    return run_fused_mlp(x, w1, w2)

# Provide the Meta-Tensor definition so PyTorch Dynamo knows the output shape
@mega_mlp.register_fake
def _mega_mlp_fake(x, w1, w2):
    return torch.empty((x.shape[0], w2.shape[1]), device=x.device, dtype=x.dtype)
