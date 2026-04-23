; ModuleID = '<string>'
source_filename = "<string>"
target triple = "arm64-apple-darwin25.2.0"

@str_3550224683375522313 = internal global [6 x i8] c"\22run\22\00"
@str_8530701029840297950 = internal global [6 x i8] c"\22get\22\00"

define double @fsm() {
entry:
  br label %L_LOOP_START

L_LOOP_START:                                     ; preds = %L_CONTINUE, %entry
  %i_slot.0 = phi double [ 0.000000e+00, %entry ], [ %.47, %L_CONTINUE ]
  %.16 = fcmp olt double %i_slot.0, 0.000000e+00
  br i1 %.16, label %L_CONTINUE, label %L_EXIT

L_CONTINUE:                                       ; preds = %L_LOOP_START
  %.47 = fadd double %i_slot.0, 1.000000e+00
  br label %L_LOOP_START

L_EXIT:                                           ; preds = %L_LOOP_START
  ret double 0.000000e+00
}

declare i32 @strcmp(i8*, i8*)
