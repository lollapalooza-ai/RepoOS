module {
  llvm.func @pagerank_alg__pagerank_python_chunk_0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr, %arg4: !llvm.ptr, %arg5: !llvm.ptr, %arg6: i64, %arg7: f64) {
    %0 = llvm.mlir.constant(0 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %3 = llvm.fsub %2, %arg7 : f64
    llvm.br ^bb1(%0 : i64)
  ^bb1(%4: i64):  // 2 preds: ^bb0, ^bb2
    %5 = llvm.icmp "slt" %4, %arg6 : i64
    llvm.cond_br %5, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %6 = llvm.getelementptr %arg5[%4] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %7 = llvm.load %6 : !llvm.ptr -> f64
    %8 = llvm.fmul %3, %7 : f64
    %9 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %8, %9 : f64, !llvm.ptr
    %10 = llvm.add %4, %1 : i64
    llvm.br ^bb1(%10 : i64)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%0 : i64)
  ^bb4(%11: i64):  // 2 preds: ^bb3, ^bb8
    %12 = llvm.icmp "slt" %11, %arg6 : i64
    llvm.cond_br %12, ^bb5, ^bb9
  ^bb5:  // pred: ^bb4
    %13 = llvm.getelementptr %arg4[%11] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %14 = llvm.load %13 : !llvm.ptr -> f64
    %15 = llvm.fmul %arg7, %14 : f64
    %16 = llvm.getelementptr %arg1[%11] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %17 = llvm.load %16 : !llvm.ptr -> i64
    %18 = llvm.add %11, %1 : i64
    %19 = llvm.getelementptr %arg1[%18] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %20 = llvm.load %19 : !llvm.ptr -> i64
    llvm.br ^bb6(%17 : i64)
  ^bb6(%21: i64):  // 2 preds: ^bb5, ^bb7
    %22 = llvm.icmp "slt" %21, %20 : i64
    llvm.cond_br %22, ^bb7, ^bb8
  ^bb7:  // pred: ^bb6
    %23 = llvm.getelementptr %arg2[%21] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %24 = llvm.load %23 : !llvm.ptr -> i64
    %25 = llvm.getelementptr %arg3[%21] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %26 = llvm.load %25 : !llvm.ptr -> f64
    %27 = llvm.fmul %15, %26 : f64
    %28 = llvm.getelementptr %arg0[%24] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %29 = llvm.load %28 : !llvm.ptr -> f64
    %30 = llvm.fadd %29, %27 : f64
    llvm.store %30, %28 : f64, !llvm.ptr
    %31 = llvm.add %21, %1 : i64
    llvm.br ^bb6(%31 : i64)
  ^bb8:  // pred: ^bb6
    %32 = llvm.add %11, %1 : i64
    llvm.br ^bb4(%32 : i64)
  ^bb9:  // pred: ^bb4
    llvm.return
  }
}

