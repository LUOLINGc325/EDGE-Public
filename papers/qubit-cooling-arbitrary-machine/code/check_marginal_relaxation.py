"""Counterexample to marginal conservation alone, without exact resonance."""

from fractions import Fraction as F


def main():
    machine = tuple(F(n, 50) for n in (1, 24, 15, 10))
    rows = (F(1, 25), F(117, 125), F(67, 3000), F(1, 600))
    incoming = (
        (0, 0, 1, 2),
        (1, 1, 2, 3),
        (2, 2, 3, 3),
        (2, 3, 3, 3),
    )
    psi = (0, 1, 4, 7)
    assert sum(machine) == sum(rows) == 1
    recovered = tuple(
        sum(rows[x] * machine[y] for x in range(4) for y in range(4)
            if incoming[x][y] == label)
        for label in range(4)
    )
    assert recovered == machine
    print("Incoming machine marginal:", tuple(map(str, recovered)))

    impossible = [
        (x, y) for x in range(4) for y in range(4)
        if rows[x] * machine[y] / machine[incoming[x][y]] not in rows
    ]
    assert impossible
    x, y = impossible[0]
    required_row = rows[x] * machine[y] / machine[incoming[x][y]]
    print(f"Exact resonance fails at destination ({x}, {y}): needs row weight {required_row}")

    fisher = energy = F(0)
    for p, indices in zip(rows, incoming):
        change = [psi[i] - val for i, val in zip(indices, psi)]
        fisher += p * sum(q * d for q, d in zip(machine, change))**2
        energy += p * sum(q * d**2 for q, d in zip(machine, change))
    difference = fisher - F(3, 4) * energy
    assert difference == F(33, 31250)
    print(f"F={fisher}; E={energy}; F-(3/4)E={difference} > 0")
    print("Scope: counterexample to marginal relaxation only.")


if __name__ == "__main__":
    main()
