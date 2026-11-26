"""Reference numerical implementation. Floating point output is not a proof.

The theorem supplies the monotone root intervals. This implementation labels
near-threshold input as ambiguous unless the caller names the exact boundary.
"""
from dataclasses import dataclass
from math import comb
import numpy as np
from scipy.optimize import brentq


@dataclass
class Game:
    a: float
    gamma: float
    sigma: np.ndarray

    def __post_init__(self):
        self.sigma = np.asarray(self.sigma, dtype=float)
        if (self.sigma.ndim != 1 or len(self.sigma) < 2 or
                not np.all(np.isfinite(self.sigma)) or np.any(self.sigma <= 0) or
                not np.isfinite(self.a) or not 0 < self.gamma <= 1):
            raise ValueError('N >= 2, finite a, 0 < gamma <= 1, sigma_i > 0 required')

    def denominator(self, k):
        return 1 - self.gamma * (self.a + np.sum(k)) ** 2

    def values(self, k):
        d = self.denominator(k)
        return (self.sigma + np.asarray(k) ** 2) / d if d > 0 else np.full(len(self.sigma), np.inf)

    def log_potential(self, k):
        d = self.denominator(k)
        if d <= 0:
            return np.inf
        return float(np.log(self.sigma + np.asarray(k) ** 2).sum() - np.log(d))

    def br(self, k):
        s = self.a + np.sum(k) - np.asarray(k)
        aa = 1 + self.gamma * (self.sigma + s * s)
        disc = np.hypot(1 + self.gamma * (self.sigma - s * s),
                        2 * self.gamma * np.sqrt(self.sigma) * s)
        return 2 * s / (aa + disc) - s

    def gradient(self, k):
        d = self.denominator(k)
        if d <= 0:
            raise ValueError('outside finite-cost domain')
        r = self.a + np.sum(k)
        return 2 * (np.asarray(k) * d + self.gamma * r * (self.sigma + np.asarray(k) ** 2)) / d ** 2

    def hessian_log_potential(self, k):
        d = self.denominator(k)
        r = self.a + np.sum(k)
        diagonal = 2 * (self.sigma - np.asarray(k) ** 2) / (self.sigma + np.asarray(k) ** 2) ** 2
        return np.diag(diagonal) + 2 * self.gamma * (1 + self.gamma * r * r) / d ** 2

    def cyclic(self, initial, max_cycles=10000, tolerance=1e-10):
        k = np.asarray(initial, dtype=float).copy()
        if k.shape != self.sigma.shape or self.denominator(k) <= 0:
            raise ValueError('a finite-cost initial profile of correct dimension is required')
        history = [dict(cycle=0, potential=self.log_potential(k),
                        residual=float(np.linalg.norm(self.br(k)-k)), denominator=self.denominator(k),
                        min_coordinate_denominator=self.denominator(k),max_coordinate_log_increase=0.)]
        for cycle in range(1, max_cycles + 1):
            minimum_d=self.denominator(k)
            max_increase=0.
            for i in range(len(k)):
                old_p=self.log_potential(k)
                k[i] = self.br(k)[i]
                minimum_d=min(minimum_d,self.denominator(k))
                max_increase=max(max_increase,self.log_potential(k)-old_p)
            history.append(dict(cycle=cycle, potential=self.log_potential(k),
                                residual=float(np.linalg.norm(self.br(k)-k)), denominator=self.denominator(k),
                                min_coordinate_denominator=minimum_d,max_coordinate_log_increase=max_increase))
            if history[-1]['residual'] <= tolerance:
                break
        return k, history


def branch_value(t, n, m, c):
    ch = np.cosh(t)
    # Rationalizing sqrt(ch^2+c)-ch avoids cancellation on the m=0 branch.
    return m * np.exp(t) + (n-m) * np.exp(-t) + c / (np.hypot(ch, np.sqrt(c)) + ch)


def normalized_slope(t, n, m, c):
    return (n-1)*np.tanh(t) + np.sinh(t)/np.sqrt(np.cosh(t)**2+c) + 2*m-n


def _upper_until(predicate, start=1.0):
    b = start
    while not predicate(b):
        b *= 2
        if b > 128:
            raise ArithmeticError('root bracket exceeds numerical implementation range')
    return b


def thresholds(n, gamma, sigma):
    c = 1/(gamma*sigma)
    result = {'coalescence': float(n-1+np.sqrt(1+c)), 'folds': []}
    for m in range(1, (n-1)//2+1):
        hi = _upper_until(lambda t: normalized_slope(t,n,m,c) > 0)
        t = brentq(lambda x: normalized_slope(x,n,m,c),0,hi,xtol=1e-14)
        result['folds'].append(dict(m=m,t=float(t),A=float(branch_value(t,n,m,c))))
    return result


def symmetric_branches(n, a, gamma, sigma, exact_boundary=None):
    """One representative per permutation orbit, with its multiplicity.

    exact_boundary may be 'coalescence' or ('fold', m). It means that the
    mathematical input is that named threshold; floating comparison is not
    used to certify equality. Outside named boundaries a 1e-10 guard rejects
    unresolved threshold comparisons. No interval-arithmetic certification
    is claimed by this reference implementation.
    """
    Game(a,gamma,np.full(n,sigma))
    if a == 0:
        return [dict(m=0,t=None,k=[0.0]*n,multiplicity=1,r=0.0,
                     plant_stable=True,morse_negative=0,kind='zero')]
    th = thresholds(n,gamma,sigma)
    aa = abs(a)/np.sqrt(sigma)
    if exact_boundary == 'coalescence':
        aa = th['coalescence']
    elif isinstance(exact_boundary,tuple) and exact_boundary[0]=='fold':
        aa = next(x['A'] for x in th['folds'] if x['m']==exact_boundary[1])
    elif min(abs(aa-x) for x in [th['coalescence']]+[q['A'] for q in th['folds']]) < 1e-10:
        raise ValueError('near an unresolved threshold: supply an exact mathematical boundary label')
    c = 1/(gamma*sigma)
    roots=[]
    if exact_boundary=='coalescence':
        roots.append((0,0.0,'coalescence'))
    elif aa < th['coalescence']:
        hi=_upper_until(lambda t: branch_value(t,n,0,c)<aa)
        roots.append((0,brentq(lambda t: branch_value(t,n,0,c)-aa,0,hi,xtol=1e-14),'regular'))
    for m in range(1,n+1):
        fold=next((x for x in th['folds'] if x['m']==m),None)
        f=lambda t: branch_value(t,n,m,c)-aa
        if fold is not None:
            tmin=fold['t']
            if exact_boundary==('fold',m):
                roots.append((m,tmin,'fold'))
                continue
            if aa < fold['A']:
                continue
            if aa < th['coalescence']:
                roots.append((m,brentq(f,0,tmin,xtol=1e-14),'regular'))
            hi=_upper_until(lambda t: f(t)>0,start=max(1.0,2*tmin))
            roots.append((m,brentq(f,tmin,hi,xtol=1e-14),'regular'))
        elif aa > th['coalescence']:
            hi=_upper_until(lambda t: f(t)>0)
            roots.append((m,brentq(f,0,hi,xtol=1e-14),'regular'))
    answer=[]
    for m,t,kind in roots:
        high=np.sqrt(sigma)*np.exp(t)
        low=np.sqrt(sigma)*np.exp(-t)
        k=-np.sign(a)*np.array([high]*m+[low]*(n-m))
        r=np.sign(a)/(gamma*(np.sqrt(sigma*np.cosh(t)**2+1/gamma)+np.sqrt(sigma)*np.cosh(t)))
        neg=None if kind in ('fold','coalescence') else (0 if m==0 else m-1+int(normalized_slope(t,n,m,c)<0))
        physical = None if abs(abs(r)-1)<1e-10 else bool(abs(r)<1)
        answer.append(dict(m=m,t=float(t),k=k.tolist(),multiplicity=1 if kind=='coalescence' else comb(n,m),
                           r=float(r),plant_stable=physical,morse_negative=neg,kind=kind))
    return answer
