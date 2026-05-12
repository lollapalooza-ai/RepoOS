module {
  func.func @networkx_utils_random_sequence_zipf_rv_chunk_0(%arg0: !llvm.ptr, %arg1: f64) {
    %cst = arith.constant 1.000000e+00 : f64
    %0 = arith.subf %arg1, %cst : f64
    %cst_0 = arith.constant 2.000000e+00 : f64
    %1 = math.powf %cst_0, %0 : f64
    llvm.store %1, %arg0 : f64, !llvm.ptr
    return
  }
}
