"""Diagnostic invocation of Lai's unchanged published real-LP source.

Source commit: 20ed01cf79cf49ccaf8eea524a40d451e7d536ca
Only module configuration is set here; no repository database is modified.
This is a single mandatory reference-weight test, not an exhaustive sweep.
"""
import importlib.util
from pathlib import Path
import json
import time
import hashlib

root=Path(__file__).resolve().parent
source=root/'source_RXxRY.py'
spec=importlib.util.spec_from_file_location('lai_published_rxry',source)
lai=importlib.util.module_from_spec(spec)
spec.loader.exec_module(lai)
lai.n=23; lai.k=1; lai.d=7
lai.EXACT_VERIFY_TIMEOUT_MS=20000
lai.PROGRESS_EVERY_SECONDS=5.0
A={0:1,6:90,8:1314,10:348,12:107280,14:434880,
   16:1282869,18:1543428,20:738072,22:86022}
print('SOURCE_SHA256',hashlib.sha256(source.read_bytes()).hexdigest(),flush=True)
print('CASE',3,'REFERENCE',6,'A',A,flush=True)
lai.internal_projection_self_test()
lai.validate_strong_configuration()
t0=time.perf_counter()
status,details=lai.solve_reference_u(A,3,6,timeout_ms=20000)
out={'source_commit':'20ed01cf79cf49ccaf8eea524a40d451e7d536ca',
     'source_blob_sha':'0fc22893e32c4154e3c42519d8f4337e6e38ab4c',
     'parameters':[23,1,7],'fixed_A':A,'global_parity_case':3,
     'reference_weight':6,'status':status,'runtime':time.perf_counter()-t0,
     'details':details,'scope':'Single-reference diagnostic; numerical SAT is not code existence.'}
(root/'b2_reference6_result.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2),flush=True)
