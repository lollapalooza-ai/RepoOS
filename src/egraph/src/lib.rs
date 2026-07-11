use egg::{rewrite as rw, *};
use pyo3::prelude::*;

// 1. Define the ProjectX 15-Op Micro-Primitives
define_language! {
    pub enum TensorLang {
        "matmul" = MatMul([Id; 2]),
        "add" = Add([Id; 2]),
        "softmax" = Softmax(Id),
        "fused_linear" = FusedLinear([Id; 3]),
        "flash_attention" = FlashAttention([Id; 3]),
        Symbol(Symbol),
    }
}

// 2. Define the Rewrite Rules
fn make_rules() -> Vec<Rewrite<TensorLang, ()>> {
    vec![
        // MatMul + Add -> FusedLinear
        rw!("fuse-linear"; "(add (matmul ?a ?b) ?bias)" => "(fused_linear ?a ?b ?bias)"),
        // BMM + Softmax + BMM -> FlashAttention
        rw!("flash-attn"; "(matmul (softmax (matmul ?q ?k)) ?v)" => "(flash_attention ?q ?k ?v)"),
    ]
}

// 3. Expose to Python orchestrator
#[pyfunction]
fn optimize_graph(expr_str: String) -> PyResult<String> {
    let expr: RecExpr<TensorLang> = expr_str.parse().unwrap();
    
    let mut runner = Runner::default().with_expr(&expr);
    let rules = make_rules();
    runner = runner.run(&rules);
    
    let extractor = Extractor::new(&runner.egraph, AstSize);
    let (_, best_expr) = extractor.find_best(runner.roots[0]);
    
    Ok(best_expr.to_string())
}

#[pymodule]
fn repo_os_egraph(_py: Python, m: &PyModule) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(optimize_graph, m)?)?;
    Ok(())
}
