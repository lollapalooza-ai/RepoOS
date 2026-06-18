import re
import asyncio
import os
import json
import time
from google import genai

# Vertex AI Configuration
PROJECT_ID = "dotted-signer-491802-m7"
LOCATION = "us-central1"

# Session-wide timestamp for grouping logs
SESSION_TIMESTAMP = int(time.time() * 1000)

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
    log_file = os.path.join(log_dir, f"{stage}_{SESSION_TIMESTAMP}.log")
    
    with open(log_file, "a") as f:
        f.write(f"\n" + "="*80 + "\n")
        f.write(f"--- STAGE: {stage} ---\n")
        f.write(f"--- PROMPT ---\n{prompt}\n")
        f.write(f"\n--- RESPONSE ---\n{response}\n")
        f.write("="*80 + "\n")
    
    print(f"\n" + "="*80)
    print(f"DEBUG: AI ORACLE INTERACTION [{stage.upper()}]")
    print(f"LOG FILE: {log_file}")
    print("="*80)
    print(f"\n>>> FULL PROMPT SENT TO GEMINI:\n{prompt}")
    print(f"\n<<< FULL RESPONSE FROM GEMINI:\n{response}")
    print("="*80 + "\n")

async def generate_cpp_fsm(python_code: str) -> str:
    """
    Generates a high-performance C++ Finite State Machine or Byte Parser.
    """
    prompt = f"""
    Translate this Python string/byte manipulation logic into a high-performance C++ Finite State Machine or byte parser.
    Use switch statements, character-by-character scanning, and direct pointer manipulation for speed.
    
    RULES:
    1. Signature MUST be: `extern "C" void _mlir_ciface_main(const char* data, size_t len, float* out)`.
    2. Use `extern "C"` to prevent name mangling.
    3. No external dependencies (no std::string, no std::vector). Use raw pointers.
    4. Write the results directly into the `out` buffer.
    
    PYTHON LOGIC:
    {python_code}
    """
    try:
        response = await client.aio.models.generate_content(model='gemini-2.5-flash', contents=prompt)
        res_text = response.text
        log_oracle_interaction("fsm_synthesis", prompt, res_text)
        match = re.search(r"```cpp\n(.*?)\n```", res_text, re.DOTALL)
        if match: return match.group(1)
        return res_text
    except Exception as e:
        print(f"[Oracle] Failed to generate FSM: {e}")
        return ""

async def compile_function_logic(python_code: str, execution_track: str):
    """The Call 1 Poly-Kernel Router"""
    
    if execution_track == "MATH":
        print("[Oracle] 🧮 Math Track: Generating PyTorch/DPS Module...")
        return await generate_traceable_wrapper(python_code)
        
    elif execution_track == "FSM":
        print("[Oracle] 🧵 FSM Track: Generating C++ Byte Parser...")
        return await generate_cpp_fsm(python_code)
        
    elif execution_track == "TABULAR":
        print("[Oracle] 🗄️ Tabular Track: Generating C++ x86_64 Linux Engine...")
        prompt = f"""
        Translate this ORM logic into a Zero-Copy C++ Kernel optimized for x86_64 Linux.
        RULES:
        1. Input is a Struct-of-Arrays (e.g., `const float* col1`, `const float* col2`).
        2. Use clean, standard C++ loops. The compiler will auto-vectorize with -O3 -march=native. 
        3. Do NOT use hardware intrinsics (e.g. __m256) as they are error-prone in generation.
        4. Write directly to `float* out_buffer`.
        5. Use `extern "C" void _mlir_ciface_main(int64_t length, const float* col1, const float* col2, float* out_buffer)` signature.
        
        PYTHON LOGIC:
        {python_code}
        """
        try:
            response = await client.aio.models.generate_content(model='gemini-2.5-flash', contents=prompt)
            res_text = response.text
            log_oracle_interaction("tabular_synthesis", prompt, res_text)
            match = re.search(r"```cpp\n(.*?)\n```", res_text, re.DOTALL)
            return match.group(1) if match else res_text
        except Exception as e:
            print(f"[Oracle] Tabular synthesis failed: {e}")
            return ""
        
    elif execution_track == "BRANCHING":
        print("[Oracle] 🌳 Branching Track: Generating MLIR SCF Dialect...")
        prompt = f"""
        Translate this nested rule engine into MLIR Structured Control Flow (scf) and Control Flow (cf) dialects.
        RULES:
        1. Use `scf.if` and `scf.yield`.
        2. Do NOT use Python runtime dependencies.
        3. Aim for branch-optimized assembly.
        4. FATAL ERROR WARNING: You MUST enclose the entire code in a `module {{ ... }}` block.
        5. Every `scf.if` that returns a value MUST use the `-> (type)` syntax.
        6. OUTPUT AS JSON: You MUST output a single JSON object with a key "mlir" containing the raw MLIR string.
        
        PYTHON LOGIC:
        {python_code}
        """
        try:
            response = await client.aio.models.generate_content(
                model='gemini-2.5-flash', 
                config={'response_mime_type': 'application/json'},
                contents=prompt
            )
            res_text = response.text
            log_oracle_interaction("branching_synthesis", prompt, res_text)
            try:
                data = json.loads(res_text)
                return data.get("mlir", res_text)
            except json.JSONDecodeError:
                match = re.search(r"```mlir\n(.*?)\n```", res_text, re.DOTALL)
                return match.group(1) if match else res_text
        except Exception as e:
            print(f"[Oracle] Branching synthesis failed: {e}")
            return ""
        
    elif execution_track == "CRYPTO":
        print("[Oracle] 🔐 Crypto Track: Bypassing AI. Linking Native libsodium...")
        return "USE_NATIVE_LIBSODIUM"
        
    elif execution_track == "INFERENCE":
        print("[Oracle] 🧠 Inference Track: Acting as MLIR Tiling Strategist...")
        # Note: This is handled separately by generate_inference_transforms
        return "INFERENCE_TRACK_ACTIVE"

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
    1. Compute-Heavy (Aggressive unrolling)
    2. Memory-Bound (Cache-aligned tiles)
    3. Balanced (Standard tiling and vectorization)

    IMPORTANT PERFORMANCE GUIDELINES:
    - The problem size is often small (e.g. 10x10). Your tiles MUST be smaller than or equal to the workload.
    - `schedule.match("linalg.generic")` returns a handle to ALL matching operations. 
    - `schedule.vectorize(target)` only works if the tiled dimensions are a multiple of 4 or 8. Do NOT call vectorize on 1x1 or odd-sized tiles.

    CRITICAL API CONSTRAINTS:
    You are FORBIDDEN from writing raw MLIR text. You must write a Python function named `apply_schedule(schedule)` using ONLY the following methods from the `RepoOSSchedule` API:

    - `schedule.match(op_name: str) -> str` 
      (Finds an operation. Example op_names: "linalg.generic", "linalg.matmul", "linalg.conv_2d_nchw_fchw")
    - `schedule.tile_to_blocks(target_var: str, tile_sizes: list[int]) -> str`
      (Tiles the operation across GPU Thread Blocks. CRITICAL: This returns a handle to the NEWLY TILED inner operations.)
    - `schedule.tile_to_threads(target_var: str, tile_sizes: list[int], block_dims: list[int]) -> str`
      (Tiles the inner loops across GPU Threads within a block.)
    - `schedule.vectorize(target_var: str) -> str`
      (Applies SIMD vectorization to the innermost loop.)

    FEW-SHOT EXAMPLE OF A VALID PYTHON SCRIPT:
    def apply_schedule(schedule):
        # 1. Match all math ops
        math_ops = schedule.match("linalg.generic")
        
        # 2. Tile for GPU Blocks. 
        # Save the returned handle! It points directly to the inner loops.
        block_tiled_ops = schedule.tile_to_blocks(math_ops, tile_sizes=[8, 8])
        
        # 3. Pass the returned handle directly to thread tiling. 
        # DO NOT call schedule.match() again!
        thread_tiled_ops = schedule.tile_to_threads(block_tiled_ops, tile_sizes=[1, 1], block_dims=[8, 8])

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
        fallback_script = """
def apply_schedule(schedule):
    target = schedule.match("linalg.generic")
"""
        return [fallback_script]

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
            # MANDATORY: Use torch.add with out=out for final buffer write.
            # This is more stable for the MLIR tracer than .copy_()
            res = torch.sparse.mm(adj_csr, node_vals)
            torch.add(res, 0.15, out=out)
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
    6. NO CONVERSATION OR COMMENTS: Output ONLY the code block starting with ```python.
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
    2. FATAL ERROR WARNING: Do NOT return a list of dictionaries or multiple test cases. You MUST return exactly ONE flat dictionary representing ONE execution frame.
    3. EVERY entry MUST be a `torch.tensor()` or `torch.sparse_csr_tensor()`. NO naked floats or ints.
    4. The dictionary keys and values MUST match the `forward` method's argument names and types EXACTLY.
    5. NO CONVERSATION: Do NOT include preamble, explanation, or code block markers.
    """
    
    try:
        response = await client.aio.models.generate_content(model='gemini-2.5-pro', contents=prompt)
        res_text = response.text
        log_oracle_interaction("sample_inputs", prompt, res_text)
        
        # Balanced Brace Extraction
        start_idx = res_text.find('{')
        if start_idx == -1: return "{}"
        
        brace_count = 0
        for i in range(start_idx, len(res_text)):
            if res_text[i] == '{': brace_count += 1
            elif res_text[i] == '}': brace_count -= 1
            
            if brace_count == 0:
                return res_text[start_idx : i+1]
                
        return "{}"
    except Exception as e:
        print(f"[Oracle] Failed to generate sample inputs: {e}")
        return "{}"

async def generate_transform_script(base_mlir_text: str, target_arch: str = "x86_64 Linux") -> str:
    """
    Acts as the Compiler Optimization Oracle. Generates a Transform Dialect script.
    """
    prompt = f"""
    You are an expert MLIR engineer. Write a Transform Dialect script for the following baseline MLIR.
    Focus on Cache tiling, unrolling, and AVX vectorization for x86_64 Linux.
    
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
    
    STRICT RULES FOR FIXING:
    - Every `transform.structured.match` MUST end with a functional type signature: `: (!transform.any_op) -> !transform.any_op`
    - NEVER use explicit type labels on the LEFT side of an assignment (e.g., `%op: !type = ...` is BANNED).
    - You MUST enclose array attributes in curly braces, e.g., `ops{["linalg.generic"]}`.
    - Output ONLY the corrected ```mlir block. Do not include apologies or explanations.
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
