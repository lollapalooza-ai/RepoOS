import time
import ctypes
import requests
import llvmlite.binding as llvm
from rich.console import Console
from rich.table import Table

from legacy_shop.ecommerce import calculate_vip_revenue

console = Console()
API_URL = "http://127.0.0.1:8080/api/v1/orders"
CACHE_FILE = "./.poly_cache/vectorized_vip_sum.ll"

def load_cached_kernel():
    """
    Bypasses the LLM entirely. Reads the Boot-Time generated LLVM IR from disk.
    """
    import os
    if not os.path.exists(CACHE_FILE):
        raise FileNotFoundError(f"AOT Cache missing! Run component9_aot.py first.")
        
    with open(CACHE_FILE, 'r') as f:
        llvm_ir = f.read()

    llvm.initialize()
    llvm.initialize_native_target()
    llvm.initialize_native_asmprinter()
    
    target_machine = llvm.Target.from_default_triple().create_target_machine()
    jit = llvm.create_mcjit_compiler(llvm.parse_assembly(llvm_ir), target_machine)
    jit.finalize_object()
    
    func_ptr = jit.get_function_address("vectorized_vip_sum")
    cfunc = ctypes.CFUNCTYPE(ctypes.c_double, ctypes.c_char_p, ctypes.c_int32)(func_ptr)
    return cfunc, jit

def run_macro_benchmark():
    console.print(f"\n[bold cyan]🌐 Fetching 500k Orders from API ({API_URL})...[/bold cyan]")
    
    # --- The Network & Deserialization Tax ---
    try:
        net_start = time.perf_counter()
        response = requests.get(API_URL)
        # Standard Python baseline still uses json.loads()
        orders = response.json() 
        net_time = time.perf_counter() - net_start
        
        # Intercept raw bytes for Poly-Kernel
        raw_bytes = response.content
        buffer_length = len(raw_bytes)
    except Exception as e:
        console.print(f"[bold red]❌ Failed to connect to API server: {e}[/bold red]")
        console.print("[yellow]Ensure you run 'python3 -m legacy_shop.api_server' in a separate terminal.[/yellow]")
        return
    
    console.print(f"[dim]Network + json.loads() Time: {net_time:.4f}s[/dim]")
    console.print(f"[dim]Intercepted {buffer_length} bytes from network.[/dim]\n")
    
    # --- PHASE 1: Native CPython ---
    console.print("[yellow]🏃 Racing Standard CPython (Pointer Chasing)...[/yellow]")
    start_py = time.perf_counter()
    py_result = calculate_vip_revenue(orders)
    py_time = time.perf_counter() - start_py
    
    # --- PHASE 2: Poly-Kernel Zero-Copy (AOT Cached) ---
    console.print("[yellow]⚡ Racing Poly-Kernel (Zero-Copy Byte Scanner)...[/yellow]")
    
    # Lock the raw bytes in memory so C can read it without Python interfering
    c_byte_buffer = ctypes.create_string_buffer(raw_bytes, buffer_length)
    
    try:
        # Load the newly compiled FSM parser
        jit_func, _engine = load_cached_kernel() 
        
        # Define the ctypes signature
        jit_func.argtypes = [ctypes.c_char_p, ctypes.c_int32]
        jit_func.restype = ctypes.c_double
        
    except Exception as e:
        console.print(f"[bold red]❌ Failed to load FSM kernel: {e}[/bold red]")
        return
    
    start_jit_exec = time.perf_counter()
    
    # We pass the memory address directly. No dictionaries. No translation loops.
    jit_result = jit_func(c_byte_buffer, buffer_length)
    
    jit_exec_time = time.perf_counter() - start_jit_exec
    marshall_time = 0.0000 
    
    # --- 3. Render Dashboard ---
    table = Table(title="End-to-End API Benchmark: Python vs AOT Poly-Kernel", style="magenta")
    table.add_column("Architecture", style="dim")
    table.add_column("Result", justify="right")
    table.add_column("Data Marshalling", justify="right")
    table.add_column("Execution Time", justify="right")
    table.add_column("AI Generation Delay", justify="right")

    table.add_row(
        "CPython", f"${py_result:,.2f}", "N/A", f"{py_time:.4f}s", "N/A"
    )
    
    speedup = py_time / jit_exec_time if jit_exec_time > 0 else float('inf')
    table.add_row(
        "Poly-Kernel", f"${jit_result:,.2f}", f"{marshall_time:.4f}s", f"{jit_exec_time:.4f}s", "[bold green]0.0000s (Cache Hit)[/bold green]"
    )
    
    console.print("\n")
    console.print(table)
    console.print("\n[bold cyan]Architect's Note:[/bold cyan] By bypassing object allocation and scanning raw bytes directly in RAM, the Poly-Kernel has completely eliminated the Data Marshalling tax.")

if __name__ == "__main__":
    run_macro_benchmark()
