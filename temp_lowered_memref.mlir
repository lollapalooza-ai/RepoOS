module {
  func.func @main(%arg0: memref<3x3xf32>, %arg1: memref<3xf32>, %arg2: memref<3xf32>, %arg3: memref<3xf32>) {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mlir.constant(3 : index) : i64
    %4 = llvm.mlir.constant(0 : index) : i64
    %5 = builtin.unrealized_conversion_cast %4 : i64 to index
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<3xf32>
    cf.br ^bb1(%5 : index)
  ^bb1(%6: index):  // 2 preds: ^bb0, ^bb2
    %7 = builtin.unrealized_conversion_cast %6 : index to i64
    %8 = llvm.icmp "slt" %7, %3 : i64
    cf.cond_br %8, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    memref.store %1, %alloc[%6] : memref<3xf32>
    %9 = llvm.add %7, %2 : i64
    %10 = builtin.unrealized_conversion_cast %9 : i64 to index
    cf.br ^bb1(%10 : index)
  ^bb3:  // pred: ^bb1
    cf.br ^bb4(%5 : index)
  ^bb4(%11: index):  // 2 preds: ^bb3, ^bb8
    %12 = builtin.unrealized_conversion_cast %11 : index to i64
    %13 = llvm.icmp "slt" %12, %3 : i64
    cf.cond_br %13, ^bb5, ^bb9
  ^bb5:  // pred: ^bb4
    cf.br ^bb6(%5 : index)
  ^bb6(%14: index):  // 2 preds: ^bb5, ^bb7
    %15 = builtin.unrealized_conversion_cast %14 : index to i64
    %16 = llvm.icmp "slt" %15, %3 : i64
    cf.cond_br %16, ^bb7, ^bb8
  ^bb7:  // pred: ^bb6
    %17 = memref.load %arg0[%11, %14] : memref<3x3xf32>
    %18 = memref.load %alloc[%11] : memref<3xf32>
    %19 = llvm.fadd %17, %18 : f32
    memref.store %19, %alloc[%11] : memref<3xf32>
    %20 = llvm.add %15, %2 : i64
    %21 = builtin.unrealized_conversion_cast %20 : i64 to index
    cf.br ^bb6(%21 : index)
  ^bb8:  // pred: ^bb6
    %22 = llvm.add %12, %2 : i64
    %23 = builtin.unrealized_conversion_cast %22 : i64 to index
    cf.br ^bb4(%23 : index)
  ^bb9:  // pred: ^bb4
    cf.br ^bb10(%5 : index)
  ^bb10(%24: index):  // 2 preds: ^bb9, ^bb11
    %25 = builtin.unrealized_conversion_cast %24 : index to i64
    %26 = llvm.icmp "slt" %25, %3 : i64
    cf.cond_br %26, ^bb11, ^bb12
  ^bb11:  // pred: ^bb10
    %27 = memref.load %alloc[%24] : memref<3xf32>
    %28 = llvm.fcmp "one" %27, %1 : f32
    cf.assert %28, "unimplemented: tensor with zero element"
    %29 = llvm.fdiv %0, %27 : f32
    memref.store %29, %alloc[%24] : memref<3xf32>
    %30 = llvm.add %25, %2 : i64
    %31 = builtin.unrealized_conversion_cast %30 : i64 to index
    cf.br ^bb10(%31 : index)
  ^bb12:  // pred: ^bb10
    return
  }
}

