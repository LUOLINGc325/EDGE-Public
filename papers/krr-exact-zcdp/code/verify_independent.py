"""Independent high-precision checks of the proposed k-RR characterization.
Uses the probability vectors directly for Renyi divergence.
Numerical diagnostics, not a formal proof or exhaustive verification.
"""
from pathlib import Path
import argparse
import json
import mpmath as mp
if not __debug__:
    raise RuntimeError('Independent diagnostics require assertions enabled; run without -O')
mp.mp.dps = 90

def threshold(e):
    u = mp.exp(e)
    return 2*(u-1)*(u-1-e)/(e*(u+1)-2*u+2)

def direct(e,k,alpha):
    p = mp.exp(e)/(mp.exp(e)+k-1)
    q = 1/(mp.exp(e)+k-1)
    return mp.log(p**alpha*q**(1-alpha)+q**alpha*p**(1-alpha)+(k-2)*q)/(alpha*(alpha-1))

def C(t):
    return (mp.sinh(t)*mp.cosh(t)-t)/(t*mp.cosh(t)-mp.sinh(t))

def H(t,a,c):
    return (t*t-a*a)*mp.sinh(t)/(2*t*(mp.cosh(t)+c))-mp.log((mp.cosh(t)+c)/(mp.cosh(a)+c))

def calc(e,k):
    a=e/2; c=(k-2)/(2*mp.exp(a))
    kl=e*(mp.exp(e)-1)/(mp.exp(e)+k-1)
    anchor_log=mp.log(2*(c+mp.cosh(a)))
    upper=anchor_log+mp.sqrt(anchor_log**2-a*a)
    assert upper>a and H(upper,a,c)<0
    if c<=C(a):
        # Check the original finite probability formula at increasing orders.
        alphas=[1+mp.power(10,j) for j in range(-12,6)]
        vals=[direct(e,k,x) for x in alphas]
        assert all(vals[i]>vals[i+1] for i in range(len(vals)-1))
        assert all(v<kl for v in vals)
        return {'epsilon':str(e),'k':int(k),'mode':'boundary','rho':mp.nstr(kl,45),'checked_orders':len(alphas)}
    # Find curvature switch independently by root bisection.
    l=a; r=max(mp.mpf(1),2*a)
    while C(r)<c:r*=2
    for _ in range(350):
        m=(l+r)/2
        if C(m)<c:l=m
        else:r=m
    turn=(l+r)/2
    assert H(turn,a,c)>0
    l=turn;r=max(2*turn,mp.mpf(1))
    while H(r,a,c)>0:r*=2
    for _ in range(350):
        m=(l+r)/2
        if H(m,a,c)>0:l=m
        else:r=m
    t=(l+r)/2; alpha=mp.mpf('.5')+t/e
    assert a<turn<t<upper
    rho=direct(e,k,alpha)
    # Tangency expression, independent direct probability derivative.
    tangent=e*e*mp.sinh(t)/(2*t*(mp.cosh(t)+c))
    deriv=mp.diff(lambda x: direct(e,k,x),alpha)
    assert abs(rho-tangent)<mp.mpf('1e-65')*max(1,abs(rho))
    assert abs(deriv)<mp.mpf('1e-60')
    assert rho>kl
    probes=[1+(alpha-1)*mp.power(10,mp.mpf(i)/5) for i in range(-40,41)]
    values=[direct(e,k,x) for x in probes]
    peak=40
    assert all(values[i]<values[i+1] for i in range(peak))
    assert all(values[i]>values[i+1] for i in range(peak,len(values)-1))
    assert all(v<=rho+mp.mpf('1e-70') for v in values)
    return {'epsilon':str(e),'k':int(k),'mode':'interior','alpha':mp.nstr(alpha,45),'t':mp.nstr(t,70),'explicit_upper_T':mp.nstr(upper,70),'rho':mp.nstr(rho,45),'kl':mp.nstr(kl,45),'derivative_residual':mp.nstr(deriv,8),'checked_orders':len(probes)}

rows=[]
for k in [2,3,6,7,8,16,100,10000,10**12]:
    for e in map(mp.mpf,['1e-6','0.01','0.2','1','5','20']):
        rows.append(calc(e,k))
# Both sides of each integer-k phase boundary, using independent original threshold.
critical=[]
for k in [7,8,16,100,10000,10**12]:
    lo=mp.mpf('1e-12');hi=mp.mpf(1)
    while threshold(hi)<k:hi*=2
    for _ in range(350):
        mid=(lo+hi)/2
        if threshold(mid)<k:lo=mid
        else:hi=mid
    ecrit=(lo+hi)/2
    for rel in ['0.999999','1.000001']:
        rows.append(calc(ecrit*mp.mpf(rel),k))
    critical.append({'k':k,'epsilon_critical':mp.nstr(ecrit,45)})
# Direct numerical derivative of C and F at extreme scales.
for t in map(mp.mpf,['1e-10','1e-6','0.01','0.1','1','5','20','100']):
    assert mp.diff(C,t)>0
    for c in [mp.mpf(0),mp.mpf(2),mp.mpf(10),mp.mpf('1e10')]:
        f=lambda x:mp.log(mp.cosh(mp.sqrt(x))+c)
        d2=mp.diff(f,t*t,2)
        explicit=((t*mp.cosh(t)-mp.sinh(t))*(c-C(t)))/(4*t**3*(mp.cosh(t)+c)**2)
        assert abs(d2-explicit)<mp.mpf('1e-45')*max(1,abs(d2))
# Independent finite diagnostics of the fixed-epsilon large-k remainder.
# These samples support, but do not prove, the asymptotic O statements.
asymptotic=[]
for e in map(mp.mpf,['0.1','1','5']):
    for exponent in [3,6,9,12,18,24]:
        k=10**exponent
        row=calc(e,k)
        assert row['mode']=='interior'
        a=e/2;c=(k-2)/(2*mp.exp(a))
        t=mp.mpf(row['t']); upper=mp.mpf(row['explicit_upper_T'])
        rho=direct(e,k,mp.mpf('.5')+t/e)
        difference=rho-e*e/(2*upper)
        assert difference>0 and upper-t>0
        asymptotic.append({
            'epsilon':str(e),'k':k,
            'T_minus_t':mp.nstr(upper-t,35),
            'rho_minus_leading':mp.nstr(difference,35),
            'root_error_scaled_by_k_over_logk':mp.nstr((upper-t)*k/mp.log(k),35),
            'rho_error_scaled_by_k_logk_squared':mp.nstr(difference*k*mp.log(k)**2,35),
            'rho_ratio_to_epsilon_squared_over_4_logk':mp.nstr(rho/(e*e/(4*mp.log(k))),35)
        })
out={'status':'PASS','precision_decimal_digits':mp.mp.dps,
     'parameter_case_count':len(rows),
     'boundary_count':sum(r['mode']=='boundary' for r in rows),
     'interior_count':sum(r['mode']=='interior' for r in rows),
     'renyi_order_checks':sum(r['checked_orders'] for r in rows),
     'cases':rows,'critical_points':critical,
     'asymptotic_diagnostics':asymptotic,
     'claim':'Finite high-precision diagnostics using original finite probability vectors; not interval certificates or a replacement for the analytical proof.'}
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--output',type=Path,default=Path(__file__).resolve().parents[1]/'results'/'independent_checks.json')
args=parser.parse_args()
args.output.parent.mkdir(parents=True,exist_ok=True)
args.output.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'status':'PASS','parameter_cases':len(rows),
    'boundary':out['boundary_count'],'interior':out['interior_count'],
    'renyi_order_checks':out['renyi_order_checks'],
    'explicit_bracket_checks':len(rows)+len(asymptotic),
    'asymptotic_diagnostics':len(asymptotic),
    'results':str(args.output)},indent=2))
