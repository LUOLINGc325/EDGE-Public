# Reproduction

Run from this project directory with Python 3.

Install the dependencies with `python -m pip install -r code/requirements.txt`.

~~~sh
python code/verify_certificate.py results/n10_k4.json
python code/run_study.py --small-max-n 12 --extended --output-dir results/regenerated-study
python code/orthogonal_recheck.py
python code/verify_uniform_example.py
~~~

The computations verify finite instances. General results follow from the written proofs.

- [algebra.py](code/algebra.py)
- [orthogonal_recheck.py](code/orthogonal_recheck.py)
- [requirements.txt](code/requirements.txt)
- [run_study.py](code/run_study.py)
- [sweep.py](code/sweep.py)
- [verify_certificate.py](code/verify_certificate.py)
- [verify_uniform_example.py](code/verify_uniform_example.py)
- [binomial_n10_k4_path.png](figures/binomial_n10_k4_path.png)
- [n10_k4.json](results/n10_k4.json)
- [n12_k9.json](results/n12_k9.json)
- [n12_k9_verified.json](results/n12_k9_verified.json)
- [orthogonal_recheck.json](results/orthogonal_recheck.json)
- [uniform_example.json](results/uniform_example.json)
