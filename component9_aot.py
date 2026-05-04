import os
import sys
import asyncio
import json
import mlir.ir as ir
from mlir.ir import Context, Module, Location, InsertionPoint, F64Type, FloatAttr, StringAttr, UnitAttr
from mlir.dialects import arith, func, builtin, memref
from mlir.passmanager import PassManager
from component2_smt import verified_generation_loop, VerifiedMLIR
from neo4j import GraphDatabase

NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
CACHE_DIR = "./.poly_cache3"
MANUAL_CACHE_DIR = "./.poly_cache_manual"

def build_and_cache_mlir(verified_mlir_data: VerifiedMLIR, cache_filepath: str):
    """
    Translates AI's optimized JSON into formal MLIR.
    """
    os.makedirs(os.path.dirname(cache_filepath), exist_ok=True)
    with Context() as ctx:
        ctx.attach_diagnostic_handler(lambda d: True)
        with Location.unknown():
            module = Module.create()
            try:
                with InsertionPoint(module.body):
                    f64 = F64Type.get()
                    
                    # 1. Signature
                    input_types = []
                    arg_names = []
                    for arg_name, arg_type in verified_mlir_data.signature.items():
                        if arg_name == "return": continue
                        input_types.append(f64) # Currently all math is f64
                        arg_names.append(arg_name)
                    
                    func_type = builtin.FunctionType.get(inputs=input_types, results=[f64])
                    mlir_func = func.FuncOp(name=verified_mlir_data.function_name, type=func_type)
                    mlir_func.attributes["llvm.emit_c_interface"] = UnitAttr.get()
                    mlir_func.add_entry_block()
                    
                    with InsertionPoint(mlir_func.entry_block):
                        ssa_map = {}
                        for i, name in enumerate(arg_names):
                            ssa_map[name] = mlir_func.entry_block.arguments[i]
                            ssa_map[f"%{name}"] = mlir_func.entry_block.arguments[i]
                        
                        # 2. Ops
                        for op_data in verified_mlir_data.operations:
                            def resolve(s):
                                if s in ssa_map: return ssa_map[s]
                                try: return arith.ConstantOp(f64, FloatAttr.get(f64, float(s))).result
                                except: return arith.ConstantOp(f64, FloatAttr.get(f64, 0.0)).result
                            
                            if op_data.op == "constant":
                                res = arith.ConstantOp(f64, FloatAttr.get(f64, float(op_data.args[0]))).result
                            elif op_data.op == "addf": res = arith.AddFOp(resolve(op_data.args[0]), resolve(op_data.args[1])).result
                            elif op_data.op == "subf": res = arith.SubFOp(resolve(op_data.args[0]), resolve(op_data.args[1])).result
                            elif op_data.op == "mulf": res = arith.MulFOp(resolve(op_data.args[0]), resolve(op_data.args[1])).result
                            elif op_data.op == "divf": res = arith.DivFOp(resolve(op_data.args[0]), resolve(op_data.args[1])).result
                            elif op_data.op == "return":
                                func.ReturnOp([resolve(op_data.args[0])])
                                continue
                            else: continue
                            if op_data.target_var: ssa_map[op_data.target_var] = res

                # 3. Verify & Lower
                module.operation.verify()
                pm = PassManager.parse("builtin.module(convert-scf-to-cf, convert-cf-to-llvm, convert-arith-to-llvm, func.func(llvm-request-c-wrappers), convert-func-to-llvm, reconcile-unrealized-casts)")
                pm.run(module.operation)
                
                cache_filepath = cache_filepath.replace('.json', '.mlir')
                with open(cache_filepath, "w") as f: f.write(str(module))
                print(f"   [OK] Compiled MLIR: {cache_filepath}")

                # 4. AOT Compilation to .dylib
                ll_path = cache_filepath.replace('.mlir', '.ll')
                dylib_path = cache_filepath.replace('.mlir', '.dylib')
                
                # Step A: MLIR -> LLVM IR
                translate_bin = "/Users/yeshr/Applications/Program1/llvm-project/build/bin/mlir-translate"
                os.system(f"{translate_bin} --mlir-to-llvmir {cache_filepath} -o {ll_path}")
                
                # Step B: LLVM IR -> .dylib (using system clang)
                os.system(f"clang -shared -O3 {ll_path} -o {dylib_path}")
                print(f"   [OK] Compiled AOT: {dylib_path}")

            except Exception as e: print(f"   [ERROR] build failed: {e}")

async def aot_compile_all(module_filter: str = ""):
    driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
    print(f"\n--- 🚀 Starting Unified AI-Optimization Loop ---")
    with driver.session() as session:
        query = "MATCH (f:Function) WHERE f.fqn STARTS WITH $mod RETURN f.fqn, f.code, f.arg_count"
        results = session.run(query, mod=module_filter)
        for record in results:
            fqn, func_code, arg_count = record["f.fqn"], record["f.code"], record["f.arg_count"]
            if "math" not in fqn and "calculate" not in fqn and "pricing" not in fqn: continue
            
            print(f"\n[OPTIMIZING] {fqn}...")
            
            # Anchor Logic
            base_json_path = os.path.join(MANUAL_CACHE_DIR, f"{fqn.replace('.', '_')}.json")
            base_json = ""
            if os.path.exists(base_json_path):
                with open(base_json_path, 'r') as f: base_json = f.read()
                print(f"   [PRIMING] Anchoring to {base_json_path}")

            intent = f"Optimize mathematical function: \n```python\n{func_code}\n```"
            try:
                verified_mlir = await verified_generation_loop(intent, func_code, arg_count, base_mlir_json=base_json)
                verified_mlir.function_name = fqn.split('.')[-1]
                cache_path = os.path.join(CACHE_DIR, f"{fqn.replace('.', '_')}.json")
                build_and_cache_mlir(verified_mlir, cache_path)
            except Exception as e: print(f"   ❌ FAILED: {e}")
    driver.close()

if __name__ == "__main__":
    target = sys.argv[1] if len(sys.argv) > 1 else "legacy_shop"
    asyncio.run(aot_compile_all(target))
