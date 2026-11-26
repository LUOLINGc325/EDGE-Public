"""Exact sum/max/leaf DAG generator used only to construct the Lean proof.

The independent full certificate is verify_certificate.py. This helper is not
trusted by the Lean kernel: all emitted graph equalities are checked in Lean.
"""
from functools import lru_cache
from fractions import Fraction
from itertools import combinations

class Kernel:
    def __init__(self,dist):
        self.dist=dist
        self.m=m=len(dist[0][0])
        if sum(w for _,w in dist) != 1 or any(w < 0 for _,w in dist):
            raise ValueError("Distribution must be nonnegative and normalized")
        worlds=[]
        for pi,(perm,weight) in enumerate(dist):
            if sorted(perm) != list(range(1,m+1)):
                raise ValueError("Invalid rank permutation")
            for h in range(m):
                for sample in combinations(range(2,m+1),h):
                    seen=set(sample)
                    arrivals=[]; observations=[]; responses=[min(seen)-1 if seen else m]
                    for a in perm:
                        if a in sample:continue
                        arrivals.append(a)
                        observations.append(sum(x<a for x in seen))
                        seen.add(a)
                        responses.append(min(seen)-1)
                        if a==1:break
                    worlds.append((tuple(arrivals),tuple(observations),tuple(responses),weight,h,pi))
        self.worlds=worlds
        nodes=[]
        @lru_cache(None)
        def add(kind,data):
            nodes.append((kind,data));return len(nodes)-1
        zero=add('leaf',(Fraction(0),)*(m+1))
        def sum_nodes(ids):
            ids=tuple(i for i in ids if i!=zero)
            if not ids:return zero
            if len(ids)==1:return ids[0]
            return add('sum',ids)
        def leaf(ids):
            c=[Fraction(0)]*(m+1)
            for i in ids:
                w=worlds[i];c[w[4]]+=w[3]
            return add('leaf',tuple(c))
        @lru_cache(None)
        def dp(ids,t,query):
            ids=tuple(i for i in ids if t<len(worlds[i][0]))
            if not ids:return zero
            obs={}
            for i in ids:obs.setdefault(worlds[i][1][t],[]).append(i)
            decisions=[]
            for group in obs.values():
                accept=leaf(tuple(i for i in group if worlds[i][0][t]==1))
                continuation=dp(tuple(group),t+1,query)
                decisions.append(add('max',(accept,continuation)))
            wait=sum_nodes(decisions)
            if not query:return wait
            branches={}
            for i in ids:branches.setdefault(worlds[i][2][t],[]).append(i)
            ask=sum_nodes(tuple(dp(tuple(g),t,False) for g in branches.values()))
            return add('max',(wait,ask))
        self.root=dp(tuple(range(len(worlds))),0,True)
        self.nodes=nodes

    def evaluate(self,p,policy=False):
        powers=[p**h*(1-p)**(self.m-h) for h in range(self.m+1)]
        values=[]; polys=[]
        for kind,data in self.nodes:
            if kind=='leaf':
                values.append(sum(c*x for c,x in zip(data,powers)))
                if policy:polys.append(data)
            elif kind=='sum':
                values.append(sum(values[i] for i in data))
                if policy:polys.append(tuple(sum(polys[i][j] for i in data) for j in range(self.m+1)))
            else:
                i=max(data,key=lambda j: values[j]);values.append(values[i])
                if policy:polys.append(polys[i])
        return (values[self.root],polys[self.root]) if policy else values[self.root]

