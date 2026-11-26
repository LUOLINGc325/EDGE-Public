#!/usr/bin/env python3
"""Independent exhaustive involution verifier; no use of coordinate normal form."""
import itertools, json, hashlib, time, argparse
from pathlib import Path
import networkx as nx


def normalize(g):
    return nx.convert_node_labels_to_integers(g, ordering='default')


def find_witness(graph, weights=None):
    g=normalize(graph); n=len(g)
    if n<3: return None
    masks=[sum(1<<v for v in g[u]) for u in range(n)]
    degree=[m.bit_count() for m in masks]
    weights=list(weights) if weights is not None else [1]*n
    candidates=[tuple(v for v in range(n) if v!=u and degree[v]==degree[u] and weights[v]==weights[u] and not(masks[u]>>v&1)) for u in range(n)]
    p=[-1]*n; used=0
    def consistent(u,v):
        for z,t in enumerate(p):
            if t!=-1 and ((masks[u]>>z&1)!=(masks[v]>>t&1)):
                return False
        return True
    def recurse(left,fixed,moved):
        if not left:
            if not fixed or not moved: return None
            remaining=sum(1<<u for u in range(n) if p[u]!=u)
            while remaining:
                first=remaining & -remaining; comp=first; frontier=first; remaining^=first
                while frontier:
                    bit=frontier & -frontier; frontier^=bit
                    u=bit.bit_length()-1; new=masks[u]&remaining
                    remaining^=new; comp|=new; frontier|=new
                u=(comp & -comp).bit_length()-1
                if comp>>p[u]&1: return None
            return p.copy()
        # The choice is a deterministic function of the currently assigned map.
        best=None; options=None
        for u in left:
            opts=[]
            if consistent(u,u): opts.append(u)
            opts.extend(v for v in candidates[u] if v in left and consistent(u,v) and consistent(v,u))
            if not opts: return None
            if options is None or len(opts)<len(options): best,options=u,opts
        u=best
        for v in options:
            p[u]=v; p[v]=u
            nxt=left-{u,v}
            ans=recurse(nxt,fixed+(u==v),moved+(u!=v))
            if ans is not None: return ans
            p[u]=-1; p[v]=-1
        return None
    return recurse(set(range(n)),0,0)


def validate_witness(g,p):
    if p is None:return
    n=len(g); assert sorted(p)==list(range(n)); assert all(p[p[v]]==v for v in range(n)); assert any(p[v]!=v for v in range(n)); assert any(p[v]==v for v in range(n))
    for u,v in itertools.combinations(range(n),2): assert g.has_edge(u,v)==g.has_edge(p[u],p[v])
    moved=[v for v in range(n) if p[v]!=v]
    for c in nx.connected_components(g.subgraph(moved)): assert not ({p[v] for v in c}&c)


def quotient(g):
    classes={}
    for v in g:
        key=frozenset({v,*g[v]})
        classes.setdefault(key,[]).append(v)
    cs=list(classes.values()); q=nx.Graph();q.add_nodes_from(range(len(cs)))
    for i,j in itertools.combinations(range(len(cs)),2):
        if g.has_edge(cs[i][0],cs[j][0]):q.add_edge(i,j)
    assert all(all(g.has_edge(u,v) for u,v in itertools.combinations(c,2)) for c in cs)
    return q,[len(c) for c in cs]


def main():
    parser=argparse.ArgumentParser();parser.add_argument('--output',default='independent_result.json');args=parser.parse_args()
    start=time.monotonic(); atlas=[normalize(g) for g in nx.graph_atlas_g() if len(g)>0]; connected=[g for g in atlas if nx.is_connected(g)]
    cache={}; quotient_tests=0; true_square=0
    for index,g in enumerate(connected):
        w=find_witness(g); validate_witness(g,w)
        key=nx.to_graph6_bytes(g,header=False).strip().decode();cache[key]=w is not None
        q,weights=quotient(g);qw=find_witness(q,weights);validate_witness(q,qw)
        assert (w is not None)==(qw is not None),(key,'quotient')
        quotient_tests+=1; true_square+=w is not None
    # Every unordered connected atlas pair with each factor at most 6 vertices and product at most 24.
    small=[g for g in connected if len(g)<=6]; rows=[]
    for i,g in enumerate(small):
        gkey=nx.to_graph6_bytes(g,header=False).strip().decode()
        for h in small[i:]:
            if len(g)*len(h)>24:continue
            hkey=nx.to_graph6_bytes(h,header=False).strip().decode()
            x=normalize(nx.strong_product(g,h));w=find_witness(x);validate_witness(x,w)
            wanted=cache[gkey] or cache[hkey]
            assert (w is not None)==wanted,(gkey,hkey,'strong-product')
            rows.append({'g':gkey,'h':hkey,'vertices':len(x),'square':wanted,'witness':w})
    # Disconnected extension, evaluated through actual connected-component products.
    small_all=[g for g in atlas if len(g)<=5]
    all_square={nx.to_graph6_bytes(g,header=False).strip().decode():find_witness(g) is not None for g in small_all}
    factor_component_square={nx.to_graph6_bytes(g,header=False).strip().decode():any(find_witness(normalize(g.subgraph(c))) is not None for c in nx.connected_components(g)) for g in small_all}
    disconnected_rows=[]
    for i,g in enumerate(small_all):
        gkey=nx.to_graph6_bytes(g,header=False).strip().decode()
        for h in small_all[i:]:
            if len(g)*len(h)>16 or (nx.is_connected(g) and nx.is_connected(h)):continue
            hkey=nx.to_graph6_bytes(h,header=False).strip().decode()
            x=normalize(nx.strong_product(g,h));w=find_witness(x);validate_witness(x,w)
            cs=[x.subgraph(c).copy() for c in nx.connected_components(x)]
            collision=len(cs)>=3 and any(nx.is_isomorphic(c,d) for c,d in itertools.combinations(cs,2))
            component_square=factor_component_square[gkey] or factor_component_square[hkey]
            wanted=component_square or collision
            assert (w is not None)==wanted,(gkey,hkey,'disconnected-strong-product')
            disconnected_rows.append({'g':gkey,'h':hkey,'vertices':len(x),'square':wanted,'input_square':all_square[gkey] or all_square[hkey],'some_factor_component_square':component_square,'component_collision_with_remainder':collision,'witness':w})
    summary={'kind':'independent_finite_verification','method':'Enumerate involutions directly using adjacency and nonadjacent-image pruning; no prime factorization or proposed theorem used','connected_atlas_graphs':quotient_tests,'square_connected_atlas_graphs':true_square,'weighted_true_twin_quotient_equivalence_checks':quotient_tests,'strong_product_factor_max_vertices':6,'strong_product_max_vertices':24,'unordered_product_pairs':len(rows),'square_products':sum(r['square'] for r in rows),'nonsquare_products':sum(not r['square'] for r in rows),'mismatches':0,'rows':rows,'disconnected_factor_max_vertices':5,'disconnected_product_max_vertices':16,'disconnected_unordered_pairs':len(disconnected_rows),'disconnected_square_products':sum(r['square'] for r in disconnected_rows),'disconnected_nonsquare_products':sum(not r['square'] for r in disconnected_rows),'disconnected_nonsquare_input_pairs':sum(not r['input_square'] for r in disconnected_rows),'disconnected_rows':disconnected_rows,'networkx_version':nx.__version__}
    Path(args.output).write_text(json.dumps(summary,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({k:v for k,v in summary.items() if k not in ('rows','disconnected_rows')},indent=2))
    print('elapsed_seconds',round(time.monotonic()-start,3))

if __name__=='__main__':main()
