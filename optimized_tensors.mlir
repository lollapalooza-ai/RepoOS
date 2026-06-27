#map = affine_map<()[s0] -> (s0 ceildiv 8)>
#map1 = affine_map<(d0) -> (d0 * 8)>
#map2 = affine_map<(d0)[s0] -> (-d0 + s0, 8)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1, 0)>
#map5 = affine_map<(d0) -> (-d0 + 1, 8)>
#map6 = affine_map<(d0, d1, d2) -> (d2)>
#map7 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map8 = affine_map<(d0)[s0] -> (d0 + s0)>
#map9 = affine_map<(d0, d1, d2) -> (d1, d2)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: tensor<?x?x?xf32>, %arg1: tensor<?x?x?xf32>, %arg2: tensor<?x?xf32>, %arg3: tensor<?x?xf32>, %arg4: tensor<?xf32>, %arg5: tensor<?xf32>, %arg6: tensor<?xf32>, %arg7: tensor<?xf32>, %arg8: tensor<?x?x?xf32>) -> tensor<?x?x?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %c0_i64 = arith.constant 0 : i64
    %cst_0 = arith.constant 0.000000e+00 : f64
    %cst_1 = arith.constant 0xFF800000 : f32
    %cst_2 = arith.constant 1.000000e+00 : f32
    %cst_3 = arith.constant 5.000000e-01 : f32
    %cst_4 = arith.constant 1.000000e-05 : f64
    %cst_5 = arith.constant 8.000000e+00 : f32
    %cst_6 = arith.constant 1.41421354 : f32
    %dim = tensor.dim %arg0, %c0 : tensor<?x?x?xf32>
    %dim_7 = tensor.dim %arg0, %c1 : tensor<?x?x?xf32>
    %0 = tensor.empty(%dim, %dim_7) : tensor<?x?x1xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<?x?x1xf32>) -> tensor<?x?x1xf32>
    %dim_8 = tensor.dim %arg0, %c0 : tensor<?x?x?xf32>
    %dim_9 = tensor.dim %arg0, %c1 : tensor<?x?x?xf32>
    %dim_10 = tensor.dim %arg0, %c2 : tensor<?x?x?xf32>
    %2 = affine.apply #map()[%dim_10]
    %3 = scf.forall (%arg9) in (%2) shared_outs(%arg10 = %1) -> (tensor<?x?x1xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_10]
      %extracted_slice = tensor.extract_slice %arg0[0, 0, %119] [%dim_8, %dim_9, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, 0] [%dim_8, %dim_9, 1] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x1xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%extracted_slice : tensor<?x?x?xf32>) outs(%extracted_slice_156 : tensor<?x?x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %122 = arith.addf %in, %out : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x1xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, 0] [%dim_8, %dim_9, 1] [1, 1, 1] : tensor<?x?x1xf32> into tensor<?x?x1xf32>
      }
    }
    %dim_11 = tensor.dim %arg0, %c2 : tensor<?x?x?xf32>
    %4 = arith.index_cast %dim_11 : index to i64
    %dim_12 = tensor.dim %3, %c0 : tensor<?x?x1xf32>
    %dim_13 = tensor.dim %3, %c1 : tensor<?x?x1xf32>
    %5 = scf.forall (%arg9) in (1) shared_outs(%arg10 = %0) -> (tensor<?x?x1xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map5(%119)
      %extracted_slice = tensor.extract_slice %3[0, 0, %119] [%dim_12, %dim_13, %120] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, %119] [%dim_12, %dim_13, %120] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?x?xf32>) outs(%extracted_slice_156 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %out: f32):
        %122 = arith.sitofp %4 : i64 to f32
        %123 = arith.divf %in, %122 : f32
        linalg.yield %123 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_12, %dim_13, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x1xf32>
      }
    }
    %6 = tensor.empty(%dim, %dim_7, %dim_11) : tensor<?x?x?xf64>
    %dim_14 = tensor.dim %arg0, %c0 : tensor<?x?x?xf32>
    %dim_15 = tensor.dim %arg0, %c1 : tensor<?x?x?xf32>
    %dim_16 = tensor.dim %arg0, %c2 : tensor<?x?x?xf32>
    %7 = affine.apply #map()[%dim_16]
    %8 = scf.forall (%arg9) in (%7) shared_outs(%arg10 = %6) -> (tensor<?x?x?xf64>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_16]
      %extracted_slice = tensor.extract_slice %arg0[0, 0, %119] [%dim_14, %dim_15, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, %119] [%dim_14, %dim_15, %120] [1, 1, 1] : tensor<?x?x?xf64> to tensor<?x?x?xf64>
      %121 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?x?xf32>) outs(%extracted_slice_156 : tensor<?x?x?xf64>) {
      ^bb0(%in: f32, %out: f64):
        %122 = arith.extf %in : f32 to f64
        linalg.yield %122 : f64
      } -> tensor<?x?x?xf64>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_14, %dim_15, %120] [1, 1, 1] : tensor<?x?x?xf64> into tensor<?x?x?xf64>
      }
    }
    %9 = tensor.empty(%dim, %dim_7) : tensor<?x?x1xf64>
    %10 = linalg.fill ins(%cst_0 : f64) outs(%9 : tensor<?x?x1xf64>) -> tensor<?x?x1xf64>
    %dim_17 = tensor.dim %8, %c0 : tensor<?x?x?xf64>
    %dim_18 = tensor.dim %8, %c1 : tensor<?x?x?xf64>
    %dim_19 = tensor.dim %8, %c2 : tensor<?x?x?xf64>
    %11 = affine.apply #map()[%dim_19]
    %12 = scf.forall (%arg9) in (%11) shared_outs(%arg10 = %10) -> (tensor<?x?x1xf64>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_19]
      %extracted_slice = tensor.extract_slice %8[0, 0, %119] [%dim_17, %dim_18, %120] [1, 1, 1] : tensor<?x?x?xf64> to tensor<?x?x?xf64>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, 0] [%dim_17, %dim_18, 1] [1, 1, 1] : tensor<?x?x1xf64> to tensor<?x?x1xf64>
      %121 = linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%extracted_slice : tensor<?x?x?xf64>) outs(%extracted_slice_156 : tensor<?x?x1xf64>) {
      ^bb0(%in: f64, %out: f64):
        %122 = arith.addf %in, %out : f64
        linalg.yield %122 : f64
      } -> tensor<?x?x1xf64>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, 0] [%dim_17, %dim_18, 1] [1, 1, 1] : tensor<?x?x1xf64> into tensor<?x?x1xf64>
      }
    }
    %dim_20 = tensor.dim %12, %c0 : tensor<?x?x1xf64>
    %dim_21 = tensor.dim %12, %c1 : tensor<?x?x1xf64>
    %13 = scf.forall (%arg9) in (1) shared_outs(%arg10 = %9) -> (tensor<?x?x1xf64>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map5(%119)
      %extracted_slice = tensor.extract_slice %12[0, 0, %119] [%dim_20, %dim_21, %120] [1, 1, 1] : tensor<?x?x1xf64> to tensor<?x?x?xf64>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, %119] [%dim_20, %dim_21, %120] [1, 1, 1] : tensor<?x?x1xf64> to tensor<?x?x?xf64>
      %121 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?x?xf64>) outs(%extracted_slice_156 : tensor<?x?x?xf64>) {
      ^bb0(%in: f64, %out: f64):
        %122 = arith.sitofp %4 : i64 to f64
        %123 = arith.divf %in, %122 : f64
        linalg.yield %123 : f64
      } -> tensor<?x?x?xf64>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_20, %dim_21, %120] [1, 1, 1] : tensor<?x?x?xf64> into tensor<?x?x1xf64>
      }
    }
    %dim_22 = tensor.dim %8, %c0 : tensor<?x?x?xf64>
    %dim_23 = tensor.dim %8, %c1 : tensor<?x?x?xf64>
    %dim_24 = tensor.dim %8, %c2 : tensor<?x?x?xf64>
    %14 = affine.apply #map()[%dim_24]
    %15 = scf.forall (%arg9) in (%14) shared_outs(%arg10 = %6) -> (tensor<?x?x?xf64>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_24]
      %extracted_slice = tensor.extract_slice %8[0, 0, %119] [%dim_22, %dim_23, %120] [1, 1, 1] : tensor<?x?x?xf64> to tensor<?x?x?xf64>
      %extracted_slice_156 = tensor.extract_slice %13[0, 0, 0] [%dim_22, %dim_23, 1] [1, 1, 1] : tensor<?x?x1xf64> to tensor<?x?x1xf64>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, %119] [%dim_22, %dim_23, %120] [1, 1, 1] : tensor<?x?x?xf64> to tensor<?x?x?xf64>
      %121 = linalg.generic {indexing_maps = [#map3, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf64>, tensor<?x?x1xf64>) outs(%extracted_slice_157 : tensor<?x?x?xf64>) {
      ^bb0(%in: f64, %in_158: f64, %out: f64):
        %122 = arith.subf %in, %in_158 : f64
        linalg.yield %122 : f64
      } -> tensor<?x?x?xf64>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_22, %dim_23, %120] [1, 1, 1] : tensor<?x?x?xf64> into tensor<?x?x?xf64>
      }
    }
    %dim_25 = tensor.dim %15, %c0 : tensor<?x?x?xf64>
    %dim_26 = tensor.dim %15, %c1 : tensor<?x?x?xf64>
    %dim_27 = tensor.dim %15, %c2 : tensor<?x?x?xf64>
    %16 = affine.apply #map()[%dim_27]
    %17 = scf.forall (%arg9) in (%16) shared_outs(%arg10 = %6) -> (tensor<?x?x?xf64>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_27]
      %extracted_slice = tensor.extract_slice %15[0, 0, %119] [%dim_25, %dim_26, %120] [1, 1, 1] : tensor<?x?x?xf64> to tensor<?x?x?xf64>
      %extracted_slice_156 = tensor.extract_slice %15[0, 0, %119] [%dim_25, %dim_26, %120] [1, 1, 1] : tensor<?x?x?xf64> to tensor<?x?x?xf64>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, %119] [%dim_25, %dim_26, %120] [1, 1, 1] : tensor<?x?x?xf64> to tensor<?x?x?xf64>
      %121 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf64>, tensor<?x?x?xf64>) outs(%extracted_slice_157 : tensor<?x?x?xf64>) {
      ^bb0(%in: f64, %in_158: f64, %out: f64):
        %122 = arith.mulf %in, %in_158 : f64
        linalg.yield %122 : f64
      } -> tensor<?x?x?xf64>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_25, %dim_26, %120] [1, 1, 1] : tensor<?x?x?xf64> into tensor<?x?x?xf64>
      }
    }
    %dim_28 = tensor.dim %17, %c0 : tensor<?x?x?xf64>
    %dim_29 = tensor.dim %17, %c1 : tensor<?x?x?xf64>
    %dim_30 = tensor.dim %17, %c2 : tensor<?x?x?xf64>
    %18 = affine.apply #map()[%dim_30]
    %19 = scf.forall (%arg9) in (%18) shared_outs(%arg10 = %10) -> (tensor<?x?x1xf64>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_30]
      %extracted_slice = tensor.extract_slice %17[0, 0, %119] [%dim_28, %dim_29, %120] [1, 1, 1] : tensor<?x?x?xf64> to tensor<?x?x?xf64>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, 0] [%dim_28, %dim_29, 1] [1, 1, 1] : tensor<?x?x1xf64> to tensor<?x?x1xf64>
      %121 = linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%extracted_slice : tensor<?x?x?xf64>) outs(%extracted_slice_156 : tensor<?x?x1xf64>) {
      ^bb0(%in: f64, %out: f64):
        %122 = arith.addf %in, %out : f64
        linalg.yield %122 : f64
      } -> tensor<?x?x1xf64>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, 0] [%dim_28, %dim_29, 1] [1, 1, 1] : tensor<?x?x1xf64> into tensor<?x?x1xf64>
      }
    }
    %dim_31 = tensor.dim %19, %c0 : tensor<?x?x1xf64>
    %dim_32 = tensor.dim %19, %c1 : tensor<?x?x1xf64>
    %20 = scf.forall (%arg9) in (1) shared_outs(%arg10 = %9) -> (tensor<?x?x1xf64>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map5(%119)
      %extracted_slice = tensor.extract_slice %19[0, 0, %119] [%dim_31, %dim_32, %120] [1, 1, 1] : tensor<?x?x1xf64> to tensor<?x?x?xf64>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, %119] [%dim_31, %dim_32, %120] [1, 1, 1] : tensor<?x?x1xf64> to tensor<?x?x?xf64>
      %121 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?x?xf64>) outs(%extracted_slice_156 : tensor<?x?x?xf64>) {
      ^bb0(%in: f64, %out: f64):
        %122 = arith.sitofp %4 : i64 to f64
        %123 = arith.divf %in, %122 : f64
        linalg.yield %123 : f64
      } -> tensor<?x?x?xf64>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_31, %dim_32, %120] [1, 1, 1] : tensor<?x?x?xf64> into tensor<?x?x1xf64>
      }
    }
    %dim_33 = tensor.dim %20, %c0 : tensor<?x?x1xf64>
    %dim_34 = tensor.dim %20, %c1 : tensor<?x?x1xf64>
    %21 = scf.forall (%arg9) in (1) shared_outs(%arg10 = %0) -> (tensor<?x?x1xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map5(%119)
      %extracted_slice = tensor.extract_slice %20[0, 0, %119] [%dim_33, %dim_34, %120] [1, 1, 1] : tensor<?x?x1xf64> to tensor<?x?x?xf64>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, %119] [%dim_33, %dim_34, %120] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?x?xf64>) outs(%extracted_slice_156 : tensor<?x?x?xf32>) {
      ^bb0(%in: f64, %out: f32):
        %122 = arith.truncf %in : f64 to f32
        linalg.yield %122 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_33, %dim_34, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x1xf32>
      }
    }
    %22 = tensor.empty(%dim, %dim_7, %dim_11) : tensor<?x?x?xf32>
    %dim_35 = tensor.dim %arg0, %c0 : tensor<?x?x?xf32>
    %dim_36 = tensor.dim %arg0, %c1 : tensor<?x?x?xf32>
    %dim_37 = tensor.dim %arg0, %c2 : tensor<?x?x?xf32>
    %23 = affine.apply #map()[%dim_37]
    %24 = scf.forall (%arg9) in (%23) shared_outs(%arg10 = %22) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_37]
      %extracted_slice = tensor.extract_slice %arg0[0, 0, %119] [%dim_35, %dim_36, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %5[0, 0, 0] [%dim_35, %dim_36, 1] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x1xf32>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, %119] [%dim_35, %dim_36, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf32>, tensor<?x?x1xf32>) outs(%extracted_slice_157 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %in_158: f32, %out: f32):
        %122 = arith.subf %in, %in_158 : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_35, %dim_36, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %dim_38 = tensor.dim %21, %c0 : tensor<?x?x1xf32>
    %dim_39 = tensor.dim %21, %c1 : tensor<?x?x1xf32>
    %25 = scf.forall (%arg9) in (1) shared_outs(%arg10 = %0) -> (tensor<?x?x1xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map5(%119)
      %extracted_slice = tensor.extract_slice %21[0, 0, %119] [%dim_38, %dim_39, %120] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, %119] [%dim_38, %dim_39, %120] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?x?xf32>) outs(%extracted_slice_156 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %out: f32):
        %122 = arith.truncf %cst_4 : f64 to f32
        %123 = arith.addf %in, %122 : f32
        linalg.yield %123 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_38, %dim_39, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x1xf32>
      }
    }
    %dim_40 = tensor.dim %25, %c0 : tensor<?x?x1xf32>
    %dim_41 = tensor.dim %25, %c1 : tensor<?x?x1xf32>
    %26 = scf.forall (%arg9) in (1) shared_outs(%arg10 = %0) -> (tensor<?x?x1xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map5(%119)
      %extracted_slice = tensor.extract_slice %25[0, 0, %119] [%dim_40, %dim_41, %120] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, %119] [%dim_40, %dim_41, %120] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?x?xf32>) outs(%extracted_slice_156 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %out: f32):
        %122 = math.sqrt %in : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_40, %dim_41, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x1xf32>
      }
    }
    %dim_42 = tensor.dim %24, %c0 : tensor<?x?x?xf32>
    %dim_43 = tensor.dim %24, %c1 : tensor<?x?x?xf32>
    %dim_44 = tensor.dim %24, %c2 : tensor<?x?x?xf32>
    %27 = affine.apply #map()[%dim_44]
    %28 = scf.forall (%arg9) in (%27) shared_outs(%arg10 = %22) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_44]
      %extracted_slice = tensor.extract_slice %24[0, 0, %119] [%dim_42, %dim_43, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %26[0, 0, 0] [%dim_42, %dim_43, 1] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x1xf32>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, %119] [%dim_42, %dim_43, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf32>, tensor<?x?x1xf32>) outs(%extracted_slice_157 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %in_158: f32, %out: f32):
        %122 = arith.divf %in, %in_158 : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_42, %dim_43, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %dim_45 = tensor.dim %arg4, %c0 : tensor<?xf32>
    %29 = arith.cmpi eq, %dim_11, %dim_45 : index
    cf.assert %29, "mismatched size for broadcast"
    %dim_46 = tensor.dim %28, %c0 : tensor<?x?x?xf32>
    %dim_47 = tensor.dim %28, %c1 : tensor<?x?x?xf32>
    %dim_48 = tensor.dim %28, %c2 : tensor<?x?x?xf32>
    %30 = affine.apply #map()[%dim_48]
    %31 = scf.forall (%arg9) in (%30) shared_outs(%arg10 = %22) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_48]
      %extracted_slice = tensor.extract_slice %28[0, 0, %119] [%dim_46, %dim_47, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg4[%119] [%120] [1] : tensor<?xf32> to tensor<?xf32>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, %119] [%dim_46, %dim_47, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf32>, tensor<?xf32>) outs(%extracted_slice_157 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %in_158: f32, %out: f32):
        %122 = arith.mulf %in, %in_158 : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_46, %dim_47, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %dim_49 = tensor.dim %arg5, %c0 : tensor<?xf32>
    %32 = arith.cmpi eq, %dim_11, %dim_49 : index
    cf.assert %32, "mismatched size for broadcast"
    %dim_50 = tensor.dim %31, %c0 : tensor<?x?x?xf32>
    %dim_51 = tensor.dim %31, %c1 : tensor<?x?x?xf32>
    %dim_52 = tensor.dim %31, %c2 : tensor<?x?x?xf32>
    %33 = affine.apply #map()[%dim_52]
    %34 = scf.forall (%arg9) in (%33) shared_outs(%arg10 = %22) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_52]
      %extracted_slice = tensor.extract_slice %31[0, 0, %119] [%dim_50, %dim_51, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg5[%119] [%120] [1] : tensor<?xf32> to tensor<?xf32>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, %119] [%dim_50, %dim_51, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf32>, tensor<?xf32>) outs(%extracted_slice_157 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %in_158: f32, %out: f32):
        %122 = arith.addf %in, %in_158 : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_50, %dim_51, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %35 = tensor.empty(%dim, %dim_11, %dim_7) : tensor<?x?x?xf32>
    %transposed = linalg.transpose ins(%34 : tensor<?x?x?xf32>) outs(%35 : tensor<?x?x?xf32>) permutation = [0, 2, 1] 
    %36 = tensor.empty(%dim, %dim_7, %dim_7) : tensor<?x?x?xf32>
    %37 = linalg.fill ins(%cst : f32) outs(%36 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %dim_53 = tensor.dim %34, %c0 : tensor<?x?x?xf32>
    %dim_54 = tensor.dim %34, %c1 : tensor<?x?x?xf32>
    %dim_55 = tensor.dim %34, %c2 : tensor<?x?x?xf32>
    %dim_56 = tensor.dim %transposed, %c2 : tensor<?x?x?xf32>
    %38 = affine.apply #map()[%dim_55]
    %39 = scf.forall (%arg9) in (%38) shared_outs(%arg10 = %37) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_55]
      %extracted_slice = tensor.extract_slice %34[0, 0, %119] [%dim_53, %dim_54, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %transposed[0, %119, 0] [%dim_53, %120, %dim_56] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, 0] [%dim_53, %dim_54, %dim_56] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.batch_matmul ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf32>, tensor<?x?x?xf32>) outs(%extracted_slice_157 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, 0] [%dim_53, %dim_54, %dim_56] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %dim_57 = tensor.dim %39, %c0 : tensor<?x?x?xf32>
    %dim_58 = tensor.dim %39, %c1 : tensor<?x?x?xf32>
    %dim_59 = tensor.dim %39, %c2 : tensor<?x?x?xf32>
    %40 = affine.apply #map()[%dim_59]
    %41 = scf.forall (%arg9) in (%40) shared_outs(%arg10 = %36) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_59]
      %extracted_slice = tensor.extract_slice %39[0, 0, %119] [%dim_57, %dim_58, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, %119] [%dim_57, %dim_58, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?x?xf32>) outs(%extracted_slice_156 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %out: f32):
        %122 = arith.divf %in, %cst_5 : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_57, %dim_58, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %dim_60 = tensor.dim %arg1, %c0 : tensor<?x?x?xf32>
    %42 = arith.cmpi eq, %dim, %dim_60 : index
    cf.assert %42, "mismatched size for broadcast"
    %dim_61 = tensor.dim %arg1, %c1 : tensor<?x?x?xf32>
    %43 = arith.cmpi eq, %dim_7, %dim_61 : index
    cf.assert %43, "mismatched size for broadcast"
    %dim_62 = tensor.dim %arg1, %c2 : tensor<?x?x?xf32>
    %44 = arith.cmpi eq, %dim_7, %dim_62 : index
    cf.assert %44, "mismatched size for broadcast"
    %dim_63 = tensor.dim %41, %c0 : tensor<?x?x?xf32>
    %dim_64 = tensor.dim %41, %c1 : tensor<?x?x?xf32>
    %dim_65 = tensor.dim %41, %c2 : tensor<?x?x?xf32>
    %45 = affine.apply #map()[%dim_65]
    %46 = scf.forall (%arg9) in (%45) shared_outs(%arg10 = %36) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_65]
      %extracted_slice = tensor.extract_slice %41[0, 0, %119] [%dim_63, %dim_64, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg1[0, 0, %119] [%dim_63, %dim_64, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, %119] [%dim_63, %dim_64, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf32>, tensor<?x?x?xf32>) outs(%extracted_slice_157 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %in_158: f32, %out: f32):
        %122 = arith.addf %in, %in_158 : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_63, %dim_64, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %47 = tensor.empty(%dim, %dim_7) : tensor<?x?xi64>
    %48 = linalg.fill ins(%c0_i64 : i64) outs(%47 : tensor<?x?xi64>) -> tensor<?x?xi64>
    %49 = tensor.empty(%dim, %dim_7) : tensor<?x?xf32>
    %50 = linalg.fill ins(%cst_1 : f32) outs(%49 : tensor<?x?xf32>) -> tensor<?x?xf32>
    %dim_66 = tensor.dim %46, %c0 : tensor<?x?x?xf32>
    %dim_67 = tensor.dim %46, %c1 : tensor<?x?x?xf32>
    %dim_68 = tensor.dim %46, %c2 : tensor<?x?x?xf32>
    %51 = affine.apply #map()[%dim_68]
    %52:2 = scf.forall (%arg9) in (%51) shared_outs(%arg10 = %50, %arg11 = %48) -> (tensor<?x?xf32>, tensor<?x?xi64>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_68]
      %extracted_slice = tensor.extract_slice %46[0, 0, %119] [%dim_66, %dim_67, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0] [%dim_66, %dim_67] [1, 1] : tensor<?x?xf32> to tensor<?x?xf32>
      %extracted_slice_157 = tensor.extract_slice %arg11[0, 0] [%dim_66, %dim_67] [1, 1] : tensor<?x?xi64> to tensor<?x?xi64>
      %121:2 = linalg.generic {indexing_maps = [#map3, #map7, #map7], iterator_types = ["parallel", "parallel", "reduction"]} ins(%extracted_slice : tensor<?x?x?xf32>) outs(%extracted_slice_156, %extracted_slice_157 : tensor<?x?xf32>, tensor<?x?xi64>) {
      ^bb0(%in: f32, %out: f32, %out_158: i64):
        %122 = linalg.index 2 : index
        %123 = affine.apply #map8(%119)[%122]
        %124 = arith.index_cast %123 : index to i64
        %125 = arith.maximumf %in, %out : f32
        %126 = arith.cmpf ogt, %in, %out : f32
        %127 = arith.select %126, %124, %out_158 : i64
        linalg.yield %125, %127 : f32, i64
      } -> (tensor<?x?xf32>, tensor<?x?xi64>)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121#0 into %arg10[0, 0] [%dim_66, %dim_67] [1, 1] : tensor<?x?xf32> into tensor<?x?xf32>
        tensor.parallel_insert_slice %121#1 into %arg11[0, 0] [%dim_66, %dim_67] [1, 1] : tensor<?x?xi64> into tensor<?x?xi64>
      }
    }
    %expanded = tensor.expand_shape %52#0 [[0], [1, 2]] output_shape [%dim, %dim_7, 1] : tensor<?x?xf32> into tensor<?x?x1xf32>
    %dim_69 = tensor.dim %46, %c0 : tensor<?x?x?xf32>
    %dim_70 = tensor.dim %46, %c1 : tensor<?x?x?xf32>
    %dim_71 = tensor.dim %46, %c2 : tensor<?x?x?xf32>
    %53 = affine.apply #map()[%dim_71]
    %54 = scf.forall (%arg9) in (%53) shared_outs(%arg10 = %36) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_71]
      %extracted_slice = tensor.extract_slice %46[0, 0, %119] [%dim_69, %dim_70, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %expanded[0, 0, 0] [%dim_69, %dim_70, 1] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x1xf32>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, %119] [%dim_69, %dim_70, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf32>, tensor<?x?x1xf32>) outs(%extracted_slice_157 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %in_158: f32, %out: f32):
        %122 = arith.subf %in, %in_158 : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_69, %dim_70, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %dim_72 = tensor.dim %54, %c0 : tensor<?x?x?xf32>
    %dim_73 = tensor.dim %54, %c1 : tensor<?x?x?xf32>
    %dim_74 = tensor.dim %54, %c2 : tensor<?x?x?xf32>
    %55 = affine.apply #map()[%dim_74]
    %56 = scf.forall (%arg9) in (%55) shared_outs(%arg10 = %36) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_74]
      %extracted_slice = tensor.extract_slice %54[0, 0, %119] [%dim_72, %dim_73, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, %119] [%dim_72, %dim_73, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?x?xf32>) outs(%extracted_slice_156 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %out: f32):
        %122 = math.exp %in : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_72, %dim_73, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %dim_75 = tensor.dim %56, %c0 : tensor<?x?x?xf32>
    %dim_76 = tensor.dim %56, %c1 : tensor<?x?x?xf32>
    %dim_77 = tensor.dim %56, %c2 : tensor<?x?x?xf32>
    %57 = affine.apply #map()[%dim_77]
    %58 = scf.forall (%arg9) in (%57) shared_outs(%arg10 = %1) -> (tensor<?x?x1xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_77]
      %extracted_slice = tensor.extract_slice %56[0, 0, %119] [%dim_75, %dim_76, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, 0] [%dim_75, %dim_76, 1] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x1xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%extracted_slice : tensor<?x?x?xf32>) outs(%extracted_slice_156 : tensor<?x?x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %122 = arith.addf %in, %out : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x1xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, 0] [%dim_75, %dim_76, 1] [1, 1, 1] : tensor<?x?x1xf32> into tensor<?x?x1xf32>
      }
    }
    %dim_78 = tensor.dim %56, %c0 : tensor<?x?x?xf32>
    %dim_79 = tensor.dim %56, %c1 : tensor<?x?x?xf32>
    %dim_80 = tensor.dim %56, %c2 : tensor<?x?x?xf32>
    %59 = affine.apply #map()[%dim_80]
    %60 = scf.forall (%arg9) in (%59) shared_outs(%arg10 = %36) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_80]
      %extracted_slice = tensor.extract_slice %56[0, 0, %119] [%dim_78, %dim_79, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %58[0, 0, 0] [%dim_78, %dim_79, 1] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x1xf32>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, %119] [%dim_78, %dim_79, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf32>, tensor<?x?x1xf32>) outs(%extracted_slice_157 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %in_158: f32, %out: f32):
        %122 = arith.divf %in, %in_158 : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_78, %dim_79, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %61 = linalg.fill ins(%cst : f32) outs(%22 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %dim_81 = tensor.dim %60, %c0 : tensor<?x?x?xf32>
    %dim_82 = tensor.dim %60, %c1 : tensor<?x?x?xf32>
    %dim_83 = tensor.dim %60, %c2 : tensor<?x?x?xf32>
    %dim_84 = tensor.dim %34, %c2 : tensor<?x?x?xf32>
    %62 = affine.apply #map()[%dim_83]
    %63 = scf.forall (%arg9) in (%62) shared_outs(%arg10 = %61) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_83]
      %extracted_slice = tensor.extract_slice %60[0, 0, %119] [%dim_81, %dim_82, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %34[0, %119, 0] [%dim_81, %120, %dim_84] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, 0] [%dim_81, %dim_82, %dim_84] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.batch_matmul ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf32>, tensor<?x?x?xf32>) outs(%extracted_slice_157 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, 0] [%dim_81, %dim_82, %dim_84] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %dim_85 = tensor.dim %arg0, %c0 : tensor<?x?x?xf32>
    %dim_86 = tensor.dim %arg0, %c1 : tensor<?x?x?xf32>
    %dim_87 = tensor.dim %arg0, %c2 : tensor<?x?x?xf32>
    %64 = affine.apply #map()[%dim_87]
    %65 = scf.forall (%arg9) in (%64) shared_outs(%arg10 = %22) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_87]
      %extracted_slice = tensor.extract_slice %arg0[0, 0, %119] [%dim_85, %dim_86, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %63[0, 0, %119] [%dim_85, %dim_86, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, %119] [%dim_85, %dim_86, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf32>, tensor<?x?x?xf32>) outs(%extracted_slice_157 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %in_158: f32, %out: f32):
        %122 = arith.addf %in, %in_158 : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_85, %dim_86, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %dim_88 = tensor.dim %65, %c0 : tensor<?x?x?xf32>
    %dim_89 = tensor.dim %65, %c1 : tensor<?x?x?xf32>
    %dim_90 = tensor.dim %65, %c2 : tensor<?x?x?xf32>
    %66 = affine.apply #map()[%dim_90]
    %67 = scf.forall (%arg9) in (%66) shared_outs(%arg10 = %1) -> (tensor<?x?x1xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_90]
      %extracted_slice = tensor.extract_slice %65[0, 0, %119] [%dim_88, %dim_89, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, 0] [%dim_88, %dim_89, 1] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x1xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%extracted_slice : tensor<?x?x?xf32>) outs(%extracted_slice_156 : tensor<?x?x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %122 = arith.addf %in, %out : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x1xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, 0] [%dim_88, %dim_89, 1] [1, 1, 1] : tensor<?x?x1xf32> into tensor<?x?x1xf32>
      }
    }
    %dim_91 = tensor.dim %67, %c0 : tensor<?x?x1xf32>
    %dim_92 = tensor.dim %67, %c1 : tensor<?x?x1xf32>
    %68 = scf.forall (%arg9) in (1) shared_outs(%arg10 = %0) -> (tensor<?x?x1xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map5(%119)
      %extracted_slice = tensor.extract_slice %67[0, 0, %119] [%dim_91, %dim_92, %120] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, %119] [%dim_91, %dim_92, %120] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?x?xf32>) outs(%extracted_slice_156 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %out: f32):
        %122 = arith.sitofp %4 : i64 to f32
        %123 = arith.divf %in, %122 : f32
        linalg.yield %123 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_91, %dim_92, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x1xf32>
      }
    }
    %dim_93 = tensor.dim %65, %c0 : tensor<?x?x?xf32>
    %dim_94 = tensor.dim %65, %c1 : tensor<?x?x?xf32>
    %dim_95 = tensor.dim %65, %c2 : tensor<?x?x?xf32>
    %69 = affine.apply #map()[%dim_95]
    %70 = scf.forall (%arg9) in (%69) shared_outs(%arg10 = %6) -> (tensor<?x?x?xf64>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_95]
      %extracted_slice = tensor.extract_slice %65[0, 0, %119] [%dim_93, %dim_94, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, %119] [%dim_93, %dim_94, %120] [1, 1, 1] : tensor<?x?x?xf64> to tensor<?x?x?xf64>
      %121 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?x?xf32>) outs(%extracted_slice_156 : tensor<?x?x?xf64>) {
      ^bb0(%in: f32, %out: f64):
        %122 = arith.extf %in : f32 to f64
        linalg.yield %122 : f64
      } -> tensor<?x?x?xf64>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_93, %dim_94, %120] [1, 1, 1] : tensor<?x?x?xf64> into tensor<?x?x?xf64>
      }
    }
    %dim_96 = tensor.dim %70, %c0 : tensor<?x?x?xf64>
    %dim_97 = tensor.dim %70, %c1 : tensor<?x?x?xf64>
    %dim_98 = tensor.dim %70, %c2 : tensor<?x?x?xf64>
    %71 = affine.apply #map()[%dim_98]
    %72 = scf.forall (%arg9) in (%71) shared_outs(%arg10 = %10) -> (tensor<?x?x1xf64>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_98]
      %extracted_slice = tensor.extract_slice %70[0, 0, %119] [%dim_96, %dim_97, %120] [1, 1, 1] : tensor<?x?x?xf64> to tensor<?x?x?xf64>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, 0] [%dim_96, %dim_97, 1] [1, 1, 1] : tensor<?x?x1xf64> to tensor<?x?x1xf64>
      %121 = linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%extracted_slice : tensor<?x?x?xf64>) outs(%extracted_slice_156 : tensor<?x?x1xf64>) {
      ^bb0(%in: f64, %out: f64):
        %122 = arith.addf %in, %out : f64
        linalg.yield %122 : f64
      } -> tensor<?x?x1xf64>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, 0] [%dim_96, %dim_97, 1] [1, 1, 1] : tensor<?x?x1xf64> into tensor<?x?x1xf64>
      }
    }
    %dim_99 = tensor.dim %72, %c0 : tensor<?x?x1xf64>
    %dim_100 = tensor.dim %72, %c1 : tensor<?x?x1xf64>
    %73 = scf.forall (%arg9) in (1) shared_outs(%arg10 = %9) -> (tensor<?x?x1xf64>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map5(%119)
      %extracted_slice = tensor.extract_slice %72[0, 0, %119] [%dim_99, %dim_100, %120] [1, 1, 1] : tensor<?x?x1xf64> to tensor<?x?x?xf64>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, %119] [%dim_99, %dim_100, %120] [1, 1, 1] : tensor<?x?x1xf64> to tensor<?x?x?xf64>
      %121 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?x?xf64>) outs(%extracted_slice_156 : tensor<?x?x?xf64>) {
      ^bb0(%in: f64, %out: f64):
        %122 = arith.sitofp %4 : i64 to f64
        %123 = arith.divf %in, %122 : f64
        linalg.yield %123 : f64
      } -> tensor<?x?x?xf64>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_99, %dim_100, %120] [1, 1, 1] : tensor<?x?x?xf64> into tensor<?x?x1xf64>
      }
    }
    %dim_101 = tensor.dim %70, %c0 : tensor<?x?x?xf64>
    %dim_102 = tensor.dim %70, %c1 : tensor<?x?x?xf64>
    %dim_103 = tensor.dim %70, %c2 : tensor<?x?x?xf64>
    %74 = affine.apply #map()[%dim_103]
    %75 = scf.forall (%arg9) in (%74) shared_outs(%arg10 = %6) -> (tensor<?x?x?xf64>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_103]
      %extracted_slice = tensor.extract_slice %70[0, 0, %119] [%dim_101, %dim_102, %120] [1, 1, 1] : tensor<?x?x?xf64> to tensor<?x?x?xf64>
      %extracted_slice_156 = tensor.extract_slice %73[0, 0, 0] [%dim_101, %dim_102, 1] [1, 1, 1] : tensor<?x?x1xf64> to tensor<?x?x1xf64>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, %119] [%dim_101, %dim_102, %120] [1, 1, 1] : tensor<?x?x?xf64> to tensor<?x?x?xf64>
      %121 = linalg.generic {indexing_maps = [#map3, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf64>, tensor<?x?x1xf64>) outs(%extracted_slice_157 : tensor<?x?x?xf64>) {
      ^bb0(%in: f64, %in_158: f64, %out: f64):
        %122 = arith.subf %in, %in_158 : f64
        linalg.yield %122 : f64
      } -> tensor<?x?x?xf64>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_101, %dim_102, %120] [1, 1, 1] : tensor<?x?x?xf64> into tensor<?x?x?xf64>
      }
    }
    %dim_104 = tensor.dim %75, %c0 : tensor<?x?x?xf64>
    %dim_105 = tensor.dim %75, %c1 : tensor<?x?x?xf64>
    %dim_106 = tensor.dim %75, %c2 : tensor<?x?x?xf64>
    %76 = affine.apply #map()[%dim_106]
    %77 = scf.forall (%arg9) in (%76) shared_outs(%arg10 = %6) -> (tensor<?x?x?xf64>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_106]
      %extracted_slice = tensor.extract_slice %75[0, 0, %119] [%dim_104, %dim_105, %120] [1, 1, 1] : tensor<?x?x?xf64> to tensor<?x?x?xf64>
      %extracted_slice_156 = tensor.extract_slice %75[0, 0, %119] [%dim_104, %dim_105, %120] [1, 1, 1] : tensor<?x?x?xf64> to tensor<?x?x?xf64>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, %119] [%dim_104, %dim_105, %120] [1, 1, 1] : tensor<?x?x?xf64> to tensor<?x?x?xf64>
      %121 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf64>, tensor<?x?x?xf64>) outs(%extracted_slice_157 : tensor<?x?x?xf64>) {
      ^bb0(%in: f64, %in_158: f64, %out: f64):
        %122 = arith.mulf %in, %in_158 : f64
        linalg.yield %122 : f64
      } -> tensor<?x?x?xf64>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_104, %dim_105, %120] [1, 1, 1] : tensor<?x?x?xf64> into tensor<?x?x?xf64>
      }
    }
    %dim_107 = tensor.dim %77, %c0 : tensor<?x?x?xf64>
    %dim_108 = tensor.dim %77, %c1 : tensor<?x?x?xf64>
    %dim_109 = tensor.dim %77, %c2 : tensor<?x?x?xf64>
    %78 = affine.apply #map()[%dim_109]
    %79 = scf.forall (%arg9) in (%78) shared_outs(%arg10 = %10) -> (tensor<?x?x1xf64>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_109]
      %extracted_slice = tensor.extract_slice %77[0, 0, %119] [%dim_107, %dim_108, %120] [1, 1, 1] : tensor<?x?x?xf64> to tensor<?x?x?xf64>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, 0] [%dim_107, %dim_108, 1] [1, 1, 1] : tensor<?x?x1xf64> to tensor<?x?x1xf64>
      %121 = linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%extracted_slice : tensor<?x?x?xf64>) outs(%extracted_slice_156 : tensor<?x?x1xf64>) {
      ^bb0(%in: f64, %out: f64):
        %122 = arith.addf %in, %out : f64
        linalg.yield %122 : f64
      } -> tensor<?x?x1xf64>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, 0] [%dim_107, %dim_108, 1] [1, 1, 1] : tensor<?x?x1xf64> into tensor<?x?x1xf64>
      }
    }
    %dim_110 = tensor.dim %79, %c0 : tensor<?x?x1xf64>
    %dim_111 = tensor.dim %79, %c1 : tensor<?x?x1xf64>
    %80 = scf.forall (%arg9) in (1) shared_outs(%arg10 = %9) -> (tensor<?x?x1xf64>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map5(%119)
      %extracted_slice = tensor.extract_slice %79[0, 0, %119] [%dim_110, %dim_111, %120] [1, 1, 1] : tensor<?x?x1xf64> to tensor<?x?x?xf64>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, %119] [%dim_110, %dim_111, %120] [1, 1, 1] : tensor<?x?x1xf64> to tensor<?x?x?xf64>
      %121 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?x?xf64>) outs(%extracted_slice_156 : tensor<?x?x?xf64>) {
      ^bb0(%in: f64, %out: f64):
        %122 = arith.sitofp %4 : i64 to f64
        %123 = arith.divf %in, %122 : f64
        linalg.yield %123 : f64
      } -> tensor<?x?x?xf64>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_110, %dim_111, %120] [1, 1, 1] : tensor<?x?x?xf64> into tensor<?x?x1xf64>
      }
    }
    %dim_112 = tensor.dim %80, %c0 : tensor<?x?x1xf64>
    %dim_113 = tensor.dim %80, %c1 : tensor<?x?x1xf64>
    %81 = scf.forall (%arg9) in (1) shared_outs(%arg10 = %0) -> (tensor<?x?x1xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map5(%119)
      %extracted_slice = tensor.extract_slice %80[0, 0, %119] [%dim_112, %dim_113, %120] [1, 1, 1] : tensor<?x?x1xf64> to tensor<?x?x?xf64>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, %119] [%dim_112, %dim_113, %120] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?x?xf64>) outs(%extracted_slice_156 : tensor<?x?x?xf32>) {
      ^bb0(%in: f64, %out: f32):
        %122 = arith.truncf %in : f64 to f32
        linalg.yield %122 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_112, %dim_113, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x1xf32>
      }
    }
    %dim_114 = tensor.dim %65, %c0 : tensor<?x?x?xf32>
    %dim_115 = tensor.dim %65, %c1 : tensor<?x?x?xf32>
    %dim_116 = tensor.dim %65, %c2 : tensor<?x?x?xf32>
    %82 = affine.apply #map()[%dim_116]
    %83 = scf.forall (%arg9) in (%82) shared_outs(%arg10 = %22) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_116]
      %extracted_slice = tensor.extract_slice %65[0, 0, %119] [%dim_114, %dim_115, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %68[0, 0, 0] [%dim_114, %dim_115, 1] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x1xf32>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, %119] [%dim_114, %dim_115, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf32>, tensor<?x?x1xf32>) outs(%extracted_slice_157 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %in_158: f32, %out: f32):
        %122 = arith.subf %in, %in_158 : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_114, %dim_115, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %dim_117 = tensor.dim %81, %c0 : tensor<?x?x1xf32>
    %dim_118 = tensor.dim %81, %c1 : tensor<?x?x1xf32>
    %84 = scf.forall (%arg9) in (1) shared_outs(%arg10 = %0) -> (tensor<?x?x1xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map5(%119)
      %extracted_slice = tensor.extract_slice %81[0, 0, %119] [%dim_117, %dim_118, %120] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, %119] [%dim_117, %dim_118, %120] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?x?xf32>) outs(%extracted_slice_156 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %out: f32):
        %122 = arith.truncf %cst_4 : f64 to f32
        %123 = arith.addf %in, %122 : f32
        linalg.yield %123 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_117, %dim_118, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x1xf32>
      }
    }
    %dim_119 = tensor.dim %84, %c0 : tensor<?x?x1xf32>
    %dim_120 = tensor.dim %84, %c1 : tensor<?x?x1xf32>
    %85 = scf.forall (%arg9) in (1) shared_outs(%arg10 = %0) -> (tensor<?x?x1xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map5(%119)
      %extracted_slice = tensor.extract_slice %84[0, 0, %119] [%dim_119, %dim_120, %120] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, %119] [%dim_119, %dim_120, %120] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?x?xf32>) outs(%extracted_slice_156 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %out: f32):
        %122 = math.sqrt %in : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_119, %dim_120, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x1xf32>
      }
    }
    %dim_121 = tensor.dim %83, %c0 : tensor<?x?x?xf32>
    %dim_122 = tensor.dim %83, %c1 : tensor<?x?x?xf32>
    %dim_123 = tensor.dim %83, %c2 : tensor<?x?x?xf32>
    %86 = affine.apply #map()[%dim_123]
    %87 = scf.forall (%arg9) in (%86) shared_outs(%arg10 = %22) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_123]
      %extracted_slice = tensor.extract_slice %83[0, 0, %119] [%dim_121, %dim_122, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %85[0, 0, 0] [%dim_121, %dim_122, 1] [1, 1, 1] : tensor<?x?x1xf32> to tensor<?x?x1xf32>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, %119] [%dim_121, %dim_122, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf32>, tensor<?x?x1xf32>) outs(%extracted_slice_157 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %in_158: f32, %out: f32):
        %122 = arith.divf %in, %in_158 : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_121, %dim_122, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %dim_124 = tensor.dim %arg6, %c0 : tensor<?xf32>
    %88 = arith.cmpi eq, %dim_11, %dim_124 : index
    cf.assert %88, "mismatched size for broadcast"
    %dim_125 = tensor.dim %87, %c0 : tensor<?x?x?xf32>
    %dim_126 = tensor.dim %87, %c1 : tensor<?x?x?xf32>
    %dim_127 = tensor.dim %87, %c2 : tensor<?x?x?xf32>
    %89 = affine.apply #map()[%dim_127]
    %90 = scf.forall (%arg9) in (%89) shared_outs(%arg10 = %22) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_127]
      %extracted_slice = tensor.extract_slice %87[0, 0, %119] [%dim_125, %dim_126, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg6[%119] [%120] [1] : tensor<?xf32> to tensor<?xf32>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, %119] [%dim_125, %dim_126, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf32>, tensor<?xf32>) outs(%extracted_slice_157 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %in_158: f32, %out: f32):
        %122 = arith.mulf %in, %in_158 : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_125, %dim_126, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %dim_128 = tensor.dim %arg7, %c0 : tensor<?xf32>
    %91 = arith.cmpi eq, %dim_11, %dim_128 : index
    cf.assert %91, "mismatched size for broadcast"
    %dim_129 = tensor.dim %90, %c0 : tensor<?x?x?xf32>
    %dim_130 = tensor.dim %90, %c1 : tensor<?x?x?xf32>
    %dim_131 = tensor.dim %90, %c2 : tensor<?x?x?xf32>
    %92 = affine.apply #map()[%dim_131]
    %93 = scf.forall (%arg9) in (%92) shared_outs(%arg10 = %22) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_131]
      %extracted_slice = tensor.extract_slice %90[0, 0, %119] [%dim_129, %dim_130, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg7[%119] [%120] [1] : tensor<?xf32> to tensor<?xf32>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, %119] [%dim_129, %dim_130, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf32>, tensor<?xf32>) outs(%extracted_slice_157 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %in_158: f32, %out: f32):
        %122 = arith.addf %in, %in_158 : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_129, %dim_130, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %dim_132 = tensor.dim %arg2, %c0 : tensor<?x?xf32>
    %dim_133 = tensor.dim %arg2, %c1 : tensor<?x?xf32>
    %94 = arith.index_cast %dim_132 : index to i64
    %95 = arith.cmpi eq, %4, %94 : i64
    cf.assert %95, "mismatching contracting dimension"
    %96 = arith.index_cast %dim : index to i64
    %97 = arith.cmpi sge, %96, %c0_i64 : i64
    cf.assert %97, "negative values not allowed in new dimensions"
    %98 = tensor.empty(%dim, %dim_132, %dim_133) : tensor<?x?x?xf32>
    %dim_134 = tensor.dim %arg2, %c0 : tensor<?x?xf32>
    %dim_135 = tensor.dim %arg2, %c1 : tensor<?x?xf32>
    %dim_136 = tensor.dim %98, %c0 : tensor<?x?x?xf32>
    %99 = affine.apply #map()[%dim_135]
    %100 = scf.forall (%arg9) in (%99) shared_outs(%arg10 = %98) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_135]
      %extracted_slice = tensor.extract_slice %arg2[0, %119] [%dim_134, %120] [1, 1] : tensor<?x?xf32> to tensor<?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, %119] [%dim_136, %dim_134, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map9, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?xf32>) outs(%extracted_slice_156 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_136, %dim_134, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %101 = tensor.empty(%dim, %dim_7, %dim_133) : tensor<?x?x?xf32>
    %102 = linalg.fill ins(%cst : f32) outs(%101 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %dim_137 = tensor.dim %93, %c0 : tensor<?x?x?xf32>
    %dim_138 = tensor.dim %93, %c1 : tensor<?x?x?xf32>
    %dim_139 = tensor.dim %93, %c2 : tensor<?x?x?xf32>
    %dim_140 = tensor.dim %100, %c2 : tensor<?x?x?xf32>
    %103 = affine.apply #map()[%dim_139]
    %104 = scf.forall (%arg9) in (%103) shared_outs(%arg10 = %102) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_139]
      %extracted_slice = tensor.extract_slice %93[0, 0, %119] [%dim_137, %dim_138, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %100[0, %119, 0] [%dim_137, %120, %dim_140] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, 0] [%dim_137, %dim_138, %dim_140] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.batch_matmul ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf32>, tensor<?x?x?xf32>) outs(%extracted_slice_157 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, 0] [%dim_137, %dim_138, %dim_140] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %dim_141 = tensor.dim %104, %c0 : tensor<?x?x?xf32>
    %dim_142 = tensor.dim %104, %c1 : tensor<?x?x?xf32>
    %dim_143 = tensor.dim %104, %c2 : tensor<?x?x?xf32>
    %105 = affine.apply #map()[%dim_143]
    %106 = scf.forall (%arg9) in (%105) shared_outs(%arg10 = %101) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_143]
      %extracted_slice = tensor.extract_slice %104[0, 0, %119] [%dim_141, %dim_142, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, %119] [%dim_141, %dim_142, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?x?xf32>) outs(%extracted_slice_156 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %out: f32):
        %122 = arith.divf %in, %cst_6 : f32
        %123 = math.erf %122 : f32
        %124 = arith.addf %123, %cst_2 : f32
        %125 = arith.mulf %124, %cst_3 : f32
        %126 = arith.mulf %in, %125 : f32
        linalg.yield %126 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_141, %dim_142, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %dim_144 = tensor.dim %arg3, %c0 : tensor<?x?xf32>
    %dim_145 = tensor.dim %arg3, %c1 : tensor<?x?xf32>
    %107 = arith.index_cast %dim_133 : index to i64
    %108 = arith.index_cast %dim_144 : index to i64
    %109 = arith.cmpi eq, %107, %108 : i64
    cf.assert %109, "mismatching contracting dimension"
    cf.assert %97, "negative values not allowed in new dimensions"
    %110 = tensor.empty(%dim, %dim_144, %dim_145) : tensor<?x?x?xf32>
    %dim_146 = tensor.dim %arg3, %c0 : tensor<?x?xf32>
    %dim_147 = tensor.dim %arg3, %c1 : tensor<?x?xf32>
    %dim_148 = tensor.dim %110, %c0 : tensor<?x?x?xf32>
    %111 = affine.apply #map()[%dim_147]
    %112 = scf.forall (%arg9) in (%111) shared_outs(%arg10 = %110) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_147]
      %extracted_slice = tensor.extract_slice %arg3[0, %119] [%dim_146, %120] [1, 1] : tensor<?x?xf32> to tensor<?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %arg10[0, 0, %119] [%dim_148, %dim_146, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map9, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<?x?xf32>) outs(%extracted_slice_156 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_148, %dim_146, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %113 = linalg.fill ins(%cst : f32) outs(%arg8 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %dim_149 = tensor.dim %106, %c0 : tensor<?x?x?xf32>
    %dim_150 = tensor.dim %106, %c1 : tensor<?x?x?xf32>
    %dim_151 = tensor.dim %106, %c2 : tensor<?x?x?xf32>
    %dim_152 = tensor.dim %112, %c2 : tensor<?x?x?xf32>
    %114 = affine.apply #map()[%dim_151]
    %115 = scf.forall (%arg9) in (%114) shared_outs(%arg10 = %113) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_151]
      %extracted_slice = tensor.extract_slice %106[0, 0, %119] [%dim_149, %dim_150, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %112[0, %119, 0] [%dim_149, %120, %dim_152] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, 0] [%dim_149, %dim_150, %dim_152] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.batch_matmul ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf32>, tensor<?x?x?xf32>) outs(%extracted_slice_157 : tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, 0] [%dim_149, %dim_150, %dim_152] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    %116 = arith.cmpi eq, %dim_11, %dim_145 : index
    cf.assert %116, "mismatched size for broadcast"
    %dim_153 = tensor.dim %65, %c0 : tensor<?x?x?xf32>
    %dim_154 = tensor.dim %65, %c1 : tensor<?x?x?xf32>
    %dim_155 = tensor.dim %65, %c2 : tensor<?x?x?xf32>
    %117 = affine.apply #map()[%dim_155]
    %118 = scf.forall (%arg9) in (%117) shared_outs(%arg10 = %22) -> (tensor<?x?x?xf32>) {
      %119 = affine.apply #map1(%arg9)
      %120 = affine.min #map2(%119)[%dim_155]
      %extracted_slice = tensor.extract_slice %65[0, 0, %119] [%dim_153, %dim_154, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_156 = tensor.extract_slice %115[0, 0, %119] [%dim_153, %dim_154, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %extracted_slice_157 = tensor.extract_slice %arg10[0, 0, %119] [%dim_153, %dim_154, %120] [1, 1, 1] : tensor<?x?x?xf32> to tensor<?x?x?xf32>
      %121 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_156 : tensor<?x?x?xf32>, tensor<?x?x?xf32>) outs(%extracted_slice_157 : tensor<?x?x?xf32>) {
      ^bb0(%in: f32, %in_158: f32, %out: f32):
        %122 = arith.addf %in, %in_158 : f32
        linalg.yield %122 : f32
      } -> tensor<?x?x?xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %121 into %arg10[0, 0, %119] [%dim_153, %dim_154, %120] [1, 1, 1] : tensor<?x?x?xf32> into tensor<?x?x?xf32>
      }
    }
    return %118 : tensor<?x?x?xf32>
  }
  transform.named_sequence @__transform_main(%arg0: !transform.any_op) {
    %0 = transform.structured.match ops{["linalg.batch_matmul"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %tiled_op, %forall_op = transform.structured.tile_using_forall %0 tile_sizes [0, 0, 0, 8] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %1 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %2 = transform.structured.vectorize_children_and_apply_patterns %1 : (!transform.any_op) -> !transform.any_op
    %3 = transform.structured.match ops{["linalg.generic"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %tiled_op_0, %forall_op_1 = transform.structured.tile_using_forall %3 tile_sizes [0, 0, 8] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %4 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %5 = transform.structured.vectorize_children_and_apply_patterns %4 : (!transform.any_op) -> !transform.any_op
    transform.yield 
  }
}

