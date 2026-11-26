"""Exact replica-matrix, reflection, and character-sum checks over odd labels."""

from itertools import product


def rank_mod(matrix, p):
    work = [list(row) for row in matrix]
    if not work:
        return 0
    rank = 0
    for col in range(len(work[0])):
        for pivot in range(rank, len(work)):
            if work[pivot][col] % p:
                break
        else:
            continue
        work[rank], work[pivot] = work[pivot], work[rank]
        reciprocal = pow(work[rank][col] % p, -1, p)
        for row in range(rank + 1, len(work)):
            ratio = work[row][col] * reciprocal % p
            if ratio:
                for j in range(col, len(work[0])):
                    work[row][j] = (work[row][j] - ratio * work[rank][j]) % p
        rank += 1
    return rank


def replica_matrices(d, n, parties, edges):
    q = max(parties) + 1
    replicas = list(product(range(n), repeat=q - 1))
    index = {replica: offset for offset, replica in enumerate(replicas)}
    number = len(replicas)
    dim = len(parties) * number
    shifts = [
        [index[tuple((value + (axis == party)) % n for axis, value in enumerate(replica))]
         for replica in replicas]
        for party in parties
    ]
    reflection = [
        vertex * number + index[tuple((-value + (axis == party)) % n
                                     for axis, value in enumerate(replica))]
        for vertex, party in enumerate(parties) for replica in replicas
    ]
    polar = [[0] * dim for _ in range(dim)]
    for left, right, weight in edges:
        for replica in range(number):
            ket = (left * number + replica, right * number + replica)
            bra = (left * number + shifts[left][replica], right * number + shifts[right][replica])
            for (row, col), sign in ((ket, 1), (bra, -1)):
                polar[row][col] = (polar[row][col] + sign * weight) % d
                polar[col][row] = polar[row][col]

    assert all(reflection[reflection[row]] == row for row in range(dim))
    assert all((polar[reflection[row]][reflection[col]] + polar[row][col]) % d == 0
               for row in range(dim) for col in range(dim))
    plus, minus = [], []
    for row, partner in enumerate(reflection):
        if row == partner:
            plus.append(((row, 1),))
        if row < partner:
            plus.append(((row, 1), (partner, 1)))
            minus.append(((row, 1), (partner, -1)))

    def bilinear(first, second):
        return sum(a * b * polar[i][j] for i, a in first for j, b in second) % d

    assert all(bilinear(first, second) == 0 for basis in (plus, minus)
               for first in basis for second in basis)
    cross = [[bilinear(first, second) for second in minus] for first in plus]
    return polar, cross, len(minus)


def direct_phase_counts(polar, d):
    dim = len(polar)
    terms = [(row, col, polar[row][col]) for row in range(dim)
             for col in range(row + 1, dim) if polar[row][col]]
    counts = [0] * d
    for labels in product(range(d), repeat=dim):
        phase = sum(weight * labels[row] * labels[col] for row, col, weight in terms) % d
        counts[phase] += 1
    return counts


def fourier_rank(p, n, parties, edges):
    roots = [label for label in range(1, p) if pow(label, n, p) == 1]
    assert len(roots) == n
    q = max(parties) + 1
    total = 0
    for free_colors in product(roots, repeat=q - 1):
        colors = (*free_colors, 1)
        dim = len(parties)
        symbol = [[0] * dim for _ in range(dim)]
        for left, right, weight in edges:
            value = weight * (colors[parties[left]] - colors[parties[right]]) % p
            symbol[left][right] = value
            symbol[right][left] = -value % p
        local_rank = rank_mod(symbol, p)
        assert local_rank % 2 == 0
        total += local_rank
    return total


def max_matching(support):
    if not support:
        return 0
    left, right = support[0]
    others = support[1:]
    rest = [edge for edge in others if left not in edge and right not in edge]
    return max(max_matching(others), 1 + max_matching(rest))


def collision_polynomial(n, parties, edges):
    q = max(parties) + 1
    total = 0

    def visit(labels):
        nonlocal total
        blocks = max(labels) + 1
        if len(labels) == q:
            multiplicity = 1
            for k in range(1, blocks):
                multiplicity *= n - k
            support = [(left, right) for left, right, weight in edges
                       if weight and labels[parties[left]] != labels[parties[right]]]
            total += multiplicity * max_matching(support)
            return
        for label in range(blocks + 1):
            visit((*labels, label))

    visit((0,))
    return total


def verify_prime(p, n, parties, edges, exhaust=False, matching=False):
    polar, cross, _ = replica_matrices(p, n, parties, edges)
    rank = rank_mod(polar, p)
    exponent = rank_mod(cross, p)
    assert rank == 2 * exponent
    checks = ["reflection", "polar rank"]
    if exhaust:
        counts = direct_phase_counts(polar, p)
        assert len(set(counts[1:])) == 1
        assert counts[0] - counts[1] == p**(len(polar) - exponent)
        checks.append("exact phase histogram")
    if (p - 1) % n == 0:
        assert rank == fourier_rank(p, n, parties, edges)
        checks.append("Fourier")
    if matching:
        assert exponent == collision_polynomial(n, parties, edges)
        checks.append("collision polynomial")
    print(f"p={p}, n={n}, parties={parties}, exponent={exponent}: " + ", ".join(checks))


def verify_composite():
    d = 9
    polar, cross, dim_minus = replica_matrices(d, 2, (0, 1), ((0, 1, 3),))
    kernel_size = sum(
        all(sum(coefficient * label for coefficient, label in zip(row, labels)) % d == 0
            for row in cross)
        for labels in product(range(d), repeat=dim_minus)
    )
    image_size = d**dim_minus // kernel_size
    histogram = direct_phase_counts(polar, d)
    # Phi_9(X)=X^6+X^3+1. Reduce the integral phase-count polynomial.
    for degree in range(8, 5, -1):
        coefficient = histogram[degree]
        histogram[degree - 3] -= coefficient
        histogram[degree - 6] -= coefficient
        histogram[degree] = 0
    assert image_size == 3 and histogram[0] * image_size == d**len(polar)
    assert not any(histogram[1:])
    print("d=9, n=2, nonunit weight 3: image index 3 and exact cyclotomic phase verified.")


if __name__ == "__main__":
    triangle = ((0, 1, 1), (1, 2, 2), (0, 2, 1))
    verify_prime(3, 2, (0, 1, 2), triangle, exhaust=True, matching=True)
    verify_prime(3, 3, (0, 1, 2), triangle)
    verify_prime(3, 6, (0, 1), ((0, 1, 1),), exhaust=True)
    verify_prime(5, 4, (0, 0, 1), triangle, matching=True)
    verify_prime(7, 3, (0, 1, 1, 2), ((0, 1, 1), (1, 2, 2), (2, 3, 3)), matching=True)
    verify_prime(5, 5, (0, 1), ((0, 1, 2),))
    verify_composite()
