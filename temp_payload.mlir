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
    %2 = linalg.matmul ins(%arg0, %arg1 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%1 : tensor<?x?xf32>) -> tensor<?x?xf32>
    return %2 : tensor<?x?xf32>
  }

transform.named_sequence @__transform_main(%root: !transform.any_op) {
    %v1 = transform.structured.match in %root { ops = ["linalg.matmul"] } : (!transform.any_op) -> !transform.any_op
    %v3, %v2 = transform.structured.tile_using_forall %v1 tile_sizes [8, 16, 16] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %v4 = transform.structured.match ops{["func.func"]} in %root : (!transform.any_op) -> !transform.any_op
    transform.structured.vectorize_children_and_apply_patterns %v4 : (!transform.any_op) -> !transform.any_op
    transform.yield
}
}