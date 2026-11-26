"""Exact sign certificate for Proposition 4 of theory_planar.md.

This is an exact check of one fixed published parameter point, not an orbit
search.  Only Python's standard library is used.  Algebra is performed in
Q(sqrt(5)); signs use a rational isolating interval with integer-square checks.
The geometric theorem is proved in the accompanying note, not by this script.
"""

from dataclasses import dataclass
from fractions import Fraction as F
import json


@dataclass(frozen=True)
class Q5:
    a: F = F(0)
    b: F = F(0)

    @staticmethod
    def cast(x):
        return x if isinstance(x, Q5) else Q5(F(x))

    def __add__(self, other):
        y = self.cast(other)
        return Q5(self.a + y.a, self.b + y.b)

    __radd__ = __add__

    def __neg__(self):
        return Q5(-self.a, -self.b)

    def __sub__(self, other):
        return self + -self.cast(other)

    def __rsub__(self, other):
        return self.cast(other) + -self

    def __mul__(self, other):
        y = self.cast(other)
        return Q5(self.a*y.a + 5*self.b*y.b, self.a*y.b + self.b*y.a)

    __rmul__ = __mul__

    def __truediv__(self, other):
        y = self.cast(other)
        den = y.a*y.a - 5*y.b*y.b
        assert den != 0
        return self * Q5(y.a/den, -y.b/den)

    def __rtruediv__(self, other):
        return self.cast(other) / self

    def __pow__(self, n):
        assert isinstance(n, int) and n >= 0
        result = Q5(F(1))
        for _ in range(n):
            result = result * self
        return result

    def interval(self):
        if self.b >= 0:
            return self.a+self.b*ROOT_LOWER, self.a+self.b*ROOT_UPPER
        return self.a+self.b*ROOT_UPPER, self.a+self.b*ROOT_LOWER


ROOT_LOWER = F(2236067, 10**6)
ROOT_UPPER = F(2236068, 10**6)
assert 0 < ROOT_LOWER < ROOT_UPPER
assert ROOT_LOWER**2 < 5 < ROOT_UPPER**2

mu = F(531, 10000)
beta = F(4879, 10000)
gamma = F(32829, 12500)
den = (1-mu)*gamma
root = Q5(F(0), F(1))
c = (root-1)/4                        # cos(72 degrees)
c36 = (root+1)/4                      # cos(36 degrees)
p2 = ((1+beta-mu*gamma)-(1+beta)*c)/den
p3 = ((1+beta-mu*gamma)+(1+beta)*c)/den
q_squared = (1-beta)**2*(10+2*root)/(16*den**2)
r2 = p2-p2**2-q_squared
r3 = p3-p3**2-q_squared
q_sin72 = (1-beta)*(10+2*root)/(16*den)
q_sin36 = (1-beta)*root/(4*den)
phi21 = r2*(c-1)+q_sin72
phi31 = r3*(-c-1)+q_sin72
phi27 = r2*(-c36-1)+q_sin36
phi37 = r3*(c36-1)+q_sin36

# M_2 and M_3 have the same imaginary part; hence their squared distance
# is the square of their real-part difference.
c23_squared = 4*r2*r3+(p2-p3)**2
a2 = 2*r2*(1-c)
a3 = 2*r3*(1+c)
e_squared = 4*(1-c**2)*c23_squared*(5+root)/8
gap = F(3,16)*e_squared-((a2+3*a3)/4)**2

checks = {
    "phi21_positive": phi21,
    "minus_phi31_positive": -phi31,
    "minus_phi27_positive": -phi27,
    "phi37_positive": phi37,
    "lag1_at_s_one_third_positive": (phi21+2*phi31)/3,
    "lag7_at_s_one_quarter_positive": (phi27+3*phi37)/4,
    "a2_positive": a2,
    "a3_minus_a2_positive": a3-a2,
    "e_squared_positive": e_squared,
    "coherence_gap_positive": gap,
}

output = {
    "status": "PASS",
    "arithmetic": "fractions.Fraction in Q(sqrt(5))",
    "sqrt5_isolating_interval": [str(ROOT_LOWER), str(ROOT_UPPER)],
    "positive_sign_certificates": {},
    "scope": "two positive circular complex modes 2/10 and 3/10 at P1 only",
}
for name, quantity in checks.items():
    lower, upper = quantity.interval()
    assert lower > 0, (name, lower, upper)
    # We retain the exact radical coefficients and enclosing rational bounds.
    # Rounded outward millionths are easier to inspect, but are not required
    # for the assertions above.
    lower_millionths = (lower*10**6).__floor__()
    upper_millionths = (upper*10**6).__ceil__()
    output["positive_sign_certificates"][name] = {
        "a_plus_b_sqrt5": [str(quantity.a), str(quantity.b)],
        "rational_interval": [str(lower), str(upper)],
        "outward_millionths": [lower_millionths, upper_millionths],
    }

if __name__ == "__main__":
    print(json.dumps(output, indent=2))
