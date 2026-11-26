"""Exact polynomial certificate for the three-base rank-two covariance bound."""
import json
from collections import Counter
from fractions import Fraction as Q
from functools import lru_cache
from itertools import combinations, permutations, product


BASES = tuple(combinations(range(6), 2))
POWERS = tuple((a, b, 5-a-b) for a in range(6) for b in range(6-a))
POSITION = {powers: index for index, powers in enumerate(POWERS)}


@lru_cache(maxsize=None)
def matching_outcomes(left, right):
    common = set(left) & set(right)
    left_difference = sorted(set(left) - common)
    right_difference = sorted(set(right) - common)
    out = []
    for perm in permutations(right_difference):
        pairs = tuple(zip(left_difference, perm))
        branches = []
        for bits in product((0, 1), repeat=len(pairs)):
            basis = common | {pair[bit] for pair, bit in zip(pairs, bits)}
            right_wins = sum(bits)
            branches.append((tuple(sorted(basis)), len(pairs)-right_wins, right_wins))
        out.append(tuple(branches))
    return tuple(out)


@lru_cache(maxsize=None)
def expand(exponents, s_power, w_power):
    """Multiply a monomial by (a+b)^s_power (a+b+c)^w_power."""
    coefficients = {exponents: 1}
    steps = [(0, 1)]*s_power + [(0, 1, 2)]*w_power
    for factors in steps:
        updated = Counter()
        for powers, coefficient in coefficients.items():
            for factor in factors:
                next_powers = list(powers)
                next_powers[factor] += 1
                updated[tuple(next_powers)] += coefficient
        coefficients = updated
    return coefficients


def coefficients(event, marginals, left_wins, right_wins, matching):
    # Integer coefficients after multiplying the covariance by (a+b)^2 (a+b+c)^3.
    total = [0]*len(POWERS)
    for basis, left, right in matching:
        if event.intersection(basis):
            continue
        includes = int(0 in basis)
        for index, marginal in enumerate(marginals):
            multiplier = marginal - includes
            if multiplier == 0:
                continue
            exponents = [left_wins, right_wins, right]
            exponents[index] += 1
            terms = expand(tuple(exponents), 2-left_wins-right_wins+left, 2-left-right)
            for powers, coefficient in terms.items():
                total[POSITION[powers]] += multiplier*coefficient
    return total


def componentwise_max(vectors):
    return [max(values) for values in zip(*vectors)]


def certify_bound(event_size):
    event = set(range(1, event_size+1))
    envelopes = {distance: None for distance in range(3)}
    counts = Counter()
    for first, second, third in product(BASES, repeat=3):
        marginals = tuple(int(0 in basis) for basis in (first, second, third))
        distance = len(set(first) - set(second))
        for first_matching in matching_outcomes(first, second):
            counts[distance] += 1
            value = [0]*len(POWERS)
            for middle, left_wins, right_wins in first_matching:
                matching_vectors = [
                    coefficients(event, marginals, left_wins, right_wins, matching)
                    for matching in matching_outcomes(middle, third)
                ]
                value = [a+b for a, b in zip(value, componentwise_max(matching_vectors))]
            old = envelopes[distance]
            envelopes[distance] = value if old is None else componentwise_max((old, value))

    assert counts == {0: 225, 1: 1800, 2: 2700}
    sharp = expand((1, 1, 1), 2, 0)
    for distance, vector in envelopes.items():
        expected = dict(sharp) if distance else {}
        if event_size == 2 and distance == 2:
            expected[(2, 2, 1)] = 1
        assert all(coefficient <= sharp.get(powers, 0)
                   for powers, coefficient in zip(POWERS, vector))
        assert all(coefficient == expected.get(powers, 0)
                   for powers, coefficient in zip(POWERS, vector))
    return [
        {
            "event_size": event_size,
            "first_difference_size": distance,
            "first_matching_cases": counts[distance],
            "coefficient_maxima": [
                envelopes[distance][POSITION[p]] for p in ((1, 3, 1), (2, 2, 1), (3, 1, 1))
            ],
        }
        for distance in range(3)
    ]


def check_attainment():
    samples = [(Q(1, 3), Q(1, 3), Q(1, 3)), (Q(1, 5), Q(3, 10), Q(1, 2))]
    for a, b, c in samples:
        s = a + b
        first = matching_outcomes((1, 2), (2, 3))[0]
        dist = Counter()
        for middle, left, right in first:
            first_prob = (a/s)**left * (b/s)**right
            second = matching_outcomes(middle, (4, 5))[0]
            for final, left, right in second:
                dist[final] += first_prob*s**left*c**right
        assert sum(dist.values()) == 1
        marginal = sum(p for basis, p in dist.items() if 1 in basis)
        misses = sum(p for basis, p in dist.items() if not {2, 5}.intersection(basis))
        overlap = sum(p for basis, p in dist.items()
                      if 1 in basis and not {2, 5}.intersection(basis))
        assert (marginal, misses, overlap) == (a, b*c, 0)
        assert marginal*misses-overlap == a*b*c
    return len(samples)


if __name__ == "__main__":
    result = {
        "script": "code/checks.py",
        "arithmetic": "integer_polynomials_and_fractions.Fraction",
        "status": "pass",
        "degree_five_monomials": len(POWERS),
        "coefficient_tables": certify_bound(2) + certify_bound(3),
        "exact_attainment_examples": check_attainment(),
    }
    print(json.dumps(result, indent=2))
