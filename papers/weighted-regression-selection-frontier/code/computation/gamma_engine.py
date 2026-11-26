"""Finite k=1 selector computation with separate rational certificates.

Mathematical reduction: Zhang, arXiv:2608.28007v2, Lemma G.2.
This implementation is a research verification aid, not a new convex-hull theorem.
It computes FULL-RANK selectors only unless an explicit shift certificate is added.
Exploration uses floating point; certify_k1 and verify_certificate use rationals.
"""
from __future__ import annotations

import argparse
import itertools
import json
import math
from fractions import Fraction
from pathlib import Path

import numpy as np
import sympy as sp


def rat(value):
    if isinstance(value, (int, np.integer)):
        return sp.Rational(int(value))
    if isinstance(value, float):
        raise TypeError("A certificate cannot silently convert a float to rational")
    return sp.Rational(str(value))


def matrix_json(a):
    return [[str(a[i, j]) for j in range(a.cols)] for i in range(a.rows)]


def gamma(d, k):
    terms = {}
    for s in range(k + 1, d + 1):
        q, a = divmod(d, s)
        terms[s] = Fraction(s - k, 1) / (Fraction(s - a, q) + Fraction(a, q + 1))
    value = max(terms.values())
    return value, [s for s in terms if terms[s] == value]


def known_connected():
    """Exactly Zhang Proposition I.7; masses globally rescaled only."""
    g = [
        [1, -1, 0, 0, 0, 0, 0, 0],
        [0, 1, -1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, -1, 0, 0],
        [0, 0, 0, 0, 0, 1, -1, 0],
        [0, 0, 0, 0, 0, 0, 1, -1],
        [1, 1, 1, -6, 1, 1, 1, 0],
    ]
    return g, [2, 2, 2, "1/1000", 1, 1, 1, 1]


def circuit_blocks(ranks):
    """Direct sum of zero-sum simplices, an explicitly known extremal class."""
    d = sum(ranks)
    n = sum(r + 1 for r in ranks)
    g = sp.zeros(d, n)
    row = col = 0
    for r in ranks:
        for j in range(r):
            g[row + j, col + j] = 1
            g[row + j, col + r] = -1
        row += r
        col += r + 1
    return [[int(v) for v in g.row(i)] for i in range(d)]


def _closest_hull_float(points, h, tol=2e-10):
    """Active-set projection, followed by explicit floating KKT checks.

    Returned status is exploratory only. A numeric failure is never a proof.
    points has shape d x m. Strict convexity holds in point-space.
    """
    qmat = points.T @ h @ points
    qmat = (qmat + qmat.T) / 2
    m = len(qmat)
    if m == 1:
        return float(qmat[0, 0]), np.ones(1), True
    scale = max(1.0, float(np.max(np.abs(qmat))))
    scaled = qmat / scale
    lam = np.zeros(m)
    lam[int(np.argmin(np.diag(scaled)))] = 1.0
    active = [int(np.argmax(lam))]
    for _ in range(100):
        aa = scaled[np.ix_(active, active)]
        kkt = np.block([[aa, np.ones((len(active), 1))],
                        [np.ones((1, len(active))), np.zeros((1, 1))]])
        rhs = np.r_[np.zeros(len(active)), 1.0]
        try:
            z = np.linalg.solve(kkt, rhs)[:-1]
        except np.linalg.LinAlgError:
            z = np.linalg.lstsq(kkt, rhs, rcond=1e-13)[0][:-1]
        if np.min(z) < -tol:
            old = lam[active]
            ratios = [(old[j] / (old[j] - z[j]), j)
                      for j in range(len(active)) if z[j] < -tol]
            theta, _ = min(ratios)
            new = old + theta * (z - old)
            lam[:] = 0
            lam[active] = new
            active = [j for j in active if lam[j] > tol]
            if not active:
                return float("nan"), lam, False
            lam[lam < tol] = 0
            lam /= lam.sum()
            continue
        lam[:] = 0
        lam[active] = np.maximum(0, z)
        lam /= lam.sum()
        value = float(lam @ scaled @ lam)
        slack = scaled @ lam - value
        entering = int(np.argmin(slack))
        if slack[entering] >= -tol:
            return float(value * scale), lam, True
        if entering in active:
            return float(value * scale), lam, False
        active.append(entering)
    return float(lam @ qmat @ lam), lam, False


class NumericFamily:
    """Cache basis inverses for fixed exact gradient geometry, vary masses."""
    def __init__(self, gradients, exact_rank=False):
        self.g_exact = sp.Matrix(gradients).applyfunc(rat)
        self.g = np.array(self.g_exact, dtype=float)
        self.d, self.n = self.g.shape
        if self.g_exact * sp.ones(self.n, 1) != sp.zeros(self.d, 1):
            raise ValueError("Gradient columns must sum exactly to zero")
        if self.g_exact.rank() != self.d:
            raise ValueError("Gradient matrix must have full row rank")
        self.bases = []
        inverses = []
        self.by_set = {}
        for basis in itertools.combinations(range(self.n), self.d):
            a = self.g[:, basis].T
            determinant = np.linalg.det(a)
            independent = abs(determinant) > 1e-9
            if exact_rank or abs(determinant) < 1e-6:
                independent = self.g_exact[:, list(basis)].det() != 0
            if independent:
                self.by_set[basis] = len(self.bases)
                self.bases.append(basis)
                inverses.append(np.linalg.inv(a))
        self.bases_array = np.array(self.bases, dtype=int)
        self.inverses = np.array(inverses)
        self.supports = []
        for support in itertools.combinations(range(self.n), min(self.n, self.d + 1)):
            vertices = [self.by_set[b] for b in itertools.combinations(support, self.d)
                        if b in self.by_set]
            if vertices:
                self.supports.append((support, vertices))

    def evaluate(self, masses, early_below=None):
        c = np.asarray(masses, dtype=float)
        if len(c) != self.n or np.min(c) <= 0:
            raise ValueError("Masses must be positive and have one per gradient")
        h = (self.g / c) @ self.g.T / c.sum()
        vertices = np.einsum("bij,bj->bi", self.inverses, c[self.bases_array])
        best = float("inf")
        best_support = None
        all_ok = True
        for support, ids in self.supports:
            val, lam, ok = _closest_hull_float(vertices[ids].T, h)
            all_ok = all_ok and ok
            if val < best:
                best, best_support = val, support
            if early_below is not None and best < early_below:
                return {"excess": best, "support": best_support,
                        "numeric_kkt_ok": all_ok, "complete_scan": False}
        return {"excess": best, "support": best_support,
                "numeric_kkt_ok": all_ok, "complete_scan": True}


def exact_projection(points, h, suggested=None):
    """Return a rational minimum-norm convex-combination certificate.

    Enumeration terminates because the adjacent-basis vertices are affinely
    independent unless all coincide; duplicates are removed by the caller.
    Every successful return verifies all inequalities, not only the chosen face.
    """
    m = points.cols
    qmat = points.T * h * points
    faces = []
    if suggested is not None:
        candidate = tuple(i for i, x in enumerate(suggested) if x > 1e-8)
        if candidate:
            faces.append(candidate)
    faces.extend(itertools.chain.from_iterable(
        itertools.combinations(range(m), size) for size in range(m, 0, -1)))
    tried = set()
    for face in faces:
        if face in tried:
            continue
        tried.add(face)
        a = qmat.extract(face, face)
        kkt = a.row_join(sp.ones(len(face), 1)).col_join(
            sp.ones(1, len(face)).row_join(sp.zeros(1, 1)))
        rhs = sp.zeros(len(face) + 1, 1)
        rhs[-1] = 1
        if kkt.det() == 0:
            continue
        solution = kkt.inv() * rhs
        if any(x < 0 for x in solution[:-1]):
            continue
        lam = sp.zeros(m, 1)
        for i, j in enumerate(face):
            lam[j] = solution[i]
        q = points * lam
        value = (q.T * h * q)[0]
        slack = points.T * h * q - sp.ones(m, 1) * value
        if all(x >= 0 for x in slack):
            return q, lam, value, slack
    raise ArithmeticError("Exact convex hull certificate not found")


def certify_k1(gradients, masses, name="unnamed"):
    g = sp.Matrix(gradients).applyfunc(rat)
    c = sp.Matrix([rat(v) for v in masses])
    d, n = g.shape
    if n < d or len(c) != n or any(x <= 0 for x in c):
        raise ValueError("Malformed dimensions or nonpositive masses")
    if g.rank() != d or g * sp.ones(n, 1) != sp.zeros(d, 1):
        raise ValueError("Full rank and exact zero sum are required")
    s = sum(c)
    h = g * sp.diag(*[1 / x for x in c]) * g.T / s
    x = (g * sp.diag(*[1 / x for x in c])).T
    vertices = {}
    basis_values = {}
    for basis in itertools.combinations(range(n), d):
        a = x[list(basis), :]
        if a.det() != 0:
            q = a.inv() * sp.ones(d, 1)
            vertices[basis] = q
            basis_values[basis] = (q.T * h * q)[0]
    supports = []
    rank_deficient = []
    for support in itertools.combinations(range(n), min(n, d + 1)):
        bases = [b for b in itertools.combinations(support, d) if b in vertices]
        if not bases:
            rank_deficient.append(list(support))
            continue
        unique = []
        unique_bases = []
        for basis in bases:
            point = vertices[basis]
            if point not in unique:
                unique.append(point)
                unique_bases.append(basis)
        points = sp.Matrix.hstack(*unique)
        _, suggested, _ = _closest_hull_float(np.array(points, dtype=float),
                                               np.array(h, dtype=float))
        q, lam, value, slack = exact_projection(points, h, suggested)
        supports.append({"support": list(support),
                         "vertex_bases": [list(b) for b in unique_bases],
                         "q": [str(v) for v in q],
                         "lambda": [str(v) for v in lam],
                         "excess": str(value),
                         "slacks": [str(v) for v in slack]})
    optimum = min(rat(v["excess"]) for v in supports)
    target, max_s = gamma(d, 1)
    probabilities = [v / s for v in c]
    denominator = sp.ilcm(*[v.q for v in probabilities])
    multiplicities = [int(v * denominator) for v in probabilities]
    return {"schema": "ede-gamma-k1-exact-v1", "name": name,
            "attribution": "Adjacent-basis hull: Zhang arXiv:2608.28007v2 Lemma G.2",
            "scope": "full-rank supports only; shift required for original minimum-norm learner",
            "d": d, "n_types": n, "budget": d + 1,
            "G": matrix_json(g), "masses": [str(v) for v in c],
            "X": matrix_json(x), "H": matrix_json(h),
            "evaluation_multiplicities": multiplicities,
            "full_rank_basis_count": len(vertices),
            "full_rank_budget_d_optimum": str(min(basis_values.values())),
            "full_rank_budget_d_plus_one_optimum": str(optimum),
            "gamma": str(target), "gamma_maximizing_s": max_s,
            "strict_full_rank_violation": bool(optimum > rat(target)),
            "support_certificates": supports,
            "rank_deficient_budget_d_plus_one_supports": rank_deficient}


def shift_certificate(certificate, minimum_excess=None):
    """Construct an explicit common lower bound for EVERY proper feature span.

    Every proper span of features extends to a hyperplane spanned by d-1
    independent features, since the complete feature matrix has rank d.
    Minimum-norm LS outputs are in their chosen feature span.
    """
    x = sp.Matrix(certificate["X"])
    h_metric = sp.Matrix(certificate["H"])
    d, n = certificate["d"], certificate["n_types"]
    target = rat(minimum_excess if minimum_excess is not None else
                 certificate["full_rank_budget_d_plus_one_optimum"])
    normals = {}
    for subset in itertools.combinations(range(n), d - 1):
        a = x[list(subset), :]
        if a.rank() != d - 1:
            continue
        normal = a.nullspace()[0]
        lead = next(v for v in normal if v != 0)
        normal = normal / lead
        key = tuple(normal)
        normals.setdefault(key, subset)
    inverse_h = h_metric.inv()
    t = 1
    while True:
        direction = sp.Matrix([t ** j for j in range(d)])
        if all((sp.Matrix(normal).T * direction)[0] != 0 for normal in normals):
            break
        t += 1
    hyperplanes = []
    for normal, subset in normals.items():
        normal = sp.Matrix(normal)
        delta = (normal.T * direction)[0] ** 2 / (normal.T * inverse_h * normal)[0]
        assert delta > 0
        hyperplanes.append({"basis": list(subset), "normal": [str(v) for v in normal],
                            "distance_squared": str(delta)})
    min_delta = min(rat(p["distance_squared"]) for p in hyperplanes)
    bound = target / min_delta
    multiplier = math.isqrt(int(sp.ceiling(bound))) + 1
    while multiplier * multiplier * min_delta <= target:
        multiplier += 1
    shift = multiplier * direction
    labels = sp.ones(n, 1) + x * shift
    return {"direction": [str(v) for v in direction], "multiplier": multiplier,
            "shift": [str(v) for v in shift], "labels": [str(v) for v in labels],
            "hyperplanes": hyperplanes, "minimum_distance_squared": str(min_delta),
            "all_rank_deficient_excess_lower_bound": str(multiplier ** 2 * min_delta),
            "strictly_exceeds": str(target)}


def verify_certificate(certificate):
    """Reconstruct each basis and all supports; do not trust stored QP values."""
    g = sp.Matrix(certificate["G"])
    c = sp.Matrix(certificate["masses"])
    d, n = g.shape
    assert d == certificate["d"] and n == certificate["n_types"]
    assert g.rank() == d and g * sp.ones(n, 1) == sp.zeros(d, 1)
    assert all(v > 0 for v in c)
    x = (g * sp.diag(*[1 / v for v in c])).T
    h = x.T * sp.diag(*[v / sum(c) for v in c]) * x
    assert x == sp.Matrix(certificate["X"])
    assert h == sp.Matrix(certificate["H"])
    mult = certificate["evaluation_multiplicities"]
    assert all(isinstance(v, int) and v > 0 for v in mult)
    assert sp.Matrix(mult) / sum(mult) == c / sum(c)
    entries = {tuple(v["support"]): v for v in certificate["support_certificates"]}
    skipped = set(map(tuple, certificate["rank_deficient_budget_d_plus_one_supports"]))
    values = []
    full_rank_count = 0
    for support in itertools.combinations(range(n), min(n, d + 1)):
        points = []
        for basis in itertools.combinations(support, d):
            a = x[list(basis), :]
            if a.det() != 0:
                point = a.inv() * sp.ones(d, 1)
                if point not in points:
                    points.append(point)
        if not points:
            assert support in skipped and support not in entries
            continue
        full_rank_count += 1
        entry = entries[support]
        q = sp.Matrix(entry["q"])
        lam = sp.Matrix(entry["lambda"])
        # Reconstruct using the saved order, then compare its complete vertex set.
        saved_points = []
        for basis in entry["vertex_bases"]:
            assert set(basis).issubset(support)
            saved_points.append(x[basis, :].inv() * sp.ones(d, 1))
        assert len(saved_points) == len(points)
        assert all(point in saved_points for point in points)
        assert all(v >= 0 for v in lam) and sum(lam) == 1
        assert sp.Matrix.hstack(*saved_points) * lam == q
        value = (q.T * h * q)[0]
        assert value == rat(entry["excess"])
        slacks = [(point.T * h * q)[0] - value for point in saved_points]
        assert all(v >= 0 for v in slacks)
        assert slacks == [rat(v) for v in entry["slacks"]]
        values.append(value)
    assert full_rank_count == len(entries)
    optimum = min(values)
    assert optimum == rat(certificate["full_rank_budget_d_plus_one_optimum"])
    if "shift_certificate" in certificate:
        shift = certificate["shift_certificate"]
        direction = sp.Matrix(shift["direction"])
        v = sp.Matrix(shift["shift"])
        assert v == shift["multiplier"] * direction
        assert sp.Matrix(shift["labels"]) == sp.ones(n, 1) + x * v
        inverse_h = h.inv()
        planes = {}
        for subset in itertools.combinations(range(n), d - 1):
            a = x[list(subset), :]
            if a.rank() == d - 1:
                normal = a.nullspace()[0]
                normal /= next(z for z in normal if z != 0)
                planes[tuple(normal)] = subset
        supplied = {tuple(sp.Matrix(p["normal"])): p for p in shift["hyperplanes"]}
        assert set(planes) == set(supplied)
        distances = []
        for key, entry in supplied.items():
            normal = sp.Matrix(key)
            assert x[entry["basis"], :] * normal == sp.zeros(d - 1, 1)
            distance = (normal.T * direction)[0] ** 2 / (normal.T * inverse_h * normal)[0]
            assert distance > 0 and distance == rat(entry["distance_squared"])
            distances.append(distance)
        assert min(distances) == rat(shift["minimum_distance_squared"])
        lower = shift["multiplier"] ** 2 * min(distances)
        assert lower == rat(shift["all_rank_deficient_excess_lower_bound"])
        assert lower > rat(shift["strictly_exceeds"])
    return {"status": "RATIONAL_CERTIFICATE_VERIFIED", "supports": len(entries),
            "excess": str(optimum), "has_shift": "shift_certificate" in certificate}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("command", choices=["regression", "verify", "certify"])
    parser.add_argument("--input", type=Path)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--shift", action="store_true")
    args = parser.parse_args()
    if args.command == "verify":
        print(json.dumps(verify_certificate(json.loads(args.input.read_text()))))
        return
    if args.command == "regression":
        g, c = known_connected()
        cert = certify_k1(g, c, "Zhang_Proposition_I_7_regression")
        assert rat(cert["full_rank_budget_d_optimum"]) == sp.Rational(192048003, 80008000)
        assert rat(cert["full_rank_budget_d_plus_one_optimum"]) == sp.Rational(288030000, 240094007)
    else:
        data = json.loads(args.input.read_text())
        cert = certify_k1(data["G"], data["masses"], data.get("name", "unnamed"))
    if args.shift:
        cert["shift_certificate"] = shift_certificate(cert)
    result = verify_certificate(cert)
    if args.output:
        args.output.write_text(json.dumps(cert, indent=2) + "\n")
    print(json.dumps(result))


if __name__ == "__main__":
    main()
