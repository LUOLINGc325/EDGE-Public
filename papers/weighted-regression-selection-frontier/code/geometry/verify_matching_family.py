#!/usr/bin/env python3
"""Exact checks for a rank-game obstruction and a coefficient-aware risk bound.

Symbolic identities are combined with a complete analytic cone description in
MATCHING_FAMILY_OBSTRUCTION.md. This script does not assert the original Gamma
conjecture and does not equate the rank-game value with regression risk.
"""

from __future__ import annotations

import hashlib
import json
from pathlib import Path

import sympy as s


HERE = Path(__file__).resolve().parent


def main():
    tau = s.symbols("tau", positive=True)
    e = s.eye(7)
    u = e[:, 0]
    a = [e[:, j] for j in (1, 2, 3)]
    a.append(-u-sum(a, s.zeros(7, 1)))
    b = [e[:, j] for j in (4, 5, 6)]
    b.append(-u-sum(b, s.zeros(7, 1)))
    h = [-2*u-a[j]-b[j] for j in range(4)]
    roots = [tau*u]+a+b+h
    g = s.Matrix.hstack(*roots)
    g_one = g.subs(tau, 1)
    assert g_one.rank() == 7

    supports = [tuple([0]+list(range(1, 5))),
                tuple([0]+list(range(5, 9))),
                tuple([0]+list(range(9, 13)))]+[
        (0, 1+j, 5+j, 9+j) for j in range(4)]
    names = ["A", "B", "H"]+[f"C{j}" for j in range(4)]
    relation_vectors = []
    for j, support in enumerate(supports):
        relation = s.zeros(13, 1)
        relation[0] = (1 if j < 2 else 6 if j == 2 else 2)/tau
        for i in support:
            if i:
                relation[i] = 1
        assert s.simplify(g*relation) == s.zeros(7, 1)
        assert g_one[:, list(support)].rank() == len(support)-1
        relation_vectors.append(relation)

    # The analytic proof establishes these are all extreme rays. Check the
    # claimed generating parametrization by a symbolic nonnegative sum.
    t, q, m = s.symbols("t q m", nonnegative=True)
    delta = s.symbols("delta0:4", nonnegative=True)
    total = t*relation_vectors[0]+q*relation_vectors[1]+m*relation_vectors[2]
    total += sum((delta[j]*relation_vectors[j+3] for j in range(4)), s.zeros(13, 1))
    assert s.simplify(total[0]-(t+q+6*m+2*sum(delta))/tau) == 0
    for j in range(4):
        assert total[1+j] == t+delta[j]
        assert total[5+j] == q+delta[j]
        assert total[9+j] == m+delta[j]
    assert s.simplify(g*total) == s.zeros(7, 1)

    ranks = [g_one[:, list(c)].rank() for c in supports]
    rank_matrix = []
    for i, aa in enumerate(supports):
        rank_matrix.append([g_one[:, sorted(set(aa) | set(cc))].rank()-ranks[i]
                            for cc in supports])
    rank_matrix = s.Matrix(rank_matrix)
    distribution = s.Matrix([s.Rational(1, 3)]*3+[0]*4)
    primal_columns = list((distribution.T*rank_matrix).T)
    dual_rows = list(rank_matrix*distribution)
    assert max(primal_columns) == min(dual_rows) == 2

    large_pair_intersections = [ranks[i]+ranks[j]-g_one[:, sorted(set(supports[i]) | set(supports[j]))].rank()
                                for i, j in ((0, 1), (0, 2), (1, 2))]
    assert large_pair_intersections == [1, 1, 1]

    # Actual quotient relations for every cross anchor and every target.
    coefficient_costs = []
    for i in range(4):
        anchor = supports[i+3]
        annihilator = s.Matrix.hstack(*g_one[:, list(anchor)].T.nullspace())
        assert annihilator.shape == (7, 4)
        projected = annihilator.T*g
        costs = []
        for j, target in enumerate(supports):
            beta = relation_vectors[j]/sum(relation_vectors[j])
            nonzero = [v for v in target if projected[:, v] != s.zeros(4, 1)]
            zero = [v for v in target if v not in nonzero]
            assert all(projected[:, v] == s.zeros(4, 1) for v in zero)
            if i+3 == j:
                assert not nonzero
                costs.append(s.Integer(0))
                continue
            assert len(nonzero) == 3
            assert projected[:, nonzero].rank() == 2
            assert s.simplify(sum((beta[v]*projected[:, v] for v in nonzero), s.zeros(4, 1))) == s.zeros(4, 1)
            assert len({s.simplify(beta[v]) for v in nonzero}) == 1
            costs.append(s.factor(2*sum(beta[v] for v in nonzero)))
        coefficient_costs.append(costs)

    costs_matrix = s.Matrix(coefficient_costs)
    averaged = [s.factor(x) for x in list((s.ones(1, 4)/4)*costs_matrix)]
    bound = 6*tau/(4*tau+1)
    assert s.simplify(averaged[0]-bound) == s.simplify(averaged[1]-bound) == 0
    assert s.simplify(averaged[2]-6*tau/(4*tau+6)) == 0
    assert all(s.simplify(x-9*tau/(2*(3*tau+2))) == 0 for x in averaged[3:])
    assert s.simplify(bound-averaged[2]-15*tau/((2*tau+3)*(4*tau+1))) == 0
    assert s.simplify(bound-averaged[3]-15*tau/(2*(3*tau+2)*(4*tau+1))) == 0
    assert s.simplify(s.Rational(3, 2)-bound-3/(2*(4*tau+1))) == 0

    # A concrete cheap original-data example prevents conflating the rank game
    # with the actual loss. Labels are all one; original evaluation weights stay
    # fixed throughout this check.
    p = s.Matrix([s.Rational(2, 5)]+[s.Rational(1, 20)]*12)
    assert sum(p) == 1 and g_one*p == s.zeros(7, 1)
    evaluation = g_one*s.diag(*p)*g_one.T
    support = tuple([0, 1, 2, 3, 4, 5, 6, 11])
    training = g_one[:, list(support)]
    solution = s.Matrix([0, 0, 0, 0, 1, 1, -1])
    assert training.rank() == 7
    assert training*(training.T*solution-s.ones(len(support), 1)) == s.zeros(7, 1)
    actual_excess = (solution.T*evaluation*solution)[0]
    assert actual_excess == s.Rational(2, 5)

    payload = {
        "scope": "auxiliary rank-game obstruction and an upper bound for one explicit noncoordinate regression family",
        "original_gamma_conjecture": "unresolved",
        "source_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "root_order": ["tau*u"]+[f"a{i}" for i in range(4)]+[f"b{i}" for i in range(4)]+[f"h{i}" for i in range(4)],
        "roots": [[str(x) for x in row] for row in g.T.tolist()],
        "all_positive_circuits": [{"name": name, "support": list(c), "rank": int(rank),
                                   "positive_relation": [str(relation[v]) for v in c]}
                                  for name, c, rank, relation in zip(names, supports, ranks, relation_vectors)],
        "completeness_proof": "MATCHING_FAMILY_OBSTRUCTION.md section 2; no reliance on numerical circuit enumeration",
        "rank_loss_matrix": rank_matrix.tolist(),
        "rank_game_primal_theta": [str(x) for x in distribution],
        "rank_game_dual_omega": [str(x) for x in distribution],
        "rank_game_primal_column_bounds": [str(x) for x in primal_columns],
        "rank_game_dual_row_bounds": [str(x) for x in dual_rows],
        "rank_game_exact_value": "2",
        "gamma_7_1": "12/7",
        "rank_game_gap": "2/7",
        "large_pair_intersection_dimensions": large_pair_intersections,
        "coefficient_cost_rows_cross_anchors": [[str(x) for x in row] for row in costs_matrix.tolist()],
        "uniform_cross_anchor_costs": [str(x) for x in averaged],
        "uniform_risk_excess_upper_bound": str(bound),
        "bound_below_3_over_2": "3/(2*(4*tau+1)) > 0 for tau > 0",
        "bound_is_not_claimed_sharp": True,
        "symmetric_tau_one_witness": {
            "evaluation_weights": [str(x) for x in p], "training_support": list(support),
            "training_weights": "all one before harmless normalization",
            "selected_rank": 7, "selected_output": [str(x) for x in solution],
            "full_optimum_loss": "1", "selected_excess": str(actual_excess),
        },
    }
    target = HERE/"matching_family_certificate.json"
    target.write_text(json.dumps(payload, indent=2, default=int)+"\n", encoding="utf-8")
    print("Exact rank game: 2 > 12/7; true risk bound: 6*tau/(4*tau+1) < 3/2; example excess: 2/5")
    print(target)


if __name__ == "__main__":
    main()
