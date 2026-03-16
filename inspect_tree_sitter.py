import tree_sitter_python as tspython
from tree_sitter import Language, Parser

PY_LANGUAGE = Language(tspython.language())
parser = Parser(PY_LANGUAGE)

source_code = "def calculate_tax(amount): return amount * 1.2"
tree = parser.parse(bytes(source_code, "utf8"))
query = PY_LANGUAGE.query("(function_definition name: (identifier) @func.name)")
captures = query.captures(tree.root_node)

print(f"Type of captures: {type(captures)}")
if isinstance(captures, dict):
    for key, val in captures.items():
        print(f"Key: {key}, Val: {val}")
else:
    for item in captures:
        print(f"Item: {item}, Type: {type(item)}")
