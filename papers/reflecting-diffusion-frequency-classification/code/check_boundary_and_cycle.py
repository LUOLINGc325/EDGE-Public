"""Exact disk boundary, resolvent, and cyclic-overlap identities."""

from fractions import Fraction
from itertools import product

import sympy as sp


def main():
    x, y = sp.symbols("x y", real=True)
    radius2 = x**2 + y**2
    z = (x + sp.I * y) * (1 - radius2 / 3)
    rotation = sp.Matrix([-y, x])
    normal = sp.Matrix([x, y])
    grad_z = sp.Matrix([sp.diff(z, x), sp.diff(z, y)])
    assert rotation.dot(normal) == 0
    assert sp.diff(rotation[0], x) + sp.diff(rotation[1], y) == 0
    assert sp.expand(normal.dot(grad_z) - (x + sp.I * y) * (1 - radius2)) == 0
    assert sp.expand(rotation.dot(grad_z) - sp.I * z) == 0

    gamma, kappa = sp.symbols("gamma kappa", positive=True)
    response = sp.expand_complex(1 / (gamma - sp.I * kappa)**2)
    coefficient = 2 * gamma * kappa / (gamma**2 + kappa**2)**2
    assert sp.simplify(sp.im(response) - coefficient) == 0
    assert coefficient.is_positive

    b00, b01, b10, b11 = sp.symbols("b00 b01 b10 b11", real=True)
    operator = sp.Matrix([[b00, b01], [b10, b11]])
    z_vector = sp.Matrix([1, sp.I])
    pairing = (z_vector.conjugate().T * operator * z_vector)[0]
    phases = [
        sp.Matrix([1, 0]),
        sp.Matrix([0, -1]),
        sp.Matrix([-1, 0]),
        sp.Matrix([0, 1]),
    ]
    total = sum(
        (phases[(i + 1) % 4].T * operator *
         (phase - phases[(i + 1) % 4]))[0]
        for i, phase in enumerate(phases)
    )
    assert sp.expand(total - 2 * sp.re((-sp.I - 1) * pairing)) == 0

    phase_count = 0
    for real, imag in product(range(-12, 13), range(1, 9)):
        half_angle = Fraction(imag, 2 * (abs(real) + imag))
        cosine = (1 - half_angle**2) / (1 + half_angle**2)
        sine = 2 * half_angle / (1 + half_angle**2)
        assert cosine**2 + sine**2 == 1
        gain = (cosine - 1) * real + sine * imag
        assert gain == sine * (imag - half_angle * real) > 0
        phase_count += 1

    rate, decay = sp.symbols("rate decay", positive=True)
    assert sp.simplify(sp.integrate(rate * sp.exp(-(rate + decay) * x), (x, 0, sp.oo)) - rate / (decay + rate)) == 0

    print("Reflecting disk: 4 symbolic boundary, divergence and harmonic-mode identities")
    print("Sector resolvent: exact positive imaginary part")
    print("Cycle overlap: exact non-symmetric 2x2 four-phase identity")
    print(f"Positive half-angle rational controls: {phase_count}")
    print("Exponential dwell: exact Laplace factor")


if __name__ == "__main__":
    main()
