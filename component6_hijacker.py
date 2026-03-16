import sys
import os
import ast
import ctypes
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
        # Returning None tells Python to create a standard empty module object for us
        return None 

    def exec_module(self, module):
        print(f"\n[Hijacker] 🕵️ Intercepted loading of module: {module.__name__}")
        print(f"[Hijacker] 1. Ingesting {self.file_path} directly to Semantic Graph (Neo4j)...")
        
        # 1. On-the-fly Neo4j Ingestion (Guarantees the AI can see it when the Trampoline trips)
        process_file(self.file_path)

        # 2. Extract function signatures via AST
        with open(self.file_path, 'r', encoding='utf-8') as f:
            source_code = f.read()

        tree = ast.parse(source_code)
        func_count = 0
        
        for node in ast.walk(tree):
            if isinstance(node, ast.FunctionDef):
                func_name = node.name
                arg_count = len(node.args.args)
                
                # 3. Register with the JIT Orchestrator (Creates the Trampoline)
                arg_types = [ctypes.c_double] * arg_count
                self.orchestrator.register_lazy_function(func_name, arg_types, ctypes.c_double)
                
                # 4. The Magic: Bind the C-level Trampoline to the Python Module
                setattr(module, func_name, self.orchestrator.registry[func_name])
                func_count += 1
                
        print(f"[Hijacker] 2. Attached {func_count} JIT Trampolines to '{module.__name__}'.\n")

class PolyKernelFinder(MetaPathFinder):
    def __init__(self, target_package: str, orchestrator: LazyCallManager):
        self.target_package = target_package
        self.orchestrator = orchestrator

    def find_spec(self, fullname, path, target=None):
        # Only hijack imports that belong to our target application
        if fullname.startswith(self.target_package):
            
            # Resolve the module name to a physical file path
            # e.g., 'legacy_shop.tax' -> './legacy_shop/tax.py'
            file_path = f"./{fullname.replace('.', '/')}.py"
            
            # Handle package directories (__init__.py)
            if os.path.isdir(file_path.replace('.py', '')):
                file_path = f"./{fullname.replace('.', '/')}/__init__.py"

            if os.path.exists(file_path):
                return ModuleSpec(fullname, PolyKernelLoader(file_path, self.orchestrator))
        
        # Return None lets Python fall back to normal importing for things like 'json' or 'os'
        return None 

def boot_poly_kernel(target_package="legacy_shop"):
    """
    Initializes the OS layer. Must be called at the very top of the entry script.
    """
    print(f"--- 🚀 Booting Poly-Kernel OS Hijacker for '{target_package}' ---")
    orchestrator = LazyCallManager()
    
    # Inject our Finder at index 0 to guarantee we intercept before standard Python
    finder = PolyKernelFinder(target_package, orchestrator)
    sys.meta_path.insert(0, finder)
    
    print("--- ✅ Hijacker Active. Awaiting standard Python execution. ---")
    return orchestrator
