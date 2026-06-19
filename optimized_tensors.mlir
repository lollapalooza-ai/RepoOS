#map = affine_map<(d0) -> (d0 * 32)>
#map1 = affine_map<(d0) -> (d0 * 8)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: tensor<512x512xf32>, %arg1: tensor<512x512xf32>, %arg2: tensor<512x512xf32>) -> tensor<512x512xf32> {
    %0 = ub.poison : f32
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<0.000000e+00> : vector<512x512xf32>
    %1 = vector.transfer_write %cst, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<512x512xf32>, tensor<512x512xf32>
    %2 = scf.forall (%arg3, %arg4, %arg5) in (16, 16, 64) shared_outs(%arg6 = %1) -> (tensor<512x512xf32>) {
      %3 = affine.apply #map(%arg3)
      %4 = affine.apply #map(%arg4)
      %extracted_slice = tensor.extract_slice %arg6[%3, %4] [32, 32] [1, 1] : tensor<512x512xf32> to tensor<32x32xf32>
      %5 = affine.apply #map(%arg3)
      %6 = affine.apply #map1(%arg5)
      %7 = vector.transfer_read %arg0[%5, %6], %0 {in_bounds = [true, true]} : tensor<512x512xf32>, vector<32x8xf32>
      %8 = affine.apply #map1(%arg5)
      %9 = affine.apply #map(%arg4)
      %10 = vector.transfer_read %arg1[%8, %9], %0 {in_bounds = [true, true]} : tensor<512x512xf32>, vector<8x32xf32>
      %11 = affine.apply #map(%arg3)
      %12 = affine.apply #map(%arg4)
      %13 = vector.transfer_read %arg6[%11, %12], %0 {in_bounds = [true, true]} : tensor<512x512xf32>, vector<32x32xf32>
      %14 = vector.contract {indexing_maps = [#map2, #map3, #map4], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %7, %10, %13 : vector<32x8xf32>, vector<8x32xf32> into vector<32x32xf32>
      %15 = vector.transfer_write %14, %extracted_slice[%c0, %c0] {in_bounds = [true, true]} : vector<32x32xf32>, tensor<32x32xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %15 into %arg6[%3, %4] [32, 32] [1, 1] : tensor<32x32xf32> into tensor<512x512xf32>
      }
    }
    return %2 : tensor<512x512xf32>
  }
  transform.named_sequence @__transform_main(%arg0: !transform.any_op) {
    %0 = transform.structured.match ops{["linalg.matmul"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %tiled_op, %forall_op = transform.structured.tile_using_forall %0 tile_sizes [32, 32, 8] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %1 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %2 = transform.structured.vectorize_children_and_apply_patterns %1 : (!transform.any_op) -> !transform.any_op
    transform.yield 
  }
}

