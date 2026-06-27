import torch
import torch_mlir
from torch_mlir.fx import export_and_import

def check_signature():
    class SimpleModule(torch.nn.Module):
        def __init__(self):
            super().__init__()
            self.linear = torch.nn.Linear(10, 10)
            self.register_buffer("my_buf", torch.ones(10))
        def forward(self, x):
            return self.linear(x) + self.my_buf

    def my_backend(gm, example_inputs):
        from torch.export import Dim
        dynamic_shapes = []
        # The original function has 1 input: x.
        # But example_inputs has 4 elements!
        # Which one is x? In this case, x is example_inputs[2]
        x_tensor = example_inputs[2]
        x_shape = {d: Dim(f"dim_{d}") for d in range(x_tensor.dim())}
        # Pass a tuple of length 1 for dynamic_shapes!
        dynamic_shapes = (x_shape,)
        
        # But wait! If we pass dynamic_shapes as length 1, how do we tell it which argument it applies to?
        # PyTorch export expects dynamic_shapes to match the *original* args.
        try:
            mlir_module = export_and_import(gm, *example_inputs, output_type="linalg-on-tensors", dynamic_shapes=dynamic_shapes)
            print("IT WORKED WITH 1 ELEMENT!")
        except Exception as e:
            print("FAILED WITH 1 ELEMENT:", e)
        
        def optimized_forward(*args):
            return gm(*args)
        return optimized_forward

    mod = SimpleModule()
    mod = torch.compile(mod, backend=my_backend)
    x = torch.randn(2, 10)
    mod(x)

if __name__ == "__main__":
    check_signature()
