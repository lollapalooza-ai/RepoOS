Phase 1: Hardening the Sandbox & Enforcing the Minimalist Funnel (Shift 1 & 2)
We are going to completely rewrite RepoOSSchedule in component9_aot.py. We will strip the AI of any ability to talk about memory or lowering, and we will implement the ast Security Sandbox to prevent prompt injections or Python hallucination crashes.

Replace the RepoOSSchedule class in component9_aot.py with this exact implementation:

Python
import ast

class SecurityError(Exception):
    pass

class SafeScheduleValidator(ast.NodeVisitor):
    """
    Strict AST Walker. Rejects anything that isn't a basic function definition,
    variable assignment, or method call. Ensures the AI cannot break the sandbox.
    """
    ALLOWED_NODES = {
        ast.Module, ast.FunctionDef, ast.arguments, ast.arg,
        ast.Expr, ast.Call, ast.Attribute, ast.Name,
        ast.Load, ast.Store, ast.Assign, ast.Constant, ast.List
    }

    def generic_visit(self, node):
        if type(node) not in self.ALLOWED_NODES:
            raise SecurityError(f"FATAL: AI generated unauthorized Python syntax: {type(node).__name__}")
        
        # Prevent accessing private methods (e.g., schedule._next_var())
        if isinstance(node, ast.Attribute) and node.attr.startswith('_'):
            raise SecurityError(f"FATAL: AI attempted to access private attribute: {node.attr}")
            
        super().generic_visit(node)

class RepoOSSchedule:
    """
    The Python Builder API for MLIR Transform Dialect.
    Shift 1: The AI Sandbox (Policy Only). No memory management allowed.
    """
    def __init__(self):
        self.instructions = []
        self.var_counter = 0

    def _next_var(self) -> str:
        self.var_counter += 1
        return f"%v{self.var_counter}"

    # === SECTION 1: AI SANDBOX (Public API) ===
    def match(self, target_op: str) -> str:
        out_var = self._next_var()
        self.instructions.append(
            f"    {out_var} = transform.structured.match in %root {{ ops = [\"{target_op}\"] }} : (!transform.any_op) -> !transform.any_op"
        )
        return out_var

    def tile_to_blocks(self, target_var: str, tile_sizes: list[int]) -> str:
        tiled_op = self._next_var()
        grid_var = self._next_var()
        sizes_str = ", ".join(map(str, tile_sizes))
        mapping = "[#gpu.block<x>, #gpu.block<y>]"
        self.instructions.append(
            f"    {grid_var}, {tiled_op} = transform.structured.tile_using_forall {target_var} tile_sizes [{sizes_str}] {{ mapping = {mapping} }} : (!transform.any_op) -> (!transform.any_op, !transform.any_op)"
        )
        return tiled_op

    def tile_to_threads(self, target_var: str, tile_sizes: list[int], block_dims: list[int] = None) -> str:
        tiled_op = self._next_var()
        thread_var = self._next_var()
        sizes_str = ", ".join(map(str, tile_sizes))
        mapping = "[#gpu.thread<x>, #gpu.thread<y>]"
        self.instructions.append(
            f"    {thread_var}, {tiled_op} = transform.structured.tile_using_forall {target_var} tile_sizes [{sizes_str}] {{ mapping = {mapping} }} : (!transform.any_op) -> (!transform.any_op, !transform.any_op)"
        )
        return tiled_op

    def vectorize(self, target_var: str):
        self.instructions.append(f"    transform.structured.vectorize {target_var} : !transform.any_op")

    # === SECTION 2: THE CONCRETE CHUTE (Private API) ===
    # Notice we REMOVED `lower_to_nvvm` from the AI's vocabulary.
    
    def build_mlir(self) -> str:
        header = "transform.named_sequence @__transform_main(%root: !transform.any_op) {\n"
        body = "\n".join(self.instructions)
        # Shift 2: Concrete Chute forces the DPS bufferization passes implicitly
        footer = "\n    // Memory management is locked to the orchestrator.\n    transform.yield\n}"
        return header + body + footer

def safe_execute_schedule(ai_generated_python_code: str, schedule_builder: RepoOSSchedule):
    """Safely parses and executes the AI schedule via AST whitelist."""
    tree = ast.parse(ai_generated_python_code)
    
    validator = SafeScheduleValidator()
    validator.visit(tree) # Will raise SecurityError if illegal syntax is found
    
    local_scope = {}
    compiled_code = compile(tree, filename="<ast>", mode="exec")
    exec(compiled_code, {}, local_scope)
    
    if "apply_schedule" not in local_scope:
        raise ValueError("AI failed to generate 'apply_schedule' function.")
        
    local_scope["apply_schedule"](schedule_builder)
Next, update apply_gpu_transform_and_compile in component9_aot.py to use the new execution loop:
(Replace the exec(transform_python_code, {}, local_scope) block with this)

Python
            print(f"      [Compiler] Executing AI Python Schedule via AST Sandbox...")
            schedule = RepoOSSchedule()
            
            # Use our new secure executor
            safe_execute_schedule(transform_python_code, schedule)
                
            transform_mlir = schedule.build_mlir()
Phase 2: Implementing Benchmarking Search (Equality Saturation Fallback)
Right now, your component10_dynamo.py executes a break the moment it finds an MLIR string that compiles. We need to implement true Equality Saturation: compile all variants, load them into memory, race them against each other in a micro-benchmark, and keep the winner.

Replace Steps 4 and 5 in _repoos_inference_backend_async inside component10_dynamo.py with this:

Python
    # 4. BENCHMARKING SEARCH (EQUALITY SATURATION)
    from component9_aot import safe_execute_schedule, RepoOSSchedule
    import time
    
    compiled_dylibs = []
    
    # Try all AI-generated schedules
    for idx, transform_script in enumerate(transform_scripts):
        variant_dylib = os.path.join(CACHE_DIR, f"kernel_{kernel_id}_v{idx}.so")
        print(f"[Dynamo] Compiling AI Schedule Variant {idx+1}/{len(transform_scripts)}...")
        
        try:
            schedule = RepoOSSchedule()
            safe_execute_schedule(transform_script, schedule)
            transform_mlir = schedule.build_mlir()
        except Exception as e:
            print(f"[Dynamo] ⚠️ Sandbox rejected AI script: {e}")
            continue

        await apply_ai_transform_and_compile(
            base_mlir_text, transform_mlir, variant_dylib, is_gpu=is_gpu
        )
        
        if os.path.exists(variant_dylib):
            compiled_dylibs.append(variant_dylib)
            print(f"[Dynamo] ✅ Variant {idx+1} successfully compiled.")

    # Fallback if AI totally failed
    if not compiled_dylibs:
        print("[Dynamo] ⚠️ All AI schedules failed bufferization. Falling back to programmatic base.")
        compiled_dylibs.append(base_dylib_path)

    # 5. MICRO-BENCHMARK THE SURVIVORS
    print(f"[Dynamo] 🏁 Racing {len(compiled_dylibs)} compiled kernels to find the Speed of Light (SoL)...")
    
    best_dylib = compiled_dylibs[0]
    best_time = float('inf')
    best_kernel_func = None
    
    for dylib in compiled_dylibs:
        try:
            lib = ctypes.CDLL(dylib)
            k_func = lib._mlir_ciface_main if hasattr(lib, "_mlir_ciface_main") else lib.main
            k_func.restype = ctypes.c_void_p
            
            # Prepare bare-pointer args for the micro-benchmark
            kernel_args = []
            numpy_arrays = []
            for arg in example_inputs:
                if not isinstance(arg, torch.Tensor): continue
                arr = arg.detach().cpu().numpy()
                numpy_arrays.append(arr)
                kernel_args.append(arr.ctypes.data_as(ctypes.c_void_p))
                
            # Warmup
            k_func(*kernel_args)
            
            # Benchmark (10 iterations)
            start_time = time.perf_counter()
            for _ in range(10):
                k_func(*kernel_args)
            avg_time = (time.perf_counter() - start_time) / 10.0
            
            print(f"      🏎️  {os.path.basename(dylib)}: {avg_time*1000:.4f} ms")
            
            if avg_time < best_time:
                best_time = avg_time
                best_dylib = dylib
                best_kernel_func = k_func
                
        except Exception as e:
            print(f"      ❌ Benchmark failed for {dylib}: {e}")

    print(f"[Dynamo] 🏆 Winner: {os.path.basename(best_dylib)} ({best_time*1000:.4f} ms)")
    kernel_func = best_kernel_func

    # ... The rest of your optimized_forward logic remains exactly the same ...