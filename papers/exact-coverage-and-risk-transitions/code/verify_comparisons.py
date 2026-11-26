"""Exact checks for the classical-rule and identical-law comparisons."""

from fractions import Fraction as F
from itertools import product
import json

from verify_exact import lower_reject, pure_bound_ok, two_point


def old_reject(x, y, threshold, alpha):
    x, y = sorted((x, y))
    if y <= threshold:
        return False
    if x >= threshold:
        return threshold**2 < alpha * x * y
    return (y - threshold)**2 > (1 - alpha) * y * (y - x)


def calculate(p, q, mean, alpha, reject):
    lower, upper = [], []
    for index, ((x, u), (y, v)) in enumerate(product(p, q)):
        if reject(x, y, mean, alpha):
            lower.append((index, u * v))
        if reject(1 - x, 1 - y, 1 - mean, alpha):
            upper.append((index, u * v))
    assert {i for i, _ in lower}.isdisjoint({i for i, _ in upper})
    return lower, upper, sum(w for _, w in lower + upper)


def verify_classical_and_same_class():
    points = [F(i, 16) for i in range(17)]
    pairs_checked = 0
    same_class_checked = 0
    for alpha in (F(1, 4), F(7, 16), F(301, 625), F(4959, 10000)):
        for mean in points[1:-1]:
            nu = 1 - mean
            points_for_mean = sorted({*points, mean / 2, (mean + 1) / 2})
            law_atoms = list(product((a for a in points_for_mean if a < mean),
                                     (c for c in points_for_mean if c > mean)))
            laws = [(a, c, two_point(a, c, mean)) for a, c in law_atoms]
            both_active = mean**2 < alpha and nu**2 < alpha
            for (a, c, p), (b, d, q) in product(laws, repeat=2):
                lower, upper, value = calculate(p, q, mean, alpha, old_reject)
                if lower and upper:
                    assert both_active and len(lower) == 1 and len(upper) == 1
                    assert lower[0][0] == 3 and upper[0][0] == 0
                    assert pure_bound_ok(value, alpha)
                else:
                    assert value <= alpha
                # The two types are separated by the low support relative to
                # 1-(1-mu)/sqrt(alpha), after reflecting the active mixed side.
                if both_active and mean < alpha:
                    types = [alpha * (1 - lo)**2 <= nu**2 for lo in (a, b)]
                elif both_active and nu < alpha:
                    types = [alpha * hi**2 <= mean**2 for hi in (c, d)]
                else:
                    types = []
                if types and types[0] == types[1]:
                    _, _, improved = calculate(p, q, mean, alpha, lower_reject)
                    assert pure_bound_ok(improved, alpha)
                    same_class_checked += 1
                pairs_checked += 1
    return pairs_checked, same_class_checked


def explicit_comparison():
    alpha, mean = F(301, 625), F(2, 5)
    left = two_point(F(1, 4), F(1), mean)
    right = two_point(F(0), F(99, 100), mean)
    old = calculate(left, right, mean, alpha, old_reject)[2]
    new = calculate(left, right, mean, alpha, lower_reject)[2]
    assert old == F(92, 165) and new == F(436, 495)
    mixed_iid = [(x, p / 2) for x, p in left + right]
    actual = calculate(mixed_iid, mixed_iid, mean, alpha, lower_reject)[2]
    s, u = F(18, 25), F(7, 25)
    a_star = 1 - (1 - mean)**2 / alpha
    envelope = 1 - (1 - alpha / (1 - mean)) * s * (1 - u * a_star / mean)
    assert pure_bound_ok(2 * actual - envelope, alpha)
    return {'classical': str(old), 'admissible': str(new), 'iid_equal_mixture': str(actual)}


def main():
    pairs, same_class = verify_classical_and_same_class()
    assert same_class > 0
    print(json.dumps({'status': 'pass', 'classical_pairs': pairs,
                      'same_type_admissible_pairs': same_class,
                      'explicit_comparison': explicit_comparison()}, indent=2))


if __name__ == '__main__':
    main()
