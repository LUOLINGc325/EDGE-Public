#!/usr/bin/env python3
"""Compare the cubic solver against an independently written exhaustive oracle."""
from fractions import Fraction as F
import json
from pathlib import Path
import sys

from polygon_solver import solve, verify_certificate
from verify_polygon_exact import cases, polygon_value


def main():
    records = []
    inputs = [('singleton', [[F(0)]]), ('zero3', [[F(0)]*3 for _ in range(3)])]
    inputs += list(cases())
    for label, a in inputs:
        result = solve(a)
        expected, _ = polygon_value(a)
        if F(result['delta']) != expected:
            raise ValueError(f'DP / exhaustive polygon mismatch in {label}')
        verify_certificate(a, expected, result['polygon_indices'], list(map(F,result['potential'])))
        records.append({'case': label, 'delta': result['delta'], 'status': 'passed'})
    # Boundary controls: the checker must reject a nonmonotone solution and
    # an array outside the theorem's hypotheses. No checks depend on assert.
    rejected = []
    for label, action in [
        ('violated_structure', lambda: solve([[0,1,1],[1,0,1],[1,1,0]])),
        ('bad_certificate', lambda: verify_certificate([[0,1],[1,0]],F(0),[0,1],[F(0),F(0)])),
    ]:
        try:
            action()
        except ValueError:
            rejected.append(label)
        else:
            raise ValueError(f'control unexpectedly accepted: {label}')
    result = {'status':'passed','cases':len(records),'arithmetic':'fractions.Fraction',
              'oracle':'exhaustive increasing chains, independently implemented',
              'negative_controls_rejected':rejected,'results':records}
    destination = Path(sys.argv[1]) if len(sys.argv)>1 else None
    if destination:
        destination.write_text(json.dumps(result,indent=2,sort_keys=True)+'\n',encoding='utf-8')
    print(json.dumps({k:v for k,v in result.items() if k != 'results'},indent=2))


if __name__ == '__main__':
    main()
