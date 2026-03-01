from fastapi import APIRouter
from neo4j import GraphDatabase
import os

router = APIRouter()

NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)

@router.get("/api/v1/views/cityscape")
async def get_cityscape_view():
    with driver.session() as session:
        # Aggregating metrics by file from Function nodes
        # Complexity is stored on Function nodes.
        nodes_query = """
        MATCH (f:Function)
        WHERE f.file IS NOT NULL
        WITH f.file as file_path, sum(f.complexity) as total_complexity, count(f) as func_count
        RETURN file_path, total_complexity, func_count
        """
        
        # Dependency between files: any CALLS between functions in different files.
        deps_query = """
        MATCH (f1:Function)-[:CALLS]->(f2:Function)
        WHERE f1.file IS NOT NULL AND f2.file IS NOT NULL AND f1.file <> f2.file
        RETURN DISTINCT f1.file as source, f2.file as target
        """
        
        nodes_result = session.run(nodes_query)
        nodes_data = {}
        for record in nodes_result:
            fp = record["file_path"]
            if not fp: continue
            
            # Calculate LOC on the fly
            loc = 0
            if os.path.exists(fp):
                try:
                    with open(fp, 'r', encoding='utf-8') as f:
                        loc = sum(1 for _ in f)
                except Exception:
                    loc = 0
            
            # District is the parent directory
            district = os.path.dirname(fp) or "root"
            
            nodes_data[fp] = {
                "id": fp,
                "district": district,
                "loc": loc,
                "complexity": int(record["total_complexity"]),
                "dependencies": []
            }
        
        deps_result = session.run(deps_query)
        for record in deps_result:
            src = record["source"]
            tgt = record["target"]
            if src in nodes_data and tgt in nodes_data: # Only link known nodes
                if tgt not in nodes_data[src]["dependencies"]:
                    nodes_data[src]["dependencies"].append(tgt)
                
        districts = sorted(list(set(node["district"] for node in nodes_data.values())))
        
        return {
            "type": "MOUNT_COMPONENT",
            "component_name": "Cityscape3D",
            "payload": {
                "districts": districts,
                "nodes": list(nodes_data.values())
            }
        }
