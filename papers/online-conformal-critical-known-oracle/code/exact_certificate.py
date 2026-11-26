"""Recompute finite Bernoulli clipping costs by integer dynamic programming."""
from fractions import Fraction
from math import erf, exp, isqrt, pi, sqrt


def measures(t_max, scale):
    states = {0: 1}
    edit_count = 0
    for t in range(1, t_max + 1):
        bound = isqrt(scale * scale * t)
        next_states = {}
        edit_count *= 2
        for state, multiplicity in states.items():
            for step in (-1, 1):
                candidate = state + step
                if abs(candidate) > bound:
                    candidate = state - step
                    edit_count += multiplicity
                assert abs(candidate) <= bound
                assert (candidate - t) % 2 == 0
                next_states[candidate] = next_states.get(candidate, 0) + multiplicity
        states = next_states
        assert sum(states.values()) == 1 << t
        assert all(states.get(-state) == n for state, n in states.items())
    risk = Fraction(edit_count, 1 << t_max)
    moment = Fraction(sum(x * x * n for x, n in states.items()), 4 * t_max * (1 << t_max))
    return risk, moment


def main():
    for scale in (1, 2):
        kappa = scale / 2
        variance = 1 / 4
        integral = sqrt(2 * pi * variance) * erf(kappa / sqrt(2 * variance))
        limit = 2 * variance * exp(-kappa * kappa / (2 * variance)) / integral
        print(f"alpha=1/2 kappa={kappa} limit={limit:.10f}")
        for horizon in (128, 512, 2048, 8192):
            risk, moment = measures(horizon, scale)
            print(f"T={horizon:4} V_T/sqrt(T)={float(risk)/sqrt(horizon):.10f}"
                  f" E[E_T^2]/T={float(moment):.10f}")


if __name__ == "__main__":
    main()
