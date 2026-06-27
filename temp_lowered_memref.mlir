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
  func.func @main(%arg0: memref<128xf32>, %arg1: memref<128xf32>, %arg2: memref<2x8x128xf32>, %arg3: memref<384x128xf32>, %arg4: memref<384xf32>, %arg5: memref<1x1x128x128xf32>, %arg6: memref<128x128xf32>, %arg7: memref<128xf32>, %arg8: memref<128xf32>, %arg9: memref<128xf32>, %arg10: memref<512x128xf32>, %arg11: memref<512xf32>, %arg12: memref<128x512xf32>, %arg13: memref<128xf32>, %arg14: memref<2x8x128xf32>) attributes {llvm.emit_c_interface} {
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
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<2x8x1xf32>
    %alloc_7 = memref.alloc() {alignment = 64 : i64} : memref<2x8x1xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_7 : memref<2x8x1xf32>)
    %alloc_8 = memref.alloc() {alignment = 64 : i64} : memref<2x8x1xf32>
    linalg.copy ins(%alloc_7 : memref<2x8x1xf32>) outs(%alloc_8 : memref<2x8x1xf32>)
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg2 : memref<2x8x128xf32>) outs(%alloc_8 : memref<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.addf %in, %out : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_8 : memref<2x8x1xf32>) outs(%alloc : memref<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.divf %in, %cst_5 : f32
      linalg.yield %1 : f32
    }
    %collapse_shape = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x8x1xf32> into memref<2x8xf32>
    linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapse_shape : memref<2x8xf32>) outs(%arg14 : memref<2x8x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    %alloc_9 = memref.alloc() {alignment = 64 : i64} : memref<2x8x128xf32>
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg2, %arg14 : memref<2x8x128xf32>, memref<2x8x128xf32>) outs(%alloc_9 : memref<2x8x128xf32>) {
    ^bb0(%in: f32, %in_54: f32, %out: f32):
      %1 = arith.subf %in, %in_54 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_9, %alloc_9 : memref<2x8x128xf32>, memref<2x8x128xf32>) outs(%arg14 : memref<2x8x128xf32>) {
    ^bb0(%in: f32, %in_54: f32, %out: f32):
      %1 = arith.mulf %in, %in_54 : f32
      linalg.yield %1 : f32
    }
    %alloc_10 = memref.alloc() {alignment = 64 : i64} : memref<2x8x1xf32>
    linalg.copy ins(%alloc_7 : memref<2x8x1xf32>) outs(%alloc_10 : memref<2x8x1xf32>)
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg14 : memref<2x8x128xf32>) outs(%alloc_10 : memref<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.addf %in, %out : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_10 : memref<2x8x1xf32>) outs(%alloc : memref<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.divf %in, %cst_5 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc : memref<2x8x1xf32>) outs(%alloc : memref<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.truncf %cst_4 : f64 to f32
      %2 = arith.addf %in, %1 : f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc : memref<2x8x1xf32>) outs(%alloc : memref<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = math.rsqrt %in : f32
      linalg.yield %1 : f32
    }
    %collapse_shape_11 = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x8x1xf32> into memref<2x8xf32>
    linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapse_shape_11 : memref<2x8xf32>) outs(%arg14 : memref<2x8x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_9, %arg14 : memref<2x8x128xf32>, memref<2x8x128xf32>) outs(%arg14 : memref<2x8x128xf32>) {
    ^bb0(%in: f32, %in_54: f32, %out: f32):
      %1 = arith.mulf %in, %in_54 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg14, %arg0 : memref<2x8x128xf32>, memref<128xf32>) outs(%arg14 : memref<2x8x128xf32>) {
    ^bb0(%in: f32, %in_54: f32, %out: f32):
      %1 = arith.mulf %in, %in_54 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg14, %arg1 : memref<2x8x128xf32>, memref<128xf32>) outs(%arg14 : memref<2x8x128xf32>) {
    ^bb0(%in: f32, %in_54: f32, %out: f32):
      %1 = arith.addf %in, %in_54 : f32
      linalg.yield %1 : f32
    }
    %alloc_12 = memref.alloc() {alignment = 64 : i64} : memref<128x384xf32>
    linalg.transpose ins(%arg3 : memref<384x128xf32>) outs(%alloc_12 : memref<128x384xf32>) permutation = [1, 0] 
    %alloc_13 = memref.alloc() {alignment = 64 : i64} : memref<2x128x384xf32>
    linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_12 : memref<128x384xf32>) outs(%alloc_13 : memref<2x128x384xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    %alloc_14 = memref.alloc() {alignment = 64 : i64} : memref<2x8x384xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_14 : memref<2x8x384xf32>)
    linalg.batch_matmul ins(%arg14, %alloc_13 : memref<2x8x128xf32>, memref<2x128x384xf32>) outs(%alloc_14 : memref<2x8x384xf32>)
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_14, %arg4 : memref<2x8x384xf32>, memref<384xf32>) outs(%alloc_14 : memref<2x8x384xf32>) {
    ^bb0(%in: f32, %in_54: f32, %out: f32):
      %1 = arith.addf %in, %in_54 : f32
      linalg.yield %1 : f32
    }
    %subview = memref.subview %alloc_14[0, 0, 0] [2, 8, 128] [1, 1, 1] : memref<2x8x384xf32> to memref<2x8x128xf32, strided<[3072, 384, 1]>>
    %subview_15 = memref.subview %alloc_14[0, 0, 128] [2, 8, 128] [1, 1, 1] : memref<2x8x384xf32> to memref<2x8x128xf32, strided<[3072, 384, 1], offset: 128>>
    %subview_16 = memref.subview %alloc_14[0, 0, 256] [2, 8, 128] [1, 1, 1] : memref<2x8x384xf32> to memref<2x8x128xf32, strided<[3072, 384, 1], offset: 256>>
    %expand_shape = memref.expand_shape %subview_15 [[0], [1], [2, 3]] output_shape [2, 8, 4, 32] : memref<2x8x128xf32, strided<[3072, 384, 1], offset: 128>> into memref<2x8x4x32xf32, strided<[3072, 384, 32, 1], offset: 128>>
    %expand_shape_17 = memref.expand_shape %subview [[0], [1], [2, 3]] output_shape [2, 8, 4, 32] : memref<2x8x128xf32, strided<[3072, 384, 1]>> into memref<2x8x4x32xf32, strided<[3072, 384, 32, 1]>>
    %alloc_18 = memref.alloc() {alignment = 64 : i64} : memref<2x4x8x32xf32>
    %alloc_19 = memref.alloc() {alignment = 64 : i64} : memref<2x4x8x32xf32>
    linalg.transpose ins(%expand_shape_17 : memref<2x8x4x32xf32, strided<[3072, 384, 32, 1]>>) outs(%alloc_19 : memref<2x4x8x32xf32>) permutation = [0, 2, 1, 3] 
    %expand_shape_20 = memref.expand_shape %subview_16 [[0], [1], [2, 3]] output_shape [2, 8, 4, 32] : memref<2x8x128xf32, strided<[3072, 384, 1], offset: 256>> into memref<2x8x4x32xf32, strided<[3072, 384, 32, 1], offset: 256>>
    linalg.transpose ins(%expand_shape_20 : memref<2x8x4x32xf32, strided<[3072, 384, 32, 1], offset: 256>>) outs(%alloc_18 : memref<2x4x8x32xf32>) permutation = [0, 2, 1, 3] 
    %alloc_21 = memref.alloc() {alignment = 64 : i64} : memref<2x4x32x8xf32>
    linalg.transpose ins(%expand_shape : memref<2x8x4x32xf32, strided<[3072, 384, 32, 1], offset: 128>>) outs(%alloc_21 : memref<2x4x32x8xf32>) permutation = [0, 2, 3, 1] 
    %collapse_shape_22 = memref.collapse_shape %alloc_19 [[0, 1], [2], [3]] : memref<2x4x8x32xf32> into memref<8x8x32xf32>
    %collapse_shape_23 = memref.collapse_shape %alloc_21 [[0, 1], [2], [3]] : memref<2x4x32x8xf32> into memref<8x32x8xf32>
    %alloc_24 = memref.alloc() {alignment = 64 : i64} : memref<8x8x8xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_24 : memref<8x8x8xf32>)
    linalg.batch_matmul ins(%collapse_shape_22, %collapse_shape_23 : memref<8x8x32xf32>, memref<8x32x8xf32>) outs(%alloc_24 : memref<8x8x8xf32>)
    %expand_shape_25 = memref.expand_shape %alloc_24 [[0, 1], [2], [3]] output_shape [2, 4, 8, 8] : memref<8x8x8xf32> into memref<2x4x8x8xf32>
    %alloc_26 = memref.alloc() {alignment = 64 : i64} : memref<2x4x8x8xf32>
    linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%expand_shape_25 : memref<2x4x8x8xf32>) outs(%alloc_26 : memref<2x4x8x8xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.truncf %cst_3 : f64 to f32
      %2 = arith.mulf %in, %1 : f32
      linalg.yield %2 : f32
    }
    %subview_27 = memref.subview %arg5[0, 0, 0, 0] [1, 1, 8, 128] [1, 1, 1, 1] : memref<1x1x128x128xf32> to memref<1x1x8x128xf32, strided<[16384, 16384, 128, 1]>>
    %subview_28 = memref.subview %subview_27[0, 0, 0, 0] [1, 1, 8, 8] [1, 1, 1, 1] : memref<1x1x8x128xf32, strided<[16384, 16384, 128, 1]>> to memref<1x1x8x8xf32, strided<[16384, 16384, 128, 1]>>
    %alloc_29 = memref.alloc() {alignment = 64 : i64} : memref<1x1x8x8xi1>
    linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%subview_28 : memref<1x1x8x8xf32, strided<[16384, 16384, 128, 1]>>) outs(%alloc_29 : memref<1x1x8x8xi1>) {
    ^bb0(%in: f32, %out: i1):
      %1 = arith.cmpf oeq, %in, %cst : f32
      linalg.yield %1 : i1
    }
    linalg.generic {indexing_maps = [#map6, #map7, #map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%alloc_29, %0, %alloc_26 : memref<1x1x8x8xi1>, memref<f32>, memref<2x4x8x8xf32>) outs(%alloc_26 : memref<2x4x8x8xf32>) {
    ^bb0(%in: i1, %in_54: f32, %in_55: f32, %out: f32):
      %1 = arith.select %in, %in_54, %in_55 : f32
      linalg.yield %1 : f32
    }
    %alloc_30 = memref.alloc() {alignment = 64 : i64} : memref<2x4x8xi64>
    linalg.fill ins(%c0_i64 : i64) outs(%alloc_30 : memref<2x4x8xi64>)
    %alloc_31 = memref.alloc() {alignment = 64 : i64} : memref<2x4x8xf32>
    linalg.fill ins(%cst_0 : f32) outs(%alloc_31 : memref<2x4x8xf32>)
    linalg.generic {indexing_maps = [#map5, #map8, #map8], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%alloc_26 : memref<2x4x8x8xf32>) outs(%alloc_31, %alloc_30 : memref<2x4x8xf32>, memref<2x4x8xi64>) {
    ^bb0(%in: f32, %out: f32, %out_54: i64):
      %1 = linalg.index 3 : index
      %2 = arith.index_cast %1 : index to i64
      %3 = arith.maximumf %in, %out : f32
      %4 = arith.cmpf ogt, %in, %out : f32
      %5 = arith.select %4, %2, %out_54 : i64
      linalg.yield %3, %5 : f32, i64
    }
    %expand_shape_32 = memref.expand_shape %alloc_31 [[0], [1], [2, 3]] output_shape [2, 4, 8, 1] : memref<2x4x8xf32> into memref<2x4x8x1xf32>
    linalg.generic {indexing_maps = [#map5, #map9, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%alloc_26, %expand_shape_32 : memref<2x4x8x8xf32>, memref<2x4x8x1xf32>) outs(%alloc_26 : memref<2x4x8x8xf32>) {
    ^bb0(%in: f32, %in_54: f32, %out: f32):
      %1 = arith.subf %in, %in_54 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%alloc_26 : memref<2x4x8x8xf32>) outs(%alloc_26 : memref<2x4x8x8xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = math.exp %in : f32
      linalg.yield %1 : f32
    }
    %alloc_33 = memref.alloc() {alignment = 64 : i64} : memref<2x4x8x1xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_33 : memref<2x4x8x1xf32>)
    linalg.generic {indexing_maps = [#map5, #map9], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%alloc_26 : memref<2x4x8x8xf32>) outs(%alloc_33 : memref<2x4x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.addf %in, %out : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map5, #map9, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%alloc_26, %alloc_33 : memref<2x4x8x8xf32>, memref<2x4x8x1xf32>) outs(%alloc_26 : memref<2x4x8x8xf32>) {
    ^bb0(%in: f32, %in_54: f32, %out: f32):
      %1 = arith.divf %in, %in_54 : f32
      linalg.yield %1 : f32
    }
    %collapse_shape_34 = memref.collapse_shape %alloc_26 [[0, 1], [2], [3]] : memref<2x4x8x8xf32> into memref<8x8x8xf32>
    %collapse_shape_35 = memref.collapse_shape %alloc_18 [[0, 1], [2], [3]] : memref<2x4x8x32xf32> into memref<8x8x32xf32>
    %alloc_36 = memref.alloc() {alignment = 64 : i64} : memref<8x8x32xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_36 : memref<8x8x32xf32>)
    linalg.batch_matmul ins(%collapse_shape_34, %collapse_shape_35 : memref<8x8x8xf32>, memref<8x8x32xf32>) outs(%alloc_36 : memref<8x8x32xf32>)
    %expand_shape_37 = memref.expand_shape %alloc_36 [[0, 1], [2], [3]] output_shape [2, 4, 8, 32] : memref<8x8x32xf32> into memref<2x4x8x32xf32>
    %alloc_38 = memref.alloc() {alignment = 64 : i64} : memref<2x8x4x32xf32>
    linalg.transpose ins(%expand_shape_37 : memref<2x4x8x32xf32>) outs(%alloc_38 : memref<2x8x4x32xf32>) permutation = [0, 2, 1, 3] 
    %collapse_shape_39 = memref.collapse_shape %alloc_38 [[0], [1], [2, 3]] : memref<2x8x4x32xf32> into memref<2x8x128xf32>
    %alloc_40 = memref.alloc() {alignment = 64 : i64} : memref<128x128xf32>
    linalg.transpose ins(%arg6 : memref<128x128xf32>) outs(%alloc_40 : memref<128x128xf32>) permutation = [1, 0] 
    %alloc_41 = memref.alloc() {alignment = 64 : i64} : memref<2x128x128xf32>
    linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_40 : memref<128x128xf32>) outs(%alloc_41 : memref<2x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    %alloc_42 = memref.alloc() {alignment = 64 : i64} : memref<2x8x128xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_42 : memref<2x8x128xf32>)
    %alloc_43 = memref.alloc() {alignment = 64 : i64} : memref<2x8x128xf32>
    linalg.copy ins(%alloc_42 : memref<2x8x128xf32>) outs(%alloc_43 : memref<2x8x128xf32>)
    linalg.batch_matmul ins(%collapse_shape_39, %alloc_41 : memref<2x8x128xf32>, memref<2x128x128xf32>) outs(%alloc_43 : memref<2x8x128xf32>)
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_43, %arg7 : memref<2x8x128xf32>, memref<128xf32>) outs(%arg14 : memref<2x8x128xf32>) {
    ^bb0(%in: f32, %in_54: f32, %out: f32):
      %1 = arith.addf %in, %in_54 : f32
      linalg.yield %1 : f32
    }
    %alloc_44 = memref.alloc() {alignment = 64 : i64} : memref<2x8x128xf32>
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg2, %arg14 : memref<2x8x128xf32>, memref<2x8x128xf32>) outs(%alloc_44 : memref<2x8x128xf32>) {
    ^bb0(%in: f32, %in_54: f32, %out: f32):
      %1 = arith.addf %in, %in_54 : f32
      linalg.yield %1 : f32
    }
    %alloc_45 = memref.alloc() {alignment = 64 : i64} : memref<2x8x1xf32>
    linalg.copy ins(%alloc_7 : memref<2x8x1xf32>) outs(%alloc_45 : memref<2x8x1xf32>)
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%alloc_44 : memref<2x8x128xf32>) outs(%alloc_45 : memref<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.addf %in, %out : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_45 : memref<2x8x1xf32>) outs(%alloc : memref<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.divf %in, %cst_5 : f32
      linalg.yield %1 : f32
    }
    %collapse_shape_46 = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x8x1xf32> into memref<2x8xf32>
    linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapse_shape_46 : memref<2x8xf32>) outs(%arg14 : memref<2x8x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    %alloc_47 = memref.alloc() {alignment = 64 : i64} : memref<2x8x128xf32>
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_44, %arg14 : memref<2x8x128xf32>, memref<2x8x128xf32>) outs(%alloc_47 : memref<2x8x128xf32>) {
    ^bb0(%in: f32, %in_54: f32, %out: f32):
      %1 = arith.subf %in, %in_54 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_47, %alloc_47 : memref<2x8x128xf32>, memref<2x8x128xf32>) outs(%arg14 : memref<2x8x128xf32>) {
    ^bb0(%in: f32, %in_54: f32, %out: f32):
      %1 = arith.mulf %in, %in_54 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg14 : memref<2x8x128xf32>) outs(%alloc_7 : memref<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.addf %in, %out : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_7 : memref<2x8x1xf32>) outs(%alloc : memref<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.divf %in, %cst_5 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc : memref<2x8x1xf32>) outs(%alloc : memref<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.truncf %cst_4 : f64 to f32
      %2 = arith.addf %in, %1 : f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc : memref<2x8x1xf32>) outs(%alloc : memref<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = math.rsqrt %in : f32
      linalg.yield %1 : f32
    }
    %collapse_shape_48 = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x8x1xf32> into memref<2x8xf32>
    linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapse_shape_48 : memref<2x8xf32>) outs(%arg14 : memref<2x8x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_47, %arg14 : memref<2x8x128xf32>, memref<2x8x128xf32>) outs(%arg14 : memref<2x8x128xf32>) {
    ^bb0(%in: f32, %in_54: f32, %out: f32):
      %1 = arith.mulf %in, %in_54 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg14, %arg8 : memref<2x8x128xf32>, memref<128xf32>) outs(%arg14 : memref<2x8x128xf32>) {
    ^bb0(%in: f32, %in_54: f32, %out: f32):
      %1 = arith.mulf %in, %in_54 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg14, %arg9 : memref<2x8x128xf32>, memref<128xf32>) outs(%arg14 : memref<2x8x128xf32>) {
    ^bb0(%in: f32, %in_54: f32, %out: f32):
      %1 = arith.addf %in, %in_54 : f32
      linalg.yield %1 : f32
    }
    %alloc_49 = memref.alloc() {alignment = 64 : i64} : memref<128x512xf32>
    linalg.transpose ins(%arg10 : memref<512x128xf32>) outs(%alloc_49 : memref<128x512xf32>) permutation = [1, 0] 
    %alloc_50 = memref.alloc() {alignment = 64 : i64} : memref<2x128x512xf32>
    linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_49 : memref<128x512xf32>) outs(%alloc_50 : memref<2x128x512xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    %alloc_51 = memref.alloc() {alignment = 64 : i64} : memref<2x8x512xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_51 : memref<2x8x512xf32>)
    linalg.batch_matmul ins(%arg14, %alloc_50 : memref<2x8x128xf32>, memref<2x128x512xf32>) outs(%alloc_51 : memref<2x8x512xf32>)
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_51, %arg11 : memref<2x8x512xf32>, memref<512xf32>) outs(%alloc_51 : memref<2x8x512xf32>) {
    ^bb0(%in: f32, %in_54: f32, %out: f32):
      %1 = arith.addf %in, %in_54 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_51 : memref<2x8x512xf32>) outs(%alloc_51 : memref<2x8x512xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.divf %in, %cst_6 : f32
      %2 = math.erf %1 : f32
      %3 = arith.addf %2, %cst_1 : f32
      %4 = arith.mulf %3, %cst_2 : f32
      %5 = arith.mulf %in, %4 : f32
      linalg.yield %5 : f32
    }
    %alloc_52 = memref.alloc() {alignment = 64 : i64} : memref<512x128xf32>
    linalg.transpose ins(%arg12 : memref<128x512xf32>) outs(%alloc_52 : memref<512x128xf32>) permutation = [1, 0] 
    %alloc_53 = memref.alloc() {alignment = 64 : i64} : memref<2x512x128xf32>
    linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_52 : memref<512x128xf32>) outs(%alloc_53 : memref<2x512x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    linalg.batch_matmul ins(%alloc_51, %alloc_53 : memref<2x8x512xf32>, memref<2x512x128xf32>) outs(%alloc_42 : memref<2x8x128xf32>)
    linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_42, %arg13 : memref<2x8x128xf32>, memref<128xf32>) outs(%arg14 : memref<2x8x128xf32>) {
    ^bb0(%in: f32, %in_54: f32, %out: f32):
      %1 = arith.addf %in, %in_54 : f32
      linalg.yield %1 : f32
    }
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_44, %arg14 : memref<2x8x128xf32>, memref<2x8x128xf32>) outs(%arg14 : memref<2x8x128xf32>) {
    ^bb0(%in: f32, %in_54: f32, %out: f32):
      %1 = arith.addf %in, %in_54 : f32
      linalg.yield %1 : f32
    }
    return
  }
}

