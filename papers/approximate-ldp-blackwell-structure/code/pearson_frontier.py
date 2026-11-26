"""Exact constructions for manuscript Theorems 5--7, using rational arithmetic.

This executable evaluates the proved formula and constructs its achievers.
It is not a replacement for the arbitrary-parameter upper-bound proof.
The symmetric construction supports the statistical risk formula. A cyclic
construction attains Pearson information but need not identify all inputs.
"""
from fractions import Fraction as F
from itertools import combinations
import argparse
import json


def frontier(k, E, delta):
    E, delta = F(E), F(delta)
    if k < 2 or E < 1 or not 0 <= delta <= 1:
        raise ValueError("Require k >= 2, E >= 1, and 0 <= delta <= 1")
    values = {d: F(d * (k-d)) * (E-1)**2 / (k+d*(E-1))**2
              for d in range(1, k)}
    C = max(values.values())
    return C, (1-delta)*C+delta*(k-1), [d for d, v in values.items() if v == C]


def mechanism(k, E, delta, mode="symmetric"):
    E, delta = F(E), F(delta)
    C, A, choices = frontier(k, E, delta)
    d = choices[0]
    if mode == "symmetric":
        blocks = [set(s) for s in combinations(range(k), d)]
    elif mode == "cyclic":
        blocks = [{(i+t) % k for i in range(d)} for t in range(k)]
    else:
        raise ValueError("mode must be symmetric or cyclic")
    L = k+d*(E-1)
    coeff = F(k, len(blocks)) / L
    columns = [[(1-delta)*coeff*(E if i in B else 1) for i in range(k)]
               for B in blocks]
    columns += [[delta if i == j else F(0) for i in range(k)] for j in range(k)]
    return [v for v in columns if sum(v)], C, A, choices


def inspect(columns, E):
    k = len(columns[0])
    E = F(E)
    row_sums = [sum(v[i] for v in columns) for i in range(k)]
    losses = [[sum(max(v[i]-E*v[j], F(0)) for v in columns)
               for j in range(k)] for i in range(k)]
    information = sum(sum(x*x for x in v)/sum(v) for v in columns)-1
    M = [[sum(v[i]*v[j]/sum(v) for v in columns) for j in range(k)]
         for i in range(k)]
    lam = information / (k-1)
    expected = [[F(1, k)+lam*((1 if i == j else 0)-F(1, k))
                 for j in range(k)] for i in range(k)]
    return {"row_sums": row_sums, "directed_losses": losses,
            "pearson_information": information,
            "uniform_tangent_isotropic": M == expected}


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--k", type=int, default=3)
    p.add_argument("--E", default="2", help="Exact likelihood multiplier, e.g. 3/2")
    p.add_argument("--delta", default="1/7", help="Exact common additive budget")
    p.add_argument("--n", type=int, default=100)
    p.add_argument("--mode", choices=["symmetric", "cyclic"], default="symmetric")
    a = p.parse_args()
    if a.n < 1:
        p.error("n must be positive")
    columns, C, A, ds = mechanism(a.k, a.E, a.delta, a.mode)
    measured = inspect(columns, a.E)
    assert measured["row_sums"] == [F(1)]*a.k
    assert measured["pearson_information"] == A
    assert all(measured["directed_losses"][i][j] == F(a.delta)
               for i in range(a.k) for j in range(a.k) if i != j)
    result = {"k": a.k, "E": F(a.E), "delta": F(a.delta), "n": a.n,
              "construction": a.mode, "optimal_high_coordinate_counts": ds,
              "pure_optimum": C, "approximate_optimum": A,
              "output_count": len(columns), "columns": columns,
              "direct_checks": measured,
              "general_upper_bound_evidence": "manuscript Theorem 5 and Appendix C",
              "statistical_scope": "Theorem 6: unbiased finite n; Theorem 7: arbitrary-estimator asymptotics",
              "risk_scope": {
                  "unrestricted_asymptotic_minimax_constant":
                      "Class optimum over all feasible finite channels and arbitrary estimators; "
                      "this is not a guarantee for the selected cyclic channel, which may be nonidentifying.",
                  "unbiased_worst_case_risk":
                      "Exact finite-n risk of the affine globally unbiased R^k-valued estimator "
                      "for the selected construction; reported only when its uniform tangent information is isotropic. "
                      "This is not the finite-n minimax risk over arbitrary biased estimators.",
                  "no_information_minimax_risk":
                      "Exact unrestricted finite-n class minimax risk when E=1 and delta=0."
              }}
    if A:
        result["unrestricted_asymptotic_minimax_constant"] = F((a.k-1)**2, a.k)/A
        if measured["uniform_tangent_isotropic"]:
            result["unbiased_worst_case_risk"] = F((a.k-1)**2, a.k*a.n)/A
    else:
        result["no_information_minimax_risk"] = F(a.k-1, a.k)
    print(json.dumps(result, default=str, indent=2))


if __name__ == "__main__":
    main()
