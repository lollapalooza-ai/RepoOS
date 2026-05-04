module {
  llvm.func @test_05_checkout_success_and_inventory_update(%arg0: f64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %5 = llvm.mlir.constant(1.200000e+03 : f64) : f64
    %6 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %7 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %8 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %9 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %10 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %11 = llvm.mlir.constant(1.500000e+02 : f64) : f64
    %12 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %13 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %14 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %15 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %16 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %17 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %18 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %19 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %20 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %21 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %22 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %23 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %24 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %25 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %26 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %27 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %28 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %29 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %30 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    llvm.return %30 : f64
  }
  llvm.func @_mlir_ciface_test_05_checkout_success_and_inventory_update(%arg0: f64) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.call @test_05_checkout_success_and_inventory_update(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }
}
