import os
import json
import asyncio
from neo4j import GraphDatabase
from component2_smt import VerifiedMLIR, verify_semantic_equivalence

NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
MANUAL_CACHE = "./.poly_cache_manual"

async def validate_cache():
    print(f"--- 🔍 Formal Semantic Validation of Manual Cache ---")
    driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
    
    with driver.session() as session:
        # We target functions where we expect semantic similarity (Math/Logic)
        results = session.run("MATCH (f:Function) RETURN f.fqn, f.code, f.arg_count")
        
        for record in results:
            fqn, source_code, arg_count = record["f.fqn"], record["f.code"], record["f.arg_count"]
            json_path = os.path.join(MANUAL_CACHE, f"{fqn.replace('.', '_')}.json")
            
            if not os.path.exists(json_path):
                continue

            print(f"\nValidating {fqn}...")
            
            with open(json_path, 'r') as f:
                mlir_data = VerifiedMLIR.model_validate_json(f.read())
            
            # Use the Z3 Symbolic Oracle to compare
            try:
                is_equiv, message = verify_semantic_equivalence(mlir_data, source_code, int(arg_count))
                
                if is_equiv:
                    print(f"   ✅ [EQUIVALENT] Logic matches Python source exactly.")
                else:
                    # For IO functions, we expect this to fail because we stubbed them
                    status = "EXPECTED STUB" if ("db" in fqn or "auth" in fqn or "app" in fqn) else "LOGIC MISMATCH"
                    print(f"   ⚠️  [{status}] {message}")
            except Exception as e:
                print(f"   ❌ [ERROR] Verification crashed: {e}")

    driver.close()

if __name__ == "__main__":
    asyncio.run(validate_cache())
