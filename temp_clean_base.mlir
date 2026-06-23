module {
  func.func @main(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>) -> tensor<?x?xf32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f32
    %dim = tensor.dim %arg0, %c0 : tensor<?x?xf32>
    %dim_0 = tensor.dim %arg1, %c1 : tensor<?x?xf32>
    %dim_1 = tensor.dim %arg0, %c1 : tensor<?x?xf32>
    %dim_2 = tensor.dim %arg1, %c0 : tensor<?x?xf32>
    %0 = arith.cmpi eq, %dim_1, %dim_2 : index
    cf.assert %0, "mismatching contracting dimension for torch.aten.mm"
    %1 = tensor.cast %arg2 : tensor<?x?xf32> to tensor<?x?xf32>
    %2 = linalg.fill ins(%cst : f32) outs(%1 : tensor<?x?xf32>) -> tensor<?x?xf32>
    %3 = linalg.matmul ins(%arg0, %arg1 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%2 : tensor<?x?xf32>) -> tensor<?x?xf32>
    return %3 : tensor<?x?xf32>
  }
}
