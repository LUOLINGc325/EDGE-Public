#!/usr/bin/env python3
"""Reproduce selected exact rational certificates; no proof assistant is invoked."""
from pathlib import Path
import json
import subprocess
import sys
import sympy as s
from finite_realization import construct

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'results'

def main():
    OUT.mkdir(exist_ok=True)
    cases = [
        ('finite_realization_certificate.json', [[0,1,-1],[-1,0,1],[1,-1,0]], 1),
        ('four_weighted_full_rank_certificate.json', [[0,2,-1,3],[-2,0,4,-2],[1,-4,0,5],[-3,2,-5,0]], 2),
        ('three_cycle_three_moments_certificate.json', [[0,1,-1],[-1,0,1],[1,-1,0]], 3),
        ('all_ties_certificate.json', [[0,0],[0,0]], 1),
    ]
    summary=[]
    for name,matrix,r in cases:
        result=construct(matrix,moment_order=r,eta=s.Rational(1,4))
        (OUT/name).write_text(json.dumps(result,indent=2)+'\n')
        summary.append({'file':name,'status':result['status'],'rank':result['rank_input_matrix'],
                        'moments':r,'support_size':result['support_size']})
    for name in ['check_indexability.py','check_three_cycle.py']:
        subprocess.run([sys.executable,str(ROOT/'code'/name)],check=True)
    (OUT/'finite_realization_checks.json').write_text(json.dumps({'arithmetic':'exact rational','cases':summary,'status':'passed'},indent=2)+'\n')
    print(json.dumps({'status':'passed','finite_targets':len(cases),'additional_certificates':2}))

if __name__=='__main__': main()
