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
    # print(f"\n>>> FULL PROMPT SENT TO GEMINI:\n{prompt}")
    # print(f"\n<<< FULL RESPONSE FROM GEMINI:\n{response}")
    print("="*80 + "\n")

async def generate_fsm_transforms(python_code: str, domain_vars: str = "{}") -> str:
    """
    The FSM Optimization Oracle.
    Prompts the AI to generate specialized byte-parsing schedules using the DSL.
    """
    prompt = f"""
    You are an elite Systems Engineer building a high-performance C++ byte parser.
    
    PYTHON LOGIC TO REPLICATE:
    {python_code}
    
    DOMAIN VARIABLES EXTRACTED BY INGESTER:
    {domain_vars}
    
    TASK:
    You must generate exactly 3 DIFFERENT parsing strategies using the `RepoOSFSMBuilder`:
    1. Eager Scanning (Aggressively check for specific character sequences).
    2. Lazy Tokenization (Focus on structural boundaries like brackets).
    3. Balanced (A mix of character and sequence matching).

    CRITICAL API CONSTRAINTS:
    You are FORBIDDEN from writing raw C++. You must output a pure Python function named `build_parser(fsm)` using ONLY these API options:
    - `fsm.declare_bool(name: str)`
    - `fsm.declare_float(name: str)`
    - `fsm.add_state(name: str) -> str`
    - `fsm.on_char(state: str, char: str, next_state: str, action: str = "NONE", target: str = None)`
    - `fsm.on_sequence(state: str, sequence: str, next_state: str, action: str = "NONE", target: str = None)`
    - `fsm.set_object_complete_action(cpp_code: str)`
    - `fsm.set_return_variable(name: str)`
    
    ACTION TYPES:
    - "RECORD_BOOL": Parses a boolean after a sequence and stores it in `target`.
    - "RECORD_FLOAT": Parses a float after a sequence and stores it in `target`.
    - "COMPLETE_OBJECT": Executes the C++ code defined in `set_object_complete_action`. You MUST use this on the transition that marks the end of the top-level object (e.g., when transitioning on '}}' to return to the array).

    IMPORTANT CONSTRAINTS:
    - Keep the strategy simple, but DO NOT use a flat Eager scanning strategy! The JSON objects may contain nested structures (which you must infer from the provided Python code). If you stay in a single state, the inner `}}` will prematurely trigger the end of the root object!
    - You MUST create separate states for entering and exiting any necessary nested objects so you can safely transition back to the main state on `}}` without triggering `COMPLETE_OBJECT`.
    - Only trigger `action="COMPLETE_OBJECT"` on the `}}` that closes the outermost top-level object being aggregated.
    - DO NOT invent methods like `get_state`.
    - ALL states MUST be explicitly created using `fsm.add_state(name)`. Do not transition to undefined states.
    - Use `on_sequence` directly to match keys (e.g. `'"my_key"'`).
    - CRITICAL: When using `RECORD_BOOL` or `RECORD_FLOAT`, you MUST attach the action DIRECTLY to the `on_sequence` transition that matches the key. DO NOT create intermediate states to wait for the value characters (e.g. do not wait for 't' or 'f' to trigger `RECORD_BOOL`). The C++ engine handles value parsing automatically.

    FEW-SHOT EXAMPLE:
    def build_parser(fsm):
        fsm.declare_bool("is_vip")
        fsm.declare_float("total_value")
        fsm.declare_float("total_revenue")
        fsm.set_return_variable("total_revenue")
        
        init = fsm.add_state("init")
        in_obj = fsm.add_state("in_object")
        
        fsm.on_char(init, "{{", in_obj)
        fsm.on_sequence(in_obj, '"is_vip"', "extract_vip", action="RECORD_BOOL", target="is_vip")
        fsm.on_sequence(in_obj, '"total_value"', "extract_val", action="RECORD_FLOAT", target="total_value")
        
        # When the top-level object ends, trigger the action
        fsm.on_char(in_obj, "}}", init, action="COMPLETE_OBJECT")
        
        fsm.set_object_complete_action(\"""
        if (is_vip) {{
            total_revenue += total_value;
        }}
        is_vip = false;
        total_value = 0.0f;
        \""")

    OUTPUT FORMAT:
    You MUST output a single raw Python block enclosed in ```python ... ``` containing the `build_parser(fsm)` function. Do NOT output a JSON array. DO NOT output multiple strategies. Choose the BEST strategy and output it.
    """
    try:
        response = await client.aio.models.generate_content(
            model='gemini-2.5-flash',
            contents=prompt
        )
        res_text = response.text
        log_oracle_interaction("fsm_transform_synthesis", prompt, res_text)
        matches = re.findall(r"```python\n(.*?)\n```", res_text, re.DOTALL)
        if matches:
            for m in reversed(matches):
                if re.search(r"def\s+build_parser\s*\(", m):
                    return m
            return matches[-1]
        return res_text
    except Exception as e:
        print(f"[Oracle] Failed to generate FSM transforms: {e}")
        return "[]"

async def compile_function_logic(python_code: str, execution_track: str, domain_vars: str = "{}"):
    """The Call 1 Poly-Kernel Router"""
    
    if execution_track == "MATH":
        print("[Oracle] 🧮 Math Track: Generating PyTorch/DPS Module...")
        return await generate_traceable_wrapper(python_code)
        
    elif execution_track == "FSM":
        print("[Oracle] 🧵 FSM Track: Generating Structured FSM Builder Schedules...")
        return await generate_fsm_transforms(python_code, domain_vars)
        
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

async def generate_inference_transforms(base_mlir_text: str, target_device: str = "x86_64 Linux") -> list[str]:
    prompt = f"""
    You are an elite Systems Performance Engineer optimizing a dense tensor codebase for a modern CPU architecture ({target_device}).
    
    Below is the baseline, mathematically verified Linalg MLIR graph of the workload:
    
    === BASELINE MLIR ===
    ```mlir
    {base_mlir_text}
    ```
    === END BASELINE MLIR ===
    
    TASK:
    You must generate exactly 3 DIFFERENT optimization strategy scripts for this CPU target:
    1. L1 Cache Optimized (Aggressive deep tiling into very small blocks to fit entirely in L1, followed by vectorization).
    2. L2 Cache Optimized (Moderate tiling sizes, prioritizing continuous memory scans).
    3. SIMD-Optimized (Tile the innermost loops to a multiple of 4 or 8, then vectorize the resulting inner loops. NEVER vectorize untiled loops, as it will crash the compiler).

    CRITICAL API CONSTRAINTS:
    You must output a pure Python function named `apply_schedule(schedule)` using ONLY these API options:

    - `schedule.match(op_name: str) -> str` 
      (Finds a target operation handle).
    - `schedule.tile(target_var: str, tile_sizes: list[int]) -> str` 
      (Tiles the loop. CRITICAL: This returns a handle to the NEWLY TILED inner operations).
    - `schedule.tile_reduction(target_var: str, tile_sizes: list[int]) -> str`
      (Tiles a reduction operation like linalg.reduce using MapReduce partial sums logic. Returns a handle to the tiled loop).
    - `schedule.generalize(target_var: str) -> str`
      (Generalizes a Named Linalg Op like linalg.batch_matmul into a linalg.generic. MUST be called before tile_reduction on named ops).
    - `schedule.vectorize(target_var: str)` 
      (Forces SIMD vectorization. Apply this to the handle returned by schedule.tile).

    CRITICAL DYNAMIC SHAPE CONSTRAINTS:
    - The baseline MLIR graph contains SYMBOLIC DYNAMIC SHAPES (tensor<?x?xf32>).
    - When you call `schedule.tile()`, the compiler will automatically generate affine boundary checks (e.g., scf.if or affine.min) to handle uneven loop tails.
    - DO NOT attempt to mask or pad the data manually. Let the compiler handle the boundary geometry.
    - Prioritize cache-friendly tile sizes (e.g., 32, 64, 128) that divide cleanly into typical power-of-2 sequence lengths to minimize branch prediction penalties on the CPU.
    
    CRITICAL REDUCTION CONSTRAINTS:
    - Named Operations (like `linalg.batch_matmul`) MUST be generalized using `schedule.generalize()` before applying `schedule.tile_reduction()`.
    - DO NOT apply `schedule.tile_reduction()` to `linalg.generic` operations that have MULTIPLE outputs (such as the combined Max/Sum Softmax loop).

    FEW-SHOT EXAMPLE OF A VALID CPU STRATEGY SCRIPT:
    def apply_schedule(schedule):
        # 1. Isolate the mathematical hotspot
        math_ops = schedule.match("linalg.matmul")
        
        # 2. Tile to fit inside CPU Cache bounds
        # Save the returned handle to interact with the inner loops
        tiled_inner_ops = schedule.tile(math_ops, tile_sizes=[32, 32, 32])
        
        # 3. Vectorize the inner loops for AVX/NEON SIMD execution
        schedule.vectorize(tiled_inner_ops)

    OUTPUT FORMAT:
    You MUST output a raw JSON array containing exactly 3 strings. Each string is the raw Python code for one of the variants.
    DO NOT wrap the JSON in markdown code blocks like ```json.
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
            transform.structured.generalize %0 : !transform.any_op
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
    You are an expert MLIR engineer. You wrote a Python optimization script using the RepoOSSchedule API, but the generated MLIR was rejected by the compiler.
    
    BROKEN PYTHON SCRIPT:
    ```python
    {broken_script}
    ```
    
    COMPILER ERROR:
    {compiler_error}
    
    TASK:
    Analyze the compiler error and fix the python script. 
    
    STRICT RULES FOR FIXING:
    - You MUST output a pure Python function named `apply_schedule(schedule)`.
    - Use `schedule.generalize(target_var)` before tiling reductions on Named Linalg Ops (like `linalg.batch_matmul`).
    - DO NOT apply `schedule.tile_reduction` to ops with multiple outputs (e.g., Softmax `linalg.generic`).
    - Output ONLY the corrected ```python block. Do not include apologies or explanations.
    """
    
    try:
        print("[Oracle] Analyzing compiler error and attempting self-heal...")
        response = await client.aio.models.generate_content(model='gemini-2.5-pro', contents=prompt)
        res_text = response.text
        log_oracle_interaction("self_heal", prompt, res_text)
        match = re.search(r"```python\n(.*?)\n```", res_text, re.DOTALL)
        if match: return match.group(1)
        return res_text
    except Exception as e:
        print(f"[Oracle] Self-heal failed: {e}")
        return broken_script
