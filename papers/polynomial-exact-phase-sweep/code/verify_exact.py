"""Reproduce the exact arithmetic sweep and cross-check it against direct rows."""

import json
from fractions import Fraction

R = Fraction


def require(condition, message):
    if not condition:
        raise ValueError(message)


def right_branches(cost, point):
    """Return the capacities at point and the branches just to its right."""
    value = [R(0)]
    prefix = [R(0)]
    branch = [0]
    start = 1
    for i in range(1, cost + 1):
        linear = (i * point + prefix[i - 1]) / (cost - 1)
        if linear < 1:
            row = linear
            branch.append(0)
        else:
            while True:
                row = 1 + (
                    i * point - (cost - 1) + prefix[i - 1] - prefix[start - 1]
                ) / (i - start)
                if row < 1 + value[start]:
                    break
                start += 1
            branch.append(start)
        value.append(row)
        prefix.append(prefix[-1] + row)
    return value, branch


def coefficients(cost, branches):
    slope, intercept = [R(0)], [R(0)]
    sum_slope, sum_intercept = [R(0)], [R(0)]
    for i, start in enumerate(branches[1:], 1):
        if start == 0:
            denominator = cost - 1
            alpha = (i + sum_slope[-1]) / denominator
            beta = sum_intercept[-1] / denominator
        else:
            denominator = i - start
            alpha = (i + sum_slope[-1] - sum_slope[start - 1]) / denominator
            beta = 1 + (
                sum_intercept[-1] - sum_intercept[start - 1] - (cost - 1)
            ) / denominator
        slope.append(alpha)
        intercept.append(beta)
        sum_slope.append(sum_slope[-1] + alpha)
        sum_intercept.append(sum_intercept[-1] + beta)
    return slope, intercept


def exact_sweep(cost):
    critical = R(cost - 1, cost)
    left = 1 / (R(cost, cost - 1) ** cost - 1)
    while left < critical:
        values, branches = right_branches(cost, left)
        slope, intercept = coefficients(cost, branches)
        require(all(a * left + b == t for a, b, t in zip(slope, intercept, values)),
                f"left coefficient mismatch at B={cost}, r={left}")
        right = critical
        for i, start in enumerate(branches[1:], 1):
            crossing = (1 - intercept[i] + intercept[start]) / (slope[i] - slope[start])
            require(crossing > left, f"nonfuture event at B={cost}, r={left}")
            right = min(right, crossing)
        yield (left, right, slope, intercept)
        left = right


def row_value(cost, point, past):
    capped = min(R(1), point)
    return (cost - 1) * capped - sum(max(R(0), capped - point + v) for v in past)


def direct_roots(cost, parameter):
    """Solve a row from its breakpoints and continuity, without suffix formulas."""
    values = [R(0)]
    critical = R(cost - 1, cost)
    for i in range(1, cost + 1):
        left = values[-1]
        if i == cost and parameter == critical:
            values.append(left + 1)
            break
        points = sorted({left, left + 1, *(
            1 + v for v in values if left < 1 + v < left + 1
        )})
        for right in points[1:]:
            flo = row_value(cost, left, values[1:])
            fhi = row_value(cost, right, values[1:])
            if flo <= i * parameter <= fhi and fhi > flo:
                values.append(left + (right - left) * (i * parameter - flo) / (fhi - flo))
                break
            left = right
        else:
            raise ValueError(f"root not bracketed at B={cost}, r={parameter}, row={i}")
    return values


def bit_length(values):
    return max(max(abs(v.numerator).bit_length(), v.denominator.bit_length()) for v in values)


def check(cost, check_interiors):
    table = list(exact_sweep(cost))
    critical = R(cost - 1, cost)
    endpoint = direct_roots(cost, critical)
    expected = sum(t > 1 for t in endpoint[1:cost])
    expected += sum(endpoint[i] - endpoint[j] > 1
                    for i in range(2, cost + 1) for j in range(1, i))
    seen = 0
    largest_batch = 0
    max_bits = 0
    previous_slope = None
    cutoff = 1 / endpoint[-1]
    for left, right, slope, intercept in table:
        require(left < right, "zero-length segment")
        require(all(a < b for a, b in zip(slope, slope[1:])), "slope order failed")
        right_values = [a * right + b for a, b in zip(slope, intercept)]
        if check_interiors:
            for sample in (left, (left + right) / 2):
                actual = direct_roots(cost, sample)
                require([a * sample + b for a, b in zip(slope, intercept)] == actual,
                        f"direct root mismatch at B={cost}, r={sample}")
        if previous_slope is not None:
            require(previous_slope < slope[-1], "value phase is redundant")
        previous_slope = slope[-1]
        if right < critical:
            count = sum(t == 1 for t in right_values[1:cost])
            count += sum(right_values[i] - right_values[j] == 1
                         for i in range(2, cost + 1) for j in range(1, i))
            require(count > 0, "breakpoint has no indexed event")
            seen += count
            largest_batch = max(largest_batch, count)
        value_slope = slope[-1]
        value_intercept = intercept[-1]
        risk_endpoint = 1 / right_values[-1]
        probability_constants = [(slope[i] - slope[i - 1]) / value_slope
                                 for i in range(1, cost + 1)]
        probability_slopes = [
            intercept[i] - intercept[i - 1] - value_intercept * probability_constants[i - 1]
            for i in range(1, cost + 1)
        ]
        require(sum(probability_constants) == 1 and sum(probability_slopes) == 0,
                "optimizer coefficients are not normalized")
        max_bits = max(max_bits, bit_length([left, right, risk_endpoint,
                      *slope, *intercept, *probability_constants, *probability_slopes]))
    require(seen == expected, f"multiplicity mismatch for B={cost}")
    require(table[-1][1] == critical and right_values == endpoint, "endpoint disagreement")
    require(len(table) <= cost * (cost - 1) // 2, "quadratic bound failed")
    return {
        "B": cost,
        "randomized_pieces": len(table),
        "indexed_events": seen,
        "max_simultaneous_events": largest_batch,
        "largest_output_rational_bits": max_bits,
        "plateau_starts_at_tail_mass": str(cutoff),
        "independent_direct_rows_checked_in_every_cell": check_interiors,
    }


def main():
    sizes = [*range(2, 17), 20, 24, 32, 48]
    results = [check(cost, cost <= 24) for cost in sizes]
    print(json.dumps({"arithmetic": "fractions.Fraction", "results": results}, indent=2))


if __name__ == "__main__":
    main()
