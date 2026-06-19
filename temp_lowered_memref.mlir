#map = affine_map<(d0) -> (d0 * 8)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map4 = affine_map<(d0, d1) -> (d0, d1)>
#map5 = affine_map<(d0, d1) -> ()>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: memref<2048x2048xf32>, %arg1: memref<2048x1xf32>, %arg2: memref<2048x1xf32>, %arg3: memref<2048x1xf32>, %arg4: memref<1xf32>, %arg5: memref<1xf32>, %arg6: memref<2048x1xf32>) {
    %0 = ub.poison : f32
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %cst_0 = arith.constant dense<0.000000e+00> : vector<2048x1xf32>
    vector.transfer_write %cst_0, %arg6[%c0, %c0] {in_bounds = [true, true]} : vector<2048x1xf32>, memref<2048x1xf32>
    scf.forall (%arg7, %arg8, %arg9) in (256, 1, 256) {
      %18 = affine.apply #map(%arg7)
      %subview = memref.subview %arg6[%18, %arg8] [8, 1] [1, 1] : memref<2048x1xf32> to memref<8x1xf32, strided<[1, 1], offset: ?>>
      %19 = affine.apply #map(%arg7)
      %20 = affine.apply #map(%arg9)
      %21 = vector.transfer_read %arg0[%19, %20], %0 {in_bounds = [true, true]} : memref<2048x2048xf32>, vector<8x8xf32>
      %22 = affine.apply #map(%arg9)
      %23 = vector.transfer_read %arg1[%22, %arg8], %0 {in_bounds = [true, true]} : memref<2048x1xf32>, vector<8x1xf32>
      %24 = affine.apply #map(%arg7)
      %25 = vector.transfer_read %arg6[%24, %arg8], %0 {in_bounds = [true, true]} : memref<2048x1xf32>, vector<8x1xf32>
      %26 = vector.contract {indexing_maps = [#map1, #map2, #map3], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %21, %23, %25 : vector<8x8xf32>, vector<8x1xf32> into vector<8x1xf32>
      vector.transfer_write %26, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<8x1xf32>, memref<8x1xf32, strided<[1, 1], offset: ?>>
      %subview_1 = memref.subview %arg6[%18, %arg8] [8, 1] [1, 1] : memref<2048x1xf32> to memref<8x1xf32, strided<[1, 1], offset: ?>>
      linalg.copy ins(%subview : memref<8x1xf32, strided<[1, 1], offset: ?>>) outs(%subview_1 : memref<8x1xf32, strided<[1, 1], offset: ?>>)
    }
    %1 = vector.transfer_read %arg1[%c0, %c0], %0 {in_bounds = [true, true]} : memref<2048x1xf32>, vector<2048x1xf32>
    %2 = vector.transfer_read %arg3[%c0, %c0], %0 {in_bounds = [true, true]} : memref<2048x1xf32>, vector<2048x1xf32>
    %3 = vector.contract {indexing_maps = [#map4, #map4, #map5], iterator_types = ["reduction", "reduction"], kind = #vector.kind<add>} %1, %2, %cst : vector<2048x1xf32>, vector<2048x1xf32> into f32
    %4 = vector.broadcast %3 : f32 to vector<f32>
    %5 = vector.transfer_read %arg4[%c0], %0 {in_bounds = [true]} : memref<1xf32>, vector<1xf32>
    %6 = vector.broadcast %4 : vector<f32> to vector<1xf32>
    %7 = arith.mulf %5, %6 : vector<1xf32>
    %8 = vector.transfer_read %arg5[%c0], %0 {in_bounds = [true]} : memref<1xf32>, vector<1xf32>
    %9 = arith.addf %7, %8 : vector<1xf32>
    %10 = vector.transfer_read %arg4[%c0], %0 {in_bounds = [true]} : memref<1xf32>, vector<1xf32>
    %11 = vector.broadcast %10 : vector<1xf32> to vector<2048x1xf32>
    %12 = vector.transfer_read %arg6[%c0, %c0], %0 {in_bounds = [true, true]} : memref<2048x1xf32>, vector<2048x1xf32>
    %13 = arith.mulf %11, %12 : vector<2048x1xf32>
    %14 = vector.broadcast %9 : vector<1xf32> to vector<2048x1xf32>
    %15 = vector.transfer_read %arg2[%c0, %c0], %0 {in_bounds = [true, true]} : memref<2048x1xf32>, vector<2048x1xf32>
    %16 = arith.mulf %14, %15 : vector<2048x1xf32>
    %17 = arith.addf %13, %16 : vector<2048x1xf32>
    vector.transfer_write %17, %arg6[%c0, %c0] {in_bounds = [true, true]} : vector<2048x1xf32>, memref<2048x1xf32>
    return
  }
}
