"""Exact finite checks for the two-color nullity-chores approximation theorem."""
from collections import Counter, defaultdict
from itertools import combinations, combinations_with_replacement, product
from math import comb, factorial
from random import Random
import json


def ceil_div(a, b):
    return (a + b - 1) // b


def projection_pairs(words, mask):
    buckets = defaultdict(list)
    for item, word in enumerate(words):
        buckets[word & mask].append(item)
    return [pair for bucket in buckets.values()
            for pair in zip(bucket[::2], bucket[1::2])]


def projection_profile(words, n):
    maxima, supports = [], {}
    for s in range(1, n):
        peak = 0
        for coords in combinations(range(n), s):
            mask = sum(1 << i for i in coords)
            sizes = Counter(word & mask for word in words)
            matching_size = sum(size // 2 for size in sizes.values())
            peak = max(peak, matching_size)
            if matching_size >= n - s and s not in supports:
                supports[s] = coords
        maxima.append(peak)
    return maxima, supports


def rank_nullity(words, observer, items):
    return len(items) - len({(words[x] >> observer) & 1 for x in items})


def validates(words, allocation, factor):
    n = len(allocation)
    assert sorted(x for b in allocation for x in b) == list(range(len(words)))
    for i, own in enumerate(allocation):
        threshold = factor * min(rank_nullity(words, i, other) for other in allocation)
        if any(rank_nullity(words, i, own[:j] + own[j+1:]) > threshold for j in range(len(own))):
            return False
    return True


def balanced_witness(words, n, coords):
    s = len(coords)
    mask = sum(1 << i for i in coords)
    pairs = projection_pairs(words, mask)[:n-s]
    assert len(pairs) == n-s
    remaining = [x for x in range(len(words)) if all(x not in pair for pair in pairs)]
    bundles = [[] for _ in range(n)]
    for i, pair in zip((i for i in range(n) if i not in coords), pairs):
        bundles[i] = list(pair)
    for j, x in enumerate(remaining):
        bundles[coords[j % s]].append(x)
    return bundles


def published_gadget():
    n = 18
    seeds = ('011111100011001110', '011101110010011001', '100010101011010111')
    words = [int(seed[k:] + seed[:k], 2) for j, seed in enumerate(seeds)
             for k in range(1 if j == 2 else 0, n)]
    assert len(words) == len(set(words)) == 53
    profile, supports = projection_profile(words, n)
    s = max(supports)
    lower = max(1, ceil_div(n - 1, s) - 1)
    upper = ceil_div(n - 1, s)
    allocation = balanced_witness(words, n, supports[s])
    assert validates(words, allocation, upper)
    if not validates(words, allocation, lower):
        # Here one owner has five chores. A single exchange among the large bundles suffices.
        for i, j in combinations(supports[s], 2):
            for a in range(len(allocation[i])):
                for b in range(len(allocation[j])):
                    allocation[i][a], allocation[j][b] = allocation[j][b], allocation[i][a]
                    if validates(words, allocation, lower):
                        return gadget_result(words, profile, supports[s], allocation, lower)
                    allocation[i][a], allocation[j][b] = allocation[j][b], allocation[i][a]
    assert validates(words, allocation, lower)
    return gadget_result(words, profile, supports[s], allocation, lower)


def gadget_result(words, profile, support, allocation, factor):
    return dict(
        source='https://arxiv.org/html/2608.10572v1#S3.SS1',
        agents=18, chores=53,
        maximum_matching_by_s_1_to_17=profile,
        s_star=len(support), big_owners=list(support), optimal_factor=factor,
        word_order='cyclic left shift of each listed seed; offsets 0..17, 0..17, 1..17, respectively; least significant bit is agent 0',
        words_decimal=words, item_ids_by_owner=allocation,
    )


def exact_finite_bound(n):
    """Dyadic union bound, recorded only when its exact integer numerator is below one."""
    m = 3 * n - 1
    terms = []
    for s in range(1, n):
        r = n - s
        matchings = factorial(m) // (factorial(m - 2 * r) * (1 << r) * factorial(r))
        terms.append((comb(n, s) * matchings, s * r))
    max_power = max(power for _, power in terms)
    denominator = 1 << max_power
    numerator = 0
    best = None
    for s in range(n - 1, 0, -1):
        coeff, power = terms[s - 1]
        numerator += coeff << (max_power - power)
        if numerator >= denominator:
            break
        best = s, numerator
    assert best and best[0] >= 2
    t, numerator = best
    assert 0 < numerator < denominator
    # A compact exact rational upper bound rounded upwards to a multiple of 10^-6.
    millionths = ceil_div(10**6 * numerator, denominator)
    return dict(n=n, threshold_t=t, probability_upper_max_millionths=millionths,
                guaranteed_instance_lower=max(1, ceil_div(n-1, t-1)-1),
                all_instances_upper=ceil_div(n-1, n.bit_length()-1))


def all_cardinalities():
    rng = Random(20261124)
    counts = Counter()
    for n in range(2, 16):
        for m in range(6*n + 2):
            words = [rng.randrange(1 << n) for _ in range(m)]
            if m <= 2*n or m >= 3*n:
                bundles = [list(range(i, m, n)) for i in range(n)]
                if m <= 2*n or m % n == 0:
                    factor = 1
                else:
                    factor = 2
                branch = 'at_most_2n' if m <= 2*n else 'at_least_3n'
            else:
                d = m - 2*n
                s = (d + 1).bit_length() - 1
                factor = ceil_div(d, s)
                bundles = balanced_witness(words, n, tuple(range(s)))
                branch = 'between_2n_and_3n'
            assert validates(words, bundles, factor)
            counts[branch] += 1
    return dict(counts)


def small_direct():
    """Check both endpoints of the instance-specific bound by direct allocation enumeration."""
    samples = []
    # All joint-signature multisets for two agents; three-agent small representative supports.
    profiles = [(2, words) for words in combinations_with_replacement(range(4), 5)]
    profiles += [(3, tuple(range(8))), (3, (0, 0, 0, 1, 2, 4, 6, 7)),
                 (3, (7, 7, 7, 7, 7, 7, 7, 7))]
    for n, words in profiles:
        _, supports = projection_profile(words, n)
        s = max(supports)
        lower = max(1, ceil_div(n-1, s)-1)
        upper = ceil_div(n-1, s)
        assert validates(words, balanced_witness(words, n, supports[s]), upper)
        opt = None
        for f in range(1, upper + 1):
            for owners in product(range(n), repeat=len(words)):
                bundles = [[g for g, owner in enumerate(owners) if owner == i] for i in range(n)]
                if validates(words, bundles, f):
                    opt = f
                    break
            if opt is not None:
                break
        assert lower <= opt <= upper
        samples.append((lower, opt, upper))
    return dict(profiles=len(samples), endpoint_frequencies={str(k): v for k, v in Counter(samples).items()})


if __name__ == '__main__':
    print(json.dumps(dict(published_gadget=published_gadget(),
                          finite_worst_case_bounds=[exact_finite_bound(n) for n in (18, 32, 64, 128, 256, 512)],
                          direct_small_instances=small_direct(),
                          all_cardinalities_seed_20261124=all_cardinalities()), indent=2))
