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
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: tensor<128xf32>, %arg1: tensor<128xf32>, %arg2: tensor<2x8x128xf32>, %arg3: tensor<384x128xf32>, %arg4: tensor<384xf32>, %arg5: tensor<1x1x128x128xf32>, %arg6: tensor<128x128xf32>, %arg7: tensor<128xf32>, %arg8: tensor<128xf32>, %arg9: tensor<128xf32>, %arg10: tensor<512x128xf32>, %arg11: tensor<512xf32>, %arg12: tensor<128x512xf32>, %arg13: tensor<128xf32>, %arg14: tensor<2x8x128xf32>) -> tensor<2x8x128xf32> {
    %c0_i64 = arith.constant 0 : i64
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 0xFF800000 : f32
    %cst_1 = arith.constant 1.000000e+00 : f32
    %cst_2 = arith.constant 5.000000e-01 : f32
    %cst_3 = arith.constant dense<0xFF800000> : tensor<f32>
    %cst_4 = arith.constant 0.17677669529663687 : f64
    %cst_5 = arith.constant 1.000000e-05 : f64
    %cst_6 = arith.constant 1.280000e+02 : f32
    %cst_7 = arith.constant 1.41421354 : f32
    %0 = tensor.empty() : tensor<2x8x1xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<2x8x1xf32>) -> tensor<2x8x1xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg2 : tensor<2x8x128xf32>) outs(%1 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %81 = arith.addf %in, %out : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x1xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%2 : tensor<2x8x1xf32>) outs(%0 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %81 = arith.divf %in, %cst_6 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x1xf32>
    %collapsed = tensor.collapse_shape %3 [[0], [1, 2]] : tensor<2x8x1xf32> into tensor<2x8xf32>
    %4 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed : tensor<2x8xf32>) outs(%arg14 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x8x128xf32>
    %5 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg2, %4 : tensor<2x8x128xf32>, tensor<2x8x128xf32>) outs(%arg14 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %81 = arith.subf %in, %in_32 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x128xf32>
    %6 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%5, %5 : tensor<2x8x128xf32>, tensor<2x8x128xf32>) outs(%arg14 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %81 = arith.mulf %in, %in_32 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x128xf32>
    %7 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%6 : tensor<2x8x128xf32>) outs(%1 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %81 = arith.addf %in, %out : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x1xf32>
    %8 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%7 : tensor<2x8x1xf32>) outs(%0 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %81 = arith.divf %in, %cst_6 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x1xf32>
    %9 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%8 : tensor<2x8x1xf32>) outs(%0 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %81 = arith.truncf %cst_5 : f64 to f32
      %82 = arith.addf %in, %81 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x1xf32>
    %10 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%9 : tensor<2x8x1xf32>) outs(%0 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %81 = math.rsqrt %in : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x1xf32>
    %collapsed_8 = tensor.collapse_shape %10 [[0], [1, 2]] : tensor<2x8x1xf32> into tensor<2x8xf32>
    %11 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed_8 : tensor<2x8xf32>) outs(%arg14 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x8x128xf32>
    %12 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%5, %11 : tensor<2x8x128xf32>, tensor<2x8x128xf32>) outs(%arg14 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %81 = arith.mulf %in, %in_32 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x128xf32>
    %13 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%12, %arg0 : tensor<2x8x128xf32>, tensor<128xf32>) outs(%arg14 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %81 = arith.mulf %in, %in_32 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x128xf32>
    %14 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%13, %arg1 : tensor<2x8x128xf32>, tensor<128xf32>) outs(%arg14 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %81 = arith.addf %in, %in_32 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x128xf32>
    %15 = tensor.empty() : tensor<128x384xf32>
    %transposed = linalg.transpose ins(%arg3 : tensor<384x128xf32>) outs(%15 : tensor<128x384xf32>) permutation = [1, 0] 
    %16 = tensor.empty() : tensor<2x128x384xf32>
    %17 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed : tensor<128x384xf32>) outs(%16 : tensor<2x128x384xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x384xf32>
    %18 = tensor.empty() : tensor<2x8x384xf32>
    %19 = linalg.fill ins(%cst : f32) outs(%18 : tensor<2x8x384xf32>) -> tensor<2x8x384xf32>
    %20 = linalg.batch_matmul ins(%14, %17 : tensor<2x8x128xf32>, tensor<2x128x384xf32>) outs(%19 : tensor<2x8x384xf32>) -> tensor<2x8x384xf32>
    %21 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%20, %arg4 : tensor<2x8x384xf32>, tensor<384xf32>) outs(%18 : tensor<2x8x384xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %81 = arith.addf %in, %in_32 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x384xf32>
    %extracted_slice = tensor.extract_slice %21[0, 0, 0] [2, 8, 128] [1, 1, 1] : tensor<2x8x384xf32> to tensor<2x8x128xf32>
    %extracted_slice_9 = tensor.extract_slice %21[0, 0, 128] [2, 8, 128] [1, 1, 1] : tensor<2x8x384xf32> to tensor<2x8x128xf32>
    %extracted_slice_10 = tensor.extract_slice %21[0, 0, 256] [2, 8, 128] [1, 1, 1] : tensor<2x8x384xf32> to tensor<2x8x128xf32>
    %expanded = tensor.expand_shape %extracted_slice_9 [[0], [1], [2, 3]] output_shape [2, 8, 4, 32] : tensor<2x8x128xf32> into tensor<2x8x4x32xf32>
    %expanded_11 = tensor.expand_shape %extracted_slice [[0], [1], [2, 3]] output_shape [2, 8, 4, 32] : tensor<2x8x128xf32> into tensor<2x8x4x32xf32>
    %22 = tensor.empty() : tensor<2x4x8x32xf32>
    %transposed_12 = linalg.transpose ins(%expanded_11 : tensor<2x8x4x32xf32>) outs(%22 : tensor<2x4x8x32xf32>) permutation = [0, 2, 1, 3] 
    %expanded_13 = tensor.expand_shape %extracted_slice_10 [[0], [1], [2, 3]] output_shape [2, 8, 4, 32] : tensor<2x8x128xf32> into tensor<2x8x4x32xf32>
    %transposed_14 = linalg.transpose ins(%expanded_13 : tensor<2x8x4x32xf32>) outs(%22 : tensor<2x4x8x32xf32>) permutation = [0, 2, 1, 3] 
    %23 = tensor.empty() : tensor<2x4x32x8xf32>
    %transposed_15 = linalg.transpose ins(%expanded : tensor<2x8x4x32xf32>) outs(%23 : tensor<2x4x32x8xf32>) permutation = [0, 2, 3, 1] 
    %collapsed_16 = tensor.collapse_shape %transposed_12 [[0, 1], [2], [3]] : tensor<2x4x8x32xf32> into tensor<8x8x32xf32>
    %collapsed_17 = tensor.collapse_shape %transposed_15 [[0, 1], [2], [3]] : tensor<2x4x32x8xf32> into tensor<8x32x8xf32>
    %24 = tensor.empty() : tensor<8x8x8xf32>
    %25 = linalg.fill ins(%cst : f32) outs(%24 : tensor<8x8x8xf32>) -> tensor<8x8x8xf32>
    %26 = linalg.batch_matmul ins(%collapsed_16, %collapsed_17 : tensor<8x8x32xf32>, tensor<8x32x8xf32>) outs(%25 : tensor<8x8x8xf32>) -> tensor<8x8x8xf32>
    %expanded_18 = tensor.expand_shape %26 [[0, 1], [2], [3]] output_shape [2, 4, 8, 8] : tensor<8x8x8xf32> into tensor<2x4x8x8xf32>
    %27 = tensor.empty() : tensor<2x4x8x8xf32>
    %28 = linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%expanded_18 : tensor<2x4x8x8xf32>) outs(%27 : tensor<2x4x8x8xf32>) {
    ^bb0(%in: f32, %out: f32):
      %81 = arith.truncf %cst_4 : f64 to f32
      %82 = arith.mulf %in, %81 : f32
      linalg.yield %82 : f32
    } -> tensor<2x4x8x8xf32>
    %extracted_slice_19 = tensor.extract_slice %arg5[0, 0, 0, 0] [1, 1, 8, 128] [1, 1, 1, 1] : tensor<1x1x128x128xf32> to tensor<1x1x8x128xf32>
    %extracted_slice_20 = tensor.extract_slice %extracted_slice_19[0, 0, 0, 0] [1, 1, 8, 8] [1, 1, 1, 1] : tensor<1x1x8x128xf32> to tensor<1x1x8x8xf32>
    %29 = tensor.empty() : tensor<1x1x8x8xi1>
    %30 = linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%extracted_slice_20 : tensor<1x1x8x8xf32>) outs(%29 : tensor<1x1x8x8xi1>) {
    ^bb0(%in: f32, %out: i1):
      %81 = arith.cmpf oeq, %in, %cst : f32
      linalg.yield %81 : i1
    } -> tensor<1x1x8x8xi1>
    %31 = linalg.generic {indexing_maps = [#map6, #map7, #map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%30, %cst_3, %28 : tensor<1x1x8x8xi1>, tensor<f32>, tensor<2x4x8x8xf32>) outs(%27 : tensor<2x4x8x8xf32>) {
    ^bb0(%in: i1, %in_32: f32, %in_33: f32, %out: f32):
      %81 = arith.select %in, %in_32, %in_33 : f32
      linalg.yield %81 : f32
    } -> tensor<2x4x8x8xf32>
    %32 = tensor.empty() : tensor<2x4x8xi64>
    %33 = linalg.fill ins(%c0_i64 : i64) outs(%32 : tensor<2x4x8xi64>) -> tensor<2x4x8xi64>
    %34 = tensor.empty() : tensor<2x4x8xf32>
    %35 = linalg.fill ins(%cst_0 : f32) outs(%34 : tensor<2x4x8xf32>) -> tensor<2x4x8xf32>
    %36:2 = linalg.generic {indexing_maps = [#map5, #map8, #map8], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%31 : tensor<2x4x8x8xf32>) outs(%35, %33 : tensor<2x4x8xf32>, tensor<2x4x8xi64>) {
    ^bb0(%in: f32, %out: f32, %out_32: i64):
      %81 = linalg.index 3 : index
      %82 = arith.index_cast %81 : index to i64
      %83 = arith.maximumf %in, %out : f32
      %84 = arith.cmpf ogt, %in, %out : f32
      %85 = arith.select %84, %82, %out_32 : i64
      linalg.yield %83, %85 : f32, i64
    } -> (tensor<2x4x8xf32>, tensor<2x4x8xi64>)
    %expanded_21 = tensor.expand_shape %36#0 [[0], [1], [2, 3]] output_shape [2, 4, 8, 1] : tensor<2x4x8xf32> into tensor<2x4x8x1xf32>
    %37 = linalg.generic {indexing_maps = [#map5, #map9, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%31, %expanded_21 : tensor<2x4x8x8xf32>, tensor<2x4x8x1xf32>) outs(%27 : tensor<2x4x8x8xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %81 = arith.subf %in, %in_32 : f32
      linalg.yield %81 : f32
    } -> tensor<2x4x8x8xf32>
    %38 = linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%37 : tensor<2x4x8x8xf32>) outs(%27 : tensor<2x4x8x8xf32>) {
    ^bb0(%in: f32, %out: f32):
      %81 = math.exp %in : f32
      linalg.yield %81 : f32
    } -> tensor<2x4x8x8xf32>
    %39 = tensor.empty() : tensor<2x4x8x1xf32>
    %40 = linalg.fill ins(%cst : f32) outs(%39 : tensor<2x4x8x1xf32>) -> tensor<2x4x8x1xf32>
    %41 = linalg.generic {indexing_maps = [#map5, #map9], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%38 : tensor<2x4x8x8xf32>) outs(%40 : tensor<2x4x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %81 = arith.addf %in, %out : f32
      linalg.yield %81 : f32
    } -> tensor<2x4x8x1xf32>
    %42 = linalg.generic {indexing_maps = [#map5, #map9, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%38, %41 : tensor<2x4x8x8xf32>, tensor<2x4x8x1xf32>) outs(%27 : tensor<2x4x8x8xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %81 = arith.divf %in, %in_32 : f32
      linalg.yield %81 : f32
    } -> tensor<2x4x8x8xf32>
    %collapsed_22 = tensor.collapse_shape %42 [[0, 1], [2], [3]] : tensor<2x4x8x8xf32> into tensor<8x8x8xf32>
    %collapsed_23 = tensor.collapse_shape %transposed_14 [[0, 1], [2], [3]] : tensor<2x4x8x32xf32> into tensor<8x8x32xf32>
    %43 = tensor.empty() : tensor<8x8x32xf32>
    %44 = linalg.fill ins(%cst : f32) outs(%43 : tensor<8x8x32xf32>) -> tensor<8x8x32xf32>
    %45 = linalg.batch_matmul ins(%collapsed_22, %collapsed_23 : tensor<8x8x8xf32>, tensor<8x8x32xf32>) outs(%44 : tensor<8x8x32xf32>) -> tensor<8x8x32xf32>
    %expanded_24 = tensor.expand_shape %45 [[0, 1], [2], [3]] output_shape [2, 4, 8, 32] : tensor<8x8x32xf32> into tensor<2x4x8x32xf32>
    %46 = tensor.empty() : tensor<2x8x4x32xf32>
    %transposed_25 = linalg.transpose ins(%expanded_24 : tensor<2x4x8x32xf32>) outs(%46 : tensor<2x8x4x32xf32>) permutation = [0, 2, 1, 3] 
    %collapsed_26 = tensor.collapse_shape %transposed_25 [[0], [1], [2, 3]] : tensor<2x8x4x32xf32> into tensor<2x8x128xf32>
    %47 = tensor.empty() : tensor<128x128xf32>
    %transposed_27 = linalg.transpose ins(%arg6 : tensor<128x128xf32>) outs(%47 : tensor<128x128xf32>) permutation = [1, 0] 
    %48 = tensor.empty() : tensor<2x128x128xf32>
    %49 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed_27 : tensor<128x128xf32>) outs(%48 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x128xf32>
    %50 = linalg.fill ins(%cst : f32) outs(%arg14 : tensor<2x8x128xf32>) -> tensor<2x8x128xf32>
    %51 = linalg.batch_matmul ins(%collapsed_26, %49 : tensor<2x8x128xf32>, tensor<2x128x128xf32>) outs(%50 : tensor<2x8x128xf32>) -> tensor<2x8x128xf32>
    %52 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%51, %arg7 : tensor<2x8x128xf32>, tensor<128xf32>) outs(%arg14 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %81 = arith.addf %in, %in_32 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x128xf32>
    %53 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg2, %52 : tensor<2x8x128xf32>, tensor<2x8x128xf32>) outs(%arg14 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %81 = arith.addf %in, %in_32 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x128xf32>
    %54 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%53 : tensor<2x8x128xf32>) outs(%1 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %81 = arith.addf %in, %out : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x1xf32>
    %55 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%54 : tensor<2x8x1xf32>) outs(%0 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %81 = arith.divf %in, %cst_6 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x1xf32>
    %collapsed_28 = tensor.collapse_shape %55 [[0], [1, 2]] : tensor<2x8x1xf32> into tensor<2x8xf32>
    %56 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed_28 : tensor<2x8xf32>) outs(%arg14 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x8x128xf32>
    %57 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%53, %56 : tensor<2x8x128xf32>, tensor<2x8x128xf32>) outs(%arg14 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %81 = arith.subf %in, %in_32 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x128xf32>
    %58 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%57, %57 : tensor<2x8x128xf32>, tensor<2x8x128xf32>) outs(%arg14 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %81 = arith.mulf %in, %in_32 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x128xf32>
    %59 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%58 : tensor<2x8x128xf32>) outs(%1 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %81 = arith.addf %in, %out : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x1xf32>
    %60 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%59 : tensor<2x8x1xf32>) outs(%0 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %81 = arith.divf %in, %cst_6 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x1xf32>
    %61 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%60 : tensor<2x8x1xf32>) outs(%0 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %81 = arith.truncf %cst_5 : f64 to f32
      %82 = arith.addf %in, %81 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x1xf32>
    %62 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%61 : tensor<2x8x1xf32>) outs(%0 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %81 = math.rsqrt %in : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x1xf32>
    %collapsed_29 = tensor.collapse_shape %62 [[0], [1, 2]] : tensor<2x8x1xf32> into tensor<2x8xf32>
    %63 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed_29 : tensor<2x8xf32>) outs(%arg14 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x8x128xf32>
    %64 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%57, %63 : tensor<2x8x128xf32>, tensor<2x8x128xf32>) outs(%arg14 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %81 = arith.mulf %in, %in_32 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x128xf32>
    %65 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%64, %arg8 : tensor<2x8x128xf32>, tensor<128xf32>) outs(%arg14 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %81 = arith.mulf %in, %in_32 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x128xf32>
    %66 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%65, %arg9 : tensor<2x8x128xf32>, tensor<128xf32>) outs(%arg14 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %81 = arith.addf %in, %in_32 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x128xf32>
    %67 = tensor.empty() : tensor<128x512xf32>
    %transposed_30 = linalg.transpose ins(%arg10 : tensor<512x128xf32>) outs(%67 : tensor<128x512xf32>) permutation = [1, 0] 
    %68 = tensor.empty() : tensor<2x128x512xf32>
    %69 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed_30 : tensor<128x512xf32>) outs(%68 : tensor<2x128x512xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x512xf32>
    %70 = tensor.empty() : tensor<2x8x512xf32>
    %71 = linalg.fill ins(%cst : f32) outs(%70 : tensor<2x8x512xf32>) -> tensor<2x8x512xf32>
    %72 = linalg.batch_matmul ins(%66, %69 : tensor<2x8x128xf32>, tensor<2x128x512xf32>) outs(%71 : tensor<2x8x512xf32>) -> tensor<2x8x512xf32>
    %73 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%72, %arg11 : tensor<2x8x512xf32>, tensor<512xf32>) outs(%70 : tensor<2x8x512xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %81 = arith.addf %in, %in_32 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x512xf32>
    %74 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%73 : tensor<2x8x512xf32>) outs(%70 : tensor<2x8x512xf32>) {
    ^bb0(%in: f32, %out: f32):
      %81 = arith.divf %in, %cst_7 : f32
      %82 = math.erf %81 : f32
      %83 = arith.addf %82, %cst_1 : f32
      %84 = arith.mulf %83, %cst_2 : f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<2x8x512xf32>
    %75 = tensor.empty() : tensor<512x128xf32>
    %transposed_31 = linalg.transpose ins(%arg12 : tensor<128x512xf32>) outs(%75 : tensor<512x128xf32>) permutation = [1, 0] 
    %76 = tensor.empty() : tensor<2x512x128xf32>
    %77 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed_31 : tensor<512x128xf32>) outs(%76 : tensor<2x512x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x512x128xf32>
    %78 = linalg.batch_matmul ins(%74, %77 : tensor<2x8x512xf32>, tensor<2x512x128xf32>) outs(%50 : tensor<2x8x128xf32>) -> tensor<2x8x128xf32>
    %79 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%78, %arg13 : tensor<2x8x128xf32>, tensor<128xf32>) outs(%arg14 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %81 = arith.addf %in, %in_32 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x128xf32>
    %80 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%53, %79 : tensor<2x8x128xf32>, tensor<2x8x128xf32>) outs(%arg14 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %81 = arith.addf %in, %in_32 : f32
      linalg.yield %81 : f32
    } -> tensor<2x8x128xf32>
    return %80 : tensor<2x8x128xf32>
  }

transform.named_sequence @__transform_main(%root: !transform.any_op) {
    %v1 = transform.structured.match in %root { ops = ["linalg.batch_matmul"] } : (!transform.any_op) -> !transform.any_op
    %v2 = transform.structured.generalize %v1 : (!transform.any_op) -> !transform.any_op
    %v4, %v3 = transform.structured.tile_using_forall %v2 tile_sizes [1, 0, 8] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %v5, %v6, %v7, %v8 = transform.structured.tile_reduction_using_for %v2 by tile_sizes = [8] : (!transform.any_op) -> (!transform.any_op, !transform.any_op, !transform.any_op, !transform.any_op)
    %v9 = transform.structured.match ops{["func.func"]} in %root : (!transform.any_op) -> !transform.any_op
    transform.structured.vectorize_children_and_apply_patterns %v9 : (!transform.any_op) -> !transform.any_op
    transform.yield
}
}