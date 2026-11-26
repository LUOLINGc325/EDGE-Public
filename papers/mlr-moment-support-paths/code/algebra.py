"""Exact rational/algebraic-root ordering; shared arithmetic, no path logic."""
from functools import lru_cache
import sympy as sp

t=sp.Symbol("t")


def key(root):
    if root.is_Rational:
        return ("rational",sp.Rational(root))
    return ("algebraic",tuple(root.poly.all_coeffs()),int(root.index))


@lru_cache(None)
def _interval(coefficients,index,digits):
    q=sp.Poly.from_list(list(coefficients),t,domain=sp.QQ)
    intervals=q.intervals(eps=sp.Rational(1,10**digits))
    a,b=intervals[index][0]
    return sp.Rational(a),sp.Rational(b)


def interval(root,digits=20):
    identity=key(root)
    if identity[0]=="rational":
        return identity[1],identity[1]
    return _interval(identity[1],identity[2],digits)


def compare(a,b):
    ka,kb=key(a),key(b)
    if ka==kb:
        return 0
    if ka[0]==kb[0]=="algebraic" and ka[1]==kb[1]:
        return -1 if ka[2]<kb[2] else 1
    digits=10
    while digits<=2560:
        al,ar=interval(a,digits)
        bl,br=interval(b,digits)
        if ar<bl:
            return -1
        if br<al:
            return 1
        digits*=2
    raise ArithmeticError("Root separation requires more than 2560 decimal digits")


def rational_between(left,right):
    assert compare(left,right)<0
    digits=10
    while digits<=2560:
        _,a=interval(left,digits)
        b,_=interval(right,digits)
        if a<b:
            for bits in range(1,4*digits):
                denominator=2**bits
                numerator=int(sp.floor(a*denominator))+1
                sample=sp.Rational(numerator,denominator)
                if a<sample<b:
                    return sample
            return (a+b)/2
        digits*=2
    raise ArithmeticError("Could not isolate a rational sample between distinct roots")
