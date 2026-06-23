#map = affine_map<()[s0] -> (s0 ceildiv 4)>
#map1 = affine_map<()[s0] -> (s0 ceildiv 8)>
#map2 = affine_map<(d0) -> (d0 * 4)>
#map3 = affine_map<(d0) -> (d0 * 8)>
#map4 = affine_map<(d0)[s0] -> (-d0 + s0, 4)>
#map5 = affine_map<(d0)[s0] -> (-d0 + s0, 8)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: memref<?x?xf32>, %arg1: memref<?x?xf32>, %arg2: memref<?x?xf32>) attributes {llvm.emit_c_interface} {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f32
    %dim = memref.dim %arg0, %c1 : memref<?x?xf32>
    %dim_0 = memref.dim %arg1, %c0 : memref<?x?xf32>
    %0 = arith.cmpi eq, %dim, %dim_0 : index
    cf.assert %0, "mismatching contracting dimension for torch.aten.mm"
    linalg.fill ins(%cst : f32) outs(%arg2 : memref<?x?xf32>)
    %dim_1 = memref.dim %arg0, %c0 : memref<?x?xf32>
    %dim_2 = memref.dim %arg0, %c1 : memref<?x?xf32>
    %dim_3 = memref.dim %arg1, %c1 : memref<?x?xf32>
    %1 = affine.apply #map()[%dim_1]
    %2 = affine.apply #map1()[%dim_3]
    %3 = affine.apply #map()[%dim_2]
    scf.forall (%arg3, %arg4, %arg5) in (%1, %2, %3) {
      %4 = affine.apply #map2(%arg3)
      %5 = affine.apply #map3(%arg4)
      %6 = affine.apply #map2(%arg5)
      %7 = affine.min #map4(%4)[%dim_1]
      %8 = affine.min #map5(%5)[%dim_3]
      %9 = affine.min #map4(%6)[%dim_2]
      %subview = memref.subview %arg0[%4, %6] [%7, %9] [1, 1] : memref<?x?xf32> to memref<?x?xf32, strided<[?, 1], offset: ?>>
      %subview_4 = memref.subview %arg1[%6, %5] [%9, %8] [1, 1] : memref<?x?xf32> to memref<?x?xf32, strided<[?, 1], offset: ?>>
      %subview_5 = memref.subview %arg2[%4, %5] [%7, %8] [1, 1] : memref<?x?xf32> to memref<?x?xf32, strided<[?, 1], offset: ?>>
      linalg.matmul ins(%subview, %subview_4 : memref<?x?xf32, strided<[?, 1], offset: ?>>, memref<?x?xf32, strided<[?, 1], offset: ?>>) outs(%subview_5 : memref<?x?xf32, strided<[?, 1], offset: ?>>)
      %subview_6 = memref.subview %arg2[%4, %5] [%7, %8] [1, 1] : memref<?x?xf32> to memref<?x?xf32, strided<[?, 1], offset: ?>>
      linalg.copy ins(%subview_5 : memref<?x?xf32, strided<[?, 1], offset: ?>>) outs(%subview_6 : memref<?x?xf32, strided<[?, 1], offset: ?>>)
    }
    return
  }
}
