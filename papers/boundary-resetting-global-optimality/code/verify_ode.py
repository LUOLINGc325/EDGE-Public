#!/usr/bin/env python3
"""Finite numerical diagnostics for the analytic theorem; not a proof.

Integrate independent initial-value equations on each constant-rate segment.
The separate independent_fd.py solves the original backward boundary problem.
"""
from __future__ import annotations

import argparse
import json
import platform
from pathlib import Path

import numpy as np
import scipy
from scipy.integrate import solve_ivp
from scipy.special import roots_jacobi, gammaln

ROOT = Path(__file__).resolve().parents[1]


class Half:
    def __init__(self, edges, rates):
        self.edges = np.asarray(edges, dtype=float)
        self.rates = np.asarray(rates, dtype=float)
        if len(self.edges) != len(self.rates) + 1 or self.edges[0] != 0 or self.edges[-1] != 1:
            raise ValueError("Invalid half-interval partition")
        if np.any(np.diff(self.edges) <= 0) or np.any(self.rates < 0):
            raise ValueError("Rates must be nonnegative on a strict partition")
        # State: s, s', k, k', integral(s), integral(k).
        state = np.array([0., 1., 0., 0., 0., 0.])
        self.solutions = []
        for left, right, rate in zip(self.edges[:-1], self.edges[1:], self.rates):
            def rhs(x, y):
                return [y[1], rate*y[0], y[3], rate*y[2]+1., y[0], y[2]]
            sol = solve_ivp(rhs, (left, right), state, method="DOP853",
                            rtol=3e-12, atol=2e-14, dense_output=True)
            if not sol.success:
                raise RuntimeError(sol.message)
            state = sol.y[:, -1]
            self.solutions.append(sol.sol)
        self.A = float(state[2]/state[0])
        self.B = float(state[4])
        self.C = float(state[5])

    def evaluate(self, x):
        x = np.asarray(x, dtype=float)
        flat = x.reshape(-1)
        if np.any((flat < 0) | (flat > 1)):
            raise ValueError("Evaluation outside [0,1]")
        idx = np.minimum(np.searchsorted(self.edges[1:], flat, side="right"), len(self.rates)-1)
        out = np.empty((6, len(flat)))
        for j, sol in enumerate(self.solutions):
            mask = idx == j
            if np.any(mask):
                out[:, mask] = sol(flat[mask])
        return out.reshape((6,)+x.shape)

    def weighted_rate_integral(self):
        def primitive(x):
            return x**3/3 - x**4/2 + x**5/5
        return float(sum(r*(primitive(b)-primitive(a))
                         for a,b,r in zip(self.edges[:-1], self.edges[1:], self.rates)))


def tau(plus, minus, x):
    vp, vm = plus.evaluate(x), minus.evaluate(x)
    return minus.A*vp[0]+vp[2], plus.A*vm[0]+vm[2]


def beta_baseline(beta):
    first = np.exp(gammaln(beta+0.5)-gammaln(beta+1)-0.5*np.log(np.pi))
    return float((first + 1/(2*beta+1))/2)


def beta_cost(plus, minus, beta, order=320):
    # y = x^2 has Beta(1/2,beta) law. Jacobi rule treats endpoint singularities.
    z, w = roots_jacobi(order, beta-1, -0.5)
    x = np.sqrt((z+1)/2)
    tp, tm = tau(plus, minus, x)
    return float(np.dot(w, (tp+tm)/2)/sum(w))


def radial_power_cost(plus, minus, power, order=320):
    z, w = roots_jacobi(order, 0, power)
    x = (z+1)/2
    tp, tm = tau(plus, minus, x)
    return float(np.dot(w, (tp+tm)/2)/sum(w))


def profiles():
    rows = [
        ("zero", [0,1], [0], [0]),
        ("constant_one", [0,1], [1], [1]),
        ("constant_asymmetric", [0,1], [0], [8]),
        ("opposite_bands", [0,.25,.5,.75,1], [0,4,0,0], [0,0,0,4]),
        ("boundary_band", [0,.75,.875,1], [0,1,0], [0,1,0]),
        ("narrow_peak", [0,.37,.39,1], [0,50,0], [0,0,0]),
    ]
    rng = np.random.default_rng(20261124)
    for j in range(24):
        rates = np.exp(rng.uniform(np.log(.02), np.log(15), (2,6)))
        rates[rng.random((2,6)) < .35] = 0
        rows.append((f"seeded_asymmetric_{j:02d}", np.linspace(0,1,7).tolist(),
                     rates[0].tolist(), rates[1].tolist()))
    return rows


def run():
    records = []
    worst_support_residual = 0.
    for name, edges, rp, rm in profiles():
        plus, minus = Half(edges,rp), Half(edges,rm)
        exact_ivp_uniform = .5*(plus.C+minus.C+minus.A*plus.B+plus.A*minus.B)
        support = (plus.weighted_rate_integral()+minus.weighted_rate_integral())/8
        residual = exact_ivp_uniform-5/12-support
        worst_support_residual = min(worst_support_residual, residual)
        if residual < -2e-10:
            raise AssertionError((name, "uniform supporting bound", residual))
        if min(plus.A*plus.B, minus.A*minus.B) < .25-2e-11:
            raise AssertionError((name, "Holder product"))
        values = {}
        for beta in [.25,.5,1.,2.]:
            value = beta_cost(plus,minus,beta)
            baseline = beta_baseline(beta)
            values[f"beta_{beta:g}"] = {"cost":value,"baseline":baseline,"gap":value-baseline}
            if beta <= 1 and value-baseline < -2e-7:
                raise AssertionError((name,beta,value-baseline))
        for power in [1,4]:
            value = radial_power_cost(plus,minus,power)
            baseline = .5*((power+1)/(power+2)+(power+1)/(power+3))
            values[f"radial_power_{power}"] = {"cost":value,"baseline":baseline,"gap":value-baseline}
            if value-baseline < -2e-7:
                raise AssertionError((name,power,value-baseline))
        records.append({"name":name,"edges":list(edges),"rates_plus":list(rp),"rates_minus":list(rm),
                        "A_plus":plus.A,"A_minus":minus.A,"AB_plus":plus.A*plus.B,
                        "AB_minus":minus.A*minus.B,"uniform_cost_ivp":exact_ivp_uniform,
                        "uniform_gap":exact_ivp_uniform-5/12,"support_lower_bound":support,
                        "support_residual":residual,"targets":values})
    # Convergence comparison concerns a real quadrature risk: piecewise rates.
    name, edges, rp, rm = profiles()[3]
    plus,minus = Half(edges,rp),Half(edges,rm)
    convergence = {str(n):{str(b):beta_cost(plus,minus,b,n) for b in [.25,.5,1,2]}
                   for n in [160,320,640]}
    max_last_change = max(abs(convergence["640"][str(b)]-convergence["320"][str(b)])
                          for b in [.25,.5,1,2])
    if max_last_change > 2e-6:
        raise AssertionError(("quadrature convergence",max_last_change))
    return {"status":"passed", "scope":"finite floating-point diagnostics; not a continuum proof",
            "environment":{"python":platform.python_version(),"numpy":np.__version__,"scipy":scipy.__version__},
            "profile_count":len(records),"weighted_cost_checks":6*len(records),
            "worst_support_residual":worst_support_residual,
            "quadrature_convergence_case":name,"quadrature_convergence":convergence,
            "max_320_to_640_change":max_last_change,"profiles":records}


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--output",type=Path,default=ROOT/"results"/"ode_checks.json")
    args=parser.parse_args()
    result=run()
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps({k:v for k,v in result.items() if k not in {"profiles","quadrature_convergence"}},indent=2))


if __name__=="__main__":
    main()
