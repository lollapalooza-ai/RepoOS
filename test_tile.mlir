module attributes {transform.with_named_sequence} {
  transform.named_sequence @__transform_main(%arg0: !transform.any_op) {
    %tiled_op, %loops:1 = transform.structured.tile_using_for %arg0 tile_sizes [0, 8] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    transform.yield
  }
}
