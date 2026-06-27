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
      %82 = arith.addf %in, %out : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x1xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%2 : tensor<2x8x1xf32>) outs(%0 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %82 = arith.divf %in, %cst_6 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x1xf32>
    %4 = tensor.cast %arg14 : tensor<2x8x128xf32> to tensor<2x8x128xf32>
    %collapsed = tensor.collapse_shape %3 [[0], [1, 2]] : tensor<2x8x1xf32> into tensor<2x8xf32>
    %5 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed : tensor<2x8xf32>) outs(%4 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x8x128xf32>
    %6 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg2, %5 : tensor<2x8x128xf32>, tensor<2x8x128xf32>) outs(%4 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %82 = arith.subf %in, %in_32 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x128xf32>
    %7 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%6, %6 : tensor<2x8x128xf32>, tensor<2x8x128xf32>) outs(%4 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %82 = arith.mulf %in, %in_32 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x128xf32>
    %8 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%7 : tensor<2x8x128xf32>) outs(%1 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %82 = arith.addf %in, %out : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x1xf32>
    %9 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%8 : tensor<2x8x1xf32>) outs(%0 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %82 = arith.divf %in, %cst_6 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x1xf32>
    %10 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%9 : tensor<2x8x1xf32>) outs(%0 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %82 = arith.truncf %cst_5 : f64 to f32
      %83 = arith.addf %in, %82 : f32
      linalg.yield %83 : f32
    } -> tensor<2x8x1xf32>
    %11 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%10 : tensor<2x8x1xf32>) outs(%0 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %82 = math.rsqrt %in : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x1xf32>
    %collapsed_8 = tensor.collapse_shape %11 [[0], [1, 2]] : tensor<2x8x1xf32> into tensor<2x8xf32>
    %12 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed_8 : tensor<2x8xf32>) outs(%4 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x8x128xf32>
    %13 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%6, %12 : tensor<2x8x128xf32>, tensor<2x8x128xf32>) outs(%4 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %82 = arith.mulf %in, %in_32 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x128xf32>
    %14 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%13, %arg0 : tensor<2x8x128xf32>, tensor<128xf32>) outs(%4 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %82 = arith.mulf %in, %in_32 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x128xf32>
    %15 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%14, %arg1 : tensor<2x8x128xf32>, tensor<128xf32>) outs(%4 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %82 = arith.addf %in, %in_32 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x128xf32>
    %16 = tensor.empty() : tensor<128x384xf32>
    %transposed = linalg.transpose ins(%arg3 : tensor<384x128xf32>) outs(%16 : tensor<128x384xf32>) permutation = [1, 0] 
    %17 = tensor.empty() : tensor<2x128x384xf32>
    %18 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed : tensor<128x384xf32>) outs(%17 : tensor<2x128x384xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x384xf32>
    %19 = tensor.empty() : tensor<2x8x384xf32>
    %20 = linalg.fill ins(%cst : f32) outs(%19 : tensor<2x8x384xf32>) -> tensor<2x8x384xf32>
    %21 = linalg.batch_matmul ins(%15, %18 : tensor<2x8x128xf32>, tensor<2x128x384xf32>) outs(%20 : tensor<2x8x384xf32>) -> tensor<2x8x384xf32>
    %22 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%21, %arg4 : tensor<2x8x384xf32>, tensor<384xf32>) outs(%19 : tensor<2x8x384xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %82 = arith.addf %in, %in_32 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x384xf32>
    %extracted_slice = tensor.extract_slice %22[0, 0, 0] [2, 8, 128] [1, 1, 1] : tensor<2x8x384xf32> to tensor<2x8x128xf32>
    %extracted_slice_9 = tensor.extract_slice %22[0, 0, 128] [2, 8, 128] [1, 1, 1] : tensor<2x8x384xf32> to tensor<2x8x128xf32>
    %extracted_slice_10 = tensor.extract_slice %22[0, 0, 256] [2, 8, 128] [1, 1, 1] : tensor<2x8x384xf32> to tensor<2x8x128xf32>
    %expanded = tensor.expand_shape %extracted_slice_9 [[0], [1], [2, 3]] output_shape [2, 8, 4, 32] : tensor<2x8x128xf32> into tensor<2x8x4x32xf32>
    %expanded_11 = tensor.expand_shape %extracted_slice [[0], [1], [2, 3]] output_shape [2, 8, 4, 32] : tensor<2x8x128xf32> into tensor<2x8x4x32xf32>
    %23 = tensor.empty() : tensor<2x4x8x32xf32>
    %transposed_12 = linalg.transpose ins(%expanded_11 : tensor<2x8x4x32xf32>) outs(%23 : tensor<2x4x8x32xf32>) permutation = [0, 2, 1, 3] 
    %expanded_13 = tensor.expand_shape %extracted_slice_10 [[0], [1], [2, 3]] output_shape [2, 8, 4, 32] : tensor<2x8x128xf32> into tensor<2x8x4x32xf32>
    %transposed_14 = linalg.transpose ins(%expanded_13 : tensor<2x8x4x32xf32>) outs(%23 : tensor<2x4x8x32xf32>) permutation = [0, 2, 1, 3] 
    %24 = tensor.empty() : tensor<2x4x32x8xf32>
    %transposed_15 = linalg.transpose ins(%expanded : tensor<2x8x4x32xf32>) outs(%24 : tensor<2x4x32x8xf32>) permutation = [0, 2, 3, 1] 
    %collapsed_16 = tensor.collapse_shape %transposed_12 [[0, 1], [2], [3]] : tensor<2x4x8x32xf32> into tensor<8x8x32xf32>
    %collapsed_17 = tensor.collapse_shape %transposed_15 [[0, 1], [2], [3]] : tensor<2x4x32x8xf32> into tensor<8x32x8xf32>
    %25 = tensor.empty() : tensor<8x8x8xf32>
    %26 = linalg.fill ins(%cst : f32) outs(%25 : tensor<8x8x8xf32>) -> tensor<8x8x8xf32>
    %27 = linalg.batch_matmul ins(%collapsed_16, %collapsed_17 : tensor<8x8x32xf32>, tensor<8x32x8xf32>) outs(%26 : tensor<8x8x8xf32>) -> tensor<8x8x8xf32>
    %expanded_18 = tensor.expand_shape %27 [[0, 1], [2], [3]] output_shape [2, 4, 8, 8] : tensor<8x8x8xf32> into tensor<2x4x8x8xf32>
    %28 = tensor.empty() : tensor<2x4x8x8xf32>
    %29 = linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%expanded_18 : tensor<2x4x8x8xf32>) outs(%28 : tensor<2x4x8x8xf32>) {
    ^bb0(%in: f32, %out: f32):
      %82 = arith.truncf %cst_4 : f64 to f32
      %83 = arith.mulf %in, %82 : f32
      linalg.yield %83 : f32
    } -> tensor<2x4x8x8xf32>
    %extracted_slice_19 = tensor.extract_slice %arg5[0, 0, 0, 0] [1, 1, 8, 128] [1, 1, 1, 1] : tensor<1x1x128x128xf32> to tensor<1x1x8x128xf32>
    %extracted_slice_20 = tensor.extract_slice %extracted_slice_19[0, 0, 0, 0] [1, 1, 8, 8] [1, 1, 1, 1] : tensor<1x1x8x128xf32> to tensor<1x1x8x8xf32>
    %30 = tensor.empty() : tensor<1x1x8x8xi1>
    %31 = linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%extracted_slice_20 : tensor<1x1x8x8xf32>) outs(%30 : tensor<1x1x8x8xi1>) {
    ^bb0(%in: f32, %out: i1):
      %82 = arith.cmpf oeq, %in, %cst : f32
      linalg.yield %82 : i1
    } -> tensor<1x1x8x8xi1>
    %32 = linalg.generic {indexing_maps = [#map6, #map7, #map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%31, %cst_3, %29 : tensor<1x1x8x8xi1>, tensor<f32>, tensor<2x4x8x8xf32>) outs(%28 : tensor<2x4x8x8xf32>) {
    ^bb0(%in: i1, %in_32: f32, %in_33: f32, %out: f32):
      %82 = arith.select %in, %in_32, %in_33 : f32
      linalg.yield %82 : f32
    } -> tensor<2x4x8x8xf32>
    %33 = tensor.empty() : tensor<2x4x8xi64>
    %34 = linalg.fill ins(%c0_i64 : i64) outs(%33 : tensor<2x4x8xi64>) -> tensor<2x4x8xi64>
    %35 = tensor.empty() : tensor<2x4x8xf32>
    %36 = linalg.fill ins(%cst_0 : f32) outs(%35 : tensor<2x4x8xf32>) -> tensor<2x4x8xf32>
    %37:2 = linalg.generic {indexing_maps = [#map5, #map8, #map8], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%32 : tensor<2x4x8x8xf32>) outs(%36, %34 : tensor<2x4x8xf32>, tensor<2x4x8xi64>) {
    ^bb0(%in: f32, %out: f32, %out_32: i64):
      %82 = linalg.index 3 : index
      %83 = arith.index_cast %82 : index to i64
      %84 = arith.maximumf %in, %out : f32
      %85 = arith.cmpf ogt, %in, %out : f32
      %86 = arith.select %85, %83, %out_32 : i64
      linalg.yield %84, %86 : f32, i64
    } -> (tensor<2x4x8xf32>, tensor<2x4x8xi64>)
    %expanded_21 = tensor.expand_shape %37#0 [[0], [1], [2, 3]] output_shape [2, 4, 8, 1] : tensor<2x4x8xf32> into tensor<2x4x8x1xf32>
    %38 = linalg.generic {indexing_maps = [#map5, #map9, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%32, %expanded_21 : tensor<2x4x8x8xf32>, tensor<2x4x8x1xf32>) outs(%28 : tensor<2x4x8x8xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %82 = arith.subf %in, %in_32 : f32
      linalg.yield %82 : f32
    } -> tensor<2x4x8x8xf32>
    %39 = linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%38 : tensor<2x4x8x8xf32>) outs(%28 : tensor<2x4x8x8xf32>) {
    ^bb0(%in: f32, %out: f32):
      %82 = math.exp %in : f32
      linalg.yield %82 : f32
    } -> tensor<2x4x8x8xf32>
    %40 = tensor.empty() : tensor<2x4x8x1xf32>
    %41 = linalg.fill ins(%cst : f32) outs(%40 : tensor<2x4x8x1xf32>) -> tensor<2x4x8x1xf32>
    %42 = linalg.generic {indexing_maps = [#map5, #map9], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%39 : tensor<2x4x8x8xf32>) outs(%41 : tensor<2x4x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %82 = arith.addf %in, %out : f32
      linalg.yield %82 : f32
    } -> tensor<2x4x8x1xf32>
    %43 = linalg.generic {indexing_maps = [#map5, #map9, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%39, %42 : tensor<2x4x8x8xf32>, tensor<2x4x8x1xf32>) outs(%28 : tensor<2x4x8x8xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %82 = arith.divf %in, %in_32 : f32
      linalg.yield %82 : f32
    } -> tensor<2x4x8x8xf32>
    %collapsed_22 = tensor.collapse_shape %43 [[0, 1], [2], [3]] : tensor<2x4x8x8xf32> into tensor<8x8x8xf32>
    %collapsed_23 = tensor.collapse_shape %transposed_14 [[0, 1], [2], [3]] : tensor<2x4x8x32xf32> into tensor<8x8x32xf32>
    %44 = tensor.empty() : tensor<8x8x32xf32>
    %45 = linalg.fill ins(%cst : f32) outs(%44 : tensor<8x8x32xf32>) -> tensor<8x8x32xf32>
    %46 = linalg.batch_matmul ins(%collapsed_22, %collapsed_23 : tensor<8x8x8xf32>, tensor<8x8x32xf32>) outs(%45 : tensor<8x8x32xf32>) -> tensor<8x8x32xf32>
    %expanded_24 = tensor.expand_shape %46 [[0, 1], [2], [3]] output_shape [2, 4, 8, 32] : tensor<8x8x32xf32> into tensor<2x4x8x32xf32>
    %47 = tensor.empty() : tensor<2x8x4x32xf32>
    %transposed_25 = linalg.transpose ins(%expanded_24 : tensor<2x4x8x32xf32>) outs(%47 : tensor<2x8x4x32xf32>) permutation = [0, 2, 1, 3] 
    %collapsed_26 = tensor.collapse_shape %transposed_25 [[0], [1], [2, 3]] : tensor<2x8x4x32xf32> into tensor<2x8x128xf32>
    %48 = tensor.empty() : tensor<128x128xf32>
    %transposed_27 = linalg.transpose ins(%arg6 : tensor<128x128xf32>) outs(%48 : tensor<128x128xf32>) permutation = [1, 0] 
    %49 = tensor.empty() : tensor<2x128x128xf32>
    %50 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed_27 : tensor<128x128xf32>) outs(%49 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x128xf32>
    %51 = linalg.fill ins(%cst : f32) outs(%4 : tensor<2x8x128xf32>) -> tensor<2x8x128xf32>
    %52 = linalg.batch_matmul ins(%collapsed_26, %50 : tensor<2x8x128xf32>, tensor<2x128x128xf32>) outs(%51 : tensor<2x8x128xf32>) -> tensor<2x8x128xf32>
    %53 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%52, %arg7 : tensor<2x8x128xf32>, tensor<128xf32>) outs(%4 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %82 = arith.addf %in, %in_32 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x128xf32>
    %54 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg2, %53 : tensor<2x8x128xf32>, tensor<2x8x128xf32>) outs(%4 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %82 = arith.addf %in, %in_32 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x128xf32>
    %55 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%54 : tensor<2x8x128xf32>) outs(%1 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %82 = arith.addf %in, %out : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x1xf32>
    %56 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%55 : tensor<2x8x1xf32>) outs(%0 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %82 = arith.divf %in, %cst_6 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x1xf32>
    %collapsed_28 = tensor.collapse_shape %56 [[0], [1, 2]] : tensor<2x8x1xf32> into tensor<2x8xf32>
    %57 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed_28 : tensor<2x8xf32>) outs(%4 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x8x128xf32>
    %58 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%54, %57 : tensor<2x8x128xf32>, tensor<2x8x128xf32>) outs(%4 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %82 = arith.subf %in, %in_32 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x128xf32>
    %59 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%58, %58 : tensor<2x8x128xf32>, tensor<2x8x128xf32>) outs(%4 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %82 = arith.mulf %in, %in_32 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x128xf32>
    %60 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%59 : tensor<2x8x128xf32>) outs(%1 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %82 = arith.addf %in, %out : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x1xf32>
    %61 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%60 : tensor<2x8x1xf32>) outs(%0 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %82 = arith.divf %in, %cst_6 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x1xf32>
    %62 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%61 : tensor<2x8x1xf32>) outs(%0 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %82 = arith.truncf %cst_5 : f64 to f32
      %83 = arith.addf %in, %82 : f32
      linalg.yield %83 : f32
    } -> tensor<2x8x1xf32>
    %63 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%62 : tensor<2x8x1xf32>) outs(%0 : tensor<2x8x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %82 = math.rsqrt %in : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x1xf32>
    %collapsed_29 = tensor.collapse_shape %63 [[0], [1, 2]] : tensor<2x8x1xf32> into tensor<2x8xf32>
    %64 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed_29 : tensor<2x8xf32>) outs(%4 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x8x128xf32>
    %65 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%58, %64 : tensor<2x8x128xf32>, tensor<2x8x128xf32>) outs(%4 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %82 = arith.mulf %in, %in_32 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x128xf32>
    %66 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%65, %arg8 : tensor<2x8x128xf32>, tensor<128xf32>) outs(%4 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %82 = arith.mulf %in, %in_32 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x128xf32>
    %67 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%66, %arg9 : tensor<2x8x128xf32>, tensor<128xf32>) outs(%4 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %82 = arith.addf %in, %in_32 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x128xf32>
    %68 = tensor.empty() : tensor<128x512xf32>
    %transposed_30 = linalg.transpose ins(%arg10 : tensor<512x128xf32>) outs(%68 : tensor<128x512xf32>) permutation = [1, 0] 
    %69 = tensor.empty() : tensor<2x128x512xf32>
    %70 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed_30 : tensor<128x512xf32>) outs(%69 : tensor<2x128x512xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x512xf32>
    %71 = tensor.empty() : tensor<2x8x512xf32>
    %72 = linalg.fill ins(%cst : f32) outs(%71 : tensor<2x8x512xf32>) -> tensor<2x8x512xf32>
    %73 = linalg.batch_matmul ins(%67, %70 : tensor<2x8x128xf32>, tensor<2x128x512xf32>) outs(%72 : tensor<2x8x512xf32>) -> tensor<2x8x512xf32>
    %74 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%73, %arg11 : tensor<2x8x512xf32>, tensor<512xf32>) outs(%71 : tensor<2x8x512xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %82 = arith.addf %in, %in_32 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x512xf32>
    %75 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%74 : tensor<2x8x512xf32>) outs(%71 : tensor<2x8x512xf32>) {
    ^bb0(%in: f32, %out: f32):
      %82 = arith.divf %in, %cst_7 : f32
      %83 = math.erf %82 : f32
      %84 = arith.addf %83, %cst_1 : f32
      %85 = arith.mulf %84, %cst_2 : f32
      %86 = arith.mulf %in, %85 : f32
      linalg.yield %86 : f32
    } -> tensor<2x8x512xf32>
    %76 = tensor.empty() : tensor<512x128xf32>
    %transposed_31 = linalg.transpose ins(%arg12 : tensor<128x512xf32>) outs(%76 : tensor<512x128xf32>) permutation = [1, 0] 
    %77 = tensor.empty() : tensor<2x512x128xf32>
    %78 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed_31 : tensor<512x128xf32>) outs(%77 : tensor<2x512x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x512x128xf32>
    %79 = linalg.batch_matmul ins(%75, %78 : tensor<2x8x512xf32>, tensor<2x512x128xf32>) outs(%51 : tensor<2x8x128xf32>) -> tensor<2x8x128xf32>
    %80 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%79, %arg13 : tensor<2x8x128xf32>, tensor<128xf32>) outs(%4 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %82 = arith.addf %in, %in_32 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x128xf32>
    %81 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%54, %80 : tensor<2x8x128xf32>, tensor<2x8x128xf32>) outs(%4 : tensor<2x8x128xf32>) {
    ^bb0(%in: f32, %in_32: f32, %out: f32):
      %82 = arith.addf %in, %in_32 : f32
      linalg.yield %82 : f32
    } -> tensor<2x8x128xf32>
    return %81 : tensor<2x8x128xf32>
  }
}
