#map = affine_map<(d0, d1) -> (d0, d1)>
module attributes {transform.with_named_sequence}  {
  func.func @main(%arg0: tensor<10x10xf32>, %arg1: tensor<10x10xf32>) -> tensor<10x10xf32> {
    %cst = arith.constant 2.000000e+00 : f32
    %0 = tensor.empty() : tensor<10x10xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : tensor<10x10xf32>, tensor<10x10xf32>) outs(%0 : tensor<10x10xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %3 = arith.mulf %in, %in_0 : f32
      linalg.yield %3 : f32
    } -> tensor<10x10xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%1 : tensor<10x10xf32>) outs(%0 : tensor<10x10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.addf %in, %cst : f32
      linalg.yield %3 : f32
    } -> tensor<10x10xf32>
    return %2 : tensor<10x10xf32>
  }

transform.named_sequence @__transform_main(%root: !transform.any_op) {
    %v1 = transform.structured.match ops{["linalg.generic"]} in %root : (!transform.any_op) -> !transform.any_op
    %v3, %v2 = transform.structured.tile_using_forall %v1 tile_sizes [8, 8] { mapping = [#gpu.block<x>, #gpu.block<y>] } : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %v4 = transform.structured.match ops{["linalg.generic"]} in %root : (!transform.any_op) -> !transform.any_op
    %v6, %v5 = transform.structured.tile_using_forall %v4 tile_sizes [4, 4] { mapping = [#gpu.thread<x>, #gpu.thread<y>] } : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %v7 = transform.bufferization.one_shot_bufferize %root { bufferize_function_boundaries = true } : (!transform.any_op) -> !transform.any_op
    // Lowering to NVVM handled by deterministic backend passes
    transform.yield
}
}