"""Finite geometry checks for near-unit-error isolation and lower bounds."""

from fractions import Fraction as F
from itertools import combinations, product
import json
import random


def require(condition, details):
    if not condition:
        raise AssertionError(details)


def radius(prefix, query, rank):
    return sorted(abs(query-x) for x in prefix)[rank-1]


def verify_pattern(points, rank, selected, width):
    left = lambda x: x <= width
    right = lambda x: x >= 1-width
    warmup = points[:rank]
    chosen = set(selected)
    selected_left = sum(left(points[t]) for t in selected)
    selected_right = sum(right(points[t]) for t in selected)
    require(all(left(x) or right(x) for x in warmup), (points, selected, "warmup bands"))
    require(selected_left == sum(right(x) for x in warmup), (points, selected, "left count"))
    require(selected_right == sum(left(x) for x in warmup), (points, selected, "right count"))
    for t in range(rank, selected[-1]):
        if t not in chosen:
            require(radius(points[:t], points[t], rank) <= width, (points, selected, t))
    before_late = points[:selected[-1]+1]
    require(sum(left(x) for x in before_late) >= rank, (points, selected, "late left"))
    require(sum(right(x) for x in before_late) >= rank, (points, selected, "late right"))


def exhaustive_patterns():
    count = 0
    for rank in (1, 2, 3):
        for points in product((F(0), F(1, 2), F(1)), repeat=2*rank+2):
            eligible = [t for t in range(rank, len(points))
                        if radius(points[:t], points[t], rank) >= F(9, 10)]
            for selected in combinations(eligible, rank):
                verify_pattern(points, rank, selected, F(1, 10))
                count += 1
    return count


def constructed_patterns():
    rng = random.Random(712062)
    count = 0
    for rank in (1, 3, 5, 7, 9):
        for _ in range(100):
            width = F(1, 10)
            warmup = [F(rng.randrange(2)) for i in range(rank)]
            left_count = warmup.count(F(0))
            remaining = [F(0)]*(rank-left_count) + [F(1)]*left_count
            rng.shuffle(remaining)
            points = list(warmup)
            selected = []
            for next_query in remaining:
                if next_query == 0 and 1 not in remaining[len(selected):]:
                    points.append(1-width)
                if next_query == 1 and 0 not in remaining[len(selected):]:
                    points.append(width)
                selected.append(len(points))
                points.append(next_query)
            require(all(radius(points[:t], points[t], rank) >= 1-width for t in selected),
                    (points, selected, "eligibility"))
            verify_pattern(points, rank, selected, width)
            count += 1
    return count


def lower_bound_checks():
    certified = []
    for eta in range(6):
        k = 2*eta+1
        tiny = F(1, 24*k)
        delta = tiny**4
        a = 1-delta
        b = tiny**2/4
        require(a*a + 4*b*b < 1, ("q2 derivative energy", k))
        # At p=3/2, b^p=tiny^3/8 and (1-delta)^p>=1-p*delta.
        excess = tiny**3/8 - F(3, 2)*k*delta
        require(excess > 0, ("p3/2 lower bound", k))
        certified.append({"corruptions": eta, "q": 2, "p": "3/2", "strict_excess_lower_bound": str(excess)})
    for depth in (16, 64, 256):
        # q=depth/(depth-1), then H=1/2 exactly on a depth-D interval.
        q = F(depth, depth-1)
        k = 1
        bound = F(k, 4) + F(depth, 16)
        require(bound > k, ("ramp excess", depth))
        certified.append({"corruptions": 0, "q": str(q), "p": 2, "ramp_lower_bound": str(bound)})
    return certified


def main():
    print(json.dumps({
        "exhaustive_selected_patterns": exhaustive_patterns(),
        "constructed_margin_patterns": constructed_patterns(),
        "finite_q_lower_bound_checks": lower_bound_checks(),
    }, indent=2))


if __name__ == "__main__":
    main()
