import json
import ollama
from sentence_transformers import SentenceTransformer
from neo4j import GraphDatabase

NEO4J_URI, NEO4J_AUTH = "bolt://localhost:7687", ("neo4j", "password")
MODEL_NAME = "qwen2.5-coder:14b-instruct-q4_K_M"
embedder = SentenceTransformer('all-MiniLM-L6-v2')
driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)

def get_hybrid_context(instruction):
    query_vector = embedder.encode(instruction).tolist()
    context_map, anchors = {}, []
    with driver.session() as session:
        result = session.run("CALL db.index.vector.queryNodes('function_embeddings', 5, $embedding) YIELD node AS anchor, score WHERE score > 0.65 RETURN anchor.name, anchor.file, score", embedding=query_vector)
        for record in result:
            anchors.append(record['anchor.name'])
            file_path = record['anchor.file']
            if file_path:
                if file_path not in context_map: context_map[file_path] = []
                context_map[file_path].append(record['anchor.name'])
    if not anchors: return None, "No relevant code found."
    graph_query = "MATCH (a:Function) WHERE a.name IN $anchors OPTIONAL MATCH (c)-[:CALLS]->(a) OPTIONAL MATCH (a)-[:CALLS]->(d) RETURN a.file, c.file, c.name, d.file, d.name"
    with driver.session() as session:
        for record in session.run(graph_query, anchors=anchors):
            for f, n in [(record['c.file'], record['c.name']), (record['d.file'], record['d.name'])]:
                if f and n:
                    if f not in context_map: context_map[f] = []
                    if n not in context_map[f]: context_map[f].append(n)
    return context_map, None

intent = "Refactor the get_context_data method in CatalogueView to use a new helper function verify_user_access() instead of the raw permission check. Ensure the verify_user_access function is created in a new utils.py file."
context_map, error = get_hybrid_context(intent)

if error:
    print(f"Error: {error}")
else:
    print(f"Context Map: {json.dumps(context_map, indent=2)}")
    task_sys_prompt = "You are a senior architect. Generate a list of tasks for a refactoring plan. Your response MUST be a JSON list of task objects."
    task_user_prompt = f"INSTRUCTION: {intent}\nCONTEXT: {json.dumps(context_map)}\n\nReturn a JSON list of tasks. Each task MUST have 'task' (string description) and 'context' (dict mapping file paths to lists of symbols)."
    
    response = ollama.chat(
        model=MODEL_NAME, messages=[{'role': 'system', 'content': task_sys_prompt}, {'role': 'user', 'content': task_user_prompt}],
        format='json', options={'temperature': 0.3}
    )
    print(f"Tasks: {json.dumps(json.loads(response['message']['content']), indent=2)}")
