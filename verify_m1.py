from neo4j import GraphDatabase
import json

NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)

def verify_milestone1():
    with driver.session() as session:
        # Check Module
        result = session.run("MATCH (m:Module {name: 'ecommerce.cart'}) RETURN m.extracted_keys as keys, m.path as path")
        record = result.single()
        if not record:
            print("❌ Module 'ecommerce.cart' not found!")
            return
        print(f"✅ Module 'ecommerce.cart' found. Keys: {record['keys']}, Path: {record['path']}")

        # Check Class
        result = session.run("MATCH (m:Module {name: 'ecommerce.cart'})-[:CONTAINS]->(c:Class) RETURN c.name as name, c.fqn as fqn")
        record = result.single()
        if not record:
            print("❌ Class Cart not found in module!")
        else:
            print(f"✅ Class '{record['name']}' found. FQN: {record['fqn']}")

        # Check Method
        result = session.run("MATCH (c:Class {name: 'Cart'})-[:HAS_METHOD]->(f:Function) RETURN f.name as name, f.fqn as fqn, f.type_hints as hints, f.arg_count as count")
        record = result.single()
        if not record:
            print("❌ Method 'calculate' not found in class!")
        else:
            print(f"✅ Method '{record['name']}' found. FQN: {record['fqn']}, Args: {record['count']}, Hints: {record['hints']}")

if __name__ == "__main__":
    verify_milestone1()
    driver.close()
