# Reproducing the majority cross-validation calculations

Run these commands from this directory with Python 3.12. The exact calculation uses the Python standard library. The numerical calculation uses NumPy 2.3.5 and SciPy 1.17.0.

```sh
python3 code/exact_checks.py
python3 -m pip install numpy==2.3.5 scipy==1.17.0
python3 code/phase_diagnostics.py --output results/phase_diagnostics.json
```

The [exact results](results/exact_checks.json) cover small label samples, parity and tie cases, and conditional covariance. The [numerical results](results/phase_diagnostics.json) cover finite transition-window examples using floating-point probabilities. See the [manuscript](paper.en.md) for the assumptions and the asymptotic proof.
