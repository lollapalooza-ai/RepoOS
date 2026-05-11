module {
  func.func @networkx_utils_random_sequence_cumulative_distribution_chunk_0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: i64) {
    %c0_i64 = arith.constant 0 : i64
    %c1_i64 = arith.constant 1 : i64
    %cst = arith.constant 0.000000e+00 : f64
    llvm.store %cst, %arg2 : f64, !llvm.ptr
    %0 = llvm.load %arg1 : !llvm.ptr -> f64
    %cst_0 = arith.constant 1.010000e+02 : f64
    %1 = arith.divf %0, %cst_0 : f64
    %2 = llvm.getelementptr %arg2[%c1_i64] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %1, %2 : f64, !llvm.ptr
    return
  }
}
