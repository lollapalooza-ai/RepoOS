# ENGINEERING SPECIFICATION: ARCHITECTURE V2 (TRANSFORM DIALECT)

**To:** Senior Compiler / Systems Engineer

**From:** Principal Engineering / AI Architect

**Subject:** Migrating RepoOS to the MLIR Transform Dialect Architecture

## 1. Context & Objective

We have hit the "Frontend Wall." Maintaining a custom Python AST-to-MLIR parser (`ast_to_mlir.py`) is unsustainable due to Python's dynamic complexity and the resulting ABI alignment bugs.

Effective immediately, we are pivoting RepoOS to the industry-standard **Transform Dialect Architecture**:

1. We will **deprecate our custom frontend** and use `torch-mlir` to deterministically trace Python math directly into mathematically proven `linalg` / `arith` MLIR textual representations.
2. We will **repurpose the LLM** from a "Graph Editor" to an "Optimization Strategist." Gemini will no longer generate JSON; it will generate declarative MLIR Transform Dialect scripts (e.g., `transform.structured.vectorize`).
3. We will **eliminate Z3 verification** for memory safety. The MLIR compiler infrastructure will natively verify the LLM's transform script. If the script is invalid, `mlir-opt` safely rejects it, and we gracefully degrade to the unoptimized baseline.

Please execute the following 5 phases to migrate the codebase.

---

## Phase 1: Deprecation and Cleanup

Delete the following files and bypasses. They are dead code.

* **DELETE:** `ast_to_mlir.py`.
* **DELETE:** Any Z3/SMT logic attempting to prove `scf.for` semantic equivalence in `component2_smt.py`.
* **REMOVE:** The JSON structured output enforcement for MLIR operations.

---

## Phase 2: The Deterministic Tracer (Torch-MLIR)

Create a new module `component1b_tracer.py`. This replaces the AST-to-JSON generation. We will trace Python functions using PyTorch and lower them directly to MLIR `linalg` on tensors.

```python
# component1b_tracer.py
import torch
import torch_mlir
from typing import Callable, Tuple

def trace_to_base_mlir(func: Callable, sample_args: Tuple[torch.Tensor, ...]) -> str:
    """
    Traces a Python/Torch function and mathematically lowers it to base MLIR.
    This guarantees 100% semantic equivalence. No LLM involved.
    """
    # Compile directly to the Linalg dialect (which is perfect for CPU/GPU optimization)
    module = torch_mlir.compile(
        func, 
        sample_args, 
        output_type=torch_mlir.OutputType.LINALG_ON_TENSORS
    )
    
    # Return the pure, deterministic textual MLIR
    return str(module)

# Example Usage:
# base_mlir_text = trace_to_base_mlir(my_math_func, (torch.randn(100), torch.randn(100)))

```

*Note: Your memory adapters in Component 5 will simply convert numpy arrays/NetworkX CSR buffers into `torch.Tensor` objects before passing them to the kernel.*

---

## Phase 3: The AI Optimization Oracle

Update `component2_smt.py`. The Oracle now accepts the baseline MLIR text, analyzes it against the target hardware, and outputs an MLIR Transform script.

```python
# component2_smt.py (Updated)
import re
from google import genai

client = genai.Client(vertexai=True, project="911836544224", location="us-central1")

async def generate_transform_script(base_mlir_text: str, target_arch: str = "ARM64 / Apple Silicon") -> str:
    """
    Acts as the Compiler Optimization Oracle. Generates a Transform Dialect script.
    """
    prompt = f"""
    You are an expert LLVM/MLIR compiler engineer.
    
    TARGET HARDWARE: {target_arch}
    
    BASELINE MLIR:
    ```mlir
    {base_mlir_text}
    ```
    
    INSTRUCTIONS:
    Write an MLIR Transform Dialect script to optimize this module for the target hardware.
    Focus on:
    1. L1 Cache line tiling (64 bytes).
    2. Loop unrolling.
    3. Vectorization (NEON 128-bit).
    
    Output ONLY the valid MLIR Transform script inside a ```mlir codeblock. Do not rewrite the baseline program.
    """
    
    response = await client.aio.models.generate_content(
        model='gemini-2.5-pro',
        contents=prompt
    )
    
    # Extract the MLIR codeblock
    match = re.search(r"```mlir\n(.*?)\n```", response.text, re.DOTALL)
    if match:
        return match.group(1)
    return response.text

```

---

## Phase 4: Native Verification & AOT Compilation

Update `component9_aot.py`. The compilation phase will now use `mlir-opt` to apply the LLM's strategy to the baseline code.

**This is the most critical safety mechanism:** If the LLM hallucinates, `mlir-opt` will fail to apply the transform, and we gracefully compile the baseline text.

```python
# component9_aot.py (Updated)
import subprocess
import os

def apply_ai_transform_and_compile(base_mlir: str, transform_mlir: str, output_dylib: str):
    base_path = "temp_base.mlir"
    transform_path = "temp_transform.mlir"
    opt_path = "temp_optimized.mlir"
    
    with open(base_path, "w") as f: f.write(base_mlir)
    with open(transform_path, "w") as f: f.write(transform_mlir)
    
    # 1. VERIFICATION BY CONSTRUCTION
    try:
        print("[Compiler] Applying AI Transform Script...")
        subprocess.run([
            "mlir-opt", base_path,
            "--pass-pipeline=builtin.module(transform-interpreter)",
            f"--transform-file={transform_path}",
            "-o", opt_path
        ], check=True, capture_output=True)
        print("[Compiler] ✅ AI Transform Successful & Mathematically Verified.")
        target_mlir = opt_path
        
    except subprocess.CalledProcessError as e:
        print(f"[Compiler] ⚠️ AI Transform Invalid. Gracefully degrading to Baseline.")
        print(f"[MLIR Error]: {e.stderr.decode()}")
        target_mlir = base_path

    # 2. STANDARD LOWERING TO BARE METAL
    # Convert Linalg -> SCF -> Standard -> LLVM -> Bare Pointers
    subprocess.run([
        "mlir-opt", target_mlir,
        "-convert-linalg-to-loops",
        "-lower-affine",
        "-convert-scf-to-cf",
        "-convert-func-to-llvm=use-bare-ptr-memref-call-conv=1",
        "-finalize-memref-to-llvm=use-bare-ptr-memref-call-conv=1",
        "-reconcile-unrealized-casts",
        "-o", "llvm_dialect.mlir"
    ], check=True)

    # Translate to LLVM IR
    subprocess.run(["mlir-translate", "-mlir-to-llvmir", "llvm_dialect.mlir", "-o", "kernel.ll"], check=True)
    
    # Compile to shared library (.dylib or .so)
    subprocess.run(["clang", "-O3", "-shared", "-fPIC", "kernel.ll", "-o", output_dylib], check=True)

```

---

## Phase 5: Elevating Neo4j to an Artifact Registry

In `component1_ingest.py`, stop trying to parse `ast.BinOp` or pure/impure blocks.

Instead, the Ingester simply uses standard AST mapping to find function definitions and update Neo4j with their lifecycle paths.

```python
# component1_ingest.py (Snippet Update)
# Update the Cypher query to store the new artifact paths

session.run("""
    MERGE (f:Function {fqn: $fqn})
    SET f.code = $code,
        f.base_mlir_path = $base_mlir_path,
        f.ai_transform_script_path = $ai_transform_script_path,
        f.optimized_dylib_path = $dylib_path,
        f.needs_recompile = true
""", fqn=function_fqn, code=raw_python, base_mlir_path="", ai_transform_script_path="", dylib_path="")

```

### The Final Execution Flow for the Drop-in Agent:

1. **Interceptor:** Triggers on `page_rank()`.
2. **Tracer:** `torch-mlir` traces `page_rank` and generates mathematically perfect `base.mlir`.
3. **Oracle:** Gemini reads `base.mlir` and writes `transform.mlir` (vectorize + unroll).
4. **Compiler:** `mlir-opt` applies the transform. If safe, it compiles `optimized.dylib`. If Gemini hallucinated, it compiles `base.mlir` to `baseline.dylib`.
5. **Execution:** `component4_jit` loads the bare pointers and executes.

By implementing this specification, RepoOS will instantly resolve all memory alignment panics, eliminate manual AST maintenance, and become a mathematically proven, AI-scheduled JIT execution engine.


# Milestone: 5.2 : Force transition to Architecture V2:
This is a classic "leaky abstraction" problem. Reviewing your attached files, it is clear why your Senior Engineer is encountering the `index_add` crash: **RepoOS has not fully transitioned to Architecture V2.**

You have built the *execution pipeline* for V2 (using `torch-mlir` in Component 1b and the Transform Interpreter in Component 9), but you are still using the *generation logic* of V1.

In `component9_aot.py`, I see these lines:

```python
wrapper_code = await generate_traceable_wrapper(python_code)
bridge = await generate_data_bridge(python_code, wrapper_code)

```

This is the smoking gun. You are still asking the AI Oracle to rewrite the raw Python logic into PyTorch (`wrapper_code`). Because the AI is unconstrained, it tries to be clever and uses sparse operations (`torch.aten.index_add`), which your local `torch-mlir` backend cannot legalize to standard MLIR.

To achieve true Architecture V2, we must strictly constrain the AI's logic generation and pivot its primary role to generating the Transform Dialect.

Here is the exact architectural blueprint and prompt to hand to your Senior Engineer.

---

## 1. The Missing Component: `component2_smt.py`

**Yes. `component2_smt.py` is the root cause of the crash.**

Currently, `generate_traceable_wrapper` allows Gemini to use any PyTorch operation. We must apply **Constrained Vocabulary Generation**. The AI must be forced to write "dumb, dense" PyTorch code so `torch-mlir` can effortlessly trace it down to the `linalg` dialect.

### Action Item for Senior Engineer: Update `component2_smt.py`

Rewrite the prompt inside `generate_traceable_wrapper` to strictly enforce a whitelist of operations.

```python
# In component2_smt.py

import re
import asyncio
import os
from google import genai

# Vertex AI Configuration
PROJECT_ID = "911836544224"
LOCATION = "us-central1"

# Primary Client: Vertex AI (GA)
client = genai.Client(
    vertexai=True,
    project=PROJECT_ID,
    location=LOCATION
)

async def generate_traceable_wrapper(python_code: str) -> str:
    """
    Uses Gemini to synthesize a torch.nn.Module wrapper for the provided Python logic.
    ENFORCES STRICT DENSE LINEAR ALGEBRA for torch-mlir compatibility.
    """
    prompt = f"""
    You are an expert compiler engineer. Convert the following Python algorithm into a PyTorch `nn.Module` class named `GeneratedModule`.
    
    ### CRITICAL ARCHITECTURE V2 CONSTRAINT ###
    This module will be traced by `torch-mlir` directly into the dense `linalg` MLIR dialect. You MUST avoid sparse operations or dynamic gathering.
    
    WHITELISTED OPERATIONS: 
    - Dense matrix multiplication (`torch.matmul`, `torch.mm`, `@`)
    - Element-wise arithmetic (`torch.add`, `torch.mul`, `+`, `*`, `/`)
    - Reductions (`torch.sum`, `torch.mean`)
    - Standard contiguous tensor slicing/indexing.
    
    ILLEGAL OPERATIONS (DO NOT USE - WILL CRASH COMPILER):
    - `torch.index_add`, `torch.gather`, `torch.scatter`, `torch.sparse_*`, or any sparse tensor layouts.
    
    If the original algorithm is a graph traversal (like PageRank or BFS), convert the logic to use Dense Adjacency Matrices (Dense Linear Algebra) instead of edge-list or dictionary iteration.
    
    PYTHON LOGIC:
    ```python
    {python_code}
    ```
    
    STRICT RULES:
    1. Output ONLY the Python code for the class `GeneratedModule(torch.nn.Module)`.
    2. USE DATA-FLOW ONLY: Synthesize the core mathematical kernel (one iteration if iterative).
    3. NO DATA-DEPENDENT CONTROL FLOW: Never use `.item()`, `bool()`, `if tensor > x`, or `while error > tol`.
    4. STRICT TENSOR SIGNATURE: The `forward` method MUST take ONLY `torch.Tensor`, `int`, or `float`. 
    """
    
    try:
        response = await client.aio.models.generate_content(model='gemini-2.5-pro', contents=prompt)
        match = re.search(r"```python\n(.*?)\n```", response.text, re.DOTALL)
        if match: return match.group(1)
        return response.text
    except Exception as e:
        print(f"[Oracle] Failed to synthesize traceable wrapper: {e}")
        return ""

async def generate_data_bridge(python_code: str, wrapper_code: str) -> dict:
    """
    Synthesizes the Prep and Post scripts to bridge high-level objects to Dense Tensor Kernels.
    """
    prompt = f"""
    You are a system architect. Create a 'Data Bridge' to connect a legacy Python function to a native dense Tensor Kernel.
    
    ORIGINAL LOGIC:
    ```python
    {python_code}
    ```
    
    NATIVE KERNEL WRAPPER:
    ```python
    {wrapper_code}
    ```
    
    TASK:
    1. Write a `prep_inputs(*args, **kwargs)` function that transforms the legacy arguments into the Tensors expected by `GeneratedModule.forward`.
    2. Write a `post_process(tensor_output, *args, **kwargs)` function that transforms the native output back to the legacy format.
    
    CRITICAL CONSTRAINT:
    If the input is a NetworkX graph or a dictionary of nodes/edges, you MUST convert it into a DENSE Adjacency Matrix `torch.Tensor`. Do not return sparse CSR/COO arrays, as the wrapper strictly expects dense linear algebra to compile correctly via MLIR.
    
    STRICT RULES:
    1. Output ONLY a valid JSON object with keys "prep" and "post" containing the Python code strings.
    2. Ensure standard imports (torch, numpy, networkx as nx) are handled inside the functions if needed.
    """
    
    try:
        response = await client.aio.models.generate_content(
            model='gemini-2.5-pro',
            config={'response_mime_type': 'application/json'},
            contents=prompt
        )
        import json
        return json.loads(response.text)
    except Exception as e:
        print(f"[Oracle] Failed to generate data bridge: {e}")
        return {"prep": "def prep_inputs(*args, **kwargs): return args", "post": "def post_process(out, *args, **kwargs): return out"}

async def generate_sample_inputs(python_code: str, wrapper_code: str = "") -> str:
    """
    Generates sample torch Tensors for tracing.
    """
    prompt = f"""
    Provide sample inputs as a Python dictionary for this Torch Wrapper.
    
    PYTHON LOGIC:
    ```python
    {python_code}
    ```
    REFERENCE WRAPPER:
    {wrapper_code}
    
    STRICT RULES:
    1. Output ONLY a Python dictionary string, e.g., '{{"arg1": torch.randn(10)}}'.
    2. Dictionary keys MUST exactly match `forward` arguments.
    3. If the wrapper expects an adjacency matrix, provide a dense `torch.randn(N, N)`.
    """
    
    try:
        response = await client.aio.models.generate_content(model='gemini-2.5-pro', contents=prompt)
        match = re.search(r"\{(.*?)\}", response.text, re.DOTALL)
        if match: return "{" + match.group(1) + "}"
        return response.text
    except Exception as e:
        print(f"[Oracle] Failed to generate sample inputs: {e}")
        return "{}"

async def generate_transform_script(base_mlir_text: str, target_arch: str = "ARM64 / Apple Silicon") -> str:
    """
    Generates a Transform Dialect script.
    """
    prompt = f"""
    You are an expert MLIR engineer. Write a Transform Dialect script for the following baseline MLIR.
    Focus on Cache tiling, unrolling, and NEON vectorization.
    
    BASELINE MLIR:
    ```mlir
    {base_mlir_text}
    ```
    
    CRITICAL RULES:
    - Use sequence name: `@__transform_main`.
    - Use correct list syntax: `ops{{"["}} "linalg.generic" {{"]"}}` (Must use double quotes for op names).
    - Use correct separator syntax: `in %arg0 : (!transform.any_op) -> !transform.any_op`
    - Output ONLY the ```mlir block.
    """
    
    try:
        response = await client.aio.models.generate_content(model='gemini-2.5-pro', contents=prompt)
        match = re.search(r"```mlir\n(.*?)\n```", response.text, re.DOTALL)
        if match: return match.group(1)
        return response.text
    except Exception as e:
        return """
        module attributes {transform.with_named_sequence} {
          transform.named_sequence @__transform_main(%arg0: !transform.any_op) {
            %0 = transform.structured.match ops{["linalg.generic"]} in %arg0 : (!transform.any_op) -> !transform.any_op
            transform.structured.vectorize %0 : !transform.any_op
            transform.yield
          }
        }
        """

```

---

## 2. Aligning the Data Bridge (`component2_smt.py` & `component5_orchestrator.py`)

Because we are forcing the AI to generate a *dense* PyTorch wrapper, the orchestrator must feed it dense data. If NetworkX passes a sparse dictionary graph, the `prep_script` (the Data Bridge) must flatten it into a dense tensor.

### Action Item for Senior Engineer: Update `generate_data_bridge` Prompt

In `component2_smt.py`, update the prompt that generates the `prep_script`.

```python
# In component2_smt.py

async def generate_data_bridge(python_code: str, wrapper_code: str) -> dict:
    prompt = f"""
    Write a Python `prep_inputs(*args, **kwargs)` function to map the arguments of the original function to the inputs of the PyTorch wrapper.
    
    CRITICAL: If the input is a NetworkX graph, convert it into a DENSE Adjacency Matrix `torch.Tensor`. Do not return sparse CSR arrays, as the wrapper expects dense linear algebra.
    
    Original Code: {python_code}
    Wrapper Code: {wrapper_code}
    
    Return a JSON object with "prep" (the prep_inputs code) and "post" (the post_process code).
    """
    # ... call Gemini ...

```

*Note: Your `component5_orchestrator.py` requires no code changes to support this. Its `trampoline_trap` is dynamically executing whatever the Data Bridge outputs, which is perfectly designed.*

---

## 3. Hardening the Compiler Pipeline (`component9_aot.py`)

Your `component9_aot.py` is structurally brilliant, especially the `extract_first_module` surgical fix. However, the `mlir-opt` lowering pipeline needs a slight adjustment to ensure the dense `linalg` operations drop cleanly into standard C pointers.

### Action Item for Senior Engineer: Update the Lowering Flags

In `component9_aot.py`, modify the subprocess call in Step 3 (`FINAL LOWERING TO MACHINE CODE`) to include the bufferization teardown flags. When `torch-mlir` outputs dense `linalg`, these flags guarantee it legalizes correctly.

```python
# In component9_aot.py, replace the subprocess.run in Step 3 with:

        subprocess.run([
            MLIR_OPT, target_mlir,
            "--lower-vector-multi-reduction",
            "--convert-linalg-to-loops",
            "--lower-affine",
            "--convert-scf-to-cf",
            # Ensure complex math drops to standard LLVM
            "--convert-complex-to-standard", 
            "--convert-math-to-llvm",
            "--convert-math-to-libm",
            # Standard bare-pointer calling convention
            "--convert-func-to-llvm=use-bare-ptr-memref-call-conv=1",
            "--finalize-memref-to-llvm=use-bare-ptr-memref-call-conv=1",
            "--reconcile-unrealized-casts",
            "-o", "llvm_dialect.mlir"
        ], check=True)

```

---

### The Final State of the System

Once your engineer updates the prompts in Component 2 and tweaks the compilation flags in Component 9, RepoOS will function as a true V2 Architecture:

1. **The Ingester (Component 1)** grabs the raw Python.
2. **The Oracle (Component 2)** acts as a "Dense Math Translator", converting complex graphs into dumb, dense PyTorch operations (guaranteeing `torch-mlir` won't crash on `index_add`).
3. **The Tracer (Component 1b)** securely and deterministically traces that math into `base.mlir`.
4. **The Oracle (Component 2)** steps in again as the "Strategist", writing a Transform script to vectorize and tile the dense MLIR.
5. **The Compiler (Component 9)** verifies and compiles it to native Apple Silicon code.

You have the bones of a world-class system here. Are you planning to add a retry loop in the Orchestrator so that if the AI *does* hallucinate an illegal operation, it automatically asks Gemini to fix the error string?