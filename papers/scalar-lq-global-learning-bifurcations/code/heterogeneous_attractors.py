"""Numerical reference for the heterogeneous attracting-branch classification.

This code enumerates generic local minima using monotone intervals supplied by
the manuscript. Exact cusp and endpoint cases are separate symbolic checks.
Floating-point near-equalities are rejected, not silently certified.
"""
from dataclasses import dataclass
import numpy as np
from scipy.optimize import brentq
from lq_game import Game


class AmbiguousBoundary(ValueError):
    pass


@dataclass
class Landscape:
    gamma: float
    sigma: np.ndarray

    def __post_init__(self):
        self.sigma=np.asarray(self.sigma,dtype=float)
        Game(0.,self.gamma,self.sigma)
        self.n=len(self.sigma);self.c=1/self.gamma
        self.M=float(max(self.sigma));self.z0=float(np.sqrt(self.M))
        self.maximal=np.flatnonzero(self.sigma==self.M)
        self.q=len(self.maximal)
        self.edge=float(self.f0(self.z0))
        self._intervals=[self.increasing_intervals(i) for i in range(self.n)]

    def radicals(self,z):
        result=np.sqrt(np.maximum(0,z*z-self.sigma))
        # sqrt(M)**2 can round slightly above M.  The branch endpoint is an
        # exact mathematical input to the interval classifier, so impose its
        # known zero radicals instead of subtracting huge nearly equal ratios.
        if z==self.z0:result[self.maximal]=0.
        return result

    def r(self,z):
        return self.c/(np.sqrt(z*z+self.c)+z)

    def f0(self,z):
        return self.r(z)+np.sum(self.sigma/(z+self.radicals(z)))

    def fi(self,z,i):
        return self.f0(z)+2*self.radicals(z)[i]

    def derivative(self,z,i):
        rad=self.radicals(z)
        if np.any(rad==0):
            if self.q==1 and i==self.maximal[0]:return np.inf
            if self.q==2 and i in self.maximal:
                others=[j for j in range(self.n) if j not in self.maximal]
                return self.n-1+z/np.sqrt(z*z+self.c)-sum(z/rad[j] for j in others)
            return -np.inf
        ratios=z/rad
        return self.n-1+z/np.sqrt(z*z+self.c)+2*ratios[i]-sum(ratios)

    def curvature_ratio(self,z,i):
        delta=max(0.,z*z-self.M)
        others=np.arange(self.n)!=i
        return (self.c/self.M*(delta/(z*z+self.c))**1.5
                +np.sum(self.sigma[others]/self.M*(delta/(z*z-self.sigma[others]))**1.5))

    def upper(self,predicate,base=None):
        z=max(2*self.z0,2.) if base is None else max(2*base,base+1.)
        for _ in range(80):
            if predicate(z):return z
            z*=2
        raise ArithmeticError('reference root bracket exhausted')

    def increasing_intervals(self,i):
        if self.q==1 and i==self.maximal[0]:
            limit=(self.c+sum(self.sigma)-self.M)/self.M
            if limit<=1:return [(self.z0,np.inf,'ordinary')]
            hi=self.upper(lambda z:self.curvature_ratio(z,i)>1)
            zm=brentq(lambda z:self.curvature_ratio(z,i)-1,self.z0,hi,xtol=1e-13)
            minimum=self.derivative(zm,i)
            if abs(minimum)<1e-10:
                raise AmbiguousBoundary('unique-maximum branch near a cusp; use an exact certificate')
            if minimum>0:return [(self.z0,np.inf,'ordinary')]
            za=brentq(lambda z:self.derivative(z,i),self.z0,zm,xtol=1e-13)
            hi=self.upper(lambda z:self.derivative(z,i)>0,zm)
            zb=brentq(lambda z:self.derivative(z,i),zm,hi,xtol=1e-13)
            return [(self.z0,za,'ordinary'),(zb,np.inf,'ordinary')]
        start=self.derivative(self.z0,i)
        if np.isfinite(start) and abs(start)<1e-10:
            raise AmbiguousBoundary('two-maximal-cost endpoint near its sixth-order boundary')
        if start>=0:return [(self.z0,np.inf,'ordinary')]
        hi=self.upper(lambda z:self.derivative(z,i)>0)
        zmin=brentq(lambda z:self.derivative(z,i),self.z0,hi,xtol=1e-13)
        return [(zmin,np.inf,'ordinary')]

    def attractors(self,a):
        if a==0:return [dict(kind='zero',high_player=None,z=None,k=[0.]*self.n)]
        aa=abs(a)
        if abs(aa-self.edge)<1e-9:
            raise AmbiguousBoundary('endpoint equality requires the exact endpoint classification')
        candidates=[]
        if aa<self.edge:
            hi=self.upper(lambda z:self.f0(z)<aa)
            z=brentq(lambda z:self.f0(z)-aa,self.z0,hi,xtol=1e-13)
            candidates.append((None,z))
        for i,intervals in enumerate(self._intervals):
            for lo,hi,_ in intervals:
                floor=self.fi(lo,i)
                ceiling=np.inf if np.isinf(hi) else self.fi(hi,i)
                if abs(aa-floor)<1e-9 or (np.isfinite(ceiling) and abs(aa-ceiling)<1e-9):
                    raise AmbiguousBoundary('fold/endpoint equality requires exact analysis')
                if not floor<aa<ceiling:continue
                if np.isinf(hi):hi=self.upper(lambda z:self.fi(z,i)>aa,lo)
                z=brentq(lambda z:self.fi(z,i)-aa,lo,hi,xtol=1e-13)
                candidates.append((i,z))
        result=[]
        for i,z in candidates:
            rad=self.radicals(z)
            k=-self.sigma/(z+rad)
            if i is not None:k[i]=-z-rad[i]
            k*=np.sign(a)
            game=Game(a,self.gamma,self.sigma)
            eig=np.linalg.eigvalsh(game.hessian_log_potential(k))
            result.append(dict(kind='nondegenerate_minimum',high_player=i,z=float(z),k=k.tolist(),
                               residual=float(np.linalg.norm(game.br(k)-k)),
                               smallest_hessian_eigenvalue=float(min(eig)),closed_loop=float(a+sum(k))))
        return result


def sharp_instance(n):
    """An explicit strictly heterogeneous instance with N+1 minima for N>=3."""
    if n==2:return dict(N=2,gamma=1.,sigma=[1.,2.],a=4.,epsilon=None)
    if n<3:raise ValueError('N >= 2 required')
    z=1+1/(4*n*n);delta=z*z-1
    b=(n-1)*z+np.sqrt(z*z+1)-(n-2)*np.sqrt(delta)
    a0=n-1+np.sqrt(2);a=(b+a0)/2
    cc=sum(np.sqrt(j) for j in range(n))
    bounds=[delta/(n-1),2*np.sqrt(delta)*(a-b)/(n*(n-1)),((a0-a)/cc)**2]
    eps=min(bounds)/4
    sig=1+np.arange(n)*eps
    landscape=Landscape(1.,sig)
    assert z>landscape.z0 and max(landscape.fi(z,i) for i in range(n))<a<landscape.edge
    return dict(N=n,gamma=1.,sigma=sig.tolist(),a=float(a),epsilon=float(eps),
                witness_z=z,witness_all_low_endpoint=landscape.edge,
                witness_max_one_high_value=max(landscape.fi(z,i) for i in range(n)))
