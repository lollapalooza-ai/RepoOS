module {
  llvm.func @betweenness_betweenness_centrality_chunk_1(%arg0: !llvm.ptr, %arg1: f64) {
    llvm.store %arg1, %arg0 : f64, !llvm.ptr
    llvm.return
  }
}

