import os
import sys
import json
from neo4j import GraphDatabase
from component2_smt import VerifiedMLIR, MLIROperation

NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
OUTPUT_DIR = os.getenv("REPOOS_MANUAL_CACHE_DIR", "./.poly_cache_manual")

os.makedirs(OUTPUT_DIR, exist_ok=True)

def sanitize_fqn(fqn: str):
    for pkg in ["networkx", "legacy_shop", "django", "numpy", "scipy"]:
        if pkg in fqn:
            idx = fqn.find(pkg)
            return fqn[idx:].replace('.', '_').replace('-', '_')
    return fqn.replace('.', '_').replace('-', '_')

def create_manual_template(fqn: str, mlir_data: VerifiedMLIR):
    sanitized = sanitize_fqn(fqn)
    path = os.path.join(OUTPUT_DIR, f"{sanitized}.json")
    with open(path, 'w') as f:
        json.dump(mlir_data.model_dump(), f, indent=2)
    print(f"✅ Manual template written to {path}")

def setup_networkx_templates():
    # 1. CUMULATIVE_DISTRIBUTION
    cd_fqn = "networkx.utils.random_sequence.cumulative_distribution.chunk_0"
    cd_mlir = VerifiedMLIR(
        function_name=sanitize_fqn(cd_fqn),
        thinking_process="High-performance prefix sum kernel.",
        signature={
            "dist_ptr": "ptr",
            "cdf_ptr": "ptr",
            "size": "i64",
            "return": "f64"
        },
        arg_mapping=[],
        operations=[
            MLIROperation(dialect="arith", op="constant", args=["0"], target_var="%c0", attributes={"type": "index"}),
            MLIROperation(dialect="arith", op="constant", args=["1"], target_var="%c1", attributes={"type": "index"}),
            MLIROperation(dialect="arith", op="constant", args=["0.0"], target_var="%f0", attributes={"type": "f64"}),
            MLIROperation(dialect="arith", op="index_cast", args=["size"], target_var="%size_idx", attributes={"type": "index"}),
            
            # Step 1: Calculate Total Sum
            MLIROperation(dialect="scf", op="for", args=["%c0", "%size_idx", "%c1"], attributes={
                "init_args": ["%f0"],
                "body_args": ["%iv_sum", "%iter_sum"]
            }, target_var="%total_sum", body=[
                MLIROperation(dialect="llvm", op="getelementptr", args=["dist_ptr", "%iv_sum"], target_var="%p_dist"),
                MLIROperation(dialect="llvm", op="load", args=["%p_dist"], target_var="%val"),
                MLIROperation(dialect="arith", op="addf", args=["%iter_sum", "%val"], target_var="%new_sum"),
                MLIROperation(dialect="scf", op="yield", args=["%new_sum"])
            ]),
            
            # Step 2: Write CDF[0] = 0.0
            MLIROperation(dialect="llvm", op="getelementptr", args=["cdf_ptr", "%c0"], target_var="%p_cdf0"),
            MLIROperation(dialect="llvm", op="store", args=["%f0", "%p_cdf0"]),
            
            # Step 3: Prefix Sum Loop
            MLIROperation(dialect="scf", op="for", args=["%c0", "%size_idx", "%c1"], attributes={
                "init_args": ["%f0"],
                "body_args": ["%iv_prefix", "%current_sum"]
            }, target_var="%final_sum", body=[
                MLIROperation(dialect="llvm", op="getelementptr", args=["dist_ptr", "%iv_prefix"], target_var="%p_d"),
                MLIROperation(dialect="llvm", op="load", args=["%p_d"], target_var="%d_val"),
                MLIROperation(dialect="arith", op="addf", args=["%current_sum", "%d_val"], target_var="%next_sum"),
                
                # norm = next_sum / total_sum
                MLIROperation(dialect="arith", op="divf", args=["%next_sum", "%total_sum"], target_var="%norm"),
                
                # cdf[iv + 1] = norm
                MLIROperation(dialect="arith", op="addi", args=["%iv_prefix", "%c1"], target_var="%iv_next"),
                MLIROperation(dialect="llvm", op="getelementptr", args=["cdf_ptr", "%iv_next"], target_var="%p_c"),
                MLIROperation(dialect="llvm", op="store", args=["%norm", "%p_c"]),
                
                MLIROperation(dialect="scf", op="yield", args=["%next_sum"])
            ]),
            
            MLIROperation(dialect="func", op="return", args=[])
        ]
    )
    create_manual_template(cd_fqn, cd_mlir)

    # 2. ZIPF_RV MATH KERNEL
    zipf_fqn = "networkx.utils.random_sequence.zipf_rv.chunk_0"
    zipf_mlir = VerifiedMLIR(
        function_name=sanitize_fqn(zipf_fqn),
        thinking_process="Scalar math acceleration for zipf_rv.",
        signature={
            "alpha": "f64",
            "return": "f64"
        },
        arg_mapping=[],
        operations=[
            MLIROperation(dialect="arith", op="constant", args=["1.0"], target_var="%c1", attributes={"type": "f64"}),
            MLIROperation(dialect="arith", op="subf", args=["alpha", "%c1"], target_var="%a1"),
            MLIROperation(dialect="arith", op="constant", args=["2.0"], target_var="%c2", attributes={"type": "f64"}),
            MLIROperation(dialect="math", op="powf", args=["%c2", "%a1"], target_var="%b"),
            MLIROperation(dialect="func", op="return", args=["%b"])
        ]
    )
    create_manual_template(zipf_fqn, zipf_mlir)

    # 3. PAGERANK POWER ITERATION KERNEL
    pr_fqn = "networkx.algorithms.link_analysis.pagerank_alg._pagerank_python.chunk_0"
    pr_mlir = VerifiedMLIR(
        function_name=sanitize_fqn(pr_fqn),
        thinking_process="High-performance iterated CSR PageRank kernel.",
        signature={
            "res_ptr": "ptr",
            "row_ptrs": "ptr",
            "col_idx": "ptr",
            "weights": "ptr",
            "xlast_ptr": "ptr",
            "p_ptr": "ptr",
            "num_nodes": "i64",
            "alpha": "f64",
            "max_iter": "i64",
            "return": "void"
        },
        arg_mapping=[],
        operations=[
            MLIROperation(dialect="arith", op="constant", args=["0"], target_var="%c0", attributes={"type": "index"}),
            MLIROperation(dialect="arith", op="constant", args=["1"], target_var="%c1", attributes={"type": "index"}),
            MLIROperation(dialect="arith", op="constant", args=["0.0"], target_var="%f0", attributes={"type": "f64"}),
            MLIROperation(dialect="arith", op="constant", args=["1.0"], target_var="%f1", attributes={"type": "f64"}),
            MLIROperation(dialect="arith", op="index_cast", args=["num_nodes"], target_var="%num_nodes_idx", attributes={"type": "index"}),
            MLIROperation(dialect="arith", op="index_cast", args=["max_iter"], target_var="%max_iter_idx", attributes={"type": "index"}),
            MLIROperation(dialect="arith", op="subf", args=["%f1", "alpha"], target_var="%one_minus_alpha"),

            # Outer Loop: Iterations
            MLIROperation(dialect="scf", op="for", args=["%c0", "%max_iter_idx", "%c1"], attributes={
                "init_args": [],
                "body_args": ["%iter_idx"]
            }, body=[
                # 1. Initialize result with (1-alpha) * p
                MLIROperation(dialect="scf", op="for", args=["%c0", "%num_nodes_idx", "%c1"], attributes={
                    "init_args": [],
                    "body_args": ["%idx"]
                }, body=[
                    MLIROperation(dialect="llvm", op="getelementptr", args=["p_ptr", "%idx"], target_var="%p_addr"),
                    MLIROperation(dialect="llvm", op="load", args=["%p_addr"], target_var="%p_val", attributes={"type": "f64"}),
                    MLIROperation(dialect="arith", op="mulf", args=["%one_minus_alpha", "%p_val"], target_var="%init_val"),
                    MLIROperation(dialect="llvm", op="getelementptr", args=["res_ptr", "%idx"], target_var="%r_addr"),
                    MLIROperation(dialect="llvm", op="store", args=["%init_val", "%r_addr"]),
                    MLIROperation(dialect="scf", op="yield", args=[])
                ]),

                # 2. Matrix-Vector Multiply: res += alpha * xlast * weights
                MLIROperation(dialect="scf", op="for", args=["%c0", "%num_nodes_idx", "%c1"], attributes={
                    "init_args": [],
                    "body_args": ["%u_idx"]
                }, body=[
                    MLIROperation(dialect="llvm", op="getelementptr", args=["xlast_ptr", "%u_idx"], target_var="%pu_val"),
                    MLIROperation(dialect="llvm", op="load", args=["%pu_val"], target_var="%u_val", attributes={"type": "f64"}),
                    MLIROperation(dialect="arith", op="mulf", args=["alpha", "%u_val"], target_var="%alpha_u"),
                    
                    MLIROperation(dialect="llvm", op="getelementptr", args=["row_ptrs", "%u_idx"], target_var="%ps"),
                    MLIROperation(dialect="llvm", op="load", args=["%ps"], target_var="%s_i64", attributes={"type": "i64"}),
                    MLIROperation(dialect="arith", op="index_cast", args=["%s_i64"], target_var="%start", attributes={"type": "index"}),
                    
                    MLIROperation(dialect="arith", op="addi", args=["%u_idx", "%c1"], target_var="%unext"),
                    MLIROperation(dialect="llvm", op="getelementptr", args=["row_ptrs", "%unext"], target_var="%pe"),
                    MLIROperation(dialect="llvm", op="load", args=["%pe"], target_var="%e_i64", attributes={"type": "i64"}),
                    MLIROperation(dialect="arith", op="index_cast", args=["%e_i64"], target_var="%end", attributes={"type": "index"}),
                    
                    MLIROperation(dialect="scf", op="for", args=["%start", "%end", "%c1"], attributes={
                        "init_args": [],
                        "body_args": ["%e_idx"]
                    }, body=[
                        MLIROperation(dialect="llvm", op="getelementptr", args=["col_idx", "%e_idx"], target_var="%pv"),
                        MLIROperation(dialect="llvm", op="load", args=["%pv"], target_var="%v_i64", attributes={"type": "i64"}),
                        MLIROperation(dialect="llvm", op="getelementptr", args=["weights", "%e_idx"], target_var="%pwt"),
                        MLIROperation(dialect="llvm", op="load", args=["%pwt"], target_var="%wt", attributes={"type": "f64"}),
                        MLIROperation(dialect="arith", op="mulf", args=["%alpha_u", "%wt"], target_var="%delta"),
                        MLIROperation(dialect="llvm", op="getelementptr", args=["res_ptr", "%v_i64"], target_var="%prv"),
                        MLIROperation(dialect="llvm", op="load", args=["%prv"], target_var="%old_v", attributes={"type": "f64"}),
                        MLIROperation(dialect="arith", op="addf", args=["%old_v", "%delta"], target_var="%new_v"),
                        MLIROperation(dialect="llvm", op="store", args=["%new_v", "%prv"]),
                        MLIROperation(dialect="scf", op="yield", args=[])
                    ]),
                    MLIROperation(dialect="scf", op="yield", args=[])
                ]),
                
                # 3. Swap xlast and res for next iteration
                MLIROperation(dialect="scf", op="for", args=["%c0", "%num_nodes_idx", "%c1"], attributes={
                    "init_args": [],
                    "body_args": ["%idx_swap"]
                }, body=[
                    MLIROperation(dialect="llvm", op="getelementptr", args=["res_ptr", "%idx_swap"], target_var="%r_s"),
                    MLIROperation(dialect="llvm", op="load", args=["%r_s"], target_var="%v_s", attributes={"type": "f64"}),
                    MLIROperation(dialect="llvm", op="getelementptr", args=["xlast_ptr", "%idx_swap"], target_var="%xl_s"),
                    MLIROperation(dialect="llvm", op="store", args=["%v_s", "%xl_s"]),
                    MLIROperation(dialect="scf", op="yield", args=[])
                ]),
                MLIROperation(dialect="scf", op="yield", args=[])
            ]),
            MLIROperation(dialect="func", op="return", args=[])
        ]
    )
    create_manual_template(pr_fqn, pr_mlir)

if __name__ == "__main__":
    setup_networkx_templates()
