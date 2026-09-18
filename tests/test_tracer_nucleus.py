import torch
import sys
import os

class SimpleAdd(torch.nn.Module):
    def forward(self, a, b):
        return a + b

def run_nucleus_test():
    from component1b_tracer import trace_to_base_mlir
    print("\n--- 🔍 Tracer Nucleus Test (Dynamo) ---")
    
    a = torch.randn(4)
    b = torch.randn(4)
    
    try:
        base_mlir = trace_to_base_mlir(SimpleAdd(), (a, b))
        print("✅ SUCCESS: Dynamo Tracing Works.")
        print("BASE MLIR SNIPPET:")
        print(str(base_mlir)[:200] + "...")
    except Exception as e:
        print(f"❌ FAIL: Dynamo tracing failed: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    run_nucleus_test()
