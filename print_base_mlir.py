import torch
import torch_mlir
from component10_dynamo import to_true_dps
class FastModel(torch.nn.Module):
    def forward(self, a, b):
        return (a * b) + 2.0

model = FastModel()
a = torch.ones((4096, 4096), dtype=torch.float32)
b = torch.ones((4096, 4096), dtype=torch.float32)

from torch_mlir.fx import export_and_import
gm = torch.fx.symbolic_trace(model)
base_mlir_module = export_and_import(gm, a, b, output_type="linalg-on-tensors")
print("--- ORIGINAL ---")
print(str(base_mlir_module))
print("--- TRUE DPS ---")
print(to_true_dps(str(base_mlir_module)))
