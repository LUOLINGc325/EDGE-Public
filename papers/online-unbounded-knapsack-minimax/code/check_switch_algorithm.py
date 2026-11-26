"""Independent finite adversarial search for first-small-item switch.

All knapsack sizes, copy counts, and offline optima use integer arithmetic.
The threshold distribution is integrated exactly up to floating evaluation
of finitely many logarithms. This is a diagnostic, not a proof of continuum
or arbitrary-horizon claims. Algorithm deliberately stops after first small
positive item, the weaker version of the claimed strategy.
"""
import argparse, functools, itertools, json, math, random

def gain(seq,M,threshold_numerator,threshold_denominator):
    load=0
    for x in seq:
        if x==0:
            continue
        if 2*x<=M:
            return load+((M-load)//x)*x
        if load==0 and x*threshold_denominator>=threshold_numerator:
            load=x
    return load

@functools.lru_cache(maxsize=None)
def opt(types,M):
    possible=[False]*(M+1);possible[0]=True
    for x in types:
        if x<=0:continue
        for load in range(x,M+1):
            possible[load] |= possible[load-x]
    return max(i for i,v in enumerate(possible) if v)

def scaled_expectation(seq,M):
    breaks={M//2,M}
    for x in seq:
        if x==0:continue
        if 2*x<=M:break
        breaks.add(x)
    breaks=sorted(breaks)
    terms=[float(gain(seq,M,M,2))]
    for a,b in zip(breaks,breaks[1:]):
        terms.append(gain(seq,M,a+b,2)*math.log(b/a))
    return math.fsum(terms)

def run(M=60,depth=4,trials=5000):
    alphabet=[0,1,19,20,21,25,29,30,31,35,39,40,41,49,59,60]
    assert M==60
    count=0;worst={'ratio':0.};min_slack=1e99;small_slack=1e99
    c=1+math.log(2)
    def inspect(seq,kind):
        nonlocal count,worst,min_slack,small_slack
        count+=1;o=opt(tuple(sorted(set(seq))),M)
        if o==0:return
        scaled=scaled_expectation(seq,M)
        slack=scaled-o
        min_slack=min(min_slack,slack)
        if any(0<x<=M/2 for x in seq):small_slack=min(small_slack,scaled-M)
        ratio=o*c/scaled
        if ratio>worst['ratio']:
            worst={'ratio':ratio,'sequence':list(seq),'kind':kind,'offline_opt':o,'scaled_expectation':scaled}
        if slack < -1e-9:
            raise AssertionError({'sequence':seq,'offline_opt':o,'scaled_expectation':scaled})
    for n in range(1,depth+1):
        for seq in itertools.product(alphabet,repeat=n):inspect(seq,'exhaustive')
    rng=random.Random(20261125)
    for _ in range(trials):
        n=rng.randint(1,40)
        inspect(tuple(rng.randrange(M+1) for _ in range(n)),'seeded_random')
    # A dense increasing all-large input approaches the known lower bound.
    Md=1000000
    dense=[Md//2+1]+list(range(Md//2+100,Md+1,100))
    dense_scaled=scaled_expectation(dense,Md)
    return {'capacity':M,'alphabet':alphabet,'depth':depth,'random_trials':trials,
      'sequences_checked':count,'minimum_scaled_slack':min_slack,
      'minimum_first_small_scaled_slack':small_slack,'worst':worst,
      'dense_pure_search_ratio':Md*c/dense_scaled,
      'candidate_ratio':c,'result':'NO_COUNTEREXAMPLE_ON_TESTED_INPUTS',
      'arithmetic':'integer feasibility/offline DP; finite log evaluation in IEEE double',
      'limitation':'finite numerical diagnostic only; independent analytic proof required'}

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--out');a=ap.parse_args()
    result=run()
    if a.out:
        with open(a.out,'w') as f:json.dump(result,f,indent=2)
    print(json.dumps(result,ensure_ascii=False))
