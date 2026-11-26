#!/usr/bin/env python3
"""Exact finite checks for route A and the IID random-measure-block theorem.

These checks do not prove the unresolved general Markov minimax upper bound.
Only Python's standard library is needed. All mathematical checks use Fraction.
"""

from __future__ import annotations

import json
from fractions import Fraction as F
from itertools import product
from pathlib import Path


def mass(mu, labels):
    return sum((mu[x] for x in labels), F(0))


def path_data(path, pi, tau):
    n = len(path)
    alphabet = set(range(len(pi)))
    windows = [set(range(max(0, i - tau + 1), min(n, i + tau))) for i in range(n)]
    supports = [{path[k] for k in window} for window in windows]
    outside = [set(range(n)) - window for window in windows]
    q = [mass(pi, alphabet - {path[k] for k in h}) for h in outside]
    z = [F(path[i] not in {path[k] for k in outside[i]}) - q[i] for i in range(n)]
    missing = mass(pi, alphabet - set(path))
    bias = sum((qi - missing for qi in q), F(0)) / n
    assert 0 <= bias <= F(2 * tau - 1, n)
    far_u_sum = F(0)
    near_u_sum = F(0)
    mutual_unequal = 0
    for i in range(n):
        for j in range(n):
            if i == j:
                continue
            unseen = alphabet - {path[k] for k in outside[i] & outside[j]}
            h = mass(pi, unseen)
            vi, vj = F(path[i] in unseen), F(path[j] in unseen)
            if abs(i - j) >= 2 * tau:
                ui = mass(pi, unseen & supports[i])
                uj = mass(pi, unseen & supports[j])
                oij = F(path[i] in unseen & supports[j])
                oji = F(path[j] in unseen & supports[i])
                assert z[i] == vi - h + uj - oij
                assert z[j] == vj - h + ui - oji
                far_u_sum += ui * uj
                mutual_unequal += int(oij * oji) * (path[i] != path[j])
            else:
                left_only = {path[k] for k in windows[i] - windows[j]}
                right_only = {path[k] for k in windows[j] - windows[i]}
                ul, ur = mass(pi, unseen & left_only), mass(pi, unseen & right_only)
                ci = F(path[i] in unseen & right_only)
                cj = F(path[j] in unseen & left_only)
                assert z[i] == vi - h + ur - ci
                assert z[j] == vj - h + ul - cj
                near_u_sum += ul + ur
    assert far_u_sum <= 8 * tau * tau
    assert near_u_sum <= 32 * tau * tau
    return z, mutual_unequal


def binary_residual_checks():
    out = []
    for n in range(3, 9):
        mean0, cross01 = F(0), F(0)
        for path in product(range(2), repeat=n):
            z, _ = path_data(path, (F(1, 2), F(1, 2)), 1)
            mean0 += z[0] / (2**n)
            cross01 += z[0] * z[1] / (2**n)
        assert mean0 == 0
        assert cross01 == F(1, 2 ** (n + 1))
        out.append({"n": n, "mean_z0": str(mean0), "cross_z0_z1": str(cross01)})
    for path in product(range(2), repeat=6):
        path_data(path, (F(2, 5), F(3, 5)), 2)
    return out


def double_permutation_checks():
    out = []
    for m, tau in [(8, 2), (12, 3), (40, 3)]:
        path = tuple(range(m)) * 2
        _, count = path_data(path, (F(1, m),) * m, tau)
        expected = 4 * m * (tau - 1) - 2 * tau * (tau - 1)
        assert count == expected
        out.append({"n": 2 * m, "tau": tau, "unequal_mutual_count": count})
    return out


def iid_block_check(name, law, n):
    k = len(law[0][1])
    alphabet = set(range(k))
    assert sum((p for p, _ in law), F(0)) == 1
    for _, mu in law:
        assert sum(mu, F(0)) == 1 and min(mu) >= 0
    pi = tuple(sum((p * mu[x] for p, mu in law), F(0)) for x in range(k))
    presence = tuple(sum((p for p, mu in law if mu[x] > 0), F(0)) for x in range(k))
    a = [[sum((p * mu[x] for p, mu in law if mu[y] > 0), F(0))
          for y in range(k)] for x in range(k)]
    c = [[pi[x] * presence[y] - a[x][y] for y in range(k)] for x in range(k)]
    qpair = [[sum((p for p, mu in law if mu[x] == 0 and mu[y] == 0), F(0))
              for y in range(k)] for x in range(k)]
    for y in range(k):
        assert sum((a[x][y] for x in range(k)), F(0)) == presence[y]
    theoretical_cross = sum((c[x][y] * c[y][x] * qpair[x][y] ** (n - 2)
                             for x in range(k) for y in range(k)), F(0))
    risk, cross, weighted_risk = F(0), F(0), F(0)
    weights = tuple(F(i + 1, n * (n + 1) // 2) for i in range(n))
    s2 = sum((w * w for w in weights), F(0))
    for choices in product(range(len(law)), repeat=n):
        prob = F(1)
        mus = []
        for choice in choices:
            p, mu = law[choice]
            prob *= p
            mus.append(mu)
        supports = [{x for x in alphabet if mu[x] > 0} for mu in mus]
        missing = mass(pi, alphabet - set.union(*supports))
        scores, z, biases = [], [], []
        for i in range(n):
            other_seen = set().union(*(supports[j] for j in range(n) if j != i))
            unseen = alphabet - other_seen
            score, qi = mass(mus[i], unseen), mass(pi, unseen)
            scores.append(score)
            z.append(score - qi)
            biases.append(qi - missing)
        bias = sum(biases, F(0)) / n
        assert 0 <= bias <= F(1, n)
        estimate = sum(scores, F(0)) / n
        estimate_w = sum((w * s for w, s in zip(weights, scores)), F(0))
        risk += prob * (estimate - missing) ** 2
        weighted_risk += prob * (estimate_w - missing) ** 2
        cross += prob * z[0] * z[1]
    assert cross == theoretical_cross
    assert cross <= F(4, n*n) + F(1, n-1)
    assert risk <= min(F(1), F(9, n))
    assert weighted_risk <= min(F(1), 12 * s2)
    return {"law": name, "blocks": n, "exact_cross": str(cross),
            "exact_risk": str(risk), "exact_weighted_risk": str(weighted_risk),
            "sum_weights_squared": str(s2), "factorization_exact": True}


def block_checks():
    laws = {
        "singleton_binary": [(F(1, 2), (F(1), F(0))),
                             (F(1, 2), (F(0), F(1)))],
        "overlapping_measures": [(F(1, 4), (F(1, 2), F(1, 2), F(0))),
                                  (F(1, 4), (F(0), F(1, 2), F(1, 2))),
                                  (F(1, 2), (F(1), F(0), F(0)))],
        "universal_and_singletons": [(F(1, 4), (F(1, 3),) * 3),
                                     (F(1, 4), (F(1), F(0), F(0))),
                                     (F(1, 4), (F(0), F(1), F(0))),
                                     (F(1, 4), (F(0), F(0), F(1)))],
        "degenerate_full_support": [(F(1), (F(2, 3), F(1, 3)))],
    }
    return [iid_block_check(name, law, n) for name, law in laws.items()
            for n in range(2, 6)]


def tv(a, b):
    return sum((abs(x-y) for x, y in zip(a, b)), F(0)) / 2


def debruijn_block_check():
    states = list(product(range(2), repeat=2))
    p = [[F(1, 2) if y[0] == x[1] else F(0) for y in states] for x in states]
    p2 = [[sum((p[i][s] * p[s][j] for s in range(4)), F(0))
           for j in range(4)] for i in range(4)]
    uniform = [F(1, 4)] * 4
    assert all(row == uniform for row in p2)
    d1 = max(tv(row, uniform) for row in p)
    assert d1 == F(1, 2)
    # Law of the entire next two-state block, conditional on current endpoint.
    block_rows = [[p[i][j] * p[j][k] for j in range(4) for k in range(4)]
                  for i in range(4)]
    delta_block = max(tv(a, b) for a in block_rows for b in block_rows)
    assert delta_block == 1
    return {"state_mixing_time_quarter": 2, "d_one_step": str(d1),
            "d_two_steps": "0", "whole_block_dobrushin": str(delta_block)}


def variance_counterexample_bound():
    out = []
    for n in [2, 5, 10, 50, 100]:
        k = n**3
        p0 = (1-F(1, n)) ** n
        bound = p0 * (1-p0) * (1-F(n, k)) ** 2
        out.append({"blocks": n, "alphabet": k,
                    "variance_lower_bound": str(bound),
                    "variance_lower_bound_decimal": float(bound)})
    return out


def fixed_block_retention_checks():
    out = []
    alpha = F(1, 2)
    for b in [1, 2, 3, 4, 8]:
        direct = sum(((1-alpha**(a+1)) * (1-alpha**(b-a))
                      for a in range(b)), F(0)) / b
        closed = 1-2*alpha*(1-alpha**b)/(b*(1-alpha))+alpha**(b+1)
        assert direct == closed
        if b == 2:
            assert direct == F(3, 8)
            assert (1-direct)**2 == F(25, 64)
        out.append({"block_length": b, "retained_mean": str(direct),
                    "asymptotic_risk_lower_bound": str((1-direct)**2)})
    return out


def main():
    report = {
        "scope": "Exact finite identities and counterexamples; no general Markov upper bound certified",
        "arithmetic": "fractions.Fraction",
        "binary_iid_residuals": binary_residual_checks(),
        "double_permutation": double_permutation_checks(),
        "iid_random_measure_blocks": block_checks(),
        "whole_block_contraction_counterexample": debruijn_block_check(),
        "target_variance_counterexample": variance_counterexample_bound(),
        "fixed_markov_block_loo_counterexample": fixed_block_retention_checks(),
        "all_assertions_passed": True,
    }
    destination = Path(__file__).resolve().parents[1] / "results" / "upper_bound_round1_checks.json"
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"report": str(destination), "iid_block_configurations": 16,
                      "all_assertions_passed": True}, ensure_ascii=False))


if __name__ == "__main__":
    main()
