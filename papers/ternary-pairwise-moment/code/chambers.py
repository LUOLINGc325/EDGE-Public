"""Recover all generic dual bases and transitions using rational arithmetic."""
from itertools import combinations, combinations_with_replacement
import sympy as s

x = s.Symbol("x")
cells = list(combinations_with_replacement(range(3), 3))
pairs = list(combinations_with_replacement(range(3), 2))
A = s.Matrix([[t.count(i)*(t.count(j)-(i == j)) for t in cells] for i,j in pairs])
cost = s.Matrix([0 if 0 in t else x**t.count(1) for t in cells])
bases = {}
possible = set()
for B in combinations(range(10), 6):
    M = A[:, B]
    if not M.det():
        continue
    dual = M.T.inv() * cost[list(B), :]
    slack = [s.factor(z) for z in A.T*dual-cost]
    bases[B] = slack
    for j in set(range(10))-set(B):
        if x in slack[j].free_symbols:
            for root in s.Poly(slack[j],x).real_roots():
                if root > 0 and root < 1:
                    possible.add(root)

cuts = [s.Integer(0), *sorted(possible), s.Integer(1)]
def feasible(t):
    return tuple(''.join(str(j) for j in B) for B,S in bases.items()
                 if all(a.subs(x,t) >= 0 for a in S))
print('nonsingular',len(bases),'interior candidate roots',cuts[1:-1])
previous = None
for l,r in zip(cuts,cuts[1:]):
    cur = feasible((l+r)/2)
    if cur != previous:
        print('from',l,'right open',len(cur),','.join(cur))
    previous = cur
for t in cuts:
    print('boundary',t, 'dual bases',len(feasible(t)))
