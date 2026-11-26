"""Exact algebraic checks and high-precision numerical threshold table.

The global monotonicity proof is in amplitude_threshold_derivation.md.
Numerical roots below are diagnostics, not interval-certified constants.
"""
import sympy as s
import mpmath as m
import json

z=s.symbols('z',real=True)
g=z*(3-z**2)/(1+z**2)
derivative=s.factor(s.diff(g,z))
assert s.simplify(derivative-(3-6*z**2-z**4)/(1+z**2)**2)==0
zstar=s.sqrt(2*s.sqrt(3)-3)
M2=s.sqrt(6*s.sqrt(3)-9)
assert s.simplify(g.subs(z,zstar)**2-M2**2)==0
assert s.simplify((3-6*z**2-z**4).subs(z,zstar))==0

m.mp.dps=80
def root(k):
    # cosh(k*u)/cosh(u) grows strictly from 1 to infinity.
    f=lambda u:m.cosh(k*u)-k*m.cosh(u)
    left=m.mpf(0);right=m.mpf(1)
    while f(right)<=0:right*=2
    for _ in range(300):
        mid=(left+right)/2
        if f(mid)<0:left=mid
        else:right=mid
    return (left+right)/2

rows=[]
for k in range(2,101):
    u=root(k)
    M=k*m.tanh(k*u)-m.tanh(u)
    alpha=m.mpf('.5')-(k-1)/(2*M)
    deriv=(1/m.cosh(u)**2)*((k-1)*u-m.sinh((k-1)*u))/(k*(k-1)**2)
    rows.append(dict(k=k,u=m.nstr(u,50),M=m.nstr(M,50),alpha_c=m.nstr(alpha,50),ratio_derivative=m.nstr(deriv,50),stationarity_residual=m.nstr(m.cosh(k*u)-k*m.cosh(u),8)))
assert all(m.mpf(rows[i]['alpha_c'])>m.mpf(rows[i+1]['alpha_c']) for i in range(len(rows)-1))

beta_c=1/(2*m.sqrt(6*m.sqrt(3)-9));ac=m.mpf('.5')-beta_c
examples=[]
for alpha in [m.mpf(0),m.mpf('0.05'),m.mpf('0.07'),ac-m.mpf('0.0001')]:
    beta=m.mpf('.5')-alpha
    u=m.atanh(m.sqrt(2*m.sqrt(3)-3))
    eps=beta*m.sqrt(6*m.sqrt(3)-9)-m.mpf('.5')
    t=u/beta;dt=eps/(10*beta**2);tt=t+dt
    gamma=1-(1+m.exp(t))/(1+m.exp(tt))
    r1=m.exp(-dt/2)*m.cosh(beta*tt)/m.cosh(beta*t)
    r2=m.exp(-dt)*m.cosh(2*beta*tt)/m.cosh(2*beta*t)
    lower=eps**2/(20*beta**2)
    assert r2>r1 and m.log(r2/r1)>lower
    examples.append({key:m.nstr(val,50) for key,val in dict(alpha=alpha,t=t,tprime=tt,gamma=gamma,eta_single=r1,coherent_rayleigh=r2,log_ratio=m.log(r2/r1),proved_log_ratio_lower_bound=lower).items()})
result=dict(exact_checks=dict(derivative=str(derivative),critical_z=str(zstar),maximum_M2=str(M2),M2_squared_identity=True,stationarity_identity=True),alpha_c2=m.nstr(ac,65),table_precision_digits=80,table_is_interval_certified=False,thresholds=rows,explicit_witnesses=examples,scope='identical amplitude-damping channels with diagonal faithful reference states; not universal CPTP classification')
json.dump(result,open('amplitude_threshold_certificate.json','w'),indent=2)
print('alpha_c2 =',m.nstr(ac,65))
print('k=2,3,4,10,100:',[(r['k'],r['alpha_c']) for r in rows if r['k'] in [2,3,4,10,100]])
print('exact algebra checks passed; 99 high-precision thresholds strictly decrease; 4 explicit witnesses tested')
