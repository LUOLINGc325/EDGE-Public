#!/usr/bin/env python3
"""Finite-point DCA performance estimation; numerical evidence only.

Normalize mu1=1, x0=0 and grad(f2)(x0)=0.  The last normalization is a
common affine shift of f1 and f2, which preserves their difference and DCA.
There are N+1 steps and N+2 interpolation points.  Minimize the *terminal
objective decrease* subject to every squared step length being at least 1.
Twice the optimum is the proposed sharp coefficient C_N(eta,rho).

The f1 and f2 interpolation inequalities are imposed for every ordered pair.
For L1=infinity f1 is a nonsmooth 1-strongly convex function; finite L1>1
adds the standard smooth interpolation square.  f2 has curvature [rho,eta].
This differs from PEPit's built-in residual/F0-Fstar DCA example.

Floating-point SDP solutions and multipliers are not mathematical proofs.
Global realizability, boundedness below, and exact certificate conversion
must be established separately in the manuscript.
"""

from __future__ import annotations

import argparse
import json
import math
import platform
import time
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path

import cvxpy as cp
import numpy as np


def E(n: int, t: float) -> float:
    """Paired form avoids avoidable cancellation when t is negative."""
    if n == 0:
        return 0.0
    if t == 0:
        return math.inf
    return math.fsum((1 + t) * t ** (-2 * k) for k in range(1, n + 1))


def proposed_coefficient(n: int, eta: float, rho: float) -> dict:
    en_eta, en_rho = E(n, eta), E(n, rho)
    if eta <= 1:
        branch = "convex_equation_10"
        primary = en_eta
        pn = None
    else:
        branch = "nonconvex_equation_9"
        correction = math.fsum(max(E(k, eta) - E(k, rho), 0) for k in range(n + 1))
        pn = ((1 + eta) * (1 + rho) / (eta + rho)
              * (n + (1 - eta) * (1 - rho) / (eta - rho) * correction))
        primary = pn
    value = 1 + rho + min(primary, en_rho)
    return {"branch": branch, "coefficient": value, "E_eta": en_eta,
            "E_rho": en_rho, "P_N": pn,
            "active": "E_rho" if en_rho < primary else ("E_eta" if eta <= 1 else "P_N")}


def symouter(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    return (np.outer(a, b) + np.outer(b, a)) / 2


@dataclass
class LinearConstraint:
    name: str
    gram: np.ndarray
    f1: np.ndarray
    f2: np.ndarray
    constant: float = 0.0
    handle: object = None

    def expression(self, gram, f1, f2):
        return cp.sum(cp.multiply(self.gram, gram)) + self.f1 @ f1 + self.f2 @ f2 + self.constant

    def evaluate(self, gram, f1, f2):
        return float(np.sum(self.gram * gram) + self.f1 @ f1 + self.f2 @ f2 + self.constant)


def build_problem(n: int, eta: float, rho: float, L1: float = math.inf):
    if n < 1 or not (-1 < rho < 0) or not (eta > max(0, -rho)):
        raise ValueError("Require N>=1, -1<rho<0, eta>max(0,-rho).")
    if not (L1 > 1):
        raise ValueError("L1 must exceed 1 (infinity is permitted).")

    m = n + 2
    d = 2 * m - 1
    eye = np.eye(d)
    zero = np.zeros(d)
    xs = [zero] + [eye[k] for k in range(m - 1)]
    gs = [zero] + [eye[m - 1 + k] for k in range(m - 1)]
    hs = [eye[-1]] + gs[:-1]  # h_(k+1)=g_k encodes every DCA step.
    labels = [f"x{k}" for k in range(1, m)] + [f"g2_{k}" for k in range(1, m)] + ["g1_0"]
    gram = cp.Variable((d, d), symmetric=True, name="Gram")
    # Each function's value at x0 is set to zero by an independent constant shift.
    f1 = cp.Variable(m - 1, name="f1_values_1_to_last")
    f2 = cp.Variable(m - 1, name="f2_values_1_to_last")
    basis_values = [np.zeros(m - 1)] + [np.eye(m - 1)[k] for k in range(m - 1)]
    constraints: list[LinearConstraint] = []
    psd = gram >> 0

    for i in range(m):
        for j in range(m):
            if i == j:
                continue
            dx = xs[i] - xs[j]
            dv = basis_values[i] - basis_values[j]
            A1 = -symouter(hs[j], dx) - 0.5 * np.outer(dx, dx)
            if math.isfinite(L1):
                residual = hs[i] - hs[j] - dx
                A1 -= np.outer(residual, residual) / (2 * (L1 - 1))
            constraints.append(LinearConstraint(f"f1_{i}_{j}", A1, dv, np.zeros(m - 1)))
            residual = gs[i] - gs[j] - rho * dx
            A2 = (-symouter(gs[j], dx) - rho / 2 * np.outer(dx, dx)
                  - np.outer(residual, residual) / (2 * (eta - rho)))
            constraints.append(LinearConstraint(f"f2_{i}_{j}", A2, np.zeros(m - 1), dv))

    for k in range(n + 1):
        step = xs[k] - xs[k + 1]
        constraints.append(LinearConstraint(f"step_{k}", np.outer(step, step),
                                            np.zeros(m - 1), np.zeros(m - 1), -1.0))

    handles = [psd]
    for item in constraints:
        item.handle = item.expression(gram, f1, f2) >= 0
        handles.append(item.handle)
    # F(x0)=0, F(xlast)=f1_last-f2_last.
    problem = cp.Problem(cp.Minimize(f2[-1] - f1[-1]), handles)
    return {"problem": problem, "Gram": gram, "f1": f1, "f2": f2,
            "constraints": constraints, "psd": psd, "xs": xs, "gs": gs,
            "hs": hs, "labels": labels, "m": m, "d": d}


def solve(n: int, eta: float, rho: float, solver: str = "CLARABEL",
          L1: float = math.inf, detailed: bool = True, verbose: bool = False) -> dict:
    model = build_problem(n, eta, rho, L1)
    problem = model["problem"]
    options = {}
    if solver == "CLARABEL":
        options = {"tol_gap_abs": 1e-10, "tol_gap_rel": 1e-10,
                   "tol_feas": 1e-10, "max_iter": 300}
    elif solver == "SCS":
        options = {"eps": 1e-8, "max_iters": 250000}
    started = time.perf_counter()
    value = problem.solve(solver=solver, verbose=verbose, **options)
    elapsed = time.perf_counter() - started
    proposed = proposed_coefficient(n, eta, rho)
    result = {"N": n, "eta": eta, "rho": rho,
              "L1": L1 if math.isfinite(L1) else "infinity",
              "solver": solver, "status": problem.status,
              "elapsed_seconds": elapsed,
              "objective_decrease": None if value is None else float(value),
              "coefficient_numerical": None if value is None else float(2 * value),
              "proposed": proposed,
              "numerical_only": True,
              "initial_gap": "F(x0)-F(x_(N+1)), not F(x0)-F_star",
              "number_of_points": model["m"], "gram_dimension": model["d"],
              "ordered_pair_interpolation": True,
              "generated_at_utc": datetime.now(timezone.utc).isoformat()}
    if problem.status not in {cp.OPTIMAL, cp.OPTIMAL_INACCURATE}:
        return result

    G = np.asarray(model["Gram"].value)
    u, v = np.asarray(model["f1"].value), np.asarray(model["f2"].value)
    items = model["constraints"]
    lambdas = np.array([float(item.handle.dual_value) for item in items])
    primal_residuals = {item.name: item.evaluate(G, u, v) for item in items}
    slack = -sum((lam * item.gram for lam, item in zip(lambdas, items)), start=np.zeros_like(G))
    obj1, obj2 = np.zeros(model["m"] - 1), np.zeros(model["m"] - 1)
    obj1[-1], obj2[-1] = -1, 1
    stationarity1 = obj1 - sum((lam * item.f1 for lam, item in zip(lambdas, items)), start=np.zeros_like(obj1))
    stationarity2 = obj2 - sum((lam * item.f2 for lam, item in zip(lambdas, items)), start=np.zeros_like(obj2))
    lower_bound = -sum(lam * item.constant for lam, item in zip(lambdas, items))
    eigvals, eigvectors = np.linalg.eigh((G + G.T) / 2)
    coordinates = np.diag(np.sqrt(np.maximum(eigvals, 0))) @ eigvectors.T
    result.update({"coefficient_minus_proposed": 2 * float(value) - proposed["coefficient"],
                   "dual_lower_bound_decrease": float(lower_bound),
                   "duality_gap": float(value - lower_bound),
                   "minimum_primal_inequality_residual": min(primal_residuals.values()),
                   "minimum_gram_eigenvalue": float(eigvals.min()),
                   "minimum_dual_multiplier": float(lambdas.min()),
                   "minimum_dual_slack_eigenvalue": float(np.linalg.eigvalsh(slack).min()),
                   "maximum_dual_value_stationarity_error": float(max(abs(stationarity1).max(), abs(stationarity2).max())),
                   "dual_slack_reconstruction_error": float(np.max(abs(slack - np.asarray(model["psd"].dual_value)))),
                   "step_squared_norms": [primal_residuals[f"step_{k}"] + 1 for k in range(n + 1)],
                   "gram_eigenvalues": eigvals.tolist(),
                   "f1_values": [0.0] + u.tolist(), "f2_values": [0.0] + v.tolist(),
                   "dual_multipliers": {item.name: float(lam) for item, lam in zip(items, lambdas)}})
    if detailed:
        result.update({"gram_basis": model["labels"], "Gram": G.tolist(),
                       "dual_slack_matrix": slack.tolist(),
                       "primal_residuals": primal_residuals,
                       "x_coordinates": [(coordinates @ x).tolist() for x in model["xs"]],
                       "g2_coordinates": [(coordinates @ g).tolist() for g in model["gs"]],
                       "g1_coordinates": [(coordinates @ h).tolist() for h in model["hs"]]})
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--N", type=int, default=2)
    parser.add_argument("--eta", type=float, required=True)
    parser.add_argument("--rho", type=float, required=True)
    parser.add_argument("--L1", type=float, default=math.inf)
    parser.add_argument("--solver", choices=["CLARABEL", "SCS"], default="CLARABEL")
    parser.add_argument("--output", type=Path)
    parser.add_argument("--compact", action="store_true")
    parser.add_argument("--verbose", action="store_true")
    args = parser.parse_args()
    result = solve(args.N, args.eta, args.rho, args.solver, args.L1, not args.compact, args.verbose)
    output = json.dumps(result, indent=2, allow_nan=False) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(output)
        print(json.dumps({key: result.get(key) for key in ["N", "eta", "rho", "status", "coefficient_numerical", "coefficient_minus_proposed", "duality_gap"]}))
    else:
        print(output)


if __name__ == "__main__":
    main()
