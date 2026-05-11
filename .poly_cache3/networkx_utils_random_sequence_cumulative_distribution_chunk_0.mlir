module {
  func.func @networkx_utils_random_sequence_cumulative_distribution_chunk_0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: index) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f64
    %0 = scf.for %arg4 = %c0 to %arg3 step %c1 iter_args(%arg5 = %cst) -> (f64) {
      %2 = arith.index_cast %arg4 : index to i64
      %3 = llvm.getelementptr %arg1[%2] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %4 = llvm.load %3 : !llvm.ptr -> f64
      %5 = arith.addf %arg5, %4 : f64
      scf.yield %5 : f64
    }
    llvm.store %cst, %arg2 : f64, !llvm.ptr
    %1 = scf.for %arg4 = %c0 to %arg3 step %c1 iter_args(%arg5 = %cst) -> (f64) {
      %2 = arith.index_cast %arg4 : index to i64
      %3 = llvm.getelementptr %arg1[%2] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %4 = llvm.load %3 : !llvm.ptr -> f64
      %5 = arith.addf %arg5, %4 : f64
      %6 = arith.divf %5, %0 : f64
      %7 = arith.addi %arg4, %c1 : index
      %8 = arith.index_cast %7 : index to i64
      %9 = llvm.getelementptr %arg2[%8] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      llvm.store %6, %9 : f64, !llvm.ptr
      scf.yield %5 : f64
    }
    return
  }
}
