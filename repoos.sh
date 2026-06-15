#!/bin/bash

# RepoOS Unified CLI Wrapper
# Usage: 
#   Standard Track (Neo4j):  ./repoos.sh <filename.py> <target_package_or_fqn> [--skip-compile]
#   Inference Track (Dynamo): ./repoos.sh inference <filename.py>

if [ "$1" == "inference" ]; then
    # --- INFERENCE TRACK (MILESTONE 7.4) ---
    if [ "$#" -lt 2 ]; then
        echo "Usage: $0 inference <filename.py>"
        exit 1
    fi
    FILENAME=$2
    
    PROJECT_ROOT=$(pwd)
    export REPOOS_CACHE_DIR="./.poly_cache"
    export PYTHONPATH="$PROJECT_ROOT/torch-mlir/build/tools/torch-mlir/python_packages/torch_mlir:$PROJECT_ROOT"
    
    echo "--- 🧠 RepoOS: Inference Track (Programmatic Dynamo Capture) ---"
    echo "Running: $FILENAME"
    
    # We use a specialized runtime hook to trigger the Dynamo backend
    ./build_venv/bin/python3 -c "
import torch
import torch._dynamo
from component10_dynamo import repoos_inference_backend
import runpy
import os

# Register the RepoOS Backend
torch._dynamo.register_backend(repoos_inference_backend)

# Wrap the execution context to use the compiler
def run_optimized():
    runpy.run_path('$FILENAME', run_name='__main__')

print('[CLI] Hijacking Torch to use RepoOS Python Scheduler...')
# Note: Users should use torch.compile(model, backend='repoos_inference_backend') inside their script
# but for universal testing, we can trigger it here if the script uses standard torch modules.
run_optimized()
"
    exit 0
fi

# --- STANDARD TRACK (Neo4j / Tree-Sitter) ---

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <filename.py> <target_package_or_fqn> [--skip-compile]"
    exit 1
fi

FILENAME=$1
TARGET=$2
SKIP_COMPILE=$3

# --- 1. BOOTSTRAP ENVIRONMENT ---
PROJECT_ROOT=$(pwd)
export REPOOS_CACHE_DIR="./.poly_cache"
export REPOOS_MANUAL_CACHE_DIR="./.poly_cache_manual"

# MLIR Core & Project Root
export PYTHONPATH="$PROJECT_ROOT/llvm-project/build/tools/mlir/python_packages/mlir_core:$PROJECT_ROOT"
# Torch-MLIR (for Tracing)
export PYTHONPATH="$PROJECT_ROOT/torch-mlir/build/tools/torch-mlir/python_packages/torch_mlir:$PYTHONPATH"
# Dynamic Libraries
export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:$PROJECT_ROOT/llvm-project/build/lib"

if [ "$SKIP_COMPILE" != "--skip-compile" ]; then
    echo "--- 🛠 RepoOS: Stage 1 (Semantic Ingestion) ---"
    echo "Targeting: $TARGET"
    ./build_venv/bin/python3 component1_ingest.py "$TARGET"

    if [ $? -ne 0 ]; then
        echo "❌ Semantic Ingestion failed."
        exit 1
    fi

    echo -e "\n--- 🛠 RepoOS: Stage 2 (AOT Trace-Optimize-Compile) ---"
    echo "Target Module/FQN: $TARGET"
    ./build_venv/bin/python3 component9_aot.py "$TARGET"

    if [ $? -ne 0 ]; then
        echo "❌ AOT Compilation failed."
        exit 1
    fi
else
    echo "--- ⏭ RepoOS: Skipping Ingestion & Compilation (Resuming from Cache) ---"
fi

echo -e "\n--- 🚀 RepoOS: Stage 3 (Drop-in Hijack & Execution) ---"
echo "Running: $FILENAME"
# Extract root package (e.g. 'networkx') for the hijacker
ROOT_PACKAGE=$(echo $TARGET | cut -d'.' -f1)
./build_venv/bin/python3 -c "from component6_hijacker import boot_poly_kernel; boot_poly_kernel('$ROOT_PACKAGE'); import runpy; runpy.run_path('$FILENAME', run_name='__main__')"
