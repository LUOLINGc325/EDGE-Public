#!/usr/bin/env python3
"""Verify the qutrit-machine bound for every full-rank qutrit distribution."""
from collections import Counter, defaultdict
from itertools import combinations_with_replacement, permutations, product
from math import comb, gcd


SYSTEM_EXPONENTS = ((0, 0), (1, 0), (1, 1))
BASIS = ((0, 0), (1, 0), (0, 1))
RAYS = ((0, 1), (1, 0)) + tuple(
    (a, b) for a, b in product(range(1, 4), repeat=2) if gcd(a, b) == 1
)


def add(*vectors):
    return tuple(sum(coordinates) for coordinates in zip(*vectors))


def subtract(first, second):
    return tuple(a - b for a, b in zip(first, second))


def dot(first, second):
    return sum(a * b for a, b in zip(first, second))


DIFFERENCES = sorted({
    subtract(first, second) for first, second in product(SYSTEM_EXPONENTS, repeat=2)
})
MACHINE_PATTERNS = tuple(
    ((0, 0), first, second)
    for first, second in combinations_with_replacement(DIFFERENCES, 2)
)


def resonant_maps(system, machine):
    shells = defaultdict(list)
    for x, y in product(range(3), repeat=2):
        shells[add(system[x], machine[y])].append((x, y))
    groups = list(shells.values())
    for sources in product(*(permutations(group) for group in groups)):
        yield {
            target: source for targets, source_group in zip(groups, sources)
            for target, source in zip(targets, source_group)
        }


def matrix_entries(system, machine, feeding):
    result = [defaultdict(int) for _ in range(3)]
    indices = ((0, 0), (0, 1), (1, 1))
    for x in range(3):
        changes = [subtract(BASIS[feeding[x, y][1]], BASIS[y]) for y in range(3)]
        for y, z in product(range(3), repeat=2):
            power = add(system[x], machine[y], machine[z])
            for entry, (i, j) in zip(result, indices):
                entry[power] += (2 * changes[y][i] * changes[y][j]
                                 - 3 * changes[y][i] * changes[z][j])
    return result


def determinant(a, b, c):
    result = defaultdict(int)
    for i, j in product(a, c):
        result[add(i, j)] += a[i] * c[j]
    for i, j in product(b, b):
        result[add(i, j)] -= b[i] * b[j]
    return result


def remove_positive_monomial(polynomial):
    nonzero = {index: value for index, value in polynomial.items() if value}
    if not nonzero:
        return {}
    minimum = tuple(min(exponents) for exponents in zip(*nonzero))
    return {subtract(index, minimum): value for index, value in nonzero.items()}


def transformed_nonnegative(polynomial):
    degrees = tuple(max(exponents) for exponents in zip(*polynomial))
    coefficients = defaultdict(int)
    for powers, value in polynomial.items():
        for target in product(*(range(a, b + 1) for a, b in zip(powers, degrees))):
            factor = 1
            for power, degree, index in zip(powers, degrees, target):
                factor *= comb(degree - power, index - power)
            coefficients[target] += value * factor
    return min(coefficients.values()) >= 0


def square_certificate(polynomial, ray):
    # 4u^2 + 17uv + 5u + (2v-1)^2 and its (u,v)=(t^3,t) specialization.
    exception = {(2, 0): 4, (1, 1): 17, (1, 0): 5,
                 (0, 2): 4, (0, 1): -4, (0, 0): 1}
    if ray is None:
        return polynomial == exception
    if ray != (3, 1):
        return False
    return polynomial == {(dot(index, ray),): value for index, value in exception.items()}


def check_family(system, machines, ray=None):
    count = 0
    tally = Counter()
    for machine in machines:
        for feeding in resonant_maps(system, machine):
            count += 1
            a, b, c = matrix_entries(system, machine, feeding)
            for test in (a, c, determinant(a, b, c)):
                reduced = remove_positive_monomial(test)
                if not reduced:
                    tally["zero"] += 1
                elif transformed_nonnegative(reduced):
                    tally["transformed"] += 1
                else:
                    assert square_certificate(reduced, ray), (machine, ray, reduced)
                    tally["square"] += 1
    return count, tally


def project_machines(ray):
    patterns = set()
    for machine in MACHINE_PATTERNS:
        projected = sorted(dot(vector, ray) for vector in machine)
        patterns.add(tuple((value - projected[0],) for value in projected))
    return sorted(patterns)


def main():
    if not __debug__:
        raise RuntimeError("Run with assertions enabled")
    assert len(MACHINE_PATTERNS) == 28
    count, tally = check_family(SYSTEM_EXPONENTS, MACHINE_PATTERNS)
    print(f"generic: 28 exponent patterns, {count} permutations, {dict(tally)}")
    total = count
    for ray in RAYS:
        machines = project_machines(ray)
        system = tuple((dot(vector, ray),) for vector in SYSTEM_EXPONENTS)
        amount, counts = check_family(system, machines, ray)
        total += amount
        tally.update(counts)
        print(f"ray {ray}: {len(machines)} exponent patterns, {amount} permutations, {dict(counts)}")
    assert total == 14382
    assert tally["square"] == 2
    assert sum(tally.values()) == 3 * total
    print(f"total permutations: {total}")
    print(f"principal-minor certificates: {dict(tally)}")


if __name__ == "__main__":
    main()
