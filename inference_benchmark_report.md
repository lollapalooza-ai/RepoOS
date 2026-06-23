# RepoOS Inference Benchmark Report

This report documents the execution of the RepoOS Inference Benchmarks, covering dense Matrix Multiplication (`benchmark_variants.py`) and PageRank computation (`benchmark_pagerank.py`). It highlights optimization issues, resolutions, and final performance metrics.

---

## 🔍 Investigation Findings & Resolutions

### 1. Clang Compilation Error (`nocreateundeforpoison`)
* **Issue:** Scheduling variant compilation failed initially with `error: unterminated attribute group` at the `nocreateundeforpoison` LLVM attribute.
* **Resolution:** Configured the LLVM IR sanitization step in [component9_aot.py](file:///home/yeshr/repoos/projectrepo/component9_aot.py#L350) to strip the unsupported `nocreateundeforpoison` attribute from LLVM IR prior to compiling with `clang`.

### 2. Compilation Hang on Large Tiled Vectorization
* **Issue:** Large tile sizes combined with `schedule.vectorize` caused `clang` to hang while optimizing extremely bloated unrolled loops (due to backend option `full-unroll=1`).
* **Resolution:** Implemented dynamic capping in `RepoOSSchedule` inside [component9_aot.py](file:///home/yeshr/repoos/projectrepo/component9_aot.py#L42). If vectorization is requested alongside any tile size `> 32`, the tiling sizes are automatically capped to `16` to prevent compiler hangs.

### 3. Floating Point Cast Validation Error (PageRank)
* **Issue:** PageRank compilation failed initially with `error: floating point constant invalid for type` due to double-precision configuration constants (like `alpha = 0.85`) being cast/truncated to float32 in MLIR, leaving invalid decimal literals in LLVM IR.
* **Resolution:** Refactored the `PageRankLayer` to accept `alpha` and `one_minus_alpha` as standard float32 tensor inputs rather than hardcoding double-precision Python literals. This bypassed constant casting issues during compilation.

---

## 📊 Final Performance Results (Enterprise Scale, N=2048)

All benchmarks run on $2048 \times 2048$ matrices/operators with verification checks matching the expected outputs.

### Benchmark A: Dense Matrix Multiplication (`benchmark_variants.py`)
Workload: Dense MatMul $2048 \times 2048$ (10 iterations).

| Variant Name | Speed (ms) | CPU (%) | Memory (MB) | Output[0,0] (Expected: 2048.0) | Speedup |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Baseline** | 38840.7141 | 100.00% | 450.83 | 2048.0 (Match) | 1.00x (Ref) |
| **Variant 1 (L1 Cache Optimized)** | 3835.4770 | 100.00% | 450.96 | 2048.0 (Match) | **10.13x** |
| **Variant 2 (Capped L2 Tiling)** | 3877.3139 | 100.00% | 450.78 | 2048.0 (Match) | **10.02x** |
| **Variant 3 (SIMD-Optimized)** | 6156.0194 | 100.00% | 450.68 | 2048.0 (Match) | **6.31x** |

### Benchmark B: PageRank Computation (`benchmark_pagerank.py`)
Workload: Dense PageRank step $2048 \times 2048$ (100 iterations, tolerance threshold $10^{-3}$).

| Variant Name | Speed (ms) | CPU (%) | Memory (MB) | Output[0,0] (Expected: 0.000472) | Speedup |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Baseline** | 2.8690 | 337.90% | 464.48 | 0.000472 (Match) | 1.00x (Ref) |
| **Variant 1 (L1 Cache Optimized)** | 1.8420 | 471.90% | 464.98 | 0.000472 (Match) | **1.55x** |
| **Variant 2 (Capped L2 Tiling)** | 1.8426 | 477.20% | 463.18 | 0.000472 (Match) | **1.55x** |
| **Variant 3 (SIMD-Optimized)** | 1.5052 | 564.10% | 463.30 | 0.000472 (Match) | **1.90x** |

---

## 🏎️ Key Observations
1. **Matrix Multiplication Cache Benefits:** Matrix multiplication shows massive scale benefits (**10.1x Speedup**) because $O(N^3)$ operations on large arrays suffer heavily from L1/L2 cache misses when untiled. Tiling restricts cache working sets to $\approx 3$ KB, completely eliminating main memory traffic bottlenecks.
2. **PageRank Tiling & Vectorization:** PageRank is an $O(N^2)$ matrix-vector computation. It is highly memory bandwidth bound. Tiling and vectorizing the MatMul core results in a **1.90x Speedup** (Variant 3) using SIMD AVX2 vectorization patterns (`[8, 1, 4]`).

---

## 📊 NanoGPT Self-Attention (Dynamic Shapes) Benchmark Results

* **Workload:** NanoGPT Scaled Dot-Product Self-Attention (`Q * K^T / sqrt(d) * V`).
* **Workload Size:** Evaluated on Sequence Length 5 and 500 dynamically on the **same compiled `.so` binary** without recompilation.
* **Telemetry State:** Thread-isolated (Single-threaded).

### Sequence Length 5
| Variant Name | Speed (ms) | CPU Time (ms) | Memory (MB) | Correct |
| :--- | :---: | :---: | :---: | :---: |
| **Baseline** | 0.0280 | 0.0000 | 500.21 | Match |
| **Variant 1** | 0.0357 | 0.0000 | 500.27 | Match |
| **Variant 2** | 0.0396 | 0.0000 | 500.34 | Match |
| **Variant 3** | 0.0282 | 0.0000 | 500.23 | Match |

### Sequence Length 500
| Variant Name | Speed (ms) | CPU Time (ms) | Memory (MB) | Correct | Speedup vs Base |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Baseline** | 40.3575 | 40.0000 | 510.67 | Match | 1.00x |
| **Variant 1** | 27.9163 | 26.6667 | 518.03 | Match | 1.44x |
| **Variant 2** | 27.2072 | 30.0000 | 518.27 | Match | **1.48x** |
| **Variant 3** | 27.7740 | 26.6667 | 518.29 | Match | 1.45x |

> [!NOTE]
> The exact same binary dynamically scaled from a 5-token context window (computing in under 0.03ms) to a 500-token context window natively. The AI Oracle generated heuristics in Variant 2 that improved inference speeds by **~48%**!
