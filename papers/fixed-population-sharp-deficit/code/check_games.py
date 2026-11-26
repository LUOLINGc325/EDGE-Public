"""Exact game certificates and high-precision geometric witnesses (Python 3, SciPy, mpmath)."""

import json
from fractions import Fraction

import mpmath as mp
from scipy.optimize import linprog

mp.mp.dps = 105


def payoff_value(matrix):
    """Use two LPs to find candidate strategies, then certify the value in rational arithmetic."""
    rows, cols = len(matrix), len(matrix[0])

    def strategy(payoffs):
        width = len(payoffs[0])
        sol = linprog([0] * width + [-1],
                      A_ub=[[-x for x in row] + [1] for row in payoffs],
                      b_ub=[0] * len(payoffs), A_eq=[[1] * width + [0]], b_eq=[1],
                      bounds=[(0, 1)] * (width + 1), method="highs")
        assert sol.success
        result = [Fraction(float(x)).limit_denominator(1000) for x in sol.x[:-1]]
        assert sum(result) == 1 and min(result) >= 0
        return result

    row_strategy = strategy(list(zip(*matrix)))
    col_strategy = strategy([[1 - x for x in row] for row in matrix])
    lower = min(sum(row_strategy[i] * matrix[i][j] for i in range(rows)) for j in range(cols))
    upper = max(sum(col_strategy[j] * row[j] for j in range(cols)) for row in matrix)
    assert lower == upper
    return lower


def antichains(prefix, candidates):
    if prefix:
        yield prefix
    for position, candidate in enumerate(candidates):
        other = [x for x in candidates[position + 1:]
                 if (x & candidate) not in (x, candidate)]
        yield from antichains(prefix + [candidate], other)


def spectrum(d):
    # Deleting a dominated row preserves the value. Duplicate columns allow games of smaller width.
    values, games = set(), 0
    for masks in antichains([], list(range(1 << d))):
        matrix = [[(row >> j) & 1 for j in range(d)] for row in masks]
        values.add(payoff_value(matrix))
        games += 1
    return {"dimension": d, "row_antichains": games, "values": [str(b) for b in sorted(values)]}


def balanced_convergent(digits):
    m = digits[-1]
    matrix = [[int(i == j) for j in range(m)] for i in range(m)]
    weights = [1] * m
    p, q = 1, m

    def extend(matrix, weights, p, q):
        return ([row + [0] for row in matrix] + [[0] * len(matrix) + [1]],
                weights + [p], p, p + q)

    for digit in reversed(digits[:-1]):
        matrix, weights, p, q = extend(matrix, weights, p, q)
        matrix = [[1 - x for x in row] for row in matrix]
        p = q - p
        for _ in range(digit - 1):
            matrix, weights, p, q = extend(matrix, weights, p, q)
    assert len(matrix) == sum(digits) and sum(weights) == q
    assert all(sum(x * z for x, z in zip(row, weights)) == p for row in matrix)
    assert matrix == list(map(list, zip(*matrix)))
    return matrix, weights, p, q


def witness(matrix, weights, p, q, tau):
    """Reconstruct actual Euclidean coordinates and costs at the two specified facilities."""
    dimension = len(matrix)
    b = mp.mpf(p) / q
    high = (tau - b) / (1 - b)
    m_b = high + (1 - high) * mp.sqrt(b)
    m_a = (1 - high) * mp.sqrt(1 - b)
    t = m_a / mp.sqrt(m_a**2 + m_b**2)
    r = mp.sqrt(b) + t * mp.sqrt(1 - b) / mp.sqrt(1 - t**2)
    f = [mp.sqrt(mp.mpf(z) / q) for z in weights]
    base_cost, reference_cost = high, mp.mpf(0)
    for row, z in zip(matrix, weights):
        x = [r * y * bit / mp.sqrt(b) for y, bit in zip(f, row)]
        mass = (1 - high) * z / q
        base_cost += mass * mp.norm(x)
        reference_cost += mass * mp.norm([x[j] - f[j] for j in range(dimension)])
    ideal = base_cost / reference_cost
    assert abs(ideal - 1 / t) < mp.mpf("1e-93")
    return ideal, base_cost, reference_cost


def rounded_profile(matrix, weights, p, q, n, base, reference):
    # Use exact integer arithmetic for all row frequencies and positive counts.
    bits = [1 - matrix[i][i] for i in range(len(matrix))]
    assert all(matrix[i][j] == bits[i] for i in range(len(matrix)) for j in range(i))
    denominator = 2 * (q - p)
    scaled = n - 16
    full = scaled * (q - 2 * p) // denominator
    cumulative = [0, 0]
    low = []
    for bit, z in zip(bits, weights):
        previous = cumulative[bit]
        cumulative[bit] += scaled * z
        low.append(cumulative[bit] // denominator - previous // denominator)
    filler = n - full - sum(low)
    counts = [full + sum(x * flag for x, flag in zip(low, col)) for col in zip(*matrix)]
    assert filler > 0 and 0 < max(counts) <= (n - 1) // 2
    discrepancy = max(abs(Fraction(k) - Fraction(scaled, 2)) for k in counts)
    assert discrepancy <= 5
    high_mass = mp.mpf(q - 2 * p) / denominator
    low_mass = 1 - high_mass
    actual_base = full + sum(low) * (base - high_mass) / low_mass
    actual_reference = filler + sum(low) * reference / low_mass
    return {"population": n, "max_column_discrepancy": str(discrepancy),
            "zero_fillers": filler, "ratio_to_reference": mp.nstr(actual_base / actual_reference, 16),
            "population_times_ideal_loss": mp.nstr(n * (base / reference - actual_base / actual_reference), 14)}


def main():
    c = mp.sqrt(6 * mp.sqrt(3) - 8)
    convergence = []
    for j in range(8):
        digits = [7] + [2, 6] * j
        matrix, weights, p, q = balanced_convergent(digits)
        ideal, base, reference = witness(matrix, weights, p, q, mp.mpf(1) / 2)
        n0 = 2 * (q - p)
        for col in zip(*matrix):
            assert sum(z * bit for z, bit in zip(weights, col)) + q - 2 * p == n0 // 2
        odd_ratio = n0 * base / (n0 * reference + 1)
        assert 1 < odd_ratio < ideal < c
        convergence.append({"dimension": len(matrix), "low_value": f"{p}/{q}",
                            "odd_population": n0 + 1, "ideal_gap": mp.nstr(c - ideal, 15),
                            "odd_population_gap": mp.nstr(c - odd_ratio, 15),
                            "population_times_gap": mp.nstr((n0 + 1) * (c - odd_ratio), 15),
                            "general_population_rounding": [
                                rounded_profile(matrix, weights, p, q, n, base, reference)
                                for n in (41, 101, 1009, 10007, 65537, 1000003)
                            ]})
    saturation = []
    for m in (3, 4, 7):
        matrix, weights, p, q = balanced_convergent([m * m])
        tau = 1 - mp.mpf(1) / m - mp.mpf(1) / (m * m)
        x = (mp.sqrt(5 - 4 * tau) - 1) / 2
        h = (tau + x) * mp.sqrt((1 - x) / (1 + x)) / (1 - tau)
        ideal, _, _ = witness(matrix, weights, p, q, tau)
        assert abs(ideal - mp.sqrt(1 + h * h)) < mp.mpf("1e-92")
        saturation.append({"m": m, "minimum_dimension": q, "ratio": mp.nstr(ideal, 15)})
    print(json.dumps({"spectra": [spectrum(d) for d in range(1, 5)],
                      "ordinary_median": convergence, "exact_dimension_family": saturation}, indent=2))


if __name__ == "__main__":
    main()
