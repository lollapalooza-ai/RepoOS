#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func @main(%arg0: tensor<?x?x?xf32>, %arg1: tensor<?x?x?xf32>, %arg2: tensor<?x?x?xf32>, %arg3: tensor<?x?x?xf32>) -> tensor<?x?x?xf32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 8.000000e+00 : f32
    %dim = tensor.dim %arg1, %c0 : tensor<?x?x?xf32>
    %dim_1 = tensor.dim %arg1, %c1 : tensor<?x?x?xf32>
    %dim_2 = tensor.dim %arg1, %c2 : tensor<?x?x?xf32>
    %0 = tensor.empty(%dim, %dim_2, %dim_1) : tensor<?x?x?xf32>
    %transposed = linalg.transpose ins(%arg1 : tensor<?x?x?xf32>) outs(%0 : tensor<?x?x?xf32>) permutation = [0, 2, 1] 
    %dim_3 = tensor.dim %arg0, %c0 : tensor<?x?x?xf32>
    %1 = arith.maxui %dim_3, %dim : index
    %dim_4 = tensor.dim %arg0, %c1 : tensor<?x?x?xf32>
    %dim_5 = tensor.dim %arg0, %c2 : tensor<?x?x?xf32>
    %2 = arith.index_cast %dim_5 : index to i64
    %3 = arith.index_cast %dim_2 : index to i64
    %4 = arith.cmpi eq, %2, %3 : i64
    cf.assert %4, "mismatching contracting dimension"
    %5 = tensor.empty(%1, %dim_4, %dim_1) : tensor<?x?x?xf32>
    %6 = linalg.fill ins(%cst : f32) outs(%5 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %7 = linalg.batch_matmul ins(%arg0, %transposed : tensor<?x?x?xf32>, tensor<?x?x?xf32>) outs(%6 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %8 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%7 : tensor<?x?x?xf32>) outs(%5 : tensor<?x?x?xf32>) {
    ^bb0(%in: f32, %out: f32):
      %16 = arith.divf %in, %cst_0 : f32
      linalg.yield %16 : f32
    } -> tensor<?x?x?xf32>
    %dim_6 = tensor.dim %arg2, %c0 : tensor<?x?x?xf32>
    %9 = arith.maxui %1, %dim_6 : index
    %dim_7 = tensor.dim %arg2, %c1 : tensor<?x?x?xf32>
    %dim_8 = tensor.dim %arg2, %c2 : tensor<?x?x?xf32>
    %10 = arith.index_cast %dim_1 : index to i64
    %11 = arith.index_cast %dim_7 : index to i64
    %12 = arith.cmpi eq, %10, %11 : i64
    cf.assert %12, "mismatching contracting dimension"
    %13 = tensor.cast %arg3 : tensor<?x?x?xf32> to tensor<?x?x?xf32>
    %14 = linalg.fill ins(%cst : f32) outs(%13 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %15 = linalg.batch_matmul ins(%8, %arg2 : tensor<?x?x?xf32>, tensor<?x?x?xf32>) outs(%14 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    return %15 : tensor<?x?x?xf32>
  }
}
