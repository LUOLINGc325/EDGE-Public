#!/usr/bin/env python3
"""High-precision method-of-steps checks, independent of the amplitude integral.

The solver integrates the original deficit DDE, preserving the logarithmic
history. Two different meshes and Taylor orders are compared. These are
numerical checks, not certified enclosures of the optimization theorem.
"""
import argparse
import json
from pathlib import Path
import mpmath as mp


def horner(coefficients, x):
    value = mp.mpf(0)
    for coefficient in reversed(coefficients):
        value = value*x + coefficient
    return value


def deficit_at(alpha, time, mesh=8, order=80):
    """D=1/(alpha-1)-psi, D'=(D-D(t-1))/alpha for t>1."""
    if not (1 < alpha <= 2 and time >= 0 and mesh >= 2 and order >= 2):
        raise ValueError("invalid DDE parameters")
    b = alpha - 1
    if time <= 1:
        return 1/b - mp.log1p(time/b)
    step = mp.mpf(1)/mesh
    histories = []
    for j in range(mesh):
        start = mp.mpf(j)/mesh
        coeff = [1/b - mp.log1p(start/b)]
        coeff.extend((-1)**k / (mp.mpf(k)*(b+start)**k)
                     for k in range(1,order+1))
        histories.append(coeff)
    value = 1/b - mp.log1p(1/b)  # exact continuity at the derivative jump
    j = mesh
    while mp.mpf(j)/mesh < time:
        start = mp.mpf(j)/mesh
        coeff = [value]
        delayed = histories[j-mesh]
        for k in range(order):
            coeff.append((coeff[k]-delayed[k])/(alpha*(k+1)))
        length = min(step, time-start)
        value = horner(coeff, length)
        histories.append(coeff)
        j += 1
    return value


def optimum_gap(q, mesh, order, c, amplitude):
    time = 1/q
    if q == 1:
        return 2-mp.e/(mp.e-1)
    def residual(gap):
        return gap-(1-gap)*deficit_at(2-gap,time,mesh,order)
    guess = amplitude*mp.exp(-c*time)
    gap = mp.findroot(residual, (guess*mp.mpf('0.95'),guess*mp.mpf('1.05')),
                      tol=mp.mpf('1e-85'), solver='secant', maxsteps=40)
    if not (0 < gap < mp.mpf('0.5')):
        raise ArithmeticError("invalid optimum gap")
    residual_value = abs(residual(gap))
    if residual_value > mp.mpf('1e-80'):
        raise ArithmeticError("root residual exceeds tolerance")
    return gap


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output',type=Path)
    parser.add_argument('--quick',action='store_true')
    args=parser.parse_args()
    mp.mp.dps=110
    c=mp.findroot(lambda x:mp.exp(x)-1-2*x,mp.mpf('1.25'))
    amplitude=mp.exp(c)/(c*(2*c-1))*mp.quad(lambda x:mp.expm1(c*x)/(1+x),[0,1])
    denominators=[1,2,4,8,16] if args.quick else [1,2,4,8,16,32,48,64]
    rows=[]
    for denominator in denominators:
        q=mp.mpf(1)/denominator
        first=optimum_gap(q,8,100,c,amplitude)
        second=optimum_gap(q,16,80,c,amplitude)
        rel_difference=abs(first-second)/abs(second)
        if rel_difference>mp.mpf('1e-32'):
            raise ArithmeticError('two numerical discretizations disagree')
        normalized=second*mp.exp(c/q)
        source_strategy_gap=1/mp.expm1(c/q)
        if second < source_strategy_gap:
            raise ArithmeticError('optimal gap violates known strategy bound')
        if second > mp.power(2,1-int(mp.floor(1/q))):
            raise ArithmeticError('optimal gap violates original lower ratio bound')
        row={
            'tail_mass_q': f'1/{denominator}',
            'T': denominator,
            'optimal_gap_numeric':mp.nstr(second,65),
            'scaled_gap_numeric':mp.nstr(normalized,50),
            'relative_error_of_leading_term':mp.nstr(second/(amplitude*mp.exp(-c/q))-1,35),
            'independent_mesh_relative_difference':mp.nstr(rel_difference,12),
            'source_strategy_gap_numeric':mp.nstr(source_strategy_gap,45),
        }
        rows.append(row)
        print(json.dumps(row),flush=True)
    payload={
        'status':'PASS',
        'scope':'high precision numerical checks; not rigorous global or floating-point certificates',
        'mpmath_version':mp.__version__,
        'decimal_precision':mp.mp.dps,
        'first_discretization':{'delay_mesh':8,'taylor_order':100},
        'second_discretization':{'delay_mesh':16,'taylor_order':80},
        'c_numeric':mp.nstr(c,65), 'amplitude_numeric':mp.nstr(amplitude,65),
        'rows':rows
    }
    if args.output:
        args.output.parent.mkdir(parents=True,exist_ok=True)
        args.output.write_text(json.dumps(payload,indent=2)+'\n')


if __name__=='__main__':
    main()
