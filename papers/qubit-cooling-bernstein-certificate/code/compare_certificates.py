"""Independent audit: compare full forward-DP minima and brute-force small m.

This script does not import the author verifier. The small-m enumeration
constructs the monomial polynomial first, then transforms its coefficients.
"""
from fractions import Fraction
from math import comb
from pathlib import Path
import csv
import hashlib
import json

ROOT = Path(__file__).resolve().parent.parent
AUTHOR = ROOT / 'results' / 'exact_certificate.json'
FORWARD = ROOT / 'results' / 'bernstein_independent_forward_up_to_64.csv'

def choose0(n, k):
    return comb(n, k) if n >= k >= 0 else 0

def compositions(m):
    # Separator-bit enumeration, independent of both dynamic programs.
    for mask in range(1 << (m - 1)):
        parts = []
        start = 0
        for pos in range(1, m):
            if mask & (1 << (pos - 1)):
                parts.append(pos - start)
                start = pos
        parts.append(m - start)
        yield parts

data = json.loads(AUTHOR.read_text())
rows = data['results']
original = {(r['m'], r['k']): Fraction(r['minimum']) for r in rows}
with FORWARD.open(newline='') as f:
    independent_rows = list(csv.DictReader(f))
independent = {
    (int(r['m']), int(r['k'])): Fraction(int(r['numerator']), int(r['denominator']))
    for r in independent_rows
}
keys = {(m, k) for m in range(2, 65) for k in range(m)}
assert len(rows) == len(original) == len(keys) == 2079
assert len(independent_rows) == len(independent) == len(keys)
assert set(original) == set(independent) == keys
assert all(original[key] == independent[key] >= 0 for key in keys)

for r in rows:
    m, k = r['m'], r['k']
    expected = comb(m + 2, 4) - choose0(m - k + 1, 4)
    assert r['transitions'] == expected
    assert r['nonnegative'] is True
author_transitions = sum(r['transitions'] for r in rows)
assert author_transitions == data['transitions'] == 418498080
assert author_transitions == 4 * comb(67, 6) + 2 * comb(67, 5)
for r in independent_rows:
    m = int(r['m'])
    assert int(r['transitions']) == comb(m, 2) + choose0(m + 1, 4)
forward_transitions = sum(int(r['transitions']) for r in independent_rows)

small_results = []
total_compositions = 0
for m in range(2, 13):
    d = m - 1
    minima = [None] * m
    count = 0
    # Evaluate g_i = coefficient of t^i in G(t), then the generic
    # monomial-to-Bernstein identity, without the weighted-edge formula.
    for n in compositions(m):
        count += 1
        g = [Fraction(d * a, m) for a in n]
        for i in range(len(n) - 1):
            h = Fraction(n[i] * n[i + 1], n[i] + n[i + 1])
            g[i] -= h
            g[i + 1] -= h
        for k in range(m):
            value = sum((g[i] * Fraction(comb(k, i), comb(d, i))
                         for i in range(min(k, len(g) - 1) + 1)), Fraction(0))
            if minima[k] is None or value < minima[k]:
                minima[k] = value
    assert count == 2 ** (m - 1)
    assert all(minima[k] == independent[m, k] for k in range(m))
    total_compositions += count
    small_results.append({'m': m, 'compositions': count,
                          'minima': [str(x) for x in minima]})

paths = [AUTHOR, ROOT/'code'/'exact_certificate.py', FORWARD,
         ROOT/'code'/'independent_forward.cpp', Path(__file__).resolve()]
report = {
    'status': 'passed',
    'scope': 'All 2079 Bernstein minima for every 2<=m<=64; no all-m claim',
    'independent_method': 'C++ GMP arbitrary precision; forward all-length composition DP; Pascal binomial LCM weights; no tail compression',
    'coefficient_count': len(keys),
    'all_exact_minima_equal': True,
    'all_minima_nonnegative': True,
    'author_transitions': author_transitions,
    'forward_transitions': forward_transitions,
    'independent_bruteforce_dimension_max': 12,
    'independent_bruteforce_compositions': total_compositions,
    'independent_bruteforce_matches': True,
    'small_dimension_results': small_results,
    'sha256': {p.name: hashlib.sha256(p.read_bytes()).hexdigest() for p in paths},
    'limitations': [
        'No arbitrary-m analytic proof is implied.',
        'Exact minima tables and minimizers alone are not Bellman lower-bound certificates; the executable recurrence and independent full-domain recomputation supply the lower-bound evidence.',
        'No proof assistant or other model provider was used.',
    ],
}
out = ROOT / 'results' / 'independent_verification.json'
out.write_text(json.dumps(report, indent=2) + '\n')
print(json.dumps({k:v for k,v in report.items() if k not in ['small_dimension_results','sha256']}, indent=2))
