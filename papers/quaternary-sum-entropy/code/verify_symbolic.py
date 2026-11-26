#!/usr/bin/env python3
"""Exact algebra behind the manuscript; does not prove the original conjecture."""
import argparse,json
from pathlib import Path
import sympy as s

def run():
    a,b,c,d,r=s.symbols('a b c d r',real=True)
    A=a+b*r/2-c*r*r/2-d*r**3;I=b*r+c*r*r;M=a-b*r+c*r*r-d*r**3
    R=a*b-a*c*r+b*c*r*r-b*d*r**3+c*d*r**4
    checks={}
    def check(name,e):
        e=s.simplify(s.expand(e));assert e==0,(name,e);checks[name]='exact_zero'
    check('cubic_norm_gap',A*A+s.Rational(3,4)*I*I-M*M-3*r*R)
    check('cubic_phase_wronskian',s.diff(I,r)*A-I*s.diff(A,r)-(a*b+2*a*c*r+b*c*r*r+2*b*d*r**3+c*d*r**4))
    def P(z):return a+b*z+c*z*z+b*z**3+a*z**4
    z1=r*(1+s.I)/s.sqrt(2);z3=r*(-1+s.I)/s.sqrt(2)
    check('quartic_norm_gap',P(z1)*s.conjugate(P(z1))-P(z3)*s.conjugate(P(z3))-2*s.sqrt(2)*b*r*(1+r*r)*(a*(r*r-1)**2+c*r*r))
    u,v,t=s.symbols('u v t',positive=True);K=1+u*(t**-2-t**-1)+v*(t*t-t)
    check('ratio_substitution',R.subs({a:u*b*b/c,d:v*c*c/b,r:b*t/c})/(b*c*(b*t/c)**2)-K)
    check('symmetric_nonnegative_part',t**-2-t**-1+t*t-t-(t+1/t-2)*(t+1/t+1))
    f=t*t/(t-1)+v*t**3
    check('phi_stationary_equation',s.diff(f,t)-t*((t-2)/(t-1)**2+3*v*t))
    check('phi_value',f.subs(v,(2-t)/(3*t*(t-1)**2))-t*t*(2*t-1)/(3*(t-1)**2))
    delta=s.symbols('delta',positive=True);check('sharp_strip',K.subs({u:4+delta,v:delta/16,t:2})+delta/8)
    x0,x3,y0,y3,z0,z3=s.symbols('x0 x3 y0 y3 z0 z3')
    E0=x0*y0*z0;E3=x3*y3*z3;E1=x3*y0*z0+x0*y3*z0+x0*y0*z3;E2=x0*y3*z3+x3*y0*z3+x3*y3*z0
    check('endpoint_sos',E1*E2-9*E0*E3-x0*x3*(y0*z3-y3*z0)**2-y0*y3*(x0*z3-x3*z0)**2-z0*z3*(x0*y3-x3*y0)**2)
    z=s.symbols('z');check('actual_witness',(1+z*z)**2*(1+z+z**3)-(1+z+2*z*z+3*z**3+z**4+3*z**5+z**7))
    N=s.symbols('N');check('curvature_numerator',(4/(N+2)-8/(N*(3*N-4))-s.Rational(3,4)/N)*4*N*(N+2)*(3*N-4)-(39*N*N-102*N-40))
    return {'status':'passed','sympy_version':s.__version__,'checks':checks,'scope':'11 exact identities only; no original-conjecture or full formalization claim','reconstruction':'Reconstructed after execution interruption and rerun; not claimed byte-identical to the lost local script.'}

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--output',type=Path);args=p.parse_args()
    text=json.dumps(run(),ensure_ascii=False,indent=2)+'\n'
    if args.output:args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(text)
    print(text,end='')
