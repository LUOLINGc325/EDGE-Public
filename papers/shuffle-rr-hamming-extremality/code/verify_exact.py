#!/usr/bin/env python3
"""Exact finite checks by enumerating the original randomized-response outputs.

This is computational evidence for explicitly listed finite instances, not the
proof of the arbitrary-dimensional theorem. Only Python's standard library is used.
"""
from collections import defaultdict
from fractions import Fraction as Q
from itertools import product
from pathlib import Path
import argparse
import hashlib
import json
import math


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def clean(law):
    return {v: p for v, p in law.items() if p}


def canonical(law):
    return [[str(v), str(law[v])] for v in sorted(law)]


def fingerprint(law):
    return hashlib.sha256(json.dumps(canonical(law), separators=(',', ':')).encode()).hexdigest()


def rr_probability(x, y, k, r):
    return math.prod((rj if a == b else Q(1)) / (rj + kj - 1)
                     for a, b, kj, rj in zip(x, y, k, r))


def original_law(k, r, lam, mask, x=None, xp=None):
    m = len(k)
    x = tuple(0 for _ in k) if x is None else tuple(x)
    xp = tuple(int(bool(mask & (1 << j))) for j in range(m)) if xp is None else tuple(xp)
    alphabet = list(product(*(range(kj) for kj in k)))
    common_mass = math.prod(Q(1) / (rj + kj - 1) for kj, rj in zip(k, r))
    gamma = len(alphabet) * common_mass
    require(Q(0) < gamma <= 1, 'invalid blanket mass')
    law = defaultdict(Q)
    law[Q(0)] += 1 - gamma
    px_total = Q(0)
    pxp_total = Q(0)
    for y in alphabet:
        px = rr_probability(x, y, k, r)
        pxp = rr_probability(xp, y, k, r)
        px_total += px
        pxp_total += pxp
        # Definition 9: the nonzero G value is (R_x-lambda R_x')/(gamma omega).
        value = (px - lam * pxp) / common_mass
        law[value] += common_mass
    law = clean(law)
    require(px_total == pxp_total == 1, 'original channel normalization failed')
    require(sum(law.values()) == 1, 'G law is not normalized')
    require(sum(v*p for v, p in law.items()) == 1-lam, 'G mean failed')
    return law


def convolve(a, b):
    c = defaultdict(Q)
    for x, p in a.items():
        for y, q in b.items():
            c[x+y] += p*q
    return clean(c)


def stop_loss(law, t):
    return sum(((v-t)*p for v, p in law.items() if v > t), Q(0))


def all_stop_losses(law, knots):
    # Exact reverse cumulative sums; both tails are affine between consecutive knots.
    support = sorted(law, reverse=True)
    j = 0
    mass = Q(0)
    first = Q(0)
    out = {}
    for t in sorted(knots, reverse=True):
        while j < len(support) and support[j] > t:
            v = support[j]
            mass += law[v]
            first += v*law[v]
            j += 1
        out[t] = first-t*mass
    return out


def check_convex_order(a, b):
    require(sum(a.values()) == sum(b.values()) == 1, 'mass mismatch')
    require(sum(v*p for v,p in a.items()) == sum(v*p for v,p in b.items()), 'mean mismatch')
    knots = set(a) | set(b)
    sa = all_stop_losses(a, knots)
    sb = all_stop_losses(b, knots)
    for t in knots:
        require(sa[t] <= sb[t], f'convex-order violation at {t}: {sa[t]} > {sb[t]}')
    return len(knots)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--cases', type=Path, default=Path(__file__).with_name('cases.json'))
    parser.add_argument('--output', type=Path, default=Path(__file__).resolve().parents[1]/'results'/'exact_checks.json')
    args = parser.parse_args()
    suite = json.loads(args.cases.read_text())
    rows = []
    comparisons = 0
    knots_checked = 0
    labels_checked = 0
    for case in suite['cases']:
        k = case['k']; r = tuple(map(Q, case['r'])); m = len(k)
        for lam in map(Q, case['lambda']):
            base = {mask: original_law(k,r,lam,mask) for mask in range(1 << m)}
            sums = {mask:{Q(0):Q(1)} for mask in base}
            for n in range(1, max(case['n'])+1):
                sums = {mask:convolve(sums[mask],base[mask]) for mask in base}
                if n not in case['n']:
                    continue
                for mask in range(1 << m):
                    law = sums[mask]
                    rows.append({'case':case['id'],'lambda':str(lam),'n':n,'mask':mask,
                                 'support':len(law),'law_sha256':fingerprint(law),
                                 'bound':str(stop_loss(law,Q(0))/n)})
                    for j in range(m):
                        if not mask & (1 << j):
                            knots_checked += check_convex_order(law,sums[mask | (1 << j)])
                            comparisons += 1
            # Test original input-label symmetry, without assuming a canonical pair.
            if m <= 2:
                alphabet = list(product(*(range(kj) for kj in k)))
                for x in alphabet:
                    for xp in alphabet:
                        mask = sum(1 << j for j in range(m) if x[j] != xp[j])
                        require(original_law(k,r,lam,mask,x,xp) == base[mask], 'label symmetry failed')
                        labels_checked += 1
    # A strictness counterexample to a stronger, false assertion.
    a = original_law([2,2],(Q(2),Q(2)),Q(1),1)
    b = original_law([2,2],(Q(2),Q(2)),Q(1),3)
    require(stop_loss(a,Q(0)) == stop_loss(b,Q(0)) == Q(1,3), 'equality witness failed')
    # Explicit zero local-privacy boundary.
    require(original_law([2],(Q(1),),Q(1),1) == {Q(0):Q(1)}, 'zero budget failed')
    record = {'status':'PASS','arithmetic':'exact fractions; no floating-point tolerance',
              'method':'enumerate original channel outputs, compute G from Definition 9, exact iid convolution',
              'source_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
              'cases_sha256':hashlib.sha256(args.cases.read_bytes()).hexdigest(),
              'law_instances':len(rows),'edge_convex_order_checks':comparisons,
              'stop_loss_knots_checked':knots_checked,'original_label_pairs_checked':labels_checked,
              'strictness_counterexample':{'k':[2,2],'r':['2','2'],'lambda':'1','n':1,'B_h1':'1/3','B_h2':'1/3'},
              'rows':rows,
              'scope':'Listed finite instances only. Arbitrary parameters require the analytic and Lean proofs.'}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(record,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({k:v for k,v in record.items() if k!='rows'},ensure_ascii=False,indent=2))


if __name__ == '__main__':
    main()
