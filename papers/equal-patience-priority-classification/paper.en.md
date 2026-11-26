# Strict Priority in Nonpreemptive Clearing Systems with Common Exponential Patience

**Wen Weixiang（文韦翔）**  
25 November 2026

**Research manuscript. No external peer review, journal acceptance, or formal verification is claimed.**

## Abstract

Consider a clearing system with two classes of jobs, independent exponential service times, independent exponential waiting lifetimes, and a positive reward for each job admitted to service. Service is nonpreemptive, and jobs cannot abandon after service begins. We prove the common-lifetime-rate branch of the strict-priority conjecture of Chen, Gayon, and Lemaire. When the common patience rate is positive, priority to class 1 is optimal for every finite initial state, relative to all nonanticipating, work-conserving, nonpreemptive dynamic policies, if and only if its reward-weighted service rate and its reward-weighted sum of service and patience rates are both at least those of class 2. We also prove the conjectured necessity of the two original inequalities for arbitrary positive, possibly unequal, patience rates. The sufficient direction uses a scalar marginal recurrence, rational comparison functions, and a residual certificate for the actual nonpreemptive Bellman equations. Parameter regions on either side of the patience rate and all equality boundaries are included. The necessary reward-rate condition follows from a weighted-mean limit for a single initial deviation, rather than from a fluid approximation. Exact rational computations independently check finite-state Bellman values and two witnesses showing that neither inequality can be omitted. The equal-reward branch with unequal patience rates and fully heterogeneous sufficiency are outside the results.

## 1. Introduction and contribution

When waiting jobs may abandon, a scheduling decision trades a job's immediate reward against the service opportunities lost while it occupies the server. A two-job comparison can identify which of two isolated jobs should start first. It does not by itself determine whether that same priority remains optimal in every larger system.

Chen, Gayon, and Lemaire [1] studied this question for two classes in a nonpreemptive clearing system. They proved necessary and sufficient conditions for homogeneous service-time distributions. For heterogeneous exponential service times, their Conjecture 1 proposes two necessary conditions, and conjectures that these become sufficient if the two classes share a service rate, a patience rate, or a reward. The homogeneous-service branch was established in their paper. The present work addresses the common-patience branch and the general necessary direction of that conjecture.

An earlier ROADEF 2021 abstract by Gayon, Chen, and Lemaire [2] reports necessity when preemption is allowed and sufficiency for three jobs, without giving those proofs in the two-page abstract. We credit those reported partial results. The increments established here are sufficiency for every finite population under common patience, and necessity in the original nonpreemptive model with arbitrary positive parameters. We do not treat either the three-job result or the preemptive necessary direction as a new contribution.

Earlier results already cover important subclasses. Argon, Ziya, and Righter [3] prove priority optimality under compatible stochastic orderings of lifetime and service distributions, principally for maximizing the number served. Jacobson, Argon, and Ziya [4] allow job-dependent rewards and establish several sufficient regimes; their Proposition 5 also contains the two-job necessary comparison used below. Aligned advantages and the common-patience, equal-reward case are therefore credited to existing work. The increment in T1 is the complete positive-parameter classification, including conflicting reward and service-rate orderings. Salch, Gayon, and Lemaire [5] instead optimize static lists with random due dates: late jobs remain and are processed. That model and policy class differ from the dynamic abandonment system considered here.

Our contribution has two parts. First, we establish an exact, all-state classification under common positive exponential patience, allowing arbitrary positive service rates and rewards. The proof covers the full class of nonanticipating nonpreemptive dynamic policies, including policies that use past observations or independent randomization. Second, we prove both proposed necessary conditions without assuming equal patience. A violation of the reward-rate condition is detected by an explicit family of states with many high-priority jobs and one low-priority job.

The main technical step is a certificate for a scalar marginal of the strict-priority value function. Two rational comparison functions handle service rates on the same side of the patience rate. Elementary upper and lower functions handle the mixed region. These inequalities feed into a recursion for a genuine first-action deviation in the nonpreemptive model; we do not substitute a problem in which the service class can be changed at abandonment epochs.

The study is confined to two job classes, no arrivals, independent exponential primitives, and strictly positive rates and rewards. It establishes the specified branches of [1], rather than the entire conjecture. The comparison with [1] is limited to the mathematical statements and literature cited here.

## 2. Model and main results

Initially there are $n_i\in\mathbb N_0$ jobs of class $i\in\{1,2\}$. There are no subsequent arrivals. A class-$i$ job has service time distributed as $\operatorname{Exp}(\mu_i)$, waiting lifetime distributed as $\operatorname{Exp}(\gamma_i)$, and reward $w_i$, where

$$
\mu_i>0,\qquad \gamma_i>0,\qquad w_i>0.
$$

All service times and lifetimes are independent. A job abandons if its waiting lifetime expires before its service starts. Once admitted to service, it cannot abandon, and it must complete without preemption. Its reward is earned when service begins. A policy is nonanticipating and work-conserving. It chooses a waiting job at time zero and whenever the server becomes free. It can use elapsed time, observed service and abandonment events, its past choices, and independent randomization; unexpired lifetime realizations and uncompleted service durations are not revealed in advance.

Write $\mathrm{SP}_i$ for strict priority to class $i$. Within-class choices are immaterial because jobs in a class have identical independent distributions. A policy is **uniformly optimal** if it maximizes expected total reward for every finite initial pair $(n_1,n_2)$. This means the same priority rule works for all initial states; it does not restrict the competing policies to fixed job lists.

### Theorem T1. Common-patience classification

Suppose $\gamma_1=\gamma_2=\gamma>0$. Then $\mathrm{SP}_1$ is uniformly optimal if and only if

$$
w_1\mu_1\ge w_2\mu_2,
\qquad
w_1(\mu_1+\gamma)\ge w_2(\mu_2+\gamma). \tag{2.1}
$$

Equivalently, after setting

$$
a=\frac{\mu_1}{\gamma},\qquad
b=\frac{\mu_2}{\gamma},\qquad
r=\frac{w_1}{w_2},
$$

the criterion is

$$
r\ge r_*(a,b):=
\max\left\{\frac ba,\frac{b+1}{a+1}\right\}. \tag{2.2}
$$

The larger term in (2.2) is $b/a$ when $a\le b$, and $(b+1)/(a+1)$ when $a\ge b$.

### Theorem T2. Necessary conditions with unequal patience

For arbitrary positive $\mu_i,\gamma_i,w_i$, uniform optimality of $\mathrm{SP}_1$ implies

$$
w_1\mu_1\ge w_2\mu_2,
\qquad
\frac{w_1\gamma_1}{\mu_2+\gamma_1}
\ge
\frac{w_2\gamma_2}{\mu_1+\gamma_2}. \tag{2.3}
$$

These are the two conditions proposed in Conjecture 1(i) of [1]. Theorem T2 makes no sufficiency claim for unequal patience.

The sufficient direction of T1 is proved in Sections 3–5. Section 6 proves T2 and completes the necessary direction of T1.

## 3. Exact recurrences under common patience

In this section and Sections 4–5, scale time so that the common patience rate is one. Service rates are then $a,b>0$. Let $F(n,m)$ denote the expected total reward of $\mathrm{SP}_1$ starting from $n$ class-1 jobs and $m$ class-2 jobs.

The pair of remaining class counts is a sufficient state at every service decision. Conditional on any past history and on having survived until the decision, each waiting lifetime is again exponential with its original rate. Unstarted service times remain independent of that history. Thus finite-state Bellman recursion is valid even against history-dependent randomized policies. Randomization cannot exceed the larger of the two conditional first-action values.

### Lemma L1. Strict-priority value recurrence

For $c>0$, define

$$
S_c(k)=\sum_{j=0}^{k-1}\frac{c}{c+j},\qquad S_c(0)=0.
$$

Then

$$
F(n,0)=w_1S_a(n),\qquad F(0,m)=w_2S_b(m). \tag{3.1}
$$

For $n\ge1,m\ge0$,

$$
(a+n+m-1)F(n,m)
=(a+n-1)F(n-1,m)+mF(n,m-1)+aw_1, \tag{3.2}
$$

where a term multiplied by $m=0$ is omitted.

**Proof.** Start one class-1 job and earn $w_1$. During its service, the next event is its completion at rate $a$, a class-1 waiting abandonment at total rate $n-1$, or a class-2 abandonment at rate $m$. After completion, the continuation value is $F(n-1,m)$. After a waiting abandonment the server remains busy on the same job. Memorylessness gives continuation values $F(n-1,m)-w_1$ and $F(n,m-1)-w_1$, respectively. The subtracted reward was already earned. First-event conditioning and rearrangement give (3.2). On an axis, (3.2), or its class-2 counterpart, telescopes to (3.1). Every service completes almost surely and only finitely many jobs can start, so all these values are finite. $\square$

### Lemma L2. Scalar marginal recurrence

For $n\ge0,m\ge1$, put

$$
q(n,m)=\frac{F(n,m)-F(n,m-1)}{w_2}.
$$

Then $q$ is independent of the two rewards, and

$$
q(0,m)=\frac b{b+m-1},\qquad
q(n,1)=\frac a{a+n}. \tag{3.3}
$$

For $n\ge1,m\ge2$, it satisfies

$$
(a+n+m-1)q(n,m)
=(a+n-1)q(n-1,m)+(m-1)q(n,m-1). \tag{3.4}
$$

**Proof.** Subtract (3.2) at $m-1$ from the equation at $m$. The denominators differ by one, and after retaining that difference the resulting equation is (3.4). The same calculation at $m=1$, with the zero-coefficient term omitted, yields

$$
(a+n)q(n,1)=(a+n-1)q(n-1,1).
$$

Since $q(0,1)=1$, this telescopes to the second boundary in (3.3). The first boundary follows from (3.1). These reward-free boundaries and the triangular recurrence establish reward independence. They also show $q>0$. $\square$

For a function $h$ on $n\ge0,m\ge1$, define its interior residual by

$$
\mathcal L h(n,m)
=(a+n+m-1)h(n,m)
-(a+n-1)h(n-1,m)-(m-1)h(n,m-1). \tag{3.5}
$$

If $\mathcal Lh\le0$ and $h\le q$ on $n=0$ and $m=1$, then $h\le q$ everywhere. If both inequalities are reversed, the conclusion is reversed. This comparison principle follows directly by induction on $n+m$, because the recurrence denominator and both interior coefficients are positive.

### Lemma L3. Elementary marginal bounds

For all $n\ge0,m\ge1$,

$$
\ell(n,m):=\frac{ab}{(a+n)(b+m-1)}
\le q(n,m)\le
u(n,m):=\frac a{a+n}. \tag{3.6}
$$

If $b\ge1$, then also

$$
q(n,m)\le v(m):=\frac b{b+m-1}. \tag{3.7}
$$

**Proof.** The lower function equals $q$ on both boundaries in (3.3), and for $m\ge2$,

$$
\mathcal L\ell
=-\frac{ab(m-1)}{(a+n)(b+m-2)(b+m-1)}\le0.
$$

The upper function $u$ dominates the boundary values, and $\mathcal Lu=0$. The comparison principle proves (3.6). For (3.7), $v$ also dominates both boundaries when $b\ge1$, and

$$
\mathcal Lv
=\frac{b(b-1)}{(b+m-2)(b+m-1)}\ge0.
$$

All denominators here are positive, including when $m=2$. $\square$

The proof uses only finite rational recurrences. In particular, a distributional representation of the strict-priority clearing time is unnecessary for the sufficient direction.

## 4. From a scalar certificate to the nonpreemptive Bellman inequality

Let $G(n,m)$, for $m\ge1$, be the value of the policy that first starts one class-2 job and thereafter follows $\mathrm{SP}_1$. Set $D=F-G$. On the boundary $n=0$, $D(0,m)=0$.

### Lemma L4. True first-action deviation recursion

For $n,m\ge1$,

$$
(b+n+m-1)G(n,m)
=bF(n,m-1)+nG(n-1,m)+(m-1)G(n,m-1)+bw_2. \tag{4.1}
$$

Consequently,

$$
(b+n+m-1)D(n,m)
=nD(n-1,m)+(m-1)D(n,m-1)+\mathcal R(n,m), \tag{4.2}
$$

where, for $r=w_1/w_2$,

$$
\frac{\mathcal R(n,m)}{w_2}
=\frac{na r-b(a+n-1)+H(n,m)q(n,m)}{a+n-1}, \tag{4.3}
$$

and

$$
H(n,m)=(a-1)(b+m-1)+n(b-1). \tag{4.4}
$$

Terms multiplied by $m-1=0$ are omitted.

**Proof.** After the initial reward $w_2$, the ongoing class-2 service completes at rate $b$; class-1 and class-2 waiting jobs abandon at total rates $n$ and $m-1$. A completion leaves continuation $F(n,m-1)$. A waiting abandonment leaves $G(n-1,m)-w_2$ or $G(n,m-1)-w_2$. In both cases the server continues processing the same class-2 job; no new scheduling action is permitted. Rearrangement gives (4.1).

Subtract this equation from the corresponding expression involving $F$. With

$$
x=F(n,m)-F(n-1,m),\qquad
y=F(n,m)-F(n,m-1)=w_2q(n,m),
$$

the remaining source is $\mathcal R=nx+(b+m-1)y-bw_2$. Equation (3.2) implies

$$
(a+n-1)x+my=aw_1.
$$

Substitution gives (4.3). $\square$

If the numerator in (4.3) is nonnegative for all $n,m\ge1$, (4.2) proves $D\ge0$ by induction. An additional induction on the total initial number of jobs then proves optimality among all admissible dynamic policies. Indeed, after the first service starts and subsequently completes, at most $n+m-1$ jobs remain. The induction hypothesis makes $\mathrm{SP}_1$ an optimal continuation from every resulting state. Thus $F$ and $G$ are exactly the two optimal first-action values, and $F\ge G$ selects class 1.

This argument is a certificate for the original nonpreemptive problem. It does not require, or assert, equivalence with a model allowing a class change while a job is in service.

## 5. The all-parameter sufficient direction

The numerator of (4.3) is increasing in $r$. It is therefore enough to prove its nonnegativity at the boundary $r_*(a,b)$ in (2.2). For brevity write

$$
A=a-1,\quad B=b-1,\quad
p=a+n-1,\quad d=a+n+m-1.
$$

The symbols $A$ and $B$ may have either sign. Care with those signs is essential when using rational comparison functions.

### Lemma L5. Boundary $a\le b$

If $a\le b$, then for all $n,m\ge1$,

$$
H(n,m)q(n,m)\ge b(a-1). \tag{5.1}
$$

**Proof.** First assume $A,B$ are nonzero and have the same sign. Then $H,H-A,H-B$ all have that sign in the interior $n\ge1,m\ge2$. Set

$$
h(n,m)=\frac{bA}{H(n,m)}.
$$

At $n=0$, $q=h$, and at $m=1$,

$$
H(n,1)q(n,1)-bA=\frac{n(b-a)}{a+n}\ge0. \tag{5.2}
$$

Direct common-denominator expansion gives the identity

$$
\mathcal Lh
=\frac{bA(a-b)Bp}{H(H-A)(H-B)}. \tag{5.3}
$$

If $1 \lt a\le b$, then $\mathcal Lh\le0$, $H>0$, and (5.2) gives $h\le q$ on the boundaries. The comparison principle yields $q\ge h$, which is (5.1). If $0 \lt a\le b<1$, then $\mathcal Lh\ge0$ and $H<0$. The boundary inequality becomes $q\le h$, and comparison gives the same inequality throughout. Multiplication by the negative $H$ again yields (5.1).

If $a<1 \lt b$, use (3.7):

$$
Hq-bA
=A\big((b+m-1)q-b\big)+nBq\ge0.
$$

Here the two factors in the first product are nonpositive, and the second term is nonnegative. Finally, the cases $a=1$ or $b=1$ follow by continuity. For each fixed integer state, $q$ is continuous in positive $a,b$ by the finite recurrence (3.4), which has positive denominators. We take limits in (5.1), not in a possibly singular comparison function. $\square$

At $r=b/a$, the numerator of (4.3) is precisely $Hq-b(a-1)$. Lemma L5 therefore proves the sufficient boundary for $a\le b$.

### Lemma L6. Boundary $a\ge b$, rates on the same side of one

Suppose $a\ge b$ and either $a,b>1$ or $a,b<1$. Put

$$
c=\frac{a-b}{a+1},\qquad M(n)=b(a-1)-nc.
$$

Then

$$
H(n,m)q(n,m)\ge M(n) \qquad(n,m\ge1). \tag{5.4}
$$

**Proof.** Set $h=M/H$. At $n=0$, $q=h$; at $m=1$,

$$
H(n,1)q(n,1)-M(n)
=\frac{n(n-1)(a-b)}{(a+1)(a+n)}\ge0. \tag{5.5}
$$

For $N=n-1\ge0$ and $L=m-1\ge1$, let

$$
P=A^2L(L+1+2B)+B^2N(N+1+2A)+2AB(LN+L+N).
$$

A common-denominator calculation gives

$$
\mathcal Lh
=-\frac{(a-b)pP}{(a+1)H(H-A)(H-B)}. \tag{5.6}
$$

If $A,B>0$, all terms in $P$ are nonnegative. If $A,B<0$, the same conclusion follows because

$$
L+1+2B=L-1+2b>0
$$

for $L\ge1$, while $N+1+2A=N-1+2a>0$ whenever $N\ge1$. At $N=0$ the second term vanishes. Also $AB>0$. Thus $P\ge0$ in both parameter regions.

For $a,b>1$, the denominator in (5.6) is positive, so $h$ is a lower comparison function and $q\ge h$. For $a,b<1$, that denominator is negative, so $h$ is an upper comparison function and $q\le h$. The boundary ordering in each case follows from (5.5) and the sign of $H$. Both conclusions give (5.4). $\square$

### Lemma L7. Mixed rates $a>1>b$

For $a>1>b$, inequality (5.4) holds for all $n,m\ge1$.

**Proof.** Use the two bounds $\ell\le q\le u$ from (3.6). If $H\ge0$, direct expansion gives

$$
H\ell-M
=\frac{n\big((a-b)(n-1)(b+m-1)
+a(a+1)(1-b)(m-1)\big)}
{(a+1)(a+n)(b+m-1)}\ge0. \tag{5.7}
$$

It follows that $Hq\ge H\ell\ge M$. If $H\le0$, use

$$
Hu-M
=\frac{a(a^2-1)(m-1)+(a-b)n(n-1)}{(a+1)(a+n)}\ge0. \tag{5.8}
$$

Multiplication of $q\le u$ by $H\le0$ gives $Hq\ge Hu\ge M$. These two alternatives include $H=0$, so no division by a potentially vanishing $H$ is required. $\square$

For completeness, a different positive-source induction independently verifies this mixed region. With $R=Hq-M$, recurrence (3.4) yields

$$
\begin{aligned}
dR(n,m)={}&pR(n-1,m)+(m-1)R(n,m-1)\\
&+p(b-1)q(n-1,m)+(m-1)(a-1)q(n,m-1)\\
&+(a+2n-1)c-b(a-1).
\end{aligned} \tag{5.9}
$$

Since $q(n-1,m)\le a/p$ and $b-1<0$, the last two lines are at least

$$
2(n-1)c+(m-1)(a-1)q(n,m-1)\ge0.
$$

The boundaries $R(0,m)=0$ and (5.5) give $R\ge0$ by induction. Either (5.7)–(5.8) or (5.9) suffices for Lemma L7.

### Completion of the sufficient direction of T1

At $r=(b+1)/(a+1)$, the numerator of (4.3) is $Hq-M$. Lemmas L6–L7 prove its nonnegativity for $a\ge b$ away from $a=1$ and $b=1$. Continuity of the finite recurrence establishes those boundary cases as well. Lemma L5 handles $a\le b$. Since the numerator is increasing in $r$, it is nonnegative whenever (2.2) holds. Lemma L4 and the two finite-state inductions after it prove uniform optimality of $\mathrm{SP}_1$.

Only the dimensionless boundaries $a=1$ or $b=1$ are treated by continuity. No passage to zero patience is made.

## 6. General necessity and completion of T1

We now allow unequal positive patience rates. This section proves Theorem T2 directly in the original nonpreemptive system.

### The two-job condition

At state $(1,1)$, the expected rewards from the two initial actions are

$$
w_1+w_2\frac{\mu_1}{\mu_1+\gamma_2},
\qquad
w_2+w_1\frac{\mu_2}{\mu_2+\gamma_1}.
$$

The first is at least the second exactly when the second inequality in (2.3) holds. Uniform optimality therefore implies that inequality. This known two-job comparison also appears in [4, Proposition 5]; its calculation is included to make the proof self-contained.

### Lemma L8. Loss from an initial service delay

Let $a,b>0$, and consider $n$ identical waiting jobs with unit patience rate. After an independent delay distributed as $\operatorname{Exp}(b)$, serve the survivors, all of which have service rate $a$ and unit reward. Let $J_n$ be the expected number eventually served, and put

$$
L_n=S_a(n)-J_n.
$$

Then $L_0=0$,

$$
(b+n)L_n=nL_{n-1}+\frac{an}{a+n-1}, \tag{6.1}
$$

and

$$
\lim_{n\to\infty}L_n=\frac ab. \tag{6.2}
$$

**Proof.** Before the delay ends, its expiration occurs at rate $b$, and waiting jobs abandon at total rate $n$. Consequently

$$
(b+n)J_n=bS_a(n)+nJ_{n-1}.
$$

Subtraction from $(b+n)S_a(n)$, using
$S_a(n)-S_a(n-1)=a/(a+n-1)$, gives (6.1).

For $1\le k\le n$, define

$$
W_{n,k}=\frac b{b+k}\prod_{j=k+1}^{n}\frac j{b+j}.
$$

Unrolling (6.1) gives

$$
L_n=\frac ab\sum_{k=1}^{n}W_{n,k}\frac{k}{a+k-1},\qquad
\sum_{k=1}^{n}W_{n,k}
=1-\prod_{j=1}^{n}\frac j{b+j}. \tag{6.3}
$$

The product tends to zero. Indeed, for positive numbers $t_j$,
$\prod_j(1+t_j)\ge1+\sum_jt_j$, so

$$
\prod_{j=1}^{n}\frac j{b+j}
\le\frac1{1+b\sum_{j=1}^{n}1/j}\longrightarrow0.
$$

The same bound on the tail product shows $W_{n,k}\to0$ for every fixed $k$. Finally, $k/(a+k-1)$ is bounded and tends to one. Given any positive error tolerance, choose $K$ so that the deviation from one is below that tolerance for $k>K$. The finitely many terms with $k\le K$ have total contribution tending to zero, while the remaining weights have total mass tending to one by (6.3). Thus the weighted sum in (6.3) tends to one, proving (6.2). $\square$

### Lemma L9. A surviving low-priority job vanishes in the many-job limit

Start with $n\ge1$ class-1 jobs and let $\tau_n$ be the time until $\mathrm{SP}_1$ has cleared them all, including completion of the last class-1 service. For any $s>0$,

$$
\mathbb E e^{-s\tau_n}
=\prod_{j=0}^{n-1}
\frac{\mu_1+j\gamma_1}{\mu_1+j\gamma_1+s}
\longrightarrow0. \tag{6.4}
$$

**Proof.** When $k\ge1$ class-1 jobs remain, one is in service and $k-1$ are waiting. A class-1 departure occurs at total rate $\mu_1+(k-1)\gamma_1$. Whether the departure is a completion or an abandonment, memorylessness restores the same description with $k-1$ jobs, until the final service completes. First-event conditioning gives the factors in (6.4).

To prove convergence, set $a=\mu_1/\gamma_1$ and $c=s/\gamma_1>0$. The product is bounded by

$$
\frac1{1+c\sum_{j=0}^{n-1}1/(a+j)}\longrightarrow0,
$$

using the same elementary product inequality as in Lemma L8 and divergence of the harmonic sum. $\square$

### Proof of Theorem T2

It remains to prove the first inequality in (2.3). Examine the initial state $(n,1)$. Under $\mathrm{SP}_1$, the class-1 expected reward is
$w_1S_a(n)$, where $a=\mu_1/\gamma_1$. The lone class-2 job is served exactly when it survives until all class-1 jobs clear. Thus the full expected reward is

$$
V_{\rm SP1}(n,1)
=w_1S_a(n)+w_2\rho_n,
\quad
\rho_n=\mathbb E e^{-\gamma_2\tau_n}\longrightarrow0. \tag{6.5}
$$

Consider the admissible deviation that serves the class-2 job first and then serves all surviving class-1 jobs. Its first reward is $w_2$, and its service acts as an independent exponential delay for the class-1 population. In units of $1/\gamma_1$, that delay has rate $b=\mu_2/\gamma_1$. Lemma L8 shows that the difference between strict priority and this deviation is

$$
w_1L_n-w_2(1-\rho_n)
\longrightarrow w_1\frac{\mu_1}{\mu_2}-w_2. \tag{6.6}
$$

Uniform optimality makes every left-hand side nonnegative. The limit is therefore nonnegative, which is equivalent to $w_1\mu_1\ge w_2\mu_2$. Together with the two-job comparison, this proves T2. $\square$

If the reward-rate inequality is strict in the wrong direction, (6.6) also proves that a finite state $(n,1)$ defeats $\mathrm{SP}_1$: all sufficiently large $n$ do so. No claim about a particular finite cutoff is needed.

### Completion of Theorem T1

Set $\gamma_1=\gamma_2=\gamma>0$ in T2. Its second condition becomes

$$
\frac{w_1}{\mu_2+\gamma}\ge\frac{w_2}{\mu_1+\gamma},
$$

equivalent to the second condition in (2.1). Therefore (2.1) is necessary. Section 5 already proved it sufficient. $\square$

## 7. Consequences, exact witnesses, and reproducibility

### Corollary C1. Classification of the two strict priorities

Under common positive patience, $\mathrm{SP}_2$ is uniformly optimal exactly when both inequalities in (2.1) are reversed. If

$$
(w_1\mu_1-w_2\mu_2)
\big(w_1(\mu_1+\gamma)-w_2(\mu_2+\gamma)\big)<0,
$$

neither strict-priority rule is uniformly optimal. Both are uniformly optimal simultaneously exactly when $w_1=w_2$ and $\mu_1=\mu_2$.

**Proof.** Exchange the class labels in T1. For simultaneous optimality both differences must vanish. Subtracting them gives $\gamma(w_1-w_2)=0$, whence the positive-$\gamma$ assumption gives equal rewards, and positive rewards then give equal service rates. Conversely, in that case the classes have identical primitives, so every admissible work-conserving choice has the same count-based law and expected reward. $\square$

The following examples use normalized patience $\gamma=1$ and $w_2=1$. They show that each scalar condition has independent content.

| Parameters and initial state | Inequality that fails | Strict-priority value | Value after first serving class 2 and then using SP1 | Improvement |
|---|---|---:|---:|---:|
| $a=1,b=2,r=7/4,(n,m)=(4,3)$ | Reward-rate condition only | $2343/560$ | $3017/720$ | $2/315$ |
| $a=2,b=1,r=3/5,(n,m)=(1,1)$ | Two-job condition only | $19/15$ | $13/10$ | $1/30$ |

These values follow exactly from (3.2) and (4.1). The finite-state Bellman computation in the companion code also finds the stated alternative value to be optimal at each displayed state. The examples are not asserted to be minimal counterexamples.

The script `code/verify_exact.py`, run from the case directory, evaluates service-completion Bellman values using exact rational arithmetic. The recorded run covers 50 parameter settings and 4,050 state evaluations, as well as 3,600 residual and marginal-bound checks. Service-rate values are $1/5,1/2,1,2,5$; each ordered pair is checked at the threshold reward ratio and at a ratio 10 percent above it. The state grid is $0\le n,m\le8$. The script also checks the two witnesses above. Results are recorded in `results/exact_diagnostics.json`.

These computations are reproducible diagnostics. The universal quantifiers in T1 and T2 are justified by the proofs, rather than by the finite grid. The rational identities (5.3), (5.6), (5.7), and (5.8) can additionally be checked by bringing both sides to a common denominator; their sign analysis is supplied in the text.

## 8. Scope and remaining questions

The results establish general necessity and common-patience sufficiency in the original two-class, nonpreemptive clearing model of [1]. In particular, no service-rate ordering relative to the patience rate is required. The crossing regions and equality cases are part of the theorem.

The paper does not establish sufficiency when only the rewards agree and the patience rates differ. It does not characterize optimal policies under fully heterogeneous parameters, introduce job arrivals, or extend the priority criterion to three or more classes. Nor does it address nonexponential patience, where elapsed waiting times generally become relevant state information.

Strictly positive patience is essential to the necessity statement. At zero patience rate no job abandons, every finite work-conserving policy eventually serves every job, and total reward is independent of the service order. The all-initial-state characterization therefore cannot be extended to zero patience by interchanging a parameter limit with the quantifier over initial populations.

No Lean source or compilation result accompanies this research round. A subsequent full formalization must cover the model-to-recursion justification, all rational comparison regions, the weighted-mean limit, both necessity arguments, and the stated boundary cases. Finite-state computations alone do not discharge those obligations.

## References

[1] Gang Chen, Jean-Philippe Gayon, and Pierre Lemaire. **Technical Note—Stochastic Scheduling with Abandonment: Necessary and Sufficient Conditions for the Optimality of a Strict Priority Policy.** *Operations Research* 71(5), 1789–1793, 2023; published online 1 April 2022. DOI: [10.1287/opre.2022.2285](https://doi.org/10.1287/opre.2022.2285). Author's full manuscript, including Conjecture 1 and the appendices: [stochastic-scheduling-2022.pdf](https://perso.isima.fr/~jpgayon/Documents/PublicationsJP/WorkingPapers/stochastic-scheduling-2022.pdf). The claims addressed here are Conjecture 1(i) and the common-patience branch of Conjecture 1(ii).

[2] Jean-Philippe Gayon, Gang Chen, and Pierre Lemaire. **Stochastic scheduling with abandonment: Necessary and sufficient conditions for the optimality of a strict priority policy.** ROADEF 2021, two-page conference abstract. [Full abstract](https://roadef2021.sciencesconf.org/350950/Conf_ROADEF_2021_Ordo_stochastique_New_version_.pdf). Sections 1–2 report the preemptive necessity and three-job sufficiency results discussed above.

[3] Nilay Tanık Argon, Serhan Ziya, and Rhonda Righter. **Scheduling impatient jobs in a clearing system with insights on patient triage in mass casualty incidents.** *Probability in the Engineering and Informational Sciences* 22(3), 301–332, 2008. DOI: [10.1017/S0269964808000272](https://doi.org/10.1017/S0269964808000272). [Author-hosted full text](https://ziya.web.unc.edu/wp-content/uploads/sites/15166/2018/02/Argon-Ziya-Righter-2008.pdf).

[4] Evin Uzun Jacobson, Nilay Tanık Argon, and Serhan Ziya. **Priority Assignment in Emergency Response.** *Operations Research* 60(4), 813–832, 2012. DOI: [10.1287/opre.1120.1075](https://doi.org/10.1287/opre.1120.1075). [Author-hosted full text](https://ziya.web.unc.edu/wp-content/uploads/sites/15166/2018/02/Uzun-Jacobson-Argon-Ziya-2012.pdf).

[5] Alexandre Salch, Jean-Philippe Gayon, and Pierre Lemaire. **Optimal static priority rules for stochastic scheduling with impatience.** *Operations Research Letters* 41(1), 81–85, 2013. DOI: [10.1016/j.orl.2012.11.008](https://doi.org/10.1016/j.orl.2012.11.008). [Author's full manuscript](https://perso.isima.fr/~jpgayon/Documents/PublicationsJP/WorkingPapers/static_ibs_ies.pdf).
