module {
  llvm.func @calculate_vip_revenue(%arg0: i64, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: !llvm.ptr, %arg7: !llvm.ptr, %arg8: i64, %arg9: i64, %arg10: i64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(0 : index) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mlir.constant(1 : i32) : i32
    llvm.br ^bb1(%0, %1 : i64, f64)
  ^bb1(%4: i64, %5: f64):  // 2 preds: ^bb0, ^bb2
    %6 = llvm.icmp "slt" %4, %arg0 : i64
    llvm.cond_br %6, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %7 = llvm.getelementptr inbounds|nuw %arg2[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %8 = llvm.load %7 : !llvm.ptr -> i32
    %9 = llvm.icmp "eq" %8, %3 : i32
    %10 = llvm.getelementptr inbounds|nuw %arg7[%4] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %11 = llvm.load %10 : !llvm.ptr -> f64
    %12 = llvm.fadd %5, %11 : f64
    %13 = llvm.select %9, %12, %5 : i1, f64
    %14 = llvm.add %4, %2 : i64
    llvm.br ^bb1(%14, %13 : i64, f64)
  ^bb3:  // pred: ^bb1
    llvm.return %5 : f64
  }
  llvm.func @_mlir_ciface_calculate_vip_revenue(%arg0: i64, %arg1: !llvm.ptr, %arg2: !llvm.ptr) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.extractvalue %0[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.load %arg2 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.extractvalue %6[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %8 = llvm.extractvalue %6[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.extractvalue %6[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.extractvalue %6[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.extractvalue %6[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.call @calculate_vip_revenue(%arg0, %1, %2, %3, %4, %5, %7, %8, %9, %10, %11) : (i64, !llvm.ptr, !llvm.ptr, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64, i64, i64) -> f64
    llvm.return %12 : f64
  }
}
