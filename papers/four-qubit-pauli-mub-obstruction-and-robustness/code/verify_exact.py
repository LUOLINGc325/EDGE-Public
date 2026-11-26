"""Exact checks of the low-dimensional Pauli spectrum and trace criteria."""

from itertools import combinations, product
from math import isqrt


REAL = (1, 0, -1, 0)
IMAG = (0, 1, 0, -1)


def parity(value):
    return value.bit_count() % 2


def walsh(values):
    """Unnormalized Boolean Walsh transform in increasing integer label order."""
    result = list(values)
    half = 1
    while half < len(result):
        for offset in range(0, len(result), 2 * half):
            for i in range(offset, offset + half):
                x, y = result[i], result[i + half]
                result[i], result[i + half] = x + y, x - y
        half *= 2
    return result


def derivative_spectrum(phase, shift):
    changes = [(phase[x ^ shift] - phase[x]) % 4 for x in range(len(phase))]
    real = walsh(REAL[change] for change in changes)
    imaginary = walsh(IMAG[change] for change in changes)
    return tuple(a * a + b * b for a, b in zip(real, imaginary))


def lagrangian_count(n):
    d = 1 << n
    low_mask = d - 1

    def orthogonal(v, w):
        vx, vz = v & low_mask, v >> n
        wx, wz = w & low_mask, w >> n
        return parity((vx & wz) ^ (vz & wx)) == 0

    spaces = set()
    for basis in combinations(range(1, d * d), n):
        if not all(orthogonal(a, b) for a, b in combinations(basis, 2)):
            continue
        span = {0}
        for v in basis:
            span |= {w ^ v for w in span}
        if len(span) == d:
            spaces.add(frozenset(span))
    return len(spaces)


def two_qubit_phases():
    phases = set()
    for tail in product(range(4), repeat=3):
        phase = (0,) + tail
        accepted = all(derivative_spectrum(phase, shift) == (4,) * 4 for shift in (1, 2, 3))
        q = tuple(f % 2 for f in phase)
        expected = q[1] ^ q[2] ^ q[3] == 1
        assert accepted == expected
        if accepted:
            phases.add(phase)
    return phases


def defect_trace_score(signs, pairs):
    def part(index, phase):
        return signs[index[0]] * signs[index[1]] * signs[index[2]] * phase

    real = sum(part(index, REAL[phase]) for index, phase in pairs)
    imag = sum(part(index, IMAG[phase]) for index, phase in pairs)
    assert imag == 0
    return real


def two_qubit_trace(physical_phases):
    n = 2
    d = 1 << n
    labels = [(a, b) for a in range(1, d) for b in range(d)]
    idx = {label: k for k, label in enumerate(labels)}
    pairs = []
    for u, (a, b) in enumerate(labels):
        for v, (c, e) in enumerate(labels):
            if a != c:
                ac, be = a ^ c, b ^ e
                power = (a & b).bit_count() + (c & e).bit_count()
                power += 2 * parity(b & c) - (ac & be).bit_count()
                pairs.append(((u, v, idx[(ac, be)]), power % 4))

    def sign_profile(phase):
        output = []
        for a, b in labels:
            codes = [
                (phase[x] - phase[x ^ a] + (a & b).bit_count() + 2 * parity(x & b)) % 4
                for x in range(d)
            ]
            re = sum(REAL[k] for k in codes)
            im = sum(IMAG[k] for k in codes)
            assert im == 0 and abs(re) == isqrt(d)
            output.append(1 if re > 0 else -1)
        return tuple(output)

    raw_target = (d - 1) * (d - 2) * d * isqrt(d)
    trace_pure = {
        signs for signs in product((-1, 1), repeat=len(labels))
        if defect_trace_score(signs, pairs) == raw_target
    }
    independently_pure = {sign_profile(phase) for phase in physical_phases}
    assert trace_pure == independently_pure
    return len(trace_pure)


def four_qubit_replay():
    d = 16
    bent = 0
    for mask in range(1 << (d - 1)):
        q = [0] + [(mask >> x) & 1 for x in range(d - 1)]
        spectrum = walsh(-1 if bit else 1 for bit in q)
        if all(abs(value) == 4 for value in spectrum):
            # Recover each Boolean monomial coefficient of degree three or four.
            for term in range(d):
                if term.bit_count() >= 3:
                    assert sum(q[x] for x in range(d) if x & term == x) % 2 == 0
            bent += 1

    canonical = [int((x & 3) == 3) ^ int((x >> 2) == 3) for x in range(d)]
    checked = 0
    for mask in range(1 << (d - 1)):
        h = [0] + [(mask >> x) & 1 for x in range(d - 1)]
        phase = [b + 2 * higher for b, higher in zip(canonical, h)]
        # The t=0 Walsh frequencies on the second block already contradict
        # flatness for at least one of the three nonzero shifts on the first.
        assert any(
            derivative_spectrum(phase, shift)[:4] != (d,) * 4 for shift in (1, 2, 3)
        ), phase
        checked += 1
    return bent, checked


def main():
    cos2_times_two = (2, 1, 0, 1, 2, 1, 0, 1)
    correct = [k for k, x in enumerate(cos2_times_two) if x == 1]
    assert correct == [1, 3, 5, 7]
    lag_one = lagrangian_count(1)
    lag_two = lagrangian_count(2)
    assert (lag_one, lag_two) == (3, 15)
    phases = two_qubit_phases()
    trace_count = two_qubit_trace(phases)
    assert len(phases) == trace_count == 32
    bent, four_candidates = four_qubit_replay()
    assert bent == 448 and four_candidates == 32768
    print(f"One qubit: {lag_one} Lagrangians, {len(correct)} rays per Lagrangian.")
    print(f"Two qubits: {lag_two} Lagrangians, {len(phases)} rays per Lagrangian.")
    print(f"Exact Pauli cube trace among 4096 sign assignments: {trace_count} pure.")
    print(f"Four qubits: {bent} normalized Boolean bent functions, all quadratic.")
    print(f"All {four_candidates} normalized high-bit lifts of the canonical one fail.")


if __name__ == "__main__":
    main()
