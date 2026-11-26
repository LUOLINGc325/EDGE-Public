"""Rational certificates for the two-step Glauber activity bounds."""
from collections import deque
from fractions import Fraction as Q
from itertools import combinations_with_replacement, product


def check_local_optimization():
    for degree in range(3, 161):
        values = []
        for r in range(degree+1):
            x = min(Q(r), Q(degree-r, 2))
            values.append(x*(degree-r-x))
        assert max(values) == degree**2 // 8
    return 158


def layered_edges(degree, layers, narrow_degree):
    width = degree
    for k in range(layers):
        low = 2*k*width
        high = low + width
        following = 2*((k+1) % layers)*width
        for index in range(width):
            for offset in range(narrow_degree):
                yield low+index, high+(index+offset) % width, True
            for offset in range(degree-narrow_degree):
                yield high+index, following+(index+offset) % width, k == layers-1


def check_layered_limit(degree, layers, narrow_degree, energies=None):
    width = degree
    order = 2*layers*width
    if energies is None:
        energies = list(range(order))
    adj = [set() for _ in range(order)]
    earlier_bias = [0] * order
    later_bias = [0] * order
    for i, j, sharp in layered_edges(degree, layers, narrow_degree):
        assert j not in adj[i] and i != j
        adj[i].add(j)
        adj[j].add(i)
        assert (i//width) % 2 != (j//width) % 2
        low, high = (i, j) if energies[i] < energies[j] else (j, i)
        later_bias[low] -= 1
        later_bias[high] += 1
        if sharp:
            earlier_bias[low] -= 1
            earlier_bias[high] += 1
    assert all(len(neighbors) == degree for neighbors in adj)
    seen = {0}
    todo = deque([0])
    while todo:
        node = todo.popleft()
        for neighbor in adj[node] - seen:
            seen.add(neighbor)
            todo.append(neighbor)
    assert len(seen) == order
    average_product = Q(sum(a*b for a, b in zip(earlier_bias, later_bias)), order)
    assert average_product == Q(degree**2-(layers-1)*(degree**2//8), layers)
    first = Q(1, 2) + Q(sum(earlier_bias), 2*degree*order)
    second = Q(1, 2) + Q(sum(later_bias), 2*degree*order) - average_product/(2*degree**2)
    return first, second


def check_cycles():
    count = 0
    beta_bases = list(combinations_with_replacement((1, 2, 3, 7), 3))
    for order in range(3, 6):
        cycle = [(index, (index+1) % order) for index in range(order)]
        for energy in product(range(3), repeat=order):
            for q0, q1, q2 in beta_bases:
                raw = [Q(1, q0**x) for x in energy]
                p = [x/sum(raw) for x in raw]
                p1 = p.copy()
                a1 = a2 = Q(0)
                for i, j in cycle:
                    ratio = Q(q1)**(energy[j]-energy[i])
                    alpha = 1/(2*(1+ratio))
                    forward, reverse = p[i]*alpha, p[j]*(Q(1, 2)-alpha)
                    a1 += forward+reverse
                    p1[i] += reverse-forward
                    p1[j] += forward-reverse
                for i, j in cycle:
                    ratio = Q(q2)**(energy[j]-energy[i])
                    alpha = 1/(2*(1+ratio))
                    a2 += p1[i]*alpha + p1[j]*(Q(1, 2)-alpha)
                assert a1 <= Q(1, 2) and a2 <= Q(1, 2)
                count += 1
    return count


def certify_finite_cubic():
    degree, layers, gap = 3, 125, 50000
    energies = [
        degree*(k*(gap+1)+band*gap)+index
        for k in range(layers) for band in range(2) for index in range(degree)
    ]
    assert len(energies) == len(set(energies)) == 750
    for i, j, sharp in layered_edges(degree, layers, 1):
        difference = abs(energies[i]-energies[j])
        assert difference >= 140000 if sharp else 1 <= difference <= 5
    ideal_first, ideal_second = check_layered_limit(degree, layers, 1, energies)
    assert ideal_first == Q(1, 2) and ideal_second == Q(1, 2)+Q(23, 450)

    energy_range = max(energies)-min(energies)
    assert energy_range == 18750374
    drift = Q(energy_range, 10**13)
    error0, error1, error2 = Q(1, 400000), Q(1, 1999), Q(1, 32768)
    assert drift/(1-drift) < error0
    assert Q(10001, 10000)**5-1 <= error1
    assert 10001**10000 > 2*10000**10000
    assert Q(2, 2**14+1) < error1
    assert Q(1, 32768+1) < error2
    first_lower = ideal_first-error0
    second_lower = ideal_second-error0-error1-error2
    assert second_lower > Q(11, 20)
    assert (first_lower+second_lower)/2 > Q(21, 40)
    return second_lower, (first_lower+second_lower)/2


if __name__ == "__main__":
    local = check_local_optimization()
    cases = 0
    for degree, layers in product(range(3, 21), (2, 3, 8, 23)):
        # Either nearest integer works at a tie.
        r = (degree+2)//4
        check_layered_limit(degree, layers, r)
        cases += 1
    cyclic = check_cycles()
    second, average = certify_finite_cubic()
    print(f"{local} exact degree optimizations checked")
    print(f"{cases} connected layered graphs checked")
    print(f"{cyclic} exact degree-two cases checked")
    print(f"finite cubic second activity > {second} > 11/20")
    print(f"finite cubic two-step mean > {average} > 21/40")
