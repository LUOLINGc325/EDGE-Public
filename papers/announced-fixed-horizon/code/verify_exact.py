"""Exact, finite diagnostics for fixed-horizon CVaR one-max search."""

from fractions import Fraction as F
from itertools import combinations_with_replacement, product
import json


def grid_endpoint(alpha, delta, knots):
    """Return 1+y_k or None for an infinite saturation threshold."""
    coefficient = alpha / (1 - delta)
    prices_minus_one = []
    for index, endpoint in enumerate(knots[1:], 1):
        stop = max(0, endpoint - delta)
        earlier = sum(
            max(0, min(stop, knots[j]) - knots[j - 1]) * prices_minus_one[j - 1]
            for j in range(1, index)
        )
        self_weight = coefficient * max(0, stop - knots[index - 1])
        if self_weight >= 1:
            return None
        prices_minus_one.append((alpha - 1 + coefficient * earlier) / (1 - self_weight))
    return 1 + prices_minus_one[-1]


def low_endpoint(horizon, alpha, delta):
    coefficient = alpha / (1 - delta)
    factor = 1 + coefficient * delta - coefficient / horizon
    if factor <= 0:
        return None
    return 1 + (alpha - 1) * (1 + coefficient * delta) ** (horizon - 1) / factor**horizon


def high_endpoint(horizon, alpha, delta):
    coefficient = alpha / (1 - delta)
    return alpha**2 + (alpha - 1) * coefficient**2 * F(horizon - 1, 2 * (horizon - 2)) * (1 - 2 * delta)**2


def low_grid(horizon):
    return tuple(F(i, horizon) for i in range(horizon + 1))


def high_grid(horizon, delta):
    span = 1 - 2 * delta
    return (F(0), *(delta + i * span / (horizon - 2) for i in range(horizon - 1)), F(1))


def accept_to_target(alpha, delta, offers):
    """Replay the continuous greedy rule by exact inversion in its sale law."""
    sale_law = []
    spent = F(0)
    largest = F(1)
    q = 1 - delta
    for offer in offers:
        if offer <= largest:
            continue
        largest = offer
        if offer <= alpha:
            continue

        needed = q * (offer / alpha - 1)
        mass_below = F(0)
        sold_so_far = [*sale_law, (1 - spent, offer)]
        for mass, price in sold_so_far:
            contribution = mass * (price - 1)
            if needed <= contribution:
                target = max(spent, delta + mass_below + needed / (price - 1))
                break
            mass_below += mass
            needed -= contribution
        else:
            return None
        if target > 1:
            return None
        if target > spent:
            sale_law.append((target - spent, offer))
            spent = target
    return [(1 - spent, F(1)), *sale_law]


def lower_tail_mean(law, q):
    total = F(0)
    remaining = q
    for mass, price in sorted(law, key=lambda pair: pair[1]):
        taken = min(mass, remaining)
        total += taken * price
        remaining -= taken
        if remaining == 0:
            return total / q
    raise ValueError("Incomplete probability law")


def two_round_ratio(theta, delta):
    midpoint = F(2)
    assert theta == midpoint**2
    q = 1 - delta
    capped = min(1, 1 / (2 * q))
    expected = 1 / (1 - (1 - 1 / midpoint) * capped)
    for first in (F(1), F(5, 4), F(3, 2), F(2), F(5, 2), F(3), F(4)):
        loss_low = 1 - 1 / first
        loss_high = 1 - first / theta
        possible = {F(0), F(1), delta, q, loss_low / (loss_low + loss_high)}
        best = min(
            max(
                1 - lower_tail_mean([(p, first), (1 - p, F(1))], q) / first,
                1 - lower_tail_mean([(p, first), (1 - p, theta)], q) / theta,
            )
            for p in possible
        )
        assert 1 / (1 - best) <= expected
        if first == midpoint:
            assert 1 / (1 - best) == expected
    return expected


def check_four_offer_transition():
    """Compare three exact inequalities with directly integrated staircases."""
    count = 0
    for delta in (F(13, 50), F(7, 24), F(3, 10), F(8, 25), F(33, 100)):
        q = 1 - delta
        s = 1 - 3 * delta
        span = 1 - 2 * delta
        for breaks in combinations_with_replacement(range(21), 3):
            a, b, d, e = (F(j - i, 20) * span for i, j in zip((0, *breaks), (*breaks, 20)))
            widths = (delta + a, b, d, e)
            heights = (a, a + b, a + b + d, q)
            bounds = (F(0), delta + a, delta + a + b, q - e, q)
            second = sum(width * height for width, height in zip(widths, heights))
            third = sum(
                width * sum(height * max(0, min(upper, endpoint) - lower)
                            for lower, upper, height in zip(bounds, bounds[1:], heights))
                for width, endpoint in zip(widths, heights)
            )
            outer_width = a + e
            outer_product = a * e
            middle_product = b * d
            assert second == span**2 - outer_product - middle_product + outer_width * (outer_width - s)
            assert third == (outer_width * second - q * outer_product
                             + middle_product * max(0, s - outer_width)
                             + b**2 * max(0, b - delta) + d**2 * max(0, d - delta))
            assert second >= 3 * span**2 / 4
            assert second + third / s >= span**2
            assert third >= delta * s**2
            for coefficient in (F(3, 2), 1 / s, 2 / s):
                if coefficient * s <= 1:
                    limit = span**2 * (3 + coefficient * s) / 4
                else:
                    limit = span**2 - delta * s + coefficient * delta * s**2
                assert second + coefficient * third >= limit
            count += 1

        for coefficient, middle_width in ((F(3, 2), span / 2), (1 / s, span / 2),
                                          (1 / s, s), (2 / s, s), (2 / s, delta)):
            alpha = coefficient * q
            if coefficient * s <= 1:
                limit = span**2 * (3 + coefficient * s) / 4
            else:
                limit = span**2 - delta * s + coefficient * delta * s**2
            expected = 1 + (alpha - 1) * (1 + coefficient * q + coefficient**2 * limit)
            knots = (F(0), delta, delta + middle_width, q, F(1))
            assert grid_endpoint(alpha, delta, knots) == expected
    return count


def verify():
    count_grids = 0
    count_exact_witnesses = 0
    count_quote_sequences = 0
    for horizon in range(2, 6):
        low_deltas = sorted({F(0), F(1, 2 * horizon), F(1, horizon)})
        high_deltas = [F(1, 3), F(2, 5), F(1, 2)] if horizon >= 3 else []
        for alpha, (delta, endpoint_function, optimal_grid) in product(
            [F(4, 3), F(3, 2), F(2)],
            [(d, low_endpoint, low_grid(horizon)) for d in low_deltas]
            + [(d, high_endpoint, high_grid(horizon, d)) for d in high_deltas],
        ):
            expected = endpoint_function(horizon, alpha, delta)
            assert grid_endpoint(alpha, delta, optimal_grid) == expected
            count_exact_witnesses += 1
            for interior in combinations_with_replacement(range(13), horizon - 1):
                knots = (F(0), *(F(j, 12) for j in interior), F(1))
                actual = grid_endpoint(alpha, delta, knots)
                assert actual is None or (expected is not None and actual >= expected)
                count_grids += 1
            if expected is None:
                continue
            if horizon <= 3:
                quotes = [1 + i * (expected - 1) / 5 for i in range(6)]
                for offers in product(quotes, repeat=horizon):
                    law = accept_to_target(alpha, delta, offers)
                    assert law is not None
                    assert max(offers) <= alpha * lower_tail_mean(law, 1 - delta)
                    count_quote_sequences += 1

    assert low_endpoint(3, F(2), F(1, 5)) == F(275, 32)
    assert low_endpoint(3, F(2), F(1, 3)) == high_endpoint(3, F(2), F(1, 3)) == 5
    assert high_endpoint(3, F(2), F(2, 5)) == F(40, 9)
    assert high_endpoint(4, F(2), F(2, 5)) == F(13, 3)
    assert high_endpoint(8, F(2), F(1, 2)) == 4
    assert two_round_ratio(F(4), F(0)) == F(4, 3)
    assert two_round_ratio(F(4), F(1, 3)) == F(8, 5)
    assert two_round_ratio(F(4), F(1, 2)) == F(2)
    assert two_round_ratio(F(4), F(9, 10)) == F(2)

    # A single reservation price must have F(8/3)=1/3 at these parameters.
    # The preceding offer 7/3 then makes at least this much low-tail mass cheaper.
    delta = F(1, 6)
    earlier = accept_to_target(F(2), delta, [F(7, 3)])
    assert earlier[-1][0] == F(13, 48)
    law = [(F(2, 3), F(1)), (F(13, 48), F(7, 3)), (F(1, 16), F(8, 3))]
    assert F(8, 3) / 2 - lower_tail_mean(law, 1 - delta) == F(1, 15)

    # Move off the first endpoint t_1=delta, retaining strictly active rows.
    ideal = high_grid(4, F(2, 5))
    endpoint = high_endpoint(4, F(2), F(2, 5))
    errors = []
    for shift in (F(1, 100), F(1, 1000), F(1, 10000)):
        knots = (ideal[0], ideal[1] + shift, *ideal[2:])
        assert all(a < b for a, b in zip(knots, knots[1:]))
        actual = grid_endpoint(F(2), F(2, 5), knots)
        errors.append(actual - endpoint)
    assert errors[0] > errors[1] > errors[2] > 0

    print(json.dumps({
        "status": "pass",
        "exact_endpoint_witnesses": count_exact_witnesses,
        "mass_grids": count_grids,
        "four_offer_transition_grids": check_four_offer_transition(),
        "quote_sequences": count_quote_sequences,
        "boundary_examples": 9,
        "perturbation_errors": [str(error) for error in errors],
        "scope": "Finite exact checks only. The written proof establishes the unrestricted statements.",
    }, indent=2))


if __name__ == "__main__":
    verify()
