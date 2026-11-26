"""Independent finite exact checks of the author's Poisson-coupling candidate.

These checks are supplementary, not a proof of the universal theorem.
The state is the set of unassigned rows. Self-loop events are removed by
conditioning on the first effective proposal. Every retained transition
assigns at least one row, so the recursion is finite and exact.
"""
from fractions import Fraction as F
from functools import lru_cache
import json
import random
from pathlib import Path


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def verify(P):
    n, m = len(P), len(P[0])
    require(all(len(row) == m and sum(row) == 1 and min(row) >= 0 for row in P), 'bad channel')
    H = [F(0)]
    for j in range(1, n + 1):
        H.append(H[-1] + F(1, j))
    events = []
    profile = [F(0)] * m
    maxcol = [max(P[i][y] for i in range(n)) for y in range(m)]
    for y in range(m):
        levels = sorted(set([F(0)] + [P[i][y] for i in range(n)]))
        for lo, hi in zip(levels, levels[1:]):
            mask = sum(1 << i for i in range(n) if P[i][y] >= hi)
            rate = hi - lo
            require(mask and rate > 0, 'zero event')
            events.append((y, mask, rate))
            profile[y] += rate * H[mask.bit_count()]

    @lru_cache(None)
    def law(U):
        if not U:
            return (tuple([F(0)] * m), tuple([F(0)] * m), tuple([F(0)] * (n*m)))
        active = [(y, S & U, a) for y, S, a in events if S & U]
        total = sum(a for _, _, a in active)
        require(total > 0, 'stuck')
        used, count, marginal = [F(0)] * m, [F(0)] * m, [F(0)] * (n*m)
        for y, S, a in active:
            q = a / total
            child_used, child_count, child_marginal = law(U ^ S)
            for z in range(m):
                used[z] += q * (1 if z == y else child_used[z])
                count[z] += q * ((1 if z == y else 0) + child_count[z])
            for i in range(n):
                for z in range(m):
                    marginal[i*m+z] += q * ((1 if z == y else 0) if S & (1<<i) else child_marginal[i*m+z])
        return tuple(used), tuple(count), tuple(marginal)

    used, count, marginal = law((1<<n)-1)
    for i in range(n):
        for y in range(m):
            require(marginal[i*m+y] == P[i][y], 'wrong marginal')
    for y in range(m):
        require(maxcol[y] <= used[y] <= min(F(1), profile[y]), 'profile violation')
        require(used[y] <= count[y] <= profile[y], 'useful-count violation')
    T = sum(maxcol)
    require(sum(used) <= H[n] * T, 'global harmonic violation')
    return {'n': n, 'm': m, 'T': str(T), 'coupling_cost': str(sum(used)),
            'profile_bound': str(sum(min(F(1), x) for x in profile)),
            'states': law.cache_info().currsize}


def main():
    rng = random.Random(275109)
    cases = []
    for n in range(1, 7):
        for m in range(1, 7):
            for rep in range(6):
                raw = [[rng.randrange(7) for _ in range(m)] for _ in range(n)]
                for i in range(n):
                    if not any(raw[i]):
                        raw[i][rng.randrange(m)] = 1
                P = [[F(x, sum(row)) for x in row] for row in raw]
                cases.append(verify(P))
    for n in range(1, 9):
        cases.append(verify([[F(1)] for _ in range(n)]))
        cases.append(verify([[F(int(i == y)) for y in range(n)] for i in range(n)]))
        if n >= 3:
            cases.append(verify([[F(int(y in {i, (i-1)%n}), 2) for y in range(n)] for i in range(n)]))
    report = {'arithmetic': 'fractions.Fraction',
              'finite_checks_only': True, 'channels': len(cases), 'seed': 275109,
              'failed_checks': 0, 'rows': cases}
    results = Path(__file__).resolve().parents[1] / 'results'
    results.mkdir(exist_ok=True)
    (results / 'PPP_PROFILE_CHECKS.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({k: v for k, v in report.items() if k != 'rows'}))


if __name__ == '__main__':
    main()
