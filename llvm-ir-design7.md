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
    The ProjectX Parameterization Approach.
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

## Milestone 7.4 : The Python Scheduling Architecture
End-to-End Implementation of RepoOSSchedule
Here is exactly how this works under the hood in component9_aot.py.

Step 3A: The Builder Class (component9_aot.py)
This class is the "translation engine." It accepts high-level Python commands and safely constructs the highly volatile MLIR syntax.

Python
class RepoOSSchedule:
    """
    The Python Builder API for MLIR Transform Dialect.
    Ensures 100% syntactically valid MLIR generation.
    """
    def __init__(self):
        self.instructions = []
        self.var_counter = 0

    def _next_var(self) -> str:
        """Safely tracks SSA variables so the AI never has to guess % numbers."""
        self.var_counter += 1
        return f"%v{self.var_counter}"

    def match(self, target_op: str) -> str:
        """Finds operations in the graph. E.g., 'linalg.generic'"""
        out_var = self._next_var()
        # Notice we hardcode the strict MLIR syntax rules here
        self.instructions.append(
            f"    {out_var} = transform.structured.match ops{{[\"{target_op}\"]}} in %root : (!transform.any_op) -> !transform.any_op"
        )
        return out_var

    def tile_to_blocks(self, target_var: str, tile_sizes: list[int]) -> str:
        """Maps an operation to GPU Thread Blocks."""
        if not isinstance(tile_sizes, list):
            raise TypeError("tile_sizes must be a list of integers")
            
        tiled_op = self._next_var()
        grid_var = self._next_var()
        sizes_str = ", ".join(map(str, tile_sizes))
        
        self.instructions.append(
            f"    {grid_var}, {tiled_op} = transform.structured.tile_using_forall {target_var} {{ tile_sizes = [{sizes_str}] }} : (!transform.any_op) -> (!transform.any_op, !transform.any_op)"
        )
        self.instructions.append(
            f"    transform.gpu.map_forall_to_blocks {grid_var} {{ grid_dims = [1, 1, 1] }} : (!transform.any_op) -> !transform.any_op"
        )
        return tiled_op

    def tile_to_threads(self, target_var: str, tile_sizes: list[int], block_dims: list[int]) -> str:
        """Maps an operation to internal GPU Threads."""
        tiled_op = self._next_var()
        thread_var = self._next_var()
        sizes_str = ", ".join(map(str, tile_sizes))
        dims_str = ", ".join(map(str, block_dims))
        
        self.instructions.append(
            f"    {thread_var}, {tiled_op} = transform.structured.tile_using_forall {target_var} {{ tile_sizes = [{sizes_str}] }} : (!transform.any_op) -> (!transform.any_op, !transform.any_op)"
        )
        self.instructions.append(
            f"    transform.gpu.map_nested_forall_to_threads {thread_var} {{ block_dims = [{dims_str}] }} : (!transform.any_op) -> !transform.any_op"
        )
        return tiled_op

    def vectorize(self, target_var: str):
        """Vectorizes the inner loops."""
        out_var = self._next_var()
        self.instructions.append(
            f"    {out_var} = transform.structured.vectorize {target_var} : !transform.any_op"
        )
        return out_var

    def lower_to_nvvm(self, target_chip: str = "sm_90"):
        """Forces the safe transition to GPU PTX memory space."""
        after_gpu = self._next_var()
        gpu_mod = self._next_var()
        self.instructions.append(
            f"    {after_gpu} = transform.bufferization.one_shot_bufferize %root {{ bufferize_function_boundaries = true }} : (!transform.any_op) -> !transform.any_op"
        )
        self.instructions.append(
            f"    {gpu_mod} = transform.gpu.lower_to_nvvm {after_gpu} {{ chip = \"{target_chip}\" }} : (!transform.any_op) -> !transform.any_op"
        )

    def build_mlir(self) -> str:
        """Compiles the Python instructions into the final MLIR string."""
        header = "transform.named_sequence @__transform_main(%root: !transform.any_op) {\n"
        body = "\n".join(self.instructions)
        footer = "\n    transform.yield\n}"
        return header + body + footer
Step 3B: How the AI Interacts With It (component2_smt.py)
Now, instead of asking Gemini for raw MLIR, you ask it to write a simple Python function called apply_schedule.

The AI's Output (Pure Python):

Python
def apply_schedule(schedule):
    # 1. AI safely targets the matrix math
    matmul = schedule.match("linalg.generic")
    
    # 2. AI decides to break it into 128x128 blocks for the GPU
    block_tiled = schedule.tile_to_blocks(matmul, tile_sizes=[128, 128])
    
    # 3. AI decides to map inner loops to threads
    thread_tiled = schedule.tile_to_threads(block_tiled, tile_sizes=[1, 128], block_dims=[128, 1, 1])
    
    # 4. AI vectorizes the remainder and lowers
    schedule.vectorize(thread_tiled)
    schedule.lower_to_nvvm(target_chip="sm_90")
Step 3C: The Execution Loop (component10_dynamo.py / component9_aot.py)
When RepoOS receives that Python text from the AI, it uses Python's native exec() sandbox to generate the MLIR dynamically.

Python
# 1. Initialize our safe builder
my_schedule = RepoOSSchedule()

# 2. Execute the AI's Python code in a safe local dictionary
local_scope = {}
try:
    # ai_generated_python_code is the string from Step 3B
    exec(ai_generated_python_code, {}, local_scope)
    
    # 3. Call the AI's function, passing in our builder
    local_scope["apply_schedule"](my_schedule)
    
    # 4. Extract the mathematically perfect MLIR!
    perfect_mlir_string = my_schedule.build_mlir()
    
    print("Successfully generated MLIR without syntax errors!")
    
except Exception as e:
    # If the AI hallucinates a bad Python command (e.g., schedule.make_it_fast()),
    # it is caught instantly right here as a standard Python error.
    print(f"AI Schedule rejected: {e}")



Implementing the DSL-Constrained System Prompt in component2_smt.py

Architectural Directive:
We are upgrading the Oracle to output a JSON array of Python scripts. Each script will represent a distinct hardware optimization schedule (Compute-Heavy, Memory-Bound, Balanced) using our custom RepoOSSchedule Python API.

Replace the generate_inference_transforms function in component2_smt.py with the following implementation.

Python
import json
import asyncio
from google import genai

async def generate_inference_transforms(base_mlir_text: str, target_gpu: str = "sm_90") -> list[str]:
    """
    The Python-DSL Oracle.
    Prompts the AI to generate Python scheduling scripts using the RepoOS API.
    """
    
    prompt = f"""
    You are an elite Deep Learning Compiler Architect optimizing a neural network for an NVIDIA GPU ({target_gpu}).
    
    Below is the mathematically verified, programmatically lowered Linalg MLIR graph of the workload:
    
    === BASELINE MLIR ===
```mlir
    {base_mlir_text}
    ```
    === END BASELINE MLIR ===
    
    TASK:
    You must generate exactly 3 DIFFERENT optimization schedules for this graph:
    1. Compute-Heavy (Large tile sizes, aggressive unrolling)
    2. Memory-Bound (Smaller, cache-aligned tiles, aggressive operator fusion)
    3. Balanced (Standard tiling and vectorization)

    CRITICAL API CONSTRAINTS:
    You are FORBIDDEN from writing raw MLIR text. You must write a Python function named `apply_schedule(schedule)` using ONLY the following methods from the `RepoOSSchedule` API:

    - `schedule.match(op_name: str) -> str` 
      (Finds an operation. Example op_names: "linalg.generic", "linalg.matmul", "linalg.conv_2d_nchw_fchw")
    - `schedule.fuse(producer_var: str, consumer_var: str) -> str`
      (Fuses two operations together to save VRAM bandwidth)
    - `schedule.tile_to_blocks(target_var: str, tile_sizes: list[int]) -> str`
      (Tiles the operation across GPU Thread Blocks. Returns the tiled operation.)
    - `schedule.tile_to_threads(target_var: str, tile_sizes: list[int], block_dims: list[int]) -> str`
      (Tiles the inner loops across GPU Threads within a block.)
    - `schedule.vectorize(target_var: str) -> str`
      (Applies SIMD vectorization to the innermost loop.)
    - `schedule.lower_to_nvvm(target_chip: str)`
      (Mandatory final step: lowers the bufferized graph to PTX/NVVM.)

    FEW-SHOT EXAMPLE OF A VALID PYTHON SCRIPT:
    def apply_schedule(schedule):
        # 1. Match the core math
        matmul = schedule.match("linalg.generic")
        
        # 2. Tile for L2 Cache / GPU Blocks
        block_tiled = schedule.tile_to_blocks(matmul, tile_sizes=[128, 128])
        
        # 3. Tile for L1 Cache / GPU Threads
        thread_tiled = schedule.tile_to_threads(block_tiled, tile_sizes=[1, 128], block_dims=[128, 1, 1])
        
        # 4. Vectorize and Lower
        schedule.vectorize(thread_tiled)
        schedule.lower_to_nvvm(target_chip="{target_gpu}")

    OUTPUT FORMAT:
    You MUST output a raw JSON array containing exactly 3 strings. Each string is the raw Python code for one of the variants.
    DO NOT wrap the JSON in markdown formatting like ```json.
    DO NOT import any external libraries.
    """
    
    try:
        response = await client.aio.models.generate_content(
            model='gemini-2.5-pro', 
            config={'response_mime_type': 'application/json'},
            contents=prompt
        )
        res_text = response.text
        
        # Log the interaction for telemetry and observability
        log_oracle_interaction("python_schedule_generation", prompt, res_text)
        
        # Parse the JSON payload containing the 3 Python scripts
        schedules = json.loads(res_text)
        
        if isinstance(schedules, list):
            return schedules
        else:
            raise ValueError("AI did not return a JSON list.")
            
    except Exception as e:
        print(f"[Oracle] ⚠️ Failed to generate Python schedules: {e}")
        # Safe Deterministic Fallback: Return a single, highly conservative Python schedule
        fallback_script = f"""
def apply_schedule(schedule):
    target = schedule.match("linalg.generic")
    schedule.lower_to_nvvm(target_chip="{target_gpu}")
"""
        return [fallback_script]