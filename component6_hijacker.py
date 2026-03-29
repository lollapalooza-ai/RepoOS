import sys
import os
import ast
import ctypes
import inspect
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
        
        # 1. On-the-fly Neo4j Ingestion
        process_file(self.file_path)

        # 2. Execute the module to get the objects
        with open(self.file_path, 'r', encoding='utf-8') as f:
            code = compile(f.read(), self.file_path, 'exec')
            exec(code, module.__dict__)

        # 3. UPGRADED: Class-Level Hijacking
        func_count = 0
        for name, obj in inspect.getmembers(module):
            if inspect.isclass(obj) and obj.__module__ == module.__name__:
                for method_name, method_obj in inspect.getmembers(obj, predicate=inspect.isfunction):
                    fqn = f"{module.__name__}.{name}.{method_name}"
                    trampoline = self.orchestrator.register_lazy_function(method_name, method_obj, fqn)
                    setattr(obj, method_name, trampoline) # Patch the class directly
                    func_count += 1
            elif inspect.isfunction(obj) and obj.__module__ == module.__name__:
                fqn = f"{module.__name__}.{name}"
                trampoline = self.orchestrator.register_lazy_function(name, obj, fqn)
                setattr(module, name, trampoline)
                func_count += 1
                
        print(f"[Hijacker] 2. Attached {func_count} SHADOW JIT Trampolines to '{module.__name__}'.\n")

class PolyKernelFinder(MetaPathFinder):
    def __init__(self, target_package: str, orchestrator: LazyCallManager):
        self.target_package = target_package
        self.orchestrator = orchestrator

    def find_spec(self, fullname, path, target=None):
        if fullname.startswith(self.target_package):
            # Resolve module name to file path
            parts = fullname.split('.')
            # Check if it's a package or a module
            base_path = os.path.join(*parts)
            
            potential_paths = [
                f"./{base_path}.py",
                f"./{base_path}/__init__.py"
            ]
            
            for file_path in potential_paths:
                if os.path.exists(file_path):
                    return ModuleSpec(fullname, PolyKernelLoader(file_path, self.orchestrator), is_package=file_path.endswith('__init__.py'))
        
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
