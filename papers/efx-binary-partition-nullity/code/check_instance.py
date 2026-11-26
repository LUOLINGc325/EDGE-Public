"""Reconstruct and check a 2-EFX allocation of Lin et al.'s 18x53 instance."""

from collections import defaultdict
from fractions import Fraction
from itertools import combinations
import json

SEEDS = ("011111100011001110", "011101110010011001", "100010101011010111")
WORDS = tuple(seed[k:] + seed[:k] for source, seed in enumerate(SEEDS)
              for k in range(int(source == 2), len(seed)))
N = len(SEEDS[0])
M = len(WORDS)
LARGE = (0, 1, 4, 5, 9, 10, 14, 16)  # Coordinates are indexed from the right.

def bit(observer, chore):
    return WORDS[chore][N - 1 - observer]

def cost(observer, bundle):
    return len(bundle) - len({bit(observer, chore) for chore in bundle})

def check(bundles):
    assert len(bundles) == N
    assert sorted(chore for bundle in bundles for chore in bundle) == list(range(M))
    ratios = []
    for i, owned in enumerate(bundles):
        for g in owned:
            trim = [item for item in owned if item != g]
            numer = cost(i, trim)
            for comparison in bundles:
                denom = cost(i, comparison)
                if denom:
                    ratios.append(Fraction(numer, denom))
                else:
                    assert numer == 0
    return max(ratios, default=Fraction(0))

def build():
    projection = defaultdict(list)
    for g in range(M):
        signature = tuple(bit(i, g) for i in LARGE)
        projection[signature].append(g)
    pairs = [
        bucket[2*k:2*k+2]
        for bucket in projection.values()
        for k in range(len(bucket)//2)
    ]
    small = sorted(set(range(N)) - set(LARGE))
    assert len(pairs) >= len(small)
    pairs = pairs[:len(small)]
    free = [g for g in range(M) if not any(g in pair for pair in pairs)]
    bundles = [[] for _ in range(N)]
    for i, pair in zip(small, pairs, strict=True):
        bundles[i] = pair
    pivot = LARGE[0]
    zeros = [g for g in free if bit(pivot, g) == "0"]
    ones = [g for g in free if bit(pivot, g) == "1"]
    assert len(zeros) >= 2 and len(ones) >= 3
    bundles[pivot] = zeros[:2] + ones[:3]
    free = [g for g in free if g not in bundles[pivot]]
    assert len(free) == 4*(len(LARGE)-1)
    for k, i in enumerate(LARGE[1:]):
        bundles[i] = free[4*k:4*k+4]
    return bundles

def largest_feasible_large_set():
    """Exact lower certificate via the number of equal-signature pairs."""
    all_words = [int(word, 2) for word in WORDS]
    maxima = []
    for s in range(1, N):
        largest = 0
        for S in combinations(range(N), s):
            mask = sum(1 << i for i in S)
            odd = set()
            # Toggle each bucket representative. Unpaired items end in odd.
            for word in all_words:
                key = word & mask
                odd.symmetric_difference_update((key,))
            largest = max(largest, (M-len(odd))//2)
        maxima.append(largest)
    return maxima, max(s for s, h in enumerate(maxima, 1) if h >= N-s)

if __name__ == "__main__":
    assert len(set(WORDS)) == M == 53
    upper = check(build())
    assert upper == 2
    maxima, maximum_large = largest_feasible_large_set()
    assert maximum_large == 8
    lower = Fraction(N-1, maximum_large) - 1
    # Every feasible allocation has a pair seen at cost one by every big
    # owner, hence its sharp finite factor is an integer.
    assert lower > 1
    print(json.dumps({
        "agents": N, "chores": M, "bundles": build(),
        "maximum_number_of_pairs_by_large_set_size": maxima,
        "maximum_feasible_large_set_size": maximum_large,
        "structural_factor_lower_bound": str(lower),
        "sharp_factor": str(upper),
    }, indent=2))
