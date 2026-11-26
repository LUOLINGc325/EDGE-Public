#!/usr/bin/env python3
"""Independent symbolic audit: roots are reconstructed by eigendecomposition.
This validates the mathematical instance, not the Lean kernel or proof coverage.
"""
from pathlib import Path
import hashlib
import itertools
import json
import sympy as sp

Q = sp.Rational
I = sp.eye(2)
ZERO = sp.zeros(2)
E = [Q(8, 15)*I, sp.diag(Q(7, 15), Q(7, 240)), sp.diag(0, Q(7, 16))]
F = [sp.diag(Q(3, 4), 0), sp.Matrix([[Q(1, 8), Q(1, 4)], [Q(1, 4), Q(1, 2)]]), sp.Matrix([[Q(1, 8), -Q(1, 4)], [-Q(1, 4), Q(1, 2)]])]
C = [E[0]+E[1], E[2]]

def check(v, message):
    if not bool(v):
        raise RuntimeError(message)

def matrix_zero(m):
    return all(sp.simplify(x)==0 for x in m)

def spectral_sqrt(m):
    check(m == m.conjugate().T, 'Hermitian effect')
    ans = sp.zeros(2)
    for eigenvalue, multiplicity, basis in m.eigenvects():
        check(eigenvalue >= 0, 'PSD effect')
        check(len(basis) == multiplicity, 'complete Hermitian spectral basis')
        # The only degenerate effect here is scalar, and SymPy returns the
        # orthogonal standard basis; check rather than silently assuming it.
        for u, v in itertools.combinations(basis, 2):
            check((u.conjugate().T*v)[0] == 0, 'orthogonal spectral basis')
        for v in basis:
            ans += sp.sqrt(eigenvalue)*(v*v.conjugate().T)/(v.conjugate().T*v)[0]
    ans = sp.simplify(ans)
    check(matrix_zero(ans*ans-m), 'root squares to effect')
    check(ans == ans.conjugate().T, 'Hermitian root')
    check(all(x >= 0 for x in ans.eigenvals()), 'positive root')
    return ans

for name, effects in [('E',E),('F',F),('C',C)]:
    check(sum(effects, sp.zeros(2)) == I, f'{name} normalized')
roots = {name:[spectral_sqrt(m) for m in effects] for name,effects in [('E',E),('F',F),('C',C)]}


def score_audit(name, effects):
    records_x, records_y, indexed = [], [], []
    for a, ea in enumerate(effects):
        for b, fb in enumerate(F):
            x = sp.simplify(roots[name][a]*fb*roots[name][a])
            y = sp.simplify(roots['F'][b]*ea*roots['F'][b])
            records_x.append(x); records_y.append(y)
            delta = sp.simplify(x-y)
            check(delta == delta.T and all(v.is_real for v in delta), 'real symmetric difference')
            check(sp.trace(delta)==0, 'traceless difference')
            if not matrix_zero(delta):
                indexed.append(((a,b),delta))
    check(sum(records_x,sp.zeros(2)) == I, 'AB normalized joint POVM')
    check(sum(records_y,sp.zeros(2)) == I, 'BA normalized joint POVM')
    events = []
    for mask in itertools.product([0,1],repeat=len(indexed)):
        h = sum((m for bit,(_,m) in zip(mask,indexed) if bit), sp.zeros(2))
        squared = sp.simplify(-h.det())
        check(squared>=0, 'nonnegative spectral radius squared')
        check(h*h == squared*I, 'event spectrum identity')
        events.append((squared,mask,h))
    best,mask,h=max(events,key=lambda x:x[0])
    score=sp.sqrt(best)
    rho=sp.simplify((I+h/score)/2)
    check(sp.simplify(sp.trace(rho)-1)==0 and matrix_zero(rho*rho-rho), 'maximizer trace and purity')
    check(all(v>=0 for v in rho.eigenvals()), 'maximizer PSD')
    direct_tv=sp.simplify(sum(sp.Abs(sp.trace(rho*m)) for _,m in indexed)/2)
    check(sp.simplify(direct_tv-score)==0,'direct full-record TV equals event maximum')
    return {'nonzero_records':[{'index':list(index),'matrix':[[str(m[i,j]) for j in range(2)] for i in range(2)]} for index,m in indexed], 'all_event_squared_values':sorted(set(str(v[0]) for v in events)), 'maximum_event_squared':str(best), 'exact_score':str(score), 'attaining_state':[[str(rho[i,j]) for j in range(2)] for i in range(2)],'direct_tv_at_attaining_state':str(direct_tv)}, score

fine, tf = score_audit('E',E)
coarse, tc = score_audit('C',C)
check(sp.simplify(tf-7*sp.sqrt(5)/160)==0,'fine target exact value')
check(tc==Q(9,80),'coarse target exact value')
check(tc**2-tf**2==Q(79,25600),'strict squared-score separation')
a,u,v,x,z = sp.symbols('a u v x z',real=True)
rho=sp.Matrix([[a,u+sp.I*v],[u-sp.I*v,1-a]])
h=sp.Matrix([[z,x],[x,-z]])
check(sp.simplify(sp.trace(rho*h)-(2*u*x+(2*a-1)*z))==0,'complex expectation identity')
check(sp.expand(1-(2*u)**2-(2*a-1)**2-4*(rho.det()+v*v))==0,'PSD determinant to real Bloch disk identity')
result={'verification':'independent symbolic reconstruction using positive spectral square roots','arithmetic':'exact SymPy algebra; no numerical optimizer','sympy_version':sp.__version__,'fine':fine,'coarse':coarse,'squared_gap':'79/25600','complex_state_algebra':'tr(rho H)=2u x+(2a-1)z; 1-(2u)^2-(2a-1)^2=4(det(rho)+v^2)','status':'instance arithmetic and mathematical optimizer witnesses pass; Lean/source semantic coverage separately required'}
print(json.dumps(result,ensure_ascii=False,indent=2))
