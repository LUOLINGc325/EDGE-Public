#!/usr/bin/env python3
"""Run exact symbolic certificates and separately labelled numerical probes."""
from pathlib import Path
from math import comb
import hashlib, json, platform
import numpy as np
import scipy
import sympy as sp
from lq_game import Game, thresholds, symmetric_branches

ROOT=Path(__file__).resolve().parent.parent


def symbolic():
    sig,g,s,z,b,v=sp.symbols('sigma gamma s z b v',real=True)
    d=lambda x:1-g*(s+x)**2
    hval=sig+b*b-v*d(b)
    hstation=b+g*v*(s+b)
    excess=(sig+z*z-v*d(z))-(1+g*v)*(z-b)**2-hval-2*(z-b)*hstation
    assert sp.expand(excess)==0
    u,r,x,y=sp.symbols('u r x y',positive=True)
    gam=1/(r*r+2*u*r)
    k1=-u+x+y; k2=-u+x-y
    den=1-gam*(r+2*x)**2
    qstar=4*u**4/(1-gam*r*r)
    sos=(x*x-y*y-2*u*x)**2+4*u*u*(1+2*u/r)*x*x
    sos_res=sp.factor((u*u+k1*k1)*(u*u+k2*k2)-qstar*den-sos)
    assert sos_res==0
    t,c,n,m=sp.symbols('t c n m',positive=True)
    ff=(n-1)*sp.cosh(t)+sp.sqrt(sp.cosh(t)**2+c)+(2*m-n)*sp.sinh(t)
    gg=(n-1)*sp.tanh(t)+sp.sinh(t)/sp.sqrt(sp.cosh(t)**2+c)
    normalized=sp.simplify(sp.diff(ff,t)/sp.cosh(t)-(gg+2*m-n))
    gp=(n-1)/sp.cosh(t)**2+(1+c)*sp.cosh(t)/(sp.cosh(t)**2+c)**sp.Rational(3,2)
    slope=sp.simplify(sp.diff(gg,t)-gp)
    assert normalized==0 and slope==0
    simultaneous=(22-3*sp.sqrt(65))/2
    assert sp.simplify(simultaneous+1)<0
    marginal_k1=-2+sp.sqrt(3); marginal_k2=-2-sp.sqrt(3)
    rr=5+marginal_k1+marginal_k2
    dd=1-sp.Rational(1,5)*rr*rr
    assert rr==1 and dd==sp.Rational(4,5)
    for kk in [marginal_k1,marginal_k2]:
        assert sp.simplify(kk*dd+sp.Rational(1,5)*rr*(1+kk*kk))==0
    return dict(status='pass',method='SymPy exact expressions over rational polynomial/radical identities; independent of numerical probes',
                identities=dict(excess_remainder=str(sp.expand(excess)),coalescence_SOS_remainder=str(sos_res),
                normalized_derivative_remainder=str(normalized),slope_derivative_remainder=str(slope)),
                simultaneous=dict(N=6,gamma=1,sigma=1,a='1/2',initial=[0]*6,
                    best_response='(7-sqrt(65))/4',updated_closed_loop=str(simultaneous),
                    exact_reason='sqrt(65)>8 implies (22-3*sqrt(65))/2 < -1'),
                marginal=dict(N=2,gamma='1/5',sigma=1,a=5,k=['-2+sqrt(3)','-2-sqrt(3)'],
                    closed_loop='1',denominator='4/5',physically_stable=False))


def enumeration():
    rows=[]; max_foc=0.; max_br=0.; checked=0
    for n in range(2,11):
        for gamma,sigma in [(1.,1.),(.2,.07),(.65,2.)]:
            th=thresholds(n,gamma,sigma)
            points=[(th['coalescence'],'coalescence')]
            points += [(x['A'],('fold',x['m'])) for x in th['folds']]
            edges=[0]+[x['A'] for x in th['folds']]+[th['coalescence']]
            points += [((a+b)/2,None) for a,b in zip(edges[:-1],edges[1:])]
            points += [(th['coalescence']+2,None)]
            for aa,boundary in points:
                a=aa*np.sqrt(sigma)
                branches=symmetric_branches(n,a,gamma,sigma,boundary)
                total=sum(x['multiplicity'] for x in branches)
                if boundary=='coalescence':
                    expected=1+sum(comb(n,m) for m in range(1,(n-1)//2+1))
                elif aa>th['coalescence']:
                    expected=2**n-1
                else:
                    expected=1
                    for f in th['folds']:
                        if boundary==('fold',f['m']): expected+=comb(n,f['m'])
                        elif aa>f['A']: expected+=2*comb(n,f['m'])
                assert total==expected,(n,gamma,sigma,aa,boundary,total,expected)
                game=Game(a,gamma,np.full(n,sigma))
                for branch in branches:
                    k=np.array(branch['k']); r=a+k.sum(); d=1-gamma*r*r
                    foc=k*d+gamma*r*(sigma+k*k)
                    rel_foc=float(np.max(np.abs(foc))/(1+np.max(np.abs(k*d))+np.max(np.abs(gamma*r*(sigma+k*k)))))
                    br=float(np.max(np.abs(game.br(k)-k)))
                    max_foc=max(max_foc,rel_foc); max_br=max(max_br,br)
                    assert d>0 and rel_foc<2e-9 and br<2e-8
                    if branch['morse_negative'] is not None:
                        eig=np.linalg.eigvalsh(game.hessian_log_potential(k))
                        count=int(np.sum(eig < -1e-8*max(1,np.max(np.abs(eig)))))
                        assert count==branch['morse_negative'],(n,branch,eig)
                    checked+=1
                rows.append(dict(N=n,gamma=gamma,sigma=sigma,A=aa,boundary=boundary,
                                 orbit_count=len(branches),distinct_profiles=total))
    # Explicitly exercise the nonzero-state and strict physical-boundary examples.
    assert symmetric_branches(3,0.,1.,1.)[0]['k']==[0.,0.,0.]
    marginal=symmetric_branches(2,5.,.2,1.)
    mixed=next(x for x in marginal if x['m']==1)
    assert mixed['plant_stable'] is None
    reflected=symmetric_branches(4,-7.,1.,1.)
    positive=symmetric_branches(4,7.,1.,1.)
    assert all(np.allclose(np.array(x['k']),-np.array(y['k'])) for x,y in zip(reflected,positive))
    return dict(status='pass',case_count=len(rows),representatives_checked=checked,
                max_relative_first_order_residual=max_foc,max_best_response_residual=max_br,
                near_physical_boundary='Reported as ambiguous by floating point code; exact symbolic marginal example proves exclusion.',cases=rows)


def learning():
    rng=np.random.default_rng(20261125)
    samples=[]; traces=[]
    for j in range(72):
        n=[2,3,4,6,9,12][j%6]
        gamma=[.1,.5,1.][(j//6)%3]
        sig=np.exp(rng.uniform(np.log(.05),np.log(5),size=n))
        a=float(rng.uniform(-8,8))
        k0=rng.normal(0,1,n)
        desired=float(rng.uniform(-.8,.8)/np.sqrt(gamma))
        k0+=(desired-a-k0.sum())/n
        game=Game(a,gamma,sig)
        k,h=game.cyclic(k0,max_cycles=10000,tolerance=1e-9)
        ps=np.array([x['potential'] for x in h]); ds=np.array([x['denominator'] for x in h])
        increase=float(max(x['max_coordinate_log_increase'] for x in h))
        min_coordinate_d=float(min(x['min_coordinate_denominator'] for x in h))
        residual=h[-1]['residual']
        passed=bool(increase<1e-10 and min_coordinate_d>0 and residual<=1e-9)
        samples.append(dict(index=j,N=n,a=a,gamma=gamma,sigma=sig.tolist(),initial=k0.tolist(),
                            final=k.tolist(),cycles=h[-1]['cycle'],residual=residual,
                            min_denominator=min_coordinate_d,max_log_potential_increase=increase,pass_=passed))
        if j<6: traces.append(dict(index=j,N=n,history=h))
    return dict(status='pass' if all(x['pass_'] for x in samples) else 'observed_failure',
                seed=20261125,samples=samples,traces=traces)


def main():
    results=ROOT/'results'; results.mkdir(exist_ok=True)
    evidence=dict(symbolic=symbolic(),enumeration=enumeration(),learning=learning())
    evidence['environment']=dict(python=platform.python_version(),numpy=np.__version__,scipy=scipy.__version__,sympy=sp.__version__)
    evidence['sources_sha256']={name:hashlib.sha256((ROOT/'code'/name).read_bytes()).hexdigest()
                               for name in ['lq_game.py','verify.py','EXPERIMENT_PLAN.json']}
    (results/'verification.json').write_text(json.dumps(evidence,indent=2)+'\n')
    summary=dict(symbolic=evidence['symbolic']['status'],enumeration=evidence['enumeration']['status'],
                 enumeration_cases=evidence['enumeration']['case_count'],representatives=evidence['enumeration']['representatives_checked'],
                 learning=evidence['learning']['status'],learning_samples=len(evidence['learning']['samples']),
                 max_cycles=max(s['cycles'] for s in evidence['learning']['samples']),
                 failed_samples=[s['index'] for s in evidence['learning']['samples'] if not s['pass_']])
    (results/'verification_summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps(summary,indent=2))
    if summary['failed_samples']: raise SystemExit(1)


if __name__=='__main__': main()
