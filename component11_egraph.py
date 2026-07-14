import repoos_egg_bindings as egg

def optimize_branching_ir(s_expr_ir: str) -> str:
    """
    Ingests the LLM-generated S-expression, applies Equality Saturation, 
    and extracts the optimal branchless structure.
    """
    print("[E-Graph] 🌳 Initializing Equality Saturation Engine...")
    
    # Define our mathematical and control-flow rewrite rules
    rewrite_rules = [
        # Branchless arithmetic conversion (if -> select)
        egg.Rewrite(
            name="if-to-select",
            searcher="(if ?cond (assign ?var ?val1) (assign ?var ?val2))",
            applier="(assign ?var (select ?cond ?val1 ?val2))"
        ),
        # Constant folding for boolean logic
        egg.Rewrite(
            name="fold-not-not",
            searcher="(not (not ?a))",
            applier="?a"
        ),
        # Flattening nested exact matches
        egg.Rewrite(
            name="flatten-nested-ifs",
            searcher="(if ?cond1 (if ?cond2 ?then ?else) ?else)",
            applier="(if (and ?cond1 ?cond2) ?then ?else)"
        )
    ]
    
    # Create the E-graph, add the LLM's IR, and run saturation
    runner = egg.Runner(rewrite_rules)
    root_id = runner.add_expr(s_expr_ir)
    runner.run()
    
    # Extract the AST with the lowest CPU cost (prioritizing branchless ops)
    extractor = egg.Extractor(runner, cost_function="cpu_cycles")
    best_cost, optimized_s_expr = extractor.extract(root_id)
    
    print(f"[E-Graph] ✅ Extraction Complete. Cost reduced to: {best_cost}")
    return optimized_s_expr
