; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define double @process_checkout(i64 %0, ptr %1, ptr %2, i64 %3, i64 %4, i64 %5, ptr %6, ptr %7, i64 %8, i64 %9, i64 %10) {
  br label %12

12:                                               ; preds = %16, %11
  %13 = phi i64 [ %23, %16 ], [ 0, %11 ]
  %14 = phi double [ %22, %16 ], [ 0.000000e+00, %11 ]
  %15 = icmp slt i64 %13, %0
  br i1 %15, label %16, label %24

16:                                               ; preds = %12
  %17 = getelementptr inbounds nuw double, ptr %2, i64 %13
  %18 = load double, ptr %17, align 8
  %19 = getelementptr inbounds nuw double, ptr %7, i64 %13
  %20 = load double, ptr %19, align 8
  %21 = fmul double %18, %20
  %22 = fadd double %14, %21
  %23 = add i64 %13, 1
  br label %12

24:                                               ; preds = %12
  %25 = fmul double %14, 1.080000e+00
  ret double %25
}

define double @_mlir_ciface_process_checkout(i64 %0, ptr %1, ptr %2) {
  %4 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %1, align 8
  %5 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %4, 0
  %6 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %4, 1
  %7 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %4, 2
  %8 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %4, 3, 0
  %9 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %4, 4, 0
  %10 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %2, align 8
  %11 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %10, 0
  %12 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %10, 1
  %13 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %10, 2
  %14 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %10, 3, 0
  %15 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %10, 4, 0
  %16 = call double @process_checkout(i64 %0, ptr %5, ptr %6, i64 %7, i64 %8, i64 %9, ptr %11, ptr %12, i64 %13, i64 %14, i64 %15)
  ret double %16
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
