#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @main(%arg0: tensor<10x10xf32>) -> tensor<10x10xf32> {
    %cst = arith.constant 2.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = tensor.empty() : tensor<10x10xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<10x10xf32>) outs(%0 : tensor<10x10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.mulf %in, %cst : f32
      linalg.yield %3 : f32
    } -> tensor<10x10xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%1 : tensor<10x10xf32>) outs(%0 : tensor<10x10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.addf %in, %cst_0 : f32
      linalg.yield %3 : f32
    } -> tensor<10x10xf32>
    return %2 : tensor<10x10xf32>
  }
}


module attributes {transform.with_named_sequence} {
  transform.named_sequence @__transform_main__(%root: !transform.any_op) {
    %module = transform.get_root_op : !transform.any_op
    %func = transform.structured.match ops["func.func"] in %module : (!transform.any_op) -> !transform.any_op
    
    %return_op = transform.structured.match ops["func.return"] in %func : (!transform.any_op) -> !transform.any_op
    %consumer_op = transform.get_producer_of_operand %return_op, operand_index = 0 : (!transform.any_op) -> !transform.any_op
    %fused_op = transform.structured.fuse_producer_of_operand %consumer_op, operand_index = 0 : (!transform.any_op) -> !transform.any_op

    %block_tiled, %block_forall = transform.structured.tile_using_forall %fused_op 
      tile_sizes([128, 128])
      mapping = [#gpu.block_id_y, #gpu.block_id_x] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)

    %thread_tiled, %thread_forall = transform.structured.tile_using_forall %block_tiled 
      num_threads([16, 8])
      mapping = [#gpu.thread_id_y, #gpu.thread_id_x] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    
    transform.structured.lower_to_gpu %func : !transform.any_op

    transform.yield
  }
}