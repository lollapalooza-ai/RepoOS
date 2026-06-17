; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define void @main(ptr %0, ptr %1) {
  %3 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %1, 0
  %4 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3, ptr %1, 1
  %5 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, i64 0, 2
  %6 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5, i64 1024, 3, 0
  %7 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %6, i64 1024, 4, 0
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %7, i64 1024, 3, 1
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, i64 1, 4, 1
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %0, 0
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, ptr %0, 1
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, i64 0, 2
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 1024, 3, 0
  %14 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, i64 1024, 4, 0
  %15 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %14, i64 1024, 3, 1
  %16 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %15, i64 1, 4, 1
  br label %17

17:                                               ; preds = %36, %2
  %18 = phi i64 [ %37, %36 ], [ 0, %2 ]
  %19 = icmp slt i64 %18, 1024
  br i1 %19, label %20, label %38

20:                                               ; preds = %17
  br label %21

21:                                               ; preds = %24, %20
  %22 = phi i64 [ %35, %24 ], [ 0, %20 ]
  %23 = icmp slt i64 %22, 1024
  br i1 %23, label %24, label %36

24:                                               ; preds = %21
  %25 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, 1
  %26 = mul nuw nsw i64 %18, 1024
  %27 = add nuw nsw i64 %26, %22
  %28 = getelementptr inbounds float, ptr %25, i64 %27
  %29 = load float, ptr %28, align 4
  %30 = fadd float %29, 1.000000e+00
  %31 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, 1
  %32 = mul nuw nsw i64 %18, 1024
  %33 = add nuw nsw i64 %32, %22
  %34 = getelementptr inbounds float, ptr %31, i64 %33
  store float %30, ptr %34, align 4
  %35 = add i64 %22, 1
  br label %21

36:                                               ; preds = %21
  %37 = add i64 %18, 1
  br label %17

38:                                               ; preds = %17
  br label %39

39:                                               ; preds = %59, %38
  %40 = phi i64 [ %60, %59 ], [ 0, %38 ]
  %41 = icmp slt i64 %40, 1024
  br i1 %41, label %42, label %61

42:                                               ; preds = %39
  br label %43

43:                                               ; preds = %46, %42
  %44 = phi i64 [ %58, %46 ], [ 0, %42 ]
  %45 = icmp slt i64 %44, 1024
  br i1 %45, label %46, label %59

46:                                               ; preds = %43
  %47 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, 1
  %48 = mul nuw nsw i64 %40, 1024
  %49 = add nuw nsw i64 %48, %44
  %50 = getelementptr inbounds float, ptr %47, i64 %49
  %51 = load float, ptr %50, align 4
  %52 = fcmp ugt float %51, 0.000000e+00
  %53 = select i1 %52, float %51, float 0.000000e+00
  %54 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, 1
  %55 = mul nuw nsw i64 %40, 1024
  %56 = add nuw nsw i64 %55, %44
  %57 = getelementptr inbounds float, ptr %54, i64 %56
  store float %53, ptr %57, align 4
  %58 = add i64 %44, 1
  br label %43

59:                                               ; preds = %43
  %60 = add i64 %40, 1
  br label %39

61:                                               ; preds = %39
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
