module {
  llvm.func @networkx_algorithms_centrality_betweenness_betweenness_centrality_chunk_0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr, %arg4: !llvm.ptr, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: !llvm.ptr, %arg8: i64) attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : index) : i64
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mlir.constant(-1 : i64) : i64
    %4 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %5 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %6 = llvm.mlir.constant(1 : i64) : i64
    llvm.br ^bb1(%1 : i64)
  ^bb1(%7: i64):  // 2 preds: ^bb0, ^bb34
    %8 = llvm.icmp "slt" %7, %arg8 : i64
    llvm.cond_br %8, ^bb2, ^bb35
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%1 : i64)
  ^bb3(%9: i64):  // 2 preds: ^bb2, ^bb4
    %10 = llvm.icmp "slt" %9, %arg8 : i64
    llvm.cond_br %10, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %11 = llvm.getelementptr %arg3[%9] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %3, %11 : i64, !llvm.ptr
    %12 = llvm.getelementptr %arg4[%9] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %4, %12 : f64, !llvm.ptr
    %13 = llvm.getelementptr %arg7[%9] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %4, %13 : f64, !llvm.ptr
    %14 = llvm.add %9, %2 : i64
    llvm.br ^bb3(%14 : i64)
  ^bb5:  // pred: ^bb3
    %15 = llvm.getelementptr %arg4[%7] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %5, %15 : f64, !llvm.ptr
    %16 = llvm.getelementptr %arg3[%7] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %0, %16 : i64, !llvm.ptr
    llvm.store %7, %arg6 : i64, !llvm.ptr
    llvm.br ^bb6(%1, %1, %2, %1 : i64, i64, i64, i64)
  ^bb6(%17: i64, %18: i64, %19: i64, %20: i64):  // 2 preds: ^bb5, ^bb21
    %21 = llvm.icmp "slt" %17, %arg8 : i64
    llvm.cond_br %21, ^bb7, ^bb22
  ^bb7:  // pred: ^bb6
    %22 = llvm.icmp "eq" %18, %19 : i64
    llvm.cond_br %22, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    llvm.br ^bb20(%18, %19, %20 : i64, i64, i64)
  ^bb9:  // pred: ^bb7
    %23 = llvm.getelementptr %arg6[%18] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %24 = llvm.load %23 : !llvm.ptr -> i64
    %25 = llvm.getelementptr %arg5[%20] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %24, %25 : i64, !llvm.ptr
    %26 = llvm.add %20, %2 : i64
    %27 = llvm.getelementptr %arg3[%24] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %28 = llvm.load %27 : !llvm.ptr -> i64
    %29 = llvm.add %28, %6 : i64
    %30 = llvm.getelementptr %arg4[%24] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %31 = llvm.load %30 : !llvm.ptr -> f64
    %32 = llvm.getelementptr %arg1[%24] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %33 = llvm.load %32 : !llvm.ptr -> i64
    %34 = llvm.add %24, %2 : i64
    %35 = llvm.getelementptr %arg1[%34] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %36 = llvm.load %35 : !llvm.ptr -> i64
    llvm.br ^bb10(%33, %19 : i64, i64)
  ^bb10(%37: i64, %38: i64):  // 2 preds: ^bb9, ^bb18
    %39 = llvm.icmp "slt" %37, %36 : i64
    llvm.cond_br %39, ^bb11, ^bb19
  ^bb11:  // pred: ^bb10
    %40 = llvm.getelementptr %arg2[%37] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %41 = llvm.load %40 : !llvm.ptr -> i64
    %42 = llvm.getelementptr %arg3[%41] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %43 = llvm.load %42 : !llvm.ptr -> i64
    %44 = llvm.icmp "eq" %43, %3 : i64
    llvm.cond_br %44, ^bb12, ^bb13
  ^bb12:  // pred: ^bb11
    llvm.store %29, %42 : i64, !llvm.ptr
    %45 = llvm.getelementptr %arg6[%38] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    llvm.store %41, %45 : i64, !llvm.ptr
    %46 = llvm.add %38, %2 : i64
    llvm.br ^bb14(%46 : i64)
  ^bb13:  // pred: ^bb11
    llvm.br ^bb14(%38 : i64)
  ^bb14(%47: i64):  // 2 preds: ^bb12, ^bb13
    llvm.br ^bb15
  ^bb15:  // pred: ^bb14
    %48 = llvm.load %42 : !llvm.ptr -> i64
    %49 = llvm.icmp "eq" %48, %29 : i64
    llvm.cond_br %49, ^bb16, ^bb17
  ^bb16:  // pred: ^bb15
    %50 = llvm.getelementptr %arg4[%41] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %51 = llvm.load %50 : !llvm.ptr -> f64
    %52 = llvm.fadd %51, %31 : f64
    llvm.store %52, %50 : f64, !llvm.ptr
    llvm.br ^bb18
  ^bb17:  // pred: ^bb15
    llvm.br ^bb18
  ^bb18:  // 2 preds: ^bb16, ^bb17
    %53 = llvm.add %37, %2 : i64
    llvm.br ^bb10(%53, %47 : i64, i64)
  ^bb19:  // pred: ^bb10
    %54 = llvm.add %18, %2 : i64
    llvm.br ^bb20(%54, %38, %26 : i64, i64, i64)
  ^bb20(%55: i64, %56: i64, %57: i64):  // 2 preds: ^bb8, ^bb19
    llvm.br ^bb21
  ^bb21:  // pred: ^bb20
    %58 = llvm.add %17, %2 : i64
    llvm.br ^bb6(%58, %55, %56, %57 : i64, i64, i64, i64)
  ^bb22:  // pred: ^bb6
    llvm.br ^bb23(%1 : i64)
  ^bb23(%59: i64):  // 2 preds: ^bb22, ^bb33
    %60 = llvm.icmp "slt" %59, %20 : i64
    llvm.cond_br %60, ^bb24, ^bb34
  ^bb24:  // pred: ^bb23
    %61 = llvm.sub %20, %2 : i64
    %62 = llvm.sub %61, %59 : i64
    %63 = llvm.getelementptr %arg5[%62] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %64 = llvm.load %63 : !llvm.ptr -> i64
    %65 = llvm.getelementptr %arg3[%64] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %66 = llvm.load %65 : !llvm.ptr -> i64
    %67 = llvm.sub %66, %6 : i64
    %68 = llvm.getelementptr %arg7[%64] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %69 = llvm.load %68 : !llvm.ptr -> f64
    %70 = llvm.getelementptr %arg4[%64] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %71 = llvm.load %70 : !llvm.ptr -> f64
    %72 = llvm.fadd %69, %5 : f64
    %73 = llvm.fdiv %72, %71 : f64
    %74 = llvm.getelementptr %arg1[%64] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %75 = llvm.load %74 : !llvm.ptr -> i64
    %76 = llvm.add %64, %2 : i64
    %77 = llvm.getelementptr %arg1[%76] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %78 = llvm.load %77 : !llvm.ptr -> i64
    llvm.br ^bb25(%75 : i64)
  ^bb25(%79: i64):  // 2 preds: ^bb24, ^bb29
    %80 = llvm.icmp "slt" %79, %78 : i64
    llvm.cond_br %80, ^bb26, ^bb30
  ^bb26:  // pred: ^bb25
    %81 = llvm.getelementptr %arg2[%79] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %82 = llvm.load %81 : !llvm.ptr -> i64
    %83 = llvm.getelementptr %arg3[%82] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %84 = llvm.load %83 : !llvm.ptr -> i64
    %85 = llvm.icmp "eq" %84, %67 : i64
    llvm.cond_br %85, ^bb27, ^bb28
  ^bb27:  // pred: ^bb26
    %86 = llvm.getelementptr %arg4[%82] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %87 = llvm.load %86 : !llvm.ptr -> f64
    %88 = llvm.fmul %87, %73 : f64
    %89 = llvm.getelementptr %arg7[%82] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %90 = llvm.load %89 : !llvm.ptr -> f64
    %91 = llvm.fadd %90, %88 : f64
    llvm.store %91, %89 : f64, !llvm.ptr
    llvm.br ^bb29
  ^bb28:  // pred: ^bb26
    llvm.br ^bb29
  ^bb29:  // 2 preds: ^bb27, ^bb28
    %92 = llvm.add %79, %2 : i64
    llvm.br ^bb25(%92 : i64)
  ^bb30:  // pred: ^bb25
    %93 = llvm.icmp "ne" %64, %7 : i64
    llvm.cond_br %93, ^bb31, ^bb32
  ^bb31:  // pred: ^bb30
    %94 = llvm.getelementptr %arg0[%64] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %95 = llvm.load %94 : !llvm.ptr -> f64
    %96 = llvm.fadd %95, %69 : f64
    llvm.store %96, %94 : f64, !llvm.ptr
    llvm.br ^bb33
  ^bb32:  // pred: ^bb30
    llvm.br ^bb33
  ^bb33:  // 2 preds: ^bb31, ^bb32
    %97 = llvm.add %59, %2 : i64
    llvm.br ^bb23(%97 : i64)
  ^bb34:  // pred: ^bb23
    %98 = llvm.add %7, %2 : i64
    llvm.br ^bb1(%98 : i64)
  ^bb35:  // pred: ^bb1
    llvm.return
  }
  llvm.func @_mlir_ciface_networkx_algorithms_centrality_betweenness_betweenness_centrality_chunk_0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr, %arg4: !llvm.ptr, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: !llvm.ptr, %arg8: i64) attributes {llvm.emit_c_interface} {
    llvm.call @networkx_algorithms_centrality_betweenness_betweenness_centrality_chunk_0(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8) : (!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }
}

