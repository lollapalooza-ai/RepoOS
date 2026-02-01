from neo4j import GraphDatabase

NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")

driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)

def clear_db():
    with driver.session() as session:
        session.run("MATCH (n) DETACH DELETE n")
    print("Neo4j database cleared.")

if __name__ == "__main__":
    clear_db()
    driver.close()
