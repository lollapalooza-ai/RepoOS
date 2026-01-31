import os
import logging
import sys
from tree_sitter import Language, Parser
import tree_sitter_python as tspython
from neo4j import GraphDatabase

# 1. Setup the Parser (The "Eyes")
PY_LANGUAGE = Language(tspython.language())
parser = Parser(PY_LANGUAGE)

# Setup logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

# 2. Setup the Database Connection (The "Memory")
# URI usually bolt://localhost:7687 for local Neo4j
driver = GraphDatabase.driver("neo4j://localhost:7687", auth=("neo4j", "password"))

def ingest_file(file_path):
    logger.debug(f"Ingesting file: {file_path}")
    try:
        with open(file_path, 'r') as f:
            code = f.read()
    except Exception as e:
        logger.error(f"Error reading file {file_path}: {e}")
        return
    
    # Parse the code into a Tree
    tree = parser.parse(bytes(code, "utf8"))
    
    # Walk the tree to find Function Definitions
    cursor = tree.walk()
    visited_children = False
    while True:
        if not visited_children:
            if cursor.node.type == 'function_definition':
                # Extract function name (simplified logic)
                func_name_node = cursor.node.child_by_field_name('name')
                func_name = code[func_name_node.start_byte:func_name_node.end_byte]
                
                logger.info(f"Found function: {func_name}")
                
                # Push to Neo4j
                with driver.session() as session:
                    session.run("""
                        MERGE (f:Function {name: $name, file: $file})
                    """, name=func_name, file=file_path)
            
        if cursor.goto_first_child():
            visited_children = False
        elif cursor.goto_next_sibling():
            visited_children = False
        elif cursor.goto_parent():
            visited_children = True
        else:
            break

if __name__ == "__main__":
    try:
        # Run it on itself!
        ingest_file("hello.py")
    finally:
        driver.close()
        sys.exit(0)