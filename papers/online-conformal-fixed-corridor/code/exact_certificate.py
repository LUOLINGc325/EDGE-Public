"""Check pathwise optimality and exact risk identities with rational arithmetic."""
from fractions import Fraction
from itertools import product
from math import ceil, floor


def bounds(alpha, lower, upper, t):
    return ceil(alpha * t - lower), floor(alpha * t + upper)


def clip(value, left, right):
    return min(right, max(left, value))


def bounded_cost(alpha, lower, upper, input_bits):
    state = 0
    greedy_cost = 0
    optimal_by_state = {0: 0}
    for t, bit in enumerate(input_bits, 1):
        left, right = bounds(alpha, lower, upper, t)
        next_state = clip(state + bit, left, right)
        greedy_cost += abs(next_state - state - bit)
        state = next_state
        next_cost = {}
        for previous, cost in optimal_by_state.items():
            for output in (0, 1):
                target = previous + output
                if left <= target <= right:
                    candidate = cost + abs(output - bit)
                    next_cost[target] = min(next_cost.get(target, candidate), candidate)
        assert next_cost
        assert all(greedy_cost + abs(state - other) <= cost
                   for other, cost in next_cost.items())
        optimal_by_state = next_cost
    return greedy_cost


def expected_prefix_risk(alpha, lower, upper, horizon):
    distribution = {0: Fraction(1)}
    risk = Fraction(0)
    for t in range(1, horizon + 1):
        left, right = bounds(alpha, lower, upper, t)
        next_distribution = {}
        for count, mass in distribution.items():
            for bit, p in ((0, 1 - alpha), (1, alpha)):
                target = clip(count + bit, left, right)
                transition_mass = mass * p
                next_distribution[target] = next_distribution.get(target, 0) + transition_mass
                risk += transition_mass * abs(target - count - bit)
        assert sum(next_distribution.values()) == 1
        distribution = next_distribution
    return risk


def main():
    cases = (
        (Fraction(1, 2), Fraction(1, 2), Fraction(1, 2)),
        (Fraction(1, 3), Fraction(1, 2), Fraction(1, 2)),
        (Fraction(2, 5), Fraction(1, 5), Fraction(4, 5)),
        (Fraction(3, 4), Fraction(2, 3), Fraction(5, 4)),
    )
    for alpha, lower, upper in cases:
        for bits in product((0, 1), repeat=9):
            bounded_cost(alpha, lower, upper, bits)
    print("Pathwise comparison against exact dynamic programming: 2048 words of length 9.")

    for alpha, lower, upper in cases[:3]:
        q = alpha.denominator
        frequency = Fraction(1, q) if (q * lower).denominator == 1 else Fraction(0)
        rate = 2 * alpha * (1 - alpha) * (1 - frequency)
        horizon = 6 * q
        risk = expected_prefix_risk(alpha, lower, upper, horizon)
        assert risk == horizon * rate
        print(f"Width one: alpha={alpha}, lower={lower}, T={horizon}, V_T/T={rate}.")

    for radius in (Fraction(1, 2), Fraction(3, 4), Fraction(1), Fraction(3, 2), Fraction(2)):
        m = floor(2 * radius)
        weights = [1] + [2] * (2 * m - 1) + [1]
        denominator = sum(weights)
        change_probability = Fraction(weights[0] + weights[-1], 2 * denominator)
        assert change_probability == Fraction(1, 4 * m)
        print(f"Symmetric alpha=1/2: kappa={radius}, invariant mean={change_probability}.")


if __name__ == "__main__":
    main()
