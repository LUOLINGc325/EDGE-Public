"""Independent finite stress checks for the robust-core lower-bound proof.

This is a finite check of identities, not a proof of the general theorem.
No floating point is used.
"""

from fractions import Fraction
from math import comb
import json


def all_ideals(n):
    """Bit-coded downward-closed families of subsets of an n-point set."""
    if n == 0:
        return [0, 1]
    old = all_ideals(n - 1)
    shift = 1 << (n - 1)
    return [lo | (hi << shift) for lo in old for hi in old if hi & ~lo == 0]


def subsets(mask):
    s = mask
    while True:
        yield s
        if s == 0:
            return
        s = (s - 1) & mask


def core(fam, active, n):
    good = 0
    feasible = [s for s in subsets(active) if fam & (1 << s)]
    for i in range(n):
        bit = 1 << i
        if active & bit and all(fam & (1 << (s | bit)) for s in feasible):
            good |= bit
    return good


def check_cores(n):
    tested_families = 0
    nested_checks = 0
    transfer_checks = 0
    for fam in all_ideals(n):
        if not fam & 1:
            continue
        tested_families += 1
        rank = max(s.bit_count() for s in range(1 << n) if fam & (1 << s))
        cores = [core(fam, r, n) for r in range(1 << n)]
        for r, cr in enumerate(cores):
            if not fam & (1 << cr):
                raise AssertionError(("core infeasible", n, fam, r, cr))
            for s in subsets(r):
                cs = cores[s]
                if not fam & (1 << (cs | cr)):
                    raise AssertionError(("union infeasible", n, fam, r, s))
                if cs.bit_count() + (cr & ~s).bit_count() > rank:
                    raise AssertionError(("pathwise bound", n, fam, r, s))
                nested_checks += 1
        averages = [
            Fraction(sum(cores[r].bit_count() for r in range(1 << n)
                         if r.bit_count() == size), comb(n, size))
            for size in range(n + 1)
        ]
        for high in range(1, n + 1):
            for low in range(high + 1):
                value = averages[low] + Fraction(high - low, high) * averages[high]
                if value > rank:
                    raise AssertionError(("layer transfer", n, fam, low, high, value))
                transfer_checks += 1
    return {
        "ground_size": n,
        "nonempty_downclosed_families": tested_families,
        "nested_pathwise_checks": nested_checks,
        "layer_average_checks": transfer_checks,
    }


def ceil_cube_root(k):
    a = 1
    while a ** 3 < k:
        a += 1
    return a


def check_counts(max_rank):
    samples = []
    for k in range(1, max_rank + 1):
        a = ceil_cube_root(k)
        b = (k + 2 * a - 1) // (2 * a)
        theta = Fraction(k, 2 * a * b)
        probs = {
            k - a: theta * Fraction(b, a + b),
            k: 1 - theta,
            k + b: theta * Fraction(a, a + b),
        }
        if not (1 <= a <= k and 1 <= b <= k and b * b <= a * k):
            raise AssertionError(("parameters", k, a, b))
        if sum(probs.values()) != 1 or min(probs.values()) < 0:
            raise AssertionError(("probabilities", k, probs))
        mean = sum(p * size for size, p in probs.items())
        variance = sum(p * (size - k) ** 2 for size, p in probs.items())
        pair = sum(p * size * (size - 1) for size, p in probs.items()) / (2 * k * (2 * k - 1))
        lower = theta * Fraction(b, k + b)
        # Cubing avoids irrational cube roots in the coarse asymptotic check.
        if not (mean == k and variance == Fraction(k, 2) and pair == Fraction(1, 4)):
            raise AssertionError(("moments", k, mean, variance, pair))
        if lower ** 3 * (8 ** 3 * k) < 1:
            raise AssertionError(("coarse bound", k, lower))
        if k <= 12 or k in (64, 125, 1000, max_rank):
            samples.append({"k": k, "a": a, "b": b,
                            "theta": str(theta), "loss_lower_bound": str(lower)})
    return {"max_rank": max_rank, "checks": max_rank, "samples": samples}


def check_cubic_sequence(max_m):
    for m in range(1, max_m + 1):
        k = 2 * m ** 3
        a, b = m, m * m
        if not (a * b == Fraction(k, 2) and b * b <= a * k):
            raise AssertionError(("cubic parameters", m))
        if Fraction(b, k + b) != Fraction(1, 2 * m + 1):
            raise AssertionError(("cubic lower bound", m))
    return {"max_m": max_m, "checks": max_m}


if __name__ == "__main__":
    report = {
        "status": "passed",
        "interpretation": "Finite exact stress checks only; general proof is in lower_agent.md.",
        "cores": [check_cores(n) for n in range(1, 6)],
        "three_layer_counts": check_counts(10000),
        "cubic_sequence": check_cubic_sequence(1000),
    }
    print(json.dumps(report, indent=2))
