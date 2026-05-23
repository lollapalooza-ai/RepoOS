; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define void @betweenness_betweenness_centrality_chunk_0(ptr %0, ptr %1, ptr %2, ptr %3, ptr %4, ptr %5, ptr %6, ptr %7, i64 %8) {
  br label %10

10:                                               ; preds = %134, %9
  %11 = phi i64 [ %135, %134 ], [ 0, %9 ]
  %12 = icmp slt i64 %11, %8
  br i1 %12, label %13, label %136

13:                                               ; preds = %10
  br label %14

14:                                               ; preds = %17, %13
  %15 = phi i64 [ %21, %17 ], [ 0, %13 ]
  %16 = icmp slt i64 %15, %8
  br i1 %16, label %17, label %22

17:                                               ; preds = %14
  %18 = getelementptr double, ptr %3, i64 %15
  store i64 -1, ptr %18, align 4
  %19 = getelementptr double, ptr %4, i64 %15
  store double 0.000000e+00, ptr %19, align 8
  %20 = getelementptr double, ptr %7, i64 %15
  store double 0.000000e+00, ptr %20, align 8
  %21 = add i64 %15, 1
  br label %14

22:                                               ; preds = %14
  %23 = getelementptr double, ptr %4, i64 %11
  store double 1.000000e+00, ptr %23, align 8
  %24 = getelementptr double, ptr %3, i64 %11
  store i64 0, ptr %24, align 4
  store i64 %11, ptr %6, align 4
  br label %25

25:                                               ; preds = %81, %22
  %26 = phi i64 [ %82, %81 ], [ 0, %22 ]
  %27 = phi i64 [ %78, %81 ], [ 0, %22 ]
  %28 = phi i64 [ %79, %81 ], [ 1, %22 ]
  %29 = phi i64 [ %80, %81 ], [ 0, %22 ]
  %30 = icmp slt i64 %26, %8
  br i1 %30, label %31, label %83

31:                                               ; preds = %25
  %32 = icmp eq i64 %27, %28
  br i1 %32, label %33, label %34

33:                                               ; preds = %31
  br label %77

34:                                               ; preds = %31
  %35 = getelementptr double, ptr %6, i64 %27
  %36 = load i64, ptr %35, align 4
  %37 = getelementptr double, ptr %5, i64 %29
  store i64 %36, ptr %37, align 4
  %38 = add i64 %29, 1
  %39 = getelementptr double, ptr %3, i64 %36
  %40 = load i64, ptr %39, align 4
  %41 = add i64 %40, 1
  %42 = getelementptr double, ptr %4, i64 %36
  %43 = load double, ptr %42, align 8
  %44 = getelementptr double, ptr %1, i64 %36
  %45 = load i64, ptr %44, align 4
  %46 = add i64 %36, 1
  %47 = getelementptr double, ptr %1, i64 %46
  %48 = load i64, ptr %47, align 4
  br label %49

49:                                               ; preds = %73, %34
  %50 = phi i64 [ %74, %73 ], [ %45, %34 ]
  %51 = phi i64 [ %64, %73 ], [ %28, %34 ]
  %52 = icmp slt i64 %50, %48
  br i1 %52, label %53, label %75

53:                                               ; preds = %49
  %54 = getelementptr double, ptr %2, i64 %50
  %55 = load i64, ptr %54, align 4
  %56 = getelementptr double, ptr %3, i64 %55
  %57 = load i64, ptr %56, align 4
  %58 = icmp eq i64 %57, -1
  br i1 %58, label %59, label %62

59:                                               ; preds = %53
  store i64 %41, ptr %56, align 4
  %60 = getelementptr double, ptr %6, i64 %51
  store i64 %55, ptr %60, align 4
  %61 = add i64 %51, 1
  br label %63

62:                                               ; preds = %53
  br label %63

63:                                               ; preds = %59, %62
  %64 = phi i64 [ %51, %62 ], [ %61, %59 ]
  br label %65

65:                                               ; preds = %63
  %66 = load i64, ptr %56, align 4
  %67 = icmp eq i64 %66, %41
  br i1 %67, label %68, label %72

68:                                               ; preds = %65
  %69 = getelementptr double, ptr %4, i64 %55
  %70 = load double, ptr %69, align 8
  %71 = fadd double %70, %43
  store double %71, ptr %69, align 8
  br label %73

72:                                               ; preds = %65
  br label %73

73:                                               ; preds = %68, %72
  %74 = add i64 %50, 1
  br label %49

75:                                               ; preds = %49
  %76 = add i64 %27, 1
  br label %77

77:                                               ; preds = %33, %75
  %78 = phi i64 [ %76, %75 ], [ %27, %33 ]
  %79 = phi i64 [ %51, %75 ], [ %28, %33 ]
  %80 = phi i64 [ %38, %75 ], [ %29, %33 ]
  br label %81

81:                                               ; preds = %77
  %82 = add i64 %26, 1
  br label %25

83:                                               ; preds = %25
  br label %84

84:                                               ; preds = %132, %83
  %85 = phi i64 [ %133, %132 ], [ 0, %83 ]
  %86 = icmp slt i64 %85, %29
  br i1 %86, label %87, label %134

87:                                               ; preds = %84
  %88 = sub i64 %29, 1
  %89 = sub i64 %88, %85
  %90 = getelementptr double, ptr %5, i64 %89
  %91 = load i64, ptr %90, align 4
  %92 = getelementptr double, ptr %3, i64 %91
  %93 = load i64, ptr %92, align 4
  %94 = sub i64 %93, 1
  %95 = getelementptr double, ptr %7, i64 %91
  %96 = load double, ptr %95, align 8
  %97 = getelementptr double, ptr %4, i64 %91
  %98 = load double, ptr %97, align 8
  %99 = fadd double %96, 1.000000e+00
  %100 = fdiv double %99, %98
  %101 = getelementptr double, ptr %1, i64 %91
  %102 = load i64, ptr %101, align 4
  %103 = add i64 %91, 1
  %104 = getelementptr double, ptr %1, i64 %103
  %105 = load i64, ptr %104, align 4
  br label %106

106:                                              ; preds = %123, %87
  %107 = phi i64 [ %124, %123 ], [ %102, %87 ]
  %108 = icmp slt i64 %107, %105
  br i1 %108, label %109, label %125

109:                                              ; preds = %106
  %110 = getelementptr double, ptr %2, i64 %107
  %111 = load i64, ptr %110, align 4
  %112 = getelementptr double, ptr %3, i64 %111
  %113 = load i64, ptr %112, align 4
  %114 = icmp eq i64 %113, %94
  br i1 %114, label %115, label %122

115:                                              ; preds = %109
  %116 = getelementptr double, ptr %4, i64 %111
  %117 = load double, ptr %116, align 8
  %118 = fmul double %117, %100
  %119 = getelementptr double, ptr %7, i64 %111
  %120 = load double, ptr %119, align 8
  %121 = fadd double %120, %118
  store double %121, ptr %119, align 8
  br label %123

122:                                              ; preds = %109
  br label %123

123:                                              ; preds = %115, %122
  %124 = add i64 %107, 1
  br label %106

125:                                              ; preds = %106
  %126 = icmp ne i64 %91, %11
  br i1 %126, label %127, label %131

127:                                              ; preds = %125
  %128 = getelementptr double, ptr %0, i64 %91
  %129 = load double, ptr %128, align 8
  %130 = fadd double %129, %96
  store double %130, ptr %128, align 8
  br label %132

131:                                              ; preds = %125
  br label %132

132:                                              ; preds = %127, %131
  %133 = add i64 %85, 1
  br label %84

134:                                              ; preds = %84
  %135 = add i64 %11, 1
  br label %10

136:                                              ; preds = %10
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
