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
  func.func @main(%arg0: tensor<128xf32>, %arg1: tensor<128xf32>, %arg2: tensor<2x128x128xf32>, %arg3: tensor<384x128xf32>, %arg4: tensor<384xf32>, %arg5: tensor<1x1x128x128xf32>, %arg6: tensor<128x128xf32>, %arg7: tensor<128xf32>, %arg8: tensor<128xf32>, %arg9: tensor<128xf32>, %arg10: tensor<512x128xf32>, %arg11: tensor<512xf32>, %arg12: tensor<128x512xf32>, %arg13: tensor<128xf32>, %arg14: tensor<2x128x128xf32>) -> tensor<2x128x128xf32> {
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
    %0 = tensor.empty() : tensor<2x128x1xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<2x128x1xf32>) -> tensor<2x128x1xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg2 : tensor<2x128x128xf32>) outs(%1 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %78 = arith.addf %in, %out : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x1xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%2 : tensor<2x128x1xf32>) outs(%0 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %78 = arith.divf %in, %cst_6 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x1xf32>
    %collapsed = tensor.collapse_shape %3 [[0], [1, 2]] : tensor<2x128x1xf32> into tensor<2x128xf32>
    %4 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed : tensor<2x128xf32>) outs(%arg14 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x128xf32>
    %5 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg2, %4 : tensor<2x128x128xf32>, tensor<2x128x128xf32>) outs(%arg14 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %78 = arith.subf %in, %in_30 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x128xf32>
    %6 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%5, %5 : tensor<2x128x128xf32>, tensor<2x128x128xf32>) outs(%arg14 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %78 = arith.mulf %in, %in_30 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x128xf32>
    %7 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%6 : tensor<2x128x128xf32>) outs(%1 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %78 = arith.addf %in, %out : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x1xf32>
    %8 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%7 : tensor<2x128x1xf32>) outs(%0 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %78 = arith.divf %in, %cst_6 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x1xf32>
    %9 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%8 : tensor<2x128x1xf32>) outs(%0 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %78 = arith.truncf %cst_5 : f64 to f32
      %79 = arith.addf %in, %78 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x1xf32>
    %10 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%9 : tensor<2x128x1xf32>) outs(%0 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %78 = math.rsqrt %in : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x1xf32>
    %collapsed_8 = tensor.collapse_shape %10 [[0], [1, 2]] : tensor<2x128x1xf32> into tensor<2x128xf32>
    %11 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed_8 : tensor<2x128xf32>) outs(%arg14 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x128xf32>
    %12 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%5, %11 : tensor<2x128x128xf32>, tensor<2x128x128xf32>) outs(%arg14 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %78 = arith.mulf %in, %in_30 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x128xf32>
    %13 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%12, %arg0 : tensor<2x128x128xf32>, tensor<128xf32>) outs(%arg14 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %78 = arith.mulf %in, %in_30 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x128xf32>
    %14 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%13, %arg1 : tensor<2x128x128xf32>, tensor<128xf32>) outs(%arg14 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %78 = arith.addf %in, %in_30 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x128xf32>
    %15 = tensor.empty() : tensor<128x384xf32>
    %transposed = linalg.transpose ins(%arg3 : tensor<384x128xf32>) outs(%15 : tensor<128x384xf32>) permutation = [1, 0] 
    %16 = tensor.empty() : tensor<2x128x384xf32>
    %17 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed : tensor<128x384xf32>) outs(%16 : tensor<2x128x384xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x384xf32>
    %18 = linalg.fill ins(%cst : f32) outs(%16 : tensor<2x128x384xf32>) -> tensor<2x128x384xf32>
    %19 = linalg.batch_matmul ins(%14, %17 : tensor<2x128x128xf32>, tensor<2x128x384xf32>) outs(%18 : tensor<2x128x384xf32>) -> tensor<2x128x384xf32>
    %20 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%19, %arg4 : tensor<2x128x384xf32>, tensor<384xf32>) outs(%16 : tensor<2x128x384xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %78 = arith.addf %in, %in_30 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x384xf32>
    %extracted_slice = tensor.extract_slice %20[0, 0, 0] [2, 128, 128] [1, 1, 1] : tensor<2x128x384xf32> to tensor<2x128x128xf32>
    %extracted_slice_9 = tensor.extract_slice %20[0, 0, 128] [2, 128, 128] [1, 1, 1] : tensor<2x128x384xf32> to tensor<2x128x128xf32>
    %extracted_slice_10 = tensor.extract_slice %20[0, 0, 256] [2, 128, 128] [1, 1, 1] : tensor<2x128x384xf32> to tensor<2x128x128xf32>
    %expanded = tensor.expand_shape %extracted_slice_9 [[0], [1], [2, 3]] output_shape [2, 128, 4, 32] : tensor<2x128x128xf32> into tensor<2x128x4x32xf32>
    %expanded_11 = tensor.expand_shape %extracted_slice [[0], [1], [2, 3]] output_shape [2, 128, 4, 32] : tensor<2x128x128xf32> into tensor<2x128x4x32xf32>
    %21 = tensor.empty() : tensor<2x4x128x32xf32>
    %transposed_12 = linalg.transpose ins(%expanded_11 : tensor<2x128x4x32xf32>) outs(%21 : tensor<2x4x128x32xf32>) permutation = [0, 2, 1, 3] 
    %expanded_13 = tensor.expand_shape %extracted_slice_10 [[0], [1], [2, 3]] output_shape [2, 128, 4, 32] : tensor<2x128x128xf32> into tensor<2x128x4x32xf32>
    %transposed_14 = linalg.transpose ins(%expanded_13 : tensor<2x128x4x32xf32>) outs(%21 : tensor<2x4x128x32xf32>) permutation = [0, 2, 1, 3] 
    %22 = tensor.empty() : tensor<2x4x32x128xf32>
    %transposed_15 = linalg.transpose ins(%expanded : tensor<2x128x4x32xf32>) outs(%22 : tensor<2x4x32x128xf32>) permutation = [0, 2, 3, 1] 
    %collapsed_16 = tensor.collapse_shape %transposed_12 [[0, 1], [2], [3]] : tensor<2x4x128x32xf32> into tensor<8x128x32xf32>
    %collapsed_17 = tensor.collapse_shape %transposed_15 [[0, 1], [2], [3]] : tensor<2x4x32x128xf32> into tensor<8x32x128xf32>
    %23 = tensor.empty() : tensor<8x128x128xf32>
    %24 = linalg.fill ins(%cst : f32) outs(%23 : tensor<8x128x128xf32>) -> tensor<8x128x128xf32>
    %25 = linalg.batch_matmul ins(%collapsed_16, %collapsed_17 : tensor<8x128x32xf32>, tensor<8x32x128xf32>) outs(%24 : tensor<8x128x128xf32>) -> tensor<8x128x128xf32>
    %expanded_18 = tensor.expand_shape %25 [[0, 1], [2], [3]] output_shape [2, 4, 128, 128] : tensor<8x128x128xf32> into tensor<2x4x128x128xf32>
    %26 = tensor.empty() : tensor<2x4x128x128xf32>
    %27 = linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%expanded_18 : tensor<2x4x128x128xf32>) outs(%26 : tensor<2x4x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      %78 = arith.truncf %cst_4 : f64 to f32
      %79 = arith.mulf %in, %78 : f32
      linalg.yield %79 : f32
    } -> tensor<2x4x128x128xf32>
    %28 = tensor.empty() : tensor<1x1x128x128xi1>
    %29 = linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg5 : tensor<1x1x128x128xf32>) outs(%28 : tensor<1x1x128x128xi1>) {
    ^bb0(%in: f32, %out: i1):
      %78 = arith.cmpf oeq, %in, %cst : f32
      linalg.yield %78 : i1
    } -> tensor<1x1x128x128xi1>
    %30 = linalg.generic {indexing_maps = [#map6, #map7, #map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%29, %cst_3, %27 : tensor<1x1x128x128xi1>, tensor<f32>, tensor<2x4x128x128xf32>) outs(%26 : tensor<2x4x128x128xf32>) {
    ^bb0(%in: i1, %in_30: f32, %in_31: f32, %out: f32):
      %78 = arith.select %in, %in_30, %in_31 : f32
      linalg.yield %78 : f32
    } -> tensor<2x4x128x128xf32>
    %31 = tensor.empty() : tensor<2x4x128xi64>
    %32 = linalg.fill ins(%c0_i64 : i64) outs(%31 : tensor<2x4x128xi64>) -> tensor<2x4x128xi64>
    %33 = tensor.empty() : tensor<2x4x128xf32>
    %34 = linalg.fill ins(%cst_0 : f32) outs(%33 : tensor<2x4x128xf32>) -> tensor<2x4x128xf32>
    %35:2 = linalg.generic {indexing_maps = [#map5, #map8, #map8], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%30 : tensor<2x4x128x128xf32>) outs(%34, %32 : tensor<2x4x128xf32>, tensor<2x4x128xi64>) {
    ^bb0(%in: f32, %out: f32, %out_30: i64):
      %78 = linalg.index 3 : index
      %79 = arith.index_cast %78 : index to i64
      %80 = arith.maximumf %in, %out : f32
      %81 = arith.cmpf ogt, %in, %out : f32
      %82 = arith.select %81, %79, %out_30 : i64
      linalg.yield %80, %82 : f32, i64
    } -> (tensor<2x4x128xf32>, tensor<2x4x128xi64>)
    %expanded_19 = tensor.expand_shape %35#0 [[0], [1], [2, 3]] output_shape [2, 4, 128, 1] : tensor<2x4x128xf32> into tensor<2x4x128x1xf32>
    %36 = linalg.generic {indexing_maps = [#map5, #map9, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%30, %expanded_19 : tensor<2x4x128x128xf32>, tensor<2x4x128x1xf32>) outs(%26 : tensor<2x4x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %78 = arith.subf %in, %in_30 : f32
      linalg.yield %78 : f32
    } -> tensor<2x4x128x128xf32>
    %37 = linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%36 : tensor<2x4x128x128xf32>) outs(%26 : tensor<2x4x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      %78 = math.exp %in : f32
      linalg.yield %78 : f32
    } -> tensor<2x4x128x128xf32>
    %38 = tensor.empty() : tensor<2x4x128x1xf32>
    %39 = linalg.fill ins(%cst : f32) outs(%38 : tensor<2x4x128x1xf32>) -> tensor<2x4x128x1xf32>
    %40 = linalg.generic {indexing_maps = [#map5, #map9], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%37 : tensor<2x4x128x128xf32>) outs(%39 : tensor<2x4x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %78 = arith.addf %in, %out : f32
      linalg.yield %78 : f32
    } -> tensor<2x4x128x1xf32>
    %41 = linalg.generic {indexing_maps = [#map5, #map9, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%37, %40 : tensor<2x4x128x128xf32>, tensor<2x4x128x1xf32>) outs(%26 : tensor<2x4x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %78 = arith.divf %in, %in_30 : f32
      linalg.yield %78 : f32
    } -> tensor<2x4x128x128xf32>
    %collapsed_20 = tensor.collapse_shape %41 [[0, 1], [2], [3]] : tensor<2x4x128x128xf32> into tensor<8x128x128xf32>
    %collapsed_21 = tensor.collapse_shape %transposed_14 [[0, 1], [2], [3]] : tensor<2x4x128x32xf32> into tensor<8x128x32xf32>
    %42 = tensor.empty() : tensor<8x128x32xf32>
    %43 = linalg.fill ins(%cst : f32) outs(%42 : tensor<8x128x32xf32>) -> tensor<8x128x32xf32>
    %44 = linalg.batch_matmul ins(%collapsed_20, %collapsed_21 : tensor<8x128x128xf32>, tensor<8x128x32xf32>) outs(%43 : tensor<8x128x32xf32>) -> tensor<8x128x32xf32>
    %expanded_22 = tensor.expand_shape %44 [[0, 1], [2], [3]] output_shape [2, 4, 128, 32] : tensor<8x128x32xf32> into tensor<2x4x128x32xf32>
    %45 = tensor.empty() : tensor<2x128x4x32xf32>
    %transposed_23 = linalg.transpose ins(%expanded_22 : tensor<2x4x128x32xf32>) outs(%45 : tensor<2x128x4x32xf32>) permutation = [0, 2, 1, 3] 
    %collapsed_24 = tensor.collapse_shape %transposed_23 [[0], [1], [2, 3]] : tensor<2x128x4x32xf32> into tensor<2x128x128xf32>
    %46 = tensor.empty() : tensor<128x128xf32>
    %transposed_25 = linalg.transpose ins(%arg6 : tensor<128x128xf32>) outs(%46 : tensor<128x128xf32>) permutation = [1, 0] 
    %47 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed_25 : tensor<128x128xf32>) outs(%arg14 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x128xf32>
    %48 = linalg.fill ins(%cst : f32) outs(%arg14 : tensor<2x128x128xf32>) -> tensor<2x128x128xf32>
    %49 = linalg.batch_matmul ins(%collapsed_24, %47 : tensor<2x128x128xf32>, tensor<2x128x128xf32>) outs(%48 : tensor<2x128x128xf32>) -> tensor<2x128x128xf32>
    %50 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%49, %arg7 : tensor<2x128x128xf32>, tensor<128xf32>) outs(%arg14 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %78 = arith.addf %in, %in_30 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x128xf32>
    %51 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg2, %50 : tensor<2x128x128xf32>, tensor<2x128x128xf32>) outs(%arg14 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %78 = arith.addf %in, %in_30 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x128xf32>
    %52 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%51 : tensor<2x128x128xf32>) outs(%1 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %78 = arith.addf %in, %out : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x1xf32>
    %53 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%52 : tensor<2x128x1xf32>) outs(%0 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %78 = arith.divf %in, %cst_6 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x1xf32>
    %collapsed_26 = tensor.collapse_shape %53 [[0], [1, 2]] : tensor<2x128x1xf32> into tensor<2x128xf32>
    %54 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed_26 : tensor<2x128xf32>) outs(%arg14 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x128xf32>
    %55 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%51, %54 : tensor<2x128x128xf32>, tensor<2x128x128xf32>) outs(%arg14 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %78 = arith.subf %in, %in_30 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x128xf32>
    %56 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%55, %55 : tensor<2x128x128xf32>, tensor<2x128x128xf32>) outs(%arg14 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %78 = arith.mulf %in, %in_30 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x128xf32>
    %57 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%56 : tensor<2x128x128xf32>) outs(%1 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %78 = arith.addf %in, %out : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x1xf32>
    %58 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%57 : tensor<2x128x1xf32>) outs(%0 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %78 = arith.divf %in, %cst_6 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x1xf32>
    %59 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%58 : tensor<2x128x1xf32>) outs(%0 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %78 = arith.truncf %cst_5 : f64 to f32
      %79 = arith.addf %in, %78 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x1xf32>
    %60 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%59 : tensor<2x128x1xf32>) outs(%0 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %78 = math.rsqrt %in : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x1xf32>
    %collapsed_27 = tensor.collapse_shape %60 [[0], [1, 2]] : tensor<2x128x1xf32> into tensor<2x128xf32>
    %61 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed_27 : tensor<2x128xf32>) outs(%arg14 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x128xf32>
    %62 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%55, %61 : tensor<2x128x128xf32>, tensor<2x128x128xf32>) outs(%arg14 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %78 = arith.mulf %in, %in_30 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x128xf32>
    %63 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%62, %arg8 : tensor<2x128x128xf32>, tensor<128xf32>) outs(%arg14 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %78 = arith.mulf %in, %in_30 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x128xf32>
    %64 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%63, %arg9 : tensor<2x128x128xf32>, tensor<128xf32>) outs(%arg14 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %78 = arith.addf %in, %in_30 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x128xf32>
    %65 = tensor.empty() : tensor<128x512xf32>
    %transposed_28 = linalg.transpose ins(%arg10 : tensor<512x128xf32>) outs(%65 : tensor<128x512xf32>) permutation = [1, 0] 
    %66 = tensor.empty() : tensor<2x128x512xf32>
    %67 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed_28 : tensor<128x512xf32>) outs(%66 : tensor<2x128x512xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x512xf32>
    %68 = linalg.fill ins(%cst : f32) outs(%66 : tensor<2x128x512xf32>) -> tensor<2x128x512xf32>
    %69 = linalg.batch_matmul ins(%64, %67 : tensor<2x128x128xf32>, tensor<2x128x512xf32>) outs(%68 : tensor<2x128x512xf32>) -> tensor<2x128x512xf32>
    %70 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%69, %arg11 : tensor<2x128x512xf32>, tensor<512xf32>) outs(%66 : tensor<2x128x512xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %78 = arith.addf %in, %in_30 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x512xf32>
    %71 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%70 : tensor<2x128x512xf32>) outs(%66 : tensor<2x128x512xf32>) {
    ^bb0(%in: f32, %out: f32):
      %78 = arith.divf %in, %cst_7 : f32
      %79 = math.erf %78 : f32
      %80 = arith.addf %79, %cst_1 : f32
      %81 = arith.mulf %80, %cst_2 : f32
      %82 = arith.mulf %in, %81 : f32
      linalg.yield %82 : f32
    } -> tensor<2x128x512xf32>
    %72 = tensor.empty() : tensor<512x128xf32>
    %transposed_29 = linalg.transpose ins(%arg12 : tensor<128x512xf32>) outs(%72 : tensor<512x128xf32>) permutation = [1, 0] 
    %73 = tensor.empty() : tensor<2x512x128xf32>
    %74 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed_29 : tensor<512x128xf32>) outs(%73 : tensor<2x512x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x512x128xf32>
    %75 = linalg.batch_matmul ins(%71, %74 : tensor<2x128x512xf32>, tensor<2x512x128xf32>) outs(%48 : tensor<2x128x128xf32>) -> tensor<2x128x128xf32>
    %76 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%75, %arg13 : tensor<2x128x128xf32>, tensor<128xf32>) outs(%arg14 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %78 = arith.addf %in, %in_30 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x128xf32>
    %77 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%51, %76 : tensor<2x128x128xf32>, tensor<2x128x128xf32>) outs(%arg14 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %78 = arith.addf %in, %in_30 : f32
      linalg.yield %78 : f32
    } -> tensor<2x128x128xf32>
    return %77 : tensor<2x128x128xf32>
  }
  transform.named_sequence @__transform_main(%arg0: !transform.any_op) {
    transform.yield 
  }
}

