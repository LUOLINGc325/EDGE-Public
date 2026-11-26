"""Smaller H x R_X diagnostic using Lai's published generic builder.

This configures its documented projection interface; it is not the complete
published RXxRY solver and cannot establish that all older tests pass.
"""
import importlib.util
from pathlib import Path
import json,time,hashlib
root=Path(__file__).resolve().parent
source=root/'source_RXxRY.py'
spec=importlib.util.spec_from_file_location('lai_published_builder',source)
lai=importlib.util.module_from_spec(spec);spec.loader.exec_module(lai)
lai.n=23;lai.k=1;lai.d=7
lai.FIXED_A={0:1,6:90,8:1314,10:348,12:107280,14:434880,
   16:1282869,18:1543428,20:738072,22:86022}
lai.GLOBAL_PARITY_CASE=3;lai.T_SIZE=17;lai.U_SIZE=6
lai.PROJECTION_T=[['I'],['X','Y','Z']]
lai.PROJECTION_U=[['I'],['X'],['Y','Z']]
lai.USE_COMMUTATION=True;lai.USE_ORBIT=True;lai.USE_SELF_ORBIT_PARITY=False
lai.USE_BLOCKWISE_TWISTS=False;lai.USE_TRANSVERSE_QY_CASES=False
lai.USE_TRANSVERSE_MEMBERSHIP_BRANCHING=False;lai.BLOCKWISE_PARITY_CASES={}
lai.USE_CLEANING=True;lai.TIMEOUT_MS=30000
t0=time.perf_counter()
print('building HxRX diagnostic',flush=True)
p=lai.build_problem()
print('built',p['nvars'],len(p['universe']),len(p['eq_rows']),len(p['inequalities']),flush=True)
status,detail=lai._solve_problem_real_lp(p)
out={'source_commit':'20ed01cf79cf49ccaf8eea524a40d451e7d536ca',
     'source_blob_sha':'0fc22893e32c4154e3c42519d8f4337e6e38ab4c',
     'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
     'parameters':[23,1,7],'reference_weight':6,'configuration':'H x R_X',
     'global_parity_case':3,'fixed_A':lai.FIXED_A,'status':status,
     'runtime':time.perf_counter()-t0,'detail':detail,
     'scope':'Floating-point continuous relaxation with one reference; not a code-existence certificate or full prior-method comparison.'}
(root/'b2_hxrx_reference6_result.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2),flush=True)
