#map = affine_map<(d0, d1) -> (d0, d1)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: tensor<4096x4096xf32>, %arg1: tensor<4096x4096xf32>, %arg2: tensor<4096x4096xf32>) -> tensor<4096x4096xf32> {
    %cst = arith.constant 2.000000e+00 : f32
    %0 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : tensor<4096x4096xf32>, tensor<4096x4096xf32>) outs(%arg2 : tensor<4096x4096xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %2 = arith.mulf %in, %in_0 : f32
      linalg.yield %2 : f32
    } -> tensor<4096x4096xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%0 : tensor<4096x4096xf32>) outs(%arg2 : tensor<4096x4096xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = arith.addf %in, %cst : f32
      linalg.yield %2 : f32
    } -> tensor<4096x4096xf32>
    return %1 : tensor<4096x4096xf32>
  }

transform.named_sequence @__transform_main(%root: !transform.any_op) {
    %v1 = transform.structured.match in %root { ops = ["linalg.generic"] } : (!transform.any_op) -> !transform.any_op
    %v3, %v2 = transform.structured.tile_using_forall %v1 tile_sizes [64, 8] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    transform.structured.vectorize %v3 : !transform.any_op
    transform.yield
}
}