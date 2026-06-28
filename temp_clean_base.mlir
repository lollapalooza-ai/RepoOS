#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, 0)>
#map2 = affine_map<(d0, d1, d2) -> (d2)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map4 = affine_map<(d0, d1, d2) -> (d1, d2)>
module {
  func.func @main(%arg0: tensor<2x?x64xf32>, %arg1: tensor<2x?x?xf32>, %arg2: tensor<64x256xf32>, %arg3: tensor<256x64xf32>, %arg4: tensor<64xf32>, %arg5: tensor<64xf32>, %arg6: tensor<64xf32>, %arg7: tensor<64xf32>, %arg8: tensor<2x?x64xf32>) -> tensor<2x?x64xf32> {
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
    %dim = tensor.dim %arg0, %c1 : tensor<2x?x64xf32>
    %0 = tensor.empty(%dim) : tensor<2x?x1xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<2x?x1xf32>) -> tensor<2x?x1xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg0 : tensor<2x?x64xf32>) outs(%1 : tensor<2x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %68 = arith.addf %in, %out : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x1xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%2 : tensor<2x?x1xf32>) outs(%0 : tensor<2x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %68 = arith.divf %in, %cst_5 : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x1xf32>
    %4 = tensor.empty(%dim) : tensor<2x?x64xf64>
    %5 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0 : tensor<2x?x64xf32>) outs(%4 : tensor<2x?x64xf64>) {
    ^bb0(%in: f32, %out: f64):
      %68 = arith.extf %in : f32 to f64
      linalg.yield %68 : f64
    } -> tensor<2x?x64xf64>
    %6 = tensor.empty(%dim) : tensor<2x?x1xf64>
    %7 = linalg.fill ins(%cst_0 : f64) outs(%6 : tensor<2x?x1xf64>) -> tensor<2x?x1xf64>
    %8 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%5 : tensor<2x?x64xf64>) outs(%7 : tensor<2x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %68 = arith.addf %in, %out : f64
      linalg.yield %68 : f64
    } -> tensor<2x?x1xf64>
    %9 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%8 : tensor<2x?x1xf64>) outs(%6 : tensor<2x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %68 = arith.divf %in, %cst_6 : f64
      linalg.yield %68 : f64
    } -> tensor<2x?x1xf64>
    %10 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%5, %9 : tensor<2x?x64xf64>, tensor<2x?x1xf64>) outs(%4 : tensor<2x?x64xf64>) {
    ^bb0(%in: f64, %in_11: f64, %out: f64):
      %68 = arith.subf %in, %in_11 : f64
      linalg.yield %68 : f64
    } -> tensor<2x?x64xf64>
    %11 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%10, %10 : tensor<2x?x64xf64>, tensor<2x?x64xf64>) outs(%4 : tensor<2x?x64xf64>) {
    ^bb0(%in: f64, %in_11: f64, %out: f64):
      %68 = arith.mulf %in, %in_11 : f64
      linalg.yield %68 : f64
    } -> tensor<2x?x64xf64>
    %12 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%11 : tensor<2x?x64xf64>) outs(%7 : tensor<2x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %68 = arith.addf %in, %out : f64
      linalg.yield %68 : f64
    } -> tensor<2x?x1xf64>
    %13 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%12 : tensor<2x?x1xf64>) outs(%6 : tensor<2x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %68 = arith.divf %in, %cst_6 : f64
      linalg.yield %68 : f64
    } -> tensor<2x?x1xf64>
    %14 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%13 : tensor<2x?x1xf64>) outs(%0 : tensor<2x?x1xf32>) {
    ^bb0(%in: f64, %out: f32):
      %68 = arith.truncf %in : f64 to f32
      linalg.yield %68 : f32
    } -> tensor<2x?x1xf32>
    %15 = tensor.cast %arg8 : tensor<2x?x64xf32> to tensor<2x?x64xf32>
    %16 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0, %3 : tensor<2x?x64xf32>, tensor<2x?x1xf32>) outs(%15 : tensor<2x?x64xf32>) {
    ^bb0(%in: f32, %in_11: f32, %out: f32):
      %68 = arith.subf %in, %in_11 : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x64xf32>
    %17 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%14 : tensor<2x?x1xf32>) outs(%0 : tensor<2x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %68 = arith.truncf %cst_4 : f64 to f32
      %69 = arith.addf %in, %68 : f32
      linalg.yield %69 : f32
    } -> tensor<2x?x1xf32>
    %18 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%17 : tensor<2x?x1xf32>) outs(%0 : tensor<2x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %68 = math.sqrt %in : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x1xf32>
    %19 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%16, %18 : tensor<2x?x64xf32>, tensor<2x?x1xf32>) outs(%15 : tensor<2x?x64xf32>) {
    ^bb0(%in: f32, %in_11: f32, %out: f32):
      %68 = arith.divf %in, %in_11 : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x64xf32>
    %20 = linalg.generic {indexing_maps = [#map, #map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%19, %arg4 : tensor<2x?x64xf32>, tensor<64xf32>) outs(%15 : tensor<2x?x64xf32>) {
    ^bb0(%in: f32, %in_11: f32, %out: f32):
      %68 = arith.mulf %in, %in_11 : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x64xf32>
    %21 = linalg.generic {indexing_maps = [#map, #map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%20, %arg5 : tensor<2x?x64xf32>, tensor<64xf32>) outs(%15 : tensor<2x?x64xf32>) {
    ^bb0(%in: f32, %in_11: f32, %out: f32):
      %68 = arith.addf %in, %in_11 : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x64xf32>
    %22 = tensor.empty(%dim) : tensor<2x64x?xf32>
    %transposed = linalg.transpose ins(%21 : tensor<2x?x64xf32>) outs(%22 : tensor<2x64x?xf32>) permutation = [0, 2, 1] 
    %23 = tensor.empty(%dim, %dim) : tensor<2x?x?xf32>
    %24 = linalg.fill ins(%cst : f32) outs(%23 : tensor<2x?x?xf32>) -> tensor<2x?x?xf32>
    %25 = linalg.batch_matmul ins(%21, %transposed : tensor<2x?x64xf32>, tensor<2x64x?xf32>) outs(%24 : tensor<2x?x?xf32>) -> tensor<2x?x?xf32>
    %26 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%25 : tensor<2x?x?xf32>) outs(%23 : tensor<2x?x?xf32>) {
    ^bb0(%in: f32, %out: f32):
      %68 = arith.divf %in, %cst_7 : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x?xf32>
    %dim_9 = tensor.dim %arg1, %c1 : tensor<2x?x?xf32>
    %27 = arith.cmpi eq, %dim, %dim_9 : index
    cf.assert %27, "mismatched size for broadcast"
    %dim_10 = tensor.dim %arg1, %c2 : tensor<2x?x?xf32>
    %28 = arith.cmpi eq, %dim, %dim_10 : index
    cf.assert %28, "mismatched size for broadcast"
    %29 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%26, %arg1 : tensor<2x?x?xf32>, tensor<2x?x?xf32>) outs(%23 : tensor<2x?x?xf32>) {
    ^bb0(%in: f32, %in_11: f32, %out: f32):
      %68 = arith.addf %in, %in_11 : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x?xf32>
    %30 = tensor.empty(%dim) : tensor<2x?xi64>
    %31 = linalg.fill ins(%c0_i64 : i64) outs(%30 : tensor<2x?xi64>) -> tensor<2x?xi64>
    %32 = tensor.empty(%dim) : tensor<2x?xf32>
    %33 = linalg.fill ins(%cst_1 : f32) outs(%32 : tensor<2x?xf32>) -> tensor<2x?xf32>
    %34:2 = linalg.generic {indexing_maps = [#map, #map3, #map3], iterator_types = ["parallel", "parallel", "reduction"]} ins(%29 : tensor<2x?x?xf32>) outs(%33, %31 : tensor<2x?xf32>, tensor<2x?xi64>) {
    ^bb0(%in: f32, %out: f32, %out_11: i64):
      %68 = linalg.index 2 : index
      %69 = arith.index_cast %68 : index to i64
      %70 = arith.maximumf %in, %out : f32
      %71 = arith.cmpf ogt, %in, %out : f32
      %72 = arith.select %71, %69, %out_11 : i64
      linalg.yield %70, %72 : f32, i64
    } -> (tensor<2x?xf32>, tensor<2x?xi64>)
    %expanded = tensor.expand_shape %34#0 [[0], [1, 2]] output_shape [2, %dim, 1] : tensor<2x?xf32> into tensor<2x?x1xf32>
    %35 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%29, %expanded : tensor<2x?x?xf32>, tensor<2x?x1xf32>) outs(%23 : tensor<2x?x?xf32>) {
    ^bb0(%in: f32, %in_11: f32, %out: f32):
      %68 = arith.subf %in, %in_11 : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x?xf32>
    %36 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%35 : tensor<2x?x?xf32>) outs(%23 : tensor<2x?x?xf32>) {
    ^bb0(%in: f32, %out: f32):
      %68 = math.exp %in : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x?xf32>
    %37 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%36 : tensor<2x?x?xf32>) outs(%1 : tensor<2x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %68 = arith.addf %in, %out : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x1xf32>
    %38 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%36, %37 : tensor<2x?x?xf32>, tensor<2x?x1xf32>) outs(%23 : tensor<2x?x?xf32>) {
    ^bb0(%in: f32, %in_11: f32, %out: f32):
      %68 = arith.divf %in, %in_11 : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x?xf32>
    %39 = linalg.fill ins(%cst : f32) outs(%15 : tensor<2x?x64xf32>) -> tensor<2x?x64xf32>
    %40 = linalg.batch_matmul ins(%38, %21 : tensor<2x?x?xf32>, tensor<2x?x64xf32>) outs(%39 : tensor<2x?x64xf32>) -> tensor<2x?x64xf32>
    %41 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0, %40 : tensor<2x?x64xf32>, tensor<2x?x64xf32>) outs(%15 : tensor<2x?x64xf32>) {
    ^bb0(%in: f32, %in_11: f32, %out: f32):
      %68 = arith.addf %in, %in_11 : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x64xf32>
    %42 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%41 : tensor<2x?x64xf32>) outs(%1 : tensor<2x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %68 = arith.addf %in, %out : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x1xf32>
    %43 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%42 : tensor<2x?x1xf32>) outs(%0 : tensor<2x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %68 = arith.divf %in, %cst_5 : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x1xf32>
    %44 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%41 : tensor<2x?x64xf32>) outs(%4 : tensor<2x?x64xf64>) {
    ^bb0(%in: f32, %out: f64):
      %68 = arith.extf %in : f32 to f64
      linalg.yield %68 : f64
    } -> tensor<2x?x64xf64>
    %45 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%44 : tensor<2x?x64xf64>) outs(%7 : tensor<2x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %68 = arith.addf %in, %out : f64
      linalg.yield %68 : f64
    } -> tensor<2x?x1xf64>
    %46 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%45 : tensor<2x?x1xf64>) outs(%6 : tensor<2x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %68 = arith.divf %in, %cst_6 : f64
      linalg.yield %68 : f64
    } -> tensor<2x?x1xf64>
    %47 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%44, %46 : tensor<2x?x64xf64>, tensor<2x?x1xf64>) outs(%4 : tensor<2x?x64xf64>) {
    ^bb0(%in: f64, %in_11: f64, %out: f64):
      %68 = arith.subf %in, %in_11 : f64
      linalg.yield %68 : f64
    } -> tensor<2x?x64xf64>
    %48 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%47, %47 : tensor<2x?x64xf64>, tensor<2x?x64xf64>) outs(%4 : tensor<2x?x64xf64>) {
    ^bb0(%in: f64, %in_11: f64, %out: f64):
      %68 = arith.mulf %in, %in_11 : f64
      linalg.yield %68 : f64
    } -> tensor<2x?x64xf64>
    %49 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%48 : tensor<2x?x64xf64>) outs(%7 : tensor<2x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %68 = arith.addf %in, %out : f64
      linalg.yield %68 : f64
    } -> tensor<2x?x1xf64>
    %50 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%49 : tensor<2x?x1xf64>) outs(%6 : tensor<2x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %68 = arith.divf %in, %cst_6 : f64
      linalg.yield %68 : f64
    } -> tensor<2x?x1xf64>
    %51 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%50 : tensor<2x?x1xf64>) outs(%0 : tensor<2x?x1xf32>) {
    ^bb0(%in: f64, %out: f32):
      %68 = arith.truncf %in : f64 to f32
      linalg.yield %68 : f32
    } -> tensor<2x?x1xf32>
    %52 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%41, %43 : tensor<2x?x64xf32>, tensor<2x?x1xf32>) outs(%15 : tensor<2x?x64xf32>) {
    ^bb0(%in: f32, %in_11: f32, %out: f32):
      %68 = arith.subf %in, %in_11 : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x64xf32>
    %53 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%51 : tensor<2x?x1xf32>) outs(%0 : tensor<2x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %68 = arith.truncf %cst_4 : f64 to f32
      %69 = arith.addf %in, %68 : f32
      linalg.yield %69 : f32
    } -> tensor<2x?x1xf32>
    %54 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%53 : tensor<2x?x1xf32>) outs(%0 : tensor<2x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %68 = math.sqrt %in : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x1xf32>
    %55 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%52, %54 : tensor<2x?x64xf32>, tensor<2x?x1xf32>) outs(%15 : tensor<2x?x64xf32>) {
    ^bb0(%in: f32, %in_11: f32, %out: f32):
      %68 = arith.divf %in, %in_11 : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x64xf32>
    %56 = linalg.generic {indexing_maps = [#map, #map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%55, %arg6 : tensor<2x?x64xf32>, tensor<64xf32>) outs(%15 : tensor<2x?x64xf32>) {
    ^bb0(%in: f32, %in_11: f32, %out: f32):
      %68 = arith.mulf %in, %in_11 : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x64xf32>
    %57 = linalg.generic {indexing_maps = [#map, #map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%56, %arg7 : tensor<2x?x64xf32>, tensor<64xf32>) outs(%15 : tensor<2x?x64xf32>) {
    ^bb0(%in: f32, %in_11: f32, %out: f32):
      %68 = arith.addf %in, %in_11 : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x64xf32>
    %58 = tensor.empty() : tensor<2x64x256xf32>
    %59 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg2 : tensor<64x256xf32>) outs(%58 : tensor<2x64x256xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x64x256xf32>
    %60 = tensor.empty(%dim) : tensor<2x?x256xf32>
    %61 = linalg.fill ins(%cst : f32) outs(%60 : tensor<2x?x256xf32>) -> tensor<2x?x256xf32>
    %62 = linalg.batch_matmul ins(%57, %59 : tensor<2x?x64xf32>, tensor<2x64x256xf32>) outs(%61 : tensor<2x?x256xf32>) -> tensor<2x?x256xf32>
    %63 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%62 : tensor<2x?x256xf32>) outs(%60 : tensor<2x?x256xf32>) {
    ^bb0(%in: f32, %out: f32):
      %68 = arith.divf %in, %cst_8 : f32
      %69 = math.erf %68 : f32
      %70 = arith.addf %69, %cst_2 : f32
      %71 = arith.mulf %70, %cst_3 : f32
      %72 = arith.mulf %in, %71 : f32
      linalg.yield %72 : f32
    } -> tensor<2x?x256xf32>
    %64 = tensor.empty() : tensor<2x256x64xf32>
    %65 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg3 : tensor<256x64xf32>) outs(%64 : tensor<2x256x64xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x256x64xf32>
    %66 = linalg.batch_matmul ins(%63, %65 : tensor<2x?x256xf32>, tensor<2x256x64xf32>) outs(%39 : tensor<2x?x64xf32>) -> tensor<2x?x64xf32>
    %67 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%41, %66 : tensor<2x?x64xf32>, tensor<2x?x64xf32>) outs(%15 : tensor<2x?x64xf32>) {
    ^bb0(%in: f32, %in_11: f32, %out: f32):
      %68 = arith.addf %in, %in_11 : f32
      linalg.yield %68 : f32
    } -> tensor<2x?x64xf32>
    return %67 : tensor<2x?x64xf32>
  }
}
