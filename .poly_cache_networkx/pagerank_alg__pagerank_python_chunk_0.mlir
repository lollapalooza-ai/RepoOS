module {
  func.func @pagerank_alg__pagerank_python_chunk_0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr, %arg4: !llvm.ptr, %arg5: !llvm.ptr, %arg6: i64, %arg7: f64) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f64
    %cst_0 = arith.constant 1.000000e+00 : f64
    %0 = arith.index_cast %arg6 : i64 to index
    %1 = arith.subf %cst_0, %arg7 : f64
    scf.for %arg8 = %c0 to %0 step %c1 {
      %2 = arith.index_cast %arg8 : index to i64
      %3 = llvm.getelementptr %arg5[%2] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %4 = llvm.load %3 : !llvm.ptr -> f64
      %5 = arith.mulf %1, %4 : f64
      %6 = arith.index_cast %arg8 : index to i64
      %7 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      llvm.store %5, %7 : f64, !llvm.ptr
    }
    scf.for %arg8 = %c0 to %0 step %c1 {
      %2 = arith.index_cast %arg8 : index to i64
      %3 = llvm.getelementptr %arg4[%2] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %4 = llvm.load %3 : !llvm.ptr -> f64
      %5 = arith.mulf %arg7, %4 : f64
      %6 = arith.index_cast %arg8 : index to i64
      %7 = llvm.getelementptr %arg1[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %8 = llvm.load %7 : !llvm.ptr -> i64
      %9 = arith.index_cast %8 : i64 to index
      %10 = arith.addi %arg8, %c1 : index
      %11 = arith.index_cast %10 : index to i64
      %12 = llvm.getelementptr %arg1[%11] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %13 = llvm.load %12 : !llvm.ptr -> i64
      %14 = arith.index_cast %13 : i64 to index
      scf.for %arg9 = %9 to %14 step %c1 {
        %15 = arith.index_cast %arg9 : index to i64
        %16 = llvm.getelementptr %arg2[%15] : (!llvm.ptr, i64) -> !llvm.ptr, f64
        %17 = llvm.load %16 : !llvm.ptr -> i64
        %18 = arith.index_cast %arg9 : index to i64
        %19 = llvm.getelementptr %arg3[%18] : (!llvm.ptr, i64) -> !llvm.ptr, f64
        %20 = llvm.load %19 : !llvm.ptr -> f64
        %21 = arith.mulf %5, %20 : f64
        %22 = llvm.getelementptr %arg0[%17] : (!llvm.ptr, i64) -> !llvm.ptr, f64
        %23 = llvm.load %22 : !llvm.ptr -> f64
        %24 = arith.addf %23, %21 : f64
        llvm.store %24, %22 : f64, !llvm.ptr
      }
    }
    return
  }
}
