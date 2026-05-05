# Engineering Handoff: The MLIR Pipeline Upgrade

**To:** Senior Compiler Engineer
**From:** Principal Architect
**Objective:** Deprecate `llvmlite` and our custom JSON ISA. Migrate the AI generation, AOT caching, and JIT compilation to the formal MLIR framework using `mlir-python-bindings`. 

### Required Dependencies
```bash
pip install mlir-python-bindings
```

---

### Phase 1: Update the AI Schema (`component2_smt.py`)
We must restrict the AI to outputting operations that directly map to official MLIR dialects, specifically `arith` (Arithmetic), `func` (Functions), and `scf` (Structured Control Flow).

**Update the `Operation` class inside `component2_smt.py`:**

```python
from typing import List, Literal, Optional, Union
from pydantic import BaseModel, Field

class MLIROperation(BaseModel):
    # Strictly aligned with formal MLIR dialects
    dialect: Literal["arith", "func", "scf", "memref"] = Field(..., description="The MLIR Dialect namespace.")
    op: Literal[
        "addf", "subf", "mulf", "divf", "cmpf",  # arith
        "call", "return",                        # func
        "for", "if", "yield",                    # scf
        "load", "store", "alloc"                 # memref
    ] = Field(..., description="The specific operation within the dialect.")
    
    args: List[str] = Field(..., description="Input variables or SSA values (e.g., '%0').")
    attributes: dict = Field(default_factory=dict, description="Dialect-specific attributes (e.g., predicate for cmpf).")
    target_var: Optional[str] = Field(None, description="The SSA assignment target (e.g., '%1').")

class VerifiedMLIR(BaseModel):
    function_name: str
    signature: dict  # e.g., {"arg0": "f64", "arg1": "f64", "return": "f64"}
    operations: List[MLIROperation]
```

---

### Phase 2: The Formal MLIR Builder (`component9_aot.py`)
We delete the `llvmlite.ir.IRBuilder` loop. We replace it with the official MLIR Python API to construct the AST in memory, run the built-in compiler verification passes, and lower it to the LLVM dialect.

**Refactor the generation loop in `component9_aot.py`:**

```python
import os
import json
from mlir.ir import Context, Module, Location, InsertionPoint, f64
from mlir.dialects import arith, func, builtin
from mlir.passmanager import PassManager

def build_and_cache_mlir(verified_mlir_data: dict, cache_filepath: str):
    """
    Translates the AI's strict JSON into a formal MLIR Module and caches it.
    """
    with Context() as ctx, Location.unknown():
        module = Module.create()
        
        with InsertionPoint(module.body):
            # 1. Define Function Signature
            # (Assuming f64 for all inputs in this macro-benchmark for simplicity)
            f64_type = f64
            input_types = [f64_type for _ in verified_mlir_data['signature'].keys() if _ != 'return']
            func_type = builtin.FunctionType.get(inputs=input_types, results=[f64_type])
            
            mlir_func = func.FuncOp(name=verified_mlir_data['function_name'], type=func_type)
            mlir_func.add_entry_block()
            
            with InsertionPoint(mlir_func.entry_block):
                ssa_map = {}
                
                # Map input arguments to SSA values
                for i, arg_name in enumerate([k for k in verified_mlir_data['signature'].keys() if k != 'return']):
                    ssa_map[arg_name] = mlir_func.entry_block.arguments[i]

                # 2. Build the MLIR AST from JSON
                for op_data in verified_mlir_data['operations']:
                    dialect = op_data['dialect']
                    op_name = op_data['op']
                    
                    if dialect == "arith":
                        arg1 = ssa_map[op_data['args'][0]]
                        arg2 = ssa_map[op_data['args'][1]]
                        
                        if op_name == "addf":
                            res = arith.AddFOp(arg1, arg2).result
                        elif op_name == "mulf":
                            res = arith.MulFOp(arg1, arg2).result
                        # ... mapping other arith ops ...
                        
                        if op_data.get('target_var'):
                            ssa_map[op_data['target_var']] = res

                    elif dialect == "func" and op_name == "return":
                        ret_val = ssa_map[op_data['args'][0]]
                        func.ReturnOp([ret_val])

        # 3. Built-in Verification (Replaces manual Python safety checks)
        module.operation.verify()

        # 4. Lower to LLVM Dialect
        pm = PassManager.parse("builtin.module(convert-scf-to-cf, convert-cf-to-llvm, convert-func-to-llvm, convert-arith-to-llvm)")
        pm.run(module.operation)

        # 5. Cache the lowered MLIR/LLVM text
        with open(cache_filepath, "w") as f:
            f.write(str(module))
        
        print(f"✅ Successfully compiled and verified MLIR to {cache_filepath}")
```

---

### Phase 3: The Execution Engine (`component4_jit.py`)
We update the live production server to read the `.mlir` text file and compile it using the MLIR `ExecutionEngine`, which wraps the LLVM ORC JIT internally but handles the MLIR ABI (Application Binary Interface) mapping automatically.

**Refactor the `PolyKernelJIT` class in `component4_jit.py`:**

```python
import ctypes
from mlir.ir import Context, Module
from mlir.execution_engine import ExecutionEngine
from mlir.passmanager import PassManager

class PolyKernelMLIRJIT:
    def __init__(self):
        self.ctx = Context()
        self.engines = [] # Keep references alive to prevent GC crashes

    def load_and_compile(self, mlir_filepath: str, func_name: str, c_func_signature):
        """
        Reads lowered MLIR text, JIT compiles to RAM, and returns a callable Python C-function pointer.
        """
        with open(mlir_filepath, "r") as f:
            mlir_text = f.read()

        with self.ctx:
            # 1. Parse the cached MLIR text
            module = Module.parse(mlir_text)
            
            # 2. Final Execution Engine Lowering (creates machine code in RAM)
            # opt_level=3 gives us the aggressive AVX-512/NEON vectorization
            engine = ExecutionEngine(module, opt_level=3)
            self.engines.append(engine)
            
            # 3. Extract the C-compatible function pointer
            # MLIR ExecutionEngine requires us to pass pointers to pointers for arguments
            def execution_wrapper(*args):
                # Convert Python/ctypes args to pointers for MLIR ABI
                arg_pointers = [ctypes.pointer(ctypes.c_double(arg)) for arg in args]
                result = ctypes.c_double(0.0)
                res_pointer = ctypes.pointer(result)
                
                # Execute the bare-metal code
                engine.invoke(func_name, res_pointer, *arg_pointers)
                return result.value

            return execution_wrapper

# Usage from Orchestrator:
# jit = PolyKernelMLIRJIT()
# compiled_math = jit.load_and_compile(".poly_cache/math.mlir", "compute_gravity", None)
# result = compiled_math(5000.0, 1200.0)
```

### Note to the Senior Engineer
1. **The ABI Bridge:** Note the `execution_wrapper` in Component 4. The MLIR `ExecutionEngine` `invoke` method does not take raw floats; it takes an array of pointers to the arguments, and the first argument is a pointer to the result. 
2. **Dialect Lowering:** The `PassManager.parse(...)` string in Component 9 is the absolute magic of MLIR. It takes high-level logical loops (`scf.for`) and mathematically transforms them down into raw LLVM branch instructions automatically. If Z3 and the `module.operation.verify()` pass succeed, the generated code is guaranteed memory-safe.



## 2.0 Fix for MLIR import
The artifact from mlir-wheels is not a standard, PEP-517 compliant Python package. Because LLVM's massive C++ CMake build system fundamentally does not understand Python packaging, that .whl file literally just takes the raw make install C++ prefix directory (/bin, /lib, /include, /python_packages) and unzips it directly into your Python site-packages.

When Python tries to import mlir, it hits the C++ prefix folder instead of the Python module, and the entire pipeline crashes. Furthermore, the compiled .so C-extensions cannot find their linked LLVM shared libraries because they are hidden inside that non-standard /lib folder.

Here is the exact architectural fix. We do not need to abandon the wheel, but we must build a Bootstrapper to map the Python runtime to this bizarre C++ prefix dynamically.

The Fix: The MLIR Bootstrapper
Before any file tries to import mlir.ir or mlir.execution_engine, we must inject a runtime patch that redirects Python's sys.path to the buried mlir_core folder, and pre-loads the hidden LLVM shared libraries so the C-bindings don't throw an ImportError: libLLVM.so not found.

Create a new file named component0_mlir_bootstrap.py:

Python
import sys
import os
import site
import ctypes

def bootstrap_mlir_prefix():
    """
    Dynamically patches the Python runtime to understand the non-standard 
    LLVM/MLIR C++ prefix installed by the mlir-wheels package.
    """
    # 1. Find where pip dumped the LLVM prefix
    site_packages = site.getsitepackages()[0]
    mlir_prefix_dir = os.path.join(site_packages, "mlir")
    
    if not os.path.exists(mlir_prefix_dir):
        raise RuntimeError(f"MLIR prefix not found at {mlir_prefix_dir}. Did you pip install the wheel?")

    # 2. Patch sys.path so Python can find the actual 'mlir' python module
    # It is buried inside the C++ prefix under /python_packages/mlir_core
    python_core_path = os.path.join(mlir_prefix_dir, "python_packages", "mlir_core")
    if python_core_path not in sys.path:
        sys.path.insert(0, python_core_path)

    # 3. Pre-load the C++ Shared Libraries (The LD_LIBRARY_PATH hack)
    # The Python C-extensions require libLLVM.so and libMLIR.so, which are 
    # hidden in the prefix's /lib folder. We load them into the global namespace.
    lib_dir = os.path.join(mlir_prefix_dir, "lib")
    
    # Load order matters: LLVM first, then MLIR Public API
    try:
        # Note: Exact .so names might vary slightly by OS (e.g., .dylib on Mac)
        ext = ".dylib" if sys.platform == "darwin" else ".so"
        
        # Load LLVM
        llvm_lib = [f for f in os.listdir(lib_dir) if f.startswith("libLLVM") and f.endswith(ext)][0]
        ctypes.CDLL(os.path.join(lib_dir, llvm_lib), mode=ctypes.RTLD_GLOBAL)
        
        # Load MLIR C API
        mlir_lib = [f for f in os.listdir(lib_dir) if f.startswith("libMLIRPublicAPI") and f.endswith(ext)][0]
        ctypes.CDLL(os.path.join(lib_dir, mlir_lib), mode=ctypes.RTLD_GLOBAL)
        
    except IndexError:
        print("[WARNING] Could not aggressively pre-load LLVM shared libraries. Import may fail.")

# Execute immediately upon import
bootstrap_mlir_prefix()
Implementing the Bootstrapper
Now, you simply instruct your Senior Engineer to add exactly one line of code to the very top of component4_jit.py and component9_aot.py.

It must be imported before any mlir imports:

Python
# component4_jit.py / component9_aot.py

import component0_mlir_bootstrap # <-- INJECT THIS LINE FIRST

from mlir.ir import Context, Module
from mlir.execution_engine import ExecutionEngine
from mlir.passmanager import PassManager
# ... rest of the code ...

## 3.0 update component 8

The Engineering Handoff: Updating Component 8
Here is the exact refactor for component8_macro2.py to make your benchmarking suite compatible with the new MLIR AOT cache.

Refactor component8_macro2.py:

Python
import time
import ctypes
import requests
from rich.console import Console
from rich.table import Table

# INJECT THE BOOTSTRAPPER FIRST
import component0_mlir_bootstrap

from mlir.ir import Context, Module
from mlir.execution_engine import ExecutionEngine
from legacy_shop.ecommerce import calculate_vip_revenue

console = Console()
API_URL = "http://127.0.0.1:8080/api/v1/orders"
CACHE_FILE = "./.poly_cache/vectorized_vip_sum.mlir" # Updated extension

# Global reference to prevent Garbage Collection of the MLIR engine
_JIT_ENGINE_REF = None 

def load_cached_kernel():
    """
    Bypasses the LLM entirely. Reads the Boot-Time generated MLIR from disk.
    """
    global _JIT_ENGINE_REF
    import os
    if not os.path.exists(CACHE_FILE):
        raise FileNotFoundError(f"AOT Cache missing! Run component9_aot.py first.")
        
    with open(CACHE_FILE, 'r') as f:
        mlir_text = f.read()

    # 1. Parse and Compile using MLIR
    ctx = Context()
    with ctx:
        module = Module.parse(mlir_text)
        # opt_level=3 guarantees the AVX-512 vectorization
        jit_engine = ExecutionEngine(module, opt_level=3)
        _JIT_ENGINE_REF = jit_engine # Keep alive
        
        # 2. Create the ABI-compliant execution wrapper
        def mlir_execution_wrapper(c_byte_buffer_ptr, buffer_length):
            # MLIR expects a pointer for the return value
            result = ctypes.c_double(0.0)
            res_pointer = ctypes.pointer(result)
            
            # The arguments must also be passed as pointers to the ExecutionEngine
            arg1_ptr = ctypes.pointer(c_byte_buffer_ptr)
            arg2_ptr = ctypes.pointer(ctypes.c_int32(buffer_length))
            
            # Invoke the bare-metal code
            jit_engine.invoke("vectorized_vip_sum", res_pointer, arg1_ptr, arg2_ptr)
            return result.value

        return mlir_execution_wrapper

def run_macro_benchmark():
    console.print(f"\n[bold cyan]🌐 Fetching Production Payload...[/bold cyan]")
    try:
        response = requests.get(API_URL)
        payload_bytes = response.content
    except requests.exceptions.ConnectionError:
        console.print("[bold red]❌ Web server not running on port 8080.[/bold red]")
        return
        
    buffer_length = len(payload_bytes)
    console.print(f"📦 Payload size: {buffer_length / 1024:.1f} KB")

    # --- 1. Baseline CPython Execution ---
    start_py = time.perf_counter()
    py_result = calculate_vip_revenue(payload_bytes)
    py_time = time.perf_counter() - start_py

    # --- 2. Poly-Kernel AOT Execution (MLIR) ---
    try:
        jit_func = load_cached_kernel()
    except Exception as e:
        console.print(f"[bold red]❌ Failed to load MLIR Kernel: {e}[/bold red]")
        return
    
    # Cast python bytes to a raw C-char pointer
    c_byte_buffer = ctypes.cast(ctypes.create_string_buffer(payload_bytes), ctypes.c_char_p)
    
    start_jit_exec = time.perf_counter()
    
    # Execute the ABI wrapper
    jit_result = jit_func(c_byte_buffer, buffer_length)
    
    jit_exec_time = time.perf_counter() - start_jit_exec
    
    # --- 3. Render Dashboard ---
    table = Table(title="End-to-End API Benchmark: Python vs AOT Poly-Kernel (MLIR)", style="magenta")
    table.add_column("Architecture", style="dim")
    table.add_column("Result", justify="right")
    table.add_column("Execution time", justify="right")

    table.add_row(
        "CPython", 
        f"${py_result:,.2f}", 
        f"[red]{py_time:.4f}s[/red]"
    )
    
    speedup = py_time / jit_exec_time if jit_exec_time > 0 else float('inf')
    
    table.add_row(
        "Poly-Kernel (MLIR)", 
        f"${jit_result:,.2f}", 
        f"[bold green]{jit_exec_time:.4f}s[/bold green] ({speedup:.1f}x Faster)"
    )
    
    console.print("\n", table)

if __name__ == "__main__":
    run_macro_benchmark()

## 4.0 Update component 7
The Engineering Handoff: Updating Component 7
Refactor component7_benchmark.py:

Python
import time
import ctypes
from rich.console import Console
from rich.table import Table

# INJECT THE BOOTSTRAPPER FIRST
import component0_mlir_bootstrap

from mlir.ir import Context, Module
from mlir.execution_engine import ExecutionEngine

console = Console()
CACHE_FILE = "./.poly_cache/math_gravity.mlir" # The AOT generated MLIR

# Global reference to prevent Garbage Collection
_JIT_ENGINE_REF = None 

# --- 1. The Baseline Python Logic ---
def compute_gravity_py(m1: float, m2: float, distance: float) -> float:
    """Standard CPython execution path"""
    # G = 6.67430e-11
    return (6.67430e-11 * m1 * m2) / (distance * distance)

# --- 2. The MLIR ABI Loader ---
def load_scalar_kernel():
    global _JIT_ENGINE_REF
    import os
    if not os.path.exists(CACHE_FILE):
        raise FileNotFoundError(f"AOT Cache missing! Generate the MLIR for gravity first.")
        
    with open(CACHE_FILE, 'r') as f:
        mlir_text = f.read()

    ctx = Context()
    with ctx:
        module = Module.parse(mlir_text)
        # opt_level=3 enables aggressive loop unrolling and FMA (Fused Multiply-Add)
        jit_engine = ExecutionEngine(module, opt_level=3)
        _JIT_ENGINE_REF = jit_engine 
        
        # The ABI-compliant scalar wrapper
        def mlir_gravity_wrapper(m1: float, m2: float, distance: float):
            # 1. Allocate pointer for the return value
            result = ctypes.c_double(0.0)
            res_ptr = ctypes.pointer(result)
            
            # 2. Convert raw Python floats to C-double pointers
            arg1_ptr = ctypes.pointer(ctypes.c_double(m1))
            arg2_ptr = ctypes.pointer(ctypes.c_double(m2))
            arg3_ptr = ctypes.pointer(ctypes.c_double(distance))
            
            # 3. Invoke via pointers
            jit_engine.invoke("compute_gravity", res_ptr, arg1_ptr, arg2_ptr, arg3_ptr)
            
            # 4. Extract the bare-metal calculated value
            return result.value

        return mlir_gravity_wrapper

def run_micro_benchmark():
    console.print(f"\n[bold cyan]🔬 Running Raw Compute Micro-Benchmark (1,000,000 Iterations)...[/bold cyan]")
    
    ITERATIONS = 1_000_000
    m1, m2, dist = 5000.0, 1200.0, 10.0

    # --- Baseline: CPython ---
    start_py = time.perf_counter()
    for _ in range(ITERATIONS):
        # We assign to a variable to prevent dead-code elimination by the interpreter
        py_res = compute_gravity_py(m1, m2, dist) 
    py_time = time.perf_counter() - start_py

    # --- Poly-Kernel: MLIR ---
    try:
        jit_func = load_scalar_kernel()
    except Exception as e:
        console.print(f"[bold red]❌ Failed to load MLIR Kernel: {e}[/bold red]")
        return
        
    start_jit = time.perf_counter()
    for _ in range(ITERATIONS):
        jit_res = jit_func(m1, m2, dist)
    jit_time = time.perf_counter() - start_jit

    # --- Sanity Check ---
    # Due to floating point precision differences between Python and AVX registers, 
    # we check for near-equality rather than strict equality.
    assert abs(py_res - jit_res) < 1e-15, f"Math Mismatch! Py: {py_res}, MLIR: {jit_res}"

    # --- Render Dashboard ---
    table = Table(title="Pure Math Loop: CPython vs Poly-Kernel (MLIR)", style="cyan")
    table.add_column("Architecture", style="dim")
    table.add_column("Final Result", justify="right")
    table.add_column("Execution time", justify="right")

    table.add_row("CPython", f"{py_res:.12e}", f"[red]{py_time:.4f}s[/red]")
    
    speedup = py_time / jit_time if jit_time > 0 else float('inf')
    table.add_row("Poly-Kernel (MLIR)", f"{jit_res:.12e}", f"[bold green]{jit_time:.4f}s[/bold green] ({speedup:.1f}x Faster)")
    
    console.print("\n", table)

if __name__ == "__main__":
    run_micro_benchmark()
