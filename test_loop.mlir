#map = affine_map<(d0) -> (d0 * 64)>
#map1 = affine_map<(d0) -> (d0 * 8)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: memref<4096x4096xf32>, %arg1: memref<4096x4096xf32>, %arg2: memref<4096x4096xf32>) {
    %c8 = arith.constant 8 : index
    %c64 = arith.constant 64 : index
    %c1 = arith.constant 1 : index
    %c4096 = arith.constant 4096 : index
    %cst = arith.constant dense<2.000000e+00> : vector<64x8xf32>
    %0 = ub.poison : f32
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<4096x4096xf32>
    scf.for %arg3 = %c0 to %c4096 step %c1 {
      scf.for %arg4 = %c0 to %c4096 step %c1 {
        %1 = memref.load %arg2[%arg3, %arg4] : memref<4096x4096xf32>
        memref.store %1, %alloc[%arg3, %arg4] : memref<4096x4096xf32>
      }
    }
    scf.forall (%arg3, %arg4) in (64, 512) {
      %1 = affine.apply #map(%arg3)
      %2 = affine.apply #map1(%arg4)
      %subview = memref.subview %arg0[%1, %2] [64, 8] [1, 1] : memref<4096x4096xf32> to memref<64x8xf32, strided<[4096, 1], offset: ?>>
      %subview_0 = memref.subview %arg1[%1, %2] [64, 8] [1, 1] : memref<4096x4096xf32> to memref<64x8xf32, strided<[4096, 1], offset: ?>>
      %subview_1 = memref.subview %alloc[%1, %2] [64, 8] [1, 1] : memref<4096x4096xf32> to memref<64x8xf32, strided<[4096, 1], offset: ?>>
      %3 = vector.transfer_read %subview[%c0, %c0], %0 {in_bounds = [true, true]} : memref<64x8xf32, strided<[4096, 1], offset: ?>>, vector<64x8xf32>
      %4 = vector.transfer_read %subview_0[%c0, %c0], %0 {in_bounds = [true, true]} : memref<64x8xf32, strided<[4096, 1], offset: ?>>, vector<64x8xf32>
      %5 = arith.mulf %3, %4 : vector<64x8xf32>
      vector.transfer_write %5, %subview_1[%c0, %c0] {in_bounds = [true, true]} : vector<64x8xf32>, memref<64x8xf32, strided<[4096, 1], offset: ?>>
      %subview_2 = memref.subview %alloc[%1, %2] [64, 8] [1, 1] : memref<4096x4096xf32> to memref<64x8xf32, strided<[4096, 1], offset: ?>>
      scf.for %arg5 = %c0 to %c64 step %c1 {
        scf.for %arg6 = %c0 to %c8 step %c1 {
          %6 = memref.load %subview_1[%arg5, %arg6] : memref<64x8xf32, strided<[4096, 1], offset: ?>>
          memref.store %6, %subview_2[%arg5, %arg6] : memref<64x8xf32, strided<[4096, 1], offset: ?>>
        }
      }
    }
    scf.forall (%arg3, %arg4) in (64, 512) {
      %1 = affine.apply #map(%arg3)
      %2 = affine.apply #map1(%arg4)
      %subview = memref.subview %alloc[%1, %2] [64, 8] [1, 1] : memref<4096x4096xf32> to memref<64x8xf32, strided<[4096, 1], offset: ?>>
      %subview_0 = memref.subview %arg2[%1, %2] [64, 8] [1, 1] : memref<4096x4096xf32> to memref<64x8xf32, strided<[4096, 1], offset: ?>>
      %3 = vector.transfer_read %subview[%c0, %c0], %0 {in_bounds = [true, true]} : memref<64x8xf32, strided<[4096, 1], offset: ?>>, vector<64x8xf32>
      %4 = arith.addf %3, %cst : vector<64x8xf32>
      vector.transfer_write %4, %subview_0[%c0, %c0] {in_bounds = [true, true]} : vector<64x8xf32>, memref<64x8xf32, strided<[4096, 1], offset: ?>>
      %subview_1 = memref.subview %arg2[%1, %2] [64, 8] [1, 1] : memref<4096x4096xf32> to memref<64x8xf32, strided<[4096, 1], offset: ?>>
      scf.for %arg5 = %c0 to %c64 step %c1 {
        scf.for %arg6 = %c0 to %c8 step %c1 {
          %5 = memref.load %subview_0[%arg5, %arg6] : memref<64x8xf32, strided<[4096, 1], offset: ?>>
          memref.store %5, %subview_1[%arg5, %arg6] : memref<64x8xf32, strided<[4096, 1], offset: ?>>
        }
      }
    }
    return
  }
}

