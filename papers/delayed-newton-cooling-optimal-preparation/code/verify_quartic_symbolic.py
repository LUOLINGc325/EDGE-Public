#!/usr/bin/env python3
"""Independently expand the method-of-steps branches; no floating arithmetic.

Branch inequalities and root isolation are checked by certificate_tau_9_25.py.
This program checks identities of polynomials, not just sampled values.
"""
from pathlib import Path
import hashlib
import json
import sympy as S

ROOT = Path(__file__).resolve().parent.parent
z, tau, t = S.symbols('z tau t')
w = z**2-z+1-tau
c = -z**2+2*z+2*tau-1

# These are independently expanded branches of E, for t in
# [0,tau], [tau,2tau] and [2tau,3tau], respectively.
E0 = 1-t
E1 = 1-t+(t-tau)**2/2
E2 = E1-(t-2*tau)**3/6
crossing_residual = S.expand(2*E1.subs(t,c+w)-E0.subs(t,c))
amplitude = 2*E1.subs(t,w)-1
balance = S.expand(amplitude+2*E2.subs(t,c+tau+w)-E1.subs(t,c+tau))
expected_general = (18*tau**2-12*tau*z**2+12*tau*z-6*tau+
                    3*z**4-2*z**3-12*z**2+12*z-3)/6
P = 1875*z**4-1250*z**3-10200*z**2+10200*z-1767
general_residual = S.expand(balance-expected_general)
special_residual = S.expand(balance.subs(tau,S.Rational(9,25))-P/3750)
assert crossing_residual == general_residual == special_residual == 0
result = dict(status='passed', arithmetic='exact polynomial arithmetic over rationals',
    sympy_version=S.__version__,
    script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    crossing_identity_residual=str(crossing_residual),
    general_balance_identity_residual=str(general_residual),
    tau_9_25_identity_residual=str(special_residual),
    quartic_coefficients=[int(a) for a in S.Poly(P,z).all_coeffs()],
    limitation='Branch validity, root isolation and the global physical theorem are separate checks/proofs.')
(ROOT/'results/quartic_symbolic_audit.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
