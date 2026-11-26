#!/usr/bin/env python3
"""Independent finite rational diagnostics for the manuscript's formulas.

Only Python's standard library is used. All equalities and row inequalities below
are exact. The script does not establish any asymptotic or all-graph theorem.
"""
from fractions import Fraction as F
from pathlib import Path
import json


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def geometric(length, ratio):
    return sum((ratio ** j for j in range(length)), F(0))


def triangular(length, ratio):
    return sum(((length - 1 - j) * ratio ** j for j in range(length - 1)), F(0))


def linear_solve(matrix, rhs):
    """Gauss-Jordan elimination over Fraction, independently of the formulas."""
    n = len(rhs)
    a = [list(matrix[i]) + [rhs[i]] for i in range(n)]
    for c in range(n):
        pivot = next((j for j in range(c, n) if a[j][c]), None)
        require(pivot is not None, "Singular absorbing-chain system")
        a[c], a[pivot] = a[pivot], a[c]
        z = a[c][c]
        a[c] = [x / z for x in a[c]]
        for j in range(n):
            if j == c or not a[j][c]:
                continue
            z = a[j][c]
            a[j] = [a[j][k] - z * a[c][k] for k in range(n + 1)]
    return [a[i][-1] for i in range(n)]


def hitting_values(rows, target):
    active = [x for x in range(len(rows)) if x != target]
    matrix = [[F(int(x == y)) - rows[x].get(y, F(0)) for y in active] for x in active]
    values = linear_solve(matrix, [F(1)] * len(active))
    out = [F(0)] * len(rows)
    for x, value in zip(active, values):
        out[x] = value
    return out


def complete_core(n):
    return [set(range(n)) - {x} for x in range(n)]


def prism_core():
    return [{(x // 3) * 3 + (x + 1) % 3, (x // 3) * 3 + (x + 2) % 3, (x + 3) % 6}
            for x in range(6)]


def graph_with_paths(core, short_length, long_length):
    adj = [set(row) for row in core]
    def attach(root, length):
        path = [root]
        for _ in range(length):
            new = len(adj)
            adj.append({path[-1]})
            adj[path[-1]].add(new)
            path.append(new)
        return path
    hairs = [attach(x, short_length) for x in range(len(core))]
    tail = attach(0, long_length) if long_length else [0]
    return adj, hairs, tail


def srw(adj):
    return [{y: F(1, len(adj[x])) for y in adj[x]} for x in range(len(adj))]


def strong_rows(adj, eps, choices):
    return [{y: (1 - eps) / len(adj[x]) + eps * int(y == choices[x]) for y in adj[x]}
            for x in range(len(adj))]


def robust_base_potential(adj, eps, target=0):
    """Finite policy iteration, followed by exact Bellman row verification."""
    policy = [min(row) for row in adj]
    seen = set()
    for iteration in range(1000):
        key = tuple(policy)
        require(key not in seen, "Policy iteration cycle")
        seen.add(key)
        h = hitting_values(strong_rows(adj, eps, policy), target)
        changed = False
        for x, neighbors in enumerate(adj):
            if x == target:
                continue
            best = max(neighbors, key=lambda y: h[y])
            if eps and h[best] > h[policy[x]]:
                policy[x] = best
                changed = True
        if not changed:
            for x, neighbors in enumerate(adj):
                if x == target:
                    continue
                rhs = 1 + (1 - eps) * sum((h[y] for y in neighbors), F(0)) / len(neighbors)
                rhs += eps * max(h[y] for y in neighbors)
                require(h[x] == rhs, "Base Bellman equality failed")
            return h, iteration + 1
    raise RuntimeError("Policy iteration exceeded explicit finite limit")


def path_diagnostics():
    cases = []
    checked_rows = 0
    for length in range(1, 13):
        for eps in [F(0), F(1, 10), F(1, 4), F(1, 2)]:
            ratio = (1 + eps) / (1 - eps)
            rows = []
            for x in range(length + 1):
                if x == 0:
                    rows.append({0: F(1)})
                elif x == length:
                    rows.append({x - 1: F(1)})
                else:
                    rows.append({x - 1: (1 - eps) / 2, x + 1: (1 + eps) / 2})
            w = hitting_values(rows, 0)
            formula = ratio ** (length - 1) + 2 * geometric(length - 1, ratio) / (1 - eps)
            require(w[1] == formula, "Return formula disagrees with linear solve")
            require(formula <= 5 * geometric(length, ratio), "Return geometric upper bound failed")
            require(max(w) <= length * formula, "Arbitrary-start path bound failed")
            if eps:
                require(formula == ((1 - eps) * ratio ** length - 1) / eps, "Closed return form failed")
            else:
                require(w == [F(x * (2 * length - x)) for x in range(length + 1)], "Zero-bias quadratic failed")
            success = [geometric(x, ratio) / geometric(length, ratio) for x in range(length + 1)]
            for x in range(1, length):
                for bias_to_right in [F(0), F(1, 3), F(1)]:
                    right = (1 - eps) / 2 + eps * bias_to_right
                    require((1 - right) * success[x - 1] + right * success[x + 1] >= success[x],
                            "Endpoint submartingale failed")
                    require(1 + (1 - right) * w[x - 1] + right * w[x + 1] <= w[x],
                            "Return supersolution failed")
                    checked_rows += 2
            cases.append({'length': length, 'epsilon': str(eps), 'return_from_one': str(w[1]),
                          'success_lower_bound': str(success[1])})
    return cases, checked_rows


def graph_diagnostics():
    endpoint_cases, certificate_cases, pair_cases = [], [], []
    for name, core in [('K4', complete_core(4)), ('triangular_prism', prism_core())]:
        n = len(core)
        degree = len(core[0])
        require(all(len(row) == degree for row in core), "Core is not regular")
        for short in [1, 2]:
            base, _, _ = graph_with_paths(core, short, 0)
            m0 = sum(map(len, base)) // 2
            for eps in [F(0), F(1, 5)]:
                g, iterations = robust_base_potential(base, eps)
                for long in [short, 2 * short + 1]:
                    adj, hairs, tail = graph_with_paths(core, short, long)
                    rows = srw(adj)
                    for j in range(1, long):
                        rows[tail[j]] = {tail[j - 1]: (1 + eps) / 2, tail[j + 1]: (1 - eps) / 2}
                    for x, row in enumerate(rows):
                        require(sum(row.values()) == 1, "Nonstochastic lower policy")
                        require(all((1 - eps) / len(adj[x]) <= q <= (1 + eps) / len(adj[x])
                                    for q in row.values()), "Lower policy is not standard-admissible")
                    ratio = (1 + eps) / (1 - eps)
                    exact = hitting_values(rows, tail[-1])
                    expected = (2 * m0 + 1) * geometric(long, ratio)
                    expected += 2 * triangular(long, ratio) / (1 - eps)
                    require(exact[0] == expected, "Endpoint formula disagrees with independent solve")
                    endpoint_cases.append({'core': name, 'K': short, 'L': long, 'epsilon': str(eps),
                                           'root_hitting_time': str(exact[0])})
                    delta = [F(0), (1 + max(g)) * (degree + 2) / (1 - eps)]
                    for j in range(1, long):
                        delta.append(ratio * delta[j] + 2 / (1 - eps))
                    a0 = sum(delta)
                    h = [a0 + value for value in g] + [F(0)] * long
                    for j in range(1, long + 1):
                        h[tail[j]] = a0 - sum(delta[1:j + 1])
                    require(h[tail[-1]] == 0 and min(h) >= 0, "Certificate boundary failed")
                    residuals = []
                    for x, neighbors in enumerate(adj):
                        if x == tail[-1]:
                            continue
                        rhs = 1 + (1 - eps) * sum((h[y] for y in neighbors), F(0)) / len(neighbors)
                        rhs += eps * max(h[y] for y in neighbors)
                        residuals.append(h[x] - rhs)
                    require(min(residuals) >= 0, "Strong Bellman certificate failed")
                    certificate_cases.append({'core': name, 'K': short, 'L': long, 'epsilon': str(eps),
                                               'base_policy_iterations': iterations,
                                               'rows': len(residuals), 'minimum_residual': str(min(residuals)),
                                               'root_certificate': str(a0)})
                    if not eps:
                        ordinary = srw(adj)
                        m = sum(map(len, adj)) // 2
                        to_tip = hitting_values(ordinary, hairs[1][-1])
                        to_root = hitting_values(ordinary, 1)
                        require(to_tip[hairs[0][-1]] == 2 * m * short + to_root[0],
                                "Short-tip identity failed")
                        pair_cases.append({'core': name, 'K': short, 'L': long,
                                           'tip_pair_hitting': str(to_tip[hairs[0][-1]])})
    return endpoint_cases, certificate_cases, pair_cases


def main():
    paths, rows = path_diagnostics()
    endpoints, certificates, pairs = graph_diagnostics()
    report = {'status': 'passed', 'arithmetic': 'exact fractions, Python standard library',
              'coverage': 'Finite path identities, admissible fixed policies, exact linear systems and strong Bellman rows only',
              'not_verified': ['Universal adaptive trace proof', 'All graph sizes', 'Asymptotic orders', 'Lean kernel'],
              'path_cases': paths, 'path_row_inequalities': rows,
              'endpoint_cases': endpoints, 'strong_certificate_cases': certificates, 'short_tip_pairs': pairs}
    dest = Path(__file__).resolve().parents[1] / 'results' / 'EXACT_DIAGNOSTICS.json'
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({'status': report['status'], 'path_cases': len(paths), 'path_row_inequalities': rows,
                      'endpoint_cases': len(endpoints), 'strong_certificates': len(certificates),
                      'certificate_rows': sum(x['rows'] for x in certificates), 'short_tip_pairs': len(pairs)}))


if __name__ == '__main__':
    main()
