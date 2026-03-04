import tree_sitter_python as tspython
from tree_sitter import Language, Parser

PY_LANGUAGE = Language(tspython.language())
parser = Parser(PY_LANGUAGE)

source_code = """
import requests as req
import boto3

def my_func():
    r = req.get("https://api.example.com/data")
    s3 = boto3.client("s3")
    db.execute("SELECT * FROM users")
"""

tree = parser.parse(bytes(source_code, "utf8"))

# Query for imports
import_query = PY_LANGUAGE.query("""
(import_from_statement
  module_name: (identifier) @mod
  (aliased_import
    name: (identifier) @name
    alias: (identifier) @alias)
) @import
(import_statement
  (dotted_name (identifier) @mod)
) @import
(import_statement
  (aliased_import
    name: (dotted_name (identifier) @mod)
    alias: (identifier) @alias)
) @import
""")

captures = import_query.captures(tree.root_node)
print("Imports:")
for node, name in captures:
    print(f"  {name}: {source_code[node.start_byte:node.end_byte]}")

# Query for calls
call_query = PY_LANGUAGE.query("""
(call
  function: (attribute
    object: (identifier) @obj
    attribute: (identifier) @method)
  arguments: (argument_list
    (string) @arg)
) @call
""")

captures = call_query.captures(tree.root_node)
print("\\nCalls:")
for node, name in captures:
    print(f"  {name}: {source_code[node.start_byte:node.end_byte]}")
