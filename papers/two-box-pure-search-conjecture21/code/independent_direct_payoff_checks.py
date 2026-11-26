"""Independent exact-payoff corroboration; no budget-transition implementation.

This finite computation is not the general proof. It sums survival probabilities
within a prefix and period, then closes the infinite tail geometrically.
"""
from fractions import Fraction as F
from itertools import product
from pathlib import Path
import json


def utility(m, prefix, period, box):
    r = F(1, m)
    visits = 0
    elapsed = F(0)
    for searched in prefix:
        elapsed += r**visits
        visits += searched == box
    period_visits = 0
    period_sum = F(0)
    for searched in period:
        period_sum += r**period_visits
        period_visits += searched == box
    if period_visits == 0:
        return None  # Infinite conditional expected time.
    return elapsed + r**visits * period_sum / (1 - r**period_visits)


def run():
    checks = []
    for m in range(3, 31):
        delta = F(m - 1, m ** (m - 1) - 1)
        value = F(m, m - 1) + 1 + delta / m
        period = (2,) * (m - 1) + (1,) * (m - 1)
        payoffs = [utility(m, (1, 2), period, box) for box in (1, 2)]
        source_value = 2 + F(1, m) + F(
            m ** (m - 2) + m - 2, (m - 1) * (m ** (m - 1) - 1)
        )
        assert payoffs == [value, value]
        assert value == source_value
        assert delta / m < 1
        assert m ** (m - 2) * delta < 1
        checks.append({
            "m": m, "V": str(value), "U1": str(payoffs[0]),
            "U2": str(payoffs[1]), "paper_value_equal": True,
            "last_forced_slack": str(1 - m ** (m - 2) * delta),
        })

    policies = 0
    minima = []
    for m in range(3, 7):
        value = F(m, m - 1) + 1 + F(m - 1, m * (m ** (m - 1) - 1))
        best = None
        ties = 0
        for prefix_length in range(3):
            for prefix in product((1, 2), repeat=prefix_length):
                for period_length in range(1, 9):
                    for period in product((1, 2), repeat=period_length):
                        payoffs = [utility(m, prefix, period, box) for box in (1, 2)]
                        if None in payoffs:
                            continue
                        policies += 1
                        worst = max(payoffs)
                        assert worst >= value, (m, prefix, period, worst, value)
                        if best is None or worst < best:
                            best = worst
                            ties = 1
                        elif worst == best:
                            ties += 1
        minima.append({
            "m": m, "finite_family_minimum": str(best),
            "theorem_value": str(value), "equal": best == value,
            "representations_at_finite_family_minimum": ties,
        })
    return {
        "candidate_checks": checks,
        "enumerated_finite_payoff_policies": policies,
        "family": "prefix length 0..2; period length 1..8; both labels in period; m=3..6",
        "enumerated_minima": minima,
        "note": "Finite enumeration is corroboration only, not the proof. m=6 candidate period length 10 is outside enumerated family.",
    }


if __name__ == "__main__":
    result = run()
    target = Path(__file__).resolve().parents[1] / "results" / "independent_direct_payoff_checks.json"
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(json.dumps(result, indent=2) + "\n")
    print(f"Verified {len(result['candidate_checks'])} candidate cases and {result['enumerated_finite_payoff_policies']} ultimately periodic policies.")
