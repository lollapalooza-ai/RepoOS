#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, 0)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d2)>
#map4 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map5 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map6 = affine_map<(d0, d1, d2, d3) -> (0, 0, d2, d3)>
#map7 = affine_map<(d0, d1, d2, d3) -> ()>
#map8 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
#map9 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, 0)>
module {
  memref.global "private" constant @__constant_xf32 : memref<f32> = dense<0xFF800000> {alignment = 64 : i64}
  func.func @main(%arg0: memref<128xf32, strided<[?], offset: ?>>, %arg1: memref<128xf32, strided<[?], offset: ?>>, %arg2: memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>, %arg3: memref<384x128xf32, strided<[?, ?], offset: ?>>, %arg4: memref<384xf32, strided<[?], offset: ?>>, %arg5: memref<1x1x1024x1024xf32, strided<[?, ?, ?, ?], offset: ?>>, %arg6: memref<128x128xf32, strided<[?, ?], offset: ?>>, %arg7: memref<128xf32, strided<[?], offset: ?>>, %arg8: memref<128xf32, strided<[?], offset: ?>>, %arg9: memref<128xf32, strided<[?], offset: ?>>, %arg10: memref<512x128xf32, strided<[?, ?], offset: ?>>, %arg11: memref<512xf32, strided<[?], offset: ?>>, %arg12: memref<128x512xf32, strided<[?, ?], offset: ?>>, %arg13: memref<128xf32, strided<[?], offset: ?>>, %arg14: memref<128xf32, strided<[?], offset: ?>>, %arg15: memref<128xf32, strided<[?], offset: ?>>, %arg16: memref<384x128xf32, strided<[?, ?], offset: ?>>, %arg17: memref<384xf32, strided<[?], offset: ?>>, %arg18: memref<1x1x1024x1024xf32, strided<[?, ?, ?, ?], offset: ?>>, %arg19: memref<128x128xf32, strided<[?, ?], offset: ?>>, %arg20: memref<128xf32, strided<[?], offset: ?>>, %arg21: memref<128xf32, strided<[?], offset: ?>>, %arg22: memref<128xf32, strided<[?], offset: ?>>, %arg23: memref<512x128xf32, strided<[?, ?], offset: ?>>, %arg24: memref<512xf32, strided<[?], offset: ?>>, %arg25: memref<128x512xf32, strided<[?, ?], offset: ?>>, %arg26: memref<128xf32, strided<[?], offset: ?>>, %arg27: memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) attributes {llvm.emit_c_interface} {
    %c0_i64 = arith.constant 0 : i64
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 0xFF800000 : f32
    %cst_1 = arith.constant 1.000000e+00 : f32
    %cst_2 = arith.constant 5.000000e-01 : f32
    %0 = memref.get_global @__constant_xf32 : memref<f32>
    %cst_3 = arith.constant 0.17677669529663687 : f64
    %cst_4 = arith.constant 1.000000e-05 : f64
    %cst_5 = arith.constant 1.280000e+02 : f32
    %cst_6 = arith.constant 1.41421354 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    %alloc_7 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_7 : memref<2x1024x1xf32>)
    %alloc_8 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    memref.copy %alloc_7, %alloc_8 : memref<2x1024x1xf32> to memref<2x1024x1xf32>
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg2 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) outs(%alloc_8 : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.addf %in, %out : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_8 : memref<2x1024x1xf32>) outs(%alloc : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.divf %in, %cst_5 : f32
      linalg.yield %1 : f32
    }
    %collapse_shape = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x1024x1xf32> into memref<2x1024xf32>
    linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapse_shape : memref<2x1024xf32>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    %alloc_9 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg2, %arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>, memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) outs(%alloc_9 : memref<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.subf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_9, %alloc_9 : memref<2x1024x128xf32>, memref<2x1024x128xf32>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.mulf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    %alloc_10 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    memref.copy %alloc_7, %alloc_10 : memref<2x1024x1xf32> to memref<2x1024x1xf32>
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) outs(%alloc_10 : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.addf %in, %out : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_10 : memref<2x1024x1xf32>) outs(%alloc : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.divf %in, %cst_5 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc : memref<2x1024x1xf32>) outs(%alloc : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.truncf %cst_4 : f64 to f32
      %2 = arith.addf %in, %1 : f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc : memref<2x1024x1xf32>) outs(%alloc : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = math.rsqrt %in : f32
      linalg.yield %1 : f32
    }
    %collapse_shape_11 = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x1024x1xf32> into memref<2x1024xf32>
    linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapse_shape_11 : memref<2x1024xf32>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_9, %arg27 : memref<2x1024x128xf32>, memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.mulf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg27, %arg0 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>, memref<128xf32, strided<[?], offset: ?>>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.mulf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg27, %arg1 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>, memref<128xf32, strided<[?], offset: ?>>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.addf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    %alloc_12 = memref.alloc() {alignment = 64 : i64} : memref<128x384xf32>
    linalg.transpose ins(%arg3 : memref<384x128xf32, strided<[?, ?], offset: ?>>) outs(%alloc_12 : memref<128x384xf32>) permutation = [1, 0] 
    %alloc_13 = memref.alloc() {alignment = 64 : i64} : memref<2x128x384xf32>
    linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_12 : memref<128x384xf32>) outs(%alloc_13 : memref<2x128x384xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    %alloc_14 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x384xf32>
    %alloc_15 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x384xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_15 : memref<2x1024x384xf32>)
    %alloc_16 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x384xf32>
    memref.copy %alloc_15, %alloc_16 : memref<2x1024x384xf32> to memref<2x1024x384xf32>
    %A_cast_0 = memref.cast %arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %B_cast_0 = memref.cast %alloc_13 : memref<2x128x384xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %C_cast_0 = memref.cast %alloc_16 : memref<2x1024x384xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    func.call @ukernel_bmm(%A_cast_0, %B_cast_0, %C_cast_0) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> ()
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_16, %arg4 : memref<2x1024x384xf32>, memref<384xf32, strided<[?], offset: ?>>) outs(%alloc_14 : memref<2x1024x384xf32>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.addf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    %subview = memref.subview %alloc_14[0, 0, 0] [2, 1024, 128] [1, 1, 1] : memref<2x1024x384xf32> to memref<2x1024x128xf32, strided<[393216, 384, 1]>>
    %subview_17 = memref.subview %alloc_14[0, 0, 128] [2, 1024, 128] [1, 1, 1] : memref<2x1024x384xf32> to memref<2x1024x128xf32, strided<[393216, 384, 1], offset: 128>>
    %subview_18 = memref.subview %alloc_14[0, 0, 256] [2, 1024, 128] [1, 1, 1] : memref<2x1024x384xf32> to memref<2x1024x128xf32, strided<[393216, 384, 1], offset: 256>>
    %expand_shape = memref.expand_shape %subview_17 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : memref<2x1024x128xf32, strided<[393216, 384, 1], offset: 128>> into memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 128>>
    %expand_shape_19 = memref.expand_shape %subview [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : memref<2x1024x128xf32, strided<[393216, 384, 1]>> into memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1]>>
    %alloc_20 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x32xf32>
    %alloc_21 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x32xf32>
    linalg.transpose ins(%expand_shape_19 : memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1]>>) outs(%alloc_21 : memref<2x4x1024x32xf32>) permutation = [0, 2, 1, 3] 
    %expand_shape_22 = memref.expand_shape %subview_18 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : memref<2x1024x128xf32, strided<[393216, 384, 1], offset: 256>> into memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 256>>
    linalg.transpose ins(%expand_shape_22 : memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 256>>) outs(%alloc_20 : memref<2x4x1024x32xf32>) permutation = [0, 2, 1, 3] 
    %alloc_23 = memref.alloc() {alignment = 64 : i64} : memref<2x4x32x1024xf32>
    linalg.transpose ins(%expand_shape : memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 128>>) outs(%alloc_23 : memref<2x4x32x1024xf32>) permutation = [0, 2, 3, 1] 
    %collapse_shape_24 = memref.collapse_shape %alloc_21 [[0, 1], [2], [3]] : memref<2x4x1024x32xf32> into memref<8x1024x32xf32>
    %collapse_shape_25 = memref.collapse_shape %alloc_23 [[0, 1], [2], [3]] : memref<2x4x32x1024xf32> into memref<8x32x1024xf32>
    %alloc_26 = memref.alloc() {alignment = 64 : i64} : memref<8x1024x1024xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_26 : memref<8x1024x1024xf32>)
    %alloc_27 = memref.alloc() {alignment = 64 : i64} : memref<8x1024x1024xf32>
    memref.copy %alloc_26, %alloc_27 : memref<8x1024x1024xf32> to memref<8x1024x1024xf32>
    %A_cast_1 = memref.cast %collapse_shape_24 : memref<8x1024x32xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %B_cast_1 = memref.cast %collapse_shape_25 : memref<8x32x1024xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %C_cast_1 = memref.cast %alloc_27 : memref<8x1024x1024xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    func.call @ukernel_bmm(%A_cast_1, %B_cast_1, %C_cast_1) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> ()
    %expand_shape_28 = memref.expand_shape %alloc_27 [[0, 1], [2], [3]] output_shape [2, 4, 1024, 1024] : memref<8x1024x1024xf32> into memref<2x4x1024x1024xf32>
    %alloc_29 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x1024xf32>
    linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%expand_shape_28 : memref<2x4x1024x1024xf32>) outs(%alloc_29 : memref<2x4x1024x1024xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.truncf %cst_3 : f64 to f32
      %2 = arith.mulf %in, %1 : f32
      linalg.yield %2 : f32
    }
    %alloc_30 = memref.alloc() {alignment = 64 : i64} : memref<1x1x1024x1024xi1>
    linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg5 : memref<1x1x1024x1024xf32, strided<[?, ?, ?, ?], offset: ?>>) outs(%alloc_30 : memref<1x1x1024x1024xi1>) {
    ^bb0(%in: f32, %out: i1):
      %1 = arith.cmpf oeq, %in, %cst : f32
      linalg.yield %1 : i1
    }
    linalg.generic {indexing_maps = [#map6, #map7, #map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%alloc_30, %0, %alloc_29 : memref<1x1x1024x1024xi1>, memref<f32>, memref<2x4x1024x1024xf32>) outs(%alloc_29 : memref<2x4x1024x1024xf32>) {
    ^bb0(%in: i1, %in_90: f32, %in_91: f32, %out: f32):
      %1 = arith.select %in, %in_90, %in_91 : f32
      linalg.yield %1 : f32
    }
    %alloc_31 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024xi64>
    linalg.fill ins(%c0_i64 : i64) outs(%alloc_31 : memref<2x4x1024xi64>)
    %alloc_32 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024xf32>
    linalg.fill ins(%cst_0 : f32) outs(%alloc_32 : memref<2x4x1024xf32>)
    %alloc_33 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024xf32>
    memref.copy %alloc_32, %alloc_33 : memref<2x4x1024xf32> to memref<2x4x1024xf32>
    %alloc_34 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024xi64>
    memref.copy %alloc_31, %alloc_34 : memref<2x4x1024xi64> to memref<2x4x1024xi64>
    linalg.generic {indexing_maps = [#map5, #map8, #map8], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%alloc_29 : memref<2x4x1024x1024xf32>) outs(%alloc_33, %alloc_34 : memref<2x4x1024xf32>, memref<2x4x1024xi64>) {
    ^bb0(%in: f32, %out: f32, %out_90: i64):
      %1 = linalg.index 3 : index
      %2 = arith.index_cast %1 : index to i64
      %3 = arith.maximumf %in, %out : f32
      %4 = arith.cmpf ogt, %in, %out : f32
      %5 = arith.select %4, %2, %out_90 : i64
      linalg.yield %3, %5 : f32, i64
    }
    %expand_shape_35 = memref.expand_shape %alloc_33 [[0], [1], [2, 3]] output_shape [2, 4, 1024, 1] : memref<2x4x1024xf32> into memref<2x4x1024x1xf32>
    linalg.generic {indexing_maps = [#map5, #map9, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%alloc_29, %expand_shape_35 : memref<2x4x1024x1024xf32>, memref<2x4x1024x1xf32>) outs(%alloc_29 : memref<2x4x1024x1024xf32>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.subf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%alloc_29 : memref<2x4x1024x1024xf32>) outs(%alloc_29 : memref<2x4x1024x1024xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = math.exp %in : f32
      linalg.yield %1 : f32
    }
    %alloc_36 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x1xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_36 : memref<2x4x1024x1xf32>)
    %alloc_37 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x1xf32>
    memref.copy %alloc_36, %alloc_37 : memref<2x4x1024x1xf32> to memref<2x4x1024x1xf32>
    linalg.generic {indexing_maps = [#map5, #map9], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%alloc_29 : memref<2x4x1024x1024xf32>) outs(%alloc_37 : memref<2x4x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.addf %in, %out : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map5, #map9, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%alloc_29, %alloc_37 : memref<2x4x1024x1024xf32>, memref<2x4x1024x1xf32>) outs(%alloc_29 : memref<2x4x1024x1024xf32>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.divf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    %collapse_shape_38 = memref.collapse_shape %alloc_29 [[0, 1], [2], [3]] : memref<2x4x1024x1024xf32> into memref<8x1024x1024xf32>
    %collapse_shape_39 = memref.collapse_shape %alloc_20 [[0, 1], [2], [3]] : memref<2x4x1024x32xf32> into memref<8x1024x32xf32>
    %alloc_40 = memref.alloc() {alignment = 64 : i64} : memref<8x1024x32xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_40 : memref<8x1024x32xf32>)
    %alloc_41 = memref.alloc() {alignment = 64 : i64} : memref<8x1024x32xf32>
    memref.copy %alloc_40, %alloc_41 : memref<8x1024x32xf32> to memref<8x1024x32xf32>
    %A_cast_2 = memref.cast %collapse_shape_38 : memref<8x1024x1024xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %B_cast_2 = memref.cast %collapse_shape_39 : memref<8x1024x32xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %C_cast_2 = memref.cast %alloc_41 : memref<8x1024x32xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    func.call @ukernel_bmm(%A_cast_2, %B_cast_2, %C_cast_2) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> ()
    %expand_shape_42 = memref.expand_shape %alloc_41 [[0, 1], [2], [3]] output_shape [2, 4, 1024, 32] : memref<8x1024x32xf32> into memref<2x4x1024x32xf32>
    %alloc_43 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x4x32xf32>
    linalg.transpose ins(%expand_shape_42 : memref<2x4x1024x32xf32>) outs(%alloc_43 : memref<2x1024x4x32xf32>) permutation = [0, 2, 1, 3] 
    %collapse_shape_44 = memref.collapse_shape %alloc_43 [[0], [1], [2, 3]] : memref<2x1024x4x32xf32> into memref<2x1024x128xf32>
    %alloc_45 = memref.alloc() {alignment = 64 : i64} : memref<128x128xf32>
    linalg.transpose ins(%arg6 : memref<128x128xf32, strided<[?, ?], offset: ?>>) outs(%alloc_45 : memref<128x128xf32>) permutation = [1, 0] 
    %alloc_46 = memref.alloc() {alignment = 64 : i64} : memref<2x128x128xf32>
    linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_45 : memref<128x128xf32>) outs(%alloc_46 : memref<2x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    %alloc_47 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_47 : memref<2x1024x128xf32>)
    %alloc_48 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    memref.copy %alloc_47, %alloc_48 : memref<2x1024x128xf32> to memref<2x1024x128xf32>
    %A_cast_3 = memref.cast %collapse_shape_44 : memref<2x1024x128xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %B_cast_3 = memref.cast %alloc_46 : memref<2x128x128xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %C_cast_3 = memref.cast %alloc_48 : memref<2x1024x128xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    func.call @ukernel_bmm(%A_cast_3, %B_cast_3, %C_cast_3) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> ()
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_48, %arg7 : memref<2x1024x128xf32>, memref<128xf32, strided<[?], offset: ?>>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.addf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    %alloc_49 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg2, %arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>, memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) outs(%alloc_49 : memref<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.addf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    %alloc_50 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    memref.copy %alloc_7, %alloc_50 : memref<2x1024x1xf32> to memref<2x1024x1xf32>
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%alloc_49 : memref<2x1024x128xf32>) outs(%alloc_50 : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.addf %in, %out : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_50 : memref<2x1024x1xf32>) outs(%alloc : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.divf %in, %cst_5 : f32
      linalg.yield %1 : f32
    }
    %collapse_shape_51 = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x1024x1xf32> into memref<2x1024xf32>
    linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapse_shape_51 : memref<2x1024xf32>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    %alloc_52 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_49, %arg27 : memref<2x1024x128xf32>, memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) outs(%alloc_52 : memref<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.subf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_52, %alloc_52 : memref<2x1024x128xf32>, memref<2x1024x128xf32>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.mulf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    %alloc_53 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    memref.copy %alloc_7, %alloc_53 : memref<2x1024x1xf32> to memref<2x1024x1xf32>
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) outs(%alloc_53 : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.addf %in, %out : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_53 : memref<2x1024x1xf32>) outs(%alloc : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.divf %in, %cst_5 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc : memref<2x1024x1xf32>) outs(%alloc : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.truncf %cst_4 : f64 to f32
      %2 = arith.addf %in, %1 : f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc : memref<2x1024x1xf32>) outs(%alloc : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = math.rsqrt %in : f32
      linalg.yield %1 : f32
    }
    %collapse_shape_54 = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x1024x1xf32> into memref<2x1024xf32>
    linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapse_shape_54 : memref<2x1024xf32>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_52, %arg27 : memref<2x1024x128xf32>, memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.mulf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg27, %arg8 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>, memref<128xf32, strided<[?], offset: ?>>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.mulf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg27, %arg9 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>, memref<128xf32, strided<[?], offset: ?>>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.addf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    %alloc_55 = memref.alloc() {alignment = 64 : i64} : memref<128x512xf32>
    linalg.transpose ins(%arg10 : memref<512x128xf32, strided<[?, ?], offset: ?>>) outs(%alloc_55 : memref<128x512xf32>) permutation = [1, 0] 
    %alloc_56 = memref.alloc() {alignment = 64 : i64} : memref<2x128x512xf32>
    linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_55 : memref<128x512xf32>) outs(%alloc_56 : memref<2x128x512xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    %alloc_57 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x512xf32>
    %alloc_58 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x512xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_58 : memref<2x1024x512xf32>)
    %alloc_59 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x512xf32>
    memref.copy %alloc_58, %alloc_59 : memref<2x1024x512xf32> to memref<2x1024x512xf32>
    %A_cast_4 = memref.cast %arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %B_cast_4 = memref.cast %alloc_56 : memref<2x128x512xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %C_cast_4 = memref.cast %alloc_59 : memref<2x1024x512xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    func.call @ukernel_bmm(%A_cast_4, %B_cast_4, %C_cast_4) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> ()
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_59, %arg11 : memref<2x1024x512xf32>, memref<512xf32, strided<[?], offset: ?>>) outs(%alloc_57 : memref<2x1024x512xf32>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.addf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_57 : memref<2x1024x512xf32>) outs(%alloc_57 : memref<2x1024x512xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.divf %in, %cst_6 : f32
      %2 = math.erf %1 : f32
      %3 = arith.addf %2, %cst_1 : f32
      %4 = arith.mulf %3, %cst_2 : f32
      %5 = arith.mulf %in, %4 : f32
      linalg.yield %5 : f32
    }
    %alloc_60 = memref.alloc() {alignment = 64 : i64} : memref<512x128xf32>
    linalg.transpose ins(%arg12 : memref<128x512xf32, strided<[?, ?], offset: ?>>) outs(%alloc_60 : memref<512x128xf32>) permutation = [1, 0] 
    %alloc_61 = memref.alloc() {alignment = 64 : i64} : memref<2x512x128xf32>
    linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_60 : memref<512x128xf32>) outs(%alloc_61 : memref<2x512x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    %alloc_62 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    memref.copy %alloc_47, %alloc_62 : memref<2x1024x128xf32> to memref<2x1024x128xf32>
    %A_cast_5 = memref.cast %alloc_57 : memref<2x1024x512xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %B_cast_5 = memref.cast %alloc_61 : memref<2x512x128xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %C_cast_5 = memref.cast %alloc_62 : memref<2x1024x128xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    func.call @ukernel_bmm(%A_cast_5, %B_cast_5, %C_cast_5) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> ()
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_62, %arg13 : memref<2x1024x128xf32>, memref<128xf32, strided<[?], offset: ?>>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.addf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    %alloc_63 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_49, %arg27 : memref<2x1024x128xf32>, memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) outs(%alloc_63 : memref<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.addf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    %alloc_64 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    memref.copy %alloc_7, %alloc_64 : memref<2x1024x1xf32> to memref<2x1024x1xf32>
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%alloc_63 : memref<2x1024x128xf32>) outs(%alloc_64 : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.addf %in, %out : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_64 : memref<2x1024x1xf32>) outs(%alloc : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.divf %in, %cst_5 : f32
      linalg.yield %1 : f32
    }
    %collapse_shape_65 = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x1024x1xf32> into memref<2x1024xf32>
    linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapse_shape_65 : memref<2x1024xf32>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    %alloc_66 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_63, %arg27 : memref<2x1024x128xf32>, memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) outs(%alloc_66 : memref<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.subf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_66, %alloc_66 : memref<2x1024x128xf32>, memref<2x1024x128xf32>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.mulf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    %alloc_67 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    memref.copy %alloc_7, %alloc_67 : memref<2x1024x1xf32> to memref<2x1024x1xf32>
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) outs(%alloc_67 : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.addf %in, %out : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_67 : memref<2x1024x1xf32>) outs(%alloc : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.divf %in, %cst_5 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc : memref<2x1024x1xf32>) outs(%alloc : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.truncf %cst_4 : f64 to f32
      %2 = arith.addf %in, %1 : f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc : memref<2x1024x1xf32>) outs(%alloc : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = math.rsqrt %in : f32
      linalg.yield %1 : f32
    }
    %collapse_shape_68 = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x1024x1xf32> into memref<2x1024xf32>
    linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapse_shape_68 : memref<2x1024xf32>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_66, %arg27 : memref<2x1024x128xf32>, memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.mulf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg27, %arg14 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>, memref<128xf32, strided<[?], offset: ?>>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.mulf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg27, %arg15 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>, memref<128xf32, strided<[?], offset: ?>>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.addf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.transpose ins(%arg16 : memref<384x128xf32, strided<[?, ?], offset: ?>>) outs(%alloc_12 : memref<128x384xf32>) permutation = [1, 0] 
    linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_12 : memref<128x384xf32>) outs(%alloc_13 : memref<2x128x384xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    %A_cast_6 = memref.cast %arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %B_cast_6 = memref.cast %alloc_13 : memref<2x128x384xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %C_cast_6 = memref.cast %alloc_15 : memref<2x1024x384xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    func.call @ukernel_bmm(%A_cast_6, %B_cast_6, %C_cast_6) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> ()
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_15, %arg17 : memref<2x1024x384xf32>, memref<384xf32, strided<[?], offset: ?>>) outs(%alloc_14 : memref<2x1024x384xf32>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.addf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    %subview_69 = memref.subview %alloc_14[0, 0, 0] [2, 1024, 128] [1, 1, 1] : memref<2x1024x384xf32> to memref<2x1024x128xf32, strided<[393216, 384, 1]>>
    %subview_70 = memref.subview %alloc_14[0, 0, 128] [2, 1024, 128] [1, 1, 1] : memref<2x1024x384xf32> to memref<2x1024x128xf32, strided<[393216, 384, 1], offset: 128>>
    %subview_71 = memref.subview %alloc_14[0, 0, 256] [2, 1024, 128] [1, 1, 1] : memref<2x1024x384xf32> to memref<2x1024x128xf32, strided<[393216, 384, 1], offset: 256>>
    %expand_shape_72 = memref.expand_shape %subview_70 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : memref<2x1024x128xf32, strided<[393216, 384, 1], offset: 128>> into memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 128>>
    %expand_shape_73 = memref.expand_shape %subview_69 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : memref<2x1024x128xf32, strided<[393216, 384, 1]>> into memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1]>>
    %alloc_74 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x32xf32>
    linalg.transpose ins(%expand_shape_73 : memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1]>>) outs(%alloc_74 : memref<2x4x1024x32xf32>) permutation = [0, 2, 1, 3] 
    %expand_shape_75 = memref.expand_shape %subview_71 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : memref<2x1024x128xf32, strided<[393216, 384, 1], offset: 256>> into memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 256>>
    linalg.transpose ins(%expand_shape_75 : memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 256>>) outs(%alloc_20 : memref<2x4x1024x32xf32>) permutation = [0, 2, 1, 3] 
    linalg.transpose ins(%expand_shape_72 : memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 128>>) outs(%alloc_23 : memref<2x4x32x1024xf32>) permutation = [0, 2, 3, 1] 
    %collapse_shape_76 = memref.collapse_shape %alloc_74 [[0, 1], [2], [3]] : memref<2x4x1024x32xf32> into memref<8x1024x32xf32>
    %collapse_shape_77 = memref.collapse_shape %alloc_23 [[0, 1], [2], [3]] : memref<2x4x32x1024xf32> into memref<8x32x1024xf32>
    %A_cast_7 = memref.cast %collapse_shape_76 : memref<8x1024x32xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %B_cast_7 = memref.cast %collapse_shape_77 : memref<8x32x1024xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %C_cast_7 = memref.cast %alloc_26 : memref<8x1024x1024xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    func.call @ukernel_bmm(%A_cast_7, %B_cast_7, %C_cast_7) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> ()
    %expand_shape_78 = memref.expand_shape %alloc_26 [[0, 1], [2], [3]] output_shape [2, 4, 1024, 1024] : memref<8x1024x1024xf32> into memref<2x4x1024x1024xf32>
    linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%expand_shape_78 : memref<2x4x1024x1024xf32>) outs(%alloc_29 : memref<2x4x1024x1024xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.truncf %cst_3 : f64 to f32
      %2 = arith.mulf %in, %1 : f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg18 : memref<1x1x1024x1024xf32, strided<[?, ?, ?, ?], offset: ?>>) outs(%alloc_30 : memref<1x1x1024x1024xi1>) {
    ^bb0(%in: f32, %out: i1):
      %1 = arith.cmpf oeq, %in, %cst : f32
      linalg.yield %1 : i1
    }
    linalg.generic {indexing_maps = [#map6, #map7, #map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%alloc_30, %0, %alloc_29 : memref<1x1x1024x1024xi1>, memref<f32>, memref<2x4x1024x1024xf32>) outs(%alloc_29 : memref<2x4x1024x1024xf32>) {
    ^bb0(%in: i1, %in_90: f32, %in_91: f32, %out: f32):
      %1 = arith.select %in, %in_90, %in_91 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map5, #map8, #map8], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%alloc_29 : memref<2x4x1024x1024xf32>) outs(%alloc_32, %alloc_31 : memref<2x4x1024xf32>, memref<2x4x1024xi64>) {
    ^bb0(%in: f32, %out: f32, %out_90: i64):
      %1 = linalg.index 3 : index
      %2 = arith.index_cast %1 : index to i64
      %3 = arith.maximumf %in, %out : f32
      %4 = arith.cmpf ogt, %in, %out : f32
      %5 = arith.select %4, %2, %out_90 : i64
      linalg.yield %3, %5 : f32, i64
    }
    %expand_shape_79 = memref.expand_shape %alloc_32 [[0], [1], [2, 3]] output_shape [2, 4, 1024, 1] : memref<2x4x1024xf32> into memref<2x4x1024x1xf32>
    linalg.generic {indexing_maps = [#map5, #map9, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%alloc_29, %expand_shape_79 : memref<2x4x1024x1024xf32>, memref<2x4x1024x1xf32>) outs(%alloc_29 : memref<2x4x1024x1024xf32>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.subf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%alloc_29 : memref<2x4x1024x1024xf32>) outs(%alloc_29 : memref<2x4x1024x1024xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = math.exp %in : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map5, #map9], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%alloc_29 : memref<2x4x1024x1024xf32>) outs(%alloc_36 : memref<2x4x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.addf %in, %out : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map5, #map9, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%alloc_29, %alloc_36 : memref<2x4x1024x1024xf32>, memref<2x4x1024x1xf32>) outs(%alloc_29 : memref<2x4x1024x1024xf32>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.divf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    %collapse_shape_80 = memref.collapse_shape %alloc_29 [[0, 1], [2], [3]] : memref<2x4x1024x1024xf32> into memref<8x1024x1024xf32>
    %collapse_shape_81 = memref.collapse_shape %alloc_20 [[0, 1], [2], [3]] : memref<2x4x1024x32xf32> into memref<8x1024x32xf32>
    %A_cast_8 = memref.cast %collapse_shape_80 : memref<8x1024x1024xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %B_cast_8 = memref.cast %collapse_shape_81 : memref<8x1024x32xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %C_cast_8 = memref.cast %alloc_40 : memref<8x1024x32xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    func.call @ukernel_bmm(%A_cast_8, %B_cast_8, %C_cast_8) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> ()
    %expand_shape_82 = memref.expand_shape %alloc_40 [[0, 1], [2], [3]] output_shape [2, 4, 1024, 32] : memref<8x1024x32xf32> into memref<2x4x1024x32xf32>
    linalg.transpose ins(%expand_shape_82 : memref<2x4x1024x32xf32>) outs(%alloc_43 : memref<2x1024x4x32xf32>) permutation = [0, 2, 1, 3] 
    %collapse_shape_83 = memref.collapse_shape %alloc_43 [[0], [1], [2, 3]] : memref<2x1024x4x32xf32> into memref<2x1024x128xf32>
    linalg.transpose ins(%arg19 : memref<128x128xf32, strided<[?, ?], offset: ?>>) outs(%alloc_45 : memref<128x128xf32>) permutation = [1, 0] 
    linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_45 : memref<128x128xf32>) outs(%alloc_46 : memref<2x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    %alloc_84 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    memref.copy %alloc_47, %alloc_84 : memref<2x1024x128xf32> to memref<2x1024x128xf32>
    %A_cast_9 = memref.cast %collapse_shape_83 : memref<2x1024x128xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %B_cast_9 = memref.cast %alloc_46 : memref<2x128x128xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %C_cast_9 = memref.cast %alloc_84 : memref<2x1024x128xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    func.call @ukernel_bmm(%A_cast_9, %B_cast_9, %C_cast_9) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> ()
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_84, %arg20 : memref<2x1024x128xf32>, memref<128xf32, strided<[?], offset: ?>>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.addf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    %alloc_85 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_63, %arg27 : memref<2x1024x128xf32>, memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) outs(%alloc_85 : memref<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.addf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    %alloc_86 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    memref.copy %alloc_7, %alloc_86 : memref<2x1024x1xf32> to memref<2x1024x1xf32>
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%alloc_85 : memref<2x1024x128xf32>) outs(%alloc_86 : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.addf %in, %out : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_86 : memref<2x1024x1xf32>) outs(%alloc : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.divf %in, %cst_5 : f32
      linalg.yield %1 : f32
    }
    %collapse_shape_87 = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x1024x1xf32> into memref<2x1024xf32>
    linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapse_shape_87 : memref<2x1024xf32>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    %alloc_88 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_85, %arg27 : memref<2x1024x128xf32>, memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) outs(%alloc_88 : memref<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.subf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_88, %alloc_88 : memref<2x1024x128xf32>, memref<2x1024x128xf32>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.mulf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) outs(%alloc_7 : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.addf %in, %out : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_7 : memref<2x1024x1xf32>) outs(%alloc : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.divf %in, %cst_5 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc : memref<2x1024x1xf32>) outs(%alloc : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.truncf %cst_4 : f64 to f32
      %2 = arith.addf %in, %1 : f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc : memref<2x1024x1xf32>) outs(%alloc : memref<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = math.rsqrt %in : f32
      linalg.yield %1 : f32
    }
    %collapse_shape_89 = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x1024x1xf32> into memref<2x1024xf32>
    linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapse_shape_89 : memref<2x1024xf32>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_88, %arg27 : memref<2x1024x128xf32>, memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.mulf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg27, %arg21 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>, memref<128xf32, strided<[?], offset: ?>>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.mulf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg27, %arg22 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>, memref<128xf32, strided<[?], offset: ?>>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.addf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.transpose ins(%arg23 : memref<512x128xf32, strided<[?, ?], offset: ?>>) outs(%alloc_55 : memref<128x512xf32>) permutation = [1, 0] 
    linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_55 : memref<128x512xf32>) outs(%alloc_56 : memref<2x128x512xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    %A_cast_10 = memref.cast %arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %B_cast_10 = memref.cast %alloc_56 : memref<2x128x512xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %C_cast_10 = memref.cast %alloc_58 : memref<2x1024x512xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    func.call @ukernel_bmm(%A_cast_10, %B_cast_10, %C_cast_10) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> ()
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_58, %arg24 : memref<2x1024x512xf32>, memref<512xf32, strided<[?], offset: ?>>) outs(%alloc_57 : memref<2x1024x512xf32>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.addf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_57 : memref<2x1024x512xf32>) outs(%alloc_57 : memref<2x1024x512xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.divf %in, %cst_6 : f32
      %2 = math.erf %1 : f32
      %3 = arith.addf %2, %cst_1 : f32
      %4 = arith.mulf %3, %cst_2 : f32
      %5 = arith.mulf %in, %4 : f32
      linalg.yield %5 : f32
    }
    linalg.transpose ins(%arg25 : memref<128x512xf32, strided<[?, ?], offset: ?>>) outs(%alloc_60 : memref<512x128xf32>) permutation = [1, 0] 
    linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_60 : memref<512x128xf32>) outs(%alloc_61 : memref<2x512x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    %A_cast_11 = memref.cast %alloc_57 : memref<2x1024x512xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %B_cast_11 = memref.cast %alloc_61 : memref<2x512x128xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %C_cast_11 = memref.cast %alloc_47 : memref<2x1024x128xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    func.call @ukernel_bmm(%A_cast_11, %B_cast_11, %C_cast_11) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> ()
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_47, %arg26 : memref<2x1024x128xf32>, memref<128xf32, strided<[?], offset: ?>>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.addf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_85, %arg27 : memref<2x1024x128xf32>, memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) outs(%arg27 : memref<2x1024x128xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %in_90: f32, %out: f32):
      %1 = arith.addf %in, %in_90 : f32
      linalg.yield %1 : f32
    }
    return
  }
func.func private @ukernel_bmm(memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>)
}

