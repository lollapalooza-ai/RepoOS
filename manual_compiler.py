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
    """Generic naming logic that preserves unique context without hardcoding packages."""
    parts = fqn.split('.')
    if len(parts) > 3:
        base = "_".join(parts[-3:])
    else:
        base = "_".join(parts)
    return base.replace('-', '_')

def create_manual_template(fqn: str, mlir_data: VerifiedMLIR):
    sanitized = sanitize_fqn(fqn)
    path = os.path.join(OUTPUT_DIR, f"{sanitized}.json")
    with open(path, 'w') as f:
        json.dump(mlir_data.model_dump(), f, indent=2)
    print(f"✅ Manual template written to {path}")

def setup_networkx_templates():
    # 1. CUMULATIVE_DISTRIBUTION
    # ... (skipping CD for brevity, focus on PageRank)

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
        config={
            "stochastic": True,
            "result_buffer": "res_ptr",
            "init": {"xlast_ptr": "1/N", "p_ptr": "1/N"}
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

            MLIROperation(dialect="scf", op="for", args=["%c0", "%max_iter_idx", "%c1"], attributes={
                "init_args": [],
                "body_args": ["%iter_idx"]
            }, body=[
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

def setup_betweenness_template():
    bc_fqn = "networkx.algorithms.centrality.betweenness.betweenness_centrality.chunk_0"
    bc_mlir = VerifiedMLIR(
        function_name=sanitize_fqn(bc_fqn),
        thinking_process="Brandes Betweenness Centrality (Unweighted).",
        signature={
            "betweenness_ptr": "ptr",
            "row_ptrs": "ptr",
            "col_idx": "ptr",
            "d_ptr": "ptr",
            "sigma_ptr": "ptr",
            "s_ptr": "ptr",
            "q_ptr": "ptr",
            "delta_ptr": "ptr",
            "num_nodes": "i64",
            "return": "void"
        },
        config={
            "result_buffer": "betweenness_ptr",
            "undirected_double_counted": True,
            "structural_mapping": {
                "row_ptrs": "row_ptrs",
                "col_idx": "col_idx",
                "num_nodes": "num_nodes"
            },
            "element_types": {
                "row_ptrs": "i64",
                "col_idx": "i64",
                "d_ptr": "i64",
                "s_ptr": "i64",
                "q_ptr": "i64"
            },
            "post_process": [
                {"type": "scale", "factor": "0.5_if_undirected"},
                {"type": "scale", "factor": "normalization"}
            ]
        },
        arg_mapping=[],
        operations=[
            MLIROperation(dialect="arith", op="constant", args=["0"], target_var="%c0", attributes={"type": "index"}),
            MLIROperation(dialect="arith", op="constant", args=["1"], target_var="%c1", attributes={"type": "index"}),
            MLIROperation(dialect="arith", op="constant", args=["-1"], target_var="%m1_i64", attributes={"type": "i64"}),
            MLIROperation(dialect="arith", op="constant", args=["0.0"], target_var="%f0", attributes={"type": "f64"}),
            MLIROperation(dialect="arith", op="constant", args=["1.0"], target_var="%f1", attributes={"type": "f64"}),
            MLIROperation(dialect="arith", op="index_cast", args=["num_nodes"], target_var="%num_nodes_idx", attributes={"type": "index"}),
            MLIROperation(dialect="arith", op="constant", args=["1"], target_var="%c1_i64", attributes={"type": "i64"}),

            # Outer Loop: for s in range(num_nodes)
            MLIROperation(dialect="scf", op="for", args=["%c0", "%num_nodes_idx", "%c1"], attributes={
                "init_args": [],
                "body_args": ["%s_idx"]
            }, body=[
                # 1. Initialize scratch buffers for this source node s
                MLIROperation(dialect="scf", op="for", args=["%c0", "%num_nodes_idx", "%c1"], attributes={
                    "init_args": [],
                    "body_args": ["%init_idx"]
                }, body=[
                    MLIROperation(dialect="llvm", op="getelementptr", args=["d_ptr", "%init_idx"], target_var="%pd"),
                    MLIROperation(dialect="llvm", op="store", args=["%m1_i64", "%pd"]),
                    MLIROperation(dialect="llvm", op="getelementptr", args=["sigma_ptr", "%init_idx"], target_var="%psig"),
                    MLIROperation(dialect="llvm", op="store", args=["%f0", "%psig"]),
                    MLIROperation(dialect="llvm", op="getelementptr", args=["delta_ptr", "%init_idx"], target_var="%pdel"),
                    MLIROperation(dialect="llvm", op="store", args=["%f0", "%pdel"]),
                    MLIROperation(dialect="scf", op="yield", args=[])
                ]),
                
                # sigma[s] = 1.0, D[s] = 0
                MLIROperation(dialect="llvm", op="getelementptr", args=["sigma_ptr", "%s_idx"], target_var="%ps_sig"),
                MLIROperation(dialect="llvm", op="store", args=["%f1", "%ps_sig"]),
                MLIROperation(dialect="llvm", op="getelementptr", args=["d_ptr", "%s_idx"], target_var="%ps_d"),
                MLIROperation(dialect="arith", op="constant", args=["0"], target_var="%c0_i64", attributes={"type": "i64"}),
                MLIROperation(dialect="llvm", op="store", args=["%c0_i64", "%ps_d"]),
                
                # Q.push(s), q_start = 0, q_end = 1, s_ptr_end = 0
                MLIROperation(dialect="llvm", op="getelementptr", args=["q_ptr", "%c0"], target_var="%pq0"),
                MLIROperation(dialect="arith", op="index_cast", args=["%s_idx"], target_var="%s_i64", attributes={"type": "i64"}),
                MLIROperation(dialect="llvm", op="store", args=["%s_i64", "%pq0"]),
                
                # 2. BFS Phase
                MLIROperation(dialect="scf", op="for", args=["%c0", "%num_nodes_idx", "%c1"], attributes={
                    "init_args": ["%c0", "%c1", "%c0"], # q_start, q_end, s_end
                    "body_args": ["%bfs_iter", "%q_start", "%q_end", "%s_end"]
                }, target_var="%q_final", body=[
                    MLIROperation(dialect="arith", op="cmpi", args=["%q_start", "%q_end"], target_var="%is_empty", attributes={"predicate": 0}), # eq
                    
                    MLIROperation(dialect="scf", op="if", args=["%is_empty"], attributes={
                        "then": [
                            MLIROperation(dialect="scf", op="yield", args=["%q_start", "%q_end", "%s_end"])
                        ],
                        "else": [
                            MLIROperation(dialect="llvm", op="getelementptr", args=["q_ptr", "%q_start"], target_var="%pv_ptr"),
                            MLIROperation(dialect="llvm", op="load", args=["%pv_ptr"], target_var="%v_i64", attributes={"type": "i64"}),
                            MLIROperation(dialect="arith", op="index_cast", args=["%v_i64"], target_var="%v_idx", attributes={"type": "index"}),
                            
                            MLIROperation(dialect="llvm", op="getelementptr", args=["s_ptr", "%s_end"], target_var="%ps_ptr"),
                            MLIROperation(dialect="llvm", op="store", args=["%v_i64", "%ps_ptr"]),
                            MLIROperation(dialect="arith", op="addi", args=["%s_end", "%c1"], target_var="%s_end_next"),
                            
                            MLIROperation(dialect="llvm", op="getelementptr", args=["d_ptr", "%v_idx"], target_var="%pdv_ptr"),
                            MLIROperation(dialect="llvm", op="load", args=["%pdv_ptr"], target_var="%dv_i64", attributes={"type": "i64"}),
                            MLIROperation(dialect="arith", op="addi", args=["%dv_i64", "%c1_i64"], target_var="%dw_i64", attributes={"type": "i64"}),
                            
                            MLIROperation(dialect="llvm", op="getelementptr", args=["sigma_ptr", "%v_idx"], target_var="%psigmav_ptr"),
                            MLIROperation(dialect="llvm", op="load", args=["%psigmav_ptr"], target_var="%sigmav", attributes={"type": "f64"}),
                            
                            MLIROperation(dialect="llvm", op="getelementptr", args=["row_ptrs", "%v_idx"], target_var="%pstart"),
                            MLIROperation(dialect="llvm", op="load", args=["%pstart"], target_var="%start_i64", attributes={"type": "i64"}),
                            MLIROperation(dialect="arith", op="index_cast", args=["%start_i64"], target_var="%start_idx", attributes={"type": "index"}),
                            
                            MLIROperation(dialect="arith", op="addi", args=["%v_idx", "%c1"], target_var="%v_next"),
                            MLIROperation(dialect="llvm", op="getelementptr", args=["row_ptrs", "%v_next"], target_var="%pend"),
                            MLIROperation(dialect="llvm", op="load", args=["%pend"], target_var="%end_i64", attributes={"type": "i64"}),
                            MLIROperation(dialect="arith", op="index_cast", args=["%end_i64"], target_var="%end_idx", attributes={"type": "index"}),
                            
                            MLIROperation(dialect="scf", op="for", args=["%start_idx", "%end_idx", "%c1"], attributes={
                                "init_args": ["%q_end"],
                                "body_args": ["%edge_idx", "%curr_q_end"]
                            }, target_var="%new_q_end", body=[
                                MLIROperation(dialect="llvm", op="getelementptr", args=["col_idx", "%edge_idx"], target_var="%pw_ptr"),
                                MLIROperation(dialect="llvm", op="load", args=["%pw_ptr"], target_var="%w_i64", attributes={"type": "i64"}),
                                MLIROperation(dialect="arith", op="index_cast", args=["%w_i64"], target_var="%w_idx", attributes={"type": "index"}),
                                
                                MLIROperation(dialect="llvm", op="getelementptr", args=["d_ptr", "%w_idx"], target_var="%pdw_ptr"),
                                MLIROperation(dialect="llvm", op="load", args=["%pdw_ptr"], target_var="%dw_curr", attributes={"type": "i64"}),
                                MLIROperation(dialect="arith", op="cmpi", args=["%dw_curr", "%m1_i64"], target_var="%is_new", attributes={"predicate": 0}), # eq
                                
                                MLIROperation(dialect="scf", op="if", args=["%is_new"], attributes={
                                    "then": [
                                        MLIROperation(dialect="llvm", op="store", args=["%dw_i64", "%pdw_ptr"]),
                                        MLIROperation(dialect="llvm", op="getelementptr", args=["q_ptr", "%curr_q_end"], target_var="%pq_next"),
                                        MLIROperation(dialect="llvm", op="store", args=["%w_i64", "%pq_next"]),
                                        MLIROperation(dialect="arith", op="addi", args=["%curr_q_end", "%c1"], target_var="%next_q_end"),
                                        MLIROperation(dialect="scf", op="yield", args=["%next_q_end"])
                                    ],
                                    "else": [
                                        MLIROperation(dialect="scf", op="yield", args=["%curr_q_end"])
                                    ]
                                }, target_var="%res_q_end"),
                                
                                MLIROperation(dialect="llvm", op="load", args=["%pdw_ptr"], target_var="%dw_final", attributes={"type": "i64"}),
                                MLIROperation(dialect="arith", op="cmpi", args=["%dw_final", "%dw_i64"], target_var="%is_sp", attributes={"predicate": 0}),
                                
                                MLIROperation(dialect="scf", op="if", args=["%is_sp"], attributes={
                                    "then": [
                                        MLIROperation(dialect="llvm", op="getelementptr", args=["sigma_ptr", "%w_idx"], target_var="%psigmaw_ptr"),
                                        MLIROperation(dialect="llvm", op="load", args=["%psigmaw_ptr"], target_var="%sigmaw", attributes={"type": "f64"}),
                                        MLIROperation(dialect="arith", op="addf", args=["%sigmaw", "%sigmav"], target_var="%new_sigmaw"),
                                        MLIROperation(dialect="llvm", op="store", args=["%new_sigmaw", "%psigmaw_ptr"]),
                                        MLIROperation(dialect="scf", op="yield", args=[])
                                    ],
                                    "else": [
                                        MLIROperation(dialect="scf", op="yield", args=[])
                                    ]
                                }),
                                
                                MLIROperation(dialect="scf", op="yield", args=["%res_q_end"])
                            ]),
                            
                            MLIROperation(dialect="arith", op="addi", args=["%q_start", "%c1"], target_var="%q_start_next"),
                            MLIROperation(dialect="scf", op="yield", args=["%q_start_next", "%new_q_end", "%s_end_next"])
                        ]
                    }, target_var="%res_q"),
                    MLIROperation(dialect="scf", op="yield", args=["%res_q#0", "%res_q#1", "%res_q#2"])
                ]),
                
                # 3. Accumulation Phase
                MLIROperation(dialect="scf", op="for", args=["%c0", "%q_final#2", "%c1"], attributes={
                    "init_args": [],
                    "body_args": ["%acc_iter"]
                }, body=[
                    MLIROperation(dialect="arith", op="subi", args=["%q_final#2", "%c1"], target_var="%s_top"),
                    MLIROperation(dialect="arith", op="subi", args=["%s_top", "%acc_iter"], target_var="%w_s_idx"),
                    
                    MLIROperation(dialect="llvm", op="getelementptr", args=["s_ptr", "%w_s_idx"], target_var="%pw_s"),
                    MLIROperation(dialect="llvm", op="load", args=["%pw_s"], target_var="%w_i64", attributes={"type": "i64"}),
                    MLIROperation(dialect="arith", op="index_cast", args=["%w_i64"], target_var="%w_idx", attributes={"type": "index"}),
                    
                    MLIROperation(dialect="llvm", op="getelementptr", args=["d_ptr", "%w_idx"], target_var="%pdw"),
                    MLIROperation(dialect="llvm", op="load", args=["%pdw"], target_var="%dw_i64", attributes={"type": "i64"}),
                    MLIROperation(dialect="arith", op="subi", args=["%dw_i64", "%c1_i64"], target_var="%dv_target", attributes={"type": "i64"}),
                    
                    MLIROperation(dialect="llvm", op="getelementptr", args=["delta_ptr", "%w_idx"], target_var="%pdeltaw"),
                    MLIROperation(dialect="llvm", op="load", args=["%pdeltaw"], target_var="%deltaw", attributes={"type": "f64"}),
                    MLIROperation(dialect="llvm", op="getelementptr", args=["sigma_ptr", "%w_idx"], target_var="%psigmaw"),
                    MLIROperation(dialect="llvm", op="load", args=["%psigmaw"], target_var="%sigmaw", attributes={"type": "f64"}),
                    
                    MLIROperation(dialect="arith", op="addf", args=["%f1", "%deltaw"], target_var="%num"),
                    MLIROperation(dialect="arith", op="divf", args=["%num", "%sigmaw"], target_var="%coeff"),
                    
                    MLIROperation(dialect="llvm", op="getelementptr", args=["row_ptrs", "%w_idx"], target_var="%pstart_w"),
                    MLIROperation(dialect="llvm", op="load", args=["%pstart_w"], target_var="%start_w_i64", attributes={"type": "i64"}),
                    MLIROperation(dialect="arith", op="index_cast", args=["%start_w_i64"], target_var="%start_w_idx", attributes={"type": "index"}),
                    
                    MLIROperation(dialect="arith", op="addi", args=["%w_idx", "%c1"], target_var="%w_next"),
                    MLIROperation(dialect="llvm", op="getelementptr", args=["row_ptrs", "%w_next"], target_var="%pend_w"),
                    MLIROperation(dialect="llvm", op="load", args=["%pend_w"], target_var="%end_w_i64", attributes={"type": "i64"}),
                    MLIROperation(dialect="arith", op="index_cast", args=["%end_w_i64"], target_var="%end_w_idx", attributes={"type": "index"}),
                    
                    MLIROperation(dialect="scf", op="for", args=["%start_w_idx", "%end_w_idx", "%c1"], attributes={
                        "init_args": [],
                        "body_args": ["%e_idx_w"]
                    }, body=[
                        MLIROperation(dialect="llvm", op="getelementptr", args=["col_idx", "%e_idx_w"], target_var="%pv_ptr_w"),
                        MLIROperation(dialect="llvm", op="load", args=["%pv_ptr_w"], target_var="%v_i64_w", attributes={"type": "i64"}),
                        MLIROperation(dialect="arith", op="index_cast", args=["%v_i64_w"], target_var="%v_idx_w", attributes={"type": "index"}),
                        
                        MLIROperation(dialect="llvm", op="getelementptr", args=["d_ptr", "%v_idx_w"], target_var="%pdv_ptr_w"),
                        MLIROperation(dialect="llvm", op="load", args=["%pdv_ptr_w"], target_var="%dv_curr_w", attributes={"type": "i64"}),
                        MLIROperation(dialect="arith", op="cmpi", args=["%dv_curr_w", "%dv_target"], target_var="%is_pred", attributes={"predicate": 0}), # eq
                        
                        MLIROperation(dialect="scf", op="if", args=["%is_pred"], attributes={
                            "then": [
                                MLIROperation(dialect="llvm", op="getelementptr", args=["sigma_ptr", "%v_idx_w"], target_var="%psigmav_w"),
                                MLIROperation(dialect="llvm", op="load", args=["%psigmav_w"], target_var="%sigmav_w", attributes={"type": "f64"}),
                                MLIROperation(dialect="arith", op="mulf", args=["%sigmav_w", "%coeff"], target_var="%term"),
                                MLIROperation(dialect="llvm", op="getelementptr", args=["delta_ptr", "%v_idx_w"], target_var="%pdeltav_w"),
                                MLIROperation(dialect="llvm", op="load", args=["%pdeltav_w"], target_var="%deltav_old", attributes={"type": "f64"}),
                                MLIROperation(dialect="arith", op="addf", args=["%deltav_old", "%term"], target_var="%deltav_new"),
                                MLIROperation(dialect="llvm", op="store", args=["%deltav_new", "%pdeltav_w"]),
                                MLIROperation(dialect="scf", op="yield", args=[])
                            ],
                            "else": [
                                MLIROperation(dialect="scf", op="yield", args=[])
                            ]
                        }),
                        MLIROperation(dialect="scf", op="yield", args=[])
                    ]),
                    
                    MLIROperation(dialect="arith", op="cmpi", args=["%w_idx", "%s_idx"], target_var="%not_source", attributes={"predicate": 1}), # ne
                    MLIROperation(dialect="scf", op="if", args=["%not_source"], attributes={
                        "then": [
                            MLIROperation(dialect="llvm", op="getelementptr", args=["betweenness_ptr", "%w_idx"], target_var="%pb"),
                            MLIROperation(dialect="llvm", op="load", args=["%pb"], target_var="%b_old", attributes={"type": "f64"}),
                            MLIROperation(dialect="arith", op="addf", args=["%b_old", "%deltaw"], target_var="%b_new"),
                            MLIROperation(dialect="llvm", op="store", args=["%b_new", "%pb"]),
                            MLIROperation(dialect="scf", op="yield", args=[])
                        ],
                        "else": [
                            MLIROperation(dialect="scf", op="yield", args=[])
                        ]
                    }),
                    MLIROperation(dialect="scf", op="yield", args=[])
                ]),
                MLIROperation(dialect="scf", op="yield", args=[])
            ]),
            MLIROperation(dialect="func", op="return", args=[])
        ]
    )
    create_manual_template(bc_fqn, bc_mlir)

if __name__ == "__main__":
    setup_networkx_templates()
    setup_betweenness_template()
