; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define void @networkx_utils_random_sequence_cumulative_distribution_chunk_0(ptr %0, ptr %1, ptr %2, i64 %3) {
  store double 0.000000e+00, ptr %2, align 8
  %5 = load double, ptr %1, align 8
  %6 = fdiv double %5, 1.010000e+02
  %7 = getelementptr double, ptr %2, i32 1
  store double %6, ptr %7, align 8
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
