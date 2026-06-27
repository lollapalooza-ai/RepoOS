#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, 0)>
#map2 = affine_map<(d0, d1, d2) -> (d2)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map4 = affine_map<(d0, d1, d2) -> (d1, d2)>
module {
  func.func @main(%arg0: tensor<?x?x?xf32>, %arg1: tensor<?x?x?xf32>, %arg2: tensor<?x?xf32>, %arg3: tensor<?x?xf32>, %arg4: tensor<?xf32>, %arg5: tensor<?xf32>, %arg6: tensor<?xf32>, %arg7: tensor<?xf32>, %arg8: tensor<?x?x?xf32>) -> tensor<?x?x?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %c0_i64 = arith.constant 0 : i64
    %cst_0 = arith.constant 0.000000e+00 : f64
    %cst_1 = arith.constant 0xFF800000 : f32
    %cst_2 = arith.constant 1.000000e+00 : f32
    %cst_3 = arith.constant 5.000000e-01 : f32
    %cst_4 = arith.constant 1.000000e-05 : f64
    %cst_5 = arith.constant 8.000000e+00 : f32
    %cst_6 = arith.constant 1.41421354 : f32
    %dim = tensor.dim %arg0, %c0 : tensor<?x?x?xf32>
    %dim_7 = tensor.dim %arg0, %c1 : tensor<?x?x?xf32>
    %0 = tensor.empty(%dim, %dim_7) : tensor<?x?x1xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<?x?x1xf32>) -> tensor<?x?x1xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg0 : tensor<?x?x?xf32>) outs(%1 : tensor<?x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %83 = arith.addf %in, %out : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x1xf32>
    %dim_8 = tensor.dim %arg0, %c2 : tensor<?x?x?xf32>
    %3 = arith.index_cast %dim_8 : index to i64
    %4 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%2 : tensor<?x?x1xf32>) outs(%0 : tensor<?x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %83 = arith.sitofp %3 : i64 to f32
      %84 = arith.divf %in, %83 : f32
      linalg.yield %84 : f32
    } -> tensor<?x?x1xf32>
    %5 = tensor.empty(%dim, %dim_7, %dim_8) : tensor<?x?x?xf64>
    %6 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0 : tensor<?x?x?xf32>) outs(%5 : tensor<?x?x?xf64>) {
    ^bb0(%in: f32, %out: f64):
      %83 = arith.extf %in : f32 to f64
      linalg.yield %83 : f64
    } -> tensor<?x?x?xf64>
    %7 = tensor.empty(%dim, %dim_7) : tensor<?x?x1xf64>
    %8 = linalg.fill ins(%cst_0 : f64) outs(%7 : tensor<?x?x1xf64>) -> tensor<?x?x1xf64>
    %9 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%6 : tensor<?x?x?xf64>) outs(%8 : tensor<?x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %83 = arith.addf %in, %out : f64
      linalg.yield %83 : f64
    } -> tensor<?x?x1xf64>
    %10 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%9 : tensor<?x?x1xf64>) outs(%7 : tensor<?x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %83 = arith.sitofp %3 : i64 to f64
      %84 = arith.divf %in, %83 : f64
      linalg.yield %84 : f64
    } -> tensor<?x?x1xf64>
    %11 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%6, %10 : tensor<?x?x?xf64>, tensor<?x?x1xf64>) outs(%5 : tensor<?x?x?xf64>) {
    ^bb0(%in: f64, %in_20: f64, %out: f64):
      %83 = arith.subf %in, %in_20 : f64
      linalg.yield %83 : f64
    } -> tensor<?x?x?xf64>
    %12 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%11, %11 : tensor<?x?x?xf64>, tensor<?x?x?xf64>) outs(%5 : tensor<?x?x?xf64>) {
    ^bb0(%in: f64, %in_20: f64, %out: f64):
      %83 = arith.mulf %in, %in_20 : f64
      linalg.yield %83 : f64
    } -> tensor<?x?x?xf64>
    %13 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%12 : tensor<?x?x?xf64>) outs(%8 : tensor<?x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %83 = arith.addf %in, %out : f64
      linalg.yield %83 : f64
    } -> tensor<?x?x1xf64>
    %14 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%13 : tensor<?x?x1xf64>) outs(%7 : tensor<?x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %83 = arith.sitofp %3 : i64 to f64
      %84 = arith.divf %in, %83 : f64
      linalg.yield %84 : f64
    } -> tensor<?x?x1xf64>
    %15 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%14 : tensor<?x?x1xf64>) outs(%0 : tensor<?x?x1xf32>) {
    ^bb0(%in: f64, %out: f32):
      %83 = arith.truncf %in : f64 to f32
      linalg.yield %83 : f32
    } -> tensor<?x?x1xf32>
    %16 = tensor.empty(%dim, %dim_7, %dim_8) : tensor<?x?x?xf32>
    %17 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0, %4 : tensor<?x?x?xf32>, tensor<?x?x1xf32>) outs(%16 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %in_20: f32, %out: f32):
      %83 = arith.subf %in, %in_20 : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x?xf32>
    %18 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%15 : tensor<?x?x1xf32>) outs(%0 : tensor<?x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %83 = arith.truncf %cst_4 : f64 to f32
      %84 = arith.addf %in, %83 : f32
      linalg.yield %84 : f32
    } -> tensor<?x?x1xf32>
    %19 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%18 : tensor<?x?x1xf32>) outs(%0 : tensor<?x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %83 = math.sqrt %in : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x1xf32>
    %20 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%17, %19 : tensor<?x?x?xf32>, tensor<?x?x1xf32>) outs(%16 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %in_20: f32, %out: f32):
      %83 = arith.divf %in, %in_20 : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x?xf32>
    %dim_9 = tensor.dim %arg4, %c0 : tensor<?xf32>
    %21 = arith.cmpi eq, %dim_8, %dim_9 : index
    cf.assert %21, "mismatched size for broadcast"
    %22 = linalg.generic {indexing_maps = [#map, #map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%20, %arg4 : tensor<?x?x?xf32>, tensor<?xf32>) outs(%16 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %in_20: f32, %out: f32):
      %83 = arith.mulf %in, %in_20 : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x?xf32>
    %dim_10 = tensor.dim %arg5, %c0 : tensor<?xf32>
    %23 = arith.cmpi eq, %dim_8, %dim_10 : index
    cf.assert %23, "mismatched size for broadcast"
    %24 = linalg.generic {indexing_maps = [#map, #map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%22, %arg5 : tensor<?x?x?xf32>, tensor<?xf32>) outs(%16 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %in_20: f32, %out: f32):
      %83 = arith.addf %in, %in_20 : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x?xf32>
    %25 = tensor.empty(%dim, %dim_8, %dim_7) : tensor<?x?x?xf32>
    %transposed = linalg.transpose ins(%24 : tensor<?x?x?xf32>) outs(%25 : tensor<?x?x?xf32>) permutation = [0, 2, 1] 
    %26 = tensor.empty(%dim, %dim_7, %dim_7) : tensor<?x?x?xf32>
    %27 = linalg.fill ins(%cst : f32) outs(%26 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %28 = linalg.batch_matmul ins(%24, %transposed : tensor<?x?x?xf32>, tensor<?x?x?xf32>) outs(%27 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %29 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%28 : tensor<?x?x?xf32>) outs(%26 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %out: f32):
      %83 = arith.divf %in, %cst_5 : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x?xf32>
    %dim_11 = tensor.dim %arg1, %c0 : tensor<?x?x?xf32>
    %30 = arith.cmpi eq, %dim, %dim_11 : index
    cf.assert %30, "mismatched size for broadcast"
    %dim_12 = tensor.dim %arg1, %c1 : tensor<?x?x?xf32>
    %31 = arith.cmpi eq, %dim_7, %dim_12 : index
    cf.assert %31, "mismatched size for broadcast"
    %dim_13 = tensor.dim %arg1, %c2 : tensor<?x?x?xf32>
    %32 = arith.cmpi eq, %dim_7, %dim_13 : index
    cf.assert %32, "mismatched size for broadcast"
    %33 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%29, %arg1 : tensor<?x?x?xf32>, tensor<?x?x?xf32>) outs(%26 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %in_20: f32, %out: f32):
      %83 = arith.addf %in, %in_20 : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x?xf32>
    %34 = tensor.empty(%dim, %dim_7) : tensor<?x?xi64>
    %35 = linalg.fill ins(%c0_i64 : i64) outs(%34 : tensor<?x?xi64>) -> tensor<?x?xi64>
    %36 = tensor.empty(%dim, %dim_7) : tensor<?x?xf32>
    %37 = linalg.fill ins(%cst_1 : f32) outs(%36 : tensor<?x?xf32>) -> tensor<?x?xf32>
    %38:2 = linalg.generic {indexing_maps = [#map, #map3, #map3], iterator_types = ["parallel", "parallel", "reduction"]} ins(%33 : tensor<?x?x?xf32>) outs(%37, %35 : tensor<?x?xf32>, tensor<?x?xi64>) {
    ^bb0(%in: f32, %out: f32, %out_20: i64):
      %83 = linalg.index 2 : index
      %84 = arith.index_cast %83 : index to i64
      %85 = arith.maximumf %in, %out : f32
      %86 = arith.cmpf ogt, %in, %out : f32
      %87 = arith.select %86, %84, %out_20 : i64
      linalg.yield %85, %87 : f32, i64
    } -> (tensor<?x?xf32>, tensor<?x?xi64>)
    %expanded = tensor.expand_shape %38#0 [[0], [1, 2]] output_shape [%dim, %dim_7, 1] : tensor<?x?xf32> into tensor<?x?x1xf32>
    %39 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%33, %expanded : tensor<?x?x?xf32>, tensor<?x?x1xf32>) outs(%26 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %in_20: f32, %out: f32):
      %83 = arith.subf %in, %in_20 : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x?xf32>
    %40 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%39 : tensor<?x?x?xf32>) outs(%26 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %out: f32):
      %83 = math.exp %in : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x?xf32>
    %41 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%40 : tensor<?x?x?xf32>) outs(%1 : tensor<?x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %83 = arith.addf %in, %out : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x1xf32>
    %42 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%40, %41 : tensor<?x?x?xf32>, tensor<?x?x1xf32>) outs(%26 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %in_20: f32, %out: f32):
      %83 = arith.divf %in, %in_20 : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x?xf32>
    %43 = linalg.fill ins(%cst : f32) outs(%16 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %44 = linalg.batch_matmul ins(%42, %24 : tensor<?x?x?xf32>, tensor<?x?x?xf32>) outs(%43 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %45 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0, %44 : tensor<?x?x?xf32>, tensor<?x?x?xf32>) outs(%16 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %in_20: f32, %out: f32):
      %83 = arith.addf %in, %in_20 : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x?xf32>
    %46 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%45 : tensor<?x?x?xf32>) outs(%1 : tensor<?x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %83 = arith.addf %in, %out : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x1xf32>
    %47 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%46 : tensor<?x?x1xf32>) outs(%0 : tensor<?x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %83 = arith.sitofp %3 : i64 to f32
      %84 = arith.divf %in, %83 : f32
      linalg.yield %84 : f32
    } -> tensor<?x?x1xf32>
    %48 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%45 : tensor<?x?x?xf32>) outs(%5 : tensor<?x?x?xf64>) {
    ^bb0(%in: f32, %out: f64):
      %83 = arith.extf %in : f32 to f64
      linalg.yield %83 : f64
    } -> tensor<?x?x?xf64>
    %49 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%48 : tensor<?x?x?xf64>) outs(%8 : tensor<?x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %83 = arith.addf %in, %out : f64
      linalg.yield %83 : f64
    } -> tensor<?x?x1xf64>
    %50 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%49 : tensor<?x?x1xf64>) outs(%7 : tensor<?x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %83 = arith.sitofp %3 : i64 to f64
      %84 = arith.divf %in, %83 : f64
      linalg.yield %84 : f64
    } -> tensor<?x?x1xf64>
    %51 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%48, %50 : tensor<?x?x?xf64>, tensor<?x?x1xf64>) outs(%5 : tensor<?x?x?xf64>) {
    ^bb0(%in: f64, %in_20: f64, %out: f64):
      %83 = arith.subf %in, %in_20 : f64
      linalg.yield %83 : f64
    } -> tensor<?x?x?xf64>
    %52 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%51, %51 : tensor<?x?x?xf64>, tensor<?x?x?xf64>) outs(%5 : tensor<?x?x?xf64>) {
    ^bb0(%in: f64, %in_20: f64, %out: f64):
      %83 = arith.mulf %in, %in_20 : f64
      linalg.yield %83 : f64
    } -> tensor<?x?x?xf64>
    %53 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%52 : tensor<?x?x?xf64>) outs(%8 : tensor<?x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %83 = arith.addf %in, %out : f64
      linalg.yield %83 : f64
    } -> tensor<?x?x1xf64>
    %54 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%53 : tensor<?x?x1xf64>) outs(%7 : tensor<?x?x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %83 = arith.sitofp %3 : i64 to f64
      %84 = arith.divf %in, %83 : f64
      linalg.yield %84 : f64
    } -> tensor<?x?x1xf64>
    %55 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%54 : tensor<?x?x1xf64>) outs(%0 : tensor<?x?x1xf32>) {
    ^bb0(%in: f64, %out: f32):
      %83 = arith.truncf %in : f64 to f32
      linalg.yield %83 : f32
    } -> tensor<?x?x1xf32>
    %56 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%45, %47 : tensor<?x?x?xf32>, tensor<?x?x1xf32>) outs(%16 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %in_20: f32, %out: f32):
      %83 = arith.subf %in, %in_20 : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x?xf32>
    %57 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%55 : tensor<?x?x1xf32>) outs(%0 : tensor<?x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %83 = arith.truncf %cst_4 : f64 to f32
      %84 = arith.addf %in, %83 : f32
      linalg.yield %84 : f32
    } -> tensor<?x?x1xf32>
    %58 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%57 : tensor<?x?x1xf32>) outs(%0 : tensor<?x?x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %83 = math.sqrt %in : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x1xf32>
    %59 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%56, %58 : tensor<?x?x?xf32>, tensor<?x?x1xf32>) outs(%16 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %in_20: f32, %out: f32):
      %83 = arith.divf %in, %in_20 : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x?xf32>
    %dim_14 = tensor.dim %arg6, %c0 : tensor<?xf32>
    %60 = arith.cmpi eq, %dim_8, %dim_14 : index
    cf.assert %60, "mismatched size for broadcast"
    %61 = linalg.generic {indexing_maps = [#map, #map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%59, %arg6 : tensor<?x?x?xf32>, tensor<?xf32>) outs(%16 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %in_20: f32, %out: f32):
      %83 = arith.mulf %in, %in_20 : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x?xf32>
    %dim_15 = tensor.dim %arg7, %c0 : tensor<?xf32>
    %62 = arith.cmpi eq, %dim_8, %dim_15 : index
    cf.assert %62, "mismatched size for broadcast"
    %63 = linalg.generic {indexing_maps = [#map, #map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%61, %arg7 : tensor<?x?x?xf32>, tensor<?xf32>) outs(%16 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %in_20: f32, %out: f32):
      %83 = arith.addf %in, %in_20 : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x?xf32>
    %dim_16 = tensor.dim %arg2, %c0 : tensor<?x?xf32>
    %dim_17 = tensor.dim %arg2, %c1 : tensor<?x?xf32>
    %64 = arith.index_cast %dim_16 : index to i64
    %65 = arith.cmpi eq, %3, %64 : i64
    cf.assert %65, "mismatching contracting dimension"
    %66 = arith.index_cast %dim : index to i64
    %67 = arith.cmpi sge, %66, %c0_i64 : i64
    cf.assert %67, "negative values not allowed in new dimensions"
    %68 = tensor.empty(%dim, %dim_16, %dim_17) : tensor<?x?x?xf32>
    %69 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg2 : tensor<?x?xf32>) outs(%68 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<?x?x?xf32>
    %70 = tensor.empty(%dim, %dim_7, %dim_17) : tensor<?x?x?xf32>
    %71 = linalg.fill ins(%cst : f32) outs(%70 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %72 = linalg.batch_matmul ins(%63, %69 : tensor<?x?x?xf32>, tensor<?x?x?xf32>) outs(%71 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %73 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%72 : tensor<?x?x?xf32>) outs(%70 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %out: f32):
      %83 = arith.divf %in, %cst_6 : f32
      %84 = math.erf %83 : f32
      %85 = arith.addf %84, %cst_2 : f32
      %86 = arith.mulf %85, %cst_3 : f32
      %87 = arith.mulf %in, %86 : f32
      linalg.yield %87 : f32
    } -> tensor<?x?x?xf32>
    %dim_18 = tensor.dim %arg3, %c0 : tensor<?x?xf32>
    %dim_19 = tensor.dim %arg3, %c1 : tensor<?x?xf32>
    %74 = arith.index_cast %dim_17 : index to i64
    %75 = arith.index_cast %dim_18 : index to i64
    %76 = arith.cmpi eq, %74, %75 : i64
    cf.assert %76, "mismatching contracting dimension"
    cf.assert %67, "negative values not allowed in new dimensions"
    %77 = tensor.empty(%dim, %dim_18, %dim_19) : tensor<?x?x?xf32>
    %78 = linalg.generic {indexing_maps = [#map4, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg3 : tensor<?x?xf32>) outs(%77 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<?x?x?xf32>
    %79 = linalg.fill ins(%cst : f32) outs(%arg8 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %80 = linalg.batch_matmul ins(%73, %78 : tensor<?x?x?xf32>, tensor<?x?x?xf32>) outs(%79 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %81 = arith.cmpi eq, %dim_8, %dim_19 : index
    cf.assert %81, "mismatched size for broadcast"
    %82 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%45, %80 : tensor<?x?x?xf32>, tensor<?x?x?xf32>) outs(%16 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %in_20: f32, %out: f32):
      %83 = arith.addf %in, %in_20 : f32
      linalg.yield %83 : f32
    } -> tensor<?x?x?xf32>
    return %82 : tensor<?x?x?xf32>
  }
}

