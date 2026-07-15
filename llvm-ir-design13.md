For the TABULAR and MATH tracks, moving away from free-text C++ and PyTorch wrappers to a strict S-Expression → E-Graph → Verifier pipeline will massively reduce hallucinations and compilation latency.

Here is the exact engineering blueprint and code for your team to standardize this architecture across both tracks.

Part 1: The Semantic Translators (Update component2_smt.py)
We must update the Oracle prompts for both tracks to stop generating raw C++ or PyTorch nn.Module wrappers. Instead, they will act strictly as syntax translators, outputting rigid S-expressions.

Action: Replace the TABULAR and MATH prompt blocks in component2_smt.py with these configurations:

Python
# --- UPDATE IN: component2_smt.py -> compile_function_logic ---

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
        # ... standard Vertex AI JSON extraction ...

    elif execution_track == "MATH":
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
        # ... standard Vertex AI JSON extraction ...
Part 2: Equality Saturation (Update component11_egraph.py)
We need to instantiate the E-graph rulesets for Relational Algebra (Tabular) and Scalar/Tensor Math (Math).

Action: Add these optimizers to your E-graph module.

Python
# --- ADD TO: component11_egraph.py ---
import repoos_egg_bindings as egg

def optimize_tabular_ir(s_expr_ir: str) -> str:
    """
    Applies Relational Algebra optimizations (like Filter Pushdown) to Tabular data.
    """
    print("[E-Graph] 🗄️ Optimizing Tabular IR...")
    rewrite_rules = [
        # Filter Pushdown: Map(Filter(x)) is faster than Filter(Map(x))
        egg.Rewrite(
            name="filter-pushdown",
            searcher="(filter ?cond (map ?op ?data))",
            applier="(map ?op (filter ?cond ?data))"
        ),
        # Column Pruning: Only fetch columns actually used in the map/filter
        egg.Rewrite(
            name="column-pruning-fusion",
            searcher="(map ?op (get-col ?data ?col1) (get-col ?data ?col2))",
            applier="(map-cols ?op ?data ?col1 ?col2)" 
        )
    ]
    runner = egg.Runner(rewrite_rules)
    best_cost, optimized_s_expr = egg.Extractor(runner.run(s_expr_ir), cost_function="memory_reads").extract()
    return optimized_s_expr


def optimize_math_ir(s_expr_ir: str) -> str:
    """
    Applies Algebraic optimizations and loop vectorization rules to pure Math logic.
    """
    print("[E-Graph] 🧮 Optimizing Math IR...")
    rewrite_rules = [
        # Algebraic Simplification (e.g., x * 2 -> x << 1)
        egg.Rewrite(
            name="mul-by-two-is-shift",
            searcher="(mul ?a 2)",
            applier="(bit-shift-left ?a 1)"
        ),
        # Fused Multiply-Add (FMA) recognition for CPU intrinsics
        egg.Rewrite(
            name="fuse-multiply-add",
            searcher="(add (mul ?a ?b) ?c)",
            applier="(fma ?a ?b ?c)"
        )
    ]
    runner = egg.Runner(rewrite_rules)
    best_cost, optimized_s_expr = egg.Extractor(runner.run(s_expr_ir), cost_function="cpu_cycles").extract()
    return optimized_s_expr
Part 3: The Verification Pipeline (Update component9_aot.py)
Now we wire the E-graph output back into the builders, execute the Z3 safety checks, and compile. Note that for the TABULAR track, we generate a highly localized Struct-of-Arrays (SoA) C++ kernel.

Action: Update the pipeline logic in component9_aot.py for both tracks.

Python
# --- UPDATE IN: component9_aot.py -> aot_compile_all ---
from component11_egraph import optimize_tabular_ir, optimize_math_ir
from component2_smt import verify_tabular_logic, verify_math_logic # (Assume Z3 harnesses are implemented)

                # Inside the compilation loop for track == "TABULAR"
                elif track == "TABULAR":
                    llm_s_expr = synthesis_result
                    
                    # 1. E-Graph Optimization (Relational Algebra)
                    optimized_s_expr = optimize_tabular_ir(llm_s_expr)
                    
                    # 2. Builder Lowering
                    builder = RepoOSTabularBuilder()
                    lower_sexpr_to_tabular_builder(optimized_s_expr, builder)
                    cpp_code = builder.build_cpp()
                    
                    # 3. Z3 Formal Verification
                    if not verify_tabular_logic(python_code, cpp_code, domain_vars_json):
                        print("[Compiler] ❌ Z3 Tabular Verification Failed. Discarding compilation.")
                        continue
                        
                    cpp_source_path = os.path.join(CACHE_DIR, f"{target_fqn.replace('.', '_')}.cpp")
                    with open(cpp_source_path, "w") as f: f.write(cpp_code)
                    subprocess.run(["clang++", "-O3", "-shared", "-fPIC", "-march=native", cpp_source_path, "-o", output_dylib], check=True)

                # Inside the compilation loop for track == "MATH"
                elif track == "MATH":
                    llm_s_expr = synthesis_result
                    
                    # 1. E-Graph Optimization (Algebraic)
                    optimized_s_expr = optimize_math_ir(llm_s_expr)
                    
                    # 2. Builder Lowering
                    builder = RepoOSMathBuilder()
                    lower_sexpr_to_math_builder(optimized_s_expr, builder)
                    cpp_code = builder.build_cpp() # Emits pure AVX/SIMD C++
                    
                    # 3. Z3 Formal Verification
                    if not verify_math_logic(python_code, cpp_code, domain_vars_json):
                        print("[Compiler] ❌ Z3 Math Verification Failed. Discarding compilation.")
                        continue
                        
                    cpp_source_path = os.path.join(CACHE_DIR, f"{target_fqn.replace('.', '_')}.cpp")
                    with open(cpp_source_path, "w") as f: f.write(cpp_code)
                    subprocess.run(["clang++", "-O3", "-shared", "-fPIC", "-march=native", cpp_source_path, "-o", output_dylib], check=True)
By transitioning the MATH track away from PyTorch and into this pipeline, we eliminate the overhead of tracing and dynamic graphs for simple scalar math, achieving much closer alignment with bare-metal C++ generation.


## Milestone 2 - The five fixes
1. The Implementation Blueprint: Data-Dependency Tracing
When component1_ingest.py finds a pure computational loop (like your run_bench inner loop) and extracts it into a synthetic function (e.g., __repoos_synthetic_fsm_001), it must perform a Data-Dependency Trace.

Identify Free Variables: As tree_sitter walks the isolated block, it must identify any variable that is read but not assigned within that block (in your case, raw_bytes and json).

Parameterize the Synthetic Kernel: The Chunker automatically defines the new synthetic function to require those free variables as parameters:

Python
# What the Chunker silently generates in memory:
def __repoos_synthetic_fsm_001(raw_bytes): 
    ...
Rewrite the Call Site: The Chunker then rewrites the original run_bench AST to explicitly pass the global variable into our synthetic kernel:

Python
# What the user wrote:
def run_bench():
    data = json.loads(raw_bytes.decode('utf-8')) # Relies on global
    ...

# What the Chunker executes in memory:
def run_bench():
    __repoos_synthetic_fsm_001 = globals().get('__repoos_synthetic_fsm_001')
    return __repoos_synthetic_fsm_001(raw_bytes) # Explicit passing!
The Architectural Win
Because the rewrite happens completely in memory during the component1_ingest.py ingestion phase, the developer never sees it. Their legacy job.py file remains perfectly intact on their hard drive, preserving our "No-Rewrite" economic wedge. Meanwhile, the component5_orchestrator.py receives a perfectly normalized function where args[0] is guaranteed to be the payload, preventing the ABI crash entirely.

2. Fixing the Silent Fallback (Observability vs. Reliability)
The Orchestrator did exactly what it was designed to do in production: it caught a fatal crash and smoothly fell back to native Python to keep the application alive. But in a benchmarking/CI environment, silent fallbacks are toxic.

The Architectural Fix:
We need to introduce a strict REPOOS_ENV environment variable.

In PROD, it behaves exactly as it did: silent fallback, log a warning, keep the server alive.

In DEV or BENCHMARK mode, it must instantly raise a RepoOSCompilationError or RepoOSRuntimeError. We need it to fail loudly so we aren't chasing ghosts.

3. Fixing the Telemetry Collector (PID Traversal)
Tracking the memory of a lightweight bash wrapper is a classic infrastructure trap.

The Architectural Fix:
The benchmark collector cannot simply monitor the PID of the command it launched. It must use a library like psutil to traverse the process tree. It needs to find the leaf node (the actual python3 process doing the CPU work) and aggregate the memory and CPU utilization of the entire process tree, ignoring the shell wrappers.

4. Fixing the Arena Race (Your Suggestion)

  You hit the nail on the head. The current  FSM  Arena Race only measures execution speed:

          🏁 Starting FSM Arena Race for 3 variants...
            🏎️  Racing Variant 0... Time: 4.80ms
            🏎️  Racing Variant 1... Time: 2.28ms

  It never actually checks if the variant computes the right answer! We must upgrade the Arena mechanism to:

  a Extract the AST of the target Python function.
  b Use  exec()  to dynamically run the Native Python function on a small piece of generated dummy data to get a "Golden Result".
  c Compile the C++ variants and run them against the same dummy data.
  d Discard any variant whose output does not strictly equal the Golden Result. Only time the ones that are semantically correct!

5. Fix the root cause of why AI skipped the  status == "PROCESSED"
The Real Root Cause: AI State-Management Laziness
The AI did not skip the check because it lacked an API; it skipped the check because it failed to correctly synthesize the Boolean State Flags required for the COMPLETE_OBJECT action.

In an FSM, compound conditionals (e.g., is_vip == true AND status == "PROCESSED") must be evaluated at the very end of the object. The correct way for the AI to handle this using our existing builder is:

Use fsm.declare_bool("is_processed").

Create a transition: fsm.on_sequence(..., sequence='"PROCESSED"', action="RECORD_BOOL", target="is_processed").

In the final action: fsm.set_object_complete_action("if (is_vip && is_processed) { vip_rev += cart_value; }").

The AI skipped the status check because it hallucinated that RECORD_BOOL only applies to literal true/false JSON values, completely missing that it can be used to flag the presence of specific string enumerations like "PROCESSED".

The Architectural Fix: Prompt Guardrails, Not API Bloat
We do not touch component9_aot.py. Instead, we tighten the cage around the Oracle in component2_smt.py.

Action: Instruct your senior engineer to update the generate_fsm_transforms prompt in component2_smt.py. We must explicitly teach the AI how to handle string-based conditional checks.

Python
# --- UPDATE IN: component2_smt.py -> generate_fsm_transforms prompt ---

    CRITICAL CONSTRAINTS FOR CONDITIONAL LOGIC:
    - You must often evaluate multiple conditions before accumulating a value (e.g., checking if a user is VIP AND if their status is "PROCESSED").
    - You MUST use `fsm.declare_bool()` to create a flag for EVERY condition you need to track.
    - FATAL ERROR WARNING: For string enumerations (like `"PROCESSED"` or `"PENDING"`), you MUST use `action="RECORD_BOOL"` directly on the `on_sequence` transition that matches the string key or value.
    - DO NOT attempt to write inline C++ `if` statements inside `on_char` or `on_sequence` transitions.
    - ALL compound logic (the actual math and accumulation) MUST happen inside the C++ string you pass to `fsm.set_object_complete_action()`. 
    - You must reset your boolean flags back to `false` at the end of your `set_object_complete_action` C++ block so they are clean for the next JSON object in the array.