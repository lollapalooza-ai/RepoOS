from fastapi import FastAPI, HTTPException
from neo4j import GraphDatabase

app = FastAPI()
driver = GraphDatabase.driver("bolt://localhost:7687", auth=("neo4j", "password"))

@app.get("/api/semantic_projection/{func_name}")
def get_business_logic(func_name: str):
    with driver.session() as session:
        query = """
        MATCH (f:Function {name: $name})
        OPTIONAL MATCH (f)-[:CALLS]->(callee:Function)
        RETURN f.name AS func, f.code AS raw_code, collect(callee.name) AS dependencies
        """
        result = session.run(query, name=func_name).single()
        
        if not result or not result["func"]:
            raise HTTPException(status_code=404, detail="Semantic node not found.")
            
        # Reconstruct IDE View
        pseudo_code = f"BUSINESS REQUIREMENT: {result['func'].replace('_', ' ').title()}\n"
        pseudo_code += "=" * 50 + "\n"
        
        pseudo_code += "DEPENDENCY FLOW:\n"
        deps = [d for d in result["dependencies"] if d]
        if deps:
            for d in deps:
                pseudo_code += f"  ↳ Triggers module: {d}\n"
        else:
            pseudo_code += "  ↳ Isolated execution (No external dependencies)\n"
            
        pseudo_code += "\nCORE LOGIC ANCHOR:\n"
        # Ensure raw_code isn't None
        raw_code = result["raw_code"] if result["raw_code"] else "No code snippet available."
        pseudo_code += "\n".join([f"    {line}" for line in raw_code.split("\n")[:5]]) 
        pseudo_code += "\n    ... (Execution paths managed by AI)"

        return {"ide_view_content": pseudo_code}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
