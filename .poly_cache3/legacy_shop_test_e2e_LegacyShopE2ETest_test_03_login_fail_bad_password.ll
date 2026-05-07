; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define double @test_03_login_fail_bad_password(double %0) {
  ret double 0.000000e+00
}

define double @_mlir_ciface_test_03_login_fail_bad_password(double %0) {
  %2 = call double @test_03_login_fail_bad_password(double %0)
  ret double %2
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
