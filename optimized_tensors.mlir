#map = affine_map<(d0) -> (d0 * 32)>
#map1 = affine_map<(d0) -> (d0 * 4)>
#map2 = affine_map<(d0) -> (d0 * 8)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: tensor<4096x4096xf32>, %arg1: tensor<4096x4096xf32>, %arg2: tensor<4096x4096xf32>) {
    %cst = arith.constant 2.000000e+00 : f32
    %0 = scf.forall (%arg3, %arg4) in (128, 128) shared_outs(%arg5 = %arg2) -> (tensor<4096x4096xf32>) {
      %2 = affine.apply #map(%arg3)
      %3 = affine.apply #map(%arg4)
      %extracted_slice = tensor.extract_slice %arg0[%2, %3] [32, 32] [1, 1] : tensor<4096x4096xf32> to tensor<32x32xf32>
      %extracted_slice_0 = tensor.extract_slice %arg1[%2, %3] [32, 32] [1, 1] : tensor<4096x4096xf32> to tensor<32x32xf32>
      %extracted_slice_1 = tensor.extract_slice %arg5[%2, %3] [32, 32] [1, 1] : tensor<4096x4096xf32> to tensor<32x32xf32>
      %4 = scf.forall (%arg6, %arg7) in (8, 4) shared_outs(%arg8 = %extracted_slice_1) -> (tensor<32x32xf32>) {
        %5 = affine.apply #map1(%arg6)
        %6 = affine.apply #map2(%arg7)
        %extracted_slice_2 = tensor.extract_slice %extracted_slice[%5, %6] [4, 8] [1, 1] : tensor<32x32xf32> to tensor<4x8xf32>
        %extracted_slice_3 = tensor.extract_slice %extracted_slice_0[%5, %6] [4, 8] [1, 1] : tensor<32x32xf32> to tensor<4x8xf32>
        %extracted_slice_4 = tensor.extract_slice %arg8[%5, %6] [4, 8] [1, 1] : tensor<32x32xf32> to tensor<4x8xf32>
        %7 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel"]} ins(%extracted_slice_2, %extracted_slice_3 : tensor<4x8xf32>, tensor<4x8xf32>) outs(%extracted_slice_4 : tensor<4x8xf32>) {
        ^bb0(%in: f32, %in_5: f32, %out: f32):
          %8 = arith.mulf %in, %in_5 : f32
          linalg.yield %8 : f32
        } -> tensor<4x8xf32>
        scf.forall.in_parallel {
          tensor.parallel_insert_slice %7 into %arg8[%5, %6] [4, 8] [1, 1] : tensor<4x8xf32> into tensor<32x32xf32>
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
      %4 = scf.forall (%arg6, %arg7) in (8, 4) shared_outs(%arg8 = %extracted_slice_0) -> (tensor<32x32xf32>) {
        %5 = affine.apply #map1(%arg6)
        %6 = affine.apply #map2(%arg7)
        %extracted_slice_1 = tensor.extract_slice %extracted_slice[%5, %6] [4, 8] [1, 1] : tensor<32x32xf32> to tensor<4x8xf32>
        %extracted_slice_2 = tensor.extract_slice %arg8[%5, %6] [4, 8] [1, 1] : tensor<32x32xf32> to tensor<4x8xf32>
        %7 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel"]} ins(%extracted_slice_1 : tensor<4x8xf32>) outs(%extracted_slice_2 : tensor<4x8xf32>) {
        ^bb0(%in: f32, %out: f32):
          %8 = arith.addf %in, %cst : f32
          linalg.yield %8 : f32
        } -> tensor<4x8xf32>
        scf.forall.in_parallel {
          tensor.parallel_insert_slice %7 into %arg8[%5, %6] [4, 8] [1, 1] : tensor<4x8xf32> into tensor<32x32xf32>
        }
      } {mapping = [#gpu.thread<x>, #gpu.thread<y>]}
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %4 into %arg5[%2, %3] [32, 32] [1, 1] : tensor<32x32xf32> into tensor<4096x4096xf32>
      }
    } {mapping = [#gpu.block<x>, #gpu.block<y>]}
    return
  }
  
}

