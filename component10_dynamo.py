import torch
import torch.nn.functional as F

class RepoOSBucketRouter(torch.nn.Module):
    """
    Phase 1: The Pre-Pad Shield.
    Isolates the compiler from PyTorch's dynamic shape tracing (SymInts).
    """
    def __init__(self, core_attention_stack, buckets=[128, 256, 512, 1024]):
        super().__init__()
        self.buckets = sorted(buckets)
        
        # CRITICAL: dynamic=False forces Dynamo to trace a pristine, static graph.
        from component9_aot import egraph_inference_backend
        self.fused_stack = torch.compile(
            core_attention_stack, 
            backend=egraph_inference_backend, 
            dynamic=False
        )

    def _get_bucket(self, seq_len: int) -> int:
        for b in self.buckets:
            if seq_len <= b: return b
        return self.buckets[-1]

    def forward(self, x):
        # x shape is usually (Batch, Seq_Len, Embed_Dim)
        seq_len = x.shape[1]
        target_len = self._get_bucket(seq_len)
        
        pad_amount = target_len - seq_len
        if pad_amount > 0:
            # Pad the sequence dimension (dim 1)
            x_pad = F.pad(x, (0, 0, 0, pad_amount), "constant", 0.0)
        else:
            x_pad = x

        # Hit the AOT cache (or trigger compilation on first run)
        out_pad = self.fused_stack(x_pad)

        # Slice off padding
        if pad_amount > 0:
            return out_pad[:, :seq_len, :]
        return out_pad
