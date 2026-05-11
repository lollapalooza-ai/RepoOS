import sys
import os

# Add the project root to sys.path so we can import components
sys.path.append(os.getcwd())

from component6_hijacker import boot_poly_kernel

# Boot the kernel for networkx
orchestrator = boot_poly_kernel("networkx")

import networkx as nx
from networkx.utils.random_sequence import cumulative_distribution

def main():
    dist = [1.0, 2.0, 3.0, 4.0, 5.0]
    cdf = cumulative_distribution(dist)
    print(f"CDF: {cdf}")

if __name__ == "__main__":
    main()
