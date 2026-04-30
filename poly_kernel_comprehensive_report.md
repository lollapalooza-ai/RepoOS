# Final Comprehensive Latency Report (with Auto-Fallback)

| Task | CPython Res | Poly-Kernel Res | Py Time/CPU/Mem | JIT Time/CPU/Mem | Speedup | Status |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| Scalar Gravity Math | 613880.7951070336 | 613880.7951070336 | 0.0836s / 0.08s / 0.00MB | 0.0836s / 0.08s / 0.00MB | 1.0x | FALLBACK TO CPython |
| Security: Password Check | False | 0.0 | 0.0254s / 0.03s / 0.05MB | 0.0113s / 0.01s / 0.00MB | 2.2x | JIT Active |
| Branching: Tax Logic | 8.0 | 8.0 | 0.0251s / 0.03s / 0.00MB | 0.0251s / 0.03s / 0.00MB | 1.0x | FALLBACK TO CPython |
| Conditional: Pricing | 75.0 | 75.0 | 0.0498s / 0.05s / 0.00MB | 0.0498s / 0.05s / 0.00MB | 1.0x | FALLBACK TO CPython |
| Aggregator: VIP Revenue | 31751587.94 | 31751587.94 | 6.1330s / 0.74s / 636.08MB | 0.0553s / 0.06s / 0.00MB | 111.0x | JIT Active |
| End-to-End Zero-Copy Scan | Processed | Processed | 0.0680s / 0.07s / 84.55MB | 0.0000s / 0.00s / 0.00MB | 10524.1x | JIT Active |
| **TOTAL** | - | - | **6.3848s** | **0.2251s** | **28.4x** | - |
