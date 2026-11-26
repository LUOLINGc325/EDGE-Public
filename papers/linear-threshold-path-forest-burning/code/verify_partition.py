#!/usr/bin/env python3
"""Independently check the returned partitions and interval covers."""

from itertools import chain
from json import dumps
from math import isqrt
from random import Random

from odd_partition import exact_odd_partition, legal_sources, planned_centers


def verify_square(lengths):
    parts = exact_odd_partition(lengths)
    assert list(map(sum, parts)) == lengths
    largest = 2 * isqrt(sum(lengths))
    assert sorted(chain.from_iterable(parts)) == list(range(1, largest, 2))


def verify_cover(lengths):
    centers = planned_centers(lengths)
    rounds = isqrt(sum(lengths) - 1) + 1
    assert len(centers) == rounds
    intervals = [[] for _ in lengths]
    for time, (path, center) in enumerate(centers, 1):
        assert 0 <= center < lengths[path]
        radius = rounds - time
        intervals[path].append((max(0, center - radius), min(lengths[path] - 1, center + radius)))
    for length, local in zip(lengths, intervals):
        end = -1
        for start, stop in sorted(local):
            assert start <= end + 1
            end = max(end, stop)
        assert end == length - 1


def verify_legal(lengths):
    rounds = isqrt(sum(lengths) - 1) + 1
    sources = legal_sources(lengths)
    assert rounds - 1 <= len(sources) <= rounds
    times = [[] for _ in lengths]
    for time, (path, center) in enumerate(sources, 1):
        assert 0 <= center < lengths[path]
        assert all(abs(center - old) > time - earlier for earlier, old in times[path])
        times[path].append((time, center))
    for length, local in zip(lengths, times):
        assert all(any(abs(vertex - center) <= rounds - time for time, center in local)
                   for vertex in range(length))


def square_lengths(n, m, random):
    minimum = 100 * n
    excess = m * m - minimum * n
    cuts = [0] + sorted(random.randrange(excess + 1) for _ in range(n - 1)) + [excess]
    result = [minimum + hi - lo for lo, hi in zip(cuts, cuts[1:])]
    random.shuffle(result)
    return result


def run_trials():
    random = Random(20261125)
    square = 0
    nonsquare = 0
    legalized = 0
    for n in (2, 3, 4, 7, 8, 15, 16, 31, 64, 129, 257):
        for m in (10 * n, 10 * n + 1, 10 * n + 3, 11 * n, 12 * n + 1, 30 * n + 1):
            for _ in range(3):
                v = square_lengths(n, m, random)
                verify_square(v)
                square += 1
                if n <= 7 and m <= 12 * n:
                    verify_legal(v)
                    legalized += 1
                candidates = [i for i, length in enumerate(v) if length > 100 * n]
                if candidates:
                    v[random.choice(candidates)] -= 1
                    verify_cover(v)
                    nonsquare += 1
                    if n <= 7 and m <= 12 * n:
                        verify_legal(v)
                        legalized += 1
    for n in (2, 10, 11, 50):
        v = [100 * n] * n
        v[0] += n + 1
        v[-1] += 18 * n
        verify_cover(v)
        nonsquare += 1
    verify_square([49])
    verify_cover([23])
    verify_legal([23])
    return {"seed": 20261125, "square_partitions": square + 1,
            "nonsquare_covers": nonsquare + 1, "legal_ignition_sequences": legalized + 1,
            "largest_number_of_paths": 257}


if __name__ == "__main__":
    print(dumps(run_trials(), indent=2))
