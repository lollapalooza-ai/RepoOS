module attributes {transform.with_named_sequence} {
  memref.global "private" constant @__constant_xf32 : memref<f32> = dense<0xFF800000> {alignment = 64 : i64}
  func.func @main(%arg0: memref<128xf32>, %arg1: memref<128xf32>, %arg2: memref<2x1024x128xf32>, %arg3: memref<384x128xf32>, %arg4: memref<384xf32>, %arg5: memref<1x1x1024x1024xf32>, %arg6: memref<128x128xf32>, %arg7: memref<128xf32>, %arg8: memref<128xf32>, %arg9: memref<128xf32>, %arg10: memref<512x128xf32>, %arg11: memref<512xf32>, %arg12: memref<128x512xf32>, %arg13: memref<128xf32>, %arg14: memref<128xf32>, %arg15: memref<128xf32>, %arg16: memref<384x128xf32>, %arg17: memref<384xf32>, %arg18: memref<1x1x1024x1024xf32>, %arg19: memref<128x128xf32>, %arg20: memref<128xf32>, %arg21: memref<128xf32>, %arg22: memref<128xf32>, %arg23: memref<512x128xf32>, %arg24: memref<512xf32>, %arg25: memref<128x512xf32>, %arg26: memref<128xf32>, %arg27: memref<2x1024x128xf32>) attributes {llvm.emit_c_interface} {
    %c512 = arith.constant 512 : index
    %c384 = arith.constant 384 : index
    %c128 = arith.constant 128 : index
    %c1024 = arith.constant 1024 : index
    %c16 = arith.constant 16 : index
    %c8 = arith.constant 8 : index
    %c2 = arith.constant 2 : index
    %c12 = arith.constant 12 : index
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    %c32 = arith.constant 32 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 1.41421354 : f32
    %cst_0 = arith.constant 1.280000e+02 : f32
    %cst_1 = arith.constant 1.000000e-05 : f64
    %cst_2 = arith.constant 0.17677669529663687 : f64
    %c0_i64 = arith.constant 0 : i64
    %cst_3 = arith.constant 0.000000e+00 : f32
    %cst_4 = arith.constant 0xFF800000 : f32
    %cst_5 = arith.constant 1.000000e+00 : f32
    %cst_6 = arith.constant 5.000000e-01 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    %alloc_7 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c1 step %c1 {
          memref.store %cst_3, %alloc_7[%arg28, %arg29, %arg30] : memref<2x1024x1xf32>
        }
      }
    }
    %alloc_8 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c1 step %c1 {
          %0 = memref.load %alloc_7[%arg28, %arg29, %arg30] : memref<2x1024x1xf32>
          memref.store %0, %alloc_8[%arg28, %arg29, %arg30] : memref<2x1024x1xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %base_buffer, %offset, %sizes:3, %strides:3 = memref.extract_strided_metadata %arg2 : memref<2x1024x128xf32> -> memref<f32>, index, index, index, index, index, index, index
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %base_buffer to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<f32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c32_105 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_8 to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %reinterpret_cast_106[%arg29, %arg30, %c0] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %c0] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_107 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_8 to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_8 to offset: [%0], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            %c32_106 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_106 overflow<nsw> : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %4 = arith.divf %3, %cst_0 : f32
                  memref.store %4, %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_108 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_108 overflow<nsw> : index
            %reinterpret_cast_109 = memref.reinterpret_cast %alloc to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_109[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_9 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_9[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc to offset: [%0], sizes: [2, 32], strides: [1024, 1] : memref<2x1024x1xf32> to memref<2x32xf32, strided<[1024, 1], offset: ?>>
            %c4096 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_9 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30] : memref<2x32xf32, strided<[1024, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_9 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_10 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_10[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %base_buffer, %offset, %sizes:3, %strides:3 = memref.extract_strided_metadata %arg2 : memref<2x1024x128xf32> -> memref<f32>, index, index, index, index, index, index, index
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %base_buffer to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<f32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_9 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_10 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %5 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %6 = arith.subf %4, %5 : f32
                  memref.store %6, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_109 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096_109 overflow<nsw> : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_10 to offset: [%3], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %4, %reinterpret_cast_110[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_11 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_11[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_10 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_10 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_11 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %5 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %6 = arith.mulf %4, %5 : f32
                  memref.store %6, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_109 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096_109 overflow<nsw> : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_11 to offset: [%3], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %4, %reinterpret_cast_110[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_12 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c1 step %c1 {
          %0 = memref.load %alloc_7[%arg28, %arg29, %arg30] : memref<2x1024x1xf32>
          memref.store %0, %alloc_12[%arg28, %arg29, %arg30] : memref<2x1024x1xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_11 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c32_105 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_12 to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %reinterpret_cast_106[%arg29, %arg30, %c0] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %c0] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_107 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_12 to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_12 to offset: [%0], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            %c32_106 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_106 overflow<nsw> : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %4 = arith.divf %3, %cst_0 : f32
                  memref.store %4, %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_108 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_108 overflow<nsw> : index
            %reinterpret_cast_109 = memref.reinterpret_cast %alloc to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_109[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_13 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc to offset: [%0], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            %c32_106 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_106 overflow<nsw> : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc_13 to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %4 = arith.truncf %cst_1 : f64 to f32
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_108 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_108 overflow<nsw> : index
            %reinterpret_cast_109 = memref.reinterpret_cast %alloc_13 to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_109[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_13 to offset: [%0], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            %c32_106 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_106 overflow<nsw> : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %4 = math.rsqrt %3 : f32
                  memref.store %4, %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_108 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_108 overflow<nsw> : index
            %reinterpret_cast_109 = memref.reinterpret_cast %alloc to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_109[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_14 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_14[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc to offset: [%0], sizes: [2, 32], strides: [1024, 1] : memref<2x1024x1xf32> to memref<2x32xf32, strided<[1024, 1], offset: ?>>
            %c4096 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_14 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30] : memref<2x32xf32, strided<[1024, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_14 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_15 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_15[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_10 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_14 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_15 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %5 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %6 = arith.mulf %4, %5 : f32
                  memref.store %6, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_109 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096_109 overflow<nsw> : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_15 to offset: [%3], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %4, %reinterpret_cast_110[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_16 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_16[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_15 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_16 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %arg0[%arg31] : memref<128xf32>
                  %5 = arith.mulf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_16 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_17 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_17[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_16 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_17 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %arg1[%arg31] : memref<128xf32>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_17 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_18 = memref.alloc() {alignment = 64 : i64} : memref<128x384xf32>
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29) : index = (%c0, %c0) to (%c4, %c12) step (%c1, %c1) collapse(2) {
            %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %arg3 : memref<384x128xf32> -> memref<f32>, index, index, index, index, index
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg29, %c4096 overflow<nsw> : index
            %c32_104 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %base_buffer to offset: [%2], sizes: [32, 32], strides: [128, 1] : memref<f32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
            %c12288 = arith.constant 12288 : index
            %3 = arith.muli %arg28, %c12288 overflow<nsw> : index
            %c32_106 = arith.constant 32 : index
            %4 = arith.muli %arg29, %c32_106 overflow<nsw> : index
            %5 = arith.addi %3, %4 : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc_18 to offset: [%5], sizes: [32, 32], strides: [384, 1] : memref<128x384xf32> to memref<32x32xf32, strided<[384, 1], offset: ?>>
            scf.for %arg30 = %c0 to %c32 step %c1 {
              scf.for %arg31 = %c0 to %c32 step %c1 {
                %9 = memref.load %reinterpret_cast_105[%arg31, %arg30] : memref<32x32xf32, strided<[128, 1], offset: ?>>
                memref.store %9, %reinterpret_cast_107[%arg30, %arg31] : memref<32x32xf32, strided<[384, 1], offset: ?>>
              }
            }
            %c12288_108 = arith.constant 12288 : index
            %6 = arith.muli %arg28, %c12288_108 overflow<nsw> : index
            %c32_109 = arith.constant 32 : index
            %7 = arith.muli %arg29, %c32_109 overflow<nsw> : index
            %8 = arith.addi %6, %7 : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_18 to offset: [%8], sizes: [32, 32], strides: [384, 1] : memref<128x384xf32> to memref<32x32xf32, strided<[384, 1], offset: ?>>
            scf.for %arg30 = %c0 to %c32 step %c1 {
              scf.for %arg31 = %c0 to %c32 step %c1 {
                %9 = memref.load %reinterpret_cast_107[%arg30, %arg31] : memref<32x32xf32, strided<[384, 1], offset: ?>>
                memref.store %9, %reinterpret_cast_110[%arg30, %arg31] : memref<32x32xf32, strided<[384, 1], offset: ?>>
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_19 = memref.alloc() {alignment = 64 : i64} : memref<2x128x384xf32>
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c4) step (%c1) {
            %c12288 = arith.constant 12288 : index
            %0 = arith.muli %arg28, %c12288 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_18 to offset: [%0], sizes: [32, 384], strides: [384, 1] : memref<128x384xf32> to memref<32x384xf32, strided<[384, 1], offset: ?>>
            %c12288_105 = arith.constant 12288 : index
            %1 = arith.muli %arg28, %c12288_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_19 to offset: [%1], sizes: [2, 32, 384], strides: [49152, 384, 1] : memref<2x128x384xf32> to memref<2x32x384xf32, strided<[49152, 384, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c384 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg30, %arg31] : memref<32x384xf32, strided<[384, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x384xf32, strided<[49152, 384, 1], offset: ?>>
                }
              }
            }
            %c12288_107 = arith.constant 12288 : index
            %2 = arith.muli %arg28, %c12288_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_19 to offset: [%2], sizes: [2, 32, 384], strides: [49152, 384, 1] : memref<2x128x384xf32> to memref<2x32x384xf32, strided<[49152, 384, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c384 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x384xf32, strided<[49152, 384, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x384xf32, strided<[49152, 384, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_20 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x384xf32>
    %alloc_21 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x384xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c384 step %c1 {
          memref.store %cst_3, %alloc_21[%arg28, %arg29, %arg30] : memref<2x1024x384xf32>
        }
      }
    }
    %alloc_22 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x384xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c384 step %c1 {
          %0 = memref.load %alloc_21[%arg28, %arg29, %arg30] : memref<2x1024x384xf32>
          memref.store %0, %alloc_22[%arg28, %arg29, %arg30] : memref<2x1024x384xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29, %arg30, %arg31) : index = (%c0, %c0, %c0, %c0) to (%c2, %c32, %c12, %c4) step (%c1, %c1, %c1, %c1) collapse(4) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg29, %c4096 overflow<nsw> : index
            %c32_104 = arith.constant 32 : index
            %1 = arith.muli %arg31, %c32_104 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %c131072 = arith.constant 131072 : index
            %3 = arith.muli %arg28, %c131072 overflow<nsw> : index
            %4 = arith.addi %2, %3 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_17 to offset: [%4], sizes: [1, 32, 32], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
            %c12288 = arith.constant 12288 : index
            %5 = arith.muli %arg31, %c12288 overflow<nsw> : index
            %c32_106 = arith.constant 32 : index
            %6 = arith.muli %arg30, %c32_106 overflow<nsw> : index
            %7 = arith.addi %5, %6 : index
            %c49152 = arith.constant 49152 : index
            %8 = arith.muli %arg28, %c49152 overflow<nsw> : index
            %9 = arith.addi %7, %8 : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc_19 to offset: [%9], sizes: [1, 32, 32], strides: [49152, 384, 1] : memref<2x128x384xf32> to memref<1x32x32xf32, strided<[49152, 384, 1], offset: ?>>
            %c12288_108 = arith.constant 12288 : index
            %10 = arith.muli %arg29, %c12288_108 overflow<nsw> : index
            %c32_109 = arith.constant 32 : index
            %11 = arith.muli %arg30, %c32_109 overflow<nsw> : index
            %12 = arith.addi %10, %11 : index
            %c393216 = arith.constant 393216 : index
            %13 = arith.muli %arg28, %c393216 overflow<nsw> : index
            %14 = arith.addi %12, %13 : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_22 to offset: [%14], sizes: [1, 32, 32], strides: [393216, 384, 1] : memref<2x1024x384xf32> to memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>
            scf.for %arg32 = %c0 to %c1 step %c1 {
              scf.for %arg33 = %c0 to %c32 step %c1 {
                scf.for %arg34 = %c0 to %c32 step %c1 {
                  scf.for %arg35 = %c0 to %c32 step %c1 {
                    %20 = memref.load %reinterpret_cast_105[%arg32, %arg33, %arg35] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                    %21 = memref.load %reinterpret_cast_107[%arg32, %arg35, %arg34] : memref<1x32x32xf32, strided<[49152, 384, 1], offset: ?>>
                    %22 = memref.load %reinterpret_cast_110[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>
                    %23 = arith.mulf %20, %21 : f32
                    %24 = arith.addf %22, %23 : f32
                    memref.store %24, %reinterpret_cast_110[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>
                  }
                }
              }
            }
            %c12288_111 = arith.constant 12288 : index
            %15 = arith.muli %arg29, %c12288_111 overflow<nsw> : index
            %c32_112 = arith.constant 32 : index
            %16 = arith.muli %arg30, %c32_112 overflow<nsw> : index
            %17 = arith.addi %15, %16 : index
            %c393216_113 = arith.constant 393216 : index
            %18 = arith.muli %arg28, %c393216_113 overflow<nsw> : index
            %19 = arith.addi %17, %18 : index
            %reinterpret_cast_114 = memref.reinterpret_cast %alloc_22 to offset: [%19], sizes: [1, 32, 32], strides: [393216, 384, 1] : memref<2x1024x384xf32> to memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>
            scf.for %arg32 = %c0 to %c1 step %c1 {
              scf.for %arg33 = %c0 to %c32 step %c1 {
                scf.for %arg34 = %c0 to %c32 step %c1 {
                  %20 = memref.load %reinterpret_cast_110[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>
                  memref.store %20, %reinterpret_cast_114[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c12288 = arith.constant 12288 : index
            %0 = arith.muli %arg28, %c12288 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_22 to offset: [%0], sizes: [2, 32, 384], strides: [393216, 384, 1] : memref<2x1024x384xf32> to memref<2x32x384xf32, strided<[393216, 384, 1], offset: ?>>
            %c12288_105 = arith.constant 12288 : index
            %1 = arith.muli %arg28, %c12288_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_20 to offset: [%1], sizes: [2, 32, 384], strides: [393216, 384, 1] : memref<2x1024x384xf32> to memref<2x32x384xf32, strided<[393216, 384, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c384 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x384xf32, strided<[393216, 384, 1], offset: ?>>
                  %4 = memref.load %arg4[%arg31] : memref<384xf32>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x384xf32, strided<[393216, 384, 1], offset: ?>>
                }
              }
            }
            %c12288_107 = arith.constant 12288 : index
            %2 = arith.muli %arg28, %c12288_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_20 to offset: [%2], sizes: [2, 32, 384], strides: [393216, 384, 1] : memref<2x1024x384xf32> to memref<2x32x384xf32, strided<[393216, 384, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c384 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x384xf32, strided<[393216, 384, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x384xf32, strided<[393216, 384, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %reinterpret_cast = memref.reinterpret_cast %alloc_20 to offset: [128], sizes: [2, 1024, 4, 32], strides: [393216, 384, 32, 1] : memref<2x1024x384xf32> to memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 128>>
    %reinterpret_cast_23 = memref.reinterpret_cast %alloc_20 to offset: [0], sizes: [2, 1024, 4, 32], strides: [393216, 384, 32, 1] : memref<2x1024x384xf32> to memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1]>>
    %alloc_24 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x32xf32>
    %alloc_25 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x32xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c32 step %c1 {
            %0 = memref.load %reinterpret_cast_23[%arg28, %arg30, %arg29, %arg31] : memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1]>>
            memref.store %0, %alloc_25[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x32xf32>
          }
        }
      }
    }
    %reinterpret_cast_26 = memref.reinterpret_cast %alloc_20 to offset: [256], sizes: [2, 1024, 4, 32], strides: [393216, 384, 32, 1] : memref<2x1024x384xf32> to memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 256>>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c32 step %c1 {
            %0 = memref.load %reinterpret_cast_26[%arg28, %arg30, %arg29, %arg31] : memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 256>>
            memref.store %0, %alloc_24[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x32xf32>
          }
        }
      }
    }
    %alloc_27 = memref.alloc() {alignment = 64 : i64} : memref<2x4x32x1024xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c32 step %c1 {
          scf.for %arg31 = %c0 to %c1024 step %c1 {
            %0 = memref.load %reinterpret_cast[%arg28, %arg31, %arg29, %arg30] : memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 128>>
            memref.store %0, %alloc_27[%arg28, %arg29, %arg30, %arg31] : memref<2x4x32x1024xf32>
          }
        }
      }
    }
    %alloc_28 = memref.alloc() {alignment = 64 : i64} : memref<8x1024x1024xf32>
    scf.for %arg28 = %c0 to %c8 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          memref.store %cst_3, %alloc_28[%arg28, %arg29, %arg30] : memref<8x1024x1024xf32>
        }
      }
    }
    %alloc_29 = memref.alloc() {alignment = 64 : i64} : memref<8x1024x1024xf32>
    scf.for %arg28 = %c0 to %c8 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          %0 = memref.load %alloc_28[%arg28, %arg29, %arg30] : memref<8x1024x1024xf32>
          memref.store %0, %alloc_29[%arg28, %arg29, %arg30] : memref<8x1024x1024xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29, %arg30) : index = (%c0, %c0, %c0) to (%c8, %c32, %c32) step (%c1, %c1, %c1) collapse(3) {
            %c1024_104 = arith.constant 1024 : index
            %0 = arith.muli %arg29, %c1024_104 overflow<nsw> : index
            %c32768 = arith.constant 32768 : index
            %1 = arith.muli %arg28, %c32768 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_25 to offset: [%2], sizes: [1, 32, 32], strides: [32768, 32, 1] : memref<2x4x1024x32xf32> to memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
            %c32_106 = arith.constant 32 : index
            %3 = arith.muli %arg30, %c32_106 overflow<nsw> : index
            %c32768_107 = arith.constant 32768 : index
            %4 = arith.muli %arg28, %c32768_107 overflow<nsw> : index
            %5 = arith.addi %3, %4 : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_27 to offset: [%5], sizes: [1, 32, 32], strides: [32768, 1024, 1] : memref<2x4x32x1024xf32> to memref<1x32x32xf32, strided<[32768, 1024, 1], offset: ?>>
            %c32768_109 = arith.constant 32768 : index
            %6 = arith.muli %arg29, %c32768_109 overflow<nsw> : index
            %c32_110 = arith.constant 32 : index
            %7 = arith.muli %arg30, %c32_110 overflow<nsw> : index
            %8 = arith.addi %6, %7 : index
            %c1048576 = arith.constant 1048576 : index
            %9 = arith.muli %arg28, %c1048576 overflow<nsw> : index
            %10 = arith.addi %8, %9 : index
            %reinterpret_cast_111 = memref.reinterpret_cast %alloc_29 to offset: [%10], sizes: [1, 32, 32], strides: [1048576, 1024, 1] : memref<8x1024x1024xf32> to memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
            scf.for %arg31 = %c0 to %c1 step %c1 {
              scf.for %arg32 = %c0 to %c32 step %c1 {
                scf.for %arg33 = %c0 to %c32 step %c1 {
                  scf.for %arg34 = %c0 to %c32 step %c1 {
                    %16 = memref.load %reinterpret_cast_105[%arg31, %arg32, %arg34] : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
                    %17 = memref.load %reinterpret_cast_108[%arg31, %arg34, %arg33] : memref<1x32x32xf32, strided<[32768, 1024, 1], offset: ?>>
                    %18 = memref.load %reinterpret_cast_111[%arg31, %arg32, %arg33] : memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
                    %19 = arith.mulf %16, %17 : f32
                    %20 = arith.addf %18, %19 : f32
                    memref.store %20, %reinterpret_cast_111[%arg31, %arg32, %arg33] : memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
                  }
                }
              }
            }
            %c32768_112 = arith.constant 32768 : index
            %11 = arith.muli %arg29, %c32768_112 overflow<nsw> : index
            %c32_113 = arith.constant 32 : index
            %12 = arith.muli %arg30, %c32_113 overflow<nsw> : index
            %13 = arith.addi %11, %12 : index
            %c1048576_114 = arith.constant 1048576 : index
            %14 = arith.muli %arg28, %c1048576_114 overflow<nsw> : index
            %15 = arith.addi %13, %14 : index
            %reinterpret_cast_115 = memref.reinterpret_cast %alloc_29 to offset: [%15], sizes: [1, 32, 32], strides: [1048576, 1024, 1] : memref<8x1024x1024xf32> to memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
            scf.for %arg31 = %c0 to %c1 step %c1 {
              scf.for %arg32 = %c0 to %c32 step %c1 {
                scf.for %arg33 = %c0 to %c32 step %c1 {
                  %16 = memref.load %reinterpret_cast_111[%arg31, %arg32, %arg33] : memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
                  memref.store %16, %reinterpret_cast_115[%arg31, %arg32, %arg33] : memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %reinterpret_cast_30 = memref.reinterpret_cast %alloc_29 to offset: [0], sizes: [2, 4, 1024, 1024], strides: [4194304, 1048576, 1024, 1] : memref<8x1024x1024xf32> to memref<2x4x1024x1024xf32>
    %alloc_31 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x1024xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c1024 step %c1 {
            %0 = memref.load %reinterpret_cast_30[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
            %1 = arith.truncf %cst_2 : f64 to f32
            %2 = arith.mulf %0, %1 : f32
            memref.store %2, %alloc_31[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
          }
        }
      }
    }
    %alloc_32 = memref.alloc() {alignment = 64 : i64} : memref<1x1x1024x1024xi1>
    scf.for %arg28 = %c0 to %c1 step %c1 {
      scf.for %arg29 = %c0 to %c1 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c1024 step %c1 {
            %0 = memref.load %arg5[%arg28, %arg29, %arg30, %arg31] : memref<1x1x1024x1024xf32>
            %1 = arith.cmpf oeq, %0, %cst_3 : f32
            memref.store %1, %alloc_32[%arg28, %arg29, %arg30, %arg31] : memref<1x1x1024x1024xi1>
          }
        }
      }
    }
    %alloc_33 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x1024xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c1024 step %c1 {
            %0 = memref.load %alloc_32[%c0, %c0, %arg30, %arg31] : memref<1x1x1024x1024xi1>
            %1 = memref.load %alloc_31[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
            %2 = arith.select %0, %cst_4, %1 : f32
            memref.store %2, %alloc_33[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
          }
        }
      }
    }
    %alloc_34 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024xi64>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          memref.store %c0_i64, %alloc_34[%arg28, %arg29, %arg30] : memref<2x4x1024xi64>
        }
      }
    }
    %alloc_35 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          memref.store %cst_4, %alloc_35[%arg28, %arg29, %arg30] : memref<2x4x1024xf32>
        }
      }
    }
    %alloc_36 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          %0 = memref.load %alloc_35[%arg28, %arg29, %arg30] : memref<2x4x1024xf32>
          memref.store %0, %alloc_36[%arg28, %arg29, %arg30] : memref<2x4x1024xf32>
        }
      }
    }
    %alloc_37 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024xi64>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          %0 = memref.load %alloc_34[%arg28, %arg29, %arg30] : memref<2x4x1024xi64>
          memref.store %0, %alloc_37[%arg28, %arg29, %arg30] : memref<2x4x1024xi64>
        }
      }
    }
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c1024 step %c1 {
            %0 = memref.load %alloc_33[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
            %1 = memref.load %alloc_36[%arg28, %arg29, %arg30] : memref<2x4x1024xf32>
            %2 = memref.load %alloc_37[%arg28, %arg29, %arg30] : memref<2x4x1024xi64>
            %3 = arith.index_cast %arg31 : index to i64
            %4 = arith.maximumf %0, %1 : f32
            %5 = arith.cmpf ogt, %0, %1 : f32
            %6 = arith.select %5, %3, %2 : i64
            memref.store %4, %alloc_36[%arg28, %arg29, %arg30] : memref<2x4x1024xf32>
            memref.store %6, %alloc_37[%arg28, %arg29, %arg30] : memref<2x4x1024xi64>
          }
        }
      }
    }
    %reinterpret_cast_38 = memref.reinterpret_cast %alloc_36 to offset: [0], sizes: [2, 4, 1024, 1], strides: [4096, 1024, 1, 1] : memref<2x4x1024xf32> to memref<2x4x1024x1xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c1024 step %c1 {
            %0 = memref.load %alloc_33[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
            %1 = memref.load %reinterpret_cast_38[%arg28, %arg29, %arg30, %c0] : memref<2x4x1024x1xf32>
            %2 = arith.subf %0, %1 : f32
            memref.store %2, %alloc_31[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
          }
        }
      }
    }
    %alloc_39 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x1024xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c1024 step %c1 {
            %0 = memref.load %alloc_31[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
            %1 = math.exp %0 : f32
            memref.store %1, %alloc_39[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
          }
        }
      }
    }
    %alloc_40 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x1xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c1 step %c1 {
            memref.store %cst_3, %alloc_40[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1xf32>
          }
        }
      }
    }
    %alloc_41 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x1xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c1 step %c1 {
            %0 = memref.load %alloc_40[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1xf32>
            memref.store %0, %alloc_41[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1xf32>
          }
        }
      }
    }
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c1024 step %c1 {
            %0 = memref.load %alloc_39[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
            %1 = memref.load %alloc_41[%arg28, %arg29, %arg30, %c0] : memref<2x4x1024x1xf32>
            %2 = arith.addf %0, %1 : f32
            memref.store %2, %alloc_41[%arg28, %arg29, %arg30, %c0] : memref<2x4x1024x1xf32>
          }
        }
      }
    }
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c1024 step %c1 {
            %0 = memref.load %alloc_39[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
            %1 = memref.load %alloc_41[%arg28, %arg29, %arg30, %c0] : memref<2x4x1024x1xf32>
            %2 = arith.divf %0, %1 : f32
            memref.store %2, %alloc_31[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
          }
        }
      }
    }
    %alloc_42 = memref.alloc() {alignment = 64 : i64} : memref<8x1024x32xf32>
    scf.for %arg28 = %c0 to %c8 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c32 step %c1 {
          memref.store %cst_3, %alloc_42[%arg28, %arg29, %arg30] : memref<8x1024x32xf32>
        }
      }
    }
    %alloc_43 = memref.alloc() {alignment = 64 : i64} : memref<8x1024x32xf32>
    scf.for %arg28 = %c0 to %c8 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c32 step %c1 {
          %0 = memref.load %alloc_42[%arg28, %arg29, %arg30] : memref<8x1024x32xf32>
          memref.store %0, %alloc_43[%arg28, %arg29, %arg30] : memref<8x1024x32xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29, %arg30) : index = (%c0, %c0, %c0) to (%c8, %c32, %c32) step (%c1, %c1, %c1) collapse(3) {
            %c32768 = arith.constant 32768 : index
            %0 = arith.muli %arg29, %c32768 overflow<nsw> : index
            %c32_104 = arith.constant 32 : index
            %1 = arith.muli %arg30, %c32_104 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %c1048576 = arith.constant 1048576 : index
            %3 = arith.muli %arg28, %c1048576 overflow<nsw> : index
            %4 = arith.addi %2, %3 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_31 to offset: [%4], sizes: [1, 32, 32], strides: [1048576, 1024, 1] : memref<2x4x1024x1024xf32> to memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
            %c1024_106 = arith.constant 1024 : index
            %5 = arith.muli %arg30, %c1024_106 overflow<nsw> : index
            %c32768_107 = arith.constant 32768 : index
            %6 = arith.muli %arg28, %c32768_107 overflow<nsw> : index
            %7 = arith.addi %5, %6 : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_24 to offset: [%7], sizes: [1, 32, 32], strides: [32768, 32, 1] : memref<2x4x1024x32xf32> to memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
            %c1024_109 = arith.constant 1024 : index
            %8 = arith.muli %arg29, %c1024_109 overflow<nsw> : index
            %c32768_110 = arith.constant 32768 : index
            %9 = arith.muli %arg28, %c32768_110 overflow<nsw> : index
            %10 = arith.addi %8, %9 : index
            %reinterpret_cast_111 = memref.reinterpret_cast %alloc_43 to offset: [%10], sizes: [1, 32, 32], strides: [32768, 32, 1] : memref<8x1024x32xf32> to memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
            scf.for %arg31 = %c0 to %c1 step %c1 {
              scf.for %arg32 = %c0 to %c32 step %c1 {
                scf.for %arg33 = %c0 to %c32 step %c1 {
                  scf.for %arg34 = %c0 to %c32 step %c1 {
                    %14 = memref.load %reinterpret_cast_105[%arg31, %arg32, %arg34] : memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
                    %15 = memref.load %reinterpret_cast_108[%arg31, %arg34, %arg33] : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
                    %16 = memref.load %reinterpret_cast_111[%arg31, %arg32, %arg33] : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
                    %17 = arith.mulf %14, %15 : f32
                    %18 = arith.addf %16, %17 : f32
                    memref.store %18, %reinterpret_cast_111[%arg31, %arg32, %arg33] : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
                  }
                }
              }
            }
            %c1024_112 = arith.constant 1024 : index
            %11 = arith.muli %arg29, %c1024_112 overflow<nsw> : index
            %c32768_113 = arith.constant 32768 : index
            %12 = arith.muli %arg28, %c32768_113 overflow<nsw> : index
            %13 = arith.addi %11, %12 : index
            %reinterpret_cast_114 = memref.reinterpret_cast %alloc_43 to offset: [%13], sizes: [1, 32, 32], strides: [32768, 32, 1] : memref<8x1024x32xf32> to memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
            scf.for %arg31 = %c0 to %c1 step %c1 {
              scf.for %arg32 = %c0 to %c32 step %c1 {
                scf.for %arg33 = %c0 to %c32 step %c1 {
                  %14 = memref.load %reinterpret_cast_111[%arg31, %arg32, %arg33] : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
                  memref.store %14, %reinterpret_cast_114[%arg31, %arg32, %arg33] : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_44 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x4x32xf32>
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c1024_104 = arith.constant 1024 : index
            %0 = arith.muli %arg28, %c1024_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_43 to offset: [%0], sizes: [2, 4, 32, 32], strides: [131072, 32768, 32, 1] : memref<8x1024x32xf32> to memref<2x4x32x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>
            %c4096 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_44 to offset: [%1], sizes: [2, 32, 4, 32], strides: [131072, 128, 32, 1] : memref<2x1024x4x32xf32> to memref<2x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c4 step %c1 {
                  scf.for %arg32 = %c0 to %c32 step %c1 {
                    %3 = memref.load %reinterpret_cast_105[%arg29, %arg31, %arg30, %arg32] : memref<2x4x32x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>
                    memref.store %3, %reinterpret_cast_106[%arg29, %arg30, %arg31, %arg32] : memref<2x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>
                  }
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_44 to offset: [%2], sizes: [2, 32, 4, 32], strides: [131072, 128, 32, 1] : memref<2x1024x4x32xf32> to memref<2x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c4 step %c1 {
                  scf.for %arg32 = %c0 to %c32 step %c1 {
                    %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31, %arg32] : memref<2x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>
                    memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31, %arg32] : memref<2x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>
                  }
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_45 = memref.alloc() {alignment = 64 : i64} : memref<128x128xf32>
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29) : index = (%c0, %c0) to (%c4, %c4) step (%c1, %c1) collapse(2) {
            %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %arg6 : memref<128x128xf32> -> memref<f32>, index, index, index, index, index
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg29, %c4096 overflow<nsw> : index
            %c32_104 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %base_buffer to offset: [%2], sizes: [32, 32], strides: [128, 1] : memref<f32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
            %c4096_106 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096_106 overflow<nsw> : index
            %c32_107 = arith.constant 32 : index
            %4 = arith.muli %arg29, %c32_107 overflow<nsw> : index
            %5 = arith.addi %3, %4 : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_45 to offset: [%5], sizes: [32, 32], strides: [128, 1] : memref<128x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
            scf.for %arg30 = %c0 to %c32 step %c1 {
              scf.for %arg31 = %c0 to %c32 step %c1 {
                %9 = memref.load %reinterpret_cast_105[%arg31, %arg30] : memref<32x32xf32, strided<[128, 1], offset: ?>>
                memref.store %9, %reinterpret_cast_108[%arg30, %arg31] : memref<32x32xf32, strided<[128, 1], offset: ?>>
              }
            }
            %c4096_109 = arith.constant 4096 : index
            %6 = arith.muli %arg28, %c4096_109 overflow<nsw> : index
            %c32_110 = arith.constant 32 : index
            %7 = arith.muli %arg29, %c32_110 overflow<nsw> : index
            %8 = arith.addi %6, %7 : index
            %reinterpret_cast_111 = memref.reinterpret_cast %alloc_45 to offset: [%8], sizes: [32, 32], strides: [128, 1] : memref<128x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
            scf.for %arg30 = %c0 to %c32 step %c1 {
              scf.for %arg31 = %c0 to %c32 step %c1 {
                %9 = memref.load %reinterpret_cast_108[%arg30, %arg31] : memref<32x32xf32, strided<[128, 1], offset: ?>>
                memref.store %9, %reinterpret_cast_111[%arg30, %arg31] : memref<32x32xf32, strided<[128, 1], offset: ?>>
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_46 = memref.alloc() {alignment = 64 : i64} : memref<2x128x128xf32>
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c4) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_45 to offset: [%0], sizes: [32, 128], strides: [128, 1] : memref<128x128xf32> to memref<32x128xf32, strided<[128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_46 to offset: [%1], sizes: [2, 32, 128], strides: [16384, 128, 1] : memref<2x128x128xf32> to memref<2x32x128xf32, strided<[16384, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg30, %arg31] : memref<32x128xf32, strided<[128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[16384, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_46 to offset: [%2], sizes: [2, 32, 128], strides: [16384, 128, 1] : memref<2x128x128xf32> to memref<2x32x128xf32, strided<[16384, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[16384, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[16384, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_47 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          memref.store %cst_3, %alloc_47[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    %alloc_48 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %alloc_47[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_48[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29, %arg30, %arg31) : index = (%c0, %c0, %c0, %c0) to (%c2, %c32, %c4, %c4) step (%c1, %c1, %c1, %c1) collapse(4) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg29, %c4096 overflow<nsw> : index
            %c32_104 = arith.constant 32 : index
            %1 = arith.muli %arg31, %c32_104 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %c131072 = arith.constant 131072 : index
            %3 = arith.muli %arg28, %c131072 overflow<nsw> : index
            %4 = arith.addi %2, %3 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_44 to offset: [%4], sizes: [1, 32, 32], strides: [131072, 128, 1] : memref<2x1024x4x32xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_106 = arith.constant 4096 : index
            %5 = arith.muli %arg31, %c4096_106 overflow<nsw> : index
            %c32_107 = arith.constant 32 : index
            %6 = arith.muli %arg30, %c32_107 overflow<nsw> : index
            %7 = arith.addi %5, %6 : index
            %c16384 = arith.constant 16384 : index
            %8 = arith.muli %arg28, %c16384 overflow<nsw> : index
            %9 = arith.addi %7, %8 : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_46 to offset: [%9], sizes: [1, 32, 32], strides: [16384, 128, 1] : memref<2x128x128xf32> to memref<1x32x32xf32, strided<[16384, 128, 1], offset: ?>>
            %c4096_109 = arith.constant 4096 : index
            %10 = arith.muli %arg29, %c4096_109 overflow<nsw> : index
            %c32_110 = arith.constant 32 : index
            %11 = arith.muli %arg30, %c32_110 overflow<nsw> : index
            %12 = arith.addi %10, %11 : index
            %c131072_111 = arith.constant 131072 : index
            %13 = arith.muli %arg28, %c131072_111 overflow<nsw> : index
            %14 = arith.addi %12, %13 : index
            %reinterpret_cast_112 = memref.reinterpret_cast %alloc_48 to offset: [%14], sizes: [1, 32, 32], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg32 = %c0 to %c1 step %c1 {
              scf.for %arg33 = %c0 to %c32 step %c1 {
                scf.for %arg34 = %c0 to %c32 step %c1 {
                  scf.for %arg35 = %c0 to %c32 step %c1 {
                    %20 = memref.load %reinterpret_cast_105[%arg32, %arg33, %arg35] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                    %21 = memref.load %reinterpret_cast_108[%arg32, %arg35, %arg34] : memref<1x32x32xf32, strided<[16384, 128, 1], offset: ?>>
                    %22 = memref.load %reinterpret_cast_112[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                    %23 = arith.mulf %20, %21 : f32
                    %24 = arith.addf %22, %23 : f32
                    memref.store %24, %reinterpret_cast_112[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                  }
                }
              }
            }
            %c4096_113 = arith.constant 4096 : index
            %15 = arith.muli %arg29, %c4096_113 overflow<nsw> : index
            %c32_114 = arith.constant 32 : index
            %16 = arith.muli %arg30, %c32_114 overflow<nsw> : index
            %17 = arith.addi %15, %16 : index
            %c131072_115 = arith.constant 131072 : index
            %18 = arith.muli %arg28, %c131072_115 overflow<nsw> : index
            %19 = arith.addi %17, %18 : index
            %reinterpret_cast_116 = memref.reinterpret_cast %alloc_48 to offset: [%19], sizes: [1, 32, 32], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg32 = %c0 to %c1 step %c1 {
              scf.for %arg33 = %c0 to %c32 step %c1 {
                scf.for %arg34 = %c0 to %c32 step %c1 {
                  %20 = memref.load %reinterpret_cast_112[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %20, %reinterpret_cast_116[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_49 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_49[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_48 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_49 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %arg7[%arg31] : memref<128xf32>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_49 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_50 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_50[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %base_buffer, %offset, %sizes:3, %strides:3 = memref.extract_strided_metadata %arg2 : memref<2x1024x128xf32> -> memref<f32>, index, index, index, index, index, index, index
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %base_buffer to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<f32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_49 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_50 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %5 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %6 = arith.addf %4, %5 : f32
                  memref.store %6, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_109 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096_109 overflow<nsw> : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_50 to offset: [%3], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %4, %reinterpret_cast_110[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_51 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c1 step %c1 {
          %0 = memref.load %alloc_7[%arg28, %arg29, %arg30] : memref<2x1024x1xf32>
          memref.store %0, %alloc_51[%arg28, %arg29, %arg30] : memref<2x1024x1xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_50 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c32_105 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_51 to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %reinterpret_cast_106[%arg29, %arg30, %c0] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %c0] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_107 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_51 to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_51 to offset: [%0], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            %c32_106 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_106 overflow<nsw> : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %4 = arith.divf %3, %cst_0 : f32
                  memref.store %4, %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_108 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_108 overflow<nsw> : index
            %reinterpret_cast_109 = memref.reinterpret_cast %alloc to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_109[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_52 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_52[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc to offset: [%0], sizes: [2, 32], strides: [1024, 1] : memref<2x1024x1xf32> to memref<2x32xf32, strided<[1024, 1], offset: ?>>
            %c4096 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_52 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30] : memref<2x32xf32, strided<[1024, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_52 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_53 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_53[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_50 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_52 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_53 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %5 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %6 = arith.subf %4, %5 : f32
                  memref.store %6, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_109 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096_109 overflow<nsw> : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_53 to offset: [%3], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %4, %reinterpret_cast_110[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_54 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_54[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_53 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_53 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_54 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %5 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %6 = arith.mulf %4, %5 : f32
                  memref.store %6, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_109 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096_109 overflow<nsw> : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_54 to offset: [%3], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %4, %reinterpret_cast_110[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_55 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c1 step %c1 {
          %0 = memref.load %alloc_7[%arg28, %arg29, %arg30] : memref<2x1024x1xf32>
          memref.store %0, %alloc_55[%arg28, %arg29, %arg30] : memref<2x1024x1xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_54 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c32_105 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_55 to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %reinterpret_cast_106[%arg29, %arg30, %c0] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %c0] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_107 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_55 to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_55 to offset: [%0], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            %c32_106 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_106 overflow<nsw> : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %4 = arith.divf %3, %cst_0 : f32
                  memref.store %4, %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_108 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_108 overflow<nsw> : index
            %reinterpret_cast_109 = memref.reinterpret_cast %alloc to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_109[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_56 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc to offset: [%0], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            %c32_106 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_106 overflow<nsw> : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc_56 to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %4 = arith.truncf %cst_1 : f64 to f32
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_108 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_108 overflow<nsw> : index
            %reinterpret_cast_109 = memref.reinterpret_cast %alloc_56 to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_109[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_56 to offset: [%0], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            %c32_106 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_106 overflow<nsw> : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %4 = math.rsqrt %3 : f32
                  memref.store %4, %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_108 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_108 overflow<nsw> : index
            %reinterpret_cast_109 = memref.reinterpret_cast %alloc to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_109[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_57 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_57[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc to offset: [%0], sizes: [2, 32], strides: [1024, 1] : memref<2x1024x1xf32> to memref<2x32xf32, strided<[1024, 1], offset: ?>>
            %c4096 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_57 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30] : memref<2x32xf32, strided<[1024, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_57 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_58 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_58[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_53 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_57 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_58 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %5 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %6 = arith.mulf %4, %5 : f32
                  memref.store %6, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_109 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096_109 overflow<nsw> : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_58 to offset: [%3], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %4, %reinterpret_cast_110[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_59 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_59[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_58 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_59 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %arg8[%arg31] : memref<128xf32>
                  %5 = arith.mulf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_59 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_60 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_60[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_59 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_60 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %arg9[%arg31] : memref<128xf32>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_60 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_61 = memref.alloc() {alignment = 64 : i64} : memref<128x512xf32>
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29) : index = (%c0, %c0) to (%c4, %c16) step (%c1, %c1) collapse(2) {
            %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %arg10 : memref<512x128xf32> -> memref<f32>, index, index, index, index, index
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg29, %c4096 overflow<nsw> : index
            %c32_104 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %base_buffer to offset: [%2], sizes: [32, 32], strides: [128, 1] : memref<f32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
            %c16384 = arith.constant 16384 : index
            %3 = arith.muli %arg28, %c16384 overflow<nsw> : index
            %c32_106 = arith.constant 32 : index
            %4 = arith.muli %arg29, %c32_106 overflow<nsw> : index
            %5 = arith.addi %3, %4 : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc_61 to offset: [%5], sizes: [32, 32], strides: [512, 1] : memref<128x512xf32> to memref<32x32xf32, strided<[512, 1], offset: ?>>
            scf.for %arg30 = %c0 to %c32 step %c1 {
              scf.for %arg31 = %c0 to %c32 step %c1 {
                %9 = memref.load %reinterpret_cast_105[%arg31, %arg30] : memref<32x32xf32, strided<[128, 1], offset: ?>>
                memref.store %9, %reinterpret_cast_107[%arg30, %arg31] : memref<32x32xf32, strided<[512, 1], offset: ?>>
              }
            }
            %c16384_108 = arith.constant 16384 : index
            %6 = arith.muli %arg28, %c16384_108 overflow<nsw> : index
            %c32_109 = arith.constant 32 : index
            %7 = arith.muli %arg29, %c32_109 overflow<nsw> : index
            %8 = arith.addi %6, %7 : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_61 to offset: [%8], sizes: [32, 32], strides: [512, 1] : memref<128x512xf32> to memref<32x32xf32, strided<[512, 1], offset: ?>>
            scf.for %arg30 = %c0 to %c32 step %c1 {
              scf.for %arg31 = %c0 to %c32 step %c1 {
                %9 = memref.load %reinterpret_cast_107[%arg30, %arg31] : memref<32x32xf32, strided<[512, 1], offset: ?>>
                memref.store %9, %reinterpret_cast_110[%arg30, %arg31] : memref<32x32xf32, strided<[512, 1], offset: ?>>
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_62 = memref.alloc() {alignment = 64 : i64} : memref<2x128x512xf32>
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c4) step (%c1) {
            %c16384 = arith.constant 16384 : index
            %0 = arith.muli %arg28, %c16384 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_61 to offset: [%0], sizes: [32, 512], strides: [512, 1] : memref<128x512xf32> to memref<32x512xf32, strided<[512, 1], offset: ?>>
            %c16384_105 = arith.constant 16384 : index
            %1 = arith.muli %arg28, %c16384_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_62 to offset: [%1], sizes: [2, 32, 512], strides: [65536, 512, 1] : memref<2x128x512xf32> to memref<2x32x512xf32, strided<[65536, 512, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c512 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg30, %arg31] : memref<32x512xf32, strided<[512, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[65536, 512, 1], offset: ?>>
                }
              }
            }
            %c16384_107 = arith.constant 16384 : index
            %2 = arith.muli %arg28, %c16384_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_62 to offset: [%2], sizes: [2, 32, 512], strides: [65536, 512, 1] : memref<2x128x512xf32> to memref<2x32x512xf32, strided<[65536, 512, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c512 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[65536, 512, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[65536, 512, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_63 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x512xf32>
    %alloc_64 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x512xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c512 step %c1 {
          memref.store %cst_3, %alloc_64[%arg28, %arg29, %arg30] : memref<2x1024x512xf32>
        }
      }
    }
    %alloc_65 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x512xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c512 step %c1 {
          %0 = memref.load %alloc_64[%arg28, %arg29, %arg30] : memref<2x1024x512xf32>
          memref.store %0, %alloc_65[%arg28, %arg29, %arg30] : memref<2x1024x512xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29, %arg30, %arg31) : index = (%c0, %c0, %c0, %c0) to (%c2, %c32, %c16, %c4) step (%c1, %c1, %c1, %c1) collapse(4) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg29, %c4096 overflow<nsw> : index
            %c32_104 = arith.constant 32 : index
            %1 = arith.muli %arg31, %c32_104 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %c131072 = arith.constant 131072 : index
            %3 = arith.muli %arg28, %c131072 overflow<nsw> : index
            %4 = arith.addi %2, %3 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_60 to offset: [%4], sizes: [1, 32, 32], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
            %c16384 = arith.constant 16384 : index
            %5 = arith.muli %arg31, %c16384 overflow<nsw> : index
            %c32_106 = arith.constant 32 : index
            %6 = arith.muli %arg30, %c32_106 overflow<nsw> : index
            %7 = arith.addi %5, %6 : index
            %c65536 = arith.constant 65536 : index
            %8 = arith.muli %arg28, %c65536 overflow<nsw> : index
            %9 = arith.addi %7, %8 : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc_62 to offset: [%9], sizes: [1, 32, 32], strides: [65536, 512, 1] : memref<2x128x512xf32> to memref<1x32x32xf32, strided<[65536, 512, 1], offset: ?>>
            %c16384_108 = arith.constant 16384 : index
            %10 = arith.muli %arg29, %c16384_108 overflow<nsw> : index
            %c32_109 = arith.constant 32 : index
            %11 = arith.muli %arg30, %c32_109 overflow<nsw> : index
            %12 = arith.addi %10, %11 : index
            %c524288 = arith.constant 524288 : index
            %13 = arith.muli %arg28, %c524288 overflow<nsw> : index
            %14 = arith.addi %12, %13 : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_65 to offset: [%14], sizes: [1, 32, 32], strides: [524288, 512, 1] : memref<2x1024x512xf32> to memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
            scf.for %arg32 = %c0 to %c1 step %c1 {
              scf.for %arg33 = %c0 to %c32 step %c1 {
                scf.for %arg34 = %c0 to %c32 step %c1 {
                  scf.for %arg35 = %c0 to %c32 step %c1 {
                    %20 = memref.load %reinterpret_cast_105[%arg32, %arg33, %arg35] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                    %21 = memref.load %reinterpret_cast_107[%arg32, %arg35, %arg34] : memref<1x32x32xf32, strided<[65536, 512, 1], offset: ?>>
                    %22 = memref.load %reinterpret_cast_110[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
                    %23 = arith.mulf %20, %21 : f32
                    %24 = arith.addf %22, %23 : f32
                    memref.store %24, %reinterpret_cast_110[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
                  }
                }
              }
            }
            %c16384_111 = arith.constant 16384 : index
            %15 = arith.muli %arg29, %c16384_111 overflow<nsw> : index
            %c32_112 = arith.constant 32 : index
            %16 = arith.muli %arg30, %c32_112 overflow<nsw> : index
            %17 = arith.addi %15, %16 : index
            %c524288_113 = arith.constant 524288 : index
            %18 = arith.muli %arg28, %c524288_113 overflow<nsw> : index
            %19 = arith.addi %17, %18 : index
            %reinterpret_cast_114 = memref.reinterpret_cast %alloc_65 to offset: [%19], sizes: [1, 32, 32], strides: [524288, 512, 1] : memref<2x1024x512xf32> to memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
            scf.for %arg32 = %c0 to %c1 step %c1 {
              scf.for %arg33 = %c0 to %c32 step %c1 {
                scf.for %arg34 = %c0 to %c32 step %c1 {
                  %20 = memref.load %reinterpret_cast_110[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
                  memref.store %20, %reinterpret_cast_114[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_66 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x512xf32>
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c16384 = arith.constant 16384 : index
            %0 = arith.muli %arg28, %c16384 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_65 to offset: [%0], sizes: [2, 32, 512], strides: [524288, 512, 1] : memref<2x1024x512xf32> to memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
            %c16384_105 = arith.constant 16384 : index
            %1 = arith.muli %arg28, %c16384_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_66 to offset: [%1], sizes: [2, 32, 512], strides: [524288, 512, 1] : memref<2x1024x512xf32> to memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c512 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
                  %4 = memref.load %arg11[%arg31] : memref<512xf32>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
                }
              }
            }
            %c16384_107 = arith.constant 16384 : index
            %2 = arith.muli %arg28, %c16384_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_66 to offset: [%2], sizes: [2, 32, 512], strides: [524288, 512, 1] : memref<2x1024x512xf32> to memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c512 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c16384 = arith.constant 16384 : index
            %0 = arith.muli %arg28, %c16384 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_66 to offset: [%0], sizes: [2, 32, 512], strides: [524288, 512, 1] : memref<2x1024x512xf32> to memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
            %c16384_105 = arith.constant 16384 : index
            %1 = arith.muli %arg28, %c16384_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_63 to offset: [%1], sizes: [2, 32, 512], strides: [524288, 512, 1] : memref<2x1024x512xf32> to memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c512 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
                  %4 = arith.divf %3, %cst : f32
                  %5 = math.erf %4 : f32
                  %6 = arith.addf %5, %cst_5 : f32
                  %7 = arith.mulf %6, %cst_6 : f32
                  %8 = arith.mulf %3, %7 : f32
                  memref.store %8, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
                }
              }
            }
            %c16384_107 = arith.constant 16384 : index
            %2 = arith.muli %arg28, %c16384_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_63 to offset: [%2], sizes: [2, 32, 512], strides: [524288, 512, 1] : memref<2x1024x512xf32> to memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c512 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_67 = memref.alloc() {alignment = 64 : i64} : memref<512x128xf32>
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29) : index = (%c0, %c0) to (%c16, %c4) step (%c1, %c1) collapse(2) {
            %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %arg12 : memref<128x512xf32> -> memref<f32>, index, index, index, index, index
            %c16384 = arith.constant 16384 : index
            %0 = arith.muli %arg29, %c16384 overflow<nsw> : index
            %c32_104 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %base_buffer to offset: [%2], sizes: [32, 32], strides: [512, 1] : memref<f32> to memref<32x32xf32, strided<[512, 1], offset: ?>>
            %c4096 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %c32_106 = arith.constant 32 : index
            %4 = arith.muli %arg29, %c32_106 overflow<nsw> : index
            %5 = arith.addi %3, %4 : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc_67 to offset: [%5], sizes: [32, 32], strides: [128, 1] : memref<512x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
            scf.for %arg30 = %c0 to %c32 step %c1 {
              scf.for %arg31 = %c0 to %c32 step %c1 {
                %9 = memref.load %reinterpret_cast_105[%arg31, %arg30] : memref<32x32xf32, strided<[512, 1], offset: ?>>
                memref.store %9, %reinterpret_cast_107[%arg30, %arg31] : memref<32x32xf32, strided<[128, 1], offset: ?>>
              }
            }
            %c4096_108 = arith.constant 4096 : index
            %6 = arith.muli %arg28, %c4096_108 overflow<nsw> : index
            %c32_109 = arith.constant 32 : index
            %7 = arith.muli %arg29, %c32_109 overflow<nsw> : index
            %8 = arith.addi %6, %7 : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_67 to offset: [%8], sizes: [32, 32], strides: [128, 1] : memref<512x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
            scf.for %arg30 = %c0 to %c32 step %c1 {
              scf.for %arg31 = %c0 to %c32 step %c1 {
                %9 = memref.load %reinterpret_cast_107[%arg30, %arg31] : memref<32x32xf32, strided<[128, 1], offset: ?>>
                memref.store %9, %reinterpret_cast_110[%arg30, %arg31] : memref<32x32xf32, strided<[128, 1], offset: ?>>
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_68 = memref.alloc() {alignment = 64 : i64} : memref<2x512x128xf32>
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c16) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_67 to offset: [%0], sizes: [32, 128], strides: [128, 1] : memref<512x128xf32> to memref<32x128xf32, strided<[128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_68 to offset: [%1], sizes: [2, 32, 128], strides: [65536, 128, 1] : memref<2x512x128xf32> to memref<2x32x128xf32, strided<[65536, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg30, %arg31] : memref<32x128xf32, strided<[128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[65536, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_68 to offset: [%2], sizes: [2, 32, 128], strides: [65536, 128, 1] : memref<2x512x128xf32> to memref<2x32x128xf32, strided<[65536, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[65536, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[65536, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_69 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %alloc_47[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_69[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29, %arg30, %arg31) : index = (%c0, %c0, %c0, %c0) to (%c2, %c32, %c4, %c16) step (%c1, %c1, %c1, %c1) collapse(4) {
            %c16384 = arith.constant 16384 : index
            %0 = arith.muli %arg29, %c16384 overflow<nsw> : index
            %c32_104 = arith.constant 32 : index
            %1 = arith.muli %arg31, %c32_104 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %c524288 = arith.constant 524288 : index
            %3 = arith.muli %arg28, %c524288 overflow<nsw> : index
            %4 = arith.addi %2, %3 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_63 to offset: [%4], sizes: [1, 32, 32], strides: [524288, 512, 1] : memref<2x1024x512xf32> to memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
            %c4096 = arith.constant 4096 : index
            %5 = arith.muli %arg31, %c4096 overflow<nsw> : index
            %c32_106 = arith.constant 32 : index
            %6 = arith.muli %arg30, %c32_106 overflow<nsw> : index
            %7 = arith.addi %5, %6 : index
            %c65536 = arith.constant 65536 : index
            %8 = arith.muli %arg28, %c65536 overflow<nsw> : index
            %9 = arith.addi %7, %8 : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc_68 to offset: [%9], sizes: [1, 32, 32], strides: [65536, 128, 1] : memref<2x512x128xf32> to memref<1x32x32xf32, strided<[65536, 128, 1], offset: ?>>
            %c4096_108 = arith.constant 4096 : index
            %10 = arith.muli %arg29, %c4096_108 overflow<nsw> : index
            %c32_109 = arith.constant 32 : index
            %11 = arith.muli %arg30, %c32_109 overflow<nsw> : index
            %12 = arith.addi %10, %11 : index
            %c131072 = arith.constant 131072 : index
            %13 = arith.muli %arg28, %c131072 overflow<nsw> : index
            %14 = arith.addi %12, %13 : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_69 to offset: [%14], sizes: [1, 32, 32], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg32 = %c0 to %c1 step %c1 {
              scf.for %arg33 = %c0 to %c32 step %c1 {
                scf.for %arg34 = %c0 to %c32 step %c1 {
                  scf.for %arg35 = %c0 to %c32 step %c1 {
                    %20 = memref.load %reinterpret_cast_105[%arg32, %arg33, %arg35] : memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
                    %21 = memref.load %reinterpret_cast_107[%arg32, %arg35, %arg34] : memref<1x32x32xf32, strided<[65536, 128, 1], offset: ?>>
                    %22 = memref.load %reinterpret_cast_110[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                    %23 = arith.mulf %20, %21 : f32
                    %24 = arith.addf %22, %23 : f32
                    memref.store %24, %reinterpret_cast_110[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                  }
                }
              }
            }
            %c4096_111 = arith.constant 4096 : index
            %15 = arith.muli %arg29, %c4096_111 overflow<nsw> : index
            %c32_112 = arith.constant 32 : index
            %16 = arith.muli %arg30, %c32_112 overflow<nsw> : index
            %17 = arith.addi %15, %16 : index
            %c131072_113 = arith.constant 131072 : index
            %18 = arith.muli %arg28, %c131072_113 overflow<nsw> : index
            %19 = arith.addi %17, %18 : index
            %reinterpret_cast_114 = memref.reinterpret_cast %alloc_69 to offset: [%19], sizes: [1, 32, 32], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg32 = %c0 to %c1 step %c1 {
              scf.for %arg33 = %c0 to %c32 step %c1 {
                scf.for %arg34 = %c0 to %c32 step %c1 {
                  %20 = memref.load %reinterpret_cast_110[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %20, %reinterpret_cast_114[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_70 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_70[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_69 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_70 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %arg13[%arg31] : memref<128xf32>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_70 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_71 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_71[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_50 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_70 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_71 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %5 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %6 = arith.addf %4, %5 : f32
                  memref.store %6, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_109 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096_109 overflow<nsw> : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_71 to offset: [%3], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %4, %reinterpret_cast_110[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_72 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c1 step %c1 {
          %0 = memref.load %alloc_7[%arg28, %arg29, %arg30] : memref<2x1024x1xf32>
          memref.store %0, %alloc_72[%arg28, %arg29, %arg30] : memref<2x1024x1xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_71 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c32_105 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_72 to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %reinterpret_cast_106[%arg29, %arg30, %c0] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %c0] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_107 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_72 to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_72 to offset: [%0], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            %c32_106 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_106 overflow<nsw> : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %4 = arith.divf %3, %cst_0 : f32
                  memref.store %4, %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_108 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_108 overflow<nsw> : index
            %reinterpret_cast_109 = memref.reinterpret_cast %alloc to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_109[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_73 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_73[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc to offset: [%0], sizes: [2, 32], strides: [1024, 1] : memref<2x1024x1xf32> to memref<2x32xf32, strided<[1024, 1], offset: ?>>
            %c4096 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_73 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30] : memref<2x32xf32, strided<[1024, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_73 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_74 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_74[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_71 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_73 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_74 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %5 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %6 = arith.subf %4, %5 : f32
                  memref.store %6, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_109 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096_109 overflow<nsw> : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_74 to offset: [%3], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %4, %reinterpret_cast_110[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_75 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_75[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_74 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_74 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_75 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %5 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %6 = arith.mulf %4, %5 : f32
                  memref.store %6, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_109 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096_109 overflow<nsw> : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_75 to offset: [%3], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %4, %reinterpret_cast_110[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_76 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c1 step %c1 {
          %0 = memref.load %alloc_7[%arg28, %arg29, %arg30] : memref<2x1024x1xf32>
          memref.store %0, %alloc_76[%arg28, %arg29, %arg30] : memref<2x1024x1xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_75 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c32_105 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_76 to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %reinterpret_cast_106[%arg29, %arg30, %c0] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %c0] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_107 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_76 to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_76 to offset: [%0], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            %c32_106 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_106 overflow<nsw> : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %4 = arith.divf %3, %cst_0 : f32
                  memref.store %4, %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_108 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_108 overflow<nsw> : index
            %reinterpret_cast_109 = memref.reinterpret_cast %alloc to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_109[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_77 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc to offset: [%0], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            %c32_106 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_106 overflow<nsw> : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc_77 to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %4 = arith.truncf %cst_1 : f64 to f32
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_108 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_108 overflow<nsw> : index
            %reinterpret_cast_109 = memref.reinterpret_cast %alloc_77 to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_109[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_77 to offset: [%0], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            %c32_106 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_106 overflow<nsw> : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %4 = math.rsqrt %3 : f32
                  memref.store %4, %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_108 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_108 overflow<nsw> : index
            %reinterpret_cast_109 = memref.reinterpret_cast %alloc to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_109[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_78 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_78[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc to offset: [%0], sizes: [2, 32], strides: [1024, 1] : memref<2x1024x1xf32> to memref<2x32xf32, strided<[1024, 1], offset: ?>>
            %c4096 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_78 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30] : memref<2x32xf32, strided<[1024, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_78 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_79 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_79[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_74 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_78 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_79 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %5 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %6 = arith.mulf %4, %5 : f32
                  memref.store %6, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_109 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096_109 overflow<nsw> : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_79 to offset: [%3], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %4, %reinterpret_cast_110[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_80 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_80[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_79 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_80 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %arg14[%arg31] : memref<128xf32>
                  %5 = arith.mulf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_80 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_81 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_81[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_80 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_81 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %arg15[%arg31] : memref<128xf32>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_81 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29) : index = (%c0, %c0) to (%c4, %c12) step (%c1, %c1) collapse(2) {
            %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %arg16 : memref<384x128xf32> -> memref<f32>, index, index, index, index, index
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg29, %c4096 overflow<nsw> : index
            %c32_104 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %base_buffer to offset: [%2], sizes: [32, 32], strides: [128, 1] : memref<f32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
            %c12288 = arith.constant 12288 : index
            %3 = arith.muli %arg28, %c12288 overflow<nsw> : index
            %c32_106 = arith.constant 32 : index
            %4 = arith.muli %arg29, %c32_106 overflow<nsw> : index
            %5 = arith.addi %3, %4 : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc_18 to offset: [%5], sizes: [32, 32], strides: [384, 1] : memref<128x384xf32> to memref<32x32xf32, strided<[384, 1], offset: ?>>
            scf.for %arg30 = %c0 to %c32 step %c1 {
              scf.for %arg31 = %c0 to %c32 step %c1 {
                %9 = memref.load %reinterpret_cast_105[%arg31, %arg30] : memref<32x32xf32, strided<[128, 1], offset: ?>>
                memref.store %9, %reinterpret_cast_107[%arg30, %arg31] : memref<32x32xf32, strided<[384, 1], offset: ?>>
              }
            }
            %c12288_108 = arith.constant 12288 : index
            %6 = arith.muli %arg28, %c12288_108 overflow<nsw> : index
            %c32_109 = arith.constant 32 : index
            %7 = arith.muli %arg29, %c32_109 overflow<nsw> : index
            %8 = arith.addi %6, %7 : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_18 to offset: [%8], sizes: [32, 32], strides: [384, 1] : memref<128x384xf32> to memref<32x32xf32, strided<[384, 1], offset: ?>>
            scf.for %arg30 = %c0 to %c32 step %c1 {
              scf.for %arg31 = %c0 to %c32 step %c1 {
                %9 = memref.load %reinterpret_cast_107[%arg30, %arg31] : memref<32x32xf32, strided<[384, 1], offset: ?>>
                memref.store %9, %reinterpret_cast_110[%arg30, %arg31] : memref<32x32xf32, strided<[384, 1], offset: ?>>
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c4) step (%c1) {
            %c12288 = arith.constant 12288 : index
            %0 = arith.muli %arg28, %c12288 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_18 to offset: [%0], sizes: [32, 384], strides: [384, 1] : memref<128x384xf32> to memref<32x384xf32, strided<[384, 1], offset: ?>>
            %c12288_105 = arith.constant 12288 : index
            %1 = arith.muli %arg28, %c12288_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_19 to offset: [%1], sizes: [2, 32, 384], strides: [49152, 384, 1] : memref<2x128x384xf32> to memref<2x32x384xf32, strided<[49152, 384, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c384 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg30, %arg31] : memref<32x384xf32, strided<[384, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x384xf32, strided<[49152, 384, 1], offset: ?>>
                }
              }
            }
            %c12288_107 = arith.constant 12288 : index
            %2 = arith.muli %arg28, %c12288_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_19 to offset: [%2], sizes: [2, 32, 384], strides: [49152, 384, 1] : memref<2x128x384xf32> to memref<2x32x384xf32, strided<[49152, 384, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c384 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x384xf32, strided<[49152, 384, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x384xf32, strided<[49152, 384, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29, %arg30, %arg31) : index = (%c0, %c0, %c0, %c0) to (%c2, %c32, %c12, %c4) step (%c1, %c1, %c1, %c1) collapse(4) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg29, %c4096 overflow<nsw> : index
            %c32_104 = arith.constant 32 : index
            %1 = arith.muli %arg31, %c32_104 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %c131072 = arith.constant 131072 : index
            %3 = arith.muli %arg28, %c131072 overflow<nsw> : index
            %4 = arith.addi %2, %3 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_81 to offset: [%4], sizes: [1, 32, 32], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
            %c12288 = arith.constant 12288 : index
            %5 = arith.muli %arg31, %c12288 overflow<nsw> : index
            %c32_106 = arith.constant 32 : index
            %6 = arith.muli %arg30, %c32_106 overflow<nsw> : index
            %7 = arith.addi %5, %6 : index
            %c49152 = arith.constant 49152 : index
            %8 = arith.muli %arg28, %c49152 overflow<nsw> : index
            %9 = arith.addi %7, %8 : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc_19 to offset: [%9], sizes: [1, 32, 32], strides: [49152, 384, 1] : memref<2x128x384xf32> to memref<1x32x32xf32, strided<[49152, 384, 1], offset: ?>>
            %c12288_108 = arith.constant 12288 : index
            %10 = arith.muli %arg29, %c12288_108 overflow<nsw> : index
            %c32_109 = arith.constant 32 : index
            %11 = arith.muli %arg30, %c32_109 overflow<nsw> : index
            %12 = arith.addi %10, %11 : index
            %c393216 = arith.constant 393216 : index
            %13 = arith.muli %arg28, %c393216 overflow<nsw> : index
            %14 = arith.addi %12, %13 : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_21 to offset: [%14], sizes: [1, 32, 32], strides: [393216, 384, 1] : memref<2x1024x384xf32> to memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>
            scf.for %arg32 = %c0 to %c1 step %c1 {
              scf.for %arg33 = %c0 to %c32 step %c1 {
                scf.for %arg34 = %c0 to %c32 step %c1 {
                  scf.for %arg35 = %c0 to %c32 step %c1 {
                    %20 = memref.load %reinterpret_cast_105[%arg32, %arg33, %arg35] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                    %21 = memref.load %reinterpret_cast_107[%arg32, %arg35, %arg34] : memref<1x32x32xf32, strided<[49152, 384, 1], offset: ?>>
                    %22 = memref.load %reinterpret_cast_110[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>
                    %23 = arith.mulf %20, %21 : f32
                    %24 = arith.addf %22, %23 : f32
                    memref.store %24, %reinterpret_cast_110[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>
                  }
                }
              }
            }
            %c12288_111 = arith.constant 12288 : index
            %15 = arith.muli %arg29, %c12288_111 overflow<nsw> : index
            %c32_112 = arith.constant 32 : index
            %16 = arith.muli %arg30, %c32_112 overflow<nsw> : index
            %17 = arith.addi %15, %16 : index
            %c393216_113 = arith.constant 393216 : index
            %18 = arith.muli %arg28, %c393216_113 overflow<nsw> : index
            %19 = arith.addi %17, %18 : index
            %reinterpret_cast_114 = memref.reinterpret_cast %alloc_21 to offset: [%19], sizes: [1, 32, 32], strides: [393216, 384, 1] : memref<2x1024x384xf32> to memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>
            scf.for %arg32 = %c0 to %c1 step %c1 {
              scf.for %arg33 = %c0 to %c32 step %c1 {
                scf.for %arg34 = %c0 to %c32 step %c1 {
                  %20 = memref.load %reinterpret_cast_110[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>
                  memref.store %20, %reinterpret_cast_114[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c12288 = arith.constant 12288 : index
            %0 = arith.muli %arg28, %c12288 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_21 to offset: [%0], sizes: [2, 32, 384], strides: [393216, 384, 1] : memref<2x1024x384xf32> to memref<2x32x384xf32, strided<[393216, 384, 1], offset: ?>>
            %c12288_105 = arith.constant 12288 : index
            %1 = arith.muli %arg28, %c12288_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_20 to offset: [%1], sizes: [2, 32, 384], strides: [393216, 384, 1] : memref<2x1024x384xf32> to memref<2x32x384xf32, strided<[393216, 384, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c384 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x384xf32, strided<[393216, 384, 1], offset: ?>>
                  %4 = memref.load %arg17[%arg31] : memref<384xf32>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x384xf32, strided<[393216, 384, 1], offset: ?>>
                }
              }
            }
            %c12288_107 = arith.constant 12288 : index
            %2 = arith.muli %arg28, %c12288_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_20 to offset: [%2], sizes: [2, 32, 384], strides: [393216, 384, 1] : memref<2x1024x384xf32> to memref<2x32x384xf32, strided<[393216, 384, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c384 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x384xf32, strided<[393216, 384, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x384xf32, strided<[393216, 384, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %reinterpret_cast_82 = memref.reinterpret_cast %alloc_20 to offset: [128], sizes: [2, 1024, 4, 32], strides: [393216, 384, 32, 1] : memref<2x1024x384xf32> to memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 128>>
    %reinterpret_cast_83 = memref.reinterpret_cast %alloc_20 to offset: [0], sizes: [2, 1024, 4, 32], strides: [393216, 384, 32, 1] : memref<2x1024x384xf32> to memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1]>>
    %alloc_84 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x32xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c32 step %c1 {
            %0 = memref.load %reinterpret_cast_83[%arg28, %arg30, %arg29, %arg31] : memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1]>>
            memref.store %0, %alloc_84[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x32xf32>
          }
        }
      }
    }
    %reinterpret_cast_85 = memref.reinterpret_cast %alloc_20 to offset: [256], sizes: [2, 1024, 4, 32], strides: [393216, 384, 32, 1] : memref<2x1024x384xf32> to memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 256>>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c32 step %c1 {
            %0 = memref.load %reinterpret_cast_85[%arg28, %arg30, %arg29, %arg31] : memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 256>>
            memref.store %0, %alloc_24[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x32xf32>
          }
        }
      }
    }
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c32 step %c1 {
          scf.for %arg31 = %c0 to %c1024 step %c1 {
            %0 = memref.load %reinterpret_cast_82[%arg28, %arg31, %arg29, %arg30] : memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 128>>
            memref.store %0, %alloc_27[%arg28, %arg29, %arg30, %arg31] : memref<2x4x32x1024xf32>
          }
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29, %arg30) : index = (%c0, %c0, %c0) to (%c8, %c32, %c32) step (%c1, %c1, %c1) collapse(3) {
            %c1024_104 = arith.constant 1024 : index
            %0 = arith.muli %arg29, %c1024_104 overflow<nsw> : index
            %c32768 = arith.constant 32768 : index
            %1 = arith.muli %arg28, %c32768 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_84 to offset: [%2], sizes: [1, 32, 32], strides: [32768, 32, 1] : memref<2x4x1024x32xf32> to memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
            %c32_106 = arith.constant 32 : index
            %3 = arith.muli %arg30, %c32_106 overflow<nsw> : index
            %c32768_107 = arith.constant 32768 : index
            %4 = arith.muli %arg28, %c32768_107 overflow<nsw> : index
            %5 = arith.addi %3, %4 : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_27 to offset: [%5], sizes: [1, 32, 32], strides: [32768, 1024, 1] : memref<2x4x32x1024xf32> to memref<1x32x32xf32, strided<[32768, 1024, 1], offset: ?>>
            %c32768_109 = arith.constant 32768 : index
            %6 = arith.muli %arg29, %c32768_109 overflow<nsw> : index
            %c32_110 = arith.constant 32 : index
            %7 = arith.muli %arg30, %c32_110 overflow<nsw> : index
            %8 = arith.addi %6, %7 : index
            %c1048576 = arith.constant 1048576 : index
            %9 = arith.muli %arg28, %c1048576 overflow<nsw> : index
            %10 = arith.addi %8, %9 : index
            %reinterpret_cast_111 = memref.reinterpret_cast %alloc_28 to offset: [%10], sizes: [1, 32, 32], strides: [1048576, 1024, 1] : memref<8x1024x1024xf32> to memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
            scf.for %arg31 = %c0 to %c1 step %c1 {
              scf.for %arg32 = %c0 to %c32 step %c1 {
                scf.for %arg33 = %c0 to %c32 step %c1 {
                  scf.for %arg34 = %c0 to %c32 step %c1 {
                    %16 = memref.load %reinterpret_cast_105[%arg31, %arg32, %arg34] : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
                    %17 = memref.load %reinterpret_cast_108[%arg31, %arg34, %arg33] : memref<1x32x32xf32, strided<[32768, 1024, 1], offset: ?>>
                    %18 = memref.load %reinterpret_cast_111[%arg31, %arg32, %arg33] : memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
                    %19 = arith.mulf %16, %17 : f32
                    %20 = arith.addf %18, %19 : f32
                    memref.store %20, %reinterpret_cast_111[%arg31, %arg32, %arg33] : memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
                  }
                }
              }
            }
            %c32768_112 = arith.constant 32768 : index
            %11 = arith.muli %arg29, %c32768_112 overflow<nsw> : index
            %c32_113 = arith.constant 32 : index
            %12 = arith.muli %arg30, %c32_113 overflow<nsw> : index
            %13 = arith.addi %11, %12 : index
            %c1048576_114 = arith.constant 1048576 : index
            %14 = arith.muli %arg28, %c1048576_114 overflow<nsw> : index
            %15 = arith.addi %13, %14 : index
            %reinterpret_cast_115 = memref.reinterpret_cast %alloc_28 to offset: [%15], sizes: [1, 32, 32], strides: [1048576, 1024, 1] : memref<8x1024x1024xf32> to memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
            scf.for %arg31 = %c0 to %c1 step %c1 {
              scf.for %arg32 = %c0 to %c32 step %c1 {
                scf.for %arg33 = %c0 to %c32 step %c1 {
                  %16 = memref.load %reinterpret_cast_111[%arg31, %arg32, %arg33] : memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
                  memref.store %16, %reinterpret_cast_115[%arg31, %arg32, %arg33] : memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %reinterpret_cast_86 = memref.reinterpret_cast %alloc_28 to offset: [0], sizes: [2, 4, 1024, 1024], strides: [4194304, 1048576, 1024, 1] : memref<8x1024x1024xf32> to memref<2x4x1024x1024xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c1024 step %c1 {
            %0 = memref.load %reinterpret_cast_86[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
            %1 = arith.truncf %cst_2 : f64 to f32
            %2 = arith.mulf %0, %1 : f32
            memref.store %2, %alloc_31[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
          }
        }
      }
    }
    scf.for %arg28 = %c0 to %c1 step %c1 {
      scf.for %arg29 = %c0 to %c1 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c1024 step %c1 {
            %0 = memref.load %arg18[%arg28, %arg29, %arg30, %arg31] : memref<1x1x1024x1024xf32>
            %1 = arith.cmpf oeq, %0, %cst_3 : f32
            memref.store %1, %alloc_32[%arg28, %arg29, %arg30, %arg31] : memref<1x1x1024x1024xi1>
          }
        }
      }
    }
    %alloc_87 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x1024xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c1024 step %c1 {
            %0 = memref.load %alloc_32[%c0, %c0, %arg30, %arg31] : memref<1x1x1024x1024xi1>
            %1 = memref.load %alloc_31[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
            %2 = arith.select %0, %cst_4, %1 : f32
            memref.store %2, %alloc_87[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
          }
        }
      }
    }
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c1024 step %c1 {
            %0 = memref.load %alloc_87[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
            %1 = memref.load %alloc_35[%arg28, %arg29, %arg30] : memref<2x4x1024xf32>
            %2 = memref.load %alloc_34[%arg28, %arg29, %arg30] : memref<2x4x1024xi64>
            %3 = arith.index_cast %arg31 : index to i64
            %4 = arith.maximumf %0, %1 : f32
            %5 = arith.cmpf ogt, %0, %1 : f32
            %6 = arith.select %5, %3, %2 : i64
            memref.store %4, %alloc_35[%arg28, %arg29, %arg30] : memref<2x4x1024xf32>
            memref.store %6, %alloc_34[%arg28, %arg29, %arg30] : memref<2x4x1024xi64>
          }
        }
      }
    }
    %reinterpret_cast_88 = memref.reinterpret_cast %alloc_35 to offset: [0], sizes: [2, 4, 1024, 1], strides: [4096, 1024, 1, 1] : memref<2x4x1024xf32> to memref<2x4x1024x1xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c1024 step %c1 {
            %0 = memref.load %alloc_87[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
            %1 = memref.load %reinterpret_cast_88[%arg28, %arg29, %arg30, %c0] : memref<2x4x1024x1xf32>
            %2 = arith.subf %0, %1 : f32
            memref.store %2, %alloc_31[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
          }
        }
      }
    }
    %alloc_89 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x1024xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c1024 step %c1 {
            %0 = memref.load %alloc_31[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
            %1 = math.exp %0 : f32
            memref.store %1, %alloc_89[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
          }
        }
      }
    }
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c1024 step %c1 {
            %0 = memref.load %alloc_89[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
            %1 = memref.load %alloc_40[%arg28, %arg29, %arg30, %c0] : memref<2x4x1024x1xf32>
            %2 = arith.addf %0, %1 : f32
            memref.store %2, %alloc_40[%arg28, %arg29, %arg30, %c0] : memref<2x4x1024x1xf32>
          }
        }
      }
    }
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c4 step %c1 {
        scf.for %arg30 = %c0 to %c1024 step %c1 {
          scf.for %arg31 = %c0 to %c1024 step %c1 {
            %0 = memref.load %alloc_89[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
            %1 = memref.load %alloc_40[%arg28, %arg29, %arg30, %c0] : memref<2x4x1024x1xf32>
            %2 = arith.divf %0, %1 : f32
            memref.store %2, %alloc_31[%arg28, %arg29, %arg30, %arg31] : memref<2x4x1024x1024xf32>
          }
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29, %arg30) : index = (%c0, %c0, %c0) to (%c8, %c32, %c32) step (%c1, %c1, %c1) collapse(3) {
            %c32768 = arith.constant 32768 : index
            %0 = arith.muli %arg29, %c32768 overflow<nsw> : index
            %c32_104 = arith.constant 32 : index
            %1 = arith.muli %arg30, %c32_104 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %c1048576 = arith.constant 1048576 : index
            %3 = arith.muli %arg28, %c1048576 overflow<nsw> : index
            %4 = arith.addi %2, %3 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_31 to offset: [%4], sizes: [1, 32, 32], strides: [1048576, 1024, 1] : memref<2x4x1024x1024xf32> to memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
            %c1024_106 = arith.constant 1024 : index
            %5 = arith.muli %arg30, %c1024_106 overflow<nsw> : index
            %c32768_107 = arith.constant 32768 : index
            %6 = arith.muli %arg28, %c32768_107 overflow<nsw> : index
            %7 = arith.addi %5, %6 : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_24 to offset: [%7], sizes: [1, 32, 32], strides: [32768, 32, 1] : memref<2x4x1024x32xf32> to memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
            %c1024_109 = arith.constant 1024 : index
            %8 = arith.muli %arg29, %c1024_109 overflow<nsw> : index
            %c32768_110 = arith.constant 32768 : index
            %9 = arith.muli %arg28, %c32768_110 overflow<nsw> : index
            %10 = arith.addi %8, %9 : index
            %reinterpret_cast_111 = memref.reinterpret_cast %alloc_42 to offset: [%10], sizes: [1, 32, 32], strides: [32768, 32, 1] : memref<8x1024x32xf32> to memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
            scf.for %arg31 = %c0 to %c1 step %c1 {
              scf.for %arg32 = %c0 to %c32 step %c1 {
                scf.for %arg33 = %c0 to %c32 step %c1 {
                  scf.for %arg34 = %c0 to %c32 step %c1 {
                    %14 = memref.load %reinterpret_cast_105[%arg31, %arg32, %arg34] : memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
                    %15 = memref.load %reinterpret_cast_108[%arg31, %arg34, %arg33] : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
                    %16 = memref.load %reinterpret_cast_111[%arg31, %arg32, %arg33] : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
                    %17 = arith.mulf %14, %15 : f32
                    %18 = arith.addf %16, %17 : f32
                    memref.store %18, %reinterpret_cast_111[%arg31, %arg32, %arg33] : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
                  }
                }
              }
            }
            %c1024_112 = arith.constant 1024 : index
            %11 = arith.muli %arg29, %c1024_112 overflow<nsw> : index
            %c32768_113 = arith.constant 32768 : index
            %12 = arith.muli %arg28, %c32768_113 overflow<nsw> : index
            %13 = arith.addi %11, %12 : index
            %reinterpret_cast_114 = memref.reinterpret_cast %alloc_42 to offset: [%13], sizes: [1, 32, 32], strides: [32768, 32, 1] : memref<8x1024x32xf32> to memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
            scf.for %arg31 = %c0 to %c1 step %c1 {
              scf.for %arg32 = %c0 to %c32 step %c1 {
                scf.for %arg33 = %c0 to %c32 step %c1 {
                  %14 = memref.load %reinterpret_cast_111[%arg31, %arg32, %arg33] : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
                  memref.store %14, %reinterpret_cast_114[%arg31, %arg32, %arg33] : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c1024_104 = arith.constant 1024 : index
            %0 = arith.muli %arg28, %c1024_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_42 to offset: [%0], sizes: [2, 4, 32, 32], strides: [131072, 32768, 32, 1] : memref<8x1024x32xf32> to memref<2x4x32x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>
            %c4096 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_44 to offset: [%1], sizes: [2, 32, 4, 32], strides: [131072, 128, 32, 1] : memref<2x1024x4x32xf32> to memref<2x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c4 step %c1 {
                  scf.for %arg32 = %c0 to %c32 step %c1 {
                    %3 = memref.load %reinterpret_cast_105[%arg29, %arg31, %arg30, %arg32] : memref<2x4x32x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>
                    memref.store %3, %reinterpret_cast_106[%arg29, %arg30, %arg31, %arg32] : memref<2x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>
                  }
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_44 to offset: [%2], sizes: [2, 32, 4, 32], strides: [131072, 128, 32, 1] : memref<2x1024x4x32xf32> to memref<2x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c4 step %c1 {
                  scf.for %arg32 = %c0 to %c32 step %c1 {
                    %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31, %arg32] : memref<2x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>
                    memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31, %arg32] : memref<2x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>
                  }
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29) : index = (%c0, %c0) to (%c4, %c4) step (%c1, %c1) collapse(2) {
            %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %arg19 : memref<128x128xf32> -> memref<f32>, index, index, index, index, index
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg29, %c4096 overflow<nsw> : index
            %c32_104 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %base_buffer to offset: [%2], sizes: [32, 32], strides: [128, 1] : memref<f32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
            %c4096_106 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096_106 overflow<nsw> : index
            %c32_107 = arith.constant 32 : index
            %4 = arith.muli %arg29, %c32_107 overflow<nsw> : index
            %5 = arith.addi %3, %4 : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_45 to offset: [%5], sizes: [32, 32], strides: [128, 1] : memref<128x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
            scf.for %arg30 = %c0 to %c32 step %c1 {
              scf.for %arg31 = %c0 to %c32 step %c1 {
                %9 = memref.load %reinterpret_cast_105[%arg31, %arg30] : memref<32x32xf32, strided<[128, 1], offset: ?>>
                memref.store %9, %reinterpret_cast_108[%arg30, %arg31] : memref<32x32xf32, strided<[128, 1], offset: ?>>
              }
            }
            %c4096_109 = arith.constant 4096 : index
            %6 = arith.muli %arg28, %c4096_109 overflow<nsw> : index
            %c32_110 = arith.constant 32 : index
            %7 = arith.muli %arg29, %c32_110 overflow<nsw> : index
            %8 = arith.addi %6, %7 : index
            %reinterpret_cast_111 = memref.reinterpret_cast %alloc_45 to offset: [%8], sizes: [32, 32], strides: [128, 1] : memref<128x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
            scf.for %arg30 = %c0 to %c32 step %c1 {
              scf.for %arg31 = %c0 to %c32 step %c1 {
                %9 = memref.load %reinterpret_cast_108[%arg30, %arg31] : memref<32x32xf32, strided<[128, 1], offset: ?>>
                memref.store %9, %reinterpret_cast_111[%arg30, %arg31] : memref<32x32xf32, strided<[128, 1], offset: ?>>
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c4) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_45 to offset: [%0], sizes: [32, 128], strides: [128, 1] : memref<128x128xf32> to memref<32x128xf32, strided<[128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_46 to offset: [%1], sizes: [2, 32, 128], strides: [16384, 128, 1] : memref<2x128x128xf32> to memref<2x32x128xf32, strided<[16384, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg30, %arg31] : memref<32x128xf32, strided<[128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[16384, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_46 to offset: [%2], sizes: [2, 32, 128], strides: [16384, 128, 1] : memref<2x128x128xf32> to memref<2x32x128xf32, strided<[16384, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[16384, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[16384, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_90 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %alloc_47[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_90[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29, %arg30, %arg31) : index = (%c0, %c0, %c0, %c0) to (%c2, %c32, %c4, %c4) step (%c1, %c1, %c1, %c1) collapse(4) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg29, %c4096 overflow<nsw> : index
            %c32_104 = arith.constant 32 : index
            %1 = arith.muli %arg31, %c32_104 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %c131072 = arith.constant 131072 : index
            %3 = arith.muli %arg28, %c131072 overflow<nsw> : index
            %4 = arith.addi %2, %3 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_44 to offset: [%4], sizes: [1, 32, 32], strides: [131072, 128, 1] : memref<2x1024x4x32xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_106 = arith.constant 4096 : index
            %5 = arith.muli %arg31, %c4096_106 overflow<nsw> : index
            %c32_107 = arith.constant 32 : index
            %6 = arith.muli %arg30, %c32_107 overflow<nsw> : index
            %7 = arith.addi %5, %6 : index
            %c16384 = arith.constant 16384 : index
            %8 = arith.muli %arg28, %c16384 overflow<nsw> : index
            %9 = arith.addi %7, %8 : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_46 to offset: [%9], sizes: [1, 32, 32], strides: [16384, 128, 1] : memref<2x128x128xf32> to memref<1x32x32xf32, strided<[16384, 128, 1], offset: ?>>
            %c4096_109 = arith.constant 4096 : index
            %10 = arith.muli %arg29, %c4096_109 overflow<nsw> : index
            %c32_110 = arith.constant 32 : index
            %11 = arith.muli %arg30, %c32_110 overflow<nsw> : index
            %12 = arith.addi %10, %11 : index
            %c131072_111 = arith.constant 131072 : index
            %13 = arith.muli %arg28, %c131072_111 overflow<nsw> : index
            %14 = arith.addi %12, %13 : index
            %reinterpret_cast_112 = memref.reinterpret_cast %alloc_90 to offset: [%14], sizes: [1, 32, 32], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg32 = %c0 to %c1 step %c1 {
              scf.for %arg33 = %c0 to %c32 step %c1 {
                scf.for %arg34 = %c0 to %c32 step %c1 {
                  scf.for %arg35 = %c0 to %c32 step %c1 {
                    %20 = memref.load %reinterpret_cast_105[%arg32, %arg33, %arg35] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                    %21 = memref.load %reinterpret_cast_108[%arg32, %arg35, %arg34] : memref<1x32x32xf32, strided<[16384, 128, 1], offset: ?>>
                    %22 = memref.load %reinterpret_cast_112[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                    %23 = arith.mulf %20, %21 : f32
                    %24 = arith.addf %22, %23 : f32
                    memref.store %24, %reinterpret_cast_112[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                  }
                }
              }
            }
            %c4096_113 = arith.constant 4096 : index
            %15 = arith.muli %arg29, %c4096_113 overflow<nsw> : index
            %c32_114 = arith.constant 32 : index
            %16 = arith.muli %arg30, %c32_114 overflow<nsw> : index
            %17 = arith.addi %15, %16 : index
            %c131072_115 = arith.constant 131072 : index
            %18 = arith.muli %arg28, %c131072_115 overflow<nsw> : index
            %19 = arith.addi %17, %18 : index
            %reinterpret_cast_116 = memref.reinterpret_cast %alloc_90 to offset: [%19], sizes: [1, 32, 32], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg32 = %c0 to %c1 step %c1 {
              scf.for %arg33 = %c0 to %c32 step %c1 {
                scf.for %arg34 = %c0 to %c32 step %c1 {
                  %20 = memref.load %reinterpret_cast_112[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %20, %reinterpret_cast_116[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_91 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_91[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_90 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_91 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %arg20[%arg31] : memref<128xf32>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_91 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_92 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_92[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_71 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_91 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_92 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %5 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %6 = arith.addf %4, %5 : f32
                  memref.store %6, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_109 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096_109 overflow<nsw> : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_92 to offset: [%3], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %4, %reinterpret_cast_110[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_93 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c1 step %c1 {
          %0 = memref.load %alloc_7[%arg28, %arg29, %arg30] : memref<2x1024x1xf32>
          memref.store %0, %alloc_93[%arg28, %arg29, %arg30] : memref<2x1024x1xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_92 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c32_105 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_93 to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %reinterpret_cast_106[%arg29, %arg30, %c0] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %c0] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_107 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_93 to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_93 to offset: [%0], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            %c32_106 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_106 overflow<nsw> : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %4 = arith.divf %3, %cst_0 : f32
                  memref.store %4, %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_108 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_108 overflow<nsw> : index
            %reinterpret_cast_109 = memref.reinterpret_cast %alloc to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_109[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_94 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_94[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc to offset: [%0], sizes: [2, 32], strides: [1024, 1] : memref<2x1024x1xf32> to memref<2x32xf32, strided<[1024, 1], offset: ?>>
            %c4096 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_94 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30] : memref<2x32xf32, strided<[1024, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_94 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_95 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_95[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_92 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_94 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_95 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %5 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %6 = arith.subf %4, %5 : f32
                  memref.store %6, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_109 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096_109 overflow<nsw> : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_95 to offset: [%3], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %4, %reinterpret_cast_110[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_96 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_96[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_95 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_95 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_96 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %5 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %6 = arith.mulf %4, %5 : f32
                  memref.store %6, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_109 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096_109 overflow<nsw> : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_96 to offset: [%3], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %4, %reinterpret_cast_110[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_96 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c32_105 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_7 to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %reinterpret_cast_106[%arg29, %arg30, %c0] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %c0] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_107 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_7 to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_7 to offset: [%0], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            %c32_106 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_106 overflow<nsw> : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %4 = arith.divf %3, %cst_0 : f32
                  memref.store %4, %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_108 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_108 overflow<nsw> : index
            %reinterpret_cast_109 = memref.reinterpret_cast %alloc to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_109[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_97 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc to offset: [%0], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            %c32_106 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_106 overflow<nsw> : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc_97 to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %4 = arith.truncf %cst_1 : f64 to f32
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_108 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_108 overflow<nsw> : index
            %reinterpret_cast_109 = memref.reinterpret_cast %alloc_97 to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_109[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_97 to offset: [%0], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            %c32_106 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_106 overflow<nsw> : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc to offset: [%1], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  %4 = math.rsqrt %3 : f32
                  memref.store %4, %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
            %c32_108 = arith.constant 32 : index
            %2 = arith.muli %arg28, %c32_108 overflow<nsw> : index
            %reinterpret_cast_109 = memref.reinterpret_cast %alloc to offset: [%2], sizes: [2, 32, 1], strides: [1024, 1, 1] : memref<2x1024x1xf32> to memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c1 step %c1 {
                  %3 = memref.load %reinterpret_cast_107[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_109[%arg29, %arg30, %arg31] : memref<2x32x1xf32, strided<[1024, 1, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_98 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_98[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c32_104 = arith.constant 32 : index
            %0 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc to offset: [%0], sizes: [2, 32], strides: [1024, 1] : memref<2x1024x1xf32> to memref<2x32xf32, strided<[1024, 1], offset: ?>>
            %c4096 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_98 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_105[%arg29, %arg30] : memref<2x32xf32, strided<[1024, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_98 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_99 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_99[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_95 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_98 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_99 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %5 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %6 = arith.mulf %4, %5 : f32
                  memref.store %6, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_109 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096_109 overflow<nsw> : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_99 to offset: [%3], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %4, %reinterpret_cast_110[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_100 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_100[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_99 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_100 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %arg21[%arg31] : memref<128xf32>
                  %5 = arith.mulf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_100 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_101 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_101[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_100 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_101 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %arg22[%arg31] : memref<128xf32>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_101 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29) : index = (%c0, %c0) to (%c4, %c16) step (%c1, %c1) collapse(2) {
            %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %arg23 : memref<512x128xf32> -> memref<f32>, index, index, index, index, index
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg29, %c4096 overflow<nsw> : index
            %c32_104 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %base_buffer to offset: [%2], sizes: [32, 32], strides: [128, 1] : memref<f32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
            %c16384 = arith.constant 16384 : index
            %3 = arith.muli %arg28, %c16384 overflow<nsw> : index
            %c32_106 = arith.constant 32 : index
            %4 = arith.muli %arg29, %c32_106 overflow<nsw> : index
            %5 = arith.addi %3, %4 : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc_61 to offset: [%5], sizes: [32, 32], strides: [512, 1] : memref<128x512xf32> to memref<32x32xf32, strided<[512, 1], offset: ?>>
            scf.for %arg30 = %c0 to %c32 step %c1 {
              scf.for %arg31 = %c0 to %c32 step %c1 {
                %9 = memref.load %reinterpret_cast_105[%arg31, %arg30] : memref<32x32xf32, strided<[128, 1], offset: ?>>
                memref.store %9, %reinterpret_cast_107[%arg30, %arg31] : memref<32x32xf32, strided<[512, 1], offset: ?>>
              }
            }
            %c16384_108 = arith.constant 16384 : index
            %6 = arith.muli %arg28, %c16384_108 overflow<nsw> : index
            %c32_109 = arith.constant 32 : index
            %7 = arith.muli %arg29, %c32_109 overflow<nsw> : index
            %8 = arith.addi %6, %7 : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_61 to offset: [%8], sizes: [32, 32], strides: [512, 1] : memref<128x512xf32> to memref<32x32xf32, strided<[512, 1], offset: ?>>
            scf.for %arg30 = %c0 to %c32 step %c1 {
              scf.for %arg31 = %c0 to %c32 step %c1 {
                %9 = memref.load %reinterpret_cast_107[%arg30, %arg31] : memref<32x32xf32, strided<[512, 1], offset: ?>>
                memref.store %9, %reinterpret_cast_110[%arg30, %arg31] : memref<32x32xf32, strided<[512, 1], offset: ?>>
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c4) step (%c1) {
            %c16384 = arith.constant 16384 : index
            %0 = arith.muli %arg28, %c16384 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_61 to offset: [%0], sizes: [32, 512], strides: [512, 1] : memref<128x512xf32> to memref<32x512xf32, strided<[512, 1], offset: ?>>
            %c16384_105 = arith.constant 16384 : index
            %1 = arith.muli %arg28, %c16384_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_62 to offset: [%1], sizes: [2, 32, 512], strides: [65536, 512, 1] : memref<2x128x512xf32> to memref<2x32x512xf32, strided<[65536, 512, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c512 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg30, %arg31] : memref<32x512xf32, strided<[512, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[65536, 512, 1], offset: ?>>
                }
              }
            }
            %c16384_107 = arith.constant 16384 : index
            %2 = arith.muli %arg28, %c16384_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_62 to offset: [%2], sizes: [2, 32, 512], strides: [65536, 512, 1] : memref<2x128x512xf32> to memref<2x32x512xf32, strided<[65536, 512, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c512 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[65536, 512, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[65536, 512, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29, %arg30, %arg31) : index = (%c0, %c0, %c0, %c0) to (%c2, %c32, %c16, %c4) step (%c1, %c1, %c1, %c1) collapse(4) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg29, %c4096 overflow<nsw> : index
            %c32_104 = arith.constant 32 : index
            %1 = arith.muli %arg31, %c32_104 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %c131072 = arith.constant 131072 : index
            %3 = arith.muli %arg28, %c131072 overflow<nsw> : index
            %4 = arith.addi %2, %3 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_101 to offset: [%4], sizes: [1, 32, 32], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
            %c16384 = arith.constant 16384 : index
            %5 = arith.muli %arg31, %c16384 overflow<nsw> : index
            %c32_106 = arith.constant 32 : index
            %6 = arith.muli %arg30, %c32_106 overflow<nsw> : index
            %7 = arith.addi %5, %6 : index
            %c65536 = arith.constant 65536 : index
            %8 = arith.muli %arg28, %c65536 overflow<nsw> : index
            %9 = arith.addi %7, %8 : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc_62 to offset: [%9], sizes: [1, 32, 32], strides: [65536, 512, 1] : memref<2x128x512xf32> to memref<1x32x32xf32, strided<[65536, 512, 1], offset: ?>>
            %c16384_108 = arith.constant 16384 : index
            %10 = arith.muli %arg29, %c16384_108 overflow<nsw> : index
            %c32_109 = arith.constant 32 : index
            %11 = arith.muli %arg30, %c32_109 overflow<nsw> : index
            %12 = arith.addi %10, %11 : index
            %c524288 = arith.constant 524288 : index
            %13 = arith.muli %arg28, %c524288 overflow<nsw> : index
            %14 = arith.addi %12, %13 : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_64 to offset: [%14], sizes: [1, 32, 32], strides: [524288, 512, 1] : memref<2x1024x512xf32> to memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
            scf.for %arg32 = %c0 to %c1 step %c1 {
              scf.for %arg33 = %c0 to %c32 step %c1 {
                scf.for %arg34 = %c0 to %c32 step %c1 {
                  scf.for %arg35 = %c0 to %c32 step %c1 {
                    %20 = memref.load %reinterpret_cast_105[%arg32, %arg33, %arg35] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                    %21 = memref.load %reinterpret_cast_107[%arg32, %arg35, %arg34] : memref<1x32x32xf32, strided<[65536, 512, 1], offset: ?>>
                    %22 = memref.load %reinterpret_cast_110[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
                    %23 = arith.mulf %20, %21 : f32
                    %24 = arith.addf %22, %23 : f32
                    memref.store %24, %reinterpret_cast_110[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
                  }
                }
              }
            }
            %c16384_111 = arith.constant 16384 : index
            %15 = arith.muli %arg29, %c16384_111 overflow<nsw> : index
            %c32_112 = arith.constant 32 : index
            %16 = arith.muli %arg30, %c32_112 overflow<nsw> : index
            %17 = arith.addi %15, %16 : index
            %c524288_113 = arith.constant 524288 : index
            %18 = arith.muli %arg28, %c524288_113 overflow<nsw> : index
            %19 = arith.addi %17, %18 : index
            %reinterpret_cast_114 = memref.reinterpret_cast %alloc_64 to offset: [%19], sizes: [1, 32, 32], strides: [524288, 512, 1] : memref<2x1024x512xf32> to memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
            scf.for %arg32 = %c0 to %c1 step %c1 {
              scf.for %arg33 = %c0 to %c32 step %c1 {
                scf.for %arg34 = %c0 to %c32 step %c1 {
                  %20 = memref.load %reinterpret_cast_110[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
                  memref.store %20, %reinterpret_cast_114[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_102 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x512xf32>
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c16384 = arith.constant 16384 : index
            %0 = arith.muli %arg28, %c16384 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_64 to offset: [%0], sizes: [2, 32, 512], strides: [524288, 512, 1] : memref<2x1024x512xf32> to memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
            %c16384_105 = arith.constant 16384 : index
            %1 = arith.muli %arg28, %c16384_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_102 to offset: [%1], sizes: [2, 32, 512], strides: [524288, 512, 1] : memref<2x1024x512xf32> to memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c512 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
                  %4 = memref.load %arg24[%arg31] : memref<512xf32>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
                }
              }
            }
            %c16384_107 = arith.constant 16384 : index
            %2 = arith.muli %arg28, %c16384_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_102 to offset: [%2], sizes: [2, 32, 512], strides: [524288, 512, 1] : memref<2x1024x512xf32> to memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c512 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c16384 = arith.constant 16384 : index
            %0 = arith.muli %arg28, %c16384 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_102 to offset: [%0], sizes: [2, 32, 512], strides: [524288, 512, 1] : memref<2x1024x512xf32> to memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
            %c16384_105 = arith.constant 16384 : index
            %1 = arith.muli %arg28, %c16384_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_63 to offset: [%1], sizes: [2, 32, 512], strides: [524288, 512, 1] : memref<2x1024x512xf32> to memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c512 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
                  %4 = arith.divf %3, %cst : f32
                  %5 = math.erf %4 : f32
                  %6 = arith.addf %5, %cst_5 : f32
                  %7 = arith.mulf %6, %cst_6 : f32
                  %8 = arith.mulf %3, %7 : f32
                  memref.store %8, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
                }
              }
            }
            %c16384_107 = arith.constant 16384 : index
            %2 = arith.muli %arg28, %c16384_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_63 to offset: [%2], sizes: [2, 32, 512], strides: [524288, 512, 1] : memref<2x1024x512xf32> to memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c512 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x512xf32, strided<[524288, 512, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29) : index = (%c0, %c0) to (%c16, %c4) step (%c1, %c1) collapse(2) {
            %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %arg25 : memref<128x512xf32> -> memref<f32>, index, index, index, index, index
            %c16384 = arith.constant 16384 : index
            %0 = arith.muli %arg29, %c16384 overflow<nsw> : index
            %c32_104 = arith.constant 32 : index
            %1 = arith.muli %arg28, %c32_104 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %base_buffer to offset: [%2], sizes: [32, 32], strides: [512, 1] : memref<f32> to memref<32x32xf32, strided<[512, 1], offset: ?>>
            %c4096 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %c32_106 = arith.constant 32 : index
            %4 = arith.muli %arg29, %c32_106 overflow<nsw> : index
            %5 = arith.addi %3, %4 : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc_67 to offset: [%5], sizes: [32, 32], strides: [128, 1] : memref<512x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
            scf.for %arg30 = %c0 to %c32 step %c1 {
              scf.for %arg31 = %c0 to %c32 step %c1 {
                %9 = memref.load %reinterpret_cast_105[%arg31, %arg30] : memref<32x32xf32, strided<[512, 1], offset: ?>>
                memref.store %9, %reinterpret_cast_107[%arg30, %arg31] : memref<32x32xf32, strided<[128, 1], offset: ?>>
              }
            }
            %c4096_108 = arith.constant 4096 : index
            %6 = arith.muli %arg28, %c4096_108 overflow<nsw> : index
            %c32_109 = arith.constant 32 : index
            %7 = arith.muli %arg29, %c32_109 overflow<nsw> : index
            %8 = arith.addi %6, %7 : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_67 to offset: [%8], sizes: [32, 32], strides: [128, 1] : memref<512x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
            scf.for %arg30 = %c0 to %c32 step %c1 {
              scf.for %arg31 = %c0 to %c32 step %c1 {
                %9 = memref.load %reinterpret_cast_107[%arg30, %arg31] : memref<32x32xf32, strided<[128, 1], offset: ?>>
                memref.store %9, %reinterpret_cast_110[%arg30, %arg31] : memref<32x32xf32, strided<[128, 1], offset: ?>>
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c16) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_67 to offset: [%0], sizes: [32, 128], strides: [128, 1] : memref<512x128xf32> to memref<32x128xf32, strided<[128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_68 to offset: [%1], sizes: [2, 32, 128], strides: [65536, 128, 1] : memref<2x512x128xf32> to memref<2x32x128xf32, strided<[65536, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg30, %arg31] : memref<32x128xf32, strided<[128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[65536, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_68 to offset: [%2], sizes: [2, 32, 128], strides: [65536, 128, 1] : memref<2x512x128xf32> to memref<2x32x128xf32, strided<[65536, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[65536, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[65536, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28, %arg29, %arg30, %arg31) : index = (%c0, %c0, %c0, %c0) to (%c2, %c32, %c4, %c16) step (%c1, %c1, %c1, %c1) collapse(4) {
            %c16384 = arith.constant 16384 : index
            %0 = arith.muli %arg29, %c16384 overflow<nsw> : index
            %c32_104 = arith.constant 32 : index
            %1 = arith.muli %arg31, %c32_104 overflow<nsw> : index
            %2 = arith.addi %0, %1 : index
            %c524288 = arith.constant 524288 : index
            %3 = arith.muli %arg28, %c524288 overflow<nsw> : index
            %4 = arith.addi %2, %3 : index
            %reinterpret_cast_105 = memref.reinterpret_cast %alloc_63 to offset: [%4], sizes: [1, 32, 32], strides: [524288, 512, 1] : memref<2x1024x512xf32> to memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
            %c4096 = arith.constant 4096 : index
            %5 = arith.muli %arg31, %c4096 overflow<nsw> : index
            %c32_106 = arith.constant 32 : index
            %6 = arith.muli %arg30, %c32_106 overflow<nsw> : index
            %7 = arith.addi %5, %6 : index
            %c65536 = arith.constant 65536 : index
            %8 = arith.muli %arg28, %c65536 overflow<nsw> : index
            %9 = arith.addi %7, %8 : index
            %reinterpret_cast_107 = memref.reinterpret_cast %alloc_68 to offset: [%9], sizes: [1, 32, 32], strides: [65536, 128, 1] : memref<2x512x128xf32> to memref<1x32x32xf32, strided<[65536, 128, 1], offset: ?>>
            %c4096_108 = arith.constant 4096 : index
            %10 = arith.muli %arg29, %c4096_108 overflow<nsw> : index
            %c32_109 = arith.constant 32 : index
            %11 = arith.muli %arg30, %c32_109 overflow<nsw> : index
            %12 = arith.addi %10, %11 : index
            %c131072 = arith.constant 131072 : index
            %13 = arith.muli %arg28, %c131072 overflow<nsw> : index
            %14 = arith.addi %12, %13 : index
            %reinterpret_cast_110 = memref.reinterpret_cast %alloc_47 to offset: [%14], sizes: [1, 32, 32], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg32 = %c0 to %c1 step %c1 {
              scf.for %arg33 = %c0 to %c32 step %c1 {
                scf.for %arg34 = %c0 to %c32 step %c1 {
                  scf.for %arg35 = %c0 to %c32 step %c1 {
                    %20 = memref.load %reinterpret_cast_105[%arg32, %arg33, %arg35] : memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
                    %21 = memref.load %reinterpret_cast_107[%arg32, %arg35, %arg34] : memref<1x32x32xf32, strided<[65536, 128, 1], offset: ?>>
                    %22 = memref.load %reinterpret_cast_110[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                    %23 = arith.mulf %20, %21 : f32
                    %24 = arith.addf %22, %23 : f32
                    memref.store %24, %reinterpret_cast_110[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                  }
                }
              }
            }
            %c4096_111 = arith.constant 4096 : index
            %15 = arith.muli %arg29, %c4096_111 overflow<nsw> : index
            %c32_112 = arith.constant 32 : index
            %16 = arith.muli %arg30, %c32_112 overflow<nsw> : index
            %17 = arith.addi %15, %16 : index
            %c131072_113 = arith.constant 131072 : index
            %18 = arith.muli %arg28, %c131072_113 overflow<nsw> : index
            %19 = arith.addi %17, %18 : index
            %reinterpret_cast_114 = memref.reinterpret_cast %alloc_47 to offset: [%19], sizes: [1, 32, 32], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg32 = %c0 to %c1 step %c1 {
              scf.for %arg33 = %c0 to %c32 step %c1 {
                scf.for %arg34 = %c0 to %c32 step %c1 {
                  %20 = memref.load %reinterpret_cast_110[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %20, %reinterpret_cast_114[%arg32, %arg33, %arg34] : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    %alloc_103 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    scf.for %arg28 = %c0 to %c2 step %c1 {
      scf.for %arg29 = %c0 to %c1024 step %c1 {
        scf.for %arg30 = %c0 to %c128 step %c1 {
          %0 = memref.load %arg27[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
          memref.store %0, %alloc_103[%arg28, %arg29, %arg30] : memref<2x1024x128xf32>
        }
      }
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_47 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_103 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %4 = memref.load %arg26[%arg31] : memref<128xf32>
                  %5 = arith.addf %3, %4 : f32
                  memref.store %5, %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %alloc_103 to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %3 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %3, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
          omp.yield
        }
      }
      omp.terminator
    }
    omp.parallel {
      omp.wsloop {
        omp.loop_nest (%arg28) : index = (%c0) to (%c32) step (%c1) {
            %c4096 = arith.constant 4096 : index
            %0 = arith.muli %arg28, %c4096 overflow<nsw> : index
            %reinterpret_cast_104 = memref.reinterpret_cast %alloc_92 to offset: [%0], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %c4096_105 = arith.constant 4096 : index
            %1 = arith.muli %arg28, %c4096_105 overflow<nsw> : index
            %reinterpret_cast_106 = memref.reinterpret_cast %alloc_103 to offset: [%1], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<2x1024x128xf32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            %base_buffer, %offset, %sizes:3, %strides:3 = memref.extract_strided_metadata %arg27 : memref<2x1024x128xf32> -> memref<f32>, index, index, index, index, index, index, index
            %c4096_107 = arith.constant 4096 : index
            %2 = arith.muli %arg28, %c4096_107 overflow<nsw> : index
            %reinterpret_cast_108 = memref.reinterpret_cast %base_buffer to offset: [%2], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<f32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_104[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %5 = memref.load %reinterpret_cast_106[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  %6 = arith.addf %4, %5 : f32
                  memref.store %6, %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
              }
            }
            %base_buffer_109, %offset_110, %sizes_111:3, %strides_112:3 = memref.extract_strided_metadata %arg27 : memref<2x1024x128xf32> -> memref<f32>, index, index, index, index, index, index, index
            %c4096_113 = arith.constant 4096 : index
            %3 = arith.muli %arg28, %c4096_113 overflow<nsw> : index
            %reinterpret_cast_114 = memref.reinterpret_cast %base_buffer_109 to offset: [%3], sizes: [2, 32, 128], strides: [131072, 128, 1] : memref<f32> to memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
            scf.for %arg29 = %c0 to %c2 step %c1 {
              scf.for %arg30 = %c0 to %c32 step %c1 {
                scf.for %arg31 = %c0 to %c128 step %c1 {
                  %4 = memref.load %reinterpret_cast_108[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                  memref.store %4, %reinterpret_cast_114[%arg29, %arg30, %arg31] : memref<2x32x128xf32, strided<[131072, 128, 1], offset: ?>>
                }
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

