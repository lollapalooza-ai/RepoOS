import tree_sitter_python as tspython
from tree_sitter import Language, Parser

PY_LANGUAGE = Language(tspython.language())
parser = Parser(PY_LANGUAGE)

with open('api_cityscape.py', 'r') as f:
    source = f.read()

tree = parser.parse(bytes(source, "utf8"))

def find_node(node):
    if node.type == "decorated_definition" and "async def" in source[node.start_byte:node.end_byte]:
        print(f"Node: {node.type}")
        for child in node.children:
             print(f"  Child: {child.type}")
             if child.type == "function_definition":
                 for gchild in child.children:
                     print(f"    GChild: {gchild.type}")
        return True
    for child in node.children:
        if find_node(child):
            return True
    return False

find_node(tree.root_node)
