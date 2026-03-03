from fastapi import APIRouter
from neo4j import GraphDatabase
import os

router = APIRouter()

NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)

@router.get("/api/v1/views/cityscape/semantic")
async def get_semantic_cityscape(route_filter: str = None):
    """
    Returns a grouped, metaphorical view of the architecture.
    """
    with driver.session() as session:
        # 1. Fetch Backend Logic (The "Back Office")
        # Group functions by their top-level module/folder to create distinct "Offices"
        backend_query = """
        MATCH (f:Function)
        WHERE f.file IS NOT NULL
        WITH split(f.file, '/')[0] as domain_name, count(f) as volume, sum(f.complexity) as heat
        RETURN domain_name as id, 'back_office' as asset_type, volume, heat
        """
        
        # 2. Fetch Databases (The "Filing Cabinets")
        db_query = """
        MATCH (i:Infrastructure)
        WHERE i.type IN ['SQL', 'MONGO', 'REDIS']
        RETURN i.type as id, 'database' as asset_type, 100 as volume, 0 as heat
        """
        
        # 3. Fetch External APIs (The "Banks")
        api_query = """
        MATCH (i:Infrastructure)
        WHERE i.type = 'ExternalAPI'
        MATCH ()-[r:CALLS_API]->(i)
        RETURN DISTINCT r.endpoint as id, 'external_api' as asset_type, 50 as volume, 0 as heat
        """

        nodes = []
        
        for record in session.run(backend_query):
            nodes.append({
                "id": record["id"],
                "asset_type": record["asset_type"],
                "volume": int(record["volume"]),
                "heat": int(record["heat"])
            })
        for record in session.run(db_query):
            nodes.append({
                "id": record["id"],
                "asset_type": record["asset_type"],
                "volume": int(record["volume"]),
                "heat": int(record["heat"])
            })
        for record in session.run(api_query):
            # Clean up the API url for display
            url = record['id']
            clean_id = url.split('/')[2] if '//' in url else url
            nodes.append({
                "id": clean_id, 
                "asset_type": record["asset_type"], 
                "volume": int(record["volume"]), 
                "heat": int(record["heat"])
            })

        # Add the implicit "Storefront" (UI) node
        nodes.append({"id": "Client_UI", "asset_type": "storefront", "volume": 50, "heat": 0})

        # 4. Fetch the Logical Flow (The Arrows)
        # We simplify the relationships based on asset types for this view
        flow_edges = [
            {"source": "Client_UI", "target": "Repo1", "label": "Customer Request"},
            {"source": "Repo1", "target": "SQL", "label": "Read/Write Data"},
            {"source": "Repo1", "target": "stripe.com", "label": "Process Payment"}
        ]

        return {
            "type": "MOUNT_COMPONENT",
            "component_name": "Cityscape3D",
            "payload": {
                "nodes": nodes,
                "edges": flow_edges
            }
        }

# Keep original view as fallback
@router.get("/api/v1/views/cityscape")
async def get_cityscape_view():
    with driver.session() as session:
        nodes_query = """
        MATCH (f:Function)
        WHERE f.file IS NOT NULL
        WITH f.file as file_path, sum(f.complexity) as total_complexity, count(f) as func_count
        RETURN file_path, total_complexity, func_count
        """
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
            loc = 0
            if os.path.exists(fp):
                try:
                    with open(fp, 'r', encoding='utf-8') as f:
                        loc = sum(1 for _ in f)
                except Exception: loc = 0
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
            src, tgt = record["source"], record["target"]
            if src in nodes_data and tgt in nodes_data:
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
