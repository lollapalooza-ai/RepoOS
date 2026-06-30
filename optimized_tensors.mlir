#map = affine_map<(d0) -> (d0 * 32)>
#map1 = affine_map<(d0) -> (-d0 + 2, 32)>
#map2 = affine_map<(d0) -> (d0 - 1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1, 0)>
#map5 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map6 = affine_map<(d0, d1, d2) -> (d2)>
#map7 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map8 = affine_map<(d0) -> (-d0 + 4, 32)>
#map9 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map10 = affine_map<(d0) -> (-d0 + 1, 32)>
#map11 = affine_map<(d0, d1, d2, d3) -> (0, 0, d2, d3)>
#map12 = affine_map<(d0, d1, d2, d3) -> ()>
#map13 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
#map14 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, 0)>
module attributes {transform.with_named_sequence} {
  func.func @main(%arg0: tensor<128xf32>, %arg1: tensor<128xf32>, %arg2: tensor<2x1024x128xf32>, %arg3: tensor<384x128xf32>, %arg4: tensor<384xf32>, %arg5: tensor<1x1x1024x1024xf32>, %arg6: tensor<128x128xf32>, %arg7: tensor<128xf32>, %arg8: tensor<128xf32>, %arg9: tensor<128xf32>, %arg10: tensor<512x128xf32>, %arg11: tensor<512xf32>, %arg12: tensor<128x512xf32>, %arg13: tensor<128xf32>, %arg14: tensor<128xf32>, %arg15: tensor<128xf32>, %arg16: tensor<384x128xf32>, %arg17: tensor<384xf32>, %arg18: tensor<1x1x1024x1024xf32>, %arg19: tensor<128x128xf32>, %arg20: tensor<128xf32>, %arg21: tensor<128xf32>, %arg22: tensor<128xf32>, %arg23: tensor<512x128xf32>, %arg24: tensor<512xf32>, %arg25: tensor<128x512xf32>, %arg26: tensor<128xf32>, %arg27: tensor<2x1024x128xf32>) -> tensor<2x1024x128xf32> {
    %c0_i64 = arith.constant 0 : i64
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 0xFF800000 : f32
    %cst_1 = arith.constant 1.000000e+00 : f32
    %cst_2 = arith.constant 5.000000e-01 : f32
    %cst_3 = arith.constant dense<0xFF800000> : tensor<f32>
    %cst_4 = arith.constant 0.17677669529663687 : f64
    %cst_5 = arith.constant 1.000000e-05 : f64
    %cst_6 = arith.constant 1.280000e+02 : f32
    %cst_7 = arith.constant 1.41421354 : f32
    %0 = tensor.empty() : tensor<2x1024x1xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<2x1024x1xf32>) -> tensor<2x1024x1xf32>
    %2 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %1) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %arg2[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%extracted_slice_41 : tensor<?x32x128xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.addf %in, %out : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %3 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %0) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %2[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32x1xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.divf %in, %cst_6 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %collapsed = tensor.collapse_shape %3 [[0], [1, 2]] : tensor<2x1024x1xf32> into tensor<2x1024xf32>
    %4 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %collapsed[%148, %149] [%150, 32] [1, 1] : tensor<2x1024xf32> to tensor<?x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map5, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32xf32>) outs(%extracted_slice_42 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %5 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %154 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %arg2[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %4[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %155 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<?x32x128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %158 = arith.subf %in, %in_44 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x128xf32>
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %155 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %6 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %154 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %5[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %5[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %155 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<?x32x128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %158 = arith.mulf %in, %in_44 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x128xf32>
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %155 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %7 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %1) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %6[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%extracted_slice_41 : tensor<?x32x128xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.addf %in, %out : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %8 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %0) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %7[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32x1xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.divf %in, %cst_6 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %9 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %0) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %8[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32x1xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.truncf %cst_5 : f64 to f32
        %158 = arith.addf %in, %157 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %10 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %0) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %9[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32x1xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = math.rsqrt %in : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %collapsed_8 = tensor.collapse_shape %10 [[0], [1, 2]] : tensor<2x1024x1xf32> into tensor<2x1024xf32>
    %11 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %collapsed_8[%148, %149] [%150, 32] [1, 1] : tensor<2x1024xf32> to tensor<?x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map5, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32xf32>) outs(%extracted_slice_42 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %12 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %154 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %5[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %11[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %155 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<?x32x128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %158 = arith.mulf %in, %in_44 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x128xf32>
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %155 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %13 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %12[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg0[0] [128] [1] : tensor<128xf32> to tensor<128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %157 = arith.mulf %in, %in_44 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %14 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %13[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg1[0] [128] [1] : tensor<128xf32> to tensor<128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %157 = arith.addf %in, %in_44 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %15 = tensor.empty() : tensor<128x384xf32>
    %16 = scf.forall (%arg28, %arg29) in (4, 12) shared_outs(%arg30 = %15) -> (tensor<128x384xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %extracted_slice_41 = tensor.extract_slice %arg3[%149, %148] [32, 32] [1, 1] : tensor<384x128xf32> to tensor<32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149] [32, 32] [1, 1] : tensor<128x384xf32> to tensor<32x32xf32>
      %transposed = linalg.transpose ins(%extracted_slice_41 : tensor<32x32xf32>) outs(%extracted_slice_42 : tensor<32x32xf32>) permutation = [1, 0] 
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %transposed into %arg30[%148, %149] [32, 32] [1, 1] : tensor<32x32xf32> into tensor<128x384xf32>
      }
    }
    %17 = tensor.empty() : tensor<2x128x384xf32>
    %18 = scf.forall (%arg28, %arg29) in (1, 4) shared_outs(%arg30 = %17) -> (tensor<2x128x384xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %16[%149, 0] [32, 384] [1, 1] : tensor<128x384xf32> to tensor<32x384xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 384] [1, 1, 1] : tensor<2x128x384xf32> to tensor<?x32x384xf32>
      %153 = linalg.generic {indexing_maps = [#map7, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<32x384xf32>) outs(%extracted_slice_42 : tensor<?x32x384xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x32x384xf32>
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %153 into %arg30[%148, %149, 0] [%150, 32, 384] [1, 1, 1] : tensor<?x32x384xf32> into tensor<2x128x384xf32>
      }
    }
    %19 = tensor.empty() : tensor<2x1024x384xf32>
    %20 = linalg.fill ins(%cst : f32) outs(%19 : tensor<2x1024x384xf32>) -> tensor<2x1024x384xf32>
    %21 = scf.forall (%arg28, %arg29, %arg30, %arg31) in (2, 32, 12, 4) shared_outs(%arg32 = %20) -> (tensor<2x1024x384xf32>) {
      %148 = affine.apply #map(%arg29)
      %149 = affine.apply #map(%arg30)
      %150 = affine.apply #map(%arg31)
      %extracted_slice_41 = tensor.extract_slice %14[%arg28, %148, %150] [1, 32, 32] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<1x32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %18[%arg28, %150, %149] [1, 32, 32] [1, 1, 1] : tensor<2x128x384xf32> to tensor<1x32x32xf32>
      %extracted_slice_43 = tensor.extract_slice %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<2x1024x384xf32> to tensor<1x32x32xf32>
      %151 = linalg.batch_matmul ins(%extracted_slice_41, %extracted_slice_42 : tensor<1x32x32xf32>, tensor<1x32x32xf32>) outs(%extracted_slice_43 : tensor<1x32x32xf32>) -> tensor<1x32x32xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %151 into %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<1x32x32xf32> into tensor<2x1024x384xf32>
      }
    }
    %22 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %19) -> (tensor<2x1024x384xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %21[%148, %149, 0] [%150, 32, 384] [1, 1, 1] : tensor<2x1024x384xf32> to tensor<?x32x384xf32>
      %extracted_slice_42 = tensor.extract_slice %arg4[0] [384] [1] : tensor<384xf32> to tensor<384xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 384] [1, 1, 1] : tensor<2x1024x384xf32> to tensor<?x32x384xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x384xf32>, tensor<384xf32>) outs(%extracted_slice_43 : tensor<?x32x384xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %157 = arith.addf %in, %in_44 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x384xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 384] [1, 1, 1] : tensor<?x32x384xf32> into tensor<2x1024x384xf32>
      }
    }
    %extracted_slice = tensor.extract_slice %22[0, 0, 0] [2, 1024, 128] [1, 1, 1] : tensor<2x1024x384xf32> to tensor<2x1024x128xf32>
    %extracted_slice_9 = tensor.extract_slice %22[0, 0, 128] [2, 1024, 128] [1, 1, 1] : tensor<2x1024x384xf32> to tensor<2x1024x128xf32>
    %extracted_slice_10 = tensor.extract_slice %22[0, 0, 256] [2, 1024, 128] [1, 1, 1] : tensor<2x1024x384xf32> to tensor<2x1024x128xf32>
    %expanded = tensor.expand_shape %extracted_slice_9 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : tensor<2x1024x128xf32> into tensor<2x1024x4x32xf32>
    %expanded_11 = tensor.expand_shape %extracted_slice [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : tensor<2x1024x128xf32> into tensor<2x1024x4x32xf32>
    %23 = tensor.empty() : tensor<2x4x1024x32xf32>
    %24 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %23) -> (tensor<2x4x1024x32xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %expanded_11[%148, 0, %149, 0] [%150, 1024, %151, 32] [1, 1, 1, 1] : tensor<2x1024x4x32xf32> to tensor<?x1024x?x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 1024, 32] [1, 1, 1, 1] : tensor<2x4x1024x32xf32> to tensor<?x?x1024x32xf32>
      %transposed = linalg.transpose ins(%extracted_slice_41 : tensor<?x1024x?x32xf32>) outs(%extracted_slice_42 : tensor<?x?x1024x32xf32>) permutation = [0, 2, 1, 3] 
      %158 = affine.apply #map2(%150)
      %159 = affine.apply #map2(%151)
      %160 = affine.apply #map2(%150)
      %161 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %transposed into %arg30[%148, %149, 0, 0] [%150, %151, 1024, 32] [1, 1, 1, 1] : tensor<?x?x1024x32xf32> into tensor<2x4x1024x32xf32>
      }
    }
    %expanded_12 = tensor.expand_shape %extracted_slice_10 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : tensor<2x1024x128xf32> into tensor<2x1024x4x32xf32>
    %25 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %23) -> (tensor<2x4x1024x32xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %expanded_12[%148, 0, %149, 0] [%150, 1024, %151, 32] [1, 1, 1, 1] : tensor<2x1024x4x32xf32> to tensor<?x1024x?x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 1024, 32] [1, 1, 1, 1] : tensor<2x4x1024x32xf32> to tensor<?x?x1024x32xf32>
      %transposed = linalg.transpose ins(%extracted_slice_41 : tensor<?x1024x?x32xf32>) outs(%extracted_slice_42 : tensor<?x?x1024x32xf32>) permutation = [0, 2, 1, 3] 
      %158 = affine.apply #map2(%150)
      %159 = affine.apply #map2(%151)
      %160 = affine.apply #map2(%150)
      %161 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %transposed into %arg30[%148, %149, 0, 0] [%150, %151, 1024, 32] [1, 1, 1, 1] : tensor<?x?x1024x32xf32> into tensor<2x4x1024x32xf32>
      }
    }
    %26 = tensor.empty() : tensor<2x4x32x1024xf32>
    %27 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %26) -> (tensor<2x4x32x1024xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %expanded[%148, 0, %149, 0] [%150, 1024, %151, 32] [1, 1, 1, 1] : tensor<2x1024x4x32xf32> to tensor<?x1024x?x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 32, 1024] [1, 1, 1, 1] : tensor<2x4x32x1024xf32> to tensor<?x?x32x1024xf32>
      %transposed = linalg.transpose ins(%extracted_slice_41 : tensor<?x1024x?x32xf32>) outs(%extracted_slice_42 : tensor<?x?x32x1024xf32>) permutation = [0, 2, 3, 1] 
      %158 = affine.apply #map2(%150)
      %159 = affine.apply #map2(%151)
      %160 = affine.apply #map2(%150)
      %161 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %transposed into %arg30[%148, %149, 0, 0] [%150, %151, 32, 1024] [1, 1, 1, 1] : tensor<?x?x32x1024xf32> into tensor<2x4x32x1024xf32>
      }
    }
    %collapsed_13 = tensor.collapse_shape %24 [[0, 1], [2], [3]] : tensor<2x4x1024x32xf32> into tensor<8x1024x32xf32>
    %collapsed_14 = tensor.collapse_shape %27 [[0, 1], [2], [3]] : tensor<2x4x32x1024xf32> into tensor<8x32x1024xf32>
    %28 = tensor.empty() : tensor<8x1024x1024xf32>
    %29 = linalg.fill ins(%cst : f32) outs(%28 : tensor<8x1024x1024xf32>) -> tensor<8x1024x1024xf32>
    %30 = scf.forall (%arg28, %arg29, %arg30, %arg31) in (8, 32, 32, 1) shared_outs(%arg32 = %29) -> (tensor<8x1024x1024xf32>) {
      %148 = affine.apply #map(%arg29)
      %149 = affine.apply #map(%arg30)
      %150 = affine.apply #map(%arg31)
      %extracted_slice_41 = tensor.extract_slice %collapsed_13[%arg28, %148, %150] [1, 32, 32] [1, 1, 1] : tensor<8x1024x32xf32> to tensor<1x32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %collapsed_14[%arg28, %150, %149] [1, 32, 32] [1, 1, 1] : tensor<8x32x1024xf32> to tensor<1x32x32xf32>
      %extracted_slice_43 = tensor.extract_slice %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<8x1024x1024xf32> to tensor<1x32x32xf32>
      %151 = linalg.batch_matmul ins(%extracted_slice_41, %extracted_slice_42 : tensor<1x32x32xf32>, tensor<1x32x32xf32>) outs(%extracted_slice_43 : tensor<1x32x32xf32>) -> tensor<1x32x32xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %151 into %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<1x32x32xf32> into tensor<8x1024x1024xf32>
      }
    }
    %expanded_15 = tensor.expand_shape %30 [[0, 1], [2], [3]] output_shape [2, 4, 1024, 1024] : tensor<8x1024x1024xf32> into tensor<2x4x1024x1024xf32>
    %31 = tensor.empty() : tensor<2x4x1024x1024xf32>
    %32 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %31) -> (tensor<2x4x1024x1024xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %expanded_15[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %158 = linalg.generic {indexing_maps = [#map9, #map9], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x?x1024x1024xf32>) outs(%extracted_slice_42 : tensor<?x?x1024x1024xf32>) {
      ^bb0(%in: f32, %out: f32):
        %163 = arith.truncf %cst_4 : f64 to f32
        %164 = arith.mulf %in, %163 : f32
        linalg.yield %164 : f32
      } -> tensor<?x?x1024x1024xf32>
      %159 = affine.apply #map2(%150)
      %160 = affine.apply #map2(%151)
      %161 = affine.apply #map2(%150)
      %162 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %158 into %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<?x?x1024x1024xf32> into tensor<2x4x1024x1024xf32>
      }
    }
    %33 = tensor.empty() : tensor<1x1x1024x1024xi1>
    %34 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %33) -> (tensor<1x1x1024x1024xi1>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c1 = arith.constant 1 : index
      %150 = affine.min #map10(%148)
      %c1_41 = arith.constant 1 : index
      %151 = affine.min #map10(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %extracted_slice_42 = tensor.extract_slice %arg5[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<1x1x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<1x1x1024x1024xi1> to tensor<?x?x1024x1024xi1>
      %158 = linalg.generic {indexing_maps = [#map9, #map9], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%extracted_slice_42 : tensor<?x?x1024x1024xf32>) outs(%extracted_slice_43 : tensor<?x?x1024x1024xi1>) {
      ^bb0(%in: f32, %out: i1):
        %163 = arith.cmpf oeq, %in, %cst : f32
        linalg.yield %163 : i1
      } -> tensor<?x?x1024x1024xi1>
      %159 = affine.apply #map2(%150)
      %160 = affine.apply #map2(%151)
      %161 = affine.apply #map2(%150)
      %162 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %158 into %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<?x?x1024x1024xi1> into tensor<1x1x1024x1024xi1>
      }
    }
    %35 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %31) -> (tensor<2x4x1024x1024xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %34[0, 0, 0, 0] [1, 1, 1024, 1024] [1, 1, 1, 1] : tensor<1x1x1024x1024xi1> to tensor<1x1x1024x1024xi1>
      %extracted_slice_42 = tensor.extract_slice %32[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %158 = linalg.generic {indexing_maps = [#map11, #map12, #map9, #map9], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %cst_3, %extracted_slice_42 : tensor<1x1x1024x1024xi1>, tensor<f32>, tensor<?x?x1024x1024xf32>) outs(%extracted_slice_43 : tensor<?x?x1024x1024xf32>) {
      ^bb0(%in: i1, %in_44: f32, %in_45: f32, %out: f32):
        %163 = arith.select %in, %in_44, %in_45 : f32
        linalg.yield %163 : f32
      } -> tensor<?x?x1024x1024xf32>
      %159 = affine.apply #map2(%150)
      %160 = affine.apply #map2(%151)
      %161 = affine.apply #map2(%150)
      %162 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %158 into %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<?x?x1024x1024xf32> into tensor<2x4x1024x1024xf32>
      }
    }
    %36 = tensor.empty() : tensor<2x4x1024xi64>
    %37 = linalg.fill ins(%c0_i64 : i64) outs(%36 : tensor<2x4x1024xi64>) -> tensor<2x4x1024xi64>
    %38 = tensor.empty() : tensor<2x4x1024xf32>
    %39 = linalg.fill ins(%cst_0 : f32) outs(%38 : tensor<2x4x1024xf32>) -> tensor<2x4x1024xf32>
    %40:2 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %39, %arg31 = %37) -> (tensor<2x4x1024xf32>, tensor<2x4x1024xi64>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %158 = affine.apply #map2(%150)
      %159 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %35[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, %151, 1024] [1, 1, 1] : tensor<2x4x1024xf32> to tensor<?x?x1024xf32>
      %extracted_slice_43 = tensor.extract_slice %arg31[%148, %149, 0] [%150, %151, 1024] [1, 1, 1] : tensor<2x4x1024xi64> to tensor<?x?x1024xi64>
      %160:2 = linalg.generic {indexing_maps = [#map9, #map13, #map13], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%extracted_slice_41 : tensor<?x?x1024x1024xf32>) outs(%extracted_slice_42, %extracted_slice_43 : tensor<?x?x1024xf32>, tensor<?x?x1024xi64>) {
      ^bb0(%in: f32, %out: f32, %out_44: i64):
        %169 = linalg.index 3 : index
        %170 = arith.index_cast %169 : index to i64
        %171 = arith.maximumf %in, %out : f32
        %172 = arith.cmpf ogt, %in, %out : f32
        %173 = arith.select %172, %170, %out_44 : i64
        linalg.yield %171, %173 : f32, i64
      } -> (tensor<?x?x1024xf32>, tensor<?x?x1024xi64>)
      %161 = affine.apply #map2(%150)
      %162 = affine.apply #map2(%151)
      %163 = affine.apply #map2(%150)
      %164 = affine.apply #map2(%151)
      %165 = affine.apply #map2(%150)
      %166 = affine.apply #map2(%151)
      %167 = affine.apply #map2(%150)
      %168 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %160#0 into %arg30[%148, %149, 0] [%150, %151, 1024] [1, 1, 1] : tensor<?x?x1024xf32> into tensor<2x4x1024xf32>
        tensor.parallel_insert_slice %160#1 into %arg31[%148, %149, 0] [%150, %151, 1024] [1, 1, 1] : tensor<?x?x1024xi64> into tensor<2x4x1024xi64>
      }
    }
    %expanded_16 = tensor.expand_shape %40#0 [[0], [1], [2, 3]] output_shape [2, 4, 1024, 1] : tensor<2x4x1024xf32> into tensor<2x4x1024x1xf32>
    %41 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %31) -> (tensor<2x4x1024x1024xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %158 = affine.apply #map2(%150)
      %159 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %35[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %extracted_slice_42 = tensor.extract_slice %expanded_16[%148, %149, 0, 0] [%150, %151, 1024, 1] [1, 1, 1, 1] : tensor<2x4x1024x1xf32> to tensor<?x?x1024x1xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %160 = linalg.generic {indexing_maps = [#map9, #map14, #map9], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x?x1024x1024xf32>, tensor<?x?x1024x1xf32>) outs(%extracted_slice_43 : tensor<?x?x1024x1024xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %165 = arith.subf %in, %in_44 : f32
        linalg.yield %165 : f32
      } -> tensor<?x?x1024x1024xf32>
      %161 = affine.apply #map2(%150)
      %162 = affine.apply #map2(%151)
      %163 = affine.apply #map2(%150)
      %164 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %160 into %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<?x?x1024x1024xf32> into tensor<2x4x1024x1024xf32>
      }
    }
    %42 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %31) -> (tensor<2x4x1024x1024xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %41[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %158 = linalg.generic {indexing_maps = [#map9, #map9], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x?x1024x1024xf32>) outs(%extracted_slice_42 : tensor<?x?x1024x1024xf32>) {
      ^bb0(%in: f32, %out: f32):
        %163 = math.exp %in : f32
        linalg.yield %163 : f32
      } -> tensor<?x?x1024x1024xf32>
      %159 = affine.apply #map2(%150)
      %160 = affine.apply #map2(%151)
      %161 = affine.apply #map2(%150)
      %162 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %158 into %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<?x?x1024x1024xf32> into tensor<2x4x1024x1024xf32>
      }
    }
    %43 = tensor.empty() : tensor<2x4x1024x1xf32>
    %44 = linalg.fill ins(%cst : f32) outs(%43 : tensor<2x4x1024x1xf32>) -> tensor<2x4x1024x1xf32>
    %45 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %44) -> (tensor<2x4x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %42[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1] [1, 1, 1, 1] : tensor<2x4x1024x1xf32> to tensor<?x?x1024x1xf32>
      %158 = linalg.generic {indexing_maps = [#map9, #map14], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%extracted_slice_41 : tensor<?x?x1024x1024xf32>) outs(%extracted_slice_42 : tensor<?x?x1024x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %163 = arith.addf %in, %out : f32
        linalg.yield %163 : f32
      } -> tensor<?x?x1024x1xf32>
      %159 = affine.apply #map2(%150)
      %160 = affine.apply #map2(%151)
      %161 = affine.apply #map2(%150)
      %162 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %158 into %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1] [1, 1, 1, 1] : tensor<?x?x1024x1xf32> into tensor<2x4x1024x1xf32>
      }
    }
    %46 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %31) -> (tensor<2x4x1024x1024xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %158 = affine.apply #map2(%150)
      %159 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %42[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %extracted_slice_42 = tensor.extract_slice %45[%148, %149, 0, 0] [%150, %151, 1024, 1] [1, 1, 1, 1] : tensor<2x4x1024x1xf32> to tensor<?x?x1024x1xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %160 = linalg.generic {indexing_maps = [#map9, #map14, #map9], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x?x1024x1024xf32>, tensor<?x?x1024x1xf32>) outs(%extracted_slice_43 : tensor<?x?x1024x1024xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %165 = arith.divf %in, %in_44 : f32
        linalg.yield %165 : f32
      } -> tensor<?x?x1024x1024xf32>
      %161 = affine.apply #map2(%150)
      %162 = affine.apply #map2(%151)
      %163 = affine.apply #map2(%150)
      %164 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %160 into %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<?x?x1024x1024xf32> into tensor<2x4x1024x1024xf32>
      }
    }
    %collapsed_17 = tensor.collapse_shape %46 [[0, 1], [2], [3]] : tensor<2x4x1024x1024xf32> into tensor<8x1024x1024xf32>
    %collapsed_18 = tensor.collapse_shape %25 [[0, 1], [2], [3]] : tensor<2x4x1024x32xf32> into tensor<8x1024x32xf32>
    %47 = tensor.empty() : tensor<8x1024x32xf32>
    %48 = linalg.fill ins(%cst : f32) outs(%47 : tensor<8x1024x32xf32>) -> tensor<8x1024x32xf32>
    %49 = scf.forall (%arg28, %arg29, %arg30, %arg31) in (8, 32, 1, 32) shared_outs(%arg32 = %48) -> (tensor<8x1024x32xf32>) {
      %148 = affine.apply #map(%arg29)
      %149 = affine.apply #map(%arg30)
      %150 = affine.apply #map(%arg31)
      %extracted_slice_41 = tensor.extract_slice %collapsed_17[%arg28, %148, %150] [1, 32, 32] [1, 1, 1] : tensor<8x1024x1024xf32> to tensor<1x32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %collapsed_18[%arg28, %150, %149] [1, 32, 32] [1, 1, 1] : tensor<8x1024x32xf32> to tensor<1x32x32xf32>
      %extracted_slice_43 = tensor.extract_slice %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<8x1024x32xf32> to tensor<1x32x32xf32>
      %151 = linalg.batch_matmul ins(%extracted_slice_41, %extracted_slice_42 : tensor<1x32x32xf32>, tensor<1x32x32xf32>) outs(%extracted_slice_43 : tensor<1x32x32xf32>) -> tensor<1x32x32xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %151 into %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<1x32x32xf32> into tensor<8x1024x32xf32>
      }
    }
    %expanded_19 = tensor.expand_shape %49 [[0, 1], [2], [3]] output_shape [2, 4, 1024, 32] : tensor<8x1024x32xf32> into tensor<2x4x1024x32xf32>
    %50 = tensor.empty() : tensor<2x1024x4x32xf32>
    %51 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %50) -> (tensor<2x1024x4x32xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %expanded_19[%148, 0, %149, 0] [%150, 4, 32, 32] [1, 1, 1, 1] : tensor<2x4x1024x32xf32> to tensor<?x4x32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, 32, 4, 32] [1, 1, 1, 1] : tensor<2x1024x4x32xf32> to tensor<?x32x4x32xf32>
      %transposed = linalg.transpose ins(%extracted_slice_41 : tensor<?x4x32x32xf32>) outs(%extracted_slice_42 : tensor<?x32x4x32xf32>) permutation = [0, 2, 1, 3] 
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %transposed into %arg30[%148, %149, 0, 0] [%150, 32, 4, 32] [1, 1, 1, 1] : tensor<?x32x4x32xf32> into tensor<2x1024x4x32xf32>
      }
    }
    %collapsed_20 = tensor.collapse_shape %51 [[0], [1], [2, 3]] : tensor<2x1024x4x32xf32> into tensor<2x1024x128xf32>
    %52 = tensor.empty() : tensor<128x128xf32>
    %53 = scf.forall (%arg28, %arg29) in (4, 4) shared_outs(%arg30 = %52) -> (tensor<128x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %extracted_slice_41 = tensor.extract_slice %arg6[%149, %148] [32, 32] [1, 1] : tensor<128x128xf32> to tensor<32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149] [32, 32] [1, 1] : tensor<128x128xf32> to tensor<32x32xf32>
      %transposed = linalg.transpose ins(%extracted_slice_41 : tensor<32x32xf32>) outs(%extracted_slice_42 : tensor<32x32xf32>) permutation = [1, 0] 
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %transposed into %arg30[%148, %149] [32, 32] [1, 1] : tensor<32x32xf32> into tensor<128x128xf32>
      }
    }
    %54 = tensor.empty() : tensor<2x128x128xf32>
    %55 = scf.forall (%arg28, %arg29) in (1, 4) shared_outs(%arg30 = %54) -> (tensor<2x128x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %53[%149, 0] [32, 128] [1, 1] : tensor<128x128xf32> to tensor<32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x128x128xf32> to tensor<?x32x128xf32>
      %153 = linalg.generic {indexing_maps = [#map7, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<32x128xf32>) outs(%extracted_slice_42 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x32x128xf32>
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %153 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x128x128xf32>
      }
    }
    %56 = linalg.fill ins(%cst : f32) outs(%arg27 : tensor<2x1024x128xf32>) -> tensor<2x1024x128xf32>
    %57 = scf.forall (%arg28, %arg29, %arg30, %arg31) in (2, 32, 4, 4) shared_outs(%arg32 = %56) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg29)
      %149 = affine.apply #map(%arg30)
      %150 = affine.apply #map(%arg31)
      %extracted_slice_41 = tensor.extract_slice %collapsed_20[%arg28, %148, %150] [1, 32, 32] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<1x32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %55[%arg28, %150, %149] [1, 32, 32] [1, 1, 1] : tensor<2x128x128xf32> to tensor<1x32x32xf32>
      %extracted_slice_43 = tensor.extract_slice %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<1x32x32xf32>
      %151 = linalg.batch_matmul ins(%extracted_slice_41, %extracted_slice_42 : tensor<1x32x32xf32>, tensor<1x32x32xf32>) outs(%extracted_slice_43 : tensor<1x32x32xf32>) -> tensor<1x32x32xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %151 into %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<1x32x32xf32> into tensor<2x1024x128xf32>
      }
    }
    %58 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %57[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg7[0] [128] [1] : tensor<128xf32> to tensor<128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %157 = arith.addf %in, %in_44 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %59 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %154 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %arg2[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %58[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %155 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<?x32x128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %158 = arith.addf %in, %in_44 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x128xf32>
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %155 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %60 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %1) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %59[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%extracted_slice_41 : tensor<?x32x128xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.addf %in, %out : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %61 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %0) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %60[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32x1xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.divf %in, %cst_6 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %collapsed_21 = tensor.collapse_shape %61 [[0], [1, 2]] : tensor<2x1024x1xf32> into tensor<2x1024xf32>
    %62 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %collapsed_21[%148, %149] [%150, 32] [1, 1] : tensor<2x1024xf32> to tensor<?x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map5, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32xf32>) outs(%extracted_slice_42 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %63 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %154 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %59[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %62[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %155 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<?x32x128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %158 = arith.subf %in, %in_44 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x128xf32>
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %155 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %64 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %154 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %63[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %63[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %155 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<?x32x128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %158 = arith.mulf %in, %in_44 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x128xf32>
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %155 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %65 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %1) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %64[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%extracted_slice_41 : tensor<?x32x128xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.addf %in, %out : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %66 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %0) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %65[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32x1xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.divf %in, %cst_6 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %67 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %0) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %66[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32x1xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.truncf %cst_5 : f64 to f32
        %158 = arith.addf %in, %157 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %68 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %0) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %67[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32x1xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = math.rsqrt %in : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %collapsed_22 = tensor.collapse_shape %68 [[0], [1, 2]] : tensor<2x1024x1xf32> into tensor<2x1024xf32>
    %69 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %collapsed_22[%148, %149] [%150, 32] [1, 1] : tensor<2x1024xf32> to tensor<?x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map5, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32xf32>) outs(%extracted_slice_42 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %70 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %154 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %63[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %69[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %155 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<?x32x128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %158 = arith.mulf %in, %in_44 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x128xf32>
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %155 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %71 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %70[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg8[0] [128] [1] : tensor<128xf32> to tensor<128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %157 = arith.mulf %in, %in_44 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %72 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %71[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg9[0] [128] [1] : tensor<128xf32> to tensor<128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %157 = arith.addf %in, %in_44 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %73 = tensor.empty() : tensor<128x512xf32>
    %74 = scf.forall (%arg28, %arg29) in (4, 16) shared_outs(%arg30 = %73) -> (tensor<128x512xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %extracted_slice_41 = tensor.extract_slice %arg10[%149, %148] [32, 32] [1, 1] : tensor<512x128xf32> to tensor<32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149] [32, 32] [1, 1] : tensor<128x512xf32> to tensor<32x32xf32>
      %transposed = linalg.transpose ins(%extracted_slice_41 : tensor<32x32xf32>) outs(%extracted_slice_42 : tensor<32x32xf32>) permutation = [1, 0] 
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %transposed into %arg30[%148, %149] [32, 32] [1, 1] : tensor<32x32xf32> into tensor<128x512xf32>
      }
    }
    %75 = tensor.empty() : tensor<2x128x512xf32>
    %76 = scf.forall (%arg28, %arg29) in (1, 4) shared_outs(%arg30 = %75) -> (tensor<2x128x512xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %74[%149, 0] [32, 512] [1, 1] : tensor<128x512xf32> to tensor<32x512xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 512] [1, 1, 1] : tensor<2x128x512xf32> to tensor<?x32x512xf32>
      %153 = linalg.generic {indexing_maps = [#map7, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<32x512xf32>) outs(%extracted_slice_42 : tensor<?x32x512xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x32x512xf32>
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %153 into %arg30[%148, %149, 0] [%150, 32, 512] [1, 1, 1] : tensor<?x32x512xf32> into tensor<2x128x512xf32>
      }
    }
    %77 = tensor.empty() : tensor<2x1024x512xf32>
    %78 = linalg.fill ins(%cst : f32) outs(%77 : tensor<2x1024x512xf32>) -> tensor<2x1024x512xf32>
    %79 = scf.forall (%arg28, %arg29, %arg30, %arg31) in (2, 32, 16, 4) shared_outs(%arg32 = %78) -> (tensor<2x1024x512xf32>) {
      %148 = affine.apply #map(%arg29)
      %149 = affine.apply #map(%arg30)
      %150 = affine.apply #map(%arg31)
      %extracted_slice_41 = tensor.extract_slice %72[%arg28, %148, %150] [1, 32, 32] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<1x32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %76[%arg28, %150, %149] [1, 32, 32] [1, 1, 1] : tensor<2x128x512xf32> to tensor<1x32x32xf32>
      %extracted_slice_43 = tensor.extract_slice %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<2x1024x512xf32> to tensor<1x32x32xf32>
      %151 = linalg.batch_matmul ins(%extracted_slice_41, %extracted_slice_42 : tensor<1x32x32xf32>, tensor<1x32x32xf32>) outs(%extracted_slice_43 : tensor<1x32x32xf32>) -> tensor<1x32x32xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %151 into %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<1x32x32xf32> into tensor<2x1024x512xf32>
      }
    }
    %80 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %77) -> (tensor<2x1024x512xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %79[%148, %149, 0] [%150, 32, 512] [1, 1, 1] : tensor<2x1024x512xf32> to tensor<?x32x512xf32>
      %extracted_slice_42 = tensor.extract_slice %arg11[0] [512] [1] : tensor<512xf32> to tensor<512xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 512] [1, 1, 1] : tensor<2x1024x512xf32> to tensor<?x32x512xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x512xf32>, tensor<512xf32>) outs(%extracted_slice_43 : tensor<?x32x512xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %157 = arith.addf %in, %in_44 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x512xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 512] [1, 1, 1] : tensor<?x32x512xf32> into tensor<2x1024x512xf32>
      }
    }
    %81 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %77) -> (tensor<2x1024x512xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %80[%148, %149, 0] [%150, 32, 512] [1, 1, 1] : tensor<2x1024x512xf32> to tensor<?x32x512xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 512] [1, 1, 1] : tensor<2x1024x512xf32> to tensor<?x32x512xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32x512xf32>) outs(%extracted_slice_42 : tensor<?x32x512xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.divf %in, %cst_7 : f32
        %158 = math.erf %157 : f32
        %159 = arith.addf %158, %cst_1 : f32
        %160 = arith.mulf %159, %cst_2 : f32
        %161 = arith.mulf %in, %160 : f32
        linalg.yield %161 : f32
      } -> tensor<?x32x512xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 512] [1, 1, 1] : tensor<?x32x512xf32> into tensor<2x1024x512xf32>
      }
    }
    %82 = tensor.empty() : tensor<512x128xf32>
    %83 = scf.forall (%arg28, %arg29) in (16, 4) shared_outs(%arg30 = %82) -> (tensor<512x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %extracted_slice_41 = tensor.extract_slice %arg12[%149, %148] [32, 32] [1, 1] : tensor<128x512xf32> to tensor<32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149] [32, 32] [1, 1] : tensor<512x128xf32> to tensor<32x32xf32>
      %transposed = linalg.transpose ins(%extracted_slice_41 : tensor<32x32xf32>) outs(%extracted_slice_42 : tensor<32x32xf32>) permutation = [1, 0] 
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %transposed into %arg30[%148, %149] [32, 32] [1, 1] : tensor<32x32xf32> into tensor<512x128xf32>
      }
    }
    %84 = tensor.empty() : tensor<2x512x128xf32>
    %85 = scf.forall (%arg28, %arg29) in (1, 16) shared_outs(%arg30 = %84) -> (tensor<2x512x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %83[%149, 0] [32, 128] [1, 1] : tensor<512x128xf32> to tensor<32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x512x128xf32> to tensor<?x32x128xf32>
      %153 = linalg.generic {indexing_maps = [#map7, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<32x128xf32>) outs(%extracted_slice_42 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x32x128xf32>
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %153 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x512x128xf32>
      }
    }
    %86 = scf.forall (%arg28, %arg29, %arg30, %arg31) in (2, 32, 4, 16) shared_outs(%arg32 = %56) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg29)
      %149 = affine.apply #map(%arg30)
      %150 = affine.apply #map(%arg31)
      %extracted_slice_41 = tensor.extract_slice %81[%arg28, %148, %150] [1, 32, 32] [1, 1, 1] : tensor<2x1024x512xf32> to tensor<1x32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %85[%arg28, %150, %149] [1, 32, 32] [1, 1, 1] : tensor<2x512x128xf32> to tensor<1x32x32xf32>
      %extracted_slice_43 = tensor.extract_slice %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<1x32x32xf32>
      %151 = linalg.batch_matmul ins(%extracted_slice_41, %extracted_slice_42 : tensor<1x32x32xf32>, tensor<1x32x32xf32>) outs(%extracted_slice_43 : tensor<1x32x32xf32>) -> tensor<1x32x32xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %151 into %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<1x32x32xf32> into tensor<2x1024x128xf32>
      }
    }
    %87 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %86[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg13[0] [128] [1] : tensor<128xf32> to tensor<128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %157 = arith.addf %in, %in_44 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %88 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %154 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %59[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %87[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %155 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<?x32x128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %158 = arith.addf %in, %in_44 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x128xf32>
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %155 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %89 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %1) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %88[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%extracted_slice_41 : tensor<?x32x128xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.addf %in, %out : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %90 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %0) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %89[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32x1xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.divf %in, %cst_6 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %collapsed_23 = tensor.collapse_shape %90 [[0], [1, 2]] : tensor<2x1024x1xf32> into tensor<2x1024xf32>
    %91 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %collapsed_23[%148, %149] [%150, 32] [1, 1] : tensor<2x1024xf32> to tensor<?x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map5, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32xf32>) outs(%extracted_slice_42 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %92 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %154 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %88[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %91[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %155 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<?x32x128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %158 = arith.subf %in, %in_44 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x128xf32>
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %155 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %93 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %154 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %92[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %92[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %155 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<?x32x128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %158 = arith.mulf %in, %in_44 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x128xf32>
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %155 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %94 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %1) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %93[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%extracted_slice_41 : tensor<?x32x128xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.addf %in, %out : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %95 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %0) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %94[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32x1xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.divf %in, %cst_6 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %96 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %0) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %95[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32x1xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.truncf %cst_5 : f64 to f32
        %158 = arith.addf %in, %157 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %97 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %0) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %96[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32x1xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = math.rsqrt %in : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %collapsed_24 = tensor.collapse_shape %97 [[0], [1, 2]] : tensor<2x1024x1xf32> into tensor<2x1024xf32>
    %98 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %collapsed_24[%148, %149] [%150, 32] [1, 1] : tensor<2x1024xf32> to tensor<?x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map5, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32xf32>) outs(%extracted_slice_42 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %99 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %154 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %92[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %98[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %155 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<?x32x128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %158 = arith.mulf %in, %in_44 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x128xf32>
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %155 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %100 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %99[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg14[0] [128] [1] : tensor<128xf32> to tensor<128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %157 = arith.mulf %in, %in_44 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %101 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %100[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg15[0] [128] [1] : tensor<128xf32> to tensor<128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %157 = arith.addf %in, %in_44 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %102 = scf.forall (%arg28, %arg29) in (4, 12) shared_outs(%arg30 = %15) -> (tensor<128x384xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %extracted_slice_41 = tensor.extract_slice %arg16[%149, %148] [32, 32] [1, 1] : tensor<384x128xf32> to tensor<32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149] [32, 32] [1, 1] : tensor<128x384xf32> to tensor<32x32xf32>
      %transposed = linalg.transpose ins(%extracted_slice_41 : tensor<32x32xf32>) outs(%extracted_slice_42 : tensor<32x32xf32>) permutation = [1, 0] 
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %transposed into %arg30[%148, %149] [32, 32] [1, 1] : tensor<32x32xf32> into tensor<128x384xf32>
      }
    }
    %103 = scf.forall (%arg28, %arg29) in (1, 4) shared_outs(%arg30 = %17) -> (tensor<2x128x384xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %102[%149, 0] [32, 384] [1, 1] : tensor<128x384xf32> to tensor<32x384xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 384] [1, 1, 1] : tensor<2x128x384xf32> to tensor<?x32x384xf32>
      %153 = linalg.generic {indexing_maps = [#map7, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<32x384xf32>) outs(%extracted_slice_42 : tensor<?x32x384xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x32x384xf32>
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %153 into %arg30[%148, %149, 0] [%150, 32, 384] [1, 1, 1] : tensor<?x32x384xf32> into tensor<2x128x384xf32>
      }
    }
    %104 = scf.forall (%arg28, %arg29, %arg30, %arg31) in (2, 32, 12, 4) shared_outs(%arg32 = %20) -> (tensor<2x1024x384xf32>) {
      %148 = affine.apply #map(%arg29)
      %149 = affine.apply #map(%arg30)
      %150 = affine.apply #map(%arg31)
      %extracted_slice_41 = tensor.extract_slice %101[%arg28, %148, %150] [1, 32, 32] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<1x32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %103[%arg28, %150, %149] [1, 32, 32] [1, 1, 1] : tensor<2x128x384xf32> to tensor<1x32x32xf32>
      %extracted_slice_43 = tensor.extract_slice %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<2x1024x384xf32> to tensor<1x32x32xf32>
      %151 = linalg.batch_matmul ins(%extracted_slice_41, %extracted_slice_42 : tensor<1x32x32xf32>, tensor<1x32x32xf32>) outs(%extracted_slice_43 : tensor<1x32x32xf32>) -> tensor<1x32x32xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %151 into %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<1x32x32xf32> into tensor<2x1024x384xf32>
      }
    }
    %105 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %19) -> (tensor<2x1024x384xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %104[%148, %149, 0] [%150, 32, 384] [1, 1, 1] : tensor<2x1024x384xf32> to tensor<?x32x384xf32>
      %extracted_slice_42 = tensor.extract_slice %arg17[0] [384] [1] : tensor<384xf32> to tensor<384xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 384] [1, 1, 1] : tensor<2x1024x384xf32> to tensor<?x32x384xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x384xf32>, tensor<384xf32>) outs(%extracted_slice_43 : tensor<?x32x384xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %157 = arith.addf %in, %in_44 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x384xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 384] [1, 1, 1] : tensor<?x32x384xf32> into tensor<2x1024x384xf32>
      }
    }
    %extracted_slice_25 = tensor.extract_slice %105[0, 0, 0] [2, 1024, 128] [1, 1, 1] : tensor<2x1024x384xf32> to tensor<2x1024x128xf32>
    %extracted_slice_26 = tensor.extract_slice %105[0, 0, 128] [2, 1024, 128] [1, 1, 1] : tensor<2x1024x384xf32> to tensor<2x1024x128xf32>
    %extracted_slice_27 = tensor.extract_slice %105[0, 0, 256] [2, 1024, 128] [1, 1, 1] : tensor<2x1024x384xf32> to tensor<2x1024x128xf32>
    %expanded_28 = tensor.expand_shape %extracted_slice_26 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : tensor<2x1024x128xf32> into tensor<2x1024x4x32xf32>
    %expanded_29 = tensor.expand_shape %extracted_slice_25 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : tensor<2x1024x128xf32> into tensor<2x1024x4x32xf32>
    %106 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %23) -> (tensor<2x4x1024x32xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %expanded_29[%148, 0, %149, 0] [%150, 1024, %151, 32] [1, 1, 1, 1] : tensor<2x1024x4x32xf32> to tensor<?x1024x?x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 1024, 32] [1, 1, 1, 1] : tensor<2x4x1024x32xf32> to tensor<?x?x1024x32xf32>
      %transposed = linalg.transpose ins(%extracted_slice_41 : tensor<?x1024x?x32xf32>) outs(%extracted_slice_42 : tensor<?x?x1024x32xf32>) permutation = [0, 2, 1, 3] 
      %158 = affine.apply #map2(%150)
      %159 = affine.apply #map2(%151)
      %160 = affine.apply #map2(%150)
      %161 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %transposed into %arg30[%148, %149, 0, 0] [%150, %151, 1024, 32] [1, 1, 1, 1] : tensor<?x?x1024x32xf32> into tensor<2x4x1024x32xf32>
      }
    }
    %expanded_30 = tensor.expand_shape %extracted_slice_27 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : tensor<2x1024x128xf32> into tensor<2x1024x4x32xf32>
    %107 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %23) -> (tensor<2x4x1024x32xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %expanded_30[%148, 0, %149, 0] [%150, 1024, %151, 32] [1, 1, 1, 1] : tensor<2x1024x4x32xf32> to tensor<?x1024x?x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 1024, 32] [1, 1, 1, 1] : tensor<2x4x1024x32xf32> to tensor<?x?x1024x32xf32>
      %transposed = linalg.transpose ins(%extracted_slice_41 : tensor<?x1024x?x32xf32>) outs(%extracted_slice_42 : tensor<?x?x1024x32xf32>) permutation = [0, 2, 1, 3] 
      %158 = affine.apply #map2(%150)
      %159 = affine.apply #map2(%151)
      %160 = affine.apply #map2(%150)
      %161 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %transposed into %arg30[%148, %149, 0, 0] [%150, %151, 1024, 32] [1, 1, 1, 1] : tensor<?x?x1024x32xf32> into tensor<2x4x1024x32xf32>
      }
    }
    %108 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %26) -> (tensor<2x4x32x1024xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %expanded_28[%148, 0, %149, 0] [%150, 1024, %151, 32] [1, 1, 1, 1] : tensor<2x1024x4x32xf32> to tensor<?x1024x?x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 32, 1024] [1, 1, 1, 1] : tensor<2x4x32x1024xf32> to tensor<?x?x32x1024xf32>
      %transposed = linalg.transpose ins(%extracted_slice_41 : tensor<?x1024x?x32xf32>) outs(%extracted_slice_42 : tensor<?x?x32x1024xf32>) permutation = [0, 2, 3, 1] 
      %158 = affine.apply #map2(%150)
      %159 = affine.apply #map2(%151)
      %160 = affine.apply #map2(%150)
      %161 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %transposed into %arg30[%148, %149, 0, 0] [%150, %151, 32, 1024] [1, 1, 1, 1] : tensor<?x?x32x1024xf32> into tensor<2x4x32x1024xf32>
      }
    }
    %collapsed_31 = tensor.collapse_shape %106 [[0, 1], [2], [3]] : tensor<2x4x1024x32xf32> into tensor<8x1024x32xf32>
    %collapsed_32 = tensor.collapse_shape %108 [[0, 1], [2], [3]] : tensor<2x4x32x1024xf32> into tensor<8x32x1024xf32>
    %109 = scf.forall (%arg28, %arg29, %arg30, %arg31) in (8, 32, 32, 1) shared_outs(%arg32 = %29) -> (tensor<8x1024x1024xf32>) {
      %148 = affine.apply #map(%arg29)
      %149 = affine.apply #map(%arg30)
      %150 = affine.apply #map(%arg31)
      %extracted_slice_41 = tensor.extract_slice %collapsed_31[%arg28, %148, %150] [1, 32, 32] [1, 1, 1] : tensor<8x1024x32xf32> to tensor<1x32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %collapsed_32[%arg28, %150, %149] [1, 32, 32] [1, 1, 1] : tensor<8x32x1024xf32> to tensor<1x32x32xf32>
      %extracted_slice_43 = tensor.extract_slice %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<8x1024x1024xf32> to tensor<1x32x32xf32>
      %151 = linalg.batch_matmul ins(%extracted_slice_41, %extracted_slice_42 : tensor<1x32x32xf32>, tensor<1x32x32xf32>) outs(%extracted_slice_43 : tensor<1x32x32xf32>) -> tensor<1x32x32xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %151 into %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<1x32x32xf32> into tensor<8x1024x1024xf32>
      }
    }
    %expanded_33 = tensor.expand_shape %109 [[0, 1], [2], [3]] output_shape [2, 4, 1024, 1024] : tensor<8x1024x1024xf32> into tensor<2x4x1024x1024xf32>
    %110 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %31) -> (tensor<2x4x1024x1024xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %expanded_33[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %158 = linalg.generic {indexing_maps = [#map9, #map9], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x?x1024x1024xf32>) outs(%extracted_slice_42 : tensor<?x?x1024x1024xf32>) {
      ^bb0(%in: f32, %out: f32):
        %163 = arith.truncf %cst_4 : f64 to f32
        %164 = arith.mulf %in, %163 : f32
        linalg.yield %164 : f32
      } -> tensor<?x?x1024x1024xf32>
      %159 = affine.apply #map2(%150)
      %160 = affine.apply #map2(%151)
      %161 = affine.apply #map2(%150)
      %162 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %158 into %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<?x?x1024x1024xf32> into tensor<2x4x1024x1024xf32>
      }
    }
    %111 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %33) -> (tensor<1x1x1024x1024xi1>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c1 = arith.constant 1 : index
      %150 = affine.min #map10(%148)
      %c1_41 = arith.constant 1 : index
      %151 = affine.min #map10(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %extracted_slice_42 = tensor.extract_slice %arg18[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<1x1x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<1x1x1024x1024xi1> to tensor<?x?x1024x1024xi1>
      %158 = linalg.generic {indexing_maps = [#map9, #map9], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%extracted_slice_42 : tensor<?x?x1024x1024xf32>) outs(%extracted_slice_43 : tensor<?x?x1024x1024xi1>) {
      ^bb0(%in: f32, %out: i1):
        %163 = arith.cmpf oeq, %in, %cst : f32
        linalg.yield %163 : i1
      } -> tensor<?x?x1024x1024xi1>
      %159 = affine.apply #map2(%150)
      %160 = affine.apply #map2(%151)
      %161 = affine.apply #map2(%150)
      %162 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %158 into %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<?x?x1024x1024xi1> into tensor<1x1x1024x1024xi1>
      }
    }
    %112 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %31) -> (tensor<2x4x1024x1024xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %111[0, 0, 0, 0] [1, 1, 1024, 1024] [1, 1, 1, 1] : tensor<1x1x1024x1024xi1> to tensor<1x1x1024x1024xi1>
      %extracted_slice_42 = tensor.extract_slice %110[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %158 = linalg.generic {indexing_maps = [#map11, #map12, #map9, #map9], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %cst_3, %extracted_slice_42 : tensor<1x1x1024x1024xi1>, tensor<f32>, tensor<?x?x1024x1024xf32>) outs(%extracted_slice_43 : tensor<?x?x1024x1024xf32>) {
      ^bb0(%in: i1, %in_44: f32, %in_45: f32, %out: f32):
        %163 = arith.select %in, %in_44, %in_45 : f32
        linalg.yield %163 : f32
      } -> tensor<?x?x1024x1024xf32>
      %159 = affine.apply #map2(%150)
      %160 = affine.apply #map2(%151)
      %161 = affine.apply #map2(%150)
      %162 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %158 into %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<?x?x1024x1024xf32> into tensor<2x4x1024x1024xf32>
      }
    }
    %113:2 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %39, %arg31 = %37) -> (tensor<2x4x1024xf32>, tensor<2x4x1024xi64>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %158 = affine.apply #map2(%150)
      %159 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %112[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, %151, 1024] [1, 1, 1] : tensor<2x4x1024xf32> to tensor<?x?x1024xf32>
      %extracted_slice_43 = tensor.extract_slice %arg31[%148, %149, 0] [%150, %151, 1024] [1, 1, 1] : tensor<2x4x1024xi64> to tensor<?x?x1024xi64>
      %160:2 = linalg.generic {indexing_maps = [#map9, #map13, #map13], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%extracted_slice_41 : tensor<?x?x1024x1024xf32>) outs(%extracted_slice_42, %extracted_slice_43 : tensor<?x?x1024xf32>, tensor<?x?x1024xi64>) {
      ^bb0(%in: f32, %out: f32, %out_44: i64):
        %169 = linalg.index 3 : index
        %170 = arith.index_cast %169 : index to i64
        %171 = arith.maximumf %in, %out : f32
        %172 = arith.cmpf ogt, %in, %out : f32
        %173 = arith.select %172, %170, %out_44 : i64
        linalg.yield %171, %173 : f32, i64
      } -> (tensor<?x?x1024xf32>, tensor<?x?x1024xi64>)
      %161 = affine.apply #map2(%150)
      %162 = affine.apply #map2(%151)
      %163 = affine.apply #map2(%150)
      %164 = affine.apply #map2(%151)
      %165 = affine.apply #map2(%150)
      %166 = affine.apply #map2(%151)
      %167 = affine.apply #map2(%150)
      %168 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %160#0 into %arg30[%148, %149, 0] [%150, %151, 1024] [1, 1, 1] : tensor<?x?x1024xf32> into tensor<2x4x1024xf32>
        tensor.parallel_insert_slice %160#1 into %arg31[%148, %149, 0] [%150, %151, 1024] [1, 1, 1] : tensor<?x?x1024xi64> into tensor<2x4x1024xi64>
      }
    }
    %expanded_34 = tensor.expand_shape %113#0 [[0], [1], [2, 3]] output_shape [2, 4, 1024, 1] : tensor<2x4x1024xf32> into tensor<2x4x1024x1xf32>
    %114 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %31) -> (tensor<2x4x1024x1024xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %158 = affine.apply #map2(%150)
      %159 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %112[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %extracted_slice_42 = tensor.extract_slice %expanded_34[%148, %149, 0, 0] [%150, %151, 1024, 1] [1, 1, 1, 1] : tensor<2x4x1024x1xf32> to tensor<?x?x1024x1xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %160 = linalg.generic {indexing_maps = [#map9, #map14, #map9], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x?x1024x1024xf32>, tensor<?x?x1024x1xf32>) outs(%extracted_slice_43 : tensor<?x?x1024x1024xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %165 = arith.subf %in, %in_44 : f32
        linalg.yield %165 : f32
      } -> tensor<?x?x1024x1024xf32>
      %161 = affine.apply #map2(%150)
      %162 = affine.apply #map2(%151)
      %163 = affine.apply #map2(%150)
      %164 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %160 into %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<?x?x1024x1024xf32> into tensor<2x4x1024x1024xf32>
      }
    }
    %115 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %31) -> (tensor<2x4x1024x1024xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %114[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %158 = linalg.generic {indexing_maps = [#map9, #map9], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x?x1024x1024xf32>) outs(%extracted_slice_42 : tensor<?x?x1024x1024xf32>) {
      ^bb0(%in: f32, %out: f32):
        %163 = math.exp %in : f32
        linalg.yield %163 : f32
      } -> tensor<?x?x1024x1024xf32>
      %159 = affine.apply #map2(%150)
      %160 = affine.apply #map2(%151)
      %161 = affine.apply #map2(%150)
      %162 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %158 into %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<?x?x1024x1024xf32> into tensor<2x4x1024x1024xf32>
      }
    }
    %116 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %44) -> (tensor<2x4x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %115[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1] [1, 1, 1, 1] : tensor<2x4x1024x1xf32> to tensor<?x?x1024x1xf32>
      %158 = linalg.generic {indexing_maps = [#map9, #map14], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%extracted_slice_41 : tensor<?x?x1024x1024xf32>) outs(%extracted_slice_42 : tensor<?x?x1024x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %163 = arith.addf %in, %out : f32
        linalg.yield %163 : f32
      } -> tensor<?x?x1024x1xf32>
      %159 = affine.apply #map2(%150)
      %160 = affine.apply #map2(%151)
      %161 = affine.apply #map2(%150)
      %162 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %158 into %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1] [1, 1, 1, 1] : tensor<?x?x1024x1xf32> into tensor<2x4x1024x1xf32>
      }
    }
    %117 = scf.forall (%arg28, %arg29) in (1, 1) shared_outs(%arg30 = %31) -> (tensor<2x4x1024x1024xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %c4 = arith.constant 4 : index
      %151 = affine.min #map8(%149)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%151)
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%151)
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%151)
      %158 = affine.apply #map2(%150)
      %159 = affine.apply #map2(%151)
      %extracted_slice_41 = tensor.extract_slice %115[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %extracted_slice_42 = tensor.extract_slice %116[%148, %149, 0, 0] [%150, %151, 1024, 1] [1, 1, 1, 1] : tensor<2x4x1024x1xf32> to tensor<?x?x1024x1xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<2x4x1024x1024xf32> to tensor<?x?x1024x1024xf32>
      %160 = linalg.generic {indexing_maps = [#map9, #map14, #map9], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x?x1024x1024xf32>, tensor<?x?x1024x1xf32>) outs(%extracted_slice_43 : tensor<?x?x1024x1024xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %165 = arith.divf %in, %in_44 : f32
        linalg.yield %165 : f32
      } -> tensor<?x?x1024x1024xf32>
      %161 = affine.apply #map2(%150)
      %162 = affine.apply #map2(%151)
      %163 = affine.apply #map2(%150)
      %164 = affine.apply #map2(%151)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %160 into %arg30[%148, %149, 0, 0] [%150, %151, 1024, 1024] [1, 1, 1, 1] : tensor<?x?x1024x1024xf32> into tensor<2x4x1024x1024xf32>
      }
    }
    %collapsed_35 = tensor.collapse_shape %117 [[0, 1], [2], [3]] : tensor<2x4x1024x1024xf32> into tensor<8x1024x1024xf32>
    %collapsed_36 = tensor.collapse_shape %107 [[0, 1], [2], [3]] : tensor<2x4x1024x32xf32> into tensor<8x1024x32xf32>
    %118 = scf.forall (%arg28, %arg29, %arg30, %arg31) in (8, 32, 1, 32) shared_outs(%arg32 = %48) -> (tensor<8x1024x32xf32>) {
      %148 = affine.apply #map(%arg29)
      %149 = affine.apply #map(%arg30)
      %150 = affine.apply #map(%arg31)
      %extracted_slice_41 = tensor.extract_slice %collapsed_35[%arg28, %148, %150] [1, 32, 32] [1, 1, 1] : tensor<8x1024x1024xf32> to tensor<1x32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %collapsed_36[%arg28, %150, %149] [1, 32, 32] [1, 1, 1] : tensor<8x1024x32xf32> to tensor<1x32x32xf32>
      %extracted_slice_43 = tensor.extract_slice %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<8x1024x32xf32> to tensor<1x32x32xf32>
      %151 = linalg.batch_matmul ins(%extracted_slice_41, %extracted_slice_42 : tensor<1x32x32xf32>, tensor<1x32x32xf32>) outs(%extracted_slice_43 : tensor<1x32x32xf32>) -> tensor<1x32x32xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %151 into %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<1x32x32xf32> into tensor<8x1024x32xf32>
      }
    }
    %expanded_37 = tensor.expand_shape %118 [[0, 1], [2], [3]] output_shape [2, 4, 1024, 32] : tensor<8x1024x32xf32> into tensor<2x4x1024x32xf32>
    %119 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %50) -> (tensor<2x1024x4x32xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %expanded_37[%148, 0, %149, 0] [%150, 4, 32, 32] [1, 1, 1, 1] : tensor<2x4x1024x32xf32> to tensor<?x4x32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0, 0] [%150, 32, 4, 32] [1, 1, 1, 1] : tensor<2x1024x4x32xf32> to tensor<?x32x4x32xf32>
      %transposed = linalg.transpose ins(%extracted_slice_41 : tensor<?x4x32x32xf32>) outs(%extracted_slice_42 : tensor<?x32x4x32xf32>) permutation = [0, 2, 1, 3] 
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %transposed into %arg30[%148, %149, 0, 0] [%150, 32, 4, 32] [1, 1, 1, 1] : tensor<?x32x4x32xf32> into tensor<2x1024x4x32xf32>
      }
    }
    %collapsed_38 = tensor.collapse_shape %119 [[0], [1], [2, 3]] : tensor<2x1024x4x32xf32> into tensor<2x1024x128xf32>
    %120 = scf.forall (%arg28, %arg29) in (4, 4) shared_outs(%arg30 = %52) -> (tensor<128x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %extracted_slice_41 = tensor.extract_slice %arg19[%149, %148] [32, 32] [1, 1] : tensor<128x128xf32> to tensor<32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149] [32, 32] [1, 1] : tensor<128x128xf32> to tensor<32x32xf32>
      %transposed = linalg.transpose ins(%extracted_slice_41 : tensor<32x32xf32>) outs(%extracted_slice_42 : tensor<32x32xf32>) permutation = [1, 0] 
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %transposed into %arg30[%148, %149] [32, 32] [1, 1] : tensor<32x32xf32> into tensor<128x128xf32>
      }
    }
    %121 = scf.forall (%arg28, %arg29) in (1, 4) shared_outs(%arg30 = %54) -> (tensor<2x128x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %120[%149, 0] [32, 128] [1, 1] : tensor<128x128xf32> to tensor<32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x128x128xf32> to tensor<?x32x128xf32>
      %153 = linalg.generic {indexing_maps = [#map7, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<32x128xf32>) outs(%extracted_slice_42 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x32x128xf32>
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %153 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x128x128xf32>
      }
    }
    %122 = scf.forall (%arg28, %arg29, %arg30, %arg31) in (2, 32, 4, 4) shared_outs(%arg32 = %56) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg29)
      %149 = affine.apply #map(%arg30)
      %150 = affine.apply #map(%arg31)
      %extracted_slice_41 = tensor.extract_slice %collapsed_38[%arg28, %148, %150] [1, 32, 32] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<1x32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %121[%arg28, %150, %149] [1, 32, 32] [1, 1, 1] : tensor<2x128x128xf32> to tensor<1x32x32xf32>
      %extracted_slice_43 = tensor.extract_slice %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<1x32x32xf32>
      %151 = linalg.batch_matmul ins(%extracted_slice_41, %extracted_slice_42 : tensor<1x32x32xf32>, tensor<1x32x32xf32>) outs(%extracted_slice_43 : tensor<1x32x32xf32>) -> tensor<1x32x32xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %151 into %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<1x32x32xf32> into tensor<2x1024x128xf32>
      }
    }
    %123 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %122[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg20[0] [128] [1] : tensor<128xf32> to tensor<128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %157 = arith.addf %in, %in_44 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %124 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %154 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %88[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %123[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %155 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<?x32x128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %158 = arith.addf %in, %in_44 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x128xf32>
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %155 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %125 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %1) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %124[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%extracted_slice_41 : tensor<?x32x128xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.addf %in, %out : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %126 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %0) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %125[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32x1xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.divf %in, %cst_6 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %collapsed_39 = tensor.collapse_shape %126 [[0], [1, 2]] : tensor<2x1024x1xf32> into tensor<2x1024xf32>
    %127 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %collapsed_39[%148, %149] [%150, 32] [1, 1] : tensor<2x1024xf32> to tensor<?x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map5, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32xf32>) outs(%extracted_slice_42 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %128 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %154 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %124[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %127[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %155 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<?x32x128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %158 = arith.subf %in, %in_44 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x128xf32>
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %155 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %129 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %154 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %128[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %128[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %155 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<?x32x128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %158 = arith.mulf %in, %in_44 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x128xf32>
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %155 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %130 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %1) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %129[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%extracted_slice_41 : tensor<?x32x128xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.addf %in, %out : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %131 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %0) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %130[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32x1xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.divf %in, %cst_6 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %132 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %0) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %131[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32x1xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.truncf %cst_5 : f64 to f32
        %158 = arith.addf %in, %157 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %133 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %0) -> (tensor<2x1024x1xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %132[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<2x1024x1xf32> to tensor<?x32x1xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32x1xf32>) outs(%extracted_slice_42 : tensor<?x32x1xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = math.rsqrt %in : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x1xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 1] [1, 1, 1] : tensor<?x32x1xf32> into tensor<2x1024x1xf32>
      }
    }
    %collapsed_40 = tensor.collapse_shape %133 [[0], [1, 2]] : tensor<2x1024x1xf32> into tensor<2x1024xf32>
    %134 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %collapsed_40[%148, %149] [%150, 32] [1, 1] : tensor<2x1024xf32> to tensor<?x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map5, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32xf32>) outs(%extracted_slice_42 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %135 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %154 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %128[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %134[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %155 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<?x32x128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %158 = arith.mulf %in, %in_44 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x128xf32>
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %155 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %136 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %135[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg21[0] [128] [1] : tensor<128xf32> to tensor<128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %157 = arith.mulf %in, %in_44 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %137 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %136[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg22[0] [128] [1] : tensor<128xf32> to tensor<128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %157 = arith.addf %in, %in_44 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %138 = scf.forall (%arg28, %arg29) in (4, 16) shared_outs(%arg30 = %73) -> (tensor<128x512xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %extracted_slice_41 = tensor.extract_slice %arg23[%149, %148] [32, 32] [1, 1] : tensor<512x128xf32> to tensor<32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149] [32, 32] [1, 1] : tensor<128x512xf32> to tensor<32x32xf32>
      %transposed = linalg.transpose ins(%extracted_slice_41 : tensor<32x32xf32>) outs(%extracted_slice_42 : tensor<32x32xf32>) permutation = [1, 0] 
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %transposed into %arg30[%148, %149] [32, 32] [1, 1] : tensor<32x32xf32> into tensor<128x512xf32>
      }
    }
    %139 = scf.forall (%arg28, %arg29) in (1, 4) shared_outs(%arg30 = %75) -> (tensor<2x128x512xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %138[%149, 0] [32, 512] [1, 1] : tensor<128x512xf32> to tensor<32x512xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 512] [1, 1, 1] : tensor<2x128x512xf32> to tensor<?x32x512xf32>
      %153 = linalg.generic {indexing_maps = [#map7, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<32x512xf32>) outs(%extracted_slice_42 : tensor<?x32x512xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x32x512xf32>
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %153 into %arg30[%148, %149, 0] [%150, 32, 512] [1, 1, 1] : tensor<?x32x512xf32> into tensor<2x128x512xf32>
      }
    }
    %140 = scf.forall (%arg28, %arg29, %arg30, %arg31) in (2, 32, 16, 4) shared_outs(%arg32 = %78) -> (tensor<2x1024x512xf32>) {
      %148 = affine.apply #map(%arg29)
      %149 = affine.apply #map(%arg30)
      %150 = affine.apply #map(%arg31)
      %extracted_slice_41 = tensor.extract_slice %137[%arg28, %148, %150] [1, 32, 32] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<1x32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %139[%arg28, %150, %149] [1, 32, 32] [1, 1, 1] : tensor<2x128x512xf32> to tensor<1x32x32xf32>
      %extracted_slice_43 = tensor.extract_slice %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<2x1024x512xf32> to tensor<1x32x32xf32>
      %151 = linalg.batch_matmul ins(%extracted_slice_41, %extracted_slice_42 : tensor<1x32x32xf32>, tensor<1x32x32xf32>) outs(%extracted_slice_43 : tensor<1x32x32xf32>) -> tensor<1x32x32xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %151 into %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<1x32x32xf32> into tensor<2x1024x512xf32>
      }
    }
    %141 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %77) -> (tensor<2x1024x512xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %140[%148, %149, 0] [%150, 32, 512] [1, 1, 1] : tensor<2x1024x512xf32> to tensor<?x32x512xf32>
      %extracted_slice_42 = tensor.extract_slice %arg24[0] [512] [1] : tensor<512xf32> to tensor<512xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 512] [1, 1, 1] : tensor<2x1024x512xf32> to tensor<?x32x512xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x512xf32>, tensor<512xf32>) outs(%extracted_slice_43 : tensor<?x32x512xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %157 = arith.addf %in, %in_44 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x512xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 512] [1, 1, 1] : tensor<?x32x512xf32> into tensor<2x1024x512xf32>
      }
    }
    %142 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %77) -> (tensor<2x1024x512xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %141[%148, %149, 0] [%150, 32, 512] [1, 1, 1] : tensor<2x1024x512xf32> to tensor<?x32x512xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 512] [1, 1, 1] : tensor<2x1024x512xf32> to tensor<?x32x512xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<?x32x512xf32>) outs(%extracted_slice_42 : tensor<?x32x512xf32>) {
      ^bb0(%in: f32, %out: f32):
        %157 = arith.divf %in, %cst_7 : f32
        %158 = math.erf %157 : f32
        %159 = arith.addf %158, %cst_1 : f32
        %160 = arith.mulf %159, %cst_2 : f32
        %161 = arith.mulf %in, %160 : f32
        linalg.yield %161 : f32
      } -> tensor<?x32x512xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 512] [1, 1, 1] : tensor<?x32x512xf32> into tensor<2x1024x512xf32>
      }
    }
    %143 = scf.forall (%arg28, %arg29) in (16, 4) shared_outs(%arg30 = %82) -> (tensor<512x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %extracted_slice_41 = tensor.extract_slice %arg25[%149, %148] [32, 32] [1, 1] : tensor<128x512xf32> to tensor<32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149] [32, 32] [1, 1] : tensor<512x128xf32> to tensor<32x32xf32>
      %transposed = linalg.transpose ins(%extracted_slice_41 : tensor<32x32xf32>) outs(%extracted_slice_42 : tensor<32x32xf32>) permutation = [1, 0] 
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %transposed into %arg30[%148, %149] [32, 32] [1, 1] : tensor<32x32xf32> into tensor<512x128xf32>
      }
    }
    %144 = scf.forall (%arg28, %arg29) in (1, 16) shared_outs(%arg30 = %84) -> (tensor<2x512x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %143[%149, 0] [32, 128] [1, 1] : tensor<512x128xf32> to tensor<32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x512x128xf32> to tensor<?x32x128xf32>
      %153 = linalg.generic {indexing_maps = [#map7, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41 : tensor<32x128xf32>) outs(%extracted_slice_42 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      } -> tensor<?x32x128xf32>
      %154 = affine.apply #map2(%150)
      %155 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %153 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x512x128xf32>
      }
    }
    %145 = scf.forall (%arg28, %arg29, %arg30, %arg31) in (2, 32, 4, 16) shared_outs(%arg32 = %56) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg29)
      %149 = affine.apply #map(%arg30)
      %150 = affine.apply #map(%arg31)
      %extracted_slice_41 = tensor.extract_slice %142[%arg28, %148, %150] [1, 32, 32] [1, 1, 1] : tensor<2x1024x512xf32> to tensor<1x32x32xf32>
      %extracted_slice_42 = tensor.extract_slice %144[%arg28, %150, %149] [1, 32, 32] [1, 1, 1] : tensor<2x512x128xf32> to tensor<1x32x32xf32>
      %extracted_slice_43 = tensor.extract_slice %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<1x32x32xf32>
      %151 = linalg.batch_matmul ins(%extracted_slice_41, %extracted_slice_42 : tensor<1x32x32xf32>, tensor<1x32x32xf32>) outs(%extracted_slice_43 : tensor<1x32x32xf32>) -> tensor<1x32x32xf32>
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %151 into %arg32[%arg28, %148, %149] [1, 32, 32] [1, 1, 1] : tensor<1x32x32xf32> into tensor<2x1024x128xf32>
      }
    }
    %146 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %145[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %arg26[0] [128] [1] : tensor<128xf32> to tensor<128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %154 = linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %157 = arith.addf %in, %in_44 : f32
        linalg.yield %157 : f32
      } -> tensor<?x32x128xf32>
      %155 = affine.apply #map2(%150)
      %156 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %154 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    %147 = scf.forall (%arg28, %arg29) in (1, 32) shared_outs(%arg30 = %arg27) -> (tensor<2x1024x128xf32>) {
      %148 = affine.apply #map(%arg28)
      %149 = affine.apply #map(%arg29)
      %c2 = arith.constant 2 : index
      %150 = affine.min #map1(%148)
      %151 = affine.apply #map2(%150)
      %152 = affine.apply #map2(%150)
      %153 = affine.apply #map2(%150)
      %154 = affine.apply #map2(%150)
      %extracted_slice_41 = tensor.extract_slice %124[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_42 = tensor.extract_slice %146[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %extracted_slice_43 = tensor.extract_slice %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<2x1024x128xf32> to tensor<?x32x128xf32>
      %155 = linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%extracted_slice_41, %extracted_slice_42 : tensor<?x32x128xf32>, tensor<?x32x128xf32>) outs(%extracted_slice_43 : tensor<?x32x128xf32>) {
      ^bb0(%in: f32, %in_44: f32, %out: f32):
        %158 = arith.addf %in, %in_44 : f32
        linalg.yield %158 : f32
      } -> tensor<?x32x128xf32>
      %156 = affine.apply #map2(%150)
      %157 = affine.apply #map2(%150)
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %155 into %arg30[%148, %149, 0] [%150, 32, 128] [1, 1, 1] : tensor<?x32x128xf32> into tensor<2x1024x128xf32>
      }
    }
    return %147 : tensor<2x1024x128xf32>
  }
  transform.named_sequence @__transform_main(%arg0: !transform.any_op) {
    %0 = transform.structured.match ops{["linalg.batch_matmul"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %tiled_op, %forall_op = transform.structured.tile_using_forall %0 tile_sizes [1, 32, 32, 32] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %1 = transform.structured.match ops{["linalg.generic"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %tiled_op_0, %forall_op_1 = transform.structured.tile_using_forall %1 tile_sizes [32, 32] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    %2 = transform.structured.match ops{["linalg.transpose"]} in %arg0 : (!transform.any_op) -> !transform.any_op
    %tiled_op_2, %forall_op_3 = transform.structured.tile_using_forall %2 tile_sizes [32, 32] : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    transform.yield 
  }
}

