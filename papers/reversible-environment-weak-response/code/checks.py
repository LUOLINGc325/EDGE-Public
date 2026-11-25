"""Exact quadratic-response and positive-vector certificates."""
from fractions import Fraction as Q


def matvec(matrix, vector):
    return [sum(a*b for a, b in zip(row, vector)) for row in matrix]


def mean(vector, probability):
    return sum(x*p for x, p in zip(vector, probability))


def multiply(left, right):
    return [[sum(a*b for a, b in zip(row, column)) for column in zip(*right)]
            for row in left]


def solve(matrix, rhs):
    size = len(rhs)
    rows = [[Q(value) for value in row] + [Q(target)]
            for row, target in zip(matrix, rhs)]
    for j in range(size):
        pivot = next(i for i in range(j, size) if rows[i][j])
        rows[j], rows[pivot] = rows[pivot], rows[j]
        normalizer = rows[j][j]
        rows[j] = [value/normalizer for value in rows[j]]
        for i in range(size):
            if i == j:
                continue
            weight = rows[i][j]
            rows[i] = [value-weight*pivot_value for value, pivot_value in zip(rows[i], rows[j])]
    return [row[-1] for row in rows]


def poisson(generator, probability, rhs):
    assert mean(rhs, probability) == 0
    vector = solve(generator[:-1] + [probability], rhs[:-1] + [Q(0)])
    assert matvec(generator, vector) == rhs
    assert mean(vector, probability) == 0
    return vector


def positive_trial(generator, probability, potential, epsilon, comparison):
    first = poisson(generator, probability, [-value for value in potential])
    product = [value*entry for value, entry in zip(potential, first)]
    coefficient = mean(product, probability)
    second = poisson(generator, probability, [coefficient-entry for entry in product])
    test = [1+epsilon*x+epsilon**2*y for x, y in zip(first, second)]
    assert min(test) > 0
    residuals = [
        (entry + epsilon*value*x - comparison*x) / epsilon**2
        for entry, value, x in zip(matvec(generator, test), potential, test)
    ]
    return coefficient, min(residuals), max(residuals)


def main():
    spatial = [[-9, 9, 0], [0, -1, 1], [1, 0, -1]]
    stationary = [Q(1, 19), Q(9, 19), Q(9, 19)]
    assert matvec(list(zip(*spatial)), stationary) == [0, 0, 0]
    negative = [[-x for x in row] for row in spatial]
    vector = [0, 1, -1]
    potential = matvec(multiply(negative, negative), vector)
    assert potential == [-99, 3, 8] and mean(potential, stationary) == 0
    assert mean([x*y for x, y in zip(potential, vector)], stationary) == Q(-45, 19)
    adjoint = [[Q(negative[j][i])*stationary[j]/stationary[i] for j in range(3)] for i in range(3)]
    symmetric = [[(x+y)/2 for x, y in zip(row, adj)]
                 for row, adj in zip(negative, adjoint)]
    skew = [[(x-y)/2 for x, y in zip(row, adj)]
            for row, adj in zip(negative, adjoint)]
    test_sym = matvec(multiply(symmetric, symmetric), vector)
    test_skew = matvec(multiply(skew, skew), vector)
    assert mean([w*(x+y) for w, x, y in zip(vector, test_sym, test_skew)], stationary) == Q(-45, 19)
    sample_count = 0
    for x in [Q(k, 8) for k in range(1, 41)]:
        operator = [[value+(x if i == j else 0) for j, value in enumerate(row)]
                    for i, row in enumerate(negative)]
        resolvent = solve(operator, potential)
        exact = mean([f*z for f, z in zip(potential, resolvent)], stationary)
        assert exact == (873 + Q(10458, 19)*x)/(x*x+11*x+19)
        sample_count += 1

    epsilon = Q(1, 10**8)
    comparison = 46*epsilon**2
    for sign in (1, -1):
        coeff, _, upper = positive_trial(spatial, stationary, [sign*f for f in potential],
                                         epsilon, comparison)
        assert coeff == Q(873, 19) and upper < Q(-1, 20)

    # Gap-one environment at omega=1/2, so its two off-diagonal rates are 1/4.
    product_generator = []
    for e in range(2):
        for i in range(3):
            row = [Q(spatial[i][j]) if e == f else Q(0)
                   for f in range(2) for j in range(3)]
            row[3*e+i] -= Q(1, 4)
            row[3*(1-e)+i] += Q(1, 4)
            product_generator.append(row)
    product_stationary = [p/2 for _ in range(2) for p in stationary]
    product_potential = potential + [-f for f in potential]
    coeff, lower, _ = positive_trial(product_generator, product_stationary, product_potential,
                                      epsilon, comparison)
    assert coeff == Q(9696, 209) and lower > Q(1, 3)
    print(f"{sample_count} exact resolvent comparisons")
    print("slow quadratic coefficient: 873/19")
    print("speed-1/2 quadratic coefficient: 9696/209")
    print("finite witness: epsilon=1/100000000; both slow modes < 46 epsilon^2, speed 1/2 > 46 epsilon^2")


if __name__ == "__main__":
    main()
