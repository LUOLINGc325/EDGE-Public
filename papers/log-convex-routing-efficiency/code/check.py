"""Verify the symbolic reductions and sample the scalar cost bound."""
from math import exp, log, log1p, sqrt
from random import Random

from scipy.optimize import brentq
from sympy import diff, expand, simplify, symbols


def verify_identities():
    d, exponential, count, inverse_players = symbols(
        "d exponential count inverse_players", positive=True
    )
    neighbors = count - 1
    h = (1 + d) * exponential
    numerator = h - 1 + neighbors * d
    denominator = exponential * (
        1 + count * d + count * neighbors * inverse_players * d**2
    ) - 1

    def derivative(value):
        return diff(value, d) + count * exponential * diff(value, exponential)

    slope = (neighbors * numerator + derivative(numerator)) * denominator
    slope -= numerator * derivative(denominator)
    at_zero = d * (exponential - 1) * neighbors * (
        exponential * count * d + exponential * count + exponential + count - 1
    )
    at_boundary = d * (exponential - 1) * neighbors * (
        count * d + count + 1
    ) * numerator / (1 + d)
    assert simplify(slope.subs(inverse_players, 0) - at_zero) == 0
    assert simplify(slope.subs(inverse_players, 1 / h) - at_boundary) == 0

    a, u, s = symbols("a u s")
    z = u - 1
    derivative_numerator = (
        2 * (a + z) ** 2 + (a + z) * a * z
        - (2 * u * a + (u + 1) * z) * (a + s * z)
    )
    claimed = z * (-a**2 + 2 * a * (1 - u * s) + z * (2 - (u + 1) * s))
    assert expand(derivative_numerator - claimed) == 0


def optimal_single_load(load, markup, players):
    right = load + log1p(load / players) + markup
    return brentq(lambda value: value + log1p(value) - right, 0, right + 1)


def verify_multiclass_examples():
    random = Random(1873)
    count = 0
    for players in (2, 3, 10, 50):
        for links in (2, 3, 5, 10):
            critical = brentq(
                lambda value: links * value + log1p(value) - log(players),
                0, log(players)
            )
            sharp = players * exp(-critical) / (1 + links * critical)
            for _ in range(30):
                loads = [
                    0.0 if random.random() < .2 else 10 ** random.uniform(-3, 3)
                    for _ in range(links)
                ]
                if not any(loads):
                    loads[0] = 1.0

                def excess(markup):
                    return sum(optimal_single_load(x, markup, players) - x for x in loads)

                price = brentq(excess, 0, log(players))
                optimal = [optimal_single_load(x, price, players) for x in loads]
                eq_cost = sum(x / (1 + x / players) for x in loads)
                opt_cost = exp(price) * sum(y / (1 + y) for y in optimal)
                assert eq_cost / opt_cost <= sharp + 1e-9
                count += 1

            loads = [1e7] + [0.0] * (links - 1)
            price = brentq(lambda a: sum(
                optimal_single_load(x, a, players) - x for x in loads
            ), 0, log(players))
            ratio = loads[0] / (1 + loads[0] / players) / (
                exp(price) * sum(
                    (y := optimal_single_load(x, price, players)) / (1 + y)
                    for x in loads
                )
            )
            assert abs(ratio - sharp) < 1e-5 * sqrt(players)
            count += 1
    return count


if __name__ == '__main__':
    verify_identities()
    print(f'3 exact symbolic identities and {verify_multiclass_examples()} load checks')
