; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define double @index() {
  ret double 0.000000e+00
}

define double @_mlir_ciface_index() {
  %1 = call double @index()
  ret double %1
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
