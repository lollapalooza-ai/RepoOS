module {
  func.func @networkx_algorithms_link_analysis_pagerank_alg__pagerank_python_chunk_0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr, %arg4: !llvm.ptr, %arg5: !llvm.ptr, %arg6: i64, %arg7: f64, %arg8: i64) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f64
    %cst_0 = arith.constant 1.000000e+00 : f64
    %0 = arith.index_cast %arg6 : i64 to index
    %1 = arith.index_cast %arg8 : i64 to index
    %2 = arith.subf %cst_0, %arg7 : f64
    scf.for %arg9 = %c0 to %1 step %c1 {
      scf.for %arg10 = %c0 to %0 step %c1 {
        %3 = arith.index_cast %arg10 : index to i64
        %4 = llvm.getelementptr %arg5[%3] : (!llvm.ptr, i64) -> !llvm.ptr, f64
        %5 = llvm.load %4 : !llvm.ptr -> f64
        %6 = arith.mulf %2, %5 : f64
        %7 = arith.index_cast %arg10 : index to i64
        %8 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, f64
        llvm.store %6, %8 : f64, !llvm.ptr
      }
      scf.for %arg10 = %c0 to %0 step %c1 {
        %3 = arith.index_cast %arg10 : index to i64
        %4 = llvm.getelementptr %arg4[%3] : (!llvm.ptr, i64) -> !llvm.ptr, f64
        %5 = llvm.load %4 : !llvm.ptr -> f64
        %6 = arith.mulf %arg7, %5 : f64
        %7 = arith.index_cast %arg10 : index to i64
        %8 = llvm.getelementptr %arg1[%7] : (!llvm.ptr, i64) -> !llvm.ptr, f64
        %9 = llvm.load %8 : !llvm.ptr -> i64
        %10 = arith.index_cast %9 : i64 to index
        %11 = arith.addi %arg10, %c1 : index
        %12 = arith.index_cast %11 : index to i64
        %13 = llvm.getelementptr %arg1[%12] : (!llvm.ptr, i64) -> !llvm.ptr, f64
        %14 = llvm.load %13 : !llvm.ptr -> i64
        %15 = arith.index_cast %14 : i64 to index
        scf.for %arg11 = %10 to %15 step %c1 {
          %16 = arith.index_cast %arg11 : index to i64
          %17 = llvm.getelementptr %arg2[%16] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %18 = llvm.load %17 : !llvm.ptr -> i64
          %19 = arith.index_cast %arg11 : index to i64
          %20 = llvm.getelementptr %arg3[%19] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %21 = llvm.load %20 : !llvm.ptr -> f64
          %22 = arith.mulf %6, %21 : f64
          %23 = llvm.getelementptr %arg0[%18] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %24 = llvm.load %23 : !llvm.ptr -> f64
          %25 = arith.addf %24, %22 : f64
          llvm.store %25, %23 : f64, !llvm.ptr
        }
      }
      scf.for %arg10 = %c0 to %0 step %c1 {
        %3 = arith.index_cast %arg10 : index to i64
        %4 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, f64
        %5 = llvm.load %4 : !llvm.ptr -> f64
        %6 = arith.index_cast %arg10 : index to i64
        %7 = llvm.getelementptr %arg4[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f64
        llvm.store %5, %7 : f64, !llvm.ptr
      }
    }
    return
  }
}
