#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @main(%arg0: tensor<10x10xf32>) -> tensor<10x10xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = tensor.empty() : tensor<10x10xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<10x10xf32>) outs(%0 : tensor<10x10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.addf %in, %cst_0 : f32
      linalg.yield %3 : f32
    } -> tensor<10x10xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%1 : tensor<10x10xf32>) outs(%0 : tensor<10x10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.cmpf ugt, %in, %cst : f32
      %4 = arith.select %3, %in, %cst : f32
      linalg.yield %4 : f32
    } -> tensor<10x10xf32>
    return %2 : tensor<10x10xf32>
  }
}

transform.named_sequence @__transform_main(%root: !transform.any_op) {
    %main_func = transform.structured.match ops{["func.func"]} in %root : (!transform.any_op) -> !transform.any_op
    %return_op = transform.structured.match ops{["func.return"]} in %main_func : (!transform.any_op) -> !transform.any_op
    %consumer_op = transform.get_producer_of_operand %return_op { operand_number = 0 } : (!transform.any_op) -> !transform.any_op
    %producer_op = transform.get_producer_of_operand %consumer_op { operand_number = 0 } : (!transform.any_op) -> !transform.any_op

    %fused_op, %_ = transform.structured.fuse %producer_op into %consumer_op : (!transform.any_op, !transform.any_op) -> (!transform.any_op, !transform.any_op)

    %forall_grid, %tiled_op = transform.structured.tile_using_forall %fused_op { tile_sizes = [64, 128] } : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    transform.gpu.map_forall_to_blocks %forall_grid { grid_dims = [1, 1, 1] } : (!transform.any_op) -> !transform.any_op

    %forall_threads, %inner_op = transform.structured.tile_using_forall %tiled_op { tile_sizes = [1, 64] } : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    transform.gpu.map_nested_forall_to_threads %forall_threads { block_dims = [64, 1, 1] } : (!transform.any_op) -> !transform.any_op
    
    %vectorized_op = transform.structured.vectorize %inner_op { vector_sizes = [4] } : (!transform.any_op) -> !transform.any_op

    %root_after_gpu = transform.bufferization.one_shot_bufferize %root { bufferize_function_boundaries = true } : (!transform.any_op) -> !transform.any_op
    %gpu_module = transform.gpu.lower_to_nvvm %root_after_gpu { chip = "sm_90" } : (!transform.any_op) -> !transform.any_op

    transform.yield
}