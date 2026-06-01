module {
  func.func @main(%arg0: tensor<4x4xf32>, %arg1: tensor<4x1xf32>, %arg2: tensor<4x1xf32>, %arg3: tensor<4x1xf32>, %arg4: f64, %arg5: i64, %arg6: tensor<4x1xf32>) {
    return
  }
}


module attributes {transform.with_named_sequence} {
  transform.named_sequence @__transform_main(%arg0: !transform.any_op) {
    // Match the entry point function.
    %func = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op

    // Step 1: Vectorize `linalg.generic` operations.
    // The baseline IR contains many element-wise `linalg.generic` ops whose
    // innermost loops are parallel and have a dimension of 4. This is a perfect
    // fit for NEON's 128-bit vectors (4 x f32). This transform will convert
    // these scalar operations into efficient vector operations.
    %generic_ops = transform.structured.match ops{["linalg.generic"]} in %func : (!transform.any_op) -> !transform.any_op
    transform.structured.vectorize %generic_ops : !transform.any_op

    // Step 2: Decompose `linalg.matmul` into `linalg.generic`.
    // This exposes the underlying loop structure, allowing for finer-grained
    // optimizations like unrolling, which cannot be directly applied to the
    // named `linalg.matmul` op.
    %matmul_ops = transform.structured.match ops{["linalg.matmul"]} in %func : (!transform.any_op) -> !transform.any_op
    %decomposed_matmuls = transform.structured.decompose %matmul_ops : (!transform.any_op) -> !transform.any_op

    // Step 3: Unroll the reduction loops of the decomposed matmuls.
    // Since the reduction dimension 'K' is small and fixed at 4, fully
    // unrolling the reduction loop is highly effective. It removes all loop
    // overhead and maximizes instruction-level parallelism.

    // Unroll for mat-vec style operations (e.g., 4x4 * 4x1) which result in
    // a `linalg.generic` with (parallel, reduction) loops. The reduction
    // loop is at depth 1.
    %unrolled_matvecs = transform.structured.unroll %decomposed_matmuls {factor = 4, loop_depth = 1} : (!transform.any_op) -> !transform.any_op

    // Unroll for dot-product style operations (e.g., 1x4 * 4x1) which result
    // in a `linalg.generic` with just a (reduction) loop. The reduction
    // loop is at depth 0.
    %unrolled_dots = transform.structured.unroll %decomposed_matmuls {factor = 4, loop_depth = 0} : (!transform.any_op) -> !transform.any_op

    transform.yield
  }
}