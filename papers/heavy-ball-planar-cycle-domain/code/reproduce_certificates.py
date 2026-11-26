#!/usr/bin/env python3
"""Recompute the four finite exact certificates without changing archived files.

This verifies deterministic certificate outputs, not the cited global spectral
theorems, the written proof, or full Lean formalization. Standard library only.
"""
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile


CASES = [
    ("check_rank_rigidity_g15.py", "rank_rigidity_g15_certificate.json"),
    ("check_rank_rigidity_k21.py", "rank_rigidity_k21_certificate.json"),
    ("check_planar_coherence_p1.py", "planar_coherence_p1_certificate.json"),
    ("fan7_certificate.py", "fan7_certificate.json"),
]


def sha(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--report", type=Path)
    args = parser.parse_args()
    code = Path(__file__).resolve().parent
    case = code.parent
    records = []
    with tempfile.TemporaryDirectory(prefix="heavy-ball-certificates-") as temp:
        work = Path(temp)
        for script, _ in CASES:
            shutil.copy2(code / script, work / script)
        for script, certificate in CASES:
            run = subprocess.run([sys.executable, str(work / script)],
                                 check=True, capture_output=True, text=True)
            if script == "fan7_certificate.py":
                regenerated = json.loads((work / certificate).read_text())
                passed = regenerated.get("verified") is True
            else:
                regenerated = json.loads(run.stdout)
                passed = regenerated.get("status") == "PASS"
            archived = json.loads((case / "results" / certificate).read_text())
            if not passed:
                raise RuntimeError(f"Certificate did not pass: {script}")
            if regenerated != archived:
                raise RuntimeError(f"Certificate differs from archive: {certificate}")
            records.append({"script": script, "status": "PASS",
                            "script_sha256": sha(code / script),
                            "certificate": certificate,
                            "archived_certificate_sha256": sha(case / "results" / certificate),
                            "semantic_output_matches_archive": True})
    report = {"status": "PASS", "python": sys.version,
              "certificate_count": len(records), "checks": records,
              "scope": "Finite rational/algebraic checks and exact archived-output comparison only",
              "not_verified": ["Cited global spectral theorems and parameter existence",
                               "Complete planar domain characterization",
                               "Whole manuscript Lean formalization"]}
    result = json.dumps(report, ensure_ascii=False, indent=2) + "\n"
    if args.report:
        args.report.parent.mkdir(parents=True, exist_ok=True)
        args.report.write_text(result, encoding="utf-8")
    print(result, end="")


if __name__ == "__main__":
    main()
