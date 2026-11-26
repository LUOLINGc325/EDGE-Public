#!/usr/bin/env python3
"""Exact infinite-state discounted queue certificate with a rational tail root.

All arithmetic in construction and verification is fractions.Fraction.
The result concerns a counterexample to an occupancy-independent queued-job
threshold and to unit increments of preferred occupancy. It is NOT a
counterexample to nondecreasing preferred occupancy or to the main all-m goal.
"""
from __future__ import annotations

from fractions import Fraction as F
import hashlib
import json
from pathlib import Path


def rational_solve(matrix, rhs):
    """Gauss-Jordan elimination over Q, with exact pivoting and residual check."""
    count=len(rhs)
    augmented=[list(matrix[i])+[rhs[i]] for i in range(count)]
    for col in range(count):
        pivot=next(row for row in range(col,count) if augmented[row][col])
        augmented[col],augmented[pivot]=augmented[pivot],augmented[col]
        scale=augmented[col][col]
        augmented[col]=[v/scale for v in augmented[col]]
        for row in range(count):
            if row==col or not augmented[row][col]: continue
            factor=augmented[row][col]
            augmented[row]=[v-factor*w for v,w in zip(augmented[row],augmented[col])]
    answer=[row[-1] for row in augmented]
    assert all(sum((matrix[i][j]*answer[j] for j in range(count)),F(0))==rhs[i]
               for i in range(count))
    return answer


def build_certificate(root=F(47,50), L=8):
    m=2
    lam,a,b=F(9),F(10),F(1)
    mu=a+m*b
    gamma=lam+mu
    r=root
    alpha=(1-r)*(mu/r-lam)
    D=alpha+gamma
    rho=gamma/D
    assert 0<r<1 and alpha>0 and lam<mu
    assert lam*r*r-(gamma+alpha)*r+mu==0
    A=D/alpha
    B=D*(lam-mu)/(alpha*alpha)
    d=(D*(1-r)/alpha)*(L+1+lam*(1-r)/alpha)
    assert d==A+(1-r)*(A*L+B)

    states=[(n,y) for n in range(L+1) for y in range(min(m,n)+1)]
    index={state:i for i,state in enumerate(states)}
    size=len(states)
    def upper(n,y): return y if n==y else min(m,n-1)
    # Candidate preferred occupancy h(n)=0 below 5 and h(n)=2 from 5 on.
    policy={(n,y):max(y,0 if n<5 else m) for n,y in states}
    assert all(y<=policy[n,y]<=upper(n,y) for n,y in states)

    iteration_log=[]
    for iteration in range(1,51):
        matrix=[[F(int(i==j)) for j in range(size)] for i in range(size)]
        rhs=[F(n) for n,y in states]
        def subtract(i,n,y,weight):
            matrix[i][index[n,policy[n,y]]]-=weight/D
        for i,(n,y) in enumerate(states):
            if n<L: subtract(i,n+1,y,lam)
            else:
                matrix[i][index[L,m]]-=lam*r/D
                rhs[i]+=lam*d/D
            subtract(i,n-1 if n>y else n,y,a)
            if y: subtract(i,n-1,y-1,b*y)
            if y<m: subtract(i,n,y,b*(m-y))
        vector=rational_solve(matrix,rhs)
        values={s:vector[index[s]] for s in states}
        chosen={}
        changes=[]
        for n,y in states:
            feasible=range(y,upper(n,y)+1)
            best=min(values[n,k] for k in feasible)
            kstar=next(k for k in feasible if values[n,k]==best)
            chosen[n,y]=kstar
            if values[n,policy[n,y]]>best:
                changes.append({'state':[n,y],'old':policy[n,y],'new':kstar,
                                'improvement':str(values[n,policy[n,y]]-best)})
                policy[n,y]=kstar
        iteration_log.append({'iteration':iteration,'strict_policy_improvements':changes})
        if not changes: break
    else: raise RuntimeError('Exact policy iteration did not terminate.')

    FL=values[L,m]
    C=FL-A*L-B
    def tail(n):
        assert n>=L
        return A*n+B+C*r**(n-L)
    assert tail(L+1)==r*FL+d
    first_increment=tail(L+1)-tail(L)
    minimum_increment=min(A,first_increment)
    assert A>0 and first_increment>0 and minimum_increment>0
    def W(n,y):
        """Candidate value after instantaneous optimal assignment."""
        assert n>=0 and 0<=y<=min(m,n)
        if n<=L:
            return min(values[n,k] for k in range(y,upper(n,y)+1))
        return tail(n)
    assert all(W(L,y)==FL for y in range(m+1))

    def U(n,z,y):
        """Auxiliary uniformized postdecision value, including fast-idle states.

        Uniformization offers decisions at potential service-clock events.
        The exact minimizing selector is idempotent, so under this selector
        dummy events cause no assignments and it implements a legal policy
        for the original arrival/actual-departure decision model.
        """
        assert n>=z+y and z in (0,1) and 0<=y<=m
        event=lam*W(n+1,y)
        event+=a*(W(n-1,y) if z else W(n,y))
        if y: event+=b*y*W(n-1,y-1)
        event+=b*(m-y)*W(n,y)
        return n+event/D

    def H(n,z,y):
        """Original real-event postdecision value, scaled by D.

        No decision is offered until an actual arrival/departure. This formula
        removes any ambiguity about assigning jobs at virtual service events.
        """
        event=lam*W(n+1,y)
        if z: event+=a*W(n-1,y)
        if y: event+=b*y*W(n-1,y-1)
        rate=lam+a*z+b*y
        value=(D*n+event)/(alpha+rate)
        assert value-W(n,y)==D*(U(n,z,y)-W(n,y))/(alpha+rate)
        return value

    finite_reduced=[]
    for n,y in states:
        z=int(n>y)
        computed=U(n,z,y)
        assert computed==values[n,y]
        choices=[{'final_slow_occupancy':k,'value':str(values[n,k]),
                  'gap_above_minimum':str(values[n,k]-W(n,y))}
                 for k in range(y,upper(n,y)+1)]
        assert min(F(x['gap_above_minimum']) for x in choices)==0
        finite_reduced.append({'total_population':n,'slow_occupancy':y,
            'x':n-y,'fast_busy':z,'value':str(values[n,y]),'assigned_value':str(W(n,y)),
            'value_kind':'auxiliary uniformized postdecision value U',
            'original_real_event_postdecision_value_H':str(H(n,z,y)),
            'greedy_final_slow_occupancy':chosen[n,y],
            'Bellman_right_hand_side':str(computed),'Bellman_residual':'0',
            'feasible_assignment_values_and_gaps':choices})

    # Full original nonpreemptive assignments at every state through L+1,
    # including all first-analytic-layer occupancies and initially idle fast server.
    original_actions=[]
    for n in range(L+2):
        for y in range(min(m,n)+1):
            for z in (0,1):
                if z+y>n: continue
                actions=[]
                for final_z in range(z,2):
                    for final_y in range(y,m+1):
                        if final_z+final_y>n: continue
                        value=H(n,final_z,final_y)
                        gap=value-W(n,y)
                        assert gap>=0
                        actions.append({'final_fast_busy':final_z,'final_slow_occupancy':final_y,
                            'queued_after_assignment':n-final_z-final_y,
                            'postdecision_value':str(value),'gap_above_minimum':str(gap)})
                assert min(F(v['gap_above_minimum']) for v in actions)==0
                # First fill the fast server if a job is available, then take
                # the smallest optimizing slow occupancy; dummy-event repetition
                # leaves this state unchanged.
                final_z=int(n>y)
                k=(chosen[n,y] if n<=L else m)
                if n==y: k=y
                assert H(n,final_z,k)==W(n,y)
                assert W(n,k)==U(n,final_z,k)
                rate=lam+a*z+b*y
                real_rhs=D*n+lam*W(n+1,y)
                if z: real_rhs+=a*W(n-1,y)
                if y: real_rhs+=b*y*W(n-1,y-1)
                real_residual=(alpha+rate)*H(n,z,y)-real_rhs
                assert real_residual==0
                original_actions.append({'total_population':n,'fast_busy':z,'slow_occupancy':y,
                    'queued_before_assignment':n-z-y,'assigned_value':str(W(n,y)),
                    'original_real_event_postdecision_value_H':str(H(n,z,y)),
                    'auxiliary_uniformized_postdecision_value_U':str(U(n,z,y)),
                    'real_event_rate':str(rate),'real_event_Bellman_residual':str(real_residual),
                    'selected_final_fast_busy':final_z,'selected_final_slow_occupancy':k,
                    'feasible_original_actions':actions})

    # Independently verify the closed-form expressions for the first two tail
    # layers. Algebra below then handles every later integer n, not a cutoff.
    tail_layer_checks=[]
    for n in (L+1,L+2):
        delta=tail(n)-tail(n-1)
        for y in range(m+1):
            for z in (0,1):
                closed=tail(n)+((m-y)*b+(1-z)*a)*delta/D
                exact=U(n,z,y)
                assert exact==closed
                original_closed=tail(n)+((m-y)*b+(1-z)*a)*delta/(alpha+lam+a*z+b*y)
                assert H(n,z,y)==original_closed
                tail_layer_checks.append({'n':n,'fast_busy':z,'slow_occupancy':y,
                    'auxiliary_direct_value_U':str(exact),'auxiliary_closed_form_value_U':str(closed),
                    'original_direct_value_H':str(H(n,z,y)),
                    'original_closed_form_value_H':str(original_closed),'residual':'0'})

    h=[]
    for n in range(L+1):
        row=[values[n,k] for k in range(min(m,max(n-1,0))+1)]
        h.append(next(k for k,v in enumerate(row) if v==min(row)))
        original_row=[H(n,int(n>0),k) for k in range(min(m,max(n-1,0))+1)]
        assert next(k for k,v in enumerate(original_row) if v==min(original_row))==h[-1]
    jump= h[5]-h[4]
    assert h[4]==0 and h[5]==2 and jump==2
    # Both slow-occupancy choices are unique at the two decisive populations.
    decisive=[]
    for n in (4,5):
        row=[H(n,1,k) for k in range(min(m,n-1)+1)]
        minimizers=[k for k,v in enumerate(row) if v==min(row)]
        assert minimizers==([0] if n==4 else [2])
        small_bounds=([F(0),F(1,20),F(2)] if n==4 else [F(1),F(1,40),F(0)])
        assert all(v-min(row)>bound if bound else v-min(row)==0
                   for v,bound in zip(row,small_bounds))
        decisive.append({'n':n,'unique_preferred_slow_occupancy':minimizers[0],
            'value_kind':'original real-event postdecision value H with busy fast server',
            'values':[str(v) for v in row],
            'gaps_above_minimum':[str(v-min(row)) for v in row],
            'readable_strict_lower_bounds_for_positive_gaps':[str(v) for v in small_bounds]})
    assert minimum_increment>36

    certificate={
        'statement':'Exact discounted infinite-state optimal-policy certificate; counterexample only to an occupancy-independent queued-job threshold and unit increments of h.',
        'not_a_counterexample_to':'The nondecreasing preferred-occupancy property in the main all-m research target.',
        'arithmetic':'fractions.Fraction only; no floating-point input, solve, sign test, residual, or tail root.',
        'parameters':{'m':m,'lambda':str(lam),'fast_rate':str(a),'slow_rate':str(b),
                      'alpha':str(alpha),'gamma':str(gamma),'D':str(D),'rho':str(rho)},
        'normalization':'H and W are D times the original continuous-time discounted costs; H is postdecision and W is after optimal instantaneous assignment. U is an auxiliary uniformized postdecision function. The certificate verifies H directly at actual-event epochs.',
        'finite_interface_total_population':L,
        'policy_iteration_log':iteration_log,
        'finite_policy_matrix':[[str(v) for v in row] for row in matrix],
        'finite_policy_rhs':[str(v) for v in rhs],
        'finite_policy_state_order':[list(s) for s in states],
        'finite_reduced_state_certificates':finite_reduced,
        'full_original_action_certificates':original_actions,
        'tail':{'r':str(r),'A':str(A),'B':str(B),'C':str(C),'F_L':str(FL),
            'boundary_d':str(d),'F_L_plus_1':str(tail(L+1)),
            'characteristic_polynomial_residual':str(lam*r*r-D*r+mu),
            'F_formula':'F(n)=A*n+B+C*r^(n-L), n>=L',
            'increment_formula':'F(n)-F(n-1)=A-C*(1-r)*r^(n-L-1), n>=L+1',
            'first_increment':str(first_increment),'positive_uniform_increment_lower_bound':str(minimum_increment),
            'readable_strict_uniform_increment_lower_bound':'36',
            'increment_positivity_proof':'If C>=0, increments increase from the positive first increment to A; if C<0, every increment exceeds A>0. Here 0<r<1, and both A and the first increment were checked exactly.',
            'all_large_state_values':'H(n,z,y)=F(n)+[(m-y)*b+(1-z)*a]*(F(n)-F(n-1))/(alpha+lambda+a*z+b*y) for n>=L+1, z in {0,1}, 0<=y<=m.',
            'auxiliary_large_state_values':'U(n,z,y)=F(n)+[(m-y)*b+(1-z)*a]*(F(n)-F(n-1))/D.',
            'all_large_action_gaps':'For n>=L+1, the full-dispatch value F(n) is smallest because every alternative has the displayed nonnegative coefficient times the positive tail increment.',
            'direct_first_two_layer_checks':tail_layer_checks},
        'preferred_occupancy':{'h_values_n0_through_L':h,'h_beyond_L':m,
            'simplified_formula':'h(n)=0 for 0<=n<=4; h(n)=2 for n>=5',
            'decisive_unique_minimizers':decisive,
            'same_queue_length_witness':[
                {'q':3,'fast_busy':1,'slow_busy':0,'n':4,'unique_final_slow_occupancy':0},
                {'q':3,'fast_busy':1,'slow_busy':1,'n':5,'unique_final_slow_occupancy':2}],
            'h_jump_from_n4_to_n5':jump},
        'verification_scope':{
            'finite_reduced_Bellman_residuals':'all exactly zero',
            'all_original_actions_through_n_L_plus_1':'all exact gaps nonnegative; at least one exact zero per state',
            'all_n_ge_L_plus_1':'covered by the rational-root recurrence, exact first-layer checks, and positive analytic increment formula',
            'dummy_events':'Only the construction uses an auxiliary uniformized U. Verification uses H(n,z,y)=[D*n+lambda*W(n+1,y)+a*z*W(n-1,y)+b*y*W(n-1,y-1)]/(alpha+lambda+a*z+b*y), so original decisions occur only at real events.',
            'transversality':'H and W grow at most linearly in n. After k actual events population is at most initial_n+k. Every actual-event rate is at most gamma, so conditional expected discount to the next event is at most rho=gamma/(alpha+gamma)<1. The expected discounted terminal value is bounded by a constant times rho^k*(initial_n+k+1), which tends to zero. Direct real-event Bellman verification gives optimality over the original admissible policy class.'},
    }
    return certificate


def manuscript(c):
    p=c['parameters']; t=c['tail']; d=c['preferred_occupancy']['decisive_unique_minimizers']
    table='\n'.join('| '+str(row['n'])+' | '+str(row['unique_preferred_slow_occupancy'])+' | '+
        ' ; '.join('0' if v=='0' else '> '+v for v in row['readable_strict_lower_bounds_for_positive_gaps'])+' |' for row in d)
    return f'''# An exact infinite-state double-jump certificate

## Statement and limitation

Consider the original nonpreemptive queue with one fast exponential server of rate 10, two slow exponential servers of rate 1, Poisson arrival rate 9, and continuous-time discount rate

\\[
\\alpha={p['alpha']}.
\\]

The normalized discounted decision value W has a unique preferred slow occupancy h(4)=0 and h(5)=2. In fact an optimal deterministic stationary policy fills the fast server whenever a job is available and, after that, uses

\\[
h(n)=\\begin{{cases}}0,&n\\le4,\\\\2,&n\\ge5,\\end{{cases}}
\\qquad k^*(n,y)=\\max\\{{y,h(n)\\}}.
\\]

Here n is total population and y is the pre-assignment number of busy slow servers. At states with no queued or fast job, existing slow jobs remain in place. Every policy decision in the statement is certified in the original infinite-buffer model below.

This gives a counterexample to a **single queued-job threshold independent of slow occupancy**, and to the stronger condition h(n+1)-h(n)<=1. It does **not** contradict nondecreasing h, does not refute the main arbitrary-m threshold conjecture, and does not extend the known two-slow-server threshold theorem. The certificate supplies an exact instance, not a novelty claim about all stronger conjectures.

## Exact finite certificate

Put gamma=21 and D=gamma+alpha={p['D']}. All cost functions in the JSON are scaled by D. Construction uses an auxiliary uniformized postdecision function U, with one-stage cost n. Verification then uses the physical decision value W and the real-event first-wait value H, defined below. The finite reduced state order, every matrix coefficient, right-hand side, rational solution value, feasible assignment value, and action gap are contained in `results/rational_policy_certificate.json`.

The interface is total population L={c['finite_interface_total_population']}. The policy evaluation system has {len(c['finite_policy_state_order'])} states. It is solved by Gauss-Jordan elimination over the rational numbers. Its residual is exactly zero in every equation. All feasible original nonpreemptive actions are then checked, including withholding the fast server, assigning one or both slow servers, and every slow-occupancy state in the first analytic layer.

For readability, the following exact lower bounds summarize the decisive action gaps, in the order of final slow occupancies k=0,1,2. The complete rational gaps and values are in the JSON:

| Total n | Unique preferred k | Certified gaps above the minimum |
|---:|---:|---|
{table}

No gap is inferred from a decimal approximation. In particular, both relevant minimizers are unique.

## Rational infinite continuation

The selected subunit birth-death root is r={t['r']}. It satisfies exactly

\\[
9r^2-(21+\\alpha)r+12=0.
\\]

For the all-busy slice define

\\[
F(n)=A n+B+C r^{{n-L}},\\qquad n\\ge L,
\\]

where

\\[
A=\\frac D\\alpha={t['A']},\\quad
B=\\frac{{D(9-12)}}{{\\alpha^2}}={t['B']},\\quad
C={t['C']}.
\\]

The finite system includes the exact interface relation

\\[
F(L+1)=rF(L)+\\frac{{D(1-r)}}\\alpha
\\left(L+1+\\frac{{9(1-r)}}\\alpha\\right).
\\]

The characteristic-root identity and the linear particular solution imply the Bellman recurrence for every later integer n. The first continuation layer is checked separately using the finite optimal-assignment values at population L, for every occupied-slow-server count. Thus the proof does not assume that an all-busy formula already applies to every boundary alternative.

Moreover,

\\[
F(n)-F(n-1)=A-C(1-r)r^{{n-L-1}}
\\ge {t['positive_uniform_increment_lower_bound']}>0
\\quad(n\\ge L+1).
\\]

The lower bound is the smaller of A and the exactly checked first increment. This is valid whether C is nonnegative or negative.

For every sufficiently large full original state, with z in {{0,1}} recording fast occupancy and y in {{0,1,2}} recording slow occupancy, direct substitution gives the physical first-wait value

\\[
H(n,z,y)=F(n)+\\frac{{(2-y)+10(1-z)}}{{\\alpha+9+10z+y}}
\\bigl(F(n)-F(n-1)\\bigr).
\\]

Every alternative to full dispatch therefore has a nonnegative exact gap. This covers infinitely many states through an algebraic formula, rather than through a finite-buffer approximation.

## Full action verification and optimality

At a decision state (n,z,y), feasible final occupancies satisfy z' in {{z,1}}, y' in {{y,...,2}}, and z'+y'<=n. These constraints enforce both nonpreemption and job availability. The certificate lists H(n,z',y')-W(n,y) for every such action through n=L+1. All gaps are nonnegative and each state has an exact zero action. Thus W is the minimum physical first-wait value over the original action set. The tail formula gives the same conclusion for every later population.

The actual event rate following a dispatch is R=9+10z+y. The next decision is offered only at an actual arrival or departure. The exact real-event identity used in verification is

\\[
H(n,z,y)=\\frac{{D n+9W(n+1,y)+10zW(n-1,y)+yW(n-1,y-1)}}{{\\alpha+9+10z+y}},
\\]

with zero-coefficient terms omitted. Every residual of this identity is exactly zero. U is only an auxiliary construction variable; arbitrary U values are not asserted to be lower bounds on instantaneous decision costs.

Both H and W grow at most linearly in population. After k actual events, population is at most n+k. Since every actual event rate is at most gamma=21, the conditional expected discount factor until the next event is at most rho=21/D<1. The expected discounted terminal candidate value is therefore bounded by a constant times rho^k(n+k+1), which tends to zero. Iterating W<=H for each selected original action and then the real-event identity proves that W is a lower bound on every admissible original **decision** cost. The certified greedy selector attains equality. This directly verifies discounted infinite-horizon optimality for the original event model, without needing decisions at dummy events.

## Why a common queued-job threshold cannot work

Compare two decision states, each with exactly three waiting jobs and a busy fast server:

- With zero busy slow servers, n=4 and the unique optimal action activates no slow server.
- With one busy slow server, n=5 and the unique optimal action activates the remaining slow server.

The identical queue length requires different activation decisions depending on slow occupancy. A single queue-length cutoff independent of that occupancy cannot implement the optimal choices. Also h(5)-h(4)=2, which rules out unit increments. The preferred occupancy remains nondecreasing, exactly as allowed by the main research target.

## Reproduction and claim boundary

Run `python code/rational_policy_certificate.py` from this case directory. It uses the Python standard library only. No floating-point values, approximate roots, tolerances, numerical linear algebra, or truncated-queue boundary conditions enter the certificate.

The known two-slow-server ordered-threshold setting is described in Wang et al., [arXiv:2607.22580, primary manuscript](https://www.cs.cmu.edu/~weinaw/pdf/One_fast_two_slow_conjecture.pdf). This exact instance is consistent with that theorem: the two initially-idle queue thresholds coincide, allowing a jump of two. Whether this exact instance or equivalent examples have appeared previously is a separate novelty question; no priority claim is made here.
'''


def main():
    base=Path(__file__).resolve().parents[1]
    cert=build_certificate()
    cert['generator_sha256']=hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    results=base/'results'/'rational_policy_certificate.json'
    paper=base/'manuscript'/'rational_policy_certificate.md'
    results.parent.mkdir(parents=True,exist_ok=True)
    paper.parent.mkdir(parents=True,exist_ok=True)
    results.write_text(json.dumps(cert,indent=2)+'\n')
    paper.write_text(manuscript(cert))
    print(json.dumps({'parameters':cert['parameters'],'finite_states':len(cert['finite_policy_state_order']),
        'full_original_states_checked':len(cert['full_original_action_certificates']),
        'all_Bellman_residuals':'exactly zero','h4':cert['preferred_occupancy']['h_values_n0_through_L'][4],
        'h5':cert['preferred_occupancy']['h_values_n0_through_L'][5],
        'json':str(results),'manuscript':str(paper)}))


if __name__=='__main__':main()
