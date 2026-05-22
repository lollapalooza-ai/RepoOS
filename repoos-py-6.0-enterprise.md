Milestone 1.0
Subject: Refactoring MLIR Pipeline: Deterministic Lowering & LLM Role Shift

Context:
Our current pipeline crashes because we are asking Gemini to translate raw Python syntax directly into an MLIR execution graph. We are going to decouple this.

We will build a deterministic AST-to-MLIR visitor in Python.

Gemini will no longer build the graph; it will receive the deterministic JSON graph and strictly return optimization heuristics (loop unrolling, vectorization) via Structured Outputs.

We must patch the Z3 bypass for bounded loops.

Please implement the following three steps:

Step 1: Deterministic AST Lowering (The Builder)
Create a new module ast_to_mlir.py. We need to extend our existing ast.NodeVisitor to emit standard MLIROperation objects directly, bypassing the LLM entirely for the baseline translation.

Python
import ast
from pydantic import BaseModel
from typing import List, Dict
from component2_smt import MLIROperation, VerifiedMLIR

class DeterministicMLIRBuilder(ast.NodeVisitor):
    def __init__(self, function_name: str, args: List[str]):
        self.operations = []
        self.env = {}
        self.var_counter = 0
        self.function_name = function_name
        self.signature = {arg: "f64" for arg in args} # Default to f64 for now
        self.signature["return"] = "f64"

    def new_var(self):
        self.var_counter += 1
        return f"%{self.var_counter}"

    def visit_BinOp(self, node):
        left_var = self.visit(node.left)
        right_var = self.visit(node.right)
        target = self.new_var()
        
        op_map = {ast.Add: "addf", ast.Sub: "subf", ast.Mult: "mulf", ast.Div: "divf"}
        mlir_op = op_map.get(type(node.op))
        
        if not mlir_op:
            raise NotImplementedError(f"Op {type(node.op)} not supported deterministically yet.")

        self.operations.append(
            MLIROperation(
                dialect="arith", op=mlir_op, args=[left_var, right_var], target_var=target
            )
        )
        return target

    def visit_Name(self, node):
        if node.id in self.signature:
            return f"%{node.id}"
        return self.env.get(node.id, f"%{node.id}")

    def visit_Constant(self, node):
        target = self.new_var()
        self.operations.append(
            MLIROperation(
                dialect="arith", op="constant", args=[str(node.value)], target_var=target,
                attributes={"type": "f64"}
            )
        )
        return target

    # TODO for Senior Eng: Implement visit_For, visit_If, and visit_Subscript to handle scf and memref
Step 2: Shift Gemini to an "Optimization Oracle"
Update component2_smt.py. Instead of asking Gemini to write MLIR, pass the deterministically generated VerifiedMLIR JSON to Gemini. Use the google-genai SDK's native response_schema to force Gemini to return only a strict configuration object.

Python
# In component2_smt.py

class MLIROptimizationHeuristics(BaseModel):
    loop_unroll_factor: int = Field(default=1, description="Factor to unroll scf.for loops.")
    vectorization_width: int = Field(default=1, description="SIMD vectorization width.")
    stochastic_routing_hint: bool = Field(default=False)

async def generate_optimization_heuristics(baseline_mlir: VerifiedMLIR) -> MLIROptimizationHeuristics:
    """Pass the deterministically generated MLIR to Gemini just for tuning parameters."""
    
    prompt = f"""
    Analyze this baseline MLIR execution graph. 
    Do NOT rewrite the logic. Provide optimization heuristics for the CPU JIT compiler.
    
    BASELINE GRAPH:
    {baseline_mlir.model_dump_json(indent=2)}
    """
    
    try:
        response = await client.aio.models.generate_content(
            model='gemini-2.5-pro',
            contents=prompt,
            config=types.GenerateContentConfig(
                response_mime_type="application/json",
                # Force the output to perfectly match the Pydantic schema
                response_schema=MLIROptimizationHeuristics,
                temperature=0.0
            )
        )
        # Parse the guaranteed JSON
        return MLIROptimizationHeuristics.model_validate_json(response.text)
    except Exception as e:
        print(f"Heuristic optimization failed, falling back to unoptimized baseline: {e}")
        return MLIROptimizationHeuristics() # Safe fallback
Step 3: Patch the Z3 Bounded Loophole
In component2_smt.py, you currently bypass scf.for in verify_semantic_equivalence. For loops with statically known bounds (or by injecting a bounded unroll limit for symbolic execution), we must verify them.

Update the mlir_to_z3_candidate to handle scf.for via bounded unrolling:

Python
# Inside mlir_to_z3_candidate in component2_smt.py

# Remove the BYPASS for 'scf'. Instead, implement bounded unrolling:
MAX_UNROLL_DEPTH = 3 # Symbolic execution bound

def process_ops(operations, current_env):
    last_val = RealVal(0.0)
    for op in operations:
        # ... existing arith processing ...
        
        if op.dialect == "scf" and op.op == "for":
            # For symbolic equivalence, we unroll the loop statically a few times
            # to ensure the algebraic accumulation matches the Python AST.
            init_val = resolve(current_env, op.attributes.get("init_args", ["0"])[0])
            iter_var = init_val
            
            for _ in range(MAX_UNROLL_DEPTH):
                loop_env = current_env.copy()
                # Map body args (like %iter_sum) to current symbolic state
                body_args = op.attributes.get("body_args", [])
                if len(body_args) > 1:
                    loop_env[body_args[1]] = iter_var
                
                # Recursively process the loop body
                iter_var = process_ops(op.body, loop_env)
            
            if op.target_var:
                current_env[op.target_var] = iter_var
            last_val = iter_var
            
    return last_val


Milestone 2.0
Subject: Update component1_ingest.py to Store Deterministic MLIR

Context:
As part of our refactoring to decouple compilation from LLM generation, the Neo4j database should store the deterministically lowered MLIR alongside the raw Python code. We will integrate the new DeterministicMLIRBuilder directly into our PureLogicChunker.

Please implement the following modifications in component1_ingest.py:

Step 1: Import the Builder and Update the Chunker
In component1_ingest.py, import the DeterministicMLIRBuilder (from our new ast_to_mlir module) and invoke it inside _flush_chunk.

Python
# component1_ingest.py
import ast
import json
# ... existing imports ...
from ast_to_mlir import DeterministicMLIRBuilder # <-- NEW

class PureLogicChunker(ast.NodeVisitor):
    # ... __init__ and other methods remain the same ...

    def _flush_chunk(self):
        """Saves the current pure block, lowers it to MLIR, and resets."""
        if self.current_chunk:
            code = "\n".join([ast.unparse(n) for n in self.current_chunk])
            inputs = list(self.inputs - self.local_vars)
            outputs = list(self.outputs)
            
            # --- NEW: Deterministic Lowering ---
            try:
                # Wrap the chunk in a dummy function AST to process it
                chunk_ast = ast.parse(code)
                builder = DeterministicMLIRBuilder(function_name="chunk", args=inputs)
                builder.visit(chunk_ast)
                
                # Extract the generated operations to a JSON-serializable format
                baseline_mlir_dict = {
                    "function_name": "chunk",
                    "signature": builder.signature,
                    "arg_mapping": {arg: f"%{arg}" for arg in inputs},
                    "operations": [op.model_dump() for op in builder.operations]
                }
                baseline_mlir_json = json.dumps(baseline_mlir_dict)
            except Exception as e:
                print(f"Warning: Deterministic lowering failed for chunk, storing empty baseline. Error: {e}")
                baseline_mlir_json = "{}"
            # -----------------------------------

            self.chunks.append({
                "code": code,
                "inputs": inputs,
                "outputs": outputs,
                "baseline_mlir": baseline_mlir_json # <-- NEW payload
            })
            self.current_chunk = []
            self.inputs = set()
            self.outputs = set()
            self.local_vars = set()
Step 2: Update the Neo4j Cypher Query
Update the process_file function where the chunk data is written to Neo4j. Add the baseline_mlir property to the Chunk node so the SMT and AOT layers can retrieve it later.

Python
# Inside process_file(file_path) in component1_ingest.py

            for i, chunk_data in enumerate(chunker.chunks):
                chunk_fqn = f"{fqn}.chunk_{i}"
                session.run("""
                    MATCH (f:Function {fqn: $parent_fqn})
                    MERGE (ch:Chunk {fqn: $chunk_fqn})
                    SET ch.code = $code, 
                        ch.inputs = $inputs, 
                        ch.outputs = $outputs, 
                        ch.index = $index,
                        ch.baseline_mlir = $baseline_mlir // <-- NEW PROPERTY
                    MERGE (f)-[:HAS_CHUNK]->(ch)
                """, 
                     parent_fqn=fqn, 
                     chunk_fqn=chunk_fqn, 
                     code=chunk_data["code"], 
                     inputs=json.dumps(chunk_data["inputs"]), 
                     outputs=json.dumps(chunk_data["outputs"]), 
                     index=i,
                     baseline_mlir=chunk_data["baseline_mlir"] # <-- Pass the data
                )

Milestone 3.0
Subject: Refactoring Downstream Compilers (Components 5 & 9) for Deterministic Pipeline

Context:
Following our updates to ingestion and SMT, our orchestration and AOT compilation layers must stop asking Gemini to generate MLIR. Instead, they must:

Fetch the deterministically generated baseline_mlir from Neo4j.

Query the LLM for MLIROptimizationHeuristics.

Deterministically apply those heuristics to the baseline graph.

Run Z3 verification on the optimized graph before lowering to machine code.

Please implement the following three updates.

Step 1: Create the Heuristic Application Pass
Create a new utility function (can be placed in component2_smt.py or a new compiler_passes.py) that strictly applies the LLM's heuristics to the MLIR AST. This replaces the LLM's "creative" graph rewriting.

Python
# compiler_passes.py
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
                op.attributes["type"] = f"vector<{heuristics.vectorization_width}x{base_type}>"
                op.attributes["vectorized"] = True

    # Example: Apply loop unrolling flags for the MLIR-OPT pass
    if heuristics.loop_unroll_factor > 1:
        for op in optimized.operations:
            if op.dialect == "scf" and op.op == "for":
                op.attributes["unroll"] = heuristics.loop_unroll_factor

    return optimized
Step 2: Update component9_aot.py (The AOT Pipeline)
Modify the main Cypher query to fetch c.baseline_mlir and rewrite the core loop to use the decoupled pipeline.

Python
# In component9_aot.py

# 1. Update the Cypher Query to fetch baseline_mlir
# Inside process_aot_queue():
result = session.run("""
    MATCH (f:Function)
    OPTIONAL MATCH (f)-[:HAS_CHUNK]->(c:Chunk)
    RETURN f.fqn as target_fqn, 
           c.fqn as c_fqn, 
           c.code as c_code, 
           c.inputs as c_inputs,
           c.baseline_mlir as baseline_mlir  // <-- NEW
""")

# 2. Update the processing loop inside process_aot_queue()
for record in result:
    target_fqn = record["target_fqn"]
    c_fqn = record["c_fqn"]
    
    sanitized = sanitize_fqn(target_fqn)
    base_json_path = os.path.join(MANUAL_CACHE_DIR, f"{sanitized}.json")
    
    if os.path.exists(base_json_path):
        print(f"   [STRICT] Using verified manual template...")
        with open(base_json_path, 'r') as f: 
            final_mlir = VerifiedMLIR.model_validate(json.load(f))
    else:
        # --- NEW PIPELINE ---
        baseline_mlir_raw = record["baseline_mlir"]
        if not baseline_mlir_raw or baseline_mlir_raw == "{}":
            print(f"   [!] Skipping {target_fqn}: No deterministic baseline found.")
            continue
            
        baseline_mlir = VerifiedMLIR.model_validate_json(baseline_mlir_raw)
        
        # 1. Get Heuristics from Gemini
        heuristics = await generate_optimization_heuristics(baseline_mlir)
        
        # 2. Deterministically Apply Heuristics
        optimized_mlir = apply_compiler_heuristics(baseline_mlir, heuristics)
        
        # 3. Z3 Safety Guard (Verify the *optimized* graph)
        arg_count = len(json.loads(record["c_inputs"])) if record["c_inputs"] else 0
        is_safe, msg_s = verify_llm_safety(optimized_mlir, arg_count, None)
        
        if not is_safe:
            print(f"   [!] Optimization unsafe ({msg_s}). Falling back to baseline.")
            final_mlir = baseline_mlir
        else:
            final_mlir = optimized_mlir
        # --------------------

    final_mlir.function_name = sanitized
    
    # Proceed to build and cache
    build_and_cache_mlir(final_mlir, os.path.join(CACHE_DIR, f"{sanitized}.mlir"))
Step 3: Update component5_orchestrator.py (The JIT Pipeline)
Apply the exact same architectural changes to the Orchestrator's Lazy Call Manager so it compiles memory-safe blocks on the fly.

Python
# In component5_orchestrator.py
# Inside compile_and_load(self, fqn: str)

    with self.driver.session() as session:
        # Update Query
        result = session.run("""
            MATCH (f:Function {fqn: $fqn})-[:HAS_CHUNK]->(c:Chunk)
            RETURN c.code as c_code, c.inputs as c_inputs, c.baseline_mlir as baseline_mlir
        """, fqn=fqn)
        
        record = result.single()
        if not record: return
        
        # --- NEW PIPELINE ---
        baseline_mlir_raw = record["baseline_mlir"]
        baseline_mlir = VerifiedMLIR.model_validate_json(baseline_mlir_raw)
        
        # Ask Oracle
        heuristics = await generate_optimization_heuristics(baseline_mlir)
        
        # Apply deterministic transformations
        optimized_mlir = apply_compiler_heuristics(baseline_mlir, heuristics)
        
        # Verify
        is_safe, _ = verify_llm_safety(optimized_mlir, len(json.loads(record["c_inputs"])), None)
        final_mlir = optimized_mlir if is_safe else baseline_mlir
        
        final_mlir.function_name = sanitized
        
        # Build cache
        build_and_cache_mlir(final_mlir, cache_file_json)
        # --------------------