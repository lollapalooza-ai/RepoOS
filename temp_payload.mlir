module attributes {transform.with_named_sequence} {
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

module attributes {transform.with_named_sequence} {
  transform.named_sequence @__transform_main(%root: !transform.any_op) {
    %func = transform.structured.match ops{"["} "func.func" {"]"} in %root : (!transform.any_op) -> !transform.any_op
    %main_loop = transform.structured.match ops{"["} "scf.for" {"]"} in %func : (!transform.any_op) -> !transform.any_op
    
    // Per the prompt, tiling is disabled. We proceed with vectorization and unrolling.
    // The typical order is to vectorize the innermost loop and unroll an outer one.
    // We choose a vector size of 4, suitable for f64 on AVX256 registers.
    // Note: The baseline IR's use of `!llvm.ptr` and `scf.switch` makes it a
    // non-trivial target for standard vectorizers. This script assumes a
    // vectorizer capable of generating gather/scatter and masked operations.
    // The unconventional syntax `... : !transform.any_op` without a return value
    // is followed precisely as instructed.
    transform.structured.vectorize %main_loop { vector_sizes = [4] } : !transform.any_op
    
    // After vectorization, the original loop is transformed. We re-match the `scf.for`
    // operation, which now represents the loop iterating over vector-sized chunks.
    %outer_loop = transform.structured.match ops{"["} "scf.for" {"]"} in %func : (!transform.any_op) -> !transform.any_op
    
    // Unroll the outer loop to reduce loop overhead and improve ILP.
    // An unroll factor of 4 is chosen. Combined with the vector size of 4, this
    // processes 16 elements per unrolled loop body.
    transform.loop.unroll %outer_loop { factor = 4 }
    
    // Lower the entire function's vector operations to the AVX2 instruction set
    // for the x86_64 target. This pass converts `vector` dialect ops into
    // target-specific `llvm` dialect intrinsics.
    transform.vector.lower_to_avx %func { avx2 }
  }
}
}