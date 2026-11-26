"""Numerical conditioning check of the unchanged HxRX constraints.

Not a complete prior-art algorithm test; not an exact certificate.
"""
import runpy,json,time
from pathlib import Path
import numpy as np
from scipy.optimize import linprog
from scipy.sparse import diags
root=Path(__file__).resolve().parent
ns=runpy.run_path(str(root/'run_b2_hxrx_reference6.py'))
lai,p=ns['lai'],ns['p'];nv=p['nvars']
eq=lai._rows_to_csr_real(p['eq_rows'],nv)
beq=np.asarray(p['eq_rhs'],float)
ineq=lai._rows_to_csr_real([r for r,_ in p['inequalities']],nv,negate=True)
bub=np.asarray([-b for _,b in p['inequalities']],float)
def scaled(M,b):
    maxima=np.asarray(abs(M).max(axis=1).toarray()).ravel()
    maxima=np.maximum(1,np.maximum(maxima,abs(b)))
    return diags(1/maxima)@M,b/maxima,maxima
E,e,es=scaled(eq,beq);I,i,iss=scaled(ineq,bub)
bounds=[(0,None if p['upper_bounds'].get(j) is None else float(p['upper_bounds'][j])) for j in range(nv)]
t0=time.perf_counter()
res=linprog(np.zeros(nv),A_eq=E,b_eq=e,A_ub=I,b_ub=i,
            bounds=bounds,method='highs',options={'time_limit':30.0})
out={'scope':'Floating-point row-scaled HxRX single-reference diagnostic, not exact verification.',
     'scipy_status':int(res.status),'message':str(res.message),'runtime':time.perf_counter()-t0,
     'max_original_abs_equality_coefficient':float(abs(eq).max()),
     'max_original_abs_inequality_coefficient':float(abs(ineq).max()),
     'nvars':nv,'n_eq':len(p['eq_rows']),'n_ineq':len(p['inequalities'])}
if res.x is not None:
    out['max_scaled_equality_residual']=float(np.max(abs(E@res.x-e)))
    out['max_scaled_inequality_violation']=float(np.max(I@res.x-i))
    out['min_variable']=float(res.x.min())
    out['candidate_vector']=res.x.tolist()
(root/'b2_hxrx_reference6_scaled_result.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:v for k,v in out.items() if k!='candidate_vector'},indent=2),flush=True)
