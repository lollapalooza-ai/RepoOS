module {
  llvm.func @networkx_utils_random_sequence_cumulative_distribution_chunk_0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: i64) {
    %0 = llvm.mlir.constant(1.010000e+02 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    llvm.store %1, %arg2 : f64, !llvm.ptr
    %2 = llvm.load %arg1 : !llvm.ptr -> f64
    %3 = llvm.fdiv %2, %0 : f64
    %4 = llvm.getelementptr %arg2[1] : (!llvm.ptr) -> !llvm.ptr, f64
    llvm.store %3, %4 : f64, !llvm.ptr
    llvm.return
  }
}

