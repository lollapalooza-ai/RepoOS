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

def calculate_vip_revenue(orders: list) -> float:
    """
    The Target Logic: Sum the total cart values, but ONLY for VIP users.
    In CPython, this causes massive dictionary hash lookups and L1 cache misses.
    """
    total_revenue = 0.0
    for order in orders:
        # 3 Dictionary Lookups per iteration!
        if order["user"]["is_vip"]:
            total_revenue += order["cart"]["total_value"]
            
    return total_revenue
