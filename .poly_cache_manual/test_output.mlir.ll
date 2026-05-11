; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define double @cumulative_distribution(i64 %0, i64 %1, i64 %2) {
  ret double 1.000000e+00
}

define double @_mlir_ciface_cumulative_distribution(i64 %0, i64 %1, i64 %2) {
  %4 = call double @cumulative_distribution(i64 %0, i64 %1, i64 %2)
  ret double %4
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
