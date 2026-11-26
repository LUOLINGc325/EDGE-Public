"""Finite exact Pauli and stabilizer checks for the Clifford charging sectors."""

import itertools
import json
from collections import Counter
from fractions import Fraction
from math import comb


I = (0, 0, 0)


def require(condition, context):
    if not condition:
        raise RuntimeError(str(context))


def pauli_product(left, right):
    x, z, phase = left
    u, v, theta = right
    exponent = phase + theta + 2 * ((z & u).bit_count() % 2)
    return x ^ u, z ^ v, exponent % 4


def times_i_power(operator, power):
    x, z, phase = operator
    return x, z, (phase + power) % 4


def jordan_wigner(modes):
    result = []
    for bit in range(modes):
        pivot = 1 << bit
        prefix = pivot - 1
        result.append((pivot, prefix, 0))
        result.append((pivot, prefix | pivot, 1))
    return result


def embed(operator, offset):
    x, z, phase = operator
    return x << offset, z << offset, phase


def stabilizer_group(generators):
    for index, operator in enumerate(generators):
        require(pauli_product(operator, operator) == I, "involution")
        for previous in generators[:index]:
            require(pauli_product(operator, previous)
                    == pauli_product(previous, operator), "commutation")
    group = {I[:2]: I[2]}
    for generator in generators:
        coset = {}
        for (x, z), phase in group.items():
            u, v, theta = pauli_product((x, z, phase), generator)
            require((u, v) not in group, "dependent stabilizer")
            coset[u, v] = theta
        group.update(coset)
    return group


def expectation(group, operator):
    if operator[:2] not in group:
        return 0
    delta = (operator[2] - group[operator[:2]]) % 4
    require(delta in (0, 2), "real Pauli expectation")
    return 1 if delta == 0 else -1


def verify_physical_sectors():
    sector_checks = partial_checks = dimensions = central_checks = 0
    for m in range(1, 9):
        battery = jordan_wigner(m)
        # Rotate the battery B-generators so their normalized sum is B_1.
        ground = times_i_power(battery[0], 2)
        r = battery[m:]
        auxiliary_modes = m // 2 + 1
        auxiliary = jordan_wigner(auxiliary_modes)
        q = [embed(times_i_power(pauli_product(auxiliary[0], gamma), 1), m)
             for gamma in auxiliary[1:m + 1]]
        parity = embed((0, (1 << auxiliary_modes) - 1, 0), m)
        f = [pauli_product(a, b) for a, b in zip(r, q)]
        f_pair = {(a, b): pauli_product(f[a], f[b])
                  for a in range(m) for b in range(a + 1, m)}
        outcomes = Counter()
        for eps in itertools.product((0, 1), repeat=m - 1):
            j = min(sum(eps), m - sum(eps))
            outcomes[j] += 1
            relatives = [times_i_power(f_pair[index, m - 1], 2 * sign)
                         for index, sign in enumerate(eps)]
            for parity_sign in (0, 1):
                group = stabilizer_group(
                    [ground, times_i_power(parity, 2 * parity_sign)] + relatives)
                actual_dimension = (1 << (m + auxiliary_modes)) // len(group)
                require(actual_dimension == 1 << (auxiliary_modes - 1),
                        (m, eps, "sector dimension"))
                energy = m + 2 * sum(expectation(group, term)
                                     for term in f_pair.values())
                require(energy == (m - 2 * j)**2, (m, eps, "sector energy"))
                sector_checks += 1
        for j in range(m // 2 + 1):
            expected = comb(m, j) // (2 if 2 * j == m else 1)
            require(outcomes[j] == expected, (m, j, "sector count"))
            dimensions += 1

        for k in range(1 if m % 2 else 2, m + 1, 2):
            select = [(a, a + 1) for a in range(k, m, 2)]
            relative = [f_pair[index, k - 1] for index in range(k - 1)]
            b_pairs = [times_i_power(pauli_product(r[a], r[b]), 1)
                       for a, b in select]
            a_pairs = [times_i_power(pauli_product(q[a], q[b]), 3)
                       for a, b in select]
            if (k - 1) % 2:
                center = I
                for index in range(k - 1):
                    xi = times_i_power(pauli_product(r[index], r[k - 1]), 1)
                    center = pauli_product(center, xi)
                center = times_i_power(center, (k - 1) // 2)
                for sign in (0, 1):
                    stabilizer_group([ground] + b_pairs
                                     + [times_i_power(center, 2 * sign)])
                    central_checks += 1
            for parity_sign in (0, 1):
                group = stabilizer_group(
                    [ground, times_i_power(parity, 2 * parity_sign)]
                    + b_pairs + a_pairs + relative)
                energy = m + 2 * sum(expectation(group, term)
                                     for term in f_pair.values())
                require(energy == k*k + 2*(m-k), (m, k, "construction energy"))
                partial_checks += 1
    return {"max_m": 8, "parity_conditioned_sectors": sector_checks,
            "spectral_layers": dimensions, "partial_constructions": partial_checks,
            "restricted_central_signs": central_checks}


def verify_irreducible_bell_vectors():
    checks = 0
    for ell in range(9):
        modes = ell // 2
        d = 1 << modes
        x_ops = jordan_wigner(modes)
        if ell % 2:
            x_ops.append((0, d - 1, 0))
        for eps in itertools.product((0, 1), repeat=ell):
            for (x, z, phase), sign in zip(x_ops, eps):
                transpose_phase = phase + 2 * ((x & z).bit_count() % 2)
                y_phase = (transpose_phase + 2 * sign) % 4
                mapping = set()
                for basis in range(d):
                    # The sign from Z appears twice in this tensor action.
                    require((phase + y_phase) % 4 == 2 * sign,
                            (ell, eps, basis, "Bell-vector eigenvalue"))
                    mapping.add(basis ^ x)
                require(len(mapping) == d, "uniform Bell coefficients")
                checks += 1
    return {"max_generators": 8, "exact_eigenvalue_checks": checks}


def finite_example():
    values = sorted([Fraction((4 - 2 * j)**2, 16)
                     for j in range(3)
                     for _ in range(comb(4, j) // (2 if j == 2 else 1))],
                    reverse=True)
    cap = Fraction(1, 2)
    result = cap * (values[0] + values[1])
    require(result == Fraction(5, 8) > Fraction(1, 2), "cap relaxation")
    return {"m": 4, "rank": 1, "cap": str(result), "separable_optimum": "1/2"}


print(json.dumps({"physical_sectors": verify_physical_sectors(),
                  "bell_vectors": verify_irreducible_bell_vectors(),
                  "strict_cap_example": finite_example()}, indent=2))
