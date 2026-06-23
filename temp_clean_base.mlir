module {
  func.func @main(%arg0: tensor<4096x4096xf32>, %arg1: tensor<4096x4096xf32>, %arg2: tensor<4096x4096xf32>) -> tensor<4096x4096xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.cast %arg2 : tensor<4096x4096xf32> to tensor<4096x4096xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<4096x4096xf32>) -> tensor<4096x4096xf32>
    %2 = linalg.matmul ins(%arg0, %arg1 : tensor<4096x4096xf32>, tensor<4096x4096xf32>) outs(%1 : tensor<4096x4096xf32>) -> tensor<4096x4096xf32>
    return %2 : tensor<4096x4096xf32>
  }
}
