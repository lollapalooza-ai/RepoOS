# user_script.py

# 1. Boot the OS layer
from component6_hijacker import boot_poly_kernel
boot_poly_kernel("legacy_shop")

# 2. Standard Developer Code (They don't know the kernel is AI-driven)
# We import 'legacy_shop.utils' because 'calculate_tax' is there
import legacy_shop.utils

print("Developer: Calling legacy_shop.utils.calculate_tax(100.0, 1.0)")
# 1.0 is CA region in our current mapping
result = legacy_shop.utils.calculate_tax(100.0, 1.0)

print(f"Developer: The final result is {result}")
