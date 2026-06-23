#map = affine_map<()[s0] -> (s0 ceildiv 8)>
#map1 = affine_map<()[s0] -> (s0 ceildiv 16)>
#map2 = affine_map<(d0) -> (d0 * 8)>
#map3 = affine_map<(d0) -> (d0 * 16)>
#map4 = affine_map<(d0)[s0] -> (-d0 + s0, 8)>
#map5 = affine_map<(d0)[s0] -> (-d0 + s0, 16)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>) -> tensor<?x?xf32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f32
    %dim = tensor.dim %arg0, %c1 : tensor<?x?xf32>
    %dim_0 = tensor.dim %arg1, %c0 : tensor<?x?xf32>
    %0 = arith.cmpi eq, %dim, %dim_0 : index
    cf.assert %0, "mismatching contracting dimension for torch.aten.mm"
    %1 = linalg.fill ins(%cst : f32) outs(%arg2 : tensor<?x?xf32>) -> tensor<?x?xf32>
    %dim_1 = tensor.dim %arg0, %c0 : tensor<?x?xf32>
    %dim_2 = tensor.dim %arg0, %c1 : tensor<?x?xf32>
    %dim_3 = tensor.dim %arg1, %c1 : tensor<?x?xf32>
    %2 = affine.apply #map()[%dim_1]
    %3 = affine.apply #map1()[%dim_3]
    %4 = affine.apply #map1()[%dim_2]
    %5 = scf.forall (%arg3, %arg4, %arg5) in (%2, %3, %4) shared_outs(%arg6 = %1) -> (tensor<?x?xf32>) {
      %6 = affine.apply #map2(%arg3)
      %7 = affine.apply #map3(%arg4)
      %8 = affine.apply #map3(%arg5)
      %9 = affine.min #map4(%6)[%dim_1]
      %10 = affine.min #map5(%7)[%dim_3]
      %11 = affine.min #map5(%8)[%dim_2]
      %extracted_slice = tensor.extract_slice %arg0[%6, %8] [%9, %11] [1, 1] : tensor<?x?xf32> to tensor<?x?xf32>
      %extracted_slice_4 = tensor.extract_slice %arg1[%8, %7] [%11, %10] [1, 1] : tensor<?x?xf32> to tensor<?x?xf32>
      %extracted_slice_5 = tensor.extract_slice %arg6[%6, %7] [%9, %10] [1, 1] : tensor<?x?xf32> to tensor<?x?xf32>
      %12 = linalg.matmul ins(%extracted_slice, %extracted_slice_4 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%extracted_slice_5 : tensor<?x?xf32>) -> tensor<?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %12 into %arg6[%6, %7] [%9, %10] [1, 1] : tensor<?x?xf32> into tensor<?x?xf32>
      }
    }
    return %5 : tensor<?x?xf32>
  }
  transform.named_sequence @__transform_main(%arg0: !transform.any_op) {
    %0 = transform.structured.match ops{["linalg.matmul"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %tiled_op, %forall_op = transform.structured.tile_using_forall %0 tile_sizes [8, 16, 16] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %1 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %2 = transform.structured.vectorize_children_and_apply_patterns %1 : (!transform.any_op) -> !transform.any_op
    transform.yield 
  }
}

