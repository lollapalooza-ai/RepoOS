import mlir.ir as ir
from mlir.dialects import llvm
import inspect

with ir.Context() as ctx, ir.Location.unknown():
    # Use the context to get the pointer type correctly for this environment
    ptr = llvm.PointerType.get(context=ctx)
    print(f"GEPOp Signature: {inspect.signature(llvm.GEPOp.__init__)}")
