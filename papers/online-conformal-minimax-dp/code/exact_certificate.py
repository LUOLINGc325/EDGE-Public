#!/usr/bin/env python3
"""Exact finite-horizon calculations for the online minimax recursion."""

from fractions import Fraction
from functools import lru_cache


def critical_counts(alpha, coefficient, time):
    """Integer counts within a symmetric corridor of radius coefficient*sqrt(time)."""
    if time == 0:
        return (0,)
    squared_width = coefficient**2 * time
    return tuple(
        count for count in range(time + 1)
        if (count - alpha * time)**2 <= squared_width
    )


def cost_and_cdf(alpha, time):
    a, d = alpha.numerator, alpha.denominator
    denominator = d**time
    weight = (d - a)**time
    total = 0
    absolute_numerator = time * a * d**(time - 1)
    cdf, costs = [], []
    for k in range(time + 1):
        costs.append(Fraction(absolute_numerator, time * denominator))
        total += weight
        cdf.append(Fraction(total, denominator))
        absolute_numerator += 2 * total - denominator
        if k < time:
            weight, remainder = divmod(weight * (time - k) * a, (k + 1) * (d - a))
            assert remainder == 0
    assert total == denominator
    return costs, cdf


def feasible_actions(count, allowed, time):
    if count not in allowed:
        assert count + 1 in allowed
        return (time,)
    if count + 1 not in allowed:
        return (0,)
    return range(time + 1)


def first_nonnegative(cdf, delta):
    left, right = 0, len(cdf) - 1
    while left < right:
        middle = (left + right) // 2
        if 2 * cdf[middle] - 1 + delta >= 0:
            right = middle
        else:
            left = middle + 1
    return left


def minimax(alpha, allowed):
    horizon = len(allowed) - 1
    value = dict.fromkeys(allowed[-1], Fraction())
    choices = [{} for _ in allowed]
    all_costs = [[] for _ in allowed]
    for time in range(horizon, 0, -1):
        costs, cdf = cost_and_cdf(alpha, time)
        all_costs[time] = costs
        previous_value = {}
        for count in allowed[time - 1]:
            actions = feasible_actions(count, allowed[time], time)

            def objective(k):
                return (
                    costs[k]
                    + Fraction(time - k, time) * value.get(count, 0)
                    + Fraction(k, time) * value.get(count + 1, 0)
                )

            if len(actions) == 1:
                chosen = actions[0]
            else:
                chosen = first_nonnegative(cdf, value[count + 1] - value[count])
            result = objective(chosen)
            if horizon <= 16:
                assert result == min(map(objective, actions))
            choices[time][count] = chosen
            previous_value[count] = result
        value = previous_value
    return value[0], choices, all_costs


def forward(alpha, allowed, choices, all_costs):
    """Forward path mass, minimax risk, absolute drift, known-law correction."""
    exact = {0: Fraction(1)}
    clipped = {0: Fraction(1)}
    risk = drift = known = Fraction()
    for time in range(1, len(allowed)):
        new_exact = dict.fromkeys(allowed[time], Fraction())
        new_clipped = dict.fromkeys(allowed[time], Fraction())
        for count, probability in exact.items():
            k = choices[time][count]
            q = Fraction(k, time)
            risk += probability * all_costs[time][k]
            drift += probability * abs(q - alpha)
            for bit, p in ((0, 1 - q), (1, q)):
                if p:
                    new_exact[count + bit] += probability * p
        for count, probability in clipped.items():
            for raw, p in ((0, 1 - alpha), (1, alpha)):
                bit = raw if count + raw in allowed[time] else 1 - raw
                new_clipped[count + bit] += probability * p
                known += probability * p * (bit != raw)
        assert sum(new_exact.values()) == sum(new_clipped.values()) == 1
        exact, clipped = new_exact, new_clipped
    return risk, drift, known


def all_rank_subsets(allowed, costs):
    """For small horizons enumerate every available subset on the full rank tree."""
    horizon = len(allowed) - 1

    @lru_cache(maxsize=None)
    def solve(order, count):
        time = len(order) + 1
        if time > horizon:
            return Fraction()
        values = []
        for mask in range(1 << time):
            k = mask.bit_count()
            if k not in feasible_actions(count, allowed[time], time):
                continue
            child_sum = Fraction()
            for rank in range(time):
                new_order = order[:rank] + (time,) + order[rank:]
                bit = (mask >> rank) & 1
                child_sum += solve(new_order, count + bit)
            values.append(costs[time][k] + child_sum / time)
        return min(values)

    return solve((), 0)


def main():
    for alpha, width in ((Fraction(1, 2), Fraction(1, 2)), (Fraction(1, 3), Fraction(3, 4))):
        for horizon in (4, 16, 64, 128):
            allowed = [critical_counts(alpha, width, t) for t in range(horizon + 1)]
            risk, choices, costs = minimax(alpha, allowed)
            replay, drift, known = forward(alpha, allowed, choices, costs)
            independent = sum(min(row) for row in costs[1:])
            joint = max(
                scale * known + sum(
                    min(c - scale * abs(Fraction(k, t) - alpha) for k, c in enumerate(costs[t]))
                    for t in range(1, horizon + 1)
                )
                for scale in (Fraction(j, 8) for j in range(9))
            )
            assert risk == replay
            assert known <= drift <= risk and max(known, independent, joint) <= risk
            if horizon == 4:
                assert risk == all_rank_subsets(allowed, costs)
                print(f"alpha={alpha}, kappa={width}, T=4: exact value={risk}")
            else:
                print(f"alpha={alpha}, kappa={width}, T={horizon}: "
                      f"minimax={float(risk):.9f}  learned={float(independent):.9f}  "
                      f"known={float(known):.9f}  joint_bound={float(joint):.9f}")
    print("Rank tree, Bellman recursion, forward replay and finite-horizon lower bounds agree.")


if __name__ == "__main__":
    main()
