#!/usr/bin/env python3
"""Independent finite-matrix checks for the separable-initialization theorem.

The all-m theorem is proved in the manuscript, not by this finite calculation.
This script constructs original edge-spin stars at M=2,4 and a Clifford
representation at m=1,...,6. It uses physical auxiliary Majoranas, including a
spectator when needed, and fixes auxiliary fermion parity. Time evolution is
computed independently by scipy.sparse.linalg.expm_multiply.

Run from any directory. Requires Python >=3.11, NumPy and SciPy. Failures cause
nonzero exit status. The output identifies the exact script SHA-256 and seed.
"""
from __future__ import annotations

import hashlib
import itertools
import json
import platform
import sys
from pathlib import Path

import numpy as np
import scipy
from scipy import sparse
from scipy.sparse.linalg import eigsh, expm_multiply, norm as sparse_norm

SEED = 2026112407
TOL = 5e-10
ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "results"

# Gaussian integers: these operations do not use floating-point arithmetic.
GI = tuple[int, int]
Word = tuple[int, ...]
Op = dict[Word, GI]
ZERO: GI = (0, 0)
ONE: GI = (1, 0)
IMAG: GI = (0, 1)


def gmul(a: GI, b: GI) -> GI:
    return (a[0] * b[0] - a[1] * b[1], a[0] * b[1] + a[1] * b[0])


def add(*ops: Op) -> Op:
    out: Op = {}
    for op in ops:
        for word, value in op.items():
            old = out.get(word, ZERO)
            out[word] = (old[0] + value[0], old[1] + value[1])
    return {word: value for word, value in out.items() if value != ZERO}


def scale(op: Op, c: GI) -> Op:
    return {word: gmul(c, value) for word, value in op.items() if gmul(c, value) != ZERO}


def multiply(a: Op, b: Op) -> Op:
    # Alphabet: I=0, X=1, Y=2, Z=3.
    table = {(1, 2): (3, 1), (2, 3): (1, 1), (3, 1): (2, 1),
             (2, 1): (3, -1), (3, 2): (1, -1), (1, 3): (2, -1)}
    terms: list[Op] = []
    for wa, ca in a.items():
        for wb, cb in b.items():
            coeff = gmul(ca, cb)
            result = []
            for x, y in zip(wa, wb, strict=True):
                if x == 0:
                    result.append(y)
                elif y == 0:
                    result.append(x)
                elif x == y:
                    result.append(0)
                else:
                    letter, sign = table[(x, y)]
                    result.append(letter)
                    coeff = gmul(coeff, (0, sign))
            terms.append({tuple(result): coeff})
    return add(*terms)


def word_op(letters: list[int] | Word) -> Op:
    return {tuple(letters): ONE}


def kron_symbolic(a: Op, b: Op) -> Op:
    return {wa + wb: gmul(ca, cb) for wa, ca in a.items() for wb, cb in b.items()}


def majorana_words(n_qubits: int) -> list[Op]:
    return [word_op([3] * j + [letter] + [0] * (n_qubits - j - 1))
            for j in range(n_qubits) for letter in (1, 2)]


def original_words(m: int) -> tuple[list[Op], list[Op], int]:
    edges = list(itertools.combinations(range(2 * m), 2))
    positions = {edge: i for i, edge in enumerate(edges)}
    stars = []
    for a in range(2 * m):
        letters = [0] * len(edges)
        for b in range(2 * m):
            if a != b:
                letters[positions[tuple(sorted((a, b)))]] = 3 if b < a else 1
        stars.append(word_op(letters))
    sy = []
    for r in range(m):
        letters = [0] * len(edges)
        letters[positions[(2 * r, 2 * r + 1)]] = 2
        sy.append(word_op(letters))
    return stars, sy, len(edges)


def exact_original_checks(m: int) -> dict:
    stars, sy, n_b = original_words(m)
    ident_b = word_op([0] * n_b)
    bt = [add(stars[2*r], stars[2*r+1]) for r in range(m)]
    rt = [scale(multiply(bt[r], sy[r]), IMAG) for r in range(m)]
    q = m // 2
    majors = majorana_words(q + 1)
    charge = [scale(multiply(majors[0], majors[r+1]), IMAG) for r in range(m)]
    hb = add(*stars)
    hc = add(*(kron_symbolic(sy[r], charge[r]) for r in range(m)))
    ident_joint = word_op([0] * (n_b + q + 1))
    checks: list[bool] = [multiply(hb, hb) == scale(ident_b, (2*m, 0)),
                          multiply(hc, hc) == scale(ident_joint, (m, 0))]
    for p in stars:
        checks.append(multiply(p, p) == ident_b)
    for p, z in itertools.combinations(stars, 2):
        checks.append(add(multiply(p, z), multiply(z, p)) == {})
    for p in bt + rt:
        checks.append(multiply(p, p) == scale(ident_b, (2, 0)))
    for p, z in itertools.combinations(bt + rt, 2):
        checks.append(add(multiply(p, z), multiply(z, p)) == {})
    for r in range(m):
        # [H_B,Y_r] = -2 i Rtilde_r, no square roots in this test.
        lhs = add(multiply(hb, sy[r]), scale(multiply(sy[r], hb), (-1, 0)))
        checks.append(lhs == scale(rt[r], (0, -2)))
    if not all(checks):
        raise AssertionError(f"exact Gaussian-integer Pauli algebra failed at M={2*m}")
    return {"M": 2*m, "physical_battery_qubits": n_b,
            "arithmetic": "Gaussian integers in a Pauli-word algebra",
            "checks": len(checks), "all_passed": True}


P_SINGLE = [sparse.csr_matrix(a, dtype=complex) for a in
            (np.eye(2), [[0, 1], [1, 0]], [[0, -1j], [1j, 0]], [[1, 0], [0, -1]])]


def matrix(op: Op) -> sparse.csr_matrix:
    n = len(next(iter(op)))
    out = sparse.csr_matrix((2**n, 2**n), dtype=complex)
    for word, (re, im) in op.items():
        piece = sparse.csr_matrix([[1.0 + 0j]])
        for letter in word:
            piece = sparse.kron(piece, P_SINGLE[letter], format="csr")
        out += (re + 1j*im) * piece
    return out


def normalize(v: np.ndarray) -> np.ndarray:
    length = np.linalg.norm(v)
    if not np.isfinite(length) or length < 1e-12:
        raise AssertionError("zero or numerically singular projected vector")
    return v / length


def random_vector(rng: np.random.Generator, d: int) -> np.ndarray:
    return rng.normal(size=d) + 1j*rng.normal(size=d)


def expect(v: np.ndarray, op: sparse.spmatrix) -> float:
    value = np.vdot(v, op @ v)
    if abs(value.imag) > TOL:
        raise AssertionError("nonreal Hermitian expectation")
    return float(value.real)


def gamma(vectors: list[np.ndarray], weights: np.ndarray,
          ops: list[sparse.csr_matrix]) -> np.ndarray:
    m = len(ops)
    out = np.zeros((m, m))
    for r in range(m):
        for s in range(r + 1, m):
            value = sum(float(w)*np.vdot(v, 1j*ops[r] @ (ops[s] @ v))
                        for v, w in zip(vectors, weights, strict=True))
            if abs(value.imag) > TOL:
                raise AssertionError("nonreal covariance entry")
            out[r, s] = value.real
            out[s, r] = -value.real
    return out


def verify_case(m: int, original: bool, rng: np.random.Generator) -> dict:
    q = m // 2
    if original:
        stars, y_words, nb = original_words(m)
        hb = matrix(add(*stars))
        b = [matrix(add(stars[2*r], stars[2*r+1])) / np.sqrt(2) for r in range(m)]
        sy = [matrix(w) for w in y_words]
    else:
        nb = m
        gs = [matrix(w) for w in majorana_words(m)]
        b = gs[::2]
        sy = [matrix(word_op([0]*r + [3] + [0]*(m-r-1))) for r in range(m)]
        hb = np.sqrt(2)*sum(b)
    # R_r = i B_r Y_r. (Y_r is represented by Z_r in the compressed model.)
    rr = [1j*b[r] @ sy[r] for r in range(m)]
    ma = [matrix(w) for w in majorana_words(q+1)]
    aa = [1j*ma[0] @ ma[r+1] for r in range(m)]
    db, da = 2**nb, 2**(q+1)
    ib, ia = sparse.eye(db, dtype=complex, format="csr"), sparse.eye(da, dtype=complex, format="csr")
    ident = sparse.eye(db*da, dtype=complex, format="csr")
    parity = matrix(word_op([3]*(q+1)))
    g = hb / np.sqrt(2*m)
    pm, pp = (ib-g)/2, (ib+g)/2
    hc = sum(sparse.kron(sy[r], aa[r], format="csr") for r in range(m))
    hbj = sparse.kron(hb, ia, format="csr")
    kappa = sum(sparse.kron(rr[r], aa[r], format="csr") for r in range(m))
    k2 = kappa @ kappa
    pg = sparse.kron(pm, ia, format="csr")
    offblock = sparse.kron(pp, ia, format="csr") @ hc @ pg
    power_op = 1j*(hc @ hbj - hbj @ hc)
    residuals: dict[str, float] = {}
    residuals["HB_square"] = float(sparse_norm(hb @ hb - 2*m*ib))
    residuals["HC_square"] = float(sparse_norm(hc @ hc - m*ident))
    residuals["offblock"] = float(sparse_norm(offblock + 1j/np.sqrt(m)*kappa @ pg))
    residuals["TdagT"] = float(sparse_norm(offblock.getH() @ offblock - pg @ k2 @ pg/m))
    residuals["current_operator"] = float(sparse_norm(power_op + 2*np.sqrt(2)*kappa))
    residuals["auxiliary_parity_commutator"] = max(float(sparse_norm(a @ parity-parity @ a)) for a in aa)

    # Explicit maximizing ground-space projector; no appeal to random search.
    pb = pm.copy()
    for j in range(q):
        pb = pb @ (ib + 1j*rr[2*j] @ rr[2*j+1])/2
    rank_b = float(pb.diagonal().sum().real)
    residuals["battery_projector_idempotence"] = float(sparse_norm(pb @ pb-pb))
    residuals["battery_projector_trace"] = abs(rank_b-2**(nb-q-1))
    psi = normalize(pb @ random_vector(rng, db))
    residuals["saturator_ground"] = float(np.linalg.norm(hb @ psi+np.sqrt(2*m)*psi))
    peak_theory = 2*np.sqrt(2)*(1+2*q/m)
    parity_records = []
    for parity_sign in (-1, 1):
        pa = (ia+parity_sign*parity)/2
        for j in range(q):
            pa = pa @ (ia-1j*aa[2*j] @ aa[2*j+1])/2
        residuals[f"aux_projector_trace_{parity_sign}"] = abs(float(pa.diagonal().sum().real)-1)
        phi = normalize(pa @ random_vector(rng, da))
        residuals[f"aux_parity_{parity_sign}"] = float(np.linalg.norm(parity @ phi-parity_sign*phi))
        v = np.kron(psi, phi)
        kval = expect(v, k2)
        evolved = expm_multiply(-1j*np.pi/(4*np.sqrt(m))*hc, v)
        peak = expect(evolved, power_op)
        residuals[f"peak_value_{parity_sign}"] = abs(peak-peak_theory)
        residuals[f"K2_saturation_{parity_sign}"] = abs(kval-(m+2*q))
        parity_records.append({"parity": parity_sign, "K2_expectation": kval,
                               "peak_power": peak, "peak_theory": float(peak_theory)})

    # Random mixed product states. Each battery constituent is an arbitrary
    # ground-projected vector; auxiliary constituents have fixed parity.
    trials = 12
    least_slack = float("inf")
    largest_cov_norm = 0.0
    cov_identity_error = 0.0
    waveform_error = 0.0
    covariance_rank_bound_error = 0.0
    ensembles = []
    for trial in range(trials):
        bvec = [normalize(pm @ random_vector(rng, db)) for _ in range(2)]
        sign = 1 if trial % 2 else -1
        ppar = (ia+sign*parity)/2
        avec = [normalize(ppar @ random_vector(rng, da)) for _ in range(2)]
        wb, wa = rng.dirichlet([1, 1]), rng.dirichlet([1, 1])
        ensemble = [(float(wb[i]*wa[j]), np.kron(bvec[i], avec[j]))
                    for i in range(2) for j in range(2)]
        ensembles.append(ensemble)
        kval = sum(w*expect(v, k2) for w, v in ensemble)
        gb, ga = gamma(bvec, wb, rr), gamma(avec, wa, aa)
        formula = m-float(np.sum(gb*ga))
        cov_identity_error = max(cov_identity_error, abs(kval-formula))
        largest_cov_norm = max(largest_cov_norm, float(np.linalg.norm(gb, 2)), float(np.linalg.norm(ga, 2)))
        covariance_rank_bound_error = max(covariance_rank_bound_error,
                                         max(0.0, float(np.sum(gb**2))-2*q),
                                         max(0.0, float(np.sum(ga**2))-2*q))
        least_slack = min(least_slack, m+2*q-kval)
        if trial < 3:
            for theta in (0.0, 0.13, 0.41, np.pi/4, 1.23, np.pi/2):
                t = theta/np.sqrt(m)
                ev = [(w, expm_multiply(-1j*t*hc, v)) for w, v in ensemble]
                energy = sum(w*expect(v, hbj) for w, v in ev)
                power = sum(w*expect(v, power_op) for w, v in ev)
                target_e = -np.sqrt(2*m)+2*np.sqrt(2*m)*kval/m**2*np.sin(theta)**2
                target_p = 2*np.sqrt(2)/m*kval*np.sin(2*theta)
                waveform_error = max(waveform_error, abs(energy-target_e), abs(power-target_p))
    residuals["mixed_product_covariance_identity"] = cov_identity_error
    residuals["mixed_product_waveform"] = waveform_error
    residuals["covariance_contraction"] = max(0.0, largest_cov_norm-1)
    residuals["covariance_rank_bound"] = covariance_rank_bound_error
    residuals["product_bound_violation"] = max(0.0, -least_slack)

    # A separable state that need not itself factor as a product of marginals.
    sep_weights = rng.dirichlet(np.ones(trials))
    sep_kval = sum(float(weight)*sum(w*expect(v, k2) for w, v in ens)
                   for weight, ens in zip(sep_weights, ensembles, strict=True))
    residuals["separable_bound_violation"] = max(0.0, sep_kval-m-2*q)

    # Positive control: permit battery--auxiliary entanglement, but still
    # project into the battery ground sector and fixed auxiliary parity.
    ppaux = sparse.kron(ib, (ia+parity)/2, format="csr")
    projector = pg @ ppaux
    target = projector @ k2 @ projector
    value, vector = eigsh(target, k=1, which="LA", v0=random_vector(rng, db*da), tol=1e-12)
    joint = normalize(projector @ vector[:, 0])
    joint_ev = expm_multiply(-1j*np.pi/(4*np.sqrt(m))*hc, joint)
    joint_peak = expect(joint_ev, power_op)
    residuals["joint_K2_eigenvalue"] = abs(float(value[0])-m*m)
    residuals["joint_ground_peak"] = abs(joint_peak-2*np.sqrt(2)*m)
    max_residual = max(residuals.values())
    if not np.isfinite(max_residual) or max_residual > TOL:
        raise AssertionError(f"m={m}, original={original}, residuals={residuals}")
    return {"representation": "original_edge_spin_stars" if original else "Clifford_compression",
            "m": m, "M": 2*m, "battery_qubits": nb, "auxiliary_fermion_modes": q+1,
            "joint_Hilbert_dimension": db*da, "battery_saturator_projector_rank": rank_b,
            "parity_saturators": parity_records, "random_mixed_product_trials": trials,
            "separable_mixture_components": 4*trials,
            "random_product_minimum_K2_slack": least_slack,
            "largest_sampled_covariance_operator_norm": largest_cov_norm,
            "joint_entangled_control_peak": joint_peak,
            "residuals": residuals, "max_residual": max_residual, "passed": True}


def main() -> None:
    OUT.mkdir(exist_ok=True)
    rng = np.random.default_rng(SEED)
    exact = [exact_original_checks(m) for m in (1, 2)]
    cases = [verify_case(m, True, rng) for m in (1, 2)]
    cases += [verify_case(m, False, rng) for m in range(1, 7)]
    report = {"status": "PASS", "scope": "finite exact Pauli algebra plus numerical sanity checks; not an all-m formal proof",
              "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
              "seed": SEED, "tolerance": TOL,
              "environment": {"python": platform.python_version(), "numpy": np.__version__, "scipy": scipy.__version__},
              "exact_original_Pauli_checks": exact, "numerical_cases": cases,
              "max_residual": max(c["max_residual"] for c in cases)}
    (OUT / "numerical_verification.json").write_text(json.dumps(report, indent=2)+"\n")
    lines = ["Independent quantum-battery verification: PASS",
             f"Seed: {SEED}; tolerance: {TOL:g}",
             f"Python {platform.python_version()}, NumPy {np.__version__}, SciPy {scipy.__version__}",
             "Exact source-model algebra: Gaussian-integer Pauli words, M=2 and M=4.",
             "Physical auxiliary parity: both signs tested; all saturator projectors have trace one.",
             "Time evolution: independent scipy expm_multiply; mixed products and separable mixtures included."]
    for check in exact:
        lines.append(f"  exact M={check['M']}: {check['checks']} identities PASS")
    for case in cases:
        lines.append(f"  {case['representation']} m={case['m']}, dim={case['joint_Hilbert_dimension']}: "
                     f"P_sep={case['parity_saturators'][0]['peak_power']:.12g}, "
                     f"P_joint={case['joint_entangled_control_peak']:.12g}, "
                     f"max residual={case['max_residual']:.3e}")
    lines.append("Finite checks do not substitute for the manuscript's all-m proof.")
    log = "\n".join(lines)+"\n"
    (OUT / "numerical_run.log").write_text(log)
    print(log, end="")


if __name__ == "__main__":
    try:
        main()
    except Exception as exc:
        OUT.mkdir(exist_ok=True)
        (OUT / "numerical_run.log").write_text(f"FAIL: {type(exc).__name__}: {exc}\n")
        raise
