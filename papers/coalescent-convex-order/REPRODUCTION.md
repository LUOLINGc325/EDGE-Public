# Reproduction

Run from this project directory with Python 3.

Install the dependencies with `python -m pip install -r code/requirements.txt`.

~~~sh
python code/verify_cost_orders.py --output results/recomputed_cost_orders.json
python code/verify_paintbox.py --output results/recomputed_paintbox.json
~~~

The computations verify finite instances. General results follow from the written proofs.

- [requirements.txt](code/requirements.txt)
- [verify_cost_orders.py](code/verify_cost_orders.py)
- [verify_paintbox.py](code/verify_paintbox.py)
- [paintbox_results.json](results/paintbox_results.json)
- [results.json](results/results.json)
