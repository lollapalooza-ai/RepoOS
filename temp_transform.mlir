module attributes {transform.with_named_sequence} {
  transform.named_sequence @__transform_main(%variant_op: !transform.any_op) {
    %func = transform.structured.match ops{["func.func"]} in %variant_op

    // Step 1: Tile ops with reduction loops (linalg.vecmat and the first linalg.generic).
    // These have 1 parallel and 1 reduction dimension, both of size 4.
    // We tile by [4, 4] to create a single point operation that can be fully vectorized.
    %matmul_like_ops = transform.structured.match
        interface{LinalgOp} in %func (
            {
            ^bb1(%op: !transform.any_op):
                %n_loops = transform.structured.get_num_loops %op
                %is_2 = transform.cmpi eq %n_loops, 2 : index
                %n_parallel = transform.structured.get_num_parallel_loops %op
                %is_1_p = transform.cmpi eq %n_parallel, 1 : index
                %n_reduction = transform.structured.get_num_reduction_loops %op
                %is_1_r = transform.cmpi eq %n_reduction, 1 : index
                %cond1 = transform.andi %is_2, %is_1_p : i1
                %cond2 = transform.andi %cond1, %is_1_r : i1
                transform.yield %cond2 : i1
            }
        )
    %tiled_matmul, %loops:2 = transform.structured.tile_using_for %matmul_like_ops tile_sizes [4, 4]

    // Step 2: Unroll the inner tiled loop (the reduction dimension).
    transform.loop.unroll %loops#1 factor = 4

    // Step 3: Vectorize the tiled point operation.
    transform.structured.vectorize %tiled_matmul

    // Step 4: Tile 2-D parallel linalg.generic ops.
    // We again tile by [4, 4] to create a single point op for vectorization.
    %parallel_2d_ops = transform.structured.match
        interface{LinalgOp} in %func (
            ops{["linalg.generic"]},
            {
            ^bb1(%op: !transform.any_op):
                %n_loops = transform.structured.get_num_loops %op
                %is_2 = transform.cmpi eq %n_loops, 2 : index
                %n_parallel = transform.structured.get_num_parallel_loops %op
                %is_all_parallel = transform.cmpi eq %n_loops, %n_parallel : index
                %cond = transform.andi %is_2, %is_all_parallel : i1
                transform.yield %cond : i1
            }
        )
    %tiled_parallel, %parallel_loops:2 = transform.structured.tile_using_for %parallel_2d_ops tile_sizes [4, 4]

    // Step 5: Vectorize the tiled 2-D parallel op.
    transform.structured.vectorize %tiled_parallel

    // Step 6: Vectorize all remaining Linalg ops (fills and 1-D generics).
    %remaining_linalg_ops = transform.structured.match interface{LinalgOp} in %func
    transform.structured.vectorize %remaining_linalg_ops

    //===--------------------------------------------------------------------===//
    // Lowering pipeline
    //===--------------------------------------------------------------------===//
    
    // Step 7: Bufferize the program.
    transform.one_shot_bufferize {
        allow_return_allocs = true,
        bufferize_function_boundaries = true,
        function_boundary_type_conversion = "identity-layout-map",
        target_module = %variant_op
    }
    
    // Step 8: Lower vector operations to a form suitable for NEON.
    %func_after_bufferize = transform.structured.match ops{["func.func"]} in %variant_op
    transform.apply_patterns to %func_after_bufferize {
      transform.apply_patterns.vector.lower_contraction lowering_strategy = "outerproduct"
      transform.apply_patterns.vector.lower_multi_reduction lowering_strategy = "innerparallel"
      transform.apply_patterns.vector.split_transfers full_unroll = true, lower_to = "shuffle"
      transform.apply_patterns.vector.shape_cast_lowering
    }

    // Step 9: Lower vector dialect to LLVM, enabling ARM NEON intrinsics.
    transform.vector.lower_to_llvm {
        reassociate_fp_reductions = true,
        enable_arm_neon = true
    }

    // Step 10: Final cleanup and lowering to LLVM dialect.
    %func_after_vector_lowering = transform.structured.match ops{["func.func"]} in %variant_op
    transform.memref.dealloc_to_scf to %func_after_vector_lowering
    transform.apply_cse to %func_after_vector_lowering
    transform.lower_to_llvm
  }
}