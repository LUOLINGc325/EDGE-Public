"""Exact finite components for the Manhattan and squared-Euclidean nearest-graph result."""

from fractions import Fraction as Q
from itertools import combinations, permutations, product


def adjacency(order, edges):
    matrix = [[0] * order for _ in range(order)]
    for i, j in edges:
        matrix[i][j] = matrix[j][i] = 1
    return matrix


def graphs(order):
    edges = tuple(combinations(range(order), 2))
    for mask in range(1 << len(edges)):
        yield adjacency(order, (edge for i, edge in enumerate(edges) if mask >> i & 1))


def determinant(matrix):
    """Bareiss determinant, with row pivoting."""
    size = len(matrix)
    matrix = [row[:] for row in matrix]
    previous, sign = 1, 1
    for i in range(size - 1):
        pivot_row = next((j for j in range(i, size) if matrix[j][i]), None)
        if pivot_row is None:
            return 0
        if pivot_row != i:
            matrix[i], matrix[pivot_row] = matrix[pivot_row], matrix[i]
            sign = -sign
        pivot = matrix[i][i]
        for j in range(i + 1, size):
            for k in range(i + 1, size):
                value = pivot * matrix[j][k] - matrix[j][i] * matrix[i][k]
                quotient, remainder = divmod(value, previous)
                assert remainder == 0
                matrix[j][k] = quotient
            matrix[j][i] = 0
        previous = pivot
    return sign * matrix[-1][-1]


def negative_shifted(graph, numerator, denominator):
    """Negative inertia of A - (numerator / denominator) I, at noninteger shifts."""
    assert numerator % denominator
    size = len(graph)
    matrix = [
        [denominator * entry - (numerator if row == col else 0)
         for col, entry in enumerate(values)]
        for row, values in enumerate(graph)
    ]
    previous, negative = 1, 0
    for i in range(size):
        pivot = matrix[i][i]
        assert pivot
        negative += (pivot < 0) != (previous < 0)
        for j in range(i + 1, size):
            for k in range(j, size):
                value = pivot * matrix[j][k] - matrix[j][i] * matrix[i][k]
                quotient, remainder = divmod(value, previous)
                assert remainder == 0
                matrix[j][k] = matrix[k][j] = quotient
        previous = pivot
    return negative


def rank_five_check():
    count, least_mass, least_sign = 0, 2 * 128**2, 2 * 128
    for graph in graphs(5):
        if determinant(graph) == 0:
            continue
        count += 1
        mass, positive_sum, negative_sum = 0, 0, 0
        for step in range(1, 128):
            below = negative_shifted(graph, -step, 128)
            above = 5 - negative_shifted(graph, step, 128)
            negative = min(2, max(0, below - 2))
            positive = min(2, max(0, above - 1))
            mass += (2 * step - 1) * (negative + positive)
            negative_sum += negative
            positive_sum += positive
        least_mass = min(least_mass, mass)
        least_sign = min(least_sign, max(negative_sum, positive_sum))
    assert 12 * least_mass > 7 * 128**2
    assert 100 * least_sign > 61 * 128
    print(f"rank_five_principal_blocks={count}, middle_mass_at_least={least_mass}/{128**2}, "
          f"one_sign_budget_at_least={least_sign}/128")


def rank_six_sign_check():
    count, least_sign = 0, 3 * 8
    for graph in graphs(6):
        if determinant(graph) == 0:
            continue
        count += 1
        positive_sum, negative_sum = 0, 0
        for step in range(1, 8):
            below = negative_shifted(graph, -step, 8)
            above = 6 - negative_shifted(graph, step, 8)
            negative_sum += min(3, max(0, below - 2))
            positive_sum += min(3, max(0, above - 1))
        least_sign = min(least_sign, max(negative_sum, positive_sum))
    assert 100 * least_sign > 61 * 8
    print(f"rank_six_principal_blocks={count}, one_sign_budget_at_least={least_sign}/8")

PAW = adjacency(4, [(0, 1), (0, 2), (1, 2), (0, 3)])
DOUBLE_LEAF = adjacency(5, [(0, 1), (0, 2), (1, 2), (1, 3), (0, 4)])


def isomorphic(first, second):
    size = len(first)
    return size == len(second) and any(
        all(first[i][j] == second[order[i]][order[j]]
            for i in range(size) for j in range(i))
        for order in permutations(range(size))
    )


def bipartite(graph):
    side = {}
    for start in range(len(graph)):
        if start in side:
            continue
        side[start] = 0
        active = [start]
        while active:
            i = active.pop()
            for j, edge in enumerate(graph[i]):
                if not edge:
                    continue
                if j not in side:
                    side[j] = 1 - side[i]
                    active.append(j)
                elif side[i] == side[j]:
                    return False
    return True


def adjugate(matrix):
    order = len(matrix)
    return [[(-1)**(i+j) * determinant([
        [matrix[row][col] for col in range(order) if col != i]
        for row in range(order) if row != j])
        for j in range(order)] for i in range(order)]


def reduced_completions(basis, det):
    order = len(basis)
    inverse_numerator = adjugate(basis)
    for i in range(order):
        for j in range(order):
            assert sum(basis[i][k] * inverse_numerator[k][j] for k in range(order)) == (
                det if i == j else 0
            )

    def inner(a, b):
        return sum(a[i] * inverse_numerator[i][j] * b[j]
                   for i in range(order) for j in range(order))

    columns = {tuple(column) for column in zip(*basis)}
    allowed = [x for x in product((0, 1), repeat=order)
               if any(x) and x not in columns and inner(x, x) == 0]

    def visit(chosen, candidates):
        size = order + len(chosen)
        completed = [[0] * size for _ in range(size)]
        for i in range(order):
            for j in range(order):
                completed[i][j] = basis[i][j]
        for i, x in enumerate(chosen, order):
            for j, value in enumerate(x):
                completed[i][j] = completed[j][i] = value
        for i, x in enumerate(chosen, order):
            for j, y in enumerate(chosen[:i-order], order):
                completed[i][j] = completed[j][i] = inner(x, y) // det
        yield completed
        for i, x in enumerate(candidates):
            yield from visit(chosen + (x,), [y for y in candidates[i+1:]
                                             if inner(x, y) in (0, det)])

    yield from visit((), allowed)


def rank_four_check():
    count, allowed = 0, 0
    for basis in graphs(4):
        det = determinant(basis)
        if det == 0:
            continue
        for core in reduced_completions(basis, det):
            count += 1
            if bipartite(core):
                continue
            if len(core) - negative_shifted(core, 331, 500) >= 2:
                continue
            if negative_shifted(core, -4, 5) >= 3:
                continue
            allowed += 1
            assert isomorphic(core, PAW) or isomorphic(core, DOUBLE_LEAF)

    for vertex in (0, 1, 3, 4):
        clone = [row + [row[vertex]] for row in DOUBLE_LEAF]
        clone.append(DOUBLE_LEAF[vertex] + [0])
        assert 6 - negative_shifted(clone, 331, 500) >= 2
    print(f"rank_four_core_completions={count}, retained_representations={allowed}")


def rational_negative_inertia(matrix):
    """Exact symmetric Schur elimination, including zero or 2x2 pivots."""
    size = len(matrix)
    if size == 0:
        return 0
    index = next((i for i in range(size) if matrix[i][i]), None)
    if index is not None:
        remaining = [i for i in range(size) if i != index]
        pivot = matrix[index][index]
        trailing = [[matrix[i][j] - matrix[i][index] * matrix[index][j] / pivot
                     for j in remaining] for i in remaining]
        return (pivot < 0) + rational_negative_inertia(trailing)

    pair = next(((i, j) for i in range(size) for j in range(i)
                 if matrix[i][j]), None)
    if pair is None:
        return 0
    left, right = pair
    pivot = matrix[left][right]
    remaining = [i for i in range(size) if i not in pair]
    trailing = [[matrix[i][j] - (
        matrix[i][left] * matrix[right][j] + matrix[i][right] * matrix[left][j]
    ) / pivot for j in remaining] for i in remaining]
    return 1 + rational_negative_inertia(trailing)


def paw_below(masses, shift):
    # Congruence removes all square roots of cell sizes.
    return rational_negative_inertia([
        [Q(PAW[i][j]) - (shift / masses[i] if i == j else 0) for j in range(4)]
        for i in range(4)
    ])


def paw_distance_bounds(masses, n):
    lower_one, upper_one, lower_two, upper_two = (Q(0) for _ in range(4))
    for index, target in enumerate((-n, -n, 0, 2*n)):
        lo, hi = Q(-3*n), Q(3*n)
        for _ in range(20):
            mid = (lo + hi) / 2
            if paw_below(masses, mid) > index:
                hi = mid
            else:
                lo = mid
        greatest = max(abs(lo - target), abs(hi - target))
        upper_one += greatest
        upper_two += greatest**2
        if not lo <= target <= hi:
            smallest = min(abs(lo - target), abs(hi - target))
            lower_one += smallest
            lower_two += smallest**2
    return lower_one, upper_one, lower_two, upper_two


def finite_paw_check():
    count, close = 0, 0
    for n in range(3, 20):
        winner = (n-1, n, n, 1)
        _, l1_upper, _, l2_upper = paw_distance_bounds(winner, n)
        assert l1_upper < Q(61, 50) and l2_upper < Q(7, 12)
        for a in range(1, 3*n-2):
            for b in range(1, 3*n-a-1):
                for c in range(b, 3*n-a-b):
                    leaves = range(1, 3*n-a-b-c+1) if n < 7 else (1,)
                    for d in leaves:
                        if a+b+c+d > 3*n or (n >= 7 and a+b+c+d != 3*n):
                            continue
                        masses = (a, b, c, d)
                        if masses == winner:
                            continue
                        count += 1
                        if (paw_below(masses, -Q(n) - Q(4, 5)) != 0 or
                            paw_below(masses, -Q(n) + Q(4, 5)) != 2 or
                            paw_below(masses, Q(2, 3)) != 3 or
                            paw_below(masses, Q(2*n) - Q(4, 5)) != 3 or
                            paw_below(masses, Q(2*n) + Q(4, 5)) != 4):
                            continue
                        close += 1
                        l1_lower, _, l2_lower, _ = paw_distance_bounds(masses, n)
                        assert l1_lower > Q(61, 50) and l2_lower > Q(7, 12)
    print(f"n_3_to_19_paw_competitors={count}, after_coordinate_filters={close}")


if __name__ == "__main__":
    rank_five_check()
    rank_six_sign_check()
    rank_four_check()
    finite_paw_check()
    print("EXACT_CHECKS_OK")
