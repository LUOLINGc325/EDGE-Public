"""Exact rational finite checks, using only Python's standard library."""
from fractions import Fraction as F
from itertools import combinations, product
from json import dumps
from math import prod
from random import Random


ZERO = ((F(0), F(1)),)


def two_point(up, down):
    up, down = F(up), F(down)
    return ((up, down / (up + down)), (-down, up / (up + down)))


def collision(p):
    return (1 - sum(mass**2 for mass in p)) / 2


def describe(laws):
    moments = [sum(x * p for x, p in law) for law in laws]
    assert all(v == 0 for v in moments)
    return sum(x*x*p for law in laws for x, p in law)


def enumerate_product(laws, data_dependent=False):
    b = F(0)
    winners = [F(0) for _ in laws]
    for atoms in product(*laws):
        xs = tuple(x for x, _ in atoms)
        mass = prod(p for _, p in atoms)
        largest = max(xs)
        candidates = [i for i, x in enumerate(xs) if x == largest]
        # Outcomes with different losing coordinates can resolve identical ties differently.
        if data_dependent and sum(xs) < 0:
            selected = candidates[-1]
        else:
            selected = candidates[0]
        winners[selected] += mass
        b += largest * mass
    assert sum(winners) == 1
    return b, winners


def check_finite_formula(laws):
    b, winners = enumerate_product(laws)
    variance = describe(laws)
    assert b*b <= variance*collision(winners)
    if ZERO in laws:
        return 'with_floor'
    ids = sorted(range(len(laws)), key=lambda i: (-laws[i][0][0], i))
    k = max(range(len(ids)), key=lambda j: (laws[ids[j]][1][0], -ids[j]))
    survival = F(1)
    first = []
    tails = []
    for i in ids:
        x = laws[i][0][1]
        first.append(x * survival)
        survival *= 1 - x
        tails.append(survival)
    all_down = survival
    finite_p = first.copy()
    finite_p[k] += all_down
    assert finite_p == [winners[i] for i in ids]
    norm_sq = sum(r*s*(1-all_down/s)**2 if j == k else r*s
                  for j, (r, s) in enumerate(zip(first, tails)))
    loss = first[k]*all_down*(1-all_down/tails[k])
    assert norm_sq + loss == collision(finite_p)
    assert b*b <= variance*norm_sq
    assert b*b < variance*collision(winners)
    return 'last_down_winner' if k == len(laws)-1 else 'earlier_down_winner'


def check_cascades():
    n = 0
    for m in range(2, 7):
        for den in range(m, 11):
            for cuts in combinations(range(1, den), m-1):
                points = (0, *cuts, den)
                p = [F(right - left, den) for left, right in zip(points[:-1], points[1:])]
                c = F(7, 5)
                laws = [two_point(c*sum(p[i+1:]), c*p[i]) for i in range(m-1)] + [ZERO]
                b, winners = enumerate_product(laws)
                assert winners == p
                assert b == c*collision(p)
                assert describe(laws) == c*c*collision(p)
                n += 1
    return n


def mix(law_a, law_b, weight):
    pmf = {}
    for law, factor in [(law_a, weight), (law_b, 1 - weight)]:
        for x, p in law:
            pmf[x] = pmf.get(x, F(0)) + p*factor
    return tuple(pmf.items())


def check_mixture(law):
    pos = [(x, p) for x, p in law if x > 0]
    neg = [(-x, p) for x, p in law if x < 0]
    m = sum(u*p for u, p in pos)
    assert m == sum(d*p for d, p in neg)
    result = {x:p for x, p in law if x == 0}
    if m:
        for u, pu in pos:
            for d, pd in neg:
                factor = (u+d)*pu*pd/m
                for value, prob in two_point(u, d):
                    result[value] = result.get(value, F(0)) + factor*prob
    assert result == dict(law)


def main():
    types = [ZERO] + [two_point(u, d) for u, d in product(range(1, 4), repeat=2)]
    counts = {'with_floor': 0, 'last_down_winner': 0, 'earlier_down_winner': 0}
    for m in range(2, 5):
        for laws in product(types, repeat=m):
            branch = check_finite_formula(laws)
            counts[branch] += 1
    rng = Random(20261124)
    for _ in range(500):
        laws = [mix(rng.choice(types), rng.choice(types), F(rng.randrange(1, 7), 7))
                for _ in range(rng.randrange(2, 6))]
        for law in laws:
            check_mixture(law)
        b, p = enumerate_product(laws, data_dependent=True)
        assert b*b <= describe(laws)*collision(p)
    result = {'two_point_or_zero_profiles': sum(counts.values()), 'branches': counts,
              'mixture_profiles_with_data_dependent_ties': 500,
              'prescribed_probability_cascades': check_cascades(), 'arithmetic': 'exact rational'}
    print(dumps(result, indent=2))


if __name__ == '__main__':
    main()
