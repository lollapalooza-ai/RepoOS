import uuid
import json

payload = []
for i in range(10000):
    payload.append({
        "id": str(uuid.uuid4()),
        "user": {"id": 1, "is_vip": (i % 5 == 0)},
        "cart": {"total_value": 150.0},
        "status": "PROCESSED" if i % 2 == 0 else "PENDING"
    })
raw_bytes = json.dumps(payload).encode('utf-8')

data = json.loads(raw_bytes.decode('utf-8'))
vip_rev = 0.0
for order in data:
    if order["user"]["is_vip"] and order["status"] == "PROCESSED":
        vip_rev += order["cart"]["total_value"]

print(f"Native Python Output: {vip_rev}")
