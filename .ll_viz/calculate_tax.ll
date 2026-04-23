; ModuleID = '<string>'
source_filename = "<string>"
target triple = "arm64-apple-darwin25.2.0"

@str_56569424925173024 = internal global [3 x i8] c"CA\00"
@str_1630747923617728598 = internal global [3 x i8] c"NY\00"

define double @calculate_tax(double %.1, i8* %.2) {
entry:
  %.8 = call i32 @strcmp(i8* noundef nonnull dereferenceable(1) %.2, i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([3 x i8], [3 x i8]* @str_56569424925173024, i64 0, i64 0))
  %.12 = icmp eq i32 %.8, 0
  br i1 %.12, label %then_ca, label %if_ny_check

then_ca:                                          ; preds = %entry
  %.19 = fmul double %.1, 8.000000e-02
  br label %end

if_ny_check:                                      ; preds = %entry
  %.27 = call i32 @strcmp(i8* noundef nonnull dereferenceable(1) %.2, i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([3 x i8], [3 x i8]* @str_1630747923617728598, i64 0, i64 0))
  %.31 = icmp eq i32 %.27, 0
  %.38 = fmul double %.1, 4.000000e-02
  %spec.select = select i1 %.31, double %.38, double 0.000000e+00
  br label %end

end:                                              ; preds = %if_ny_check, %then_ca
  %result_storage.sroa.0.0 = phi double [ %.19, %then_ca ], [ %spec.select, %if_ny_check ]
  ret double %result_storage.sroa.0.0
}

declare i32 @strcmp(i8*, i8*)
