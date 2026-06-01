# RepoOS Current State & TODOs

## Current State Summary
Milestone 5 (Transform Dialect Architecture) has been successfully proven end-to-end for the PageRank benchmark (achieving a 225x speedup at 50,000 nodes). The **ABI Bridge has been fully generalized** via a dynamic FFI in the Orchestrator. However, due to environment-specific bugs in `torch-mlir` on macOS arm64, the tracing phase is currently hardcoded for the PageRank mathematical signature.

---

## 🔴 What is Hardcoded (PageRank Specific)

1. **The Tracer (`component1b_tracer.py`):**
   * **The Compromise:** The generalized `torch_mlir.fx.export_and_import` failed due to local C++ assertion failures in LLVM/Torch.
   * **The Hardcoding:** `trace_to_base_mlir` programmatically constructs the exact MLIR AST (using `scf.for`, `memref.load`, etc.) specifically for the CSR PageRank mathematical signature. It bypasses Python AST parsing entirely.

### Proposed Solution :
Subject: Unblocking torch-mlir via Linux DevContainers

Context:
We are officially targeting Linux for the RepoOS production deployment. Because torch-mlir is highly stable on Linux, we will retain it as our primary tracer. To bypass the Apple Silicon bad_weak_ptr crash locally, we are shifting our local development environment into a Dockerized Linux DevContainer.

Please implement the following steps to containerize the local workspace.

Step 1: Create the Standardized Dockerfile
In the root of the repository, create a Dockerfile. We will use a standard Ubuntu image and install the pre-built Linux wheels for PyTorch and torch-mlir. (You no longer need to build torch-mlir from source).

Dockerfile
# Dockerfile
FROM ubuntu:22.04

# Prevent interactive prompts during apt installations
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies (LLVM, Clang, Python)
RUN apt-get update && apt-get install -y \
    python3.10 python3.10-venv python3-pip \
    clang lld cmake ninja-build git \
    && rm -rf /var/lib/apt/lists/*

# Set up the workspace
WORKDIR /repoos

# Create a virtual environment and install standard Python MLIR/Torch packages
RUN python3.10 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install PyTorch and torch-mlir (Linux wheels are highly stable)
RUN pip install --upgrade pip && \
    pip install torch torchvision --index-url https://download.pytorch.org/whl/cpu && \
    pip install torch-mlir
    
# Install the rest of the RepoOS requirements (Neo4j, google-genai, etc.)
COPY requirements.txt .
RUN pip install -r requirements.txt

# Keep container running for remote development
CMD ["tail", "-f", "/dev/null"]
Step 2: Set up VS Code DevContainers (The seamless bridge)
To ensure you don't have to manually docker exec every time you want to run a script, use VS Code's DevContainer feature. This mounts your Mac's filesystem directly into the Linux container.

Create a .devcontainer folder in the root directory, and add a devcontainer.json file:

JSON
{
    "name": "RepoOS Linux Environment",
    "build": {
        "dockerfile": "../Dockerfile"
    },
    "customizations": {
        "vscode": {
            "extensions": [
                "ms-python.python",
                "ms-python.vscode-pylance"
            ]
        }
    },
    "remoteUser": "root",
    "workspaceMount": "source=${localWorkspaceFolder},target=/repoos,type=bind,consistency=cached",
    "workspaceFolder": "/repoos"
}
Step 3: Revert to the Clean Architecture
Now that you are executing inside a Linux kernel, the torch-mlir C++ backend will behave perfectly.

Open VS Code.

Click "Reopen in Container" (Requires the "Dev Containers" extension and Docker Desktop).

Revert component1b_tracer.py back to the generalized torch_mlir.compile(func) logic.

Python
# component1b_tracer.py (Restored to fully generalized state)
import torch
import torch_mlir

def trace_to_base_mlir(func, sample_args) -> str:
    # This will now succeed silently and instantly on your Mac (via Linux Docker)
    module = torch_mlir.compile(
        func, 
        sample_args, 
        output_type=torch_mlir.OutputType.LINALG_ON_TENSORS
    )
    return str(module)

---

## 🟢 What is Fully Generalized (Works for Any Code)

1. **The ABI Bridge (Dynamic FFI) (`component5_orchestrator.py`):**
   * **Generalization Complete:** The Orchestrator now dynamically inspects Python arguments at runtime and constructs the appropriate MLIR `MemRef` descriptors for any tensor rank. It automatically maps scalars and pointers to the native C-Interface of the compiled kernels.
2. **The AI Optimization Oracle (`component2_smt.py`):**
   * The Gemini prompt takes *any* baseline MLIR string and returns a hardware-specific Transform Dialect script. It optimizes generic loops and memory accesses.
3. **The Native AOT Compiler (`component9_aot.py`):**
   * The lowering pipeline is standard. It compiles *any* valid Linalg/MemRef MLIR into a highly optimized C-compatible `.dylib` using C-Wrappers.
4. **The Neo4j Ingester (`component1_ingest.py`):**
   * Successfully parses arbitrary Python files, maps their ASTs, and registers them into the graph database.

---

## 🛣️ Actionable TODOs (The Path to a Fully Generalized RepoOS)

- [ ] **Fix or Swap the Tracer:** 
  Resolve the `torch-mlir` crashes. This may require moving the build to a stable Linux/Docker environment where `torch.export` and `torch-mlir` are fully supported without `bad_weak_ptr` crashes. Once `torch_mlir.compile(func)` works reliably, RepoOS will automatically trace any Python logic into MLIR.
- [x] **Dynamic FFI in the Orchestrator:** 
  Implemented a dynamic Foreign Function Interface that handles arbitrary tensor ranks and scalar types at runtime.
- [ ] **General Control Flow Support:** 
  Expand the compilation pipeline beyond linear algebra (`linalg`). General-purpose Python code requires compiling to standard `scf` (Structured Control Flow) and `cf` (Control Flow) dialects.
