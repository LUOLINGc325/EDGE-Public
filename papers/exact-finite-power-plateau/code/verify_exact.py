"""Exact trajectory and potential checks for the Lipschitz plateau."""

from fractions import Fraction as F
from itertools import combinations
import json
import random


def require(condition, explanation):
    if not condition:
        raise AssertionError(explanation)


def prediction(history, x, rank):
    upper = sorted(y + abs(x - old_x) for old_x, y in history)[rank - 1]
    lower = sorted((y - abs(x - old_x) for old_x, y in history), reverse=True)[rank - 1]
    return (upper + lower) / 2


def evaluate(function, x):
    for (a, u), (b, v) in zip(function, function[1:]):
        if a <= x <= b:
            return u + (v - u) * (x - a) / (b - a)
    raise ValueError("query outside the piecewise-affine function")


def side_integral(function, history, rank, side):
    base = sorted({x for x, _ in function} | {x for x, _ in history})

    def functions_at(x):
        truth = evaluate(function, x)
        return [side * (label - truth) + abs(x - loc) for loc, label in history]

    total = F(0)
    for a, b in zip(base, base[1:]):
        left = functions_at(a)
        right = functions_at(b)
        cuts = {F(0), F(1)}
        for (l1, r1), (l2, r2) in combinations(zip(left + [F(0)], right + [F(0)]), 2):
            d_left, d_right = l1 - l2, r1 - r2
            if d_left * d_right < 0:
                cuts.add(d_left / (d_left - d_right))

        def trimmed_at(fraction):
            values = [max(F(0), l + fraction * (r - l)) for l, r in zip(left, right)]
            return sum(sorted(values)[:rank])

        cuts = sorted(cuts)
        values = [trimmed_at(cut) for cut in cuts]
        total += sum((b-a)*(v-u)*(left_value+right_value)/2
                     for u, v, left_value, right_value in zip(cuts, cuts[1:], values, values[1:]))
    return total


def potential(function, history, rank):
    return side_integral(function, history, rank, 1) + side_integral(function, history, rank, -1)


def run_trace(function, points, reports, eta, warmup):
    history = []
    rank = eta + 1
    squares = F(0)
    truthful_squares = F(0)
    total_corrupt = 0
    locales = []
    prior = None
    for t, (x, feedback) in enumerate(zip(points, reports)):
        label = evaluate(function, x)
        corrupted = (feedback != label)
        total_corrupt += corrupted
        if t < warmup:
            if not corrupted:
                locales.append(x*x + (1-x)*(1-x))
            history.append((x, feedback))
            continue
        if prior is None:
            prior = potential(function, history, rank)
            localized = sum(sorted(locales)[:rank])
            require(prior <= localized <= rank, ("warmup bound", prior, localized))
        loss = abs(prediction(history, x, rank) - label) ** 2
        require(loss <= 1, ("range bound", eta, t, loss))
        history.append((x, feedback))
        current = potential(function, history, rank)
        require(current <= prior, ("potential monotonicity", eta, t, prior, current))
        if not corrupted:
            require(prior-current >= loss, ("truthful drop", eta, t, loss, prior-current))
            truthful_squares += loss
        prior = current
        squares += loss
    require(total_corrupt <= eta, "bad input trace")
    require(truthful_squares <= rank and squares <= 2*eta+1, "cumulative bound")
    return squares


def main():
    rng = random.Random(125112)
    traces = scored = 0
    extreme = []
    for eta in range(3):
        k = 2*eta+1
        for sign in (-1, 1):
            warmup = k+2
            points = [F(0)]*warmup + [F(1)]*k
            reports = [F(0)]*warmup + [F(-1)]*eta + [F(1)]*eta + [F(sign)]
            value = run_trace([(F(0), F(0)), (F(1), F(sign))], points, reports, eta, warmup)
            require(value == k, ("exact extremal trace", eta, sign, value))
            extreme.append({"corruptions": eta, "sign": sign, "exact_loss": int(value)})
            traces += 1
            scored += k

        for test in range(32):
            warmup = k + test % 3
            steps = warmup + 6
            function = [(F(0), F(rng.randrange(-5, 6)))]
            for i in range(1, 5):
                slope = F(rng.randrange(-4, 5), 4)
                function.append((F(i, 4), function[-1][1] + slope/4))
            points = [F(rng.randrange(9), 8) for _ in range(steps)]
            reports = [evaluate(function, x) for x in points]
            for t in rng.sample(range(steps), eta):
                reports[t] += rng.choice([F(-100), F(-1, 8), F(1, 8), F(100)])
            run_trace(function, points, reports, eta, warmup)
            traces += 1
            scored += steps-warmup
    print(json.dumps({
        "trajectories": traces,
        "scored_rounds": scored,
        "extremal_trajectories": extreme,
        "arithmetic": "exact rational piecewise-affine integration",
    }, indent=2))


if __name__ == "__main__":
    main()
