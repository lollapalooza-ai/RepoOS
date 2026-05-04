module {
  llvm.func @compute_gravity(%arg0: f64, %arg1: f64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.fmul %arg0, %arg1 : f64
    %1 = llvm.mlir.constant(9.810000e+00 : f64) : f64
    %2 = llvm.fdiv %0, %1 : f64
    %3 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %4 = llvm.fmul %arg0, %3 : f64
    %5 = llvm.fadd %2, %4 : f64
    %6 = llvm.mlir.constant(2.000000e-01 : f64) : f64
    %7 = llvm.fmul %arg1, %6 : f64
    %8 = llvm.fsub %5, %7 : f64
    llvm.return %8 : f64
  }
  llvm.func @_mlir_ciface_compute_gravity(%arg0: f64, %arg1: f64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.call @compute_gravity(%arg0, %arg1) : (f64, f64) -> f64
    llvm.return %0 : f64
  }
}
