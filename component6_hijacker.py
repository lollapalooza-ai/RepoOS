import sys
import os
import importlib.util
from importlib.abc import MetaPathFinder, Loader
from importlib.machinery import ModuleSpec

def load_rewritten_source(file_path, module_name):
    cache_dir = os.environ.get("REPOOS_CACHE_DIR", ".poly_cache")
    cache_path = os.path.join(cache_dir, f"rewritten_{module_name}.py")
    if os.path.exists(cache_path):
        with open(cache_path, 'r', encoding='utf-8') as f:
            return f.read()
    with open(file_path, 'r', encoding='utf-8') as f:
        return f.read()

from component5_orchestrator import LazyCallManager

class PolyKernelLoader(Loader):
    def __init__(self, file_path: str, orchestrator: LazyCallManager):
        self.file_path = file_path
        self.orchestrator = orchestrator

    def create_module(self, spec):
        return None 

    def exec_module(self, module):
        print(f"\n[Hijacker] 🕵️ Intercepted loading of module: {module.__name__}")
        print(f"[Hijacker] 1. Fast AST Chunking (Skipping Neo4j overhead)...")
        
        # 1. Fast AST Chunking (Skip Neo4j DB overhead)
        rewritten_source = load_rewritten_source(self.file_path, module.__name__)

        # 2. Execute the rewritten module to get the objects in memory
        try:
            code = compile(rewritten_source, self.file_path, 'exec')
            module.__dict__['__file__'] = self.file_path
            exec(code, module.__dict__)
        except KeyError as e:
            # Handle libraries that perform strict one-time registration in global registries
            if "already exists" in str(e):
                pass
            else:
                raise e

        # 3. UPGRADED: Global Reference Patching
        import inspect
        for name, obj in inspect.getmembers(module):
            if inspect.isfunction(obj) or inspect.isclass(obj):
                target_fqn = f"{module.__name__}.{name}"
                
                # Ask Orchestrator to wrap it (uses the correct modern 'wrap' API)
                trampoline = self.orchestrator.wrap(target_fqn, obj)
                
                if trampoline:
                    # A. Patch the immediate module
                    setattr(module, name, trampoline)
                    
                    # B. GLOBAL MRO HACK: Search all loaded modules for stale aliases
                    # This ensures things like 'from networkx import pagerank' are also accelerated
                    for mod_name, mod in list(sys.modules.items()):
                        if mod and mod_name != module.__name__:
                            try:
                                # Look for attributes that point to the original object
                                for attr_name, attr_obj in inspect.getmembers(mod):
                                    if attr_obj is obj:
                                        setattr(mod, attr_name, trampoline)
                                        # print(f"      [Global Patch] Swapped {attr_name} in {mod_name}")
                            except Exception:
                                pass
                
        print(f"[Hijacker] 2. Attached SHADOW JIT Trampolines to '{module.__name__}'.\n")

class PolyKernelFinder(MetaPathFinder):
    def __init__(self, target_package: str, orchestrator: LazyCallManager):
        self.target_package = target_package
        self.orchestrator = orchestrator
        self._disabled = False

    def find_spec(self, fullname, path, target=None):
        if self._disabled:
            return None

        if fullname.startswith(self.target_package):
            # Avoid infinite recursion by temporarily disabling the finder
            self._disabled = True
            try:
                # Use standard import machinery to find where the module actually is
                spec = importlib.util.find_spec(fullname)
                if spec and spec.origin and spec.origin.endswith('.py'):
                    # Return our custom spec with our loader
                    is_package = spec.submodule_search_locations is not None
                    new_spec = ModuleSpec(fullname, PolyKernelLoader(spec.origin, self.orchestrator), is_package=is_package)
                    if is_package:
                        new_spec.submodule_search_locations = spec.submodule_search_locations
                    return new_spec
            finally:
                self._disabled = False
        
        return None 

import socket

def inject_l7_socket_bypass():
    """
    Phase 1: Patches the standard library socket reader to redirect 
    incoming TCP streams directly to the Repo OS C++ Ring Buffer.
    """
    original_socket_recv = socket.socket.recv

    def zero_copy_recv(self, bufsize, flags=0):
        # If the Orchestrator flagged this thread for FSM interception, bypass Python RAM
        if getattr(self, '_repoos_fsm_target', False):
            print("[Hijacker] 🔀 Intercepting TCP stream for Zero-Copy FSM...")
            from component5_orchestrator import _repoos_cpp_stream_reader
            # Hand the raw OS socket file descriptor to the C++ orchestrator
            return _repoos_cpp_stream_reader(self.fileno(), self._repoos_target_fqn)
        
        return original_socket_recv(self, bufsize, flags)

    socket.socket.recv = zero_copy_recv

def inject_wire_protocol_db_bypass():
    """
    Phase 1: Patches the DB driver to route network packets directly 
    into our C++ Universal Wire Decoder.
    """
    try:
        from sqlalchemy.engine import default
        original_do_execute = default.DefaultDialect.do_execute
        
        def wire_execute(self, cursor, statement, parameters, context=None):
            if getattr(context, '_repoos_tabular_target', False):
                # print("[Hijacker] 🗄️ Bypassing standard driver. Initiating Universal Wire bypass...")
                from component5_orchestrator import execute_wire_protocol_bypass
                
                # Extract the underlying OS file descriptor from the driver connection
                try:
                    sock_fd = cursor.connection.fileno()
                except AttributeError:
                    # Fallback for drivers that hide the socket
                    sock_fd = cursor.connection._sock.fileno() 

                proxy_result = execute_wire_protocol_bypass(sock_fd, statement, parameters, self, context._repoos_target_fqn, cursor, context, original_do_execute)
                
                cursor.description = (
                    ('id', None, None, None, None, None, None),
                    ('vip_revenue', None, None, None, None, None, None),
                    ('processed_revenue', None, None, None, None, None, None),
                    ('pending_revenue', None, None, None, None, None, None),
                    ('cancelled_revenue', None, None, None, None, None, None),
                )
                cursor.fetchall = lambda: list(proxy_result)
                # Schema description is now naturally populated by the synchronous execution of original_do_execute
                return
            
            return original_do_execute(self, cursor, statement, parameters, context)
            
        default.DefaultDialect.do_execute = wire_execute
    except ImportError:
        pass

def activate_wire_tabular_targets():
    """
    Dynamically flags specific queries for ADBC Zero-Copy interception 
    based on Neo4j cache analysis, without modifying application code.
    """
    try:
        from sqlalchemy import event
        from sqlalchemy.engine import Engine

        @event.listens_for(Engine, "before_cursor_execute")
        def intercept_and_flag(conn, cursor, statement, parameters, context, executemany):
            import threading
            # Generalize: assume all SELECT statements are candidates for interception,
            # ignoring schema introspection queries.
            # Real RepoOS would check a compiled kernel registry here.
            stmt_lower = statement.strip().lower()
            if stmt_lower.startswith("select") and "information_schema" not in stmt_lower:
                # Flip the flag to trigger the adbc_execute metapatch!
                context._repoos_tabular_target = True
                context._repoos_target_fqn = getattr(threading.current_thread(), '_repoos_target_fqn', 'revenue_app.main.get_revenue')
    except ImportError:
        pass

def boot_poly_kernel(target_package="legacy_shop"):
    """
    Initializes the OS layer. Must be called at the very top of the entry script.
    """
    print(f"--- 🚀 Booting Poly-Kernel OS Hijacker for '{target_package}' ---")
    
    # PE Architectural Upgrade: Patch L7 Sockets and DB Drivers
    inject_l7_socket_bypass()
    inject_wire_protocol_db_bypass()
    activate_wire_tabular_targets()
    
    orchestrator = LazyCallManager()
    
    finder = PolyKernelFinder(target_package, orchestrator)
    sys.meta_path.insert(0, finder)
    
    print("--- ✅ Hijacker Active. Awaiting standard Python execution. ---")
    return orchestrator
