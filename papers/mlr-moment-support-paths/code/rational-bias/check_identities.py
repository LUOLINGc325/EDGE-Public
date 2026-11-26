"""Optional exact symbolic certificates. Requires SymPy."""
import sympy as s

w,u,z,y,c,t,S,P=s.symbols('w u z y c t S P')
H=[s.hermite_prob(j,y) for j in range(5)]
def gaussian(F):
    return sum(a*(s.factorial2(j[0]-1) if j[0]>0 else 1)
               for j,a in s.Poly(F,y).terms() if not j[0]%2)
A=s.Matrix(4,4,lambda i,j:gaussian(((y-u)**2-s.Rational(4,9))*H[i]*H[j]))
E=[w+s.Rational(5,9),
   w*w-8*w/9+s.Rational(115,81),
   2*w**3-26*w*w/3+374*w/27+s.Rational(1978,729),
   12*w**4-352*w**3/3+3368*w*w/9-64960*w/243+s.Rational(149812,2187)]
def changes(signs):
    nz=[x for x in signs if x]
    return sum(a!=b for a,b in zip(nz,nz[1:]))
for j,p in enumerate(E,1):
    assert s.expand(A[:j,:j].det()-p.subs(w,u*u))==0
    st=[s.Poly(q,w) for q in s.sturm(p,w)]
    assert p.subs(w,0)>0
    assert changes([s.sign(q.eval(0)) for q in st])==changes([s.sign(q.LC()) for q in st])

K=[s.Integer(1),y]
for j in range(1,4):
    K.append(s.expand((y-j*c)*K[j]-j*(1-(j-1)*t)*K[j-1]))
v=1+c*z-t*z*z
k=[0,z,v]
for j in range(3,7):
    k.append(s.expand(v*s.diff(k[j-1],z)))
m=[s.Integer(1)]
for j in range(1,7):
    m.append(s.expand(sum(s.binomial(j-1,i-1)*k[i]*m[j-i] for i in range(1,j+1))))
L=[s.prod(1-i*t for i in range(1,j+1)) for j in range(6)]
R=[
 [L[1],(-S+3*c)*L[1],(P+5-2*S*c+4*c*c-8*t)*L[1],3*(-S+5*c)*L[2],12*L[3]],
 [0,L[2],(-S+5*c)*L[2],(P+7-3*S*c+9*c*c-18*t)*L[2],4*(-S+7*c)*L[3]],
 [0,0,L[3],(-S+7*c)*L[3],(P+9-4*S*c+16*c*c-32*t)*L[3]],
 [0,0,0,L[4],(-S+9*c)*L[4]],
]
for j in range(5):
    inp=s.Poly(K[j]*(y*y-S*y+P),y)
    out=s.Poly(sum(a*m[i[0]] for i,a in inp.terms()),z)
    for i in range(2,6):
        assert s.expand(out.nth(i)-R[i-2][j])==0
assert s.expand(K[4]-H[4]-(c*(-6*y**3+14*y)+(11*c*c+8*t)*y*y-(6*c**3+12*c*t)*y-6*c*c-6*t))==0
assert [s.expand(s.Poly(m[2],z).nth(i)) for i in range(2,5)]==[1-t,0,0]
assert all(s.expand(s.Poly(m[3],z).nth(i)-a)==0 for i,a in zip(range(2,5),[3*c*L[1],L[2],0]))
assert all(s.expand(s.Poly(m[4],z).nth(i)-a)==0 for i,a in zip(range(2,5),[(6+7*c*c-8*t)*L[1],6*c*L[2],L[3]]))
print('Exact Gram/Sturm, recurrence, and transfer identities: OK.')
