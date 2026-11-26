#!/usr/bin/env python3
"""Cross-check the main approximation against the independent implementation."""
import json
from pathlib import Path

import mpmath as mp
from krr_zcdp import solve

ROOT=Path(__file__).resolve().parent.parent


def main():
    mp.mp.dps=85
    data=json.loads((ROOT/'results/independent_checks.json').read_text())
    rows=[]
    for row in data['cases']:
        result=solve(row['k'],row['epsilon'],60)
        err=abs(mp.mpf(result.rho)-mp.mpf(row['rho']))
        if err>mp.mpf('1e-42')*max(1,abs(mp.mpf(row['rho']))):
            raise ArithmeticError(('value mismatch',row['k'],row['epsilon'],str(err)))
        if result.regime!=row['mode']:
            raise ArithmeticError('regime mismatch')
        rows.append({'k':row['k'],'epsilon':row['epsilon'],
                     'absolute_difference':mp.nstr(err,12)})
    zero=solve(100,'0',60)
    if zero.rho!='0' or zero.alpha is not None:
        raise ArithmeticError('zero-privacy case failed')
    rejected=0
    for k,e in [(1,'1'),(2,'-1'),(True,'1'),(2,'nan'),(2,'inf')]:
        try:
            solve(k,e)
        except ValueError:
            rejected+=1
        else:
            raise ArithmeticError('invalid input accepted')
    output={'status':'PASS','case_count':len(rows),'zero_case':'PASS',
            'invalid_inputs_rejected':rejected,
            'scope':'Independent approximation agreement, not interval certification',
            'cases':rows}
    (ROOT/'results/solver_crosscheck.json').write_text(json.dumps(output,indent=2)+'\n')
    print(f'PASS: main solver matches {len(rows)} independent cases; zero and invalid inputs checked')


if __name__=='__main__':
    main()
