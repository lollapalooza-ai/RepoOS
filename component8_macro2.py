import time
import ctypes
import requests
from rich.console import Console
from rich.table import Table

# INJECT THE BOOTSTRAPPER FIRST

from mlir.ir import Context, Module
from mlir.execution_engine import ExecutionEngine
from legacy_shop.ecommerce import calculate_vip_revenue

console = Console()
API_URL = "http://127.0.0.1:8080/api/v1/orders"
CACHE_FILE = "./.poly_cache3/vectorized_vip_sum.mlir" # Updated extension

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
        # Note: We use the raw bytes directly for the Poly-Kernel
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
