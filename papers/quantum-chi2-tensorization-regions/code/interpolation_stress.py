"""Independent numerical stress checks for proposed interpolation/tensor bounds.

No numerical run proves a universal inequality. All margins are retained.
"""
import json,time
import numpy as np
from scipy.linalg import eigh
from quantum_sdpi import *

ALPHAS=[.01,.05,.076,.1,.2,.25,1/3,.4,.49,.5]

def matrix_power(a,r):
    vals,u=eigh(a,check_finite=False)
    return (u*vals**r)@u.conj().T

def petz(kraus,sigma):
    tau=apply(kraus,sigma)
    sq=matrix_power(sigma,.5);ti=matrix_power(tau,-.5)
    return np.array([sq@k.conj().T@ti for k in kraus]),tau

def complex_gram(sigma,matrices,alpha):
    lam,u=eigh(sigma,check_finite=False)
    v=np.einsum('ia,nij,jb->nab',u.conj(),matrices,u,optimize=True)
    w=lam[:,None]**(-alpha)*lam[None,:]**(alpha-1)
    g=np.einsum('aij,ij,bij->ab',v.conj(),w,v,optimize=True)
    return (g+g.conj().T)/2

def eta_hat(kraus,sigma,alpha):
    b=tangent_basis(len(sigma));n=len(b)
    g=complex_gram(sigma,b,alpha)
    q=complex_gram(apply(kraus,sigma),apply(kraus,b),alpha)
    return float(eigh(q,g,eigvals_only=True,subset_by_index=[n-1,n-1],check_finite=False)[0])

def mixed_eta(kraus,sigma,alpha,beta,weight):
    b=tangent_basis(len(sigma));n=len(b);tau=apply(kraus,sigma);eb=apply(kraus,b)
    g=weight*metric_gram(sigma,b,'mean',alpha)+(1-weight)*metric_gram(sigma,b,'mean',beta)
    q=weight*metric_gram(tau,eb,'mean',alpha)+(1-weight)*metric_gram(tau,eb,'mean',beta)
    return float(eigh(q,g,eigvals_only=True,subset_by_index=[n-1,n-1],check_finite=False)[0])

def make_pairs():
    rng=np.random.default_rng(5384001)
    pairs=[]
    for it in range(96):
        d1,d2=(2,2) if it<64 else ((2,3) if it<80 else (3,3))
        k1=random_channel(rng,d1,d1,2+it%3);s1=random_state(rng,d1,1+it%3)
        k2=random_channel(rng,d2,d2,2+(it+1)%3);s2=random_state(rng,d2,1+(it+1)%3)
        if it%4==0:
            # An exactly CPTP nearly identity channel; no matrix logarithm.
            eps=10.**(-1-it%3)
            k1=np.concatenate([np.sqrt(1-eps)*np.eye(d1)[None,:,:],np.sqrt(eps)*k1])
            k2=np.concatenate([np.sqrt(1-eps)*np.eye(d2)[None,:,:],np.sqrt(eps)*k2])
        label=f'random_{it}'
        if it%3==0:
            k1,s1=petz(k1,s1);label+='_petz_first'
        if it%5==0:
            k2,s2=petz(k2,s2);label+='_petz_second'
        pairs.append((label,k1,s1,k2,s2))
    # Reproduction controls: endpoint activation, reverse activation, sign crossing.
    for gamma,s in [(.5,.5),(.2,-.7),(.8,.6),(.01,.9)]:
        k=amplitude_damping(gamma);sig=diagonal_qubit(s)
        pairs.append((f'amplitude_{gamma}_{s}',k,sig,k,sig))
        r,tau=petz(k,sig)
        pairs.append((f'amplitude_petz_{gamma}_{s}',r,tau,r,tau))
    # Boundary checks where midpoint coefficient is exactly zero or one.
    for d in [2,3]:
        sig=np.eye(d)/d
        identity=np.eye(d)[None,:,:].astype(complex)
        replacement=[]
        for i in range(d):
            for j in range(d):
                k=np.zeros((d,d),complex);k[i,j]=1/np.sqrt(d);replacement.append(k)
        replacement=np.array(replacement)
        pairs.append((f'identity_{d}',identity,sig,identity,sig))
        pairs.append((f'replacement_{d}',replacement,sig,replacement,sig))
        pairs.append((f'identity_replacement_{d}',identity,sig,replacement,sig))
    return pairs

def run():
    pairs=make_pairs();rows=[];mixrows=[]
    maxima={key:dict(margin=-np.inf) for key in ['local_lower','hermitian_below_complex','complex_upper','product_lower','product_upper','positive_interval_equality']}
    start=time.monotonic();maxcond=0.;maxtp=0.
    for it,(label,k1,s1,k2,s2) in enumerate(pairs):
        kk=tensor_channel(k1,k2);ss=np.kron(s1,s2)
        r1=max(0.,eta(k1,s1,'mean',.5));r2=max(0.,eta(k2,s2,'mean',.5))
        cond=max(np.linalg.cond(ss),np.linalg.cond(apply(kk,ss)))
        maxcond=max(maxcond,cond)
        maxtp=max(maxtp,channel_checks(k1)['tp_error'],channel_checks(k2)['tp_error'])
        for alpha in ALPHAS:
            e1=eta(k1,s1,'mean',alpha);e2=eta(k2,s2,'mean',alpha)
            h1=eta_hat(k1,s1,alpha);h2=eta_hat(k2,s2,alpha)
            ej=eta(kk,ss,'mean',alpha)
            m=max(e1,e2);bound=max(m,max(e1*e2,0.)**(alpha/(1-alpha)))
            rec=dict(label=label,alpha=alpha,input_dimensions=[len(s1),len(s2)],r1=r1,r2=r2,eta1=e1,eta2=e2,hat1=h1,hat2=h2,joint=ej,upper_bound=bound,condition_number=float(cond))
            margins=dict(local_lower=max(r1**(2-2*alpha)-e1,r2**(2-2*alpha)-e2),hermitian_below_complex=max(e1-h1,e2-h2),complex_upper=max(h1-r1**(2*alpha),h2-r2**(2*alpha)),product_lower=m-ej,product_upper=ej-bound)
            if alpha>=1/3:margins['positive_interval_equality']=abs(ej-m)
            rec['margins']=margins;rows.append(rec)
            for key,val in margins.items():
                if val>maxima[key]['margin']:maxima[key]=dict(margin=val,case=label,alpha=alpha,condition_number=float(cond))
        # Exploratory only: no mixture theorem is assumed.
        if it<32:
            alpha,beta,weight=1/3,.49,.35
            e1=mixed_eta(k1,s1,alpha,beta,weight);e2=mixed_eta(k2,s2,alpha,beta,weight);ej=mixed_eta(kk,ss,alpha,beta,weight)
            mixrows.append(dict(label=label,alpha=alpha,beta=beta,weight=weight,eta1=e1,eta2=e2,joint=ej,gap=ej-max(e1,e2),status='exploratory convex-kernel mixture; outside asserted mean-alpha theorem'))
        if (it+1)%16==0:print('pairs',it+1,'elapsed',round(time.monotonic()-start,2),{k:v['margin'] for k,v in maxima.items()},flush=True)
    result=dict(seed=5384001,pair_count=len(pairs),bound_case_count=len(rows),local_comparison_count=2*len(rows),positive_interval_case_count=sum(r['alpha']>=1/3 for r in rows),random_pairs=96,amplitude_and_petz_controls=8,boundary_controls=6,max_reference_condition=maxcond,max_tp_error=maxtp,numerical_tolerance=1e-8,maximum_violation_margins=maxima,contradiction_candidates=[r for r in rows if any(v>1e-8 for v in r['margins'].values())],convex_kernel_mixture_case_count=len(mixrows),convex_kernel_mixture_max_gap=max(r['gap'] for r in mixrows),convex_kernel_mixture_exploration=mixrows,rows=rows,scope='numerical stress test, not a proof of universal inequalities')
    json.dump(result,open('interpolation_stress.json','w'),indent=2)
    print(json.dumps({k:v for k,v in result.items() if k not in ['rows','convex_kernel_mixture_exploration','contradiction_candidates']},indent=2))

if __name__=='__main__':run()
