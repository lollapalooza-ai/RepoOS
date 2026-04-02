# Final Comprehensive Latency Report

| Task | CPython Res | Poly-Kernel Res | Py Time | JIT Time | Speedup |
| :--- | :---: | :---: | :---: | :---: | :---: |
| Scalar Gravity Math | 613880.7951070336 | 613880.7951070336 | 0.0908s | 0.1703s | 0.5x |
| Security: Password Check | False | 0.0 | 0.0261s | 0.0112s | 2.3x |
| Branching: Tax Logic | 8.0 | 8.0 | 0.0282s | 0.0706s | 0.4x |
| Conditional: Pricing | 75.0 | 75.0 | 0.0564s | 0.1672s | 0.3x |
| Aggregator: VIP Revenue | 639845.02 | 639845.02 | 0.0003s | 0.0000s | 31.5x |
| End-to-End Zero-Copy Scan | Processed | Processed | 0.1493s | 0.0000s | 19364.9x |
| **TOTAL** | - | - | **0.3510s** | **0.4193s** | **0.8x** |
