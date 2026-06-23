#map = affine_map<()[s0] -> (s0 ceildiv 4)>
#map1 = affine_map<()[s0] -> (s0 ceildiv 8)>
#map2 = affine_map<()[s0] -> (s0 ceildiv 16)>
#map3 = affine_map<(d0) -> (d0 * 4)>
#map4 = affine_map<(d0) -> (d0 * 8)>
#map5 = affine_map<(d0) -> (d0 * 16)>
#map6 = affine_map<(d0)[s0] -> (-d0 + s0, 4)>
#map7 = affine_map<(d0)[s0] -> (-d0 + s0, 8)>
#map8 = affine_map<(d0)[s0] -> (-d0 + s0, 16)>
#map9 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: memref<?x?x?xf32>, %arg1: memref<?x?x?xf32>, %arg2: memref<?x?x?xf32>, %arg3: memref<?x?x?xf32>) attributes {llvm.emit_c_interface} {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 8.000000e+00 : f32
    %dim = memref.dim %arg1, %c0 : memref<?x?x?xf32>
    %dim_1 = memref.dim %arg1, %c1 : memref<?x?x?xf32>
    %dim_2 = memref.dim %arg1, %c2 : memref<?x?x?xf32>
    %alloc = memref.alloc(%dim, %dim_2, %dim_1) {alignment = 64 : i64} : memref<?x?x?xf32>
    linalg.transpose ins(%arg1 : memref<?x?x?xf32>) outs(%alloc : memref<?x?x?xf32>) permutation = [0, 2, 1] 
    %dim_3 = memref.dim %arg0, %c0 : memref<?x?x?xf32>
    %0 = arith.maxui %dim_3, %dim : index
    %dim_4 = memref.dim %arg0, %c1 : memref<?x?x?xf32>
    %dim_5 = memref.dim %arg0, %c2 : memref<?x?x?xf32>
    %1 = arith.index_cast %dim_5 : index to i64
    %2 = arith.index_cast %dim_2 : index to i64
    %3 = arith.cmpi eq, %1, %2 : i64
    cf.assert %3, "mismatching contracting dimension"
    %alloc_6 = memref.alloc(%0, %dim_4, %dim_1) {alignment = 64 : i64} : memref<?x?x?xf32>
    %alloc_7 = memref.alloc(%0, %dim_4, %dim_1) {alignment = 64 : i64} : memref<?x?x?xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_7 : memref<?x?x?xf32>)
    %dim_8 = memref.dim %arg0, %c0 : memref<?x?x?xf32>
    %dim_9 = memref.dim %arg0, %c1 : memref<?x?x?xf32>
    %dim_10 = memref.dim %arg0, %c2 : memref<?x?x?xf32>
    %dim_11 = memref.dim %alloc, %c2 : memref<?x?x?xf32>
    %4 = affine.apply #map()[%dim_9]
    %5 = affine.apply #map1()[%dim_11]
    %6 = affine.apply #map2()[%dim_10]
    scf.forall (%arg4, %arg5, %arg6, %arg7) in (%dim_8, %4, %5, %6) {
      %14 = affine.apply #map3(%arg5)
      %15 = affine.apply #map4(%arg6)
      %16 = affine.apply #map5(%arg7)
      %17 = affine.min #map6(%14)[%dim_9]
      %18 = affine.min #map7(%15)[%dim_11]
      %19 = affine.min #map8(%16)[%dim_10]
      %subview = memref.subview %arg0[%arg4, %14, %16] [1, %17, %19] [1, 1, 1] : memref<?x?x?xf32> to memref<1x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_20 = memref.subview %alloc[%arg4, %16, %15] [1, %19, %18] [1, 1, 1] : memref<?x?x?xf32> to memref<1x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_21 = memref.subview %alloc_7[%arg4, %14, %15] [1, %17, %18] [1, 1, 1] : memref<?x?x?xf32> to memref<1x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.batch_matmul ins(%subview, %subview_20 : memref<1x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<1x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_21 : memref<1x?x?xf32, strided<[?, ?, 1], offset: ?>>)
      %subview_22 = memref.subview %alloc_7[%arg4, %14, %15] [1, %17, %18] [1, 1, 1] : memref<?x?x?xf32> to memref<1x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_21 : memref<1x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_22 : memref<1x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    %dim_12 = memref.dim %alloc_7, %c0 : memref<?x?x?xf32>
    %dim_13 = memref.dim %alloc_7, %c1 : memref<?x?x?xf32>
    %dim_14 = memref.dim %alloc_7, %c2 : memref<?x?x?xf32>
    %7 = affine.apply #map1()[%dim_14]
    scf.forall (%arg4, %arg5, %arg6) in (%dim_12, %dim_13, %7) {
      %14 = affine.apply #map4(%arg6)
      %15 = affine.min #map7(%14)[%dim_14]
      %subview = memref.subview %alloc_7[%arg4, %arg5, %14] [1, 1, %15] [1, 1, 1] : memref<?x?x?xf32> to memref<1x1x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_20 = memref.subview %alloc_6[%arg4, %arg5, %14] [1, 1, %15] [1, 1, 1] : memref<?x?x?xf32> to memref<1x1x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map9, #map9], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<1x1x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_20 : memref<1x1x?xf32, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %16 = arith.divf %in, %cst_0 : f32
        linalg.yield %16 : f32
      }
      %subview_21 = memref.subview %alloc_6[%arg4, %arg5, %14] [1, 1, %15] [1, 1, 1] : memref<?x?x?xf32> to memref<1x1x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_20 : memref<1x1x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_21 : memref<1x1x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    %dim_15 = memref.dim %arg2, %c1 : memref<?x?x?xf32>
    %8 = arith.index_cast %dim_1 : index to i64
    %9 = arith.index_cast %dim_15 : index to i64
    %10 = arith.cmpi eq, %8, %9 : i64
    cf.assert %10, "mismatching contracting dimension"
    linalg.fill ins(%cst : f32) outs(%arg3 : memref<?x?x?xf32>)
    %dim_16 = memref.dim %alloc_6, %c0 : memref<?x?x?xf32>
    %dim_17 = memref.dim %alloc_6, %c1 : memref<?x?x?xf32>
    %dim_18 = memref.dim %alloc_6, %c2 : memref<?x?x?xf32>
    %dim_19 = memref.dim %arg2, %c2 : memref<?x?x?xf32>
    %11 = affine.apply #map()[%dim_17]
    %12 = affine.apply #map1()[%dim_19]
    %13 = affine.apply #map2()[%dim_18]
    scf.forall (%arg4, %arg5, %arg6, %arg7) in (%dim_16, %11, %12, %13) {
      %14 = affine.apply #map3(%arg5)
      %15 = affine.apply #map4(%arg6)
      %16 = affine.apply #map5(%arg7)
      %17 = affine.min #map6(%14)[%dim_17]
      %18 = affine.min #map7(%15)[%dim_19]
      %19 = affine.min #map8(%16)[%dim_18]
      %subview = memref.subview %alloc_6[%arg4, %14, %16] [1, %17, %19] [1, 1, 1] : memref<?x?x?xf32> to memref<1x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_20 = memref.subview %arg2[%arg4, %16, %15] [1, %19, %18] [1, 1, 1] : memref<?x?x?xf32> to memref<1x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_21 = memref.subview %arg3[%arg4, %14, %15] [1, %17, %18] [1, 1, 1] : memref<?x?x?xf32> to memref<1x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.batch_matmul ins(%subview, %subview_20 : memref<1x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<1x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_21 : memref<1x?x?xf32, strided<[?, ?, 1], offset: ?>>)
      %subview_22 = memref.subview %arg3[%arg4, %14, %15] [1, %17, %18] [1, 1, 1] : memref<?x?x?xf32> to memref<1x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_21 : memref<1x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_22 : memref<1x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    return
  }
}
