"""Exact checks for the projection identity and the capital constructions."""
from fractions import Fraction as Q
from functools import lru_cache
from itertools import product
from math import prod


GRID = (Q(0), Q(1, 2), Q(1), Q(2), Q(3))


def positive(value):
    return max(Q(0), value)


def target(values, strength):
    return 1 + strength*(prod(positive(x-1) for x in values)
                        - prod(positive(1-x) for x in values))


def projection(function, index):
    @lru_cache(maxsize=None)
    def result(values):
        high = values[:index] + (Q(2),) + values[index+1:]
        neutral = values[:index] + (Q(1),) + values[index+1:]
        return function(values) - (values[index]-1)*(function(high)-function(neutral))
    return result


def check_projection():
    count = 0
    for n in range(2, 6):
        def function(values):
            # A nonsymmetric precise convex mixture on the same cube.
            return (target(values, Q(2, 3)) + values[0]*values[-1] + values[0]) / 3

        projected = function
        for i in range(n):
            projected = projection(projected, i)
        for values in product(GRID, repeat=n):
            assert projected(values) == 1
            assert 0 <= function(values) <= prod(max(1, x) for x in values)
            count += 1
    return count


def ordered_payoff(values, capital, strength, first):
    active = strength
    cash = capital-strength
    for i in (first, *(j for j in range(len(values)) if j != first)):
        cash += active*min(1, values[i])
        active *= positive(values[i]-1)
    return cash+active


def check_product_strategy():
    count = 0
    for n, strength in product(range(2, 6), (Q(0), Q(2, 3), Q(1))):
        capital = 1 + strength*Q(n-1, n)
        for values in product(GRID, repeat=n):
            payoff = sum(ordered_payoff(values, capital, strength, i) for i in range(n))/n
            assert payoff >= target(values, strength)
            count += 1
        extremal = [tuple(1 if i == j else 0 for j in range(n)) for i in range(n)]
        assert sum(ordered_payoff(values, capital, strength, 0) for values in extremal)/n == 1
    return count


def check_asymmetric_pairs():
    count = 0
    for bias, swapped in product((Q(0), Q(1, 5), Q(1, 2), Q(4, 5), Q(1)), (False, True)):
        base_slope = (1-bias)/2
        bias_f, bias_g = (bias, Q(0)) if swapped else (Q(0), bias)
        # The positive-tail lower slopes are both base_slope.
        balance = (bias_f-bias_g)/2
        gauge = min(base_slope, max(-base_slope, balance))
        r, s = base_slope+bias_f-gauge, base_slope+bias_g+gauge
        q = r+s
        assert r >= 0 and s >= 0 and q == 1
        capital = 1+q/2
        x_account, y_account = s, capital-s
        for x, y in product(GRID, repeat=2):
            u, v = x-1, y-1
            f = base_slope*abs(u)+bias_f+gauge*u
            g = base_slope*abs(v)+bias_g-gauge*v
            x_wager, y_wager = positive(f-r), positive(g-s)
            assert x_wager <= x_account+s*u and y_wager <= y_account+r*v
            assert positive(r-f) <= q/2*min(1, 1+u)
            assert positive(s-g) <= q/2*min(1, 1+v)
            payoff = capital+s*u+r*v+x_wager*v+y_wager*u
            assert payoff >= 1+v*f+u*g
            count += 1
    return count


if __name__ == "__main__":
    print(f"{check_projection()} exact coordinate-projection evaluations")
    print(f"{check_asymmetric_pairs()} exact asymmetric ordered-account comparisons")
    print(f"{check_product_strategy()} exact n-way strategy comparisons")
