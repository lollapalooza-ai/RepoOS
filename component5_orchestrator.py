import ctypes
import asyncio
import sys
import os
import inspect
import json
import llvmlite.ir as ir
from neo4j import GraphDatabase
from component2_smt import verified_generation_loop
from component4_jit import PolyKernelJIT, map_python_signature_to_llvm

NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")

class LazyCallManager:
    def __init__(self):
        self.kernel = PolyKernelJIT()
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
                
                # UPGRADED: Struct Projection (Milestone 2/3)
                final_args = []
                for i, arg in enumerate(call_args):
                    if isinstance(arg, dict):
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
        print(f"   [AI] Generating C-Kernel for {fqn} in background...")
        
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
            # Find what keys we need from Neo4j
            module_name = ".".join(fqn.split('.')[:-1])
            with self.driver.session() as session:
                res = session.run("MATCH (m:Module) WHERE m.name = $mod OR $fqn STARTS WITH m.name RETURN m.extracted_keys", mod=module_name, fqn=fqn)
                rec = res.single()
                keys = rec[0] if rec else []

            # Remove 'self' from type hints if it's a method
            is_method = "." in fqn and fqn.split('.')[-2][0].isupper()
            if is_method and 'self' in type_hints:
                type_hints.pop('self')
            
            # Map type hints to LLVM/ctypes
            ir_arg_types, ctypes_arg_types = map_python_signature_to_llvm(type_hints)
            
            # If hints are incomplete, pad with doubles
            real_arg_count = arg_count - 1 if is_method else arg_count
            while len(ir_arg_types) < real_arg_count:
                from component4_jit import TYPE_MAP
                ir_t, c_t = TYPE_MAP['double']
                ir_arg_types.append(ir_t)
                ctypes_arg_types.append(c_t)

            # If we have keys, it means we expect a dict which will be projected to a struct
            # For simplicity, if we have keys, we assume the LAST argument is the projected struct
            # (This is a heuristic for OOP generic repo support)
            arg_info = [f"arg{i}" for i in range(real_arg_count)]
            external_memory = {}
            if keys and real_arg_count > 0:
                # Override the last arg to be a pointer to the struct
                ir_arg_types[-1] = ir.PointerType(ir.ArrayType(ir.DoubleType(), len(keys)))
                
                class DynamicStruct(ctypes.Structure):
                    _fields_ = [(k, ctypes.c_double) for k in keys]
                ctypes_arg_types[-1] = ctypes.POINTER(DynamicStruct)
                ptr_name = f"arg{real_arg_count-1}"
                arg_info[-1] = f"{ptr_name} (Pointer to Struct: {keys})"
                external_memory[ptr_name] = len(keys)

            cache_file = f"./.poly_cache/{fqn.replace('.', '_')}.json"
            if os.path.exists(cache_file):
                from component2_smt import VerifiedMLIR
                with open(cache_file, 'r', encoding='utf-8') as f:
                    mlir_json = f.read()
                verified_mlir = VerifiedMLIR.model_validate_json(mlir_json)
            else:
                from component9_aot import generate_dynamic_fsm_prompt
                intent = await generate_dynamic_fsm_prompt(fqn, real_arg_count)
                # If no keys were found or it's a standard function, use scalar prompt
                if not intent:
                    arg_desc = f"takes {real_arg_count} inputs: {', '.join(arg_info)}" if real_arg_count > 0 else "takes 0 inputs"
                    intent = f"""
You are an expert compiler frontend. Convert this Python logic into a DOD MLIR JSON execution graph.
You MUST use the `thinking_process` field first to trace the variables before writing the operations.

IMPORTANT: If an argument is a Pointer to a Struct, use `gep` and `load` to access its fields.
Use NUMERICAL indices for `gep` offsets based on the field order.
Field order (0-indexed): {keys}

STRICT ISA RULES:
1. Every operation MUST be a flat object. NO nested logic like 'arg0 * 0.5'.
   WRONG: {{"op": "select", "args": ["cond", "arg0 * 0.5", "arg0"], "target_var": "res"}}
   CORRECT:
     {{"op": "mul", "args": ["arg0", "0.5"], "target_var": "temp1"}},
     {{"op": "select", "args": ["cond", "temp1", "arg0"], "target_var": "res"}}
2. The `store` operation takes [value, pointer]. You CANNOT store into a literal or a variable name that is not a pointer.
3. If you need to return a value, the LAST operation's `target_var` will be the return value.
4. For STRING COMPARISON: Use `strcmp`, which takes [pointer, pointer_or_literal] and returns 1.0 (float) if equal, else 0.0.

Now, compile this target:
```python
{func_code}
```
The function {arg_desc}.
Only use allowed opcodes. Store the final calculated result in the target_var of the last operation.
"""
                verified_mlir = await verified_generation_loop(intent, func_code, real_arg_count, external_memory=external_memory)
            
            CFuncType = ctypes.CFUNCTYPE(ctypes.c_double, *ctypes_arg_types)
            compiled_func = self.kernel.incremental_compile(fqn, verified_mlir, CFuncType, real_arg_count, ir_arg_types=ir_arg_types)
            self.registry[fqn] = compiled_func
            
            print(f"   [AI] ✅ Hot-swapped {fqn} to bare-metal.")
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
        print("--- Booting Poly-Kernel OS ---")
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
        # ... (rest of REPL)
