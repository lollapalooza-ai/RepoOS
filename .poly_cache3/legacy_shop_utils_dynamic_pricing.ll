; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define double @dynamic_pricing(double %0, double %1) {
  %3 = fcmp ogt double %1, 1.000000e+00
  %4 = fmul double %0, %1
  %5 = select i1 %3, double %4, double %0
  ret double %5
}

define double @_mlir_ciface_dynamic_pricing(double %0, double %1) {
  %3 = call double @dynamic_pricing(double %0, double %1)
  ret double %3
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
