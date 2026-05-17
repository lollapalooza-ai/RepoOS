module {
  llvm.func @networkx_algorithms_link_analysis_pagerank_alg__pagerank_python_chunk_0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr, %arg4: !llvm.ptr, %arg5: !llvm.ptr, %arg6: i64, %arg7: f64, %arg8: i64) {
    %0 = llvm.mlir.constant(0 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %3 = llvm.fsub %2, %arg7 : f64
    llvm.br ^bb1(%0 : i64)
  ^bb1(%4: i64):  // 2 preds: ^bb0, ^bb14
    %5 = llvm.icmp "slt" %4, %arg8 : i64
    llvm.cond_br %5, ^bb2, ^bb15
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%0 : i64)
  ^bb3(%6: i64):  // 2 preds: ^bb2, ^bb4
    %7 = llvm.icmp "slt" %6, %arg6 : i64
    llvm.cond_br %7, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %8 = llvm.getelementptr %arg5[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %9 = llvm.load %8 : !llvm.ptr -> f64
    %10 = llvm.fmul %3, %9 : f64
    %11 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %10, %11 : f64, !llvm.ptr
    %12 = llvm.add %6, %1 : i64
    llvm.br ^bb3(%12 : i64)
  ^bb5:  // pred: ^bb3
    llvm.br ^bb6(%0 : i64)
  ^bb6(%13: i64):  // 2 preds: ^bb5, ^bb10
    %14 = llvm.icmp "slt" %13, %arg6 : i64
    llvm.cond_br %14, ^bb7, ^bb11
  ^bb7:  // pred: ^bb6
    %15 = llvm.getelementptr %arg4[%13] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %16 = llvm.load %15 : !llvm.ptr -> f64
    %17 = llvm.fmul %arg7, %16 : f64
    %18 = llvm.getelementptr %arg1[%13] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %19 = llvm.load %18 : !llvm.ptr -> i64
    %20 = llvm.add %13, %1 : i64
    %21 = llvm.getelementptr %arg1[%20] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %22 = llvm.load %21 : !llvm.ptr -> i64
    llvm.br ^bb8(%19 : i64)
  ^bb8(%23: i64):  // 2 preds: ^bb7, ^bb9
    %24 = llvm.icmp "slt" %23, %22 : i64
    llvm.cond_br %24, ^bb9, ^bb10
  ^bb9:  // pred: ^bb8
    %25 = llvm.getelementptr %arg2[%23] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %26 = llvm.load %25 : !llvm.ptr -> i64
    %27 = llvm.getelementptr %arg3[%23] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %28 = llvm.load %27 : !llvm.ptr -> f64
    %29 = llvm.fmul %17, %28 : f64
    %30 = llvm.getelementptr %arg0[%26] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %31 = llvm.load %30 : !llvm.ptr -> f64
    %32 = llvm.fadd %31, %29 : f64
    llvm.store %32, %30 : f64, !llvm.ptr
    %33 = llvm.add %23, %1 : i64
    llvm.br ^bb8(%33 : i64)
  ^bb10:  // pred: ^bb8
    %34 = llvm.add %13, %1 : i64
    llvm.br ^bb6(%34 : i64)
  ^bb11:  // pred: ^bb6
    llvm.br ^bb12(%0 : i64)
  ^bb12(%35: i64):  // 2 preds: ^bb11, ^bb13
    %36 = llvm.icmp "slt" %35, %arg6 : i64
    llvm.cond_br %36, ^bb13, ^bb14
  ^bb13:  // pred: ^bb12
    %37 = llvm.getelementptr %arg0[%35] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %38 = llvm.load %37 : !llvm.ptr -> f64
    %39 = llvm.getelementptr %arg4[%35] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %38, %39 : f64, !llvm.ptr
    %40 = llvm.add %35, %1 : i64
    llvm.br ^bb12(%40 : i64)
  ^bb14:  // pred: ^bb12
    %41 = llvm.add %4, %1 : i64
    llvm.br ^bb1(%41 : i64)
  ^bb15:  // pred: ^bb1
    llvm.return
  }
}

