#map = affine_map<()[s0] -> (s0 ceildiv 4)>
#map1 = affine_map<()[s0] -> (s0 ceildiv 8)>
#map2 = affine_map<()[s0] -> (s0 ceildiv 16)>
#map3 = affine_map<(d0) -> (d0 * 4)>
#map4 = affine_map<(d0) -> (d0 * 8)>
#map5 = affine_map<(d0) -> (d0 * 16)>
#map6 = affine_map<(d0)[s0] -> (-d0 + s0, 4)>
#map7 = affine_map<(d0)[s0] -> (-d0 + s0, 8)>
#map8 = affine_map<(d0)[s0] -> (-d0 + s0, 16)>
#map9 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: tensor<?x?x?xf32>, %arg1: tensor<?x?x?xf32>, %arg2: tensor<?x?x?xf32>, %arg3: tensor<?x?x?xf32>) -> tensor<?x?x?xf32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 8.000000e+00 : f32
    %dim = tensor.dim %arg1, %c0 : tensor<?x?x?xf32>
    %dim_1 = tensor.dim %arg1, %c1 : tensor<?x?x?xf32>
    %dim_2 = tensor.dim %arg1, %c2 : tensor<?x?x?xf32>
    %0 = tensor.empty(%dim, %dim_2, %dim_1) : tensor<?x?x?xf32>
    %transposed = linalg.transpose ins(%arg1 : tensor<?x?x?xf32>) outs(%0 : tensor<?x?x?xf32>) permutation = [0, 2, 1] 
    %dim_3 = tensor.dim %arg0, %c0 : tensor<?x?x?xf32>
    %1 = arith.maxui %dim_3, %dim : index
    %dim_4 = tensor.dim %arg0, %c1 : tensor<?x?x?xf32>
    %dim_5 = tensor.dim %arg0, %c2 : tensor<?x?x?xf32>
    %2 = arith.index_cast %dim_5 : index to i64
    %3 = arith.index_cast %dim_2 : index to i64
    %4 = arith.cmpi eq, %2, %3 : i64
    cf.assert %4, "mismatching contracting dimension"
    %5 = tensor.empty(%1, %dim_4, %dim_1) : tensor<?x?x?xf32>
    %6 = linalg.fill ins(%cst : f32) outs(%5 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %dim_6 = tensor.dim %arg0, %c0 : tensor<?x?x?xf32>
    %dim_7 = tensor.dim %arg0, %c1 : tensor<?x?x?xf32>
    %dim_8 = tensor.dim %arg0, %c2 : tensor<?x?x?xf32>
    %dim_9 = tensor.dim %transposed, %c2 : tensor<?x?x?xf32>
    %7 = affine.apply #map()[%dim_7]
    %8 = affine.apply #map1()[%dim_9]
    %9 = affine.apply #map2()[%dim_8]
    %10 = scf.forall (%arg4, %arg5, %arg6, %arg7) in (%dim_6, %7, %8, %9) shared_outs(%arg8 = %6) -> (tensor<?x?x?xf32>) {
      %21 = affine.apply #map3(%arg5)
      %22 = affine.apply #map4(%arg6)
      %23 = affine.apply #map5(%arg7)
      %24 = affine.min #map6(%21)[%dim_7]
      %25 = affine.min #map7(%22)[%dim_9]
      %26 = affine.min #map8(%23)[%dim_8]
      %extracted_slice = tensor.extract_slice %arg0[%arg4, %21, %23] [1, %24, %26] [1, 1, 1] : tensor<?x?x?xf32> to tensor<1x?x?xf32>
      %extracted_slice_18 = tensor.extract_slice %transposed[%arg4, %23, %22] [1, %26, %25] [1, 1, 1] : tensor<?x?x?xf32> to tensor<1x?x?xf32>
      %extracted_slice_19 = tensor.extract_slice %arg8[%arg4, %21, %22] [1, %24, %25] [1, 1, 1] : tensor<?x?x?xf32> to tensor<1x?x?xf32>
      %27 = linalg.batch_matmul ins(%extracted_slice, %extracted_slice_18 : tensor<1x?x?xf32>, tensor<1x?x?xf32>) outs(%extracted_slice_19 : tensor<1x?x?xf32>) -> tensor<1x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %27 into %arg8[%arg4, %21, %22] [1, %24, %25] [1, 1, 1] : tensor<1x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %dim_10 = tensor.dim %10, %c0 : tensor<?x?x?xf32>
    %dim_11 = tensor.dim %10, %c1 : tensor<?x?x?xf32>
    %dim_12 = tensor.dim %10, %c2 : tensor<?x?x?xf32>
    %11 = affine.apply #map1()[%dim_12]
    %12 = scf.forall (%arg4, %arg5, %arg6) in (%dim_10, %dim_11, %11) shared_outs(%arg7 = %5) -> (tensor<?x?x?xf32>) {
      %21 = affine.apply #map4(%arg6)
      %22 = affine.min #map7(%21)[%dim_12]
      %extracted_slice = tensor.extract_slice %10[%arg4, %arg5, %21] [1, 1, %22] [1, 1, 1] : tensor<?x?x?xf32> to tensor<1x1x?xf32>
      %extracted_slice_18 = tensor.extract_slice %arg7[%arg4, %arg5, %21] [1, 1, %22] [1, 1, 1] : tensor<?x?x?xf32> to tensor<1x1x?xf32>
      %23 = linalg.generic {indexing_maps = [#map9, #map9], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<1x1x?xf32>) outs(%extracted_slice_18 : tensor<1x1x?xf32>) {
      ^bb0(%in: f32, %out: f32):
        %24 = arith.divf %in, %cst_0 : f32
        linalg.yield %24 : f32
      } -> tensor<1x1x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %23 into %arg7[%arg4, %arg5, %21] [1, 1, %22] [1, 1, 1] : tensor<1x1x?xf32> into tensor<?x?x?xf32>
      }
    }
    %dim_13 = tensor.dim %arg2, %c1 : tensor<?x?x?xf32>
    %13 = arith.index_cast %dim_1 : index to i64
    %14 = arith.index_cast %dim_13 : index to i64
    %15 = arith.cmpi eq, %13, %14 : i64
    cf.assert %15, "mismatching contracting dimension"
    %16 = linalg.fill ins(%cst : f32) outs(%arg3 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %dim_14 = tensor.dim %12, %c0 : tensor<?x?x?xf32>
    %dim_15 = tensor.dim %12, %c1 : tensor<?x?x?xf32>
    %dim_16 = tensor.dim %12, %c2 : tensor<?x?x?xf32>
    %dim_17 = tensor.dim %arg2, %c2 : tensor<?x?x?xf32>
    %17 = affine.apply #map()[%dim_15]
    %18 = affine.apply #map1()[%dim_17]
    %19 = affine.apply #map2()[%dim_16]
    %20 = scf.forall (%arg4, %arg5, %arg6, %arg7) in (%dim_14, %17, %18, %19) shared_outs(%arg8 = %16) -> (tensor<?x?x?xf32>) {
      %21 = affine.apply #map3(%arg5)
      %22 = affine.apply #map4(%arg6)
      %23 = affine.apply #map5(%arg7)
      %24 = affine.min #map6(%21)[%dim_15]
      %25 = affine.min #map7(%22)[%dim_17]
      %26 = affine.min #map8(%23)[%dim_16]
      %extracted_slice = tensor.extract_slice %12[%arg4, %21, %23] [1, %24, %26] [1, 1, 1] : tensor<?x?x?xf32> to tensor<1x?x?xf32>
      %extracted_slice_18 = tensor.extract_slice %arg2[%arg4, %23, %22] [1, %26, %25] [1, 1, 1] : tensor<?x?x?xf32> to tensor<1x?x?xf32>
      %extracted_slice_19 = tensor.extract_slice %arg8[%arg4, %21, %22] [1, %24, %25] [1, 1, 1] : tensor<?x?x?xf32> to tensor<1x?x?xf32>
      %27 = linalg.batch_matmul ins(%extracted_slice, %extracted_slice_18 : tensor<1x?x?xf32>, tensor<1x?x?xf32>) outs(%extracted_slice_19 : tensor<1x?x?xf32>) -> tensor<1x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %27 into %arg8[%arg4, %21, %22] [1, %24, %25] [1, 1, 1] : tensor<1x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    return %20 : tensor<?x?x?xf32>
  }
  transform.named_sequence @__transform_main(%arg0: !transform.any_op) {
    %0 = transform.structured.match ops{["linalg.batch_matmul"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %1 = transform.structured.match ops{["linalg.generic"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %tiled_op, %forall_op = transform.structured.tile_using_forall %0 tile_sizes [1, 4, 8, 16] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %tiled_op_0, %forall_op_1 = transform.structured.tile_using_forall %1 tile_sizes [1, 1, 8] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %2 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %3 = transform.structured.vectorize_children_and_apply_patterns %2 : (!transform.any_op) -> !transform.any_op
    %4 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %5 = transform.structured.vectorize_children_and_apply_patterns %4 : (!transform.any_op) -> !transform.any_op
    transform.yield 
  }
}

