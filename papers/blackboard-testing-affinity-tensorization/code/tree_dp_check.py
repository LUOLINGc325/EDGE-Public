import itertools, functools, json, random, math, time

def test(P,Q,budgets,lam):
    ns=len(P)
    masses=[]
    for p,q in zip(P,Q):
        k=len(p)
        a=[0.]*(1<<k); c=[0.]*(1<<k)
        for m in range(1,1<<k):
            lo=m&(-m); i=lo.bit_length()-1
            a[m]=a[m^lo]+p[i];c[m]=c[m^lo]+q[i]
        masses.append((a,c))
    def weight(i,s):
        a,c=masses[i]
        return a[s]**lam*c[s]**(1-lam)
    @functools.lru_cache(None)
    def single(i,s,k):
        best=weight(i,s)
        if k==0 or s&(s-1)==0:return best
        lo=s&-s
        t=(s-1)&s
        while t:
            if t&lo and t!=s:
                best=min(best,single(i,t,k-1)+single(i,s^t,k-1))
            t=(t-1)&s
        return best
    @functools.lru_cache(None)
    def full(ss,bb):
        best=math.prod(weight(i,s) for i,s in enumerate(ss))
        for i,(s,b) in enumerate(zip(ss,bb)):
            if b==0 or s&(s-1)==0:continue
            lo=s&-s;t=(s-1)&s
            nb=bb[:i]+(b-1,)+bb[i+1:]
            while t:
                if t&lo and t!=s:
                    a=ss[:i]+(t,)+ss[i+1:]
                    c=ss[:i]+(s^t,)+ss[i+1:]
                    best=min(best,full(a,nb)+full(c,nb))
                t=(t-1)&s
        return best
    ss=tuple((1<<len(p))-1 for p in P)
    v=math.prod(single(i,s,b) for i,(s,b) in enumerate(zip(ss,budgets)))
    w=full(ss,tuple(budgets))
    return dict(lam=lam,budgets=budgets,k=[len(p) for p in P],product=v,interactive=w,gap=w-v,states=full.cache_info().currsize)
random.seed(2571)
res=[]
for n,k,b in [(2,5,[2,2]),(2,5,[1,2]),(3,4,[1,1,2]),(3,3,[1,1,1])]:
    p=[];q=[]
    for i in range(n):
        a=[random.randint(0,9) for j in range(k)];c=[random.randint(0,9) for j in range(k)]
        p.append([v/sum(a) for v in a]);q.append([v/sum(c) for v in c])
    for lam in [0.001,0.125,0.5,0.875,0.999]:
        out=test(p,q,b,lam);res.append(out)
        print(json.dumps(out),flush=True)
assert max(abs(r['gap']) for r in res)<2e-14
print(json.dumps({'cases':len(res),'max_absolute_gap':max(abs(r['gap']) for r in res),'all_match':True}))
