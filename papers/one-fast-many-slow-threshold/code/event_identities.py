#!/usr/bin/env python3
"""Exact symbolic coefficient checks. Not a threshold-policy verifier."""
import json
from pathlib import Path
import sympy as sp
m, y = sp.symbols('m y')
f = lambda dx,dy: sp.Symbol(f'f_{dx}_{dy}')
forms = {
 'L1':[(1,0,1),(0,0,-1)],
 'L2':[(2,0,1),(0,1,1),(1,0,-1),(1,1,-1)],
 'L3':[(0,0,1),(1,1,1),(1,0,-1),(0,1,-1)],
 'L4':[(0,1,1),(0,0,-1)],
 'L5':[(0,0,1),(0,2,1),(0,1,-2)],
 'L6':[(2,0,1),(0,2,1),(1,1,-2)],
 'L7':[(2,0,1),(0,0,1),(1,0,-2)]}
def L(name,dy=0):
 return sum(c*f(dx,yy+dy) for dx,yy,c in forms[name])
def D(dx,dy):
 return (y+dy)*f(dx,dy-1)+(m-y-dy)*f(dx,dy)
identities={
 'L1': y*L('L1',-1)+(m-y)*L('L1'),
 'L2': y*L('L2',-1)+(m-y-1)*L('L2')+L('L7'),
 'L3': y*L('L3',-1)+(m-y-1)*L('L3'),
 'L4': y*L('L4',-1)+(m-y-1)*L('L4'),
 'L5': y*L('L5',-1)+(m-y-2)*L('L5'),
 'L6': y*L('L6',-1)+(m-y-2)*L('L6')+2*L('L2')}
results={}
for name,rhs in identities.items():
 lhs=sum(c*D(dx,dy) for dx,dy,c in forms[name])
 z=sp.expand(lhs-rhs)
 assert z==0,(name,z)
 # At y=0 no symbol from a negative row remains in the actual operator.
 z0=sp.expand(lhs.subs(y,0))
 assert all(not str(s).endswith('_-1') for s in z0.free_symbols)
 results[name]={'symbolic_residual':str(z),'boundary_y0_no_negative_row':True}
results['scope']='Six all-capacity algebraic identities; symbolic equality plus coefficient-domain proof in manuscript. Does not certify Bellman assignment or queue optimality.'
print(json.dumps(results,indent=2))
