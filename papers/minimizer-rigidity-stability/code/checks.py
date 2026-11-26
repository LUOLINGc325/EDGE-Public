"""Exact finite checks for spectral cut estimates and rigidity witnesses."""
from fractions import Fraction as Q
from itertools import combinations, product
from math import isqrt


def same_side_overlap_squared(left, right):
    return min(left*right, (1-left)*(1-right))


def check_cut_probabilities():
    grid = [Q(k, 20) for k in range(21)]
    count = 0
    for first, middle, last in product(grid, repeat=3):
        defect_half = middle*(1-first)*(1-last) + (1-middle)*first*last
        assert defect_half >= same_side_overlap_squared(first, last)
        assert defect_half >= same_side_overlap_squared(first, middle)**2
        assert defect_half >= same_side_overlap_squared(middle, last)**2
        count += 1
    return count


def check_binary_projection_witnesses():
    for numerator in range(1, 51):
        t = Q(numerator, 1000)
        matrix_entry_squared = t*(1-t)
        first, second, third = 1-t, t, Q(0)
        adjacent_defect = 2*(second*(1-first)*(1-third) + (1-second)*first*third)
        assert adjacent_defect == 2*t*t
        first, second, third = 1-t, Q(0), t
        endpoint_defect = 2*(second*(1-first)*(1-third) + (1-second)*first*third)
        assert endpoint_defect == 2*matrix_entry_squared
    return 100


def check_square_root_metric():
    count = 0
    for first, middle, last in product(range(26), repeat=3):
        distances = [abs(first-middle), abs(middle-last), abs(first-last)]
        roots = [isqrt(distance) for distance in distances]
        if not all(root*root == distance for root, distance in zip(roots, distances)):
            continue
        linear_defect = distances[0]+distances[1]-distances[2]
        sqrt_defect = roots[0]+roots[1]-roots[2]
        assert sqrt_defect >= Q(3, 20)*linear_defect  # (1 + p) L^(p-1) / 2
        count += 1
    return count


def check_full_chain():
    count = 0
    for n in range(3, 12):
        chain_ratio = Q(n-2, n)
        for length in range(3, n+1):
            for chain in combinations(range(n), length):
                deficit = chain[-1]-chain[0]-1
                deficit -= sum(right-left-1 for left, right in zip(chain, chain[1:]))
                assert deficit == length-2
                assert Q(deficit, length) <= chain_ratio
                count += 1
    return count


def check_degenerate_minimizer():
    # Coordinate levels with a two-dimensional middle block.
    level = [0, 1, 1, 2]
    cut1, cut2 = (0, 1, 1, 1), (0, 0, 0, 1)
    projection1, projection2 = (0, 1, 0, 1), (0, 0, 1, 1)
    delta, strength = Q(2, 3), Q(1, 5)
    gamma = Q(5, 3)
    projections = (cut1, cut2, projection1, projection2)
    coefficients = (gamma-strength, gamma-strength, strength, strength)
    costs = {(i, j): sum(amount*abs(proj[i]-proj[j])
                        for amount, proj in zip(coefficients, projections))
             for i, j in product(range(4), repeat=2)}
    target = {(i, j): (level[i]-level[j])**2 for i, j in costs}
    assert max(abs(target[pair]-cost) for pair, cost in costs.items()) == delta
    assert all(cost == gamma*abs(level[i]-level[j])
               for (i, j), cost in costs.items() if level[i] != level[j])
    assert costs[1, 2] == 2*strength > 0
    return len(costs)


if __name__ == "__main__":
    print(f"{check_cut_probabilities()} rational triples of spectral CDF values")
    print(f"{check_binary_projection_witnesses()} exact rotating-projection checks")
    print(f"{check_square_root_metric()} exact square-root triangle comparisons")
    print(f"{check_full_chain()} exact chain comparisons")
    print(f"{check_degenerate_minimizer()} tensor-coordinate checks for a degenerate optimum")
