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
  func.func @main(%arg0: memref<?x?x?xf32>, %arg1: memref<?x?x?xf32>, %arg2: memref<?x?xf32>, %arg3: memref<?x?xf32>, %arg4: memref<?xf32>, %arg5: memref<?xf32>, %arg6: memref<?xf32>, %arg7: memref<?xf32>, %arg8: memref<?x?x?xf32>) attributes {llvm.emit_c_interface} {
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
    %dim = memref.dim %arg0, %c0 : memref<?x?x?xf32>
    %dim_7 = memref.dim %arg0, %c1 : memref<?x?x?xf32>
    %alloc = memref.alloc(%dim, %dim_7) {alignment = 64 : i64} : memref<?x?x1xf32>
    %alloc_8 = memref.alloc(%dim, %dim_7) {alignment = 64 : i64} : memref<?x?x1xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_8 : memref<?x?x1xf32>)
    %dim_9 = memref.dim %arg0, %c0 : memref<?x?x?xf32>
    %dim_10 = memref.dim %arg0, %c1 : memref<?x?x?xf32>
    %dim_11 = memref.dim %arg0, %c2 : memref<?x?x?xf32>
    %0 = affine.apply #map()[%dim_11]
    %c0_12 = arith.constant 0 : index
    %dim_13 = memref.dim %alloc_8, %c0_12 : memref<?x?x1xf32>
    %c1_14 = arith.constant 1 : index
    %dim_15 = memref.dim %alloc_8, %c1_14 : memref<?x?x1xf32>
    %alloc_16 = memref.alloc(%dim_13, %dim_15) {alignment = 64 : i64} : memref<?x?x1xf32>
    linalg.copy ins(%alloc_8 : memref<?x?x1xf32>) outs(%alloc_16 : memref<?x?x1xf32>)
    scf.forall (%arg9) in (%0) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_11]
      %subview = memref.subview %arg0[0, 0, %52] [%dim_9, %dim_10, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_16[0, 0, 0] [%dim_9, %dim_10, 1] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x1xf32, strided<[?, 1, 1]>>
      linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%subview : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_208 : memref<?x?x1xf32, strided<[?, 1, 1]>>) {
      ^bb0(%in: f32, %out: f32):
        %54 = arith.addf %in, %out : f32
        linalg.yield %54 : f32
      }
      %subview_209 = memref.subview %alloc_16[0, 0, 0] [%dim_9, %dim_10, 1] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x1xf32, strided<[?, 1, 1]>>
      linalg.copy ins(%subview_208 : memref<?x?x1xf32, strided<[?, 1, 1]>>) outs(%subview_209 : memref<?x?x1xf32, strided<[?, 1, 1]>>)
    }
    %dim_17 = memref.dim %arg0, %c2 : memref<?x?x?xf32>
    %1 = arith.index_cast %dim_17 : index to i64
    %dim_18 = memref.dim %alloc_16, %c0 : memref<?x?x1xf32>
    %dim_19 = memref.dim %alloc_16, %c1 : memref<?x?x1xf32>
    %alloc_20 = memref.alloc(%dim, %dim_7) {alignment = 64 : i64} : memref<?x?x1xf32>
    scf.forall (%arg9) in (1) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map5(%52)
      %subview = memref.subview %alloc_16[0, 0, %52] [%dim_18, %dim_19, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_20[0, 0, %52] [%dim_18, %dim_19, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) outs(%subview_208 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %54 = arith.sitofp %1 : i64 to f32
        %55 = arith.divf %in, %54 : f32
        linalg.yield %55 : f32
      }
      %subview_209 = memref.subview %alloc_20[0, 0, %52] [%dim_18, %dim_19, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      linalg.copy ins(%subview_208 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>)
    }
    %alloc_21 = memref.alloc(%dim, %dim_7, %dim_17) {alignment = 64 : i64} : memref<?x?x?xf64>
    %dim_22 = memref.dim %arg0, %c0 : memref<?x?x?xf32>
    %dim_23 = memref.dim %arg0, %c1 : memref<?x?x?xf32>
    %dim_24 = memref.dim %arg0, %c2 : memref<?x?x?xf32>
    %2 = affine.apply #map()[%dim_24]
    scf.forall (%arg9) in (%2) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_24]
      %subview = memref.subview %arg0[0, 0, %52] [%dim_22, %dim_23, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_21[0, 0, %52] [%dim_22, %dim_23, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_208 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f64):
        %54 = arith.extf %in : f32 to f64
        linalg.yield %54 : f64
      }
      %subview_209 = memref.subview %alloc_21[0, 0, %52] [%dim_22, %dim_23, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_208 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>)
    }
    %alloc_25 = memref.alloc(%dim, %dim_7) {alignment = 64 : i64} : memref<?x?x1xf64>
    %alloc_26 = memref.alloc(%dim, %dim_7) {alignment = 64 : i64} : memref<?x?x1xf64>
    linalg.fill ins(%cst_0 : f64) outs(%alloc_26 : memref<?x?x1xf64>)
    %dim_27 = memref.dim %alloc_21, %c0 : memref<?x?x?xf64>
    %dim_28 = memref.dim %alloc_21, %c1 : memref<?x?x?xf64>
    %dim_29 = memref.dim %alloc_21, %c2 : memref<?x?x?xf64>
    %3 = affine.apply #map()[%dim_29]
    %c0_30 = arith.constant 0 : index
    %dim_31 = memref.dim %alloc_26, %c0_30 : memref<?x?x1xf64>
    %c1_32 = arith.constant 1 : index
    %dim_33 = memref.dim %alloc_26, %c1_32 : memref<?x?x1xf64>
    %alloc_34 = memref.alloc(%dim_31, %dim_33) {alignment = 64 : i64} : memref<?x?x1xf64>
    linalg.copy ins(%alloc_26 : memref<?x?x1xf64>) outs(%alloc_34 : memref<?x?x1xf64>)
    scf.forall (%arg9) in (%3) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_29]
      %subview = memref.subview %alloc_21[0, 0, %52] [%dim_27, %dim_28, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_34[0, 0, 0] [%dim_27, %dim_28, 1] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x1xf64, strided<[?, 1, 1]>>
      linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%subview : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>) outs(%subview_208 : memref<?x?x1xf64, strided<[?, 1, 1]>>) {
      ^bb0(%in: f64, %out: f64):
        %54 = arith.addf %in, %out : f64
        linalg.yield %54 : f64
      }
      %subview_209 = memref.subview %alloc_34[0, 0, 0] [%dim_27, %dim_28, 1] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x1xf64, strided<[?, 1, 1]>>
      linalg.copy ins(%subview_208 : memref<?x?x1xf64, strided<[?, 1, 1]>>) outs(%subview_209 : memref<?x?x1xf64, strided<[?, 1, 1]>>)
    }
    %dim_35 = memref.dim %alloc_34, %c0 : memref<?x?x1xf64>
    %dim_36 = memref.dim %alloc_34, %c1 : memref<?x?x1xf64>
    scf.forall (%arg9) in (1) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map5(%52)
      %subview = memref.subview %alloc_34[0, 0, %52] [%dim_35, %dim_36, %53] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_25[0, 0, %52] [%dim_35, %dim_36, %53] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>) outs(%subview_208 : memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>) {
      ^bb0(%in: f64, %out: f64):
        %54 = arith.sitofp %1 : i64 to f64
        %55 = arith.divf %in, %54 : f64
        linalg.yield %55 : f64
      }
      %subview_209 = memref.subview %alloc_25[0, 0, %52] [%dim_35, %dim_36, %53] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>
      linalg.copy ins(%subview_208 : memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>)
    }
    %dim_37 = memref.dim %alloc_21, %c0 : memref<?x?x?xf64>
    %dim_38 = memref.dim %alloc_21, %c1 : memref<?x?x?xf64>
    %dim_39 = memref.dim %alloc_21, %c2 : memref<?x?x?xf64>
    %4 = affine.apply #map()[%dim_39]
    %alloc_40 = memref.alloc(%dim, %dim_7, %dim_17) {alignment = 64 : i64} : memref<?x?x?xf64>
    scf.forall (%arg9) in (%4) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_39]
      %subview = memref.subview %alloc_21[0, 0, %52] [%dim_37, %dim_38, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_25[0, 0, 0] [%dim_37, %dim_38, 1] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x1xf64, strided<[?, 1, 1]>>
      %subview_209 = memref.subview %alloc_40[0, 0, %52] [%dim_37, %dim_38, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview, %subview_208 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>, memref<?x?x1xf64, strided<[?, 1, 1]>>) outs(%subview_209 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f64, %in_211: f64, %out: f64):
        %54 = arith.subf %in, %in_211 : f64
        linalg.yield %54 : f64
      }
      %subview_210 = memref.subview %alloc_40[0, 0, %52] [%dim_37, %dim_38, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>) outs(%subview_210 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>)
    }
    %dim_41 = memref.dim %alloc_40, %c0 : memref<?x?x?xf64>
    %dim_42 = memref.dim %alloc_40, %c1 : memref<?x?x?xf64>
    %dim_43 = memref.dim %alloc_40, %c2 : memref<?x?x?xf64>
    %5 = affine.apply #map()[%dim_43]
    scf.forall (%arg9) in (%5) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_43]
      %subview = memref.subview %alloc_40[0, 0, %52] [%dim_41, %dim_42, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_40[0, 0, %52] [%dim_41, %dim_42, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      %subview_209 = memref.subview %alloc_21[0, 0, %52] [%dim_41, %dim_42, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview, %subview_208 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>, memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f64, %in_211: f64, %out: f64):
        %54 = arith.mulf %in, %in_211 : f64
        linalg.yield %54 : f64
      }
      %subview_210 = memref.subview %alloc_21[0, 0, %52] [%dim_41, %dim_42, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>) outs(%subview_210 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>)
    }
    %dim_44 = memref.dim %alloc_21, %c0 : memref<?x?x?xf64>
    %dim_45 = memref.dim %alloc_21, %c1 : memref<?x?x?xf64>
    %dim_46 = memref.dim %alloc_21, %c2 : memref<?x?x?xf64>
    %6 = affine.apply #map()[%dim_46]
    %c0_47 = arith.constant 0 : index
    %dim_48 = memref.dim %alloc_26, %c0_47 : memref<?x?x1xf64>
    %c1_49 = arith.constant 1 : index
    %dim_50 = memref.dim %alloc_26, %c1_49 : memref<?x?x1xf64>
    %alloc_51 = memref.alloc(%dim_48, %dim_50) {alignment = 64 : i64} : memref<?x?x1xf64>
    linalg.copy ins(%alloc_26 : memref<?x?x1xf64>) outs(%alloc_51 : memref<?x?x1xf64>)
    scf.forall (%arg9) in (%6) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_46]
      %subview = memref.subview %alloc_21[0, 0, %52] [%dim_44, %dim_45, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_51[0, 0, 0] [%dim_44, %dim_45, 1] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x1xf64, strided<[?, 1, 1]>>
      linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%subview : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>) outs(%subview_208 : memref<?x?x1xf64, strided<[?, 1, 1]>>) {
      ^bb0(%in: f64, %out: f64):
        %54 = arith.addf %in, %out : f64
        linalg.yield %54 : f64
      }
      %subview_209 = memref.subview %alloc_51[0, 0, 0] [%dim_44, %dim_45, 1] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x1xf64, strided<[?, 1, 1]>>
      linalg.copy ins(%subview_208 : memref<?x?x1xf64, strided<[?, 1, 1]>>) outs(%subview_209 : memref<?x?x1xf64, strided<[?, 1, 1]>>)
    }
    %dim_52 = memref.dim %alloc_51, %c0 : memref<?x?x1xf64>
    %dim_53 = memref.dim %alloc_51, %c1 : memref<?x?x1xf64>
    scf.forall (%arg9) in (1) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map5(%52)
      %subview = memref.subview %alloc_51[0, 0, %52] [%dim_52, %dim_53, %53] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_25[0, 0, %52] [%dim_52, %dim_53, %53] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>) outs(%subview_208 : memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>) {
      ^bb0(%in: f64, %out: f64):
        %54 = arith.sitofp %1 : i64 to f64
        %55 = arith.divf %in, %54 : f64
        linalg.yield %55 : f64
      }
      %subview_209 = memref.subview %alloc_25[0, 0, %52] [%dim_52, %dim_53, %53] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>
      linalg.copy ins(%subview_208 : memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>)
    }
    %dim_54 = memref.dim %alloc_25, %c0 : memref<?x?x1xf64>
    %dim_55 = memref.dim %alloc_25, %c1 : memref<?x?x1xf64>
    scf.forall (%arg9) in (1) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map5(%52)
      %subview = memref.subview %alloc_25[0, 0, %52] [%dim_54, %dim_55, %53] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>
      %subview_208 = memref.subview %alloc[0, 0, %52] [%dim_54, %dim_55, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>) outs(%subview_208 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) {
      ^bb0(%in: f64, %out: f32):
        %54 = arith.truncf %in : f64 to f32
        linalg.yield %54 : f32
      }
      %subview_209 = memref.subview %alloc[0, 0, %52] [%dim_54, %dim_55, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      linalg.copy ins(%subview_208 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>)
    }
    %alloc_56 = memref.alloc(%dim, %dim_7, %dim_17) {alignment = 64 : i64} : memref<?x?x?xf32>
    %dim_57 = memref.dim %arg0, %c0 : memref<?x?x?xf32>
    %dim_58 = memref.dim %arg0, %c1 : memref<?x?x?xf32>
    %dim_59 = memref.dim %arg0, %c2 : memref<?x?x?xf32>
    %7 = affine.apply #map()[%dim_59]
    scf.forall (%arg9) in (%7) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_59]
      %subview = memref.subview %arg0[0, 0, %52] [%dim_57, %dim_58, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_20[0, 0, 0] [%dim_57, %dim_58, 1] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x1xf32, strided<[?, 1, 1]>>
      %subview_209 = memref.subview %alloc_56[0, 0, %52] [%dim_57, %dim_58, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview, %subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?x?x1xf32, strided<[?, 1, 1]>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_211: f32, %out: f32):
        %54 = arith.subf %in, %in_211 : f32
        linalg.yield %54 : f32
      }
      %subview_210 = memref.subview %alloc_56[0, 0, %52] [%dim_57, %dim_58, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_210 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    %dim_60 = memref.dim %alloc, %c0 : memref<?x?x1xf32>
    %dim_61 = memref.dim %alloc, %c1 : memref<?x?x1xf32>
    %alloc_62 = memref.alloc(%dim, %dim_7) {alignment = 64 : i64} : memref<?x?x1xf32>
    scf.forall (%arg9) in (1) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map5(%52)
      %subview = memref.subview %alloc[0, 0, %52] [%dim_60, %dim_61, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_62[0, 0, %52] [%dim_60, %dim_61, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) outs(%subview_208 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %54 = arith.truncf %cst_4 : f64 to f32
        %55 = arith.addf %in, %54 : f32
        linalg.yield %55 : f32
      }
      %subview_209 = memref.subview %alloc_62[0, 0, %52] [%dim_60, %dim_61, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      linalg.copy ins(%subview_208 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>)
    }
    %dim_63 = memref.dim %alloc_62, %c0 : memref<?x?x1xf32>
    %dim_64 = memref.dim %alloc_62, %c1 : memref<?x?x1xf32>
    scf.forall (%arg9) in (1) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map5(%52)
      %subview = memref.subview %alloc_62[0, 0, %52] [%dim_63, %dim_64, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      %subview_208 = memref.subview %alloc[0, 0, %52] [%dim_63, %dim_64, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) outs(%subview_208 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %54 = math.sqrt %in : f32
        linalg.yield %54 : f32
      }
      %subview_209 = memref.subview %alloc[0, 0, %52] [%dim_63, %dim_64, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      linalg.copy ins(%subview_208 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>)
    }
    %dim_65 = memref.dim %alloc_56, %c0 : memref<?x?x?xf32>
    %dim_66 = memref.dim %alloc_56, %c1 : memref<?x?x?xf32>
    %dim_67 = memref.dim %alloc_56, %c2 : memref<?x?x?xf32>
    %8 = affine.apply #map()[%dim_67]
    %alloc_68 = memref.alloc(%dim, %dim_7, %dim_17) {alignment = 64 : i64} : memref<?x?x?xf32>
    scf.forall (%arg9) in (%8) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_67]
      %subview = memref.subview %alloc_56[0, 0, %52] [%dim_65, %dim_66, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc[0, 0, 0] [%dim_65, %dim_66, 1] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x1xf32, strided<[?, 1, 1]>>
      %subview_209 = memref.subview %alloc_68[0, 0, %52] [%dim_65, %dim_66, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview, %subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?x?x1xf32, strided<[?, 1, 1]>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_211: f32, %out: f32):
        %54 = arith.divf %in, %in_211 : f32
        linalg.yield %54 : f32
      }
      %subview_210 = memref.subview %alloc_68[0, 0, %52] [%dim_65, %dim_66, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_210 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    %dim_69 = memref.dim %arg4, %c0 : memref<?xf32>
    %9 = arith.cmpi eq, %dim_17, %dim_69 : index
    cf.assert %9, "mismatched size for broadcast"
    %dim_70 = memref.dim %alloc_68, %c0 : memref<?x?x?xf32>
    %dim_71 = memref.dim %alloc_68, %c1 : memref<?x?x?xf32>
    %dim_72 = memref.dim %alloc_68, %c2 : memref<?x?x?xf32>
    %10 = affine.apply #map()[%dim_72]
    scf.forall (%arg9) in (%10) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_72]
      %subview = memref.subview %alloc_68[0, 0, %52] [%dim_70, %dim_71, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %arg4[%52] [%53] [1] : memref<?xf32> to memref<?xf32, strided<[1], offset: ?>>
      %subview_209 = memref.subview %alloc_56[0, 0, %52] [%dim_70, %dim_71, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview, %subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?xf32, strided<[1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_211: f32, %out: f32):
        %54 = arith.mulf %in, %in_211 : f32
        linalg.yield %54 : f32
      }
      %subview_210 = memref.subview %alloc_56[0, 0, %52] [%dim_70, %dim_71, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_210 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    %dim_73 = memref.dim %arg5, %c0 : memref<?xf32>
    %11 = arith.cmpi eq, %dim_17, %dim_73 : index
    cf.assert %11, "mismatched size for broadcast"
    %dim_74 = memref.dim %alloc_56, %c0 : memref<?x?x?xf32>
    %dim_75 = memref.dim %alloc_56, %c1 : memref<?x?x?xf32>
    %dim_76 = memref.dim %alloc_56, %c2 : memref<?x?x?xf32>
    %12 = affine.apply #map()[%dim_76]
    %alloc_77 = memref.alloc(%dim, %dim_7, %dim_17) {alignment = 64 : i64} : memref<?x?x?xf32>
    scf.forall (%arg9) in (%12) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_76]
      %subview = memref.subview %alloc_56[0, 0, %52] [%dim_74, %dim_75, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %arg5[%52] [%53] [1] : memref<?xf32> to memref<?xf32, strided<[1], offset: ?>>
      %subview_209 = memref.subview %alloc_77[0, 0, %52] [%dim_74, %dim_75, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview, %subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?xf32, strided<[1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_211: f32, %out: f32):
        %54 = arith.addf %in, %in_211 : f32
        linalg.yield %54 : f32
      }
      %subview_210 = memref.subview %alloc_77[0, 0, %52] [%dim_74, %dim_75, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_210 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    %alloc_78 = memref.alloc(%dim, %dim_17, %dim_7) {alignment = 64 : i64} : memref<?x?x?xf32>
    linalg.transpose ins(%alloc_77 : memref<?x?x?xf32>) outs(%alloc_78 : memref<?x?x?xf32>) permutation = [0, 2, 1] 
    %alloc_79 = memref.alloc(%dim, %dim_7, %dim_7) {alignment = 64 : i64} : memref<?x?x?xf32>
    %alloc_80 = memref.alloc(%dim, %dim_7, %dim_7) {alignment = 64 : i64} : memref<?x?x?xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_80 : memref<?x?x?xf32>)
    %dim_81 = memref.dim %alloc_77, %c0 : memref<?x?x?xf32>
    %dim_82 = memref.dim %alloc_77, %c1 : memref<?x?x?xf32>
    %dim_83 = memref.dim %alloc_77, %c2 : memref<?x?x?xf32>
    %dim_84 = memref.dim %alloc_78, %c2 : memref<?x?x?xf32>
    %13 = affine.apply #map()[%dim_83]
    scf.forall (%arg9) in (%13) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_83]
      %subview = memref.subview %alloc_77[0, 0, %52] [%dim_81, %dim_82, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_78[0, %52, 0] [%dim_81, %53, %dim_84] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_209 = memref.subview %alloc_80[0, 0, 0] [%dim_81, %dim_82, %dim_84] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1]>>
      linalg.batch_matmul ins(%subview, %subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1]>>)
      %subview_210 = memref.subview %alloc_80[0, 0, 0] [%dim_81, %dim_82, %dim_84] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1]>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1]>>) outs(%subview_210 : memref<?x?x?xf32, strided<[?, ?, 1]>>)
    }
    %dim_85 = memref.dim %alloc_80, %c0 : memref<?x?x?xf32>
    %dim_86 = memref.dim %alloc_80, %c1 : memref<?x?x?xf32>
    %dim_87 = memref.dim %alloc_80, %c2 : memref<?x?x?xf32>
    %14 = affine.apply #map()[%dim_87]
    scf.forall (%arg9) in (%14) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_87]
      %subview = memref.subview %alloc_80[0, 0, %52] [%dim_85, %dim_86, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_79[0, 0, %52] [%dim_85, %dim_86, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %54 = arith.divf %in, %cst_5 : f32
        linalg.yield %54 : f32
      }
      %subview_209 = memref.subview %alloc_79[0, 0, %52] [%dim_85, %dim_86, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    %dim_88 = memref.dim %arg1, %c0 : memref<?x?x?xf32>
    %15 = arith.cmpi eq, %dim, %dim_88 : index
    cf.assert %15, "mismatched size for broadcast"
    %dim_89 = memref.dim %arg1, %c1 : memref<?x?x?xf32>
    %16 = arith.cmpi eq, %dim_7, %dim_89 : index
    cf.assert %16, "mismatched size for broadcast"
    %dim_90 = memref.dim %arg1, %c2 : memref<?x?x?xf32>
    %17 = arith.cmpi eq, %dim_7, %dim_90 : index
    cf.assert %17, "mismatched size for broadcast"
    %dim_91 = memref.dim %alloc_79, %c0 : memref<?x?x?xf32>
    %dim_92 = memref.dim %alloc_79, %c1 : memref<?x?x?xf32>
    %dim_93 = memref.dim %alloc_79, %c2 : memref<?x?x?xf32>
    %18 = affine.apply #map()[%dim_93]
    %alloc_94 = memref.alloc(%dim, %dim_7, %dim_7) {alignment = 64 : i64} : memref<?x?x?xf32>
    scf.forall (%arg9) in (%18) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_93]
      %subview = memref.subview %alloc_79[0, 0, %52] [%dim_91, %dim_92, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %arg1[0, 0, %52] [%dim_91, %dim_92, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_209 = memref.subview %alloc_94[0, 0, %52] [%dim_91, %dim_92, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview, %subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_211: f32, %out: f32):
        %54 = arith.addf %in, %in_211 : f32
        linalg.yield %54 : f32
      }
      %subview_210 = memref.subview %alloc_94[0, 0, %52] [%dim_91, %dim_92, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_210 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    %alloc_95 = memref.alloc(%dim, %dim_7) {alignment = 64 : i64} : memref<?x?xi64>
    linalg.fill ins(%c0_i64 : i64) outs(%alloc_95 : memref<?x?xi64>)
    %alloc_96 = memref.alloc(%dim, %dim_7) {alignment = 64 : i64} : memref<?x?xf32>
    linalg.fill ins(%cst_1 : f32) outs(%alloc_96 : memref<?x?xf32>)
    %dim_97 = memref.dim %alloc_94, %c0 : memref<?x?x?xf32>
    %dim_98 = memref.dim %alloc_94, %c1 : memref<?x?x?xf32>
    %dim_99 = memref.dim %alloc_94, %c2 : memref<?x?x?xf32>
    %19 = affine.apply #map()[%dim_99]
    scf.forall (%arg9) in (%19) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_99]
      %subview = memref.subview %alloc_94[0, 0, %52] [%dim_97, %dim_98, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_96[0, 0] [%dim_97, %dim_98] [1, 1] : memref<?x?xf32> to memref<?x?xf32, strided<[?, 1]>>
      %subview_209 = memref.subview %alloc_95[0, 0] [%dim_97, %dim_98] [1, 1] : memref<?x?xi64> to memref<?x?xi64, strided<[?, 1]>>
      linalg.generic {indexing_maps = [#map3, #map7, #map7], iterator_types = ["parallel", "parallel", "reduction"]} ins(%subview : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_208, %subview_209 : memref<?x?xf32, strided<[?, 1]>>, memref<?x?xi64, strided<[?, 1]>>) {
      ^bb0(%in: f32, %out: f32, %out_212: i64):
        %54 = linalg.index 2 : index
        %55 = affine.apply #map8(%52)[%54]
        %56 = arith.index_cast %55 : index to i64
        %57 = arith.maximumf %in, %out : f32
        %58 = arith.cmpf ogt, %in, %out : f32
        %59 = arith.select %58, %56, %out_212 : i64
        linalg.yield %57, %59 : f32, i64
      }
      %subview_210 = memref.subview %alloc_96[0, 0] [%dim_97, %dim_98] [1, 1] : memref<?x?xf32> to memref<?x?xf32, strided<[?, 1]>>
      linalg.copy ins(%subview_208 : memref<?x?xf32, strided<[?, 1]>>) outs(%subview_210 : memref<?x?xf32, strided<[?, 1]>>)
      %subview_211 = memref.subview %alloc_95[0, 0] [%dim_97, %dim_98] [1, 1] : memref<?x?xi64> to memref<?x?xi64, strided<[?, 1]>>
      linalg.copy ins(%subview_209 : memref<?x?xi64, strided<[?, 1]>>) outs(%subview_211 : memref<?x?xi64, strided<[?, 1]>>)
    }
    %expand_shape = memref.expand_shape %alloc_96 [[0], [1, 2]] output_shape [%dim, %dim_7, 1] : memref<?x?xf32> into memref<?x?x1xf32>
    %dim_100 = memref.dim %alloc_94, %c0 : memref<?x?x?xf32>
    %dim_101 = memref.dim %alloc_94, %c1 : memref<?x?x?xf32>
    %dim_102 = memref.dim %alloc_94, %c2 : memref<?x?x?xf32>
    %20 = affine.apply #map()[%dim_102]
    scf.forall (%arg9) in (%20) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_102]
      %subview = memref.subview %alloc_94[0, 0, %52] [%dim_100, %dim_101, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %expand_shape[0, 0, 0] [%dim_100, %dim_101, 1] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x1xf32, strided<[?, 1, 1]>>
      %subview_209 = memref.subview %alloc_79[0, 0, %52] [%dim_100, %dim_101, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview, %subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?x?x1xf32, strided<[?, 1, 1]>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_211: f32, %out: f32):
        %54 = arith.subf %in, %in_211 : f32
        linalg.yield %54 : f32
      }
      %subview_210 = memref.subview %alloc_79[0, 0, %52] [%dim_100, %dim_101, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_210 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    %dim_103 = memref.dim %alloc_79, %c0 : memref<?x?x?xf32>
    %dim_104 = memref.dim %alloc_79, %c1 : memref<?x?x?xf32>
    %dim_105 = memref.dim %alloc_79, %c2 : memref<?x?x?xf32>
    %21 = affine.apply #map()[%dim_105]
    %alloc_106 = memref.alloc(%dim, %dim_7, %dim_7) {alignment = 64 : i64} : memref<?x?x?xf32>
    scf.forall (%arg9) in (%21) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_105]
      %subview = memref.subview %alloc_79[0, 0, %52] [%dim_103, %dim_104, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_106[0, 0, %52] [%dim_103, %dim_104, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %54 = math.exp %in : f32
        linalg.yield %54 : f32
      }
      %subview_209 = memref.subview %alloc_106[0, 0, %52] [%dim_103, %dim_104, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    %dim_107 = memref.dim %alloc_106, %c0 : memref<?x?x?xf32>
    %dim_108 = memref.dim %alloc_106, %c1 : memref<?x?x?xf32>
    %dim_109 = memref.dim %alloc_106, %c2 : memref<?x?x?xf32>
    %22 = affine.apply #map()[%dim_109]
    %c0_110 = arith.constant 0 : index
    %dim_111 = memref.dim %alloc_8, %c0_110 : memref<?x?x1xf32>
    %c1_112 = arith.constant 1 : index
    %dim_113 = memref.dim %alloc_8, %c1_112 : memref<?x?x1xf32>
    %alloc_114 = memref.alloc(%dim_111, %dim_113) {alignment = 64 : i64} : memref<?x?x1xf32>
    linalg.copy ins(%alloc_8 : memref<?x?x1xf32>) outs(%alloc_114 : memref<?x?x1xf32>)
    scf.forall (%arg9) in (%22) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_109]
      %subview = memref.subview %alloc_106[0, 0, %52] [%dim_107, %dim_108, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_114[0, 0, 0] [%dim_107, %dim_108, 1] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x1xf32, strided<[?, 1, 1]>>
      linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%subview : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_208 : memref<?x?x1xf32, strided<[?, 1, 1]>>) {
      ^bb0(%in: f32, %out: f32):
        %54 = arith.addf %in, %out : f32
        linalg.yield %54 : f32
      }
      %subview_209 = memref.subview %alloc_114[0, 0, 0] [%dim_107, %dim_108, 1] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x1xf32, strided<[?, 1, 1]>>
      linalg.copy ins(%subview_208 : memref<?x?x1xf32, strided<[?, 1, 1]>>) outs(%subview_209 : memref<?x?x1xf32, strided<[?, 1, 1]>>)
    }
    %dim_115 = memref.dim %alloc_106, %c0 : memref<?x?x?xf32>
    %dim_116 = memref.dim %alloc_106, %c1 : memref<?x?x?xf32>
    %dim_117 = memref.dim %alloc_106, %c2 : memref<?x?x?xf32>
    %23 = affine.apply #map()[%dim_117]
    scf.forall (%arg9) in (%23) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_117]
      %subview = memref.subview %alloc_106[0, 0, %52] [%dim_115, %dim_116, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_114[0, 0, 0] [%dim_115, %dim_116, 1] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x1xf32, strided<[?, 1, 1]>>
      %subview_209 = memref.subview %alloc_79[0, 0, %52] [%dim_115, %dim_116, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview, %subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?x?x1xf32, strided<[?, 1, 1]>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_211: f32, %out: f32):
        %54 = arith.divf %in, %in_211 : f32
        linalg.yield %54 : f32
      }
      %subview_210 = memref.subview %alloc_79[0, 0, %52] [%dim_115, %dim_116, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_210 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    linalg.fill ins(%cst : f32) outs(%alloc_56 : memref<?x?x?xf32>)
    %dim_118 = memref.dim %alloc_79, %c0 : memref<?x?x?xf32>
    %dim_119 = memref.dim %alloc_79, %c1 : memref<?x?x?xf32>
    %dim_120 = memref.dim %alloc_79, %c2 : memref<?x?x?xf32>
    %dim_121 = memref.dim %alloc_77, %c2 : memref<?x?x?xf32>
    %24 = affine.apply #map()[%dim_120]
    scf.forall (%arg9) in (%24) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_120]
      %subview = memref.subview %alloc_79[0, 0, %52] [%dim_118, %dim_119, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_77[0, %52, 0] [%dim_118, %53, %dim_121] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_209 = memref.subview %alloc_56[0, 0, 0] [%dim_118, %dim_119, %dim_121] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1]>>
      linalg.batch_matmul ins(%subview, %subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1]>>)
      %subview_210 = memref.subview %alloc_56[0, 0, 0] [%dim_118, %dim_119, %dim_121] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1]>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1]>>) outs(%subview_210 : memref<?x?x?xf32, strided<[?, ?, 1]>>)
    }
    %dim_122 = memref.dim %arg0, %c0 : memref<?x?x?xf32>
    %dim_123 = memref.dim %arg0, %c1 : memref<?x?x?xf32>
    %dim_124 = memref.dim %arg0, %c2 : memref<?x?x?xf32>
    %25 = affine.apply #map()[%dim_124]
    %alloc_125 = memref.alloc(%dim, %dim_7, %dim_17) {alignment = 64 : i64} : memref<?x?x?xf32>
    scf.forall (%arg9) in (%25) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_124]
      %subview = memref.subview %arg0[0, 0, %52] [%dim_122, %dim_123, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_56[0, 0, %52] [%dim_122, %dim_123, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_209 = memref.subview %alloc_125[0, 0, %52] [%dim_122, %dim_123, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview, %subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_211: f32, %out: f32):
        %54 = arith.addf %in, %in_211 : f32
        linalg.yield %54 : f32
      }
      %subview_210 = memref.subview %alloc_125[0, 0, %52] [%dim_122, %dim_123, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_210 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    %dim_126 = memref.dim %alloc_125, %c0 : memref<?x?x?xf32>
    %dim_127 = memref.dim %alloc_125, %c1 : memref<?x?x?xf32>
    %dim_128 = memref.dim %alloc_125, %c2 : memref<?x?x?xf32>
    %26 = affine.apply #map()[%dim_128]
    scf.forall (%arg9) in (%26) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_128]
      %subview = memref.subview %alloc_125[0, 0, %52] [%dim_126, %dim_127, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_8[0, 0, 0] [%dim_126, %dim_127, 1] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x1xf32, strided<[?, 1, 1]>>
      linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%subview : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_208 : memref<?x?x1xf32, strided<[?, 1, 1]>>) {
      ^bb0(%in: f32, %out: f32):
        %54 = arith.addf %in, %out : f32
        linalg.yield %54 : f32
      }
      %subview_209 = memref.subview %alloc_8[0, 0, 0] [%dim_126, %dim_127, 1] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x1xf32, strided<[?, 1, 1]>>
      linalg.copy ins(%subview_208 : memref<?x?x1xf32, strided<[?, 1, 1]>>) outs(%subview_209 : memref<?x?x1xf32, strided<[?, 1, 1]>>)
    }
    %dim_129 = memref.dim %alloc_8, %c0 : memref<?x?x1xf32>
    %dim_130 = memref.dim %alloc_8, %c1 : memref<?x?x1xf32>
    %alloc_131 = memref.alloc(%dim, %dim_7) {alignment = 64 : i64} : memref<?x?x1xf32>
    scf.forall (%arg9) in (1) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map5(%52)
      %subview = memref.subview %alloc_8[0, 0, %52] [%dim_129, %dim_130, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_131[0, 0, %52] [%dim_129, %dim_130, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) outs(%subview_208 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %54 = arith.sitofp %1 : i64 to f32
        %55 = arith.divf %in, %54 : f32
        linalg.yield %55 : f32
      }
      %subview_209 = memref.subview %alloc_131[0, 0, %52] [%dim_129, %dim_130, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      linalg.copy ins(%subview_208 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>)
    }
    %dim_132 = memref.dim %alloc_125, %c0 : memref<?x?x?xf32>
    %dim_133 = memref.dim %alloc_125, %c1 : memref<?x?x?xf32>
    %dim_134 = memref.dim %alloc_125, %c2 : memref<?x?x?xf32>
    %27 = affine.apply #map()[%dim_134]
    scf.forall (%arg9) in (%27) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_134]
      %subview = memref.subview %alloc_125[0, 0, %52] [%dim_132, %dim_133, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_21[0, 0, %52] [%dim_132, %dim_133, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_208 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f64):
        %54 = arith.extf %in : f32 to f64
        linalg.yield %54 : f64
      }
      %subview_209 = memref.subview %alloc_21[0, 0, %52] [%dim_132, %dim_133, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_208 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>)
    }
    %dim_135 = memref.dim %alloc_21, %c0 : memref<?x?x?xf64>
    %dim_136 = memref.dim %alloc_21, %c1 : memref<?x?x?xf64>
    %dim_137 = memref.dim %alloc_21, %c2 : memref<?x?x?xf64>
    %28 = affine.apply #map()[%dim_137]
    %c0_138 = arith.constant 0 : index
    %dim_139 = memref.dim %alloc_26, %c0_138 : memref<?x?x1xf64>
    %c1_140 = arith.constant 1 : index
    %dim_141 = memref.dim %alloc_26, %c1_140 : memref<?x?x1xf64>
    %alloc_142 = memref.alloc(%dim_139, %dim_141) {alignment = 64 : i64} : memref<?x?x1xf64>
    linalg.copy ins(%alloc_26 : memref<?x?x1xf64>) outs(%alloc_142 : memref<?x?x1xf64>)
    scf.forall (%arg9) in (%28) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_137]
      %subview = memref.subview %alloc_21[0, 0, %52] [%dim_135, %dim_136, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_142[0, 0, 0] [%dim_135, %dim_136, 1] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x1xf64, strided<[?, 1, 1]>>
      linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%subview : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>) outs(%subview_208 : memref<?x?x1xf64, strided<[?, 1, 1]>>) {
      ^bb0(%in: f64, %out: f64):
        %54 = arith.addf %in, %out : f64
        linalg.yield %54 : f64
      }
      %subview_209 = memref.subview %alloc_142[0, 0, 0] [%dim_135, %dim_136, 1] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x1xf64, strided<[?, 1, 1]>>
      linalg.copy ins(%subview_208 : memref<?x?x1xf64, strided<[?, 1, 1]>>) outs(%subview_209 : memref<?x?x1xf64, strided<[?, 1, 1]>>)
    }
    %dim_143 = memref.dim %alloc_142, %c0 : memref<?x?x1xf64>
    %dim_144 = memref.dim %alloc_142, %c1 : memref<?x?x1xf64>
    scf.forall (%arg9) in (1) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map5(%52)
      %subview = memref.subview %alloc_142[0, 0, %52] [%dim_143, %dim_144, %53] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_25[0, 0, %52] [%dim_143, %dim_144, %53] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>) outs(%subview_208 : memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>) {
      ^bb0(%in: f64, %out: f64):
        %54 = arith.sitofp %1 : i64 to f64
        %55 = arith.divf %in, %54 : f64
        linalg.yield %55 : f64
      }
      %subview_209 = memref.subview %alloc_25[0, 0, %52] [%dim_143, %dim_144, %53] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>
      linalg.copy ins(%subview_208 : memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>)
    }
    %dim_145 = memref.dim %alloc_21, %c0 : memref<?x?x?xf64>
    %dim_146 = memref.dim %alloc_21, %c1 : memref<?x?x?xf64>
    %dim_147 = memref.dim %alloc_21, %c2 : memref<?x?x?xf64>
    %29 = affine.apply #map()[%dim_147]
    %alloc_148 = memref.alloc(%dim, %dim_7, %dim_17) {alignment = 64 : i64} : memref<?x?x?xf64>
    scf.forall (%arg9) in (%29) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_147]
      %subview = memref.subview %alloc_21[0, 0, %52] [%dim_145, %dim_146, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_25[0, 0, 0] [%dim_145, %dim_146, 1] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x1xf64, strided<[?, 1, 1]>>
      %subview_209 = memref.subview %alloc_148[0, 0, %52] [%dim_145, %dim_146, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview, %subview_208 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>, memref<?x?x1xf64, strided<[?, 1, 1]>>) outs(%subview_209 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f64, %in_211: f64, %out: f64):
        %54 = arith.subf %in, %in_211 : f64
        linalg.yield %54 : f64
      }
      %subview_210 = memref.subview %alloc_148[0, 0, %52] [%dim_145, %dim_146, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>) outs(%subview_210 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>)
    }
    %dim_149 = memref.dim %alloc_148, %c0 : memref<?x?x?xf64>
    %dim_150 = memref.dim %alloc_148, %c1 : memref<?x?x?xf64>
    %dim_151 = memref.dim %alloc_148, %c2 : memref<?x?x?xf64>
    %30 = affine.apply #map()[%dim_151]
    scf.forall (%arg9) in (%30) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_151]
      %subview = memref.subview %alloc_148[0, 0, %52] [%dim_149, %dim_150, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_148[0, 0, %52] [%dim_149, %dim_150, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      %subview_209 = memref.subview %alloc_21[0, 0, %52] [%dim_149, %dim_150, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview, %subview_208 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>, memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f64, %in_211: f64, %out: f64):
        %54 = arith.mulf %in, %in_211 : f64
        linalg.yield %54 : f64
      }
      %subview_210 = memref.subview %alloc_21[0, 0, %52] [%dim_149, %dim_150, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>) outs(%subview_210 : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>)
    }
    %dim_152 = memref.dim %alloc_21, %c0 : memref<?x?x?xf64>
    %dim_153 = memref.dim %alloc_21, %c1 : memref<?x?x?xf64>
    %dim_154 = memref.dim %alloc_21, %c2 : memref<?x?x?xf64>
    %31 = affine.apply #map()[%dim_154]
    scf.forall (%arg9) in (%31) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_154]
      %subview = memref.subview %alloc_21[0, 0, %52] [%dim_152, %dim_153, %53] [1, 1, 1] : memref<?x?x?xf64> to memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_26[0, 0, 0] [%dim_152, %dim_153, 1] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x1xf64, strided<[?, 1, 1]>>
      linalg.generic {indexing_maps = [#map3, #map4], iterator_types = ["parallel", "parallel", "reduction"]} ins(%subview : memref<?x?x?xf64, strided<[?, ?, 1], offset: ?>>) outs(%subview_208 : memref<?x?x1xf64, strided<[?, 1, 1]>>) {
      ^bb0(%in: f64, %out: f64):
        %54 = arith.addf %in, %out : f64
        linalg.yield %54 : f64
      }
      %subview_209 = memref.subview %alloc_26[0, 0, 0] [%dim_152, %dim_153, 1] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x1xf64, strided<[?, 1, 1]>>
      linalg.copy ins(%subview_208 : memref<?x?x1xf64, strided<[?, 1, 1]>>) outs(%subview_209 : memref<?x?x1xf64, strided<[?, 1, 1]>>)
    }
    %dim_155 = memref.dim %alloc_26, %c0 : memref<?x?x1xf64>
    %dim_156 = memref.dim %alloc_26, %c1 : memref<?x?x1xf64>
    scf.forall (%arg9) in (1) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map5(%52)
      %subview = memref.subview %alloc_26[0, 0, %52] [%dim_155, %dim_156, %53] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_25[0, 0, %52] [%dim_155, %dim_156, %53] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>) outs(%subview_208 : memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>) {
      ^bb0(%in: f64, %out: f64):
        %54 = arith.sitofp %1 : i64 to f64
        %55 = arith.divf %in, %54 : f64
        linalg.yield %55 : f64
      }
      %subview_209 = memref.subview %alloc_25[0, 0, %52] [%dim_155, %dim_156, %53] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>
      linalg.copy ins(%subview_208 : memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>)
    }
    %dim_157 = memref.dim %alloc_25, %c0 : memref<?x?x1xf64>
    %dim_158 = memref.dim %alloc_25, %c1 : memref<?x?x1xf64>
    scf.forall (%arg9) in (1) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map5(%52)
      %subview = memref.subview %alloc_25[0, 0, %52] [%dim_157, %dim_158, %53] [1, 1, 1] : memref<?x?x1xf64> to memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>
      %subview_208 = memref.subview %alloc[0, 0, %52] [%dim_157, %dim_158, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?x?xf64, strided<[?, 1, 1], offset: ?>>) outs(%subview_208 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) {
      ^bb0(%in: f64, %out: f32):
        %54 = arith.truncf %in : f64 to f32
        linalg.yield %54 : f32
      }
      %subview_209 = memref.subview %alloc[0, 0, %52] [%dim_157, %dim_158, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      linalg.copy ins(%subview_208 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>)
    }
    %dim_159 = memref.dim %alloc_125, %c0 : memref<?x?x?xf32>
    %dim_160 = memref.dim %alloc_125, %c1 : memref<?x?x?xf32>
    %dim_161 = memref.dim %alloc_125, %c2 : memref<?x?x?xf32>
    %32 = affine.apply #map()[%dim_161]
    %alloc_162 = memref.alloc(%dim, %dim_7, %dim_17) {alignment = 64 : i64} : memref<?x?x?xf32>
    scf.forall (%arg9) in (%32) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_161]
      %subview = memref.subview %alloc_125[0, 0, %52] [%dim_159, %dim_160, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_131[0, 0, 0] [%dim_159, %dim_160, 1] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x1xf32, strided<[?, 1, 1]>>
      %subview_209 = memref.subview %alloc_162[0, 0, %52] [%dim_159, %dim_160, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview, %subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?x?x1xf32, strided<[?, 1, 1]>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_211: f32, %out: f32):
        %54 = arith.subf %in, %in_211 : f32
        linalg.yield %54 : f32
      }
      %subview_210 = memref.subview %alloc_162[0, 0, %52] [%dim_159, %dim_160, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_210 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    %dim_163 = memref.dim %alloc, %c0 : memref<?x?x1xf32>
    %dim_164 = memref.dim %alloc, %c1 : memref<?x?x1xf32>
    %alloc_165 = memref.alloc(%dim, %dim_7) {alignment = 64 : i64} : memref<?x?x1xf32>
    scf.forall (%arg9) in (1) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map5(%52)
      %subview = memref.subview %alloc[0, 0, %52] [%dim_163, %dim_164, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_165[0, 0, %52] [%dim_163, %dim_164, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) outs(%subview_208 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %54 = arith.truncf %cst_4 : f64 to f32
        %55 = arith.addf %in, %54 : f32
        linalg.yield %55 : f32
      }
      %subview_209 = memref.subview %alloc_165[0, 0, %52] [%dim_163, %dim_164, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      linalg.copy ins(%subview_208 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>)
    }
    %dim_166 = memref.dim %alloc_165, %c0 : memref<?x?x1xf32>
    %dim_167 = memref.dim %alloc_165, %c1 : memref<?x?x1xf32>
    scf.forall (%arg9) in (1) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map5(%52)
      %subview = memref.subview %alloc_165[0, 0, %52] [%dim_166, %dim_167, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      %subview_208 = memref.subview %alloc[0, 0, %52] [%dim_166, %dim_167, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) outs(%subview_208 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %54 = math.sqrt %in : f32
        linalg.yield %54 : f32
      }
      %subview_209 = memref.subview %alloc[0, 0, %52] [%dim_166, %dim_167, %53] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>
      linalg.copy ins(%subview_208 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, 1, 1], offset: ?>>)
    }
    %dim_168 = memref.dim %alloc_162, %c0 : memref<?x?x?xf32>
    %dim_169 = memref.dim %alloc_162, %c1 : memref<?x?x?xf32>
    %dim_170 = memref.dim %alloc_162, %c2 : memref<?x?x?xf32>
    %33 = affine.apply #map()[%dim_170]
    scf.forall (%arg9) in (%33) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_170]
      %subview = memref.subview %alloc_162[0, 0, %52] [%dim_168, %dim_169, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc[0, 0, 0] [%dim_168, %dim_169, 1] [1, 1, 1] : memref<?x?x1xf32> to memref<?x?x1xf32, strided<[?, 1, 1]>>
      %subview_209 = memref.subview %alloc_56[0, 0, %52] [%dim_168, %dim_169, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map4, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview, %subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?x?x1xf32, strided<[?, 1, 1]>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_211: f32, %out: f32):
        %54 = arith.divf %in, %in_211 : f32
        linalg.yield %54 : f32
      }
      %subview_210 = memref.subview %alloc_56[0, 0, %52] [%dim_168, %dim_169, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_210 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    %dim_171 = memref.dim %arg6, %c0 : memref<?xf32>
    %34 = arith.cmpi eq, %dim_17, %dim_171 : index
    cf.assert %34, "mismatched size for broadcast"
    %dim_172 = memref.dim %alloc_56, %c0 : memref<?x?x?xf32>
    %dim_173 = memref.dim %alloc_56, %c1 : memref<?x?x?xf32>
    %dim_174 = memref.dim %alloc_56, %c2 : memref<?x?x?xf32>
    %35 = affine.apply #map()[%dim_174]
    %alloc_175 = memref.alloc(%dim, %dim_7, %dim_17) {alignment = 64 : i64} : memref<?x?x?xf32>
    scf.forall (%arg9) in (%35) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_174]
      %subview = memref.subview %alloc_56[0, 0, %52] [%dim_172, %dim_173, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %arg6[%52] [%53] [1] : memref<?xf32> to memref<?xf32, strided<[1], offset: ?>>
      %subview_209 = memref.subview %alloc_175[0, 0, %52] [%dim_172, %dim_173, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview, %subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?xf32, strided<[1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_211: f32, %out: f32):
        %54 = arith.mulf %in, %in_211 : f32
        linalg.yield %54 : f32
      }
      %subview_210 = memref.subview %alloc_175[0, 0, %52] [%dim_172, %dim_173, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_210 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    %dim_176 = memref.dim %arg7, %c0 : memref<?xf32>
    %36 = arith.cmpi eq, %dim_17, %dim_176 : index
    cf.assert %36, "mismatched size for broadcast"
    %dim_177 = memref.dim %alloc_175, %c0 : memref<?x?x?xf32>
    %dim_178 = memref.dim %alloc_175, %c1 : memref<?x?x?xf32>
    %dim_179 = memref.dim %alloc_175, %c2 : memref<?x?x?xf32>
    %37 = affine.apply #map()[%dim_179]
    scf.forall (%arg9) in (%37) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_179]
      %subview = memref.subview %alloc_175[0, 0, %52] [%dim_177, %dim_178, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %arg7[%52] [%53] [1] : memref<?xf32> to memref<?xf32, strided<[1], offset: ?>>
      %subview_209 = memref.subview %alloc_56[0, 0, %52] [%dim_177, %dim_178, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map6, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview, %subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?xf32, strided<[1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_211: f32, %out: f32):
        %54 = arith.addf %in, %in_211 : f32
        linalg.yield %54 : f32
      }
      %subview_210 = memref.subview %alloc_56[0, 0, %52] [%dim_177, %dim_178, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_210 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    %dim_180 = memref.dim %arg2, %c0 : memref<?x?xf32>
    %dim_181 = memref.dim %arg2, %c1 : memref<?x?xf32>
    %38 = arith.index_cast %dim_180 : index to i64
    %39 = arith.cmpi eq, %1, %38 : i64
    cf.assert %39, "mismatching contracting dimension"
    %40 = arith.index_cast %dim : index to i64
    %41 = arith.cmpi sge, %40, %c0_i64 : i64
    cf.assert %41, "negative values not allowed in new dimensions"
    %alloc_182 = memref.alloc(%dim, %dim_180, %dim_181) {alignment = 64 : i64} : memref<?x?x?xf32>
    %dim_183 = memref.dim %arg2, %c0 : memref<?x?xf32>
    %dim_184 = memref.dim %arg2, %c1 : memref<?x?xf32>
    %dim_185 = memref.dim %alloc_182, %c0 : memref<?x?x?xf32>
    %42 = affine.apply #map()[%dim_184]
    scf.forall (%arg9) in (%42) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_184]
      %subview = memref.subview %arg2[0, %52] [%dim_183, %53] [1, 1] : memref<?x?xf32> to memref<?x?xf32, strided<[?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_182[0, 0, %52] [%dim_185, %dim_183, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map9, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?xf32, strided<[?, 1], offset: ?>>) outs(%subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      }
      %subview_209 = memref.subview %alloc_182[0, 0, %52] [%dim_185, %dim_183, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    %alloc_186 = memref.alloc(%dim, %dim_7, %dim_181) {alignment = 64 : i64} : memref<?x?x?xf32>
    %alloc_187 = memref.alloc(%dim, %dim_7, %dim_181) {alignment = 64 : i64} : memref<?x?x?xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_187 : memref<?x?x?xf32>)
    %dim_188 = memref.dim %alloc_56, %c0 : memref<?x?x?xf32>
    %dim_189 = memref.dim %alloc_56, %c1 : memref<?x?x?xf32>
    %dim_190 = memref.dim %alloc_56, %c2 : memref<?x?x?xf32>
    %dim_191 = memref.dim %alloc_182, %c2 : memref<?x?x?xf32>
    %43 = affine.apply #map()[%dim_190]
    scf.forall (%arg9) in (%43) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_190]
      %subview = memref.subview %alloc_56[0, 0, %52] [%dim_188, %dim_189, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_182[0, %52, 0] [%dim_188, %53, %dim_191] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_209 = memref.subview %alloc_187[0, 0, 0] [%dim_188, %dim_189, %dim_191] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1]>>
      linalg.batch_matmul ins(%subview, %subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1]>>)
      %subview_210 = memref.subview %alloc_187[0, 0, 0] [%dim_188, %dim_189, %dim_191] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1]>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1]>>) outs(%subview_210 : memref<?x?x?xf32, strided<[?, ?, 1]>>)
    }
    %dim_192 = memref.dim %alloc_187, %c0 : memref<?x?x?xf32>
    %dim_193 = memref.dim %alloc_187, %c1 : memref<?x?x?xf32>
    %dim_194 = memref.dim %alloc_187, %c2 : memref<?x?x?xf32>
    %44 = affine.apply #map()[%dim_194]
    scf.forall (%arg9) in (%44) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_194]
      %subview = memref.subview %alloc_187[0, 0, %52] [%dim_192, %dim_193, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_186[0, 0, %52] [%dim_192, %dim_193, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %54 = arith.divf %in, %cst_6 : f32
        %55 = math.erf %54 : f32
        %56 = arith.addf %55, %cst_2 : f32
        %57 = arith.mulf %56, %cst_3 : f32
        %58 = arith.mulf %in, %57 : f32
        linalg.yield %58 : f32
      }
      %subview_209 = memref.subview %alloc_186[0, 0, %52] [%dim_192, %dim_193, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    %dim_195 = memref.dim %arg3, %c0 : memref<?x?xf32>
    %dim_196 = memref.dim %arg3, %c1 : memref<?x?xf32>
    %45 = arith.index_cast %dim_181 : index to i64
    %46 = arith.index_cast %dim_195 : index to i64
    %47 = arith.cmpi eq, %45, %46 : i64
    cf.assert %47, "mismatching contracting dimension"
    cf.assert %41, "negative values not allowed in new dimensions"
    %alloc_197 = memref.alloc(%dim, %dim_195, %dim_196) {alignment = 64 : i64} : memref<?x?x?xf32>
    %dim_198 = memref.dim %arg3, %c0 : memref<?x?xf32>
    %dim_199 = memref.dim %arg3, %c1 : memref<?x?xf32>
    %dim_200 = memref.dim %alloc_197, %c0 : memref<?x?x?xf32>
    %48 = affine.apply #map()[%dim_199]
    scf.forall (%arg9) in (%48) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_199]
      %subview = memref.subview %arg3[0, %52] [%dim_198, %53] [1, 1] : memref<?x?xf32> to memref<?x?xf32, strided<[?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_197[0, 0, %52] [%dim_200, %dim_198, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map9, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview : memref<?x?xf32, strided<[?, 1], offset: ?>>) outs(%subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      }
      %subview_209 = memref.subview %alloc_197[0, 0, %52] [%dim_200, %dim_198, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    linalg.fill ins(%cst : f32) outs(%arg8 : memref<?x?x?xf32>)
    %dim_201 = memref.dim %alloc_186, %c0 : memref<?x?x?xf32>
    %dim_202 = memref.dim %alloc_186, %c1 : memref<?x?x?xf32>
    %dim_203 = memref.dim %alloc_186, %c2 : memref<?x?x?xf32>
    %dim_204 = memref.dim %alloc_197, %c2 : memref<?x?x?xf32>
    %49 = affine.apply #map()[%dim_203]
    scf.forall (%arg9) in (%49) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_203]
      %subview = memref.subview %alloc_186[0, 0, %52] [%dim_201, %dim_202, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %alloc_197[0, %52, 0] [%dim_201, %53, %dim_204] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_209 = memref.subview %arg8[0, 0, 0] [%dim_201, %dim_202, %dim_204] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1]>>
      linalg.batch_matmul ins(%subview, %subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1]>>)
      %subview_210 = memref.subview %arg8[0, 0, 0] [%dim_201, %dim_202, %dim_204] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1]>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1]>>) outs(%subview_210 : memref<?x?x?xf32, strided<[?, ?, 1]>>)
    }
    %50 = arith.cmpi eq, %dim_17, %dim_196 : index
    cf.assert %50, "mismatched size for broadcast"
    %dim_205 = memref.dim %alloc_125, %c0 : memref<?x?x?xf32>
    %dim_206 = memref.dim %alloc_125, %c1 : memref<?x?x?xf32>
    %dim_207 = memref.dim %alloc_125, %c2 : memref<?x?x?xf32>
    %51 = affine.apply #map()[%dim_207]
    scf.forall (%arg9) in (%51) {
      %52 = affine.apply #map1(%arg9)
      %53 = affine.min #map2(%52)[%dim_207]
      %subview = memref.subview %alloc_125[0, 0, %52] [%dim_205, %dim_206, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_208 = memref.subview %arg8[0, 0, %52] [%dim_205, %dim_206, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      %subview_209 = memref.subview %alloc_56[0, 0, %52] [%dim_205, %dim_206, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map3, #map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview, %subview_208 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>, memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_211: f32, %out: f32):
        %54 = arith.addf %in, %in_211 : f32
        linalg.yield %54 : f32
      }
      %subview_210 = memref.subview %alloc_56[0, 0, %52] [%dim_205, %dim_206, %53] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>
      linalg.copy ins(%subview_209 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>) outs(%subview_210 : memref<?x?x?xf32, strided<[?, ?, 1], offset: ?>>)
    }
    return
  }
}
