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
        
        _local_cache = {}

        if os.path.exists(cache_file_mlir) and fqn not in self.registry:
            try:
                rtype = "f64"
                if os.path.exists(cache_file_json):
                    with open(cache_file_json, 'r') as f:
                        rtype = json.load(f).get("signature", {}).get("return", "f64")
                
                self.registry[fqn] = self.kernel.load_and_compile(cache_file_mlir, chunk_0_sanitized, return_type=rtype)
                print(f"✅ Hot-swapped {fqn} (Kernel: {chunk_0_sanitized}, Return: {rtype}).")
            except Exception as e: print(f"⚠️ Failed to sync-load {fqn}: {e}")

        def trampoline_trap(*args, **kwargs):
            if fqn in self.registry:
                input_obj = args[0]
                
                # --- 1. NETWORKX CSR DEVIRTUALIZATION PATH ---
                is_networkx = hasattr(input_obj, '__class__') and \
                             input_obj.__class__.__name__ in ['Graph', 'DiGraph', 'MultiGraph', 'MultiDiGraph'] and \
                             input_obj.__class__.__module__.startswith('networkx')
                
                if is_networkx:
                    try:
                        # 1. Flatten the Dictionary Graph (Request Stochastic Normalization for PageRank)
                        row_ptrs, col_idx, weights, node_map, rev_node_map, num_nodes, num_edges = networkx_to_csr(input_obj, stochastic=True)
                        
                        # 2. Extract PageRank Parameters (Transparency Path)
                        # Signature: (G, alpha, personalization, max_iter, tol, nstart, weight, dangling)
                        alpha = kwargs.get('alpha', args[1] if len(args) > 1 else 0.85)
                        personalization = kwargs.get('personalization', args[2] if len(args) > 2 else None)
                        max_iter = kwargs.get('max_iter', args[3] if len(args) > 3 else 100)
                        nstart = kwargs.get('nstart', args[5] if len(args) > 5 else None)
                        
                        import numpy as np
                        x_last = np.ones(num_nodes, dtype=np.float64) / num_nodes
                        p_vector = np.ones(num_nodes, dtype=np.float64) / num_nodes
                        
                        # Use nstart if provided
                        if nstart:
                            for node, val in nstart.items():
                                if node in node_map: x_last[node_map[node]] = val
                        
                        if personalization:
                            p_sum = sum(personalization.values())
                            for node, val in personalization.items():
                                if node in node_map: p_vector[node_map[node]] = val / p_sum
                        
                        # 3. Allocate Output Buffer
                        result_arr = (ctypes.c_double * num_nodes)()
                        
                        # 4. Extract Raw Integer Pointers for the MLIR ABI
                        row_ptr_addr = ctypes.cast(row_ptrs, ctypes.c_void_p).value
                        col_idx_addr = ctypes.cast(col_idx, ctypes.c_void_p).value
                        weight_addr  = ctypes.cast(weights, ctypes.c_void_p).value
                        res_addr     = ctypes.cast(result_arr, ctypes.c_void_p).value
                        x_last_addr  = x_last.ctypes.data
                        p_addr       = p_vector.ctypes.data
                        
                        # 5. Bare-Metal Execution!
                        # ABI: (res, rows, cols, wts, xlast, p, num_nodes, alpha, max_iter)
                        self.registry[fqn](res_addr, row_ptr_addr, col_idx_addr, weight_addr, x_last_addr, p_addr, num_nodes, float(alpha), int(max_iter))
                        
                        return {rev_node_map[i]: result_arr[i] for i in range(num_nodes)}
                    except Exception as e:
                        print(f"⚠️ CSR Devirtualization Failed: {e}")
                        return original_func(*args, **kwargs)

                # --- 2. CONTAINER DETECTION (NumPy / List) ---
                is_numpy = hasattr(input_obj, '__array_interface__')
                is_list = isinstance(input_obj, list)
                
                if is_numpy:
                    size = input_obj.size
                    dist_ptr = input_obj.ctypes.data
                    
                    if len(args) > 1 and hasattr(args[1], '__array_interface__'):
                        cdf_ptr = args[1].ctypes.data
                        cdf_np_view = args[1]
                        should_return = False
                    else:
                        cache_key = f"res_np_{size}"
                        if cache_key in _local_cache:
                            cdf_np_view, cdf_ptr = _local_cache[cache_key]
                        else:
                            # Allocate persistent result buffer
                            cdf_obj = (ctypes.c_double * (size + 1))()
                            cdf_ptr = ctypes.cast(cdf_obj, ctypes.c_void_p).value
                            cdf_np_view = np.ctypeslib.as_array(cdf_obj)
                            _local_cache[cache_key] = (cdf_np_view, cdf_ptr)
                        should_return = True
                    
                    try:
                        self.registry[fqn](dist_ptr, cdf_ptr, size)
                        return cdf_np_view if should_return else None
                    except Exception as e:
                        return original_func(*args, **kwargs)

                elif is_list:
                    size = len(input_obj)
                    if size in _local_cache:
                        dist_arr, dist_ptr, cdf_arr, cdf_ptr = _local_cache[size]
                    else:
                        dist_arr = (ctypes.c_double * size)()
                        dist_ptr = ctypes.cast(dist_arr, ctypes.c_void_p).value
                        cdf_arr = (ctypes.c_double * (size + 1))()
                        cdf_ptr = ctypes.cast(cdf_arr, ctypes.c_void_p).value
                        _local_cache[size] = (dist_arr, dist_ptr, cdf_arr, cdf_ptr)
                    
                    dist_arr[:] = input_obj
                    
                    if len(args) > 1 and isinstance(args[1], list):
                        cdf_list = args[1]
                        should_return = False
                        cdf_target = cdf_list
                    else:
                        cdf_list = [0.0] * (size + 1)
                        should_return = True
                        cdf_target = cdf_list
                    
                    try:
                        self.registry[fqn](dist_ptr, cdf_ptr, size)
                        cdf_target[:] = list(cdf_arr)
                        return cdf_target if should_return else None
                    except Exception:
                        return original_func(*args, **kwargs)

                # --- 3. SCALAR FALLBACK ---
                try:
                    return self.registry[fqn](*args)
                except Exception:
                    return original_func(*args, **kwargs)
            
            # Background compilation trigger
            if fqn not in self._compiling_flags and fqn not in self._failed_compilation:
                self._compiling_flags.add(fqn)
                asyncio.run_coroutine_threadsafe(self.background_compile(fqn, original_func), self._loop)
            return original_func(*args, **kwargs)
            
        return trampoline_trap

    async def background_compile(self, fqn, original_func):
        try:
            with self.driver.session() as session:
                res = session.run("MATCH (f:Function {fqn: $fqn})-[:HAS_CHUNK]->(c:Chunk {index: 0}) RETURN c.code, c.inputs LIMIT 1", fqn=fqn)
                record = res.single()
                if not record: return
                chunk_code, inputs = record[0], json.loads(record[1])
            
            sanitized = sanitize_fqn(f"{fqn}.chunk_0")
            cache_file_mlir = os.path.join(CACHE_DIR, f"{sanitized}.mlir")
            cache_file_json = os.path.join(CACHE_DIR, f"{sanitized}.json")
            
            if not os.path.exists(cache_file_mlir):
                from component9_aot import build_and_cache_mlir
                verified_mlir = await verified_generation_loop(f"Optimize: \n{chunk_code}", chunk_code, inputs)
                verified_mlir.function_name = sanitized
                build_and_cache_mlir(verified_mlir, cache_file_json)
            
            rtype = "f64"
            if os.path.exists(cache_file_json):
                with open(cache_file_json, 'r') as f:
                    rtype = json.load(f).get("signature", {}).get("return", "f64")
            
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

