#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> ()>
#map2 = affine_map<(d0) -> (d0)>
#map3 = affine_map<(d0) -> ()>
#map4 = affine_map<(d0, d1) -> (d1)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: tensor<2048x2048xf32>, %arg1: tensor<2048x1xf32>, %arg2: tensor<2048x1xf32>, %arg3: tensor<2048x1xf32>, %arg4: tensor<1xf32>, %arg5: tensor<1xf32>, %arg6: tensor<2048x1xf32>) -> tensor<2048x1xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = linalg.fill ins(%cst : f32) outs(%arg6 : tensor<2048x1xf32>) -> tensor<2048x1xf32>
    %1 = linalg.matmul ins(%arg0, %arg1 : tensor<2048x2048xf32>, tensor<2048x1xf32>) outs(%0 : tensor<2048x1xf32>) -> tensor<2048x1xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg1, %arg3 : tensor<2048x1xf32>, tensor<2048x1xf32>) outs(%arg6 : tensor<2048x1xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %12 = arith.mulf %in, %in_0 : f32
      linalg.yield %12 : f32
    } -> tensor<2048x1xf32>
    %3 = tensor.empty() : tensor<f32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<f32>) -> tensor<f32>
    %5 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["reduction", "reduction"]} ins(%2 : tensor<2048x1xf32>) outs(%4 : tensor<f32>) {
    ^bb0(%in: f32, %out: f32):
      %12 = arith.addf %in, %out : f32
      linalg.yield %12 : f32
    } -> tensor<f32>
    %6 = tensor.empty() : tensor<1xf32>
    %7 = linalg.generic {indexing_maps = [#map2, #map3, #map2], iterator_types = ["parallel"]} ins(%arg4, %5 : tensor<1xf32>, tensor<f32>) outs(%6 : tensor<1xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %12 = arith.mulf %in, %in_0 : f32
      linalg.yield %12 : f32
    } -> tensor<1xf32>
    %8 = linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel"]} ins(%7, %arg5 : tensor<1xf32>, tensor<1xf32>) outs(%6 : tensor<1xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %12 = arith.addf %in, %in_0 : f32
      linalg.yield %12 : f32
    } -> tensor<1xf32>
    %9 = linalg.generic {indexing_maps = [#map4, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg4, %1 : tensor<1xf32>, tensor<2048x1xf32>) outs(%arg6 : tensor<2048x1xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %12 = arith.mulf %in, %in_0 : f32
      linalg.yield %12 : f32
    } -> tensor<2048x1xf32>
    %10 = linalg.generic {indexing_maps = [#map4, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%8, %arg2 : tensor<1xf32>, tensor<2048x1xf32>) outs(%arg6 : tensor<2048x1xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %12 = arith.mulf %in, %in_0 : f32
      linalg.yield %12 : f32
    } -> tensor<2048x1xf32>
    %11 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%9, %10 : tensor<2048x1xf32>, tensor<2048x1xf32>) outs(%arg6 : tensor<2048x1xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %12 = arith.addf %in, %in_0 : f32
      linalg.yield %12 : f32
    } -> tensor<2048x1xf32>
    return %11 : tensor<2048x1xf32>
  }

transform.named_sequence @__transform_main(%root: !transform.any_op) {
    %v1 = transform.structured.match in %root { ops = ["linalg.matmul"] } : (!transform.any_op) -> !transform.any_op
    %v3, %v2 = transform.structured.tile_using_forall %v1 tile_sizes [8, 1, 8] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %v4 = transform.structured.match ops{["func.func"]} in %root : (!transform.any_op) -> !transform.any_op
    transform.structured.vectorize_children_and_apply_patterns %v4 : (!transform.any_op) -> !transform.any_op
    transform.yield
}
}