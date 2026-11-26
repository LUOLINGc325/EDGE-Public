#!/usr/bin/env python3
"""Independent exact diagnostics for the common-patience scheduling proof.

No simulation and no Lean are used.  The optimal Bellman value is evaluated
from beta-integrated survivor transition probabilities; the SP1 value is
evaluated from a different first-event recurrence.  Finite-state agreement
is diagnostic only.  The all-state theorem is proved in the manuscript.
"""

from fractions import Fraction as Q
from functools import lru_cache
from math import comb, factorial
from pathlib import Path
import json

import sympy as sy


def symbolic_checks():
    a, b, n, m = sy.symbols("a b n m", positive=True)
    A, B = a - 1, b - 1
    H = A * (b + m - 1) + n * B
    p, d = a + n - 1, a + n + m - 1
    h = b * A / H
    identity1 = d * h - p * h.subs(n, n - 1) - (m - 1) * h.subs(m, m - 1)
    identity1 -= b * A * (a - b) * B * p / (H * (H - A) * (H - B))
    c = (a - b) / (a + 1)
    M = b * A - n * c
    h = M / H
    N, L = n - 1, m - 1
    P = A * A * L * (L + 1 + 2 * B) + B * B * N * (N + 1 + 2 * A)
    P += 2 * A * B * (L * N + L + N)
    identity2 = d * h - p * h.subs(n, n - 1) - (m - 1) * h.subs(m, m - 1)
    identity2 += (a - b) * p * P / ((a + 1) * H * (H - A) * (H - B))
    lo, hi = a * b / ((a + n) * (b + m - 1)), a / (a + n)
    identity3 = H * lo - M
    identity3 -= n * ((a - b) * (n - 1) * (b + m - 1)
                      + a * (a + 1) * (1 - b) * (m - 1)) / (
                          (a + 1) * (a + n) * (b + m - 1))
    identity4 = H * hi - M
    identity4 -= (a * (a * a - 1) * (m - 1)
                  + (a - b) * n * (n - 1)) / ((a + 1) * (a + n))
    identities = [identity1, identity2, identity3, identity4]
    for index, expression in enumerate(identities, 1):
        assert sy.factor(expression) == 0, f"rational identity {index} failed"
    return len(identities)


@lru_cache(maxsize=None)
def survivor_probability(rate, n, m, i, j):
    """P(Bin(n,Z)=i, Bin(m,Z)=j), Z~Beta(rate,1)."""
    losses = n + m - i - j
    value = rate * comb(n, i) * comb(m, j) * factorial(losses)
    for k in range(losses + 1):
        value /= rate + i + j + k
    return value


def exact_case(a, b, ratio, limit=5):
    rewards = (ratio, Q(1))
    rates = (a, b)
    optimal, priority = {}, {}
    checked_probabilities = 0
    checked_states = 0
    strict_states = 0
    min_advantage = None
    for total in range(2 * limit + 1):
        for n in range(limit + 1):
            m = total - n
            if m < 0 or m > limit:
                continue
            if total == 0:
                optimal[n, m] = priority[n, m] = Q(0)
                continue
            actions = []
            for action in (0, 1):
                if (n, m)[action] == 0:
                    continue
                waiting_n, waiting_m = n - (action == 0), m - (action == 1)
                value = rewards[action]
                mass = Q(0)
                for i in range(waiting_n + 1):
                    for j in range(waiting_m + 1):
                        probability = survivor_probability(rates[action], waiting_n, waiting_m, i, j)
                        mass += probability
                        value += probability * optimal[i, j]
                assert mass == 1
                checked_probabilities += 1
                actions.append((action, value))
            optimal[n, m] = max(value for _, value in actions)
            if n == 0:
                priority[n, m] = priority[n, m - 1] + b / (b + m - 1)
            else:
                numerator = (a + n - 1) * priority[n - 1, m] + a * ratio
                if m:
                    numerator += m * priority[n, m - 1]
                priority[n, m] = numerator / (a + n + m - 1)
            assert optimal[n, m] == priority[n, m], (a, b, ratio, n, m)
            checked_states += 1
            if n and m:
                values = dict(actions)
                advantage = values[0] - values[1]
                assert advantage >= 0
                min_advantage = advantage if min_advantage is None else min(min_advantage, advantage)
                strict_states += advantage > 0
    return {
        "a": str(a), "b": str(b), "reward_ratio": str(ratio),
        "states_checked": checked_states,
        "transition_mass_checks": checked_probabilities,
        "strict_priority_states": strict_states,
        "minimum_first_action_advantage": str(min_advantage),
    }


def main():
    identities = symbolic_checks()
    levels = [Q(1, 4), Q(1, 2), Q(1), Q(2), Q(4)]
    rows = []
    for a in levels:
        for b in levels:
            boundary = max(b / a, (b + 1) / (a + 1))
            for ratio in (boundary, boundary + Q(1, 3)):
                rows.append(exact_case(a, b, ratio))
    result = {
        "status": "pass",
        "arithmetic": "exact rational and symbolic polynomial arithmetic",
        "rational_identities_checked": identities,
        "parameter_instances": len(rows),
        "states_checked": sum(row["states_checked"] for row in rows),
        "transition_mass_checks": sum(row["transition_mass_checks"] for row in rows),
        "state_range": "0 <= n,m <= 5, excluding (0,0) from checked count",
        "proof_scope": "finite diagnostics; universal result relies on the analytical proof",
        "lean_compiled": False,
        "instances": rows,
    }
    output = Path(__file__).resolve().parents[1] / "results" / "independent_diagnostics.json"
    output.write_text(json.dumps(result, indent=2, ensure_ascii=False) + "\n")
    print(json.dumps({key: val for key, val in result.items() if key != "instances"}, indent=2))


if __name__ == "__main__":
    main()
