#!/usr/bin/env python3
"""Independent finite verification for the row/column convex scenario example.

Run from any directory:
    python code/verify_independent.py --local-only

Only the Python standard library is needed for the exact certificates.  If
NumPy/SciPy are available, every r=3 LP is also solved by scipy.optimize.linprog.
Use --require-scipy to make that additional check mandatory.

The exact checks certify the 64 finite scenario sets for r=3.  Repeated
constraints do not change these LPs, so these sets cover the fixed finite
model's arbitrary sample lengths.  They are a supplement to, not a substitute
for, the manuscript's symbolic proof or the general transfer theorem.
No formal proof assistant is invoked.
"""

from __future__ import annotations

import argparse
from collections import Counter
from fractions import Fraction as F
import hashlib
import itertools
import json
from math import comb
from pathlib import Path
import platform


def q(value):
    """Stable exact-rational JSON representation."""
    return str(F(value))


def dot(a, b):
    return sum((x * y for x, y in zip(a, b)), F(0))


def exact_rank(rows, n):
    a = [[F(x) for x in row] for row in rows]
    rank = 0
    for col in range(n):
        pivot = next((j for j in range(rank, len(a)) if a[j][col]), None)
        if pivot is None:
            continue
        a[rank], a[pivot] = a[pivot], a[rank]
        v = a[rank][col]
        a[rank] = [x / v for x in a[rank]]
        for j in range(len(a)):
            if j != rank and a[j][col]:
                v = a[j][col]
                a[j] = [x - v * y for x, y in zip(a[j], a[rank])]
        rank += 1
    return rank


class GridLP:
    """Original inequalities, with scenarios grouped as rows and columns."""

    def __init__(self, r):
        if r < 2:
            raise ValueError("r must be at least two")
        self.r = r
        self.k = r * r
        self.tau = F(1, 2 * self.k)
        self.weights = tuple(F(self.k - j) for j in range(self.k))
        self.labels = tuple([f"R{i + 1}" for i in range(r)] +
                            [f"C{i + 1}" for i in range(r)])
        self.allowed = tuple(
            frozenset(j for j in range(self.k)
                      if (j // r == s if s < r else j % r == s - r))
            for s in range(2 * r)
        )

    def selected(self, mask):
        return tuple(i for i in range(2 * self.r) if mask & (1 << i))

    def capped(self, mask):
        # Construct caps from the stated inequalities, not from the event law.
        return frozenset(j for i in self.selected(mask)
                         for j in range(self.k) if j not in self.allowed[i])

    def exact_primal_dual(self, mask):
        capped = self.capped(mask)
        uncapped = [j for j in range(self.k) if j not in capped]
        x = [F(0)] * self.k
        mu = [F(0)] * self.k
        if uncapped:
            first = uncapped[0]
            lam = self.weights[first]
            for j in range(first):
                x[j] = self.tau
                mu[j] = self.weights[j] - lam
            x[first] = 1 - first * self.tau
        else:
            first = None
            lam = F(0)
            x = [self.tau] * self.k
            mu = list(self.weights)
        return tuple(x), lam, tuple(mu), first

    def risk(self, x):
        # Directly evaluate every unsampled inequality in each scenario.
        violations = tuple(i for i in range(2 * self.r)
                           if any(x[j] > self.tau
                                  for j in range(self.k)
                                  if j not in self.allowed[i]))
        return F(len(violations), 2 * self.r), violations

    def verify_certificate(self, mask, x, lam, mu):
        capped = self.capped(mask)
        assert all(t >= 0 for t in x)
        assert sum(x) <= 1
        assert all(x[j] <= self.tau for j in capped)
        assert lam >= 0 and all(t >= 0 for t in mu)
        assert all(mu[j] == 0 for j in range(self.k) if j not in capped)
        reduced = tuple(lam + mu[j] - self.weights[j]
                        for j in range(self.k))
        assert all(t >= 0 for t in reduced)
        primal = dot(self.weights, x)
        dual = lam + self.tau * sum(mu)
        assert primal == dual
        assert lam * (1 - sum(x)) == 0
        assert all(mu[j] * (self.tau - x[j]) == 0 for j in capped)
        assert all(reduced[j] * x[j] == 0 for j in range(self.k))

        # Every other optimum obeys these equalities by nonnegative gap
        # decomposition.  Rank k certifies that the optimum is unique.
        forced = []
        if lam > 0:
            forced.append([F(1)] * self.k)
        for j in range(self.k):
            if mu[j] > 0 or reduced[j] > 0:
                row = [F(0)] * self.k
                row[j] = F(1)
                forced.append(row)
        rank = exact_rank(forced, self.k)
        assert rank == self.k
        return primal, reduced, rank

    def strict_interior(self):
        x = tuple([self.tau / 2] * self.k)
        assert all(t > 0 for t in x)
        assert sum(x) < 1
        assert all(x[j] < self.tau for i in range(2 * self.r)
                   for j in range(self.k) if j not in self.allowed[i])
        # l_infinity ball of radius tau/4 around x satisfies every inequality.
        radius = self.tau / 4
        assert all(t - radius > 0 for t in x)
        assert sum(x) + self.k * radius < 1
        assert all(t + radius < self.tau for t in x)
        return x, radius


def submasks(mask):
    current = mask
    while True:
        yield current
        if current == 0:
            break
        current = (current - 1) & mask


def beta_tail(d, n, eps):
    assert n >= d >= 1
    return sum((F(comb(n, i)) * eps**i * (1 - eps)**(n - i)
                for i in range(d)), F(0))


def stated_h(r, n):
    assert n >= 1
    return F(r)**(2 - n) * (1 - F(2)**(1 - n) * (1 - F(1, r)))


def finite_lp_certificates(model, scipy_required=False):
    try:
        import numpy as np
        import scipy
        from scipy.optimize import linprog
    except ImportError:
        if scipy_required:
            raise
        np = scipy = linprog = None

    exact = {}
    records = []
    max_float_error = 0.0
    max_objective_error = 0.0
    for mask in range(1 << (2 * model.r)):
        x, lam, mu, first = model.exact_primal_dual(mask)
        primal, reduced, rank = model.verify_certificate(mask, x, lam, mu)
        risk, violations = model.risk(x)
        exact[mask] = x
        if linprog is not None:
            capped = model.capped(mask)
            result = linprog(
                -np.array([float(t) for t in model.weights]),
                A_ub=np.ones((1, model.k)), b_ub=np.ones(1),
                bounds=[(0.0, float(model.tau) if j in capped else None)
                        for j in range(model.k)], method="highs",
            )
            assert result.success, (mask, result.message)
            error = float(np.max(np.abs(result.x - np.array([float(t) for t in x]))))
            obj_error = abs(float(result.fun) + float(primal))
            assert error < 1e-10, (mask, error)
            assert obj_error < 1e-10, (mask, obj_error)
            max_float_error = max(max_float_error, error)
            max_objective_error = max(max_objective_error, obj_error)
        records.append({
            "mask": mask,
            "scenarios": [model.labels[i] for i in model.selected(mask)],
            "capped_coordinates_one_based": [j + 1 for j in sorted(model.capped(mask))],
            "first_uncapped_coordinate_one_based": None if first is None else first + 1,
            "primal_x": [q(t) for t in x],
            "max_objective": q(primal),
            "min_objective": q(-primal),
            "dual_budget_multiplier": q(lam),
            "dual_cap_multipliers": [q(t) for t in mu],
            "dual_nonnegativity_slacks": [q(t) for t in reduced],
            "forced_equality_rank": rank,
            "risk": q(risk),
            "violated_scenarios": [model.labels[i] for i in violations],
        })
    histogram = Counter()
    for record in records:
        mask = record["mask"]
        reconstructing = [s for s in submasks(mask) if exact[s] == exact[mask]]
        minimum_size = min(s.bit_count() for s in reconstructing)
        minimum = sorted(s for s in reconstructing if s.bit_count() == minimum_size)
        irreducible = [s for s in reconstructing
                       if not any(t != s and (t & s) == t for t in reconstructing)]
        assert minimum_size <= 2
        assert all(s.bit_count() <= 2 for s in irreducible)
        record["minimum_compression_size"] = minimum_size
        record["minimum_compression_masks"] = minimum
        record["all_irreducible_compression_masks"] = sorted(irreducible)
        histogram[minimum_size] += 1
    return exact, records, {
        "status": "passed" if linprog is not None else "unavailable",
        "scipy_version": None if scipy is None else scipy.__version__,
        "numpy_version": None if np is None else np.__version__,
        "lp_count": len(records) if linprog is not None else 0,
        "maximum_coordinate_absolute_error": max_float_error,
        "maximum_objective_absolute_error": max_objective_error,
    }, dict(sorted(histogram.items()))


def verify_sample_laws(model, exact):
    eps = F(3, 5)
    risk_by_mask = {mask: model.risk(x)[0] for mask, x in exact.items()}
    samples_n2 = []
    high_count = 0
    for sequence in itertools.product(range(2 * model.r), repeat=2):
        mask = (1 << sequence[0]) | (1 << sequence[1])
        risk = risk_by_mask[mask]
        high_count += risk > eps
        samples_n2.append({
            "sample": [model.labels[i] for i in sequence],
            "mask": mask, "risk": q(risk), "risk_gt_epsilon": risk > eps,
        })
    probability = F(high_count, (2 * model.r)**2)
    tail = beta_tail(2, 2, eps)
    assert probability == F(2, 3)
    assert tail == F(16, 25)
    assert probability - tail == F(2, 75) > 0

    # Dynamic program counts all ordered samples exactly by their distinct-set
    # mask.  It never uses the claimed closed form h_N in a transition.
    counts = {0: 1}
    dp_rows = []
    for n in range(1, 21):
        next_counts = Counter()
        for mask, count in counts.items():
            for s in range(2 * model.r):
                next_counts[mask | (1 << s)] += count
        counts = dict(next_counts)
        assert sum(counts.values()) == (2 * model.r)**n
        law = Counter()
        for mask, count in counts.items():
            law[risk_by_mask[mask]] += count
        high = sum(count for risk, count in law.items() if risk > eps)
        exact_tail = F(high, (2 * model.r)**n)
        assert exact_tail == stated_h(model.r, n)
        dp_rows.append({
            "N": n, "ordered_sample_count": (2 * model.r)**n,
            "high_risk_sample_count": high, "high_risk_probability": q(exact_tail),
            "closed_form_h_N": q(stated_h(model.r, n)),
            "risk_law_counts": {q(risk): count for risk, count in sorted(law.items())},
        })

    # Direct sequence enumeration separately checks the dynamic program.
    direct_rows = []
    for n in range(1, 7):
        count = 0
        for sequence in itertools.product(range(2 * model.r), repeat=n):
            mask = 0
            for s in sequence:
                mask |= 1 << s
            count += risk_by_mask[mask] > eps
        assert count == dp_rows[n - 1]["high_risk_sample_count"]
        direct_rows.append({"N": n, "ordered_sample_count": (2 * model.r)**n,
                            "high_risk_sample_count": count})
    return samples_n2, dp_rows, direct_rows, {
        "r": model.r, "ambient_dimension": model.k, "compression_bound": 2,
        "N": 2, "epsilon": q(eps), "high_risk": q(F(model.r - 1, model.r)),
        "high_risk_ordered_samples": high_count,
        "all_ordered_samples": (2 * model.r)**2,
        "exact_tail_probability": q(probability),
        "beta_2_1_tail": q(tail), "strict_excess": q(probability - tail),
    }


def cross_r_checks():
    # A finite parameter check, explicitly not a proof for every integer r.
    rows = []
    for r in (2, 3, 4, 5):
        model = GridLP(r)
        risks = {}
        for mask in range(1 << (2 * r)):
            x, _, _, _ = model.exact_primal_dual(mask)
            risks[mask] = model.risk(x)[0]
            assert risks[mask] in (F(0), F(r - 1, r))
        counts = {0: 1}
        for n in range(1, 13):
            nxt = Counter()
            for mask, count in counts.items():
                for s in range(2 * r):
                    nxt[mask | (1 << s)] += count
            counts = dict(nxt)
            high = sum(count for mask, count in counts.items() if risks[mask] > 0)
            probability = F(high, (2 * r)**n)
            assert probability == stated_h(r, n)
            rows.append({"r": r, "N": n, "probability_nonzero_risk": q(probability),
                         "stated_h_N": q(stated_h(r, n))})
    return rows


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--local-only", action="store_true",
                        help="Explicitly select the only supported mode: local computation.")
    parser.add_argument("--require-scipy", action="store_true")
    parser.add_argument("--output-dir", type=Path,
                        default=Path(__file__).resolve().parents[1] / "results")
    args = parser.parse_args()
    model = GridLP(3)
    exact, certificates, numeric, histogram = finite_lp_certificates(model, args.require_scipy)
    n2, dp, direct, witness = verify_sample_laws(model, exact)
    cross_r = cross_r_checks()
    center, radius = model.strict_interior()
    result = {
        "schema": "convex-scenario-independent-verification-v1",
        "verification_status": "passed",
        "scope": {
            "exact_LP_certificates": "all 64 distinct scenario subsets for r=3, including empty",
            "sample_law": "direct ordered samples N=1..6; independent integer-state counts N=1..20",
            "parameter_spot_checks": "r=2,3,4,5 and N=1..12",
            "limitations": "Finite certificates supplement the symbolic manuscript; no proof assistant was run and no general transfer theorem is certified by enumeration.",
        },
        "runtime": {"python": platform.python_version(),
                    "verifier_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest()},
        "model": {"r": 3, "K": 9, "tau": q(model.tau),
                  "maximization_weights": [q(t) for t in model.weights],
                  "scenario_labels": list(model.labels)},
        "common_strict_interior": {"point": [q(t) for t in center],
                                   "linfinity_radius": q(radius),
                                   "coordinate_slack": q(model.tau / 2),
                                   "budget_slack": q(1 - sum(center))},
        "all_subset_certificate_count": len(certificates),
        "minimum_compression_size_histogram": histogram,
        "all_irreducible_supports_have_size_at_most_two": True,
        "numerical_cross_check": numeric,
        "counterexample": witness,
        "all_subset_certificates": certificates,
        "ordered_samples_N2": n2,
        "risk_laws_dynamic_counts": dp,
        "risk_laws_direct_enumeration": direct,
        "finite_cross_r_checks": cross_r,
    }
    args.output_dir.mkdir(parents=True, exist_ok=True)
    target = args.output_dir / "independent_verification.json"
    target.write_text(json.dumps(result, ensure_ascii=False, indent=2, sort_keys=True) + "\n")
    digest = hashlib.sha256(target.read_bytes()).hexdigest()
    summary = {
        "verification_status": "passed", "certificate_file": target.name,
        "certificate_sha256": digest,
        "all_subset_certificate_count": len(certificates),
        "compression_histogram": histogram, "numerical_cross_check": numeric,
        "counterexample": witness,
        "scope_note": result["scope"]["limitations"],
    }
    (args.output_dir / "independent_summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=2, sort_keys=True) + "\n")
    print(json.dumps(summary, ensure_ascii=False, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
