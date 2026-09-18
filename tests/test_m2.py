import sys
import os
import asyncio
import time
from component6_hijacker import boot_poly_kernel

async def test_milestone2(orchestrator):
    # 2. Import the hijacked module
    print("\n[TEST] Importing ecommerce.cart...")
    from ecommerce.cart import Cart
    
    # 3. Instantiate and call method
    cart = Cart()
    payload = {"tax_rate": 0.05}
    
    print("[TEST] Calling Cart.calculate() - First call (Should fallback)...")
    start = time.time()
    result = cart.calculate(payload)
    end = time.time()
    print(f"[TEST] Result: {result}, Time: {end - start:.4f}s")
    
    # 4. Wait for background compilation (simulated)
    print("\n[TEST] Waiting for background compilation (60s)...")
    for _ in range(60):
        if "ecommerce.cart.Cart.calculate" in orchestrator.registry:
            print("✅ [TEST] Hot-swap detected in registry!")
            break
        await asyncio.sleep(1)
    
    # 5. Call again - Should be fast path (if compiled)
    print("[TEST] Calling Cart.calculate() - Second call (Should be fast path if hot-swapped)...")
    start = time.time()
    result = cart.calculate(payload)
    end = time.time()
    print(f"[TEST] Result: {result}, Time: {end - start:.4f}s")

if __name__ == "__main__":
    async def main():
        orchestrator = boot_poly_kernel("ecommerce")
        await test_milestone2(orchestrator)
        # Give some extra time for any remaining tasks
        await asyncio.sleep(5)
    
    asyncio.run(main())
