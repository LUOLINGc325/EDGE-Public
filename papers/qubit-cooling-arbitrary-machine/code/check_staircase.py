"""Exact algebra certificates for the qubit shell-capacity staircase proof."""

from fractions import Fraction as F


class Polynomial:
    def __init__(self, value):
        if isinstance(value, (int, F)):
            value = {(0, 0, 0): F(value)}
        self.coefficients = {powers: n for powers, n in value.items() if n}

    def __add__(self, other):
        if isinstance(other, (int, F)):
            other = Polynomial(other)
        coefficients = self.coefficients.copy()
        for powers, n in other.coefficients.items():
            coefficients[powers] = coefficients.get(powers, 0) + n
        return Polynomial(coefficients)

    __radd__ = __add__

    def __sub__(self, other):
        return self + (-1) * other

    def __rsub__(self, other):
        return (-1) * self + other

    def __mul__(self, other):
        if isinstance(other, (int, F)):
            other = Polynomial(other)
        coefficients = {}
        for p, n in self.coefficients.items():
            for q, m in other.coefficients.items():
                powers = tuple(a + b for a, b in zip(p, q))
                coefficients[powers] = coefficients.get(powers, 0) + n * m
        return Polynomial(coefficients)

    __rmul__ = __mul__

    def __pow__(self, exponent):
        result = Polynomial(1)
        for _ in range(exponent):
            result *= self
        return result


t = u = Polynomial({(1, 0, 0): 1})
v = Polynomial({(0, 1, 0): 1})
d = Polynomial({(0, 0, 1): 1})


def mobius_coefficients(poly):
    """Substitute t=(1+2u)/(2+2u), clearing the positive denominator."""
    degree = max((i for i, _, _ in poly.coefficients), default=0)
    numerator = 1 + 2 * u
    denominator = 2 + 2 * u
    return sum(
        n * numerator**i * denominator**(degree-i) * v**j * d**k
        for (i, j, k), n in poly.coefficients.items()
    )


def assert_mobius_nonnegative(poly):
    expanded = mobius_coefficients(poly)
    if expanded:
        assert all(n > 0 for n in expanded.coefficients.values())


def cap(prefix, *, endpoint_only=False):
    """Endpoint Cauchy cap for a fixed prefix and arbitrary suffix mass d."""
    k = len(prefix) - 1
    c = prefix[-1]
    m = sum(prefix)
    mass = sum(t**i * n for i, n in enumerate(prefix))
    # Use the product of edge denominators to include a symbolic final entry.
    edges = list(zip(prefix, prefix[1:]))
    denominator = Polynomial(1)
    for a, b in edges:
        denominator *= a + b
    peeled = Polynomial(0)
    for i, (a, b) in enumerate(edges):
        term = t**i * a * (a - t * b)
        for j, (a_other, b_other) in enumerate(edges):
            if j != i:
                term *= a_other + b_other
        peeled += term
    tail_mass = 0 if endpoint_only else d
    tail_denominator = c + (1 + t) * tail_mass
    polynomial = (
        (m + tail_mass) * (
            peeled * tail_denominator + denominator * t**k * c * (c + t*tail_mass)
        )
        - denominator * (mass + t**(k+1) * tail_mass) * tail_denominator
    )
    assert_mobius_nonnegative(polynomial)


def edge(a, b):
    return F(a, a + b) * (a - t * b)


def energy_numerator(prefix):
    """(1+t) times the lower bound that retains only prefix edges."""
    return t + sum(
        F(1, a + b) * t**i * (a - t*b)**2
        for i, (a, b) in enumerate(zip(prefix, prefix[1:]))
    )


def univariate_coefficients(poly):
    assert all(j == k == 0 for _, j, k in poly.coefficients)
    degree = max((i for i, _, _ in poly.coefficients), default=0)
    return [poly.coefficients.get((i, 0, 0), 0) for i in range(degree + 1)]


def horner_lower(coefficients, left, right):
    """Lower bound the polynomial on a positive interval by interval Horner."""
    low = high = 0
    for coefficient in reversed(coefficients):
        low = coefficient + low * (left if low >= 0 else right)
        high = coefficient + high * (right if high >= 0 else left)
    return low


def certify_interval(left, right, alternatives):
    """Prove at least one polynomial-plus-power bound on every subinterval."""
    alternatives = [
        (univariate_coefficients(poly), multiple, degree)
        for poly, multiple, degree in alternatives
    ]
    intervals = [(left, right, 0)]
    leaves = 0
    while intervals:
        a, b, depth = intervals.pop()
        if any(horner_lower(poly, a, b) + multiple * a**degree >= 0
               for poly, multiple, degree in alternatives):
            leaves += 1
            continue
        assert depth < 20, (a, b, alternatives)
        midpoint = (a + b) / 2
        intervals.extend([(a, midpoint, depth + 1), (midpoint, b, depth + 1)])
    return leaves


def verify_repeated(k, alpha, beta):
    x = sum(t**i for i in range(k))
    b = sum(t**(j-1) * edge(j, j+1) for j in range(1, k)) + F(k, 2)*t**(k-1)
    assert_mobius_nonnegative((k+1)*b - x)
    total_min = max(19, k*(k+1)//2 + k)
    left = 1 - F(k+1, total_min)
    e = energy_numerator(list(range(1, k+1)))
    constant = e - (1+t)*x*F(1, k) + beta
    slope = t*(1+t)*b*F(1, k) - alpha
    return (
        certify_interval(left, F(1), [(constant, 0, 0)]),
        certify_interval(left, F(1), [(slope, 0, 0)]),
    )


def verify_down_bump(k):
    removed = 2*k - 1
    x = (1-t*t)*sum(j*t**(j-1) for j in range(1, k-1))
    x += (k-1)*t**(k-2) + k*t**(k-1)
    b = (1-t*t)*sum(t**(j-1)*edge(j, j+1) for j in range(1, k-1))
    b += t**(k-2)*edge(k-1, k) + t**(k-1)*edge(k, k-1)
    assert_mobius_nonnegative(removed**2 * b - x)
    minimal_m = max(19, k*(k+1)//2 + k-1)
    e = energy_numerator(list(range(1, k+1)) + [k-1])
    leaves = 0
    for m in range(minimal_m, removed**2):
        exponent = m + 1 - k*(k+1)//2
        induction_polynomial = m*b - x
        energy_polynomial = e + (1+t)*F(1, removed)*((m-removed)*b - x)
        leaves += certify_interval(F(1, 2), F(1), [
            (induction_polynomial, removed, exponent),
            (energy_polynomial, 1, exponent),
        ])
    return removed**2 - minimal_m, leaves


def main():
    if not __debug__:
        raise RuntimeError("Run with assertions enabled")
    cap([1, 3+v])
    cap([1, 2, 4+v])
    cap(list(range(1, 9)))
    cap_count = 3
    for k in range(3, 8):
        prefix = list(range(1, k+1))
        for j in range(1, k-1):
            cap(prefix + [j])
            cap_count += 1
        cap(prefix + [k+2+v])
        cap_count += 1
    print(f"Prefix caps: {cap_count} coefficient certificates")
    for k in (6, 7):
        cap(list(range(1, k+1)), endpoint_only=True)
    print("Staircases with no suffix: 2 coefficient certificates")

    tangents = [
        (F(7, 20), F(7, 10)), (F(1, 4), F(7, 12)),
        (F(1, 7), F(95, 231)), (F(1, 8), F(3, 8)),
        (F(1, 16), F(11, 48)), (F(1, 16), F(11, 48)),
    ]
    for k, (alpha, beta) in enumerate(tangents, 2):
        const, slope = verify_repeated(k, alpha, beta)
        print(f"Repeated level {k}: {const}/{slope} intervals for constant/slope")

    for k in range(3, 8):
        dimensions, leaves = verify_down_bump(k)
        print(f"Down bump {k}: {dimensions} dimensions; {leaves} intervals")


if __name__ == "__main__":
    main()
