import sys
import json
import uuid
import timeit

from component6_hijacker import boot_poly_kernel
boot_poly_kernel("revenue_app")

import revenue_app.job

print("Generating dummy payload for benchmark...")
payload = []
for i in range(10000):
    payload.append({
        "id": str(uuid.uuid4()),
        "user": {"id": 1, "is_vip": (i % 5 == 0)},
        "cart": {"total_value": 150.0},
        "status": "PROCESSED" if i % 2 == 0 else "PENDING"
    })
raw_bytes = json.dumps(payload).encode('utf-8')

# We know the AST chunker extracted the vip loop into this synthetic function
def run_bench(payload_bytes):
    return revenue_app.job.__repoos_synthetic_fsm_001(payload_bytes)

print("Warming up...")
for _ in range(10): run_bench(raw_bytes)

print("Benchmarking...")
iters = 50
total_time = timeit.timeit(lambda: run_bench(raw_bytes), number=iters)
avg_time = (total_time / iters) * 1000
res = run_bench(raw_bytes)

print(f"  - Avg Speed: {avg_time:.4f} ms")
print(f"  - Final Result[0,0]: {res:.4f}")
