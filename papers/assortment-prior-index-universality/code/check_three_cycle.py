"""Exact rational checks for a six-support cycle."""
from fractions import Fraction as F
from pathlib import Path
import json


SUPPORT = (0, 11, 15, 30, 100, 1000)
MEAN_ALLOCATIONS_OVER_20 = (
    (11, 3, 2, 2, 2),
    (14, 6, 0, 0, 0),
    (4, 2, 0, 11, 3),
)


def priors():
    rows = []
    for allocation in MEAN_ALLOCATIONS_OVER_20:
        tail = [F(weight, 20 * value)
                for weight, value in zip(allocation, SUPPORT[1:])]
        row = [1 - sum(tail)] + tail
        assert min(row) >= 0
        assert sum(row) == 1
        assert sum(value * prob for value, prob in zip(SUPPORT, row)) == 1
        rows.append(row)
    return rows


def compare(p, q):
    c_first_p = F(0)
    c_first_q = F(0)
    c_both = F(0)
    kernel = F(0)
    for i, x in enumerate(SUPPORT):
        for j, y in enumerate(SUPPORT):
            probability = p[i] * q[j]
            top_two_sum = sum(sorted((x, y, 10, 5), reverse=True)[:2])
            r = F(top_two_sum, 1 + top_two_sum)
            u, v = max(10, x), max(10, y)
            cost_p = 2 * r + (r - 1) * (12 + u)
            cost_q = 2 * r + (r - 1) * (12 + v)
            cost_b = F(3, 2) * r + 2 * (r - 1) + F(u + v, 2) * (r - 1)
            # Independent geometric-epoch derivation of the same conditional costs.
            first_epoch_single = 12 * r - 11
            after_p = (2 + u) * r - (1 + u)
            after_q = (2 + v) * r - (1 + v)
            first_epoch_both = F(3, 2) * r - 1
            assert cost_p == first_epoch_single + after_p
            assert cost_q == first_epoch_single + after_q
            assert cost_b == first_epoch_both + (after_p + after_q) / 2
            assert cost_q - cost_p == F(u - v, 1 + top_two_sum)
            assert cost_b - cost_p == F(20 + u - v - top_two_sum, 2 * (1 + top_two_sum))
            c_first_p += probability * cost_p
            c_first_q += probability * cost_q
            c_both += probability * cost_b
            kernel += probability * F(u - v, 1 + u + v)
    gap = c_first_q - c_first_p
    assert kernel == gap
    assert gap > 0
    assert c_both - c_first_p >= F(17, 640)
    assert c_both - c_first_q >= F(17, 640)
    value = min(c_first_p, c_first_q, c_both)
    first_action_both_gap = F(2, 3) * (c_both - value)
    first_action_wrong_single_gap = gap / 12
    assert first_action_both_gap >= F(17, 960)
    return {
        "first_i": str(c_first_p),
        "first_j": str(c_first_q),
        "both": str(c_both),
        "j_minus_i": str(gap),
        "kernel": str(kernel),
        "both_minus_i": str(c_both - c_first_p),
        "both_minus_j": str(c_both - c_first_q),
        "one_action_both_bellman_gap": str(first_action_both_gap),
        "one_action_wrong_single_bellman_gap": str(first_action_wrong_single_gap),
        "gap_decimal_diagnostic_only": float(gap),
    }


def main():
    rows = priors()
    result = {
        "status": "exact_rational_diagnostic_pass",
        "formalization_performed": False,
        "x": SUPPORT,
        "mean_allocation_over_20": MEAN_ALLOCATIONS_OVER_20,
        "probabilities": [[str(q) for q in row] for row in rows],
        "mean": ["1"] * len(rows),
        "pairs": {f"{i + 1}>{j + 1}": compare(rows[i], rows[j])
                  for i, j in ((0, 1), (1, 2), (2, 0))},
    }
    destination = Path(__file__).resolve().parents[1] / "results" / "three_cycle.json"
    destination.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"status": result["status"], "output": str(destination)}, indent=2))


if __name__ == "__main__":
    main()
