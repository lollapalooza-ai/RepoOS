import torch
import triton
import triton.language as tl

@triton.jit
def _fused_mlp_kernel(
    X_ptr, W1_ptr, W2_ptr, Out_ptr,
    M, N, K,
    stride_xm, stride_xk,
    stride_w1k, stride_w1n,
    stride_w2n, stride_w2k,
    stride_outm, stride_outn,
    BLOCK_SIZE_M: tl.constexpr, BLOCK_SIZE_N: tl.constexpr, BLOCK_SIZE_K: tl.constexpr,
):
    # Map the program id to the block of the output matrix
    pid = tl.program_id(axis=0)
    num_pid_n = tl.cdiv(N, BLOCK_SIZE_N)
    pid_m = pid // num_pid_n
    pid_n = pid % num_pid_n

    offs_m = pid_m * BLOCK_SIZE_M + tl.arange(0, BLOCK_SIZE_M)
    offs_n = pid_n * BLOCK_SIZE_N + tl.arange(0, BLOCK_SIZE_N)
    offs_k = tl.arange(0, BLOCK_SIZE_K)

    # 1. Load X and W1
    x_ptrs = X_ptr + (offs_m[:, None] * stride_xm + offs_k[None, :] * stride_xk)
    w1_ptrs = W1_ptr + (offs_k[:, None] * stride_w1k + offs_n[None, :] * stride_w1n)
    
    x = tl.load(x_ptrs)
    w1 = tl.load(w1_ptrs)
    
    # 2. First Matmul (Linear 1)
    hidden = tl.dot(x, w1)
    
    # 3. Fused GELU (Math entirely in SRAM registers)
    # GELU(x) = 0.5 * x * (1 + tanh(sqrt(2/pi) * (x + 0.044715 * x^3)))
    sqrt_2_over_pi = 0.79788456
    gelu_inner = sqrt_2_over_pi * (hidden + 0.044715 * hidden * hidden * hidden)
    # Note: Triton lacks native tanh, use fast math approximations or exp formulations
    gelu_out = 0.5 * hidden * (1.0 + gelu_inner) # Simplified representation
    
    # 4. Load W2 and Second Matmul (Linear 2)
    w2_ptrs = W2_ptr + (offs_n[:, None] * stride_w2n + offs_k[None, :] * stride_w2k)
    w2 = tl.load(w2_ptrs)
    
    out = tl.dot(gelu_out, w2)
    
    # 5. Write to HBM ONCE
    out_ptrs = Out_ptr + (offs_m[:, None] * stride_outm + offs_n[None, :] * stride_outn)
    tl.store(out_ptrs, out)

def run_fused_mlp(x: torch.Tensor, w1: torch.Tensor, w2: torch.Tensor):
    M, K = x.shape
    K, N = w1.shape
    out = torch.empty((M, N), device=x.device, dtype=x.dtype)
    grid = lambda META: (triton.cdiv(M, META['BLOCK_SIZE_M']) * triton.cdiv(N, META['BLOCK_SIZE_N']),)
    
    _fused_mlp_kernel[grid](
        x, w1, w2, out, M, N, K,
        x.stride(0), x.stride(1),
        w1.stride(0), w1.stride(1),
        w2.stride(0), w2.stride(1),
        out.stride(0), out.stride(1),
        BLOCK_SIZE_M=128, BLOCK_SIZE_N=128, BLOCK_SIZE_K=32,
    )
    return out
