import ctypes
import json
import uuid

# Generate payload
payload = []
for i in range(10000):
    payload.append({
        "id": str(uuid.uuid4()),
        "user": {"id": 1, "is_vip": (i % 5 == 0)},
        "cart": {"total_value": 150.0},
        "status": "PROCESSED" if i % 2 == 0 else "PENDING"
    })
raw_bytes = json.dumps(payload).encode('utf-8')

# Load the C++ kernel
lib = ctypes.CDLL("./.poly_cache/revenue_app_job_run_bench_var1.dylib")

# Signature: void _mlir_ciface_main(const char* data, size_t len, float* out)
lib._mlir_ciface_main.argtypes = [ctypes.c_char_p, ctypes.c_size_t, ctypes.POINTER(ctypes.c_float)]
lib._mlir_ciface_main.restype = None

out_val = ctypes.c_float(0.0)
lib._mlir_ciface_main(raw_bytes, len(raw_bytes), ctypes.byref(out_val))

print(f"C++ Kernel Output: {out_val.value}")
