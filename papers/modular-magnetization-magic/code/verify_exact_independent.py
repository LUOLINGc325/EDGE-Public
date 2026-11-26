"""Exact, standard-library falsification checks of positive-sector Laplace bounds.

Two independent representations are compared:
  (1) direct computational-basis Pauli sums, implemented with integer Walsh sums;
  (2) the 16-column, eight-row parity-constrained count.
No floating-point value is used to decide any check. This verifies finite instances,
not the general mathematical theorem or its asymptotic limit.
"""
from collections import defaultdict
from fractions import Fraction
from itertools import product
from math import comb, factorial, log2
from pathlib import Path
import json
import random


def walsh(values):
    out = list(values)
    stride = 1
    while stride < len(out):
        for start in range(0, len(out), 2 * stride):
            for i in range(start, start + stride):
                a, b = out[i], out[i + stride]
                out[i], out[i + stride] = a + b, a - b
        stride *= 2
    return out


def moment_from_basis(amplitudes):
    dimension = len(amplitudes)
    if dimension == 0 or dimension & (dimension - 1):
        raise ValueError('Dimension must be a power of two.')
    norm = sum(x*x for x in amplitudes)
    if norm == 0:
        raise ValueError('Zero vector.')
    total = 0
    for shift in range(dimension):
        coeff = walsh([amplitudes[x]*amplitudes[x ^ shift] for x in range(dimension)])
        total += sum(x**4 for x in coeff)
    return Fraction(total, dimension * norm**4)


def local_columns():
    cols = []
    for bits in product((0, 1), repeat=4):
        if sum(bits) % 2:
            continue
        for flip in (0, 1):
            cols.append(bits + tuple(b ^ flip for b in bits))
    if len(set(cols)) != 16:
        raise RuntimeError('Unexpected column count.')
    weights = sorted(sum(c) for c in cols)
    if weights != [0] + [4]*14 + [8]:
        raise RuntimeError('Unexpected column weights.')
    middle = [c for c in cols if sum(c) == 4]
    if [sum(c[i] for c in middle) for i in range(8)] != [7]*8:
        raise RuntimeError('Unbalanced middle columns.')
    return cols


def next_counts(counts, cols):
    out = defaultdict(int)
    for rows, ways in counts.items():
        for col in cols:
            out[tuple(x+y for x,y in zip(rows,col))] += ways
    return dict(out)


def serial(frac):
    return {'numerator':str(frac.numerator), 'denominator':str(frac.denominator)}


def main():
    cols = local_columns()
    counts = {(0,)*8: 1}
    dicke, modular, positive = [], [], []
    rng = random.Random(20261124)
    for N in range(1, 6):
        counts = next_counts(counts, cols)
        C = [counts.get((n,)*8, 0) for n in range(N+1)]
        for n in range(N+1):
            basis = [int(x.bit_count() == n) for x in range(2**N)]
            direct = moment_from_basis(basis)
            column = Fraction(C[n], comb(N,n)**4)
            if direct != column:
                raise RuntimeError(('Dicke disagreement',N,n,direct,column))
            dicke.append({'N':N, 'n':n, 'column_count':str(C[n]),'W':serial(direct)})
        for K in range(1,N+2):
            for r in range(K):
                sectors = [n for n in range(N+1) if n % K == r]
                if not sectors:
                    continue
                for a,b in [(1,1),(2,1),(1,3)]:
                    v = [a**(N-n)*b**n if n in sectors else 0 for n in range(N+1)]
                    norm = sum(comb(N,n)*v[n]**2 for n in sectors)
                    basis = [v[x.bit_count()] for x in range(2**N)]
                    direct = moment_from_basis(basis)
                    total = 0
                    for rows, ways in counts.items():
                        if all(n % K == r for n in rows):
                            total += ways * a**(8*N-sum(rows))*b**sum(rows)
                    column = Fraction(total,norm**4)
                    diagonal = Fraction(sum(C[n]*v[n]**8 for n in sectors),norm**4)
                    if direct != column:
                        raise RuntimeError(('Modular disagreement',N,K,r,a,b))
                    if not diagonal <= direct <= len(sectors)**7 * diagonal:
                        raise RuntimeError(('Laplace bound failure',N,K,r,a,b))
                    modular.append({'N':N,'K':K,'r':r,'a':a,'b':b,'M':len(sectors),
                                    'W':serial(direct),'diagonal':serial(diagonal)})
        for trial in range(20):
            v=[rng.randrange(0,5) for _ in range(N+1)]
            if not any(v): v[0]=1
            sectors=[n for n in range(N+1) if v[n]>0]
            norm=sum(comb(N,n)*v[n]**2 for n in sectors)
            direct=moment_from_basis([v[x.bit_count()] for x in range(2**N)])
            diagonal=Fraction(sum(C[n]*v[n]**8 for n in sectors),norm**4)
            if not diagonal <= direct <= len(sectors)**7 * diagonal:
                raise RuntimeError(('General positive sector bound failure',N,trial))
            positive.append({'N':N,'trial':trial,'sector_basis_amplitudes':v,
                             'M':len(sectors),'W':serial(direct),'diagonal':serial(diagonal)})

    # An exact scope guard: positivity cannot be silently replaced by arbitrary phases.
    # T^N has W=(3/4)^N.  For N=96, the n=48 diagonal contribution is at least
    # [96!/(6!)^16]/16^96, because each of the 16 columns can occur six times.
    N=96
    one_type=factorial(N)//factorial(N//16)**16
    phase_violates=one_type>12**N
    if not phase_violates:
        raise RuntimeError('Expected phase-scope counterexample disappeared.')
    phase_guard={'N':N,'K':1,'p':'1/2','phase':'pi/4','state':'T tensor power 96',
                 'one_admissible_type_count':str(one_type),'comparison_12_power_N':str(12**N),
                 'strict_integer_inequality':True,
                 'interpretation':'The diagonal lower bound fails without the nonnegative-amplitude assumption.'}
    summary={'all_checks_passed':True,'dicke_exact_cases':len(dicke),
             'modular_exact_cases':len(modular),'arbitrary_positive_sector_cases':len(positive),
             'phase_scope_counterexample_certified':phase_violates,
             'arithmetic':'Python integers and fractions.Fraction; no tolerance or float-based pass/fail'}
    result={'summary':summary,'dicke':dicke,'modular':modular,'positive_sectors':positive,'phase_scope_guard':phase_guard}
    target = Path(__file__).resolve().parents[1] / 'results' / 'exact_independent.json'
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps(summary,indent=2))


if __name__=='__main__':
    main()
