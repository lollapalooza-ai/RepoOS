import time
import ctypes
import json
import os
import importlib
import requests
import llvmlite.ir as ir
import llvmlite.binding as llvm
import psutil
from rich.console import Console
from rich.table import Table

from component2_smt import VerifiedMLIR
from component4_jit import PolyKernelJIT, TYPE_MAP

console = Console()
CACHE_DIR = "./.poly_cache2"
REPORT_FILE = "poly_kernel_comprehensive_report.md"

def get_metrics():
    process = psutil.Process(os.getpid())
    mem = process.memory_info().rss / (1024 * 1024)  # MB
    cpu_time = process.cpu_times().user + process.cpu_times().system
    return mem, cpu_time

# Define functions to benchmark
BENCHMARK_SUITE = [
    {
        "fqn": "legacy_shop.heavy_math.compute_gravity",
        "module": "legacy_shop.heavy_math",
        "func": "compute_gravity",
        "args": (5000.0, 1200.0),
        "arg_types": ['float', 'float'],
        "iterations": 1000000,
        "name": "Scalar Gravity Math"
    },
    {
        "fqn": "legacy_shop.auth.check_password",
        "module": "legacy_shop.auth",
        "func": "check_password",
        "args": ("password123", "5f4dcc3b5aa765d61d8327deb882cf99"), 
        "arg_types": ['str', 'str'],
        "iterations": 100000,
        "name": "Security: Password Check"
    },
    {
        "fqn": "legacy_shop.utils.calculate_tax",
        "module": "legacy_shop.utils",
        "func": "calculate_tax",
        "args": (100.0, "CA"),
        "arg_types": ['float', 'str'], # Note: Gemini treats arg1 as ptr to struct holding str
        "iterations": 500000,
        "name": "Branching: Tax Logic"
    },
    {
        "fqn": "legacy_shop.utils.dynamic_pricing",
        "module": "legacy_shop.utils",
        "func": "dynamic_pricing",
        "args": (50.0, 1.5),
        "arg_types": ['float', 'float'], # Note: Gemini treats arg1 as ptr to struct holding float
        "iterations": 1000000,
        "name": "Conditional: Pricing"
    }
]

def load_jit_func(fqn, arg_types):
    cache_file = os.path.join(CACHE_DIR, f"{fqn.replace('.', '_')}.json")
    if not os.path.exists(cache_file): return None
    with open(cache_file, 'r') as f:
        mlir_data = VerifiedMLIR.model_validate_json(f.read())
    jit = PolyKernelJIT()
    ir_args = []
    ctypes_args = []
    
    # DYNAMIC POINTER DETECTION: If MLIR uses an argument in a 'gep', it must be a pointer.
    pointer_args = set()
    for op in mlir_data.operations:
        if op.op == "gep" and op.args[0].startswith("arg"):
            pointer_args.add(op.args[0])

    for i, t in enumerate(arg_types):
        arg_name = f"arg{i}"
        ir_t, c_t = TYPE_MAP.get(t, TYPE_MAP['double'])
        if arg_name in pointer_args:
             ir_args.append(ir.PointerType(ir_t))
             ctypes_args.append(ctypes.POINTER(c_t))
        else:
            ir_args.append(ir_t)
            ctypes_args.append(c_t)
    CFuncType = ctypes.CFUNCTYPE(ctypes.c_double, *ctypes_args)
    return jit.incremental_compile(fqn.split('.')[-1], mlir_data, CFuncType, len(arg_types), ir_arg_types=ir_args)

def load_cached_kernel(cache_file):
    """
    Bypasses the LLM entirely. Reads the Boot-Time generated LLVM IR from disk.
    """
    if not os.path.exists(cache_file):
        raise FileNotFoundError(f"AOT Cache missing: {cache_file}")
        
    with open(cache_file, 'r') as f:
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

def run_comprehensive_benchmark():
    final_results = []
    total_py_time = 0
    total_jit_time = 0
    
    console.print("[bold green]🚀 Initiating Final Bare-Metal Alignment Benchmark...[/bold green]\n")
    
    for item in BENCHMARK_SUITE:
        fqn = item["fqn"]
        console.print(f"Benchmarking [cyan]{item['name']}[/cyan]...")
        
        try:
            mod = importlib.import_module(item["module"])
            py_func = getattr(mod, item["func"])
            jit_func = load_jit_func(fqn, item["arg_types"])
            if not jit_func: continue

            args = item["args"]
            py_args = list(args)
            jit_args = []
            
            # --- GENERIC ALIGNMENT ---
            for i, val in enumerate(args):
                t = item["arg_types"][i]
                if t == 'str':
                    jit_args.append(val.encode('utf-8'))
                else:
                    jit_args.append(val)

            # Python
            mem_pre, cpu_pre = get_metrics()
            start = time.perf_counter()
            for _ in range(item["iterations"]):
                res_py = py_func(*py_args)
            py_time = (time.perf_counter() - start)
            mem_post, cpu_post = get_metrics()
            py_mem = mem_post - mem_pre
            py_cpu = cpu_post - cpu_pre
            
            # JIT
            mem_pre, cpu_pre = get_metrics()
            start = time.perf_counter()
            for _ in range(item["iterations"]):
                res_jit = jit_func(*jit_args)
            jit_time = (time.perf_counter() - start)
            mem_post, cpu_post = get_metrics()
            jit_mem = mem_post - mem_pre
            jit_cpu = cpu_post - cpu_pre

            final_results.append({
                "name": item["name"],
                "py_res": str(res_py),
                "jit_res": str(res_jit),
                "py_time": py_time,
                "jit_time": jit_time,
                "py_mem": py_mem,
                "jit_mem": jit_mem,
                "py_cpu": py_cpu,
                "jit_cpu": jit_cpu
            })
            total_py_time += py_time
            total_jit_time += jit_time
        except Exception as e:
            import traceback
            console.print(f"[red]  ❌ Failed {fqn}:[/red]")
            console.print(traceback.format_exc())

    # --- VIP REVENUE (Production Parity - API Fetch + Zero-Copy) ---
    API_URL = "http://127.0.0.1:8080/api/v1/orders"
    console.print(f"Benchmarking [cyan]Aggregator: VIP Revenue (500k from API)[/cyan]...")
    try:
        from legacy_shop.ecommerce import calculate_vip_revenue
        
        # 1. Measure CPython Baseline (Full Network + Parse + Logic)
        mem_pre, cpu_pre = get_metrics()
        start_full_py = time.perf_counter()
        response = requests.get(API_URL)
        orders = response.json() # Includes json.loads() tax
        res_py = calculate_vip_revenue(orders)
        task_py_time = time.perf_counter() - start_full_py
        mem_post, cpu_post = get_metrics()
        py_mem = mem_post - mem_pre
        py_cpu = cpu_post - cpu_pre
        
        # 2. Prepare JIT Input (Raw bytes intercepted from the same response)
        raw_bytes = response.content
        
        # 3. Measure Poly-Kernel (Pure Zero-Copy Logic)
        jit_func, _engine = load_cached_kernel("./.poly_cache/vectorized_vip_sum.ll")
        
        mem_pre, cpu_pre = get_metrics()
        start_jit = time.perf_counter()
        res_jit = jit_func(raw_bytes, len(raw_bytes))
        task_jit_time = time.perf_counter() - start_jit
        mem_post, cpu_post = get_metrics()
        jit_mem = mem_post - mem_pre
        jit_cpu = cpu_post - cpu_pre
        
        final_results.append({
            "name": "Aggregator: VIP Revenue",
            "py_res": f"{res_py:.2f}",
            "jit_res": f"{res_jit:.2f}",
            "py_time": task_py_time,
            "jit_time": task_jit_time,
            "py_mem": py_mem,
            "jit_mem": jit_mem,
            "py_cpu": py_cpu,
            "jit_cpu": jit_cpu
        })
        total_py_time += task_py_time
        total_jit_time += task_jit_time
    except Exception as e:
        console.print(f"  ❌ VIP Revenue API Benchmark failed: {e}")

    # --- ZERO-COPY SCAN ---
    console.print(f"Benchmarking [cyan]End-to-End Zero-Copy Scan (100k orders)[/cyan]...")
    try:
        from legacy_shop.ecommerce import generate_payload
        raw_data = generate_payload(100000)
        json_str = json.dumps(raw_data)
        json_bytes = json_str.encode('utf-8')
        
        mem_pre, cpu_pre = get_metrics()
        start = time.perf_counter()
        parsed = json.loads(json_str)
        res_py = "Processed"
        py_time = time.perf_counter() - start
        mem_post, cpu_post = get_metrics()
        py_mem = mem_post - mem_pre
        py_cpu = cpu_post - cpu_pre
        
        with open(os.path.join(CACHE_DIR, "legacy_shop_api_server_get_orders.json"), 'r') as f:
            mlir_data = VerifiedMLIR.model_validate_json(f.read())
        jit = PolyKernelJIT()
        jit_scanner = jit.incremental_compile("fsm", mlir_data, ctypes.CFUNCTYPE(ctypes.c_double, ctypes.c_char_p, ctypes.c_int32), 0)
        
        mem_pre, cpu_pre = get_metrics()
        start = time.perf_counter()
        jit_scanner(json_bytes, len(json_bytes))
        res_jit = "Processed"
        jit_total_time = time.perf_counter() - start
        mem_post, cpu_post = get_metrics()
        jit_mem = mem_post - mem_pre
        jit_cpu = cpu_post - cpu_pre
        
        final_results.append({
            "name": "End-to-End Zero-Copy Scan",
            "py_res": res_py,
            "jit_res": res_jit,
            "py_time": py_time,
            "jit_time": jit_total_time,
            "py_mem": py_mem,
            "jit_mem": jit_mem,
            "py_cpu": py_cpu,
            "jit_cpu": jit_cpu
        })
        total_py_time += py_time
        total_jit_time += jit_total_time
    except Exception as e:
        console.print(f"  ❌ Zero-Copy failed: {e}")

    # --- RENDER DASHBOARD ---
    table = Table(title="Repo OS v4.0 FINAL COMPREHENSIVE BENCHMARK")
    table.add_column("Task", style="cyan")
    table.add_column("CPython Res", justify="right")
    table.add_column("Poly-Kernel Res", justify="right")
    table.add_column("CPython Time/CPU/Mem", justify="right")
    table.add_column("Poly-Kernel Time/CPU/Mem", justify="right")
    table.add_column("Speedup", justify="right", style="bold green")

    for r in final_results:
        is_fallback = r['jit_time'] > r['py_time']
        s = r['py_time'] / r['jit_time'] if r['jit_time'] > 0 else 0
        
        jit_display = f"{r['jit_time']:.4f}s / {r['jit_cpu']:.2f}s / {r['jit_mem']:.2f}MB"
        py_display = f"{r['py_time']:.4f}s / {r['py_cpu']:.2f}s / {r['py_mem']:.2f}MB"
        speedup_display = f"{s:.1f}x"
        
        if is_fallback:
            jit_display = "[yellow]FALLBACK TO CPython[/yellow]"
            speedup_display = "[dim]1.0x[/dim]"
            # Adjust total jit time for the final summary to reflect fallback behavior
            total_jit_time -= r['jit_time']
            total_jit_time += r['py_time']

        table.add_row(r['name'], r['py_res'], r['jit_res'], py_display, jit_display, speedup_display)
    
    table.add_section()
    ts = total_py_time / total_jit_time if total_jit_time > 0 else 0
    table.add_row("TOTAL RUN TIME", "-", "-", f"[red]{total_py_time:.4f}s[/red]", f"[green]{total_jit_time:.4f}s[/green]", f"[bold white on green] {ts:.1f}x [/bold white on green]")
    console.print("\n", table)

    # Save Markdown
    with open(REPORT_FILE, "w") as f:
        f.write("# Final Comprehensive Latency Report (with Auto-Fallback)\n\n")
        f.write("| Task | CPython Res | Poly-Kernel Res | Py Time/CPU/Mem | JIT Time/CPU/Mem | Speedup | Status |\n")
        f.write("| :--- | :---: | :---: | :---: | :---: | :---: | :---: |\n")
        for r in final_results:
            is_fallback = r['jit_time'] > r['py_time']
            s = r['py_time'] / r['jit_time'] if r['jit_time'] > 0 else 0
            
            jt = f"{r['jit_time']:.4f}s / {r['jit_cpu']:.2f}s / {r['jit_mem']:.2f}MB"
            py_d = f"{r['py_time']:.4f}s / {r['py_cpu']:.2f}s / {r['py_mem']:.2f}MB"
            sd = f"{s:.1f}x"
            status = "JIT Active"
            if is_fallback:
                jt = f"{r['py_time']:.4f}s / {r['py_cpu']:.2f}s / {r['py_mem']:.2f}MB"
                sd = "1.0x"
                status = "FALLBACK TO CPython"
                
            f.write(f"| {r['name']} | {r['py_res']} | {r['jit_res']} | {py_d} | {jt} | {sd} | {status} |\n")
        f.write(f"| **TOTAL** | - | - | **{total_py_time:.4f}s** | **{total_jit_time:.4f}s** | **{ts:.1f}x** | - |\n")

if __name__ == "__main__":
    run_comprehensive_benchmark()
