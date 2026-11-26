#!/usr/bin/env python3
"""Exact boundary identities and finite probes for the heterogeneous extension."""
from pathlib import Path
import hashlib,json
import numpy as np
import sympy as sp
from heterogeneous_attractors import Landscape,AmbiguousBoundary,sharp_instance

ROOT=Path(__file__).resolve().parent.parent


def exact_boundaries():
    M,v,z,w=sp.symbols('M v z w',real=True)
    product=(M+v*v-w)**2+4*M*w
    e=product-2*z*v*(M+v*v-w)
    bridge=z*(M-v*v+w)*(M+v*v+w)-(z-v)*product-v*e
    assert sp.expand(bridge)==0
    t=sp.symbols('t',positive=True)
    at={M:t*t,v:t,z:t,w:0}
    assert sp.simplify(sp.diff(e,v).subs(at))==0
    assert sp.simplify(sp.diff(e,z).subs(at)+4*t**3)==0
    assert sp.simplify(sp.diff(e,w).subs(at)-2*t*t)==0
    gamma=sp.Rational(4,5);sig=[sp.S.One,sp.S.One,sp.Rational(55,64)]
    aa=sp.Rational(25,8);kk=[-sp.S.One,-sp.S.One,-sp.Rational(5,8)]
    rr=aa+sum(kk);dd=1-gamma*rr*rr
    assert rr==sp.Rational(1,2) and dd==sp.Rational(4,5)
    assert all(sp.simplify(k*dd+gamma*rr*(s+k*k))==0 for k,s in zip(kk,sig))
    d=2+sp.Rational(2,3)-sp.Rational(8,3)
    curvature=sp.Rational(5,4)/sp.Rational(3,2)**3+sp.Rational(55,64)/sp.Rational(3,8)**3
    assert d==0 and curvature==sp.Rational(50,3)
    assert curvature/48==sp.Rational(25,72)
    u=sp.Rational(1,2);vv=2+sp.sqrt(7)/2;ww=sp.Rational(3,2)+sp.sqrt(7)
    first=sp.simplify(2+u+ww-2*vv)
    second=sp.simplify(u-u**3-(ww**3-ww)+2*(vv**3-vv))
    third=sp.simplify(3*((ww**5-ww**3)-2*(vv**5-vv**3)-(u**3-u**5)))
    assert first==0 and second==0 and third>0
    zs=5/sp.sqrt(231); ms=sp.Rational(375,3721); ss=sp.Rational(1625,16807)
    us=sp.Rational(5,16); vs=sp.Rational(49,16); ws=sp.Rational(61,16)
    astar=sp.Rational(2178,20923)*sp.sqrt(231)
    assert sp.simplify(zs**2*(1-1/ws**2)-ms)==0
    assert sp.simplify(zs**2*(1-1/vs**2)-ss)==0
    assert sp.simplify(zs**2*(1/us**2-1)-1)==0
    assert 2+us+ws-2*vs==0
    assert us-us**3-(ws**3-ws)+2*(vs**3-vs)==0
    scaled_third=3*((ws**5-ws**3)-2*(vs**5-vs**3)-(us**3-us**5))
    assert scaled_third==sp.Rational(26413695,32768)
    assert sp.simplify((2+1/us+1/ws-2/vs)*zs-astar)==0
    assert sp.simplify((1/us-1)*zs-11/sp.sqrt(231))==0
    return dict(status='pass',transverse_identity_remainder=str(sp.expand(bridge)),
                endpoint_E_z='-4*t^3',endpoint_E_w='2*t^2',endpoint_E_v='0',
                sixth_order_example=dict(N=3,gamma='4/5',sigma=['1','1','55/64'],a='25/8',
                    gains=['-1','-1','-5/8'],closed_loop='1/2',denominator='4/5',
                    L_prime='0',L_second='50/3',reduced_sixth_order_coefficient='25/72'),
                cusp_example=dict(N=3,z='1',gamma='1/3',v=str(vv),w=str(ww),
                    sigma=['1-1/w^2','1-1/v^2','1-1/v^2'],a='4+1/w-2/v',
                    F_prime=str(first),F_second=str(second),F_third=str(third),
                    reduced_fourth_order_coefficient=str(sp.simplify(third/24))),
                stable_cusp_example=dict(N=3,gamma='1',z='5/sqrt(231)',
                    sigma=['375/3721','1625/16807','1625/16807'],
                    a='2178*sqrt(231)/20923',closed_loop='11/sqrt(231)',
                    F_prime='0',F_second='0',z_squared_times_F_third=str(scaled_third)),
                interpretation='Exact algebra supports the manuscript local-reduction proof; symbolic substitution alone does not prove full-space local minimality.')


def main():
    exact=exact_boundaries();sharp=[];generic=[];ambiguous=[]
    for n in range(2,13):
        data=sharp_instance(n);landscape=Landscape(data['gamma'],data['sigma'])
        roots=landscape.attractors(data['a'])
        expected=2 if n==2 else n+1
        assert len(roots)==expected,(n,len(roots),expected)
        assert all(x['residual']<1e-7 and x['smallest_hessian_eigenvalue']>0 for x in roots)
        sharp.append(dict(**data,expected_count=expected,computed_count=len(roots),attractors=roots))
    rng=np.random.default_rng(730125)
    for index in range(160):
        n=2+index%8;gamma=float(rng.uniform(.15,1))
        sig=np.exp(rng.uniform(np.log(.2),np.log(4),size=n));aa=float(rng.uniform(.1,12))
        try:
            landscape=Landscape(gamma,sig);roots=landscape.attractors(aa)
        except AmbiguousBoundary as exc:
            ambiguous.append(dict(index=index,N=n,gamma=gamma,sigma=sig.tolist(),a=aa,reason=str(exc)))
            continue
        assert 1<=len(roots)<=(2 if n==2 else n+1)
        assert all(x['residual']<1e-7 and x['smallest_hessian_eigenvalue']>0 for x in roots)
        generic.append(dict(index=index,N=n,gamma=gamma,sigma=sig.tolist(),a=aa,
                            attractor_count=len(roots),attractors=roots))
    result=dict(status='pass',exact=exact,sharp_instances=sharp,generic_instances=generic,
                ambiguous_inputs=ambiguous,
                source_sha256={name:hashlib.sha256((ROOT/'code'/name).read_bytes()).hexdigest()
                               for name in ['heterogeneous_attractors.py','verify_secondary.py','SECONDARY_EXPERIMENT_PLAN.json']})
    (ROOT/'results/secondary_verification.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(dict(status=result['status'],exact=exact['status'],sharp_instances=len(sharp),
                          generic_completed=len(generic),ambiguous=len(ambiguous),
                          sharp_counts=[x['computed_count'] for x in sharp]),indent=2))

if __name__=='__main__':main()
