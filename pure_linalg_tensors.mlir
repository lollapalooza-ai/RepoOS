module {
  func.func @main(%arg0: tensor<512x512xf32>, %arg1: tensor<512x512xf32>, %arg2: tensor<512x512xf32>) -> tensor<512x512xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = linalg.fill ins(%cst : f32) outs(%arg2 : tensor<512x512xf32>) -> tensor<512x512xf32>
    %1 = linalg.matmul ins(%arg0, %arg1 : tensor<512x512xf32>, tensor<512x512xf32>) outs(%0 : tensor<512x512xf32>) -> tensor<512x512xf32>
    return %1 : tensor<512x512xf32>
  }
}

