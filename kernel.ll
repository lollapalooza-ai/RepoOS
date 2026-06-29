; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define void @main(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, ptr %7, ptr %8, i64 %9, i64 %10, i64 %11, i64 %12, i64 %13, ptr %14, ptr %15, i64 %16, i64 %17, i64 %18, i64 %19, i64 %20) {
  %22 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %14, 0
  %23 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, ptr %15, 1
  %24 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %23, i64 %16, 2
  %25 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, i64 %17, 3, 0
  %26 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %25, i64 %19, 4, 0
  %27 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, i64 %18, 3, 1
  %28 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %27, i64 %20, 4, 1
  %29 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %7, 0
  %30 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %29, ptr %8, 1
  %31 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %30, i64 %9, 2
  %32 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %31, i64 %10, 3, 0
  %33 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %32, i64 %12, 4, 0
  %34 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %33, i64 %11, 3, 1
  %35 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, i64 %13, 4, 1
  %36 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %0, 0
  %37 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %36, ptr %1, 1
  %38 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %37, i64 %2, 2
  %39 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %38, i64 %3, 3, 0
  %40 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, i64 %5, 4, 0
  %41 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %40, i64 %4, 3, 1
  %42 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %41, i64 %6, 4, 1
  br label %43

43:                                               ; preds = %56, %21
  %44 = phi i64 [ %57, %56 ], [ 0, %21 ]
  %45 = icmp slt i64 %44, 128
  br i1 %45, label %46, label %58

46:                                               ; preds = %43
  br label %47

47:                                               ; preds = %50, %46
  %48 = phi i64 [ %55, %50 ], [ 0, %46 ]
  %49 = icmp slt i64 %48, 128
  br i1 %49, label %50, label %56

50:                                               ; preds = %47
  %51 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 1
  %52 = mul nuw nsw i64 %44, 128
  %53 = add nuw nsw i64 %52, %48
  %54 = getelementptr inbounds float, ptr %51, i64 %53
  store float 0.000000e+00, ptr %54, align 4
  %55 = add i64 %48, 1
  br label %47

56:                                               ; preds = %47
  %57 = add i64 %44, 1
  br label %43

58:                                               ; preds = %43
  br label %59

59:                                               ; preds = %95, %58
  %60 = phi i64 [ %96, %95 ], [ 0, %58 ]
  %61 = icmp slt i64 %60, 128
  br i1 %61, label %62, label %97

62:                                               ; preds = %59
  br label %63

63:                                               ; preds = %93, %62
  %64 = phi i64 [ %94, %93 ], [ 0, %62 ]
  %65 = icmp slt i64 %64, 128
  br i1 %65, label %66, label %95

66:                                               ; preds = %63
  br label %67

67:                                               ; preds = %70, %66
  %68 = phi i64 [ %92, %70 ], [ 0, %66 ]
  %69 = icmp slt i64 %68, 128
  br i1 %69, label %70, label %93

70:                                               ; preds = %67
  %71 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 1
  %72 = mul nuw nsw i64 %60, 128
  %73 = add nuw nsw i64 %72, %68
  %74 = getelementptr inbounds float, ptr %71, i64 %73
  %75 = load float, ptr %74, align 4
  %76 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, 1
  %77 = mul nuw nsw i64 %68, 128
  %78 = add nuw nsw i64 %77, %64
  %79 = getelementptr inbounds float, ptr %76, i64 %78
  %80 = load float, ptr %79, align 4
  %81 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 1
  %82 = mul nuw nsw i64 %60, 128
  %83 = add nuw nsw i64 %82, %64
  %84 = getelementptr inbounds float, ptr %81, i64 %83
  %85 = load float, ptr %84, align 4
  %86 = fmul float %75, %80
  %87 = fadd float %85, %86
  %88 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 1
  %89 = mul nuw nsw i64 %60, 128
  %90 = add nuw nsw i64 %89, %64
  %91 = getelementptr inbounds float, ptr %88, i64 %90
  store float %87, ptr %91, align 4
  %92 = add i64 %68, 1
  br label %67

93:                                               ; preds = %67
  %94 = add i64 %64, 1
  br label %63

95:                                               ; preds = %63
  %96 = add i64 %60, 1
  br label %59

97:                                               ; preds = %59
  ret void
}

define void @_mlir_ciface_main(ptr %0, ptr %1, ptr %2) {
  %4 = load { ptr, ptr, i64, [2 x i64], [2 x i64] }, ptr %0, align 8
  %5 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, 0
  %6 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, 1
  %7 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, 2
  %8 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, 3, 0
  %9 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, 3, 1
  %10 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, 4, 0
  %11 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, 4, 1
  %12 = load { ptr, ptr, i64, [2 x i64], [2 x i64] }, ptr %1, align 8
  %13 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, 0
  %14 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, 1
  %15 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, 2
  %16 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, 3, 0
  %17 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, 3, 1
  %18 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, 4, 0
  %19 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, 4, 1
  %20 = load { ptr, ptr, i64, [2 x i64], [2 x i64] }, ptr %2, align 8
  %21 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, 0
  %22 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, 1
  %23 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, 2
  %24 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, 3, 0
  %25 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, 3, 1
  %26 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, 4, 0
  %27 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, 4, 1
  call void @main(ptr %5, ptr %6, i64 %7, i64 %8, i64 %9, i64 %10, i64 %11, ptr %13, ptr %14, i64 %15, i64 %16, i64 %17, i64 %18, i64 %19, ptr %21, ptr %22, i64 %23, i64 %24, i64 %25, i64 %26, i64 %27)
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
