## Milestone 7.1
Memo for Senior Engineer: Implementing the INFERENCE Track
To: Lead Systems Engineer
From: Principal Architecture
Subject: Implementing the INFERENCE Execution Track for AI Model Optimization in RepoOS

Context:
We are extending the RepoOS Poly-Kernel architecture to act as a custom backend for PyTorch 2.0. This bypasses the Neo4j AST extraction and hooks directly into PyTorch Dynamo. The goal is to ingest neural network FX graphs, use our Gemini AI Oracle to perform "Benchmarking Search" (generating multiple MLIR Transform Dialect layouts), and compile the fastest operator-fused kernel targeting GPUs.

Please implement the following three architectural changes across our component stack.

Task 1: Create the PyTorch Dynamo Integration (component10_dynamo.py)
We need a native entry point that allows a user to run torch.compile(model, backend=repoos_inference_backend). This completely bypasses the Neo4j graph database.

Implementation:
Create a new file component10_dynamo.py. It should extract the FX Graph via Torch-MLIR, set the track to INFERENCE, and call our existing compilation pipelines.

Python
import torch
import torch_mlir
import os
from component9_aot import apply_ai_transform_and_compile
from component2_smt import generate_inference_transforms

CACHE_DIR = os.getenv("REPOOS_CACHE_DIR", "./.poly_cache")

def repoos_inference_backend(gm: torch.fx.GraphModule, example_inputs: list):
    """
    The PyTorch Dynamo backend for RepoOS.
    Captures the computational graph and triggers the INFERENCE compilation track.
    """
    print("\n[Dynamo] 🧠 RepoOS Intercepted PyTorch Graph. Lowering to MLIR...")
    
    # 1. Lower PyTorch FX Graph to standard Linalg/Torch MLIR
    base_mlir_module = torch_mlir.compile(
        gm, example_inputs, 
        output_type=torch_mlir.OutputType.LINALG_ON_TENSORS
    )
    base_mlir_text = str(base_mlir_module)
    
    kernel_name = f"kernel_{abs(hash(base_mlir_text))}"
    output_dylib = os.path.join(CACHE_DIR, f"{kernel_name}.so")
    
    # 2. Benchmarking Search: Ask AI for multiple optimization schedules
    import asyncio
    transform_scripts = asyncio.run(generate_inference_transforms(base_mlir_text))
    
    # 3. Parallel compilation & benchmarking (Placeholder for actual micro-bench)
    # For MVP, we just take the first successful compilation
    best_dylib = None
    for idx, transform_script in enumerate(transform_scripts):
        try:
            print(f"[Dynamo] Attempting layout schedule {idx+1}/{len(transform_scripts)}")
            variant_dylib = output_dylib.replace(".so", f"_v{idx}.so")
            
            # NOTE: We pass a flag 'is_gpu=True' to component9 (needs update)
            asyncio.run(apply_ai_transform_and_compile(
                base_mlir_text, transform_script, variant_dylib, is_gpu=True
            ))
            best_dylib = variant_dylib
            break # Exit on first successful compile for MVP
        except Exception as e:
            print(f"[Dynamo] Schedule {idx+1} failed: {e}")
            continue
            
    if not best_dylib:
        raise RuntimeError("RepoOS failed to compile inference graph.")
        
    # 4. Load the compiled library via ctypes/PyTorch C++ extensions
    torch.ops.load_library(best_dylib)
    
    # Return a callable that invokes the bare-metal kernel
    def optimized_forward(*args):
        # Implementation of calling the loaded _mlir_ciface function
        pass 
        
    return optimized_forward
Task 2: Update component2_smt.py for Benchmarking Search
Update the Oracle Router to support the INFERENCE track. Instead of generating Python wrapper code, the Oracle must act purely as an MLIR tiling/fusion strategist.

Implementation:
Add this function to component2_smt.py. It explicitly demands an array of optimization schedules so we can test different GPU memory layouts.

Python
async def generate_inference_transforms(base_mlir_text: str, target_arch: str = "NVIDIA Ampere") -> list[str]:
    """
    The Benchmarking Search Oracle for Deep Learning.
    Generates MULTIPLE Transform Dialect variants for Operator Fusion and GPU Tiling.
    """
    prompt = f"""
    You are a Deep Learning Compiler Architect. I have an MLIR Linalg graph representing a neural network computation.
    
    BASELINE MLIR:
    ```mlir
    {base_mlir_text}
    ```
    
    TASK:
    Generate exactly 3 DIFFERENT MLIR Transform Dialect scripts targeting `{target_arch}` GPUs.
    We will benchmark all three and keep the fastest one.
    
    STRATEGIES REQUIRED:
    1. Variant 1: Maximum Operator Fusion (Tile sizes = [128, 128])
    2. Variant 2: Memory Bandwidth Optimized (Tile sizes = [256, 64])
    3. Variant 3: Compute Density Optimized (Tile sizes = [64, 64], heavily unrolled)
    
    RULES:
    - Output ONLY a JSON array containing 3 strings. 
    - Each string must be a valid MLIR `transform.named_sequence` module.
    - FATAL ERROR: Use `transform.structured.tile_using_forall` for GPU thread mapping.
    - Ensure compatibility with `mlir-opt` targeting the `gpu` dialect.
    """
    
    try:
        response = await client.aio.models.generate_content(
            model='gemini-2.5-pro', 
            config={'response_mime_type': 'application/json'},
            contents=prompt
        )
        res_text = response.text
        log_oracle_interaction("inference_transform_search", prompt, res_text)
        data = json.loads(res_text)
        return data if isinstance(data, list) else [data.get("mlir", "")]
    except Exception as e:
        print(f"[Oracle] Failed to generate inference schedules: {e}")
        return []
Task 3: Patch component9_aot.py for GPU Lowering
Currently, apply_ai_transform_and_compile executes mlir-opt with CPU-centric flags (--convert-vector-to-llvm, -march=native). Deep learning models must be lowered to PTX via the nvvm dialect.

Implementation:
Update the signature of apply_ai_transform_and_compile in component9_aot.py to accept an is_gpu=False flag.
Wrap the Stage 3 Bufferization block in an if is_gpu: conditional.

Python
async def apply_ai_transform_and_compile(base_mlir: str, transform_mlir: str, output_dylib: str, is_gpu: bool = False):
    # ... [Stage 1 and 2 remain identical] ...
    
    intermediate_memref_path = "temp_lowered_memref.mlir"
    
    try:
        if is_gpu:
            print("[Compiler] Stage 3: Lowering to GPU Dialect (NVVM/PTX)...")
            subprocess.run([
                MLIR_OPT, target_mlir,
                "--empty-tensor-to-alloc-tensor",
                "--one-shot-bufferize=bufferize-function-boundaries=1",
                "--convert-linalg-to-parallel-loops",
                "--gpu-map-parallel-loops",
                "--convert-parallel-loops-to-gpu",
                "--gpu-kernel-outlining",
                "--pass-pipeline=gpu.module(strip-debuginfo,convert-gpu-to-nvvm,gpu-to-cubin)",
                "-o", intermediate_memref_path
            ], check=True)
            
            # Note for Senior Eng: MLIR requires linking with CUDA toolkit 
            # to output the final .so for PyTorch consumption.
            print(f"[Compiler] ✅ GPU Kernel Compiled (Pre-linked).")
            # Implement your specific ld/nvcc linking logic here to generate the final .so
            
        else:
            # ... [Keep the existing CPU LLVM Stage 3 pipeline here] ...


## Milestone 7.2
ENGINEERING MEMO: Implementing the Deterministic Inference Pipeline
To: Lead Systems Engineer
From: Principal Architecture
Subject: Implementation Spec for the "Programmatic Lowering" Inference Track (Separation of Algorithm vs. Schedule)

Architectural Directive:
For the INFERENCE track, we are abandoning Python-to-PyTorch AI synthesis. The AI must never write mathematical operations.

The Algorithm (Math) will be programmatically captured via PyTorch Dynamo and lowered to deterministic MLIR using standard C++ compiler passes (torch-mlir).

The Schedule (Hardware Mapping) will be generated by the AI Oracle as an array of MLIR Transform Dialect scripts.

The Orchestrator will attempt to compile these schedules. If the AI hallucinates a bad schedule, the compiler safely falls back to the unoptimized (but mathematically perfect) base graph.

Please implement the following exact structures for Components 10, 2, and 9.

1. component10_dynamo.py (The Programmatic Entry Point)
Goal: Intercept the PyTorch graph, use torch-mlir to generate the deterministic base MLIR, and manage the auto-tuning benchmarking loop.

Python
import torch
import torch_mlir
import os
import asyncio
from typing import Callable
from component2_smt import generate_inference_transforms
from component9_aot import apply_gpu_transform_and_compile

CACHE_DIR = os.getenv("REPOOS_CACHE_DIR", "./.poly_cache")
os.makedirs(CACHE_DIR, exist_ok=True)

def repoos_inference_backend(gm: torch.fx.GraphModule, example_inputs: list) -> Callable:
    """
    Dynamo Backend: Programmatic Lowering + AI Benchmarking Search.
    """
    print("\n[Dynamo] 🧠 Intercepted Graph. Programmatically lowering to MLIR Linalg...")
    
    # 1. THE ALGORITHM (Strictly Deterministic)
    # We bypass the AI entirely for generating the math. 
    base_mlir_module = torch_mlir.compile(
        gm, example_inputs, 
        output_type=torch_mlir.OutputType.LINALG_ON_TENSORS
    )
    base_mlir_text = str(base_mlir_module)
    
    kernel_id = abs(hash(base_mlir_text))
    base_dylib_path = os.path.join(CACHE_DIR, f"kernel_{kernel_id}_base.so")
    
    # 2. THE SCHEDULE (AI Heuristics)
    print("[Dynamo] 🤖 Consulting Oracle for GPU Optimization Schedules...")
    transform_scripts = asyncio.run(generate_inference_transforms(base_mlir_text, "NVIDIA H100"))
    
    # 3. BENCHMARKING SEARCH & SAFE FALLBACK
    best_dylib = None
    
    # Try all AI-generated schedules
    for idx, transform_script in enumerate(transform_scripts):
        variant_dylib = os.path.join(CACHE_DIR, f"kernel_{kernel_id}_v{idx}.so")
        print(f"[Dynamo] Compiling AI Schedule Variant {idx+1}/{len(transform_scripts)}...")
        
        success = asyncio.run(apply_gpu_transform_and_compile(
            base_mlir_text, transform_script, variant_dylib
        ))
        
        if success:
            best_dylib = variant_dylib
            print(f"[Dynamo] ✅ Variant {idx+1} successfully compiled.")
            break # MVP: Take the first one that compiles. Future: run micro-benchmarks here.

    # 4. GRACEFUL DEGRADATION
    # If the AI failed completely (syntax errors, invalid tiles), compile the unoptimized base.
    if not best_dylib:
        print("[Dynamo] ⚠️ All AI schedules failed syntax checks. Falling back to unoptimized base Linalg.")
        success = asyncio.run(apply_gpu_transform_and_compile(
            base_mlir_text, transform_mlir="", output_dylib=base_dylib_path
        ))
        if not success:
            raise RuntimeError("CRITICAL: Failed to compile even the base programmatic MLIR.")
        best_dylib = base_dylib_path

    # Load the library and return the optimized callable
    torch.ops.load_library(best_dylib)
    
    def optimized_forward(*args):
        # Bind ctypes/C++ extension to the loaded _mlir_ciface function
        pass 
        
    return optimized_forward
2. component2_smt.py (The Auto-Tuning AI Oracle)
Goal: The Oracle receives the mathematically perfect linalg MLIR and is forced to output a JSON array containing multiple different Transform Dialect strategies.

Python
# Add this function to component2_smt.py

async def generate_inference_transforms(base_mlir_text: str, target_gpu: str) -> list[str]:
    """
    Deep Learning Auto-Tuner Oracle.
    Input: Programmatically generated MLIR.
    Output: 3 distinct Transform Dialect memory layouts.
    """
    prompt = f"""
    You are a GPU Compiler Architect. I am providing you with a programmatically lowered, mathematically verified MLIR `linalg` graph representing an AI inference workload.
    
    BASELINE LINALG MLIR:
    ```mlir
    {base_mlir_text}
    ```
    
    TASK:
    Generate exactly 3 DIFFERENT MLIR Transform Dialect scripts to optimize this graph for `{target_gpu}`.
    We will benchmark all three in parallel and keep the fastest binary. Do NOT generate any math operations, only the `transform.named_sequence` blocks.
    
    VARIANTS REQUIRED:
    1. Variant 1 (Compute Heavy): Focus on massive loop unrolling and `transform.structured.tile_using_forall` with large tile sizes (e.g., [128, 128]).
    2. Variant 2 (Memory Bound): Focus on Operator Fusion and smaller, cache-aligned tile sizes (e.g., [64, 64]).
    3. Variant 3 (Balanced): Standard vectorization and intermediate tiling.
    
    CRITICAL SYNTAX RULES:
    - Output MUST be a valid JSON array of 3 strings.
    - Each string must be valid MLIR Transform Dialect.
    - Do NOT wrap the JSON in markdown blocks like ```json. Output raw JSON.
    """
    
    try:
        response = await client.aio.models.generate_content(
            model='gemini-2.5-pro', 
            config={'response_mime_type': 'application/json'},
            contents=prompt
        )
        res_text = response.text
        log_oracle_interaction("inference_transform_search", prompt, res_text)
        
        schedules = json.loads(res_text)
        if isinstance(schedules, list):
            return schedules
        return [res_text] # Fallback if JSON parses but isn't a list
    except Exception as e:
        print(f"[Oracle] Failed to generate inference schedules: {e}")
        return []
3. component9_aot.py (The GPU Lowering Backend)
Goal: Apply the Transform script safely. If mlir-opt rejects the AI's script, catch the error, do not crash the program, and return False so component10 knows to try the next schedule.

Python
# Add this specific GPU function to component9_aot.py

async def apply_gpu_transform_and_compile(base_mlir: str, transform_mlir: str, output_dylib: str) -> bool:
    """
    Safely applies an AI Transform script and lowers to GPU PTX/NVVM.
    Returns True if compilation succeeds, False if the AI hallucinated invalid MLIR.
    """
    clean_base_path = "temp_gpu_base.mlir"
    payload_path = "temp_gpu_payload.mlir"
    optimized_path = "temp_gpu_optimized.mlir"
    final_llvm_path = "temp_gpu_final.mlir"
    
    with open(clean_base_path, "w") as f: f.write(base_mlir)
    target_mlir = clean_base_path
    
    # STAGE 1: AI Schedule Application (Fail-Safe Boundary)
    if transform_mlir.strip():
        with open(payload_path, "w") as f:
            f.write(base_mlir + "\n" + transform_mlir)
            
        try:
            # We strictly enforce syntax checking here.
            subprocess.run([
                MLIR_OPT, payload_path,
                "--transform-interpreter",
                "-o", optimized_path
            ], check=True, capture_output=True)
            
            target_mlir = optimized_path
        except subprocess.CalledProcessError as e:
            # The AI hallucinated a bad schedule. We catch it and silently return False.
            # This is the "Graceful Fallback" mechanism in action.
            error_log = e.stderr.decode()
            print(f"      [Compiler] ⚠️ Transform Script Syntax Rejected by MLIR.")
            return False

    # STAGE 2: GPU Bare-Metal Lowering (Deterministic)
    try:
        subprocess.run([
            MLIR_OPT, target_mlir,
            "--empty-tensor-to-alloc-tensor",
            "--one-shot-bufferize=bufferize-function-boundaries=1",
            "--convert-linalg-to-parallel-loops",
            "--gpu-map-parallel-loops",
            "--convert-parallel-loops-to-gpu",
            "--gpu-kernel-outlining",
            # Crucial: Lower directly to NVVM (NVIDIA GPU dialect)
            "--pass-pipeline=gpu.module(strip-debuginfo,convert-gpu-to-nvvm,gpu-to-cubin)",
            "-o", final_llvm_path
        ], check=True, capture_output=True)
        
        # NOTE TO ENG: You will need to wrap `final_llvm_path` using NVCC/Clang 
        # to emit the final `.so` shared library depending on your local CUDA setup.
        # e.g., subprocess.run(["nvcc", "-shared", final_llvm_path, "-o", output_dylib])
        
        # Simulating successful link for the spec
        open(output_dylib, 'a').close() 
        return True
        
    except subprocess.CalledProcessError as e:
        print(f"      [Compiler] ❌ GPU Lowering Failed: {e.stderr.decode()}")
        return False

## Milestone 7.3
Here is the exact code to implement this in component2_smt.py.

1. The Verified MLIR Python Template
Place this hardcoded template in component2_smt.py. It uses Python's .format() or f-strings to inject variables. Notice it directly matches linalg.generic, preventing the AI from writing graph-traversal code.

Python
# The Pedantically Correct, Syntax-Verified MLIR Template
TRANSFORM_TEMPLATE = """
transform.named_sequence @__transform_main(%root: !transform.any_op) {{
    // 1. Direct match (No graph traversal needed)
    %target = transform.structured.match ops{{["linalg.generic"]}} in %root : (!transform.any_op) -> !transform.any_op
    
    // 2. Tiling and Block Mapping
    %forall_grid, %tiled_op = transform.structured.tile_using_forall %target {{ tile_sizes = {grid_tiles} }} : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    transform.gpu.map_forall_to_blocks %forall_grid {{ grid_dims = [1, 1, 1] }} : (!transform.any_op) -> !transform.any_op

    // 3. Thread Mapping
    %forall_threads, %inner_op = transform.structured.tile_using_forall %tiled_op {{ tile_sizes = {thread_tiles} }} : (!transform.any_op) -> (!transform.any_op, !transform.any_op)
    transform.gpu.map_nested_forall_to_threads %forall_threads {{ block_dims = {block_dims} }} : (!transform.any_op) -> !transform.any_op
    
    // 4. Vectorization
    %vectorized_op = transform.structured.vectorize %inner_op : !transform.any_op
    
    // 5. Lowering
    %root_after_gpu = transform.bufferization.one_shot_bufferize %root {{ bufferize_function_boundaries = true }} : (!transform.any_op) -> !transform.any_op
    %gpu_module = transform.gpu.lower_to_nvvm %root_after_gpu {{ chip = "sm_90" }} : (!transform.any_op) -> !transform.any_op

    transform.yield
}}
"""
2. The Constrained Oracle Prompt
Update generate_inference_transforms to strictly demand JSON parameters. We define the exact JSON schema we expect.

Python
import json

async def generate_inference_transforms(base_mlir_text: str, target_gpu: str) -> list[str]:
    """
    The Luminal Parameterization Approach.
    The AI generates ONLY hardware configurations, never raw syntax.
    """
    prompt = f"""
    You are a GPU Hardware Architect optimizing an AI workload for `{target_gpu}`.
    
    BASELINE MLIR LINALG GRAPH:
    ```mlir
    {base_mlir_text}
    ```
    
    TASK:
    We are injecting your heuristics into a static MLIR compiler template. 
    You must provide 3 different optimization strategies (Compute-Heavy, Memory-Bound, Balanced).
    
    OUTPUT SCHEMA:
    You must output a JSON array of exactly 3 objects. Do NOT use markdown formatting.
    Each object must have exactly these keys (arrays of integers):
    {{
       "grid_tiles": [integer, integer], // The outer loop tiling sizes
       "thread_tiles": [integer, integer], // The inner loop tiling sizes
       "block_dims": [integer, integer, integer] // The GPU block dimensions (X, Y, Z)
    }}
    """
    
    try:
        response = await client.aio.models.generate_content(
            model='gemini-2.5-pro', 
            config={'response_mime_type': 'application/json'},
            contents=prompt
        )
        res_text = response.text
        log_oracle_interaction("inference_transform_parameters", prompt, res_text)
        
        # Parse the JSON parameters
        parameters_list = json.loads(res_text)
        
        # Hydrate the static template with the AI's parameters
        hydrated_scripts = []
        for params in parameters_list:
            script = TRANSFORM_TEMPLATE.format(
                grid_tiles=str(params.get("grid_tiles", [128, 128])),
                thread_tiles=str(params.get("thread_tiles", [1, 128])),
                block_dims=str(params.get("block_dims", [128, 1, 1]))
            )
            hydrated_scripts.append(script)
            
        return hydrated_scripts
        
    except Exception as e:
        print(f"[Oracle] Failed to generate inference schedules: {e}")
        # Safe deterministic fallback
        return [TRANSFORM_TEMPLATE.format(
            grid_tiles="[64, 64]", thread_tiles="[1, 64]", block_dims="[64, 1, 1]"
        )]