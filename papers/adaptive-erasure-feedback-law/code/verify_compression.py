"""Finite exact check of tail reset using the original optimal scheduling rule.

This checks the noiseless real-length scalar guarantee, not an implementation
of codebook search or a substitute for the compression theorem.
"""
from fractions import Fraction as F
import json
from pathlib import Path
from erasure_dp import agreement
from closed_form import deficit,first_fraction

def run(max_m=64,max_r=12,cutoffs=(2,4,8)):
    failures=[];records=[];checked=0
    for K in cutoffs:
        v={(0,m):1-agreement(m,2) for m in range(2,max_m+1)}
        worst=(F(0),0,2)
        for r in range(1,max_r+1):
            for m in range(2,max_m+1):
                t=first_fraction(r,m)
                branches=[t*(1-agreement(m,k))+(1-t)*v[r-1,k]
                          for k in range(2,min(K,m)+1)]
                if m>K:
                    branches.append(t*(1-agreement(m,K+1))+(1-t)*v[r-1,m])
                v[r,m]=min(branches)
                loss=1-deficit(r,m)-v[r,m]
                checked+=1
                if not 0<=loss<=F(1,2**K):
                    failures.append(dict(K=K,r=r,m=m,loss=str(loss)))
                worst=max(worst,(loss,r,m))
        records.append(dict(cutoff=K,tail_bound=str(F(1,2**K)),
            maximum_loss=str(worst[0]),worst_r=worst[1],worst_m=worst[2]))
    return dict(status="passed" if not failures else "failed",
        scope="finite rational consistency check of the scalar tail-reset guarantee",
        states=checked,grid=dict(max_m=max_m,max_r=max_r),records=records,failures=failures)

if __name__=="__main__":
    result=run()
    Path("results/compressed_feedback_verification.json").write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps(result,indent=2))
    if result["status"]!="passed":raise SystemExit(1)
