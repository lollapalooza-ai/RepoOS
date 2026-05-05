import sys
import os
import ctypes
import importlib.util

def bootstrap_mlir_prefix():
    """
    Dynamically patches the Python runtime to understand the non-standard 
    LLVM/MLIR C++ prefix installed by the mlir-wheels package.
    """
    # 0. Check if we already have mlir.ir (e.g. from PYTHONPATH)
    try:
        import mlir.ir
        print("[INFO] mlir.ir already available in sys.path.")
        return
    except ImportError:
        pass

    # 1. Dynamically find exactly where the active pip environment put the package
    spec = importlib.util.find_spec("mlir")
    if spec is None:
        raise RuntimeError("MLIR package not found. Did you run the pip install command?")
    
    if spec.origin:
        mlir_prefix_dir = os.path.dirname(spec.origin)
    elif spec.submodule_search_locations:
        # Handle namespace packages
        mlir_prefix_dir = list(spec.submodule_search_locations)[0]
    else:
        raise RuntimeError("MLIR package found but has no origin or search locations.")

    # 2. Patch sys.path so Python can find the actual nested 'mlir' python module
    python_core_path = os.path.join(mlir_prefix_dir, "python_packages", "mlir_core")
    
    if not os.path.exists(python_core_path):
         raise RuntimeError(
             f"\n[FATAL] MLIR core not found at: {python_core_path}\n"
             "You have the dummy PyPI 'mlir' package installed instead of the LLVM bindings.\n"
             "Run: pip uninstall -y mlir && pip install mlir --extra-index-url https://makslevental.github.io/wheels/"
         )

    if python_core_path not in sys.path:
        sys.path.insert(0, python_core_path)

    # 3. Pre-load the C++ Shared Libraries (The LD_LIBRARY_PATH hack)
    lib_dir = os.path.join(mlir_prefix_dir, "lib")
    if os.path.exists(lib_dir):
        ext = ".dylib" if sys.platform == "darwin" else ".so"
        try:
            # Load LLVM
            # Note: The wheel for Mac often uses .dylib
            llvm_lib = [f for f in os.listdir(lib_dir) if f.startswith("libLLVM") and f.endswith(ext)][0]
            ctypes.CDLL(os.path.join(lib_dir, llvm_lib), mode=ctypes.RTLD_GLOBAL)
            
            # Load MLIR C API
            mlir_lib = [f for f in os.listdir(lib_dir) if f.startswith("libMLIRPublicAPI") and (f.endswith(ext) or ".dylib" in f)][0]
            ctypes.CDLL(os.path.join(lib_dir, mlir_lib), mode=ctypes.RTLD_GLOBAL)
        except IndexError:
            # On some builds, the names might be slightly different or libraries might be in _mlir_libs
            print("[WARNING] Could not aggressively pre-load LLVM shared libraries from /lib. Import may fail.")

# Execute immediately upon import
bootstrap_mlir_prefix()
