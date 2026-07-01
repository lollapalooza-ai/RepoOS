import subprocess
import os
import ctypes
import torch
import time
import re

CLANG = "clang"
MLIR_OPT = "/home/yeshr/repoos/projectrepo/torch-mlir/build/bin/mlir-opt"
OPENMP_THRESHOLD = 1
CACHE_DIR = os.getenv("REPOOS_CACHE_DIR", "./.poly_cache")
os.makedirs(CACHE_DIR, exist_ok=True)

def to_true_dps(mlir_text: str) -> str:
    """
    Surgically transforms a standard functional MLIR module into True DPS.
    1. Adds an output tensor as the LAST argument.
    2. Replaces the internal tensor.empty() with that argument.
    """
    match = re.search(r"func\.func @main\((.*?)\)\s*->\s*(tensor<.*?>)", mlir_text)
    if not match: return mlir_text
    
    args = match.group(1)
    ret_type = match.group(2)
    
    arg_count = len(re.findall(r"%arg\d+", args))
    out_arg = f"%arg{arg_count}"
    
    new_args = args + f", {out_arg}: {ret_type}"
    mlir_text = mlir_text.replace(f"func.func @main({args})", f"func.func @main({new_args})")
    
    ret_type_escaped = re.escape(ret_type)
    pattern = r"(%[a-zA-Z0-9_]+) = tensor\.empty\([^)]*\)\s*:\s*" + ret_type_escaped
    matches = list(re.finditer(pattern, mlir_text))
    if matches:
        last_match = matches[-1]
        mlir_text = mlir_text[:last_match.start()] + f"{last_match.group(1)} = tensor.cast {out_arg} : {ret_type} to {ret_type}" + mlir_text[last_match.end():]
    
    return mlir_text

def prune_abi_to_void(mlir_text: str) -> str:
    def repl(m):
        func_decl = m.group(1)
        return func_decl + " attributes {llvm.emit_c_interface} {"
    mlir_text = re.sub(
        r"(func\.func\s+@[a-zA-Z0-9_\./]+\([^)]*\))(?:\s*->\s*[^\{]+)?\s*\{",
        repl,
        mlir_text,
        count=1
    )
    mlir_text = re.sub(
        r"return\s+[%a-zA-Z0-9_, ]+\s*:\s*.*",
        r"return",
        mlir_text
    )
    return mlir_text

def build_ctypes_wrapper(dylib_path, gm):
    from component5_orchestrator import pack_tensor_to_memref
    lib = ctypes.CDLL(dylib_path)
    k_func = lib._mlir_ciface_main if hasattr(lib, "_mlir_ciface_main") else lib.main
    k_func.restype = ctypes.c_void_p

    def optimized_forward(*args):
        try:
            # print(f"[Runtime] Invoking Bare-Metal Kernel: {dylib_path}")
            kernel_args = []
            numpy_arrays = []
            structs = []
            
            for arg in args:
                if not isinstance(arg, torch.Tensor): continue
                arr = arg.detach().cpu().numpy()
                numpy_arrays.append(arr)
                memref = pack_tensor_to_memref(arg)
                structs.append(memref)
                kernel_args.append(ctypes.byref(memref))
            
            with torch.device('meta'):
                meta_args = [a.to('meta') if isinstance(a, torch.Tensor) else a for a in args]
                meta_out = gm(*meta_args)
            if isinstance(meta_out, tuple):
                meta_out = meta_out[0]
                
            res_torch = torch.zeros(meta_out.shape, dtype=meta_out.dtype, device=args[0].device)
            res_arr = res_torch.detach().cpu().numpy()
            numpy_arrays.append(res_arr)
            memref_res = pack_tensor_to_memref(res_torch)
            structs.append(memref_res)
            kernel_args.append(ctypes.byref(memref_res))

            k_func(*kernel_args)
            res = torch.from_numpy(res_arr)
            return [res]
        except Exception as e:
            print(f"[Runtime] ❌ Bare-Metal Execution Failed: {e}")
            raise e
            
    return optimized_forward

def run_arena_race(compiled_dylibs, example_inputs, gm):
    print(f"\n\n--- [Isolated Benchmarking Phase - V2 E-Graph Arena] ---")
    print(f"{'Variant Name':<32} | {'Speed (ms)':<10} | {'CPUs Used':<9} | {'Memory (MB)':<12} | {'Correct'}")
    print("-" * 102)

    import psutil
    process = psutil.Process(os.getpid())
    best_dylib = compiled_dylibs[0]
    best_time = float('inf')

    # Baseline PyTorch
    try:
        for _ in range(2): gm(*example_inputs)
        start_time = time.perf_counter()
        start_cpu = process.cpu_times()
        for _ in range(10): gm(*example_inputs)
        end_time = time.perf_counter()
        end_cpu = process.cpu_times()
        
        avg_time_base = ((end_time - start_time) / 10.0) * 1000
        cpu_time_base = (((end_cpu.user - start_cpu.user) + (end_cpu.system - start_cpu.system)) / 10.0) * 1000
        cpus_used_base = cpu_time_base / avg_time_base if avg_time_base > 0 else 0.0
        mem_base = process.memory_info().rss / (1024 * 1024)
        print(f"{'PyTorch Native (MKL/BLAS)':<32} | {avg_time_base:10.4f} | {cpus_used_base:9.1f} | {mem_base:12.2f} | True")
    except Exception as e:
        print(f"{'PyTorch Native (MKL/BLAS)':<32} | {'CRASHED':<10} | {'-':<9} | {'-':<12} | False")

    from component5_orchestrator import pack_tensor_to_memref

    for dylib in compiled_dylibs:
        try:
            lib = ctypes.CDLL(dylib)
            k_func = lib._mlir_ciface_main if hasattr(lib, "_mlir_ciface_main") else lib.main
            k_func.restype = ctypes.c_void_p
            
            kernel_args = []
            numpy_arrays = []
            structs = []
            for arg in example_inputs:
                if not isinstance(arg, torch.Tensor): continue
                arr = arg.detach().cpu().numpy()
                numpy_arrays.append(arr)
                memref = pack_tensor_to_memref(arg)
                structs.append(memref)
                kernel_args.append(ctypes.byref(memref))
            
            with torch.device('meta'):
                meta_args = [a.to('meta') if isinstance(a, torch.Tensor) else a for a in example_inputs]
                meta_out = gm(*meta_args)
            if isinstance(meta_out, tuple):
                meta_out = meta_out[0]
            bench_res = torch.zeros(meta_out.shape, dtype=meta_out.dtype, device=example_inputs[0].device)
            bench_arr = bench_res.detach().cpu().numpy()
            numpy_arrays.append(bench_arr)
            memref_out = pack_tensor_to_memref(bench_res)
            structs.append(memref_out)
            kernel_args.append(ctypes.byref(memref_out))
                
            expected_out = gm(*example_inputs)
            if isinstance(expected_out, tuple): expected_out = expected_out[0]
                
            k_func(*kernel_args)
            is_correct = bool(torch.allclose(torch.from_numpy(bench_arr), expected_out, atol=1.0))
            result_str = "Match" if is_correct else "Mismatch"
            
            start_time = time.perf_counter()
            start_cpu = process.cpu_times()
            for _ in range(10): k_func(*kernel_args)
            end_time = time.perf_counter()
            end_cpu = process.cpu_times()
            
            avg_time = ((end_time - start_time) / 10.0) * 1000
            cpu_time = (((end_cpu.user - start_cpu.user) + (end_cpu.system - start_cpu.system)) / 10.0) * 1000
            cpus_used = cpu_time / avg_time if avg_time > 0 else 0.0
            mem_usage = process.memory_info().rss / (1024 * 1024)
            
            variant_name = os.path.basename(dylib)
            print(f"{variant_name:<32} | {avg_time:10.4f} | {cpus_used:9.1f} | {mem_usage:12.2f} | {result_str}")
            
            if avg_time < best_time:
                best_time = avg_time
                best_dylib = dylib
                
        except Exception as e:
            variant_name = os.path.basename(dylib)
            print(f"{variant_name:<32} | {'CRASHED':<10} | {'-':<9} | {'-':<12} | False")
            print(f"      ❌ Benchmark failed for {dylib}: {e}")

    print(f"[Dynamo] 🏆 Winner: {os.path.basename(best_dylib)} ({best_time:.4f} ms)")
    return best_dylib


def egraph_inference_backend(gm: torch.fx.GraphModule, example_inputs: list):
    """The new Dynamo Entry Point."""
    from component2_smt import generate_egraph_policy
    from component3_egraph import apply_egraph_search
    import asyncio
    from torch_mlir.fx import export_and_import
    
    print("\n[V2 Backend] 🧠 Intercepted Graph.")
    # 1. Get Policy and E-Graph Variants
    policy = asyncio.run(generate_egraph_policy(gm.code))
    
    base_mlir_module = export_and_import(
        gm, *example_inputs,
        output_type="linalg-on-tensors",
        dynamic_shapes=None
    )
    base_mlir_text = str(base_mlir_module)
    base_mlir_text = to_true_dps(base_mlir_text)
    
    fused_mlir_variants = apply_egraph_search(gm.graph.nodes, policy, base_mlir_text)
    
    compiled_dylibs = []
    
    # 2. Lower and Compile the Variants
    for i, mlir_text in enumerate(fused_mlir_variants):
        fusion_activated = False
        if mlir_text.startswith("// EGRAPH_FUSION_ACTIVATED"):
            fusion_activated = True
            mlir_text = mlir_text.replace("// EGRAPH_FUSION_ACTIVATED\n", "")
            
        # Scrub tm_tensor 
        with open("temp_raw.mlir", "w") as f: f.write(mlir_text)
        subprocess.run([
            "/home/yeshr/repoos/projectrepo/torch-mlir/build/bin/torch-mlir-opt", "temp_raw.mlir",
            "-pass-pipeline=builtin.module(torch-backend-to-linalg-on-tensors-backend-pipeline)", 
            "-o", "temp_linalg.mlir"
        ], check=True)

        dylib_path = os.path.join(CACHE_DIR, f"egraph_kernel_{i}.so")
        
        # Stage 1: Bufferize
        pipeline1 = "empty-tensor-to-alloc-tensor,one-shot-bufferize{bufferize-function-boundaries=1}"
        if fusion_activated:
            pipeline1 = "linalg-fuse-elementwise-ops," + pipeline1
            
        subprocess.run([
            MLIR_OPT, "temp_linalg.mlir",
            f"--pass-pipeline=builtin.module({pipeline1})",
            "-o", "memref.mlir"
        ], check=True)
        
        # --- UKERNEL INTERCEPT STAGE ---
        with open("memref.mlir", "r") as f:
            memref_text = f.read()

        import re
        pattern = r"linalg\.batch_matmul\s+ins\(([^,]+),\s*([^:]+)\s*:\s*(.+?),\s*(memref<.+)\)\s*outs\(([^:]+)\s*:\s*(.+)\)"
        
        ukernel_count = [0]
        def ukernel_replacer(m):
            a_var = m.group(1).strip()
            b_var = m.group(2).strip()
            a_type = m.group(3).strip()
            b_type = m.group(4).strip()
            c_var = m.group(5).strip()
            c_type = m.group(6).strip()
            
            idx = ukernel_count[0]
            ukernel_count[0] += 1
            
            dyn_type = "memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>"
            
            res = f"%A_cast_{idx} = memref.cast {a_var} : {a_type} to {dyn_type}\n"
            res += f"    %B_cast_{idx} = memref.cast {b_var} : {b_type} to {dyn_type}\n"
            res += f"    %C_cast_{idx} = memref.cast {c_var} : {c_type} to {dyn_type}\n"
            res += f"    func.call @ukernel_bmm(%A_cast_{idx}, %B_cast_{idx}, %C_cast_{idx}) : ({dyn_type}, {dyn_type}, {dyn_type}) -> ()"
            return res
            
        memref_text = re.sub(pattern, ukernel_replacer, memref_text)
        
        if ukernel_count[0] > 0:
            dyn_type = "memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>"
            func_decl = f"func.func private @ukernel_bmm({dyn_type}, {dyn_type}, {dyn_type})\n"
            last_brace_idx = memref_text.rfind('}')
            if last_brace_idx != -1:
                memref_text = memref_text[:last_brace_idx] + func_decl + memref_text[last_brace_idx:]
            else:
                memref_text += f"\n{func_decl}"
            
        with open("memref.mlir", "w") as f:
            f.write(memref_text)
        # -------------------------------

        memref_text = prune_abi_to_void(memref_text)
        with open("memref.mlir", "w") as f: f.write(memref_text)

        # Stage 2: Pure Lowering (No Transform Dialect baggage)
        pipeline = "memref-expand,convert-linalg-to-loops,expand-strided-metadata,lower-affine,convert-scf-to-cf,convert-cf-to-llvm,convert-vector-to-llvm,convert-arith-to-llvm,convert-math-to-llvm,convert-math-to-libm,convert-index-to-llvm,convert-ub-to-llvm,convert-func-to-llvm,finalize-memref-to-llvm,reconcile-unrealized-casts"
            
        subprocess.run([
            MLIR_OPT, "memref.mlir",
            f"--pass-pipeline=builtin.module({pipeline})",
            "-o", "kernel.mlir"
        ], check=True)
        
        # Stage 2.5: Translate MLIR to LLVM IR
        MLIR_TRANSLATE = "/home/yeshr/repoos/projectrepo/torch-mlir/build/bin/mlir-translate"
        subprocess.run([
            MLIR_TRANSLATE, "--mlir-to-llvmir", "kernel.mlir", "-o", "kernel.ll"
        ], check=True)
        
        # INTERCEPT: Fix invalid '-inf' float constants and 'nuw' GEP flags generated by mlir-translate
        with open("kernel.ll", "r") as f: ll_text = f.read()
        ll_text = ll_text.replace("float -inf", "float 0xFFF0000000000000")
        ll_text = ll_text.replace("getelementptr inbounds nuw", "getelementptr inbounds")
        ll_text = ll_text.replace("getelementptr nuw", "getelementptr")
        ll_text = ll_text.replace(" captures(none)", "")
        ll_text = ll_text.replace(" nocreateundeforpoison", "")
        
        import struct
        def repl_hex_float(m):
            hex_str = m.group(1)
            if len(hex_str) == 8:
                val = struct.unpack('>f', bytes.fromhex(hex_str))[0]
                double_hex = struct.pack('>d', val).hex().upper()
                return "0x" + double_hex
            return "0x" + hex_str
        ll_text = re.sub(r"\bf0x([0-9a-fA-F]+)\b", repl_hex_float, ll_text)
        
        with open("kernel.ll", "w") as f: f.write(ll_text)
        
        # Stage 3: The Clang Polly Auto-Parallelizer
        seq_len = example_inputs[0].shape[1] if len(example_inputs[0].shape) >= 2 else example_inputs[0].shape[0]
        clang_cmd = [CLANG, "-O3", "-march=native", "-ffast-math"]
        
        print(f"[DEBUG] egraph_inference_backend seq_len = {seq_len}, type = {type(seq_len)}")
        
        # In case seq_len is a SymInt or evaluated dynamically, we force OpenMP if it's large enough or if we just want to ensure parallel execution
        try:
            if int(seq_len) >= OPENMP_THRESHOLD:
                print(f"[Compiler] Sequence length {seq_len} >= {OPENMP_THRESHOLD}. Enabling OpenMP & Polly.")
                clang_cmd.extend(["-fopenmp", "-mllvm", "-polly", "-mllvm", "-polly-parallel"])
        except Exception as e:
            print(f"[Compiler] Warning: Could not evaluate seq_len: {e}. Enabling OpenMP anyway for safety.")
            clang_cmd.extend(["-fopenmp", "-mllvm", "-polly", "-mllvm", "-polly-parallel"])
            
        ukernel_path = os.path.abspath("ukernel.so")
        clang_cmd.extend(["-shared", "-fPIC", "kernel.ll", ukernel_path, f"-Wl,-rpath={os.path.dirname(ukernel_path)}", "-o", dylib_path, "-lm"])
        subprocess.run(clang_cmd, check=True)
        compiled_dylibs.append(dylib_path)

    # 3. Race in the Arena
    winner_dylib = run_arena_race(compiled_dylibs, example_inputs, gm)
    
    # Return ctypes wrapper pointing to winner_dylib
    return build_ctypes_wrapper(winner_dylib, gm)
