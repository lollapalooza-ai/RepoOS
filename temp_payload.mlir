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
  func.func @main(%arg0: tensor<128xf32>, %arg1: tensor<128xf32>, %arg2: tensor<2x1024x128xf32>, %arg3: tensor<384x128xf32>, %arg4: tensor<384xf32>, %arg5: tensor<1x1x1024x1024xf32>, %arg6: tensor<128x128xf32>, %arg7: tensor<128xf32>, %arg8: tensor<128xf32>, %arg9: tensor<128xf32>, %arg10: tensor<512x128xf32>, %arg11: tensor<512xf32>, %arg12: tensor<128x512xf32>, %arg13: tensor<128xf32>, %arg14: tensor<128xf32>, %arg15: tensor<128xf32>, %arg16: tensor<384x128xf32>, %arg17: tensor<384xf32>, %arg18: tensor<1x1x1024x1024xf32>, %arg19: tensor<128x128xf32>, %arg20: tensor<128xf32>, %arg21: tensor<128xf32>, %arg22: tensor<128xf32>, %arg23: tensor<512x128xf32>, %arg24: tensor<512xf32>, %arg25: tensor<128x512xf32>, %arg26: tensor<128xf32>, %arg27: tensor<2x1024x128xf32>) -> tensor<2x1024x128xf32> {
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
    %0 = tensor.empty() : tensor<2x1024x1xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<2x1024x1xf32>) -> tensor<2x1024x1xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg2 : tensor<2x1024x128xf32>) outs(%1 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.addf %in, %out : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%2 : tensor<2x1024x1xf32>) outs(%0 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.divf %in, %cst_6 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %collapsed = tensor.collapse_shape %3 [[0], [1, 2]] : tensor<2x1024x1xf32> into tensor<2x1024xf32>
    %4 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed : tensor<2x1024xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x1024x128xf32>
    %5 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg2, %4 : tensor<2x1024x128xf32>, tensor<2x1024x128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.subf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %6 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%5, %5 : tensor<2x1024x128xf32>, tensor<2x1024x128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.mulf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %7 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%6 : tensor<2x1024x128xf32>) outs(%1 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.addf %in, %out : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %8 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%7 : tensor<2x1024x1xf32>) outs(%0 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.divf %in, %cst_6 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %9 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%8 : tensor<2x1024x1xf32>) outs(%0 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.truncf %cst_5 : f64 to f32
      %133 = arith.addf %in, %132 : f32
      linalg.yield %133 : f32
    } -> tensor<2x1024x1xf32>
    %10 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%9 : tensor<2x1024x1xf32>) outs(%0 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = math.rsqrt %in : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %collapsed_8 = tensor.collapse_shape %10 [[0], [1, 2]] : tensor<2x1024x1xf32> into tensor<2x1024xf32>
    %11 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed_8 : tensor<2x1024xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x1024x128xf32>
    %12 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%5, %11 : tensor<2x1024x128xf32>, tensor<2x1024x128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.mulf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %13 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%12, %arg0 : tensor<2x1024x128xf32>, tensor<128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.mulf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %14 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%13, %arg1 : tensor<2x1024x128xf32>, tensor<128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.addf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %15 = tensor.empty() : tensor<128x384xf32>
    %transposed = linalg.transpose ins(%arg3 : tensor<384x128xf32>) outs(%15 : tensor<128x384xf32>) permutation = [1, 0] 
    %16 = tensor.empty() : tensor<2x128x384xf32>
    %17 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed : tensor<128x384xf32>) outs(%16 : tensor<2x128x384xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x384xf32>
    %18 = tensor.empty() : tensor<2x1024x384xf32>
    %19 = linalg.fill ins(%cst : f32) outs(%18 : tensor<2x1024x384xf32>) -> tensor<2x1024x384xf32>
    %20 = linalg.batch_matmul ins(%14, %17 : tensor<2x1024x128xf32>, tensor<2x128x384xf32>) outs(%19 : tensor<2x1024x384xf32>) -> tensor<2x1024x384xf32>
    %21 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%20, %arg4 : tensor<2x1024x384xf32>, tensor<384xf32>) outs(%18 : tensor<2x1024x384xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.addf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x384xf32>
    %extracted_slice = tensor.extract_slice %21[0, 0, 0] [2, 1024, 128] [1, 1, 1] : tensor<2x1024x384xf32> to tensor<2x1024x128xf32>
    %extracted_slice_9 = tensor.extract_slice %21[0, 0, 128] [2, 1024, 128] [1, 1, 1] : tensor<2x1024x384xf32> to tensor<2x1024x128xf32>
    %extracted_slice_10 = tensor.extract_slice %21[0, 0, 256] [2, 1024, 128] [1, 1, 1] : tensor<2x1024x384xf32> to tensor<2x1024x128xf32>
    %expanded = tensor.expand_shape %extracted_slice_9 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : tensor<2x1024x128xf32> into tensor<2x1024x4x32xf32>
    %expanded_11 = tensor.expand_shape %extracted_slice [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : tensor<2x1024x128xf32> into tensor<2x1024x4x32xf32>
    %22 = tensor.empty() : tensor<2x4x1024x32xf32>
    %transposed_12 = linalg.transpose ins(%expanded_11 : tensor<2x1024x4x32xf32>) outs(%22 : tensor<2x4x1024x32xf32>) permutation = [0, 2, 1, 3] 
    %expanded_13 = tensor.expand_shape %extracted_slice_10 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : tensor<2x1024x128xf32> into tensor<2x1024x4x32xf32>
    %transposed_14 = linalg.transpose ins(%expanded_13 : tensor<2x1024x4x32xf32>) outs(%22 : tensor<2x4x1024x32xf32>) permutation = [0, 2, 1, 3] 
    %23 = tensor.empty() : tensor<2x4x32x1024xf32>
    %transposed_15 = linalg.transpose ins(%expanded : tensor<2x1024x4x32xf32>) outs(%23 : tensor<2x4x32x1024xf32>) permutation = [0, 2, 3, 1] 
    %collapsed_16 = tensor.collapse_shape %transposed_12 [[0, 1], [2], [3]] : tensor<2x4x1024x32xf32> into tensor<8x1024x32xf32>
    %collapsed_17 = tensor.collapse_shape %transposed_15 [[0, 1], [2], [3]] : tensor<2x4x32x1024xf32> into tensor<8x32x1024xf32>
    %24 = tensor.empty() : tensor<8x1024x1024xf32>
    %25 = linalg.fill ins(%cst : f32) outs(%24 : tensor<8x1024x1024xf32>) -> tensor<8x1024x1024xf32>
    %26 = linalg.batch_matmul ins(%collapsed_16, %collapsed_17 : tensor<8x1024x32xf32>, tensor<8x32x1024xf32>) outs(%25 : tensor<8x1024x1024xf32>) -> tensor<8x1024x1024xf32>
    %expanded_18 = tensor.expand_shape %26 [[0, 1], [2], [3]] output_shape [2, 4, 1024, 1024] : tensor<8x1024x1024xf32> into tensor<2x4x1024x1024xf32>
    %27 = tensor.empty() : tensor<2x4x1024x1024xf32>
    %28 = linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%expanded_18 : tensor<2x4x1024x1024xf32>) outs(%27 : tensor<2x4x1024x1024xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.truncf %cst_4 : f64 to f32
      %133 = arith.mulf %in, %132 : f32
      linalg.yield %133 : f32
    } -> tensor<2x4x1024x1024xf32>
    %29 = tensor.empty() : tensor<1x1x1024x1024xi1>
    %30 = linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg5 : tensor<1x1x1024x1024xf32>) outs(%29 : tensor<1x1x1024x1024xi1>) {
    ^bb0(%in: f32, %out: i1):
      %132 = arith.cmpf oeq, %in, %cst : f32
      linalg.yield %132 : i1
    } -> tensor<1x1x1024x1024xi1>
    %31 = linalg.generic {indexing_maps = [#map6, #map7, #map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%30, %cst_3, %28 : tensor<1x1x1024x1024xi1>, tensor<f32>, tensor<2x4x1024x1024xf32>) outs(%27 : tensor<2x4x1024x1024xf32>) {
    ^bb0(%in: i1, %in_56: f32, %in_57: f32, %out: f32):
      %132 = arith.select %in, %in_56, %in_57 : f32
      linalg.yield %132 : f32
    } -> tensor<2x4x1024x1024xf32>
    %32 = tensor.empty() : tensor<2x4x1024xi64>
    %33 = linalg.fill ins(%c0_i64 : i64) outs(%32 : tensor<2x4x1024xi64>) -> tensor<2x4x1024xi64>
    %34 = tensor.empty() : tensor<2x4x1024xf32>
    %35 = linalg.fill ins(%cst_0 : f32) outs(%34 : tensor<2x4x1024xf32>) -> tensor<2x4x1024xf32>
    %36:2 = linalg.generic {indexing_maps = [#map5, #map8, #map8], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%31 : tensor<2x4x1024x1024xf32>) outs(%35, %33 : tensor<2x4x1024xf32>, tensor<2x4x1024xi64>) {
    ^bb0(%in: f32, %out: f32, %out_56: i64):
      %132 = linalg.index 3 : index
      %133 = arith.index_cast %132 : index to i64
      %134 = arith.maximumf %in, %out : f32
      %135 = arith.cmpf ogt, %in, %out : f32
      %136 = arith.select %135, %133, %out_56 : i64
      linalg.yield %134, %136 : f32, i64
    } -> (tensor<2x4x1024xf32>, tensor<2x4x1024xi64>)
    %expanded_19 = tensor.expand_shape %36#0 [[0], [1], [2, 3]] output_shape [2, 4, 1024, 1] : tensor<2x4x1024xf32> into tensor<2x4x1024x1xf32>
    %37 = linalg.generic {indexing_maps = [#map5, #map9, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%31, %expanded_19 : tensor<2x4x1024x1024xf32>, tensor<2x4x1024x1xf32>) outs(%27 : tensor<2x4x1024x1024xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.subf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x4x1024x1024xf32>
    %38 = linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%37 : tensor<2x4x1024x1024xf32>) outs(%27 : tensor<2x4x1024x1024xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = math.exp %in : f32
      linalg.yield %132 : f32
    } -> tensor<2x4x1024x1024xf32>
    %39 = tensor.empty() : tensor<2x4x1024x1xf32>
    %40 = linalg.fill ins(%cst : f32) outs(%39 : tensor<2x4x1024x1xf32>) -> tensor<2x4x1024x1xf32>
    %41 = linalg.generic {indexing_maps = [#map5, #map9], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%38 : tensor<2x4x1024x1024xf32>) outs(%40 : tensor<2x4x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.addf %in, %out : f32
      linalg.yield %132 : f32
    } -> tensor<2x4x1024x1xf32>
    %42 = linalg.generic {indexing_maps = [#map5, #map9, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%38, %41 : tensor<2x4x1024x1024xf32>, tensor<2x4x1024x1xf32>) outs(%27 : tensor<2x4x1024x1024xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.divf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x4x1024x1024xf32>
    %collapsed_20 = tensor.collapse_shape %42 [[0, 1], [2], [3]] : tensor<2x4x1024x1024xf32> into tensor<8x1024x1024xf32>
    %collapsed_21 = tensor.collapse_shape %transposed_14 [[0, 1], [2], [3]] : tensor<2x4x1024x32xf32> into tensor<8x1024x32xf32>
    %43 = tensor.empty() : tensor<8x1024x32xf32>
    %44 = linalg.fill ins(%cst : f32) outs(%43 : tensor<8x1024x32xf32>) -> tensor<8x1024x32xf32>
    %45 = linalg.batch_matmul ins(%collapsed_20, %collapsed_21 : tensor<8x1024x1024xf32>, tensor<8x1024x32xf32>) outs(%44 : tensor<8x1024x32xf32>) -> tensor<8x1024x32xf32>
    %expanded_22 = tensor.expand_shape %45 [[0, 1], [2], [3]] output_shape [2, 4, 1024, 32] : tensor<8x1024x32xf32> into tensor<2x4x1024x32xf32>
    %46 = tensor.empty() : tensor<2x1024x4x32xf32>
    %transposed_23 = linalg.transpose ins(%expanded_22 : tensor<2x4x1024x32xf32>) outs(%46 : tensor<2x1024x4x32xf32>) permutation = [0, 2, 1, 3] 
    %collapsed_24 = tensor.collapse_shape %transposed_23 [[0], [1], [2, 3]] : tensor<2x1024x4x32xf32> into tensor<2x1024x128xf32>
    %47 = tensor.empty() : tensor<128x128xf32>
    %transposed_25 = linalg.transpose ins(%arg6 : tensor<128x128xf32>) outs(%47 : tensor<128x128xf32>) permutation = [1, 0] 
    %48 = tensor.empty() : tensor<2x128x128xf32>
    %49 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed_25 : tensor<128x128xf32>) outs(%48 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x128xf32>
    %50 = linalg.fill ins(%cst : f32) outs(%arg27 : tensor<2x1024x128xf32>) -> tensor<2x1024x128xf32>
    %51 = linalg.batch_matmul ins(%collapsed_24, %49 : tensor<2x1024x128xf32>, tensor<2x128x128xf32>) outs(%50 : tensor<2x1024x128xf32>) -> tensor<2x1024x128xf32>
    %52 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%51, %arg7 : tensor<2x1024x128xf32>, tensor<128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.addf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %53 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg2, %52 : tensor<2x1024x128xf32>, tensor<2x1024x128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.addf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %54 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%53 : tensor<2x1024x128xf32>) outs(%1 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.addf %in, %out : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %55 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%54 : tensor<2x1024x1xf32>) outs(%0 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.divf %in, %cst_6 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %collapsed_26 = tensor.collapse_shape %55 [[0], [1, 2]] : tensor<2x1024x1xf32> into tensor<2x1024xf32>
    %56 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed_26 : tensor<2x1024xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x1024x128xf32>
    %57 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%53, %56 : tensor<2x1024x128xf32>, tensor<2x1024x128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.subf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %58 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%57, %57 : tensor<2x1024x128xf32>, tensor<2x1024x128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.mulf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %59 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%58 : tensor<2x1024x128xf32>) outs(%1 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.addf %in, %out : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %60 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%59 : tensor<2x1024x1xf32>) outs(%0 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.divf %in, %cst_6 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %61 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%60 : tensor<2x1024x1xf32>) outs(%0 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.truncf %cst_5 : f64 to f32
      %133 = arith.addf %in, %132 : f32
      linalg.yield %133 : f32
    } -> tensor<2x1024x1xf32>
    %62 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%61 : tensor<2x1024x1xf32>) outs(%0 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = math.rsqrt %in : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %collapsed_27 = tensor.collapse_shape %62 [[0], [1, 2]] : tensor<2x1024x1xf32> into tensor<2x1024xf32>
    %63 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed_27 : tensor<2x1024xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x1024x128xf32>
    %64 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%57, %63 : tensor<2x1024x128xf32>, tensor<2x1024x128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.mulf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %65 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%64, %arg8 : tensor<2x1024x128xf32>, tensor<128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.mulf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %66 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%65, %arg9 : tensor<2x1024x128xf32>, tensor<128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.addf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %67 = tensor.empty() : tensor<128x512xf32>
    %transposed_28 = linalg.transpose ins(%arg10 : tensor<512x128xf32>) outs(%67 : tensor<128x512xf32>) permutation = [1, 0] 
    %68 = tensor.empty() : tensor<2x128x512xf32>
    %69 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed_28 : tensor<128x512xf32>) outs(%68 : tensor<2x128x512xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x512xf32>
    %70 = tensor.empty() : tensor<2x1024x512xf32>
    %71 = linalg.fill ins(%cst : f32) outs(%70 : tensor<2x1024x512xf32>) -> tensor<2x1024x512xf32>
    %72 = linalg.batch_matmul ins(%66, %69 : tensor<2x1024x128xf32>, tensor<2x128x512xf32>) outs(%71 : tensor<2x1024x512xf32>) -> tensor<2x1024x512xf32>
    %73 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%72, %arg11 : tensor<2x1024x512xf32>, tensor<512xf32>) outs(%70 : tensor<2x1024x512xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.addf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x512xf32>
    %74 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%73 : tensor<2x1024x512xf32>) outs(%70 : tensor<2x1024x512xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.divf %in, %cst_7 : f32
      %133 = math.erf %132 : f32
      %134 = arith.addf %133, %cst_1 : f32
      %135 = arith.mulf %134, %cst_2 : f32
      %136 = arith.mulf %in, %135 : f32
      linalg.yield %136 : f32
    } -> tensor<2x1024x512xf32>
    %75 = tensor.empty() : tensor<512x128xf32>
    %transposed_29 = linalg.transpose ins(%arg12 : tensor<128x512xf32>) outs(%75 : tensor<512x128xf32>) permutation = [1, 0] 
    %76 = tensor.empty() : tensor<2x512x128xf32>
    %77 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed_29 : tensor<512x128xf32>) outs(%76 : tensor<2x512x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x512x128xf32>
    %78 = linalg.batch_matmul ins(%74, %77 : tensor<2x1024x512xf32>, tensor<2x512x128xf32>) outs(%50 : tensor<2x1024x128xf32>) -> tensor<2x1024x128xf32>
    %79 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%78, %arg13 : tensor<2x1024x128xf32>, tensor<128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.addf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %80 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%53, %79 : tensor<2x1024x128xf32>, tensor<2x1024x128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.addf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %81 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%80 : tensor<2x1024x128xf32>) outs(%1 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.addf %in, %out : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %82 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%81 : tensor<2x1024x1xf32>) outs(%0 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.divf %in, %cst_6 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %collapsed_30 = tensor.collapse_shape %82 [[0], [1, 2]] : tensor<2x1024x1xf32> into tensor<2x1024xf32>
    %83 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed_30 : tensor<2x1024xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x1024x128xf32>
    %84 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%80, %83 : tensor<2x1024x128xf32>, tensor<2x1024x128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.subf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %85 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%84, %84 : tensor<2x1024x128xf32>, tensor<2x1024x128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.mulf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %86 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%85 : tensor<2x1024x128xf32>) outs(%1 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.addf %in, %out : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %87 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%86 : tensor<2x1024x1xf32>) outs(%0 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.divf %in, %cst_6 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %88 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%87 : tensor<2x1024x1xf32>) outs(%0 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.truncf %cst_5 : f64 to f32
      %133 = arith.addf %in, %132 : f32
      linalg.yield %133 : f32
    } -> tensor<2x1024x1xf32>
    %89 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%88 : tensor<2x1024x1xf32>) outs(%0 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = math.rsqrt %in : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %collapsed_31 = tensor.collapse_shape %89 [[0], [1, 2]] : tensor<2x1024x1xf32> into tensor<2x1024xf32>
    %90 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed_31 : tensor<2x1024xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x1024x128xf32>
    %91 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%84, %90 : tensor<2x1024x128xf32>, tensor<2x1024x128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.mulf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %92 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%91, %arg14 : tensor<2x1024x128xf32>, tensor<128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.mulf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %93 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%92, %arg15 : tensor<2x1024x128xf32>, tensor<128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.addf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %transposed_32 = linalg.transpose ins(%arg16 : tensor<384x128xf32>) outs(%15 : tensor<128x384xf32>) permutation = [1, 0] 
    %94 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed_32 : tensor<128x384xf32>) outs(%16 : tensor<2x128x384xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x384xf32>
    %95 = linalg.batch_matmul ins(%93, %94 : tensor<2x1024x128xf32>, tensor<2x128x384xf32>) outs(%19 : tensor<2x1024x384xf32>) -> tensor<2x1024x384xf32>
    %96 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%95, %arg17 : tensor<2x1024x384xf32>, tensor<384xf32>) outs(%18 : tensor<2x1024x384xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.addf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x384xf32>
    %extracted_slice_33 = tensor.extract_slice %96[0, 0, 0] [2, 1024, 128] [1, 1, 1] : tensor<2x1024x384xf32> to tensor<2x1024x128xf32>
    %extracted_slice_34 = tensor.extract_slice %96[0, 0, 128] [2, 1024, 128] [1, 1, 1] : tensor<2x1024x384xf32> to tensor<2x1024x128xf32>
    %extracted_slice_35 = tensor.extract_slice %96[0, 0, 256] [2, 1024, 128] [1, 1, 1] : tensor<2x1024x384xf32> to tensor<2x1024x128xf32>
    %expanded_36 = tensor.expand_shape %extracted_slice_34 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : tensor<2x1024x128xf32> into tensor<2x1024x4x32xf32>
    %expanded_37 = tensor.expand_shape %extracted_slice_33 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : tensor<2x1024x128xf32> into tensor<2x1024x4x32xf32>
    %transposed_38 = linalg.transpose ins(%expanded_37 : tensor<2x1024x4x32xf32>) outs(%22 : tensor<2x4x1024x32xf32>) permutation = [0, 2, 1, 3] 
    %expanded_39 = tensor.expand_shape %extracted_slice_35 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : tensor<2x1024x128xf32> into tensor<2x1024x4x32xf32>
    %transposed_40 = linalg.transpose ins(%expanded_39 : tensor<2x1024x4x32xf32>) outs(%22 : tensor<2x4x1024x32xf32>) permutation = [0, 2, 1, 3] 
    %transposed_41 = linalg.transpose ins(%expanded_36 : tensor<2x1024x4x32xf32>) outs(%23 : tensor<2x4x32x1024xf32>) permutation = [0, 2, 3, 1] 
    %collapsed_42 = tensor.collapse_shape %transposed_38 [[0, 1], [2], [3]] : tensor<2x4x1024x32xf32> into tensor<8x1024x32xf32>
    %collapsed_43 = tensor.collapse_shape %transposed_41 [[0, 1], [2], [3]] : tensor<2x4x32x1024xf32> into tensor<8x32x1024xf32>
    %97 = linalg.batch_matmul ins(%collapsed_42, %collapsed_43 : tensor<8x1024x32xf32>, tensor<8x32x1024xf32>) outs(%25 : tensor<8x1024x1024xf32>) -> tensor<8x1024x1024xf32>
    %expanded_44 = tensor.expand_shape %97 [[0, 1], [2], [3]] output_shape [2, 4, 1024, 1024] : tensor<8x1024x1024xf32> into tensor<2x4x1024x1024xf32>
    %98 = linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%expanded_44 : tensor<2x4x1024x1024xf32>) outs(%27 : tensor<2x4x1024x1024xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.truncf %cst_4 : f64 to f32
      %133 = arith.mulf %in, %132 : f32
      linalg.yield %133 : f32
    } -> tensor<2x4x1024x1024xf32>
    %99 = linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg18 : tensor<1x1x1024x1024xf32>) outs(%29 : tensor<1x1x1024x1024xi1>) {
    ^bb0(%in: f32, %out: i1):
      %132 = arith.cmpf oeq, %in, %cst : f32
      linalg.yield %132 : i1
    } -> tensor<1x1x1024x1024xi1>
    %100 = linalg.generic {indexing_maps = [#map6, #map7, #map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%99, %cst_3, %98 : tensor<1x1x1024x1024xi1>, tensor<f32>, tensor<2x4x1024x1024xf32>) outs(%27 : tensor<2x4x1024x1024xf32>) {
    ^bb0(%in: i1, %in_56: f32, %in_57: f32, %out: f32):
      %132 = arith.select %in, %in_56, %in_57 : f32
      linalg.yield %132 : f32
    } -> tensor<2x4x1024x1024xf32>
    %101:2 = linalg.generic {indexing_maps = [#map5, #map8, #map8], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%100 : tensor<2x4x1024x1024xf32>) outs(%35, %33 : tensor<2x4x1024xf32>, tensor<2x4x1024xi64>) {
    ^bb0(%in: f32, %out: f32, %out_56: i64):
      %132 = linalg.index 3 : index
      %133 = arith.index_cast %132 : index to i64
      %134 = arith.maximumf %in, %out : f32
      %135 = arith.cmpf ogt, %in, %out : f32
      %136 = arith.select %135, %133, %out_56 : i64
      linalg.yield %134, %136 : f32, i64
    } -> (tensor<2x4x1024xf32>, tensor<2x4x1024xi64>)
    %expanded_45 = tensor.expand_shape %101#0 [[0], [1], [2, 3]] output_shape [2, 4, 1024, 1] : tensor<2x4x1024xf32> into tensor<2x4x1024x1xf32>
    %102 = linalg.generic {indexing_maps = [#map5, #map9, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%100, %expanded_45 : tensor<2x4x1024x1024xf32>, tensor<2x4x1024x1xf32>) outs(%27 : tensor<2x4x1024x1024xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.subf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x4x1024x1024xf32>
    %103 = linalg.generic {indexing_maps = [#map5, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%102 : tensor<2x4x1024x1024xf32>) outs(%27 : tensor<2x4x1024x1024xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = math.exp %in : f32
      linalg.yield %132 : f32
    } -> tensor<2x4x1024x1024xf32>
    %104 = linalg.generic {indexing_maps = [#map5, #map9], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%103 : tensor<2x4x1024x1024xf32>) outs(%40 : tensor<2x4x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.addf %in, %out : f32
      linalg.yield %132 : f32
    } -> tensor<2x4x1024x1xf32>
    %105 = linalg.generic {indexing_maps = [#map5, #map9, #map5], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%103, %104 : tensor<2x4x1024x1024xf32>, tensor<2x4x1024x1xf32>) outs(%27 : tensor<2x4x1024x1024xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.divf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x4x1024x1024xf32>
    %collapsed_46 = tensor.collapse_shape %105 [[0, 1], [2], [3]] : tensor<2x4x1024x1024xf32> into tensor<8x1024x1024xf32>
    %collapsed_47 = tensor.collapse_shape %transposed_40 [[0, 1], [2], [3]] : tensor<2x4x1024x32xf32> into tensor<8x1024x32xf32>
    %106 = linalg.batch_matmul ins(%collapsed_46, %collapsed_47 : tensor<8x1024x1024xf32>, tensor<8x1024x32xf32>) outs(%44 : tensor<8x1024x32xf32>) -> tensor<8x1024x32xf32>
    %expanded_48 = tensor.expand_shape %106 [[0, 1], [2], [3]] output_shape [2, 4, 1024, 32] : tensor<8x1024x32xf32> into tensor<2x4x1024x32xf32>
    %transposed_49 = linalg.transpose ins(%expanded_48 : tensor<2x4x1024x32xf32>) outs(%46 : tensor<2x1024x4x32xf32>) permutation = [0, 2, 1, 3] 
    %collapsed_50 = tensor.collapse_shape %transposed_49 [[0], [1], [2, 3]] : tensor<2x1024x4x32xf32> into tensor<2x1024x128xf32>
    %transposed_51 = linalg.transpose ins(%arg19 : tensor<128x128xf32>) outs(%47 : tensor<128x128xf32>) permutation = [1, 0] 
    %107 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed_51 : tensor<128x128xf32>) outs(%48 : tensor<2x128x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x128xf32>
    %108 = linalg.batch_matmul ins(%collapsed_50, %107 : tensor<2x1024x128xf32>, tensor<2x128x128xf32>) outs(%50 : tensor<2x1024x128xf32>) -> tensor<2x1024x128xf32>
    %109 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%108, %arg20 : tensor<2x1024x128xf32>, tensor<128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.addf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %110 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%80, %109 : tensor<2x1024x128xf32>, tensor<2x1024x128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.addf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %111 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%110 : tensor<2x1024x128xf32>) outs(%1 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.addf %in, %out : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %112 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%111 : tensor<2x1024x1xf32>) outs(%0 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.divf %in, %cst_6 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %collapsed_52 = tensor.collapse_shape %112 [[0], [1, 2]] : tensor<2x1024x1xf32> into tensor<2x1024xf32>
    %113 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed_52 : tensor<2x1024xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x1024x128xf32>
    %114 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%110, %113 : tensor<2x1024x128xf32>, tensor<2x1024x128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.subf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %115 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%114, %114 : tensor<2x1024x128xf32>, tensor<2x1024x128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.mulf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %116 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%115 : tensor<2x1024x128xf32>) outs(%1 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.addf %in, %out : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %117 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%116 : tensor<2x1024x1xf32>) outs(%0 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.divf %in, %cst_6 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %118 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%117 : tensor<2x1024x1xf32>) outs(%0 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.truncf %cst_5 : f64 to f32
      %133 = arith.addf %in, %132 : f32
      linalg.yield %133 : f32
    } -> tensor<2x1024x1xf32>
    %119 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%118 : tensor<2x1024x1xf32>) outs(%0 : tensor<2x1024x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = math.rsqrt %in : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x1xf32>
    %collapsed_53 = tensor.collapse_shape %119 [[0], [1, 2]] : tensor<2x1024x1xf32> into tensor<2x1024xf32>
    %120 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed_53 : tensor<2x1024xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x1024x128xf32>
    %121 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%114, %120 : tensor<2x1024x128xf32>, tensor<2x1024x128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.mulf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %122 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%121, %arg21 : tensor<2x1024x128xf32>, tensor<128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.mulf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %123 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%122, %arg22 : tensor<2x1024x128xf32>, tensor<128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.addf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %transposed_54 = linalg.transpose ins(%arg23 : tensor<512x128xf32>) outs(%67 : tensor<128x512xf32>) permutation = [1, 0] 
    %124 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed_54 : tensor<128x512xf32>) outs(%68 : tensor<2x128x512xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x128x512xf32>
    %125 = linalg.batch_matmul ins(%123, %124 : tensor<2x1024x128xf32>, tensor<2x128x512xf32>) outs(%71 : tensor<2x1024x512xf32>) -> tensor<2x1024x512xf32>
    %126 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%125, %arg24 : tensor<2x1024x512xf32>, tensor<512xf32>) outs(%70 : tensor<2x1024x512xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.addf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x512xf32>
    %127 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%126 : tensor<2x1024x512xf32>) outs(%70 : tensor<2x1024x512xf32>) {
    ^bb0(%in: f32, %out: f32):
      %132 = arith.divf %in, %cst_7 : f32
      %133 = math.erf %132 : f32
      %134 = arith.addf %133, %cst_1 : f32
      %135 = arith.mulf %134, %cst_2 : f32
      %136 = arith.mulf %in, %135 : f32
      linalg.yield %136 : f32
    } -> tensor<2x1024x512xf32>
    %transposed_55 = linalg.transpose ins(%arg25 : tensor<128x512xf32>) outs(%75 : tensor<512x128xf32>) permutation = [1, 0] 
    %128 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%transposed_55 : tensor<512x128xf32>) outs(%76 : tensor<2x512x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x512x128xf32>
    %129 = linalg.batch_matmul ins(%127, %128 : tensor<2x1024x512xf32>, tensor<2x512x128xf32>) outs(%50 : tensor<2x1024x128xf32>) -> tensor<2x1024x128xf32>
    %130 = linalg.generic {indexing_maps = [#map, #map3, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%129, %arg26 : tensor<2x1024x128xf32>, tensor<128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.addf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    %131 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%110, %130 : tensor<2x1024x128xf32>, tensor<2x1024x128xf32>) outs(%arg27 : tensor<2x1024x128xf32>) {
    ^bb0(%in: f32, %in_56: f32, %out: f32):
      %132 = arith.addf %in, %in_56 : f32
      linalg.yield %132 : f32
    } -> tensor<2x1024x128xf32>
    return %131 : tensor<2x1024x128xf32>
  }

transform.named_sequence @__transform_main(%root: !transform.any_op) {
    %v1 = transform.structured.match in %root { ops = ["linalg.batch_matmul"] } : (!transform.any_op) -> !transform.any_op
    %v3, %v2 = transform.structured.tile_using_forall %v1 tile_sizes [1, 32, 32, 32] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %v4 = transform.structured.match in %root { ops = ["linalg.generic"] } : (!transform.any_op) -> !transform.any_op
    %v6, %v5 = transform.structured.tile_using_forall %v4 tile_sizes [32, 32] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %v7 = transform.structured.match in %root { ops = ["linalg.transpose"] } : (!transform.any_op) -> !transform.any_op
    %v9, %v8 = transform.structured.tile_using_forall %v7 tile_sizes [32, 32] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    transform.yield
}
}