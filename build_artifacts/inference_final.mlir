#map = affine_map<(d0) -> (d0 * 8)>
#map1 = affine_map<(d0) -> (-d0 + 10, 8)>
#map2 = affine_map<()[s0] -> (s0 ceildiv 4)>
#map3 = affine_map<(d0) -> (d0 * 4)>
#map4 = affine_map<(d0)[s0] -> (-d0 + s0, 4)>
#map5 = affine_map<(d0, d1) -> (d0, d1)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: memref<10x10xf32, strided<[?, ?], offset: ?>>, %arg1: memref<10x10xf32, strided<[?, ?], offset: ?>>) -> memref<10x10xf32> {
    %cst = arith.constant 2.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10x10xf32>
    %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<10x10xf32>
    scf.forall (%arg2, %arg3) in (2, 2) {
      %0 = affine.apply #map(%arg2)
      %1 = affine.apply #map(%arg3)
      %2 = affine.min #map1(%0)
      %3 = affine.min #map1(%1)
      %subview = memref.subview %arg0[%0, %1] [%2, %3] [1, 1] : memref<10x10xf32, strided<[?, ?], offset: ?>> to memref<?x?xf32, strided<[?, ?], offset: ?>>
      %subview_1 = memref.subview %arg1[%0, %1] [%2, %3] [1, 1] : memref<10x10xf32, strided<[?, ?], offset: ?>> to memref<?x?xf32, strided<[?, ?], offset: ?>>
      %subview_2 = memref.subview %alloc_0[%0, %1] [%2, %3] [1, 1] : memref<10x10xf32> to memref<?x?xf32, strided<[10, 1], offset: ?>>
      %4 = affine.apply #map2()[%2]
      %5 = affine.apply #map2()[%3]
      scf.forall (%arg4, %arg5) in (%4, %5) {
        %6 = affine.apply #map3(%arg4)
        %7 = affine.apply #map3(%arg5)
        %8 = affine.min #map4(%6)[%2]
        %9 = affine.min #map4(%7)[%3]
        %subview_4 = memref.subview %subview[%6, %7] [%8, %9] [1, 1] : memref<?x?xf32, strided<[?, ?], offset: ?>> to memref<?x?xf32, strided<[?, ?], offset: ?>>
        %subview_5 = memref.subview %subview_1[%6, %7] [%8, %9] [1, 1] : memref<?x?xf32, strided<[?, ?], offset: ?>> to memref<?x?xf32, strided<[?, ?], offset: ?>>
        %subview_6 = memref.subview %subview_2[%6, %7] [%8, %9] [1, 1] : memref<?x?xf32, strided<[10, 1], offset: ?>> to memref<?x?xf32, strided<[10, 1], offset: ?>>
        linalg.generic {indexing_maps = [#map5, #map5, #map5], iterator_types = ["parallel", "parallel"]} ins(%subview_4, %subview_5 : memref<?x?xf32, strided<[?, ?], offset: ?>>, memref<?x?xf32, strided<[?, ?], offset: ?>>) outs(%subview_6 : memref<?x?xf32, strided<[10, 1], offset: ?>>) {
        ^bb0(%in: f32, %in_8: f32, %out: f32):
          %10 = arith.mulf %in, %in_8 : f32
          linalg.yield %10 : f32
        }
        %subview_7 = memref.subview %subview_2[%6, %7] [%8, %9] [1, 1] : memref<?x?xf32, strided<[10, 1], offset: ?>> to memref<?x?xf32, strided<[10, 1], offset: ?>>
        memref.copy %subview_6, %subview_7 : memref<?x?xf32, strided<[10, 1], offset: ?>> to memref<?x?xf32, strided<[10, 1], offset: ?>>
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      %subview_3 = memref.subview %alloc_0[%0, %1] [%2, %3] [1, 1] : memref<10x10xf32> to memref<?x?xf32, strided<[10, 1], offset: ?>>
      memref.copy %subview_2, %subview_3 : memref<?x?xf32, strided<[10, 1], offset: ?>> to memref<?x?xf32, strided<[10, 1], offset: ?>>
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    scf.forall (%arg2, %arg3) in (2, 2) {
      %0 = affine.apply #map(%arg2)
      %1 = affine.apply #map(%arg3)
      %2 = affine.min #map1(%0)
      %3 = affine.min #map1(%1)
      %subview = memref.subview %alloc_0[%0, %1] [%2, %3] [1, 1] : memref<10x10xf32> to memref<?x?xf32, strided<[10, 1], offset: ?>>
      %subview_1 = memref.subview %alloc[%0, %1] [%2, %3] [1, 1] : memref<10x10xf32> to memref<?x?xf32, strided<[10, 1], offset: ?>>
      %4 = affine.apply #map2()[%2]
      %5 = affine.apply #map2()[%3]
      scf.forall (%arg4, %arg5) in (%4, %5) {
        %6 = affine.apply #map3(%arg4)
        %7 = affine.apply #map3(%arg5)
        %8 = affine.min #map4(%6)[%2]
        %9 = affine.min #map4(%7)[%3]
        %subview_3 = memref.subview %subview[%6, %7] [%8, %9] [1, 1] : memref<?x?xf32, strided<[10, 1], offset: ?>> to memref<?x?xf32, strided<[10, 1], offset: ?>>
        %subview_4 = memref.subview %subview_1[%6, %7] [%8, %9] [1, 1] : memref<?x?xf32, strided<[10, 1], offset: ?>> to memref<?x?xf32, strided<[10, 1], offset: ?>>
        linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel"]} ins(%subview_3 : memref<?x?xf32, strided<[10, 1], offset: ?>>) outs(%subview_4 : memref<?x?xf32, strided<[10, 1], offset: ?>>) {
        ^bb0(%in: f32, %out: f32):
          %10 = arith.addf %in, %cst : f32
          linalg.yield %10 : f32
        }
        %subview_5 = memref.subview %subview_1[%6, %7] [%8, %9] [1, 1] : memref<?x?xf32, strided<[10, 1], offset: ?>> to memref<?x?xf32, strided<[10, 1], offset: ?>>
        memref.copy %subview_4, %subview_5 : memref<?x?xf32, strided<[10, 1], offset: ?>> to memref<?x?xf32, strided<[10, 1], offset: ?>>
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      %subview_2 = memref.subview %alloc[%0, %1] [%2, %3] [1, 1] : memref<10x10xf32> to memref<?x?xf32, strided<[10, 1], offset: ?>>
      memref.copy %subview_1, %subview_2 : memref<?x?xf32, strided<[10, 1], offset: ?>> to memref<?x?xf32, strided<[10, 1], offset: ?>>
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    return %alloc : memref<10x10xf32>
  }
  transform.named_sequence @__transform_main(%arg0: !transform.any_op) {
    %0 = transform.structured.match ops{["linalg.generic"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %tiled_op, %forall_op = transform.structured.tile_using_forall %0 tile_sizes [8, 8](mapping = [#gpu.block<x>, #gpu.block<y>]) : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %1 = transform.structured.match ops{["linalg.generic"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %tiled_op_0, %forall_op_1 = transform.structured.tile_using_forall %1 tile_sizes [4, 4](mapping = [#gpu.thread<x>, #gpu.thread<y>]) : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %2 = transform.bufferization.one_shot_bufferize %arg0 {bufferize_function_boundaries = true} : (!transform.any_op) -> !transform.any_op
    transform.yield 
  }
}

