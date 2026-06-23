; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define void @main(ptr %0, ptr %1, ptr %2) {
  %4 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %2, 0
  %5 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4, ptr %2, 1
  %6 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5, i64 0, 2
  %7 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %6, i64 4096, 3, 0
  %8 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %7, i64 4096, 4, 0
  %9 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8, i64 4096, 3, 1
  %10 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %9, i64 1, 4, 1
  %11 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %1, 0
  %12 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %11, ptr %1, 1
  %13 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %12, i64 0, 2
  %14 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %13, i64 4096, 3, 0
  %15 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %14, i64 4096, 4, 0
  %16 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %15, i64 4096, 3, 1
  %17 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %16, i64 1, 4, 1
  %18 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %0, 0
  %19 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %18, ptr %0, 1
  %20 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %19, i64 0, 2
  %21 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, i64 4096, 3, 0
  %22 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, i64 4096, 4, 0
  %23 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, i64 4096, 3, 1
  %24 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %23, i64 1, 4, 1
  %25 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %26 = getelementptr float, ptr %25, i64 0
  store <4096 x float> zeroinitializer, ptr %26, align 4
  %27 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %28 = getelementptr float, ptr %27, i64 4096
  store <4096 x float> zeroinitializer, ptr %28, align 4
  %29 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %30 = getelementptr float, ptr %29, i64 8192
  store <4096 x float> zeroinitializer, ptr %30, align 4
  %31 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %32 = getelementptr float, ptr %31, i64 12288
  store <4096 x float> zeroinitializer, ptr %32, align 4
  %33 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %34 = getelementptr float, ptr %33, i64 16384
  store <4096 x float> zeroinitializer, ptr %34, align 4
  %35 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %36 = getelementptr float, ptr %35, i64 20480
  store <4096 x float> zeroinitializer, ptr %36, align 4
  %37 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %38 = getelementptr float, ptr %37, i64 24576
  store <4096 x float> zeroinitializer, ptr %38, align 4
  %39 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %40 = getelementptr float, ptr %39, i64 28672
  store <4096 x float> zeroinitializer, ptr %40, align 4
  %41 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %42 = getelementptr float, ptr %41, i64 32768
  store <4096 x float> zeroinitializer, ptr %42, align 4
  %43 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %44 = getelementptr float, ptr %43, i64 36864
  store <4096 x float> zeroinitializer, ptr %44, align 4
  %45 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %46 = getelementptr float, ptr %45, i64 40960
  store <4096 x float> zeroinitializer, ptr %46, align 4
  %47 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %48 = getelementptr float, ptr %47, i64 45056
  store <4096 x float> zeroinitializer, ptr %48, align 4
  %49 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %50 = getelementptr float, ptr %49, i64 49152
  store <4096 x float> zeroinitializer, ptr %50, align 4
  %51 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %52 = getelementptr float, ptr %51, i64 53248
  store <4096 x float> zeroinitializer, ptr %52, align 4
  %53 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %54 = getelementptr float, ptr %53, i64 57344
  store <4096 x float> zeroinitializer, ptr %54, align 4
  %55 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %56 = getelementptr float, ptr %55, i64 61440
  store <4096 x float> zeroinitializer, ptr %56, align 4
  %57 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %58 = getelementptr float, ptr %57, i64 65536
  store <4096 x float> zeroinitializer, ptr %58, align 4
  %59 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %60 = getelementptr float, ptr %59, i64 69632
  store <4096 x float> zeroinitializer, ptr %60, align 4
  %61 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %62 = getelementptr float, ptr %61, i64 73728
  store <4096 x float> zeroinitializer, ptr %62, align 4
  %63 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %64 = getelementptr float, ptr %63, i64 77824
  store <4096 x float> zeroinitializer, ptr %64, align 4
  %65 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %66 = getelementptr float, ptr %65, i64 81920
  store <4096 x float> zeroinitializer, ptr %66, align 4
  %67 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %68 = getelementptr float, ptr %67, i64 86016
  store <4096 x float> zeroinitializer, ptr %68, align 4
  %69 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %70 = getelementptr float, ptr %69, i64 90112
  store <4096 x float> zeroinitializer, ptr %70, align 4
  %71 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %72 = getelementptr float, ptr %71, i64 94208
  store <4096 x float> zeroinitializer, ptr %72, align 4
  %73 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %74 = getelementptr float, ptr %73, i64 98304
  store <4096 x float> zeroinitializer, ptr %74, align 4
  %75 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %76 = getelementptr float, ptr %75, i64 102400
  store <4096 x float> zeroinitializer, ptr %76, align 4
  %77 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %78 = getelementptr float, ptr %77, i64 106496
  store <4096 x float> zeroinitializer, ptr %78, align 4
  %79 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %80 = getelementptr float, ptr %79, i64 110592
  store <4096 x float> zeroinitializer, ptr %80, align 4
  %81 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %82 = getelementptr float, ptr %81, i64 114688
  store <4096 x float> zeroinitializer, ptr %82, align 4
  %83 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %84 = getelementptr float, ptr %83, i64 118784
  store <4096 x float> zeroinitializer, ptr %84, align 4
  %85 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %86 = getelementptr float, ptr %85, i64 122880
  store <4096 x float> zeroinitializer, ptr %86, align 4
  %87 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %88 = getelementptr float, ptr %87, i64 126976
  store <4096 x float> zeroinitializer, ptr %88, align 4
  %89 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %90 = getelementptr float, ptr %89, i64 131072
  store <4096 x float> zeroinitializer, ptr %90, align 4
  %91 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %92 = getelementptr float, ptr %91, i64 135168
  store <4096 x float> zeroinitializer, ptr %92, align 4
  %93 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %94 = getelementptr float, ptr %93, i64 139264
  store <4096 x float> zeroinitializer, ptr %94, align 4
  %95 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %96 = getelementptr float, ptr %95, i64 143360
  store <4096 x float> zeroinitializer, ptr %96, align 4
  %97 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %98 = getelementptr float, ptr %97, i64 147456
  store <4096 x float> zeroinitializer, ptr %98, align 4
  %99 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %100 = getelementptr float, ptr %99, i64 151552
  store <4096 x float> zeroinitializer, ptr %100, align 4
  %101 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %102 = getelementptr float, ptr %101, i64 155648
  store <4096 x float> zeroinitializer, ptr %102, align 4
  %103 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %104 = getelementptr float, ptr %103, i64 159744
  store <4096 x float> zeroinitializer, ptr %104, align 4
  %105 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %106 = getelementptr float, ptr %105, i64 163840
  store <4096 x float> zeroinitializer, ptr %106, align 4
  %107 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %108 = getelementptr float, ptr %107, i64 167936
  store <4096 x float> zeroinitializer, ptr %108, align 4
  %109 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %110 = getelementptr float, ptr %109, i64 172032
  store <4096 x float> zeroinitializer, ptr %110, align 4
  %111 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %112 = getelementptr float, ptr %111, i64 176128
  store <4096 x float> zeroinitializer, ptr %112, align 4
  %113 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %114 = getelementptr float, ptr %113, i64 180224
  store <4096 x float> zeroinitializer, ptr %114, align 4
  %115 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %116 = getelementptr float, ptr %115, i64 184320
  store <4096 x float> zeroinitializer, ptr %116, align 4
  %117 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %118 = getelementptr float, ptr %117, i64 188416
  store <4096 x float> zeroinitializer, ptr %118, align 4
  %119 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %120 = getelementptr float, ptr %119, i64 192512
  store <4096 x float> zeroinitializer, ptr %120, align 4
  %121 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %122 = getelementptr float, ptr %121, i64 196608
  store <4096 x float> zeroinitializer, ptr %122, align 4
  %123 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %124 = getelementptr float, ptr %123, i64 200704
  store <4096 x float> zeroinitializer, ptr %124, align 4
  %125 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %126 = getelementptr float, ptr %125, i64 204800
  store <4096 x float> zeroinitializer, ptr %126, align 4
  %127 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %128 = getelementptr float, ptr %127, i64 208896
  store <4096 x float> zeroinitializer, ptr %128, align 4
  %129 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %130 = getelementptr float, ptr %129, i64 212992
  store <4096 x float> zeroinitializer, ptr %130, align 4
  %131 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %132 = getelementptr float, ptr %131, i64 217088
  store <4096 x float> zeroinitializer, ptr %132, align 4
  %133 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %134 = getelementptr float, ptr %133, i64 221184
  store <4096 x float> zeroinitializer, ptr %134, align 4
  %135 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %136 = getelementptr float, ptr %135, i64 225280
  store <4096 x float> zeroinitializer, ptr %136, align 4
  %137 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %138 = getelementptr float, ptr %137, i64 229376
  store <4096 x float> zeroinitializer, ptr %138, align 4
  %139 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %140 = getelementptr float, ptr %139, i64 233472
  store <4096 x float> zeroinitializer, ptr %140, align 4
  %141 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %142 = getelementptr float, ptr %141, i64 237568
  store <4096 x float> zeroinitializer, ptr %142, align 4
  %143 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %144 = getelementptr float, ptr %143, i64 241664
  store <4096 x float> zeroinitializer, ptr %144, align 4
  %145 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %146 = getelementptr float, ptr %145, i64 245760
  store <4096 x float> zeroinitializer, ptr %146, align 4
  %147 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %148 = getelementptr float, ptr %147, i64 249856
  store <4096 x float> zeroinitializer, ptr %148, align 4
  %149 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %150 = getelementptr float, ptr %149, i64 253952
  store <4096 x float> zeroinitializer, ptr %150, align 4
  %151 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %152 = getelementptr float, ptr %151, i64 258048
  store <4096 x float> zeroinitializer, ptr %152, align 4
  %153 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %154 = getelementptr float, ptr %153, i64 262144
  store <4096 x float> zeroinitializer, ptr %154, align 4
  %155 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %156 = getelementptr float, ptr %155, i64 266240
  store <4096 x float> zeroinitializer, ptr %156, align 4
  %157 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %158 = getelementptr float, ptr %157, i64 270336
  store <4096 x float> zeroinitializer, ptr %158, align 4
  %159 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %160 = getelementptr float, ptr %159, i64 274432
  store <4096 x float> zeroinitializer, ptr %160, align 4
  %161 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %162 = getelementptr float, ptr %161, i64 278528
  store <4096 x float> zeroinitializer, ptr %162, align 4
  %163 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %164 = getelementptr float, ptr %163, i64 282624
  store <4096 x float> zeroinitializer, ptr %164, align 4
  %165 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %166 = getelementptr float, ptr %165, i64 286720
  store <4096 x float> zeroinitializer, ptr %166, align 4
  %167 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %168 = getelementptr float, ptr %167, i64 290816
  store <4096 x float> zeroinitializer, ptr %168, align 4
  %169 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %170 = getelementptr float, ptr %169, i64 294912
  store <4096 x float> zeroinitializer, ptr %170, align 4
  %171 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %172 = getelementptr float, ptr %171, i64 299008
  store <4096 x float> zeroinitializer, ptr %172, align 4
  %173 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %174 = getelementptr float, ptr %173, i64 303104
  store <4096 x float> zeroinitializer, ptr %174, align 4
  %175 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %176 = getelementptr float, ptr %175, i64 307200
  store <4096 x float> zeroinitializer, ptr %176, align 4
  %177 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %178 = getelementptr float, ptr %177, i64 311296
  store <4096 x float> zeroinitializer, ptr %178, align 4
  %179 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %180 = getelementptr float, ptr %179, i64 315392
  store <4096 x float> zeroinitializer, ptr %180, align 4
  %181 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %182 = getelementptr float, ptr %181, i64 319488
  store <4096 x float> zeroinitializer, ptr %182, align 4
  %183 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %184 = getelementptr float, ptr %183, i64 323584
  store <4096 x float> zeroinitializer, ptr %184, align 4
  %185 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %186 = getelementptr float, ptr %185, i64 327680
  store <4096 x float> zeroinitializer, ptr %186, align 4
  %187 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %188 = getelementptr float, ptr %187, i64 331776
  store <4096 x float> zeroinitializer, ptr %188, align 4
  %189 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %190 = getelementptr float, ptr %189, i64 335872
  store <4096 x float> zeroinitializer, ptr %190, align 4
  %191 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %192 = getelementptr float, ptr %191, i64 339968
  store <4096 x float> zeroinitializer, ptr %192, align 4
  %193 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %194 = getelementptr float, ptr %193, i64 344064
  store <4096 x float> zeroinitializer, ptr %194, align 4
  %195 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %196 = getelementptr float, ptr %195, i64 348160
  store <4096 x float> zeroinitializer, ptr %196, align 4
  %197 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %198 = getelementptr float, ptr %197, i64 352256
  store <4096 x float> zeroinitializer, ptr %198, align 4
  %199 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %200 = getelementptr float, ptr %199, i64 356352
  store <4096 x float> zeroinitializer, ptr %200, align 4
  %201 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %202 = getelementptr float, ptr %201, i64 360448
  store <4096 x float> zeroinitializer, ptr %202, align 4
  %203 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %204 = getelementptr float, ptr %203, i64 364544
  store <4096 x float> zeroinitializer, ptr %204, align 4
  %205 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %206 = getelementptr float, ptr %205, i64 368640
  store <4096 x float> zeroinitializer, ptr %206, align 4
  %207 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %208 = getelementptr float, ptr %207, i64 372736
  store <4096 x float> zeroinitializer, ptr %208, align 4
  %209 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %210 = getelementptr float, ptr %209, i64 376832
  store <4096 x float> zeroinitializer, ptr %210, align 4
  %211 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %212 = getelementptr float, ptr %211, i64 380928
  store <4096 x float> zeroinitializer, ptr %212, align 4
  %213 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %214 = getelementptr float, ptr %213, i64 385024
  store <4096 x float> zeroinitializer, ptr %214, align 4
  %215 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %216 = getelementptr float, ptr %215, i64 389120
  store <4096 x float> zeroinitializer, ptr %216, align 4
  %217 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %218 = getelementptr float, ptr %217, i64 393216
  store <4096 x float> zeroinitializer, ptr %218, align 4
  %219 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %220 = getelementptr float, ptr %219, i64 397312
  store <4096 x float> zeroinitializer, ptr %220, align 4
  %221 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %222 = getelementptr float, ptr %221, i64 401408
  store <4096 x float> zeroinitializer, ptr %222, align 4
  %223 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %224 = getelementptr float, ptr %223, i64 405504
  store <4096 x float> zeroinitializer, ptr %224, align 4
  %225 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %226 = getelementptr float, ptr %225, i64 409600
  store <4096 x float> zeroinitializer, ptr %226, align 4
  %227 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %228 = getelementptr float, ptr %227, i64 413696
  store <4096 x float> zeroinitializer, ptr %228, align 4
  %229 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %230 = getelementptr float, ptr %229, i64 417792
  store <4096 x float> zeroinitializer, ptr %230, align 4
  %231 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %232 = getelementptr float, ptr %231, i64 421888
  store <4096 x float> zeroinitializer, ptr %232, align 4
  %233 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %234 = getelementptr float, ptr %233, i64 425984
  store <4096 x float> zeroinitializer, ptr %234, align 4
  %235 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %236 = getelementptr float, ptr %235, i64 430080
  store <4096 x float> zeroinitializer, ptr %236, align 4
  %237 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %238 = getelementptr float, ptr %237, i64 434176
  store <4096 x float> zeroinitializer, ptr %238, align 4
  %239 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %240 = getelementptr float, ptr %239, i64 438272
  store <4096 x float> zeroinitializer, ptr %240, align 4
  %241 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %242 = getelementptr float, ptr %241, i64 442368
  store <4096 x float> zeroinitializer, ptr %242, align 4
  %243 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %244 = getelementptr float, ptr %243, i64 446464
  store <4096 x float> zeroinitializer, ptr %244, align 4
  %245 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %246 = getelementptr float, ptr %245, i64 450560
  store <4096 x float> zeroinitializer, ptr %246, align 4
  %247 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %248 = getelementptr float, ptr %247, i64 454656
  store <4096 x float> zeroinitializer, ptr %248, align 4
  %249 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %250 = getelementptr float, ptr %249, i64 458752
  store <4096 x float> zeroinitializer, ptr %250, align 4
  %251 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %252 = getelementptr float, ptr %251, i64 462848
  store <4096 x float> zeroinitializer, ptr %252, align 4
  %253 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %254 = getelementptr float, ptr %253, i64 466944
  store <4096 x float> zeroinitializer, ptr %254, align 4
  %255 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %256 = getelementptr float, ptr %255, i64 471040
  store <4096 x float> zeroinitializer, ptr %256, align 4
  %257 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %258 = getelementptr float, ptr %257, i64 475136
  store <4096 x float> zeroinitializer, ptr %258, align 4
  %259 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %260 = getelementptr float, ptr %259, i64 479232
  store <4096 x float> zeroinitializer, ptr %260, align 4
  %261 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %262 = getelementptr float, ptr %261, i64 483328
  store <4096 x float> zeroinitializer, ptr %262, align 4
  %263 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %264 = getelementptr float, ptr %263, i64 487424
  store <4096 x float> zeroinitializer, ptr %264, align 4
  %265 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %266 = getelementptr float, ptr %265, i64 491520
  store <4096 x float> zeroinitializer, ptr %266, align 4
  %267 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %268 = getelementptr float, ptr %267, i64 495616
  store <4096 x float> zeroinitializer, ptr %268, align 4
  %269 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %270 = getelementptr float, ptr %269, i64 499712
  store <4096 x float> zeroinitializer, ptr %270, align 4
  %271 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %272 = getelementptr float, ptr %271, i64 503808
  store <4096 x float> zeroinitializer, ptr %272, align 4
  %273 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %274 = getelementptr float, ptr %273, i64 507904
  store <4096 x float> zeroinitializer, ptr %274, align 4
  %275 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %276 = getelementptr float, ptr %275, i64 512000
  store <4096 x float> zeroinitializer, ptr %276, align 4
  %277 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %278 = getelementptr float, ptr %277, i64 516096
  store <4096 x float> zeroinitializer, ptr %278, align 4
  %279 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %280 = getelementptr float, ptr %279, i64 520192
  store <4096 x float> zeroinitializer, ptr %280, align 4
  %281 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %282 = getelementptr float, ptr %281, i64 524288
  store <4096 x float> zeroinitializer, ptr %282, align 4
  %283 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %284 = getelementptr float, ptr %283, i64 528384
  store <4096 x float> zeroinitializer, ptr %284, align 4
  %285 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %286 = getelementptr float, ptr %285, i64 532480
  store <4096 x float> zeroinitializer, ptr %286, align 4
  %287 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %288 = getelementptr float, ptr %287, i64 536576
  store <4096 x float> zeroinitializer, ptr %288, align 4
  %289 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %290 = getelementptr float, ptr %289, i64 540672
  store <4096 x float> zeroinitializer, ptr %290, align 4
  %291 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %292 = getelementptr float, ptr %291, i64 544768
  store <4096 x float> zeroinitializer, ptr %292, align 4
  %293 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %294 = getelementptr float, ptr %293, i64 548864
  store <4096 x float> zeroinitializer, ptr %294, align 4
  %295 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %296 = getelementptr float, ptr %295, i64 552960
  store <4096 x float> zeroinitializer, ptr %296, align 4
  %297 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %298 = getelementptr float, ptr %297, i64 557056
  store <4096 x float> zeroinitializer, ptr %298, align 4
  %299 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %300 = getelementptr float, ptr %299, i64 561152
  store <4096 x float> zeroinitializer, ptr %300, align 4
  %301 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %302 = getelementptr float, ptr %301, i64 565248
  store <4096 x float> zeroinitializer, ptr %302, align 4
  %303 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %304 = getelementptr float, ptr %303, i64 569344
  store <4096 x float> zeroinitializer, ptr %304, align 4
  %305 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %306 = getelementptr float, ptr %305, i64 573440
  store <4096 x float> zeroinitializer, ptr %306, align 4
  %307 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %308 = getelementptr float, ptr %307, i64 577536
  store <4096 x float> zeroinitializer, ptr %308, align 4
  %309 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %310 = getelementptr float, ptr %309, i64 581632
  store <4096 x float> zeroinitializer, ptr %310, align 4
  %311 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %312 = getelementptr float, ptr %311, i64 585728
  store <4096 x float> zeroinitializer, ptr %312, align 4
  %313 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %314 = getelementptr float, ptr %313, i64 589824
  store <4096 x float> zeroinitializer, ptr %314, align 4
  %315 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %316 = getelementptr float, ptr %315, i64 593920
  store <4096 x float> zeroinitializer, ptr %316, align 4
  %317 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %318 = getelementptr float, ptr %317, i64 598016
  store <4096 x float> zeroinitializer, ptr %318, align 4
  %319 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %320 = getelementptr float, ptr %319, i64 602112
  store <4096 x float> zeroinitializer, ptr %320, align 4
  %321 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %322 = getelementptr float, ptr %321, i64 606208
  store <4096 x float> zeroinitializer, ptr %322, align 4
  %323 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %324 = getelementptr float, ptr %323, i64 610304
  store <4096 x float> zeroinitializer, ptr %324, align 4
  %325 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %326 = getelementptr float, ptr %325, i64 614400
  store <4096 x float> zeroinitializer, ptr %326, align 4
  %327 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %328 = getelementptr float, ptr %327, i64 618496
  store <4096 x float> zeroinitializer, ptr %328, align 4
  %329 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %330 = getelementptr float, ptr %329, i64 622592
  store <4096 x float> zeroinitializer, ptr %330, align 4
  %331 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %332 = getelementptr float, ptr %331, i64 626688
  store <4096 x float> zeroinitializer, ptr %332, align 4
  %333 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %334 = getelementptr float, ptr %333, i64 630784
  store <4096 x float> zeroinitializer, ptr %334, align 4
  %335 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %336 = getelementptr float, ptr %335, i64 634880
  store <4096 x float> zeroinitializer, ptr %336, align 4
  %337 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %338 = getelementptr float, ptr %337, i64 638976
  store <4096 x float> zeroinitializer, ptr %338, align 4
  %339 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %340 = getelementptr float, ptr %339, i64 643072
  store <4096 x float> zeroinitializer, ptr %340, align 4
  %341 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %342 = getelementptr float, ptr %341, i64 647168
  store <4096 x float> zeroinitializer, ptr %342, align 4
  %343 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %344 = getelementptr float, ptr %343, i64 651264
  store <4096 x float> zeroinitializer, ptr %344, align 4
  %345 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %346 = getelementptr float, ptr %345, i64 655360
  store <4096 x float> zeroinitializer, ptr %346, align 4
  %347 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %348 = getelementptr float, ptr %347, i64 659456
  store <4096 x float> zeroinitializer, ptr %348, align 4
  %349 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %350 = getelementptr float, ptr %349, i64 663552
  store <4096 x float> zeroinitializer, ptr %350, align 4
  %351 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %352 = getelementptr float, ptr %351, i64 667648
  store <4096 x float> zeroinitializer, ptr %352, align 4
  %353 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %354 = getelementptr float, ptr %353, i64 671744
  store <4096 x float> zeroinitializer, ptr %354, align 4
  %355 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %356 = getelementptr float, ptr %355, i64 675840
  store <4096 x float> zeroinitializer, ptr %356, align 4
  %357 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %358 = getelementptr float, ptr %357, i64 679936
  store <4096 x float> zeroinitializer, ptr %358, align 4
  %359 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %360 = getelementptr float, ptr %359, i64 684032
  store <4096 x float> zeroinitializer, ptr %360, align 4
  %361 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %362 = getelementptr float, ptr %361, i64 688128
  store <4096 x float> zeroinitializer, ptr %362, align 4
  %363 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %364 = getelementptr float, ptr %363, i64 692224
  store <4096 x float> zeroinitializer, ptr %364, align 4
  %365 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %366 = getelementptr float, ptr %365, i64 696320
  store <4096 x float> zeroinitializer, ptr %366, align 4
  %367 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %368 = getelementptr float, ptr %367, i64 700416
  store <4096 x float> zeroinitializer, ptr %368, align 4
  %369 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %370 = getelementptr float, ptr %369, i64 704512
  store <4096 x float> zeroinitializer, ptr %370, align 4
  %371 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %372 = getelementptr float, ptr %371, i64 708608
  store <4096 x float> zeroinitializer, ptr %372, align 4
  %373 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %374 = getelementptr float, ptr %373, i64 712704
  store <4096 x float> zeroinitializer, ptr %374, align 4
  %375 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %376 = getelementptr float, ptr %375, i64 716800
  store <4096 x float> zeroinitializer, ptr %376, align 4
  %377 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %378 = getelementptr float, ptr %377, i64 720896
  store <4096 x float> zeroinitializer, ptr %378, align 4
  %379 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %380 = getelementptr float, ptr %379, i64 724992
  store <4096 x float> zeroinitializer, ptr %380, align 4
  %381 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %382 = getelementptr float, ptr %381, i64 729088
  store <4096 x float> zeroinitializer, ptr %382, align 4
  %383 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %384 = getelementptr float, ptr %383, i64 733184
  store <4096 x float> zeroinitializer, ptr %384, align 4
  %385 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %386 = getelementptr float, ptr %385, i64 737280
  store <4096 x float> zeroinitializer, ptr %386, align 4
  %387 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %388 = getelementptr float, ptr %387, i64 741376
  store <4096 x float> zeroinitializer, ptr %388, align 4
  %389 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %390 = getelementptr float, ptr %389, i64 745472
  store <4096 x float> zeroinitializer, ptr %390, align 4
  %391 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %392 = getelementptr float, ptr %391, i64 749568
  store <4096 x float> zeroinitializer, ptr %392, align 4
  %393 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %394 = getelementptr float, ptr %393, i64 753664
  store <4096 x float> zeroinitializer, ptr %394, align 4
  %395 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %396 = getelementptr float, ptr %395, i64 757760
  store <4096 x float> zeroinitializer, ptr %396, align 4
  %397 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %398 = getelementptr float, ptr %397, i64 761856
  store <4096 x float> zeroinitializer, ptr %398, align 4
  %399 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %400 = getelementptr float, ptr %399, i64 765952
  store <4096 x float> zeroinitializer, ptr %400, align 4
  %401 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %402 = getelementptr float, ptr %401, i64 770048
  store <4096 x float> zeroinitializer, ptr %402, align 4
  %403 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %404 = getelementptr float, ptr %403, i64 774144
  store <4096 x float> zeroinitializer, ptr %404, align 4
  %405 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %406 = getelementptr float, ptr %405, i64 778240
  store <4096 x float> zeroinitializer, ptr %406, align 4
  %407 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %408 = getelementptr float, ptr %407, i64 782336
  store <4096 x float> zeroinitializer, ptr %408, align 4
  %409 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %410 = getelementptr float, ptr %409, i64 786432
  store <4096 x float> zeroinitializer, ptr %410, align 4
  %411 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %412 = getelementptr float, ptr %411, i64 790528
  store <4096 x float> zeroinitializer, ptr %412, align 4
  %413 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %414 = getelementptr float, ptr %413, i64 794624
  store <4096 x float> zeroinitializer, ptr %414, align 4
  %415 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %416 = getelementptr float, ptr %415, i64 798720
  store <4096 x float> zeroinitializer, ptr %416, align 4
  %417 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %418 = getelementptr float, ptr %417, i64 802816
  store <4096 x float> zeroinitializer, ptr %418, align 4
  %419 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %420 = getelementptr float, ptr %419, i64 806912
  store <4096 x float> zeroinitializer, ptr %420, align 4
  %421 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %422 = getelementptr float, ptr %421, i64 811008
  store <4096 x float> zeroinitializer, ptr %422, align 4
  %423 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %424 = getelementptr float, ptr %423, i64 815104
  store <4096 x float> zeroinitializer, ptr %424, align 4
  %425 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %426 = getelementptr float, ptr %425, i64 819200
  store <4096 x float> zeroinitializer, ptr %426, align 4
  %427 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %428 = getelementptr float, ptr %427, i64 823296
  store <4096 x float> zeroinitializer, ptr %428, align 4
  %429 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %430 = getelementptr float, ptr %429, i64 827392
  store <4096 x float> zeroinitializer, ptr %430, align 4
  %431 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %432 = getelementptr float, ptr %431, i64 831488
  store <4096 x float> zeroinitializer, ptr %432, align 4
  %433 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %434 = getelementptr float, ptr %433, i64 835584
  store <4096 x float> zeroinitializer, ptr %434, align 4
  %435 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %436 = getelementptr float, ptr %435, i64 839680
  store <4096 x float> zeroinitializer, ptr %436, align 4
  %437 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %438 = getelementptr float, ptr %437, i64 843776
  store <4096 x float> zeroinitializer, ptr %438, align 4
  %439 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %440 = getelementptr float, ptr %439, i64 847872
  store <4096 x float> zeroinitializer, ptr %440, align 4
  %441 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %442 = getelementptr float, ptr %441, i64 851968
  store <4096 x float> zeroinitializer, ptr %442, align 4
  %443 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %444 = getelementptr float, ptr %443, i64 856064
  store <4096 x float> zeroinitializer, ptr %444, align 4
  %445 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %446 = getelementptr float, ptr %445, i64 860160
  store <4096 x float> zeroinitializer, ptr %446, align 4
  %447 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %448 = getelementptr float, ptr %447, i64 864256
  store <4096 x float> zeroinitializer, ptr %448, align 4
  %449 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %450 = getelementptr float, ptr %449, i64 868352
  store <4096 x float> zeroinitializer, ptr %450, align 4
  %451 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %452 = getelementptr float, ptr %451, i64 872448
  store <4096 x float> zeroinitializer, ptr %452, align 4
  %453 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %454 = getelementptr float, ptr %453, i64 876544
  store <4096 x float> zeroinitializer, ptr %454, align 4
  %455 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %456 = getelementptr float, ptr %455, i64 880640
  store <4096 x float> zeroinitializer, ptr %456, align 4
  %457 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %458 = getelementptr float, ptr %457, i64 884736
  store <4096 x float> zeroinitializer, ptr %458, align 4
  %459 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %460 = getelementptr float, ptr %459, i64 888832
  store <4096 x float> zeroinitializer, ptr %460, align 4
  %461 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %462 = getelementptr float, ptr %461, i64 892928
  store <4096 x float> zeroinitializer, ptr %462, align 4
  %463 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %464 = getelementptr float, ptr %463, i64 897024
  store <4096 x float> zeroinitializer, ptr %464, align 4
  %465 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %466 = getelementptr float, ptr %465, i64 901120
  store <4096 x float> zeroinitializer, ptr %466, align 4
  %467 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %468 = getelementptr float, ptr %467, i64 905216
  store <4096 x float> zeroinitializer, ptr %468, align 4
  %469 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %470 = getelementptr float, ptr %469, i64 909312
  store <4096 x float> zeroinitializer, ptr %470, align 4
  %471 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %472 = getelementptr float, ptr %471, i64 913408
  store <4096 x float> zeroinitializer, ptr %472, align 4
  %473 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %474 = getelementptr float, ptr %473, i64 917504
  store <4096 x float> zeroinitializer, ptr %474, align 4
  %475 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %476 = getelementptr float, ptr %475, i64 921600
  store <4096 x float> zeroinitializer, ptr %476, align 4
  %477 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %478 = getelementptr float, ptr %477, i64 925696
  store <4096 x float> zeroinitializer, ptr %478, align 4
  %479 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %480 = getelementptr float, ptr %479, i64 929792
  store <4096 x float> zeroinitializer, ptr %480, align 4
  %481 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %482 = getelementptr float, ptr %481, i64 933888
  store <4096 x float> zeroinitializer, ptr %482, align 4
  %483 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %484 = getelementptr float, ptr %483, i64 937984
  store <4096 x float> zeroinitializer, ptr %484, align 4
  %485 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %486 = getelementptr float, ptr %485, i64 942080
  store <4096 x float> zeroinitializer, ptr %486, align 4
  %487 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %488 = getelementptr float, ptr %487, i64 946176
  store <4096 x float> zeroinitializer, ptr %488, align 4
  %489 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %490 = getelementptr float, ptr %489, i64 950272
  store <4096 x float> zeroinitializer, ptr %490, align 4
  %491 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %492 = getelementptr float, ptr %491, i64 954368
  store <4096 x float> zeroinitializer, ptr %492, align 4
  %493 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %494 = getelementptr float, ptr %493, i64 958464
  store <4096 x float> zeroinitializer, ptr %494, align 4
  %495 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %496 = getelementptr float, ptr %495, i64 962560
  store <4096 x float> zeroinitializer, ptr %496, align 4
  %497 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %498 = getelementptr float, ptr %497, i64 966656
  store <4096 x float> zeroinitializer, ptr %498, align 4
  %499 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %500 = getelementptr float, ptr %499, i64 970752
  store <4096 x float> zeroinitializer, ptr %500, align 4
  %501 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %502 = getelementptr float, ptr %501, i64 974848
  store <4096 x float> zeroinitializer, ptr %502, align 4
  %503 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %504 = getelementptr float, ptr %503, i64 978944
  store <4096 x float> zeroinitializer, ptr %504, align 4
  %505 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %506 = getelementptr float, ptr %505, i64 983040
  store <4096 x float> zeroinitializer, ptr %506, align 4
  %507 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %508 = getelementptr float, ptr %507, i64 987136
  store <4096 x float> zeroinitializer, ptr %508, align 4
  %509 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %510 = getelementptr float, ptr %509, i64 991232
  store <4096 x float> zeroinitializer, ptr %510, align 4
  %511 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %512 = getelementptr float, ptr %511, i64 995328
  store <4096 x float> zeroinitializer, ptr %512, align 4
  %513 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %514 = getelementptr float, ptr %513, i64 999424
  store <4096 x float> zeroinitializer, ptr %514, align 4
  %515 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %516 = getelementptr float, ptr %515, i64 1003520
  store <4096 x float> zeroinitializer, ptr %516, align 4
  %517 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %518 = getelementptr float, ptr %517, i64 1007616
  store <4096 x float> zeroinitializer, ptr %518, align 4
  %519 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %520 = getelementptr float, ptr %519, i64 1011712
  store <4096 x float> zeroinitializer, ptr %520, align 4
  %521 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %522 = getelementptr float, ptr %521, i64 1015808
  store <4096 x float> zeroinitializer, ptr %522, align 4
  %523 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %524 = getelementptr float, ptr %523, i64 1019904
  store <4096 x float> zeroinitializer, ptr %524, align 4
  %525 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %526 = getelementptr float, ptr %525, i64 1024000
  store <4096 x float> zeroinitializer, ptr %526, align 4
  %527 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %528 = getelementptr float, ptr %527, i64 1028096
  store <4096 x float> zeroinitializer, ptr %528, align 4
  %529 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %530 = getelementptr float, ptr %529, i64 1032192
  store <4096 x float> zeroinitializer, ptr %530, align 4
  %531 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %532 = getelementptr float, ptr %531, i64 1036288
  store <4096 x float> zeroinitializer, ptr %532, align 4
  %533 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %534 = getelementptr float, ptr %533, i64 1040384
  store <4096 x float> zeroinitializer, ptr %534, align 4
  %535 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %536 = getelementptr float, ptr %535, i64 1044480
  store <4096 x float> zeroinitializer, ptr %536, align 4
  %537 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %538 = getelementptr float, ptr %537, i64 1048576
  store <4096 x float> zeroinitializer, ptr %538, align 4
  %539 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %540 = getelementptr float, ptr %539, i64 1052672
  store <4096 x float> zeroinitializer, ptr %540, align 4
  %541 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %542 = getelementptr float, ptr %541, i64 1056768
  store <4096 x float> zeroinitializer, ptr %542, align 4
  %543 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %544 = getelementptr float, ptr %543, i64 1060864
  store <4096 x float> zeroinitializer, ptr %544, align 4
  %545 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %546 = getelementptr float, ptr %545, i64 1064960
  store <4096 x float> zeroinitializer, ptr %546, align 4
  %547 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %548 = getelementptr float, ptr %547, i64 1069056
  store <4096 x float> zeroinitializer, ptr %548, align 4
  %549 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %550 = getelementptr float, ptr %549, i64 1073152
  store <4096 x float> zeroinitializer, ptr %550, align 4
  %551 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %552 = getelementptr float, ptr %551, i64 1077248
  store <4096 x float> zeroinitializer, ptr %552, align 4
  %553 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %554 = getelementptr float, ptr %553, i64 1081344
  store <4096 x float> zeroinitializer, ptr %554, align 4
  %555 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %556 = getelementptr float, ptr %555, i64 1085440
  store <4096 x float> zeroinitializer, ptr %556, align 4
  %557 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %558 = getelementptr float, ptr %557, i64 1089536
  store <4096 x float> zeroinitializer, ptr %558, align 4
  %559 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %560 = getelementptr float, ptr %559, i64 1093632
  store <4096 x float> zeroinitializer, ptr %560, align 4
  %561 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %562 = getelementptr float, ptr %561, i64 1097728
  store <4096 x float> zeroinitializer, ptr %562, align 4
  %563 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %564 = getelementptr float, ptr %563, i64 1101824
  store <4096 x float> zeroinitializer, ptr %564, align 4
  %565 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %566 = getelementptr float, ptr %565, i64 1105920
  store <4096 x float> zeroinitializer, ptr %566, align 4
  %567 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %568 = getelementptr float, ptr %567, i64 1110016
  store <4096 x float> zeroinitializer, ptr %568, align 4
  %569 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %570 = getelementptr float, ptr %569, i64 1114112
  store <4096 x float> zeroinitializer, ptr %570, align 4
  %571 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %572 = getelementptr float, ptr %571, i64 1118208
  store <4096 x float> zeroinitializer, ptr %572, align 4
  %573 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %574 = getelementptr float, ptr %573, i64 1122304
  store <4096 x float> zeroinitializer, ptr %574, align 4
  %575 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %576 = getelementptr float, ptr %575, i64 1126400
  store <4096 x float> zeroinitializer, ptr %576, align 4
  %577 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %578 = getelementptr float, ptr %577, i64 1130496
  store <4096 x float> zeroinitializer, ptr %578, align 4
  %579 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %580 = getelementptr float, ptr %579, i64 1134592
  store <4096 x float> zeroinitializer, ptr %580, align 4
  %581 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %582 = getelementptr float, ptr %581, i64 1138688
  store <4096 x float> zeroinitializer, ptr %582, align 4
  %583 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %584 = getelementptr float, ptr %583, i64 1142784
  store <4096 x float> zeroinitializer, ptr %584, align 4
  %585 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %586 = getelementptr float, ptr %585, i64 1146880
  store <4096 x float> zeroinitializer, ptr %586, align 4
  %587 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %588 = getelementptr float, ptr %587, i64 1150976
  store <4096 x float> zeroinitializer, ptr %588, align 4
  %589 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %590 = getelementptr float, ptr %589, i64 1155072
  store <4096 x float> zeroinitializer, ptr %590, align 4
  %591 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %592 = getelementptr float, ptr %591, i64 1159168
  store <4096 x float> zeroinitializer, ptr %592, align 4
  %593 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %594 = getelementptr float, ptr %593, i64 1163264
  store <4096 x float> zeroinitializer, ptr %594, align 4
  %595 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %596 = getelementptr float, ptr %595, i64 1167360
  store <4096 x float> zeroinitializer, ptr %596, align 4
  %597 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %598 = getelementptr float, ptr %597, i64 1171456
  store <4096 x float> zeroinitializer, ptr %598, align 4
  %599 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %600 = getelementptr float, ptr %599, i64 1175552
  store <4096 x float> zeroinitializer, ptr %600, align 4
  %601 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %602 = getelementptr float, ptr %601, i64 1179648
  store <4096 x float> zeroinitializer, ptr %602, align 4
  %603 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %604 = getelementptr float, ptr %603, i64 1183744
  store <4096 x float> zeroinitializer, ptr %604, align 4
  %605 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %606 = getelementptr float, ptr %605, i64 1187840
  store <4096 x float> zeroinitializer, ptr %606, align 4
  %607 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %608 = getelementptr float, ptr %607, i64 1191936
  store <4096 x float> zeroinitializer, ptr %608, align 4
  %609 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %610 = getelementptr float, ptr %609, i64 1196032
  store <4096 x float> zeroinitializer, ptr %610, align 4
  %611 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %612 = getelementptr float, ptr %611, i64 1200128
  store <4096 x float> zeroinitializer, ptr %612, align 4
  %613 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %614 = getelementptr float, ptr %613, i64 1204224
  store <4096 x float> zeroinitializer, ptr %614, align 4
  %615 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %616 = getelementptr float, ptr %615, i64 1208320
  store <4096 x float> zeroinitializer, ptr %616, align 4
  %617 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %618 = getelementptr float, ptr %617, i64 1212416
  store <4096 x float> zeroinitializer, ptr %618, align 4
  %619 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %620 = getelementptr float, ptr %619, i64 1216512
  store <4096 x float> zeroinitializer, ptr %620, align 4
  %621 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %622 = getelementptr float, ptr %621, i64 1220608
  store <4096 x float> zeroinitializer, ptr %622, align 4
  %623 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %624 = getelementptr float, ptr %623, i64 1224704
  store <4096 x float> zeroinitializer, ptr %624, align 4
  %625 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %626 = getelementptr float, ptr %625, i64 1228800
  store <4096 x float> zeroinitializer, ptr %626, align 4
  %627 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %628 = getelementptr float, ptr %627, i64 1232896
  store <4096 x float> zeroinitializer, ptr %628, align 4
  %629 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %630 = getelementptr float, ptr %629, i64 1236992
  store <4096 x float> zeroinitializer, ptr %630, align 4
  %631 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %632 = getelementptr float, ptr %631, i64 1241088
  store <4096 x float> zeroinitializer, ptr %632, align 4
  %633 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %634 = getelementptr float, ptr %633, i64 1245184
  store <4096 x float> zeroinitializer, ptr %634, align 4
  %635 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %636 = getelementptr float, ptr %635, i64 1249280
  store <4096 x float> zeroinitializer, ptr %636, align 4
  %637 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %638 = getelementptr float, ptr %637, i64 1253376
  store <4096 x float> zeroinitializer, ptr %638, align 4
  %639 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %640 = getelementptr float, ptr %639, i64 1257472
  store <4096 x float> zeroinitializer, ptr %640, align 4
  %641 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %642 = getelementptr float, ptr %641, i64 1261568
  store <4096 x float> zeroinitializer, ptr %642, align 4
  %643 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %644 = getelementptr float, ptr %643, i64 1265664
  store <4096 x float> zeroinitializer, ptr %644, align 4
  %645 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %646 = getelementptr float, ptr %645, i64 1269760
  store <4096 x float> zeroinitializer, ptr %646, align 4
  %647 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %648 = getelementptr float, ptr %647, i64 1273856
  store <4096 x float> zeroinitializer, ptr %648, align 4
  %649 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %650 = getelementptr float, ptr %649, i64 1277952
  store <4096 x float> zeroinitializer, ptr %650, align 4
  %651 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %652 = getelementptr float, ptr %651, i64 1282048
  store <4096 x float> zeroinitializer, ptr %652, align 4
  %653 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %654 = getelementptr float, ptr %653, i64 1286144
  store <4096 x float> zeroinitializer, ptr %654, align 4
  %655 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %656 = getelementptr float, ptr %655, i64 1290240
  store <4096 x float> zeroinitializer, ptr %656, align 4
  %657 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %658 = getelementptr float, ptr %657, i64 1294336
  store <4096 x float> zeroinitializer, ptr %658, align 4
  %659 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %660 = getelementptr float, ptr %659, i64 1298432
  store <4096 x float> zeroinitializer, ptr %660, align 4
  %661 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %662 = getelementptr float, ptr %661, i64 1302528
  store <4096 x float> zeroinitializer, ptr %662, align 4
  %663 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %664 = getelementptr float, ptr %663, i64 1306624
  store <4096 x float> zeroinitializer, ptr %664, align 4
  %665 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %666 = getelementptr float, ptr %665, i64 1310720
  store <4096 x float> zeroinitializer, ptr %666, align 4
  %667 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %668 = getelementptr float, ptr %667, i64 1314816
  store <4096 x float> zeroinitializer, ptr %668, align 4
  %669 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %670 = getelementptr float, ptr %669, i64 1318912
  store <4096 x float> zeroinitializer, ptr %670, align 4
  %671 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %672 = getelementptr float, ptr %671, i64 1323008
  store <4096 x float> zeroinitializer, ptr %672, align 4
  %673 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %674 = getelementptr float, ptr %673, i64 1327104
  store <4096 x float> zeroinitializer, ptr %674, align 4
  %675 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %676 = getelementptr float, ptr %675, i64 1331200
  store <4096 x float> zeroinitializer, ptr %676, align 4
  %677 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %678 = getelementptr float, ptr %677, i64 1335296
  store <4096 x float> zeroinitializer, ptr %678, align 4
  %679 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %680 = getelementptr float, ptr %679, i64 1339392
  store <4096 x float> zeroinitializer, ptr %680, align 4
  %681 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %682 = getelementptr float, ptr %681, i64 1343488
  store <4096 x float> zeroinitializer, ptr %682, align 4
  %683 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %684 = getelementptr float, ptr %683, i64 1347584
  store <4096 x float> zeroinitializer, ptr %684, align 4
  %685 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %686 = getelementptr float, ptr %685, i64 1351680
  store <4096 x float> zeroinitializer, ptr %686, align 4
  %687 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %688 = getelementptr float, ptr %687, i64 1355776
  store <4096 x float> zeroinitializer, ptr %688, align 4
  %689 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %690 = getelementptr float, ptr %689, i64 1359872
  store <4096 x float> zeroinitializer, ptr %690, align 4
  %691 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %692 = getelementptr float, ptr %691, i64 1363968
  store <4096 x float> zeroinitializer, ptr %692, align 4
  %693 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %694 = getelementptr float, ptr %693, i64 1368064
  store <4096 x float> zeroinitializer, ptr %694, align 4
  %695 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %696 = getelementptr float, ptr %695, i64 1372160
  store <4096 x float> zeroinitializer, ptr %696, align 4
  %697 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %698 = getelementptr float, ptr %697, i64 1376256
  store <4096 x float> zeroinitializer, ptr %698, align 4
  %699 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %700 = getelementptr float, ptr %699, i64 1380352
  store <4096 x float> zeroinitializer, ptr %700, align 4
  %701 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %702 = getelementptr float, ptr %701, i64 1384448
  store <4096 x float> zeroinitializer, ptr %702, align 4
  %703 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %704 = getelementptr float, ptr %703, i64 1388544
  store <4096 x float> zeroinitializer, ptr %704, align 4
  %705 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %706 = getelementptr float, ptr %705, i64 1392640
  store <4096 x float> zeroinitializer, ptr %706, align 4
  %707 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %708 = getelementptr float, ptr %707, i64 1396736
  store <4096 x float> zeroinitializer, ptr %708, align 4
  %709 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %710 = getelementptr float, ptr %709, i64 1400832
  store <4096 x float> zeroinitializer, ptr %710, align 4
  %711 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %712 = getelementptr float, ptr %711, i64 1404928
  store <4096 x float> zeroinitializer, ptr %712, align 4
  %713 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %714 = getelementptr float, ptr %713, i64 1409024
  store <4096 x float> zeroinitializer, ptr %714, align 4
  %715 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %716 = getelementptr float, ptr %715, i64 1413120
  store <4096 x float> zeroinitializer, ptr %716, align 4
  %717 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %718 = getelementptr float, ptr %717, i64 1417216
  store <4096 x float> zeroinitializer, ptr %718, align 4
  %719 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %720 = getelementptr float, ptr %719, i64 1421312
  store <4096 x float> zeroinitializer, ptr %720, align 4
  %721 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %722 = getelementptr float, ptr %721, i64 1425408
  store <4096 x float> zeroinitializer, ptr %722, align 4
  %723 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %724 = getelementptr float, ptr %723, i64 1429504
  store <4096 x float> zeroinitializer, ptr %724, align 4
  %725 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %726 = getelementptr float, ptr %725, i64 1433600
  store <4096 x float> zeroinitializer, ptr %726, align 4
  %727 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %728 = getelementptr float, ptr %727, i64 1437696
  store <4096 x float> zeroinitializer, ptr %728, align 4
  %729 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %730 = getelementptr float, ptr %729, i64 1441792
  store <4096 x float> zeroinitializer, ptr %730, align 4
  %731 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %732 = getelementptr float, ptr %731, i64 1445888
  store <4096 x float> zeroinitializer, ptr %732, align 4
  %733 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %734 = getelementptr float, ptr %733, i64 1449984
  store <4096 x float> zeroinitializer, ptr %734, align 4
  %735 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %736 = getelementptr float, ptr %735, i64 1454080
  store <4096 x float> zeroinitializer, ptr %736, align 4
  %737 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %738 = getelementptr float, ptr %737, i64 1458176
  store <4096 x float> zeroinitializer, ptr %738, align 4
  %739 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %740 = getelementptr float, ptr %739, i64 1462272
  store <4096 x float> zeroinitializer, ptr %740, align 4
  %741 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %742 = getelementptr float, ptr %741, i64 1466368
  store <4096 x float> zeroinitializer, ptr %742, align 4
  %743 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %744 = getelementptr float, ptr %743, i64 1470464
  store <4096 x float> zeroinitializer, ptr %744, align 4
  %745 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %746 = getelementptr float, ptr %745, i64 1474560
  store <4096 x float> zeroinitializer, ptr %746, align 4
  %747 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %748 = getelementptr float, ptr %747, i64 1478656
  store <4096 x float> zeroinitializer, ptr %748, align 4
  %749 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %750 = getelementptr float, ptr %749, i64 1482752
  store <4096 x float> zeroinitializer, ptr %750, align 4
  %751 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %752 = getelementptr float, ptr %751, i64 1486848
  store <4096 x float> zeroinitializer, ptr %752, align 4
  %753 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %754 = getelementptr float, ptr %753, i64 1490944
  store <4096 x float> zeroinitializer, ptr %754, align 4
  %755 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %756 = getelementptr float, ptr %755, i64 1495040
  store <4096 x float> zeroinitializer, ptr %756, align 4
  %757 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %758 = getelementptr float, ptr %757, i64 1499136
  store <4096 x float> zeroinitializer, ptr %758, align 4
  %759 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %760 = getelementptr float, ptr %759, i64 1503232
  store <4096 x float> zeroinitializer, ptr %760, align 4
  %761 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %762 = getelementptr float, ptr %761, i64 1507328
  store <4096 x float> zeroinitializer, ptr %762, align 4
  %763 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %764 = getelementptr float, ptr %763, i64 1511424
  store <4096 x float> zeroinitializer, ptr %764, align 4
  %765 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %766 = getelementptr float, ptr %765, i64 1515520
  store <4096 x float> zeroinitializer, ptr %766, align 4
  %767 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %768 = getelementptr float, ptr %767, i64 1519616
  store <4096 x float> zeroinitializer, ptr %768, align 4
  %769 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %770 = getelementptr float, ptr %769, i64 1523712
  store <4096 x float> zeroinitializer, ptr %770, align 4
  %771 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %772 = getelementptr float, ptr %771, i64 1527808
  store <4096 x float> zeroinitializer, ptr %772, align 4
  %773 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %774 = getelementptr float, ptr %773, i64 1531904
  store <4096 x float> zeroinitializer, ptr %774, align 4
  %775 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %776 = getelementptr float, ptr %775, i64 1536000
  store <4096 x float> zeroinitializer, ptr %776, align 4
  %777 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %778 = getelementptr float, ptr %777, i64 1540096
  store <4096 x float> zeroinitializer, ptr %778, align 4
  %779 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %780 = getelementptr float, ptr %779, i64 1544192
  store <4096 x float> zeroinitializer, ptr %780, align 4
  %781 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %782 = getelementptr float, ptr %781, i64 1548288
  store <4096 x float> zeroinitializer, ptr %782, align 4
  %783 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %784 = getelementptr float, ptr %783, i64 1552384
  store <4096 x float> zeroinitializer, ptr %784, align 4
  %785 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %786 = getelementptr float, ptr %785, i64 1556480
  store <4096 x float> zeroinitializer, ptr %786, align 4
  %787 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %788 = getelementptr float, ptr %787, i64 1560576
  store <4096 x float> zeroinitializer, ptr %788, align 4
  %789 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %790 = getelementptr float, ptr %789, i64 1564672
  store <4096 x float> zeroinitializer, ptr %790, align 4
  %791 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %792 = getelementptr float, ptr %791, i64 1568768
  store <4096 x float> zeroinitializer, ptr %792, align 4
  %793 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %794 = getelementptr float, ptr %793, i64 1572864
  store <4096 x float> zeroinitializer, ptr %794, align 4
  %795 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %796 = getelementptr float, ptr %795, i64 1576960
  store <4096 x float> zeroinitializer, ptr %796, align 4
  %797 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %798 = getelementptr float, ptr %797, i64 1581056
  store <4096 x float> zeroinitializer, ptr %798, align 4
  %799 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %800 = getelementptr float, ptr %799, i64 1585152
  store <4096 x float> zeroinitializer, ptr %800, align 4
  %801 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %802 = getelementptr float, ptr %801, i64 1589248
  store <4096 x float> zeroinitializer, ptr %802, align 4
  %803 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %804 = getelementptr float, ptr %803, i64 1593344
  store <4096 x float> zeroinitializer, ptr %804, align 4
  %805 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %806 = getelementptr float, ptr %805, i64 1597440
  store <4096 x float> zeroinitializer, ptr %806, align 4
  %807 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %808 = getelementptr float, ptr %807, i64 1601536
  store <4096 x float> zeroinitializer, ptr %808, align 4
  %809 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %810 = getelementptr float, ptr %809, i64 1605632
  store <4096 x float> zeroinitializer, ptr %810, align 4
  %811 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %812 = getelementptr float, ptr %811, i64 1609728
  store <4096 x float> zeroinitializer, ptr %812, align 4
  %813 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %814 = getelementptr float, ptr %813, i64 1613824
  store <4096 x float> zeroinitializer, ptr %814, align 4
  %815 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %816 = getelementptr float, ptr %815, i64 1617920
  store <4096 x float> zeroinitializer, ptr %816, align 4
  %817 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %818 = getelementptr float, ptr %817, i64 1622016
  store <4096 x float> zeroinitializer, ptr %818, align 4
  %819 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %820 = getelementptr float, ptr %819, i64 1626112
  store <4096 x float> zeroinitializer, ptr %820, align 4
  %821 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %822 = getelementptr float, ptr %821, i64 1630208
  store <4096 x float> zeroinitializer, ptr %822, align 4
  %823 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %824 = getelementptr float, ptr %823, i64 1634304
  store <4096 x float> zeroinitializer, ptr %824, align 4
  %825 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %826 = getelementptr float, ptr %825, i64 1638400
  store <4096 x float> zeroinitializer, ptr %826, align 4
  %827 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %828 = getelementptr float, ptr %827, i64 1642496
  store <4096 x float> zeroinitializer, ptr %828, align 4
  %829 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %830 = getelementptr float, ptr %829, i64 1646592
  store <4096 x float> zeroinitializer, ptr %830, align 4
  %831 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %832 = getelementptr float, ptr %831, i64 1650688
  store <4096 x float> zeroinitializer, ptr %832, align 4
  %833 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %834 = getelementptr float, ptr %833, i64 1654784
  store <4096 x float> zeroinitializer, ptr %834, align 4
  %835 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %836 = getelementptr float, ptr %835, i64 1658880
  store <4096 x float> zeroinitializer, ptr %836, align 4
  %837 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %838 = getelementptr float, ptr %837, i64 1662976
  store <4096 x float> zeroinitializer, ptr %838, align 4
  %839 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %840 = getelementptr float, ptr %839, i64 1667072
  store <4096 x float> zeroinitializer, ptr %840, align 4
  %841 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %842 = getelementptr float, ptr %841, i64 1671168
  store <4096 x float> zeroinitializer, ptr %842, align 4
  %843 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %844 = getelementptr float, ptr %843, i64 1675264
  store <4096 x float> zeroinitializer, ptr %844, align 4
  %845 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %846 = getelementptr float, ptr %845, i64 1679360
  store <4096 x float> zeroinitializer, ptr %846, align 4
  %847 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %848 = getelementptr float, ptr %847, i64 1683456
  store <4096 x float> zeroinitializer, ptr %848, align 4
  %849 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %850 = getelementptr float, ptr %849, i64 1687552
  store <4096 x float> zeroinitializer, ptr %850, align 4
  %851 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %852 = getelementptr float, ptr %851, i64 1691648
  store <4096 x float> zeroinitializer, ptr %852, align 4
  %853 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %854 = getelementptr float, ptr %853, i64 1695744
  store <4096 x float> zeroinitializer, ptr %854, align 4
  %855 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %856 = getelementptr float, ptr %855, i64 1699840
  store <4096 x float> zeroinitializer, ptr %856, align 4
  %857 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %858 = getelementptr float, ptr %857, i64 1703936
  store <4096 x float> zeroinitializer, ptr %858, align 4
  %859 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %860 = getelementptr float, ptr %859, i64 1708032
  store <4096 x float> zeroinitializer, ptr %860, align 4
  %861 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %862 = getelementptr float, ptr %861, i64 1712128
  store <4096 x float> zeroinitializer, ptr %862, align 4
  %863 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %864 = getelementptr float, ptr %863, i64 1716224
  store <4096 x float> zeroinitializer, ptr %864, align 4
  %865 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %866 = getelementptr float, ptr %865, i64 1720320
  store <4096 x float> zeroinitializer, ptr %866, align 4
  %867 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %868 = getelementptr float, ptr %867, i64 1724416
  store <4096 x float> zeroinitializer, ptr %868, align 4
  %869 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %870 = getelementptr float, ptr %869, i64 1728512
  store <4096 x float> zeroinitializer, ptr %870, align 4
  %871 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %872 = getelementptr float, ptr %871, i64 1732608
  store <4096 x float> zeroinitializer, ptr %872, align 4
  %873 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %874 = getelementptr float, ptr %873, i64 1736704
  store <4096 x float> zeroinitializer, ptr %874, align 4
  %875 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %876 = getelementptr float, ptr %875, i64 1740800
  store <4096 x float> zeroinitializer, ptr %876, align 4
  %877 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %878 = getelementptr float, ptr %877, i64 1744896
  store <4096 x float> zeroinitializer, ptr %878, align 4
  %879 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %880 = getelementptr float, ptr %879, i64 1748992
  store <4096 x float> zeroinitializer, ptr %880, align 4
  %881 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %882 = getelementptr float, ptr %881, i64 1753088
  store <4096 x float> zeroinitializer, ptr %882, align 4
  %883 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %884 = getelementptr float, ptr %883, i64 1757184
  store <4096 x float> zeroinitializer, ptr %884, align 4
  %885 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %886 = getelementptr float, ptr %885, i64 1761280
  store <4096 x float> zeroinitializer, ptr %886, align 4
  %887 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %888 = getelementptr float, ptr %887, i64 1765376
  store <4096 x float> zeroinitializer, ptr %888, align 4
  %889 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %890 = getelementptr float, ptr %889, i64 1769472
  store <4096 x float> zeroinitializer, ptr %890, align 4
  %891 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %892 = getelementptr float, ptr %891, i64 1773568
  store <4096 x float> zeroinitializer, ptr %892, align 4
  %893 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %894 = getelementptr float, ptr %893, i64 1777664
  store <4096 x float> zeroinitializer, ptr %894, align 4
  %895 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %896 = getelementptr float, ptr %895, i64 1781760
  store <4096 x float> zeroinitializer, ptr %896, align 4
  %897 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %898 = getelementptr float, ptr %897, i64 1785856
  store <4096 x float> zeroinitializer, ptr %898, align 4
  %899 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %900 = getelementptr float, ptr %899, i64 1789952
  store <4096 x float> zeroinitializer, ptr %900, align 4
  %901 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %902 = getelementptr float, ptr %901, i64 1794048
  store <4096 x float> zeroinitializer, ptr %902, align 4
  %903 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %904 = getelementptr float, ptr %903, i64 1798144
  store <4096 x float> zeroinitializer, ptr %904, align 4
  %905 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %906 = getelementptr float, ptr %905, i64 1802240
  store <4096 x float> zeroinitializer, ptr %906, align 4
  %907 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %908 = getelementptr float, ptr %907, i64 1806336
  store <4096 x float> zeroinitializer, ptr %908, align 4
  %909 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %910 = getelementptr float, ptr %909, i64 1810432
  store <4096 x float> zeroinitializer, ptr %910, align 4
  %911 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %912 = getelementptr float, ptr %911, i64 1814528
  store <4096 x float> zeroinitializer, ptr %912, align 4
  %913 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %914 = getelementptr float, ptr %913, i64 1818624
  store <4096 x float> zeroinitializer, ptr %914, align 4
  %915 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %916 = getelementptr float, ptr %915, i64 1822720
  store <4096 x float> zeroinitializer, ptr %916, align 4
  %917 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %918 = getelementptr float, ptr %917, i64 1826816
  store <4096 x float> zeroinitializer, ptr %918, align 4
  %919 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %920 = getelementptr float, ptr %919, i64 1830912
  store <4096 x float> zeroinitializer, ptr %920, align 4
  %921 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %922 = getelementptr float, ptr %921, i64 1835008
  store <4096 x float> zeroinitializer, ptr %922, align 4
  %923 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %924 = getelementptr float, ptr %923, i64 1839104
  store <4096 x float> zeroinitializer, ptr %924, align 4
  %925 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %926 = getelementptr float, ptr %925, i64 1843200
  store <4096 x float> zeroinitializer, ptr %926, align 4
  %927 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %928 = getelementptr float, ptr %927, i64 1847296
  store <4096 x float> zeroinitializer, ptr %928, align 4
  %929 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %930 = getelementptr float, ptr %929, i64 1851392
  store <4096 x float> zeroinitializer, ptr %930, align 4
  %931 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %932 = getelementptr float, ptr %931, i64 1855488
  store <4096 x float> zeroinitializer, ptr %932, align 4
  %933 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %934 = getelementptr float, ptr %933, i64 1859584
  store <4096 x float> zeroinitializer, ptr %934, align 4
  %935 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %936 = getelementptr float, ptr %935, i64 1863680
  store <4096 x float> zeroinitializer, ptr %936, align 4
  %937 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %938 = getelementptr float, ptr %937, i64 1867776
  store <4096 x float> zeroinitializer, ptr %938, align 4
  %939 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %940 = getelementptr float, ptr %939, i64 1871872
  store <4096 x float> zeroinitializer, ptr %940, align 4
  %941 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %942 = getelementptr float, ptr %941, i64 1875968
  store <4096 x float> zeroinitializer, ptr %942, align 4
  %943 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %944 = getelementptr float, ptr %943, i64 1880064
  store <4096 x float> zeroinitializer, ptr %944, align 4
  %945 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %946 = getelementptr float, ptr %945, i64 1884160
  store <4096 x float> zeroinitializer, ptr %946, align 4
  %947 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %948 = getelementptr float, ptr %947, i64 1888256
  store <4096 x float> zeroinitializer, ptr %948, align 4
  %949 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %950 = getelementptr float, ptr %949, i64 1892352
  store <4096 x float> zeroinitializer, ptr %950, align 4
  %951 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %952 = getelementptr float, ptr %951, i64 1896448
  store <4096 x float> zeroinitializer, ptr %952, align 4
  %953 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %954 = getelementptr float, ptr %953, i64 1900544
  store <4096 x float> zeroinitializer, ptr %954, align 4
  %955 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %956 = getelementptr float, ptr %955, i64 1904640
  store <4096 x float> zeroinitializer, ptr %956, align 4
  %957 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %958 = getelementptr float, ptr %957, i64 1908736
  store <4096 x float> zeroinitializer, ptr %958, align 4
  %959 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %960 = getelementptr float, ptr %959, i64 1912832
  store <4096 x float> zeroinitializer, ptr %960, align 4
  %961 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %962 = getelementptr float, ptr %961, i64 1916928
  store <4096 x float> zeroinitializer, ptr %962, align 4
  %963 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %964 = getelementptr float, ptr %963, i64 1921024
  store <4096 x float> zeroinitializer, ptr %964, align 4
  %965 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %966 = getelementptr float, ptr %965, i64 1925120
  store <4096 x float> zeroinitializer, ptr %966, align 4
  %967 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %968 = getelementptr float, ptr %967, i64 1929216
  store <4096 x float> zeroinitializer, ptr %968, align 4
  %969 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %970 = getelementptr float, ptr %969, i64 1933312
  store <4096 x float> zeroinitializer, ptr %970, align 4
  %971 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %972 = getelementptr float, ptr %971, i64 1937408
  store <4096 x float> zeroinitializer, ptr %972, align 4
  %973 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %974 = getelementptr float, ptr %973, i64 1941504
  store <4096 x float> zeroinitializer, ptr %974, align 4
  %975 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %976 = getelementptr float, ptr %975, i64 1945600
  store <4096 x float> zeroinitializer, ptr %976, align 4
  %977 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %978 = getelementptr float, ptr %977, i64 1949696
  store <4096 x float> zeroinitializer, ptr %978, align 4
  %979 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %980 = getelementptr float, ptr %979, i64 1953792
  store <4096 x float> zeroinitializer, ptr %980, align 4
  %981 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %982 = getelementptr float, ptr %981, i64 1957888
  store <4096 x float> zeroinitializer, ptr %982, align 4
  %983 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %984 = getelementptr float, ptr %983, i64 1961984
  store <4096 x float> zeroinitializer, ptr %984, align 4
  %985 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %986 = getelementptr float, ptr %985, i64 1966080
  store <4096 x float> zeroinitializer, ptr %986, align 4
  %987 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %988 = getelementptr float, ptr %987, i64 1970176
  store <4096 x float> zeroinitializer, ptr %988, align 4
  %989 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %990 = getelementptr float, ptr %989, i64 1974272
  store <4096 x float> zeroinitializer, ptr %990, align 4
  %991 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %992 = getelementptr float, ptr %991, i64 1978368
  store <4096 x float> zeroinitializer, ptr %992, align 4
  %993 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %994 = getelementptr float, ptr %993, i64 1982464
  store <4096 x float> zeroinitializer, ptr %994, align 4
  %995 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %996 = getelementptr float, ptr %995, i64 1986560
  store <4096 x float> zeroinitializer, ptr %996, align 4
  %997 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %998 = getelementptr float, ptr %997, i64 1990656
  store <4096 x float> zeroinitializer, ptr %998, align 4
  %999 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1000 = getelementptr float, ptr %999, i64 1994752
  store <4096 x float> zeroinitializer, ptr %1000, align 4
  %1001 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1002 = getelementptr float, ptr %1001, i64 1998848
  store <4096 x float> zeroinitializer, ptr %1002, align 4
  %1003 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1004 = getelementptr float, ptr %1003, i64 2002944
  store <4096 x float> zeroinitializer, ptr %1004, align 4
  %1005 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1006 = getelementptr float, ptr %1005, i64 2007040
  store <4096 x float> zeroinitializer, ptr %1006, align 4
  %1007 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1008 = getelementptr float, ptr %1007, i64 2011136
  store <4096 x float> zeroinitializer, ptr %1008, align 4
  %1009 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1010 = getelementptr float, ptr %1009, i64 2015232
  store <4096 x float> zeroinitializer, ptr %1010, align 4
  %1011 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1012 = getelementptr float, ptr %1011, i64 2019328
  store <4096 x float> zeroinitializer, ptr %1012, align 4
  %1013 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1014 = getelementptr float, ptr %1013, i64 2023424
  store <4096 x float> zeroinitializer, ptr %1014, align 4
  %1015 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1016 = getelementptr float, ptr %1015, i64 2027520
  store <4096 x float> zeroinitializer, ptr %1016, align 4
  %1017 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1018 = getelementptr float, ptr %1017, i64 2031616
  store <4096 x float> zeroinitializer, ptr %1018, align 4
  %1019 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1020 = getelementptr float, ptr %1019, i64 2035712
  store <4096 x float> zeroinitializer, ptr %1020, align 4
  %1021 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1022 = getelementptr float, ptr %1021, i64 2039808
  store <4096 x float> zeroinitializer, ptr %1022, align 4
  %1023 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1024 = getelementptr float, ptr %1023, i64 2043904
  store <4096 x float> zeroinitializer, ptr %1024, align 4
  %1025 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1026 = getelementptr float, ptr %1025, i64 2048000
  store <4096 x float> zeroinitializer, ptr %1026, align 4
  %1027 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1028 = getelementptr float, ptr %1027, i64 2052096
  store <4096 x float> zeroinitializer, ptr %1028, align 4
  %1029 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1030 = getelementptr float, ptr %1029, i64 2056192
  store <4096 x float> zeroinitializer, ptr %1030, align 4
  %1031 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1032 = getelementptr float, ptr %1031, i64 2060288
  store <4096 x float> zeroinitializer, ptr %1032, align 4
  %1033 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1034 = getelementptr float, ptr %1033, i64 2064384
  store <4096 x float> zeroinitializer, ptr %1034, align 4
  %1035 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1036 = getelementptr float, ptr %1035, i64 2068480
  store <4096 x float> zeroinitializer, ptr %1036, align 4
  %1037 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1038 = getelementptr float, ptr %1037, i64 2072576
  store <4096 x float> zeroinitializer, ptr %1038, align 4
  %1039 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1040 = getelementptr float, ptr %1039, i64 2076672
  store <4096 x float> zeroinitializer, ptr %1040, align 4
  %1041 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1042 = getelementptr float, ptr %1041, i64 2080768
  store <4096 x float> zeroinitializer, ptr %1042, align 4
  %1043 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1044 = getelementptr float, ptr %1043, i64 2084864
  store <4096 x float> zeroinitializer, ptr %1044, align 4
  %1045 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1046 = getelementptr float, ptr %1045, i64 2088960
  store <4096 x float> zeroinitializer, ptr %1046, align 4
  %1047 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1048 = getelementptr float, ptr %1047, i64 2093056
  store <4096 x float> zeroinitializer, ptr %1048, align 4
  %1049 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1050 = getelementptr float, ptr %1049, i64 2097152
  store <4096 x float> zeroinitializer, ptr %1050, align 4
  %1051 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1052 = getelementptr float, ptr %1051, i64 2101248
  store <4096 x float> zeroinitializer, ptr %1052, align 4
  %1053 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1054 = getelementptr float, ptr %1053, i64 2105344
  store <4096 x float> zeroinitializer, ptr %1054, align 4
  %1055 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1056 = getelementptr float, ptr %1055, i64 2109440
  store <4096 x float> zeroinitializer, ptr %1056, align 4
  %1057 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1058 = getelementptr float, ptr %1057, i64 2113536
  store <4096 x float> zeroinitializer, ptr %1058, align 4
  %1059 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1060 = getelementptr float, ptr %1059, i64 2117632
  store <4096 x float> zeroinitializer, ptr %1060, align 4
  %1061 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1062 = getelementptr float, ptr %1061, i64 2121728
  store <4096 x float> zeroinitializer, ptr %1062, align 4
  %1063 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1064 = getelementptr float, ptr %1063, i64 2125824
  store <4096 x float> zeroinitializer, ptr %1064, align 4
  %1065 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1066 = getelementptr float, ptr %1065, i64 2129920
  store <4096 x float> zeroinitializer, ptr %1066, align 4
  %1067 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1068 = getelementptr float, ptr %1067, i64 2134016
  store <4096 x float> zeroinitializer, ptr %1068, align 4
  %1069 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1070 = getelementptr float, ptr %1069, i64 2138112
  store <4096 x float> zeroinitializer, ptr %1070, align 4
  %1071 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1072 = getelementptr float, ptr %1071, i64 2142208
  store <4096 x float> zeroinitializer, ptr %1072, align 4
  %1073 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1074 = getelementptr float, ptr %1073, i64 2146304
  store <4096 x float> zeroinitializer, ptr %1074, align 4
  %1075 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1076 = getelementptr float, ptr %1075, i64 2150400
  store <4096 x float> zeroinitializer, ptr %1076, align 4
  %1077 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1078 = getelementptr float, ptr %1077, i64 2154496
  store <4096 x float> zeroinitializer, ptr %1078, align 4
  %1079 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1080 = getelementptr float, ptr %1079, i64 2158592
  store <4096 x float> zeroinitializer, ptr %1080, align 4
  %1081 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1082 = getelementptr float, ptr %1081, i64 2162688
  store <4096 x float> zeroinitializer, ptr %1082, align 4
  %1083 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1084 = getelementptr float, ptr %1083, i64 2166784
  store <4096 x float> zeroinitializer, ptr %1084, align 4
  %1085 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1086 = getelementptr float, ptr %1085, i64 2170880
  store <4096 x float> zeroinitializer, ptr %1086, align 4
  %1087 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1088 = getelementptr float, ptr %1087, i64 2174976
  store <4096 x float> zeroinitializer, ptr %1088, align 4
  %1089 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1090 = getelementptr float, ptr %1089, i64 2179072
  store <4096 x float> zeroinitializer, ptr %1090, align 4
  %1091 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1092 = getelementptr float, ptr %1091, i64 2183168
  store <4096 x float> zeroinitializer, ptr %1092, align 4
  %1093 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1094 = getelementptr float, ptr %1093, i64 2187264
  store <4096 x float> zeroinitializer, ptr %1094, align 4
  %1095 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1096 = getelementptr float, ptr %1095, i64 2191360
  store <4096 x float> zeroinitializer, ptr %1096, align 4
  %1097 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1098 = getelementptr float, ptr %1097, i64 2195456
  store <4096 x float> zeroinitializer, ptr %1098, align 4
  %1099 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1100 = getelementptr float, ptr %1099, i64 2199552
  store <4096 x float> zeroinitializer, ptr %1100, align 4
  %1101 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1102 = getelementptr float, ptr %1101, i64 2203648
  store <4096 x float> zeroinitializer, ptr %1102, align 4
  %1103 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1104 = getelementptr float, ptr %1103, i64 2207744
  store <4096 x float> zeroinitializer, ptr %1104, align 4
  %1105 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1106 = getelementptr float, ptr %1105, i64 2211840
  store <4096 x float> zeroinitializer, ptr %1106, align 4
  %1107 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1108 = getelementptr float, ptr %1107, i64 2215936
  store <4096 x float> zeroinitializer, ptr %1108, align 4
  %1109 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1110 = getelementptr float, ptr %1109, i64 2220032
  store <4096 x float> zeroinitializer, ptr %1110, align 4
  %1111 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1112 = getelementptr float, ptr %1111, i64 2224128
  store <4096 x float> zeroinitializer, ptr %1112, align 4
  %1113 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1114 = getelementptr float, ptr %1113, i64 2228224
  store <4096 x float> zeroinitializer, ptr %1114, align 4
  %1115 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1116 = getelementptr float, ptr %1115, i64 2232320
  store <4096 x float> zeroinitializer, ptr %1116, align 4
  %1117 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1118 = getelementptr float, ptr %1117, i64 2236416
  store <4096 x float> zeroinitializer, ptr %1118, align 4
  %1119 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1120 = getelementptr float, ptr %1119, i64 2240512
  store <4096 x float> zeroinitializer, ptr %1120, align 4
  %1121 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1122 = getelementptr float, ptr %1121, i64 2244608
  store <4096 x float> zeroinitializer, ptr %1122, align 4
  %1123 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1124 = getelementptr float, ptr %1123, i64 2248704
  store <4096 x float> zeroinitializer, ptr %1124, align 4
  %1125 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1126 = getelementptr float, ptr %1125, i64 2252800
  store <4096 x float> zeroinitializer, ptr %1126, align 4
  %1127 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1128 = getelementptr float, ptr %1127, i64 2256896
  store <4096 x float> zeroinitializer, ptr %1128, align 4
  %1129 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1130 = getelementptr float, ptr %1129, i64 2260992
  store <4096 x float> zeroinitializer, ptr %1130, align 4
  %1131 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1132 = getelementptr float, ptr %1131, i64 2265088
  store <4096 x float> zeroinitializer, ptr %1132, align 4
  %1133 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1134 = getelementptr float, ptr %1133, i64 2269184
  store <4096 x float> zeroinitializer, ptr %1134, align 4
  %1135 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1136 = getelementptr float, ptr %1135, i64 2273280
  store <4096 x float> zeroinitializer, ptr %1136, align 4
  %1137 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1138 = getelementptr float, ptr %1137, i64 2277376
  store <4096 x float> zeroinitializer, ptr %1138, align 4
  %1139 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1140 = getelementptr float, ptr %1139, i64 2281472
  store <4096 x float> zeroinitializer, ptr %1140, align 4
  %1141 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1142 = getelementptr float, ptr %1141, i64 2285568
  store <4096 x float> zeroinitializer, ptr %1142, align 4
  %1143 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1144 = getelementptr float, ptr %1143, i64 2289664
  store <4096 x float> zeroinitializer, ptr %1144, align 4
  %1145 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1146 = getelementptr float, ptr %1145, i64 2293760
  store <4096 x float> zeroinitializer, ptr %1146, align 4
  %1147 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1148 = getelementptr float, ptr %1147, i64 2297856
  store <4096 x float> zeroinitializer, ptr %1148, align 4
  %1149 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1150 = getelementptr float, ptr %1149, i64 2301952
  store <4096 x float> zeroinitializer, ptr %1150, align 4
  %1151 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1152 = getelementptr float, ptr %1151, i64 2306048
  store <4096 x float> zeroinitializer, ptr %1152, align 4
  %1153 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1154 = getelementptr float, ptr %1153, i64 2310144
  store <4096 x float> zeroinitializer, ptr %1154, align 4
  %1155 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1156 = getelementptr float, ptr %1155, i64 2314240
  store <4096 x float> zeroinitializer, ptr %1156, align 4
  %1157 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1158 = getelementptr float, ptr %1157, i64 2318336
  store <4096 x float> zeroinitializer, ptr %1158, align 4
  %1159 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1160 = getelementptr float, ptr %1159, i64 2322432
  store <4096 x float> zeroinitializer, ptr %1160, align 4
  %1161 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1162 = getelementptr float, ptr %1161, i64 2326528
  store <4096 x float> zeroinitializer, ptr %1162, align 4
  %1163 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1164 = getelementptr float, ptr %1163, i64 2330624
  store <4096 x float> zeroinitializer, ptr %1164, align 4
  %1165 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1166 = getelementptr float, ptr %1165, i64 2334720
  store <4096 x float> zeroinitializer, ptr %1166, align 4
  %1167 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1168 = getelementptr float, ptr %1167, i64 2338816
  store <4096 x float> zeroinitializer, ptr %1168, align 4
  %1169 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1170 = getelementptr float, ptr %1169, i64 2342912
  store <4096 x float> zeroinitializer, ptr %1170, align 4
  %1171 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1172 = getelementptr float, ptr %1171, i64 2347008
  store <4096 x float> zeroinitializer, ptr %1172, align 4
  %1173 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1174 = getelementptr float, ptr %1173, i64 2351104
  store <4096 x float> zeroinitializer, ptr %1174, align 4
  %1175 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1176 = getelementptr float, ptr %1175, i64 2355200
  store <4096 x float> zeroinitializer, ptr %1176, align 4
  %1177 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1178 = getelementptr float, ptr %1177, i64 2359296
  store <4096 x float> zeroinitializer, ptr %1178, align 4
  %1179 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1180 = getelementptr float, ptr %1179, i64 2363392
  store <4096 x float> zeroinitializer, ptr %1180, align 4
  %1181 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1182 = getelementptr float, ptr %1181, i64 2367488
  store <4096 x float> zeroinitializer, ptr %1182, align 4
  %1183 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1184 = getelementptr float, ptr %1183, i64 2371584
  store <4096 x float> zeroinitializer, ptr %1184, align 4
  %1185 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1186 = getelementptr float, ptr %1185, i64 2375680
  store <4096 x float> zeroinitializer, ptr %1186, align 4
  %1187 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1188 = getelementptr float, ptr %1187, i64 2379776
  store <4096 x float> zeroinitializer, ptr %1188, align 4
  %1189 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1190 = getelementptr float, ptr %1189, i64 2383872
  store <4096 x float> zeroinitializer, ptr %1190, align 4
  %1191 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1192 = getelementptr float, ptr %1191, i64 2387968
  store <4096 x float> zeroinitializer, ptr %1192, align 4
  %1193 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1194 = getelementptr float, ptr %1193, i64 2392064
  store <4096 x float> zeroinitializer, ptr %1194, align 4
  %1195 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1196 = getelementptr float, ptr %1195, i64 2396160
  store <4096 x float> zeroinitializer, ptr %1196, align 4
  %1197 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1198 = getelementptr float, ptr %1197, i64 2400256
  store <4096 x float> zeroinitializer, ptr %1198, align 4
  %1199 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1200 = getelementptr float, ptr %1199, i64 2404352
  store <4096 x float> zeroinitializer, ptr %1200, align 4
  %1201 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1202 = getelementptr float, ptr %1201, i64 2408448
  store <4096 x float> zeroinitializer, ptr %1202, align 4
  %1203 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1204 = getelementptr float, ptr %1203, i64 2412544
  store <4096 x float> zeroinitializer, ptr %1204, align 4
  %1205 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1206 = getelementptr float, ptr %1205, i64 2416640
  store <4096 x float> zeroinitializer, ptr %1206, align 4
  %1207 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1208 = getelementptr float, ptr %1207, i64 2420736
  store <4096 x float> zeroinitializer, ptr %1208, align 4
  %1209 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1210 = getelementptr float, ptr %1209, i64 2424832
  store <4096 x float> zeroinitializer, ptr %1210, align 4
  %1211 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1212 = getelementptr float, ptr %1211, i64 2428928
  store <4096 x float> zeroinitializer, ptr %1212, align 4
  %1213 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1214 = getelementptr float, ptr %1213, i64 2433024
  store <4096 x float> zeroinitializer, ptr %1214, align 4
  %1215 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1216 = getelementptr float, ptr %1215, i64 2437120
  store <4096 x float> zeroinitializer, ptr %1216, align 4
  %1217 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1218 = getelementptr float, ptr %1217, i64 2441216
  store <4096 x float> zeroinitializer, ptr %1218, align 4
  %1219 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1220 = getelementptr float, ptr %1219, i64 2445312
  store <4096 x float> zeroinitializer, ptr %1220, align 4
  %1221 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1222 = getelementptr float, ptr %1221, i64 2449408
  store <4096 x float> zeroinitializer, ptr %1222, align 4
  %1223 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1224 = getelementptr float, ptr %1223, i64 2453504
  store <4096 x float> zeroinitializer, ptr %1224, align 4
  %1225 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1226 = getelementptr float, ptr %1225, i64 2457600
  store <4096 x float> zeroinitializer, ptr %1226, align 4
  %1227 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1228 = getelementptr float, ptr %1227, i64 2461696
  store <4096 x float> zeroinitializer, ptr %1228, align 4
  %1229 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1230 = getelementptr float, ptr %1229, i64 2465792
  store <4096 x float> zeroinitializer, ptr %1230, align 4
  %1231 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1232 = getelementptr float, ptr %1231, i64 2469888
  store <4096 x float> zeroinitializer, ptr %1232, align 4
  %1233 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1234 = getelementptr float, ptr %1233, i64 2473984
  store <4096 x float> zeroinitializer, ptr %1234, align 4
  %1235 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1236 = getelementptr float, ptr %1235, i64 2478080
  store <4096 x float> zeroinitializer, ptr %1236, align 4
  %1237 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1238 = getelementptr float, ptr %1237, i64 2482176
  store <4096 x float> zeroinitializer, ptr %1238, align 4
  %1239 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1240 = getelementptr float, ptr %1239, i64 2486272
  store <4096 x float> zeroinitializer, ptr %1240, align 4
  %1241 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1242 = getelementptr float, ptr %1241, i64 2490368
  store <4096 x float> zeroinitializer, ptr %1242, align 4
  %1243 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1244 = getelementptr float, ptr %1243, i64 2494464
  store <4096 x float> zeroinitializer, ptr %1244, align 4
  %1245 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1246 = getelementptr float, ptr %1245, i64 2498560
  store <4096 x float> zeroinitializer, ptr %1246, align 4
  %1247 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1248 = getelementptr float, ptr %1247, i64 2502656
  store <4096 x float> zeroinitializer, ptr %1248, align 4
  %1249 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1250 = getelementptr float, ptr %1249, i64 2506752
  store <4096 x float> zeroinitializer, ptr %1250, align 4
  %1251 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1252 = getelementptr float, ptr %1251, i64 2510848
  store <4096 x float> zeroinitializer, ptr %1252, align 4
  %1253 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1254 = getelementptr float, ptr %1253, i64 2514944
  store <4096 x float> zeroinitializer, ptr %1254, align 4
  %1255 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1256 = getelementptr float, ptr %1255, i64 2519040
  store <4096 x float> zeroinitializer, ptr %1256, align 4
  %1257 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1258 = getelementptr float, ptr %1257, i64 2523136
  store <4096 x float> zeroinitializer, ptr %1258, align 4
  %1259 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1260 = getelementptr float, ptr %1259, i64 2527232
  store <4096 x float> zeroinitializer, ptr %1260, align 4
  %1261 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1262 = getelementptr float, ptr %1261, i64 2531328
  store <4096 x float> zeroinitializer, ptr %1262, align 4
  %1263 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1264 = getelementptr float, ptr %1263, i64 2535424
  store <4096 x float> zeroinitializer, ptr %1264, align 4
  %1265 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1266 = getelementptr float, ptr %1265, i64 2539520
  store <4096 x float> zeroinitializer, ptr %1266, align 4
  %1267 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1268 = getelementptr float, ptr %1267, i64 2543616
  store <4096 x float> zeroinitializer, ptr %1268, align 4
  %1269 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1270 = getelementptr float, ptr %1269, i64 2547712
  store <4096 x float> zeroinitializer, ptr %1270, align 4
  %1271 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1272 = getelementptr float, ptr %1271, i64 2551808
  store <4096 x float> zeroinitializer, ptr %1272, align 4
  %1273 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1274 = getelementptr float, ptr %1273, i64 2555904
  store <4096 x float> zeroinitializer, ptr %1274, align 4
  %1275 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1276 = getelementptr float, ptr %1275, i64 2560000
  store <4096 x float> zeroinitializer, ptr %1276, align 4
  %1277 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1278 = getelementptr float, ptr %1277, i64 2564096
  store <4096 x float> zeroinitializer, ptr %1278, align 4
  %1279 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1280 = getelementptr float, ptr %1279, i64 2568192
  store <4096 x float> zeroinitializer, ptr %1280, align 4
  %1281 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1282 = getelementptr float, ptr %1281, i64 2572288
  store <4096 x float> zeroinitializer, ptr %1282, align 4
  %1283 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1284 = getelementptr float, ptr %1283, i64 2576384
  store <4096 x float> zeroinitializer, ptr %1284, align 4
  %1285 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1286 = getelementptr float, ptr %1285, i64 2580480
  store <4096 x float> zeroinitializer, ptr %1286, align 4
  %1287 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1288 = getelementptr float, ptr %1287, i64 2584576
  store <4096 x float> zeroinitializer, ptr %1288, align 4
  %1289 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1290 = getelementptr float, ptr %1289, i64 2588672
  store <4096 x float> zeroinitializer, ptr %1290, align 4
  %1291 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1292 = getelementptr float, ptr %1291, i64 2592768
  store <4096 x float> zeroinitializer, ptr %1292, align 4
  %1293 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1294 = getelementptr float, ptr %1293, i64 2596864
  store <4096 x float> zeroinitializer, ptr %1294, align 4
  %1295 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1296 = getelementptr float, ptr %1295, i64 2600960
  store <4096 x float> zeroinitializer, ptr %1296, align 4
  %1297 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1298 = getelementptr float, ptr %1297, i64 2605056
  store <4096 x float> zeroinitializer, ptr %1298, align 4
  %1299 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1300 = getelementptr float, ptr %1299, i64 2609152
  store <4096 x float> zeroinitializer, ptr %1300, align 4
  %1301 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1302 = getelementptr float, ptr %1301, i64 2613248
  store <4096 x float> zeroinitializer, ptr %1302, align 4
  %1303 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1304 = getelementptr float, ptr %1303, i64 2617344
  store <4096 x float> zeroinitializer, ptr %1304, align 4
  %1305 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1306 = getelementptr float, ptr %1305, i64 2621440
  store <4096 x float> zeroinitializer, ptr %1306, align 4
  %1307 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1308 = getelementptr float, ptr %1307, i64 2625536
  store <4096 x float> zeroinitializer, ptr %1308, align 4
  %1309 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1310 = getelementptr float, ptr %1309, i64 2629632
  store <4096 x float> zeroinitializer, ptr %1310, align 4
  %1311 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1312 = getelementptr float, ptr %1311, i64 2633728
  store <4096 x float> zeroinitializer, ptr %1312, align 4
  %1313 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1314 = getelementptr float, ptr %1313, i64 2637824
  store <4096 x float> zeroinitializer, ptr %1314, align 4
  %1315 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1316 = getelementptr float, ptr %1315, i64 2641920
  store <4096 x float> zeroinitializer, ptr %1316, align 4
  %1317 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1318 = getelementptr float, ptr %1317, i64 2646016
  store <4096 x float> zeroinitializer, ptr %1318, align 4
  %1319 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1320 = getelementptr float, ptr %1319, i64 2650112
  store <4096 x float> zeroinitializer, ptr %1320, align 4
  %1321 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1322 = getelementptr float, ptr %1321, i64 2654208
  store <4096 x float> zeroinitializer, ptr %1322, align 4
  %1323 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1324 = getelementptr float, ptr %1323, i64 2658304
  store <4096 x float> zeroinitializer, ptr %1324, align 4
  %1325 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1326 = getelementptr float, ptr %1325, i64 2662400
  store <4096 x float> zeroinitializer, ptr %1326, align 4
  %1327 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1328 = getelementptr float, ptr %1327, i64 2666496
  store <4096 x float> zeroinitializer, ptr %1328, align 4
  %1329 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1330 = getelementptr float, ptr %1329, i64 2670592
  store <4096 x float> zeroinitializer, ptr %1330, align 4
  %1331 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1332 = getelementptr float, ptr %1331, i64 2674688
  store <4096 x float> zeroinitializer, ptr %1332, align 4
  %1333 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1334 = getelementptr float, ptr %1333, i64 2678784
  store <4096 x float> zeroinitializer, ptr %1334, align 4
  %1335 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1336 = getelementptr float, ptr %1335, i64 2682880
  store <4096 x float> zeroinitializer, ptr %1336, align 4
  %1337 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1338 = getelementptr float, ptr %1337, i64 2686976
  store <4096 x float> zeroinitializer, ptr %1338, align 4
  %1339 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1340 = getelementptr float, ptr %1339, i64 2691072
  store <4096 x float> zeroinitializer, ptr %1340, align 4
  %1341 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1342 = getelementptr float, ptr %1341, i64 2695168
  store <4096 x float> zeroinitializer, ptr %1342, align 4
  %1343 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1344 = getelementptr float, ptr %1343, i64 2699264
  store <4096 x float> zeroinitializer, ptr %1344, align 4
  %1345 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1346 = getelementptr float, ptr %1345, i64 2703360
  store <4096 x float> zeroinitializer, ptr %1346, align 4
  %1347 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1348 = getelementptr float, ptr %1347, i64 2707456
  store <4096 x float> zeroinitializer, ptr %1348, align 4
  %1349 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1350 = getelementptr float, ptr %1349, i64 2711552
  store <4096 x float> zeroinitializer, ptr %1350, align 4
  %1351 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1352 = getelementptr float, ptr %1351, i64 2715648
  store <4096 x float> zeroinitializer, ptr %1352, align 4
  %1353 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1354 = getelementptr float, ptr %1353, i64 2719744
  store <4096 x float> zeroinitializer, ptr %1354, align 4
  %1355 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1356 = getelementptr float, ptr %1355, i64 2723840
  store <4096 x float> zeroinitializer, ptr %1356, align 4
  %1357 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1358 = getelementptr float, ptr %1357, i64 2727936
  store <4096 x float> zeroinitializer, ptr %1358, align 4
  %1359 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1360 = getelementptr float, ptr %1359, i64 2732032
  store <4096 x float> zeroinitializer, ptr %1360, align 4
  %1361 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1362 = getelementptr float, ptr %1361, i64 2736128
  store <4096 x float> zeroinitializer, ptr %1362, align 4
  %1363 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1364 = getelementptr float, ptr %1363, i64 2740224
  store <4096 x float> zeroinitializer, ptr %1364, align 4
  %1365 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1366 = getelementptr float, ptr %1365, i64 2744320
  store <4096 x float> zeroinitializer, ptr %1366, align 4
  %1367 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1368 = getelementptr float, ptr %1367, i64 2748416
  store <4096 x float> zeroinitializer, ptr %1368, align 4
  %1369 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1370 = getelementptr float, ptr %1369, i64 2752512
  store <4096 x float> zeroinitializer, ptr %1370, align 4
  %1371 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1372 = getelementptr float, ptr %1371, i64 2756608
  store <4096 x float> zeroinitializer, ptr %1372, align 4
  %1373 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1374 = getelementptr float, ptr %1373, i64 2760704
  store <4096 x float> zeroinitializer, ptr %1374, align 4
  %1375 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1376 = getelementptr float, ptr %1375, i64 2764800
  store <4096 x float> zeroinitializer, ptr %1376, align 4
  %1377 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1378 = getelementptr float, ptr %1377, i64 2768896
  store <4096 x float> zeroinitializer, ptr %1378, align 4
  %1379 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1380 = getelementptr float, ptr %1379, i64 2772992
  store <4096 x float> zeroinitializer, ptr %1380, align 4
  %1381 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1382 = getelementptr float, ptr %1381, i64 2777088
  store <4096 x float> zeroinitializer, ptr %1382, align 4
  %1383 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1384 = getelementptr float, ptr %1383, i64 2781184
  store <4096 x float> zeroinitializer, ptr %1384, align 4
  %1385 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1386 = getelementptr float, ptr %1385, i64 2785280
  store <4096 x float> zeroinitializer, ptr %1386, align 4
  %1387 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1388 = getelementptr float, ptr %1387, i64 2789376
  store <4096 x float> zeroinitializer, ptr %1388, align 4
  %1389 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1390 = getelementptr float, ptr %1389, i64 2793472
  store <4096 x float> zeroinitializer, ptr %1390, align 4
  %1391 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1392 = getelementptr float, ptr %1391, i64 2797568
  store <4096 x float> zeroinitializer, ptr %1392, align 4
  %1393 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1394 = getelementptr float, ptr %1393, i64 2801664
  store <4096 x float> zeroinitializer, ptr %1394, align 4
  %1395 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1396 = getelementptr float, ptr %1395, i64 2805760
  store <4096 x float> zeroinitializer, ptr %1396, align 4
  %1397 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1398 = getelementptr float, ptr %1397, i64 2809856
  store <4096 x float> zeroinitializer, ptr %1398, align 4
  %1399 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1400 = getelementptr float, ptr %1399, i64 2813952
  store <4096 x float> zeroinitializer, ptr %1400, align 4
  %1401 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1402 = getelementptr float, ptr %1401, i64 2818048
  store <4096 x float> zeroinitializer, ptr %1402, align 4
  %1403 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1404 = getelementptr float, ptr %1403, i64 2822144
  store <4096 x float> zeroinitializer, ptr %1404, align 4
  %1405 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1406 = getelementptr float, ptr %1405, i64 2826240
  store <4096 x float> zeroinitializer, ptr %1406, align 4
  %1407 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1408 = getelementptr float, ptr %1407, i64 2830336
  store <4096 x float> zeroinitializer, ptr %1408, align 4
  %1409 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1410 = getelementptr float, ptr %1409, i64 2834432
  store <4096 x float> zeroinitializer, ptr %1410, align 4
  %1411 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1412 = getelementptr float, ptr %1411, i64 2838528
  store <4096 x float> zeroinitializer, ptr %1412, align 4
  %1413 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1414 = getelementptr float, ptr %1413, i64 2842624
  store <4096 x float> zeroinitializer, ptr %1414, align 4
  %1415 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1416 = getelementptr float, ptr %1415, i64 2846720
  store <4096 x float> zeroinitializer, ptr %1416, align 4
  %1417 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1418 = getelementptr float, ptr %1417, i64 2850816
  store <4096 x float> zeroinitializer, ptr %1418, align 4
  %1419 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1420 = getelementptr float, ptr %1419, i64 2854912
  store <4096 x float> zeroinitializer, ptr %1420, align 4
  %1421 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1422 = getelementptr float, ptr %1421, i64 2859008
  store <4096 x float> zeroinitializer, ptr %1422, align 4
  %1423 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1424 = getelementptr float, ptr %1423, i64 2863104
  store <4096 x float> zeroinitializer, ptr %1424, align 4
  %1425 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1426 = getelementptr float, ptr %1425, i64 2867200
  store <4096 x float> zeroinitializer, ptr %1426, align 4
  %1427 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1428 = getelementptr float, ptr %1427, i64 2871296
  store <4096 x float> zeroinitializer, ptr %1428, align 4
  %1429 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1430 = getelementptr float, ptr %1429, i64 2875392
  store <4096 x float> zeroinitializer, ptr %1430, align 4
  %1431 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1432 = getelementptr float, ptr %1431, i64 2879488
  store <4096 x float> zeroinitializer, ptr %1432, align 4
  %1433 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1434 = getelementptr float, ptr %1433, i64 2883584
  store <4096 x float> zeroinitializer, ptr %1434, align 4
  %1435 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1436 = getelementptr float, ptr %1435, i64 2887680
  store <4096 x float> zeroinitializer, ptr %1436, align 4
  %1437 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1438 = getelementptr float, ptr %1437, i64 2891776
  store <4096 x float> zeroinitializer, ptr %1438, align 4
  %1439 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1440 = getelementptr float, ptr %1439, i64 2895872
  store <4096 x float> zeroinitializer, ptr %1440, align 4
  %1441 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1442 = getelementptr float, ptr %1441, i64 2899968
  store <4096 x float> zeroinitializer, ptr %1442, align 4
  %1443 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1444 = getelementptr float, ptr %1443, i64 2904064
  store <4096 x float> zeroinitializer, ptr %1444, align 4
  %1445 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1446 = getelementptr float, ptr %1445, i64 2908160
  store <4096 x float> zeroinitializer, ptr %1446, align 4
  %1447 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1448 = getelementptr float, ptr %1447, i64 2912256
  store <4096 x float> zeroinitializer, ptr %1448, align 4
  %1449 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1450 = getelementptr float, ptr %1449, i64 2916352
  store <4096 x float> zeroinitializer, ptr %1450, align 4
  %1451 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1452 = getelementptr float, ptr %1451, i64 2920448
  store <4096 x float> zeroinitializer, ptr %1452, align 4
  %1453 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1454 = getelementptr float, ptr %1453, i64 2924544
  store <4096 x float> zeroinitializer, ptr %1454, align 4
  %1455 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1456 = getelementptr float, ptr %1455, i64 2928640
  store <4096 x float> zeroinitializer, ptr %1456, align 4
  %1457 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1458 = getelementptr float, ptr %1457, i64 2932736
  store <4096 x float> zeroinitializer, ptr %1458, align 4
  %1459 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1460 = getelementptr float, ptr %1459, i64 2936832
  store <4096 x float> zeroinitializer, ptr %1460, align 4
  %1461 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1462 = getelementptr float, ptr %1461, i64 2940928
  store <4096 x float> zeroinitializer, ptr %1462, align 4
  %1463 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1464 = getelementptr float, ptr %1463, i64 2945024
  store <4096 x float> zeroinitializer, ptr %1464, align 4
  %1465 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1466 = getelementptr float, ptr %1465, i64 2949120
  store <4096 x float> zeroinitializer, ptr %1466, align 4
  %1467 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1468 = getelementptr float, ptr %1467, i64 2953216
  store <4096 x float> zeroinitializer, ptr %1468, align 4
  %1469 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1470 = getelementptr float, ptr %1469, i64 2957312
  store <4096 x float> zeroinitializer, ptr %1470, align 4
  %1471 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1472 = getelementptr float, ptr %1471, i64 2961408
  store <4096 x float> zeroinitializer, ptr %1472, align 4
  %1473 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1474 = getelementptr float, ptr %1473, i64 2965504
  store <4096 x float> zeroinitializer, ptr %1474, align 4
  %1475 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1476 = getelementptr float, ptr %1475, i64 2969600
  store <4096 x float> zeroinitializer, ptr %1476, align 4
  %1477 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1478 = getelementptr float, ptr %1477, i64 2973696
  store <4096 x float> zeroinitializer, ptr %1478, align 4
  %1479 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1480 = getelementptr float, ptr %1479, i64 2977792
  store <4096 x float> zeroinitializer, ptr %1480, align 4
  %1481 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1482 = getelementptr float, ptr %1481, i64 2981888
  store <4096 x float> zeroinitializer, ptr %1482, align 4
  %1483 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1484 = getelementptr float, ptr %1483, i64 2985984
  store <4096 x float> zeroinitializer, ptr %1484, align 4
  %1485 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1486 = getelementptr float, ptr %1485, i64 2990080
  store <4096 x float> zeroinitializer, ptr %1486, align 4
  %1487 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1488 = getelementptr float, ptr %1487, i64 2994176
  store <4096 x float> zeroinitializer, ptr %1488, align 4
  %1489 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1490 = getelementptr float, ptr %1489, i64 2998272
  store <4096 x float> zeroinitializer, ptr %1490, align 4
  %1491 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1492 = getelementptr float, ptr %1491, i64 3002368
  store <4096 x float> zeroinitializer, ptr %1492, align 4
  %1493 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1494 = getelementptr float, ptr %1493, i64 3006464
  store <4096 x float> zeroinitializer, ptr %1494, align 4
  %1495 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1496 = getelementptr float, ptr %1495, i64 3010560
  store <4096 x float> zeroinitializer, ptr %1496, align 4
  %1497 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1498 = getelementptr float, ptr %1497, i64 3014656
  store <4096 x float> zeroinitializer, ptr %1498, align 4
  %1499 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1500 = getelementptr float, ptr %1499, i64 3018752
  store <4096 x float> zeroinitializer, ptr %1500, align 4
  %1501 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1502 = getelementptr float, ptr %1501, i64 3022848
  store <4096 x float> zeroinitializer, ptr %1502, align 4
  %1503 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1504 = getelementptr float, ptr %1503, i64 3026944
  store <4096 x float> zeroinitializer, ptr %1504, align 4
  %1505 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1506 = getelementptr float, ptr %1505, i64 3031040
  store <4096 x float> zeroinitializer, ptr %1506, align 4
  %1507 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1508 = getelementptr float, ptr %1507, i64 3035136
  store <4096 x float> zeroinitializer, ptr %1508, align 4
  %1509 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1510 = getelementptr float, ptr %1509, i64 3039232
  store <4096 x float> zeroinitializer, ptr %1510, align 4
  %1511 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1512 = getelementptr float, ptr %1511, i64 3043328
  store <4096 x float> zeroinitializer, ptr %1512, align 4
  %1513 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1514 = getelementptr float, ptr %1513, i64 3047424
  store <4096 x float> zeroinitializer, ptr %1514, align 4
  %1515 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1516 = getelementptr float, ptr %1515, i64 3051520
  store <4096 x float> zeroinitializer, ptr %1516, align 4
  %1517 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1518 = getelementptr float, ptr %1517, i64 3055616
  store <4096 x float> zeroinitializer, ptr %1518, align 4
  %1519 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1520 = getelementptr float, ptr %1519, i64 3059712
  store <4096 x float> zeroinitializer, ptr %1520, align 4
  %1521 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1522 = getelementptr float, ptr %1521, i64 3063808
  store <4096 x float> zeroinitializer, ptr %1522, align 4
  %1523 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1524 = getelementptr float, ptr %1523, i64 3067904
  store <4096 x float> zeroinitializer, ptr %1524, align 4
  %1525 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1526 = getelementptr float, ptr %1525, i64 3072000
  store <4096 x float> zeroinitializer, ptr %1526, align 4
  %1527 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1528 = getelementptr float, ptr %1527, i64 3076096
  store <4096 x float> zeroinitializer, ptr %1528, align 4
  %1529 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1530 = getelementptr float, ptr %1529, i64 3080192
  store <4096 x float> zeroinitializer, ptr %1530, align 4
  %1531 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1532 = getelementptr float, ptr %1531, i64 3084288
  store <4096 x float> zeroinitializer, ptr %1532, align 4
  %1533 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1534 = getelementptr float, ptr %1533, i64 3088384
  store <4096 x float> zeroinitializer, ptr %1534, align 4
  %1535 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1536 = getelementptr float, ptr %1535, i64 3092480
  store <4096 x float> zeroinitializer, ptr %1536, align 4
  %1537 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1538 = getelementptr float, ptr %1537, i64 3096576
  store <4096 x float> zeroinitializer, ptr %1538, align 4
  %1539 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1540 = getelementptr float, ptr %1539, i64 3100672
  store <4096 x float> zeroinitializer, ptr %1540, align 4
  %1541 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1542 = getelementptr float, ptr %1541, i64 3104768
  store <4096 x float> zeroinitializer, ptr %1542, align 4
  %1543 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1544 = getelementptr float, ptr %1543, i64 3108864
  store <4096 x float> zeroinitializer, ptr %1544, align 4
  %1545 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1546 = getelementptr float, ptr %1545, i64 3112960
  store <4096 x float> zeroinitializer, ptr %1546, align 4
  %1547 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1548 = getelementptr float, ptr %1547, i64 3117056
  store <4096 x float> zeroinitializer, ptr %1548, align 4
  %1549 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1550 = getelementptr float, ptr %1549, i64 3121152
  store <4096 x float> zeroinitializer, ptr %1550, align 4
  %1551 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1552 = getelementptr float, ptr %1551, i64 3125248
  store <4096 x float> zeroinitializer, ptr %1552, align 4
  %1553 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1554 = getelementptr float, ptr %1553, i64 3129344
  store <4096 x float> zeroinitializer, ptr %1554, align 4
  %1555 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1556 = getelementptr float, ptr %1555, i64 3133440
  store <4096 x float> zeroinitializer, ptr %1556, align 4
  %1557 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1558 = getelementptr float, ptr %1557, i64 3137536
  store <4096 x float> zeroinitializer, ptr %1558, align 4
  %1559 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1560 = getelementptr float, ptr %1559, i64 3141632
  store <4096 x float> zeroinitializer, ptr %1560, align 4
  %1561 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1562 = getelementptr float, ptr %1561, i64 3145728
  store <4096 x float> zeroinitializer, ptr %1562, align 4
  %1563 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1564 = getelementptr float, ptr %1563, i64 3149824
  store <4096 x float> zeroinitializer, ptr %1564, align 4
  %1565 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1566 = getelementptr float, ptr %1565, i64 3153920
  store <4096 x float> zeroinitializer, ptr %1566, align 4
  %1567 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1568 = getelementptr float, ptr %1567, i64 3158016
  store <4096 x float> zeroinitializer, ptr %1568, align 4
  %1569 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1570 = getelementptr float, ptr %1569, i64 3162112
  store <4096 x float> zeroinitializer, ptr %1570, align 4
  %1571 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1572 = getelementptr float, ptr %1571, i64 3166208
  store <4096 x float> zeroinitializer, ptr %1572, align 4
  %1573 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1574 = getelementptr float, ptr %1573, i64 3170304
  store <4096 x float> zeroinitializer, ptr %1574, align 4
  %1575 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1576 = getelementptr float, ptr %1575, i64 3174400
  store <4096 x float> zeroinitializer, ptr %1576, align 4
  %1577 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1578 = getelementptr float, ptr %1577, i64 3178496
  store <4096 x float> zeroinitializer, ptr %1578, align 4
  %1579 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1580 = getelementptr float, ptr %1579, i64 3182592
  store <4096 x float> zeroinitializer, ptr %1580, align 4
  %1581 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1582 = getelementptr float, ptr %1581, i64 3186688
  store <4096 x float> zeroinitializer, ptr %1582, align 4
  %1583 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1584 = getelementptr float, ptr %1583, i64 3190784
  store <4096 x float> zeroinitializer, ptr %1584, align 4
  %1585 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1586 = getelementptr float, ptr %1585, i64 3194880
  store <4096 x float> zeroinitializer, ptr %1586, align 4
  %1587 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1588 = getelementptr float, ptr %1587, i64 3198976
  store <4096 x float> zeroinitializer, ptr %1588, align 4
  %1589 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1590 = getelementptr float, ptr %1589, i64 3203072
  store <4096 x float> zeroinitializer, ptr %1590, align 4
  %1591 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1592 = getelementptr float, ptr %1591, i64 3207168
  store <4096 x float> zeroinitializer, ptr %1592, align 4
  %1593 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1594 = getelementptr float, ptr %1593, i64 3211264
  store <4096 x float> zeroinitializer, ptr %1594, align 4
  %1595 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1596 = getelementptr float, ptr %1595, i64 3215360
  store <4096 x float> zeroinitializer, ptr %1596, align 4
  %1597 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1598 = getelementptr float, ptr %1597, i64 3219456
  store <4096 x float> zeroinitializer, ptr %1598, align 4
  %1599 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1600 = getelementptr float, ptr %1599, i64 3223552
  store <4096 x float> zeroinitializer, ptr %1600, align 4
  %1601 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1602 = getelementptr float, ptr %1601, i64 3227648
  store <4096 x float> zeroinitializer, ptr %1602, align 4
  %1603 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1604 = getelementptr float, ptr %1603, i64 3231744
  store <4096 x float> zeroinitializer, ptr %1604, align 4
  %1605 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1606 = getelementptr float, ptr %1605, i64 3235840
  store <4096 x float> zeroinitializer, ptr %1606, align 4
  %1607 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1608 = getelementptr float, ptr %1607, i64 3239936
  store <4096 x float> zeroinitializer, ptr %1608, align 4
  %1609 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1610 = getelementptr float, ptr %1609, i64 3244032
  store <4096 x float> zeroinitializer, ptr %1610, align 4
  %1611 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1612 = getelementptr float, ptr %1611, i64 3248128
  store <4096 x float> zeroinitializer, ptr %1612, align 4
  %1613 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1614 = getelementptr float, ptr %1613, i64 3252224
  store <4096 x float> zeroinitializer, ptr %1614, align 4
  %1615 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1616 = getelementptr float, ptr %1615, i64 3256320
  store <4096 x float> zeroinitializer, ptr %1616, align 4
  %1617 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1618 = getelementptr float, ptr %1617, i64 3260416
  store <4096 x float> zeroinitializer, ptr %1618, align 4
  %1619 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1620 = getelementptr float, ptr %1619, i64 3264512
  store <4096 x float> zeroinitializer, ptr %1620, align 4
  %1621 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1622 = getelementptr float, ptr %1621, i64 3268608
  store <4096 x float> zeroinitializer, ptr %1622, align 4
  %1623 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1624 = getelementptr float, ptr %1623, i64 3272704
  store <4096 x float> zeroinitializer, ptr %1624, align 4
  %1625 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1626 = getelementptr float, ptr %1625, i64 3276800
  store <4096 x float> zeroinitializer, ptr %1626, align 4
  %1627 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1628 = getelementptr float, ptr %1627, i64 3280896
  store <4096 x float> zeroinitializer, ptr %1628, align 4
  %1629 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1630 = getelementptr float, ptr %1629, i64 3284992
  store <4096 x float> zeroinitializer, ptr %1630, align 4
  %1631 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1632 = getelementptr float, ptr %1631, i64 3289088
  store <4096 x float> zeroinitializer, ptr %1632, align 4
  %1633 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1634 = getelementptr float, ptr %1633, i64 3293184
  store <4096 x float> zeroinitializer, ptr %1634, align 4
  %1635 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1636 = getelementptr float, ptr %1635, i64 3297280
  store <4096 x float> zeroinitializer, ptr %1636, align 4
  %1637 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1638 = getelementptr float, ptr %1637, i64 3301376
  store <4096 x float> zeroinitializer, ptr %1638, align 4
  %1639 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1640 = getelementptr float, ptr %1639, i64 3305472
  store <4096 x float> zeroinitializer, ptr %1640, align 4
  %1641 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1642 = getelementptr float, ptr %1641, i64 3309568
  store <4096 x float> zeroinitializer, ptr %1642, align 4
  %1643 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1644 = getelementptr float, ptr %1643, i64 3313664
  store <4096 x float> zeroinitializer, ptr %1644, align 4
  %1645 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1646 = getelementptr float, ptr %1645, i64 3317760
  store <4096 x float> zeroinitializer, ptr %1646, align 4
  %1647 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1648 = getelementptr float, ptr %1647, i64 3321856
  store <4096 x float> zeroinitializer, ptr %1648, align 4
  %1649 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1650 = getelementptr float, ptr %1649, i64 3325952
  store <4096 x float> zeroinitializer, ptr %1650, align 4
  %1651 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1652 = getelementptr float, ptr %1651, i64 3330048
  store <4096 x float> zeroinitializer, ptr %1652, align 4
  %1653 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1654 = getelementptr float, ptr %1653, i64 3334144
  store <4096 x float> zeroinitializer, ptr %1654, align 4
  %1655 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1656 = getelementptr float, ptr %1655, i64 3338240
  store <4096 x float> zeroinitializer, ptr %1656, align 4
  %1657 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1658 = getelementptr float, ptr %1657, i64 3342336
  store <4096 x float> zeroinitializer, ptr %1658, align 4
  %1659 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1660 = getelementptr float, ptr %1659, i64 3346432
  store <4096 x float> zeroinitializer, ptr %1660, align 4
  %1661 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1662 = getelementptr float, ptr %1661, i64 3350528
  store <4096 x float> zeroinitializer, ptr %1662, align 4
  %1663 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1664 = getelementptr float, ptr %1663, i64 3354624
  store <4096 x float> zeroinitializer, ptr %1664, align 4
  %1665 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1666 = getelementptr float, ptr %1665, i64 3358720
  store <4096 x float> zeroinitializer, ptr %1666, align 4
  %1667 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1668 = getelementptr float, ptr %1667, i64 3362816
  store <4096 x float> zeroinitializer, ptr %1668, align 4
  %1669 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1670 = getelementptr float, ptr %1669, i64 3366912
  store <4096 x float> zeroinitializer, ptr %1670, align 4
  %1671 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1672 = getelementptr float, ptr %1671, i64 3371008
  store <4096 x float> zeroinitializer, ptr %1672, align 4
  %1673 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1674 = getelementptr float, ptr %1673, i64 3375104
  store <4096 x float> zeroinitializer, ptr %1674, align 4
  %1675 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1676 = getelementptr float, ptr %1675, i64 3379200
  store <4096 x float> zeroinitializer, ptr %1676, align 4
  %1677 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1678 = getelementptr float, ptr %1677, i64 3383296
  store <4096 x float> zeroinitializer, ptr %1678, align 4
  %1679 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1680 = getelementptr float, ptr %1679, i64 3387392
  store <4096 x float> zeroinitializer, ptr %1680, align 4
  %1681 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1682 = getelementptr float, ptr %1681, i64 3391488
  store <4096 x float> zeroinitializer, ptr %1682, align 4
  %1683 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1684 = getelementptr float, ptr %1683, i64 3395584
  store <4096 x float> zeroinitializer, ptr %1684, align 4
  %1685 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1686 = getelementptr float, ptr %1685, i64 3399680
  store <4096 x float> zeroinitializer, ptr %1686, align 4
  %1687 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1688 = getelementptr float, ptr %1687, i64 3403776
  store <4096 x float> zeroinitializer, ptr %1688, align 4
  %1689 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1690 = getelementptr float, ptr %1689, i64 3407872
  store <4096 x float> zeroinitializer, ptr %1690, align 4
  %1691 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1692 = getelementptr float, ptr %1691, i64 3411968
  store <4096 x float> zeroinitializer, ptr %1692, align 4
  %1693 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1694 = getelementptr float, ptr %1693, i64 3416064
  store <4096 x float> zeroinitializer, ptr %1694, align 4
  %1695 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1696 = getelementptr float, ptr %1695, i64 3420160
  store <4096 x float> zeroinitializer, ptr %1696, align 4
  %1697 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1698 = getelementptr float, ptr %1697, i64 3424256
  store <4096 x float> zeroinitializer, ptr %1698, align 4
  %1699 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1700 = getelementptr float, ptr %1699, i64 3428352
  store <4096 x float> zeroinitializer, ptr %1700, align 4
  %1701 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1702 = getelementptr float, ptr %1701, i64 3432448
  store <4096 x float> zeroinitializer, ptr %1702, align 4
  %1703 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1704 = getelementptr float, ptr %1703, i64 3436544
  store <4096 x float> zeroinitializer, ptr %1704, align 4
  %1705 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1706 = getelementptr float, ptr %1705, i64 3440640
  store <4096 x float> zeroinitializer, ptr %1706, align 4
  %1707 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1708 = getelementptr float, ptr %1707, i64 3444736
  store <4096 x float> zeroinitializer, ptr %1708, align 4
  %1709 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1710 = getelementptr float, ptr %1709, i64 3448832
  store <4096 x float> zeroinitializer, ptr %1710, align 4
  %1711 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1712 = getelementptr float, ptr %1711, i64 3452928
  store <4096 x float> zeroinitializer, ptr %1712, align 4
  %1713 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1714 = getelementptr float, ptr %1713, i64 3457024
  store <4096 x float> zeroinitializer, ptr %1714, align 4
  %1715 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1716 = getelementptr float, ptr %1715, i64 3461120
  store <4096 x float> zeroinitializer, ptr %1716, align 4
  %1717 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1718 = getelementptr float, ptr %1717, i64 3465216
  store <4096 x float> zeroinitializer, ptr %1718, align 4
  %1719 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1720 = getelementptr float, ptr %1719, i64 3469312
  store <4096 x float> zeroinitializer, ptr %1720, align 4
  %1721 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1722 = getelementptr float, ptr %1721, i64 3473408
  store <4096 x float> zeroinitializer, ptr %1722, align 4
  %1723 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1724 = getelementptr float, ptr %1723, i64 3477504
  store <4096 x float> zeroinitializer, ptr %1724, align 4
  %1725 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1726 = getelementptr float, ptr %1725, i64 3481600
  store <4096 x float> zeroinitializer, ptr %1726, align 4
  %1727 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1728 = getelementptr float, ptr %1727, i64 3485696
  store <4096 x float> zeroinitializer, ptr %1728, align 4
  %1729 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1730 = getelementptr float, ptr %1729, i64 3489792
  store <4096 x float> zeroinitializer, ptr %1730, align 4
  %1731 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1732 = getelementptr float, ptr %1731, i64 3493888
  store <4096 x float> zeroinitializer, ptr %1732, align 4
  %1733 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1734 = getelementptr float, ptr %1733, i64 3497984
  store <4096 x float> zeroinitializer, ptr %1734, align 4
  %1735 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1736 = getelementptr float, ptr %1735, i64 3502080
  store <4096 x float> zeroinitializer, ptr %1736, align 4
  %1737 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1738 = getelementptr float, ptr %1737, i64 3506176
  store <4096 x float> zeroinitializer, ptr %1738, align 4
  %1739 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1740 = getelementptr float, ptr %1739, i64 3510272
  store <4096 x float> zeroinitializer, ptr %1740, align 4
  %1741 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1742 = getelementptr float, ptr %1741, i64 3514368
  store <4096 x float> zeroinitializer, ptr %1742, align 4
  %1743 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1744 = getelementptr float, ptr %1743, i64 3518464
  store <4096 x float> zeroinitializer, ptr %1744, align 4
  %1745 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1746 = getelementptr float, ptr %1745, i64 3522560
  store <4096 x float> zeroinitializer, ptr %1746, align 4
  %1747 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1748 = getelementptr float, ptr %1747, i64 3526656
  store <4096 x float> zeroinitializer, ptr %1748, align 4
  %1749 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1750 = getelementptr float, ptr %1749, i64 3530752
  store <4096 x float> zeroinitializer, ptr %1750, align 4
  %1751 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1752 = getelementptr float, ptr %1751, i64 3534848
  store <4096 x float> zeroinitializer, ptr %1752, align 4
  %1753 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1754 = getelementptr float, ptr %1753, i64 3538944
  store <4096 x float> zeroinitializer, ptr %1754, align 4
  %1755 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1756 = getelementptr float, ptr %1755, i64 3543040
  store <4096 x float> zeroinitializer, ptr %1756, align 4
  %1757 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1758 = getelementptr float, ptr %1757, i64 3547136
  store <4096 x float> zeroinitializer, ptr %1758, align 4
  %1759 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1760 = getelementptr float, ptr %1759, i64 3551232
  store <4096 x float> zeroinitializer, ptr %1760, align 4
  %1761 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1762 = getelementptr float, ptr %1761, i64 3555328
  store <4096 x float> zeroinitializer, ptr %1762, align 4
  %1763 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1764 = getelementptr float, ptr %1763, i64 3559424
  store <4096 x float> zeroinitializer, ptr %1764, align 4
  %1765 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1766 = getelementptr float, ptr %1765, i64 3563520
  store <4096 x float> zeroinitializer, ptr %1766, align 4
  %1767 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1768 = getelementptr float, ptr %1767, i64 3567616
  store <4096 x float> zeroinitializer, ptr %1768, align 4
  %1769 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1770 = getelementptr float, ptr %1769, i64 3571712
  store <4096 x float> zeroinitializer, ptr %1770, align 4
  %1771 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1772 = getelementptr float, ptr %1771, i64 3575808
  store <4096 x float> zeroinitializer, ptr %1772, align 4
  %1773 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1774 = getelementptr float, ptr %1773, i64 3579904
  store <4096 x float> zeroinitializer, ptr %1774, align 4
  %1775 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1776 = getelementptr float, ptr %1775, i64 3584000
  store <4096 x float> zeroinitializer, ptr %1776, align 4
  %1777 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1778 = getelementptr float, ptr %1777, i64 3588096
  store <4096 x float> zeroinitializer, ptr %1778, align 4
  %1779 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1780 = getelementptr float, ptr %1779, i64 3592192
  store <4096 x float> zeroinitializer, ptr %1780, align 4
  %1781 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1782 = getelementptr float, ptr %1781, i64 3596288
  store <4096 x float> zeroinitializer, ptr %1782, align 4
  %1783 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1784 = getelementptr float, ptr %1783, i64 3600384
  store <4096 x float> zeroinitializer, ptr %1784, align 4
  %1785 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1786 = getelementptr float, ptr %1785, i64 3604480
  store <4096 x float> zeroinitializer, ptr %1786, align 4
  %1787 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1788 = getelementptr float, ptr %1787, i64 3608576
  store <4096 x float> zeroinitializer, ptr %1788, align 4
  %1789 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1790 = getelementptr float, ptr %1789, i64 3612672
  store <4096 x float> zeroinitializer, ptr %1790, align 4
  %1791 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1792 = getelementptr float, ptr %1791, i64 3616768
  store <4096 x float> zeroinitializer, ptr %1792, align 4
  %1793 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1794 = getelementptr float, ptr %1793, i64 3620864
  store <4096 x float> zeroinitializer, ptr %1794, align 4
  %1795 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1796 = getelementptr float, ptr %1795, i64 3624960
  store <4096 x float> zeroinitializer, ptr %1796, align 4
  %1797 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1798 = getelementptr float, ptr %1797, i64 3629056
  store <4096 x float> zeroinitializer, ptr %1798, align 4
  %1799 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1800 = getelementptr float, ptr %1799, i64 3633152
  store <4096 x float> zeroinitializer, ptr %1800, align 4
  %1801 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1802 = getelementptr float, ptr %1801, i64 3637248
  store <4096 x float> zeroinitializer, ptr %1802, align 4
  %1803 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1804 = getelementptr float, ptr %1803, i64 3641344
  store <4096 x float> zeroinitializer, ptr %1804, align 4
  %1805 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1806 = getelementptr float, ptr %1805, i64 3645440
  store <4096 x float> zeroinitializer, ptr %1806, align 4
  %1807 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1808 = getelementptr float, ptr %1807, i64 3649536
  store <4096 x float> zeroinitializer, ptr %1808, align 4
  %1809 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1810 = getelementptr float, ptr %1809, i64 3653632
  store <4096 x float> zeroinitializer, ptr %1810, align 4
  %1811 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1812 = getelementptr float, ptr %1811, i64 3657728
  store <4096 x float> zeroinitializer, ptr %1812, align 4
  %1813 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1814 = getelementptr float, ptr %1813, i64 3661824
  store <4096 x float> zeroinitializer, ptr %1814, align 4
  %1815 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1816 = getelementptr float, ptr %1815, i64 3665920
  store <4096 x float> zeroinitializer, ptr %1816, align 4
  %1817 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1818 = getelementptr float, ptr %1817, i64 3670016
  store <4096 x float> zeroinitializer, ptr %1818, align 4
  %1819 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1820 = getelementptr float, ptr %1819, i64 3674112
  store <4096 x float> zeroinitializer, ptr %1820, align 4
  %1821 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1822 = getelementptr float, ptr %1821, i64 3678208
  store <4096 x float> zeroinitializer, ptr %1822, align 4
  %1823 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1824 = getelementptr float, ptr %1823, i64 3682304
  store <4096 x float> zeroinitializer, ptr %1824, align 4
  %1825 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1826 = getelementptr float, ptr %1825, i64 3686400
  store <4096 x float> zeroinitializer, ptr %1826, align 4
  %1827 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1828 = getelementptr float, ptr %1827, i64 3690496
  store <4096 x float> zeroinitializer, ptr %1828, align 4
  %1829 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1830 = getelementptr float, ptr %1829, i64 3694592
  store <4096 x float> zeroinitializer, ptr %1830, align 4
  %1831 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1832 = getelementptr float, ptr %1831, i64 3698688
  store <4096 x float> zeroinitializer, ptr %1832, align 4
  %1833 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1834 = getelementptr float, ptr %1833, i64 3702784
  store <4096 x float> zeroinitializer, ptr %1834, align 4
  %1835 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1836 = getelementptr float, ptr %1835, i64 3706880
  store <4096 x float> zeroinitializer, ptr %1836, align 4
  %1837 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1838 = getelementptr float, ptr %1837, i64 3710976
  store <4096 x float> zeroinitializer, ptr %1838, align 4
  %1839 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1840 = getelementptr float, ptr %1839, i64 3715072
  store <4096 x float> zeroinitializer, ptr %1840, align 4
  %1841 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1842 = getelementptr float, ptr %1841, i64 3719168
  store <4096 x float> zeroinitializer, ptr %1842, align 4
  %1843 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1844 = getelementptr float, ptr %1843, i64 3723264
  store <4096 x float> zeroinitializer, ptr %1844, align 4
  %1845 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1846 = getelementptr float, ptr %1845, i64 3727360
  store <4096 x float> zeroinitializer, ptr %1846, align 4
  %1847 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1848 = getelementptr float, ptr %1847, i64 3731456
  store <4096 x float> zeroinitializer, ptr %1848, align 4
  %1849 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1850 = getelementptr float, ptr %1849, i64 3735552
  store <4096 x float> zeroinitializer, ptr %1850, align 4
  %1851 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1852 = getelementptr float, ptr %1851, i64 3739648
  store <4096 x float> zeroinitializer, ptr %1852, align 4
  %1853 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1854 = getelementptr float, ptr %1853, i64 3743744
  store <4096 x float> zeroinitializer, ptr %1854, align 4
  %1855 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1856 = getelementptr float, ptr %1855, i64 3747840
  store <4096 x float> zeroinitializer, ptr %1856, align 4
  %1857 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1858 = getelementptr float, ptr %1857, i64 3751936
  store <4096 x float> zeroinitializer, ptr %1858, align 4
  %1859 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1860 = getelementptr float, ptr %1859, i64 3756032
  store <4096 x float> zeroinitializer, ptr %1860, align 4
  %1861 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1862 = getelementptr float, ptr %1861, i64 3760128
  store <4096 x float> zeroinitializer, ptr %1862, align 4
  %1863 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1864 = getelementptr float, ptr %1863, i64 3764224
  store <4096 x float> zeroinitializer, ptr %1864, align 4
  %1865 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1866 = getelementptr float, ptr %1865, i64 3768320
  store <4096 x float> zeroinitializer, ptr %1866, align 4
  %1867 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1868 = getelementptr float, ptr %1867, i64 3772416
  store <4096 x float> zeroinitializer, ptr %1868, align 4
  %1869 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1870 = getelementptr float, ptr %1869, i64 3776512
  store <4096 x float> zeroinitializer, ptr %1870, align 4
  %1871 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1872 = getelementptr float, ptr %1871, i64 3780608
  store <4096 x float> zeroinitializer, ptr %1872, align 4
  %1873 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1874 = getelementptr float, ptr %1873, i64 3784704
  store <4096 x float> zeroinitializer, ptr %1874, align 4
  %1875 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1876 = getelementptr float, ptr %1875, i64 3788800
  store <4096 x float> zeroinitializer, ptr %1876, align 4
  %1877 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1878 = getelementptr float, ptr %1877, i64 3792896
  store <4096 x float> zeroinitializer, ptr %1878, align 4
  %1879 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1880 = getelementptr float, ptr %1879, i64 3796992
  store <4096 x float> zeroinitializer, ptr %1880, align 4
  %1881 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1882 = getelementptr float, ptr %1881, i64 3801088
  store <4096 x float> zeroinitializer, ptr %1882, align 4
  %1883 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1884 = getelementptr float, ptr %1883, i64 3805184
  store <4096 x float> zeroinitializer, ptr %1884, align 4
  %1885 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1886 = getelementptr float, ptr %1885, i64 3809280
  store <4096 x float> zeroinitializer, ptr %1886, align 4
  %1887 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1888 = getelementptr float, ptr %1887, i64 3813376
  store <4096 x float> zeroinitializer, ptr %1888, align 4
  %1889 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1890 = getelementptr float, ptr %1889, i64 3817472
  store <4096 x float> zeroinitializer, ptr %1890, align 4
  %1891 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1892 = getelementptr float, ptr %1891, i64 3821568
  store <4096 x float> zeroinitializer, ptr %1892, align 4
  %1893 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1894 = getelementptr float, ptr %1893, i64 3825664
  store <4096 x float> zeroinitializer, ptr %1894, align 4
  %1895 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1896 = getelementptr float, ptr %1895, i64 3829760
  store <4096 x float> zeroinitializer, ptr %1896, align 4
  %1897 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1898 = getelementptr float, ptr %1897, i64 3833856
  store <4096 x float> zeroinitializer, ptr %1898, align 4
  %1899 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1900 = getelementptr float, ptr %1899, i64 3837952
  store <4096 x float> zeroinitializer, ptr %1900, align 4
  %1901 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1902 = getelementptr float, ptr %1901, i64 3842048
  store <4096 x float> zeroinitializer, ptr %1902, align 4
  %1903 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1904 = getelementptr float, ptr %1903, i64 3846144
  store <4096 x float> zeroinitializer, ptr %1904, align 4
  %1905 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1906 = getelementptr float, ptr %1905, i64 3850240
  store <4096 x float> zeroinitializer, ptr %1906, align 4
  %1907 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1908 = getelementptr float, ptr %1907, i64 3854336
  store <4096 x float> zeroinitializer, ptr %1908, align 4
  %1909 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1910 = getelementptr float, ptr %1909, i64 3858432
  store <4096 x float> zeroinitializer, ptr %1910, align 4
  %1911 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1912 = getelementptr float, ptr %1911, i64 3862528
  store <4096 x float> zeroinitializer, ptr %1912, align 4
  %1913 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1914 = getelementptr float, ptr %1913, i64 3866624
  store <4096 x float> zeroinitializer, ptr %1914, align 4
  %1915 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1916 = getelementptr float, ptr %1915, i64 3870720
  store <4096 x float> zeroinitializer, ptr %1916, align 4
  %1917 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1918 = getelementptr float, ptr %1917, i64 3874816
  store <4096 x float> zeroinitializer, ptr %1918, align 4
  %1919 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1920 = getelementptr float, ptr %1919, i64 3878912
  store <4096 x float> zeroinitializer, ptr %1920, align 4
  %1921 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1922 = getelementptr float, ptr %1921, i64 3883008
  store <4096 x float> zeroinitializer, ptr %1922, align 4
  %1923 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1924 = getelementptr float, ptr %1923, i64 3887104
  store <4096 x float> zeroinitializer, ptr %1924, align 4
  %1925 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1926 = getelementptr float, ptr %1925, i64 3891200
  store <4096 x float> zeroinitializer, ptr %1926, align 4
  %1927 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1928 = getelementptr float, ptr %1927, i64 3895296
  store <4096 x float> zeroinitializer, ptr %1928, align 4
  %1929 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1930 = getelementptr float, ptr %1929, i64 3899392
  store <4096 x float> zeroinitializer, ptr %1930, align 4
  %1931 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1932 = getelementptr float, ptr %1931, i64 3903488
  store <4096 x float> zeroinitializer, ptr %1932, align 4
  %1933 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1934 = getelementptr float, ptr %1933, i64 3907584
  store <4096 x float> zeroinitializer, ptr %1934, align 4
  %1935 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1936 = getelementptr float, ptr %1935, i64 3911680
  store <4096 x float> zeroinitializer, ptr %1936, align 4
  %1937 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1938 = getelementptr float, ptr %1937, i64 3915776
  store <4096 x float> zeroinitializer, ptr %1938, align 4
  %1939 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1940 = getelementptr float, ptr %1939, i64 3919872
  store <4096 x float> zeroinitializer, ptr %1940, align 4
  %1941 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1942 = getelementptr float, ptr %1941, i64 3923968
  store <4096 x float> zeroinitializer, ptr %1942, align 4
  %1943 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1944 = getelementptr float, ptr %1943, i64 3928064
  store <4096 x float> zeroinitializer, ptr %1944, align 4
  %1945 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1946 = getelementptr float, ptr %1945, i64 3932160
  store <4096 x float> zeroinitializer, ptr %1946, align 4
  %1947 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1948 = getelementptr float, ptr %1947, i64 3936256
  store <4096 x float> zeroinitializer, ptr %1948, align 4
  %1949 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1950 = getelementptr float, ptr %1949, i64 3940352
  store <4096 x float> zeroinitializer, ptr %1950, align 4
  %1951 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1952 = getelementptr float, ptr %1951, i64 3944448
  store <4096 x float> zeroinitializer, ptr %1952, align 4
  %1953 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1954 = getelementptr float, ptr %1953, i64 3948544
  store <4096 x float> zeroinitializer, ptr %1954, align 4
  %1955 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1956 = getelementptr float, ptr %1955, i64 3952640
  store <4096 x float> zeroinitializer, ptr %1956, align 4
  %1957 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1958 = getelementptr float, ptr %1957, i64 3956736
  store <4096 x float> zeroinitializer, ptr %1958, align 4
  %1959 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1960 = getelementptr float, ptr %1959, i64 3960832
  store <4096 x float> zeroinitializer, ptr %1960, align 4
  %1961 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1962 = getelementptr float, ptr %1961, i64 3964928
  store <4096 x float> zeroinitializer, ptr %1962, align 4
  %1963 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1964 = getelementptr float, ptr %1963, i64 3969024
  store <4096 x float> zeroinitializer, ptr %1964, align 4
  %1965 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1966 = getelementptr float, ptr %1965, i64 3973120
  store <4096 x float> zeroinitializer, ptr %1966, align 4
  %1967 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1968 = getelementptr float, ptr %1967, i64 3977216
  store <4096 x float> zeroinitializer, ptr %1968, align 4
  %1969 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1970 = getelementptr float, ptr %1969, i64 3981312
  store <4096 x float> zeroinitializer, ptr %1970, align 4
  %1971 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1972 = getelementptr float, ptr %1971, i64 3985408
  store <4096 x float> zeroinitializer, ptr %1972, align 4
  %1973 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1974 = getelementptr float, ptr %1973, i64 3989504
  store <4096 x float> zeroinitializer, ptr %1974, align 4
  %1975 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1976 = getelementptr float, ptr %1975, i64 3993600
  store <4096 x float> zeroinitializer, ptr %1976, align 4
  %1977 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1978 = getelementptr float, ptr %1977, i64 3997696
  store <4096 x float> zeroinitializer, ptr %1978, align 4
  %1979 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1980 = getelementptr float, ptr %1979, i64 4001792
  store <4096 x float> zeroinitializer, ptr %1980, align 4
  %1981 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1982 = getelementptr float, ptr %1981, i64 4005888
  store <4096 x float> zeroinitializer, ptr %1982, align 4
  %1983 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1984 = getelementptr float, ptr %1983, i64 4009984
  store <4096 x float> zeroinitializer, ptr %1984, align 4
  %1985 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1986 = getelementptr float, ptr %1985, i64 4014080
  store <4096 x float> zeroinitializer, ptr %1986, align 4
  %1987 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1988 = getelementptr float, ptr %1987, i64 4018176
  store <4096 x float> zeroinitializer, ptr %1988, align 4
  %1989 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1990 = getelementptr float, ptr %1989, i64 4022272
  store <4096 x float> zeroinitializer, ptr %1990, align 4
  %1991 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1992 = getelementptr float, ptr %1991, i64 4026368
  store <4096 x float> zeroinitializer, ptr %1992, align 4
  %1993 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1994 = getelementptr float, ptr %1993, i64 4030464
  store <4096 x float> zeroinitializer, ptr %1994, align 4
  %1995 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1996 = getelementptr float, ptr %1995, i64 4034560
  store <4096 x float> zeroinitializer, ptr %1996, align 4
  %1997 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %1998 = getelementptr float, ptr %1997, i64 4038656
  store <4096 x float> zeroinitializer, ptr %1998, align 4
  %1999 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2000 = getelementptr float, ptr %1999, i64 4042752
  store <4096 x float> zeroinitializer, ptr %2000, align 4
  %2001 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2002 = getelementptr float, ptr %2001, i64 4046848
  store <4096 x float> zeroinitializer, ptr %2002, align 4
  %2003 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2004 = getelementptr float, ptr %2003, i64 4050944
  store <4096 x float> zeroinitializer, ptr %2004, align 4
  %2005 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2006 = getelementptr float, ptr %2005, i64 4055040
  store <4096 x float> zeroinitializer, ptr %2006, align 4
  %2007 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2008 = getelementptr float, ptr %2007, i64 4059136
  store <4096 x float> zeroinitializer, ptr %2008, align 4
  %2009 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2010 = getelementptr float, ptr %2009, i64 4063232
  store <4096 x float> zeroinitializer, ptr %2010, align 4
  %2011 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2012 = getelementptr float, ptr %2011, i64 4067328
  store <4096 x float> zeroinitializer, ptr %2012, align 4
  %2013 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2014 = getelementptr float, ptr %2013, i64 4071424
  store <4096 x float> zeroinitializer, ptr %2014, align 4
  %2015 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2016 = getelementptr float, ptr %2015, i64 4075520
  store <4096 x float> zeroinitializer, ptr %2016, align 4
  %2017 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2018 = getelementptr float, ptr %2017, i64 4079616
  store <4096 x float> zeroinitializer, ptr %2018, align 4
  %2019 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2020 = getelementptr float, ptr %2019, i64 4083712
  store <4096 x float> zeroinitializer, ptr %2020, align 4
  %2021 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2022 = getelementptr float, ptr %2021, i64 4087808
  store <4096 x float> zeroinitializer, ptr %2022, align 4
  %2023 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2024 = getelementptr float, ptr %2023, i64 4091904
  store <4096 x float> zeroinitializer, ptr %2024, align 4
  %2025 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2026 = getelementptr float, ptr %2025, i64 4096000
  store <4096 x float> zeroinitializer, ptr %2026, align 4
  %2027 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2028 = getelementptr float, ptr %2027, i64 4100096
  store <4096 x float> zeroinitializer, ptr %2028, align 4
  %2029 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2030 = getelementptr float, ptr %2029, i64 4104192
  store <4096 x float> zeroinitializer, ptr %2030, align 4
  %2031 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2032 = getelementptr float, ptr %2031, i64 4108288
  store <4096 x float> zeroinitializer, ptr %2032, align 4
  %2033 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2034 = getelementptr float, ptr %2033, i64 4112384
  store <4096 x float> zeroinitializer, ptr %2034, align 4
  %2035 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2036 = getelementptr float, ptr %2035, i64 4116480
  store <4096 x float> zeroinitializer, ptr %2036, align 4
  %2037 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2038 = getelementptr float, ptr %2037, i64 4120576
  store <4096 x float> zeroinitializer, ptr %2038, align 4
  %2039 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2040 = getelementptr float, ptr %2039, i64 4124672
  store <4096 x float> zeroinitializer, ptr %2040, align 4
  %2041 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2042 = getelementptr float, ptr %2041, i64 4128768
  store <4096 x float> zeroinitializer, ptr %2042, align 4
  %2043 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2044 = getelementptr float, ptr %2043, i64 4132864
  store <4096 x float> zeroinitializer, ptr %2044, align 4
  %2045 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2046 = getelementptr float, ptr %2045, i64 4136960
  store <4096 x float> zeroinitializer, ptr %2046, align 4
  %2047 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2048 = getelementptr float, ptr %2047, i64 4141056
  store <4096 x float> zeroinitializer, ptr %2048, align 4
  %2049 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2050 = getelementptr float, ptr %2049, i64 4145152
  store <4096 x float> zeroinitializer, ptr %2050, align 4
  %2051 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2052 = getelementptr float, ptr %2051, i64 4149248
  store <4096 x float> zeroinitializer, ptr %2052, align 4
  %2053 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2054 = getelementptr float, ptr %2053, i64 4153344
  store <4096 x float> zeroinitializer, ptr %2054, align 4
  %2055 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2056 = getelementptr float, ptr %2055, i64 4157440
  store <4096 x float> zeroinitializer, ptr %2056, align 4
  %2057 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2058 = getelementptr float, ptr %2057, i64 4161536
  store <4096 x float> zeroinitializer, ptr %2058, align 4
  %2059 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2060 = getelementptr float, ptr %2059, i64 4165632
  store <4096 x float> zeroinitializer, ptr %2060, align 4
  %2061 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2062 = getelementptr float, ptr %2061, i64 4169728
  store <4096 x float> zeroinitializer, ptr %2062, align 4
  %2063 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2064 = getelementptr float, ptr %2063, i64 4173824
  store <4096 x float> zeroinitializer, ptr %2064, align 4
  %2065 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2066 = getelementptr float, ptr %2065, i64 4177920
  store <4096 x float> zeroinitializer, ptr %2066, align 4
  %2067 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2068 = getelementptr float, ptr %2067, i64 4182016
  store <4096 x float> zeroinitializer, ptr %2068, align 4
  %2069 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2070 = getelementptr float, ptr %2069, i64 4186112
  store <4096 x float> zeroinitializer, ptr %2070, align 4
  %2071 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2072 = getelementptr float, ptr %2071, i64 4190208
  store <4096 x float> zeroinitializer, ptr %2072, align 4
  %2073 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2074 = getelementptr float, ptr %2073, i64 4194304
  store <4096 x float> zeroinitializer, ptr %2074, align 4
  %2075 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2076 = getelementptr float, ptr %2075, i64 4198400
  store <4096 x float> zeroinitializer, ptr %2076, align 4
  %2077 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2078 = getelementptr float, ptr %2077, i64 4202496
  store <4096 x float> zeroinitializer, ptr %2078, align 4
  %2079 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2080 = getelementptr float, ptr %2079, i64 4206592
  store <4096 x float> zeroinitializer, ptr %2080, align 4
  %2081 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2082 = getelementptr float, ptr %2081, i64 4210688
  store <4096 x float> zeroinitializer, ptr %2082, align 4
  %2083 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2084 = getelementptr float, ptr %2083, i64 4214784
  store <4096 x float> zeroinitializer, ptr %2084, align 4
  %2085 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2086 = getelementptr float, ptr %2085, i64 4218880
  store <4096 x float> zeroinitializer, ptr %2086, align 4
  %2087 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2088 = getelementptr float, ptr %2087, i64 4222976
  store <4096 x float> zeroinitializer, ptr %2088, align 4
  %2089 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2090 = getelementptr float, ptr %2089, i64 4227072
  store <4096 x float> zeroinitializer, ptr %2090, align 4
  %2091 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2092 = getelementptr float, ptr %2091, i64 4231168
  store <4096 x float> zeroinitializer, ptr %2092, align 4
  %2093 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2094 = getelementptr float, ptr %2093, i64 4235264
  store <4096 x float> zeroinitializer, ptr %2094, align 4
  %2095 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2096 = getelementptr float, ptr %2095, i64 4239360
  store <4096 x float> zeroinitializer, ptr %2096, align 4
  %2097 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2098 = getelementptr float, ptr %2097, i64 4243456
  store <4096 x float> zeroinitializer, ptr %2098, align 4
  %2099 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2100 = getelementptr float, ptr %2099, i64 4247552
  store <4096 x float> zeroinitializer, ptr %2100, align 4
  %2101 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2102 = getelementptr float, ptr %2101, i64 4251648
  store <4096 x float> zeroinitializer, ptr %2102, align 4
  %2103 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2104 = getelementptr float, ptr %2103, i64 4255744
  store <4096 x float> zeroinitializer, ptr %2104, align 4
  %2105 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2106 = getelementptr float, ptr %2105, i64 4259840
  store <4096 x float> zeroinitializer, ptr %2106, align 4
  %2107 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2108 = getelementptr float, ptr %2107, i64 4263936
  store <4096 x float> zeroinitializer, ptr %2108, align 4
  %2109 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2110 = getelementptr float, ptr %2109, i64 4268032
  store <4096 x float> zeroinitializer, ptr %2110, align 4
  %2111 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2112 = getelementptr float, ptr %2111, i64 4272128
  store <4096 x float> zeroinitializer, ptr %2112, align 4
  %2113 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2114 = getelementptr float, ptr %2113, i64 4276224
  store <4096 x float> zeroinitializer, ptr %2114, align 4
  %2115 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2116 = getelementptr float, ptr %2115, i64 4280320
  store <4096 x float> zeroinitializer, ptr %2116, align 4
  %2117 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2118 = getelementptr float, ptr %2117, i64 4284416
  store <4096 x float> zeroinitializer, ptr %2118, align 4
  %2119 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2120 = getelementptr float, ptr %2119, i64 4288512
  store <4096 x float> zeroinitializer, ptr %2120, align 4
  %2121 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2122 = getelementptr float, ptr %2121, i64 4292608
  store <4096 x float> zeroinitializer, ptr %2122, align 4
  %2123 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2124 = getelementptr float, ptr %2123, i64 4296704
  store <4096 x float> zeroinitializer, ptr %2124, align 4
  %2125 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2126 = getelementptr float, ptr %2125, i64 4300800
  store <4096 x float> zeroinitializer, ptr %2126, align 4
  %2127 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2128 = getelementptr float, ptr %2127, i64 4304896
  store <4096 x float> zeroinitializer, ptr %2128, align 4
  %2129 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2130 = getelementptr float, ptr %2129, i64 4308992
  store <4096 x float> zeroinitializer, ptr %2130, align 4
  %2131 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2132 = getelementptr float, ptr %2131, i64 4313088
  store <4096 x float> zeroinitializer, ptr %2132, align 4
  %2133 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2134 = getelementptr float, ptr %2133, i64 4317184
  store <4096 x float> zeroinitializer, ptr %2134, align 4
  %2135 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2136 = getelementptr float, ptr %2135, i64 4321280
  store <4096 x float> zeroinitializer, ptr %2136, align 4
  %2137 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2138 = getelementptr float, ptr %2137, i64 4325376
  store <4096 x float> zeroinitializer, ptr %2138, align 4
  %2139 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2140 = getelementptr float, ptr %2139, i64 4329472
  store <4096 x float> zeroinitializer, ptr %2140, align 4
  %2141 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2142 = getelementptr float, ptr %2141, i64 4333568
  store <4096 x float> zeroinitializer, ptr %2142, align 4
  %2143 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2144 = getelementptr float, ptr %2143, i64 4337664
  store <4096 x float> zeroinitializer, ptr %2144, align 4
  %2145 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2146 = getelementptr float, ptr %2145, i64 4341760
  store <4096 x float> zeroinitializer, ptr %2146, align 4
  %2147 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2148 = getelementptr float, ptr %2147, i64 4345856
  store <4096 x float> zeroinitializer, ptr %2148, align 4
  %2149 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2150 = getelementptr float, ptr %2149, i64 4349952
  store <4096 x float> zeroinitializer, ptr %2150, align 4
  %2151 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2152 = getelementptr float, ptr %2151, i64 4354048
  store <4096 x float> zeroinitializer, ptr %2152, align 4
  %2153 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2154 = getelementptr float, ptr %2153, i64 4358144
  store <4096 x float> zeroinitializer, ptr %2154, align 4
  %2155 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2156 = getelementptr float, ptr %2155, i64 4362240
  store <4096 x float> zeroinitializer, ptr %2156, align 4
  %2157 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2158 = getelementptr float, ptr %2157, i64 4366336
  store <4096 x float> zeroinitializer, ptr %2158, align 4
  %2159 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2160 = getelementptr float, ptr %2159, i64 4370432
  store <4096 x float> zeroinitializer, ptr %2160, align 4
  %2161 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2162 = getelementptr float, ptr %2161, i64 4374528
  store <4096 x float> zeroinitializer, ptr %2162, align 4
  %2163 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2164 = getelementptr float, ptr %2163, i64 4378624
  store <4096 x float> zeroinitializer, ptr %2164, align 4
  %2165 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2166 = getelementptr float, ptr %2165, i64 4382720
  store <4096 x float> zeroinitializer, ptr %2166, align 4
  %2167 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2168 = getelementptr float, ptr %2167, i64 4386816
  store <4096 x float> zeroinitializer, ptr %2168, align 4
  %2169 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2170 = getelementptr float, ptr %2169, i64 4390912
  store <4096 x float> zeroinitializer, ptr %2170, align 4
  %2171 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2172 = getelementptr float, ptr %2171, i64 4395008
  store <4096 x float> zeroinitializer, ptr %2172, align 4
  %2173 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2174 = getelementptr float, ptr %2173, i64 4399104
  store <4096 x float> zeroinitializer, ptr %2174, align 4
  %2175 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2176 = getelementptr float, ptr %2175, i64 4403200
  store <4096 x float> zeroinitializer, ptr %2176, align 4
  %2177 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2178 = getelementptr float, ptr %2177, i64 4407296
  store <4096 x float> zeroinitializer, ptr %2178, align 4
  %2179 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2180 = getelementptr float, ptr %2179, i64 4411392
  store <4096 x float> zeroinitializer, ptr %2180, align 4
  %2181 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2182 = getelementptr float, ptr %2181, i64 4415488
  store <4096 x float> zeroinitializer, ptr %2182, align 4
  %2183 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2184 = getelementptr float, ptr %2183, i64 4419584
  store <4096 x float> zeroinitializer, ptr %2184, align 4
  %2185 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2186 = getelementptr float, ptr %2185, i64 4423680
  store <4096 x float> zeroinitializer, ptr %2186, align 4
  %2187 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2188 = getelementptr float, ptr %2187, i64 4427776
  store <4096 x float> zeroinitializer, ptr %2188, align 4
  %2189 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2190 = getelementptr float, ptr %2189, i64 4431872
  store <4096 x float> zeroinitializer, ptr %2190, align 4
  %2191 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2192 = getelementptr float, ptr %2191, i64 4435968
  store <4096 x float> zeroinitializer, ptr %2192, align 4
  %2193 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2194 = getelementptr float, ptr %2193, i64 4440064
  store <4096 x float> zeroinitializer, ptr %2194, align 4
  %2195 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2196 = getelementptr float, ptr %2195, i64 4444160
  store <4096 x float> zeroinitializer, ptr %2196, align 4
  %2197 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2198 = getelementptr float, ptr %2197, i64 4448256
  store <4096 x float> zeroinitializer, ptr %2198, align 4
  %2199 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2200 = getelementptr float, ptr %2199, i64 4452352
  store <4096 x float> zeroinitializer, ptr %2200, align 4
  %2201 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2202 = getelementptr float, ptr %2201, i64 4456448
  store <4096 x float> zeroinitializer, ptr %2202, align 4
  %2203 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2204 = getelementptr float, ptr %2203, i64 4460544
  store <4096 x float> zeroinitializer, ptr %2204, align 4
  %2205 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2206 = getelementptr float, ptr %2205, i64 4464640
  store <4096 x float> zeroinitializer, ptr %2206, align 4
  %2207 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2208 = getelementptr float, ptr %2207, i64 4468736
  store <4096 x float> zeroinitializer, ptr %2208, align 4
  %2209 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2210 = getelementptr float, ptr %2209, i64 4472832
  store <4096 x float> zeroinitializer, ptr %2210, align 4
  %2211 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2212 = getelementptr float, ptr %2211, i64 4476928
  store <4096 x float> zeroinitializer, ptr %2212, align 4
  %2213 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2214 = getelementptr float, ptr %2213, i64 4481024
  store <4096 x float> zeroinitializer, ptr %2214, align 4
  %2215 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2216 = getelementptr float, ptr %2215, i64 4485120
  store <4096 x float> zeroinitializer, ptr %2216, align 4
  %2217 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2218 = getelementptr float, ptr %2217, i64 4489216
  store <4096 x float> zeroinitializer, ptr %2218, align 4
  %2219 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2220 = getelementptr float, ptr %2219, i64 4493312
  store <4096 x float> zeroinitializer, ptr %2220, align 4
  %2221 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2222 = getelementptr float, ptr %2221, i64 4497408
  store <4096 x float> zeroinitializer, ptr %2222, align 4
  %2223 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2224 = getelementptr float, ptr %2223, i64 4501504
  store <4096 x float> zeroinitializer, ptr %2224, align 4
  %2225 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2226 = getelementptr float, ptr %2225, i64 4505600
  store <4096 x float> zeroinitializer, ptr %2226, align 4
  %2227 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2228 = getelementptr float, ptr %2227, i64 4509696
  store <4096 x float> zeroinitializer, ptr %2228, align 4
  %2229 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2230 = getelementptr float, ptr %2229, i64 4513792
  store <4096 x float> zeroinitializer, ptr %2230, align 4
  %2231 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2232 = getelementptr float, ptr %2231, i64 4517888
  store <4096 x float> zeroinitializer, ptr %2232, align 4
  %2233 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2234 = getelementptr float, ptr %2233, i64 4521984
  store <4096 x float> zeroinitializer, ptr %2234, align 4
  %2235 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2236 = getelementptr float, ptr %2235, i64 4526080
  store <4096 x float> zeroinitializer, ptr %2236, align 4
  %2237 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2238 = getelementptr float, ptr %2237, i64 4530176
  store <4096 x float> zeroinitializer, ptr %2238, align 4
  %2239 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2240 = getelementptr float, ptr %2239, i64 4534272
  store <4096 x float> zeroinitializer, ptr %2240, align 4
  %2241 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2242 = getelementptr float, ptr %2241, i64 4538368
  store <4096 x float> zeroinitializer, ptr %2242, align 4
  %2243 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2244 = getelementptr float, ptr %2243, i64 4542464
  store <4096 x float> zeroinitializer, ptr %2244, align 4
  %2245 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2246 = getelementptr float, ptr %2245, i64 4546560
  store <4096 x float> zeroinitializer, ptr %2246, align 4
  %2247 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2248 = getelementptr float, ptr %2247, i64 4550656
  store <4096 x float> zeroinitializer, ptr %2248, align 4
  %2249 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2250 = getelementptr float, ptr %2249, i64 4554752
  store <4096 x float> zeroinitializer, ptr %2250, align 4
  %2251 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2252 = getelementptr float, ptr %2251, i64 4558848
  store <4096 x float> zeroinitializer, ptr %2252, align 4
  %2253 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2254 = getelementptr float, ptr %2253, i64 4562944
  store <4096 x float> zeroinitializer, ptr %2254, align 4
  %2255 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2256 = getelementptr float, ptr %2255, i64 4567040
  store <4096 x float> zeroinitializer, ptr %2256, align 4
  %2257 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2258 = getelementptr float, ptr %2257, i64 4571136
  store <4096 x float> zeroinitializer, ptr %2258, align 4
  %2259 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2260 = getelementptr float, ptr %2259, i64 4575232
  store <4096 x float> zeroinitializer, ptr %2260, align 4
  %2261 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2262 = getelementptr float, ptr %2261, i64 4579328
  store <4096 x float> zeroinitializer, ptr %2262, align 4
  %2263 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2264 = getelementptr float, ptr %2263, i64 4583424
  store <4096 x float> zeroinitializer, ptr %2264, align 4
  %2265 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2266 = getelementptr float, ptr %2265, i64 4587520
  store <4096 x float> zeroinitializer, ptr %2266, align 4
  %2267 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2268 = getelementptr float, ptr %2267, i64 4591616
  store <4096 x float> zeroinitializer, ptr %2268, align 4
  %2269 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2270 = getelementptr float, ptr %2269, i64 4595712
  store <4096 x float> zeroinitializer, ptr %2270, align 4
  %2271 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2272 = getelementptr float, ptr %2271, i64 4599808
  store <4096 x float> zeroinitializer, ptr %2272, align 4
  %2273 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2274 = getelementptr float, ptr %2273, i64 4603904
  store <4096 x float> zeroinitializer, ptr %2274, align 4
  %2275 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2276 = getelementptr float, ptr %2275, i64 4608000
  store <4096 x float> zeroinitializer, ptr %2276, align 4
  %2277 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2278 = getelementptr float, ptr %2277, i64 4612096
  store <4096 x float> zeroinitializer, ptr %2278, align 4
  %2279 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2280 = getelementptr float, ptr %2279, i64 4616192
  store <4096 x float> zeroinitializer, ptr %2280, align 4
  %2281 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2282 = getelementptr float, ptr %2281, i64 4620288
  store <4096 x float> zeroinitializer, ptr %2282, align 4
  %2283 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2284 = getelementptr float, ptr %2283, i64 4624384
  store <4096 x float> zeroinitializer, ptr %2284, align 4
  %2285 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2286 = getelementptr float, ptr %2285, i64 4628480
  store <4096 x float> zeroinitializer, ptr %2286, align 4
  %2287 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2288 = getelementptr float, ptr %2287, i64 4632576
  store <4096 x float> zeroinitializer, ptr %2288, align 4
  %2289 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2290 = getelementptr float, ptr %2289, i64 4636672
  store <4096 x float> zeroinitializer, ptr %2290, align 4
  %2291 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2292 = getelementptr float, ptr %2291, i64 4640768
  store <4096 x float> zeroinitializer, ptr %2292, align 4
  %2293 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2294 = getelementptr float, ptr %2293, i64 4644864
  store <4096 x float> zeroinitializer, ptr %2294, align 4
  %2295 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2296 = getelementptr float, ptr %2295, i64 4648960
  store <4096 x float> zeroinitializer, ptr %2296, align 4
  %2297 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2298 = getelementptr float, ptr %2297, i64 4653056
  store <4096 x float> zeroinitializer, ptr %2298, align 4
  %2299 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2300 = getelementptr float, ptr %2299, i64 4657152
  store <4096 x float> zeroinitializer, ptr %2300, align 4
  %2301 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2302 = getelementptr float, ptr %2301, i64 4661248
  store <4096 x float> zeroinitializer, ptr %2302, align 4
  %2303 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2304 = getelementptr float, ptr %2303, i64 4665344
  store <4096 x float> zeroinitializer, ptr %2304, align 4
  %2305 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2306 = getelementptr float, ptr %2305, i64 4669440
  store <4096 x float> zeroinitializer, ptr %2306, align 4
  %2307 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2308 = getelementptr float, ptr %2307, i64 4673536
  store <4096 x float> zeroinitializer, ptr %2308, align 4
  %2309 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2310 = getelementptr float, ptr %2309, i64 4677632
  store <4096 x float> zeroinitializer, ptr %2310, align 4
  %2311 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2312 = getelementptr float, ptr %2311, i64 4681728
  store <4096 x float> zeroinitializer, ptr %2312, align 4
  %2313 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2314 = getelementptr float, ptr %2313, i64 4685824
  store <4096 x float> zeroinitializer, ptr %2314, align 4
  %2315 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2316 = getelementptr float, ptr %2315, i64 4689920
  store <4096 x float> zeroinitializer, ptr %2316, align 4
  %2317 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2318 = getelementptr float, ptr %2317, i64 4694016
  store <4096 x float> zeroinitializer, ptr %2318, align 4
  %2319 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2320 = getelementptr float, ptr %2319, i64 4698112
  store <4096 x float> zeroinitializer, ptr %2320, align 4
  %2321 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2322 = getelementptr float, ptr %2321, i64 4702208
  store <4096 x float> zeroinitializer, ptr %2322, align 4
  %2323 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2324 = getelementptr float, ptr %2323, i64 4706304
  store <4096 x float> zeroinitializer, ptr %2324, align 4
  %2325 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2326 = getelementptr float, ptr %2325, i64 4710400
  store <4096 x float> zeroinitializer, ptr %2326, align 4
  %2327 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2328 = getelementptr float, ptr %2327, i64 4714496
  store <4096 x float> zeroinitializer, ptr %2328, align 4
  %2329 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2330 = getelementptr float, ptr %2329, i64 4718592
  store <4096 x float> zeroinitializer, ptr %2330, align 4
  %2331 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2332 = getelementptr float, ptr %2331, i64 4722688
  store <4096 x float> zeroinitializer, ptr %2332, align 4
  %2333 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2334 = getelementptr float, ptr %2333, i64 4726784
  store <4096 x float> zeroinitializer, ptr %2334, align 4
  %2335 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2336 = getelementptr float, ptr %2335, i64 4730880
  store <4096 x float> zeroinitializer, ptr %2336, align 4
  %2337 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2338 = getelementptr float, ptr %2337, i64 4734976
  store <4096 x float> zeroinitializer, ptr %2338, align 4
  %2339 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2340 = getelementptr float, ptr %2339, i64 4739072
  store <4096 x float> zeroinitializer, ptr %2340, align 4
  %2341 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2342 = getelementptr float, ptr %2341, i64 4743168
  store <4096 x float> zeroinitializer, ptr %2342, align 4
  %2343 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2344 = getelementptr float, ptr %2343, i64 4747264
  store <4096 x float> zeroinitializer, ptr %2344, align 4
  %2345 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2346 = getelementptr float, ptr %2345, i64 4751360
  store <4096 x float> zeroinitializer, ptr %2346, align 4
  %2347 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2348 = getelementptr float, ptr %2347, i64 4755456
  store <4096 x float> zeroinitializer, ptr %2348, align 4
  %2349 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2350 = getelementptr float, ptr %2349, i64 4759552
  store <4096 x float> zeroinitializer, ptr %2350, align 4
  %2351 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2352 = getelementptr float, ptr %2351, i64 4763648
  store <4096 x float> zeroinitializer, ptr %2352, align 4
  %2353 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2354 = getelementptr float, ptr %2353, i64 4767744
  store <4096 x float> zeroinitializer, ptr %2354, align 4
  %2355 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2356 = getelementptr float, ptr %2355, i64 4771840
  store <4096 x float> zeroinitializer, ptr %2356, align 4
  %2357 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2358 = getelementptr float, ptr %2357, i64 4775936
  store <4096 x float> zeroinitializer, ptr %2358, align 4
  %2359 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2360 = getelementptr float, ptr %2359, i64 4780032
  store <4096 x float> zeroinitializer, ptr %2360, align 4
  %2361 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2362 = getelementptr float, ptr %2361, i64 4784128
  store <4096 x float> zeroinitializer, ptr %2362, align 4
  %2363 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2364 = getelementptr float, ptr %2363, i64 4788224
  store <4096 x float> zeroinitializer, ptr %2364, align 4
  %2365 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2366 = getelementptr float, ptr %2365, i64 4792320
  store <4096 x float> zeroinitializer, ptr %2366, align 4
  %2367 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2368 = getelementptr float, ptr %2367, i64 4796416
  store <4096 x float> zeroinitializer, ptr %2368, align 4
  %2369 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2370 = getelementptr float, ptr %2369, i64 4800512
  store <4096 x float> zeroinitializer, ptr %2370, align 4
  %2371 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2372 = getelementptr float, ptr %2371, i64 4804608
  store <4096 x float> zeroinitializer, ptr %2372, align 4
  %2373 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2374 = getelementptr float, ptr %2373, i64 4808704
  store <4096 x float> zeroinitializer, ptr %2374, align 4
  %2375 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2376 = getelementptr float, ptr %2375, i64 4812800
  store <4096 x float> zeroinitializer, ptr %2376, align 4
  %2377 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2378 = getelementptr float, ptr %2377, i64 4816896
  store <4096 x float> zeroinitializer, ptr %2378, align 4
  %2379 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2380 = getelementptr float, ptr %2379, i64 4820992
  store <4096 x float> zeroinitializer, ptr %2380, align 4
  %2381 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2382 = getelementptr float, ptr %2381, i64 4825088
  store <4096 x float> zeroinitializer, ptr %2382, align 4
  %2383 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2384 = getelementptr float, ptr %2383, i64 4829184
  store <4096 x float> zeroinitializer, ptr %2384, align 4
  %2385 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2386 = getelementptr float, ptr %2385, i64 4833280
  store <4096 x float> zeroinitializer, ptr %2386, align 4
  %2387 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2388 = getelementptr float, ptr %2387, i64 4837376
  store <4096 x float> zeroinitializer, ptr %2388, align 4
  %2389 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2390 = getelementptr float, ptr %2389, i64 4841472
  store <4096 x float> zeroinitializer, ptr %2390, align 4
  %2391 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2392 = getelementptr float, ptr %2391, i64 4845568
  store <4096 x float> zeroinitializer, ptr %2392, align 4
  %2393 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2394 = getelementptr float, ptr %2393, i64 4849664
  store <4096 x float> zeroinitializer, ptr %2394, align 4
  %2395 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2396 = getelementptr float, ptr %2395, i64 4853760
  store <4096 x float> zeroinitializer, ptr %2396, align 4
  %2397 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2398 = getelementptr float, ptr %2397, i64 4857856
  store <4096 x float> zeroinitializer, ptr %2398, align 4
  %2399 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2400 = getelementptr float, ptr %2399, i64 4861952
  store <4096 x float> zeroinitializer, ptr %2400, align 4
  %2401 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2402 = getelementptr float, ptr %2401, i64 4866048
  store <4096 x float> zeroinitializer, ptr %2402, align 4
  %2403 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2404 = getelementptr float, ptr %2403, i64 4870144
  store <4096 x float> zeroinitializer, ptr %2404, align 4
  %2405 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2406 = getelementptr float, ptr %2405, i64 4874240
  store <4096 x float> zeroinitializer, ptr %2406, align 4
  %2407 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2408 = getelementptr float, ptr %2407, i64 4878336
  store <4096 x float> zeroinitializer, ptr %2408, align 4
  %2409 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2410 = getelementptr float, ptr %2409, i64 4882432
  store <4096 x float> zeroinitializer, ptr %2410, align 4
  %2411 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2412 = getelementptr float, ptr %2411, i64 4886528
  store <4096 x float> zeroinitializer, ptr %2412, align 4
  %2413 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2414 = getelementptr float, ptr %2413, i64 4890624
  store <4096 x float> zeroinitializer, ptr %2414, align 4
  %2415 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2416 = getelementptr float, ptr %2415, i64 4894720
  store <4096 x float> zeroinitializer, ptr %2416, align 4
  %2417 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2418 = getelementptr float, ptr %2417, i64 4898816
  store <4096 x float> zeroinitializer, ptr %2418, align 4
  %2419 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2420 = getelementptr float, ptr %2419, i64 4902912
  store <4096 x float> zeroinitializer, ptr %2420, align 4
  %2421 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2422 = getelementptr float, ptr %2421, i64 4907008
  store <4096 x float> zeroinitializer, ptr %2422, align 4
  %2423 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2424 = getelementptr float, ptr %2423, i64 4911104
  store <4096 x float> zeroinitializer, ptr %2424, align 4
  %2425 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2426 = getelementptr float, ptr %2425, i64 4915200
  store <4096 x float> zeroinitializer, ptr %2426, align 4
  %2427 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2428 = getelementptr float, ptr %2427, i64 4919296
  store <4096 x float> zeroinitializer, ptr %2428, align 4
  %2429 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2430 = getelementptr float, ptr %2429, i64 4923392
  store <4096 x float> zeroinitializer, ptr %2430, align 4
  %2431 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2432 = getelementptr float, ptr %2431, i64 4927488
  store <4096 x float> zeroinitializer, ptr %2432, align 4
  %2433 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2434 = getelementptr float, ptr %2433, i64 4931584
  store <4096 x float> zeroinitializer, ptr %2434, align 4
  %2435 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2436 = getelementptr float, ptr %2435, i64 4935680
  store <4096 x float> zeroinitializer, ptr %2436, align 4
  %2437 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2438 = getelementptr float, ptr %2437, i64 4939776
  store <4096 x float> zeroinitializer, ptr %2438, align 4
  %2439 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2440 = getelementptr float, ptr %2439, i64 4943872
  store <4096 x float> zeroinitializer, ptr %2440, align 4
  %2441 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2442 = getelementptr float, ptr %2441, i64 4947968
  store <4096 x float> zeroinitializer, ptr %2442, align 4
  %2443 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2444 = getelementptr float, ptr %2443, i64 4952064
  store <4096 x float> zeroinitializer, ptr %2444, align 4
  %2445 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2446 = getelementptr float, ptr %2445, i64 4956160
  store <4096 x float> zeroinitializer, ptr %2446, align 4
  %2447 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2448 = getelementptr float, ptr %2447, i64 4960256
  store <4096 x float> zeroinitializer, ptr %2448, align 4
  %2449 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2450 = getelementptr float, ptr %2449, i64 4964352
  store <4096 x float> zeroinitializer, ptr %2450, align 4
  %2451 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2452 = getelementptr float, ptr %2451, i64 4968448
  store <4096 x float> zeroinitializer, ptr %2452, align 4
  %2453 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2454 = getelementptr float, ptr %2453, i64 4972544
  store <4096 x float> zeroinitializer, ptr %2454, align 4
  %2455 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2456 = getelementptr float, ptr %2455, i64 4976640
  store <4096 x float> zeroinitializer, ptr %2456, align 4
  %2457 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2458 = getelementptr float, ptr %2457, i64 4980736
  store <4096 x float> zeroinitializer, ptr %2458, align 4
  %2459 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2460 = getelementptr float, ptr %2459, i64 4984832
  store <4096 x float> zeroinitializer, ptr %2460, align 4
  %2461 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2462 = getelementptr float, ptr %2461, i64 4988928
  store <4096 x float> zeroinitializer, ptr %2462, align 4
  %2463 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2464 = getelementptr float, ptr %2463, i64 4993024
  store <4096 x float> zeroinitializer, ptr %2464, align 4
  %2465 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2466 = getelementptr float, ptr %2465, i64 4997120
  store <4096 x float> zeroinitializer, ptr %2466, align 4
  %2467 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2468 = getelementptr float, ptr %2467, i64 5001216
  store <4096 x float> zeroinitializer, ptr %2468, align 4
  %2469 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2470 = getelementptr float, ptr %2469, i64 5005312
  store <4096 x float> zeroinitializer, ptr %2470, align 4
  %2471 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2472 = getelementptr float, ptr %2471, i64 5009408
  store <4096 x float> zeroinitializer, ptr %2472, align 4
  %2473 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2474 = getelementptr float, ptr %2473, i64 5013504
  store <4096 x float> zeroinitializer, ptr %2474, align 4
  %2475 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2476 = getelementptr float, ptr %2475, i64 5017600
  store <4096 x float> zeroinitializer, ptr %2476, align 4
  %2477 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2478 = getelementptr float, ptr %2477, i64 5021696
  store <4096 x float> zeroinitializer, ptr %2478, align 4
  %2479 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2480 = getelementptr float, ptr %2479, i64 5025792
  store <4096 x float> zeroinitializer, ptr %2480, align 4
  %2481 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2482 = getelementptr float, ptr %2481, i64 5029888
  store <4096 x float> zeroinitializer, ptr %2482, align 4
  %2483 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2484 = getelementptr float, ptr %2483, i64 5033984
  store <4096 x float> zeroinitializer, ptr %2484, align 4
  %2485 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2486 = getelementptr float, ptr %2485, i64 5038080
  store <4096 x float> zeroinitializer, ptr %2486, align 4
  %2487 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2488 = getelementptr float, ptr %2487, i64 5042176
  store <4096 x float> zeroinitializer, ptr %2488, align 4
  %2489 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2490 = getelementptr float, ptr %2489, i64 5046272
  store <4096 x float> zeroinitializer, ptr %2490, align 4
  %2491 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2492 = getelementptr float, ptr %2491, i64 5050368
  store <4096 x float> zeroinitializer, ptr %2492, align 4
  %2493 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2494 = getelementptr float, ptr %2493, i64 5054464
  store <4096 x float> zeroinitializer, ptr %2494, align 4
  %2495 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2496 = getelementptr float, ptr %2495, i64 5058560
  store <4096 x float> zeroinitializer, ptr %2496, align 4
  %2497 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2498 = getelementptr float, ptr %2497, i64 5062656
  store <4096 x float> zeroinitializer, ptr %2498, align 4
  %2499 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2500 = getelementptr float, ptr %2499, i64 5066752
  store <4096 x float> zeroinitializer, ptr %2500, align 4
  %2501 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2502 = getelementptr float, ptr %2501, i64 5070848
  store <4096 x float> zeroinitializer, ptr %2502, align 4
  %2503 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2504 = getelementptr float, ptr %2503, i64 5074944
  store <4096 x float> zeroinitializer, ptr %2504, align 4
  %2505 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2506 = getelementptr float, ptr %2505, i64 5079040
  store <4096 x float> zeroinitializer, ptr %2506, align 4
  %2507 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2508 = getelementptr float, ptr %2507, i64 5083136
  store <4096 x float> zeroinitializer, ptr %2508, align 4
  %2509 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2510 = getelementptr float, ptr %2509, i64 5087232
  store <4096 x float> zeroinitializer, ptr %2510, align 4
  %2511 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2512 = getelementptr float, ptr %2511, i64 5091328
  store <4096 x float> zeroinitializer, ptr %2512, align 4
  %2513 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2514 = getelementptr float, ptr %2513, i64 5095424
  store <4096 x float> zeroinitializer, ptr %2514, align 4
  %2515 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2516 = getelementptr float, ptr %2515, i64 5099520
  store <4096 x float> zeroinitializer, ptr %2516, align 4
  %2517 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2518 = getelementptr float, ptr %2517, i64 5103616
  store <4096 x float> zeroinitializer, ptr %2518, align 4
  %2519 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2520 = getelementptr float, ptr %2519, i64 5107712
  store <4096 x float> zeroinitializer, ptr %2520, align 4
  %2521 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2522 = getelementptr float, ptr %2521, i64 5111808
  store <4096 x float> zeroinitializer, ptr %2522, align 4
  %2523 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2524 = getelementptr float, ptr %2523, i64 5115904
  store <4096 x float> zeroinitializer, ptr %2524, align 4
  %2525 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2526 = getelementptr float, ptr %2525, i64 5120000
  store <4096 x float> zeroinitializer, ptr %2526, align 4
  %2527 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2528 = getelementptr float, ptr %2527, i64 5124096
  store <4096 x float> zeroinitializer, ptr %2528, align 4
  %2529 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2530 = getelementptr float, ptr %2529, i64 5128192
  store <4096 x float> zeroinitializer, ptr %2530, align 4
  %2531 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2532 = getelementptr float, ptr %2531, i64 5132288
  store <4096 x float> zeroinitializer, ptr %2532, align 4
  %2533 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2534 = getelementptr float, ptr %2533, i64 5136384
  store <4096 x float> zeroinitializer, ptr %2534, align 4
  %2535 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2536 = getelementptr float, ptr %2535, i64 5140480
  store <4096 x float> zeroinitializer, ptr %2536, align 4
  %2537 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2538 = getelementptr float, ptr %2537, i64 5144576
  store <4096 x float> zeroinitializer, ptr %2538, align 4
  %2539 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2540 = getelementptr float, ptr %2539, i64 5148672
  store <4096 x float> zeroinitializer, ptr %2540, align 4
  %2541 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2542 = getelementptr float, ptr %2541, i64 5152768
  store <4096 x float> zeroinitializer, ptr %2542, align 4
  %2543 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2544 = getelementptr float, ptr %2543, i64 5156864
  store <4096 x float> zeroinitializer, ptr %2544, align 4
  %2545 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2546 = getelementptr float, ptr %2545, i64 5160960
  store <4096 x float> zeroinitializer, ptr %2546, align 4
  %2547 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2548 = getelementptr float, ptr %2547, i64 5165056
  store <4096 x float> zeroinitializer, ptr %2548, align 4
  %2549 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2550 = getelementptr float, ptr %2549, i64 5169152
  store <4096 x float> zeroinitializer, ptr %2550, align 4
  %2551 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2552 = getelementptr float, ptr %2551, i64 5173248
  store <4096 x float> zeroinitializer, ptr %2552, align 4
  %2553 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2554 = getelementptr float, ptr %2553, i64 5177344
  store <4096 x float> zeroinitializer, ptr %2554, align 4
  %2555 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2556 = getelementptr float, ptr %2555, i64 5181440
  store <4096 x float> zeroinitializer, ptr %2556, align 4
  %2557 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2558 = getelementptr float, ptr %2557, i64 5185536
  store <4096 x float> zeroinitializer, ptr %2558, align 4
  %2559 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2560 = getelementptr float, ptr %2559, i64 5189632
  store <4096 x float> zeroinitializer, ptr %2560, align 4
  %2561 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2562 = getelementptr float, ptr %2561, i64 5193728
  store <4096 x float> zeroinitializer, ptr %2562, align 4
  %2563 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2564 = getelementptr float, ptr %2563, i64 5197824
  store <4096 x float> zeroinitializer, ptr %2564, align 4
  %2565 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2566 = getelementptr float, ptr %2565, i64 5201920
  store <4096 x float> zeroinitializer, ptr %2566, align 4
  %2567 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2568 = getelementptr float, ptr %2567, i64 5206016
  store <4096 x float> zeroinitializer, ptr %2568, align 4
  %2569 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2570 = getelementptr float, ptr %2569, i64 5210112
  store <4096 x float> zeroinitializer, ptr %2570, align 4
  %2571 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2572 = getelementptr float, ptr %2571, i64 5214208
  store <4096 x float> zeroinitializer, ptr %2572, align 4
  %2573 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2574 = getelementptr float, ptr %2573, i64 5218304
  store <4096 x float> zeroinitializer, ptr %2574, align 4
  %2575 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2576 = getelementptr float, ptr %2575, i64 5222400
  store <4096 x float> zeroinitializer, ptr %2576, align 4
  %2577 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2578 = getelementptr float, ptr %2577, i64 5226496
  store <4096 x float> zeroinitializer, ptr %2578, align 4
  %2579 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2580 = getelementptr float, ptr %2579, i64 5230592
  store <4096 x float> zeroinitializer, ptr %2580, align 4
  %2581 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2582 = getelementptr float, ptr %2581, i64 5234688
  store <4096 x float> zeroinitializer, ptr %2582, align 4
  %2583 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2584 = getelementptr float, ptr %2583, i64 5238784
  store <4096 x float> zeroinitializer, ptr %2584, align 4
  %2585 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2586 = getelementptr float, ptr %2585, i64 5242880
  store <4096 x float> zeroinitializer, ptr %2586, align 4
  %2587 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2588 = getelementptr float, ptr %2587, i64 5246976
  store <4096 x float> zeroinitializer, ptr %2588, align 4
  %2589 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2590 = getelementptr float, ptr %2589, i64 5251072
  store <4096 x float> zeroinitializer, ptr %2590, align 4
  %2591 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2592 = getelementptr float, ptr %2591, i64 5255168
  store <4096 x float> zeroinitializer, ptr %2592, align 4
  %2593 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2594 = getelementptr float, ptr %2593, i64 5259264
  store <4096 x float> zeroinitializer, ptr %2594, align 4
  %2595 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2596 = getelementptr float, ptr %2595, i64 5263360
  store <4096 x float> zeroinitializer, ptr %2596, align 4
  %2597 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2598 = getelementptr float, ptr %2597, i64 5267456
  store <4096 x float> zeroinitializer, ptr %2598, align 4
  %2599 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2600 = getelementptr float, ptr %2599, i64 5271552
  store <4096 x float> zeroinitializer, ptr %2600, align 4
  %2601 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2602 = getelementptr float, ptr %2601, i64 5275648
  store <4096 x float> zeroinitializer, ptr %2602, align 4
  %2603 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2604 = getelementptr float, ptr %2603, i64 5279744
  store <4096 x float> zeroinitializer, ptr %2604, align 4
  %2605 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2606 = getelementptr float, ptr %2605, i64 5283840
  store <4096 x float> zeroinitializer, ptr %2606, align 4
  %2607 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2608 = getelementptr float, ptr %2607, i64 5287936
  store <4096 x float> zeroinitializer, ptr %2608, align 4
  %2609 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2610 = getelementptr float, ptr %2609, i64 5292032
  store <4096 x float> zeroinitializer, ptr %2610, align 4
  %2611 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2612 = getelementptr float, ptr %2611, i64 5296128
  store <4096 x float> zeroinitializer, ptr %2612, align 4
  %2613 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2614 = getelementptr float, ptr %2613, i64 5300224
  store <4096 x float> zeroinitializer, ptr %2614, align 4
  %2615 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2616 = getelementptr float, ptr %2615, i64 5304320
  store <4096 x float> zeroinitializer, ptr %2616, align 4
  %2617 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2618 = getelementptr float, ptr %2617, i64 5308416
  store <4096 x float> zeroinitializer, ptr %2618, align 4
  %2619 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2620 = getelementptr float, ptr %2619, i64 5312512
  store <4096 x float> zeroinitializer, ptr %2620, align 4
  %2621 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2622 = getelementptr float, ptr %2621, i64 5316608
  store <4096 x float> zeroinitializer, ptr %2622, align 4
  %2623 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2624 = getelementptr float, ptr %2623, i64 5320704
  store <4096 x float> zeroinitializer, ptr %2624, align 4
  %2625 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2626 = getelementptr float, ptr %2625, i64 5324800
  store <4096 x float> zeroinitializer, ptr %2626, align 4
  %2627 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2628 = getelementptr float, ptr %2627, i64 5328896
  store <4096 x float> zeroinitializer, ptr %2628, align 4
  %2629 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2630 = getelementptr float, ptr %2629, i64 5332992
  store <4096 x float> zeroinitializer, ptr %2630, align 4
  %2631 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2632 = getelementptr float, ptr %2631, i64 5337088
  store <4096 x float> zeroinitializer, ptr %2632, align 4
  %2633 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2634 = getelementptr float, ptr %2633, i64 5341184
  store <4096 x float> zeroinitializer, ptr %2634, align 4
  %2635 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2636 = getelementptr float, ptr %2635, i64 5345280
  store <4096 x float> zeroinitializer, ptr %2636, align 4
  %2637 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2638 = getelementptr float, ptr %2637, i64 5349376
  store <4096 x float> zeroinitializer, ptr %2638, align 4
  %2639 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2640 = getelementptr float, ptr %2639, i64 5353472
  store <4096 x float> zeroinitializer, ptr %2640, align 4
  %2641 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2642 = getelementptr float, ptr %2641, i64 5357568
  store <4096 x float> zeroinitializer, ptr %2642, align 4
  %2643 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2644 = getelementptr float, ptr %2643, i64 5361664
  store <4096 x float> zeroinitializer, ptr %2644, align 4
  %2645 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2646 = getelementptr float, ptr %2645, i64 5365760
  store <4096 x float> zeroinitializer, ptr %2646, align 4
  %2647 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2648 = getelementptr float, ptr %2647, i64 5369856
  store <4096 x float> zeroinitializer, ptr %2648, align 4
  %2649 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2650 = getelementptr float, ptr %2649, i64 5373952
  store <4096 x float> zeroinitializer, ptr %2650, align 4
  %2651 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2652 = getelementptr float, ptr %2651, i64 5378048
  store <4096 x float> zeroinitializer, ptr %2652, align 4
  %2653 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2654 = getelementptr float, ptr %2653, i64 5382144
  store <4096 x float> zeroinitializer, ptr %2654, align 4
  %2655 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2656 = getelementptr float, ptr %2655, i64 5386240
  store <4096 x float> zeroinitializer, ptr %2656, align 4
  %2657 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2658 = getelementptr float, ptr %2657, i64 5390336
  store <4096 x float> zeroinitializer, ptr %2658, align 4
  %2659 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2660 = getelementptr float, ptr %2659, i64 5394432
  store <4096 x float> zeroinitializer, ptr %2660, align 4
  %2661 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2662 = getelementptr float, ptr %2661, i64 5398528
  store <4096 x float> zeroinitializer, ptr %2662, align 4
  %2663 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2664 = getelementptr float, ptr %2663, i64 5402624
  store <4096 x float> zeroinitializer, ptr %2664, align 4
  %2665 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2666 = getelementptr float, ptr %2665, i64 5406720
  store <4096 x float> zeroinitializer, ptr %2666, align 4
  %2667 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2668 = getelementptr float, ptr %2667, i64 5410816
  store <4096 x float> zeroinitializer, ptr %2668, align 4
  %2669 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2670 = getelementptr float, ptr %2669, i64 5414912
  store <4096 x float> zeroinitializer, ptr %2670, align 4
  %2671 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2672 = getelementptr float, ptr %2671, i64 5419008
  store <4096 x float> zeroinitializer, ptr %2672, align 4
  %2673 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2674 = getelementptr float, ptr %2673, i64 5423104
  store <4096 x float> zeroinitializer, ptr %2674, align 4
  %2675 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2676 = getelementptr float, ptr %2675, i64 5427200
  store <4096 x float> zeroinitializer, ptr %2676, align 4
  %2677 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2678 = getelementptr float, ptr %2677, i64 5431296
  store <4096 x float> zeroinitializer, ptr %2678, align 4
  %2679 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2680 = getelementptr float, ptr %2679, i64 5435392
  store <4096 x float> zeroinitializer, ptr %2680, align 4
  %2681 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2682 = getelementptr float, ptr %2681, i64 5439488
  store <4096 x float> zeroinitializer, ptr %2682, align 4
  %2683 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2684 = getelementptr float, ptr %2683, i64 5443584
  store <4096 x float> zeroinitializer, ptr %2684, align 4
  %2685 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2686 = getelementptr float, ptr %2685, i64 5447680
  store <4096 x float> zeroinitializer, ptr %2686, align 4
  %2687 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2688 = getelementptr float, ptr %2687, i64 5451776
  store <4096 x float> zeroinitializer, ptr %2688, align 4
  %2689 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2690 = getelementptr float, ptr %2689, i64 5455872
  store <4096 x float> zeroinitializer, ptr %2690, align 4
  %2691 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2692 = getelementptr float, ptr %2691, i64 5459968
  store <4096 x float> zeroinitializer, ptr %2692, align 4
  %2693 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2694 = getelementptr float, ptr %2693, i64 5464064
  store <4096 x float> zeroinitializer, ptr %2694, align 4
  %2695 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2696 = getelementptr float, ptr %2695, i64 5468160
  store <4096 x float> zeroinitializer, ptr %2696, align 4
  %2697 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2698 = getelementptr float, ptr %2697, i64 5472256
  store <4096 x float> zeroinitializer, ptr %2698, align 4
  %2699 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2700 = getelementptr float, ptr %2699, i64 5476352
  store <4096 x float> zeroinitializer, ptr %2700, align 4
  %2701 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2702 = getelementptr float, ptr %2701, i64 5480448
  store <4096 x float> zeroinitializer, ptr %2702, align 4
  %2703 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2704 = getelementptr float, ptr %2703, i64 5484544
  store <4096 x float> zeroinitializer, ptr %2704, align 4
  %2705 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2706 = getelementptr float, ptr %2705, i64 5488640
  store <4096 x float> zeroinitializer, ptr %2706, align 4
  %2707 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2708 = getelementptr float, ptr %2707, i64 5492736
  store <4096 x float> zeroinitializer, ptr %2708, align 4
  %2709 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2710 = getelementptr float, ptr %2709, i64 5496832
  store <4096 x float> zeroinitializer, ptr %2710, align 4
  %2711 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2712 = getelementptr float, ptr %2711, i64 5500928
  store <4096 x float> zeroinitializer, ptr %2712, align 4
  %2713 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2714 = getelementptr float, ptr %2713, i64 5505024
  store <4096 x float> zeroinitializer, ptr %2714, align 4
  %2715 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2716 = getelementptr float, ptr %2715, i64 5509120
  store <4096 x float> zeroinitializer, ptr %2716, align 4
  %2717 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2718 = getelementptr float, ptr %2717, i64 5513216
  store <4096 x float> zeroinitializer, ptr %2718, align 4
  %2719 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2720 = getelementptr float, ptr %2719, i64 5517312
  store <4096 x float> zeroinitializer, ptr %2720, align 4
  %2721 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2722 = getelementptr float, ptr %2721, i64 5521408
  store <4096 x float> zeroinitializer, ptr %2722, align 4
  %2723 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2724 = getelementptr float, ptr %2723, i64 5525504
  store <4096 x float> zeroinitializer, ptr %2724, align 4
  %2725 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2726 = getelementptr float, ptr %2725, i64 5529600
  store <4096 x float> zeroinitializer, ptr %2726, align 4
  %2727 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2728 = getelementptr float, ptr %2727, i64 5533696
  store <4096 x float> zeroinitializer, ptr %2728, align 4
  %2729 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2730 = getelementptr float, ptr %2729, i64 5537792
  store <4096 x float> zeroinitializer, ptr %2730, align 4
  %2731 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2732 = getelementptr float, ptr %2731, i64 5541888
  store <4096 x float> zeroinitializer, ptr %2732, align 4
  %2733 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2734 = getelementptr float, ptr %2733, i64 5545984
  store <4096 x float> zeroinitializer, ptr %2734, align 4
  %2735 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2736 = getelementptr float, ptr %2735, i64 5550080
  store <4096 x float> zeroinitializer, ptr %2736, align 4
  %2737 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2738 = getelementptr float, ptr %2737, i64 5554176
  store <4096 x float> zeroinitializer, ptr %2738, align 4
  %2739 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2740 = getelementptr float, ptr %2739, i64 5558272
  store <4096 x float> zeroinitializer, ptr %2740, align 4
  %2741 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2742 = getelementptr float, ptr %2741, i64 5562368
  store <4096 x float> zeroinitializer, ptr %2742, align 4
  %2743 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2744 = getelementptr float, ptr %2743, i64 5566464
  store <4096 x float> zeroinitializer, ptr %2744, align 4
  %2745 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2746 = getelementptr float, ptr %2745, i64 5570560
  store <4096 x float> zeroinitializer, ptr %2746, align 4
  %2747 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2748 = getelementptr float, ptr %2747, i64 5574656
  store <4096 x float> zeroinitializer, ptr %2748, align 4
  %2749 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2750 = getelementptr float, ptr %2749, i64 5578752
  store <4096 x float> zeroinitializer, ptr %2750, align 4
  %2751 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2752 = getelementptr float, ptr %2751, i64 5582848
  store <4096 x float> zeroinitializer, ptr %2752, align 4
  %2753 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2754 = getelementptr float, ptr %2753, i64 5586944
  store <4096 x float> zeroinitializer, ptr %2754, align 4
  %2755 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2756 = getelementptr float, ptr %2755, i64 5591040
  store <4096 x float> zeroinitializer, ptr %2756, align 4
  %2757 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2758 = getelementptr float, ptr %2757, i64 5595136
  store <4096 x float> zeroinitializer, ptr %2758, align 4
  %2759 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2760 = getelementptr float, ptr %2759, i64 5599232
  store <4096 x float> zeroinitializer, ptr %2760, align 4
  %2761 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2762 = getelementptr float, ptr %2761, i64 5603328
  store <4096 x float> zeroinitializer, ptr %2762, align 4
  %2763 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2764 = getelementptr float, ptr %2763, i64 5607424
  store <4096 x float> zeroinitializer, ptr %2764, align 4
  %2765 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2766 = getelementptr float, ptr %2765, i64 5611520
  store <4096 x float> zeroinitializer, ptr %2766, align 4
  %2767 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2768 = getelementptr float, ptr %2767, i64 5615616
  store <4096 x float> zeroinitializer, ptr %2768, align 4
  %2769 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2770 = getelementptr float, ptr %2769, i64 5619712
  store <4096 x float> zeroinitializer, ptr %2770, align 4
  %2771 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2772 = getelementptr float, ptr %2771, i64 5623808
  store <4096 x float> zeroinitializer, ptr %2772, align 4
  %2773 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2774 = getelementptr float, ptr %2773, i64 5627904
  store <4096 x float> zeroinitializer, ptr %2774, align 4
  %2775 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2776 = getelementptr float, ptr %2775, i64 5632000
  store <4096 x float> zeroinitializer, ptr %2776, align 4
  %2777 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2778 = getelementptr float, ptr %2777, i64 5636096
  store <4096 x float> zeroinitializer, ptr %2778, align 4
  %2779 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2780 = getelementptr float, ptr %2779, i64 5640192
  store <4096 x float> zeroinitializer, ptr %2780, align 4
  %2781 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2782 = getelementptr float, ptr %2781, i64 5644288
  store <4096 x float> zeroinitializer, ptr %2782, align 4
  %2783 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2784 = getelementptr float, ptr %2783, i64 5648384
  store <4096 x float> zeroinitializer, ptr %2784, align 4
  %2785 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2786 = getelementptr float, ptr %2785, i64 5652480
  store <4096 x float> zeroinitializer, ptr %2786, align 4
  %2787 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2788 = getelementptr float, ptr %2787, i64 5656576
  store <4096 x float> zeroinitializer, ptr %2788, align 4
  %2789 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2790 = getelementptr float, ptr %2789, i64 5660672
  store <4096 x float> zeroinitializer, ptr %2790, align 4
  %2791 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2792 = getelementptr float, ptr %2791, i64 5664768
  store <4096 x float> zeroinitializer, ptr %2792, align 4
  %2793 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2794 = getelementptr float, ptr %2793, i64 5668864
  store <4096 x float> zeroinitializer, ptr %2794, align 4
  %2795 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2796 = getelementptr float, ptr %2795, i64 5672960
  store <4096 x float> zeroinitializer, ptr %2796, align 4
  %2797 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2798 = getelementptr float, ptr %2797, i64 5677056
  store <4096 x float> zeroinitializer, ptr %2798, align 4
  %2799 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2800 = getelementptr float, ptr %2799, i64 5681152
  store <4096 x float> zeroinitializer, ptr %2800, align 4
  %2801 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2802 = getelementptr float, ptr %2801, i64 5685248
  store <4096 x float> zeroinitializer, ptr %2802, align 4
  %2803 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2804 = getelementptr float, ptr %2803, i64 5689344
  store <4096 x float> zeroinitializer, ptr %2804, align 4
  %2805 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2806 = getelementptr float, ptr %2805, i64 5693440
  store <4096 x float> zeroinitializer, ptr %2806, align 4
  %2807 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2808 = getelementptr float, ptr %2807, i64 5697536
  store <4096 x float> zeroinitializer, ptr %2808, align 4
  %2809 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2810 = getelementptr float, ptr %2809, i64 5701632
  store <4096 x float> zeroinitializer, ptr %2810, align 4
  %2811 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2812 = getelementptr float, ptr %2811, i64 5705728
  store <4096 x float> zeroinitializer, ptr %2812, align 4
  %2813 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2814 = getelementptr float, ptr %2813, i64 5709824
  store <4096 x float> zeroinitializer, ptr %2814, align 4
  %2815 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2816 = getelementptr float, ptr %2815, i64 5713920
  store <4096 x float> zeroinitializer, ptr %2816, align 4
  %2817 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2818 = getelementptr float, ptr %2817, i64 5718016
  store <4096 x float> zeroinitializer, ptr %2818, align 4
  %2819 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2820 = getelementptr float, ptr %2819, i64 5722112
  store <4096 x float> zeroinitializer, ptr %2820, align 4
  %2821 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2822 = getelementptr float, ptr %2821, i64 5726208
  store <4096 x float> zeroinitializer, ptr %2822, align 4
  %2823 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2824 = getelementptr float, ptr %2823, i64 5730304
  store <4096 x float> zeroinitializer, ptr %2824, align 4
  %2825 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2826 = getelementptr float, ptr %2825, i64 5734400
  store <4096 x float> zeroinitializer, ptr %2826, align 4
  %2827 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2828 = getelementptr float, ptr %2827, i64 5738496
  store <4096 x float> zeroinitializer, ptr %2828, align 4
  %2829 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2830 = getelementptr float, ptr %2829, i64 5742592
  store <4096 x float> zeroinitializer, ptr %2830, align 4
  %2831 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2832 = getelementptr float, ptr %2831, i64 5746688
  store <4096 x float> zeroinitializer, ptr %2832, align 4
  %2833 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2834 = getelementptr float, ptr %2833, i64 5750784
  store <4096 x float> zeroinitializer, ptr %2834, align 4
  %2835 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2836 = getelementptr float, ptr %2835, i64 5754880
  store <4096 x float> zeroinitializer, ptr %2836, align 4
  %2837 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2838 = getelementptr float, ptr %2837, i64 5758976
  store <4096 x float> zeroinitializer, ptr %2838, align 4
  %2839 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2840 = getelementptr float, ptr %2839, i64 5763072
  store <4096 x float> zeroinitializer, ptr %2840, align 4
  %2841 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2842 = getelementptr float, ptr %2841, i64 5767168
  store <4096 x float> zeroinitializer, ptr %2842, align 4
  %2843 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2844 = getelementptr float, ptr %2843, i64 5771264
  store <4096 x float> zeroinitializer, ptr %2844, align 4
  %2845 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2846 = getelementptr float, ptr %2845, i64 5775360
  store <4096 x float> zeroinitializer, ptr %2846, align 4
  %2847 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2848 = getelementptr float, ptr %2847, i64 5779456
  store <4096 x float> zeroinitializer, ptr %2848, align 4
  %2849 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2850 = getelementptr float, ptr %2849, i64 5783552
  store <4096 x float> zeroinitializer, ptr %2850, align 4
  %2851 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2852 = getelementptr float, ptr %2851, i64 5787648
  store <4096 x float> zeroinitializer, ptr %2852, align 4
  %2853 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2854 = getelementptr float, ptr %2853, i64 5791744
  store <4096 x float> zeroinitializer, ptr %2854, align 4
  %2855 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2856 = getelementptr float, ptr %2855, i64 5795840
  store <4096 x float> zeroinitializer, ptr %2856, align 4
  %2857 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2858 = getelementptr float, ptr %2857, i64 5799936
  store <4096 x float> zeroinitializer, ptr %2858, align 4
  %2859 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2860 = getelementptr float, ptr %2859, i64 5804032
  store <4096 x float> zeroinitializer, ptr %2860, align 4
  %2861 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2862 = getelementptr float, ptr %2861, i64 5808128
  store <4096 x float> zeroinitializer, ptr %2862, align 4
  %2863 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2864 = getelementptr float, ptr %2863, i64 5812224
  store <4096 x float> zeroinitializer, ptr %2864, align 4
  %2865 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2866 = getelementptr float, ptr %2865, i64 5816320
  store <4096 x float> zeroinitializer, ptr %2866, align 4
  %2867 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2868 = getelementptr float, ptr %2867, i64 5820416
  store <4096 x float> zeroinitializer, ptr %2868, align 4
  %2869 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2870 = getelementptr float, ptr %2869, i64 5824512
  store <4096 x float> zeroinitializer, ptr %2870, align 4
  %2871 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2872 = getelementptr float, ptr %2871, i64 5828608
  store <4096 x float> zeroinitializer, ptr %2872, align 4
  %2873 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2874 = getelementptr float, ptr %2873, i64 5832704
  store <4096 x float> zeroinitializer, ptr %2874, align 4
  %2875 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2876 = getelementptr float, ptr %2875, i64 5836800
  store <4096 x float> zeroinitializer, ptr %2876, align 4
  %2877 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2878 = getelementptr float, ptr %2877, i64 5840896
  store <4096 x float> zeroinitializer, ptr %2878, align 4
  %2879 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2880 = getelementptr float, ptr %2879, i64 5844992
  store <4096 x float> zeroinitializer, ptr %2880, align 4
  %2881 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2882 = getelementptr float, ptr %2881, i64 5849088
  store <4096 x float> zeroinitializer, ptr %2882, align 4
  %2883 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2884 = getelementptr float, ptr %2883, i64 5853184
  store <4096 x float> zeroinitializer, ptr %2884, align 4
  %2885 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2886 = getelementptr float, ptr %2885, i64 5857280
  store <4096 x float> zeroinitializer, ptr %2886, align 4
  %2887 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2888 = getelementptr float, ptr %2887, i64 5861376
  store <4096 x float> zeroinitializer, ptr %2888, align 4
  %2889 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2890 = getelementptr float, ptr %2889, i64 5865472
  store <4096 x float> zeroinitializer, ptr %2890, align 4
  %2891 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2892 = getelementptr float, ptr %2891, i64 5869568
  store <4096 x float> zeroinitializer, ptr %2892, align 4
  %2893 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2894 = getelementptr float, ptr %2893, i64 5873664
  store <4096 x float> zeroinitializer, ptr %2894, align 4
  %2895 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2896 = getelementptr float, ptr %2895, i64 5877760
  store <4096 x float> zeroinitializer, ptr %2896, align 4
  %2897 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2898 = getelementptr float, ptr %2897, i64 5881856
  store <4096 x float> zeroinitializer, ptr %2898, align 4
  %2899 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2900 = getelementptr float, ptr %2899, i64 5885952
  store <4096 x float> zeroinitializer, ptr %2900, align 4
  %2901 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2902 = getelementptr float, ptr %2901, i64 5890048
  store <4096 x float> zeroinitializer, ptr %2902, align 4
  %2903 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2904 = getelementptr float, ptr %2903, i64 5894144
  store <4096 x float> zeroinitializer, ptr %2904, align 4
  %2905 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2906 = getelementptr float, ptr %2905, i64 5898240
  store <4096 x float> zeroinitializer, ptr %2906, align 4
  %2907 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2908 = getelementptr float, ptr %2907, i64 5902336
  store <4096 x float> zeroinitializer, ptr %2908, align 4
  %2909 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2910 = getelementptr float, ptr %2909, i64 5906432
  store <4096 x float> zeroinitializer, ptr %2910, align 4
  %2911 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2912 = getelementptr float, ptr %2911, i64 5910528
  store <4096 x float> zeroinitializer, ptr %2912, align 4
  %2913 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2914 = getelementptr float, ptr %2913, i64 5914624
  store <4096 x float> zeroinitializer, ptr %2914, align 4
  %2915 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2916 = getelementptr float, ptr %2915, i64 5918720
  store <4096 x float> zeroinitializer, ptr %2916, align 4
  %2917 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2918 = getelementptr float, ptr %2917, i64 5922816
  store <4096 x float> zeroinitializer, ptr %2918, align 4
  %2919 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2920 = getelementptr float, ptr %2919, i64 5926912
  store <4096 x float> zeroinitializer, ptr %2920, align 4
  %2921 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2922 = getelementptr float, ptr %2921, i64 5931008
  store <4096 x float> zeroinitializer, ptr %2922, align 4
  %2923 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2924 = getelementptr float, ptr %2923, i64 5935104
  store <4096 x float> zeroinitializer, ptr %2924, align 4
  %2925 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2926 = getelementptr float, ptr %2925, i64 5939200
  store <4096 x float> zeroinitializer, ptr %2926, align 4
  %2927 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2928 = getelementptr float, ptr %2927, i64 5943296
  store <4096 x float> zeroinitializer, ptr %2928, align 4
  %2929 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2930 = getelementptr float, ptr %2929, i64 5947392
  store <4096 x float> zeroinitializer, ptr %2930, align 4
  %2931 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2932 = getelementptr float, ptr %2931, i64 5951488
  store <4096 x float> zeroinitializer, ptr %2932, align 4
  %2933 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2934 = getelementptr float, ptr %2933, i64 5955584
  store <4096 x float> zeroinitializer, ptr %2934, align 4
  %2935 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2936 = getelementptr float, ptr %2935, i64 5959680
  store <4096 x float> zeroinitializer, ptr %2936, align 4
  %2937 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2938 = getelementptr float, ptr %2937, i64 5963776
  store <4096 x float> zeroinitializer, ptr %2938, align 4
  %2939 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2940 = getelementptr float, ptr %2939, i64 5967872
  store <4096 x float> zeroinitializer, ptr %2940, align 4
  %2941 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2942 = getelementptr float, ptr %2941, i64 5971968
  store <4096 x float> zeroinitializer, ptr %2942, align 4
  %2943 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2944 = getelementptr float, ptr %2943, i64 5976064
  store <4096 x float> zeroinitializer, ptr %2944, align 4
  %2945 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2946 = getelementptr float, ptr %2945, i64 5980160
  store <4096 x float> zeroinitializer, ptr %2946, align 4
  %2947 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2948 = getelementptr float, ptr %2947, i64 5984256
  store <4096 x float> zeroinitializer, ptr %2948, align 4
  %2949 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2950 = getelementptr float, ptr %2949, i64 5988352
  store <4096 x float> zeroinitializer, ptr %2950, align 4
  %2951 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2952 = getelementptr float, ptr %2951, i64 5992448
  store <4096 x float> zeroinitializer, ptr %2952, align 4
  %2953 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2954 = getelementptr float, ptr %2953, i64 5996544
  store <4096 x float> zeroinitializer, ptr %2954, align 4
  %2955 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2956 = getelementptr float, ptr %2955, i64 6000640
  store <4096 x float> zeroinitializer, ptr %2956, align 4
  %2957 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2958 = getelementptr float, ptr %2957, i64 6004736
  store <4096 x float> zeroinitializer, ptr %2958, align 4
  %2959 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2960 = getelementptr float, ptr %2959, i64 6008832
  store <4096 x float> zeroinitializer, ptr %2960, align 4
  %2961 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2962 = getelementptr float, ptr %2961, i64 6012928
  store <4096 x float> zeroinitializer, ptr %2962, align 4
  %2963 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2964 = getelementptr float, ptr %2963, i64 6017024
  store <4096 x float> zeroinitializer, ptr %2964, align 4
  %2965 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2966 = getelementptr float, ptr %2965, i64 6021120
  store <4096 x float> zeroinitializer, ptr %2966, align 4
  %2967 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2968 = getelementptr float, ptr %2967, i64 6025216
  store <4096 x float> zeroinitializer, ptr %2968, align 4
  %2969 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2970 = getelementptr float, ptr %2969, i64 6029312
  store <4096 x float> zeroinitializer, ptr %2970, align 4
  %2971 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2972 = getelementptr float, ptr %2971, i64 6033408
  store <4096 x float> zeroinitializer, ptr %2972, align 4
  %2973 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2974 = getelementptr float, ptr %2973, i64 6037504
  store <4096 x float> zeroinitializer, ptr %2974, align 4
  %2975 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2976 = getelementptr float, ptr %2975, i64 6041600
  store <4096 x float> zeroinitializer, ptr %2976, align 4
  %2977 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2978 = getelementptr float, ptr %2977, i64 6045696
  store <4096 x float> zeroinitializer, ptr %2978, align 4
  %2979 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2980 = getelementptr float, ptr %2979, i64 6049792
  store <4096 x float> zeroinitializer, ptr %2980, align 4
  %2981 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2982 = getelementptr float, ptr %2981, i64 6053888
  store <4096 x float> zeroinitializer, ptr %2982, align 4
  %2983 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2984 = getelementptr float, ptr %2983, i64 6057984
  store <4096 x float> zeroinitializer, ptr %2984, align 4
  %2985 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2986 = getelementptr float, ptr %2985, i64 6062080
  store <4096 x float> zeroinitializer, ptr %2986, align 4
  %2987 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2988 = getelementptr float, ptr %2987, i64 6066176
  store <4096 x float> zeroinitializer, ptr %2988, align 4
  %2989 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2990 = getelementptr float, ptr %2989, i64 6070272
  store <4096 x float> zeroinitializer, ptr %2990, align 4
  %2991 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2992 = getelementptr float, ptr %2991, i64 6074368
  store <4096 x float> zeroinitializer, ptr %2992, align 4
  %2993 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2994 = getelementptr float, ptr %2993, i64 6078464
  store <4096 x float> zeroinitializer, ptr %2994, align 4
  %2995 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2996 = getelementptr float, ptr %2995, i64 6082560
  store <4096 x float> zeroinitializer, ptr %2996, align 4
  %2997 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %2998 = getelementptr float, ptr %2997, i64 6086656
  store <4096 x float> zeroinitializer, ptr %2998, align 4
  %2999 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3000 = getelementptr float, ptr %2999, i64 6090752
  store <4096 x float> zeroinitializer, ptr %3000, align 4
  %3001 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3002 = getelementptr float, ptr %3001, i64 6094848
  store <4096 x float> zeroinitializer, ptr %3002, align 4
  %3003 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3004 = getelementptr float, ptr %3003, i64 6098944
  store <4096 x float> zeroinitializer, ptr %3004, align 4
  %3005 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3006 = getelementptr float, ptr %3005, i64 6103040
  store <4096 x float> zeroinitializer, ptr %3006, align 4
  %3007 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3008 = getelementptr float, ptr %3007, i64 6107136
  store <4096 x float> zeroinitializer, ptr %3008, align 4
  %3009 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3010 = getelementptr float, ptr %3009, i64 6111232
  store <4096 x float> zeroinitializer, ptr %3010, align 4
  %3011 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3012 = getelementptr float, ptr %3011, i64 6115328
  store <4096 x float> zeroinitializer, ptr %3012, align 4
  %3013 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3014 = getelementptr float, ptr %3013, i64 6119424
  store <4096 x float> zeroinitializer, ptr %3014, align 4
  %3015 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3016 = getelementptr float, ptr %3015, i64 6123520
  store <4096 x float> zeroinitializer, ptr %3016, align 4
  %3017 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3018 = getelementptr float, ptr %3017, i64 6127616
  store <4096 x float> zeroinitializer, ptr %3018, align 4
  %3019 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3020 = getelementptr float, ptr %3019, i64 6131712
  store <4096 x float> zeroinitializer, ptr %3020, align 4
  %3021 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3022 = getelementptr float, ptr %3021, i64 6135808
  store <4096 x float> zeroinitializer, ptr %3022, align 4
  %3023 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3024 = getelementptr float, ptr %3023, i64 6139904
  store <4096 x float> zeroinitializer, ptr %3024, align 4
  %3025 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3026 = getelementptr float, ptr %3025, i64 6144000
  store <4096 x float> zeroinitializer, ptr %3026, align 4
  %3027 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3028 = getelementptr float, ptr %3027, i64 6148096
  store <4096 x float> zeroinitializer, ptr %3028, align 4
  %3029 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3030 = getelementptr float, ptr %3029, i64 6152192
  store <4096 x float> zeroinitializer, ptr %3030, align 4
  %3031 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3032 = getelementptr float, ptr %3031, i64 6156288
  store <4096 x float> zeroinitializer, ptr %3032, align 4
  %3033 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3034 = getelementptr float, ptr %3033, i64 6160384
  store <4096 x float> zeroinitializer, ptr %3034, align 4
  %3035 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3036 = getelementptr float, ptr %3035, i64 6164480
  store <4096 x float> zeroinitializer, ptr %3036, align 4
  %3037 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3038 = getelementptr float, ptr %3037, i64 6168576
  store <4096 x float> zeroinitializer, ptr %3038, align 4
  %3039 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3040 = getelementptr float, ptr %3039, i64 6172672
  store <4096 x float> zeroinitializer, ptr %3040, align 4
  %3041 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3042 = getelementptr float, ptr %3041, i64 6176768
  store <4096 x float> zeroinitializer, ptr %3042, align 4
  %3043 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3044 = getelementptr float, ptr %3043, i64 6180864
  store <4096 x float> zeroinitializer, ptr %3044, align 4
  %3045 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3046 = getelementptr float, ptr %3045, i64 6184960
  store <4096 x float> zeroinitializer, ptr %3046, align 4
  %3047 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3048 = getelementptr float, ptr %3047, i64 6189056
  store <4096 x float> zeroinitializer, ptr %3048, align 4
  %3049 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3050 = getelementptr float, ptr %3049, i64 6193152
  store <4096 x float> zeroinitializer, ptr %3050, align 4
  %3051 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3052 = getelementptr float, ptr %3051, i64 6197248
  store <4096 x float> zeroinitializer, ptr %3052, align 4
  %3053 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3054 = getelementptr float, ptr %3053, i64 6201344
  store <4096 x float> zeroinitializer, ptr %3054, align 4
  %3055 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3056 = getelementptr float, ptr %3055, i64 6205440
  store <4096 x float> zeroinitializer, ptr %3056, align 4
  %3057 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3058 = getelementptr float, ptr %3057, i64 6209536
  store <4096 x float> zeroinitializer, ptr %3058, align 4
  %3059 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3060 = getelementptr float, ptr %3059, i64 6213632
  store <4096 x float> zeroinitializer, ptr %3060, align 4
  %3061 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3062 = getelementptr float, ptr %3061, i64 6217728
  store <4096 x float> zeroinitializer, ptr %3062, align 4
  %3063 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3064 = getelementptr float, ptr %3063, i64 6221824
  store <4096 x float> zeroinitializer, ptr %3064, align 4
  %3065 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3066 = getelementptr float, ptr %3065, i64 6225920
  store <4096 x float> zeroinitializer, ptr %3066, align 4
  %3067 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3068 = getelementptr float, ptr %3067, i64 6230016
  store <4096 x float> zeroinitializer, ptr %3068, align 4
  %3069 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3070 = getelementptr float, ptr %3069, i64 6234112
  store <4096 x float> zeroinitializer, ptr %3070, align 4
  %3071 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3072 = getelementptr float, ptr %3071, i64 6238208
  store <4096 x float> zeroinitializer, ptr %3072, align 4
  %3073 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3074 = getelementptr float, ptr %3073, i64 6242304
  store <4096 x float> zeroinitializer, ptr %3074, align 4
  %3075 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3076 = getelementptr float, ptr %3075, i64 6246400
  store <4096 x float> zeroinitializer, ptr %3076, align 4
  %3077 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3078 = getelementptr float, ptr %3077, i64 6250496
  store <4096 x float> zeroinitializer, ptr %3078, align 4
  %3079 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3080 = getelementptr float, ptr %3079, i64 6254592
  store <4096 x float> zeroinitializer, ptr %3080, align 4
  %3081 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3082 = getelementptr float, ptr %3081, i64 6258688
  store <4096 x float> zeroinitializer, ptr %3082, align 4
  %3083 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3084 = getelementptr float, ptr %3083, i64 6262784
  store <4096 x float> zeroinitializer, ptr %3084, align 4
  %3085 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3086 = getelementptr float, ptr %3085, i64 6266880
  store <4096 x float> zeroinitializer, ptr %3086, align 4
  %3087 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3088 = getelementptr float, ptr %3087, i64 6270976
  store <4096 x float> zeroinitializer, ptr %3088, align 4
  %3089 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3090 = getelementptr float, ptr %3089, i64 6275072
  store <4096 x float> zeroinitializer, ptr %3090, align 4
  %3091 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3092 = getelementptr float, ptr %3091, i64 6279168
  store <4096 x float> zeroinitializer, ptr %3092, align 4
  %3093 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3094 = getelementptr float, ptr %3093, i64 6283264
  store <4096 x float> zeroinitializer, ptr %3094, align 4
  %3095 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3096 = getelementptr float, ptr %3095, i64 6287360
  store <4096 x float> zeroinitializer, ptr %3096, align 4
  %3097 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3098 = getelementptr float, ptr %3097, i64 6291456
  store <4096 x float> zeroinitializer, ptr %3098, align 4
  %3099 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3100 = getelementptr float, ptr %3099, i64 6295552
  store <4096 x float> zeroinitializer, ptr %3100, align 4
  %3101 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3102 = getelementptr float, ptr %3101, i64 6299648
  store <4096 x float> zeroinitializer, ptr %3102, align 4
  %3103 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3104 = getelementptr float, ptr %3103, i64 6303744
  store <4096 x float> zeroinitializer, ptr %3104, align 4
  %3105 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3106 = getelementptr float, ptr %3105, i64 6307840
  store <4096 x float> zeroinitializer, ptr %3106, align 4
  %3107 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3108 = getelementptr float, ptr %3107, i64 6311936
  store <4096 x float> zeroinitializer, ptr %3108, align 4
  %3109 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3110 = getelementptr float, ptr %3109, i64 6316032
  store <4096 x float> zeroinitializer, ptr %3110, align 4
  %3111 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3112 = getelementptr float, ptr %3111, i64 6320128
  store <4096 x float> zeroinitializer, ptr %3112, align 4
  %3113 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3114 = getelementptr float, ptr %3113, i64 6324224
  store <4096 x float> zeroinitializer, ptr %3114, align 4
  %3115 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3116 = getelementptr float, ptr %3115, i64 6328320
  store <4096 x float> zeroinitializer, ptr %3116, align 4
  %3117 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3118 = getelementptr float, ptr %3117, i64 6332416
  store <4096 x float> zeroinitializer, ptr %3118, align 4
  %3119 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3120 = getelementptr float, ptr %3119, i64 6336512
  store <4096 x float> zeroinitializer, ptr %3120, align 4
  %3121 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3122 = getelementptr float, ptr %3121, i64 6340608
  store <4096 x float> zeroinitializer, ptr %3122, align 4
  %3123 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3124 = getelementptr float, ptr %3123, i64 6344704
  store <4096 x float> zeroinitializer, ptr %3124, align 4
  %3125 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3126 = getelementptr float, ptr %3125, i64 6348800
  store <4096 x float> zeroinitializer, ptr %3126, align 4
  %3127 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3128 = getelementptr float, ptr %3127, i64 6352896
  store <4096 x float> zeroinitializer, ptr %3128, align 4
  %3129 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3130 = getelementptr float, ptr %3129, i64 6356992
  store <4096 x float> zeroinitializer, ptr %3130, align 4
  %3131 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3132 = getelementptr float, ptr %3131, i64 6361088
  store <4096 x float> zeroinitializer, ptr %3132, align 4
  %3133 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3134 = getelementptr float, ptr %3133, i64 6365184
  store <4096 x float> zeroinitializer, ptr %3134, align 4
  %3135 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3136 = getelementptr float, ptr %3135, i64 6369280
  store <4096 x float> zeroinitializer, ptr %3136, align 4
  %3137 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3138 = getelementptr float, ptr %3137, i64 6373376
  store <4096 x float> zeroinitializer, ptr %3138, align 4
  %3139 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3140 = getelementptr float, ptr %3139, i64 6377472
  store <4096 x float> zeroinitializer, ptr %3140, align 4
  %3141 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3142 = getelementptr float, ptr %3141, i64 6381568
  store <4096 x float> zeroinitializer, ptr %3142, align 4
  %3143 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3144 = getelementptr float, ptr %3143, i64 6385664
  store <4096 x float> zeroinitializer, ptr %3144, align 4
  %3145 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3146 = getelementptr float, ptr %3145, i64 6389760
  store <4096 x float> zeroinitializer, ptr %3146, align 4
  %3147 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3148 = getelementptr float, ptr %3147, i64 6393856
  store <4096 x float> zeroinitializer, ptr %3148, align 4
  %3149 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3150 = getelementptr float, ptr %3149, i64 6397952
  store <4096 x float> zeroinitializer, ptr %3150, align 4
  %3151 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3152 = getelementptr float, ptr %3151, i64 6402048
  store <4096 x float> zeroinitializer, ptr %3152, align 4
  %3153 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3154 = getelementptr float, ptr %3153, i64 6406144
  store <4096 x float> zeroinitializer, ptr %3154, align 4
  %3155 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3156 = getelementptr float, ptr %3155, i64 6410240
  store <4096 x float> zeroinitializer, ptr %3156, align 4
  %3157 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3158 = getelementptr float, ptr %3157, i64 6414336
  store <4096 x float> zeroinitializer, ptr %3158, align 4
  %3159 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3160 = getelementptr float, ptr %3159, i64 6418432
  store <4096 x float> zeroinitializer, ptr %3160, align 4
  %3161 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3162 = getelementptr float, ptr %3161, i64 6422528
  store <4096 x float> zeroinitializer, ptr %3162, align 4
  %3163 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3164 = getelementptr float, ptr %3163, i64 6426624
  store <4096 x float> zeroinitializer, ptr %3164, align 4
  %3165 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3166 = getelementptr float, ptr %3165, i64 6430720
  store <4096 x float> zeroinitializer, ptr %3166, align 4
  %3167 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3168 = getelementptr float, ptr %3167, i64 6434816
  store <4096 x float> zeroinitializer, ptr %3168, align 4
  %3169 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3170 = getelementptr float, ptr %3169, i64 6438912
  store <4096 x float> zeroinitializer, ptr %3170, align 4
  %3171 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3172 = getelementptr float, ptr %3171, i64 6443008
  store <4096 x float> zeroinitializer, ptr %3172, align 4
  %3173 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3174 = getelementptr float, ptr %3173, i64 6447104
  store <4096 x float> zeroinitializer, ptr %3174, align 4
  %3175 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3176 = getelementptr float, ptr %3175, i64 6451200
  store <4096 x float> zeroinitializer, ptr %3176, align 4
  %3177 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3178 = getelementptr float, ptr %3177, i64 6455296
  store <4096 x float> zeroinitializer, ptr %3178, align 4
  %3179 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3180 = getelementptr float, ptr %3179, i64 6459392
  store <4096 x float> zeroinitializer, ptr %3180, align 4
  %3181 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3182 = getelementptr float, ptr %3181, i64 6463488
  store <4096 x float> zeroinitializer, ptr %3182, align 4
  %3183 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3184 = getelementptr float, ptr %3183, i64 6467584
  store <4096 x float> zeroinitializer, ptr %3184, align 4
  %3185 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3186 = getelementptr float, ptr %3185, i64 6471680
  store <4096 x float> zeroinitializer, ptr %3186, align 4
  %3187 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3188 = getelementptr float, ptr %3187, i64 6475776
  store <4096 x float> zeroinitializer, ptr %3188, align 4
  %3189 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3190 = getelementptr float, ptr %3189, i64 6479872
  store <4096 x float> zeroinitializer, ptr %3190, align 4
  %3191 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3192 = getelementptr float, ptr %3191, i64 6483968
  store <4096 x float> zeroinitializer, ptr %3192, align 4
  %3193 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3194 = getelementptr float, ptr %3193, i64 6488064
  store <4096 x float> zeroinitializer, ptr %3194, align 4
  %3195 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3196 = getelementptr float, ptr %3195, i64 6492160
  store <4096 x float> zeroinitializer, ptr %3196, align 4
  %3197 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3198 = getelementptr float, ptr %3197, i64 6496256
  store <4096 x float> zeroinitializer, ptr %3198, align 4
  %3199 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3200 = getelementptr float, ptr %3199, i64 6500352
  store <4096 x float> zeroinitializer, ptr %3200, align 4
  %3201 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3202 = getelementptr float, ptr %3201, i64 6504448
  store <4096 x float> zeroinitializer, ptr %3202, align 4
  %3203 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3204 = getelementptr float, ptr %3203, i64 6508544
  store <4096 x float> zeroinitializer, ptr %3204, align 4
  %3205 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3206 = getelementptr float, ptr %3205, i64 6512640
  store <4096 x float> zeroinitializer, ptr %3206, align 4
  %3207 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3208 = getelementptr float, ptr %3207, i64 6516736
  store <4096 x float> zeroinitializer, ptr %3208, align 4
  %3209 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3210 = getelementptr float, ptr %3209, i64 6520832
  store <4096 x float> zeroinitializer, ptr %3210, align 4
  %3211 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3212 = getelementptr float, ptr %3211, i64 6524928
  store <4096 x float> zeroinitializer, ptr %3212, align 4
  %3213 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3214 = getelementptr float, ptr %3213, i64 6529024
  store <4096 x float> zeroinitializer, ptr %3214, align 4
  %3215 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3216 = getelementptr float, ptr %3215, i64 6533120
  store <4096 x float> zeroinitializer, ptr %3216, align 4
  %3217 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3218 = getelementptr float, ptr %3217, i64 6537216
  store <4096 x float> zeroinitializer, ptr %3218, align 4
  %3219 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3220 = getelementptr float, ptr %3219, i64 6541312
  store <4096 x float> zeroinitializer, ptr %3220, align 4
  %3221 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3222 = getelementptr float, ptr %3221, i64 6545408
  store <4096 x float> zeroinitializer, ptr %3222, align 4
  %3223 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3224 = getelementptr float, ptr %3223, i64 6549504
  store <4096 x float> zeroinitializer, ptr %3224, align 4
  %3225 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3226 = getelementptr float, ptr %3225, i64 6553600
  store <4096 x float> zeroinitializer, ptr %3226, align 4
  %3227 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3228 = getelementptr float, ptr %3227, i64 6557696
  store <4096 x float> zeroinitializer, ptr %3228, align 4
  %3229 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3230 = getelementptr float, ptr %3229, i64 6561792
  store <4096 x float> zeroinitializer, ptr %3230, align 4
  %3231 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3232 = getelementptr float, ptr %3231, i64 6565888
  store <4096 x float> zeroinitializer, ptr %3232, align 4
  %3233 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3234 = getelementptr float, ptr %3233, i64 6569984
  store <4096 x float> zeroinitializer, ptr %3234, align 4
  %3235 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3236 = getelementptr float, ptr %3235, i64 6574080
  store <4096 x float> zeroinitializer, ptr %3236, align 4
  %3237 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3238 = getelementptr float, ptr %3237, i64 6578176
  store <4096 x float> zeroinitializer, ptr %3238, align 4
  %3239 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3240 = getelementptr float, ptr %3239, i64 6582272
  store <4096 x float> zeroinitializer, ptr %3240, align 4
  %3241 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3242 = getelementptr float, ptr %3241, i64 6586368
  store <4096 x float> zeroinitializer, ptr %3242, align 4
  %3243 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3244 = getelementptr float, ptr %3243, i64 6590464
  store <4096 x float> zeroinitializer, ptr %3244, align 4
  %3245 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3246 = getelementptr float, ptr %3245, i64 6594560
  store <4096 x float> zeroinitializer, ptr %3246, align 4
  %3247 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3248 = getelementptr float, ptr %3247, i64 6598656
  store <4096 x float> zeroinitializer, ptr %3248, align 4
  %3249 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3250 = getelementptr float, ptr %3249, i64 6602752
  store <4096 x float> zeroinitializer, ptr %3250, align 4
  %3251 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3252 = getelementptr float, ptr %3251, i64 6606848
  store <4096 x float> zeroinitializer, ptr %3252, align 4
  %3253 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3254 = getelementptr float, ptr %3253, i64 6610944
  store <4096 x float> zeroinitializer, ptr %3254, align 4
  %3255 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3256 = getelementptr float, ptr %3255, i64 6615040
  store <4096 x float> zeroinitializer, ptr %3256, align 4
  %3257 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3258 = getelementptr float, ptr %3257, i64 6619136
  store <4096 x float> zeroinitializer, ptr %3258, align 4
  %3259 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3260 = getelementptr float, ptr %3259, i64 6623232
  store <4096 x float> zeroinitializer, ptr %3260, align 4
  %3261 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3262 = getelementptr float, ptr %3261, i64 6627328
  store <4096 x float> zeroinitializer, ptr %3262, align 4
  %3263 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3264 = getelementptr float, ptr %3263, i64 6631424
  store <4096 x float> zeroinitializer, ptr %3264, align 4
  %3265 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3266 = getelementptr float, ptr %3265, i64 6635520
  store <4096 x float> zeroinitializer, ptr %3266, align 4
  %3267 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3268 = getelementptr float, ptr %3267, i64 6639616
  store <4096 x float> zeroinitializer, ptr %3268, align 4
  %3269 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3270 = getelementptr float, ptr %3269, i64 6643712
  store <4096 x float> zeroinitializer, ptr %3270, align 4
  %3271 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3272 = getelementptr float, ptr %3271, i64 6647808
  store <4096 x float> zeroinitializer, ptr %3272, align 4
  %3273 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3274 = getelementptr float, ptr %3273, i64 6651904
  store <4096 x float> zeroinitializer, ptr %3274, align 4
  %3275 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3276 = getelementptr float, ptr %3275, i64 6656000
  store <4096 x float> zeroinitializer, ptr %3276, align 4
  %3277 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3278 = getelementptr float, ptr %3277, i64 6660096
  store <4096 x float> zeroinitializer, ptr %3278, align 4
  %3279 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3280 = getelementptr float, ptr %3279, i64 6664192
  store <4096 x float> zeroinitializer, ptr %3280, align 4
  %3281 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3282 = getelementptr float, ptr %3281, i64 6668288
  store <4096 x float> zeroinitializer, ptr %3282, align 4
  %3283 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3284 = getelementptr float, ptr %3283, i64 6672384
  store <4096 x float> zeroinitializer, ptr %3284, align 4
  %3285 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3286 = getelementptr float, ptr %3285, i64 6676480
  store <4096 x float> zeroinitializer, ptr %3286, align 4
  %3287 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3288 = getelementptr float, ptr %3287, i64 6680576
  store <4096 x float> zeroinitializer, ptr %3288, align 4
  %3289 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3290 = getelementptr float, ptr %3289, i64 6684672
  store <4096 x float> zeroinitializer, ptr %3290, align 4
  %3291 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3292 = getelementptr float, ptr %3291, i64 6688768
  store <4096 x float> zeroinitializer, ptr %3292, align 4
  %3293 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3294 = getelementptr float, ptr %3293, i64 6692864
  store <4096 x float> zeroinitializer, ptr %3294, align 4
  %3295 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3296 = getelementptr float, ptr %3295, i64 6696960
  store <4096 x float> zeroinitializer, ptr %3296, align 4
  %3297 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3298 = getelementptr float, ptr %3297, i64 6701056
  store <4096 x float> zeroinitializer, ptr %3298, align 4
  %3299 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3300 = getelementptr float, ptr %3299, i64 6705152
  store <4096 x float> zeroinitializer, ptr %3300, align 4
  %3301 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3302 = getelementptr float, ptr %3301, i64 6709248
  store <4096 x float> zeroinitializer, ptr %3302, align 4
  %3303 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3304 = getelementptr float, ptr %3303, i64 6713344
  store <4096 x float> zeroinitializer, ptr %3304, align 4
  %3305 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3306 = getelementptr float, ptr %3305, i64 6717440
  store <4096 x float> zeroinitializer, ptr %3306, align 4
  %3307 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3308 = getelementptr float, ptr %3307, i64 6721536
  store <4096 x float> zeroinitializer, ptr %3308, align 4
  %3309 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3310 = getelementptr float, ptr %3309, i64 6725632
  store <4096 x float> zeroinitializer, ptr %3310, align 4
  %3311 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3312 = getelementptr float, ptr %3311, i64 6729728
  store <4096 x float> zeroinitializer, ptr %3312, align 4
  %3313 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3314 = getelementptr float, ptr %3313, i64 6733824
  store <4096 x float> zeroinitializer, ptr %3314, align 4
  %3315 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3316 = getelementptr float, ptr %3315, i64 6737920
  store <4096 x float> zeroinitializer, ptr %3316, align 4
  %3317 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3318 = getelementptr float, ptr %3317, i64 6742016
  store <4096 x float> zeroinitializer, ptr %3318, align 4
  %3319 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3320 = getelementptr float, ptr %3319, i64 6746112
  store <4096 x float> zeroinitializer, ptr %3320, align 4
  %3321 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3322 = getelementptr float, ptr %3321, i64 6750208
  store <4096 x float> zeroinitializer, ptr %3322, align 4
  %3323 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3324 = getelementptr float, ptr %3323, i64 6754304
  store <4096 x float> zeroinitializer, ptr %3324, align 4
  %3325 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3326 = getelementptr float, ptr %3325, i64 6758400
  store <4096 x float> zeroinitializer, ptr %3326, align 4
  %3327 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3328 = getelementptr float, ptr %3327, i64 6762496
  store <4096 x float> zeroinitializer, ptr %3328, align 4
  %3329 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3330 = getelementptr float, ptr %3329, i64 6766592
  store <4096 x float> zeroinitializer, ptr %3330, align 4
  %3331 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3332 = getelementptr float, ptr %3331, i64 6770688
  store <4096 x float> zeroinitializer, ptr %3332, align 4
  %3333 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3334 = getelementptr float, ptr %3333, i64 6774784
  store <4096 x float> zeroinitializer, ptr %3334, align 4
  %3335 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3336 = getelementptr float, ptr %3335, i64 6778880
  store <4096 x float> zeroinitializer, ptr %3336, align 4
  %3337 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3338 = getelementptr float, ptr %3337, i64 6782976
  store <4096 x float> zeroinitializer, ptr %3338, align 4
  %3339 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3340 = getelementptr float, ptr %3339, i64 6787072
  store <4096 x float> zeroinitializer, ptr %3340, align 4
  %3341 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3342 = getelementptr float, ptr %3341, i64 6791168
  store <4096 x float> zeroinitializer, ptr %3342, align 4
  %3343 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3344 = getelementptr float, ptr %3343, i64 6795264
  store <4096 x float> zeroinitializer, ptr %3344, align 4
  %3345 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3346 = getelementptr float, ptr %3345, i64 6799360
  store <4096 x float> zeroinitializer, ptr %3346, align 4
  %3347 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3348 = getelementptr float, ptr %3347, i64 6803456
  store <4096 x float> zeroinitializer, ptr %3348, align 4
  %3349 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3350 = getelementptr float, ptr %3349, i64 6807552
  store <4096 x float> zeroinitializer, ptr %3350, align 4
  %3351 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3352 = getelementptr float, ptr %3351, i64 6811648
  store <4096 x float> zeroinitializer, ptr %3352, align 4
  %3353 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3354 = getelementptr float, ptr %3353, i64 6815744
  store <4096 x float> zeroinitializer, ptr %3354, align 4
  %3355 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3356 = getelementptr float, ptr %3355, i64 6819840
  store <4096 x float> zeroinitializer, ptr %3356, align 4
  %3357 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3358 = getelementptr float, ptr %3357, i64 6823936
  store <4096 x float> zeroinitializer, ptr %3358, align 4
  %3359 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3360 = getelementptr float, ptr %3359, i64 6828032
  store <4096 x float> zeroinitializer, ptr %3360, align 4
  %3361 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3362 = getelementptr float, ptr %3361, i64 6832128
  store <4096 x float> zeroinitializer, ptr %3362, align 4
  %3363 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3364 = getelementptr float, ptr %3363, i64 6836224
  store <4096 x float> zeroinitializer, ptr %3364, align 4
  %3365 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3366 = getelementptr float, ptr %3365, i64 6840320
  store <4096 x float> zeroinitializer, ptr %3366, align 4
  %3367 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3368 = getelementptr float, ptr %3367, i64 6844416
  store <4096 x float> zeroinitializer, ptr %3368, align 4
  %3369 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3370 = getelementptr float, ptr %3369, i64 6848512
  store <4096 x float> zeroinitializer, ptr %3370, align 4
  %3371 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3372 = getelementptr float, ptr %3371, i64 6852608
  store <4096 x float> zeroinitializer, ptr %3372, align 4
  %3373 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3374 = getelementptr float, ptr %3373, i64 6856704
  store <4096 x float> zeroinitializer, ptr %3374, align 4
  %3375 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3376 = getelementptr float, ptr %3375, i64 6860800
  store <4096 x float> zeroinitializer, ptr %3376, align 4
  %3377 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3378 = getelementptr float, ptr %3377, i64 6864896
  store <4096 x float> zeroinitializer, ptr %3378, align 4
  %3379 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3380 = getelementptr float, ptr %3379, i64 6868992
  store <4096 x float> zeroinitializer, ptr %3380, align 4
  %3381 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3382 = getelementptr float, ptr %3381, i64 6873088
  store <4096 x float> zeroinitializer, ptr %3382, align 4
  %3383 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3384 = getelementptr float, ptr %3383, i64 6877184
  store <4096 x float> zeroinitializer, ptr %3384, align 4
  %3385 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3386 = getelementptr float, ptr %3385, i64 6881280
  store <4096 x float> zeroinitializer, ptr %3386, align 4
  %3387 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3388 = getelementptr float, ptr %3387, i64 6885376
  store <4096 x float> zeroinitializer, ptr %3388, align 4
  %3389 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3390 = getelementptr float, ptr %3389, i64 6889472
  store <4096 x float> zeroinitializer, ptr %3390, align 4
  %3391 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3392 = getelementptr float, ptr %3391, i64 6893568
  store <4096 x float> zeroinitializer, ptr %3392, align 4
  %3393 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3394 = getelementptr float, ptr %3393, i64 6897664
  store <4096 x float> zeroinitializer, ptr %3394, align 4
  %3395 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3396 = getelementptr float, ptr %3395, i64 6901760
  store <4096 x float> zeroinitializer, ptr %3396, align 4
  %3397 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3398 = getelementptr float, ptr %3397, i64 6905856
  store <4096 x float> zeroinitializer, ptr %3398, align 4
  %3399 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3400 = getelementptr float, ptr %3399, i64 6909952
  store <4096 x float> zeroinitializer, ptr %3400, align 4
  %3401 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3402 = getelementptr float, ptr %3401, i64 6914048
  store <4096 x float> zeroinitializer, ptr %3402, align 4
  %3403 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3404 = getelementptr float, ptr %3403, i64 6918144
  store <4096 x float> zeroinitializer, ptr %3404, align 4
  %3405 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3406 = getelementptr float, ptr %3405, i64 6922240
  store <4096 x float> zeroinitializer, ptr %3406, align 4
  %3407 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3408 = getelementptr float, ptr %3407, i64 6926336
  store <4096 x float> zeroinitializer, ptr %3408, align 4
  %3409 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3410 = getelementptr float, ptr %3409, i64 6930432
  store <4096 x float> zeroinitializer, ptr %3410, align 4
  %3411 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3412 = getelementptr float, ptr %3411, i64 6934528
  store <4096 x float> zeroinitializer, ptr %3412, align 4
  %3413 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3414 = getelementptr float, ptr %3413, i64 6938624
  store <4096 x float> zeroinitializer, ptr %3414, align 4
  %3415 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3416 = getelementptr float, ptr %3415, i64 6942720
  store <4096 x float> zeroinitializer, ptr %3416, align 4
  %3417 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3418 = getelementptr float, ptr %3417, i64 6946816
  store <4096 x float> zeroinitializer, ptr %3418, align 4
  %3419 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3420 = getelementptr float, ptr %3419, i64 6950912
  store <4096 x float> zeroinitializer, ptr %3420, align 4
  %3421 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3422 = getelementptr float, ptr %3421, i64 6955008
  store <4096 x float> zeroinitializer, ptr %3422, align 4
  %3423 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3424 = getelementptr float, ptr %3423, i64 6959104
  store <4096 x float> zeroinitializer, ptr %3424, align 4
  %3425 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3426 = getelementptr float, ptr %3425, i64 6963200
  store <4096 x float> zeroinitializer, ptr %3426, align 4
  %3427 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3428 = getelementptr float, ptr %3427, i64 6967296
  store <4096 x float> zeroinitializer, ptr %3428, align 4
  %3429 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3430 = getelementptr float, ptr %3429, i64 6971392
  store <4096 x float> zeroinitializer, ptr %3430, align 4
  %3431 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3432 = getelementptr float, ptr %3431, i64 6975488
  store <4096 x float> zeroinitializer, ptr %3432, align 4
  %3433 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3434 = getelementptr float, ptr %3433, i64 6979584
  store <4096 x float> zeroinitializer, ptr %3434, align 4
  %3435 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3436 = getelementptr float, ptr %3435, i64 6983680
  store <4096 x float> zeroinitializer, ptr %3436, align 4
  %3437 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3438 = getelementptr float, ptr %3437, i64 6987776
  store <4096 x float> zeroinitializer, ptr %3438, align 4
  %3439 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3440 = getelementptr float, ptr %3439, i64 6991872
  store <4096 x float> zeroinitializer, ptr %3440, align 4
  %3441 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3442 = getelementptr float, ptr %3441, i64 6995968
  store <4096 x float> zeroinitializer, ptr %3442, align 4
  %3443 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3444 = getelementptr float, ptr %3443, i64 7000064
  store <4096 x float> zeroinitializer, ptr %3444, align 4
  %3445 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3446 = getelementptr float, ptr %3445, i64 7004160
  store <4096 x float> zeroinitializer, ptr %3446, align 4
  %3447 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3448 = getelementptr float, ptr %3447, i64 7008256
  store <4096 x float> zeroinitializer, ptr %3448, align 4
  %3449 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3450 = getelementptr float, ptr %3449, i64 7012352
  store <4096 x float> zeroinitializer, ptr %3450, align 4
  %3451 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3452 = getelementptr float, ptr %3451, i64 7016448
  store <4096 x float> zeroinitializer, ptr %3452, align 4
  %3453 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3454 = getelementptr float, ptr %3453, i64 7020544
  store <4096 x float> zeroinitializer, ptr %3454, align 4
  %3455 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3456 = getelementptr float, ptr %3455, i64 7024640
  store <4096 x float> zeroinitializer, ptr %3456, align 4
  %3457 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3458 = getelementptr float, ptr %3457, i64 7028736
  store <4096 x float> zeroinitializer, ptr %3458, align 4
  %3459 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3460 = getelementptr float, ptr %3459, i64 7032832
  store <4096 x float> zeroinitializer, ptr %3460, align 4
  %3461 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3462 = getelementptr float, ptr %3461, i64 7036928
  store <4096 x float> zeroinitializer, ptr %3462, align 4
  %3463 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3464 = getelementptr float, ptr %3463, i64 7041024
  store <4096 x float> zeroinitializer, ptr %3464, align 4
  %3465 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3466 = getelementptr float, ptr %3465, i64 7045120
  store <4096 x float> zeroinitializer, ptr %3466, align 4
  %3467 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3468 = getelementptr float, ptr %3467, i64 7049216
  store <4096 x float> zeroinitializer, ptr %3468, align 4
  %3469 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3470 = getelementptr float, ptr %3469, i64 7053312
  store <4096 x float> zeroinitializer, ptr %3470, align 4
  %3471 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3472 = getelementptr float, ptr %3471, i64 7057408
  store <4096 x float> zeroinitializer, ptr %3472, align 4
  %3473 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3474 = getelementptr float, ptr %3473, i64 7061504
  store <4096 x float> zeroinitializer, ptr %3474, align 4
  %3475 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3476 = getelementptr float, ptr %3475, i64 7065600
  store <4096 x float> zeroinitializer, ptr %3476, align 4
  %3477 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3478 = getelementptr float, ptr %3477, i64 7069696
  store <4096 x float> zeroinitializer, ptr %3478, align 4
  %3479 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3480 = getelementptr float, ptr %3479, i64 7073792
  store <4096 x float> zeroinitializer, ptr %3480, align 4
  %3481 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3482 = getelementptr float, ptr %3481, i64 7077888
  store <4096 x float> zeroinitializer, ptr %3482, align 4
  %3483 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3484 = getelementptr float, ptr %3483, i64 7081984
  store <4096 x float> zeroinitializer, ptr %3484, align 4
  %3485 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3486 = getelementptr float, ptr %3485, i64 7086080
  store <4096 x float> zeroinitializer, ptr %3486, align 4
  %3487 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3488 = getelementptr float, ptr %3487, i64 7090176
  store <4096 x float> zeroinitializer, ptr %3488, align 4
  %3489 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3490 = getelementptr float, ptr %3489, i64 7094272
  store <4096 x float> zeroinitializer, ptr %3490, align 4
  %3491 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3492 = getelementptr float, ptr %3491, i64 7098368
  store <4096 x float> zeroinitializer, ptr %3492, align 4
  %3493 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3494 = getelementptr float, ptr %3493, i64 7102464
  store <4096 x float> zeroinitializer, ptr %3494, align 4
  %3495 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3496 = getelementptr float, ptr %3495, i64 7106560
  store <4096 x float> zeroinitializer, ptr %3496, align 4
  %3497 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3498 = getelementptr float, ptr %3497, i64 7110656
  store <4096 x float> zeroinitializer, ptr %3498, align 4
  %3499 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3500 = getelementptr float, ptr %3499, i64 7114752
  store <4096 x float> zeroinitializer, ptr %3500, align 4
  %3501 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3502 = getelementptr float, ptr %3501, i64 7118848
  store <4096 x float> zeroinitializer, ptr %3502, align 4
  %3503 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3504 = getelementptr float, ptr %3503, i64 7122944
  store <4096 x float> zeroinitializer, ptr %3504, align 4
  %3505 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3506 = getelementptr float, ptr %3505, i64 7127040
  store <4096 x float> zeroinitializer, ptr %3506, align 4
  %3507 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3508 = getelementptr float, ptr %3507, i64 7131136
  store <4096 x float> zeroinitializer, ptr %3508, align 4
  %3509 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3510 = getelementptr float, ptr %3509, i64 7135232
  store <4096 x float> zeroinitializer, ptr %3510, align 4
  %3511 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3512 = getelementptr float, ptr %3511, i64 7139328
  store <4096 x float> zeroinitializer, ptr %3512, align 4
  %3513 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3514 = getelementptr float, ptr %3513, i64 7143424
  store <4096 x float> zeroinitializer, ptr %3514, align 4
  %3515 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3516 = getelementptr float, ptr %3515, i64 7147520
  store <4096 x float> zeroinitializer, ptr %3516, align 4
  %3517 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3518 = getelementptr float, ptr %3517, i64 7151616
  store <4096 x float> zeroinitializer, ptr %3518, align 4
  %3519 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3520 = getelementptr float, ptr %3519, i64 7155712
  store <4096 x float> zeroinitializer, ptr %3520, align 4
  %3521 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3522 = getelementptr float, ptr %3521, i64 7159808
  store <4096 x float> zeroinitializer, ptr %3522, align 4
  %3523 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3524 = getelementptr float, ptr %3523, i64 7163904
  store <4096 x float> zeroinitializer, ptr %3524, align 4
  %3525 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3526 = getelementptr float, ptr %3525, i64 7168000
  store <4096 x float> zeroinitializer, ptr %3526, align 4
  %3527 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3528 = getelementptr float, ptr %3527, i64 7172096
  store <4096 x float> zeroinitializer, ptr %3528, align 4
  %3529 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3530 = getelementptr float, ptr %3529, i64 7176192
  store <4096 x float> zeroinitializer, ptr %3530, align 4
  %3531 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3532 = getelementptr float, ptr %3531, i64 7180288
  store <4096 x float> zeroinitializer, ptr %3532, align 4
  %3533 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3534 = getelementptr float, ptr %3533, i64 7184384
  store <4096 x float> zeroinitializer, ptr %3534, align 4
  %3535 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3536 = getelementptr float, ptr %3535, i64 7188480
  store <4096 x float> zeroinitializer, ptr %3536, align 4
  %3537 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3538 = getelementptr float, ptr %3537, i64 7192576
  store <4096 x float> zeroinitializer, ptr %3538, align 4
  %3539 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3540 = getelementptr float, ptr %3539, i64 7196672
  store <4096 x float> zeroinitializer, ptr %3540, align 4
  %3541 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3542 = getelementptr float, ptr %3541, i64 7200768
  store <4096 x float> zeroinitializer, ptr %3542, align 4
  %3543 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3544 = getelementptr float, ptr %3543, i64 7204864
  store <4096 x float> zeroinitializer, ptr %3544, align 4
  %3545 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3546 = getelementptr float, ptr %3545, i64 7208960
  store <4096 x float> zeroinitializer, ptr %3546, align 4
  %3547 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3548 = getelementptr float, ptr %3547, i64 7213056
  store <4096 x float> zeroinitializer, ptr %3548, align 4
  %3549 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3550 = getelementptr float, ptr %3549, i64 7217152
  store <4096 x float> zeroinitializer, ptr %3550, align 4
  %3551 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3552 = getelementptr float, ptr %3551, i64 7221248
  store <4096 x float> zeroinitializer, ptr %3552, align 4
  %3553 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3554 = getelementptr float, ptr %3553, i64 7225344
  store <4096 x float> zeroinitializer, ptr %3554, align 4
  %3555 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3556 = getelementptr float, ptr %3555, i64 7229440
  store <4096 x float> zeroinitializer, ptr %3556, align 4
  %3557 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3558 = getelementptr float, ptr %3557, i64 7233536
  store <4096 x float> zeroinitializer, ptr %3558, align 4
  %3559 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3560 = getelementptr float, ptr %3559, i64 7237632
  store <4096 x float> zeroinitializer, ptr %3560, align 4
  %3561 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3562 = getelementptr float, ptr %3561, i64 7241728
  store <4096 x float> zeroinitializer, ptr %3562, align 4
  %3563 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3564 = getelementptr float, ptr %3563, i64 7245824
  store <4096 x float> zeroinitializer, ptr %3564, align 4
  %3565 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3566 = getelementptr float, ptr %3565, i64 7249920
  store <4096 x float> zeroinitializer, ptr %3566, align 4
  %3567 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3568 = getelementptr float, ptr %3567, i64 7254016
  store <4096 x float> zeroinitializer, ptr %3568, align 4
  %3569 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3570 = getelementptr float, ptr %3569, i64 7258112
  store <4096 x float> zeroinitializer, ptr %3570, align 4
  %3571 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3572 = getelementptr float, ptr %3571, i64 7262208
  store <4096 x float> zeroinitializer, ptr %3572, align 4
  %3573 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3574 = getelementptr float, ptr %3573, i64 7266304
  store <4096 x float> zeroinitializer, ptr %3574, align 4
  %3575 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3576 = getelementptr float, ptr %3575, i64 7270400
  store <4096 x float> zeroinitializer, ptr %3576, align 4
  %3577 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3578 = getelementptr float, ptr %3577, i64 7274496
  store <4096 x float> zeroinitializer, ptr %3578, align 4
  %3579 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3580 = getelementptr float, ptr %3579, i64 7278592
  store <4096 x float> zeroinitializer, ptr %3580, align 4
  %3581 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3582 = getelementptr float, ptr %3581, i64 7282688
  store <4096 x float> zeroinitializer, ptr %3582, align 4
  %3583 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3584 = getelementptr float, ptr %3583, i64 7286784
  store <4096 x float> zeroinitializer, ptr %3584, align 4
  %3585 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3586 = getelementptr float, ptr %3585, i64 7290880
  store <4096 x float> zeroinitializer, ptr %3586, align 4
  %3587 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3588 = getelementptr float, ptr %3587, i64 7294976
  store <4096 x float> zeroinitializer, ptr %3588, align 4
  %3589 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3590 = getelementptr float, ptr %3589, i64 7299072
  store <4096 x float> zeroinitializer, ptr %3590, align 4
  %3591 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3592 = getelementptr float, ptr %3591, i64 7303168
  store <4096 x float> zeroinitializer, ptr %3592, align 4
  %3593 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3594 = getelementptr float, ptr %3593, i64 7307264
  store <4096 x float> zeroinitializer, ptr %3594, align 4
  %3595 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3596 = getelementptr float, ptr %3595, i64 7311360
  store <4096 x float> zeroinitializer, ptr %3596, align 4
  %3597 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3598 = getelementptr float, ptr %3597, i64 7315456
  store <4096 x float> zeroinitializer, ptr %3598, align 4
  %3599 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3600 = getelementptr float, ptr %3599, i64 7319552
  store <4096 x float> zeroinitializer, ptr %3600, align 4
  %3601 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3602 = getelementptr float, ptr %3601, i64 7323648
  store <4096 x float> zeroinitializer, ptr %3602, align 4
  %3603 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3604 = getelementptr float, ptr %3603, i64 7327744
  store <4096 x float> zeroinitializer, ptr %3604, align 4
  %3605 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3606 = getelementptr float, ptr %3605, i64 7331840
  store <4096 x float> zeroinitializer, ptr %3606, align 4
  %3607 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3608 = getelementptr float, ptr %3607, i64 7335936
  store <4096 x float> zeroinitializer, ptr %3608, align 4
  %3609 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3610 = getelementptr float, ptr %3609, i64 7340032
  store <4096 x float> zeroinitializer, ptr %3610, align 4
  %3611 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3612 = getelementptr float, ptr %3611, i64 7344128
  store <4096 x float> zeroinitializer, ptr %3612, align 4
  %3613 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3614 = getelementptr float, ptr %3613, i64 7348224
  store <4096 x float> zeroinitializer, ptr %3614, align 4
  %3615 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3616 = getelementptr float, ptr %3615, i64 7352320
  store <4096 x float> zeroinitializer, ptr %3616, align 4
  %3617 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3618 = getelementptr float, ptr %3617, i64 7356416
  store <4096 x float> zeroinitializer, ptr %3618, align 4
  %3619 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3620 = getelementptr float, ptr %3619, i64 7360512
  store <4096 x float> zeroinitializer, ptr %3620, align 4
  %3621 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3622 = getelementptr float, ptr %3621, i64 7364608
  store <4096 x float> zeroinitializer, ptr %3622, align 4
  %3623 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3624 = getelementptr float, ptr %3623, i64 7368704
  store <4096 x float> zeroinitializer, ptr %3624, align 4
  %3625 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3626 = getelementptr float, ptr %3625, i64 7372800
  store <4096 x float> zeroinitializer, ptr %3626, align 4
  %3627 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3628 = getelementptr float, ptr %3627, i64 7376896
  store <4096 x float> zeroinitializer, ptr %3628, align 4
  %3629 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3630 = getelementptr float, ptr %3629, i64 7380992
  store <4096 x float> zeroinitializer, ptr %3630, align 4
  %3631 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3632 = getelementptr float, ptr %3631, i64 7385088
  store <4096 x float> zeroinitializer, ptr %3632, align 4
  %3633 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3634 = getelementptr float, ptr %3633, i64 7389184
  store <4096 x float> zeroinitializer, ptr %3634, align 4
  %3635 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3636 = getelementptr float, ptr %3635, i64 7393280
  store <4096 x float> zeroinitializer, ptr %3636, align 4
  %3637 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3638 = getelementptr float, ptr %3637, i64 7397376
  store <4096 x float> zeroinitializer, ptr %3638, align 4
  %3639 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3640 = getelementptr float, ptr %3639, i64 7401472
  store <4096 x float> zeroinitializer, ptr %3640, align 4
  %3641 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3642 = getelementptr float, ptr %3641, i64 7405568
  store <4096 x float> zeroinitializer, ptr %3642, align 4
  %3643 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3644 = getelementptr float, ptr %3643, i64 7409664
  store <4096 x float> zeroinitializer, ptr %3644, align 4
  %3645 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3646 = getelementptr float, ptr %3645, i64 7413760
  store <4096 x float> zeroinitializer, ptr %3646, align 4
  %3647 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3648 = getelementptr float, ptr %3647, i64 7417856
  store <4096 x float> zeroinitializer, ptr %3648, align 4
  %3649 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3650 = getelementptr float, ptr %3649, i64 7421952
  store <4096 x float> zeroinitializer, ptr %3650, align 4
  %3651 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3652 = getelementptr float, ptr %3651, i64 7426048
  store <4096 x float> zeroinitializer, ptr %3652, align 4
  %3653 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3654 = getelementptr float, ptr %3653, i64 7430144
  store <4096 x float> zeroinitializer, ptr %3654, align 4
  %3655 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3656 = getelementptr float, ptr %3655, i64 7434240
  store <4096 x float> zeroinitializer, ptr %3656, align 4
  %3657 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3658 = getelementptr float, ptr %3657, i64 7438336
  store <4096 x float> zeroinitializer, ptr %3658, align 4
  %3659 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3660 = getelementptr float, ptr %3659, i64 7442432
  store <4096 x float> zeroinitializer, ptr %3660, align 4
  %3661 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3662 = getelementptr float, ptr %3661, i64 7446528
  store <4096 x float> zeroinitializer, ptr %3662, align 4
  %3663 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3664 = getelementptr float, ptr %3663, i64 7450624
  store <4096 x float> zeroinitializer, ptr %3664, align 4
  %3665 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3666 = getelementptr float, ptr %3665, i64 7454720
  store <4096 x float> zeroinitializer, ptr %3666, align 4
  %3667 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3668 = getelementptr float, ptr %3667, i64 7458816
  store <4096 x float> zeroinitializer, ptr %3668, align 4
  %3669 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3670 = getelementptr float, ptr %3669, i64 7462912
  store <4096 x float> zeroinitializer, ptr %3670, align 4
  %3671 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3672 = getelementptr float, ptr %3671, i64 7467008
  store <4096 x float> zeroinitializer, ptr %3672, align 4
  %3673 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3674 = getelementptr float, ptr %3673, i64 7471104
  store <4096 x float> zeroinitializer, ptr %3674, align 4
  %3675 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3676 = getelementptr float, ptr %3675, i64 7475200
  store <4096 x float> zeroinitializer, ptr %3676, align 4
  %3677 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3678 = getelementptr float, ptr %3677, i64 7479296
  store <4096 x float> zeroinitializer, ptr %3678, align 4
  %3679 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3680 = getelementptr float, ptr %3679, i64 7483392
  store <4096 x float> zeroinitializer, ptr %3680, align 4
  %3681 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3682 = getelementptr float, ptr %3681, i64 7487488
  store <4096 x float> zeroinitializer, ptr %3682, align 4
  %3683 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3684 = getelementptr float, ptr %3683, i64 7491584
  store <4096 x float> zeroinitializer, ptr %3684, align 4
  %3685 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3686 = getelementptr float, ptr %3685, i64 7495680
  store <4096 x float> zeroinitializer, ptr %3686, align 4
  %3687 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3688 = getelementptr float, ptr %3687, i64 7499776
  store <4096 x float> zeroinitializer, ptr %3688, align 4
  %3689 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3690 = getelementptr float, ptr %3689, i64 7503872
  store <4096 x float> zeroinitializer, ptr %3690, align 4
  %3691 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3692 = getelementptr float, ptr %3691, i64 7507968
  store <4096 x float> zeroinitializer, ptr %3692, align 4
  %3693 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3694 = getelementptr float, ptr %3693, i64 7512064
  store <4096 x float> zeroinitializer, ptr %3694, align 4
  %3695 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3696 = getelementptr float, ptr %3695, i64 7516160
  store <4096 x float> zeroinitializer, ptr %3696, align 4
  %3697 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3698 = getelementptr float, ptr %3697, i64 7520256
  store <4096 x float> zeroinitializer, ptr %3698, align 4
  %3699 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3700 = getelementptr float, ptr %3699, i64 7524352
  store <4096 x float> zeroinitializer, ptr %3700, align 4
  %3701 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3702 = getelementptr float, ptr %3701, i64 7528448
  store <4096 x float> zeroinitializer, ptr %3702, align 4
  %3703 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3704 = getelementptr float, ptr %3703, i64 7532544
  store <4096 x float> zeroinitializer, ptr %3704, align 4
  %3705 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3706 = getelementptr float, ptr %3705, i64 7536640
  store <4096 x float> zeroinitializer, ptr %3706, align 4
  %3707 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3708 = getelementptr float, ptr %3707, i64 7540736
  store <4096 x float> zeroinitializer, ptr %3708, align 4
  %3709 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3710 = getelementptr float, ptr %3709, i64 7544832
  store <4096 x float> zeroinitializer, ptr %3710, align 4
  %3711 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3712 = getelementptr float, ptr %3711, i64 7548928
  store <4096 x float> zeroinitializer, ptr %3712, align 4
  %3713 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3714 = getelementptr float, ptr %3713, i64 7553024
  store <4096 x float> zeroinitializer, ptr %3714, align 4
  %3715 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3716 = getelementptr float, ptr %3715, i64 7557120
  store <4096 x float> zeroinitializer, ptr %3716, align 4
  %3717 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3718 = getelementptr float, ptr %3717, i64 7561216
  store <4096 x float> zeroinitializer, ptr %3718, align 4
  %3719 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3720 = getelementptr float, ptr %3719, i64 7565312
  store <4096 x float> zeroinitializer, ptr %3720, align 4
  %3721 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3722 = getelementptr float, ptr %3721, i64 7569408
  store <4096 x float> zeroinitializer, ptr %3722, align 4
  %3723 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3724 = getelementptr float, ptr %3723, i64 7573504
  store <4096 x float> zeroinitializer, ptr %3724, align 4
  %3725 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3726 = getelementptr float, ptr %3725, i64 7577600
  store <4096 x float> zeroinitializer, ptr %3726, align 4
  %3727 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3728 = getelementptr float, ptr %3727, i64 7581696
  store <4096 x float> zeroinitializer, ptr %3728, align 4
  %3729 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3730 = getelementptr float, ptr %3729, i64 7585792
  store <4096 x float> zeroinitializer, ptr %3730, align 4
  %3731 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3732 = getelementptr float, ptr %3731, i64 7589888
  store <4096 x float> zeroinitializer, ptr %3732, align 4
  %3733 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3734 = getelementptr float, ptr %3733, i64 7593984
  store <4096 x float> zeroinitializer, ptr %3734, align 4
  %3735 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3736 = getelementptr float, ptr %3735, i64 7598080
  store <4096 x float> zeroinitializer, ptr %3736, align 4
  %3737 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3738 = getelementptr float, ptr %3737, i64 7602176
  store <4096 x float> zeroinitializer, ptr %3738, align 4
  %3739 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3740 = getelementptr float, ptr %3739, i64 7606272
  store <4096 x float> zeroinitializer, ptr %3740, align 4
  %3741 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3742 = getelementptr float, ptr %3741, i64 7610368
  store <4096 x float> zeroinitializer, ptr %3742, align 4
  %3743 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3744 = getelementptr float, ptr %3743, i64 7614464
  store <4096 x float> zeroinitializer, ptr %3744, align 4
  %3745 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3746 = getelementptr float, ptr %3745, i64 7618560
  store <4096 x float> zeroinitializer, ptr %3746, align 4
  %3747 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3748 = getelementptr float, ptr %3747, i64 7622656
  store <4096 x float> zeroinitializer, ptr %3748, align 4
  %3749 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3750 = getelementptr float, ptr %3749, i64 7626752
  store <4096 x float> zeroinitializer, ptr %3750, align 4
  %3751 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3752 = getelementptr float, ptr %3751, i64 7630848
  store <4096 x float> zeroinitializer, ptr %3752, align 4
  %3753 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3754 = getelementptr float, ptr %3753, i64 7634944
  store <4096 x float> zeroinitializer, ptr %3754, align 4
  %3755 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3756 = getelementptr float, ptr %3755, i64 7639040
  store <4096 x float> zeroinitializer, ptr %3756, align 4
  %3757 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3758 = getelementptr float, ptr %3757, i64 7643136
  store <4096 x float> zeroinitializer, ptr %3758, align 4
  %3759 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3760 = getelementptr float, ptr %3759, i64 7647232
  store <4096 x float> zeroinitializer, ptr %3760, align 4
  %3761 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3762 = getelementptr float, ptr %3761, i64 7651328
  store <4096 x float> zeroinitializer, ptr %3762, align 4
  %3763 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3764 = getelementptr float, ptr %3763, i64 7655424
  store <4096 x float> zeroinitializer, ptr %3764, align 4
  %3765 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3766 = getelementptr float, ptr %3765, i64 7659520
  store <4096 x float> zeroinitializer, ptr %3766, align 4
  %3767 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3768 = getelementptr float, ptr %3767, i64 7663616
  store <4096 x float> zeroinitializer, ptr %3768, align 4
  %3769 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3770 = getelementptr float, ptr %3769, i64 7667712
  store <4096 x float> zeroinitializer, ptr %3770, align 4
  %3771 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3772 = getelementptr float, ptr %3771, i64 7671808
  store <4096 x float> zeroinitializer, ptr %3772, align 4
  %3773 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3774 = getelementptr float, ptr %3773, i64 7675904
  store <4096 x float> zeroinitializer, ptr %3774, align 4
  %3775 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3776 = getelementptr float, ptr %3775, i64 7680000
  store <4096 x float> zeroinitializer, ptr %3776, align 4
  %3777 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3778 = getelementptr float, ptr %3777, i64 7684096
  store <4096 x float> zeroinitializer, ptr %3778, align 4
  %3779 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3780 = getelementptr float, ptr %3779, i64 7688192
  store <4096 x float> zeroinitializer, ptr %3780, align 4
  %3781 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3782 = getelementptr float, ptr %3781, i64 7692288
  store <4096 x float> zeroinitializer, ptr %3782, align 4
  %3783 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3784 = getelementptr float, ptr %3783, i64 7696384
  store <4096 x float> zeroinitializer, ptr %3784, align 4
  %3785 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3786 = getelementptr float, ptr %3785, i64 7700480
  store <4096 x float> zeroinitializer, ptr %3786, align 4
  %3787 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3788 = getelementptr float, ptr %3787, i64 7704576
  store <4096 x float> zeroinitializer, ptr %3788, align 4
  %3789 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3790 = getelementptr float, ptr %3789, i64 7708672
  store <4096 x float> zeroinitializer, ptr %3790, align 4
  %3791 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3792 = getelementptr float, ptr %3791, i64 7712768
  store <4096 x float> zeroinitializer, ptr %3792, align 4
  %3793 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3794 = getelementptr float, ptr %3793, i64 7716864
  store <4096 x float> zeroinitializer, ptr %3794, align 4
  %3795 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3796 = getelementptr float, ptr %3795, i64 7720960
  store <4096 x float> zeroinitializer, ptr %3796, align 4
  %3797 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3798 = getelementptr float, ptr %3797, i64 7725056
  store <4096 x float> zeroinitializer, ptr %3798, align 4
  %3799 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3800 = getelementptr float, ptr %3799, i64 7729152
  store <4096 x float> zeroinitializer, ptr %3800, align 4
  %3801 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3802 = getelementptr float, ptr %3801, i64 7733248
  store <4096 x float> zeroinitializer, ptr %3802, align 4
  %3803 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3804 = getelementptr float, ptr %3803, i64 7737344
  store <4096 x float> zeroinitializer, ptr %3804, align 4
  %3805 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3806 = getelementptr float, ptr %3805, i64 7741440
  store <4096 x float> zeroinitializer, ptr %3806, align 4
  %3807 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3808 = getelementptr float, ptr %3807, i64 7745536
  store <4096 x float> zeroinitializer, ptr %3808, align 4
  %3809 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3810 = getelementptr float, ptr %3809, i64 7749632
  store <4096 x float> zeroinitializer, ptr %3810, align 4
  %3811 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3812 = getelementptr float, ptr %3811, i64 7753728
  store <4096 x float> zeroinitializer, ptr %3812, align 4
  %3813 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3814 = getelementptr float, ptr %3813, i64 7757824
  store <4096 x float> zeroinitializer, ptr %3814, align 4
  %3815 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3816 = getelementptr float, ptr %3815, i64 7761920
  store <4096 x float> zeroinitializer, ptr %3816, align 4
  %3817 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3818 = getelementptr float, ptr %3817, i64 7766016
  store <4096 x float> zeroinitializer, ptr %3818, align 4
  %3819 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3820 = getelementptr float, ptr %3819, i64 7770112
  store <4096 x float> zeroinitializer, ptr %3820, align 4
  %3821 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3822 = getelementptr float, ptr %3821, i64 7774208
  store <4096 x float> zeroinitializer, ptr %3822, align 4
  %3823 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3824 = getelementptr float, ptr %3823, i64 7778304
  store <4096 x float> zeroinitializer, ptr %3824, align 4
  %3825 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3826 = getelementptr float, ptr %3825, i64 7782400
  store <4096 x float> zeroinitializer, ptr %3826, align 4
  %3827 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3828 = getelementptr float, ptr %3827, i64 7786496
  store <4096 x float> zeroinitializer, ptr %3828, align 4
  %3829 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3830 = getelementptr float, ptr %3829, i64 7790592
  store <4096 x float> zeroinitializer, ptr %3830, align 4
  %3831 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3832 = getelementptr float, ptr %3831, i64 7794688
  store <4096 x float> zeroinitializer, ptr %3832, align 4
  %3833 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3834 = getelementptr float, ptr %3833, i64 7798784
  store <4096 x float> zeroinitializer, ptr %3834, align 4
  %3835 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3836 = getelementptr float, ptr %3835, i64 7802880
  store <4096 x float> zeroinitializer, ptr %3836, align 4
  %3837 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3838 = getelementptr float, ptr %3837, i64 7806976
  store <4096 x float> zeroinitializer, ptr %3838, align 4
  %3839 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3840 = getelementptr float, ptr %3839, i64 7811072
  store <4096 x float> zeroinitializer, ptr %3840, align 4
  %3841 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3842 = getelementptr float, ptr %3841, i64 7815168
  store <4096 x float> zeroinitializer, ptr %3842, align 4
  %3843 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3844 = getelementptr float, ptr %3843, i64 7819264
  store <4096 x float> zeroinitializer, ptr %3844, align 4
  %3845 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3846 = getelementptr float, ptr %3845, i64 7823360
  store <4096 x float> zeroinitializer, ptr %3846, align 4
  %3847 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3848 = getelementptr float, ptr %3847, i64 7827456
  store <4096 x float> zeroinitializer, ptr %3848, align 4
  %3849 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3850 = getelementptr float, ptr %3849, i64 7831552
  store <4096 x float> zeroinitializer, ptr %3850, align 4
  %3851 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3852 = getelementptr float, ptr %3851, i64 7835648
  store <4096 x float> zeroinitializer, ptr %3852, align 4
  %3853 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3854 = getelementptr float, ptr %3853, i64 7839744
  store <4096 x float> zeroinitializer, ptr %3854, align 4
  %3855 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3856 = getelementptr float, ptr %3855, i64 7843840
  store <4096 x float> zeroinitializer, ptr %3856, align 4
  %3857 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3858 = getelementptr float, ptr %3857, i64 7847936
  store <4096 x float> zeroinitializer, ptr %3858, align 4
  %3859 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3860 = getelementptr float, ptr %3859, i64 7852032
  store <4096 x float> zeroinitializer, ptr %3860, align 4
  %3861 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3862 = getelementptr float, ptr %3861, i64 7856128
  store <4096 x float> zeroinitializer, ptr %3862, align 4
  %3863 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3864 = getelementptr float, ptr %3863, i64 7860224
  store <4096 x float> zeroinitializer, ptr %3864, align 4
  %3865 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3866 = getelementptr float, ptr %3865, i64 7864320
  store <4096 x float> zeroinitializer, ptr %3866, align 4
  %3867 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3868 = getelementptr float, ptr %3867, i64 7868416
  store <4096 x float> zeroinitializer, ptr %3868, align 4
  %3869 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3870 = getelementptr float, ptr %3869, i64 7872512
  store <4096 x float> zeroinitializer, ptr %3870, align 4
  %3871 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3872 = getelementptr float, ptr %3871, i64 7876608
  store <4096 x float> zeroinitializer, ptr %3872, align 4
  %3873 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3874 = getelementptr float, ptr %3873, i64 7880704
  store <4096 x float> zeroinitializer, ptr %3874, align 4
  %3875 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3876 = getelementptr float, ptr %3875, i64 7884800
  store <4096 x float> zeroinitializer, ptr %3876, align 4
  %3877 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3878 = getelementptr float, ptr %3877, i64 7888896
  store <4096 x float> zeroinitializer, ptr %3878, align 4
  %3879 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3880 = getelementptr float, ptr %3879, i64 7892992
  store <4096 x float> zeroinitializer, ptr %3880, align 4
  %3881 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3882 = getelementptr float, ptr %3881, i64 7897088
  store <4096 x float> zeroinitializer, ptr %3882, align 4
  %3883 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3884 = getelementptr float, ptr %3883, i64 7901184
  store <4096 x float> zeroinitializer, ptr %3884, align 4
  %3885 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3886 = getelementptr float, ptr %3885, i64 7905280
  store <4096 x float> zeroinitializer, ptr %3886, align 4
  %3887 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3888 = getelementptr float, ptr %3887, i64 7909376
  store <4096 x float> zeroinitializer, ptr %3888, align 4
  %3889 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3890 = getelementptr float, ptr %3889, i64 7913472
  store <4096 x float> zeroinitializer, ptr %3890, align 4
  %3891 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3892 = getelementptr float, ptr %3891, i64 7917568
  store <4096 x float> zeroinitializer, ptr %3892, align 4
  %3893 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3894 = getelementptr float, ptr %3893, i64 7921664
  store <4096 x float> zeroinitializer, ptr %3894, align 4
  %3895 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3896 = getelementptr float, ptr %3895, i64 7925760
  store <4096 x float> zeroinitializer, ptr %3896, align 4
  %3897 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3898 = getelementptr float, ptr %3897, i64 7929856
  store <4096 x float> zeroinitializer, ptr %3898, align 4
  %3899 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3900 = getelementptr float, ptr %3899, i64 7933952
  store <4096 x float> zeroinitializer, ptr %3900, align 4
  %3901 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3902 = getelementptr float, ptr %3901, i64 7938048
  store <4096 x float> zeroinitializer, ptr %3902, align 4
  %3903 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3904 = getelementptr float, ptr %3903, i64 7942144
  store <4096 x float> zeroinitializer, ptr %3904, align 4
  %3905 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3906 = getelementptr float, ptr %3905, i64 7946240
  store <4096 x float> zeroinitializer, ptr %3906, align 4
  %3907 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3908 = getelementptr float, ptr %3907, i64 7950336
  store <4096 x float> zeroinitializer, ptr %3908, align 4
  %3909 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3910 = getelementptr float, ptr %3909, i64 7954432
  store <4096 x float> zeroinitializer, ptr %3910, align 4
  %3911 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3912 = getelementptr float, ptr %3911, i64 7958528
  store <4096 x float> zeroinitializer, ptr %3912, align 4
  %3913 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3914 = getelementptr float, ptr %3913, i64 7962624
  store <4096 x float> zeroinitializer, ptr %3914, align 4
  %3915 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3916 = getelementptr float, ptr %3915, i64 7966720
  store <4096 x float> zeroinitializer, ptr %3916, align 4
  %3917 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3918 = getelementptr float, ptr %3917, i64 7970816
  store <4096 x float> zeroinitializer, ptr %3918, align 4
  %3919 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3920 = getelementptr float, ptr %3919, i64 7974912
  store <4096 x float> zeroinitializer, ptr %3920, align 4
  %3921 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3922 = getelementptr float, ptr %3921, i64 7979008
  store <4096 x float> zeroinitializer, ptr %3922, align 4
  %3923 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3924 = getelementptr float, ptr %3923, i64 7983104
  store <4096 x float> zeroinitializer, ptr %3924, align 4
  %3925 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3926 = getelementptr float, ptr %3925, i64 7987200
  store <4096 x float> zeroinitializer, ptr %3926, align 4
  %3927 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3928 = getelementptr float, ptr %3927, i64 7991296
  store <4096 x float> zeroinitializer, ptr %3928, align 4
  %3929 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3930 = getelementptr float, ptr %3929, i64 7995392
  store <4096 x float> zeroinitializer, ptr %3930, align 4
  %3931 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3932 = getelementptr float, ptr %3931, i64 7999488
  store <4096 x float> zeroinitializer, ptr %3932, align 4
  %3933 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3934 = getelementptr float, ptr %3933, i64 8003584
  store <4096 x float> zeroinitializer, ptr %3934, align 4
  %3935 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3936 = getelementptr float, ptr %3935, i64 8007680
  store <4096 x float> zeroinitializer, ptr %3936, align 4
  %3937 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3938 = getelementptr float, ptr %3937, i64 8011776
  store <4096 x float> zeroinitializer, ptr %3938, align 4
  %3939 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3940 = getelementptr float, ptr %3939, i64 8015872
  store <4096 x float> zeroinitializer, ptr %3940, align 4
  %3941 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3942 = getelementptr float, ptr %3941, i64 8019968
  store <4096 x float> zeroinitializer, ptr %3942, align 4
  %3943 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3944 = getelementptr float, ptr %3943, i64 8024064
  store <4096 x float> zeroinitializer, ptr %3944, align 4
  %3945 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3946 = getelementptr float, ptr %3945, i64 8028160
  store <4096 x float> zeroinitializer, ptr %3946, align 4
  %3947 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3948 = getelementptr float, ptr %3947, i64 8032256
  store <4096 x float> zeroinitializer, ptr %3948, align 4
  %3949 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3950 = getelementptr float, ptr %3949, i64 8036352
  store <4096 x float> zeroinitializer, ptr %3950, align 4
  %3951 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3952 = getelementptr float, ptr %3951, i64 8040448
  store <4096 x float> zeroinitializer, ptr %3952, align 4
  %3953 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3954 = getelementptr float, ptr %3953, i64 8044544
  store <4096 x float> zeroinitializer, ptr %3954, align 4
  %3955 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3956 = getelementptr float, ptr %3955, i64 8048640
  store <4096 x float> zeroinitializer, ptr %3956, align 4
  %3957 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3958 = getelementptr float, ptr %3957, i64 8052736
  store <4096 x float> zeroinitializer, ptr %3958, align 4
  %3959 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3960 = getelementptr float, ptr %3959, i64 8056832
  store <4096 x float> zeroinitializer, ptr %3960, align 4
  %3961 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3962 = getelementptr float, ptr %3961, i64 8060928
  store <4096 x float> zeroinitializer, ptr %3962, align 4
  %3963 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3964 = getelementptr float, ptr %3963, i64 8065024
  store <4096 x float> zeroinitializer, ptr %3964, align 4
  %3965 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3966 = getelementptr float, ptr %3965, i64 8069120
  store <4096 x float> zeroinitializer, ptr %3966, align 4
  %3967 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3968 = getelementptr float, ptr %3967, i64 8073216
  store <4096 x float> zeroinitializer, ptr %3968, align 4
  %3969 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3970 = getelementptr float, ptr %3969, i64 8077312
  store <4096 x float> zeroinitializer, ptr %3970, align 4
  %3971 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3972 = getelementptr float, ptr %3971, i64 8081408
  store <4096 x float> zeroinitializer, ptr %3972, align 4
  %3973 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3974 = getelementptr float, ptr %3973, i64 8085504
  store <4096 x float> zeroinitializer, ptr %3974, align 4
  %3975 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3976 = getelementptr float, ptr %3975, i64 8089600
  store <4096 x float> zeroinitializer, ptr %3976, align 4
  %3977 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3978 = getelementptr float, ptr %3977, i64 8093696
  store <4096 x float> zeroinitializer, ptr %3978, align 4
  %3979 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3980 = getelementptr float, ptr %3979, i64 8097792
  store <4096 x float> zeroinitializer, ptr %3980, align 4
  %3981 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3982 = getelementptr float, ptr %3981, i64 8101888
  store <4096 x float> zeroinitializer, ptr %3982, align 4
  %3983 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3984 = getelementptr float, ptr %3983, i64 8105984
  store <4096 x float> zeroinitializer, ptr %3984, align 4
  %3985 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3986 = getelementptr float, ptr %3985, i64 8110080
  store <4096 x float> zeroinitializer, ptr %3986, align 4
  %3987 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3988 = getelementptr float, ptr %3987, i64 8114176
  store <4096 x float> zeroinitializer, ptr %3988, align 4
  %3989 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3990 = getelementptr float, ptr %3989, i64 8118272
  store <4096 x float> zeroinitializer, ptr %3990, align 4
  %3991 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3992 = getelementptr float, ptr %3991, i64 8122368
  store <4096 x float> zeroinitializer, ptr %3992, align 4
  %3993 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3994 = getelementptr float, ptr %3993, i64 8126464
  store <4096 x float> zeroinitializer, ptr %3994, align 4
  %3995 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3996 = getelementptr float, ptr %3995, i64 8130560
  store <4096 x float> zeroinitializer, ptr %3996, align 4
  %3997 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %3998 = getelementptr float, ptr %3997, i64 8134656
  store <4096 x float> zeroinitializer, ptr %3998, align 4
  %3999 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4000 = getelementptr float, ptr %3999, i64 8138752
  store <4096 x float> zeroinitializer, ptr %4000, align 4
  %4001 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4002 = getelementptr float, ptr %4001, i64 8142848
  store <4096 x float> zeroinitializer, ptr %4002, align 4
  %4003 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4004 = getelementptr float, ptr %4003, i64 8146944
  store <4096 x float> zeroinitializer, ptr %4004, align 4
  %4005 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4006 = getelementptr float, ptr %4005, i64 8151040
  store <4096 x float> zeroinitializer, ptr %4006, align 4
  %4007 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4008 = getelementptr float, ptr %4007, i64 8155136
  store <4096 x float> zeroinitializer, ptr %4008, align 4
  %4009 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4010 = getelementptr float, ptr %4009, i64 8159232
  store <4096 x float> zeroinitializer, ptr %4010, align 4
  %4011 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4012 = getelementptr float, ptr %4011, i64 8163328
  store <4096 x float> zeroinitializer, ptr %4012, align 4
  %4013 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4014 = getelementptr float, ptr %4013, i64 8167424
  store <4096 x float> zeroinitializer, ptr %4014, align 4
  %4015 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4016 = getelementptr float, ptr %4015, i64 8171520
  store <4096 x float> zeroinitializer, ptr %4016, align 4
  %4017 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4018 = getelementptr float, ptr %4017, i64 8175616
  store <4096 x float> zeroinitializer, ptr %4018, align 4
  %4019 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4020 = getelementptr float, ptr %4019, i64 8179712
  store <4096 x float> zeroinitializer, ptr %4020, align 4
  %4021 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4022 = getelementptr float, ptr %4021, i64 8183808
  store <4096 x float> zeroinitializer, ptr %4022, align 4
  %4023 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4024 = getelementptr float, ptr %4023, i64 8187904
  store <4096 x float> zeroinitializer, ptr %4024, align 4
  %4025 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4026 = getelementptr float, ptr %4025, i64 8192000
  store <4096 x float> zeroinitializer, ptr %4026, align 4
  %4027 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4028 = getelementptr float, ptr %4027, i64 8196096
  store <4096 x float> zeroinitializer, ptr %4028, align 4
  %4029 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4030 = getelementptr float, ptr %4029, i64 8200192
  store <4096 x float> zeroinitializer, ptr %4030, align 4
  %4031 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4032 = getelementptr float, ptr %4031, i64 8204288
  store <4096 x float> zeroinitializer, ptr %4032, align 4
  %4033 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4034 = getelementptr float, ptr %4033, i64 8208384
  store <4096 x float> zeroinitializer, ptr %4034, align 4
  %4035 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4036 = getelementptr float, ptr %4035, i64 8212480
  store <4096 x float> zeroinitializer, ptr %4036, align 4
  %4037 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4038 = getelementptr float, ptr %4037, i64 8216576
  store <4096 x float> zeroinitializer, ptr %4038, align 4
  %4039 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4040 = getelementptr float, ptr %4039, i64 8220672
  store <4096 x float> zeroinitializer, ptr %4040, align 4
  %4041 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4042 = getelementptr float, ptr %4041, i64 8224768
  store <4096 x float> zeroinitializer, ptr %4042, align 4
  %4043 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4044 = getelementptr float, ptr %4043, i64 8228864
  store <4096 x float> zeroinitializer, ptr %4044, align 4
  %4045 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4046 = getelementptr float, ptr %4045, i64 8232960
  store <4096 x float> zeroinitializer, ptr %4046, align 4
  %4047 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4048 = getelementptr float, ptr %4047, i64 8237056
  store <4096 x float> zeroinitializer, ptr %4048, align 4
  %4049 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4050 = getelementptr float, ptr %4049, i64 8241152
  store <4096 x float> zeroinitializer, ptr %4050, align 4
  %4051 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4052 = getelementptr float, ptr %4051, i64 8245248
  store <4096 x float> zeroinitializer, ptr %4052, align 4
  %4053 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4054 = getelementptr float, ptr %4053, i64 8249344
  store <4096 x float> zeroinitializer, ptr %4054, align 4
  %4055 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4056 = getelementptr float, ptr %4055, i64 8253440
  store <4096 x float> zeroinitializer, ptr %4056, align 4
  %4057 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4058 = getelementptr float, ptr %4057, i64 8257536
  store <4096 x float> zeroinitializer, ptr %4058, align 4
  %4059 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4060 = getelementptr float, ptr %4059, i64 8261632
  store <4096 x float> zeroinitializer, ptr %4060, align 4
  %4061 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4062 = getelementptr float, ptr %4061, i64 8265728
  store <4096 x float> zeroinitializer, ptr %4062, align 4
  %4063 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4064 = getelementptr float, ptr %4063, i64 8269824
  store <4096 x float> zeroinitializer, ptr %4064, align 4
  %4065 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4066 = getelementptr float, ptr %4065, i64 8273920
  store <4096 x float> zeroinitializer, ptr %4066, align 4
  %4067 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4068 = getelementptr float, ptr %4067, i64 8278016
  store <4096 x float> zeroinitializer, ptr %4068, align 4
  %4069 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4070 = getelementptr float, ptr %4069, i64 8282112
  store <4096 x float> zeroinitializer, ptr %4070, align 4
  %4071 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4072 = getelementptr float, ptr %4071, i64 8286208
  store <4096 x float> zeroinitializer, ptr %4072, align 4
  %4073 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4074 = getelementptr float, ptr %4073, i64 8290304
  store <4096 x float> zeroinitializer, ptr %4074, align 4
  %4075 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4076 = getelementptr float, ptr %4075, i64 8294400
  store <4096 x float> zeroinitializer, ptr %4076, align 4
  %4077 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4078 = getelementptr float, ptr %4077, i64 8298496
  store <4096 x float> zeroinitializer, ptr %4078, align 4
  %4079 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4080 = getelementptr float, ptr %4079, i64 8302592
  store <4096 x float> zeroinitializer, ptr %4080, align 4
  %4081 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4082 = getelementptr float, ptr %4081, i64 8306688
  store <4096 x float> zeroinitializer, ptr %4082, align 4
  %4083 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4084 = getelementptr float, ptr %4083, i64 8310784
  store <4096 x float> zeroinitializer, ptr %4084, align 4
  %4085 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4086 = getelementptr float, ptr %4085, i64 8314880
  store <4096 x float> zeroinitializer, ptr %4086, align 4
  %4087 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4088 = getelementptr float, ptr %4087, i64 8318976
  store <4096 x float> zeroinitializer, ptr %4088, align 4
  %4089 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4090 = getelementptr float, ptr %4089, i64 8323072
  store <4096 x float> zeroinitializer, ptr %4090, align 4
  %4091 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4092 = getelementptr float, ptr %4091, i64 8327168
  store <4096 x float> zeroinitializer, ptr %4092, align 4
  %4093 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4094 = getelementptr float, ptr %4093, i64 8331264
  store <4096 x float> zeroinitializer, ptr %4094, align 4
  %4095 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4096 = getelementptr float, ptr %4095, i64 8335360
  store <4096 x float> zeroinitializer, ptr %4096, align 4
  %4097 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4098 = getelementptr float, ptr %4097, i64 8339456
  store <4096 x float> zeroinitializer, ptr %4098, align 4
  %4099 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4100 = getelementptr float, ptr %4099, i64 8343552
  store <4096 x float> zeroinitializer, ptr %4100, align 4
  %4101 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4102 = getelementptr float, ptr %4101, i64 8347648
  store <4096 x float> zeroinitializer, ptr %4102, align 4
  %4103 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4104 = getelementptr float, ptr %4103, i64 8351744
  store <4096 x float> zeroinitializer, ptr %4104, align 4
  %4105 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4106 = getelementptr float, ptr %4105, i64 8355840
  store <4096 x float> zeroinitializer, ptr %4106, align 4
  %4107 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4108 = getelementptr float, ptr %4107, i64 8359936
  store <4096 x float> zeroinitializer, ptr %4108, align 4
  %4109 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4110 = getelementptr float, ptr %4109, i64 8364032
  store <4096 x float> zeroinitializer, ptr %4110, align 4
  %4111 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4112 = getelementptr float, ptr %4111, i64 8368128
  store <4096 x float> zeroinitializer, ptr %4112, align 4
  %4113 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4114 = getelementptr float, ptr %4113, i64 8372224
  store <4096 x float> zeroinitializer, ptr %4114, align 4
  %4115 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4116 = getelementptr float, ptr %4115, i64 8376320
  store <4096 x float> zeroinitializer, ptr %4116, align 4
  %4117 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4118 = getelementptr float, ptr %4117, i64 8380416
  store <4096 x float> zeroinitializer, ptr %4118, align 4
  %4119 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4120 = getelementptr float, ptr %4119, i64 8384512
  store <4096 x float> zeroinitializer, ptr %4120, align 4
  %4121 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4122 = getelementptr float, ptr %4121, i64 8388608
  store <4096 x float> zeroinitializer, ptr %4122, align 4
  %4123 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4124 = getelementptr float, ptr %4123, i64 8392704
  store <4096 x float> zeroinitializer, ptr %4124, align 4
  %4125 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4126 = getelementptr float, ptr %4125, i64 8396800
  store <4096 x float> zeroinitializer, ptr %4126, align 4
  %4127 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4128 = getelementptr float, ptr %4127, i64 8400896
  store <4096 x float> zeroinitializer, ptr %4128, align 4
  %4129 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4130 = getelementptr float, ptr %4129, i64 8404992
  store <4096 x float> zeroinitializer, ptr %4130, align 4
  %4131 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4132 = getelementptr float, ptr %4131, i64 8409088
  store <4096 x float> zeroinitializer, ptr %4132, align 4
  %4133 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4134 = getelementptr float, ptr %4133, i64 8413184
  store <4096 x float> zeroinitializer, ptr %4134, align 4
  %4135 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4136 = getelementptr float, ptr %4135, i64 8417280
  store <4096 x float> zeroinitializer, ptr %4136, align 4
  %4137 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4138 = getelementptr float, ptr %4137, i64 8421376
  store <4096 x float> zeroinitializer, ptr %4138, align 4
  %4139 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4140 = getelementptr float, ptr %4139, i64 8425472
  store <4096 x float> zeroinitializer, ptr %4140, align 4
  %4141 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4142 = getelementptr float, ptr %4141, i64 8429568
  store <4096 x float> zeroinitializer, ptr %4142, align 4
  %4143 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4144 = getelementptr float, ptr %4143, i64 8433664
  store <4096 x float> zeroinitializer, ptr %4144, align 4
  %4145 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4146 = getelementptr float, ptr %4145, i64 8437760
  store <4096 x float> zeroinitializer, ptr %4146, align 4
  %4147 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4148 = getelementptr float, ptr %4147, i64 8441856
  store <4096 x float> zeroinitializer, ptr %4148, align 4
  %4149 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4150 = getelementptr float, ptr %4149, i64 8445952
  store <4096 x float> zeroinitializer, ptr %4150, align 4
  %4151 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4152 = getelementptr float, ptr %4151, i64 8450048
  store <4096 x float> zeroinitializer, ptr %4152, align 4
  %4153 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4154 = getelementptr float, ptr %4153, i64 8454144
  store <4096 x float> zeroinitializer, ptr %4154, align 4
  %4155 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4156 = getelementptr float, ptr %4155, i64 8458240
  store <4096 x float> zeroinitializer, ptr %4156, align 4
  %4157 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4158 = getelementptr float, ptr %4157, i64 8462336
  store <4096 x float> zeroinitializer, ptr %4158, align 4
  %4159 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4160 = getelementptr float, ptr %4159, i64 8466432
  store <4096 x float> zeroinitializer, ptr %4160, align 4
  %4161 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4162 = getelementptr float, ptr %4161, i64 8470528
  store <4096 x float> zeroinitializer, ptr %4162, align 4
  %4163 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4164 = getelementptr float, ptr %4163, i64 8474624
  store <4096 x float> zeroinitializer, ptr %4164, align 4
  %4165 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4166 = getelementptr float, ptr %4165, i64 8478720
  store <4096 x float> zeroinitializer, ptr %4166, align 4
  %4167 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4168 = getelementptr float, ptr %4167, i64 8482816
  store <4096 x float> zeroinitializer, ptr %4168, align 4
  %4169 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4170 = getelementptr float, ptr %4169, i64 8486912
  store <4096 x float> zeroinitializer, ptr %4170, align 4
  %4171 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4172 = getelementptr float, ptr %4171, i64 8491008
  store <4096 x float> zeroinitializer, ptr %4172, align 4
  %4173 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4174 = getelementptr float, ptr %4173, i64 8495104
  store <4096 x float> zeroinitializer, ptr %4174, align 4
  %4175 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4176 = getelementptr float, ptr %4175, i64 8499200
  store <4096 x float> zeroinitializer, ptr %4176, align 4
  %4177 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4178 = getelementptr float, ptr %4177, i64 8503296
  store <4096 x float> zeroinitializer, ptr %4178, align 4
  %4179 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4180 = getelementptr float, ptr %4179, i64 8507392
  store <4096 x float> zeroinitializer, ptr %4180, align 4
  %4181 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4182 = getelementptr float, ptr %4181, i64 8511488
  store <4096 x float> zeroinitializer, ptr %4182, align 4
  %4183 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4184 = getelementptr float, ptr %4183, i64 8515584
  store <4096 x float> zeroinitializer, ptr %4184, align 4
  %4185 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4186 = getelementptr float, ptr %4185, i64 8519680
  store <4096 x float> zeroinitializer, ptr %4186, align 4
  %4187 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4188 = getelementptr float, ptr %4187, i64 8523776
  store <4096 x float> zeroinitializer, ptr %4188, align 4
  %4189 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4190 = getelementptr float, ptr %4189, i64 8527872
  store <4096 x float> zeroinitializer, ptr %4190, align 4
  %4191 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4192 = getelementptr float, ptr %4191, i64 8531968
  store <4096 x float> zeroinitializer, ptr %4192, align 4
  %4193 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4194 = getelementptr float, ptr %4193, i64 8536064
  store <4096 x float> zeroinitializer, ptr %4194, align 4
  %4195 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4196 = getelementptr float, ptr %4195, i64 8540160
  store <4096 x float> zeroinitializer, ptr %4196, align 4
  %4197 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4198 = getelementptr float, ptr %4197, i64 8544256
  store <4096 x float> zeroinitializer, ptr %4198, align 4
  %4199 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4200 = getelementptr float, ptr %4199, i64 8548352
  store <4096 x float> zeroinitializer, ptr %4200, align 4
  %4201 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4202 = getelementptr float, ptr %4201, i64 8552448
  store <4096 x float> zeroinitializer, ptr %4202, align 4
  %4203 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4204 = getelementptr float, ptr %4203, i64 8556544
  store <4096 x float> zeroinitializer, ptr %4204, align 4
  %4205 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4206 = getelementptr float, ptr %4205, i64 8560640
  store <4096 x float> zeroinitializer, ptr %4206, align 4
  %4207 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4208 = getelementptr float, ptr %4207, i64 8564736
  store <4096 x float> zeroinitializer, ptr %4208, align 4
  %4209 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4210 = getelementptr float, ptr %4209, i64 8568832
  store <4096 x float> zeroinitializer, ptr %4210, align 4
  %4211 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4212 = getelementptr float, ptr %4211, i64 8572928
  store <4096 x float> zeroinitializer, ptr %4212, align 4
  %4213 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4214 = getelementptr float, ptr %4213, i64 8577024
  store <4096 x float> zeroinitializer, ptr %4214, align 4
  %4215 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4216 = getelementptr float, ptr %4215, i64 8581120
  store <4096 x float> zeroinitializer, ptr %4216, align 4
  %4217 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4218 = getelementptr float, ptr %4217, i64 8585216
  store <4096 x float> zeroinitializer, ptr %4218, align 4
  %4219 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4220 = getelementptr float, ptr %4219, i64 8589312
  store <4096 x float> zeroinitializer, ptr %4220, align 4
  %4221 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4222 = getelementptr float, ptr %4221, i64 8593408
  store <4096 x float> zeroinitializer, ptr %4222, align 4
  %4223 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4224 = getelementptr float, ptr %4223, i64 8597504
  store <4096 x float> zeroinitializer, ptr %4224, align 4
  %4225 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4226 = getelementptr float, ptr %4225, i64 8601600
  store <4096 x float> zeroinitializer, ptr %4226, align 4
  %4227 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4228 = getelementptr float, ptr %4227, i64 8605696
  store <4096 x float> zeroinitializer, ptr %4228, align 4
  %4229 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4230 = getelementptr float, ptr %4229, i64 8609792
  store <4096 x float> zeroinitializer, ptr %4230, align 4
  %4231 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4232 = getelementptr float, ptr %4231, i64 8613888
  store <4096 x float> zeroinitializer, ptr %4232, align 4
  %4233 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4234 = getelementptr float, ptr %4233, i64 8617984
  store <4096 x float> zeroinitializer, ptr %4234, align 4
  %4235 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4236 = getelementptr float, ptr %4235, i64 8622080
  store <4096 x float> zeroinitializer, ptr %4236, align 4
  %4237 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4238 = getelementptr float, ptr %4237, i64 8626176
  store <4096 x float> zeroinitializer, ptr %4238, align 4
  %4239 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4240 = getelementptr float, ptr %4239, i64 8630272
  store <4096 x float> zeroinitializer, ptr %4240, align 4
  %4241 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4242 = getelementptr float, ptr %4241, i64 8634368
  store <4096 x float> zeroinitializer, ptr %4242, align 4
  %4243 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4244 = getelementptr float, ptr %4243, i64 8638464
  store <4096 x float> zeroinitializer, ptr %4244, align 4
  %4245 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4246 = getelementptr float, ptr %4245, i64 8642560
  store <4096 x float> zeroinitializer, ptr %4246, align 4
  %4247 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4248 = getelementptr float, ptr %4247, i64 8646656
  store <4096 x float> zeroinitializer, ptr %4248, align 4
  %4249 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4250 = getelementptr float, ptr %4249, i64 8650752
  store <4096 x float> zeroinitializer, ptr %4250, align 4
  %4251 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4252 = getelementptr float, ptr %4251, i64 8654848
  store <4096 x float> zeroinitializer, ptr %4252, align 4
  %4253 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4254 = getelementptr float, ptr %4253, i64 8658944
  store <4096 x float> zeroinitializer, ptr %4254, align 4
  %4255 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4256 = getelementptr float, ptr %4255, i64 8663040
  store <4096 x float> zeroinitializer, ptr %4256, align 4
  %4257 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4258 = getelementptr float, ptr %4257, i64 8667136
  store <4096 x float> zeroinitializer, ptr %4258, align 4
  %4259 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4260 = getelementptr float, ptr %4259, i64 8671232
  store <4096 x float> zeroinitializer, ptr %4260, align 4
  %4261 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4262 = getelementptr float, ptr %4261, i64 8675328
  store <4096 x float> zeroinitializer, ptr %4262, align 4
  %4263 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4264 = getelementptr float, ptr %4263, i64 8679424
  store <4096 x float> zeroinitializer, ptr %4264, align 4
  %4265 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4266 = getelementptr float, ptr %4265, i64 8683520
  store <4096 x float> zeroinitializer, ptr %4266, align 4
  %4267 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4268 = getelementptr float, ptr %4267, i64 8687616
  store <4096 x float> zeroinitializer, ptr %4268, align 4
  %4269 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4270 = getelementptr float, ptr %4269, i64 8691712
  store <4096 x float> zeroinitializer, ptr %4270, align 4
  %4271 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4272 = getelementptr float, ptr %4271, i64 8695808
  store <4096 x float> zeroinitializer, ptr %4272, align 4
  %4273 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4274 = getelementptr float, ptr %4273, i64 8699904
  store <4096 x float> zeroinitializer, ptr %4274, align 4
  %4275 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4276 = getelementptr float, ptr %4275, i64 8704000
  store <4096 x float> zeroinitializer, ptr %4276, align 4
  %4277 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4278 = getelementptr float, ptr %4277, i64 8708096
  store <4096 x float> zeroinitializer, ptr %4278, align 4
  %4279 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4280 = getelementptr float, ptr %4279, i64 8712192
  store <4096 x float> zeroinitializer, ptr %4280, align 4
  %4281 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4282 = getelementptr float, ptr %4281, i64 8716288
  store <4096 x float> zeroinitializer, ptr %4282, align 4
  %4283 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4284 = getelementptr float, ptr %4283, i64 8720384
  store <4096 x float> zeroinitializer, ptr %4284, align 4
  %4285 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4286 = getelementptr float, ptr %4285, i64 8724480
  store <4096 x float> zeroinitializer, ptr %4286, align 4
  %4287 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4288 = getelementptr float, ptr %4287, i64 8728576
  store <4096 x float> zeroinitializer, ptr %4288, align 4
  %4289 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4290 = getelementptr float, ptr %4289, i64 8732672
  store <4096 x float> zeroinitializer, ptr %4290, align 4
  %4291 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4292 = getelementptr float, ptr %4291, i64 8736768
  store <4096 x float> zeroinitializer, ptr %4292, align 4
  %4293 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4294 = getelementptr float, ptr %4293, i64 8740864
  store <4096 x float> zeroinitializer, ptr %4294, align 4
  %4295 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4296 = getelementptr float, ptr %4295, i64 8744960
  store <4096 x float> zeroinitializer, ptr %4296, align 4
  %4297 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4298 = getelementptr float, ptr %4297, i64 8749056
  store <4096 x float> zeroinitializer, ptr %4298, align 4
  %4299 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4300 = getelementptr float, ptr %4299, i64 8753152
  store <4096 x float> zeroinitializer, ptr %4300, align 4
  %4301 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4302 = getelementptr float, ptr %4301, i64 8757248
  store <4096 x float> zeroinitializer, ptr %4302, align 4
  %4303 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4304 = getelementptr float, ptr %4303, i64 8761344
  store <4096 x float> zeroinitializer, ptr %4304, align 4
  %4305 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4306 = getelementptr float, ptr %4305, i64 8765440
  store <4096 x float> zeroinitializer, ptr %4306, align 4
  %4307 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4308 = getelementptr float, ptr %4307, i64 8769536
  store <4096 x float> zeroinitializer, ptr %4308, align 4
  %4309 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4310 = getelementptr float, ptr %4309, i64 8773632
  store <4096 x float> zeroinitializer, ptr %4310, align 4
  %4311 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4312 = getelementptr float, ptr %4311, i64 8777728
  store <4096 x float> zeroinitializer, ptr %4312, align 4
  %4313 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4314 = getelementptr float, ptr %4313, i64 8781824
  store <4096 x float> zeroinitializer, ptr %4314, align 4
  %4315 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4316 = getelementptr float, ptr %4315, i64 8785920
  store <4096 x float> zeroinitializer, ptr %4316, align 4
  %4317 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4318 = getelementptr float, ptr %4317, i64 8790016
  store <4096 x float> zeroinitializer, ptr %4318, align 4
  %4319 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4320 = getelementptr float, ptr %4319, i64 8794112
  store <4096 x float> zeroinitializer, ptr %4320, align 4
  %4321 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4322 = getelementptr float, ptr %4321, i64 8798208
  store <4096 x float> zeroinitializer, ptr %4322, align 4
  %4323 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4324 = getelementptr float, ptr %4323, i64 8802304
  store <4096 x float> zeroinitializer, ptr %4324, align 4
  %4325 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4326 = getelementptr float, ptr %4325, i64 8806400
  store <4096 x float> zeroinitializer, ptr %4326, align 4
  %4327 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4328 = getelementptr float, ptr %4327, i64 8810496
  store <4096 x float> zeroinitializer, ptr %4328, align 4
  %4329 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4330 = getelementptr float, ptr %4329, i64 8814592
  store <4096 x float> zeroinitializer, ptr %4330, align 4
  %4331 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4332 = getelementptr float, ptr %4331, i64 8818688
  store <4096 x float> zeroinitializer, ptr %4332, align 4
  %4333 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4334 = getelementptr float, ptr %4333, i64 8822784
  store <4096 x float> zeroinitializer, ptr %4334, align 4
  %4335 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4336 = getelementptr float, ptr %4335, i64 8826880
  store <4096 x float> zeroinitializer, ptr %4336, align 4
  %4337 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4338 = getelementptr float, ptr %4337, i64 8830976
  store <4096 x float> zeroinitializer, ptr %4338, align 4
  %4339 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4340 = getelementptr float, ptr %4339, i64 8835072
  store <4096 x float> zeroinitializer, ptr %4340, align 4
  %4341 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4342 = getelementptr float, ptr %4341, i64 8839168
  store <4096 x float> zeroinitializer, ptr %4342, align 4
  %4343 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4344 = getelementptr float, ptr %4343, i64 8843264
  store <4096 x float> zeroinitializer, ptr %4344, align 4
  %4345 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4346 = getelementptr float, ptr %4345, i64 8847360
  store <4096 x float> zeroinitializer, ptr %4346, align 4
  %4347 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4348 = getelementptr float, ptr %4347, i64 8851456
  store <4096 x float> zeroinitializer, ptr %4348, align 4
  %4349 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4350 = getelementptr float, ptr %4349, i64 8855552
  store <4096 x float> zeroinitializer, ptr %4350, align 4
  %4351 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4352 = getelementptr float, ptr %4351, i64 8859648
  store <4096 x float> zeroinitializer, ptr %4352, align 4
  %4353 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4354 = getelementptr float, ptr %4353, i64 8863744
  store <4096 x float> zeroinitializer, ptr %4354, align 4
  %4355 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4356 = getelementptr float, ptr %4355, i64 8867840
  store <4096 x float> zeroinitializer, ptr %4356, align 4
  %4357 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4358 = getelementptr float, ptr %4357, i64 8871936
  store <4096 x float> zeroinitializer, ptr %4358, align 4
  %4359 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4360 = getelementptr float, ptr %4359, i64 8876032
  store <4096 x float> zeroinitializer, ptr %4360, align 4
  %4361 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4362 = getelementptr float, ptr %4361, i64 8880128
  store <4096 x float> zeroinitializer, ptr %4362, align 4
  %4363 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4364 = getelementptr float, ptr %4363, i64 8884224
  store <4096 x float> zeroinitializer, ptr %4364, align 4
  %4365 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4366 = getelementptr float, ptr %4365, i64 8888320
  store <4096 x float> zeroinitializer, ptr %4366, align 4
  %4367 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4368 = getelementptr float, ptr %4367, i64 8892416
  store <4096 x float> zeroinitializer, ptr %4368, align 4
  %4369 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4370 = getelementptr float, ptr %4369, i64 8896512
  store <4096 x float> zeroinitializer, ptr %4370, align 4
  %4371 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4372 = getelementptr float, ptr %4371, i64 8900608
  store <4096 x float> zeroinitializer, ptr %4372, align 4
  %4373 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4374 = getelementptr float, ptr %4373, i64 8904704
  store <4096 x float> zeroinitializer, ptr %4374, align 4
  %4375 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4376 = getelementptr float, ptr %4375, i64 8908800
  store <4096 x float> zeroinitializer, ptr %4376, align 4
  %4377 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4378 = getelementptr float, ptr %4377, i64 8912896
  store <4096 x float> zeroinitializer, ptr %4378, align 4
  %4379 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4380 = getelementptr float, ptr %4379, i64 8916992
  store <4096 x float> zeroinitializer, ptr %4380, align 4
  %4381 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4382 = getelementptr float, ptr %4381, i64 8921088
  store <4096 x float> zeroinitializer, ptr %4382, align 4
  %4383 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4384 = getelementptr float, ptr %4383, i64 8925184
  store <4096 x float> zeroinitializer, ptr %4384, align 4
  %4385 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4386 = getelementptr float, ptr %4385, i64 8929280
  store <4096 x float> zeroinitializer, ptr %4386, align 4
  %4387 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4388 = getelementptr float, ptr %4387, i64 8933376
  store <4096 x float> zeroinitializer, ptr %4388, align 4
  %4389 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4390 = getelementptr float, ptr %4389, i64 8937472
  store <4096 x float> zeroinitializer, ptr %4390, align 4
  %4391 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4392 = getelementptr float, ptr %4391, i64 8941568
  store <4096 x float> zeroinitializer, ptr %4392, align 4
  %4393 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4394 = getelementptr float, ptr %4393, i64 8945664
  store <4096 x float> zeroinitializer, ptr %4394, align 4
  %4395 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4396 = getelementptr float, ptr %4395, i64 8949760
  store <4096 x float> zeroinitializer, ptr %4396, align 4
  %4397 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4398 = getelementptr float, ptr %4397, i64 8953856
  store <4096 x float> zeroinitializer, ptr %4398, align 4
  %4399 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4400 = getelementptr float, ptr %4399, i64 8957952
  store <4096 x float> zeroinitializer, ptr %4400, align 4
  %4401 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4402 = getelementptr float, ptr %4401, i64 8962048
  store <4096 x float> zeroinitializer, ptr %4402, align 4
  %4403 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4404 = getelementptr float, ptr %4403, i64 8966144
  store <4096 x float> zeroinitializer, ptr %4404, align 4
  %4405 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4406 = getelementptr float, ptr %4405, i64 8970240
  store <4096 x float> zeroinitializer, ptr %4406, align 4
  %4407 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4408 = getelementptr float, ptr %4407, i64 8974336
  store <4096 x float> zeroinitializer, ptr %4408, align 4
  %4409 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4410 = getelementptr float, ptr %4409, i64 8978432
  store <4096 x float> zeroinitializer, ptr %4410, align 4
  %4411 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4412 = getelementptr float, ptr %4411, i64 8982528
  store <4096 x float> zeroinitializer, ptr %4412, align 4
  %4413 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4414 = getelementptr float, ptr %4413, i64 8986624
  store <4096 x float> zeroinitializer, ptr %4414, align 4
  %4415 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4416 = getelementptr float, ptr %4415, i64 8990720
  store <4096 x float> zeroinitializer, ptr %4416, align 4
  %4417 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4418 = getelementptr float, ptr %4417, i64 8994816
  store <4096 x float> zeroinitializer, ptr %4418, align 4
  %4419 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4420 = getelementptr float, ptr %4419, i64 8998912
  store <4096 x float> zeroinitializer, ptr %4420, align 4
  %4421 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4422 = getelementptr float, ptr %4421, i64 9003008
  store <4096 x float> zeroinitializer, ptr %4422, align 4
  %4423 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4424 = getelementptr float, ptr %4423, i64 9007104
  store <4096 x float> zeroinitializer, ptr %4424, align 4
  %4425 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4426 = getelementptr float, ptr %4425, i64 9011200
  store <4096 x float> zeroinitializer, ptr %4426, align 4
  %4427 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4428 = getelementptr float, ptr %4427, i64 9015296
  store <4096 x float> zeroinitializer, ptr %4428, align 4
  %4429 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4430 = getelementptr float, ptr %4429, i64 9019392
  store <4096 x float> zeroinitializer, ptr %4430, align 4
  %4431 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4432 = getelementptr float, ptr %4431, i64 9023488
  store <4096 x float> zeroinitializer, ptr %4432, align 4
  %4433 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4434 = getelementptr float, ptr %4433, i64 9027584
  store <4096 x float> zeroinitializer, ptr %4434, align 4
  %4435 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4436 = getelementptr float, ptr %4435, i64 9031680
  store <4096 x float> zeroinitializer, ptr %4436, align 4
  %4437 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4438 = getelementptr float, ptr %4437, i64 9035776
  store <4096 x float> zeroinitializer, ptr %4438, align 4
  %4439 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4440 = getelementptr float, ptr %4439, i64 9039872
  store <4096 x float> zeroinitializer, ptr %4440, align 4
  %4441 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4442 = getelementptr float, ptr %4441, i64 9043968
  store <4096 x float> zeroinitializer, ptr %4442, align 4
  %4443 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4444 = getelementptr float, ptr %4443, i64 9048064
  store <4096 x float> zeroinitializer, ptr %4444, align 4
  %4445 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4446 = getelementptr float, ptr %4445, i64 9052160
  store <4096 x float> zeroinitializer, ptr %4446, align 4
  %4447 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4448 = getelementptr float, ptr %4447, i64 9056256
  store <4096 x float> zeroinitializer, ptr %4448, align 4
  %4449 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4450 = getelementptr float, ptr %4449, i64 9060352
  store <4096 x float> zeroinitializer, ptr %4450, align 4
  %4451 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4452 = getelementptr float, ptr %4451, i64 9064448
  store <4096 x float> zeroinitializer, ptr %4452, align 4
  %4453 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4454 = getelementptr float, ptr %4453, i64 9068544
  store <4096 x float> zeroinitializer, ptr %4454, align 4
  %4455 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4456 = getelementptr float, ptr %4455, i64 9072640
  store <4096 x float> zeroinitializer, ptr %4456, align 4
  %4457 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4458 = getelementptr float, ptr %4457, i64 9076736
  store <4096 x float> zeroinitializer, ptr %4458, align 4
  %4459 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4460 = getelementptr float, ptr %4459, i64 9080832
  store <4096 x float> zeroinitializer, ptr %4460, align 4
  %4461 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4462 = getelementptr float, ptr %4461, i64 9084928
  store <4096 x float> zeroinitializer, ptr %4462, align 4
  %4463 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4464 = getelementptr float, ptr %4463, i64 9089024
  store <4096 x float> zeroinitializer, ptr %4464, align 4
  %4465 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4466 = getelementptr float, ptr %4465, i64 9093120
  store <4096 x float> zeroinitializer, ptr %4466, align 4
  %4467 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4468 = getelementptr float, ptr %4467, i64 9097216
  store <4096 x float> zeroinitializer, ptr %4468, align 4
  %4469 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4470 = getelementptr float, ptr %4469, i64 9101312
  store <4096 x float> zeroinitializer, ptr %4470, align 4
  %4471 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4472 = getelementptr float, ptr %4471, i64 9105408
  store <4096 x float> zeroinitializer, ptr %4472, align 4
  %4473 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4474 = getelementptr float, ptr %4473, i64 9109504
  store <4096 x float> zeroinitializer, ptr %4474, align 4
  %4475 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4476 = getelementptr float, ptr %4475, i64 9113600
  store <4096 x float> zeroinitializer, ptr %4476, align 4
  %4477 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4478 = getelementptr float, ptr %4477, i64 9117696
  store <4096 x float> zeroinitializer, ptr %4478, align 4
  %4479 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4480 = getelementptr float, ptr %4479, i64 9121792
  store <4096 x float> zeroinitializer, ptr %4480, align 4
  %4481 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4482 = getelementptr float, ptr %4481, i64 9125888
  store <4096 x float> zeroinitializer, ptr %4482, align 4
  %4483 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4484 = getelementptr float, ptr %4483, i64 9129984
  store <4096 x float> zeroinitializer, ptr %4484, align 4
  %4485 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4486 = getelementptr float, ptr %4485, i64 9134080
  store <4096 x float> zeroinitializer, ptr %4486, align 4
  %4487 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4488 = getelementptr float, ptr %4487, i64 9138176
  store <4096 x float> zeroinitializer, ptr %4488, align 4
  %4489 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4490 = getelementptr float, ptr %4489, i64 9142272
  store <4096 x float> zeroinitializer, ptr %4490, align 4
  %4491 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4492 = getelementptr float, ptr %4491, i64 9146368
  store <4096 x float> zeroinitializer, ptr %4492, align 4
  %4493 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4494 = getelementptr float, ptr %4493, i64 9150464
  store <4096 x float> zeroinitializer, ptr %4494, align 4
  %4495 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4496 = getelementptr float, ptr %4495, i64 9154560
  store <4096 x float> zeroinitializer, ptr %4496, align 4
  %4497 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4498 = getelementptr float, ptr %4497, i64 9158656
  store <4096 x float> zeroinitializer, ptr %4498, align 4
  %4499 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4500 = getelementptr float, ptr %4499, i64 9162752
  store <4096 x float> zeroinitializer, ptr %4500, align 4
  %4501 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4502 = getelementptr float, ptr %4501, i64 9166848
  store <4096 x float> zeroinitializer, ptr %4502, align 4
  %4503 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4504 = getelementptr float, ptr %4503, i64 9170944
  store <4096 x float> zeroinitializer, ptr %4504, align 4
  %4505 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4506 = getelementptr float, ptr %4505, i64 9175040
  store <4096 x float> zeroinitializer, ptr %4506, align 4
  %4507 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4508 = getelementptr float, ptr %4507, i64 9179136
  store <4096 x float> zeroinitializer, ptr %4508, align 4
  %4509 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4510 = getelementptr float, ptr %4509, i64 9183232
  store <4096 x float> zeroinitializer, ptr %4510, align 4
  %4511 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4512 = getelementptr float, ptr %4511, i64 9187328
  store <4096 x float> zeroinitializer, ptr %4512, align 4
  %4513 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4514 = getelementptr float, ptr %4513, i64 9191424
  store <4096 x float> zeroinitializer, ptr %4514, align 4
  %4515 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4516 = getelementptr float, ptr %4515, i64 9195520
  store <4096 x float> zeroinitializer, ptr %4516, align 4
  %4517 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4518 = getelementptr float, ptr %4517, i64 9199616
  store <4096 x float> zeroinitializer, ptr %4518, align 4
  %4519 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4520 = getelementptr float, ptr %4519, i64 9203712
  store <4096 x float> zeroinitializer, ptr %4520, align 4
  %4521 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4522 = getelementptr float, ptr %4521, i64 9207808
  store <4096 x float> zeroinitializer, ptr %4522, align 4
  %4523 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4524 = getelementptr float, ptr %4523, i64 9211904
  store <4096 x float> zeroinitializer, ptr %4524, align 4
  %4525 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4526 = getelementptr float, ptr %4525, i64 9216000
  store <4096 x float> zeroinitializer, ptr %4526, align 4
  %4527 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4528 = getelementptr float, ptr %4527, i64 9220096
  store <4096 x float> zeroinitializer, ptr %4528, align 4
  %4529 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4530 = getelementptr float, ptr %4529, i64 9224192
  store <4096 x float> zeroinitializer, ptr %4530, align 4
  %4531 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4532 = getelementptr float, ptr %4531, i64 9228288
  store <4096 x float> zeroinitializer, ptr %4532, align 4
  %4533 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4534 = getelementptr float, ptr %4533, i64 9232384
  store <4096 x float> zeroinitializer, ptr %4534, align 4
  %4535 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4536 = getelementptr float, ptr %4535, i64 9236480
  store <4096 x float> zeroinitializer, ptr %4536, align 4
  %4537 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4538 = getelementptr float, ptr %4537, i64 9240576
  store <4096 x float> zeroinitializer, ptr %4538, align 4
  %4539 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4540 = getelementptr float, ptr %4539, i64 9244672
  store <4096 x float> zeroinitializer, ptr %4540, align 4
  %4541 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4542 = getelementptr float, ptr %4541, i64 9248768
  store <4096 x float> zeroinitializer, ptr %4542, align 4
  %4543 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4544 = getelementptr float, ptr %4543, i64 9252864
  store <4096 x float> zeroinitializer, ptr %4544, align 4
  %4545 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4546 = getelementptr float, ptr %4545, i64 9256960
  store <4096 x float> zeroinitializer, ptr %4546, align 4
  %4547 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4548 = getelementptr float, ptr %4547, i64 9261056
  store <4096 x float> zeroinitializer, ptr %4548, align 4
  %4549 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4550 = getelementptr float, ptr %4549, i64 9265152
  store <4096 x float> zeroinitializer, ptr %4550, align 4
  %4551 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4552 = getelementptr float, ptr %4551, i64 9269248
  store <4096 x float> zeroinitializer, ptr %4552, align 4
  %4553 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4554 = getelementptr float, ptr %4553, i64 9273344
  store <4096 x float> zeroinitializer, ptr %4554, align 4
  %4555 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4556 = getelementptr float, ptr %4555, i64 9277440
  store <4096 x float> zeroinitializer, ptr %4556, align 4
  %4557 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4558 = getelementptr float, ptr %4557, i64 9281536
  store <4096 x float> zeroinitializer, ptr %4558, align 4
  %4559 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4560 = getelementptr float, ptr %4559, i64 9285632
  store <4096 x float> zeroinitializer, ptr %4560, align 4
  %4561 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4562 = getelementptr float, ptr %4561, i64 9289728
  store <4096 x float> zeroinitializer, ptr %4562, align 4
  %4563 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4564 = getelementptr float, ptr %4563, i64 9293824
  store <4096 x float> zeroinitializer, ptr %4564, align 4
  %4565 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4566 = getelementptr float, ptr %4565, i64 9297920
  store <4096 x float> zeroinitializer, ptr %4566, align 4
  %4567 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4568 = getelementptr float, ptr %4567, i64 9302016
  store <4096 x float> zeroinitializer, ptr %4568, align 4
  %4569 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4570 = getelementptr float, ptr %4569, i64 9306112
  store <4096 x float> zeroinitializer, ptr %4570, align 4
  %4571 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4572 = getelementptr float, ptr %4571, i64 9310208
  store <4096 x float> zeroinitializer, ptr %4572, align 4
  %4573 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4574 = getelementptr float, ptr %4573, i64 9314304
  store <4096 x float> zeroinitializer, ptr %4574, align 4
  %4575 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4576 = getelementptr float, ptr %4575, i64 9318400
  store <4096 x float> zeroinitializer, ptr %4576, align 4
  %4577 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4578 = getelementptr float, ptr %4577, i64 9322496
  store <4096 x float> zeroinitializer, ptr %4578, align 4
  %4579 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4580 = getelementptr float, ptr %4579, i64 9326592
  store <4096 x float> zeroinitializer, ptr %4580, align 4
  %4581 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4582 = getelementptr float, ptr %4581, i64 9330688
  store <4096 x float> zeroinitializer, ptr %4582, align 4
  %4583 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4584 = getelementptr float, ptr %4583, i64 9334784
  store <4096 x float> zeroinitializer, ptr %4584, align 4
  %4585 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4586 = getelementptr float, ptr %4585, i64 9338880
  store <4096 x float> zeroinitializer, ptr %4586, align 4
  %4587 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4588 = getelementptr float, ptr %4587, i64 9342976
  store <4096 x float> zeroinitializer, ptr %4588, align 4
  %4589 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4590 = getelementptr float, ptr %4589, i64 9347072
  store <4096 x float> zeroinitializer, ptr %4590, align 4
  %4591 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4592 = getelementptr float, ptr %4591, i64 9351168
  store <4096 x float> zeroinitializer, ptr %4592, align 4
  %4593 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4594 = getelementptr float, ptr %4593, i64 9355264
  store <4096 x float> zeroinitializer, ptr %4594, align 4
  %4595 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4596 = getelementptr float, ptr %4595, i64 9359360
  store <4096 x float> zeroinitializer, ptr %4596, align 4
  %4597 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4598 = getelementptr float, ptr %4597, i64 9363456
  store <4096 x float> zeroinitializer, ptr %4598, align 4
  %4599 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4600 = getelementptr float, ptr %4599, i64 9367552
  store <4096 x float> zeroinitializer, ptr %4600, align 4
  %4601 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4602 = getelementptr float, ptr %4601, i64 9371648
  store <4096 x float> zeroinitializer, ptr %4602, align 4
  %4603 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4604 = getelementptr float, ptr %4603, i64 9375744
  store <4096 x float> zeroinitializer, ptr %4604, align 4
  %4605 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4606 = getelementptr float, ptr %4605, i64 9379840
  store <4096 x float> zeroinitializer, ptr %4606, align 4
  %4607 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4608 = getelementptr float, ptr %4607, i64 9383936
  store <4096 x float> zeroinitializer, ptr %4608, align 4
  %4609 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4610 = getelementptr float, ptr %4609, i64 9388032
  store <4096 x float> zeroinitializer, ptr %4610, align 4
  %4611 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4612 = getelementptr float, ptr %4611, i64 9392128
  store <4096 x float> zeroinitializer, ptr %4612, align 4
  %4613 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4614 = getelementptr float, ptr %4613, i64 9396224
  store <4096 x float> zeroinitializer, ptr %4614, align 4
  %4615 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4616 = getelementptr float, ptr %4615, i64 9400320
  store <4096 x float> zeroinitializer, ptr %4616, align 4
  %4617 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4618 = getelementptr float, ptr %4617, i64 9404416
  store <4096 x float> zeroinitializer, ptr %4618, align 4
  %4619 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4620 = getelementptr float, ptr %4619, i64 9408512
  store <4096 x float> zeroinitializer, ptr %4620, align 4
  %4621 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4622 = getelementptr float, ptr %4621, i64 9412608
  store <4096 x float> zeroinitializer, ptr %4622, align 4
  %4623 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4624 = getelementptr float, ptr %4623, i64 9416704
  store <4096 x float> zeroinitializer, ptr %4624, align 4
  %4625 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4626 = getelementptr float, ptr %4625, i64 9420800
  store <4096 x float> zeroinitializer, ptr %4626, align 4
  %4627 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4628 = getelementptr float, ptr %4627, i64 9424896
  store <4096 x float> zeroinitializer, ptr %4628, align 4
  %4629 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4630 = getelementptr float, ptr %4629, i64 9428992
  store <4096 x float> zeroinitializer, ptr %4630, align 4
  %4631 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4632 = getelementptr float, ptr %4631, i64 9433088
  store <4096 x float> zeroinitializer, ptr %4632, align 4
  %4633 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4634 = getelementptr float, ptr %4633, i64 9437184
  store <4096 x float> zeroinitializer, ptr %4634, align 4
  %4635 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4636 = getelementptr float, ptr %4635, i64 9441280
  store <4096 x float> zeroinitializer, ptr %4636, align 4
  %4637 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4638 = getelementptr float, ptr %4637, i64 9445376
  store <4096 x float> zeroinitializer, ptr %4638, align 4
  %4639 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4640 = getelementptr float, ptr %4639, i64 9449472
  store <4096 x float> zeroinitializer, ptr %4640, align 4
  %4641 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4642 = getelementptr float, ptr %4641, i64 9453568
  store <4096 x float> zeroinitializer, ptr %4642, align 4
  %4643 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4644 = getelementptr float, ptr %4643, i64 9457664
  store <4096 x float> zeroinitializer, ptr %4644, align 4
  %4645 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4646 = getelementptr float, ptr %4645, i64 9461760
  store <4096 x float> zeroinitializer, ptr %4646, align 4
  %4647 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4648 = getelementptr float, ptr %4647, i64 9465856
  store <4096 x float> zeroinitializer, ptr %4648, align 4
  %4649 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4650 = getelementptr float, ptr %4649, i64 9469952
  store <4096 x float> zeroinitializer, ptr %4650, align 4
  %4651 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4652 = getelementptr float, ptr %4651, i64 9474048
  store <4096 x float> zeroinitializer, ptr %4652, align 4
  %4653 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4654 = getelementptr float, ptr %4653, i64 9478144
  store <4096 x float> zeroinitializer, ptr %4654, align 4
  %4655 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4656 = getelementptr float, ptr %4655, i64 9482240
  store <4096 x float> zeroinitializer, ptr %4656, align 4
  %4657 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4658 = getelementptr float, ptr %4657, i64 9486336
  store <4096 x float> zeroinitializer, ptr %4658, align 4
  %4659 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4660 = getelementptr float, ptr %4659, i64 9490432
  store <4096 x float> zeroinitializer, ptr %4660, align 4
  %4661 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4662 = getelementptr float, ptr %4661, i64 9494528
  store <4096 x float> zeroinitializer, ptr %4662, align 4
  %4663 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4664 = getelementptr float, ptr %4663, i64 9498624
  store <4096 x float> zeroinitializer, ptr %4664, align 4
  %4665 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4666 = getelementptr float, ptr %4665, i64 9502720
  store <4096 x float> zeroinitializer, ptr %4666, align 4
  %4667 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4668 = getelementptr float, ptr %4667, i64 9506816
  store <4096 x float> zeroinitializer, ptr %4668, align 4
  %4669 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4670 = getelementptr float, ptr %4669, i64 9510912
  store <4096 x float> zeroinitializer, ptr %4670, align 4
  %4671 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4672 = getelementptr float, ptr %4671, i64 9515008
  store <4096 x float> zeroinitializer, ptr %4672, align 4
  %4673 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4674 = getelementptr float, ptr %4673, i64 9519104
  store <4096 x float> zeroinitializer, ptr %4674, align 4
  %4675 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4676 = getelementptr float, ptr %4675, i64 9523200
  store <4096 x float> zeroinitializer, ptr %4676, align 4
  %4677 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4678 = getelementptr float, ptr %4677, i64 9527296
  store <4096 x float> zeroinitializer, ptr %4678, align 4
  %4679 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4680 = getelementptr float, ptr %4679, i64 9531392
  store <4096 x float> zeroinitializer, ptr %4680, align 4
  %4681 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4682 = getelementptr float, ptr %4681, i64 9535488
  store <4096 x float> zeroinitializer, ptr %4682, align 4
  %4683 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4684 = getelementptr float, ptr %4683, i64 9539584
  store <4096 x float> zeroinitializer, ptr %4684, align 4
  %4685 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4686 = getelementptr float, ptr %4685, i64 9543680
  store <4096 x float> zeroinitializer, ptr %4686, align 4
  %4687 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4688 = getelementptr float, ptr %4687, i64 9547776
  store <4096 x float> zeroinitializer, ptr %4688, align 4
  %4689 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4690 = getelementptr float, ptr %4689, i64 9551872
  store <4096 x float> zeroinitializer, ptr %4690, align 4
  %4691 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4692 = getelementptr float, ptr %4691, i64 9555968
  store <4096 x float> zeroinitializer, ptr %4692, align 4
  %4693 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4694 = getelementptr float, ptr %4693, i64 9560064
  store <4096 x float> zeroinitializer, ptr %4694, align 4
  %4695 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4696 = getelementptr float, ptr %4695, i64 9564160
  store <4096 x float> zeroinitializer, ptr %4696, align 4
  %4697 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4698 = getelementptr float, ptr %4697, i64 9568256
  store <4096 x float> zeroinitializer, ptr %4698, align 4
  %4699 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4700 = getelementptr float, ptr %4699, i64 9572352
  store <4096 x float> zeroinitializer, ptr %4700, align 4
  %4701 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4702 = getelementptr float, ptr %4701, i64 9576448
  store <4096 x float> zeroinitializer, ptr %4702, align 4
  %4703 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4704 = getelementptr float, ptr %4703, i64 9580544
  store <4096 x float> zeroinitializer, ptr %4704, align 4
  %4705 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4706 = getelementptr float, ptr %4705, i64 9584640
  store <4096 x float> zeroinitializer, ptr %4706, align 4
  %4707 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4708 = getelementptr float, ptr %4707, i64 9588736
  store <4096 x float> zeroinitializer, ptr %4708, align 4
  %4709 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4710 = getelementptr float, ptr %4709, i64 9592832
  store <4096 x float> zeroinitializer, ptr %4710, align 4
  %4711 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4712 = getelementptr float, ptr %4711, i64 9596928
  store <4096 x float> zeroinitializer, ptr %4712, align 4
  %4713 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4714 = getelementptr float, ptr %4713, i64 9601024
  store <4096 x float> zeroinitializer, ptr %4714, align 4
  %4715 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4716 = getelementptr float, ptr %4715, i64 9605120
  store <4096 x float> zeroinitializer, ptr %4716, align 4
  %4717 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4718 = getelementptr float, ptr %4717, i64 9609216
  store <4096 x float> zeroinitializer, ptr %4718, align 4
  %4719 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4720 = getelementptr float, ptr %4719, i64 9613312
  store <4096 x float> zeroinitializer, ptr %4720, align 4
  %4721 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4722 = getelementptr float, ptr %4721, i64 9617408
  store <4096 x float> zeroinitializer, ptr %4722, align 4
  %4723 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4724 = getelementptr float, ptr %4723, i64 9621504
  store <4096 x float> zeroinitializer, ptr %4724, align 4
  %4725 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4726 = getelementptr float, ptr %4725, i64 9625600
  store <4096 x float> zeroinitializer, ptr %4726, align 4
  %4727 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4728 = getelementptr float, ptr %4727, i64 9629696
  store <4096 x float> zeroinitializer, ptr %4728, align 4
  %4729 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4730 = getelementptr float, ptr %4729, i64 9633792
  store <4096 x float> zeroinitializer, ptr %4730, align 4
  %4731 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4732 = getelementptr float, ptr %4731, i64 9637888
  store <4096 x float> zeroinitializer, ptr %4732, align 4
  %4733 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4734 = getelementptr float, ptr %4733, i64 9641984
  store <4096 x float> zeroinitializer, ptr %4734, align 4
  %4735 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4736 = getelementptr float, ptr %4735, i64 9646080
  store <4096 x float> zeroinitializer, ptr %4736, align 4
  %4737 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4738 = getelementptr float, ptr %4737, i64 9650176
  store <4096 x float> zeroinitializer, ptr %4738, align 4
  %4739 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4740 = getelementptr float, ptr %4739, i64 9654272
  store <4096 x float> zeroinitializer, ptr %4740, align 4
  %4741 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4742 = getelementptr float, ptr %4741, i64 9658368
  store <4096 x float> zeroinitializer, ptr %4742, align 4
  %4743 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4744 = getelementptr float, ptr %4743, i64 9662464
  store <4096 x float> zeroinitializer, ptr %4744, align 4
  %4745 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4746 = getelementptr float, ptr %4745, i64 9666560
  store <4096 x float> zeroinitializer, ptr %4746, align 4
  %4747 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4748 = getelementptr float, ptr %4747, i64 9670656
  store <4096 x float> zeroinitializer, ptr %4748, align 4
  %4749 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4750 = getelementptr float, ptr %4749, i64 9674752
  store <4096 x float> zeroinitializer, ptr %4750, align 4
  %4751 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4752 = getelementptr float, ptr %4751, i64 9678848
  store <4096 x float> zeroinitializer, ptr %4752, align 4
  %4753 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4754 = getelementptr float, ptr %4753, i64 9682944
  store <4096 x float> zeroinitializer, ptr %4754, align 4
  %4755 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4756 = getelementptr float, ptr %4755, i64 9687040
  store <4096 x float> zeroinitializer, ptr %4756, align 4
  %4757 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4758 = getelementptr float, ptr %4757, i64 9691136
  store <4096 x float> zeroinitializer, ptr %4758, align 4
  %4759 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4760 = getelementptr float, ptr %4759, i64 9695232
  store <4096 x float> zeroinitializer, ptr %4760, align 4
  %4761 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4762 = getelementptr float, ptr %4761, i64 9699328
  store <4096 x float> zeroinitializer, ptr %4762, align 4
  %4763 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4764 = getelementptr float, ptr %4763, i64 9703424
  store <4096 x float> zeroinitializer, ptr %4764, align 4
  %4765 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4766 = getelementptr float, ptr %4765, i64 9707520
  store <4096 x float> zeroinitializer, ptr %4766, align 4
  %4767 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4768 = getelementptr float, ptr %4767, i64 9711616
  store <4096 x float> zeroinitializer, ptr %4768, align 4
  %4769 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4770 = getelementptr float, ptr %4769, i64 9715712
  store <4096 x float> zeroinitializer, ptr %4770, align 4
  %4771 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4772 = getelementptr float, ptr %4771, i64 9719808
  store <4096 x float> zeroinitializer, ptr %4772, align 4
  %4773 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4774 = getelementptr float, ptr %4773, i64 9723904
  store <4096 x float> zeroinitializer, ptr %4774, align 4
  %4775 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4776 = getelementptr float, ptr %4775, i64 9728000
  store <4096 x float> zeroinitializer, ptr %4776, align 4
  %4777 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4778 = getelementptr float, ptr %4777, i64 9732096
  store <4096 x float> zeroinitializer, ptr %4778, align 4
  %4779 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4780 = getelementptr float, ptr %4779, i64 9736192
  store <4096 x float> zeroinitializer, ptr %4780, align 4
  %4781 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4782 = getelementptr float, ptr %4781, i64 9740288
  store <4096 x float> zeroinitializer, ptr %4782, align 4
  %4783 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4784 = getelementptr float, ptr %4783, i64 9744384
  store <4096 x float> zeroinitializer, ptr %4784, align 4
  %4785 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4786 = getelementptr float, ptr %4785, i64 9748480
  store <4096 x float> zeroinitializer, ptr %4786, align 4
  %4787 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4788 = getelementptr float, ptr %4787, i64 9752576
  store <4096 x float> zeroinitializer, ptr %4788, align 4
  %4789 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4790 = getelementptr float, ptr %4789, i64 9756672
  store <4096 x float> zeroinitializer, ptr %4790, align 4
  %4791 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4792 = getelementptr float, ptr %4791, i64 9760768
  store <4096 x float> zeroinitializer, ptr %4792, align 4
  %4793 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4794 = getelementptr float, ptr %4793, i64 9764864
  store <4096 x float> zeroinitializer, ptr %4794, align 4
  %4795 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4796 = getelementptr float, ptr %4795, i64 9768960
  store <4096 x float> zeroinitializer, ptr %4796, align 4
  %4797 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4798 = getelementptr float, ptr %4797, i64 9773056
  store <4096 x float> zeroinitializer, ptr %4798, align 4
  %4799 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4800 = getelementptr float, ptr %4799, i64 9777152
  store <4096 x float> zeroinitializer, ptr %4800, align 4
  %4801 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4802 = getelementptr float, ptr %4801, i64 9781248
  store <4096 x float> zeroinitializer, ptr %4802, align 4
  %4803 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4804 = getelementptr float, ptr %4803, i64 9785344
  store <4096 x float> zeroinitializer, ptr %4804, align 4
  %4805 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4806 = getelementptr float, ptr %4805, i64 9789440
  store <4096 x float> zeroinitializer, ptr %4806, align 4
  %4807 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4808 = getelementptr float, ptr %4807, i64 9793536
  store <4096 x float> zeroinitializer, ptr %4808, align 4
  %4809 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4810 = getelementptr float, ptr %4809, i64 9797632
  store <4096 x float> zeroinitializer, ptr %4810, align 4
  %4811 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4812 = getelementptr float, ptr %4811, i64 9801728
  store <4096 x float> zeroinitializer, ptr %4812, align 4
  %4813 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4814 = getelementptr float, ptr %4813, i64 9805824
  store <4096 x float> zeroinitializer, ptr %4814, align 4
  %4815 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4816 = getelementptr float, ptr %4815, i64 9809920
  store <4096 x float> zeroinitializer, ptr %4816, align 4
  %4817 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4818 = getelementptr float, ptr %4817, i64 9814016
  store <4096 x float> zeroinitializer, ptr %4818, align 4
  %4819 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4820 = getelementptr float, ptr %4819, i64 9818112
  store <4096 x float> zeroinitializer, ptr %4820, align 4
  %4821 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4822 = getelementptr float, ptr %4821, i64 9822208
  store <4096 x float> zeroinitializer, ptr %4822, align 4
  %4823 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4824 = getelementptr float, ptr %4823, i64 9826304
  store <4096 x float> zeroinitializer, ptr %4824, align 4
  %4825 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4826 = getelementptr float, ptr %4825, i64 9830400
  store <4096 x float> zeroinitializer, ptr %4826, align 4
  %4827 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4828 = getelementptr float, ptr %4827, i64 9834496
  store <4096 x float> zeroinitializer, ptr %4828, align 4
  %4829 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4830 = getelementptr float, ptr %4829, i64 9838592
  store <4096 x float> zeroinitializer, ptr %4830, align 4
  %4831 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4832 = getelementptr float, ptr %4831, i64 9842688
  store <4096 x float> zeroinitializer, ptr %4832, align 4
  %4833 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4834 = getelementptr float, ptr %4833, i64 9846784
  store <4096 x float> zeroinitializer, ptr %4834, align 4
  %4835 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4836 = getelementptr float, ptr %4835, i64 9850880
  store <4096 x float> zeroinitializer, ptr %4836, align 4
  %4837 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4838 = getelementptr float, ptr %4837, i64 9854976
  store <4096 x float> zeroinitializer, ptr %4838, align 4
  %4839 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4840 = getelementptr float, ptr %4839, i64 9859072
  store <4096 x float> zeroinitializer, ptr %4840, align 4
  %4841 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4842 = getelementptr float, ptr %4841, i64 9863168
  store <4096 x float> zeroinitializer, ptr %4842, align 4
  %4843 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4844 = getelementptr float, ptr %4843, i64 9867264
  store <4096 x float> zeroinitializer, ptr %4844, align 4
  %4845 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4846 = getelementptr float, ptr %4845, i64 9871360
  store <4096 x float> zeroinitializer, ptr %4846, align 4
  %4847 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4848 = getelementptr float, ptr %4847, i64 9875456
  store <4096 x float> zeroinitializer, ptr %4848, align 4
  %4849 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4850 = getelementptr float, ptr %4849, i64 9879552
  store <4096 x float> zeroinitializer, ptr %4850, align 4
  %4851 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4852 = getelementptr float, ptr %4851, i64 9883648
  store <4096 x float> zeroinitializer, ptr %4852, align 4
  %4853 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4854 = getelementptr float, ptr %4853, i64 9887744
  store <4096 x float> zeroinitializer, ptr %4854, align 4
  %4855 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4856 = getelementptr float, ptr %4855, i64 9891840
  store <4096 x float> zeroinitializer, ptr %4856, align 4
  %4857 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4858 = getelementptr float, ptr %4857, i64 9895936
  store <4096 x float> zeroinitializer, ptr %4858, align 4
  %4859 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4860 = getelementptr float, ptr %4859, i64 9900032
  store <4096 x float> zeroinitializer, ptr %4860, align 4
  %4861 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4862 = getelementptr float, ptr %4861, i64 9904128
  store <4096 x float> zeroinitializer, ptr %4862, align 4
  %4863 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4864 = getelementptr float, ptr %4863, i64 9908224
  store <4096 x float> zeroinitializer, ptr %4864, align 4
  %4865 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4866 = getelementptr float, ptr %4865, i64 9912320
  store <4096 x float> zeroinitializer, ptr %4866, align 4
  %4867 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4868 = getelementptr float, ptr %4867, i64 9916416
  store <4096 x float> zeroinitializer, ptr %4868, align 4
  %4869 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4870 = getelementptr float, ptr %4869, i64 9920512
  store <4096 x float> zeroinitializer, ptr %4870, align 4
  %4871 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4872 = getelementptr float, ptr %4871, i64 9924608
  store <4096 x float> zeroinitializer, ptr %4872, align 4
  %4873 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4874 = getelementptr float, ptr %4873, i64 9928704
  store <4096 x float> zeroinitializer, ptr %4874, align 4
  %4875 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4876 = getelementptr float, ptr %4875, i64 9932800
  store <4096 x float> zeroinitializer, ptr %4876, align 4
  %4877 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4878 = getelementptr float, ptr %4877, i64 9936896
  store <4096 x float> zeroinitializer, ptr %4878, align 4
  %4879 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4880 = getelementptr float, ptr %4879, i64 9940992
  store <4096 x float> zeroinitializer, ptr %4880, align 4
  %4881 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4882 = getelementptr float, ptr %4881, i64 9945088
  store <4096 x float> zeroinitializer, ptr %4882, align 4
  %4883 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4884 = getelementptr float, ptr %4883, i64 9949184
  store <4096 x float> zeroinitializer, ptr %4884, align 4
  %4885 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4886 = getelementptr float, ptr %4885, i64 9953280
  store <4096 x float> zeroinitializer, ptr %4886, align 4
  %4887 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4888 = getelementptr float, ptr %4887, i64 9957376
  store <4096 x float> zeroinitializer, ptr %4888, align 4
  %4889 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4890 = getelementptr float, ptr %4889, i64 9961472
  store <4096 x float> zeroinitializer, ptr %4890, align 4
  %4891 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4892 = getelementptr float, ptr %4891, i64 9965568
  store <4096 x float> zeroinitializer, ptr %4892, align 4
  %4893 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4894 = getelementptr float, ptr %4893, i64 9969664
  store <4096 x float> zeroinitializer, ptr %4894, align 4
  %4895 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4896 = getelementptr float, ptr %4895, i64 9973760
  store <4096 x float> zeroinitializer, ptr %4896, align 4
  %4897 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4898 = getelementptr float, ptr %4897, i64 9977856
  store <4096 x float> zeroinitializer, ptr %4898, align 4
  %4899 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4900 = getelementptr float, ptr %4899, i64 9981952
  store <4096 x float> zeroinitializer, ptr %4900, align 4
  %4901 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4902 = getelementptr float, ptr %4901, i64 9986048
  store <4096 x float> zeroinitializer, ptr %4902, align 4
  %4903 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4904 = getelementptr float, ptr %4903, i64 9990144
  store <4096 x float> zeroinitializer, ptr %4904, align 4
  %4905 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4906 = getelementptr float, ptr %4905, i64 9994240
  store <4096 x float> zeroinitializer, ptr %4906, align 4
  %4907 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4908 = getelementptr float, ptr %4907, i64 9998336
  store <4096 x float> zeroinitializer, ptr %4908, align 4
  %4909 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4910 = getelementptr float, ptr %4909, i64 10002432
  store <4096 x float> zeroinitializer, ptr %4910, align 4
  %4911 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4912 = getelementptr float, ptr %4911, i64 10006528
  store <4096 x float> zeroinitializer, ptr %4912, align 4
  %4913 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4914 = getelementptr float, ptr %4913, i64 10010624
  store <4096 x float> zeroinitializer, ptr %4914, align 4
  %4915 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4916 = getelementptr float, ptr %4915, i64 10014720
  store <4096 x float> zeroinitializer, ptr %4916, align 4
  %4917 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4918 = getelementptr float, ptr %4917, i64 10018816
  store <4096 x float> zeroinitializer, ptr %4918, align 4
  %4919 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4920 = getelementptr float, ptr %4919, i64 10022912
  store <4096 x float> zeroinitializer, ptr %4920, align 4
  %4921 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4922 = getelementptr float, ptr %4921, i64 10027008
  store <4096 x float> zeroinitializer, ptr %4922, align 4
  %4923 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4924 = getelementptr float, ptr %4923, i64 10031104
  store <4096 x float> zeroinitializer, ptr %4924, align 4
  %4925 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4926 = getelementptr float, ptr %4925, i64 10035200
  store <4096 x float> zeroinitializer, ptr %4926, align 4
  %4927 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4928 = getelementptr float, ptr %4927, i64 10039296
  store <4096 x float> zeroinitializer, ptr %4928, align 4
  %4929 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4930 = getelementptr float, ptr %4929, i64 10043392
  store <4096 x float> zeroinitializer, ptr %4930, align 4
  %4931 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4932 = getelementptr float, ptr %4931, i64 10047488
  store <4096 x float> zeroinitializer, ptr %4932, align 4
  %4933 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4934 = getelementptr float, ptr %4933, i64 10051584
  store <4096 x float> zeroinitializer, ptr %4934, align 4
  %4935 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4936 = getelementptr float, ptr %4935, i64 10055680
  store <4096 x float> zeroinitializer, ptr %4936, align 4
  %4937 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4938 = getelementptr float, ptr %4937, i64 10059776
  store <4096 x float> zeroinitializer, ptr %4938, align 4
  %4939 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4940 = getelementptr float, ptr %4939, i64 10063872
  store <4096 x float> zeroinitializer, ptr %4940, align 4
  %4941 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4942 = getelementptr float, ptr %4941, i64 10067968
  store <4096 x float> zeroinitializer, ptr %4942, align 4
  %4943 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4944 = getelementptr float, ptr %4943, i64 10072064
  store <4096 x float> zeroinitializer, ptr %4944, align 4
  %4945 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4946 = getelementptr float, ptr %4945, i64 10076160
  store <4096 x float> zeroinitializer, ptr %4946, align 4
  %4947 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4948 = getelementptr float, ptr %4947, i64 10080256
  store <4096 x float> zeroinitializer, ptr %4948, align 4
  %4949 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4950 = getelementptr float, ptr %4949, i64 10084352
  store <4096 x float> zeroinitializer, ptr %4950, align 4
  %4951 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4952 = getelementptr float, ptr %4951, i64 10088448
  store <4096 x float> zeroinitializer, ptr %4952, align 4
  %4953 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4954 = getelementptr float, ptr %4953, i64 10092544
  store <4096 x float> zeroinitializer, ptr %4954, align 4
  %4955 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4956 = getelementptr float, ptr %4955, i64 10096640
  store <4096 x float> zeroinitializer, ptr %4956, align 4
  %4957 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4958 = getelementptr float, ptr %4957, i64 10100736
  store <4096 x float> zeroinitializer, ptr %4958, align 4
  %4959 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4960 = getelementptr float, ptr %4959, i64 10104832
  store <4096 x float> zeroinitializer, ptr %4960, align 4
  %4961 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4962 = getelementptr float, ptr %4961, i64 10108928
  store <4096 x float> zeroinitializer, ptr %4962, align 4
  %4963 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4964 = getelementptr float, ptr %4963, i64 10113024
  store <4096 x float> zeroinitializer, ptr %4964, align 4
  %4965 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4966 = getelementptr float, ptr %4965, i64 10117120
  store <4096 x float> zeroinitializer, ptr %4966, align 4
  %4967 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4968 = getelementptr float, ptr %4967, i64 10121216
  store <4096 x float> zeroinitializer, ptr %4968, align 4
  %4969 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4970 = getelementptr float, ptr %4969, i64 10125312
  store <4096 x float> zeroinitializer, ptr %4970, align 4
  %4971 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4972 = getelementptr float, ptr %4971, i64 10129408
  store <4096 x float> zeroinitializer, ptr %4972, align 4
  %4973 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4974 = getelementptr float, ptr %4973, i64 10133504
  store <4096 x float> zeroinitializer, ptr %4974, align 4
  %4975 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4976 = getelementptr float, ptr %4975, i64 10137600
  store <4096 x float> zeroinitializer, ptr %4976, align 4
  %4977 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4978 = getelementptr float, ptr %4977, i64 10141696
  store <4096 x float> zeroinitializer, ptr %4978, align 4
  %4979 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4980 = getelementptr float, ptr %4979, i64 10145792
  store <4096 x float> zeroinitializer, ptr %4980, align 4
  %4981 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4982 = getelementptr float, ptr %4981, i64 10149888
  store <4096 x float> zeroinitializer, ptr %4982, align 4
  %4983 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4984 = getelementptr float, ptr %4983, i64 10153984
  store <4096 x float> zeroinitializer, ptr %4984, align 4
  %4985 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4986 = getelementptr float, ptr %4985, i64 10158080
  store <4096 x float> zeroinitializer, ptr %4986, align 4
  %4987 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4988 = getelementptr float, ptr %4987, i64 10162176
  store <4096 x float> zeroinitializer, ptr %4988, align 4
  %4989 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4990 = getelementptr float, ptr %4989, i64 10166272
  store <4096 x float> zeroinitializer, ptr %4990, align 4
  %4991 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4992 = getelementptr float, ptr %4991, i64 10170368
  store <4096 x float> zeroinitializer, ptr %4992, align 4
  %4993 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4994 = getelementptr float, ptr %4993, i64 10174464
  store <4096 x float> zeroinitializer, ptr %4994, align 4
  %4995 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4996 = getelementptr float, ptr %4995, i64 10178560
  store <4096 x float> zeroinitializer, ptr %4996, align 4
  %4997 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %4998 = getelementptr float, ptr %4997, i64 10182656
  store <4096 x float> zeroinitializer, ptr %4998, align 4
  %4999 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5000 = getelementptr float, ptr %4999, i64 10186752
  store <4096 x float> zeroinitializer, ptr %5000, align 4
  %5001 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5002 = getelementptr float, ptr %5001, i64 10190848
  store <4096 x float> zeroinitializer, ptr %5002, align 4
  %5003 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5004 = getelementptr float, ptr %5003, i64 10194944
  store <4096 x float> zeroinitializer, ptr %5004, align 4
  %5005 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5006 = getelementptr float, ptr %5005, i64 10199040
  store <4096 x float> zeroinitializer, ptr %5006, align 4
  %5007 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5008 = getelementptr float, ptr %5007, i64 10203136
  store <4096 x float> zeroinitializer, ptr %5008, align 4
  %5009 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5010 = getelementptr float, ptr %5009, i64 10207232
  store <4096 x float> zeroinitializer, ptr %5010, align 4
  %5011 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5012 = getelementptr float, ptr %5011, i64 10211328
  store <4096 x float> zeroinitializer, ptr %5012, align 4
  %5013 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5014 = getelementptr float, ptr %5013, i64 10215424
  store <4096 x float> zeroinitializer, ptr %5014, align 4
  %5015 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5016 = getelementptr float, ptr %5015, i64 10219520
  store <4096 x float> zeroinitializer, ptr %5016, align 4
  %5017 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5018 = getelementptr float, ptr %5017, i64 10223616
  store <4096 x float> zeroinitializer, ptr %5018, align 4
  %5019 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5020 = getelementptr float, ptr %5019, i64 10227712
  store <4096 x float> zeroinitializer, ptr %5020, align 4
  %5021 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5022 = getelementptr float, ptr %5021, i64 10231808
  store <4096 x float> zeroinitializer, ptr %5022, align 4
  %5023 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5024 = getelementptr float, ptr %5023, i64 10235904
  store <4096 x float> zeroinitializer, ptr %5024, align 4
  %5025 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5026 = getelementptr float, ptr %5025, i64 10240000
  store <4096 x float> zeroinitializer, ptr %5026, align 4
  %5027 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5028 = getelementptr float, ptr %5027, i64 10244096
  store <4096 x float> zeroinitializer, ptr %5028, align 4
  %5029 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5030 = getelementptr float, ptr %5029, i64 10248192
  store <4096 x float> zeroinitializer, ptr %5030, align 4
  %5031 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5032 = getelementptr float, ptr %5031, i64 10252288
  store <4096 x float> zeroinitializer, ptr %5032, align 4
  %5033 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5034 = getelementptr float, ptr %5033, i64 10256384
  store <4096 x float> zeroinitializer, ptr %5034, align 4
  %5035 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5036 = getelementptr float, ptr %5035, i64 10260480
  store <4096 x float> zeroinitializer, ptr %5036, align 4
  %5037 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5038 = getelementptr float, ptr %5037, i64 10264576
  store <4096 x float> zeroinitializer, ptr %5038, align 4
  %5039 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5040 = getelementptr float, ptr %5039, i64 10268672
  store <4096 x float> zeroinitializer, ptr %5040, align 4
  %5041 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5042 = getelementptr float, ptr %5041, i64 10272768
  store <4096 x float> zeroinitializer, ptr %5042, align 4
  %5043 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5044 = getelementptr float, ptr %5043, i64 10276864
  store <4096 x float> zeroinitializer, ptr %5044, align 4
  %5045 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5046 = getelementptr float, ptr %5045, i64 10280960
  store <4096 x float> zeroinitializer, ptr %5046, align 4
  %5047 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5048 = getelementptr float, ptr %5047, i64 10285056
  store <4096 x float> zeroinitializer, ptr %5048, align 4
  %5049 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5050 = getelementptr float, ptr %5049, i64 10289152
  store <4096 x float> zeroinitializer, ptr %5050, align 4
  %5051 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5052 = getelementptr float, ptr %5051, i64 10293248
  store <4096 x float> zeroinitializer, ptr %5052, align 4
  %5053 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5054 = getelementptr float, ptr %5053, i64 10297344
  store <4096 x float> zeroinitializer, ptr %5054, align 4
  %5055 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5056 = getelementptr float, ptr %5055, i64 10301440
  store <4096 x float> zeroinitializer, ptr %5056, align 4
  %5057 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5058 = getelementptr float, ptr %5057, i64 10305536
  store <4096 x float> zeroinitializer, ptr %5058, align 4
  %5059 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5060 = getelementptr float, ptr %5059, i64 10309632
  store <4096 x float> zeroinitializer, ptr %5060, align 4
  %5061 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5062 = getelementptr float, ptr %5061, i64 10313728
  store <4096 x float> zeroinitializer, ptr %5062, align 4
  %5063 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5064 = getelementptr float, ptr %5063, i64 10317824
  store <4096 x float> zeroinitializer, ptr %5064, align 4
  %5065 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5066 = getelementptr float, ptr %5065, i64 10321920
  store <4096 x float> zeroinitializer, ptr %5066, align 4
  %5067 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5068 = getelementptr float, ptr %5067, i64 10326016
  store <4096 x float> zeroinitializer, ptr %5068, align 4
  %5069 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5070 = getelementptr float, ptr %5069, i64 10330112
  store <4096 x float> zeroinitializer, ptr %5070, align 4
  %5071 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5072 = getelementptr float, ptr %5071, i64 10334208
  store <4096 x float> zeroinitializer, ptr %5072, align 4
  %5073 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5074 = getelementptr float, ptr %5073, i64 10338304
  store <4096 x float> zeroinitializer, ptr %5074, align 4
  %5075 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5076 = getelementptr float, ptr %5075, i64 10342400
  store <4096 x float> zeroinitializer, ptr %5076, align 4
  %5077 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5078 = getelementptr float, ptr %5077, i64 10346496
  store <4096 x float> zeroinitializer, ptr %5078, align 4
  %5079 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5080 = getelementptr float, ptr %5079, i64 10350592
  store <4096 x float> zeroinitializer, ptr %5080, align 4
  %5081 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5082 = getelementptr float, ptr %5081, i64 10354688
  store <4096 x float> zeroinitializer, ptr %5082, align 4
  %5083 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5084 = getelementptr float, ptr %5083, i64 10358784
  store <4096 x float> zeroinitializer, ptr %5084, align 4
  %5085 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5086 = getelementptr float, ptr %5085, i64 10362880
  store <4096 x float> zeroinitializer, ptr %5086, align 4
  %5087 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5088 = getelementptr float, ptr %5087, i64 10366976
  store <4096 x float> zeroinitializer, ptr %5088, align 4
  %5089 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5090 = getelementptr float, ptr %5089, i64 10371072
  store <4096 x float> zeroinitializer, ptr %5090, align 4
  %5091 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5092 = getelementptr float, ptr %5091, i64 10375168
  store <4096 x float> zeroinitializer, ptr %5092, align 4
  %5093 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5094 = getelementptr float, ptr %5093, i64 10379264
  store <4096 x float> zeroinitializer, ptr %5094, align 4
  %5095 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5096 = getelementptr float, ptr %5095, i64 10383360
  store <4096 x float> zeroinitializer, ptr %5096, align 4
  %5097 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5098 = getelementptr float, ptr %5097, i64 10387456
  store <4096 x float> zeroinitializer, ptr %5098, align 4
  %5099 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5100 = getelementptr float, ptr %5099, i64 10391552
  store <4096 x float> zeroinitializer, ptr %5100, align 4
  %5101 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5102 = getelementptr float, ptr %5101, i64 10395648
  store <4096 x float> zeroinitializer, ptr %5102, align 4
  %5103 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5104 = getelementptr float, ptr %5103, i64 10399744
  store <4096 x float> zeroinitializer, ptr %5104, align 4
  %5105 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5106 = getelementptr float, ptr %5105, i64 10403840
  store <4096 x float> zeroinitializer, ptr %5106, align 4
  %5107 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5108 = getelementptr float, ptr %5107, i64 10407936
  store <4096 x float> zeroinitializer, ptr %5108, align 4
  %5109 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5110 = getelementptr float, ptr %5109, i64 10412032
  store <4096 x float> zeroinitializer, ptr %5110, align 4
  %5111 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5112 = getelementptr float, ptr %5111, i64 10416128
  store <4096 x float> zeroinitializer, ptr %5112, align 4
  %5113 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5114 = getelementptr float, ptr %5113, i64 10420224
  store <4096 x float> zeroinitializer, ptr %5114, align 4
  %5115 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5116 = getelementptr float, ptr %5115, i64 10424320
  store <4096 x float> zeroinitializer, ptr %5116, align 4
  %5117 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5118 = getelementptr float, ptr %5117, i64 10428416
  store <4096 x float> zeroinitializer, ptr %5118, align 4
  %5119 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5120 = getelementptr float, ptr %5119, i64 10432512
  store <4096 x float> zeroinitializer, ptr %5120, align 4
  %5121 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5122 = getelementptr float, ptr %5121, i64 10436608
  store <4096 x float> zeroinitializer, ptr %5122, align 4
  %5123 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5124 = getelementptr float, ptr %5123, i64 10440704
  store <4096 x float> zeroinitializer, ptr %5124, align 4
  %5125 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5126 = getelementptr float, ptr %5125, i64 10444800
  store <4096 x float> zeroinitializer, ptr %5126, align 4
  %5127 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5128 = getelementptr float, ptr %5127, i64 10448896
  store <4096 x float> zeroinitializer, ptr %5128, align 4
  %5129 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5130 = getelementptr float, ptr %5129, i64 10452992
  store <4096 x float> zeroinitializer, ptr %5130, align 4
  %5131 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5132 = getelementptr float, ptr %5131, i64 10457088
  store <4096 x float> zeroinitializer, ptr %5132, align 4
  %5133 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5134 = getelementptr float, ptr %5133, i64 10461184
  store <4096 x float> zeroinitializer, ptr %5134, align 4
  %5135 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5136 = getelementptr float, ptr %5135, i64 10465280
  store <4096 x float> zeroinitializer, ptr %5136, align 4
  %5137 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5138 = getelementptr float, ptr %5137, i64 10469376
  store <4096 x float> zeroinitializer, ptr %5138, align 4
  %5139 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5140 = getelementptr float, ptr %5139, i64 10473472
  store <4096 x float> zeroinitializer, ptr %5140, align 4
  %5141 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5142 = getelementptr float, ptr %5141, i64 10477568
  store <4096 x float> zeroinitializer, ptr %5142, align 4
  %5143 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5144 = getelementptr float, ptr %5143, i64 10481664
  store <4096 x float> zeroinitializer, ptr %5144, align 4
  %5145 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5146 = getelementptr float, ptr %5145, i64 10485760
  store <4096 x float> zeroinitializer, ptr %5146, align 4
  %5147 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5148 = getelementptr float, ptr %5147, i64 10489856
  store <4096 x float> zeroinitializer, ptr %5148, align 4
  %5149 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5150 = getelementptr float, ptr %5149, i64 10493952
  store <4096 x float> zeroinitializer, ptr %5150, align 4
  %5151 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5152 = getelementptr float, ptr %5151, i64 10498048
  store <4096 x float> zeroinitializer, ptr %5152, align 4
  %5153 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5154 = getelementptr float, ptr %5153, i64 10502144
  store <4096 x float> zeroinitializer, ptr %5154, align 4
  %5155 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5156 = getelementptr float, ptr %5155, i64 10506240
  store <4096 x float> zeroinitializer, ptr %5156, align 4
  %5157 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5158 = getelementptr float, ptr %5157, i64 10510336
  store <4096 x float> zeroinitializer, ptr %5158, align 4
  %5159 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5160 = getelementptr float, ptr %5159, i64 10514432
  store <4096 x float> zeroinitializer, ptr %5160, align 4
  %5161 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5162 = getelementptr float, ptr %5161, i64 10518528
  store <4096 x float> zeroinitializer, ptr %5162, align 4
  %5163 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5164 = getelementptr float, ptr %5163, i64 10522624
  store <4096 x float> zeroinitializer, ptr %5164, align 4
  %5165 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5166 = getelementptr float, ptr %5165, i64 10526720
  store <4096 x float> zeroinitializer, ptr %5166, align 4
  %5167 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5168 = getelementptr float, ptr %5167, i64 10530816
  store <4096 x float> zeroinitializer, ptr %5168, align 4
  %5169 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5170 = getelementptr float, ptr %5169, i64 10534912
  store <4096 x float> zeroinitializer, ptr %5170, align 4
  %5171 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5172 = getelementptr float, ptr %5171, i64 10539008
  store <4096 x float> zeroinitializer, ptr %5172, align 4
  %5173 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5174 = getelementptr float, ptr %5173, i64 10543104
  store <4096 x float> zeroinitializer, ptr %5174, align 4
  %5175 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5176 = getelementptr float, ptr %5175, i64 10547200
  store <4096 x float> zeroinitializer, ptr %5176, align 4
  %5177 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5178 = getelementptr float, ptr %5177, i64 10551296
  store <4096 x float> zeroinitializer, ptr %5178, align 4
  %5179 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5180 = getelementptr float, ptr %5179, i64 10555392
  store <4096 x float> zeroinitializer, ptr %5180, align 4
  %5181 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5182 = getelementptr float, ptr %5181, i64 10559488
  store <4096 x float> zeroinitializer, ptr %5182, align 4
  %5183 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5184 = getelementptr float, ptr %5183, i64 10563584
  store <4096 x float> zeroinitializer, ptr %5184, align 4
  %5185 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5186 = getelementptr float, ptr %5185, i64 10567680
  store <4096 x float> zeroinitializer, ptr %5186, align 4
  %5187 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5188 = getelementptr float, ptr %5187, i64 10571776
  store <4096 x float> zeroinitializer, ptr %5188, align 4
  %5189 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5190 = getelementptr float, ptr %5189, i64 10575872
  store <4096 x float> zeroinitializer, ptr %5190, align 4
  %5191 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5192 = getelementptr float, ptr %5191, i64 10579968
  store <4096 x float> zeroinitializer, ptr %5192, align 4
  %5193 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5194 = getelementptr float, ptr %5193, i64 10584064
  store <4096 x float> zeroinitializer, ptr %5194, align 4
  %5195 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5196 = getelementptr float, ptr %5195, i64 10588160
  store <4096 x float> zeroinitializer, ptr %5196, align 4
  %5197 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5198 = getelementptr float, ptr %5197, i64 10592256
  store <4096 x float> zeroinitializer, ptr %5198, align 4
  %5199 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5200 = getelementptr float, ptr %5199, i64 10596352
  store <4096 x float> zeroinitializer, ptr %5200, align 4
  %5201 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5202 = getelementptr float, ptr %5201, i64 10600448
  store <4096 x float> zeroinitializer, ptr %5202, align 4
  %5203 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5204 = getelementptr float, ptr %5203, i64 10604544
  store <4096 x float> zeroinitializer, ptr %5204, align 4
  %5205 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5206 = getelementptr float, ptr %5205, i64 10608640
  store <4096 x float> zeroinitializer, ptr %5206, align 4
  %5207 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5208 = getelementptr float, ptr %5207, i64 10612736
  store <4096 x float> zeroinitializer, ptr %5208, align 4
  %5209 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5210 = getelementptr float, ptr %5209, i64 10616832
  store <4096 x float> zeroinitializer, ptr %5210, align 4
  %5211 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5212 = getelementptr float, ptr %5211, i64 10620928
  store <4096 x float> zeroinitializer, ptr %5212, align 4
  %5213 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5214 = getelementptr float, ptr %5213, i64 10625024
  store <4096 x float> zeroinitializer, ptr %5214, align 4
  %5215 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5216 = getelementptr float, ptr %5215, i64 10629120
  store <4096 x float> zeroinitializer, ptr %5216, align 4
  %5217 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5218 = getelementptr float, ptr %5217, i64 10633216
  store <4096 x float> zeroinitializer, ptr %5218, align 4
  %5219 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5220 = getelementptr float, ptr %5219, i64 10637312
  store <4096 x float> zeroinitializer, ptr %5220, align 4
  %5221 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5222 = getelementptr float, ptr %5221, i64 10641408
  store <4096 x float> zeroinitializer, ptr %5222, align 4
  %5223 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5224 = getelementptr float, ptr %5223, i64 10645504
  store <4096 x float> zeroinitializer, ptr %5224, align 4
  %5225 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5226 = getelementptr float, ptr %5225, i64 10649600
  store <4096 x float> zeroinitializer, ptr %5226, align 4
  %5227 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5228 = getelementptr float, ptr %5227, i64 10653696
  store <4096 x float> zeroinitializer, ptr %5228, align 4
  %5229 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5230 = getelementptr float, ptr %5229, i64 10657792
  store <4096 x float> zeroinitializer, ptr %5230, align 4
  %5231 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5232 = getelementptr float, ptr %5231, i64 10661888
  store <4096 x float> zeroinitializer, ptr %5232, align 4
  %5233 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5234 = getelementptr float, ptr %5233, i64 10665984
  store <4096 x float> zeroinitializer, ptr %5234, align 4
  %5235 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5236 = getelementptr float, ptr %5235, i64 10670080
  store <4096 x float> zeroinitializer, ptr %5236, align 4
  %5237 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5238 = getelementptr float, ptr %5237, i64 10674176
  store <4096 x float> zeroinitializer, ptr %5238, align 4
  %5239 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5240 = getelementptr float, ptr %5239, i64 10678272
  store <4096 x float> zeroinitializer, ptr %5240, align 4
  %5241 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5242 = getelementptr float, ptr %5241, i64 10682368
  store <4096 x float> zeroinitializer, ptr %5242, align 4
  %5243 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5244 = getelementptr float, ptr %5243, i64 10686464
  store <4096 x float> zeroinitializer, ptr %5244, align 4
  %5245 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5246 = getelementptr float, ptr %5245, i64 10690560
  store <4096 x float> zeroinitializer, ptr %5246, align 4
  %5247 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5248 = getelementptr float, ptr %5247, i64 10694656
  store <4096 x float> zeroinitializer, ptr %5248, align 4
  %5249 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5250 = getelementptr float, ptr %5249, i64 10698752
  store <4096 x float> zeroinitializer, ptr %5250, align 4
  %5251 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5252 = getelementptr float, ptr %5251, i64 10702848
  store <4096 x float> zeroinitializer, ptr %5252, align 4
  %5253 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5254 = getelementptr float, ptr %5253, i64 10706944
  store <4096 x float> zeroinitializer, ptr %5254, align 4
  %5255 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5256 = getelementptr float, ptr %5255, i64 10711040
  store <4096 x float> zeroinitializer, ptr %5256, align 4
  %5257 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5258 = getelementptr float, ptr %5257, i64 10715136
  store <4096 x float> zeroinitializer, ptr %5258, align 4
  %5259 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5260 = getelementptr float, ptr %5259, i64 10719232
  store <4096 x float> zeroinitializer, ptr %5260, align 4
  %5261 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5262 = getelementptr float, ptr %5261, i64 10723328
  store <4096 x float> zeroinitializer, ptr %5262, align 4
  %5263 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5264 = getelementptr float, ptr %5263, i64 10727424
  store <4096 x float> zeroinitializer, ptr %5264, align 4
  %5265 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5266 = getelementptr float, ptr %5265, i64 10731520
  store <4096 x float> zeroinitializer, ptr %5266, align 4
  %5267 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5268 = getelementptr float, ptr %5267, i64 10735616
  store <4096 x float> zeroinitializer, ptr %5268, align 4
  %5269 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5270 = getelementptr float, ptr %5269, i64 10739712
  store <4096 x float> zeroinitializer, ptr %5270, align 4
  %5271 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5272 = getelementptr float, ptr %5271, i64 10743808
  store <4096 x float> zeroinitializer, ptr %5272, align 4
  %5273 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5274 = getelementptr float, ptr %5273, i64 10747904
  store <4096 x float> zeroinitializer, ptr %5274, align 4
  %5275 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5276 = getelementptr float, ptr %5275, i64 10752000
  store <4096 x float> zeroinitializer, ptr %5276, align 4
  %5277 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5278 = getelementptr float, ptr %5277, i64 10756096
  store <4096 x float> zeroinitializer, ptr %5278, align 4
  %5279 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5280 = getelementptr float, ptr %5279, i64 10760192
  store <4096 x float> zeroinitializer, ptr %5280, align 4
  %5281 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5282 = getelementptr float, ptr %5281, i64 10764288
  store <4096 x float> zeroinitializer, ptr %5282, align 4
  %5283 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5284 = getelementptr float, ptr %5283, i64 10768384
  store <4096 x float> zeroinitializer, ptr %5284, align 4
  %5285 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5286 = getelementptr float, ptr %5285, i64 10772480
  store <4096 x float> zeroinitializer, ptr %5286, align 4
  %5287 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5288 = getelementptr float, ptr %5287, i64 10776576
  store <4096 x float> zeroinitializer, ptr %5288, align 4
  %5289 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5290 = getelementptr float, ptr %5289, i64 10780672
  store <4096 x float> zeroinitializer, ptr %5290, align 4
  %5291 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5292 = getelementptr float, ptr %5291, i64 10784768
  store <4096 x float> zeroinitializer, ptr %5292, align 4
  %5293 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5294 = getelementptr float, ptr %5293, i64 10788864
  store <4096 x float> zeroinitializer, ptr %5294, align 4
  %5295 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5296 = getelementptr float, ptr %5295, i64 10792960
  store <4096 x float> zeroinitializer, ptr %5296, align 4
  %5297 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5298 = getelementptr float, ptr %5297, i64 10797056
  store <4096 x float> zeroinitializer, ptr %5298, align 4
  %5299 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5300 = getelementptr float, ptr %5299, i64 10801152
  store <4096 x float> zeroinitializer, ptr %5300, align 4
  %5301 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5302 = getelementptr float, ptr %5301, i64 10805248
  store <4096 x float> zeroinitializer, ptr %5302, align 4
  %5303 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5304 = getelementptr float, ptr %5303, i64 10809344
  store <4096 x float> zeroinitializer, ptr %5304, align 4
  %5305 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5306 = getelementptr float, ptr %5305, i64 10813440
  store <4096 x float> zeroinitializer, ptr %5306, align 4
  %5307 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5308 = getelementptr float, ptr %5307, i64 10817536
  store <4096 x float> zeroinitializer, ptr %5308, align 4
  %5309 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5310 = getelementptr float, ptr %5309, i64 10821632
  store <4096 x float> zeroinitializer, ptr %5310, align 4
  %5311 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5312 = getelementptr float, ptr %5311, i64 10825728
  store <4096 x float> zeroinitializer, ptr %5312, align 4
  %5313 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5314 = getelementptr float, ptr %5313, i64 10829824
  store <4096 x float> zeroinitializer, ptr %5314, align 4
  %5315 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5316 = getelementptr float, ptr %5315, i64 10833920
  store <4096 x float> zeroinitializer, ptr %5316, align 4
  %5317 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5318 = getelementptr float, ptr %5317, i64 10838016
  store <4096 x float> zeroinitializer, ptr %5318, align 4
  %5319 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5320 = getelementptr float, ptr %5319, i64 10842112
  store <4096 x float> zeroinitializer, ptr %5320, align 4
  %5321 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5322 = getelementptr float, ptr %5321, i64 10846208
  store <4096 x float> zeroinitializer, ptr %5322, align 4
  %5323 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5324 = getelementptr float, ptr %5323, i64 10850304
  store <4096 x float> zeroinitializer, ptr %5324, align 4
  %5325 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5326 = getelementptr float, ptr %5325, i64 10854400
  store <4096 x float> zeroinitializer, ptr %5326, align 4
  %5327 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5328 = getelementptr float, ptr %5327, i64 10858496
  store <4096 x float> zeroinitializer, ptr %5328, align 4
  %5329 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5330 = getelementptr float, ptr %5329, i64 10862592
  store <4096 x float> zeroinitializer, ptr %5330, align 4
  %5331 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5332 = getelementptr float, ptr %5331, i64 10866688
  store <4096 x float> zeroinitializer, ptr %5332, align 4
  %5333 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5334 = getelementptr float, ptr %5333, i64 10870784
  store <4096 x float> zeroinitializer, ptr %5334, align 4
  %5335 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5336 = getelementptr float, ptr %5335, i64 10874880
  store <4096 x float> zeroinitializer, ptr %5336, align 4
  %5337 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5338 = getelementptr float, ptr %5337, i64 10878976
  store <4096 x float> zeroinitializer, ptr %5338, align 4
  %5339 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5340 = getelementptr float, ptr %5339, i64 10883072
  store <4096 x float> zeroinitializer, ptr %5340, align 4
  %5341 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5342 = getelementptr float, ptr %5341, i64 10887168
  store <4096 x float> zeroinitializer, ptr %5342, align 4
  %5343 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5344 = getelementptr float, ptr %5343, i64 10891264
  store <4096 x float> zeroinitializer, ptr %5344, align 4
  %5345 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5346 = getelementptr float, ptr %5345, i64 10895360
  store <4096 x float> zeroinitializer, ptr %5346, align 4
  %5347 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5348 = getelementptr float, ptr %5347, i64 10899456
  store <4096 x float> zeroinitializer, ptr %5348, align 4
  %5349 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5350 = getelementptr float, ptr %5349, i64 10903552
  store <4096 x float> zeroinitializer, ptr %5350, align 4
  %5351 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5352 = getelementptr float, ptr %5351, i64 10907648
  store <4096 x float> zeroinitializer, ptr %5352, align 4
  %5353 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5354 = getelementptr float, ptr %5353, i64 10911744
  store <4096 x float> zeroinitializer, ptr %5354, align 4
  %5355 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5356 = getelementptr float, ptr %5355, i64 10915840
  store <4096 x float> zeroinitializer, ptr %5356, align 4
  %5357 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5358 = getelementptr float, ptr %5357, i64 10919936
  store <4096 x float> zeroinitializer, ptr %5358, align 4
  %5359 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5360 = getelementptr float, ptr %5359, i64 10924032
  store <4096 x float> zeroinitializer, ptr %5360, align 4
  %5361 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5362 = getelementptr float, ptr %5361, i64 10928128
  store <4096 x float> zeroinitializer, ptr %5362, align 4
  %5363 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5364 = getelementptr float, ptr %5363, i64 10932224
  store <4096 x float> zeroinitializer, ptr %5364, align 4
  %5365 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5366 = getelementptr float, ptr %5365, i64 10936320
  store <4096 x float> zeroinitializer, ptr %5366, align 4
  %5367 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5368 = getelementptr float, ptr %5367, i64 10940416
  store <4096 x float> zeroinitializer, ptr %5368, align 4
  %5369 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5370 = getelementptr float, ptr %5369, i64 10944512
  store <4096 x float> zeroinitializer, ptr %5370, align 4
  %5371 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5372 = getelementptr float, ptr %5371, i64 10948608
  store <4096 x float> zeroinitializer, ptr %5372, align 4
  %5373 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5374 = getelementptr float, ptr %5373, i64 10952704
  store <4096 x float> zeroinitializer, ptr %5374, align 4
  %5375 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5376 = getelementptr float, ptr %5375, i64 10956800
  store <4096 x float> zeroinitializer, ptr %5376, align 4
  %5377 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5378 = getelementptr float, ptr %5377, i64 10960896
  store <4096 x float> zeroinitializer, ptr %5378, align 4
  %5379 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5380 = getelementptr float, ptr %5379, i64 10964992
  store <4096 x float> zeroinitializer, ptr %5380, align 4
  %5381 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5382 = getelementptr float, ptr %5381, i64 10969088
  store <4096 x float> zeroinitializer, ptr %5382, align 4
  %5383 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5384 = getelementptr float, ptr %5383, i64 10973184
  store <4096 x float> zeroinitializer, ptr %5384, align 4
  %5385 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5386 = getelementptr float, ptr %5385, i64 10977280
  store <4096 x float> zeroinitializer, ptr %5386, align 4
  %5387 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5388 = getelementptr float, ptr %5387, i64 10981376
  store <4096 x float> zeroinitializer, ptr %5388, align 4
  %5389 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5390 = getelementptr float, ptr %5389, i64 10985472
  store <4096 x float> zeroinitializer, ptr %5390, align 4
  %5391 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5392 = getelementptr float, ptr %5391, i64 10989568
  store <4096 x float> zeroinitializer, ptr %5392, align 4
  %5393 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5394 = getelementptr float, ptr %5393, i64 10993664
  store <4096 x float> zeroinitializer, ptr %5394, align 4
  %5395 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5396 = getelementptr float, ptr %5395, i64 10997760
  store <4096 x float> zeroinitializer, ptr %5396, align 4
  %5397 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5398 = getelementptr float, ptr %5397, i64 11001856
  store <4096 x float> zeroinitializer, ptr %5398, align 4
  %5399 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5400 = getelementptr float, ptr %5399, i64 11005952
  store <4096 x float> zeroinitializer, ptr %5400, align 4
  %5401 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5402 = getelementptr float, ptr %5401, i64 11010048
  store <4096 x float> zeroinitializer, ptr %5402, align 4
  %5403 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5404 = getelementptr float, ptr %5403, i64 11014144
  store <4096 x float> zeroinitializer, ptr %5404, align 4
  %5405 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5406 = getelementptr float, ptr %5405, i64 11018240
  store <4096 x float> zeroinitializer, ptr %5406, align 4
  %5407 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5408 = getelementptr float, ptr %5407, i64 11022336
  store <4096 x float> zeroinitializer, ptr %5408, align 4
  %5409 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5410 = getelementptr float, ptr %5409, i64 11026432
  store <4096 x float> zeroinitializer, ptr %5410, align 4
  %5411 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5412 = getelementptr float, ptr %5411, i64 11030528
  store <4096 x float> zeroinitializer, ptr %5412, align 4
  %5413 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5414 = getelementptr float, ptr %5413, i64 11034624
  store <4096 x float> zeroinitializer, ptr %5414, align 4
  %5415 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5416 = getelementptr float, ptr %5415, i64 11038720
  store <4096 x float> zeroinitializer, ptr %5416, align 4
  %5417 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5418 = getelementptr float, ptr %5417, i64 11042816
  store <4096 x float> zeroinitializer, ptr %5418, align 4
  %5419 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5420 = getelementptr float, ptr %5419, i64 11046912
  store <4096 x float> zeroinitializer, ptr %5420, align 4
  %5421 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5422 = getelementptr float, ptr %5421, i64 11051008
  store <4096 x float> zeroinitializer, ptr %5422, align 4
  %5423 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5424 = getelementptr float, ptr %5423, i64 11055104
  store <4096 x float> zeroinitializer, ptr %5424, align 4
  %5425 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5426 = getelementptr float, ptr %5425, i64 11059200
  store <4096 x float> zeroinitializer, ptr %5426, align 4
  %5427 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5428 = getelementptr float, ptr %5427, i64 11063296
  store <4096 x float> zeroinitializer, ptr %5428, align 4
  %5429 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5430 = getelementptr float, ptr %5429, i64 11067392
  store <4096 x float> zeroinitializer, ptr %5430, align 4
  %5431 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5432 = getelementptr float, ptr %5431, i64 11071488
  store <4096 x float> zeroinitializer, ptr %5432, align 4
  %5433 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5434 = getelementptr float, ptr %5433, i64 11075584
  store <4096 x float> zeroinitializer, ptr %5434, align 4
  %5435 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5436 = getelementptr float, ptr %5435, i64 11079680
  store <4096 x float> zeroinitializer, ptr %5436, align 4
  %5437 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5438 = getelementptr float, ptr %5437, i64 11083776
  store <4096 x float> zeroinitializer, ptr %5438, align 4
  %5439 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5440 = getelementptr float, ptr %5439, i64 11087872
  store <4096 x float> zeroinitializer, ptr %5440, align 4
  %5441 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5442 = getelementptr float, ptr %5441, i64 11091968
  store <4096 x float> zeroinitializer, ptr %5442, align 4
  %5443 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5444 = getelementptr float, ptr %5443, i64 11096064
  store <4096 x float> zeroinitializer, ptr %5444, align 4
  %5445 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5446 = getelementptr float, ptr %5445, i64 11100160
  store <4096 x float> zeroinitializer, ptr %5446, align 4
  %5447 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5448 = getelementptr float, ptr %5447, i64 11104256
  store <4096 x float> zeroinitializer, ptr %5448, align 4
  %5449 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5450 = getelementptr float, ptr %5449, i64 11108352
  store <4096 x float> zeroinitializer, ptr %5450, align 4
  %5451 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5452 = getelementptr float, ptr %5451, i64 11112448
  store <4096 x float> zeroinitializer, ptr %5452, align 4
  %5453 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5454 = getelementptr float, ptr %5453, i64 11116544
  store <4096 x float> zeroinitializer, ptr %5454, align 4
  %5455 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5456 = getelementptr float, ptr %5455, i64 11120640
  store <4096 x float> zeroinitializer, ptr %5456, align 4
  %5457 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5458 = getelementptr float, ptr %5457, i64 11124736
  store <4096 x float> zeroinitializer, ptr %5458, align 4
  %5459 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5460 = getelementptr float, ptr %5459, i64 11128832
  store <4096 x float> zeroinitializer, ptr %5460, align 4
  %5461 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5462 = getelementptr float, ptr %5461, i64 11132928
  store <4096 x float> zeroinitializer, ptr %5462, align 4
  %5463 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5464 = getelementptr float, ptr %5463, i64 11137024
  store <4096 x float> zeroinitializer, ptr %5464, align 4
  %5465 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5466 = getelementptr float, ptr %5465, i64 11141120
  store <4096 x float> zeroinitializer, ptr %5466, align 4
  %5467 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5468 = getelementptr float, ptr %5467, i64 11145216
  store <4096 x float> zeroinitializer, ptr %5468, align 4
  %5469 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5470 = getelementptr float, ptr %5469, i64 11149312
  store <4096 x float> zeroinitializer, ptr %5470, align 4
  %5471 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5472 = getelementptr float, ptr %5471, i64 11153408
  store <4096 x float> zeroinitializer, ptr %5472, align 4
  %5473 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5474 = getelementptr float, ptr %5473, i64 11157504
  store <4096 x float> zeroinitializer, ptr %5474, align 4
  %5475 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5476 = getelementptr float, ptr %5475, i64 11161600
  store <4096 x float> zeroinitializer, ptr %5476, align 4
  %5477 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5478 = getelementptr float, ptr %5477, i64 11165696
  store <4096 x float> zeroinitializer, ptr %5478, align 4
  %5479 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5480 = getelementptr float, ptr %5479, i64 11169792
  store <4096 x float> zeroinitializer, ptr %5480, align 4
  %5481 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5482 = getelementptr float, ptr %5481, i64 11173888
  store <4096 x float> zeroinitializer, ptr %5482, align 4
  %5483 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5484 = getelementptr float, ptr %5483, i64 11177984
  store <4096 x float> zeroinitializer, ptr %5484, align 4
  %5485 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5486 = getelementptr float, ptr %5485, i64 11182080
  store <4096 x float> zeroinitializer, ptr %5486, align 4
  %5487 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5488 = getelementptr float, ptr %5487, i64 11186176
  store <4096 x float> zeroinitializer, ptr %5488, align 4
  %5489 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5490 = getelementptr float, ptr %5489, i64 11190272
  store <4096 x float> zeroinitializer, ptr %5490, align 4
  %5491 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5492 = getelementptr float, ptr %5491, i64 11194368
  store <4096 x float> zeroinitializer, ptr %5492, align 4
  %5493 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5494 = getelementptr float, ptr %5493, i64 11198464
  store <4096 x float> zeroinitializer, ptr %5494, align 4
  %5495 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5496 = getelementptr float, ptr %5495, i64 11202560
  store <4096 x float> zeroinitializer, ptr %5496, align 4
  %5497 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5498 = getelementptr float, ptr %5497, i64 11206656
  store <4096 x float> zeroinitializer, ptr %5498, align 4
  %5499 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5500 = getelementptr float, ptr %5499, i64 11210752
  store <4096 x float> zeroinitializer, ptr %5500, align 4
  %5501 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5502 = getelementptr float, ptr %5501, i64 11214848
  store <4096 x float> zeroinitializer, ptr %5502, align 4
  %5503 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5504 = getelementptr float, ptr %5503, i64 11218944
  store <4096 x float> zeroinitializer, ptr %5504, align 4
  %5505 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5506 = getelementptr float, ptr %5505, i64 11223040
  store <4096 x float> zeroinitializer, ptr %5506, align 4
  %5507 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5508 = getelementptr float, ptr %5507, i64 11227136
  store <4096 x float> zeroinitializer, ptr %5508, align 4
  %5509 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5510 = getelementptr float, ptr %5509, i64 11231232
  store <4096 x float> zeroinitializer, ptr %5510, align 4
  %5511 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5512 = getelementptr float, ptr %5511, i64 11235328
  store <4096 x float> zeroinitializer, ptr %5512, align 4
  %5513 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5514 = getelementptr float, ptr %5513, i64 11239424
  store <4096 x float> zeroinitializer, ptr %5514, align 4
  %5515 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5516 = getelementptr float, ptr %5515, i64 11243520
  store <4096 x float> zeroinitializer, ptr %5516, align 4
  %5517 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5518 = getelementptr float, ptr %5517, i64 11247616
  store <4096 x float> zeroinitializer, ptr %5518, align 4
  %5519 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5520 = getelementptr float, ptr %5519, i64 11251712
  store <4096 x float> zeroinitializer, ptr %5520, align 4
  %5521 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5522 = getelementptr float, ptr %5521, i64 11255808
  store <4096 x float> zeroinitializer, ptr %5522, align 4
  %5523 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5524 = getelementptr float, ptr %5523, i64 11259904
  store <4096 x float> zeroinitializer, ptr %5524, align 4
  %5525 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5526 = getelementptr float, ptr %5525, i64 11264000
  store <4096 x float> zeroinitializer, ptr %5526, align 4
  %5527 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5528 = getelementptr float, ptr %5527, i64 11268096
  store <4096 x float> zeroinitializer, ptr %5528, align 4
  %5529 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5530 = getelementptr float, ptr %5529, i64 11272192
  store <4096 x float> zeroinitializer, ptr %5530, align 4
  %5531 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5532 = getelementptr float, ptr %5531, i64 11276288
  store <4096 x float> zeroinitializer, ptr %5532, align 4
  %5533 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5534 = getelementptr float, ptr %5533, i64 11280384
  store <4096 x float> zeroinitializer, ptr %5534, align 4
  %5535 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5536 = getelementptr float, ptr %5535, i64 11284480
  store <4096 x float> zeroinitializer, ptr %5536, align 4
  %5537 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5538 = getelementptr float, ptr %5537, i64 11288576
  store <4096 x float> zeroinitializer, ptr %5538, align 4
  %5539 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5540 = getelementptr float, ptr %5539, i64 11292672
  store <4096 x float> zeroinitializer, ptr %5540, align 4
  %5541 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5542 = getelementptr float, ptr %5541, i64 11296768
  store <4096 x float> zeroinitializer, ptr %5542, align 4
  %5543 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5544 = getelementptr float, ptr %5543, i64 11300864
  store <4096 x float> zeroinitializer, ptr %5544, align 4
  %5545 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5546 = getelementptr float, ptr %5545, i64 11304960
  store <4096 x float> zeroinitializer, ptr %5546, align 4
  %5547 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5548 = getelementptr float, ptr %5547, i64 11309056
  store <4096 x float> zeroinitializer, ptr %5548, align 4
  %5549 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5550 = getelementptr float, ptr %5549, i64 11313152
  store <4096 x float> zeroinitializer, ptr %5550, align 4
  %5551 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5552 = getelementptr float, ptr %5551, i64 11317248
  store <4096 x float> zeroinitializer, ptr %5552, align 4
  %5553 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5554 = getelementptr float, ptr %5553, i64 11321344
  store <4096 x float> zeroinitializer, ptr %5554, align 4
  %5555 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5556 = getelementptr float, ptr %5555, i64 11325440
  store <4096 x float> zeroinitializer, ptr %5556, align 4
  %5557 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5558 = getelementptr float, ptr %5557, i64 11329536
  store <4096 x float> zeroinitializer, ptr %5558, align 4
  %5559 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5560 = getelementptr float, ptr %5559, i64 11333632
  store <4096 x float> zeroinitializer, ptr %5560, align 4
  %5561 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5562 = getelementptr float, ptr %5561, i64 11337728
  store <4096 x float> zeroinitializer, ptr %5562, align 4
  %5563 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5564 = getelementptr float, ptr %5563, i64 11341824
  store <4096 x float> zeroinitializer, ptr %5564, align 4
  %5565 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5566 = getelementptr float, ptr %5565, i64 11345920
  store <4096 x float> zeroinitializer, ptr %5566, align 4
  %5567 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5568 = getelementptr float, ptr %5567, i64 11350016
  store <4096 x float> zeroinitializer, ptr %5568, align 4
  %5569 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5570 = getelementptr float, ptr %5569, i64 11354112
  store <4096 x float> zeroinitializer, ptr %5570, align 4
  %5571 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5572 = getelementptr float, ptr %5571, i64 11358208
  store <4096 x float> zeroinitializer, ptr %5572, align 4
  %5573 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5574 = getelementptr float, ptr %5573, i64 11362304
  store <4096 x float> zeroinitializer, ptr %5574, align 4
  %5575 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5576 = getelementptr float, ptr %5575, i64 11366400
  store <4096 x float> zeroinitializer, ptr %5576, align 4
  %5577 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5578 = getelementptr float, ptr %5577, i64 11370496
  store <4096 x float> zeroinitializer, ptr %5578, align 4
  %5579 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5580 = getelementptr float, ptr %5579, i64 11374592
  store <4096 x float> zeroinitializer, ptr %5580, align 4
  %5581 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5582 = getelementptr float, ptr %5581, i64 11378688
  store <4096 x float> zeroinitializer, ptr %5582, align 4
  %5583 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5584 = getelementptr float, ptr %5583, i64 11382784
  store <4096 x float> zeroinitializer, ptr %5584, align 4
  %5585 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5586 = getelementptr float, ptr %5585, i64 11386880
  store <4096 x float> zeroinitializer, ptr %5586, align 4
  %5587 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5588 = getelementptr float, ptr %5587, i64 11390976
  store <4096 x float> zeroinitializer, ptr %5588, align 4
  %5589 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5590 = getelementptr float, ptr %5589, i64 11395072
  store <4096 x float> zeroinitializer, ptr %5590, align 4
  %5591 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5592 = getelementptr float, ptr %5591, i64 11399168
  store <4096 x float> zeroinitializer, ptr %5592, align 4
  %5593 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5594 = getelementptr float, ptr %5593, i64 11403264
  store <4096 x float> zeroinitializer, ptr %5594, align 4
  %5595 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5596 = getelementptr float, ptr %5595, i64 11407360
  store <4096 x float> zeroinitializer, ptr %5596, align 4
  %5597 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5598 = getelementptr float, ptr %5597, i64 11411456
  store <4096 x float> zeroinitializer, ptr %5598, align 4
  %5599 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5600 = getelementptr float, ptr %5599, i64 11415552
  store <4096 x float> zeroinitializer, ptr %5600, align 4
  %5601 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5602 = getelementptr float, ptr %5601, i64 11419648
  store <4096 x float> zeroinitializer, ptr %5602, align 4
  %5603 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5604 = getelementptr float, ptr %5603, i64 11423744
  store <4096 x float> zeroinitializer, ptr %5604, align 4
  %5605 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5606 = getelementptr float, ptr %5605, i64 11427840
  store <4096 x float> zeroinitializer, ptr %5606, align 4
  %5607 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5608 = getelementptr float, ptr %5607, i64 11431936
  store <4096 x float> zeroinitializer, ptr %5608, align 4
  %5609 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5610 = getelementptr float, ptr %5609, i64 11436032
  store <4096 x float> zeroinitializer, ptr %5610, align 4
  %5611 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5612 = getelementptr float, ptr %5611, i64 11440128
  store <4096 x float> zeroinitializer, ptr %5612, align 4
  %5613 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5614 = getelementptr float, ptr %5613, i64 11444224
  store <4096 x float> zeroinitializer, ptr %5614, align 4
  %5615 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5616 = getelementptr float, ptr %5615, i64 11448320
  store <4096 x float> zeroinitializer, ptr %5616, align 4
  %5617 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5618 = getelementptr float, ptr %5617, i64 11452416
  store <4096 x float> zeroinitializer, ptr %5618, align 4
  %5619 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5620 = getelementptr float, ptr %5619, i64 11456512
  store <4096 x float> zeroinitializer, ptr %5620, align 4
  %5621 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5622 = getelementptr float, ptr %5621, i64 11460608
  store <4096 x float> zeroinitializer, ptr %5622, align 4
  %5623 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5624 = getelementptr float, ptr %5623, i64 11464704
  store <4096 x float> zeroinitializer, ptr %5624, align 4
  %5625 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5626 = getelementptr float, ptr %5625, i64 11468800
  store <4096 x float> zeroinitializer, ptr %5626, align 4
  %5627 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5628 = getelementptr float, ptr %5627, i64 11472896
  store <4096 x float> zeroinitializer, ptr %5628, align 4
  %5629 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5630 = getelementptr float, ptr %5629, i64 11476992
  store <4096 x float> zeroinitializer, ptr %5630, align 4
  %5631 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5632 = getelementptr float, ptr %5631, i64 11481088
  store <4096 x float> zeroinitializer, ptr %5632, align 4
  %5633 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5634 = getelementptr float, ptr %5633, i64 11485184
  store <4096 x float> zeroinitializer, ptr %5634, align 4
  %5635 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5636 = getelementptr float, ptr %5635, i64 11489280
  store <4096 x float> zeroinitializer, ptr %5636, align 4
  %5637 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5638 = getelementptr float, ptr %5637, i64 11493376
  store <4096 x float> zeroinitializer, ptr %5638, align 4
  %5639 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5640 = getelementptr float, ptr %5639, i64 11497472
  store <4096 x float> zeroinitializer, ptr %5640, align 4
  %5641 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5642 = getelementptr float, ptr %5641, i64 11501568
  store <4096 x float> zeroinitializer, ptr %5642, align 4
  %5643 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5644 = getelementptr float, ptr %5643, i64 11505664
  store <4096 x float> zeroinitializer, ptr %5644, align 4
  %5645 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5646 = getelementptr float, ptr %5645, i64 11509760
  store <4096 x float> zeroinitializer, ptr %5646, align 4
  %5647 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5648 = getelementptr float, ptr %5647, i64 11513856
  store <4096 x float> zeroinitializer, ptr %5648, align 4
  %5649 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5650 = getelementptr float, ptr %5649, i64 11517952
  store <4096 x float> zeroinitializer, ptr %5650, align 4
  %5651 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5652 = getelementptr float, ptr %5651, i64 11522048
  store <4096 x float> zeroinitializer, ptr %5652, align 4
  %5653 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5654 = getelementptr float, ptr %5653, i64 11526144
  store <4096 x float> zeroinitializer, ptr %5654, align 4
  %5655 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5656 = getelementptr float, ptr %5655, i64 11530240
  store <4096 x float> zeroinitializer, ptr %5656, align 4
  %5657 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5658 = getelementptr float, ptr %5657, i64 11534336
  store <4096 x float> zeroinitializer, ptr %5658, align 4
  %5659 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5660 = getelementptr float, ptr %5659, i64 11538432
  store <4096 x float> zeroinitializer, ptr %5660, align 4
  %5661 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5662 = getelementptr float, ptr %5661, i64 11542528
  store <4096 x float> zeroinitializer, ptr %5662, align 4
  %5663 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5664 = getelementptr float, ptr %5663, i64 11546624
  store <4096 x float> zeroinitializer, ptr %5664, align 4
  %5665 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5666 = getelementptr float, ptr %5665, i64 11550720
  store <4096 x float> zeroinitializer, ptr %5666, align 4
  %5667 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5668 = getelementptr float, ptr %5667, i64 11554816
  store <4096 x float> zeroinitializer, ptr %5668, align 4
  %5669 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5670 = getelementptr float, ptr %5669, i64 11558912
  store <4096 x float> zeroinitializer, ptr %5670, align 4
  %5671 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5672 = getelementptr float, ptr %5671, i64 11563008
  store <4096 x float> zeroinitializer, ptr %5672, align 4
  %5673 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5674 = getelementptr float, ptr %5673, i64 11567104
  store <4096 x float> zeroinitializer, ptr %5674, align 4
  %5675 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5676 = getelementptr float, ptr %5675, i64 11571200
  store <4096 x float> zeroinitializer, ptr %5676, align 4
  %5677 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5678 = getelementptr float, ptr %5677, i64 11575296
  store <4096 x float> zeroinitializer, ptr %5678, align 4
  %5679 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5680 = getelementptr float, ptr %5679, i64 11579392
  store <4096 x float> zeroinitializer, ptr %5680, align 4
  %5681 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5682 = getelementptr float, ptr %5681, i64 11583488
  store <4096 x float> zeroinitializer, ptr %5682, align 4
  %5683 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5684 = getelementptr float, ptr %5683, i64 11587584
  store <4096 x float> zeroinitializer, ptr %5684, align 4
  %5685 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5686 = getelementptr float, ptr %5685, i64 11591680
  store <4096 x float> zeroinitializer, ptr %5686, align 4
  %5687 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5688 = getelementptr float, ptr %5687, i64 11595776
  store <4096 x float> zeroinitializer, ptr %5688, align 4
  %5689 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5690 = getelementptr float, ptr %5689, i64 11599872
  store <4096 x float> zeroinitializer, ptr %5690, align 4
  %5691 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5692 = getelementptr float, ptr %5691, i64 11603968
  store <4096 x float> zeroinitializer, ptr %5692, align 4
  %5693 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5694 = getelementptr float, ptr %5693, i64 11608064
  store <4096 x float> zeroinitializer, ptr %5694, align 4
  %5695 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5696 = getelementptr float, ptr %5695, i64 11612160
  store <4096 x float> zeroinitializer, ptr %5696, align 4
  %5697 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5698 = getelementptr float, ptr %5697, i64 11616256
  store <4096 x float> zeroinitializer, ptr %5698, align 4
  %5699 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5700 = getelementptr float, ptr %5699, i64 11620352
  store <4096 x float> zeroinitializer, ptr %5700, align 4
  %5701 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5702 = getelementptr float, ptr %5701, i64 11624448
  store <4096 x float> zeroinitializer, ptr %5702, align 4
  %5703 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5704 = getelementptr float, ptr %5703, i64 11628544
  store <4096 x float> zeroinitializer, ptr %5704, align 4
  %5705 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5706 = getelementptr float, ptr %5705, i64 11632640
  store <4096 x float> zeroinitializer, ptr %5706, align 4
  %5707 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5708 = getelementptr float, ptr %5707, i64 11636736
  store <4096 x float> zeroinitializer, ptr %5708, align 4
  %5709 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5710 = getelementptr float, ptr %5709, i64 11640832
  store <4096 x float> zeroinitializer, ptr %5710, align 4
  %5711 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5712 = getelementptr float, ptr %5711, i64 11644928
  store <4096 x float> zeroinitializer, ptr %5712, align 4
  %5713 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5714 = getelementptr float, ptr %5713, i64 11649024
  store <4096 x float> zeroinitializer, ptr %5714, align 4
  %5715 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5716 = getelementptr float, ptr %5715, i64 11653120
  store <4096 x float> zeroinitializer, ptr %5716, align 4
  %5717 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5718 = getelementptr float, ptr %5717, i64 11657216
  store <4096 x float> zeroinitializer, ptr %5718, align 4
  %5719 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5720 = getelementptr float, ptr %5719, i64 11661312
  store <4096 x float> zeroinitializer, ptr %5720, align 4
  %5721 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5722 = getelementptr float, ptr %5721, i64 11665408
  store <4096 x float> zeroinitializer, ptr %5722, align 4
  %5723 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5724 = getelementptr float, ptr %5723, i64 11669504
  store <4096 x float> zeroinitializer, ptr %5724, align 4
  %5725 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5726 = getelementptr float, ptr %5725, i64 11673600
  store <4096 x float> zeroinitializer, ptr %5726, align 4
  %5727 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5728 = getelementptr float, ptr %5727, i64 11677696
  store <4096 x float> zeroinitializer, ptr %5728, align 4
  %5729 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5730 = getelementptr float, ptr %5729, i64 11681792
  store <4096 x float> zeroinitializer, ptr %5730, align 4
  %5731 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5732 = getelementptr float, ptr %5731, i64 11685888
  store <4096 x float> zeroinitializer, ptr %5732, align 4
  %5733 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5734 = getelementptr float, ptr %5733, i64 11689984
  store <4096 x float> zeroinitializer, ptr %5734, align 4
  %5735 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5736 = getelementptr float, ptr %5735, i64 11694080
  store <4096 x float> zeroinitializer, ptr %5736, align 4
  %5737 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5738 = getelementptr float, ptr %5737, i64 11698176
  store <4096 x float> zeroinitializer, ptr %5738, align 4
  %5739 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5740 = getelementptr float, ptr %5739, i64 11702272
  store <4096 x float> zeroinitializer, ptr %5740, align 4
  %5741 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5742 = getelementptr float, ptr %5741, i64 11706368
  store <4096 x float> zeroinitializer, ptr %5742, align 4
  %5743 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5744 = getelementptr float, ptr %5743, i64 11710464
  store <4096 x float> zeroinitializer, ptr %5744, align 4
  %5745 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5746 = getelementptr float, ptr %5745, i64 11714560
  store <4096 x float> zeroinitializer, ptr %5746, align 4
  %5747 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5748 = getelementptr float, ptr %5747, i64 11718656
  store <4096 x float> zeroinitializer, ptr %5748, align 4
  %5749 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5750 = getelementptr float, ptr %5749, i64 11722752
  store <4096 x float> zeroinitializer, ptr %5750, align 4
  %5751 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5752 = getelementptr float, ptr %5751, i64 11726848
  store <4096 x float> zeroinitializer, ptr %5752, align 4
  %5753 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5754 = getelementptr float, ptr %5753, i64 11730944
  store <4096 x float> zeroinitializer, ptr %5754, align 4
  %5755 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5756 = getelementptr float, ptr %5755, i64 11735040
  store <4096 x float> zeroinitializer, ptr %5756, align 4
  %5757 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5758 = getelementptr float, ptr %5757, i64 11739136
  store <4096 x float> zeroinitializer, ptr %5758, align 4
  %5759 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5760 = getelementptr float, ptr %5759, i64 11743232
  store <4096 x float> zeroinitializer, ptr %5760, align 4
  %5761 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5762 = getelementptr float, ptr %5761, i64 11747328
  store <4096 x float> zeroinitializer, ptr %5762, align 4
  %5763 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5764 = getelementptr float, ptr %5763, i64 11751424
  store <4096 x float> zeroinitializer, ptr %5764, align 4
  %5765 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5766 = getelementptr float, ptr %5765, i64 11755520
  store <4096 x float> zeroinitializer, ptr %5766, align 4
  %5767 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5768 = getelementptr float, ptr %5767, i64 11759616
  store <4096 x float> zeroinitializer, ptr %5768, align 4
  %5769 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5770 = getelementptr float, ptr %5769, i64 11763712
  store <4096 x float> zeroinitializer, ptr %5770, align 4
  %5771 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5772 = getelementptr float, ptr %5771, i64 11767808
  store <4096 x float> zeroinitializer, ptr %5772, align 4
  %5773 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5774 = getelementptr float, ptr %5773, i64 11771904
  store <4096 x float> zeroinitializer, ptr %5774, align 4
  %5775 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5776 = getelementptr float, ptr %5775, i64 11776000
  store <4096 x float> zeroinitializer, ptr %5776, align 4
  %5777 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5778 = getelementptr float, ptr %5777, i64 11780096
  store <4096 x float> zeroinitializer, ptr %5778, align 4
  %5779 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5780 = getelementptr float, ptr %5779, i64 11784192
  store <4096 x float> zeroinitializer, ptr %5780, align 4
  %5781 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5782 = getelementptr float, ptr %5781, i64 11788288
  store <4096 x float> zeroinitializer, ptr %5782, align 4
  %5783 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5784 = getelementptr float, ptr %5783, i64 11792384
  store <4096 x float> zeroinitializer, ptr %5784, align 4
  %5785 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5786 = getelementptr float, ptr %5785, i64 11796480
  store <4096 x float> zeroinitializer, ptr %5786, align 4
  %5787 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5788 = getelementptr float, ptr %5787, i64 11800576
  store <4096 x float> zeroinitializer, ptr %5788, align 4
  %5789 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5790 = getelementptr float, ptr %5789, i64 11804672
  store <4096 x float> zeroinitializer, ptr %5790, align 4
  %5791 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5792 = getelementptr float, ptr %5791, i64 11808768
  store <4096 x float> zeroinitializer, ptr %5792, align 4
  %5793 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5794 = getelementptr float, ptr %5793, i64 11812864
  store <4096 x float> zeroinitializer, ptr %5794, align 4
  %5795 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5796 = getelementptr float, ptr %5795, i64 11816960
  store <4096 x float> zeroinitializer, ptr %5796, align 4
  %5797 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5798 = getelementptr float, ptr %5797, i64 11821056
  store <4096 x float> zeroinitializer, ptr %5798, align 4
  %5799 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5800 = getelementptr float, ptr %5799, i64 11825152
  store <4096 x float> zeroinitializer, ptr %5800, align 4
  %5801 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5802 = getelementptr float, ptr %5801, i64 11829248
  store <4096 x float> zeroinitializer, ptr %5802, align 4
  %5803 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5804 = getelementptr float, ptr %5803, i64 11833344
  store <4096 x float> zeroinitializer, ptr %5804, align 4
  %5805 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5806 = getelementptr float, ptr %5805, i64 11837440
  store <4096 x float> zeroinitializer, ptr %5806, align 4
  %5807 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5808 = getelementptr float, ptr %5807, i64 11841536
  store <4096 x float> zeroinitializer, ptr %5808, align 4
  %5809 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5810 = getelementptr float, ptr %5809, i64 11845632
  store <4096 x float> zeroinitializer, ptr %5810, align 4
  %5811 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5812 = getelementptr float, ptr %5811, i64 11849728
  store <4096 x float> zeroinitializer, ptr %5812, align 4
  %5813 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5814 = getelementptr float, ptr %5813, i64 11853824
  store <4096 x float> zeroinitializer, ptr %5814, align 4
  %5815 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5816 = getelementptr float, ptr %5815, i64 11857920
  store <4096 x float> zeroinitializer, ptr %5816, align 4
  %5817 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5818 = getelementptr float, ptr %5817, i64 11862016
  store <4096 x float> zeroinitializer, ptr %5818, align 4
  %5819 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5820 = getelementptr float, ptr %5819, i64 11866112
  store <4096 x float> zeroinitializer, ptr %5820, align 4
  %5821 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5822 = getelementptr float, ptr %5821, i64 11870208
  store <4096 x float> zeroinitializer, ptr %5822, align 4
  %5823 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5824 = getelementptr float, ptr %5823, i64 11874304
  store <4096 x float> zeroinitializer, ptr %5824, align 4
  %5825 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5826 = getelementptr float, ptr %5825, i64 11878400
  store <4096 x float> zeroinitializer, ptr %5826, align 4
  %5827 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5828 = getelementptr float, ptr %5827, i64 11882496
  store <4096 x float> zeroinitializer, ptr %5828, align 4
  %5829 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5830 = getelementptr float, ptr %5829, i64 11886592
  store <4096 x float> zeroinitializer, ptr %5830, align 4
  %5831 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5832 = getelementptr float, ptr %5831, i64 11890688
  store <4096 x float> zeroinitializer, ptr %5832, align 4
  %5833 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5834 = getelementptr float, ptr %5833, i64 11894784
  store <4096 x float> zeroinitializer, ptr %5834, align 4
  %5835 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5836 = getelementptr float, ptr %5835, i64 11898880
  store <4096 x float> zeroinitializer, ptr %5836, align 4
  %5837 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5838 = getelementptr float, ptr %5837, i64 11902976
  store <4096 x float> zeroinitializer, ptr %5838, align 4
  %5839 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5840 = getelementptr float, ptr %5839, i64 11907072
  store <4096 x float> zeroinitializer, ptr %5840, align 4
  %5841 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5842 = getelementptr float, ptr %5841, i64 11911168
  store <4096 x float> zeroinitializer, ptr %5842, align 4
  %5843 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5844 = getelementptr float, ptr %5843, i64 11915264
  store <4096 x float> zeroinitializer, ptr %5844, align 4
  %5845 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5846 = getelementptr float, ptr %5845, i64 11919360
  store <4096 x float> zeroinitializer, ptr %5846, align 4
  %5847 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5848 = getelementptr float, ptr %5847, i64 11923456
  store <4096 x float> zeroinitializer, ptr %5848, align 4
  %5849 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5850 = getelementptr float, ptr %5849, i64 11927552
  store <4096 x float> zeroinitializer, ptr %5850, align 4
  %5851 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5852 = getelementptr float, ptr %5851, i64 11931648
  store <4096 x float> zeroinitializer, ptr %5852, align 4
  %5853 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5854 = getelementptr float, ptr %5853, i64 11935744
  store <4096 x float> zeroinitializer, ptr %5854, align 4
  %5855 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5856 = getelementptr float, ptr %5855, i64 11939840
  store <4096 x float> zeroinitializer, ptr %5856, align 4
  %5857 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5858 = getelementptr float, ptr %5857, i64 11943936
  store <4096 x float> zeroinitializer, ptr %5858, align 4
  %5859 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5860 = getelementptr float, ptr %5859, i64 11948032
  store <4096 x float> zeroinitializer, ptr %5860, align 4
  %5861 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5862 = getelementptr float, ptr %5861, i64 11952128
  store <4096 x float> zeroinitializer, ptr %5862, align 4
  %5863 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5864 = getelementptr float, ptr %5863, i64 11956224
  store <4096 x float> zeroinitializer, ptr %5864, align 4
  %5865 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5866 = getelementptr float, ptr %5865, i64 11960320
  store <4096 x float> zeroinitializer, ptr %5866, align 4
  %5867 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5868 = getelementptr float, ptr %5867, i64 11964416
  store <4096 x float> zeroinitializer, ptr %5868, align 4
  %5869 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5870 = getelementptr float, ptr %5869, i64 11968512
  store <4096 x float> zeroinitializer, ptr %5870, align 4
  %5871 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5872 = getelementptr float, ptr %5871, i64 11972608
  store <4096 x float> zeroinitializer, ptr %5872, align 4
  %5873 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5874 = getelementptr float, ptr %5873, i64 11976704
  store <4096 x float> zeroinitializer, ptr %5874, align 4
  %5875 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5876 = getelementptr float, ptr %5875, i64 11980800
  store <4096 x float> zeroinitializer, ptr %5876, align 4
  %5877 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5878 = getelementptr float, ptr %5877, i64 11984896
  store <4096 x float> zeroinitializer, ptr %5878, align 4
  %5879 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5880 = getelementptr float, ptr %5879, i64 11988992
  store <4096 x float> zeroinitializer, ptr %5880, align 4
  %5881 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5882 = getelementptr float, ptr %5881, i64 11993088
  store <4096 x float> zeroinitializer, ptr %5882, align 4
  %5883 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5884 = getelementptr float, ptr %5883, i64 11997184
  store <4096 x float> zeroinitializer, ptr %5884, align 4
  %5885 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5886 = getelementptr float, ptr %5885, i64 12001280
  store <4096 x float> zeroinitializer, ptr %5886, align 4
  %5887 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5888 = getelementptr float, ptr %5887, i64 12005376
  store <4096 x float> zeroinitializer, ptr %5888, align 4
  %5889 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5890 = getelementptr float, ptr %5889, i64 12009472
  store <4096 x float> zeroinitializer, ptr %5890, align 4
  %5891 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5892 = getelementptr float, ptr %5891, i64 12013568
  store <4096 x float> zeroinitializer, ptr %5892, align 4
  %5893 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5894 = getelementptr float, ptr %5893, i64 12017664
  store <4096 x float> zeroinitializer, ptr %5894, align 4
  %5895 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5896 = getelementptr float, ptr %5895, i64 12021760
  store <4096 x float> zeroinitializer, ptr %5896, align 4
  %5897 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5898 = getelementptr float, ptr %5897, i64 12025856
  store <4096 x float> zeroinitializer, ptr %5898, align 4
  %5899 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5900 = getelementptr float, ptr %5899, i64 12029952
  store <4096 x float> zeroinitializer, ptr %5900, align 4
  %5901 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5902 = getelementptr float, ptr %5901, i64 12034048
  store <4096 x float> zeroinitializer, ptr %5902, align 4
  %5903 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5904 = getelementptr float, ptr %5903, i64 12038144
  store <4096 x float> zeroinitializer, ptr %5904, align 4
  %5905 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5906 = getelementptr float, ptr %5905, i64 12042240
  store <4096 x float> zeroinitializer, ptr %5906, align 4
  %5907 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5908 = getelementptr float, ptr %5907, i64 12046336
  store <4096 x float> zeroinitializer, ptr %5908, align 4
  %5909 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5910 = getelementptr float, ptr %5909, i64 12050432
  store <4096 x float> zeroinitializer, ptr %5910, align 4
  %5911 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5912 = getelementptr float, ptr %5911, i64 12054528
  store <4096 x float> zeroinitializer, ptr %5912, align 4
  %5913 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5914 = getelementptr float, ptr %5913, i64 12058624
  store <4096 x float> zeroinitializer, ptr %5914, align 4
  %5915 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5916 = getelementptr float, ptr %5915, i64 12062720
  store <4096 x float> zeroinitializer, ptr %5916, align 4
  %5917 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5918 = getelementptr float, ptr %5917, i64 12066816
  store <4096 x float> zeroinitializer, ptr %5918, align 4
  %5919 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5920 = getelementptr float, ptr %5919, i64 12070912
  store <4096 x float> zeroinitializer, ptr %5920, align 4
  %5921 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5922 = getelementptr float, ptr %5921, i64 12075008
  store <4096 x float> zeroinitializer, ptr %5922, align 4
  %5923 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5924 = getelementptr float, ptr %5923, i64 12079104
  store <4096 x float> zeroinitializer, ptr %5924, align 4
  %5925 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5926 = getelementptr float, ptr %5925, i64 12083200
  store <4096 x float> zeroinitializer, ptr %5926, align 4
  %5927 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5928 = getelementptr float, ptr %5927, i64 12087296
  store <4096 x float> zeroinitializer, ptr %5928, align 4
  %5929 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5930 = getelementptr float, ptr %5929, i64 12091392
  store <4096 x float> zeroinitializer, ptr %5930, align 4
  %5931 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5932 = getelementptr float, ptr %5931, i64 12095488
  store <4096 x float> zeroinitializer, ptr %5932, align 4
  %5933 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5934 = getelementptr float, ptr %5933, i64 12099584
  store <4096 x float> zeroinitializer, ptr %5934, align 4
  %5935 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5936 = getelementptr float, ptr %5935, i64 12103680
  store <4096 x float> zeroinitializer, ptr %5936, align 4
  %5937 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5938 = getelementptr float, ptr %5937, i64 12107776
  store <4096 x float> zeroinitializer, ptr %5938, align 4
  %5939 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5940 = getelementptr float, ptr %5939, i64 12111872
  store <4096 x float> zeroinitializer, ptr %5940, align 4
  %5941 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5942 = getelementptr float, ptr %5941, i64 12115968
  store <4096 x float> zeroinitializer, ptr %5942, align 4
  %5943 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5944 = getelementptr float, ptr %5943, i64 12120064
  store <4096 x float> zeroinitializer, ptr %5944, align 4
  %5945 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5946 = getelementptr float, ptr %5945, i64 12124160
  store <4096 x float> zeroinitializer, ptr %5946, align 4
  %5947 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5948 = getelementptr float, ptr %5947, i64 12128256
  store <4096 x float> zeroinitializer, ptr %5948, align 4
  %5949 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5950 = getelementptr float, ptr %5949, i64 12132352
  store <4096 x float> zeroinitializer, ptr %5950, align 4
  %5951 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5952 = getelementptr float, ptr %5951, i64 12136448
  store <4096 x float> zeroinitializer, ptr %5952, align 4
  %5953 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5954 = getelementptr float, ptr %5953, i64 12140544
  store <4096 x float> zeroinitializer, ptr %5954, align 4
  %5955 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5956 = getelementptr float, ptr %5955, i64 12144640
  store <4096 x float> zeroinitializer, ptr %5956, align 4
  %5957 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5958 = getelementptr float, ptr %5957, i64 12148736
  store <4096 x float> zeroinitializer, ptr %5958, align 4
  %5959 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5960 = getelementptr float, ptr %5959, i64 12152832
  store <4096 x float> zeroinitializer, ptr %5960, align 4
  %5961 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5962 = getelementptr float, ptr %5961, i64 12156928
  store <4096 x float> zeroinitializer, ptr %5962, align 4
  %5963 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5964 = getelementptr float, ptr %5963, i64 12161024
  store <4096 x float> zeroinitializer, ptr %5964, align 4
  %5965 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5966 = getelementptr float, ptr %5965, i64 12165120
  store <4096 x float> zeroinitializer, ptr %5966, align 4
  %5967 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5968 = getelementptr float, ptr %5967, i64 12169216
  store <4096 x float> zeroinitializer, ptr %5968, align 4
  %5969 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5970 = getelementptr float, ptr %5969, i64 12173312
  store <4096 x float> zeroinitializer, ptr %5970, align 4
  %5971 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5972 = getelementptr float, ptr %5971, i64 12177408
  store <4096 x float> zeroinitializer, ptr %5972, align 4
  %5973 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5974 = getelementptr float, ptr %5973, i64 12181504
  store <4096 x float> zeroinitializer, ptr %5974, align 4
  %5975 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5976 = getelementptr float, ptr %5975, i64 12185600
  store <4096 x float> zeroinitializer, ptr %5976, align 4
  %5977 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5978 = getelementptr float, ptr %5977, i64 12189696
  store <4096 x float> zeroinitializer, ptr %5978, align 4
  %5979 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5980 = getelementptr float, ptr %5979, i64 12193792
  store <4096 x float> zeroinitializer, ptr %5980, align 4
  %5981 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5982 = getelementptr float, ptr %5981, i64 12197888
  store <4096 x float> zeroinitializer, ptr %5982, align 4
  %5983 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5984 = getelementptr float, ptr %5983, i64 12201984
  store <4096 x float> zeroinitializer, ptr %5984, align 4
  %5985 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5986 = getelementptr float, ptr %5985, i64 12206080
  store <4096 x float> zeroinitializer, ptr %5986, align 4
  %5987 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5988 = getelementptr float, ptr %5987, i64 12210176
  store <4096 x float> zeroinitializer, ptr %5988, align 4
  %5989 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5990 = getelementptr float, ptr %5989, i64 12214272
  store <4096 x float> zeroinitializer, ptr %5990, align 4
  %5991 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5992 = getelementptr float, ptr %5991, i64 12218368
  store <4096 x float> zeroinitializer, ptr %5992, align 4
  %5993 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5994 = getelementptr float, ptr %5993, i64 12222464
  store <4096 x float> zeroinitializer, ptr %5994, align 4
  %5995 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5996 = getelementptr float, ptr %5995, i64 12226560
  store <4096 x float> zeroinitializer, ptr %5996, align 4
  %5997 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %5998 = getelementptr float, ptr %5997, i64 12230656
  store <4096 x float> zeroinitializer, ptr %5998, align 4
  %5999 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6000 = getelementptr float, ptr %5999, i64 12234752
  store <4096 x float> zeroinitializer, ptr %6000, align 4
  %6001 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6002 = getelementptr float, ptr %6001, i64 12238848
  store <4096 x float> zeroinitializer, ptr %6002, align 4
  %6003 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6004 = getelementptr float, ptr %6003, i64 12242944
  store <4096 x float> zeroinitializer, ptr %6004, align 4
  %6005 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6006 = getelementptr float, ptr %6005, i64 12247040
  store <4096 x float> zeroinitializer, ptr %6006, align 4
  %6007 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6008 = getelementptr float, ptr %6007, i64 12251136
  store <4096 x float> zeroinitializer, ptr %6008, align 4
  %6009 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6010 = getelementptr float, ptr %6009, i64 12255232
  store <4096 x float> zeroinitializer, ptr %6010, align 4
  %6011 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6012 = getelementptr float, ptr %6011, i64 12259328
  store <4096 x float> zeroinitializer, ptr %6012, align 4
  %6013 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6014 = getelementptr float, ptr %6013, i64 12263424
  store <4096 x float> zeroinitializer, ptr %6014, align 4
  %6015 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6016 = getelementptr float, ptr %6015, i64 12267520
  store <4096 x float> zeroinitializer, ptr %6016, align 4
  %6017 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6018 = getelementptr float, ptr %6017, i64 12271616
  store <4096 x float> zeroinitializer, ptr %6018, align 4
  %6019 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6020 = getelementptr float, ptr %6019, i64 12275712
  store <4096 x float> zeroinitializer, ptr %6020, align 4
  %6021 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6022 = getelementptr float, ptr %6021, i64 12279808
  store <4096 x float> zeroinitializer, ptr %6022, align 4
  %6023 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6024 = getelementptr float, ptr %6023, i64 12283904
  store <4096 x float> zeroinitializer, ptr %6024, align 4
  %6025 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6026 = getelementptr float, ptr %6025, i64 12288000
  store <4096 x float> zeroinitializer, ptr %6026, align 4
  %6027 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6028 = getelementptr float, ptr %6027, i64 12292096
  store <4096 x float> zeroinitializer, ptr %6028, align 4
  %6029 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6030 = getelementptr float, ptr %6029, i64 12296192
  store <4096 x float> zeroinitializer, ptr %6030, align 4
  %6031 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6032 = getelementptr float, ptr %6031, i64 12300288
  store <4096 x float> zeroinitializer, ptr %6032, align 4
  %6033 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6034 = getelementptr float, ptr %6033, i64 12304384
  store <4096 x float> zeroinitializer, ptr %6034, align 4
  %6035 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6036 = getelementptr float, ptr %6035, i64 12308480
  store <4096 x float> zeroinitializer, ptr %6036, align 4
  %6037 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6038 = getelementptr float, ptr %6037, i64 12312576
  store <4096 x float> zeroinitializer, ptr %6038, align 4
  %6039 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6040 = getelementptr float, ptr %6039, i64 12316672
  store <4096 x float> zeroinitializer, ptr %6040, align 4
  %6041 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6042 = getelementptr float, ptr %6041, i64 12320768
  store <4096 x float> zeroinitializer, ptr %6042, align 4
  %6043 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6044 = getelementptr float, ptr %6043, i64 12324864
  store <4096 x float> zeroinitializer, ptr %6044, align 4
  %6045 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6046 = getelementptr float, ptr %6045, i64 12328960
  store <4096 x float> zeroinitializer, ptr %6046, align 4
  %6047 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6048 = getelementptr float, ptr %6047, i64 12333056
  store <4096 x float> zeroinitializer, ptr %6048, align 4
  %6049 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6050 = getelementptr float, ptr %6049, i64 12337152
  store <4096 x float> zeroinitializer, ptr %6050, align 4
  %6051 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6052 = getelementptr float, ptr %6051, i64 12341248
  store <4096 x float> zeroinitializer, ptr %6052, align 4
  %6053 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6054 = getelementptr float, ptr %6053, i64 12345344
  store <4096 x float> zeroinitializer, ptr %6054, align 4
  %6055 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6056 = getelementptr float, ptr %6055, i64 12349440
  store <4096 x float> zeroinitializer, ptr %6056, align 4
  %6057 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6058 = getelementptr float, ptr %6057, i64 12353536
  store <4096 x float> zeroinitializer, ptr %6058, align 4
  %6059 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6060 = getelementptr float, ptr %6059, i64 12357632
  store <4096 x float> zeroinitializer, ptr %6060, align 4
  %6061 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6062 = getelementptr float, ptr %6061, i64 12361728
  store <4096 x float> zeroinitializer, ptr %6062, align 4
  %6063 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6064 = getelementptr float, ptr %6063, i64 12365824
  store <4096 x float> zeroinitializer, ptr %6064, align 4
  %6065 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6066 = getelementptr float, ptr %6065, i64 12369920
  store <4096 x float> zeroinitializer, ptr %6066, align 4
  %6067 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6068 = getelementptr float, ptr %6067, i64 12374016
  store <4096 x float> zeroinitializer, ptr %6068, align 4
  %6069 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6070 = getelementptr float, ptr %6069, i64 12378112
  store <4096 x float> zeroinitializer, ptr %6070, align 4
  %6071 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6072 = getelementptr float, ptr %6071, i64 12382208
  store <4096 x float> zeroinitializer, ptr %6072, align 4
  %6073 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6074 = getelementptr float, ptr %6073, i64 12386304
  store <4096 x float> zeroinitializer, ptr %6074, align 4
  %6075 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6076 = getelementptr float, ptr %6075, i64 12390400
  store <4096 x float> zeroinitializer, ptr %6076, align 4
  %6077 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6078 = getelementptr float, ptr %6077, i64 12394496
  store <4096 x float> zeroinitializer, ptr %6078, align 4
  %6079 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6080 = getelementptr float, ptr %6079, i64 12398592
  store <4096 x float> zeroinitializer, ptr %6080, align 4
  %6081 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6082 = getelementptr float, ptr %6081, i64 12402688
  store <4096 x float> zeroinitializer, ptr %6082, align 4
  %6083 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6084 = getelementptr float, ptr %6083, i64 12406784
  store <4096 x float> zeroinitializer, ptr %6084, align 4
  %6085 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6086 = getelementptr float, ptr %6085, i64 12410880
  store <4096 x float> zeroinitializer, ptr %6086, align 4
  %6087 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6088 = getelementptr float, ptr %6087, i64 12414976
  store <4096 x float> zeroinitializer, ptr %6088, align 4
  %6089 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6090 = getelementptr float, ptr %6089, i64 12419072
  store <4096 x float> zeroinitializer, ptr %6090, align 4
  %6091 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6092 = getelementptr float, ptr %6091, i64 12423168
  store <4096 x float> zeroinitializer, ptr %6092, align 4
  %6093 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6094 = getelementptr float, ptr %6093, i64 12427264
  store <4096 x float> zeroinitializer, ptr %6094, align 4
  %6095 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6096 = getelementptr float, ptr %6095, i64 12431360
  store <4096 x float> zeroinitializer, ptr %6096, align 4
  %6097 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6098 = getelementptr float, ptr %6097, i64 12435456
  store <4096 x float> zeroinitializer, ptr %6098, align 4
  %6099 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6100 = getelementptr float, ptr %6099, i64 12439552
  store <4096 x float> zeroinitializer, ptr %6100, align 4
  %6101 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6102 = getelementptr float, ptr %6101, i64 12443648
  store <4096 x float> zeroinitializer, ptr %6102, align 4
  %6103 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6104 = getelementptr float, ptr %6103, i64 12447744
  store <4096 x float> zeroinitializer, ptr %6104, align 4
  %6105 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6106 = getelementptr float, ptr %6105, i64 12451840
  store <4096 x float> zeroinitializer, ptr %6106, align 4
  %6107 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6108 = getelementptr float, ptr %6107, i64 12455936
  store <4096 x float> zeroinitializer, ptr %6108, align 4
  %6109 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6110 = getelementptr float, ptr %6109, i64 12460032
  store <4096 x float> zeroinitializer, ptr %6110, align 4
  %6111 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6112 = getelementptr float, ptr %6111, i64 12464128
  store <4096 x float> zeroinitializer, ptr %6112, align 4
  %6113 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6114 = getelementptr float, ptr %6113, i64 12468224
  store <4096 x float> zeroinitializer, ptr %6114, align 4
  %6115 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6116 = getelementptr float, ptr %6115, i64 12472320
  store <4096 x float> zeroinitializer, ptr %6116, align 4
  %6117 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6118 = getelementptr float, ptr %6117, i64 12476416
  store <4096 x float> zeroinitializer, ptr %6118, align 4
  %6119 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6120 = getelementptr float, ptr %6119, i64 12480512
  store <4096 x float> zeroinitializer, ptr %6120, align 4
  %6121 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6122 = getelementptr float, ptr %6121, i64 12484608
  store <4096 x float> zeroinitializer, ptr %6122, align 4
  %6123 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6124 = getelementptr float, ptr %6123, i64 12488704
  store <4096 x float> zeroinitializer, ptr %6124, align 4
  %6125 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6126 = getelementptr float, ptr %6125, i64 12492800
  store <4096 x float> zeroinitializer, ptr %6126, align 4
  %6127 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6128 = getelementptr float, ptr %6127, i64 12496896
  store <4096 x float> zeroinitializer, ptr %6128, align 4
  %6129 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6130 = getelementptr float, ptr %6129, i64 12500992
  store <4096 x float> zeroinitializer, ptr %6130, align 4
  %6131 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6132 = getelementptr float, ptr %6131, i64 12505088
  store <4096 x float> zeroinitializer, ptr %6132, align 4
  %6133 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6134 = getelementptr float, ptr %6133, i64 12509184
  store <4096 x float> zeroinitializer, ptr %6134, align 4
  %6135 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6136 = getelementptr float, ptr %6135, i64 12513280
  store <4096 x float> zeroinitializer, ptr %6136, align 4
  %6137 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6138 = getelementptr float, ptr %6137, i64 12517376
  store <4096 x float> zeroinitializer, ptr %6138, align 4
  %6139 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6140 = getelementptr float, ptr %6139, i64 12521472
  store <4096 x float> zeroinitializer, ptr %6140, align 4
  %6141 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6142 = getelementptr float, ptr %6141, i64 12525568
  store <4096 x float> zeroinitializer, ptr %6142, align 4
  %6143 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6144 = getelementptr float, ptr %6143, i64 12529664
  store <4096 x float> zeroinitializer, ptr %6144, align 4
  %6145 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6146 = getelementptr float, ptr %6145, i64 12533760
  store <4096 x float> zeroinitializer, ptr %6146, align 4
  %6147 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6148 = getelementptr float, ptr %6147, i64 12537856
  store <4096 x float> zeroinitializer, ptr %6148, align 4
  %6149 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6150 = getelementptr float, ptr %6149, i64 12541952
  store <4096 x float> zeroinitializer, ptr %6150, align 4
  %6151 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6152 = getelementptr float, ptr %6151, i64 12546048
  store <4096 x float> zeroinitializer, ptr %6152, align 4
  %6153 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6154 = getelementptr float, ptr %6153, i64 12550144
  store <4096 x float> zeroinitializer, ptr %6154, align 4
  %6155 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6156 = getelementptr float, ptr %6155, i64 12554240
  store <4096 x float> zeroinitializer, ptr %6156, align 4
  %6157 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6158 = getelementptr float, ptr %6157, i64 12558336
  store <4096 x float> zeroinitializer, ptr %6158, align 4
  %6159 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6160 = getelementptr float, ptr %6159, i64 12562432
  store <4096 x float> zeroinitializer, ptr %6160, align 4
  %6161 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6162 = getelementptr float, ptr %6161, i64 12566528
  store <4096 x float> zeroinitializer, ptr %6162, align 4
  %6163 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6164 = getelementptr float, ptr %6163, i64 12570624
  store <4096 x float> zeroinitializer, ptr %6164, align 4
  %6165 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6166 = getelementptr float, ptr %6165, i64 12574720
  store <4096 x float> zeroinitializer, ptr %6166, align 4
  %6167 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6168 = getelementptr float, ptr %6167, i64 12578816
  store <4096 x float> zeroinitializer, ptr %6168, align 4
  %6169 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6170 = getelementptr float, ptr %6169, i64 12582912
  store <4096 x float> zeroinitializer, ptr %6170, align 4
  %6171 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6172 = getelementptr float, ptr %6171, i64 12587008
  store <4096 x float> zeroinitializer, ptr %6172, align 4
  %6173 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6174 = getelementptr float, ptr %6173, i64 12591104
  store <4096 x float> zeroinitializer, ptr %6174, align 4
  %6175 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6176 = getelementptr float, ptr %6175, i64 12595200
  store <4096 x float> zeroinitializer, ptr %6176, align 4
  %6177 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6178 = getelementptr float, ptr %6177, i64 12599296
  store <4096 x float> zeroinitializer, ptr %6178, align 4
  %6179 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6180 = getelementptr float, ptr %6179, i64 12603392
  store <4096 x float> zeroinitializer, ptr %6180, align 4
  %6181 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6182 = getelementptr float, ptr %6181, i64 12607488
  store <4096 x float> zeroinitializer, ptr %6182, align 4
  %6183 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6184 = getelementptr float, ptr %6183, i64 12611584
  store <4096 x float> zeroinitializer, ptr %6184, align 4
  %6185 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6186 = getelementptr float, ptr %6185, i64 12615680
  store <4096 x float> zeroinitializer, ptr %6186, align 4
  %6187 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6188 = getelementptr float, ptr %6187, i64 12619776
  store <4096 x float> zeroinitializer, ptr %6188, align 4
  %6189 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6190 = getelementptr float, ptr %6189, i64 12623872
  store <4096 x float> zeroinitializer, ptr %6190, align 4
  %6191 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6192 = getelementptr float, ptr %6191, i64 12627968
  store <4096 x float> zeroinitializer, ptr %6192, align 4
  %6193 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6194 = getelementptr float, ptr %6193, i64 12632064
  store <4096 x float> zeroinitializer, ptr %6194, align 4
  %6195 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6196 = getelementptr float, ptr %6195, i64 12636160
  store <4096 x float> zeroinitializer, ptr %6196, align 4
  %6197 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6198 = getelementptr float, ptr %6197, i64 12640256
  store <4096 x float> zeroinitializer, ptr %6198, align 4
  %6199 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6200 = getelementptr float, ptr %6199, i64 12644352
  store <4096 x float> zeroinitializer, ptr %6200, align 4
  %6201 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6202 = getelementptr float, ptr %6201, i64 12648448
  store <4096 x float> zeroinitializer, ptr %6202, align 4
  %6203 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6204 = getelementptr float, ptr %6203, i64 12652544
  store <4096 x float> zeroinitializer, ptr %6204, align 4
  %6205 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6206 = getelementptr float, ptr %6205, i64 12656640
  store <4096 x float> zeroinitializer, ptr %6206, align 4
  %6207 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6208 = getelementptr float, ptr %6207, i64 12660736
  store <4096 x float> zeroinitializer, ptr %6208, align 4
  %6209 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6210 = getelementptr float, ptr %6209, i64 12664832
  store <4096 x float> zeroinitializer, ptr %6210, align 4
  %6211 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6212 = getelementptr float, ptr %6211, i64 12668928
  store <4096 x float> zeroinitializer, ptr %6212, align 4
  %6213 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6214 = getelementptr float, ptr %6213, i64 12673024
  store <4096 x float> zeroinitializer, ptr %6214, align 4
  %6215 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6216 = getelementptr float, ptr %6215, i64 12677120
  store <4096 x float> zeroinitializer, ptr %6216, align 4
  %6217 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6218 = getelementptr float, ptr %6217, i64 12681216
  store <4096 x float> zeroinitializer, ptr %6218, align 4
  %6219 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6220 = getelementptr float, ptr %6219, i64 12685312
  store <4096 x float> zeroinitializer, ptr %6220, align 4
  %6221 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6222 = getelementptr float, ptr %6221, i64 12689408
  store <4096 x float> zeroinitializer, ptr %6222, align 4
  %6223 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6224 = getelementptr float, ptr %6223, i64 12693504
  store <4096 x float> zeroinitializer, ptr %6224, align 4
  %6225 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6226 = getelementptr float, ptr %6225, i64 12697600
  store <4096 x float> zeroinitializer, ptr %6226, align 4
  %6227 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6228 = getelementptr float, ptr %6227, i64 12701696
  store <4096 x float> zeroinitializer, ptr %6228, align 4
  %6229 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6230 = getelementptr float, ptr %6229, i64 12705792
  store <4096 x float> zeroinitializer, ptr %6230, align 4
  %6231 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6232 = getelementptr float, ptr %6231, i64 12709888
  store <4096 x float> zeroinitializer, ptr %6232, align 4
  %6233 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6234 = getelementptr float, ptr %6233, i64 12713984
  store <4096 x float> zeroinitializer, ptr %6234, align 4
  %6235 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6236 = getelementptr float, ptr %6235, i64 12718080
  store <4096 x float> zeroinitializer, ptr %6236, align 4
  %6237 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6238 = getelementptr float, ptr %6237, i64 12722176
  store <4096 x float> zeroinitializer, ptr %6238, align 4
  %6239 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6240 = getelementptr float, ptr %6239, i64 12726272
  store <4096 x float> zeroinitializer, ptr %6240, align 4
  %6241 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6242 = getelementptr float, ptr %6241, i64 12730368
  store <4096 x float> zeroinitializer, ptr %6242, align 4
  %6243 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6244 = getelementptr float, ptr %6243, i64 12734464
  store <4096 x float> zeroinitializer, ptr %6244, align 4
  %6245 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6246 = getelementptr float, ptr %6245, i64 12738560
  store <4096 x float> zeroinitializer, ptr %6246, align 4
  %6247 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6248 = getelementptr float, ptr %6247, i64 12742656
  store <4096 x float> zeroinitializer, ptr %6248, align 4
  %6249 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6250 = getelementptr float, ptr %6249, i64 12746752
  store <4096 x float> zeroinitializer, ptr %6250, align 4
  %6251 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6252 = getelementptr float, ptr %6251, i64 12750848
  store <4096 x float> zeroinitializer, ptr %6252, align 4
  %6253 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6254 = getelementptr float, ptr %6253, i64 12754944
  store <4096 x float> zeroinitializer, ptr %6254, align 4
  %6255 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6256 = getelementptr float, ptr %6255, i64 12759040
  store <4096 x float> zeroinitializer, ptr %6256, align 4
  %6257 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6258 = getelementptr float, ptr %6257, i64 12763136
  store <4096 x float> zeroinitializer, ptr %6258, align 4
  %6259 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6260 = getelementptr float, ptr %6259, i64 12767232
  store <4096 x float> zeroinitializer, ptr %6260, align 4
  %6261 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6262 = getelementptr float, ptr %6261, i64 12771328
  store <4096 x float> zeroinitializer, ptr %6262, align 4
  %6263 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6264 = getelementptr float, ptr %6263, i64 12775424
  store <4096 x float> zeroinitializer, ptr %6264, align 4
  %6265 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6266 = getelementptr float, ptr %6265, i64 12779520
  store <4096 x float> zeroinitializer, ptr %6266, align 4
  %6267 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6268 = getelementptr float, ptr %6267, i64 12783616
  store <4096 x float> zeroinitializer, ptr %6268, align 4
  %6269 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6270 = getelementptr float, ptr %6269, i64 12787712
  store <4096 x float> zeroinitializer, ptr %6270, align 4
  %6271 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6272 = getelementptr float, ptr %6271, i64 12791808
  store <4096 x float> zeroinitializer, ptr %6272, align 4
  %6273 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6274 = getelementptr float, ptr %6273, i64 12795904
  store <4096 x float> zeroinitializer, ptr %6274, align 4
  %6275 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6276 = getelementptr float, ptr %6275, i64 12800000
  store <4096 x float> zeroinitializer, ptr %6276, align 4
  %6277 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6278 = getelementptr float, ptr %6277, i64 12804096
  store <4096 x float> zeroinitializer, ptr %6278, align 4
  %6279 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6280 = getelementptr float, ptr %6279, i64 12808192
  store <4096 x float> zeroinitializer, ptr %6280, align 4
  %6281 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6282 = getelementptr float, ptr %6281, i64 12812288
  store <4096 x float> zeroinitializer, ptr %6282, align 4
  %6283 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6284 = getelementptr float, ptr %6283, i64 12816384
  store <4096 x float> zeroinitializer, ptr %6284, align 4
  %6285 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6286 = getelementptr float, ptr %6285, i64 12820480
  store <4096 x float> zeroinitializer, ptr %6286, align 4
  %6287 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6288 = getelementptr float, ptr %6287, i64 12824576
  store <4096 x float> zeroinitializer, ptr %6288, align 4
  %6289 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6290 = getelementptr float, ptr %6289, i64 12828672
  store <4096 x float> zeroinitializer, ptr %6290, align 4
  %6291 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6292 = getelementptr float, ptr %6291, i64 12832768
  store <4096 x float> zeroinitializer, ptr %6292, align 4
  %6293 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6294 = getelementptr float, ptr %6293, i64 12836864
  store <4096 x float> zeroinitializer, ptr %6294, align 4
  %6295 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6296 = getelementptr float, ptr %6295, i64 12840960
  store <4096 x float> zeroinitializer, ptr %6296, align 4
  %6297 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6298 = getelementptr float, ptr %6297, i64 12845056
  store <4096 x float> zeroinitializer, ptr %6298, align 4
  %6299 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6300 = getelementptr float, ptr %6299, i64 12849152
  store <4096 x float> zeroinitializer, ptr %6300, align 4
  %6301 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6302 = getelementptr float, ptr %6301, i64 12853248
  store <4096 x float> zeroinitializer, ptr %6302, align 4
  %6303 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6304 = getelementptr float, ptr %6303, i64 12857344
  store <4096 x float> zeroinitializer, ptr %6304, align 4
  %6305 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6306 = getelementptr float, ptr %6305, i64 12861440
  store <4096 x float> zeroinitializer, ptr %6306, align 4
  %6307 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6308 = getelementptr float, ptr %6307, i64 12865536
  store <4096 x float> zeroinitializer, ptr %6308, align 4
  %6309 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6310 = getelementptr float, ptr %6309, i64 12869632
  store <4096 x float> zeroinitializer, ptr %6310, align 4
  %6311 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6312 = getelementptr float, ptr %6311, i64 12873728
  store <4096 x float> zeroinitializer, ptr %6312, align 4
  %6313 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6314 = getelementptr float, ptr %6313, i64 12877824
  store <4096 x float> zeroinitializer, ptr %6314, align 4
  %6315 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6316 = getelementptr float, ptr %6315, i64 12881920
  store <4096 x float> zeroinitializer, ptr %6316, align 4
  %6317 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6318 = getelementptr float, ptr %6317, i64 12886016
  store <4096 x float> zeroinitializer, ptr %6318, align 4
  %6319 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6320 = getelementptr float, ptr %6319, i64 12890112
  store <4096 x float> zeroinitializer, ptr %6320, align 4
  %6321 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6322 = getelementptr float, ptr %6321, i64 12894208
  store <4096 x float> zeroinitializer, ptr %6322, align 4
  %6323 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6324 = getelementptr float, ptr %6323, i64 12898304
  store <4096 x float> zeroinitializer, ptr %6324, align 4
  %6325 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6326 = getelementptr float, ptr %6325, i64 12902400
  store <4096 x float> zeroinitializer, ptr %6326, align 4
  %6327 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6328 = getelementptr float, ptr %6327, i64 12906496
  store <4096 x float> zeroinitializer, ptr %6328, align 4
  %6329 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6330 = getelementptr float, ptr %6329, i64 12910592
  store <4096 x float> zeroinitializer, ptr %6330, align 4
  %6331 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6332 = getelementptr float, ptr %6331, i64 12914688
  store <4096 x float> zeroinitializer, ptr %6332, align 4
  %6333 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6334 = getelementptr float, ptr %6333, i64 12918784
  store <4096 x float> zeroinitializer, ptr %6334, align 4
  %6335 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6336 = getelementptr float, ptr %6335, i64 12922880
  store <4096 x float> zeroinitializer, ptr %6336, align 4
  %6337 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6338 = getelementptr float, ptr %6337, i64 12926976
  store <4096 x float> zeroinitializer, ptr %6338, align 4
  %6339 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6340 = getelementptr float, ptr %6339, i64 12931072
  store <4096 x float> zeroinitializer, ptr %6340, align 4
  %6341 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6342 = getelementptr float, ptr %6341, i64 12935168
  store <4096 x float> zeroinitializer, ptr %6342, align 4
  %6343 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6344 = getelementptr float, ptr %6343, i64 12939264
  store <4096 x float> zeroinitializer, ptr %6344, align 4
  %6345 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6346 = getelementptr float, ptr %6345, i64 12943360
  store <4096 x float> zeroinitializer, ptr %6346, align 4
  %6347 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6348 = getelementptr float, ptr %6347, i64 12947456
  store <4096 x float> zeroinitializer, ptr %6348, align 4
  %6349 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6350 = getelementptr float, ptr %6349, i64 12951552
  store <4096 x float> zeroinitializer, ptr %6350, align 4
  %6351 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6352 = getelementptr float, ptr %6351, i64 12955648
  store <4096 x float> zeroinitializer, ptr %6352, align 4
  %6353 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6354 = getelementptr float, ptr %6353, i64 12959744
  store <4096 x float> zeroinitializer, ptr %6354, align 4
  %6355 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6356 = getelementptr float, ptr %6355, i64 12963840
  store <4096 x float> zeroinitializer, ptr %6356, align 4
  %6357 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6358 = getelementptr float, ptr %6357, i64 12967936
  store <4096 x float> zeroinitializer, ptr %6358, align 4
  %6359 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6360 = getelementptr float, ptr %6359, i64 12972032
  store <4096 x float> zeroinitializer, ptr %6360, align 4
  %6361 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6362 = getelementptr float, ptr %6361, i64 12976128
  store <4096 x float> zeroinitializer, ptr %6362, align 4
  %6363 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6364 = getelementptr float, ptr %6363, i64 12980224
  store <4096 x float> zeroinitializer, ptr %6364, align 4
  %6365 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6366 = getelementptr float, ptr %6365, i64 12984320
  store <4096 x float> zeroinitializer, ptr %6366, align 4
  %6367 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6368 = getelementptr float, ptr %6367, i64 12988416
  store <4096 x float> zeroinitializer, ptr %6368, align 4
  %6369 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6370 = getelementptr float, ptr %6369, i64 12992512
  store <4096 x float> zeroinitializer, ptr %6370, align 4
  %6371 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6372 = getelementptr float, ptr %6371, i64 12996608
  store <4096 x float> zeroinitializer, ptr %6372, align 4
  %6373 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6374 = getelementptr float, ptr %6373, i64 13000704
  store <4096 x float> zeroinitializer, ptr %6374, align 4
  %6375 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6376 = getelementptr float, ptr %6375, i64 13004800
  store <4096 x float> zeroinitializer, ptr %6376, align 4
  %6377 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6378 = getelementptr float, ptr %6377, i64 13008896
  store <4096 x float> zeroinitializer, ptr %6378, align 4
  %6379 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6380 = getelementptr float, ptr %6379, i64 13012992
  store <4096 x float> zeroinitializer, ptr %6380, align 4
  %6381 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6382 = getelementptr float, ptr %6381, i64 13017088
  store <4096 x float> zeroinitializer, ptr %6382, align 4
  %6383 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6384 = getelementptr float, ptr %6383, i64 13021184
  store <4096 x float> zeroinitializer, ptr %6384, align 4
  %6385 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6386 = getelementptr float, ptr %6385, i64 13025280
  store <4096 x float> zeroinitializer, ptr %6386, align 4
  %6387 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6388 = getelementptr float, ptr %6387, i64 13029376
  store <4096 x float> zeroinitializer, ptr %6388, align 4
  %6389 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6390 = getelementptr float, ptr %6389, i64 13033472
  store <4096 x float> zeroinitializer, ptr %6390, align 4
  %6391 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6392 = getelementptr float, ptr %6391, i64 13037568
  store <4096 x float> zeroinitializer, ptr %6392, align 4
  %6393 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6394 = getelementptr float, ptr %6393, i64 13041664
  store <4096 x float> zeroinitializer, ptr %6394, align 4
  %6395 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6396 = getelementptr float, ptr %6395, i64 13045760
  store <4096 x float> zeroinitializer, ptr %6396, align 4
  %6397 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6398 = getelementptr float, ptr %6397, i64 13049856
  store <4096 x float> zeroinitializer, ptr %6398, align 4
  %6399 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6400 = getelementptr float, ptr %6399, i64 13053952
  store <4096 x float> zeroinitializer, ptr %6400, align 4
  %6401 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6402 = getelementptr float, ptr %6401, i64 13058048
  store <4096 x float> zeroinitializer, ptr %6402, align 4
  %6403 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6404 = getelementptr float, ptr %6403, i64 13062144
  store <4096 x float> zeroinitializer, ptr %6404, align 4
  %6405 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6406 = getelementptr float, ptr %6405, i64 13066240
  store <4096 x float> zeroinitializer, ptr %6406, align 4
  %6407 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6408 = getelementptr float, ptr %6407, i64 13070336
  store <4096 x float> zeroinitializer, ptr %6408, align 4
  %6409 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6410 = getelementptr float, ptr %6409, i64 13074432
  store <4096 x float> zeroinitializer, ptr %6410, align 4
  %6411 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6412 = getelementptr float, ptr %6411, i64 13078528
  store <4096 x float> zeroinitializer, ptr %6412, align 4
  %6413 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6414 = getelementptr float, ptr %6413, i64 13082624
  store <4096 x float> zeroinitializer, ptr %6414, align 4
  %6415 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6416 = getelementptr float, ptr %6415, i64 13086720
  store <4096 x float> zeroinitializer, ptr %6416, align 4
  %6417 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6418 = getelementptr float, ptr %6417, i64 13090816
  store <4096 x float> zeroinitializer, ptr %6418, align 4
  %6419 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6420 = getelementptr float, ptr %6419, i64 13094912
  store <4096 x float> zeroinitializer, ptr %6420, align 4
  %6421 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6422 = getelementptr float, ptr %6421, i64 13099008
  store <4096 x float> zeroinitializer, ptr %6422, align 4
  %6423 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6424 = getelementptr float, ptr %6423, i64 13103104
  store <4096 x float> zeroinitializer, ptr %6424, align 4
  %6425 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6426 = getelementptr float, ptr %6425, i64 13107200
  store <4096 x float> zeroinitializer, ptr %6426, align 4
  %6427 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6428 = getelementptr float, ptr %6427, i64 13111296
  store <4096 x float> zeroinitializer, ptr %6428, align 4
  %6429 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6430 = getelementptr float, ptr %6429, i64 13115392
  store <4096 x float> zeroinitializer, ptr %6430, align 4
  %6431 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6432 = getelementptr float, ptr %6431, i64 13119488
  store <4096 x float> zeroinitializer, ptr %6432, align 4
  %6433 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6434 = getelementptr float, ptr %6433, i64 13123584
  store <4096 x float> zeroinitializer, ptr %6434, align 4
  %6435 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6436 = getelementptr float, ptr %6435, i64 13127680
  store <4096 x float> zeroinitializer, ptr %6436, align 4
  %6437 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6438 = getelementptr float, ptr %6437, i64 13131776
  store <4096 x float> zeroinitializer, ptr %6438, align 4
  %6439 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6440 = getelementptr float, ptr %6439, i64 13135872
  store <4096 x float> zeroinitializer, ptr %6440, align 4
  %6441 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6442 = getelementptr float, ptr %6441, i64 13139968
  store <4096 x float> zeroinitializer, ptr %6442, align 4
  %6443 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6444 = getelementptr float, ptr %6443, i64 13144064
  store <4096 x float> zeroinitializer, ptr %6444, align 4
  %6445 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6446 = getelementptr float, ptr %6445, i64 13148160
  store <4096 x float> zeroinitializer, ptr %6446, align 4
  %6447 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6448 = getelementptr float, ptr %6447, i64 13152256
  store <4096 x float> zeroinitializer, ptr %6448, align 4
  %6449 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6450 = getelementptr float, ptr %6449, i64 13156352
  store <4096 x float> zeroinitializer, ptr %6450, align 4
  %6451 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6452 = getelementptr float, ptr %6451, i64 13160448
  store <4096 x float> zeroinitializer, ptr %6452, align 4
  %6453 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6454 = getelementptr float, ptr %6453, i64 13164544
  store <4096 x float> zeroinitializer, ptr %6454, align 4
  %6455 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6456 = getelementptr float, ptr %6455, i64 13168640
  store <4096 x float> zeroinitializer, ptr %6456, align 4
  %6457 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6458 = getelementptr float, ptr %6457, i64 13172736
  store <4096 x float> zeroinitializer, ptr %6458, align 4
  %6459 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6460 = getelementptr float, ptr %6459, i64 13176832
  store <4096 x float> zeroinitializer, ptr %6460, align 4
  %6461 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6462 = getelementptr float, ptr %6461, i64 13180928
  store <4096 x float> zeroinitializer, ptr %6462, align 4
  %6463 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6464 = getelementptr float, ptr %6463, i64 13185024
  store <4096 x float> zeroinitializer, ptr %6464, align 4
  %6465 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6466 = getelementptr float, ptr %6465, i64 13189120
  store <4096 x float> zeroinitializer, ptr %6466, align 4
  %6467 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6468 = getelementptr float, ptr %6467, i64 13193216
  store <4096 x float> zeroinitializer, ptr %6468, align 4
  %6469 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6470 = getelementptr float, ptr %6469, i64 13197312
  store <4096 x float> zeroinitializer, ptr %6470, align 4
  %6471 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6472 = getelementptr float, ptr %6471, i64 13201408
  store <4096 x float> zeroinitializer, ptr %6472, align 4
  %6473 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6474 = getelementptr float, ptr %6473, i64 13205504
  store <4096 x float> zeroinitializer, ptr %6474, align 4
  %6475 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6476 = getelementptr float, ptr %6475, i64 13209600
  store <4096 x float> zeroinitializer, ptr %6476, align 4
  %6477 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6478 = getelementptr float, ptr %6477, i64 13213696
  store <4096 x float> zeroinitializer, ptr %6478, align 4
  %6479 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6480 = getelementptr float, ptr %6479, i64 13217792
  store <4096 x float> zeroinitializer, ptr %6480, align 4
  %6481 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6482 = getelementptr float, ptr %6481, i64 13221888
  store <4096 x float> zeroinitializer, ptr %6482, align 4
  %6483 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6484 = getelementptr float, ptr %6483, i64 13225984
  store <4096 x float> zeroinitializer, ptr %6484, align 4
  %6485 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6486 = getelementptr float, ptr %6485, i64 13230080
  store <4096 x float> zeroinitializer, ptr %6486, align 4
  %6487 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6488 = getelementptr float, ptr %6487, i64 13234176
  store <4096 x float> zeroinitializer, ptr %6488, align 4
  %6489 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6490 = getelementptr float, ptr %6489, i64 13238272
  store <4096 x float> zeroinitializer, ptr %6490, align 4
  %6491 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6492 = getelementptr float, ptr %6491, i64 13242368
  store <4096 x float> zeroinitializer, ptr %6492, align 4
  %6493 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6494 = getelementptr float, ptr %6493, i64 13246464
  store <4096 x float> zeroinitializer, ptr %6494, align 4
  %6495 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6496 = getelementptr float, ptr %6495, i64 13250560
  store <4096 x float> zeroinitializer, ptr %6496, align 4
  %6497 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6498 = getelementptr float, ptr %6497, i64 13254656
  store <4096 x float> zeroinitializer, ptr %6498, align 4
  %6499 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6500 = getelementptr float, ptr %6499, i64 13258752
  store <4096 x float> zeroinitializer, ptr %6500, align 4
  %6501 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6502 = getelementptr float, ptr %6501, i64 13262848
  store <4096 x float> zeroinitializer, ptr %6502, align 4
  %6503 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6504 = getelementptr float, ptr %6503, i64 13266944
  store <4096 x float> zeroinitializer, ptr %6504, align 4
  %6505 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6506 = getelementptr float, ptr %6505, i64 13271040
  store <4096 x float> zeroinitializer, ptr %6506, align 4
  %6507 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6508 = getelementptr float, ptr %6507, i64 13275136
  store <4096 x float> zeroinitializer, ptr %6508, align 4
  %6509 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6510 = getelementptr float, ptr %6509, i64 13279232
  store <4096 x float> zeroinitializer, ptr %6510, align 4
  %6511 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6512 = getelementptr float, ptr %6511, i64 13283328
  store <4096 x float> zeroinitializer, ptr %6512, align 4
  %6513 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6514 = getelementptr float, ptr %6513, i64 13287424
  store <4096 x float> zeroinitializer, ptr %6514, align 4
  %6515 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6516 = getelementptr float, ptr %6515, i64 13291520
  store <4096 x float> zeroinitializer, ptr %6516, align 4
  %6517 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6518 = getelementptr float, ptr %6517, i64 13295616
  store <4096 x float> zeroinitializer, ptr %6518, align 4
  %6519 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6520 = getelementptr float, ptr %6519, i64 13299712
  store <4096 x float> zeroinitializer, ptr %6520, align 4
  %6521 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6522 = getelementptr float, ptr %6521, i64 13303808
  store <4096 x float> zeroinitializer, ptr %6522, align 4
  %6523 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6524 = getelementptr float, ptr %6523, i64 13307904
  store <4096 x float> zeroinitializer, ptr %6524, align 4
  %6525 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6526 = getelementptr float, ptr %6525, i64 13312000
  store <4096 x float> zeroinitializer, ptr %6526, align 4
  %6527 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6528 = getelementptr float, ptr %6527, i64 13316096
  store <4096 x float> zeroinitializer, ptr %6528, align 4
  %6529 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6530 = getelementptr float, ptr %6529, i64 13320192
  store <4096 x float> zeroinitializer, ptr %6530, align 4
  %6531 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6532 = getelementptr float, ptr %6531, i64 13324288
  store <4096 x float> zeroinitializer, ptr %6532, align 4
  %6533 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6534 = getelementptr float, ptr %6533, i64 13328384
  store <4096 x float> zeroinitializer, ptr %6534, align 4
  %6535 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6536 = getelementptr float, ptr %6535, i64 13332480
  store <4096 x float> zeroinitializer, ptr %6536, align 4
  %6537 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6538 = getelementptr float, ptr %6537, i64 13336576
  store <4096 x float> zeroinitializer, ptr %6538, align 4
  %6539 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6540 = getelementptr float, ptr %6539, i64 13340672
  store <4096 x float> zeroinitializer, ptr %6540, align 4
  %6541 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6542 = getelementptr float, ptr %6541, i64 13344768
  store <4096 x float> zeroinitializer, ptr %6542, align 4
  %6543 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6544 = getelementptr float, ptr %6543, i64 13348864
  store <4096 x float> zeroinitializer, ptr %6544, align 4
  %6545 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6546 = getelementptr float, ptr %6545, i64 13352960
  store <4096 x float> zeroinitializer, ptr %6546, align 4
  %6547 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6548 = getelementptr float, ptr %6547, i64 13357056
  store <4096 x float> zeroinitializer, ptr %6548, align 4
  %6549 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6550 = getelementptr float, ptr %6549, i64 13361152
  store <4096 x float> zeroinitializer, ptr %6550, align 4
  %6551 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6552 = getelementptr float, ptr %6551, i64 13365248
  store <4096 x float> zeroinitializer, ptr %6552, align 4
  %6553 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6554 = getelementptr float, ptr %6553, i64 13369344
  store <4096 x float> zeroinitializer, ptr %6554, align 4
  %6555 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6556 = getelementptr float, ptr %6555, i64 13373440
  store <4096 x float> zeroinitializer, ptr %6556, align 4
  %6557 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6558 = getelementptr float, ptr %6557, i64 13377536
  store <4096 x float> zeroinitializer, ptr %6558, align 4
  %6559 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6560 = getelementptr float, ptr %6559, i64 13381632
  store <4096 x float> zeroinitializer, ptr %6560, align 4
  %6561 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6562 = getelementptr float, ptr %6561, i64 13385728
  store <4096 x float> zeroinitializer, ptr %6562, align 4
  %6563 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6564 = getelementptr float, ptr %6563, i64 13389824
  store <4096 x float> zeroinitializer, ptr %6564, align 4
  %6565 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6566 = getelementptr float, ptr %6565, i64 13393920
  store <4096 x float> zeroinitializer, ptr %6566, align 4
  %6567 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6568 = getelementptr float, ptr %6567, i64 13398016
  store <4096 x float> zeroinitializer, ptr %6568, align 4
  %6569 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6570 = getelementptr float, ptr %6569, i64 13402112
  store <4096 x float> zeroinitializer, ptr %6570, align 4
  %6571 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6572 = getelementptr float, ptr %6571, i64 13406208
  store <4096 x float> zeroinitializer, ptr %6572, align 4
  %6573 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6574 = getelementptr float, ptr %6573, i64 13410304
  store <4096 x float> zeroinitializer, ptr %6574, align 4
  %6575 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6576 = getelementptr float, ptr %6575, i64 13414400
  store <4096 x float> zeroinitializer, ptr %6576, align 4
  %6577 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6578 = getelementptr float, ptr %6577, i64 13418496
  store <4096 x float> zeroinitializer, ptr %6578, align 4
  %6579 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6580 = getelementptr float, ptr %6579, i64 13422592
  store <4096 x float> zeroinitializer, ptr %6580, align 4
  %6581 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6582 = getelementptr float, ptr %6581, i64 13426688
  store <4096 x float> zeroinitializer, ptr %6582, align 4
  %6583 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6584 = getelementptr float, ptr %6583, i64 13430784
  store <4096 x float> zeroinitializer, ptr %6584, align 4
  %6585 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6586 = getelementptr float, ptr %6585, i64 13434880
  store <4096 x float> zeroinitializer, ptr %6586, align 4
  %6587 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6588 = getelementptr float, ptr %6587, i64 13438976
  store <4096 x float> zeroinitializer, ptr %6588, align 4
  %6589 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6590 = getelementptr float, ptr %6589, i64 13443072
  store <4096 x float> zeroinitializer, ptr %6590, align 4
  %6591 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6592 = getelementptr float, ptr %6591, i64 13447168
  store <4096 x float> zeroinitializer, ptr %6592, align 4
  %6593 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6594 = getelementptr float, ptr %6593, i64 13451264
  store <4096 x float> zeroinitializer, ptr %6594, align 4
  %6595 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6596 = getelementptr float, ptr %6595, i64 13455360
  store <4096 x float> zeroinitializer, ptr %6596, align 4
  %6597 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6598 = getelementptr float, ptr %6597, i64 13459456
  store <4096 x float> zeroinitializer, ptr %6598, align 4
  %6599 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6600 = getelementptr float, ptr %6599, i64 13463552
  store <4096 x float> zeroinitializer, ptr %6600, align 4
  %6601 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6602 = getelementptr float, ptr %6601, i64 13467648
  store <4096 x float> zeroinitializer, ptr %6602, align 4
  %6603 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6604 = getelementptr float, ptr %6603, i64 13471744
  store <4096 x float> zeroinitializer, ptr %6604, align 4
  %6605 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6606 = getelementptr float, ptr %6605, i64 13475840
  store <4096 x float> zeroinitializer, ptr %6606, align 4
  %6607 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6608 = getelementptr float, ptr %6607, i64 13479936
  store <4096 x float> zeroinitializer, ptr %6608, align 4
  %6609 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6610 = getelementptr float, ptr %6609, i64 13484032
  store <4096 x float> zeroinitializer, ptr %6610, align 4
  %6611 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6612 = getelementptr float, ptr %6611, i64 13488128
  store <4096 x float> zeroinitializer, ptr %6612, align 4
  %6613 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6614 = getelementptr float, ptr %6613, i64 13492224
  store <4096 x float> zeroinitializer, ptr %6614, align 4
  %6615 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6616 = getelementptr float, ptr %6615, i64 13496320
  store <4096 x float> zeroinitializer, ptr %6616, align 4
  %6617 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6618 = getelementptr float, ptr %6617, i64 13500416
  store <4096 x float> zeroinitializer, ptr %6618, align 4
  %6619 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6620 = getelementptr float, ptr %6619, i64 13504512
  store <4096 x float> zeroinitializer, ptr %6620, align 4
  %6621 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6622 = getelementptr float, ptr %6621, i64 13508608
  store <4096 x float> zeroinitializer, ptr %6622, align 4
  %6623 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6624 = getelementptr float, ptr %6623, i64 13512704
  store <4096 x float> zeroinitializer, ptr %6624, align 4
  %6625 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6626 = getelementptr float, ptr %6625, i64 13516800
  store <4096 x float> zeroinitializer, ptr %6626, align 4
  %6627 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6628 = getelementptr float, ptr %6627, i64 13520896
  store <4096 x float> zeroinitializer, ptr %6628, align 4
  %6629 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6630 = getelementptr float, ptr %6629, i64 13524992
  store <4096 x float> zeroinitializer, ptr %6630, align 4
  %6631 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6632 = getelementptr float, ptr %6631, i64 13529088
  store <4096 x float> zeroinitializer, ptr %6632, align 4
  %6633 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6634 = getelementptr float, ptr %6633, i64 13533184
  store <4096 x float> zeroinitializer, ptr %6634, align 4
  %6635 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6636 = getelementptr float, ptr %6635, i64 13537280
  store <4096 x float> zeroinitializer, ptr %6636, align 4
  %6637 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6638 = getelementptr float, ptr %6637, i64 13541376
  store <4096 x float> zeroinitializer, ptr %6638, align 4
  %6639 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6640 = getelementptr float, ptr %6639, i64 13545472
  store <4096 x float> zeroinitializer, ptr %6640, align 4
  %6641 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6642 = getelementptr float, ptr %6641, i64 13549568
  store <4096 x float> zeroinitializer, ptr %6642, align 4
  %6643 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6644 = getelementptr float, ptr %6643, i64 13553664
  store <4096 x float> zeroinitializer, ptr %6644, align 4
  %6645 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6646 = getelementptr float, ptr %6645, i64 13557760
  store <4096 x float> zeroinitializer, ptr %6646, align 4
  %6647 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6648 = getelementptr float, ptr %6647, i64 13561856
  store <4096 x float> zeroinitializer, ptr %6648, align 4
  %6649 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6650 = getelementptr float, ptr %6649, i64 13565952
  store <4096 x float> zeroinitializer, ptr %6650, align 4
  %6651 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6652 = getelementptr float, ptr %6651, i64 13570048
  store <4096 x float> zeroinitializer, ptr %6652, align 4
  %6653 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6654 = getelementptr float, ptr %6653, i64 13574144
  store <4096 x float> zeroinitializer, ptr %6654, align 4
  %6655 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6656 = getelementptr float, ptr %6655, i64 13578240
  store <4096 x float> zeroinitializer, ptr %6656, align 4
  %6657 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6658 = getelementptr float, ptr %6657, i64 13582336
  store <4096 x float> zeroinitializer, ptr %6658, align 4
  %6659 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6660 = getelementptr float, ptr %6659, i64 13586432
  store <4096 x float> zeroinitializer, ptr %6660, align 4
  %6661 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6662 = getelementptr float, ptr %6661, i64 13590528
  store <4096 x float> zeroinitializer, ptr %6662, align 4
  %6663 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6664 = getelementptr float, ptr %6663, i64 13594624
  store <4096 x float> zeroinitializer, ptr %6664, align 4
  %6665 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6666 = getelementptr float, ptr %6665, i64 13598720
  store <4096 x float> zeroinitializer, ptr %6666, align 4
  %6667 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6668 = getelementptr float, ptr %6667, i64 13602816
  store <4096 x float> zeroinitializer, ptr %6668, align 4
  %6669 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6670 = getelementptr float, ptr %6669, i64 13606912
  store <4096 x float> zeroinitializer, ptr %6670, align 4
  %6671 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6672 = getelementptr float, ptr %6671, i64 13611008
  store <4096 x float> zeroinitializer, ptr %6672, align 4
  %6673 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6674 = getelementptr float, ptr %6673, i64 13615104
  store <4096 x float> zeroinitializer, ptr %6674, align 4
  %6675 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6676 = getelementptr float, ptr %6675, i64 13619200
  store <4096 x float> zeroinitializer, ptr %6676, align 4
  %6677 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6678 = getelementptr float, ptr %6677, i64 13623296
  store <4096 x float> zeroinitializer, ptr %6678, align 4
  %6679 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6680 = getelementptr float, ptr %6679, i64 13627392
  store <4096 x float> zeroinitializer, ptr %6680, align 4
  %6681 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6682 = getelementptr float, ptr %6681, i64 13631488
  store <4096 x float> zeroinitializer, ptr %6682, align 4
  %6683 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6684 = getelementptr float, ptr %6683, i64 13635584
  store <4096 x float> zeroinitializer, ptr %6684, align 4
  %6685 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6686 = getelementptr float, ptr %6685, i64 13639680
  store <4096 x float> zeroinitializer, ptr %6686, align 4
  %6687 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6688 = getelementptr float, ptr %6687, i64 13643776
  store <4096 x float> zeroinitializer, ptr %6688, align 4
  %6689 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6690 = getelementptr float, ptr %6689, i64 13647872
  store <4096 x float> zeroinitializer, ptr %6690, align 4
  %6691 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6692 = getelementptr float, ptr %6691, i64 13651968
  store <4096 x float> zeroinitializer, ptr %6692, align 4
  %6693 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6694 = getelementptr float, ptr %6693, i64 13656064
  store <4096 x float> zeroinitializer, ptr %6694, align 4
  %6695 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6696 = getelementptr float, ptr %6695, i64 13660160
  store <4096 x float> zeroinitializer, ptr %6696, align 4
  %6697 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6698 = getelementptr float, ptr %6697, i64 13664256
  store <4096 x float> zeroinitializer, ptr %6698, align 4
  %6699 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6700 = getelementptr float, ptr %6699, i64 13668352
  store <4096 x float> zeroinitializer, ptr %6700, align 4
  %6701 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6702 = getelementptr float, ptr %6701, i64 13672448
  store <4096 x float> zeroinitializer, ptr %6702, align 4
  %6703 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6704 = getelementptr float, ptr %6703, i64 13676544
  store <4096 x float> zeroinitializer, ptr %6704, align 4
  %6705 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6706 = getelementptr float, ptr %6705, i64 13680640
  store <4096 x float> zeroinitializer, ptr %6706, align 4
  %6707 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6708 = getelementptr float, ptr %6707, i64 13684736
  store <4096 x float> zeroinitializer, ptr %6708, align 4
  %6709 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6710 = getelementptr float, ptr %6709, i64 13688832
  store <4096 x float> zeroinitializer, ptr %6710, align 4
  %6711 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6712 = getelementptr float, ptr %6711, i64 13692928
  store <4096 x float> zeroinitializer, ptr %6712, align 4
  %6713 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6714 = getelementptr float, ptr %6713, i64 13697024
  store <4096 x float> zeroinitializer, ptr %6714, align 4
  %6715 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6716 = getelementptr float, ptr %6715, i64 13701120
  store <4096 x float> zeroinitializer, ptr %6716, align 4
  %6717 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6718 = getelementptr float, ptr %6717, i64 13705216
  store <4096 x float> zeroinitializer, ptr %6718, align 4
  %6719 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6720 = getelementptr float, ptr %6719, i64 13709312
  store <4096 x float> zeroinitializer, ptr %6720, align 4
  %6721 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6722 = getelementptr float, ptr %6721, i64 13713408
  store <4096 x float> zeroinitializer, ptr %6722, align 4
  %6723 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6724 = getelementptr float, ptr %6723, i64 13717504
  store <4096 x float> zeroinitializer, ptr %6724, align 4
  %6725 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6726 = getelementptr float, ptr %6725, i64 13721600
  store <4096 x float> zeroinitializer, ptr %6726, align 4
  %6727 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6728 = getelementptr float, ptr %6727, i64 13725696
  store <4096 x float> zeroinitializer, ptr %6728, align 4
  %6729 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6730 = getelementptr float, ptr %6729, i64 13729792
  store <4096 x float> zeroinitializer, ptr %6730, align 4
  %6731 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6732 = getelementptr float, ptr %6731, i64 13733888
  store <4096 x float> zeroinitializer, ptr %6732, align 4
  %6733 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6734 = getelementptr float, ptr %6733, i64 13737984
  store <4096 x float> zeroinitializer, ptr %6734, align 4
  %6735 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6736 = getelementptr float, ptr %6735, i64 13742080
  store <4096 x float> zeroinitializer, ptr %6736, align 4
  %6737 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6738 = getelementptr float, ptr %6737, i64 13746176
  store <4096 x float> zeroinitializer, ptr %6738, align 4
  %6739 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6740 = getelementptr float, ptr %6739, i64 13750272
  store <4096 x float> zeroinitializer, ptr %6740, align 4
  %6741 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6742 = getelementptr float, ptr %6741, i64 13754368
  store <4096 x float> zeroinitializer, ptr %6742, align 4
  %6743 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6744 = getelementptr float, ptr %6743, i64 13758464
  store <4096 x float> zeroinitializer, ptr %6744, align 4
  %6745 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6746 = getelementptr float, ptr %6745, i64 13762560
  store <4096 x float> zeroinitializer, ptr %6746, align 4
  %6747 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6748 = getelementptr float, ptr %6747, i64 13766656
  store <4096 x float> zeroinitializer, ptr %6748, align 4
  %6749 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6750 = getelementptr float, ptr %6749, i64 13770752
  store <4096 x float> zeroinitializer, ptr %6750, align 4
  %6751 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6752 = getelementptr float, ptr %6751, i64 13774848
  store <4096 x float> zeroinitializer, ptr %6752, align 4
  %6753 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6754 = getelementptr float, ptr %6753, i64 13778944
  store <4096 x float> zeroinitializer, ptr %6754, align 4
  %6755 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6756 = getelementptr float, ptr %6755, i64 13783040
  store <4096 x float> zeroinitializer, ptr %6756, align 4
  %6757 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6758 = getelementptr float, ptr %6757, i64 13787136
  store <4096 x float> zeroinitializer, ptr %6758, align 4
  %6759 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6760 = getelementptr float, ptr %6759, i64 13791232
  store <4096 x float> zeroinitializer, ptr %6760, align 4
  %6761 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6762 = getelementptr float, ptr %6761, i64 13795328
  store <4096 x float> zeroinitializer, ptr %6762, align 4
  %6763 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6764 = getelementptr float, ptr %6763, i64 13799424
  store <4096 x float> zeroinitializer, ptr %6764, align 4
  %6765 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6766 = getelementptr float, ptr %6765, i64 13803520
  store <4096 x float> zeroinitializer, ptr %6766, align 4
  %6767 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6768 = getelementptr float, ptr %6767, i64 13807616
  store <4096 x float> zeroinitializer, ptr %6768, align 4
  %6769 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6770 = getelementptr float, ptr %6769, i64 13811712
  store <4096 x float> zeroinitializer, ptr %6770, align 4
  %6771 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6772 = getelementptr float, ptr %6771, i64 13815808
  store <4096 x float> zeroinitializer, ptr %6772, align 4
  %6773 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6774 = getelementptr float, ptr %6773, i64 13819904
  store <4096 x float> zeroinitializer, ptr %6774, align 4
  %6775 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6776 = getelementptr float, ptr %6775, i64 13824000
  store <4096 x float> zeroinitializer, ptr %6776, align 4
  %6777 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6778 = getelementptr float, ptr %6777, i64 13828096
  store <4096 x float> zeroinitializer, ptr %6778, align 4
  %6779 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6780 = getelementptr float, ptr %6779, i64 13832192
  store <4096 x float> zeroinitializer, ptr %6780, align 4
  %6781 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6782 = getelementptr float, ptr %6781, i64 13836288
  store <4096 x float> zeroinitializer, ptr %6782, align 4
  %6783 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6784 = getelementptr float, ptr %6783, i64 13840384
  store <4096 x float> zeroinitializer, ptr %6784, align 4
  %6785 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6786 = getelementptr float, ptr %6785, i64 13844480
  store <4096 x float> zeroinitializer, ptr %6786, align 4
  %6787 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6788 = getelementptr float, ptr %6787, i64 13848576
  store <4096 x float> zeroinitializer, ptr %6788, align 4
  %6789 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6790 = getelementptr float, ptr %6789, i64 13852672
  store <4096 x float> zeroinitializer, ptr %6790, align 4
  %6791 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6792 = getelementptr float, ptr %6791, i64 13856768
  store <4096 x float> zeroinitializer, ptr %6792, align 4
  %6793 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6794 = getelementptr float, ptr %6793, i64 13860864
  store <4096 x float> zeroinitializer, ptr %6794, align 4
  %6795 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6796 = getelementptr float, ptr %6795, i64 13864960
  store <4096 x float> zeroinitializer, ptr %6796, align 4
  %6797 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6798 = getelementptr float, ptr %6797, i64 13869056
  store <4096 x float> zeroinitializer, ptr %6798, align 4
  %6799 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6800 = getelementptr float, ptr %6799, i64 13873152
  store <4096 x float> zeroinitializer, ptr %6800, align 4
  %6801 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6802 = getelementptr float, ptr %6801, i64 13877248
  store <4096 x float> zeroinitializer, ptr %6802, align 4
  %6803 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6804 = getelementptr float, ptr %6803, i64 13881344
  store <4096 x float> zeroinitializer, ptr %6804, align 4
  %6805 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6806 = getelementptr float, ptr %6805, i64 13885440
  store <4096 x float> zeroinitializer, ptr %6806, align 4
  %6807 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6808 = getelementptr float, ptr %6807, i64 13889536
  store <4096 x float> zeroinitializer, ptr %6808, align 4
  %6809 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6810 = getelementptr float, ptr %6809, i64 13893632
  store <4096 x float> zeroinitializer, ptr %6810, align 4
  %6811 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6812 = getelementptr float, ptr %6811, i64 13897728
  store <4096 x float> zeroinitializer, ptr %6812, align 4
  %6813 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6814 = getelementptr float, ptr %6813, i64 13901824
  store <4096 x float> zeroinitializer, ptr %6814, align 4
  %6815 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6816 = getelementptr float, ptr %6815, i64 13905920
  store <4096 x float> zeroinitializer, ptr %6816, align 4
  %6817 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6818 = getelementptr float, ptr %6817, i64 13910016
  store <4096 x float> zeroinitializer, ptr %6818, align 4
  %6819 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6820 = getelementptr float, ptr %6819, i64 13914112
  store <4096 x float> zeroinitializer, ptr %6820, align 4
  %6821 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6822 = getelementptr float, ptr %6821, i64 13918208
  store <4096 x float> zeroinitializer, ptr %6822, align 4
  %6823 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6824 = getelementptr float, ptr %6823, i64 13922304
  store <4096 x float> zeroinitializer, ptr %6824, align 4
  %6825 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6826 = getelementptr float, ptr %6825, i64 13926400
  store <4096 x float> zeroinitializer, ptr %6826, align 4
  %6827 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6828 = getelementptr float, ptr %6827, i64 13930496
  store <4096 x float> zeroinitializer, ptr %6828, align 4
  %6829 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6830 = getelementptr float, ptr %6829, i64 13934592
  store <4096 x float> zeroinitializer, ptr %6830, align 4
  %6831 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6832 = getelementptr float, ptr %6831, i64 13938688
  store <4096 x float> zeroinitializer, ptr %6832, align 4
  %6833 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6834 = getelementptr float, ptr %6833, i64 13942784
  store <4096 x float> zeroinitializer, ptr %6834, align 4
  %6835 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6836 = getelementptr float, ptr %6835, i64 13946880
  store <4096 x float> zeroinitializer, ptr %6836, align 4
  %6837 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6838 = getelementptr float, ptr %6837, i64 13950976
  store <4096 x float> zeroinitializer, ptr %6838, align 4
  %6839 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6840 = getelementptr float, ptr %6839, i64 13955072
  store <4096 x float> zeroinitializer, ptr %6840, align 4
  %6841 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6842 = getelementptr float, ptr %6841, i64 13959168
  store <4096 x float> zeroinitializer, ptr %6842, align 4
  %6843 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6844 = getelementptr float, ptr %6843, i64 13963264
  store <4096 x float> zeroinitializer, ptr %6844, align 4
  %6845 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6846 = getelementptr float, ptr %6845, i64 13967360
  store <4096 x float> zeroinitializer, ptr %6846, align 4
  %6847 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6848 = getelementptr float, ptr %6847, i64 13971456
  store <4096 x float> zeroinitializer, ptr %6848, align 4
  %6849 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6850 = getelementptr float, ptr %6849, i64 13975552
  store <4096 x float> zeroinitializer, ptr %6850, align 4
  %6851 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6852 = getelementptr float, ptr %6851, i64 13979648
  store <4096 x float> zeroinitializer, ptr %6852, align 4
  %6853 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6854 = getelementptr float, ptr %6853, i64 13983744
  store <4096 x float> zeroinitializer, ptr %6854, align 4
  %6855 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6856 = getelementptr float, ptr %6855, i64 13987840
  store <4096 x float> zeroinitializer, ptr %6856, align 4
  %6857 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6858 = getelementptr float, ptr %6857, i64 13991936
  store <4096 x float> zeroinitializer, ptr %6858, align 4
  %6859 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6860 = getelementptr float, ptr %6859, i64 13996032
  store <4096 x float> zeroinitializer, ptr %6860, align 4
  %6861 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6862 = getelementptr float, ptr %6861, i64 14000128
  store <4096 x float> zeroinitializer, ptr %6862, align 4
  %6863 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6864 = getelementptr float, ptr %6863, i64 14004224
  store <4096 x float> zeroinitializer, ptr %6864, align 4
  %6865 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6866 = getelementptr float, ptr %6865, i64 14008320
  store <4096 x float> zeroinitializer, ptr %6866, align 4
  %6867 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6868 = getelementptr float, ptr %6867, i64 14012416
  store <4096 x float> zeroinitializer, ptr %6868, align 4
  %6869 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6870 = getelementptr float, ptr %6869, i64 14016512
  store <4096 x float> zeroinitializer, ptr %6870, align 4
  %6871 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6872 = getelementptr float, ptr %6871, i64 14020608
  store <4096 x float> zeroinitializer, ptr %6872, align 4
  %6873 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6874 = getelementptr float, ptr %6873, i64 14024704
  store <4096 x float> zeroinitializer, ptr %6874, align 4
  %6875 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6876 = getelementptr float, ptr %6875, i64 14028800
  store <4096 x float> zeroinitializer, ptr %6876, align 4
  %6877 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6878 = getelementptr float, ptr %6877, i64 14032896
  store <4096 x float> zeroinitializer, ptr %6878, align 4
  %6879 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6880 = getelementptr float, ptr %6879, i64 14036992
  store <4096 x float> zeroinitializer, ptr %6880, align 4
  %6881 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6882 = getelementptr float, ptr %6881, i64 14041088
  store <4096 x float> zeroinitializer, ptr %6882, align 4
  %6883 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6884 = getelementptr float, ptr %6883, i64 14045184
  store <4096 x float> zeroinitializer, ptr %6884, align 4
  %6885 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6886 = getelementptr float, ptr %6885, i64 14049280
  store <4096 x float> zeroinitializer, ptr %6886, align 4
  %6887 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6888 = getelementptr float, ptr %6887, i64 14053376
  store <4096 x float> zeroinitializer, ptr %6888, align 4
  %6889 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6890 = getelementptr float, ptr %6889, i64 14057472
  store <4096 x float> zeroinitializer, ptr %6890, align 4
  %6891 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6892 = getelementptr float, ptr %6891, i64 14061568
  store <4096 x float> zeroinitializer, ptr %6892, align 4
  %6893 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6894 = getelementptr float, ptr %6893, i64 14065664
  store <4096 x float> zeroinitializer, ptr %6894, align 4
  %6895 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6896 = getelementptr float, ptr %6895, i64 14069760
  store <4096 x float> zeroinitializer, ptr %6896, align 4
  %6897 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6898 = getelementptr float, ptr %6897, i64 14073856
  store <4096 x float> zeroinitializer, ptr %6898, align 4
  %6899 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6900 = getelementptr float, ptr %6899, i64 14077952
  store <4096 x float> zeroinitializer, ptr %6900, align 4
  %6901 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6902 = getelementptr float, ptr %6901, i64 14082048
  store <4096 x float> zeroinitializer, ptr %6902, align 4
  %6903 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6904 = getelementptr float, ptr %6903, i64 14086144
  store <4096 x float> zeroinitializer, ptr %6904, align 4
  %6905 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6906 = getelementptr float, ptr %6905, i64 14090240
  store <4096 x float> zeroinitializer, ptr %6906, align 4
  %6907 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6908 = getelementptr float, ptr %6907, i64 14094336
  store <4096 x float> zeroinitializer, ptr %6908, align 4
  %6909 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6910 = getelementptr float, ptr %6909, i64 14098432
  store <4096 x float> zeroinitializer, ptr %6910, align 4
  %6911 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6912 = getelementptr float, ptr %6911, i64 14102528
  store <4096 x float> zeroinitializer, ptr %6912, align 4
  %6913 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6914 = getelementptr float, ptr %6913, i64 14106624
  store <4096 x float> zeroinitializer, ptr %6914, align 4
  %6915 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6916 = getelementptr float, ptr %6915, i64 14110720
  store <4096 x float> zeroinitializer, ptr %6916, align 4
  %6917 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6918 = getelementptr float, ptr %6917, i64 14114816
  store <4096 x float> zeroinitializer, ptr %6918, align 4
  %6919 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6920 = getelementptr float, ptr %6919, i64 14118912
  store <4096 x float> zeroinitializer, ptr %6920, align 4
  %6921 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6922 = getelementptr float, ptr %6921, i64 14123008
  store <4096 x float> zeroinitializer, ptr %6922, align 4
  %6923 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6924 = getelementptr float, ptr %6923, i64 14127104
  store <4096 x float> zeroinitializer, ptr %6924, align 4
  %6925 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6926 = getelementptr float, ptr %6925, i64 14131200
  store <4096 x float> zeroinitializer, ptr %6926, align 4
  %6927 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6928 = getelementptr float, ptr %6927, i64 14135296
  store <4096 x float> zeroinitializer, ptr %6928, align 4
  %6929 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6930 = getelementptr float, ptr %6929, i64 14139392
  store <4096 x float> zeroinitializer, ptr %6930, align 4
  %6931 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6932 = getelementptr float, ptr %6931, i64 14143488
  store <4096 x float> zeroinitializer, ptr %6932, align 4
  %6933 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6934 = getelementptr float, ptr %6933, i64 14147584
  store <4096 x float> zeroinitializer, ptr %6934, align 4
  %6935 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6936 = getelementptr float, ptr %6935, i64 14151680
  store <4096 x float> zeroinitializer, ptr %6936, align 4
  %6937 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6938 = getelementptr float, ptr %6937, i64 14155776
  store <4096 x float> zeroinitializer, ptr %6938, align 4
  %6939 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6940 = getelementptr float, ptr %6939, i64 14159872
  store <4096 x float> zeroinitializer, ptr %6940, align 4
  %6941 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6942 = getelementptr float, ptr %6941, i64 14163968
  store <4096 x float> zeroinitializer, ptr %6942, align 4
  %6943 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6944 = getelementptr float, ptr %6943, i64 14168064
  store <4096 x float> zeroinitializer, ptr %6944, align 4
  %6945 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6946 = getelementptr float, ptr %6945, i64 14172160
  store <4096 x float> zeroinitializer, ptr %6946, align 4
  %6947 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6948 = getelementptr float, ptr %6947, i64 14176256
  store <4096 x float> zeroinitializer, ptr %6948, align 4
  %6949 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6950 = getelementptr float, ptr %6949, i64 14180352
  store <4096 x float> zeroinitializer, ptr %6950, align 4
  %6951 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6952 = getelementptr float, ptr %6951, i64 14184448
  store <4096 x float> zeroinitializer, ptr %6952, align 4
  %6953 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6954 = getelementptr float, ptr %6953, i64 14188544
  store <4096 x float> zeroinitializer, ptr %6954, align 4
  %6955 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6956 = getelementptr float, ptr %6955, i64 14192640
  store <4096 x float> zeroinitializer, ptr %6956, align 4
  %6957 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6958 = getelementptr float, ptr %6957, i64 14196736
  store <4096 x float> zeroinitializer, ptr %6958, align 4
  %6959 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6960 = getelementptr float, ptr %6959, i64 14200832
  store <4096 x float> zeroinitializer, ptr %6960, align 4
  %6961 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6962 = getelementptr float, ptr %6961, i64 14204928
  store <4096 x float> zeroinitializer, ptr %6962, align 4
  %6963 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6964 = getelementptr float, ptr %6963, i64 14209024
  store <4096 x float> zeroinitializer, ptr %6964, align 4
  %6965 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6966 = getelementptr float, ptr %6965, i64 14213120
  store <4096 x float> zeroinitializer, ptr %6966, align 4
  %6967 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6968 = getelementptr float, ptr %6967, i64 14217216
  store <4096 x float> zeroinitializer, ptr %6968, align 4
  %6969 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6970 = getelementptr float, ptr %6969, i64 14221312
  store <4096 x float> zeroinitializer, ptr %6970, align 4
  %6971 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6972 = getelementptr float, ptr %6971, i64 14225408
  store <4096 x float> zeroinitializer, ptr %6972, align 4
  %6973 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6974 = getelementptr float, ptr %6973, i64 14229504
  store <4096 x float> zeroinitializer, ptr %6974, align 4
  %6975 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6976 = getelementptr float, ptr %6975, i64 14233600
  store <4096 x float> zeroinitializer, ptr %6976, align 4
  %6977 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6978 = getelementptr float, ptr %6977, i64 14237696
  store <4096 x float> zeroinitializer, ptr %6978, align 4
  %6979 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6980 = getelementptr float, ptr %6979, i64 14241792
  store <4096 x float> zeroinitializer, ptr %6980, align 4
  %6981 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6982 = getelementptr float, ptr %6981, i64 14245888
  store <4096 x float> zeroinitializer, ptr %6982, align 4
  %6983 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6984 = getelementptr float, ptr %6983, i64 14249984
  store <4096 x float> zeroinitializer, ptr %6984, align 4
  %6985 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6986 = getelementptr float, ptr %6985, i64 14254080
  store <4096 x float> zeroinitializer, ptr %6986, align 4
  %6987 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6988 = getelementptr float, ptr %6987, i64 14258176
  store <4096 x float> zeroinitializer, ptr %6988, align 4
  %6989 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6990 = getelementptr float, ptr %6989, i64 14262272
  store <4096 x float> zeroinitializer, ptr %6990, align 4
  %6991 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6992 = getelementptr float, ptr %6991, i64 14266368
  store <4096 x float> zeroinitializer, ptr %6992, align 4
  %6993 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6994 = getelementptr float, ptr %6993, i64 14270464
  store <4096 x float> zeroinitializer, ptr %6994, align 4
  %6995 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6996 = getelementptr float, ptr %6995, i64 14274560
  store <4096 x float> zeroinitializer, ptr %6996, align 4
  %6997 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %6998 = getelementptr float, ptr %6997, i64 14278656
  store <4096 x float> zeroinitializer, ptr %6998, align 4
  %6999 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7000 = getelementptr float, ptr %6999, i64 14282752
  store <4096 x float> zeroinitializer, ptr %7000, align 4
  %7001 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7002 = getelementptr float, ptr %7001, i64 14286848
  store <4096 x float> zeroinitializer, ptr %7002, align 4
  %7003 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7004 = getelementptr float, ptr %7003, i64 14290944
  store <4096 x float> zeroinitializer, ptr %7004, align 4
  %7005 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7006 = getelementptr float, ptr %7005, i64 14295040
  store <4096 x float> zeroinitializer, ptr %7006, align 4
  %7007 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7008 = getelementptr float, ptr %7007, i64 14299136
  store <4096 x float> zeroinitializer, ptr %7008, align 4
  %7009 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7010 = getelementptr float, ptr %7009, i64 14303232
  store <4096 x float> zeroinitializer, ptr %7010, align 4
  %7011 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7012 = getelementptr float, ptr %7011, i64 14307328
  store <4096 x float> zeroinitializer, ptr %7012, align 4
  %7013 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7014 = getelementptr float, ptr %7013, i64 14311424
  store <4096 x float> zeroinitializer, ptr %7014, align 4
  %7015 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7016 = getelementptr float, ptr %7015, i64 14315520
  store <4096 x float> zeroinitializer, ptr %7016, align 4
  %7017 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7018 = getelementptr float, ptr %7017, i64 14319616
  store <4096 x float> zeroinitializer, ptr %7018, align 4
  %7019 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7020 = getelementptr float, ptr %7019, i64 14323712
  store <4096 x float> zeroinitializer, ptr %7020, align 4
  %7021 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7022 = getelementptr float, ptr %7021, i64 14327808
  store <4096 x float> zeroinitializer, ptr %7022, align 4
  %7023 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7024 = getelementptr float, ptr %7023, i64 14331904
  store <4096 x float> zeroinitializer, ptr %7024, align 4
  %7025 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7026 = getelementptr float, ptr %7025, i64 14336000
  store <4096 x float> zeroinitializer, ptr %7026, align 4
  %7027 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7028 = getelementptr float, ptr %7027, i64 14340096
  store <4096 x float> zeroinitializer, ptr %7028, align 4
  %7029 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7030 = getelementptr float, ptr %7029, i64 14344192
  store <4096 x float> zeroinitializer, ptr %7030, align 4
  %7031 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7032 = getelementptr float, ptr %7031, i64 14348288
  store <4096 x float> zeroinitializer, ptr %7032, align 4
  %7033 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7034 = getelementptr float, ptr %7033, i64 14352384
  store <4096 x float> zeroinitializer, ptr %7034, align 4
  %7035 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7036 = getelementptr float, ptr %7035, i64 14356480
  store <4096 x float> zeroinitializer, ptr %7036, align 4
  %7037 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7038 = getelementptr float, ptr %7037, i64 14360576
  store <4096 x float> zeroinitializer, ptr %7038, align 4
  %7039 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7040 = getelementptr float, ptr %7039, i64 14364672
  store <4096 x float> zeroinitializer, ptr %7040, align 4
  %7041 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7042 = getelementptr float, ptr %7041, i64 14368768
  store <4096 x float> zeroinitializer, ptr %7042, align 4
  %7043 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7044 = getelementptr float, ptr %7043, i64 14372864
  store <4096 x float> zeroinitializer, ptr %7044, align 4
  %7045 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7046 = getelementptr float, ptr %7045, i64 14376960
  store <4096 x float> zeroinitializer, ptr %7046, align 4
  %7047 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7048 = getelementptr float, ptr %7047, i64 14381056
  store <4096 x float> zeroinitializer, ptr %7048, align 4
  %7049 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7050 = getelementptr float, ptr %7049, i64 14385152
  store <4096 x float> zeroinitializer, ptr %7050, align 4
  %7051 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7052 = getelementptr float, ptr %7051, i64 14389248
  store <4096 x float> zeroinitializer, ptr %7052, align 4
  %7053 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7054 = getelementptr float, ptr %7053, i64 14393344
  store <4096 x float> zeroinitializer, ptr %7054, align 4
  %7055 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7056 = getelementptr float, ptr %7055, i64 14397440
  store <4096 x float> zeroinitializer, ptr %7056, align 4
  %7057 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7058 = getelementptr float, ptr %7057, i64 14401536
  store <4096 x float> zeroinitializer, ptr %7058, align 4
  %7059 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7060 = getelementptr float, ptr %7059, i64 14405632
  store <4096 x float> zeroinitializer, ptr %7060, align 4
  %7061 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7062 = getelementptr float, ptr %7061, i64 14409728
  store <4096 x float> zeroinitializer, ptr %7062, align 4
  %7063 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7064 = getelementptr float, ptr %7063, i64 14413824
  store <4096 x float> zeroinitializer, ptr %7064, align 4
  %7065 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7066 = getelementptr float, ptr %7065, i64 14417920
  store <4096 x float> zeroinitializer, ptr %7066, align 4
  %7067 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7068 = getelementptr float, ptr %7067, i64 14422016
  store <4096 x float> zeroinitializer, ptr %7068, align 4
  %7069 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7070 = getelementptr float, ptr %7069, i64 14426112
  store <4096 x float> zeroinitializer, ptr %7070, align 4
  %7071 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7072 = getelementptr float, ptr %7071, i64 14430208
  store <4096 x float> zeroinitializer, ptr %7072, align 4
  %7073 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7074 = getelementptr float, ptr %7073, i64 14434304
  store <4096 x float> zeroinitializer, ptr %7074, align 4
  %7075 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7076 = getelementptr float, ptr %7075, i64 14438400
  store <4096 x float> zeroinitializer, ptr %7076, align 4
  %7077 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7078 = getelementptr float, ptr %7077, i64 14442496
  store <4096 x float> zeroinitializer, ptr %7078, align 4
  %7079 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7080 = getelementptr float, ptr %7079, i64 14446592
  store <4096 x float> zeroinitializer, ptr %7080, align 4
  %7081 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7082 = getelementptr float, ptr %7081, i64 14450688
  store <4096 x float> zeroinitializer, ptr %7082, align 4
  %7083 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7084 = getelementptr float, ptr %7083, i64 14454784
  store <4096 x float> zeroinitializer, ptr %7084, align 4
  %7085 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7086 = getelementptr float, ptr %7085, i64 14458880
  store <4096 x float> zeroinitializer, ptr %7086, align 4
  %7087 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7088 = getelementptr float, ptr %7087, i64 14462976
  store <4096 x float> zeroinitializer, ptr %7088, align 4
  %7089 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7090 = getelementptr float, ptr %7089, i64 14467072
  store <4096 x float> zeroinitializer, ptr %7090, align 4
  %7091 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7092 = getelementptr float, ptr %7091, i64 14471168
  store <4096 x float> zeroinitializer, ptr %7092, align 4
  %7093 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7094 = getelementptr float, ptr %7093, i64 14475264
  store <4096 x float> zeroinitializer, ptr %7094, align 4
  %7095 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7096 = getelementptr float, ptr %7095, i64 14479360
  store <4096 x float> zeroinitializer, ptr %7096, align 4
  %7097 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7098 = getelementptr float, ptr %7097, i64 14483456
  store <4096 x float> zeroinitializer, ptr %7098, align 4
  %7099 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7100 = getelementptr float, ptr %7099, i64 14487552
  store <4096 x float> zeroinitializer, ptr %7100, align 4
  %7101 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7102 = getelementptr float, ptr %7101, i64 14491648
  store <4096 x float> zeroinitializer, ptr %7102, align 4
  %7103 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7104 = getelementptr float, ptr %7103, i64 14495744
  store <4096 x float> zeroinitializer, ptr %7104, align 4
  %7105 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7106 = getelementptr float, ptr %7105, i64 14499840
  store <4096 x float> zeroinitializer, ptr %7106, align 4
  %7107 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7108 = getelementptr float, ptr %7107, i64 14503936
  store <4096 x float> zeroinitializer, ptr %7108, align 4
  %7109 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7110 = getelementptr float, ptr %7109, i64 14508032
  store <4096 x float> zeroinitializer, ptr %7110, align 4
  %7111 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7112 = getelementptr float, ptr %7111, i64 14512128
  store <4096 x float> zeroinitializer, ptr %7112, align 4
  %7113 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7114 = getelementptr float, ptr %7113, i64 14516224
  store <4096 x float> zeroinitializer, ptr %7114, align 4
  %7115 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7116 = getelementptr float, ptr %7115, i64 14520320
  store <4096 x float> zeroinitializer, ptr %7116, align 4
  %7117 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7118 = getelementptr float, ptr %7117, i64 14524416
  store <4096 x float> zeroinitializer, ptr %7118, align 4
  %7119 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7120 = getelementptr float, ptr %7119, i64 14528512
  store <4096 x float> zeroinitializer, ptr %7120, align 4
  %7121 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7122 = getelementptr float, ptr %7121, i64 14532608
  store <4096 x float> zeroinitializer, ptr %7122, align 4
  %7123 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7124 = getelementptr float, ptr %7123, i64 14536704
  store <4096 x float> zeroinitializer, ptr %7124, align 4
  %7125 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7126 = getelementptr float, ptr %7125, i64 14540800
  store <4096 x float> zeroinitializer, ptr %7126, align 4
  %7127 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7128 = getelementptr float, ptr %7127, i64 14544896
  store <4096 x float> zeroinitializer, ptr %7128, align 4
  %7129 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7130 = getelementptr float, ptr %7129, i64 14548992
  store <4096 x float> zeroinitializer, ptr %7130, align 4
  %7131 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7132 = getelementptr float, ptr %7131, i64 14553088
  store <4096 x float> zeroinitializer, ptr %7132, align 4
  %7133 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7134 = getelementptr float, ptr %7133, i64 14557184
  store <4096 x float> zeroinitializer, ptr %7134, align 4
  %7135 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7136 = getelementptr float, ptr %7135, i64 14561280
  store <4096 x float> zeroinitializer, ptr %7136, align 4
  %7137 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7138 = getelementptr float, ptr %7137, i64 14565376
  store <4096 x float> zeroinitializer, ptr %7138, align 4
  %7139 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7140 = getelementptr float, ptr %7139, i64 14569472
  store <4096 x float> zeroinitializer, ptr %7140, align 4
  %7141 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7142 = getelementptr float, ptr %7141, i64 14573568
  store <4096 x float> zeroinitializer, ptr %7142, align 4
  %7143 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7144 = getelementptr float, ptr %7143, i64 14577664
  store <4096 x float> zeroinitializer, ptr %7144, align 4
  %7145 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7146 = getelementptr float, ptr %7145, i64 14581760
  store <4096 x float> zeroinitializer, ptr %7146, align 4
  %7147 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7148 = getelementptr float, ptr %7147, i64 14585856
  store <4096 x float> zeroinitializer, ptr %7148, align 4
  %7149 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7150 = getelementptr float, ptr %7149, i64 14589952
  store <4096 x float> zeroinitializer, ptr %7150, align 4
  %7151 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7152 = getelementptr float, ptr %7151, i64 14594048
  store <4096 x float> zeroinitializer, ptr %7152, align 4
  %7153 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7154 = getelementptr float, ptr %7153, i64 14598144
  store <4096 x float> zeroinitializer, ptr %7154, align 4
  %7155 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7156 = getelementptr float, ptr %7155, i64 14602240
  store <4096 x float> zeroinitializer, ptr %7156, align 4
  %7157 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7158 = getelementptr float, ptr %7157, i64 14606336
  store <4096 x float> zeroinitializer, ptr %7158, align 4
  %7159 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7160 = getelementptr float, ptr %7159, i64 14610432
  store <4096 x float> zeroinitializer, ptr %7160, align 4
  %7161 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7162 = getelementptr float, ptr %7161, i64 14614528
  store <4096 x float> zeroinitializer, ptr %7162, align 4
  %7163 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7164 = getelementptr float, ptr %7163, i64 14618624
  store <4096 x float> zeroinitializer, ptr %7164, align 4
  %7165 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7166 = getelementptr float, ptr %7165, i64 14622720
  store <4096 x float> zeroinitializer, ptr %7166, align 4
  %7167 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7168 = getelementptr float, ptr %7167, i64 14626816
  store <4096 x float> zeroinitializer, ptr %7168, align 4
  %7169 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7170 = getelementptr float, ptr %7169, i64 14630912
  store <4096 x float> zeroinitializer, ptr %7170, align 4
  %7171 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7172 = getelementptr float, ptr %7171, i64 14635008
  store <4096 x float> zeroinitializer, ptr %7172, align 4
  %7173 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7174 = getelementptr float, ptr %7173, i64 14639104
  store <4096 x float> zeroinitializer, ptr %7174, align 4
  %7175 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7176 = getelementptr float, ptr %7175, i64 14643200
  store <4096 x float> zeroinitializer, ptr %7176, align 4
  %7177 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7178 = getelementptr float, ptr %7177, i64 14647296
  store <4096 x float> zeroinitializer, ptr %7178, align 4
  %7179 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7180 = getelementptr float, ptr %7179, i64 14651392
  store <4096 x float> zeroinitializer, ptr %7180, align 4
  %7181 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7182 = getelementptr float, ptr %7181, i64 14655488
  store <4096 x float> zeroinitializer, ptr %7182, align 4
  %7183 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7184 = getelementptr float, ptr %7183, i64 14659584
  store <4096 x float> zeroinitializer, ptr %7184, align 4
  %7185 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7186 = getelementptr float, ptr %7185, i64 14663680
  store <4096 x float> zeroinitializer, ptr %7186, align 4
  %7187 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7188 = getelementptr float, ptr %7187, i64 14667776
  store <4096 x float> zeroinitializer, ptr %7188, align 4
  %7189 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7190 = getelementptr float, ptr %7189, i64 14671872
  store <4096 x float> zeroinitializer, ptr %7190, align 4
  %7191 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7192 = getelementptr float, ptr %7191, i64 14675968
  store <4096 x float> zeroinitializer, ptr %7192, align 4
  %7193 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7194 = getelementptr float, ptr %7193, i64 14680064
  store <4096 x float> zeroinitializer, ptr %7194, align 4
  %7195 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7196 = getelementptr float, ptr %7195, i64 14684160
  store <4096 x float> zeroinitializer, ptr %7196, align 4
  %7197 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7198 = getelementptr float, ptr %7197, i64 14688256
  store <4096 x float> zeroinitializer, ptr %7198, align 4
  %7199 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7200 = getelementptr float, ptr %7199, i64 14692352
  store <4096 x float> zeroinitializer, ptr %7200, align 4
  %7201 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7202 = getelementptr float, ptr %7201, i64 14696448
  store <4096 x float> zeroinitializer, ptr %7202, align 4
  %7203 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7204 = getelementptr float, ptr %7203, i64 14700544
  store <4096 x float> zeroinitializer, ptr %7204, align 4
  %7205 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7206 = getelementptr float, ptr %7205, i64 14704640
  store <4096 x float> zeroinitializer, ptr %7206, align 4
  %7207 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7208 = getelementptr float, ptr %7207, i64 14708736
  store <4096 x float> zeroinitializer, ptr %7208, align 4
  %7209 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7210 = getelementptr float, ptr %7209, i64 14712832
  store <4096 x float> zeroinitializer, ptr %7210, align 4
  %7211 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7212 = getelementptr float, ptr %7211, i64 14716928
  store <4096 x float> zeroinitializer, ptr %7212, align 4
  %7213 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7214 = getelementptr float, ptr %7213, i64 14721024
  store <4096 x float> zeroinitializer, ptr %7214, align 4
  %7215 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7216 = getelementptr float, ptr %7215, i64 14725120
  store <4096 x float> zeroinitializer, ptr %7216, align 4
  %7217 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7218 = getelementptr float, ptr %7217, i64 14729216
  store <4096 x float> zeroinitializer, ptr %7218, align 4
  %7219 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7220 = getelementptr float, ptr %7219, i64 14733312
  store <4096 x float> zeroinitializer, ptr %7220, align 4
  %7221 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7222 = getelementptr float, ptr %7221, i64 14737408
  store <4096 x float> zeroinitializer, ptr %7222, align 4
  %7223 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7224 = getelementptr float, ptr %7223, i64 14741504
  store <4096 x float> zeroinitializer, ptr %7224, align 4
  %7225 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7226 = getelementptr float, ptr %7225, i64 14745600
  store <4096 x float> zeroinitializer, ptr %7226, align 4
  %7227 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7228 = getelementptr float, ptr %7227, i64 14749696
  store <4096 x float> zeroinitializer, ptr %7228, align 4
  %7229 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7230 = getelementptr float, ptr %7229, i64 14753792
  store <4096 x float> zeroinitializer, ptr %7230, align 4
  %7231 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7232 = getelementptr float, ptr %7231, i64 14757888
  store <4096 x float> zeroinitializer, ptr %7232, align 4
  %7233 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7234 = getelementptr float, ptr %7233, i64 14761984
  store <4096 x float> zeroinitializer, ptr %7234, align 4
  %7235 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7236 = getelementptr float, ptr %7235, i64 14766080
  store <4096 x float> zeroinitializer, ptr %7236, align 4
  %7237 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7238 = getelementptr float, ptr %7237, i64 14770176
  store <4096 x float> zeroinitializer, ptr %7238, align 4
  %7239 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7240 = getelementptr float, ptr %7239, i64 14774272
  store <4096 x float> zeroinitializer, ptr %7240, align 4
  %7241 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7242 = getelementptr float, ptr %7241, i64 14778368
  store <4096 x float> zeroinitializer, ptr %7242, align 4
  %7243 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7244 = getelementptr float, ptr %7243, i64 14782464
  store <4096 x float> zeroinitializer, ptr %7244, align 4
  %7245 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7246 = getelementptr float, ptr %7245, i64 14786560
  store <4096 x float> zeroinitializer, ptr %7246, align 4
  %7247 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7248 = getelementptr float, ptr %7247, i64 14790656
  store <4096 x float> zeroinitializer, ptr %7248, align 4
  %7249 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7250 = getelementptr float, ptr %7249, i64 14794752
  store <4096 x float> zeroinitializer, ptr %7250, align 4
  %7251 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7252 = getelementptr float, ptr %7251, i64 14798848
  store <4096 x float> zeroinitializer, ptr %7252, align 4
  %7253 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7254 = getelementptr float, ptr %7253, i64 14802944
  store <4096 x float> zeroinitializer, ptr %7254, align 4
  %7255 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7256 = getelementptr float, ptr %7255, i64 14807040
  store <4096 x float> zeroinitializer, ptr %7256, align 4
  %7257 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7258 = getelementptr float, ptr %7257, i64 14811136
  store <4096 x float> zeroinitializer, ptr %7258, align 4
  %7259 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7260 = getelementptr float, ptr %7259, i64 14815232
  store <4096 x float> zeroinitializer, ptr %7260, align 4
  %7261 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7262 = getelementptr float, ptr %7261, i64 14819328
  store <4096 x float> zeroinitializer, ptr %7262, align 4
  %7263 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7264 = getelementptr float, ptr %7263, i64 14823424
  store <4096 x float> zeroinitializer, ptr %7264, align 4
  %7265 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7266 = getelementptr float, ptr %7265, i64 14827520
  store <4096 x float> zeroinitializer, ptr %7266, align 4
  %7267 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7268 = getelementptr float, ptr %7267, i64 14831616
  store <4096 x float> zeroinitializer, ptr %7268, align 4
  %7269 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7270 = getelementptr float, ptr %7269, i64 14835712
  store <4096 x float> zeroinitializer, ptr %7270, align 4
  %7271 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7272 = getelementptr float, ptr %7271, i64 14839808
  store <4096 x float> zeroinitializer, ptr %7272, align 4
  %7273 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7274 = getelementptr float, ptr %7273, i64 14843904
  store <4096 x float> zeroinitializer, ptr %7274, align 4
  %7275 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7276 = getelementptr float, ptr %7275, i64 14848000
  store <4096 x float> zeroinitializer, ptr %7276, align 4
  %7277 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7278 = getelementptr float, ptr %7277, i64 14852096
  store <4096 x float> zeroinitializer, ptr %7278, align 4
  %7279 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7280 = getelementptr float, ptr %7279, i64 14856192
  store <4096 x float> zeroinitializer, ptr %7280, align 4
  %7281 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7282 = getelementptr float, ptr %7281, i64 14860288
  store <4096 x float> zeroinitializer, ptr %7282, align 4
  %7283 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7284 = getelementptr float, ptr %7283, i64 14864384
  store <4096 x float> zeroinitializer, ptr %7284, align 4
  %7285 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7286 = getelementptr float, ptr %7285, i64 14868480
  store <4096 x float> zeroinitializer, ptr %7286, align 4
  %7287 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7288 = getelementptr float, ptr %7287, i64 14872576
  store <4096 x float> zeroinitializer, ptr %7288, align 4
  %7289 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7290 = getelementptr float, ptr %7289, i64 14876672
  store <4096 x float> zeroinitializer, ptr %7290, align 4
  %7291 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7292 = getelementptr float, ptr %7291, i64 14880768
  store <4096 x float> zeroinitializer, ptr %7292, align 4
  %7293 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7294 = getelementptr float, ptr %7293, i64 14884864
  store <4096 x float> zeroinitializer, ptr %7294, align 4
  %7295 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7296 = getelementptr float, ptr %7295, i64 14888960
  store <4096 x float> zeroinitializer, ptr %7296, align 4
  %7297 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7298 = getelementptr float, ptr %7297, i64 14893056
  store <4096 x float> zeroinitializer, ptr %7298, align 4
  %7299 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7300 = getelementptr float, ptr %7299, i64 14897152
  store <4096 x float> zeroinitializer, ptr %7300, align 4
  %7301 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7302 = getelementptr float, ptr %7301, i64 14901248
  store <4096 x float> zeroinitializer, ptr %7302, align 4
  %7303 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7304 = getelementptr float, ptr %7303, i64 14905344
  store <4096 x float> zeroinitializer, ptr %7304, align 4
  %7305 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7306 = getelementptr float, ptr %7305, i64 14909440
  store <4096 x float> zeroinitializer, ptr %7306, align 4
  %7307 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7308 = getelementptr float, ptr %7307, i64 14913536
  store <4096 x float> zeroinitializer, ptr %7308, align 4
  %7309 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7310 = getelementptr float, ptr %7309, i64 14917632
  store <4096 x float> zeroinitializer, ptr %7310, align 4
  %7311 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7312 = getelementptr float, ptr %7311, i64 14921728
  store <4096 x float> zeroinitializer, ptr %7312, align 4
  %7313 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7314 = getelementptr float, ptr %7313, i64 14925824
  store <4096 x float> zeroinitializer, ptr %7314, align 4
  %7315 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7316 = getelementptr float, ptr %7315, i64 14929920
  store <4096 x float> zeroinitializer, ptr %7316, align 4
  %7317 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7318 = getelementptr float, ptr %7317, i64 14934016
  store <4096 x float> zeroinitializer, ptr %7318, align 4
  %7319 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7320 = getelementptr float, ptr %7319, i64 14938112
  store <4096 x float> zeroinitializer, ptr %7320, align 4
  %7321 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7322 = getelementptr float, ptr %7321, i64 14942208
  store <4096 x float> zeroinitializer, ptr %7322, align 4
  %7323 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7324 = getelementptr float, ptr %7323, i64 14946304
  store <4096 x float> zeroinitializer, ptr %7324, align 4
  %7325 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7326 = getelementptr float, ptr %7325, i64 14950400
  store <4096 x float> zeroinitializer, ptr %7326, align 4
  %7327 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7328 = getelementptr float, ptr %7327, i64 14954496
  store <4096 x float> zeroinitializer, ptr %7328, align 4
  %7329 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7330 = getelementptr float, ptr %7329, i64 14958592
  store <4096 x float> zeroinitializer, ptr %7330, align 4
  %7331 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7332 = getelementptr float, ptr %7331, i64 14962688
  store <4096 x float> zeroinitializer, ptr %7332, align 4
  %7333 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7334 = getelementptr float, ptr %7333, i64 14966784
  store <4096 x float> zeroinitializer, ptr %7334, align 4
  %7335 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7336 = getelementptr float, ptr %7335, i64 14970880
  store <4096 x float> zeroinitializer, ptr %7336, align 4
  %7337 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7338 = getelementptr float, ptr %7337, i64 14974976
  store <4096 x float> zeroinitializer, ptr %7338, align 4
  %7339 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7340 = getelementptr float, ptr %7339, i64 14979072
  store <4096 x float> zeroinitializer, ptr %7340, align 4
  %7341 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7342 = getelementptr float, ptr %7341, i64 14983168
  store <4096 x float> zeroinitializer, ptr %7342, align 4
  %7343 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7344 = getelementptr float, ptr %7343, i64 14987264
  store <4096 x float> zeroinitializer, ptr %7344, align 4
  %7345 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7346 = getelementptr float, ptr %7345, i64 14991360
  store <4096 x float> zeroinitializer, ptr %7346, align 4
  %7347 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7348 = getelementptr float, ptr %7347, i64 14995456
  store <4096 x float> zeroinitializer, ptr %7348, align 4
  %7349 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7350 = getelementptr float, ptr %7349, i64 14999552
  store <4096 x float> zeroinitializer, ptr %7350, align 4
  %7351 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7352 = getelementptr float, ptr %7351, i64 15003648
  store <4096 x float> zeroinitializer, ptr %7352, align 4
  %7353 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7354 = getelementptr float, ptr %7353, i64 15007744
  store <4096 x float> zeroinitializer, ptr %7354, align 4
  %7355 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7356 = getelementptr float, ptr %7355, i64 15011840
  store <4096 x float> zeroinitializer, ptr %7356, align 4
  %7357 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7358 = getelementptr float, ptr %7357, i64 15015936
  store <4096 x float> zeroinitializer, ptr %7358, align 4
  %7359 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7360 = getelementptr float, ptr %7359, i64 15020032
  store <4096 x float> zeroinitializer, ptr %7360, align 4
  %7361 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7362 = getelementptr float, ptr %7361, i64 15024128
  store <4096 x float> zeroinitializer, ptr %7362, align 4
  %7363 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7364 = getelementptr float, ptr %7363, i64 15028224
  store <4096 x float> zeroinitializer, ptr %7364, align 4
  %7365 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7366 = getelementptr float, ptr %7365, i64 15032320
  store <4096 x float> zeroinitializer, ptr %7366, align 4
  %7367 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7368 = getelementptr float, ptr %7367, i64 15036416
  store <4096 x float> zeroinitializer, ptr %7368, align 4
  %7369 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7370 = getelementptr float, ptr %7369, i64 15040512
  store <4096 x float> zeroinitializer, ptr %7370, align 4
  %7371 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7372 = getelementptr float, ptr %7371, i64 15044608
  store <4096 x float> zeroinitializer, ptr %7372, align 4
  %7373 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7374 = getelementptr float, ptr %7373, i64 15048704
  store <4096 x float> zeroinitializer, ptr %7374, align 4
  %7375 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7376 = getelementptr float, ptr %7375, i64 15052800
  store <4096 x float> zeroinitializer, ptr %7376, align 4
  %7377 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7378 = getelementptr float, ptr %7377, i64 15056896
  store <4096 x float> zeroinitializer, ptr %7378, align 4
  %7379 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7380 = getelementptr float, ptr %7379, i64 15060992
  store <4096 x float> zeroinitializer, ptr %7380, align 4
  %7381 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7382 = getelementptr float, ptr %7381, i64 15065088
  store <4096 x float> zeroinitializer, ptr %7382, align 4
  %7383 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7384 = getelementptr float, ptr %7383, i64 15069184
  store <4096 x float> zeroinitializer, ptr %7384, align 4
  %7385 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7386 = getelementptr float, ptr %7385, i64 15073280
  store <4096 x float> zeroinitializer, ptr %7386, align 4
  %7387 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7388 = getelementptr float, ptr %7387, i64 15077376
  store <4096 x float> zeroinitializer, ptr %7388, align 4
  %7389 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7390 = getelementptr float, ptr %7389, i64 15081472
  store <4096 x float> zeroinitializer, ptr %7390, align 4
  %7391 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7392 = getelementptr float, ptr %7391, i64 15085568
  store <4096 x float> zeroinitializer, ptr %7392, align 4
  %7393 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7394 = getelementptr float, ptr %7393, i64 15089664
  store <4096 x float> zeroinitializer, ptr %7394, align 4
  %7395 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7396 = getelementptr float, ptr %7395, i64 15093760
  store <4096 x float> zeroinitializer, ptr %7396, align 4
  %7397 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7398 = getelementptr float, ptr %7397, i64 15097856
  store <4096 x float> zeroinitializer, ptr %7398, align 4
  %7399 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7400 = getelementptr float, ptr %7399, i64 15101952
  store <4096 x float> zeroinitializer, ptr %7400, align 4
  %7401 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7402 = getelementptr float, ptr %7401, i64 15106048
  store <4096 x float> zeroinitializer, ptr %7402, align 4
  %7403 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7404 = getelementptr float, ptr %7403, i64 15110144
  store <4096 x float> zeroinitializer, ptr %7404, align 4
  %7405 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7406 = getelementptr float, ptr %7405, i64 15114240
  store <4096 x float> zeroinitializer, ptr %7406, align 4
  %7407 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7408 = getelementptr float, ptr %7407, i64 15118336
  store <4096 x float> zeroinitializer, ptr %7408, align 4
  %7409 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7410 = getelementptr float, ptr %7409, i64 15122432
  store <4096 x float> zeroinitializer, ptr %7410, align 4
  %7411 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7412 = getelementptr float, ptr %7411, i64 15126528
  store <4096 x float> zeroinitializer, ptr %7412, align 4
  %7413 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7414 = getelementptr float, ptr %7413, i64 15130624
  store <4096 x float> zeroinitializer, ptr %7414, align 4
  %7415 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7416 = getelementptr float, ptr %7415, i64 15134720
  store <4096 x float> zeroinitializer, ptr %7416, align 4
  %7417 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7418 = getelementptr float, ptr %7417, i64 15138816
  store <4096 x float> zeroinitializer, ptr %7418, align 4
  %7419 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7420 = getelementptr float, ptr %7419, i64 15142912
  store <4096 x float> zeroinitializer, ptr %7420, align 4
  %7421 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7422 = getelementptr float, ptr %7421, i64 15147008
  store <4096 x float> zeroinitializer, ptr %7422, align 4
  %7423 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7424 = getelementptr float, ptr %7423, i64 15151104
  store <4096 x float> zeroinitializer, ptr %7424, align 4
  %7425 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7426 = getelementptr float, ptr %7425, i64 15155200
  store <4096 x float> zeroinitializer, ptr %7426, align 4
  %7427 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7428 = getelementptr float, ptr %7427, i64 15159296
  store <4096 x float> zeroinitializer, ptr %7428, align 4
  %7429 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7430 = getelementptr float, ptr %7429, i64 15163392
  store <4096 x float> zeroinitializer, ptr %7430, align 4
  %7431 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7432 = getelementptr float, ptr %7431, i64 15167488
  store <4096 x float> zeroinitializer, ptr %7432, align 4
  %7433 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7434 = getelementptr float, ptr %7433, i64 15171584
  store <4096 x float> zeroinitializer, ptr %7434, align 4
  %7435 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7436 = getelementptr float, ptr %7435, i64 15175680
  store <4096 x float> zeroinitializer, ptr %7436, align 4
  %7437 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7438 = getelementptr float, ptr %7437, i64 15179776
  store <4096 x float> zeroinitializer, ptr %7438, align 4
  %7439 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7440 = getelementptr float, ptr %7439, i64 15183872
  store <4096 x float> zeroinitializer, ptr %7440, align 4
  %7441 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7442 = getelementptr float, ptr %7441, i64 15187968
  store <4096 x float> zeroinitializer, ptr %7442, align 4
  %7443 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7444 = getelementptr float, ptr %7443, i64 15192064
  store <4096 x float> zeroinitializer, ptr %7444, align 4
  %7445 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7446 = getelementptr float, ptr %7445, i64 15196160
  store <4096 x float> zeroinitializer, ptr %7446, align 4
  %7447 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7448 = getelementptr float, ptr %7447, i64 15200256
  store <4096 x float> zeroinitializer, ptr %7448, align 4
  %7449 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7450 = getelementptr float, ptr %7449, i64 15204352
  store <4096 x float> zeroinitializer, ptr %7450, align 4
  %7451 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7452 = getelementptr float, ptr %7451, i64 15208448
  store <4096 x float> zeroinitializer, ptr %7452, align 4
  %7453 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7454 = getelementptr float, ptr %7453, i64 15212544
  store <4096 x float> zeroinitializer, ptr %7454, align 4
  %7455 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7456 = getelementptr float, ptr %7455, i64 15216640
  store <4096 x float> zeroinitializer, ptr %7456, align 4
  %7457 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7458 = getelementptr float, ptr %7457, i64 15220736
  store <4096 x float> zeroinitializer, ptr %7458, align 4
  %7459 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7460 = getelementptr float, ptr %7459, i64 15224832
  store <4096 x float> zeroinitializer, ptr %7460, align 4
  %7461 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7462 = getelementptr float, ptr %7461, i64 15228928
  store <4096 x float> zeroinitializer, ptr %7462, align 4
  %7463 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7464 = getelementptr float, ptr %7463, i64 15233024
  store <4096 x float> zeroinitializer, ptr %7464, align 4
  %7465 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7466 = getelementptr float, ptr %7465, i64 15237120
  store <4096 x float> zeroinitializer, ptr %7466, align 4
  %7467 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7468 = getelementptr float, ptr %7467, i64 15241216
  store <4096 x float> zeroinitializer, ptr %7468, align 4
  %7469 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7470 = getelementptr float, ptr %7469, i64 15245312
  store <4096 x float> zeroinitializer, ptr %7470, align 4
  %7471 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7472 = getelementptr float, ptr %7471, i64 15249408
  store <4096 x float> zeroinitializer, ptr %7472, align 4
  %7473 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7474 = getelementptr float, ptr %7473, i64 15253504
  store <4096 x float> zeroinitializer, ptr %7474, align 4
  %7475 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7476 = getelementptr float, ptr %7475, i64 15257600
  store <4096 x float> zeroinitializer, ptr %7476, align 4
  %7477 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7478 = getelementptr float, ptr %7477, i64 15261696
  store <4096 x float> zeroinitializer, ptr %7478, align 4
  %7479 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7480 = getelementptr float, ptr %7479, i64 15265792
  store <4096 x float> zeroinitializer, ptr %7480, align 4
  %7481 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7482 = getelementptr float, ptr %7481, i64 15269888
  store <4096 x float> zeroinitializer, ptr %7482, align 4
  %7483 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7484 = getelementptr float, ptr %7483, i64 15273984
  store <4096 x float> zeroinitializer, ptr %7484, align 4
  %7485 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7486 = getelementptr float, ptr %7485, i64 15278080
  store <4096 x float> zeroinitializer, ptr %7486, align 4
  %7487 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7488 = getelementptr float, ptr %7487, i64 15282176
  store <4096 x float> zeroinitializer, ptr %7488, align 4
  %7489 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7490 = getelementptr float, ptr %7489, i64 15286272
  store <4096 x float> zeroinitializer, ptr %7490, align 4
  %7491 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7492 = getelementptr float, ptr %7491, i64 15290368
  store <4096 x float> zeroinitializer, ptr %7492, align 4
  %7493 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7494 = getelementptr float, ptr %7493, i64 15294464
  store <4096 x float> zeroinitializer, ptr %7494, align 4
  %7495 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7496 = getelementptr float, ptr %7495, i64 15298560
  store <4096 x float> zeroinitializer, ptr %7496, align 4
  %7497 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7498 = getelementptr float, ptr %7497, i64 15302656
  store <4096 x float> zeroinitializer, ptr %7498, align 4
  %7499 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7500 = getelementptr float, ptr %7499, i64 15306752
  store <4096 x float> zeroinitializer, ptr %7500, align 4
  %7501 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7502 = getelementptr float, ptr %7501, i64 15310848
  store <4096 x float> zeroinitializer, ptr %7502, align 4
  %7503 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7504 = getelementptr float, ptr %7503, i64 15314944
  store <4096 x float> zeroinitializer, ptr %7504, align 4
  %7505 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7506 = getelementptr float, ptr %7505, i64 15319040
  store <4096 x float> zeroinitializer, ptr %7506, align 4
  %7507 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7508 = getelementptr float, ptr %7507, i64 15323136
  store <4096 x float> zeroinitializer, ptr %7508, align 4
  %7509 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7510 = getelementptr float, ptr %7509, i64 15327232
  store <4096 x float> zeroinitializer, ptr %7510, align 4
  %7511 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7512 = getelementptr float, ptr %7511, i64 15331328
  store <4096 x float> zeroinitializer, ptr %7512, align 4
  %7513 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7514 = getelementptr float, ptr %7513, i64 15335424
  store <4096 x float> zeroinitializer, ptr %7514, align 4
  %7515 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7516 = getelementptr float, ptr %7515, i64 15339520
  store <4096 x float> zeroinitializer, ptr %7516, align 4
  %7517 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7518 = getelementptr float, ptr %7517, i64 15343616
  store <4096 x float> zeroinitializer, ptr %7518, align 4
  %7519 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7520 = getelementptr float, ptr %7519, i64 15347712
  store <4096 x float> zeroinitializer, ptr %7520, align 4
  %7521 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7522 = getelementptr float, ptr %7521, i64 15351808
  store <4096 x float> zeroinitializer, ptr %7522, align 4
  %7523 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7524 = getelementptr float, ptr %7523, i64 15355904
  store <4096 x float> zeroinitializer, ptr %7524, align 4
  %7525 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7526 = getelementptr float, ptr %7525, i64 15360000
  store <4096 x float> zeroinitializer, ptr %7526, align 4
  %7527 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7528 = getelementptr float, ptr %7527, i64 15364096
  store <4096 x float> zeroinitializer, ptr %7528, align 4
  %7529 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7530 = getelementptr float, ptr %7529, i64 15368192
  store <4096 x float> zeroinitializer, ptr %7530, align 4
  %7531 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7532 = getelementptr float, ptr %7531, i64 15372288
  store <4096 x float> zeroinitializer, ptr %7532, align 4
  %7533 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7534 = getelementptr float, ptr %7533, i64 15376384
  store <4096 x float> zeroinitializer, ptr %7534, align 4
  %7535 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7536 = getelementptr float, ptr %7535, i64 15380480
  store <4096 x float> zeroinitializer, ptr %7536, align 4
  %7537 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7538 = getelementptr float, ptr %7537, i64 15384576
  store <4096 x float> zeroinitializer, ptr %7538, align 4
  %7539 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7540 = getelementptr float, ptr %7539, i64 15388672
  store <4096 x float> zeroinitializer, ptr %7540, align 4
  %7541 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7542 = getelementptr float, ptr %7541, i64 15392768
  store <4096 x float> zeroinitializer, ptr %7542, align 4
  %7543 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7544 = getelementptr float, ptr %7543, i64 15396864
  store <4096 x float> zeroinitializer, ptr %7544, align 4
  %7545 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7546 = getelementptr float, ptr %7545, i64 15400960
  store <4096 x float> zeroinitializer, ptr %7546, align 4
  %7547 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7548 = getelementptr float, ptr %7547, i64 15405056
  store <4096 x float> zeroinitializer, ptr %7548, align 4
  %7549 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7550 = getelementptr float, ptr %7549, i64 15409152
  store <4096 x float> zeroinitializer, ptr %7550, align 4
  %7551 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7552 = getelementptr float, ptr %7551, i64 15413248
  store <4096 x float> zeroinitializer, ptr %7552, align 4
  %7553 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7554 = getelementptr float, ptr %7553, i64 15417344
  store <4096 x float> zeroinitializer, ptr %7554, align 4
  %7555 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7556 = getelementptr float, ptr %7555, i64 15421440
  store <4096 x float> zeroinitializer, ptr %7556, align 4
  %7557 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7558 = getelementptr float, ptr %7557, i64 15425536
  store <4096 x float> zeroinitializer, ptr %7558, align 4
  %7559 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7560 = getelementptr float, ptr %7559, i64 15429632
  store <4096 x float> zeroinitializer, ptr %7560, align 4
  %7561 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7562 = getelementptr float, ptr %7561, i64 15433728
  store <4096 x float> zeroinitializer, ptr %7562, align 4
  %7563 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7564 = getelementptr float, ptr %7563, i64 15437824
  store <4096 x float> zeroinitializer, ptr %7564, align 4
  %7565 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7566 = getelementptr float, ptr %7565, i64 15441920
  store <4096 x float> zeroinitializer, ptr %7566, align 4
  %7567 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7568 = getelementptr float, ptr %7567, i64 15446016
  store <4096 x float> zeroinitializer, ptr %7568, align 4
  %7569 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7570 = getelementptr float, ptr %7569, i64 15450112
  store <4096 x float> zeroinitializer, ptr %7570, align 4
  %7571 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7572 = getelementptr float, ptr %7571, i64 15454208
  store <4096 x float> zeroinitializer, ptr %7572, align 4
  %7573 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7574 = getelementptr float, ptr %7573, i64 15458304
  store <4096 x float> zeroinitializer, ptr %7574, align 4
  %7575 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7576 = getelementptr float, ptr %7575, i64 15462400
  store <4096 x float> zeroinitializer, ptr %7576, align 4
  %7577 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7578 = getelementptr float, ptr %7577, i64 15466496
  store <4096 x float> zeroinitializer, ptr %7578, align 4
  %7579 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7580 = getelementptr float, ptr %7579, i64 15470592
  store <4096 x float> zeroinitializer, ptr %7580, align 4
  %7581 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7582 = getelementptr float, ptr %7581, i64 15474688
  store <4096 x float> zeroinitializer, ptr %7582, align 4
  %7583 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7584 = getelementptr float, ptr %7583, i64 15478784
  store <4096 x float> zeroinitializer, ptr %7584, align 4
  %7585 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7586 = getelementptr float, ptr %7585, i64 15482880
  store <4096 x float> zeroinitializer, ptr %7586, align 4
  %7587 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7588 = getelementptr float, ptr %7587, i64 15486976
  store <4096 x float> zeroinitializer, ptr %7588, align 4
  %7589 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7590 = getelementptr float, ptr %7589, i64 15491072
  store <4096 x float> zeroinitializer, ptr %7590, align 4
  %7591 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7592 = getelementptr float, ptr %7591, i64 15495168
  store <4096 x float> zeroinitializer, ptr %7592, align 4
  %7593 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7594 = getelementptr float, ptr %7593, i64 15499264
  store <4096 x float> zeroinitializer, ptr %7594, align 4
  %7595 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7596 = getelementptr float, ptr %7595, i64 15503360
  store <4096 x float> zeroinitializer, ptr %7596, align 4
  %7597 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7598 = getelementptr float, ptr %7597, i64 15507456
  store <4096 x float> zeroinitializer, ptr %7598, align 4
  %7599 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7600 = getelementptr float, ptr %7599, i64 15511552
  store <4096 x float> zeroinitializer, ptr %7600, align 4
  %7601 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7602 = getelementptr float, ptr %7601, i64 15515648
  store <4096 x float> zeroinitializer, ptr %7602, align 4
  %7603 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7604 = getelementptr float, ptr %7603, i64 15519744
  store <4096 x float> zeroinitializer, ptr %7604, align 4
  %7605 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7606 = getelementptr float, ptr %7605, i64 15523840
  store <4096 x float> zeroinitializer, ptr %7606, align 4
  %7607 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7608 = getelementptr float, ptr %7607, i64 15527936
  store <4096 x float> zeroinitializer, ptr %7608, align 4
  %7609 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7610 = getelementptr float, ptr %7609, i64 15532032
  store <4096 x float> zeroinitializer, ptr %7610, align 4
  %7611 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7612 = getelementptr float, ptr %7611, i64 15536128
  store <4096 x float> zeroinitializer, ptr %7612, align 4
  %7613 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7614 = getelementptr float, ptr %7613, i64 15540224
  store <4096 x float> zeroinitializer, ptr %7614, align 4
  %7615 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7616 = getelementptr float, ptr %7615, i64 15544320
  store <4096 x float> zeroinitializer, ptr %7616, align 4
  %7617 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7618 = getelementptr float, ptr %7617, i64 15548416
  store <4096 x float> zeroinitializer, ptr %7618, align 4
  %7619 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7620 = getelementptr float, ptr %7619, i64 15552512
  store <4096 x float> zeroinitializer, ptr %7620, align 4
  %7621 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7622 = getelementptr float, ptr %7621, i64 15556608
  store <4096 x float> zeroinitializer, ptr %7622, align 4
  %7623 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7624 = getelementptr float, ptr %7623, i64 15560704
  store <4096 x float> zeroinitializer, ptr %7624, align 4
  %7625 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7626 = getelementptr float, ptr %7625, i64 15564800
  store <4096 x float> zeroinitializer, ptr %7626, align 4
  %7627 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7628 = getelementptr float, ptr %7627, i64 15568896
  store <4096 x float> zeroinitializer, ptr %7628, align 4
  %7629 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7630 = getelementptr float, ptr %7629, i64 15572992
  store <4096 x float> zeroinitializer, ptr %7630, align 4
  %7631 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7632 = getelementptr float, ptr %7631, i64 15577088
  store <4096 x float> zeroinitializer, ptr %7632, align 4
  %7633 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7634 = getelementptr float, ptr %7633, i64 15581184
  store <4096 x float> zeroinitializer, ptr %7634, align 4
  %7635 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7636 = getelementptr float, ptr %7635, i64 15585280
  store <4096 x float> zeroinitializer, ptr %7636, align 4
  %7637 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7638 = getelementptr float, ptr %7637, i64 15589376
  store <4096 x float> zeroinitializer, ptr %7638, align 4
  %7639 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7640 = getelementptr float, ptr %7639, i64 15593472
  store <4096 x float> zeroinitializer, ptr %7640, align 4
  %7641 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7642 = getelementptr float, ptr %7641, i64 15597568
  store <4096 x float> zeroinitializer, ptr %7642, align 4
  %7643 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7644 = getelementptr float, ptr %7643, i64 15601664
  store <4096 x float> zeroinitializer, ptr %7644, align 4
  %7645 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7646 = getelementptr float, ptr %7645, i64 15605760
  store <4096 x float> zeroinitializer, ptr %7646, align 4
  %7647 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7648 = getelementptr float, ptr %7647, i64 15609856
  store <4096 x float> zeroinitializer, ptr %7648, align 4
  %7649 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7650 = getelementptr float, ptr %7649, i64 15613952
  store <4096 x float> zeroinitializer, ptr %7650, align 4
  %7651 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7652 = getelementptr float, ptr %7651, i64 15618048
  store <4096 x float> zeroinitializer, ptr %7652, align 4
  %7653 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7654 = getelementptr float, ptr %7653, i64 15622144
  store <4096 x float> zeroinitializer, ptr %7654, align 4
  %7655 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7656 = getelementptr float, ptr %7655, i64 15626240
  store <4096 x float> zeroinitializer, ptr %7656, align 4
  %7657 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7658 = getelementptr float, ptr %7657, i64 15630336
  store <4096 x float> zeroinitializer, ptr %7658, align 4
  %7659 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7660 = getelementptr float, ptr %7659, i64 15634432
  store <4096 x float> zeroinitializer, ptr %7660, align 4
  %7661 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7662 = getelementptr float, ptr %7661, i64 15638528
  store <4096 x float> zeroinitializer, ptr %7662, align 4
  %7663 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7664 = getelementptr float, ptr %7663, i64 15642624
  store <4096 x float> zeroinitializer, ptr %7664, align 4
  %7665 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7666 = getelementptr float, ptr %7665, i64 15646720
  store <4096 x float> zeroinitializer, ptr %7666, align 4
  %7667 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7668 = getelementptr float, ptr %7667, i64 15650816
  store <4096 x float> zeroinitializer, ptr %7668, align 4
  %7669 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7670 = getelementptr float, ptr %7669, i64 15654912
  store <4096 x float> zeroinitializer, ptr %7670, align 4
  %7671 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7672 = getelementptr float, ptr %7671, i64 15659008
  store <4096 x float> zeroinitializer, ptr %7672, align 4
  %7673 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7674 = getelementptr float, ptr %7673, i64 15663104
  store <4096 x float> zeroinitializer, ptr %7674, align 4
  %7675 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7676 = getelementptr float, ptr %7675, i64 15667200
  store <4096 x float> zeroinitializer, ptr %7676, align 4
  %7677 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7678 = getelementptr float, ptr %7677, i64 15671296
  store <4096 x float> zeroinitializer, ptr %7678, align 4
  %7679 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7680 = getelementptr float, ptr %7679, i64 15675392
  store <4096 x float> zeroinitializer, ptr %7680, align 4
  %7681 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7682 = getelementptr float, ptr %7681, i64 15679488
  store <4096 x float> zeroinitializer, ptr %7682, align 4
  %7683 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7684 = getelementptr float, ptr %7683, i64 15683584
  store <4096 x float> zeroinitializer, ptr %7684, align 4
  %7685 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7686 = getelementptr float, ptr %7685, i64 15687680
  store <4096 x float> zeroinitializer, ptr %7686, align 4
  %7687 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7688 = getelementptr float, ptr %7687, i64 15691776
  store <4096 x float> zeroinitializer, ptr %7688, align 4
  %7689 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7690 = getelementptr float, ptr %7689, i64 15695872
  store <4096 x float> zeroinitializer, ptr %7690, align 4
  %7691 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7692 = getelementptr float, ptr %7691, i64 15699968
  store <4096 x float> zeroinitializer, ptr %7692, align 4
  %7693 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7694 = getelementptr float, ptr %7693, i64 15704064
  store <4096 x float> zeroinitializer, ptr %7694, align 4
  %7695 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7696 = getelementptr float, ptr %7695, i64 15708160
  store <4096 x float> zeroinitializer, ptr %7696, align 4
  %7697 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7698 = getelementptr float, ptr %7697, i64 15712256
  store <4096 x float> zeroinitializer, ptr %7698, align 4
  %7699 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7700 = getelementptr float, ptr %7699, i64 15716352
  store <4096 x float> zeroinitializer, ptr %7700, align 4
  %7701 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7702 = getelementptr float, ptr %7701, i64 15720448
  store <4096 x float> zeroinitializer, ptr %7702, align 4
  %7703 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7704 = getelementptr float, ptr %7703, i64 15724544
  store <4096 x float> zeroinitializer, ptr %7704, align 4
  %7705 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7706 = getelementptr float, ptr %7705, i64 15728640
  store <4096 x float> zeroinitializer, ptr %7706, align 4
  %7707 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7708 = getelementptr float, ptr %7707, i64 15732736
  store <4096 x float> zeroinitializer, ptr %7708, align 4
  %7709 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7710 = getelementptr float, ptr %7709, i64 15736832
  store <4096 x float> zeroinitializer, ptr %7710, align 4
  %7711 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7712 = getelementptr float, ptr %7711, i64 15740928
  store <4096 x float> zeroinitializer, ptr %7712, align 4
  %7713 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7714 = getelementptr float, ptr %7713, i64 15745024
  store <4096 x float> zeroinitializer, ptr %7714, align 4
  %7715 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7716 = getelementptr float, ptr %7715, i64 15749120
  store <4096 x float> zeroinitializer, ptr %7716, align 4
  %7717 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7718 = getelementptr float, ptr %7717, i64 15753216
  store <4096 x float> zeroinitializer, ptr %7718, align 4
  %7719 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7720 = getelementptr float, ptr %7719, i64 15757312
  store <4096 x float> zeroinitializer, ptr %7720, align 4
  %7721 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7722 = getelementptr float, ptr %7721, i64 15761408
  store <4096 x float> zeroinitializer, ptr %7722, align 4
  %7723 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7724 = getelementptr float, ptr %7723, i64 15765504
  store <4096 x float> zeroinitializer, ptr %7724, align 4
  %7725 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7726 = getelementptr float, ptr %7725, i64 15769600
  store <4096 x float> zeroinitializer, ptr %7726, align 4
  %7727 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7728 = getelementptr float, ptr %7727, i64 15773696
  store <4096 x float> zeroinitializer, ptr %7728, align 4
  %7729 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7730 = getelementptr float, ptr %7729, i64 15777792
  store <4096 x float> zeroinitializer, ptr %7730, align 4
  %7731 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7732 = getelementptr float, ptr %7731, i64 15781888
  store <4096 x float> zeroinitializer, ptr %7732, align 4
  %7733 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7734 = getelementptr float, ptr %7733, i64 15785984
  store <4096 x float> zeroinitializer, ptr %7734, align 4
  %7735 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7736 = getelementptr float, ptr %7735, i64 15790080
  store <4096 x float> zeroinitializer, ptr %7736, align 4
  %7737 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7738 = getelementptr float, ptr %7737, i64 15794176
  store <4096 x float> zeroinitializer, ptr %7738, align 4
  %7739 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7740 = getelementptr float, ptr %7739, i64 15798272
  store <4096 x float> zeroinitializer, ptr %7740, align 4
  %7741 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7742 = getelementptr float, ptr %7741, i64 15802368
  store <4096 x float> zeroinitializer, ptr %7742, align 4
  %7743 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7744 = getelementptr float, ptr %7743, i64 15806464
  store <4096 x float> zeroinitializer, ptr %7744, align 4
  %7745 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7746 = getelementptr float, ptr %7745, i64 15810560
  store <4096 x float> zeroinitializer, ptr %7746, align 4
  %7747 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7748 = getelementptr float, ptr %7747, i64 15814656
  store <4096 x float> zeroinitializer, ptr %7748, align 4
  %7749 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7750 = getelementptr float, ptr %7749, i64 15818752
  store <4096 x float> zeroinitializer, ptr %7750, align 4
  %7751 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7752 = getelementptr float, ptr %7751, i64 15822848
  store <4096 x float> zeroinitializer, ptr %7752, align 4
  %7753 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7754 = getelementptr float, ptr %7753, i64 15826944
  store <4096 x float> zeroinitializer, ptr %7754, align 4
  %7755 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7756 = getelementptr float, ptr %7755, i64 15831040
  store <4096 x float> zeroinitializer, ptr %7756, align 4
  %7757 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7758 = getelementptr float, ptr %7757, i64 15835136
  store <4096 x float> zeroinitializer, ptr %7758, align 4
  %7759 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7760 = getelementptr float, ptr %7759, i64 15839232
  store <4096 x float> zeroinitializer, ptr %7760, align 4
  %7761 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7762 = getelementptr float, ptr %7761, i64 15843328
  store <4096 x float> zeroinitializer, ptr %7762, align 4
  %7763 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7764 = getelementptr float, ptr %7763, i64 15847424
  store <4096 x float> zeroinitializer, ptr %7764, align 4
  %7765 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7766 = getelementptr float, ptr %7765, i64 15851520
  store <4096 x float> zeroinitializer, ptr %7766, align 4
  %7767 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7768 = getelementptr float, ptr %7767, i64 15855616
  store <4096 x float> zeroinitializer, ptr %7768, align 4
  %7769 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7770 = getelementptr float, ptr %7769, i64 15859712
  store <4096 x float> zeroinitializer, ptr %7770, align 4
  %7771 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7772 = getelementptr float, ptr %7771, i64 15863808
  store <4096 x float> zeroinitializer, ptr %7772, align 4
  %7773 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7774 = getelementptr float, ptr %7773, i64 15867904
  store <4096 x float> zeroinitializer, ptr %7774, align 4
  %7775 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7776 = getelementptr float, ptr %7775, i64 15872000
  store <4096 x float> zeroinitializer, ptr %7776, align 4
  %7777 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7778 = getelementptr float, ptr %7777, i64 15876096
  store <4096 x float> zeroinitializer, ptr %7778, align 4
  %7779 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7780 = getelementptr float, ptr %7779, i64 15880192
  store <4096 x float> zeroinitializer, ptr %7780, align 4
  %7781 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7782 = getelementptr float, ptr %7781, i64 15884288
  store <4096 x float> zeroinitializer, ptr %7782, align 4
  %7783 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7784 = getelementptr float, ptr %7783, i64 15888384
  store <4096 x float> zeroinitializer, ptr %7784, align 4
  %7785 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7786 = getelementptr float, ptr %7785, i64 15892480
  store <4096 x float> zeroinitializer, ptr %7786, align 4
  %7787 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7788 = getelementptr float, ptr %7787, i64 15896576
  store <4096 x float> zeroinitializer, ptr %7788, align 4
  %7789 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7790 = getelementptr float, ptr %7789, i64 15900672
  store <4096 x float> zeroinitializer, ptr %7790, align 4
  %7791 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7792 = getelementptr float, ptr %7791, i64 15904768
  store <4096 x float> zeroinitializer, ptr %7792, align 4
  %7793 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7794 = getelementptr float, ptr %7793, i64 15908864
  store <4096 x float> zeroinitializer, ptr %7794, align 4
  %7795 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7796 = getelementptr float, ptr %7795, i64 15912960
  store <4096 x float> zeroinitializer, ptr %7796, align 4
  %7797 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7798 = getelementptr float, ptr %7797, i64 15917056
  store <4096 x float> zeroinitializer, ptr %7798, align 4
  %7799 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7800 = getelementptr float, ptr %7799, i64 15921152
  store <4096 x float> zeroinitializer, ptr %7800, align 4
  %7801 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7802 = getelementptr float, ptr %7801, i64 15925248
  store <4096 x float> zeroinitializer, ptr %7802, align 4
  %7803 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7804 = getelementptr float, ptr %7803, i64 15929344
  store <4096 x float> zeroinitializer, ptr %7804, align 4
  %7805 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7806 = getelementptr float, ptr %7805, i64 15933440
  store <4096 x float> zeroinitializer, ptr %7806, align 4
  %7807 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7808 = getelementptr float, ptr %7807, i64 15937536
  store <4096 x float> zeroinitializer, ptr %7808, align 4
  %7809 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7810 = getelementptr float, ptr %7809, i64 15941632
  store <4096 x float> zeroinitializer, ptr %7810, align 4
  %7811 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7812 = getelementptr float, ptr %7811, i64 15945728
  store <4096 x float> zeroinitializer, ptr %7812, align 4
  %7813 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7814 = getelementptr float, ptr %7813, i64 15949824
  store <4096 x float> zeroinitializer, ptr %7814, align 4
  %7815 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7816 = getelementptr float, ptr %7815, i64 15953920
  store <4096 x float> zeroinitializer, ptr %7816, align 4
  %7817 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7818 = getelementptr float, ptr %7817, i64 15958016
  store <4096 x float> zeroinitializer, ptr %7818, align 4
  %7819 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7820 = getelementptr float, ptr %7819, i64 15962112
  store <4096 x float> zeroinitializer, ptr %7820, align 4
  %7821 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7822 = getelementptr float, ptr %7821, i64 15966208
  store <4096 x float> zeroinitializer, ptr %7822, align 4
  %7823 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7824 = getelementptr float, ptr %7823, i64 15970304
  store <4096 x float> zeroinitializer, ptr %7824, align 4
  %7825 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7826 = getelementptr float, ptr %7825, i64 15974400
  store <4096 x float> zeroinitializer, ptr %7826, align 4
  %7827 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7828 = getelementptr float, ptr %7827, i64 15978496
  store <4096 x float> zeroinitializer, ptr %7828, align 4
  %7829 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7830 = getelementptr float, ptr %7829, i64 15982592
  store <4096 x float> zeroinitializer, ptr %7830, align 4
  %7831 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7832 = getelementptr float, ptr %7831, i64 15986688
  store <4096 x float> zeroinitializer, ptr %7832, align 4
  %7833 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7834 = getelementptr float, ptr %7833, i64 15990784
  store <4096 x float> zeroinitializer, ptr %7834, align 4
  %7835 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7836 = getelementptr float, ptr %7835, i64 15994880
  store <4096 x float> zeroinitializer, ptr %7836, align 4
  %7837 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7838 = getelementptr float, ptr %7837, i64 15998976
  store <4096 x float> zeroinitializer, ptr %7838, align 4
  %7839 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7840 = getelementptr float, ptr %7839, i64 16003072
  store <4096 x float> zeroinitializer, ptr %7840, align 4
  %7841 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7842 = getelementptr float, ptr %7841, i64 16007168
  store <4096 x float> zeroinitializer, ptr %7842, align 4
  %7843 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7844 = getelementptr float, ptr %7843, i64 16011264
  store <4096 x float> zeroinitializer, ptr %7844, align 4
  %7845 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7846 = getelementptr float, ptr %7845, i64 16015360
  store <4096 x float> zeroinitializer, ptr %7846, align 4
  %7847 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7848 = getelementptr float, ptr %7847, i64 16019456
  store <4096 x float> zeroinitializer, ptr %7848, align 4
  %7849 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7850 = getelementptr float, ptr %7849, i64 16023552
  store <4096 x float> zeroinitializer, ptr %7850, align 4
  %7851 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7852 = getelementptr float, ptr %7851, i64 16027648
  store <4096 x float> zeroinitializer, ptr %7852, align 4
  %7853 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7854 = getelementptr float, ptr %7853, i64 16031744
  store <4096 x float> zeroinitializer, ptr %7854, align 4
  %7855 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7856 = getelementptr float, ptr %7855, i64 16035840
  store <4096 x float> zeroinitializer, ptr %7856, align 4
  %7857 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7858 = getelementptr float, ptr %7857, i64 16039936
  store <4096 x float> zeroinitializer, ptr %7858, align 4
  %7859 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7860 = getelementptr float, ptr %7859, i64 16044032
  store <4096 x float> zeroinitializer, ptr %7860, align 4
  %7861 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7862 = getelementptr float, ptr %7861, i64 16048128
  store <4096 x float> zeroinitializer, ptr %7862, align 4
  %7863 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7864 = getelementptr float, ptr %7863, i64 16052224
  store <4096 x float> zeroinitializer, ptr %7864, align 4
  %7865 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7866 = getelementptr float, ptr %7865, i64 16056320
  store <4096 x float> zeroinitializer, ptr %7866, align 4
  %7867 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7868 = getelementptr float, ptr %7867, i64 16060416
  store <4096 x float> zeroinitializer, ptr %7868, align 4
  %7869 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7870 = getelementptr float, ptr %7869, i64 16064512
  store <4096 x float> zeroinitializer, ptr %7870, align 4
  %7871 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7872 = getelementptr float, ptr %7871, i64 16068608
  store <4096 x float> zeroinitializer, ptr %7872, align 4
  %7873 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7874 = getelementptr float, ptr %7873, i64 16072704
  store <4096 x float> zeroinitializer, ptr %7874, align 4
  %7875 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7876 = getelementptr float, ptr %7875, i64 16076800
  store <4096 x float> zeroinitializer, ptr %7876, align 4
  %7877 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7878 = getelementptr float, ptr %7877, i64 16080896
  store <4096 x float> zeroinitializer, ptr %7878, align 4
  %7879 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7880 = getelementptr float, ptr %7879, i64 16084992
  store <4096 x float> zeroinitializer, ptr %7880, align 4
  %7881 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7882 = getelementptr float, ptr %7881, i64 16089088
  store <4096 x float> zeroinitializer, ptr %7882, align 4
  %7883 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7884 = getelementptr float, ptr %7883, i64 16093184
  store <4096 x float> zeroinitializer, ptr %7884, align 4
  %7885 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7886 = getelementptr float, ptr %7885, i64 16097280
  store <4096 x float> zeroinitializer, ptr %7886, align 4
  %7887 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7888 = getelementptr float, ptr %7887, i64 16101376
  store <4096 x float> zeroinitializer, ptr %7888, align 4
  %7889 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7890 = getelementptr float, ptr %7889, i64 16105472
  store <4096 x float> zeroinitializer, ptr %7890, align 4
  %7891 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7892 = getelementptr float, ptr %7891, i64 16109568
  store <4096 x float> zeroinitializer, ptr %7892, align 4
  %7893 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7894 = getelementptr float, ptr %7893, i64 16113664
  store <4096 x float> zeroinitializer, ptr %7894, align 4
  %7895 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7896 = getelementptr float, ptr %7895, i64 16117760
  store <4096 x float> zeroinitializer, ptr %7896, align 4
  %7897 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7898 = getelementptr float, ptr %7897, i64 16121856
  store <4096 x float> zeroinitializer, ptr %7898, align 4
  %7899 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7900 = getelementptr float, ptr %7899, i64 16125952
  store <4096 x float> zeroinitializer, ptr %7900, align 4
  %7901 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7902 = getelementptr float, ptr %7901, i64 16130048
  store <4096 x float> zeroinitializer, ptr %7902, align 4
  %7903 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7904 = getelementptr float, ptr %7903, i64 16134144
  store <4096 x float> zeroinitializer, ptr %7904, align 4
  %7905 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7906 = getelementptr float, ptr %7905, i64 16138240
  store <4096 x float> zeroinitializer, ptr %7906, align 4
  %7907 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7908 = getelementptr float, ptr %7907, i64 16142336
  store <4096 x float> zeroinitializer, ptr %7908, align 4
  %7909 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7910 = getelementptr float, ptr %7909, i64 16146432
  store <4096 x float> zeroinitializer, ptr %7910, align 4
  %7911 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7912 = getelementptr float, ptr %7911, i64 16150528
  store <4096 x float> zeroinitializer, ptr %7912, align 4
  %7913 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7914 = getelementptr float, ptr %7913, i64 16154624
  store <4096 x float> zeroinitializer, ptr %7914, align 4
  %7915 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7916 = getelementptr float, ptr %7915, i64 16158720
  store <4096 x float> zeroinitializer, ptr %7916, align 4
  %7917 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7918 = getelementptr float, ptr %7917, i64 16162816
  store <4096 x float> zeroinitializer, ptr %7918, align 4
  %7919 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7920 = getelementptr float, ptr %7919, i64 16166912
  store <4096 x float> zeroinitializer, ptr %7920, align 4
  %7921 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7922 = getelementptr float, ptr %7921, i64 16171008
  store <4096 x float> zeroinitializer, ptr %7922, align 4
  %7923 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7924 = getelementptr float, ptr %7923, i64 16175104
  store <4096 x float> zeroinitializer, ptr %7924, align 4
  %7925 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7926 = getelementptr float, ptr %7925, i64 16179200
  store <4096 x float> zeroinitializer, ptr %7926, align 4
  %7927 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7928 = getelementptr float, ptr %7927, i64 16183296
  store <4096 x float> zeroinitializer, ptr %7928, align 4
  %7929 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7930 = getelementptr float, ptr %7929, i64 16187392
  store <4096 x float> zeroinitializer, ptr %7930, align 4
  %7931 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7932 = getelementptr float, ptr %7931, i64 16191488
  store <4096 x float> zeroinitializer, ptr %7932, align 4
  %7933 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7934 = getelementptr float, ptr %7933, i64 16195584
  store <4096 x float> zeroinitializer, ptr %7934, align 4
  %7935 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7936 = getelementptr float, ptr %7935, i64 16199680
  store <4096 x float> zeroinitializer, ptr %7936, align 4
  %7937 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7938 = getelementptr float, ptr %7937, i64 16203776
  store <4096 x float> zeroinitializer, ptr %7938, align 4
  %7939 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7940 = getelementptr float, ptr %7939, i64 16207872
  store <4096 x float> zeroinitializer, ptr %7940, align 4
  %7941 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7942 = getelementptr float, ptr %7941, i64 16211968
  store <4096 x float> zeroinitializer, ptr %7942, align 4
  %7943 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7944 = getelementptr float, ptr %7943, i64 16216064
  store <4096 x float> zeroinitializer, ptr %7944, align 4
  %7945 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7946 = getelementptr float, ptr %7945, i64 16220160
  store <4096 x float> zeroinitializer, ptr %7946, align 4
  %7947 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7948 = getelementptr float, ptr %7947, i64 16224256
  store <4096 x float> zeroinitializer, ptr %7948, align 4
  %7949 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7950 = getelementptr float, ptr %7949, i64 16228352
  store <4096 x float> zeroinitializer, ptr %7950, align 4
  %7951 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7952 = getelementptr float, ptr %7951, i64 16232448
  store <4096 x float> zeroinitializer, ptr %7952, align 4
  %7953 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7954 = getelementptr float, ptr %7953, i64 16236544
  store <4096 x float> zeroinitializer, ptr %7954, align 4
  %7955 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7956 = getelementptr float, ptr %7955, i64 16240640
  store <4096 x float> zeroinitializer, ptr %7956, align 4
  %7957 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7958 = getelementptr float, ptr %7957, i64 16244736
  store <4096 x float> zeroinitializer, ptr %7958, align 4
  %7959 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7960 = getelementptr float, ptr %7959, i64 16248832
  store <4096 x float> zeroinitializer, ptr %7960, align 4
  %7961 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7962 = getelementptr float, ptr %7961, i64 16252928
  store <4096 x float> zeroinitializer, ptr %7962, align 4
  %7963 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7964 = getelementptr float, ptr %7963, i64 16257024
  store <4096 x float> zeroinitializer, ptr %7964, align 4
  %7965 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7966 = getelementptr float, ptr %7965, i64 16261120
  store <4096 x float> zeroinitializer, ptr %7966, align 4
  %7967 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7968 = getelementptr float, ptr %7967, i64 16265216
  store <4096 x float> zeroinitializer, ptr %7968, align 4
  %7969 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7970 = getelementptr float, ptr %7969, i64 16269312
  store <4096 x float> zeroinitializer, ptr %7970, align 4
  %7971 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7972 = getelementptr float, ptr %7971, i64 16273408
  store <4096 x float> zeroinitializer, ptr %7972, align 4
  %7973 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7974 = getelementptr float, ptr %7973, i64 16277504
  store <4096 x float> zeroinitializer, ptr %7974, align 4
  %7975 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7976 = getelementptr float, ptr %7975, i64 16281600
  store <4096 x float> zeroinitializer, ptr %7976, align 4
  %7977 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7978 = getelementptr float, ptr %7977, i64 16285696
  store <4096 x float> zeroinitializer, ptr %7978, align 4
  %7979 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7980 = getelementptr float, ptr %7979, i64 16289792
  store <4096 x float> zeroinitializer, ptr %7980, align 4
  %7981 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7982 = getelementptr float, ptr %7981, i64 16293888
  store <4096 x float> zeroinitializer, ptr %7982, align 4
  %7983 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7984 = getelementptr float, ptr %7983, i64 16297984
  store <4096 x float> zeroinitializer, ptr %7984, align 4
  %7985 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7986 = getelementptr float, ptr %7985, i64 16302080
  store <4096 x float> zeroinitializer, ptr %7986, align 4
  %7987 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7988 = getelementptr float, ptr %7987, i64 16306176
  store <4096 x float> zeroinitializer, ptr %7988, align 4
  %7989 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7990 = getelementptr float, ptr %7989, i64 16310272
  store <4096 x float> zeroinitializer, ptr %7990, align 4
  %7991 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7992 = getelementptr float, ptr %7991, i64 16314368
  store <4096 x float> zeroinitializer, ptr %7992, align 4
  %7993 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7994 = getelementptr float, ptr %7993, i64 16318464
  store <4096 x float> zeroinitializer, ptr %7994, align 4
  %7995 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7996 = getelementptr float, ptr %7995, i64 16322560
  store <4096 x float> zeroinitializer, ptr %7996, align 4
  %7997 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %7998 = getelementptr float, ptr %7997, i64 16326656
  store <4096 x float> zeroinitializer, ptr %7998, align 4
  %7999 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8000 = getelementptr float, ptr %7999, i64 16330752
  store <4096 x float> zeroinitializer, ptr %8000, align 4
  %8001 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8002 = getelementptr float, ptr %8001, i64 16334848
  store <4096 x float> zeroinitializer, ptr %8002, align 4
  %8003 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8004 = getelementptr float, ptr %8003, i64 16338944
  store <4096 x float> zeroinitializer, ptr %8004, align 4
  %8005 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8006 = getelementptr float, ptr %8005, i64 16343040
  store <4096 x float> zeroinitializer, ptr %8006, align 4
  %8007 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8008 = getelementptr float, ptr %8007, i64 16347136
  store <4096 x float> zeroinitializer, ptr %8008, align 4
  %8009 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8010 = getelementptr float, ptr %8009, i64 16351232
  store <4096 x float> zeroinitializer, ptr %8010, align 4
  %8011 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8012 = getelementptr float, ptr %8011, i64 16355328
  store <4096 x float> zeroinitializer, ptr %8012, align 4
  %8013 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8014 = getelementptr float, ptr %8013, i64 16359424
  store <4096 x float> zeroinitializer, ptr %8014, align 4
  %8015 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8016 = getelementptr float, ptr %8015, i64 16363520
  store <4096 x float> zeroinitializer, ptr %8016, align 4
  %8017 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8018 = getelementptr float, ptr %8017, i64 16367616
  store <4096 x float> zeroinitializer, ptr %8018, align 4
  %8019 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8020 = getelementptr float, ptr %8019, i64 16371712
  store <4096 x float> zeroinitializer, ptr %8020, align 4
  %8021 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8022 = getelementptr float, ptr %8021, i64 16375808
  store <4096 x float> zeroinitializer, ptr %8022, align 4
  %8023 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8024 = getelementptr float, ptr %8023, i64 16379904
  store <4096 x float> zeroinitializer, ptr %8024, align 4
  %8025 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8026 = getelementptr float, ptr %8025, i64 16384000
  store <4096 x float> zeroinitializer, ptr %8026, align 4
  %8027 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8028 = getelementptr float, ptr %8027, i64 16388096
  store <4096 x float> zeroinitializer, ptr %8028, align 4
  %8029 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8030 = getelementptr float, ptr %8029, i64 16392192
  store <4096 x float> zeroinitializer, ptr %8030, align 4
  %8031 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8032 = getelementptr float, ptr %8031, i64 16396288
  store <4096 x float> zeroinitializer, ptr %8032, align 4
  %8033 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8034 = getelementptr float, ptr %8033, i64 16400384
  store <4096 x float> zeroinitializer, ptr %8034, align 4
  %8035 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8036 = getelementptr float, ptr %8035, i64 16404480
  store <4096 x float> zeroinitializer, ptr %8036, align 4
  %8037 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8038 = getelementptr float, ptr %8037, i64 16408576
  store <4096 x float> zeroinitializer, ptr %8038, align 4
  %8039 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8040 = getelementptr float, ptr %8039, i64 16412672
  store <4096 x float> zeroinitializer, ptr %8040, align 4
  %8041 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8042 = getelementptr float, ptr %8041, i64 16416768
  store <4096 x float> zeroinitializer, ptr %8042, align 4
  %8043 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8044 = getelementptr float, ptr %8043, i64 16420864
  store <4096 x float> zeroinitializer, ptr %8044, align 4
  %8045 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8046 = getelementptr float, ptr %8045, i64 16424960
  store <4096 x float> zeroinitializer, ptr %8046, align 4
  %8047 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8048 = getelementptr float, ptr %8047, i64 16429056
  store <4096 x float> zeroinitializer, ptr %8048, align 4
  %8049 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8050 = getelementptr float, ptr %8049, i64 16433152
  store <4096 x float> zeroinitializer, ptr %8050, align 4
  %8051 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8052 = getelementptr float, ptr %8051, i64 16437248
  store <4096 x float> zeroinitializer, ptr %8052, align 4
  %8053 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8054 = getelementptr float, ptr %8053, i64 16441344
  store <4096 x float> zeroinitializer, ptr %8054, align 4
  %8055 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8056 = getelementptr float, ptr %8055, i64 16445440
  store <4096 x float> zeroinitializer, ptr %8056, align 4
  %8057 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8058 = getelementptr float, ptr %8057, i64 16449536
  store <4096 x float> zeroinitializer, ptr %8058, align 4
  %8059 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8060 = getelementptr float, ptr %8059, i64 16453632
  store <4096 x float> zeroinitializer, ptr %8060, align 4
  %8061 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8062 = getelementptr float, ptr %8061, i64 16457728
  store <4096 x float> zeroinitializer, ptr %8062, align 4
  %8063 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8064 = getelementptr float, ptr %8063, i64 16461824
  store <4096 x float> zeroinitializer, ptr %8064, align 4
  %8065 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8066 = getelementptr float, ptr %8065, i64 16465920
  store <4096 x float> zeroinitializer, ptr %8066, align 4
  %8067 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8068 = getelementptr float, ptr %8067, i64 16470016
  store <4096 x float> zeroinitializer, ptr %8068, align 4
  %8069 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8070 = getelementptr float, ptr %8069, i64 16474112
  store <4096 x float> zeroinitializer, ptr %8070, align 4
  %8071 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8072 = getelementptr float, ptr %8071, i64 16478208
  store <4096 x float> zeroinitializer, ptr %8072, align 4
  %8073 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8074 = getelementptr float, ptr %8073, i64 16482304
  store <4096 x float> zeroinitializer, ptr %8074, align 4
  %8075 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8076 = getelementptr float, ptr %8075, i64 16486400
  store <4096 x float> zeroinitializer, ptr %8076, align 4
  %8077 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8078 = getelementptr float, ptr %8077, i64 16490496
  store <4096 x float> zeroinitializer, ptr %8078, align 4
  %8079 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8080 = getelementptr float, ptr %8079, i64 16494592
  store <4096 x float> zeroinitializer, ptr %8080, align 4
  %8081 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8082 = getelementptr float, ptr %8081, i64 16498688
  store <4096 x float> zeroinitializer, ptr %8082, align 4
  %8083 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8084 = getelementptr float, ptr %8083, i64 16502784
  store <4096 x float> zeroinitializer, ptr %8084, align 4
  %8085 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8086 = getelementptr float, ptr %8085, i64 16506880
  store <4096 x float> zeroinitializer, ptr %8086, align 4
  %8087 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8088 = getelementptr float, ptr %8087, i64 16510976
  store <4096 x float> zeroinitializer, ptr %8088, align 4
  %8089 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8090 = getelementptr float, ptr %8089, i64 16515072
  store <4096 x float> zeroinitializer, ptr %8090, align 4
  %8091 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8092 = getelementptr float, ptr %8091, i64 16519168
  store <4096 x float> zeroinitializer, ptr %8092, align 4
  %8093 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8094 = getelementptr float, ptr %8093, i64 16523264
  store <4096 x float> zeroinitializer, ptr %8094, align 4
  %8095 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8096 = getelementptr float, ptr %8095, i64 16527360
  store <4096 x float> zeroinitializer, ptr %8096, align 4
  %8097 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8098 = getelementptr float, ptr %8097, i64 16531456
  store <4096 x float> zeroinitializer, ptr %8098, align 4
  %8099 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8100 = getelementptr float, ptr %8099, i64 16535552
  store <4096 x float> zeroinitializer, ptr %8100, align 4
  %8101 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8102 = getelementptr float, ptr %8101, i64 16539648
  store <4096 x float> zeroinitializer, ptr %8102, align 4
  %8103 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8104 = getelementptr float, ptr %8103, i64 16543744
  store <4096 x float> zeroinitializer, ptr %8104, align 4
  %8105 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8106 = getelementptr float, ptr %8105, i64 16547840
  store <4096 x float> zeroinitializer, ptr %8106, align 4
  %8107 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8108 = getelementptr float, ptr %8107, i64 16551936
  store <4096 x float> zeroinitializer, ptr %8108, align 4
  %8109 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8110 = getelementptr float, ptr %8109, i64 16556032
  store <4096 x float> zeroinitializer, ptr %8110, align 4
  %8111 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8112 = getelementptr float, ptr %8111, i64 16560128
  store <4096 x float> zeroinitializer, ptr %8112, align 4
  %8113 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8114 = getelementptr float, ptr %8113, i64 16564224
  store <4096 x float> zeroinitializer, ptr %8114, align 4
  %8115 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8116 = getelementptr float, ptr %8115, i64 16568320
  store <4096 x float> zeroinitializer, ptr %8116, align 4
  %8117 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8118 = getelementptr float, ptr %8117, i64 16572416
  store <4096 x float> zeroinitializer, ptr %8118, align 4
  %8119 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8120 = getelementptr float, ptr %8119, i64 16576512
  store <4096 x float> zeroinitializer, ptr %8120, align 4
  %8121 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8122 = getelementptr float, ptr %8121, i64 16580608
  store <4096 x float> zeroinitializer, ptr %8122, align 4
  %8123 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8124 = getelementptr float, ptr %8123, i64 16584704
  store <4096 x float> zeroinitializer, ptr %8124, align 4
  %8125 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8126 = getelementptr float, ptr %8125, i64 16588800
  store <4096 x float> zeroinitializer, ptr %8126, align 4
  %8127 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8128 = getelementptr float, ptr %8127, i64 16592896
  store <4096 x float> zeroinitializer, ptr %8128, align 4
  %8129 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8130 = getelementptr float, ptr %8129, i64 16596992
  store <4096 x float> zeroinitializer, ptr %8130, align 4
  %8131 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8132 = getelementptr float, ptr %8131, i64 16601088
  store <4096 x float> zeroinitializer, ptr %8132, align 4
  %8133 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8134 = getelementptr float, ptr %8133, i64 16605184
  store <4096 x float> zeroinitializer, ptr %8134, align 4
  %8135 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8136 = getelementptr float, ptr %8135, i64 16609280
  store <4096 x float> zeroinitializer, ptr %8136, align 4
  %8137 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8138 = getelementptr float, ptr %8137, i64 16613376
  store <4096 x float> zeroinitializer, ptr %8138, align 4
  %8139 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8140 = getelementptr float, ptr %8139, i64 16617472
  store <4096 x float> zeroinitializer, ptr %8140, align 4
  %8141 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8142 = getelementptr float, ptr %8141, i64 16621568
  store <4096 x float> zeroinitializer, ptr %8142, align 4
  %8143 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8144 = getelementptr float, ptr %8143, i64 16625664
  store <4096 x float> zeroinitializer, ptr %8144, align 4
  %8145 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8146 = getelementptr float, ptr %8145, i64 16629760
  store <4096 x float> zeroinitializer, ptr %8146, align 4
  %8147 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8148 = getelementptr float, ptr %8147, i64 16633856
  store <4096 x float> zeroinitializer, ptr %8148, align 4
  %8149 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8150 = getelementptr float, ptr %8149, i64 16637952
  store <4096 x float> zeroinitializer, ptr %8150, align 4
  %8151 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8152 = getelementptr float, ptr %8151, i64 16642048
  store <4096 x float> zeroinitializer, ptr %8152, align 4
  %8153 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8154 = getelementptr float, ptr %8153, i64 16646144
  store <4096 x float> zeroinitializer, ptr %8154, align 4
  %8155 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8156 = getelementptr float, ptr %8155, i64 16650240
  store <4096 x float> zeroinitializer, ptr %8156, align 4
  %8157 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8158 = getelementptr float, ptr %8157, i64 16654336
  store <4096 x float> zeroinitializer, ptr %8158, align 4
  %8159 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8160 = getelementptr float, ptr %8159, i64 16658432
  store <4096 x float> zeroinitializer, ptr %8160, align 4
  %8161 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8162 = getelementptr float, ptr %8161, i64 16662528
  store <4096 x float> zeroinitializer, ptr %8162, align 4
  %8163 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8164 = getelementptr float, ptr %8163, i64 16666624
  store <4096 x float> zeroinitializer, ptr %8164, align 4
  %8165 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8166 = getelementptr float, ptr %8165, i64 16670720
  store <4096 x float> zeroinitializer, ptr %8166, align 4
  %8167 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8168 = getelementptr float, ptr %8167, i64 16674816
  store <4096 x float> zeroinitializer, ptr %8168, align 4
  %8169 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8170 = getelementptr float, ptr %8169, i64 16678912
  store <4096 x float> zeroinitializer, ptr %8170, align 4
  %8171 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8172 = getelementptr float, ptr %8171, i64 16683008
  store <4096 x float> zeroinitializer, ptr %8172, align 4
  %8173 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8174 = getelementptr float, ptr %8173, i64 16687104
  store <4096 x float> zeroinitializer, ptr %8174, align 4
  %8175 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8176 = getelementptr float, ptr %8175, i64 16691200
  store <4096 x float> zeroinitializer, ptr %8176, align 4
  %8177 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8178 = getelementptr float, ptr %8177, i64 16695296
  store <4096 x float> zeroinitializer, ptr %8178, align 4
  %8179 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8180 = getelementptr float, ptr %8179, i64 16699392
  store <4096 x float> zeroinitializer, ptr %8180, align 4
  %8181 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8182 = getelementptr float, ptr %8181, i64 16703488
  store <4096 x float> zeroinitializer, ptr %8182, align 4
  %8183 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8184 = getelementptr float, ptr %8183, i64 16707584
  store <4096 x float> zeroinitializer, ptr %8184, align 4
  %8185 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8186 = getelementptr float, ptr %8185, i64 16711680
  store <4096 x float> zeroinitializer, ptr %8186, align 4
  %8187 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8188 = getelementptr float, ptr %8187, i64 16715776
  store <4096 x float> zeroinitializer, ptr %8188, align 4
  %8189 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8190 = getelementptr float, ptr %8189, i64 16719872
  store <4096 x float> zeroinitializer, ptr %8190, align 4
  %8191 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8192 = getelementptr float, ptr %8191, i64 16723968
  store <4096 x float> zeroinitializer, ptr %8192, align 4
  %8193 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8194 = getelementptr float, ptr %8193, i64 16728064
  store <4096 x float> zeroinitializer, ptr %8194, align 4
  %8195 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8196 = getelementptr float, ptr %8195, i64 16732160
  store <4096 x float> zeroinitializer, ptr %8196, align 4
  %8197 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8198 = getelementptr float, ptr %8197, i64 16736256
  store <4096 x float> zeroinitializer, ptr %8198, align 4
  %8199 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8200 = getelementptr float, ptr %8199, i64 16740352
  store <4096 x float> zeroinitializer, ptr %8200, align 4
  %8201 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8202 = getelementptr float, ptr %8201, i64 16744448
  store <4096 x float> zeroinitializer, ptr %8202, align 4
  %8203 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8204 = getelementptr float, ptr %8203, i64 16748544
  store <4096 x float> zeroinitializer, ptr %8204, align 4
  %8205 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8206 = getelementptr float, ptr %8205, i64 16752640
  store <4096 x float> zeroinitializer, ptr %8206, align 4
  %8207 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8208 = getelementptr float, ptr %8207, i64 16756736
  store <4096 x float> zeroinitializer, ptr %8208, align 4
  %8209 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8210 = getelementptr float, ptr %8209, i64 16760832
  store <4096 x float> zeroinitializer, ptr %8210, align 4
  %8211 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8212 = getelementptr float, ptr %8211, i64 16764928
  store <4096 x float> zeroinitializer, ptr %8212, align 4
  %8213 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8214 = getelementptr float, ptr %8213, i64 16769024
  store <4096 x float> zeroinitializer, ptr %8214, align 4
  %8215 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8216 = getelementptr float, ptr %8215, i64 16773120
  store <4096 x float> zeroinitializer, ptr %8216, align 4
  br label %8217

8217:                                             ; preds = %8960, %3
  %8218 = phi i64 [ %8961, %8960 ], [ 0, %3 ]
  %8219 = icmp slt i64 %8218, 512
  br i1 %8219, label %8220, label %8962

8220:                                             ; preds = %8217
  br label %8221

8221:                                             ; preds = %8958, %8220
  %8222 = phi i64 [ %8959, %8958 ], [ 0, %8220 ]
  %8223 = icmp slt i64 %8222, 512
  br i1 %8223, label %8224, label %8960

8224:                                             ; preds = %8221
  br label %8225

8225:                                             ; preds = %8956, %8224
  %8226 = phi i64 [ %8957, %8956 ], [ 0, %8224 ]
  %8227 = icmp slt i64 %8226, 512
  br i1 %8227, label %8228, label %8958

8228:                                             ; preds = %8225
  %8229 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 0
  %8230 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8231 = insertvalue { ptr, ptr, i64 } poison, ptr %8229, 0
  %8232 = insertvalue { ptr, ptr, i64 } %8231, ptr %8230, 1
  %8233 = insertvalue { ptr, ptr, i64 } %8232, i64 0, 2
  %8234 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 2
  %8235 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 3, 0
  %8236 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 3, 1
  %8237 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 4, 0
  %8238 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 4, 1
  %8239 = mul nsw i64 %8218, 32768
  %8240 = mul nsw i64 %8222, 8
  %8241 = add i64 %8239, %8240
  %8242 = extractvalue { ptr, ptr, i64 } %8233, 0
  %8243 = extractvalue { ptr, ptr, i64 } %8233, 1
  %8244 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %8242, 0
  %8245 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8244, ptr %8243, 1
  %8246 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8245, i64 %8241, 2
  %8247 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8246, i64 8, 3, 0
  %8248 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8247, i64 4096, 4, 0
  %8249 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8248, i64 8, 3, 1
  %8250 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8249, i64 1, 4, 1
  %8251 = mul nsw i64 %8218, 8
  %8252 = mul nsw i64 %8226, 8
  %8253 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, 1
  %8254 = mul i64 %8251, 4096
  %8255 = add i64 %8254, %8252
  %8256 = getelementptr float, ptr %8253, i64 %8255
  %8257 = load <8 x float>, ptr %8256, align 4
  %8258 = add i64 %8251, 1
  %8259 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, 1
  %8260 = mul i64 %8258, 4096
  %8261 = add i64 %8260, %8252
  %8262 = getelementptr float, ptr %8259, i64 %8261
  %8263 = load <8 x float>, ptr %8262, align 4
  %8264 = add i64 %8251, 2
  %8265 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, 1
  %8266 = mul i64 %8264, 4096
  %8267 = add i64 %8266, %8252
  %8268 = getelementptr float, ptr %8265, i64 %8267
  %8269 = load <8 x float>, ptr %8268, align 4
  %8270 = add i64 %8251, 3
  %8271 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, 1
  %8272 = mul i64 %8270, 4096
  %8273 = add i64 %8272, %8252
  %8274 = getelementptr float, ptr %8271, i64 %8273
  %8275 = load <8 x float>, ptr %8274, align 4
  %8276 = add i64 %8251, 4
  %8277 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, 1
  %8278 = mul i64 %8276, 4096
  %8279 = add i64 %8278, %8252
  %8280 = getelementptr float, ptr %8277, i64 %8279
  %8281 = load <8 x float>, ptr %8280, align 4
  %8282 = add i64 %8251, 5
  %8283 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, 1
  %8284 = mul i64 %8282, 4096
  %8285 = add i64 %8284, %8252
  %8286 = getelementptr float, ptr %8283, i64 %8285
  %8287 = load <8 x float>, ptr %8286, align 4
  %8288 = add i64 %8251, 6
  %8289 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, 1
  %8290 = mul i64 %8288, 4096
  %8291 = add i64 %8290, %8252
  %8292 = getelementptr float, ptr %8289, i64 %8291
  %8293 = load <8 x float>, ptr %8292, align 4
  %8294 = add i64 %8251, 7
  %8295 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, 1
  %8296 = mul i64 %8294, 4096
  %8297 = add i64 %8296, %8252
  %8298 = getelementptr float, ptr %8295, i64 %8297
  %8299 = load <8 x float>, ptr %8298, align 4
  %8300 = mul nsw i64 %8226, 8
  %8301 = mul nsw i64 %8222, 8
  %8302 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %17, 1
  %8303 = mul i64 %8300, 4096
  %8304 = add i64 %8303, %8301
  %8305 = getelementptr float, ptr %8302, i64 %8304
  %8306 = load <8 x float>, ptr %8305, align 4
  %8307 = add i64 %8300, 1
  %8308 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %17, 1
  %8309 = mul i64 %8307, 4096
  %8310 = add i64 %8309, %8301
  %8311 = getelementptr float, ptr %8308, i64 %8310
  %8312 = load <8 x float>, ptr %8311, align 4
  %8313 = add i64 %8300, 2
  %8314 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %17, 1
  %8315 = mul i64 %8313, 4096
  %8316 = add i64 %8315, %8301
  %8317 = getelementptr float, ptr %8314, i64 %8316
  %8318 = load <8 x float>, ptr %8317, align 4
  %8319 = add i64 %8300, 3
  %8320 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %17, 1
  %8321 = mul i64 %8319, 4096
  %8322 = add i64 %8321, %8301
  %8323 = getelementptr float, ptr %8320, i64 %8322
  %8324 = load <8 x float>, ptr %8323, align 4
  %8325 = add i64 %8300, 4
  %8326 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %17, 1
  %8327 = mul i64 %8325, 4096
  %8328 = add i64 %8327, %8301
  %8329 = getelementptr float, ptr %8326, i64 %8328
  %8330 = load <8 x float>, ptr %8329, align 4
  %8331 = add i64 %8300, 5
  %8332 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %17, 1
  %8333 = mul i64 %8331, 4096
  %8334 = add i64 %8333, %8301
  %8335 = getelementptr float, ptr %8332, i64 %8334
  %8336 = load <8 x float>, ptr %8335, align 4
  %8337 = add i64 %8300, 6
  %8338 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %17, 1
  %8339 = mul i64 %8337, 4096
  %8340 = add i64 %8339, %8301
  %8341 = getelementptr float, ptr %8338, i64 %8340
  %8342 = load <8 x float>, ptr %8341, align 4
  %8343 = add i64 %8300, 7
  %8344 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %17, 1
  %8345 = mul i64 %8343, 4096
  %8346 = add i64 %8345, %8301
  %8347 = getelementptr float, ptr %8344, i64 %8346
  %8348 = load <8 x float>, ptr %8347, align 4
  %8349 = mul nsw i64 %8218, 8
  %8350 = mul nsw i64 %8222, 8
  %8351 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8352 = mul i64 %8349, 4096
  %8353 = add i64 %8352, %8350
  %8354 = getelementptr float, ptr %8351, i64 %8353
  %8355 = load <8 x float>, ptr %8354, align 4
  %8356 = insertvalue [8 x <8 x float>] poison, <8 x float> %8355, 0
  %8357 = add i64 %8349, 1
  %8358 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8359 = mul i64 %8357, 4096
  %8360 = add i64 %8359, %8350
  %8361 = getelementptr float, ptr %8358, i64 %8360
  %8362 = load <8 x float>, ptr %8361, align 4
  %8363 = insertvalue [8 x <8 x float>] %8356, <8 x float> %8362, 1
  %8364 = add i64 %8349, 2
  %8365 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8366 = mul i64 %8364, 4096
  %8367 = add i64 %8366, %8350
  %8368 = getelementptr float, ptr %8365, i64 %8367
  %8369 = load <8 x float>, ptr %8368, align 4
  %8370 = insertvalue [8 x <8 x float>] %8363, <8 x float> %8369, 2
  %8371 = add i64 %8349, 3
  %8372 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8373 = mul i64 %8371, 4096
  %8374 = add i64 %8373, %8350
  %8375 = getelementptr float, ptr %8372, i64 %8374
  %8376 = load <8 x float>, ptr %8375, align 4
  %8377 = insertvalue [8 x <8 x float>] %8370, <8 x float> %8376, 3
  %8378 = add i64 %8349, 4
  %8379 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8380 = mul i64 %8378, 4096
  %8381 = add i64 %8380, %8350
  %8382 = getelementptr float, ptr %8379, i64 %8381
  %8383 = load <8 x float>, ptr %8382, align 4
  %8384 = insertvalue [8 x <8 x float>] %8377, <8 x float> %8383, 4
  %8385 = add i64 %8349, 5
  %8386 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8387 = mul i64 %8385, 4096
  %8388 = add i64 %8387, %8350
  %8389 = getelementptr float, ptr %8386, i64 %8388
  %8390 = load <8 x float>, ptr %8389, align 4
  %8391 = insertvalue [8 x <8 x float>] %8384, <8 x float> %8390, 5
  %8392 = add i64 %8349, 6
  %8393 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8394 = mul i64 %8392, 4096
  %8395 = add i64 %8394, %8350
  %8396 = getelementptr float, ptr %8393, i64 %8395
  %8397 = load <8 x float>, ptr %8396, align 4
  %8398 = insertvalue [8 x <8 x float>] %8391, <8 x float> %8397, 6
  %8399 = add i64 %8349, 7
  %8400 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8401 = mul i64 %8399, 4096
  %8402 = add i64 %8401, %8350
  %8403 = getelementptr float, ptr %8400, i64 %8402
  %8404 = load <8 x float>, ptr %8403, align 4
  %8405 = insertvalue [8 x <8 x float>] %8398, <8 x float> %8404, 7
  %8406 = extractelement <8 x float> %8306, i64 0
  %8407 = insertelement <8 x float> poison, float %8406, i64 0
  %8408 = insertvalue [8 x <8 x float>] poison, <8 x float> %8407, 0
  %8409 = extractelement <8 x float> %8306, i64 1
  %8410 = insertelement <8 x float> poison, float %8409, i64 0
  %8411 = insertvalue [8 x <8 x float>] %8408, <8 x float> %8410, 1
  %8412 = extractelement <8 x float> %8306, i64 2
  %8413 = insertelement <8 x float> poison, float %8412, i64 0
  %8414 = insertvalue [8 x <8 x float>] %8411, <8 x float> %8413, 2
  %8415 = extractelement <8 x float> %8306, i64 3
  %8416 = insertelement <8 x float> poison, float %8415, i64 0
  %8417 = insertvalue [8 x <8 x float>] %8414, <8 x float> %8416, 3
  %8418 = extractelement <8 x float> %8306, i64 4
  %8419 = insertelement <8 x float> poison, float %8418, i64 0
  %8420 = insertvalue [8 x <8 x float>] %8417, <8 x float> %8419, 4
  %8421 = extractelement <8 x float> %8306, i64 5
  %8422 = insertelement <8 x float> poison, float %8421, i64 0
  %8423 = insertvalue [8 x <8 x float>] %8420, <8 x float> %8422, 5
  %8424 = extractelement <8 x float> %8306, i64 6
  %8425 = insertelement <8 x float> poison, float %8424, i64 0
  %8426 = insertvalue [8 x <8 x float>] %8423, <8 x float> %8425, 6
  %8427 = extractelement <8 x float> %8306, i64 7
  %8428 = insertelement <8 x float> poison, float %8427, i64 0
  %8429 = insertvalue [8 x <8 x float>] %8426, <8 x float> %8428, 7
  %8430 = extractelement <8 x float> %8312, i64 0
  %8431 = insertelement <8 x float> %8407, float %8430, i64 1
  %8432 = insertvalue [8 x <8 x float>] %8429, <8 x float> %8431, 0
  %8433 = extractelement <8 x float> %8312, i64 1
  %8434 = insertelement <8 x float> %8410, float %8433, i64 1
  %8435 = insertvalue [8 x <8 x float>] %8432, <8 x float> %8434, 1
  %8436 = extractelement <8 x float> %8312, i64 2
  %8437 = insertelement <8 x float> %8413, float %8436, i64 1
  %8438 = insertvalue [8 x <8 x float>] %8435, <8 x float> %8437, 2
  %8439 = extractelement <8 x float> %8312, i64 3
  %8440 = insertelement <8 x float> %8416, float %8439, i64 1
  %8441 = insertvalue [8 x <8 x float>] %8438, <8 x float> %8440, 3
  %8442 = extractelement <8 x float> %8312, i64 4
  %8443 = insertelement <8 x float> %8419, float %8442, i64 1
  %8444 = insertvalue [8 x <8 x float>] %8441, <8 x float> %8443, 4
  %8445 = extractelement <8 x float> %8312, i64 5
  %8446 = insertelement <8 x float> %8422, float %8445, i64 1
  %8447 = insertvalue [8 x <8 x float>] %8444, <8 x float> %8446, 5
  %8448 = extractelement <8 x float> %8312, i64 6
  %8449 = insertelement <8 x float> %8425, float %8448, i64 1
  %8450 = insertvalue [8 x <8 x float>] %8447, <8 x float> %8449, 6
  %8451 = extractelement <8 x float> %8312, i64 7
  %8452 = insertelement <8 x float> %8428, float %8451, i64 1
  %8453 = insertvalue [8 x <8 x float>] %8450, <8 x float> %8452, 7
  %8454 = extractelement <8 x float> %8318, i64 0
  %8455 = insertelement <8 x float> %8431, float %8454, i64 2
  %8456 = insertvalue [8 x <8 x float>] %8453, <8 x float> %8455, 0
  %8457 = extractelement <8 x float> %8318, i64 1
  %8458 = insertelement <8 x float> %8434, float %8457, i64 2
  %8459 = insertvalue [8 x <8 x float>] %8456, <8 x float> %8458, 1
  %8460 = extractelement <8 x float> %8318, i64 2
  %8461 = insertelement <8 x float> %8437, float %8460, i64 2
  %8462 = insertvalue [8 x <8 x float>] %8459, <8 x float> %8461, 2
  %8463 = extractelement <8 x float> %8318, i64 3
  %8464 = insertelement <8 x float> %8440, float %8463, i64 2
  %8465 = insertvalue [8 x <8 x float>] %8462, <8 x float> %8464, 3
  %8466 = extractelement <8 x float> %8318, i64 4
  %8467 = insertelement <8 x float> %8443, float %8466, i64 2
  %8468 = insertvalue [8 x <8 x float>] %8465, <8 x float> %8467, 4
  %8469 = extractelement <8 x float> %8318, i64 5
  %8470 = insertelement <8 x float> %8446, float %8469, i64 2
  %8471 = insertvalue [8 x <8 x float>] %8468, <8 x float> %8470, 5
  %8472 = extractelement <8 x float> %8318, i64 6
  %8473 = insertelement <8 x float> %8449, float %8472, i64 2
  %8474 = insertvalue [8 x <8 x float>] %8471, <8 x float> %8473, 6
  %8475 = extractelement <8 x float> %8318, i64 7
  %8476 = insertelement <8 x float> %8452, float %8475, i64 2
  %8477 = insertvalue [8 x <8 x float>] %8474, <8 x float> %8476, 7
  %8478 = extractelement <8 x float> %8324, i64 0
  %8479 = insertelement <8 x float> %8455, float %8478, i64 3
  %8480 = insertvalue [8 x <8 x float>] %8477, <8 x float> %8479, 0
  %8481 = extractelement <8 x float> %8324, i64 1
  %8482 = insertelement <8 x float> %8458, float %8481, i64 3
  %8483 = insertvalue [8 x <8 x float>] %8480, <8 x float> %8482, 1
  %8484 = extractelement <8 x float> %8324, i64 2
  %8485 = insertelement <8 x float> %8461, float %8484, i64 3
  %8486 = insertvalue [8 x <8 x float>] %8483, <8 x float> %8485, 2
  %8487 = extractelement <8 x float> %8324, i64 3
  %8488 = insertelement <8 x float> %8464, float %8487, i64 3
  %8489 = insertvalue [8 x <8 x float>] %8486, <8 x float> %8488, 3
  %8490 = extractelement <8 x float> %8324, i64 4
  %8491 = insertelement <8 x float> %8467, float %8490, i64 3
  %8492 = insertvalue [8 x <8 x float>] %8489, <8 x float> %8491, 4
  %8493 = extractelement <8 x float> %8324, i64 5
  %8494 = insertelement <8 x float> %8470, float %8493, i64 3
  %8495 = insertvalue [8 x <8 x float>] %8492, <8 x float> %8494, 5
  %8496 = extractelement <8 x float> %8324, i64 6
  %8497 = insertelement <8 x float> %8473, float %8496, i64 3
  %8498 = insertvalue [8 x <8 x float>] %8495, <8 x float> %8497, 6
  %8499 = extractelement <8 x float> %8324, i64 7
  %8500 = insertelement <8 x float> %8476, float %8499, i64 3
  %8501 = insertvalue [8 x <8 x float>] %8498, <8 x float> %8500, 7
  %8502 = extractelement <8 x float> %8330, i64 0
  %8503 = insertelement <8 x float> %8479, float %8502, i64 4
  %8504 = insertvalue [8 x <8 x float>] %8501, <8 x float> %8503, 0
  %8505 = extractelement <8 x float> %8330, i64 1
  %8506 = insertelement <8 x float> %8482, float %8505, i64 4
  %8507 = insertvalue [8 x <8 x float>] %8504, <8 x float> %8506, 1
  %8508 = extractelement <8 x float> %8330, i64 2
  %8509 = insertelement <8 x float> %8485, float %8508, i64 4
  %8510 = insertvalue [8 x <8 x float>] %8507, <8 x float> %8509, 2
  %8511 = extractelement <8 x float> %8330, i64 3
  %8512 = insertelement <8 x float> %8488, float %8511, i64 4
  %8513 = insertvalue [8 x <8 x float>] %8510, <8 x float> %8512, 3
  %8514 = extractelement <8 x float> %8330, i64 4
  %8515 = insertelement <8 x float> %8491, float %8514, i64 4
  %8516 = insertvalue [8 x <8 x float>] %8513, <8 x float> %8515, 4
  %8517 = extractelement <8 x float> %8330, i64 5
  %8518 = insertelement <8 x float> %8494, float %8517, i64 4
  %8519 = insertvalue [8 x <8 x float>] %8516, <8 x float> %8518, 5
  %8520 = extractelement <8 x float> %8330, i64 6
  %8521 = insertelement <8 x float> %8497, float %8520, i64 4
  %8522 = insertvalue [8 x <8 x float>] %8519, <8 x float> %8521, 6
  %8523 = extractelement <8 x float> %8330, i64 7
  %8524 = insertelement <8 x float> %8500, float %8523, i64 4
  %8525 = insertvalue [8 x <8 x float>] %8522, <8 x float> %8524, 7
  %8526 = extractelement <8 x float> %8336, i64 0
  %8527 = insertelement <8 x float> %8503, float %8526, i64 5
  %8528 = insertvalue [8 x <8 x float>] %8525, <8 x float> %8527, 0
  %8529 = extractelement <8 x float> %8336, i64 1
  %8530 = insertelement <8 x float> %8506, float %8529, i64 5
  %8531 = insertvalue [8 x <8 x float>] %8528, <8 x float> %8530, 1
  %8532 = extractelement <8 x float> %8336, i64 2
  %8533 = insertelement <8 x float> %8509, float %8532, i64 5
  %8534 = insertvalue [8 x <8 x float>] %8531, <8 x float> %8533, 2
  %8535 = extractelement <8 x float> %8336, i64 3
  %8536 = insertelement <8 x float> %8512, float %8535, i64 5
  %8537 = insertvalue [8 x <8 x float>] %8534, <8 x float> %8536, 3
  %8538 = extractelement <8 x float> %8336, i64 4
  %8539 = insertelement <8 x float> %8515, float %8538, i64 5
  %8540 = insertvalue [8 x <8 x float>] %8537, <8 x float> %8539, 4
  %8541 = extractelement <8 x float> %8336, i64 5
  %8542 = insertelement <8 x float> %8518, float %8541, i64 5
  %8543 = insertvalue [8 x <8 x float>] %8540, <8 x float> %8542, 5
  %8544 = extractelement <8 x float> %8336, i64 6
  %8545 = insertelement <8 x float> %8521, float %8544, i64 5
  %8546 = insertvalue [8 x <8 x float>] %8543, <8 x float> %8545, 6
  %8547 = extractelement <8 x float> %8336, i64 7
  %8548 = insertelement <8 x float> %8524, float %8547, i64 5
  %8549 = insertvalue [8 x <8 x float>] %8546, <8 x float> %8548, 7
  %8550 = extractelement <8 x float> %8342, i64 0
  %8551 = insertelement <8 x float> %8527, float %8550, i64 6
  %8552 = insertvalue [8 x <8 x float>] %8549, <8 x float> %8551, 0
  %8553 = extractelement <8 x float> %8342, i64 1
  %8554 = insertelement <8 x float> %8530, float %8553, i64 6
  %8555 = insertvalue [8 x <8 x float>] %8552, <8 x float> %8554, 1
  %8556 = extractelement <8 x float> %8342, i64 2
  %8557 = insertelement <8 x float> %8533, float %8556, i64 6
  %8558 = insertvalue [8 x <8 x float>] %8555, <8 x float> %8557, 2
  %8559 = extractelement <8 x float> %8342, i64 3
  %8560 = insertelement <8 x float> %8536, float %8559, i64 6
  %8561 = insertvalue [8 x <8 x float>] %8558, <8 x float> %8560, 3
  %8562 = extractelement <8 x float> %8342, i64 4
  %8563 = insertelement <8 x float> %8539, float %8562, i64 6
  %8564 = insertvalue [8 x <8 x float>] %8561, <8 x float> %8563, 4
  %8565 = extractelement <8 x float> %8342, i64 5
  %8566 = insertelement <8 x float> %8542, float %8565, i64 6
  %8567 = insertvalue [8 x <8 x float>] %8564, <8 x float> %8566, 5
  %8568 = extractelement <8 x float> %8342, i64 6
  %8569 = insertelement <8 x float> %8545, float %8568, i64 6
  %8570 = insertvalue [8 x <8 x float>] %8567, <8 x float> %8569, 6
  %8571 = extractelement <8 x float> %8342, i64 7
  %8572 = insertelement <8 x float> %8548, float %8571, i64 6
  %8573 = insertvalue [8 x <8 x float>] %8570, <8 x float> %8572, 7
  %8574 = extractelement <8 x float> %8348, i64 0
  %8575 = insertelement <8 x float> %8551, float %8574, i64 7
  %8576 = insertvalue [8 x <8 x float>] %8573, <8 x float> %8575, 0
  %8577 = extractelement <8 x float> %8348, i64 1
  %8578 = insertelement <8 x float> %8554, float %8577, i64 7
  %8579 = insertvalue [8 x <8 x float>] %8576, <8 x float> %8578, 1
  %8580 = extractelement <8 x float> %8348, i64 2
  %8581 = insertelement <8 x float> %8557, float %8580, i64 7
  %8582 = insertvalue [8 x <8 x float>] %8579, <8 x float> %8581, 2
  %8583 = extractelement <8 x float> %8348, i64 3
  %8584 = insertelement <8 x float> %8560, float %8583, i64 7
  %8585 = insertvalue [8 x <8 x float>] %8582, <8 x float> %8584, 3
  %8586 = extractelement <8 x float> %8348, i64 4
  %8587 = insertelement <8 x float> %8563, float %8586, i64 7
  %8588 = insertvalue [8 x <8 x float>] %8585, <8 x float> %8587, 4
  %8589 = extractelement <8 x float> %8348, i64 5
  %8590 = insertelement <8 x float> %8566, float %8589, i64 7
  %8591 = insertvalue [8 x <8 x float>] %8588, <8 x float> %8590, 5
  %8592 = extractelement <8 x float> %8348, i64 6
  %8593 = insertelement <8 x float> %8569, float %8592, i64 7
  %8594 = insertvalue [8 x <8 x float>] %8591, <8 x float> %8593, 6
  %8595 = extractelement <8 x float> %8348, i64 7
  %8596 = insertelement <8 x float> %8572, float %8595, i64 7
  %8597 = insertvalue [8 x <8 x float>] %8594, <8 x float> %8596, 7
  %8598 = fmul <8 x float> %8257, %8575
  %8599 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8598)
  %8600 = insertelement <8 x float> zeroinitializer, float %8599, i64 0
  %8601 = insertvalue [8 x <8 x float>] zeroinitializer, <8 x float> %8600, 0
  %8602 = fmul <8 x float> %8257, %8578
  %8603 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8602)
  %8604 = insertelement <8 x float> %8600, float %8603, i64 1
  %8605 = insertvalue [8 x <8 x float>] %8601, <8 x float> %8604, 0
  %8606 = fmul <8 x float> %8257, %8581
  %8607 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8606)
  %8608 = insertelement <8 x float> %8604, float %8607, i64 2
  %8609 = insertvalue [8 x <8 x float>] %8605, <8 x float> %8608, 0
  %8610 = fmul <8 x float> %8257, %8584
  %8611 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8610)
  %8612 = insertelement <8 x float> %8608, float %8611, i64 3
  %8613 = insertvalue [8 x <8 x float>] %8609, <8 x float> %8612, 0
  %8614 = fmul <8 x float> %8257, %8587
  %8615 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8614)
  %8616 = insertelement <8 x float> %8612, float %8615, i64 4
  %8617 = insertvalue [8 x <8 x float>] %8613, <8 x float> %8616, 0
  %8618 = fmul <8 x float> %8257, %8590
  %8619 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8618)
  %8620 = insertelement <8 x float> %8616, float %8619, i64 5
  %8621 = insertvalue [8 x <8 x float>] %8617, <8 x float> %8620, 0
  %8622 = fmul <8 x float> %8257, %8593
  %8623 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8622)
  %8624 = insertelement <8 x float> %8620, float %8623, i64 6
  %8625 = insertvalue [8 x <8 x float>] %8621, <8 x float> %8624, 0
  %8626 = fmul <8 x float> %8257, %8596
  %8627 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8626)
  %8628 = insertelement <8 x float> %8624, float %8627, i64 7
  %8629 = insertvalue [8 x <8 x float>] %8625, <8 x float> %8628, 0
  %8630 = fmul <8 x float> %8263, %8575
  %8631 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8630)
  %8632 = insertelement <8 x float> zeroinitializer, float %8631, i64 0
  %8633 = insertvalue [8 x <8 x float>] %8629, <8 x float> %8632, 1
  %8634 = fmul <8 x float> %8263, %8578
  %8635 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8634)
  %8636 = insertelement <8 x float> %8632, float %8635, i64 1
  %8637 = insertvalue [8 x <8 x float>] %8633, <8 x float> %8636, 1
  %8638 = fmul <8 x float> %8263, %8581
  %8639 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8638)
  %8640 = insertelement <8 x float> %8636, float %8639, i64 2
  %8641 = insertvalue [8 x <8 x float>] %8637, <8 x float> %8640, 1
  %8642 = fmul <8 x float> %8263, %8584
  %8643 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8642)
  %8644 = insertelement <8 x float> %8640, float %8643, i64 3
  %8645 = insertvalue [8 x <8 x float>] %8641, <8 x float> %8644, 1
  %8646 = fmul <8 x float> %8263, %8587
  %8647 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8646)
  %8648 = insertelement <8 x float> %8644, float %8647, i64 4
  %8649 = insertvalue [8 x <8 x float>] %8645, <8 x float> %8648, 1
  %8650 = fmul <8 x float> %8263, %8590
  %8651 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8650)
  %8652 = insertelement <8 x float> %8648, float %8651, i64 5
  %8653 = insertvalue [8 x <8 x float>] %8649, <8 x float> %8652, 1
  %8654 = fmul <8 x float> %8263, %8593
  %8655 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8654)
  %8656 = insertelement <8 x float> %8652, float %8655, i64 6
  %8657 = insertvalue [8 x <8 x float>] %8653, <8 x float> %8656, 1
  %8658 = fmul <8 x float> %8263, %8596
  %8659 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8658)
  %8660 = insertelement <8 x float> %8656, float %8659, i64 7
  %8661 = insertvalue [8 x <8 x float>] %8657, <8 x float> %8660, 1
  %8662 = fmul <8 x float> %8269, %8575
  %8663 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8662)
  %8664 = insertelement <8 x float> zeroinitializer, float %8663, i64 0
  %8665 = insertvalue [8 x <8 x float>] %8661, <8 x float> %8664, 2
  %8666 = fmul <8 x float> %8269, %8578
  %8667 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8666)
  %8668 = insertelement <8 x float> %8664, float %8667, i64 1
  %8669 = insertvalue [8 x <8 x float>] %8665, <8 x float> %8668, 2
  %8670 = fmul <8 x float> %8269, %8581
  %8671 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8670)
  %8672 = insertelement <8 x float> %8668, float %8671, i64 2
  %8673 = insertvalue [8 x <8 x float>] %8669, <8 x float> %8672, 2
  %8674 = fmul <8 x float> %8269, %8584
  %8675 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8674)
  %8676 = insertelement <8 x float> %8672, float %8675, i64 3
  %8677 = insertvalue [8 x <8 x float>] %8673, <8 x float> %8676, 2
  %8678 = fmul <8 x float> %8269, %8587
  %8679 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8678)
  %8680 = insertelement <8 x float> %8676, float %8679, i64 4
  %8681 = insertvalue [8 x <8 x float>] %8677, <8 x float> %8680, 2
  %8682 = fmul <8 x float> %8269, %8590
  %8683 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8682)
  %8684 = insertelement <8 x float> %8680, float %8683, i64 5
  %8685 = insertvalue [8 x <8 x float>] %8681, <8 x float> %8684, 2
  %8686 = fmul <8 x float> %8269, %8593
  %8687 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8686)
  %8688 = insertelement <8 x float> %8684, float %8687, i64 6
  %8689 = insertvalue [8 x <8 x float>] %8685, <8 x float> %8688, 2
  %8690 = fmul <8 x float> %8269, %8596
  %8691 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8690)
  %8692 = insertelement <8 x float> %8688, float %8691, i64 7
  %8693 = insertvalue [8 x <8 x float>] %8689, <8 x float> %8692, 2
  %8694 = fmul <8 x float> %8275, %8575
  %8695 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8694)
  %8696 = insertelement <8 x float> zeroinitializer, float %8695, i64 0
  %8697 = insertvalue [8 x <8 x float>] %8693, <8 x float> %8696, 3
  %8698 = fmul <8 x float> %8275, %8578
  %8699 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8698)
  %8700 = insertelement <8 x float> %8696, float %8699, i64 1
  %8701 = insertvalue [8 x <8 x float>] %8697, <8 x float> %8700, 3
  %8702 = fmul <8 x float> %8275, %8581
  %8703 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8702)
  %8704 = insertelement <8 x float> %8700, float %8703, i64 2
  %8705 = insertvalue [8 x <8 x float>] %8701, <8 x float> %8704, 3
  %8706 = fmul <8 x float> %8275, %8584
  %8707 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8706)
  %8708 = insertelement <8 x float> %8704, float %8707, i64 3
  %8709 = insertvalue [8 x <8 x float>] %8705, <8 x float> %8708, 3
  %8710 = fmul <8 x float> %8275, %8587
  %8711 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8710)
  %8712 = insertelement <8 x float> %8708, float %8711, i64 4
  %8713 = insertvalue [8 x <8 x float>] %8709, <8 x float> %8712, 3
  %8714 = fmul <8 x float> %8275, %8590
  %8715 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8714)
  %8716 = insertelement <8 x float> %8712, float %8715, i64 5
  %8717 = insertvalue [8 x <8 x float>] %8713, <8 x float> %8716, 3
  %8718 = fmul <8 x float> %8275, %8593
  %8719 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8718)
  %8720 = insertelement <8 x float> %8716, float %8719, i64 6
  %8721 = insertvalue [8 x <8 x float>] %8717, <8 x float> %8720, 3
  %8722 = fmul <8 x float> %8275, %8596
  %8723 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8722)
  %8724 = insertelement <8 x float> %8720, float %8723, i64 7
  %8725 = insertvalue [8 x <8 x float>] %8721, <8 x float> %8724, 3
  %8726 = fmul <8 x float> %8281, %8575
  %8727 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8726)
  %8728 = insertelement <8 x float> zeroinitializer, float %8727, i64 0
  %8729 = insertvalue [8 x <8 x float>] %8725, <8 x float> %8728, 4
  %8730 = fmul <8 x float> %8281, %8578
  %8731 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8730)
  %8732 = insertelement <8 x float> %8728, float %8731, i64 1
  %8733 = insertvalue [8 x <8 x float>] %8729, <8 x float> %8732, 4
  %8734 = fmul <8 x float> %8281, %8581
  %8735 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8734)
  %8736 = insertelement <8 x float> %8732, float %8735, i64 2
  %8737 = insertvalue [8 x <8 x float>] %8733, <8 x float> %8736, 4
  %8738 = fmul <8 x float> %8281, %8584
  %8739 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8738)
  %8740 = insertelement <8 x float> %8736, float %8739, i64 3
  %8741 = insertvalue [8 x <8 x float>] %8737, <8 x float> %8740, 4
  %8742 = fmul <8 x float> %8281, %8587
  %8743 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8742)
  %8744 = insertelement <8 x float> %8740, float %8743, i64 4
  %8745 = insertvalue [8 x <8 x float>] %8741, <8 x float> %8744, 4
  %8746 = fmul <8 x float> %8281, %8590
  %8747 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8746)
  %8748 = insertelement <8 x float> %8744, float %8747, i64 5
  %8749 = insertvalue [8 x <8 x float>] %8745, <8 x float> %8748, 4
  %8750 = fmul <8 x float> %8281, %8593
  %8751 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8750)
  %8752 = insertelement <8 x float> %8748, float %8751, i64 6
  %8753 = insertvalue [8 x <8 x float>] %8749, <8 x float> %8752, 4
  %8754 = fmul <8 x float> %8281, %8596
  %8755 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8754)
  %8756 = insertelement <8 x float> %8752, float %8755, i64 7
  %8757 = insertvalue [8 x <8 x float>] %8753, <8 x float> %8756, 4
  %8758 = fmul <8 x float> %8287, %8575
  %8759 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8758)
  %8760 = insertelement <8 x float> zeroinitializer, float %8759, i64 0
  %8761 = insertvalue [8 x <8 x float>] %8757, <8 x float> %8760, 5
  %8762 = fmul <8 x float> %8287, %8578
  %8763 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8762)
  %8764 = insertelement <8 x float> %8760, float %8763, i64 1
  %8765 = insertvalue [8 x <8 x float>] %8761, <8 x float> %8764, 5
  %8766 = fmul <8 x float> %8287, %8581
  %8767 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8766)
  %8768 = insertelement <8 x float> %8764, float %8767, i64 2
  %8769 = insertvalue [8 x <8 x float>] %8765, <8 x float> %8768, 5
  %8770 = fmul <8 x float> %8287, %8584
  %8771 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8770)
  %8772 = insertelement <8 x float> %8768, float %8771, i64 3
  %8773 = insertvalue [8 x <8 x float>] %8769, <8 x float> %8772, 5
  %8774 = fmul <8 x float> %8287, %8587
  %8775 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8774)
  %8776 = insertelement <8 x float> %8772, float %8775, i64 4
  %8777 = insertvalue [8 x <8 x float>] %8773, <8 x float> %8776, 5
  %8778 = fmul <8 x float> %8287, %8590
  %8779 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8778)
  %8780 = insertelement <8 x float> %8776, float %8779, i64 5
  %8781 = insertvalue [8 x <8 x float>] %8777, <8 x float> %8780, 5
  %8782 = fmul <8 x float> %8287, %8593
  %8783 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8782)
  %8784 = insertelement <8 x float> %8780, float %8783, i64 6
  %8785 = insertvalue [8 x <8 x float>] %8781, <8 x float> %8784, 5
  %8786 = fmul <8 x float> %8287, %8596
  %8787 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8786)
  %8788 = insertelement <8 x float> %8784, float %8787, i64 7
  %8789 = insertvalue [8 x <8 x float>] %8785, <8 x float> %8788, 5
  %8790 = fmul <8 x float> %8293, %8575
  %8791 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8790)
  %8792 = insertelement <8 x float> zeroinitializer, float %8791, i64 0
  %8793 = insertvalue [8 x <8 x float>] %8789, <8 x float> %8792, 6
  %8794 = fmul <8 x float> %8293, %8578
  %8795 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8794)
  %8796 = insertelement <8 x float> %8792, float %8795, i64 1
  %8797 = insertvalue [8 x <8 x float>] %8793, <8 x float> %8796, 6
  %8798 = fmul <8 x float> %8293, %8581
  %8799 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8798)
  %8800 = insertelement <8 x float> %8796, float %8799, i64 2
  %8801 = insertvalue [8 x <8 x float>] %8797, <8 x float> %8800, 6
  %8802 = fmul <8 x float> %8293, %8584
  %8803 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8802)
  %8804 = insertelement <8 x float> %8800, float %8803, i64 3
  %8805 = insertvalue [8 x <8 x float>] %8801, <8 x float> %8804, 6
  %8806 = fmul <8 x float> %8293, %8587
  %8807 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8806)
  %8808 = insertelement <8 x float> %8804, float %8807, i64 4
  %8809 = insertvalue [8 x <8 x float>] %8805, <8 x float> %8808, 6
  %8810 = fmul <8 x float> %8293, %8590
  %8811 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8810)
  %8812 = insertelement <8 x float> %8808, float %8811, i64 5
  %8813 = insertvalue [8 x <8 x float>] %8809, <8 x float> %8812, 6
  %8814 = fmul <8 x float> %8293, %8593
  %8815 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8814)
  %8816 = insertelement <8 x float> %8812, float %8815, i64 6
  %8817 = insertvalue [8 x <8 x float>] %8813, <8 x float> %8816, 6
  %8818 = fmul <8 x float> %8293, %8596
  %8819 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8818)
  %8820 = insertelement <8 x float> %8816, float %8819, i64 7
  %8821 = insertvalue [8 x <8 x float>] %8817, <8 x float> %8820, 6
  %8822 = fmul <8 x float> %8299, %8575
  %8823 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8822)
  %8824 = insertelement <8 x float> zeroinitializer, float %8823, i64 0
  %8825 = insertvalue [8 x <8 x float>] %8821, <8 x float> %8824, 7
  %8826 = fmul <8 x float> %8299, %8578
  %8827 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8826)
  %8828 = insertelement <8 x float> %8824, float %8827, i64 1
  %8829 = insertvalue [8 x <8 x float>] %8825, <8 x float> %8828, 7
  %8830 = fmul <8 x float> %8299, %8581
  %8831 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8830)
  %8832 = insertelement <8 x float> %8828, float %8831, i64 2
  %8833 = insertvalue [8 x <8 x float>] %8829, <8 x float> %8832, 7
  %8834 = fmul <8 x float> %8299, %8584
  %8835 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8834)
  %8836 = insertelement <8 x float> %8832, float %8835, i64 3
  %8837 = insertvalue [8 x <8 x float>] %8833, <8 x float> %8836, 7
  %8838 = fmul <8 x float> %8299, %8587
  %8839 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8838)
  %8840 = insertelement <8 x float> %8836, float %8839, i64 4
  %8841 = insertvalue [8 x <8 x float>] %8837, <8 x float> %8840, 7
  %8842 = fmul <8 x float> %8299, %8590
  %8843 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8842)
  %8844 = insertelement <8 x float> %8840, float %8843, i64 5
  %8845 = insertvalue [8 x <8 x float>] %8841, <8 x float> %8844, 7
  %8846 = fmul <8 x float> %8299, %8593
  %8847 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8846)
  %8848 = insertelement <8 x float> %8844, float %8847, i64 6
  %8849 = insertvalue [8 x <8 x float>] %8845, <8 x float> %8848, 7
  %8850 = fmul <8 x float> %8299, %8596
  %8851 = call float @llvm.vector.reduce.fadd.v8f32(float 0.000000e+00, <8 x float> %8850)
  %8852 = insertelement <8 x float> %8848, float %8851, i64 7
  %8853 = insertvalue [8 x <8 x float>] %8849, <8 x float> %8852, 7
  %8854 = fadd <8 x float> %8628, %8355
  %8855 = insertvalue [8 x <8 x float>] poison, <8 x float> %8854, 0
  %8856 = fadd <8 x float> %8660, %8362
  %8857 = insertvalue [8 x <8 x float>] %8855, <8 x float> %8856, 1
  %8858 = fadd <8 x float> %8692, %8369
  %8859 = insertvalue [8 x <8 x float>] %8857, <8 x float> %8858, 2
  %8860 = fadd <8 x float> %8724, %8376
  %8861 = insertvalue [8 x <8 x float>] %8859, <8 x float> %8860, 3
  %8862 = fadd <8 x float> %8756, %8383
  %8863 = insertvalue [8 x <8 x float>] %8861, <8 x float> %8862, 4
  %8864 = fadd <8 x float> %8788, %8390
  %8865 = insertvalue [8 x <8 x float>] %8863, <8 x float> %8864, 5
  %8866 = fadd <8 x float> %8820, %8397
  %8867 = insertvalue [8 x <8 x float>] %8865, <8 x float> %8866, 6
  %8868 = fadd <8 x float> %8852, %8404
  %8869 = insertvalue [8 x <8 x float>] %8867, <8 x float> %8868, 7
  %8870 = extractvalue [8 x <8 x float>] %8869, 0
  %8871 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8250, 1
  %8872 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8250, 2
  %8873 = getelementptr float, ptr %8871, i64 %8872
  %8874 = getelementptr float, ptr %8873, i64 0
  store <8 x float> %8870, ptr %8874, align 4
  %8875 = extractvalue [8 x <8 x float>] %8869, 1
  %8876 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8250, 1
  %8877 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8250, 2
  %8878 = getelementptr float, ptr %8876, i64 %8877
  %8879 = getelementptr float, ptr %8878, i64 4096
  store <8 x float> %8875, ptr %8879, align 4
  %8880 = extractvalue [8 x <8 x float>] %8869, 2
  %8881 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8250, 1
  %8882 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8250, 2
  %8883 = getelementptr float, ptr %8881, i64 %8882
  %8884 = getelementptr float, ptr %8883, i64 8192
  store <8 x float> %8880, ptr %8884, align 4
  %8885 = extractvalue [8 x <8 x float>] %8869, 3
  %8886 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8250, 1
  %8887 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8250, 2
  %8888 = getelementptr float, ptr %8886, i64 %8887
  %8889 = getelementptr float, ptr %8888, i64 12288
  store <8 x float> %8885, ptr %8889, align 4
  %8890 = extractvalue [8 x <8 x float>] %8869, 4
  %8891 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8250, 1
  %8892 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8250, 2
  %8893 = getelementptr float, ptr %8891, i64 %8892
  %8894 = getelementptr float, ptr %8893, i64 16384
  store <8 x float> %8890, ptr %8894, align 4
  %8895 = extractvalue [8 x <8 x float>] %8869, 5
  %8896 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8250, 1
  %8897 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8250, 2
  %8898 = getelementptr float, ptr %8896, i64 %8897
  %8899 = getelementptr float, ptr %8898, i64 20480
  store <8 x float> %8895, ptr %8899, align 4
  %8900 = extractvalue [8 x <8 x float>] %8869, 6
  %8901 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8250, 1
  %8902 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8250, 2
  %8903 = getelementptr float, ptr %8901, i64 %8902
  %8904 = getelementptr float, ptr %8903, i64 24576
  store <8 x float> %8900, ptr %8904, align 4
  %8905 = extractvalue [8 x <8 x float>] %8869, 7
  %8906 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8250, 1
  %8907 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8250, 2
  %8908 = getelementptr float, ptr %8906, i64 %8907
  %8909 = getelementptr float, ptr %8908, i64 28672
  store <8 x float> %8905, ptr %8909, align 4
  %8910 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 0
  %8911 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 1
  %8912 = insertvalue { ptr, ptr, i64 } poison, ptr %8910, 0
  %8913 = insertvalue { ptr, ptr, i64 } %8912, ptr %8911, 1
  %8914 = insertvalue { ptr, ptr, i64 } %8913, i64 0, 2
  %8915 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 2
  %8916 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 3, 0
  %8917 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 3, 1
  %8918 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 4, 0
  %8919 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %10, 4, 1
  %8920 = mul nsw i64 %8218, 32768
  %8921 = mul nsw i64 %8222, 8
  %8922 = add i64 %8920, %8921
  %8923 = extractvalue { ptr, ptr, i64 } %8914, 0
  %8924 = extractvalue { ptr, ptr, i64 } %8914, 1
  %8925 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %8923, 0
  %8926 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8925, ptr %8924, 1
  %8927 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8926, i64 %8922, 2
  %8928 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8927, i64 8, 3, 0
  %8929 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8928, i64 4096, 4, 0
  %8930 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8929, i64 8, 3, 1
  %8931 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8930, i64 1, 4, 1
  br label %8932

8932:                                             ; preds = %8954, %8228
  %8933 = phi i64 [ %8955, %8954 ], [ 0, %8228 ]
  %8934 = icmp slt i64 %8933, 8
  br i1 %8934, label %8935, label %8956

8935:                                             ; preds = %8932
  br label %8936

8936:                                             ; preds = %8939, %8935
  %8937 = phi i64 [ %8953, %8939 ], [ 0, %8935 ]
  %8938 = icmp slt i64 %8937, 8
  br i1 %8938, label %8939, label %8954

8939:                                             ; preds = %8936
  %8940 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8250, 1
  %8941 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8250, 2
  %8942 = getelementptr float, ptr %8940, i64 %8941
  %8943 = mul nuw nsw i64 %8933, 4096
  %8944 = add nuw nsw i64 %8943, %8937
  %8945 = getelementptr inbounds float, ptr %8942, i64 %8944
  %8946 = load float, ptr %8945, align 4
  %8947 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8931, 1
  %8948 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %8931, 2
  %8949 = getelementptr float, ptr %8947, i64 %8948
  %8950 = mul nuw nsw i64 %8933, 4096
  %8951 = add nuw nsw i64 %8950, %8937
  %8952 = getelementptr inbounds float, ptr %8949, i64 %8951
  store float %8946, ptr %8952, align 4
  %8953 = add i64 %8937, 1
  br label %8936

8954:                                             ; preds = %8936
  %8955 = add i64 %8933, 1
  br label %8932

8956:                                             ; preds = %8932
  %8957 = add i64 %8226, 1
  br label %8225

8958:                                             ; preds = %8225
  %8959 = add i64 %8222, 1
  br label %8221

8960:                                             ; preds = %8221
  %8961 = add i64 %8218, 1
  br label %8217

8962:                                             ; preds = %8217
  ret void
}

; Function Attrs: nocallback  nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.vector.reduce.fadd.v8f32(float, <8 x float>) #0

attributes #0 = { nocallback  nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
