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
    cfunc = ctypes.CFUNCTYPE(ctypes.c_double, ctypes.c_int32, ctypes.POINTER(ctypes.c_bool), ctypes.POINTER(ctypes.c_double))(func_ptr)
    return cfunc, jit

def run_macro_benchmark():
    console.print(f"\n[bold cyan]🌐 Fetching 500k Orders from API ({API_URL})...[/bold cyan]")
    
    # --- The Network & Deserialization Tax ---
    try:
        net_start = time.perf_counter()
        response = requests.get(API_URL)
        # This is the massive standard CPython JSON parsing tax
        orders = response.json() 
        net_time = time.perf_counter() - net_start
    except Exception as e:
        console.print(f"[bold red]❌ Failed to connect to API server: {e}[/bold red]")
        console.print("[yellow]Ensure you run 'python3 -m legacy_shop.api_server' in a separate terminal.[/yellow]")
        return
    
    num_orders = len(orders)
    console.print(f"[dim]Network + json.loads() Time: {net_time:.4f}s[/dim]\n")
    
    # --- PHASE 1: Native CPython ---
    console.print("[yellow]🏃 Racing Standard CPython (Pointer Chasing)...[/yellow]")
    start_py = time.perf_counter()
    py_result = calculate_vip_revenue(orders)
    py_time = time.perf_counter() - start_py
    
    # --- PHASE 2: Poly-Kernel (AOT Cached) ---
    console.print("[yellow]⚡ Racing Poly-Kernel (Loading from .poly_cache)...[/yellow]")
    start_jit_total = time.perf_counter()
    
    # Step A: The Struct Transformer (Marshalling)
    vip_array_type = ctypes.c_bool * num_orders
    val_array_type = ctypes.c_double * num_orders
    vip_c_array = vip_array_type()
    val_c_array = val_array_type()
    
    for i in range(num_orders):
        vip_c_array[i] = orders[i]["user"]["is_vip"]
        val_c_array[i] = orders[i]["cart"]["total_value"]
        
    marshall_time = time.perf_counter() - start_jit_total
    
    # Step B: Load AOT Cache & Execute (Zero AI Latency)
    try:
        jit_func, _engine = load_cached_kernel() 
    except Exception as e:
        console.print(f"[bold red]❌ Failed to load cached kernel: {e}[/bold red]")
        return
    
    start_jit_exec = time.perf_counter()
    jit_result = jit_func(num_orders, vip_c_array, val_c_array)
    jit_exec_time = time.perf_counter() - start_jit_exec
    
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
    console.print("\n[bold cyan]Architect's Note:[/bold cyan] By loading the Execution Graph from the hard drive (`.poly_cache`), we have completely eliminated the 3-5 second LLM inference delay at runtime.")

if __name__ == "__main__":
    run_macro_benchmark()
