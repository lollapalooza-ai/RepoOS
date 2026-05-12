# RepoOS-AI-Compiler

RepoOS is an AI-driven, formally verified compiler toolchain that bridges Python logic into high-performance native machine code via **MLIR (Multi-Level Intermediate Representation)**.

---

## 🛠 Prerequisites & Environment

All commands must be run from the project root: `/Users/yeshr/Applications/Program1` using the specialized build environment.

**Key Path Variables:**
*   **Interpreter:** `./build_venv/bin/python3`
*   **MLIR Core:** `/Users/yeshr/Applications/Program1/llvm-project/build/tools/mlir/python_packages/mlir_core`
*   **LLVM Libs:** `/Users/yeshr/Applications/Program1/llvm-project/build/lib`

### Environment Export Template
Before running any component, ensure your environment is set:
```bash
export PYTHONPATH=/Users/yeshr/Applications/Program1/llvm-project/build/tools/mlir/python_packages/mlir_core:/Users/yeshr/Applications/Program1
export DYLD_LIBRARY_PATH=/opt/homebrew/opt/expat/lib:/Users/yeshr/Applications/Program1/llvm-project/build/lib
```

---

## 🚀 The Operational Pipeline

### 1. Semantic Ingestion (Neo4j)
Parses Python source code, extracts pure logic chunks, and stores them in the Neo4j Semantic Graph.
*   **Example:** Ingest the NetworkX random sequence module.
```bash
./build_venv/bin/python3 component1_ingest.py venv/lib/python3.9/site-packages/networkx/utils/random_sequence.py
```

### 2. Reference Baselining (`manual_compiler.py`)
**CRITICAL:** This component provides the "Ground Truth" MLIR templates for complex kernels to prevent AI hallucinations.
```bash
REPOOS_MANUAL_CACHE_DIR=.poly_cache_manual ./build_venv/bin/python3 manual_compiler.py
```

### 3. AOT Compilation (MLIR to .dylib)
Translates Python chunks into MLIR and compiles them into native shared libraries.
*   **Example:** Compile all detected chunks for the NetworkX package.
```bash
REPOOS_CACHE_DIR=.poly_cache_networkx \
REPOOS_MANUAL_CACHE_DIR=.poly_cache_manual \
./build_venv/bin/python3 component9_aot.py networkx
```

---

## 🧪 Validation & Test Suite

The following scripts are used to verify the integrity and performance of the compiler pipeline.

### A. ABI & Programmatic JSON Verification (`test_manual_pipeline.py`)
Verifies that the MLIR JSON templates correctly lower to machine code and that the Python-to-C ABI (MemRef descriptors) is working without segfaults.
```bash
export PYTHONPATH=/Users/yeshr/Applications/Program1/llvm-project/build/tools/mlir/python_packages/mlir_core:/Users/yeshr/Applications/Program1
export DYLD_LIBRARY_PATH=/opt/homebrew/opt/expat/lib:/Users/yeshr/Applications/Program1/llvm-project/build/lib
./build_venv/bin/python3 test_manual_pipeline.py
```

### B. CSR Devirtualization Validation (`verify_devirtualization.py`)
Validates the **Milestone 5.2** implementation. It proves that RepoOS can successfully project a complex `networkx.DiGraph` into flat C-arrays, execute a kernel, and return a dictionary.
```bash
./build_venv/bin/python3 verify_devirtualization.py
```

### C. Manual Cache Integrity (`validate_manual_cache.py`)
Checks that the `.poly_cache_manual` directory contains valid, parseable MLIR JSON files that match the expected schema.
```bash
./build_venv/bin/python3 validate_manual_cache.py
```

---

## 📊 Performance Suite (`component8-networkx.py`)

Runs the comprehensive benchmark comparing Native Python, RepoOS (Standard List), and RepoOS (NumPy Zero-Copy).

**Run Command:**
```bash
export PYTHONPATH=/Users/yeshr/Applications/Program1/llvm-project/build/tools/mlir/python_packages/mlir_core:/Users/yeshr/Applications/Program1
export DYLD_LIBRARY_PATH=/opt/homebrew/opt/expat/lib:/Users/yeshr/Applications/Program1/llvm-project/build/lib
REPOOS_CACHE_DIR=.poly_cache_networkx \
REPOOS_MANUAL_CACHE_DIR=.poly_cache_manual \
./build_venv/bin/python3 component8-networkx.py
```
*   **Success Criteria:** RepoOS (NumPy) should show a **~25x Speedup** over Native Python for 10,000 elements.

---

## 🔧 Component Overview

| Component | Name | Responsibility |
| :--- | :--- | :--- |
| **Component 1** | Ingester | AST Parsing (tree-sitter) & Neo4j Storage |
| **Component 2** | SMT/AI | Python-to-MLIR translation & Z3 Formal Verification |
| **Component 4** | JIT/Loader | High-stability AOT Kernel Loader (ctypes Bridge) |
| **Component 5** | Orchestrator | Runtime logic swapping & CSR/Zero-Copy Data Pathing |
| **Component 6** | Hijacker | MetaPathFinder import-level interception |
| **Component 9** | AOT Backend | MLIR lowering to LLVM IR and Clang compilation |
| **Manual Compiler** | Baseliner | Provides formally verified ground-truth templates |

---

## 💡 Engineering Best Practices

1.  **Always use Zero-Copy:** Passing Python lists incurs an O(N) copy tax. For maximum performance, use NumPy arrays which RepoOS detects and processes with **0ns** data transfer cost.
2.  **Verify via Manual Pipeline:** If a new kernel is failing, run `test_manual_pipeline.py` first to isolate whether the issue is in the MLIR logic or the AI translation.
3.  **Check Neo4j:** Ensure `component1` has successfully chunked your function by querying the Neo4j browser before running `component9`.
