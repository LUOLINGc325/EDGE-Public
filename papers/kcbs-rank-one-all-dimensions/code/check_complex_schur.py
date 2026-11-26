"""Independent exact audit of the complex path Schur formulas.

The lower-case / doubled symbols stand for independent variables which will be
specialized to a complex number and its conjugate.  Checking an identity before
specialization is stronger than substituting real edge weights.  This script is
an algebraic cross-check, not a replacement for a Lean proof.
"""
import sympy as s
import json
from pathlib import Path

a, aa, b, bb, c, cc, L = s.symbols('a aa b bb c cc L')
x, y, z = a*aa, b*bb, c*cc
P = s.Matrix([[0,a,0,0],[aa,0,b,0],[0,bb,0,c],[0,0,cc,0]])
A = s.eye(4)+P
R = L*s.eye(4)-P
D = (1-x)*(1-z)-y
DL = L**4-(x+y+z)*L**2+x*z
B = s.Matrix([[1-y-z,-a*b*c],[-aa*bb*cc,1-x-y]])/D
C = s.Matrix([[L*(L**2-y-z),a*b*c],[aa*bb*cc,L*(L**2-x-y)]])/DL

checks = {}
checks['complex_path_det_plus'] = s.expand(A.det()-D)==0
checks['complex_path_det_minus'] = s.expand(R.det()-DL)==0
AI,RI = A.inv(),R.inv()
checks['complex_endpoint_inverse_plus'] = all(s.cancel(AI[i,j]-B[r,t])==0
    for r,i in enumerate([0,3]) for t,j in enumerate([0,3]))
checks['complex_endpoint_inverse_minus'] = all(s.cancel(RI[i,j]-C[r,t])==0
    for r,i in enumerate([0,3]) for t,j in enumerate([0,3]))
J = s.diag(1,-1,1,-1)
checks['bipartite_conjugation'] = J*A*J==s.eye(4)-P

# Independent determinant check directly from the two symbolic endpoint blocks.
u=s.symbols('u')
N=u**2*((1-y)*u*(u+2)+(1-y)**2+y*(x+z))-x*y*z
M=(L*B-C).subs(L,1+u)
rhs=(u+2)**2*N/(D*DL.subs(L,1+u))
checks['complex_comparison_determinant'] = s.cancel(M.det()-rhs)==0

assert all(checks.values()),checks
out={'status':'PASS','checks':checks,
     'scope':'Exact symbolic identities for generic complex path entries; scalar inequality and positivity hypotheses are independently required.'}
Path(__file__).with_name('complex_schur_audit.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
