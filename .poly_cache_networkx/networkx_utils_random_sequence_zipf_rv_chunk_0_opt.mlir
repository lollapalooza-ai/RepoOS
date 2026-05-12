module {
  llvm.func @networkx_utils_random_sequence_zipf_rv_chunk_0(%arg0: !llvm.ptr, %arg1: f64) {
    %0 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.fsub %arg1, %1 : f64
    %3 = llvm.intr.pow(%0, %2) : (f64, f64) -> f64
    llvm.store %3, %arg0 : f64, !llvm.ptr
    llvm.return
  }
}

