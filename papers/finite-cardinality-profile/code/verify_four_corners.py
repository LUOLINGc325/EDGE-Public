"""Exact cone enumeration and corner checks for the four-element gap."""

from fractions import Fraction
from itertools import combinations, permutations
from math import comb, gcd


ELEMENTS = (1, 2, 4, 8)
DIMENSION = 15


def submodularity_rows():
    for first, second in combinations(ELEMENTS, 2):
        for base in range(DIMENSION + 1):
            if base & (first | second):
                continue
            row = [0] * DIMENSION
            row[(base | first) - 1] += 1
            row[(base | second) - 1] += 1
            row[(base | first | second) - 1] -= 1
            if base:
                row[base - 1] -= 1
            yield tuple(row)


def dot(left, right):
    return sum(a * b for a, b in zip(left, right) if a)


def all_rays():
    # Coordinates are in increasing order of the nonempty subset masks.
    rays = [tuple(int(i == j) for j in range(DIMENSION)) for i in range(DIMENSION)]
    all_coordinates = (1 << DIMENSION) - 1
    active = [all_coordinates ^ (1 << i) for i in range(DIMENSION)]

    for cut_index, row in enumerate(submodularity_rows(), start=DIMENSION):
        values = [dot(row, ray) for ray in rays]
        positive = [index for index, value in enumerate(values) if value > 0]
        negative = [index for index, value in enumerate(values) if value < 0]
        kept = [index for index, value in enumerate(values) if value >= 0]
        new_bit = 1 << cut_index
        new_rays = [rays[index] for index in kept]
        new_active = [
            active[index] | (new_bit if values[index] == 0 else 0)
            for index in kept
        ]
        for inside in positive:
            for outside in negative:
                common = active[inside] & active[outside]
                # The common tight inequalities define the smallest face
                # containing both rays. A two-dimensional pointed face has two rays.
                if sum(mask & common == common for mask in active) != 2:
                    continue
                crossing = tuple(
                    -values[outside] * a + values[inside] * b
                    for a, b in zip(rays[inside], rays[outside])
                )
                divisor = gcd(*crossing)
                new_rays.append(tuple(value // divisor for value in crossing))
                new_active.append(common | new_bit)

        rays, active = new_rays, new_active
        if len(set(rays)) != len(rays):
            raise ArithmeticError('duplicate extreme ray')

    return rays


def orbit_representative(ray):
    return min(
        tuple(
            ray[sum(relabel[j] for j, bit in enumerate(ELEMENTS) if subset & bit) - 1]
            for subset in range(1, DIMENSION + 1)
        )
        for relabel in permutations(ELEMENTS)
    )


def corner_coefficients(ray, support):
    singleton_sum = sum(ray[bit - 1] for bit in ELEMENTS if support & bit)
    if singleton_sum == 0:
        return None

    # Coefficients in the power basis for F((1-q) 1_support)/((1-q)
    # singleton_sum) minus q - q**2/3 + q**3/27.
    powers = [Fraction(0), Fraction(-1), Fraction(1, 3), Fraction(-1, 27)]
    for subset in range(1, DIMENSION + 1):
        if subset & support != subset:
            continue
        present = subset.bit_count()
        absent = (support ^ subset).bit_count()
        for term in range(present):
            powers[absent + term] += Fraction(
                ray[subset - 1] * comb(present - 1, term) * (-1) ** term,
                singleton_sum,
            )

    # Degree-three Bernstein coefficients on 0 <= q <= 3/4.
    return tuple(
        sum(
            powers[term] * Fraction(3, 4) ** term
            * Fraction(comb(index, term), comb(3, term))
            for term in range(index + 1)
        )
        for index in range(4)
    )


def main():
    rays = all_rays()
    if len(rays) != 218:
        raise ArithmeticError('unexpected number of extreme rays')
    reps = sorted(set(map(orbit_representative, rays)))
    if len(reps) != 20:
        raise ArithmeticError('unexpected number of ray orbits')

    # These ray numbers receive direct analytic bounds.
    direct = {6, 12, 14, 15, 16, 17, 19}
    for number, ray in enumerate(reps, start=1):
        print(number, ray)
        if number in direct:
            continue
        coefficients = [
            values for support in range(1, DIMENSION + 1)
            if (values := corner_coefficients(ray, support)) is not None
        ]
        minima = tuple(min(column) for column in zip(*coefficients))
        if not all(value >= 0 for value in minima):
            raise ArithmeticError(f'negative Bernstein coefficient in orbit {number}')
        print("  Bernstein minima", ", ".join(map(str, minima)))


if __name__ == "__main__":
    main()
