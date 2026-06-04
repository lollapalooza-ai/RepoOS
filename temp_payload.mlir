#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0)>
#map2 = affine_map<(d0) -> (d0)>
module {
  func.func @main(%arg0: tensor<3x3xf32>, %arg1: tensor<3xf32>, %arg2: tensor<3xf32>, %arg3: tensor<3xf32>) {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = tensor.empty() : tensor<3xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<3xf32>) -> tensor<3xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "reduction"]} ins(%arg0 : tensor<3x3xf32>) outs(%1 : tensor<3xf32>) {
    ^bb0(%in: f32, %out: f32):
      %4 = arith.addf %in, %out : f32
      linalg.yield %4 : f32
    } -> tensor<3xf32>
    %3 = linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel"]} ins(%2 : tensor<3xf32>) outs(%0 : tensor<3xf32>) {
    ^bb0(%in: f32, %out: f32):
      %4 = arith.cmpf one, %in, %cst : f32
      cf.assert %4, "unimplemented: tensor with zero element"
      %5 = arith.divf %cst_0, %in : f32
      linalg.yield %5 : f32
    } -> tensor<3xf32>
    return
  }
}


module attributes {transform.with_named_sequence} {
  transform.named_sequence @__transform_main(%arg0: !transform.any_op) {
    %main_func = transform.structured.match ops{["func.func"]} in %arg0 {
      transform.check.func_name ["main"]
    } : (!transform.any_op) -> !transform.any_op

    // Step 1: Optimize `linalg.matvec` operations.
    // We tile the reduction loop, unroll it, and vectorize the inner operation.
    %matvec_ops = transform.structured.match ops{["linalg.matvec"]} in %main_func
      : (!transform.any_op) -> !transform.any_op

    // Tile the reduction dimension (dim 1) to size 4 for vectorization.
    // The parallel dimension (dim 0) is not tiled (size 0).
    %k_loop, %tiled_matvec = transform.structured.tile_using_for %matvec_ops tile_sizes = [0, 4]
      : (!transform.any_op) -> (!transform.any_op, !transform.any_op)

    // Unroll the generated loop for the reduction dimension.
    transform.loop.unroll %k_loop { factor = 2 }

    // Vectorize the tiled payload op. `vectorize_padding` is crucial for small, non-multiple sizes.
    transform.structured.vectorize %tiled_matvec { vectorize_padding } : !transform.any_op

    // Step 2: Optimize `linalg.generic` operations.
    // A similar strategy is applied: tile the outermost loop, unroll, and vectorize.
    %generic_ops = transform.structured.match ops{["linalg.generic"]} in %main_func
      : (!transform.any_op) -> !transform.any_op

    // Tile the outermost dimension of generic ops by a vector-friendly size.
    %generic_loop, %tiled_generic = transform.structured.tile_using_for %generic_ops tile_sizes = [4]
      : (!transform.any_op) -> (!transform.any_op, !transform.any_op)

    // Unroll the generated loop.
    transform.loop.unroll %generic_loop { factor = 4 }

    // Vectorize the tiled generic payload.
    transform.structured.vectorize %tiled_generic { vectorize_padding } : !transform.any_op
  }
}