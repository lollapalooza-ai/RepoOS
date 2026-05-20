import ast
import inspect
from component1_ingest import PureLogicChunker
import networkx.algorithms.centrality.betweenness as b_mod

code = inspect.getsource(b_mod.betweenness_centrality)
tree = ast.parse(code)
visitor = PureLogicChunker()
visitor.visit(tree)

print(f"Chunks found: {len(visitor.chunks)}")
for i, c in enumerate(visitor.chunks):
    print(f"Chunk {i}:\n{c['code'][:100]}...")
