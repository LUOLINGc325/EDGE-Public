#!/usr/bin/env python3
"""Reconstruct the finite-job dimension positivity certificate exactly.

This is polynomial identity/positive-coefficient verification, not a grid test.
The surrounding derivative and branch-continuity argument is in the manuscript.
"""
from __future__ import annotations

import argparse
import json
from pathlib import Path
import sympy as sp


def certificate() -> dict:
    R, a, H, theta, v, b = sp.symbols('R a H theta v b')
    s, c = (R - 2) * H, R + 2
    numerator = ((R + 1) * (s + c) * (s + 2) * (s + c * a + 2)
                 - R * (s + c + 2) * s * ((R - 1) * H + (R + 1) * a))
    polynomial = sp.Poly(sp.expand(numerator.subs(H, (R + 1) * (a + theta))
                                  .subs(R, v + 2).subs(a, b + 1)), theta)
    assert polynomial.degree() == 3
    coefficients = [sp.expand(sum(polynomial.nth(i) * sp.binomial(k, i)
                                 / sp.binomial(3, i) for i in range(k + 1)))
                    for k in range(4)]
    reconstruction = sum(coefficients[k] * sp.binomial(3, k)
                         * theta**k * (1 - theta)**(3 - k) for k in range(4))
    assert sp.expand(reconstruction - polynomial.as_expr()) == 0
    records = []
    for k, expression in enumerate(coefficients):
        terms = sp.Poly(expression, b, v)
        assert all(coefficient >= 0 for coefficient in terms.coeffs())
        constant = terms.coeff_monomial(1)
        assert constant > 0
        records.append({'index': k, 'factorized': str(sp.factor(expression)),
                        'all_monomial_coefficients_nonnegative': True,
                        'strictly_positive_constant': str(constant),
                        'number_of_nonzero_monomials': len(terms.terms())})
    return {'status': 'exact_identity_and_positivity_passed',
            'arithmetic': 'rational polynomial identity in SymPy',
            'domain': 'v >= 0, b >= 0, 0 <= theta <= 1',
            'substitution': 'R=v+2, a=b+1, H=(R+1)*(a+theta)',
            'reconstruction_difference': '0', 'coefficients': records,
            'scope': 'Appendix A positivity identity only; not the continuous scheduling theorem'}


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path)
    options = parser.parse_args()
    text = json.dumps(certificate(), indent=2, sort_keys=True) + '\n'
    if options.output:
        options.output.parent.mkdir(parents=True, exist_ok=True)
        options.output.write_text(text)
    else:
        print(text, end='')
