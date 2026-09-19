from typing import Any, Tuple, Dict
import ctypes

class TypeAdapter:
    def can_handle(self, obj: Any) -> bool:
        raise NotImplementedError
    
    def devirtualize(self, obj: Any, contract: dict) -> Tuple[Dict[str, Any], int]:
        """Returns a dict of flat ctypes buffers and the primary length."""
        raise NotImplementedError

class NetworkXAdapter(TypeAdapter):
    def can_handle(self, obj: Any) -> bool:
        # Check if it's a NetworkX graph or similar
        return (hasattr(obj, 'nodes') and hasattr(obj, 'edges') and 
                type(obj).__module__.startswith("networkx"))
        
    def devirtualize(self, G, contract: dict):
        import ctypes
        n_nodes = G.number_of_nodes()
        n_edges = G.number_of_edges()
        total_edges = n_edges if G.is_directed() else n_edges * 2

        node_to_idx = {node: i for i, node in enumerate(G.nodes())}
        idx_to_node = {i: node for node, i in node_to_idx.items()}

        row_ptrs = (ctypes.c_int64 * (n_nodes + 1))()
        col_idx = (ctypes.c_int64 * total_edges)()
        weights = (ctypes.c_double * total_edges)()

        needs_stochastic = contract.get("stochastic", False)
        edge_idx = 0
        for i, node in enumerate(G.nodes()):
            row_ptrs[i] = edge_idx
            out_weight = 1.0
            if needs_stochastic:
                out_weight = sum(float(edge_data.get('weight', 1.0)) for neighbor, edge_data in G[node].items())
                if out_weight == 0: out_weight = 1.0
            for neighbor, edge_data in G[node].items():
                col_idx[edge_idx] = node_to_idx[neighbor]
                raw_weight = float(edge_data.get('weight', 1.0))
                weights[edge_idx] = raw_weight / out_weight
                edge_idx += 1
        row_ptrs[n_nodes] = edge_idx
        
        return {
            "row_ptrs": row_ptrs,
            "col_idx": col_idx,
            "weights": weights,
            "num_nodes": n_nodes,
            "num_edges": edge_idx,
            "__node_map__": node_to_idx,
            "__rev_node_map__": idx_to_node
        }, n_nodes

class NumpyAdapter(TypeAdapter):
    def can_handle(self, obj: Any) -> bool:
        return hasattr(obj, '__array_interface__')
        
    def devirtualize(self, arr, contract: dict):
        # Map raw numpy buffer
        return {
            "BUFFER": arr,
            "SIZE": arr.size
        }, arr.size

def get_adapter_registry():
    return [NetworkXAdapter(), NumpyAdapter()]
