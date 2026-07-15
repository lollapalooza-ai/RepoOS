#!/bin/bash

# RepoOS A/B Benchmark Runner
# Usage:
#   Inference Track: ./benchmark.sh inference <filename.py>
#   Standard Track:  ./benchmark.sh <filename.py> <target_fqn>

if [ "$1" == "inference" ]; then
    MODE="inference"
    SCRIPT=$2
    TARGET=""
else
    MODE="standard"
    SCRIPT=$1
    TARGET=$2
fi

if [ -z "$SCRIPT" ]; then
    echo "Usage: $0 [inference] <filename.py> [target_fqn]"
    exit 1
fi

echo "--- 🚀 RepoOS A/B Benchmark Tool ---"
echo "Target Script: $SCRIPT"
echo "Track Mode:    $MODE"
echo "-------------------------------------"

./build_venv/bin/python3 benchmark_collector.py "$MODE" "$SCRIPT" "$TARGET" "${@:3}"
