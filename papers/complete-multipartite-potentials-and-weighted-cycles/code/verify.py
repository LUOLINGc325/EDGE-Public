"""Reproduce exact potential comparisons and complete bipartite witnesses."""
from fractions import Fraction as F
from itertools import combinations


def colorings(counts):
    if sum(counts) == 0:
        yield ()
        return
    for color, count in enumerate(counts):
        if count > 0:
            residual = counts[:color] + (count - 1,) + counts[color + 1:]
            for suffix in colorings(residual):
                yield (color,) + suffix


def utility(state, parts, place, color, weight):
    visible = {a for a, p in zip(state, parts) if p != parts[place] and a and a != color}
    return sum(weight[a] for a in visible)


def exclusive(state, parts, weight):
    result = [0] * (max(parts) + 1)
    for color in range(1, len(weight)):
        present = {part for part, a in zip(parts, state) if a == color}
        assert present
        if len(present) == 1:
            result[present.pop()] += weight[color]
    return result


def change(state, source, target):
    result = list(state)
    assert result[source] > 0 and result[target] == 0
    result[target], result[source] = result[source], 0
    return tuple(result)


def potential(state, parts, exclusive_values):
    return tuple(sorted(exclusive_values[p] for p, a in zip(parts, state) if not a))


def exhaustive():
    total = improving_unit = improving_shared = 0
    cases = (
        ((2, 2), (1, 1, 1, 1)),
        ((3, 3), (2, 2, 1, 1)),
        ((2, 2, 2), (2, 2, 1, 1)),
        ((1, 2, 3), (3, 1, 1, 1)),
        ((2, 2, 2, 2), (2, 2, 2, 1, 1)),
        ((3, 2, 2, 1), (3, 2, 1, 1, 1)),
    )
    for sizes, counts in cases:
        parts = tuple(p for p, size in enumerate(sizes) for _ in range(size))
        for state in colorings(counts):
            for weighted in (False, True):
                weight = (0,) + tuple(F(6 + (3 * a) % 7, 7) if weighted else 1 for a in range(1, len(counts)))
                e = exclusive(state, parts, weight)
                for source, a in enumerate(state):
                    if a == 0:
                        continue
                    for target, empty in enumerate(state):
                        if empty:
                            continue
                        total += 1
                        after = change(state, source, target)
                        i, j = parts[source], parts[target]
                        before_u = utility(state, parts, source, a, weight)
                        after_u = utility(after, parts, target, a, weight)
                        alone = all(occupant != a or p == i for p, occupant in zip(parts, state))
                        formula = i != j and e[i] - weight[a] * alone > e[j]
                        assert formula == (after_u > before_u)
                        if not formula:
                            continue
                        f = exclusive(after, parts, weight)
                        old, new = potential(state, parts, e), potential(after, parts, f)
                        assert new > old
                        if weighted:
                            improving_shared += 1
                        else:
                            improving_unit += 1
                            if counts[0] == 2:
                                old_parts = {p for p, x in zip(parts, state) if not x}
                                new_parts = {p for p, x in zip(parts, after) if not x}
                                assert 2 * sum(new) + (len(new_parts) == 1) > 2 * sum(old) + (len(old_parts) == 1)
    print(f'{total} direct jump checks, {improving_unit} unit and {improving_shared} shared-weight improvements.')


def play(state, parts, color, side, weight):
    source = next(i for i, a in enumerate(state) if a == color and parts[i] == side)
    target = next(i for i, a in enumerate(state) if not a and parts[i] != side)
    after = change(state, source, target)
    assert utility(after, parts, target, color, weight) > utility(state, parts, source, color, weight)
    return after


def bipartite_witnesses():
    for holes in range(1, 9):
        state = (1,) + (2,) * (holes + 2) + (0,) * holes
        parts = (0,) * (holes + 2) + (1,) * (holes + 1)
        for _ in range(holes):
            state = play(state, parts, 2, 0, (0, 1, 1))
        assert all(color for color, p in zip(state, parts) if p == 1)

    for k in range(3, 11):
        left = tuple(range(1, k + 1))
        right = tuple(range(2, k + 1)) + (0,)
        state = left + right
        parts = (0,) * k + (1,) * k
        weights = (0, 1, F(101, 100)) + (1,) * (k - 2)
        for color in range(2, k + 1):
            state = play(state, parts, color, color % 2, weights)

    lengths = []
    for singles, heavy in ((2, 1), (4, 3), (6, 5), (8, 7)):
        differences = tuple(range(singles + 1, 0, -1))
        singleton_weight = tuple(F(a + b, 2) for a, b in zip(differences, differences[1:]))
        total = differences[0] + differences[-1]
        fixed = singles + 1
        heavies = tuple(range(fixed + 1, fixed + 1 + heavy))
        weight = (0,) + singleton_weight + (F(total, 2),) + (total,) * heavy
        left = tuple(range(1, singles + 1, 2)) + (fixed, fixed) + heavies
        right = tuple(range(2, singles + 1, 2)) + heavies + (0,)
        parts = (0,) * len(left) + (1,) * len(right)
        state = left + right
        for phase in range(heavy + 1):
            for singleton in range(1, singles + 1):
                side = (phase + singleton - 1) % 2
                state = play(state, parts, singleton, side, weight)
                e = exclusive(state, parts, weight)
                assert abs(e[0] - e[1]) == differences[singleton]
            if phase < heavy:
                state = play(state, parts, heavies[phase], phase % 2, weight)
                e = exclusive(state, parts, weight)
                assert abs(e[0] - e[1]) == differences[0]
        lengths.append((heavy + 1) * singles + heavy)
    print(f'Equal-weight sharp paths H=1..8; one-weight perturbation K=3..10; quadratic witness lengths {lengths}.')


def personal_weight_cycle():
    trajectory = ((0, 3), (2, 0), (1, 2), (3, 1), (0, 3), (2, 0))
    swap = (1, 0, 3, 2)
    twice = trajectory + tuple((swap[a], swap[b]) for a, b in trajectory)
    for holes in range(1, 7):
        initial = (1, 2, 3) + (0,) * holes
        parts = (0, 0) + (1,) * (holes + 1)
        state = initial
        for source, target in twice:
            color = state[source]
            old = {a for a, p in zip(state, parts) if p != parts[source] and a}
            after = change(state, source, target)
            new = {a for a, p in zip(after, parts) if p != parts[target] and a}
            assert old == {(color + 1) % 3 + 1}
            assert new == {color % 3 + 1}
            state = after
        assert state == initial
    print('Labelled 12-move individual-weight cycles checked for H=1..6, all epsilon > 0 via neighbor identities.')


if __name__ == '__main__':
    exhaustive()
    bipartite_witnesses()
    personal_weight_cycle()
