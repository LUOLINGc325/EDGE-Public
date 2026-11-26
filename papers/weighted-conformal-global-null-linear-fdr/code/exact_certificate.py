"""Exact finite checks of the weighted-conformal global-null proof."""
from fractions import Fraction as F
from itertools import product
from math import comb, prod


def count_vectors(total, cells):
    if cells == 1:
        yield (total,)
        return
    for count in range(total + 1):
        for rest in count_vectors(total - count, cells - 1):
            yield (count, *rest)


def multinomial_probability(counts, probabilities):
    remaining = sum(counts)
    result = F(1)
    for count, probability in zip(counts, probabilities, strict=True):
        result *= comb(remaining, count) * probability**count
        remaining -= count
    return result


def binomial_tail(trials, probability, cutoff):
    return sum(
        comb(trials, count) * probability**count * (1 - probability)**(trials - count)
        for count in range(cutoff, trials + 1)
    )


def exp_enclosure(x):
    """Rational enclosure via a positive Taylor sum and a ratio bound."""
    assert x >= 0
    order = max(24, 2 * int(x) + 2)
    term = total = F(1)
    for j in range(1, order + 1):
        term *= x / j
        total += term
    remainder_upper = (term * x / (order + 1)) / (1 - x / (order + 2))
    return total, total + remainder_upper


def cdf_given_calibration(probabilities, weights, scores, counts):
    total = sum(w * c for w, c in zip(weights, counts, strict=True))
    mass = tuple(p * w for p, w in zip(probabilities, weights, strict=True))
    normalizer = sum(mass)
    pieces = []
    for probability, weight, score in zip(mass, weights, scores, strict=True):
        below = sum(w * c for w, s, c in zip(weights, scores, counts) if s < score)
        tie = sum(w * c for w, s, c in zip(weights, scores, counts) if s == score)
        lo = F(below, total + weight)
        hi = F(below + tie + weight, total + weight)
        pieces.append((probability / normalizer, lo, hi))

    def cdf(threshold):
        return sum(
            mass * max(0, min(1, (threshold - lo) / (hi - lo)))
            for mass, lo, hi in pieces
        )

    return cdf


def rejection_probability(cdf_values, m):
    endpoints = [0, *cdf_values, 1]
    bands = tuple(hi - lo for lo, hi in zip(endpoints, endpoints[1:]))
    no_rejection = F(0)
    for vector in count_vectors(m, m + 1):
        cumulative = 0
        for k, within_band in enumerate(vector[:-1], 1):
            cumulative += within_band
            if cumulative >= k:
                break
        else:
            no_rejection += multinomial_probability(vector, bands)
    return 1 - no_rejection


def exact_case(probabilities, weights, scores, n, m, q, rho=None):
    bound = max(weights)
    grid = [q * k / m for k in range(1, m + 1)]
    tau = F(bound, n + 1)
    window_mass = [F(0)] * (m + 1)
    window_good = [F(0)] * (m + 1)
    window_bad = [F(0)] * (m + 1)
    fdr = F(0)
    checkpoints = {0, 1, *grid}
    checkpoints.update(max(0, t - tau) for t in grid)
    checkpoints.update(min(1, t + tau) for t in grid)
    marginal = dict.fromkeys(checkpoints, F(0))
    for vector in count_vectors(n, len(weights)):
        weight = multinomial_probability(vector, probabilities)
        cdf = cdf_given_calibration(probabilities, weights, scores, vector)
        fdr += weight * rejection_probability([cdf(t) for t in grid], m)
        for t in checkpoints:
            marginal[t] += weight * cdf(t)
        for k in range(2, m + 1):
            t = grid[k - 1]
            b = min(t + tau, F(1))
            low, high = cdf(max(0, t - tau)), cdf(b)
            window = binomial_tail(m - 1, high, k - 1) - binomial_tail(m - 1, low, k - 1)
            window_mass[k] += weight * window
            if rho is not None:
                if high <= rho * (t + tau):
                    window_good[k] += weight * window
                else:
                    window_bad[k] += weight * window
    assert all(marginal[t] == t for t in checkpoints)
    weighted_windows = sum((k - 1) * window_mass[k] for k in range(2, m + 1))
    assert fdr / q - 1 <= weighted_windows

    if rho is not None:
        kappa = F(bound, n)
        mean_weight = sum(p * w for p, w in zip(probabilities, weights, strict=True))
        bar_b = bound / mean_weight
        a = n * q * (rho - 1 - kappa)**2 / (2 * bar_b * m * (3 * rho - 2 - 2 * kappa))
        beta = F(0)
        for k in range(2, m + 1):
            b = grid[k - 1] + tau
            tail = binomial_tail(m - 2, F(min(1, rho * b)), k - 2)
            assert window_good[k] <= (m - 1) * 2 * tau * tail
            assert window_bad[k] <= 1 / exp_enclosure(k * a)[1]
            assert window_mass[k] == window_good[k] + window_bad[k]
            beta += (k - 1) * tail
        alpha, delta = rho * q, rho * m * tau
        exponential_lower = exp_enclosure(1 - alpha)[0]
        ratio_lower = alpha * exponential_lower
        numerator_lower = exp_enclosure(2 * (1 - alpha) + delta * (1 / alpha - 1))[0]
        majorant_lower = numerator_lower / (1 - ratio_lower)**2
        final_bound_lower = 2 * (m - 1) * tau * majorant_lower + 1 / (exp_enclosure(a)[1] - 1)**2
        assert beta <= majorant_lower
        assert fdr / q - 1 <= final_bound_lower
    return fdr


def main():
    checked = 0
    for n, m, q in product((1, 2, 4, 6), (1, 2, 3, 4), (F(1, 10), F(2, 5), F(9, 10))):
        fdr = exact_case((F(1, 2), F(1, 3), F(1, 6)), (1, 2, 3), (0, 0, 1), n, m, q)
        if m == 1:
            assert fdr == q
        checked += 1
    print(f"Atomic score/weight cases with exact uniform marginals and window bound: {checked}")

    checked = 0
    for n, m, q in product((8, 16, 32), (2, 3, 5), (F(1, 10), F(1, 5))):
        rho = F(3, 2)
        exact_case((F(2, 5), F(3, 5)), (1, 2), (0, 1), n, m, q, rho)
        checked += 1
    print(f"Exact per-threshold split and complete quantitative bound cases: {checked}")

    fdr = exact_case((F(3, 4), F(3, 20), F(1, 10)), (1, 3, 50), (2, 1, 0), 5, 2, F(4, 5))
    print(f"Lim Appendix F.2 replication FDR: {fdr}")
    assert fdr > F(4, 5)


if __name__ == "__main__":
    main()
