import ctypes
import asyncio
import sys
import os
import inspect
import json
import threading
from neo4j import GraphDatabase
from component2_smt import verified_generation_loop
from component4_jit import PolyKernelMLIRJIT

# Milestone 5: Standardizing Local Workspace Environment
NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
CACHE_DIR = os.getenv("REPOOS_CACHE_DIR", "./.poly_cache")
MANUAL_CACHE_DIR = os.getenv("REPOOS_MANUAL_CACHE_DIR", "./.poly_cache_manual")

os.makedirs(CACHE_DIR, exist_ok=True)

def sanitize_fqn(fqn: str):
    """Unified naming logic across all components."""
    for pkg in ["networkx", "legacy_shop", "django", "numpy", "scipy"]:
        if pkg in fqn:
            idx = fqn.find(pkg)
            return fqn[idx:].replace('.', '_').replace('-', '_')
    return fqn.replace('.', '_').replace('-', '_')

def networkx_to_csr(G, stochastic=False):
    """
    Devirtualizes a NetworkX Dictionary Graph into flat CSR Memory Arrays.
    Returns: row_ptrs, col_indices, weights, node_to_idx, idx_to_node, num_nodes, num_edges
    """
    import ctypes
    n_nodes = G.number_of_nodes()
    n_edges = G.number_of_edges()
    if G.is_directed():
        total_edges = n_edges
    else:
        total_edges = n_edges * 2

    node_to_idx = {node: i for i, node in enumerate(G.nodes())}
    idx_to_node = {i: node for node, i in node_to_idx.items()}

    row_ptrs = (ctypes.c_int64 * (n_nodes + 1))()
    col_indices = (ctypes.c_int64 * total_edges)()
    weights = (ctypes.c_double * total_edges)()

    edge_idx = 0
    for i, node in enumerate(G.nodes()):
        row_ptrs[i] = edge_idx
        
        # Calculate total out-weight for normalization if stochastic is requested
        out_weight = 1.0
        if stochastic:
            out_weight = sum(float(edge_data.get('weight', 1.0)) for neighbor, edge_data in G[node].items())
            if out_weight == 0: out_weight = 1.0 # Avoid division by zero
            
        for neighbor, edge_data in G[node].items():
            col_indices[edge_idx] = node_to_idx[neighbor]
            raw_weight = float(edge_data.get('weight', 1.0))
            weights[edge_idx] = raw_weight / out_weight
            edge_idx += 1
            
    row_ptrs[n_nodes] = edge_idx
    return row_ptrs, col_indices, weights, node_to_idx, idx_to_node, n_nodes, edge_idx

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
                    
                    import inspect
                    py_sig = inspect.signature(original_func)
                    bound = py_sig.bind(*args, **kwargs)
                    bound.apply_defaults()
                    
                    # 2. Specialized Object Devirtualization (Library-Agnostic)
                    primary_arg = args[0] if args else None
                    is_nx_graph = hasattr(primary_arg, 'nodes') and hasattr(primary_arg, 'edges')
                    
                    kernel_args = []
                    allocations = {}
                    
                    if is_nx_graph:
                        # Identify Stochastic Requirement from Metadata Hint
                        needs_stochastic = meta.get("config", {}).get("stochastic", False)
                        row_ptrs, col_idx, weights, node_map, rev_node_map, num_nodes, num_edges = networkx_to_csr(primary_arg, stochastic=needs_stochastic)
                        
                        for arg_name, arg_type in sig.items():
                            if arg_name == "return": continue
                            
                            # A. Structural Mapping
                            if arg_name == "row_ptrs": kernel_args.append(ctypes.cast(row_ptrs, ctypes.c_void_p).value)
                            elif arg_name == "col_idx": kernel_args.append(ctypes.cast(col_idx, ctypes.c_void_p).value)
                            elif arg_name == "weights": kernel_args.append(ctypes.cast(weights, ctypes.c_void_p).value)
                            elif arg_name == "num_nodes": kernel_args.append(num_nodes)
                            elif arg_name == "num_edges": kernel_args.append(num_edges)
                            
                            # B. Dynamic Buffer Mapping
                            elif arg_name.endswith("_ptr") or arg_name.endswith("_buf"):
                                py_key = arg_name.replace("_ptr", "").replace("_buf", "")
                                py_val = bound.arguments.get(py_key)
                                
                                if py_val is not None and isinstance(py_val, dict):
                                    buf = (ctypes.c_double * num_nodes)()
                                    total = sum(py_val.values()) if py_val else 1.0
                                    if total == 0: total = 1.0
                                    for node, val in py_val.items():
                                        if node in node_map: buf[node_map[node]] = val / total
                                    kernel_args.append(ctypes.cast(buf, ctypes.c_void_p).value)
                                    allocations[arg_name] = buf
                                else:
                                    # Default Generic Buffer (Zero-initialized)
                                    ctype = ctypes.c_double if arg_type == "ptr" else ctypes.c_int64
                                    buf = (ctype * num_nodes)()
                                    init_val = meta.get("config", {}).get("init", {}).get(arg_name)
                                    if init_val == "1/N":
                                        dv = 1.0 / num_nodes if num_nodes > 0 else 0.0
                                        for i in range(num_nodes): buf[i] = dv
                                    kernel_args.append(ctypes.cast(buf, ctypes.c_void_p).value)
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
                        res_key = meta.get("config", {}).get("result_buffer") or \
                                  next((k for k in allocations if any(s in k for s in ["res", "betweenness", "centrality"])), None)
                        
                        if res_key:
                            res_buf = allocations[res_key]
                            final_res = {rev_node_map[i]: res_buf[i] for i in range(num_nodes)}
                            
                            # Meta-Driven Post-Processing (NO HARDCODING)
                            post_ops = meta.get("config", {}).get("post_process", [])
                            for op in post_ops:
                                if op["type"] == "scale":
                                    factor = 1.0
                                    if op["factor"] == "0.5_if_undirected" and not primary_arg.is_directed(): factor = 0.5
                                    elif op["factor"] == "normalization":
                                        is_norm = bound.arguments.get("normalized", True)
                                        if is_norm and num_nodes > 2:
                                            factor = 1.0 / ((num_nodes - 1) * (num_nodes - 2))
                                            if not primary_arg.is_directed() and meta.get("config", {}).get("undirected_double_counted", False):
                                                factor *= 2.0
                                    for v in final_res: final_res[v] *= factor
                            return final_res
                        return None

                    # --- 2. CONTAINER DETECTION (NumPy / List) ---
                    is_numpy = hasattr(primary_arg, '__array_interface__')
                    if is_numpy:
                        # (Keep original container logic, simplified for brevity)
                        return original_func(*args, **kwargs)
                        
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
                res = session.run("MATCH (f:Function {fqn: $fqn})-[:HAS_CHUNK]->(c:Chunk {index: 0}) RETURN c.code, c.inputs LIMIT 1", fqn=fqn)
                record = res.single()
                if not record: return
                chunk_code, inputs = record[0], json.loads(record[1])
            
            if not os.path.exists(cache_file_mlir):
                from component9_aot import build_and_cache_mlir
                verified_mlir = await verified_generation_loop(f"Optimize: \n{chunk_code}", chunk_code, inputs)
                verified_mlir.function_name = sanitized
                build_and_cache_mlir(verified_mlir, cache_file_json)
            
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
