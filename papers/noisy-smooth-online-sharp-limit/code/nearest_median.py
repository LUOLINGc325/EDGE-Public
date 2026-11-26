"""Reference online learner for a known bound on corrupted feedback counts.

Only the Python standard library is required. Inputs may be Fraction objects.
Observations at the same coordinate remain separate indexed observations.
This deliberately simple implementation sorts the history at every prediction;
it is a research reference, not a claim of optimal running time.
"""

from __future__ import annotations


class NearestMedian:
    """Median of the 2*eta+1 nearest previously reported observations."""

    def __init__(self, eta: int):
        if isinstance(eta, bool) or not isinstance(eta, int) or eta < 0:
            raise ValueError("eta must be a nonnegative integer")
        self.eta = eta
        self.k = 2 * eta + 1
        self.history = []

    def predict(self, x):
        """Return (prediction, kth radius, selected indices), before observing y.

        During the k unscored warmup rounds return an arbitrary zero prediction
        with radius None. No current or future reported label is accessed.
        """
        if not 0 <= x <= 1:
            raise ValueError("the input must belong to [0, 1]")
        if len(self.history) < self.k:
            return 0, None, ()
        indices = sorted(
            range(len(self.history)),
            key=lambda i: (abs(x - self.history[i][0]), i),
        )[: self.k]
        reports = sorted(self.history[i][1] for i in indices)
        radius = abs(x - self.history[indices[-1]][0])
        return reports[self.eta], radius, tuple(indices)

    def observe(self, x, reported_y):
        """Append a report after making the prediction at x."""
        if not 0 <= x <= 1:
            raise ValueError("the input must belong to [0, 1]")
        self.history.append((x, reported_y))


def geometric_trace(points, k):
    """Return the k-th previous-neighbour radii and the proof colouring.

    The colouring is an analysis device; NearestMedian does not use it.
    Ties are resolved by observation index, including repeated coordinates.
    """
    if not isinstance(k, int) or isinstance(k, bool) or k < 1:
        raise ValueError("k must be a positive integer")
    if len(points) < k or any(not 0 <= x <= 1 for x in points):
        raise ValueError("need at least k points in [0, 1]")
    colours = list(range(k))
    records = []
    for t in range(k, len(points)):
        nearest = sorted(range(t), key=lambda i: (abs(points[t] - points[i]), i))
        excluded = {colours[i] for i in nearest[: k - 1]}
        colour = next(c for c in range(k) if c not in excluded)
        radius = abs(points[t] - points[nearest[k - 1]])
        own_distance = min(
            abs(points[t] - points[i]) for i in range(t) if colours[i] == colour
        )
        colours.append(colour)
        records.append((t, radius, colour, own_distance))
    return colours, records
