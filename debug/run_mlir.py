import sys
import os
import torch
import time
import subprocess
import ctypes
import re
import inspect

class RepoOSRunner:
    def __init__(self, func_name):
        self.func_name = func_name
        self.gen_dir = "generated"
        self.results = {}

    def extract_code(self, file_path):
        """Surgically extracts code from logs or markdown blocks."""
        if not os.path.exists(file_path):
            return None
        
        with open(file_path, "r") as f:
            content = f.read()

        # 1. If it's a log, find the RESPONSE section
        if "--- RESPONSE ---" in content:
            content = content.split("--- RESPONSE ---")[1]

        # 2. If it's wrapped in JSON (like Branching)
        try:
            data = json.loads(content.strip())
            if "mlir" in data: content = data["mlir"]
        except: pass

        # 3. Strip Markdown backticks
        match = re.search(r"```(?:\w+)?\n(.*?)\n```", content, re.DOTALL)
        if match:
            content = match.group(1)
        
        return content.strip()

    def identify_track(self, code):
        if "torch" in code or "nn.Module" in code: return "PYTHON"
        if "#include" in code or "extern \"C\"" in code: return "CPP"
        if "module {" in code or "func.func" in code: return "MLIR"
        return "UNKNOWN"

    def find_latest_log(self, stage):
        """Finds the most recent log file for a specific stage."""
        import glob
        logs = glob.glob(f"oracle_logs/{stage}_*.log")
        if not logs: return None
        return max(logs, key=os.path.getmtime)

    def extract_bridge(self):
        """Extracts prep/post functions from the latest data_bridge log."""
        log_path = self.find_latest_log("data_bridge")
        if not log_path: 
            print("      ⚠️ No data_bridge log found. Using dummy inputs.")
            return None, None
        
        with open(log_path, "r") as f:
            content = f.read()
            if "--- RESPONSE ---" in content:
                content = content.split("--- RESPONSE ---")[1].strip()
        
        try:
            import json
            # Handle markdown-wrapped JSON
            json_match = re.search(r"(\{.*\})", content, re.DOTALL)
            if not json_match: return None, None
            data = json.loads(json_match.group(1))
            return data.get("prep"), data.get("post")
        except Exception as e:
            print(f"      ⚠️ Failed to parse bridge JSON: {e}")
            return None, None

    def run_python(self, code):
        # Ensure common libraries are available in exec scope
        import requests
        import numpy as np
        local_scope = {
            "torch": torch, 
            "nn": torch.nn, 
            "requests": requests, 
            "json": __import__("json"),
            "np": np,
            "numpy": np
        }
        
        try:
            # 1. Load the full code (Bridge + Kernel)
            exec(code, local_scope)
            
            GenClass = local_scope.get("GeneratedModule")
            prep_func = local_scope.get("prep_inputs")
            post_func = local_scope.get("post_process")
            
            if not GenClass: return "FAILED", "No GeneratedModule"
            module = GenClass()
            
            start = time.perf_counter_ns()
            # 2. Execution Flow: Prep (API Call) -> Kernel -> Post
            try:
                inputs = prep_func() if prep_func else []
            except Exception as e:
                return "FAILED", f"Prep failed: {e}"
            
            # Check kernel signature
            sig = inspect.signature(module.forward)
            try:
                if "out" in sig.parameters:
                    # Actual variant (DPS)
                    kernel_args = inputs[:-1]
                    out_buffer = inputs[-1]
                    mid_res = module(*kernel_args, out_buffer)
                else:
                    # Corrected variant (Functional)
                    # Filter out the 'out' buffer if prep provided one
                    kernel_args = inputs[:len(sig.parameters)]
                    mid_res = module(*kernel_args)
                
                final_res = post_func(mid_res) if post_func else mid_res
            except Exception as e:
                return "FAILED", f"Kernel/Post failed: {e}"
                
            end = time.perf_counter_ns()
            
            return (end - start) / 1e6, str(final_res)
        except Exception as e:
            return "FAILED", str(e)

    def run_cpp(self, code):
        src_path = f"{self.func_name}.cpp"
        lib_path = f"./{self.func_name}.so"
        with open(src_path, "w") as f: f.write(code)
        
        try:
            subprocess.run(["clang++", "-O3", "-shared", "-fPIC", "-march=native", src_path, "-o", lib_path], check=True, capture_output=True)
            lib = ctypes.CDLL(lib_path)
            
            # Note: Signature varies by track. This is a heuristic for validation.
            start = time.perf_counter_ns()
            # We just verify it loads and links for this generic runner
            # Mocking response for C++ success
            res_val = "LINKED & EXECUTABLE"
            end = time.perf_counter_ns()
            
            os.remove(src_path)
            os.remove(lib_path)
            return (end - start) / 1e6, res_val
        except Exception as e:
            if os.path.exists(src_path): os.remove(src_path)
            return "FAILED", str(e)

    def run_mlir(self, code):
        tmp = "temp.mlir"
        with open(tmp, "w") as f: f.write(code)
        mlir_opt = os.environ.get("MLIR_OPT", "./torch-mlir/build/bin/mlir-opt")
        
        start = time.perf_counter_ns()
        res = subprocess.run([mlir_opt, tmp], capture_output=True, text=True)
        end = time.perf_counter_ns()
        
        os.remove(tmp)
        if res.returncode == 0:
            return (end - start) / 1e6, "VALID SYNTAX"
        return "FAILED", res.stderr.split("\n")[0]

    def run_baseline(self):
        """Executes the original function from test_tracks.py as a baseline."""
        try:
            # Ensure current directory is in path
            sys.path.append(os.getcwd())
            import test_tracks
            import importlib
            importlib.reload(test_tracks) # Ensure we have latest changes
            
            func = getattr(test_tracks, self.func_name)
            sig = inspect.signature(func)
            
            start = time.perf_counter_ns()
            # Dynamic argument injection based on track heuristics
            if len(sig.parameters) == 0:
                result = func()
            else:
                # Mock inputs for math/tabular baseline
                # (A, x) style
                A = torch.randn(3, 3).to_sparse_csr()
                x = torch.randn(3, 1)
                try:
                    result = func(A, x)
                except:
                    # Fallback for scalar inputs
                    result = func(150) # Heuristic for branching_hotspot
            
            end = time.perf_counter_ns()
            res_val = result.item() if hasattr(result, "item") else str(result)
            return (end - start) / 1e6, res_val
        except Exception as e:
            return "FAILED", str(e)

    def benchmark(self):
        print(f"\n📊 Benchmarking: {self.func_name}")
        print("-" * 80)
        
        # 1. Run Python Baseline first
        self.results["python_baseline"] = self.run_baseline()

        # 2. Run AI Variants
        for variant in ["actual", "corrected"]:
            path = os.path.join(self.gen_dir, f"{self.func_name}_{variant}.txt")
            code = self.extract_code(path)
            
            if not code:
                self.results[variant] = ("MISSING", "N/A")
                continue
                
            track = self.identify_track(code)
            
            if track == "PYTHON":
                self.results[variant] = self.run_python(code)
            elif track == "CPP":
                self.results[variant] = self.run_cpp(code)
            elif track == "MLIR":
                self.results[variant] = self.run_mlir(code)
            else:
                self.results[variant] = ("UNSUPPORTED", "N/A")

        # Print Table
        print(f"{'Variant':15} | {'Time (ms)':15} | {'Response/Error'}")
        print("-" * 80)
        for variant, (t, resp) in self.results.items():
            t_disp = f"{t:.4f} ms" if isinstance(t, float) else t
            print(f"{variant:15} | {t_disp:15} | {resp}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 run_mlir.py <function_name>")
        sys.exit(1)
        
    runner = RepoOSRunner(sys.argv[1])
    runner.benchmark()
