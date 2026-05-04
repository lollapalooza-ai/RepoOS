module {
  llvm.func @compute_gravity(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(9.810000e+00 : f64) : f64
    %1 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %2 = llvm.mlir.constant(2.000000e-01 : f64) : f64
    %3 = llvm.fmul %arg0, %arg1 : f64
    %4 = llvm.fdiv %3, %0 : f64
    %5 = llvm.fmul %arg0, %1 : f64
    %6 = llvm.fadd %4, %5 : f64
    %7 = llvm.fmul %arg1, %2 : f64
    %8 = llvm.fsub %6, %7 : f64
    llvm.return %8 : f64
  }
  llvm.func @main() {
    %0 = llvm.mlir.constant(5.000000e+03 : f64) : f64
    %1 = llvm.mlir.constant(1.200000e+03 : f64) : f64
    %2 = llvm.call @compute_gravity(%0, %1) : (f64, f64) -> f64
    %3 = llvm.mlir.poison : vector<1xf64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<1xf64>
    vector.print %5 : vector<1xf64>
    llvm.return
  }
}

