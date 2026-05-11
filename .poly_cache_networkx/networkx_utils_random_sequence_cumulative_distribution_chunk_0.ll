; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define void @networkx_utils_random_sequence_cumulative_distribution_chunk_0(ptr %0, ptr %1, ptr %2, i64 %3) {
  br label %5

5:                                                ; preds = %9, %4
  %6 = phi i64 [ %13, %9 ], [ 0, %4 ]
  %7 = phi double [ %12, %9 ], [ 0.000000e+00, %4 ]
  %8 = icmp slt i64 %6, %3
  br i1 %8, label %9, label %14

9:                                                ; preds = %5
  %10 = getelementptr double, ptr %1, i64 %6
  %11 = load double, ptr %10, align 8
  %12 = fadd double %7, %11
  %13 = add i64 %6, 1
  br label %5

14:                                               ; preds = %5
  store double 0.000000e+00, ptr %2, align 8
  br label %15

15:                                               ; preds = %19, %14
  %16 = phi i64 [ %26, %19 ], [ 0, %14 ]
  %17 = phi double [ %22, %19 ], [ 0.000000e+00, %14 ]
  %18 = icmp slt i64 %16, %3
  br i1 %18, label %19, label %27

19:                                               ; preds = %15
  %20 = getelementptr double, ptr %1, i64 %16
  %21 = load double, ptr %20, align 8
  %22 = fadd double %17, %21
  %23 = fdiv double %22, %7
  %24 = add i64 %16, 1
  %25 = getelementptr double, ptr %2, i64 %24
  store double %23, ptr %25, align 8
  %26 = add i64 %16, 1
  br label %15

27:                                               ; preds = %15
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
