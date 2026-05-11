import os
import sys
import asyncio
import json
import subprocess
import shutil
import mlir.ir as ir
from mlir.ir import Context, Module, Location, InsertionPoint, F64Type, FloatAttr, StringAttr, UnitAttr
from mlir.dialects import arith, func, builtin, memref, scf, math, llvm
from mlir.passmanager import PassManager
from component2_smt import verified_generation_loop, VerifiedMLIR
from neo4j import GraphDatabase

NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
CACHE_DIR = os.getenv("REPOOS_CACHE_DIR", "./.poly_cache3")
MANUAL_CACHE_DIR = os.getenv("REPOOS_MANUAL_CACHE_DIR", "./.poly_cache_manual")

LLVM_BIN_DIR = "/Users/yeshr/Applications/Program1/llvm-project/build/bin"
MLIR_OPT = os.path.join(LLVM_BIN_DIR, "mlir-opt")
MLIR_TRANSLATE = os.path.join(LLVM_BIN_DIR, "mlir-translate")
CLANG = "/usr/bin/clang"

def sanitize_fqn(fqn: str):
    for pkg in ["networkx", "legacy_shop", "django", "numpy", "scipy"]:
        if pkg in fqn:
            idx = fqn.find(pkg)
            return fqn[idx:].replace('.', '_').replace('-', '_')
    return fqn.replace('.', '_').replace('-', '_')

def build_and_cache_mlir(verified_mlir_data: VerifiedMLIR, cache_filepath: str):
    os.makedirs(os.path.dirname(cache_filepath), exist_ok=True)
    base_path, _ = os.path.splitext(cache_filepath)
    mlir_path, opt_mlir_path, ll_path, dylib_path = f"{base_path}.mlir", f"{base_path}_opt.mlir", f"{base_path}.ll", f"{base_path}.dylib"

    with Context() as ctx:
        ctx.attach_diagnostic_handler(lambda d: True)
        with Location.unknown():
            module = Module.create()
            try:
                with InsertionPoint(module.body):
                    f64, i32, i64, index_t, ptr_t = F64Type.get(), ir.IntegerType.get_signless(32), ir.IntegerType.get_signless(64), ir.IndexType.get(), llvm.PointerType.get()
                    def get_type(t):
                        t = str(t).lower()
                        if t == "f64": return f64
                        if t == "i32": return i32
                        if t == "i64": return i64
                        if t == "index": return index_t
                        if t == "ptr" or t == "llvm.ptr" or t.startswith("memref"): return ptr_t
                        return None
                    
                    input_types = [ptr_t]
                    for k,v in verified_mlir_data.signature.items():
                        if k != "return": input_types.append(get_type(v))
                    
                    mlir_func = func.FuncOp(name=verified_mlir_data.function_name, type=builtin.FunctionType.get(inputs=input_types, results=[]))
                    mlir_func.add_entry_block()
                    
                    def process_ops(ops, ip, ssa_map):
                        with ip:
                            for op_data in ops:
                                def resolve(s):
                                    if not s: return None
                                    if s in ssa_map: return ssa_map[s]
                                    if s.startswith("%arg") and s[4:].isdigit(): return mlir_func.entry_block.arguments[int(s[4:])]
                                    try: 
                                        if "." in s: return arith.ConstantOp(f64, ir.FloatAttr.get(f64, float(s))).result
                                        return arith.ConstantOp(i64, ir.IntegerAttr.get(i64, int(s))).result
                                    except: return arith.ConstantOp(f64, ir.FloatAttr.get(f64, 0.0)).result

                                def cast_to_i64(val):
                                    if str(val.type) == "index":
                                        return arith.IndexCastOp(i64, val).result
                                    return val

                                res = None
                                if op_data.dialect == "llvm":
                                    if op_data.op == "getelementptr":
                                        # FIX: Cast dynamic indices from 'index' to 'i64' for LLVM compatibility
                                        raw_indices = [resolve(a) for a in op_data.args[1:]]
                                        i64_indices = [cast_to_i64(idx) for idx in raw_indices]
                                        res = llvm.GEPOp(ptr_t, resolve(op_data.args[0]), i64_indices, [-2147483648], f64, 0).result
                                    elif op_data.op == "load":
                                        res = llvm.LoadOp(f64, resolve(op_data.args[0])).result
                                    elif op_data.op == "store":
                                        v_to_store, p_to_store = resolve(op_data.args[0]), resolve(op_data.args[1])
                                        if v_to_store and p_to_store: llvm.StoreOp(v_to_store, p_to_store)
                                        continue
                                elif op_data.op == "constant":
                                    t = get_type(op_data.attributes.get("type", "f64"))
                                    v = op_data.args[0] if op_data.args else op_data.attributes.get("value", "0.0")
                                    if t == index_t: res = arith.ConstantOp(index_t, ir.IntegerAttr.get(index_t, int(float(v)))).result
                                    elif t == i64: res = arith.ConstantOp(i64, ir.IntegerAttr.get(i64, int(float(v)))).result
                                    else: res = arith.ConstantOp(f64, ir.FloatAttr.get(f64, float(v))).result
                                elif op_data.op == "addf": res = arith.AddFOp(resolve(op_data.args[0]), resolve(op_data.args[1])).result
                                elif op_data.op == "divf": res = arith.DivFOp(resolve(op_data.args[0]), resolve(op_data.args[1])).result
                                elif op_data.op == "addi": res = arith.AddIOp(resolve(op_data.args[0]), resolve(op_data.args[1])).result
                                elif op_data.op == "for":
                                    ia = [resolve(a) for a in op_data.attributes.get("init_args", [])]
                                    for_op = scf.ForOp(resolve(op_data.args[0]), resolve(op_data.args[1]), resolve(op_data.args[2]), ia)
                                    body_map = ssa_map.copy()
                                    ba = op_data.attributes.get("body_args", ["%iv"])
                                    body_map[ba[0]] = for_op.induction_variable
                                    for j in range(1, len(ba)): body_map[ba[j]] = for_op.inner_iter_args[j-1]
                                    process_ops(op_data.body, InsertionPoint(for_op.body), body_map)
                                    with InsertionPoint(for_op.body):
                                        if not any(isinstance(o.opview, scf.YieldOp) for o in for_op.body.operations):
                                            scf.YieldOp(for_op.inner_iter_args)
                                    res = for_op.results[0] if for_op.results else None
                                elif op_data.op == "yield":
                                    scf.YieldOp([resolve(a) for a in op_data.args if a])
                                    continue
                                elif op_data.op == "return":
                                    if op_data.args:
                                        v_ret = resolve(op_data.args[0])
                                        if v_ret: llvm.StoreOp(v_ret, mlir_func.entry_block.arguments[0])
                                    func.ReturnOp([])
                                    continue
                                if op_data.target_var: ssa_map[op_data.target_var] = res

                    main_map = {}
                    for i, (k,v) in enumerate(verified_mlir_data.signature.items()):
                        if k != "return": main_map[k] = main_map[f"%{k}"] = mlir_func.entry_block.arguments[i+1]
                    process_ops(verified_mlir_data.operations, InsertionPoint(mlir_func.entry_block), main_map)

                with open(mlir_path, "w") as f: f.write(str(module))
                pipeline = "builtin.module(convert-scf-to-cf,convert-math-to-llvm,convert-arith-to-llvm,convert-index-to-llvm,convert-func-to-llvm,convert-cf-to-llvm,reconcile-unrealized-casts,canonicalize)"
                subprocess.run([MLIR_OPT, mlir_path, f"-pass-pipeline={pipeline}", "-o", opt_mlir_path], check=True)
                subprocess.run([MLIR_TRANSLATE, "--mlir-to-llvmir", opt_mlir_path, "-o", ll_path], check=True)
                subprocess.run([CLANG, "-shared", "-O3", ll_path, "-o", dylib_path, "-lm"], check=True)
                print(f"   [OK] Compiled: {dylib_path}")
            except Exception as e: print(f"   [ERROR] build failed: {e}")

async def aot_compile_all(module_filter: str = ""):
    if os.path.exists(CACHE_DIR): shutil.rmtree(CACHE_DIR)
    os.makedirs(CACHE_DIR)
    driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
    print(f"\n--- 🚀 Milestone 5: Stable Bare-Metal Pipeline ---")
    with driver.session() as session:
        query = "MATCH (f:Function)-[:HAS_CHUNK]->(c:Chunk) WHERE f.fqn CONTAINS $mod RETURN c.fqn, c.code, c.inputs"
        results = session.run(query, mod=module_filter)
        for record in results:
            fqn, chunk_code, inputs_json = record["c.fqn"], record["c.code"], record["c.inputs"]
            sanitized = sanitize_fqn(fqn)
            print(f"\n[AOT] {fqn} -> {sanitized}...")
            base_json_path = os.path.join(MANUAL_CACHE_DIR, f"{sanitized}.json")
            if os.path.exists(base_json_path):
                print(f"   [STRICT] Using verified manual template: {base_json_path}")
                with open(base_json_path, 'r') as f: verified_mlir = VerifiedMLIR.model_validate(json.load(f))
            else:
                verified_mlir = await verified_generation_loop(f"Optimize: \n{chunk_code}", chunk_code, len(json.loads(inputs_json)))
            verified_mlir.function_name = sanitized
            with driver.session() as session:
                session.run("MATCH (c:Chunk {fqn: $fqn}) SET c.arg_mapping = $mapping, c.signature = $sig, c.sanitized_name = $sn", 
                            fqn=fqn, mapping=json.dumps(verified_mlir.arg_mapping), sig=json.dumps(verified_mlir.signature), sn=sanitized)
            build_and_cache_mlir(verified_mlir, os.path.join(CACHE_DIR, f"{sanitized}.json"))
    driver.close()

if __name__ == "__main__":
    target_mod = sys.argv[1] if len(sys.argv) > 1 else "legacy_shop"
    asyncio.run(aot_compile_all(target_mod))
