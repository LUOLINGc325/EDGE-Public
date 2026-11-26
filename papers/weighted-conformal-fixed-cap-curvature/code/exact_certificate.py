"""Finite rational checks for the weighted-conformal Simes coefficient."""
from fractions import Fraction as Q
from itertools import product
from math import comb, prod


def compositions(total, parts):
    if parts == 1:
        yield (total,)
        return
    for first in range(total + 1):
        for rest in compositions(total - first, parts - 1):
            yield (first, *rest)


def sum_weights(counts, band_masses):
    left = sum(counts)
    ways = 1
    for count in counts:
        ways *= comb(left, count)
        left -= count
    return ways * prod(p**count for p, count in zip(band_masses, counts))


def rejects(counts):
    running = 0
    for threshold, count in enumerate(counts[:-1], start=1):
        running += count
        if running >= threshold:
            return True
    return False


def add_bands(counts, *bands):
    counts = list(counts)
    for band in bands:
        counts[band] += 1
    return counts


def forced(m, masses, *bands):
    return sum(
        sum_weights(counts, masses)
        for counts in compositions(m - len(bands), m + 1)
        if rejects(add_bands(counts, *bands))
    )


def curvature_check(m, q):
    bands = (q / m,) * m + (1 - q,)
    thresholds = tuple(k * q / m for k in range(1, m + 1))
    pair = [[forced(m, bands, i, j) for j in range(m + 1)] for i in range(m + 1)]
    hessian = [
        [
            m * (m - 1) * (pair[i][j] - pair[i + 1][j] - pair[i][j + 1] + pair[i + 1][j + 1])
            for j in range(m)
        ]
        for i in range(m)
    ]
    curvatures = []
    for band in range(m + 1):
        direction = [int(band <= j) - t for j, t in enumerate(thresholds)]
        quadratic = sum(
            direction[i] * hessian[i][j] * direction[j]
            for i, j in product(range(m), repeat=2)
        )
        finite_difference = m * (m - 1) * (
            pair[band][band] - 2 * forced(m, bands, band) + q
        )
        assert quadratic == finite_difference
        curvatures.append(quadratic)
    assert sum(a * b for a, b in zip(bands, curvatures)) == 0
    assert curvatures[0] == -m * (m - 1) * (1 - q)
    assert curvatures[-1] == 0
    return curvatures


def atom_overlap(lo, hi, left, right):
    return max(Q(0), min(hi, right) - max(lo, left)) / (hi - lo)


def atom_check(q, lo, hi):
    a = atom_overlap(lo, hi, Q(0), q / 2)
    b = atom_overlap(lo, hi, q / 2, q)
    u, v = a - q / 2, a + b - q
    assert 2 * v*v - 4*u*v <= 2 * (1 - q) * (b - a)


def cdf(q_masses, weights, counts, threshold):
    score_totals = [w * c for w, c in zip(weights, counts)]
    total = sum(score_totals)
    cumulative, out = 0, Q(0)
    for mass, weight, score_total in zip(q_masses, weights, score_totals):
        fraction = (threshold * (total + weight) - cumulative) / (score_total + weight)
        out += mass * min(Q(1), max(Q(0), fraction))
        cumulative += score_total
    return out


def finite_n(m, q, n, masses, weights):
    p_masses = [mass / weight for mass, weight in zip(masses, weights)]
    p_masses = [mass / sum(p_masses) for mass in p_masses]
    thresholds = [k * q / m for k in range(1, m + 1)]
    unconditional = [Q(0)] * m
    fdr = Q(0)
    for counts in compositions(n, len(masses)):
        prob = sum_weights(counts, p_masses)
        cdfs = [cdf(masses, weights, counts, t) for t in thresholds]
        for j, g in enumerate(cdfs):
            unconditional[j] += prob * g
        band_masses = [b - a for a, b in zip([Q(0), *cdfs], [*cdfs, Q(1)])]
        fdr += prob * forced(m, band_masses)
    assert unconditional == thresholds
    return fdr


def optimal_two(q, cap):
    return (cap - 1) * (1 - q) * q / 2 * (1 - (1 - 1 / cap) * q / 2)


def decimal_interval(value, places=8):
    unit = 10**places
    lower = value * unit
    lower = lower.numerator // lower.denominator
    whole, frac = divmod(lower, unit)
    high_whole, high_frac = divmod(lower + 1, unit)
    return f"[{whole}.{frac:0{places}d}, {high_whole}.{high_frac:0{places}d}]"


def main():
    qs = (Q(1, 20), Q(1, 5), Q(1, 2), Q(4, 5), Q(19, 20))
    for m, q in product(range(2, 7), qs):
        curvatures = curvature_check(m, q)
        if m == 2:
            assert curvatures == [-2 * (1 - q), 2 * (1 - q), 0]
    print("25 forced-band Hessians, curvature sums and boundary cases: exact")

    intervals = 0
    for q in qs:
        grid = sorted({Q(i, 20) for i in range(21)} | {q / 2, q})
        for i, lo in enumerate(grid):
            for hi in grid[i + 1:]:
                atom_check(q, lo, hi)
                intervals += 1
    print(f"{intervals} contiguous-atom inequalities: exact")

    tested = 0
    for q, cap in product(qs, (Q(1), Q(3, 2), Q(2), Q(7))):
        masses = (q / 2, q / 2, 1 - q)
        weights = (Q(1), cap, Q(1))
        d = (-2 * (1 - q), 2 * (1 - q), Q(0))
        coefficient = (
            sum(mass / w for mass, w in zip(masses, weights))
            * sum(mass * w * curvature for mass, w, curvature in zip(masses, weights, d))
            / 2
        )
        assert coefficient == optimal_two(q, cap)
        tested += 1
    print(f"{tested} sharp three-score coefficients: exact")

    q, cap = Q(1, 2), Q(2)
    assert optimal_two(q, cap) == Q(7, 64)
    masses = (q / 2, q / 2, 1 - q)
    weights = (Q(1), cap, Q(1))
    print("q=1/2, B=2: sharp coefficient 7/64")
    for n in (16, 32, 64, 128):
        fdr = finite_n(2, q, n, masses, weights)
        assert fdr > q
        print(f"n={n}: n(FDR-q) in {decimal_interval(n * (fdr - q))}; exact marginals")
    alternate = finite_n(3, Q(3, 10), 6, (Q(1, 5), Q(1, 2), Q(3, 10)),
                         (Q(1), Q(3), Q(2)))
    assert 0 < alternate < 1
    print("One three-test straddling-atom finite-sample case: exact marginals")


if __name__ == "__main__":
    main()
