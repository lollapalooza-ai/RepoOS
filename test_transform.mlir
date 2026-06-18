#map = affine_map<(d0, d1) -> (d0, d1)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: tensor<4096x4096xf32>, %arg1: tensor<4096x4096xf32>, %arg2: tensor<4096x4096xf32>) -> tensor<4096x4096xf32> {
    %cst = arith.constant 2.000000e+00 : f32
    %0 = tensor.cast %arg2 : tensor<4096x4096xf32> to tensor<4096x4096xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : tensor<4096x4096xf32>, tensor<4096x4096xf32>) outs(%0 : tensor<4096x4096xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %3 = arith.mulf %in, %in_0 : f32
      linalg.yield %3 : f32
    } -> tensor<4096x4096xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%1 : tensor<4096x4096xf32>) outs(%0 : tensor<4096x4096xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.addf %in, %cst : f32
      linalg.yield %3 : f32
    } -> tensor<4096x4096xf32>
    return %2 : tensor<4096x4096xf32>
  }

  transform.named_sequence @__transform_main(%root: !transform.any_op) {
    %v1 = transform.structured.match in %root { ops = ["linalg.generic"] } : (!transform.any_op) -> !transform.any_op
    %v2, %v3 = transform.structured.tile_using_forall %v1 tile_sizes [16, 16] { mapping = [#gpu.block<x>, #gpu.block<y>] } : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %v4, %v5 = transform.structured.tile_using_forall %v2 tile_sizes [4, 4] { mapping = [#gpu.thread<x>, #gpu.thread<y>] } : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    transform.structured.vectorize %v4 : !transform.any_op
    transform.yield
  }
}
