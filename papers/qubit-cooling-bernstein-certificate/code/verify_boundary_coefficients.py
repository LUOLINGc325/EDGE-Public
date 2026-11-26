#!/usr/bin/env python3
"""Independent exact audit of the all-dimension boundary coefficient proof.

This script imports no implementation from the Bernstein dynamic program.
Its finite audit supplements, and does not replace, the analytic proof.
"""

import argparse
import json
from fractions import Fraction as Q


def compositions(total):
    if total == 0:
        yield ()
    else:
        for first in range(1, total + 1):
            for rest in compositions(total - first):
                yield (first,) + rest


def audit(max_m=12):
    count = 0
    counts = {}
    blocks_checked = 0
    for m in range(2, max_m + 1):
        d = m - 1
        counts[m] = 0
        for n in compositions(m):
            length = len(n) - 1
            if length == 0:
                continue
            h = [Q(a * b, a + b) for a, b in zip(n, n[1:])]
            g = [Q(d * a, m)
                 - (h[i - 1] if i else 0)
                 - (h[i] if i < length else 0)
                 for i, a in enumerate(n)]
            direct = sum((Q(d - i, d) * value
                          for i, value in enumerate(g)), Q(0))
            u = [a - 1 for a in n]
            excess = sum(u)
            e = [Q((a - b)**2, a + b) for a, b in zip(n, n[1:])]
            derived = (
                Q(2 * m - 1, 4) * u[0]
                + Q(2 * excess - 1, 4) * u[-1]
                + sum((Q(2 * m - 2 * i - 3, 4) * value
                       for i, value in enumerate(e)), Q(0))
                + sum((Q(2 * i - length, 2 * m) * value
                       for i, value in enumerate(u)), Q(0))
            )
            assert d * direct == derived
            assert direct >= 0
            assert (direct == 0) == (excess == 0)

            if excess:
                coarea = Q(0)
                for height in range(1, max(u) + 1):
                    i = 0
                    while i <= length:
                        if u[i] < height:
                            i += 1
                            continue
                        left = i
                        while i + 1 <= length and u[i + 1] >= height:
                            i += 1
                        right = i
                        width = right - left + 1
                        i += 1
                        block = Q(width * (left + right - length), 2 * m)
                        if left == 0:
                            block += Q(2 * m - 1, 4)
                        else:
                            block += Q(2 * m - 2 * (left - 1) - 3,
                                       4 * (2 * height + 1))
                        if right == length:
                            block += Q(2 * excess - 1, 4)
                        else:
                            block += Q(2 * m - 2 * right - 3,
                                       4 * (2 * height + 1))
                        assert block > 0, (n, height, left, right, block)
                        coarea += block
                        blocks_checked += 1
                assert derived >= coarea > 0
            count += 1
            counts[m] += 1

    return {
        "status": "PASS",
        "arithmetic": "fractions.Fraction (exact)",
        "imports_dynamic_program": False,
        "dimension_min": 2,
        "dimension_max": max_m,
        "multi_layer_compositions_checked": count,
        "height_blocks_checked": blocks_checked,
        "counts_by_dimension": counts,
        "verified": [
            "direct Bernstein coefficient equals the analytic expansion",
            "coarea sum lower-bounds the analytic expression",
            "each nonempty height block is strictly positive when U > 0",
            "the penultimate coefficient vanishes exactly for all-ones compositions",
        ],
        "scope": "finite independent audit of an analytically proved boundary theorem",
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--max-m", type=int, default=12)
    args = parser.parse_args()
    if args.max_m < 2:
        parser.error("--max-m must be at least 2")
    print(json.dumps(audit(args.max_m), indent=2))
