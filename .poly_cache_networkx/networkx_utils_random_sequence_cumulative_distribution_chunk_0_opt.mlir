module {
  llvm.func @networkx_utils_random_sequence_cumulative_distribution_chunk_0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: i64) {
    %0 = llvm.mlir.constant(0 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    llvm.br ^bb1(%0, %2 : i64, f64)
  ^bb1(%3: i64, %4: f64):  // 2 preds: ^bb0, ^bb2
    %5 = llvm.icmp "slt" %3, %arg3 : i64
    llvm.cond_br %5, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %6 = llvm.getelementptr %arg1[%3] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %7 = llvm.load %6 : !llvm.ptr -> f64
    %8 = llvm.fadd %4, %7 : f64
    %9 = llvm.add %3, %1 : i64
    llvm.br ^bb1(%9, %8 : i64, f64)
  ^bb3:  // pred: ^bb1
    llvm.store %2, %arg2 : f64, !llvm.ptr
    llvm.br ^bb4(%0, %2 : i64, f64)
  ^bb4(%10: i64, %11: f64):  // 2 preds: ^bb3, ^bb5
    %12 = llvm.icmp "slt" %10, %arg3 : i64
    llvm.cond_br %12, ^bb5, ^bb6
  ^bb5:  // pred: ^bb4
    %13 = llvm.getelementptr %arg1[%10] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %14 = llvm.load %13 : !llvm.ptr -> f64
    %15 = llvm.fadd %11, %14 : f64
    %16 = llvm.fdiv %15, %4 : f64
    %17 = llvm.add %10, %1 : i64
    %18 = llvm.getelementptr %arg2[%17] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %16, %18 : f64, !llvm.ptr
    %19 = llvm.add %10, %1 : i64
    llvm.br ^bb4(%19, %15 : i64, f64)
  ^bb6:  // pred: ^bb4
    llvm.return
  }
}

