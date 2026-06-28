#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, 0)>
#map2 = affine_map<(d0, d1, d2) -> (d2)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map4 = affine_map<(d0, d1, d2) -> (d1, d2)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: memref<2x?x64xf32>, %arg1: memref<2x?x?xf32>, %arg2: memref<64x256xf32>, %arg3: memref<256x64xf32>, %arg4: memref<64xf32>, %arg5: memref<64xf32>, %arg6: memref<64xf32>, %arg7: memref<64xf32>, %arg8: memref<2x?x64xf32>) attributes {llvm.emit_c_interface} {
    %cst = arith.constant 0.000000e+00 : f32
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %cst_0 = arith.constant 0.000000e+00 : f64
    %c0_i64 = arith.constant 0 : i64
    %cst_1 = arith.constant 0xFF800000 : f32
    %cst_2 = arith.constant 1.000000e+00 : f32
    %cst_3 = arith.constant 5.000000e-01 : f32
    %cst_4 = arith.constant 1.000000e-05 : f64
    %cst_5 = arith.constant 6.400000e+01 : f32
    %cst_6 = arith.constant 6.400000e+01 : f64
    %cst_7 = arith.constant 8.000000e+00 : f32
    %cst_8 = arith.constant 1.41421354 : f32
    %dim = memref.dim %arg0, %c1 : memref<2x?x64xf32>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<2x?x1xf32>
    %alloc_9 = memref.alloc(%dim) {alignment = 64 : i64} : memref<2x?x1xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_9 : memref<2x?x1xf32>)
    %c1_10 = arith.constant 1 : index
    %dim_11 = memref.dim %alloc_9, %c1_10 : memref<2x?x1xf32>
    %alloc_12 = memref.alloc(%dim_11) {alignment = 64 : i64} : memref<2x?x1xf32>
    linalg.copy ins(%alloc_9 : memref<2x?x1xf32>) outs(%alloc_12 : memref<2x?x1xf32>)
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg0 : memref<2x?x64xf32>) outs(%alloc_12 : memref<2x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = arith.addf %in, %out : f32
      linalg.yield %2 : f32
    }
    %alloc_13 = memref.alloc(%dim) {alignment = 64 : i64} : memref<2x?x1xf32>
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_12 : memref<2x?x1xf32>) outs(%alloc_13 : memref<2x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = arith.divf %in, %cst_5 : f32
      linalg.yield %2 : f32
    }
    %alloc_14 = memref.alloc(%dim) {alignment = 64 : i64} : memref<2x?x64xf64>
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0 : memref<2x?x64xf32>) outs(%alloc_14 : memref<2x?x64xf64>) {
    ^bb0(%in: f32, %out: f64):
      %2 = arith.extf %in : f32 to f64
      linalg.yield %2 : f64
    }
    %alloc_15 = memref.alloc(%dim) {alignment = 64 : i64} : memref<2x?x1xf64>
    %alloc_16 = memref.alloc(%dim) {alignment = 64 : i64} : memref<2x?x1xf64>
    linalg.fill ins(%cst_0 : f64) outs(%alloc_16 : memref<2x?x1xf64>)
    %c1_17 = arith.constant 1 : index
    %dim_18 = memref.dim %alloc_16, %c1_17 : memref<2x?x1xf64>
    %alloc_19 = memref.alloc(%dim_18) {alignment = 64 : i64} : memref<2x?x1xf64>
    linalg.copy ins(%alloc_16 : memref<2x?x1xf64>) outs(%alloc_19 : memref<2x?x1xf64>)
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%alloc_14 : memref<2x?x64xf64>) outs(%alloc_19 : memref<2x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %2 = arith.addf %in, %out : f64
      linalg.yield %2 : f64
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_19 : memref<2x?x1xf64>) outs(%alloc_15 : memref<2x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %2 = arith.divf %in, %cst_6 : f64
      linalg.yield %2 : f64
    }
    linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_14, %alloc_15 : memref<2x?x64xf64>, memref<2x?x1xf64>) outs(%alloc_14 : memref<2x?x64xf64>) {
    ^bb0(%in: f64, %in_48: f64, %out: f64):
      %2 = arith.subf %in, %in_48 : f64
      linalg.yield %2 : f64
    }
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_14, %alloc_14 : memref<2x?x64xf64>, memref<2x?x64xf64>) outs(%alloc_14 : memref<2x?x64xf64>) {
    ^bb0(%in: f64, %in_48: f64, %out: f64):
      %2 = arith.mulf %in, %in_48 : f64
      linalg.yield %2 : f64
    }
    %c1_20 = arith.constant 1 : index
    %dim_21 = memref.dim %alloc_16, %c1_20 : memref<2x?x1xf64>
    %alloc_22 = memref.alloc(%dim_21) {alignment = 64 : i64} : memref<2x?x1xf64>
    linalg.copy ins(%alloc_16 : memref<2x?x1xf64>) outs(%alloc_22 : memref<2x?x1xf64>)
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%alloc_14 : memref<2x?x64xf64>) outs(%alloc_22 : memref<2x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %2 = arith.addf %in, %out : f64
      linalg.yield %2 : f64
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_22 : memref<2x?x1xf64>) outs(%alloc_15 : memref<2x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %2 = arith.divf %in, %cst_6 : f64
      linalg.yield %2 : f64
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_15 : memref<2x?x1xf64>) outs(%alloc : memref<2x?x1xf32>) {
    ^bb0(%in: f64, %out: f32):
      %2 = arith.truncf %in : f64 to f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0, %alloc_13 : memref<2x?x64xf32>, memref<2x?x1xf32>) outs(%arg8 : memref<2x?x64xf32>) {
    ^bb0(%in: f32, %in_48: f32, %out: f32):
      %2 = arith.subf %in, %in_48 : f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc : memref<2x?x1xf32>) outs(%alloc : memref<2x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = arith.truncf %cst_4 : f64 to f32
      %3 = arith.addf %in, %2 : f32
      linalg.yield %3 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc : memref<2x?x1xf32>) outs(%alloc : memref<2x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = math.sqrt %in : f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg8, %alloc : memref<2x?x64xf32>, memref<2x?x1xf32>) outs(%arg8 : memref<2x?x64xf32>) {
    ^bb0(%in: f32, %in_48: f32, %out: f32):
      %2 = arith.divf %in, %in_48 : f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg8, %arg4 : memref<2x?x64xf32>, memref<64xf32>) outs(%arg8 : memref<2x?x64xf32>) {
    ^bb0(%in: f32, %in_48: f32, %out: f32):
      %2 = arith.mulf %in, %in_48 : f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg8, %arg5 : memref<2x?x64xf32>, memref<64xf32>) outs(%arg8 : memref<2x?x64xf32>) {
    ^bb0(%in: f32, %in_48: f32, %out: f32):
      %2 = arith.addf %in, %in_48 : f32
      linalg.yield %2 : f32
    }
    %alloc_23 = memref.alloc(%dim) {alignment = 64 : i64} : memref<2x64x?xf32>
    linalg.transpose ins(%arg8 : memref<2x?x64xf32>) outs(%alloc_23 : memref<2x64x?xf32>) permutation = [0, 2, 1] 
    %alloc_24 = memref.alloc(%dim, %dim) {alignment = 64 : i64} : memref<2x?x?xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_24 : memref<2x?x?xf32>)
    linalg.batch_matmul ins(%arg8, %alloc_23 : memref<2x?x64xf32>, memref<2x64x?xf32>) outs(%alloc_24 : memref<2x?x?xf32>)
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_24 : memref<2x?x?xf32>) outs(%alloc_24 : memref<2x?x?xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = arith.divf %in, %cst_7 : f32
      linalg.yield %2 : f32
    }
    %dim_25 = memref.dim %arg1, %c1 : memref<2x?x?xf32>
    %0 = arith.cmpi eq, %dim, %dim_25 : index
    cf.assert %0, "mismatched size for broadcast"
    %dim_26 = memref.dim %arg1, %c2 : memref<2x?x?xf32>
    %1 = arith.cmpi eq, %dim, %dim_26 : index
    cf.assert %1, "mismatched size for broadcast"
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_24, %arg1 : memref<2x?x?xf32>, memref<2x?x?xf32>) outs(%alloc_24 : memref<2x?x?xf32>) {
    ^bb0(%in: f32, %in_48: f32, %out: f32):
      %2 = arith.addf %in, %in_48 : f32
      linalg.yield %2 : f32
    }
    %alloc_27 = memref.alloc(%dim) {alignment = 64 : i64} : memref<2x?xi64>
    linalg.fill ins(%c0_i64 : i64) outs(%alloc_27 : memref<2x?xi64>)
    %alloc_28 = memref.alloc(%dim) {alignment = 64 : i64} : memref<2x?xf32>
    linalg.fill ins(%cst_1 : f32) outs(%alloc_28 : memref<2x?xf32>)
    linalg.generic {indexing_maps = [#map, #map3, #map3], iterator_types = ["parallel", "parallel", "reduction"]} ins(%alloc_24 : memref<2x?x?xf32>) outs(%alloc_28, %alloc_27 : memref<2x?xf32>, memref<2x?xi64>) {
    ^bb0(%in: f32, %out: f32, %out_48: i64):
      %2 = linalg.index 2 : index
      %3 = arith.index_cast %2 : index to i64
      %4 = arith.maximumf %in, %out : f32
      %5 = arith.cmpf ogt, %in, %out : f32
      %6 = arith.select %5, %3, %out_48 : i64
      linalg.yield %4, %6 : f32, i64
    }
    %expand_shape = memref.expand_shape %alloc_28 [[0], [1, 2]] output_shape [2, %dim, 1] : memref<2x?xf32> into memref<2x?x1xf32>
    linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_24, %expand_shape : memref<2x?x?xf32>, memref<2x?x1xf32>) outs(%alloc_24 : memref<2x?x?xf32>) {
    ^bb0(%in: f32, %in_48: f32, %out: f32):
      %2 = arith.subf %in, %in_48 : f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_24 : memref<2x?x?xf32>) outs(%alloc_24 : memref<2x?x?xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = math.exp %in : f32
      linalg.yield %2 : f32
    }
    %c1_29 = arith.constant 1 : index
    %dim_30 = memref.dim %alloc_9, %c1_29 : memref<2x?x1xf32>
    %alloc_31 = memref.alloc(%dim_30) {alignment = 64 : i64} : memref<2x?x1xf32>
    linalg.copy ins(%alloc_9 : memref<2x?x1xf32>) outs(%alloc_31 : memref<2x?x1xf32>)
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%alloc_24 : memref<2x?x?xf32>) outs(%alloc_31 : memref<2x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = arith.addf %in, %out : f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_24, %alloc_31 : memref<2x?x?xf32>, memref<2x?x1xf32>) outs(%alloc_24 : memref<2x?x?xf32>) {
    ^bb0(%in: f32, %in_48: f32, %out: f32):
      %2 = arith.divf %in, %in_48 : f32
      linalg.yield %2 : f32
    }
    %c1_32 = arith.constant 1 : index
    %dim_33 = memref.dim %arg8, %c1_32 : memref<2x?x64xf32>
    %alloc_34 = memref.alloc(%dim_33) {alignment = 64 : i64} : memref<2x?x64xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_34 : memref<2x?x64xf32>)
    %c1_35 = arith.constant 1 : index
    %dim_36 = memref.dim %alloc_34, %c1_35 : memref<2x?x64xf32>
    %alloc_37 = memref.alloc(%dim_36) {alignment = 64 : i64} : memref<2x?x64xf32>
    linalg.copy ins(%alloc_34 : memref<2x?x64xf32>) outs(%alloc_37 : memref<2x?x64xf32>)
    linalg.batch_matmul ins(%alloc_24, %arg8 : memref<2x?x?xf32>, memref<2x?x64xf32>) outs(%alloc_37 : memref<2x?x64xf32>)
    %c1_38 = arith.constant 1 : index
    %dim_39 = memref.dim %arg8, %c1_38 : memref<2x?x64xf32>
    %alloc_40 = memref.alloc(%dim_39) {alignment = 64 : i64} : memref<2x?x64xf32>
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0, %alloc_37 : memref<2x?x64xf32>, memref<2x?x64xf32>) outs(%alloc_40 : memref<2x?x64xf32>) {
    ^bb0(%in: f32, %in_48: f32, %out: f32):
      %2 = arith.addf %in, %in_48 : f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%alloc_40 : memref<2x?x64xf32>) outs(%alloc_9 : memref<2x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = arith.addf %in, %out : f32
      linalg.yield %2 : f32
    }
    %alloc_41 = memref.alloc(%dim) {alignment = 64 : i64} : memref<2x?x1xf32>
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_9 : memref<2x?x1xf32>) outs(%alloc_41 : memref<2x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = arith.divf %in, %cst_5 : f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_40 : memref<2x?x64xf32>) outs(%alloc_14 : memref<2x?x64xf64>) {
    ^bb0(%in: f32, %out: f64):
      %2 = arith.extf %in : f32 to f64
      linalg.yield %2 : f64
    }
    %c1_42 = arith.constant 1 : index
    %dim_43 = memref.dim %alloc_16, %c1_42 : memref<2x?x1xf64>
    %alloc_44 = memref.alloc(%dim_43) {alignment = 64 : i64} : memref<2x?x1xf64>
    linalg.copy ins(%alloc_16 : memref<2x?x1xf64>) outs(%alloc_44 : memref<2x?x1xf64>)
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%alloc_14 : memref<2x?x64xf64>) outs(%alloc_44 : memref<2x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %2 = arith.addf %in, %out : f64
      linalg.yield %2 : f64
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_44 : memref<2x?x1xf64>) outs(%alloc_15 : memref<2x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %2 = arith.divf %in, %cst_6 : f64
      linalg.yield %2 : f64
    }
    linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_14, %alloc_15 : memref<2x?x64xf64>, memref<2x?x1xf64>) outs(%alloc_14 : memref<2x?x64xf64>) {
    ^bb0(%in: f64, %in_48: f64, %out: f64):
      %2 = arith.subf %in, %in_48 : f64
      linalg.yield %2 : f64
    }
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_14, %alloc_14 : memref<2x?x64xf64>, memref<2x?x64xf64>) outs(%alloc_14 : memref<2x?x64xf64>) {
    ^bb0(%in: f64, %in_48: f64, %out: f64):
      %2 = arith.mulf %in, %in_48 : f64
      linalg.yield %2 : f64
    }
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%alloc_14 : memref<2x?x64xf64>) outs(%alloc_16 : memref<2x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %2 = arith.addf %in, %out : f64
      linalg.yield %2 : f64
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_16 : memref<2x?x1xf64>) outs(%alloc_15 : memref<2x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %2 = arith.divf %in, %cst_6 : f64
      linalg.yield %2 : f64
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_15 : memref<2x?x1xf64>) outs(%alloc : memref<2x?x1xf32>) {
    ^bb0(%in: f64, %out: f32):
      %2 = arith.truncf %in : f64 to f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_40, %alloc_41 : memref<2x?x64xf32>, memref<2x?x1xf32>) outs(%arg8 : memref<2x?x64xf32>) {
    ^bb0(%in: f32, %in_48: f32, %out: f32):
      %2 = arith.subf %in, %in_48 : f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc : memref<2x?x1xf32>) outs(%alloc : memref<2x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = arith.truncf %cst_4 : f64 to f32
      %3 = arith.addf %in, %2 : f32
      linalg.yield %3 : f32
    }
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc : memref<2x?x1xf32>) outs(%alloc : memref<2x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = math.sqrt %in : f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg8, %alloc : memref<2x?x64xf32>, memref<2x?x1xf32>) outs(%arg8 : memref<2x?x64xf32>) {
    ^bb0(%in: f32, %in_48: f32, %out: f32):
      %2 = arith.divf %in, %in_48 : f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg8, %arg6 : memref<2x?x64xf32>, memref<64xf32>) outs(%arg8 : memref<2x?x64xf32>) {
    ^bb0(%in: f32, %in_48: f32, %out: f32):
      %2 = arith.mulf %in, %in_48 : f32
      linalg.yield %2 : f32
    }
    linalg.generic {indexing_maps = [#map, #map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg8, %arg7 : memref<2x?x64xf32>, memref<64xf32>) outs(%arg8 : memref<2x?x64xf32>) {
    ^bb0(%in: f32, %in_48: f32, %out: f32):
      %2 = arith.addf %in, %in_48 : f32
      linalg.yield %2 : f32
    }
    %alloc_45 = memref.alloc() {alignment = 64 : i64} : memref<2x64x256xf32>
    linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg2 : memref<64x256xf32>) outs(%alloc_45 : memref<2x64x256xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    %alloc_46 = memref.alloc(%dim) {alignment = 64 : i64} : memref<2x?x256xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_46 : memref<2x?x256xf32>)
    linalg.batch_matmul ins(%arg8, %alloc_45 : memref<2x?x64xf32>, memref<2x64x256xf32>) outs(%alloc_46 : memref<2x?x256xf32>)
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_46 : memref<2x?x256xf32>) outs(%alloc_46 : memref<2x?x256xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = arith.divf %in, %cst_8 : f32
      %3 = math.erf %2 : f32
      %4 = arith.addf %3, %cst_2 : f32
      %5 = arith.mulf %4, %cst_3 : f32
      %6 = arith.mulf %in, %5 : f32
      linalg.yield %6 : f32
    }
    %alloc_47 = memref.alloc() {alignment = 64 : i64} : memref<2x256x64xf32>
    linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg3 : memref<256x64xf32>) outs(%alloc_47 : memref<2x256x64xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    }
    linalg.batch_matmul ins(%alloc_46, %alloc_47 : memref<2x?x256xf32>, memref<2x256x64xf32>) outs(%alloc_34 : memref<2x?x64xf32>)
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc_40, %alloc_34 : memref<2x?x64xf32>, memref<2x?x64xf32>) outs(%arg8 : memref<2x?x64xf32>) {
    ^bb0(%in: f32, %in_48: f32, %out: f32):
      %2 = arith.addf %in, %in_48 : f32
      linalg.yield %2 : f32
    }
    return
  }
}
