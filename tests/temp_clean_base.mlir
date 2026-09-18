module {
  llvm.mlir.global internal constant @_PROCESSED_KEY("PROCESSED\00") : !llvm.array<10 x i8>
  llvm.mlir.global internal constant @_PENDING_KEY("PENDING\00") : !llvm.array<8 x i8>
  llvm.mlir.global internal constant @_CANCELLED_KEY("CANCELLED\00") : !llvm.array<10 x i8>
  llvm.func @strcmp_external(!llvm.ptr, !llvm.ptr) -> i32
func.func @calculate_status_revenues_mlir(%arg0: !llvm.ptr, %arg1: i64) -> (!llvm.struct<(f64, f64, f64)>) {
    %c0_i32 = arith.constant 0 : i32
            %c1_i32 = arith.constant 1 : i32
            %c0_i64 = arith.constant 0 : i64
            %c1_i64 = arith.constant 1 : i64
            %c0_f64 = arith.constant 0.0 : f64
    %processed_revenue_var = llvm.alloca %c1_i64 : f64
            %pending_revenue_var = llvm.alloca %c1_i64 : f64
            %cancelled_revenue_var = llvm.alloca %c1_i64 : f64
    
            llvm.store %c0_f64, %processed_revenue_var : f64, !llvm.ptr
            llvm.store %c0_f64, %pending_revenue_var : f64, !llvm.ptr
            llvm.store %c0_f64, %cancelled_revenue_var : f64, !llvm.ptr
    %processed_key_ptr_array = llvm.mlir.addressof @_PROCESSED_KEY : !llvm.array<10 x i8>
            %processed_key_ptr = llvm.getelementptr %processed_key_ptr_array[%c0_i64, %c0_i64] : !llvm.array<10 x i8>, i64
    
            %pending_key_ptr_array = llvm.mlir.addressof @_PENDING_KEY : !llvm.array<8 x i8>
            %pending_key_ptr = llvm.getelementptr %pending_key_ptr_array[%c0_i64, %c0_i64] : !llvm.array<8 x i8>, i64
    
            %cancelled_key_ptr_array = llvm.mlir.addressof @_CANCELLED_KEY : !llvm.array<10 x i8>
            %cancelled_key_ptr = llvm.getelementptr %cancelled_key_ptr_array[%c0_i64, %c0_i64] : !llvm.array<10 x i8>, i64
    %loop_start_index = arith.constant 0 : i64
            %orders_count_i64 = %arg1 : i64
    
            scf.for %index = %loop_start_index to %orders_count_i64 step %c1_i64 {
    // Get address of the current Order struct in the array.
                %current_order_ptr = llvm.getelementptr %arg0[%index] : !llvm.ptr, i64
    
                // Load 'status' (field 0: !llvm.ptr to string).
                %status_ptr_addr = llvm.getelementptr %current_order_ptr, %c0_i32 : !llvm.ptr, i32
                %status_string_ptr = llvm.load %status_ptr_addr : !llvm.ptr, !llvm.ptr
    
                // Load 'cart' struct (field 1: !llvm.struct<(f64)>).
                %cart_struct_addr = llvm.getelementptr %current_order_ptr, %c1_i32 : !llvm.ptr, i32
                // Load 'total_value' from the Cart struct (field 0: f64).
                %total_value_addr = llvm.getelementptr %cart_struct_addr, %c0_i32 : !llvm.ptr, i32
                %total_value = llvm.load %total_value_addr : !llvm.ptr, f64
    // Compare status_string_ptr with "PROCESSED"
                %is_processed_res = llvm.call @strcmp_external(%status_string_ptr, %processed_key_ptr) : (!llvm.ptr, !llvm.ptr) -> i32
                %is_processed = arith.cmpi "eq", %is_processed_res, %c0_i32 : i32
                scf.if %is_processed {
                    %current_processed = llvm.load %processed_revenue_var : !llvm.ptr, f64
                    %new_processed = arith.addf %current_processed, %total_value : f64
                    llvm.store %new_processed, %processed_revenue_var : f64, !llvm.ptr
                } else {
                    // Compare with "PENDING"
                    %is_pending_res = llvm.call @strcmp_external(%status_string_ptr, %pending_key_ptr) : (!llvm.ptr, !llvm.ptr) -> i32
                    %is_pending = arith.cmpi "eq", %is_pending_res, %c0_i32 : i32
                    scf.if %is_pending {
                        %current_pending = llvm.load %pending_revenue_var : !llvm.ptr, f64
                        %new_pending = arith.addf %current_pending, %total_value : f64
                        llvm.store %new_pending, %pending_revenue_var : f64, !llvm.ptr
                    } else {
                        // Compare with "CANCELLED"
                        %is_cancelled_res = llvm.call @strcmp_external(%status_string_ptr, %cancelled_key_ptr) : (!llvm.ptr, !llvm.ptr) -> i32
                        %is_cancelled = arith.cmpi "eq", %is_cancelled_res, %c0_i32 : i32
                        scf.if %is_cancelled {
                            %current_cancelled = llvm.load %cancelled_revenue_var : !llvm.ptr, f64
                            %new_cancelled = arith.addf %current_cancelled, %total_value : f64
                            llvm.store %new_cancelled, %cancelled_revenue_var : f64, !llvm.ptr
                        }
                    }
                }
    } // end scf.for
    %final_processed = llvm.load %processed_revenue_var : !llvm.ptr, f64
            %final_pending = llvm.load %pending_revenue_var : !llvm.ptr, f64
            %final_cancelled = llvm.load %cancelled_revenue_var : !llvm.ptr, f64
    
            %result_struct = llvm.mlir.undef : !llvm.struct<(f64, f64, f64)>
            %result_struct_0 = llvm.insertvalue %final_processed, %result_struct[0] : !llvm.struct<(f64, f64, f64)>
            %result_struct_1 = llvm.insertvalue %final_pending, %result_struct_0[1] : !llvm.struct<(f64, f64, f64)>
            %result_struct_2 = llvm.insertvalue %final_cancelled, %result_struct_1[2] : !llvm.struct<(f64, f64, f64)>
            llvm.return %result_struct_2 : !llvm.struct<(f64, f64, f64)>
  }
}
