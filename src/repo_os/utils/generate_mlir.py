import sys
import os
import torch
import importlib.util
from torch_mlir.fx import export_and_import

def generate_mlir_programmatically(file_path, func_name):
    """
    Programmatically lowers a Python function to MLIR using the FX path.
    """
    print(f"--- 🔍 Programmatic Lowering: {func_name} from {file_path} ---")
    
    # 1. Dynamically load the module and function
    spec = importlib.util.spec_from_file_location("target_mod", file_path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    func = getattr(module, func_name)
    
    # 2. Create sample inputs for the FX tracer
    # For inference_hotspot, we expect a 10x10 tensor
    # If the function signature allows, we use standard dimensions
    x = torch.randn(10, 10)
    
    # 3. Lower to MLIR (Linalg-on-Tensors)
    # We wrap the function in a simple nn.Module for the FX importer if needed,
    # but export_and_import often handles functions directly.
    try:
        # Note: export_and_import expects a module or function and its arguments
        mlir_module = export_and_import(
            func, x, 
            output_type="linalg-on-tensors"
        )
        return str(mlir_module)
    except Exception as e:
        print(f"❌ Programmatic lowering failed: {e}")
        return None

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python3 generate_mlir.py <file_path> <func_name>")
        sys.exit(1)
        
    source_file = sys.argv[1]
    function_name = sys.argv[2]
    
    output_mlir = generate_mlir_programmatically(source_file, function_name)
    
    if output_mlir:
        out_file = f"generated/{function_name}_compiled.txt"
        with open(out_file, "w") as f:
            f.write(output_mlir)
        print(f"✅ SUCCESS: MLIR written to {out_file}")
    else:
        sys.exit(1)
