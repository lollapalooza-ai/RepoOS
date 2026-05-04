module {
  llvm.func @check_password(%arg0: f64, %arg1: f64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    llvm.return %2 : f64
  }
  llvm.func @_mlir_ciface_check_password(%arg0: f64, %arg1: f64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.call @check_password(%arg0, %arg1) : (f64, f64) -> f64
    llvm.return %0 : f64
  }
}
