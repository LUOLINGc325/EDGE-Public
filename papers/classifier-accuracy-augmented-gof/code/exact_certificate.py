"""Rational checks of the equalized Poisson occupancy formulas."""
from fractions import Fraction as F
from itertools import product
from math import prod


def exp_positive_enclosure(x):
    assert x >= 0
    order = max(45, 2 * int(x) + 2)
    partial = term = F(1)
    for j in range(1, order + 1):
        term *= x / j
        partial += term
    rest = (term * x / (order + 1)) / (1 - x / (order + 2))
    return partial, partial + rest


def exp_enclosure(x):
    if x >= 0:
        return exp_positive_enclosure(x)
    a, b = exp_positive_enclosure(-x)
    return 1 / b, 1 / a


def ceil(x):
    return -(-x.numerator // x.denominator)


def clone(p, q):
    k = len(p)
    p_new, q_new = [], []
    for pi, qi in zip(p, q, strict=True):
        copies = max(1, ceil(k * qi))
        p_new.extend([pi / copies] * copies)
        q_new.extend([qi / copies] * copies)
    assert sum(p_new) == sum(q_new) == 1
    assert max(q_new) <= F(1, k) and len(q_new) <= 2 * k
    assert sum(abs(pi - qi) for pi, qi in zip(p_new, q_new)) == sum(abs(pi - qi) for pi, qi in zip(p, q))
    return p_new, q_new


def audit_training(p, q, n):
    k = len(p)
    p_new, q_new = clone(p, q)
    lam = F(n, k)
    y = [n * (pi - qi) for pi, qi in zip(p_new, q_new)]
    assert all(yi >= -lam for yi in y) and sum(y) == 0
    assert sum(lam + yi for yi in y) == len(p_new) * lam
    empty = [exp_enclosure(-lam - yi) for yi in y]
    mu_lower = F(0)
    for yi, (lo, hi) in zip(y, empty, strict=True):
        mu_lower += yi * (1 - hi if yi >= 0 else 1 - lo)
    epsilon = sum(abs(pi - qi) for pi, qi in zip(p, q)) / 2
    target = F(n*n, 12*k) * epsilon**2
    assert mu_lower >= target
    tail_upper = F(0)
    for bits in product((0, 1), repeat=len(y)):
        if sum(yi * bit for yi, bit in zip(y, bits)) >= target / 2:
            continue
        tail_upper += prod(
            1 - lo if bit else hi
            for bit, (lo, hi) in zip(bits, empty, strict=True)
        )
    assert tail_upper <= exp_enclosure(-target / 128)[0]
    return epsilon, target


def check_mgf_points():
    checked = 0
    for lam, steps, s in product(
        (F(1, 8), F(1, 2), F(1)), range(-8, 35), (F(1, 48), F(1, 5), F(1, 2))
    ):
        y = F(steps, 8)
        if y < -lam or not y:
            continue
        pi_lo, pi_hi = exp_enclosure(-lam - y)
        null_lo, null_hi = exp_enclosure(-lam)
        # For W=y(B-E B), mgf = exp(s*y*(1-pi))*(pi+(1-pi)*exp(-s*y)).
        center_hi = exp_enclosure(s * y * (1 - (pi_lo if y >= 0 else pi_hi)))[1]
        flip_hi = exp_enclosure(-s * y)[1]
        mgf_hi = center_hi * (pi_hi + (1 - pi_lo) * flip_hi)
        mu_lo = y * ((null_lo - pi_hi) if y >= 0 else (null_hi - pi_lo))
        assert mgf_hi <= exp_enclosure(6*s*s*mu_lo)[0]
        checked += 1
    return checked


def main():
    experiments = [
        ((F(0), F(1, 2), F(1, 2)), (F(3, 4), F(1, 4), F(0))),
        ((F(1, 2), F(0), F(1, 2)), (F(1, 3), F(1, 3), F(1, 3))),
        ((F(0), F(1), F(0), F(0)), (F(1, 5), F(1, 10), F(1, 2), F(1, 5))),
    ]
    count = 0
    for p, q in experiments:
        for n in range(1, len(p) + 1):
            audit_training(p, q, n)
            count += 1
    print(f"Clone mass, TV, separation and lower-tail checks on finite padded systems: {count}")
    print(f"Rational exponential-enclosure checks of the single-cell MGF bound: {check_mgf_points()}")
    example = audit_training(*experiments[0], 3)
    print(f"First example, n=3: TV={example[0]}, rigorous lower bound on n times mean separation={example[1]}")


if __name__ == "__main__":
    main()
