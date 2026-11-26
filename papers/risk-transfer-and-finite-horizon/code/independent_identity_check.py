from fractions import Fraction as F
from itertools import product
import json

# Independent definitions: direct lower-tail mass allocation versus quantile integral.
def lower_tail(law,q):
 left=q;total=F(0)
 for x,p in sorted(law):
  take=min(left,p);total+=take*x;left-=take
  if not left:break
 if left!=0:raise ArithmeticError("tail mass not exhausted")
 return total/q

def quantile_integral(law,cap):
 left=cap;total=F(0)
 for x,p in sorted(law):
  take=min(left,p);total+=take*(x-1);left-=take
  if not left:break
 if left!=0:raise ArithmeticError("tail mass not exhausted")
 return total

values=[F(1),F(3,2),F(5,2),F(4)]
prices=[F(1),F(6,5),F(3,2),F(2),F(5,2),F(3),F(4)]
deltas=[F(0),F(1,3),F(1,2),F(2,3),F(3,4),F(4,5)]
count=0
for ns in product(range(7),repeat=4):
 if sum(ns)!=6: continue
 law=[(x,F(n,6)) for x,n in zip(values,ns)]
 for v,d in product(prices,deltas):
  q=1-d;cdf=sum(p for x,p in law if x<=v)
  direct=lower_tail([(x if x<=v else F(1),p) for x,p in law],q)
  formula=1+quantile_integral(law,max(F(0),cdf-d))/q
  if direct!=formula:raise ValueError((law,v,d,direct,formula))
  count+=1
print(json.dumps({'checks':count,'status':'pass','arithmetic':'exact Python Fraction','scope':'CVaR quantile identity on finite laws, including atoms, gaps, endpoint equalities; not the analytic minimax theorem'},indent=2))
