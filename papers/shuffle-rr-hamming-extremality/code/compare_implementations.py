#!/usr/bin/env python3
"""Compare every complete probability-law digest from two independent algorithms."""
import hashlib
import json
from pathlib import Path

root = Path(__file__).resolve().parents[1]
pa = root/'results/exact_checks.json'
pb = root/'results/independent_checks.json'
a = json.loads(pa.read_text())
b = json.loads(pb.read_text())
def key(x):
    return (x['case'], x['lambda'], x['n'], x['mask'])
aa = {key(x): x for x in a['rows']}
bb = {key(x): x for x in b['rows']}
if len(aa) != len(a['rows']) or len(bb) != len(b['rows']):
    raise RuntimeError('Duplicate instance keys')
if aa.keys() != bb.keys():
    raise RuntimeError('Instance keys differ')
for k in aa:
    for field in ('law_sha256','bound','support'):
        if aa[k][field] != bb[k][field]:
            raise RuntimeError((k, field, aa[k][field], bb[k][field]))
report = {
    'status':'PASS', 'compared_complete_laws':len(aa),
    'fields':['law_sha256','bound','support'],
    'primary_record_sha256':hashlib.sha256(pa.read_bytes()).hexdigest(),
    'independent_record_sha256':hashlib.sha256(pb.read_bytes()).hexdigest(),
    'note':'Independent algorithms exactly agree on every listed full law, not only on the reported bound.'
}
(root/'results/cross_implementation.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2))
