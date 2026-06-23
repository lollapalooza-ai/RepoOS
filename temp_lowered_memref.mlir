#map = affine_map<(d0) -> (d0 * 8)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: memref<4096x4096xf32>, %arg1: memref<4096x4096xf32>, %arg2: memref<4096x4096xf32>) {
    %0 = ub.poison : f32
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<0.000000e+00> : vector<4096x4096xf32>
    vector.transfer_write %cst, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<4096x4096xf32>, memref<4096x4096xf32>
    scf.forall (%arg3, %arg4, %arg5) in (512, 512, 512) {
      %1 = affine.apply #map(%arg3)
      %2 = affine.apply #map(%arg4)
      %subview = memref.subview %arg2[%1, %2] [8, 8] [1, 1] : memref<4096x4096xf32> to memref<8x8xf32, strided<[4096, 1], offset: ?>>
      %3 = affine.apply #map(%arg3)
      %4 = affine.apply #map(%arg5)
      %5 = vector.transfer_read %arg0[%3, %4], %0 {in_bounds = [true, true]} : memref<4096x4096xf32>, vector<8x8xf32>
      %6 = affine.apply #map(%arg5)
      %7 = affine.apply #map(%arg4)
      %8 = vector.transfer_read %arg1[%6, %7], %0 {in_bounds = [true, true]} : memref<4096x4096xf32>, vector<8x8xf32>
      %9 = affine.apply #map(%arg3)
      %10 = affine.apply #map(%arg4)
      %11 = vector.transfer_read %arg2[%9, %10], %0 {in_bounds = [true, true]} : memref<4096x4096xf32>, vector<8x8xf32>
      %12 = vector.contract {indexing_maps = [#map1, #map2, #map3], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %5, %8, %11 : vector<8x8xf32>, vector<8x8xf32> into vector<8x8xf32>
      vector.transfer_write %12, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<8x8xf32>, memref<8x8xf32, strided<[4096, 1], offset: ?>>
      %subview_0 = memref.subview %arg2[%1, %2] [8, 8] [1, 1] : memref<4096x4096xf32> to memref<8x8xf32, strided<[4096, 1], offset: ?>>
      linalg.copy ins(%subview : memref<8x8xf32, strided<[4096, 1], offset: ?>>) outs(%subview_0 : memref<8x8xf32, strided<[4096, 1], offset: ?>>)
    }
    return
  }
}
