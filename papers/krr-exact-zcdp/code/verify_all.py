#!/usr/bin/env python3
"""Run the three separate mathematical implementation checks."""
from pathlib import Path
import subprocess
import sys

ROOT=Path(__file__).resolve().parent.parent
for name in ['exact_certificate.py','verify_independent.py','verify_solver.py']:
    subprocess.run([sys.executable,'-B',str(ROOT/'code'/name)],cwd=ROOT,check=True)
print('PASS: rational examples, independent diagnostics, and main-solver cross-check')
