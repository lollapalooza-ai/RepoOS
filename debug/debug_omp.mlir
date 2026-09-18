#map = affine_map<(d0) -> (d0 * 32)>
#map1 = affine_map<(d0) -> (d0 * 4)>
#map2 = affine_map<(d0) -> (d0 * 8)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: memref<4096x4096xf32>, %arg1: memref<4096x4096xf32>, %arg2: memref<4096x4096xf32>) {
    %c32 = arith.constant 32 : index
    %c8 = arith.constant 8 : index
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    %c4096 = arith.constant 4096 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 2.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<4096x4096xf32>
    %0 = llvm.mlir.constant(1 : i64) : i64
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg3, %arg4) : index = (%c0, %c0) to (%c4096, %c4096) step (%c1, %c1) collapse(2) {
          memref.alloca_scope  {
            %3 = memref.load %arg2[%arg3, %arg4] : memref<4096x4096xf32>
            memref.store %3, %alloc[%arg3, %arg4] : memref<4096x4096xf32>
          }
          omp.yield
        }
      }
      omp.terminator
    }
    %c0_0 = arith.constant 0 : index
    %c0_1 = arith.constant 0 : index
    %c128 = arith.constant 128 : index
    %c128_2 = arith.constant 128 : index
    %c1_3 = arith.constant 1 : index
    %c1_4 = arith.constant 1 : index
    %1 = llvm.mlir.constant(1 : i64) : i64
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg3, %arg4) : index = (%c0_0, %c0_1) to (%c128, %c128_2) step (%c1_3, %c1_4) collapse(2) {
          memref.alloca_scope  {
            %3 = affine.apply #map(%arg3)
            %4 = affine.apply #map(%arg4)
            %subview = memref.subview %arg0[%3, %4] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
            %subview_11 = memref.subview %arg1[%3, %4] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
            %subview_12 = memref.subview %alloc[%3, %4] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
            %c0_13 = arith.constant 0 : index
            %c0_14 = arith.constant 0 : index
            %c8_15 = arith.constant 8 : index
            %c4_16 = arith.constant 4 : index
            %c1_17 = arith.constant 1 : index
            %c1_18 = arith.constant 1 : index
            %5 = llvm.mlir.constant(1 : i64) : i64
            omp.parallel {
              omp.wsloop {
                omp.loop_nest (%arg5, %arg6) : index = (%c0_13, %c0_14) to (%c8_15, %c4_16) step (%c1_17, %c1_18) collapse(2) {
                  memref.alloca_scope  {
                    %7 = affine.apply #map1(%arg5)
                    %8 = affine.apply #map2(%arg6)
                    %subview_20 = memref.subview %subview[%7, %8] [4, 8] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<4x8xf32, strided<[4096, 1], offset: ?>>
                    %subview_21 = memref.subview %subview_11[%7, %8] [4, 8] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<4x8xf32, strided<[4096, 1], offset: ?>>
                    %subview_22 = memref.subview %subview_12[%7, %8] [4, 8] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<4x8xf32, strided<[4096, 1], offset: ?>>
                    %9 = llvm.mlir.constant(1 : i64) : i64
                    omp.parallel {
                      omp.wsloop {
                        omp.loop_nest (%arg7, %arg8) : index = (%c0, %c0) to (%c4, %c8) step (%c1, %c1) collapse(2) {
                          memref.alloca_scope  {
                            %11 = memref.load %subview_20[%arg7, %arg8] : memref<4x8xf32, strided<[4096, 1], offset: ?>>
                            %12 = memref.load %subview_21[%arg7, %arg8] : memref<4x8xf32, strided<[4096, 1], offset: ?>>
                            %13 = arith.mulf %11, %12 : f32
                            memref.store %13, %subview_22[%arg7, %arg8] : memref<4x8xf32, strided<[4096, 1], offset: ?>>
                          }
                          omp.yield
                        }
                      }
                      omp.terminator
                    }
                    %subview_23 = memref.subview %subview_12[%7, %8] [4, 8] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<4x8xf32, strided<[4096, 1], offset: ?>>
                    %10 = llvm.mlir.constant(1 : i64) : i64
                    omp.parallel {
                      omp.wsloop {
                        omp.loop_nest (%arg7, %arg8) : index = (%c0, %c0) to (%c4, %c8) step (%c1, %c1) collapse(2) {
                          memref.alloca_scope  {
                            %11 = memref.load %subview_22[%arg7, %arg8] : memref<4x8xf32, strided<[4096, 1], offset: ?>>
                            memref.store %11, %subview_23[%arg7, %arg8] : memref<4x8xf32, strided<[4096, 1], offset: ?>>
                          }
                          omp.yield
                        }
                      }
                      omp.terminator
                    }
                  }
                  omp.yield
                }
              }
              omp.terminator
            }
            %subview_19 = memref.subview %alloc[%3, %4] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
            %6 = llvm.mlir.constant(1 : i64) : i64
            omp.parallel {
              omp.wsloop {
                omp.loop_nest (%arg5, %arg6) : index = (%c0, %c0) to (%c32, %c32) step (%c1, %c1) collapse(2) {
                  memref.alloca_scope  {
                    %7 = memref.load %subview_12[%arg5, %arg6] : memref<32x32xf32, strided<[4096, 1], offset: ?>>
                    memref.store %7, %subview_19[%arg5, %arg6] : memref<32x32xf32, strided<[4096, 1], offset: ?>>
                  }
                  omp.yield
                }
              }
              omp.terminator
            }
          }
          omp.yield
        }
      }
      omp.terminator
    }
    %c0_5 = arith.constant 0 : index
    %c0_6 = arith.constant 0 : index
    %c128_7 = arith.constant 128 : index
    %c128_8 = arith.constant 128 : index
    %c1_9 = arith.constant 1 : index
    %c1_10 = arith.constant 1 : index
    %2 = llvm.mlir.constant(1 : i64) : i64
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg3, %arg4) : index = (%c0_5, %c0_6) to (%c128_7, %c128_8) step (%c1_9, %c1_10) collapse(2) {
          memref.alloca_scope  {
            %3 = affine.apply #map(%arg3)
            %4 = affine.apply #map(%arg4)
            %subview = memref.subview %alloc[%3, %4] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
            %subview_11 = memref.subview %arg2[%3, %4] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
            %c0_12 = arith.constant 0 : index
            %c0_13 = arith.constant 0 : index
            %c8_14 = arith.constant 8 : index
            %c4_15 = arith.constant 4 : index
            %c1_16 = arith.constant 1 : index
            %c1_17 = arith.constant 1 : index
            %5 = llvm.mlir.constant(1 : i64) : i64
            omp.parallel {
              omp.wsloop {
                omp.loop_nest (%arg5, %arg6) : index = (%c0_12, %c0_13) to (%c8_14, %c4_15) step (%c1_16, %c1_17) collapse(2) {
                  memref.alloca_scope  {
                    %7 = affine.apply #map1(%arg5)
                    %8 = affine.apply #map2(%arg6)
                    %subview_19 = memref.subview %subview[%7, %8] [4, 8] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<4x8xf32, strided<[4096, 1], offset: ?>>
                    %subview_20 = memref.subview %subview_11[%7, %8] [4, 8] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<4x8xf32, strided<[4096, 1], offset: ?>>
                    %9 = llvm.mlir.constant(1 : i64) : i64
                    omp.parallel {
                      omp.wsloop {
                        omp.loop_nest (%arg7, %arg8) : index = (%c0, %c0) to (%c4, %c8) step (%c1, %c1) collapse(2) {
                          memref.alloca_scope  {
                            %11 = memref.load %subview_19[%arg7, %arg8] : memref<4x8xf32, strided<[4096, 1], offset: ?>>
                            %12 = arith.addf %11, %cst : f32
                            memref.store %12, %subview_20[%arg7, %arg8] : memref<4x8xf32, strided<[4096, 1], offset: ?>>
                          }
                          omp.yield
                        }
                      }
                      omp.terminator
                    }
                    %subview_21 = memref.subview %subview_11[%7, %8] [4, 8] [1, 1] : memref<32x32xf32, strided<[4096, 1], offset: ?>> to memref<4x8xf32, strided<[4096, 1], offset: ?>>
                    %10 = llvm.mlir.constant(1 : i64) : i64
                    omp.parallel {
                      omp.wsloop {
                        omp.loop_nest (%arg7, %arg8) : index = (%c0, %c0) to (%c4, %c8) step (%c1, %c1) collapse(2) {
                          memref.alloca_scope  {
                            %11 = memref.load %subview_20[%arg7, %arg8] : memref<4x8xf32, strided<[4096, 1], offset: ?>>
                            memref.store %11, %subview_21[%arg7, %arg8] : memref<4x8xf32, strided<[4096, 1], offset: ?>>
                          }
                          omp.yield
                        }
                      }
                      omp.terminator
                    }
                  }
                  omp.yield
                }
              }
              omp.terminator
            }
            %subview_18 = memref.subview %arg2[%3, %4] [32, 32] [1, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
            %6 = llvm.mlir.constant(1 : i64) : i64
            omp.parallel {
              omp.wsloop {
                omp.loop_nest (%arg5, %arg6) : index = (%c0, %c0) to (%c32, %c32) step (%c1, %c1) collapse(2) {
                  memref.alloca_scope  {
                    %7 = memref.load %subview_11[%arg5, %arg6] : memref<32x32xf32, strided<[4096, 1], offset: ?>>
                    memref.store %7, %subview_18[%arg5, %arg6] : memref<32x32xf32, strided<[4096, 1], offset: ?>>
                  }
                  omp.yield
                }
              }
              omp.terminator
            }
          }
          omp.yield
        }
      }
      omp.terminator
    }
    return
  }
}

