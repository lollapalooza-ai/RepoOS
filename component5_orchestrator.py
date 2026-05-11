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
        chunk_0_sanitized = sanitize_fqn(f"{fqn}.chunk_0")
        cache_file_mlir = os.path.join(CACHE_DIR, f"{chunk_0_sanitized}.mlir")
        
        if os.path.exists(cache_file_mlir) and fqn not in self.registry:
            try:
                self.registry[fqn] = self.kernel.load_and_compile(cache_file_mlir, chunk_0_sanitized)
                print(f"✅ Hot-swapped {fqn} (Kernel: {chunk_0_sanitized}).")
            except Exception as e: print(f"⚠️ Failed to sync-load {fqn}: {e}")

        def trampoline_trap(*args, **kwargs):
            if fqn in self.registry:
                call_args = args
                if inspect.ismethod(original_func) or (args and hasattr(args[0], '__class__') and fqn.split('.')[-2] == args[0].__class__.__name__):
                    call_args = args[1:]
                
                # MILESTONE 5.3: SIGNATURE-AWARE ADAPTATION
                dist_list = call_args[0]
                
                # NetworkX logic: If second arg missing, return NEW list. 
                # Else mutate second arg.
                if len(call_args) > 1 and isinstance(call_args[1], list):
                    cdf_list = call_args[1]
                    should_return = False
                else:
                    cdf_list = [0.0] * (len(dist_list) + 1)
                    should_return = True
                
                # Create underlying C-arrays
                dist_arr = (ctypes.c_double * len(dist_list))(*dist_list)
                cdf_arr = (ctypes.c_double * len(cdf_list))()
                
                dist_ptr = ctypes.cast(dist_arr, ctypes.c_void_p).value
                cdf_ptr = ctypes.cast(cdf_arr, ctypes.c_void_p).value
                
                res_buf = ctypes.c_double(0.0)
                
                try:
                    self.registry[fqn](ctypes.pointer(res_buf), dist_ptr, cdf_ptr, len(dist_list))
                    
                    # Sync back to Python object
                    for i in range(len(cdf_list)):
                        cdf_list[i] = cdf_arr[i]
                    
                    return cdf_list if should_return else None
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
                verified_mlir = await verified_generation_loop(f"Optimize: \n{chunk_code}", chunk_code, len(inputs))
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
