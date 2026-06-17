#map = affine_map<(d0) -> (d0 * 64)>
#map1 = affine_map<(d0) -> (d0 * 4)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: memref<4096x4096xf32, strided<[?, ?], offset: ?>>, %arg1: memref<4096x4096xf32, strided<[?, ?], offset: ?>>) -> memref<4096x4096xf32> {
    %cst = arith.constant 2.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<4096x4096xf32>
    %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<4096x4096xf32>
    scf.forall (%arg2, %arg3) in (64, 64) {
      %0 = affine.apply #map(%arg2)
      %1 = affine.apply #map(%arg3)
      %subview = memref.subview %arg0[%0, %1] [64, 64] [1, 1] : memref<4096x4096xf32, strided<[?, ?], offset: ?>> to memref<64x64xf32, strided<[?, ?], offset: ?>>
      %subview_1 = memref.subview %arg1[%0, %1] [64, 64] [1, 1] : memref<4096x4096xf32, strided<[?, ?], offset: ?>> to memref<64x64xf32, strided<[?, ?], offset: ?>>
      %subview_2 = memref.subview %alloc_0[%0, %1] [64, 64] [1, 1] : memref<4096x4096xf32> to memref<64x64xf32, strided<[4096, 1], offset: ?>>
      scf.forall (%arg4, %arg5) in (16, 16) {
        %2 = affine.apply #map1(%arg4)
        %3 = affine.apply #map1(%arg5)
        %subview_4 = memref.subview %subview[%2, %3] [4, 4] [1, 1] : memref<64x64xf32, strided<[?, ?], offset: ?>> to memref<4x4xf32, strided<[?, ?], offset: ?>>
        %subview_5 = memref.subview %subview_1[%2, %3] [4, 4] [1, 1] : memref<64x64xf32, strided<[?, ?], offset: ?>> to memref<4x4xf32, strided<[?, ?], offset: ?>>
        %subview_6 = memref.subview %subview_2[%2, %3] [4, 4] [1, 1] : memref<64x64xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %c4 = arith.constant 4 : index
        %c4_7 = arith.constant 4 : index
        %c0 = arith.constant 0 : index
        %4 = ub.poison : f32
        %5 = vector.transfer_read %subview_4[%c0, %c0], %4 : memref<4x4xf32, strided<[?, ?], offset: ?>>, vector<4x4xf32>
        %6 = ub.poison : f32
        %7 = vector.transfer_read %subview_5[%c0, %c0], %6 : memref<4x4xf32, strided<[?, ?], offset: ?>>, vector<4x4xf32>
        %8 = ub.poison : f32
        %9 = vector.transfer_read %subview_6[%c0, %c0], %8 : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4x4xf32>
        %10 = arith.mulf %5, %7 : vector<4x4xf32>
        %c0_8 = arith.constant 0 : index
        vector.transfer_write %10, %subview_6[%c0_8, %c0_8] : vector<4x4xf32>, memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %subview_9 = memref.subview %subview_2[%2, %3] [4, 4] [1, 1] : memref<64x64xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        memref.copy %subview_6, %subview_9 : memref<4x4xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      %subview_3 = memref.subview %alloc_0[%0, %1] [64, 64] [1, 1] : memref<4096x4096xf32> to memref<64x64xf32, strided<[4096, 1], offset: ?>>
      memref.copy %subview_2, %subview_3 : memref<64x64xf32, strided<[4096, 1], offset: ?>> to memref<64x64xf32, strided<[4096, 1], offset: ?>>
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    scf.forall (%arg2, %arg3) in (64, 64) {
      %0 = affine.apply #map(%arg2)
      %1 = affine.apply #map(%arg3)
      %subview = memref.subview %alloc_0[%0, %1] [64, 64] [1, 1] : memref<4096x4096xf32> to memref<64x64xf32, strided<[4096, 1], offset: ?>>
      %subview_1 = memref.subview %alloc[%0, %1] [64, 64] [1, 1] : memref<4096x4096xf32> to memref<64x64xf32, strided<[4096, 1], offset: ?>>
      scf.forall (%arg4, %arg5) in (16, 16) {
        %2 = affine.apply #map1(%arg4)
        %3 = affine.apply #map1(%arg5)
        %subview_3 = memref.subview %subview[%2, %3] [4, 4] [1, 1] : memref<64x64xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %subview_4 = memref.subview %subview_1[%2, %3] [4, 4] [1, 1] : memref<64x64xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %c4 = arith.constant 4 : index
        %c4_5 = arith.constant 4 : index
        %c0 = arith.constant 0 : index
        %4 = ub.poison : f32
        %5 = vector.transfer_read %subview_3[%c0, %c0], %4 : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4x4xf32>
        %6 = ub.poison : f32
        %7 = vector.transfer_read %subview_4[%c0, %c0], %6 : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4x4xf32>
        %cst_6 = arith.constant dense<2.000000e+00> : vector<4x4xf32>
        %8 = arith.addf %5, %cst_6 : vector<4x4xf32>
        %c0_7 = arith.constant 0 : index
        vector.transfer_write %8, %subview_4[%c0_7, %c0_7] : vector<4x4xf32>, memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %subview_8 = memref.subview %subview_1[%2, %3] [4, 4] [1, 1] : memref<64x64xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        memref.copy %subview_4, %subview_8 : memref<4x4xf32, strided<[4096, 1], offset: ?>> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      %subview_2 = memref.subview %alloc[%0, %1] [64, 64] [1, 1] : memref<4096x4096xf32> to memref<64x64xf32, strided<[4096, 1], offset: ?>>
      memref.copy %subview_1, %subview_2 : memref<64x64xf32, strided<[4096, 1], offset: ?>> to memref<64x64xf32, strided<[4096, 1], offset: ?>>
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    %cast = memref.cast %alloc : memref<4096x4096xf32> to memref<4096x4096xf32, strided<[?, ?], offset: ?>>
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

