from bisect import bisect_left, bisect_right
from collections import Counter
from functools import lru_cache
from itertools import combinations_with_replacement, permutations


def raw_schedule(deadlines):
    n = len(deadlines)

    @lru_cache(None)
    def search(visits, previous):
        slot = sum(visits) + 1
        if slot > 2 * n:
            return True
        if any(count < 2 and slot - last > due
               for count, last, due in zip(visits, previous, deadlines)):
            return False
        for i, count in enumerate(visits):
            if count < 2:
                nxt_visits = visits[:i] + (count + 1,) + visits[i + 1:]
                nxt_previous = previous[:i] + (slot,) + previous[i + 1:]
                if search(nxt_visits, nxt_previous):
                    return True
        return False

    return search((0,) * n, (0,) * n)


def fixed_point(deadlines):
    n = len(deadlines)
    primary = list(deadlines)
    for i in range(n - 2, -1, -1):
        primary[i] = min(primary[i], primary[i + 1] - 1)
    if primary[0] < 1:
        return False
    secondary = sorted(set(range(1, 2 * n + 1)) - set(primary))
    ordinary, m = Counter(deadlines).most_common(1)[0]
    exceptions = [due for due in deadlines if due != ordinary]
    r = len(exceptions)
    for a_order in permutations(range(r)):
        a_pos = {i: j for j, i in enumerate(a_order)}
        for t_order in permutations(range(r)):
            t_pos = {i: j for j, i in enumerate(t_order)}
            x, y = [0] * r, [0] * r
            while True:
                old = (x.copy(), y.copy())
                for i in range(r):
                    target = secondary[y[i] + t_pos[i]] - exceptions[i]
                    x[i] = max(x[i], bisect_left(primary, target) - a_pos[i])
                limit = bisect_right(primary, ordinary)
                rejected = False
                for j in range(1, m + 1):
                    if limit < j:
                        rejected = True
                        break
                    for i in a_order[limit - j:]:
                        x[i] = max(x[i], j)
                for left, right in zip(a_order, a_order[1:]):
                    x[right] = max(x[right], x[left])
                if rejected or any(x[i] > m or primary[x[i] + a_pos[i]] > exceptions[i]
                                   for i in range(r)):
                    break
                for j in range(1, m + 1):
                    location = primary[j - 1 + sum(value < j for value in x)]
                    limit = bisect_right(secondary, location + ordinary) - j
                    if limit < 0:
                        rejected = True
                        break
                    for i in t_order[limit:]:
                        y[i] = max(y[i], j)
                for left, right in zip(t_order, t_order[1:]):
                    y[right] = max(y[right], y[left])
                if rejected or any(value > m for value in y):
                    break
                if old == (x, y):
                    return True
    return False


count = 0
for n in range(1, 5):
    for deadlines in combinations_with_replacement(range(1, 2 * n + 1), n):
        assert fixed_point(deadlines) == raw_schedule(deadlines), deadlines
        count += 1
impossible = (2, 3, 4, 5, 7, 8)
assert not fixed_point(impossible) and not raw_schedule(impossible)
print(f"PASS: {count} multisets plus the six-task counterexample")
