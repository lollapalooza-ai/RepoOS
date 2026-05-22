from component2_smt import VerifiedMLIR, MLIROptimizationHeuristics

def apply_compiler_heuristics(baseline: VerifiedMLIR, heuristics: MLIROptimizationHeuristics) -> VerifiedMLIR:
    """
    Deterministically applies LLM heuristics to the MLIR graph without breaking SSA form.
    """
    optimized = baseline.model_copy(deep=True)
    
    # Example: Apply vectorization heuristics to operations
    if heuristics.vectorization_width > 1:
        for op in optimized.operations:
            # Only tag vectorizable ops (e.g., standard arithmetic)
            if op.dialect in ["arith", "math"] and "type" in op.attributes:
                # e.g., f64 -> vector<4xf64>
                base_type = op.attributes["type"]
                # Avoid re-vectorizing or applying to non-scalar types if already handled
                if not str(base_type).startswith("vector"):
                    op.attributes["type"] = f"vector<{heuristics.vectorization_width}x{base_type}>"
                    op.attributes["vectorized"] = True

    # Example: Apply loop unrolling flags for the MLIR-OPT pass
    if heuristics.loop_unroll_factor > 1:
        for op in optimized.operations:
            if op.dialect == "scf" and op.op == "for":
                op.attributes["unroll"] = heuristics.loop_unroll_factor

    return optimized
