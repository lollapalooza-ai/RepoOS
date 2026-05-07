module {
  llvm.func @test_04_login_fail_nonexistent_user(%arg0: f64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }
  llvm.func @_mlir_ciface_test_04_login_fail_nonexistent_user(%arg0: f64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.call @test_04_login_fail_nonexistent_user(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }
}
