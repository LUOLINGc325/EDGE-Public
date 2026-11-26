"""Reproduce exact inflation-tail checks and the paper's large numerical example.

Requires Python 3.10 or newer and only its standard library.
"""

from collections import Counter
from fractions import Fraction
from itertools import combinations
from math import comb, exp, lgamma, log, log1p


def binomial_mass(size, prob, count):
    return comb(size, count) * prob**count * (1 - prob)**(size - count)


def binomial_cdf(size, prob, count):
    return sum(binomial_mass(size, prob, i) for i in range(count + 1))


def pooled_spacing_counts(n, k, m, block):
    """Count how many uniform spacings the round-up skips in each rank order."""
    total = n + m
    ranks = tuple(range(1, total + 1))
    counts = Counter()
    for private in combinations(ranks, n):
        start = private[k - 1]
        public = [rank for rank in ranks if rank not in private]
        for offset in range(block):
            end = next((rank for rank in public[offset::block] if rank > start),
                       total + 1)
            counts[end - start] += 1
    return counts


def exact_excess_checks():
    """Compare a pooled-spacing mixture with Theorem 1 at rational x."""
    trials = 0
    for n in range(1, 5):
        for k in range(1, n + 1):
            for m in range(1, 5):
                for block in range(1, m + 3):
                    counts = pooled_spacing_counts(n, k, m, block)
                    for x in (Fraction(0), Fraction(1, 5), Fraction(1, 2),
                              Fraction(4, 5)):
                        # d pooled uniform spacings have the Beta(d,N+1-d) law.
                        direct = sum(
                            count * binomial_cdf(n + m, x, d - 1)
                            for d, count in counts.items()
                        ) / sum(counts.values())
                        private_tail = 1 - binomial_cdf(n, 1 - x, k - 1)
                        public_tail = sum(
                            Fraction(block - z, block) * binomial_mass(m, x, z)
                            for z in range(min(m, block - 1) + 1)
                        )
                        assert direct == private_tail * public_tail
                        trials += 1
    print(f"{trials} exact inflation tails matched pooled-order enumeration.")


def binomial_remote_tail(n, p, start, step):
    """Sum a remote binomial tail from its end nearest the mean outward."""
    log_mass = (lgamma(n + 1) - lgamma(start + 1) - lgamma(n - start + 1)
                + start * log(p) + (n - start) * log1p(-p))
    i, weight, total_weight = start, 1.0, 1.0
    if step == 1:
        assert start >= n * p
    else:
        assert step == -1 and start <= n * p
    while 0 <= i + step <= n:
        if step == 1:
            weight *= (n - i) * p / ((i + 1) * (1 - p))
        else:
            weight *= i * (1 - p) / ((n - i + 1) * p)
        i += step
        total_weight += weight
        if weight < total_weight * 1e-18:
            break
    return exp(log_mass) * total_weight


def show_paper_example():
    n, k, m, block = 500000, 450001, 800, 4
    a, c = k, n + 1 - k

    def log_beta(x, y):
        return lgamma(x) + lgamma(y) - lgamma(x + y)

    spread = 4 * exp(log_beta(2 * a, 2 * c) - 2 * log_beta(a, c)) / (a + c)
    disagreement_bound = m * spread / block
    inflation_bound = Fraction(block + 1, 2 * (m + 1))
    pilot_failure = binomial_cdf(m, Fraction(1, 100), block - 1)
    # Order-statistic beta tails are ordinary binomial tails.
    private_failure = (binomial_remote_tail(n, .89, k, 1)
                       + binomial_remote_tail(n, .91, k - 1, -1))
    assert .0957456 < disagreement_bound < .095746
    assert inflation_bound == Fraction(5, 1602)
    assert Fraction(41665, 10**6) < pilot_failure < Fraction(41666, 10**6)
    assert private_failure < 2e-116
    print(f"Ex ante disagreement bound  {disagreement_bound:.9f}")
    print(f"Mean inflation bound        {inflation_bound}")
    print(f"Pilot failure probability   {float(pilot_failure):.9f}")
    print(f"Private failure probability {private_failure:.5e}")


if __name__ == "__main__":
    exact_excess_checks()
    show_paper_example()
