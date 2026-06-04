import ctypes
import os
import sys
import inspect
from neo4j import GraphDatabase
import numpy as np
import torch

NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")

def get_true_fqn(func):
    """
    Unwraps decorators and aliases to find the true, physical origin of a Python function.
    This guarantees a 1:1, O(1) match with the AST Ingester.
    """
    try:
        # 1. Unwrap any decorators (like @lru_cache) to get the raw original function
        unwrapped_func = inspect.unwrap(func)
        
        # 2. Extract the exact file module where the function was physically written
        module_name = getattr(unwrapped_func, '__module__', '')
        
        # 3. Extract the true qualified name (handles inner classes/functions)
        func_name = getattr(unwrapped_func, '__qualname__', getattr(unwrapped_func, '__name__', ''))
        
        if module_name and func_name:
            return f"{module_name}.{func_name}"
        return func_name
    except Exception:
        # Fallback if the object is a weird C-extension
        return getattr(func, '__name__', str(func))

class MemRef1D(ctypes.Structure):
    _fields_ = [("base", ctypes.c_void_p), ("data", ctypes.c_void_p), 
                ("offset", ctypes.c_longlong), ("size", ctypes.c_longlong), 
                ("stride", ctypes.c_longlong)]

class MemRef2D(ctypes.Structure):
    _fields_ = [("base", ctypes.c_void_p), ("data", ctypes.c_void_p), 
                ("offset", ctypes.c_longlong), 
                ("size", ctypes.c_longlong * 2), 
                ("stride", ctypes.c_longlong * 2)]

def to_memref(arr):
    """Maps a NumPy array to a C-compatible MemRef descriptor."""
    if arr.ndim == 1:
        return MemRef1D(arr.ctypes.data, arr.ctypes.data, 0, arr.size, 1)
    elif arr.ndim == 2:
        sizes = (ctypes.c_longlong * 2)(*arr.shape)
        strides = (ctypes.c_longlong * 2)(*arr.strides)
        return MemRef2D(arr.ctypes.data, arr.ctypes.data, 0, sizes, strides)
    raise ValueError(f"Unsupported dimension: {arr.ndim}")

def get_orchestrated_kernel(target_fqn, dylib_path, original_func, prep_code, post_code):
    """
    Universal Orchestrator:
    Uses metadata from Neo4j to devirtualize any Python object into a Native Poly-Kernel.
    """
    try:
        lib = ctypes.CDLL(dylib_path)
        kernel = lib._mlir_ciface_main
    except Exception as e:
        print(f"⚠️ Orchestrator: Failed to load native kernel {dylib_path}: {e}")
        return original_func

    if not prep_code or not post_code:
        print(f"⚠️ Orchestrator: No Data Bridge provided for {target_fqn}. Falling back.")
        return original_func

    def trampoline_trap(*args, **kwargs):
        print(f"\n--- 🚀 [Orchestrator] Intercepted execution of {target_fqn} ---")
        
        # ==========================================
        # DEBUG LOGGING: What exactly are we intercepting?
        # ==========================================
        print(f"      [Debug] Raw Inputs Intercepted: {len(args)} args, {len(kwargs)} kwargs")
        for i, arg in enumerate(args):
            if hasattr(arg, 'shape'): # Numpy or PyTorch
                print(f"      [Debug] Arg {i}: Array/Tensor -> shape={arg.shape}, dtype={arg.dtype}")
            elif isinstance(arg, (list, dict, set)): # Collections / NetworkX Graphs
                print(f"      [Debug] Arg {i}: {type(arg).__name__} -> length/nodes={len(arg)}")
            else: # Scalars
                print(f"      [Debug] Arg {i}: Scalar {type(arg).__name__} -> {str(arg)[:20]}...")
        # ==========================================

        try:
            print(f"      [Orchestrator] Bridging Data via AI Python Script...")
            # 1. PREP: Execute AI-synthesized Devirtualizer
            local_scope = {"torch": torch, "np": np, "args": args, "kwargs": kwargs}
            # Add nx if it's a graph-related call
            try: import networkx as nx; local_scope["nx"] = nx
            except: pass

            exec(prep_code, local_scope)
            prep_func = local_scope.get("prep_inputs")
            tensors = prep_func(*args, **kwargs) # Should return list of torch Tensors

            # 2. ABI BRIDGE: Map Tensors to MemRefs
            kernel_args = []
            numpy_arrays = []
            for t in tensors:
                arr = t.detach().cpu().numpy()
                numpy_arrays.append(arr) # Keep reference to prevent GC
                kernel_args.append(ctypes.byref(to_memref(arr)))

            # 3. EXECUTE: Invoke Bare-Metal Kernel
            print(f"--- 🚀 [RepoOS] Invoking Bare-Metal Kernel for {target_fqn} ---")
            kernel(*kernel_args)

            # 4. POST: Execute AI-synthesized Revirtualizer
            # Use the first array as the typical result buffer
            output_tensor = torch.from_numpy(numpy_arrays[0]) 
            exec(post_code, local_scope)
            post_func = local_scope.get("post_process")
            return post_func(output_tensor, *args, **kwargs)

        except Exception as e:
            print(f"⚠️ RepoOS Execution Failed: {e}. Falling back.")
            return original_func(*args, **kwargs)

    return trampoline_trap

class LazyCallManager:
    """Manages the interception of package-level functions with Zero-I/O overhead."""
    
    def __init__(self):
        self.orchestrated_funcs = {}
        self._driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
        
        # --- NEW: The In-Memory Manifest ---
        self.known_compiled_targets = set()
        self._preload_registry()

    def _preload_registry(self):
        """Fetches the list of all compiled functions ONCE at boot to avoid DB spanning."""
        print("[Orchestrator] 🚀 Booting Zero-Overhead Registry...")
        with self._driver.session() as session:
            # Only pull functions that actually have a compiled .dylib
            query = "MATCH (f:Function) WHERE f.optimized_dylib_path IS NOT NULL AND f.optimized_dylib_path <> '' RETURN f.fqn as fqn"
            result = session.run(query)
            for record in result:
                self.known_compiled_targets.add(record["fqn"])
                
        print(f"[Orchestrator] ✅ Pre-loaded {len(self.known_compiled_targets)} accelerated targets into memory.")

    def wrap(self, fqn, func):
        # NORMALIZATION: Ignore the alias FQN passed by the hijacker. 
        # Ask the object for its true physical identity.
        true_fqn = get_true_fqn(func)
        
        # ==============================================================
        # FAST FAIL: The $O(1)$ Bypass. 
        # If the AI hasn't compiled it, don't touch it. Zero database overhead.
        # ==============================================================
        if true_fqn not in self.known_compiled_targets:
            return None 

        # FAST HIT: If we already wrapped it in this runtime session
        if true_fqn in self.orchestrated_funcs:
            return self.orchestrated_funcs[true_fqn]

        # ONLY if it's a guaranteed hit do we query Neo4j for the actual file paths
        print(f"--- 🚀 [RepoOS] Accelerated Target Detected: {true_fqn} ---")
        
        with self._driver.session() as session:
            # We can now do a STRICT, FAST EXACT MATCH. No fuzzy logic required.
            query = """
            MATCH (f:Function {fqn: $fqn}) 
            RETURN f.fqn as full_fqn, f.optimized_dylib_path as path, 
                   f.prep_script as prep, f.post_script as post
            """
            result = session.run(query, fqn=true_fqn)
            record = result.single()
            
            if record and record["path"] and os.path.exists(record["path"]):
                print(f"      [Orchestrator] Binding C-ABI for {record['full_fqn']}")
                orchestrated = get_orchestrated_kernel(
                    record['full_fqn'], 
                    record["path"], 
                    func, 
                    record["prep"], 
                    record["post"]
                )
                self.orchestrated_funcs[true_fqn] = orchestrated
                return orchestrated

        return None

if __name__ == "__main__":
    orchestrator = LazyCallManager()
