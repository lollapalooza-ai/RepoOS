import tree_sitter_python as tspython
from tree_sitter import Language, Parser

PY_LANGUAGE = Language(tspython.language())
parser = Parser(PY_LANGUAGE)

source_code = """
req.get("...")
"""

tree = parser.parse(bytes(source_code, "utf8"))

node = tree.root_node.children[0].children[0]
print(f"Node type: {node.type}")
for i in range(node.child_count):
    child = node.children[i]
    field = node.field_name_for_child(i)
    print(f"Child {i}: {child.type} - Field: {field}")

attr_node = node.children[0]
print(f"Node type: {attr_node.type}")
for i in range(attr_node.child_count):
    child = attr_node.children[i]
    field = attr_node.field_name_for_child(i)
    print(f"Child {i}: {child.type} - Field: {field}")
