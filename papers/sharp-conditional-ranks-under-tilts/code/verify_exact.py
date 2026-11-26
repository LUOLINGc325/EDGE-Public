#!/usr/bin/env python3
from collections import Counter
from fractions import Fraction
from itertools import combinations, permutations, product
from math import factorial, prod


def multiset_words(counts):
    items = sorted(counts)
    length = sum(counts.values())
    def visit(word):
        if len(word) == length:
            yield tuple(word)
            return
        for item in items:
            if counts[item]:
                counts[item] -= 1
                yield from visit(word + [item])
                counts[item] += 1
    yield from visit([])


def word_count(counts):
    return factorial(sum(counts.values())) // prod(factorial(x) for x in counts.values())


def tail_fraction(word):
    counts = Counter(word)
    total = word_count(counts)
    before = 0
    for selected in word:
        for x in sorted(counts):
            if x >= selected:
                break
            if counts[x]:
                counts[x] -= 1
                before += word_count(counts)
                counts[x] += 1
        counts[selected] -= 1
    return Fraction(before + 1, total)


def label_bin(value, cutoff_values):
    return sum(2 if x < value else int(x == value) for x in cutoff_values)


def attainable_totals(counts, number_masks):
    states = {(0,) * number_masks}
    for size in counts:
        new_states = set()
        for previous in states:
            for mask in range(number_masks):
                successor = list(previous)
                successor[mask] += size
                new_states.add(tuple(successor))
        states = new_states
    return states


def envelope(word, gamma):
    r = len(gamma)
    cutoffs = sorted(set(word[:r]))
    target = tuple(label_bin(v, cutoffs) for v in word[:r])
    table = [[] for _ in range(2 * len(cutoffs) + 1)]
    for value, multiplicity in Counter(word).items():
        table[label_bin(value, cutoffs)].append(multiplicity)
    mask_count = 1 << r
    weights = tuple(tuple(gamma[i] if mask & (1 << i) else 1 for mask in range(mask_count)) for i in range(r))
    equal_tail = tail_fraction(word[r:])
    best = Fraction(0)
    for state in product(*(attainable_totals(c, mask_count) for c in table)):
        types = [(b, mask, n) for b, ns in enumerate(state) for mask, n in enumerate(ns) if n]
        counts = [item[2] for item in types]
        seen_bins = []
        def weighted_permutations(i, mass):
            if i == r:
                bins = tuple(seen_bins)
                if bins < target:
                    return mass, mass
                if bins == target:
                    return equal_tail * mass, mass
                return 0, mass
            numerator, denominator = 0, 0
            for index, (group, mask, _) in enumerate(types):
                if not counts[index]:
                    continue
                count = counts[index]
                counts[index] -= 1
                seen_bins.append(group)
                a, b = weighted_permutations(i + 1, mass * count * weights[i][mask])
                numerator += a
                denominator += b
                seen_bins.pop()
                counts[index] += 1
            return numerator, denominator
        numerator, denominator = weighted_permutations(0, 1)
        best = max(best, Fraction(numerator, denominator))
    return best


def brute_envelopes(words, gamma):
    items = sorted(set(words[0]))
    columns = {x: i for i, x in enumerate(items)}
    r = len(gamma)
    best = [Fraction(0)] * len(words)
    for mask in product((0, 1), repeat=len(items) * r):
        weights = [prod(gamma[i] if mask[i * len(items) + columns[word[i]]] else 1 for i in range(r)) for word in words]
        total = sum(weights)
        cumulative = 0
        for j, weight in enumerate(weights):
            cumulative += weight
            best[j] = max(best[j], Fraction(cumulative, total))
    return tuple(best)


def smallest_factor(n, gamma):
    shifts = tuple(g - 1 for g in gamma)
    denominator = sum(factorial(n-k) * sum(prod(v) for v in combinations(shifts, k)) for k in range(len(gamma) + 1))
    return Fraction(prod(gamma), denominator)


def single_row(word, gamma):
    n = len(word)
    a = sum(x < word[0] for x in word)
    b = word.count(word[0])
    c = n - a - b
    q = tail_fraction(word[1:])
    return max(Fraction(gamma*a + t*b*q, gamma*a + t*b + c) for t in (1, gamma))


def mean_completion():
    values = (Fraction(1, 5), Fraction(2, 5), Fraction(3, 4))
    mu = Fraction(3, 5)
    a, b = Fraction(0), Fraction(1)
    orbit_mass = Fraction(1, 100)
    orbit_weights = (orbit_mass / len(values),) * len(values)
    pb = (mu - sum(x * w for x, w in zip(values, orbit_weights)) - a * (1-orbit_mass)) / (b-a)
    pa = 1 - orbit_mass - pb
    checks = 0
    for gamma in (1, Fraction(3, 2), 2, 5, 100):
        middle = Fraction(1+gamma,2)
        for row in product((1, gamma), repeat=len(values)):
            delta = sum(w*(x-mu)*(weight-middle) for w, x, weight in zip(orbit_weights, values, row))
            ga = middle - delta/(pa*(a-mu))
            law = (ga*pa, middle*pb, *(w*g for w,g in zip(orbit_weights,row)))
            assert 1 <= ga <= gamma and sum(q*x for q,x in zip(law,(a,b,*values))) == mu*sum(law)
            checks += 1
    return checks


def main():
    multiset_cases = ((0, 1), (0, 0, 1), (0, 1, 2), (0, 0, 0), (0, 0, 1, 2), (0, 1, 1, 2), (0, 0, 1, 1), (0, 1, 2, 3))
    count = 0
    for multiset in multiset_cases:
        words = tuple(multiset_words(Counter(multiset)))
        budgets = ((), (2,), (Fraction(3, 2),), (2, 2), (Fraction(3, 2), 3))
        if len(set(multiset)) <= 3 and len(multiset) >= 3:
            budgets += ((2, 2, 3),)
        for gammas in budgets:
            direct = brute_envelopes(words,gammas)
            computed = tuple(envelope(word,gammas) for word in words)
            assert computed == direct and computed[-1] == 1
            assert all(a<b for a,b in zip(computed, computed[1:]))
            assert computed[0] >= smallest_factor(len(multiset),gammas)
            if len(set(multiset))==len(multiset):
                assert computed[0] == smallest_factor(len(multiset),gammas)
            if len(gammas)==1:
                assert computed == tuple(single_row(word,gammas[0]) for word in words)
            if not gammas:
                assert computed == tuple(Fraction(j+1,len(words)) for j in range(len(words)))
            count += len(words)
    bottleneck = envelope((0,1,2,3),(2,2))
    assert bottleneck == Fraction(2,19) and bottleneck < Fraction(4,27)
    print(f'{count} prefix envelopes matched independent multiset-word exhaustive calculation.')
    print(f'{mean_completion()} shared-reference mean completions with exact same mean.')
    print('Two tilted positions out of four, Gamma=(2,2), smallest factor 2/19 versus 4/27 from the aggregate ratio.')


if __name__ == '__main__':
    main()
