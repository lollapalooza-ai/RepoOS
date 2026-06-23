; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@assert_msg = private constant [52 x i8] c"mismatching contracting dimension for torch.aten.mm\00"

declare void @abort()

declare void @puts(ptr)

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
  %43 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 3
  %44 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %43, ptr %44, align 4
  %45 = getelementptr [2 x i64], ptr %44, i32 0, i64 1
  %46 = load i64, ptr %45, align 4
  %47 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, 3
  %48 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %47, ptr %48, align 4
  %49 = getelementptr [2 x i64], ptr %48, i32 0, i64 0
  %50 = load i64, ptr %49, align 4
  %51 = icmp eq i64 %46, %50
  br i1 %51, label %52, label %314

52:                                               ; preds = %21
  %53 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 3
  %54 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %53, ptr %54, align 4
  %55 = getelementptr [2 x i64], ptr %54, i32 0, i64 0
  %56 = load i64, ptr %55, align 4
  %57 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 3
  %58 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %57, ptr %58, align 4
  %59 = getelementptr [2 x i64], ptr %58, i32 0, i64 1
  %60 = load i64, ptr %59, align 4
  br label %61

61:                                               ; preds = %75, %52
  %62 = phi i64 [ %76, %75 ], [ 0, %52 ]
  %63 = icmp slt i64 %62, %56
  br i1 %63, label %64, label %77

64:                                               ; preds = %61
  br label %65

65:                                               ; preds = %68, %64
  %66 = phi i64 [ %74, %68 ], [ 0, %64 ]
  %67 = icmp slt i64 %66, %60
  br i1 %67, label %68, label %75

68:                                               ; preds = %65
  %69 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 1
  %70 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 4, 0
  %71 = mul nuw nsw i64 %62, %70
  %72 = add nuw nsw i64 %71, %66
  %73 = getelementptr inbounds float, ptr %69, i64 %72
  store float 0.000000e+00, ptr %73, align 4
  %74 = add i64 %66, 1
  br label %65

75:                                               ; preds = %65
  %76 = add i64 %62, 1
  br label %61

77:                                               ; preds = %61
  %78 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 3
  %79 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %78, ptr %79, align 4
  %80 = getelementptr [2 x i64], ptr %79, i32 0, i64 0
  %81 = load i64, ptr %80, align 4
  %82 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 3
  %83 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %82, ptr %83, align 4
  %84 = getelementptr [2 x i64], ptr %83, i32 0, i64 1
  %85 = load i64, ptr %84, align 4
  %86 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, 3
  %87 = alloca [2 x i64], i64 1, align 8
  store [2 x i64] %86, ptr %87, align 4
  %88 = getelementptr [2 x i64], ptr %87, i32 0, i64 1
  %89 = load i64, ptr %88, align 4
  %90 = icmp sle i64 %81, 0
  %91 = sub i64 0, %81
  %92 = sub i64 %81, 1
  %93 = select i1 %90, i64 %91, i64 %92
  %94 = sdiv i64 %93, 8
  %95 = sub i64 0, %94
  %96 = add i64 %94, 1
  %97 = select i1 %90, i64 %95, i64 %96
  %98 = icmp sle i64 %89, 0
  %99 = sub i64 0, %89
  %100 = sub i64 %89, 1
  %101 = select i1 %98, i64 %99, i64 %100
  %102 = sdiv i64 %101, 16
  %103 = sub i64 0, %102
  %104 = add i64 %102, 1
  %105 = select i1 %98, i64 %103, i64 %104
  %106 = icmp sle i64 %85, 0
  %107 = sub i64 0, %85
  %108 = sub i64 %85, 1
  %109 = select i1 %106, i64 %107, i64 %108
  %110 = sdiv i64 %109, 16
  %111 = sub i64 0, %110
  %112 = add i64 %110, 1
  %113 = select i1 %106, i64 %111, i64 %112
  br label %114

114:                                              ; preds = %311, %77
  %115 = phi i64 [ %312, %311 ], [ 0, %77 ]
  %116 = icmp slt i64 %115, %97
  br i1 %116, label %117, label %313

117:                                              ; preds = %114
  br label %118

118:                                              ; preds = %309, %117
  %119 = phi i64 [ %310, %309 ], [ 0, %117 ]
  %120 = icmp slt i64 %119, %105
  br i1 %120, label %121, label %311

121:                                              ; preds = %118
  br label %122

122:                                              ; preds = %307, %121
  %123 = phi i64 [ %308, %307 ], [ 0, %121 ]
  %124 = icmp slt i64 %123, %113
  br i1 %124, label %125, label %309

125:                                              ; preds = %122
  %126 = mul nsw i64 %115, 8
  %127 = mul nsw i64 %119, 16
  %128 = mul nsw i64 %123, 16
  %129 = mul nsw i64 %126, -1
  %130 = add i64 %129, %81
  %131 = call i64 @llvm.smin.i64(i64 %130, i64 8)
  %132 = mul nsw i64 %127, -1
  %133 = add i64 %132, %89
  %134 = call i64 @llvm.smin.i64(i64 %133, i64 16)
  %135 = mul nsw i64 %128, -1
  %136 = add i64 %135, %85
  %137 = call i64 @llvm.smin.i64(i64 %136, i64 16)
  %138 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 0
  %139 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 1
  %140 = insertvalue { ptr, ptr, i64 } poison, ptr %138, 0
  %141 = insertvalue { ptr, ptr, i64 } %140, ptr %139, 1
  %142 = insertvalue { ptr, ptr, i64 } %141, i64 0, 2
  %143 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 2
  %144 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 3, 0
  %145 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 3, 1
  %146 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 4, 0
  %147 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %42, 4, 1
  %148 = mul nsw i64 %115, %146
  %149 = mul nsw i64 %148, 8
  %150 = mul nsw i64 %123, 16
  %151 = add i64 %149, %150
  %152 = extractvalue { ptr, ptr, i64 } %142, 0
  %153 = extractvalue { ptr, ptr, i64 } %142, 1
  %154 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %152, 0
  %155 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %154, ptr %153, 1
  %156 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %155, i64 %151, 2
  %157 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %156, i64 %131, 3, 0
  %158 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %157, i64 %146, 4, 0
  %159 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %158, i64 %137, 3, 1
  %160 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %159, i64 1, 4, 1
  %161 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, 0
  %162 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, 1
  %163 = insertvalue { ptr, ptr, i64 } poison, ptr %161, 0
  %164 = insertvalue { ptr, ptr, i64 } %163, ptr %162, 1
  %165 = insertvalue { ptr, ptr, i64 } %164, i64 0, 2
  %166 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, 2
  %167 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, 3, 0
  %168 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, 3, 1
  %169 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, 4, 0
  %170 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %35, 4, 1
  %171 = mul nsw i64 %123, %169
  %172 = mul nsw i64 %171, 16
  %173 = mul nsw i64 %119, 16
  %174 = add i64 %172, %173
  %175 = extractvalue { ptr, ptr, i64 } %165, 0
  %176 = extractvalue { ptr, ptr, i64 } %165, 1
  %177 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %175, 0
  %178 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %177, ptr %176, 1
  %179 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %178, i64 %174, 2
  %180 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %179, i64 %137, 3, 0
  %181 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %180, i64 %169, 4, 0
  %182 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %181, i64 %134, 3, 1
  %183 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %182, i64 1, 4, 1
  %184 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 0
  %185 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 1
  %186 = insertvalue { ptr, ptr, i64 } poison, ptr %184, 0
  %187 = insertvalue { ptr, ptr, i64 } %186, ptr %185, 1
  %188 = insertvalue { ptr, ptr, i64 } %187, i64 0, 2
  %189 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 2
  %190 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 3, 0
  %191 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 3, 1
  %192 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 4, 0
  %193 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 4, 1
  %194 = mul nsw i64 %115, %192
  %195 = mul nsw i64 %194, 8
  %196 = mul nsw i64 %119, 16
  %197 = add i64 %195, %196
  %198 = extractvalue { ptr, ptr, i64 } %188, 0
  %199 = extractvalue { ptr, ptr, i64 } %188, 1
  %200 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %198, 0
  %201 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %200, ptr %199, 1
  %202 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %201, i64 %197, 2
  %203 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %202, i64 %131, 3, 0
  %204 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %203, i64 %192, 4, 0
  %205 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %204, i64 %134, 3, 1
  %206 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %205, i64 1, 4, 1
  br label %207

207:                                              ; preds = %255, %125
  %208 = phi i64 [ %256, %255 ], [ 0, %125 ]
  %209 = icmp slt i64 %208, %131
  br i1 %209, label %210, label %257

210:                                              ; preds = %207
  br label %211

211:                                              ; preds = %253, %210
  %212 = phi i64 [ %254, %253 ], [ 0, %210 ]
  %213 = icmp slt i64 %212, %134
  br i1 %213, label %214, label %255

214:                                              ; preds = %211
  br label %215

215:                                              ; preds = %218, %214
  %216 = phi i64 [ %252, %218 ], [ 0, %214 ]
  %217 = icmp slt i64 %216, %137
  br i1 %217, label %218, label %253

218:                                              ; preds = %215
  %219 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %160, 1
  %220 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %160, 2
  %221 = getelementptr float, ptr %219, i64 %220
  %222 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %160, 4, 0
  %223 = mul nuw nsw i64 %208, %222
  %224 = add nuw nsw i64 %223, %216
  %225 = getelementptr inbounds float, ptr %221, i64 %224
  %226 = load float, ptr %225, align 4
  %227 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %183, 1
  %228 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %183, 2
  %229 = getelementptr float, ptr %227, i64 %228
  %230 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %183, 4, 0
  %231 = mul nuw nsw i64 %216, %230
  %232 = add nuw nsw i64 %231, %212
  %233 = getelementptr inbounds float, ptr %229, i64 %232
  %234 = load float, ptr %233, align 4
  %235 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %206, 1
  %236 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %206, 2
  %237 = getelementptr float, ptr %235, i64 %236
  %238 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %206, 4, 0
  %239 = mul nuw nsw i64 %208, %238
  %240 = add nuw nsw i64 %239, %212
  %241 = getelementptr inbounds float, ptr %237, i64 %240
  %242 = load float, ptr %241, align 4
  %243 = fmul float %226, %234
  %244 = fadd float %242, %243
  %245 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %206, 1
  %246 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %206, 2
  %247 = getelementptr float, ptr %245, i64 %246
  %248 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %206, 4, 0
  %249 = mul nuw nsw i64 %208, %248
  %250 = add nuw nsw i64 %249, %212
  %251 = getelementptr inbounds float, ptr %247, i64 %250
  store float %244, ptr %251, align 4
  %252 = add i64 %216, 1
  br label %215

253:                                              ; preds = %215
  %254 = add i64 %212, 1
  br label %211

255:                                              ; preds = %211
  %256 = add i64 %208, 1
  br label %207

257:                                              ; preds = %207
  %258 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 0
  %259 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 1
  %260 = insertvalue { ptr, ptr, i64 } poison, ptr %258, 0
  %261 = insertvalue { ptr, ptr, i64 } %260, ptr %259, 1
  %262 = insertvalue { ptr, ptr, i64 } %261, i64 0, 2
  %263 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 2
  %264 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 3, 0
  %265 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 3, 1
  %266 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 4, 0
  %267 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %28, 4, 1
  %268 = mul nsw i64 %115, %266
  %269 = mul nsw i64 %268, 8
  %270 = mul nsw i64 %119, 16
  %271 = add i64 %269, %270
  %272 = extractvalue { ptr, ptr, i64 } %262, 0
  %273 = extractvalue { ptr, ptr, i64 } %262, 1
  %274 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %272, 0
  %275 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %274, ptr %273, 1
  %276 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %275, i64 %271, 2
  %277 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %276, i64 %131, 3, 0
  %278 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %277, i64 %266, 4, 0
  %279 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %278, i64 %134, 3, 1
  %280 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %279, i64 1, 4, 1
  br label %281

281:                                              ; preds = %305, %257
  %282 = phi i64 [ %306, %305 ], [ 0, %257 ]
  %283 = icmp slt i64 %282, %131
  br i1 %283, label %284, label %307

284:                                              ; preds = %281
  br label %285

285:                                              ; preds = %288, %284
  %286 = phi i64 [ %304, %288 ], [ 0, %284 ]
  %287 = icmp slt i64 %286, %134
  br i1 %287, label %288, label %305

288:                                              ; preds = %285
  %289 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %206, 1
  %290 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %206, 2
  %291 = getelementptr float, ptr %289, i64 %290
  %292 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %206, 4, 0
  %293 = mul nuw nsw i64 %282, %292
  %294 = add nuw nsw i64 %293, %286
  %295 = getelementptr inbounds float, ptr %291, i64 %294
  %296 = load float, ptr %295, align 4
  %297 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %280, 1
  %298 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %280, 2
  %299 = getelementptr float, ptr %297, i64 %298
  %300 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %280, 4, 0
  %301 = mul nuw nsw i64 %282, %300
  %302 = add nuw nsw i64 %301, %286
  %303 = getelementptr inbounds float, ptr %299, i64 %302
  store float %296, ptr %303, align 4
  %304 = add i64 %286, 1
  br label %285

305:                                              ; preds = %285
  %306 = add i64 %282, 1
  br label %281

307:                                              ; preds = %281
  %308 = add i64 %123, 1
  br label %122

309:                                              ; preds = %122
  %310 = add i64 %119, 1
  br label %118

311:                                              ; preds = %118
  %312 = add i64 %115, 1
  br label %114

313:                                              ; preds = %114
  ret void

314:                                              ; preds = %21
  call void @puts(ptr @assert_msg)
  call void @abort()
  unreachable
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

; Function Attrs: nocallback  nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.smin.i64(i64, i64) #0

attributes #0 = { nocallback  nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
