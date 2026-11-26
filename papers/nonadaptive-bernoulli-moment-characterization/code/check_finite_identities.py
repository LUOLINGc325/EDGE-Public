#!/usr/bin/env python3
"""Exact finite checks for the paper. These are not proofs of infinite claims.

Only Python's standard library is used. Run from any working directory.
The deterministic JSON result records what was checked and what was not.
"""
from fractions import Fraction as Q
from math import comb
from pathlib import Path
import json


def add(a, b):
    c = [Q(0)] * max(len(a), len(b))
    for i, x in enumerate(a):
        c[i] += x
    for i, x in enumerate(b):
        c[i] += x
    while len(c) > 1 and c[-1] == 0:
        c.pop()
    return c


def scale(a, t):
    return [t * x for x in a]


def mul(a, b):
    c = [Q(0)] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            c[i + j] += x * y
    return c


def shifted_chebyshev(m):
    if m == 0:
        return [Q(1)]
    prev, cur = [Q(1)], [Q(-1), Q(2)]
    for _ in range(1, m):
        prev, cur = cur, add(mul([Q(-2), Q(4)], cur), scale(prev, -1))
    return cur


def bernstein_coeff(p, n, k):
    assert n >= len(p) - 1
    return sum((p[j] * Q(comb(k, j), comb(n, j))
                for j in range(min(k, len(p) - 1) + 1)), Q(0))


def elevate(coeff, n, k):
    m = len(coeff) - 1
    assert 0 <= k <= n and m <= n
    return sum((Q(comb(m, i) * comb(n-m, k-i), comb(n, k)) * coeff[i]
                for i in range(max(0, k-(n-m)), min(m, k)+1)), Q(0))


def binomial_weight(n, k, x):
    return comb(n, k) * x**k * (1-x)**(n-k)


def check_stability():
    rows = []
    for m in range(1, 9):
        p = shifted_chebyshev(m)
        n = 20 * m*m  # 20 > 2*pi^2; this finite check uses exact rationals.
        coeff = [bernstein_coeff(p, n, k) for k in range(n+1)]
        largest = max(map(abs, coeff))
        assert largest <= 2
        rows.append({"degree": m, "budget": n, "max_abs_coefficient": str(largest)})
    return rows


def check_signed_mixture():
    delta = Q(1, 1024)
    target = add([Q(1, 2)], scale(shifted_chebyshev(4), delta))
    w1, w2 = 8*delta, 4*delta
    w0 = 1-w1-w2
    branches = [(w0, 320, [Q(1, 2)]), (w1, 80, [Q(1, 2)]),
                (w2, 320, add([Q(1, 2)], scale(shifted_chebyshev(4), Q(1, 4))))]
    result = [Q(0)]
    for weight, budget, poly in branches:
        assert all(0 <= bernstein_coeff(poly, budget, k) <= 1 for k in range(budget+1))
        result = add(result, scale(poly, weight))
    assert result == target
    return {"weights": [str(b[0]) for b in branches],
            "budgets": [b[1] for b in branches],
            "target_power_coefficients": list(map(str, target)),
            "mean_one_plus_budget": str(sum(w*(1+n) for w, n, _ in branches)),
            "identity": "exact equality of all power-basis coefficients"}


def check_hypergeometric_and_jensen():
    k0, top = 3, 9
    # Lower polynomials g_m(x)=1/4+x^2/4-1/(8(m+1)), m>=2.
    # Their elevations are ordered, and the target is strictly interior.
    def coeff(m, k):
        return Q(1, 4) + Q(k*(k-1), 4*m*(m-1)) - Q(1, 8*(m+1))
    a = {m: [coeff(m, k) for k in range(m+1)] for m in range(k0-1, top+1)}
    pmf = {l: Q(1, l*l) for l in range(k0, top+1)}
    total = sum(pmf.values())
    pmf = {l: p/total for l, p in pmf.items()}
    tails = {m: sum(pmf[l] for l in range(m, top+1)) for m in range(k0, top+1)}
    rows, states = [], 0
    for x in [Q(0), Q(1, 5), Q(1, 2), Q(4, 5), Q(1)]:
        mean = moment = upper = Q(0)
        for l, prob_l in pmf.items():
            for s in range(l+1):
                y = {m: elevate(a[m], l, s) for m in range(k0-1, l+1)}
                assert 0 <= y[k0-1] <= y[l] <= 1
                inc = {m: y[m]-y[m-1] for m in range(k0, l+1)}
                assert all(d >= 0 for d in inc.values())
                psi = y[k0-1] + sum(inc[m]/tails[m] for m in inc)
                bound = y[k0-1] + sum(inc[m]/tails[m]**2 for m in inc)
                assert psi*psi <= bound
                # Abel identity with terminal deficit d_l=0.
                d = {m: y[l]-y[m] for m in range(k0-1, l+1)}
                abel = y[l] + sum((1/tails[m+1]-1/tails[m])*d[m]
                                  for m in range(k0, l))
                assert psi == abel
                weight = prob_l * binomial_weight(l, s, x)
                mean += weight*psi
                moment += weight*psi*psi
                upper += weight*bound
                states += 1
        expected = Q(1, 4)+x*x/4-Q(1, 8*(top+1))
        assert mean == expected  # Truncated L gives g_top, not the infinite target f.
        theoretical = Q(1, 4)+x*x/4-Q(1, 8*k0)
        theoretical += sum(Q(1, 8*m*(m+1))/tails[m] for m in range(k0, top+1))
        assert upper == theoretical and moment <= upper
        rows.append({"x": str(x), "mean": str(mean), "second_moment": str(moment),
                     "jensen_upper": str(upper)})
    return {"finite_truncation": [k0, top], "states_checked": states, "rows": rows}


def check_frequency_bands():
    rows = []
    for M in range(1, 6):
        J = 1
        while 2**J <= 4*M:
            J += 1
        # Laurent coefficients of sin(theta)^(2M) and cos(2^j theta).
        sine = {2*M-2*a: Q((-1)**(M+a)*comb(2*M, a), 2**(2*M))
                for a in range(2*M+1)}
        summed = {}
        for j in range(J, J+4):
            amplitude = Q(1, 2**(2*j)*j)  # alpha=2, beta=1, eta suppressed.
            for freq, value in sine.items():
                for sign in [-1, 1]:
                    t = freq + sign*2**j
                    summed[t] = summed.get(t, Q(0)) + amplitude*value/2
        for ell in range(J, J+4):
            frequency = 2**ell+2*M
            observed_cosine = 2*summed[frequency]
            expected_cosine = Q((-1)**M, 2**(2*M+2*ell)*ell)
            assert observed_cosine == expected_cosine
        rows.append({"M": M, "J": J, "bands_checked": 4})
    return rows


def main():
    report = {"status": "pass", "arithmetic": "Python fractions.Fraction, exact rationals",
              "stability_examples": check_stability(),
              "signed_mixture": check_signed_mixture(),
              "hypergeometric_jensen_abel": check_hypergeometric_and_jensen(),
              "critical_frequency_bands": check_frequency_bands(),
              "scope": "Finite examples and algebraic identities only; not an infinite-dimensional proof or Lean verification."}
    path = Path(__file__).resolve().parents[1]/"results"/"finite_checks.json"
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(report, indent=2, ensure_ascii=False)+"\n", encoding="utf-8")
    print(json.dumps({"status": "pass", "output": str(path),
                      "states": report["hypergeometric_jensen_abel"]["states_checked"]}))


if __name__ == "__main__":
    main()
