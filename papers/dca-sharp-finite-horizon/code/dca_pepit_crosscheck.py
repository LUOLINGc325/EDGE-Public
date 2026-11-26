#!/usr/bin/env python3
"""Independent PEPit formulation with fixed terminal gap and maximized steps.

This deliberately uses PEPit's function/point/oracle interfaces, unlike the
explicit Gram and linear-constraint construction in dca_pep.py.  It still
produces numerical evidence, not an exact proof.
"""

import argparse
import contextlib
import io
import json
from pathlib import Path

from PEPit import PEP
from PEPit.functions import SmoothStronglyConvexFunction, StronglyConvexFunction
from PEPit.primitive_steps import shifted_optimization_step


def solve(N, eta, rho, solver="SCS"):
    pep = PEP()
    f1 = pep.declare_function(StronglyConvexFunction, mu=1)
    f2 = pep.declare_function(SmoothStronglyConvexFunction, mu=rho, L=eta)
    x0 = pep.set_initial_point()
    initial_value = f1(x0) - f2(x0)
    x = x0
    for k in range(N + 1):
        g2 = f2.gradient(x)
        y, _, _ = shifted_optimization_step(g2, f1)
        pep.set_performance_metric((x - y) ** 2)
        x = y
    terminal_value = f1(x) - f2(x)
    pep.set_initial_condition(initial_value - terminal_value <= 1)
    options = {"eps": 1e-8, "max_iters": 250000} if solver == "SCS" else {"tol_feas": 1e-8, "tol_gap_abs": 1e-8, "tol_gap_rel": 1e-8}
    log = io.StringIO()
    with contextlib.redirect_stdout(log):
        tau = pep.solve(wrapper="cvxpy", solver=solver, verbose=1, **options)
    return {"N": N, "eta": eta, "rho": rho, "solver": solver,
            "maximum_minimum_step_squared_at_gap_1": float(tau),
            "coefficient_numerical": float(2 / tau),
            "formulation": "max-min step squared; F0-Fend<=1; PEPit function interpolation",
            "log": log.getvalue(), "numerical_only": True}


if __name__ == "__main__":
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--N", type=int, required=True)
    p.add_argument("--eta", type=float, required=True)
    p.add_argument("--rho", type=float, required=True)
    p.add_argument("--solver", default="SCS", choices=["SCS", "CLARABEL"])
    p.add_argument("--output", type=Path, required=True)
    a = p.parse_args()
    r = solve(a.N, a.eta, a.rho, a.solver)
    a.output.parent.mkdir(parents=True, exist_ok=True)
    a.output.write_text(json.dumps(r, indent=2) + "\n")
    print(json.dumps({k: v for k, v in r.items() if k != "log"}))
