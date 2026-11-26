"""Symbolic certificate for the fixed-G four-parameter matching family.

All twelve displayed selections use positive weights and exactly eight rows;
each has an explicit nonzero 7x7 feature minor and zero normal-equation vector.
The final inequality uses the four recorded elementary sign cases, not a
numerical minimizer or a general-purpose inequality oracle.
"""
import json
from pathlib import Path

import sympy as sp


def main():
    folder = Path(__file__).parent
    source = json.loads((folder.parent / "geometry/matching_tetrahedra_d7.json").read_text())
    roots = sp.Matrix(source["roots"])
    cu, ca, cb, ch = sp.symbols("c_u c_a c_b c_h", positive=True)
    variables = {"c_u": cu, "c_a": ca, "c_b": cb, "c_h": ch}
    masses = sp.Matrix([cu] + [ca] * 4 + [cb] * 4 + [ch] * 4)
    scales = sp.Matrix([8] + [1] * 12)
    x = sp.diag(*[scales[i] / masses[i] for i in range(13)]) * roots
    total = cu + 4 * (ca + cb + ch)
    assert sum(masses) == total
    assert x.T * masses == sp.zeros(7, 1)
    full_h = x.T * sp.diag(*[v / total for v in masses]) * x
    initial_basis = [0, 1, 2, 3, 5, 6, 7]
    initial_minor = sp.factor(x[initial_basis, :].det())
    assert initial_minor == 8 / (cu * ca ** 3 * cb ** 3)
    selections = []
    for name, anchor, anchor_basis, positive_group, negative_group, a, b, anchor_weights in [
        ("A", [0, 1, 2, 3, 4], [0, 1, 2, 3], [5, 6, 7], [9, 10, 11],
         cb, ch, [cu / 8] + [ca] * 4),
        ("B", [0, 5, 6, 7, 8], [0, 5, 6, 7], [1, 2, 3], [9, 10, 11],
         ca, ch, [cu / 8] + [cb] * 4),
        ("H", [0, 9, 10, 11, 12], [0, 9, 10, 11], [1, 2, 3], [5, 6, 7],
         ca, cb, [3 * cu / 4] + [ch] * 4),
    ]:
        for m in range(4):
            interpolated = positive_group[:m] + negative_group[m:]
            independent = anchor_basis + interpolated
            matrix = x[independent, :]
            determinant = sp.factor(matrix.det())
            assert determinant != 0
            # A single nonzero monomial in positive parameters cannot vanish.
            numerator, denominator = sp.fraction(determinant)
            assert len(sp.Poly(numerator, cu, ca, cb, ch).terms()) == 1
            assert len(sp.Poly(denominator, cu, ca, cb, ch).terms()) == 1
            rhs = sp.Matrix([0] * 4 + [1] * 3)
            output = sp.simplify(matrix.inv() * rhs)
            support = anchor + interpolated
            weights = sp.Matrix(anchor_weights + [1] * 3)
            assert len(set(support)) == len(support) == 8
            assert all(sp.ask(sp.Q.positive(v)) is True for v in weights)
            selected = x[support, :]
            residuals = sp.simplify(selected * output - sp.ones(8, 1))
            assert residuals == sp.Matrix([-1] * 5 + [0] * 3)
            normal_equations = sp.simplify(selected.T * sp.diag(*weights) * residuals)
            assert normal_equations == sp.zeros(7, 1)
            q = m * a ** 2 + (3 - m) * b ** 2 + (m * a - (3 - m) * b) ** 2
            claimed = (1 / a + 1 / b) * q / total
            actual = sp.factor((output.T * full_h * output)[0])
            assert sp.simplify(actual - claimed) == 0
            selections.append({"anchor": name, "m": m, "support": support,
                               "training_weights_unnormalized": list(map(str, weights)),
                               "output": list(map(str, output)),
                               "independent_selected_rows": independent,
                               "nonzero_minor": str(determinant),
                               "selected_residuals": list(map(str, residuals)),
                               "normal_equations": list(map(str, normal_equations)),
                               "pair_parameters": [str(a), str(b)],
                               "Q_m": str(sp.expand(q)), "exact_excess": str(actual),
                               "claimed_excess_formula_verified": True})
    a, b = sp.symbols("x y", positive=True)
    cases = []
    for m, region, factor in [
        (3, "0 < x <= y/3", 4 * a * (3 * a - b)),
        (2, "y/3 <= x <= y", 2 * (3 * a - b) * (a - b)),
        (1, "y <= x <= 3*y", 2 * (a - b) * (a - 3 * b)),
        (0, "3*y <= x", 4 * b * (3 * b - a)),
    ]:
        q = m * a ** 2 + (3 - m) * b ** 2 + (m * a - (3 - m) * b) ** 2
        assert sp.expand(q - 4 * a * b - factor) == 0
        cases.append({"m": m, "positive_parameter_region": region,
                      "Q_m_minus_4xy_factored": str(factor),
                      "sign_on_region": "nonpositive"})
    group_sum = ca + cb + ch
    bound = 8 * group_sum / (3 * total)
    slack = sp.factor(sp.Rational(2, 3) - bound)
    assert sp.simplify(slack - 2 * cu / (3 * total)) == 0
    assert sp.ask(sp.Q.positive(slack)) is True
    assert sp.Rational(2, 3) < sp.Rational(12, 7)
    canonical = next(s for s in selections if s["anchor"] == "A" and s["m"] == 1)
    canonical_cost = sp.sympify(canonical["exact_excess"], locals=variables).subs(
        {cu: 8, ca: 1, cb: 1, ch: 1})
    assert canonical_cost == sp.Rational(2, 5)
    result = {"schema": "matching-four-parameter-symbolic-v1",
              "assumptions": "c_u,c_a,c_b,c_h strictly positive",
              "fixed_gradient_scales": [8] + [1] * 12,
              "root_matrix_rows": source["roots"],
              "evaluation_masses": list(map(str, masses)), "total_mass": str(total),
              "features": "x_i = fixed_gradient_scale_i * root_i / evaluation_mass_i",
              "labels": "all equal one",
              "full_mean_zero_verified": True,
              "full_rank_minor_rows": initial_basis, "full_rank_minor": str(initial_minor),
              "selections": selections, "scalar_sign_cases": cases,
              "pair_cost_bound": "J(x,y) <= 4*(x+y)",
              "averaging_identity": "(c_a+c_b)+(c_a+c_h)+(c_b+c_h)=2*(c_a+c_b+c_h)",
              "actual_feasible_excess_upper_bound": str(bound),
              "two_thirds_minus_bound": str(slack),
              "conclusion": "Every member of this fixed-G four-parameter family admits a positive-weight full-rank 8-row fit with excess <2/3<12/7.",
              "scope_exclusions": "No assertion for arbitrary individual row scaling, arbitrary positive kernel vector, or the general Gamma frontier.",
              "canonical_excess": str(canonical_cost)}
    (folder / "matching_four_parameter_symbolic.json").write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps({"status": "SYMBOLIC_NORMAL_EQUATIONS_AND_MINOR_CERTIFICATES_VERIFIED",
                      "selections": len(selections), "scalar_cases": len(cases),
                      "strict_upper_bound": "2/3", "Gamma": "12/7",
                      "canonical_excess": str(canonical_cost)}))


if __name__ == "__main__":
    main()
