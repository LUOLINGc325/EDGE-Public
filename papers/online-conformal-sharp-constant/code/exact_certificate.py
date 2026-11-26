#!/usr/bin/env python3
"""Exact Bernoulli clipping checks for two symmetric/asymmetric corridors."""

from collections import defaultdict
from decimal import Decimal, localcontext
from fractions import Fraction


def inside(count, time, alpha_num, alpha_den, lower, upper):
    offset_num = count * alpha_den - alpha_num * time
    coefficient, power_den = lower if offset_num < 0 else upper
    return (
        (abs(offset_num) * coefficient.denominator) ** power_den
        <= (alpha_den * coefficient.numerator) ** power_den * time
    )


def check(alpha, lower, upper, checkpoints):
    a, d = alpha.numerator, alpha.denominator
    sigma2 = alpha * (1 - alpha)
    weights = {0: 1}
    mass = 1
    cumulative = 0
    second_moment = 0
    for time in range(1, max(checkpoints) + 1):
        next_weights = defaultdict(int)
        disagreements = 0
        cross_term = 0
        for count, weight in weights.items():
            assert inside(count, time, a, d, lower, upper) or (
                inside(count + 1, time, a, d, lower, upper)
            )
            for raw, probability_num in ((0, d - a), (1, a)):
                clipped = raw
                if not inside(count + raw, time, a, d, lower, upper):
                    clipped = 1 - raw
                assert inside(count + clipped, time, a, d, lower, upper)
                next_weights[count + clipped] += weight * probability_num
                if clipped != raw:
                    weighted_event = weight * probability_num
                    disagreements += weighted_event
                    coefficient_num = 2 * (count * d - a * (time - 1)) + d - 2 * a
                    cross_term += coefficient_num * (clipped - raw) * weighted_event

        mass *= d
        assert sum(next_weights.values()) == mass
        next_moment = sum(
            (count * d - a * time) ** 2 * weight
            for count, weight in next_weights.items()
        )
        # Check the square expansion around zero, so no irrational boundaries
        # or midpoints enter the arithmetic even for an asymmetric example.
        assert next_moment - d * second_moment == (
            a * (d - a) * mass + d * cross_term
        )
        second_moment = next_moment
        cumulative = d * cumulative + disagreements
        weights = next_weights
        if time in checkpoints:
            with localcontext() as ctx:
                ctx.prec = 32
                expectation = Decimal(cumulative) / Decimal(mass)
                print(f"T={time:5d}  E[edits]={expectation:.12f}  states={len(weights)}")
    dominant_power_den = min(lower[1], upper[1])
    beta = 1 - Fraction(1, dominant_power_den)
    leading_width = sum(
        side[0] for side in (lower, upper) if side[1] == dominant_power_den
    )
    print(f"predicted limit E[edits]/T^beta: beta={beta}, constant={sigma2 / (beta * leading_width)}")


def main():
    times = (16, 64, 256, 1024, 4096)
    print("symmetric: alpha=1/3, radius=(1/2)t^(1/4)")
    check(Fraction(1, 3), (Fraction(1, 2), 4), (Fraction(1, 2), 4), times)
    print("asymmetric: alpha=2/5, lower=(2/3)t^(1/4), upper=(1/3)t^(1/5)")
    check(Fraction(2, 5), (Fraction(2, 3), 4), (Fraction(1, 3), 5), times)
    print("All probability-mass, feasibility, and quadratic-potential checks passed.")


if __name__ == "__main__":
    main()
