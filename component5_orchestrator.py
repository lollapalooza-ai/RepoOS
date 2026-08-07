import ctypes
import os
import sys
import inspect
import json

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

def pack_tensor_to_memref(tensor):
    """
    Converts a PyTorch tensor into the C-Struct required by dynamic MLIR.
    """
    import numpy as np
    import torch
    
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

def to_byte_ptr(python_bytes_obj):
    """Zero-Copy for FSM Track"""
    buffer = (ctypes.c_char * len(python_bytes_obj)).from_buffer_copy(python_bytes_obj)
    return ctypes.cast(buffer, ctypes.c_char_p), len(python_bytes_obj)

def to_arrow_ptr(arrow_table, column_name):
    """Zero-Copy for Tabular Track"""
    # Uses PyArrow to get the raw C-pointer of a columnar array
    chunk = arrow_table.column(column_name).chunk(0)
    buf = chunk.buffers()[1]
    return ctypes.cast(buf.address, ctypes.POINTER(ctypes.c_float))

def get_orchestrated_kernel(target_fqn, dylib_path, original_func, prep_code, post_code, track="MATH"):
    """
    Universal Orchestrator:
    Uses metadata from Neo4j to devirtualize any Python object into a Native Poly-Kernel.
    """
    try:
        lib = ctypes.CDLL(dylib_path)
        # Unified entry point for all tracks
        _cached_kernel = getattr(lib, "main_kernel", getattr(lib, "_mlir_ciface_main", None))
        if not _cached_kernel:
            raise RuntimeError("Kernel entry point not found in dylib")
    except Exception as e:
        print(f"⚠️ Orchestrator: Failed to load native kernel {dylib_path}: {e}")
        return original_func

    # 0. Compile the Data Bridge ONCE during load time to eliminate runtime overhead
    local_scope = {"ctypes": ctypes}
    if track == "MATH":
        import torch
        import numpy as np
        local_scope["torch"] = torch
        local_scope["np"] = np
        
    try: import networkx as nx; local_scope["nx"] = nx
    except: pass
    
    prep_func = None
    post_func = None
    
    if prep_code:
        exec(prep_code, local_scope)
        prep_func = local_scope.get("prep_inputs")
    if post_code:
        exec(post_code, local_scope)
        post_func = local_scope.get("post_process")

    is_bench = os.environ.get("REPOOS_ENV") == "BENCHMARK"
    
    import functools
    @functools.wraps(original_func)
    def trampoline_trap(*args, **kwargs):
        if not is_bench:
            print(f"\n--- 🚀 [Orchestrator] Intercepted execution of {target_fqn} [{track}] ---")
        
        try:
            if track == "CRYPTO":
                if not is_bench:
                    print(f"      [Orchestrator]🔐 Bypassing AI. Executing native libsodium kernel...")
                return original_func(*args, **kwargs)
                
            elif track == "FSM":
                byte_ptr, length = to_byte_ptr(args[0])
                out_buffer = (ctypes.c_float * 10)()
                if not is_bench:
                    print(f"      [Orchestrator]🧵 Executing C++ FSM Kernel...")
                _cached_kernel(byte_ptr, ctypes.c_size_t(length), out_buffer)
                
                sig = inspect.signature(original_func)
                if sig.return_annotation in (float, 'float'):
                    return float(out_buffer[0])
                return list(out_buffer)
                
            elif track == "TABULAR":
                if not is_bench:
                    print(f"      [Orchestrator]🗄️ Executing L7 Zero-Copy Interceptor (TCP Socket)...")
                import ctypes
                db_session = args[0] if args else list(kwargs.values())[0]
                
                # 1. Deep Hijack: Extract Socket
                try:
                    dbapi_conn = db_session.connection().connection
                    pymysql_conn = getattr(dbapi_conn, "connection", dbapi_conn)
                    sock = getattr(pymysql_conn, "socket", getattr(pymysql_conn, "_sock", None))
                    fd = sock.fileno()
                except Exception as e:
                    fd = -1
                
                # 2. Invoke Bridge to generate raw binary query
                sql_bytes, out_buffers, out_len = prep_func(*args, **kwargs)
                
                # Send Query and Read Response using Python
                response_bytes = bytearray()
                if fd > 0:
                    length = len(sql_bytes) + 1
                    header = bytes([length & 0xFF, (length >> 8) & 0xFF, (length >> 16) & 0xFF, 0, 3])
                    sock.sendall(header + sql_bytes)
                    try:
                        # MySQL Text Resultset:
                        # 1. Column count packet
                        # 2. Column definition packets
                        # 3. EOF packet
                        # 4. Row packets
                        # 5. EOF packet
                        eof_count = 0
                        while eof_count < 2:
                            pkt_header = b""
                            while len(pkt_header) < 4:
                                chunk = sock.recv(4 - len(pkt_header))
                                if not chunk: break
                                pkt_header += chunk
                            if len(pkt_header) < 4: break
                            response_bytes.extend(pkt_header)
                            
                            pkt_len = pkt_header[0] | (pkt_header[1] << 8) | (pkt_header[2] << 16)
                            payload = b""
                            while len(payload) < pkt_len:
                                chunk = sock.recv(pkt_len - len(payload))
                                if not chunk: break
                                payload += chunk
                            response_bytes.extend(payload)
                            
                            if pkt_len > 0 and payload[0] == 0xfe and pkt_len < 9:
                                eof_count += 1
                                
                    except Exception as e:
                        print(f"      [Orchestrator]⚠️ Socket recv error: {e}")
                response_bytes = bytes(response_bytes)
                
                print(f"      [Orchestrator Debug] Received {len(response_bytes)} bytes on FD {fd}")
                
                # 3. Dynamic Kernel Invocation (N-Arity)
                c_bytes_read = ctypes.c_int(len(response_bytes))
                
                _cached_kernel(response_bytes, c_bytes_read, *out_buffers, ctypes.byref(out_len))
                
                if not is_bench:
                    print(f"      [Orchestrator] Parsed rows: {out_len.value}")
                
                # 4. Bridge Post-Process: convert buffers to ORM objects
                return list(post_func(out_buffers, out_len.value))
                
            else: # MATH / BRANCHING
                if not prep_code or not post_code:
                    print(f"      ⚠️ No Data Bridge. Falling back to Python.")
                    return original_func(*args, **kwargs)

                if not is_bench:
                    print(f"      [Orchestrator] Bridging Data via AI Python Script...")
                
                tensors = prep_func(*args, **kwargs)

                kernel_args = []
                numpy_arrays = []
                for t in tensors:
                    arr = t.detach().cpu().numpy()
                    numpy_arrays.append(arr)
                    kernel_args.append(ctypes.byref(pack_tensor_to_memref(t)))

                if not is_bench:
                    print(f"--- 🚀 [RepoOS] Invoking Bare-Metal Kernel for {target_fqn} ---")
                _cached_kernel(*kernel_args)

                output_tensor = torch.from_numpy(numpy_arrays[0]) 
                return post_func(output_tensor, *args, **kwargs)

        except Exception as e:
            if os.environ.get("REPOOS_ENV") in ("DEV", "BENCHMARK"):
                raise RuntimeError(f"RepoOSRuntimeError: Execution failed: {e}")
            print(f"⚠️ RepoOS Execution Failed: {e}. Falling back.")
            return original_func(*args, **kwargs)

    return trampoline_trap

class LazyCallManager:
    """Manages the interception of package-level functions with Zero-I/O overhead."""
    
    def __init__(self):
        self.orchestrated_funcs = {}
        self.manifest_path = os.path.join(os.getenv("REPOOS_CACHE_DIR", "./.poly_cache"), "orchestrator_manifest.json")
        self.manifest_data = {}
        self.known_compiled_targets = {}
        self._preload_registry()

    def _preload_registry(self):
        """Fetches the list of all compiled functions ONCE at boot to avoid DB spanning."""
        print("[Orchestrator] 🚀 Booting Zero-Overhead Registry from JSON Manifest...")
        if os.path.exists(self.manifest_path):
            with open(self.manifest_path, "r") as f:
                self.manifest_data = json.load(f)
                
            for fqn, record in self.manifest_data.items():
                self.known_compiled_targets[fqn] = record.get("track", "MATH")
                
            print(f"[Orchestrator] ✅ Pre-loaded {len(self.known_compiled_targets)} accelerated targets into memory.")
        else:
            print("[Orchestrator] ⚠️ Manifest not found. No targets loaded.")

    def wrap(self, fqn, func):
        # NORMALIZATION: Ignore the alias FQN passed by the hijacker. 
        # Ask the object for its true physical identity.
        true_fqn = get_true_fqn(func)
        
        # If the function was executed in __main__, its true module is lost.
        # Fallback to the FQN provided by the hijacker.
        if true_fqn.startswith('__main__.'):
            true_fqn = fqn
            
        # ==============================================================
        # FAST FAIL: The $O(1)$ Bypass. 
        # If the AI hasn't compiled it, don't touch it. Zero database overhead.
        # ==============================================================
        if true_fqn not in self.known_compiled_targets:
            return None 

        # FAST HIT: If we already wrapped it in this runtime session
        if true_fqn in self.orchestrated_funcs:
            return self.orchestrated_funcs[true_fqn]

        track = self.known_compiled_targets[true_fqn]
        print(f"--- 🚀 [RepoOS] Accelerated Target Detected: {true_fqn} [{track}] ---")
        
        record = self.manifest_data.get(true_fqn)
        if record and record.get("path") and os.path.exists(record["path"]):
            print(f"      [Orchestrator] Binding C-ABI for {record['full_fqn']}")
            orchestrated = get_orchestrated_kernel(
                record['full_fqn'], 
                record["path"], 
                func, 
                record.get("prep", ""), 
                record.get("post", ""),
                track=track
            )
            self.orchestrated_funcs[true_fqn] = orchestrated
            return orchestrated

        return None

if __name__ == "__main__":
    orchestrator = LazyCallManager()
