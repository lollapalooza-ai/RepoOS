# legacy_shop/heavy_math.py

def compute_gravity(mass1: float, mass2: float) -> float:
    """
    A simulated N-body gravity calculation.
    We run a heavy mathematical workload to expose Python's bytecode interpreter overhead.
    """
    result = 0.0
    # A pseudo-workload to force the CPU to churn
    result = (mass1 * mass2) / 9.81
    result = result + (mass1 * 0.5)
    result = result - (mass2 * 0.2)
    return result
