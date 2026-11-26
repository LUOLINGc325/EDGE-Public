#!/usr/bin/env python3
"""Exact author-side certificates; standard library only.

This verifies finite rational saddle points and all supports for the two
counterexamples. Parameter checks corroborate, but do not replace, the
manuscript's proofs of the infinite family and universal graph bound.
"""
from fractions import Fraction as F
from itertools import combinations
from pathlib import Path
import json
import platform

ROOT = Path(__file__).resolve().parents[1]


def payoff(edges, weights):
    return [[sum(weights[v] for v in e) if v not in e else F(0)
             for v in range(len(weights))] for e in edges]


def expected_columns(a, p):
    return [sum(p[i]*a[i][j] for i in range(len(a)))
            for j in range(len(a[0]))]


def expected_rows(a, q):
    return [sum(a[i][j]*q[j] for j in range(len(q))) for i in range(len(a))]


def all_reciprocal(edges, weights):
    a = payoff(edges, weights)
    rewards = [sum(weights[v] for v in e) for e in edges]
    out = []
    for size in range(1, len(edges)+1):
        for support in combinations(range(len(edges)), size):
            z = sum((1/rewards[i] for i in support), F(0))
            p = [1/(rewards[i]*z) if i in support else F(0)
                 for i in range(len(edges))]
            cols = expected_columns(a, p)
            out.append({'support': list(support), 'probabilities': list(map(str,p)),
                        'pure_hider_payoffs': list(map(str, cols)),
                        'guarantee': str(min(cols))})
    return out


def check_case(n, edges, p, q, value, rec_value):
    weights = [F(1)]*n
    a = payoff(edges, weights)
    assert sum(p)==sum(q)==1 and min(p)>=0 and min(q)>=0
    cols, rows = expected_columns(a,p), expected_rows(a,q)
    assert min(cols)==value and max(rows)==value
    supports = all_reciprocal(edges,weights)
    assert max(F(row['guarantee']) for row in supports)==rec_value
    return {'vertices': n, 'edges': [sorted(e) for e in edges],
            'matrix': [[str(x) for x in row] for row in a],
            'searcher': list(map(str,p)), 'hider': list(map(str,q)),
            'column_payoffs': list(map(str,cols)), 'row_payoffs': list(map(str,rows)),
            'value': str(value), 'best_reciprocal_value': str(rec_value),
            'ratio': str(rec_value/value), 'supports': supports}


def main():
    h_edges = [frozenset((0,i)) for i in range(1,4)]+[frozenset((1,2,3))]
    h = check_case(4,h_edges,[F(3,13)]*3+[F(4,13)],
                   [F(4,13)]+[F(3,13)]*3,F(12,13),F(3,4))
    g_edges = list(map(frozenset,[(0,1),(0,2),(1,2),(2,3),(3,4)]))
    g = check_case(5,g_edges,[F(1,5)]*3+[F(0),F(2,5)],
                   [F(1,5)]*5,F(6,5),F(1))
    family = []
    for m in range(2,129):
        d=m*m+2*m-2
        p_pair,p_big=F(m,d),F(2*(m-1),d)
        v,w=F(2*m*(m-1),d),F(m,m+1)
        assert m*p_pair+p_big==1
        assert m*p_big==2*(m-1)*p_pair==v
        assert 2*(1-p_big-p_pair)==v
        vals=[F(0) if s<2 else F(2*m,m*s+2) for s in range(m+1)]
        assert max(vals)==w
        assert v-w==F(m*m*(m-2),d*(m+1))
        assert w/v==F(d,2*(m*m-1))
        assert (v>w)==(m>=3)
        family.append({'m':m,'value':str(v),'best_reciprocal':str(w),'ratio':str(w/v)})
    # Distinct rewards within the analytically proved open neighbourhood.
    weights=list(map(F,['19/20','39/40','41/40','21/20']))
    fixed_lower=min(expected_columns(payoff(h_edges,weights),[F(3,13)]*3+[F(4,13)]))
    distinct_supports=all_reciprocal(h_edges,weights)
    distinct_upper=max(F(row['guarantee']) for row in distinct_supports)
    assert fixed_lower>distinct_upper
    assert fixed_lower-distinct_upper>=F(9,52)-F(87,52)*F(1,20)
    # Rational checks of the analytic graph-bound inequality, not a proof
    # of half-integrality or of the universal quantifier over all graphs.
    bounds=0
    for s in range(1,21):
        for t in range(1,21):
            for extra in range(11):
                l=3*t+2*extra
                q=F(s)+F(l,2)
                b=max(q-F(t,2),q-F(s,2))
                ratio=(1-1/b)/(1-1/q)
                assert ratio>=F(5,6)
                bounds+=1
    result={'status':'passed','arithmetic':'fractions.Fraction; no floating point',
            'four_vertex_hypergraph':h,'five_vertex_connected_graph':g,
            'family_parameter_checks':family,
            'distinct_rewards':{'weights':list(map(str,weights)),
              'fixed_strategy_lower_bound':str(fixed_lower),
              'all_reciprocal_supports_upper_bound':str(distinct_upper),
              'gap':str(fixed_lower-distinct_upper)},
            'graph_bound_parameter_checks':bounds,
            'scope':'Exact finite witnesses and finite parameter checks; universal proofs are in the manuscript.'}
    (ROOT/'results').mkdir(exist_ok=True)
    (ROOT/'results'/'exact_certificates.json').write_text(json.dumps(result,indent=2)+'\n')
    env={'python':platform.python_version(),'arithmetic':'Python standard library fractions.Fraction',
         'dependencies_for_certificate':'none beyond Python 3.10+', 'lean_used':False}
    (ROOT/'results'/'environment.json').write_text(json.dumps(env,indent=2)+'\n')
    print('PASS: four-vertex saddle point; all 15 reciprocal supports; value 12/13 versus 3/4')
    print('PASS: five-vertex connected graph; all 31 supports; value 6/5 versus 1')
    print('PASS: family m=2..128; 127 exact parameter checks')
    print('PASS: pairwise distinct rewards retain a strict gap '+str(fixed_lower-distinct_upper))
    print('PASS: '+str(bounds)+' exact parameter checks of the graph-bound inequality')
    print('Universal statements rely on the written proofs, not the finite checks above.')


if __name__=='__main__':
    main()
