#!/usr/bin/env python3
"""Check elementary identities only; not verification of the theorem."""
import json, math
from pathlib import Path
import sympy as s
from scipy.special import gamma, airy
u,z,r,p=s.symbols('u z r p', real=True)
assert s.expand(z*z-u*z+u*u/3-z*z/8-u*u/24-s.Rational(7,8)*(z-4*u/7)**2-u*u/168)==0
third=(p-2)/(r*(1-r*r))-2*r/(1-r*r)**2
assert s.simplify(third-((p-2)-p*r*r)/(r*(1-r*r)**2))==0
J=math.sqrt(math.pi)*2**(1/3)*float(gamma(1/6))/(3*math.sqrt(3))
ai,_,bi,_=airy(0)
J2=4*math.pi**2/(9*float(gamma(2/3))**2)
J3=math.pi**2*3**(-2/3)*(ai*ai+bi*bi)
assert max(abs(J-J2),abs(J-J3))<1e-12
out={'scope':'symbolic elementary identities and floating-point cross-check only','cubic_square_identity':True,'third_derivative_identity':True,'J_gamma_1_6':J,'J_gamma_2_3':J2,'J_airy':J3,'max_abs_difference':max(abs(J-J2),abs(J-J3))}
path=Path(__file__).resolve().parent.parent/'results'/'local_algebra.json'
path.write_text(json.dumps(out,indent=2)+'\n'); print(json.dumps(out,indent=2))
