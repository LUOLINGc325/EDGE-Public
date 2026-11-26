"""Exact bottleneck spectrum certificates, using only the standard library."""
from fractions import Fraction as Q
from itertools import combinations
import json


def sign(x):
    return (x > 0) - (x < 0)


def characteristic(mask, n):
    """Monic characteristic polynomial via Newton identities."""
    neighbors = [[] for _ in range(n)]
    for bit, (i, j) in enumerate(combinations(range(n), 2)):
        if mask >> bit & 1:
            neighbors[i].append(j)
            neighbors[j].append(i)
    powers = [[int(i == j) for j in range(n)] for i in range(n)]
    traces = []
    for _ in range(n):
        powers = [[sum(row[k] for k in neighbors[j]) for j in range(n)] for row in powers]
        traces.append(sum(powers[i][i] for i in range(n)))

    coeff = [1]
    for k in range(1, n+1):
        numerator = -sum(coeff[k-1-i]*traces[i] for i in range(k))
        quotient, remainder = divmod(numerator, k)
        assert remainder == 0
        coeff.append(quotient)
    return coeff


def ring_sign(a, b):
    """Sign of a+b phi, where phi=(sqrt(5)-1)/2."""
    x, y = 2*a-b, b
    if x == 0:
        return sign(y)
    if y == 0 or sign(x) == sign(y):
        return sign(x)
    assert x*x != 5*y*y
    return sign(x) if x*x > 5*y*y else sign(y)


def count_at_or_beyond(polynomial, side):
    # Horner substitution: evaluate P(side*(phi+z)) in Z[phi][z].
    coefficients = [(0, 0)]
    for coeff in polynomial:
        expanded = [(0, 0)]*(len(coefficients)+1)
        for degree, (a, b) in enumerate(coefficients):
            x, y = expanded[degree]
            expanded[degree] = (x+side*b, y+side*(a-b))
            x, y = expanded[degree+1]
            expanded[degree+1] = (x+side*a, y+side*b)
        x, y = expanded[0]
        expanded[0] = (x+coeff, y)
        coefficients = expanded
    signs = [ring_sign(a, b) for a, b in coefficients]
    zeros = next(i for i, value in enumerate(signs) if value)
    nonzero = [value for value in signs if value]
    return zeros + sum(a != b for a, b in zip(nonzero, nonzero[1:]))


def verify_rank_gap():
    counts = {}
    for n in (5, 6):
        count = 0
        for mask in range(1 << (n*(n-1)//2)):
            polynomial = characteristic(mask, n)
            if polynomial[-1] == 0:
                continue
            positive = count_at_or_beyond(polynomial, 1)
            negative = count_at_or_beyond(polynomial, -1)
            assert positive >= 2 or negative >= 3, (n, mask, polynomial)
            count += 1
        counts[n] = count
    # C5 and triangle with a leaf at each vertex.
    assert characteristic(220, 5) == [1, 0, -5, 0, 5, -2]
    assert characteristic(691, 6) == [1, 0, -6, -2, 6, 0, -1]
    return counts


PAW = (
    (0, 1, 1, 1),
    (1, 0, 1, 0),
    (1, 1, 0, 0),
    (1, 0, 0, 0),
)


def negative_inertia(sizes, shift):
    """Count strictly negative eigenvalues by exact congruence pivots."""
    numerator, denominator = shift.numerator, shift.denominator
    assert denominator > 1
    matrix = [[denominator*sizes[i]*sizes[j]*PAW[i][j]
               - (numerator*sizes[i] if i == j else 0)
               for j in range(4)] for i in range(4)]
    previous = 1
    negative = 0
    for k in range(4):
        pivot = matrix[k][k]
        assert pivot != 0
        negative += int(sign(previous) != sign(pivot))
        for i in range(k+1, 4):
            for j in range(k+1, 4):
                dividend = pivot*matrix[i][j]-matrix[i][k]*matrix[k][j]
                quotient, remainder = divmod(dividend, previous)
                assert remainder == 0
                matrix[i][j] = quotient
        previous = pivot
    return negative


def fits(sizes, n, margin):
    # A paw quotient has two positive and two negative eigenvalues.
    return (
        negative_inertia(sizes, -n-margin) == 0
        and negative_inertia(sizes, -n+margin) >= 2
        and negative_inertia(sizes, margin) >= 3
        and negative_inertia(sizes, 2*n-margin) <= 3
        and negative_inertia(sizes, 2*n+margin) == 4
    )


def all_candidate_sizes(n):
    total = 3*n
    for a in range(1, total-2):
        for b in range(1, total-a-1):
            for c in range(b, total-a-b):
                residual = total-a-b-c
                leaves = range(1, residual+1) if n <= 6 else ((1,) if residual == 1 else ())
                for d in leaves:
                    yield a, b, c, d


def verify_finite():
    ceilings = {}
    total_competitors = 0
    for n in range(3, 20):
        winner = (n-1, n, n, 1)
        left, right = 0, 6100
        assert fits(winner, n, Q(right, 10000))
        while left+1 < right:
            middle = (left+right)//2
            if fits(winner, n, Q(middle, 10000)):
                right = middle
            else:
                left = middle
        ceiling = Q(right, 10000)
        ceilings[n] = right
        if 5 <= n <= 8:
            assert 3*ceiling*ceiling < 1
        for sizes in all_candidate_sizes(n):
            if sizes == winner:
                continue
            assert not fits(sizes, n, ceiling), (n, sizes, ceiling)
            total_competitors += 1
    for n in (3, 4):
        z = Q(61, 100)
        assert (3*n-z)*z*z/(n+z) < 1
    return ceilings, total_competitors


if __name__ == "__main__":
    counts = verify_rank_gap()
    margins, cases = verify_finite()
    result = {
        "script": "code/checks.py",
        "arithmetic": "integers_and_fractions.Fraction",
        "status": "pass",
        "invertible_labelled_graphs": counts,
        "finite_competing_paw_expansions": cases,
        "margin_upper_bounds_in_units_of_1_over_10000": margins,
    }
    print(json.dumps(result, indent=2))
