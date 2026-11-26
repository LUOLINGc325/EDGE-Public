"""Exact checks of the new finite-layer laws; no repeat of core-family enumeration."""

from fractions import Fraction as F
from math import prod, isqrt
import json


def add_at(law, x, p):
    law[x] = law.get(x, F(0)) + p


def two_layer(k, a, b):
    return {k - a: F(b, a + b), k + b: F(a, a + b)}


def mix(parts):
    law = {}
    for weight, component in parts:
        for count, p in component.items():
            add_at(law, count, weight * p)
    return law


def reflect(k, law):
    return {2 * k - x: p for x, p in law.items()}


def factorial_moment(law, r):
    return sum(p * prod(x - j for j in range(r)) for x, p in law.items())


def check_twise(k, law, t):
    if sum(law.values()) != 1 or any(p < 0 for p in law.values()):
        raise AssertionError(("probabilities", k, law))
    if any(x < 0 or x > 2 * k for x in law):
        raise AssertionError(("count support", k, law))
    for r in range(min(2 * k, t) + 1):
        target = F(prod(2 * k - j for j in range(r)), 2 ** r)
        observed = factorial_moment(law, r)
        if target != observed:
            raise AssertionError(("factorial moment", k, r, target, observed))


def threewise(k):
    a = 1
    while a ** 3 < k:
        a += 1
    b = (k + 2 * a - 1) // (2 * a)
    theta = F(k, 2 * a * b)
    base = mix([(theta, two_layer(k, a, b)), (1 - theta, {k: F(1)})])
    sym = mix([(F(1, 2), base), (F(1, 2), reflect(k, base))])
    check_twise(k, sym, 3)
    loss = F(k, 4 * a * (k + b))
    if loss ** 3 * 16 ** 3 * k < 1:
        raise AssertionError(("threewise coarse loss", k, loss))
    return {"k": k, "count_layers": len(sym), "loss": str(loss)}


def fivewise(m):
    k = m ** 10
    a, b = m ** 2, m ** 6
    original = two_layer(k, a, b)
    tail = mix([(F(1, 2), original), (F(1, 2), reflect(k, original))])
    w = F(m ** 10 - 1, 4 * m ** 2 * (m ** 8 - m ** 6 - m ** 4 + 1))
    u = F(1, 2) - w / m ** 2
    v = 1 - w - u
    middle = {k - m ** 5: F(1, 2), k + m ** 5: F(1, 2)}
    law = mix([(w, tail), (u, middle), (v, {k: F(1)})])
    if not F(1, 4) <= w <= F(1, 2):
        raise AssertionError(("tail mass", m, w))
    check_twise(k, law, 5)
    loss = w / (2 * (m ** 4 + 1))
    if loss < F(1, 16 * m ** 4):
        raise AssertionError(("fivewise coarse loss", m, loss))
    fourth = sum(p * (x - k) ** 4 for x, p in law.items())
    return {"m": m, "k": k, "count_layers": len(law),
            "tail_weight": str(w), "middle_weight": str(u), "central_weight": str(v),
            "fourth_centered_moment": str(fourth), "loss": str(loss)}


def integer_tenth_root(k):
    lo, hi = 0, 1
    while hi ** 10 <= k:
        hi *= 2
    while hi - lo > 1:
        mid = (lo + hi) // 2
        if mid ** 10 <= k:
            lo = mid
        else:
            hi = mid
    return lo


def fivewise_all_large(k):
    m = integer_tenth_root(k)
    if m < 64:
        raise AssertionError(("threshold", k, m))
    a, b = m ** 2, m ** 6
    s = isqrt(k)
    s += s ** 2 < k
    tail_variance = m ** 8
    tail_fourth = m ** 20 - m ** 16 + m ** 12
    numerator = F(k * (3 * k - 1), 4) - F(k * s ** 2, 2)
    denominator = tail_fourth - tail_variance * s ** 2
    if not m ** 10 <= k < (m + 1) ** 10 <= F(5 * m ** 10, 4):
        raise AssertionError(("tenth root bracket", k, m))
    if not k <= s ** 2 <= F(17 * k, 16):
        raise AssertionError(("square root bracket", k, s))
    if not F(3 * k ** 2, 16) <= numerator <= F(k ** 2, 4):
        raise AssertionError(("numerator bounds", k, numerator))
    if not F(7 * m ** 20, 8) <= denominator <= m ** 20:
        raise AssertionError(("denominator bounds", k, denominator))
    w = numerator / denominator
    u = (F(k, 2) - w * tail_variance) / s ** 2
    v = 1 - w - u
    if not F(3, 16) <= w <= F(25, 56):
        raise AssertionError(("all-large tail mass", k, w))
    if not 0 <= u <= F(1, 2) or v < 0:
        raise AssertionError(("all-large middle/central masses", k, u, v))
    original = two_layer(k, a, b)
    tail = mix([(F(1, 2), original), (F(1, 2), reflect(k, original))])
    middle = {k - s: F(1, 2), k + s: F(1, 2)}
    law = mix([(w, tail), (u, middle), (v, {k: F(1)})])
    check_twise(k, law, 5)
    if b ** 2 > a * k:
        raise AssertionError(("core lower regime", k, a, b))
    loss = w * F(b, 2 * (k + b))
    if loss < F(1, 36 * m ** 4) or loss ** 5 * 36 ** 5 * k ** 2 < 1:
        raise AssertionError(("all-large coarse loss", k, loss))
    return {"k": k, "m": m, "s": s, "count_layers": len(law),
            "tail_weight": str(w), "middle_weight": str(u),
            "central_weight": str(v), "loss": str(loss)}


def all_large_sample_ranks():
    # Both ends of every tested tenth-root interval, fractions of that interval,
    # and both sides of square boundaries check all uses of rounding exactly.
    ranks = set()
    for m in list(range(64, 165)) + [255, 256, 1000, 10 ** 4, 10 ** 6]:
        left, right = m ** 10, (m + 1) ** 10 - 1
        for j in range(9):
            k = left + (right - left) * j // 8
            ranks.add(k)
            q = isqrt(k)
            for offset in (-1, 0, 1):
                candidate = q ** 2 + offset
                if left <= candidate <= right:
                    ranks.add(candidate)
    return sorted(ranks)


if __name__ == "__main__":
    three = [threewise(k) for k in range(1, 10001)]
    five = [fivewise(m) for m in range(2, 101)]
    all_large = [fivewise_all_large(k) for k in all_large_sample_ranks()]
    report = {
        "status": "passed",
        "scope": "Exact moment/weight checks of finite exchangeable count laws; not a substitute for the general proof.",
        "threewise_ranks_checked": len(three),
        "threewise_small_ground_set_handling": "Only factorial orders r<=min(3,n) are required.",
        "threewise_samples": three[:5] + [three[63], three[999], three[-1]],
        "fivewise_tenth_power_parameters_checked": len(five),
        "fivewise_samples": five[:3] + [five[-1]],
        "all_large_threshold": 64 ** 10,
        "all_large_integer_endpoint_check": 4 * 65 ** 10 <= 5 * 64 ** 10,
        "all_large_ranks_checked": len(all_large),
        "all_large_samples": all_large[:2] + [all_large[-1]],
    }
    print(json.dumps(report, indent=2))
