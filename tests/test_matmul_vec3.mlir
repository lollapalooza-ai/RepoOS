module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: tensor<512x512xf32>, %arg1: tensor<512x512xf32>, %arg2: tensor<512x512xf32>) -> tensor<512x512xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.cast %arg2 : tensor<512x512xf32> to tensor<512x512xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<512x512xf32>) -> tensor<512x512xf32>
    %2 = linalg.matmul ins(%arg0, %arg1 : tensor<512x512xf32>, tensor<512x512xf32>) outs(%1 : tensor<512x512xf32>) -> tensor<512x512xf32>
    return %2 : tensor<512x512xf32>
  }
  transform.named_sequence @__transform_main(%root: !transform.any_op) {
    %v1 = transform.structured.match in %root { ops = ["linalg.matmul"] } : (!transform.any_op) -> !transform.any_op
    %v3:2, %v2 = transform.structured.tile_using_for %v1 tile_sizes [16, 16] : (!transform.any_op) -> (!transform.any_op, !transform.any_op, !transform.any_op)
    transform.structured.vectorize_children_and_apply_patterns %v2 : !transform.any_op
    transform.yield
  }
}
