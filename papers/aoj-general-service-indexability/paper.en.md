# Exact age-of-job indices with preemptive resume, general service and nonlinear age

## Abstract

In a regenerative Bernoulli-arrival arm, jobs have positive integer service times and may be paused after any attained service. With age penalty $wd^a$, the optimal expected average charge is finite exactly when the service time has a finite moment of order $a+1$. We determine the minimizing actions at every busy state, including zero completion hazards. The index depends on the expected penalty at uninterrupted completion, with an integer optimization over waiting at a fresh job. For linear age and bounded service we also give finite-horizon verification errors, bias uniqueness in a linear-growth class, a constrained activation-rate frontier, and examples that separate throughput from age.

## 1. Contributions and scope

Sections 2–8 present the bounded-service, linear-cost specialization with its quantitative estimates. Sections 9–10 establish the constrained frontier and the general-service theorem. The calculation concerns a single arm. Section 3 introduces the envelopes used in both parts of the analysis.

## 2. The controlled model

Let $Y$ be a positive integer service requirement, with actual largest support point $M\ge1$. Write

$$
f_j=\Pr(Y=j),\quad 1\le j\le M,\qquad f_j\ge0,
\quad \sum_j f_j=1,\quad f_M>0.
$$

Fix $p\in(0,1]$, $w>0$, and an activation charge $\lambda\in\mathbb R$. The empty state is $e$. A physical busy state is $(d,k)$, where $0\le k<M$ and $d\ge k$. Here $d$ is the age of the job and $k$ is its attained service. Only the passive action is permitted at $e$; at a busy state, actions are $a=0,1$.

An empty slot produces a fresh job $(0,0)$ with probability $p$, and remains empty otherwise. Passivity at $(d,k)$ produces $(d+1,k)$. Activation completes with probability

$$
h_k=\frac{f_{k+1}}{q_k},\qquad q_k=\Pr(Y>k)>0.
$$

On completion the next state is $(0,0)$ with probability $p$ and $e$ otherwise. On noncompletion it is $(d+1,k+1)$. In particular, $h_{M-1}=1$. A new request arriving while a job is present does not replace that job. The cost is

$$
c_\lambda(s,a)=wD(s)+\lambda a,
\qquad D(e)=0,\quad D(d,k)=d.
$$

Admissible policies may be nonstationary, randomized and depend on the complete observed history. Conditional on that history and the selected action, the next state has exactly the transition kernel specified above. Policy randomization supplies no information about the latent service requirement or future arrivals beyond the observed history. From every fixed physical initial state $s_0$, the criterion, with the limsup interpreted in the extended reals, is

$$
\inf_\pi\limsup_{T\to\infty}
J_T^\pi,
\qquad
J_T^\pi=\frac1T\mathbb E_{s_0}^\pi
\sum_{t=0}^{T-1}c_\lambda(S_t,A_t).
$$

### 2.1 Residual quantities

Define

$$
\mu=\mathbb EY,\quad
\tau=\mathbb E\frac{Y(Y-1)}2,\quad
z=\frac{1-p}{p},
$$

and for $0\le k<M$,

$$
r_k=\mathbb E[Y-k\mid Y>k],\qquad
t_k=\mathbb E\left[\frac{(Y-k)(Y-k-1)}2\mid Y>k\right].
$$

Set $r_M=t_M=0$ solely to give a value to the impossible failed branch at the last service unit. These are not conditional expectations on a zero-probability event. Then

$$
r_k=1+(1-h_k)r_{k+1},\qquad
t_k=(1-h_k)(r_{k+1}+t_{k+1}). \tag{2.1}
$$

The equalities follow by separating residual service equal to one from residual service exceeding one. They include the last phase. Also $1\le r_k\le M$, $0\le t_k\le M(M-1)/2$, $r_0=\mu$, and $t_0=\tau$.

The scalar

$$
x(d,k)=d+r_k \tag{2.2}
$$

does not decrease on an active failure, because

$$
(d+1+r_{k+1})-(d+r_k)=h_kr_{k+1}\ge0. \tag{2.3}
$$

Moreover $k+r_k\ge\mu$, by iterating $r_k\le1+r_{k+1}$. Hence every physical busy state has $x(d,k)\ge\mu$.

## 3. Two scalar envelopes

For an integer $n\ge0$, set

$$
C_n=w\left[\frac{n(n-1)}2+\mu n+\tau\right],
\qquad D_n=n+\mu+z,
\qquad R_n(\lambda)=\frac{C_n+\lambda\mu}{D_n}.
$$

These expressions are algebraic candidates associated with the policy that waits $n$ slots at a fresh job and then serves continuously. Section 7.2 proves that its expected long-run average cost is exactly $R_n(\lambda)$ directly from the original transition kernel. Optimizing these candidates alone would not prove optimality over all causal policies; that stronger conclusion is established in Section 5.

### Lemma 3.1. Gain envelope and its exact minimizer

For every real $\lambda$,

$$
g(\lambda)=\min_{n\in\mathbb N}R_n(\lambda) \tag{3.1}
$$

is finite and attained. Define

$$
\ell_n=\frac w\mu
\left[\frac{n^2}2+
\left(\mu+z+\frac12\right)n+
\mu(\mu+z)-\tau\right]. \tag{3.2}
$$

Then

$$
\ell_{n+1}-\ell_n=\frac w\mu(n+\mu+z+1)>0, \tag{3.3}
$$

and

$$
R_{n+1}(\lambda)-R_n(\lambda)
=\frac{\mu(\ell_n-\lambda)}{D_nD_{n+1}}. \tag{3.4}
$$

The least $n$ with $\lambda\le\ell_n$ is a minimizer. It is the unique minimizer unless $\lambda=\ell_n$, in which case exactly $n,n+1$ minimize. The gain $g$ is strictly increasing in the charge.

**Proof.** The denominators are positive. Expanding the definitions gives (3.3)--(3.4). The sequence $\ell_n$ tends to infinity. Thus the ratios strictly decrease up to the first crossing, are equal at a crossing equality if present, and strictly increase afterwards. For $\lambda_2>\lambda_1$, take a minimizing $n_2$ at $\lambda_2$. Then $g(\lambda_2)=R_{n_2}(\lambda_2)>R_{n_2}(\lambda_1)\ge g(\lambda_1)$, since $\mu/D_{n_2}>0$. This proves every assertion, without an age cutoff. $\square$

For fixed $g\in\mathbb R$, define the waiting envelope

$$
F_g(x)=\min_{n\in\mathbb N}
\left\{\frac w2n(n-1)+(wx-g)n\right\}. \tag{3.5}
$$

### Lemma 3.2. Waiting-envelope identities

The minimum in (3.5) exists for every real $x$. The function is nondecreasing in $x$, and

$$
F_g(x)\le0,\qquad
F_g(x)=0\ \Longleftrightarrow\ wx\ge g, \tag{3.6}
$$

$$
F_g(x)=\min\{0,wx-g+F_g(x+1)\}. \tag{3.7}
$$

A minimizer is $\max\{0,\lceil g/w-x\rceil\}$. At a nonnegative integer value of $g/w-x$, that integer and its successor both minimize.

**Proof.** Let the expression in braces be $Q_x(n)$. Its successive difference is $w(n+x)-g$, increasing strictly in $n$. This proves the minimizing formula and existence. The candidate $n=0$ gives $F_g\le0$. If $wx\ge g$, every successive difference is nonnegative, so the minimum is zero. If $wx<g$, the candidate $n=1$ is strictly negative. Each $Q_x(n)$ is nondecreasing in $x$, so their minimum is too. Finally, $Q_x(n+1)=wx-g+Q_{x+1}(n)$; partitioning the minimization into zero and positive integers proves (3.7). $\square$

Fix $g=g(\lambda)$. Equation (3.1) is equivalently

$$
w\tau+\lambda\mu-g(\mu+z)+F_g(\mu)=0. \tag{3.8}
$$

## 4. A full-state Bellman certificate

Define

$$
V(e)=-g/p,
$$

$$
\begin{split}
B(d,k)&=w(dr_k+t_k)+\lambda r_k-g(r_k+z),\\
V(d,k)&=B(d,k)+F_g(d+r_k).
\end{split} \tag{4.1}
$$

Equation (3.8) gives $V(0,0)=0$.

### Theorem 4.1. Bellman equation and exact minimizing actions

On every physical state,

$$
g+V(s)=\min_{a\in\mathcal A(s)}
\{c_\lambda(s,a)+P_aV(s)\}. \tag{4.2}
$$

At a busy state $(d,k)$, passivity minimizes the Bellman expression exactly when

$$
g\ge w(d+r_k). \tag{4.3}
$$

If $h_k>0$, activation minimizes exactly when the reverse inequality holds. If $h_k=0$, activation minimizes for every charge, including the region where passivity also minimizes.

**Proof.** At $e$, (4.2) is $g+V(e)=(1-p)V(e)+pV(0,0)$, which follows immediately.

At a busy state put $x=d+r_k$ and $x'=d+1+r_{k+1}$. The expected continuation value on a completion is
$pV(0,0)+(1-p)V(e)=-zg$. Using (2.1), the two cost-plus-continuation values after subtracting $g$ become

$$
Q_0-g=B(d,k)+wx-g+F_g(x+1), \tag{4.4}
$$

$$
Q_1-g=B(d,k)+(1-h_k)F_g(x'). \tag{4.5}
$$

The impossible failed branch at $k=M-1$ has coefficient zero, so the totalization in Section 2.1 is legitimate.

If $wx\ge g$, (2.3) and (3.6) give $F_g(x)=F_g(x')=F_g(x+1)=0$. Activation has value $V$, and passivity has excess $wx-g$.

If $wx<g$, (3.7) gives $wx-g+F_g(x+1)=F_g(x)<0$. Thus passivity has value $V$. Monotonicity and nonpositivity give

$$
(1-h_k)F_g(x')-F_g(x)
\ge-h_kF_g(x)\ge0. \tag{4.6}
$$

This is strictly positive when $h_k>0$. When $h_k=0$, (2.3) gives $x'=x$, so the excess is exactly zero. All minimizing-action claims follow. $\square$

### Lemma 4.2. Growth and a proper minimizing policy

There is a finite $K\ge0$ such that $|V(s)|\le K(1+D(s))$ on all physical states. The stationary policy

$$
a^*(d,k)=1\quad\Longleftrightarrow\quad w(d+r_k)\ge g \tag{4.7}
$$

is Bellman minimizing, serves at every sufficiently large age, and never preempts a job once it has begun serving it.

**Proof.** Choose an integer $b\ge0$ with $wb\ge\max(g,0)$. For $x\ge1$, a waiting minimizer in (3.5) can be selected with $n\le b$, because the successive difference is positive for every $n\ge b$. Since $n(n-1)\ge0$ and $wxn\ge0$,

$$
-|g|b\le F_g(x)\le0.
$$

For busy states, (4.1) therefore gives

$$
|V(d,k)|\le wMd+L,
\quad
L=wM(M-1)/2+|\lambda|M+|g|(M+z+b).
$$

For example, $K=wM+L+|g|/p$ is sufficient, including the empty state. Policy (4.7) minimizes by Theorem 4.1. If $d\ge b$, then $w(d+r_k)>g$, so it activates. Once it activates, an unsuccessful activation cannot lower $d+r_k$, by (2.3); subsequent busy actions therefore activate as well. $\square$

## 5. Optimality against all causal policies

A Bellman solution alone does not justify an unbounded-state average-cost claim. We prove the terminal estimate explicitly.

### Lemma 5.1. Terminal age is controlled by cumulative age

Every admissible path satisfies

$$
D(S_T)^2\le D(s_0)^2+T+2\sum_{t=0}^{T-1}D(S_t). \tag{5.1}
$$

**Proof.** Each allowed transition satisfies $0\le D(S_{t+1})\le D(S_t)+1$. Squaring gives an increment at most $2D(S_t)+1$; summation proves (5.1). $\square$

### Theorem 5.2. Universal verification and an attaining policy

Let $K$ be as in Lemma 4.2, $d_0=D(s_0)$, $\lambda_-=\max(0,-\lambda)$, and

$$
B_*=1+\frac2w\max(g+\lambda_-,0).
$$

Every causal randomized policy and every $T\ge1$ satisfy

$$
J_T^\pi\ge
g-\frac{|V(s_0)|+K+K\sqrt{d_0^2+B_*T}}{T}. \tag{5.2}
$$

For (4.7), with $D_* =\max(d_0,b)+M-1$,

$$
|J_T^{\pi^*}-g|
\le\frac{|V(s_0)|+K(1+D_*)}{T}. \tag{5.3}
$$

Thus the optimal value for the original limsup criterion equals $g$, from every physical initial state. In fact every competing policy has $\liminf J_T^\pi\ge g$.

**Proof.** Finite-horizon integrability is automatic: $D(S_t)\le d_0+t$. Condition the Bellman inequality on the complete history and selected action, then telescope:

$$
C_T^\pi:=TJ_T^\pi\ge gT+V(s_0)-\mathbb E^\pi V(S_T). \tag{5.4}
$$

The stage-cost lower bound $c_\lambda\ge wD-\lambda_-$ and (5.1) imply

$$
\mathbb E D(S_T)^2
\le d_0^2+T+\frac2w(C_T^\pi+\lambda_-T). \tag{5.5}
$$

If $C_T^\pi\ge gT$, (5.2) is immediate. Otherwise (5.5) is at most $d_0^2+B_*T$. Cauchy--Schwarz gives $\mathbb ED(S_T)\le\sqrt{d_0^2+B_*T}$. Substitute this and the linear upper bound on $V$ into (5.4), then divide by $T$. This proves (5.2) with no transversality or recurrence assumption on the competitor.

Under (4.7), once age reaches $b$, every subsequent busy slot serves the job. At most $M$ service slots remain. Hence, almost surely and simultaneously at every time, the age is at most $D_*$. The Bellman inequalities in (5.4) are equalities for this policy, and the terminal bias is bounded by $K(1+D_*)$. This proves (5.3). The error terms tend to zero, giving the stated optimality. $\square$

### 5.1 Meaning and uniqueness of the bias

The passive set below refers to Bellman-minimizing actions, not to the vacuous observation that a finite initial deviation can leave a long-run average unchanged. With $V(0,0)=0$, (4.1) is the unique bias solving (4.2) with gain $g$ and at most linear absolute growth.

To see this, use backward induction on $k$. Empty-state normalization fixes $V(e)=-g/p$. Once the next-service-phase value is fixed, a competing linear-growth solution at phase $k$ has the scalar recursion

$$
U_k(d)=\min\{A_k(d),wd-g+U_k(d+1)\},
$$

where the activation value $A_k$ is already fixed by the next phase and completion boundary. Expanding this recursion for $n$ steps gives the minimum of the first-activation costs at waits $0,\ldots,n-1$ and the residual term

$$
w\left(nd+\frac{n(n-1)}2\right)-gn+U_k(d+n).
$$

The residual term tends to $+\infty$, since the quadratic coefficient is $w/2>0$ and $U$ has a linear lower bound. Thus the recursion uniquely determines $U_k(d)$ as the infimum of the finite first-activation costs. Apply the induction from $k=M-1$ down to zero. This also handles zero hazards: the next phase is still fixed, even when the completion branch vanishes.

## 6. Exact index and indexability

Let the passive set contain the busy states at which the passive action is Bellman minimizing. The empty state is always passive because it has no activation action; it is not included in the variable passive-set endpoints.

### Theorem 6.1. General finite-service Whittle index

For a physical busy state set $x=d+r_k$ and

$$
n=\max\{0,\lceil x-\mu\rceil\}.
$$

Then the exact charge threshold is

$$
\boxed{
W(d,k)=\frac w\mu
\left[x(n+\mu+z)-\frac{n(n-1)}2-\mu n-\tau\right].
} \tag{6.1}
$$

Passivity is minimizing exactly for $\lambda\ge W(d,k)$. Thus the busy passive sets increase from the empty set to all busy states as $\lambda$ runs from $-\infty$ to $+\infty$, in the pointwise set-limit sense. At the threshold both actions minimize. If $h_k>0$, the action-value equality occurs at that threshold only. If $h_k=0$, both actions minimize for the entire half-line $\lambda\ge W(d,k)$.

**Proof.** By Theorem 4.1, passivity is optimal precisely when $g(\lambda)\ge wx$. Because all $D_s$ are positive, (3.1) gives

$$
g(\lambda)\ge wx
\quad\Longleftrightarrow\quad
\lambda\ge\sup_{s\in\mathbb N}
\frac{wxD_s-C_s}{\mu}. \tag{6.2}
$$

Let $H_s=(wxD_s-C_s)/\mu$. Its successive difference is

$$
H_{s+1}-H_s=\frac w\mu(x-\mu-s). \tag{6.3}
$$

It is increasing until the integer crossing and decreasing afterwards. The stated $n$ maximizes it, proving (6.1). If $x-\mu$ is a nonnegative integer, $n+1$ is a second maximizer with the same value. Finiteness follows from the negative quadratic term. At $\lambda=W$, the maximizing $n$ gives $R_n(W)=wx$, while every ratio is at least $wx$, so $g(W)=wx$. Strict monotonicity from Lemma 3.1 makes this the only charge with $g(\lambda)=wx$. The pointwise set limits and all action statements now follow from the finite threshold and Theorem 4.1. $\square$

### Corollary 6.2. Information and sensitivity

The index is determined by $(p,w,\mu,\tau,r_k,d)$. It is strictly increasing as a function of $x=d+r_k$ with the other quantities fixed. On each interval with constant maximizing integer $n$, its slope in $x$ is
$w(n+\mu+z)/\mu>0$. Adjacent formulas agree at their common boundary.

If $\mu,r_k,p,w,d$ are fixed, increasing $\tau$ by $\delta$ changes the index by exactly $-w\delta/\mu$. If only the arrival probability changes from $p_1$ to $p_2$, the index change is

$$
\frac{wx}{\mu}\left(\frac1{p_2}-\frac1{p_1}\right). \tag{6.4}
$$

These comparisons apply when the stated moment constraints are simultaneously realizable; they are not assertions that arbitrary moment triples define a service law.

**Proof.** For each $s$, $H_s(x)$ is affine with strictly positive slope at least $w(\mu+z)/\mu$. A maximizing line at $x_1$ supplies this strict lower bound on the increase to $x_2>x_1$. Formula (6.3) gives the adjacent-line agreement. The remaining statements follow directly from (6.1). $\square$

## 7. Sharp examples and interpretation

### 7.1 Deterministic service and the geometric comparison

If $Y=M$, then $\mu=M$, $\tau=M(M-1)/2$, and $r_k=M-k$. Put $j=d-k\ge0$. Then

$$
W(d,k)=\frac wM
\left[\frac{j^2}2+
\left(M+z+\frac12\right)j+
M(M+z)-\frac{M(M-1)}2\right]. \tag{7.1}
$$

Although all but the final phase have zero completion hazard, their indices are finite and positive at a fresh job. An immediate-completion weight alone does not express their value.

For comparison with the known geometric result, substitute the geometric moment identities $\mu=1/q$, $\tau=\mu^2-\mu$, $r_k=\mu$ into (6.1). The purely algebraic specialization is

$$
w\left[\frac q2d^2+
\left(1-\frac q2+\frac qp\right)d+\frac1p\right], \tag{7.2}
$$

which agrees with [BU26, (45)]. Equation (7.2) is a consistency check; the bounded-service theorem is not silently promoted to an unbounded-service theorem by this substitution.

### 7.2 Performance of a fixed initial-wait policy

For an integer $n\ge0$, consider the policy that waits while $k=0,d<n$, and activates in every other busy state. Define $L_n(d,0)=\max(n-d,0)$ and $L_n(d,k)=0$ for $k>0$. Its gain is $R_n(\lambda)$, and its expected completion rate converges to $1/D_n$ from every fixed physical initial state.

Here is a direct verification that avoids a renewal-theorem assumption. Put $g_n=R_n(\lambda)$ and

$$
V_n(d,k)=w\left[d(L_n+r_k)+\frac{L_n(L_n-1)}2+L_nr_k+t_k\right]
+\lambda r_k-g_n(L_n+r_k+z),\qquad V_n(e)=-g_n/p.
$$

Then $V_n(0,0)=0$. When waiting, $L_n$ decreases by one; when serving, both its current and failed-successor values are zero. The moment recursions (2.1) therefore give the exact Poisson equation $g_n+V_n=c_\lambda+P_{a_n}V_n$ for this fixed policy. Its age is bounded by $\max(d_0,n)+M-1$, so telescoping gives average cost $g_n$ with error of order $1/T$.

For completions, put $\rho_n=1/D_n$ and

$$
H_n(e)=-\rho_n/p,\qquad
H_n(d,k)=1-\rho_n(L_n(d,k)+r_k+z).
$$

This function is uniformly bounded, and $H_n(0,0)=0$. Separating a waiting slot, a failed service slot, and a completion gives

$$
\rho_n+H_n(s)=\mathbb E[\mathbf1_{\{\text{completion this slot}\}}+H_n(S')\mid s,a_n].
$$

Indeed the waiting branch uses $L_n'=L_n-1$, the active branch uses $r_k=1+(1-h_k)r_{k+1}$, and the completion continuation has expectation $-\rho_nz$. Telescoping this bounded identity proves the claimed expected completion rate, also with an $O(1/T)$ error. Thus all performance comparisons below refer to the original stochastic process from arbitrary fixed initial states.

### 7.3 When zero-charge service should wait

At a fresh job,

$$
W(0,0)=w\left(\mu+z-\frac\tau\mu\right). \tag{7.3}
$$

Consequently immediate continuous service is strictly suboptimal at $\lambda=0$ exactly when $\tau>\mu(\mu+z)$. Equivalently, this is precisely when the least optimal initial waiting time is positive. This concerns the whole zero-wait policy, not a single first activation, which can still be optimal at zero hazard. In variance notation this is

$$
\operatorname{Var}(Y)>\mu^2+\mu(2z+1). \tag{7.4}
$$

At equality, zero and one initial waiting slots tie. This statement concerns the selected wait-then-serve optimal policy; a zero-hazard job can equivalently move guaranteed service ahead of some waiting.

Take $p=w=1$, with probabilities $9/10$ at $Y=1$ and $1/10$ at $Y=10$. Here $\mu=19/10$, $\tau=9/2$, and $W(0,0)=-89/190$. At zero charge, the unique minimizing initial wait is one slot. Its age cost is $64/29$, compared with $45/19$ for immediate continuous service; the strict improvement is $89/551$. Yet the completion rates are respectively $10/29$ and $10/19$. Thus average age minimization and throughput maximization are not equivalent in this exact finite-buffer model.

### 7.4 Equality roots do not always identify the index

For $Y=2$ deterministically, $p=w=1$, the fresh state's index is $3/2$. Its hazard is zero. For every charge $\lambda\ge3/2$, both first actions minimize the Bellman expression. For example, at $\lambda=20$, the optimal gain is $76/9$, and both action values agree at the fresh state despite the charge being far above the index. The half-line of roots is a structural consequence of Theorem 6.1. An index implementation must use the onset of passivity, not an arbitrary root.

### 7.5 Equal overall moments do not determine a partially served action

Consider the two laws on $\{1,2,3,4\}$,

$$
f^A=(3,7,1,5)/16,\qquad f^B=(5,1,7,3)/16.
$$

Both have $\mu=5/2$ and $\mathbb EY^2=15/2$. At $p=1/2$, $w=1$, $\lambda=7/2$, both have gain $55/18$. At $(d,k)=(1,1)$, however,

$$
r^A_1=24/13,\quad r^B_1=24/11,
\qquad W^A(1,1)=203/65,\quad W^B(1,1)=41/11.
$$

The first state is strictly passive and the second strictly active. Thus the gain's two-moment dependence is compatible with a genuine value of attained-service information.

## 8. Computation and verification

For finite support, a reverse cumulative pass computes the tail probabilities, first moments and second factorial moments. Each state index then requires one residual-mean lookup, one integer ceiling and a fixed number of arithmetic operations. This avoids optimizing over an age-truncated state space. The operation count uses exact arithmetic, comparisons and ceiling as mathematical primitives; it does not assert computability from arbitrary black-box real inputs or constant bit complexity. For rational inputs, these operations and all boundary comparisons can be implemented exactly. A numerical implementation must treat values close to an integer ceiling with certified comparisons if exact decisions at ties are needed.

The accompanying verification code includes an independent rational policy-iteration implementation built directly from the transitions, using two finite age caps that force service at the boundary, as well as enumeration of waiting placements within a job. These are adversarial finite checks, not a proof of the universal theorem. The actual counts and output digests are kept in the reproduction report. The formalization coverage table separately records which mathematical claims have passed Lean; a passed computation is not reported as a passed general formalization.

## 9. Prescribed positive activation rate for bounded linear service

With $D_j=j+\mu+z,\ A_j=\mu/D_j,\ H_j=C_j/D_j$, the minimum limiting upper expected holding cost at any prescribed limiting expected activation rate $A_{j+1}\le a_0\le A_j$ is $sH_j+(1-s)H_{j+1}$, $s=(a_0-A_{j+1})/(A_j-A_{j+1})$. The charge where the adjacent lines $H_j+\lambda A_j$ and $H_{j+1}+\lambda A_{j+1}$ meet gives the supporting lower bound by Theorem 5.2. Initial randomization with weights $s,1-s$ attains it. Alternatively, choose the shorter wait anew per fresh cycle with probability $sD_{j+1}/[(1-s)D_j+sD_{j+1}]$; renewal rewards give the required long-run time fractions.

## 10. Arbitrary integer service and power age penalties

Now $b(d)=wd^a,\ w,a>0,\ U(j)=\sum_{i=0}^{j-1}b(i)$, and $Y$ has any positive integer law. Write $\mu=EY,\ z=(1-p)/p$. The residual $R_k$ has the law of $Y-k\mid Y>k$ at each physical busy state. The mean $\mu$ is used in formulas for finite-value models.

**Theorem.** The optimal average cost is finite exactly when $EY^{a+1}<\infty$. In that case it equals
$$
g(\lambda)=\min_{n\ge0}\frac{EU(n+Y)+\lambda\mu}{n+\mu+z}.
$$
All causal policies from every fixed physical initial state have lower limiting expected time-average cost at least $g$. An attaining stationary rule waits at a busy state exactly when $\psi(d,k)=Eb(d+R_k)<g$, and activates thereafter. The passive Bellman action is minimizing exactly for $g\ge\psi$. The index is
$$
W(d,k)=\max_{n\ge0}\frac{\psi(d,k)(n+\mu+z)-EU(n+Y)}{\mu}.
$$
A maximizing integer is the least $n\ge0$ with $Eb(n+Y)\ge\psi(d,k)$. Positive hazards give a unique action away from the threshold. At zero hazard activation also minimizes throughout the passive region. At infinite moment every policy has even lower limiting expected time-average cost $+\infty$, for every fixed finite charge. These are single-arm results.

**Bellman construction.** Under the finite moment condition all displayed expectations at fixed $d,k,n$ are finite. The ratio tends to infinity as $n\to\infty$, so the minimum is attained. Set $V(e)=-g/p$ and
$$
 \begin{aligned} B(d,k)&=E[U(d+R_k)-U(d)]+(\lambda-g)ER_k-gz,\\
 F(d,k)&=\min_{n\ge0} E\sum_{j=0}^{n-1}[b(d+R_k+j)-g],\\ V&=B+F.\end{aligned}
$$
The successive waiting increments strictly increase to infinity. Thus $F\le0$, uniformly bounded below since only the first finitely many $j$ can have $b(j)<g$; $F=0$ iff $\psi\ge g$. The equation defining $g$ gives $V(0,0)=0$. Relative to $B$, after subtracting $g$ the passive and active action values are $\psi-g+F(d+1,k)$ and $(1-h_k)F(d+1,k+1)$. These identities follow by conditioning the serving cost on first-slot completion and by telescoping the difference of shifted $U$'s. The first is the minimum defining $F$ restricted to $n\ge1$. On a possible failed service, $d+1+R_{k+1}$ has the law of $d+R_k$ conditioned on $R_k>1$, so its distribution dominates the old one and $F(d+1,k+1)\ge F(d,k)$. This proves the Bellman equation, including the action ties as in the bounded linear case (at zero hazard equality holds on active failure). It also proves nonpreemption of the selected rule. Strict increase of $g$ follows by inserting a minimizing integer for the larger charge. Inverting $g\ge\psi$ gives the index; successive differences of its numerator are $\psi-Eb(n+Y)$.

**Verification without a uniform residual bound.** A bounded subsequence of expected averages provides tight expected occupation measures on state–action pairs, since $b(d)\to\infty$ and each bounded age set is finite. Pass to a probability limit in total variation on this countable space. The flow identity has endpoint error at most $1/T$ on each singleton, so disintegration gives a stationary randomized policy and an invariant probability. Fatou after the constant shift by $|\lambda|$ shows that its average cost is at most the subsequential limit. It suffices to bound every invariant probability with finite age cost.

Such a probability is carried by recurrent positive-recurrent classes (equivalently use recurrence under the stationary path law). Every recurrent busy state reaches a completion before its return because age strictly increases while the job survives. From a completion the fresh state is reached with probability one before another busy state is seen. An empty recurrent state also leads to a fresh state. Consequently every class of positive stationary mass contains the same fresh state and there is only one. Take a cycle from fresh state to its first positive return $L$. The return-cycle occupation formula gives $EL<\infty$ and $E\sum_{t<L} b(D_t)<\infty$. The busy part has length $H\ge Y$ and ages $0,\dots,H-1$. Thus $EU(Y)<\infty$ is necessary, equivalent to the asserted moment condition by integral comparison. This already proves the infinite-cost assertion by contradiction, including infinite-mean laws.

Under finite moment, telescope the Bellman inequality only to $L\wedge m$, for finite $m$. The terminal value at return is zero. On a surviving busy path at $m<L$, $R_k$ has its stated conditional law, while the remaining actual calendar time of this job is at least its latent residual service. Hence the positive part of $V(S_m)$ on this event is bounded in conditional expectation by the future total age cost up to return plus $(|\lambda|+|g|)$ times future return time and $|g|z$. On an empty path the value is constant. After multiplication by the survival indicator and expectation the bound tends to zero by integrability of the cycle's cost and length. Consequently $E\sum_{t<L}(c_t-g)\ge0$, and the return-cycle formula proves the universal lower bound. This route avoids imposing transversality on arbitrary competitors.

Under the selected rule every fresh cycle has deterministic initial wait $n$ (the least minimizer of the scalar waiting envelope), continuous service, and geometric empty delay of mean $z$. Length has finite mean and the nonnegative cycle cost after shifting by $|\lambda|$ has finite mean. The expected renewal-reward theorem gives the claimed limiting average from fresh. From every other fixed initial state the initial delay to fresh has finite expected length and finite expected shifted total cost: activation occurs by the first age with $b(d)\ge g$, followed by the conditional residual and geometric empty time. The delayed renewal theorem therefore gives the same limit. Equivalently for integer cycles, write expected accumulated nonnegative reward as the convolution of the renewal mass with the summable within-cycle expected rewards and apply the elementary Cesàro renewal theorem (renewal mass per time is at most one).

Banerjee and Ulukus [BU26, §§VI–VII] introduce the preemptive-resume age-of-job model and solve their geometric-service case. For general service their algorithm uses a max-weight fallback. Sun and Cyr derive sampling thresholds under nonlinear age penalties and random service. Theorem 5 and equations (70)–(72) of Ornee and Sun express the idle-channel index with an expected future age penalty and separately prescribe the occupied-channel action. The continuation here uses the residual service law at every phase where the job can be paused and resumed. Aalto [A26, equations (10) and (51)–(52)] also uses age and attained service for a convex holding cost, and treats general service through truncated productivity ratios for discounted control of a job until absorption and its continuous-time limit. Here completion regenerates the arm through Bernoulli arrivals. The average-cost proof covers every attained phase, including zero hazards, and gives a necessary and sufficient power-moment condition. Li et al. [LGHS25, §4, Corollary 1] obtain an expected future-cost priority in open M/M/1 classes, with the exponential queueing delay entering the expectation. The residual service in Section 10 instead depends on the attained phase of the job being controlled. Here the action classification includes every such phase and zero-hazard ties, and the moment test distinguishes every infinite-value service law for the power costs. No uniqueness claim for unbounded-service biases or hard-capacity multi-arm optimality is made.

## Formalization scope

Full Lean formalization will be delivered separately.

## References

- **[BU26]** S. Banerjee and S. Ulukus. *Preemptive Scheduling for Age of Job Minimization in Task-Specific Machine Networks*. arXiv:2602.02435v1, 2 February 2026. https://arxiv.org/html/2602.02435v1
- **[A26]** S. Aalto. *Dynamic scheduling with convex delay costs revisited*. Queueing Systems 110, article 2 (2026), published online 8 December 2025. https://doi.org/10.1007/s11134-025-09961-2
- **[LGHS25]** Z. Li, K. Gurushankar, M. Harchol-Balter, and A. Scheller-Wolf. *Improving Upon the generalized c-mu rule: a Whittle approach*. Author manuscript, 14 April 2025. https://li-zhouzi.github.io/files/whittle_TVHC.pdf
- **[TWTS20]** H. Tang, J. Wang, Z. Tang, and J. Song. *Scheduling to Minimize Age of Synchronization in Wireless Broadcast Networks With Random Updates*. IEEE Transactions on Wireless Communications 19(6), 4023--4037 (2020). https://doi.org/10.1109/TWC.2020.2979436

- Y. Sun and B. Cyr. *Sampling for Data Freshness Optimization: Non-linear Age Functions*. https://arxiv.org/abs/1812.07241
- T. Z. Ornee and Y. Sun. *Remote Estimation of Gauss-Markov Processes over Multiple Channels: A Whittle Index Policy*. https://arxiv.org/html/2305.04809v4
