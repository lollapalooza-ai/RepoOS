import torch
import torch_mlir
from torch_mlir.fx import export_and_import
class FastModel(torch.nn.Module):
    def forward(self, a, b):
        return torch.matmul(a, b)
model = FastModel()
a = torch.ones((512, 512), dtype=torch.float32)
b = torch.ones((512, 512), dtype=torch.float32)
gm = torch.fx.symbolic_trace(model)
base_mlir_module = export_and_import(gm, a, b, output_type="linalg-on-tensors")
print(str(base_mlir_module))
