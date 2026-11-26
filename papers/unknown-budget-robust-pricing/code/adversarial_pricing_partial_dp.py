"""Exact finite-horizon adversarial DP for the final partial-decrement policy.

This is the final a>=8 algorithm, not the earlier full-reset discovery variant.
A new macro-step starts only with at least three physical rounds remaining.
At most two residual rounds post zero. Leaf counters are persistent and real
(rational in this implementation); only the current counter is decremented.

The adversary chooses whether to flag the next physical query before the fresh
price coin, and then chooses a reported bit separately for each price branch.
The DP maximizes exact rational expected economic regret over all such adaptive
hard-budget adversaries at the supplied fixed valuation. This finite computation
is neither a proof at arbitrary horizons nor a certificate of the manuscript.
"""
from fractions import Fraction as Q
from functools import lru_cache
import argparse
import json
import math
import time


START = 0
RIGHT_GUARD = 1
MIDPOINT = 2
LEAF_SECOND = 3


def solve(T, C, v, a=Q(8)):
    T, C, v, a = int(T), int(C), Q(v), Q(a)
    if T < 1 or C < 0 or not 0 <= v <= 1 or a < 8:
        raise ValueError('Require T>=1, C>=0, 0<=v<=1 and a>=8.')
    D = (T - 1).bit_length()

    def update(counter, leaf, amount):
        assert amount >= 0
        new_counter = dict(counter)
        if amount:
            new_counter[leaf] = amount
        else:
            new_counter.pop(leaf, None)
        return tuple(sorted(new_counter.items()))

    def parent(depth, index, counter):
        assert depth > 0
        return depth - 1, index // 2, START, counter

    def branches(depth, index, phase, counter):
        """Return actual physical-query branches, excluding skipped sentinels."""
        left, right = Q(index, 2**depth), Q(index + 1, 2**depth)
        if depth < D:
            if phase == START:
                if left > 0:
                    next_phase = RIGHT_GUARD if right < 1 else MIDPOINT
                    def after_left(bit):
                        if bit:
                            return depth, index, next_phase, counter
                        return parent(depth, index, counter)
                    return [(Q(1), left, after_left)]
                phase = RIGHT_GUARD if right < 1 else MIDPOINT
            if phase == RIGHT_GUARD:
                assert right < 1
                def after_right(bit):
                    if bit:
                        return parent(depth, index, counter)
                    return depth, index, MIDPOINT, counter
                return [(Q(1), right, after_right)]
            assert phase == MIDPOINT
            def after_midpoint(bit):
                return depth + 1, 2 * index + bit, START, counter
            return [(Q(1), (left + right) / 2, after_midpoint)]

        assert depth == D
        if right == 1:
            assert phase == START
            def after_rightmost_left(bit):
                if bit:
                    return depth, index, START, counter
                return parent(depth, index, counter)
            return [(Q(1), left, after_rightmost_left)]
        if phase == START:
            def after_leaf_first(bit):
                if bit:
                    return depth, index, LEAF_SECOND, counter
                return parent(depth, index, counter)
            return [(Q(1), left, after_leaf_first)]
        assert phase == LEAF_SECOND
        old = dict(counter).get(index, Q(0))
        z = old + 1
        q = min(a / z, Q(1))
        decrement = min(z, 4 / q)
        assert 0 < q <= 1 and 0 < decrement <= z
        incremented = update(counter, index, z)
        decremented = update(counter, index, z - decrement)
        def after_lower(bit):
            if bit:
                return depth, index, START, incremented
            return parent(depth, index, incremented)
        def after_upper(bit):
            if bit:
                return parent(depth, index, decremented)
            return depth, index, START, incremented
        # Discard impossible zero-probability branches, including q=1's left child.
        return [(prob, price, continuation) for prob, price, continuation in
                [(1-q, left, after_lower), (q, right, after_upper)] if prob]

    diagnostics = {"fractional_counter_states": 0, "interior_query_states": 0,
                   "leaf_second_query_states": 0, "terminal_filler_states": 0}

    @lru_cache(None)
    def value(remaining, budget, depth, index, phase, counter):
        assert 0 <= depth <= D and 0 <= index < 2**depth
        if any(amount.denominator > 1 for _, amount in counter):
            diagnostics["fractional_counter_states"] += 1
        assert all(amount > 0 for _, amount in counter)
        assert sum((amount for _, amount in counter), Q(0)) <= T - remaining
        if remaining == 0:
            assert phase == START, 'A reserved macro-step cannot be truncated.'
            return Q(0)
        if phase == START and remaining < 3:
            diagnostics["terminal_filler_states"] += 1
            # The policy ends with deterministic price-zero queries.
            return remaining * v
        if depth < D:
            diagnostics["interior_query_states"] += 1
        if phase == LEAF_SECOND:
            diagnostics["leaf_second_query_states"] += 1
        price_branches = branches(depth, index, phase, counter)
        assert sum((prob for prob, _, _ in price_branches), Q(0)) == 1
        honest, attacked = Q(0), Q(0)
        for prob, price, continuation in price_branches:
            assert 0 <= price <= 1
            truth = int(price <= v)
            regret = v - price * truth
            assert 0 <= regret <= 1
            honest += prob * (regret + value(remaining - 1, budget, *continuation(truth)))
            if budget:
                best_report = max(value(remaining - 1, budget - 1, *continuation(0)),
                                  value(remaining - 1, budget - 1, *continuation(1)))
                attacked += prob * (regret + best_report)
        # The maximum is outside the coin expectation: the flag is predictable.
        return max(honest, attacked) if budget else honest

    tic = time.monotonic()
    regret = value(T, C, 0, 0, START, ())
    h_decimal = T if T <= a else float(a) * (1 + math.log(T / float(a)))
    bound_decimal = 11 * C + 3 * D + h_decimal + 5
    return {
        'algorithm': 'partial_decrement_persistent_macro_filler_v1',
        'T': T, 'C': C, 'v': str(v), 'a': str(a), 'D': D,
        'expected_regret': str(regret),
        'expected_regret_decimal': float(regret),
        'theorem_bound_expression': f'11*{C}+3*{D}+h_{a}({T})+5',
        'theorem_bound_decimal': bound_decimal,
        'within_bound_numeric': float(regret) <= bound_decimal,
        'bound_comparison_is_numerical_not_proof': True,
        'states': value.cache_info().currsize,
        'state_diagnostics': diagnostics,
        'seconds': time.monotonic() - tic,
        'attack_timing': 'flag_before_coin_report_after_price',
        'counter_update': 'only_current_leaf_partial_decrement_others_persist',
        'horizon_rule': 'start_macro_iff_remaining_at_least_3_else_post_zero',
    }


if __name__ == '__main__':
    ap = argparse.ArgumentParser()
    ap.add_argument('--T', type=int, default=32)
    ap.add_argument('--C', type=int, default=2)
    ap.add_argument('--v', default='3/8')
    ap.add_argument('--a', default='8')
    args = ap.parse_args()
    print(json.dumps(solve(args.T, args.C, Q(args.v), Q(args.a)), indent=2))
