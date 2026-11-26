"""Check finite phase tables directly through sorted CVaR costs.

Does not import the capacity generator. Within each rational q interval,
probabilities are affine. Split at every tail-quantile switch. On each
resulting interval the tail integral is affine, so endpoint equality
certifies the identity over the entire interval, not just at test points.
"""
from fractions import Fraction as F
from pathlib import Path
import argparse,json


def add(u,v): return (u[0]+v[0],u[1]+v[1])
def at(u,q): return u[0]+u[1]*q


def tail_integral(prob,cost,q):
    need=q; total=F(0)
    for j in sorted(range(len(prob)),key=lambda j:cost[j],reverse=True):
        take=min(prob[j],need)
        total+=take*cost[j];need-=take
        if need==0: break
    assert need==0
    return total


def verify(rows):
    intervals=0; equalities=0; checked=[]
    for row in rows:
        B=row['B']; qc=F(row['q_critical']); D=F(2*B-1,B)
        pieces=row['pieces']
        assert F(pieces[0]['q_hi'])==1
        assert F(pieces[-1]['q_lo'])==qc
        assert F(row['delta_critical'])==1-qc
        previous_lo=F(1)
        for piece in pieces:
            lo,hi=F(piece['q_lo']),F(piece['q_hi'])
            assert lo<hi and hi==previous_lo
            previous_lo=lo
            A,C=F(piece['ratio_constant']),F(piece['ratio_inverse_q'])
            funcs=[tuple(map(F,p)) for p in piece['cumulative']]
            # r=(A-1)+C/q; q*U_i = a_i*C + (a_i*(A-1)+b_i)*q.
            cum=[(F(0),F(0))]+[(a*C,a*(A-1)+b) for a,b in funcs]
            probs=[(v[0]-u[0],v[1]-u[1]) for u,v in zip(cum,cum[1:])]
            assert cum[-1]==(F(1),F(0))
            assert all(at(p,q)>=0 for p in probs for q in [lo,hi])
            assert all(at(p,(lo+hi)/2)>0 for p in probs)
            for s in range(1,B+1):
                cost=[F(B+j-1) if j<=s else F(s) for j in range(1,B+1)]
                order=sorted(range(B),key=lambda j:cost[j],reverse=True)
                switches={lo,hi}; partial=(F(0),F(0))
                for j in order:
                    partial=add(partial,probs[j])
                    if partial[1]!=1:
                        q=-partial[0]/(partial[1]-1)
                        if lo<q<hi: switches.add(q)
                knots=sorted(switches)
                for a,b in zip(knots,knots[1:]):
                    intervals+=1
                    for q in (a,b):
                        p=[at(v,q) for v in probs]
                        got=tail_integral(p,cost,q)
                        assert got==s*(A*q+C),(B,s,q,got,s*(A*q+C))
                        equalities+=1
            if lo==qc:
                assert A+C/qc==D
                assert at(probs[-1],qc)==qc
        checked.append({'B':B,'nonconstant_pieces':len(pieces),'threshold':row['delta_critical']})
    return {'status':'passed','arithmetic':'fractions.Fraction',
            'scope':'Direct CVaR feasibility and equalization for every q on the listed rational phase intervals; independent global optimality is checked separately.',
            'certified_affine_tail_intervals':intervals,'exact_endpoint_equalities':equalities,'tables':checked}


if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('tables');ap.add_argument('--output')
    a=ap.parse_args();result=verify(json.loads(Path(a.tables).read_text()))
    if a.output:Path(a.output).write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k!='tables'},indent=2))
