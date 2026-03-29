# ENGINEERING EXECUTION BRIEF: Project "Repo OS v4.0" (Generic Codebase Support)

**To:** Senior Python Engineer
**From:** Principal Engineering / Architecture
**Objective:** Upgrade the Repo OS compiler pipeline to handle arbitrary, generic Python repositories (OOP, dynamic arguments, delayed variable usage) using Asynchronous Shadow JIT and Struct Projection.

---

## MILESTONE 1: Full Object-Oriented Semantic Ingestion
**Target:** `component1_ingest.py`
**Objective:** Stop assuming the codebase is flat. Extract Fully Qualified Names (FQNs), Class structures, and Dictionary/Attribute accesses to build the "Intent Map" for the AI compiler.

**Exact Code Changes:**
Replace the `process_file` logic to include `class_definition` and a deep AST pass for dictionary keys.

```python
# component1_ingest.py (Updates)
import ast

def extract_data_intents(source_code: str):
    """AST pass to find what JSON keys the business logic actually uses."""
    tree = ast.parse(source_code)
    intents = []
    for node in ast.walk(tree):
        # Find payload["target_key"]
        if isinstance(node, ast.Subscript) and isinstance(node.slice, ast.Constant):
            intents.append(node.slice.value)
        # Find object.attribute
        elif isinstance(node, ast.Attribute):
            intents.append(node.attr)
    return list(set(intents))

def process_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        source_code = f.read()
    
    # 1. NEW: Extract data keys to feed to the AOT Compiler
    data_keys = extract_data_intents(source_code)
    
    # 2. UPGRADED: Tree-Sitter queries for Classes AND Functions
    tree = parser.parse(bytes(source_code, "utf8"))
    class_query = PY_LANGUAGE.query("(class_definition name: (identifier) @class.name)")
    func_query = PY_LANGUAGE.query("(function_definition name: (identifier) @func.name)")
    
    # Update Neo4j to use FQNs (Module.Class.Method)
    module_name = file_path.replace('./', '').replace('/', '.').replace('.py', '')
    
    with driver.session() as session:
        # Push file, module, classes, and extracted JSON keys to the Graph
        session.run("""
            MERGE (m:Module {name: $module})
            SET m.extracted_keys = $keys
        """, module=module_name, keys=data_keys)
        # (Engineer: Add remaining tree-sitter loop to link (Module)-[:CONTAINS]->(Class)-[:HAS_METHOD]->(Function))
```

**How to Test Milestone 1:**
1. Create a dummy file: `ecommerce/cart.py` containing a `class Cart` with a method `def calculate(self, payload)`. Inside, access `payload["tax_rate"]`.
2. Run `python component1_ingest.py ./ecommerce`.
3. Open the Neo4j Browser (`localhost:7474`). Verify you see a `Module` node connected to a `Class` node, connected to a `Function` node, and the Module has an `extracted_keys` property containing `"tax_rate"`.

---

## MILESTONE 2: Asynchronous Shadow JIT & Class Metaprogramming
**Target:** `component5_orchestrator.py` & `component6_hijacker.py`
**Objective:** Never block the main thread. If the C-Kernel isn't compiled yet, fall back to standard Python. Intercept class methods and handle `*args`/`**kwargs`.

**Exact Code Changes:**
Rewrite the Hook and Trampoline to be non-blocking.

```python
# component5_orchestrator.py (Updates)
import asyncio
import inspect

class LazyCallManager:
    # ... existing init ...
    
    def register_lazy_function(self, func_name: str, original_func, fqn: str):
        """
        original_func: The actual slow Python function to fall back on.
        fqn: Fully Qualified Name (e.g., 'ecommerce.cart.Cart.calculate')
        """
        def trampoline_trap(*args, **kwargs):
            if fqn in self.registry:
                # FAST PATH: C-Kernel is ready.
                # (Engineer: Add logic here to pack args into ctypes based on type hints)
                return self.registry[fqn](*args)
            
            # SLOW PATH / COLD START:
            print(f"⚡ [SHADOW JIT] '{fqn}' not compiled. Falling back to Python.")
            
            # Fire the AI Compilation in the background (DO NOT WAIT)
            if fqn not in self._compiling_flags:
                self._compiling_flags.add(fqn)
                asyncio.create_task(self.background_compile(fqn, original_func))
            
            # Execute original Python code so the user doesn't time out
            return original_func(*args, **kwargs)
            
        return trampoline_trap

    async def background_compile(self, fqn, original_func):
        print(f"   [AI] Generating C-Kernel for {fqn} in background...")
        # ... call LLM, Z3, LLVM ...
        # self.registry[fqn] = new_c_func
        print(f"   [AI] ✅ Hot-swapped {fqn} to bare-metal.")
```

```python
# component6_hijacker.py (Updates)
    def exec_module(self, module):
        # ... ingest Neo4j ...
        
        # UPGRADED: Class-Level Hijacking
        for name, obj in inspect.getmembers(module):
            if inspect.isclass(obj):
                for method_name, method_obj in inspect.getmembers(obj, predicate=inspect.isfunction):
                    fqn = f"{module.__name__}.{name}.{method_name}"
                    trampoline = self.orchestrator.register_lazy_function(method_name, method_obj, fqn)
                    setattr(obj, method_name, trampoline) # Patch the class directly
            elif inspect.isfunction(obj):
                fqn = f"{module.__name__}.{name}"
                trampoline = self.orchestrator.register_lazy_function(name, obj, fqn)
                setattr(module, name, trampoline)
```

**How to Test Milestone 2:**
1. Run a generic FastAPI server with Repo OS attached.
2. Hit the endpoint. It should instantly return using the "SLOW PATH" and print `[SHADOW JIT]... Falling back to Python`.
3. Wait 15 seconds. The console should print `[AI] ✅ Hot-swapped`.
4. Hit the endpoint again. It should now execute the FAST PATH.

---

## MILESTONE 3: Dynamic ABI Mapping & AOT Intent Generation
**Target:** `component4_jit.py` & `component9_aot.py`
**Objective:** Delete the hardcoded LLVM IR. Teach the AI to generate dynamic FSMs based on the keys extracted in Milestone 1. Teach the JIT to map Python Type Hints to `ctypes`.

**Exact Code Changes:**

```python
# component4_jit.py (Updates)
import ctypes
import llvmlite.ir as ir

# Dynamic Type Mapper
TYPE_MAP = {
    'int': (ir.IntType(32), ctypes.c_int32),
    'float': (ir.DoubleType(), ctypes.c_double),
    'str': (ir.PointerType(ir.IntType(8)), ctypes.c_char_p), # String View Pointer
    # (Engineer: Add Struct Pointer mapping for complex objects)
}

def map_python_signature_to_llvm(type_hints: dict):
    ir_args = []
    ctypes_args = []
    for arg_name, type_str in type_hints.items():
        ir_t, c_t = TYPE_MAP.get(type_str, TYPE_MAP['float']) # Default to float MVP
        ir_args.append(ir_t)
        ctypes_args.append(c_t)
    return ir_args, ctypes_args
```

```python
# component9_aot.py (Updates)
async def generate_dynamic_fsm_prompt(fqn: str):
    """Replaces the 100 lines of hardcoded LLVM IR."""
    
    # 1. Ask Neo4j what JSON keys this function needs (from Milestone 1)
    # result = session.run("MATCH (m:Module)... RETURN m.extracted_keys")
    required_keys = ["tax_rate", "user_id"] # Mocked for example
    
    intent = (
        f"You are an expert LLVM FSM Generator.\n"
        f"TARGET LOGIC: {fqn}\n"
        f"REQUIRED JSON KEYS: {required_keys}\n"
        f"TASK: Generate a Zero-Copy Finite State Machine using our expanded ISA.\n"
        f"Do not parse the whole JSON. ONLY search for the exact bytes for the required keys.\n"
        f"Project them into a contiguous memory struct."
    )
    # Pass this intent to component2_smt.py (Verified Generation Loop)
```

**How to Test Milestone 3:**
1. Add type hints to a Python function: `def process(val: float, name: str):`.
2. Run `component4_jit.py`. Verify that the orchestrator dynamically creates a `CFUNCTYPE` expecting `c_double` and `c_char_p` instead of crashing.
3. Run `component9_aot.py`. Verify the LLM outputs a custom MLIR JSON graph targeting *only* the specific keys requested.

---

## MILESTONE 4: The Verifier Expansion (Complex State)
**Target:** `component2_smt.py`
**Objective:** Allow the AI to allocate C-Structs and use String Views safely without Z3 rejecting the graph.

**Exact Code Changes:**
Update the Strict Pydantic Schema that constrains the AI.

```python
# component2_smt.py (Updates)
from pydantic import BaseModel, Field
from typing import Literal, List, Optional

class Operation(BaseModel):
    # THE UPGRADED INSTRUCTION SET ARCHITECTURE (ISA)
    op: Literal[
        "add", "sub", "mul", "div", "cmp_eq", "select", 
        "load", "store", "gep", "icmp", "br", "label",
        # NEW INSTRUCTIONS FOR GENERIC PIPELINES:
        "alloc_struct",    # Projects off-heap struct
        "string_view_ptr", # Creates a zero-copy pointer to a substring
        "ffi_call"         # Escapes back to CPython for unsupported logic
    ] = Field(...)
    
    args: List[str] = Field(...)
    target_var: Optional[str] = Field(None)

# (Engineer: Update `verify_llm_safety` function to ensure `string_view_ptr` 
# bounds do not exceed the `buffer_len` integer passed into the function).
```

**How to Test Milestone 4:**
1. Feed a manual MLIR JSON string into the Z3 verifier that includes an `alloc_struct` and `string_view_ptr` operation. 
2. Ensure `verify_llm_safety()` returns `True`.
3. Feed it a malicious MLIR JSON where `string_view_ptr` length is set to `999999` (simulating an out-of-bounds read). 
4. Ensure the Z3 verifier catches the memory violation and returns `False`.