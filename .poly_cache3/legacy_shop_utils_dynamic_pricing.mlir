module {
  llvm.func @dynamic_pricing(%arg0: f64, %arg1: f64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ogt" %arg1, %0 : f64
    %2 = llvm.fmul %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %arg0 : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @_mlir_ciface_dynamic_pricing(%arg0: f64, %arg1: f64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.call @dynamic_pricing(%arg0, %arg1) : (f64, f64) -> f64
    llvm.return %0 : f64
  }
}
