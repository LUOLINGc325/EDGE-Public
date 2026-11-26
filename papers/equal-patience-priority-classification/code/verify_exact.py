#!/usr/bin/env python3
"""Exact, finite diagnostics for the equal-patience priority theorem.

The integral service-completion Bellman solver is independent of the
first-event recurrences used in the analytic proof. Fractions are exact.
This program is not a proof for arbitrary queue sizes and does not run Lean.
"""
from fractions import Fraction as Q
from functools import lru_cache
from math import comb, factorial
from pathlib import Path
import json


@lru_cache(None)
def beta_integer(x, k):
    """B(x,k+1) for positive rational x and nonnegative integer k."""
    denominator = Q(1)
    for j in range(k + 1):
        denominator *= x + j
    return Q(factorial(k), 1) / denominator


@lru_cache(None)
def transitions(rate, n, m):
    # P=exp(-T) has density rate*p**(rate-1); surviving counts are
    # conditionally independent Bin(n,P), Bin(m,P), with the same P.
    rows = tuple(
        (i, j, comb(n, i) * comb(m, j) * rate
         * beta_integer(rate + i + j, n + m - i - j))
        for i in range(n + 1) for j in range(m + 1)
    )
    assert sum(p for _, _, p in rows) == 1
    return rows


def expectation(values, rate, n, m):
    return sum(p * values[i, j] for i, j, p in transitions(rate, n, m))


def solve(a, b, reward, nmax=8, mmax=8):
    optimal, priority, event = {(0, 0): Q(0)}, {(0, 0): Q(0)}, {(0, 0): Q(0)}
    actions = {}
    for total in range(1, nmax + mmax + 1):
        for n in range(nmax + 1):
            m = total - n
            if m < 0 or m > mmax:
                continue
            choices = {}
            if n:
                choices[1] = reward + expectation(optimal, a, n - 1, m)
            if m:
                choices[2] = 1 + expectation(optimal, b, n, m - 1)
            optimal[n, m] = max(choices.values())
            actions[n, m] = choices
            if n:
                priority[n, m] = reward + expectation(priority, a, n - 1, m)
                event[n, m] = (a * reward + (a + n - 1) * event[n - 1, m]
                               + (m * event[n, m - 1] if m else 0)) / (a + n + m - 1)
            else:
                priority[n, m] = 1 + expectation(priority, b, n, m - 1)
                event[n, m] = event[n, m - 1] + b / (b + m - 1)
            assert event[n, m] == priority[n, m], (a, b, reward, n, m)
    return optimal, priority, actions


def q_table(a, b, nmax=12, mmax=12):
    q = {(0, m): b / (b + m - 1) for m in range(1, mmax + 1)}
    for n in range(1, nmax + 1):
        for m in range(1, mmax + 1):
            q[n, m] = ((a + n - 1) * q[n - 1, m]
                       + ((m - 1) * q[n, m - 1] if m > 1 else 0)) / (a + n + m - 1)
    return q


def main():
    rates = [Q(1, 5), Q(1, 2), Q(1), Q(2), Q(5)]
    settings, state_checks, residual_checks = [], 0, 0
    for a in rates:
        for b in rates:
            threshold = max(b / a, (b + 1) / (a + 1))
            q = q_table(a, b)
            for (n, m), value in q.items():
                if not n:
                    continue
                h = (a - 1) * (b + m - 1) + n * (b - 1)
                residual = n * a * threshold - b * (a + n - 1) + h * value
                assert residual >= 0, (a, b, n, m, residual)
                assert a * b / ((a + n) * (b + m - 1)) <= value <= a / (a + n)
                residual_checks += 1
            for multiplier in [Q(1), Q(11, 10)]:
                reward = threshold * multiplier
                optimal, priority, _ = solve(a, b, reward)
                assert optimal == priority, (a, b, reward)
                state_checks += len(optimal)
                settings.append({'a': str(a), 'b': str(b), 'w1_over_w2': str(reward),
                                 'states': len(optimal), 'all_priority_optimal': True})
    witnesses = []
    for a, b, reward, label in [
        (Q(1), Q(2), Q(7, 4), 'reward-rate condition only fails'),
        (Q(2), Q(1), Q(3, 5), 'two-job condition only fails'),
    ]:
        optimal, priority, actions = solve(a, b, reward, 16, 3)
        bad = sorted((n + m, n, m) for n, m in optimal if optimal[n, m] > priority[n, m])
        assert bad
        _, n, m = bad[0]
        witnesses.append({'kind': label, 'a': str(a), 'b': str(b), 'w1_over_w2': str(reward),
                          'n': n, 'm': m, 'priority_value': str(priority[n, m]),
                          'optimal_value': str(optimal[n, m]),
                          'gap': str(optimal[n, m] - priority[n, m]),
                          'first_action_values': {str(i): str(v) for i, v in actions[n, m].items()}})
    result = {'arithmetic': 'exact rational', 'formal_verification': False,
              'scope': 'finite diagnostics; analytic manuscript supplies the all-state proof',
              'service_completion_bellman_instances': len(settings),
              'service_completion_state_checks': state_checks,
              'residual_and_bound_checks': residual_checks,
              'settings': settings, 'necessity_witnesses': witnesses, 'passed': True}
    out = Path(__file__).resolve().parents[1] / 'results' / 'exact_diagnostics.json'
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(result, indent=2, ensure_ascii=False) + '\n')
    print(json.dumps({k: v for k, v in result.items() if k != 'settings'}, ensure_ascii=False))


if __name__ == '__main__':
    main()
