#!/usr/bin/env python3
"""Exact selected-instance checks of the proved high-fidelity polynomial family.

Uses the polynomial integrator to check the beta-derived closed moments. This
is a consistency check, not an independent proof or a proof of the limit.
"""
import argparse
from fractions import Fraction as F
import json
from pathlib import Path
from exact_moments import Poly, integrate, density


def main():
    if not __debug__:
        raise SystemExit('Verification requires assertions; do not use python -O.')
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    x = [Poly.var(4, j) for j in range(4)]
    q = x[0]**2 + x[1]**2
    u = x[0]*x[2] - x[1]*x[3]
    v = x[0]*x[2] + x[1]*x[3]
    records = []
    checks = 0
    for m in [3, 4, 5, 8, 12, 16, 24, 32]:
        raw = (1+x[0])**m
        Z = integrate(raw)
        assert Z > 0
        g = raw * (1/Z)
        qg = F(m*m+3*m+6, (m+3)*(m+4))
        assert integrate(g) == 1
        assert integrate(g*x[0]) == F(m,m+3)
        assert integrate(g*x[0]**2) == F(m*m+m+3,(m+3)*(m+4))
        assert integrate(g*q) == qg
        assert integrate(g*u) == integrate(g*v) == 0
        checks += 6
        eps = F(1,m+1)
        expected_q = (1-eps)*qg + eps*F(13,24)
        values = {}
        for k in ['A_mode','B_mode']:
            f = g*(1-eps) + density(x,k)*eps
            assert integrate(f) == 1
            assert [integrate(f*z) for z in x] == [(1-eps)*F(m,m+3)+eps/F(16),F(0),F(0),F(0)]
            assert integrate(f*q) == expected_q
            assert integrate(f*v) == eps*F(5,1152)
            assert integrate(f*u) == (1 if k=='A_mode' else -1)*eps*F(5,1152)
            checks += 5
            predicted = expected_q**2+(1-expected_q)**2
            actual = predicted-2*integrate(f*u)*integrate(f*v)
            assert F(1,2) < actual < expected_q < 1
            assert actual-predicted == (-1 if k=='A_mode' else 1)*F(25,663552*(m+1)**2)
            checks += 2
            values[k] = {'q':str(expected_q),'composed':str(actual),'discrepancy':str(actual-predicted)}
        records.append({'m':m,'Z_m':str(Z),'laws':values})
    result={'status':'passed','checks':checks,'instances':records,
            'scope':'Selected exact polynomial moments agree with the analytic beta-integral family; not all-m Lean formalization.'}
    text=json.dumps(result,indent=2)+'\n'
    if args.output: args.output.write_text(text,encoding='utf-8')
    print(text,end='')


if __name__=='__main__':
    main()
