#!/usr/bin/env python3
"""Plot the proved exponent rate and high-order interior prior scale.

This is a theorem-derived illustration for a fixed BSC with p=0.1.
It does not display finite-blocklength data or the lattice first-order
prefactors. Numerical root solving evaluates the proved inverse-Renyi
characterization; it is not an independent proof of the characterization.
"""
from __future__ import annotations

import argparse
import json
import math
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
import scipy
from scipy.optimize import brentq


def bsc_parameters(p: float) -> dict[str, float]:
    if not 0.0 < p < 0.5:
        raise ValueError("The illustration requires 0 < p < 1/2.")
    m = math.log((1.0 - p) / p)
    return {
        "p": p,
        "M": m,
        "D": (1.0 - 2.0 * p) * m,
        "C": -math.log(2.0 * math.sqrt(p * (1.0 - p))),
        "ell": -math.log1p(-p),
    }


def psi(s: float, p: float, m: float) -> float:
    # Under P: Y=log(Q/P) equals -M with probability 1-p, and +M with p.
    return float(np.logaddexp(math.log1p(-p) - s * m, math.log(p) + s * m))


def exponent_rate(r: float, p: float, m: float, d: float) -> float:
    """The proved E(r), extended continuously to r=0 for plotting."""
    if r < 0.0:
        raise ValueError("r must be nonnegative.")
    if r < d:
        theta = 0.5 - math.atanh(r / m) / m
        rate_i = -theta * r - psi(theta, p, m)
        return r + rate_i
    return r if r <= m else m


def interior_point(r: float, p: float, m: float, d: float, ell: float):
    """Evaluate beta and u for the strict interior D < r < M."""
    if not d < r < m:
        raise ValueError("The interior prior scale is defined here only for D < r < M.")

    def renyi(beta: float) -> float:
        if beta == 0.0:
            return d
        # psi(-beta)/beta = M + log(1-p+p exp(-2 beta M))/beta.
        # expm1/log1p avoid subtracting nearly equal numbers when beta is small.
        return m + math.log1p(p * math.expm1(-2.0 * beta * m)) / beta

    upper = 2.0 * ell / (m - r)
    beta = brentq(
        lambda x: renyi(x) - r,
        0.0,
        upper,
        xtol=1e-14,
        rtol=8.0 * np.finfo(float).eps,
        maxiter=200,
    )
    minus_psi_prime = m * math.tanh(m * (beta + 0.5))
    u = minus_psi_prime - r
    equation_residual = psi(-beta, p, m) - r * beta
    return beta, u, equation_residual


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--out-dir",
        type=Path,
        default=Path(__file__).resolve().parents[1] / "results",
    )
    args = parser.parse_args()
    args.out_dir.mkdir(parents=True, exist_ok=True)

    par = bsc_parameters(0.1)
    p, m, d, c, ell = (par[k] for k in ("p", "M", "D", "C", "ell"))
    d_scaled = d / m
    domains = [
        ("below_kl", np.linspace(0.0, d_scaled, 321)),
        ("kl_to_endpoint", np.linspace(d_scaled, 1.0, 101)),
        ("above_endpoint", np.linspace(1.0, 1.25, 101)),
    ]
    left_data = []
    for name, rr in domains:
        ee = np.array([exponent_rate(float(x) * m, p, m, d) / m for x in rr])
        left_data.append(
            {
                "region": name,
                "r_over_M": rr.tolist(),
                "E_over_M": ee.tolist(),
            }
        )

    interior_r = np.linspace(d_scaled + 1e-5, 1.0 - 1e-5, 401)
    interior = [
        interior_point(float(x) * m, p, m, d, ell) for x in interior_r
    ]
    beta_values = np.array([x[0] for x in interior])
    u_values = np.array([x[1] for x in interior])
    residuals = np.array([x[2] for x in interior])
    if not np.all(u_values > 0.0):
        raise ArithmeticError("A nonpositive interior prior scale was produced.")
    # The theoretical upper bound is strict. At very large beta, floating
    # tanh rounds to one, so permit roundoff equality in this numerical check.
    upper_u = m * (1.0 - interior_r)
    if np.any(u_values > upper_u + 2e-14):
        raise ArithmeticError("An interior scale exceeded M-r.")
    if float(np.max(np.abs(residuals))) > 2e-10:
        raise ArithmeticError("The inverse-Renyi root residual is too large.")

    plt.rcParams.update(
        {
            "font.family": "DejaVu Sans",
            "font.size": 10,
            "axes.titlesize": 12,
            "axes.labelsize": 10.5,
            "axes.spines.top": False,
            "axes.spines.right": False,
            "axes.linewidth": 0.8,
            "xtick.direction": "out",
            "ytick.direction": "out",
            "figure.facecolor": "white",
            "axes.facecolor": "white",
            "savefig.facecolor": "white",
            "pdf.fonttype": 42,
            "ps.fonttype": 42,
        }
    )
    fig, axes = plt.subplots(1, 2, figsize=(10.8, 4.7))
    fig.subplots_adjust(left=0.075, right=0.978, top=0.82, bottom=0.23, wspace=0.27)
    fig.suptitle(
        r"BSC $p=0.1$: exponent rate and optimal interior prior scale",
        x=0.075,
        y=0.965,
        ha="left",
        fontsize=14,
        fontweight="semibold",
    )
    fig.text(
        0.075,
        0.895,
        rf"$C={c:.6f}$,  $D={d:.6f}$,  $M={m:.6f}$ nats",
        fontsize=10,
        color="#475569",
    )

    ax = axes[0]
    colors = ["#2457A7", "#12806A", "#B97112"]
    labels = [r"$0<r<D$", r"$D\leq r\leq M$", r"$r>M$"]
    for series, color, label in zip(left_data, colors, labels):
        ax.plot(series["r_over_M"], series["E_over_M"], color=color, lw=2.3, label=label)
    ax.axvline(d_scaled, color="#94A3B8", lw=0.8, ls=(0, (3, 3)), zorder=0)
    ax.axvline(1.0, color="#94A3B8", lw=0.8, ls=(0, (3, 3)), zorder=0)
    ax.scatter(
        [0.0, d_scaled, 1.0],
        [c / m, d_scaled, 1.0],
        s=26,
        color=["#2457A7", "#12806A", "#B97112"],
        edgecolors="white",
        linewidths=0.7,
        zorder=5,
        clip_on=False,
    )
    ax.annotate(r"$C/M$", (0.0, c / m), xytext=(10, 5), textcoords="offset points")
    ax.annotate(r"$D$", (d_scaled, d_scaled), xytext=(-14, 10), textcoords="offset points")
    ax.annotate(r"$M$", (1.0, 1.0), xytext=(-6, 10), textcoords="offset points")
    ax.set(xlim=(0.0, 1.25), ylim=(0.0, 1.12))
    ax.set_xlabel(r"Order growth rate $r/M$")
    ax.set_ylabel(r"Deficit exponent $E(r)/M$")
    ax.set_title("(a) Theorem exponent rate", loc="left", pad=10)
    ax.grid(axis="y", color="#E2E8F0", lw=0.7)
    ax.legend(loc="lower right", frameon=False, fontsize=9)

    ax = axes[1]
    ax.plot(interior_r, u_values, color="#6546A1", lw=2.3)
    ax.set_xlim(d_scaled, 1.0)
    ax.set_ylim(0.0, float(np.max(u_values)) * 1.13)
    ax.set_xlabel(r"Order growth rate $r/M$")
    ax.set_ylabel(r"$u(r)=\lim_{n\to\infty}U_n/n$  (nats)")
    ax.set_title(r"(b) Optimal prior scale, $D<r<M$", loc="left", pad=10)
    ax.set_xticks([d_scaled, 0.85, 0.9, 0.95, 1.0])
    ax.set_xticklabels(["0.80\n" + r"$D/M$", "0.85", "0.90", "0.95", "1.00\n" + r"$M/M$"])
    ax.grid(axis="y", color="#E2E8F0", lw=0.7)
    ax.text(
        0.98,
        0.98,
        r"$D_{1+\beta}(P\Vert Q)=r$" + "\n" + r"$u(r)=-\psi'(-\beta)-r$",
        transform=ax.transAxes,
        ha="right",
        va="top",
        fontsize=9.2,
        color="#4C3578",
    )

    fig.text(
        0.075,
        0.075,
        r"Theorem-derived asymptotic quantities for $b_n=\alpha_n-1=e^{nr}$."
        "\nBSC is arithmetic: lattice first-order prefactors are not shown. The right panel uses only the strict interior.",
        fontsize=8.6,
        color="#475569",
        va="bottom",
        linespacing=1.5,
    )
    png = args.out_dir / "phase_diagram.png"
    pdf = args.out_dir / "phase_diagram.pdf"
    fig.savefig(png, dpi=220)
    fig.savefig(pdf)
    plt.close(fig)

    data = {
        "schema_version": 1,
        "kind": "theorem_derived_rate_and_prior_scale_illustration",
        "channel": "BSC(p=0.1)",
        "logarithms": "natural",
        "parameters": par,
        "scope": {
            "left": "E(r)/M against r/M for b_n=exp(nr); r=0 is the continuous fixed-order exponent endpoint.",
            "right": "Exact limiting prior scale u(r), evaluated numerically from the proved inverse-Renyi characterization, only for D<r<M.",
            "arithmetic_channel": True,
            "lattice_prefactors_included": False,
            "finite_blocklength_data_included": False,
            "new_theorem_or_independent_proof": False,
        },
        "formulas": {
            "psi": "log[(1-p) exp(-s M)+p exp(s M)]",
            "E_below_KL": "r+I(-r)=r-r theta-psi(theta), theta=1/2-atanh(r/M)/M",
            "E_KL_to_M": "r",
            "E_above_M": "M",
            "interior_beta": "unique positive root psi(-beta)=r beta",
            "interior_u": "-psi'(-beta)-r",
        },
        "left": left_data,
        "right": {
            "r_over_M": interior_r.tolist(),
            "r": (interior_r * m).tolist(),
            "beta": beta_values.tolist(),
            "u": u_values.tolist(),
            "root_equation_residual": residuals.tolist(),
        },
        "numerical_checks": {
            "interior_samples": len(interior),
            "all_u_positive": bool(np.all(u_values > 0)),
            "all_u_at_most_M_minus_r_up_to_roundoff": bool(np.all(u_values <= upper_u + 2e-14)),
            "max_absolute_root_equation_residual": float(np.max(np.abs(residuals))),
            "not_a_formal_certificate": True,
        },
        "software_versions": {
            "numpy": np.__version__,
            "scipy": scipy.__version__,
            "matplotlib": matplotlib.__version__,
        },
    }
    json_path = args.out_dir / "phase_diagram_data.json"
    json_path.write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({
        "outputs": [str(png), str(pdf), str(json_path)],
        "parameters": par,
        "max_root_residual": data["numerical_checks"]["max_absolute_root_equation_residual"],
    }, indent=2))


if __name__ == "__main__":
    main()
