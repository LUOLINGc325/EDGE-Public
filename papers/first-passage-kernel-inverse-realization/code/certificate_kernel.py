"""Certify exact examples of the inverse construction in dimensions two and three."""

from itertools import combinations

from sympy import I, Matrix, Rational, eye, simplify, sqrt, trace, zeros


def matrix_unit(d, row, col):
    unit = zeros(d)
    unit[row, col] = 1
    return unit


def basis_for_dimension(d):
    diagonal = Matrix.diag(1, -1, *([0] if d == 3 else [])) / sqrt(2)
    off_diagonal = []
    for first, second in combinations(range(d), 2):
        forward = matrix_unit(d, first, second)
        backward = matrix_unit(d, second, first)
        off_diagonal.extend([(forward + backward) / sqrt(2),
                             I * (backward - forward) / sqrt(2)])
    if d == 2:
        return [off_diagonal[0], off_diagonal[1], diagonal]
    return [diagonal, *off_diagonal, Matrix.diag(1, 1, -2) / sqrt(6)]


def hermitian_coordinates(matrix, traceless):
    return Matrix([trace(matrix), *[trace(item * matrix) for item in traceless]])


def exact_dimension_example(d):
    m = d * d - 1
    q = Rational(1, 4)
    mu = alpha = beta = Rational(1, 64)
    delta = Rational(1, 32)
    shift = zeros(m)
    for i in range(m - 1):
        shift[i, i + 1] = 1
    trace_shear = zeros(1, m)
    trace_shear[0, 0] = 1
    if d == 2:
        trace_shear[0, m - 1] = 1
    transient = mu * eye(m) + alpha * shift
    shear = eye(m + 1)
    shear[0, 1:] = beta * trace_shear
    r_map = q * shear * Matrix.diag(1, transient) * shear.inv()

    traceless = basis_for_dimension(d)
    gram = Matrix(m, m, lambda row, col: trace(traceless[row] * traceless[col]))
    assert gram == eye(m)
    d_coords = trace_shear * (transient - eye(m))
    d_matrix = zeros(d)
    for coefficient, matrix in zip(d_coords, traceless):
        d_matrix += coefficient * matrix
    b_matrix = q * (eye(d) + beta * d_matrix)
    assert simplify(trace((beta * d_matrix) ** 2)) < 1
    assert simplify(q**2 * trace((beta * d_matrix) ** 2)) < (1 - q) ** 2
    rate = simplify((eye(d) - b_matrix).inv() - eye(d))

    denominator = Matrix.hstack(
        *[hermitian_coordinates(
              item + (rate * item + item * rate) / 2, traceless
          ) for item in [eye(d) / d, *traceless]]
    ).applyfunc(simplify)
    jump = simplify(r_map * denominator)
    assert simplify(jump[0, :].T - Matrix(
        [trace(rate) / d, *[trace(rate * item) for item in traceless]]
    )) == zeros(m + 1, 1)

    # Choi reshuffling preserves Frobenius norm in orthonormal operator coordinates.
    depolarizing_jump = zeros(m + 1)
    depolarizing_jump[0, 0] = q / (1 - q)
    orthonormal = Matrix.diag(1 / sqrt(d), *([1] * m))
    perturbation = orthonormal * (jump - depolarizing_jump) * orthonormal.inv()
    squared_norm = simplify(trace(perturbation.H * perturbation))
    choi_gap = q / (d * (1 - q))
    assert squared_norm < choi_gap**2

    input_coordinates = Matrix([1, *([0] * (m - 1)), delta])
    last_vector = eye(m)[:, -1]
    for count in range(m + 2):
        actual = (r_map**count * input_coordinates)[0] / q**count
        expected = (1 - beta * delta * trace_shear[0, m - 1]
                    + beta * delta * (trace_shear * transient**count * last_vector)[0])
        assert simplify(actual - expected) == 0
    highest_coefficient = beta * delta * (trace_shear * (alpha * shift)**(m - 1)
                                            * last_vector)[0]
    assert highest_coefficient == beta * delta * alpha**(m - 1)

    vector_on_e1 = shear[:, 1]
    inverse_column = (denominator.inv() * vector_on_e1).applyfunc(simplify)
    c_m1 = inverse_column[-1]
    assert c_m1.is_positive
    if d == 2:
        expected_c_m1 = q * beta**2 * (1 - mu) * (1 - q * mu) / (2 * (1 - q))
        assert simplify(c_m1 - expected_c_m1) == 0
    reduced_derivative = q * mu * (q * alpha)**(m - 1) * c_m1
    assert reduced_derivative.is_positive
    print(f"d={d}, Jordan order={m}, ordinary coefficient={highest_coefficient}")
    print(f"  Choi perturbation norm squared / gap squared={squared_norm / choi_gap**2}")
    print(f"  fixed-kernel characteristic derivative={simplify(reduced_derivative)}")


def check_inverse_rate():
    b = [Rational(1, 4), Rational(1, 2)]
    s = Rational(3, 2)
    b_matrix = Matrix.diag(*b)
    h = Matrix([[0, 1 + I], [1 - I, 0]])
    commutator = h * b_matrix - b_matrix * h
    rate = Matrix(2, 2, lambda i, j: (
        (s * b_matrix - I * commutator)[i, j] / (1 - (b[i] + b[j]) / 2)
    ))
    assert simplify(rate - rate.H) == zeros(2)
    residual = rate - s * b_matrix + I * commutator - (rate * b_matrix + b_matrix * rate) / 2
    assert simplify(residual) == zeros(2)
    print("Inverse rate consistency with noncommuting Hamiltonian verified.")


if __name__ == "__main__":
    check_inverse_rate()
    for dimension in (2, 3):
        exact_dimension_example(dimension)
