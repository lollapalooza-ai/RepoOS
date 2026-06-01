module {
  func.func @main(%arg0: memref<128xf32, strided<[?], offset: ?>>, %arg1: memref<128x128xf32, strided<[?, ?], offset: ?>>, %arg2: memref<f32, strided<[], offset: ?>>, %arg3: memref<128xf32, strided<[?], offset: ?>>) -> memref<128xf32> {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(128 : index) : i64
    %2 = llvm.mlir.constant(0 : index) : i64
    %3 = builtin.unrealized_conversion_cast %2 : i64 to index
    %4 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %5 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<128xf32>
    cf.br ^bb1(%3 : index)
  ^bb1(%6: index):  // 2 preds: ^bb0, ^bb2
    %7 = builtin.unrealized_conversion_cast %6 : index to i64
    %8 = llvm.icmp "slt" %7, %1 : i64
    cf.cond_br %8, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    memref.store %4, %alloc[%6] : memref<128xf32>
    %9 = llvm.add %7, %0 : i64
    %10 = builtin.unrealized_conversion_cast %9 : i64 to index
    cf.br ^bb1(%10 : index)
  ^bb3:  // pred: ^bb1
    cf.br ^bb4(%3 : index)
  ^bb4(%11: index):  // 2 preds: ^bb3, ^bb8
    %12 = builtin.unrealized_conversion_cast %11 : index to i64
    %13 = llvm.icmp "slt" %12, %1 : i64
    cf.cond_br %13, ^bb5, ^bb9
  ^bb5:  // pred: ^bb4
    cf.br ^bb6(%3 : index)
  ^bb6(%14: index):  // 2 preds: ^bb5, ^bb7
    %15 = builtin.unrealized_conversion_cast %14 : index to i64
    %16 = llvm.icmp "slt" %15, %1 : i64
    cf.cond_br %16, ^bb7, ^bb8
  ^bb7:  // pred: ^bb6
    %17 = memref.load %arg1[%11, %14] : memref<128x128xf32, strided<[?, ?], offset: ?>>
    %18 = memref.load %arg0[%14] : memref<128xf32, strided<[?], offset: ?>>
    %19 = memref.load %alloc[%11] : memref<128xf32>
    %20 = llvm.fmul %17, %18 : f32
    %21 = llvm.fadd %19, %20 : f32
    memref.store %21, %alloc[%11] : memref<128xf32>
    %22 = llvm.add %15, %0 : i64
    %23 = builtin.unrealized_conversion_cast %22 : i64 to index
    cf.br ^bb6(%23 : index)
  ^bb8:  // pred: ^bb6
    %24 = llvm.add %12, %0 : i64
    %25 = builtin.unrealized_conversion_cast %24 : i64 to index
    cf.br ^bb4(%25 : index)
  ^bb9:  // pred: ^bb4
    %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<128xf32>
    cf.br ^bb10(%3 : index)
  ^bb10(%26: index):  // 2 preds: ^bb9, ^bb11
    %27 = builtin.unrealized_conversion_cast %26 : index to i64
    %28 = llvm.icmp "slt" %27, %1 : i64
    cf.cond_br %28, ^bb11, ^bb12
  ^bb11:  // pred: ^bb10
    %29 = memref.load %arg2[] : memref<f32, strided<[], offset: ?>>
    %30 = memref.load %alloc[%26] : memref<128xf32>
    %31 = llvm.fmul %29, %30 : f32
    memref.store %31, %alloc_0[%26] : memref<128xf32>
    %32 = llvm.add %27, %0 : i64
    %33 = builtin.unrealized_conversion_cast %32 : i64 to index
    cf.br ^bb10(%33 : index)
  ^bb12:  // pred: ^bb10
    %alloc_1 = memref.alloc() {alignment = 64 : i64} : memref<f32>
    %34 = memref.load %arg2[] : memref<f32, strided<[], offset: ?>>
    %35 = llvm.fsub %5, %34 : f32
    memref.store %35, %alloc_1[] : memref<f32>
    cf.br ^bb13(%3 : index)
  ^bb13(%36: index):  // 2 preds: ^bb12, ^bb14
    %37 = builtin.unrealized_conversion_cast %36 : index to i64
    %38 = llvm.icmp "slt" %37, %1 : i64
    cf.cond_br %38, ^bb14, ^bb15
  ^bb14:  // pred: ^bb13
    %39 = memref.load %alloc_1[] : memref<f32>
    %40 = memref.load %arg3[%36] : memref<128xf32, strided<[?], offset: ?>>
    %41 = llvm.fmul %39, %40 : f32
    memref.store %41, %alloc[%36] : memref<128xf32>
    %42 = llvm.add %37, %0 : i64
    %43 = builtin.unrealized_conversion_cast %42 : i64 to index
    cf.br ^bb13(%43 : index)
  ^bb15:  // pred: ^bb13
    cf.br ^bb16(%3 : index)
  ^bb16(%44: index):  // 2 preds: ^bb15, ^bb17
    %45 = builtin.unrealized_conversion_cast %44 : index to i64
    %46 = llvm.icmp "slt" %45, %1 : i64
    cf.cond_br %46, ^bb17, ^bb18
  ^bb17:  // pred: ^bb16
    %47 = memref.load %alloc_0[%44] : memref<128xf32>
    %48 = memref.load %alloc[%44] : memref<128xf32>
    %49 = llvm.fadd %47, %48 : f32
    memref.store %49, %alloc[%44] : memref<128xf32>
    %50 = llvm.add %45, %0 : i64
    %51 = builtin.unrealized_conversion_cast %50 : i64 to index
    cf.br ^bb16(%51 : index)
  ^bb18:  // pred: ^bb16
    return %alloc : memref<128xf32>
  }
}

