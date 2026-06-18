module {
  func.func @main(%arg0: memref<4x4xf32, strided<[4096, 1], offset: ?>>) {
    %c0 = arith.constant 0 : index
    %0 = ub.poison : f32
    %1 = vector.transfer_read %arg0[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4x4xf32>
    vector.transfer_write %1, %arg0[%c0, %c0] {in_bounds = [true, true]} : vector<4x4xf32>, memref<4x4xf32, strided<[4096, 1], offset: ?>>
    return
  }
}
