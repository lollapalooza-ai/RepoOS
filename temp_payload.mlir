#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: tensor<?x?x?xf32>, %arg1: tensor<?x?x?xf32>, %arg2: tensor<?x?x?xf32>, %arg3: tensor<?x?x?xf32>) -> tensor<?x?x?xf32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 8.000000e+00 : f32
    %dim = tensor.dim %arg1, %c0 : tensor<?x?x?xf32>
    %dim_1 = tensor.dim %arg1, %c1 : tensor<?x?x?xf32>
    %dim_2 = tensor.dim %arg1, %c2 : tensor<?x?x?xf32>
    %0 = tensor.empty(%dim, %dim_2, %dim_1) : tensor<?x?x?xf32>
    %transposed = linalg.transpose ins(%arg1 : tensor<?x?x?xf32>) outs(%0 : tensor<?x?x?xf32>) permutation = [0, 2, 1] 
    %dim_3 = tensor.dim %arg0, %c0 : tensor<?x?x?xf32>
    %1 = arith.maxui %dim_3, %dim : index
    %dim_4 = tensor.dim %arg0, %c1 : tensor<?x?x?xf32>
    %dim_5 = tensor.dim %arg0, %c2 : tensor<?x?x?xf32>
    %2 = arith.index_cast %dim_5 : index to i64
    %3 = arith.index_cast %dim_2 : index to i64
    %4 = arith.cmpi eq, %2, %3 : i64
    cf.assert %4, "mismatching contracting dimension"
    %5 = tensor.empty(%1, %dim_4, %dim_1) : tensor<?x?x?xf32>
    %6 = linalg.fill ins(%cst : f32) outs(%5 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %7 = linalg.batch_matmul ins(%arg0, %transposed : tensor<?x?x?xf32>, tensor<?x?x?xf32>) outs(%6 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %8 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%7 : tensor<?x?x?xf32>) outs(%5 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %out: f32):
      %14 = arith.divf %in, %cst_0 : f32
      linalg.yield %14 : f32
    } -> tensor<?x?x?xf32>
    %dim_6 = tensor.dim %arg2, %c1 : tensor<?x?x?xf32>
    %9 = arith.index_cast %dim_1 : index to i64
    %10 = arith.index_cast %dim_6 : index to i64
    %11 = arith.cmpi eq, %9, %10 : i64
    cf.assert %11, "mismatching contracting dimension"
    %12 = linalg.fill ins(%cst : f32) outs(%arg3 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %13 = linalg.batch_matmul ins(%8, %arg2 : tensor<?x?x?xf32>, tensor<?x?x?xf32>) outs(%12 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    return %13 : tensor<?x?x?xf32>
  }

transform.named_sequence @__transform_main(%root: !transform.any_op) {
    %v1 = transform.structured.match in %root { ops = ["linalg.batch_matmul"] } : (!transform.any_op) -> !transform.any_op
    %v2 = transform.structured.match in %root { ops = ["linalg.generic"] } : (!transform.any_op) -> !transform.any_op
    %v4, %v3 = transform.structured.tile_using_forall %v1 tile_sizes [1, 4, 8, 16] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %v6, %v5 = transform.structured.tile_using_forall %v2 tile_sizes [1, 1, 8] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %v7 = transform.structured.match ops{["func.func"]} in %root : (!transform.any_op) -> !transform.any_op
    transform.structured.vectorize_children_and_apply_patterns %v7 : (!transform.any_op) -> !transform.any_op
    %v8 = transform.structured.match ops{["func.func"]} in %root : (!transform.any_op) -> !transform.any_op
    transform.structured.vectorize_children_and_apply_patterns %v8 : (!transform.any_op) -> !transform.any_op
    transform.yield
}
}