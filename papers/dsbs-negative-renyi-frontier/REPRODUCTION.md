# Reproduction

Run from this project directory with Python 3.

~~~sh
python code/certify_thresholds.py --output results/recomputed-thresholds
python code/certify_background_curvature.py --cells 2048 --output results/recomputed-curvature.json
python code/certify_background_curvature.py --cells 8192 --extensions --output results/recomputed-finite-counts.json
python code/certify_e_star_independent.py
~~~

The computations verify finite instances. General results follow from the written proofs.

- [certify_background_curvature.py](code/certify_background_curvature.py)
- [certify_e_star_independent.py](code/certify_e_star_independent.py)
- [certify_thresholds.py](code/certify_thresholds.py)
- [prior_operational_converse.md](references/prior_operational_converse.md)
- [prior_phase_boundary.md](references/prior_phase_boundary.md)
- [background_curvature.json](results/background_curvature.json)
- [e_star_certificate_independent.json](results/e_star_certificate_independent.json)
- [finite_examples_and_critical.json](results/finite_examples_and_critical.json)
- [threshold_certificates.json](results/threshold_certificates.json)
- [threshold_certificates.md](results/threshold_certificates.md)
