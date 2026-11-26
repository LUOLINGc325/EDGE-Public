#!/usr/bin/env python3
"""Finite exact DP checks on the route to the critical variational limit."""

from fractions import Fraction
from pathlib import Path
from runpy import run_path


def main():
    cases = Path(__file__).resolve().parents[2]
    model = run_path(str(cases / "online-conformal-minimax-dp" / "code" / "exact_certificate.py"))
    alpha = width = Fraction(1, 2)
    for root_horizon in (2, 4, 8, 12, 16):
        horizon = root_horizon**2
        allowed = [model["critical_counts"](alpha, width, t) for t in range(horizon + 1)]
        exact, choices, stages = model["minimax"](alpha, allowed)
        replay, drift, known = model["forward"](alpha, allowed, choices, stages)
        assert exact == replay and known <= drift <= exact
        if horizon == 4:
            assert exact == model["all_rank_subsets"](allowed, stages) == Fraction(23, 16)
        print(f"T={horizon:3d}  exact M_T/√T displayed as {float(exact/root_horizon):.9f}")
    print("Finite checks corroborate the recurrence. They do not evaluate the limiting value.")


if __name__ == "__main__":
    main()
