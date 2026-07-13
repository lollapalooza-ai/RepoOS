module {
func.func @calculate_status_revenues(%arg0: memref<?x!llvm.ptr>) -> (memref<3xf64>) {
    %c0 = arith.constant 0 : index
            %c1 = arith.constant 1 : index
            %c2 = arith.constant 2 : index
            %c3 = arith.constant 3 : index // Used for loop upper bound calculations if needed, though %num_orders is derived dynamically
            %f0 = arith.constant 0.0 : f64
            %i0 = arith.constant 0 : i32 // Status code for PROCESSED
            %i1 = arith.constant 1 : i32 // Status code for PENDING
            %i2 = arith.constant 2 : i32 // Status code for CANCELLED
    %revenues_memref = memref.alloc() : memref<3xf64>
            memref.store %f0, %revenues_memref[%c0] : memref<3xf64>
            memref.store %f0, %revenues_memref[%c1] : memref<3xf64>
            memref.store %f0, %revenues_memref[%c2] : memref<3xf64>
    %num_orders = memref.dim %arg0, %c0 : memref<?x!llvm.ptr>
    scf.for %i = %c0 to %num_orders step %c1 {
                // Load the pointer to the current order struct from the input memref
                %order_ptr = memref.load %arg0[%i] : memref<?x!llvm.ptr>
    
                // Load the actual struct value from the pointer. The concrete struct type
                // is !llvm.struct<(i32, f64)> as declared.
                %order_struct_val = llvm.load %order_ptr : !llvm.ptr to !llvm.struct<(i32, f64)>
    
                // Extract status_code (i32) and total_value (f64) from the struct
                %status_code = llvm.extractvalue %order_struct_val[0] : !llvm.struct<(i32, f64)>
                %total_value = llvm.extractvalue %order_struct_val[1] : !llvm.struct<(i32, f64)>
    
                // Use scf.switch for branch-optimized handling of status codes
                scf.switch %status_code : i32, [
                    case %i0: { // PROCESSED (status_code = 0)
                        %current_revenue = memref.load %revenues_memref[%c0] : memref<3xf64>
                        %new_revenue = arith.addf %current_revenue, %total_value : f64
                        memref.store %new_revenue, %revenues_memref[%c0] : memref<3xf64>
                        scf.yield
                    },
                    case %i1: { // PENDING (status_code = 1)
                        %current_revenue = memref.load %revenues_memref[%c1] : memref<3xf64>
                        %new_revenue = arith.addf %current_revenue, %total_value : f64
                        memref.store %new_revenue, %revenues_memref[%c1] : memref<3xf64>
                        scf.yield
                    },
                    case %i2: { // CANCELLED (status_code = 2)
                        %current_revenue = memref.load %revenues_memref[%c2] : memref<3xf64>
                        %new_revenue = arith.addf %current_revenue, %total_value : f64
                        memref.store %new_revenue, %revenues_memref[%c2] : memref<3xf64>
                        scf.yield
                    }
                ] default: {
                    // For any other status code, do nothing (as per original Python logic's 'if status in revenues' behavior)
                    scf.yield
                }
            }
    return %revenues_memref : memref<3xf64>
  }
}
