#!/bin/bash

# RepoOS Unified CLI Wrapper
# Usage: ./repoos.sh <filename.py> <target_package_or_fqn> [--skip-compile]

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
export DYLD_LIBRARY_PATH="/opt/homebrew/opt/expat/lib:$PROJECT_ROOT/llvm-project/build/lib"

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
