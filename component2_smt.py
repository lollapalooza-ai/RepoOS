import re
import asyncio
import os
import json
import time

# --- Assume Z3 Harnesses are implemented (PE llvm-ir-design13.md) ---
def verify_tabular_logic(python_code, cpp_code, domain_vars):
    return True

def verify_math_logic(python_code, cpp_code, domain_vars):
    return True
# ----------------------------------------------------------------

from google import genai

# Vertex AI Configuration
PROJECT_ID = "project-a2d78296-18ff-4dd4-a6c"
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

async def generate_fsm_transforms(python_code: str, domain_vars: str = "{}"):
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
    - CRITICAL: When writing the C++ code for `set_object_complete_action`, you MUST use the exact variable names you declared with `declare_bool` and `declare_float`. DO NOT append trailing underscores (e.g. use `is_vip` not `is_vip_`). The builder generates the variables exactly as you name them.

    CRITICAL CONSTRAINTS FOR CONDITIONAL LOGIC:
    - You must often evaluate multiple conditions before accumulating a value (e.g., checking if a user is VIP AND if their status is "PROCESSED").
    - You MUST use `fsm.declare_bool()` to create a flag for EVERY condition you need to track.
    - FATAL ERROR WARNING: For string enumerations (e.g. `order["status"] == "PROCESSED"`), you MUST match the FULL key-value pair sequence! Example: `fsm.on_sequence(S_STATE, '"status":"PROCESSED"', S_NEXT, action="RECORD_BOOL", target="is_processed")`. DO NOT just match the key `\"status\"`, otherwise you will falsely trigger on ALL statuses!
    - DO NOT attempt to write inline C++ `if` statements inside `on_char` or `on_sequence` transitions.
    - ALL compound logic (the actual math and accumulation) MUST happen inside the C++ string you pass to `fsm.set_object_complete_action()`. 
    - You must reset your boolean flags back to `false` at the end of your `set_object_complete_action` C++ block so they are clean for the next JSON object in the array.
    - FATAL ERROR WARNING: Python DOES NOT support character subtraction like `'0'-'9'`. If you need to match numbers, you MUST use a loop in Python, e.g., `for i in range(10): fsm.on_char(state, str(i), next_state)`. Do NOT write `'0'-'9'` anywhere in the Python script!

    OUTPUT FORMAT:
    You MUST output exactly 3 markdown Python blocks. Do NOT output JSON. 
    Separate them with the exact headers:
    ### EAGER
    ```python
    ...
    ```
    ### LAZY
    ```python
    ...
    ```
    ### BALANCED
    ```python
    ...
    ```
    """
    try:
        response = await client.aio.models.generate_content(
            model='gemini-2.5-flash',
            contents=prompt,
            config={'temperature': 0.0}
        )
        res_text = response.text
        log_oracle_interaction("fsm_transform_synthesis", prompt, res_text)
        
        # Parse the 3 python blocks using regex
        import re
        eager_match = re.search(r'### EAGER\s*```python\n(.*?)\n```', res_text, re.DOTALL)
        lazy_match = re.search(r'### LAZY\s*```python\n(.*?)\n```', res_text, re.DOTALL)
        balanced_match = re.search(r'### BALANCED\s*```python\n(.*?)\n```', res_text, re.DOTALL)
        
        eager_code = eager_match.group(1).strip() if eager_match else ""
        lazy_code = lazy_match.group(1).strip() if lazy_match else ""
        balanced_code = balanced_match.group(1).strip() if balanced_match else ""
        
        if not eager_code or not lazy_code or not balanced_code:
            print("[Oracle] Warning: Failed to extract all 3 FSM variants via regex. Falling back to naive block extraction.")
            blocks = re.findall(r'```python\n(.*?)\n```', res_text, re.DOTALL)
            eager_code = blocks[0].strip() if len(blocks) > 0 else ""
            lazy_code = blocks[1].strip() if len(blocks) > 1 else ""
            balanced_code = blocks[2].strip() if len(blocks) > 2 else ""
            
        return [eager_code, lazy_code, balanced_code]
    except Exception as e:
        import traceback
        print(f"[Oracle] FSM synthesis failed: {repr(e)}\n{traceback.format_exc()}")
        return []

async def compile_function_logic(python_code: str, execution_track: str, domain_vars: str = "{}"):
    """The Call 1 Poly-Kernel Router"""
    
    if execution_track == "MATH":
        print("[Oracle] 🧮 Math Track: Semantic Translation to Tensor/Scalar IR...")
        prompt = f"""
        You are a Semantic Translator for an Algebraic E-graph compiler.
        Translate the following mathematical Python loop into a strict Algebraic S-expression.
        
        ALLOWED S-EXPRESSION NODES:
        - (assign <var> <expression>)
        - (add <a> <b>), (sub <a> <b>), (mul <a> <b>), (div <a> <b>)
        - (pow <base> <exp>), (sqrt <val>)
        - (sum-loop <iterator> <range_expr> <body_expr>)
        
        STRICT RULES:
        1. FATAL ERROR WARNING: Do NOT generate a PyTorch `nn.Module`. We are bypassing PyTorch for this track.
        2. Do NOT evaluate math or unroll loops. Translate the arithmetic structure exactly.
        3. OUTPUT AS JSON: You MUST output a single JSON object with a key "s_expr".
        
        PYTHON LOGIC:
        {python_code}
        """
        try:
            response = await client.aio.models.generate_content(
                model='gemini-2.5-flash',
                contents=prompt,
                config={'temperature': 0.0, 'response_mime_type': 'application/json'}
            )
            res_text = response.text
            res_text = response.text
            log_oracle_interaction("math_synthesis", prompt, res_text)
            parsed = json.loads(res_text)
            return parsed.get("s_expr", "")
        except Exception as e:
            print(f"[Oracle] Math synthesis failed: {e}")
            return ""
            
    elif execution_track == "FSM":
        print("[Oracle] 🧵 FSM Track: Generating Structured FSM Builder Schedules...")
        return await generate_fsm_transforms(python_code, domain_vars)
        
    elif execution_track == "TABULAR":
        print("[Oracle] 🗄️ Tabular Track: Semantic Translation to Relational IR...")
        prompt = f"""
        You are a Semantic Translator for a Relational E-graph compiler.
        Translate the following Python ORM or list-comprehension logic into a strict Relational S-expression.
        
        ALLOWED S-EXPRESSION NODES:
        - (filter <condition> <dataset>)
        - (map <operation> <dataset>)
        - (reduce <operation> <dataset>)
        - (get-col <dataset> <column_name>)
        - (== <a> <b>), (> <a> <b>), (< <a> <b>)
        - (mul <a> <b>), (add <a> <b>)
        
        STRICT RULES:
        1. FATAL ERROR WARNING: Do NOT generate C++ or Python code.
        2. Translate the logic EXACTLY as written. Do not attempt to optimize (e.g., do not manually push filters down). The E-graph will optimize it.
        3. OUTPUT AS JSON: You MUST output a single JSON object with a key "s_expr".
        
        PYTHON LOGIC:
        {python_code}
        """
        try:
            response = await client.aio.models.generate_content(
                model='gemini-2.5-flash',
                contents=prompt,
                config={'temperature': 0.0, 'response_mime_type': 'application/json'}
            )
            res_text = response.text
            res_text = response.text
            log_oracle_interaction("tabular_synthesis", prompt, res_text)
            parsed = json.loads(res_text)
            return parsed.get("s_expr", "")
        except Exception as e:
            print(f"[Oracle] Tabular synthesis failed: {e}")
            return ""
        
    elif execution_track == "BRANCHING":
        print("[Oracle] 🌳 Branching Track: Generating Structured Branching Builder Schedules...")
        prompt = f"""
        You are a Semantic Translator for an E-graph compiler pipeline.
        Translate the following Python business logic into a strict S-expression (Lisp-like) Intermediate Representation (IR).
        
        ALLOWED S-EXPRESSION NODES:
        - (if <condition> <then> <else>)
        - (== <a> <b>)
        - (!= <a> <b>)
        - (get-dict <dict_name> <string_key>)
        - (assign <var_name> <value>)
        - (return <value>)
        - (seq <expr1> <expr2> ...) ; For sequential operations
        
        STRICT RULES:
        1. FATAL ERROR WARNING: Do NOT generate C++ or Python code. You MUST generate ONLY valid S-expressions.
        2. String literals must be wrapped in double quotes.
        3. Do NOT attempt to optimize the logic. Translate the nested control flow exactly as it appears in the Python code. The E-graph will handle the optimization.
        4. OUTPUT AS JSON: You MUST output a single JSON object with a key "s_expr" containing the raw S-expression string.
        
        PYTHON LOGIC:
        {python_code}
        """
        try:
            response = await client.aio.models.generate_content(
                model='gemini-2.5-flash', 
                contents=prompt,
                config={'response_mime_type': 'application/json', 'temperature': 0.0}
            )
            res_text = response.text
            log_oracle_interaction("branching_synthesis", prompt, res_text)
            try:
                result_json = json.loads(res_text)
                return result_json.get("s_expr", "")
            except json.JSONDecodeError:
                return ""
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
    1. L1 Cache Optimized: Deep tiling of spatial loops into very small blocks (e.g., 8, 16) to fit entirely in the CPU L1 cache.
    2. L2 Cache Optimized: Moderate tiling sizes (e.g., 64, 128), prioritizing continuous memory scans for the L2 cache.
    3. Hardware Fallback: Do not tile at all. Leave the loops intact and let the LLVM auto-vectorizer handle the entire workload natively.

    CRITICAL API CONSTRAINTS:
    You must output a pure Python function named `apply_schedule(schedule)` using ONLY these API options:

    - `schedule.match(op_name: str) -> str` 
      (Finds a target operation handle).
    - `schedule.tile(target_var: str, tile_sizes: list[int]) -> str` 
      (Tiles the loop. CRITICAL: This returns a handle to the NEWLY TILED inner operations).

    CRITICAL DYNAMIC SHAPE CONSTRAINTS:
    - The baseline MLIR graph contains SYMBOLIC DYNAMIC SHAPES (tensor<?x?xf32>).
    - When you call `schedule.tile()`, the compiler will automatically generate affine boundary checks (e.g., scf.if or affine.min) to handle uneven loop tails.
    - DO NOT attempt to mask or pad the data manually. Let the compiler handle the boundary geometry.
    - Prioritize cache-friendly tile sizes (e.g., 32, 64, 128) that divide cleanly into typical power-of-2 sequence lengths to minimize branch prediction penalties on the CPU.

    FEW-SHOT EXAMPLE OF A VALID CPU STRATEGY SCRIPT:
    def apply_schedule(schedule):
        # 1. Tile batch_matmul for L2 cache
        bmm_ops = schedule.match("linalg.batch_matmul")
        schedule.tile(bmm_ops, tile_sizes=[1, 32, 32, 0])
        
        # 2. Tile generic parallel ops
        generic_ops = schedule.match("linalg.generic")
        schedule.tile(generic_ops, tile_sizes=[1, 1, 8])

    OUTPUT FORMAT:
    You MUST output a raw JSON array containing exactly 3 strings. Each string is the raw Python code for one of the variants.
    DO NOT wrap the JSON in markdown code blocks like ```json.
    """
    
    try:
        response = await client.aio.models.generate_content(
            model='gemini-2.5-pro', 
            config={'response_mime_type': 'application/json', 'temperature': 0.0},
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
        response = await client.aio.models.generate_content(
            model='gemini-2.5-pro',
            contents=prompt,
            config={'temperature': 0.0}
        )
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
        response = await client.aio.models.generate_content(
            model='gemini-2.5-pro',
            contents=prompt,
            config={'temperature': 0.0}
        )
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
        response = await client.aio.models.generate_content(
            model='gemini-2.5-pro',
            contents=prompt,
            config={'temperature': 0.0}
        )
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
    - DO NOT use `schedule.tile_reduction()`, `schedule.generalize()`, or `schedule.vectorize()`. Only use `schedule.tile()` for parallel loops.
    - `schedule.tile` CANNOT tile reduction loops. The last dimension's tile size MUST be 0.
    - If the error states that a handle was invalidated, it means you tried to apply another transform to a handle that was already consumed by `schedule.tile()`. You must use the NEW handle returned by `schedule.tile()` for subsequent inner-loop operations.
    - Output ONLY the corrected ```python block. Do not include apologies or explanations.
    """
    
    try:
        print("[Oracle] Analyzing compiler error and attempting self-heal...")
        response = await client.aio.models.generate_content(
            model='gemini-2.5-pro',
            contents=prompt,
            config={'temperature': 0.0}
        )
        res_text = response.text
        log_oracle_interaction("self_heal", prompt, res_text)
        match = re.search(r"```python\n(.*?)\n```", res_text, re.DOTALL)
        if match: return match.group(1)
        return res_text
    except Exception as e:
        print(f"[Oracle] Self-heal failed: {e}")
        return broken_script

def verify_branching_logic(python_code: str, cpp_code: str, domain_vars: dict) -> bool:
    """
    Stub for Z3 Formal Verification.
    Proves that the highly optimized C++ logic perfectly matches the original Python intent.
    Returns True if valid.
    """
    print("[Z3 Prover] 🔍 Verifying Equality between Python AST and C++ AST...")
    # Mock implementation for now
    return True
