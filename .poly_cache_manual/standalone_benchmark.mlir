
    module {
      func.func @compute_gravity(%arg0: f64, %arg1: f64) -> f64 {
        %c981 = arith.constant 9.81 : f64
        %c05 = arith.constant 0.5 : f64
        %c02 = arith.constant 0.2 : f64
        %0 = arith.mulf %arg0, %arg1 : f64
        %1 = arith.divf %0, %c981 : f64
        %2 = arith.mulf %arg0, %c05 : f64
        %3 = arith.addf %1, %2 : f64
        %4 = arith.mulf %arg1, %c02 : f64
        %5 = arith.subf %3, %4 : f64
        return %5 : f64
      }

      func.func @main() {
        %m1 = arith.constant 5000.0 : f64
        %m2 = arith.constant 1200.0 : f64
        %res = func.call @compute_gravity(%m1, %m2) : (f64, f64) -> f64
        
        // Print result using vector.print (simplest way to see output in mlir-runner)
        %v = vector.broadcast %res : f64 to vector<1xf64>
        vector.print %v : vector<1xf64>
        return
      }
    }
    