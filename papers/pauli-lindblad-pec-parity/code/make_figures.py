"""Deterministic explanatory figures from closed formulas and finite Fourier sums."""
from itertools import combinations
from pathlib import Path
import csv
import json

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np

ROOT = Path(__file__).resolve().parents[1]


def gamma(n, edges, time):
    size = 1 << n
    eigenvalues = []
    for character in range(size):
        cut = sum(((character >> u) ^ (character >> v)) & 1 for u, v in edges)
        eigenvalues.append(np.exp(2 * time * cut))
    q = np.array(eigenvalues, dtype=float)
    step = 1
    while step < size:
        for start in range(0, size, 2 * step):
            a, b = q[start:start + step].copy(), q[start + step:start + 2 * step].copy()
            q[start:start + step], q[start + step:start + 2 * step] = a + b, a - b
        step *= 2
    return np.sum(abs(q)) / size


def main():
    figures = ROOT / 'figures'
    figures.mkdir(exist_ok=True)
    plt.rcParams.update({'font.family': 'DejaVu Sans', 'font.size': 10,
                         'axes.spines.top': False, 'axes.spines.right': False})
    models = {
        'Triangle': (3, [(0, 1), (0, 2), (1, 2)], '#2563eb'),
        'Five-cycle': (5, [(0, 1), (1, 2), (2, 3), (3, 4), (0, 4)], '#0f766e'),
        'Theta (3,2,2)': (6, [(0, 1), (1, 2), (2, 5), (0, 3), (3, 5), (0, 4), (4, 5)], '#b45309'),
        'Square (bipartite)': (4, [(0, 1), (1, 2), (2, 3), (0, 3)], '#64748b'),
    }
    times = np.linspace(0, 0.8, 161)
    fig, axes = plt.subplots(1, 2, figsize=(10.8, 4.0), layout='constrained')
    rows = []
    for name, (n, edges, color) in models.items():
        costs = np.array([gamma(n, edges, float(t)) for t in times])
        factorized = np.exp(2 * len(edges) * times)
        ratios = (costs / factorized) ** 2
        axes[0].plot(times, ratios, color=color, label=name, lw=2)
        if 'Square' not in name:
            small_times = np.geomspace(0.0008, 0.06, 90)
            differences = np.array([np.exp(2 * len(edges) * t) - gamma(n, edges, float(t)) for t in small_times])
            axes[1].loglog(small_times, differences, color=color, lw=2, label=name)
            order, coefficient = (2, 6) if name == 'Triangle' else (3, 20) if name == 'Five-cycle' else (3, 38)
            axes[1].loglog(small_times, coefficient * small_times ** order, color=color, ls='--', lw=1)
        for t, g, f, ratio in zip(times, costs, factorized, ratios):
            rows.append([name, format(t, '.12g'), format(g, '.16g'), format(f, '.16g'), format(ratio, '.16g')])
    axes[0].set(xlabel='Noise time t (unit edge rates)', ylabel='Optimal / factorized squared cost',
                title='Exact model: sampling-cost reduction', ylim=(-0.02, 1.05))
    axes[1].set(xlabel='Noise time t (unit edge rates)', ylabel='Factorized cost minus optimal cost',
                title='Weak-noise law and leading term')
    for ax in axes:
        ax.grid(alpha=.2)
    axes[0].legend(frameon=False, loc='lower left', fontsize=9)
    axes[1].text(.05, .95, 'Solid: Fourier formula\nDashed: 6t², 20t³, 38t³',
                 transform=axes[1].transAxes, va='top', fontsize=9)
    fig.savefig(figures / 'pec_topology.png', dpi=190)
    fig.savefig(figures / 'pec_topology.pdf')
    plt.close(fig)
    with (ROOT / 'results' / 'figure_data.csv').open('w', newline='') as handle:
        writer = csv.writer(handle)
        writer.writerow(['model', 'time', 'gamma_opt', 'gamma_factorized', 'squared_cost_ratio'])
        writer.writerows(rows)
    (ROOT / 'results' / 'figure_metadata.json').write_text(json.dumps({
        'source': 'Analytic finite Fourier formula; illustrative floating point curves',
        'unit_edge_rates': True, 'hardware_measurements': False,
        'models': list(models), 'data_rows': len(rows), 'matplotlib': matplotlib.__version__,
    }, indent=2) + '\n')
    print('Wrote figures/pec_topology.png, figures/pec_topology.pdf and 644 data rows.')


if __name__ == '__main__':
    main()
