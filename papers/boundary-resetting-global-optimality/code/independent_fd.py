#!/usr/bin/env python3
"""Independent full backward-equation finite-difference verification.

This deliberately does not use the q-transform, the homogeneous s/k formula,
or the quantile representation. It solves the original nonlocal resetting BVP
for each target and integrates the resulting cost changes. Floating-point
convergence checks are supplementary; the rational certificate proves the
small beta=2 perturbation's sign.
"""
import argparse
from fractions import Fraction as F
import json
import math
from pathlib import Path
import platform

import numpy as np
import scipy
from scipy.integrate import simpson
from scipy.linalg import solve_banded
from scipy.special import roots_jacobi


def band(x, lower, upper):
    """Cell-average convention at mesh-aligned jump points (null-set choices)."""
    z=np.zeros_like(x,dtype=float)
    z[(x>lower)&(x<upper)]=1.
    z[np.isclose(x,lower,rtol=0,atol=1e-13)]=.5
    z[np.isclose(x,upper,rtol=0,atol=1e-13)]=.5
    return z


# Each tuple is (side, nonnegative radial lower, radial upper, rate).
# Side is -1 or +1. Every geometric endpoint aligns with all reported meshes.
PROFILES={
    'zero':[],
    'constant_2':[(-1,F(0),F(1),F(2)),(1,F(0),F(1),F(2))],
    'left_only_4':[(-1,F(0),F(1),F(4))],
    'symmetric_inner_bands_6':[(-1,F(1,4),F(3,8),F(6)),(1,F(1,4),F(3,8),F(6))],
    'symmetric_outer_bands_1':[(-1,F(3,4),F(7,8),F(1)),(1,F(3,4),F(7,8),F(1))],
    'asymmetric_bands':[(-1,F(1,4),F(1,2),F(4)),(1,F(5,8),F(3,4),F(7))],
    'certified_outer_bands_epsilon':[(-1,F(3,4),F(7,8),F(1,100000)),(1,F(3,4),F(7,8),F(1,100000))],
}


def make_rate(segments):
    def rate(x):
        out=np.zeros_like(x,dtype=float)
        for side,lo,hi,amplitude in segments:
            if side>0:
                out += float(amplitude)*band(x,float(lo),float(hi))
            else:
                out += float(amplitude)*band(-x,float(lo),float(hi))
        return out
    return rate


def uniform_lower_bound(segments):
    # Exact integral of x^2(1-x)^2 / 8 on each side's interval.
    def primitive(x): return x**3/F(3)-x**4/F(2)+x**5/F(5)
    return sum((amplitude*(primitive(hi)-primitive(lo))/8
                for side,lo,hi,amplitude in segments),F(0))


def target_cost_changes(rate,m,side):
    """Return delta T(side*j/m) for j=0,...,m.

    On [-1,a], eliminate m(-1)=m(0), keep m(a)=0. The resulting
    finite-difference matrix is a tridiagonal matrix minus one column.
    The two banded solves are a Sherman-Morrison elimination of that column.
    Solving directly for the cost change avoids cancellation at epsilon=1e-5.
    """
    delta=np.zeros(m+1)
    minimum_denominator=1.
    for j in range(1,m+1):
        x=np.arange(-m+1,j,dtype=float)/m
        r=rate(side*x)
        n=len(x)
        inverse_h2=float(m*m)
        ab=np.zeros((3,n))
        ab[0,1:]=-inverse_h2
        ab[1,:]=2*inverse_h2+r
        ab[2,:-1]=-inverse_h2
        center=m-1
        column=r.copy()
        column[0]+=inverse_h2
        # K m0 = r(x) [m0(0)-m0(x)], with the exact quadratic m0.
        source=r*(x+x*x)/2
        solved=solve_banded((1,1),ab,np.column_stack((source,column)),
                            check_finite=False)
        denominator=1-solved[center,1]
        if denominator<=0:
            raise ArithmeticError('nonpositive resetting resolvent denominator')
        minimum_denominator=min(minimum_denominator,float(denominator))
        delta[j]=solved[center,0]/denominator
    return delta,minimum_denominator


def average_change(half_pair_change,m,beta):
    a=np.linspace(0.,1.,m+1)
    if beta==1:
        return float(simpson(half_pair_change,x=a))
    if beta==2:
        return float(simpson(half_pair_change*1.5*(1-a*a),x=a))
    # Gauss-Jacobi handles the integrable (1-a)^(beta-1) endpoint weight.
    # Interpolate only the bounded delta T, not the singular target density.
    z,w=roots_jacobi(max(256,m),beta-1,0)
    points=(z+1)/2
    c=math.gamma(beta+.5)/(math.sqrt(math.pi)*math.gamma(beta))
    weight_scale=2*c/(2**beta)
    values=np.interp(points,a,half_pair_change)
    return float(weight_scale*np.sum(w*(1+points)**(beta-1)*values))


def baseline(beta):
    c=math.gamma(beta+.5)/(math.sqrt(math.pi)*math.gamma(beta))
    return c/(2*beta)+1/(2*(2*beta+1))


def run(meshes):
    betas=(.5,1.,2.)
    rows=[]
    homogeneous_errors=[]
    for m in meshes:
        if m%16:
            raise ValueError('mesh sizes must be divisible by 16')
        for name,segments in PROFILES.items():
            rate=make_rate(segments)
            plus,den_plus=target_cost_changes(rate,m,1)
            minus,den_minus=target_cost_changes(rate,m,-1)
            pair=(plus+minus)/2
            lower=uniform_lower_bound(segments)
            costs=[]
            for beta in betas:
                change=average_change(pair,m,beta)
                costs.append({'beta':beta,'baseline':baseline(beta),
                              'cost_change':change,'cost':baseline(beta)+change})
            row={'mesh_half_intervals':m,'profile':name,
                 'costs':costs,'uniform_global_lower_bound_exact':str(lower),
                 'uniform_lower_bound_margin':costs[1]['cost_change']-float(lower),
                 'minimum_rank_one_denominator':min(den_plus,den_minus)}
            rows.append(row)
            if name=='constant_2':
                points=np.arange(1,m+1)/m
                exact=(np.cosh((points+.5)*math.sqrt(2))/math.cosh(math.sqrt(2)/2)-1)/2
                computed=(points+points*points)/2+plus[1:]
                homogeneous_errors.append({'mesh_half_intervals':m,
                                           'maximum_targetwise_absolute_error':float(np.max(abs(computed-exact)))})
    finest=meshes[-1]
    last=[r for r in rows if r['mesh_half_intervals']==finest]
    zero_rows=[r for r in rows if r['profile']=='zero']
    certified=[r for r in last if r['profile']=='certified_outer_bands_epsilon'][0]
    numerical_sign=certified['costs'][2]['cost_change']<0
    checks={
        'zero_profile_exact_numerical_changes':all(c['cost_change']==0. for r in zero_rows for c in r['costs']),
        'outward_targets_nonnegative_on_finest_mesh':all(c['cost_change']>=-1e-10 for r in last for c in r['costs'] if c['beta']<=1),
        'uniform_quantitative_bound_on_finest_mesh':all(r['uniform_lower_bound_margin']>=-1e-9 for r in last),
        'homogeneous_formula_error_decreases':all(homogeneous_errors[i+1]['maximum_targetwise_absolute_error']<homogeneous_errors[i]['maximum_targetwise_absolute_error'] for i in range(len(homogeneous_errors)-1)),
        'certified_beta2_perturbation_negative_numerically':numerical_sign,
    }
    if not all(checks.values()):
        raise AssertionError(checks)
    return {
        'status':'passed',
        'scope':'independent discretization and convergence checks, not a proof of continuum optimality or a rigorous floating-point enclosure',
        'method':'original nonlocal backward boundary-value equation; centered finite differences; rank-one nonlocal column elimination; baseline-subtracted linear solve',
        'density_integration':'Simpson for beta=1,2; Gauss-Jacobi with piecewise-linear cost interpolation for beta=1/2',
        'jump_treatment':'cell-average 1/2 at mesh-aligned band endpoints',
        'environment':{'python':platform.python_version(),'numpy':np.__version__,'scipy':scipy.__version__},
        'mesh_half_intervals':meshes,
        'baseline_values':{str(beta):baseline(beta) for beta in betas},
        'profiles':{name:[{'side':s,'lower':str(lo),'upper':str(hi),'rate':str(r)} for s,lo,hi,r in ss] for name,ss in PROFILES.items()},
        'homogeneous_closed_formula_comparison':homogeneous_errors,
        'checks':checks,
        'results':rows,
    }


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--meshes',type=int,nargs='+',default=[128,256,512])
    parser.add_argument('--output',type=Path)
    args=parser.parse_args()
    result=run(args.meshes)
    if args.output:
        args.output.parent.mkdir(parents=True,exist_ok=True)
        args.output.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'status':result['status'],'checks':result['checks'],
                      'homogeneous_errors':result['homogeneous_closed_formula_comparison'],
                      'finest_grid_results':[{'profile':r['profile'],'cost_changes':{str(c['beta']):c['cost_change'] for c in r['costs']},'uniform_bound_margin':r['uniform_lower_bound_margin']} for r in result['results'] if r['mesh_half_intervals']==args.meshes[-1]]},indent=2))


if __name__=='__main__': main()
