
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @main(%arg0: tensor<4096x4096xf32>, %arg1: tensor<4096x4096xf32>, %arg2: tensor<4096x4096xf32>) -> tensor<4096x4096xf32> {
    %cst = arith.constant 2.000000e+00 : f32
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : tensor<4096x4096xf32>, tensor<4096x4096xf32>) outs(%arg2 : tensor<4096x4096xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %3 = arith.mulf %in, %in_0 : f32
      linalg.yield %3 : f32
    } -> tensor<4096x4096xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%1 : tensor<4096x4096xf32>) outs(%arg2 : tensor<4096x4096xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.addf %in, %cst : f32
      linalg.yield %3 : f32
    } -> tensor<4096x4096xf32>
    return %2 : tensor<4096x4096xf32>
  }
}
