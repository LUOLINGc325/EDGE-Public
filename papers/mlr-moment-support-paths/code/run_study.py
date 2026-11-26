#!/usr/bin/env python3
"""Bounded reproducibility study, with retained per-instance certificates."""
import argparse
import hashlib
import json
from pathlib import Path
import time

from sweep import generate
from verify_certificate import verify


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--small-max-n",type=int,default=12)
    parser.add_argument("--output-dir",default=str(Path(__file__).parent/"study"))
    parser.add_argument("--extended",action="store_true")
    args=parser.parse_args()
    cases={(n,k) for n in range(3,args.small_max_n+1) for k in range(2,n)}
    cases.update({(7,4),(9,4),(10,6),(10,4),(11,4)})
    if args.extended:
        cases.update({(17,4),(23,6)})
    output=Path(args.output_dir)
    output.mkdir(parents=True,exist_ok=True)
    started=time.monotonic()
    results=[]
    for n,k in sorted(cases):
        certificate=generate(n,k)
        raw=(json.dumps(certificate,indent=2)+"\n").encode()
        target=output/f"n{n}_k{k}.json"
        target.write_bytes(raw)
        report=verify(certificate)
        report["certificate_sha256"]=hashlib.sha256(raw).hexdigest()
        (output/f"n{n}_k{k}_verified.json").write_text(json.dumps(report,indent=2)+"\n")
        row={"n":n,"k":k,"regimes":certificate["regime_count"],
             "bound":certificate["regime_bound"],
             "exceptional_points":certificate["exceptional_points"],
             "exact_passed":report["exact_certificate_passed"],
             "numerical_passed":report["all_numerical_checks_passed"],
             "generation_seconds":certificate["generation_seconds"],
             "verification_seconds":report["verifier_seconds"],
             "certificate_sha256":report["certificate_sha256"]}
        results.append(row)
        print(json.dumps(row),flush=True)
    summary={"instances":len(results),"total_regimes":sum(r["regimes"] for r in results),
             "all_exact_passed":all(r["exact_passed"] for r in results),
             "all_numeric_passed":all(r["numerical_passed"] for r in results),
             "scope":f"All 3 <= n <= {args.small_max_n}, 2 <= k < n; plus explicitly listed larger cases",
             "results":results,"seconds":round(time.monotonic()-started,6),
             "interpretation":"Finite exact certificates verify these instances, not the general theorem or a rational-exception conjecture"}
    (output/"summary.json").write_text(json.dumps(summary,indent=2)+"\n")
    print(json.dumps({key:value for key,value in summary.items() if key!="results"}),flush=True)


if __name__=="__main__":
    main()
