# NetworkX Benchmarking Roadmap: RepoOS Stress Tests

This document outlines the strategic benchmarking roadmap for RepoOS, focusing on NetworkX algorithms that serve as stress tests for specific compiler capabilities.

## 🎯 The Principal Engineer's Strategic Roadmap

To rigorously prove RepoOS's enterprise value, we select benchmarks that act as **Stress Tests for specific compiler capabilities**.

### Category 1: Complex Control Flow & Branching
*Tests for `scf.while`, deep `scf.if`, and dynamic memory jumps.*
*   **[x] `nx.betweenness_centrality()` (The Final Boss)**
    *   **Bottleneck:** $O(V \cdot E)$. Requires shortest path calculations from every node and fractional path tracking.
    *   **Strategy:** AoS-to-SoA transformation of path-tracking queues into bounded `memref` ring buffers.
    *   **Goal:** Prove compilation of complex state machines to bare metal.
    *   **Result:** ✅ **15.5x Speedup** achieved with 100% mathematical parity. Successfully implemented generalized graph parameter mappings in the orchestrator via JSON metadata.
*   **[ ] `nx.single_source_dijkstra()`**

    *   **Result:** ✅ **>15x Speedup** achieved with 100% mathematical parity. Successfully implemented generalized graph parameter mappings in the orchestrator via JSON metadata.
*   **[ ] `nx.single_source_dijkstra()`**
    *   **Bottleneck:** Priority Queue (Min-Heap) maintenance.
    *   **Strategy:** Allocate a flat C-array as a binary heap; implement `heapify` and `extract_min` logic natively in MLIR.
    *   **Goal:** Beat Python's C-based `heapq` by keeping the heap inside L1 Cache.

### Category 2: Dense Matrix Math (The LAPACK Replacements)
*Tests for pure arithmetic throughput and loop fusion.*

*   **[ ] `nx.eigenvector_centrality()`**
    *   **Bottleneck:** Power iteration method (repeated matrix-vector multiplication).
    *   **Strategy:** Devirtualize to Dense Adjacency Matrix (1D flat array) + Vector (1D array).
    *   **Goal:** Beat NumPy's C-backend by aggressively fusing loops and eliminating allocations.
*   **[ ] `nx.algebraic_connectivity()` (Fiedler Vector)**
    *   **Bottleneck:** Laplacian matrix calculation and eigenvalue finding.
    *   **Goal:** Test `math` dialect (sqrt, float precision) and deep matrix factorization.

### Category 3: Combinatorial & Intersection (Cache Thrashing)
*Tests for localized memory access and CPU cache optimization.*

*   **[ ] `nx.triangles()`**
    *   **Bottleneck:** Neighborhood intersection for every node.
    *   **Strategy:** CSR Array projection with parallel integer comparisons or bitwise SIMD.
    *   **Goal:** Outperform Python's $O(\min(N, M))$ hash-lookup `set()` intersections.
*   **[ ] `nx.louvain_communities()`**
    *   **Bottleneck:** Modularity optimization via constant node movement and connection density delta calculation.
    *   **Goal:** Simulate "Enterprise FinTech Risk Engine" logic (highly iterative, constant state updates).

---

## 🏛 The Architect's Pitch Deck Strategy

We focus on three definitive benchmarks to tell the complete engineering story:

1.  **`nx.pagerank` (The Baseline):** ✅ *COMPLETED*. Proves basic devirtualization and iterative math speed.
2.  **`nx.floyd_warshall` (The Brute Force):** Proves SIMD vectorization and $O(V^3)$ throughput.
3.  **`nx.betweenness_centrality` (The Final Boss):** Proves complex control flow and unpredictable memory access.

---

## 🔍 Additional Candidates Identified

*   **[ ] `hits()` (`link_analysis.hits_alg`):** Iterative Power Method computing Hubs and Authorities; dual CSR-matrix operations.
*   **[ ] `katz_centrality()` (`centrality.katz`):** Adds a constant bias term to eigenvector centrality; tests scalar-vector offsets.
*   **[ ] `clustering()` (`cluster`):** Neighborhood intersection primitive; benefits from sorted neighbor array devirtualization.
