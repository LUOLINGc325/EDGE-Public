"""Exact real-matrix witnesses for first-count survival tomography."""
from fractions import Fraction as Q
from itertools import product


def identity(d):
    return [[Q(i == j) for j in range(d)] for i in range(d)]


def transpose(matrix):
    return [list(column) for column in zip(*matrix)]


def multiply(left, right):
    return [[sum(a*b for a, b in zip(row, column)) for column in zip(*right)]
            for row in left]


def add(left, right):
    return [[a+b for a, b in zip(row, other)] for row, other in zip(left, right)]


def subtract(left, right):
    return [[a-b for a, b in zip(row, other)] for row, other in zip(left, right)]


def scale(matrix, factor):
    return [[factor*entry for entry in row] for row in matrix]


def flatten(matrix):
    return [entry for row in matrix for entry in row]


def eliminate(matrix, pivot_columns):
    rows = [[Q(entry) for entry in row] for row in matrix]
    next_row = 0
    for j in range(pivot_columns):
        pivot = next((i for i in range(next_row, len(rows)) if rows[i][j]), None)
        if pivot is None:
            continue
        rows[next_row], rows[pivot] = rows[pivot], rows[next_row]
        normalizer = rows[next_row][j]
        rows[next_row] = [entry/normalizer for entry in rows[next_row]]
        for i in range(len(rows)):
            if i == next_row or rows[i][j] == 0:
                continue
            factor = rows[i][j]
            rows[i] = [a-factor*b for a, b in zip(rows[i], rows[next_row])]
        next_row += 1
        if next_row == len(rows):
            break
    return rows, next_row


def solve(matrix, rhs):
    d = len(matrix)
    augmented = [list(row)+list(right) for row, right in zip(matrix, rhs)]
    rows, rank = eliminate(augmented, d)
    assert rank == d
    return [row[d:] for row in rows]


def inverse(matrix):
    return solve(matrix, identity(len(matrix)))


def lyapunov(F, X):
    return add(multiply(F, X), multiply(X, transpose(F)))


def survival(F, s):
    d = len(F)
    indices = list(product(range(d), repeat=2))
    matrix = [
        [
            (F[i][a] if b == j else 0)
            + (F[j][b] if a == i else 0)
            + (s if (i, j) == (a, b) else 0)
            for a, b in indices
        ]
        for i, j in indices
    ]
    flat = solve(matrix, [[Q(i == j)] for i, j in indices])
    M = [[flat[i*d+j][0] for j in range(d)] for i in range(d)]
    assert M == transpose(M)
    assert add(lyapunov(F, M), scale(M, s)) == identity(d)
    return M


def sample_generator(d):
    # F = G/2 + a real skew matrix, corresponding to purely imaginary H.
    return [[Q(i+1, 2) if i == j else Q(1 if i < j else -1, 17)
             for j in range(d)] for i in range(d)]


def commutant_rank(operators):
    d = len(operators[0])
    indices = list(product(range(d), repeat=2))
    rows = [
        [(operator[b][j] if a == i else 0)-(operator[i][a] if b == j else 0)
         for a, b in indices]
        for operator in operators for i, j in indices
    ]
    return eliminate(rows, d*d)[1]


def check_three_samples():
    frequencies = ((Q(1), Q(2), Q(3)), (Q(1, 2), Q(3), Q(1)))
    count = 0
    for d, sample in product(range(2, 6), frequencies):
        F = sample_generator(d)
        m1, m2, m3 = [survival(F, s) for s in sample]
        z2, z3 = [multiply(inverse(m1), m) for m in (m2, m3)]
        assert commutant_rank((z2, z3)) == d*d-1
        assert commutant_rank((z2,)) <= d*d-d
        count += 1
    return count


def check_krylov():
    dimensions = []
    for d in range(2, 5):
        F = sample_generator(d)
        current = identity(d)
        vectors = []
        for _ in range(d*d+1):
            candidate = vectors + [flatten(current)]
            if eliminate(candidate, d*d)[1] == len(vectors):
                break
            vectors = candidate
            current = lyapunov(F, current)
        dimension = len(vectors)
        samples = [flatten(survival(F, Q(k))) for k in range(1, dimension+1)]
        assert eliminate(samples, d*d)[1] == dimension
        assert eliminate(samples+vectors, d*d)[1] == dimension
        dimensions.append(dimension)
    return dimensions


def check_boundary():
    F = [[Q(1, 2), Q(1)], [Q(-1), Q(0)]]
    m1, m2 = survival(F, Q(1)), survival(F, Q(2))
    assert m1 == [[Q(11, 18), Q(-1, 9)], [Q(-1, 9), Q(7, 9)]]
    assert m2 == [[Q(9, 25), Q(-1, 25)], [Q(-1, 25), Q(23, 50)]]
    inverse_m1 = inverse(m1)
    direction = subtract(multiply(m2, inverse_m1), multiply(inverse_m1, m2))
    assert direction == [[0, Q(-6, 625)], [Q(6, 625), 0]]
    return direction[0][1]


if __name__ == "__main__":
    print(f"{check_three_samples()} exact three-frequency commutant rank checks")
    print(f"Krylov dimensions for d=2,3,4: {check_krylov()}")
    print(f"boundary off-diagonal gauge coefficient: {check_boundary()}")
