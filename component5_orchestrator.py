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

NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
CACHE_DIR = os.getenv("REPOOS_CACHE_DIR", "./.poly_cache3")

def sanitize_fqn(fqn: str):
    for pkg in ["networkx", "legacy_shop", "django", "numpy", "scipy"]:
        if pkg in fqn:
            return (pkg + fqn.split(pkg)[-1]).replace('.', '_').replace('-', '_')
    return fqn.replace('.', '_').replace('-', '_')

class LazyCallManager:
    def __init__(self):
        self.kernel = PolyKernelMLIRJIT()
        self.registry = {} 
        self.buffer_cache = {} # Persistent C-Buffers for zero-allocation loops
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
        
        # Local cache for the trampoline closure to avoid dict lookups on 'self'
        _local_cache = {}

        if os.path.exists(cache_file_mlir) and fqn not in self.registry:
            try:
                self.registry[fqn] = self.kernel.load_and_compile(cache_file_mlir, chunk_0_sanitized)
                print(f"✅ Hot-swapped {fqn} (Kernel: {chunk_0_sanitized}).")
            except Exception as e: print(f"⚠️ Failed to sync-load {fqn}: {e}")

        def trampoline_trap(*args, **kwargs):
            if fqn in self.registry:
                # Use faster argument unpacking
                input_obj = args[0]
                
                # ZERO-COPY DETECTOR (NumPy Support)
                is_numpy = hasattr(input_obj, '__array_interface__')
                
                if is_numpy:
                    # Bypasses all Python-to-C copying
                    size = input_obj.size
                    dist_ptr = input_obj.ctypes.data
                    
                    # We still need a result buffer. 
                    # If the user passed a second arg, use it if it's numpy too.
                    if len(args) > 1 and hasattr(args[1], '__array_interface__'):
                        cdf_ptr = args[1].ctypes.data
                        cdf_np_view = args[1]
                        should_return = False
                    else:
                        # Fallback: allocate persistent buffer for the result
                        cache_key = f"res_np_{size}"
                        if cache_key in _local_cache:
                            cdf_np_view, cdf_ptr = _local_cache[cache_key]
                        else:
                            cdf_obj = (ctypes.c_double * (size + 1))()
                            cdf_ptr = ctypes.cast(cdf_obj, ctypes.c_void_p).value
                            # Create the NumPy view ONCE and cache it
                            cdf_np_view = np.ctypeslib.as_array(cdf_obj)
                            _local_cache[cache_key] = (cdf_np_view, cdf_ptr)
                        should_return = True
                else:
                    # STANDARD CPYTHON LIST (Requires O(N) copy)
                    dist_list = input_obj
                    size = len(dist_list)
                    if size in _local_cache:
                        dist_arr, dist_ptr, cdf_arr, cdf_ptr = _local_cache[size]
                    else:
                        dist_arr = (ctypes.c_double * size)()
                        dist_ptr = ctypes.cast(dist_arr, ctypes.c_void_p).value
                        cdf_arr = (ctypes.c_double * (size + 1))()
                        cdf_ptr = ctypes.cast(cdf_arr, ctypes.c_void_p).value
                        _local_cache[size] = (dist_arr, dist_ptr, cdf_arr, cdf_ptr)
                    
                    dist_arr[:] = dist_list
                    
                    if len(args) > 1 and isinstance(args[1], list):
                        cdf_list = args[1]
                        should_return = False
                        cdf_target = cdf_list
                    else:
                        cdf_list = [0.0] * (size + 1)
                        should_return = True
                        cdf_target = cdf_list
                
                try:
                    # BARE-METAL EXECUTION (ZERO-COPY IF NUMPY)
                    # Note: registry[fqn] is the execution_wrapper from component4_jit
                    # which internally adds the result pointer.
                    res_val = self.registry[fqn](dist_ptr, cdf_ptr, size)
                    
                    if is_numpy:
                        return cdf_np_view if should_return else None
                    else:
                        cdf_target[:] = list(cdf_arr)
                        return cdf_target if should_return else None
                except Exception as e:
                    return original_func(*args, **kwargs)
            
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
            
            if not os.path.exists(cache_file_mlir):
                from component9_aot import build_and_cache_mlir
                verified_mlir = await verified_generation_loop(f"Optimize: \n{chunk_code}", chunk_code, inputs)
                verified_mlir.function_name = sanitized
                build_and_cache_mlir(verified_mlir, os.path.join(CACHE_DIR, f"{sanitized}.json"))
            
            self.registry[fqn] = self.kernel.load_and_compile(cache_file_mlir, sanitized)
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
