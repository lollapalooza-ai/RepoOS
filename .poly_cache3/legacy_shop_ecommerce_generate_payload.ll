; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i64 @generate_payload(i64 %0) {
  br label %2

2:                                                ; preds = %6, %1
  %3 = phi i64 [ %7, %6 ], [ 0, %1 ]
  %4 = phi i64 [ %4, %6 ], [ %0, %1 ]
  %5 = icmp slt i64 %3, %0
  br i1 %5, label %6, label %8

6:                                                ; preds = %2
  %7 = add i64 %3, 1
  br label %2

8:                                                ; preds = %2
  ret i64 %4
}

define i64 @_mlir_ciface_generate_payload(i64 %0) {
  %2 = call i64 @generate_payload(i64 %0)
  ret i64 %2
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
