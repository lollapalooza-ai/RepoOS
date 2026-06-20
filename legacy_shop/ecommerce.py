# legacy_shop/ecommerce.py
import random

def generate_payload(num_orders: int = 500000):
    """
    Generates a massive, fragmented list of nested Python dictionaries.
    This simulates a typical JSON payload from a database or API.
    """
    orders = []
    for i in range(num_orders):
        order = {
            "order_id": i,
            "user": {
                "id": random.randint(1, 10000),
                "is_vip": random.choice([True, False, False, False]) # 25% VIP ratio
            },
            "cart": {
                "total_value": random.uniform(10.0, 500.0),
                "item_count": random.randint(1, 10)
            },
            "status": "PROCESSED"
        }
        orders.append(order)
    return orders

def calculate_vip_revenue(orders: bytes) -> float:
    """
    Sum the total cart values, but ONLY for VIP users.
    Accepts raw JSON bytes directly from the network buffer.
    """
    import json
    data = json.loads(orders.decode('utf-8'))
    total_revenue = 0.0
    for order in data:
        if order["user"]["is_vip"]:
            total_revenue += order["cart"]["total_value"]
            
    return total_revenue
