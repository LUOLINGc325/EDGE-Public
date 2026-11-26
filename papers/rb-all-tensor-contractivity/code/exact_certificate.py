"""Check the full Clifford twirls of three qubit channels with exact arithmetic."""
from collections import defaultdict
from fractions import Fraction as Q
from itertools import permutations, product
from math import prod


def clifford_actions():
    for perm in permutations(range(3)):
        inversions = sum(perm[i] > perm[j] for i in range(3) for j in range(i + 1, 3))
        for signs in product((-1, 1), repeat=3):
            if prod(signs) == (-1) ** inversions:
                yield perm, signs


def check_design_gram(actions):
    # R maps e_i to signs[i] * e_perm[i]. Check the average of every
    # R^T E_{ab} R against (delta_ab / 3) I.
    for a, b, i, j in product(range(3), repeat=4):
        total = sum(
            signs[i] * signs[j]
            for perm, signs in actions
            if perm[i] == a and perm[j] == b
        )
        assert Q(total, len(actions)) == Q(int(a == b and i == j), 3)


def twirled_column(actions, diagonal, shift, incoming):
    entries = defaultdict(Q)
    for perm, signs in actions:
        columns = []
        for j in incoming:
            if j:
                columns.append([(j, diagonal[perm[j - 1]])])
            else:
                possible = [(0, Q(1))]
                possible.extend(
                    (i + 1, signs[i] * shift[perm[i]])
                    for i in range(3)
                    if shift[perm[i]]
                )
                columns.append(possible)
        for row in product(*columns):
            output = tuple(index for index, _ in row)
            entries[output] += prod(value for _, value in row)
    return {index: value / len(actions) for index, value in entries.items() if value}


def check_channel(actions, label, diagonal, shift, expected_p, expected_u):
    p = sum(diagonal) / 3
    u = sum(value ** 2 for value in diagonal) / 3
    assert (p, u) == (expected_p, expected_u)
    for n in (2, 3, 4):
        eigenvalues = []
        for incoming in product(range(4), repeat=n):
            column = twirled_column(actions, diagonal, shift, incoming)
            # Our three choices have diagonal traceless blocks under each action.
            # The actual full twirl is triangular in the trace-adapted basis.
            assert all(
                all(source == 0 or source == target for source, target in zip(incoming, outgoing))
                for outgoing in column
            )
            coefficient = column.get(incoming, Q(0))
            nonzero = tuple(index for index in incoming if index)
            if len(nonzero) == 0:
                assert coefficient == 1
            elif len(nonzero) == 1:
                assert coefficient == p
            elif len(nonzero) == 2 and nonzero[0] == nonzero[1]:
                assert coefficient == u
            if nonzero:
                eigenvalues.append(coefficient)
        assert len(eigenvalues) == 4 ** n - 1
        radius = max(map(abs, eigenvalues))
        assert radius == max(abs(p), u)
        print(f"{label} n={n}: p={p}, u={u}, remaining radius={radius}")


def main():
    actions = list(clifford_actions())
    assert len(actions) == 24
    check_design_gram(actions)
    check_channel(
        actions, "amplitude damping", (Q(3, 5), Q(3, 5), Q(9, 25)),
        (Q(0), Q(0), Q(16, 25)), Q(13, 25), Q(177, 625),
    )
    check_channel(
        actions, "phase flip", (Q(-1, 2), Q(-1, 2), Q(1)),
        (Q(0), Q(0), Q(0)), Q(0), Q(1, 2),
    )
    check_channel(
        actions, "unitary boundary", (Q(-1), Q(-1), Q(1)),
        (Q(0), Q(0), Q(0)), Q(-1, 3), Q(1),
    )
    print("ALL_CHECKS_OK")


if __name__ == "__main__":
    main()
