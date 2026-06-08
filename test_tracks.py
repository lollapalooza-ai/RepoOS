import json
import networkx as nx

def math_hotspot(A, x):
    # PageRank style math
    return A @ x + 0.15

def fsm_hotspot(data: bytes):
    # Byte parsing style
    return json.loads(data.decode('utf-8'))

def tabular_hotspot():
    # ORM style
    # In a real Django app this would be User.objects.filter(...)
    # We simulate it with keywords the classifier looks for
    results = ["user1", "user2"]
    return [r for r in results if "user" in r]

def branching_hotspot(val):
    # Rule engine style
    if val > 100:
        if val < 200:
            return 1
        else:
            return 2
    else:
        return 0

def crypto_hotspot(password):
    # Crypto style
    import hashlib
    return hashlib.sha256(password.encode()).hexdigest()
