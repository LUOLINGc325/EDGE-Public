"""Rational replay of the centroid and slow/fast-mode examples."""
from fractions import Fraction as F
from functools import cache
from itertools import permutations


def add(bounds):
    items = tuple(bounds)
    return sum(x for x, _ in items), sum(y for _, y in items)


def scale(bound, factor):
    a, b = (factor * endpoint for endpoint in bound)
    return min(a, b), max(a, b)


@cache
def log_unit(value):
    assert 1 <= value <= 2
    ratio = (value - 1) / (value + 1)
    square = ratio * ratio
    term = ratio
    result = F(0)
    for k in range(16):
        result += 2 * term / (2 * k + 1)
        term *= square
    tail = 2 * term / (33 * (1 - square))
    return result, result + tail


@cache
def log(value):
    """Reduce to [1,2], then bound the exact atanh-series remainder."""
    assert value > 0
    exponent = 0
    while value < 1:
        value *= 2
        exponent -= 1
    while value > 2:
        value /= 2
        exponent += 1
    return add((log_unit(value), scale(log_unit(F(2)), exponent)))


def logdiff(a, b):
    return add((log(a), scale(log(b), -1)))


def mean(points):
    return tuple(sum(values) / len(points) for values in zip(*points))


def children(points):
    for order in permutations(points):
        yield tuple(mean(order[:size]) for size in range(1, len(points) + 1))


def entropy(point, stationary):
    return add(scale(log(value / stationary[i]), value) for i, value in enumerate(point) if value)


def quotient_test(density, stationary, flows, target):
    point = tuple(p * h for p, h in zip(stationary, density))
    assert sum(point) == 1
    energy = add(scale(logdiff(density[i], density[j]), w * (density[i] - density[j])) for i, j, w in flows)
    return add((energy, scale(entropy(point, stationary), -2 * target)))


def tangent(point, density, pi, flows):
    terms = []
    for i, j, flow in flows:
        a, b = point[i] / pi[i], point[j] / pi[j]
        correction = (density[i] - density[j]) * (a / density[i] - b / density[j])
        terms.append(scale(add((scale(logdiff(density[i], density[j]), a - b), (correction, correction))), flow))
    return add(terms)


def centroid_certificate(pi, flows, lower, spectral_lower, radius):
    assert spectral_lower * (1 - radius) / (1 + radius) > lower
    n = len(pi)
    vertices = tuple(tuple(F(i == j) for i in range(n)) for j in range(n))
    stack = [(vertices, 0)]
    equilibrium = tangents = deepest = 0
    while stack:
        simplex, depth = stack.pop()
        deepest = max(deepest, depth)
        if all(1-radius < x/p < 1+radius for vertex in simplex for x,p in zip(vertex, pi)):
            equilibrium += 1
            continue
        center = mean(simplex)
        assert all(value > 0 for value in center)
        assert all(value <= n * m for v in simplex for value, m in zip(v, center))
        h = tuple(value / p for value, p in zip(center, pi))
        if all(add((tangent(v, h, pi, flows), scale(entropy(v, pi), -2 * lower)))[0] > 0 for v in simplex):
            tangents += 1
        else:
            assert depth < 12
            stack.extend((child, depth + 1) for child in children(simplex))
    return equilibrium, tangents, deepest


def main():
    two = (F(1, 2),) * 2
    print('Balanced two-state lower 19/20:', centroid_certificate(two, ((0,1,F(1,4)),), F(19,20), F(1), F(1,50)))

    three = (F(1, 8), F(1, 8), F(3, 4))
    three_flows = ((0, 1, F(1, 192)), (0, 2, F(1, 8)), (1, 2, F(1, 8)))
    slow, fast = F(13, 12), F(4, 3)
    quartic = slow * F(1, 24) - fast * fast * F(3, 16) / (16 * (fast - slow))
    assert quartic == -F(11, 288)
    t = F(1, 10)
    density = (1 + t + t*t, 1 - t + t*t, 1 - t*t/3)
    assert quotient_test(density, three, three_flows, slow)[1] < 0
    print('Positive three-state lower 3/4:', centroid_certificate(three, three_flows, F(3,4), slow, F(1,10)))
    print('Zero cubic moment with quartic descent:', quartic, 'and trial ratio below', slow)

    sparse = (F(1, 3),) * 3
    path_flows = ((0, 1, F(1, 2)), (1, 2, F(1, 2)))
    print('Sparse three-state path lower 1/2:', centroid_certificate(sparse, path_flows, F(1,2), F(3,2), F(1,5)))

    # The split-block example has fixed slow eigenvalue 1. At either side
    # of the balanced base a block-constant trial lowers the quotient.
    for p in (F(49, 100), F(51, 100)):
        delta = p - F(1, 2)
        split_pi = (p / 2, p / 2, 1 - p)
        x = p * (1 - p) / 2
        flows = ((0, 1, p * F(3, 4)), (0, 2, x), (1, 2, x))
        density = (1 - 4 * delta * (1 - p),) * 2 + (1 + 4 * delta * p,)
        assert quotient_test(density, split_pi, flows, F(1))[1] < 0
    print('Split-block strict departure at p=49/100 and 51/100.')


if __name__ == '__main__':
    main()
