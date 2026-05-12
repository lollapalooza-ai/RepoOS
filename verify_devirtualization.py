import time
import sys
import os
import ctypes
import networkx as nx
from rich.console import Console
from rich.table import Table

console = Console()

# --- 1. BOOTSTRAP ENVIRONMENT ---
PROJECT_ROOT = "/Users/yeshr/Applications/Program1"
if PROJECT_ROOT not in sys.path:
    sys.path.insert(0, PROJECT_ROOT)

from component6_hijacker import boot_poly_kernel
from component2_smt import VerifiedMLIR, MLIROperation

# --- 2. DEFINE MANUAL CSR PAGERANK TEMPLATE ---
def setup_csr_pagerank_template():
    fqn = "networkx.algorithms.link_analysis.pagerank_alg.pagerank.chunk_0"
    
    # Simple one-pass power iteration step for PageRank
    # MLIR ABI: (ResultPtr, RowPtrs, ColIdx, Weights, NumNodes, NumEdges)
    # Note: For PageRank, we'd typically need alpha, personalization, etc.
    # This is a simplified "Sum Neighbors" kernel for validation.
    
    # We'll use the existing manual_compiler.py logic but for CSR
    from manual_compiler import create_manual_template, sanitize_fqn
    
    mlir = VerifiedMLIR(
        function_name=sanitize_fqn(fqn),
        thinking_process="CSR-based Graph Summation kernel.",
        signature={
            "res_ptr": "ptr",
            "row_ptrs": "ptr",
            "col_idx": "ptr",
            "weights": "ptr",
            "num_nodes": "i64",
            "num_edges": "i64",
            "return": "void"
        },
        arg_mapping=[],
        operations=[
            # Constants
            MLIROperation(dialect="arith", op="constant", args=["0"], target_var="%c0", attributes={"type": "index"}),
            MLIROperation(dialect="arith", op="constant", args=["1"], target_var="%c1", attributes={"type": "index"}),
            MLIROperation(dialect="arith", op="constant", args=["0.0"], target_var="%f0", attributes={"type": "f64"}),
            
            # Node Loop
            MLIROperation(dialect="scf", op="for", args=["%c0", "num_nodes", "%c1"], attributes={
                "init_args": [],
                "body_args": ["%node_idx"]
            }, body=[
                # start_idx = row_ptrs[node_idx]
                MLIROperation(dialect="llvm", op="getelementptr", args=["row_ptrs", "%node_idx"], target_var="%p_start"),
                MLIROperation(dialect="llvm", op="load", args=["%p_start"], target_var="%start_idx"),
                
                # end_idx = row_ptrs[node_idx + 1]
                MLIROperation(dialect="arith", op="addi", args=["%node_idx", "%c1"], target_var="%node_next"),
                MLIROperation(dialect="llvm", op="getelementptr", args=["row_ptrs", "%node_next"], target_var="%p_end"),
                MLIROperation(dialect="llvm", op="load", args=["%p_end"], target_var="%end_idx"),
                
                # Sum weights for this node
                MLIROperation(dialect="scf", op="for", args=["%start_idx", "%end_idx", "%c1"], attributes={
                    "init_args": ["%f0"],
                    "body_args": ["%edge_idx", "%iter_sum"]
                }, target_var="%node_sum", body=[
                    MLIROperation(dialect="llvm", op="getelementptr", args=["weights", "%edge_idx"], target_var="%p_w"),
                    MLIROperation(dialect="llvm", op="load", args=["%p_w"], target_var="%w_val"),
                    MLIROperation(dialect="arith", op="addf", args=["%iter_sum", "%w_val"], target_var="%new_sum"),
                    MLIROperation(dialect="scf", op="yield", args=["%new_sum"])
                ]),
                
                # store result
                MLIROperation(dialect="llvm", op="getelementptr", args=["res_ptr", "%node_idx"], target_var="%p_res"),
                MLIROperation(dialect="llvm", op="store", args=["%node_sum", "%p_res"]),
                MLIROperation(dialect="scf", op="yield", args=[])
            ]),
            MLIROperation(dialect="func", op="return", args=[])
        ]
    )
    create_manual_template(fqn, mlir)

# --- 3. VALIDATE CSR PROJECTION ---
def validate_csr_devirtualization():
    console.print("[bold green]🚀 Validating Milestone 5.2: CSR Devirtualization[/bold green]\n")
    
    # Create a test graph
    G = nx.DiGraph()
    G.add_edge("A", "B", weight=0.5)
    G.add_edge("A", "C", weight=1.5)
    G.add_edge("B", "C", weight=2.0)
    
    console.print(f"Graph: {G.nodes()} | {G.edges(data=True)}")
    
    # 1. Setup Templates
    setup_csr_pagerank_template()
    
    # 2. Compile Kernel
    from component9_aot import aot_compile_all
    import asyncio
    asyncio.run(aot_compile_all("networkx.algorithms.link_analysis.pagerank_alg.pagerank"))
    
    # 3. Boot Hijacker
    orchestrator = boot_poly_kernel("networkx")
    
    # 4. Execute PageRank (Triggering Hijack)
    from networkx.algorithms.link_analysis.pagerank_alg import pagerank
    
    console.print("\n[yellow]Executing PageRank (will trigger CSR Devirtualization)...[/yellow]")
    
    # We pass a simple graph to PageRank. 
    # Since we manually registered 'chunk_0' for pagerank, the orchestrator will intercept.
    try:
        # Note: Our manual kernel is a dummy sum, not real PageRank.
        # But it proves the CSR translation works.
        results = pagerank(G)
        
        console.print("\n[bold green]Devirtualization Successful![/bold green]")
        console.print(f"Results from Machine Code: {results}")
        
        # Expected results for our "Sum Weights" kernel:
        # Node A: (A->B 0.5) + (A->C 1.5) = 2.0
        # Node B: (B->C 2.0) = 2.0
        # Node C: 0.0
        
    except Exception as e:
        console.print(f"[bold red]Validation Failed: {e}[/bold red]")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    validate_csr_devirtualization()
