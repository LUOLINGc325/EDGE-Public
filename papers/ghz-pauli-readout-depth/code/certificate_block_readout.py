#!/usr/bin/env python3
"""Integer checks of the cat-block and one-qubit frame calculations."""

from fractions import Fraction
from itertools import product


ROOTS = ((1, 0), (0, 1), (-1, 0), (0, -1))
AXES = "XYZ"


def fanout_bits(value, block_length, inverse=False):
    controls = range(block_length - 1)
    if inverse:
        controls = reversed(controls)
    for control in controls:
        if (value >> control) & 1:
            value ^= 1 << (control + 1)
    return value


def check_gate_columns(block_length):
    ones = (1 << block_length) - 1
    for branch, expected_sign in ((0, 1), (ones, -1)):
        decoded = fanout_bits(branch, block_length, inverse=True)
        assert decoded in (0, 1)
        zero_output = fanout_bits(decoded & ~1, block_length)
        one_output = fanout_bits(decoded | 1, block_length)
        assert (zero_output, one_output) == (0, ones)
        assert (-1) ** decoded == expected_sign


def cat_numerators(axes, bits):
    zero_support = True
    one_support = True
    exponent = 0
    for axis, bit in zip(axes, bits):
        if axis == "Z":
            zero_support &= bit == 0
            one_support &= bit == 1
        elif axis == "X":
            exponent += 2 * bit
        else:
            exponent += 2 * bit - 1
    real, imag = ROOTS[exponent % 4] if one_support else (0, 0)
    zero = int(zero_support)
    return (zero + real, imag), (zero - real, -imag)


def norm_squared(pair):
    return pair[0] ** 2 + pair[1] ** 2


def conjugate_product(first, second):
    return (
        first[0] * second[0] + first[1] * second[1],
        first[0] * second[1] - first[1] * second[0],
    )


def check_block(block_length):
    check_gate_columns(block_length)
    blocked_settings = 0
    for axes in product(AXES, repeat=block_length):
        obstructed = "Z" not in axes and axes.count("Y") % 2 == 0
        blocked_settings += obstructed
        plus_total = minus_total = cross_real = cross_imag = 0
        for bits in product((0, 1), repeat=block_length):
            plus, minus = cat_numerators(axes, bits)
            plus_size, minus_size = norm_squared(plus), norm_squared(minus)
            real, imag = conjugate_product(plus, minus)
            plus_total += plus_size
            minus_total += minus_size
            cross_real += real
            cross_imag += imag
            if obstructed:
                assert plus_size * minus_size == 0
            else:
                assert plus_size == minus_size
                if "Z" in axes:
                    assert imag == 0 and abs(real) == plus_size
                else:
                    assert real == 0 and abs(imag) == plus_size
        normalization = 2 ** (block_length - axes.count("Z") + 1)
        assert plus_total == minus_total == normalization
        assert cross_real == cross_imag == 0

    assert blocked_settings == 2 ** (block_length - 1)
    fraction = Fraction(3**block_length - blocked_settings, 3**block_length)
    return blocked_settings, fraction


def check_one_qubit_frame():
    trace_vectors = []
    for axis in AXES:
        for sign in (-1, 1):
            traces = [1]
            traces.extend(sign * (axis == op) for op in AXES)
            trace_vectors.append(traces)

    # The Hilbert--Schmidt Gram matrix of I,X,Y,Z is 2 I.
    coefficients = [
        [
            Fraction(sum(tr[i] * tr[j] for tr in trace_vectors), 6)
            for j in range(4)
        ]
        for i in range(4)
    ]
    eigenvalues = (Fraction(1), Fraction(1, 3), Fraction(1, 3), Fraction(1, 3))
    assert coefficients == [
        [eigenvalues[i] if i == j else 0 for j in range(4)]
        for i in range(4)
    ]
    return eigenvalues


def main():
    print("one-qubit Pauli frame eigenvalues:", " ".join(map(str, check_one_qubit_frame())))
    for length in range(1, 7):
        blocked, fraction = check_block(length)
        print(
            f"block_length={length} settings={3**length} "
            f"blocked={blocked} generic_fisher_fraction={fraction}"
        )
    _, fraction = check_block(3)
    assert fraction**2 == Fraction(529, 729)
    print("two length-three blocks: generic_fisher_fraction=529/729")


if __name__ == "__main__":
    main()
