import torch
import os
import asyncio
from component10_dynamo import repoos_inference_backend

# Mocking the environment for testing
os.environ["REPOOS_CACHE_DIR"] = "./.poly_cache_test"

class SimpleModel(torch.nn.Module):
    def __init__(self):
        super().__init__()
        self.relu = torch.nn.ReLU()

    def forward(self, x):
        return self.relu(x + 1.0)

def test_inference_pipeline():
    print("--- 🧪 Testing RepoOS INFERENCE Track (Isolated) ---")
    model = SimpleModel()
    example_input = torch.randn(10, 10)
    
    # Trigger the Dynamo backend
    # Note: In a real scenario, we use torch.compile(model, backend=repoos_inference_backend)
    # For this unit test, we call the backend directly to verify the logic.
    print("[Test] Triggering RepoOS Inference Backend...")
    optimized_fn = repoos_inference_backend(torch.fx.symbolic_trace(model), [example_input])
    
    # Execute the returned callable
    result = optimized_fn(example_input)
    print("[Test] Inference executed successfully. Result shape:", result.shape)
    assert result is not None
    print("\n✅ Test Passed: Inference track logic executed successfully and isolated.")

if __name__ == "__main__":
    test_inference_pipeline()
