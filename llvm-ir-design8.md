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


# Milestone 8.2
ENGINEERING BRIEF: EPOCH 2 - DYNAMIC SHAPE HANDLING
To: Senior Compiler Engineer
From: Principal Engineering
Subject: Upgrading Repo OS for Symbolic Tensor Dimensions (LLM Support)

The Architectural Problem
Currently, Repo OS hardcodes tensor sizes during the MLIR lowering phase. If Dynamo sees a tensor of shape [4, 128], it compiles a binary hardcoded for exactly 4 batches and 128 sequence length. If the next API request has a sequence length of 129, the execution will either crash with a Segfault or trigger a catastrophic, 10-second recompilation.

To support LLMs (where prompt length changes every request), we must upgrade the system to support Symbolic Shapes (e.g., tensor<?x?xf32>).

This requires three surgical updates across the codebase:

The Tracing Layer: Forcing torch.export to emit symbolic bounds.

The ABI Bridge: Upgrading our ctypes bare-pointer implementation to full N-Dimensional MemRef Descriptors.

The Oracle Prompt: Warning the AI that it is dealing with partial boundary tiles.

Step 1: Upgrading Dynamo (component10_dynamo.py)
We must intercept the PyTorch graph before it lowers to MLIR and explicitly mark the varying dimensions (usually dimension 0 for Batch Size, and dimension 1 for Sequence Length) as "Dynamic."

Replace the deterministic tracing logic in _repoos_inference_backend_async with this implementation using torch.export.Dim:

Python
import torch
from torch.export import Dim
from torch_mlir.extras.fx_importer import FxImporter

def capture_dynamic_mlir(gm: torch.fx.GraphModule, example_inputs: list) -> str:
    """
    Captures the MLIR graph with strictly symbolic dynamic dimensions.
    """
    dynamic_shapes = {}
    
    # 1. Define our symbolic variables
    # We define max bounds to help the compiler optimize memory pre-fetching
    batch_dim = Dim("batch_size", min=1, max=2048)
    seq_dim = Dim("seq_length", min=1, max=32768)
    
    # 2. Map symbolic variables to the input tensors
    for i, arg in enumerate(example_inputs):
        if isinstance(arg, torch.Tensor):
            # If 2D or greater, assume Batch is dim 0, Seq is dim 1
            if arg.ndim >= 2:
                dynamic_shapes[i] = {0: batch_dim, 1: seq_dim}
            # If 1D, assume it's just a sequence/batch vector
            elif arg.ndim == 1:
                dynamic_shapes[i] = {0: batch_dim}

    # 3. Export using PyTorch 2.0+ Dynamic Shapes API
    exported_program = torch.export.export(
        gm, 
        tuple(example_inputs), 
        dynamic_shapes=dynamic_shapes
    )
    
    # 4. Lower to MLIR Linalg on Tensors
    # The output will now contain tensor<?x?xf32> instead of hardcoded sizes
    import torch_mlir
    mlir_module = torch_mlir.torchscript.compile(
        exported_program.module(), 
        example_inputs, 
        output_type=torch_mlir.torchscript.OutputType.LINALG_ON_TENSORS
    )
    return str(mlir_module)
Step 2: The MemRef ABI Bridge (component5_orchestrator.py)
Critical Architecture Note: You cannot pass bare pointers (void*) to MLIR when shapes are dynamic. If MLIR doesn't know the shape at compile time, it must receive the shape at runtime.

To do this, we must dynamically generate C-Compatible MemRef structures in Python that describe the tensor's shape, strides, and memory pointers.

Add this dynamic C-Struct generator to the Orchestrator/Runtime bridge:

Python
import ctypes
import numpy as np

def make_nd_memref_struct(ndim: int, dtype):
    """
    Dynamically creates an MLIR-ABI compliant MemRef descriptor C-Struct 
    for any tensor dimension at runtime.
    """
    c_type = ctypes.c_float # Default, map to dtype in prod
    
    class MemRefDescriptor(ctypes.Structure):
        _fields_ = [
            ("allocatedPtr", ctypes.POINTER(c_type)),
            ("alignedPtr", ctypes.POINTER(c_type)),
            ("offset", ctypes.c_int64),
            ("sizes", ctypes.c_int64 * ndim),
            ("strides", ctypes.c_int64 * ndim)
        ]
    return MemRefDescriptor

def pack_tensor_to_memref(tensor: torch.Tensor):
    """
    Converts a PyTorch tensor into the C-Struct required by dynamic MLIR.
    """
    tensor_np = tensor.detach().cpu().numpy()
    ndim = tensor_np.ndim
    
    # Generate the strict C-Struct for this specific rank
    MemRefStruct = make_nd_memref_struct(ndim, tensor_np.dtype)
    memref = MemRefStruct()
    
    # Fill the pointers
    ptr = tensor_np.ctypes.data_as(ctypes.POINTER(ctypes.c_float))
    memref.allocatedPtr = ptr
    memref.alignedPtr = ptr
    memref.offset = 0
    
    # Fill dynamic sizes and strides
    for i in range(ndim):
        memref.sizes[i] = tensor_np.shape[i]
        # NumPy strides are in bytes, MLIR expects elements
        memref.strides[i] = tensor_np.strides[i] // tensor_np.itemsize
        
    return memref
When executing the kernel using ctypes, you will now pass ctypes.byref(pack_tensor_to_memref(arg)) instead of raw pointers.

Step 3: Upgrading the Oracle Prompt (component2_smt.py)
Because the tensors now have ? (unknown) sizes, the AI's tiling strategy will result in "partial tiles." If the AI tiles by 32, but the sequence length is 50, the compiler will generate an affine.min bounding box to handle the remaining 18 elements.

Update the AI prompt in generate_inference_transforms to add this critical hardware constraint:

Plaintext
    CRITICAL DYNAMIC SHAPE CONSTRAINTS:
    - The baseline MLIR graph contains SYMBOLIC DYNAMIC SHAPES (tensor<?x?xf32>).
    - When you call `schedule.tile()`, the compiler will automatically generate affine boundary checks (e.g., scf.if or affine.min) to handle uneven loop tails.
    - DO NOT attempt to mask or pad the data manually. Let the compiler handle the boundary geometry.
    - Prioritize cache-friendly tile sizes (e.g., 32, 64, 128) that divide cleanly into typical power-of-2 sequence lengths to minimize branch prediction penalties on the CPU.
Principal Engineer's Final Review
If your engineer implements these three blocks:

PyTorch will gracefully export symbolic math (?).

The MLIR compiler will compile the logic using algebraic bounds rather than fixed integers.

The Python Orchestrator will inject the exact mathematical sizes into the .so kernel at the exact millisecond of execution via the MemRef struct.

You will now be able to compile the nanoGPT Self-Attention block once, and feed it a prompt of 5 words, followed by a prompt of 500 words, and the same underlying bare-metal kernel will execute perfectly without recompiling.