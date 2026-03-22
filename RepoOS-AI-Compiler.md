# DESIGN DOCUMENT: Repo OS Poly-Kernel (v1.0 - v2.5)

## 1. Architectural Vision
The goal of the Poly-Kernel is to decouple **Business Intent** (High-level Python) from **Hardware Execution** (Native Machine Code). It treats a source code repository not as a set of files, but as a **Semantic Graph** that can be dynamically "lowered" into verified silicon instructions on demand.

---

## 2. Component Breakdown & Diagrams

### [Component 1] The Generic Ingestor (Semantic Ground Truth)
**Functionality:** Performs AST parsing via Tree-sitter and extracts function signatures.
```mermaid
graph TD
    A[Source Code .py] -->|Tree-sitter| B[AST Parsing]
    B -->|ast.walk| C[Extract Arg Counts]
    C -->|Cypher MERGE| D[(Neo4j Semantic Graph)]
    B -->|Map Dependencies| D
```

### [Component 2] The Formal Verification Bridge (SMT & LLM)
**Functionality:** AI translation of logic verified by mathematical safety proofs.
```mermaid
graph LR
    A[Intent/Code] -->|Prompt| B[LLM deepseek-coder-v2]
    B -->|MLIR JSON| C{Z3 SMT Solver}
    C -->|Failure| D[Error Feedback Loop]
    D -->|Refine| B
    C -->|Success| E[Verified MLIR]
```

### [Component 3] The Semantic API (Human Visualizer)
**Functionality:** Translates complex machine state into human-readable business logic.
```mermaid
graph TD
    A[Developer/Auditor] -->|GET /api/projection| B[FastAPI]
    B -->|Query| C[(Neo4j)]
    C -->|Source Code + Deps| B
    B -->|IDE View| A
```

### [Component 4] The Persistent JIT Engine (The Synthesis Layer)
**Functionality:** A two-pass compiler synthesizing native machine code in RAM.
```mermaid
graph TD
    A[Verified MLIR] -->|Pass 1| B[Label/Block Allocation]
    B -->|Pass 2| C[Instruction Synthesis]
    C -->|LLVM IR| D[MCJIT Engine]
    D -->|Native Pointer| E[System RAM]
```

### [Component 5] The Trampoline Mesh (The Control Plane)
**Functionality:** Manages the function lifecycle and hot-patches memory addresses.
```mermaid
sequenceDiagram
    User->>Trampoline: Call Function()
    Trampoline->>Orchestrator: TRAP (1st Call)
    Orchestrator->>AI/JIT: Compile to Native
    AI/JIT-->>Orchestrator: Native RAM Pointer
    Orchestrator->>Trampoline: Hot-Patch Address
    Trampoline->>CPU: Direct Native Execution
```

### [Component 6] The Import Hijacker (OS Layer)
**Functionality:** Overwrites the Python `import` mechanism to intercept code loading.
```mermaid
graph LR
    A[import legacy_shop] -->|sys.meta_path| B[Hijacker Finder]
    B -->|Loader| C[C1 Ingestion]
    C -->|Register| D[C5 Trampolines]
    D -->|Return Module| E[Python Runtime]
```

### [Component 7] Telemetry Dashboard (The Profiler)
**Functionality:** Real-time performance matrix visualization.
```mermaid
graph TD
    A[JIT Warm Run] --> B[Telemetry]
    C[CPython Baseline] --> B
    B -->|Rich Table| D[Terminal UI Dashboard]
```

### [Component 8] Macro-Benchmark (Zero-Copy I/O)
**Functionality:** High-speed FSM scanner operating on raw TCP buffers.
```mermaid
graph LR
    A[API Server] -->|Raw Bytes| B[TCP Buffer]
    B -->|Direct Ptr| C[LLVM FSM Kernel]
    C -->|Sum| D[Result]
    style B fill:#f9f,stroke:#333,stroke-width:4px
```

### [Component 9] AOT Shadow Compiler (The Build Step)
**Functionality:** Background worker that pre-compiles the entire repo to disk.
```mermaid
graph TD
    A[(Neo4j)] -->|Scan All| B[C9 Build Step]
    B -->|Verified MLIR| C[/.poly_cache/]
    D[C5 Orchestrator] -->|Fast Path| C
```

---

## 3. System-Wide Integration Map

This diagram shows how all components work together to form the Zero-Binary pipeline.

```mermaid
graph TD
    subgraph OS_LAYER [Operating System Layer]
        C6[C6: Import Hijacker]
    end

    subgraph KERNEL [Poly-Kernel Core]
        C5[C5: Orchestrator]
        C4[C4: JIT Engine]
        C9[C9: AOT Cache]
    end

    subgraph BRAIN [The Verification Bridge]
        C2[C2: LLM + Z3]
    end

    subgraph DATA [Semantic Graph]
        C1[C1: Ingestor]
        DB[(Neo4j)]
    end

    subgraph PROFILING [Monitoring]
        C7[C7: Telemetry]
        C8[C8: Macro Benchmark]
    end

    %% Flow
    C6 -->|Traps Import| C1
    C1 -->|Stores| DB
    C5 -->|Checks Cache| C9
    C5 -->|Fallback| C2
    C2 -->|Queries| DB
    C2 -->|Feeds| C4
    C4 -->|Hot-Patches| C5
    C5 -->|Reports| C7
    C8 -->|Stresses| C4
```

## 4. Final System State
The Repo OS is now a **Universal AI-JIT**. It can take any "Legacy" Python repository, mathematically verify its business rules, and execute them as high-performance, zero-copy native kernels without the user ever writing a single line of C or LLVM.
