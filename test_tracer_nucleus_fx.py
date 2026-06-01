import torch
import torch_mlir
from torch_mlir.fx import export_and_import
import sys
import os

class SimpleAdd(torch.nn.Module):
    def forward(self, a, b):
        return a + b

def run_nucleus_test():
    print("\n--- 🔍 Tracer Nucleus Test (FX) ---")
    
    a = torch.randn(4)
    b = torch.randn(4)
    
    try:
        # Use the FX-based export_and_import
        base_mlir = export_and_import(SimpleAdd(), a, b, output_type="linalg-on-tensors")
        print("✅ SUCCESS: FX Tracing Works.")
        print("BASE MLIR SNIPPET:")
        print(str(base_mlir)[:200] + "...")
    except Exception as e:
        print(f"❌ FAIL: FX tracing failed: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    run_nucleus_test()
