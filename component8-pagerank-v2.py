import torch
import asyncio
import os
import sys

# --- 1. DEFINE VECTORIZED PAGERANK MODULE (GENERALIZED) ---
class PageRankModule(torch.nn.Module):
    def forward(self, x, M, alpha, p):
        # res = alpha * (M @ x) + (1-alpha) * p
        res = alpha * torch.mv(M, x) + (1.0 - alpha) * p
        return res

# Stage 1: Trace (Generates deterministic MLIR using torch-mlir.compile)
def run_tracing():
    from component1b_tracer import trace_to_base_mlir
    print("\n[1/3] Stage: Generalized Tracing (Milestone 5)...")
    
    # Sample data for tracing
    N = 8192
    x = torch.randn(N)
    M = torch.randn(N, N)
    alpha = torch.tensor(0.85)
    p = torch.randn(N)
    
    module = PageRankModule()
    # No more hardcoded MLIR! We are using the real tracer.
    base_mlir = trace_to_base_mlir(module, (x, M, alpha, p))
    
    with open("v2_pagerank_base.mlir", "w") as f: f.write(base_mlir)
    print(f"      ✅ Base MLIR generated from Python source.")

# Stage 2: Optimize & Compile
async def run_compilation():
    from component9_aot import apply_ai_transform_and_compile
    from neo4j import GraphDatabase
    import json

    print("\n[2/3] Stage: Applying Verified Vectorization Strategy...")
    if not os.path.exists("v2_pagerank_base.mlir"): return

    with open("v2_pagerank_base.mlir", "r") as f:
        base_mlir = f.read()

    # Verified Hardware-Optimal Vectorization Script (2D Tiling)
    transform_script = """
    module attributes {transform.with_named_sequence} {
      transform.named_sequence @__transform_main(%arg0: !transform.any_op) {
        %0 = transform.structured.match ops{["linalg.generic"]} in %arg0 : (!transform.any_op) -> !transform.any_op

        // Tile Rows (1) and Columns (8) to fit SIMD registers
        %tiled, %loops:2 = transform.structured.tile_using_for %0 tile_sizes [1, 8] : (!transform.any_op) -> (!transform.any_op, !transform.any_op, !transform.any_op)

        // Vectorize the hardware-friendly tile
        transform.structured.vectorize %tiled : !transform.any_op
        transform.yield
      }
    }
    """

    print("\n[3/3] Stage: Native Compilation...")
    output_dylib = os.path.abspath("./v2_pagerank_kernel.dylib")
    apply_ai_transform_and_compile(base_mlir, transform_script, output_dylib)

    # NEW: Register in Neo4j for the Drop-in Agent (Hijacker)
    NEO4J_URI = "bolt://localhost:7687"
    NEO4J_AUTH = ("neo4j", "password")
    fqn = "networkx.algorithms.link_analysis.pagerank_alg.pagerank"

    driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
    with driver.session() as session:
        session.run("""
            MERGE (f:Function {fqn: $fqn})
            SET f.optimized_dylib_path = $dylib,
                f.needs_recompile = false
        """, fqn=fqn, dylib=output_dylib)
    driver.close()

    print(f"      ✅ Kernel registered in Neo4j for FQN: {fqn}")
    print(f"\n🏆 SUCCESS: V2 Generalized Pipeline Complete.")


if __name__ == "__main__":
    if "--trace" in sys.argv:
        run_tracing()
    elif "--compile" in sys.argv:
        asyncio.run(run_compilation())
    else:
        print("Usage: python component8-pagerank-v2.py [--trace | --compile]")
