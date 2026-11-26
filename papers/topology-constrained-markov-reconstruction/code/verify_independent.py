#!/usr/bin/env python3
"""Independent exact checks of sparse-generator commutator classification.
No claimed proof by testing: this audits the finite algebra used by the proof.
"""
import itertools, json, math
from pathlib import Path
import sympy as sp

ROOT=Path(__file__).resolve().parents[1]
(ROOT/'results').mkdir(parents=True,exist_ok=True)

def connected(n,adj):
    seen={0};todo=[0]
    while todo:
        for v in adj[todo.pop()]:
            if v not in seen: seen.add(v);todo.append(v)
    return len(seen)==n

def eligible(n,edges):
    adj=[set() for _ in range(n)]
    for u,v in edges: adj[u].add(v);adj[v].add(u)
    if not connected(n,adj):return None
    for u in range(n):
        for v in range(u+1,n):
            common=adj[u]&adj[v]
            if (v in adj[u] and common) or len(common)>1:return None
    return adj

def ratio_components(n,edges,adj):
    arcs=[a for u,v in edges for a in [(u,v),(v,u)]]
    parent={a:a for a in arcs}
    def find(x):
        while parent[x]!=x:parent[x]=parent[parent[x]];x=parent[x]
        return x
    def union(x,y):parent[find(x)]=find(y)
    for v in range(n):
        for u,w in itertools.permutations(adj[v],2):union((u,v),(v,w))
    raw=len({find(a) for a in arcs})
    for u in range(n):
        if len(adj[u])==1:
            v=next(iter(adj[u]));union((u,v),(v,u))
    leaf=len({find(a) for a in arcs})
    return raw,leaf

counts={};tests=0
for n in range(2,7):
    possible=list(itertools.combinations(range(n),2));count=cyc=0
    for mask in range(1<<len(possible)):
        if mask.bit_count()<n-1:continue
        edges=[e for k,e in enumerate(possible) if mask>>k&1]
        adj=eligible(n,edges)
        if adj is None:continue
        count+=1;is_cycle=all(len(x)==2 for x in adj);cyc+=is_cycle
        raw,leaf=ratio_components(n,edges,adj)
        assert leaf==(2 if is_cycle else 1),(n,edges,raw,leaf)
        tests+=1
    counts[n]={'connected_girth_at_least_5_labelled_graphs':count,'cycles':cyc}

# Symbolic independent cycle calculation, n=5. Define each entry explicitly,
# keeping all a_i,b_i independent. SymPy computes the full commutator.
n=5
alpha,beta=sp.symbols('alpha beta',real=True)
a=sp.symbols('a0:'+str(n),positive=True);b=sp.symbols('b0:'+str(n),positive=True)
Q=sp.zeros(n);R=sp.zeros(n)
for i in range(n):
    Q[i,(i+1)%n]=a[i];Q[i,(i-1)%n]=b[i];Q[i,i]=-a[i]-b[i]
    R[i,(i+1)%n]=alpha*a[i];R[i,(i-1)%n]=beta*b[i];R[i,i]=-alpha*a[i]-beta*b[i]
C=Q*R-R*Q
for i in range(n):
    assert sp.expand(C[i,(i+1)%n]-(alpha-beta)*a[i]*(b[(i+1)%n]-b[i]))==0
    assert sp.expand(C[i,(i-1)%n]-(alpha-beta)*b[i]*(a[i]-a[(i-1)%n]))==0
    assert sp.expand(C[i,i]-(beta-alpha)*(a[i]*b[(i+1)%n]-b[i]*a[(i-1)%n]))==0
    assert C[i,(i+2)%n]==0 and C[i,(i-2)%n]==0

# Exact trigonometric phase certificate for an alias with simple sampled P on C6.
# Delta=1, a=3*pi/sqrt(3), b=pi/(2*sqrt(3)), a'=a-2*pi/sqrt(3), b'=b+2*pi/sqrt(3).
c=sp.pi/sp.sqrt(3);a0=3*c;b0=c/2;a1=c;b1=sp.Rational(5,2)*c
phases=[];eigen=[]
for k in range(6):
    theta=2*sp.pi*k/6
    l0=sp.simplify((a0+b0)*(sp.cos(theta)-1)+sp.I*(a0-b0)*sp.sin(theta))
    l1=sp.simplify((a1+b1)*(sp.cos(theta)-1)+sp.I*(a1-b1)*sp.sin(theta))
    m=sp.simplify((l1-l0)/(2*sp.pi*sp.I))
    assert m.is_integer is True
    phases.append(int(m));eigen.append(l0)
# Repeated exponentials can occur only within same real-part pairs; check those.
for i in range(6):
    for j in range(i):
        diff=sp.simplify(eigen[i]-eigen[j])
        if sp.simplify(sp.re(diff))==0:
            assert sp.simplify(diff/(2*sp.pi*sp.I)).is_integer is False

result={'status':'PASS','method':'exact integer combinatorics and SymPy identities','enumerated_graphs':tests,'counts_by_order':counts,'cycle_commutator_n':5,'c6_alias_eigenvalue_windings':phases,'c6_alias_sampled_spectrum':'simple','limitations':['Finite enumeration is a check, not the graph theorem proof.','Sine commensurability classification uses the algebraic-integer proof in the manuscript and reviews/final_math_audit.md.','No simulation and no floating point acceptance criteria are used.']}
(ROOT/'results'/'independent_exact.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
print(json.dumps(result,ensure_ascii=False,indent=2))
