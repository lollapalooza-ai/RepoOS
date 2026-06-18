/home/yeshr/repoos/projectrepo/torch-mlir/build/bin/mlir-opt temp_lowered_memref.mlir \
    --pass-pipeline="builtin.module(memref-expand,convert-linalg-to-loops,expand-strided-metadata,lower-affine)" -o test_step1.mlir

/home/yeshr/repoos/projectrepo/torch-mlir/build/bin/mlir-opt test_step1.mlir \
    --pass-pipeline="builtin.module(convert-vector-to-scf)" -o test_step2.mlir

grep "vector.transfer" test_step2.mlir
