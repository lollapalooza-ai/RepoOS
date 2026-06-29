module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: memref<128x128xf32>, %arg1: memref<128x128xf32>, %arg2: memref<128x128xf32>) attributes {llvm.emit_c_interface} {
    %cst = arith.constant 0.000000e+00 : f32
    linalg.fill ins(%cst : f32) outs(%arg2 : memref<128x128xf32>)
    linalg.matmul ins(%arg0, %arg1 : memref<128x128xf32>, memref<128x128xf32>) outs(%arg2 : memref<128x128xf32>)
    return
  }
}
