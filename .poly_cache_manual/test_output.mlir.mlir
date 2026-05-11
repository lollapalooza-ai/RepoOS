module {
  func.func @cumulative_distribution(%arg0: i64, %arg1: i64, %arg2: i64) -> f64 attributes {llvm.emit_c_interface} {
    %cst = arith.constant 1.000000e+00 : f64
    return %cst : f64
  }
}
