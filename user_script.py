# user_script.py

# 1. Boot the OS layer
from component6_hijacker import boot_poly_kernel
boot_poly_kernel("legacy_shop")

# 2. Standard Developer Code
import legacy_shop.utils

print("Developer: Calling legacy_shop.utils.dynamic_pricing(10.0, 1.5)")
# 10.0 * 1.5 = 15.0
result = legacy_shop.utils.dynamic_pricing(10.0, 1.5)

print(f"Developer: The final result is {result}")
