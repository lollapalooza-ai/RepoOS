; ModuleID = '<string>'
source_filename = "<string>"
target triple = "arm64-apple-darwin25.2.0"

@str_8230480194049562947 = internal global [15 x i8] c"\22is_vip\22: true\00"
@str_7922747793756604102 = internal global [16 x i8] c"\22total_value\22: \00"

define double @calculate_vip_revenue_fsm(i8* %.1, i32 %.2) {
entry:
  br label %scan_loop

scan_loop:                                        ; preds = %next_idx, %extract, %inner_inc, %entry
  %total_slot.0 = phi double [ 0.000000e+00, %entry ], [ %.82, %extract ], [ %total_slot.0, %inner_inc ], [ %total_slot.0, %next_idx ]
  %idx_slot.0 = phi double [ 0.000000e+00, %entry ], [ %.85, %extract ], [ %.59, %inner_inc ], [ %.89, %next_idx ]
  %.13 = sitofp i32 %.2 to double
  %.14 = fcmp olt double %idx_slot.0, %.13
  br i1 %.14, label %check_vip, label %done

check_vip:                                        ; preds = %scan_loop
  %.22 = fptosi double %idx_slot.0 to i32
  %0 = sext i32 %.22 to i64
  %.23 = getelementptr i8, i8* %.1, i64 %0
  %.27 = call i32 @strcmp(i8* noundef nonnull dereferenceable(1) %.23, i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([15 x i8], [15 x i8]* @str_8230480194049562947, i64 0, i64 0))
  %.31 = icmp eq i32 %.27, 1
  br i1 %.31, label %find_value, label %next_idx

find_value:                                       ; preds = %check_vip
  %.38 = fadd double %idx_slot.0, 1.000000e+02
  br label %inner_loop

inner_loop:                                       ; preds = %inner_inc, %find_value
  %idx_slot.1 = phi double [ %idx_slot.0, %find_value ], [ %.59, %inner_inc ]
  %.43 = fptosi double %idx_slot.1 to i32
  %1 = sext i32 %.43 to i64
  %.44 = getelementptr i8, i8* %.1, i64 %1
  %.48 = call i32 @strcmp(i8* noundef nonnull dereferenceable(1) %.44, i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @str_7922747793756604102, i64 0, i64 0))
  %.52 = icmp eq i32 %.48, 1
  br i1 %.52, label %extract, label %inner_inc

inner_inc:                                        ; preds = %inner_loop
  %.59 = fadd double %idx_slot.1, 1.000000e+00
  %.63 = fcmp olt double %.59, %.38
  br i1 %.63, label %inner_loop, label %scan_loop

extract:                                          ; preds = %inner_loop
  %.70 = fadd double %idx_slot.1, 1.500000e+01
  %.74 = fptosi double %.70 to i32
  %2 = sext i32 %.74 to i64
  %.75 = getelementptr i8, i8* %.1, i64 %2
  %.78 = call double @atof(i8* %.75)
  %.82 = fadd double %total_slot.0, %.78
  %.85 = fadd double %idx_slot.1, 1.000000e+02
  br label %scan_loop

next_idx:                                         ; preds = %check_vip
  %.89 = fadd double %idx_slot.0, 1.000000e+00
  br label %scan_loop

done:                                             ; preds = %scan_loop
  %.93 = fadd double %total_slot.0, 0.000000e+00
  ret double %.93
}

declare i32 @strcmp(i8*, i8*)

declare double @atof(i8*)
