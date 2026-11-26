#!/usr/bin/env python3
"""Independent exact certificate using nonnegative scheduling regret increments.

This implementation does not import either of the other game solvers.
Every job contributes its common p part to B=p*n(n+1)/2. The excess over
clairvoyant SPT is the sum of test ranks and x times long-before-short
execution inversions. A short completion therefore incurs x*b where b is
the number of long jobs already completed. This is a different recurrence
from the rank-extra-cost/negative-clairvoyant-terminal formulation.

All arithmetic in the target certificate is integral after multiplication
by the denominator of rho. No floating point or Lean is used.
"""
from fractions import Fraction
from functools import lru_cache
from hashlib import sha256
import json
from pathlib import Path


def tri(k):
    return k*(k+1)//2


def solve_qs(n,x):
    """The paper's (4.1)--(4.3), directly, on every feasible triple.

    This iterative table includes even the boundary states not reached by the
    separate recursive four-coordinate implementation below.  The stopping
    value is recomputed from its finite maximization, not taken from a solver.
    """
    values={}; rows=[]
    for f in range(n+1):
        for d in range(n-f+1):
            for b in range(n-f-d+1):
                if f==0:
                    value=0; stop=test=known=None
                else:
                    stop=x*max((b+k)*(f-k) for k in range(f+1))
                    test=f+d+max(x*b+values[f-1,d,b],values[f-1,d+1,b])
                    known=values[f,d-1,b+1] if d else None
                    value=min(a for a in (stop,test,known) if a is not None)
                values[f,d,b]=value
                rows.append([f,d,b,value,stop,test,known])
    for f,d,b,value,stop,test,known in rows:
        if f==0:
            assert value==0
            continue
        assert stop==x*max((b+k)*(f-k) for k in range(f+1))
        assert test==f+d+max(x*b+values[f-1,d,b],values[f-1,d+1,b])
        if d: assert known==values[f,d-1,b+1]
        assert value==min(a for a in (stop,test,known) if a is not None)
    encoded=json.dumps(rows,separators=(',',':'))
    return {
        'n':n,'x':x,'mode':'physical_two_phase_qs',
        'root':values[n,0,0],'number_of_states':len(rows),
        'every_local_identity_verified':True,
        'table_columns':['unseen','pending_long','completed_long','value','stop','test','execute_known_long'],
        'table_sha256':sha256(encoded.encode()).hexdigest(),'table':rows,
    }


def solve(n,p,x,rho,two_phase=False):
    assert isinstance(p,int) and p>0 and isinstance(x,int) and x>0
    rho=Fraction(rho); D=rho.denominator; beta=rho.numerator-D
    base=p*tri(n)
    rows={}

    @lru_cache(None)
    def rec(f,d,b,closed):
        assert min(f,d,b)>=0 and f+d+b<=n
        if f==0:
            val=-beta*(base+x*tri(d+b))
            rows[(f,d,b,closed)]=[val,None,None,None]
            return val
        rank=f+d
        test=None
        if not (two_phase and closed):
            test=D*rank+max(D*x*b+rec(f-1,d,b,closed),
                            rec(f-1,d+1,b,closed))
        next_closed=bool(two_phase)
        execute=max(D*x*b+rec(f-1,d,b,next_closed),
                    rec(f-1,d,b+1,next_closed))
        known=rec(f,d-1,b+1,closed) if d else None
        val=min(q for q in (test,execute,known) if q is not None)
        rows[(f,d,b,closed)]=[val,test,execute,known]
        return val

    root=rec(n,0,0,False)
    table=[[f,d,b,int(closed),*vals] for (f,d,b,closed),vals in sorted(rows.items())]
    # Check every recorded equality again without recursion or memoization.
    for (f,d,b,closed),(value,t,e,k) in rows.items():
        if f==0:
            assert value==-beta*(base+x*tri(d+b))
            continue
        get=lambda ff,dd,bb,cc:rows[(ff,dd,bb,cc)][0]
        if t is not None:
            assert t==D*(f+d)+max(D*x*b+get(f-1,d,b,closed),get(f-1,d+1,b,closed))
        assert e==max(D*x*b+get(f-1,d,b,bool(two_phase)),get(f-1,d,b+1,bool(two_phase)))
        if k is not None:assert k==get(f,d-1,b+1,closed)
        assert value==min(q for q in (t,e,k) if q is not None)
    encoded=json.dumps(table,separators=(',',':'))
    rootvals=rows[(n,0,0,False)]
    return {
        'n':n,'p':p,'x':x,'rho':str(rho),'mode':'two_phase_full_physical' if two_phase else 'unrestricted_full_physical',
        'normalization_denominator':D,'root_scaled':root,
        'root':str(Fraction(root,D)),
        'root_actions':dict(zip(('T','E','P'),(None if a is None else str(Fraction(a,D)) for a in rootvals[1:]))),
        'number_of_states':len(rows),'every_local_identity_verified':True,
        'table_columns':['unseen','pending_long','completed_long','testing_closed','value','test','execute_unseen','execute_known_long'],
        'table_sha256':sha256(encoded.encode()).hexdigest(),'table':table,
    }


def main():
    n,p,x=18,1260,3
    rho=Fraction(215783,215568)
    additive_full=solve(n,p,x,Fraction(1),False)
    additive_two=solve(n,p,x,Fraction(1),True)
    additive_qs=solve_qs(n,x)
    assert additive_qs['root']==216 and additive_qs['number_of_states']==1330
    qs_values={(f,d,b):v for f,d,b,v,*rest in additive_qs['table']}
    compared=0
    for f,d,b,closed,value,*rest in additive_two['table']:
        if not closed:
            assert value==qs_values[f,d,b]
            compared+=1
    additive_qs['crosscheck_with_phase_flag']={
        'all_common_open_phase_states_equal':True,'compared_states':compared}
    exact_full=solve(n,p,x,rho,False)
    exact_two=solve(n,p,x,rho,True)
    assert additive_full['root']=='215'
    assert additive_two['root']=='216'
    assert exact_full['root']=='0'
    assert exact_full['root_actions']['T']=='10471/11976'
    assert exact_full['root_actions']['E']=='0'
    assert Fraction(exact_two['root'])>0
    base=p*tri(n)
    possible=[l for l in range(n+1) if (base+x*tri(l))%rho.denominator==0]
    assert possible==[8]
    forced_opt=base+x*tri(8)
    forced_alg=rho*forced_opt
    assert forced_opt==215568 and forced_alg==215783 and forced_alg.denominator==1
    assert int(forced_alg)%3==2
    result={
        'kind':'independent_nonnegative_regret_bellman_certificate',
        'arithmetic':'Python integers; Fraction only for report formatting',
        'recurrence_basis':'test delay ranks plus long-before-short inversions',
        'independent_of':['search_game.py','exact_adaptive.py'],
        'claim_scope':'the exact n=18, p=1260, x=3 witness; additive values independent of p',
        'paper_qs_recurrence':additive_qs,
        'checks':{'additive_full':additive_full,'additive_two_phase':additive_two,'ratio_full':exact_full,'ratio_two_phase':exact_two},
        'weak_equilibrium_interpretation':{
            'root_action_uniquely':'E',
            'clairvoyant_cost_range':[base,(p+x)*tri(n)],
            'only_possible_long_count_at_exact_ratio':possible,
            'forced_clairvoyant_cost':forced_opt,'forced_algorithm_cost':str(forced_alg),
            'zero_test_costs_divisible_by':3,
            'forced_algorithm_cost_mod_3':int(forced_alg)%3,
            'conclusion':'Every minimax policy starts with E; every worst-case path must later contain T. This does not assume subgame-perfect tie breaking.'
        }
    }
    out=Path(__file__).resolve().parents[1]/'results'/'independent_regret_certificate.json'
    out.parent.mkdir(parents=True,exist_ok=True)
    out.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({'output':str(out),'roots':{key:value['root'] for key,value in result['checks'].items()},'root_actions':exact_full['root_actions'],'state_counts':{key:value['number_of_states'] for key,value in result['checks'].items()},'weak_equilibrium_check':'passed'},indent=2))


if __name__=='__main__':
    main()
