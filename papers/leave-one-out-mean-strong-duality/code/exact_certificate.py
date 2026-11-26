"""Exact checks of leave-one-out dual certificates and grid rounding."""
from collections import defaultdict
from fractions import Fraction as Q
from itertools import product
from math import ceil, prod


def check_null(law):
    assert sum(law.values()) == 1
    conditional_constraints = defaultdict(Q)
    for values, probability in law.items():
        assert probability >= 0
        for i, value in enumerate(values):
            fiber = values[:i] + values[i+1:]
            conditional_constraints[i, fiber] += (value - 1) * probability
    assert all(moment <= 0 for moment in conditional_constraints.values())


def max_certificate_bound(values, cutoff):
    n = len(values)
    b = 1 - 1 / cutoff
    baseline = 1 - b**n
    for i, value in enumerate(values):
        prefix = prod(max(Q(0), 1 - earlier / cutoff) for earlier in values[:i])
        lam = b**(n-i-1) / cutoff * prefix
        baseline += lam * (value - 1)
    return baseline


def max_size(n, cutoff):
    return 1 - (1 - 1 / cutoff)**n


def independent_two_point(n, cutoff):
    return {
        values: prod(1 / cutoff if value else 1 - 1 / cutoff for value in values)
        for values in product((Q(0), cutoff), repeat=n)
    }


def exact_dependent_star(arms):
    n = len(arms)
    origin = (Q(0),) * n
    factors = [1 / (arm - 1) for arm in arms]
    origin_mass = 1 / (1 + sum(factors))
    law = {origin: origin_mass}
    for i, (arm, factor) in enumerate(zip(arms, factors)):
        law[origin[:i] + (arm,) + origin[i+1:]] = origin_mass * factor
    return law


def round_and_thin(law, mesh, cutoff):
    probability_kept = 1 / (1 + mesh)
    rounded_law = defaultdict(Q)
    n = len(next(iter(law)))
    for values, probability in law.items():
        rounded = tuple(min(cutoff, mesh * ceil(x / mesh)) for x in values)
        for kept in product((False, True), repeat=n):
            out = tuple(x if yes else Q(0) for x, yes in zip(rounded, kept))
            keep_mass = prod(probability_kept if yes else 1-probability_kept for yes in kept)
            rounded_law[out] += probability * keep_mass
    return rounded_law


def probability(law, region):
    return sum(mass for outcome, mass in law.items() if region(outcome))


def main():
    labels = (Q(3, 2), Q(2), Q(7, 3), Q(5))
    checked = 0
    for n, c in product(range(1, 5), labels):
        grid = sorted({Q(0), Q(1, 2), Q(1), c, c + 1, 2*c})
        for values in product(grid, repeat=n):
            assert max_certificate_bound(values, c) >= int(max(values) >= c)
            checked += 1
        law = independent_two_point(n, c)
        check_null(law)
        assert probability(law, lambda values: max(values) >= c) == max_size(n, c)
    print(f"{checked} pointwise multiplier checks and 16 exact primal witnesses")

    checked = 0
    for n, c, mesh in product(range(1, 5), labels, (Q(1, 3), Q(3, 8), Q(1, 2))):
        cutoff = 18 * mesh
        next_point = ceil(c / mesh) * mesh
        grid_size = max_size(n, next_point) if next_point <= cutoff else Q(0)
        continuum = max_size(n, c)
        assert grid_size <= continuum <= (1 + mesh)**n * grid_size + n / cutoff
        assert continuum - grid_size <= n * mesh + n / cutoff
        checked += 1
    print(f"{checked} exact finite-grid size comparisons")
    print("n=3 and max threshold 5: least favorable rejection probability 61/125")

    regions = (
        lambda x: max(x) >= 3,
        lambda x: sum(x) > 3,
        lambda x: x[0] + 2*x[-1] >= 4,
    )
    checked = 0
    for n, mesh, steps in product(range(2, 5), (Q(1, 3), Q(2, 5), Q(1, 2)), (7, 13)):
        law = exact_dependent_star(tuple(Q(7+i, 4) for i in range(n)))
        check_null(law)
        cutoff = steps * mesh
        rounded = round_and_thin(law, mesh, cutoff)
        check_null(rounded)
        assert all(x <= cutoff and (x / mesh).denominator == 1
                   for outcome in rounded for x in outcome)
        for region in regions:
            original_inside = probability(law, lambda x: max(x) <= cutoff and region(x))
            assert probability(rounded, region) >= original_inside / (1 + mesh)**n
            checked += 1
    print(f"{checked} exact preservation and power checks for dependent rounding examples")


if __name__ == "__main__":
    main()
