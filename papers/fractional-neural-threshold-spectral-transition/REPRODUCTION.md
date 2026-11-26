# Reproduction

Run from this project directory with Python 3.

Install NumPy, SciPy, mpmath and Matplotlib. Create a figures directory if it is absent.

~~~sh
python code/reproduce.py
python code/reproduce_radial.py
~~~

The computations verify finite instances. General results follow from the written proofs.

- [reproduce.py](code/reproduce.py)
- [reproduce_radial.py](code/reproduce_radial.py)
- [numerical_checks.json](results/numerical_checks.json)
- [radial_checks.json](results/radial_checks.json)
