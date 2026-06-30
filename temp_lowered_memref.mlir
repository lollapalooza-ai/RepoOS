#map = affine_map<(d0) -> (d0 * 32)>
#map1 = affine_map<(d0) -> (-d0 + 2, 32)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1, 0)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map5 = affine_map<(d0, d1, d2) -> (d2)>
#map6 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map7 = affine_map<(d0) -> (-d0 + 4, 32)>
#map8 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map9 = affine_map<(d0) -> (-d0 + 1, 32)>
#map10 = affine_map<(d0, d1, d2, d3) -> (0, 0, d2, d3)>
#map11 = affine_map<(d0, d1, d2, d3) -> ()>
#map12 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
#map13 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, 0)>
module attributes {transform.with_named_sequence} {
  memref.global "private" constant @__constant_xf32 : memref<f32> = dense<0xFF800000> {alignment = 64 : i64}
  func.func @main(%arg0: memref<128xf32>, %arg1: memref<128xf32>, %arg2: memref<2x1024x128xf32>, %arg3: memref<384x128xf32>, %arg4: memref<384xf32>, %arg5: memref<1x1x1024x1024xf32>, %arg6: memref<128x128xf32>, %arg7: memref<128xf32>, %arg8: memref<128xf32>, %arg9: memref<128xf32>, %arg10: memref<512x128xf32>, %arg11: memref<512xf32>, %arg12: memref<128x512xf32>, %arg13: memref<128xf32>, %arg14: memref<128xf32>, %arg15: memref<128xf32>, %arg16: memref<384x128xf32>, %arg17: memref<384xf32>, %arg18: memref<1x1x1024x1024xf32>, %arg19: memref<128x128xf32>, %arg20: memref<128xf32>, %arg21: memref<128xf32>, %arg22: memref<128xf32>, %arg23: memref<512x128xf32>, %arg24: memref<512xf32>, %arg25: memref<128x512xf32>, %arg26: memref<128xf32>, %arg27: memref<2x1024x128xf32>) attributes {llvm.emit_c_interface} {
    %c0_i64 = arith.constant 0 : i64
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 0xFF800000 : f32
    %cst_1 = arith.constant 1.000000e+00 : f32
    %cst_2 = arith.constant 5.000000e-01 : f32
    %0 = memref.get_global @__constant_xf32 : memref<f32>
    %cst_3 = arith.constant 0.17677669529663687 : f64
    %cst_4 = arith.constant 1.000000e-05 : f64
    %cst_5 = arith.constant 1.280000e+02 : f32
    %cst_6 = arith.constant 1.41421354 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    %alloc_7 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_7 : memref<2x1024x1xf32>)
    %alloc_8 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    linalg.copy ins(%alloc_7 : memref<2x1024x1xf32>) outs(%alloc_8 : memref<2x1024x1xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %arg2[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_8[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map3], iterator_types = ["parallel", "parallel", "reduction"]} ins(%subview_128 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.addf %in, %out : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_8[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_8[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      %subview_129 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.divf %in, %cst_5 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    %collapse_shape = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x1024x1xf32> into memref<2x1024xf32>
    %alloc_9 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_9 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %collapse_shape[%1, %2] [%3, 32] [1, 1] : memref<2x1024xf32> to memref<?x32xf32, strided<[1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_9[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map4, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32xf32, strided<[1024, 1], offset: ?>>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      }
      %subview_130 = memref.subview %alloc_9[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_10 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_10 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %arg2[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_9[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_10[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %4 = arith.subf %in, %in_132 : f32
        linalg.yield %4 : f32
      }
      %subview_131 = memref.subview %alloc_10[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_11 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_11 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_10[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_10[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_11[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %4 = arith.mulf %in, %in_132 : f32
        linalg.yield %4 : f32
      }
      %subview_131 = memref.subview %alloc_11[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_12 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    linalg.copy ins(%alloc_7 : memref<2x1024x1xf32>) outs(%alloc_12 : memref<2x1024x1xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_11[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_12[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map3], iterator_types = ["parallel", "parallel", "reduction"]} ins(%subview_128 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.addf %in, %out : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_12[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_12[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      %subview_129 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.divf %in, %cst_5 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    %alloc_13 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_13[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.truncf %cst_4 : f64 to f32
        %5 = arith.addf %in, %4 : f32
        linalg.yield %5 : f32
      }
      %subview_130 = memref.subview %alloc_13[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_13[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      %subview_129 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = math.rsqrt %in : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    %collapse_shape_14 = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x1024x1xf32> into memref<2x1024xf32>
    %alloc_15 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_15 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %collapse_shape_14[%1, %2] [%3, 32] [1, 1] : memref<2x1024xf32> to memref<?x32xf32, strided<[1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_15[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map4, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32xf32, strided<[1024, 1], offset: ?>>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      }
      %subview_130 = memref.subview %alloc_15[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_16 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_16 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_10[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_15[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_16[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %4 = arith.mulf %in, %in_132 : f32
        linalg.yield %4 : f32
      }
      %subview_131 = memref.subview %alloc_16[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_17 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_17 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_16[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_17[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map5, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %arg0 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<128xf32>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_131: f32, %out: f32):
        %4 = arith.mulf %in, %in_131 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_17[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_18 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_18 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_17[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_18[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map5, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %arg1 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<128xf32>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_131: f32, %out: f32):
        %4 = arith.addf %in, %in_131 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_18[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_19 = memref.alloc() {alignment = 64 : i64} : memref<128x384xf32>
    scf.forall (%arg28, %arg29) in (4, 12) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %subview_128 = memref.subview %arg3[%2, %1] [32, 32] [1, 1] : memref<384x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_19[%1, %2] [32, 32] [1, 1] : memref<128x384xf32> to memref<32x32xf32, strided<[384, 1], offset: ?>>
      linalg.transpose ins(%subview_128 : memref<32x32xf32, strided<[128, 1], offset: ?>>) outs(%subview_129 : memref<32x32xf32, strided<[384, 1], offset: ?>>) permutation = [1, 0] 
      %subview_130 = memref.subview %alloc_19[%1, %2] [32, 32] [1, 1] : memref<128x384xf32> to memref<32x32xf32, strided<[384, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<32x32xf32, strided<[384, 1], offset: ?>>) outs(%subview_130 : memref<32x32xf32, strided<[384, 1], offset: ?>>)
    }
    %alloc_20 = memref.alloc() {alignment = 64 : i64} : memref<2x128x384xf32>
    scf.forall (%arg28, %arg29) in (1, 4) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_19[%2, 0] [32, 384] [1, 1] : memref<128x384xf32> to memref<32x384xf32, strided<[384, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_20[%1, %2, 0] [%3, 32, 384] [1, 1, 1] : memref<2x128x384xf32> to memref<?x32x384xf32, strided<[49152, 384, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map6, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<32x384xf32, strided<[384, 1], offset: ?>>) outs(%subview_129 : memref<?x32x384xf32, strided<[49152, 384, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      }
      %subview_130 = memref.subview %alloc_20[%1, %2, 0] [%3, 32, 384] [1, 1, 1] : memref<2x128x384xf32> to memref<?x32x384xf32, strided<[49152, 384, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x384xf32, strided<[49152, 384, 1], offset: ?>>) outs(%subview_130 : memref<?x32x384xf32, strided<[49152, 384, 1], offset: ?>>)
    }
    %alloc_21 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x384xf32>
    %alloc_22 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x384xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_22 : memref<2x1024x384xf32>)
    %alloc_23 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x384xf32>
    linalg.copy ins(%alloc_22 : memref<2x1024x384xf32>) outs(%alloc_23 : memref<2x1024x384xf32>)
    scf.forall (%arg28, %arg29, %arg30, %arg31) in (2, 32, 12, 4) {
      %1 = affine.apply #map(%arg29)
      %2 = affine.apply #map(%arg30)
      %3 = affine.apply #map(%arg31)
      %subview_128 = memref.subview %alloc_18[%arg28, %1, %3] [1, 32, 32] [1, 1, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_20[%arg28, %3, %2] [1, 32, 32] [1, 1, 1] : memref<2x128x384xf32> to memref<1x32x32xf32, strided<[49152, 384, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_23[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<2x1024x384xf32> to memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>
      linalg.batch_matmul ins(%subview_128, %subview_129 : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>, memref<1x32x32xf32, strided<[49152, 384, 1], offset: ?>>) outs(%subview_130 : memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>)
      %subview_131 = memref.subview %alloc_23[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<2x1024x384xf32> to memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>) outs(%subview_131 : memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_23[%1, %2, 0] [%3, 32, 384] [1, 1, 1] : memref<2x1024x384xf32> to memref<?x32x384xf32, strided<[393216, 384, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_21[%1, %2, 0] [%3, 32, 384] [1, 1, 1] : memref<2x1024x384xf32> to memref<?x32x384xf32, strided<[393216, 384, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map5, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %arg4 : memref<?x32x384xf32, strided<[393216, 384, 1], offset: ?>>, memref<384xf32>) outs(%subview_129 : memref<?x32x384xf32, strided<[393216, 384, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_131: f32, %out: f32):
        %4 = arith.addf %in, %in_131 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_21[%1, %2, 0] [%3, 32, 384] [1, 1, 1] : memref<2x1024x384xf32> to memref<?x32x384xf32, strided<[393216, 384, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x384xf32, strided<[393216, 384, 1], offset: ?>>) outs(%subview_130 : memref<?x32x384xf32, strided<[393216, 384, 1], offset: ?>>)
    }
    %subview = memref.subview %alloc_21[0, 0, 0] [2, 1024, 128] [1, 1, 1] : memref<2x1024x384xf32> to memref<2x1024x128xf32, strided<[393216, 384, 1]>>
    %subview_24 = memref.subview %alloc_21[0, 0, 128] [2, 1024, 128] [1, 1, 1] : memref<2x1024x384xf32> to memref<2x1024x128xf32, strided<[393216, 384, 1], offset: 128>>
    %subview_25 = memref.subview %alloc_21[0, 0, 256] [2, 1024, 128] [1, 1, 1] : memref<2x1024x384xf32> to memref<2x1024x128xf32, strided<[393216, 384, 1], offset: 256>>
    %expand_shape = memref.expand_shape %subview_24 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : memref<2x1024x128xf32, strided<[393216, 384, 1], offset: 128>> into memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 128>>
    %expand_shape_26 = memref.expand_shape %subview [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : memref<2x1024x128xf32, strided<[393216, 384, 1]>> into memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1]>>
    %alloc_27 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x32xf32>
    %alloc_28 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x32xf32>
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %expand_shape_26[%1, 0, %2, 0] [%3, 1024, %4, 32] [1, 1, 1, 1] : memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1]>> to memref<?x1024x?x32xf32, strided<[393216, 384, 32, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_28[%1, %2, 0, 0] [%3, %4, 1024, 32] [1, 1, 1, 1] : memref<2x4x1024x32xf32> to memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>
      linalg.transpose ins(%subview_128 : memref<?x1024x?x32xf32, strided<[393216, 384, 32, 1], offset: ?>>) outs(%subview_129 : memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>) permutation = [0, 2, 1, 3] 
      %subview_130 = memref.subview %alloc_28[%1, %2, 0, 0] [%3, %4, 1024, 32] [1, 1, 1, 1] : memref<2x4x1024x32xf32> to memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>) outs(%subview_130 : memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>)
    }
    %expand_shape_29 = memref.expand_shape %subview_25 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : memref<2x1024x128xf32, strided<[393216, 384, 1], offset: 256>> into memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 256>>
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %expand_shape_29[%1, 0, %2, 0] [%3, 1024, %4, 32] [1, 1, 1, 1] : memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 256>> to memref<?x1024x?x32xf32, strided<[393216, 384, 32, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_27[%1, %2, 0, 0] [%3, %4, 1024, 32] [1, 1, 1, 1] : memref<2x4x1024x32xf32> to memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>
      linalg.transpose ins(%subview_128 : memref<?x1024x?x32xf32, strided<[393216, 384, 32, 1], offset: ?>>) outs(%subview_129 : memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>) permutation = [0, 2, 1, 3] 
      %subview_130 = memref.subview %alloc_27[%1, %2, 0, 0] [%3, %4, 1024, 32] [1, 1, 1, 1] : memref<2x4x1024x32xf32> to memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>) outs(%subview_130 : memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>)
    }
    %alloc_30 = memref.alloc() {alignment = 64 : i64} : memref<2x4x32x1024xf32>
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %expand_shape[%1, 0, %2, 0] [%3, 1024, %4, 32] [1, 1, 1, 1] : memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 128>> to memref<?x1024x?x32xf32, strided<[393216, 384, 32, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_30[%1, %2, 0, 0] [%3, %4, 32, 1024] [1, 1, 1, 1] : memref<2x4x32x1024xf32> to memref<?x?x32x1024xf32, strided<[131072, 32768, 1024, 1], offset: ?>>
      linalg.transpose ins(%subview_128 : memref<?x1024x?x32xf32, strided<[393216, 384, 32, 1], offset: ?>>) outs(%subview_129 : memref<?x?x32x1024xf32, strided<[131072, 32768, 1024, 1], offset: ?>>) permutation = [0, 2, 3, 1] 
      %subview_130 = memref.subview %alloc_30[%1, %2, 0, 0] [%3, %4, 32, 1024] [1, 1, 1, 1] : memref<2x4x32x1024xf32> to memref<?x?x32x1024xf32, strided<[131072, 32768, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x?x32x1024xf32, strided<[131072, 32768, 1024, 1], offset: ?>>) outs(%subview_130 : memref<?x?x32x1024xf32, strided<[131072, 32768, 1024, 1], offset: ?>>)
    }
    %collapse_shape_31 = memref.collapse_shape %alloc_28 [[0, 1], [2], [3]] : memref<2x4x1024x32xf32> into memref<8x1024x32xf32>
    %collapse_shape_32 = memref.collapse_shape %alloc_30 [[0, 1], [2], [3]] : memref<2x4x32x1024xf32> into memref<8x32x1024xf32>
    %alloc_33 = memref.alloc() {alignment = 64 : i64} : memref<8x1024x1024xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_33 : memref<8x1024x1024xf32>)
    %alloc_34 = memref.alloc() {alignment = 64 : i64} : memref<8x1024x1024xf32>
    linalg.copy ins(%alloc_33 : memref<8x1024x1024xf32>) outs(%alloc_34 : memref<8x1024x1024xf32>)
    scf.forall (%arg28, %arg29, %arg30, %arg31) in (8, 32, 32, 1) {
      %1 = affine.apply #map(%arg29)
      %2 = affine.apply #map(%arg30)
      %3 = affine.apply #map(%arg31)
      %subview_128 = memref.subview %collapse_shape_31[%arg28, %1, %3] [1, 32, 32] [1, 1, 1] : memref<8x1024x32xf32> to memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
      %subview_129 = memref.subview %collapse_shape_32[%arg28, %3, %2] [1, 32, 32] [1, 1, 1] : memref<8x32x1024xf32> to memref<1x32x32xf32, strided<[32768, 1024, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_34[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<8x1024x1024xf32> to memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
      linalg.batch_matmul ins(%subview_128, %subview_129 : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>, memref<1x32x32xf32, strided<[32768, 1024, 1], offset: ?>>) outs(%subview_130 : memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>)
      %subview_131 = memref.subview %alloc_34[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<8x1024x1024xf32> to memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>) outs(%subview_131 : memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>)
    }
    %expand_shape_35 = memref.expand_shape %alloc_34 [[0, 1], [2], [3]] output_shape [2, 4, 1024, 1024] : memref<8x1024x1024xf32> into memref<2x4x1024x1024xf32>
    %alloc_36 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x1024xf32>
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %expand_shape_35[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_36[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map8, #map8], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_129 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %5 = arith.truncf %cst_3 : f64 to f32
        %6 = arith.mulf %in, %5 : f32
        linalg.yield %6 : f32
      }
      %subview_130 = memref.subview %alloc_36[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_130 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>)
    }
    %alloc_37 = memref.alloc() {alignment = 64 : i64} : memref<1x1x1024x1024xi1>
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map9(%1)
      %4 = affine.min #map9(%2)
      %subview_128 = memref.subview %arg5[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<1x1x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[1048576, 1048576, 1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_37[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<1x1x1024x1024xi1> to memref<?x?x1024x1024xi1, strided<[1048576, 1048576, 1024, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map8, #map8], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x?x1024x1024xf32, strided<[1048576, 1048576, 1024, 1], offset: ?>>) outs(%subview_129 : memref<?x?x1024x1024xi1, strided<[1048576, 1048576, 1024, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: i1):
        %5 = arith.cmpf oeq, %in, %cst : f32
        linalg.yield %5 : i1
      }
      %subview_130 = memref.subview %alloc_37[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<1x1x1024x1024xi1> to memref<?x?x1024x1024xi1, strided<[1048576, 1048576, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x?x1024x1024xi1, strided<[1048576, 1048576, 1024, 1], offset: ?>>) outs(%subview_130 : memref<?x?x1024x1024xi1, strided<[1048576, 1048576, 1024, 1], offset: ?>>)
    }
    %alloc_38 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x1024xf32>
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %alloc_36[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_38[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map10, #map11, #map8, #map8], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%alloc_37, %0, %subview_128 : memref<1x1x1024x1024xi1>, memref<f32>, memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_129 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) {
      ^bb0(%in: i1, %in_131: f32, %in_132: f32, %out: f32):
        %5 = arith.select %in, %in_131, %in_132 : f32
        linalg.yield %5 : f32
      }
      %subview_130 = memref.subview %alloc_38[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_130 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>)
    }
    %alloc_39 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024xi64>
    linalg.fill ins(%c0_i64 : i64) outs(%alloc_39 : memref<2x4x1024xi64>)
    %alloc_40 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024xf32>
    linalg.fill ins(%cst_0 : f32) outs(%alloc_40 : memref<2x4x1024xf32>)
    %alloc_41 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024xf32>
    linalg.copy ins(%alloc_40 : memref<2x4x1024xf32>) outs(%alloc_41 : memref<2x4x1024xf32>)
    %alloc_42 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024xi64>
    linalg.copy ins(%alloc_39 : memref<2x4x1024xi64>) outs(%alloc_42 : memref<2x4x1024xi64>)
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %alloc_38[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_41[%1, %2, 0] [%3, %4, 1024] [1, 1, 1] : memref<2x4x1024xf32> to memref<?x?x1024xf32, strided<[4096, 1024, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_42[%1, %2, 0] [%3, %4, 1024] [1, 1, 1] : memref<2x4x1024xi64> to memref<?x?x1024xi64, strided<[4096, 1024, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map8, #map12, #map12], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%subview_128 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_129, %subview_130 : memref<?x?x1024xf32, strided<[4096, 1024, 1], offset: ?>>, memref<?x?x1024xi64, strided<[4096, 1024, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32, %out_133: i64):
        %5 = linalg.index 3 : index
        %6 = arith.index_cast %5 : index to i64
        %7 = arith.maximumf %in, %out : f32
        %8 = arith.cmpf ogt, %in, %out : f32
        %9 = arith.select %8, %6, %out_133 : i64
        linalg.yield %7, %9 : f32, i64
      }
      %subview_131 = memref.subview %alloc_41[%1, %2, 0] [%3, %4, 1024] [1, 1, 1] : memref<2x4x1024xf32> to memref<?x?x1024xf32, strided<[4096, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x?x1024xf32, strided<[4096, 1024, 1], offset: ?>>) outs(%subview_131 : memref<?x?x1024xf32, strided<[4096, 1024, 1], offset: ?>>)
      %subview_132 = memref.subview %alloc_42[%1, %2, 0] [%3, %4, 1024] [1, 1, 1] : memref<2x4x1024xi64> to memref<?x?x1024xi64, strided<[4096, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x?x1024xi64, strided<[4096, 1024, 1], offset: ?>>) outs(%subview_132 : memref<?x?x1024xi64, strided<[4096, 1024, 1], offset: ?>>)
    }
    %expand_shape_43 = memref.expand_shape %alloc_41 [[0], [1], [2, 3]] output_shape [2, 4, 1024, 1] : memref<2x4x1024xf32> into memref<2x4x1024x1xf32>
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %alloc_38[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      %subview_129 = memref.subview %expand_shape_43[%1, %2, 0, 0] [%3, %4, 1024, 1] [1, 1, 1, 1] : memref<2x4x1024x1xf32> to memref<?x?x1024x1xf32, strided<[4096, 1024, 1, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_36[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map8, #map13, #map8], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>, memref<?x?x1024x1xf32, strided<[4096, 1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %5 = arith.subf %in, %in_132 : f32
        linalg.yield %5 : f32
      }
      %subview_131 = memref.subview %alloc_36[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_131 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>)
    }
    %alloc_44 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x1024xf32>
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %alloc_36[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_44[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map8, #map8], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_129 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %5 = math.exp %in : f32
        linalg.yield %5 : f32
      }
      %subview_130 = memref.subview %alloc_44[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_130 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>)
    }
    %alloc_45 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x1xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_45 : memref<2x4x1024x1xf32>)
    %alloc_46 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x1xf32>
    linalg.copy ins(%alloc_45 : memref<2x4x1024x1xf32>) outs(%alloc_46 : memref<2x4x1024x1xf32>)
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %alloc_44[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_46[%1, %2, 0, 0] [%3, %4, 1024, 1] [1, 1, 1, 1] : memref<2x4x1024x1xf32> to memref<?x?x1024x1xf32, strided<[4096, 1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map8, #map13], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%subview_128 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_129 : memref<?x?x1024x1xf32, strided<[4096, 1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %5 = arith.addf %in, %out : f32
        linalg.yield %5 : f32
      }
      %subview_130 = memref.subview %alloc_46[%1, %2, 0, 0] [%3, %4, 1024, 1] [1, 1, 1, 1] : memref<2x4x1024x1xf32> to memref<?x?x1024x1xf32, strided<[4096, 1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x?x1024x1xf32, strided<[4096, 1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x?x1024x1xf32, strided<[4096, 1024, 1, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %alloc_44[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_46[%1, %2, 0, 0] [%3, %4, 1024, 1] [1, 1, 1, 1] : memref<2x4x1024x1xf32> to memref<?x?x1024x1xf32, strided<[4096, 1024, 1, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_36[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map8, #map13, #map8], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>, memref<?x?x1024x1xf32, strided<[4096, 1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %5 = arith.divf %in, %in_132 : f32
        linalg.yield %5 : f32
      }
      %subview_131 = memref.subview %alloc_36[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_131 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>)
    }
    %collapse_shape_47 = memref.collapse_shape %alloc_36 [[0, 1], [2], [3]] : memref<2x4x1024x1024xf32> into memref<8x1024x1024xf32>
    %collapse_shape_48 = memref.collapse_shape %alloc_27 [[0, 1], [2], [3]] : memref<2x4x1024x32xf32> into memref<8x1024x32xf32>
    %alloc_49 = memref.alloc() {alignment = 64 : i64} : memref<8x1024x32xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_49 : memref<8x1024x32xf32>)
    %alloc_50 = memref.alloc() {alignment = 64 : i64} : memref<8x1024x32xf32>
    linalg.copy ins(%alloc_49 : memref<8x1024x32xf32>) outs(%alloc_50 : memref<8x1024x32xf32>)
    scf.forall (%arg28, %arg29, %arg30, %arg31) in (8, 32, 1, 32) {
      %1 = affine.apply #map(%arg29)
      %2 = affine.apply #map(%arg30)
      %3 = affine.apply #map(%arg31)
      %subview_128 = memref.subview %collapse_shape_47[%arg28, %1, %3] [1, 32, 32] [1, 1, 1] : memref<8x1024x1024xf32> to memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
      %subview_129 = memref.subview %collapse_shape_48[%arg28, %3, %2] [1, 32, 32] [1, 1, 1] : memref<8x1024x32xf32> to memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_50[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<8x1024x32xf32> to memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
      linalg.batch_matmul ins(%subview_128, %subview_129 : memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>, memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>) outs(%subview_130 : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>)
      %subview_131 = memref.subview %alloc_50[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<8x1024x32xf32> to memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>) outs(%subview_131 : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>)
    }
    %expand_shape_51 = memref.expand_shape %alloc_50 [[0, 1], [2], [3]] output_shape [2, 4, 1024, 32] : memref<8x1024x32xf32> into memref<2x4x1024x32xf32>
    %alloc_52 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x4x32xf32>
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %expand_shape_51[%1, 0, %2, 0] [%3, 4, 32, 32] [1, 1, 1, 1] : memref<2x4x1024x32xf32> to memref<?x4x32x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_52[%1, %2, 0, 0] [%3, 32, 4, 32] [1, 1, 1, 1] : memref<2x1024x4x32xf32> to memref<?x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>
      linalg.transpose ins(%subview_128 : memref<?x4x32x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>) outs(%subview_129 : memref<?x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>) permutation = [0, 2, 1, 3] 
      %subview_130 = memref.subview %alloc_52[%1, %2, 0, 0] [%3, 32, 4, 32] [1, 1, 1, 1] : memref<2x1024x4x32xf32> to memref<?x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>) outs(%subview_130 : memref<?x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>)
    }
    %collapse_shape_53 = memref.collapse_shape %alloc_52 [[0], [1], [2, 3]] : memref<2x1024x4x32xf32> into memref<2x1024x128xf32>
    %alloc_54 = memref.alloc() {alignment = 64 : i64} : memref<128x128xf32>
    scf.forall (%arg28, %arg29) in (4, 4) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %subview_128 = memref.subview %arg6[%2, %1] [32, 32] [1, 1] : memref<128x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_54[%1, %2] [32, 32] [1, 1] : memref<128x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
      linalg.transpose ins(%subview_128 : memref<32x32xf32, strided<[128, 1], offset: ?>>) outs(%subview_129 : memref<32x32xf32, strided<[128, 1], offset: ?>>) permutation = [1, 0] 
      %subview_130 = memref.subview %alloc_54[%1, %2] [32, 32] [1, 1] : memref<128x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<32x32xf32, strided<[128, 1], offset: ?>>) outs(%subview_130 : memref<32x32xf32, strided<[128, 1], offset: ?>>)
    }
    %alloc_55 = memref.alloc() {alignment = 64 : i64} : memref<2x128x128xf32>
    scf.forall (%arg28, %arg29) in (1, 4) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_54[%2, 0] [32, 128] [1, 1] : memref<128x128xf32> to memref<32x128xf32, strided<[128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_55[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x128x128xf32> to memref<?x32x128xf32, strided<[16384, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map6, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<32x128xf32, strided<[128, 1], offset: ?>>) outs(%subview_129 : memref<?x32x128xf32, strided<[16384, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      }
      %subview_130 = memref.subview %alloc_55[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x128x128xf32> to memref<?x32x128xf32, strided<[16384, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[16384, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[16384, 128, 1], offset: ?>>)
    }
    %alloc_56 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_56 : memref<2x1024x128xf32>)
    %alloc_57 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%alloc_56 : memref<2x1024x128xf32>) outs(%alloc_57 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29, %arg30, %arg31) in (2, 32, 4, 4) {
      %1 = affine.apply #map(%arg29)
      %2 = affine.apply #map(%arg30)
      %3 = affine.apply #map(%arg31)
      %subview_128 = memref.subview %collapse_shape_53[%arg28, %1, %3] [1, 32, 32] [1, 1, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_55[%arg28, %3, %2] [1, 32, 32] [1, 1, 1] : memref<2x128x128xf32> to memref<1x32x32xf32, strided<[16384, 128, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_57[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.batch_matmul ins(%subview_128, %subview_129 : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>, memref<1x32x32xf32, strided<[16384, 128, 1], offset: ?>>) outs(%subview_130 : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>)
      %subview_131 = memref.subview %alloc_57[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_58 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_58 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_57[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_58[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map5, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %arg7 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<128xf32>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_131: f32, %out: f32):
        %4 = arith.addf %in, %in_131 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_58[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_59 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_59 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %arg2[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_58[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_59[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %4 = arith.addf %in, %in_132 : f32
        linalg.yield %4 : f32
      }
      %subview_131 = memref.subview %alloc_59[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_60 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    linalg.copy ins(%alloc_7 : memref<2x1024x1xf32>) outs(%alloc_60 : memref<2x1024x1xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_59[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_60[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map3], iterator_types = ["parallel", "parallel", "reduction"]} ins(%subview_128 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.addf %in, %out : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_60[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_60[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      %subview_129 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.divf %in, %cst_5 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    %collapse_shape_61 = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x1024x1xf32> into memref<2x1024xf32>
    %alloc_62 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_62 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %collapse_shape_61[%1, %2] [%3, 32] [1, 1] : memref<2x1024xf32> to memref<?x32xf32, strided<[1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_62[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map4, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32xf32, strided<[1024, 1], offset: ?>>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      }
      %subview_130 = memref.subview %alloc_62[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_63 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_63 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_59[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_62[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_63[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %4 = arith.subf %in, %in_132 : f32
        linalg.yield %4 : f32
      }
      %subview_131 = memref.subview %alloc_63[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_64 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_64 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_63[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_63[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_64[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %4 = arith.mulf %in, %in_132 : f32
        linalg.yield %4 : f32
      }
      %subview_131 = memref.subview %alloc_64[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_65 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    linalg.copy ins(%alloc_7 : memref<2x1024x1xf32>) outs(%alloc_65 : memref<2x1024x1xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_64[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_65[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map3], iterator_types = ["parallel", "parallel", "reduction"]} ins(%subview_128 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.addf %in, %out : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_65[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_65[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      %subview_129 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.divf %in, %cst_5 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    %alloc_66 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_66[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.truncf %cst_4 : f64 to f32
        %5 = arith.addf %in, %4 : f32
        linalg.yield %5 : f32
      }
      %subview_130 = memref.subview %alloc_66[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_66[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      %subview_129 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = math.rsqrt %in : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    %collapse_shape_67 = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x1024x1xf32> into memref<2x1024xf32>
    %alloc_68 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_68 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %collapse_shape_67[%1, %2] [%3, 32] [1, 1] : memref<2x1024xf32> to memref<?x32xf32, strided<[1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_68[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map4, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32xf32, strided<[1024, 1], offset: ?>>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      }
      %subview_130 = memref.subview %alloc_68[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_69 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_69 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_63[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_68[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_69[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %4 = arith.mulf %in, %in_132 : f32
        linalg.yield %4 : f32
      }
      %subview_131 = memref.subview %alloc_69[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_70 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_70 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_69[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_70[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map5, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %arg8 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<128xf32>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_131: f32, %out: f32):
        %4 = arith.mulf %in, %in_131 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_70[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_71 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_71 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_70[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_71[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map5, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %arg9 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<128xf32>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_131: f32, %out: f32):
        %4 = arith.addf %in, %in_131 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_71[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_72 = memref.alloc() {alignment = 64 : i64} : memref<128x512xf32>
    scf.forall (%arg28, %arg29) in (4, 16) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %subview_128 = memref.subview %arg10[%2, %1] [32, 32] [1, 1] : memref<512x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_72[%1, %2] [32, 32] [1, 1] : memref<128x512xf32> to memref<32x32xf32, strided<[512, 1], offset: ?>>
      linalg.transpose ins(%subview_128 : memref<32x32xf32, strided<[128, 1], offset: ?>>) outs(%subview_129 : memref<32x32xf32, strided<[512, 1], offset: ?>>) permutation = [1, 0] 
      %subview_130 = memref.subview %alloc_72[%1, %2] [32, 32] [1, 1] : memref<128x512xf32> to memref<32x32xf32, strided<[512, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<32x32xf32, strided<[512, 1], offset: ?>>) outs(%subview_130 : memref<32x32xf32, strided<[512, 1], offset: ?>>)
    }
    %alloc_73 = memref.alloc() {alignment = 64 : i64} : memref<2x128x512xf32>
    scf.forall (%arg28, %arg29) in (1, 4) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_72[%2, 0] [32, 512] [1, 1] : memref<128x512xf32> to memref<32x512xf32, strided<[512, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_73[%1, %2, 0] [%3, 32, 512] [1, 1, 1] : memref<2x128x512xf32> to memref<?x32x512xf32, strided<[65536, 512, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map6, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<32x512xf32, strided<[512, 1], offset: ?>>) outs(%subview_129 : memref<?x32x512xf32, strided<[65536, 512, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      }
      %subview_130 = memref.subview %alloc_73[%1, %2, 0] [%3, 32, 512] [1, 1, 1] : memref<2x128x512xf32> to memref<?x32x512xf32, strided<[65536, 512, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x512xf32, strided<[65536, 512, 1], offset: ?>>) outs(%subview_130 : memref<?x32x512xf32, strided<[65536, 512, 1], offset: ?>>)
    }
    %alloc_74 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x512xf32>
    %alloc_75 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x512xf32>
    linalg.fill ins(%cst : f32) outs(%alloc_75 : memref<2x1024x512xf32>)
    %alloc_76 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x512xf32>
    linalg.copy ins(%alloc_75 : memref<2x1024x512xf32>) outs(%alloc_76 : memref<2x1024x512xf32>)
    scf.forall (%arg28, %arg29, %arg30, %arg31) in (2, 32, 16, 4) {
      %1 = affine.apply #map(%arg29)
      %2 = affine.apply #map(%arg30)
      %3 = affine.apply #map(%arg31)
      %subview_128 = memref.subview %alloc_71[%arg28, %1, %3] [1, 32, 32] [1, 1, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_73[%arg28, %3, %2] [1, 32, 32] [1, 1, 1] : memref<2x128x512xf32> to memref<1x32x32xf32, strided<[65536, 512, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_76[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<2x1024x512xf32> to memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
      linalg.batch_matmul ins(%subview_128, %subview_129 : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>, memref<1x32x32xf32, strided<[65536, 512, 1], offset: ?>>) outs(%subview_130 : memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>)
      %subview_131 = memref.subview %alloc_76[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<2x1024x512xf32> to memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>) outs(%subview_131 : memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>)
    }
    %alloc_77 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x512xf32>
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_76[%1, %2, 0] [%3, 32, 512] [1, 1, 1] : memref<2x1024x512xf32> to memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_77[%1, %2, 0] [%3, 32, 512] [1, 1, 1] : memref<2x1024x512xf32> to memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map5, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %arg11 : memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>, memref<512xf32>) outs(%subview_129 : memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_131: f32, %out: f32):
        %4 = arith.addf %in, %in_131 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_77[%1, %2, 0] [%3, 32, 512] [1, 1, 1] : memref<2x1024x512xf32> to memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>) outs(%subview_130 : memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_77[%1, %2, 0] [%3, 32, 512] [1, 1, 1] : memref<2x1024x512xf32> to memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_74[%1, %2, 0] [%3, 32, 512] [1, 1, 1] : memref<2x1024x512xf32> to memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>) outs(%subview_129 : memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.divf %in, %cst_6 : f32
        %5 = math.erf %4 : f32
        %6 = arith.addf %5, %cst_1 : f32
        %7 = arith.mulf %6, %cst_2 : f32
        %8 = arith.mulf %in, %7 : f32
        linalg.yield %8 : f32
      }
      %subview_130 = memref.subview %alloc_74[%1, %2, 0] [%3, 32, 512] [1, 1, 1] : memref<2x1024x512xf32> to memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>) outs(%subview_130 : memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>)
    }
    %alloc_78 = memref.alloc() {alignment = 64 : i64} : memref<512x128xf32>
    scf.forall (%arg28, %arg29) in (16, 4) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %subview_128 = memref.subview %arg12[%2, %1] [32, 32] [1, 1] : memref<128x512xf32> to memref<32x32xf32, strided<[512, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_78[%1, %2] [32, 32] [1, 1] : memref<512x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
      linalg.transpose ins(%subview_128 : memref<32x32xf32, strided<[512, 1], offset: ?>>) outs(%subview_129 : memref<32x32xf32, strided<[128, 1], offset: ?>>) permutation = [1, 0] 
      %subview_130 = memref.subview %alloc_78[%1, %2] [32, 32] [1, 1] : memref<512x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<32x32xf32, strided<[128, 1], offset: ?>>) outs(%subview_130 : memref<32x32xf32, strided<[128, 1], offset: ?>>)
    }
    %alloc_79 = memref.alloc() {alignment = 64 : i64} : memref<2x512x128xf32>
    scf.forall (%arg28, %arg29) in (1, 16) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_78[%2, 0] [32, 128] [1, 1] : memref<512x128xf32> to memref<32x128xf32, strided<[128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_79[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x512x128xf32> to memref<?x32x128xf32, strided<[65536, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map6, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<32x128xf32, strided<[128, 1], offset: ?>>) outs(%subview_129 : memref<?x32x128xf32, strided<[65536, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      }
      %subview_130 = memref.subview %alloc_79[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x512x128xf32> to memref<?x32x128xf32, strided<[65536, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[65536, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[65536, 128, 1], offset: ?>>)
    }
    %alloc_80 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%alloc_56 : memref<2x1024x128xf32>) outs(%alloc_80 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29, %arg30, %arg31) in (2, 32, 4, 16) {
      %1 = affine.apply #map(%arg29)
      %2 = affine.apply #map(%arg30)
      %3 = affine.apply #map(%arg31)
      %subview_128 = memref.subview %alloc_74[%arg28, %1, %3] [1, 32, 32] [1, 1, 1] : memref<2x1024x512xf32> to memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_79[%arg28, %3, %2] [1, 32, 32] [1, 1, 1] : memref<2x512x128xf32> to memref<1x32x32xf32, strided<[65536, 128, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_80[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.batch_matmul ins(%subview_128, %subview_129 : memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>, memref<1x32x32xf32, strided<[65536, 128, 1], offset: ?>>) outs(%subview_130 : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>)
      %subview_131 = memref.subview %alloc_80[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_81 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_81 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_80[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_81[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map5, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %arg13 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<128xf32>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_131: f32, %out: f32):
        %4 = arith.addf %in, %in_131 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_81[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_82 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_82 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_59[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_81[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_82[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %4 = arith.addf %in, %in_132 : f32
        linalg.yield %4 : f32
      }
      %subview_131 = memref.subview %alloc_82[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_83 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    linalg.copy ins(%alloc_7 : memref<2x1024x1xf32>) outs(%alloc_83 : memref<2x1024x1xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_82[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_83[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map3], iterator_types = ["parallel", "parallel", "reduction"]} ins(%subview_128 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.addf %in, %out : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_83[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_83[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      %subview_129 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.divf %in, %cst_5 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    %collapse_shape_84 = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x1024x1xf32> into memref<2x1024xf32>
    %alloc_85 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_85 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %collapse_shape_84[%1, %2] [%3, 32] [1, 1] : memref<2x1024xf32> to memref<?x32xf32, strided<[1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_85[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map4, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32xf32, strided<[1024, 1], offset: ?>>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      }
      %subview_130 = memref.subview %alloc_85[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_86 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_86 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_82[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_85[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_86[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %4 = arith.subf %in, %in_132 : f32
        linalg.yield %4 : f32
      }
      %subview_131 = memref.subview %alloc_86[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_87 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_87 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_86[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_86[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_87[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %4 = arith.mulf %in, %in_132 : f32
        linalg.yield %4 : f32
      }
      %subview_131 = memref.subview %alloc_87[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_88 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    linalg.copy ins(%alloc_7 : memref<2x1024x1xf32>) outs(%alloc_88 : memref<2x1024x1xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_87[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_88[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map3], iterator_types = ["parallel", "parallel", "reduction"]} ins(%subview_128 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.addf %in, %out : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_88[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_88[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      %subview_129 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.divf %in, %cst_5 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    %alloc_89 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_89[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.truncf %cst_4 : f64 to f32
        %5 = arith.addf %in, %4 : f32
        linalg.yield %5 : f32
      }
      %subview_130 = memref.subview %alloc_89[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_89[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      %subview_129 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = math.rsqrt %in : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    %collapse_shape_90 = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x1024x1xf32> into memref<2x1024xf32>
    %alloc_91 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_91 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %collapse_shape_90[%1, %2] [%3, 32] [1, 1] : memref<2x1024xf32> to memref<?x32xf32, strided<[1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_91[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map4, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32xf32, strided<[1024, 1], offset: ?>>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      }
      %subview_130 = memref.subview %alloc_91[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_92 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_92 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_86[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_91[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_92[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %4 = arith.mulf %in, %in_132 : f32
        linalg.yield %4 : f32
      }
      %subview_131 = memref.subview %alloc_92[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_93 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_93 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_92[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_93[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map5, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %arg14 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<128xf32>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_131: f32, %out: f32):
        %4 = arith.mulf %in, %in_131 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_93[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_94 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_94 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_93[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_94[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map5, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %arg15 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<128xf32>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_131: f32, %out: f32):
        %4 = arith.addf %in, %in_131 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_94[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (4, 12) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %subview_128 = memref.subview %arg16[%2, %1] [32, 32] [1, 1] : memref<384x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_19[%1, %2] [32, 32] [1, 1] : memref<128x384xf32> to memref<32x32xf32, strided<[384, 1], offset: ?>>
      linalg.transpose ins(%subview_128 : memref<32x32xf32, strided<[128, 1], offset: ?>>) outs(%subview_129 : memref<32x32xf32, strided<[384, 1], offset: ?>>) permutation = [1, 0] 
      %subview_130 = memref.subview %alloc_19[%1, %2] [32, 32] [1, 1] : memref<128x384xf32> to memref<32x32xf32, strided<[384, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<32x32xf32, strided<[384, 1], offset: ?>>) outs(%subview_130 : memref<32x32xf32, strided<[384, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 4) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_19[%2, 0] [32, 384] [1, 1] : memref<128x384xf32> to memref<32x384xf32, strided<[384, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_20[%1, %2, 0] [%3, 32, 384] [1, 1, 1] : memref<2x128x384xf32> to memref<?x32x384xf32, strided<[49152, 384, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map6, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<32x384xf32, strided<[384, 1], offset: ?>>) outs(%subview_129 : memref<?x32x384xf32, strided<[49152, 384, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      }
      %subview_130 = memref.subview %alloc_20[%1, %2, 0] [%3, 32, 384] [1, 1, 1] : memref<2x128x384xf32> to memref<?x32x384xf32, strided<[49152, 384, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x384xf32, strided<[49152, 384, 1], offset: ?>>) outs(%subview_130 : memref<?x32x384xf32, strided<[49152, 384, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29, %arg30, %arg31) in (2, 32, 12, 4) {
      %1 = affine.apply #map(%arg29)
      %2 = affine.apply #map(%arg30)
      %3 = affine.apply #map(%arg31)
      %subview_128 = memref.subview %alloc_94[%arg28, %1, %3] [1, 32, 32] [1, 1, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_20[%arg28, %3, %2] [1, 32, 32] [1, 1, 1] : memref<2x128x384xf32> to memref<1x32x32xf32, strided<[49152, 384, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_22[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<2x1024x384xf32> to memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>
      linalg.batch_matmul ins(%subview_128, %subview_129 : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>, memref<1x32x32xf32, strided<[49152, 384, 1], offset: ?>>) outs(%subview_130 : memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>)
      %subview_131 = memref.subview %alloc_22[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<2x1024x384xf32> to memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>) outs(%subview_131 : memref<1x32x32xf32, strided<[393216, 384, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_22[%1, %2, 0] [%3, 32, 384] [1, 1, 1] : memref<2x1024x384xf32> to memref<?x32x384xf32, strided<[393216, 384, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_21[%1, %2, 0] [%3, 32, 384] [1, 1, 1] : memref<2x1024x384xf32> to memref<?x32x384xf32, strided<[393216, 384, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map5, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %arg17 : memref<?x32x384xf32, strided<[393216, 384, 1], offset: ?>>, memref<384xf32>) outs(%subview_129 : memref<?x32x384xf32, strided<[393216, 384, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_131: f32, %out: f32):
        %4 = arith.addf %in, %in_131 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_21[%1, %2, 0] [%3, 32, 384] [1, 1, 1] : memref<2x1024x384xf32> to memref<?x32x384xf32, strided<[393216, 384, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x384xf32, strided<[393216, 384, 1], offset: ?>>) outs(%subview_130 : memref<?x32x384xf32, strided<[393216, 384, 1], offset: ?>>)
    }
    %subview_95 = memref.subview %alloc_21[0, 0, 0] [2, 1024, 128] [1, 1, 1] : memref<2x1024x384xf32> to memref<2x1024x128xf32, strided<[393216, 384, 1]>>
    %subview_96 = memref.subview %alloc_21[0, 0, 128] [2, 1024, 128] [1, 1, 1] : memref<2x1024x384xf32> to memref<2x1024x128xf32, strided<[393216, 384, 1], offset: 128>>
    %subview_97 = memref.subview %alloc_21[0, 0, 256] [2, 1024, 128] [1, 1, 1] : memref<2x1024x384xf32> to memref<2x1024x128xf32, strided<[393216, 384, 1], offset: 256>>
    %expand_shape_98 = memref.expand_shape %subview_96 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : memref<2x1024x128xf32, strided<[393216, 384, 1], offset: 128>> into memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 128>>
    %expand_shape_99 = memref.expand_shape %subview_95 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : memref<2x1024x128xf32, strided<[393216, 384, 1]>> into memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1]>>
    %alloc_100 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x32xf32>
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %expand_shape_99[%1, 0, %2, 0] [%3, 1024, %4, 32] [1, 1, 1, 1] : memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1]>> to memref<?x1024x?x32xf32, strided<[393216, 384, 32, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_100[%1, %2, 0, 0] [%3, %4, 1024, 32] [1, 1, 1, 1] : memref<2x4x1024x32xf32> to memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>
      linalg.transpose ins(%subview_128 : memref<?x1024x?x32xf32, strided<[393216, 384, 32, 1], offset: ?>>) outs(%subview_129 : memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>) permutation = [0, 2, 1, 3] 
      %subview_130 = memref.subview %alloc_100[%1, %2, 0, 0] [%3, %4, 1024, 32] [1, 1, 1, 1] : memref<2x4x1024x32xf32> to memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>) outs(%subview_130 : memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>)
    }
    %expand_shape_101 = memref.expand_shape %subview_97 [[0], [1], [2, 3]] output_shape [2, 1024, 4, 32] : memref<2x1024x128xf32, strided<[393216, 384, 1], offset: 256>> into memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 256>>
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %expand_shape_101[%1, 0, %2, 0] [%3, 1024, %4, 32] [1, 1, 1, 1] : memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 256>> to memref<?x1024x?x32xf32, strided<[393216, 384, 32, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_27[%1, %2, 0, 0] [%3, %4, 1024, 32] [1, 1, 1, 1] : memref<2x4x1024x32xf32> to memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>
      linalg.transpose ins(%subview_128 : memref<?x1024x?x32xf32, strided<[393216, 384, 32, 1], offset: ?>>) outs(%subview_129 : memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>) permutation = [0, 2, 1, 3] 
      %subview_130 = memref.subview %alloc_27[%1, %2, 0, 0] [%3, %4, 1024, 32] [1, 1, 1, 1] : memref<2x4x1024x32xf32> to memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>) outs(%subview_130 : memref<?x?x1024x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %expand_shape_98[%1, 0, %2, 0] [%3, 1024, %4, 32] [1, 1, 1, 1] : memref<2x1024x4x32xf32, strided<[393216, 384, 32, 1], offset: 128>> to memref<?x1024x?x32xf32, strided<[393216, 384, 32, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_30[%1, %2, 0, 0] [%3, %4, 32, 1024] [1, 1, 1, 1] : memref<2x4x32x1024xf32> to memref<?x?x32x1024xf32, strided<[131072, 32768, 1024, 1], offset: ?>>
      linalg.transpose ins(%subview_128 : memref<?x1024x?x32xf32, strided<[393216, 384, 32, 1], offset: ?>>) outs(%subview_129 : memref<?x?x32x1024xf32, strided<[131072, 32768, 1024, 1], offset: ?>>) permutation = [0, 2, 3, 1] 
      %subview_130 = memref.subview %alloc_30[%1, %2, 0, 0] [%3, %4, 32, 1024] [1, 1, 1, 1] : memref<2x4x32x1024xf32> to memref<?x?x32x1024xf32, strided<[131072, 32768, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x?x32x1024xf32, strided<[131072, 32768, 1024, 1], offset: ?>>) outs(%subview_130 : memref<?x?x32x1024xf32, strided<[131072, 32768, 1024, 1], offset: ?>>)
    }
    %collapse_shape_102 = memref.collapse_shape %alloc_100 [[0, 1], [2], [3]] : memref<2x4x1024x32xf32> into memref<8x1024x32xf32>
    %collapse_shape_103 = memref.collapse_shape %alloc_30 [[0, 1], [2], [3]] : memref<2x4x32x1024xf32> into memref<8x32x1024xf32>
    scf.forall (%arg28, %arg29, %arg30, %arg31) in (8, 32, 32, 1) {
      %1 = affine.apply #map(%arg29)
      %2 = affine.apply #map(%arg30)
      %3 = affine.apply #map(%arg31)
      %subview_128 = memref.subview %collapse_shape_102[%arg28, %1, %3] [1, 32, 32] [1, 1, 1] : memref<8x1024x32xf32> to memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
      %subview_129 = memref.subview %collapse_shape_103[%arg28, %3, %2] [1, 32, 32] [1, 1, 1] : memref<8x32x1024xf32> to memref<1x32x32xf32, strided<[32768, 1024, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_33[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<8x1024x1024xf32> to memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
      linalg.batch_matmul ins(%subview_128, %subview_129 : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>, memref<1x32x32xf32, strided<[32768, 1024, 1], offset: ?>>) outs(%subview_130 : memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>)
      %subview_131 = memref.subview %alloc_33[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<8x1024x1024xf32> to memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>) outs(%subview_131 : memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>)
    }
    %expand_shape_104 = memref.expand_shape %alloc_33 [[0, 1], [2], [3]] output_shape [2, 4, 1024, 1024] : memref<8x1024x1024xf32> into memref<2x4x1024x1024xf32>
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %expand_shape_104[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_36[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map8, #map8], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_129 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %5 = arith.truncf %cst_3 : f64 to f32
        %6 = arith.mulf %in, %5 : f32
        linalg.yield %6 : f32
      }
      %subview_130 = memref.subview %alloc_36[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_130 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map9(%1)
      %4 = affine.min #map9(%2)
      %subview_128 = memref.subview %arg18[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<1x1x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[1048576, 1048576, 1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_37[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<1x1x1024x1024xi1> to memref<?x?x1024x1024xi1, strided<[1048576, 1048576, 1024, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map8, #map8], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x?x1024x1024xf32, strided<[1048576, 1048576, 1024, 1], offset: ?>>) outs(%subview_129 : memref<?x?x1024x1024xi1, strided<[1048576, 1048576, 1024, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: i1):
        %5 = arith.cmpf oeq, %in, %cst : f32
        linalg.yield %5 : i1
      }
      %subview_130 = memref.subview %alloc_37[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<1x1x1024x1024xi1> to memref<?x?x1024x1024xi1, strided<[1048576, 1048576, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x?x1024x1024xi1, strided<[1048576, 1048576, 1024, 1], offset: ?>>) outs(%subview_130 : memref<?x?x1024x1024xi1, strided<[1048576, 1048576, 1024, 1], offset: ?>>)
    }
    %alloc_105 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x1024xf32>
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %alloc_36[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_105[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map10, #map11, #map8, #map8], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%alloc_37, %0, %subview_128 : memref<1x1x1024x1024xi1>, memref<f32>, memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_129 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) {
      ^bb0(%in: i1, %in_131: f32, %in_132: f32, %out: f32):
        %5 = arith.select %in, %in_131, %in_132 : f32
        linalg.yield %5 : f32
      }
      %subview_130 = memref.subview %alloc_105[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_130 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %alloc_105[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_40[%1, %2, 0] [%3, %4, 1024] [1, 1, 1] : memref<2x4x1024xf32> to memref<?x?x1024xf32, strided<[4096, 1024, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_39[%1, %2, 0] [%3, %4, 1024] [1, 1, 1] : memref<2x4x1024xi64> to memref<?x?x1024xi64, strided<[4096, 1024, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map8, #map12, #map12], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%subview_128 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_129, %subview_130 : memref<?x?x1024xf32, strided<[4096, 1024, 1], offset: ?>>, memref<?x?x1024xi64, strided<[4096, 1024, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32, %out_133: i64):
        %5 = linalg.index 3 : index
        %6 = arith.index_cast %5 : index to i64
        %7 = arith.maximumf %in, %out : f32
        %8 = arith.cmpf ogt, %in, %out : f32
        %9 = arith.select %8, %6, %out_133 : i64
        linalg.yield %7, %9 : f32, i64
      }
      %subview_131 = memref.subview %alloc_40[%1, %2, 0] [%3, %4, 1024] [1, 1, 1] : memref<2x4x1024xf32> to memref<?x?x1024xf32, strided<[4096, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x?x1024xf32, strided<[4096, 1024, 1], offset: ?>>) outs(%subview_131 : memref<?x?x1024xf32, strided<[4096, 1024, 1], offset: ?>>)
      %subview_132 = memref.subview %alloc_39[%1, %2, 0] [%3, %4, 1024] [1, 1, 1] : memref<2x4x1024xi64> to memref<?x?x1024xi64, strided<[4096, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x?x1024xi64, strided<[4096, 1024, 1], offset: ?>>) outs(%subview_132 : memref<?x?x1024xi64, strided<[4096, 1024, 1], offset: ?>>)
    }
    %expand_shape_106 = memref.expand_shape %alloc_40 [[0], [1], [2, 3]] output_shape [2, 4, 1024, 1] : memref<2x4x1024xf32> into memref<2x4x1024x1xf32>
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %alloc_105[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      %subview_129 = memref.subview %expand_shape_106[%1, %2, 0, 0] [%3, %4, 1024, 1] [1, 1, 1, 1] : memref<2x4x1024x1xf32> to memref<?x?x1024x1xf32, strided<[4096, 1024, 1, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_36[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map8, #map13, #map8], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>, memref<?x?x1024x1xf32, strided<[4096, 1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %5 = arith.subf %in, %in_132 : f32
        linalg.yield %5 : f32
      }
      %subview_131 = memref.subview %alloc_36[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_131 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>)
    }
    %alloc_107 = memref.alloc() {alignment = 64 : i64} : memref<2x4x1024x1024xf32>
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %alloc_36[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_107[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map8, #map8], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_129 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %5 = math.exp %in : f32
        linalg.yield %5 : f32
      }
      %subview_130 = memref.subview %alloc_107[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_130 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %alloc_107[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_45[%1, %2, 0, 0] [%3, %4, 1024, 1] [1, 1, 1, 1] : memref<2x4x1024x1xf32> to memref<?x?x1024x1xf32, strided<[4096, 1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map8, #map13], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%subview_128 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_129 : memref<?x?x1024x1xf32, strided<[4096, 1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %5 = arith.addf %in, %out : f32
        linalg.yield %5 : f32
      }
      %subview_130 = memref.subview %alloc_45[%1, %2, 0, 0] [%3, %4, 1024, 1] [1, 1, 1, 1] : memref<2x4x1024x1xf32> to memref<?x?x1024x1xf32, strided<[4096, 1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x?x1024x1xf32, strided<[4096, 1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x?x1024x1xf32, strided<[4096, 1024, 1, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 1) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %4 = affine.min #map7(%2)
      %subview_128 = memref.subview %alloc_107[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_45[%1, %2, 0, 0] [%3, %4, 1024, 1] [1, 1, 1, 1] : memref<2x4x1024x1xf32> to memref<?x?x1024x1xf32, strided<[4096, 1024, 1, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_36[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map8, #map13, #map8], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>, memref<?x?x1024x1xf32, strided<[4096, 1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %5 = arith.divf %in, %in_132 : f32
        linalg.yield %5 : f32
      }
      %subview_131 = memref.subview %alloc_36[%1, %2, 0, 0] [%3, %4, 1024, 1024] [1, 1, 1, 1] : memref<2x4x1024x1024xf32> to memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>) outs(%subview_131 : memref<?x?x1024x1024xf32, strided<[4194304, 1048576, 1024, 1], offset: ?>>)
    }
    %collapse_shape_108 = memref.collapse_shape %alloc_36 [[0, 1], [2], [3]] : memref<2x4x1024x1024xf32> into memref<8x1024x1024xf32>
    %collapse_shape_109 = memref.collapse_shape %alloc_27 [[0, 1], [2], [3]] : memref<2x4x1024x32xf32> into memref<8x1024x32xf32>
    scf.forall (%arg28, %arg29, %arg30, %arg31) in (8, 32, 1, 32) {
      %1 = affine.apply #map(%arg29)
      %2 = affine.apply #map(%arg30)
      %3 = affine.apply #map(%arg31)
      %subview_128 = memref.subview %collapse_shape_108[%arg28, %1, %3] [1, 32, 32] [1, 1, 1] : memref<8x1024x1024xf32> to memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>
      %subview_129 = memref.subview %collapse_shape_109[%arg28, %3, %2] [1, 32, 32] [1, 1, 1] : memref<8x1024x32xf32> to memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_49[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<8x1024x32xf32> to memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
      linalg.batch_matmul ins(%subview_128, %subview_129 : memref<1x32x32xf32, strided<[1048576, 1024, 1], offset: ?>>, memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>) outs(%subview_130 : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>)
      %subview_131 = memref.subview %alloc_49[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<8x1024x32xf32> to memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>) outs(%subview_131 : memref<1x32x32xf32, strided<[32768, 32, 1], offset: ?>>)
    }
    %expand_shape_110 = memref.expand_shape %alloc_49 [[0, 1], [2], [3]] output_shape [2, 4, 1024, 32] : memref<8x1024x32xf32> into memref<2x4x1024x32xf32>
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %expand_shape_110[%1, 0, %2, 0] [%3, 4, 32, 32] [1, 1, 1, 1] : memref<2x4x1024x32xf32> to memref<?x4x32x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_52[%1, %2, 0, 0] [%3, 32, 4, 32] [1, 1, 1, 1] : memref<2x1024x4x32xf32> to memref<?x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>
      linalg.transpose ins(%subview_128 : memref<?x4x32x32xf32, strided<[131072, 32768, 32, 1], offset: ?>>) outs(%subview_129 : memref<?x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>) permutation = [0, 2, 1, 3] 
      %subview_130 = memref.subview %alloc_52[%1, %2, 0, 0] [%3, 32, 4, 32] [1, 1, 1, 1] : memref<2x1024x4x32xf32> to memref<?x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>) outs(%subview_130 : memref<?x32x4x32xf32, strided<[131072, 128, 32, 1], offset: ?>>)
    }
    %collapse_shape_111 = memref.collapse_shape %alloc_52 [[0], [1], [2, 3]] : memref<2x1024x4x32xf32> into memref<2x1024x128xf32>
    scf.forall (%arg28, %arg29) in (4, 4) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %subview_128 = memref.subview %arg19[%2, %1] [32, 32] [1, 1] : memref<128x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_54[%1, %2] [32, 32] [1, 1] : memref<128x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
      linalg.transpose ins(%subview_128 : memref<32x32xf32, strided<[128, 1], offset: ?>>) outs(%subview_129 : memref<32x32xf32, strided<[128, 1], offset: ?>>) permutation = [1, 0] 
      %subview_130 = memref.subview %alloc_54[%1, %2] [32, 32] [1, 1] : memref<128x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<32x32xf32, strided<[128, 1], offset: ?>>) outs(%subview_130 : memref<32x32xf32, strided<[128, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 4) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_54[%2, 0] [32, 128] [1, 1] : memref<128x128xf32> to memref<32x128xf32, strided<[128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_55[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x128x128xf32> to memref<?x32x128xf32, strided<[16384, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map6, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<32x128xf32, strided<[128, 1], offset: ?>>) outs(%subview_129 : memref<?x32x128xf32, strided<[16384, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      }
      %subview_130 = memref.subview %alloc_55[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x128x128xf32> to memref<?x32x128xf32, strided<[16384, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[16384, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[16384, 128, 1], offset: ?>>)
    }
    %alloc_112 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%alloc_56 : memref<2x1024x128xf32>) outs(%alloc_112 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29, %arg30, %arg31) in (2, 32, 4, 4) {
      %1 = affine.apply #map(%arg29)
      %2 = affine.apply #map(%arg30)
      %3 = affine.apply #map(%arg31)
      %subview_128 = memref.subview %collapse_shape_111[%arg28, %1, %3] [1, 32, 32] [1, 1, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_55[%arg28, %3, %2] [1, 32, 32] [1, 1, 1] : memref<2x128x128xf32> to memref<1x32x32xf32, strided<[16384, 128, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_112[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.batch_matmul ins(%subview_128, %subview_129 : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>, memref<1x32x32xf32, strided<[16384, 128, 1], offset: ?>>) outs(%subview_130 : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>)
      %subview_131 = memref.subview %alloc_112[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_113 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_113 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_112[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_113[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map5, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %arg20 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<128xf32>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_131: f32, %out: f32):
        %4 = arith.addf %in, %in_131 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_113[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_114 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_114 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_82[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_113[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_114[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %4 = arith.addf %in, %in_132 : f32
        linalg.yield %4 : f32
      }
      %subview_131 = memref.subview %alloc_114[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_115 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    linalg.copy ins(%alloc_7 : memref<2x1024x1xf32>) outs(%alloc_115 : memref<2x1024x1xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_114[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_115[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map3], iterator_types = ["parallel", "parallel", "reduction"]} ins(%subview_128 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.addf %in, %out : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_115[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_115[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      %subview_129 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.divf %in, %cst_5 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    %collapse_shape_116 = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x1024x1xf32> into memref<2x1024xf32>
    %alloc_117 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_117 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %collapse_shape_116[%1, %2] [%3, 32] [1, 1] : memref<2x1024xf32> to memref<?x32xf32, strided<[1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_117[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map4, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32xf32, strided<[1024, 1], offset: ?>>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      }
      %subview_130 = memref.subview %alloc_117[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_118 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_118 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_114[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_117[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_118[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %4 = arith.subf %in, %in_132 : f32
        linalg.yield %4 : f32
      }
      %subview_131 = memref.subview %alloc_118[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_119 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_119 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_118[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_118[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_119[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %4 = arith.mulf %in, %in_132 : f32
        linalg.yield %4 : f32
      }
      %subview_131 = memref.subview %alloc_119[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_119[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_7[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map3], iterator_types = ["parallel", "parallel", "reduction"]} ins(%subview_128 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.addf %in, %out : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_7[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_7[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      %subview_129 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.divf %in, %cst_5 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    %alloc_120 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x1xf32>
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_120[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.truncf %cst_4 : f64 to f32
        %5 = arith.addf %in, %4 : f32
        linalg.yield %5 : f32
      }
      %subview_130 = memref.subview %alloc_120[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_120[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      %subview_129 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = math.rsqrt %in : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc[%1, %2, 0] [%3, 32, 1] [1, 1, 1] : memref<2x1024x1xf32> to memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>) outs(%subview_130 : memref<?x32x1xf32, strided<[1024, 1, 1], offset: ?>>)
    }
    %collapse_shape_121 = memref.collapse_shape %alloc [[0], [1, 2]] : memref<2x1024x1xf32> into memref<2x1024xf32>
    %alloc_122 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_122 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %collapse_shape_121[%1, %2] [%3, 32] [1, 1] : memref<2x1024xf32> to memref<?x32xf32, strided<[1024, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_122[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map4, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32xf32, strided<[1024, 1], offset: ?>>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      }
      %subview_130 = memref.subview %alloc_122[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_123 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_123 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_118[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_122[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_123[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %4 = arith.mulf %in, %in_132 : f32
        linalg.yield %4 : f32
      }
      %subview_131 = memref.subview %alloc_123[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_124 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_124 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_123[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_124[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map5, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %arg21 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<128xf32>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_131: f32, %out: f32):
        %4 = arith.mulf %in, %in_131 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_124[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_125 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_125 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_124[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_125[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map5, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %arg22 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<128xf32>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_131: f32, %out: f32):
        %4 = arith.addf %in, %in_131 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_125[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (4, 16) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %subview_128 = memref.subview %arg23[%2, %1] [32, 32] [1, 1] : memref<512x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_72[%1, %2] [32, 32] [1, 1] : memref<128x512xf32> to memref<32x32xf32, strided<[512, 1], offset: ?>>
      linalg.transpose ins(%subview_128 : memref<32x32xf32, strided<[128, 1], offset: ?>>) outs(%subview_129 : memref<32x32xf32, strided<[512, 1], offset: ?>>) permutation = [1, 0] 
      %subview_130 = memref.subview %alloc_72[%1, %2] [32, 32] [1, 1] : memref<128x512xf32> to memref<32x32xf32, strided<[512, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<32x32xf32, strided<[512, 1], offset: ?>>) outs(%subview_130 : memref<32x32xf32, strided<[512, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 4) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_72[%2, 0] [32, 512] [1, 1] : memref<128x512xf32> to memref<32x512xf32, strided<[512, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_73[%1, %2, 0] [%3, 32, 512] [1, 1, 1] : memref<2x128x512xf32> to memref<?x32x512xf32, strided<[65536, 512, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map6, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<32x512xf32, strided<[512, 1], offset: ?>>) outs(%subview_129 : memref<?x32x512xf32, strided<[65536, 512, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      }
      %subview_130 = memref.subview %alloc_73[%1, %2, 0] [%3, 32, 512] [1, 1, 1] : memref<2x128x512xf32> to memref<?x32x512xf32, strided<[65536, 512, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x512xf32, strided<[65536, 512, 1], offset: ?>>) outs(%subview_130 : memref<?x32x512xf32, strided<[65536, 512, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29, %arg30, %arg31) in (2, 32, 16, 4) {
      %1 = affine.apply #map(%arg29)
      %2 = affine.apply #map(%arg30)
      %3 = affine.apply #map(%arg31)
      %subview_128 = memref.subview %alloc_125[%arg28, %1, %3] [1, 32, 32] [1, 1, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_73[%arg28, %3, %2] [1, 32, 32] [1, 1, 1] : memref<2x128x512xf32> to memref<1x32x32xf32, strided<[65536, 512, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_75[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<2x1024x512xf32> to memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
      linalg.batch_matmul ins(%subview_128, %subview_129 : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>, memref<1x32x32xf32, strided<[65536, 512, 1], offset: ?>>) outs(%subview_130 : memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>)
      %subview_131 = memref.subview %alloc_75[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<2x1024x512xf32> to memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>) outs(%subview_131 : memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>)
    }
    %alloc_126 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x512xf32>
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_75[%1, %2, 0] [%3, 32, 512] [1, 1, 1] : memref<2x1024x512xf32> to memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_126[%1, %2, 0] [%3, 32, 512] [1, 1, 1] : memref<2x1024x512xf32> to memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map5, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %arg24 : memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>, memref<512xf32>) outs(%subview_129 : memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_131: f32, %out: f32):
        %4 = arith.addf %in, %in_131 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_126[%1, %2, 0] [%3, 32, 512] [1, 1, 1] : memref<2x1024x512xf32> to memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>) outs(%subview_130 : memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_126[%1, %2, 0] [%3, 32, 512] [1, 1, 1] : memref<2x1024x512xf32> to memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_74[%1, %2, 0] [%3, 32, 512] [1, 1, 1] : memref<2x1024x512xf32> to memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>) outs(%subview_129 : memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        %4 = arith.divf %in, %cst_6 : f32
        %5 = math.erf %4 : f32
        %6 = arith.addf %5, %cst_1 : f32
        %7 = arith.mulf %6, %cst_2 : f32
        %8 = arith.mulf %in, %7 : f32
        linalg.yield %8 : f32
      }
      %subview_130 = memref.subview %alloc_74[%1, %2, 0] [%3, 32, 512] [1, 1, 1] : memref<2x1024x512xf32> to memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>) outs(%subview_130 : memref<?x32x512xf32, strided<[524288, 512, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (16, 4) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %subview_128 = memref.subview %arg25[%2, %1] [32, 32] [1, 1] : memref<128x512xf32> to memref<32x32xf32, strided<[512, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_78[%1, %2] [32, 32] [1, 1] : memref<512x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
      linalg.transpose ins(%subview_128 : memref<32x32xf32, strided<[512, 1], offset: ?>>) outs(%subview_129 : memref<32x32xf32, strided<[128, 1], offset: ?>>) permutation = [1, 0] 
      %subview_130 = memref.subview %alloc_78[%1, %2] [32, 32] [1, 1] : memref<512x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<32x32xf32, strided<[128, 1], offset: ?>>) outs(%subview_130 : memref<32x32xf32, strided<[128, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 16) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_78[%2, 0] [32, 128] [1, 1] : memref<512x128xf32> to memref<32x128xf32, strided<[128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_79[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x512x128xf32> to memref<?x32x128xf32, strided<[65536, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map6, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128 : memref<32x128xf32, strided<[128, 1], offset: ?>>) outs(%subview_129 : memref<?x32x128xf32, strided<[65536, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %out: f32):
        linalg.yield %in : f32
      }
      %subview_130 = memref.subview %alloc_79[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x512x128xf32> to memref<?x32x128xf32, strided<[65536, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[65536, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[65536, 128, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29, %arg30, %arg31) in (2, 32, 4, 16) {
      %1 = affine.apply #map(%arg29)
      %2 = affine.apply #map(%arg30)
      %3 = affine.apply #map(%arg31)
      %subview_128 = memref.subview %alloc_74[%arg28, %1, %3] [1, 32, 32] [1, 1, 1] : memref<2x1024x512xf32> to memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_79[%arg28, %3, %2] [1, 32, 32] [1, 1, 1] : memref<2x512x128xf32> to memref<1x32x32xf32, strided<[65536, 128, 1], offset: ?>>
      %subview_130 = memref.subview %alloc_56[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.batch_matmul ins(%subview_128, %subview_129 : memref<1x32x32xf32, strided<[524288, 512, 1], offset: ?>>, memref<1x32x32xf32, strided<[65536, 128, 1], offset: ?>>) outs(%subview_130 : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>)
      %subview_131 = memref.subview %alloc_56[%arg28, %1, %2] [1, 32, 32] [1, 1, 1] : memref<2x1024x128xf32> to memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<1x32x32xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    %alloc_127 = memref.alloc() {alignment = 64 : i64} : memref<2x1024x128xf32>
    linalg.copy ins(%arg27 : memref<2x1024x128xf32>) outs(%alloc_127 : memref<2x1024x128xf32>)
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_56[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_127[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map5, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %arg26 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<128xf32>) outs(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_131: f32, %out: f32):
        %4 = arith.addf %in, %in_131 : f32
        linalg.yield %4 : f32
      }
      %subview_130 = memref.subview %alloc_127[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    scf.forall (%arg28, %arg29) in (1, 32) {
      %1 = affine.apply #map(%arg28)
      %2 = affine.apply #map(%arg29)
      %3 = affine.min #map1(%1)
      %subview_128 = memref.subview %alloc_114[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_129 = memref.subview %alloc_127[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      %subview_130 = memref.subview %arg27[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%subview_128, %subview_129 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>, memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) {
      ^bb0(%in: f32, %in_132: f32, %out: f32):
        %4 = arith.addf %in, %in_132 : f32
        linalg.yield %4 : f32
      }
      %subview_131 = memref.subview %arg27[%1, %2, 0] [%3, 32, 128] [1, 1, 1] : memref<2x1024x128xf32> to memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>
      linalg.copy ins(%subview_130 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>) outs(%subview_131 : memref<?x32x128xf32, strided<[131072, 128, 1], offset: ?>>)
    }
    return
  }
}
