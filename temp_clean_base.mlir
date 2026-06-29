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
      %79 = arith.addf %in, %out : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x1xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%2 : tensor<2x128x1xf32>) outs(%0 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %79 = arith.divf %in, %cst_6 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x1xf32>
    %4 = tensor.cast %arg14 : tensor<2x128x128xf32> to tensor<2x128x128xf32>
    %collapsed = tensor.collapse_shape %3 [[0], [1, 2]] : tensor<2x128x1xf32> into tensor<2x128xf32>
    %5 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed : tensor<2x128xf32>) outs(%4 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x128xf32>
    %6 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg2, %5 : tensor<2x128x128xf32>, tensor<2x128x128xf32>) outs(%4 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %79 = arith.subf %in, %in_30 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x128xf32>
    %7 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%6, %6 : tensor<2x128x128xf32>, tensor<2x128x128xf32>) outs(%4 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %79 = arith.mulf %in, %in_30 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x128xf32>
    %8 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%7 : tensor<2x128x128xf32>) outs(%1 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %79 = arith.addf %in, %out : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x1xf32>
    %9 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%8 : tensor<2x128x1xf32>) outs(%0 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %79 = arith.divf %in, %cst_6 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x1xf32>
    %10 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%9 : tensor<2x128x1xf32>) outs(%0 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %79 = arith.truncf %cst_5 : f64 to f32
      %80 = arith.addf %in, %79 : f32
      linalg.yield %80 : f32
    } -> tensor<2x128x1xf32>
    %11 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%10 : tensor<2x128x1xf32>) outs(%0 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %79 = math.rsqrt %in : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x1xf32>
    %collapsed_8 = tensor.collapse_shape %11 [[0], [1, 2]] : tensor<2x128x1xf32> into tensor<2x128xf32>
    %12 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed_8 : tensor<2x128xf32>) outs(%4 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x128xf32>
    %13 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%6, %12 : tensor<2x128x128xf32>, tensor<2x128x128xf32>) outs(%4 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %79 = arith.mulf %in, %in_30 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x128xf32>
    %14 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%13, %arg0 : tensor<2x128x128xf32>, tensor<128xf32>) outs(%4 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %79 = arith.mulf %in, %in_30 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x128xf32>
    %15 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%14, %arg1 : tensor<2x128x128xf32>, tensor<128xf32>) outs(%4 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %79 = arith.addf %in, %in_30 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x128xf32>
    %16 = tensor.empty() : tensor<128x384xf32>
    %transposed = linalg.transpose ins(%arg3 : tensor<384x128xf32>) outs(%16 : tensor<128x384xf32>) permutation = [1, 0] 
    %17 = tensor.empty() : tensor<2x128x384xf32>
    %18 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed : tensor<128x384xf32>) outs(%17 : tensor<2x128x384xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x384xf32>
    %19 = linalg.fill ins(%cst : f32) outs(%17 : tensor<2x128x384xf32>) -> tensor<2x128x384xf32>
    %20 = linalg.batch_matmul ins(%15, %18 : tensor<2x128x128xf32>, tensor<2x128x384xf32>) outs(%19 : tensor<2x128x384xf32>) -> tensor<2x128x384xf32>
    %21 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%20, %arg4 : tensor<2x128x384xf32>, tensor<384xf32>) outs(%17 : tensor<2x128x384xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %79 = arith.addf %in, %in_30 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x384xf32>
    %extracted_slice = tensor.extract_slice %21[0, 0, 0] [2, 128, 128] [1, 1, 1] : tensor<2x128x384xf32> to tensor<2x128x128xf32>
    %extracted_slice_9 = tensor.extract_slice %21[0, 0, 128] [2, 128, 128] [1, 1, 1] : tensor<2x128x384xf32> to tensor<2x128x128xf32>
    %extracted_slice_10 = tensor.extract_slice %21[0, 0, 256] [2, 128, 128] [1, 1, 1] : tensor<2x128x384xf32> to tensor<2x128x128xf32>
    %expanded = tensor.expand_shape %extracted_slice_9 [[0], [1], [2, 3]] output_shape [2, 128, 4, 32] : tensor<2x128x128xf32> into tensor<2x128x4x32xf32>
    %expanded_11 = tensor.expand_shape %extracted_slice [[0], [1], [2, 3]] output_shape [2, 128, 4, 32] : tensor<2x128x128xf32> into tensor<2x128x4x32xf32>
    %22 = tensor.empty() : tensor<2x4x128x32xf32>
    %transposed_12 = linalg.transpose ins(%expanded_11 : tensor<2x128x4x32xf32>) outs(%22 : tensor<2x4x128x32xf32>) permutation = [0, 2, 1, 3] 
    %expanded_13 = tensor.expand_shape %extracted_slice_10 [[0], [1], [2, 3]] output_shape [2, 128, 4, 32] : tensor<2x128x128xf32> into tensor<2x128x4x32xf32>
    %transposed_14 = linalg.transpose ins(%expanded_13 : tensor<2x128x4x32xf32>) outs(%22 : tensor<2x4x128x32xf32>) permutation = [0, 2, 1, 3] 
    %23 = tensor.empty() : tensor<2x4x32x128xf32>
    %transposed_15 = linalg.transpose ins(%expanded : tensor<2x128x4x32xf32>) outs(%23 : tensor<2x4x32x128xf32>) permutation = [0, 2, 3, 1] 
    %collapsed_16 = tensor.collapse_shape %transposed_12 [[0, 1], [2], [3]] : tensor<2x4x128x32xf32> into tensor<8x128x32xf32>
    %collapsed_17 = tensor.collapse_shape %transposed_15 [[0, 1], [2], [3]] : tensor<2x4x32x128xf32> into tensor<8x32x128xf32>
    %24 = tensor.empty() : tensor<8x128x128xf32>
    %25 = linalg.fill ins(%cst : f32) outs(%24 : tensor<8x128x128xf32>) -> tensor<8x128x128xf32>
    %26 = linalg.batch_matmul ins(%collapsed_16, %collapsed_17 : tensor<8x128x32xf32>, tensor<8x32x128xf32>) outs(%25 : tensor<8x128x128xf32>) -> tensor<8x128x128xf32>
    %expanded_18 = tensor.expand_shape %26 [[0, 1], [2], [3]] output_shape [2, 4, 128, 128] : tensor<8x128x128xf32> into tensor<2x4x128x128xf32>
    %27 = tensor.empty() : tensor<2x4x128x128xf32>
    %28 = linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%expanded_18 : tensor<2x4x128x128xf32>) outs(%27 : tensor<2x4x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      %79 = arith.truncf %cst_4 : f64 to f32
      %80 = arith.mulf %in, %79 : f32
      linalg.yield %80 : f32
    } -> tensor<2x4x128x128xf32>
    %29 = tensor.empty() : tensor<1x1x128x128xi1>
    %30 = linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg5 : tensor<1x1x128x128xf32>) outs(%29 : tensor<1x1x128x128xi1>) {
    ^bb0(%in: f32, %out: i1):
      %79 = arith.cmpf oeq, %in, %cst : f32
      linalg.yield %79 : i1
    } -> tensor<1x1x128x128xi1>
    %31 = linalg.generic {indexing_maps = [#map6, #map7, #map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%30, %cst_3, %28 : tensor<1x1x128x128xi1>, tensor<f32>, tensor<2x4x128x128xf32>) outs(%27 : tensor<2x4x128x128xf32>) {
    ^bb0(%in: i1, %in_30: f32, %in_31: f32, %out: f32):
      %79 = arith.select %in, %in_30, %in_31 : f32
      linalg.yield %79 : f32
    } -> tensor<2x4x128x128xf32>
    %32 = tensor.empty() : tensor<2x4x128xi64>
    %33 = linalg.fill ins(%c0_i64 : i64) outs(%32 : tensor<2x4x128xi64>) -> tensor<2x4x128xi64>
    %34 = tensor.empty() : tensor<2x4x128xf32>
    %35 = linalg.fill ins(%cst_0 : f32) outs(%34 : tensor<2x4x128xf32>) -> tensor<2x4x128xf32>
    %36:2 = linalg.generic {indexing_maps = [#map5, #map8, #map8], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%31 : tensor<2x4x128x128xf32>) outs(%35, %33 : tensor<2x4x128xf32>, tensor<2x4x128xi64>) {
    ^bb0(%in: f32, %out: f32, %out_30: i64):
      %79 = linalg.index 3 : index
      %80 = arith.index_cast %79 : index to i64
      %81 = arith.maximumf %in, %out : f32
      %82 = arith.cmpf ogt, %in, %out : f32
      %83 = arith.select %82, %80, %out_30 : i64
      linalg.yield %81, %83 : f32, i64
    } -> (tensor<2x4x128xf32>, tensor<2x4x128xi64>)
    %expanded_19 = tensor.expand_shape %36#0 [[0], [1], [2, 3]] output_shape [2, 4, 128, 1] : tensor<2x4x128xf32> into tensor<2x4x128x1xf32>
    %37 = linalg.generic {indexing_maps = [#map5, #map9, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%31, %expanded_19 : tensor<2x4x128x128xf32>, tensor<2x4x128x1xf32>) outs(%27 : tensor<2x4x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %79 = arith.subf %in, %in_30 : f32
      linalg.yield %79 : f32
    } -> tensor<2x4x128x128xf32>
    %38 = linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%37 : tensor<2x4x128x128xf32>) outs(%27 : tensor<2x4x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      %79 = math.exp %in : f32
      linalg.yield %79 : f32
    } -> tensor<2x4x128x128xf32>
    %39 = tensor.empty() : tensor<2x4x128x1xf32>
    %40 = linalg.fill ins(%cst : f32) outs(%39 : tensor<2x4x128x1xf32>) -> tensor<2x4x128x1xf32>
    %41 = linalg.generic {indexing_maps = [#map5, #map9], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%38 : tensor<2x4x128x128xf32>) outs(%40 : tensor<2x4x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %79 = arith.addf %in, %out : f32
      linalg.yield %79 : f32
    } -> tensor<2x4x128x1xf32>
    %42 = linalg.generic {indexing_maps = [#map5, #map9, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%38, %41 : tensor<2x4x128x128xf32>, tensor<2x4x128x1xf32>) outs(%27 : tensor<2x4x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %79 = arith.divf %in, %in_30 : f32
      linalg.yield %79 : f32
    } -> tensor<2x4x128x128xf32>
    %collapsed_20 = tensor.collapse_shape %42 [[0, 1], [2], [3]] : tensor<2x4x128x128xf32> into tensor<8x128x128xf32>
    %collapsed_21 = tensor.collapse_shape %transposed_14 [[0, 1], [2], [3]] : tensor<2x4x128x32xf32> into tensor<8x128x32xf32>
    %43 = tensor.empty() : tensor<8x128x32xf32>
    %44 = linalg.fill ins(%cst : f32) outs(%43 : tensor<8x128x32xf32>) -> tensor<8x128x32xf32>
    %45 = linalg.batch_matmul ins(%collapsed_20, %collapsed_21 : tensor<8x128x128xf32>, tensor<8x128x32xf32>) outs(%44 : tensor<8x128x32xf32>) -> tensor<8x128x32xf32>
    %expanded_22 = tensor.expand_shape %45 [[0, 1], [2], [3]] output_shape [2, 4, 128, 32] : tensor<8x128x32xf32> into tensor<2x4x128x32xf32>
    %46 = tensor.empty() : tensor<2x128x4x32xf32>
    %transposed_23 = linalg.transpose ins(%expanded_22 : tensor<2x4x128x32xf32>) outs(%46 : tensor<2x128x4x32xf32>) permutation = [0, 2, 1, 3] 
    %collapsed_24 = tensor.collapse_shape %transposed_23 [[0], [1], [2, 3]] : tensor<2x128x4x32xf32> into tensor<2x128x128xf32>
    %47 = tensor.empty() : tensor<128x128xf32>
    %transposed_25 = linalg.transpose ins(%arg6 : tensor<128x128xf32>) outs(%47 : tensor<128x128xf32>) permutation = [1, 0] 
    %48 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed_25 : tensor<128x128xf32>) outs(%4 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x128xf32>
    %49 = linalg.fill ins(%cst : f32) outs(%4 : tensor<2x128x128xf32>) -> tensor<2x128x128xf32>
    %50 = linalg.batch_matmul ins(%collapsed_24, %48 : tensor<2x128x128xf32>, tensor<2x128x128xf32>) outs(%49 : tensor<2x128x128xf32>) -> tensor<2x128x128xf32>
    %51 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%50, %arg7 : tensor<2x128x128xf32>, tensor<128xf32>) outs(%4 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %79 = arith.addf %in, %in_30 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x128xf32>
    %52 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg2, %51 : tensor<2x128x128xf32>, tensor<2x128x128xf32>) outs(%4 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %79 = arith.addf %in, %in_30 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x128xf32>
    %53 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%52 : tensor<2x128x128xf32>) outs(%1 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %79 = arith.addf %in, %out : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x1xf32>
    %54 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%53 : tensor<2x128x1xf32>) outs(%0 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %79 = arith.divf %in, %cst_6 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x1xf32>
    %collapsed_26 = tensor.collapse_shape %54 [[0], [1, 2]] : tensor<2x128x1xf32> into tensor<2x128xf32>
    %55 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed_26 : tensor<2x128xf32>) outs(%4 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x128xf32>
    %56 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%52, %55 : tensor<2x128x128xf32>, tensor<2x128x128xf32>) outs(%4 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %79 = arith.subf %in, %in_30 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x128xf32>
    %57 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%56, %56 : tensor<2x128x128xf32>, tensor<2x128x128xf32>) outs(%4 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %79 = arith.mulf %in, %in_30 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x128xf32>
    %58 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%57 : tensor<2x128x128xf32>) outs(%1 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %79 = arith.addf %in, %out : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x1xf32>
    %59 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%58 : tensor<2x128x1xf32>) outs(%0 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %79 = arith.divf %in, %cst_6 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x1xf32>
    %60 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%59 : tensor<2x128x1xf32>) outs(%0 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %79 = arith.truncf %cst_5 : f64 to f32
      %80 = arith.addf %in, %79 : f32
      linalg.yield %80 : f32
    } -> tensor<2x128x1xf32>
    %61 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%60 : tensor<2x128x1xf32>) outs(%0 : tensor<2x128x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %79 = math.rsqrt %in : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x1xf32>
    %collapsed_27 = tensor.collapse_shape %61 [[0], [1, 2]] : tensor<2x128x1xf32> into tensor<2x128xf32>
    %62 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed_27 : tensor<2x128xf32>) outs(%4 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x128xf32>
    %63 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%56, %62 : tensor<2x128x128xf32>, tensor<2x128x128xf32>) outs(%4 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %79 = arith.mulf %in, %in_30 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x128xf32>
    %64 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%63, %arg8 : tensor<2x128x128xf32>, tensor<128xf32>) outs(%4 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %79 = arith.mulf %in, %in_30 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x128xf32>
    %65 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%64, %arg9 : tensor<2x128x128xf32>, tensor<128xf32>) outs(%4 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %79 = arith.addf %in, %in_30 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x128xf32>
    %66 = tensor.empty() : tensor<128x512xf32>
    %transposed_28 = linalg.transpose ins(%arg10 : tensor<512x128xf32>) outs(%66 : tensor<128x512xf32>) permutation = [1, 0] 
    %67 = tensor.empty() : tensor<2x128x512xf32>
    %68 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed_28 : tensor<128x512xf32>) outs(%67 : tensor<2x128x512xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x512xf32>
    %69 = linalg.fill ins(%cst : f32) outs(%67 : tensor<2x128x512xf32>) -> tensor<2x128x512xf32>
    %70 = linalg.batch_matmul ins(%65, %68 : tensor<2x128x128xf32>, tensor<2x128x512xf32>) outs(%69 : tensor<2x128x512xf32>) -> tensor<2x128x512xf32>
    %71 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%70, %arg11 : tensor<2x128x512xf32>, tensor<512xf32>) outs(%67 : tensor<2x128x512xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %79 = arith.addf %in, %in_30 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x512xf32>
    %72 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%71 : tensor<2x128x512xf32>) outs(%67 : tensor<2x128x512xf32>) {
    ^bb0(%in: f32, %out: f32):
      %79 = arith.divf %in, %cst_7 : f32
      %80 = math.erf %79 : f32
      %81 = arith.addf %80, %cst_1 : f32
      %82 = arith.mulf %81, %cst_2 : f32
      %83 = arith.mulf %in, %82 : f32
      linalg.yield %83 : f32
    } -> tensor<2x128x512xf32>
    %73 = tensor.empty() : tensor<512x128xf32>
    %transposed_29 = linalg.transpose ins(%arg12 : tensor<128x512xf32>) outs(%73 : tensor<512x128xf32>) permutation = [1, 0] 
    %74 = tensor.empty() : tensor<2x512x128xf32>
    %75 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed_29 : tensor<512x128xf32>) outs(%74 : tensor<2x512x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x512x128xf32>
    %76 = linalg.batch_matmul ins(%72, %75 : tensor<2x128x512xf32>, tensor<2x512x128xf32>) outs(%49 : tensor<2x128x128xf32>) -> tensor<2x128x128xf32>
    %77 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%76, %arg13 : tensor<2x128x128xf32>, tensor<128xf32>) outs(%4 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %79 = arith.addf %in, %in_30 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x128xf32>
    %78 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%52, %77 : tensor<2x128x128xf32>, tensor<2x128x128xf32>) outs(%4 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %in_30: f32, %out: f32):
      %79 = arith.addf %in, %in_30 : f32
      linalg.yield %79 : f32
    } -> tensor<2x128x128xf32>
    return %78 : tensor<2x128x128xf32>
  }
}
