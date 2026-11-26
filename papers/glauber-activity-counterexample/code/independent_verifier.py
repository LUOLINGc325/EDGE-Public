from fractions import Fraction as Q
from decimal import Decimal, localcontext
from pathlib import Path
import argparse, json, hashlib

ENERGIES=(0,1,2,3,50,51,52,53)
BATH_BASES=(Q(1001,1000),Q(21,20),Q(32))
# Edge list written directly, independently of the author's graph constructor.
EDGES=((0,1),(0,2),(0,3),(1,2),(1,3),(2,4),(3,5),(4,6),(4,7),(5,6),(5,7),(6,7))
N=8;DEGREE=3

def check(test,message):
 if not test: raise RuntimeError(message)

check(len(set(EDGES))==12,'duplicate edges')
check(all(i<j for i,j in EDGES),'edge normalization')
check(all(sum(i==u or i==v for u,v in EDGES)==3 for i in range(N)),'regularity')
seen={0}
while True:
 expanded=seen|{v for u,v in EDGES if u in seen}|{u for u,v in EDGES if v in seen}
 if expanded==seen:break
 seen=expanded
check(len(seen)==N,'connectedness')
check(all(ENERGIES[i]<ENERGIES[i+1] for i in range(N-1)),'distinct increasing energies')
check(1<BATH_BASES[0]<BATH_BASES[1]<BATH_BASES[2],'positive strictly increasing beta')

def thermal(q):
 masses=[q**(-E) for E in ENERGIES]
 Z=sum(masses)
 return [m/Z for m in masses]

def edge_acceptance(q,i,j):
 return 1/(1+q**(ENERGIES[j]-ENERGIES[i]))

def update(p,q):
 nxt=list(p)
 activity=Q(0)
 for i,j in EDGES:
  ai=edge_acceptance(q,i,j);aj=edge_acceptance(q,j,i)
  check(ai+aj==1,'edge acceptance sum')
  check(0<ai<1 and 0<aj<1,'finite positive acceptance')
  forward=p[i]*ai/DEGREE
  reverse=p[j]*aj/DEGREE
  nxt[i]+=reverse-forward;nxt[j]+=forward-reverse
  activity+=forward+reverse
 check(sum(nxt)==1 and min(nxt)>0,'probability vector')
 return nxt,activity

p0=thermal(BATH_BASES[0]);p1,A0=update(p0,BATH_BASES[1]);p2,A1=update(p1,BATH_BASES[2])
check(A0>Q(249,500),'first activity lower bound')
check(A0<Q(1,2),'initial activity upper bound')
check(A1>Q(51,100),'second activity lower bound')
AVG=(A0+A1)/2
check(AVG>Q(63,125),'average activity lower bound')
# Independent stationary and detailed-balance verification for all 3 baths.
for q in BATH_BASES:
 g=thermal(q)
 for i,j in EDGES:
  check(g[i]*edge_acceptance(q,i,j)==g[j]*edge_acceptance(q,j,i),'detailed balance')
 gp,activity=update(g,q)
 check(gp==g,'thermal stationarity')
 check(activity<=Q(1,2),'equilibrium activity')
# Independent pairwise reformulation of (40): directed sum becomes twice edge sum.
S=Q(0)
for i,j in EDGES:
 w=1-2*edge_acceptance(BATH_BASES[2],i,j)
 S+=w*(p1[i]-p1[j])
check(A1==Q(1,2)-S/(2*DEGREE),'Eq 40 activity identity')
check(S<0,'aggregate negative passivity')

# Energy actually decreases at both steps, although this is not needed for Eq.39.
means=[sum(Q(E)*v for E,v in zip(ENERGIES,p)) for p in (p0,p1,p2)]
check(means[0]>means[1]>means[2],'mean energy decrease')

# Verify the proposed general-family limiting count at arbitrary d, directly.
family_checks=[]
for d in range(3,21):
 nn=2*(d+1)
 edges=[(u,v) for lo in (0,d+1) for u in range(lo,lo+d+1) for v in range(u+1,lo+d+1)]
 edges.remove((d-1,d));edges.remove((d+1,d+2));edges += [(d-1,d+1),(d,d+2)]
 check(all(sum(v in e for e in edges)==d for v in range(nn)),'family degree')
 p=[Q(1,nn) for _ in range(nn)]
 pp=list(p)
 for u,v in edges:
  cross=u<=d<v
  # first-stage cross energies are separated, within clusters become degenerate.
  a=Q(0) if cross else Q(1,2)
  f=p[u]*a/d;g=p[v]*(1-a)/d
  pp[u]+=g-f;pp[v]+=f-g
 # second-stage energy order is strictly the vertex order.
 A=sum(pp[v]/d for u,v in edges)
 target=Q(1,2)+Q(d-2,d*d*(d+1))
 check(A==target,'family limiting activity')
 family_checks.append({'d':d,'A1_limit':str(A),'mean_limit':str((Q(1,2)+A)/2)})

def decimal(v):
 with localcontext() as c:
  c.prec=50
  return str(Decimal(v.numerator)/Decimal(v.denominator))

def value(v):
 return {'numerator':str(v.numerator),'denominator':str(v.denominator),'decimal':decimal(v)}

result={
 'method':'Independent edge-flux implementation; all checks use exact Fraction arithmetic and explicit RuntimeError checks, valid with python -O.',
 'energies':ENERGIES,'bath_exponential_bases':[str(x) for x in BATH_BASES],
 'inverse_temperature_schedule':'log(1001/1000), log(21/20), log(32)',
 'edges':EDGES,'vertices':N,'degree':DEGREE,
 'p0':[value(x) for x in p0],'p1':[value(x) for x in p1],'p2':[value(x) for x in p2],
 'A0':value(A0),'A1':value(A1),'two_update_average':value(AVG),
 'gap_A0_over_249_500':value(A0-Q(249,500)),
 'gap_A1_over_51_100':value(A1-Q(51,100)),
 'gap_average_over_63_125':value(AVG-Q(63,125)),
 'undirected_passivity_sum':value(S),
 'mean_energies':[value(x) for x in means],
 'family_limit_checks_d3_to20':family_checks,
 'verified':True
}
parser=argparse.ArgumentParser(description='Independent exact verification of the eight-state Glauber activity counterexample.')
parser.add_argument('--output',type=Path,default=Path(__file__).resolve().parents[1]/'results'/'independent_certificate.json')
args=parser.parse_args()
out=args.output
out.parent.mkdir(parents=True,exist_ok=True)
out.write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({
 'A0':decimal(A0),'A1':decimal(A1),'two_update_average':decimal(AVG),
 'undirected_passivity_sum':decimal(S),'mean_energies':[decimal(x) for x in means],
 'verified_claims':['A0>249/500','A0<1/2','A1>51/100','average>63/125','stationarity','detailed balance','connected cubic graph','distinct integer energies','strict finite cooling','mean energy strictly decreases twice','Eq40 identity','family limit count for d=3,...,20'],
 'certificate':str(out),'sha256':hashlib.sha256(out.read_bytes()).hexdigest()
},indent=2))
