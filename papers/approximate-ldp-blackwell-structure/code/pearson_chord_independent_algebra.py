"""Independent symbolic transcription checks for the Pearson chord proof.
These checks supplement the mathematical review; they do not prove sign claims.
"""
from pathlib import Path
import hashlib,json
import sympy as sp

a,b,c,E,x,u,w,tau,K,gamma,ell,v,d,s,S0,V0,T0,t = sp.symbols(
    "a b c E x u w tau K gamma ell v d s S0 V0 T0 t")
S=a*x+b*E+u
V=a*x**2+b*E**2+w
T=K*(a*x+b*E)+tau
D=S**2-V
S1=S.subs(x,1);V1=V.subs(x,1);T1=T.subs(x,1);D1=D.subs(x,1)
P=K*S1*D1-T1*(S1**2+V1-2*S1)
derivative=sp.factor((sp.diff(S*T/D,x).subs(x,1)*D1**2/a-P))

SS=ell+u
VV=v+u**2-d
DD=SS**2-VV
B0=(ell**2-v+2*ell)*u-2*ell*(v-ell)
B1=(K-2*gamma)*u**2+2*(K-gamma)*ell*u+2*gamma*u-gamma*(ell**2+v-2*ell)
bound=K*SS*DD-(K*ell+gamma*d/u)*(SS**2+VV-2*SS)
expansion=sp.factor(u*bound-(K*u*B0+d*B1+gamma*d**2))
ell0=a+b*E;v0=a+b*E**2
positive=E*(a*(a+1)*E+2*a*b*(E**2-E+1)
            +b*(b-1)*E*((E-1)**2+1)+2*b*E)
b0_certificate=sp.factor(((ell0**2-v0+2*ell0)*E**2-2*ell0*(v0-ell0))-positive)
r=sp.symbols("r")
lower_b1=(r-1)*u**2+gamma*(ell**2-v+2*ell)+2*gamma*u
b1_certificate=sp.factor((B1-lower_b1
    -2*ell*((K-gamma)*u-gamma*ell)).subs(K,r-1+2*gamma))

Rnew=(S0+t)*(T0+s*(E+1)*t)/(S0**2-V0+2*S0*t)
zero_derivative=sp.factor(sp.diff(Rnew,t).subs(t,0)*(S0**2-V0)**2
    -(S0*s*(E+1)*(S0**2-V0)-T0*(S0**2+V0)))
k,q=sp.symbols("k q")
L=k+q*(E-1);Q=k+q*(E**2-1)
Cd=q*(k-q)*(E-1)**2/L**2
two_level=sp.factor((k-1)*L**2/(L**2-Q)-k*(k-1)/(k-1-Cd))
checks={"direct_derivative_minus_aP_over_D2":derivative,
        "equation_6_expansion":expansion,
        "equation_7_positive_identity":b0_certificate,
        "equation_8_comparison_remainder":b1_certificate,
        "adding_zero_coordinate_derivative":zero_derivative,
        "two_level_ratio_evaluation":two_level}
assert all(val==0 for val in checks.values())
candidate=Path("research_work/extensions/PEARSON_CHORD_PROOF_CONTROL.md")
report={"reviewed_source":str(candidate),"source_sha256":hashlib.sha256(candidate.read_bytes()).hexdigest(),
        "independent_transcription":True,"residuals":{key:str(val) for key,val in checks.items()},
        "all_exact_zero":True,"scope":"algebraic identities only; inequality signs audited separately"}
Path("research_work/extensions/pearson_chord_independent_algebra.json").write_text(json.dumps(report,indent=2)+"\n")
print(json.dumps(report,indent=2))

