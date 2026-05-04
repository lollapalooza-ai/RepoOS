module {
  llvm.func @test_06_admin_users_endpoint(%arg0: f64) -> f64 attributes {llvm.emit_c_interface} {
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
    llvm.return %9 : f64
  }
  llvm.func @_mlir_ciface_test_06_admin_users_endpoint(%arg0: f64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.call @test_06_admin_users_endpoint(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }
}
