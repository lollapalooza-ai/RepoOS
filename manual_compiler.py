import os
import sys
import ast
import json
from neo4j import GraphDatabase
from component2_smt import VerifiedMLIR, MLIROperation

import mlir.ir as ir
from mlir.ir import Context, Module, Location, InsertionPoint, F64Type, FloatAttr, StringAttr, UnitAttr
from mlir.dialects import arith, func, builtin, memref
from mlir.passmanager import PassManager

NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
OUTPUT_DIR = "./.poly_cache_manual"

def build_standalone_benchmark_mlir(func_name: str, func_code: str, arg_count: int):
    """
    Generates a standalone .mlir file with a 'main' function for mlir-runner.
    Proof-of-concept for compute_gravity.
    """
    stable_mlir = f"""
    module {{
      func.func @{func_name}(%arg0: f64, %arg1: f64) -> f64 {{
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
      }}

      func.func @main() {{
        %m1 = arith.constant 5000.0 : f64
        %m2 = arith.constant 1200.0 : f64
        %res = func.call @{func_name}(%m1, %m2) : (f64, f64) -> f64
        
        // Print result using vector.print (simplest way to see output in mlir-runner)
        %v = vector.broadcast %res : f64 to vector<1xf64>
        vector.print %v : vector<1xf64>
        return
      }}
    }}
    """
    path = os.path.join(OUTPUT_DIR, "standalone_benchmark.mlir")
    with open(path, "w") as f:
        f.write(stable_mlir)
    print(f"✅ Standalone benchmark MLIR written to {path}")

if __name__ == "__main__":
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    build_standalone_benchmark_mlir("compute_gravity", "", 2)
