module attributes {transform.with_named_sequence} {
  transform.named_sequence @__transform_main(%root: !transform.any_op) {
      %target = transform.structured.match in %root { ops = ["linalg.reduce"] } : (!transform.any_op) -> !transform.any_op
      %loop, %fill, %split, %tiled = transform.structured.tile_reduction_using_for %target by tile_sizes = [4] : (!transform.any_op) -> (!transform.any_op, !transform.any_op, !transform.any_op, !transform.any_op)
      transform.yield
  }
}
