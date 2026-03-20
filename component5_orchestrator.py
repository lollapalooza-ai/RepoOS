import ctypes
import asyncio
import sys
from neo4j import GraphDatabase
from component2_smt import verified_generation_loop
from component4_jit import PolyKernelJIT

NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")

class LazyCallManager:
    def __init__(self):
        self.kernel = PolyKernelJIT()
        self.registry = {} # Global Offset Table
        self.driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
        self._trampoline_refs = [] # Prevent garbage collection of ctypes hooks

    def register_lazy_function(self, func_name: str, arg_types, return_type):
        CFuncType = ctypes.CFUNCTYPE(return_type, *arg_types)
        
        def trampoline_trap(*args):
            print(f"\n⚡ [TRAP] Intercepted call to uncompiled function: '{func_name}'")
            print(f"⚡ [TRAP] Suspending thread. Triggering AI Poly-Kernel...")
            
            # Use current event loop if it exists, else create one
            try:
                loop = asyncio.get_event_loop()
            except RuntimeError:
                loop = asyncio.new_event_loop()
                asyncio.set_event_loop(loop)
            
            compiled_func = loop.run_until_complete(self.compile_on_demand(func_name, arg_types, return_type))
            
            # Hot-Patch
            self.registry[func_name] = compiled_func
            print(f"⚡ [TRAP] Hot-patch complete. Resuming bare-metal execution.\n")
            return compiled_func(*args)

        c_trampoline = CFuncType(trampoline_trap)
        self._trampoline_refs.append(c_trampoline)
        self.registry[func_name] = c_trampoline

    async def compile_on_demand(self, func_name: str, arg_types, return_type):
        import os
        from component2_smt import VerifiedMLIR
        
        cache_file = f"./.poly_cache/{func_name}.json"
        
        # --- THE AOT FAST PATH ---
        if os.path.exists(cache_file):
            print(f"   ⚡ [AOT Cache Hit] Loading verified MLIR from disk for '{func_name}'...")
            with open(cache_file, 'r', encoding='utf-8') as f:
                mlir_json = f.read()
            verified_mlir = VerifiedMLIR.model_validate_json(mlir_json)
            
            # Extract arg_count from the Neo4j or assume from arg_types length
            arg_count = len(arg_types) 
            
            CFuncType = ctypes.CFUNCTYPE(return_type, *arg_types)
            return self.kernel.incremental_compile(func_name, verified_mlir, CFuncType, arg_count)
            
        # --- THE JIT SLOW PATH (Fallback) ---
        print(f"   🐢 [AOT Cache Miss] No cache found. Waking up AI compiler...")
        with self.driver.session() as session:
            result = session.run("MATCH (f:Function {name: $name}) RETURN f.code, f.arg_count", name=func_name)
            record = result.single()
            if not record:
                raise Exception(f"Function '{func_name}' not found in Neo4j Semantic Graph.")
            func_code, arg_count = record[0], record[1]

        # THE DOMAIN-AGNOSTIC PROMPT
        intent = (
            f"You are an expert compiler frontend. Convert this exact Python logic into a DOD MLIR execution graph: \n"
            f"```python\n{func_code}\n```\n"
            f"The function takes {arg_count} float inputs. You MUST name them 'arg0' through 'arg{arg_count - 1}'.\n"
            f"Only use opcodes: 'add', 'sub', 'mul', 'div', 'cmp_eq', 'select'.\n"
            f"Store the final calculated result in the target_var of the last operation."
        )
        
        verified_mlir = await verified_generation_loop(intent)
        
        CFuncType = ctypes.CFUNCTYPE(return_type, *arg_types)
        return self.kernel.incremental_compile(func_name, verified_mlir, CFuncType, arg_count)

# --- Boot & Interactive REPL ---
if __name__ == "__main__":
    orchestrator = LazyCallManager()
    
    print("--- Booting Poly-Kernel OS ---")
    print("Mapping Semantic Graph to Global Offset Table...")
    
    # DYNAMIC BOOT SEQUENCE
    with orchestrator.driver.session() as session:
        result = session.run("MATCH (f:Function) WHERE f.arg_count IS NOT NULL RETURN f.name, f.arg_count")
        count = 0
        for record in result:
            name, arg_c = record["f.name"], record["f.arg_count"]
            arg_types = [ctypes.c_double] * arg_c
            orchestrator.register_lazy_function(name, arg_types, ctypes.c_double)
            count += 1
            
    print(f"✅ Boot Complete. {count} functions registered.")
    
    # GENERIC REPL
    print("\n[Poly-Kernel] Ready. Type 'exit' to quit.")
    while True:
        try:
            cmd = input("\n[Poly-Kernel] Enter function call (e.g., 'calculate_tax 100 1.0') or 'exit': ")
        except EOFError:
            break
            
        if cmd.lower() == 'exit': break
        parts = cmd.split()
        if not parts: continue
        
        f_name = parts[0]
        try:
            args = [float(x) for x in parts[1:]]
        except ValueError:
            print("❌ Invalid arguments. Use numbers.")
            continue
        
        if f_name in orchestrator.registry:
            try:
                # Execute dynamically
                res = orchestrator.registry[f_name](*args)
                print(f"🔥 Result: {res}")
            except Exception as e:
                print(f"❌ Execution Error: {e}")
        else:
            print(f"Unknown function: {f_name}")
