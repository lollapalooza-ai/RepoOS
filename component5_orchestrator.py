import ctypes
import asyncio
import sys
import os
import inspect
import json
from neo4j import GraphDatabase
from component2_smt import verified_generation_loop
from component4_jit import PolyKernelMLIRJIT, map_python_signature_to_llvm

NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
CACHE_DIR = "./.poly_cache3"

class LazyCallManager:
    def __init__(self):
        self.kernel = PolyKernelMLIRJIT()
        self.registry = {} # Fast Path: FQN -> Compiled C Function
        self.driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
        self._compiling_flags = set()
        self._trampoline_refs = []

    def register_lazy_function(self, func_name: str, original_func, fqn: str):
        def trampoline_trap(*args, **kwargs):
            if fqn in self.registry:
                call_args = args
                if inspect.ismethod(original_func) or (args and hasattr(args[0], '__class__') and fqn.split('.')[-2] == args[0].__class__.__name__):
                    call_args = args[1:]
                
                # UPGRADED: Generic SoA Projection (Milestone 3 Final)
                final_args = []
                for i, arg in enumerate(call_args):
                    if isinstance(arg, list) and arg and isinstance(arg[0], dict):
                        # Data Devirtualization: Project List[Dict] to SoA
                        length = len(arg)
                        final_args.append(ctypes.c_int64(length)) # arg_len

                        module_name = ".".join(fqn.split('.')[:-1])
                        with self.driver.session() as session:
                            res = session.run("MATCH (m:Module) WHERE m.name = $mod OR $fqn STARTS WITH m.name RETURN m.access_paths", mod=module_name, fqn=fqn)
                            rec = res.single()
                            paths_json = rec[0] if rec else []
                            access_paths = [json.loads(p) for p in paths_json]
                        
                        def get_nested(d, path):
                            curr = d
                            for k in path:
                                if isinstance(curr, dict) and k in curr: curr = curr[k]
                                else: return None
                            return curr

                        # Map each extracted path to a flat C-array
                        # Note: We need a heuristic to decide if it's float or int
                        for path in sorted(access_paths):
                            # Skip paths that don't belong to the current object in the list
                            # (In a real system, we'd use semantic mapping to tie paths to arguments)
                            sample_val = get_nested(arg[0], path)
                            if sample_val is None: continue
                            
                            if isinstance(sample_val, bool) or (isinstance(sample_val, int) and "is_" in path[-1]):
                                # Boolean/Flag array
                                arr = (ctypes.c_int32 * length)(*[1 if get_nested(o, path) else 0 for o in arg])
                                final_args.append(ctypes.cast(arr, ctypes.c_void_p))
                            else:
                                # Float/Numeric array
                                arr = (ctypes.c_double * length)(*[float(get_nested(o, path) or 0.0) for o in arg])
                                final_args.append(ctypes.cast(arr, ctypes.c_void_p))

                    elif isinstance(arg, dict):
                        # Find what keys we need from Neo4j
                        module_name = ".".join(fqn.split('.')[:-1])
                        with self.driver.session() as session:
                            res = session.run("MATCH (m:Module) WHERE m.name = $mod OR $fqn STARTS WITH m.name RETURN m.extracted_keys", mod=module_name, fqn=fqn)
                            rec = res.single()
                            keys = rec[0] if rec else []
                        
                        if keys:
                            class DynamicStruct(ctypes.Structure):
                                _fields_ = [(k, ctypes.c_double) for k in keys]
                            
                            struct_obj = DynamicStruct()
                            for k in keys:
                                setattr(struct_obj, k, float(arg.get(k, 0.0)))
                            final_args.append(ctypes.pointer(struct_obj))
                        else:
                            final_args.append(arg)
                    else:
                        final_args.append(arg)

                try:
                    return self.registry[fqn](*final_args)
                except Exception as e:
                    print(f"⚡ [FAST PATH ERROR] {fqn}: {e}. Falling back to Python.")
                    import traceback
                    traceback.print_exc()
                    return original_func(*args, **kwargs)
            
            if fqn not in self._compiling_flags:
                print(f"⚡ [SHADOW JIT] '{fqn}' not compiled. Falling back to Python.")
                self._compiling_flags.add(fqn)
                try:
                    loop = asyncio.get_running_loop()
                    loop.create_task(self.background_compile(fqn, original_func))
                except RuntimeError:
                    pass
            
            return original_func(*args, **kwargs)
            
        return trampoline_trap

    async def background_compile(self, fqn, original_func):
        print(f"   [AI] Generating MLIR-Kernel for {fqn} in background...")
        
        try:
            with self.driver.session() as session:
                result = session.run("MATCH (f:Function {fqn: $fqn}) RETURN f.code, f.arg_count, f.type_hints", fqn=fqn)
                record = result.single()
                if not record:
                    name = fqn.split('.')[-1]
                    result = session.run("MATCH (f:Function {name: $name}) RETURN f.code, f.arg_count, f.type_hints", name=name)
                    record = result.single()
                
                if not record:
                    print(f"   [AI] ❌ Could not find {fqn} in Semantic Graph.")
                    self._compiling_flags.remove(fqn)
                    return

                func_code, arg_count, type_hints_json = record[0], record[1], record[2]
                type_hints = json.loads(type_hints_json) if type_hints_json else {}

            # UPGRADED: Dynamic ABI Mapping (Milestone 3)
            module_name = ".".join(fqn.split('.')[:-1])
            with self.driver.session() as session:
                res = session.run("MATCH (m:Module) WHERE m.name = $mod OR $fqn STARTS WITH m.name RETURN m.extracted_keys", mod=module_name, fqn=fqn)
                rec = res.single()
                keys = rec[0] if rec else []

            is_method = "." in fqn and fqn.split('.')[-2][0].isupper()
            real_arg_count = arg_count - 1 if is_method else arg_count

            cache_file_mlir = os.path.join(CACHE_DIR, f"{fqn.replace('.', '_')}.mlir")
            if os.path.exists(cache_file_mlir):
                compiled_func = self.kernel.load_and_compile(cache_file_mlir, fqn.split('.')[-1])
            else:
                from component9_aot import generate_dynamic_fsm_prompt, build_and_cache_mlir
                intent = await generate_dynamic_fsm_prompt(fqn, real_arg_count)
                if not intent:
                    intent = f"""
You are an expert compiler frontend. Convert this Python logic into a formal MLIR execution graph in JSON format.
You MUST use the 'thinking_process' field first to trace the variables before writing the operations.

DIALECT RULES:
1. 'arith': Use for all math (addf, subf, mulf, divf).
2. 'func': Use for 'return'.
3. 'scf': Use for structured control flow ('if', 'for', 'yield').

STRICT FLATNESS RULE:
You CANNOT use math symbols (+, -, *, /) or nested logic in the 'args' list.
Use SSA naming for 'target_var' (e.g., '%0', '%1').

Now, compile this target:
```python
{func_code}
```
The function takes {real_arg_count} inputs.
Store the final calculated result in the target_var of the last operation.
"""
                verified_mlir = await verified_generation_loop(intent, func_code, real_arg_count, external_memory={})
                verified_mlir.function_name = fqn.split('.')[-1]
                
                temp_json_cache = os.path.join(CACHE_DIR, f"{fqn.replace('.', '_')}.json")
                build_and_cache_mlir(verified_mlir, temp_json_cache)
                compiled_func = self.kernel.load_and_compile(cache_file_mlir, verified_mlir.function_name)
            
            self.registry[fqn] = compiled_func
            print(f"   [AI] ✅ Hot-swapped {fqn} to bare-metal (MLIR).")
        except Exception as e:
            print(f"   [AI] ❌ Background compilation failed for {fqn}: {e}")
            import traceback
            traceback.print_exc()
        finally:
            if fqn in self._compiling_flags:
                self._compiling_flags.remove(fqn)

if __name__ == "__main__":
    orchestrator = LazyCallManager()
    
    async def main_loop():
        print("--- Booting Poly-Kernel OS (MLIR) ---")
        with orchestrator.driver.session() as session:
            result = session.run("MATCH (f:Function) WHERE f.arg_count IS NOT NULL RETURN f.fqn, f.name, f.arg_count, f.code")
            count = 0
            for record in result:
                fqn, name, arg_c = record["f.fqn"], record["f.name"], record["f.arg_count"]
                exec(record["f.code"], globals())
                original_func = globals().get(name)
                trampoline = orchestrator.register_lazy_function(name, original_func, fqn)
                orchestrator.registry[name] = trampoline 
                count += 1
        print(f"✅ Boot Complete. {count} functions registered.")
