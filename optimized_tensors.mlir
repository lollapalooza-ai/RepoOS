#map = affine_map<(d0) -> (d0 * 64)>
#map1 = affine_map<(d0) -> (d0 * 8)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: tensor<4096x4096xf32>, %arg1: tensor<4096x4096xf32>, %arg2: tensor<4096x4096xf32>) -> tensor<4096x4096xf32> {
    %cst = arith.constant 2.000000e+00 : f32
    %0 = scf.forall (%arg3, %arg4) in (64, 512) shared_outs(%arg5 = %arg2) -> (tensor<4096x4096xf32>) {
      %2 = affine.apply #map(%arg3)
      %3 = affine.apply #map1(%arg4)
      %extracted_slice = tensor.extract_slice %arg0[%2, %3] [64, 8] [1, 1] : tensor<4096x4096xf32> to tensor<64x8xf32>
      %extracted_slice_0 = tensor.extract_slice %arg1[%2, %3] [64, 8] [1, 1] : tensor<4096x4096xf32> to tensor<64x8xf32>
      %extracted_slice_1 = tensor.extract_slice %arg5[%2, %3] [64, 8] [1, 1] : tensor<4096x4096xf32> to tensor<64x8xf32>
      %c64 = arith.constant 64 : index
      %c8 = arith.constant 8 : index
      %c0 = arith.constant 0 : index
      %4 = ub.poison : f32
      %5 = vector.transfer_read %extracted_slice[%c0, %c0], %4 : tensor<64x8xf32>, vector<64x8xf32>
      %6 = ub.poison : f32
      %7 = vector.transfer_read %extracted_slice_0[%c0, %c0], %6 : tensor<64x8xf32>, vector<64x8xf32>
      %8 = ub.poison : f32
      %9 = vector.transfer_read %extracted_slice_1[%c0, %c0], %8 : tensor<64x8xf32>, vector<64x8xf32>
      %10 = arith.mulf %5, %7 : vector<64x8xf32>
      %c0_2 = arith.constant 0 : index
      %11 = vector.transfer_write %10, %extracted_slice_1[%c0_2, %c0_2] : vector<64x8xf32>, tensor<64x8xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %11 into %arg5[%2, %3] [64, 8] [1, 1] : tensor<64x8xf32> into tensor<4096x4096xf32>
      }
    }
    %1 = scf.forall (%arg3, %arg4) in (64, 512) shared_outs(%arg5 = %arg2) -> (tensor<4096x4096xf32>) {
      %2 = affine.apply #map(%arg3)
      %3 = affine.apply #map1(%arg4)
      %extracted_slice = tensor.extract_slice %0[%2, %3] [64, 8] [1, 1] : tensor<4096x4096xf32> to tensor<64x8xf32>
      %extracted_slice_0 = tensor.extract_slice %arg5[%2, %3] [64, 8] [1, 1] : tensor<4096x4096xf32> to tensor<64x8xf32>
      %c64 = arith.constant 64 : index
      %c8 = arith.constant 8 : index
      %c0 = arith.constant 0 : index
      %4 = ub.poison : f32
      %5 = vector.transfer_read %extracted_slice[%c0, %c0], %4 : tensor<64x8xf32>, vector<64x8xf32>
      %6 = ub.poison : f32
      %7 = vector.transfer_read %extracted_slice_0[%c0, %c0], %6 : tensor<64x8xf32>, vector<64x8xf32>
      %cst_1 = arith.constant dense<2.000000e+00> : vector<64x8xf32>
      %8 = arith.addf %5, %cst_1 : vector<64x8xf32>
      %c0_2 = arith.constant 0 : index
      %9 = vector.transfer_write %8, %extracted_slice_0[%c0_2, %c0_2] : vector<64x8xf32>, tensor<64x8xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %9 into %arg5[%2, %3] [64, 8] [1, 1] : tensor<64x8xf32> into tensor<4096x4096xf32>
      }
    }
    return %1 : tensor<4096x4096xf32>
  }
  transform.named_sequence @__transform_main(%arg0: !transform.any_op) {
    %0 = transform.structured.match ops{["linalg.generic"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %tiled_op, %forall_op = transform.structured.tile_using_forall %0 tile_sizes [64, 8] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    transform.structured.vectorize %tiled_op : !transform.any_op
    transform.yield 
  }
}

