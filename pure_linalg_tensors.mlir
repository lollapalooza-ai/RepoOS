#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @main(%arg0: tensor<1024x1024xf32>, %arg1: tensor<1024x1024xf32>) -> tensor<1024x1024xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<1024x1024xf32>) outs(%arg1 : tensor<1024x1024xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = arith.addf %in, %cst_0 : f32
      linalg.yield %2 : f32
    } -> tensor<1024x1024xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%0 : tensor<1024x1024xf32>) outs(%arg1 : tensor<1024x1024xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = arith.cmpf ugt, %in, %cst : f32
      %3 = arith.select %2, %in, %cst : f32
      linalg.yield %3 : f32
    } -> tensor<1024x1024xf32>
    return %1 : tensor<1024x1024xf32>
  }
}

