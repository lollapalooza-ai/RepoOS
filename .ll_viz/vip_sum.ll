; ModuleID = "zero_copy_precision_lexer"
target triple = "unknown-unknown-unknown"
target datalayout = ""

define double @"vectorized_vip_sum"(i8* %".1", i32 %".2")
{
entry:
  %"idx_p" = alloca i32
  store i32 0, i32* %"idx_p"
  %"sum_p" = alloca double
  store double              0x0, double* %"sum_p"
  %"vip_p" = alloca i1
  store i1 0, i1* %"vip_p"
  %"v_idx_p" = alloca i32
  %"acc_p" = alloca double
  %"dot_p" = alloca i1
  %"div_p" = alloca double
  br label %"loop_cond"
loop_cond:
  %".8" = load i32, i32* %"idx_p"
  %".9" = sub i32 %".2", 64
  %".10" = icmp sge i32 %".8", %".9"
  br i1 %".10", label %"exit", label %"loop_body"
loop_body:
  %".12" = getelementptr i8, i8* %".1", i32 %".8"
  %".13" = load i8, i8* %".12"
  %".14" = icmp eq i8 %".13", 34
  br i1 %".14", label %"loop_body.if", label %"loop_body.endif"
exit:
  %".232" = load double, double* %"sum_p"
  ret double %".232"
loop_body.if:
  %".16" = add i32 %".8", 1
  %".17" = getelementptr i8, i8* %".1", i32 %".16"
  %".18" = load i8, i8* %".17"
  %".19" = icmp eq i8 %".18", 105
  %".20" = and i1 1, %".19"
  %".21" = add i32 %".8", 2
  %".22" = getelementptr i8, i8* %".1", i32 %".21"
  %".23" = load i8, i8* %".22"
  %".24" = icmp eq i8 %".23", 115
  %".25" = and i1 %".20", %".24"
  %".26" = add i32 %".8", 3
  %".27" = getelementptr i8, i8* %".1", i32 %".26"
  %".28" = load i8, i8* %".27"
  %".29" = icmp eq i8 %".28", 95
  %".30" = and i1 %".25", %".29"
  %".31" = add i32 %".8", 4
  %".32" = getelementptr i8, i8* %".1", i32 %".31"
  %".33" = load i8, i8* %".32"
  %".34" = icmp eq i8 %".33", 118
  %".35" = and i1 %".30", %".34"
  %".36" = add i32 %".8", 5
  %".37" = getelementptr i8, i8* %".1", i32 %".36"
  %".38" = load i8, i8* %".37"
  %".39" = icmp eq i8 %".38", 105
  %".40" = and i1 %".35", %".39"
  %".41" = add i32 %".8", 6
  %".42" = getelementptr i8, i8* %".1", i32 %".41"
  %".43" = load i8, i8* %".42"
  %".44" = icmp eq i8 %".43", 112
  %".45" = and i1 %".40", %".44"
  %".46" = add i32 %".8", 7
  %".47" = getelementptr i8, i8* %".1", i32 %".46"
  %".48" = load i8, i8* %".47"
  %".49" = icmp eq i8 %".48", 34
  %".50" = and i1 %".45", %".49"
  %".51" = add i32 %".8", 8
  %".52" = getelementptr i8, i8* %".1", i32 %".51"
  %".53" = load i8, i8* %".52"
  %".54" = icmp eq i8 %".53", 58
  %".55" = and i1 %".50", %".54"
  %".56" = add i32 %".8", 9
  %".57" = getelementptr i8, i8* %".1", i32 %".56"
  %".58" = load i8, i8* %".57"
  %".59" = icmp eq i8 %".58", 116
  %".60" = and i1 %".55", %".59"
  br i1 %".60", label %"loop_body.if.if", label %"loop_body.if.endif"
loop_body.endif:
  %".228" = load i32, i32* %"idx_p"
  %".229" = add i32 %".228", 1
  store i32 %".229", i32* %"idx_p"
  br label %"loop_cond"
loop_body.if.if:
  store i1 1, i1* %"vip_p"
  br label %"loop_body.if.endif"
loop_body.if.endif:
  %".64" = add i32 %".8", 1
  %".65" = getelementptr i8, i8* %".1", i32 %".64"
  %".66" = load i8, i8* %".65"
  %".67" = icmp eq i8 %".66", 105
  %".68" = and i1 1, %".67"
  %".69" = add i32 %".8", 2
  %".70" = getelementptr i8, i8* %".1", i32 %".69"
  %".71" = load i8, i8* %".70"
  %".72" = icmp eq i8 %".71", 115
  %".73" = and i1 %".68", %".72"
  %".74" = add i32 %".8", 3
  %".75" = getelementptr i8, i8* %".1", i32 %".74"
  %".76" = load i8, i8* %".75"
  %".77" = icmp eq i8 %".76", 95
  %".78" = and i1 %".73", %".77"
  %".79" = add i32 %".8", 4
  %".80" = getelementptr i8, i8* %".1", i32 %".79"
  %".81" = load i8, i8* %".80"
  %".82" = icmp eq i8 %".81", 118
  %".83" = and i1 %".78", %".82"
  %".84" = add i32 %".8", 5
  %".85" = getelementptr i8, i8* %".1", i32 %".84"
  %".86" = load i8, i8* %".85"
  %".87" = icmp eq i8 %".86", 105
  %".88" = and i1 %".83", %".87"
  %".89" = add i32 %".8", 6
  %".90" = getelementptr i8, i8* %".1", i32 %".89"
  %".91" = load i8, i8* %".90"
  %".92" = icmp eq i8 %".91", 112
  %".93" = and i1 %".88", %".92"
  %".94" = add i32 %".8", 7
  %".95" = getelementptr i8, i8* %".1", i32 %".94"
  %".96" = load i8, i8* %".95"
  %".97" = icmp eq i8 %".96", 34
  %".98" = and i1 %".93", %".97"
  %".99" = add i32 %".8", 8
  %".100" = getelementptr i8, i8* %".1", i32 %".99"
  %".101" = load i8, i8* %".100"
  %".102" = icmp eq i8 %".101", 58
  %".103" = and i1 %".98", %".102"
  %".104" = add i32 %".8", 9
  %".105" = getelementptr i8, i8* %".1", i32 %".104"
  %".106" = load i8, i8* %".105"
  %".107" = icmp eq i8 %".106", 102
  %".108" = and i1 %".103", %".107"
  br i1 %".108", label %"loop_body.if.endif.if", label %"loop_body.if.endif.endif"
loop_body.if.endif.if:
  store i1 0, i1* %"vip_p"
  br label %"loop_body.if.endif.endif"
loop_body.if.endif.endif:
  %".112" = add i32 %".8", 1
  %".113" = getelementptr i8, i8* %".1", i32 %".112"
  %".114" = load i8, i8* %".113"
  %".115" = icmp eq i8 %".114", 116
  %".116" = and i1 1, %".115"
  %".117" = add i32 %".8", 2
  %".118" = getelementptr i8, i8* %".1", i32 %".117"
  %".119" = load i8, i8* %".118"
  %".120" = icmp eq i8 %".119", 111
  %".121" = and i1 %".116", %".120"
  %".122" = add i32 %".8", 3
  %".123" = getelementptr i8, i8* %".1", i32 %".122"
  %".124" = load i8, i8* %".123"
  %".125" = icmp eq i8 %".124", 116
  %".126" = and i1 %".121", %".125"
  %".127" = add i32 %".8", 4
  %".128" = getelementptr i8, i8* %".1", i32 %".127"
  %".129" = load i8, i8* %".128"
  %".130" = icmp eq i8 %".129", 97
  %".131" = and i1 %".126", %".130"
  %".132" = add i32 %".8", 5
  %".133" = getelementptr i8, i8* %".1", i32 %".132"
  %".134" = load i8, i8* %".133"
  %".135" = icmp eq i8 %".134", 108
  %".136" = and i1 %".131", %".135"
  %".137" = add i32 %".8", 6
  %".138" = getelementptr i8, i8* %".1", i32 %".137"
  %".139" = load i8, i8* %".138"
  %".140" = icmp eq i8 %".139", 95
  %".141" = and i1 %".136", %".140"
  %".142" = add i32 %".8", 7
  %".143" = getelementptr i8, i8* %".1", i32 %".142"
  %".144" = load i8, i8* %".143"
  %".145" = icmp eq i8 %".144", 118
  %".146" = and i1 %".141", %".145"
  %".147" = add i32 %".8", 8
  %".148" = getelementptr i8, i8* %".1", i32 %".147"
  %".149" = load i8, i8* %".148"
  %".150" = icmp eq i8 %".149", 97
  %".151" = and i1 %".146", %".150"
  %".152" = add i32 %".8", 9
  %".153" = getelementptr i8, i8* %".1", i32 %".152"
  %".154" = load i8, i8* %".153"
  %".155" = icmp eq i8 %".154", 108
  %".156" = and i1 %".151", %".155"
  %".157" = add i32 %".8", 10
  %".158" = getelementptr i8, i8* %".1", i32 %".157"
  %".159" = load i8, i8* %".158"
  %".160" = icmp eq i8 %".159", 117
  %".161" = and i1 %".156", %".160"
  %".162" = add i32 %".8", 11
  %".163" = getelementptr i8, i8* %".1", i32 %".162"
  %".164" = load i8, i8* %".163"
  %".165" = icmp eq i8 %".164", 101
  %".166" = and i1 %".161", %".165"
  %".167" = add i32 %".8", 12
  %".168" = getelementptr i8, i8* %".1", i32 %".167"
  %".169" = load i8, i8* %".168"
  %".170" = icmp eq i8 %".169", 34
  %".171" = and i1 %".166", %".170"
  %".172" = add i32 %".8", 13
  %".173" = getelementptr i8, i8* %".1", i32 %".172"
  %".174" = load i8, i8* %".173"
  %".175" = icmp eq i8 %".174", 58
  %".176" = and i1 %".171", %".175"
  br i1 %".176", label %"loop_body.if.endif.endif.if", label %"loop_body.if.endif.endif.endif"
loop_body.if.endif.endif.if:
  %".178" = add i32 %".8", 14
  store i32 %".178", i32* %"v_idx_p"
  store double              0x0, double* %"acc_p"
  store i1 0, i1* %"dot_p"
  store double 0x3fb999999999999a, double* %"div_p"
  br label %"p_cond"
loop_body.if.endif.endif.endif:
  br label %"loop_body.endif"
p_cond:
  %".184" = load i32, i32* %"v_idx_p"
  %".185" = getelementptr i8, i8* %".1", i32 %".184"
  %".186" = load i8, i8* %".185"
  %".187" = icmp uge i8 %".186", 48
  %".188" = icmp ule i8 %".186", 57
  %".189" = and i1 %".187", %".188"
  %".190" = icmp eq i8 %".186", 46
  %".191" = or i1 %".189", %".190"
  br i1 %".191", label %"p_body", label %"p_end"
p_body:
  br i1 %".190", label %"p_body.if", label %"p_body.else"
p_end:
  %".217" = load i1, i1* %"vip_p"
  br i1 %".217", label %"p_end.if", label %"p_end.endif"
p_body.if:
  store i1 1, i1* %"dot_p"
  br label %"p_body.endif"
p_body.else:
  %".196" = sub i8 %".186", 48
  %".197" = uitofp i8 %".196" to double
  %".198" = load i1, i1* %"dot_p"
  br i1 %".198", label %"p_body.else.if", label %"p_body.else.else"
p_body.endif:
  %".214" = add i32 %".184", 1
  store i32 %".214", i32* %"v_idx_p"
  br label %"p_cond"
p_body.else.if:
  %".200" = load double, double* %"div_p"
  %".201" = load double, double* %"acc_p"
  %".202" = fmul double %".197", %".200"
  %".203" = fadd double %".201", %".202"
  store double %".203", double* %"acc_p"
  %".205" = fmul double %".200", 0x3fb999999999999a
  store double %".205", double* %"div_p"
  br label %"p_body.else.endif"
p_body.else.else:
  %".208" = load double, double* %"acc_p"
  %".209" = fmul double %".208", 0x4024000000000000
  %".210" = fadd double %".209", %".197"
  store double %".210", double* %"acc_p"
  br label %"p_body.else.endif"
p_body.else.endif:
  br label %"p_body.endif"
p_end.if:
  %".219" = load double, double* %"sum_p"
  %".220" = load double, double* %"acc_p"
  %".221" = fadd double %".219", %".220"
  store double %".221", double* %"sum_p"
  br label %"p_end.endif"
p_end.endif:
  %".224" = load i32, i32* %"v_idx_p"
  store i32 %".224", i32* %"idx_p"
  br label %"loop_cond"
}
