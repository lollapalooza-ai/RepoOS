module {
  func.func @main(%arg0: memref<128xf32, strided<[?], offset: ?>>, %arg1: memref<128x128xf32, strided<[?, ?], offset: ?>>, %arg2: memref<f32, strided<[], offset: ?>>, %arg3: memref<128xf32, strided<[?], offset: ?>>) -> memref<128xf32> {
    %c1 = arith.constant 1 : index
    %c128 = arith.constant 128 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<128xf32>
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi slt, %0, %c128 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    memref.store %cst, %alloc[%0] : memref<128xf32>
    %2 = arith.addi %0, %c1 : index
    cf.br ^bb1(%2 : index)
  ^bb3:  // pred: ^bb1
    cf.br ^bb4(%c0 : index)
  ^bb4(%3: index):  // 2 preds: ^bb3, ^bb8
    %4 = arith.cmpi slt, %3, %c128 : index
    cf.cond_br %4, ^bb5, ^bb9
  ^bb5:  // pred: ^bb4
    cf.br ^bb6(%c0 : index)
  ^bb6(%5: index):  // 2 preds: ^bb5, ^bb7
    %6 = arith.cmpi slt, %5, %c128 : index
    cf.cond_br %6, ^bb7, ^bb8
  ^bb7:  // pred: ^bb6
    %7 = memref.load %arg1[%3, %5] : memref<128x128xf32, strided<[?, ?], offset: ?>>
    %8 = memref.load %arg0[%5] : memref<128xf32, strided<[?], offset: ?>>
    %9 = memref.load %alloc[%3] : memref<128xf32>
    %10 = arith.mulf %7, %8 : f32
    %11 = arith.addf %9, %10 : f32
    memref.store %11, %alloc[%3] : memref<128xf32>
    %12 = arith.addi %5, %c1 : index
    cf.br ^bb6(%12 : index)
  ^bb8:  // pred: ^bb6
    %13 = arith.addi %3, %c1 : index
    cf.br ^bb4(%13 : index)
  ^bb9:  // pred: ^bb4
    %alloc_1 = memref.alloc() {alignment = 64 : i64} : memref<128xf32>
    cf.br ^bb10(%c0 : index)
  ^bb10(%14: index):  // 2 preds: ^bb9, ^bb11
    %15 = arith.cmpi slt, %14, %c128 : index
    cf.cond_br %15, ^bb11, ^bb12
  ^bb11:  // pred: ^bb10
    %16 = memref.load %arg2[] : memref<f32, strided<[], offset: ?>>
    %17 = memref.load %alloc[%14] : memref<128xf32>
    %18 = arith.mulf %16, %17 : f32
    memref.store %18, %alloc_1[%14] : memref<128xf32>
    %19 = arith.addi %14, %c1 : index
    cf.br ^bb10(%19 : index)
  ^bb12:  // pred: ^bb10
    %alloc_2 = memref.alloc() {alignment = 64 : i64} : memref<f32>
    %20 = memref.load %arg2[] : memref<f32, strided<[], offset: ?>>
    %21 = arith.subf %cst_0, %20 : f32
    memref.store %21, %alloc_2[] : memref<f32>
    cf.br ^bb13(%c0 : index)
  ^bb13(%22: index):  // 2 preds: ^bb12, ^bb14
    %23 = arith.cmpi slt, %22, %c128 : index
    cf.cond_br %23, ^bb14, ^bb15
  ^bb14:  // pred: ^bb13
    %24 = memref.load %alloc_2[] : memref<f32>
    %25 = memref.load %arg3[%22] : memref<128xf32, strided<[?], offset: ?>>
    %26 = arith.mulf %24, %25 : f32
    memref.store %26, %alloc[%22] : memref<128xf32>
    %27 = arith.addi %22, %c1 : index
    cf.br ^bb13(%27 : index)
  ^bb15:  // pred: ^bb13
    cf.br ^bb16(%c0 : index)
  ^bb16(%28: index):  // 2 preds: ^bb15, ^bb17
    %29 = arith.cmpi slt, %28, %c128 : index
    cf.cond_br %29, ^bb17, ^bb18
  ^bb17:  // pred: ^bb16
    %30 = memref.load %alloc_1[%28] : memref<128xf32>
    %31 = memref.load %alloc[%28] : memref<128xf32>
    %32 = arith.addf %30, %31 : f32
    memref.store %32, %alloc[%28] : memref<128xf32>
    %33 = arith.addi %28, %c1 : index
    cf.br ^bb16(%33 : index)
  ^bb18:  // pred: ^bb16
    return %alloc : memref<128xf32>
  }
}

