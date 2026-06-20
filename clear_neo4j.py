from neo4j import GraphDatabase
driver = GraphDatabase.driver("bolt://localhost:7687", auth=("neo4j", "password"))
with driver.session() as session:
    session.run("MATCH (n) DETACH DELETE n")
print("Neo4j database cleared.")
