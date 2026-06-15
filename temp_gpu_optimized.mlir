#map = affine_map<(d0) -> (d0 * 10)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: memref<10x10xf32, strided<[?, ?], offset: ?>>) -> memref<10x10xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10x10xf32>
    %alloc_1 = memref.alloc() {alignment = 64 : i64} : memref<10x10xf32>
    scf.forall (%arg1, %arg2) in (1, 1) {
      %0 = affine.apply #map(%arg1)
      %1 = affine.apply #map(%arg2)
      %subview = memref.subview %arg0[%0, %1] [10, 10] [1, 1] : memref<10x10xf32, strided<[?, ?], offset: ?>> to memref<10x10xf32, strided<[?, ?], offset: ?>>
      %subview_2 = memref.subview %alloc_1[%0, %1] [10, 10] [1, 1] : memref<10x10xf32> to memref<10x10xf32, strided<[10, 1], offset: ?>>
      scf.forall (%arg3, %arg4) in (10, 10) {
        %subview_4 = memref.subview %subview[%arg3, %arg4] [1, 1] [1, 1] : memref<10x10xf32, strided<[?, ?], offset: ?>> to memref<1x1xf32, strided<[?, ?], offset: ?>>
        %subview_5 = memref.subview %subview_2[%arg3, %arg4] [1, 1] [1, 1] : memref<10x10xf32, strided<[10, 1], offset: ?>> to memref<1x1xf32, strided<[10, 1], offset: ?>>
        linalg.generic {indexing_maps = [#map1, #map1], iterator_types = ["parallel", "parallel"]} ins(%subview_4 : memref<1x1xf32, strided<[?, ?], offset: ?>>) outs(%subview_5 : memref<1x1xf32, strided<[10, 1], offset: ?>>) {
        ^bb0(%in: f32, %out: f32):
          %2 = arith.addf %in, %cst_0 : f32
          linalg.yield %2 : f32
        }
        %subview_6 = memref.subview %subview_2[%arg3, %arg4] [1, 1] [1, 1] : memref<10x10xf32, strided<[10, 1], offset: ?>> to memref<1x1xf32, strided<[10, 1], offset: ?>>
        memref.copy %subview_5, %subview_6 : memref<1x1xf32, strided<[10, 1], offset: ?>> to memref<1x1xf32, strided<[10, 1], offset: ?>>
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      %subview_3 = memref.subview %alloc_1[%0, %1] [10, 10] [1, 1] : memref<10x10xf32> to memref<10x10xf32, strided<[10, 1], offset: ?>>
      memref.copy %subview_2, %subview_3 : memref<10x10xf32, strided<[10, 1], offset: ?>> to memref<10x10xf32, strided<[10, 1], offset: ?>>
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    scf.forall (%arg1, %arg2) in (1, 1) {
      %0 = affine.apply #map(%arg1)
      %1 = affine.apply #map(%arg2)
      %subview = memref.subview %alloc_1[%0, %1] [10, 10] [1, 1] : memref<10x10xf32> to memref<10x10xf32, strided<[10, 1], offset: ?>>
      %subview_2 = memref.subview %alloc[%0, %1] [10, 10] [1, 1] : memref<10x10xf32> to memref<10x10xf32, strided<[10, 1], offset: ?>>
      scf.forall (%arg3, %arg4) in (10, 10) {
        %subview_4 = memref.subview %subview[%arg3, %arg4] [1, 1] [1, 1] : memref<10x10xf32, strided<[10, 1], offset: ?>> to memref<1x1xf32, strided<[10, 1], offset: ?>>
        %subview_5 = memref.subview %subview_2[%arg3, %arg4] [1, 1] [1, 1] : memref<10x10xf32, strided<[10, 1], offset: ?>> to memref<1x1xf32, strided<[10, 1], offset: ?>>
        linalg.generic {indexing_maps = [#map1, #map1], iterator_types = ["parallel", "parallel"]} ins(%subview_4 : memref<1x1xf32, strided<[10, 1], offset: ?>>) outs(%subview_5 : memref<1x1xf32, strided<[10, 1], offset: ?>>) {
        ^bb0(%in: f32, %out: f32):
          %2 = arith.cmpf ugt, %in, %cst : f32
          %3 = arith.select %2, %in, %cst : f32
          linalg.yield %3 : f32
        }
        %subview_6 = memref.subview %subview_2[%arg3, %arg4] [1, 1] [1, 1] : memref<10x10xf32, strided<[10, 1], offset: ?>> to memref<1x1xf32, strided<[10, 1], offset: ?>>
        memref.copy %subview_5, %subview_6 : memref<1x1xf32, strided<[10, 1], offset: ?>> to memref<1x1xf32, strided<[10, 1], offset: ?>>
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      %subview_3 = memref.subview %alloc[%0, %1] [10, 10] [1, 1] : memref<10x10xf32> to memref<10x10xf32, strided<[10, 1], offset: ?>>
      memref.copy %subview_2, %subview_3 : memref<10x10xf32, strided<[10, 1], offset: ?>> to memref<10x10xf32, strided<[10, 1], offset: ?>>
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    %cast = memref.cast %alloc : memref<10x10xf32> to memref<10x10xf32, strided<[?, ?], offset: ?>>
    return %alloc : memref<10x10xf32>
  }
  transform.named_sequence @__transform_main(%arg0: !transform.any_op) {
    %0 = transform.structured.match ops{["linalg.generic"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %tiled_op, %forall_op = transform.structured.tile_using_forall %0 tile_sizes [10, 10](mapping = [#gpu.block<x>, #gpu.block<y>]) : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %1 = transform.structured.match ops{["linalg.generic"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %tiled_op_0, %forall_op_1 = transform.structured.tile_using_forall %1 tile_sizes [1, 1](mapping = [#gpu.thread<x>, #gpu.thread<y>]) : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %2 = transform.bufferization.one_shot_bufferize %arg0 {bufferize_function_boundaries = true} : (!transform.any_op) -> !transform.any_op
    transform.yield 
  }
}

