# Reproducing the Cauchy-channel calculations

Run these commands from this directory with Python 3.12, SymPy 1.14.0 and mpmath 1.3.0.

```sh
python3 -m pip install sympy==1.14.0 mpmath==1.3.0
python3 code/check_cauchy.py > results/check_output.json
```

The [recorded results](results/check_output.json) include an exact rational bracket for the first transition, symbolic identity checks, and high-precision calculations at selected power values. The numerical examples are diagnostic. The [manuscript](paper.en.md) gives the continuous-domain proof and the scope of each result.

## Reproducing the additional results

Use Python 3 with NumPy and SciPy. Run from this project directory.

~~~sh
python code/check_risks.py > results/check_risks.json
~~~

The [recorded calculations](results/check_risks.json) give independent finite examples of the new analytical results.
