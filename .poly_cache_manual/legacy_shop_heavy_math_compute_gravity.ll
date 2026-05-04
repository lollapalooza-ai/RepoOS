; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define double @compute_gravity(double %0, double %1) {
  %3 = fmul double %0, %1
  %4 = fdiv double %3, 9.810000e+00
  %5 = fmul double %0, 5.000000e-01
  %6 = fadd double %4, %5
  %7 = fmul double %1, 2.000000e-01
  %8 = fsub double %6, %7
  ret double %8
}

define double @_mlir_ciface_compute_gravity(double %0, double %1) {
  %3 = call double @compute_gravity(double %0, double %1)
  ret double %3
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
