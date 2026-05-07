import os
import sys
import asyncio
import json
import mlir.ir as ir
from mlir.ir import Context, Module, Location, InsertionPoint, F64Type, FloatAttr, StringAttr, UnitAttr
from mlir.dialects import arith, func, builtin, memref, scf
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
    Upgraded for Milestone 3: Supports scf.for and memref.
    """
    os.makedirs(os.path.dirname(cache_filepath), exist_ok=True)
    with Context() as ctx:
        ctx.attach_diagnostic_handler(lambda d: True)
        with Location.unknown():
            module = Module.create()
            try:
                with InsertionPoint(module.body):
                    f64 = F64Type.get()
                    i32 = ir.IntegerType.get_signless(32)
                    i8 = ir.IntegerType.get_signless(8)
                    i1 = ir.IntegerType.get_signless(1)
                    index_t = ir.IndexType.get()

                    def get_type(t_str):
                        t_str = t_str.lower()
                        if t_str == "f64": return f64
                        if t_str == "i32": return i32
                        if t_str == "i8": return i8
                        if t_str == "i1": return i1
                        if t_str == "index": return index_t
                        if t_str.startswith("memref"):
                            if "f64" in t_str: inner = f64
                            elif "i32" in t_str: inner = i32
                            elif "i8" in t_str: inner = i8
                            else: inner = f64
                            # Use get_dynamic_size() for better compatibility
                            return ir.MemRefType.get([ir.ShapedType.get_dynamic_size()], inner)
                        return f64

                    # 1. Signature
                    input_types = []
                    arg_names = []
                    # Signature keys might be arg0, arg1 or names like arg_len
                    for arg_name, arg_type in verified_mlir_data.signature.items():
                        if arg_name == "return": continue
                        input_types.append(get_type(arg_type))
                        arg_names.append(arg_name)
                    
                    res_type_str = verified_mlir_data.signature.get("return", verified_mlir_data.return_type)
                    res_type = get_type(res_type_str)
                    func_type = builtin.FunctionType.get(inputs=input_types, results=[res_type])
                    mlir_func = func.FuncOp(name=verified_mlir_data.function_name, type=func_type)
                    mlir_func.attributes["llvm.emit_c_interface"] = UnitAttr.get()
                    mlir_func.add_entry_block()
                    
                    ssa_map = {}

                    def process_ops(ops, ip):
                        with ip:
                            for op_data in ops:
                                def resolve(s):
                                    if s in ssa_map: return ssa_map[s]
                                    if s.startswith("%arg") and s[4:].isdigit():
                                        idx = int(s[4:])
                                        if idx < len(mlir_func.entry_block.arguments):
                                            return mlir_func.entry_block.arguments[idx]
                                    try:
                                        val = float(s)
                                        if val.is_integer():
                                            return arith.ConstantOp(i32, ir.IntegerAttr.get(i32, int(val))).result
                                        return arith.ConstantOp(f64, ir.FloatAttr.get(f64, val)).result
                                    except:
                                        return arith.ConstantOp(f64, ir.FloatAttr.get(f64, 0.0)).result

                                res = None
                                if op_data.op == "constant":
                                    t = get_type(op_data.attributes.get("type", "f64"))
                                    if t == index_t:
                                        res = arith.ConstantOp(index_t, ir.IntegerAttr.get(index_t, int(op_data.args[0]))).result
                                    elif t == i32:
                                        res = arith.ConstantOp(i32, ir.IntegerAttr.get(i32, int(op_data.args[0]))).result
                                    else:
                                        res = arith.ConstantOp(f64, ir.FloatAttr.get(f64, float(op_data.args[0]))).result
                                
                                elif op_data.op == "addf": res = arith.AddFOp(resolve(op_data.args[0]), resolve(op_data.args[1])).result
                                elif op_data.op == "subf": res = arith.SubFOp(resolve(op_data.args[0]), resolve(op_data.args[1])).result
                                elif op_data.op == "mulf": res = arith.MulFOp(resolve(op_data.args[0]), resolve(op_data.args[1])).result
                                elif op_data.op == "divf": res = arith.DivFOp(resolve(op_data.args[0]), resolve(op_data.args[1])).result
                                elif op_data.op == "cmpi" or op_data.op == "cmp_eq":
                                    # Handle cmpi with predicate (default to eq/0)
                                    pred_map = {"eq": 0, "ne": 1, "slt": 2, "sle": 3, "sgt": 4, "sge": 5, "ult": 6, "ule": 7, "ugt": 8, "uge": 9}
                                    p_str = op_data.attributes.get("predicate", "eq")
                                    p_val = pred_map.get(p_str, 0)
                                    res = arith.CmpIOp(p_val, resolve(op_data.args[0]), resolve(op_data.args[1])).result
                                
                                elif op_data.op == "cmpf":
                                    # Handle cmpf with predicate (default to ueq/1)
                                    # Predicates: false, oeq, ogt, oge, olt, ole, one, ord, ueq, ugt, uge, ult, ule, une, uno, true
                                    pred_map = {
                                        "false": 0, "oeq": 1, "ogt": 2, "oge": 3, "olt": 4, "ole": 5, "one": 6, "ord": 7,
                                        "ueq": 8, "ugt": 9, "uge": 10, "ult": 11, "ule": 12, "une": 13, "uno": 14, "true": 15
                                    }
                                    p_str = op_data.attributes.get("predicate", "oeq")
                                    p_val = pred_map.get(p_str, 1)
                                    res = arith.CmpFOp(p_val, resolve(op_data.args[0]), resolve(op_data.args[1])).result

                                elif op_data.op == "select":
                                    res = arith.SelectOp(resolve(op_data.args[0]), resolve(op_data.args[1]), resolve(op_data.args[2])).result
                                
                                elif op_data.op == "load":
                                    mem = resolve(op_data.args[0])
                                    idx = resolve(op_data.args[1])
                                    res = memref.LoadOp(mem, [idx]).result
                                
                                elif op_data.op == "call":
                                    callee = op_data.args[0].replace("@", "")
                                    args = [resolve(a) for a in op_data.args[1:]]
                                    # Heuristic: if target_var suggests boolean, use i1
                                    res_types = [f64]
                                    if op_data.target_var:
                                        if any(k in op_data.target_var for k in ["is_", "result", "bool", "cmp"]):
                                            res_types = [i1]
                                    
                                    # Declarations are tricky in the Python bindings without a SymbolTable
                                    # For now, we'll try to just emit the call and hope it resolves
                                    res = func.CallOp(res_types, ir.FlatSymbolRefAttr.get(callee), args).results[0]

                                elif op_data.op == "if":
                                    cond = resolve(op_data.args[0])
                                    # Heuristic: if target_var is present, assume f64 result
                                    # In a real system, we'd look up the type from the context
                                    res_types = [f64] if op_data.target_var else []
                                    has_else = op_data.else_ is not None or op_data.body is not None # fallback
                                    if_op = scf.IfOp(cond, res_types, has_else=has_else)
                                    
                                    if op_data.then:
                                        process_ops(op_data.then, InsertionPoint(if_op.then_block))
                                    
                                    if op_data.else_:
                                        process_ops(op_data.else_, InsertionPoint(if_op.else_block))
                                    
                                    res = if_op.results[0] if if_op.results else None

                                elif op_data.op == "for":
                                    lb = resolve(op_data.args[0])
                                    ub = resolve(op_data.args[1])
                                    step = resolve(op_data.args[2])
                                    init_args = [resolve(a) for a in op_data.attributes.get("init_args", [])]
                                    
                                    for_op = scf.ForOp(lb, ub, step, init_args)
                                    
                                    # Map induction variable and body arguments based on AI attributes
                                    body_args = op_data.attributes.get("body_args", [])
                                    if body_args:
                                        ssa_map[body_args[0]] = for_op.induction_variable
                                        for j in range(1, len(body_args)):
                                            iter_arg_name = op_data.attributes.get("init_args", [])[j-1]
                                            ssa_map[body_args[j]] = for_op.inner_iter_args[j-1]
                                            ssa_map[iter_arg_name] = for_op.inner_iter_args[j-1]
                                    else:
                                        ssa_map["%index"] = for_op.induction_variable
                                        for j, arg_name in enumerate(op_data.attributes.get("init_args", [])):
                                            ssa_map[arg_name] = for_op.inner_iter_args[j]
                                    
                                    process_ops(op_data.body, InsertionPoint(for_op.body))
                                    res = for_op.results[0] if for_op.results else None

                                elif op_data.op == "yield":
                                    scf.YieldOp([resolve(a) for a in op_data.args])
                                    continue

                                elif op_data.op == "return":
                                    func.ReturnOp([resolve(op_data.args[0])])
                                    continue
                                
                                if op_data.target_var: ssa_map[op_data.target_var] = res

                    # Initial SSA map with function arguments
                    for i, name in enumerate(arg_names):
                        ssa_map[name] = mlir_func.entry_block.arguments[i]
                        ssa_map[f"%{name}"] = mlir_func.entry_block.arguments[i]

                    process_ops(verified_mlir_data.operations, InsertionPoint(mlir_func.entry_block))

                # 3. Verify & Lower
                module.operation.verify()
                # Unified lowering pipeline: SCF -> CF -> LLVM, plus Arith, MemRef, and Index
                # We use a single string to ensure passes run in the correct order for type reconciliation
                pipeline = (
                    "builtin.module("
                        "convert-scf-to-cf,"
                        "convert-cf-to-llvm,"
                        "expand-strided-metadata,"
                        "finalize-memref-to-llvm,"
                        "convert-arith-to-llvm,"
                        "convert-index-to-llvm,"
                        "func.func(llvm-request-c-wrappers),"
                        "convert-func-to-llvm,"
                        "reconcile-unrealized-casts,"
                        "canonicalize"
                    ")"
                )
                pm = PassManager.parse(pipeline)
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
        query = "MATCH (f:Function) WHERE f.fqn STARTS WITH $mod RETURN f.fqn, f.code, f.arg_count, f.enum_map"
        results = session.run(query, mod=module_filter)
        for record in results:
            fqn, func_code, arg_count, enum_map_json = record["f.fqn"], record["f.code"], record["f.arg_count"], record["f.enum_map"]

            print(f"\n[OPTIMIZING] {fqn}...")

            intent = f"Function: {fqn}\nCode:\n{func_code}\n"
            if enum_map_json:
                intent += f"ENUM MAPPING FOR STRINGS: {enum_map_json}\n"

            base_json_path = os.path.join(MANUAL_CACHE_DIR, f"{fqn.replace('.', '_')}.json")
            base_json = ""
            if os.path.exists(base_json_path):
                with open(base_json_path, 'r') as f: base_json = f.read()
                print(f"   [PRIMING] Anchoring to {base_json_path}")

            intent = f"Optimize mathematical function: \n```python\n{func_code}\n```"
            try:
                verified_mlir = await verified_generation_loop(intent, func_code, arg_count, base_mlir_json=base_json)
                verified_mlir.function_name = fqn.split('.')[-1]
                
                # NEW: Store arg_mapping in Neo4j so Orchestrator knows what columns to project
                with driver.session() as session:
                    session.run("MATCH (f:Function {fqn: $fqn}) SET f.arg_mapping = $mapping", fqn=fqn, mapping=json.dumps(verified_mlir.arg_mapping))

                cache_path = os.path.join(CACHE_DIR, f"{fqn.replace('.', '_')}.json")
                build_and_cache_mlir(verified_mlir, cache_path)
            except Exception as e: print(f"   ❌ FAILED: {e}")
    driver.close()

if __name__ == "__main__":
    target = sys.argv[1] if len(sys.argv) > 1 else "legacy_shop"
    asyncio.run(aot_compile_all(target))
