#map = affine_map<(d0) -> (d0 * 32)>
#map1 = affine_map<(d0) -> (d0 * 2)>
#map2 = affine_map<(d0) -> (d0 * 4)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: tensor<4096x4096xf32>, %arg1: tensor<4096x4096xf32>, %arg2: tensor<4096x4096xf32>) -> tensor<4096x4096xf32> {
    %cst = arith.constant 2.000000e+00 : f32
    %0 = scf.forall (%arg3, %arg4) in (128, 128) shared_outs(%arg5 = %arg2) -> (tensor<4096x4096xf32>) {
      %2 = affine.apply #map(%arg3)
      %3 = affine.apply #map(%arg4)
      %extracted_slice = tensor.extract_slice %arg0[%2, %3] [32, 32] [1, 1] : tensor<4096x4096xf32> to tensor<32x32xf32>
      %extracted_slice_0 = tensor.extract_slice %arg1[%2, %3] [32, 32] [1, 1] : tensor<4096x4096xf32> to tensor<32x32xf32>
      %extracted_slice_1 = tensor.extract_slice %arg5[%2, %3] [32, 32] [1, 1] : tensor<4096x4096xf32> to tensor<32x32xf32>
      %4 = scf.forall (%arg6, %arg7) in (16, 8) shared_outs(%arg8 = %extracted_slice_1) -> (tensor<32x32xf32>) {
        %5 = affine.apply #map1(%arg6)
        %6 = affine.apply #map2(%arg7)
        %extracted_slice_2 = tensor.extract_slice %extracted_slice[%5, %6] [2, 4] [1, 1] : tensor<32x32xf32> to tensor<2x4xf32>
        %extracted_slice_3 = tensor.extract_slice %extracted_slice_0[%5, %6] [2, 4] [1, 1] : tensor<32x32xf32> to tensor<2x4xf32>
        %extracted_slice_4 = tensor.extract_slice %arg8[%5, %6] [2, 4] [1, 1] : tensor<32x32xf32> to tensor<2x4xf32>
        %c2 = arith.constant 2 : index
        %c4 = arith.constant 4 : index
        %c0 = arith.constant 0 : index
        %7 = ub.poison : f32
        %8 = vector.transfer_read %extracted_slice_2[%c0, %c0], %7 : tensor<2x4xf32>, vector<2x4xf32>
        %9 = ub.poison : f32
        %10 = vector.transfer_read %extracted_slice_3[%c0, %c0], %9 : tensor<2x4xf32>, vector<2x4xf32>
        %11 = ub.poison : f32
        %12 = vector.transfer_read %extracted_slice_4[%c0, %c0], %11 : tensor<2x4xf32>, vector<2x4xf32>
        %13 = arith.mulf %8, %10 : vector<2x4xf32>
        %c0_5 = arith.constant 0 : index
        %14 = vector.transfer_write %13, %extracted_slice_4[%c0_5, %c0_5] : vector<2x4xf32>, tensor<2x4xf32>
        scf.forall.in_parallel {
          tensor.parallel_insert_slice %14 into %arg8[%5, %6] [2, 4] [1, 1] : tensor<2x4xf32> into tensor<32x32xf32>
        }
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %4 into %arg5[%2, %3] [32, 32] [1, 1] : tensor<32x32xf32> into tensor<4096x4096xf32>
      }
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    %1 = scf.forall (%arg3, %arg4) in (128, 128) shared_outs(%arg5 = %arg2) -> (tensor<4096x4096xf32>) {
      %2 = affine.apply #map(%arg3)
      %3 = affine.apply #map(%arg4)
      %extracted_slice = tensor.extract_slice %0[%2, %3] [32, 32] [1, 1] : tensor<4096x4096xf32> to tensor<32x32xf32>
      %extracted_slice_0 = tensor.extract_slice %arg5[%2, %3] [32, 32] [1, 1] : tensor<4096x4096xf32> to tensor<32x32xf32>
      %4 = scf.forall (%arg6, %arg7) in (16, 8) shared_outs(%arg8 = %extracted_slice_0) -> (tensor<32x32xf32>) {
        %5 = affine.apply #map1(%arg6)
        %6 = affine.apply #map2(%arg7)
        %extracted_slice_1 = tensor.extract_slice %extracted_slice[%5, %6] [2, 4] [1, 1] : tensor<32x32xf32> to tensor<2x4xf32>
        %extracted_slice_2 = tensor.extract_slice %arg8[%5, %6] [2, 4] [1, 1] : tensor<32x32xf32> to tensor<2x4xf32>
        %c2 = arith.constant 2 : index
        %c4 = arith.constant 4 : index
        %c0 = arith.constant 0 : index
        %7 = ub.poison : f32
        %8 = vector.transfer_read %extracted_slice_1[%c0, %c0], %7 : tensor<2x4xf32>, vector<2x4xf32>
        %9 = ub.poison : f32
        %10 = vector.transfer_read %extracted_slice_2[%c0, %c0], %9 : tensor<2x4xf32>, vector<2x4xf32>
        %cst_3 = arith.constant dense<2.000000e+00> : vector<2x4xf32>
        %11 = arith.addf %8, %cst_3 : vector<2x4xf32>
        %c0_4 = arith.constant 0 : index
        %12 = vector.transfer_write %11, %extracted_slice_2[%c0_4, %c0_4] : vector<2x4xf32>, tensor<2x4xf32>
        scf.forall.in_parallel {
          tensor.parallel_insert_slice %12 into %arg8[%5, %6] [2, 4] [1, 1] : tensor<2x4xf32> into tensor<32x32xf32>
        }
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %4 into %arg5[%2, %3] [32, 32] [1, 1] : tensor<32x32xf32> into tensor<4096x4096xf32>
      }
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    return %1 : tensor<4096x4096xf32>
  }
  transform.named_sequence @__transform_main(%arg0: !transform.any_op) {
    %0 = transform.structured.match ops{["linalg.generic"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %tiled_op, %forall_op = transform.structured.tile_using_forall %0 tile_sizes [32, 32](mapping = [#gpu.block<x>, #gpu.block<y>]) : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %tiled_op_0, %forall_op_1 = transform.structured.tile_using_forall %tiled_op tile_sizes [2, 4](mapping = [#gpu.thread<x>, #gpu.thread<y>]) : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    transform.structured.vectorize %tiled_op_0 : !transform.any_op
    transform.yield 
  }
}

