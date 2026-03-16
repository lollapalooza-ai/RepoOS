import asyncio
from component2_smt import verified_generation_loop
from component4_jit import dynamic_jit_compile_and_run
from neo4j import GraphDatabase

# --- Configuration ---
NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")

async def run_v2_pipeline():
    print("--- 🚀 Repo OS Poly-Kernel Pipeline v2.0 ---")
    
    # 1. Fetch Semantic Context from Neo4j
    print("1. Fetching Context from Neo4j...")
    driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
    with driver.session() as session:
        # Let's pick a function we ingested
        result = session.run("MATCH (f:Function) RETURN f.name, f.code LIMIT 1")
        record = result.single()
        if not record:
            print("❌ No functions found in Neo4j. Run component1_ingest.py first.")
            return
        
        func_name = record[0]
        func_code = record[1]
        print(f"   Targeting Function: {func_name}")

    # 2. LLM Generation with Mathematical Verification Loop
    print(f"2. Generating Verified Execution Graph for '{func_name}'...")
    # We'll give it the code as context
    intent = f"Implement the logic of this function: {func_code}. It should take 2 float inputs and return the result."
    
    try:
        # This calls component2_smt which uses Ollama + Z3
        verified_mlir = await verified_generation_loop(intent)
    except Exception as e:
        print(f"❌ Pipeline Halted: {e}")
        return

    # 2.5 Persist Verified Plan to Neo4j for Auditing
    print(f"2.5 Saving Verified Plan for '{func_name}' to Neo4j...")
    with driver.session() as session:
        session.run("""
            MATCH (f:Function {name: $name})
            CREATE (p:ExecutionPlan {
                timestamp: datetime(),
                mlir_json: $mlir_json,
                safety_status: 'PROVEN SAFE'
            })
            MERGE (f)-[:HAS_PLAN]->(p)
        """, name=func_name, mlir_json=verified_mlir.model_dump_json())

    # 3. Dynamic JIT Compilation and Execution
    print("3. Synthesizing Native Machine Code via Dynamic JIT...")
    # Simulate some inputs for the function
    test_inputs = [50.0, 10.0]
    try:
        native_result = dynamic_jit_compile_and_run(verified_mlir, test_inputs)
        print(f"✅ Execution Successful!")
        print(f"   Result for inputs {test_inputs}: {native_result}")
    except Exception as e:
        print(f"❌ JIT Execution Failed: {e}")

if __name__ == "__main__":
    asyncio.run(run_v2_pipeline())
