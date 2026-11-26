"""Exact rational reference implementation of fractional-advice PAW.

This is computational reproduction code, not a formal proof or a Lean file.
The paper defines the same finite operations for real inputs.  This executable
uses Fraction and accepts rational inputs only.
"""
from fractions import Fraction as Q


def waterlevel(bins, supply):
    """Largest useful level in [0,1] for positive (capacity, height) bins."""
    bins = [(Q(b), Q(z)) for b, z in bins if b > 0]
    if not bins:
        return Q(1)
    supply = Q(supply)
    if supply < 0:
        raise ValueError("negative supply")
    available = sum((b * (1 - z) for b, z in bins), Q(0))
    if supply >= available:
        return Q(1)
    events = {}
    for b, z in bins:
        if not 0 <= z <= 1:
            raise ValueError("height outside [0,1]")
        events[z] = events.get(z, Q(0)) + b
    active = Q(0)
    level = min(events)
    rest = supply
    for height in sorted(events):
        cost = active * (height - level)
        if active and rest <= cost:
            return level + rest / active
        rest -= cost
        active += events[height]
        level = height
    return min(Q(1), level + rest / active)


class FractionalPAW:
    """Two levels per original vertex; the arrival horizon is not an input."""

    def __init__(self, n, trust):
        if not isinstance(n, int) or n < 0:
            raise ValueError("n must be a nonnegative integer")
        self.n = n
        self.trust = Q(trust)
        if not 0 <= self.trust <= 1:
            raise ValueError("trust must lie in [0,1]")
        self.advised = [Q(0)] * n
        self.base = [Q(0)] * n
        self.total_advice = Q(0)

    def load(self, u):
        z, a = self.base[u], self.advised[u]
        return z + a * max(Q(0), self.trust - z)

    def loads(self):
        return [self.load(u) for u in range(self.n)]

    def _waterfill(self, neighbors, supply):
        if supply == 0 or not neighbors:
            return {u: Q(0) for u in neighbors}
        before = {u: self.load(u) for u in neighbors}
        bins = []
        for u in neighbors:
            a, z = self.advised[u], self.base[u]
            bins.append((1 - a, z))
            bins.append((a, max(z, self.trust)))
        ell = waterlevel(bins, supply)
        for u in neighbors:
            self.base[u] = max(self.base[u], ell)
        return {u: self.load(u) - before[u] for u in neighbors}

    def arrive(self, neighbors, advice=None):
        """Return the irrevocable row allocation, processing advice in index order.

        Feasibility of the revealed advice prefix is checked before any mutation.
        Splitting uses unadvised nominal capacity, not unoccupied capacity.
        """
        neighbors = tuple(sorted(set(neighbors)))
        if any(not isinstance(u, int) or not 0 <= u < self.n for u in neighbors):
            raise ValueError("invalid offline vertex")
        advice = {u: Q(a) for u, a in (advice or {}).items() if a != 0}
        if not set(advice) <= set(neighbors):
            raise ValueError("advice on an absent edge")
        if any(a < 0 for a in advice.values()):
            raise ValueError("negative advice")
        advised_mass = sum(advice.values(), Q(0))
        if advised_mass > 1:
            raise ValueError("advice exceeds online capacity")
        if any(self.advised[u] + a > 1 for u, a in advice.items()):
            raise ValueError("advice exceeds offline nominal capacity")
        out = {u: Q(0) for u in neighbors}
        for u in sorted(advice):
            a = advice[u]
            push = a * max(Q(0), self.trust - self.base[u])
            self.advised[u] += a
            out[u] += push
            for w, amount in self._waterfill(neighbors, a - push).items():
                out[w] += amount
        for w, amount in self._waterfill(neighbors, 1 - advised_mass).items():
            out[w] += amount
        self.total_advice += advised_mass
        if any(a < 0 for a in out.values()) or sum(out.values(), Q(0)) > 1:
            raise AssertionError("invalid row allocation")
        if any(not 0 <= self.load(u) <= 1 for u in neighbors):
            raise AssertionError("invalid column allocation")
        return out


def run(n, rows, trust):
    alg = FractionalPAW(n, trust)
    out = [alg.arrive(row['neighbors'], row.get('advice', {})) for row in rows]
    return {'allocations': out, 'loads': alg.loads(),
            'value': sum(alg.loads(), Q(0)), 'advice_value': alg.total_advice}
