import os
import sys
import asyncio
import json
import subprocess
import shutil
import mlir.ir as ir
from mlir.ir import Context, Module, Location, InsertionPoint, F64Type, FloatAttr, StringAttr, UnitAttr
from mlir.dialects import func, arith, scf, llvm, math
from neo4j import GraphDatabase
from component2_smt import VerifiedMLIR, verified_generation_loop, generate_optimization_heuristics, verify_llm_safety, synthesize_execution_contract
from compiler_passes import apply_compiler_heuristics

# Milestone 5: Stable Bare-Metal Pipeline
NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
CACHE_DIR = os.getenv("REPOOS_CACHE_DIR", "./.poly_cache3")
MANUAL_CACHE_DIR = os.getenv("REPOOS_MANUAL_CACHE_DIR", "./.poly_cache_manual")

# Compiler Paths
MLIR_OPT = "/Users/yeshr/Applications/Program1/llvm-project/build/bin/mlir-opt"
MLIR_TRANSLATE = "/Users/yeshr/Applications/Program1/llvm-project/build/bin/mlir-translate"
CLANG = "clang"

os.makedirs(CACHE_DIR, exist_ok=True)

def sanitize_fqn(fqn: str):
    """Generic naming logic that preserves unique context without hardcoding packages."""
    parts = fqn.split('.')
    if len(parts) > 3:
        base = "_".join(parts[-3:])
    else:
        base = "_".join(parts)
    return base.replace('-', '_')

def build_and_cache_mlir(verified_mlir_data: VerifiedMLIR, cache_json_path: str):
    sanitized = verified_mlir_data.function_name
    mlir_path = os.path.join(CACHE_DIR, f"{sanitized}.mlir")
    opt_mlir_path = os.path.join(CACHE_DIR, f"{sanitized}_opt.mlir")
    ll_path = os.path.join(CACHE_DIR, f"{sanitized}.ll")
    dylib_path = os.path.join(CACHE_DIR, f"{sanitized}.dylib")

    with Context() as ctx, Location.unknown():
        ctx.allow_unregistered_dialects = True
        module = Module.create()
        f64 = F64Type.get()
        i64 = ir.IntegerType.get_signless(64)
        ptr = llvm.PointerType.get(context=ctx)
        
        type_map = {"f64": f64, "i64": i64, "ptr": ptr, "void": None}
        
        with InsertionPoint(module.body):
            try:
                # 1. Build Native Function Signature
                arg_types = []
                ret_type_str = verified_mlir_data.signature.get("return", "f64")

                # Convention: If returning a value, it's passed as a result pointer in Arg0
                if ret_type_str != "void":
                    arg_types.append(ptr)

                for k, v in verified_mlir_data.signature.items():
                    if k == "return": continue
                    arg_types.append(type_map.get(v, f64))

                func_type = ir.FunctionType.get(arg_types, []) # Always return void in signature
                mlir_func = func.FuncOp(sanitized, func_type)
                mlir_func.add_entry_block()
                # REMOVED: llvm.emit_c_interface (Avoids descriptor structs)

                def process_ops(ops, ip, ssa_map):
                    if ops is None: return
                    with ip:
                        for op_data in ops:
                            # Robust terminator check
                            if len(ip.block.operations) > 0:
                                last_op_name = str(ip.block.operations[-1].operation.name)
                                if any(t in last_op_name for t in ["return", "yield", "br"]):
                                    break
                            ...

                            def get_attr(obj, name, default=None):
                                if hasattr(obj, name): return getattr(obj, name)
                                if isinstance(obj, dict): return obj.get(name, default)
                                return default

                            def resolve(s):
                                if not s: return None
                                if s in ssa_map: return ssa_map[s]
                                if s.startswith('%'):
                                    clean = s[1:]
                                    if clean in ssa_map: return ssa_map[clean]
                                    if '#' in clean: # Handle multi-result indexing
                                        base, idx = clean.split('#')
                                        if base in ssa_map: return ssa_map[s] # Already in map if handled by parent
                                # Fallback to constant
                                try: 
                                    if "." in s: return arith.ConstantOp(f64, ir.FloatAttr.get(f64, float(s))).result
                                    return arith.ConstantOp(i64, ir.IntegerAttr.get(i64, int(s))).result
                                except: return arith.ConstantOp(f64, ir.FloatAttr.get(f64, 0.0)).result

                            dialect = get_attr(op_data, "dialect")
                            op = get_attr(op_data, "op")
                            args = get_attr(op_data, "args", [])
                            attributes = get_attr(op_data, "attributes", {})
                            target_var = get_attr(op_data, "target_var")
                            body = get_attr(op_data, "body", [])

                            res = None
                            if dialect == "arith":
                                if op == "constant":
                                    v = args[0]
                                    t = attributes.get("type")
                                    if t == "index": res = arith.ConstantOp(ir.IndexType.get(), ir.IntegerAttr.get(ir.IndexType.get(), int(v))).result
                                    elif t == "i1": res = arith.ConstantOp(ir.IntegerType.get_signless(1), ir.IntegerAttr.get(ir.IntegerType.get_signless(1), int(v))).result
                                    elif t == "i64" or t == i64: res = arith.ConstantOp(i64, ir.IntegerAttr.get(i64, int(float(v)))).result
                                    else: res = arith.ConstantOp(f64, ir.FloatAttr.get(f64, float(v))).result
                                elif op == "addf": res = arith.AddFOp(resolve(args[0]), resolve(args[1])).result
                                elif op == "subf": res = arith.SubFOp(resolve(args[0]), resolve(args[1])).result
                                elif op == "mulf": res = arith.MulFOp(resolve(args[0]), resolve(args[1])).result
                                elif op == "divf": res = arith.DivFOp(resolve(args[0]), resolve(args[1])).result
                                elif op == "addi": res = arith.AddIOp(resolve(args[0]), resolve(args[1])).result
                                elif op == "subi": res = arith.SubIOp(resolve(args[0]), resolve(args[1])).result
                                elif op == "muli": res = arith.MulIOp(resolve(args[0]), resolve(args[1])).result
                                elif op == "cmpi": 
                                    pred = attributes.get("predicate", 0)
                                    lhs = resolve(args[0])
                                    rhs = resolve(args[1])
                                    if lhs and rhs:
                                        # Auto-bridge index vs integer
                                        if str(lhs.type) == "index" and str(rhs.type) != "index":
                                            rhs = arith.IndexCastOp(ir.IndexType.get(), rhs).result
                                        elif str(rhs.type) == "index" and str(lhs.type) != "index":
                                            lhs = arith.IndexCastOp(ir.IndexType.get(), lhs).result
                                        res = arith.CmpIOp(pred, lhs, rhs).result
                                elif op == "cmpf":
                                    pred = attributes.get("predicate", 1) # Default to oeq (1)
                                    lhs = resolve(args[0])
                                    rhs = resolve(args[1])
                                    if lhs and rhs:
                                        res = arith.CmpFOp(pred, lhs, rhs).result
                                elif op == "index_cast":
                                    out_type = ir.IndexType.get() if attributes.get("type") == "index" else i64
                                    res = arith.IndexCastOp(out_type, resolve(args[0])).result
                                elif op == "select":
                                    res = arith.SelectOp(resolve(args[0]), resolve(args[1]), resolve(args[2])).result
                            elif dialect == "math":
                                if op == "powf": res = math.PowFOp(resolve(args[0]), resolve(args[1])).result
                            elif dialect == "memref":
                                if op == "load":
                                    # memref.load args: [base, index]
                                    base = resolve(args[0])
                                    idx = resolve(args[1])
                                    if str(idx.type) == "index":
                                        idx = arith.IndexCastOp(i64, idx).result
                                    raw_consts = [-2147483648]
                                    gep = llvm.GEPOp(ptr, base, [idx], raw_consts, f64, llvm.GEPNoWrapFlags.none).result
                                    res = llvm.LoadOp(f64, gep).result
                                elif op == "store":
                                    # memref.store args: [value, base, index]
                                    val = resolve(args[0])
                                    base = resolve(args[1])
                                    idx = resolve(args[2])
                                    if str(idx.type) == "index":
                                        idx = arith.IndexCastOp(i64, idx).result
                                    raw_consts = [-2147483648]
                                    gep = llvm.GEPOp(ptr, base, [idx], raw_consts, f64, llvm.GEPNoWrapFlags.none).result
                                    llvm.StoreOp(val, gep)
                            elif dialect == "llvm":
                                if op == "getelementptr":
                                    raw_base = resolve(args[0])
                                    # --- ABI BRIDGE: Extract Raw Pointer from MemRef ---
                                    if str(raw_base.type).startswith("memref"):
                                        # Extract aligned pointer as index
                                        idx_ptr = ir.IndexType.get()
                                        raw_ptr_idx = ir.Operation.create(
                                            "memref.extract_aligned_pointer_as_index",
                                            results=[idx_ptr],
                                            operands=[raw_base]
                                        ).result
                                        # Cast index to i64 (pointer address)
                                        base_i64 = arith.IndexCastOp(i64, raw_ptr_idx).result
                                        # Cast i64 to llvm.ptr
                                        base = llvm.IntToPtrOp(ptr, base_i64).result
                                    else:
                                        base = raw_base
                                    # --------------------------------------------------
                                    
                                    raw_idx = resolve(args[1])
                                    # LLVM GEP requires signless integer indices, not 'index' type
                                    if str(raw_idx.type) == "index":
                                        # Use the current insertion point to add the cast
                                        idx = arith.IndexCastOp(i64, raw_idx).result
                                    else:
                                        idx = raw_idx
                                    
                                    # Signature: (res, base, dynamicIndices, rawConstantIndices, elem_type, noWrapFlags)
                                    raw_consts = [-2147483648]
                                    et = i64 if attributes.get("type") == "i64" else f64
                                    res = llvm.GEPOp(ptr, base, [idx], raw_consts, et, llvm.GEPNoWrapFlags.none).result
                                elif op == "load":
                                    t = i64 if attributes.get("type") == "i64" else f64
                                    res = llvm.LoadOp(t, resolve(args[0])).result
                                elif op == "store":
                                    llvm.StoreOp(resolve(args[0]), resolve(args[1]))
                            elif dialect == "scf":
                                if op == "for":
                                    ia = [resolve(a) for a in attributes.get("init_args", [])]
                                    # Determine result types from init_args
                                    res_types = [a.type for a in ia]
                                    
                                    for_op = scf.ForOp(resolve(args[0]), resolve(args[1]), resolve(args[2]), ia)
                                    body_map = ssa_map.copy()
                                    ba = attributes.get("body_args", ["%iv"])
                                    body_map[ba[0]] = for_op.induction_variable
                                    for j in range(1, len(ba)): body_map[ba[j]] = for_op.inner_iter_args[j-1]
                                    process_ops(body, InsertionPoint(for_op.body), body_map)

                                    # Ensure terminator
                                    with InsertionPoint(for_op.body):
                                        if len(for_op.body.operations) == 0 or not any(t in str(for_op.body.operations[-1].operation.name).lower() for t in ["return", "yield", "br"]):
                                            scf.YieldOp(for_op.inner_iter_args)

                                    if for_op.results:
                                        res = for_op.results[0]
                                        for k, r in enumerate(for_op.results):
                                            ssa_map[f"{target_var}#{k}"] = r
                                            ssa_map[f"%{target_var}#{k}"] = r
                                    else: res = None
                                elif op == "if":
                                    cond = resolve(args[0])
                                    then_ops = get_attr(op_data, "then") or attributes.get("then", [])
                                    else_ops = get_attr(op_data, "else_") or get_attr(op_data, "else") or attributes.get("else", [])
                                    
                                    # If the field exists at all, we assume an else block is intended
                                    raw_data = op_data if isinstance(op_data, dict) else op_data.model_dump()
                                    has_else = "else" in raw_data or "else_" in raw_data or "else" in attributes
                                    
                                    res_types = []
                                    # Scan then_ops for yield types
                                    for o in then_ops:
                                        o_op = get_attr(o, "op")
                                        if o_op == "yield":
                                            y_args = get_attr(o, "args", [])
                                            # Default to index for control flow state
                                            res_types = [ir.IndexType.get() for _ in y_args]

                                    if_op = scf.IfOp(cond, res_types, has_else=has_else)
                                    
                                    process_ops(then_ops, InsertionPoint(if_op.then_block), ssa_map.copy())
                                    with InsertionPoint(if_op.then_block):
                                        if len(if_op.then_block.operations) == 0 or not any(t in str(if_op.then_block.operations[-1].operation.name).lower() for t in ["return", "yield", "br"]):
                                            scf.YieldOp([])

                                    if has_else:
                                        process_ops(else_ops, InsertionPoint(if_op.else_block), ssa_map.copy())
                                        with InsertionPoint(if_op.else_block):
                                            if len(if_op.else_block.operations) == 0 or not any(t in str(if_op.else_block.operations[-1].operation.name).lower() for t in ["return", "yield", "br"]):
                                                scf.YieldOp([])
                                    
                                    if if_op.results:
                                        res = if_op.results[0]
                                        for k, r in enumerate(if_op.results):
                                            ssa_map[f"{target_var}#{k}"] = r
                                            ssa_map[f"%{target_var}#{k}"] = r
                                    else: res = None
                                elif op == "yield":
                                    scf.YieldOp([resolve(a) for a in args if a])
                                    continue
                            elif dialect == "func":
                                if op == "return":
                                    if args:
                                        v_ret = resolve(args[0])
                                        if v_ret: llvm.StoreOp(v_ret, mlir_func.entry_block.arguments[0])
                                    
                                    # ONLY emit func.return if we are in the main block
                                    if ip.block == mlir_func.entry_block:
                                        func.ReturnOp([])
                                    else:
                                        # Inside scf.if/for, we must use scf.yield
                                        # But we can't easily break out of the parent loop/if.
                                        # For now, just yield to satisfy the terminator requirement
                                        scf.YieldOp([])
                                    continue
                            if target_var: ssa_map[target_var] = res

                main_map = {}
                offset = 1 if ret_type_str != "void" else 0
                for i, (k,v) in enumerate(verified_mlir_data.signature.items()):
                    if k == "return": continue
                    main_map[k] = main_map[f"%{k}"] = mlir_func.entry_block.arguments[i + offset]
                process_ops(verified_mlir_data.operations, InsertionPoint(mlir_func.entry_block), main_map)
                with InsertionPoint(mlir_func.entry_block):
                    if len(mlir_func.entry_block.operations) == 0 or not any(t in str(mlir_func.entry_block.operations[-1].operation.name).lower() for t in ["return", "yield", "br"]):
                        func.ReturnOp([])

                with open(mlir_path, "w") as f: f.write(str(module))
                pipeline = "builtin.module(convert-scf-to-cf,convert-math-to-llvm,convert-arith-to-llvm,convert-index-to-llvm,convert-func-to-llvm,convert-cf-to-llvm,reconcile-unrealized-casts,canonicalize)"

                subprocess.run([MLIR_OPT, mlir_path, f"-pass-pipeline={pipeline}", "-o", opt_mlir_path], check=True)
                subprocess.run([MLIR_TRANSLATE, "--mlir-to-llvmir", opt_mlir_path, "-o", ll_path], check=True)
                
                with open(ll_path, 'r') as f:
                    ll_content = f.read()
                ll_content = ll_content.replace("nocreateundeforpoison ", "")
                with open(ll_path, 'w') as f:
                    f.write(ll_content)

                subprocess.run([CLANG, "-shared", "-O3", ll_path, "-o", dylib_path, "-lm"], check=True)
                print(f"   [OK] Compiled: {dylib_path}")
                
                # Save the JSON metadata to cache so Orchestrator can load it
                with open(cache_json_path, 'w') as f:
                    f.write(verified_mlir_data.model_dump_json())
            except Exception as e: print(f"   [ERROR] build failed: {e}")

async def aot_compile_all(module_filter: str = ""):
    if os.path.exists(CACHE_DIR): shutil.rmtree(CACHE_DIR)
    os.makedirs(CACHE_DIR)
    driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
    print(f"\n--- 🚀 Milestone 5: Stable Bare-Metal Pipeline ---")
    with driver.session() as session:
        query = """
        MATCH (f:Function) WHERE f.fqn CONTAINS $mod
        OPTIONAL MATCH (f)-[:HAS_CHUNK]->(c:Chunk)
        RETURN f.fqn as f_fqn, f.code as f_code, c.fqn as c_fqn, c.code as c_code, c.inputs as c_inputs, c.baseline_mlir as baseline_mlir
        """
        results = session.run(query, mod=module_filter)
        seen_targets = set()
        for record in results:
            target_fqn = record["c_fqn"] or f"{record['f_fqn']}.chunk_0"
            if target_fqn in seen_targets: continue
            seen_targets.add(target_fqn)
            
            chunk_code = record["c_code"] or record["f_code"]
            input_names = json.loads(record["c_inputs"]) if record["c_inputs"] else []
            
            sanitized = sanitize_fqn(target_fqn)
            print(f"\n[AOT] {target_fqn} -> {sanitized}...")
            base_json_path = os.path.join(MANUAL_CACHE_DIR, f"{sanitized}.json")
            
            if os.path.exists(base_json_path):
                print(f"   [STRICT] Using verified manual template: {base_json_path}")
                with open(base_json_path, 'r') as f: verified_mlir = VerifiedMLIR.model_validate(json.load(f))
            else:
                # --- NEW PIPELINE ---
                baseline_mlir_raw = record["baseline_mlir"]
                if not baseline_mlir_raw or baseline_mlir_raw == "{}":
                    print(f"   [!] Skipping {target_fqn}: No deterministic baseline found.")
                    continue
                    
                baseline_mlir = VerifiedMLIR.model_validate_json(baseline_mlir_raw)
                
                # --- NEW: Agentic Contract Synthesis ---
                if not baseline_mlir.config:
                    print(f"   [Oracle] Synthesizing Execution Contract...")
                    contract = await synthesize_execution_contract(chunk_code)
                    baseline_mlir.config = contract.model_dump()
                    print(f"      [OK] Contract synthesized.")
                # ----------------------------------------

                # 1. Get Heuristics from Gemini
                heuristics = await generate_optimization_heuristics(baseline_mlir)
                
                # 2. Deterministically Apply Heuristics
                optimized_mlir = apply_compiler_heuristics(baseline_mlir, heuristics)
                
                # 3. Z3 Safety Guard (Verify the *optimized* graph)
                arg_count = len(input_names)
                is_safe, msg_s = verify_llm_safety(optimized_mlir, arg_count, None)
                
                if not is_safe:
                    print(f"   [!] Optimization unsafe ({msg_s}). Falling back to baseline.")
                    verified_mlir = baseline_mlir
                else:
                    print(f"   [OK] Optimization verified safe.")
                    verified_mlir = optimized_mlir
                # --------------------
            
            verified_mlir.function_name = sanitized
            if record["c_fqn"]:
                with driver.session() as session:
                    session.run("MATCH (c:Chunk {fqn: $fqn}) SET c.arg_mapping = $mapping, c.signature = $sig, c.sanitized_name = $sn", 
                                fqn=target_fqn, mapping=json.dumps(verified_mlir.arg_mapping), sig=json.dumps(verified_mlir.signature), sn=sanitized)
            
            build_and_cache_mlir(verified_mlir, os.path.join(CACHE_DIR, f"{sanitized}.json"))
    driver.close()

if __name__ == "__main__":
    target_mod = sys.argv[1] if len(sys.argv) > 1 else "legacy_shop"
    asyncio.run(aot_compile_all(target_mod))
