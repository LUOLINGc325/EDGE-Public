#!/usr/bin/env python3
"""Exact finite certificates for the batch-demand structure research note.

All arithmetic is fractions.Fraction. The general theorems are proved in
manuscript/paper.en.md (Section 9); this program verifies specified instances and the exact
finite reduction used to interpret them. No floating-point optimization,
probability truncation, or proof-assistant validation is claimed.
"""

from fractions import Fraction as F
from pathlib import Path
import json


def linear_solve(matrix, rhs):
    n = len(rhs)
    a = [list(row) + [v] for row, v in zip(matrix, rhs)]
    for col in range(n):
        pivot = next((row for row in range(col, n) if a[row][col]), None)
        if pivot is None:
            raise AssertionError("singular policy equation")
        a[col], a[pivot] = a[pivot], a[col]
        scale = a[col][col]
        a[col] = [v / scale for v in a[col]]
        for row in range(n):
            if row == col or not a[row][col]:
                continue
            scale = a[row][col]
            a[row] = [v - scale * w for v, w in zip(a[row], a[col])]
    return [row[-1] for row in a]


def fee(x, y, r, K, k):
    return F(0) if y <= x else (k if y <= x + r else K)


def solve_core(*, lam, mu, alpha, h, b, K, k, demand, capacities):
    assert lam > 0 and mu >= 0 and alpha > 0 and h > 0 and b > 0
    assert F(0) <= k <= K
    assert sum(prob for _, prob in demand) == 1
    assert sum(prob for _, prob in capacities) == 1
    assert all(d > 0 and prob > 0 for d, prob in demand)
    assert all(r > 0 and prob > 0 for r, prob in capacities)
    Q = lam + mu + alpha
    L = -int(((Q + lam) * K) // b)
    U = int((lam * K) // h)
    J = list(range(L, U + 1))
    n = len(J)
    running = [h * max(i, 0) + b * max(-i, 0) for i in J]
    events = [[(lam * prob, i - d, 0) for d, prob in demand]
              + [(mu * prob, i, r) for r, prob in capacities if mu * prob]
              for i in J]

    def greedy(z):
        return tuple(tuple(min(range(n), key=lambda t: fee(x, J[t], r, K, k) + z[t])
                           for _, x, r in evs) for evs in events)

    z = [F(0)] * n
    previous_policies = set()
    for iteration in range(1, 1001):
        policy = greedy(z)
        if policy in previous_policies:
            raise AssertionError("policy cycle before exact convergence")
        previous_policies.add(policy)
        mat = [[Q if i == j else F(0) for j in range(n)] for i in range(n)]
        rhs = list(running)
        for i, evs in enumerate(events):
            for target, (rate, x, r) in zip(policy[i], evs):
                mat[i][target] -= rate
                rhs[i] += rate * fee(x, J[target], r, K, k)
        z = linear_solve(mat, rhs)
        if greedy(z) == policy:
            break
    else:
        raise AssertionError("policy iteration bound exceeded")

    for i, evs in enumerate(events):
        exact_rhs = running[i]
        for rate, x, r in evs:
            exact_rhs += rate * min(fee(x, j, r, K, k) + z[t]
                                   for t, j in enumerate(J))
        assert Q * z[i] == exact_rhs
    g = min(z)
    S = next(j for j, v in zip(J, z) if v == g)
    return J, z, S, iteration


def counterexample(p):
    assert F(0) <= p < F(1, 2)
    s = 1 + 2 * p
    delta = (1 - 2 * p) / s
    K = (5 - 2 * p) / s
    mu = delta / (100 * K)
    demand = [(d, prob) for d, prob in [(1, p), (2, 1 - p)] if prob]
    J, z, S, iterations = solve_core(
        lam=F(1), mu=mu, alpha=F(1), h=F(1), b=F(100),
        K=K, k=F(1), demand=demand, capacities=[(2, F(1))])
    assert J[0] == 0 and S == 2
    assert all(value > z[J.index(2)] for j, value in zip(J, z) if j != 2)
    costs = [fee(-1, j, 2, K, F(1)) + value for j, value in zip(J, z)]
    target = J[min(range(len(J)), key=lambda t: costs[t])]
    assert target == 0 and costs.count(min(costs)) == 1
    gap = costs[J.index(1)] - costs[J.index(0)]
    assert gap >= F(23, 50) * delta
    u = 4 / s
    g0 = (3 + 2 * p) / s
    def base(j):
        if j == 0: return u
        if j == 1: return (9 - 2 * p) / (2 * s)
        if j == 2: return g0
        if j == 3: return (7 + 5 * p + 2 * p * p) / (2 * s)
        return (j + g0) / 2
    error = max(abs(value - base(j)) for j, value in zip(J, z))
    assert error <= 2 * mu * K
    return {
        "p": str(p), "mu": str(mu), "K": str(K), "delta": str(delta),
        "core": J, "S": S, "initial_state": [-1, 2],
        "unique_optimal_target": target, "full_capacity_target": 1,
        "full_capacity_loss": str(gap),
        "proved_loss_lower_bound": str(F(23, 50) * delta),
        "core_perturbation": str(error), "proved_perturbation_bound": str(2 * mu * K),
        "exact_bellman_residual": "0", "iterations": iterations,
        "values": {str(j): str(value) for j, value in zip(J, z)},
    }


def positive_example(name, demand, capacities, *, underlying_infinite_mean=False):
    K, k = F(15), F(1)
    J, z, S, iterations = solve_core(
        lam=F(1), mu=F(1, 10), alpha=F(1), h=F(1), b=F(100),
        K=K, k=k, demand=demand, capacities=capacities)
    assert J == list(range(16))
    assert all(z[i + 1] < z[i] for i in range(S))
    tail_differences = [z[i + 1] - z[i] for i in range(S, len(J) - 1)]
    assert all(x >= 0 for x in tail_differences)
    assert all(x <= y for x, y in zip(tail_differences, tail_differences[1:]))
    canonical_checks = 0
    for r in range(1, len(J) + 1):
        for x in range(-r, S - r):
            # The offered endpoint is nonnegative here; all offered targets
            # below it are either in the core or excluded by the core theorem.
            if x + r < J[0]:
                continue
            candidates = [j for j in J if x < j <= x + r]
            values = [k + z[J.index(j)] for j in candidates]
            assert candidates[values.index(min(values))] == x + r
            assert values.count(min(values)) == 1
            canonical_checks += 1
    return {
        "name": name, "underlying_infinite_mean": underlying_infinite_mean,
        "demand_classes": [[d, str(p)] for d, p in demand],
        "capacity_classes": [[r, str(p)] for r, p in capacities],
        "core": J, "S": S, "strict_pre_target_descent": True,
        "nondecreasing_convex_right_tail_on_core": True,
        "discounted_window_checks": canonical_checks,
        "exact_bellman_residual": "0", "iterations": iterations,
        "values": {str(j): str(value) for j, value in zip(J, z)},
    }


def main():
    counterexamples = [counterexample(p) for p in
                       [F(0), F(1, 10), F(1, 4), F(1, 3), F(49, 100), F(499, 1000)]]
    positive = []
    for p in [F(1, 2), F(3, 5), F(9, 10)]:
        positive.append(positive_example("two-size p=" + str(p), [(1, p), (2, 1 - p)], [(3, F(1))]))
    positive.append(positive_example("uniform on 1..4", [(d, F(1, 4)) for d in range(1, 5)],
                                     [(1, F(1, 4)), (3, F(3, 4))]))
    # For J=0..15, D>=16 is a single exact fee class and R>=15
    # is a single exact capacity class. Every tail mass is retained.
    geometric_d = [(d, F(1, 2**d)) for d in range(1, 16)] + [(16, F(1, 2**15))]
    geometric_r = [(r, F(1, 2**r)) for r in range(1, 15)] + [(15, F(1, 2**14))]
    positive.append(positive_example("geometric demand and geometric capacity, exact tails",
                                     geometric_d, geometric_r))
    heavy_d = [(d, F(1, d * (d + 1))) for d in range(1, 16)] + [(16, F(1, 16))]
    positive.append(positive_example("p_d=1/[d(d+1)], exact infinite-mean tail",
                                     heavy_d, [(3, F(1))], underlying_infinite_mean=True))
    result = {
        "schema": "batch-structure-exact-certificates-v1",
        "arithmetic": "Python fractions.Fraction only",
        "status": "pass",
        "counterexample_count": len(counterexamples),
        "positive_example_count": len(positive),
        "proof_boundary": "Finite arithmetic instances only; general distributional and parametric assertions have written proofs in manuscript/paper.en.md (Section 9).",
        "counterexamples": counterexamples,
        "positive_examples": positive,
    }
    output = Path(__file__).resolve().parents[1] / "results/batch_structure_exact.json"
    output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({k: result[k] for k in ["status", "arithmetic", "counterexample_count", "positive_example_count"]}))
    print(str(output))


if __name__ == "__main__":
    main()
