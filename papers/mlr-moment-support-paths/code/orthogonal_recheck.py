#!/usr/bin/env python3
"""One bounded conditioning recheck of the retained n=12,k=9 LP discrepancy."""
import hashlib
import json
import math
from pathlib import Path
import numpy as np
from scipy.optimize import linprog
import sympy as sp

from verify_certificate import poly

base=Path(__file__).resolve().parents[1] / "results"
source=base/"n12_k9.json"
original=base/"n12_k9_verified.json"
data=json.loads(source.read_text())
first=json.loads(original.read_text())
failed=[entry for entry in first["numerical_checks"] if not entry["numerical_check_passed"]]
assert len(failed)==1
entry=failed[0]
cell=data["regimes"][entry["regime"]]
n,k=data["n"],data["k"]
sample=sp.Rational(cell["sample"])
A=np.array([[math.comb(i,r)/math.comb(n,r) if i>=r else 0.
             for i in range(n+1)] for r in range(k+1)])
Q,R=np.linalg.qr(A.T,mode="reduced")
orthogonal=Q.T
# Compute the target from the positive reference pmf directly, avoiding
# triangular inversion of the poorly conditioned ordinary-moment right side.
reference=np.array([float(math.comb(n,i)*sample**i*(1-sample)**(n-i))
                    for i in range(n+1)])
rhs=orthogonal@reference
c=np.zeros(n+1);c[n]=-1.
result=linprog(c,A_eq=orthogonal,b_eq=rhs,bounds=(0,None),method="highs",
               options={"primal_feasibility_tolerance":1e-9,"dual_feasibility_tolerance":1e-9})
expected=float(poly(cell["objective"]).eval(sample))
error=abs(-result.fun-expected) if result.success else None
residual=float(np.max(np.abs(orthogonal@result.x-rhs))) if result.success else None
report={"n":n,"k":k,"regime":entry["regime"],"sample":str(sample),
        "original_record_preserved":entry,
        "original_report_sha256":hashlib.sha256(original.read_bytes()).hexdigest(),
        "certificate_sha256":hashlib.sha256(source.read_bytes()).hexdigest(),
        "original_matrix_condition_number":float(np.linalg.cond(A)),
        "orthogonal_matrix_condition_number":float(np.linalg.cond(orthogonal)),
        "method":"QR row-space basis, RHS formed from binomial reference masses",
        "lp_success":bool(result.success),"objective_absolute_error":error,
        "moment_residual":residual,
        "passed_original_unchanged_tolerances":bool(result.success and error<2e-7 and residual<2e-8),
        "interpretation":"A single supplementary numerical conditioning check. Original floating-point failure remains recorded; exact certificates are the mathematical acceptance criterion."}
(base/"orthogonal_recheck.json").write_text(json.dumps(report,indent=2)+"\n")
print(json.dumps(report))
