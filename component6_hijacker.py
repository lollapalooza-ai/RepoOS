import sys
import os
import ast
import ctypes
import inspect
import importlib.util
from importlib.abc import MetaPathFinder, Loader
from importlib.machinery import ModuleSpec

# Import our Poly-Kernel components
from component1_ingest import process_file
from component5_orchestrator import LazyCallManager

class PolyKernelLoader(Loader):
    def __init__(self, file_path: str, orchestrator: LazyCallManager):
        self.file_path = file_path
        self.orchestrator = orchestrator

    def create_module(self, spec):
        return None 

    def exec_module(self, module):
        print(f"\n[Hijacker] 🕵️ Intercepted loading of module: {module.__name__}")
        print(f"[Hijacker] 1. Ingesting {self.file_path} to Semantic Graph...")
        
        # 1. On-the-fly Neo4j Ingestion & AST Chunking
        rewritten_source = process_file(self.file_path, forced_module_name=module.__name__, return_rewritten=True)

        # 2. Execute the rewritten module to get the objects in memory
        try:
            code = compile(rewritten_source, self.file_path, 'exec')
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

def boot_poly_kernel(target_package="legacy_shop"):
    """
    Initializes the OS layer. Must be called at the very top of the entry script.
    """
    print(f"--- 🚀 Booting Poly-Kernel OS Hijacker for '{target_package}' ---")
    orchestrator = LazyCallManager()
    
    finder = PolyKernelFinder(target_package, orchestrator)
    sys.meta_path.insert(0, finder)
    
    print("--- ✅ Hijacker Active. Awaiting standard Python execution. ---")
    return orchestrator
