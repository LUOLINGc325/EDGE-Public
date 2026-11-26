"""Exact symbolic checks of the newly derived terminal lift identities.

These include free-parameter local identities and finite exact rational
specializations. The analytic derivation and sign proof are in
paper/convex_and_terminal_sections.tex and paper/CONVEX_TERMINALS_DRAFT.md.
"""
import sympy as S
from collections import defaultdict
from fractions import Fraction as Q
from dca_convex_certificate import E, d2, lift, add


def sq(x): return x*x


def run(k,eta,rho,branch):
    n=k+1
    h,r=map(S.Rational,(str(eta),str(rho)))
    a=h-r
    T=E(k,h)-E(k,r)
    Tn=E(n,h)-E(n,r)
    U=E(n,h if branch=='eta' else r)
    if branch=='eta':
        C=-r*r*Tn/a**2
        u=h*U-(1+h)*T/(2*a)
        v=-1+h*U-(1-r)*T/(2*a)
    else:
        C=h*h*Tn/a**2
        u=1-r*U+(1-h)*T/(2*a)
        v=-r*U+(1+r)*T/(2*a)
    assert T>=0 and C>=0, 'Test parameter is outside its intended phase.'
    W=d2(k,h,r)
    add(W,k,n,u);add(W,n,k,v)
    H=lift(W,n,h,r)
    if branch=='eta':
        H[k,k+2]+=h*C
        H[k,k+1]-=h*C
        H[k+1,k+2]-=(1+h)*C
        H[k+2,k+1]-=C
    xs=S.symbols(f'x0:{n+2}')
    ss=S.symbols(f's0:{n+2}')
    hv=S.symbols(f'h0:{n+2}')
    qv=S.symbols(f'q0:{n+1}')
    z=[xs[i+1]+ss[i+1] for i in range(n+1)]
    ds=[xs[i]-xs[i+1] for i in range(n+1)]
    fs=[xs[i]**2/2+hv[i]-qv[i] for i in range(n+1)]
    rhs=S.Integer(0)
    lap=S.Integer(0)
    for (i,j),w in W.items():
        # Reverse GD direction to f2 direction.
        i,j=j,i
        dx=xs[i]-xs[j]
        iq=qv[i]-qv[j]-z[j]*dx-r*sq(dx)/2-sq(z[i]-z[j]-r*dx)/(2*a)
        rhs+=w*iq
        lap+=w*sq(ss[i+1]-ss[j+1])/(2*a)
    for (i,j),w in H.items():
        rhs+=w*(hv[i]-hv[j]-ss[j]*(xs[i]-xs[j]))
    if branch=='eta':
        rhs+=lap-C*sq(ss[k+1]-ss[k+2])/2
        rhs+=C*sq(ds[n]+ss[k+1]-ss[k+2]-h*ds[k])/2
    else:
        rhs+=lap+C*sq(ds[n]-r*ds[k])/2
    lhs=fs[0]-fs[n]-U*sq(ds[n])/2
    difference=S.Poly(S.expand(lhs-rhs),*xs,*ss,*hv,*qv)
    print({'k':k,'eta':str(h),'rho':str(r),'branch':branch,
           'identity_is_exact':difference.is_zero,
           'minimum_h_multiplier':str(min(H.values()))})
    assert difference.is_zero
    assert min(H.values())>=0


def verify_eta_tail_all_parameters():
    e,r,U=S.symbols('eta rho U',nonzero=True)
    a=e-r
    A=e*e*U-1-e
    C=((e+r)*U-1)/a
    u=e*U;v=e*U-1
    x=S.symbols('x0:3');s=S.symbols('s0:3')
    h=S.symbols('h0:3');q=S.symbols('q0:2')
    z=[x[1]+s[1],x[2]+s[2]]
    def iq(i,j):
        dx=x[i]-x[j]
        return q[i]-q[j]-z[j]*dx-r*dx*dx/2-(z[i]-z[j]-r*dx)**2/(2*a)
    def ih(i,j):return h[i]-h[j]-s[j]*(x[i]-x[j])
    d=x[0]-x[1];dn=x[1]-x[2];rr=s[1]-s[2]
    F=[x[i]**2/2+h[i]-q[i] for i in range(2)]
    lhs=F[0]-F[1]+A*d*d/2-U*dn*dn/2
    rhs=u*iq(1,0)+v*iq(0,1)+ih(0,1)+U*ih(1,2)+U*ih(2,1)+U*rr*rr/2+C*(dn+rr-e*d)**2/2
    difference=S.Poly(S.expand(2*a*(lhs-rhs)),*x,*s,*h,*q)
    exact=all(S.factor(c)==0 for c in difference.coeffs())
    print({'identity':'eta_tail','all_parameters_symbolic':True,'identity_is_exact':exact})
    assert exact


def verify_rho_empty_prefix_all_parameters():
    e,r=S.symbols('eta rho',nonzero=True)
    a=e-r
    U=(1+r)/r**2
    T=(1+e)/e**2-U
    C=e**2*T/a**2
    u=1-r*U;v=-r*U
    x=S.symbols('x0:3');s=S.symbols('s0:3')
    h=S.symbols('h0:3');q=S.symbols('q0:2')
    z=[x[1]+s[1],x[2]+s[2]]
    def iq(i,j):
        dx=x[i]-x[j]
        return q[i]-q[j]-z[j]*dx-r*dx*dx/2-(z[i]-z[j]-r*dx)**2/(2*a)
    def ih(i,j):return h[i]-h[j]-s[j]*(x[i]-x[j])
    d=x[0]-x[1];dn=x[1]-x[2];rr=s[1]-s[2]
    F=[x[i]**2/2+h[i]-q[i] for i in range(2)]
    lhs=F[0]-F[1]-U*dn*dn/2
    rhs=(u*iq(1,0)+v*iq(0,1)+(1+r*C)*ih(0,1)-r*C*ih(0,2)
         +(u+v)/a*ih(2,1)+(v+(1+r)*(u+v)/a)*ih(1,2)
         +(u+v)/(2*a)*rr*rr+C*(dn-r*d)**2/2)
    difference=S.Poly(S.expand(2*a*a*r*r*(lhs-rhs)),*x,*s,*h,*q)
    exact=all(S.factor(c)==0 for c in difference.coeffs())
    print({'identity':'rho_empty_prefix','all_parameters_symbolic':True,'identity_is_exact':exact})
    assert exact


if __name__=='__main__':
    verify_eta_tail_all_parameters()
    verify_rho_empty_prefix_all_parameters()
    run(0,Q(4,5),Q(-3,5),'rho')
    run(0,Q(4,5),Q(-1,5),'eta')
    run(1,Q(4,5),Q(-3,5),'rho')
    run(2,Q(1,2),Q(-2,5),'eta')
    run(5,Q(1),Q(-3,4),'eta')
