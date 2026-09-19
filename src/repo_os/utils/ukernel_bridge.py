import ctypes
import torch
import os

# Load the compiled Mega-UKernel
dylib_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "native", "mega_ukernel.so")
ukernel_lib = ctypes.CDLL(dylib_path)

# Define the C-function signature
# void fused_attention_ukernel(float* Q, float* K, float* V, float* Out, int batch, int seq, int head)
ukernel_lib.fused_attention_ukernel.argtypes = [
    ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p,
    ctypes.c_int, ctypes.c_int, ctypes.c_int
]

def run_mega_ukernel(q: torch.Tensor, k: torch.Tensor, v: torch.Tensor):
    batch_size, seq_len, head_dim = q.shape
    
    # 1. DPS Allocation (No MLIR alloca scopes!)
    out = torch.empty_like(q)
    
    # 2. Get raw memory pointers
    q_ptr = q.data_ptr()
    k_ptr = k.data_ptr()
    v_ptr = v.data_ptr()
    out_ptr = out.data_ptr()
    
    # 3. Fire the OpenMP C++ Kernel
    ukernel_lib.fused_attention_ukernel(
        q_ptr, k_ptr, v_ptr, out_ptr, 
        batch_size, seq_len, head_dim
    )
    
    return out
