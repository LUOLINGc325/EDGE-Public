"""High-precision candidate generator for the documented demonstration grid.

Candidate stationary points are not trusted as certificates. Run
verify_certificates.py to establish finite-instance primal/dual bounds. This
routine explores two active-set patterns and is not a guaranteed general solver.
"""
import mpmath as mp
mp.mp.dps=85

def solve(p,q,r,a):
 p,q,r,a=map(mp.mpf,map(str,(p,q,r,a)))
 def full(x,l):
  y=mp.exp(l)
  r1=(q-r+y)/(p-x);r0=(1-q-y)/(1-p-r+x)
  s1=(r-y)/x;s0=y/(r-x)
  return r1-r0-a*(s1-s0),mp.log(r1/r0)-a*(mp.log(s1)-mp.log(s0))
 delta=q-p
 starts=[min(p/2,r/3),min(p/2,mp.sqrt(a)),min(p/2,a)]
 candidates=[]
 overlap_seeds=[]
 if delta<r:
  # The exact common-law/Vajda minimizer is a stable starting point as a -> 0.
  lo,hi=mp.mpf('0'),r-delta
  for _ in range(300):
   mid=(lo+hi)/2
   derivative=mp.log((mid+delta)*(r-mid)/(mid*(r-mid-delta)))-delta*(1/mid+1/(r-mid))
   if derivative<0:lo=mid
   else:hi=mid
  sx=(lo+hi)/2;sy=r-delta-sx
  overlap_seeds.append((sx,r-sx,r-sy,sy,'seed'))
  try:
   x,l=mp.findroot(full,(sx,mp.log(sy)),solver='mdnewton',tol=mp.mpf('1e-70'),maxsteps=150)
   y=mp.exp(l)
   if 0<x<min(p,r) and 0<y<min(r,1-q):candidates.append((x,r-x,r-y,y,'full'))
  except (ValueError,ZeroDivisionError,TypeError):pass
 for st in starts:
  rr1=(q-r)/(p-st);rr0=(1-q)/(1-p-r+st)
  sl=mp.log((r-st)*r/st)-mp.log(rr1/rr0)/a
  for ls in [sl,mp.log(r/3),-1/a]:
   try:
    x,l=mp.findroot(full,(st,ls),solver='mdnewton',tol=mp.mpf('1e-70'),maxsteps=150)
    y=mp.exp(l)
    if not(0<x<min(p,r) and 0<y<min(r,1-q)):continue
    cand=(x,r-x,r-y,y,'full')
    candidates.append(cand)
   except (ValueError,ZeroDivisionError,TypeError):pass
 def slack(x,h,l):
  y=mp.exp(l);m=x+h
  r1=(q-r+y)/(p-x);r0=(1-q-y)/(1-p-h)
  s1=(r-y)/x;s0=y/h;rm=r/m
  return r1-a*s1-(1-a)*rm,r0-a*s0-(1-a)*rm,mp.log(r1/r0)-a*(mp.log(s1)-mp.log(s0))
 for c in overlap_seeds+candidates[:2]+[(s,r-s,r/2,r/2,'seed') for s in starts]:
  x,h,z,y,_=c
  ls=mp.log(y)
  try:
   xx,hh,ll=mp.findroot(slack,(x,h,ls),solver='mdnewton',tol=mp.mpf('1e-70'),maxsteps=150)
   yy=mp.exp(ll)
   if 0<xx<p and 0<hh<1-p and xx+hh<=r+mp.mpf('1e-50') and 0<yy<min(r,1-q):candidates.append((xx,hh,r-yy,yy,'slack'))
  except (ValueError,ZeroDivisionError,TypeError):pass
 def law(t,h1,h0):return [t-h1,1-t-h0,a*h1,a*h0,(1-a)*(h1+h0)]
 out=[]
 for x,h,z,y,mode in candidates:
  P=law(p,x,h);Q=law(q,z,y)
  e=[v/u for u,v in zip(P,Q)]
  value=sum(v*mp.log(w) for v,w in zip(Q,e))
  g1=a*e[2]+(1-a)*e[4]-e[0]
  g0=a*e[3]+(1-a)*e[4]-e[1]
  d1=a*mp.log(e[2])+(1-a)*mp.log(e[4])-mp.log(e[0])
  d0=a*mp.log(e[3])+(1-a)*mp.log(e[4])-mp.log(e[1])
  if abs(g1-g0)<mp.mpf('1e-40') and abs(d1-d0)<mp.mpf('1e-40') and g1>=-mp.mpf('1e-45') and d1<=mp.mpf('1e-45'):
   out.append({'a':str(a),'rho':str(r),'mode':mode,'I':mp.nstr(value,25),'x':mp.nstr(x,15),'h0':mp.nstr(h,15),'log_y':mp.nstr(mp.log(y),15),'log_e':[mp.nstr(mp.log(v),65) for v in e], 'hidden_p':[mp.nstr(x,65),mp.nstr(h,65)],'hidden_q':[mp.nstr(z,65),mp.nstr(y,65)]})
 if not out:return {'failed':True,'a':str(a),'rho':str(r),'candidates':len(candidates)}
 return min(out,key=lambda x:mp.mpf(x['I']))

if __name__=='__main__':
 import json
 for r in [.2,.3,.4]:
  for a in [.1,.01,.001]:
   print(json.dumps(solve(.2,.5,r,a)),flush=True)
