#!/usr/bin/env python3
"""Optional SymPy checks of displayed algebraic identities.

The standard-library finite diagnostics do not require this file or SymPy.
This script checks identities only, not the sign arguments or the stochastic
model.  It does not constitute formal verification.
"""

import argparse
import json
from pathlib import Path

try:
    import sympy as s
except ImportError as error:
    raise SystemExit("Optional dependency SymPy is unavailable. Run exact_diagnostics.py for the standard-library diagnostics.") from error


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=Path(__file__).resolve().parents[1] / "results" / "symbolic_identities.json")
    args = parser.parse_args()
    a, b, c, n, m = s.symbols("a b c n m")
    A = a + n - 1
    B = b + (m - 1) * c
    alpha = a - 1
    beta = b - c
    z = c - 1
    Y = a - b
    X = a * b * z + c * Y
    r = c * (b + 1) / (a + c)
    H = alpha * B + n * beta
    Hn = H - beta
    Hm = H - alpha * c
    t = b * A - n * r * a
    Pn = Y**2 * (b*b*z + 2*b*c) + Y * (2*b**3*z + c*(2*b*b-b-c)) + z*b*(b**3-c)
    Pm = Y**2 * (b*b*z + c*(2*b-c)) + Y * (2*b**3*z + c*(b-c)*(2*b+c)) + z*b*(b**3-c*c)
    k, ell = n - 1, m - 1
    P = c*beta**2*X*k**2 + c*alpha*beta*(c+1)*X*k*ell + c*c*alpha**2*X*ell**2 + c*beta*Pn*k + c*alpha*Pm*ell
    direct_P = X*H*Hm - beta*(a+c)*t*(z*H+c*(Y+z))
    h = t / H
    Lh = (A+m*c)*h - A*h.subs(n,n-1) - (m-1)*c*h.subs(m,m-1)
    u = a/(a+n*c)
    Lu = (A+m*c)*u - A*u.subs(n,n-1) - (m-1)*c*u.subs(m,m-1)
    lower = b/B * (1-n*c/(a+c))
    upper_identity = (a*c*(m-1)*(a-1)+n*a*c*(n-1)*(b*c-a)/(a+c)+c*n*(n-1)*(a-b))/(a+n*c)
    lower_identity = n*c*(c-b)*(a*(m-1)+b*(n-1))/((a+c)*B)
    middle = Pm.subs(a,b) + (1-b)/2*s.diff(Pm,a).subs(a,b)
    M = s.symbols("M")
    product_lower_residual = (A+m*c)*M*b/B - A*((A+c)*M/A)*b/B - (m-1)*c*M*b/(B-c)
    identities = {
        "upper_function_recurrence_residual": Lu - a*c*(c-1)*(n-1)/((a+n*c)*(a+(n-1)*c)),
        "product_lower_function_recurrence_residual": product_lower_residual + (m-1)*c*c*b*M/(B*(B-c)),
        "mixed_upper_comparison": H*u-t-upper_identity,
        "mixed_lower_comparison": H*lower-t-lower_identity,
        "five_term_polynomial_certificate": direct_P-P,
        "rational_function_recurrence_residual": Lh+A*P/((a+c)*H*Hn*Hm),
        "Pn_left_endpoint": Pn.subs(a,b)-b*(b**3-c)*(c-1),
        "Pn_right_endpoint": Pn.subs(a,1)+(b-c)**2,
        "Pm_left_endpoint": Pm.subs(a,b)-b*(b**3-c*c)*(c-1),
        "Pm_right_endpoint": Pm.subs(a,1)+(c+1)*(b-c)**2,
        "Pm_Bernstein_middle": middle+(b-c)*(2*b*b-(b+1)*c*c)/2,
        "two_job_threshold_value": h.subs({n:1,m:1})-a/(a+c),
        "m1_denominator_boundary": Hm.subs(m,1)-beta*A,
    }
    results = []
    for name, expression in identities.items():
        numerator = s.fraction(s.cancel(expression))[0]
        if s.expand(numerator) != 0:
            raise RuntimeError(f"Identity did not reduce to zero: {name}: {s.factor(numerator)}")
        results.append({"identity": name, "cleared_numerator": "0"})
    output = {"schema": "weighted-priority-symbolic-identities-v1", "dependency": {"name": "SymPy", "version": s.__version__},
              "identity_count": len(results), "outcome": "all_listed_algebraic_differences_zero",
              "limitations": "Optional symbolic identity checks only. Nonzero denominators, signs, quantifiers, the stochastic model, and the infinite family of populations are justified in the written proof. No Lean kernel or proof-assistant validation is claimed.",
              "identities": results}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(output, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"output": str(args.output), "identity_count": len(results), "outcome": output["outcome"]}, indent=2))


if __name__ == "__main__":
    main()
