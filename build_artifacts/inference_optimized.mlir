#map = affine_map<(d0) -> (d0 * 8)>
#map1 = affine_map<(d0) -> (-d0 + 10, 8)>
#map2 = affine_map<(d0) -> (d0 - 1)>
#map3 = affine_map<()[s0] -> (s0 ceildiv 4)>
#map4 = affine_map<(d0) -> (d0 * 4)>
#map5 = affine_map<(d0)[s0] -> (-d0 + s0, 4)>
#map6 = affine_map<(d0, d1) -> (d0, d1)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: memref<10x10xf32, strided<[?, ?], offset: ?>>) -> memref<10x10xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10x10xf32>
    %alloc_1 = memref.alloc() {alignment = 64 : i64} : memref<10x10xf32>
    scf.forall (%arg1, %arg2) in (2, 2) {
      %0 = affine.apply #map(%arg1)
      %1 = affine.apply #map(%arg2)
      %c10 = arith.constant 10 : index
      %2 = affine.min #map1(%0)
      %c10_2 = arith.constant 10 : index
      %3 = affine.min #map1(%1)
      %4 = affine.apply #map2(%2)
      %5 = affine.apply #map2(%3)
      %6 = affine.apply #map2(%2)
      %7 = affine.apply #map2(%3)
      %8 = affine.apply #map2(%2)
      %9 = affine.apply #map2(%3)
      %subview = memref.subview %arg0[%0, %1] [%2, %3] [1, 1] : memref<10x10xf32, strided<[?, ?], offset: ?>> to memref<?x?xf32, strided<[?, ?], offset: ?>>
      %subview_3 = memref.subview %alloc_1[%0, %1] [%2, %3] [1, 1] : memref<10x10xf32> to memref<?x?xf32, strided<[10, 1], offset: ?>>
      %c0 = arith.constant 0 : index
      %c1 = arith.constant 1 : index
      %c0_4 = arith.constant 0 : index
      %c1_5 = arith.constant 1 : index
      %10 = affine.apply #map3()[%2]
      %11 = affine.apply #map3()[%3]
      scf.forall (%arg3, %arg4) in (%10, %11) {
        %16 = affine.apply #map4(%arg3)
        %17 = affine.apply #map4(%arg4)
        %18 = affine.min #map5(%16)[%2]
        %19 = affine.min #map5(%17)[%3]
        %20 = affine.apply #map2(%18)
        %21 = affine.apply #map2(%19)
        %22 = affine.apply #map2(%18)
        %23 = affine.apply #map2(%19)
        %24 = affine.apply #map2(%18)
        %25 = affine.apply #map2(%19)
        %subview_7 = memref.subview %subview[%16, %17] [%18, %19] [1, 1] : memref<?x?xf32, strided<[?, ?], offset: ?>> to memref<?x?xf32, strided<[?, ?], offset: ?>>
        %subview_8 = memref.subview %subview_3[%16, %17] [%18, %19] [1, 1] : memref<?x?xf32, strided<[10, 1], offset: ?>> to memref<?x?xf32, strided<[10, 1], offset: ?>>
        linalg.generic {indexing_maps = [#map6, #map6], iterator_types = ["parallel", "parallel"]} ins(%subview_7 : memref<?x?xf32, strided<[?, ?], offset: ?>>) outs(%subview_8 : memref<?x?xf32, strided<[10, 1], offset: ?>>) {
        ^bb0(%in: f32, %out: f32):
          %30 = arith.addf %in, %cst_0 : f32
          linalg.yield %30 : f32
        }
        %26 = affine.apply #map2(%18)
        %27 = affine.apply #map2(%19)
        %28 = affine.apply #map2(%18)
        %29 = affine.apply #map2(%19)
        %subview_9 = memref.subview %subview_3[%16, %17] [%18, %19] [1, 1] : memref<?x?xf32, strided<[10, 1], offset: ?>> to memref<?x?xf32, strided<[10, 1], offset: ?>>
        memref.copy %subview_8, %subview_9 : memref<?x?xf32, strided<[10, 1], offset: ?>> to memref<?x?xf32, strided<[10, 1], offset: ?>>
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      %12 = affine.apply #map2(%2)
      %13 = affine.apply #map2(%3)
      %14 = affine.apply #map2(%2)
      %15 = affine.apply #map2(%3)
      %subview_6 = memref.subview %alloc_1[%0, %1] [%2, %3] [1, 1] : memref<10x10xf32> to memref<?x?xf32, strided<[10, 1], offset: ?>>
      memref.copy %subview_3, %subview_6 : memref<?x?xf32, strided<[10, 1], offset: ?>> to memref<?x?xf32, strided<[10, 1], offset: ?>>
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    scf.forall (%arg1, %arg2) in (2, 2) {
      %0 = affine.apply #map(%arg1)
      %1 = affine.apply #map(%arg2)
      %c10 = arith.constant 10 : index
      %2 = affine.min #map1(%0)
      %c10_2 = arith.constant 10 : index
      %3 = affine.min #map1(%1)
      %4 = affine.apply #map2(%2)
      %5 = affine.apply #map2(%3)
      %6 = affine.apply #map2(%2)
      %7 = affine.apply #map2(%3)
      %8 = affine.apply #map2(%2)
      %9 = affine.apply #map2(%3)
      %subview = memref.subview %alloc_1[%0, %1] [%2, %3] [1, 1] : memref<10x10xf32> to memref<?x?xf32, strided<[10, 1], offset: ?>>
      %subview_3 = memref.subview %alloc[%0, %1] [%2, %3] [1, 1] : memref<10x10xf32> to memref<?x?xf32, strided<[10, 1], offset: ?>>
      %c0 = arith.constant 0 : index
      %c1 = arith.constant 1 : index
      %c0_4 = arith.constant 0 : index
      %c1_5 = arith.constant 1 : index
      %10 = affine.apply #map3()[%2]
      %11 = affine.apply #map3()[%3]
      scf.forall (%arg3, %arg4) in (%10, %11) {
        %16 = affine.apply #map4(%arg3)
        %17 = affine.apply #map4(%arg4)
        %18 = affine.min #map5(%16)[%2]
        %19 = affine.min #map5(%17)[%3]
        %20 = affine.apply #map2(%18)
        %21 = affine.apply #map2(%19)
        %22 = affine.apply #map2(%18)
        %23 = affine.apply #map2(%19)
        %24 = affine.apply #map2(%18)
        %25 = affine.apply #map2(%19)
        %subview_7 = memref.subview %subview[%16, %17] [%18, %19] [1, 1] : memref<?x?xf32, strided<[10, 1], offset: ?>> to memref<?x?xf32, strided<[10, 1], offset: ?>>
        %subview_8 = memref.subview %subview_3[%16, %17] [%18, %19] [1, 1] : memref<?x?xf32, strided<[10, 1], offset: ?>> to memref<?x?xf32, strided<[10, 1], offset: ?>>
        linalg.generic {indexing_maps = [#map6, #map6], iterator_types = ["parallel", "parallel"]} ins(%subview_7 : memref<?x?xf32, strided<[10, 1], offset: ?>>) outs(%subview_8 : memref<?x?xf32, strided<[10, 1], offset: ?>>) {
        ^bb0(%in: f32, %out: f32):
          %30 = arith.cmpf ugt, %in, %cst : f32
          %31 = arith.select %30, %in, %cst : f32
          linalg.yield %31 : f32
        }
        %26 = affine.apply #map2(%18)
        %27 = affine.apply #map2(%19)
        %28 = affine.apply #map2(%18)
        %29 = affine.apply #map2(%19)
        %subview_9 = memref.subview %subview_3[%16, %17] [%18, %19] [1, 1] : memref<?x?xf32, strided<[10, 1], offset: ?>> to memref<?x?xf32, strided<[10, 1], offset: ?>>
        memref.copy %subview_8, %subview_9 : memref<?x?xf32, strided<[10, 1], offset: ?>> to memref<?x?xf32, strided<[10, 1], offset: ?>>
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      %12 = affine.apply #map2(%2)
      %13 = affine.apply #map2(%3)
      %14 = affine.apply #map2(%2)
      %15 = affine.apply #map2(%3)
      %subview_6 = memref.subview %alloc[%0, %1] [%2, %3] [1, 1] : memref<10x10xf32> to memref<?x?xf32, strided<[10, 1], offset: ?>>
      memref.copy %subview_3, %subview_6 : memref<?x?xf32, strided<[10, 1], offset: ?>> to memref<?x?xf32, strided<[10, 1], offset: ?>>
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    %cast = memref.cast %alloc : memref<10x10xf32> to memref<10x10xf32, strided<[?, ?], offset: ?>>
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

