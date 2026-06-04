; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@assert_msg = private constant [40 x i8] c"unimplemented: tensor with zero element\00"

declare ptr @malloc(i64)

declare void @abort()

declare void @puts(ptr)

define void @main(ptr %0, ptr %1, ptr %2, ptr %3) {
  %5 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %0, 0
  %6 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5, ptr %0, 1
  %7 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %6, i64 0, 2
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %7, i64 3, 3, 0
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, i64 3, 4, 0
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 3, 3, 1
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, i64 1, 4, 1
  %12 = call ptr @malloc(i64 76)
  %13 = ptrtoint ptr %12 to i64
  %14 = add i64 %13, 63
  %15 = urem i64 %14, 64
  %16 = sub i64 %14, %15
  %17 = inttoptr i64 %16 to ptr
  %18 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %12, 0
  %19 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %18, ptr %17, 1
  %20 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %19, i64 0, 2
  %21 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %20, i64 3, 3, 0
  %22 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %21, i64 1, 4, 0
  br label %23

23:                                               ; preds = %26, %4
  %24 = phi i64 [ %29, %26 ], [ 0, %4 ]
  %25 = icmp slt i64 %24, 3
  br i1 %25, label %26, label %30

26:                                               ; preds = %23
  %27 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %22, 1
  %28 = getelementptr inbounds nuw float, ptr %27, i64 %24
  store float 0.000000e+00, ptr %28, align 4
  %29 = add i64 %24, 1
  br label %23

30:                                               ; preds = %23
  br label %31

31:                                               ; preds = %51, %30
  %32 = phi i64 [ %52, %51 ], [ 0, %30 ]
  %33 = icmp slt i64 %32, 3
  br i1 %33, label %34, label %53

34:                                               ; preds = %31
  br label %35

35:                                               ; preds = %38, %34
  %36 = phi i64 [ %50, %38 ], [ 0, %34 ]
  %37 = icmp slt i64 %36, 3
  br i1 %37, label %38, label %51

38:                                               ; preds = %35
  %39 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, 1
  %40 = mul nuw nsw i64 %32, 3
  %41 = add nuw nsw i64 %40, %36
  %42 = getelementptr inbounds nuw float, ptr %39, i64 %41
  %43 = load float, ptr %42, align 4
  %44 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %22, 1
  %45 = getelementptr inbounds nuw float, ptr %44, i64 %32
  %46 = load float, ptr %45, align 4
  %47 = fadd float %43, %46
  %48 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %22, 1
  %49 = getelementptr inbounds nuw float, ptr %48, i64 %32
  store float %47, ptr %49, align 4
  %50 = add i64 %36, 1
  br label %35

51:                                               ; preds = %35
  %52 = add i64 %32, 1
  br label %31

53:                                               ; preds = %31
  br label %54

54:                                               ; preds = %62, %53
  %55 = phi i64 [ %66, %62 ], [ 0, %53 ]
  %56 = icmp slt i64 %55, 3
  br i1 %56, label %57, label %67

57:                                               ; preds = %54
  %58 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %22, 1
  %59 = getelementptr inbounds nuw float, ptr %58, i64 %55
  %60 = load float, ptr %59, align 4
  %61 = fcmp one float %60, 0.000000e+00
  br i1 %61, label %62, label %68

62:                                               ; preds = %57
  %63 = fdiv float 1.000000e+00, %60
  %64 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %22, 1
  %65 = getelementptr inbounds nuw float, ptr %64, i64 %55
  store float %63, ptr %65, align 4
  %66 = add i64 %55, 1
  br label %54

67:                                               ; preds = %54
  ret void

68:                                               ; preds = %57
  call void @puts(ptr @assert_msg)
  call void @abort()
  unreachable
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
