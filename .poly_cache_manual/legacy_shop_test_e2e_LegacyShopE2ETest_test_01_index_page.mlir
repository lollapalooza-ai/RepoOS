module {
  llvm.func @test_01_index_page(%arg0: f64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    llvm.return %4 : f64
  }
  llvm.func @_mlir_ciface_test_01_index_page(%arg0: f64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.call @test_01_index_page(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }
}
