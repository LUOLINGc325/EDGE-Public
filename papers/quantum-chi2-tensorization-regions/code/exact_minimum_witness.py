"""Exact rational generalized-spectrum certificate for the structured SLD witness."""
import sympy as s
import json

R=s.Rational
I=s.I
K=[s.diag(2*s.sqrt(2)/3,1),s.Matrix([[0,0],[R(1,3),0]])]
sigma=s.diag(R(9,10),R(1,10))
def channel(ks,h): return sum((k*h*k.conjugate().T for k in ks),s.zeros(h.rows))
tau=channel(K,sigma)
assert tau==s.diag(R(4,5),R(1,5))
assert sum((k.conjugate().T*k for k in K),s.zeros(2))==s.eye(2)
KK=[s.kronecker_product(k,l) for k in K for l in K]
ss=s.kronecker_product(sigma,sigma)
tt=s.kronecker_product(tau,tau)
bs=[]
for i in range(4):
 for j in range(i+1,4):
  x=s.zeros(4);x[i,j]=x[j,i]=1;bs.append(x)
  y=s.zeros(4);y[i,j]=-I;y[j,i]=I;bs.append(y)
for i in range(3):
 z=s.zeros(4);z[i,i]=1;z[3,3]=-1;bs.append(z)
def gram(reference,bs):
 def inner(a,b):return s.simplify(sum(a[i,j].conjugate()*b[i,j]*2/(reference[i,i]+reference[j,j]) for i in range(4) for j in range(4)))
 return s.Matrix([[inner(a,b) for b in bs] for a in bs])
G=gram(ss,bs);Q=gram(tt,[channel(KK,b) for b in bs])
unseen=set(range(len(bs)));components=[]
while unseen:
 c={unseen.pop()};todo=list(c)
 while todo:
  i=todo.pop()
  add={j for j in unseen if G[i,j]!=0 or Q[i,j]!=0}
  unseen-=add;c|=add;todo.extend(add)
 components.append(sorted(c))
lam=s.symbols('lambda')
factors=[]
for c in components:
 g=G.extract(c,c);q=Q.extract(c,c)
 f=s.factor((lam*g-q).det()/g.det())
 factors.append((c,str(f)))
char=s.factor(s.prod((lam*G.extract(c,c)-Q.extract(c,c)).det()/G.extract(c,c).det() for c in components))
expected=(lam-R(16,81))*(lam-R(32,81))**4*(lam-R(4,9))**4*(lam-R(8,9))**4*(lam-R(1312,1377))**2
assert s.factor(char-expected)==0
result={"arithmetic":"SymPy exact rational and quadratic radical arithmetic", "source_reference":["9/10","1/10"],"output_reference":["4/5","1/5"],"trace_preserving":True,"blocks":factors,"normalized_characteristic_polynomial":str(char),"factorization_verified":True,"joint_eta":"1312/1377","single_eta":"8/9","strict_gap":str(R(1312,1377)-R(8,9)),"scope":"exact algebraic witness and finite spectra; no universal-kernel classification"}
json.dump(result,open('exact_minimum_witness.json','w'),indent=2)
print(json.dumps(result,indent=2))
