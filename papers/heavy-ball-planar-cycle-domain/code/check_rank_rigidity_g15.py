"""Exact rational interval certificate for the G.15 rigidity application.

The published Theorem G.15 (arXiv:2610.09912v2) supplies existence of q_star,
the global two-lag symbol and its zero set.  This script does NOT reprove those
published facts.  It certifies the additional nondegeneracy hypotheses in
Theorem 2 of theory_planar.md over the entire published rational parameter box.

Only the standard library is used.  Pi is enclosed by Machin's formula with
alternating rational arctangent sums; sin and cos are enclosed by rational
Taylor polynomials and Lagrange remainder bounds.  No floating point, LP,
interval package or numerical optimizer is used for any assertion.
"""

from dataclasses import dataclass
from fractions import Fraction as F
from functools import lru_cache
from math import factorial
import json


@dataclass(frozen=True)
class I:
    lo: F
    hi: F

    def __post_init__(self):
        assert self.lo <= self.hi

    @staticmethod
    def cast(x):
        return x if isinstance(x, I) else I(F(x), F(x))

    def __add__(self, other):
        y = self.cast(other)
        return I(self.lo+y.lo, self.hi+y.hi)

    __radd__ = __add__

    def __neg__(self):
        return I(-self.hi, -self.lo)

    def __sub__(self, other):
        return self+-self.cast(other)

    def __rsub__(self, other):
        return self.cast(other)+-self

    def __mul__(self, other):
        y = self.cast(other)
        products = [self.lo*y.lo, self.lo*y.hi, self.hi*y.lo, self.hi*y.hi]
        return I(min(products), max(products))

    __rmul__ = __mul__

    def __truediv__(self, other):
        y = self.cast(other)
        assert y.lo > 0 or y.hi < 0, (y.lo, y.hi)
        return self*I(1/y.hi, 1/y.lo)

    def __rtruediv__(self, other):
        return self.cast(other)/self

    def __pow__(self, exponent):
        assert isinstance(exponent, int) and exponent >= 0
        value = self.cast(1)
        for _ in range(exponent):
            value = value*self
        return value

    def rounded_out(self, denominator=10**18):
        return I(F((self.lo*denominator).__floor__(), denominator),
                 F((self.hi*denominator).__ceil__(), denominator))

    def excludes_zero(self):
        return self.lo > 0 or self.hi < 0

    def output(self):
        return {"exact": [str(self.lo), str(self.hi)],
                "outward_millionths": [(self.lo*10**6).__floor__(),
                                        (self.hi*10**6).__ceil__()]}


@dataclass(frozen=True)
class C:
    re: I
    im: I

    @staticmethod
    def cast(x):
        return x if isinstance(x, C) else C(I.cast(x), I.cast(0))

    def __add__(self, other):
        z = self.cast(other)
        return C(self.re+z.re, self.im+z.im)

    __radd__ = __add__

    def __neg__(self):
        return C(-self.re, -self.im)

    def __sub__(self, other):
        return self+-self.cast(other)

    def __rsub__(self, other):
        return self.cast(other)+-self

    def __mul__(self, other):
        z = self.cast(other)
        return C(self.re*z.re-self.im*z.im, self.re*z.im+self.im*z.re)

    __rmul__ = __mul__

    def output(self):
        return {"real": self.re.output(), "imaginary": self.im.output()}

    def assert_nonzero(self):
        assert self.re.excludes_zero() or self.im.excludes_zero()


def atan_reciprocal(denominator, terms=40):
    x = F(1, denominator)
    total = sum(((-1)**k*x**(2*k+1)/F(2*k+1)
                 for k in range(terms)), F(0))
    next_term = (-1)**terms*x**(2*terms+1)/F(2*terms+1)
    # All terms decrease strictly, so the exact value lies between these sums.
    return I(min(total, total+next_term), max(total, total+next_term))


PI = 16*atan_reciprocal(5)-4*atan_reciprocal(239)
assert F(3) < PI.lo < PI.hi < F(22, 7)
PI = PI.rounded_out(10**24)


@lru_cache(maxsize=13)
def cis_root13(index):
    k = index % 13
    if k > 6:
        k -= 13
    if k == 0:
        return C.cast(1)
    x = 2*k*PI/13
    bound = max(abs(x.lo), abs(x.hi))
    degree_index = 18
    cosine = I.cast(0)
    sine = I.cast(0)
    for j in range(degree_index+1):
        cosine += (-1)**j*x**(2*j)/factorial(2*j)
        sine += (-1)**j*x**(2*j+1)/factorial(2*j+1)
    cos_error = bound**(2*degree_index+1)/factorial(2*degree_index+1)
    sin_error = bound**(2*degree_index+2)/factorial(2*degree_index+2)
    cosine += I(-cos_error, cos_error)
    sine += I(-sin_error, sin_error)
    return C(cosine.rounded_out(), sine.rounded_out())


# Closed hull of the strict box in published Theorem G.15.
KAPPA = I(F("83.53425"), F("83.53435"))
GAMMA = I(F("2.2189085"), F("2.2189095"))
BETA = I(F("0.6227675"), F("0.6227685"))
MU = 1/KAPPA
assert 0 < MU.lo <= MU.hi < 1
assert 0 < BETA.lo <= BETA.hi < 1
assert 0 < GAMMA.lo <= GAMMA.hi < 2*(1+BETA.lo)
DEN = (1-MU)*GAMMA


@lru_cache(maxsize=13)
def multiplier(index):
    z = cis_root13(index)
    return C(((1+BETA-MU*GAMMA)-(1+BETA)*z.re)/DEN,
             -(1-BETA)*z.im/DEN)


def T(lag, k, ell):
    mk, ml = multiplier(k), multiplier(ell)
    return ((1-mk)*ml*(cis_root13(lag*ell)-1)
            +(1-ml)*mk*(cis_root13(lag*k)-1))


LAG1, LAG2 = 1, -4


def cross_determinant(k, ell):
    return ((cis_root13(LAG2*(k+ell))-1)*T(LAG1, k, ell)
            -(cis_root13(LAG1*(k+ell))-1)*T(LAG2, k, ell))


def self_factor(k):
    m = multiplier(k)
    z1, z2 = cis_root13(LAG1*k), cis_root13(LAG2*k)
    return m*(1-m)*(z1-1)*(z2-1)*(z2-z1)


FREQUENCIES = [0, 6, -6, 4, -4, 5, -5, 1, -1]
assert len({k % 13 for k in FREQUENCIES}) == 9
values = {
    "self_mode_3": self_factor(3),
    "self_mode_2": self_factor(2),
    "cross_3_2": cross_determinant(3, 2),
    "cross_3_minus2": cross_determinant(3, -2),
}
for value in values.values():
    value.assert_nonzero()

output = {
    "status": "PASS",
    "arithmetic": "exact rational interval arithmetic, standard library only",
    "published_dependency": "Pasechnyuk-Vilensky and Takac, arXiv:2610.09912v2, Theorem G.15 and (E1)-(E4) of Theorem G.12",
    "dependency_scope": "published existence/global sign/zero set/primal feasibility are invoked, not re-proved here",
    "pi_interval": PI.output(),
    "parameter_box": {"kappa_L_over_mu": KAPPA.output(),
                      "gamma_L": GAMMA.output(), "beta": BETA.output()},
    "lags": [LAG1, LAG2],
    "frequencies_over_2pi": ["3/13", "2/13"],
    "distinct_sum_residues_mod13": [k % 13 for k in FREQUENCIES],
    "nonzero_factor_certificates": {name: value.output()
                                    for name, value in values.items()},
    "conclusion": "all additional scalar nondegeneracy hypotheses hold over the entire box",
}

if __name__ == "__main__":
    print(json.dumps(output, indent=2))
