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
    """Unified naming logic across all components."""
    for pkg in ["networkx", "legacy_shop", "django", "numpy", "scipy"]:
        if pkg in fqn:
            return (pkg + fqn.split(pkg)[-1]).replace('.', '_').replace('-', '_')
    return fqn.replace('.', '_').replace('-', '_')

class LazyCallManager:
    def __init__(self):
        self.kernel = PolyKernelMLIRJIT()
        self.registry = {} 
        self.metadata_cache = {} 
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
        # Hot-swap if already exists (Sync with Chunk 0)
        chunk_0_sanitized = sanitize_fqn(f"{fqn}.chunk_0")
        cache_file_mlir = os.path.join(CACHE_DIR, f"{chunk_0_sanitized}.mlir")
        
        if os.path.exists(cache_file_mlir) and fqn not in self.registry:
            try:
                # Milestone 5.2: Load the chunk-level kernel
                self.registry[fqn] = self.kernel.load_and_compile(cache_file_mlir, chunk_0_sanitized)
                print(f"✅ Hot-swapped {fqn} (Kernel: {chunk_0_sanitized}).")
            except Exception as e: print(f"⚠️ Failed to sync-load {fqn}: {e}")

        def trampoline_trap(*args, **kwargs):
            if fqn in self.registry:
                call_args = args
                if inspect.ismethod(original_func) or (args and hasattr(args[0], '__class__') and fqn.split('.')[-2] == args[0].__class__.__name__):
                    call_args = args[1:]
                
                if fqn not in self.metadata_cache:
                    with self.driver.session() as session:
                        res = session.run("MATCH (f:Function {fqn: $fqn})-[:HAS_CHUNK]->(c:Chunk {index: 0}) RETURN c.signature LIMIT 1", fqn=fqn)
                        rec = res.single()
                        self.metadata_cache[fqn] = {"signature": json.loads(rec[0]) if rec and rec[0] else {}}
                
                signature = self.metadata_cache[fqn]["signature"]
                final_args = []
                array_len = 0
                for arg in call_args:
                    if isinstance(arg, (list, dict)): array_len = len(arg); break

                def get_addr(obj):
                    return ctypes.cast(obj, ctypes.c_void_p).value

                # 1. Project Arguments (Standard Direct Pointer ABI)
                for arg in call_args:
                    if isinstance(arg, (int, float)): final_args.append(ctypes.c_double(float(arg)))
                    elif isinstance(arg, list) and arg and isinstance(arg[0], (int, float)):
                        arr = (ctypes.c_double * len(arg))(*arg)
                        final_args.append(ctypes.c_int64(get_addr(arr)))
                    else: final_args.append(arg)

                # 2. Output Buffer (NetworkX Specific)
                output_buffer_raw = None
                if "cumulative_distribution" in fqn:
                    buf_len = array_len + 1
                    output_buffer_raw = (ctypes.c_double * buf_len)()
                    final_args.append(ctypes.c_int64(get_addr(output_buffer_raw)))

                # 3. Scalar Metadata
                if "arg_len" in signature or "cumulative_distribution" in fqn:
                    final_args.append(ctypes.c_int64(array_len))

                try:
                    # Milestone 5.2: Execute via the stable C-ABI
                    self.registry[fqn](*final_args)
                    if output_buffer_raw: return list(output_buffer_raw)
                    return 1.0 
                except Exception as e:
                    if fqn not in self._failed_compilation:
                        print(f"⚡ [FAST PATH ERROR] {fqn}: {e}. Falling back to Python.")
                        self._failed_compilation.add(fqn)
                    return original_func(*args, **kwargs)
            
            if fqn not in self._compiling_flags and fqn not in self._failed_compilation:
                print(f"⚡ [SHADOW JIT] '{fqn}' not compiled. Falling back to Python.")
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
            print(f"   [AI] ✅ Hot-swapped {fqn} to bare-metal (MLIR).")
        except Exception as e:
            if fqn not in self._failed_compilation:
                print(f"   [AI] ❌ Background compilation failed for {fqn}: {e}")
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
