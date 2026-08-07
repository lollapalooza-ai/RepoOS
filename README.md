# RepoOS-AI-Compiler

RepoOS is an AI-driven, formally verified compiler toolchain that bridges Python logic into high-performance native machine code via **MLIR (Multi-Level Intermediate Representation)**.

---

## ⚖️ Core Engineering Principles

To ensure RepoOS functions as a truly generic, enterprise-grade acceleration layer, all contributions MUST adhere to these foundational rules:

1.  **Zero Hardcoding (Generalization Mandate):** Never hardcode function-specific checks, names, or specialized logic into core files. RepoOS must remain agnostic of the target codebase. All algorithm-specific behavior (e.g., scaling, normalization, structural mapping) must be driven by generic metadata (`config` field in `VerifiedMLIR`).
2.  **Universal Applicability:** Logic must be designed to handle arbitrary codebases and functions. This applies to all core components (1 thru 9), the AI Oracle, and the Orchestrator. The system should function as a **drop-in agent** that autonomously adapts to the provided Python context.
3.  **Autonomous Contract Synthesis:** Future expansions should prioritize AI-driven inference for memory and execution contracts instead of manual configuration bridges.
4.  **Mandatory Triple-Verification:** Once a benchmark or test completes successfully, you MUST triple-check that the RepoOS bare-metal kernel was actually executed. 
    *   **Audit logs:** Ensure "Invoking Bare-Metal Kernel" appears in the output.
    *   **Fallback Detection:** Verify the system did not silently fallback to native Python.

---

## 🛠 Prerequisites
 & Environment

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

### 1. Semantic Ingestion & Deterministic Lowering (`component1_ingest.py` & `ast_to_mlir.py`)
Parses Python source code, extracts pure logic chunks, and deterministically lowers them to baseline MLIR (`ast_to_mlir.py`). This baseline is then stored in the Neo4j Semantic Graph as the Ground Truth.
*   **Example:** Ingest the NetworkX PageRank algorithm.
```bash
./build_venv/bin/python3 component1_ingest.py venv/lib/python3.9/site-packages/networkx/algorithms/link_analysis/pagerank_alg.py
```

### 2. AOT Compilation & Formal Optimization (`component9_aot.py`, `component2_smt.py`, `compiler_passes.py`)
Retrieves the deterministic baseline MLIR from Neo4j. It queries Gemini as an **Optimization Oracle** for tuning heuristics (e.g., unroll factor) and deterministically applies them (`compiler_passes.py`). The optimized graph is formally verified by Z3 before being lowered to LLVM IR using the Bare Pointer Calling Convention and compiled to `.dylib`.
*   **Example:** Compile all detected chunks for the NetworkX package.
```bash
REPOOS_CACHE_DIR=.poly_cache_networkx \
REPOOS_MANUAL_CACHE_DIR=.poly_cache_manual \
./build_venv/bin/python3 component9_aot.py networkx
```

### 3. Metadata-Driven Orchestration (`component5_orchestrator.py`)
Intercepts Python execution at runtime. Utilizing the `VerifiedMLIR.config` contract stored in Neo4j (or manually injected), it dynamically devirtualizes complex objects (like NetworkX CSR Graphs), handles buffer initializations, and hot-swaps to the native kernel without hardcoded application logic.

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

## 📊 Performance Suite

### A. NetworkX Cumulative Distribution Benchmark
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

### B. PageRank CSR Benchmark
Validates high-performance graph processing using CSR devirtualization with 100% mathematical correctness.

**Run Command:**
```bash
export PYTHONPATH=/Users/yeshr/Applications/Program1/llvm-project/build/tools/mlir/python_packages/mlir_core:/Users/yeshr/Applications/Program1
export DYLD_LIBRARY_PATH=/opt/homebrew/opt/expat/lib:/Users/yeshr/Applications/Program1/llvm-project/build/lib
REPOOS_CACHE_DIR=.poly_cache_networkx \
REPOOS_MANUAL_CACHE_DIR=.poly_cache_manual \
./build_venv/bin/python3 component8-pagerank.py
```
*   **Success Criteria:** RepoOS should show a **~2.0x Speedup** and **~70% Memory Reduction** for 20,000 nodes.

### C. NanoGPT Sub-Component Benchmarks (Milestone 8.3)
Validates the compilation of entire LLM inference blocks on the CPU (incorporating Map-Reduce tiling, C Math Library linkage for transcendental functions, and dynamic Causal Masking).

**Environment Setup:**
Before running the benchmarks, you must export the MLIR and LLVM shared library paths:
```bash
export PROJECT_ROOT=$(pwd)
export PYTHONPATH="$PROJECT_ROOT/llvm-project/build/tools/mlir/python_packages/mlir_core:$PROJECT_ROOT"
export PYTHONPATH="$PROJECT_ROOT/torch-mlir/build/tools/torch-mlir/python_packages/torch_mlir:$PYTHONPATH"
export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:$PROJECT_ROOT/llvm-project/build/lib"
```

**Run Commands:**
To clear the cache and compile each component natively:

1. **Softmax Kernel (Reduction Tiling):**
```bash
rm -rf .poly_cache/softmax_*
./build_venv/bin/python3 benchmark_softmax.py
```

2. **GELU/MLP Kernel (Transcendental Math):**
```bash
rm -rf .poly_cache/gelu_*
./build_venv/bin/python3 benchmark_gelu.py
```

3. **Full NanoGPT Block (Self-Attention + LayerNorm + MLP):**
```bash
rm -rf .poly_cache/fullblock_*
./build_venv/bin/python3 benchmark_full_block.py
```

* To test a specific compiled variant on a custom sequence length without recompiling, use the `--measure` flag:
```bash
./build_venv/bin/python3 benchmark_full_block.py --measure .poly_cache/fullblock_v1.so 2048
```
---

## 🏗 Detailed Lowering Flow (Step-by-Step)

The RepoOS pipeline is a multi-stage bridge that transforms high-level Python intent into hardware-optimized machine code.

### 1. Semantic Ingestion (Source to Graph)
*   **Trigger**: `./repoos.sh <script> <package>` calls `component1_ingest.py`.
*   **Resolution**: Resolves the package name to its actual `.py` file path (even inside venvs).
*   **Parsing**: Uses **Tree-sitter** to parse Python source into an AST.
*   **Storage**: AST metadata, code, and signatures are stored in **Neo4j**, serving as the "Ground Truth."

### 2. AI Frontend Synthesis (Intent to Tracing)
*   **Kernel Synthesis**: **Gemini 2.5 Pro** analyzes legacy Python and synthesizes a `torch.nn.Module` (the "Kernel Wrapper") containing the mathematical core.
*   **Data Bridge Synthesis**: AI generates `prep_inputs` (Object-to-Tensor) and `post_process` (Tensor-to-Object) scripts for universal devirtualization.

### 3. Deterministic Tracing (Torch to MLIR)
*   **Capture**: **`torch-mlir`** executes the wrapper with AI-generated sample inputs, tracing the math into a stable **MLIR graph** (`linalg-on-tensors`).

### 4. Bufferization (Tensors to Pointers)
*   **Lowering**: High-level immutable Tensors are lowered to explicit memory pointers (MemRefs) via the `mlir-opt` `-one-shot-bufferize` pass.

### 5. AI Optimization Oracle
*   **Oracle Analysis**: Gemini reviews the raw MLIR and writes a **Transform Dialect** script specifically for the target hardware (e.g., Apple Silicon).
*   **Optimization**: Applies **Tiling** (L1 Cache alignment), **SIMD Vectorization** (NEON), and **Loop Unrolling**.

### 6. Backend Compilation (MLIR to Binary)
*   **Translation**: `mlir-translate` converts the optimized graph into **LLVM IR**.
*   **Sanitization**: A custom sanitizer strips incompatible LLVM attributes to ensure stability with the system `clang`.
*   **Binary**: `clang` compiles the sanitized IR into a native **`.dylib`**.

### 7. Runtime Orchestration (The Drop-in Swap)
*   **Hijacking**: `component6` intercepts imports and attaches "Shadow Trampolines" to target functions.
*   **Execution**: `component5` runs the `prep_inputs` script, maps buffers to **zero-copy MemRef Descriptors**, invokes the native kernel, and revirtualizes the result via `post_process`.

---

## 🔧 Component Overview

| Component | Name | Responsibility |
| :--- | :--- | :--- |
| **ast_to_mlir** | Builder | Deterministic AST-to-MLIR Visitor |
| **compiler_passes**| Optimizer | Deterministic application of LLM heuristics |
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

### Unified Execution via `repoos.sh`
The `repoos.sh` script is the primary entry point for the RepoOS drop-in agent. It handles ingestion, tracing, optimization, and hijacked execution in a single command.

### Benchmark (Uses Dynamic FFI to execute the kernel and compare vs NumPy)
./build_venv/bin/python3 component8-pagerank-v2-benchmark.py

### Ubuntu OS Run Command
To run the AOT compilation pipeline on Ubuntu:
```bash
export PYTHONPATH=/home/yeshr/repoos/projectrepo/torch-mlir/build/tools/torch-mlir/python_packages/torch_mlir && ./build_venv/bin/python3 component9_aot.py test_tracks
```

### Benchmarking and Validation
We provide a specialized tool, `run_mlir.py`, to compare the AI's raw output against fixed/corrected versions.

**Usage:**
```bash
./build_venv/bin/python3 run_mlir.py <function_name>
```
Example: `./build_venv/bin/python3 run_mlir.py fsm_hotspot`

**Folder: `generated/`**
This folder contains the code fragments used for comparison:
*   `<func>_actual.txt`: The raw code synthesized by the AI (extracted from oracle logs).
*   `<func>_corrected.txt`: The manually or programmatically fixed version that resolves tracing or syntax issues.

The `run_mlir.py` script automatically identifies the track (Torch, C++, or MLIR), executes both versions, and displays a comparison table showing execution time and the returned response.

## 🧠 Python Scheduling Architecture (Milestone 7.4)

RepoOS now features a high-safety **Inference Track** that uses a Python-based DSL for GPU auto-tuning. This architecture strictly separates the **Algorithm** from the **Schedule**.

### 1. The Algorithm (Strictly Deterministic)
Captured programmatically from PyTorch FX graphs via `torch-mlir`. This ensures 100% mathematical fidelity.

### 2. The Schedule (AI-Driven DSL)
Instead of writing raw MLIR text, the Gemini Oracle generates Python scripts using the `RepoOSSchedule` API:
*   `schedule.match(op)`
*   `schedule.tile_to_blocks(target, sizes)`
*   `schedule.tile_to_threads(target, sizes)`
*   `schedule.vectorize(target)`

### 3. Syntax Safety & Fallback
The Python DSL acts as a validator, making it physically impossible for the AI to generate invalid MLIR syntax. If an optimization variant fails to compile (e.g. unsupported vectorization), the system safely falls back to the verified base kernel.

Intermediate stages are preserved in `build_artifacts/` for debugging:
*   `inference_base.mlir`: captured math.
*   `inference_payload.mlir`: math + AI schedule.
*   `inference_optimized.mlir`: tiled and mapped IR.
*   `inference_final.mlir`: final GPU IR.


## Inference Benchmark
*   `export PYTHONPATH=$PYTHONPATH:/home/yeshr/repoos/projectrepo/torch-mlir/build/tools/torch-mlir/python_packages/torch_mlir && ./build_venv/bin/python3 test_inference.py`
*   `export PYTHONPATH=$PYTHONPATH:/home/yeshr/repoos/projectrepo/torch-mlir/build/tools/torch-mlir/python_packages/torch_mlir && ./build_venv/bin/python3 benchmark_variants.py`

## 💻 CPU with Python Validation

To run and validate the revenue validation application on CPU, follow these 5 steps from the repository root:

1. **Start the MySQL Database:**
   ```bash
   docker compose -f revenue_app/docker-compose.yml up -d
   ```

2. **Install Dependencies:**
   ```bash
   ./build_venv/bin/pip install -r revenue_app/requirements.txt
   ```

3. **Start the Legacy API Server (port 8080):**
   ```bash
   ./build_venv/bin/python3 -m legacy_shop.api_server
   ```

4. **Start the Background Job:**
   ```bash
   ./build_venv/bin/python3 -m revenue_app.job
   ```

5. **Start the New API Server (port 8000):**
   ```bash
   ./build_venv/bin/uvicorn revenue_app.main:app --host 127.0.0.1 --port 8000
   ```

## 🚀 Compiling and Benchmarking with RepoOS

To test the RepoOS dynamic compiler and benchmarking tool on the `revenue_app`, you can use the provided bash scripts.

**1. Compile the application via RepoOS:**
Provide the database credentials and target table via environment variables so the Oracle can infer the schema dynamically, then run the compiler:
```bash
DATABASE_URL="mysql+pymysql://revenue_user:revenue_password@127.0.0.1:3306/revenue_db" TARGET_TABLE="revenue_details" ./repoos.sh revenue_app/main.py revenue_app.main.get_revenue
```

**2. Run the Benchmark Tool (e.g., 100 iterations):**
This script will execute the original Python function natively and then run it through the compiled RepoOS zero-overhead L7 interceptor kernel to display performance differences:
```bash
./benchmark.sh revenue_app/main.py revenue_app.main.get_revenue 100
```