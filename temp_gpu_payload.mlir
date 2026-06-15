#map = affine_map<(d0, d1) -> (d0, d1)>
module attributes {transform.with_named_sequence}  {
  func.func @main(%arg0: tensor<10x10xf32>) -> tensor<10x10xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = tensor.empty() : tensor<10x10xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<10x10xf32>) outs(%0 : tensor<10x10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.addf %in, %cst_0 : f32
      linalg.yield %3 : f32
    } -> tensor<10x10xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%1 : tensor<10x10xf32>) outs(%0 : tensor<10x10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.cmpf ugt, %in, %cst : f32
      %4 = arith.select %3, %in, %cst : f32
      linalg.yield %4 : f32
    } -> tensor<10x10xf32>
    return %2 : tensor<10x10xf32>
  }

transform.named_sequence @__transform_main(%root: !transform.any_op) {
    %v1 = transform.structured.match ops{["linalg.generic"]} in %root : (!transform.any_op) -> !transform.any_op
    %v3, %v2 = transform.structured.tile_using_forall %v1 tile_sizes [10, 10] { mapping = [#gpu.block<x>, #gpu.block<y>] } : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %v4 = transform.structured.match ops{["linalg.generic"]} in %root : (!transform.any_op) -> !transform.any_op
    %v6, %v5 = transform.structured.tile_using_forall %v4 tile_sizes [1, 1] { mapping = [#gpu.thread<x>, #gpu.thread<y>] } : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %v7 = transform.bufferization.one_shot_bufferize %root { bufferize_function_boundaries = true } : (!transform.any_op) -> !transform.any_op
    // Lowering to NVVM handled by deterministic backend passes
    transform.yield
}
}