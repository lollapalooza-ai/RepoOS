#map = affine_map<(d0) -> (d0 * 8)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map4 = affine_map<(d0, d1) -> (d0, d1)>
#map5 = affine_map<(d0, d1) -> ()>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: tensor<2048x2048xf32>, %arg1: tensor<2048x1xf32>, %arg2: tensor<2048x1xf32>, %arg3: tensor<2048x1xf32>, %arg4: tensor<1xf32>, %arg5: tensor<1xf32>, %arg6: tensor<2048x1xf32>) -> tensor<2048x1xf32> {
    %0 = ub.poison : f32
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %cst_0 = arith.constant dense<0.000000e+00> : vector<2048x1xf32>
    %1 = vector.transfer_write %cst_0, %arg6[%c0, %c0] {in_bounds = [true, true]} : vector<2048x1xf32>, tensor<2048x1xf32>
    %2 = scf.forall (%arg7, %arg8, %arg9) in (256, 1, 256) shared_outs(%arg10 = %1) -> (tensor<2048x1xf32>) {
      %21 = affine.apply #map(%arg7)
      %extracted_slice = tensor.extract_slice %arg10[%21, %arg8] [8, 1] [1, 1] : tensor<2048x1xf32> to tensor<8x1xf32>
      %22 = affine.apply #map(%arg7)
      %23 = affine.apply #map(%arg9)
      %24 = vector.transfer_read %arg0[%22, %23], %0 {in_bounds = [true, true]} : tensor<2048x2048xf32>, vector<8x8xf32>
      %25 = affine.apply #map(%arg9)
      %26 = vector.transfer_read %arg1[%25, %arg8], %0 {in_bounds = [true, true]} : tensor<2048x1xf32>, vector<8x1xf32>
      %27 = affine.apply #map(%arg7)
      %28 = vector.transfer_read %arg10[%27, %arg8], %0 {in_bounds = [true, true]} : tensor<2048x1xf32>, vector<8x1xf32>
      %29 = vector.contract {indexing_maps = [#map1, #map2, #map3], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %24, %26, %28 : vector<8x8xf32>, vector<8x1xf32> into vector<8x1xf32>
      %30 = vector.transfer_write %29, %extracted_slice[%c0, %c0] {in_bounds = [true, true]} : vector<8x1xf32>, tensor<8x1xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %30 into %arg10[%21, %arg8] [8, 1] [1, 1] : tensor<8x1xf32> into tensor<2048x1xf32>
      }
    }
    %3 = vector.transfer_read %arg1[%c0, %c0], %0 {in_bounds = [true, true]} : tensor<2048x1xf32>, vector<2048x1xf32>
    %4 = vector.transfer_read %arg3[%c0, %c0], %0 {in_bounds = [true, true]} : tensor<2048x1xf32>, vector<2048x1xf32>
    %5 = vector.contract {indexing_maps = [#map4, #map4, #map5], iterator_types = ["reduction", "reduction"], kind = #vector.kind<add>} %3, %4, %cst : vector<2048x1xf32>, vector<2048x1xf32> into f32
    %6 = vector.broadcast %5 : f32 to vector<f32>
    %7 = vector.transfer_read %arg4[%c0], %0 {in_bounds = [true]} : tensor<1xf32>, vector<1xf32>
    %8 = vector.broadcast %6 : vector<f32> to vector<1xf32>
    %9 = arith.mulf %7, %8 : vector<1xf32>
    %10 = vector.transfer_read %arg5[%c0], %0 {in_bounds = [true]} : tensor<1xf32>, vector<1xf32>
    %11 = arith.addf %9, %10 : vector<1xf32>
    %12 = vector.transfer_read %arg4[%c0], %0 {in_bounds = [true]} : tensor<1xf32>, vector<1xf32>
    %13 = vector.broadcast %12 : vector<1xf32> to vector<2048x1xf32>
    %14 = vector.transfer_read %2[%c0, %c0], %0 {in_bounds = [true, true]} : tensor<2048x1xf32>, vector<2048x1xf32>
    %15 = arith.mulf %13, %14 : vector<2048x1xf32>
    %16 = vector.broadcast %11 : vector<1xf32> to vector<2048x1xf32>
    %17 = vector.transfer_read %arg2[%c0, %c0], %0 {in_bounds = [true, true]} : tensor<2048x1xf32>, vector<2048x1xf32>
    %18 = arith.mulf %16, %17 : vector<2048x1xf32>
    %19 = arith.addf %15, %18 : vector<2048x1xf32>
    %20 = vector.transfer_write %19, %arg6[%c0, %c0] {in_bounds = [true, true]} : vector<2048x1xf32>, tensor<2048x1xf32>
    return %20 : tensor<2048x1xf32>
  }
  transform.named_sequence @__transform_main(%arg0: !transform.any_op) {
    %0 = transform.structured.match ops{["linalg.matmul"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %tiled_op, %forall_op = transform.structured.tile_using_forall %0 tile_sizes [8, 1, 8] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %1 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %2 = transform.structured.vectorize_children_and_apply_patterns %1 : (!transform.any_op) -> !transform.any_op
    transform.yield 
  }
}

