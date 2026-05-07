; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define double @calculate_tax(double %0, i32 %1) {
  %3 = fmul double %0, 4.000000e-02
  %4 = icmp eq i32 %1, 2
  %5 = select i1 %4, double %3, double 0.000000e+00
  %6 = fmul double %0, 8.000000e-02
  %7 = icmp eq i32 %1, 1
  %8 = select i1 %7, double %6, double %5
  ret double %8
}

define double @_mlir_ciface_calculate_tax(double %0, i32 %1) {
  %3 = call double @calculate_tax(double %0, i32 %1)
  ret double %3
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
