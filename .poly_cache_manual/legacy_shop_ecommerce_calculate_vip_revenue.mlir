module {
  llvm.func @calculate_vip_revenue(%arg0: f64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    llvm.return %1 : f64
  }
  llvm.func @_mlir_ciface_calculate_vip_revenue(%arg0: f64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.call @calculate_vip_revenue(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }
}
