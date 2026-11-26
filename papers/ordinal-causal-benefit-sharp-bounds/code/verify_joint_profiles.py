"""Check exact ordinal-benefit profiles, their coupling, and the trial example.

Run with Python 3.10 or newer. All checks use nonnegative integer masses and
the standard library. A table is indexed first by treatment, then by control.
"""

from collections import defaultdict
from itertools import accumulate, product


def cumulative(values):
    return (0, *accumulate(values))


def single_bounds(treated, control, cuts, lower, upper):
    """Return the endpoint numerators from Theorem 1, or None if infeasible.

    A cut k labels the first k treated levels as below or at the threshold.
    All masses, lower/upper bounds, and the result use the same units.
    """
    n = sum(treated)
    assert n == sum(control)
    assert all(x >= 0 for x in (*treated, *control))
    assert len(control) == len(cuts) == len(lower) == len(upper)
    assert list(cuts) == sorted(cuts)
    assert all(0 <= x <= len(treated) for x in cuts)
    assert all(0 <= a <= b <= c for a, b, c in zip(lower, upper, control))
    row, col = cumulative(treated), cumulative(control)
    a_sum, b_sum = cumulative(lower), cumulative(upper)
    lo, hi = a_sum[-1], b_sum[-1]
    for j, cut in enumerate(cuts):
        need = col[j + 1] - row[cut]
        free = n - row[cut]
        if b_sum[j + 1] < need or a_sum[-1] - a_sum[j] > free:
            return None
        lo = max(lo, need + a_sum[-1] - a_sum[j + 1])
        hi = min(hi, free + b_sum[j])
    return (lo, hi) if lo <= hi else None


def profile(table):
    size = len(table)
    above = tuple(sum(table[i][j] for i in range(j + 1, size))
                  for j in range(size))
    weak = tuple(above[j] + table[j][j] for j in range(size))
    return above, weak


def margins(table):
    return tuple(map(sum, table)), tuple(map(sum, zip(*table)))


def admissible(treated, control, above, weak):
    """Evaluate the four sets of inequalities in Theorem 3."""
    n = sum(treated)
    assert n == sum(control)
    row, col = cumulative(treated), cumulative(control)
    strict, inclusive = cumulative(above), cumulative(weak)
    return all(
        0 <= above[j] <= weak[j] <= control[j]
        and weak[j] - above[j] <= treated[j]
        and strict[j] + weak[j] >= col[j + 1] - row[j]
        and above[j] + inclusive[-1] - inclusive[j + 1] <= n - row[j + 1]
        for j in range(len(control))
    )


def reconstruct(treated, control, above, weak):
    """Construct a full integer table from (5) by rank-interval overlaps."""
    if not admissible(treated, control, above, weak):
        raise ValueError("Infeasible joint profile")
    size = len(treated)
    tied = [v - u for u, v in zip(above, weak)]
    residual = cumulative([r - d for r, d in zip(treated, tied)])
    below = [c - v for c, v in zip(control, weak)]
    slots = [(j, below[j]) for j in range(size)]
    slots.extend((j, above[j]) for j in range(size))
    table = [[0] * size for _ in range(size)]
    for j, diagonal in enumerate(tied):
        table[j][j] = diagonal
    start = 0
    for j, length in slots:
        end = start + length
        for i in range(size):
            overlap = min(end, residual[i + 1]) - max(start, residual[i])
            table[i][j] += max(0, overlap)
        start = end
    assert start == residual[-1]
    assert margins(table) == (tuple(treated), tuple(control))
    assert profile(table) == (tuple(above), tuple(weak))
    return table


def compositions(total, parts):
    """Enumerate ordered weak compositions of an integer."""
    if parts == 1:
        yield (total,)
        return
    for first in range(total + 1):
        for rest in compositions(total - first, parts - 1):
            yield (first, *rest)


def exhaustive_check(size=3, total=6):
    """Independently project all integer joint tables on a finite grid."""
    observed = defaultdict(set)
    tables = 0
    for entries in compositions(total, size * size):
        table = [entries[i * size:(i + 1) * size] for i in range(size)]
        observed[margins(table)].add(profile(table))
        tables += 1

    candidates = 0
    accepted = 0
    for (treated, control), actual in observed.items():
        predicted = set()
        coordinates = [
            tuple((u, v) for v in range(c + 1) for u in range(v + 1))
            for c in control
        ]
        for pairs in product(*coordinates):
            above, weak = zip(*pairs)
            candidates += 1
            if admissible(treated, control, above, weak):
                predicted.add((above, weak))
                reconstruct(treated, control, above, weak)
        assert actual == predicted
        accepted += len(predicted)
    print(f"{size}x{size}, total {total}: {tables:,} integer tables, "
          f"{len(observed):,} margin pairs")
    print(f"{candidates:,} candidate joint profiles, {accepted:,} feasible")


def trial_check():
    tr_counts = (49, 13, 52, 43, 49, 27)
    co_counts = (59, 32, 81, 44, 35, 16)
    treated = tuple(x * sum(co_counts) for x in tr_counts)
    control = tuple(x * sum(tr_counts) for x in co_counts)
    n = sum(treated)
    strict_cuts = tuple(range(1, 7))
    weak_cuts = tuple(range(6))

    def lower_bands(cuts):
        return tuple(
            co_counts[j] * sum(tr_counts[cut:]) if j >= 3 else 0
            for j, cut in enumerate(cuts)
        )

    open_lower = lower_bands(strict_cuts)
    closed_lower = lower_bands(weak_cuts)
    strict_only = single_bounds(treated, control, strict_cuts, open_lower, control)
    closed_only = single_bounds(treated, control, weak_cuts, closed_lower, control)
    assert strict_only == (13927, 49128)
    assert closed_only == (31850, n)

    # Exact certificates under simultaneous open- and closed-tail DTD.
    # Each entry is the pair of strict and weak column masses.
    certificates = [
        ((4376, 3985, 1277, 3344, 945, 0),
         (13747, 7456, 15161, 10252, 8155, 432)),
        ((13747, 7456, 11481, 10252, 5760, 0),
         (13747, 7456, 11481, 10252, 5760, 432)),
        ((13747, 109, 4094, 3344, 2660, 0),
         (13747, 109, 9666, 5236, 2660, 432)),
        ((664, 4649, 4989, 3760, 945, 0),
         (13747, 7456, 18873, 10252, 8155, 3728)),
    ]
    for above, weak in certificates:
        assert all(u >= a for u, a in zip(above, open_lower))
        assert all(v >= a for v, a in zip(weak, closed_lower))
        reconstruct(treated, control, above, weak)

    strict_min = sum(certificates[0][0])
    strict_max = sum(certificates[1][0])
    weak_min = sum(certificates[2][1])
    weak_max = sum(certificates[3][1])
    assert strict_min == strict_only[0]
    assert strict_max == n - treated[0] - closed_lower[-1] == 48696
    assert (weak_min, weak_max) == closed_only
    print(f"Trial, denominator {n}: open-only strict {strict_only}; "
          f"both strict {(strict_min, strict_max)}; both weak {(weak_min, weak_max)}")


def strict_improvement_check():
    """Test the source implementation's three candidates and the sharp bound."""
    treated = (18, 12, 6)
    control = (12, 18, 6)
    total = 36
    # Closed-tail DTD on control levels 2 and 3.
    closed_lower = (0, 9, 1)
    open_lower = (0, 3, 0)
    row, col = cumulative(treated), cumulative(control)
    primary_candidates = tuple(
        total + col[j] - row[j] - treated[j]
        - (closed_lower[-1] if j < 2 else 0)
        for j in range(3)
    )
    assert primary_candidates == (17, 17, 30)
    table = ((4, 9, 5), (8, 4, 0), (0, 5, 1))
    above, weak = profile(table)
    assert margins(table) == (treated, control)
    assert all(x >= a for x, a in zip(above, open_lower))
    assert all(x >= a for x, a in zip(weak, closed_lower))
    forced_top = closed_lower[-1]
    forced_middle = closed_lower[1] - (treated[2] - forced_top)
    bound = total - treated[0] - forced_middle - forced_top
    assert sum(above) == bound == 13
    print(f"Three-level example: prior upper {min(primary_candidates)}/36, "
          f"sharp upper {bound}/36")


if __name__ == "__main__":
    exhaustive_check()
    exhaustive_check(size=4, total=4)
    strict_improvement_check()
    trial_check()
