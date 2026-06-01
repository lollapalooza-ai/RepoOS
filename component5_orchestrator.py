import ctypes
import os
import sys
from neo4j import GraphDatabase
import numpy as np
import torch

NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")

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

def get_orchestrated_kernel(target_fqn, dylib_path, original_func):
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

    # Fetch Data Bridge from Neo4j
    driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
    with driver.session() as session:
        result = session.run("MATCH (f:Function {fqn: $fqn}) RETURN f.prep_script as prep, f.post_script as post", fqn=target_fqn)
        record = result.single()
        prep_code = record["prep"] if record else None
        post_code = record["post"] if record else None
    driver.close()

    if not prep_code or not post_code:
        print(f"⚠️ Orchestrator: No Data Bridge found for {target_fqn}. Falling back.")
        return original_func

    def trampoline_trap(*args, **kwargs):
        try:
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
            # In MLIR C-Interface, the return tensor is often passed as a pointer to the first arg
            # but since we are generic, we assume the kernel modifies an output buffer passed in.
            
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
    """Manages the interception of package-level functions."""
    def __init__(self):
        self.orchestrated_funcs = {}
        self._driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)

    def wrap(self, fqn, func):
        # Universal Matching: Use the clean FQN provided by the hijacker
        if fqn in self.orchestrated_funcs:
            return self.orchestrated_funcs[fqn]

        print(f"--- 🔍 [Orchestrator] Checking Neo4j for: {fqn} ---")
        with self._driver.session() as session:
            # Query for exact or localized FQN match
            result = session.run("MATCH (f:Function) WHERE f.fqn = $fqn OR f.fqn ENDS WITH ('.' + $fqn) RETURN f.fqn as full_fqn, f.optimized_dylib_path as path", fqn=fqn)
            record = result.single()
            if record and record["path"] and os.path.exists(record["path"]):
                print(f"--- 🚀 [RepoOS] Match Found! Accelerating {record['full_fqn']} ---")
                orchestrated = get_orchestrated_kernel(record['full_fqn'], record["path"], func)
                self.orchestrated_funcs[fqn] = orchestrated
                return orchestrated
            else:
                print(f"--- ⚠️ [Orchestrator] No compiled kernel found for {fqn} ---")
        
        return func

if __name__ == "__main__":
    orchestrator = LazyCallManager()
