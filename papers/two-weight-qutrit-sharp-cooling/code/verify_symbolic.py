#!/usr/bin/env python3
"""Independent symbolic checks of the algebraic proof, not a general theorem prover.

No import from verify_product.py. Six shell maps are rebuilt as permutations of
three symbolic numbers. Geometric closed forms are separately checked in exact
rational arithmetic. The analytic manuscript proves the quantified inequalities.
"""
from __future__ import annotations

import argparse
from fractions import Fraction as R
from itertools import permutations
import json
from pathlib import Path
import sympy as sp


def require(value, message):
    if not value:
        raise RuntimeError(message)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    u, v, t, z = sp.symbols('u v t z', real=True)
    identities = []

    def identity(name, left, right):
        residual = sp.expand(left-right)
        require(residual == 0, name)
        identities.append({'name': name, 'left': str(left), 'right': str(right),
                           'expanded_residual': '0'})

    energy3 = u*u+v*v+(u-v)**2
    identity('same_sign_square_u', energy3-sp.Rational(3,2)*u*u,
             2*(v-u/2)**2)
    identity('same_sign_square_v', energy3-sp.Rational(3,2)*v*v,
             2*(u-v/2)**2)
    identity('opposite_sign_energy_u', energy3-2*u*u, 2*v*v-2*u*v)
    identity('opposite_sign_energy_v', energy3-2*v*v, 2*u*u-2*u*v)
    identity('rho_odd_to_even', (1-t*z)**2-(1-z)*(1-t*t*z),
             z*(1-t)**2)
    identity('rho_even_to_odd', (1-t*z)**3-(1-z)**2*(1-t**3*z),
             z*(1-t)**2*((t+2)-z*(2*t+1)))
    identity('even_to_odd_positive_bracket',
             (t+2)-z*(2*t+1), 2*(1-t*t)+(t-z)*(2*t+1))
    identity('universal_two_thirds', 4*(1+2*t*t)-3*(1+t*t)*(1+t),
             (1-t)*(3*t*t-2*t+1))
    identity('positive_quadratic', 3*t*t-2*t+1,
             3*(t-sp.Rational(1,3))**2+sp.Rational(2,3))
    identity('regime_switch', (1+t)/2-sp.Rational(2,3),
             (3*t-1)/6)
    identity('restricted_shell_energy', energy3.subs(v,u), 2*u*u)
    identity('L2_threshold_polynomial', (3*t)**2-(1+t*t)**2,
             -(t*t+3*t+1)*(t*t-3*t+1))

    # Rebuild the local catalogue without using the author's table.
    psi = [sp.Integer(0), u, v]
    shell_rows = []
    observed = set()
    for source in permutations(range(3)):
        delta = [psi[source[j]]-psi[j] for j in range(3)]
        energy = sp.expand(sum(d*d for d in delta))
        x = delta[0]
        require(sp.expand(sum(delta)) == 0, 'shell conservation')
        observed.add((str(x), str(energy)))
        shell_rows.append({'inverse_permutation': list(source),
                           'singleton_increment': str(x), 'energy_over_weight': str(energy)})
    expected = {
        ('0','0'), ('0',str(sp.expand(2*(u-v)**2))),
        ('u',str(2*u*u)), ('v',str(2*v*v)),
        ('u',str(sp.expand(energy3))), ('v',str(sp.expand(energy3)))
    }
    require(observed == expected, 'complete six-permutation catalogue')

    ratios = [R(1,100),R(1,9),R(1,4),R(1,2),R(3,4),R(9,10),R(99,100)]
    geometric_count = 0
    for s in ratios:
        previous = R(0)
        for L in range(2,65):
            A = sum((s**j for j in range(0,L,2)),R(0))
            B = sum((s**j for j in range(1,L,2)),R(0))
            T = sum((s**j for j in range(1,L)),R(0))
            rho_squared = T*T/(A*B)
            if L % 2 == 0:
                closed = (1+s)**2*s*(1-s**(L-1))**2/(1-s**L)**2
            else:
                closed = (1+s)**2*s*(1-s**(L-1))/(1-s**(L+1))
            require(rho_squared == closed, f'geometric closed form {s} {L}')
            require(previous < rho_squared < (1+s)**2*s,
                    f'monotone strict interval {s} {L}')
            previous = rho_squared
            geometric_count += 1

    result = {'status':'passed', 'arithmetic':'symbolic polynomials over Q; fractions.Fraction',
              'scope':'Symbolic identities, complete three-label shell catalogue, finite geometric checks. This does not certify all p, all permutations, or the entire paper.',
              'sympy_version':sp.__version__, 'symbolic_identity_count':len(identities),
              'identities':identities, 'shell_permutations':shell_rows,
              'geometric_checks':geometric_count, 'geometric_L_range':[2,64],
              'geometric_s_values':[str(s) for s in ratios]}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({k:result[k] for k in ['status','symbolic_identity_count','geometric_checks']}))


if __name__ == '__main__':
    main()
