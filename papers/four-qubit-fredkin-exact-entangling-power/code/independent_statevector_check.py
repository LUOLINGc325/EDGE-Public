#!/usr/bin/env python3
"""Independent finite checks using the complete eight-qubit state vector.

Factor order: A,R_A,B,R_B,C,R_C,D,R_D.  The physical gate is applied as a
256-element basis permutation; reduced states are obtained by a partial trace.
No symbolic polynomial or Bernstein-certificate code is imported.  Floating
point checks are diagnostic and do not prove the universal optimization theorem.
"""
from __future__ import annotations

import argparse
import json
import math
from pathlib import Path

import numpy as np

SEED = 20261124
TOL = 2e-10


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def normalized(v):
    v = np.asarray(v, dtype=complex)
    return v / np.linalg.norm(v)


def random_party(rng):
    return normalized(rng.normal(size=4) + 1j * rng.normal(size=4))


def control(p):
    return np.array([math.sqrt(1-p), 0, math.sqrt(p), 0], dtype=complex)


def schmidt_party(c):
    return np.array([math.sqrt(c), 0, 0, math.sqrt(1-c)], dtype=complex)


def density_of_party(v):
    m = v.reshape(2, 2)
    return m @ m.conj().T


def purification(rho):
    eig, vec = np.linalg.eigh(rho)
    require(eig.min() > -TOL, 'Nonpositive density matrix in purification')
    m = (vec * np.sqrt(np.maximum(eig, 0))) @ vec.conj().T
    return normalized(m.reshape(4))


def fredkin_output(parties):
    initial = np.array([1.0 + 0.0j])
    for v in parties:
        require(abs(float(np.vdot(v, v).real) - 1) < TOL,
                'Input party is not normalized')
        initial = np.kron(initial, v)
    result = np.empty(256, dtype=complex)
    # A and B are the first and third physical factors, C and D the fifth
    # and seventh factors; their ancillas remain exactly where they were.
    for i, amplitude in enumerate(initial):
        bits = [(i >> (7-j)) & 1 for j in range(8)]
        if bits[0] == 1 and bits[2] == 1:
            bits[4], bits[6] = bits[6], bits[4]
        destination = sum(bit << (7-j) for j, bit in enumerate(bits))
        result[destination] = amplitude
    require(abs(float(np.vdot(result, result).real) - 1) < TOL,
            'Gate did not preserve the norm')
    return result


def reduced_spectrum(output, left_parties=(0, 3)):
    left_axes = [axis for party in left_parties for axis in (2*party, 2*party+1)]
    other_axes = [axis for axis in range(8) if axis not in left_axes]
    matrix = output.reshape([2]*8).transpose(left_axes + other_axes).reshape(
        2**len(left_axes), -1)
    reduced = matrix @ matrix.conj().T
    eig = np.linalg.eigvalsh(reduced)
    require(eig.min() > -TOL, 'Partial trace acquired a negative eigenvalue')
    require(abs(float(eig.sum()) - 1) < TOL, 'Partial trace has wrong trace')
    return np.sort(np.maximum(eig, 0))[::-1]


def entropy(spectrum):
    # Values below machine noise are removed only in this diagnostic routine.
    values = spectrum[spectrum > 1e-14]
    return float(-np.sum(values * np.log2(values)))


def padded_small_spectrum(p, q, c, d):
    """Small amplitude-block prediction, checked against the full permutation."""
    alpha = np.sqrt([1-p, p])
    beta = np.sqrt([1-q, q])
    cv, dv = [c, 1-c], [d, 1-d]
    block = np.zeros((4, 4))
    for a in range(2):
        for j in range(2):
            for b in range(2):
                for i in range(2):
                    if not (a == b == 1 and i != j):
                        block[2*a+j, 2*b+i] = (
                            alpha[a]*beta[b]*math.sqrt(dv[j]*cv[i]))
    eig = np.linalg.eigvalsh(block @ block.T).tolist()
    eig += [p*q*c*(1-d), p*q*(1-c)*d]
    eig += [0.0]*(16-len(eig))
    return np.sort(np.maximum(eig, 0))[::-1]


def root_and_control():
    def g(z):
        return (math.log(z) + (1+z)*(3+z)/(2*(1-2*z))
                * math.log1p(2*z/(1-z))/z)
    lo, hi = 1e-9, .1
    require(g(lo) < 0 < g(hi), 'Scalar root bracket failed')
    for _ in range(75):
        mid = (lo+hi)/2
        if g(mid) > 0:
            hi = mid
        else:
            lo = mid
    z = (lo+hi)/2
    return z, 2*(1-z)/(z*z-z+2)


def run():
    rng = np.random.default_rng(SEED)
    z_star, s_star = root_and_control()
    max_spectrum_error = 0.0
    grid_cases = 0
    for p in (0.0, .8, s_star, 1.0):
        for q in (0.0, .8, s_star, 1.0):
            for c in (0.0, .5, 1.0):
                for d in (0.0, .5, 1.0):
                    output = fredkin_output([control(p), control(q),
                                             schmidt_party(c), schmidt_party(d)])
                    eig = reduced_spectrum(output)
                    expected = padded_small_spectrum(p, q, c, d)
                    error = float(np.max(np.abs(eig-expected)))
                    max_spectrum_error = max(max_spectrum_error, error)
                    require(error < TOL, 'Commuting-target spectrum mismatch')
                    grid_cases += 1

    # The 2026 public refutation's input, reproduced with padded |0> control
    # ancillas.  Its target purifications use a Hadamard-rotated Bell state.
    prior_a = np.array([3, 0, 20, 0], dtype=complex)/math.sqrt(409)
    prior_b = control(73/75)
    prior_target = np.array([1, 1, 1, -1], dtype=complex)/2
    prior_eig = reduced_spectrum(fredkin_output(
        [prior_a, prior_b, prior_target, prior_target]))
    prior_expected = np.array(sorted([1752/6135, 1460/6135, 1460/6135,
                                     1460/6135, 3/6135] + [0.0]*11,
                                    reverse=True))
    prior_error = float(np.max(np.abs(prior_eig-prior_expected)))
    require(prior_error < TOL, 'Published counterexample spectrum mismatch')
    require(entropy(prior_eig) > 2, 'Published counterexample entropy check failed')

    bell = schmidt_party(.5)
    optimum_output = fredkin_output([control(s_star), control(s_star), bell, bell])
    optimum_eig = reduced_spectrum(optimum_output)
    D = z_star*z_star-z_star+2
    optimum_expected = np.array(sorted([(1+z_star)**2/D**2]
        + [(1-z_star)**2/D**2]*3
        + [z_star*z_star*(1-z_star)**2/D**2] + [0.0]*11, reverse=True))
    optimum_error = float(np.max(np.abs(optimum_eig-optimum_expected)))
    require(optimum_error < TOL, 'Optimal-curve spectrum mismatch')
    require(entropy(optimum_eig) > entropy(prior_eig),
            'Candidate optimum did not improve the prior witness')
    baseline = reduced_spectrum(fredkin_output([control(1), control(1), bell, bell]))
    require(abs(entropy(baseline)-2) < TOL, 'Original two-ebit baseline failed')

    # A concrete check against an invalid shortcut: maximally mixed targets
    # need not maximize entropy when the control probabilities are fixed low.
    low_pure = reduced_spectrum(fredkin_output([
        control(.5), control(.5), schmidt_party(1), schmidt_party(0)]))
    low_mixed = reduced_spectrum(fredkin_output([
        control(.5), control(.5), bell, bell]))
    require(entropy(low_pure) > entropy(low_mixed),
            'The counterexample to a global mixed-target shortcut failed')

    gains = []
    max_twirl_spectrum_error = 0.0
    other_cut_maxima = {'A': 0.0, 'B': 0.0, 'C': 0.0, 'D': 0.0, 'AB': 0.0}
    cut_data = [('A', (0,), 1), ('B', (1,), 1), ('C', (2,), 2),
                ('D', (3,), 2), ('AB', (0,1), 1)]
    for _ in range(128):
        parties = [random_party(rng) for _ in range(4)]
        original_output = fredkin_output(parties)
        before = entropy(reduced_spectrum(original_output))
        rho_c = density_of_party(parties[2])
        rho_d = density_of_party(parties[3])
        d_eig, basis = np.linalg.eigh(rho_d)
        c_in_d_basis = basis.conj().T @ rho_c @ basis
        c_diagonal = np.real(np.diag(c_in_d_basis))
        twirled_c = basis @ np.diag(c_diagonal) @ basis.conj().T
        twirled_parties = list(parties)
        twirled_parties[2] = purification(twirled_c)
        twirled_eig = reduced_spectrum(fredkin_output(twirled_parties))
        after = entropy(twirled_eig)
        gains.append(after-before)
        require(after >= before-TOL, 'Target dephasing decreased entropy')
        p = float(np.sum(np.abs(parties[0][2:])**2))
        q = float(np.sum(np.abs(parties[1][2:])**2))
        predicted = padded_small_spectrum(p, q, float(c_diagonal[0]),
                                           float(d_eig[0]))
        error = float(np.max(np.abs(twirled_eig-predicted)))
        max_twirl_spectrum_error = max(max_twirl_spectrum_error, error)
        require(error < TOL, 'General-ancilla/twirl spectrum mismatch')
        for name, cut, bound in cut_data:
            value = entropy(reduced_spectrum(original_output, cut))
            other_cut_maxima[name] = max(other_cut_maxima[name], value)
            require(value <= bound+TOL, 'A noncrossed cut exceeded its bound')

    return {
        'status': 'passed',
        'evidence_scope': 'Finite floating-point checks only; not a proof of a universal bound.',
        'method': 'Full 256-amplitude permutation followed by partial traces; independent of polynomial certificate code.',
        'numpy_version': np.__version__, 'seed': SEED, 'tolerance': TOL,
        'commuting_boundary_and_stationary_cases': grid_cases,
        'random_complex_four_party_with_ancilla_cases': len(gains),
        'maximum_commuting_spectrum_error': max_spectrum_error,
        'maximum_twirled_spectrum_error': max_twirl_spectrum_error,
        'minimum_twirl_entropy_gain': min(gains),
        'maximum_twirl_entropy_gain': max(gains),
        'prior_counterexample_source': 'https://www.trureturing.org/research/qiu-2025-fredkin-entangling-power/',
        'prior_counterexample_spectrum_error': prior_error,
        'prior_counterexample_entropy_bits': entropy(prior_eig),
        'original_baseline_entropy_bits': entropy(baseline),
        'fixed_half_controls_pure_opposite_targets_entropy_bits': entropy(low_pure),
        'fixed_half_controls_mixed_targets_entropy_bits': entropy(low_mixed),
        'candidate_root_z': z_star, 'candidate_control_probability': s_star,
        'candidate_optimum_spectrum_error': optimum_error,
        'candidate_optimum_entropy_bits': entropy(optimum_eig),
        'noncrossed_cut_maxima_in_random_sample': other_cut_maxima,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    result = run()
    content = json.dumps(result, ensure_ascii=False, indent=2, allow_nan=False) + '\n'
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(content, encoding='utf-8')
    print(content, end='')


if __name__ == '__main__':
    main()
