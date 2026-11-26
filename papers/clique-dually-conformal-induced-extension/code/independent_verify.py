"""Independent finite audit: actual maximal cliques -> blocker -> co-occurrence.
No symbolic description of the expected transversals is used to decide CDC.
All labelled simple graphs on 1,...,5 vertices are exhausted.
"""
import argparse
import itertools
import json
from pathlib import Path

def bits(x):
    while x:
        b=x&-x
        yield b.bit_length()-1
        x-=b

def max_cliques(adj):
    out=[]
    def visit(R,P,X):
        if not P and not X:
            out.append(R)
            return
        union=P|X
        u=max(bits(union),key=lambda j:(P&adj[j]).bit_count()) if union else 0
        cand=P&~adj[u] if union else P
        while cand:
            vbit=cand&-cand; v=vbit.bit_length()-1
            visit(R|vbit,P&adj[v],X&adj[v])
            P &= ~vbit
            X |= vbit
            cand &= ~vbit
    visit(0,(1<<len(adj))-1,0)
    return sorted(out)

def minimal_sets(sets):
    kept=[]
    for x in sorted(set(sets),key=lambda s:(s.bit_count(),s)):
        if not any(y&x==y for y in kept):
            kept.append(x)
    return kept

def blocker(hyperedges):
    frontier=[0]
    for e in sorted(hyperedges,key=lambda s:(s.bit_count(),s)):
        candidates=[]
        for t in frontier:
            if t&e:
                candidates.append(t)
            else:
                for v in bits(e):
                    candidates.append(t|(1<<v))
        frontier=minimal_sets(candidates)
    return sorted(frontier)

def expand(adj):
    n=len(adj); cliques=max_cliques(adj)
    out=list(adj)+[0]*(n+len(cliques))
    for v in range(n):
        out[v]|=1<<(n+v);out[n+v]|=1<<v
    for k,c in enumerate(cliques):
        w=2*n+k
        out[w]=c
        for v in bits(c): out[v]|=1<<w
    return out,cliques

def dual_adj(N,transversals):
    out=[0]*N
    for t in transversals:
        for v in bits(t): out[v]|=t&~(1<<v)
    return out

def check(adj):
    n=len(adj); ext,orig_cliques=expand(adj)
    ext_cliques=max_cliques(ext)
    actual=blocker(ext_cliques)
    dual=dual_adj(len(ext),actual)
    if max_cliques(dual)!=actual:
        raise RuntimeError(('not CDC',adj,ext_cliques,actual,max_cliques(dual)))
    expected_cliques=sorted([(1<<v)|(1<<(v+n)) for v in range(n)]+[c|(1<<(2*n+j)) for j,c in enumerate(orig_cliques)])
    if ext_cliques!=expected_cliques: raise RuntimeError(('cliques',adj))
    expected=[]
    for x in range(1<<n):
        t=x|(((1<<n)-1-x)<<n)
        for j,c in enumerate(orig_cliques):
            if not x&c:t|=1<<(2*n+j)
        expected.append(t)
    if actual!=sorted(expected): raise RuntimeError(('transversals',adj))
    if max(c.bit_count() for c in ext_cliques)!=1+max(c.bit_count() for c in orig_cliques):raise RuntimeError(('omega',adj))
    for u in range(n):
        if ext[u]&((1<<n)-1)!=adj[u]:raise RuntimeError(('induced',adj))
    return len(ext),len(actual)

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=Path(__file__).resolve().parents[1]/'results'/'independent_exhaustive.json')
    args=parser.parse_args()
    counts={};max_size=0;max_ts=0
    for n in range(1,6):
        pairs=list(itertools.combinations(range(n),2));count=0
        for edge_mask in range(1<<len(pairs)):
            adj=[0]*n
            for k,(u,v) in enumerate(pairs):
                if edge_mask>>k&1:
                    adj[u]|=1<<v;adj[v]|=1<<u
            N,T=check(adj);max_size=max(max_size,N);max_ts=max(max_ts,T);count+=1
        counts[str(n)]=count
    # Attack the tempting but incorrect simplification that adds leaves only.
    # This graph is the ordinary corona of K3, with originals 0,1,2 and leaves 3,4,5.
    corona=[(1<<j)|(1<<k)|(1<<(3+i)) for i,(j,k) in enumerate([(1,2),(0,2),(0,1)])]+[1,2,4]
    corona_cliques=max_cliques(corona)
    corona_transversals=blocker(corona_cliques)
    corona_dual_cliques=max_cliques(dual_adj(6,corona_transversals))
    obstruction=(1<<3)|(1<<4)|(1<<5)
    if obstruction not in corona_dual_cliques or obstruction in corona_transversals:
        raise RuntimeError('The independent negative control did not detect the corona obstruction.')
    # Recheck this attack by brute-force definitions, independently of the two
    # enumeration algorithms used above.
    def is_clique(a,s):
        return all((s&~(1<<v))&~a[v]==0 for v in bits(s))
    brute_cliques=sorted(s for s in range(1<<6) if is_clique(corona,s) and all(not is_clique(corona,s|(1<<v)) for v in range(6) if not s>>v&1))
    def hits(s):return all(s&e for e in brute_cliques)
    brute_transversals=sorted(s for s in range(1<<6) if hits(s) and all(not hits(s&~(1<<v)) for v in bits(s)))
    if brute_cliques!=corona_cliques or brute_transversals!=corona_transversals:
        raise RuntimeError('The brute-force negative-control checks disagree.')
    result={
        "status":"PASS",
        "tested":"all labelled nonempty simple graphs on at most 5 vertices",
        "graphs_by_order":counts,
        "total_graphs":sum(counts.values()),
        "maximum_extension_order":max_size,
        "maximum_transversal_count":max_ts,
        "failures":0,
        "method":"Bron-Kerbosch maximal cliques; incremental exact blocker; co-occurrence graph; independently enumerated maximal-clique equality",
        "negative_control":{
            "graph":"ordinary corona of K3; no maximal-clique markers",
            "order":6,
            "maximal_cliques":[list(bits(x)) for x in corona_cliques],
            "minimal_transversal_count":len(corona_transversals),
            "dual_maximal_clique_count":len(corona_dual_cliques),
            "dual_clique_not_transversal":list(bits(obstruction)),
            "brute_force_cross_check":"PASS",
            "interpretation":"The all-leaf triple is a maximal clique of the co-occurrence graph but misses the original triangle."
        },
        "scope":"Finite validation and a finite negative control, not the proof of the general theorem."
    }
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(result,indent=2))
if __name__=='__main__':main()
