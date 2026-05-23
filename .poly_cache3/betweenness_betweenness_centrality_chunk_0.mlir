module {
  func.func @betweenness_betweenness_centrality_chunk_0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr, %arg4: !llvm.ptr, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: !llvm.ptr, %arg8: i64) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c-1_i64 = arith.constant -1 : i64
    %cst = arith.constant 0.000000e+00 : f64
    %cst_0 = arith.constant 1.000000e+00 : f64
    %0 = arith.index_cast %arg8 : i64 to index
    %c1_i64 = arith.constant 1 : i64
    scf.for %arg9 = %c0 to %0 step %c1 {
      scf.for %arg10 = %c0 to %0 step %c1 {
        %9 = arith.index_cast %arg10 : index to i64
        %10 = llvm.getelementptr %arg3[%9] : (!llvm.ptr, i64) -> !llvm.ptr, f64
        llvm.store %c-1_i64, %10 : i64, !llvm.ptr
        %11 = arith.index_cast %arg10 : index to i64
        %12 = llvm.getelementptr %arg4[%11] : (!llvm.ptr, i64) -> !llvm.ptr, f64
        llvm.store %cst, %12 : f64, !llvm.ptr
        %13 = arith.index_cast %arg10 : index to i64
        %14 = llvm.getelementptr %arg7[%13] : (!llvm.ptr, i64) -> !llvm.ptr, f64
        llvm.store %cst, %14 : f64, !llvm.ptr
      }
      %1 = arith.index_cast %arg9 : index to i64
      %2 = llvm.getelementptr %arg4[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      llvm.store %cst_0, %2 : f64, !llvm.ptr
      %3 = arith.index_cast %arg9 : index to i64
      %4 = llvm.getelementptr %arg3[%3] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %c0_i64 = arith.constant 0 : i64
      llvm.store %c0_i64, %4 : i64, !llvm.ptr
      %5 = arith.index_cast %c0 : index to i64
      %6 = llvm.getelementptr %arg6[%5] : (!llvm.ptr, i64) -> !llvm.ptr, f64
      %7 = arith.index_cast %arg9 : index to i64
      llvm.store %7, %6 : i64, !llvm.ptr
      %8:3 = scf.for %arg10 = %c0 to %0 step %c1 iter_args(%arg11 = %c0, %arg12 = %c1, %arg13 = %c0) -> (index, index, index) {
        %9 = arith.cmpi eq, %arg11, %arg12 : index
        %10:3 = scf.if %9 -> (index, index, index) {
          scf.yield %arg11, %arg12, %arg13 : index, index, index
        } else {
          %11 = arith.index_cast %arg11 : index to i64
          %12 = llvm.getelementptr %arg6[%11] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %13 = llvm.load %12 : !llvm.ptr -> i64
          %14 = arith.index_cast %13 : i64 to index
          %15 = arith.index_cast %arg13 : index to i64
          %16 = llvm.getelementptr %arg5[%15] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          llvm.store %13, %16 : i64, !llvm.ptr
          %17 = arith.addi %arg13, %c1 : index
          %18 = arith.index_cast %14 : index to i64
          %19 = llvm.getelementptr %arg3[%18] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %20 = llvm.load %19 : !llvm.ptr -> i64
          %21 = arith.addi %20, %c1_i64 : i64
          %22 = arith.index_cast %14 : index to i64
          %23 = llvm.getelementptr %arg4[%22] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %24 = llvm.load %23 : !llvm.ptr -> f64
          %25 = arith.index_cast %14 : index to i64
          %26 = llvm.getelementptr %arg1[%25] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %27 = llvm.load %26 : !llvm.ptr -> i64
          %28 = arith.index_cast %27 : i64 to index
          %29 = arith.addi %14, %c1 : index
          %30 = arith.index_cast %29 : index to i64
          %31 = llvm.getelementptr %arg1[%30] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %32 = llvm.load %31 : !llvm.ptr -> i64
          %33 = arith.index_cast %32 : i64 to index
          %34 = scf.for %arg14 = %28 to %33 step %c1 iter_args(%arg15 = %arg12) -> (index) {
            %36 = arith.index_cast %arg14 : index to i64
            %37 = llvm.getelementptr %arg2[%36] : (!llvm.ptr, i64) -> !llvm.ptr, f64
            %38 = llvm.load %37 : !llvm.ptr -> i64
            %39 = arith.index_cast %38 : i64 to index
            %40 = arith.index_cast %39 : index to i64
            %41 = llvm.getelementptr %arg3[%40] : (!llvm.ptr, i64) -> !llvm.ptr, f64
            %42 = llvm.load %41 : !llvm.ptr -> i64
            %43 = arith.cmpi eq, %42, %c-1_i64 : i64
            %44 = scf.if %43 -> (index) {
              llvm.store %21, %41 : i64, !llvm.ptr
              %47 = arith.index_cast %arg15 : index to i64
              %48 = llvm.getelementptr %arg6[%47] : (!llvm.ptr, i64) -> !llvm.ptr, f64
              llvm.store %38, %48 : i64, !llvm.ptr
              %49 = arith.addi %arg15, %c1 : index
              scf.yield %49 : index
            } else {
              scf.yield %arg15 : index
            }
            %45 = llvm.load %41 : !llvm.ptr -> i64
            %46 = arith.cmpi eq, %45, %21 : i64
            scf.if %46 {
              %47 = arith.index_cast %39 : index to i64
              %48 = llvm.getelementptr %arg4[%47] : (!llvm.ptr, i64) -> !llvm.ptr, f64
              %49 = llvm.load %48 : !llvm.ptr -> f64
              %50 = arith.addf %49, %24 : f64
              llvm.store %50, %48 : f64, !llvm.ptr
            } else {
            }
            scf.yield %44 : index
          }
          %35 = arith.addi %arg11, %c1 : index
          scf.yield %35, %34, %17 : index, index, index
        }
        scf.yield %10#0, %10#1, %10#2 : index, index, index
      }
      scf.for %arg10 = %c0 to %8#2 step %c1 {
        %9 = arith.subi %8#2, %c1 : index
        %10 = arith.subi %9, %arg10 : index
        %11 = arith.index_cast %10 : index to i64
        %12 = llvm.getelementptr %arg5[%11] : (!llvm.ptr, i64) -> !llvm.ptr, f64
        %13 = llvm.load %12 : !llvm.ptr -> i64
        %14 = arith.index_cast %13 : i64 to index
        %15 = arith.index_cast %14 : index to i64
        %16 = llvm.getelementptr %arg3[%15] : (!llvm.ptr, i64) -> !llvm.ptr, f64
        %17 = llvm.load %16 : !llvm.ptr -> i64
        %18 = arith.subi %17, %c1_i64 : i64
        %19 = arith.index_cast %14 : index to i64
        %20 = llvm.getelementptr %arg7[%19] : (!llvm.ptr, i64) -> !llvm.ptr, f64
        %21 = llvm.load %20 : !llvm.ptr -> f64
        %22 = arith.index_cast %14 : index to i64
        %23 = llvm.getelementptr %arg4[%22] : (!llvm.ptr, i64) -> !llvm.ptr, f64
        %24 = llvm.load %23 : !llvm.ptr -> f64
        %25 = arith.addf %cst_0, %21 : f64
        %26 = arith.divf %25, %24 : f64
        %27 = arith.index_cast %14 : index to i64
        %28 = llvm.getelementptr %arg1[%27] : (!llvm.ptr, i64) -> !llvm.ptr, f64
        %29 = llvm.load %28 : !llvm.ptr -> i64
        %30 = arith.index_cast %29 : i64 to index
        %31 = arith.addi %14, %c1 : index
        %32 = arith.index_cast %31 : index to i64
        %33 = llvm.getelementptr %arg1[%32] : (!llvm.ptr, i64) -> !llvm.ptr, f64
        %34 = llvm.load %33 : !llvm.ptr -> i64
        %35 = arith.index_cast %34 : i64 to index
        scf.for %arg11 = %30 to %35 step %c1 {
          %37 = arith.index_cast %arg11 : index to i64
          %38 = llvm.getelementptr %arg2[%37] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %39 = llvm.load %38 : !llvm.ptr -> i64
          %40 = arith.index_cast %39 : i64 to index
          %41 = arith.index_cast %40 : index to i64
          %42 = llvm.getelementptr %arg3[%41] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %43 = llvm.load %42 : !llvm.ptr -> i64
          %44 = arith.cmpi eq, %43, %18 : i64
          scf.if %44 {
            %45 = arith.index_cast %40 : index to i64
            %46 = llvm.getelementptr %arg4[%45] : (!llvm.ptr, i64) -> !llvm.ptr, f64
            %47 = llvm.load %46 : !llvm.ptr -> f64
            %48 = arith.mulf %47, %26 : f64
            %49 = arith.index_cast %40 : index to i64
            %50 = llvm.getelementptr %arg7[%49] : (!llvm.ptr, i64) -> !llvm.ptr, f64
            %51 = llvm.load %50 : !llvm.ptr -> f64
            %52 = arith.addf %51, %48 : f64
            llvm.store %52, %50 : f64, !llvm.ptr
          } else {
          }
        }
        %36 = arith.cmpi ne, %14, %arg9 : index
        scf.if %36 {
          %37 = arith.index_cast %14 : index to i64
          %38 = llvm.getelementptr %arg0[%37] : (!llvm.ptr, i64) -> !llvm.ptr, f64
          %39 = llvm.load %38 : !llvm.ptr -> f64
          %40 = arith.addf %39, %21 : f64
          llvm.store %40, %38 : f64, !llvm.ptr
        } else {
        }
      }
    }
    return
  }
}
