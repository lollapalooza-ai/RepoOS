module {
  llvm.func @compute_gravity(%arg0: f64, %arg1: f64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.fmul %arg0, %arg1 : f64
    %3 = llvm.mlir.constant(9.810000e+00 : f64) : f64
    %4 = llvm.fdiv %2, %3 : f64
    %5 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %6 = llvm.fmul %arg0, %5 : f64
    %7 = llvm.fadd %4, %6 : f64
    %8 = llvm.mlir.constant(2.000000e-01 : f64) : f64
    %9 = llvm.fmul %arg1, %8 : f64
    %10 = llvm.fsub %7, %9 : f64
    llvm.return %10 : f64
  }
  llvm.func @_mlir_ciface_compute_gravity(%arg0: f64, %arg1: f64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.call @compute_gravity(%arg0, %arg1) : (f64, f64) -> f64
    llvm.return %0 : f64
  }
}
