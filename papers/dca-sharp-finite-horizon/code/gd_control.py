#!/usr/bin/env python3
"""Auxiliary gradient-descent SDP for examining certificate lifting.

The Gram basis is d_0,...,d_N, x_0=0, x_k=-sum_{t<k}d_t, and
g2_k=x_k-d_k.  Thus f1(x)=||x||^2/2 and grad(phi)(x_k)=d_k.
Only f2 data at points 0,...,N are interpolated in curvature [rho,eta].
Minimize phi(x0)-phi(xN)+(1+rho)||d_N||^2/2 subject to ||d_k||^2>=1.
This is an auxiliary control problem, not a claim of full DCA realizability.
"""

import argparse
import json
from pathlib import Path
import time

import cvxpy as cp
import numpy as np

from dca_pep import symouter, proposed_coefficient


def solve(N, eta, rho, solver="CLARABEL"):
    m = N + 1
    steps = np.eye(m)
    xs = [np.zeros(m)] + [-sum(steps[:k]) for k in range(1, m)]
    gs = [x - d for x, d in zip(xs, steps)]
    values = [np.zeros(N)] + [np.eye(N)[k] for k in range(N)]
    G = cp.Variable((m, m), symmetric=True, name="step_Gram")
    v = cp.Variable(N, name="f2_values")
    psd = G >> 0
    constraints = [psd]
    data = []

    for i in range(m):
        for j in range(m):
            if i == j:
                continue
            dx = xs[i] - xs[j]
            dg = gs[i] - gs[j] - rho * dx
            A = -symouter(gs[j], dx) - rho / 2 * np.outer(dx, dx) - np.outer(dg, dg) / (2 * (eta - rho))
            b = values[i] - values[j]
            h = cp.sum(cp.multiply(A, G)) + b @ v >= 0
            constraints.append(h)
            data.append((f"f2_{i}_{j}", A, b, 0.0, h))
    for i, d in enumerate(steps):
        A = np.outer(d, d)
        h = cp.sum(cp.multiply(A, G)) >= 1
        constraints.append(h)
        data.append((f"step_{i}", A, np.zeros(N), -1.0, h))

    A_obj = -np.outer(xs[-1], xs[-1]) / 2 + (1 + rho) / 2 * np.outer(steps[-1], steps[-1])
    b_obj = values[-1]
    objective = cp.sum(cp.multiply(A_obj, G)) + b_obj @ v
    problem = cp.Problem(cp.Minimize(objective), constraints)
    opts = ({"tol_gap_abs": 1e-10, "tol_gap_rel": 1e-10, "tol_feas": 1e-10, "max_iter": 300}
            if solver == "CLARABEL" else {"eps": 1e-9, "max_iters": 250000})
    t0 = time.perf_counter()
    answer = problem.solve(solver=solver, **opts)
    out = {"N": N, "eta": eta, "rho": rho, "solver": solver,
           "status": problem.status, "elapsed_seconds": time.perf_counter() - t0,
           "auxiliary_objective": float(answer), "coefficient_numerical": float(2 * answer),
           "proposed": proposed_coefficient(N, eta, rho), "numerical_only": True,
           "scope": "quadratic-f1 GD control; only points 0,...,N; endpoint penalty"}
    if problem.status not in {cp.OPTIMAL, cp.OPTIMAL_INACCURATE}:
        return out
    g = np.asarray(G.value)
    f = np.asarray(v.value)
    multipliers = {name: float(h.dual_value) for name, A, b, c, h in data}
    slack = A_obj - sum((multipliers[name] * A for name, A, b, c, h in data), start=np.zeros_like(g))
    stationarity = b_obj - sum((multipliers[name] * b for name, A, b, c, h in data), start=np.zeros(N))
    bound = -sum(multipliers[name] * c for name, A, b, c, h in data)
    residuals = {name: float(np.sum(A * g) + b @ f + c) for name, A, b, c, h in data}
    out.update({"coefficient_minus_proposed": float(2 * answer - out["proposed"]["coefficient"]),
                "dual_bound": float(bound), "duality_gap": float(answer - bound),
                "Gram": g.tolist(), "gram_basis": [f"d_{k}" for k in range(m)],
                "f2_values": [0.0] + f.tolist(),
                "dual_multipliers": multipliers, "dual_slack_matrix": slack.tolist(),
                "minimum_gram_eigenvalue": float(np.linalg.eigvalsh(g).min()),
                "minimum_dual_slack_eigenvalue": float(np.linalg.eigvalsh(slack).min()),
                "maximum_dual_stationarity_error": float(np.max(abs(stationarity))),
                "dual_slack_reconstruction_error": float(np.max(abs(slack - np.asarray(psd.dual_value)))),
                "minimum_primal_residual": min(residuals.values()), "primal_residuals": residuals})
    return out


if __name__ == "__main__":
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--N", type=int, required=True)
    p.add_argument("--eta", type=float, required=True)
    p.add_argument("--rho", type=float, required=True)
    p.add_argument("--solver", default="CLARABEL", choices=["CLARABEL", "SCS"])
    p.add_argument("--output", type=Path, required=True)
    a = p.parse_args()
    r = solve(a.N, a.eta, a.rho, a.solver)
    a.output.parent.mkdir(parents=True, exist_ok=True)
    a.output.write_text(json.dumps(r, indent=2) + "\n")
    print(json.dumps({k:r.get(k) for k in ["N","eta","rho","status","coefficient_numerical","coefficient_minus_proposed","duality_gap"]}))
