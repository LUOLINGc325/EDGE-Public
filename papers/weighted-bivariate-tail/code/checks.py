"""Exact finite checks for the weighted bivariate leave-one-out certificate."""

from collections import defaultdict
from fractions import Fraction as Q
from random import Random
import json


def require(condition, context):
    if not condition:
        raise RuntimeError(str(context))


def parameters(a, b):
    s = a + b - a*b
    w = 1 - b
    z = 1 - a
    optimum = max(s, a/w, b/z)
    return optimum, optimum/s * (1 - b/2), optimum/s * (1 - a/2)


def multiplier(y, a, b, optimum, u0, v0):
    if y <= b:
        return u0 + v0*y/a
    t = 1 - a - b
    offset = y - b
    n_branch = (optimum + v0*offset)/a
    if offset <= t:
        return n_branch
    r_branch = (optimum - u0*offset)/b + (optimum*(1-a)/b - 1)/(offset-t)
    require(offset*r_branch >= (1-optimum)*(1-b)/(2*(1-a)),
            (a, b, y, "rejecting branch bound"))
    return min(n_branch, r_branch)


def slack(x, y, a, b, optimum, u0, v0):
    u = multiplier(y, a, b, optimum, u0, v0)
    v = multiplier(x, b, a, optimum, v0, u0)
    require(u > 0 and v > 0, (a, b, x, y, "positive multipliers"))
    return optimum + u*(x-a) + v*(y-b) - int(x+y >= 1)


def branch_laws(a, b):
    return [
        (a+b-a*b, {(Q(0), Q(0)): (1-a)*(1-b), (Q(1), Q(0)): a*(1-b),
                   (Q(0), Q(1)): (1-a)*b, (Q(1), Q(1)): a*b}),
        (a/(1-b), {(Q(0), b): 1-a/(1-b), (1-b, b): a/(1-b)}),
        (b/(1-a), {(a, Q(0)): 1-b/(1-a), (a, 1-a): b/(1-a)}),
    ]


def verify_law(law, expected, a, b):
    y_mass, x_mass = defaultdict(Q), defaultdict(Q)
    x_given_y, y_given_x = defaultdict(Q), defaultdict(Q)
    rejection = Q(0)
    for (x, y), mass in law.items():
        require(mass >= 0, law)
        y_mass[y] += mass
        x_mass[x] += mass
        x_given_y[y] += mass*x
        y_given_x[x] += mass*y
        if x+y >= 1:
            rejection += mass
    require(sum(y_mass.values()) == 1 and rejection == expected, law)
    require(all(x_given_y[y] == a*mass for y, mass in y_mass.items()), law)
    require(all(y_given_x[x] == b*mass for x, mass in x_mass.items()), law)


def verify():
    rng = Random(20261125)
    inputs = set()
    for _ in range(66):
        i = rng.randrange(1, 35)
        j = rng.randrange(1, 36-i)
        inputs.add((Q(i, 36), Q(j, 36)))
    inputs.update({(Q(49, 50), Q(1, 100)), (Q(1, 100), Q(49, 50)),
                   (Q(2, 5), Q(2, 5)), (Q(1, 5), Q(1, 5))})
    for small in (Q(1, 100), Q(1, 8), Q(1, 5), Q(3, 8)):
        large = (1-small)/(2-small)
        inputs.update({(large, small), (small, large)})
    points = high_tight_cases = laws = ties = 0
    for a, b in sorted(inputs):
        optimum, u0, v0 = parameters(a, b)
        t = 1-a-b
        locations = {Q(i, 24) for i in range(25)}
        locations.update({a, b, 1-a, 1-b, a+t/2, b+t/2, a/2, b/2})
        locations |= {1-x for x in locations}
        for x in sorted(locations):
            for y in sorted(locations):
                gap = slack(x, y, a, b, optimum, u0, v0)
                require(gap >= 0, (a, b, x, y, "dual feasibility"))
                points += 1
                if gap == 0 and x >= a and y >= b:
                    allowed = ({(1, 1)} if optimum == a+b-a*b else set())
                    if optimum == a/(1-b):
                        allowed.add((1-b, b))
                    if optimum == b/(1-a):
                        allowed.add((a, 1-a))
                    require((x, y) in allowed, (a, b, x, y, "tight high point"))
                    high_tight_cases += 1
        active = []
        for value, law in branch_laws(a, b):
            verify_law(law, value, a, b)
            laws += 1
            if value == optimum:
                require(all(slack(x, y, a, b, optimum, u0, v0) == 0
                            for x, y in law), (a, b, "complementary slackness"))
                active.append(law)
        if len(active) > 1:
            mixture = defaultdict(Q)
            for law in active:
                for point, mass in law.items():
                    mixture[point] += mass/len(active)
            verify_law(mixture, optimum, a, b)
            ties += 1
    return {"budget_pairs": len(inputs), "pointwise_dual_checks": points,
            "tight_high_points": high_tight_cases,
            "candidate_laws": laws, "tie_mixtures": ties}


print(json.dumps(verify(), indent=2))
