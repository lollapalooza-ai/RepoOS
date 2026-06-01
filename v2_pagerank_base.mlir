#map = affine_map<(d0) -> ()>
#map1 = affine_map<(d0) -> (d0)>
#map2 = affine_map<() -> ()>
module {
  func.func @main(%arg0: tensor<8192xf32>, %arg1: tensor<8192x8192xf32>, %arg2: tensor<f32>, %arg3: tensor<8192xf32>) -> tensor<8192xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = tensor.empty() : tensor<8192xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<8192xf32>) -> tensor<8192xf32>
    %2 = linalg.matvec ins(%arg1, %arg0 : tensor<8192x8192xf32>, tensor<8192xf32>) outs(%1 : tensor<8192xf32>) -> tensor<8192xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel"]} ins(%arg2, %2 : tensor<f32>, tensor<8192xf32>) outs(%0 : tensor<8192xf32>) {
    ^bb0(%in: f32, %in_1: f32, %out: f32):
      %8 = arith.mulf %in, %in_1 : f32
      linalg.yield %8 : f32
    } -> tensor<8192xf32>
    %4 = tensor.empty() : tensor<f32>
    %5 = linalg.generic {indexing_maps = [#map2, #map2], iterator_types = []} ins(%arg2 : tensor<f32>) outs(%4 : tensor<f32>) {
    ^bb0(%in: f32, %out: f32):
      %8 = arith.subf %cst_0, %in : f32
      linalg.yield %8 : f32
    } -> tensor<f32>
    %6 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel"]} ins(%5, %arg3 : tensor<f32>, tensor<8192xf32>) outs(%0 : tensor<8192xf32>) {
    ^bb0(%in: f32, %in_1: f32, %out: f32):
      %8 = arith.mulf %in, %in_1 : f32
      linalg.yield %8 : f32
    } -> tensor<8192xf32>
    %7 = linalg.generic {indexing_maps = [#map1, #map1, #map1], iterator_types = ["parallel"]} ins(%3, %6 : tensor<8192xf32>, tensor<8192xf32>) outs(%0 : tensor<8192xf32>) {
    ^bb0(%in: f32, %in_1: f32, %out: f32):
      %8 = arith.addf %in, %in_1 : f32
      linalg.yield %8 : f32
    } -> tensor<8192xf32>
    return %7 : tensor<8192xf32>
  }
}
