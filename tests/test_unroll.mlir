#map = affine_map<(d0) -> (d0 * 32)>
#map1 = affine_map<(d0) -> (d0 * 4)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: memref<4096x4096xf32>, %arg1: memref<4096x4096xf32>, %arg2: memref<4096x4096xf32>) {
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %0 = ub.poison : vector<4x4xf32>
    %cst = arith.constant dense<2.000000e+00> : vector<4x4xf32>
    %1 = ub.poison : f32
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<4096x4096xf32>
    linalg.copy ins(%arg2 : memref<4096x4096xf32>) outs(%alloc : memref<4096x4096xf32>)
    scf.forall (%arg3, %arg4) in (128, 128) {
      %2 = affine.apply #map(%arg3)
      %3 = affine.apply #map(%arg4)
      %subview = memref.subview %arg0[%2, %3] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      %subview_0 = memref.subview %arg1[%2, %3] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      %subview_1 = memref.subview %alloc[%2, %3] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      scf.forall (%arg5, %arg6) in (8, 8) {
        %4 = affine.apply #map1(%arg5)
        %5 = affine.apply #map1(%arg6)
        %subview_3 = memref.subview %subview[%4, %5] [4, 4] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %subview_4 = memref.subview %subview_0[%4, %5] [4, 4] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %subview_5 = memref.subview %subview_1[%4, %5] [4, 4] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %6 = vector.transfer_read %subview_3[%c0, %c0], %1 {in_bounds = [true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4xf32>
        %7 = vector.insert %6, %0 [0] : vector<4xf32> into vector<4x4xf32>
        %8 = vector.transfer_read %subview_3[%c1, %c0], %1 {in_bounds = [true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4xf32>
        %9 = vector.insert %8, %7 [1] : vector<4xf32> into vector<4x4xf32>
        %10 = vector.transfer_read %subview_3[%c2, %c0], %1 {in_bounds = [true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4xf32>
        %11 = vector.insert %10, %9 [2] : vector<4xf32> into vector<4x4xf32>
        %12 = vector.transfer_read %subview_3[%c3, %c0], %1 {in_bounds = [true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4xf32>
        %13 = vector.insert %12, %11 [3] : vector<4xf32> into vector<4x4xf32>
        %14 = vector.transfer_read %subview_4[%c0, %c0], %1 {in_bounds = [true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4xf32>
        %15 = vector.insert %14, %0 [0] : vector<4xf32> into vector<4x4xf32>
        %16 = vector.transfer_read %subview_4[%c1, %c0], %1 {in_bounds = [true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4xf32>
        %17 = vector.insert %16, %15 [1] : vector<4xf32> into vector<4x4xf32>
        %18 = vector.transfer_read %subview_4[%c2, %c0], %1 {in_bounds = [true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4xf32>
        %19 = vector.insert %18, %17 [2] : vector<4xf32> into vector<4x4xf32>
        %20 = vector.transfer_read %subview_4[%c3, %c0], %1 {in_bounds = [true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4xf32>
        %21 = vector.insert %20, %19 [3] : vector<4xf32> into vector<4x4xf32>
        %22 = arith.mulf %13, %21 : vector<4x4xf32>
        %23 = vector.extract %22[0] : vector<4xf32> from vector<4x4xf32>
        vector.transfer_write %23, %subview_5[%c0, %c0] {in_bounds = [true]} : vector<4xf32>, memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %24 = vector.extract %22[1] : vector<4xf32> from vector<4x4xf32>
        vector.transfer_write %24, %subview_5[%c1, %c0] {in_bounds = [true]} : vector<4xf32>, memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %25 = vector.extract %22[2] : vector<4xf32> from vector<4x4xf32>
        vector.transfer_write %25, %subview_5[%c2, %c0] {in_bounds = [true]} : vector<4xf32>, memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %26 = vector.extract %22[3] : vector<4xf32> from vector<4x4xf32>
        vector.transfer_write %26, %subview_5[%c3, %c0] {in_bounds = [true]} : vector<4xf32>, memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %subview_6 = memref.subview %subview_1[%4, %5] [4, 4] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        linalg.copy ins(%subview_5 : memref<4x4xf32, strided<[4096, 1], offset: ?>>) outs(%subview_6 : memref<4x4xf32, strided<[4096, 1], offset: ?>>)
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      %subview_2 = memref.subview %alloc[%2, %3] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      linalg.copy ins(%subview_1 : memref<32x32xf32, strided<[4096, 1], offset: ?>>) outs(%subview_2 : memref<32x32xf32, strided<[4096, 1], offset: ?>>)
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    scf.forall (%arg3, %arg4) in (128, 128) {
      %2 = affine.apply #map(%arg3)
      %3 = affine.apply #map(%arg4)
      %subview = memref.subview %alloc[%2, %3] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      %subview_0 = memref.subview %arg2[%2, %3] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      scf.forall (%arg5, %arg6) in (8, 8) {
        %4 = affine.apply #map1(%arg5)
        %5 = affine.apply #map1(%arg6)
        %subview_2 = memref.subview %subview[%4, %5] [4, 4] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %subview_3 = memref.subview %subview_0[%4, %5] [4, 4] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %6 = vector.transfer_read %subview_2[%c0, %c0], %1 {in_bounds = [true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4xf32>
        %7 = vector.insert %6, %0 [0] : vector<4xf32> into vector<4x4xf32>
        %8 = vector.transfer_read %subview_2[%c1, %c0], %1 {in_bounds = [true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4xf32>
        %9 = vector.insert %8, %7 [1] : vector<4xf32> into vector<4x4xf32>
        %10 = vector.transfer_read %subview_2[%c2, %c0], %1 {in_bounds = [true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4xf32>
        %11 = vector.insert %10, %9 [2] : vector<4xf32> into vector<4x4xf32>
        %12 = vector.transfer_read %subview_2[%c3, %c0], %1 {in_bounds = [true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4xf32>
        %13 = vector.insert %12, %11 [3] : vector<4xf32> into vector<4x4xf32>
        %14 = arith.addf %13, %cst : vector<4x4xf32>
        %15 = vector.extract %14[0] : vector<4xf32> from vector<4x4xf32>
        vector.transfer_write %15, %subview_3[%c0, %c0] {in_bounds = [true]} : vector<4xf32>, memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %16 = vector.extract %14[1] : vector<4xf32> from vector<4x4xf32>
        vector.transfer_write %16, %subview_3[%c1, %c0] {in_bounds = [true]} : vector<4xf32>, memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %17 = vector.extract %14[2] : vector<4xf32> from vector<4x4xf32>
        vector.transfer_write %17, %subview_3[%c2, %c0] {in_bounds = [true]} : vector<4xf32>, memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %18 = vector.extract %14[3] : vector<4xf32> from vector<4x4xf32>
        vector.transfer_write %18, %subview_3[%c3, %c0] {in_bounds = [true]} : vector<4xf32>, memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %subview_4 = memref.subview %subview_0[%4, %5] [4, 4] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        linalg.copy ins(%subview_3 : memref<4x4xf32, strided<[4096, 1], offset: ?>>) outs(%subview_4 : memref<4x4xf32, strided<[4096, 1], offset: ?>>)
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      %subview_1 = memref.subview %arg2[%2, %3] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      linalg.copy ins(%subview_0 : memref<32x32xf32, strided<[4096, 1], offset: ?>>) outs(%subview_1 : memref<32x32xf32, strided<[4096, 1], offset: ?>>)
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    return
  }
}

