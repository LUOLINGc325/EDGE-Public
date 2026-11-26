"""Independent finite numerical checks for the capped-tail operator.

No asymptotic theorem is inferred from these checks. The two integrations use
separate Stieltjes-measure and layer-cake implementations. Run from any cwd.
"""
from __future__ import annotations
import json, math
from pathlib import Path
import numpy as np
from scipy.integrate import quad

ROOT = Path(__file__).resolve().parent
M = 2.0


def cap(x: float, power: int) -> float:
    return min(1.0, M * math.exp(-x**power))


def tail(atoms, x, sign):
    return sum(m for v, m in atoms if sign*v > x)


def ray_intervals(atoms, sign):
    points = sorted(set([0.0] + [sign*x for x, m in atoms if sign*x > 0 and m > 0]))
    return points, [(a,b,tail(atoms,(a+b)/2,sign)) for a,b in zip(points,points[1:])]


def direct_integral(atoms, power, fn):
    """Stieltjes mass: jumps at observed atoms plus smooth cap sections."""
    total = 0.0
    for sign in (-1, 1):
        points, intervals = ray_intervals(atoms, sign)
        for x in points[1:]:
            before = sum(m for v,m in atoms if sign*v >= x)
            after = sum(m for v,m in atoms if sign*v > x)
            mass = min(before,cap(x,power))-min(after,cap(x,power))
            total += mass*fn(sign*x)
        for a,b,p in intervals:
            if p <= 0: continue
            cutoff = math.log(M/p)**(1/power)
            low = max(a,cutoff)
            if low < b:
                val = quad(lambda x: fn(sign*x)*M*power*x**(power-1)*math.exp(-x**power), low,b, epsabs=1e-11,epsrel=2e-11,limit=200)[0]
                total += val
    zero_mass = 1-tail(atoms,0,1)-tail(atoms,0,-1)
    return total+zero_mass*fn(0.0)


def layer_integral(atoms,power,derivative):
    total = 0.0
    for sign in (-1,1):
        _, intervals=ray_intervals(atoms,sign)
        for a,b,p in intervals:
            cutoff=math.log(M/p)**(1/power) if p else b
            cuts=sorted(set([a,b]+([cutoff] if a < cutoff < b else [])))
            for l,u in zip(cuts,cuts[1:]):
                total += quad(lambda x: derivative(sign,x)*min(p,cap(x,power)),l,u,epsabs=1e-11,epsrel=2e-11,limit=200)[0]
    return total


def main():
    P=[(-0.5,0.2),(0.0,0.6),(0.5,0.2)]
    contaminants=[ [(-8.0,0.5),(9.0,0.5)], [(12.0,1.0)], [(-3.0,0.25),(0.25,0.25),(2.0,0.5)] ]
    records=[]; compare_count=0; tail_count=0; max_rel=0.0; max_tail_slack=-math.inf
    for power in (2,4,6):
        assert sum(m*math.exp(abs(x)**power) for x,m in P) <= M
        for eps in (0.0,0.005,0.05,0.2):
            for Q in contaminants:
                H=[(x,(1-eps)*m) for x,m in P]+[(x,eps*m) for x,m in Q]
                # H_n=H, so the relative-tail event holds with eta=d=0.
                pts=set([0.0])
                for x,m in H:
                    pts.update([abs(x),max(0.0,abs(x)-1e-8),abs(x)+1e-8])
                pts.update(np.linspace(0,13,301))
                for sign in (-1,1):
                    for x in sorted(pts):
                        p=tail(P,x,sign); hn=tail(H,x,sign); z=min(hn,cap(x,power))
                        assert z <= p+eps+3e-13
                        assert p <= z/(1-eps)+3e-13
                        max_tail_slack=max(max_tail_slack,z-p-eps,p-z/(1-eps))
                        tail_count += 2
                mass=direct_integral(H,power,lambda x:1.0)
                assert abs(mass-1)<2e-10, (power,eps,mass)
                moment=direct_integral(H,power,lambda x: math.exp(x*x/2))
                assert moment <= math.exp(0.5)+2*M+1e-10
                local_max=0.0
                for t in (-2.0,-0.7,0.0,0.7,2.0):
                    if t==0:
                        f=lambda x:x*x
                        deriv=lambda sign,x:2*x
                    else:
                        f=lambda x,t=t:2*(math.expm1(t*x)-t*x)/(t*t)
                        deriv=lambda sign,x,t=t:2*sign*math.expm1(t*sign*x)/t
                    d=direct_integral(H,power,f)
                    l=layer_integral(H,power,deriv)
                    rel=abs(d-l)/(1+abs(d)+abs(l))
                    assert rel < 3e-10, (power,eps,t,d,l,rel)
                    compare_count+=1;local_max=max(local_max,rel);max_rel=max(max_rel,rel)
                records.append({'power':power,'epsilon':eps,'contamination_atoms':Q,'mass':mass,'exp_square_moment':moment,'max_double_integration_relative_error':local_max})
    # Check the constants in the two Gaussian cap-tail bounds independently.
    tail_kernel_checks=0; max_small_ratio=0.0;max_large_ratio=0.0
    for S in (25.0,64.0,100.0):
        for B in (0.02,0.1,1.0):
            r=math.sqrt(S*B)
            for tr_ratio in (0.1,0.5,0.9):
                tau=tr_ratio*S/r
                # Avoid exponent overflow by factoring out tau*r-S.
                val=quad(lambda y:y*math.exp(tau*r*(y-1)-S*(y*y-1)),1,math.inf,epsabs=1e-11,limit=200)[0]
                ratio=(r*r*val)/B
                assert ratio <= 1+2e-10
                max_small_ratio=max(max_small_ratio,ratio);tail_kernel_checks+=1
            for z in (0.5,2.0,5.0,12.0):
                # Integral exp(t*x-x*x/B) / [sqrt(pi B)*exp(t*t*B/4)].
                # Complete the square, then integrate normalized Gaussian.
                low=r/math.sqrt(B)-z/2
                ratio=quad(lambda y:math.exp(-y*y)/math.sqrt(math.pi),low,math.inf,epsabs=1e-12,limit=200)[0]
                assert 0 <= ratio <= 1+2e-12
                max_large_ratio=max(max_large_ratio,ratio);tail_kernel_checks+=1
    out={
        'status':'passed','kind':'finite_float_operator_and_integral_checks_not_asymptotic_proof',
        'operator_cases':len(records),'tail_inequality_checks':tail_count,'independent_stieltjes_vs_layercake_checks':compare_count,
        'gaussian_tail_kernel_checks':tail_kernel_checks,'max_double_integral_relative_error':max_rel,
        'max_small_argument_tail_ratio':max_small_ratio,'max_large_argument_tail_ratio':max_large_ratio,
        'records':records,
    }
    (ROOT/'CAP_CHECK.json').write_text(json.dumps(out,indent=2)+'\n')
    print(json.dumps({k:v for k,v in out.items() if k!='records'},indent=2))

if __name__=='__main__': main()
