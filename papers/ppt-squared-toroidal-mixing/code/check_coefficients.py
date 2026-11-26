"""Exact rational checks for the population certificate and SIC formulas."""

import json
from fractions import Fraction as F


def doc_example():
    u = F(6, 5)
    raw = [[F(1) for _ in range(4)] for _ in range(4)]
    raw[0][1], raw[1][0] = u, 1 / u
    column_sums = [sum(column) for column in zip(*raw)]
    population = [[raw[i][j] / column_sums[j] for j in range(4)] for i in range(4)]
    assert all(sum(col) == 1 for col in zip(*population))
    for i in range(4):
        for j in range(4):
            assert raw[i][j] * raw[j][i] >= 1
    reverse_cycle = raw[1][0] * raw[0][2] * raw[2][1]
    assert reverse_cycle < 1
    ratios = []
    for i in range(4):
        row = []
        for j in range(4):
            entry = sum(population[i][k] * population[k][j] for k in range(4))
            row.append(entry / (population[i][i] * population[j][j]))
        ratios.append(row)
    minimum = min(map(min, ratios))
    assert minimum == F(965, 252) and minimum < 4
    # minimum > 2 + 2 / sqrt(3), checked without square roots.
    assert minimum > 2 and 3 * (minimum - 2) ** 2 > 4
    assert minimum > F(7, 2)
    return {"column_sums": list(map(str, column_sums)),
            "population_ratios": [list(map(str, row)) for row in ratios],
            "minimum": str(minimum), "normalized_reverse_cycle": str(reverse_cycle)}


def sic_coefficient():
    # Integer s = sqrt(r + 1) lets us verify the coefficient formula exactly
    # without symbolic dependencies. The identity is proved for all r in the paper.
    for s in range(2, 52):
        r = s * s - 1
        mixing = 1 - F(1, (s + 1) ** 2)
        phase_product = F(s * s * r + 2 * s * (1 - s), r * r)
        support_gap = F((1 + (r - 1) * s) ** 2 - r * r, r * r * (r - 1))
        assert mixing == phase_product == support_gap
        h = F(1, s)
        denominator = 2 * h * (1 + h) ** 2
        for p in range(21):
            y = F(p, 20)
            t = y * y
            polynomial = (-t * t + (3*h*h + 2*h + 1)*t + h*h*(1 + 2*h))
            factor = (y-h)**2 * (1-y) * (y+1+2*h)
            assert polynomial - y * denominator == factor >= 0
    return {"exact_coefficient_identities": 50, "polynomial_grid_checks": 1050}


if __name__ == "__main__":
    print(json.dumps({"doc_example": doc_example(), "sic": sic_coefficient()}, indent=2))
