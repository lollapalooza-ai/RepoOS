#map = affine_map<(d0) -> (d0 * 64)>
#map1 = affine_map<(d0) -> (d0 * 4)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: memref<4096x4096xf32, strided<[?, ?], offset: ?>>, %arg1: memref<4096x4096xf32, strided<[?, ?], offset: ?>>) -> memref<4096x4096xf32> {
    %cst = arith.constant dense<2.000000e+00> : vector<4x4xf32>
    %0 = ub.poison : f32
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<4096x4096xf32>
    %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<4096x4096xf32>
    scf.forall (%arg2, %arg3) in (64, 64) {
      %1 = affine.apply #map(%arg2)
      %2 = affine.apply #map(%arg3)
      %subview = memref.subview %arg0[%1, %2] [64, 64] [1, 1] : memref<4096x4096xf32, strided<[?, ?], offset: ?>> to memref<64x64xf32, strided<[?, ?], offset: ?>>
      %subview_1 = memref.subview %arg1[%1, %2] [64, 64] [1, 1] : memref<4096x4096xf32, strided<[?, ?], offset: ?>> to memref<64x64xf32, strided<[?, ?], offset: ?>>
      %subview_2 = memref.subview %alloc_0[%1, %2] [64, 64] [1, 1] : memref<4096x4096xf32> to memref<64x64xf32, strided<[4096, 1], offset: ?>>
      scf.forall (%arg4, %arg5) in (16, 16) {
        %3 = affine.apply #map1(%arg4)
        %4 = affine.apply #map1(%arg5)
        %subview_4 = memref.subview %subview[%3, %4] [4, 4] [1, 1] : memref<64x64xf32, strided<[?, ?], offset: ?>> to memref<4x4xf32, strided<[?, ?], offset: ?>>
        %subview_5 = memref.subview %subview_1[%3, %4] [4, 4] [1, 1] : memref<64x64xf32, strided<[?, ?], offset: ?>> to memref<4x4xf32, strided<[?, ?], offset: ?>>
        %subview_6 = memref.subview %subview_2[%3, %4] [4, 4] [1, 1] : memref<64x64xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %5 = vector.transfer_read %subview_4[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x4xf32, strided<[?, ?], offset: ?>>, vector<4x4xf32>
        %6 = vector.transfer_read %subview_5[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x4xf32, strided<[?, ?], offset: ?>>, vector<4x4xf32>
        %7 = arith.mulf %5, %6 : vector<4x4xf32>
        vector.transfer_write %7, %subview_6[%c0, %c0] {in_bounds = [true, true]} : vector<4x4xf32>, memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %subview_7 = memref.subview %subview_2[%3, %4] [4, 4] [1, 1] : memref<64x64xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        memref.copy %subview_6, %subview_7 : memref<4x4xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      %subview_3 = memref.subview %alloc_0[%1, %2] [64, 64] [1, 1] : memref<4096x4096xf32> to memref<64x64xf32, strided<[4096, 1], offset: ?>>
      memref.copy %subview_2, %subview_3 : memref<64x64xf32, strided<[4096, 1], offset: ?>> to memref<64x64xf32, strided<[4096, 1], offset: ?>>
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    scf.forall (%arg2, %arg3) in (64, 64) {
      %1 = affine.apply #map(%arg2)
      %2 = affine.apply #map(%arg3)
      %subview = memref.subview %alloc_0[%1, %2] [64, 64] [1, 1] : memref<4096x4096xf32> to memref<64x64xf32, strided<[4096, 1], offset: ?>>
      %subview_1 = memref.subview %alloc[%1, %2] [64, 64] [1, 1] : memref<4096x4096xf32> to memref<64x64xf32, strided<[4096, 1], offset: ?>>
      scf.forall (%arg4, %arg5) in (16, 16) {
        %3 = affine.apply #map1(%arg4)
        %4 = affine.apply #map1(%arg5)
        %subview_3 = memref.subview %subview[%3, %4] [4, 4] [1, 1] : memref<64x64xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %subview_4 = memref.subview %subview_1[%3, %4] [4, 4] [1, 1] : memref<64x64xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %5 = vector.transfer_read %subview_3[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4x4xf32>
        %6 = arith.addf %5, %cst : vector<4x4xf32>
        vector.transfer_write %6, %subview_4[%c0, %c0] {in_bounds = [true, true]} : vector<4x4xf32>, memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %subview_5 = memref.subview %subview_1[%3, %4] [4, 4] [1, 1] : memref<64x64xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        memref.copy %subview_4, %subview_5 : memref<4x4xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      %subview_2 = memref.subview %alloc[%1, %2] [64, 64] [1, 1] : memref<4096x4096xf32> to memref<64x64xf32, strided<[4096, 1], offset: ?>>
      memref.copy %subview_1, %subview_2 : memref<64x64xf32, strided<[4096, 1], offset: ?>> to memref<64x64xf32, strided<[4096, 1], offset: ?>>
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    return %alloc : memref<4096x4096xf32>
  }
  transform.named_sequence @__transform_main(%arg0: !transform.any_op) {
    %0 = transform.structured.match ops{["linalg.generic"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %tiled_op, %forall_op = transform.structured.tile_using_forall %0 tile_sizes [64, 64](mapping = [#gpu.block<x>, #gpu.block<y>]) : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %1 = transform.structured.match ops{["linalg.generic"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %tiled_op_0, %forall_op_1 = transform.structured.tile_using_forall %1 tile_sizes [4, 4](mapping = [#gpu.thread<x>, #gpu.thread<y>]) : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %2 = transform.structured.match ops{["linalg.generic"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    transform.structured.vectorize %2 : !transform.any_op
    %3 = transform.bufferization.one_shot_bufferize %arg0 {bufferize_function_boundaries = true} : (!transform.any_op) -> !transform.any_op
    transform.yield 
  }
}

