#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @main(%arg0: memref<1024x1024xf32>, %arg1: memref<1024x1024xf32>) {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : memref<1024x1024xf32>) outs(%arg1 : memref<1024x1024xf32>) {
    ^bb0(%in: f32, %out: f32):
      %0 = arith.addf %in, %cst_0 : f32
      linalg.yield %0 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg1 : memref<1024x1024xf32>) outs(%arg1 : memref<1024x1024xf32>) {
    ^bb0(%in: f32, %out: f32):
      %0 = arith.cmpf ugt, %in, %cst : f32
      %1 = arith.select %0, %in, %cst : f32
      linalg.yield %1 : f32
    }
    return
  }
}

