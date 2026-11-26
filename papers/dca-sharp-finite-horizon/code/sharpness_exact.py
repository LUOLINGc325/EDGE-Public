#!/usr/bin/env python3
"""Exact rational checks for the analytic sharpness constructions.

No numerical optimizer is used. Vectors are rational coordinates in an
orthogonal basis with rational positive squared lengths. Thus their Euclidean
Gram matrices, interpolation residuals, and all checked identities are exact.
The finite examples are regression certificates, not substitutes for the
all-parameter proof in paper/SHARPNESS_DRAFT.md.
"""

from fractions import Fraction as F
from math import isqrt
from pathlib import Path
import argparse
import json


def add(x, y):
    return tuple(a + b for a, b in zip(x, y))


def sub(x, y):
    return tuple(a - b for a, b in zip(x, y))


def scale(c, x):
    return tuple(c * a for a in x)


def dot(x, y, weights):
    return sum((w * a * b for w, a, b in zip(weights, x, y)), F(0))


def E(n, t):
    return sum((t ** (-j) for j in range(1, 2 * n + 1)), F(0))


def coefficient(n, eta, rho):
    er = E(n, rho)
    if eta <= 1:
        return 1 + rho + min(E(n, eta), er)
    A = (1 + eta) * (1 + rho) / (eta + rho)
    D = (1 - eta) * (1 - rho) / (eta - rho)
    P = A * (n + D * sum((max(E(k, eta) - E(k, rho), F(0))
                         for k in range(n + 1)), F(0)))
    return 1 + rho + min(P, er)


def exact_sqrt(q):
    assert q >= 0
    n, d = isqrt(q.numerator), isqrt(q.denominator)
    if n * n != q.numerator or d * d != q.denominator:
        raise ValueError("This diagnostic sample has nonrational coordinates")
    return F(n, d)


def Q(i, j, xs, ds, vals, eta, rho, weights):
    a, M = 1 - eta, eta - rho
    dx = sub(xs[i], xs[j])
    z = sub(sub(ds[i], ds[j]), scale(a, dx))
    return (vals[i] - vals[j] - dot(ds[j], dx, weights)
            - a * dot(dx, dx, weights) / 2 - dot(z, z, weights) / (2 * M))


def scalar_rho(n, eta, rho):
    xs = [(rho ** (k - n) / (1 - rho),) for k in range(n + 2)]
    ds = [(rho ** (k - n),) for k in range(n + 2)]
    vals = [(1 - rho) * x[0] ** 2 / 2 for x in xs]
    return xs, ds, vals, (F(1),), {"kind": "rho-quadratic"}


def scalar_eta(n, eta, rho):
    xs = [(sum((eta ** (-j) for j in range(1, n - k + 1)), F(0)),)
          for k in range(n + 1)] + [(F(-1),)]
    ds = [(eta ** (k - n),) for k in range(n + 1)] + [(rho,)]
    vals = [((1 - (eta if x[0] >= 0 else rho)) * x[0] ** 2 / 2 + x[0])
            for x in xs]
    return xs, ds, vals, (F(1),), {"kind": "eta-piecewise-quadratic"}


def nonconvex_P(n, eta, rho):
    assert eta > 1 and -1 < rho < 0
    m = 0
    while E(m + 1, eta) >= E(m + 1, rho):
        m += 1
        assert m < 10000
    assert n > m
    den = eta ** 2 - rho ** 2
    wr, we = (eta ** 2 - 1) / den, (1 - rho ** 2) / den
    weights = (wr, we, we)
    ds = [(rho ** (i - m), eta ** (i - m), F(0)) for i in range(m + 1)]
    M = eta - rho
    A = (1 + eta) * (1 + rho) / (eta + rho)

    def next_d(i, d):
        t = i - m
        S = sum((rho ** (2 * k) for k in range(t)), F(0))
        q = (-1) ** t * exact_sqrt((eta ** 2 - 1) * S)
        v, w = d[1:]
        # cos(theta) R(theta) = [[1,-q],[q,1]] / (1+q^2).
        return (rho * d[0],
                rho * v + M * (v - q * w) / (1 + q * q),
                rho * w + M * (q * v + w) / (1 + q * q))

    for i in range(m, n):
        ds.append(next_d(i, ds[-1]))
    xs = [(F(0), F(0), F(0)) for _ in range(n + 2)]
    for i in range(n - 1, -1, -1):
        xs[i] = add(xs[i + 1], ds[i])
    xs[n + 1] = scale(F(-1), ds[n])
    vals = [F(0) for _ in range(n + 2)]
    for i in range(n - 1, -1, -1):
        dec = (A / 2 if i >= m else
               ((1 + rho) * wr * ds[i][0] ** 2
                + (1 + eta) * we * ds[i][1] ** 2) / 2)
        vals[i] = vals[i + 1] + dec
    vals[n + 1] = -(1 + rho) / 2
    ds.append(scale(rho, ds[n]))
    meta = {"kind": "P-prefix-and-continuation", "phase_index": m}
    B = ((eta ** 2 - 1) * E(m, rho) + (1 - rho ** 2) * E(m, eta)) / den
    assert 2 * (vals[0] - vals[n]) == B + A * (n - m)

    # When also rational, check both exact terminal-comparison identities
    # against the unmodified extra gradient of the published construction.
    try:
        old_d = next_d(n, ds[n])
    except ValueError:
        meta["terminal_comparison"] = "not instantiated: auxiliary old gradient is irrational"
    else:
        old_ds, old_vals = list(ds), list(vals)
        old_ds[-1], old_vals[-1] = old_d, -A / 2
        e = sub(old_d, scale(rho, ds[n]))
        assert vals[-1] - old_vals[-1] == dot(e, e, weights) / (2 * M)
        for j in range(n + 1):
            assert Q(n + 1, j, xs, ds, vals, eta, rho, weights) == Q(
                n, j, xs, old_ds, old_vals, eta, rho, weights)
        for i in range(n + 1):
            sdiff = add(scale(1 - rho, sub(xs[i], xs[n])), sub(ds[n], ds[i]))
            assert Q(i, n + 1, xs, ds, vals, eta, rho, weights) == (
                Q(i, n + 1, xs, old_ds, old_vals, eta, rho, weights)
                + dot(e, sdiff, weights) / M)
        meta["terminal_comparison"] = "both ordered identities verified exactly"
    return xs, ds, vals, weights, meta


def rank(rows):
    a = [list(row) for row in rows]
    r = 0
    for j in range(len(a[0])):
        p = next((i for i in range(r, len(a)) if a[i][j]), None)
        if p is None:
            continue
        a[r], a[p] = a[p], a[r]
        pivot = a[r][j]
        a[r] = [z / pivot for z in a[r]]
        for i in range(len(a)):
            if i != r and a[i][j]:
                t = a[i][j]
                a[i] = [z - t * y for z, y in zip(a[i], a[r])]
        r += 1
    return r


def run_case(label, n, eta, rho, maker):
    xs, ds, vals, weights, meta = maker(n, eta, rho)
    assert all(w > 0 for w in weights)
    residuals = {f"Q_{i}_{j}": Q(i, j, xs, ds, vals, eta, rho, weights)
                 for i in range(n + 2) for j in range(n + 2) if i != j}
    assert all(q >= 0 for q in residuals.values()), (label, min(residuals.values()))
    norms = [dot(d, d, weights) for d in ds[:n + 1]]
    assert min(norms) == 1
    for i in range(n + 1):
        assert xs[i + 1] == sub(xs[i], ds[i])
    measured = 2 * (vals[0] - vals[-1])
    assert measured == coefficient(n, eta, rho), label

    # Independently check the transformed f2 convexification, including the
    # terminal point. It is precisely what the global conjugate extension uses.
    hs = [(1 - rho) * dot(x, x, weights) / 2 - f for x, f in zip(xs, vals)]
    ss = [sub(scale(1 - rho, x), d) for x, d in zip(xs, ds)]
    for i in range(n + 2):
        for j in range(n + 2):
            dx, sd = sub(xs[i], xs[j]), sub(ss[i], ss[j])
            hres = hs[i] - hs[j] - dot(ss[j], dx, weights) - dot(sd, sd, weights) / (2 * (eta - rho))
            assert hres == Q(j, i, xs, ds, vals, eta, rho, weights)
            assert hres >= 0

    return {"label": label, "N": n, "eta": str(eta), "rho": str(rho), **meta,
            "coefficient_exact": str(measured), "minimum_step_squared": "1",
            "trajectory_gradient_rank": rank(ds[:n + 1]),
            "ordered_interpolation_constraints": len(residuals),
            "zero_interpolation_residuals": sum(q == 0 for q in residuals.values()),
            "minimum_interpolation_residual": str(min(residuals.values())),
            "gram_basis_squared_lengths": [str(w) for w in weights],
            "points_in_weighted_basis": [[str(z) for z in x] for x in xs],
            "gradients_in_weighted_basis": [[str(z) for z in d] for d in ds],
            "function_values": [str(f) for f in vals],
            "step_Gram": [[str(dot(x, y, weights)) for y in ds[:n + 1]] for x in ds[:n + 1]],
            "interpolation_residuals": {k: str(v) for k, v in residuals.items()}}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    cases = [
        ("convex-rho", 2, F(4, 5), F(-3, 5), scalar_rho),
        ("convex-eta", 4, F(4, 5), F(-3, 5), scalar_eta),
        ("convex-eta-one", 4, F(1), F(-3, 5), scalar_eta),
        ("nonconvex-rho", 2, F(3, 2), F(-4, 5), scalar_rho),
        ("nonconvex-quadratic-prefix", 4, F(3, 2), F(-4, 5), nonconvex_P),
        ("nonconvex-three-dimensional", 4, F(5, 3), F(-3, 4), nonconvex_P),
        ("nonconvex-three-dimensional-longer", 5, F(5, 3), F(-3, 4), nonconvex_P),
        ("nonconvex-zero-prefix", 2, F(5, 3), F(-1, 2), nonconvex_P),
    ]
    results = [run_case(*case) for case in cases]
    out = {"arithmetic": "fractions.Fraction; all assertions exact",
           "scope": "finite regression certificates supporting the analytic proof",
           "cases": results}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(out, indent=2) + "\n")
    for r in results:
        print(f'{r["label"]}: C={r["coefficient_exact"]}, '
              f'rank={r["trajectory_gradient_rank"]}, '
              f'{r["ordered_interpolation_constraints"]} exact ordered constraints passed')


if __name__ == "__main__":
    main()
