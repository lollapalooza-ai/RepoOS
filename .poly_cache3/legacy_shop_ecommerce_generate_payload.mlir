module {
  llvm.func @generate_payload(%arg0: i64) -> i64 attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(0 : index) : i64
    llvm.br ^bb1(%1, %arg0 : i64, i64)
  ^bb1(%2: i64, %3: i64):  // 2 preds: ^bb0, ^bb2
    %4 = llvm.icmp "slt" %2, %arg0 : i64
    llvm.cond_br %4, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %5 = llvm.add %2, %0 : i64
    llvm.br ^bb1(%5, %3 : i64, i64)
  ^bb3:  // pred: ^bb1
    llvm.return %3 : i64
  }
  llvm.func @_mlir_ciface_generate_payload(%arg0: i64) -> i64 attributes {llvm.emit_c_interface} {
    %0 = llvm.call @generate_payload(%arg0) : (i64) -> i64
    llvm.return %0 : i64
  }
}
