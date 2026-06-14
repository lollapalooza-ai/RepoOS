import json
import networkx as nx

# def math_hotspot(A, x):
#     # PageRank style math
#     return A @ x + 0.15

def fsm_hotspot():
    # Byte parsing style + API Call
    import requests
    import json
    
    # 1. Fetch massive payload from the legacy shop API
    response = requests.get("http://127.0.0.1:8080/api/v1/orders")
    orders = response.json()
    
    # 2. Sum the total_value (Target for FSM/Byte optimization)
    total = 0.0
    for order in orders:
        total += order["cart"]["total_value"]
        
    return total

# def tabular_hotspot():
#     # ORM style
#     # In a real Django app this would be User.objects.filter(...)
#     # We simulate it with keywords the classifier looks for
#     results = ["user1", "user2"]
#     return [r for r in results if "user" in r]

# def branching_hotspot(val):
#     # Rule engine style
#     if val > 100:
#         if val < 200:
#             return 1
#         else:
#             return 2
#     else:
#         return 0

# def crypto_hotspot(password):
#     # Crypto style
#     import hashlib
#     return hashlib.sha256(password.encode()).hexdigest()
