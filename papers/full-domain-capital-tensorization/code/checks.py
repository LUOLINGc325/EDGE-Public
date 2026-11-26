"""Exact rational checks for rounded policies and the symmetric pair bound."""
from fractions import Fraction as Q
from functools import lru_cache
from itertools import product


def round_up(x, mesh):
    if x == 0:
        return Q(0)
    upper = Q(1)
    while upper < x:
        upper *= mesh
    while upper / mesh >= x:
        upper /= mesh
    return upper


def check_rounding():
    values = [Q(0)] + [Q(i, j) for i in range(1, 14) for j in range(1, 10)]
    stakes = [Q(k, 8) for k in range(9)]
    meshes = [Q(5, 4), Q(3, 2), Q(2)]
    count = 0
    for mesh, x, stake in product(meshes, values, stakes):
        rounded = round_up(x, mesh)
        assert x <= rounded <= mesh*x
        assert mesh*(1 + stake*(x-1)) >= 1 + stake*(rounded-1)
        count += 1
    return count


def best_expected_wealth(law):
    dimension = len(law[0][0])
    unread = None

    @lru_cache(maxsize=None)
    def continuation(history):
        legal_atoms = [(x, mass) for x, mass in law
                       if all(value is unread or value == x[index]
                              for index, value in enumerate(history))]
        if all(value is not unread for value in history):
            return Q(1)
        mass_now = sum(mass for _, mass in legal_atoms)
        best = Q(0)
        for index, value in enumerate(history):
            if value is not unread:
                continue
            subtotals = {}
            for atom, mass in legal_atoms:
                observed = atom[index]
                subtotals[observed] = subtotals.get(observed, 0) + mass
            bets = [Q(0), Q(0)]
            for observed, mass in subtotals.items():
                after = history[:index] + (observed,) + history[index+1:]
                expected = mass * continuation(after) / mass_now
                bets[0] += expected
                bets[1] += expected * observed
            best = max(best, *bets)
        return best

    return continuation((unread,) * dimension)


def check_interleaving():
    laws = [
        (((Q(0), Q(1)), Q(1, 3)), ((Q(1), Q(0)), Q(1, 3)), ((Q(3), Q(3)), Q(1, 3))),
        (((Q(1, 2), Q(4)), Q(3, 5)), ((Q(2), Q(0)), Q(2, 5))),
        (((Q(0), Q(3)), Q(1, 2)), ((Q(4), Q(1, 4)), Q(1, 2))),
    ]
    for left, right in product(laws, repeat=2):
        joined = tuple((x+y, px*py) for (x, px), (y, py) in product(left, right))
        assert best_expected_wealth(joined) == (
            best_expected_wealth(left) * best_expected_wealth(right)
        )
    return len(laws)**2


def check_pair_profiles():
    shifts = sorted({Q(i, 8) for i in range(-8, 49)} | {Q(40)})
    # The last profile is asymmetric in the shifted coordinate and is nonconvex.
    profiles = [
        lambda u: Q(1, 2) * abs(u),
        lambda u: 1 + u/2,
        lambda u: Q(1, 3) * max(Q(3, 4), abs(u)),
        lambda u: abs(u)/4 + min(Q(1), max(Q(0), Q(3, 2)-u))/8,
    ]
    count = 0
    for h in profiles:
        corner = h(Q(-1))
        capital = 1 + corner
        second = {u: max(Q(0), h(u)-corner) for u in shifts}
        for u, wager in second.items():
            assert 0 <= wager <= capital/2 + corner*u
        for u, v in product(shifts, repeat=2):
            target = 1 + v*h(u) + u*h(v)
            payoff = capital + corner*(u+v) + second[u]*v + second[v]*u
            assert target >= 0
            assert payoff >= target
            count += 1
    return count


if __name__ == "__main__":
    print(f"{check_rounding()} exact one-step mesh inequalities checked")
    print(f"{check_interleaving()} finite product laws checked by Bellman recursion")
    print(f"{check_pair_profiles()} exact two-input capital comparisons checked")
