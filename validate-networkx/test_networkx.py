import networkx as nx

def main():
    G = nx.Graph()
    G.add_edge(1, 2)
    G.add_edge(2, 3)
    G.add_edge(3, 1)
    
    print(f"Nodes: {G.nodes()}")
    print(f"Edges: {G.edges()}")
    
    shortest_path = nx.shortest_path(G, source=1, target=3)
    print(f"Shortest path from 1 to 3: {shortest_path}")

if __name__ == "__main__":
    main()
