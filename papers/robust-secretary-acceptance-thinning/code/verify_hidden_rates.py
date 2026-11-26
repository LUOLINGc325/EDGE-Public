"""Exact finite checks for the hidden-rate square-root boundary.

This independently enumerates permutations, offered subwords and active sets.
No floating-point probabilities, LP optimizer or proof assistant is used.
The universal statements are justified by manuscript/paper.md, Section 10,
not by finite testing. This script is not formalization code.
"""
from collections import Counter
from fractions import Fraction as F
from itertools import permutations
from math import comb, factorial
from pathlib import Path
import json


def subword(word, mask):
    return tuple(x for j, x in enumerate(word) if mask & (1 << j))


def exhaustive_lis(word, decreasing=False):
    """Independent brute-force subsequence definition, used through n=7."""
    best = 0
    for mask in range(1 << len(word)):
        w = subword(word, mask)
        if all((a > b if decreasing else a < b) for a, b in zip(w, w[1:])):
            best = max(best, len(w))
    return best


def online_colors(word):
    colors = []
    for t, rank in enumerate(word):
        colors.append(1 + max((colors[s] for s in range(t) if word[s] > rank), default=0))
    return tuple(colors)


def first_active(word, active):
    return next((rank for rank in word if active & (1 << (rank - 1))), None)


def exact_active_distribution(rates):
    """Full product distribution, including zero-mass masks for auditability."""
    for mask in range(1 << len(rates)):
        mass = F(1)
        for j, p in enumerate(rates):
            mass *= p if mask & (1 << j) else 1 - p
        yield mask, mass


def rank_selection_distribution(offer_word, rates):
    answer = [F(0)] * (len(rates) + 1)
    for active, mass in exact_active_distribution(rates):
        chosen = first_active(offer_word, active)
        if chosen is not None:
            answer[chosen] += mass
    return answer


def main():
    counts = Counter()
    lis_distributions = {}
    qs = (F(1, 3), F(1, 2), F(1))

    # Completely enumerate all order/subword pairs.  Inequality C does not
    # assume that the selected subword came from any specific policy.
    for n in range(1, 7):
        for word in permutations(range(1, n + 1)):
            lis = exhaustive_lis(word)
            for mask in range(1 << n):
                offered = subword(word, mask)
                ds = [sum(s > r for s in offered[:j]) for j, r in enumerate(offered)]
                for m in range(n):
                    assert sum(d <= m for d in ds) <= (m + 1) * lis
                    counts['subword_coloring_bounds'] += 1
                for q in qs:
                    w = 1 - q
                    weight = sum((w ** d for d in ds), F(0))
                    assert weight <= F(lis) / q
                    # Exact finite form of the infinite summation: beyond
                    # n-1 all cumulative counts equal len(offered).
                    cumulative = q * sum((w ** m * sum(d <= m for d in ds) for m in range(n)), F(0))
                    cumulative += len(offered) * w ** n
                    assert cumulative == weight
                    counts['weighted_path_bounds'] += 1
                    counts['geometric_sum_identities'] += 1

    # Directly integrate all active subsets; compare against the proposed
    # all-rejection identity, including q=1 and rank r not offered.
    for n in range(1, 6):
        for word in permutations(range(1, n + 1)):
            for mask in range(1 << n):
                offered = subword(word, mask)
                for r in range(1, n + 1):
                    d = sum(s > r for s in offered[:offered.index(r)]) if r in offered else 0
                    for q in qs:
                        rates = tuple(F(0) if i < r else q for i in range(1, n + 1))
                        direct = rank_selection_distribution(offered, rates)
                        expected = q * (1 - q) ** d if r in offered else F(0)
                        assert direct[r] == expected
                        assert sum(direct[1:r+1], F(0)) == direct[r]
                        counts['all_rejection_path_identities'] += 1

                        if n <= 4:
                            eps = q / (n * n)
                            positive = tuple(eps if i < r else q for i in range(1, n + 1))
                            direct_positive = rank_selection_distribution(offered, positive)
                            numerator = sum(direct_positive[1:r+1], F(0))
                            denominator = 1 - (1 - eps) ** (r - 1) * (1 - q)
                            assert denominator >= q
                            assert numerator <= direct[r] + (r - 1) * eps
                            assert numerator / denominator <= direct[r] / q + F(1, n)
                            counts['positive_rate_perturbations'] += 1

    # Full permutation/activation enumeration validates the online policy.
    # Every activation mask is inspected, so this part does not assume any
    # distribution or independence among active coordinates.
    for n in range(1, 8):
        hist_lis = Counter()
        hist_lds = Counter()
        # For a subset of absolute ranks and each M,k, accumulate direct
        # unnormalised top-k selection counts over permutations and colors.
        # Checking the pathwise capture suffices for all distributions.
        for word in permutations(range(1, n + 1)):
            lis = exhaustive_lis(word)
            lds = exhaustive_lis(word, decreasing=True)
            hist_lis[lis] += 1
            hist_lds[lds] += 1
            colors = online_colors(word)
            assert max(colors) == lds
            counts['online_depth_equals_bruteforce_lds'] += 1
            for color in range(1, n + 1):
                color_word = tuple(rank for rank, c in zip(word, colors) if c == color)
                assert all(a < b for a, b in zip(color_word, color_word[1:]))
                counts['same_color_increasing'] += 1
            for active in range(1, 1 << n):
                best = min(rank for rank in range(1, n + 1) if active & (1 << (rank - 1)))
                best_color = colors[word.index(best)]
                offered = tuple(rank for rank, c in zip(word, colors) if c == best_color)
                assert first_active(offered, active) == best
                counts['best_active_pathwise_captures'] += 1
                # For every truncation level satisfying the theorem's
                # good-order event, the winning color is among 1,...,M.
                for M in range(lds, n + 1):
                    assert 1 <= best_color <= M
                    counts['admissible_color_truncations'] += 1
        assert hist_lis == hist_lds
        counts['lis_lds_distribution_equalities'] += 1
        nf = factorial(n)
        for ell in range(1, n + 1):
            tail = F(sum(v for key, v in hist_lis.items() if key >= ell), nf)
            assert tail <= F(comb(n, ell), factorial(ell))
            counts['lis_union_bounds'] += 1
        mean = F(sum(k * v for k, v in hist_lis.items()), nf)
        lower_options = {str(M): str(F(sum(v for k, v in hist_lds.items() if k <= M), nf * M)) for M in range(1, n + 1)}
        lis_distributions[str(n)] = {
            'counts_by_length': {str(k): v for k, v in sorted(hist_lis.items())},
            'mean_exact': str(mean),
            'color_guarantees_by_M': lower_options,
            'best_color_guarantee': str(max(F(x) for x in lower_options.values()))
        }

    report = {
        'status': 'PASS',
        'arithmetic': 'integers and fractions.Fraction; no floating point',
        'counts': dict(counts),
        'scope': {
            'all_subwords_and_permutations': 'n=1,...,6',
            'direct_all_rejection_coin_enumeration': 'n=1,...,5; q in {1/3,1/2,1}',
            'strictly_positive_perturbation': 'n=1,...,4; epsilon=q/n^2',
            'online_coloring_all_permutations_and_nonempty_active_subsets': 'n=1,...,7',
            'limitation': 'finite checks complement, and do not replace, the universal proof'
        },
        'lis_distribution_and_exact_policy_lower_bounds': lis_distributions,
        'source': 'verify_hidden_rates.py'
    }
    output = Path(__file__).resolve().parents[1]/'results/hidden_rates_verification.json'
    output.write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({'status': report['status'], 'counts': report['counts'], 'output': str(output)}, indent=2))


if __name__ == '__main__':
    main()
