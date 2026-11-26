"""Recheck the exclusion geometry and the optimization identities over Q."""
from fractions import Fraction as Q
from itertools import combinations, product


def rational_circle(t):
    return (1 - t*t) / (1 + t*t), 2*t / (1 + t*t)


def rotate(left, right):
    x, y = left
    u, v = right
    return x*u - y*v, x*v + y*u


def square_norm(point):
    x, y = point
    return x*x + y*y


def cross(left, right):
    x, y = left
    u, v = right
    return x*v - y*u


def subtract(left, right):
    return left[0] - right[0], left[1] - right[1]


def check_triangle(a, b, c):
    """Inputs have cosine and sine of positive half-gaps summing to pi."""
    assert all(x > 0 and y > 0 and x*x + y*y == 1 for x, y in (a, b, c))
    assert rotate(rotate(a, b), c) == (-1, 0)
    origin = (Q(0), Q(0))
    first = (Q(1), Q(0))
    second = rotate(b, b)
    reversed_a = (a[0], -a[1])
    third = rotate(reversed_a, reversed_a)
    vertices = [first, second, third]
    edges = list(zip(vertices, vertices[1:] + vertices[:1]))

    def inside(point):
        return all(cross(subtract(end, start), subtract(point, start)) >= 0
                   for start, end in edges)

    assert inside(origin)
    assert max(square_norm(subtract(x, y)) for x, y in combinations(vertices, 2)) == (
        4 * max(a[1], b[1], c[1])**2
    )
    cos_product = a[0]*b[0]*c[0]
    radii = []
    for shared, left, right, remaining in [
        (first, a, b, c), (second, b, c, a), (third, c, a, b),
    ]:
        p, q = left[1]/left[0], right[1]/right[0]
        relative_point = ((q-p)/(p+q), -2/(p+q))
        point = rotate(shared, relative_point)
        assert inside(point) and inside((-point[0], -point[1]))
        assert square_norm(point) == 1 - 4*cos_product/remaining[1]**2
        radii.append(square_norm(point))
    assert max(radii) == 1 - 4*cos_product/max(a[1], b[1], c[1])**2
    return max(radii)


def radius_squared(u):
    return 1 - 4*u*(1-2*u)/(1-u)


def main():
    trine_u = Q(1, 4)
    assert radius_squared(trine_u) == Q(1, 3)
    first_quadrant = sorted({rational_circle(Q(p, 24)) for p in range(1, 24)})
    checked_triangles = 0
    for a, b in product(first_quadrant, repeat=2):
        cosine_ab, sine_ab = rotate(a, b)
        c = (-cosine_ab, sine_ab)
        if c[0] <= 0:
            continue
        radius = check_triangle(a, b, c)
        u = min(a[0], b[0], c[0])**2
        assert Q(0) < u <= trine_u and radius <= radius_squared(u)
        assert (radius == radius_squared(u)) == ([a[0], b[0], c[0]].count(min(a[0], b[0], c[0])) >= 2)
        checked_triangles += 1

    checked_profiles = 0
    for c in first_quadrant:
        u = c[0]**2
        if u >= trine_u:
            continue
        cosine_2c, sine_2c = rotate(c, c)
        other = (-cosine_2c, sine_2c)
        radius = check_triangle(c, c, other)
        assert radius == radius_squared(u)
        v = 1 - radius
        assert 8*u*u - (4+v)*u + v == 0
        assert (4+v)**2 - 32*v == (4+v-16*u)**2
        assert 4+v-16*u > 0
        checked_profiles += 1

    previous = None
    for numerator in range(1, 251):
        u = Q(numerator, 1000)
        assert 1 - 4*u + 2*u*u > 0
        current = radius_squared(u)
        assert previous is None or previous > current
        previous = current

    print(f"{checked_triangles} rational triangles checked")
    print(f"{checked_profiles} attaining isosceles families checked")
    print("250 ordered rational radius-profile values checked")
    print("Exact trine radius squared: 1/3")


if __name__ == "__main__":
    main()
