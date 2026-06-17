#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @main(%arg0: tensor<1024x1024xf32>, %arg1: tensor<1024x1024xf32>) -> tensor<1024x1024xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = tensor.cast %arg1 : tensor<1024x1024xf32> to tensor<1024x1024xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<1024x1024xf32>) outs(%0 : tensor<1024x1024xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.addf %in, %cst_0 : f32
      linalg.yield %3 : f32
    } -> tensor<1024x1024xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%1 : tensor<1024x1024xf32>) outs(%0 : tensor<1024x1024xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.cmpf ugt, %in, %cst : f32
      %4 = arith.select %3, %in, %cst : f32
      linalg.yield %4 : f32
    } -> tensor<1024x1024xf32>
    return %2 : tensor<1024x1024xf32>
  }
}
