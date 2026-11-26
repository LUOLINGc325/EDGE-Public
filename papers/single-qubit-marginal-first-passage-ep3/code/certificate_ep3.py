"""Check the finite algebra in the single-qubit first-passage proof."""

from sympy import Matrix, Rational, diag, eye, simplify, sqrt, symbols, trace, zeros


def main():
    x, c, w, eta, s, gamma, epsilon = symbols("x c w eta s gamma epsilon")
    d = Rational(1, 8)
    eigenvalue = Rational(1, 4)
    base = {c: Rational(1, 2), w: Rational(1, 7)}
    z_coordinate = c + (1 - c) * w
    a = 1 + 2 * c - z_coordinate
    coefficient_t = d * a + z_coordinate
    coefficient_q = d * a + d**2 * z_coordinate
    coefficient_d = d**2
    constraints = Matrix(
        [coefficient_q - coefficient_t**2 / 3, coefficient_d - coefficient_t**3 / 27]
    )
    jacobian = constraints.jacobian([c, w]).subs(base).det()
    assert jacobian == -Rational(63, 8192)

    axis = Matrix([sqrt(Rational(6, 7)), 0, sqrt(Rational(1, 7))])
    axis_generator = Matrix(
        [[0, -axis[2], axis[1]], [axis[2], 0, -axis[0]], [-axis[1], axis[0], 0]]
    )
    rotation = (eye(3) + axis * axis.T + sqrt(3) * axis_generator) / 2
    rotation = rotation.applyfunc(simplify)
    assert simplify(rotation * rotation.T) == eye(3)
    assert simplify(rotation.det()) == 1
    a_matrix = rotation * diag(d, d, 1)
    characteristic = a_matrix.charpoly(x).as_expr()
    assert simplify(characteristic - (x - eigenvalue) ** 3) == 0
    nilpotent = a_matrix - eigenvalue * eye(3)
    square = simplify(nilpotent**2)
    assert simplify(nilpotent**3) == zeros(3)
    assert square[2, 2] == Rational(3, 112)

    z_generator = Matrix([[0, -1, 0], [1, 0, 0], [0, 0, 0]])
    z_contraction = simplify(trace(square * z_generator))
    assert z_contraction == 3 * sqrt(21) / 224
    weighted_derivative = (
        a_matrix * (63 * diag(1, 1, 0) - sqrt(63) * z_generator) / (64 * eta)
    )
    laplace_derivative = simplify(-trace(square * weighted_derivative))
    expected = (9 * sqrt(3) / 8192 + Rational(27, 4096)) / eta
    assert simplify(laplace_derivative - expected) == 0
    assert simplify((eigenvalue * eye(3) - a_matrix).adjugate() - square) == zeros(3)

    trace_resolvent = Matrix([[eta, gamma * epsilon], [gamma * epsilon, eta]]).inv()
    trace_row = (Matrix([[1, 0]]) - s * trace_resolvent[0, :]) / (gamma / eta)
    b_derivative = simplify(trace_row[1].diff(epsilon).subs(epsilon, 0))
    assert b_derivative == s / eta
    ez = Matrix([0, 0, 1])
    graph_derivative = b_derivative * ez.T * (a_matrix - eye(3)).inv()
    visibility_derivative = simplify((graph_derivative * square * ez)[0])
    assert visibility_derivative == -s / (28 * eta)

    print("Bloch characteristic: (x - 1/4)^3")
    print(f"Constraint Jacobian: {jacobian}")
    print(f"Jordan square zz component: {square[2, 2]}")
    print(f"Jordan square rotation contraction: {z_contraction}")
    print(f"Marginal quadratic coefficient derivative: {visibility_derivative}")
    print(f"Laplace cubic derivative: {laplace_derivative}")
    print("All symbolic identities verified.")


if __name__ == "__main__":
    main()
