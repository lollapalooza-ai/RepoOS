import time
import ctypes
import requests
import importlib
import sys
import os
import asyncio
import json
from rich.console import Console
from rich.table import Table

# --- 1. Import original Python function first to get baseline ---
from legacy_shop.ecommerce import calculate_vip_revenue as original_calculate_vip_revenue

# --- 2. Boot RepoOS Hijacker ---
from component6_hijacker import boot_poly_kernel
orchestrator = boot_poly_kernel("legacy_shop")

console = Console()
API_URL = "http://127.0.0.1:8080/api/v1/orders"

def run_macro_benchmark():
    console.print(f"\n[bold cyan]🌐 Fetching Production Payload...[/bold cyan]")
    try:
        response = requests.get(API_URL)
        payload_bytes = response.content
    except requests.exceptions.ConnectionError:
        console.print("[bold red]❌ Web server not running on port 8080. Start api_server.py first.[/bold red]")
        return
        
    buffer_length = len(payload_bytes)
    console.print(f"📦 Payload size: {buffer_length / 1024:.1f} KB")

    # --- Baseline CPython Execution ---
    import tracemalloc
    tracemalloc.start()
    start_py = time.perf_counter()
    start_py_cpu = time.process_time()
    py_result = original_calculate_vip_revenue(payload_bytes)
    py_cpu_time = time.process_time() - start_py_cpu
    py_time = time.perf_counter() - start_py
    _, py_mem_peak = tracemalloc.get_traced_memory()
    tracemalloc.stop()

    # --- Step 1: Query Oracle for 3 FSM schedules ---
    from component2_smt import generate_fsm_transforms
    import ast
    
    with open("legacy_shop/ecommerce.py", "r") as f:
        py_code = f.read()
    
    tree = ast.parse(py_code)
    func_code = ""
    for node in ast.walk(tree):
        if isinstance(node, ast.FunctionDef) and node.name == "calculate_vip_revenue":
            func_code = ast.unparse(node)
            break
            
    print("\n1. Querying AI for FSM Builder Schedule...")
    script = asyncio.run(generate_fsm_transforms(func_code))
    if not script:
        print("Failed to get script from AI.")
        return
        
    schedules = [script]

    # --- Step 2: Compile FSM Variants using RepoOSFSMBuilder ---
    from component9_aot import RepoOSFSMBuilder, safe_execute_fsm_schedule, CACHE_DIR
    
    compiled_dylibs = []
    for idx, script in enumerate(schedules):
        variant_dylib = os.path.join(CACHE_DIR, f"fsm_variant_{idx}.dylib")
        cpp_source = os.path.join(CACHE_DIR, f"fsm_variant_{idx}.cpp")
        
        try:
            fsm_builder = RepoOSFSMBuilder()
            safe_execute_fsm_schedule(script, fsm_builder)
            cpp_code = fsm_builder.build_cpp()
            with open(cpp_source, "w") as f:
                f.write(cpp_code)
                
            subprocess_env = os.environ.copy()
            # Compile with Clang
            import subprocess
            subprocess.run(["clang++", "-O3", "-shared", "-fPIC", "-march=native",
                            cpp_source, "-o", variant_dylib], check=True, env=subprocess_env)
            compiled_dylibs.append(variant_dylib)
        except Exception as err:
            print(f"Variant {idx+1} failed syntax/compilation: {err}")

    if not compiled_dylibs:
        print("❌ No FSM variants compiled successfully.")
        return

    # --- Step 3: Micro-Benchmark / Race the Compiled Kernels ---
    print(f"\n[Dynamo] 🏁 Racing {len(compiled_dylibs)} compiled FSM kernels to find the Speed of Light (SoL)...")
    for path in compiled_dylibs:
        print(f"🏎️  {os.path.basename(path)}")

    # Warmup runs
    for path in compiled_dylibs:
        lib = ctypes.CDLL(path)
        kernel = lib._mlir_ciface_main
        out_buffer = (ctypes.c_float * 10)()
        c_buf = ctypes.cast(ctypes.create_string_buffer(payload_bytes), ctypes.c_char_p)
        kernel(c_buf, ctypes.c_size_t(buffer_length), out_buffer)

    best_time = float('inf')
    best_dylib = None

    # Timing loop (100 iterations per variant)
    for idx, path in enumerate(compiled_dylibs):
        lib = ctypes.CDLL(path)
        kernel = lib._mlir_ciface_main
        out_buffer = (ctypes.c_float * 10)()
        c_buf = ctypes.cast(ctypes.create_string_buffer(payload_bytes), ctypes.c_char_p)
        
        t0 = time.perf_counter()
        for _ in range(100):
            kernel(c_buf, ctypes.c_size_t(buffer_length), out_buffer)
        t_spent = (time.perf_counter() - t0) / 100.0
        
        result = float(out_buffer[0])
        print(f"   -> {os.path.basename(path)} avg time: {t_spent*1000.0:.4f} ms, result: ${result:,.2f}")
        
        # Verify correctness against CPython baseline
        if t_spent < best_time and abs(result - py_result) < 0.01:
            best_time = t_spent
            best_dylib = path

    # --- Step 4: Register the Winner as the official JIT kernel ---
    if best_dylib:
        official_path = os.path.abspath(os.path.join(CACHE_DIR, "legacy_shop_ecommerce_calculate_vip_revenue.dylib"))
        import shutil
        shutil.copy(best_dylib, official_path)
        
        from neo4j import GraphDatabase
        driver = GraphDatabase.driver("bolt://localhost:7687", auth=("neo4j", "password"))
        with driver.session() as session:
            session.run("""
                MATCH (f:Function {fqn: 'legacy_shop.ecommerce.calculate_vip_revenue'})
                SET f.optimized_dylib_path = $path,
                    f.needs_recompile = false
            """, path=official_path)
        driver.close()
        print(f"\n🏆 Winner: {os.path.basename(best_dylib)} promoted to official JIT path.")

    # --- Step 5: Reload module to bind the winning FSM JIT kernel ---
    orchestrator._preload_registry()
    import legacy_shop.ecommerce
    importlib.reload(legacy_shop.ecommerce)
    from legacy_shop.ecommerce import calculate_vip_revenue as hijacked_calculate_vip_revenue

    # Run the final hijacked benchmark
    tracemalloc.start()
    start_jit = time.perf_counter()
    start_jit_cpu = time.process_time()
    jit_result = hijacked_calculate_vip_revenue(payload_bytes)
    jit_cpu_time = time.process_time() - start_jit_cpu
    jit_time = time.perf_counter() - start_jit
    _, jit_mem_peak = tracemalloc.get_traced_memory()
    tracemalloc.stop()
    
    # --- Render Dashboard ---
    table = Table(title="End-to-End API Benchmark: Python vs RepoOS FSM Kernel", style="magenta")
    table.add_column("Architecture", style="dim")
    table.add_column("Result", justify="right")
    table.add_column("Execution time", justify="right")
    table.add_column("CPU Time", justify="right")
    table.add_column("Peak Memory", justify="right")

    table.add_row(
        "CPython (Interpreter)", 
        f"${py_result:,.2f}", 
        f"[red]{py_time:.4f}s[/red]",
        f"{py_cpu_time:.4f}s",
        f"{py_mem_peak / 1024:.1f} KB"
    )
    
    speedup = py_time / jit_time if jit_time > 0 else float('inf')
    
    table.add_row(
        "RepoOS FSM Kernel (JIT)", 
        f"${jit_result:,.2f}", 
        f"[bold green]{jit_time:.4f}s[/bold green] ({speedup:.1f}x Faster)",
        f"{jit_cpu_time:.4f}s",
        f"{jit_mem_peak / 1024:.1f} KB"
    )
    
    console.print("\n", table)

if __name__ == "__main__":
    run_macro_benchmark()
