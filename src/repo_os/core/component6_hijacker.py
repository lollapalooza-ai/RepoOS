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

from repo_os.core.component5_orchestrator import LazyCallManager

class PolyKernelLoader(Loader):
    def __init__(self, file_path: str, orchestrator: LazyCallManager):
        self.file_path = file_path
        self.orchestrator = orchestrator

    def create_module(self, spec):
        return None 

    def get_filename(self, fullname):
        return self.file_path

    def get_code(self, fullname):
        # Allow runpy to execute this module as __main__
        try:
            import inspect
            print(f"[Hijacker Debug] get_code called with fullname={fullname}")
            rewritten = load_rewritten_source(self.file_path, fullname)
            
            # INJECT BOOTSTRAP BEFORE execution of main block
            injection = f"""
import inspect
import sys
from repo_os.core.component6_hijacker import boot_poly_kernel
_orch = boot_poly_kernel('{fullname.split(".")[0]}')
_mod_dict = globals()
print(f"[Injection Debug] Scanning globals for functions. Looking for {fullname}.get_revenue")
for _name, _obj in list(_mod_dict.items()):
    if inspect.isfunction(_obj) or inspect.isclass(_obj):
        print(f"  [Injection Debug] Found {{_name}}")
        _trampoline = _orch.wrap("{fullname}." + _name, _obj)
        if _trampoline and _trampoline is not _obj:
            print(f"  [Injection Debug] Successfully wrapped {{_name}}")
            _mod_dict[_name] = _trampoline
            
            # Patch FastAPI app routes if 'app' is in globals
            if 'app' in _mod_dict and hasattr(_mod_dict['app'], 'routes'):
                for _route in _mod_dict['app'].routes:
                    if getattr(_route, 'endpoint', None) is _obj:
                        print(f"  [Injection Debug] Patching FastAPI route for {{_name}}")
                        _route.endpoint = _trampoline
                        if hasattr(_route, 'dependant'):
                            _route.dependant.call = _trampoline
"""
            # Replace the main guard with the injection + main guard
            if 'if __name__ == "__main__":' in rewritten:
                rewritten = rewritten.replace('if __name__ == "__main__":', injection + '\nif __name__ == "__main__":')
            elif "if __name__ == '__main__':" in rewritten:
                rewritten = rewritten.replace("if __name__ == '__main__':", injection + "\nif __name__ == '__main__':")
            else:
                rewritten = rewritten + "\n" + injection
                
            return compile(rewritten, self.file_path, 'exec')
        except:
            with open(self.file_path, 'r') as f:
                return compile(f.read(), self.file_path, 'exec')

    def exec_module(self, module):
        print(f"\n[Hijacker] 🕵️ Intercepted loading of module: {module.__name__}")
        print(f"[Hijacker] 1. Fast AST Chunking (Skipping Neo4j overhead)...")
        
        # 1. Fast AST Chunking (Skip Neo4j DB overhead)
        rewritten_source = load_rewritten_source(self.file_path, module.__name__)

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
                    for mod_name, mod in list(sys.modules.items()):
                        if mod and mod_name != module.__name__:
                            try:
                                # Look for attributes that point to the original object
                                for attr_name, attr_obj in inspect.getmembers(mod):
                                    if attr_obj is obj:
                                        setattr(mod, attr_name, trampoline)
                            except Exception:
                                pass
                                
                        # C. FastAPI Router Patching
                        try:
                            if hasattr(mod, 'app') and hasattr(mod.app, 'routes'):
                                for route in mod.app.routes:
                                    if hasattr(route, 'endpoint') and route.endpoint is obj:
                                        route.endpoint = trampoline
                                        if hasattr(route, 'dependant'):
                                            route.dependant.call = trampoline
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
                    from importlib.machinery import ModuleSpec
                    new_spec = ModuleSpec(fullname, PolyKernelLoader(spec.origin, self.orchestrator), is_package=is_package)
                    new_spec.origin = spec.origin
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
