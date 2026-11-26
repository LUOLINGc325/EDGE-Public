#!/usr/bin/env python3
"""Integer checks for the analytic x=3 physical two-phase subsolution.

The universal result is proved in the physical-unit two-phase derivation in the manuscript.
This finite checker verifies its identities on a specified state simplex;
it does not extrapolate a finite check to arbitrary job counts.
"""
import argparse
import json
from math import comb
from pathlib import Path


def phi12(f, d, b):
    """Twelve times the continuous piecewise quadratic; exact integers."""
    r = f + d
    if f <= b:
        return 36 * b * f
    if f <= 2*d + 3*b:
        return 9 * (f+b)**2
    if f <= 2*d + 6*b:
        return 6*r*r + 36*b*f - 18*(b+d)**2
    return 12*r*(f+b) - 4*r*r + 54*b*b


def stop(f, b):
    return 3 * (b*f if f <= b else (f+b)**2 // 4)


def check(n):
    states = 0
    checks = {name: 0 for name in (
        "terminal", "continuous_stop", "continuous_test", "continuous_pending",
        "integer_stop", "integer_test", "integer_pending", "stop_rounding",
    )}
    for f in range(n+1):
        for d in range(n+1-f):
            for b in range(n+1-f-d):
                states += 1
                w = phi12(f,d,b)
                v = w // 12
                if f == 0:
                    assert w == 0
                    checks["terminal"] += 1
                    continue
                r = f+d
                sc = 36*b*f if f <= b else 9*(f+b)**2
                ts = 12*r + max(36*b+phi12(f-1,d,b), phi12(f-1,d+1,b))
                ti = r + max(3*b+phi12(f-1,d,b)//12,
                             phi12(f-1,d+1,b)//12)
                assert w <= sc, ("continuous_stop",f,d,b,w,sc)
                assert w <= ts, ("continuous_test",f,d,b,w,ts)
                assert v <= stop(f,b), ("integer_stop",f,d,b,v)
                assert v <= ti, ("integer_test",f,d,b,v,ti)
                assert sc//12 == stop(f,b)
                for name in ("continuous_stop", "continuous_test", "integer_stop",
                             "integer_test", "stop_rounding"):
                    checks[name] += 1
                if d:
                    wp = phi12(f,d-1,b+1)
                    assert w <= wp, ("continuous_pending",f,d,b,w,wp)
                    assert v <= wp//12, ("integer_pending",f,d,b,v,wp//12)
                    checks["continuous_pending"] += 1
                    checks["integer_pending"] += 1
    assert states == comb(n+3,3)
    roots = []
    for jobs in range(1,n+1):
        a = (jobs+1)//3
        lower = phi12(jobs,0,0)//12
        upper = jobs*a + 3*((jobs-a)**2//4)
        canonical = min(jobs*t+3*((jobs-t)**2//4) for t in range(jobs+1))
        assert lower == upper == canonical == 2*jobs*jobs//3
        roots.append({"n":jobs,"tests":a,"lower":lower,"upper":upper})
    return {
        "kind":"finite_integer_check_of_analytic_physical_subsolution",
        "x":3,
        "state_simplex_maximum":n,
        "states_checked":states,
        "arithmetic":"Python integers; phi multiplied by twelve",
        "local_checks":checks,
        "all_checks_passed":True,
        "roots":roots,
        "scope":"Finite verification only. The all-n theorem follows from the analytic proof.",
        "proof":"the physical-unit two-phase derivation in the manuscript",
    }


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--max-n",type=int,default=160)
    parser.add_argument("--output",type=Path)
    args=parser.parse_args()
    assert args.max_n >= 1
    result=check(args.max_n)
    out=args.output or Path(__file__).resolve().parents[1]/"results"/"physical_subsolution_check.json"
    out.parent.mkdir(parents=True,exist_ok=True)
    out.write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps({"output":str(out),"states_checked":result["states_checked"],
                      "local_checks":result["local_checks"],"all_checks_passed":True},indent=2))


if __name__ == "__main__":
    main()
