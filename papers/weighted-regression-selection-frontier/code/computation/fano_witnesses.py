"""Exact feasible selectors for the Fano root family, not lower bounds.

The multi-anchor game obstruction was identified by agent topic_or; that game
is only a sufficient mechanism and its value must not be called dataset risk.
All outputs below are verified by exact weighted normal equations and rank.
"""
import json
from pathlib import Path

import sympy as sp

LINES = [(0, 1, 2), (0, 3, 4), (0, 5, 6), (1, 3, 5),
         (1, 4, 6), (2, 3, 6), (2, 4, 5)]


def model(beta):
    beta = sp.sympify(beta)
    x = sp.eye(7).col_join(sp.Matrix([
        [-beta if j in line else 0 for j in range(7)] for line in LINES]))
    p = 3 * beta / (7 * (3 * beta + 1))
    q = 1 / (7 * (3 * beta + 1))
    probabilities = sp.Matrix([p] * 7 + [q] * 7)
    h = sp.simplify(x.T * sp.diag(*probabilities) * x)
    assert sp.simplify(x.T * probabilities) == sp.zeros(7, 1)
    return x, probabilities, h


def witness(beta, mode):
    """Seven anchor rows on coordinates 0..4 plus two interpolation rows.

    Each anchor gradient cancels exactly at output zero in coordinates 0..4.
    The interpolating rows therefore contribute zero gradient individually.
    """
    x, p, h = model(beta)
    beta = sp.sympify(beta)
    anchor = [0, 1, 2, 3, 4, 7, 8]
    weights = [2 * beta, beta, beta, beta, beta, 1, 1]
    if mode == "positive_positive":
        selected = anchor + [5, 6]
        output = sp.Matrix([0] * 5 + [1, 1])
    elif mode == "mixed":
        selected = anchor + [5, 11]
        output = sp.Matrix([0] * 5 + [1, -1 / beta])
    elif mode == "negative_negative":
        selected = anchor + [10, 11]
        output = sp.Matrix([0] * 5 + [-1 / beta, -1 / beta])
    else:
        raise ValueError(mode)
    weights += [1, 1]
    xs = x[selected, :]
    residual = xs * output - sp.ones(len(selected), 1)
    stationarity = sp.simplify(xs.T * sp.diag(*weights) * residual)
    assert stationarity == sp.zeros(7, 1)
    assert xs.rank() == 7
    excess = sp.factor((output.T * h * output)[0])
    return {"beta": str(beta), "mode": mode, "support": selected,
            "training_weights_unnormalized": list(map(str, weights)),
            "output": list(map(str, output)), "excess": str(excess)}


def main():
    beta = sp.symbols("b", positive=True)
    symbolic = [witness(beta, mode) for mode in
                ["positive_positive", "mixed", "negative_negative"]]
    concrete = [witness(sp.Rational(b), "mixed") for b in ["1/2", "1", "2"]]
    # Pair-positive is <= 1/2 on b <= 1; pair-negative is <= 1/2 on b >= 1.
    first = sp.sympify(symbolic[0]["excess"], locals={"b": beta})
    last = sp.sympify(symbolic[2]["excess"], locals={"b": beta})
    assert sp.simplify(sp.Rational(1, 2) - first + (beta - 1) * (16 * beta + 7) / (14 * (3 * beta + 1))) == 0
    assert sp.simplify(sp.Rational(1, 2) - last - 3 * (beta - 1) * (7 * beta + 4) / (14 * beta * (3 * beta + 1))) == 0
    result = {"family": "Fano roots, common positive scale 1 and negative scale beta>0",
              "evaluation": "p_positive=3 beta/[7(3 beta+1)], p_negative=1/[7(3 beta+1)]",
              "budget": 9, "dimension": 7, "Gamma": "4/5",
              "symbolic_witnesses": symbolic, "concrete_witnesses": concrete,
              "conclusion": "Every beta>0 has an explicitly weighted full-rank selector with excess <=1/2; this family cannot refute Gamma=4/5.",
              "proof": "Use positive_positive for 0<beta<=1 and negative_negative for beta>=1; the two displayed factorizations have nonnegative signs.",
              "half_minus_positive_positive": str(sp.factor(sp.Rational(1, 2) - first)),
              "half_minus_negative_negative": str(sp.factor(sp.Rational(1, 2) - last))}
    path = Path(__file__).with_name("fano_symmetric_witnesses.json")
    path.write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps({"status": "EXACT_FEASIBLE_UPPER_BOUND_VERIFIED", "excess_bound": "1/2",
                      "gamma": "4/5", "symmetric_beta_1_excess": concrete[1]["excess"]}))


if __name__ == "__main__":
    main()
