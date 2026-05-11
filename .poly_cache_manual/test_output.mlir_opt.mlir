module {
  llvm.func @cumulative_distribution(%arg0: i64, %arg1: i64, %arg2: i64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }
  llvm.func @_mlir_ciface_cumulative_distribution(%arg0: i64, %arg1: i64, %arg2: i64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.call @cumulative_distribution(%arg0, %arg1, %arg2) : (i64, i64, i64) -> f64
    llvm.return %0 : f64
  }
}

