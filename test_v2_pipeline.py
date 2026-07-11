import sys
import os

# Ensure src is in PYTHONPATH so we can import from ukernels, dispatcher, etc.
sys.path.append(os.path.join(os.path.dirname(__file__), "src"))
sys.path.append(os.path.join(os.path.dirname(__file__), "src", "egraph", "target", "release"))
sys.path.append(os.path.join(os.path.dirname(__file__), "src", "egraph"))

import torch
import torch._dynamo

# Import our custom backend and ops
from orchestrator.dynamo_backend import egraph_inference_backend
import dispatcher.custom_ops

class DummyModel(torch.nn.Module):
    def forward(self, x, w1, w2):
        # A simple graph that might trigger the equality saturation logic
        # Our mock e-graph logic rewrites it if it finds "add" and "matmul"
        return torch.add(torch.matmul(x, w1), w2)

def test_pipeline():
    print("🚀 Initializing Repo OS V2 End-to-End Test...")
    model = DummyModel().cuda() if torch.cuda.is_available() else DummyModel()
    
    # Wrap model with our E-Graph Orchestrator
    compiled_model = torch.compile(model, backend=egraph_inference_backend)
    
    # 128x128 matrices to match the Triton block sizes (M=128, N=128, K=128)
    device = 'cuda' if torch.cuda.is_available() else 'cpu'
    x = torch.randn(128, 128, device=device)
    w1 = torch.randn(128, 128, device=device)
    w2 = torch.randn(128, 128, device=device)
    b = torch.randn(128, device=device)
    
    print("\n▶️ Running Compiled Model...")
    # This should trigger the dynamo backend intercept and the Rust optimizer
    out = compiled_model(x, w1, w2)
    print("\n✅ V2 Orchestrator Execution Complete!")
    print("Output shape:", out.shape)

if __name__ == "__main__":
    test_pipeline()
