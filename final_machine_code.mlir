module {
  llvm.func @main(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.insertvalue %3, %2[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.mlir.constant(1024 : index) : i64
    %6 = llvm.insertvalue %5, %4[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %7 = llvm.mlir.constant(1024 : index) : i64
    %8 = llvm.insertvalue %7, %6[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %9 = llvm.mlir.constant(1024 : index) : i64
    %10 = llvm.insertvalue %9, %8[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.mlir.constant(1 : index) : i64
    %12 = llvm.insertvalue %11, %10[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %14 = llvm.insertvalue %arg0, %13[0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %arg0, %14[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.mlir.constant(0 : index) : i64
    %17 = llvm.insertvalue %16, %15[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %18 = llvm.mlir.constant(1024 : index) : i64
    %19 = llvm.insertvalue %18, %17[3, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %20 = llvm.mlir.constant(1024 : index) : i64
    %21 = llvm.insertvalue %20, %19[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %22 = llvm.mlir.constant(1024 : index) : i64
    %23 = llvm.insertvalue %22, %21[3, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %24 = llvm.mlir.constant(1 : index) : i64
    %25 = llvm.insertvalue %24, %23[4, 1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %26 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %27 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %28 = llvm.mlir.constant(0 : index) : i64
    %29 = llvm.mlir.constant(1024 : index) : i64
    %30 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%28 : i64)
  ^bb1(%31: i64):  // 2 preds: ^bb0, ^bb5
    %32 = llvm.icmp "slt" %31, %29 : i64
    llvm.cond_br %32, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%28 : i64)
  ^bb3(%33: i64):  // 2 preds: ^bb2, ^bb4
    %34 = llvm.icmp "slt" %33, %29 : i64
    llvm.cond_br %34, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %35 = llvm.extractvalue %25[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %36 = llvm.mlir.constant(1024 : index) : i64
    %37 = llvm.mul %31, %36 overflow<nsw, nuw> : i64
    %38 = llvm.add %37, %33 overflow<nsw, nuw> : i64
    %39 = llvm.getelementptr inbounds|nuw %35[%38] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %40 = llvm.load %39 : !llvm.ptr -> f32
    %41 = llvm.fadd %40, %27 : f32
    %42 = llvm.extractvalue %12[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %43 = llvm.mlir.constant(1024 : index) : i64
    %44 = llvm.mul %31, %43 overflow<nsw, nuw> : i64
    %45 = llvm.add %44, %33 overflow<nsw, nuw> : i64
    %46 = llvm.getelementptr inbounds|nuw %42[%45] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %41, %46 : f32, !llvm.ptr
    %47 = llvm.add %33, %30 : i64
    llvm.br ^bb3(%47 : i64)
  ^bb5:  // pred: ^bb3
    %48 = llvm.add %31, %30 : i64
    llvm.br ^bb1(%48 : i64)
  ^bb6:  // pred: ^bb1
    llvm.br ^bb7(%28 : i64)
  ^bb7(%49: i64):  // 2 preds: ^bb6, ^bb11
    %50 = llvm.icmp "slt" %49, %29 : i64
    llvm.cond_br %50, ^bb8, ^bb12
  ^bb8:  // pred: ^bb7
    llvm.br ^bb9(%28 : i64)
  ^bb9(%51: i64):  // 2 preds: ^bb8, ^bb10
    %52 = llvm.icmp "slt" %51, %29 : i64
    llvm.cond_br %52, ^bb10, ^bb11
  ^bb10:  // pred: ^bb9
    %53 = llvm.extractvalue %12[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %54 = llvm.mlir.constant(1024 : index) : i64
    %55 = llvm.mul %49, %54 overflow<nsw, nuw> : i64
    %56 = llvm.add %55, %51 overflow<nsw, nuw> : i64
    %57 = llvm.getelementptr inbounds|nuw %53[%56] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %58 = llvm.load %57 : !llvm.ptr -> f32
    %59 = llvm.fcmp "ugt" %58, %26 : f32
    %60 = llvm.select %59, %58, %26 : i1, f32
    %61 = llvm.extractvalue %12[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %62 = llvm.mlir.constant(1024 : index) : i64
    %63 = llvm.mul %49, %62 overflow<nsw, nuw> : i64
    %64 = llvm.add %63, %51 overflow<nsw, nuw> : i64
    %65 = llvm.getelementptr inbounds|nuw %61[%64] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %60, %65 : f32, !llvm.ptr
    %66 = llvm.add %51, %30 : i64
    llvm.br ^bb9(%66 : i64)
  ^bb11:  // pred: ^bb9
    %67 = llvm.add %49, %30 : i64
    llvm.br ^bb7(%67 : i64)
  ^bb12:  // pred: ^bb7
    llvm.return
  }
}

