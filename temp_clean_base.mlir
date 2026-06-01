#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (0, d1)>
module {
  func.func @main(%arg0: tensor<4x4xf32>, %arg1: tensor<4x1xf32>, %arg2: tensor<4x1xf32>, %arg3: tensor<4x1xf32>, %arg4: f64, %arg5: i64, %arg6: tensor<4x1xf32>) {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant dense<1.000000e+00> : tensor<1x4xf32>
    %cst_1 = arith.constant 8.500000e-01 : f64
    %cst_2 = arith.constant 0.15000000000000002 : f64
    %cst_3 = arith.constant 0.000000e+00 : f64
    %0 = tensor.empty() : tensor<1x4xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x4xf32>) -> tensor<1x4xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["reduction", "parallel"]} ins(%arg0 : tensor<4x4xf32>) outs(%1 : tensor<1x4xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.addf %in, %out : f32
      linalg.yield %84 : f32
    } -> tensor<1x4xf32>
    %3 = tensor.empty() : tensor<1x4xi1>
    %4 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%2 : tensor<1x4xf32>) outs(%3 : tensor<1x4xi1>) {
    ^bb0(%in: f32, %out: i1):
      %84 = arith.extf %in : f32 to f64
      %85 = arith.cmpf oeq, %84, %cst_3 : f64
      linalg.yield %85 : i1
    } -> tensor<1x4xi1>
    %5 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%4 : tensor<1x4xi1>) outs(%0 : tensor<1x4xf32>) {
    ^bb0(%in: i1, %out: f32):
      %84 = arith.uitofp %in : i1 to f32
      linalg.yield %84 : f32
    } -> tensor<1x4xf32>
    %6 = linalg.generic {indexing_maps = [#map, #map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%4, %cst_0, %2 : tensor<1x4xi1>, tensor<1x4xf32>, tensor<1x4xf32>) outs(%0 : tensor<1x4xf32>) {
    ^bb0(%in: i1, %in_4: f32, %in_5: f32, %out: f32):
      %84 = arith.select %in, %in_4, %in_5 : f32
      linalg.yield %84 : f32
    } -> tensor<1x4xf32>
    %7 = tensor.empty() : tensor<4x4xf32>
    %8 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %6 : tensor<4x4xf32>, tensor<1x4xf32>) outs(%7 : tensor<4x4xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.divf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x4xf32>
    %9 = tensor.empty() : tensor<4x1xf32>
    %10 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg1 : tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_2 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<4x1xf32>
    %11 = linalg.fill ins(%cst : f32) outs(%9 : tensor<4x1xf32>) -> tensor<4x1xf32>
    %12 = linalg.matmul ins(%8, %arg2 : tensor<4x4xf32>, tensor<4x1xf32>) outs(%11 : tensor<4x1xf32>) -> tensor<4x1xf32>
    %13 = tensor.empty() : tensor<1x1xf32>
    %14 = linalg.fill ins(%cst : f32) outs(%13 : tensor<1x1xf32>) -> tensor<1x1xf32>
    %15 = linalg.matmul ins(%5, %arg2 : tensor<1x4xf32>, tensor<4x1xf32>) outs(%14 : tensor<1x1xf32>) -> tensor<1x1xf32>
    %16 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%12 : tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<4x1xf32>
    %17 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%15 : tensor<1x1xf32>) outs(%13 : tensor<1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<1x1xf32>
    %18 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%arg3, %17 : tensor<4x1xf32>, tensor<1x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.mulf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %19 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%16, %18 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %20 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%19, %10 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %21 = linalg.matmul ins(%8, %20 : tensor<4x4xf32>, tensor<4x1xf32>) outs(%11 : tensor<4x1xf32>) -> tensor<4x1xf32>
    %22 = linalg.matmul ins(%5, %20 : tensor<1x4xf32>, tensor<4x1xf32>) outs(%14 : tensor<1x1xf32>) -> tensor<1x1xf32>
    %23 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%21 : tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<4x1xf32>
    %24 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%22 : tensor<1x1xf32>) outs(%13 : tensor<1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<1x1xf32>
    %25 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%arg3, %24 : tensor<4x1xf32>, tensor<1x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.mulf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %26 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%23, %25 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %27 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%26, %10 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %28 = linalg.matmul ins(%8, %27 : tensor<4x4xf32>, tensor<4x1xf32>) outs(%11 : tensor<4x1xf32>) -> tensor<4x1xf32>
    %29 = linalg.matmul ins(%5, %27 : tensor<1x4xf32>, tensor<4x1xf32>) outs(%14 : tensor<1x1xf32>) -> tensor<1x1xf32>
    %30 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%28 : tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<4x1xf32>
    %31 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%29 : tensor<1x1xf32>) outs(%13 : tensor<1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<1x1xf32>
    %32 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%arg3, %31 : tensor<4x1xf32>, tensor<1x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.mulf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %33 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%30, %32 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %34 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%33, %10 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %35 = linalg.matmul ins(%8, %34 : tensor<4x4xf32>, tensor<4x1xf32>) outs(%11 : tensor<4x1xf32>) -> tensor<4x1xf32>
    %36 = linalg.matmul ins(%5, %34 : tensor<1x4xf32>, tensor<4x1xf32>) outs(%14 : tensor<1x1xf32>) -> tensor<1x1xf32>
    %37 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%35 : tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<4x1xf32>
    %38 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%36 : tensor<1x1xf32>) outs(%13 : tensor<1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<1x1xf32>
    %39 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%arg3, %38 : tensor<4x1xf32>, tensor<1x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.mulf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %40 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%37, %39 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %41 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%40, %10 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %42 = linalg.matmul ins(%8, %41 : tensor<4x4xf32>, tensor<4x1xf32>) outs(%11 : tensor<4x1xf32>) -> tensor<4x1xf32>
    %43 = linalg.matmul ins(%5, %41 : tensor<1x4xf32>, tensor<4x1xf32>) outs(%14 : tensor<1x1xf32>) -> tensor<1x1xf32>
    %44 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%42 : tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<4x1xf32>
    %45 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%43 : tensor<1x1xf32>) outs(%13 : tensor<1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<1x1xf32>
    %46 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%arg3, %45 : tensor<4x1xf32>, tensor<1x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.mulf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %47 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%44, %46 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %48 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%47, %10 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %49 = linalg.matmul ins(%8, %48 : tensor<4x4xf32>, tensor<4x1xf32>) outs(%11 : tensor<4x1xf32>) -> tensor<4x1xf32>
    %50 = linalg.matmul ins(%5, %48 : tensor<1x4xf32>, tensor<4x1xf32>) outs(%14 : tensor<1x1xf32>) -> tensor<1x1xf32>
    %51 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%49 : tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<4x1xf32>
    %52 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%50 : tensor<1x1xf32>) outs(%13 : tensor<1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<1x1xf32>
    %53 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%arg3, %52 : tensor<4x1xf32>, tensor<1x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.mulf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %54 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%51, %53 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %55 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%54, %10 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %56 = linalg.matmul ins(%8, %55 : tensor<4x4xf32>, tensor<4x1xf32>) outs(%11 : tensor<4x1xf32>) -> tensor<4x1xf32>
    %57 = linalg.matmul ins(%5, %55 : tensor<1x4xf32>, tensor<4x1xf32>) outs(%14 : tensor<1x1xf32>) -> tensor<1x1xf32>
    %58 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%56 : tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<4x1xf32>
    %59 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%57 : tensor<1x1xf32>) outs(%13 : tensor<1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<1x1xf32>
    %60 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%arg3, %59 : tensor<4x1xf32>, tensor<1x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.mulf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %61 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%58, %60 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %62 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%61, %10 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %63 = linalg.matmul ins(%8, %62 : tensor<4x4xf32>, tensor<4x1xf32>) outs(%11 : tensor<4x1xf32>) -> tensor<4x1xf32>
    %64 = linalg.matmul ins(%5, %62 : tensor<1x4xf32>, tensor<4x1xf32>) outs(%14 : tensor<1x1xf32>) -> tensor<1x1xf32>
    %65 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%63 : tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<4x1xf32>
    %66 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%64 : tensor<1x1xf32>) outs(%13 : tensor<1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<1x1xf32>
    %67 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%arg3, %66 : tensor<4x1xf32>, tensor<1x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.mulf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %68 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%65, %67 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %69 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%68, %10 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %70 = linalg.matmul ins(%8, %69 : tensor<4x4xf32>, tensor<4x1xf32>) outs(%11 : tensor<4x1xf32>) -> tensor<4x1xf32>
    %71 = linalg.matmul ins(%5, %69 : tensor<1x4xf32>, tensor<4x1xf32>) outs(%14 : tensor<1x1xf32>) -> tensor<1x1xf32>
    %72 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%70 : tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<4x1xf32>
    %73 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%71 : tensor<1x1xf32>) outs(%13 : tensor<1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<1x1xf32>
    %74 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%arg3, %73 : tensor<4x1xf32>, tensor<1x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.mulf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %75 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%72, %74 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %76 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%75, %10 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %77 = linalg.matmul ins(%8, %76 : tensor<4x4xf32>, tensor<4x1xf32>) outs(%11 : tensor<4x1xf32>) -> tensor<4x1xf32>
    %78 = linalg.matmul ins(%5, %76 : tensor<1x4xf32>, tensor<4x1xf32>) outs(%14 : tensor<1x1xf32>) -> tensor<1x1xf32>
    %79 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%77 : tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<4x1xf32>
    %80 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%78 : tensor<1x1xf32>) outs(%13 : tensor<1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %84 = arith.truncf %cst_1 : f64 to f32
      %85 = arith.mulf %in, %84 : f32
      linalg.yield %85 : f32
    } -> tensor<1x1xf32>
    %81 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%arg3, %80 : tensor<4x1xf32>, tensor<1x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.mulf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %82 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%79, %81 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    %83 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%82, %10 : tensor<4x1xf32>, tensor<4x1xf32>) outs(%9 : tensor<4x1xf32>) {
    ^bb0(%in: f32, %in_4: f32, %out: f32):
      %84 = arith.addf %in, %in_4 : f32
      linalg.yield %84 : f32
    } -> tensor<4x1xf32>
    return
  }
}
