#map = affine_map<(d0) -> (d0 * 32)>
#map1 = affine_map<(d0) -> (d0 * 8)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: memref<512x512xf32>, %arg1: memref<512x512xf32>, %arg2: memref<512x512xf32>) {
    %0 = ub.poison : f32
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<0.000000e+00> : vector<512x512xf32>
    vector.transfer_write %cst, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<512x512xf32>, memref<512x512xf32>
    scf.forall (%arg3, %arg4, %arg5) in (16, 16, 64) {
      %1 = affine.apply #map(%arg3)
      %2 = affine.apply #map(%arg4)
      %subview = memref.subview %arg2[%1, %2] [32, 32] [1, 1] : memref<512x512xf32> to memref<32x32xf32, strided<[512, 1], offset: ?>>
      %3 = affine.apply #map(%arg3)
      %4 = affine.apply #map1(%arg5)
      %5 = vector.transfer_read %arg0[%3, %4], %0 {in_bounds = [true, true]} : memref<512x512xf32>, vector<32x8xf32>
      %6 = affine.apply #map1(%arg5)
      %7 = affine.apply #map(%arg4)
      %8 = vector.transfer_read %arg1[%6, %7], %0 {in_bounds = [true, true]} : memref<512x512xf32>, vector<8x32xf32>
      %9 = affine.apply #map(%arg3)
      %10 = affine.apply #map(%arg4)
      %11 = vector.transfer_read %arg2[%9, %10], %0 {in_bounds = [true, true]} : memref<512x512xf32>, vector<32x32xf32>
      %12 = vector.contract {indexing_maps = [#map2, #map3, #map4], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %5, %8, %11 : vector<32x8xf32>, vector<8x32xf32> into vector<32x32xf32>
      vector.transfer_write %12, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<32x32xf32>, memref<32x32xf32, strided<[512, 1], offset: ?>>
      %subview_0 = memref.subview %arg2[%1, %2] [32, 32] [1, 1] : memref<512x512xf32> to memref<32x32xf32, strided<[512, 1], offset: ?>>
      linalg.copy ins(%subview : memref<32x32xf32, strided<[512, 1], offset: ?>>) outs(%subview_0 : memref<32x32xf32, strided<[512, 1], offset: ?>>)
    }
    return
  }
}
