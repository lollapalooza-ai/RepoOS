#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @main(%arg0: memref<10x10xf32, strided<[?, ?], offset: ?>>) -> memref<10x10xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10x10xf32>
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : memref<10x10xf32, strided<[?, ?], offset: ?>>) outs(%alloc : memref<10x10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %0 = arith.addf %in, %cst_0 : f32
      linalg.yield %0 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%alloc : memref<10x10xf32>) outs(%alloc : memref<10x10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %0 = arith.cmpf ugt, %in, %cst : f32
      %1 = arith.select %0, %in, %cst : f32
      linalg.yield %1 : f32
    }
    %cast = memref.cast %alloc : memref<10x10xf32> to memref<10x10xf32, strided<[?, ?], offset: ?>>
    return %alloc : memref<10x10xf32>
  }
}

