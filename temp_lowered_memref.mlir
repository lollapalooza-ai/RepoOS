#map = affine_map<(d0) -> (d0 * 32)>
#map1 = affine_map<(d0) -> (d0 * 2)>
#map2 = affine_map<(d0) -> (d0 * 4)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: memref<4096x4096xf32>, %arg1: memref<4096x4096xf32>, %arg2: memref<4096x4096xf32>) {
    %cst = arith.constant dense<2.000000e+00> : vector<2x4xf32>
    %0 = ub.poison : f32
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<4096x4096xf32>
    linalg.copy ins(%arg2 : memref<4096x4096xf32>) outs(%alloc : memref<4096x4096xf32>)
    scf.forall (%arg3, %arg4) in (128, 128) {
      %1 = affine.apply #map(%arg3)
      %2 = affine.apply #map(%arg4)
      %subview = memref.subview %arg0[%1, %2] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      %subview_0 = memref.subview %arg1[%1, %2] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      %subview_1 = memref.subview %alloc[%1, %2] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      scf.forall (%arg5, %arg6) in (16, 8) {
        %3 = affine.apply #map1(%arg5)
        %4 = affine.apply #map2(%arg6)
        %subview_3 = memref.subview %subview[%3, %4] [2, 4] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<2x4xf32, strided<[4096, 1], offset: ?>>
        %subview_4 = memref.subview %subview_0[%3, %4] [2, 4] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<2x4xf32, strided<[4096, 1], offset: ?>>
        %subview_5 = memref.subview %subview_1[%3, %4] [2, 4] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<2x4xf32, strided<[4096, 1], offset: ?>>
        %5 = vector.transfer_read %subview_3[%c0, %c0], %0 {in_bounds = [true, true]} : memref<2x4xf32, strided<[4096, 1], offset: ?>>, vector<2x4xf32>
        %6 = vector.transfer_read %subview_4[%c0, %c0], %0 {in_bounds = [true, true]} : memref<2x4xf32, strided<[4096, 1], offset: ?>>, vector<2x4xf32>
        %7 = arith.mulf %5, %6 : vector<2x4xf32>
        vector.transfer_write %7, %subview_5[%c0, %c0] {in_bounds = [true, true]} : vector<2x4xf32>, memref<2x4xf32, strided<[4096, 1], offset: ?>>
        %subview_6 = memref.subview %subview_1[%3, %4] [2, 4] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<2x4xf32, strided<[4096, 1], offset: ?>>
        linalg.copy ins(%subview_5 : memref<2x4xf32, strided<[4096, 1], offset: ?>>) outs(%subview_6 : memref<2x4xf32, strided<[4096, 1], offset: ?>>)
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      %subview_2 = memref.subview %alloc[%1, %2] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      linalg.copy ins(%subview_1 : memref<32x32xf32, strided<[4096, 1], offset: ?>>) outs(%subview_2 : memref<32x32xf32, strided<[4096, 1], offset: ?>>)
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    scf.forall (%arg3, %arg4) in (128, 128) {
      %1 = affine.apply #map(%arg3)
      %2 = affine.apply #map(%arg4)
      %subview = memref.subview %alloc[%1, %2] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      %subview_0 = memref.subview %arg2[%1, %2] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      scf.forall (%arg5, %arg6) in (16, 8) {
        %3 = affine.apply #map1(%arg5)
        %4 = affine.apply #map2(%arg6)
        %subview_2 = memref.subview %subview[%3, %4] [2, 4] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<2x4xf32, strided<[4096, 1], offset: ?>>
        %subview_3 = memref.subview %subview_0[%3, %4] [2, 4] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<2x4xf32, strided<[4096, 1], offset: ?>>
        %5 = vector.transfer_read %subview_2[%c0, %c0], %0 {in_bounds = [true, true]} : memref<2x4xf32, strided<[4096, 1], offset: ?>>, vector<2x4xf32>
        %6 = arith.addf %5, %cst : vector<2x4xf32>
        vector.transfer_write %6, %subview_3[%c0, %c0] {in_bounds = [true, true]} : vector<2x4xf32>, memref<2x4xf32, strided<[4096, 1], offset: ?>>
        %subview_4 = memref.subview %subview_0[%3, %4] [2, 4] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<2x4xf32, strided<[4096, 1], offset: ?>>
        linalg.copy ins(%subview_3 : memref<2x4xf32, strided<[4096, 1], offset: ?>>) outs(%subview_4 : memref<2x4xf32, strided<[4096, 1], offset: ?>>)
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      %subview_1 = memref.subview %arg2[%1, %2] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      linalg.copy ins(%subview_0 : memref<32x32xf32, strided<[4096, 1], offset: ?>>) outs(%subview_1 : memref<32x32xf32, strided<[4096, 1], offset: ?>>)
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    return
  }
}
