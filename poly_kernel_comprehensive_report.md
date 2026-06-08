# Final Comprehensive Latency Report (with Auto-Fallback)

| Task | CPython Res | Poly-Kernel Res | Py Time/CPU/Mem | JIT Time/CPU/Mem | Speedup | Status |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| Scalar Gravity Math | 613880.7951070336 | 613880.7951070336 | 0.0546s / 0.05s / 0.00MB | 0.0546s / 0.05s / 0.00MB | 1.0x | FALLBACK TO CPython |
| Security: Password Check | False | 0.0 | 0.0266s / 0.03s / 0.03MB | 0.0122s / 0.01s / 0.00MB | 2.2x | JIT Active |
| Branching: Tax Logic | 8.0 | 8.0 | 0.0163s / 0.02s / 0.00MB | 0.0163s / 0.02s / 0.00MB | 1.0x | FALLBACK TO CPython |
| Conditional: Pricing | 75.0 | 75.0 | 0.0341s / 0.03s / 0.00MB | 0.0341s / 0.03s / 0.00MB | 1.0x | FALLBACK TO CPython |
| End-to-End Zero-Copy Scan | Processed | Processed | 0.0813s / 0.08s / 16.20MB | 0.0000s / 0.00s / 0.00MB | 11337.1x | JIT Active |
| **TOTAL** | - | - | **0.2129s** | **0.1172s** | **1.8x** | - |
