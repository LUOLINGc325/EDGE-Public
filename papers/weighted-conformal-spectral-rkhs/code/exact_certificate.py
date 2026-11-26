#!/usr/bin/env python3
"""Exact spectral perturbation and hard-deletion examples."""

from fractions import Fraction as Q


def transpose(matrix):
    return tuple(zip(*matrix))


def multiply(left, right):
    return tuple(tuple(sum(a * b for a, b in zip(row, col)) for col in transpose(right))
                 for row in left)


def diagonal(first, second):
    return ((first, 0), (0, second))


def hs_distance_squared(left, right):
    return sum((a - b) ** 2 for u, v in zip(left, right) for a, b in zip(u, v))


def main():
    cutoff, transition, ridge = Q(1, 3), Q(1, 4), Q(1, 2)

    def response(eigenvalue):
        taper = min(Q(1), max(Q(0), (eigenvalue - cutoff) / transition))
        return taper / (eigenvalue + ridge)

    left_pair = Q(1), Q(1, 4)
    right_pair = Q(3, 4), Q(1, 2)
    rotation = ((Q(3, 5), -Q(4, 5)), (Q(4, 5), Q(3, 5)))

    def rotated(pair):
        return multiply(multiply(rotation, diagonal(*pair)), transpose(rotation))

    left, right = diagonal(*left_pair), rotated(right_pair)
    assert multiply(left, right) != multiply(right, left)
    kernel_squared = hs_distance_squared(left, right)
    filter_squared = hs_distance_squared(diagonal(*map(response, left_pair)),
                                        rotated(tuple(map(response, right_pair))))
    lipschitz = 1 / (transition * (cutoff + ridge)) + 1 / (cutoff + ridge) ** 2
    assert filter_squared <= lipschitz**2 * kernel_squared
    print("Noncommuting spectral example")
    print(f"operator HS squared = {kernel_squared}")
    print(f"filtered HS squared = {filter_squared}")
    print(f"Lipschitz bound squared = {lipschitz**2 * kernel_squared}")
    print("Hard rank-one deletion witness for ridge λ=1/2")
    for m in (2, 10, 100, 1000):
        before = (Q(m, 2*m), Q(m+1, 2*m))
        after = (Q(m, 2*m-1), Q(m-1, 2*m-1))
        assert before[0] < before[1] and after[0] > after[1]
        prediction_change = after[0] / (after[0] + ridge)
        assert prediction_change > Q(1, 2)
        print(f"n={2*m}: change at e1 is {prediction_change} (>1/2)")
    print("All checks used exact rational arithmetic.")


if __name__ == "__main__":
    main()
