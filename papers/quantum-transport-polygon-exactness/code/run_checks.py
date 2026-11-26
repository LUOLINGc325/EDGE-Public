#!/usr/bin/env python3
"""Run the finite exact checks and record observed exit codes."""
import hashlib
import json
from pathlib import Path
import platform
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]


def main():
    jobs = [
        (['code/verify_polygon_exact.py','--output','results/exact_verification.json'],0),
        (['-O','code/verify_polygon_exact.py','--output','results/exact_verification_optimized.json'],0),
        (['-O','code/verify_polygon_exact.py','--negative-control','--output','results/negative_control.json'],1),
        (['code/verify_algorithm.py','results/algorithm_verification.json'],0),
        (['code/polygon_solver.py','--points','0','1','2','3','--q','2','--output','results/example_four_levels.json'],0),
        (['code/polygon_solver.py','--points','0','1','2','3','4','--q','2','--output','results/example_five_levels.json'],0),
    ]
    records = []
    passed = True
    for arguments, expected in jobs:
        proc = subprocess.run([sys.executable]+arguments,cwd=ROOT,text=True,capture_output=True)
        matched = proc.returncode == expected
        passed = passed and matched
        records.append({'command':'python3 '+' '.join(arguments),'exit_code':proc.returncode,
                        'expected_exit_code':expected,'passed':matched,'stdout':proc.stdout,'stderr':proc.stderr})
    normal = ROOT/'results/exact_verification.json'
    optimized = ROOT/'results/exact_verification_optimized.json'
    equal = normal.read_bytes() == optimized.read_bytes()
    passed = passed and equal
    result = {'status':'passed' if passed else 'failed','python':platform.python_version(),
              'standard_library_only':True,'normal_and_optimized_outputs_identical':equal,
              'exact_verification_sha256':hashlib.sha256(normal.read_bytes()).hexdigest(),
              'commands':records,
              'scope':'Finite rational checks and code verification; no claim of universal machine proof.'}
    (ROOT/'results/checks_summary.json').write_text(json.dumps(result,indent=2,sort_keys=True)+'\n',encoding='utf-8')
    print(json.dumps({k:v for k,v in result.items() if k != 'commands'},indent=2))
    return 0 if passed else 1


if __name__ == '__main__':
    raise SystemExit(main())
