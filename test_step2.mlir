module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: memref<4096x4096xf32>, %arg1: memref<4096x4096xf32>, %arg2: memref<4096x4096xf32>) {
    %c16384 = arith.constant 16384 : index
    %c131072 = arith.constant 131072 : index
    %c32 = arith.constant 32 : index
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    %c4096 = arith.constant 4096 : index
    %cst = arith.constant dense<2.000000e+00> : vector<4x4xf32>
    %0 = ub.poison : f32
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<4096x4096xf32>
    scf.for %arg3 = %c0 to %c4096 step %c1 {
      scf.for %arg4 = %c0 to %c4096 step %c1 {
        %1 = memref.load %arg2[%arg3, %arg4] : memref<4096x4096xf32>
        memref.store %1, %alloc[%arg3, %arg4] : memref<4096x4096xf32>
      }
    }
    scf.forall (%arg3, %arg4) in (128, 128) {
      %1 = arith.muli %arg3, %c131072 overflow<nsw> : index
      %2 = arith.muli %arg4, %c32 overflow<nsw> : index
      %3 = arith.addi %1, %2 : index
      %reinterpret_cast = memref.reinterpret_cast %alloc to offset: [%3], sizes: [32, 32], strides: [4096, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      scf.forall (%arg5, %arg6) in (8, 8) {
        %alloca = memref.alloca() : memref<vector<4x4xf32>>
        %alloca_1 = memref.alloca() : memref<vector<4x4xf32>>
        %alloca_2 = memref.alloca() : memref<vector<4x4xf32>>
        %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %arg0 : memref<4096x4096xf32> -> memref<f32>, index, index, index, index, index
        %7 = arith.muli %arg3, %c131072 overflow<nsw> : index
        %8 = arith.muli %arg4, %c32 overflow<nsw> : index
        %9 = arith.addi %7, %8 : index
        %10 = arith.muli %arg5, %c16384 overflow<nsw> : index
        %11 = arith.muli %arg6, %c4 overflow<nsw> : index
        %12 = arith.addi %10, %11 : index
        %13 = arith.addi %12, %9 : index
        %reinterpret_cast_3 = memref.reinterpret_cast %base_buffer to offset: [%13], sizes: [4, 4], strides: [4096, 1] : memref<f32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %base_buffer_4, %offset_5, %sizes_6:2, %strides_7:2 = memref.extract_strided_metadata %arg1 : memref<4096x4096xf32> -> memref<f32>, index, index, index, index, index
        %14 = arith.muli %arg3, %c131072 overflow<nsw> : index
        %15 = arith.muli %arg4, %c32 overflow<nsw> : index
        %16 = arith.addi %14, %15 : index
        %17 = arith.muli %arg5, %c16384 overflow<nsw> : index
        %18 = arith.muli %arg6, %c4 overflow<nsw> : index
        %19 = arith.addi %17, %18 : index
        %20 = arith.addi %19, %16 : index
        %reinterpret_cast_8 = memref.reinterpret_cast %base_buffer_4 to offset: [%20], sizes: [4, 4], strides: [4096, 1] : memref<f32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %21 = arith.muli %arg3, %c131072 overflow<nsw> : index
        %22 = arith.muli %arg4, %c32 overflow<nsw> : index
        %23 = arith.addi %21, %22 : index
        %24 = arith.muli %arg5, %c16384 overflow<nsw> : index
        %25 = arith.muli %arg6, %c4 overflow<nsw> : index
        %26 = arith.addi %24, %25 : index
        %27 = arith.addi %26, %23 : index
        %reinterpret_cast_9 = memref.reinterpret_cast %alloc to offset: [%27], sizes: [4, 4], strides: [4096, 1] : memref<4096x4096xf32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %28 = vector.type_cast %alloca : memref<vector<4x4xf32>> to memref<4xvector<4xf32>>
        scf.for %arg7 = %c0 to %c4 step %c1 {
          %41 = vector.transfer_read %reinterpret_cast_3[%arg7, %c0], %0 {in_bounds = [true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4xf32>
          memref.store %41, %28[%arg7] : memref<4xvector<4xf32>>
        }
        %29 = memref.load %alloca[] : memref<vector<4x4xf32>>
        %30 = vector.type_cast %alloca_1 : memref<vector<4x4xf32>> to memref<4xvector<4xf32>>
        scf.for %arg7 = %c0 to %c4 step %c1 {
          %41 = vector.transfer_read %reinterpret_cast_8[%arg7, %c0], %0 {in_bounds = [true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4xf32>
          memref.store %41, %30[%arg7] : memref<4xvector<4xf32>>
        }
        %31 = memref.load %alloca_1[] : memref<vector<4x4xf32>>
        %32 = arith.mulf %29, %31 : vector<4x4xf32>
        memref.store %32, %alloca_2[] : memref<vector<4x4xf32>>
        %33 = vector.type_cast %alloca_2 : memref<vector<4x4xf32>> to memref<4xvector<4xf32>>
        scf.for %arg7 = %c0 to %c4 step %c1 {
          %41 = memref.load %33[%arg7] : memref<4xvector<4xf32>>
          vector.transfer_write %41, %reinterpret_cast_9[%arg7, %c0] {in_bounds = [true]} : vector<4xf32>, memref<4x4xf32, strided<[4096, 1], offset: ?>>
        }
        %34 = arith.muli %arg3, %c131072 overflow<nsw> : index
        %35 = arith.muli %arg4, %c32 overflow<nsw> : index
        %36 = arith.addi %34, %35 : index
        %37 = arith.muli %arg5, %c16384 overflow<nsw> : index
        %38 = arith.muli %arg6, %c4 overflow<nsw> : index
        %39 = arith.addi %37, %38 : index
        %40 = arith.addi %39, %36 : index
        %reinterpret_cast_10 = memref.reinterpret_cast %alloc to offset: [%40], sizes: [4, 4], strides: [4096, 1] : memref<4096x4096xf32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        scf.for %arg7 = %c0 to %c4 step %c1 {
          scf.for %arg8 = %c0 to %c4 step %c1 {
            %41 = memref.load %reinterpret_cast_9[%arg7, %arg8] : memref<4x4xf32, strided<[4096, 1], offset: ?>>
            memref.store %41, %reinterpret_cast_10[%arg7, %arg8] : memref<4x4xf32, strided<[4096, 1], offset: ?>>
          }
        }
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      %4 = arith.muli %arg3, %c131072 overflow<nsw> : index
      %5 = arith.muli %arg4, %c32 overflow<nsw> : index
      %6 = arith.addi %4, %5 : index
      %reinterpret_cast_0 = memref.reinterpret_cast %alloc to offset: [%6], sizes: [32, 32], strides: [4096, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      scf.for %arg5 = %c0 to %c32 step %c1 {
        scf.for %arg6 = %c0 to %c32 step %c1 {
          %7 = memref.load %reinterpret_cast[%arg5, %arg6] : memref<32x32xf32, strided<[4096, 1], offset: ?>>
          memref.store %7, %reinterpret_cast_0[%arg5, %arg6] : memref<32x32xf32, strided<[4096, 1], offset: ?>>
        }
      }
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    scf.forall (%arg3, %arg4) in (128, 128) {
      %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %arg2 : memref<4096x4096xf32> -> memref<f32>, index, index, index, index, index
      %1 = arith.muli %arg3, %c131072 overflow<nsw> : index
      %2 = arith.muli %arg4, %c32 overflow<nsw> : index
      %3 = arith.addi %1, %2 : index
      %reinterpret_cast = memref.reinterpret_cast %base_buffer to offset: [%3], sizes: [32, 32], strides: [4096, 1] : memref<f32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      scf.forall (%arg5, %arg6) in (8, 8) {
        %alloca = memref.alloca() : memref<vector<4x4xf32>>
        %alloca_5 = memref.alloca() : memref<vector<4x4xf32>>
        %7 = arith.muli %arg3, %c131072 overflow<nsw> : index
        %8 = arith.muli %arg4, %c32 overflow<nsw> : index
        %9 = arith.addi %7, %8 : index
        %10 = arith.muli %arg5, %c16384 overflow<nsw> : index
        %11 = arith.muli %arg6, %c4 overflow<nsw> : index
        %12 = arith.addi %10, %11 : index
        %13 = arith.addi %12, %9 : index
        %reinterpret_cast_6 = memref.reinterpret_cast %alloc to offset: [%13], sizes: [4, 4], strides: [4096, 1] : memref<4096x4096xf32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %base_buffer_7, %offset_8, %sizes_9:2, %strides_10:2 = memref.extract_strided_metadata %arg2 : memref<4096x4096xf32> -> memref<f32>, index, index, index, index, index
        %14 = arith.muli %arg3, %c131072 overflow<nsw> : index
        %15 = arith.muli %arg4, %c32 overflow<nsw> : index
        %16 = arith.addi %14, %15 : index
        %17 = arith.muli %arg5, %c16384 overflow<nsw> : index
        %18 = arith.muli %arg6, %c4 overflow<nsw> : index
        %19 = arith.addi %17, %18 : index
        %20 = arith.addi %19, %16 : index
        %reinterpret_cast_11 = memref.reinterpret_cast %base_buffer_7 to offset: [%20], sizes: [4, 4], strides: [4096, 1] : memref<f32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %21 = vector.type_cast %alloca : memref<vector<4x4xf32>> to memref<4xvector<4xf32>>
        scf.for %arg7 = %c0 to %c4 step %c1 {
          %32 = vector.transfer_read %reinterpret_cast_6[%arg7, %c0], %0 {in_bounds = [true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4xf32>
          memref.store %32, %21[%arg7] : memref<4xvector<4xf32>>
        }
        %22 = memref.load %alloca[] : memref<vector<4x4xf32>>
        %23 = arith.addf %22, %cst : vector<4x4xf32>
        memref.store %23, %alloca_5[] : memref<vector<4x4xf32>>
        %24 = vector.type_cast %alloca_5 : memref<vector<4x4xf32>> to memref<4xvector<4xf32>>
        scf.for %arg7 = %c0 to %c4 step %c1 {
          %32 = memref.load %24[%arg7] : memref<4xvector<4xf32>>
          vector.transfer_write %32, %reinterpret_cast_11[%arg7, %c0] {in_bounds = [true]} : vector<4xf32>, memref<4x4xf32, strided<[4096, 1], offset: ?>>
        }
        %base_buffer_12, %offset_13, %sizes_14:2, %strides_15:2 = memref.extract_strided_metadata %arg2 : memref<4096x4096xf32> -> memref<f32>, index, index, index, index, index
        %25 = arith.muli %arg3, %c131072 overflow<nsw> : index
        %26 = arith.muli %arg4, %c32 overflow<nsw> : index
        %27 = arith.addi %25, %26 : index
        %28 = arith.muli %arg5, %c16384 overflow<nsw> : index
        %29 = arith.muli %arg6, %c4 overflow<nsw> : index
        %30 = arith.addi %28, %29 : index
        %31 = arith.addi %30, %27 : index
        %reinterpret_cast_16 = memref.reinterpret_cast %base_buffer_12 to offset: [%31], sizes: [4, 4], strides: [4096, 1] : memref<f32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        scf.for %arg7 = %c0 to %c4 step %c1 {
          scf.for %arg8 = %c0 to %c4 step %c1 {
            %32 = memref.load %reinterpret_cast_11[%arg7, %arg8] : memref<4x4xf32, strided<[4096, 1], offset: ?>>
            memref.store %32, %reinterpret_cast_16[%arg7, %arg8] : memref<4x4xf32, strided<[4096, 1], offset: ?>>
          }
        }
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      %base_buffer_0, %offset_1, %sizes_2:2, %strides_3:2 = memref.extract_strided_metadata %arg2 : memref<4096x4096xf32> -> memref<f32>, index, index, index, index, index
      %4 = arith.muli %arg3, %c131072 overflow<nsw> : index
      %5 = arith.muli %arg4, %c32 overflow<nsw> : index
      %6 = arith.addi %4, %5 : index
      %reinterpret_cast_4 = memref.reinterpret_cast %base_buffer_0 to offset: [%6], sizes: [32, 32], strides: [4096, 1] : memref<f32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      scf.for %arg5 = %c0 to %c32 step %c1 {
        scf.for %arg6 = %c0 to %c32 step %c1 {
          %7 = memref.load %reinterpret_cast[%arg5, %arg6] : memref<32x32xf32, strided<[4096, 1], offset: ?>>
          memref.store %7, %reinterpret_cast_4[%arg5, %arg6] : memref<32x32xf32, strided<[4096, 1], offset: ?>>
        }
      }
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    return
  }
}

