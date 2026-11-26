#!/usr/bin/env python3
"""Generate rational primal/log-score candidates; the verifier is separate."""
import json
from fractions import Fraction as F
from pathlib import Path
from concurrent.futures import ProcessPoolExecutor
from solve_candidates import solve


def floor_decimal(s, digits=55):
    x=F(s);d=10**digits
    return F((x.numerator*d)//x.denominator,d)


def one(args):
    p,q,r,a=args
    c=solve(p,q,r,a)
    if c.get('failed'):
        raise RuntimeError(c)
    hp=[floor_decimal(s) for s in c['hidden_p']]
    hq=[floor_decimal(s) for s in c['hidden_q']]
    # Both full and slack candidates use a full alternative budget. Rounding
    # the very small hq[1] to zero is safe for a PRIMAL UPPER bound only.
    hq[0]=F(str(r))-hq[1]
    if c['mode']=='full':hp[1]=F(str(r))-hp[0]
    return {'p':str(p),'q':str(q),'rho':str(r),'a':str(a),
            'null_hidden':list(map(str,hp)),
            'alternative_hidden':list(map(str,hq)),
            'log_scores':c['log_e'],
            'candidate_pattern':c['mode'],
            'candidate_information':c['I'],
            'log_alternative_hidden_zero_mass':c['log_y']}


if __name__=='__main__':
    root=Path(__file__).resolve().parents[1]
    params=[('0.2','0.5',r,a) for r in ['0.2','0.3','0.4']
            for a in ['0.1','0.01','0.001','0.0001','0.00001','0.000001']]
    cases=[]
    with ProcessPoolExecutor(max_workers=3) as pool:
        for c in pool.map(one,params):
            cases.append(c)
            print(c['rho'],c['a'],c['candidate_pattern'],c['candidate_information'],flush=True)
    out={'description':'Exact rational primal mechanisms and rational log-score candidates',
         'verification':'Use verify_certificates.py; optimizer convergence is not evidence.',
         'cases':cases}
    (root/'results').mkdir(parents=True,exist_ok=True)
    (root/'results'/'certificates.json').write_text(json.dumps(out,indent=2)+'\n')
