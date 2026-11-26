"""Exact finite checks of the bin-loss estimates and certificate parameters."""

from fractions import Fraction as Q
import json
from random import Random


def require(condition, context):
    if not condition:
        raise RuntimeError(str(context))


def minus_log_enclosure(q, terms=32):
    z = 1 - q
    lower = sum(z**k / k for k in range(1, terms + 1))
    return lower, lower + z ** (terms + 1) / ((terms + 1) * q)


def exp_minus_enclosure(x, terms=24):
    value = term = Q(1)
    for k in range(1, terms + 1):
        term *= -x / k
        value += term
    return value - term * x / (terms + 1), value


def verify_cutoff_grid():
    random = Random(20261125)
    cutoff_checks = early_checks = late_checks = 0
    for case in range(48):
        q = Q(random.randint(4, 19), 20)
        n = random.randint(2, 14)
        values = sorted([1] + [random.randint(0, 30)
                               for _ in range(random.randint(2, 9))],
                        reverse=True)
        # The grid is expressed in units of -log(q) in the scaled mark hx.
        lo, hi = minus_log_enclosure(q)
        p = sum(v * q**(n * j) * (1 - q**n)
                for j, v in enumerate(values))
        for size in range(1, len(values) + 1):
            payoffs = values[:size]
            active = 1 - q**size
            discrete = sum(v * q**j * (1 - q)
                           for j, v in enumerate(payoffs))
            continuous = active * Q(sum(payoffs), size)
            loss = discrete - continuous
            require(0 <= loss <= Q(size, 2) * lo * discrete,
                    (case, size, "raw cutoff loss"))
            cutoff_checks += 1
            for remaining in range(n):
                future_none = q**(size * remaining)
                if payoffs[-1] * active >= (1 - future_none) * discrete:
                    require(loss <= Q(size, 2) * lo * future_none * discrete,
                            (case, size, remaining, "early cutoff loss"))
                    early_checks += 1
        for previous in range(1, n):
            count = previous + 1
            b = Q(1, count**2) + Q(1, previous * count)

            def primitive(j, lam):
                return (j * lam / count + b) * q**(j * count)

            # The exact integral is affine in lambda = -log(q). Checking
            # both enclosure endpoints validates the analytic integral bound.
            for lam in (lo, hi):
                weighted = sum(
                    v * (primitive(j, lam) - primitive(j + 1, lam))
                    for j, v in enumerate(values)
                ) / 2
                require(0 <= weighted <= p * b / 2
                        <= p / (previous * count),
                        (case, previous, "late exponential comparison"))
            late_checks += 1
    return {"profiles": 48, "raw_cutoffs": cutoff_checks,
            "eligible_early_cutoffs": early_checks, "late_integrals": late_checks}


def verify_two_level():
    a = Q(1, 4)
    ea_lo, ea_hi = exp_minus_enclosure(a)
    eb_lo, eb_hi = exp_minus_enclosure(2 * a)
    require(2 * (1 - eb_lo) < 1, "every positive mark is accepted")
    p_lo, p_hi = 2 - ea_hi - eb_hi, 2 - ea_lo - eb_lo
    limit_lo = a * (1 - eb_hi) / (4 * p_hi)
    limit_hi = a * (1 - eb_lo) / (4 * p_lo)
    previous_upper = Q(0)
    counts = (1, 2, 3, 8, 32, 128, 512, 4096)
    for n in counts:
        lo, hi = exp_minus_enclosure(a / n)
        # For b=2a the first term inside the bracket is 1/(1+exp(-a/n)).
        gap_lo = n * (1 - eb_hi) * (1 / (1 + hi) - Q(1, 2)) / p_hi
        gap_hi = n * (1 - eb_lo) * (1 / (1 + lo) - Q(1, 2)) / p_lo
        require(previous_upper < gap_lo <= gap_hi < limit_lo,
                (n, "scaled positive two-level gap"))
        previous_upper = gap_hi
    require(Q(39, 1000) < limit_lo <= limit_hi < Q(41, 1000),
            "positive limiting coefficient")
    return {"horizons": list(counts),
            "limit_enclosure": ["39/1000", "41/1000"],
            "strict_increase_on_sample": True}


def verify_rational_budget():
    parameters = []
    for eps in (Q(1, 2), Q(1, 9), Q(1, 100), Q(1, 1000), Q(1, 10000)):
        r = 1
        while Q(1, 2**r) > eps / 8:
            r += 1
        n = max(-(-12 // eps), 2 * r)
        m = -(-(3 * r) // eps)
        width = Q(3 * (n - 1) * r, 2 * n * m) + Q(1, 2**r) + Q(3, n)
        require(Q(0) < Q(r, n) <= Q(1, 2) and width < eps, eps)
        parameters.append({"epsilon": str(eps), "r": r, "n": n, "labels": m})
    return parameters


print(json.dumps({"cutoff_grid": verify_cutoff_grid(),
                  "sharp_order_witness": verify_two_level(),
                  "certificate_budget": verify_rational_budget()},
                 indent=2))
