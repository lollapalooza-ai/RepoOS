module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: memref<4096x4096xf32>, %arg1: memref<4096x4096xf32>, %arg2: memref<4096x4096xf32>) {
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
      %c131072 = arith.constant 131072 : index
      %1 = arith.muli %arg3, %c131072 overflow<nsw> : index
      %c32_0 = arith.constant 32 : index
      %2 = arith.muli %arg4, %c32_0 overflow<nsw> : index
      %3 = arith.addi %1, %2 : index
      %reinterpret_cast = memref.reinterpret_cast %alloc to offset: [%3], sizes: [32, 32], strides: [4096, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      scf.forall (%arg5, %arg6) in (8, 8) {
        %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %arg0 : memref<4096x4096xf32> -> memref<f32>, index, index, index, index, index
        %c131072_4 = arith.constant 131072 : index
        %7 = arith.muli %arg3, %c131072_4 overflow<nsw> : index
        %c32_5 = arith.constant 32 : index
        %8 = arith.muli %arg4, %c32_5 overflow<nsw> : index
        %9 = arith.addi %7, %8 : index
        %c16384 = arith.constant 16384 : index
        %10 = arith.muli %arg5, %c16384 overflow<nsw> : index
        %c4_6 = arith.constant 4 : index
        %11 = arith.muli %arg6, %c4_6 overflow<nsw> : index
        %12 = arith.addi %10, %11 : index
        %13 = arith.addi %12, %9 : index
        %reinterpret_cast_7 = memref.reinterpret_cast %base_buffer to offset: [%13], sizes: [4, 4], strides: [4096, 1] : memref<f32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %base_buffer_8, %offset_9, %sizes_10:2, %strides_11:2 = memref.extract_strided_metadata %arg1 : memref<4096x4096xf32> -> memref<f32>, index, index, index, index, index
        %c131072_12 = arith.constant 131072 : index
        %14 = arith.muli %arg3, %c131072_12 overflow<nsw> : index
        %c32_13 = arith.constant 32 : index
        %15 = arith.muli %arg4, %c32_13 overflow<nsw> : index
        %16 = arith.addi %14, %15 : index
        %c16384_14 = arith.constant 16384 : index
        %17 = arith.muli %arg5, %c16384_14 overflow<nsw> : index
        %c4_15 = arith.constant 4 : index
        %18 = arith.muli %arg6, %c4_15 overflow<nsw> : index
        %19 = arith.addi %17, %18 : index
        %20 = arith.addi %19, %16 : index
        %reinterpret_cast_16 = memref.reinterpret_cast %base_buffer_8 to offset: [%20], sizes: [4, 4], strides: [4096, 1] : memref<f32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %c131072_17 = arith.constant 131072 : index
        %21 = arith.muli %arg3, %c131072_17 overflow<nsw> : index
        %c32_18 = arith.constant 32 : index
        %22 = arith.muli %arg4, %c32_18 overflow<nsw> : index
        %23 = arith.addi %21, %22 : index
        %c16384_19 = arith.constant 16384 : index
        %24 = arith.muli %arg5, %c16384_19 overflow<nsw> : index
        %c4_20 = arith.constant 4 : index
        %25 = arith.muli %arg6, %c4_20 overflow<nsw> : index
        %26 = arith.addi %24, %25 : index
        %27 = arith.addi %26, %23 : index
        %reinterpret_cast_21 = memref.reinterpret_cast %alloc to offset: [%27], sizes: [4, 4], strides: [4096, 1] : memref<4096x4096xf32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %28 = vector.transfer_read %reinterpret_cast_7[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4x4xf32>
        %29 = vector.transfer_read %reinterpret_cast_16[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4x4xf32>
        %30 = arith.mulf %28, %29 : vector<4x4xf32>
        vector.transfer_write %30, %reinterpret_cast_21[%c0, %c0] {in_bounds = [true, true]} : vector<4x4xf32>, memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %c131072_22 = arith.constant 131072 : index
        %31 = arith.muli %arg3, %c131072_22 overflow<nsw> : index
        %c32_23 = arith.constant 32 : index
        %32 = arith.muli %arg4, %c32_23 overflow<nsw> : index
        %33 = arith.addi %31, %32 : index
        %c16384_24 = arith.constant 16384 : index
        %34 = arith.muli %arg5, %c16384_24 overflow<nsw> : index
        %c4_25 = arith.constant 4 : index
        %35 = arith.muli %arg6, %c4_25 overflow<nsw> : index
        %36 = arith.addi %34, %35 : index
        %37 = arith.addi %36, %33 : index
        %reinterpret_cast_26 = memref.reinterpret_cast %alloc to offset: [%37], sizes: [4, 4], strides: [4096, 1] : memref<4096x4096xf32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        scf.for %arg7 = %c0 to %c4 step %c1 {
          scf.for %arg8 = %c0 to %c4 step %c1 {
            %38 = memref.load %reinterpret_cast_21[%arg7, %arg8] : memref<4x4xf32, strided<[4096, 1], offset: ?>>
            memref.store %38, %reinterpret_cast_26[%arg7, %arg8] : memref<4x4xf32, strided<[4096, 1], offset: ?>>
          }
        }
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      %c131072_1 = arith.constant 131072 : index
      %4 = arith.muli %arg3, %c131072_1 overflow<nsw> : index
      %c32_2 = arith.constant 32 : index
      %5 = arith.muli %arg4, %c32_2 overflow<nsw> : index
      %6 = arith.addi %4, %5 : index
      %reinterpret_cast_3 = memref.reinterpret_cast %alloc to offset: [%6], sizes: [32, 32], strides: [4096, 1] : memref<4096x4096xf32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      scf.for %arg5 = %c0 to %c32 step %c1 {
        scf.for %arg6 = %c0 to %c32 step %c1 {
          %7 = memref.load %reinterpret_cast[%arg5, %arg6] : memref<32x32xf32, strided<[4096, 1], offset: ?>>
          memref.store %7, %reinterpret_cast_3[%arg5, %arg6] : memref<32x32xf32, strided<[4096, 1], offset: ?>>
        }
      }
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    scf.forall (%arg3, %arg4) in (128, 128) {
      %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %arg2 : memref<4096x4096xf32> -> memref<f32>, index, index, index, index, index
      %c131072 = arith.constant 131072 : index
      %1 = arith.muli %arg3, %c131072 overflow<nsw> : index
      %c32_0 = arith.constant 32 : index
      %2 = arith.muli %arg4, %c32_0 overflow<nsw> : index
      %3 = arith.addi %1, %2 : index
      %reinterpret_cast = memref.reinterpret_cast %base_buffer to offset: [%3], sizes: [32, 32], strides: [4096, 1] : memref<f32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      scf.forall (%arg5, %arg6) in (8, 8) {
        %c131072_8 = arith.constant 131072 : index
        %7 = arith.muli %arg3, %c131072_8 overflow<nsw> : index
        %c32_9 = arith.constant 32 : index
        %8 = arith.muli %arg4, %c32_9 overflow<nsw> : index
        %9 = arith.addi %7, %8 : index
        %c16384 = arith.constant 16384 : index
        %10 = arith.muli %arg5, %c16384 overflow<nsw> : index
        %c4_10 = arith.constant 4 : index
        %11 = arith.muli %arg6, %c4_10 overflow<nsw> : index
        %12 = arith.addi %10, %11 : index
        %13 = arith.addi %12, %9 : index
        %reinterpret_cast_11 = memref.reinterpret_cast %alloc to offset: [%13], sizes: [4, 4], strides: [4096, 1] : memref<4096x4096xf32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %base_buffer_12, %offset_13, %sizes_14:2, %strides_15:2 = memref.extract_strided_metadata %arg2 : memref<4096x4096xf32> -> memref<f32>, index, index, index, index, index
        %c131072_16 = arith.constant 131072 : index
        %14 = arith.muli %arg3, %c131072_16 overflow<nsw> : index
        %c32_17 = arith.constant 32 : index
        %15 = arith.muli %arg4, %c32_17 overflow<nsw> : index
        %16 = arith.addi %14, %15 : index
        %c16384_18 = arith.constant 16384 : index
        %17 = arith.muli %arg5, %c16384_18 overflow<nsw> : index
        %c4_19 = arith.constant 4 : index
        %18 = arith.muli %arg6, %c4_19 overflow<nsw> : index
        %19 = arith.addi %17, %18 : index
        %20 = arith.addi %19, %16 : index
        %reinterpret_cast_20 = memref.reinterpret_cast %base_buffer_12 to offset: [%20], sizes: [4, 4], strides: [4096, 1] : memref<f32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %21 = vector.transfer_read %reinterpret_cast_11[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x4xf32, strided<[4096, 1], offset: ?>>, vector<4x4xf32>
        %22 = arith.addf %21, %cst : vector<4x4xf32>
        vector.transfer_write %22, %reinterpret_cast_20[%c0, %c0] {in_bounds = [true, true]} : vector<4x4xf32>, memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %base_buffer_21, %offset_22, %sizes_23:2, %strides_24:2 = memref.extract_strided_metadata %arg2 : memref<4096x4096xf32> -> memref<f32>, index, index, index, index, index
        %c131072_25 = arith.constant 131072 : index
        %23 = arith.muli %arg3, %c131072_25 overflow<nsw> : index
        %c32_26 = arith.constant 32 : index
        %24 = arith.muli %arg4, %c32_26 overflow<nsw> : index
        %25 = arith.addi %23, %24 : index
        %c16384_27 = arith.constant 16384 : index
        %26 = arith.muli %arg5, %c16384_27 overflow<nsw> : index
        %c4_28 = arith.constant 4 : index
        %27 = arith.muli %arg6, %c4_28 overflow<nsw> : index
        %28 = arith.addi %26, %27 : index
        %29 = arith.addi %28, %25 : index
        %reinterpret_cast_29 = memref.reinterpret_cast %base_buffer_21 to offset: [%29], sizes: [4, 4], strides: [4096, 1] : memref<f32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        scf.for %arg7 = %c0 to %c4 step %c1 {
          scf.for %arg8 = %c0 to %c4 step %c1 {
            %30 = memref.load %reinterpret_cast_20[%arg7, %arg8] : memref<4x4xf32, strided<[4096, 1], offset: ?>>
            memref.store %30, %reinterpret_cast_29[%arg7, %arg8] : memref<4x4xf32, strided<[4096, 1], offset: ?>>
          }
        }
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      %base_buffer_1, %offset_2, %sizes_3:2, %strides_4:2 = memref.extract_strided_metadata %arg2 : memref<4096x4096xf32> -> memref<f32>, index, index, index, index, index
      %c131072_5 = arith.constant 131072 : index
      %4 = arith.muli %arg3, %c131072_5 overflow<nsw> : index
      %c32_6 = arith.constant 32 : index
      %5 = arith.muli %arg4, %c32_6 overflow<nsw> : index
      %6 = arith.addi %4, %5 : index
      %reinterpret_cast_7 = memref.reinterpret_cast %base_buffer_1 to offset: [%6], sizes: [32, 32], strides: [4096, 1] : memref<f32> to memref<32x32xf32, strided<[4096, 1], offset: ?>>
      scf.for %arg5 = %c0 to %c32 step %c1 {
        scf.for %arg6 = %c0 to %c32 step %c1 {
          %7 = memref.load %reinterpret_cast[%arg5, %arg6] : memref<32x32xf32, strided<[4096, 1], offset: ?>>
          memref.store %7, %reinterpret_cast_7[%arg5, %arg6] : memref<32x32xf32, strided<[4096, 1], offset: ?>>
        }
      }
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    return
  }
}

