; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define void @networkx_utils_random_sequence_zipf_rv_chunk_0(ptr %0, double %1) {
  %3 = fsub double %1, 1.000000e+00
  %4 = call double @llvm.pow.f64(double 2.000000e+00, double %3)
  store double %4, ptr %0, align 8
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.pow.f64(double, double) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
