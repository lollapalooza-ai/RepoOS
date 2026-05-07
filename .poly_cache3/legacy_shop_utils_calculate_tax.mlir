module {
  llvm.func @calculate_tax(%arg0: f64, %arg1: i32) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(8.000000e-02 : f64) : f64
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(4.000000e-02 : f64) : f64
    %5 = llvm.fmul %arg0, %4 : f64
    %6 = llvm.icmp "eq" %arg1, %2 : i32
    %7 = llvm.select %6, %5, %3 : i1, f64
    %8 = llvm.fmul %arg0, %1 : f64
    %9 = llvm.icmp "eq" %arg1, %0 : i32
    %10 = llvm.select %9, %8, %7 : i1, f64
    llvm.return %10 : f64
  }
  llvm.func @_mlir_ciface_calculate_tax(%arg0: f64, %arg1: i32) -> f64 attributes {llvm.emit_c_interface} {
    %0 = llvm.call @calculate_tax(%arg0, %arg1) : (f64, i32) -> f64
    llvm.return %0 : f64
  }
}
