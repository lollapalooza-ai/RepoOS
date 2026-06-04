import re
import asyncio
import os
import json
import time
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

def log_oracle_interaction(stage: str, prompt: str, response: str):
    """Logs the full prompt and response for debugging and transparency."""
    log_dir = "oracle_logs"
    os.makedirs(log_dir, exist_ok=True)
    timestamp = int(time.time() * 1000)
    log_file = os.path.join(log_dir, f"{stage}_{timestamp}.log")
    
    with open(log_file, "w") as f:
        f.write(f"--- STAGE: {stage} ---\n")
        f.write(f"--- PROMPT ---\n{prompt}\n")
        f.write(f"\n--- RESPONSE ---\n{response}\n")
    
    print(f"\n" + "="*80)
    print(f"DEBUG: AI ORACLE INTERACTION [{stage.upper()}]")
    print(f"LOG FILE: {log_file}")
    print("="*80)
    print(f"\n>>> FULL PROMPT SENT TO GEMINI:\n{prompt}")
    print(f"\n<<< FULL RESPONSE FROM GEMINI:\n{response}")
    print("="*80 + "\n")

async def generate_traceable_wrapper(python_code: str) -> str:
    """
    Uses Gemini to synthesize a torch.nn.Module wrapper for the provided Python logic.
    ENFORCES THE 'PURE CONSUMER MANDATE' for stable sparse math.
    """
    prompt = f"""
    You are an expert compiler engineer. Convert the following Python algorithm into a PyTorch `nn.Module` class named `GeneratedModule`.
    
    ### CRITICAL: THE PURE CONSUMER MANDATE (SPARSE MATH) ###
    - You are strictly a MATH CONSUMER. 
    - Do NOT attempt to construct, instantiate, or convert tensors inside the `forward` method. 
    - FATAL ERROR WARNING: Do NOT use `.new_sparse_csr_tensor()`, `.to_sparse()`, or any constructor inside `forward`.
    - ASSUME the `prep_inputs` data bridge has ALREADY converted the graph into a `torch.sparse_csr_tensor`.
    - Your `forward` method signature MUST simply accept the CSR tensor as an input argument (e.g., `adj_csr`).
    - You MUST use `torch.sparse.mm(adj_csr, vector)` to perform the math.
    
    EXAMPLE:
    ```python
    class GeneratedModule(torch.nn.Module):
        def forward(self, adj_csr: torch.Tensor, node_vals: torch.Tensor, out: torch.Tensor):
            out.copy_(torch.sparse.mm(adj_csr, node_vals))
            return out # MUST return the mutated buffer
    ```

    ### CRITICAL TRACER RULES (THE LOOP-FREE MANDATE) ###
    - FATAL ERROR WARNING: Do NOT use Python `for` loops or `while` loops inside the `forward` method.
    - FATAL ERROR WARNING: Do NOT use Python `if` statements or conditional branching that depends on tensor values.
    - The PyTorch tracer will CRASH if you attempt to iterate over tensor indices manually.
    - You MUST use 100% straight-line, vectorized tensor algebra.

    ### CRITICAL: DESTINATION-PASSING STYLE (DPS) ###
    The `forward` method MUST take a pre-allocated dense `out` Tensor as its final argument.
    You must write the final mathematical result into this buffer and return it.

    ### CRITICAL: KERNEL ISOLATION (PEEL & MATCH) ###
    Do NOT synthesize setup logic, masking, or graph-parsing.
    The kernel MUST contain ONLY the core mathematical hotspot.

    PYTHON LOGIC:
    ```python
    {python_code}
    ```
    
    STRICT RULES:
    1. Output ONLY the Python code for the class `GeneratedModule(torch.nn.Module)`.
    2. USE DATA-FLOW ONLY.
    3. NO DATA-DEPENDENT CONTROL FLOW.
    4. STRICT TENSOR SIGNATURE: `forward` must take ONLY standard `torch.Tensor` (dense or sparse) or scalars. 
    5. STATELESS MODULE: The `__init__` method MUST NOT take any arguments.
    """
    
    try:
        response = await client.aio.models.generate_content(model='gemini-2.5-pro', contents=prompt)
        res_text = response.text
        log_oracle_interaction("synthesis", prompt, res_text)
        match = re.search(r"```python\n(.*?)\n```", res_text, re.DOTALL)
        if match: return match.group(1)
        return res_text
    except Exception as e:
        print(f"[Oracle] Failed to synthesize traceable wrapper: {e}")
        return ""

async def generate_data_bridge(python_code: str, wrapper_code: str) -> dict:
    """
    Synthesizes the Prep and Post scripts to bridge high-level objects to the Tensor-Only ABI.
    """
    prompt = f"""
    You are a system architect. Create a 'Data Bridge' to connect a legacy Python function to a native CSR Sparse Kernel.
    
    ORIGINAL LOGIC:
    ```python
    {python_code}
    ```
    
    NATIVE KERNEL WRAPPER:
    ```python
    {wrapper_code}
    ```
    
    TASK:
    1. Write a `prep_inputs(*args, **kwargs)` function.
    2. CRITICAL: Every scalar (float/int) MUST be converted to a `torch.tensor()`.
    3. Return a list of tensors matching the `forward` signature.
    4. Include the dense `out` tensor as the FINAL element.
    5. Write a `post_process(tensor_output, *args, **kwargs)` function.
    
    STRICT RULES:
    1. Output ONLY a valid JSON object with keys "prep" and "post".
    2. Import any required libraries (torch, numpy, etc.) inside the functions.
    """
    
    try:
        response = await client.aio.models.generate_content(
            model='gemini-2.5-pro',
            config={'response_mime_type': 'application/json'},
            contents=prompt
        )
        res_text = response.text
        log_oracle_interaction("data_bridge", prompt, res_text)
        return json.loads(res_text)
    except Exception as e:
        print(f"[Oracle] Failed to generate data bridge: {e}")
        return {"prep": "def prep_inputs(*args, **kwargs): return args", "post": "def post_process(out, *args, **kwargs): return out"}

async def generate_sample_inputs(python_code: str, wrapper_code: str = "") -> str:
    """
    Generates sample torch Tensors for the Tensor-Only ABI.
    """
    prompt = f"""
    Provide sample inputs as a Python dictionary for this Torch Wrapper.
    
    REFERENCE WRAPPER:
    {wrapper_code}
    
    STRICT RULES:
    1. Output ONLY a Python dictionary string.
    2. EVERY entry MUST be a `torch.tensor()`. NO naked floats or ints.
    3. Provide raw `crow_indices`, `col_indices`, and `values` as dense 1D tensors.
    """
    
    try:
        response = await client.aio.models.generate_content(model='gemini-2.5-pro', contents=prompt)
        res_text = response.text
        log_oracle_interaction("sample_inputs", prompt, res_text)
        match = re.search(r"\{(.*?)\}", res_text, re.DOTALL)
        if match: return "{" + match.group(1) + "}"
        return res_text
    except Exception as e:
        print(f"[Oracle] Failed to generate sample inputs: {e}")
        return "{}"

async def generate_transform_script(base_mlir_text: str, target_arch: str = "ARM64 / Apple Silicon") -> str:
    """
    Acts as the Compiler Optimization Oracle. Generates a Transform Dialect script.
    """
    prompt = f"""
    You are an expert MLIR engineer. Write a Transform Dialect script for the following baseline MLIR.
    Focus on Cache tiling, unrolling, and NEON vectorization.
    
    BASELINE MLIR:
    ```mlir
    {base_mlir_text}
    ```
    
    CRITICAL SYNTAX RULES (PEDANTIC MLIR):
    - Do NOT use `op_name = `. 
    - You MUST include type signatures on the RIGHT side of the `match` operation.
    - FATAL ERROR: NEVER use explicit type labels on the LEFT side of an assignment.
    - Example GOOD: `%func = transform.structured.match ...`
    - FATAL ERROR WARNING: Do NOT use brackets without curly braces (e.g., `ops["func.func"]`). 
    - You MUST wrap the array in curly braces: `ops{{"["}} "linalg.generic" {{"]"}}`
    - FATAL ERROR WARNING: Do NOT use or match the `iterator_types` attribute.
    - FATAL ERROR WARNING: Do NOT use `transform.structured.fuse_into_containing_op`, `transform.structured.fuse`, or `single_result_user_of`.
    - TEMPORARY BAN: Do NOT use `transform.structured.tile_using_for`. Rely ONLY on vectorization and loop unrolling.
    
    # --- NEW VECTORIZE RULE ---
    - FATAL ERROR WARNING: `transform.structured.vectorize` MUST take a type annotation (the colon `:`) but NOT a return arrow (`->`).
    - EXACT CORRECT SYNTAX: `transform.structured.vectorize %0 : !transform.any_op`
    
    # TODO: Fix syntax volatility and re-enable the following:
    # - FATAL ERROR WARNING: `transform.structured.tile` is deprecated. 
    # - You MUST use `transform.structured.tile_using_for` for all tiling operations.
    # - TILING SYNTAX: You MUST provide sizes via attributes, e.g., `tile_sizes = [1, 8]`.
    # - LOOP HANDLES: Use `!transform.op<"scf.for">` instead of `!transform.any_op` when matching loops.
    
    - Use sequence name: `@__transform_main`.
    - Output ONLY the ```mlir block.
    """
    
    try:
        response = await client.aio.models.generate_content(model='gemini-2.5-pro', contents=prompt)
        res_text = response.text
        log_oracle_interaction("transform_schedule", prompt, res_text)
        match = re.search(r"```mlir\n(.*?)\n```", res_text, re.DOTALL)
        if match: return match.group(1)
        return res_text
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

async def fix_transform_syntax_with_ai(broken_script: str, compiler_error: str) -> str:
    """
    The Self-Healing Loop: Feeds compiler syntax errors back to Gemini for autonomous correction.
    """
    prompt = f"""
    You are an expert MLIR engineer. You wrote a Transform Dialect script, but the local MLIR parser rejected it with a syntax error.
    
    BROKEN SCRIPT:
    ```mlir
    {broken_script}
    ```
    
    COMPILER ERROR:
    {compiler_error}
    
    TASK:
    Analyze the compiler error and fix the syntax in the script. 
    Output ONLY the corrected ```mlir block. Do not include apologies or explanations.
    """
    
    try:
        print("[Oracle] Analyzing compiler error and attempting self-heal...")
        response = await client.aio.models.generate_content(model='gemini-2.5-pro', contents=prompt)
        res_text = response.text
        log_oracle_interaction("self_heal", prompt, res_text)
        match = re.search(r"```mlir\n(.*?)\n```", res_text, re.DOTALL)
        if match: return match.group(1)
        return res_text
    except Exception as e:
        print(f"[Oracle] Self-heal failed: {e}")
        return broken_script
