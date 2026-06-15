import torch

class FastModel(torch.nn.Module):
    def forward(self, a, b):
        return (a * b) + 2.0

def main():
    print("[User Script] Initializing Model...")
    model = FastModel()
    
    # Enable the RepoOS Inference Backend
    # The 'repoos_inference_backend' is registered via the CLI wrapper
    model = torch.compile(model, backend='repoos_inference_backend')
    
    a = torch.ones(10, 10)
    b = torch.ones(10, 10)
    
    print("[User Script] Running first inference (this triggers compilation)...")
    result = model(a, b)
    
    print(f"[User Script] Result captured. Shape: {result.shape}")
    print(f"[User Script] Result Snippet: {result[0, 0]}")

if __name__ == "__main__":
    main()
