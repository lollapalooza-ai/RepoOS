import os
import sys
import asyncio
import llvmlite.ir as ir
from component2_smt import verified_generation_loop
from neo4j import GraphDatabase

NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
CACHE_DIR = "./.poly_cache2"

async def generate_dynamic_fsm_prompt(fqn: str, arg_count: int = 0):
    """
    MILESTONE 3.0: Queries Neo4j for extracted JSON keys and builds a custom FSM prompt.
    """
    driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
    module_name = ".".join(fqn.split('.')[:-1])
    if not module_name: module_name = fqn # Fallback
    
    with driver.session() as session:
        # Find the module and its extracted keys
        result = session.run("""
            MATCH (m:Module) 
            WHERE m.name = $module OR $fqn STARTS WITH m.name
            RETURN m.extracted_keys as keys
            LIMIT 1
        """, module=module_name, fqn=fqn)
        record = result.single()
        required_keys = record["keys"] if record else []

    # If it has arguments, it's likely a standard Python function, NOT a raw buffer scanner.
    if arg_count > 0:
        return "" # Signal to use standard scalar prompt
    
    intent = (
        f"You are an expert LLVM FSM Generator.\n"
        f"TARGET LOGIC: {fqn}\n"
        f"REQUIRED JSON KEYS: {required_keys}\n"
        f"TASK: Generate a Zero-Copy Finite State Machine using our expanded ISA.\n"
        f"Do not parse the whole JSON. ONLY search for the exact bytes for the required keys.\n"
        f"Project them into a contiguous memory struct (memory_allocations) and return the calculated result.\n"
        f"Use `gep`, `load`, `icmp`, and `br` for the scanner logic."
    )
    driver.close()
    return intent

async def aot_compile_all(target_module: str = "legacy_shop"):
    if not os.path.exists(CACHE_DIR): os.makedirs(CACHE_DIR)
    
    print(f"\n--- 🚀 Scanning Neo4j for module: '{target_module}' ---")
    driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
    with driver.session() as session:
        query = "MATCH (f:Function) WHERE f.arg_count IS NOT NULL"
        if target_module != "all" and target_module != ".":
            query += " AND (f.file CONTAINS $path OR f.fqn STARTS WITH $path)"
        query += " RETURN f.fqn, f.name, f.code, f.arg_count"
        
        result = session.run(query, path=target_module)
        records = [r for r in result]
    
    driver.close()
        
    for record in records:
        fqn = record["f.fqn"]
        func_name = record["f.name"]
        func_code = record["f.code"]
        arg_count = record["f.arg_count"]
        
        print(f"\n[AOT] Targeting: {fqn} (Args: {arg_count})")
        
        # HEURISTIC SKIP: Some functions are too complex for our current ISA (SQL, IO, etc.)
        skip_keywords = ["sql", "db", "connect", "cursor", "execute", "date", "time", "setUp", "tearDown", "test_", "print", "log", "mail", "jsonify", "flask"]
        if any(kw in fqn.lower() or kw in func_name.lower() for kw in skip_keywords):
            print(f"   ⏩ Skipping {fqn}: Heuristic identifies it as too complex (IO/SQL/Test).")
            continue

        cache_file = os.path.join(CACHE_DIR, f"{fqn.replace('.', '_')}.json")
        
        if os.path.exists(cache_file):
            print(f"   ⚡ Cache hit! '{fqn}' is already compiled. Skipping.")
            continue
            
        # Decision: Is this a generic function or does it need a custom FSM?
        intent = await generate_dynamic_fsm_prompt(fqn, arg_count)
        if not intent:
             arg_desc = f"takes {arg_count} float inputs: named 'arg0' through 'arg{arg_count - 1}'" if arg_count > 0 else "takes 0 inputs"
             intent = f"""
You are an expert compiler frontend. Convert this Python logic into a DOD MLIR JSON execution graph.
You MUST use the `thinking_process` field first to trace the variables before writing the operations.

STRICT FLATNESS RULE:
You CANNOT use math symbols (+, -, *, /) or nested logic in the `args` list.
The arguments MUST be simple strings: variable names (e.g., "arg0", "temp1") or numbers (e.g., "1.5", "0.08").

WRONG: {{"op": "select", "args": ["cond", "arg0 * 1.5", "arg0"], "target_var": "res"}}
CORRECT (Break it down):
  {{"op": "mul", "args": ["arg0", "1.5"], "target_var": "temp1"}},
  {{"op": "select", "args": ["cond", "temp1", "arg0"], "target_var": "res"}}

ISA OPCODES: add, sub, mul, div, cmp_eq, select, load, store, gep, icmp, br, label, alloc_struct, string_view_ptr, ffi_call, strcmp

Now, compile this target:
```python
{func_code}
```
The function {arg_desc}.
Store the final calculated result in the target_var of the last operation.
"""

        try:
            verified_mlir = await verified_generation_loop(intent, func_code, arg_count)
            with open(cache_file, 'w', encoding='utf-8') as f:
                f.write(verified_mlir.model_dump_json(indent=2))
            print(f"   💾 SUCCESS: Saved verified MLIR to {cache_file}")
        except Exception as e:
            print(f"   ❌ FAILED to compile '{fqn}': {e}")
            # TODO: Remove this quota-check kill switch once daily limits are increased
            if "RESOURCE_EXHAUSTED" in str(e) or "429" in str(e):
                print("🛑 Quota exceeded. Killing run as requested.")
                sys.exit(1)

if __name__ == "__main__":
    target = sys.argv[1] if len(sys.argv) > 1 else "legacy_shop"
    asyncio.run(aot_compile_all(target))
