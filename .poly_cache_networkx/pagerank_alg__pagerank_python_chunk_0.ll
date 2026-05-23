; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define void @pagerank_alg__pagerank_python_chunk_0(ptr %0, ptr %1, ptr %2, ptr %3, ptr %4, ptr %5, i64 %6, double %7) {
  %9 = fsub double 1.000000e+00, %7
  br label %10

10:                                               ; preds = %13, %8
  %11 = phi i64 [ %18, %13 ], [ 0, %8 ]
  %12 = icmp slt i64 %11, %6
  br i1 %12, label %13, label %19

13:                                               ; preds = %10
  %14 = getelementptr double, ptr %5, i64 %11
  %15 = load double, ptr %14, align 8
  %16 = fmul double %9, %15
  %17 = getelementptr double, ptr %0, i64 %11
  store double %16, ptr %17, align 8
  %18 = add i64 %11, 1
  br label %10

19:                                               ; preds = %10
  br label %20

20:                                               ; preds = %45, %19
  %21 = phi i64 [ %46, %45 ], [ 0, %19 ]
  %22 = icmp slt i64 %21, %6
  br i1 %22, label %23, label %47

23:                                               ; preds = %20
  %24 = getelementptr double, ptr %4, i64 %21
  %25 = load double, ptr %24, align 8
  %26 = fmul double %7, %25
  %27 = getelementptr double, ptr %1, i64 %21
  %28 = load i64, ptr %27, align 4
  %29 = add i64 %21, 1
  %30 = getelementptr double, ptr %1, i64 %29
  %31 = load i64, ptr %30, align 4
  br label %32

32:                                               ; preds = %35, %23
  %33 = phi i64 [ %44, %35 ], [ %28, %23 ]
  %34 = icmp slt i64 %33, %31
  br i1 %34, label %35, label %45

35:                                               ; preds = %32
  %36 = getelementptr double, ptr %2, i64 %33
  %37 = load i64, ptr %36, align 4
  %38 = getelementptr double, ptr %3, i64 %33
  %39 = load double, ptr %38, align 8
  %40 = fmul double %26, %39
  %41 = getelementptr double, ptr %0, i64 %37
  %42 = load double, ptr %41, align 8
  %43 = fadd double %42, %40
  store double %43, ptr %41, align 8
  %44 = add i64 %33, 1
  br label %32

45:                                               ; preds = %32
  %46 = add i64 %21, 1
  br label %20

47:                                               ; preds = %20
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
