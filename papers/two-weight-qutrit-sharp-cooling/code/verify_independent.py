"""Independent exact attack from product configurations; no shell/path identities.

Only the proposed comparison constant is taken from the candidate theorem.
No author implementation is imported. Runtime checks use explicit exceptions
and remain active under Python -O. The certificate contains no timestamps.
All E,F matrices are constructed from original p*q weighted permutations.
"""
from fractions import Fraction as R
from itertools import permutations, product
from collections import defaultdict
from pathlib import Path
import json
import argparse
import hashlib


class Quad:
    """Exact ordered arithmetic in Q(sqrt(rad)); rad can be a square."""
    rad = R(1)

    def __init__(self, a=0, b=0):
        self.a, self.b = R(a), R(b)

    def __add__(self, other):
        if not isinstance(other, Quad): other = Quad(other)
        return Quad(self.a+other.a, self.b+other.b)
    __radd__ = __add__

    def __neg__(self): return Quad(-self.a, -self.b)
    def __sub__(self, other): return self + (-other if isinstance(other, Quad) else -R(other))
    def __rsub__(self, other): return other + (-self)

    def __mul__(self, other):
        if not isinstance(other, Quad): other = Quad(other)
        return Quad(self.a*other.a+self.rad*self.b*other.b,
                    self.a*other.b+self.b*other.a)
    __rmul__ = __mul__

    def sign(self):
        a,b = self.a,self.b
        if b == 0: return (a>0)-(a<0)
        if a == 0: return (b>0)-(b<0)
        if (a>0)==(b>0): return (a>0)-(a<0)
        diff=a*a-b*b*self.rad
        if diff==0: return 0
        return ((a>0)-(a<0))*((diff>0)-(diff<0))

    def encode(self): return {'rational':str(self.a),'sqrt_coefficient':str(self.b),'radicand':str(self.rad)}


def max_chain(p,s):
    ps=set(p)
    starts=[x for x in ps if x/s not in ps]
    best=0
    for x in starts:
        length=0
        while x*s in ps:
            length+=1;x*=s
        best=max(best,length)
    return best


def candidate(p,s,a):
    b=3-a; D=a+b*s; length=max_chain(p,s)
    if length==0:
        Quad.rad=R(1)
        return Quad(0),length
    A=sum((s**j for j in range(length) if j%2==0),R(0))
    B=sum((s**j for j in range(length) if j%2==1),R(0))
    T=sum((s**j for j in range(1,length)),R(0))
    same=Quad(2*(1+s)/(3*D))
    if length==1:
        Quad.rad=R(1)
        return same,length
    Quad.rad=A*B
    alternate=Quad((1+s)/(2*D),T/(2*D*A*B))
    return (alternate if (alternate-same).sign()>0 else same),length


def original_block_data(p,q,singleton):
    repeated=[i for i in range(3) if i!=singleton]
    basis=[(0,0)]*3
    basis[repeated[0]]=(1,0);basis[repeated[1]]=(0,1)
    groups=defaultdict(list)
    for x,px in enumerate(p):
        for y,qy in enumerate(q): groups[px*qy].append((x,y))
    blocks=[]
    for weight,configs in sorted(groups.items()):
        choices=[]
        for srcs in permutations(configs):
            E=[R(0)]*3
            delta=[[R(0),R(0)] for _ in p]
            for (x,y),(xp,yp) in zip(configs,srcs):
                du=basis[yp][0]-basis[y][0]
                dv=basis[yp][1]-basis[y][1]
                E[0]+=weight*du*du;E[1]+=weight*du*dv;E[2]+=weight*dv*dv
                delta[x][0]+=weight*du;delta[x][1]+=weight*dv
            choices.append((E,delta))
        blocks.append(choices)
    return blocks,[len(v) for v in groups.values()]


def positive_energy_nullvector(M,E):
    m0,m1,m2=M
    if m0.sign()!=0:
        z=(-m1,m0)
    elif m2.sign()!=0:
        z=(m2,-m1)
    else:
        return E[0]>0 or E[2]>0
    energy=E[0]*z[0]*z[0]+2*E[1]*z[0]*z[1]+E[2]*z[1]*z[1]
    return energy.sign()>0


def audit_model(raw,s,a,name):
    total=sum(raw);p=[x/total for x in raw]
    if len(set(p))!=len(p): raise ValueError('system probabilities degenerate')
    D=a+(3-a)*s
    q=[1/D]*a+[s/D]*(3-a)
    singleton=0 if a==1 else 2
    C,length=candidate(p,s,a)
    blocks,shellsizes=original_block_data(p,q,singleton)
    count=0;attain=0;restricted_attain=0;kernel_count=0
    restricted=R(0) if length==0 else (1+s)/(2*D)
    for choices in product(*blocks):
        count+=1
        E=[sum((c[0][j] for c in choices),R(0)) for j in range(3)]
        ds=[[sum((c[1][i][j] for c in choices),R(0)) for j in range(2)] for i in range(len(p))]
        F=[sum((d[0]*d[0]/px for d,px in zip(ds,p)),R(0)),
           sum((d[0]*d[1]/px for d,px in zip(ds,p)),R(0)),
           sum((d[1]*d[1]/px for d,px in zip(ds,p)),R(0))]
        M=[C*e-f for e,f in zip(E,F)]
        det=M[0]*M[2]-M[1]*M[1]
        if M[0].sign()<0 or M[2].sign()<0 or det.sign()<0:
            raise AssertionError((name,a,str(s),count,'sharp comparison fails',E,F))
        if det.sign()==0 and positive_energy_nullvector(M,E): attain+=1
        if E[0]==E[1]==E[2]==0:
            kernel_count+=1
            if F!=[0,0,0]:raise AssertionError('zero E nonzero F')
        Er=E[0]+2*E[1]+E[2];Fr=F[0]+2*F[1]+F[2]
        if Fr>restricted*Er:raise AssertionError('preserved degeneracy bound fails')
        if Er>0 and Fr==restricted*Er:restricted_attain+=1
    if length>0 and (attain==0 or restricted_attain==0):raise AssertionError('no saturation found')
    return {'name':name,'s':str(s),'high_multiplicity':a,'system_raw':[str(x) for x in raw],
            'max_edges':length,'shell_sizes':sorted(shellsizes),'permutations_checked':count,
            'sharp_C':C.encode(),'saturating_permutations':attain,
            'degeneracy_preserving_C':str(restricted),'restricted_saturating_permutations':restricted_attain,
            'identically_zero_energy_permutations':kernel_count}


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path,
                        help='Explicit destination for the deterministic JSON certificate')
    args=parser.parse_args()
    records=[]
    for s in [R(1,16),R(1,4),R(2,3)]:
        for a in [1,2]:
            for L in range(1,5):
                records.append(audit_model([s**i for i in range(L+1)],s,a,f'chain_L{L}'))
    for a in [1,2]:
        s=R(1,4)
        records.append(audit_model([R(1),s,s*s,R(11,7),R(11,7)*s,R(13,11)],s,a,'L2_L1_isolated'))
        records.append(audit_model([R(1),s,s*s,R(11,7),R(11,7)*s,R(11,7)*s*s],s,a,'two_L2_components'))
        records.append(audit_model([R(1),R(11,7),R(13,11)],s,a,'no_mixed_shell'))
    payload={'status':'PASS','method':'Original product-configuration permutation enumeration; Fraction E,F; exact Q(sqrt(r)) PSD comparison',
             'model_count':len(records),'total_permutations':sum(x['permutations_checked'] for x in records),
             'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),'models':records}
    out=args.output
    out.parent.mkdir(parents=True,exist_ok=True)
    out.write_text(json.dumps(payload,indent=2)+'\n')
    print(json.dumps({k:v for k,v in payload.items() if k!='models'}))


if __name__=='__main__':main()
