"""Independent exact enumeration of finite distributions used in the paper."""

import json
import random
from fractions import Fraction as F
from itertools import product
from math import prod


def two_point(up, down):
    up, down = F(up), F(down)
    return ((up, down / (up + down)), (-down, up / (up + down)))


def enumerate_outcomes(arms):
    variance = sum(x * x * probability for arm in arms for x, probability in arm)
    for arm in arms:
        assert sum(probability for _, probability in arm) == 1
        assert sum(x * probability for x, probability in arm) == 0
    wins = [F(0) for _ in arms]
    bias = F(0)
    for outcome in product(*arms):
        values, probabilities = zip(*outcome)
        winner = max(range(len(arms)), key=values.__getitem__)
        probability = prod(probabilities)
        wins[winner] += probability
        bias += probability * values[winner]
    assert sum(wins) == 1
    envelope = (1 - sum(p * p for p in wins)) / 2
    assert bias >= 0 and bias * bias <= variance * envelope
    return bias, variance, tuple(wins), envelope


def check_first_hit(arms, wins, envelope):
    ordered = sorted(range(len(arms)), key=lambda i: -arms[i][0][0])
    survival = F(1)
    hits = [F(0) for _ in arms]
    energy = F(0)
    for i in ordered:
        up_probability = arms[i][0][1]
        hits[i] = survival * up_probability
        survival -= hits[i]
        energy += hits[i] * survival
    assert energy == (1 - sum(p * p for p in hits) - survival**2) / 2
    k = max(range(len(arms)), key=lambda i: arms[i][1][0])
    post_k = prod(arms[i][1][1] for i in ordered[:ordered.index(k) + 1])
    adjusted = energy - 2 * hits[k] * survival + hits[k] * survival**2 / post_k
    assert adjusted == envelope - hits[k] * survival * (1 - survival / post_k)
    hits[k] += survival
    assert tuple(hits) == wins


def floor_envelope(probabilities, scale):
    arms = []
    remaining = F(1)
    for p in probabilities[:-1]:
        remaining -= p
        arms.append(two_point(scale * remaining, scale * p))
    return arms + [((F(0), F(1)),)]


def check_mixture(arm):
    positive = [(x, mass) for x, mass in arm if x > 0]
    negative = [(-x, mass) for x, mass in arm if x < 0]
    b = sum(x * mass for x, mass in positive)
    reconstructed = {F(0): sum(mass for x, mass in arm if x == 0)}
    component_variance = F(0)
    for (up, up_mass), (down, down_mass) in product(positive, negative):
        mixture_mass = (up + down) * up_mass * down_mass / b
        component_variance += mixture_mass * up * down
        for x, p in two_point(up, down):
            reconstructed[x] = reconstructed.get(x, F(0)) + mixture_mass * p
    assert reconstructed == dict(arm)
    assert component_variance == sum(x * x * mass for x, mass in arm)


def main():
    rng = random.Random(261031948)
    sharp = 0
    strict = 0
    for m in range(2, 10):
        profiles = [[1] * m] + [[rng.randint(1, 20) for _ in range(m)] for _ in range(12)]
        for weights in profiles:
            p = tuple(F(w, sum(weights)) for w in weights)
            bias, variance, wins, envelope = enumerate_outcomes(floor_envelope(p, F(3, 7)))
            assert wins == p
            assert bias * bias == variance * envelope
            sharp += 1
        for _ in range(35):
            arms = [two_point(rng.randint(1, 8), rng.randint(1, 8)) for _ in range(m)]
            bias, variance, wins, envelope = enumerate_outcomes(arms)
            check_first_hit(arms, wins, envelope)
            assert bias * bias < variance * envelope
            strict += 1

    mixed = ((F(-3), F(1, 10)), (F(-1), F(1, 10)), (F(0), F(1, 2)),
             (F(1), F(1, 5)), (F(2), F(1, 10)))
    check_mixture(mixed)
    enumerate_outcomes([mixed, two_point(2, 1), mixed, ((F(0), F(1)),)])
    return {"arithmetic": "exact rational", "sharp_frequency_profiles": sharp,
            "strict_all_random_configurations": strict, "mixture_reconstruction_checks": 1}


if __name__ == "__main__":
    print(json.dumps(main(), indent=2, sort_keys=True))
