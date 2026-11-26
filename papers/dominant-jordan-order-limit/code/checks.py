"""Exact arithmetic checks for the monitored-qubit Jordan-order result."""

from dataclasses import dataclass
from fractions import Fraction as Q
from random import Random
import json


def require(condition, context):
    if not condition:
        raise RuntimeError(str(context))


@dataclass(frozen=True)
class Quadratic:
    rational: Q = Q(0)
    radical: Q = Q(0)

    @staticmethod
    def coerce(value):
        return value if isinstance(value, Quadratic) else Quadratic(Q(value))

    def __add__(self, value):
        other = self.coerce(value)
        return Quadratic(self.rational + other.rational,
                         self.radical + other.radical)

    __radd__ = __add__

    def __neg__(self):
        return Quadratic(-self.rational, -self.radical)

    def __sub__(self, value):
        return self + (-self.coerce(value))

    def __rsub__(self, value):
        return self.coerce(value) + (-self)

    def __mul__(self, value):
        other = self.coerce(value)
        a, b, c, d = self.rational, self.radical, other.rational, other.radical
        return Quadratic(a*c + 2*b*d, a*d + b*c)

    __rmul__ = __mul__

    def __truediv__(self, value):
        other = self.coerce(value)
        det = other.rational**2 - 2*other.radical**2
        return self * Quadratic(other.rational/det, -other.radical/det)

    def __pow__(self, exponent):
        result, base = Quadratic(Q(1)), self
        while exponent:
            if exponent % 2:
                result *= base
            base *= base
            exponent //= 2
        return result

    def positive(self):
        a, b = self.rational, self.radical
        if a >= 0 and b >= 0:
            return a > 0 or b > 0
        if a <= 0 and b <= 0:
            return False
        return a*a > 2*b*b if a > 0 else 2*b*b > a*a


ROOT_TWO = Quadratic(Q(0), Q(1))


def multiply(a, b):
    return [[sum(x*y for x, y in zip(row, column))
             for column in zip(*b)] for row in a]


def subtract_diagonal(a, value):
    return [[entry - (value if i == j else 0) for j, entry in enumerate(row)]
            for i, row in enumerate(a)]


def contains_nonzero(matrix):
    return any(Quadratic.coerce(entry) != Quadratic()
               for row in matrix for entry in row)


def verify_one_jump():
    # K comes from -iH and the jump Gram matrix.
    l = [[1, 1], [0, ROOT_TWO]]
    gram = multiply(list(zip(*l)), l)
    hamiltonian_term = [[0, Q(-1, 2)], [Q(1, 2), 0]]
    k = [[term - Quadratic.coerce(g)/2 for term, g in zip(row, gram_row)]
         for row, gram_row in zip(hamiltonian_term, gram)]
    expected_k = [[Q(-1, 2), -1], [0, Q(-3, 2)]]
    require(k == [[Quadratic.coerce(x) for x in row] for row in expected_k],
            "physical generator")
    s_minus_no_count = [[2, 2, 0, 0], [0, 3, 0, 1],
                        [0, 0, 3, 0], [0, 0, 0, 4]]
    jump = [[1, 2, 0, 1], [0, ROOT_TWO, 0, ROOT_TWO],
            [0, 0, ROOT_TWO, 0], [0, 0, 0, 2]]
    lam = Quadratic(Q(1, 2))
    delta = ROOT_TWO/3
    alpha, beta, c = Q(1, 3), Q(1, 6), ROOT_TWO/6
    kernel = [[lam, alpha, 0, beta], [0, delta, 0, c],
              [0, 0, delta, 0], [0, 0, 0, lam]]
    result = multiply(kernel, s_minus_no_count)
    require([[Quadratic.coerce(x) for x in row] for row in result]
            == [[Quadratic.coerce(x) for x in row] for row in jump],
            "exact Laplace resolvent identity")
    shifted = subtract_diagonal(kernel, lam)
    other = subtract_diagonal(kernel, delta)
    mixed = multiply(shifted, other)
    require(contains_nonzero(mixed)
            and not contains_nonzero(multiply(shifted, mixed)), "minimum polynomial")
    gap = lam-delta
    coeff = Quadratic.coerce(beta) + c*alpha/gap
    require(gap.positive() and coeff.positive(), "visible positive coefficient")
    state = [[0], [0], [0], [1]]
    for n in range(1, 65):
        state = multiply(kernel, state)
        trace = state[0][0] + state[3][0]
        expected = lam**n + n*coeff*lam**(n-1) - alpha*c*(lam**n-delta**n)/(gap**2)
        require(trace == expected and trace.positive(), (n, "ordinary trace"))
    return {"resolved_physical_example": True, "exact_iterates": 64}


def verify_normal_form():
    rng = Random(20261125)
    ep3 = ep2 = scalar = 0
    for trial in range(48):
        root_lam = Q(rng.randrange(1, 10), rng.randrange(1, 10))
        shear_re = Q(rng.randrange(-4, 5), rng.randrange(1, 10)) if trial >= 12 else Q(0)
        shear_im = Q(rng.randrange(-4, 5), rng.randrange(1, 10)) if trial >= 12 else Q(0)
        shear_sq = shear_re**2 + shear_im**2
        beta = Q(rng.randrange(1, 5), 9) if trial >= 6 else Q(0)
        tangent = [[0, 2*root_lam*shear_re, 2*root_lam*shear_im, shear_sq+beta],
                   [0, 0, 0, root_lam*shear_re],
                   [0, 0, 0, root_lam*shear_im],
                   [0, 0, 0, 0]]
        square = multiply(tangent, tangent)
        expected = [[0, 0, 0, 2*root_lam**2*shear_sq]] + [[0]*4 for _ in range(3)]
        require(square == expected and not contains_nonzero(multiply(square, tangent)),
                "normal-form nilpotent part")
        if shear_sq:
            require(contains_nonzero(square), "third order")
            ep3 += 1
        elif beta:
            require(contains_nonzero(tangent), "second order")
            ep2 += 1
        else:
            scalar += 1
    return {"third_order": ep3, "second_order": ep2, "scalar": scalar}


print(json.dumps({"monitored_example": verify_one_jump(),
                  "abstract_normal_form": verify_normal_form()}, indent=2))
