import sys
import time
import psutil
import subprocess
import os
import json
import re

def sample_resources(pid, interval=0.1):
    try:
        proc = psutil.Process(pid)
        mems = []
        cpus = []
        while proc.is_running():
            mems.append(proc.memory_info().rss / (1024 * 1024))
            cpus.append(proc.cpu_percent(interval=None))
            time.sleep(interval)
        return max(mems), sum(cpus)/len(cpus) if cpus else 0
    except:
        return 0, 0

def run_benchmark(label, cmd, env=None):
    print(f"   [Bench] Running {label}...")
    
    # 1. Capture Total Process Time
    start_time = time.perf_counter()
    p = subprocess.Popen(cmd, env=env, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    
    max_mem = 0
    cpu_samples = []
    proc = psutil.Process(p.pid)
    
    full_output = ""
    try:
        while p.poll() is None:
            try:
                m = proc.memory_info().rss / (1024 * 1024)
                max_mem = max(max_mem, m)
                cpu_samples.append(proc.cpu_percent(interval=None))
            except: pass
            time.sleep(0.05)
    except:
        pass
        
    p.wait()
    end_time = time.perf_counter()
    full_output = p.stdout.read()
    
    # 2. Extract Internal "Pure" Execution Time and Result if available
    # Looking for: "  - Avg Speed: 0.0090 ms" and "  - Final Result[0,0]: 3.2804"
    pure_time = None
    final_res = None
    
    t_matches = re.findall(r"Avg Speed: ([\d\.]+) ms", full_output)
    if t_matches:
        pure_time = float(t_matches[-1])
        
    r_matches = re.findall(r"Final Result\[0,0\]: ([\-\d\.]+)", full_output)
    if r_matches:
        final_res = float(r_matches[-1])

    duration = (end_time - start_time) * 1000 # ms (total)
    avg_cpu = sum(cpu_samples) / len(cpu_samples) if cpu_samples else 0
    
    return {
        "total_time": duration,
        "pure_time": pure_time,
        "result": final_res,
        "memory": max_mem,
        "cpu": avg_cpu,
        "success": p.returncode == 0,
        "output": full_output
    }

def main():
    if len(sys.argv) < 3:
        print("Usage: python3 benchmark_collector.py <mode> <script> [target]")
        sys.exit(1)
        
    mode = sys.argv[1]
    script = sys.argv[2]
    target = sys.argv[3] if len(sys.argv) > 3 else ""
    
    # Pre-run RepoOS once to ensure compilation is cached
    if mode == "inference":
        print(f"   [Prep] Pre-compiling RepoOS kernels for {script}...")
        subprocess.run(["./repoos.sh", "inference", script], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    
    # 1. NATIVE RUN
    native_env = os.environ.copy()
    native_env["PYTHONPATH"] = os.getcwd()
    native_res = run_benchmark("NATIVE", ["./build_venv/bin/python3", script], env=native_env)
    
    # 2. REPOOS RUN
    repoos_env = os.environ.copy()
    if mode == "inference":
        repoos_cmd = ["./repoos.sh", "inference", script]
        repoos_env["REPOOS_INFERENCE"] = "1"
    else:
        repoos_cmd = ["./repoos.sh", script, target]
        
    repoos_res = run_benchmark("REPOOS", repoos_cmd, env=repoos_env)
    
    # SUMMARY TABLE
    print("\n" + "="*80)
    print(f"📊 PURE EXECUTION BENCHMARK: {script}")
    print("="*80)
    print(f"{'Metric':20} | {'Native':15} | {'RepoOS':15} | {'Gain/Diff'}")
    print("-"*80)
    
    # Use Pure Time if available
    t_native = native_res["pure_time"] if native_res["pure_time"] else native_res["total_time"]
    t_repoos = repoos_res["pure_time"] if repoos_res["pure_time"] else repoos_res["total_time"]
    
    speedup = t_native / t_repoos if t_repoos > 0 else 0
    label = "Exec Time (ms)" if native_res["pure_time"] else "Total Time (ms)"
    print(f"{label:20} | {t_native:15.4f} | {t_repoos:15.4f} | {speedup:.2f}x")
    
    m_native, m_repoos = native_res["memory"], repoos_res["memory"]
    print(f"{'Peak Memory (MB)':20} | {m_native:15.2f} | {m_repoos:15.2f} | {m_repoos - m_native:+.2f} MB")
    
    c_native, c_repoos = native_res["cpu"], repoos_res["cpu"]
    print(f"{'Avg CPU (%)':20} | {c_native:15.1f} | {c_repoos:15.1f} | {c_repoos - c_native:+.1f}%")
    
    # Result Comparison
    r_native = native_res["result"]
    r_repoos = repoos_res["result"]
    if r_native is not None and r_repoos is not None:
        match_str = "MATCH" if abs(r_native - r_repoos) < 1e-5 else "MISMATCH"
        print(f"{'Final Result[0,0]':20} | {r_native:15.4f} | {r_repoos:15.4f} | {match_str}")
    
    print("-" * 80)
    print(f"Timing Source: {'Internal (Pure)' if native_res['pure_time'] else 'External (Process)'}")
    status = "SUCCESS" if repoos_res["success"] else "FAILED"
    print(f"REPOOS STATUS: {status}")
    print("="*80)

if __name__ == "__main__":
    main()
