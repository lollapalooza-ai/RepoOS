module {
  llvm.func @generate_payload(%arg0: f64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %5 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %6 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %7 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %8 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %9 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %10 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %11 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %12 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %13 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %14 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %15 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }
  llvm.func @_mlir_ciface_generate_payload(%arg0: f64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.call @generate_payload(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }
}
