"""Independent illustration of the one-dimensional two-family limiting cost."""
import json
import numpy as np
from scipy.linalg import eigh_tridiagonal
from scipy.special import ai_zeros
def half(s):
 x=np.linspace(s,12.,1001);h=x[1]-x[0];y=x[1:-1]
 return float(eigh_tridiagonal(2/h**2+y*y/4-.5,-np.ones(len(y)-1)/h**2,select='i',select_range=(0,0),eigvals_only=True)[0])
points=np.arange(-2.,2.01,.25)
energy=[(half(s)+half(-s))/2 for s in points]
assert np.argmin(energy)==8 and abs(energy[8]-1)<3e-4
print(json.dumps({'half_line_energy_at_zero':energy[8],'grid_partition_minimizer':float(points[np.argmin(energy)]),'airy_first_positive_zero':float(-ai_zeros(1)[0][0]),'interpretation':'Finite-difference checks of the auxiliary limiting formulas, not asymptotic proof.'}))
