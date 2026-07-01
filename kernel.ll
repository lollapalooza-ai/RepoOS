; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@__constant_xf32 = private constant float 0xFFF0000000000000, align 64

declare ptr @malloc(i64)

; Function Attrs: memory(none)
declare float @erff(float) #0

define void @main(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, ptr %5, ptr %6, i64 %7, i64 %8, i64 %9, ptr %10, ptr %11, i64 %12, i64 %13, i64 %14, i64 %15, i64 %16, i64 %17, i64 %18, ptr %19, ptr %20, i64 %21, i64 %22, i64 %23, i64 %24, i64 %25, ptr %26, ptr %27, i64 %28, i64 %29, i64 %30, ptr %31, ptr %32, i64 %33, i64 %34, i64 %35, i64 %36, i64 %37, i64 %38, i64 %39, i64 %40, i64 %41, ptr %42, ptr %43, i64 %44, i64 %45, i64 %46, i64 %47, i64 %48, ptr %49, ptr %50, i64 %51, i64 %52, i64 %53, ptr %54, ptr %55, i64 %56, i64 %57, i64 %58, ptr %59, ptr %60, i64 %61, i64 %62, i64 %63, ptr %64, ptr %65, i64 %66, i64 %67, i64 %68, i64 %69, i64 %70, ptr %71, ptr %72, i64 %73, i64 %74, i64 %75, ptr %76, ptr %77, i64 %78, i64 %79, i64 %80, i64 %81, i64 %82, ptr %83, ptr %84, i64 %85, i64 %86, i64 %87, ptr %88, ptr %89, i64 %90, i64 %91, i64 %92, ptr %93, ptr %94, i64 %95, i64 %96, i64 %97, ptr %98, ptr %99, i64 %100, i64 %101, i64 %102, i64 %103, i64 %104, ptr %105, ptr %106, i64 %107, i64 %108, i64 %109, ptr %110, ptr %111, i64 %112, i64 %113, i64 %114, i64 %115, i64 %116, i64 %117, i64 %118, i64 %119, i64 %120, ptr %121, ptr %122, i64 %123, i64 %124, i64 %125, i64 %126, i64 %127, ptr %128, ptr %129, i64 %130, i64 %131, i64 %132, ptr %133, ptr %134, i64 %135, i64 %136, i64 %137, ptr %138, ptr %139, i64 %140, i64 %141, i64 %142, ptr %143, ptr %144, i64 %145, i64 %146, i64 %147, i64 %148, i64 %149, ptr %150, ptr %151, i64 %152, i64 %153, i64 %154, ptr %155, ptr %156, i64 %157, i64 %158, i64 %159, i64 %160, i64 %161, ptr %162, ptr %163, i64 %164, i64 %165, i64 %166, ptr %167, ptr %168, i64 %169, i64 %170, i64 %171, i64 %172, i64 %173, i64 %174, i64 %175) {
  %177 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %167, 0
  %178 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %177, ptr %168, 1
  %179 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %178, i64 %169, 2
  %180 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %179, i64 %170, 3, 0
  %181 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %180, i64 %173, 4, 0
  %182 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %181, i64 %171, 3, 1
  %183 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %182, i64 %174, 4, 1
  %184 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %183, i64 %172, 3, 2
  %185 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %184, i64 %175, 4, 2
  %186 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %162, 0
  %187 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %186, ptr %163, 1
  %188 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %187, i64 %164, 2
  %189 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %188, i64 %165, 3, 0
  %190 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %189, i64 %166, 4, 0
  %191 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %155, 0
  %192 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %191, ptr %156, 1
  %193 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %192, i64 %157, 2
  %194 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %193, i64 %158, 3, 0
  %195 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %194, i64 %160, 4, 0
  %196 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %195, i64 %159, 3, 1
  %197 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %196, i64 %161, 4, 1
  %198 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %150, 0
  %199 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %198, ptr %151, 1
  %200 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %199, i64 %152, 2
  %201 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %200, i64 %153, 3, 0
  %202 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %201, i64 %154, 4, 0
  %203 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %143, 0
  %204 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %203, ptr %144, 1
  %205 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %204, i64 %145, 2
  %206 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %205, i64 %146, 3, 0
  %207 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %206, i64 %148, 4, 0
  %208 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %207, i64 %147, 3, 1
  %209 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %208, i64 %149, 4, 1
  %210 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %138, 0
  %211 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %210, ptr %139, 1
  %212 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %211, i64 %140, 2
  %213 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %212, i64 %141, 3, 0
  %214 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %213, i64 %142, 4, 0
  %215 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %133, 0
  %216 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %215, ptr %134, 1
  %217 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %216, i64 %135, 2
  %218 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %217, i64 %136, 3, 0
  %219 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %218, i64 %137, 4, 0
  %220 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %128, 0
  %221 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %220, ptr %129, 1
  %222 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %221, i64 %130, 2
  %223 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %222, i64 %131, 3, 0
  %224 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %223, i64 %132, 4, 0
  %225 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %121, 0
  %226 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %225, ptr %122, 1
  %227 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %226, i64 %123, 2
  %228 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %227, i64 %124, 3, 0
  %229 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %228, i64 %126, 4, 0
  %230 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %229, i64 %125, 3, 1
  %231 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %230, i64 %127, 4, 1
  %232 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %110, 0
  %233 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %232, ptr %111, 1
  %234 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %233, i64 %112, 2
  %235 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %234, i64 %113, 3, 0
  %236 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %235, i64 %117, 4, 0
  %237 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %236, i64 %114, 3, 1
  %238 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %237, i64 %118, 4, 1
  %239 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %238, i64 %115, 3, 2
  %240 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %239, i64 %119, 4, 2
  %241 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %240, i64 %116, 3, 3
  %242 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %241, i64 %120, 4, 3
  %243 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %105, 0
  %244 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %243, ptr %106, 1
  %245 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %244, i64 %107, 2
  %246 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %245, i64 %108, 3, 0
  %247 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %246, i64 %109, 4, 0
  %248 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %98, 0
  %249 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %248, ptr %99, 1
  %250 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %249, i64 %100, 2
  %251 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %250, i64 %101, 3, 0
  %252 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %251, i64 %103, 4, 0
  %253 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %252, i64 %102, 3, 1
  %254 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %253, i64 %104, 4, 1
  %255 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %93, 0
  %256 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %255, ptr %94, 1
  %257 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %256, i64 %95, 2
  %258 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %257, i64 %96, 3, 0
  %259 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %258, i64 %97, 4, 0
  %260 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %88, 0
  %261 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %260, ptr %89, 1
  %262 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %261, i64 %90, 2
  %263 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %262, i64 %91, 3, 0
  %264 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %263, i64 %92, 4, 0
  %265 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %83, 0
  %266 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %265, ptr %84, 1
  %267 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %266, i64 %85, 2
  %268 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %267, i64 %86, 3, 0
  %269 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %268, i64 %87, 4, 0
  %270 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %76, 0
  %271 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %270, ptr %77, 1
  %272 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %271, i64 %78, 2
  %273 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %272, i64 %79, 3, 0
  %274 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %273, i64 %81, 4, 0
  %275 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %274, i64 %80, 3, 1
  %276 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %275, i64 %82, 4, 1
  %277 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %71, 0
  %278 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %277, ptr %72, 1
  %279 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %278, i64 %73, 2
  %280 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %279, i64 %74, 3, 0
  %281 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %280, i64 %75, 4, 0
  %282 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %64, 0
  %283 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %282, ptr %65, 1
  %284 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %283, i64 %66, 2
  %285 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %284, i64 %67, 3, 0
  %286 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %285, i64 %69, 4, 0
  %287 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %286, i64 %68, 3, 1
  %288 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %287, i64 %70, 4, 1
  %289 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %59, 0
  %290 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %289, ptr %60, 1
  %291 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %290, i64 %61, 2
  %292 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %291, i64 %62, 3, 0
  %293 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %292, i64 %63, 4, 0
  %294 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %54, 0
  %295 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %294, ptr %55, 1
  %296 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %295, i64 %56, 2
  %297 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %296, i64 %57, 3, 0
  %298 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %297, i64 %58, 4, 0
  %299 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %49, 0
  %300 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %299, ptr %50, 1
  %301 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %300, i64 %51, 2
  %302 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %301, i64 %52, 3, 0
  %303 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %302, i64 %53, 4, 0
  %304 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %42, 0
  %305 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %304, ptr %43, 1
  %306 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %305, i64 %44, 2
  %307 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %306, i64 %45, 3, 0
  %308 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %307, i64 %47, 4, 0
  %309 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %308, i64 %46, 3, 1
  %310 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %309, i64 %48, 4, 1
  %311 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %31, 0
  %312 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %311, ptr %32, 1
  %313 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %312, i64 %33, 2
  %314 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %313, i64 %34, 3, 0
  %315 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %314, i64 %38, 4, 0
  %316 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %315, i64 %35, 3, 1
  %317 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %316, i64 %39, 4, 1
  %318 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %317, i64 %36, 3, 2
  %319 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %318, i64 %40, 4, 2
  %320 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %319, i64 %37, 3, 3
  %321 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %320, i64 %41, 4, 3
  %322 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %26, 0
  %323 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %322, ptr %27, 1
  %324 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %323, i64 %28, 2
  %325 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %324, i64 %29, 3, 0
  %326 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %325, i64 %30, 4, 0
  %327 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %19, 0
  %328 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %327, ptr %20, 1
  %329 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %328, i64 %21, 2
  %330 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %329, i64 %22, 3, 0
  %331 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %330, i64 %24, 4, 0
  %332 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %331, i64 %23, 3, 1
  %333 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %332, i64 %25, 4, 1
  %334 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %10, 0
  %335 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %334, ptr %11, 1
  %336 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %335, i64 %12, 2
  %337 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %336, i64 %13, 3, 0
  %338 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %337, i64 %16, 4, 0
  %339 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %338, i64 %14, 3, 1
  %340 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %339, i64 %17, 4, 1
  %341 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %340, i64 %15, 3, 2
  %342 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %341, i64 %18, 4, 2
  %343 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %5, 0
  %344 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %343, ptr %6, 1
  %345 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %344, i64 %7, 2
  %346 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %345, i64 %8, 3, 0
  %347 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %346, i64 %9, 4, 0
  %348 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %0, 0
  %349 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %348, ptr %1, 1
  %350 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %349, i64 %2, 2
  %351 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %350, i64 %3, 3, 0
  %352 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %351, i64 %4, 4, 0
  %353 = call ptr @malloc(i64 8256)
  %354 = ptrtoint ptr %353 to i64
  %355 = add i64 %354, 63
  %356 = urem i64 %355, 64
  %357 = sub i64 %355, %356
  %358 = inttoptr i64 %357 to ptr
  %359 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %353, 0
  %360 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %359, ptr %358, 1
  %361 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %360, i64 0, 2
  %362 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %361, i64 2, 3, 0
  %363 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %362, i64 1024, 3, 1
  %364 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %363, i64 1, 3, 2
  %365 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %364, i64 1024, 4, 0
  %366 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %365, i64 1, 4, 1
  %367 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %366, i64 1, 4, 2
  %368 = call ptr @malloc(i64 8256)
  %369 = ptrtoint ptr %368 to i64
  %370 = add i64 %369, 63
  %371 = urem i64 %370, 64
  %372 = sub i64 %370, %371
  %373 = inttoptr i64 %372 to ptr
  %374 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %368, 0
  %375 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %374, ptr %373, 1
  %376 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %375, i64 0, 2
  %377 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %376, i64 2, 3, 0
  %378 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %377, i64 1024, 3, 1
  %379 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %378, i64 1, 3, 2
  %380 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %379, i64 1024, 4, 0
  %381 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %380, i64 1, 4, 1
  %382 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %381, i64 1, 4, 2
  br label %383

383:                                              ; preds = %403, %176
  %384 = phi i64 [ %404, %403 ], [ 0, %176 ]
  %385 = icmp slt i64 %384, 2
  br i1 %385, label %386, label %405

386:                                              ; preds = %383
  br label %387

387:                                              ; preds = %401, %386
  %388 = phi i64 [ %402, %401 ], [ 0, %386 ]
  %389 = icmp slt i64 %388, 1024
  br i1 %389, label %390, label %403

390:                                              ; preds = %387
  br label %391

391:                                              ; preds = %394, %390
  %392 = phi i64 [ %400, %394 ], [ 0, %390 ]
  %393 = icmp slt i64 %392, 1
  br i1 %393, label %394, label %401

394:                                              ; preds = %391
  %395 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 1
  %396 = mul nuw nsw i64 %384, 1024
  %397 = add nuw nsw i64 %396, %388
  %398 = add nuw nsw i64 %397, %392
  %399 = getelementptr inbounds float, ptr %395, i64 %398
  store float 0.000000e+00, ptr %399, align 4
  %400 = add i64 %392, 1
  br label %391

401:                                              ; preds = %391
  %402 = add i64 %388, 1
  br label %387

403:                                              ; preds = %387
  %404 = add i64 %384, 1
  br label %383

405:                                              ; preds = %383
  %406 = call ptr @malloc(i64 8256)
  %407 = ptrtoint ptr %406 to i64
  %408 = add i64 %407, 63
  %409 = urem i64 %408, 64
  %410 = sub i64 %408, %409
  %411 = inttoptr i64 %410 to ptr
  %412 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %406, 0
  %413 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %412, ptr %411, 1
  %414 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %413, i64 0, 2
  %415 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %414, i64 2, 3, 0
  %416 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %415, i64 1024, 3, 1
  %417 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %416, i64 1, 3, 2
  %418 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %417, i64 1024, 4, 0
  %419 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %418, i64 1, 4, 1
  %420 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %419, i64 1, 4, 2
  %421 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 0
  %422 = mul i64 1, %421
  %423 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 1
  %424 = mul i64 %422, %423
  %425 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 2
  %426 = mul i64 %424, %425
  %427 = mul i64 %426, 4
  %428 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 1
  %429 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 2
  %430 = getelementptr float, ptr %428, i64 %429
  %431 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %420, 1
  %432 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %420, 2
  %433 = getelementptr float, ptr %431, i64 %432
  call void @llvm.memcpy.p0.p0.i64(ptr %433, ptr %430, i64 %427, i1 false)
  br label %434

434:                                              ; preds = %474, %405
  %435 = phi i64 [ %475, %474 ], [ 0, %405 ]
  %436 = icmp slt i64 %435, 2
  br i1 %436, label %437, label %476

437:                                              ; preds = %434
  br label %438

438:                                              ; preds = %472, %437
  %439 = phi i64 [ %473, %472 ], [ 0, %437 ]
  %440 = icmp slt i64 %439, 1024
  br i1 %440, label %441, label %474

441:                                              ; preds = %438
  br label %442

442:                                              ; preds = %445, %441
  %443 = phi i64 [ %471, %445 ], [ 0, %441 ]
  %444 = icmp slt i64 %443, 128
  br i1 %444, label %445, label %472

445:                                              ; preds = %442
  %446 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %342, 1
  %447 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %342, 2
  %448 = getelementptr float, ptr %446, i64 %447
  %449 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %342, 4, 0
  %450 = mul nuw nsw i64 %435, %449
  %451 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %342, 4, 1
  %452 = mul nuw nsw i64 %439, %451
  %453 = add nuw nsw i64 %450, %452
  %454 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %342, 4, 2
  %455 = mul nuw nsw i64 %443, %454
  %456 = add nuw nsw i64 %453, %455
  %457 = getelementptr inbounds float, ptr %448, i64 %456
  %458 = load float, ptr %457, align 4
  %459 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %420, 1
  %460 = mul nuw nsw i64 %435, 1024
  %461 = add nuw nsw i64 %460, %439
  %462 = add nuw nsw i64 %461, 0
  %463 = getelementptr inbounds float, ptr %459, i64 %462
  %464 = load float, ptr %463, align 4
  %465 = fadd float %458, %464
  %466 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %420, 1
  %467 = mul nuw nsw i64 %435, 1024
  %468 = add nuw nsw i64 %467, %439
  %469 = add nuw nsw i64 %468, 0
  %470 = getelementptr inbounds float, ptr %466, i64 %469
  store float %465, ptr %470, align 4
  %471 = add i64 %443, 1
  br label %442

472:                                              ; preds = %442
  %473 = add i64 %439, 1
  br label %438

474:                                              ; preds = %438
  %475 = add i64 %435, 1
  br label %434

476:                                              ; preds = %434
  br label %477

477:                                              ; preds = %504, %476
  %478 = phi i64 [ %505, %504 ], [ 0, %476 ]
  %479 = icmp slt i64 %478, 2
  br i1 %479, label %480, label %506

480:                                              ; preds = %477
  br label %481

481:                                              ; preds = %502, %480
  %482 = phi i64 [ %503, %502 ], [ 0, %480 ]
  %483 = icmp slt i64 %482, 1024
  br i1 %483, label %484, label %504

484:                                              ; preds = %481
  br label %485

485:                                              ; preds = %488, %484
  %486 = phi i64 [ %501, %488 ], [ 0, %484 ]
  %487 = icmp slt i64 %486, 1
  br i1 %487, label %488, label %502

488:                                              ; preds = %485
  %489 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %420, 1
  %490 = mul nuw nsw i64 %478, 1024
  %491 = add nuw nsw i64 %490, %482
  %492 = add nuw nsw i64 %491, %486
  %493 = getelementptr inbounds float, ptr %489, i64 %492
  %494 = load float, ptr %493, align 4
  %495 = fdiv float %494, 1.280000e+02
  %496 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %497 = mul nuw nsw i64 %478, 1024
  %498 = add nuw nsw i64 %497, %482
  %499 = add nuw nsw i64 %498, %486
  %500 = getelementptr inbounds float, ptr %496, i64 %499
  store float %495, ptr %500, align 4
  %501 = add i64 %486, 1
  br label %485

502:                                              ; preds = %485
  %503 = add i64 %482, 1
  br label %481

504:                                              ; preds = %481
  %505 = add i64 %478, 1
  br label %477

506:                                              ; preds = %477
  %507 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 0
  %508 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %509 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %507, 0
  %510 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %509, ptr %508, 1
  %511 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %510, i64 0, 2
  %512 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %511, i64 2, 3, 0
  %513 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %512, i64 1024, 4, 0
  %514 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %513, i64 1024, 3, 1
  %515 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %514, i64 1, 4, 1
  br label %516

516:                                              ; preds = %548, %506
  %517 = phi i64 [ %549, %548 ], [ 0, %506 ]
  %518 = icmp slt i64 %517, 2
  br i1 %518, label %519, label %550

519:                                              ; preds = %516
  br label %520

520:                                              ; preds = %546, %519
  %521 = phi i64 [ %547, %546 ], [ 0, %519 ]
  %522 = icmp slt i64 %521, 1024
  br i1 %522, label %523, label %548

523:                                              ; preds = %520
  br label %524

524:                                              ; preds = %527, %523
  %525 = phi i64 [ %545, %527 ], [ 0, %523 ]
  %526 = icmp slt i64 %525, 128
  br i1 %526, label %527, label %546

527:                                              ; preds = %524
  %528 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %515, 1
  %529 = mul nuw nsw i64 %517, 1024
  %530 = add nuw nsw i64 %529, %521
  %531 = getelementptr inbounds float, ptr %528, i64 %530
  %532 = load float, ptr %531, align 4
  %533 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %534 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %535 = getelementptr float, ptr %533, i64 %534
  %536 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %537 = mul nuw nsw i64 %517, %536
  %538 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %539 = mul nuw nsw i64 %521, %538
  %540 = add nuw nsw i64 %537, %539
  %541 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %542 = mul nuw nsw i64 %525, %541
  %543 = add nuw nsw i64 %540, %542
  %544 = getelementptr inbounds float, ptr %535, i64 %543
  store float %532, ptr %544, align 4
  %545 = add i64 %525, 1
  br label %524

546:                                              ; preds = %524
  %547 = add i64 %521, 1
  br label %520

548:                                              ; preds = %520
  %549 = add i64 %517, 1
  br label %516

550:                                              ; preds = %516
  %551 = call ptr @malloc(i64 1048640)
  %552 = ptrtoint ptr %551 to i64
  %553 = add i64 %552, 63
  %554 = urem i64 %553, 64
  %555 = sub i64 %553, %554
  %556 = inttoptr i64 %555 to ptr
  %557 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %551, 0
  %558 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %557, ptr %556, 1
  %559 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %558, i64 0, 2
  %560 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %559, i64 2, 3, 0
  %561 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %560, i64 1024, 3, 1
  %562 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %561, i64 128, 3, 2
  %563 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %562, i64 131072, 4, 0
  %564 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %563, i64 128, 4, 1
  %565 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %564, i64 1, 4, 2
  br label %566

566:                                              ; preds = %614, %550
  %567 = phi i64 [ %615, %614 ], [ 0, %550 ]
  %568 = icmp slt i64 %567, 2
  br i1 %568, label %569, label %616

569:                                              ; preds = %566
  br label %570

570:                                              ; preds = %612, %569
  %571 = phi i64 [ %613, %612 ], [ 0, %569 ]
  %572 = icmp slt i64 %571, 1024
  br i1 %572, label %573, label %614

573:                                              ; preds = %570
  br label %574

574:                                              ; preds = %577, %573
  %575 = phi i64 [ %611, %577 ], [ 0, %573 ]
  %576 = icmp slt i64 %575, 128
  br i1 %576, label %577, label %612

577:                                              ; preds = %574
  %578 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %342, 1
  %579 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %342, 2
  %580 = getelementptr float, ptr %578, i64 %579
  %581 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %342, 4, 0
  %582 = mul nuw nsw i64 %567, %581
  %583 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %342, 4, 1
  %584 = mul nuw nsw i64 %571, %583
  %585 = add nuw nsw i64 %582, %584
  %586 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %342, 4, 2
  %587 = mul nuw nsw i64 %575, %586
  %588 = add nuw nsw i64 %585, %587
  %589 = getelementptr inbounds float, ptr %580, i64 %588
  %590 = load float, ptr %589, align 4
  %591 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %592 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %593 = getelementptr float, ptr %591, i64 %592
  %594 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %595 = mul nuw nsw i64 %567, %594
  %596 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %597 = mul nuw nsw i64 %571, %596
  %598 = add nuw nsw i64 %595, %597
  %599 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %600 = mul nuw nsw i64 %575, %599
  %601 = add nuw nsw i64 %598, %600
  %602 = getelementptr inbounds float, ptr %593, i64 %601
  %603 = load float, ptr %602, align 4
  %604 = fsub float %590, %603
  %605 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %565, 1
  %606 = mul nuw nsw i64 %567, 131072
  %607 = mul nuw nsw i64 %571, 128
  %608 = add nuw nsw i64 %606, %607
  %609 = add nuw nsw i64 %608, %575
  %610 = getelementptr inbounds float, ptr %605, i64 %609
  store float %604, ptr %610, align 4
  %611 = add i64 %575, 1
  br label %574

612:                                              ; preds = %574
  %613 = add i64 %571, 1
  br label %570

614:                                              ; preds = %570
  %615 = add i64 %567, 1
  br label %566

616:                                              ; preds = %566
  br label %617

617:                                              ; preds = %659, %616
  %618 = phi i64 [ %660, %659 ], [ 0, %616 ]
  %619 = icmp slt i64 %618, 2
  br i1 %619, label %620, label %661

620:                                              ; preds = %617
  br label %621

621:                                              ; preds = %657, %620
  %622 = phi i64 [ %658, %657 ], [ 0, %620 ]
  %623 = icmp slt i64 %622, 1024
  br i1 %623, label %624, label %659

624:                                              ; preds = %621
  br label %625

625:                                              ; preds = %628, %624
  %626 = phi i64 [ %656, %628 ], [ 0, %624 ]
  %627 = icmp slt i64 %626, 128
  br i1 %627, label %628, label %657

628:                                              ; preds = %625
  %629 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %565, 1
  %630 = mul nuw nsw i64 %618, 131072
  %631 = mul nuw nsw i64 %622, 128
  %632 = add nuw nsw i64 %630, %631
  %633 = add nuw nsw i64 %632, %626
  %634 = getelementptr inbounds float, ptr %629, i64 %633
  %635 = load float, ptr %634, align 4
  %636 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %565, 1
  %637 = mul nuw nsw i64 %618, 131072
  %638 = mul nuw nsw i64 %622, 128
  %639 = add nuw nsw i64 %637, %638
  %640 = add nuw nsw i64 %639, %626
  %641 = getelementptr inbounds float, ptr %636, i64 %640
  %642 = load float, ptr %641, align 4
  %643 = fmul float %635, %642
  %644 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %645 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %646 = getelementptr float, ptr %644, i64 %645
  %647 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %648 = mul nuw nsw i64 %618, %647
  %649 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %650 = mul nuw nsw i64 %622, %649
  %651 = add nuw nsw i64 %648, %650
  %652 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %653 = mul nuw nsw i64 %626, %652
  %654 = add nuw nsw i64 %651, %653
  %655 = getelementptr inbounds float, ptr %646, i64 %654
  store float %643, ptr %655, align 4
  %656 = add i64 %626, 1
  br label %625

657:                                              ; preds = %625
  %658 = add i64 %622, 1
  br label %621

659:                                              ; preds = %621
  %660 = add i64 %618, 1
  br label %617

661:                                              ; preds = %617
  %662 = call ptr @malloc(i64 8256)
  %663 = ptrtoint ptr %662 to i64
  %664 = add i64 %663, 63
  %665 = urem i64 %664, 64
  %666 = sub i64 %664, %665
  %667 = inttoptr i64 %666 to ptr
  %668 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %662, 0
  %669 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %668, ptr %667, 1
  %670 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %669, i64 0, 2
  %671 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %670, i64 2, 3, 0
  %672 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %671, i64 1024, 3, 1
  %673 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %672, i64 1, 3, 2
  %674 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %673, i64 1024, 4, 0
  %675 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %674, i64 1, 4, 1
  %676 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %675, i64 1, 4, 2
  %677 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 0
  %678 = mul i64 1, %677
  %679 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 1
  %680 = mul i64 %678, %679
  %681 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 2
  %682 = mul i64 %680, %681
  %683 = mul i64 %682, 4
  %684 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 1
  %685 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 2
  %686 = getelementptr float, ptr %684, i64 %685
  %687 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %676, 1
  %688 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %676, 2
  %689 = getelementptr float, ptr %687, i64 %688
  call void @llvm.memcpy.p0.p0.i64(ptr %689, ptr %686, i64 %683, i1 false)
  br label %690

690:                                              ; preds = %730, %661
  %691 = phi i64 [ %731, %730 ], [ 0, %661 ]
  %692 = icmp slt i64 %691, 2
  br i1 %692, label %693, label %732

693:                                              ; preds = %690
  br label %694

694:                                              ; preds = %728, %693
  %695 = phi i64 [ %729, %728 ], [ 0, %693 ]
  %696 = icmp slt i64 %695, 1024
  br i1 %696, label %697, label %730

697:                                              ; preds = %694
  br label %698

698:                                              ; preds = %701, %697
  %699 = phi i64 [ %727, %701 ], [ 0, %697 ]
  %700 = icmp slt i64 %699, 128
  br i1 %700, label %701, label %728

701:                                              ; preds = %698
  %702 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %703 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %704 = getelementptr float, ptr %702, i64 %703
  %705 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %706 = mul nuw nsw i64 %691, %705
  %707 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %708 = mul nuw nsw i64 %695, %707
  %709 = add nuw nsw i64 %706, %708
  %710 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %711 = mul nuw nsw i64 %699, %710
  %712 = add nuw nsw i64 %709, %711
  %713 = getelementptr inbounds float, ptr %704, i64 %712
  %714 = load float, ptr %713, align 4
  %715 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %676, 1
  %716 = mul nuw nsw i64 %691, 1024
  %717 = add nuw nsw i64 %716, %695
  %718 = add nuw nsw i64 %717, 0
  %719 = getelementptr inbounds float, ptr %715, i64 %718
  %720 = load float, ptr %719, align 4
  %721 = fadd float %714, %720
  %722 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %676, 1
  %723 = mul nuw nsw i64 %691, 1024
  %724 = add nuw nsw i64 %723, %695
  %725 = add nuw nsw i64 %724, 0
  %726 = getelementptr inbounds float, ptr %722, i64 %725
  store float %721, ptr %726, align 4
  %727 = add i64 %699, 1
  br label %698

728:                                              ; preds = %698
  %729 = add i64 %695, 1
  br label %694

730:                                              ; preds = %694
  %731 = add i64 %691, 1
  br label %690

732:                                              ; preds = %690
  br label %733

733:                                              ; preds = %760, %732
  %734 = phi i64 [ %761, %760 ], [ 0, %732 ]
  %735 = icmp slt i64 %734, 2
  br i1 %735, label %736, label %762

736:                                              ; preds = %733
  br label %737

737:                                              ; preds = %758, %736
  %738 = phi i64 [ %759, %758 ], [ 0, %736 ]
  %739 = icmp slt i64 %738, 1024
  br i1 %739, label %740, label %760

740:                                              ; preds = %737
  br label %741

741:                                              ; preds = %744, %740
  %742 = phi i64 [ %757, %744 ], [ 0, %740 ]
  %743 = icmp slt i64 %742, 1
  br i1 %743, label %744, label %758

744:                                              ; preds = %741
  %745 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %676, 1
  %746 = mul nuw nsw i64 %734, 1024
  %747 = add nuw nsw i64 %746, %738
  %748 = add nuw nsw i64 %747, %742
  %749 = getelementptr inbounds float, ptr %745, i64 %748
  %750 = load float, ptr %749, align 4
  %751 = fdiv float %750, 1.280000e+02
  %752 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %753 = mul nuw nsw i64 %734, 1024
  %754 = add nuw nsw i64 %753, %738
  %755 = add nuw nsw i64 %754, %742
  %756 = getelementptr inbounds float, ptr %752, i64 %755
  store float %751, ptr %756, align 4
  %757 = add i64 %742, 1
  br label %741

758:                                              ; preds = %741
  %759 = add i64 %738, 1
  br label %737

760:                                              ; preds = %737
  %761 = add i64 %734, 1
  br label %733

762:                                              ; preds = %733
  br label %763

763:                                              ; preds = %790, %762
  %764 = phi i64 [ %791, %790 ], [ 0, %762 ]
  %765 = icmp slt i64 %764, 2
  br i1 %765, label %766, label %792

766:                                              ; preds = %763
  br label %767

767:                                              ; preds = %788, %766
  %768 = phi i64 [ %789, %788 ], [ 0, %766 ]
  %769 = icmp slt i64 %768, 1024
  br i1 %769, label %770, label %790

770:                                              ; preds = %767
  br label %771

771:                                              ; preds = %774, %770
  %772 = phi i64 [ %787, %774 ], [ 0, %770 ]
  %773 = icmp slt i64 %772, 1
  br i1 %773, label %774, label %788

774:                                              ; preds = %771
  %775 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %776 = mul nuw nsw i64 %764, 1024
  %777 = add nuw nsw i64 %776, %768
  %778 = add nuw nsw i64 %777, %772
  %779 = getelementptr inbounds float, ptr %775, i64 %778
  %780 = load float, ptr %779, align 4
  %781 = fadd float %780, 0x3EE4F8B580000000
  %782 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %783 = mul nuw nsw i64 %764, 1024
  %784 = add nuw nsw i64 %783, %768
  %785 = add nuw nsw i64 %784, %772
  %786 = getelementptr inbounds float, ptr %782, i64 %785
  store float %781, ptr %786, align 4
  %787 = add i64 %772, 1
  br label %771

788:                                              ; preds = %771
  %789 = add i64 %768, 1
  br label %767

790:                                              ; preds = %767
  %791 = add i64 %764, 1
  br label %763

792:                                              ; preds = %763
  br label %793

793:                                              ; preds = %821, %792
  %794 = phi i64 [ %822, %821 ], [ 0, %792 ]
  %795 = icmp slt i64 %794, 2
  br i1 %795, label %796, label %823

796:                                              ; preds = %793
  br label %797

797:                                              ; preds = %819, %796
  %798 = phi i64 [ %820, %819 ], [ 0, %796 ]
  %799 = icmp slt i64 %798, 1024
  br i1 %799, label %800, label %821

800:                                              ; preds = %797
  br label %801

801:                                              ; preds = %804, %800
  %802 = phi i64 [ %818, %804 ], [ 0, %800 ]
  %803 = icmp slt i64 %802, 1
  br i1 %803, label %804, label %819

804:                                              ; preds = %801
  %805 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %806 = mul nuw nsw i64 %794, 1024
  %807 = add nuw nsw i64 %806, %798
  %808 = add nuw nsw i64 %807, %802
  %809 = getelementptr inbounds float, ptr %805, i64 %808
  %810 = load float, ptr %809, align 4
  %811 = call float @llvm.sqrt.f32(float %810)
  %812 = fdiv float 1.000000e+00, %811
  %813 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %814 = mul nuw nsw i64 %794, 1024
  %815 = add nuw nsw i64 %814, %798
  %816 = add nuw nsw i64 %815, %802
  %817 = getelementptr inbounds float, ptr %813, i64 %816
  store float %812, ptr %817, align 4
  %818 = add i64 %802, 1
  br label %801

819:                                              ; preds = %801
  %820 = add i64 %798, 1
  br label %797

821:                                              ; preds = %797
  %822 = add i64 %794, 1
  br label %793

823:                                              ; preds = %793
  %824 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 0
  %825 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %826 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %824, 0
  %827 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %826, ptr %825, 1
  %828 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %827, i64 0, 2
  %829 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %828, i64 2, 3, 0
  %830 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %829, i64 1024, 4, 0
  %831 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %830, i64 1024, 3, 1
  %832 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %831, i64 1, 4, 1
  br label %833

833:                                              ; preds = %865, %823
  %834 = phi i64 [ %866, %865 ], [ 0, %823 ]
  %835 = icmp slt i64 %834, 2
  br i1 %835, label %836, label %867

836:                                              ; preds = %833
  br label %837

837:                                              ; preds = %863, %836
  %838 = phi i64 [ %864, %863 ], [ 0, %836 ]
  %839 = icmp slt i64 %838, 1024
  br i1 %839, label %840, label %865

840:                                              ; preds = %837
  br label %841

841:                                              ; preds = %844, %840
  %842 = phi i64 [ %862, %844 ], [ 0, %840 ]
  %843 = icmp slt i64 %842, 128
  br i1 %843, label %844, label %863

844:                                              ; preds = %841
  %845 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %832, 1
  %846 = mul nuw nsw i64 %834, 1024
  %847 = add nuw nsw i64 %846, %838
  %848 = getelementptr inbounds float, ptr %845, i64 %847
  %849 = load float, ptr %848, align 4
  %850 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %851 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %852 = getelementptr float, ptr %850, i64 %851
  %853 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %854 = mul nuw nsw i64 %834, %853
  %855 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %856 = mul nuw nsw i64 %838, %855
  %857 = add nuw nsw i64 %854, %856
  %858 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %859 = mul nuw nsw i64 %842, %858
  %860 = add nuw nsw i64 %857, %859
  %861 = getelementptr inbounds float, ptr %852, i64 %860
  store float %849, ptr %861, align 4
  %862 = add i64 %842, 1
  br label %841

863:                                              ; preds = %841
  %864 = add i64 %838, 1
  br label %837

865:                                              ; preds = %837
  %866 = add i64 %834, 1
  br label %833

867:                                              ; preds = %833
  br label %868

868:                                              ; preds = %916, %867
  %869 = phi i64 [ %917, %916 ], [ 0, %867 ]
  %870 = icmp slt i64 %869, 2
  br i1 %870, label %871, label %918

871:                                              ; preds = %868
  br label %872

872:                                              ; preds = %914, %871
  %873 = phi i64 [ %915, %914 ], [ 0, %871 ]
  %874 = icmp slt i64 %873, 1024
  br i1 %874, label %875, label %916

875:                                              ; preds = %872
  br label %876

876:                                              ; preds = %879, %875
  %877 = phi i64 [ %913, %879 ], [ 0, %875 ]
  %878 = icmp slt i64 %877, 128
  br i1 %878, label %879, label %914

879:                                              ; preds = %876
  %880 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %565, 1
  %881 = mul nuw nsw i64 %869, 131072
  %882 = mul nuw nsw i64 %873, 128
  %883 = add nuw nsw i64 %881, %882
  %884 = add nuw nsw i64 %883, %877
  %885 = getelementptr inbounds float, ptr %880, i64 %884
  %886 = load float, ptr %885, align 4
  %887 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %888 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %889 = getelementptr float, ptr %887, i64 %888
  %890 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %891 = mul nuw nsw i64 %869, %890
  %892 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %893 = mul nuw nsw i64 %873, %892
  %894 = add nuw nsw i64 %891, %893
  %895 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %896 = mul nuw nsw i64 %877, %895
  %897 = add nuw nsw i64 %894, %896
  %898 = getelementptr inbounds float, ptr %889, i64 %897
  %899 = load float, ptr %898, align 4
  %900 = fmul float %886, %899
  %901 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %902 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %903 = getelementptr float, ptr %901, i64 %902
  %904 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %905 = mul nuw nsw i64 %869, %904
  %906 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %907 = mul nuw nsw i64 %873, %906
  %908 = add nuw nsw i64 %905, %907
  %909 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %910 = mul nuw nsw i64 %877, %909
  %911 = add nuw nsw i64 %908, %910
  %912 = getelementptr inbounds float, ptr %903, i64 %911
  store float %900, ptr %912, align 4
  %913 = add i64 %877, 1
  br label %876

914:                                              ; preds = %876
  %915 = add i64 %873, 1
  br label %872

916:                                              ; preds = %872
  %917 = add i64 %869, 1
  br label %868

918:                                              ; preds = %868
  br label %919

919:                                              ; preds = %967, %918
  %920 = phi i64 [ %968, %967 ], [ 0, %918 ]
  %921 = icmp slt i64 %920, 2
  br i1 %921, label %922, label %969

922:                                              ; preds = %919
  br label %923

923:                                              ; preds = %965, %922
  %924 = phi i64 [ %966, %965 ], [ 0, %922 ]
  %925 = icmp slt i64 %924, 1024
  br i1 %925, label %926, label %967

926:                                              ; preds = %923
  br label %927

927:                                              ; preds = %930, %926
  %928 = phi i64 [ %964, %930 ], [ 0, %926 ]
  %929 = icmp slt i64 %928, 128
  br i1 %929, label %930, label %965

930:                                              ; preds = %927
  %931 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %932 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %933 = getelementptr float, ptr %931, i64 %932
  %934 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %935 = mul nuw nsw i64 %920, %934
  %936 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %937 = mul nuw nsw i64 %924, %936
  %938 = add nuw nsw i64 %935, %937
  %939 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %940 = mul nuw nsw i64 %928, %939
  %941 = add nuw nsw i64 %938, %940
  %942 = getelementptr inbounds float, ptr %933, i64 %941
  %943 = load float, ptr %942, align 4
  %944 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %352, 1
  %945 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %352, 2
  %946 = getelementptr float, ptr %944, i64 %945
  %947 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %352, 4, 0
  %948 = mul nuw nsw i64 %928, %947
  %949 = getelementptr inbounds float, ptr %946, i64 %948
  %950 = load float, ptr %949, align 4
  %951 = fmul float %943, %950
  %952 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %953 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %954 = getelementptr float, ptr %952, i64 %953
  %955 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %956 = mul nuw nsw i64 %920, %955
  %957 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %958 = mul nuw nsw i64 %924, %957
  %959 = add nuw nsw i64 %956, %958
  %960 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %961 = mul nuw nsw i64 %928, %960
  %962 = add nuw nsw i64 %959, %961
  %963 = getelementptr inbounds float, ptr %954, i64 %962
  store float %951, ptr %963, align 4
  %964 = add i64 %928, 1
  br label %927

965:                                              ; preds = %927
  %966 = add i64 %924, 1
  br label %923

967:                                              ; preds = %923
  %968 = add i64 %920, 1
  br label %919

969:                                              ; preds = %919
  br label %970

970:                                              ; preds = %1018, %969
  %971 = phi i64 [ %1019, %1018 ], [ 0, %969 ]
  %972 = icmp slt i64 %971, 2
  br i1 %972, label %973, label %1020

973:                                              ; preds = %970
  br label %974

974:                                              ; preds = %1016, %973
  %975 = phi i64 [ %1017, %1016 ], [ 0, %973 ]
  %976 = icmp slt i64 %975, 1024
  br i1 %976, label %977, label %1018

977:                                              ; preds = %974
  br label %978

978:                                              ; preds = %981, %977
  %979 = phi i64 [ %1015, %981 ], [ 0, %977 ]
  %980 = icmp slt i64 %979, 128
  br i1 %980, label %981, label %1016

981:                                              ; preds = %978
  %982 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %983 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %984 = getelementptr float, ptr %982, i64 %983
  %985 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %986 = mul nuw nsw i64 %971, %985
  %987 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %988 = mul nuw nsw i64 %975, %987
  %989 = add nuw nsw i64 %986, %988
  %990 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %991 = mul nuw nsw i64 %979, %990
  %992 = add nuw nsw i64 %989, %991
  %993 = getelementptr inbounds float, ptr %984, i64 %992
  %994 = load float, ptr %993, align 4
  %995 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %347, 1
  %996 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %347, 2
  %997 = getelementptr float, ptr %995, i64 %996
  %998 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %347, 4, 0
  %999 = mul nuw nsw i64 %979, %998
  %1000 = getelementptr inbounds float, ptr %997, i64 %999
  %1001 = load float, ptr %1000, align 4
  %1002 = fadd float %994, %1001
  %1003 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %1004 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %1005 = getelementptr float, ptr %1003, i64 %1004
  %1006 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %1007 = mul nuw nsw i64 %971, %1006
  %1008 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %1009 = mul nuw nsw i64 %975, %1008
  %1010 = add nuw nsw i64 %1007, %1009
  %1011 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %1012 = mul nuw nsw i64 %979, %1011
  %1013 = add nuw nsw i64 %1010, %1012
  %1014 = getelementptr inbounds float, ptr %1005, i64 %1013
  store float %1002, ptr %1014, align 4
  %1015 = add i64 %979, 1
  br label %978

1016:                                             ; preds = %978
  %1017 = add i64 %975, 1
  br label %974

1018:                                             ; preds = %974
  %1019 = add i64 %971, 1
  br label %970

1020:                                             ; preds = %970
  %1021 = call ptr @malloc(i64 196672)
  %1022 = ptrtoint ptr %1021 to i64
  %1023 = add i64 %1022, 63
  %1024 = urem i64 %1023, 64
  %1025 = sub i64 %1023, %1024
  %1026 = inttoptr i64 %1025 to ptr
  %1027 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %1021, 0
  %1028 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %1027, ptr %1026, 1
  %1029 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %1028, i64 0, 2
  %1030 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %1029, i64 128, 3, 0
  %1031 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %1030, i64 384, 3, 1
  %1032 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %1031, i64 384, 4, 0
  %1033 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %1032, i64 1, 4, 1
  br label %1034

1034:                                             ; preds = %1057, %1020
  %1035 = phi i64 [ %1058, %1057 ], [ 0, %1020 ]
  %1036 = icmp slt i64 %1035, 128
  br i1 %1036, label %1037, label %1059

1037:                                             ; preds = %1034
  br label %1038

1038:                                             ; preds = %1041, %1037
  %1039 = phi i64 [ %1056, %1041 ], [ 0, %1037 ]
  %1040 = icmp slt i64 %1039, 384
  br i1 %1040, label %1041, label %1057

1041:                                             ; preds = %1038
  %1042 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %333, 1
  %1043 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %333, 2
  %1044 = getelementptr float, ptr %1042, i64 %1043
  %1045 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %333, 4, 0
  %1046 = mul nuw nsw i64 %1039, %1045
  %1047 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %333, 4, 1
  %1048 = mul nuw nsw i64 %1035, %1047
  %1049 = add nuw nsw i64 %1046, %1048
  %1050 = getelementptr inbounds float, ptr %1044, i64 %1049
  %1051 = load float, ptr %1050, align 4
  %1052 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %1033, 1
  %1053 = mul nuw nsw i64 %1035, 384
  %1054 = add nuw nsw i64 %1053, %1039
  %1055 = getelementptr inbounds float, ptr %1052, i64 %1054
  store float %1051, ptr %1055, align 4
  %1056 = add i64 %1039, 1
  br label %1038

1057:                                             ; preds = %1038
  %1058 = add i64 %1035, 1
  br label %1034

1059:                                             ; preds = %1034
  %1060 = call ptr @malloc(i64 393280)
  %1061 = ptrtoint ptr %1060 to i64
  %1062 = add i64 %1061, 63
  %1063 = urem i64 %1062, 64
  %1064 = sub i64 %1062, %1063
  %1065 = inttoptr i64 %1064 to ptr
  %1066 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %1060, 0
  %1067 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1066, ptr %1065, 1
  %1068 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1067, i64 0, 2
  %1069 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1068, i64 2, 3, 0
  %1070 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1069, i64 128, 3, 1
  %1071 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1070, i64 384, 3, 2
  %1072 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1071, i64 49152, 4, 0
  %1073 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1072, i64 384, 4, 1
  %1074 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1073, i64 1, 4, 2
  br label %1075

1075:                                             ; preds = %1101, %1059
  %1076 = phi i64 [ %1102, %1101 ], [ 0, %1059 ]
  %1077 = icmp slt i64 %1076, 2
  br i1 %1077, label %1078, label %1103

1078:                                             ; preds = %1075
  br label %1079

1079:                                             ; preds = %1099, %1078
  %1080 = phi i64 [ %1100, %1099 ], [ 0, %1078 ]
  %1081 = icmp slt i64 %1080, 128
  br i1 %1081, label %1082, label %1101

1082:                                             ; preds = %1079
  br label %1083

1083:                                             ; preds = %1086, %1082
  %1084 = phi i64 [ %1098, %1086 ], [ 0, %1082 ]
  %1085 = icmp slt i64 %1084, 384
  br i1 %1085, label %1086, label %1099

1086:                                             ; preds = %1083
  %1087 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %1033, 1
  %1088 = mul nuw nsw i64 %1080, 384
  %1089 = add nuw nsw i64 %1088, %1084
  %1090 = getelementptr inbounds float, ptr %1087, i64 %1089
  %1091 = load float, ptr %1090, align 4
  %1092 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 1
  %1093 = mul nuw nsw i64 %1076, 49152
  %1094 = mul nuw nsw i64 %1080, 384
  %1095 = add nuw nsw i64 %1093, %1094
  %1096 = add nuw nsw i64 %1095, %1084
  %1097 = getelementptr inbounds float, ptr %1092, i64 %1096
  store float %1091, ptr %1097, align 4
  %1098 = add i64 %1084, 1
  br label %1083

1099:                                             ; preds = %1083
  %1100 = add i64 %1080, 1
  br label %1079

1101:                                             ; preds = %1079
  %1102 = add i64 %1076, 1
  br label %1075

1103:                                             ; preds = %1075
  %1104 = call ptr @malloc(i64 3145792)
  %1105 = ptrtoint ptr %1104 to i64
  %1106 = add i64 %1105, 63
  %1107 = urem i64 %1106, 64
  %1108 = sub i64 %1106, %1107
  %1109 = inttoptr i64 %1108 to ptr
  %1110 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %1104, 0
  %1111 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1110, ptr %1109, 1
  %1112 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1111, i64 0, 2
  %1113 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1112, i64 2, 3, 0
  %1114 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1113, i64 1024, 3, 1
  %1115 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1114, i64 384, 3, 2
  %1116 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1115, i64 393216, 4, 0
  %1117 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1116, i64 384, 4, 1
  %1118 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1117, i64 1, 4, 2
  %1119 = call ptr @malloc(i64 3145792)
  %1120 = ptrtoint ptr %1119 to i64
  %1121 = add i64 %1120, 63
  %1122 = urem i64 %1121, 64
  %1123 = sub i64 %1121, %1122
  %1124 = inttoptr i64 %1123 to ptr
  %1125 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %1119, 0
  %1126 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1125, ptr %1124, 1
  %1127 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1126, i64 0, 2
  %1128 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1127, i64 2, 3, 0
  %1129 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1128, i64 1024, 3, 1
  %1130 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1129, i64 384, 3, 2
  %1131 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1130, i64 393216, 4, 0
  %1132 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1131, i64 384, 4, 1
  %1133 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1132, i64 1, 4, 2
  br label %1134

1134:                                             ; preds = %1155, %1103
  %1135 = phi i64 [ %1156, %1155 ], [ 0, %1103 ]
  %1136 = icmp slt i64 %1135, 2
  br i1 %1136, label %1137, label %1157

1137:                                             ; preds = %1134
  br label %1138

1138:                                             ; preds = %1153, %1137
  %1139 = phi i64 [ %1154, %1153 ], [ 0, %1137 ]
  %1140 = icmp slt i64 %1139, 1024
  br i1 %1140, label %1141, label %1155

1141:                                             ; preds = %1138
  br label %1142

1142:                                             ; preds = %1145, %1141
  %1143 = phi i64 [ %1152, %1145 ], [ 0, %1141 ]
  %1144 = icmp slt i64 %1143, 384
  br i1 %1144, label %1145, label %1153

1145:                                             ; preds = %1142
  %1146 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1133, 1
  %1147 = mul nuw nsw i64 %1135, 393216
  %1148 = mul nuw nsw i64 %1139, 384
  %1149 = add nuw nsw i64 %1147, %1148
  %1150 = add nuw nsw i64 %1149, %1143
  %1151 = getelementptr inbounds float, ptr %1146, i64 %1150
  store float 0.000000e+00, ptr %1151, align 4
  %1152 = add i64 %1143, 1
  br label %1142

1153:                                             ; preds = %1142
  %1154 = add i64 %1139, 1
  br label %1138

1155:                                             ; preds = %1138
  %1156 = add i64 %1135, 1
  br label %1134

1157:                                             ; preds = %1134
  %1158 = call ptr @malloc(i64 3145792)
  %1159 = ptrtoint ptr %1158 to i64
  %1160 = add i64 %1159, 63
  %1161 = urem i64 %1160, 64
  %1162 = sub i64 %1160, %1161
  %1163 = inttoptr i64 %1162 to ptr
  %1164 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %1158, 0
  %1165 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1164, ptr %1163, 1
  %1166 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1165, i64 0, 2
  %1167 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1166, i64 2, 3, 0
  %1168 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1167, i64 1024, 3, 1
  %1169 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1168, i64 384, 3, 2
  %1170 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1169, i64 393216, 4, 0
  %1171 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1170, i64 384, 4, 1
  %1172 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1171, i64 1, 4, 2
  %1173 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1133, 3, 0
  %1174 = mul i64 1, %1173
  %1175 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1133, 3, 1
  %1176 = mul i64 %1174, %1175
  %1177 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1133, 3, 2
  %1178 = mul i64 %1176, %1177
  %1179 = mul i64 %1178, 4
  %1180 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1133, 1
  %1181 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1133, 2
  %1182 = getelementptr float, ptr %1180, i64 %1181
  %1183 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1172, 1
  %1184 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1172, 2
  %1185 = getelementptr float, ptr %1183, i64 %1184
  call void @llvm.memcpy.p0.p0.i64(ptr %1185, ptr %1182, i64 %1179, i1 false)
  %1186 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 0
  %1187 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %1188 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %1189 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 3, 0
  %1190 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 3, 1
  %1191 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 3, 2
  %1192 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %1193 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %1194 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %1195 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 0
  %1196 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 1
  %1197 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 2
  %1198 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 3, 0
  %1199 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 3, 1
  %1200 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 3, 2
  %1201 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 4, 0
  %1202 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 4, 1
  %1203 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 4, 2
  %1204 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1172, 0
  %1205 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1172, 1
  %1206 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1172, 2
  %1207 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1172, 3, 0
  %1208 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1172, 3, 1
  %1209 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1172, 3, 2
  %1210 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1172, 4, 0
  %1211 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1172, 4, 1
  %1212 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1172, 4, 2
  call void @ukernel_bmm(ptr %1186, ptr %1187, i64 %1188, i64 %1189, i64 %1190, i64 %1191, i64 %1192, i64 %1193, i64 %1194, ptr %1195, ptr %1196, i64 %1197, i64 %1198, i64 %1199, i64 %1200, i64 %1201, i64 %1202, i64 %1203, ptr %1204, ptr %1205, i64 %1206, i64 %1207, i64 %1208, i64 %1209, i64 %1210, i64 %1211, i64 %1212)
  br label %1213

1213:                                             ; preds = %1249, %1157
  %1214 = phi i64 [ %1250, %1249 ], [ 0, %1157 ]
  %1215 = icmp slt i64 %1214, 2
  br i1 %1215, label %1216, label %1251

1216:                                             ; preds = %1213
  br label %1217

1217:                                             ; preds = %1247, %1216
  %1218 = phi i64 [ %1248, %1247 ], [ 0, %1216 ]
  %1219 = icmp slt i64 %1218, 1024
  br i1 %1219, label %1220, label %1249

1220:                                             ; preds = %1217
  br label %1221

1221:                                             ; preds = %1224, %1220
  %1222 = phi i64 [ %1246, %1224 ], [ 0, %1220 ]
  %1223 = icmp slt i64 %1222, 384
  br i1 %1223, label %1224, label %1247

1224:                                             ; preds = %1221
  %1225 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1172, 1
  %1226 = mul nuw nsw i64 %1214, 393216
  %1227 = mul nuw nsw i64 %1218, 384
  %1228 = add nuw nsw i64 %1226, %1227
  %1229 = add nuw nsw i64 %1228, %1222
  %1230 = getelementptr inbounds float, ptr %1225, i64 %1229
  %1231 = load float, ptr %1230, align 4
  %1232 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %326, 1
  %1233 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %326, 2
  %1234 = getelementptr float, ptr %1232, i64 %1233
  %1235 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %326, 4, 0
  %1236 = mul nuw nsw i64 %1222, %1235
  %1237 = getelementptr inbounds float, ptr %1234, i64 %1236
  %1238 = load float, ptr %1237, align 4
  %1239 = fadd float %1231, %1238
  %1240 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1118, 1
  %1241 = mul nuw nsw i64 %1214, 393216
  %1242 = mul nuw nsw i64 %1218, 384
  %1243 = add nuw nsw i64 %1241, %1242
  %1244 = add nuw nsw i64 %1243, %1222
  %1245 = getelementptr inbounds float, ptr %1240, i64 %1244
  store float %1239, ptr %1245, align 4
  %1246 = add i64 %1222, 1
  br label %1221

1247:                                             ; preds = %1221
  %1248 = add i64 %1218, 1
  br label %1217

1249:                                             ; preds = %1217
  %1250 = add i64 %1214, 1
  br label %1213

1251:                                             ; preds = %1213
  %1252 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1118, 0
  %1253 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1118, 1
  %1254 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %1252, 0
  %1255 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1254, ptr %1253, 1
  %1256 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1255, i64 128, 2
  %1257 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1256, i64 2, 3, 0
  %1258 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1257, i64 393216, 4, 0
  %1259 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1258, i64 1024, 3, 1
  %1260 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1259, i64 384, 4, 1
  %1261 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1260, i64 4, 3, 2
  %1262 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1261, i64 32, 4, 2
  %1263 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1262, i64 32, 3, 3
  %1264 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1263, i64 1, 4, 3
  %1265 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1118, 0
  %1266 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1118, 1
  %1267 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %1265, 0
  %1268 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1267, ptr %1266, 1
  %1269 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1268, i64 0, 2
  %1270 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1269, i64 2, 3, 0
  %1271 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1270, i64 393216, 4, 0
  %1272 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1271, i64 1024, 3, 1
  %1273 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1272, i64 384, 4, 1
  %1274 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1273, i64 4, 3, 2
  %1275 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1274, i64 32, 4, 2
  %1276 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1275, i64 32, 3, 3
  %1277 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1276, i64 1, 4, 3
  %1278 = call ptr @malloc(i64 1048640)
  %1279 = ptrtoint ptr %1278 to i64
  %1280 = add i64 %1279, 63
  %1281 = urem i64 %1280, 64
  %1282 = sub i64 %1280, %1281
  %1283 = inttoptr i64 %1282 to ptr
  %1284 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %1278, 0
  %1285 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1284, ptr %1283, 1
  %1286 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1285, i64 0, 2
  %1287 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1286, i64 2, 3, 0
  %1288 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1287, i64 4, 3, 1
  %1289 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1288, i64 1024, 3, 2
  %1290 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1289, i64 32, 3, 3
  %1291 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1290, i64 131072, 4, 0
  %1292 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1291, i64 32768, 4, 1
  %1293 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1292, i64 32, 4, 2
  %1294 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1293, i64 1, 4, 3
  %1295 = call ptr @malloc(i64 1048640)
  %1296 = ptrtoint ptr %1295 to i64
  %1297 = add i64 %1296, 63
  %1298 = urem i64 %1297, 64
  %1299 = sub i64 %1297, %1298
  %1300 = inttoptr i64 %1299 to ptr
  %1301 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %1295, 0
  %1302 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1301, ptr %1300, 1
  %1303 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1302, i64 0, 2
  %1304 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1303, i64 2, 3, 0
  %1305 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1304, i64 4, 3, 1
  %1306 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1305, i64 1024, 3, 2
  %1307 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1306, i64 32, 3, 3
  %1308 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1307, i64 131072, 4, 0
  %1309 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1308, i64 32768, 4, 1
  %1310 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1309, i64 32, 4, 2
  %1311 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1310, i64 1, 4, 3
  br label %1312

1312:                                             ; preds = %1350, %1251
  %1313 = phi i64 [ %1351, %1350 ], [ 0, %1251 ]
  %1314 = icmp slt i64 %1313, 2
  br i1 %1314, label %1315, label %1352

1315:                                             ; preds = %1312
  br label %1316

1316:                                             ; preds = %1348, %1315
  %1317 = phi i64 [ %1349, %1348 ], [ 0, %1315 ]
  %1318 = icmp slt i64 %1317, 4
  br i1 %1318, label %1319, label %1350

1319:                                             ; preds = %1316
  br label %1320

1320:                                             ; preds = %1346, %1319
  %1321 = phi i64 [ %1347, %1346 ], [ 0, %1319 ]
  %1322 = icmp slt i64 %1321, 1024
  br i1 %1322, label %1323, label %1348

1323:                                             ; preds = %1320
  br label %1324

1324:                                             ; preds = %1327, %1323
  %1325 = phi i64 [ %1345, %1327 ], [ 0, %1323 ]
  %1326 = icmp slt i64 %1325, 32
  br i1 %1326, label %1327, label %1346

1327:                                             ; preds = %1324
  %1328 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1277, 1
  %1329 = mul nuw nsw i64 %1313, 393216
  %1330 = mul nuw nsw i64 %1321, 384
  %1331 = add nuw nsw i64 %1329, %1330
  %1332 = mul nuw nsw i64 %1317, 32
  %1333 = add nuw nsw i64 %1331, %1332
  %1334 = add nuw nsw i64 %1333, %1325
  %1335 = getelementptr inbounds float, ptr %1328, i64 %1334
  %1336 = load float, ptr %1335, align 4
  %1337 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1311, 1
  %1338 = mul nuw nsw i64 %1313, 131072
  %1339 = mul nuw nsw i64 %1317, 32768
  %1340 = add nuw nsw i64 %1338, %1339
  %1341 = mul nuw nsw i64 %1321, 32
  %1342 = add nuw nsw i64 %1340, %1341
  %1343 = add nuw nsw i64 %1342, %1325
  %1344 = getelementptr inbounds float, ptr %1337, i64 %1343
  store float %1336, ptr %1344, align 4
  %1345 = add i64 %1325, 1
  br label %1324

1346:                                             ; preds = %1324
  %1347 = add i64 %1321, 1
  br label %1320

1348:                                             ; preds = %1320
  %1349 = add i64 %1317, 1
  br label %1316

1350:                                             ; preds = %1316
  %1351 = add i64 %1313, 1
  br label %1312

1352:                                             ; preds = %1312
  %1353 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1118, 0
  %1354 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1118, 1
  %1355 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %1353, 0
  %1356 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1355, ptr %1354, 1
  %1357 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1356, i64 256, 2
  %1358 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1357, i64 2, 3, 0
  %1359 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1358, i64 393216, 4, 0
  %1360 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1359, i64 1024, 3, 1
  %1361 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1360, i64 384, 4, 1
  %1362 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1361, i64 4, 3, 2
  %1363 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1362, i64 32, 4, 2
  %1364 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1363, i64 32, 3, 3
  %1365 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1364, i64 1, 4, 3
  br label %1366

1366:                                             ; preds = %1405, %1352
  %1367 = phi i64 [ %1406, %1405 ], [ 0, %1352 ]
  %1368 = icmp slt i64 %1367, 2
  br i1 %1368, label %1369, label %1407

1369:                                             ; preds = %1366
  br label %1370

1370:                                             ; preds = %1403, %1369
  %1371 = phi i64 [ %1404, %1403 ], [ 0, %1369 ]
  %1372 = icmp slt i64 %1371, 4
  br i1 %1372, label %1373, label %1405

1373:                                             ; preds = %1370
  br label %1374

1374:                                             ; preds = %1401, %1373
  %1375 = phi i64 [ %1402, %1401 ], [ 0, %1373 ]
  %1376 = icmp slt i64 %1375, 1024
  br i1 %1376, label %1377, label %1403

1377:                                             ; preds = %1374
  br label %1378

1378:                                             ; preds = %1381, %1377
  %1379 = phi i64 [ %1400, %1381 ], [ 0, %1377 ]
  %1380 = icmp slt i64 %1379, 32
  br i1 %1380, label %1381, label %1401

1381:                                             ; preds = %1378
  %1382 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1365, 1
  %1383 = getelementptr float, ptr %1382, i64 256
  %1384 = mul nuw nsw i64 %1367, 393216
  %1385 = mul nuw nsw i64 %1375, 384
  %1386 = add nuw nsw i64 %1384, %1385
  %1387 = mul nuw nsw i64 %1371, 32
  %1388 = add nuw nsw i64 %1386, %1387
  %1389 = add nuw nsw i64 %1388, %1379
  %1390 = getelementptr inbounds float, ptr %1383, i64 %1389
  %1391 = load float, ptr %1390, align 4
  %1392 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1294, 1
  %1393 = mul nuw nsw i64 %1367, 131072
  %1394 = mul nuw nsw i64 %1371, 32768
  %1395 = add nuw nsw i64 %1393, %1394
  %1396 = mul nuw nsw i64 %1375, 32
  %1397 = add nuw nsw i64 %1395, %1396
  %1398 = add nuw nsw i64 %1397, %1379
  %1399 = getelementptr inbounds float, ptr %1392, i64 %1398
  store float %1391, ptr %1399, align 4
  %1400 = add i64 %1379, 1
  br label %1378

1401:                                             ; preds = %1378
  %1402 = add i64 %1375, 1
  br label %1374

1403:                                             ; preds = %1374
  %1404 = add i64 %1371, 1
  br label %1370

1405:                                             ; preds = %1370
  %1406 = add i64 %1367, 1
  br label %1366

1407:                                             ; preds = %1366
  %1408 = call ptr @malloc(i64 1048640)
  %1409 = ptrtoint ptr %1408 to i64
  %1410 = add i64 %1409, 63
  %1411 = urem i64 %1410, 64
  %1412 = sub i64 %1410, %1411
  %1413 = inttoptr i64 %1412 to ptr
  %1414 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %1408, 0
  %1415 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1414, ptr %1413, 1
  %1416 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1415, i64 0, 2
  %1417 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1416, i64 2, 3, 0
  %1418 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1417, i64 4, 3, 1
  %1419 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1418, i64 32, 3, 2
  %1420 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1419, i64 1024, 3, 3
  %1421 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1420, i64 131072, 4, 0
  %1422 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1421, i64 32768, 4, 1
  %1423 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1422, i64 1024, 4, 2
  %1424 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1423, i64 1, 4, 3
  br label %1425

1425:                                             ; preds = %1464, %1407
  %1426 = phi i64 [ %1465, %1464 ], [ 0, %1407 ]
  %1427 = icmp slt i64 %1426, 2
  br i1 %1427, label %1428, label %1466

1428:                                             ; preds = %1425
  br label %1429

1429:                                             ; preds = %1462, %1428
  %1430 = phi i64 [ %1463, %1462 ], [ 0, %1428 ]
  %1431 = icmp slt i64 %1430, 4
  br i1 %1431, label %1432, label %1464

1432:                                             ; preds = %1429
  br label %1433

1433:                                             ; preds = %1460, %1432
  %1434 = phi i64 [ %1461, %1460 ], [ 0, %1432 ]
  %1435 = icmp slt i64 %1434, 32
  br i1 %1435, label %1436, label %1462

1436:                                             ; preds = %1433
  br label %1437

1437:                                             ; preds = %1440, %1436
  %1438 = phi i64 [ %1459, %1440 ], [ 0, %1436 ]
  %1439 = icmp slt i64 %1438, 1024
  br i1 %1439, label %1440, label %1460

1440:                                             ; preds = %1437
  %1441 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1264, 1
  %1442 = getelementptr float, ptr %1441, i64 128
  %1443 = mul nuw nsw i64 %1426, 393216
  %1444 = mul nuw nsw i64 %1438, 384
  %1445 = add nuw nsw i64 %1443, %1444
  %1446 = mul nuw nsw i64 %1430, 32
  %1447 = add nuw nsw i64 %1445, %1446
  %1448 = add nuw nsw i64 %1447, %1434
  %1449 = getelementptr inbounds float, ptr %1442, i64 %1448
  %1450 = load float, ptr %1449, align 4
  %1451 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1424, 1
  %1452 = mul nuw nsw i64 %1426, 131072
  %1453 = mul nuw nsw i64 %1430, 32768
  %1454 = add nuw nsw i64 %1452, %1453
  %1455 = mul nuw nsw i64 %1434, 1024
  %1456 = add nuw nsw i64 %1454, %1455
  %1457 = add nuw nsw i64 %1456, %1438
  %1458 = getelementptr inbounds float, ptr %1451, i64 %1457
  store float %1450, ptr %1458, align 4
  %1459 = add i64 %1438, 1
  br label %1437

1460:                                             ; preds = %1437
  %1461 = add i64 %1434, 1
  br label %1433

1462:                                             ; preds = %1433
  %1463 = add i64 %1430, 1
  br label %1429

1464:                                             ; preds = %1429
  %1465 = add i64 %1426, 1
  br label %1425

1466:                                             ; preds = %1425
  %1467 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1311, 0
  %1468 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1311, 1
  %1469 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %1467, 0
  %1470 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1469, ptr %1468, 1
  %1471 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1470, i64 0, 2
  %1472 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1471, i64 8, 3, 0
  %1473 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1472, i64 32768, 4, 0
  %1474 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1473, i64 1024, 3, 1
  %1475 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1474, i64 32, 4, 1
  %1476 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1475, i64 32, 3, 2
  %1477 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1476, i64 1, 4, 2
  %1478 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1424, 0
  %1479 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1424, 1
  %1480 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %1478, 0
  %1481 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1480, ptr %1479, 1
  %1482 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1481, i64 0, 2
  %1483 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1482, i64 8, 3, 0
  %1484 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1483, i64 32768, 4, 0
  %1485 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1484, i64 32, 3, 1
  %1486 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1485, i64 1024, 4, 1
  %1487 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1486, i64 1024, 3, 2
  %1488 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1487, i64 1, 4, 2
  %1489 = call ptr @malloc(i64 33554496)
  %1490 = ptrtoint ptr %1489 to i64
  %1491 = add i64 %1490, 63
  %1492 = urem i64 %1491, 64
  %1493 = sub i64 %1491, %1492
  %1494 = inttoptr i64 %1493 to ptr
  %1495 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %1489, 0
  %1496 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1495, ptr %1494, 1
  %1497 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1496, i64 0, 2
  %1498 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1497, i64 8, 3, 0
  %1499 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1498, i64 1024, 3, 1
  %1500 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1499, i64 1024, 3, 2
  %1501 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1500, i64 1048576, 4, 0
  %1502 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1501, i64 1024, 4, 1
  %1503 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1502, i64 1, 4, 2
  br label %1504

1504:                                             ; preds = %1525, %1466
  %1505 = phi i64 [ %1526, %1525 ], [ 0, %1466 ]
  %1506 = icmp slt i64 %1505, 8
  br i1 %1506, label %1507, label %1527

1507:                                             ; preds = %1504
  br label %1508

1508:                                             ; preds = %1523, %1507
  %1509 = phi i64 [ %1524, %1523 ], [ 0, %1507 ]
  %1510 = icmp slt i64 %1509, 1024
  br i1 %1510, label %1511, label %1525

1511:                                             ; preds = %1508
  br label %1512

1512:                                             ; preds = %1515, %1511
  %1513 = phi i64 [ %1522, %1515 ], [ 0, %1511 ]
  %1514 = icmp slt i64 %1513, 1024
  br i1 %1514, label %1515, label %1523

1515:                                             ; preds = %1512
  %1516 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1503, 1
  %1517 = mul nuw nsw i64 %1505, 1048576
  %1518 = mul nuw nsw i64 %1509, 1024
  %1519 = add nuw nsw i64 %1517, %1518
  %1520 = add nuw nsw i64 %1519, %1513
  %1521 = getelementptr inbounds float, ptr %1516, i64 %1520
  store float 0.000000e+00, ptr %1521, align 4
  %1522 = add i64 %1513, 1
  br label %1512

1523:                                             ; preds = %1512
  %1524 = add i64 %1509, 1
  br label %1508

1525:                                             ; preds = %1508
  %1526 = add i64 %1505, 1
  br label %1504

1527:                                             ; preds = %1504
  %1528 = call ptr @malloc(i64 33554496)
  %1529 = ptrtoint ptr %1528 to i64
  %1530 = add i64 %1529, 63
  %1531 = urem i64 %1530, 64
  %1532 = sub i64 %1530, %1531
  %1533 = inttoptr i64 %1532 to ptr
  %1534 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %1528, 0
  %1535 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1534, ptr %1533, 1
  %1536 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1535, i64 0, 2
  %1537 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1536, i64 8, 3, 0
  %1538 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1537, i64 1024, 3, 1
  %1539 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1538, i64 1024, 3, 2
  %1540 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1539, i64 1048576, 4, 0
  %1541 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1540, i64 1024, 4, 1
  %1542 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1541, i64 1, 4, 2
  %1543 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1503, 3, 0
  %1544 = mul i64 1, %1543
  %1545 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1503, 3, 1
  %1546 = mul i64 %1544, %1545
  %1547 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1503, 3, 2
  %1548 = mul i64 %1546, %1547
  %1549 = mul i64 %1548, 4
  %1550 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1503, 1
  %1551 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1503, 2
  %1552 = getelementptr float, ptr %1550, i64 %1551
  %1553 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1542, 1
  %1554 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1542, 2
  %1555 = getelementptr float, ptr %1553, i64 %1554
  call void @llvm.memcpy.p0.p0.i64(ptr %1555, ptr %1552, i64 %1549, i1 false)
  %1556 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1477, 0
  %1557 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1477, 1
  %1558 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1477, 2
  %1559 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1477, 3, 0
  %1560 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1477, 3, 1
  %1561 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1477, 3, 2
  %1562 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1477, 4, 0
  %1563 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1477, 4, 1
  %1564 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1477, 4, 2
  %1565 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1488, 0
  %1566 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1488, 1
  %1567 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1488, 2
  %1568 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1488, 3, 0
  %1569 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1488, 3, 1
  %1570 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1488, 3, 2
  %1571 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1488, 4, 0
  %1572 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1488, 4, 1
  %1573 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1488, 4, 2
  %1574 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1542, 0
  %1575 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1542, 1
  %1576 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1542, 2
  %1577 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1542, 3, 0
  %1578 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1542, 3, 1
  %1579 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1542, 3, 2
  %1580 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1542, 4, 0
  %1581 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1542, 4, 1
  %1582 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1542, 4, 2
  call void @ukernel_bmm(ptr %1556, ptr %1557, i64 %1558, i64 %1559, i64 %1560, i64 %1561, i64 %1562, i64 %1563, i64 %1564, ptr %1565, ptr %1566, i64 %1567, i64 %1568, i64 %1569, i64 %1570, i64 %1571, i64 %1572, i64 %1573, ptr %1574, ptr %1575, i64 %1576, i64 %1577, i64 %1578, i64 %1579, i64 %1580, i64 %1581, i64 %1582)
  %1583 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1542, 0
  %1584 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1542, 1
  %1585 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %1583, 0
  %1586 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1585, ptr %1584, 1
  %1587 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1586, i64 0, 2
  %1588 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1587, i64 2, 3, 0
  %1589 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1588, i64 4194304, 4, 0
  %1590 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1589, i64 4, 3, 1
  %1591 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1590, i64 1048576, 4, 1
  %1592 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1591, i64 1024, 3, 2
  %1593 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1592, i64 1024, 4, 2
  %1594 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1593, i64 1024, 3, 3
  %1595 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1594, i64 1, 4, 3
  %1596 = call ptr @malloc(i64 33554496)
  %1597 = ptrtoint ptr %1596 to i64
  %1598 = add i64 %1597, 63
  %1599 = urem i64 %1598, 64
  %1600 = sub i64 %1598, %1599
  %1601 = inttoptr i64 %1600 to ptr
  %1602 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %1596, 0
  %1603 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1602, ptr %1601, 1
  %1604 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1603, i64 0, 2
  %1605 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1604, i64 2, 3, 0
  %1606 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1605, i64 4, 3, 1
  %1607 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1606, i64 1024, 3, 2
  %1608 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1607, i64 1024, 3, 3
  %1609 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1608, i64 4194304, 4, 0
  %1610 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1609, i64 1048576, 4, 1
  %1611 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1610, i64 1024, 4, 2
  %1612 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1611, i64 1, 4, 3
  br label %1613

1613:                                             ; preds = %1652, %1527
  %1614 = phi i64 [ %1653, %1652 ], [ 0, %1527 ]
  %1615 = icmp slt i64 %1614, 2
  br i1 %1615, label %1616, label %1654

1616:                                             ; preds = %1613
  br label %1617

1617:                                             ; preds = %1650, %1616
  %1618 = phi i64 [ %1651, %1650 ], [ 0, %1616 ]
  %1619 = icmp slt i64 %1618, 4
  br i1 %1619, label %1620, label %1652

1620:                                             ; preds = %1617
  br label %1621

1621:                                             ; preds = %1648, %1620
  %1622 = phi i64 [ %1649, %1648 ], [ 0, %1620 ]
  %1623 = icmp slt i64 %1622, 1024
  br i1 %1623, label %1624, label %1650

1624:                                             ; preds = %1621
  br label %1625

1625:                                             ; preds = %1628, %1624
  %1626 = phi i64 [ %1647, %1628 ], [ 0, %1624 ]
  %1627 = icmp slt i64 %1626, 1024
  br i1 %1627, label %1628, label %1648

1628:                                             ; preds = %1625
  %1629 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1595, 1
  %1630 = mul nuw nsw i64 %1614, 4194304
  %1631 = mul nuw nsw i64 %1618, 1048576
  %1632 = add nuw nsw i64 %1630, %1631
  %1633 = mul nuw nsw i64 %1622, 1024
  %1634 = add nuw nsw i64 %1632, %1633
  %1635 = add nuw nsw i64 %1634, %1626
  %1636 = getelementptr inbounds float, ptr %1629, i64 %1635
  %1637 = load float, ptr %1636, align 4
  %1638 = fmul float %1637, 0x3FC6A09E60000000
  %1639 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %1640 = mul nuw nsw i64 %1614, 4194304
  %1641 = mul nuw nsw i64 %1618, 1048576
  %1642 = add nuw nsw i64 %1640, %1641
  %1643 = mul nuw nsw i64 %1622, 1024
  %1644 = add nuw nsw i64 %1642, %1643
  %1645 = add nuw nsw i64 %1644, %1626
  %1646 = getelementptr inbounds float, ptr %1639, i64 %1645
  store float %1638, ptr %1646, align 4
  %1647 = add i64 %1626, 1
  br label %1625

1648:                                             ; preds = %1625
  %1649 = add i64 %1622, 1
  br label %1621

1650:                                             ; preds = %1621
  %1651 = add i64 %1618, 1
  br label %1617

1652:                                             ; preds = %1617
  %1653 = add i64 %1614, 1
  br label %1613

1654:                                             ; preds = %1613
  %1655 = call ptr @malloc(i64 1048640)
  %1656 = ptrtoint ptr %1655 to i64
  %1657 = add i64 %1656, 63
  %1658 = urem i64 %1657, 64
  %1659 = sub i64 %1657, %1658
  %1660 = inttoptr i64 %1659 to ptr
  %1661 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %1655, 0
  %1662 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1661, ptr %1660, 1
  %1663 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1662, i64 0, 2
  %1664 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1663, i64 1, 3, 0
  %1665 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1664, i64 1, 3, 1
  %1666 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1665, i64 1024, 3, 2
  %1667 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1666, i64 1024, 3, 3
  %1668 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1667, i64 1048576, 4, 0
  %1669 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1668, i64 1048576, 4, 1
  %1670 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1669, i64 1024, 4, 2
  %1671 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1670, i64 1, 4, 3
  br label %1672

1672:                                             ; preds = %1718, %1654
  %1673 = phi i64 [ %1719, %1718 ], [ 0, %1654 ]
  %1674 = icmp slt i64 %1673, 1
  br i1 %1674, label %1675, label %1720

1675:                                             ; preds = %1672
  br label %1676

1676:                                             ; preds = %1716, %1675
  %1677 = phi i64 [ %1717, %1716 ], [ 0, %1675 ]
  %1678 = icmp slt i64 %1677, 1
  br i1 %1678, label %1679, label %1718

1679:                                             ; preds = %1676
  br label %1680

1680:                                             ; preds = %1714, %1679
  %1681 = phi i64 [ %1715, %1714 ], [ 0, %1679 ]
  %1682 = icmp slt i64 %1681, 1024
  br i1 %1682, label %1683, label %1716

1683:                                             ; preds = %1680
  br label %1684

1684:                                             ; preds = %1687, %1683
  %1685 = phi i64 [ %1713, %1687 ], [ 0, %1683 ]
  %1686 = icmp slt i64 %1685, 1024
  br i1 %1686, label %1687, label %1714

1687:                                             ; preds = %1684
  %1688 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %321, 1
  %1689 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %321, 2
  %1690 = getelementptr float, ptr %1688, i64 %1689
  %1691 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %321, 4, 0
  %1692 = mul nuw nsw i64 %1673, %1691
  %1693 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %321, 4, 1
  %1694 = mul nuw nsw i64 %1677, %1693
  %1695 = add nuw nsw i64 %1692, %1694
  %1696 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %321, 4, 2
  %1697 = mul nuw nsw i64 %1681, %1696
  %1698 = add nuw nsw i64 %1695, %1697
  %1699 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %321, 4, 3
  %1700 = mul nuw nsw i64 %1685, %1699
  %1701 = add nuw nsw i64 %1698, %1700
  %1702 = getelementptr inbounds float, ptr %1690, i64 %1701
  %1703 = load float, ptr %1702, align 4
  %1704 = fcmp oeq float %1703, 0.000000e+00
  %1705 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1671, 1
  %1706 = mul nuw nsw i64 %1673, 1048576
  %1707 = mul nuw nsw i64 %1677, 1048576
  %1708 = add nuw nsw i64 %1706, %1707
  %1709 = mul nuw nsw i64 %1681, 1024
  %1710 = add nuw nsw i64 %1708, %1709
  %1711 = add nuw nsw i64 %1710, %1685
  %1712 = getelementptr inbounds i1, ptr %1705, i64 %1711
  store i1 %1704, ptr %1712, align 1
  %1713 = add i64 %1685, 1
  br label %1684

1714:                                             ; preds = %1684
  %1715 = add i64 %1681, 1
  br label %1680

1716:                                             ; preds = %1680
  %1717 = add i64 %1677, 1
  br label %1676

1718:                                             ; preds = %1676
  %1719 = add i64 %1673, 1
  br label %1672

1720:                                             ; preds = %1672
  br label %1721

1721:                                             ; preds = %1766, %1720
  %1722 = phi i64 [ %1767, %1766 ], [ 0, %1720 ]
  %1723 = icmp slt i64 %1722, 2
  br i1 %1723, label %1724, label %1768

1724:                                             ; preds = %1721
  br label %1725

1725:                                             ; preds = %1764, %1724
  %1726 = phi i64 [ %1765, %1764 ], [ 0, %1724 ]
  %1727 = icmp slt i64 %1726, 4
  br i1 %1727, label %1728, label %1766

1728:                                             ; preds = %1725
  br label %1729

1729:                                             ; preds = %1762, %1728
  %1730 = phi i64 [ %1763, %1762 ], [ 0, %1728 ]
  %1731 = icmp slt i64 %1730, 1024
  br i1 %1731, label %1732, label %1764

1732:                                             ; preds = %1729
  br label %1733

1733:                                             ; preds = %1736, %1732
  %1734 = phi i64 [ %1761, %1736 ], [ 0, %1732 ]
  %1735 = icmp slt i64 %1734, 1024
  br i1 %1735, label %1736, label %1762

1736:                                             ; preds = %1733
  %1737 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1671, 1
  %1738 = mul nuw nsw i64 %1730, 1024
  %1739 = add nuw nsw i64 0, %1738
  %1740 = add nuw nsw i64 %1739, %1734
  %1741 = getelementptr inbounds i1, ptr %1737, i64 %1740
  %1742 = load i1, ptr %1741, align 1
  %1743 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %1744 = mul nuw nsw i64 %1722, 4194304
  %1745 = mul nuw nsw i64 %1726, 1048576
  %1746 = add nuw nsw i64 %1744, %1745
  %1747 = mul nuw nsw i64 %1730, 1024
  %1748 = add nuw nsw i64 %1746, %1747
  %1749 = add nuw nsw i64 %1748, %1734
  %1750 = getelementptr inbounds float, ptr %1743, i64 %1749
  %1751 = load float, ptr %1750, align 4
  %1752 = select i1 %1742, float 0xFFF0000000000000, float %1751
  %1753 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %1754 = mul nuw nsw i64 %1722, 4194304
  %1755 = mul nuw nsw i64 %1726, 1048576
  %1756 = add nuw nsw i64 %1754, %1755
  %1757 = mul nuw nsw i64 %1730, 1024
  %1758 = add nuw nsw i64 %1756, %1757
  %1759 = add nuw nsw i64 %1758, %1734
  %1760 = getelementptr inbounds float, ptr %1753, i64 %1759
  store float %1752, ptr %1760, align 4
  %1761 = add i64 %1734, 1
  br label %1733

1762:                                             ; preds = %1733
  %1763 = add i64 %1730, 1
  br label %1729

1764:                                             ; preds = %1729
  %1765 = add i64 %1726, 1
  br label %1725

1766:                                             ; preds = %1725
  %1767 = add i64 %1722, 1
  br label %1721

1768:                                             ; preds = %1721
  %1769 = call ptr @malloc(i64 65600)
  %1770 = ptrtoint ptr %1769 to i64
  %1771 = add i64 %1770, 63
  %1772 = urem i64 %1771, 64
  %1773 = sub i64 %1771, %1772
  %1774 = inttoptr i64 %1773 to ptr
  %1775 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %1769, 0
  %1776 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1775, ptr %1774, 1
  %1777 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1776, i64 0, 2
  %1778 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1777, i64 2, 3, 0
  %1779 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1778, i64 4, 3, 1
  %1780 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1779, i64 1024, 3, 2
  %1781 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1780, i64 4096, 4, 0
  %1782 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1781, i64 1024, 4, 1
  %1783 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1782, i64 1, 4, 2
  br label %1784

1784:                                             ; preds = %1805, %1768
  %1785 = phi i64 [ %1806, %1805 ], [ 0, %1768 ]
  %1786 = icmp slt i64 %1785, 2
  br i1 %1786, label %1787, label %1807

1787:                                             ; preds = %1784
  br label %1788

1788:                                             ; preds = %1803, %1787
  %1789 = phi i64 [ %1804, %1803 ], [ 0, %1787 ]
  %1790 = icmp slt i64 %1789, 4
  br i1 %1790, label %1791, label %1805

1791:                                             ; preds = %1788
  br label %1792

1792:                                             ; preds = %1795, %1791
  %1793 = phi i64 [ %1802, %1795 ], [ 0, %1791 ]
  %1794 = icmp slt i64 %1793, 1024
  br i1 %1794, label %1795, label %1803

1795:                                             ; preds = %1792
  %1796 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1783, 1
  %1797 = mul nuw nsw i64 %1785, 4096
  %1798 = mul nuw nsw i64 %1789, 1024
  %1799 = add nuw nsw i64 %1797, %1798
  %1800 = add nuw nsw i64 %1799, %1793
  %1801 = getelementptr inbounds i64, ptr %1796, i64 %1800
  store i64 0, ptr %1801, align 4
  %1802 = add i64 %1793, 1
  br label %1792

1803:                                             ; preds = %1792
  %1804 = add i64 %1789, 1
  br label %1788

1805:                                             ; preds = %1788
  %1806 = add i64 %1785, 1
  br label %1784

1807:                                             ; preds = %1784
  %1808 = call ptr @malloc(i64 32832)
  %1809 = ptrtoint ptr %1808 to i64
  %1810 = add i64 %1809, 63
  %1811 = urem i64 %1810, 64
  %1812 = sub i64 %1810, %1811
  %1813 = inttoptr i64 %1812 to ptr
  %1814 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %1808, 0
  %1815 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1814, ptr %1813, 1
  %1816 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1815, i64 0, 2
  %1817 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1816, i64 2, 3, 0
  %1818 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1817, i64 4, 3, 1
  %1819 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1818, i64 1024, 3, 2
  %1820 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1819, i64 4096, 4, 0
  %1821 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1820, i64 1024, 4, 1
  %1822 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1821, i64 1, 4, 2
  br label %1823

1823:                                             ; preds = %1844, %1807
  %1824 = phi i64 [ %1845, %1844 ], [ 0, %1807 ]
  %1825 = icmp slt i64 %1824, 2
  br i1 %1825, label %1826, label %1846

1826:                                             ; preds = %1823
  br label %1827

1827:                                             ; preds = %1842, %1826
  %1828 = phi i64 [ %1843, %1842 ], [ 0, %1826 ]
  %1829 = icmp slt i64 %1828, 4
  br i1 %1829, label %1830, label %1844

1830:                                             ; preds = %1827
  br label %1831

1831:                                             ; preds = %1834, %1830
  %1832 = phi i64 [ %1841, %1834 ], [ 0, %1830 ]
  %1833 = icmp slt i64 %1832, 1024
  br i1 %1833, label %1834, label %1842

1834:                                             ; preds = %1831
  %1835 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1822, 1
  %1836 = mul nuw nsw i64 %1824, 4096
  %1837 = mul nuw nsw i64 %1828, 1024
  %1838 = add nuw nsw i64 %1836, %1837
  %1839 = add nuw nsw i64 %1838, %1832
  %1840 = getelementptr inbounds float, ptr %1835, i64 %1839
  store float 0xFFF0000000000000, ptr %1840, align 4
  %1841 = add i64 %1832, 1
  br label %1831

1842:                                             ; preds = %1831
  %1843 = add i64 %1828, 1
  br label %1827

1844:                                             ; preds = %1827
  %1845 = add i64 %1824, 1
  br label %1823

1846:                                             ; preds = %1823
  %1847 = call ptr @malloc(i64 32832)
  %1848 = ptrtoint ptr %1847 to i64
  %1849 = add i64 %1848, 63
  %1850 = urem i64 %1849, 64
  %1851 = sub i64 %1849, %1850
  %1852 = inttoptr i64 %1851 to ptr
  %1853 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %1847, 0
  %1854 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1853, ptr %1852, 1
  %1855 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1854, i64 0, 2
  %1856 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1855, i64 2, 3, 0
  %1857 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1856, i64 4, 3, 1
  %1858 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1857, i64 1024, 3, 2
  %1859 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1858, i64 4096, 4, 0
  %1860 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1859, i64 1024, 4, 1
  %1861 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1860, i64 1, 4, 2
  %1862 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1822, 3, 0
  %1863 = mul i64 1, %1862
  %1864 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1822, 3, 1
  %1865 = mul i64 %1863, %1864
  %1866 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1822, 3, 2
  %1867 = mul i64 %1865, %1866
  %1868 = mul i64 %1867, 4
  %1869 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1822, 1
  %1870 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1822, 2
  %1871 = getelementptr float, ptr %1869, i64 %1870
  %1872 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1861, 1
  %1873 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1861, 2
  %1874 = getelementptr float, ptr %1872, i64 %1873
  call void @llvm.memcpy.p0.p0.i64(ptr %1874, ptr %1871, i64 %1868, i1 false)
  %1875 = call ptr @malloc(i64 65600)
  %1876 = ptrtoint ptr %1875 to i64
  %1877 = add i64 %1876, 63
  %1878 = urem i64 %1877, 64
  %1879 = sub i64 %1877, %1878
  %1880 = inttoptr i64 %1879 to ptr
  %1881 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %1875, 0
  %1882 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1881, ptr %1880, 1
  %1883 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1882, i64 0, 2
  %1884 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1883, i64 2, 3, 0
  %1885 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1884, i64 4, 3, 1
  %1886 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1885, i64 1024, 3, 2
  %1887 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1886, i64 4096, 4, 0
  %1888 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1887, i64 1024, 4, 1
  %1889 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1888, i64 1, 4, 2
  %1890 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1783, 3, 0
  %1891 = mul i64 1, %1890
  %1892 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1783, 3, 1
  %1893 = mul i64 %1891, %1892
  %1894 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1783, 3, 2
  %1895 = mul i64 %1893, %1894
  %1896 = mul i64 %1895, 8
  %1897 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1783, 1
  %1898 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1783, 2
  %1899 = getelementptr i64, ptr %1897, i64 %1898
  %1900 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1889, 1
  %1901 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1889, 2
  %1902 = getelementptr i64, ptr %1900, i64 %1901
  call void @llvm.memcpy.p0.p0.i64(ptr %1902, ptr %1899, i64 %1896, i1 false)
  br label %1903

1903:                                             ; preds = %1962, %1846
  %1904 = phi i64 [ %1963, %1962 ], [ 0, %1846 ]
  %1905 = icmp slt i64 %1904, 2
  br i1 %1905, label %1906, label %1964

1906:                                             ; preds = %1903
  br label %1907

1907:                                             ; preds = %1960, %1906
  %1908 = phi i64 [ %1961, %1960 ], [ 0, %1906 ]
  %1909 = icmp slt i64 %1908, 4
  br i1 %1909, label %1910, label %1962

1910:                                             ; preds = %1907
  br label %1911

1911:                                             ; preds = %1958, %1910
  %1912 = phi i64 [ %1959, %1958 ], [ 0, %1910 ]
  %1913 = icmp slt i64 %1912, 1024
  br i1 %1913, label %1914, label %1960

1914:                                             ; preds = %1911
  br label %1915

1915:                                             ; preds = %1918, %1914
  %1916 = phi i64 [ %1957, %1918 ], [ 0, %1914 ]
  %1917 = icmp slt i64 %1916, 1024
  br i1 %1917, label %1918, label %1958

1918:                                             ; preds = %1915
  %1919 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %1920 = mul nuw nsw i64 %1904, 4194304
  %1921 = mul nuw nsw i64 %1908, 1048576
  %1922 = add nuw nsw i64 %1920, %1921
  %1923 = mul nuw nsw i64 %1912, 1024
  %1924 = add nuw nsw i64 %1922, %1923
  %1925 = add nuw nsw i64 %1924, %1916
  %1926 = getelementptr inbounds float, ptr %1919, i64 %1925
  %1927 = load float, ptr %1926, align 4
  %1928 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1861, 1
  %1929 = mul nuw nsw i64 %1904, 4096
  %1930 = mul nuw nsw i64 %1908, 1024
  %1931 = add nuw nsw i64 %1929, %1930
  %1932 = add nuw nsw i64 %1931, %1912
  %1933 = getelementptr inbounds float, ptr %1928, i64 %1932
  %1934 = load float, ptr %1933, align 4
  %1935 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1889, 1
  %1936 = mul nuw nsw i64 %1904, 4096
  %1937 = mul nuw nsw i64 %1908, 1024
  %1938 = add nuw nsw i64 %1936, %1937
  %1939 = add nuw nsw i64 %1938, %1912
  %1940 = getelementptr inbounds i64, ptr %1935, i64 %1939
  %1941 = load i64, ptr %1940, align 4
  %1942 = call float @llvm.maximum.f32(float %1927, float %1934)
  %1943 = fcmp ogt float %1927, %1934
  %1944 = select i1 %1943, i64 %1916, i64 %1941
  %1945 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1861, 1
  %1946 = mul nuw nsw i64 %1904, 4096
  %1947 = mul nuw nsw i64 %1908, 1024
  %1948 = add nuw nsw i64 %1946, %1947
  %1949 = add nuw nsw i64 %1948, %1912
  %1950 = getelementptr inbounds float, ptr %1945, i64 %1949
  store float %1942, ptr %1950, align 4
  %1951 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1889, 1
  %1952 = mul nuw nsw i64 %1904, 4096
  %1953 = mul nuw nsw i64 %1908, 1024
  %1954 = add nuw nsw i64 %1952, %1953
  %1955 = add nuw nsw i64 %1954, %1912
  %1956 = getelementptr inbounds i64, ptr %1951, i64 %1955
  store i64 %1944, ptr %1956, align 4
  %1957 = add i64 %1916, 1
  br label %1915

1958:                                             ; preds = %1915
  %1959 = add i64 %1912, 1
  br label %1911

1960:                                             ; preds = %1911
  %1961 = add i64 %1908, 1
  br label %1907

1962:                                             ; preds = %1907
  %1963 = add i64 %1904, 1
  br label %1903

1964:                                             ; preds = %1903
  %1965 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1861, 0
  %1966 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1861, 1
  %1967 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %1965, 0
  %1968 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1967, ptr %1966, 1
  %1969 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1968, i64 0, 2
  %1970 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1969, i64 2, 3, 0
  %1971 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1970, i64 4096, 4, 0
  %1972 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1971, i64 4, 3, 1
  %1973 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1972, i64 1024, 4, 1
  %1974 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1973, i64 1024, 3, 2
  %1975 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1974, i64 1, 4, 2
  %1976 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1975, i64 1, 3, 3
  %1977 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1976, i64 1, 4, 3
  br label %1978

1978:                                             ; preds = %2025, %1964
  %1979 = phi i64 [ %2026, %2025 ], [ 0, %1964 ]
  %1980 = icmp slt i64 %1979, 2
  br i1 %1980, label %1981, label %2027

1981:                                             ; preds = %1978
  br label %1982

1982:                                             ; preds = %2023, %1981
  %1983 = phi i64 [ %2024, %2023 ], [ 0, %1981 ]
  %1984 = icmp slt i64 %1983, 4
  br i1 %1984, label %1985, label %2025

1985:                                             ; preds = %1982
  br label %1986

1986:                                             ; preds = %2021, %1985
  %1987 = phi i64 [ %2022, %2021 ], [ 0, %1985 ]
  %1988 = icmp slt i64 %1987, 1024
  br i1 %1988, label %1989, label %2023

1989:                                             ; preds = %1986
  br label %1990

1990:                                             ; preds = %1993, %1989
  %1991 = phi i64 [ %2020, %1993 ], [ 0, %1989 ]
  %1992 = icmp slt i64 %1991, 1024
  br i1 %1992, label %1993, label %2021

1993:                                             ; preds = %1990
  %1994 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %1995 = mul nuw nsw i64 %1979, 4194304
  %1996 = mul nuw nsw i64 %1983, 1048576
  %1997 = add nuw nsw i64 %1995, %1996
  %1998 = mul nuw nsw i64 %1987, 1024
  %1999 = add nuw nsw i64 %1997, %1998
  %2000 = add nuw nsw i64 %1999, %1991
  %2001 = getelementptr inbounds float, ptr %1994, i64 %2000
  %2002 = load float, ptr %2001, align 4
  %2003 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1977, 1
  %2004 = mul nuw nsw i64 %1979, 4096
  %2005 = mul nuw nsw i64 %1983, 1024
  %2006 = add nuw nsw i64 %2004, %2005
  %2007 = add nuw nsw i64 %2006, %1987
  %2008 = add nuw nsw i64 %2007, 0
  %2009 = getelementptr inbounds float, ptr %2003, i64 %2008
  %2010 = load float, ptr %2009, align 4
  %2011 = fsub float %2002, %2010
  %2012 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %2013 = mul nuw nsw i64 %1979, 4194304
  %2014 = mul nuw nsw i64 %1983, 1048576
  %2015 = add nuw nsw i64 %2013, %2014
  %2016 = mul nuw nsw i64 %1987, 1024
  %2017 = add nuw nsw i64 %2015, %2016
  %2018 = add nuw nsw i64 %2017, %1991
  %2019 = getelementptr inbounds float, ptr %2012, i64 %2018
  store float %2011, ptr %2019, align 4
  %2020 = add i64 %1991, 1
  br label %1990

2021:                                             ; preds = %1990
  %2022 = add i64 %1987, 1
  br label %1986

2023:                                             ; preds = %1986
  %2024 = add i64 %1983, 1
  br label %1982

2025:                                             ; preds = %1982
  %2026 = add i64 %1979, 1
  br label %1978

2027:                                             ; preds = %1978
  br label %2028

2028:                                             ; preds = %2067, %2027
  %2029 = phi i64 [ %2068, %2067 ], [ 0, %2027 ]
  %2030 = icmp slt i64 %2029, 2
  br i1 %2030, label %2031, label %2069

2031:                                             ; preds = %2028
  br label %2032

2032:                                             ; preds = %2065, %2031
  %2033 = phi i64 [ %2066, %2065 ], [ 0, %2031 ]
  %2034 = icmp slt i64 %2033, 4
  br i1 %2034, label %2035, label %2067

2035:                                             ; preds = %2032
  br label %2036

2036:                                             ; preds = %2063, %2035
  %2037 = phi i64 [ %2064, %2063 ], [ 0, %2035 ]
  %2038 = icmp slt i64 %2037, 1024
  br i1 %2038, label %2039, label %2065

2039:                                             ; preds = %2036
  br label %2040

2040:                                             ; preds = %2043, %2039
  %2041 = phi i64 [ %2062, %2043 ], [ 0, %2039 ]
  %2042 = icmp slt i64 %2041, 1024
  br i1 %2042, label %2043, label %2063

2043:                                             ; preds = %2040
  %2044 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %2045 = mul nuw nsw i64 %2029, 4194304
  %2046 = mul nuw nsw i64 %2033, 1048576
  %2047 = add nuw nsw i64 %2045, %2046
  %2048 = mul nuw nsw i64 %2037, 1024
  %2049 = add nuw nsw i64 %2047, %2048
  %2050 = add nuw nsw i64 %2049, %2041
  %2051 = getelementptr inbounds float, ptr %2044, i64 %2050
  %2052 = load float, ptr %2051, align 4
  %2053 = call float @llvm.exp.f32(float %2052)
  %2054 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %2055 = mul nuw nsw i64 %2029, 4194304
  %2056 = mul nuw nsw i64 %2033, 1048576
  %2057 = add nuw nsw i64 %2055, %2056
  %2058 = mul nuw nsw i64 %2037, 1024
  %2059 = add nuw nsw i64 %2057, %2058
  %2060 = add nuw nsw i64 %2059, %2041
  %2061 = getelementptr inbounds float, ptr %2054, i64 %2060
  store float %2053, ptr %2061, align 4
  %2062 = add i64 %2041, 1
  br label %2040

2063:                                             ; preds = %2040
  %2064 = add i64 %2037, 1
  br label %2036

2065:                                             ; preds = %2036
  %2066 = add i64 %2033, 1
  br label %2032

2067:                                             ; preds = %2032
  %2068 = add i64 %2029, 1
  br label %2028

2069:                                             ; preds = %2028
  %2070 = call ptr @malloc(i64 32832)
  %2071 = ptrtoint ptr %2070 to i64
  %2072 = add i64 %2071, 63
  %2073 = urem i64 %2072, 64
  %2074 = sub i64 %2072, %2073
  %2075 = inttoptr i64 %2074 to ptr
  %2076 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %2070, 0
  %2077 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2076, ptr %2075, 1
  %2078 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2077, i64 0, 2
  %2079 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2078, i64 2, 3, 0
  %2080 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2079, i64 4, 3, 1
  %2081 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2080, i64 1024, 3, 2
  %2082 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2081, i64 1, 3, 3
  %2083 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2082, i64 4096, 4, 0
  %2084 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2083, i64 1024, 4, 1
  %2085 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2084, i64 1, 4, 2
  %2086 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2085, i64 1, 4, 3
  br label %2087

2087:                                             ; preds = %2115, %2069
  %2088 = phi i64 [ %2116, %2115 ], [ 0, %2069 ]
  %2089 = icmp slt i64 %2088, 2
  br i1 %2089, label %2090, label %2117

2090:                                             ; preds = %2087
  br label %2091

2091:                                             ; preds = %2113, %2090
  %2092 = phi i64 [ %2114, %2113 ], [ 0, %2090 ]
  %2093 = icmp slt i64 %2092, 4
  br i1 %2093, label %2094, label %2115

2094:                                             ; preds = %2091
  br label %2095

2095:                                             ; preds = %2111, %2094
  %2096 = phi i64 [ %2112, %2111 ], [ 0, %2094 ]
  %2097 = icmp slt i64 %2096, 1024
  br i1 %2097, label %2098, label %2113

2098:                                             ; preds = %2095
  br label %2099

2099:                                             ; preds = %2102, %2098
  %2100 = phi i64 [ %2110, %2102 ], [ 0, %2098 ]
  %2101 = icmp slt i64 %2100, 1
  br i1 %2101, label %2102, label %2111

2102:                                             ; preds = %2099
  %2103 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2086, 1
  %2104 = mul nuw nsw i64 %2088, 4096
  %2105 = mul nuw nsw i64 %2092, 1024
  %2106 = add nuw nsw i64 %2104, %2105
  %2107 = add nuw nsw i64 %2106, %2096
  %2108 = add nuw nsw i64 %2107, %2100
  %2109 = getelementptr inbounds float, ptr %2103, i64 %2108
  store float 0.000000e+00, ptr %2109, align 4
  %2110 = add i64 %2100, 1
  br label %2099

2111:                                             ; preds = %2099
  %2112 = add i64 %2096, 1
  br label %2095

2113:                                             ; preds = %2095
  %2114 = add i64 %2092, 1
  br label %2091

2115:                                             ; preds = %2091
  %2116 = add i64 %2088, 1
  br label %2087

2117:                                             ; preds = %2087
  %2118 = call ptr @malloc(i64 32832)
  %2119 = ptrtoint ptr %2118 to i64
  %2120 = add i64 %2119, 63
  %2121 = urem i64 %2120, 64
  %2122 = sub i64 %2120, %2121
  %2123 = inttoptr i64 %2122 to ptr
  %2124 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %2118, 0
  %2125 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2124, ptr %2123, 1
  %2126 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2125, i64 0, 2
  %2127 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2126, i64 2, 3, 0
  %2128 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2127, i64 4, 3, 1
  %2129 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2128, i64 1024, 3, 2
  %2130 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2129, i64 1, 3, 3
  %2131 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2130, i64 4096, 4, 0
  %2132 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2131, i64 1024, 4, 1
  %2133 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2132, i64 1, 4, 2
  %2134 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2133, i64 1, 4, 3
  %2135 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2086, 3, 0
  %2136 = mul i64 1, %2135
  %2137 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2086, 3, 1
  %2138 = mul i64 %2136, %2137
  %2139 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2086, 3, 2
  %2140 = mul i64 %2138, %2139
  %2141 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2086, 3, 3
  %2142 = mul i64 %2140, %2141
  %2143 = mul i64 %2142, 4
  %2144 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2086, 1
  %2145 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2086, 2
  %2146 = getelementptr float, ptr %2144, i64 %2145
  %2147 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2134, 1
  %2148 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2134, 2
  %2149 = getelementptr float, ptr %2147, i64 %2148
  call void @llvm.memcpy.p0.p0.i64(ptr %2149, ptr %2146, i64 %2143, i1 false)
  br label %2150

2150:                                             ; preds = %2196, %2117
  %2151 = phi i64 [ %2197, %2196 ], [ 0, %2117 ]
  %2152 = icmp slt i64 %2151, 2
  br i1 %2152, label %2153, label %2198

2153:                                             ; preds = %2150
  br label %2154

2154:                                             ; preds = %2194, %2153
  %2155 = phi i64 [ %2195, %2194 ], [ 0, %2153 ]
  %2156 = icmp slt i64 %2155, 4
  br i1 %2156, label %2157, label %2196

2157:                                             ; preds = %2154
  br label %2158

2158:                                             ; preds = %2192, %2157
  %2159 = phi i64 [ %2193, %2192 ], [ 0, %2157 ]
  %2160 = icmp slt i64 %2159, 1024
  br i1 %2160, label %2161, label %2194

2161:                                             ; preds = %2158
  br label %2162

2162:                                             ; preds = %2165, %2161
  %2163 = phi i64 [ %2191, %2165 ], [ 0, %2161 ]
  %2164 = icmp slt i64 %2163, 1024
  br i1 %2164, label %2165, label %2192

2165:                                             ; preds = %2162
  %2166 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %2167 = mul nuw nsw i64 %2151, 4194304
  %2168 = mul nuw nsw i64 %2155, 1048576
  %2169 = add nuw nsw i64 %2167, %2168
  %2170 = mul nuw nsw i64 %2159, 1024
  %2171 = add nuw nsw i64 %2169, %2170
  %2172 = add nuw nsw i64 %2171, %2163
  %2173 = getelementptr inbounds float, ptr %2166, i64 %2172
  %2174 = load float, ptr %2173, align 4
  %2175 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2134, 1
  %2176 = mul nuw nsw i64 %2151, 4096
  %2177 = mul nuw nsw i64 %2155, 1024
  %2178 = add nuw nsw i64 %2176, %2177
  %2179 = add nuw nsw i64 %2178, %2159
  %2180 = add nuw nsw i64 %2179, 0
  %2181 = getelementptr inbounds float, ptr %2175, i64 %2180
  %2182 = load float, ptr %2181, align 4
  %2183 = fadd float %2174, %2182
  %2184 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2134, 1
  %2185 = mul nuw nsw i64 %2151, 4096
  %2186 = mul nuw nsw i64 %2155, 1024
  %2187 = add nuw nsw i64 %2185, %2186
  %2188 = add nuw nsw i64 %2187, %2159
  %2189 = add nuw nsw i64 %2188, 0
  %2190 = getelementptr inbounds float, ptr %2184, i64 %2189
  store float %2183, ptr %2190, align 4
  %2191 = add i64 %2163, 1
  br label %2162

2192:                                             ; preds = %2162
  %2193 = add i64 %2159, 1
  br label %2158

2194:                                             ; preds = %2158
  %2195 = add i64 %2155, 1
  br label %2154

2196:                                             ; preds = %2154
  %2197 = add i64 %2151, 1
  br label %2150

2198:                                             ; preds = %2150
  br label %2199

2199:                                             ; preds = %2246, %2198
  %2200 = phi i64 [ %2247, %2246 ], [ 0, %2198 ]
  %2201 = icmp slt i64 %2200, 2
  br i1 %2201, label %2202, label %2248

2202:                                             ; preds = %2199
  br label %2203

2203:                                             ; preds = %2244, %2202
  %2204 = phi i64 [ %2245, %2244 ], [ 0, %2202 ]
  %2205 = icmp slt i64 %2204, 4
  br i1 %2205, label %2206, label %2246

2206:                                             ; preds = %2203
  br label %2207

2207:                                             ; preds = %2242, %2206
  %2208 = phi i64 [ %2243, %2242 ], [ 0, %2206 ]
  %2209 = icmp slt i64 %2208, 1024
  br i1 %2209, label %2210, label %2244

2210:                                             ; preds = %2207
  br label %2211

2211:                                             ; preds = %2214, %2210
  %2212 = phi i64 [ %2241, %2214 ], [ 0, %2210 ]
  %2213 = icmp slt i64 %2212, 1024
  br i1 %2213, label %2214, label %2242

2214:                                             ; preds = %2211
  %2215 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %2216 = mul nuw nsw i64 %2200, 4194304
  %2217 = mul nuw nsw i64 %2204, 1048576
  %2218 = add nuw nsw i64 %2216, %2217
  %2219 = mul nuw nsw i64 %2208, 1024
  %2220 = add nuw nsw i64 %2218, %2219
  %2221 = add nuw nsw i64 %2220, %2212
  %2222 = getelementptr inbounds float, ptr %2215, i64 %2221
  %2223 = load float, ptr %2222, align 4
  %2224 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2134, 1
  %2225 = mul nuw nsw i64 %2200, 4096
  %2226 = mul nuw nsw i64 %2204, 1024
  %2227 = add nuw nsw i64 %2225, %2226
  %2228 = add nuw nsw i64 %2227, %2208
  %2229 = add nuw nsw i64 %2228, 0
  %2230 = getelementptr inbounds float, ptr %2224, i64 %2229
  %2231 = load float, ptr %2230, align 4
  %2232 = fdiv float %2223, %2231
  %2233 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %2234 = mul nuw nsw i64 %2200, 4194304
  %2235 = mul nuw nsw i64 %2204, 1048576
  %2236 = add nuw nsw i64 %2234, %2235
  %2237 = mul nuw nsw i64 %2208, 1024
  %2238 = add nuw nsw i64 %2236, %2237
  %2239 = add nuw nsw i64 %2238, %2212
  %2240 = getelementptr inbounds float, ptr %2233, i64 %2239
  store float %2232, ptr %2240, align 4
  %2241 = add i64 %2212, 1
  br label %2211

2242:                                             ; preds = %2211
  %2243 = add i64 %2208, 1
  br label %2207

2244:                                             ; preds = %2207
  %2245 = add i64 %2204, 1
  br label %2203

2246:                                             ; preds = %2203
  %2247 = add i64 %2200, 1
  br label %2199

2248:                                             ; preds = %2199
  %2249 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 0
  %2250 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %2251 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %2249, 0
  %2252 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2251, ptr %2250, 1
  %2253 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2252, i64 0, 2
  %2254 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2253, i64 8, 3, 0
  %2255 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2254, i64 1048576, 4, 0
  %2256 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2255, i64 1024, 3, 1
  %2257 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2256, i64 1024, 4, 1
  %2258 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2257, i64 1024, 3, 2
  %2259 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2258, i64 1, 4, 2
  %2260 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1294, 0
  %2261 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1294, 1
  %2262 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %2260, 0
  %2263 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2262, ptr %2261, 1
  %2264 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2263, i64 0, 2
  %2265 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2264, i64 8, 3, 0
  %2266 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2265, i64 32768, 4, 0
  %2267 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2266, i64 1024, 3, 1
  %2268 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2267, i64 32, 4, 1
  %2269 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2268, i64 32, 3, 2
  %2270 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2269, i64 1, 4, 2
  %2271 = call ptr @malloc(i64 1048640)
  %2272 = ptrtoint ptr %2271 to i64
  %2273 = add i64 %2272, 63
  %2274 = urem i64 %2273, 64
  %2275 = sub i64 %2273, %2274
  %2276 = inttoptr i64 %2275 to ptr
  %2277 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %2271, 0
  %2278 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2277, ptr %2276, 1
  %2279 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2278, i64 0, 2
  %2280 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2279, i64 8, 3, 0
  %2281 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2280, i64 1024, 3, 1
  %2282 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2281, i64 32, 3, 2
  %2283 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2282, i64 32768, 4, 0
  %2284 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2283, i64 32, 4, 1
  %2285 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2284, i64 1, 4, 2
  br label %2286

2286:                                             ; preds = %2307, %2248
  %2287 = phi i64 [ %2308, %2307 ], [ 0, %2248 ]
  %2288 = icmp slt i64 %2287, 8
  br i1 %2288, label %2289, label %2309

2289:                                             ; preds = %2286
  br label %2290

2290:                                             ; preds = %2305, %2289
  %2291 = phi i64 [ %2306, %2305 ], [ 0, %2289 ]
  %2292 = icmp slt i64 %2291, 1024
  br i1 %2292, label %2293, label %2307

2293:                                             ; preds = %2290
  br label %2294

2294:                                             ; preds = %2297, %2293
  %2295 = phi i64 [ %2304, %2297 ], [ 0, %2293 ]
  %2296 = icmp slt i64 %2295, 32
  br i1 %2296, label %2297, label %2305

2297:                                             ; preds = %2294
  %2298 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2285, 1
  %2299 = mul nuw nsw i64 %2287, 32768
  %2300 = mul nuw nsw i64 %2291, 32
  %2301 = add nuw nsw i64 %2299, %2300
  %2302 = add nuw nsw i64 %2301, %2295
  %2303 = getelementptr inbounds float, ptr %2298, i64 %2302
  store float 0.000000e+00, ptr %2303, align 4
  %2304 = add i64 %2295, 1
  br label %2294

2305:                                             ; preds = %2294
  %2306 = add i64 %2291, 1
  br label %2290

2307:                                             ; preds = %2290
  %2308 = add i64 %2287, 1
  br label %2286

2309:                                             ; preds = %2286
  %2310 = call ptr @malloc(i64 1048640)
  %2311 = ptrtoint ptr %2310 to i64
  %2312 = add i64 %2311, 63
  %2313 = urem i64 %2312, 64
  %2314 = sub i64 %2312, %2313
  %2315 = inttoptr i64 %2314 to ptr
  %2316 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %2310, 0
  %2317 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2316, ptr %2315, 1
  %2318 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2317, i64 0, 2
  %2319 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2318, i64 8, 3, 0
  %2320 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2319, i64 1024, 3, 1
  %2321 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2320, i64 32, 3, 2
  %2322 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2321, i64 32768, 4, 0
  %2323 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2322, i64 32, 4, 1
  %2324 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2323, i64 1, 4, 2
  %2325 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2285, 3, 0
  %2326 = mul i64 1, %2325
  %2327 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2285, 3, 1
  %2328 = mul i64 %2326, %2327
  %2329 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2285, 3, 2
  %2330 = mul i64 %2328, %2329
  %2331 = mul i64 %2330, 4
  %2332 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2285, 1
  %2333 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2285, 2
  %2334 = getelementptr float, ptr %2332, i64 %2333
  %2335 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2324, 1
  %2336 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2324, 2
  %2337 = getelementptr float, ptr %2335, i64 %2336
  call void @llvm.memcpy.p0.p0.i64(ptr %2337, ptr %2334, i64 %2331, i1 false)
  %2338 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2259, 0
  %2339 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2259, 1
  %2340 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2259, 2
  %2341 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2259, 3, 0
  %2342 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2259, 3, 1
  %2343 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2259, 3, 2
  %2344 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2259, 4, 0
  %2345 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2259, 4, 1
  %2346 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2259, 4, 2
  %2347 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2270, 0
  %2348 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2270, 1
  %2349 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2270, 2
  %2350 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2270, 3, 0
  %2351 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2270, 3, 1
  %2352 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2270, 3, 2
  %2353 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2270, 4, 0
  %2354 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2270, 4, 1
  %2355 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2270, 4, 2
  %2356 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2324, 0
  %2357 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2324, 1
  %2358 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2324, 2
  %2359 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2324, 3, 0
  %2360 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2324, 3, 1
  %2361 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2324, 3, 2
  %2362 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2324, 4, 0
  %2363 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2324, 4, 1
  %2364 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2324, 4, 2
  call void @ukernel_bmm(ptr %2338, ptr %2339, i64 %2340, i64 %2341, i64 %2342, i64 %2343, i64 %2344, i64 %2345, i64 %2346, ptr %2347, ptr %2348, i64 %2349, i64 %2350, i64 %2351, i64 %2352, i64 %2353, i64 %2354, i64 %2355, ptr %2356, ptr %2357, i64 %2358, i64 %2359, i64 %2360, i64 %2361, i64 %2362, i64 %2363, i64 %2364)
  %2365 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2324, 0
  %2366 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2324, 1
  %2367 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %2365, 0
  %2368 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2367, ptr %2366, 1
  %2369 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2368, i64 0, 2
  %2370 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2369, i64 2, 3, 0
  %2371 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2370, i64 131072, 4, 0
  %2372 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2371, i64 4, 3, 1
  %2373 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2372, i64 32768, 4, 1
  %2374 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2373, i64 1024, 3, 2
  %2375 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2374, i64 32, 4, 2
  %2376 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2375, i64 32, 3, 3
  %2377 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2376, i64 1, 4, 3
  %2378 = call ptr @malloc(i64 1048640)
  %2379 = ptrtoint ptr %2378 to i64
  %2380 = add i64 %2379, 63
  %2381 = urem i64 %2380, 64
  %2382 = sub i64 %2380, %2381
  %2383 = inttoptr i64 %2382 to ptr
  %2384 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %2378, 0
  %2385 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2384, ptr %2383, 1
  %2386 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2385, i64 0, 2
  %2387 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2386, i64 2, 3, 0
  %2388 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2387, i64 1024, 3, 1
  %2389 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2388, i64 4, 3, 2
  %2390 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2389, i64 32, 3, 3
  %2391 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2390, i64 131072, 4, 0
  %2392 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2391, i64 128, 4, 1
  %2393 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2392, i64 32, 4, 2
  %2394 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2393, i64 1, 4, 3
  br label %2395

2395:                                             ; preds = %2433, %2309
  %2396 = phi i64 [ %2434, %2433 ], [ 0, %2309 ]
  %2397 = icmp slt i64 %2396, 2
  br i1 %2397, label %2398, label %2435

2398:                                             ; preds = %2395
  br label %2399

2399:                                             ; preds = %2431, %2398
  %2400 = phi i64 [ %2432, %2431 ], [ 0, %2398 ]
  %2401 = icmp slt i64 %2400, 1024
  br i1 %2401, label %2402, label %2433

2402:                                             ; preds = %2399
  br label %2403

2403:                                             ; preds = %2429, %2402
  %2404 = phi i64 [ %2430, %2429 ], [ 0, %2402 ]
  %2405 = icmp slt i64 %2404, 4
  br i1 %2405, label %2406, label %2431

2406:                                             ; preds = %2403
  br label %2407

2407:                                             ; preds = %2410, %2406
  %2408 = phi i64 [ %2428, %2410 ], [ 0, %2406 ]
  %2409 = icmp slt i64 %2408, 32
  br i1 %2409, label %2410, label %2429

2410:                                             ; preds = %2407
  %2411 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2377, 1
  %2412 = mul nuw nsw i64 %2396, 131072
  %2413 = mul nuw nsw i64 %2404, 32768
  %2414 = add nuw nsw i64 %2412, %2413
  %2415 = mul nuw nsw i64 %2400, 32
  %2416 = add nuw nsw i64 %2414, %2415
  %2417 = add nuw nsw i64 %2416, %2408
  %2418 = getelementptr inbounds float, ptr %2411, i64 %2417
  %2419 = load float, ptr %2418, align 4
  %2420 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2394, 1
  %2421 = mul nuw nsw i64 %2396, 131072
  %2422 = mul nuw nsw i64 %2400, 128
  %2423 = add nuw nsw i64 %2421, %2422
  %2424 = mul nuw nsw i64 %2404, 32
  %2425 = add nuw nsw i64 %2423, %2424
  %2426 = add nuw nsw i64 %2425, %2408
  %2427 = getelementptr inbounds float, ptr %2420, i64 %2426
  store float %2419, ptr %2427, align 4
  %2428 = add i64 %2408, 1
  br label %2407

2429:                                             ; preds = %2407
  %2430 = add i64 %2404, 1
  br label %2403

2431:                                             ; preds = %2403
  %2432 = add i64 %2400, 1
  br label %2399

2433:                                             ; preds = %2399
  %2434 = add i64 %2396, 1
  br label %2395

2435:                                             ; preds = %2395
  %2436 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2394, 0
  %2437 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2394, 1
  %2438 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %2436, 0
  %2439 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2438, ptr %2437, 1
  %2440 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2439, i64 0, 2
  %2441 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2440, i64 2, 3, 0
  %2442 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2441, i64 131072, 4, 0
  %2443 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2442, i64 1024, 3, 1
  %2444 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2443, i64 128, 4, 1
  %2445 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2444, i64 128, 3, 2
  %2446 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2445, i64 1, 4, 2
  %2447 = call ptr @malloc(i64 65600)
  %2448 = ptrtoint ptr %2447 to i64
  %2449 = add i64 %2448, 63
  %2450 = urem i64 %2449, 64
  %2451 = sub i64 %2449, %2450
  %2452 = inttoptr i64 %2451 to ptr
  %2453 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %2447, 0
  %2454 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2453, ptr %2452, 1
  %2455 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2454, i64 0, 2
  %2456 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2455, i64 128, 3, 0
  %2457 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2456, i64 128, 3, 1
  %2458 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2457, i64 128, 4, 0
  %2459 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2458, i64 1, 4, 1
  br label %2460

2460:                                             ; preds = %2483, %2435
  %2461 = phi i64 [ %2484, %2483 ], [ 0, %2435 ]
  %2462 = icmp slt i64 %2461, 128
  br i1 %2462, label %2463, label %2485

2463:                                             ; preds = %2460
  br label %2464

2464:                                             ; preds = %2467, %2463
  %2465 = phi i64 [ %2482, %2467 ], [ 0, %2463 ]
  %2466 = icmp slt i64 %2465, 128
  br i1 %2466, label %2467, label %2483

2467:                                             ; preds = %2464
  %2468 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %310, 1
  %2469 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %310, 2
  %2470 = getelementptr float, ptr %2468, i64 %2469
  %2471 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %310, 4, 0
  %2472 = mul nuw nsw i64 %2465, %2471
  %2473 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %310, 4, 1
  %2474 = mul nuw nsw i64 %2461, %2473
  %2475 = add nuw nsw i64 %2472, %2474
  %2476 = getelementptr inbounds float, ptr %2470, i64 %2475
  %2477 = load float, ptr %2476, align 4
  %2478 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2459, 1
  %2479 = mul nuw nsw i64 %2461, 128
  %2480 = add nuw nsw i64 %2479, %2465
  %2481 = getelementptr inbounds float, ptr %2478, i64 %2480
  store float %2477, ptr %2481, align 4
  %2482 = add i64 %2465, 1
  br label %2464

2483:                                             ; preds = %2464
  %2484 = add i64 %2461, 1
  br label %2460

2485:                                             ; preds = %2460
  %2486 = call ptr @malloc(i64 131136)
  %2487 = ptrtoint ptr %2486 to i64
  %2488 = add i64 %2487, 63
  %2489 = urem i64 %2488, 64
  %2490 = sub i64 %2488, %2489
  %2491 = inttoptr i64 %2490 to ptr
  %2492 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %2486, 0
  %2493 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2492, ptr %2491, 1
  %2494 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2493, i64 0, 2
  %2495 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2494, i64 2, 3, 0
  %2496 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2495, i64 128, 3, 1
  %2497 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2496, i64 128, 3, 2
  %2498 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2497, i64 16384, 4, 0
  %2499 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2498, i64 128, 4, 1
  %2500 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2499, i64 1, 4, 2
  br label %2501

2501:                                             ; preds = %2527, %2485
  %2502 = phi i64 [ %2528, %2527 ], [ 0, %2485 ]
  %2503 = icmp slt i64 %2502, 2
  br i1 %2503, label %2504, label %2529

2504:                                             ; preds = %2501
  br label %2505

2505:                                             ; preds = %2525, %2504
  %2506 = phi i64 [ %2526, %2525 ], [ 0, %2504 ]
  %2507 = icmp slt i64 %2506, 128
  br i1 %2507, label %2508, label %2527

2508:                                             ; preds = %2505
  br label %2509

2509:                                             ; preds = %2512, %2508
  %2510 = phi i64 [ %2524, %2512 ], [ 0, %2508 ]
  %2511 = icmp slt i64 %2510, 128
  br i1 %2511, label %2512, label %2525

2512:                                             ; preds = %2509
  %2513 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2459, 1
  %2514 = mul nuw nsw i64 %2506, 128
  %2515 = add nuw nsw i64 %2514, %2510
  %2516 = getelementptr inbounds float, ptr %2513, i64 %2515
  %2517 = load float, ptr %2516, align 4
  %2518 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 1
  %2519 = mul nuw nsw i64 %2502, 16384
  %2520 = mul nuw nsw i64 %2506, 128
  %2521 = add nuw nsw i64 %2519, %2520
  %2522 = add nuw nsw i64 %2521, %2510
  %2523 = getelementptr inbounds float, ptr %2518, i64 %2522
  store float %2517, ptr %2523, align 4
  %2524 = add i64 %2510, 1
  br label %2509

2525:                                             ; preds = %2509
  %2526 = add i64 %2506, 1
  br label %2505

2527:                                             ; preds = %2505
  %2528 = add i64 %2502, 1
  br label %2501

2529:                                             ; preds = %2501
  %2530 = call ptr @malloc(i64 1048640)
  %2531 = ptrtoint ptr %2530 to i64
  %2532 = add i64 %2531, 63
  %2533 = urem i64 %2532, 64
  %2534 = sub i64 %2532, %2533
  %2535 = inttoptr i64 %2534 to ptr
  %2536 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %2530, 0
  %2537 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2536, ptr %2535, 1
  %2538 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2537, i64 0, 2
  %2539 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2538, i64 2, 3, 0
  %2540 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2539, i64 1024, 3, 1
  %2541 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2540, i64 128, 3, 2
  %2542 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2541, i64 131072, 4, 0
  %2543 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2542, i64 128, 4, 1
  %2544 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2543, i64 1, 4, 2
  br label %2545

2545:                                             ; preds = %2566, %2529
  %2546 = phi i64 [ %2567, %2566 ], [ 0, %2529 ]
  %2547 = icmp slt i64 %2546, 2
  br i1 %2547, label %2548, label %2568

2548:                                             ; preds = %2545
  br label %2549

2549:                                             ; preds = %2564, %2548
  %2550 = phi i64 [ %2565, %2564 ], [ 0, %2548 ]
  %2551 = icmp slt i64 %2550, 1024
  br i1 %2551, label %2552, label %2566

2552:                                             ; preds = %2549
  br label %2553

2553:                                             ; preds = %2556, %2552
  %2554 = phi i64 [ %2563, %2556 ], [ 0, %2552 ]
  %2555 = icmp slt i64 %2554, 128
  br i1 %2555, label %2556, label %2564

2556:                                             ; preds = %2553
  %2557 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 1
  %2558 = mul nuw nsw i64 %2546, 131072
  %2559 = mul nuw nsw i64 %2550, 128
  %2560 = add nuw nsw i64 %2558, %2559
  %2561 = add nuw nsw i64 %2560, %2554
  %2562 = getelementptr inbounds float, ptr %2557, i64 %2561
  store float 0.000000e+00, ptr %2562, align 4
  %2563 = add i64 %2554, 1
  br label %2553

2564:                                             ; preds = %2553
  %2565 = add i64 %2550, 1
  br label %2549

2566:                                             ; preds = %2549
  %2567 = add i64 %2546, 1
  br label %2545

2568:                                             ; preds = %2545
  %2569 = call ptr @malloc(i64 1048640)
  %2570 = ptrtoint ptr %2569 to i64
  %2571 = add i64 %2570, 63
  %2572 = urem i64 %2571, 64
  %2573 = sub i64 %2571, %2572
  %2574 = inttoptr i64 %2573 to ptr
  %2575 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %2569, 0
  %2576 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2575, ptr %2574, 1
  %2577 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2576, i64 0, 2
  %2578 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2577, i64 2, 3, 0
  %2579 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2578, i64 1024, 3, 1
  %2580 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2579, i64 128, 3, 2
  %2581 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2580, i64 131072, 4, 0
  %2582 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2581, i64 128, 4, 1
  %2583 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2582, i64 1, 4, 2
  %2584 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 3, 0
  %2585 = mul i64 1, %2584
  %2586 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 3, 1
  %2587 = mul i64 %2585, %2586
  %2588 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 3, 2
  %2589 = mul i64 %2587, %2588
  %2590 = mul i64 %2589, 4
  %2591 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 1
  %2592 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 2
  %2593 = getelementptr float, ptr %2591, i64 %2592
  %2594 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2583, 1
  %2595 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2583, 2
  %2596 = getelementptr float, ptr %2594, i64 %2595
  call void @llvm.memcpy.p0.p0.i64(ptr %2596, ptr %2593, i64 %2590, i1 false)
  %2597 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2446, 0
  %2598 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2446, 1
  %2599 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2446, 2
  %2600 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2446, 3, 0
  %2601 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2446, 3, 1
  %2602 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2446, 3, 2
  %2603 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2446, 4, 0
  %2604 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2446, 4, 1
  %2605 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2446, 4, 2
  %2606 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 0
  %2607 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 1
  %2608 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 2
  %2609 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 3, 0
  %2610 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 3, 1
  %2611 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 3, 2
  %2612 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 4, 0
  %2613 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 4, 1
  %2614 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 4, 2
  %2615 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2583, 0
  %2616 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2583, 1
  %2617 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2583, 2
  %2618 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2583, 3, 0
  %2619 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2583, 3, 1
  %2620 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2583, 3, 2
  %2621 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2583, 4, 0
  %2622 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2583, 4, 1
  %2623 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2583, 4, 2
  call void @ukernel_bmm(ptr %2597, ptr %2598, i64 %2599, i64 %2600, i64 %2601, i64 %2602, i64 %2603, i64 %2604, i64 %2605, ptr %2606, ptr %2607, i64 %2608, i64 %2609, i64 %2610, i64 %2611, i64 %2612, i64 %2613, i64 %2614, ptr %2615, ptr %2616, i64 %2617, i64 %2618, i64 %2619, i64 %2620, i64 %2621, i64 %2622, i64 %2623)
  br label %2624

2624:                                             ; preds = %2666, %2568
  %2625 = phi i64 [ %2667, %2666 ], [ 0, %2568 ]
  %2626 = icmp slt i64 %2625, 2
  br i1 %2626, label %2627, label %2668

2627:                                             ; preds = %2624
  br label %2628

2628:                                             ; preds = %2664, %2627
  %2629 = phi i64 [ %2665, %2664 ], [ 0, %2627 ]
  %2630 = icmp slt i64 %2629, 1024
  br i1 %2630, label %2631, label %2666

2631:                                             ; preds = %2628
  br label %2632

2632:                                             ; preds = %2635, %2631
  %2633 = phi i64 [ %2663, %2635 ], [ 0, %2631 ]
  %2634 = icmp slt i64 %2633, 128
  br i1 %2634, label %2635, label %2664

2635:                                             ; preds = %2632
  %2636 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2583, 1
  %2637 = mul nuw nsw i64 %2625, 131072
  %2638 = mul nuw nsw i64 %2629, 128
  %2639 = add nuw nsw i64 %2637, %2638
  %2640 = add nuw nsw i64 %2639, %2633
  %2641 = getelementptr inbounds float, ptr %2636, i64 %2640
  %2642 = load float, ptr %2641, align 4
  %2643 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %303, 1
  %2644 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %303, 2
  %2645 = getelementptr float, ptr %2643, i64 %2644
  %2646 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %303, 4, 0
  %2647 = mul nuw nsw i64 %2633, %2646
  %2648 = getelementptr inbounds float, ptr %2645, i64 %2647
  %2649 = load float, ptr %2648, align 4
  %2650 = fadd float %2642, %2649
  %2651 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %2652 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %2653 = getelementptr float, ptr %2651, i64 %2652
  %2654 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %2655 = mul nuw nsw i64 %2625, %2654
  %2656 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %2657 = mul nuw nsw i64 %2629, %2656
  %2658 = add nuw nsw i64 %2655, %2657
  %2659 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %2660 = mul nuw nsw i64 %2633, %2659
  %2661 = add nuw nsw i64 %2658, %2660
  %2662 = getelementptr inbounds float, ptr %2653, i64 %2661
  store float %2650, ptr %2662, align 4
  %2663 = add i64 %2633, 1
  br label %2632

2664:                                             ; preds = %2632
  %2665 = add i64 %2629, 1
  br label %2628

2666:                                             ; preds = %2628
  %2667 = add i64 %2625, 1
  br label %2624

2668:                                             ; preds = %2624
  %2669 = call ptr @malloc(i64 1048640)
  %2670 = ptrtoint ptr %2669 to i64
  %2671 = add i64 %2670, 63
  %2672 = urem i64 %2671, 64
  %2673 = sub i64 %2671, %2672
  %2674 = inttoptr i64 %2673 to ptr
  %2675 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %2669, 0
  %2676 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2675, ptr %2674, 1
  %2677 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2676, i64 0, 2
  %2678 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2677, i64 2, 3, 0
  %2679 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2678, i64 1024, 3, 1
  %2680 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2679, i64 128, 3, 2
  %2681 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2680, i64 131072, 4, 0
  %2682 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2681, i64 128, 4, 1
  %2683 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2682, i64 1, 4, 2
  br label %2684

2684:                                             ; preds = %2732, %2668
  %2685 = phi i64 [ %2733, %2732 ], [ 0, %2668 ]
  %2686 = icmp slt i64 %2685, 2
  br i1 %2686, label %2687, label %2734

2687:                                             ; preds = %2684
  br label %2688

2688:                                             ; preds = %2730, %2687
  %2689 = phi i64 [ %2731, %2730 ], [ 0, %2687 ]
  %2690 = icmp slt i64 %2689, 1024
  br i1 %2690, label %2691, label %2732

2691:                                             ; preds = %2688
  br label %2692

2692:                                             ; preds = %2695, %2691
  %2693 = phi i64 [ %2729, %2695 ], [ 0, %2691 ]
  %2694 = icmp slt i64 %2693, 128
  br i1 %2694, label %2695, label %2730

2695:                                             ; preds = %2692
  %2696 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %342, 1
  %2697 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %342, 2
  %2698 = getelementptr float, ptr %2696, i64 %2697
  %2699 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %342, 4, 0
  %2700 = mul nuw nsw i64 %2685, %2699
  %2701 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %342, 4, 1
  %2702 = mul nuw nsw i64 %2689, %2701
  %2703 = add nuw nsw i64 %2700, %2702
  %2704 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %342, 4, 2
  %2705 = mul nuw nsw i64 %2693, %2704
  %2706 = add nuw nsw i64 %2703, %2705
  %2707 = getelementptr inbounds float, ptr %2698, i64 %2706
  %2708 = load float, ptr %2707, align 4
  %2709 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %2710 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %2711 = getelementptr float, ptr %2709, i64 %2710
  %2712 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %2713 = mul nuw nsw i64 %2685, %2712
  %2714 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %2715 = mul nuw nsw i64 %2689, %2714
  %2716 = add nuw nsw i64 %2713, %2715
  %2717 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %2718 = mul nuw nsw i64 %2693, %2717
  %2719 = add nuw nsw i64 %2716, %2718
  %2720 = getelementptr inbounds float, ptr %2711, i64 %2719
  %2721 = load float, ptr %2720, align 4
  %2722 = fadd float %2708, %2721
  %2723 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2683, 1
  %2724 = mul nuw nsw i64 %2685, 131072
  %2725 = mul nuw nsw i64 %2689, 128
  %2726 = add nuw nsw i64 %2724, %2725
  %2727 = add nuw nsw i64 %2726, %2693
  %2728 = getelementptr inbounds float, ptr %2723, i64 %2727
  store float %2722, ptr %2728, align 4
  %2729 = add i64 %2693, 1
  br label %2692

2730:                                             ; preds = %2692
  %2731 = add i64 %2689, 1
  br label %2688

2732:                                             ; preds = %2688
  %2733 = add i64 %2685, 1
  br label %2684

2734:                                             ; preds = %2684
  %2735 = call ptr @malloc(i64 8256)
  %2736 = ptrtoint ptr %2735 to i64
  %2737 = add i64 %2736, 63
  %2738 = urem i64 %2737, 64
  %2739 = sub i64 %2737, %2738
  %2740 = inttoptr i64 %2739 to ptr
  %2741 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %2735, 0
  %2742 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2741, ptr %2740, 1
  %2743 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2742, i64 0, 2
  %2744 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2743, i64 2, 3, 0
  %2745 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2744, i64 1024, 3, 1
  %2746 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2745, i64 1, 3, 2
  %2747 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2746, i64 1024, 4, 0
  %2748 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2747, i64 1, 4, 1
  %2749 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2748, i64 1, 4, 2
  %2750 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 0
  %2751 = mul i64 1, %2750
  %2752 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 1
  %2753 = mul i64 %2751, %2752
  %2754 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 2
  %2755 = mul i64 %2753, %2754
  %2756 = mul i64 %2755, 4
  %2757 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 1
  %2758 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 2
  %2759 = getelementptr float, ptr %2757, i64 %2758
  %2760 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2749, 1
  %2761 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2749, 2
  %2762 = getelementptr float, ptr %2760, i64 %2761
  call void @llvm.memcpy.p0.p0.i64(ptr %2762, ptr %2759, i64 %2756, i1 false)
  br label %2763

2763:                                             ; preds = %2797, %2734
  %2764 = phi i64 [ %2798, %2797 ], [ 0, %2734 ]
  %2765 = icmp slt i64 %2764, 2
  br i1 %2765, label %2766, label %2799

2766:                                             ; preds = %2763
  br label %2767

2767:                                             ; preds = %2795, %2766
  %2768 = phi i64 [ %2796, %2795 ], [ 0, %2766 ]
  %2769 = icmp slt i64 %2768, 1024
  br i1 %2769, label %2770, label %2797

2770:                                             ; preds = %2767
  br label %2771

2771:                                             ; preds = %2774, %2770
  %2772 = phi i64 [ %2794, %2774 ], [ 0, %2770 ]
  %2773 = icmp slt i64 %2772, 128
  br i1 %2773, label %2774, label %2795

2774:                                             ; preds = %2771
  %2775 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2683, 1
  %2776 = mul nuw nsw i64 %2764, 131072
  %2777 = mul nuw nsw i64 %2768, 128
  %2778 = add nuw nsw i64 %2776, %2777
  %2779 = add nuw nsw i64 %2778, %2772
  %2780 = getelementptr inbounds float, ptr %2775, i64 %2779
  %2781 = load float, ptr %2780, align 4
  %2782 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2749, 1
  %2783 = mul nuw nsw i64 %2764, 1024
  %2784 = add nuw nsw i64 %2783, %2768
  %2785 = add nuw nsw i64 %2784, 0
  %2786 = getelementptr inbounds float, ptr %2782, i64 %2785
  %2787 = load float, ptr %2786, align 4
  %2788 = fadd float %2781, %2787
  %2789 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2749, 1
  %2790 = mul nuw nsw i64 %2764, 1024
  %2791 = add nuw nsw i64 %2790, %2768
  %2792 = add nuw nsw i64 %2791, 0
  %2793 = getelementptr inbounds float, ptr %2789, i64 %2792
  store float %2788, ptr %2793, align 4
  %2794 = add i64 %2772, 1
  br label %2771

2795:                                             ; preds = %2771
  %2796 = add i64 %2768, 1
  br label %2767

2797:                                             ; preds = %2767
  %2798 = add i64 %2764, 1
  br label %2763

2799:                                             ; preds = %2763
  br label %2800

2800:                                             ; preds = %2827, %2799
  %2801 = phi i64 [ %2828, %2827 ], [ 0, %2799 ]
  %2802 = icmp slt i64 %2801, 2
  br i1 %2802, label %2803, label %2829

2803:                                             ; preds = %2800
  br label %2804

2804:                                             ; preds = %2825, %2803
  %2805 = phi i64 [ %2826, %2825 ], [ 0, %2803 ]
  %2806 = icmp slt i64 %2805, 1024
  br i1 %2806, label %2807, label %2827

2807:                                             ; preds = %2804
  br label %2808

2808:                                             ; preds = %2811, %2807
  %2809 = phi i64 [ %2824, %2811 ], [ 0, %2807 ]
  %2810 = icmp slt i64 %2809, 1
  br i1 %2810, label %2811, label %2825

2811:                                             ; preds = %2808
  %2812 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2749, 1
  %2813 = mul nuw nsw i64 %2801, 1024
  %2814 = add nuw nsw i64 %2813, %2805
  %2815 = add nuw nsw i64 %2814, %2809
  %2816 = getelementptr inbounds float, ptr %2812, i64 %2815
  %2817 = load float, ptr %2816, align 4
  %2818 = fdiv float %2817, 1.280000e+02
  %2819 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %2820 = mul nuw nsw i64 %2801, 1024
  %2821 = add nuw nsw i64 %2820, %2805
  %2822 = add nuw nsw i64 %2821, %2809
  %2823 = getelementptr inbounds float, ptr %2819, i64 %2822
  store float %2818, ptr %2823, align 4
  %2824 = add i64 %2809, 1
  br label %2808

2825:                                             ; preds = %2808
  %2826 = add i64 %2805, 1
  br label %2804

2827:                                             ; preds = %2804
  %2828 = add i64 %2801, 1
  br label %2800

2829:                                             ; preds = %2800
  %2830 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 0
  %2831 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %2832 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %2830, 0
  %2833 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2832, ptr %2831, 1
  %2834 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2833, i64 0, 2
  %2835 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2834, i64 2, 3, 0
  %2836 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2835, i64 1024, 4, 0
  %2837 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2836, i64 1024, 3, 1
  %2838 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2837, i64 1, 4, 1
  br label %2839

2839:                                             ; preds = %2871, %2829
  %2840 = phi i64 [ %2872, %2871 ], [ 0, %2829 ]
  %2841 = icmp slt i64 %2840, 2
  br i1 %2841, label %2842, label %2873

2842:                                             ; preds = %2839
  br label %2843

2843:                                             ; preds = %2869, %2842
  %2844 = phi i64 [ %2870, %2869 ], [ 0, %2842 ]
  %2845 = icmp slt i64 %2844, 1024
  br i1 %2845, label %2846, label %2871

2846:                                             ; preds = %2843
  br label %2847

2847:                                             ; preds = %2850, %2846
  %2848 = phi i64 [ %2868, %2850 ], [ 0, %2846 ]
  %2849 = icmp slt i64 %2848, 128
  br i1 %2849, label %2850, label %2869

2850:                                             ; preds = %2847
  %2851 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2838, 1
  %2852 = mul nuw nsw i64 %2840, 1024
  %2853 = add nuw nsw i64 %2852, %2844
  %2854 = getelementptr inbounds float, ptr %2851, i64 %2853
  %2855 = load float, ptr %2854, align 4
  %2856 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %2857 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %2858 = getelementptr float, ptr %2856, i64 %2857
  %2859 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %2860 = mul nuw nsw i64 %2840, %2859
  %2861 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %2862 = mul nuw nsw i64 %2844, %2861
  %2863 = add nuw nsw i64 %2860, %2862
  %2864 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %2865 = mul nuw nsw i64 %2848, %2864
  %2866 = add nuw nsw i64 %2863, %2865
  %2867 = getelementptr inbounds float, ptr %2858, i64 %2866
  store float %2855, ptr %2867, align 4
  %2868 = add i64 %2848, 1
  br label %2847

2869:                                             ; preds = %2847
  %2870 = add i64 %2844, 1
  br label %2843

2871:                                             ; preds = %2843
  %2872 = add i64 %2840, 1
  br label %2839

2873:                                             ; preds = %2839
  %2874 = call ptr @malloc(i64 1048640)
  %2875 = ptrtoint ptr %2874 to i64
  %2876 = add i64 %2875, 63
  %2877 = urem i64 %2876, 64
  %2878 = sub i64 %2876, %2877
  %2879 = inttoptr i64 %2878 to ptr
  %2880 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %2874, 0
  %2881 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2880, ptr %2879, 1
  %2882 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2881, i64 0, 2
  %2883 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2882, i64 2, 3, 0
  %2884 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2883, i64 1024, 3, 1
  %2885 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2884, i64 128, 3, 2
  %2886 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2885, i64 131072, 4, 0
  %2887 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2886, i64 128, 4, 1
  %2888 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2887, i64 1, 4, 2
  br label %2889

2889:                                             ; preds = %2931, %2873
  %2890 = phi i64 [ %2932, %2931 ], [ 0, %2873 ]
  %2891 = icmp slt i64 %2890, 2
  br i1 %2891, label %2892, label %2933

2892:                                             ; preds = %2889
  br label %2893

2893:                                             ; preds = %2929, %2892
  %2894 = phi i64 [ %2930, %2929 ], [ 0, %2892 ]
  %2895 = icmp slt i64 %2894, 1024
  br i1 %2895, label %2896, label %2931

2896:                                             ; preds = %2893
  br label %2897

2897:                                             ; preds = %2900, %2896
  %2898 = phi i64 [ %2928, %2900 ], [ 0, %2896 ]
  %2899 = icmp slt i64 %2898, 128
  br i1 %2899, label %2900, label %2929

2900:                                             ; preds = %2897
  %2901 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2683, 1
  %2902 = mul nuw nsw i64 %2890, 131072
  %2903 = mul nuw nsw i64 %2894, 128
  %2904 = add nuw nsw i64 %2902, %2903
  %2905 = add nuw nsw i64 %2904, %2898
  %2906 = getelementptr inbounds float, ptr %2901, i64 %2905
  %2907 = load float, ptr %2906, align 4
  %2908 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %2909 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %2910 = getelementptr float, ptr %2908, i64 %2909
  %2911 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %2912 = mul nuw nsw i64 %2890, %2911
  %2913 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %2914 = mul nuw nsw i64 %2894, %2913
  %2915 = add nuw nsw i64 %2912, %2914
  %2916 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %2917 = mul nuw nsw i64 %2898, %2916
  %2918 = add nuw nsw i64 %2915, %2917
  %2919 = getelementptr inbounds float, ptr %2910, i64 %2918
  %2920 = load float, ptr %2919, align 4
  %2921 = fsub float %2907, %2920
  %2922 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2888, 1
  %2923 = mul nuw nsw i64 %2890, 131072
  %2924 = mul nuw nsw i64 %2894, 128
  %2925 = add nuw nsw i64 %2923, %2924
  %2926 = add nuw nsw i64 %2925, %2898
  %2927 = getelementptr inbounds float, ptr %2922, i64 %2926
  store float %2921, ptr %2927, align 4
  %2928 = add i64 %2898, 1
  br label %2897

2929:                                             ; preds = %2897
  %2930 = add i64 %2894, 1
  br label %2893

2931:                                             ; preds = %2893
  %2932 = add i64 %2890, 1
  br label %2889

2933:                                             ; preds = %2889
  br label %2934

2934:                                             ; preds = %2976, %2933
  %2935 = phi i64 [ %2977, %2976 ], [ 0, %2933 ]
  %2936 = icmp slt i64 %2935, 2
  br i1 %2936, label %2937, label %2978

2937:                                             ; preds = %2934
  br label %2938

2938:                                             ; preds = %2974, %2937
  %2939 = phi i64 [ %2975, %2974 ], [ 0, %2937 ]
  %2940 = icmp slt i64 %2939, 1024
  br i1 %2940, label %2941, label %2976

2941:                                             ; preds = %2938
  br label %2942

2942:                                             ; preds = %2945, %2941
  %2943 = phi i64 [ %2973, %2945 ], [ 0, %2941 ]
  %2944 = icmp slt i64 %2943, 128
  br i1 %2944, label %2945, label %2974

2945:                                             ; preds = %2942
  %2946 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2888, 1
  %2947 = mul nuw nsw i64 %2935, 131072
  %2948 = mul nuw nsw i64 %2939, 128
  %2949 = add nuw nsw i64 %2947, %2948
  %2950 = add nuw nsw i64 %2949, %2943
  %2951 = getelementptr inbounds float, ptr %2946, i64 %2950
  %2952 = load float, ptr %2951, align 4
  %2953 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2888, 1
  %2954 = mul nuw nsw i64 %2935, 131072
  %2955 = mul nuw nsw i64 %2939, 128
  %2956 = add nuw nsw i64 %2954, %2955
  %2957 = add nuw nsw i64 %2956, %2943
  %2958 = getelementptr inbounds float, ptr %2953, i64 %2957
  %2959 = load float, ptr %2958, align 4
  %2960 = fmul float %2952, %2959
  %2961 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %2962 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %2963 = getelementptr float, ptr %2961, i64 %2962
  %2964 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %2965 = mul nuw nsw i64 %2935, %2964
  %2966 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %2967 = mul nuw nsw i64 %2939, %2966
  %2968 = add nuw nsw i64 %2965, %2967
  %2969 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %2970 = mul nuw nsw i64 %2943, %2969
  %2971 = add nuw nsw i64 %2968, %2970
  %2972 = getelementptr inbounds float, ptr %2963, i64 %2971
  store float %2960, ptr %2972, align 4
  %2973 = add i64 %2943, 1
  br label %2942

2974:                                             ; preds = %2942
  %2975 = add i64 %2939, 1
  br label %2938

2976:                                             ; preds = %2938
  %2977 = add i64 %2935, 1
  br label %2934

2978:                                             ; preds = %2934
  %2979 = call ptr @malloc(i64 8256)
  %2980 = ptrtoint ptr %2979 to i64
  %2981 = add i64 %2980, 63
  %2982 = urem i64 %2981, 64
  %2983 = sub i64 %2981, %2982
  %2984 = inttoptr i64 %2983 to ptr
  %2985 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %2979, 0
  %2986 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2985, ptr %2984, 1
  %2987 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2986, i64 0, 2
  %2988 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2987, i64 2, 3, 0
  %2989 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2988, i64 1024, 3, 1
  %2990 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2989, i64 1, 3, 2
  %2991 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2990, i64 1024, 4, 0
  %2992 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2991, i64 1, 4, 1
  %2993 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2992, i64 1, 4, 2
  %2994 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 0
  %2995 = mul i64 1, %2994
  %2996 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 1
  %2997 = mul i64 %2995, %2996
  %2998 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 2
  %2999 = mul i64 %2997, %2998
  %3000 = mul i64 %2999, 4
  %3001 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 1
  %3002 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 2
  %3003 = getelementptr float, ptr %3001, i64 %3002
  %3004 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2993, 1
  %3005 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2993, 2
  %3006 = getelementptr float, ptr %3004, i64 %3005
  call void @llvm.memcpy.p0.p0.i64(ptr %3006, ptr %3003, i64 %3000, i1 false)
  br label %3007

3007:                                             ; preds = %3047, %2978
  %3008 = phi i64 [ %3048, %3047 ], [ 0, %2978 ]
  %3009 = icmp slt i64 %3008, 2
  br i1 %3009, label %3010, label %3049

3010:                                             ; preds = %3007
  br label %3011

3011:                                             ; preds = %3045, %3010
  %3012 = phi i64 [ %3046, %3045 ], [ 0, %3010 ]
  %3013 = icmp slt i64 %3012, 1024
  br i1 %3013, label %3014, label %3047

3014:                                             ; preds = %3011
  br label %3015

3015:                                             ; preds = %3018, %3014
  %3016 = phi i64 [ %3044, %3018 ], [ 0, %3014 ]
  %3017 = icmp slt i64 %3016, 128
  br i1 %3017, label %3018, label %3045

3018:                                             ; preds = %3015
  %3019 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %3020 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %3021 = getelementptr float, ptr %3019, i64 %3020
  %3022 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %3023 = mul nuw nsw i64 %3008, %3022
  %3024 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %3025 = mul nuw nsw i64 %3012, %3024
  %3026 = add nuw nsw i64 %3023, %3025
  %3027 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %3028 = mul nuw nsw i64 %3016, %3027
  %3029 = add nuw nsw i64 %3026, %3028
  %3030 = getelementptr inbounds float, ptr %3021, i64 %3029
  %3031 = load float, ptr %3030, align 4
  %3032 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2993, 1
  %3033 = mul nuw nsw i64 %3008, 1024
  %3034 = add nuw nsw i64 %3033, %3012
  %3035 = add nuw nsw i64 %3034, 0
  %3036 = getelementptr inbounds float, ptr %3032, i64 %3035
  %3037 = load float, ptr %3036, align 4
  %3038 = fadd float %3031, %3037
  %3039 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2993, 1
  %3040 = mul nuw nsw i64 %3008, 1024
  %3041 = add nuw nsw i64 %3040, %3012
  %3042 = add nuw nsw i64 %3041, 0
  %3043 = getelementptr inbounds float, ptr %3039, i64 %3042
  store float %3038, ptr %3043, align 4
  %3044 = add i64 %3016, 1
  br label %3015

3045:                                             ; preds = %3015
  %3046 = add i64 %3012, 1
  br label %3011

3047:                                             ; preds = %3011
  %3048 = add i64 %3008, 1
  br label %3007

3049:                                             ; preds = %3007
  br label %3050

3050:                                             ; preds = %3077, %3049
  %3051 = phi i64 [ %3078, %3077 ], [ 0, %3049 ]
  %3052 = icmp slt i64 %3051, 2
  br i1 %3052, label %3053, label %3079

3053:                                             ; preds = %3050
  br label %3054

3054:                                             ; preds = %3075, %3053
  %3055 = phi i64 [ %3076, %3075 ], [ 0, %3053 ]
  %3056 = icmp slt i64 %3055, 1024
  br i1 %3056, label %3057, label %3077

3057:                                             ; preds = %3054
  br label %3058

3058:                                             ; preds = %3061, %3057
  %3059 = phi i64 [ %3074, %3061 ], [ 0, %3057 ]
  %3060 = icmp slt i64 %3059, 1
  br i1 %3060, label %3061, label %3075

3061:                                             ; preds = %3058
  %3062 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2993, 1
  %3063 = mul nuw nsw i64 %3051, 1024
  %3064 = add nuw nsw i64 %3063, %3055
  %3065 = add nuw nsw i64 %3064, %3059
  %3066 = getelementptr inbounds float, ptr %3062, i64 %3065
  %3067 = load float, ptr %3066, align 4
  %3068 = fdiv float %3067, 1.280000e+02
  %3069 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %3070 = mul nuw nsw i64 %3051, 1024
  %3071 = add nuw nsw i64 %3070, %3055
  %3072 = add nuw nsw i64 %3071, %3059
  %3073 = getelementptr inbounds float, ptr %3069, i64 %3072
  store float %3068, ptr %3073, align 4
  %3074 = add i64 %3059, 1
  br label %3058

3075:                                             ; preds = %3058
  %3076 = add i64 %3055, 1
  br label %3054

3077:                                             ; preds = %3054
  %3078 = add i64 %3051, 1
  br label %3050

3079:                                             ; preds = %3050
  br label %3080

3080:                                             ; preds = %3107, %3079
  %3081 = phi i64 [ %3108, %3107 ], [ 0, %3079 ]
  %3082 = icmp slt i64 %3081, 2
  br i1 %3082, label %3083, label %3109

3083:                                             ; preds = %3080
  br label %3084

3084:                                             ; preds = %3105, %3083
  %3085 = phi i64 [ %3106, %3105 ], [ 0, %3083 ]
  %3086 = icmp slt i64 %3085, 1024
  br i1 %3086, label %3087, label %3107

3087:                                             ; preds = %3084
  br label %3088

3088:                                             ; preds = %3091, %3087
  %3089 = phi i64 [ %3104, %3091 ], [ 0, %3087 ]
  %3090 = icmp slt i64 %3089, 1
  br i1 %3090, label %3091, label %3105

3091:                                             ; preds = %3088
  %3092 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %3093 = mul nuw nsw i64 %3081, 1024
  %3094 = add nuw nsw i64 %3093, %3085
  %3095 = add nuw nsw i64 %3094, %3089
  %3096 = getelementptr inbounds float, ptr %3092, i64 %3095
  %3097 = load float, ptr %3096, align 4
  %3098 = fadd float %3097, 0x3EE4F8B580000000
  %3099 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %3100 = mul nuw nsw i64 %3081, 1024
  %3101 = add nuw nsw i64 %3100, %3085
  %3102 = add nuw nsw i64 %3101, %3089
  %3103 = getelementptr inbounds float, ptr %3099, i64 %3102
  store float %3098, ptr %3103, align 4
  %3104 = add i64 %3089, 1
  br label %3088

3105:                                             ; preds = %3088
  %3106 = add i64 %3085, 1
  br label %3084

3107:                                             ; preds = %3084
  %3108 = add i64 %3081, 1
  br label %3080

3109:                                             ; preds = %3080
  br label %3110

3110:                                             ; preds = %3138, %3109
  %3111 = phi i64 [ %3139, %3138 ], [ 0, %3109 ]
  %3112 = icmp slt i64 %3111, 2
  br i1 %3112, label %3113, label %3140

3113:                                             ; preds = %3110
  br label %3114

3114:                                             ; preds = %3136, %3113
  %3115 = phi i64 [ %3137, %3136 ], [ 0, %3113 ]
  %3116 = icmp slt i64 %3115, 1024
  br i1 %3116, label %3117, label %3138

3117:                                             ; preds = %3114
  br label %3118

3118:                                             ; preds = %3121, %3117
  %3119 = phi i64 [ %3135, %3121 ], [ 0, %3117 ]
  %3120 = icmp slt i64 %3119, 1
  br i1 %3120, label %3121, label %3136

3121:                                             ; preds = %3118
  %3122 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %3123 = mul nuw nsw i64 %3111, 1024
  %3124 = add nuw nsw i64 %3123, %3115
  %3125 = add nuw nsw i64 %3124, %3119
  %3126 = getelementptr inbounds float, ptr %3122, i64 %3125
  %3127 = load float, ptr %3126, align 4
  %3128 = call float @llvm.sqrt.f32(float %3127)
  %3129 = fdiv float 1.000000e+00, %3128
  %3130 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %3131 = mul nuw nsw i64 %3111, 1024
  %3132 = add nuw nsw i64 %3131, %3115
  %3133 = add nuw nsw i64 %3132, %3119
  %3134 = getelementptr inbounds float, ptr %3130, i64 %3133
  store float %3129, ptr %3134, align 4
  %3135 = add i64 %3119, 1
  br label %3118

3136:                                             ; preds = %3118
  %3137 = add i64 %3115, 1
  br label %3114

3138:                                             ; preds = %3114
  %3139 = add i64 %3111, 1
  br label %3110

3140:                                             ; preds = %3110
  %3141 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 0
  %3142 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %3143 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %3141, 0
  %3144 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3143, ptr %3142, 1
  %3145 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3144, i64 0, 2
  %3146 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3145, i64 2, 3, 0
  %3147 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3146, i64 1024, 4, 0
  %3148 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3147, i64 1024, 3, 1
  %3149 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3148, i64 1, 4, 1
  br label %3150

3150:                                             ; preds = %3182, %3140
  %3151 = phi i64 [ %3183, %3182 ], [ 0, %3140 ]
  %3152 = icmp slt i64 %3151, 2
  br i1 %3152, label %3153, label %3184

3153:                                             ; preds = %3150
  br label %3154

3154:                                             ; preds = %3180, %3153
  %3155 = phi i64 [ %3181, %3180 ], [ 0, %3153 ]
  %3156 = icmp slt i64 %3155, 1024
  br i1 %3156, label %3157, label %3182

3157:                                             ; preds = %3154
  br label %3158

3158:                                             ; preds = %3161, %3157
  %3159 = phi i64 [ %3179, %3161 ], [ 0, %3157 ]
  %3160 = icmp slt i64 %3159, 128
  br i1 %3160, label %3161, label %3180

3161:                                             ; preds = %3158
  %3162 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3149, 1
  %3163 = mul nuw nsw i64 %3151, 1024
  %3164 = add nuw nsw i64 %3163, %3155
  %3165 = getelementptr inbounds float, ptr %3162, i64 %3164
  %3166 = load float, ptr %3165, align 4
  %3167 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %3168 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %3169 = getelementptr float, ptr %3167, i64 %3168
  %3170 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %3171 = mul nuw nsw i64 %3151, %3170
  %3172 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %3173 = mul nuw nsw i64 %3155, %3172
  %3174 = add nuw nsw i64 %3171, %3173
  %3175 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %3176 = mul nuw nsw i64 %3159, %3175
  %3177 = add nuw nsw i64 %3174, %3176
  %3178 = getelementptr inbounds float, ptr %3169, i64 %3177
  store float %3166, ptr %3178, align 4
  %3179 = add i64 %3159, 1
  br label %3158

3180:                                             ; preds = %3158
  %3181 = add i64 %3155, 1
  br label %3154

3182:                                             ; preds = %3154
  %3183 = add i64 %3151, 1
  br label %3150

3184:                                             ; preds = %3150
  br label %3185

3185:                                             ; preds = %3233, %3184
  %3186 = phi i64 [ %3234, %3233 ], [ 0, %3184 ]
  %3187 = icmp slt i64 %3186, 2
  br i1 %3187, label %3188, label %3235

3188:                                             ; preds = %3185
  br label %3189

3189:                                             ; preds = %3231, %3188
  %3190 = phi i64 [ %3232, %3231 ], [ 0, %3188 ]
  %3191 = icmp slt i64 %3190, 1024
  br i1 %3191, label %3192, label %3233

3192:                                             ; preds = %3189
  br label %3193

3193:                                             ; preds = %3196, %3192
  %3194 = phi i64 [ %3230, %3196 ], [ 0, %3192 ]
  %3195 = icmp slt i64 %3194, 128
  br i1 %3195, label %3196, label %3231

3196:                                             ; preds = %3193
  %3197 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2888, 1
  %3198 = mul nuw nsw i64 %3186, 131072
  %3199 = mul nuw nsw i64 %3190, 128
  %3200 = add nuw nsw i64 %3198, %3199
  %3201 = add nuw nsw i64 %3200, %3194
  %3202 = getelementptr inbounds float, ptr %3197, i64 %3201
  %3203 = load float, ptr %3202, align 4
  %3204 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %3205 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %3206 = getelementptr float, ptr %3204, i64 %3205
  %3207 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %3208 = mul nuw nsw i64 %3186, %3207
  %3209 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %3210 = mul nuw nsw i64 %3190, %3209
  %3211 = add nuw nsw i64 %3208, %3210
  %3212 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %3213 = mul nuw nsw i64 %3194, %3212
  %3214 = add nuw nsw i64 %3211, %3213
  %3215 = getelementptr inbounds float, ptr %3206, i64 %3214
  %3216 = load float, ptr %3215, align 4
  %3217 = fmul float %3203, %3216
  %3218 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %3219 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %3220 = getelementptr float, ptr %3218, i64 %3219
  %3221 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %3222 = mul nuw nsw i64 %3186, %3221
  %3223 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %3224 = mul nuw nsw i64 %3190, %3223
  %3225 = add nuw nsw i64 %3222, %3224
  %3226 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %3227 = mul nuw nsw i64 %3194, %3226
  %3228 = add nuw nsw i64 %3225, %3227
  %3229 = getelementptr inbounds float, ptr %3220, i64 %3228
  store float %3217, ptr %3229, align 4
  %3230 = add i64 %3194, 1
  br label %3193

3231:                                             ; preds = %3193
  %3232 = add i64 %3190, 1
  br label %3189

3233:                                             ; preds = %3189
  %3234 = add i64 %3186, 1
  br label %3185

3235:                                             ; preds = %3185
  br label %3236

3236:                                             ; preds = %3284, %3235
  %3237 = phi i64 [ %3285, %3284 ], [ 0, %3235 ]
  %3238 = icmp slt i64 %3237, 2
  br i1 %3238, label %3239, label %3286

3239:                                             ; preds = %3236
  br label %3240

3240:                                             ; preds = %3282, %3239
  %3241 = phi i64 [ %3283, %3282 ], [ 0, %3239 ]
  %3242 = icmp slt i64 %3241, 1024
  br i1 %3242, label %3243, label %3284

3243:                                             ; preds = %3240
  br label %3244

3244:                                             ; preds = %3247, %3243
  %3245 = phi i64 [ %3281, %3247 ], [ 0, %3243 ]
  %3246 = icmp slt i64 %3245, 128
  br i1 %3246, label %3247, label %3282

3247:                                             ; preds = %3244
  %3248 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %3249 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %3250 = getelementptr float, ptr %3248, i64 %3249
  %3251 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %3252 = mul nuw nsw i64 %3237, %3251
  %3253 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %3254 = mul nuw nsw i64 %3241, %3253
  %3255 = add nuw nsw i64 %3252, %3254
  %3256 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %3257 = mul nuw nsw i64 %3245, %3256
  %3258 = add nuw nsw i64 %3255, %3257
  %3259 = getelementptr inbounds float, ptr %3250, i64 %3258
  %3260 = load float, ptr %3259, align 4
  %3261 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %298, 1
  %3262 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %298, 2
  %3263 = getelementptr float, ptr %3261, i64 %3262
  %3264 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %298, 4, 0
  %3265 = mul nuw nsw i64 %3245, %3264
  %3266 = getelementptr inbounds float, ptr %3263, i64 %3265
  %3267 = load float, ptr %3266, align 4
  %3268 = fmul float %3260, %3267
  %3269 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %3270 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %3271 = getelementptr float, ptr %3269, i64 %3270
  %3272 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %3273 = mul nuw nsw i64 %3237, %3272
  %3274 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %3275 = mul nuw nsw i64 %3241, %3274
  %3276 = add nuw nsw i64 %3273, %3275
  %3277 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %3278 = mul nuw nsw i64 %3245, %3277
  %3279 = add nuw nsw i64 %3276, %3278
  %3280 = getelementptr inbounds float, ptr %3271, i64 %3279
  store float %3268, ptr %3280, align 4
  %3281 = add i64 %3245, 1
  br label %3244

3282:                                             ; preds = %3244
  %3283 = add i64 %3241, 1
  br label %3240

3284:                                             ; preds = %3240
  %3285 = add i64 %3237, 1
  br label %3236

3286:                                             ; preds = %3236
  br label %3287

3287:                                             ; preds = %3335, %3286
  %3288 = phi i64 [ %3336, %3335 ], [ 0, %3286 ]
  %3289 = icmp slt i64 %3288, 2
  br i1 %3289, label %3290, label %3337

3290:                                             ; preds = %3287
  br label %3291

3291:                                             ; preds = %3333, %3290
  %3292 = phi i64 [ %3334, %3333 ], [ 0, %3290 ]
  %3293 = icmp slt i64 %3292, 1024
  br i1 %3293, label %3294, label %3335

3294:                                             ; preds = %3291
  br label %3295

3295:                                             ; preds = %3298, %3294
  %3296 = phi i64 [ %3332, %3298 ], [ 0, %3294 ]
  %3297 = icmp slt i64 %3296, 128
  br i1 %3297, label %3298, label %3333

3298:                                             ; preds = %3295
  %3299 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %3300 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %3301 = getelementptr float, ptr %3299, i64 %3300
  %3302 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %3303 = mul nuw nsw i64 %3288, %3302
  %3304 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %3305 = mul nuw nsw i64 %3292, %3304
  %3306 = add nuw nsw i64 %3303, %3305
  %3307 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %3308 = mul nuw nsw i64 %3296, %3307
  %3309 = add nuw nsw i64 %3306, %3308
  %3310 = getelementptr inbounds float, ptr %3301, i64 %3309
  %3311 = load float, ptr %3310, align 4
  %3312 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %293, 1
  %3313 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %293, 2
  %3314 = getelementptr float, ptr %3312, i64 %3313
  %3315 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %293, 4, 0
  %3316 = mul nuw nsw i64 %3296, %3315
  %3317 = getelementptr inbounds float, ptr %3314, i64 %3316
  %3318 = load float, ptr %3317, align 4
  %3319 = fadd float %3311, %3318
  %3320 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %3321 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %3322 = getelementptr float, ptr %3320, i64 %3321
  %3323 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %3324 = mul nuw nsw i64 %3288, %3323
  %3325 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %3326 = mul nuw nsw i64 %3292, %3325
  %3327 = add nuw nsw i64 %3324, %3326
  %3328 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %3329 = mul nuw nsw i64 %3296, %3328
  %3330 = add nuw nsw i64 %3327, %3329
  %3331 = getelementptr inbounds float, ptr %3322, i64 %3330
  store float %3319, ptr %3331, align 4
  %3332 = add i64 %3296, 1
  br label %3295

3333:                                             ; preds = %3295
  %3334 = add i64 %3292, 1
  br label %3291

3335:                                             ; preds = %3291
  %3336 = add i64 %3288, 1
  br label %3287

3337:                                             ; preds = %3287
  %3338 = call ptr @malloc(i64 262208)
  %3339 = ptrtoint ptr %3338 to i64
  %3340 = add i64 %3339, 63
  %3341 = urem i64 %3340, 64
  %3342 = sub i64 %3340, %3341
  %3343 = inttoptr i64 %3342 to ptr
  %3344 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %3338, 0
  %3345 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3344, ptr %3343, 1
  %3346 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3345, i64 0, 2
  %3347 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3346, i64 128, 3, 0
  %3348 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3347, i64 512, 3, 1
  %3349 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3348, i64 512, 4, 0
  %3350 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3349, i64 1, 4, 1
  br label %3351

3351:                                             ; preds = %3374, %3337
  %3352 = phi i64 [ %3375, %3374 ], [ 0, %3337 ]
  %3353 = icmp slt i64 %3352, 128
  br i1 %3353, label %3354, label %3376

3354:                                             ; preds = %3351
  br label %3355

3355:                                             ; preds = %3358, %3354
  %3356 = phi i64 [ %3373, %3358 ], [ 0, %3354 ]
  %3357 = icmp slt i64 %3356, 512
  br i1 %3357, label %3358, label %3374

3358:                                             ; preds = %3355
  %3359 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %288, 1
  %3360 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %288, 2
  %3361 = getelementptr float, ptr %3359, i64 %3360
  %3362 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %288, 4, 0
  %3363 = mul nuw nsw i64 %3356, %3362
  %3364 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %288, 4, 1
  %3365 = mul nuw nsw i64 %3352, %3364
  %3366 = add nuw nsw i64 %3363, %3365
  %3367 = getelementptr inbounds float, ptr %3361, i64 %3366
  %3368 = load float, ptr %3367, align 4
  %3369 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3350, 1
  %3370 = mul nuw nsw i64 %3352, 512
  %3371 = add nuw nsw i64 %3370, %3356
  %3372 = getelementptr inbounds float, ptr %3369, i64 %3371
  store float %3368, ptr %3372, align 4
  %3373 = add i64 %3356, 1
  br label %3355

3374:                                             ; preds = %3355
  %3375 = add i64 %3352, 1
  br label %3351

3376:                                             ; preds = %3351
  %3377 = call ptr @malloc(i64 524352)
  %3378 = ptrtoint ptr %3377 to i64
  %3379 = add i64 %3378, 63
  %3380 = urem i64 %3379, 64
  %3381 = sub i64 %3379, %3380
  %3382 = inttoptr i64 %3381 to ptr
  %3383 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %3377, 0
  %3384 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3383, ptr %3382, 1
  %3385 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3384, i64 0, 2
  %3386 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3385, i64 2, 3, 0
  %3387 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3386, i64 128, 3, 1
  %3388 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3387, i64 512, 3, 2
  %3389 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3388, i64 65536, 4, 0
  %3390 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3389, i64 512, 4, 1
  %3391 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3390, i64 1, 4, 2
  br label %3392

3392:                                             ; preds = %3418, %3376
  %3393 = phi i64 [ %3419, %3418 ], [ 0, %3376 ]
  %3394 = icmp slt i64 %3393, 2
  br i1 %3394, label %3395, label %3420

3395:                                             ; preds = %3392
  br label %3396

3396:                                             ; preds = %3416, %3395
  %3397 = phi i64 [ %3417, %3416 ], [ 0, %3395 ]
  %3398 = icmp slt i64 %3397, 128
  br i1 %3398, label %3399, label %3418

3399:                                             ; preds = %3396
  br label %3400

3400:                                             ; preds = %3403, %3399
  %3401 = phi i64 [ %3415, %3403 ], [ 0, %3399 ]
  %3402 = icmp slt i64 %3401, 512
  br i1 %3402, label %3403, label %3416

3403:                                             ; preds = %3400
  %3404 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3350, 1
  %3405 = mul nuw nsw i64 %3397, 512
  %3406 = add nuw nsw i64 %3405, %3401
  %3407 = getelementptr inbounds float, ptr %3404, i64 %3406
  %3408 = load float, ptr %3407, align 4
  %3409 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 1
  %3410 = mul nuw nsw i64 %3393, 65536
  %3411 = mul nuw nsw i64 %3397, 512
  %3412 = add nuw nsw i64 %3410, %3411
  %3413 = add nuw nsw i64 %3412, %3401
  %3414 = getelementptr inbounds float, ptr %3409, i64 %3413
  store float %3408, ptr %3414, align 4
  %3415 = add i64 %3401, 1
  br label %3400

3416:                                             ; preds = %3400
  %3417 = add i64 %3397, 1
  br label %3396

3418:                                             ; preds = %3396
  %3419 = add i64 %3393, 1
  br label %3392

3420:                                             ; preds = %3392
  %3421 = call ptr @malloc(i64 4194368)
  %3422 = ptrtoint ptr %3421 to i64
  %3423 = add i64 %3422, 63
  %3424 = urem i64 %3423, 64
  %3425 = sub i64 %3423, %3424
  %3426 = inttoptr i64 %3425 to ptr
  %3427 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %3421, 0
  %3428 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3427, ptr %3426, 1
  %3429 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3428, i64 0, 2
  %3430 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3429, i64 2, 3, 0
  %3431 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3430, i64 1024, 3, 1
  %3432 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3431, i64 512, 3, 2
  %3433 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3432, i64 524288, 4, 0
  %3434 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3433, i64 512, 4, 1
  %3435 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3434, i64 1, 4, 2
  %3436 = call ptr @malloc(i64 4194368)
  %3437 = ptrtoint ptr %3436 to i64
  %3438 = add i64 %3437, 63
  %3439 = urem i64 %3438, 64
  %3440 = sub i64 %3438, %3439
  %3441 = inttoptr i64 %3440 to ptr
  %3442 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %3436, 0
  %3443 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3442, ptr %3441, 1
  %3444 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3443, i64 0, 2
  %3445 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3444, i64 2, 3, 0
  %3446 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3445, i64 1024, 3, 1
  %3447 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3446, i64 512, 3, 2
  %3448 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3447, i64 524288, 4, 0
  %3449 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3448, i64 512, 4, 1
  %3450 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3449, i64 1, 4, 2
  br label %3451

3451:                                             ; preds = %3472, %3420
  %3452 = phi i64 [ %3473, %3472 ], [ 0, %3420 ]
  %3453 = icmp slt i64 %3452, 2
  br i1 %3453, label %3454, label %3474

3454:                                             ; preds = %3451
  br label %3455

3455:                                             ; preds = %3470, %3454
  %3456 = phi i64 [ %3471, %3470 ], [ 0, %3454 ]
  %3457 = icmp slt i64 %3456, 1024
  br i1 %3457, label %3458, label %3472

3458:                                             ; preds = %3455
  br label %3459

3459:                                             ; preds = %3462, %3458
  %3460 = phi i64 [ %3469, %3462 ], [ 0, %3458 ]
  %3461 = icmp slt i64 %3460, 512
  br i1 %3461, label %3462, label %3470

3462:                                             ; preds = %3459
  %3463 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3450, 1
  %3464 = mul nuw nsw i64 %3452, 524288
  %3465 = mul nuw nsw i64 %3456, 512
  %3466 = add nuw nsw i64 %3464, %3465
  %3467 = add nuw nsw i64 %3466, %3460
  %3468 = getelementptr inbounds float, ptr %3463, i64 %3467
  store float 0.000000e+00, ptr %3468, align 4
  %3469 = add i64 %3460, 1
  br label %3459

3470:                                             ; preds = %3459
  %3471 = add i64 %3456, 1
  br label %3455

3472:                                             ; preds = %3455
  %3473 = add i64 %3452, 1
  br label %3451

3474:                                             ; preds = %3451
  %3475 = call ptr @malloc(i64 4194368)
  %3476 = ptrtoint ptr %3475 to i64
  %3477 = add i64 %3476, 63
  %3478 = urem i64 %3477, 64
  %3479 = sub i64 %3477, %3478
  %3480 = inttoptr i64 %3479 to ptr
  %3481 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %3475, 0
  %3482 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3481, ptr %3480, 1
  %3483 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3482, i64 0, 2
  %3484 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3483, i64 2, 3, 0
  %3485 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3484, i64 1024, 3, 1
  %3486 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3485, i64 512, 3, 2
  %3487 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3486, i64 524288, 4, 0
  %3488 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3487, i64 512, 4, 1
  %3489 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3488, i64 1, 4, 2
  %3490 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3450, 3, 0
  %3491 = mul i64 1, %3490
  %3492 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3450, 3, 1
  %3493 = mul i64 %3491, %3492
  %3494 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3450, 3, 2
  %3495 = mul i64 %3493, %3494
  %3496 = mul i64 %3495, 4
  %3497 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3450, 1
  %3498 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3450, 2
  %3499 = getelementptr float, ptr %3497, i64 %3498
  %3500 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3489, 1
  %3501 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3489, 2
  %3502 = getelementptr float, ptr %3500, i64 %3501
  call void @llvm.memcpy.p0.p0.i64(ptr %3502, ptr %3499, i64 %3496, i1 false)
  %3503 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 0
  %3504 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %3505 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %3506 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 3, 0
  %3507 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 3, 1
  %3508 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 3, 2
  %3509 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %3510 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %3511 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %3512 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 0
  %3513 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 1
  %3514 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 2
  %3515 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 3, 0
  %3516 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 3, 1
  %3517 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 3, 2
  %3518 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 4, 0
  %3519 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 4, 1
  %3520 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 4, 2
  %3521 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3489, 0
  %3522 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3489, 1
  %3523 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3489, 2
  %3524 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3489, 3, 0
  %3525 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3489, 3, 1
  %3526 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3489, 3, 2
  %3527 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3489, 4, 0
  %3528 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3489, 4, 1
  %3529 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3489, 4, 2
  call void @ukernel_bmm(ptr %3503, ptr %3504, i64 %3505, i64 %3506, i64 %3507, i64 %3508, i64 %3509, i64 %3510, i64 %3511, ptr %3512, ptr %3513, i64 %3514, i64 %3515, i64 %3516, i64 %3517, i64 %3518, i64 %3519, i64 %3520, ptr %3521, ptr %3522, i64 %3523, i64 %3524, i64 %3525, i64 %3526, i64 %3527, i64 %3528, i64 %3529)
  br label %3530

3530:                                             ; preds = %3566, %3474
  %3531 = phi i64 [ %3567, %3566 ], [ 0, %3474 ]
  %3532 = icmp slt i64 %3531, 2
  br i1 %3532, label %3533, label %3568

3533:                                             ; preds = %3530
  br label %3534

3534:                                             ; preds = %3564, %3533
  %3535 = phi i64 [ %3565, %3564 ], [ 0, %3533 ]
  %3536 = icmp slt i64 %3535, 1024
  br i1 %3536, label %3537, label %3566

3537:                                             ; preds = %3534
  br label %3538

3538:                                             ; preds = %3541, %3537
  %3539 = phi i64 [ %3563, %3541 ], [ 0, %3537 ]
  %3540 = icmp slt i64 %3539, 512
  br i1 %3540, label %3541, label %3564

3541:                                             ; preds = %3538
  %3542 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3489, 1
  %3543 = mul nuw nsw i64 %3531, 524288
  %3544 = mul nuw nsw i64 %3535, 512
  %3545 = add nuw nsw i64 %3543, %3544
  %3546 = add nuw nsw i64 %3545, %3539
  %3547 = getelementptr inbounds float, ptr %3542, i64 %3546
  %3548 = load float, ptr %3547, align 4
  %3549 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %281, 1
  %3550 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %281, 2
  %3551 = getelementptr float, ptr %3549, i64 %3550
  %3552 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %281, 4, 0
  %3553 = mul nuw nsw i64 %3539, %3552
  %3554 = getelementptr inbounds float, ptr %3551, i64 %3553
  %3555 = load float, ptr %3554, align 4
  %3556 = fadd float %3548, %3555
  %3557 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 1
  %3558 = mul nuw nsw i64 %3531, 524288
  %3559 = mul nuw nsw i64 %3535, 512
  %3560 = add nuw nsw i64 %3558, %3559
  %3561 = add nuw nsw i64 %3560, %3539
  %3562 = getelementptr inbounds float, ptr %3557, i64 %3561
  store float %3556, ptr %3562, align 4
  %3563 = add i64 %3539, 1
  br label %3538

3564:                                             ; preds = %3538
  %3565 = add i64 %3535, 1
  br label %3534

3566:                                             ; preds = %3534
  %3567 = add i64 %3531, 1
  br label %3530

3568:                                             ; preds = %3530
  br label %3569

3569:                                             ; preds = %3602, %3568
  %3570 = phi i64 [ %3603, %3602 ], [ 0, %3568 ]
  %3571 = icmp slt i64 %3570, 2
  br i1 %3571, label %3572, label %3604

3572:                                             ; preds = %3569
  br label %3573

3573:                                             ; preds = %3600, %3572
  %3574 = phi i64 [ %3601, %3600 ], [ 0, %3572 ]
  %3575 = icmp slt i64 %3574, 1024
  br i1 %3575, label %3576, label %3602

3576:                                             ; preds = %3573
  br label %3577

3577:                                             ; preds = %3580, %3576
  %3578 = phi i64 [ %3599, %3580 ], [ 0, %3576 ]
  %3579 = icmp slt i64 %3578, 512
  br i1 %3579, label %3580, label %3600

3580:                                             ; preds = %3577
  %3581 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 1
  %3582 = mul nuw nsw i64 %3570, 524288
  %3583 = mul nuw nsw i64 %3574, 512
  %3584 = add nuw nsw i64 %3582, %3583
  %3585 = add nuw nsw i64 %3584, %3578
  %3586 = getelementptr inbounds float, ptr %3581, i64 %3585
  %3587 = load float, ptr %3586, align 4
  %3588 = fdiv float %3587, 0x3FF6A09E60000000
  %3589 = call float @erff(float %3588)
  %3590 = fadd float %3589, 1.000000e+00
  %3591 = fmul float %3590, 5.000000e-01
  %3592 = fmul float %3587, %3591
  %3593 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 1
  %3594 = mul nuw nsw i64 %3570, 524288
  %3595 = mul nuw nsw i64 %3574, 512
  %3596 = add nuw nsw i64 %3594, %3595
  %3597 = add nuw nsw i64 %3596, %3578
  %3598 = getelementptr inbounds float, ptr %3593, i64 %3597
  store float %3592, ptr %3598, align 4
  %3599 = add i64 %3578, 1
  br label %3577

3600:                                             ; preds = %3577
  %3601 = add i64 %3574, 1
  br label %3573

3602:                                             ; preds = %3573
  %3603 = add i64 %3570, 1
  br label %3569

3604:                                             ; preds = %3569
  %3605 = call ptr @malloc(i64 262208)
  %3606 = ptrtoint ptr %3605 to i64
  %3607 = add i64 %3606, 63
  %3608 = urem i64 %3607, 64
  %3609 = sub i64 %3607, %3608
  %3610 = inttoptr i64 %3609 to ptr
  %3611 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %3605, 0
  %3612 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3611, ptr %3610, 1
  %3613 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3612, i64 0, 2
  %3614 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3613, i64 512, 3, 0
  %3615 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3614, i64 128, 3, 1
  %3616 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3615, i64 128, 4, 0
  %3617 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3616, i64 1, 4, 1
  br label %3618

3618:                                             ; preds = %3641, %3604
  %3619 = phi i64 [ %3642, %3641 ], [ 0, %3604 ]
  %3620 = icmp slt i64 %3619, 512
  br i1 %3620, label %3621, label %3643

3621:                                             ; preds = %3618
  br label %3622

3622:                                             ; preds = %3625, %3621
  %3623 = phi i64 [ %3640, %3625 ], [ 0, %3621 ]
  %3624 = icmp slt i64 %3623, 128
  br i1 %3624, label %3625, label %3641

3625:                                             ; preds = %3622
  %3626 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %276, 1
  %3627 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %276, 2
  %3628 = getelementptr float, ptr %3626, i64 %3627
  %3629 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %276, 4, 0
  %3630 = mul nuw nsw i64 %3623, %3629
  %3631 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %276, 4, 1
  %3632 = mul nuw nsw i64 %3619, %3631
  %3633 = add nuw nsw i64 %3630, %3632
  %3634 = getelementptr inbounds float, ptr %3628, i64 %3633
  %3635 = load float, ptr %3634, align 4
  %3636 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3617, 1
  %3637 = mul nuw nsw i64 %3619, 128
  %3638 = add nuw nsw i64 %3637, %3623
  %3639 = getelementptr inbounds float, ptr %3636, i64 %3638
  store float %3635, ptr %3639, align 4
  %3640 = add i64 %3623, 1
  br label %3622

3641:                                             ; preds = %3622
  %3642 = add i64 %3619, 1
  br label %3618

3643:                                             ; preds = %3618
  %3644 = call ptr @malloc(i64 524352)
  %3645 = ptrtoint ptr %3644 to i64
  %3646 = add i64 %3645, 63
  %3647 = urem i64 %3646, 64
  %3648 = sub i64 %3646, %3647
  %3649 = inttoptr i64 %3648 to ptr
  %3650 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %3644, 0
  %3651 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3650, ptr %3649, 1
  %3652 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3651, i64 0, 2
  %3653 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3652, i64 2, 3, 0
  %3654 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3653, i64 512, 3, 1
  %3655 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3654, i64 128, 3, 2
  %3656 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3655, i64 65536, 4, 0
  %3657 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3656, i64 128, 4, 1
  %3658 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3657, i64 1, 4, 2
  br label %3659

3659:                                             ; preds = %3685, %3643
  %3660 = phi i64 [ %3686, %3685 ], [ 0, %3643 ]
  %3661 = icmp slt i64 %3660, 2
  br i1 %3661, label %3662, label %3687

3662:                                             ; preds = %3659
  br label %3663

3663:                                             ; preds = %3683, %3662
  %3664 = phi i64 [ %3684, %3683 ], [ 0, %3662 ]
  %3665 = icmp slt i64 %3664, 512
  br i1 %3665, label %3666, label %3685

3666:                                             ; preds = %3663
  br label %3667

3667:                                             ; preds = %3670, %3666
  %3668 = phi i64 [ %3682, %3670 ], [ 0, %3666 ]
  %3669 = icmp slt i64 %3668, 128
  br i1 %3669, label %3670, label %3683

3670:                                             ; preds = %3667
  %3671 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3617, 1
  %3672 = mul nuw nsw i64 %3664, 128
  %3673 = add nuw nsw i64 %3672, %3668
  %3674 = getelementptr inbounds float, ptr %3671, i64 %3673
  %3675 = load float, ptr %3674, align 4
  %3676 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 1
  %3677 = mul nuw nsw i64 %3660, 65536
  %3678 = mul nuw nsw i64 %3664, 128
  %3679 = add nuw nsw i64 %3677, %3678
  %3680 = add nuw nsw i64 %3679, %3668
  %3681 = getelementptr inbounds float, ptr %3676, i64 %3680
  store float %3675, ptr %3681, align 4
  %3682 = add i64 %3668, 1
  br label %3667

3683:                                             ; preds = %3667
  %3684 = add i64 %3664, 1
  br label %3663

3685:                                             ; preds = %3663
  %3686 = add i64 %3660, 1
  br label %3659

3687:                                             ; preds = %3659
  %3688 = call ptr @malloc(i64 1048640)
  %3689 = ptrtoint ptr %3688 to i64
  %3690 = add i64 %3689, 63
  %3691 = urem i64 %3690, 64
  %3692 = sub i64 %3690, %3691
  %3693 = inttoptr i64 %3692 to ptr
  %3694 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %3688, 0
  %3695 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3694, ptr %3693, 1
  %3696 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3695, i64 0, 2
  %3697 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3696, i64 2, 3, 0
  %3698 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3697, i64 1024, 3, 1
  %3699 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3698, i64 128, 3, 2
  %3700 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3699, i64 131072, 4, 0
  %3701 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3700, i64 128, 4, 1
  %3702 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3701, i64 1, 4, 2
  %3703 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 3, 0
  %3704 = mul i64 1, %3703
  %3705 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 3, 1
  %3706 = mul i64 %3704, %3705
  %3707 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 3, 2
  %3708 = mul i64 %3706, %3707
  %3709 = mul i64 %3708, 4
  %3710 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 1
  %3711 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 2
  %3712 = getelementptr float, ptr %3710, i64 %3711
  %3713 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3702, 1
  %3714 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3702, 2
  %3715 = getelementptr float, ptr %3713, i64 %3714
  call void @llvm.memcpy.p0.p0.i64(ptr %3715, ptr %3712, i64 %3709, i1 false)
  %3716 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 0
  %3717 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 1
  %3718 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 2
  %3719 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 3, 0
  %3720 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 3, 1
  %3721 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 3, 2
  %3722 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 4, 0
  %3723 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 4, 1
  %3724 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 4, 2
  %3725 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 0
  %3726 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 1
  %3727 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 2
  %3728 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 3, 0
  %3729 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 3, 1
  %3730 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 3, 2
  %3731 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 4, 0
  %3732 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 4, 1
  %3733 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 4, 2
  %3734 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3702, 0
  %3735 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3702, 1
  %3736 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3702, 2
  %3737 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3702, 3, 0
  %3738 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3702, 3, 1
  %3739 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3702, 3, 2
  %3740 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3702, 4, 0
  %3741 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3702, 4, 1
  %3742 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3702, 4, 2
  call void @ukernel_bmm(ptr %3716, ptr %3717, i64 %3718, i64 %3719, i64 %3720, i64 %3721, i64 %3722, i64 %3723, i64 %3724, ptr %3725, ptr %3726, i64 %3727, i64 %3728, i64 %3729, i64 %3730, i64 %3731, i64 %3732, i64 %3733, ptr %3734, ptr %3735, i64 %3736, i64 %3737, i64 %3738, i64 %3739, i64 %3740, i64 %3741, i64 %3742)
  br label %3743

3743:                                             ; preds = %3785, %3687
  %3744 = phi i64 [ %3786, %3785 ], [ 0, %3687 ]
  %3745 = icmp slt i64 %3744, 2
  br i1 %3745, label %3746, label %3787

3746:                                             ; preds = %3743
  br label %3747

3747:                                             ; preds = %3783, %3746
  %3748 = phi i64 [ %3784, %3783 ], [ 0, %3746 ]
  %3749 = icmp slt i64 %3748, 1024
  br i1 %3749, label %3750, label %3785

3750:                                             ; preds = %3747
  br label %3751

3751:                                             ; preds = %3754, %3750
  %3752 = phi i64 [ %3782, %3754 ], [ 0, %3750 ]
  %3753 = icmp slt i64 %3752, 128
  br i1 %3753, label %3754, label %3783

3754:                                             ; preds = %3751
  %3755 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3702, 1
  %3756 = mul nuw nsw i64 %3744, 131072
  %3757 = mul nuw nsw i64 %3748, 128
  %3758 = add nuw nsw i64 %3756, %3757
  %3759 = add nuw nsw i64 %3758, %3752
  %3760 = getelementptr inbounds float, ptr %3755, i64 %3759
  %3761 = load float, ptr %3760, align 4
  %3762 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %269, 1
  %3763 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %269, 2
  %3764 = getelementptr float, ptr %3762, i64 %3763
  %3765 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %269, 4, 0
  %3766 = mul nuw nsw i64 %3752, %3765
  %3767 = getelementptr inbounds float, ptr %3764, i64 %3766
  %3768 = load float, ptr %3767, align 4
  %3769 = fadd float %3761, %3768
  %3770 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %3771 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %3772 = getelementptr float, ptr %3770, i64 %3771
  %3773 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %3774 = mul nuw nsw i64 %3744, %3773
  %3775 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %3776 = mul nuw nsw i64 %3748, %3775
  %3777 = add nuw nsw i64 %3774, %3776
  %3778 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %3779 = mul nuw nsw i64 %3752, %3778
  %3780 = add nuw nsw i64 %3777, %3779
  %3781 = getelementptr inbounds float, ptr %3772, i64 %3780
  store float %3769, ptr %3781, align 4
  %3782 = add i64 %3752, 1
  br label %3751

3783:                                             ; preds = %3751
  %3784 = add i64 %3748, 1
  br label %3747

3785:                                             ; preds = %3747
  %3786 = add i64 %3744, 1
  br label %3743

3787:                                             ; preds = %3743
  %3788 = call ptr @malloc(i64 1048640)
  %3789 = ptrtoint ptr %3788 to i64
  %3790 = add i64 %3789, 63
  %3791 = urem i64 %3790, 64
  %3792 = sub i64 %3790, %3791
  %3793 = inttoptr i64 %3792 to ptr
  %3794 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %3788, 0
  %3795 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3794, ptr %3793, 1
  %3796 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3795, i64 0, 2
  %3797 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3796, i64 2, 3, 0
  %3798 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3797, i64 1024, 3, 1
  %3799 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3798, i64 128, 3, 2
  %3800 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3799, i64 131072, 4, 0
  %3801 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3800, i64 128, 4, 1
  %3802 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3801, i64 1, 4, 2
  br label %3803

3803:                                             ; preds = %3845, %3787
  %3804 = phi i64 [ %3846, %3845 ], [ 0, %3787 ]
  %3805 = icmp slt i64 %3804, 2
  br i1 %3805, label %3806, label %3847

3806:                                             ; preds = %3803
  br label %3807

3807:                                             ; preds = %3843, %3806
  %3808 = phi i64 [ %3844, %3843 ], [ 0, %3806 ]
  %3809 = icmp slt i64 %3808, 1024
  br i1 %3809, label %3810, label %3845

3810:                                             ; preds = %3807
  br label %3811

3811:                                             ; preds = %3814, %3810
  %3812 = phi i64 [ %3842, %3814 ], [ 0, %3810 ]
  %3813 = icmp slt i64 %3812, 128
  br i1 %3813, label %3814, label %3843

3814:                                             ; preds = %3811
  %3815 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2683, 1
  %3816 = mul nuw nsw i64 %3804, 131072
  %3817 = mul nuw nsw i64 %3808, 128
  %3818 = add nuw nsw i64 %3816, %3817
  %3819 = add nuw nsw i64 %3818, %3812
  %3820 = getelementptr inbounds float, ptr %3815, i64 %3819
  %3821 = load float, ptr %3820, align 4
  %3822 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %3823 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %3824 = getelementptr float, ptr %3822, i64 %3823
  %3825 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %3826 = mul nuw nsw i64 %3804, %3825
  %3827 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %3828 = mul nuw nsw i64 %3808, %3827
  %3829 = add nuw nsw i64 %3826, %3828
  %3830 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %3831 = mul nuw nsw i64 %3812, %3830
  %3832 = add nuw nsw i64 %3829, %3831
  %3833 = getelementptr inbounds float, ptr %3824, i64 %3832
  %3834 = load float, ptr %3833, align 4
  %3835 = fadd float %3821, %3834
  %3836 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3802, 1
  %3837 = mul nuw nsw i64 %3804, 131072
  %3838 = mul nuw nsw i64 %3808, 128
  %3839 = add nuw nsw i64 %3837, %3838
  %3840 = add nuw nsw i64 %3839, %3812
  %3841 = getelementptr inbounds float, ptr %3836, i64 %3840
  store float %3835, ptr %3841, align 4
  %3842 = add i64 %3812, 1
  br label %3811

3843:                                             ; preds = %3811
  %3844 = add i64 %3808, 1
  br label %3807

3845:                                             ; preds = %3807
  %3846 = add i64 %3804, 1
  br label %3803

3847:                                             ; preds = %3803
  %3848 = call ptr @malloc(i64 8256)
  %3849 = ptrtoint ptr %3848 to i64
  %3850 = add i64 %3849, 63
  %3851 = urem i64 %3850, 64
  %3852 = sub i64 %3850, %3851
  %3853 = inttoptr i64 %3852 to ptr
  %3854 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %3848, 0
  %3855 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3854, ptr %3853, 1
  %3856 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3855, i64 0, 2
  %3857 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3856, i64 2, 3, 0
  %3858 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3857, i64 1024, 3, 1
  %3859 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3858, i64 1, 3, 2
  %3860 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3859, i64 1024, 4, 0
  %3861 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3860, i64 1, 4, 1
  %3862 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3861, i64 1, 4, 2
  %3863 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 0
  %3864 = mul i64 1, %3863
  %3865 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 1
  %3866 = mul i64 %3864, %3865
  %3867 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 2
  %3868 = mul i64 %3866, %3867
  %3869 = mul i64 %3868, 4
  %3870 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 1
  %3871 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 2
  %3872 = getelementptr float, ptr %3870, i64 %3871
  %3873 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3862, 1
  %3874 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3862, 2
  %3875 = getelementptr float, ptr %3873, i64 %3874
  call void @llvm.memcpy.p0.p0.i64(ptr %3875, ptr %3872, i64 %3869, i1 false)
  br label %3876

3876:                                             ; preds = %3910, %3847
  %3877 = phi i64 [ %3911, %3910 ], [ 0, %3847 ]
  %3878 = icmp slt i64 %3877, 2
  br i1 %3878, label %3879, label %3912

3879:                                             ; preds = %3876
  br label %3880

3880:                                             ; preds = %3908, %3879
  %3881 = phi i64 [ %3909, %3908 ], [ 0, %3879 ]
  %3882 = icmp slt i64 %3881, 1024
  br i1 %3882, label %3883, label %3910

3883:                                             ; preds = %3880
  br label %3884

3884:                                             ; preds = %3887, %3883
  %3885 = phi i64 [ %3907, %3887 ], [ 0, %3883 ]
  %3886 = icmp slt i64 %3885, 128
  br i1 %3886, label %3887, label %3908

3887:                                             ; preds = %3884
  %3888 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3802, 1
  %3889 = mul nuw nsw i64 %3877, 131072
  %3890 = mul nuw nsw i64 %3881, 128
  %3891 = add nuw nsw i64 %3889, %3890
  %3892 = add nuw nsw i64 %3891, %3885
  %3893 = getelementptr inbounds float, ptr %3888, i64 %3892
  %3894 = load float, ptr %3893, align 4
  %3895 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3862, 1
  %3896 = mul nuw nsw i64 %3877, 1024
  %3897 = add nuw nsw i64 %3896, %3881
  %3898 = add nuw nsw i64 %3897, 0
  %3899 = getelementptr inbounds float, ptr %3895, i64 %3898
  %3900 = load float, ptr %3899, align 4
  %3901 = fadd float %3894, %3900
  %3902 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3862, 1
  %3903 = mul nuw nsw i64 %3877, 1024
  %3904 = add nuw nsw i64 %3903, %3881
  %3905 = add nuw nsw i64 %3904, 0
  %3906 = getelementptr inbounds float, ptr %3902, i64 %3905
  store float %3901, ptr %3906, align 4
  %3907 = add i64 %3885, 1
  br label %3884

3908:                                             ; preds = %3884
  %3909 = add i64 %3881, 1
  br label %3880

3910:                                             ; preds = %3880
  %3911 = add i64 %3877, 1
  br label %3876

3912:                                             ; preds = %3876
  br label %3913

3913:                                             ; preds = %3940, %3912
  %3914 = phi i64 [ %3941, %3940 ], [ 0, %3912 ]
  %3915 = icmp slt i64 %3914, 2
  br i1 %3915, label %3916, label %3942

3916:                                             ; preds = %3913
  br label %3917

3917:                                             ; preds = %3938, %3916
  %3918 = phi i64 [ %3939, %3938 ], [ 0, %3916 ]
  %3919 = icmp slt i64 %3918, 1024
  br i1 %3919, label %3920, label %3940

3920:                                             ; preds = %3917
  br label %3921

3921:                                             ; preds = %3924, %3920
  %3922 = phi i64 [ %3937, %3924 ], [ 0, %3920 ]
  %3923 = icmp slt i64 %3922, 1
  br i1 %3923, label %3924, label %3938

3924:                                             ; preds = %3921
  %3925 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3862, 1
  %3926 = mul nuw nsw i64 %3914, 1024
  %3927 = add nuw nsw i64 %3926, %3918
  %3928 = add nuw nsw i64 %3927, %3922
  %3929 = getelementptr inbounds float, ptr %3925, i64 %3928
  %3930 = load float, ptr %3929, align 4
  %3931 = fdiv float %3930, 1.280000e+02
  %3932 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %3933 = mul nuw nsw i64 %3914, 1024
  %3934 = add nuw nsw i64 %3933, %3918
  %3935 = add nuw nsw i64 %3934, %3922
  %3936 = getelementptr inbounds float, ptr %3932, i64 %3935
  store float %3931, ptr %3936, align 4
  %3937 = add i64 %3922, 1
  br label %3921

3938:                                             ; preds = %3921
  %3939 = add i64 %3918, 1
  br label %3917

3940:                                             ; preds = %3917
  %3941 = add i64 %3914, 1
  br label %3913

3942:                                             ; preds = %3913
  %3943 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 0
  %3944 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %3945 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %3943, 0
  %3946 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3945, ptr %3944, 1
  %3947 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3946, i64 0, 2
  %3948 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3947, i64 2, 3, 0
  %3949 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3948, i64 1024, 4, 0
  %3950 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3949, i64 1024, 3, 1
  %3951 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3950, i64 1, 4, 1
  br label %3952

3952:                                             ; preds = %3984, %3942
  %3953 = phi i64 [ %3985, %3984 ], [ 0, %3942 ]
  %3954 = icmp slt i64 %3953, 2
  br i1 %3954, label %3955, label %3986

3955:                                             ; preds = %3952
  br label %3956

3956:                                             ; preds = %3982, %3955
  %3957 = phi i64 [ %3983, %3982 ], [ 0, %3955 ]
  %3958 = icmp slt i64 %3957, 1024
  br i1 %3958, label %3959, label %3984

3959:                                             ; preds = %3956
  br label %3960

3960:                                             ; preds = %3963, %3959
  %3961 = phi i64 [ %3981, %3963 ], [ 0, %3959 ]
  %3962 = icmp slt i64 %3961, 128
  br i1 %3962, label %3963, label %3982

3963:                                             ; preds = %3960
  %3964 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3951, 1
  %3965 = mul nuw nsw i64 %3953, 1024
  %3966 = add nuw nsw i64 %3965, %3957
  %3967 = getelementptr inbounds float, ptr %3964, i64 %3966
  %3968 = load float, ptr %3967, align 4
  %3969 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %3970 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %3971 = getelementptr float, ptr %3969, i64 %3970
  %3972 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %3973 = mul nuw nsw i64 %3953, %3972
  %3974 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %3975 = mul nuw nsw i64 %3957, %3974
  %3976 = add nuw nsw i64 %3973, %3975
  %3977 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %3978 = mul nuw nsw i64 %3961, %3977
  %3979 = add nuw nsw i64 %3976, %3978
  %3980 = getelementptr inbounds float, ptr %3971, i64 %3979
  store float %3968, ptr %3980, align 4
  %3981 = add i64 %3961, 1
  br label %3960

3982:                                             ; preds = %3960
  %3983 = add i64 %3957, 1
  br label %3956

3984:                                             ; preds = %3956
  %3985 = add i64 %3953, 1
  br label %3952

3986:                                             ; preds = %3952
  %3987 = call ptr @malloc(i64 1048640)
  %3988 = ptrtoint ptr %3987 to i64
  %3989 = add i64 %3988, 63
  %3990 = urem i64 %3989, 64
  %3991 = sub i64 %3989, %3990
  %3992 = inttoptr i64 %3991 to ptr
  %3993 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %3987, 0
  %3994 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3993, ptr %3992, 1
  %3995 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3994, i64 0, 2
  %3996 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3995, i64 2, 3, 0
  %3997 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3996, i64 1024, 3, 1
  %3998 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3997, i64 128, 3, 2
  %3999 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3998, i64 131072, 4, 0
  %4000 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3999, i64 128, 4, 1
  %4001 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4000, i64 1, 4, 2
  br label %4002

4002:                                             ; preds = %4044, %3986
  %4003 = phi i64 [ %4045, %4044 ], [ 0, %3986 ]
  %4004 = icmp slt i64 %4003, 2
  br i1 %4004, label %4005, label %4046

4005:                                             ; preds = %4002
  br label %4006

4006:                                             ; preds = %4042, %4005
  %4007 = phi i64 [ %4043, %4042 ], [ 0, %4005 ]
  %4008 = icmp slt i64 %4007, 1024
  br i1 %4008, label %4009, label %4044

4009:                                             ; preds = %4006
  br label %4010

4010:                                             ; preds = %4013, %4009
  %4011 = phi i64 [ %4041, %4013 ], [ 0, %4009 ]
  %4012 = icmp slt i64 %4011, 128
  br i1 %4012, label %4013, label %4042

4013:                                             ; preds = %4010
  %4014 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3802, 1
  %4015 = mul nuw nsw i64 %4003, 131072
  %4016 = mul nuw nsw i64 %4007, 128
  %4017 = add nuw nsw i64 %4015, %4016
  %4018 = add nuw nsw i64 %4017, %4011
  %4019 = getelementptr inbounds float, ptr %4014, i64 %4018
  %4020 = load float, ptr %4019, align 4
  %4021 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %4022 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %4023 = getelementptr float, ptr %4021, i64 %4022
  %4024 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %4025 = mul nuw nsw i64 %4003, %4024
  %4026 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %4027 = mul nuw nsw i64 %4007, %4026
  %4028 = add nuw nsw i64 %4025, %4027
  %4029 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %4030 = mul nuw nsw i64 %4011, %4029
  %4031 = add nuw nsw i64 %4028, %4030
  %4032 = getelementptr inbounds float, ptr %4023, i64 %4031
  %4033 = load float, ptr %4032, align 4
  %4034 = fsub float %4020, %4033
  %4035 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4001, 1
  %4036 = mul nuw nsw i64 %4003, 131072
  %4037 = mul nuw nsw i64 %4007, 128
  %4038 = add nuw nsw i64 %4036, %4037
  %4039 = add nuw nsw i64 %4038, %4011
  %4040 = getelementptr inbounds float, ptr %4035, i64 %4039
  store float %4034, ptr %4040, align 4
  %4041 = add i64 %4011, 1
  br label %4010

4042:                                             ; preds = %4010
  %4043 = add i64 %4007, 1
  br label %4006

4044:                                             ; preds = %4006
  %4045 = add i64 %4003, 1
  br label %4002

4046:                                             ; preds = %4002
  br label %4047

4047:                                             ; preds = %4089, %4046
  %4048 = phi i64 [ %4090, %4089 ], [ 0, %4046 ]
  %4049 = icmp slt i64 %4048, 2
  br i1 %4049, label %4050, label %4091

4050:                                             ; preds = %4047
  br label %4051

4051:                                             ; preds = %4087, %4050
  %4052 = phi i64 [ %4088, %4087 ], [ 0, %4050 ]
  %4053 = icmp slt i64 %4052, 1024
  br i1 %4053, label %4054, label %4089

4054:                                             ; preds = %4051
  br label %4055

4055:                                             ; preds = %4058, %4054
  %4056 = phi i64 [ %4086, %4058 ], [ 0, %4054 ]
  %4057 = icmp slt i64 %4056, 128
  br i1 %4057, label %4058, label %4087

4058:                                             ; preds = %4055
  %4059 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4001, 1
  %4060 = mul nuw nsw i64 %4048, 131072
  %4061 = mul nuw nsw i64 %4052, 128
  %4062 = add nuw nsw i64 %4060, %4061
  %4063 = add nuw nsw i64 %4062, %4056
  %4064 = getelementptr inbounds float, ptr %4059, i64 %4063
  %4065 = load float, ptr %4064, align 4
  %4066 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4001, 1
  %4067 = mul nuw nsw i64 %4048, 131072
  %4068 = mul nuw nsw i64 %4052, 128
  %4069 = add nuw nsw i64 %4067, %4068
  %4070 = add nuw nsw i64 %4069, %4056
  %4071 = getelementptr inbounds float, ptr %4066, i64 %4070
  %4072 = load float, ptr %4071, align 4
  %4073 = fmul float %4065, %4072
  %4074 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %4075 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %4076 = getelementptr float, ptr %4074, i64 %4075
  %4077 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %4078 = mul nuw nsw i64 %4048, %4077
  %4079 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %4080 = mul nuw nsw i64 %4052, %4079
  %4081 = add nuw nsw i64 %4078, %4080
  %4082 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %4083 = mul nuw nsw i64 %4056, %4082
  %4084 = add nuw nsw i64 %4081, %4083
  %4085 = getelementptr inbounds float, ptr %4076, i64 %4084
  store float %4073, ptr %4085, align 4
  %4086 = add i64 %4056, 1
  br label %4055

4087:                                             ; preds = %4055
  %4088 = add i64 %4052, 1
  br label %4051

4089:                                             ; preds = %4051
  %4090 = add i64 %4048, 1
  br label %4047

4091:                                             ; preds = %4047
  %4092 = call ptr @malloc(i64 8256)
  %4093 = ptrtoint ptr %4092 to i64
  %4094 = add i64 %4093, 63
  %4095 = urem i64 %4094, 64
  %4096 = sub i64 %4094, %4095
  %4097 = inttoptr i64 %4096 to ptr
  %4098 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %4092, 0
  %4099 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4098, ptr %4097, 1
  %4100 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4099, i64 0, 2
  %4101 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4100, i64 2, 3, 0
  %4102 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4101, i64 1024, 3, 1
  %4103 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4102, i64 1, 3, 2
  %4104 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4103, i64 1024, 4, 0
  %4105 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4104, i64 1, 4, 1
  %4106 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4105, i64 1, 4, 2
  %4107 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 0
  %4108 = mul i64 1, %4107
  %4109 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 1
  %4110 = mul i64 %4108, %4109
  %4111 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 2
  %4112 = mul i64 %4110, %4111
  %4113 = mul i64 %4112, 4
  %4114 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 1
  %4115 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 2
  %4116 = getelementptr float, ptr %4114, i64 %4115
  %4117 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4106, 1
  %4118 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4106, 2
  %4119 = getelementptr float, ptr %4117, i64 %4118
  call void @llvm.memcpy.p0.p0.i64(ptr %4119, ptr %4116, i64 %4113, i1 false)
  br label %4120

4120:                                             ; preds = %4160, %4091
  %4121 = phi i64 [ %4161, %4160 ], [ 0, %4091 ]
  %4122 = icmp slt i64 %4121, 2
  br i1 %4122, label %4123, label %4162

4123:                                             ; preds = %4120
  br label %4124

4124:                                             ; preds = %4158, %4123
  %4125 = phi i64 [ %4159, %4158 ], [ 0, %4123 ]
  %4126 = icmp slt i64 %4125, 1024
  br i1 %4126, label %4127, label %4160

4127:                                             ; preds = %4124
  br label %4128

4128:                                             ; preds = %4131, %4127
  %4129 = phi i64 [ %4157, %4131 ], [ 0, %4127 ]
  %4130 = icmp slt i64 %4129, 128
  br i1 %4130, label %4131, label %4158

4131:                                             ; preds = %4128
  %4132 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %4133 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %4134 = getelementptr float, ptr %4132, i64 %4133
  %4135 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %4136 = mul nuw nsw i64 %4121, %4135
  %4137 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %4138 = mul nuw nsw i64 %4125, %4137
  %4139 = add nuw nsw i64 %4136, %4138
  %4140 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %4141 = mul nuw nsw i64 %4129, %4140
  %4142 = add nuw nsw i64 %4139, %4141
  %4143 = getelementptr inbounds float, ptr %4134, i64 %4142
  %4144 = load float, ptr %4143, align 4
  %4145 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4106, 1
  %4146 = mul nuw nsw i64 %4121, 1024
  %4147 = add nuw nsw i64 %4146, %4125
  %4148 = add nuw nsw i64 %4147, 0
  %4149 = getelementptr inbounds float, ptr %4145, i64 %4148
  %4150 = load float, ptr %4149, align 4
  %4151 = fadd float %4144, %4150
  %4152 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4106, 1
  %4153 = mul nuw nsw i64 %4121, 1024
  %4154 = add nuw nsw i64 %4153, %4125
  %4155 = add nuw nsw i64 %4154, 0
  %4156 = getelementptr inbounds float, ptr %4152, i64 %4155
  store float %4151, ptr %4156, align 4
  %4157 = add i64 %4129, 1
  br label %4128

4158:                                             ; preds = %4128
  %4159 = add i64 %4125, 1
  br label %4124

4160:                                             ; preds = %4124
  %4161 = add i64 %4121, 1
  br label %4120

4162:                                             ; preds = %4120
  br label %4163

4163:                                             ; preds = %4190, %4162
  %4164 = phi i64 [ %4191, %4190 ], [ 0, %4162 ]
  %4165 = icmp slt i64 %4164, 2
  br i1 %4165, label %4166, label %4192

4166:                                             ; preds = %4163
  br label %4167

4167:                                             ; preds = %4188, %4166
  %4168 = phi i64 [ %4189, %4188 ], [ 0, %4166 ]
  %4169 = icmp slt i64 %4168, 1024
  br i1 %4169, label %4170, label %4190

4170:                                             ; preds = %4167
  br label %4171

4171:                                             ; preds = %4174, %4170
  %4172 = phi i64 [ %4187, %4174 ], [ 0, %4170 ]
  %4173 = icmp slt i64 %4172, 1
  br i1 %4173, label %4174, label %4188

4174:                                             ; preds = %4171
  %4175 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4106, 1
  %4176 = mul nuw nsw i64 %4164, 1024
  %4177 = add nuw nsw i64 %4176, %4168
  %4178 = add nuw nsw i64 %4177, %4172
  %4179 = getelementptr inbounds float, ptr %4175, i64 %4178
  %4180 = load float, ptr %4179, align 4
  %4181 = fdiv float %4180, 1.280000e+02
  %4182 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %4183 = mul nuw nsw i64 %4164, 1024
  %4184 = add nuw nsw i64 %4183, %4168
  %4185 = add nuw nsw i64 %4184, %4172
  %4186 = getelementptr inbounds float, ptr %4182, i64 %4185
  store float %4181, ptr %4186, align 4
  %4187 = add i64 %4172, 1
  br label %4171

4188:                                             ; preds = %4171
  %4189 = add i64 %4168, 1
  br label %4167

4190:                                             ; preds = %4167
  %4191 = add i64 %4164, 1
  br label %4163

4192:                                             ; preds = %4163
  br label %4193

4193:                                             ; preds = %4220, %4192
  %4194 = phi i64 [ %4221, %4220 ], [ 0, %4192 ]
  %4195 = icmp slt i64 %4194, 2
  br i1 %4195, label %4196, label %4222

4196:                                             ; preds = %4193
  br label %4197

4197:                                             ; preds = %4218, %4196
  %4198 = phi i64 [ %4219, %4218 ], [ 0, %4196 ]
  %4199 = icmp slt i64 %4198, 1024
  br i1 %4199, label %4200, label %4220

4200:                                             ; preds = %4197
  br label %4201

4201:                                             ; preds = %4204, %4200
  %4202 = phi i64 [ %4217, %4204 ], [ 0, %4200 ]
  %4203 = icmp slt i64 %4202, 1
  br i1 %4203, label %4204, label %4218

4204:                                             ; preds = %4201
  %4205 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %4206 = mul nuw nsw i64 %4194, 1024
  %4207 = add nuw nsw i64 %4206, %4198
  %4208 = add nuw nsw i64 %4207, %4202
  %4209 = getelementptr inbounds float, ptr %4205, i64 %4208
  %4210 = load float, ptr %4209, align 4
  %4211 = fadd float %4210, 0x3EE4F8B580000000
  %4212 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %4213 = mul nuw nsw i64 %4194, 1024
  %4214 = add nuw nsw i64 %4213, %4198
  %4215 = add nuw nsw i64 %4214, %4202
  %4216 = getelementptr inbounds float, ptr %4212, i64 %4215
  store float %4211, ptr %4216, align 4
  %4217 = add i64 %4202, 1
  br label %4201

4218:                                             ; preds = %4201
  %4219 = add i64 %4198, 1
  br label %4197

4220:                                             ; preds = %4197
  %4221 = add i64 %4194, 1
  br label %4193

4222:                                             ; preds = %4193
  br label %4223

4223:                                             ; preds = %4251, %4222
  %4224 = phi i64 [ %4252, %4251 ], [ 0, %4222 ]
  %4225 = icmp slt i64 %4224, 2
  br i1 %4225, label %4226, label %4253

4226:                                             ; preds = %4223
  br label %4227

4227:                                             ; preds = %4249, %4226
  %4228 = phi i64 [ %4250, %4249 ], [ 0, %4226 ]
  %4229 = icmp slt i64 %4228, 1024
  br i1 %4229, label %4230, label %4251

4230:                                             ; preds = %4227
  br label %4231

4231:                                             ; preds = %4234, %4230
  %4232 = phi i64 [ %4248, %4234 ], [ 0, %4230 ]
  %4233 = icmp slt i64 %4232, 1
  br i1 %4233, label %4234, label %4249

4234:                                             ; preds = %4231
  %4235 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %4236 = mul nuw nsw i64 %4224, 1024
  %4237 = add nuw nsw i64 %4236, %4228
  %4238 = add nuw nsw i64 %4237, %4232
  %4239 = getelementptr inbounds float, ptr %4235, i64 %4238
  %4240 = load float, ptr %4239, align 4
  %4241 = call float @llvm.sqrt.f32(float %4240)
  %4242 = fdiv float 1.000000e+00, %4241
  %4243 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %4244 = mul nuw nsw i64 %4224, 1024
  %4245 = add nuw nsw i64 %4244, %4228
  %4246 = add nuw nsw i64 %4245, %4232
  %4247 = getelementptr inbounds float, ptr %4243, i64 %4246
  store float %4242, ptr %4247, align 4
  %4248 = add i64 %4232, 1
  br label %4231

4249:                                             ; preds = %4231
  %4250 = add i64 %4228, 1
  br label %4227

4251:                                             ; preds = %4227
  %4252 = add i64 %4224, 1
  br label %4223

4253:                                             ; preds = %4223
  %4254 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 0
  %4255 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %4256 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %4254, 0
  %4257 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4256, ptr %4255, 1
  %4258 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4257, i64 0, 2
  %4259 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4258, i64 2, 3, 0
  %4260 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4259, i64 1024, 4, 0
  %4261 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4260, i64 1024, 3, 1
  %4262 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4261, i64 1, 4, 1
  br label %4263

4263:                                             ; preds = %4295, %4253
  %4264 = phi i64 [ %4296, %4295 ], [ 0, %4253 ]
  %4265 = icmp slt i64 %4264, 2
  br i1 %4265, label %4266, label %4297

4266:                                             ; preds = %4263
  br label %4267

4267:                                             ; preds = %4293, %4266
  %4268 = phi i64 [ %4294, %4293 ], [ 0, %4266 ]
  %4269 = icmp slt i64 %4268, 1024
  br i1 %4269, label %4270, label %4295

4270:                                             ; preds = %4267
  br label %4271

4271:                                             ; preds = %4274, %4270
  %4272 = phi i64 [ %4292, %4274 ], [ 0, %4270 ]
  %4273 = icmp slt i64 %4272, 128
  br i1 %4273, label %4274, label %4293

4274:                                             ; preds = %4271
  %4275 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %4262, 1
  %4276 = mul nuw nsw i64 %4264, 1024
  %4277 = add nuw nsw i64 %4276, %4268
  %4278 = getelementptr inbounds float, ptr %4275, i64 %4277
  %4279 = load float, ptr %4278, align 4
  %4280 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %4281 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %4282 = getelementptr float, ptr %4280, i64 %4281
  %4283 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %4284 = mul nuw nsw i64 %4264, %4283
  %4285 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %4286 = mul nuw nsw i64 %4268, %4285
  %4287 = add nuw nsw i64 %4284, %4286
  %4288 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %4289 = mul nuw nsw i64 %4272, %4288
  %4290 = add nuw nsw i64 %4287, %4289
  %4291 = getelementptr inbounds float, ptr %4282, i64 %4290
  store float %4279, ptr %4291, align 4
  %4292 = add i64 %4272, 1
  br label %4271

4293:                                             ; preds = %4271
  %4294 = add i64 %4268, 1
  br label %4267

4295:                                             ; preds = %4267
  %4296 = add i64 %4264, 1
  br label %4263

4297:                                             ; preds = %4263
  br label %4298

4298:                                             ; preds = %4346, %4297
  %4299 = phi i64 [ %4347, %4346 ], [ 0, %4297 ]
  %4300 = icmp slt i64 %4299, 2
  br i1 %4300, label %4301, label %4348

4301:                                             ; preds = %4298
  br label %4302

4302:                                             ; preds = %4344, %4301
  %4303 = phi i64 [ %4345, %4344 ], [ 0, %4301 ]
  %4304 = icmp slt i64 %4303, 1024
  br i1 %4304, label %4305, label %4346

4305:                                             ; preds = %4302
  br label %4306

4306:                                             ; preds = %4309, %4305
  %4307 = phi i64 [ %4343, %4309 ], [ 0, %4305 ]
  %4308 = icmp slt i64 %4307, 128
  br i1 %4308, label %4309, label %4344

4309:                                             ; preds = %4306
  %4310 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4001, 1
  %4311 = mul nuw nsw i64 %4299, 131072
  %4312 = mul nuw nsw i64 %4303, 128
  %4313 = add nuw nsw i64 %4311, %4312
  %4314 = add nuw nsw i64 %4313, %4307
  %4315 = getelementptr inbounds float, ptr %4310, i64 %4314
  %4316 = load float, ptr %4315, align 4
  %4317 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %4318 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %4319 = getelementptr float, ptr %4317, i64 %4318
  %4320 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %4321 = mul nuw nsw i64 %4299, %4320
  %4322 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %4323 = mul nuw nsw i64 %4303, %4322
  %4324 = add nuw nsw i64 %4321, %4323
  %4325 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %4326 = mul nuw nsw i64 %4307, %4325
  %4327 = add nuw nsw i64 %4324, %4326
  %4328 = getelementptr inbounds float, ptr %4319, i64 %4327
  %4329 = load float, ptr %4328, align 4
  %4330 = fmul float %4316, %4329
  %4331 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %4332 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %4333 = getelementptr float, ptr %4331, i64 %4332
  %4334 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %4335 = mul nuw nsw i64 %4299, %4334
  %4336 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %4337 = mul nuw nsw i64 %4303, %4336
  %4338 = add nuw nsw i64 %4335, %4337
  %4339 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %4340 = mul nuw nsw i64 %4307, %4339
  %4341 = add nuw nsw i64 %4338, %4340
  %4342 = getelementptr inbounds float, ptr %4333, i64 %4341
  store float %4330, ptr %4342, align 4
  %4343 = add i64 %4307, 1
  br label %4306

4344:                                             ; preds = %4306
  %4345 = add i64 %4303, 1
  br label %4302

4346:                                             ; preds = %4302
  %4347 = add i64 %4299, 1
  br label %4298

4348:                                             ; preds = %4298
  br label %4349

4349:                                             ; preds = %4397, %4348
  %4350 = phi i64 [ %4398, %4397 ], [ 0, %4348 ]
  %4351 = icmp slt i64 %4350, 2
  br i1 %4351, label %4352, label %4399

4352:                                             ; preds = %4349
  br label %4353

4353:                                             ; preds = %4395, %4352
  %4354 = phi i64 [ %4396, %4395 ], [ 0, %4352 ]
  %4355 = icmp slt i64 %4354, 1024
  br i1 %4355, label %4356, label %4397

4356:                                             ; preds = %4353
  br label %4357

4357:                                             ; preds = %4360, %4356
  %4358 = phi i64 [ %4394, %4360 ], [ 0, %4356 ]
  %4359 = icmp slt i64 %4358, 128
  br i1 %4359, label %4360, label %4395

4360:                                             ; preds = %4357
  %4361 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %4362 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %4363 = getelementptr float, ptr %4361, i64 %4362
  %4364 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %4365 = mul nuw nsw i64 %4350, %4364
  %4366 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %4367 = mul nuw nsw i64 %4354, %4366
  %4368 = add nuw nsw i64 %4365, %4367
  %4369 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %4370 = mul nuw nsw i64 %4358, %4369
  %4371 = add nuw nsw i64 %4368, %4370
  %4372 = getelementptr inbounds float, ptr %4363, i64 %4371
  %4373 = load float, ptr %4372, align 4
  %4374 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %264, 1
  %4375 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %264, 2
  %4376 = getelementptr float, ptr %4374, i64 %4375
  %4377 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %264, 4, 0
  %4378 = mul nuw nsw i64 %4358, %4377
  %4379 = getelementptr inbounds float, ptr %4376, i64 %4378
  %4380 = load float, ptr %4379, align 4
  %4381 = fmul float %4373, %4380
  %4382 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %4383 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %4384 = getelementptr float, ptr %4382, i64 %4383
  %4385 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %4386 = mul nuw nsw i64 %4350, %4385
  %4387 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %4388 = mul nuw nsw i64 %4354, %4387
  %4389 = add nuw nsw i64 %4386, %4388
  %4390 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %4391 = mul nuw nsw i64 %4358, %4390
  %4392 = add nuw nsw i64 %4389, %4391
  %4393 = getelementptr inbounds float, ptr %4384, i64 %4392
  store float %4381, ptr %4393, align 4
  %4394 = add i64 %4358, 1
  br label %4357

4395:                                             ; preds = %4357
  %4396 = add i64 %4354, 1
  br label %4353

4397:                                             ; preds = %4353
  %4398 = add i64 %4350, 1
  br label %4349

4399:                                             ; preds = %4349
  br label %4400

4400:                                             ; preds = %4448, %4399
  %4401 = phi i64 [ %4449, %4448 ], [ 0, %4399 ]
  %4402 = icmp slt i64 %4401, 2
  br i1 %4402, label %4403, label %4450

4403:                                             ; preds = %4400
  br label %4404

4404:                                             ; preds = %4446, %4403
  %4405 = phi i64 [ %4447, %4446 ], [ 0, %4403 ]
  %4406 = icmp slt i64 %4405, 1024
  br i1 %4406, label %4407, label %4448

4407:                                             ; preds = %4404
  br label %4408

4408:                                             ; preds = %4411, %4407
  %4409 = phi i64 [ %4445, %4411 ], [ 0, %4407 ]
  %4410 = icmp slt i64 %4409, 128
  br i1 %4410, label %4411, label %4446

4411:                                             ; preds = %4408
  %4412 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %4413 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %4414 = getelementptr float, ptr %4412, i64 %4413
  %4415 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %4416 = mul nuw nsw i64 %4401, %4415
  %4417 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %4418 = mul nuw nsw i64 %4405, %4417
  %4419 = add nuw nsw i64 %4416, %4418
  %4420 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %4421 = mul nuw nsw i64 %4409, %4420
  %4422 = add nuw nsw i64 %4419, %4421
  %4423 = getelementptr inbounds float, ptr %4414, i64 %4422
  %4424 = load float, ptr %4423, align 4
  %4425 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %259, 1
  %4426 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %259, 2
  %4427 = getelementptr float, ptr %4425, i64 %4426
  %4428 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %259, 4, 0
  %4429 = mul nuw nsw i64 %4409, %4428
  %4430 = getelementptr inbounds float, ptr %4427, i64 %4429
  %4431 = load float, ptr %4430, align 4
  %4432 = fadd float %4424, %4431
  %4433 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %4434 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %4435 = getelementptr float, ptr %4433, i64 %4434
  %4436 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %4437 = mul nuw nsw i64 %4401, %4436
  %4438 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %4439 = mul nuw nsw i64 %4405, %4438
  %4440 = add nuw nsw i64 %4437, %4439
  %4441 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %4442 = mul nuw nsw i64 %4409, %4441
  %4443 = add nuw nsw i64 %4440, %4442
  %4444 = getelementptr inbounds float, ptr %4435, i64 %4443
  store float %4432, ptr %4444, align 4
  %4445 = add i64 %4409, 1
  br label %4408

4446:                                             ; preds = %4408
  %4447 = add i64 %4405, 1
  br label %4404

4448:                                             ; preds = %4404
  %4449 = add i64 %4401, 1
  br label %4400

4450:                                             ; preds = %4400
  br label %4451

4451:                                             ; preds = %4474, %4450
  %4452 = phi i64 [ %4475, %4474 ], [ 0, %4450 ]
  %4453 = icmp slt i64 %4452, 128
  br i1 %4453, label %4454, label %4476

4454:                                             ; preds = %4451
  br label %4455

4455:                                             ; preds = %4458, %4454
  %4456 = phi i64 [ %4473, %4458 ], [ 0, %4454 ]
  %4457 = icmp slt i64 %4456, 384
  br i1 %4457, label %4458, label %4474

4458:                                             ; preds = %4455
  %4459 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %254, 1
  %4460 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %254, 2
  %4461 = getelementptr float, ptr %4459, i64 %4460
  %4462 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %254, 4, 0
  %4463 = mul nuw nsw i64 %4456, %4462
  %4464 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %254, 4, 1
  %4465 = mul nuw nsw i64 %4452, %4464
  %4466 = add nuw nsw i64 %4463, %4465
  %4467 = getelementptr inbounds float, ptr %4461, i64 %4466
  %4468 = load float, ptr %4467, align 4
  %4469 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %1033, 1
  %4470 = mul nuw nsw i64 %4452, 384
  %4471 = add nuw nsw i64 %4470, %4456
  %4472 = getelementptr inbounds float, ptr %4469, i64 %4471
  store float %4468, ptr %4472, align 4
  %4473 = add i64 %4456, 1
  br label %4455

4474:                                             ; preds = %4455
  %4475 = add i64 %4452, 1
  br label %4451

4476:                                             ; preds = %4451
  br label %4477

4477:                                             ; preds = %4503, %4476
  %4478 = phi i64 [ %4504, %4503 ], [ 0, %4476 ]
  %4479 = icmp slt i64 %4478, 2
  br i1 %4479, label %4480, label %4505

4480:                                             ; preds = %4477
  br label %4481

4481:                                             ; preds = %4501, %4480
  %4482 = phi i64 [ %4502, %4501 ], [ 0, %4480 ]
  %4483 = icmp slt i64 %4482, 128
  br i1 %4483, label %4484, label %4503

4484:                                             ; preds = %4481
  br label %4485

4485:                                             ; preds = %4488, %4484
  %4486 = phi i64 [ %4500, %4488 ], [ 0, %4484 ]
  %4487 = icmp slt i64 %4486, 384
  br i1 %4487, label %4488, label %4501

4488:                                             ; preds = %4485
  %4489 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %1033, 1
  %4490 = mul nuw nsw i64 %4482, 384
  %4491 = add nuw nsw i64 %4490, %4486
  %4492 = getelementptr inbounds float, ptr %4489, i64 %4491
  %4493 = load float, ptr %4492, align 4
  %4494 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 1
  %4495 = mul nuw nsw i64 %4478, 49152
  %4496 = mul nuw nsw i64 %4482, 384
  %4497 = add nuw nsw i64 %4495, %4496
  %4498 = add nuw nsw i64 %4497, %4486
  %4499 = getelementptr inbounds float, ptr %4494, i64 %4498
  store float %4493, ptr %4499, align 4
  %4500 = add i64 %4486, 1
  br label %4485

4501:                                             ; preds = %4485
  %4502 = add i64 %4482, 1
  br label %4481

4503:                                             ; preds = %4481
  %4504 = add i64 %4478, 1
  br label %4477

4505:                                             ; preds = %4477
  %4506 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 0
  %4507 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %4508 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %4509 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 3, 0
  %4510 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 3, 1
  %4511 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 3, 2
  %4512 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %4513 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %4514 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %4515 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 0
  %4516 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 1
  %4517 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 2
  %4518 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 3, 0
  %4519 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 3, 1
  %4520 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 3, 2
  %4521 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 4, 0
  %4522 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 4, 1
  %4523 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1074, 4, 2
  %4524 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1133, 0
  %4525 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1133, 1
  %4526 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1133, 2
  %4527 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1133, 3, 0
  %4528 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1133, 3, 1
  %4529 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1133, 3, 2
  %4530 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1133, 4, 0
  %4531 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1133, 4, 1
  %4532 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1133, 4, 2
  call void @ukernel_bmm(ptr %4506, ptr %4507, i64 %4508, i64 %4509, i64 %4510, i64 %4511, i64 %4512, i64 %4513, i64 %4514, ptr %4515, ptr %4516, i64 %4517, i64 %4518, i64 %4519, i64 %4520, i64 %4521, i64 %4522, i64 %4523, ptr %4524, ptr %4525, i64 %4526, i64 %4527, i64 %4528, i64 %4529, i64 %4530, i64 %4531, i64 %4532)
  br label %4533

4533:                                             ; preds = %4569, %4505
  %4534 = phi i64 [ %4570, %4569 ], [ 0, %4505 ]
  %4535 = icmp slt i64 %4534, 2
  br i1 %4535, label %4536, label %4571

4536:                                             ; preds = %4533
  br label %4537

4537:                                             ; preds = %4567, %4536
  %4538 = phi i64 [ %4568, %4567 ], [ 0, %4536 ]
  %4539 = icmp slt i64 %4538, 1024
  br i1 %4539, label %4540, label %4569

4540:                                             ; preds = %4537
  br label %4541

4541:                                             ; preds = %4544, %4540
  %4542 = phi i64 [ %4566, %4544 ], [ 0, %4540 ]
  %4543 = icmp slt i64 %4542, 384
  br i1 %4543, label %4544, label %4567

4544:                                             ; preds = %4541
  %4545 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1133, 1
  %4546 = mul nuw nsw i64 %4534, 393216
  %4547 = mul nuw nsw i64 %4538, 384
  %4548 = add nuw nsw i64 %4546, %4547
  %4549 = add nuw nsw i64 %4548, %4542
  %4550 = getelementptr inbounds float, ptr %4545, i64 %4549
  %4551 = load float, ptr %4550, align 4
  %4552 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %247, 1
  %4553 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %247, 2
  %4554 = getelementptr float, ptr %4552, i64 %4553
  %4555 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %247, 4, 0
  %4556 = mul nuw nsw i64 %4542, %4555
  %4557 = getelementptr inbounds float, ptr %4554, i64 %4556
  %4558 = load float, ptr %4557, align 4
  %4559 = fadd float %4551, %4558
  %4560 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1118, 1
  %4561 = mul nuw nsw i64 %4534, 393216
  %4562 = mul nuw nsw i64 %4538, 384
  %4563 = add nuw nsw i64 %4561, %4562
  %4564 = add nuw nsw i64 %4563, %4542
  %4565 = getelementptr inbounds float, ptr %4560, i64 %4564
  store float %4559, ptr %4565, align 4
  %4566 = add i64 %4542, 1
  br label %4541

4567:                                             ; preds = %4541
  %4568 = add i64 %4538, 1
  br label %4537

4569:                                             ; preds = %4537
  %4570 = add i64 %4534, 1
  br label %4533

4571:                                             ; preds = %4533
  %4572 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1118, 0
  %4573 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1118, 1
  %4574 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %4572, 0
  %4575 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4574, ptr %4573, 1
  %4576 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4575, i64 128, 2
  %4577 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4576, i64 2, 3, 0
  %4578 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4577, i64 393216, 4, 0
  %4579 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4578, i64 1024, 3, 1
  %4580 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4579, i64 384, 4, 1
  %4581 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4580, i64 4, 3, 2
  %4582 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4581, i64 32, 4, 2
  %4583 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4582, i64 32, 3, 3
  %4584 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4583, i64 1, 4, 3
  %4585 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1118, 0
  %4586 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1118, 1
  %4587 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %4585, 0
  %4588 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4587, ptr %4586, 1
  %4589 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4588, i64 0, 2
  %4590 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4589, i64 2, 3, 0
  %4591 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4590, i64 393216, 4, 0
  %4592 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4591, i64 1024, 3, 1
  %4593 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4592, i64 384, 4, 1
  %4594 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4593, i64 4, 3, 2
  %4595 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4594, i64 32, 4, 2
  %4596 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4595, i64 32, 3, 3
  %4597 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4596, i64 1, 4, 3
  %4598 = call ptr @malloc(i64 1048640)
  %4599 = ptrtoint ptr %4598 to i64
  %4600 = add i64 %4599, 63
  %4601 = urem i64 %4600, 64
  %4602 = sub i64 %4600, %4601
  %4603 = inttoptr i64 %4602 to ptr
  %4604 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %4598, 0
  %4605 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4604, ptr %4603, 1
  %4606 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4605, i64 0, 2
  %4607 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4606, i64 2, 3, 0
  %4608 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4607, i64 4, 3, 1
  %4609 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4608, i64 1024, 3, 2
  %4610 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4609, i64 32, 3, 3
  %4611 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4610, i64 131072, 4, 0
  %4612 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4611, i64 32768, 4, 1
  %4613 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4612, i64 32, 4, 2
  %4614 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4613, i64 1, 4, 3
  br label %4615

4615:                                             ; preds = %4653, %4571
  %4616 = phi i64 [ %4654, %4653 ], [ 0, %4571 ]
  %4617 = icmp slt i64 %4616, 2
  br i1 %4617, label %4618, label %4655

4618:                                             ; preds = %4615
  br label %4619

4619:                                             ; preds = %4651, %4618
  %4620 = phi i64 [ %4652, %4651 ], [ 0, %4618 ]
  %4621 = icmp slt i64 %4620, 4
  br i1 %4621, label %4622, label %4653

4622:                                             ; preds = %4619
  br label %4623

4623:                                             ; preds = %4649, %4622
  %4624 = phi i64 [ %4650, %4649 ], [ 0, %4622 ]
  %4625 = icmp slt i64 %4624, 1024
  br i1 %4625, label %4626, label %4651

4626:                                             ; preds = %4623
  br label %4627

4627:                                             ; preds = %4630, %4626
  %4628 = phi i64 [ %4648, %4630 ], [ 0, %4626 ]
  %4629 = icmp slt i64 %4628, 32
  br i1 %4629, label %4630, label %4649

4630:                                             ; preds = %4627
  %4631 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4597, 1
  %4632 = mul nuw nsw i64 %4616, 393216
  %4633 = mul nuw nsw i64 %4624, 384
  %4634 = add nuw nsw i64 %4632, %4633
  %4635 = mul nuw nsw i64 %4620, 32
  %4636 = add nuw nsw i64 %4634, %4635
  %4637 = add nuw nsw i64 %4636, %4628
  %4638 = getelementptr inbounds float, ptr %4631, i64 %4637
  %4639 = load float, ptr %4638, align 4
  %4640 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4614, 1
  %4641 = mul nuw nsw i64 %4616, 131072
  %4642 = mul nuw nsw i64 %4620, 32768
  %4643 = add nuw nsw i64 %4641, %4642
  %4644 = mul nuw nsw i64 %4624, 32
  %4645 = add nuw nsw i64 %4643, %4644
  %4646 = add nuw nsw i64 %4645, %4628
  %4647 = getelementptr inbounds float, ptr %4640, i64 %4646
  store float %4639, ptr %4647, align 4
  %4648 = add i64 %4628, 1
  br label %4627

4649:                                             ; preds = %4627
  %4650 = add i64 %4624, 1
  br label %4623

4651:                                             ; preds = %4623
  %4652 = add i64 %4620, 1
  br label %4619

4653:                                             ; preds = %4619
  %4654 = add i64 %4616, 1
  br label %4615

4655:                                             ; preds = %4615
  %4656 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1118, 0
  %4657 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1118, 1
  %4658 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %4656, 0
  %4659 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4658, ptr %4657, 1
  %4660 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4659, i64 256, 2
  %4661 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4660, i64 2, 3, 0
  %4662 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4661, i64 393216, 4, 0
  %4663 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4662, i64 1024, 3, 1
  %4664 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4663, i64 384, 4, 1
  %4665 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4664, i64 4, 3, 2
  %4666 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4665, i64 32, 4, 2
  %4667 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4666, i64 32, 3, 3
  %4668 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4667, i64 1, 4, 3
  br label %4669

4669:                                             ; preds = %4708, %4655
  %4670 = phi i64 [ %4709, %4708 ], [ 0, %4655 ]
  %4671 = icmp slt i64 %4670, 2
  br i1 %4671, label %4672, label %4710

4672:                                             ; preds = %4669
  br label %4673

4673:                                             ; preds = %4706, %4672
  %4674 = phi i64 [ %4707, %4706 ], [ 0, %4672 ]
  %4675 = icmp slt i64 %4674, 4
  br i1 %4675, label %4676, label %4708

4676:                                             ; preds = %4673
  br label %4677

4677:                                             ; preds = %4704, %4676
  %4678 = phi i64 [ %4705, %4704 ], [ 0, %4676 ]
  %4679 = icmp slt i64 %4678, 1024
  br i1 %4679, label %4680, label %4706

4680:                                             ; preds = %4677
  br label %4681

4681:                                             ; preds = %4684, %4680
  %4682 = phi i64 [ %4703, %4684 ], [ 0, %4680 ]
  %4683 = icmp slt i64 %4682, 32
  br i1 %4683, label %4684, label %4704

4684:                                             ; preds = %4681
  %4685 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4668, 1
  %4686 = getelementptr float, ptr %4685, i64 256
  %4687 = mul nuw nsw i64 %4670, 393216
  %4688 = mul nuw nsw i64 %4678, 384
  %4689 = add nuw nsw i64 %4687, %4688
  %4690 = mul nuw nsw i64 %4674, 32
  %4691 = add nuw nsw i64 %4689, %4690
  %4692 = add nuw nsw i64 %4691, %4682
  %4693 = getelementptr inbounds float, ptr %4686, i64 %4692
  %4694 = load float, ptr %4693, align 4
  %4695 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1294, 1
  %4696 = mul nuw nsw i64 %4670, 131072
  %4697 = mul nuw nsw i64 %4674, 32768
  %4698 = add nuw nsw i64 %4696, %4697
  %4699 = mul nuw nsw i64 %4678, 32
  %4700 = add nuw nsw i64 %4698, %4699
  %4701 = add nuw nsw i64 %4700, %4682
  %4702 = getelementptr inbounds float, ptr %4695, i64 %4701
  store float %4694, ptr %4702, align 4
  %4703 = add i64 %4682, 1
  br label %4681

4704:                                             ; preds = %4681
  %4705 = add i64 %4678, 1
  br label %4677

4706:                                             ; preds = %4677
  %4707 = add i64 %4674, 1
  br label %4673

4708:                                             ; preds = %4673
  %4709 = add i64 %4670, 1
  br label %4669

4710:                                             ; preds = %4669
  br label %4711

4711:                                             ; preds = %4750, %4710
  %4712 = phi i64 [ %4751, %4750 ], [ 0, %4710 ]
  %4713 = icmp slt i64 %4712, 2
  br i1 %4713, label %4714, label %4752

4714:                                             ; preds = %4711
  br label %4715

4715:                                             ; preds = %4748, %4714
  %4716 = phi i64 [ %4749, %4748 ], [ 0, %4714 ]
  %4717 = icmp slt i64 %4716, 4
  br i1 %4717, label %4718, label %4750

4718:                                             ; preds = %4715
  br label %4719

4719:                                             ; preds = %4746, %4718
  %4720 = phi i64 [ %4747, %4746 ], [ 0, %4718 ]
  %4721 = icmp slt i64 %4720, 32
  br i1 %4721, label %4722, label %4748

4722:                                             ; preds = %4719
  br label %4723

4723:                                             ; preds = %4726, %4722
  %4724 = phi i64 [ %4745, %4726 ], [ 0, %4722 ]
  %4725 = icmp slt i64 %4724, 1024
  br i1 %4725, label %4726, label %4746

4726:                                             ; preds = %4723
  %4727 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4584, 1
  %4728 = getelementptr float, ptr %4727, i64 128
  %4729 = mul nuw nsw i64 %4712, 393216
  %4730 = mul nuw nsw i64 %4724, 384
  %4731 = add nuw nsw i64 %4729, %4730
  %4732 = mul nuw nsw i64 %4716, 32
  %4733 = add nuw nsw i64 %4731, %4732
  %4734 = add nuw nsw i64 %4733, %4720
  %4735 = getelementptr inbounds float, ptr %4728, i64 %4734
  %4736 = load float, ptr %4735, align 4
  %4737 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1424, 1
  %4738 = mul nuw nsw i64 %4712, 131072
  %4739 = mul nuw nsw i64 %4716, 32768
  %4740 = add nuw nsw i64 %4738, %4739
  %4741 = mul nuw nsw i64 %4720, 1024
  %4742 = add nuw nsw i64 %4740, %4741
  %4743 = add nuw nsw i64 %4742, %4724
  %4744 = getelementptr inbounds float, ptr %4737, i64 %4743
  store float %4736, ptr %4744, align 4
  %4745 = add i64 %4724, 1
  br label %4723

4746:                                             ; preds = %4723
  %4747 = add i64 %4720, 1
  br label %4719

4748:                                             ; preds = %4719
  %4749 = add i64 %4716, 1
  br label %4715

4750:                                             ; preds = %4715
  %4751 = add i64 %4712, 1
  br label %4711

4752:                                             ; preds = %4711
  %4753 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4614, 0
  %4754 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4614, 1
  %4755 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %4753, 0
  %4756 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4755, ptr %4754, 1
  %4757 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4756, i64 0, 2
  %4758 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4757, i64 8, 3, 0
  %4759 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4758, i64 32768, 4, 0
  %4760 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4759, i64 1024, 3, 1
  %4761 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4760, i64 32, 4, 1
  %4762 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4761, i64 32, 3, 2
  %4763 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4762, i64 1, 4, 2
  %4764 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1424, 0
  %4765 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1424, 1
  %4766 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %4764, 0
  %4767 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4766, ptr %4765, 1
  %4768 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4767, i64 0, 2
  %4769 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4768, i64 8, 3, 0
  %4770 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4769, i64 32768, 4, 0
  %4771 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4770, i64 32, 3, 1
  %4772 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4771, i64 1024, 4, 1
  %4773 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4772, i64 1024, 3, 2
  %4774 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4773, i64 1, 4, 2
  %4775 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4763, 0
  %4776 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4763, 1
  %4777 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4763, 2
  %4778 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4763, 3, 0
  %4779 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4763, 3, 1
  %4780 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4763, 3, 2
  %4781 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4763, 4, 0
  %4782 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4763, 4, 1
  %4783 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4763, 4, 2
  %4784 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4774, 0
  %4785 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4774, 1
  %4786 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4774, 2
  %4787 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4774, 3, 0
  %4788 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4774, 3, 1
  %4789 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4774, 3, 2
  %4790 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4774, 4, 0
  %4791 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4774, 4, 1
  %4792 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4774, 4, 2
  %4793 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1503, 0
  %4794 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1503, 1
  %4795 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1503, 2
  %4796 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1503, 3, 0
  %4797 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1503, 3, 1
  %4798 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1503, 3, 2
  %4799 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1503, 4, 0
  %4800 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1503, 4, 1
  %4801 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1503, 4, 2
  call void @ukernel_bmm(ptr %4775, ptr %4776, i64 %4777, i64 %4778, i64 %4779, i64 %4780, i64 %4781, i64 %4782, i64 %4783, ptr %4784, ptr %4785, i64 %4786, i64 %4787, i64 %4788, i64 %4789, i64 %4790, i64 %4791, i64 %4792, ptr %4793, ptr %4794, i64 %4795, i64 %4796, i64 %4797, i64 %4798, i64 %4799, i64 %4800, i64 %4801)
  %4802 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1503, 0
  %4803 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1503, 1
  %4804 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %4802, 0
  %4805 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4804, ptr %4803, 1
  %4806 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4805, i64 0, 2
  %4807 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4806, i64 2, 3, 0
  %4808 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4807, i64 4194304, 4, 0
  %4809 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4808, i64 4, 3, 1
  %4810 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4809, i64 1048576, 4, 1
  %4811 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4810, i64 1024, 3, 2
  %4812 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4811, i64 1024, 4, 2
  %4813 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4812, i64 1024, 3, 3
  %4814 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4813, i64 1, 4, 3
  br label %4815

4815:                                             ; preds = %4854, %4752
  %4816 = phi i64 [ %4855, %4854 ], [ 0, %4752 ]
  %4817 = icmp slt i64 %4816, 2
  br i1 %4817, label %4818, label %4856

4818:                                             ; preds = %4815
  br label %4819

4819:                                             ; preds = %4852, %4818
  %4820 = phi i64 [ %4853, %4852 ], [ 0, %4818 ]
  %4821 = icmp slt i64 %4820, 4
  br i1 %4821, label %4822, label %4854

4822:                                             ; preds = %4819
  br label %4823

4823:                                             ; preds = %4850, %4822
  %4824 = phi i64 [ %4851, %4850 ], [ 0, %4822 ]
  %4825 = icmp slt i64 %4824, 1024
  br i1 %4825, label %4826, label %4852

4826:                                             ; preds = %4823
  br label %4827

4827:                                             ; preds = %4830, %4826
  %4828 = phi i64 [ %4849, %4830 ], [ 0, %4826 ]
  %4829 = icmp slt i64 %4828, 1024
  br i1 %4829, label %4830, label %4850

4830:                                             ; preds = %4827
  %4831 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %4814, 1
  %4832 = mul nuw nsw i64 %4816, 4194304
  %4833 = mul nuw nsw i64 %4820, 1048576
  %4834 = add nuw nsw i64 %4832, %4833
  %4835 = mul nuw nsw i64 %4824, 1024
  %4836 = add nuw nsw i64 %4834, %4835
  %4837 = add nuw nsw i64 %4836, %4828
  %4838 = getelementptr inbounds float, ptr %4831, i64 %4837
  %4839 = load float, ptr %4838, align 4
  %4840 = fmul float %4839, 0x3FC6A09E60000000
  %4841 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %4842 = mul nuw nsw i64 %4816, 4194304
  %4843 = mul nuw nsw i64 %4820, 1048576
  %4844 = add nuw nsw i64 %4842, %4843
  %4845 = mul nuw nsw i64 %4824, 1024
  %4846 = add nuw nsw i64 %4844, %4845
  %4847 = add nuw nsw i64 %4846, %4828
  %4848 = getelementptr inbounds float, ptr %4841, i64 %4847
  store float %4840, ptr %4848, align 4
  %4849 = add i64 %4828, 1
  br label %4827

4850:                                             ; preds = %4827
  %4851 = add i64 %4824, 1
  br label %4823

4852:                                             ; preds = %4823
  %4853 = add i64 %4820, 1
  br label %4819

4854:                                             ; preds = %4819
  %4855 = add i64 %4816, 1
  br label %4815

4856:                                             ; preds = %4815
  br label %4857

4857:                                             ; preds = %4903, %4856
  %4858 = phi i64 [ %4904, %4903 ], [ 0, %4856 ]
  %4859 = icmp slt i64 %4858, 1
  br i1 %4859, label %4860, label %4905

4860:                                             ; preds = %4857
  br label %4861

4861:                                             ; preds = %4901, %4860
  %4862 = phi i64 [ %4902, %4901 ], [ 0, %4860 ]
  %4863 = icmp slt i64 %4862, 1
  br i1 %4863, label %4864, label %4903

4864:                                             ; preds = %4861
  br label %4865

4865:                                             ; preds = %4899, %4864
  %4866 = phi i64 [ %4900, %4899 ], [ 0, %4864 ]
  %4867 = icmp slt i64 %4866, 1024
  br i1 %4867, label %4868, label %4901

4868:                                             ; preds = %4865
  br label %4869

4869:                                             ; preds = %4872, %4868
  %4870 = phi i64 [ %4898, %4872 ], [ 0, %4868 ]
  %4871 = icmp slt i64 %4870, 1024
  br i1 %4871, label %4872, label %4899

4872:                                             ; preds = %4869
  %4873 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %242, 1
  %4874 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %242, 2
  %4875 = getelementptr float, ptr %4873, i64 %4874
  %4876 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %242, 4, 0
  %4877 = mul nuw nsw i64 %4858, %4876
  %4878 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %242, 4, 1
  %4879 = mul nuw nsw i64 %4862, %4878
  %4880 = add nuw nsw i64 %4877, %4879
  %4881 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %242, 4, 2
  %4882 = mul nuw nsw i64 %4866, %4881
  %4883 = add nuw nsw i64 %4880, %4882
  %4884 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %242, 4, 3
  %4885 = mul nuw nsw i64 %4870, %4884
  %4886 = add nuw nsw i64 %4883, %4885
  %4887 = getelementptr inbounds float, ptr %4875, i64 %4886
  %4888 = load float, ptr %4887, align 4
  %4889 = fcmp oeq float %4888, 0.000000e+00
  %4890 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1671, 1
  %4891 = mul nuw nsw i64 %4858, 1048576
  %4892 = mul nuw nsw i64 %4862, 1048576
  %4893 = add nuw nsw i64 %4891, %4892
  %4894 = mul nuw nsw i64 %4866, 1024
  %4895 = add nuw nsw i64 %4893, %4894
  %4896 = add nuw nsw i64 %4895, %4870
  %4897 = getelementptr inbounds i1, ptr %4890, i64 %4896
  store i1 %4889, ptr %4897, align 1
  %4898 = add i64 %4870, 1
  br label %4869

4899:                                             ; preds = %4869
  %4900 = add i64 %4866, 1
  br label %4865

4901:                                             ; preds = %4865
  %4902 = add i64 %4862, 1
  br label %4861

4903:                                             ; preds = %4861
  %4904 = add i64 %4858, 1
  br label %4857

4905:                                             ; preds = %4857
  br label %4906

4906:                                             ; preds = %4951, %4905
  %4907 = phi i64 [ %4952, %4951 ], [ 0, %4905 ]
  %4908 = icmp slt i64 %4907, 2
  br i1 %4908, label %4909, label %4953

4909:                                             ; preds = %4906
  br label %4910

4910:                                             ; preds = %4949, %4909
  %4911 = phi i64 [ %4950, %4949 ], [ 0, %4909 ]
  %4912 = icmp slt i64 %4911, 4
  br i1 %4912, label %4913, label %4951

4913:                                             ; preds = %4910
  br label %4914

4914:                                             ; preds = %4947, %4913
  %4915 = phi i64 [ %4948, %4947 ], [ 0, %4913 ]
  %4916 = icmp slt i64 %4915, 1024
  br i1 %4916, label %4917, label %4949

4917:                                             ; preds = %4914
  br label %4918

4918:                                             ; preds = %4921, %4917
  %4919 = phi i64 [ %4946, %4921 ], [ 0, %4917 ]
  %4920 = icmp slt i64 %4919, 1024
  br i1 %4920, label %4921, label %4947

4921:                                             ; preds = %4918
  %4922 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1671, 1
  %4923 = mul nuw nsw i64 %4915, 1024
  %4924 = add nuw nsw i64 0, %4923
  %4925 = add nuw nsw i64 %4924, %4919
  %4926 = getelementptr inbounds i1, ptr %4922, i64 %4925
  %4927 = load i1, ptr %4926, align 1
  %4928 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %4929 = mul nuw nsw i64 %4907, 4194304
  %4930 = mul nuw nsw i64 %4911, 1048576
  %4931 = add nuw nsw i64 %4929, %4930
  %4932 = mul nuw nsw i64 %4915, 1024
  %4933 = add nuw nsw i64 %4931, %4932
  %4934 = add nuw nsw i64 %4933, %4919
  %4935 = getelementptr inbounds float, ptr %4928, i64 %4934
  %4936 = load float, ptr %4935, align 4
  %4937 = select i1 %4927, float 0xFFF0000000000000, float %4936
  %4938 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %4939 = mul nuw nsw i64 %4907, 4194304
  %4940 = mul nuw nsw i64 %4911, 1048576
  %4941 = add nuw nsw i64 %4939, %4940
  %4942 = mul nuw nsw i64 %4915, 1024
  %4943 = add nuw nsw i64 %4941, %4942
  %4944 = add nuw nsw i64 %4943, %4919
  %4945 = getelementptr inbounds float, ptr %4938, i64 %4944
  store float %4937, ptr %4945, align 4
  %4946 = add i64 %4919, 1
  br label %4918

4947:                                             ; preds = %4918
  %4948 = add i64 %4915, 1
  br label %4914

4949:                                             ; preds = %4914
  %4950 = add i64 %4911, 1
  br label %4910

4951:                                             ; preds = %4910
  %4952 = add i64 %4907, 1
  br label %4906

4953:                                             ; preds = %4906
  br label %4954

4954:                                             ; preds = %5013, %4953
  %4955 = phi i64 [ %5014, %5013 ], [ 0, %4953 ]
  %4956 = icmp slt i64 %4955, 2
  br i1 %4956, label %4957, label %5015

4957:                                             ; preds = %4954
  br label %4958

4958:                                             ; preds = %5011, %4957
  %4959 = phi i64 [ %5012, %5011 ], [ 0, %4957 ]
  %4960 = icmp slt i64 %4959, 4
  br i1 %4960, label %4961, label %5013

4961:                                             ; preds = %4958
  br label %4962

4962:                                             ; preds = %5009, %4961
  %4963 = phi i64 [ %5010, %5009 ], [ 0, %4961 ]
  %4964 = icmp slt i64 %4963, 1024
  br i1 %4964, label %4965, label %5011

4965:                                             ; preds = %4962
  br label %4966

4966:                                             ; preds = %4969, %4965
  %4967 = phi i64 [ %5008, %4969 ], [ 0, %4965 ]
  %4968 = icmp slt i64 %4967, 1024
  br i1 %4968, label %4969, label %5009

4969:                                             ; preds = %4966
  %4970 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %4971 = mul nuw nsw i64 %4955, 4194304
  %4972 = mul nuw nsw i64 %4959, 1048576
  %4973 = add nuw nsw i64 %4971, %4972
  %4974 = mul nuw nsw i64 %4963, 1024
  %4975 = add nuw nsw i64 %4973, %4974
  %4976 = add nuw nsw i64 %4975, %4967
  %4977 = getelementptr inbounds float, ptr %4970, i64 %4976
  %4978 = load float, ptr %4977, align 4
  %4979 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1822, 1
  %4980 = mul nuw nsw i64 %4955, 4096
  %4981 = mul nuw nsw i64 %4959, 1024
  %4982 = add nuw nsw i64 %4980, %4981
  %4983 = add nuw nsw i64 %4982, %4963
  %4984 = getelementptr inbounds float, ptr %4979, i64 %4983
  %4985 = load float, ptr %4984, align 4
  %4986 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1783, 1
  %4987 = mul nuw nsw i64 %4955, 4096
  %4988 = mul nuw nsw i64 %4959, 1024
  %4989 = add nuw nsw i64 %4987, %4988
  %4990 = add nuw nsw i64 %4989, %4963
  %4991 = getelementptr inbounds i64, ptr %4986, i64 %4990
  %4992 = load i64, ptr %4991, align 4
  %4993 = call float @llvm.maximum.f32(float %4978, float %4985)
  %4994 = fcmp ogt float %4978, %4985
  %4995 = select i1 %4994, i64 %4967, i64 %4992
  %4996 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1822, 1
  %4997 = mul nuw nsw i64 %4955, 4096
  %4998 = mul nuw nsw i64 %4959, 1024
  %4999 = add nuw nsw i64 %4997, %4998
  %5000 = add nuw nsw i64 %4999, %4963
  %5001 = getelementptr inbounds float, ptr %4996, i64 %5000
  store float %4993, ptr %5001, align 4
  %5002 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1783, 1
  %5003 = mul nuw nsw i64 %4955, 4096
  %5004 = mul nuw nsw i64 %4959, 1024
  %5005 = add nuw nsw i64 %5003, %5004
  %5006 = add nuw nsw i64 %5005, %4963
  %5007 = getelementptr inbounds i64, ptr %5002, i64 %5006
  store i64 %4995, ptr %5007, align 4
  %5008 = add i64 %4967, 1
  br label %4966

5009:                                             ; preds = %4966
  %5010 = add i64 %4963, 1
  br label %4962

5011:                                             ; preds = %4962
  %5012 = add i64 %4959, 1
  br label %4958

5013:                                             ; preds = %4958
  %5014 = add i64 %4955, 1
  br label %4954

5015:                                             ; preds = %4954
  %5016 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1822, 0
  %5017 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %1822, 1
  %5018 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %5016, 0
  %5019 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5018, ptr %5017, 1
  %5020 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5019, i64 0, 2
  %5021 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5020, i64 2, 3, 0
  %5022 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5021, i64 4096, 4, 0
  %5023 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5022, i64 4, 3, 1
  %5024 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5023, i64 1024, 4, 1
  %5025 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5024, i64 1024, 3, 2
  %5026 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5025, i64 1, 4, 2
  %5027 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5026, i64 1, 3, 3
  %5028 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5027, i64 1, 4, 3
  br label %5029

5029:                                             ; preds = %5076, %5015
  %5030 = phi i64 [ %5077, %5076 ], [ 0, %5015 ]
  %5031 = icmp slt i64 %5030, 2
  br i1 %5031, label %5032, label %5078

5032:                                             ; preds = %5029
  br label %5033

5033:                                             ; preds = %5074, %5032
  %5034 = phi i64 [ %5075, %5074 ], [ 0, %5032 ]
  %5035 = icmp slt i64 %5034, 4
  br i1 %5035, label %5036, label %5076

5036:                                             ; preds = %5033
  br label %5037

5037:                                             ; preds = %5072, %5036
  %5038 = phi i64 [ %5073, %5072 ], [ 0, %5036 ]
  %5039 = icmp slt i64 %5038, 1024
  br i1 %5039, label %5040, label %5074

5040:                                             ; preds = %5037
  br label %5041

5041:                                             ; preds = %5044, %5040
  %5042 = phi i64 [ %5071, %5044 ], [ 0, %5040 ]
  %5043 = icmp slt i64 %5042, 1024
  br i1 %5043, label %5044, label %5072

5044:                                             ; preds = %5041
  %5045 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %5046 = mul nuw nsw i64 %5030, 4194304
  %5047 = mul nuw nsw i64 %5034, 1048576
  %5048 = add nuw nsw i64 %5046, %5047
  %5049 = mul nuw nsw i64 %5038, 1024
  %5050 = add nuw nsw i64 %5048, %5049
  %5051 = add nuw nsw i64 %5050, %5042
  %5052 = getelementptr inbounds float, ptr %5045, i64 %5051
  %5053 = load float, ptr %5052, align 4
  %5054 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5028, 1
  %5055 = mul nuw nsw i64 %5030, 4096
  %5056 = mul nuw nsw i64 %5034, 1024
  %5057 = add nuw nsw i64 %5055, %5056
  %5058 = add nuw nsw i64 %5057, %5038
  %5059 = add nuw nsw i64 %5058, 0
  %5060 = getelementptr inbounds float, ptr %5054, i64 %5059
  %5061 = load float, ptr %5060, align 4
  %5062 = fsub float %5053, %5061
  %5063 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %5064 = mul nuw nsw i64 %5030, 4194304
  %5065 = mul nuw nsw i64 %5034, 1048576
  %5066 = add nuw nsw i64 %5064, %5065
  %5067 = mul nuw nsw i64 %5038, 1024
  %5068 = add nuw nsw i64 %5066, %5067
  %5069 = add nuw nsw i64 %5068, %5042
  %5070 = getelementptr inbounds float, ptr %5063, i64 %5069
  store float %5062, ptr %5070, align 4
  %5071 = add i64 %5042, 1
  br label %5041

5072:                                             ; preds = %5041
  %5073 = add i64 %5038, 1
  br label %5037

5074:                                             ; preds = %5037
  %5075 = add i64 %5034, 1
  br label %5033

5076:                                             ; preds = %5033
  %5077 = add i64 %5030, 1
  br label %5029

5078:                                             ; preds = %5029
  br label %5079

5079:                                             ; preds = %5118, %5078
  %5080 = phi i64 [ %5119, %5118 ], [ 0, %5078 ]
  %5081 = icmp slt i64 %5080, 2
  br i1 %5081, label %5082, label %5120

5082:                                             ; preds = %5079
  br label %5083

5083:                                             ; preds = %5116, %5082
  %5084 = phi i64 [ %5117, %5116 ], [ 0, %5082 ]
  %5085 = icmp slt i64 %5084, 4
  br i1 %5085, label %5086, label %5118

5086:                                             ; preds = %5083
  br label %5087

5087:                                             ; preds = %5114, %5086
  %5088 = phi i64 [ %5115, %5114 ], [ 0, %5086 ]
  %5089 = icmp slt i64 %5088, 1024
  br i1 %5089, label %5090, label %5116

5090:                                             ; preds = %5087
  br label %5091

5091:                                             ; preds = %5094, %5090
  %5092 = phi i64 [ %5113, %5094 ], [ 0, %5090 ]
  %5093 = icmp slt i64 %5092, 1024
  br i1 %5093, label %5094, label %5114

5094:                                             ; preds = %5091
  %5095 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %5096 = mul nuw nsw i64 %5080, 4194304
  %5097 = mul nuw nsw i64 %5084, 1048576
  %5098 = add nuw nsw i64 %5096, %5097
  %5099 = mul nuw nsw i64 %5088, 1024
  %5100 = add nuw nsw i64 %5098, %5099
  %5101 = add nuw nsw i64 %5100, %5092
  %5102 = getelementptr inbounds float, ptr %5095, i64 %5101
  %5103 = load float, ptr %5102, align 4
  %5104 = call float @llvm.exp.f32(float %5103)
  %5105 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %5106 = mul nuw nsw i64 %5080, 4194304
  %5107 = mul nuw nsw i64 %5084, 1048576
  %5108 = add nuw nsw i64 %5106, %5107
  %5109 = mul nuw nsw i64 %5088, 1024
  %5110 = add nuw nsw i64 %5108, %5109
  %5111 = add nuw nsw i64 %5110, %5092
  %5112 = getelementptr inbounds float, ptr %5105, i64 %5111
  store float %5104, ptr %5112, align 4
  %5113 = add i64 %5092, 1
  br label %5091

5114:                                             ; preds = %5091
  %5115 = add i64 %5088, 1
  br label %5087

5116:                                             ; preds = %5087
  %5117 = add i64 %5084, 1
  br label %5083

5118:                                             ; preds = %5083
  %5119 = add i64 %5080, 1
  br label %5079

5120:                                             ; preds = %5079
  br label %5121

5121:                                             ; preds = %5167, %5120
  %5122 = phi i64 [ %5168, %5167 ], [ 0, %5120 ]
  %5123 = icmp slt i64 %5122, 2
  br i1 %5123, label %5124, label %5169

5124:                                             ; preds = %5121
  br label %5125

5125:                                             ; preds = %5165, %5124
  %5126 = phi i64 [ %5166, %5165 ], [ 0, %5124 ]
  %5127 = icmp slt i64 %5126, 4
  br i1 %5127, label %5128, label %5167

5128:                                             ; preds = %5125
  br label %5129

5129:                                             ; preds = %5163, %5128
  %5130 = phi i64 [ %5164, %5163 ], [ 0, %5128 ]
  %5131 = icmp slt i64 %5130, 1024
  br i1 %5131, label %5132, label %5165

5132:                                             ; preds = %5129
  br label %5133

5133:                                             ; preds = %5136, %5132
  %5134 = phi i64 [ %5162, %5136 ], [ 0, %5132 ]
  %5135 = icmp slt i64 %5134, 1024
  br i1 %5135, label %5136, label %5163

5136:                                             ; preds = %5133
  %5137 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %5138 = mul nuw nsw i64 %5122, 4194304
  %5139 = mul nuw nsw i64 %5126, 1048576
  %5140 = add nuw nsw i64 %5138, %5139
  %5141 = mul nuw nsw i64 %5130, 1024
  %5142 = add nuw nsw i64 %5140, %5141
  %5143 = add nuw nsw i64 %5142, %5134
  %5144 = getelementptr inbounds float, ptr %5137, i64 %5143
  %5145 = load float, ptr %5144, align 4
  %5146 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2086, 1
  %5147 = mul nuw nsw i64 %5122, 4096
  %5148 = mul nuw nsw i64 %5126, 1024
  %5149 = add nuw nsw i64 %5147, %5148
  %5150 = add nuw nsw i64 %5149, %5130
  %5151 = add nuw nsw i64 %5150, 0
  %5152 = getelementptr inbounds float, ptr %5146, i64 %5151
  %5153 = load float, ptr %5152, align 4
  %5154 = fadd float %5145, %5153
  %5155 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2086, 1
  %5156 = mul nuw nsw i64 %5122, 4096
  %5157 = mul nuw nsw i64 %5126, 1024
  %5158 = add nuw nsw i64 %5156, %5157
  %5159 = add nuw nsw i64 %5158, %5130
  %5160 = add nuw nsw i64 %5159, 0
  %5161 = getelementptr inbounds float, ptr %5155, i64 %5160
  store float %5154, ptr %5161, align 4
  %5162 = add i64 %5134, 1
  br label %5133

5163:                                             ; preds = %5133
  %5164 = add i64 %5130, 1
  br label %5129

5165:                                             ; preds = %5129
  %5166 = add i64 %5126, 1
  br label %5125

5167:                                             ; preds = %5125
  %5168 = add i64 %5122, 1
  br label %5121

5169:                                             ; preds = %5121
  br label %5170

5170:                                             ; preds = %5217, %5169
  %5171 = phi i64 [ %5218, %5217 ], [ 0, %5169 ]
  %5172 = icmp slt i64 %5171, 2
  br i1 %5172, label %5173, label %5219

5173:                                             ; preds = %5170
  br label %5174

5174:                                             ; preds = %5215, %5173
  %5175 = phi i64 [ %5216, %5215 ], [ 0, %5173 ]
  %5176 = icmp slt i64 %5175, 4
  br i1 %5176, label %5177, label %5217

5177:                                             ; preds = %5174
  br label %5178

5178:                                             ; preds = %5213, %5177
  %5179 = phi i64 [ %5214, %5213 ], [ 0, %5177 ]
  %5180 = icmp slt i64 %5179, 1024
  br i1 %5180, label %5181, label %5215

5181:                                             ; preds = %5178
  br label %5182

5182:                                             ; preds = %5185, %5181
  %5183 = phi i64 [ %5212, %5185 ], [ 0, %5181 ]
  %5184 = icmp slt i64 %5183, 1024
  br i1 %5184, label %5185, label %5213

5185:                                             ; preds = %5182
  %5186 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %5187 = mul nuw nsw i64 %5171, 4194304
  %5188 = mul nuw nsw i64 %5175, 1048576
  %5189 = add nuw nsw i64 %5187, %5188
  %5190 = mul nuw nsw i64 %5179, 1024
  %5191 = add nuw nsw i64 %5189, %5190
  %5192 = add nuw nsw i64 %5191, %5183
  %5193 = getelementptr inbounds float, ptr %5186, i64 %5192
  %5194 = load float, ptr %5193, align 4
  %5195 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2086, 1
  %5196 = mul nuw nsw i64 %5171, 4096
  %5197 = mul nuw nsw i64 %5175, 1024
  %5198 = add nuw nsw i64 %5196, %5197
  %5199 = add nuw nsw i64 %5198, %5179
  %5200 = add nuw nsw i64 %5199, 0
  %5201 = getelementptr inbounds float, ptr %5195, i64 %5200
  %5202 = load float, ptr %5201, align 4
  %5203 = fdiv float %5194, %5202
  %5204 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %5205 = mul nuw nsw i64 %5171, 4194304
  %5206 = mul nuw nsw i64 %5175, 1048576
  %5207 = add nuw nsw i64 %5205, %5206
  %5208 = mul nuw nsw i64 %5179, 1024
  %5209 = add nuw nsw i64 %5207, %5208
  %5210 = add nuw nsw i64 %5209, %5183
  %5211 = getelementptr inbounds float, ptr %5204, i64 %5210
  store float %5203, ptr %5211, align 4
  %5212 = add i64 %5183, 1
  br label %5182

5213:                                             ; preds = %5182
  %5214 = add i64 %5179, 1
  br label %5178

5215:                                             ; preds = %5178
  %5216 = add i64 %5175, 1
  br label %5174

5217:                                             ; preds = %5174
  %5218 = add i64 %5171, 1
  br label %5170

5219:                                             ; preds = %5170
  %5220 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 0
  %5221 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1612, 1
  %5222 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %5220, 0
  %5223 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5222, ptr %5221, 1
  %5224 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5223, i64 0, 2
  %5225 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5224, i64 8, 3, 0
  %5226 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5225, i64 1048576, 4, 0
  %5227 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5226, i64 1024, 3, 1
  %5228 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5227, i64 1024, 4, 1
  %5229 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5228, i64 1024, 3, 2
  %5230 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5229, i64 1, 4, 2
  %5231 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1294, 0
  %5232 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %1294, 1
  %5233 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %5231, 0
  %5234 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5233, ptr %5232, 1
  %5235 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5234, i64 0, 2
  %5236 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5235, i64 8, 3, 0
  %5237 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5236, i64 32768, 4, 0
  %5238 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5237, i64 1024, 3, 1
  %5239 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5238, i64 32, 4, 1
  %5240 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5239, i64 32, 3, 2
  %5241 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5240, i64 1, 4, 2
  %5242 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5230, 0
  %5243 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5230, 1
  %5244 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5230, 2
  %5245 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5230, 3, 0
  %5246 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5230, 3, 1
  %5247 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5230, 3, 2
  %5248 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5230, 4, 0
  %5249 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5230, 4, 1
  %5250 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5230, 4, 2
  %5251 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5241, 0
  %5252 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5241, 1
  %5253 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5241, 2
  %5254 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5241, 3, 0
  %5255 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5241, 3, 1
  %5256 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5241, 3, 2
  %5257 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5241, 4, 0
  %5258 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5241, 4, 1
  %5259 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5241, 4, 2
  %5260 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2285, 0
  %5261 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2285, 1
  %5262 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2285, 2
  %5263 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2285, 3, 0
  %5264 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2285, 3, 1
  %5265 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2285, 3, 2
  %5266 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2285, 4, 0
  %5267 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2285, 4, 1
  %5268 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2285, 4, 2
  call void @ukernel_bmm(ptr %5242, ptr %5243, i64 %5244, i64 %5245, i64 %5246, i64 %5247, i64 %5248, i64 %5249, i64 %5250, ptr %5251, ptr %5252, i64 %5253, i64 %5254, i64 %5255, i64 %5256, i64 %5257, i64 %5258, i64 %5259, ptr %5260, ptr %5261, i64 %5262, i64 %5263, i64 %5264, i64 %5265, i64 %5266, i64 %5267, i64 %5268)
  %5269 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2285, 0
  %5270 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2285, 1
  %5271 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } poison, ptr %5269, 0
  %5272 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5271, ptr %5270, 1
  %5273 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5272, i64 0, 2
  %5274 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5273, i64 2, 3, 0
  %5275 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5274, i64 131072, 4, 0
  %5276 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5275, i64 4, 3, 1
  %5277 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5276, i64 32768, 4, 1
  %5278 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5277, i64 1024, 3, 2
  %5279 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5278, i64 32, 4, 2
  %5280 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5279, i64 32, 3, 3
  %5281 = insertvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5280, i64 1, 4, 3
  br label %5282

5282:                                             ; preds = %5320, %5219
  %5283 = phi i64 [ %5321, %5320 ], [ 0, %5219 ]
  %5284 = icmp slt i64 %5283, 2
  br i1 %5284, label %5285, label %5322

5285:                                             ; preds = %5282
  br label %5286

5286:                                             ; preds = %5318, %5285
  %5287 = phi i64 [ %5319, %5318 ], [ 0, %5285 ]
  %5288 = icmp slt i64 %5287, 1024
  br i1 %5288, label %5289, label %5320

5289:                                             ; preds = %5286
  br label %5290

5290:                                             ; preds = %5316, %5289
  %5291 = phi i64 [ %5317, %5316 ], [ 0, %5289 ]
  %5292 = icmp slt i64 %5291, 4
  br i1 %5292, label %5293, label %5318

5293:                                             ; preds = %5290
  br label %5294

5294:                                             ; preds = %5297, %5293
  %5295 = phi i64 [ %5315, %5297 ], [ 0, %5293 ]
  %5296 = icmp slt i64 %5295, 32
  br i1 %5296, label %5297, label %5316

5297:                                             ; preds = %5294
  %5298 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %5281, 1
  %5299 = mul nuw nsw i64 %5283, 131072
  %5300 = mul nuw nsw i64 %5291, 32768
  %5301 = add nuw nsw i64 %5299, %5300
  %5302 = mul nuw nsw i64 %5287, 32
  %5303 = add nuw nsw i64 %5301, %5302
  %5304 = add nuw nsw i64 %5303, %5295
  %5305 = getelementptr inbounds float, ptr %5298, i64 %5304
  %5306 = load float, ptr %5305, align 4
  %5307 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2394, 1
  %5308 = mul nuw nsw i64 %5283, 131072
  %5309 = mul nuw nsw i64 %5287, 128
  %5310 = add nuw nsw i64 %5308, %5309
  %5311 = mul nuw nsw i64 %5291, 32
  %5312 = add nuw nsw i64 %5310, %5311
  %5313 = add nuw nsw i64 %5312, %5295
  %5314 = getelementptr inbounds float, ptr %5307, i64 %5313
  store float %5306, ptr %5314, align 4
  %5315 = add i64 %5295, 1
  br label %5294

5316:                                             ; preds = %5294
  %5317 = add i64 %5291, 1
  br label %5290

5318:                                             ; preds = %5290
  %5319 = add i64 %5287, 1
  br label %5286

5320:                                             ; preds = %5286
  %5321 = add i64 %5283, 1
  br label %5282

5322:                                             ; preds = %5282
  %5323 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2394, 0
  %5324 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %2394, 1
  %5325 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %5323, 0
  %5326 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5325, ptr %5324, 1
  %5327 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5326, i64 0, 2
  %5328 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5327, i64 2, 3, 0
  %5329 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5328, i64 131072, 4, 0
  %5330 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5329, i64 1024, 3, 1
  %5331 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5330, i64 128, 4, 1
  %5332 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5331, i64 128, 3, 2
  %5333 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5332, i64 1, 4, 2
  br label %5334

5334:                                             ; preds = %5357, %5322
  %5335 = phi i64 [ %5358, %5357 ], [ 0, %5322 ]
  %5336 = icmp slt i64 %5335, 128
  br i1 %5336, label %5337, label %5359

5337:                                             ; preds = %5334
  br label %5338

5338:                                             ; preds = %5341, %5337
  %5339 = phi i64 [ %5356, %5341 ], [ 0, %5337 ]
  %5340 = icmp slt i64 %5339, 128
  br i1 %5340, label %5341, label %5357

5341:                                             ; preds = %5338
  %5342 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %231, 1
  %5343 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %231, 2
  %5344 = getelementptr float, ptr %5342, i64 %5343
  %5345 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %231, 4, 0
  %5346 = mul nuw nsw i64 %5339, %5345
  %5347 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %231, 4, 1
  %5348 = mul nuw nsw i64 %5335, %5347
  %5349 = add nuw nsw i64 %5346, %5348
  %5350 = getelementptr inbounds float, ptr %5344, i64 %5349
  %5351 = load float, ptr %5350, align 4
  %5352 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2459, 1
  %5353 = mul nuw nsw i64 %5335, 128
  %5354 = add nuw nsw i64 %5353, %5339
  %5355 = getelementptr inbounds float, ptr %5352, i64 %5354
  store float %5351, ptr %5355, align 4
  %5356 = add i64 %5339, 1
  br label %5338

5357:                                             ; preds = %5338
  %5358 = add i64 %5335, 1
  br label %5334

5359:                                             ; preds = %5334
  br label %5360

5360:                                             ; preds = %5386, %5359
  %5361 = phi i64 [ %5387, %5386 ], [ 0, %5359 ]
  %5362 = icmp slt i64 %5361, 2
  br i1 %5362, label %5363, label %5388

5363:                                             ; preds = %5360
  br label %5364

5364:                                             ; preds = %5384, %5363
  %5365 = phi i64 [ %5385, %5384 ], [ 0, %5363 ]
  %5366 = icmp slt i64 %5365, 128
  br i1 %5366, label %5367, label %5386

5367:                                             ; preds = %5364
  br label %5368

5368:                                             ; preds = %5371, %5367
  %5369 = phi i64 [ %5383, %5371 ], [ 0, %5367 ]
  %5370 = icmp slt i64 %5369, 128
  br i1 %5370, label %5371, label %5384

5371:                                             ; preds = %5368
  %5372 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %2459, 1
  %5373 = mul nuw nsw i64 %5365, 128
  %5374 = add nuw nsw i64 %5373, %5369
  %5375 = getelementptr inbounds float, ptr %5372, i64 %5374
  %5376 = load float, ptr %5375, align 4
  %5377 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 1
  %5378 = mul nuw nsw i64 %5361, 16384
  %5379 = mul nuw nsw i64 %5365, 128
  %5380 = add nuw nsw i64 %5378, %5379
  %5381 = add nuw nsw i64 %5380, %5369
  %5382 = getelementptr inbounds float, ptr %5377, i64 %5381
  store float %5376, ptr %5382, align 4
  %5383 = add i64 %5369, 1
  br label %5368

5384:                                             ; preds = %5368
  %5385 = add i64 %5365, 1
  br label %5364

5386:                                             ; preds = %5364
  %5387 = add i64 %5361, 1
  br label %5360

5388:                                             ; preds = %5360
  %5389 = call ptr @malloc(i64 1048640)
  %5390 = ptrtoint ptr %5389 to i64
  %5391 = add i64 %5390, 63
  %5392 = urem i64 %5391, 64
  %5393 = sub i64 %5391, %5392
  %5394 = inttoptr i64 %5393 to ptr
  %5395 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %5389, 0
  %5396 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5395, ptr %5394, 1
  %5397 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5396, i64 0, 2
  %5398 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5397, i64 2, 3, 0
  %5399 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5398, i64 1024, 3, 1
  %5400 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5399, i64 128, 3, 2
  %5401 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5400, i64 131072, 4, 0
  %5402 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5401, i64 128, 4, 1
  %5403 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5402, i64 1, 4, 2
  %5404 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 3, 0
  %5405 = mul i64 1, %5404
  %5406 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 3, 1
  %5407 = mul i64 %5405, %5406
  %5408 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 3, 2
  %5409 = mul i64 %5407, %5408
  %5410 = mul i64 %5409, 4
  %5411 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 1
  %5412 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 2
  %5413 = getelementptr float, ptr %5411, i64 %5412
  %5414 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5403, 1
  %5415 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5403, 2
  %5416 = getelementptr float, ptr %5414, i64 %5415
  call void @llvm.memcpy.p0.p0.i64(ptr %5416, ptr %5413, i64 %5410, i1 false)
  %5417 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5333, 0
  %5418 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5333, 1
  %5419 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5333, 2
  %5420 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5333, 3, 0
  %5421 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5333, 3, 1
  %5422 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5333, 3, 2
  %5423 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5333, 4, 0
  %5424 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5333, 4, 1
  %5425 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5333, 4, 2
  %5426 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 0
  %5427 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 1
  %5428 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 2
  %5429 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 3, 0
  %5430 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 3, 1
  %5431 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 3, 2
  %5432 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 4, 0
  %5433 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 4, 1
  %5434 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2500, 4, 2
  %5435 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5403, 0
  %5436 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5403, 1
  %5437 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5403, 2
  %5438 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5403, 3, 0
  %5439 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5403, 3, 1
  %5440 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5403, 3, 2
  %5441 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5403, 4, 0
  %5442 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5403, 4, 1
  %5443 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5403, 4, 2
  call void @ukernel_bmm(ptr %5417, ptr %5418, i64 %5419, i64 %5420, i64 %5421, i64 %5422, i64 %5423, i64 %5424, i64 %5425, ptr %5426, ptr %5427, i64 %5428, i64 %5429, i64 %5430, i64 %5431, i64 %5432, i64 %5433, i64 %5434, ptr %5435, ptr %5436, i64 %5437, i64 %5438, i64 %5439, i64 %5440, i64 %5441, i64 %5442, i64 %5443)
  br label %5444

5444:                                             ; preds = %5486, %5388
  %5445 = phi i64 [ %5487, %5486 ], [ 0, %5388 ]
  %5446 = icmp slt i64 %5445, 2
  br i1 %5446, label %5447, label %5488

5447:                                             ; preds = %5444
  br label %5448

5448:                                             ; preds = %5484, %5447
  %5449 = phi i64 [ %5485, %5484 ], [ 0, %5447 ]
  %5450 = icmp slt i64 %5449, 1024
  br i1 %5450, label %5451, label %5486

5451:                                             ; preds = %5448
  br label %5452

5452:                                             ; preds = %5455, %5451
  %5453 = phi i64 [ %5483, %5455 ], [ 0, %5451 ]
  %5454 = icmp slt i64 %5453, 128
  br i1 %5454, label %5455, label %5484

5455:                                             ; preds = %5452
  %5456 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5403, 1
  %5457 = mul nuw nsw i64 %5445, 131072
  %5458 = mul nuw nsw i64 %5449, 128
  %5459 = add nuw nsw i64 %5457, %5458
  %5460 = add nuw nsw i64 %5459, %5453
  %5461 = getelementptr inbounds float, ptr %5456, i64 %5460
  %5462 = load float, ptr %5461, align 4
  %5463 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %224, 1
  %5464 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %224, 2
  %5465 = getelementptr float, ptr %5463, i64 %5464
  %5466 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %224, 4, 0
  %5467 = mul nuw nsw i64 %5453, %5466
  %5468 = getelementptr inbounds float, ptr %5465, i64 %5467
  %5469 = load float, ptr %5468, align 4
  %5470 = fadd float %5462, %5469
  %5471 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %5472 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %5473 = getelementptr float, ptr %5471, i64 %5472
  %5474 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %5475 = mul nuw nsw i64 %5445, %5474
  %5476 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %5477 = mul nuw nsw i64 %5449, %5476
  %5478 = add nuw nsw i64 %5475, %5477
  %5479 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %5480 = mul nuw nsw i64 %5453, %5479
  %5481 = add nuw nsw i64 %5478, %5480
  %5482 = getelementptr inbounds float, ptr %5473, i64 %5481
  store float %5470, ptr %5482, align 4
  %5483 = add i64 %5453, 1
  br label %5452

5484:                                             ; preds = %5452
  %5485 = add i64 %5449, 1
  br label %5448

5486:                                             ; preds = %5448
  %5487 = add i64 %5445, 1
  br label %5444

5488:                                             ; preds = %5444
  %5489 = call ptr @malloc(i64 1048640)
  %5490 = ptrtoint ptr %5489 to i64
  %5491 = add i64 %5490, 63
  %5492 = urem i64 %5491, 64
  %5493 = sub i64 %5491, %5492
  %5494 = inttoptr i64 %5493 to ptr
  %5495 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %5489, 0
  %5496 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5495, ptr %5494, 1
  %5497 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5496, i64 0, 2
  %5498 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5497, i64 2, 3, 0
  %5499 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5498, i64 1024, 3, 1
  %5500 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5499, i64 128, 3, 2
  %5501 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5500, i64 131072, 4, 0
  %5502 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5501, i64 128, 4, 1
  %5503 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5502, i64 1, 4, 2
  br label %5504

5504:                                             ; preds = %5546, %5488
  %5505 = phi i64 [ %5547, %5546 ], [ 0, %5488 ]
  %5506 = icmp slt i64 %5505, 2
  br i1 %5506, label %5507, label %5548

5507:                                             ; preds = %5504
  br label %5508

5508:                                             ; preds = %5544, %5507
  %5509 = phi i64 [ %5545, %5544 ], [ 0, %5507 ]
  %5510 = icmp slt i64 %5509, 1024
  br i1 %5510, label %5511, label %5546

5511:                                             ; preds = %5508
  br label %5512

5512:                                             ; preds = %5515, %5511
  %5513 = phi i64 [ %5543, %5515 ], [ 0, %5511 ]
  %5514 = icmp slt i64 %5513, 128
  br i1 %5514, label %5515, label %5544

5515:                                             ; preds = %5512
  %5516 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3802, 1
  %5517 = mul nuw nsw i64 %5505, 131072
  %5518 = mul nuw nsw i64 %5509, 128
  %5519 = add nuw nsw i64 %5517, %5518
  %5520 = add nuw nsw i64 %5519, %5513
  %5521 = getelementptr inbounds float, ptr %5516, i64 %5520
  %5522 = load float, ptr %5521, align 4
  %5523 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %5524 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %5525 = getelementptr float, ptr %5523, i64 %5524
  %5526 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %5527 = mul nuw nsw i64 %5505, %5526
  %5528 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %5529 = mul nuw nsw i64 %5509, %5528
  %5530 = add nuw nsw i64 %5527, %5529
  %5531 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %5532 = mul nuw nsw i64 %5513, %5531
  %5533 = add nuw nsw i64 %5530, %5532
  %5534 = getelementptr inbounds float, ptr %5525, i64 %5533
  %5535 = load float, ptr %5534, align 4
  %5536 = fadd float %5522, %5535
  %5537 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5503, 1
  %5538 = mul nuw nsw i64 %5505, 131072
  %5539 = mul nuw nsw i64 %5509, 128
  %5540 = add nuw nsw i64 %5538, %5539
  %5541 = add nuw nsw i64 %5540, %5513
  %5542 = getelementptr inbounds float, ptr %5537, i64 %5541
  store float %5536, ptr %5542, align 4
  %5543 = add i64 %5513, 1
  br label %5512

5544:                                             ; preds = %5512
  %5545 = add i64 %5509, 1
  br label %5508

5546:                                             ; preds = %5508
  %5547 = add i64 %5505, 1
  br label %5504

5548:                                             ; preds = %5504
  %5549 = call ptr @malloc(i64 8256)
  %5550 = ptrtoint ptr %5549 to i64
  %5551 = add i64 %5550, 63
  %5552 = urem i64 %5551, 64
  %5553 = sub i64 %5551, %5552
  %5554 = inttoptr i64 %5553 to ptr
  %5555 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %5549, 0
  %5556 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5555, ptr %5554, 1
  %5557 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5556, i64 0, 2
  %5558 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5557, i64 2, 3, 0
  %5559 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5558, i64 1024, 3, 1
  %5560 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5559, i64 1, 3, 2
  %5561 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5560, i64 1024, 4, 0
  %5562 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5561, i64 1, 4, 1
  %5563 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5562, i64 1, 4, 2
  %5564 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 0
  %5565 = mul i64 1, %5564
  %5566 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 1
  %5567 = mul i64 %5565, %5566
  %5568 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 3, 2
  %5569 = mul i64 %5567, %5568
  %5570 = mul i64 %5569, 4
  %5571 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 1
  %5572 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 2
  %5573 = getelementptr float, ptr %5571, i64 %5572
  %5574 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5563, 1
  %5575 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5563, 2
  %5576 = getelementptr float, ptr %5574, i64 %5575
  call void @llvm.memcpy.p0.p0.i64(ptr %5576, ptr %5573, i64 %5570, i1 false)
  br label %5577

5577:                                             ; preds = %5611, %5548
  %5578 = phi i64 [ %5612, %5611 ], [ 0, %5548 ]
  %5579 = icmp slt i64 %5578, 2
  br i1 %5579, label %5580, label %5613

5580:                                             ; preds = %5577
  br label %5581

5581:                                             ; preds = %5609, %5580
  %5582 = phi i64 [ %5610, %5609 ], [ 0, %5580 ]
  %5583 = icmp slt i64 %5582, 1024
  br i1 %5583, label %5584, label %5611

5584:                                             ; preds = %5581
  br label %5585

5585:                                             ; preds = %5588, %5584
  %5586 = phi i64 [ %5608, %5588 ], [ 0, %5584 ]
  %5587 = icmp slt i64 %5586, 128
  br i1 %5587, label %5588, label %5609

5588:                                             ; preds = %5585
  %5589 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5503, 1
  %5590 = mul nuw nsw i64 %5578, 131072
  %5591 = mul nuw nsw i64 %5582, 128
  %5592 = add nuw nsw i64 %5590, %5591
  %5593 = add nuw nsw i64 %5592, %5586
  %5594 = getelementptr inbounds float, ptr %5589, i64 %5593
  %5595 = load float, ptr %5594, align 4
  %5596 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5563, 1
  %5597 = mul nuw nsw i64 %5578, 1024
  %5598 = add nuw nsw i64 %5597, %5582
  %5599 = add nuw nsw i64 %5598, 0
  %5600 = getelementptr inbounds float, ptr %5596, i64 %5599
  %5601 = load float, ptr %5600, align 4
  %5602 = fadd float %5595, %5601
  %5603 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5563, 1
  %5604 = mul nuw nsw i64 %5578, 1024
  %5605 = add nuw nsw i64 %5604, %5582
  %5606 = add nuw nsw i64 %5605, 0
  %5607 = getelementptr inbounds float, ptr %5603, i64 %5606
  store float %5602, ptr %5607, align 4
  %5608 = add i64 %5586, 1
  br label %5585

5609:                                             ; preds = %5585
  %5610 = add i64 %5582, 1
  br label %5581

5611:                                             ; preds = %5581
  %5612 = add i64 %5578, 1
  br label %5577

5613:                                             ; preds = %5577
  br label %5614

5614:                                             ; preds = %5641, %5613
  %5615 = phi i64 [ %5642, %5641 ], [ 0, %5613 ]
  %5616 = icmp slt i64 %5615, 2
  br i1 %5616, label %5617, label %5643

5617:                                             ; preds = %5614
  br label %5618

5618:                                             ; preds = %5639, %5617
  %5619 = phi i64 [ %5640, %5639 ], [ 0, %5617 ]
  %5620 = icmp slt i64 %5619, 1024
  br i1 %5620, label %5621, label %5641

5621:                                             ; preds = %5618
  br label %5622

5622:                                             ; preds = %5625, %5621
  %5623 = phi i64 [ %5638, %5625 ], [ 0, %5621 ]
  %5624 = icmp slt i64 %5623, 1
  br i1 %5624, label %5625, label %5639

5625:                                             ; preds = %5622
  %5626 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5563, 1
  %5627 = mul nuw nsw i64 %5615, 1024
  %5628 = add nuw nsw i64 %5627, %5619
  %5629 = add nuw nsw i64 %5628, %5623
  %5630 = getelementptr inbounds float, ptr %5626, i64 %5629
  %5631 = load float, ptr %5630, align 4
  %5632 = fdiv float %5631, 1.280000e+02
  %5633 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %5634 = mul nuw nsw i64 %5615, 1024
  %5635 = add nuw nsw i64 %5634, %5619
  %5636 = add nuw nsw i64 %5635, %5623
  %5637 = getelementptr inbounds float, ptr %5633, i64 %5636
  store float %5632, ptr %5637, align 4
  %5638 = add i64 %5623, 1
  br label %5622

5639:                                             ; preds = %5622
  %5640 = add i64 %5619, 1
  br label %5618

5641:                                             ; preds = %5618
  %5642 = add i64 %5615, 1
  br label %5614

5643:                                             ; preds = %5614
  %5644 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 0
  %5645 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %5646 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %5644, 0
  %5647 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5646, ptr %5645, 1
  %5648 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5647, i64 0, 2
  %5649 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5648, i64 2, 3, 0
  %5650 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5649, i64 1024, 4, 0
  %5651 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5650, i64 1024, 3, 1
  %5652 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5651, i64 1, 4, 1
  br label %5653

5653:                                             ; preds = %5685, %5643
  %5654 = phi i64 [ %5686, %5685 ], [ 0, %5643 ]
  %5655 = icmp slt i64 %5654, 2
  br i1 %5655, label %5656, label %5687

5656:                                             ; preds = %5653
  br label %5657

5657:                                             ; preds = %5683, %5656
  %5658 = phi i64 [ %5684, %5683 ], [ 0, %5656 ]
  %5659 = icmp slt i64 %5658, 1024
  br i1 %5659, label %5660, label %5685

5660:                                             ; preds = %5657
  br label %5661

5661:                                             ; preds = %5664, %5660
  %5662 = phi i64 [ %5682, %5664 ], [ 0, %5660 ]
  %5663 = icmp slt i64 %5662, 128
  br i1 %5663, label %5664, label %5683

5664:                                             ; preds = %5661
  %5665 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5652, 1
  %5666 = mul nuw nsw i64 %5654, 1024
  %5667 = add nuw nsw i64 %5666, %5658
  %5668 = getelementptr inbounds float, ptr %5665, i64 %5667
  %5669 = load float, ptr %5668, align 4
  %5670 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %5671 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %5672 = getelementptr float, ptr %5670, i64 %5671
  %5673 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %5674 = mul nuw nsw i64 %5654, %5673
  %5675 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %5676 = mul nuw nsw i64 %5658, %5675
  %5677 = add nuw nsw i64 %5674, %5676
  %5678 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %5679 = mul nuw nsw i64 %5662, %5678
  %5680 = add nuw nsw i64 %5677, %5679
  %5681 = getelementptr inbounds float, ptr %5672, i64 %5680
  store float %5669, ptr %5681, align 4
  %5682 = add i64 %5662, 1
  br label %5661

5683:                                             ; preds = %5661
  %5684 = add i64 %5658, 1
  br label %5657

5685:                                             ; preds = %5657
  %5686 = add i64 %5654, 1
  br label %5653

5687:                                             ; preds = %5653
  %5688 = call ptr @malloc(i64 1048640)
  %5689 = ptrtoint ptr %5688 to i64
  %5690 = add i64 %5689, 63
  %5691 = urem i64 %5690, 64
  %5692 = sub i64 %5690, %5691
  %5693 = inttoptr i64 %5692 to ptr
  %5694 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } poison, ptr %5688, 0
  %5695 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5694, ptr %5693, 1
  %5696 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5695, i64 0, 2
  %5697 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5696, i64 2, 3, 0
  %5698 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5697, i64 1024, 3, 1
  %5699 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5698, i64 128, 3, 2
  %5700 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5699, i64 131072, 4, 0
  %5701 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5700, i64 128, 4, 1
  %5702 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5701, i64 1, 4, 2
  br label %5703

5703:                                             ; preds = %5745, %5687
  %5704 = phi i64 [ %5746, %5745 ], [ 0, %5687 ]
  %5705 = icmp slt i64 %5704, 2
  br i1 %5705, label %5706, label %5747

5706:                                             ; preds = %5703
  br label %5707

5707:                                             ; preds = %5743, %5706
  %5708 = phi i64 [ %5744, %5743 ], [ 0, %5706 ]
  %5709 = icmp slt i64 %5708, 1024
  br i1 %5709, label %5710, label %5745

5710:                                             ; preds = %5707
  br label %5711

5711:                                             ; preds = %5714, %5710
  %5712 = phi i64 [ %5742, %5714 ], [ 0, %5710 ]
  %5713 = icmp slt i64 %5712, 128
  br i1 %5713, label %5714, label %5743

5714:                                             ; preds = %5711
  %5715 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5503, 1
  %5716 = mul nuw nsw i64 %5704, 131072
  %5717 = mul nuw nsw i64 %5708, 128
  %5718 = add nuw nsw i64 %5716, %5717
  %5719 = add nuw nsw i64 %5718, %5712
  %5720 = getelementptr inbounds float, ptr %5715, i64 %5719
  %5721 = load float, ptr %5720, align 4
  %5722 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %5723 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %5724 = getelementptr float, ptr %5722, i64 %5723
  %5725 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %5726 = mul nuw nsw i64 %5704, %5725
  %5727 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %5728 = mul nuw nsw i64 %5708, %5727
  %5729 = add nuw nsw i64 %5726, %5728
  %5730 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %5731 = mul nuw nsw i64 %5712, %5730
  %5732 = add nuw nsw i64 %5729, %5731
  %5733 = getelementptr inbounds float, ptr %5724, i64 %5732
  %5734 = load float, ptr %5733, align 4
  %5735 = fsub float %5721, %5734
  %5736 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5702, 1
  %5737 = mul nuw nsw i64 %5704, 131072
  %5738 = mul nuw nsw i64 %5708, 128
  %5739 = add nuw nsw i64 %5737, %5738
  %5740 = add nuw nsw i64 %5739, %5712
  %5741 = getelementptr inbounds float, ptr %5736, i64 %5740
  store float %5735, ptr %5741, align 4
  %5742 = add i64 %5712, 1
  br label %5711

5743:                                             ; preds = %5711
  %5744 = add i64 %5708, 1
  br label %5707

5745:                                             ; preds = %5707
  %5746 = add i64 %5704, 1
  br label %5703

5747:                                             ; preds = %5703
  br label %5748

5748:                                             ; preds = %5790, %5747
  %5749 = phi i64 [ %5791, %5790 ], [ 0, %5747 ]
  %5750 = icmp slt i64 %5749, 2
  br i1 %5750, label %5751, label %5792

5751:                                             ; preds = %5748
  br label %5752

5752:                                             ; preds = %5788, %5751
  %5753 = phi i64 [ %5789, %5788 ], [ 0, %5751 ]
  %5754 = icmp slt i64 %5753, 1024
  br i1 %5754, label %5755, label %5790

5755:                                             ; preds = %5752
  br label %5756

5756:                                             ; preds = %5759, %5755
  %5757 = phi i64 [ %5787, %5759 ], [ 0, %5755 ]
  %5758 = icmp slt i64 %5757, 128
  br i1 %5758, label %5759, label %5788

5759:                                             ; preds = %5756
  %5760 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5702, 1
  %5761 = mul nuw nsw i64 %5749, 131072
  %5762 = mul nuw nsw i64 %5753, 128
  %5763 = add nuw nsw i64 %5761, %5762
  %5764 = add nuw nsw i64 %5763, %5757
  %5765 = getelementptr inbounds float, ptr %5760, i64 %5764
  %5766 = load float, ptr %5765, align 4
  %5767 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5702, 1
  %5768 = mul nuw nsw i64 %5749, 131072
  %5769 = mul nuw nsw i64 %5753, 128
  %5770 = add nuw nsw i64 %5768, %5769
  %5771 = add nuw nsw i64 %5770, %5757
  %5772 = getelementptr inbounds float, ptr %5767, i64 %5771
  %5773 = load float, ptr %5772, align 4
  %5774 = fmul float %5766, %5773
  %5775 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %5776 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %5777 = getelementptr float, ptr %5775, i64 %5776
  %5778 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %5779 = mul nuw nsw i64 %5749, %5778
  %5780 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %5781 = mul nuw nsw i64 %5753, %5780
  %5782 = add nuw nsw i64 %5779, %5781
  %5783 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %5784 = mul nuw nsw i64 %5757, %5783
  %5785 = add nuw nsw i64 %5782, %5784
  %5786 = getelementptr inbounds float, ptr %5777, i64 %5785
  store float %5774, ptr %5786, align 4
  %5787 = add i64 %5757, 1
  br label %5756

5788:                                             ; preds = %5756
  %5789 = add i64 %5753, 1
  br label %5752

5790:                                             ; preds = %5752
  %5791 = add i64 %5749, 1
  br label %5748

5792:                                             ; preds = %5748
  br label %5793

5793:                                             ; preds = %5833, %5792
  %5794 = phi i64 [ %5834, %5833 ], [ 0, %5792 ]
  %5795 = icmp slt i64 %5794, 2
  br i1 %5795, label %5796, label %5835

5796:                                             ; preds = %5793
  br label %5797

5797:                                             ; preds = %5831, %5796
  %5798 = phi i64 [ %5832, %5831 ], [ 0, %5796 ]
  %5799 = icmp slt i64 %5798, 1024
  br i1 %5799, label %5800, label %5833

5800:                                             ; preds = %5797
  br label %5801

5801:                                             ; preds = %5804, %5800
  %5802 = phi i64 [ %5830, %5804 ], [ 0, %5800 ]
  %5803 = icmp slt i64 %5802, 128
  br i1 %5803, label %5804, label %5831

5804:                                             ; preds = %5801
  %5805 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %5806 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %5807 = getelementptr float, ptr %5805, i64 %5806
  %5808 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %5809 = mul nuw nsw i64 %5794, %5808
  %5810 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %5811 = mul nuw nsw i64 %5798, %5810
  %5812 = add nuw nsw i64 %5809, %5811
  %5813 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %5814 = mul nuw nsw i64 %5802, %5813
  %5815 = add nuw nsw i64 %5812, %5814
  %5816 = getelementptr inbounds float, ptr %5807, i64 %5815
  %5817 = load float, ptr %5816, align 4
  %5818 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 1
  %5819 = mul nuw nsw i64 %5794, 1024
  %5820 = add nuw nsw i64 %5819, %5798
  %5821 = add nuw nsw i64 %5820, 0
  %5822 = getelementptr inbounds float, ptr %5818, i64 %5821
  %5823 = load float, ptr %5822, align 4
  %5824 = fadd float %5817, %5823
  %5825 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 1
  %5826 = mul nuw nsw i64 %5794, 1024
  %5827 = add nuw nsw i64 %5826, %5798
  %5828 = add nuw nsw i64 %5827, 0
  %5829 = getelementptr inbounds float, ptr %5825, i64 %5828
  store float %5824, ptr %5829, align 4
  %5830 = add i64 %5802, 1
  br label %5801

5831:                                             ; preds = %5801
  %5832 = add i64 %5798, 1
  br label %5797

5833:                                             ; preds = %5797
  %5834 = add i64 %5794, 1
  br label %5793

5835:                                             ; preds = %5793
  br label %5836

5836:                                             ; preds = %5863, %5835
  %5837 = phi i64 [ %5864, %5863 ], [ 0, %5835 ]
  %5838 = icmp slt i64 %5837, 2
  br i1 %5838, label %5839, label %5865

5839:                                             ; preds = %5836
  br label %5840

5840:                                             ; preds = %5861, %5839
  %5841 = phi i64 [ %5862, %5861 ], [ 0, %5839 ]
  %5842 = icmp slt i64 %5841, 1024
  br i1 %5842, label %5843, label %5863

5843:                                             ; preds = %5840
  br label %5844

5844:                                             ; preds = %5847, %5843
  %5845 = phi i64 [ %5860, %5847 ], [ 0, %5843 ]
  %5846 = icmp slt i64 %5845, 1
  br i1 %5846, label %5847, label %5861

5847:                                             ; preds = %5844
  %5848 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %382, 1
  %5849 = mul nuw nsw i64 %5837, 1024
  %5850 = add nuw nsw i64 %5849, %5841
  %5851 = add nuw nsw i64 %5850, %5845
  %5852 = getelementptr inbounds float, ptr %5848, i64 %5851
  %5853 = load float, ptr %5852, align 4
  %5854 = fdiv float %5853, 1.280000e+02
  %5855 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %5856 = mul nuw nsw i64 %5837, 1024
  %5857 = add nuw nsw i64 %5856, %5841
  %5858 = add nuw nsw i64 %5857, %5845
  %5859 = getelementptr inbounds float, ptr %5855, i64 %5858
  store float %5854, ptr %5859, align 4
  %5860 = add i64 %5845, 1
  br label %5844

5861:                                             ; preds = %5844
  %5862 = add i64 %5841, 1
  br label %5840

5863:                                             ; preds = %5840
  %5864 = add i64 %5837, 1
  br label %5836

5865:                                             ; preds = %5836
  br label %5866

5866:                                             ; preds = %5893, %5865
  %5867 = phi i64 [ %5894, %5893 ], [ 0, %5865 ]
  %5868 = icmp slt i64 %5867, 2
  br i1 %5868, label %5869, label %5895

5869:                                             ; preds = %5866
  br label %5870

5870:                                             ; preds = %5891, %5869
  %5871 = phi i64 [ %5892, %5891 ], [ 0, %5869 ]
  %5872 = icmp slt i64 %5871, 1024
  br i1 %5872, label %5873, label %5893

5873:                                             ; preds = %5870
  br label %5874

5874:                                             ; preds = %5877, %5873
  %5875 = phi i64 [ %5890, %5877 ], [ 0, %5873 ]
  %5876 = icmp slt i64 %5875, 1
  br i1 %5876, label %5877, label %5891

5877:                                             ; preds = %5874
  %5878 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %5879 = mul nuw nsw i64 %5867, 1024
  %5880 = add nuw nsw i64 %5879, %5871
  %5881 = add nuw nsw i64 %5880, %5875
  %5882 = getelementptr inbounds float, ptr %5878, i64 %5881
  %5883 = load float, ptr %5882, align 4
  %5884 = fadd float %5883, 0x3EE4F8B580000000
  %5885 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %5886 = mul nuw nsw i64 %5867, 1024
  %5887 = add nuw nsw i64 %5886, %5871
  %5888 = add nuw nsw i64 %5887, %5875
  %5889 = getelementptr inbounds float, ptr %5885, i64 %5888
  store float %5884, ptr %5889, align 4
  %5890 = add i64 %5875, 1
  br label %5874

5891:                                             ; preds = %5874
  %5892 = add i64 %5871, 1
  br label %5870

5893:                                             ; preds = %5870
  %5894 = add i64 %5867, 1
  br label %5866

5895:                                             ; preds = %5866
  br label %5896

5896:                                             ; preds = %5924, %5895
  %5897 = phi i64 [ %5925, %5924 ], [ 0, %5895 ]
  %5898 = icmp slt i64 %5897, 2
  br i1 %5898, label %5899, label %5926

5899:                                             ; preds = %5896
  br label %5900

5900:                                             ; preds = %5922, %5899
  %5901 = phi i64 [ %5923, %5922 ], [ 0, %5899 ]
  %5902 = icmp slt i64 %5901, 1024
  br i1 %5902, label %5903, label %5924

5903:                                             ; preds = %5900
  br label %5904

5904:                                             ; preds = %5907, %5903
  %5905 = phi i64 [ %5921, %5907 ], [ 0, %5903 ]
  %5906 = icmp slt i64 %5905, 1
  br i1 %5906, label %5907, label %5922

5907:                                             ; preds = %5904
  %5908 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %5909 = mul nuw nsw i64 %5897, 1024
  %5910 = add nuw nsw i64 %5909, %5901
  %5911 = add nuw nsw i64 %5910, %5905
  %5912 = getelementptr inbounds float, ptr %5908, i64 %5911
  %5913 = load float, ptr %5912, align 4
  %5914 = call float @llvm.sqrt.f32(float %5913)
  %5915 = fdiv float 1.000000e+00, %5914
  %5916 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %5917 = mul nuw nsw i64 %5897, 1024
  %5918 = add nuw nsw i64 %5917, %5901
  %5919 = add nuw nsw i64 %5918, %5905
  %5920 = getelementptr inbounds float, ptr %5916, i64 %5919
  store float %5915, ptr %5920, align 4
  %5921 = add i64 %5905, 1
  br label %5904

5922:                                             ; preds = %5904
  %5923 = add i64 %5901, 1
  br label %5900

5924:                                             ; preds = %5900
  %5925 = add i64 %5897, 1
  br label %5896

5926:                                             ; preds = %5896
  %5927 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 0
  %5928 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %367, 1
  %5929 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } poison, ptr %5927, 0
  %5930 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5929, ptr %5928, 1
  %5931 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5930, i64 0, 2
  %5932 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5931, i64 2, 3, 0
  %5933 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5932, i64 1024, 4, 0
  %5934 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5933, i64 1024, 3, 1
  %5935 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5934, i64 1, 4, 1
  br label %5936

5936:                                             ; preds = %5968, %5926
  %5937 = phi i64 [ %5969, %5968 ], [ 0, %5926 ]
  %5938 = icmp slt i64 %5937, 2
  br i1 %5938, label %5939, label %5970

5939:                                             ; preds = %5936
  br label %5940

5940:                                             ; preds = %5966, %5939
  %5941 = phi i64 [ %5967, %5966 ], [ 0, %5939 ]
  %5942 = icmp slt i64 %5941, 1024
  br i1 %5942, label %5943, label %5968

5943:                                             ; preds = %5940
  br label %5944

5944:                                             ; preds = %5947, %5943
  %5945 = phi i64 [ %5965, %5947 ], [ 0, %5943 ]
  %5946 = icmp slt i64 %5945, 128
  br i1 %5946, label %5947, label %5966

5947:                                             ; preds = %5944
  %5948 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %5935, 1
  %5949 = mul nuw nsw i64 %5937, 1024
  %5950 = add nuw nsw i64 %5949, %5941
  %5951 = getelementptr inbounds float, ptr %5948, i64 %5950
  %5952 = load float, ptr %5951, align 4
  %5953 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %5954 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %5955 = getelementptr float, ptr %5953, i64 %5954
  %5956 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %5957 = mul nuw nsw i64 %5937, %5956
  %5958 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %5959 = mul nuw nsw i64 %5941, %5958
  %5960 = add nuw nsw i64 %5957, %5959
  %5961 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %5962 = mul nuw nsw i64 %5945, %5961
  %5963 = add nuw nsw i64 %5960, %5962
  %5964 = getelementptr inbounds float, ptr %5955, i64 %5963
  store float %5952, ptr %5964, align 4
  %5965 = add i64 %5945, 1
  br label %5944

5966:                                             ; preds = %5944
  %5967 = add i64 %5941, 1
  br label %5940

5968:                                             ; preds = %5940
  %5969 = add i64 %5937, 1
  br label %5936

5970:                                             ; preds = %5936
  br label %5971

5971:                                             ; preds = %6019, %5970
  %5972 = phi i64 [ %6020, %6019 ], [ 0, %5970 ]
  %5973 = icmp slt i64 %5972, 2
  br i1 %5973, label %5974, label %6021

5974:                                             ; preds = %5971
  br label %5975

5975:                                             ; preds = %6017, %5974
  %5976 = phi i64 [ %6018, %6017 ], [ 0, %5974 ]
  %5977 = icmp slt i64 %5976, 1024
  br i1 %5977, label %5978, label %6019

5978:                                             ; preds = %5975
  br label %5979

5979:                                             ; preds = %5982, %5978
  %5980 = phi i64 [ %6016, %5982 ], [ 0, %5978 ]
  %5981 = icmp slt i64 %5980, 128
  br i1 %5981, label %5982, label %6017

5982:                                             ; preds = %5979
  %5983 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5702, 1
  %5984 = mul nuw nsw i64 %5972, 131072
  %5985 = mul nuw nsw i64 %5976, 128
  %5986 = add nuw nsw i64 %5984, %5985
  %5987 = add nuw nsw i64 %5986, %5980
  %5988 = getelementptr inbounds float, ptr %5983, i64 %5987
  %5989 = load float, ptr %5988, align 4
  %5990 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %5991 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %5992 = getelementptr float, ptr %5990, i64 %5991
  %5993 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %5994 = mul nuw nsw i64 %5972, %5993
  %5995 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %5996 = mul nuw nsw i64 %5976, %5995
  %5997 = add nuw nsw i64 %5994, %5996
  %5998 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %5999 = mul nuw nsw i64 %5980, %5998
  %6000 = add nuw nsw i64 %5997, %5999
  %6001 = getelementptr inbounds float, ptr %5992, i64 %6000
  %6002 = load float, ptr %6001, align 4
  %6003 = fmul float %5989, %6002
  %6004 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %6005 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %6006 = getelementptr float, ptr %6004, i64 %6005
  %6007 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %6008 = mul nuw nsw i64 %5972, %6007
  %6009 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %6010 = mul nuw nsw i64 %5976, %6009
  %6011 = add nuw nsw i64 %6008, %6010
  %6012 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %6013 = mul nuw nsw i64 %5980, %6012
  %6014 = add nuw nsw i64 %6011, %6013
  %6015 = getelementptr inbounds float, ptr %6006, i64 %6014
  store float %6003, ptr %6015, align 4
  %6016 = add i64 %5980, 1
  br label %5979

6017:                                             ; preds = %5979
  %6018 = add i64 %5976, 1
  br label %5975

6019:                                             ; preds = %5975
  %6020 = add i64 %5972, 1
  br label %5971

6021:                                             ; preds = %5971
  br label %6022

6022:                                             ; preds = %6070, %6021
  %6023 = phi i64 [ %6071, %6070 ], [ 0, %6021 ]
  %6024 = icmp slt i64 %6023, 2
  br i1 %6024, label %6025, label %6072

6025:                                             ; preds = %6022
  br label %6026

6026:                                             ; preds = %6068, %6025
  %6027 = phi i64 [ %6069, %6068 ], [ 0, %6025 ]
  %6028 = icmp slt i64 %6027, 1024
  br i1 %6028, label %6029, label %6070

6029:                                             ; preds = %6026
  br label %6030

6030:                                             ; preds = %6033, %6029
  %6031 = phi i64 [ %6067, %6033 ], [ 0, %6029 ]
  %6032 = icmp slt i64 %6031, 128
  br i1 %6032, label %6033, label %6068

6033:                                             ; preds = %6030
  %6034 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %6035 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %6036 = getelementptr float, ptr %6034, i64 %6035
  %6037 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %6038 = mul nuw nsw i64 %6023, %6037
  %6039 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %6040 = mul nuw nsw i64 %6027, %6039
  %6041 = add nuw nsw i64 %6038, %6040
  %6042 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %6043 = mul nuw nsw i64 %6031, %6042
  %6044 = add nuw nsw i64 %6041, %6043
  %6045 = getelementptr inbounds float, ptr %6036, i64 %6044
  %6046 = load float, ptr %6045, align 4
  %6047 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %219, 1
  %6048 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %219, 2
  %6049 = getelementptr float, ptr %6047, i64 %6048
  %6050 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %219, 4, 0
  %6051 = mul nuw nsw i64 %6031, %6050
  %6052 = getelementptr inbounds float, ptr %6049, i64 %6051
  %6053 = load float, ptr %6052, align 4
  %6054 = fmul float %6046, %6053
  %6055 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %6056 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %6057 = getelementptr float, ptr %6055, i64 %6056
  %6058 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %6059 = mul nuw nsw i64 %6023, %6058
  %6060 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %6061 = mul nuw nsw i64 %6027, %6060
  %6062 = add nuw nsw i64 %6059, %6061
  %6063 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %6064 = mul nuw nsw i64 %6031, %6063
  %6065 = add nuw nsw i64 %6062, %6064
  %6066 = getelementptr inbounds float, ptr %6057, i64 %6065
  store float %6054, ptr %6066, align 4
  %6067 = add i64 %6031, 1
  br label %6030

6068:                                             ; preds = %6030
  %6069 = add i64 %6027, 1
  br label %6026

6070:                                             ; preds = %6026
  %6071 = add i64 %6023, 1
  br label %6022

6072:                                             ; preds = %6022
  br label %6073

6073:                                             ; preds = %6121, %6072
  %6074 = phi i64 [ %6122, %6121 ], [ 0, %6072 ]
  %6075 = icmp slt i64 %6074, 2
  br i1 %6075, label %6076, label %6123

6076:                                             ; preds = %6073
  br label %6077

6077:                                             ; preds = %6119, %6076
  %6078 = phi i64 [ %6120, %6119 ], [ 0, %6076 ]
  %6079 = icmp slt i64 %6078, 1024
  br i1 %6079, label %6080, label %6121

6080:                                             ; preds = %6077
  br label %6081

6081:                                             ; preds = %6084, %6080
  %6082 = phi i64 [ %6118, %6084 ], [ 0, %6080 ]
  %6083 = icmp slt i64 %6082, 128
  br i1 %6083, label %6084, label %6119

6084:                                             ; preds = %6081
  %6085 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %6086 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %6087 = getelementptr float, ptr %6085, i64 %6086
  %6088 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %6089 = mul nuw nsw i64 %6074, %6088
  %6090 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %6091 = mul nuw nsw i64 %6078, %6090
  %6092 = add nuw nsw i64 %6089, %6091
  %6093 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %6094 = mul nuw nsw i64 %6082, %6093
  %6095 = add nuw nsw i64 %6092, %6094
  %6096 = getelementptr inbounds float, ptr %6087, i64 %6095
  %6097 = load float, ptr %6096, align 4
  %6098 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %214, 1
  %6099 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %214, 2
  %6100 = getelementptr float, ptr %6098, i64 %6099
  %6101 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %214, 4, 0
  %6102 = mul nuw nsw i64 %6082, %6101
  %6103 = getelementptr inbounds float, ptr %6100, i64 %6102
  %6104 = load float, ptr %6103, align 4
  %6105 = fadd float %6097, %6104
  %6106 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %6107 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %6108 = getelementptr float, ptr %6106, i64 %6107
  %6109 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %6110 = mul nuw nsw i64 %6074, %6109
  %6111 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %6112 = mul nuw nsw i64 %6078, %6111
  %6113 = add nuw nsw i64 %6110, %6112
  %6114 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %6115 = mul nuw nsw i64 %6082, %6114
  %6116 = add nuw nsw i64 %6113, %6115
  %6117 = getelementptr inbounds float, ptr %6108, i64 %6116
  store float %6105, ptr %6117, align 4
  %6118 = add i64 %6082, 1
  br label %6081

6119:                                             ; preds = %6081
  %6120 = add i64 %6078, 1
  br label %6077

6121:                                             ; preds = %6077
  %6122 = add i64 %6074, 1
  br label %6073

6123:                                             ; preds = %6073
  br label %6124

6124:                                             ; preds = %6147, %6123
  %6125 = phi i64 [ %6148, %6147 ], [ 0, %6123 ]
  %6126 = icmp slt i64 %6125, 128
  br i1 %6126, label %6127, label %6149

6127:                                             ; preds = %6124
  br label %6128

6128:                                             ; preds = %6131, %6127
  %6129 = phi i64 [ %6146, %6131 ], [ 0, %6127 ]
  %6130 = icmp slt i64 %6129, 512
  br i1 %6130, label %6131, label %6147

6131:                                             ; preds = %6128
  %6132 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %209, 1
  %6133 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %209, 2
  %6134 = getelementptr float, ptr %6132, i64 %6133
  %6135 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %209, 4, 0
  %6136 = mul nuw nsw i64 %6129, %6135
  %6137 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %209, 4, 1
  %6138 = mul nuw nsw i64 %6125, %6137
  %6139 = add nuw nsw i64 %6136, %6138
  %6140 = getelementptr inbounds float, ptr %6134, i64 %6139
  %6141 = load float, ptr %6140, align 4
  %6142 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3350, 1
  %6143 = mul nuw nsw i64 %6125, 512
  %6144 = add nuw nsw i64 %6143, %6129
  %6145 = getelementptr inbounds float, ptr %6142, i64 %6144
  store float %6141, ptr %6145, align 4
  %6146 = add i64 %6129, 1
  br label %6128

6147:                                             ; preds = %6128
  %6148 = add i64 %6125, 1
  br label %6124

6149:                                             ; preds = %6124
  br label %6150

6150:                                             ; preds = %6176, %6149
  %6151 = phi i64 [ %6177, %6176 ], [ 0, %6149 ]
  %6152 = icmp slt i64 %6151, 2
  br i1 %6152, label %6153, label %6178

6153:                                             ; preds = %6150
  br label %6154

6154:                                             ; preds = %6174, %6153
  %6155 = phi i64 [ %6175, %6174 ], [ 0, %6153 ]
  %6156 = icmp slt i64 %6155, 128
  br i1 %6156, label %6157, label %6176

6157:                                             ; preds = %6154
  br label %6158

6158:                                             ; preds = %6161, %6157
  %6159 = phi i64 [ %6173, %6161 ], [ 0, %6157 ]
  %6160 = icmp slt i64 %6159, 512
  br i1 %6160, label %6161, label %6174

6161:                                             ; preds = %6158
  %6162 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3350, 1
  %6163 = mul nuw nsw i64 %6155, 512
  %6164 = add nuw nsw i64 %6163, %6159
  %6165 = getelementptr inbounds float, ptr %6162, i64 %6164
  %6166 = load float, ptr %6165, align 4
  %6167 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 1
  %6168 = mul nuw nsw i64 %6151, 65536
  %6169 = mul nuw nsw i64 %6155, 512
  %6170 = add nuw nsw i64 %6168, %6169
  %6171 = add nuw nsw i64 %6170, %6159
  %6172 = getelementptr inbounds float, ptr %6167, i64 %6171
  store float %6166, ptr %6172, align 4
  %6173 = add i64 %6159, 1
  br label %6158

6174:                                             ; preds = %6158
  %6175 = add i64 %6155, 1
  br label %6154

6176:                                             ; preds = %6154
  %6177 = add i64 %6151, 1
  br label %6150

6178:                                             ; preds = %6150
  %6179 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 0
  %6180 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %6181 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %6182 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 3, 0
  %6183 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 3, 1
  %6184 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 3, 2
  %6185 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %6186 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %6187 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %6188 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 0
  %6189 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 1
  %6190 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 2
  %6191 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 3, 0
  %6192 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 3, 1
  %6193 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 3, 2
  %6194 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 4, 0
  %6195 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 4, 1
  %6196 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3391, 4, 2
  %6197 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3450, 0
  %6198 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3450, 1
  %6199 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3450, 2
  %6200 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3450, 3, 0
  %6201 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3450, 3, 1
  %6202 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3450, 3, 2
  %6203 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3450, 4, 0
  %6204 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3450, 4, 1
  %6205 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3450, 4, 2
  call void @ukernel_bmm(ptr %6179, ptr %6180, i64 %6181, i64 %6182, i64 %6183, i64 %6184, i64 %6185, i64 %6186, i64 %6187, ptr %6188, ptr %6189, i64 %6190, i64 %6191, i64 %6192, i64 %6193, i64 %6194, i64 %6195, i64 %6196, ptr %6197, ptr %6198, i64 %6199, i64 %6200, i64 %6201, i64 %6202, i64 %6203, i64 %6204, i64 %6205)
  br label %6206

6206:                                             ; preds = %6242, %6178
  %6207 = phi i64 [ %6243, %6242 ], [ 0, %6178 ]
  %6208 = icmp slt i64 %6207, 2
  br i1 %6208, label %6209, label %6244

6209:                                             ; preds = %6206
  br label %6210

6210:                                             ; preds = %6240, %6209
  %6211 = phi i64 [ %6241, %6240 ], [ 0, %6209 ]
  %6212 = icmp slt i64 %6211, 1024
  br i1 %6212, label %6213, label %6242

6213:                                             ; preds = %6210
  br label %6214

6214:                                             ; preds = %6217, %6213
  %6215 = phi i64 [ %6239, %6217 ], [ 0, %6213 ]
  %6216 = icmp slt i64 %6215, 512
  br i1 %6216, label %6217, label %6240

6217:                                             ; preds = %6214
  %6218 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3450, 1
  %6219 = mul nuw nsw i64 %6207, 524288
  %6220 = mul nuw nsw i64 %6211, 512
  %6221 = add nuw nsw i64 %6219, %6220
  %6222 = add nuw nsw i64 %6221, %6215
  %6223 = getelementptr inbounds float, ptr %6218, i64 %6222
  %6224 = load float, ptr %6223, align 4
  %6225 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %202, 1
  %6226 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %202, 2
  %6227 = getelementptr float, ptr %6225, i64 %6226
  %6228 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %202, 4, 0
  %6229 = mul nuw nsw i64 %6215, %6228
  %6230 = getelementptr inbounds float, ptr %6227, i64 %6229
  %6231 = load float, ptr %6230, align 4
  %6232 = fadd float %6224, %6231
  %6233 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 1
  %6234 = mul nuw nsw i64 %6207, 524288
  %6235 = mul nuw nsw i64 %6211, 512
  %6236 = add nuw nsw i64 %6234, %6235
  %6237 = add nuw nsw i64 %6236, %6215
  %6238 = getelementptr inbounds float, ptr %6233, i64 %6237
  store float %6232, ptr %6238, align 4
  %6239 = add i64 %6215, 1
  br label %6214

6240:                                             ; preds = %6214
  %6241 = add i64 %6211, 1
  br label %6210

6242:                                             ; preds = %6210
  %6243 = add i64 %6207, 1
  br label %6206

6244:                                             ; preds = %6206
  br label %6245

6245:                                             ; preds = %6278, %6244
  %6246 = phi i64 [ %6279, %6278 ], [ 0, %6244 ]
  %6247 = icmp slt i64 %6246, 2
  br i1 %6247, label %6248, label %6280

6248:                                             ; preds = %6245
  br label %6249

6249:                                             ; preds = %6276, %6248
  %6250 = phi i64 [ %6277, %6276 ], [ 0, %6248 ]
  %6251 = icmp slt i64 %6250, 1024
  br i1 %6251, label %6252, label %6278

6252:                                             ; preds = %6249
  br label %6253

6253:                                             ; preds = %6256, %6252
  %6254 = phi i64 [ %6275, %6256 ], [ 0, %6252 ]
  %6255 = icmp slt i64 %6254, 512
  br i1 %6255, label %6256, label %6276

6256:                                             ; preds = %6253
  %6257 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 1
  %6258 = mul nuw nsw i64 %6246, 524288
  %6259 = mul nuw nsw i64 %6250, 512
  %6260 = add nuw nsw i64 %6258, %6259
  %6261 = add nuw nsw i64 %6260, %6254
  %6262 = getelementptr inbounds float, ptr %6257, i64 %6261
  %6263 = load float, ptr %6262, align 4
  %6264 = fdiv float %6263, 0x3FF6A09E60000000
  %6265 = call float @erff(float %6264)
  %6266 = fadd float %6265, 1.000000e+00
  %6267 = fmul float %6266, 5.000000e-01
  %6268 = fmul float %6263, %6267
  %6269 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 1
  %6270 = mul nuw nsw i64 %6246, 524288
  %6271 = mul nuw nsw i64 %6250, 512
  %6272 = add nuw nsw i64 %6270, %6271
  %6273 = add nuw nsw i64 %6272, %6254
  %6274 = getelementptr inbounds float, ptr %6269, i64 %6273
  store float %6268, ptr %6274, align 4
  %6275 = add i64 %6254, 1
  br label %6253

6276:                                             ; preds = %6253
  %6277 = add i64 %6250, 1
  br label %6249

6278:                                             ; preds = %6249
  %6279 = add i64 %6246, 1
  br label %6245

6280:                                             ; preds = %6245
  br label %6281

6281:                                             ; preds = %6304, %6280
  %6282 = phi i64 [ %6305, %6304 ], [ 0, %6280 ]
  %6283 = icmp slt i64 %6282, 512
  br i1 %6283, label %6284, label %6306

6284:                                             ; preds = %6281
  br label %6285

6285:                                             ; preds = %6288, %6284
  %6286 = phi i64 [ %6303, %6288 ], [ 0, %6284 ]
  %6287 = icmp slt i64 %6286, 128
  br i1 %6287, label %6288, label %6304

6288:                                             ; preds = %6285
  %6289 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %197, 1
  %6290 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %197, 2
  %6291 = getelementptr float, ptr %6289, i64 %6290
  %6292 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %197, 4, 0
  %6293 = mul nuw nsw i64 %6286, %6292
  %6294 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %197, 4, 1
  %6295 = mul nuw nsw i64 %6282, %6294
  %6296 = add nuw nsw i64 %6293, %6295
  %6297 = getelementptr inbounds float, ptr %6291, i64 %6296
  %6298 = load float, ptr %6297, align 4
  %6299 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3617, 1
  %6300 = mul nuw nsw i64 %6282, 128
  %6301 = add nuw nsw i64 %6300, %6286
  %6302 = getelementptr inbounds float, ptr %6299, i64 %6301
  store float %6298, ptr %6302, align 4
  %6303 = add i64 %6286, 1
  br label %6285

6304:                                             ; preds = %6285
  %6305 = add i64 %6282, 1
  br label %6281

6306:                                             ; preds = %6281
  br label %6307

6307:                                             ; preds = %6333, %6306
  %6308 = phi i64 [ %6334, %6333 ], [ 0, %6306 ]
  %6309 = icmp slt i64 %6308, 2
  br i1 %6309, label %6310, label %6335

6310:                                             ; preds = %6307
  br label %6311

6311:                                             ; preds = %6331, %6310
  %6312 = phi i64 [ %6332, %6331 ], [ 0, %6310 ]
  %6313 = icmp slt i64 %6312, 512
  br i1 %6313, label %6314, label %6333

6314:                                             ; preds = %6311
  br label %6315

6315:                                             ; preds = %6318, %6314
  %6316 = phi i64 [ %6330, %6318 ], [ 0, %6314 ]
  %6317 = icmp slt i64 %6316, 128
  br i1 %6317, label %6318, label %6331

6318:                                             ; preds = %6315
  %6319 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %3617, 1
  %6320 = mul nuw nsw i64 %6312, 128
  %6321 = add nuw nsw i64 %6320, %6316
  %6322 = getelementptr inbounds float, ptr %6319, i64 %6321
  %6323 = load float, ptr %6322, align 4
  %6324 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 1
  %6325 = mul nuw nsw i64 %6308, 65536
  %6326 = mul nuw nsw i64 %6312, 128
  %6327 = add nuw nsw i64 %6325, %6326
  %6328 = add nuw nsw i64 %6327, %6316
  %6329 = getelementptr inbounds float, ptr %6324, i64 %6328
  store float %6323, ptr %6329, align 4
  %6330 = add i64 %6316, 1
  br label %6315

6331:                                             ; preds = %6315
  %6332 = add i64 %6312, 1
  br label %6311

6333:                                             ; preds = %6311
  %6334 = add i64 %6308, 1
  br label %6307

6335:                                             ; preds = %6307
  %6336 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 0
  %6337 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 1
  %6338 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 2
  %6339 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 3, 0
  %6340 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 3, 1
  %6341 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 3, 2
  %6342 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 4, 0
  %6343 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 4, 1
  %6344 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3435, 4, 2
  %6345 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 0
  %6346 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 1
  %6347 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 2
  %6348 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 3, 0
  %6349 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 3, 1
  %6350 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 3, 2
  %6351 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 4, 0
  %6352 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 4, 1
  %6353 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3658, 4, 2
  %6354 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 0
  %6355 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 1
  %6356 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 2
  %6357 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 3, 0
  %6358 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 3, 1
  %6359 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 3, 2
  %6360 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 4, 0
  %6361 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 4, 1
  %6362 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 4, 2
  call void @ukernel_bmm(ptr %6336, ptr %6337, i64 %6338, i64 %6339, i64 %6340, i64 %6341, i64 %6342, i64 %6343, i64 %6344, ptr %6345, ptr %6346, i64 %6347, i64 %6348, i64 %6349, i64 %6350, i64 %6351, i64 %6352, i64 %6353, ptr %6354, ptr %6355, i64 %6356, i64 %6357, i64 %6358, i64 %6359, i64 %6360, i64 %6361, i64 %6362)
  br label %6363

6363:                                             ; preds = %6405, %6335
  %6364 = phi i64 [ %6406, %6405 ], [ 0, %6335 ]
  %6365 = icmp slt i64 %6364, 2
  br i1 %6365, label %6366, label %6407

6366:                                             ; preds = %6363
  br label %6367

6367:                                             ; preds = %6403, %6366
  %6368 = phi i64 [ %6404, %6403 ], [ 0, %6366 ]
  %6369 = icmp slt i64 %6368, 1024
  br i1 %6369, label %6370, label %6405

6370:                                             ; preds = %6367
  br label %6371

6371:                                             ; preds = %6374, %6370
  %6372 = phi i64 [ %6402, %6374 ], [ 0, %6370 ]
  %6373 = icmp slt i64 %6372, 128
  br i1 %6373, label %6374, label %6403

6374:                                             ; preds = %6371
  %6375 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2544, 1
  %6376 = mul nuw nsw i64 %6364, 131072
  %6377 = mul nuw nsw i64 %6368, 128
  %6378 = add nuw nsw i64 %6376, %6377
  %6379 = add nuw nsw i64 %6378, %6372
  %6380 = getelementptr inbounds float, ptr %6375, i64 %6379
  %6381 = load float, ptr %6380, align 4
  %6382 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %190, 1
  %6383 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %190, 2
  %6384 = getelementptr float, ptr %6382, i64 %6383
  %6385 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %190, 4, 0
  %6386 = mul nuw nsw i64 %6372, %6385
  %6387 = getelementptr inbounds float, ptr %6384, i64 %6386
  %6388 = load float, ptr %6387, align 4
  %6389 = fadd float %6381, %6388
  %6390 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %6391 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %6392 = getelementptr float, ptr %6390, i64 %6391
  %6393 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %6394 = mul nuw nsw i64 %6364, %6393
  %6395 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %6396 = mul nuw nsw i64 %6368, %6395
  %6397 = add nuw nsw i64 %6394, %6396
  %6398 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %6399 = mul nuw nsw i64 %6372, %6398
  %6400 = add nuw nsw i64 %6397, %6399
  %6401 = getelementptr inbounds float, ptr %6392, i64 %6400
  store float %6389, ptr %6401, align 4
  %6402 = add i64 %6372, 1
  br label %6371

6403:                                             ; preds = %6371
  %6404 = add i64 %6368, 1
  br label %6367

6405:                                             ; preds = %6367
  %6406 = add i64 %6364, 1
  br label %6363

6407:                                             ; preds = %6363
  br label %6408

6408:                                             ; preds = %6456, %6407
  %6409 = phi i64 [ %6457, %6456 ], [ 0, %6407 ]
  %6410 = icmp slt i64 %6409, 2
  br i1 %6410, label %6411, label %6458

6411:                                             ; preds = %6408
  br label %6412

6412:                                             ; preds = %6454, %6411
  %6413 = phi i64 [ %6455, %6454 ], [ 0, %6411 ]
  %6414 = icmp slt i64 %6413, 1024
  br i1 %6414, label %6415, label %6456

6415:                                             ; preds = %6412
  br label %6416

6416:                                             ; preds = %6419, %6415
  %6417 = phi i64 [ %6453, %6419 ], [ 0, %6415 ]
  %6418 = icmp slt i64 %6417, 128
  br i1 %6418, label %6419, label %6454

6419:                                             ; preds = %6416
  %6420 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5503, 1
  %6421 = mul nuw nsw i64 %6409, 131072
  %6422 = mul nuw nsw i64 %6413, 128
  %6423 = add nuw nsw i64 %6421, %6422
  %6424 = add nuw nsw i64 %6423, %6417
  %6425 = getelementptr inbounds float, ptr %6420, i64 %6424
  %6426 = load float, ptr %6425, align 4
  %6427 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %6428 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %6429 = getelementptr float, ptr %6427, i64 %6428
  %6430 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %6431 = mul nuw nsw i64 %6409, %6430
  %6432 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %6433 = mul nuw nsw i64 %6413, %6432
  %6434 = add nuw nsw i64 %6431, %6433
  %6435 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %6436 = mul nuw nsw i64 %6417, %6435
  %6437 = add nuw nsw i64 %6434, %6436
  %6438 = getelementptr inbounds float, ptr %6429, i64 %6437
  %6439 = load float, ptr %6438, align 4
  %6440 = fadd float %6426, %6439
  %6441 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 1
  %6442 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 2
  %6443 = getelementptr float, ptr %6441, i64 %6442
  %6444 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 0
  %6445 = mul nuw nsw i64 %6409, %6444
  %6446 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 1
  %6447 = mul nuw nsw i64 %6413, %6446
  %6448 = add nuw nsw i64 %6445, %6447
  %6449 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %185, 4, 2
  %6450 = mul nuw nsw i64 %6417, %6449
  %6451 = add nuw nsw i64 %6448, %6450
  %6452 = getelementptr inbounds float, ptr %6443, i64 %6451
  store float %6440, ptr %6452, align 4
  %6453 = add i64 %6417, 1
  br label %6416

6454:                                             ; preds = %6416
  %6455 = add i64 %6413, 1
  br label %6412

6456:                                             ; preds = %6412
  %6457 = add i64 %6409, 1
  br label %6408

6458:                                             ; preds = %6408
  ret void
}

define void @_mlir_ciface_main(ptr %0, ptr %1, ptr %2, ptr %3, ptr %4, ptr %5, ptr %6, ptr %7, ptr %8, ptr %9, ptr %10, ptr %11, ptr %12, ptr %13, ptr %14, ptr %15, ptr %16, ptr %17, ptr %18, ptr %19, ptr %20, ptr %21, ptr %22, ptr %23, ptr %24, ptr %25, ptr %26, ptr %27) {
  %29 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %0, align 8
  %30 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %29, 0
  %31 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %29, 1
  %32 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %29, 2
  %33 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %29, 3, 0
  %34 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %29, 4, 0
  %35 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %1, align 8
  %36 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %35, 0
  %37 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %35, 1
  %38 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %35, 2
  %39 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %35, 3, 0
  %40 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %35, 4, 0
  %41 = load { ptr, ptr, i64, [3 x i64], [3 x i64] }, ptr %2, align 8
  %42 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %41, 0
  %43 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %41, 1
  %44 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %41, 2
  %45 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %41, 3, 0
  %46 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %41, 3, 1
  %47 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %41, 3, 2
  %48 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %41, 4, 0
  %49 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %41, 4, 1
  %50 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %41, 4, 2
  %51 = load { ptr, ptr, i64, [2 x i64], [2 x i64] }, ptr %3, align 8
  %52 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, 0
  %53 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, 1
  %54 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, 2
  %55 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, 3, 0
  %56 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, 3, 1
  %57 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, 4, 0
  %58 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, 4, 1
  %59 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %4, align 8
  %60 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %59, 0
  %61 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %59, 1
  %62 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %59, 2
  %63 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %59, 3, 0
  %64 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %59, 4, 0
  %65 = load { ptr, ptr, i64, [4 x i64], [4 x i64] }, ptr %5, align 8
  %66 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %65, 0
  %67 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %65, 1
  %68 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %65, 2
  %69 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %65, 3, 0
  %70 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %65, 3, 1
  %71 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %65, 3, 2
  %72 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %65, 3, 3
  %73 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %65, 4, 0
  %74 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %65, 4, 1
  %75 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %65, 4, 2
  %76 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %65, 4, 3
  %77 = load { ptr, ptr, i64, [2 x i64], [2 x i64] }, ptr %6, align 8
  %78 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %77, 0
  %79 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %77, 1
  %80 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %77, 2
  %81 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %77, 3, 0
  %82 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %77, 3, 1
  %83 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %77, 4, 0
  %84 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %77, 4, 1
  %85 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %7, align 8
  %86 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %85, 0
  %87 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %85, 1
  %88 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %85, 2
  %89 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %85, 3, 0
  %90 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %85, 4, 0
  %91 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %8, align 8
  %92 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %91, 0
  %93 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %91, 1
  %94 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %91, 2
  %95 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %91, 3, 0
  %96 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %91, 4, 0
  %97 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %9, align 8
  %98 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %97, 0
  %99 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %97, 1
  %100 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %97, 2
  %101 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %97, 3, 0
  %102 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %97, 4, 0
  %103 = load { ptr, ptr, i64, [2 x i64], [2 x i64] }, ptr %10, align 8
  %104 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %103, 0
  %105 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %103, 1
  %106 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %103, 2
  %107 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %103, 3, 0
  %108 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %103, 3, 1
  %109 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %103, 4, 0
  %110 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %103, 4, 1
  %111 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %11, align 8
  %112 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %111, 0
  %113 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %111, 1
  %114 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %111, 2
  %115 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %111, 3, 0
  %116 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %111, 4, 0
  %117 = load { ptr, ptr, i64, [2 x i64], [2 x i64] }, ptr %12, align 8
  %118 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %117, 0
  %119 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %117, 1
  %120 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %117, 2
  %121 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %117, 3, 0
  %122 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %117, 3, 1
  %123 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %117, 4, 0
  %124 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %117, 4, 1
  %125 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %13, align 8
  %126 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %125, 0
  %127 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %125, 1
  %128 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %125, 2
  %129 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %125, 3, 0
  %130 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %125, 4, 0
  %131 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %14, align 8
  %132 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %131, 0
  %133 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %131, 1
  %134 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %131, 2
  %135 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %131, 3, 0
  %136 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %131, 4, 0
  %137 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %15, align 8
  %138 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %137, 0
  %139 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %137, 1
  %140 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %137, 2
  %141 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %137, 3, 0
  %142 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %137, 4, 0
  %143 = load { ptr, ptr, i64, [2 x i64], [2 x i64] }, ptr %16, align 8
  %144 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %143, 0
  %145 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %143, 1
  %146 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %143, 2
  %147 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %143, 3, 0
  %148 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %143, 3, 1
  %149 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %143, 4, 0
  %150 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %143, 4, 1
  %151 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %17, align 8
  %152 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %151, 0
  %153 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %151, 1
  %154 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %151, 2
  %155 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %151, 3, 0
  %156 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %151, 4, 0
  %157 = load { ptr, ptr, i64, [4 x i64], [4 x i64] }, ptr %18, align 8
  %158 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %157, 0
  %159 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %157, 1
  %160 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %157, 2
  %161 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %157, 3, 0
  %162 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %157, 3, 1
  %163 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %157, 3, 2
  %164 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %157, 3, 3
  %165 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %157, 4, 0
  %166 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %157, 4, 1
  %167 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %157, 4, 2
  %168 = extractvalue { ptr, ptr, i64, [4 x i64], [4 x i64] } %157, 4, 3
  %169 = load { ptr, ptr, i64, [2 x i64], [2 x i64] }, ptr %19, align 8
  %170 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %169, 0
  %171 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %169, 1
  %172 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %169, 2
  %173 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %169, 3, 0
  %174 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %169, 3, 1
  %175 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %169, 4, 0
  %176 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %169, 4, 1
  %177 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %20, align 8
  %178 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %177, 0
  %179 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %177, 1
  %180 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %177, 2
  %181 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %177, 3, 0
  %182 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %177, 4, 0
  %183 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %21, align 8
  %184 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %183, 0
  %185 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %183, 1
  %186 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %183, 2
  %187 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %183, 3, 0
  %188 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %183, 4, 0
  %189 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %22, align 8
  %190 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %189, 0
  %191 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %189, 1
  %192 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %189, 2
  %193 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %189, 3, 0
  %194 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %189, 4, 0
  %195 = load { ptr, ptr, i64, [2 x i64], [2 x i64] }, ptr %23, align 8
  %196 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %195, 0
  %197 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %195, 1
  %198 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %195, 2
  %199 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %195, 3, 0
  %200 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %195, 3, 1
  %201 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %195, 4, 0
  %202 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %195, 4, 1
  %203 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %24, align 8
  %204 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %203, 0
  %205 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %203, 1
  %206 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %203, 2
  %207 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %203, 3, 0
  %208 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %203, 4, 0
  %209 = load { ptr, ptr, i64, [2 x i64], [2 x i64] }, ptr %25, align 8
  %210 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %209, 0
  %211 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %209, 1
  %212 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %209, 2
  %213 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %209, 3, 0
  %214 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %209, 3, 1
  %215 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %209, 4, 0
  %216 = extractvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %209, 4, 1
  %217 = load { ptr, ptr, i64, [1 x i64], [1 x i64] }, ptr %26, align 8
  %218 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %217, 0
  %219 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %217, 1
  %220 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %217, 2
  %221 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %217, 3, 0
  %222 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %217, 4, 0
  %223 = load { ptr, ptr, i64, [3 x i64], [3 x i64] }, ptr %27, align 8
  %224 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %223, 0
  %225 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %223, 1
  %226 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %223, 2
  %227 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %223, 3, 0
  %228 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %223, 3, 1
  %229 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %223, 3, 2
  %230 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %223, 4, 0
  %231 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %223, 4, 1
  %232 = extractvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %223, 4, 2
  call void @main(ptr %30, ptr %31, i64 %32, i64 %33, i64 %34, ptr %36, ptr %37, i64 %38, i64 %39, i64 %40, ptr %42, ptr %43, i64 %44, i64 %45, i64 %46, i64 %47, i64 %48, i64 %49, i64 %50, ptr %52, ptr %53, i64 %54, i64 %55, i64 %56, i64 %57, i64 %58, ptr %60, ptr %61, i64 %62, i64 %63, i64 %64, ptr %66, ptr %67, i64 %68, i64 %69, i64 %70, i64 %71, i64 %72, i64 %73, i64 %74, i64 %75, i64 %76, ptr %78, ptr %79, i64 %80, i64 %81, i64 %82, i64 %83, i64 %84, ptr %86, ptr %87, i64 %88, i64 %89, i64 %90, ptr %92, ptr %93, i64 %94, i64 %95, i64 %96, ptr %98, ptr %99, i64 %100, i64 %101, i64 %102, ptr %104, ptr %105, i64 %106, i64 %107, i64 %108, i64 %109, i64 %110, ptr %112, ptr %113, i64 %114, i64 %115, i64 %116, ptr %118, ptr %119, i64 %120, i64 %121, i64 %122, i64 %123, i64 %124, ptr %126, ptr %127, i64 %128, i64 %129, i64 %130, ptr %132, ptr %133, i64 %134, i64 %135, i64 %136, ptr %138, ptr %139, i64 %140, i64 %141, i64 %142, ptr %144, ptr %145, i64 %146, i64 %147, i64 %148, i64 %149, i64 %150, ptr %152, ptr %153, i64 %154, i64 %155, i64 %156, ptr %158, ptr %159, i64 %160, i64 %161, i64 %162, i64 %163, i64 %164, i64 %165, i64 %166, i64 %167, i64 %168, ptr %170, ptr %171, i64 %172, i64 %173, i64 %174, i64 %175, i64 %176, ptr %178, ptr %179, i64 %180, i64 %181, i64 %182, ptr %184, ptr %185, i64 %186, i64 %187, i64 %188, ptr %190, ptr %191, i64 %192, i64 %193, i64 %194, ptr %196, ptr %197, i64 %198, i64 %199, i64 %200, i64 %201, i64 %202, ptr %204, ptr %205, i64 %206, i64 %207, i64 %208, ptr %210, ptr %211, i64 %212, i64 %213, i64 %214, i64 %215, i64 %216, ptr %218, ptr %219, i64 %220, i64 %221, i64 %222, ptr %224, ptr %225, i64 %226, i64 %227, i64 %228, i64 %229, i64 %230, i64 %231, i64 %232)
  ret void
}

declare void @ukernel_bmm(ptr, ptr, i64, i64, i64, i64, i64, i64, i64, ptr, ptr, i64, i64, i64, i64, i64, i64, i64, ptr, ptr, i64, i64, i64, i64, i64, i64, i64)

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly, ptr noalias readonly, i64, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.sqrt.f32(float) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.maximum.f32(float, float) #2

attributes #0 = { memory(none) }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
