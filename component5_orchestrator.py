import ctypes
import asyncio
import sys
import os
import inspect
import json
import threading
from neo4j import GraphDatabase
from component2_smt import verified_generation_loop, VerifiedMLIR
from component4_jit import PolyKernelMLIRJIT

# Milestone 5: Standardizing Local Workspace Environment
NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
CACHE_DIR = os.getenv("REPOOS_CACHE_DIR", "./.poly_cache")
MANUAL_CACHE_DIR = os.getenv("REPOOS_MANUAL_CACHE_DIR", "./.poly_cache_manual")

os.makedirs(CACHE_DIR, exist_ok=True)

def sanitize_fqn(fqn: str):
    """Generic naming logic that preserves unique context without hardcoding packages."""
    parts = fqn.split('.')
    if len(parts) > 3:
        # Keep last 3 parts for readability, e.g. algorithms_pagerank_alg__pagerank_python
        base = "_".join(parts[-3:])
    else:
        base = "_".join(parts)
    return base.replace('-', '_')

class LazyCallManager:
    def __init__(self):
        self.kernel = PolyKernelMLIRJIT()
        self.registry = {} 
        self.metadata = {} # Stores VerifiedMLIR JSON for each FQN
        self.driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
        self._compiling_flags = set()
        self._failed_compilation = set()
        self._loop = asyncio.new_event_loop()
        self._loop_thread = threading.Thread(target=self._run_event_loop, daemon=True)
        self._loop_thread.start()

    def _run_event_loop(self):
        asyncio.set_event_loop(self._loop)
        self._loop.run_forever()

    def register_lazy_function(self, func_name: str, original_func, fqn: str):
        import numpy as np
        chunk_0_sanitized = sanitize_fqn(f"{fqn}.chunk_0")
        cache_file_mlir = os.path.join(CACHE_DIR, f"{chunk_0_sanitized}.mlir")
        cache_file_json = os.path.join(CACHE_DIR, f"{chunk_0_sanitized}.json")
        
        if os.path.exists(cache_file_mlir) and fqn not in self.registry:
            try:
                rtype = "f64"
                # Check standard cache first, then manual cache for the JSON metadata
                meta_path = cache_file_json
                if not os.path.exists(meta_path):
                    meta_path = os.path.join(MANUAL_CACHE_DIR, f"{chunk_0_sanitized}.json")
                
                if os.path.exists(meta_path):
                    with open(meta_path, 'r') as f:
                        meta_data = json.load(f)
                        self.metadata[fqn] = meta_data
                        rtype = meta_data.get("signature", {}).get("return", "f64")
                
                self.registry[fqn] = self.kernel.load_and_compile(cache_file_mlir, chunk_0_sanitized, return_type=rtype)
                print(f"✅ Hot-swapped {fqn} (Kernel: {chunk_0_sanitized}, Return: {rtype}).")
            except Exception as e: print(f"⚠️ Failed to sync-load {fqn}: {e}")

        def trampoline_trap(*args, **kwargs):
            if fqn in self.registry:
                # 1. Resolve Execution Context (Generic)
                try:
                    meta = self.metadata.get(fqn, {})
                    sig = meta.get("signature", {})
                    contract = meta.get("config", {})
                    
                    import inspect
                    py_sig = inspect.signature(original_func)
                    bound = py_sig.bind(*args, **kwargs)
                    bound.apply_defaults()
                    
                    # 2. Specialized Object Devirtualization (Registry-Driven)
                    from adapters import get_adapter_registry
                    adapter_registry = get_adapter_registry()
                    
                    kernel_args = []
                    allocations = {}
                    primary_length = 0
                    node_map = {}; rev_node_map = {}

                    # Devirtualize arguments dynamically
                    for arg in args:
                        for adapter in adapter_registry:
                            if adapter.can_handle(arg):
                                flat_buffers, length = adapter.devirtualize(arg, contract)
                                allocations.update(flat_buffers)
                                primary_length = max(primary_length, length)
                                if "__node_map__" in flat_buffers: node_map = flat_buffers["__node_map__"]
                                if "__rev_node_map__" in flat_buffers: rev_node_map = flat_buffers["__rev_node_map__"]
                                break
                    
                    # Map signatures to kernel args using the synthesized contract
                    for arg_name, arg_type in sig.items():
                        if arg_name == "return": continue
                        
                        # A. Structural Mapping via Config Hints
                        struct_map = contract.get("structural_mapping", {})
                        if arg_name in struct_map:
                            val_key = struct_map[arg_name]
                            if val_key in allocations:
                                val = allocations[val_key]
                                if isinstance(val, int): kernel_args.append(val)
                                else: kernel_args.append(ctypes.cast(val, ctypes.c_void_p).value)
                                continue

                        # B. Dynamic Buffer Mapping
                        if arg_name.endswith("_ptr") or arg_name.endswith("_buf"):
                            # Check pointer aliases first
                            alias_key = contract.get("pointer_aliases", {}).get(arg_name)
                            py_val = bound.arguments.get(alias_key) if alias_key else None
                            
                            if py_val is None:
                                py_key = arg_name.replace("_ptr", "").replace("_buf", "")
                                py_val = bound.arguments.get(py_key)
                            
                            # Fallback logic from contract
                            if py_val is None:
                                fallback_key = contract.get("fallbacks", {}).get(arg_name)
                                if fallback_key: py_val = bound.arguments.get(fallback_key)
                            
                            if py_val is not None and isinstance(py_val, dict):
                                buf = (ctypes.c_double * primary_length)()
                                needs_normalization = contract.get("normalize_buffers", {}).get(arg_name, False)
                                total = sum(py_val.values()) if py_val else 1.0
                                if total == 0: total = 1.0
                                for node, val in py_val.items():
                                    if node in node_map: 
                                        buf[node_map[node]] = val / total if needs_normalization else val
                                kernel_args.append(ctypes.cast(buf, ctypes.POINTER(ctypes.c_double)))
                                allocations[arg_name] = buf
                            else:
                                # Default Generic Buffer (Zero-initialized)
                                ctype = ctypes.c_double if arg_type == "ptr" else ctypes.c_int64
                                buf = (ctype * primary_length)()
                                
                                # Config-driven initialization
                                init_type = contract.get("init", {}).get(arg_name) or contract.get("init_hints", {}).get(arg_name)
                                if init_type == "1/N":
                                    dv = 1.0 / primary_length if primary_length > 0 else 0.0
                                    for i in range(primary_length): buf[i] = dv
                                    
                                kernel_args.append(ctypes.cast(buf, ctypes.POINTER(ctype)))
                                allocations[arg_name] = buf
                        
                        # C. Direct Value Mapping
                        elif arg_name in bound.arguments:
                            val = bound.arguments[arg_name]
                            if arg_type == "f64": kernel_args.append(float(val))
                            elif arg_type == "i64": kernel_args.append(int(val))
                            else: kernel_args.append(val)
                        else: kernel_args.append(0)

                    print(f"   [RepoOS] Invoking Bare-Metal Kernel for {fqn}...")
                    self.registry[fqn](*kernel_args)
                    
                    # 3. Generic Result Reconstruction & Post-Processing
                    # Look for result buffer in: 1. Manual contract, 2. Synthesized pointer aliases, 3. Allocation heuristics
                    res_key = contract.get("result_buffer")
                    if not res_key:
                        # Search pointer aliases for something that looks like 'result' or 'pagerank'
                        aliases = contract.get("pointer_aliases", {})
                        for k, v in aliases.items():
                            if any(s in v.lower() for s in ["res", "out", "pagerank", "centrality"]):
                                res_key = k
                                break
                    
                    if not res_key:
                        # Heuristic fallback
                        res_key = next((k for k in allocations if any(s in k.lower() for s in ["res", "betweenness", "centrality", "output", "buffer"])), None)
                    
                    if res_key:
                        res_buf = allocations[res_key]
                        final_res = {rev_node_map[i]: res_buf[i] for i in range(primary_length)}
                        
                        # Meta-Driven Post-Processing (NO HARDCODING)
                        post_ops = contract.get("post_process", [])
                        for op in post_ops:
                            if op["type"] == "scale":
                                factor = 1.0
                                if op["factor"] == "0.5_if_undirected" and (not hasattr(args[0], 'is_directed') or not args[0].is_directed()): factor = 0.5
                                elif op["factor"] == "normalization":
                                    is_norm = bound.arguments.get("normalized", True)
                                    if is_norm and primary_length > 2:
                                        factor = 1.0 / ((primary_length - 1) * (primary_length - 2))
                                for v in final_res: final_res[v] *= factor
                        return final_res
                    return None

                except Exception as e:
                    print(f"⚠️ RepoOS Execution Failed: {e}")
                    raise e
            return original_func(*args, **kwargs)
        return trampoline_trap

    async def background_compile(self, fqn, original_func):
        try:
            if fqn in self.registry: return
            sanitized = sanitize_fqn(f"{fqn}.chunk_0")
            cache_file_mlir = os.path.join(CACHE_DIR, f"{sanitized}.mlir")
            cache_file_json = os.path.join(CACHE_DIR, f"{sanitized}.json")
            
            if os.path.exists(cache_file_mlir):
                rtype = "f64"
                meta_path = cache_file_json
                if not os.path.exists(meta_path):
                    meta_path = os.path.join(MANUAL_CACHE_DIR, f"{sanitized}.json")
                if os.path.exists(meta_path):
                    with open(meta_path, 'r') as f:
                        meta_data = json.load(f)
                        self.metadata[fqn] = meta_data
                        rtype = meta_data.get("signature", {}).get("return", "f64")
                self.registry[fqn] = self.kernel.load_and_compile(cache_file_mlir, sanitized, return_type=rtype)
                return

            with self.driver.session() as session:
                res = session.run("""
                    MATCH (f:Function {fqn: $fqn})-[:HAS_CHUNK]->(c:Chunk {index: 0}) 
                    RETURN c.code as c_code, c.inputs as c_inputs, c.baseline_mlir as baseline_mlir
                """, fqn=fqn)
                record = res.single()
                if not record: return
                chunk_code = record["c_code"]
                inputs = json.loads(record["c_inputs"])
                baseline_mlir_raw = record["baseline_mlir"]
            
            if not os.path.exists(cache_file_mlir):
                from component9_aot import build_and_cache_mlir
                from component2_smt import generate_optimization_heuristics, verify_llm_safety
                from compiler_passes import apply_compiler_heuristics

                # --- NEW PIPELINE ---
                baseline_mlir = VerifiedMLIR.model_validate_json(baseline_mlir_raw)
                heuristics = await generate_optimization_heuristics(baseline_mlir)
                optimized_mlir = apply_compiler_heuristics(baseline_mlir, heuristics)
                
                is_safe, _ = verify_llm_safety(optimized_mlir, len(inputs), None)
                final_mlir = optimized_mlir if is_safe else baseline_mlir
                # --------------------
                
                final_mlir.function_name = sanitized
                build_and_cache_mlir(final_mlir, cache_file_json)
            
            rtype = "f64"
            if os.path.exists(cache_file_json):
                with open(cache_file_json, 'r') as f:
                    meta_data = json.load(f)
                    self.metadata[fqn] = meta_data
                    rtype = meta_data.get("signature", {}).get("return", "f64")
            self.registry[fqn] = self.kernel.load_and_compile(cache_file_mlir, sanitized, return_type=rtype)
        except Exception as e:
            self._failed_compilation.add(fqn)
        finally:
            if fqn in self._compiling_flags: self._compiling_flags.remove(fqn)

if __name__ == "__main__":
    orchestrator = LazyCallManager()
    async def main_loop():
        with orchestrator.driver.session() as session:
            result = session.run("MATCH (f:Function) WHERE f.arg_count IS NOT NULL RETURN f.fqn, f.name, f.code")
            for record in result:
                fqn, name = record["f.fqn"], record["f.name"]
                exec(record["f.code"], globals())
                original_func = globals().get(name)
                trampoline = orchestrator.register_lazy_function(name, original_func, fqn)
                orchestrator.registry[name] = trampoline 
        print(f"✅ Boot Complete.")
