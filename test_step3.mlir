module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: memref<4096x4096xf32>, %arg1: memref<4096x4096xf32>, %arg2: memref<4096x4096xf32>) {
    %c16384 = arith.constant 16384 : index
    %c131072 = arith.constant 131072 : index
    %c32 = arith.constant 32 : index
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    %c4096 = arith.constant 4096 : index
    %cst = arith.constant dense<2.000000e+00> : vector<4x4xf32>
    %c0 = arith.constant 0 : index
    %0 = builtin.unrealized_conversion_cast %c0 : index to i64
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
        %7 = builtin.unrealized_conversion_cast %alloca : memref<vector<4x4xf32>> to !llvm.struct<(ptr, ptr, i64)>
        %alloca_1 = memref.alloca() : memref<vector<4x4xf32>>
        %8 = builtin.unrealized_conversion_cast %alloca_1 : memref<vector<4x4xf32>> to !llvm.struct<(ptr, ptr, i64)>
        %alloca_2 = memref.alloca() : memref<vector<4x4xf32>>
        %9 = builtin.unrealized_conversion_cast %alloca_2 : memref<vector<4x4xf32>> to !llvm.struct<(ptr, ptr, i64)>
        %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %arg0 : memref<4096x4096xf32> -> memref<f32>, index, index, index, index, index
        %10 = arith.muli %arg3, %c131072 overflow<nsw> : index
        %11 = arith.muli %arg4, %c32 overflow<nsw> : index
        %12 = arith.addi %10, %11 : index
        %13 = arith.muli %arg5, %c16384 overflow<nsw> : index
        %14 = arith.muli %arg6, %c4 overflow<nsw> : index
        %15 = arith.addi %13, %14 : index
        %16 = arith.addi %15, %12 : index
        %reinterpret_cast_3 = memref.reinterpret_cast %base_buffer to offset: [%16], sizes: [4, 4], strides: [4096, 1] : memref<f32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %17 = builtin.unrealized_conversion_cast %reinterpret_cast_3 : memref<4x4xf32, strided<[4096, 1], offset: ?>> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
        %base_buffer_4, %offset_5, %sizes_6:2, %strides_7:2 = memref.extract_strided_metadata %arg1 : memref<4096x4096xf32> -> memref<f32>, index, index, index, index, index
        %18 = arith.muli %arg3, %c131072 overflow<nsw> : index
        %19 = arith.muli %arg4, %c32 overflow<nsw> : index
        %20 = arith.addi %18, %19 : index
        %21 = arith.muli %arg5, %c16384 overflow<nsw> : index
        %22 = arith.muli %arg6, %c4 overflow<nsw> : index
        %23 = arith.addi %21, %22 : index
        %24 = arith.addi %23, %20 : index
        %reinterpret_cast_8 = memref.reinterpret_cast %base_buffer_4 to offset: [%24], sizes: [4, 4], strides: [4096, 1] : memref<f32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %25 = builtin.unrealized_conversion_cast %reinterpret_cast_8 : memref<4x4xf32, strided<[4096, 1], offset: ?>> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
        %26 = arith.muli %arg3, %c131072 overflow<nsw> : index
        %27 = arith.muli %arg4, %c32 overflow<nsw> : index
        %28 = arith.addi %26, %27 : index
        %29 = arith.muli %arg5, %c16384 overflow<nsw> : index
        %30 = arith.muli %arg6, %c4 overflow<nsw> : index
        %31 = arith.addi %29, %30 : index
        %32 = arith.addi %31, %28 : index
        %reinterpret_cast_9 = memref.reinterpret_cast %alloc to offset: [%32], sizes: [4, 4], strides: [4096, 1] : memref<4096x4096xf32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %33 = builtin.unrealized_conversion_cast %reinterpret_cast_9 : memref<4x4xf32, strided<[4096, 1], offset: ?>> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
        %34 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
        %35 = llvm.extractvalue %7[0] : !llvm.struct<(ptr, ptr, i64)> 
        %36 = llvm.insertvalue %35, %34[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %37 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64)> 
        %38 = llvm.insertvalue %37, %36[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %39 = llvm.mlir.constant(0 : index) : i64
        %40 = llvm.insertvalue %39, %38[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %41 = llvm.mlir.constant(4 : index) : i64
        %42 = llvm.insertvalue %41, %40[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %43 = llvm.mlir.constant(1 : index) : i64
        %44 = llvm.insertvalue %43, %42[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %45 = builtin.unrealized_conversion_cast %44 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<4xvector<4xf32>>
        scf.for %arg7 = %c0 to %c4 step %c1 {
          %80 = builtin.unrealized_conversion_cast %arg7 : index to i64
          %81 = llvm.extractvalue %17[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %82 = llvm.extractvalue %17[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %83 = llvm.getelementptr %81[%82] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          %84 = llvm.mlir.constant(4096 : index) : i64
          %85 = llvm.mul %80, %84 : i64
          %86 = llvm.add %85, %0 : i64
          %87 = llvm.getelementptr %83[%86] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          %88 = llvm.load %87 {alignment = 4 : i64} : !llvm.ptr -> vector<4xf32>
          memref.store %88, %45[%arg7] : memref<4xvector<4xf32>>
        }
        %46 = memref.load %alloca[] : memref<vector<4x4xf32>>
        %47 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
        %48 = llvm.extractvalue %8[0] : !llvm.struct<(ptr, ptr, i64)> 
        %49 = llvm.insertvalue %48, %47[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %50 = llvm.extractvalue %8[1] : !llvm.struct<(ptr, ptr, i64)> 
        %51 = llvm.insertvalue %50, %49[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %52 = llvm.mlir.constant(0 : index) : i64
        %53 = llvm.insertvalue %52, %51[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %54 = llvm.mlir.constant(4 : index) : i64
        %55 = llvm.insertvalue %54, %53[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %56 = llvm.mlir.constant(1 : index) : i64
        %57 = llvm.insertvalue %56, %55[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %58 = builtin.unrealized_conversion_cast %57 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<4xvector<4xf32>>
        scf.for %arg7 = %c0 to %c4 step %c1 {
          %80 = builtin.unrealized_conversion_cast %arg7 : index to i64
          %81 = llvm.extractvalue %25[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %82 = llvm.extractvalue %25[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %83 = llvm.getelementptr %81[%82] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          %84 = llvm.mlir.constant(4096 : index) : i64
          %85 = llvm.mul %80, %84 : i64
          %86 = llvm.add %85, %0 : i64
          %87 = llvm.getelementptr %83[%86] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          %88 = llvm.load %87 {alignment = 4 : i64} : !llvm.ptr -> vector<4xf32>
          memref.store %88, %58[%arg7] : memref<4xvector<4xf32>>
        }
        %59 = memref.load %alloca_1[] : memref<vector<4x4xf32>>
        %60 = arith.mulf %46, %59 : vector<4x4xf32>
        memref.store %60, %alloca_2[] : memref<vector<4x4xf32>>
        %61 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
        %62 = llvm.extractvalue %9[0] : !llvm.struct<(ptr, ptr, i64)> 
        %63 = llvm.insertvalue %62, %61[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %64 = llvm.extractvalue %9[1] : !llvm.struct<(ptr, ptr, i64)> 
        %65 = llvm.insertvalue %64, %63[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %66 = llvm.mlir.constant(0 : index) : i64
        %67 = llvm.insertvalue %66, %65[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %68 = llvm.mlir.constant(4 : index) : i64
        %69 = llvm.insertvalue %68, %67[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %70 = llvm.mlir.constant(1 : index) : i64
        %71 = llvm.insertvalue %70, %69[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %72 = builtin.unrealized_conversion_cast %71 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<4xvector<4xf32>>
        scf.for %arg7 = %c0 to %c4 step %c1 {
          %80 = builtin.unrealized_conversion_cast %arg7 : index to i64
          %81 = memref.load %72[%arg7] : memref<4xvector<4xf32>>
          %82 = llvm.extractvalue %33[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %83 = llvm.extractvalue %33[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %84 = llvm.getelementptr %82[%83] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          %85 = llvm.mlir.constant(4096 : index) : i64
          %86 = llvm.mul %80, %85 : i64
          %87 = llvm.add %86, %0 : i64
          %88 = llvm.getelementptr %84[%87] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          llvm.store %81, %88 {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr
        }
        %73 = arith.muli %arg3, %c131072 overflow<nsw> : index
        %74 = arith.muli %arg4, %c32 overflow<nsw> : index
        %75 = arith.addi %73, %74 : index
        %76 = arith.muli %arg5, %c16384 overflow<nsw> : index
        %77 = arith.muli %arg6, %c4 overflow<nsw> : index
        %78 = arith.addi %76, %77 : index
        %79 = arith.addi %78, %75 : index
        %reinterpret_cast_10 = memref.reinterpret_cast %alloc to offset: [%79], sizes: [4, 4], strides: [4096, 1] : memref<4096x4096xf32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        scf.for %arg7 = %c0 to %c4 step %c1 {
          scf.for %arg8 = %c0 to %c4 step %c1 {
            %80 = memref.load %reinterpret_cast_9[%arg7, %arg8] : memref<4x4xf32, strided<[4096, 1], offset: ?>>
            memref.store %80, %reinterpret_cast_10[%arg7, %arg8] : memref<4x4xf32, strided<[4096, 1], offset: ?>>
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
        %7 = builtin.unrealized_conversion_cast %alloca : memref<vector<4x4xf32>> to !llvm.struct<(ptr, ptr, i64)>
        %alloca_5 = memref.alloca() : memref<vector<4x4xf32>>
        %8 = builtin.unrealized_conversion_cast %alloca_5 : memref<vector<4x4xf32>> to !llvm.struct<(ptr, ptr, i64)>
        %9 = arith.muli %arg3, %c131072 overflow<nsw> : index
        %10 = arith.muli %arg4, %c32 overflow<nsw> : index
        %11 = arith.addi %9, %10 : index
        %12 = arith.muli %arg5, %c16384 overflow<nsw> : index
        %13 = arith.muli %arg6, %c4 overflow<nsw> : index
        %14 = arith.addi %12, %13 : index
        %15 = arith.addi %14, %11 : index
        %reinterpret_cast_6 = memref.reinterpret_cast %alloc to offset: [%15], sizes: [4, 4], strides: [4096, 1] : memref<4096x4096xf32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %16 = builtin.unrealized_conversion_cast %reinterpret_cast_6 : memref<4x4xf32, strided<[4096, 1], offset: ?>> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
        %base_buffer_7, %offset_8, %sizes_9:2, %strides_10:2 = memref.extract_strided_metadata %arg2 : memref<4096x4096xf32> -> memref<f32>, index, index, index, index, index
        %17 = arith.muli %arg3, %c131072 overflow<nsw> : index
        %18 = arith.muli %arg4, %c32 overflow<nsw> : index
        %19 = arith.addi %17, %18 : index
        %20 = arith.muli %arg5, %c16384 overflow<nsw> : index
        %21 = arith.muli %arg6, %c4 overflow<nsw> : index
        %22 = arith.addi %20, %21 : index
        %23 = arith.addi %22, %19 : index
        %reinterpret_cast_11 = memref.reinterpret_cast %base_buffer_7 to offset: [%23], sizes: [4, 4], strides: [4096, 1] : memref<f32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        %24 = builtin.unrealized_conversion_cast %reinterpret_cast_11 : memref<4x4xf32, strided<[4096, 1], offset: ?>> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
        %25 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
        %26 = llvm.extractvalue %7[0] : !llvm.struct<(ptr, ptr, i64)> 
        %27 = llvm.insertvalue %26, %25[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %28 = llvm.extractvalue %7[1] : !llvm.struct<(ptr, ptr, i64)> 
        %29 = llvm.insertvalue %28, %27[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %30 = llvm.mlir.constant(0 : index) : i64
        %31 = llvm.insertvalue %30, %29[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %32 = llvm.mlir.constant(4 : index) : i64
        %33 = llvm.insertvalue %32, %31[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %34 = llvm.mlir.constant(1 : index) : i64
        %35 = llvm.insertvalue %34, %33[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %36 = builtin.unrealized_conversion_cast %35 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<4xvector<4xf32>>
        scf.for %arg7 = %c0 to %c4 step %c1 {
          %58 = builtin.unrealized_conversion_cast %arg7 : index to i64
          %59 = llvm.extractvalue %16[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %60 = llvm.extractvalue %16[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %61 = llvm.getelementptr %59[%60] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          %62 = llvm.mlir.constant(4096 : index) : i64
          %63 = llvm.mul %58, %62 : i64
          %64 = llvm.add %63, %0 : i64
          %65 = llvm.getelementptr %61[%64] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          %66 = llvm.load %65 {alignment = 4 : i64} : !llvm.ptr -> vector<4xf32>
          memref.store %66, %36[%arg7] : memref<4xvector<4xf32>>
        }
        %37 = memref.load %alloca[] : memref<vector<4x4xf32>>
        %38 = arith.addf %37, %cst : vector<4x4xf32>
        memref.store %38, %alloca_5[] : memref<vector<4x4xf32>>
        %39 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
        %40 = llvm.extractvalue %8[0] : !llvm.struct<(ptr, ptr, i64)> 
        %41 = llvm.insertvalue %40, %39[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %42 = llvm.extractvalue %8[1] : !llvm.struct<(ptr, ptr, i64)> 
        %43 = llvm.insertvalue %42, %41[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %44 = llvm.mlir.constant(0 : index) : i64
        %45 = llvm.insertvalue %44, %43[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %46 = llvm.mlir.constant(4 : index) : i64
        %47 = llvm.insertvalue %46, %45[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %48 = llvm.mlir.constant(1 : index) : i64
        %49 = llvm.insertvalue %48, %47[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
        %50 = builtin.unrealized_conversion_cast %49 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<4xvector<4xf32>>
        scf.for %arg7 = %c0 to %c4 step %c1 {
          %58 = builtin.unrealized_conversion_cast %arg7 : index to i64
          %59 = memref.load %50[%arg7] : memref<4xvector<4xf32>>
          %60 = llvm.extractvalue %24[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %61 = llvm.extractvalue %24[2] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
          %62 = llvm.getelementptr %60[%61] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          %63 = llvm.mlir.constant(4096 : index) : i64
          %64 = llvm.mul %58, %63 : i64
          %65 = llvm.add %64, %0 : i64
          %66 = llvm.getelementptr %62[%65] : (!llvm.ptr, i64) -> !llvm.ptr, f32
          llvm.store %59, %66 {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr
        }
        %base_buffer_12, %offset_13, %sizes_14:2, %strides_15:2 = memref.extract_strided_metadata %arg2 : memref<4096x4096xf32> -> memref<f32>, index, index, index, index, index
        %51 = arith.muli %arg3, %c131072 overflow<nsw> : index
        %52 = arith.muli %arg4, %c32 overflow<nsw> : index
        %53 = arith.addi %51, %52 : index
        %54 = arith.muli %arg5, %c16384 overflow<nsw> : index
        %55 = arith.muli %arg6, %c4 overflow<nsw> : index
        %56 = arith.addi %54, %55 : index
        %57 = arith.addi %56, %53 : index
        %reinterpret_cast_16 = memref.reinterpret_cast %base_buffer_12 to offset: [%57], sizes: [4, 4], strides: [4096, 1] : memref<f32> to memref<4x4xf32, strided<[4096, 1], offset: ?>>
        scf.for %arg7 = %c0 to %c4 step %c1 {
          scf.for %arg8 = %c0 to %c4 step %c1 {
            %58 = memref.load %reinterpret_cast_11[%arg7, %arg8] : memref<4x4xf32, strided<[4096, 1], offset: ?>>
            memref.store %58, %reinterpret_cast_16[%arg7, %arg8] : memref<4x4xf32, strided<[4096, 1], offset: ?>>
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

