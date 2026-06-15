#map = affine_map<(d0, d1) -> (d0, d1)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: tensor<10x10xf32>) -> tensor<10x10xf32> {
    %0 = tensor.empty() : tensor<10x10xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<10x10xf32>) outs(%0 : tensor<10x10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.addf %in, %in : f32
      linalg.yield %3 : f32
    } -> tensor<10x10xf32>
    return %1 : tensor<10x10xf32>
  }

  transform.named_sequence @__transform_main(%root: !transform.any_op) {
      %v1 = transform.structured.match ops{["linalg.generic"]} in %root : (!transform.any_op) -> !transform.any_op
      %v3, %v2 = transform.structured.tile_using_forall %v1 num_threads [1, 1] mapping [#gpu.block_id_x, #gpu.block_id_y] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
      transform.yield
  }
}
