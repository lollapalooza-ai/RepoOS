; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define void @networkx_algorithms_link_analysis_pagerank_alg__pagerank_python_chunk_0(ptr %0, ptr %1, ptr %2, ptr %3, ptr %4, ptr %5, ptr %6, i64 %7, double %8) {
  %10 = fsub double 1.000000e+00, %8
  br label %11

11:                                               ; preds = %14, %9
  %12 = phi i64 [ %19, %14 ], [ 0, %9 ]
  %13 = icmp slt i64 %12, %7
  br i1 %13, label %14, label %20

14:                                               ; preds = %11
  %15 = getelementptr double, ptr %6, i64 %12
  %16 = load double, ptr %15, align 8
  %17 = fmul double %10, %16
  %18 = getelementptr double, ptr %1, i64 %12
  store double %17, ptr %18, align 8
  %19 = add i64 %12, 1
  br label %11

20:                                               ; preds = %11
  br label %21

21:                                               ; preds = %46, %20
  %22 = phi i64 [ %47, %46 ], [ 0, %20 ]
  %23 = icmp slt i64 %22, %7
  br i1 %23, label %24, label %48

24:                                               ; preds = %21
  %25 = getelementptr double, ptr %5, i64 %22
  %26 = load double, ptr %25, align 8
  %27 = fmul double %8, %26
  %28 = getelementptr double, ptr %2, i64 %22
  %29 = load i64, ptr %28, align 4
  %30 = add i64 %22, 1
  %31 = getelementptr double, ptr %2, i64 %30
  %32 = load i64, ptr %31, align 4
  br label %33

33:                                               ; preds = %36, %24
  %34 = phi i64 [ %45, %36 ], [ %29, %24 ]
  %35 = icmp slt i64 %34, %32
  br i1 %35, label %36, label %46

36:                                               ; preds = %33
  %37 = getelementptr double, ptr %3, i64 %34
  %38 = load i64, ptr %37, align 4
  %39 = getelementptr double, ptr %4, i64 %34
  %40 = load double, ptr %39, align 8
  %41 = fmul double %27, %40
  %42 = getelementptr double, ptr %1, i64 %38
  %43 = load double, ptr %42, align 8
  %44 = fadd double %43, %41
  store double %44, ptr %42, align 8
  %45 = add i64 %34, 1
  br label %33

46:                                               ; preds = %33
  %47 = add i64 %22, 1
  br label %21

48:                                               ; preds = %21
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
