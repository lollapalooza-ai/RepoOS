import tree_sitter_python as tspython
from tree_sitter import Language, Parser

PY_LANGUAGE = Language(tspython.language())
parser = Parser(PY_LANGUAGE)

source_code = """
import requests as req
import boto3
from os import path as p
"""

tree = parser.parse(bytes(source_code, "utf8"))

def print_node(node, level=0):
    print("  " * level + f"{node.type}: {source_code[node.start_byte:node.end_byte]}")
    for child in node.children:
        print_node(child, level + 1)

print_node(tree.root_node)
