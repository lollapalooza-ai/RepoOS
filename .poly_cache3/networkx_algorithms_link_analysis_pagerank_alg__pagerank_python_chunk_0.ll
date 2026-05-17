; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define void @networkx_algorithms_link_analysis_pagerank_alg__pagerank_python_chunk_0(ptr %0, ptr %1, ptr %2, ptr %3, ptr %4, ptr %5, i64 %6, double %7, i64 %8) {
  %10 = fsub double 1.000000e+00, %7
  br label %11

11:                                               ; preds = %61, %9
  %12 = phi i64 [ %62, %61 ], [ 0, %9 ]
  %13 = icmp slt i64 %12, %8
  br i1 %13, label %14, label %63

14:                                               ; preds = %11
  br label %15

15:                                               ; preds = %18, %14
  %16 = phi i64 [ %23, %18 ], [ 0, %14 ]
  %17 = icmp slt i64 %16, %6
  br i1 %17, label %18, label %24

18:                                               ; preds = %15
  %19 = getelementptr double, ptr %5, i64 %16
  %20 = load double, ptr %19, align 8
  %21 = fmul double %10, %20
  %22 = getelementptr double, ptr %0, i64 %16
  store double %21, ptr %22, align 8
  %23 = add i64 %16, 1
  br label %15

24:                                               ; preds = %15
  br label %25

25:                                               ; preds = %50, %24
  %26 = phi i64 [ %51, %50 ], [ 0, %24 ]
  %27 = icmp slt i64 %26, %6
  br i1 %27, label %28, label %52

28:                                               ; preds = %25
  %29 = getelementptr double, ptr %4, i64 %26
  %30 = load double, ptr %29, align 8
  %31 = fmul double %7, %30
  %32 = getelementptr double, ptr %1, i64 %26
  %33 = load i64, ptr %32, align 4
  %34 = add i64 %26, 1
  %35 = getelementptr double, ptr %1, i64 %34
  %36 = load i64, ptr %35, align 4
  br label %37

37:                                               ; preds = %40, %28
  %38 = phi i64 [ %49, %40 ], [ %33, %28 ]
  %39 = icmp slt i64 %38, %36
  br i1 %39, label %40, label %50

40:                                               ; preds = %37
  %41 = getelementptr double, ptr %2, i64 %38
  %42 = load i64, ptr %41, align 4
  %43 = getelementptr double, ptr %3, i64 %38
  %44 = load double, ptr %43, align 8
  %45 = fmul double %31, %44
  %46 = getelementptr double, ptr %0, i64 %42
  %47 = load double, ptr %46, align 8
  %48 = fadd double %47, %45
  store double %48, ptr %46, align 8
  %49 = add i64 %38, 1
  br label %37

50:                                               ; preds = %37
  %51 = add i64 %26, 1
  br label %25

52:                                               ; preds = %25
  br label %53

53:                                               ; preds = %56, %52
  %54 = phi i64 [ %60, %56 ], [ 0, %52 ]
  %55 = icmp slt i64 %54, %6
  br i1 %55, label %56, label %61

56:                                               ; preds = %53
  %57 = getelementptr double, ptr %0, i64 %54
  %58 = load double, ptr %57, align 8
  %59 = getelementptr double, ptr %4, i64 %54
  store double %58, ptr %59, align 8
  %60 = add i64 %54, 1
  br label %53

61:                                               ; preds = %53
  %62 = add i64 %12, 1
  br label %11

63:                                               ; preds = %11
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
