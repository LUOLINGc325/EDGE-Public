"""Independent ECQC noise-family verification; standard library plus SymPy for audit."""
from fractions import Fraction as Q
import json, math
from pathlib import Path
import argparse
import sympy as s

t=s.symbols('t',real=True)
a=(5*t+4)/36;b=(1-t)/9;c=(t+2)/6;e=(4-t)/12;d=(1-t)/3;u=(8*t+1)/9
H=lambda xs:-sum(x*s.log(x) for x in xs)
C=2*H([c,e,e])-H([a]*4+[b]*5)
QMI=2*H([c,c,d])-H([u]+[b]*8)
F=s.expand(C*3-QMI)
Fpp=s.factor(s.diff(F,t,2))
print('Fpp_times_ln2=',Fpp)
expected=(80*t**3+405*t**2+696*t-128)/((t-4)*(t-1)*(t+2)*(5*t+4)*(8*t+1))
assert s.cancel(Fpp-expected)==0
assert s.simplify(F.subs(t,0))==0
assert s.simplify(s.diff(F,t).subs(t,0))==0
assert s.limit(F,t,1,dir="-")==s.log(2)
expr=54*s.log(3)+66*s.log(11)-24*s.log(2)-90*s.log(5)-19*s.log(19)
assert s.simplify(s.expand_log(27*F.subs(t,s.Rational(2,3))-expr,force=True))==0
assert 3**54*11**66>2**24*5**90*19**19
print('integer certificate at 2/3: numerator greater than denominator:',3**54*11**66-2**24*5**90*19**19)
# Log enclosure entirely in fractions. Scale argument into [1,2].
def log_interval(x, terms=50):
    x=Q(x); assert x>0
    k=0
    while x>2:x/=2;k+=1
    while x<1:x*=2;k-=1
    def atanh_log(r):
        z=(r-1)/(r+1); zz=z*z
        total=Q(0); power=z
        for j in range(terms):
            total+=2*power/(2*j+1); power*=zz
        tail=2*power/((2*terms+1)*(1-zz))
        return total,total+tail
    lo,hi=atanh_log(x);l2,h2=atanh_log(Q(2))
    return (lo+k*l2,hi+k*h2) if k>=0 else (lo+k*h2,hi+k*l2)
def entropy_interval(xs,terms=50):
    lo=Q(0);hi=Q(0)
    for x in xs:
        if not x:continue
        l,h=log_interval(x,terms);lo-=x*h;hi-=x*l
    return lo,hi
def scaled_interval(x,lohi):
    l,h=lohi
    return (x*l,x*h) if x>=0 else (x*h,x*l)
def F_interval(t,terms=50):
    a=(5*t+4)/36;b=(1-t)/9;c=(t+2)/6;e=(4-t)/12;d=(1-t)/3;u=(8*t+1)/9
    # natural log units: 6H(c,e,e)-3H(a,a,a,a,b,b,b,b,b)-2H(c,c,d)+H(u,bx8)
    groups=[(6,[c,e,e]),(-3,[a]*4+[b]*5),(-2,[c,c,d]),(1,[u]+[b]*8)]
    out=[Q(0),Q(0)]
    for scale,xs in groups:
        l,h=scaled_interval(scale,entropy_interval(xs,terms));out[0]+=l;out[1]+=h
    return tuple(out)
lo=Q(65787847979876378651,10**20);hi=Q(65787847979876378652,10**20)
records=[]
for x in [Q(0),lo,hi,Q(2,3),Q(1)]:
    l,h=F_interval(x)
    print('t=',x,'Fln2 interval approx=',float(l),float(h),'sign', '+' if l>0 else '-' if h<0 else '?')
    scale=10**35
    lower=Q((l*scale).__floor__(),scale);upper=Q((h*scale).__ceil__(),scale)
    assert lower<=l<=h<=upper
    records.append({'t':str(x),'lower':str(lower),'upper':str(upper),'lower_decimal':float(lower),'upper_decimal':float(upper)})
assert F_interval(lo)[1]<0
assert F_interval(hi)[0]>0
parser=argparse.ArgumentParser()
parser.add_argument('--output',type=Path,default=Path(__file__).with_name('noise_certificate.json'))
args=parser.parse_args()
args.output.parent.mkdir(parents=True,exist_ok=True)
with args.output.open('w') as f:json.dump({'terms':50,'root_bracket':[str(lo),str(hi)],'F_times_ln2':records},f,indent=2)
print('ALL CHECKS PASS')
