"""Integer orbit checks for the three-coordinate arithmetic-prefix frontier."""

from itertools import combinations_with_replacement, permutations, product
from math import factorial
import json


def require(condition, context):
    if not condition:
        raise RuntimeError(str(context))


def base(point, unit):
    running = 0
    for n, x in enumerate(point, start=1):
        running += x
        if running >= n*unit:
            return True
    return False


def a_test(x, y, z, unit):
    return y >= unit and x+2*y >= 3*unit and x+y+z >= 2*unit


def b_test(x, y, z, unit):
    return z >= unit and x+z >= 2*unit and 2*y+z >= 3*unit


def b_prime_test(x, y, z, unit):
    return (z >= unit and x+z >= 2*unit and 2*x+z >= 3*unit
            and 2*(x+y+z) >= 5*unit)


def covered(point, unit, option):
    if base(point, unit):
        return True
    if len(point) < 3:
        return False
    first, second, third = point[:3]
    test = b_test if option == "B" else b_prime_test
    return a_test(first, second, third, unit) or test(first, second, third, unit)


def qualifies(point, unit):
    x, y, z = point
    if y >= unit and z >= unit:
        return 2*(x+y+z) >= 5*unit and x+2*max(y, z) >= 3*unit
    if y >= unit:
        return x+2*y >= 3*unit and y+2*max(x, z) >= 2*unit
    if z >= unit:
        return x+2*z >= 3*unit and z+2*max(x, y) >= 3*unit
    return False


def orthant_orbit(point, orbit, unit):
    return sum(base(p, unit) or all(x >= y for x, y in zip(p, point))
               for p in permutations(orbit))


def negative_witness(point, unit):
    x, y, z = point
    if y >= unit and z >= unit:
        return point if 2*sum(point) < 5*unit else (x, max(y, z), max(y, z))
    if y >= unit:
        bottom = max(x, z)
        return (x, y, y) if x+2*y < 3*unit else (bottom, y, bottom)
    if z >= unit:
        bottom = max(x, y)
        return (x, z, z) if x+2*z < 3*unit else (bottom, bottom, max(z, 2*unit-bottom))
    return (max(point),)*3


def verify_frontier():
    unit = 10
    grid = tuple(range(0, 2*unit+1, 2))
    orbits = [(tuple(permutations(o)), 2*sum(o))
              for o in combinations_with_replacement(grid, 3) if sum(o) < 3*unit]
    positives = negatives = comparisons = 0
    for point in product(grid, repeat=3):
        if base(point, unit):
            continue
        if not qualifies(point, unit):
            lift = negative_witness(point, unit)
            require(unit*orthant_orbit(point, lift, unit) > 2*sum(lift),
                    (point, lift, "exact negative certificate"))
            negatives += 1
            continue
        for permutations_of_orbit, capacity in orbits:
            count = sum(base(p, unit) or all(x >= y for x, y in zip(p, point))
                        for p in permutations_of_orbit)
            require(unit*count <= capacity, (point, permutations_of_orbit))
            comparisons += 1
        positives += 1
    return {"positive_points": positives, "negative_lift_certificates": negatives,
            "principal_orbit_comparisons": comparisons}


def verify_extensions():
    unit = 20
    values = (0, 5, 11, 16, 20, 27, 30, 40)
    per_length = {}
    for n in range(1, 7):
        tested = 0
        for orbit in combinations_with_replacement(values, n):
            if sum(orbit) >= n*unit:
                continue
            permutations_of_orbit = tuple(permutations(orbit))
            for option in ("B", "Bprime"):
                reject_count = sum(covered(p, unit, option) for p in permutations_of_orbit)
                require(n*unit*reject_count <= factorial(n)*sum(orbit), (n, orbit, option))
            tested += 1
        per_length[str(n)] = tested
    conflict = tuple(permutations((11, 16, 30)))
    counts = [sum(base(p, unit) for p in conflict),
              sum(covered(p, unit, "B") for p in conflict),
              sum(covered(p, unit, "Bprime") for p in conflict),
              sum(covered(p, unit, "B") or covered(p, unit, "Bprime") for p in conflict)]
    require(counts == [4, 5, 5, 6] and 6*unit > 2*(11+16+30), counts)
    return {"nontrivial_orbits_per_length": per_length, "conflict_counts": counts}



from collections import Counter, defaultdict
from fractions import Fraction as Q
from math import prod


def verify_actual_obstruction():
    mixture = ((0,12,18,2),(0,15,21,11),(0,17,19,1),(1,9,23,11),(2,7,22,11),(3,14,19,4),(3,16,17,7),(4,8,20,11),(5,10,19,4),(5,11,19,2),(5,13,18,2),(5,14,17,3),(6,9,18,7),(6,14,16,4),(11,12,13,9))
    total = sum(n for _, _, _, n in mixture)
    count = [sum(covered(p, 12, "B") or covered(p, 12, "Bprime")
                 for p in permutations((a, b, c))) for a, b, c, _ in mixture]
    numerator = sum(n*k for (_, _, _, n), k in zip(mixture, count))
    cdf = [sum(n*sum(a > 0 and 24-a <= j for a in (x, y, z))
               for x, y, z, n in mixture) for j in range(24)]
    require(cdf == [11*j - (7 if j == 14 else 0) for j in range(24)],
            "exact marginal cdf")
    require(count == [5]+[6]*14 and total == 89, "exact rejection counts")
    probability = Q(numerator, 6*352)
    require(probability == Q(133, 528) > Q(1, 4), "invalid union")
    return {"marginal_numerators": cdf, "orbit_counts": count,
            "union_rejection_probability": str(probability)}


def orbit_mass(orbit, grid_size):
    k = len(orbit)
    multiplicity = prod(factorial(v) for v in Counter(orbit).values())
    return Q(factorial(k)//multiplicity, grid_size**k)


def marginal(table, dimension, inactive):
    mass = defaultdict(Q)
    for orbit, weight in table.items():
        for u in orbit:
            if u != inactive:
                mass[u] += weight/dimension
    return mass


def verify_rounding_repair():
    cases = 0
    for k in range(2, 6):
        fine = 11
        original = {orbit: orbit_mass(orbit, fine)
                    for orbit in combinations_with_replacement(range(1, fine+1), k)
                    if orbit[0] != fine}
        for m in range(2, 8):
            rounded = defaultdict(Q)
            for orbit, weight in original.items():
                rounded[tuple(value*m//fine for value in orbit)] += weight
            mu = marginal(rounded, k, m)
            remaining = Q(1, m)
            mark = {}
            for u, mass in sorted(mu.items()):
                take = min(mass, remaining)
                mark[u] = take/mass
                remaining -= take
            retained = {orbit: weight*prod(1-mark.get(u, 0) for u in orbit)
                        for orbit, weight in rounded.items()}
            after = marginal(retained, k, m)
            for j in range(m):
                require(sum(v for u, v in mu.items() if u <= j) <= Q(j+1,m),
                        (k, m, j, "rounded marginal"))
                require(sum(v for u, v in after.items() if u <= j) <= Q(j,m),
                        (k, m, j, "repaired marginal"))
            require(sum(rounded.values())-sum(retained.values()) <= Q(k,m),
                    (k, m, "mass repair"))
            cases += 1
    return cases


def verify_large_length_conflicts():
    witnesses = []
    for k in range(3, 8):
        n = k-1
        orbit = (0,n+1) + (n,)*(n-1)
        orbit_list = tuple(permutations(orbit))
        def special(point, coordinate):
            return min(point[1:]) >= n and point[coordinate] >= n+1
        first = sum(base(p,n) or special(p,1) for p in orbit_list)
        both = sum(base(p,n) or special(p,1) or special(p,2) for p in orbit_list)
        budget = Q(sum(orbit), k*n)
        require(Q(first,factorial(k)) == budget < Q(both,factorial(k)),
                (k, "all-length nonexistence witness"))
        witnesses.append(k)
    return witnesses


print(json.dumps({"frontier": verify_frontier(),
                  "finite_length_augmentations": verify_extensions(),
                  "actual_null_obstruction": verify_actual_obstruction(),
                  "rounding_repair_cases": verify_rounding_repair(),
                  "all_length_conflict_examples": verify_large_length_conflicts()}, indent=2))
