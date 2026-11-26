# The Cost of Zeros in Exact Adaptive Rejection Sampling

Sharp rejection complexity, automatic adaptation, and a logarithmic endpoint

## Abstract

We study normalized, nonnegative Hölder densities on a unit cube in the standard adaptive rejection model: one exact density evaluation is made at each proposal, and every output is accepted by the usual envelope test. For dimension $d\ge1$, exponent $0 \lt s\le1$, and Hölder radius $H>1+s/d$, we prove that the minimax expected number of rejections in $n$ evaluations is of order $n^{d/(d+s)}$. The lower bound holds even for policies allowed invalid envelopes when a failure incurs loss $n$. A single horizon-free dyadic algorithm attains the upper bound, using only evaluated proposals. Without knowing any density floor, it also attains $n^{1-s/d}$ when $d>s$ and the target is bounded below, and $\log(n+1)$ at the one-dimensional Lipschitz endpoint. We prove the latter rate optimal for universally valid envelope policies, even at the uniform target. A density-profile inequality gives faster guarantees under an integrable negative moment without a positive floor. We identify the exact radius at which zeros become possible and classify the densities attaining zero at that radius. These are oracle-evaluation results for standard adaptive rejection, not query lower bounds for every exact simulation method.

## 1. Introduction and relation to earlier work

Adaptive rejection sampling learns an upper envelope while producing samples. Smoothness controls local approximation error, but the observations themselves arrive from the current proposal. Where a target is small, learning its shape can therefore require precisely the rejected proposals that the method aims to avoid. The question is whether this feedback changes the optimal rejection exponent when the density is allowed to vanish.

Achddou, Lam-Weil, Carpentier and Blanchard [1] established the principal minimax formulation for adaptive rejection sampling and proved near-optimal bounds under a positive density floor. Their Section 5 explicitly asks about extension to targets without that floor. Their method already preserves sampling correctness without a floor; the missing issue relevant here is sharp efficiency. We address the normalized model using a different sampler. We do not assert a new efficiency theorem for NNARS itself.

Our upper argument charges each dyadic cell for at most one rejection and bounds that charge in two ways: by its conditional rejection probability when visited, and by its probability of being visited within the budget. Summing the smaller charge yields both the nonnegative and positive-floor rates. Our lower argument keeps normalization fixed across a finite family and separates observations of a low-density region into accepted mass and rejected exploration. This exposes a different information balance from the positive-floor lower construction. Fixed-count bump normalization itself is inherited from the methodology of [1]; it is not a new device claimed here.

Related methods have different information interfaces or losses. Pliable rejection sampling [2] learns proposals through a kernel estimate with a high-probability correctness guarantee. Safe adaptive importance sampling [3] couples proposal estimation with an exploration mixture and studies weighted integration and asymptotic variance. The shared issue is adaptive proposal learning; our exact accepted stream and finite-budget rejection loss do not improve its central limit theorem. Discrete shape-constrained rejection [4] concerns preprocessing query cost for a constant acceptance rate. Privacy-aware rejection [5] uses, among other assumptions, a Hölder log-density and a different runtime objective. Approximate rejection from a fixed candidate pool [6,8] controls distributional error rather than this cumulative loss.

Holzmüller and Bach [7] analyze sampling and log-partition estimation for smooth log-densities. Their approximate-output information model is different, and their Proposition 13 also illustrates why a lower bound for standard envelope rejection must not be advertised as a bound for all exact samplers: a special normalized positive class admits an exact one-query construction with a different output rule. Interval arithmetic methods [9] supply another, stronger envelope oracle than point values alone. Classical adaptive rejection [10] may use squeeze tests that emit a sample without a new density evaluation. Such methods are outside the one-evaluation-per-proposal accounting used here.

The principal new conclusions are the matching nonnegative-class exponent, the same algorithm's automatic adaptation, and the exact-policy logarithmic endpoint. The density-profile estimate and sharp radius geometry clarify their range. Our inspection of the sources listed here and the accompanying source audit found no equivalent complete theorem; this bounded literature check is not a certificate of global priority.

## 2. Model, risks, and exactness

Let $D=[0,1]^d$ carry Lebesgue measure of total mass one. Fix an integer $d\ge1$, $0 \lt s\le1$, and $H\ge0$. Define
$$
\mathcal F_{d,s,H}=\left\{f:D\to[0,\infty):\int_D f=1,\quad
|f(x)-f(y)|\le H\|x-y\|_\infty^s\ \text{for all }x,y\in D\right\}.
$$
The values $d,s,H$ and the normalization one are known. The target oracle returns the exact real value at a queried point. For $0 \lt c<1$, write $\mathcal F_{d,s,H}(c)=\{f\in\mathcal F_{d,s,H}: f\ge c\}$.

At round $t$, a policy uses the full past and independent private randomness to choose a measurable probability density $q_t$ and a finite multiplier $M_t>0$. It sets $U_t=M_tq_t$, draws $X_t\sim q_t$, evaluates $f(X_t)$, and accepts precisely when an independent uniform $V_t$ satisfies $V_t\le f(X_t)/U_t(X_t)$. Ratios larger than one mean automatic acceptance; the convention where $q_t=0$ is irrelevant to the proposal. There is exactly one evaluation and at most one output per round. The policy can know the budget $n$. Its kernels and envelope-validity events are assumed measurable. Lower bounds allow all such policies, not only partitions or local updates.

An envelope is valid when $U_t\ge f$ Lebesgue almost everywhere. Let $F_n$ denote failure of at least one of the first $n$ envelopes and let $R_n$ be the actual rejection count. A **universally valid policy** has $\mathbb P_f(F_n)=0$ for every target and every finite $n$. We call this the exact policy class and write $\mathfrak A_{\mathrm{ex}}(\mathcal F)$. This term refers to envelope validity; for the algorithm constructed below we separately prove that every accepted index is finite and the infinite accepted stream is iid.

For arbitrary standard rejection policies define the envelope-failure penalized loss
$$
L_n=R_n\mathbf 1_{F_n^c}+n\mathbf 1_{F_n}.
$$
In particular $L_n\ge R_n$ and $\mathbb E L_n\ge n\mathbb P(F_n)$. Write
$$
\mathcal R_n^{\mathrm{ex}}(\mathcal F)=\inf_{A\in\mathfrak A_{\mathrm{ex}}(\mathcal F)}\sup_{f\in\mathcal F}\mathbb E_fR_n,
\qquad
\mathcal R_n^{\mathrm{pen}}(\mathcal F)=\inf_A\sup_{f\in\mathcal F}\mathbb E_fL_n.
$$
The second infimum ranges over all policies just described; thus $\mathcal R_n^{\mathrm{pen}}\le\mathcal R_n^{\mathrm{ex}}$. This is the normalized envelope-failure convention corresponding to [1]. It is not a universal loss for arbitrary exact simulators.

The oracle model grants no gradient, regional integral, direct target sampler, free pilot evaluations, or squeeze outputs without evaluations. Sampling from a specified proposal and arithmetic on exact real heights are idealized. We analyze density evaluations, not bit complexity or a dimension-uniform runtime. If $H=0$, normalization forces $f\equiv1$; the known uniform sampler has zero rejections. We assume $H>0$ below unless explicitly stated.

Whenever an envelope is valid, for every Borel $B\subseteq D$,
$$
\mathbb P(X_t\in B,\ t\text{ accepted}\mid\mathcal H_t)=\frac{\int_B f}{M_t},
\qquad
\mathbb P(t\text{ rejected}\mid\mathcal H_t)=1-\frac1{M_t},                 \tag{2.1}
$$
where $\mathcal H_t$ includes the chosen envelope but precedes the new proposal. These identities follow by multiplying $q_t$ by $f/U_t$. Our algorithm has $1\le M_t\le1+H$. Consequently each next acceptance occurs almost surely. Summing (2.1) over its possible stopping times, conditional on the previous accepted history, gives target law $f$ for the next accepted mark, independent of that history. Induction proves an infinite iid accepted stream. A budget-$n$ output is an initial segment of this stream. We make no iid assertion conditional on its random length, since that length may depend on its values.

## 3. Results

Constants in $\asymp$ may depend on the displayed fixed class parameters but never on $n$. All bounds hold for integer $n\ge1$ after adjusting these constants.

### Theorem 3.1 (sharp nonnegative-class complexity)

For every $d\ge1$, $0 \lt s\le1$, and fixed $H>1+s/d$,
$$
\mathcal R_n^{\mathrm{pen}}(\mathcal F_{d,s,H})
\asymp_{d,s,H}
\mathcal R_n^{\mathrm{ex}}(\mathcal F_{d,s,H})
\asymp_{d,s,H}n^{d/(d+s)}.                                           \tag{3.1}
$$
One algorithm, defined in Section 4, attains the upper bound for every $H>0$ without knowing $n$. The lower bound in Section 7 is for every fixed $H>1+s/d$, not merely a sufficiently large radius. Its constants may tend to zero as $H\downarrow1+s/d$.

### Theorem 3.2 (automatic adaptation and the exact endpoint)

For every $H>0$ and $0 \lt c<1$, the same algorithm, without using $c$, satisfies
$$
\sup_{f\in\mathcal F_{d,s,H}(c)}\mathbb E_fR_n\le
\begin{cases}
C_{d,s,H,c}n^{1-s/d},&d>s,\\
C_{H,c}\log(n+1),&d=s=1.
\end{cases}                                                        \tag{3.2}
$$
For $d>s$, both the penalized and exact minimax risks on this subclass have order $n^{1-s/d}$. For $d=s=1$, the exact minimax risk has order $\log(n+1)$. The logarithmic lower bound is proved even at $f\equiv1$ for policies valid on the entire positive-floor class; it is not asserted for all penalized policies. The positive-floor polynomial lower rate is a self-contained extension of the established signed-cell argument in [1], not a new exponent.

### Theorem 3.3 (density profile)

If $d>s$, let $p=s/d$ and $\tau_n=n^{-s/(d+s)}$. For every $f\in\mathcal F_{d,s,H}$ the same algorithm satisfies
$$
\mathbb E_fR_n\le C_{d,s,H}n^{1-p}\int_D(f(x)+\tau_n)^{-p}\,dx.        \tag{3.3}
$$
In particular, $\int_Df^{-p}<\infty$ suffices for an $O(n^{1-p})$ rejection bound, even when $\min f=0$. If
$|\{x:f(x)\le u\}|\le A u^\beta$ for $0 \lt u\le1$, with $\beta>0$, the upper rates are
$$
\begin{cases}
O(n^{1-p}),&\beta>p,\\
O(n^{1-p}\log(n+1)),&\beta=p,\\
O\bigl(n^{1-s(\beta+1)/(d+s)}\bigr),&0<\beta \lt p.
\end{cases}                                                        \tag{3.4}
$$
Neither the moment nor $A,\beta$ is an algorithm input. These are sufficient upper bounds; no matching minimax theorem for the sublevel classes is claimed.

Section 6 proves the exact threshold $H_{\mathrm{crit}}=1+s/d$ for the existence of zeros and critical rigidity. Combining it with Theorem 3.2 also determines the subcritical full-class rates: for $0 \lt H \lt H_{\mathrm{crit}}$ they are $n^{1-s/d}$ if $d>s$ (both risks), and $\log(n+1)$ at $d=s=1$ (exact risk). Indeed the geometric floor gives the upper bound, and any fixed positive-floor subclass supplies the lower bound. The full-class minimax at $H=H_{\mathrm{crit}}$ remains outside these conclusions.

## 4. A dyadic sampler and its rejection charges

### Algorithm 4.1 (one visit per dyadic cell)

Use dyadic cubes with an arbitrary fixed half-open convention on internal faces; boundary conventions affect no integrals. Maintain a finite partition of active leaves. A leaf $Q$ has side $h_Q$ and a positive height $u_Q$. Initialize with the root $D$ at height $1+H$.

At every round perform the following operations in order.

1. Compute $M=\sum_Q u_Q|Q|$ and select leaf $Q$ with probability $u_Q|Q|/M$.
2. Draw $X$ uniformly in $Q$, evaluate $f(X)$ once, draw an independent uniform $V$, and output $X$ if $V\le f(X)/u_Q$.
3. After the decision, split the selected $Q$ into its $2^d$ dyadic children. Give each child $C$ the height
   $$u_C=\min\{u_Q,\ f(X)+Hh_Q^s\}.                                \tag{4.1}$$

Both accepted and rejected proposals trigger the split. No centers or additional pilot points are evaluated. A cube's height is fixed at its birth; the cube is removed at its first visit. At every finite time the partition is finite, so the proposal is a finite mixture of uniform laws. The procedure uses $d,s,H$ but no budget or density floor.

### Lemma 4.2 (validity, mass, and local error)

Every finite envelope is pointwise valid and heights remain positive. Refinement never increases the envelope. Hence $1\le M_t\le1+H$. Put $b=2^{s+1}H$. If a dyadic cube $Q$ of side $h$ is born, then throughout its lifetime
$$
0\le u_Q-f(x)\le b h^s\quad(x\in Q),\qquad
a_Q\le u_Q\le a_Q+b h^s,
\quad a_Q=|Q|^{-1}\int_Q f.                                        \tag{4.2}
$$

**Proof.** The oscillation of $f$ on $D$ is at most $H$, so its unit mean implies $f\le1+H$ and $f\ge1-H$. The initial envelope is valid, with excess at most $2H\le b$. For a child, the sampled point and all its points lie in the same parent. The Hölder bound gives $f(y)\le f(X)+Hh_Q^s$, while validity of the parent gives $f(y)\le u_Q$. Their minimum is valid, is positive because $Hh_Q^s>0$, and does not exceed the parent height. Integrating yields the mass bounds. For a nonroot child of side $h$, its parent side is $2h$, so
$u_Q\le f(X)+H(2h)^s\le f(x)+2H(2h)^s=f(x)+bh^s$.
Averaging establishes the last bounds. $\square$

In particular, (2.1) applies and proves the exact accepted-stream statement of Section 2. The averages $a_Q$ occur only in the analysis; the algorithm never evaluates them.

### Lemma 4.3 (the whole contribution of one cube)

Let $Z_Q(n)$ indicate that $Q$ is visited by time $n$ and rejects at that visit. Then
$$
\mathbb E_f Z_Q(n)\le
\min\left\{\frac{bh^s}{a_Q+bh^s},\ nbh^{d+s}\right\}.              \tag{4.3}
$$

**Proof.** Conditional on any history at which $Q$ is selected, its proposal is uniform and its rejection probability is $(u_Q-a_Q)/u_Q$. This expression is increasing in $u_Q$ when $a_Q\ge0$. By (4.2) it is at most $bh^s/(a_Q+bh^s)$. The disjoint possible first-visit times sum to probability at most one, proving the first bound. At any particular round when $Q$ is active, the conditional probability of jointly selecting it and rejecting equals
$$
\frac{u_Qh^d}{M_t}\frac{u_Q-a_Q}{u_Q}
=\frac{h^d(u_Q-a_Q)}{M_t}\le bh^{d+s}.
$$
It is zero if $Q$ is not active. Sum over $n$ rounds for the second bound. This argument requires no independence of the random birth events. $\square$

### Proposition 4.4 (multiscale sum and uniform bounds)

Let $\mathcal D_k$ be all depth-$k$ dyadic cubes and $h_k=2^{-k}$. Then
$$
\mathbb E_fR_n\le\sum_{k\ge0}\sum_{Q\in\mathcal D_k}
\min\left\{\frac{bh_k^s}{a_Q+bh_k^s},\ nbh_k^{d+s}\right\}.          \tag{4.4}
$$
Consequently the upper bounds in Theorems 3.1 and 3.2 hold.

**Proof.** Exactly $n$ cubes are visited in $n$ rounds. The pathwise identity $R_n=\sum_QZ_Q(n)$ and nonnegative Tonelli justify the countable sum. For any integer $K\ge0$, bound the first entry of the minimum by one on coarse levels and use the second on fine levels:
$$
\mathbb E_fR_n\le\sum_{k=0}^K2^{dk}+nb\sum_{k>K}2^{-sk}.             \tag{4.5}
$$
Take $2^K$ within a factor two of $\max\{1,(nb)^{1/(d+s)}\}$. The two geometric sums give $C_{d,s,H}n^{d/(d+s)}$; fixed constants also cover $nb<1$.

If $f\ge c>0$, the first entry in (4.4) is at most $bh_k^s/c$. Thus
$$
\mathbb E_fR_n\le (b/c)\sum_{k=0}^K2^{(d-s)k}
+nb\sum_{k>K}2^{-sk}.                                              \tag{4.6}
$$
Choose $2^K$ comparable with $\max\{1,(nc)^{1/d}\}$. For $d>s$ both sums give $C_{d,s,H,c}n^{1-s/d}$. For $d=s=1$ the coarse summands are constant and their number is $O(\log(n+1))$; the fine sum is bounded by a constant depending on $H,c$. Choices of $K$ are analytical only and do not change the algorithm. $\square$

## 5. Pointwise profile and sublevel adaptation

### Lemma 5.1 (pointwise reduction)

For $d>s$, (4.4) implies
$$
\mathbb E_fR_n\le C_H\int_D\sum_{k\ge0}
\min\left\{\frac{h_k^{s-d}}{f(x)+h_k^s},\ nh_k^s\right\}\,dx.        \tag{5.1}
$$
Here and below the subscript on a constant lists allowed dependencies, and $C_H$ in this display may also depend on the fixed $s$ through $b$.

**Proof.** Hölder continuity within $Q$ gives $a_Q\ge f(x)-Hh^s$ for every $x\in Q$. Since $b>H$, put $c_b=\min\{1,b-H\}>0$ and obtain
$$a_Q+bh^s\ge f(x)+(b-H)h^s\ge c_b(f(x)+h^s).$$
The first entry of (4.3) is therefore at most $(b/c_b)h^s/(f(x)+h^s)$ at every $x\in Q$. Bound the minimum pointwise, average over $Q$, and sum. Nonnegative Tonelli gives (5.1) with $C_H=\max\{b/c_b,b\}$. No exchange of a minimum with Jensen's inequality is used. $\square$

### Lemma 5.2 (the scalar dyadic series)

For $d>s$, $n\ge2$, $a\ge0$, $p=s/d$, and $\tau=n^{-s/(d+s)}$,
$$
\sum_{k\ge0}\min\left\{\frac{h_k^{s-d}}{a+h_k^s},\ nh_k^s\right\}
\le C_{d,s}n^{1-p}(a+\tau)^{-p}.                                   \tag{5.2}
$$

**Proof.** If $a\le\tau$, use $h^{s-d}/(a+h^s)\le h^{-d}$ and split at $h\asymp n^{-1/(d+s)}$. The sum is $O(n^{d/(d+s)})$, which has the asserted form since $\tau\le a+\tau\le2\tau$. If $a>\tau$, then $na>1$. Bound the first entry by $a^{-1}h^{s-d}$ and split at $h_*=(na)^{-1/d}<1$. For $h\ge h_*$ the geometric sum is at most a constant times $a^{-1}h_*^{s-d}=n^{1-p}a^{-p}$; for $h \lt h_*$ the other sum is at most a constant times $nh_*^s=n^{1-p}a^{-p}$. The geometric factors are finite precisely because $d>s$. Since $a \lt a+\tau<2a$, this proves the claim. $\square$

Integrating Lemma 5.2 proves (3.3) for $n\ge2$. For $n=1$, use $R_1\le1$ and the positive uniform lower bound on $\int(f+1)^{-p}$ supplied, for example, by Jensen's inequality and $\int f=1$. Enlarging the constant proves all budgets. If the negative moment is finite, $(f+\tau)^{-p}\le f^{-p}$ almost everywhere, yielding the stated consequence.

### Corollary 5.3 (sublevel bounds)

The rates (3.4) follow under the stated sublevel condition.

**Proof.** On $\{f\le1\}$ the identity
$$
(f+\tau)^{-p}=(1+\tau)^{-p}
+p\int_f^1(u+\tau)^{-p-1}\,du
$$
and Tonelli imply, also bounding the integral on $\{f>1\}$ by one,
$$
\int_D(f+\tau)^{-p}\le2+pA\int_0^1u^\beta(u+\tau)^{-p-1}\,du.
$$
Split the last integral at $u=\tau$ (if $\tau=1$, the assertion is immediate). Its order is bounded, $1+\log(1/\tau)$, or $\tau^{\beta-p}$ according as $\beta>p$, $\beta=p$, or $\beta \lt p$. Multiply by $n^{1-p}$ and substitute $\tau_n$. For the last case,
$1-p+s(p-\beta)/(d+s)=1-s(\beta+1)/(d+s)$.
This proves all three rates. $\square$

## 6. The exact Hölder-radius threshold

Define
$$
H_{\mathrm{crit}}=\frac{d+s}{d}=1+\frac{s}{d}.
$$

### Lemma 6.1 (largest distance moment on a cube)

For every $z\in D$,
$$
I(z):=\int_D\|x-z\|_\infty^s\,dx\le\frac d{d+s}.
$$
Equality holds exactly when $z$ is a vertex of $D$.

**Proof.** If $X$ is uniform on $D$, then for $0 \lt r<1$,
$$
P(\|X-z\|_\infty\le r)
=\prod_{j=1}^d\{\min(1,z_j+r)-\max(0,z_j-r)\}\ge r^d.
$$
Each interval length is at least $r$. The layer-cake identity yields
$$
I(z)\le\int_0^1 sr^{s-1}(1-r^d)\,dr=\frac d{d+s}.
$$
At a vertex every length is exactly $r$, giving equality. If some coordinate
of $z$ is interior, its interval length is $2r>r$ for all sufficiently small
positive $r$. The displayed product inequality is then strict on a set of
positive $r$-measure, giving strict inequality in the integral. $\square$

### Proposition 6.2 (automatic floor and critical rigidity)

Every $f\in\mathcal F_{d,s,H}$ satisfies
$$
\min_D f\ge \max\left\{0,\ 1-\frac{Hd}{d+s}\right\}.
$$
For $H\le H_{\mathrm{crit}}$, this lower bound is attained by
$$
f(x)=1-\frac{Hd}{d+s}+H\|x-v\|_\infty^s
$$
at any vertex $v$. At $H=H_{\mathrm{crit}}$, if $f(z)=0$, then $z$ is a
vertex and
$$
f(x)=H_{\mathrm{crit}}\|x-z\|_\infty^s\quad\text{for every }x\in D.
$$
For $H>H_{\mathrm{crit}}$, the class contains densities that vanish on a
positive-volume cube.

**Proof.** Compactness gives a minimizer $z$. Integrating
$f(x)\le f(z)+H\|x-z\|_\infty^s$ and applying Lemma 6.1 gives the floor.
The claimed attaining examples are nonnegative, normalized and Hölder.
In the critical zero case,
$$
1=\int f\le H_{\mathrm{crit}}I(z)\le1.
$$
Both inequalities are equalities. Lemma 6.1 gives the vertex conclusion.
The continuous nonnegative function
$H_{\mathrm{crit}}\|x-z\|_\infty^s-f(x)$ has integral zero, hence vanishes
identically.

For the last statement let $A=[0,a]^d$, where $a\in(0,1)$, and put
$$
J(a)=\int_D \operatorname{dist}_\infty(x,A)^s\,dx
=d\int_a^1(r-a)^sr^{d-1}\,dr.
$$
This is continuous at zero and $J(0)=d/(d+s)$. Since $H>H_{\mathrm{crit}}$,
choose $a>0$ so small that $c:=1/J(a) \lt H$. Then
$$
g(x)=c\,\operatorname{dist}_\infty(x,A)^s
$$
is a normalized density, is zero on $A$, and has Hölder constant at most
$c \lt H$. $\square$

This proposition does not settle minimax risk at the critical radius. Critical
zero densities are rigid, but the class also contains densities with
arbitrarily small positive minima; uniform minimax analysis of that entire
class is a separate question.

## 7. The lower bound with a zero region

### 7.1 A normalized fixed-count bump family

Assume $H>H_{\mathrm{crit}}$, and fix $a,c,g,A$ from Proposition 6.2.
For an even positive integer $k$, partition $A$ into $M=k^d$ congruent
cubes $Q_i$ of side $h=a/k$. Their boundaries have measure zero.
Let
$$
r_i(x)=
\begin{cases}
\operatorname{dist}_\infty(x,Q_i^c),&x\in Q_i,\\
0,&x\notin Q_i,
\end{cases}
\qquad
\phi_i(x)=\gamma r_i(x)^s.
$$
Equivalently $r_i$ is the distance to the complement of the interior of
$Q_i$. Thus $r_i$ is zero on boundaries. Every $\phi_i$ is globally
$s$-Hölder with constant $\gamma$, nonnegative, and positive throughout
the interior of its cube. Define
$$
v_{d,s}=\int_{[0,1]^d}
\operatorname{dist}_\infty(u,[0,1]^d{}^c)^s\,du
=\int_0^{1/2}s r^{s-1}(1-2r)^d\,dr>0.
$$
Boundary conventions do not affect the integral. The common bump integral is
$$
b=\int\phi_i=\gamma v_{d,s}h^{d+s}.
$$
Choose $\gamma>0$, independent of $k,n$, so that
$$
\gamma\le H,\qquad b_0:=\gamma v_{d,s}a^{d+s}\le\frac1{16}.
$$
There is always such a positive $\gamma$. Then
$$
b=b_0M^{-1-s/d},\qquad
K=M/2,\qquad
w=Kb=\frac{b_0}{2}M^{-s/d}\le\frac1{32}.
$$
For $\omega\in\{0,1\}^M$ with $\sum_i\omega_i=K$, set
$$
f_\omega(x)=(1-w)g(x)+\sum_{i=1}^M\omega_i\phi_i(x).
$$

### Lemma 7.1 (family admissibility)

Every $f_\omega$ lies in $\mathcal F_{d,s,H}$; its mass on $A$ is exactly
$w$; and all members agree outside $A$. Normalization and outside values
reveal only the known count $K$, not the assignment $\omega$.

**Proof.** The integral is $1-w+Kb=1$. Nonnegativity is immediate.
On $D\setminus A$, the Hölder seminorm is at most $c \lt H$. Within any one
cube the seminorm is at most $\gamma\le H$. If two points belong to different
cube interiors, their value difference is at most the larger of their two
nonnegative bump values; each such value is at most
$\gamma\|x-y\|_\infty^s$, because the other point lies outside that cube.
If one point is outside $A$ and the other lies in a bump cube, the value
difference is again at most the larger nonnegative value.
For the outside point,
$(1-w)g(x)\le c\|x-y\|_\infty^s$, since $y\in A$.
For the inside point, its bump value is at most
$\gamma\|x-y\|_\infty^s$, since $x\notin Q_i$.
The same argument handles boundaries and zero cubes. Hence the global
seminorm is at most $\max(c,\gamma)\le H$. $\square$

### 7.2 Posterior uniformity and the first unsafe envelope

Put the uniform prior on the finite set of vectors $\omega$ with exactly
$K$ ones. Algorithmic randomness is independent of this prior.
Call a cube revealed once a queried point lies in its interior. Since
$\phi_i>0$ there, one query reveals the corresponding bit exactly.
Queries outside $A$ reveal no bit. Because each proposal has a Lebesgue
density, all queried cube boundaries have probability zero.

### Lemma 7.2 (finite-family posterior)

Conditional on the full history before a round, including all observed
evaluations, proposal and acceptance randomness, and any internal state, the
unrevealed bit assignments are uniform subject to their remaining total.
In particular, if at most $M/4$ cubes have been revealed, every unrevealed
cube has posterior probability at least $1/4$ of being positive.

**Proof.** At initialization the assertion is the prior. Conditional on the
past, a randomized choice of envelope and a proposal draw use randomness
independent of $\omega$. Thus their likelihoods are identical for all
configurations compatible with the past. An oracle observation either adds no
information or fixes one new bit. Acceptance randomness, given the point and
its evaluated value, adds no further information. Induction proves the claim.
If $r\le M/4$ bits were revealed, the number of remaining positive bits is
at least $K-r\ge M/4$, while the number of remaining bits is at most $M$.
The ratio is at least $1/4$. $\square$

For a realized pre-round history, a configuration is compatible if it agrees
with every revealed bit. Call the envelope a gamble if it fails to dominate
at least one compatible density almost everywhere. This is a proof device,
not an operation the algorithm must compute.

### Lemma 7.3 (a first gamble is detectably risky)

Consider the first gamble occurring before the number of revealed cubes exceeds $M/4$, and before any earlier gamble. Let $G$ be the event that such a
gamble occurs in the first $n$ rounds. Then
$$
P(F_n)\ge \tfrac14P(G),\qquad P(G)\le \frac{4E L_n}{n}.
$$

**Proof.** On the event that the first gamble is at a specified round, the
history-dependent choice and the event itself are measurable before the new
oracle value is revealed. Earlier envelopes dominate every compatible target.
If the new envelope fails on the common outside part or in a revealed cube,
it fails for every compatible target. Otherwise it undercovers at least one
unrevealed bump: there is a positive-measure set in that cube on which
$U_t<\phi_i$. Choose the first such index in a fixed ordering.
If that bit is positive, the actual target is undercovered. By Lemma 7.2 this
has conditional probability at least $1/4$. Sum over disjoint first-gamble
times. The risk inequality follows from $E L_n\ge nP(F_n)$. $\square$

For universally valid samplers, $P(G)=0$. This gives the same-history
compatibility conclusion without appealing to uncountably many alternatives.

### 7.3 Finite-budget minimax lower bound

### Theorem 7.4

Fix $d\ge1$, $0 \lt s\le1$, and $H>1+s/d$. There is a constant
$C_{d,s,H}>0$ such that every horizon $n\ge1$ and every adaptive rejection
sampling algorithm in the above model satisfy
$$
\sup_{f\in\mathcal F_{d,s,H}}E_fL_n
\ge C_{d,s,H}\,n^{d/(d+s)}.
$$
The same lower bound holds for $E_fR_n$ when the infimum is restricted to
universally valid samplers. All functions used in this bound have known
normalization one.

**Proof.** Set
$$
k=2\left\lceil\frac{n^{1/(d+s)}}2\right\rceil,\qquad M=k^d.
$$
Then $k$ is even,
$$
n^{1/(d+s)}\le k\le3n^{1/(d+s)},\qquad
n^{d/(d+s)}\le M\le3^d n^{d/(d+s)}.
$$
Use the finite prior in Sections 7.1–7.2, and write $B=E L_n$ for its Bayes
risk. Let $V^-$, $R^-$, $A^-$ count respectively low-region proposals,
all rejected proposals, and accepted low-region proposals, up to but
excluding the first gamble; also stop counting after the query that first
makes the number of revealed cubes exceed $M/4$, or at $n$, whichever
comes first.

Every counted round has an envelope valid for every compatible target.
Therefore $M_t=\int U_t\ge1$. Its conditional probability of an accepted
low-region proposal, conditional also on the true target, is
$$
\int_A q_t(x)\frac{f_\omega(x)}{U_t(x)}\,dx=\frac{w}{M_t}\le w.
$$
The decision that a round is counted is measurable before that round's
proposal. Consequently
$$
E A^-\le nw,\qquad V^-\le R^-+A^-,\qquad
E V^-\le B+nw.
$$
The inequality $R^-\le L_n$ holds pathwise because $L_n\ge R_n$.

If the revealed-cube threshold is crossed during the counted rounds, then
$V^->M/4$. By Markov's inequality, the probability of this event is at most
$4(B+nw)/M$. By Lemma 7.3 the probability of a gamble before crossing the
threshold is at most $4B/n$. Hence at any specified round, the probability
that neither obstruction has yet occurred and that its envelope is not a
gamble is at least
$$
1-\frac{4B}{n}-\frac{4(B+nw)}M.
$$
The right side may be negative, in which case using it is harmless.

At such a good round, at least $M/4$ unrevealed cubes are actually zero:
the total number of zero bits is $M/2$, and at most $M/4$ bits have been
revealed. At least one positive bit also remains unrevealed. Every unresolved
zero cube can be made positive by swapping with an unresolved positive cube,
while preserving all observations and the total positive count.
The envelope therefore dominates $\phi_i$ on each unresolved zero cube.
It already dominates the actual target almost everywhere. Thus
$$
M_t-1=\int_D(U_t-f_\omega)\ge e:=\frac{Mb}4=\frac w2.
$$
Conditional rejection probability is
$$
1-\frac1{M_t}\ge\frac e{1+e}.
$$
Summing over the $n$ rounds, using $L_n\ge R_n$, and setting
$a_n=ne/(1+e)$, gives
$$
B\ge a_n\left(1-\frac{4B}{n}-\frac{4(B+nw)}M\right).
$$
This inequality remains valid when its parenthesis is negative.

The selected $M$ and $b_0\le1/16$ imply
$$
\frac{nw}M=\frac{b_0}2\,nM^{-1-s/d}\le\frac{b_0}2,\qquad
\frac{a_n}{M}\le\frac{b_0}4,\qquad
\frac{a_n}{n}\le\frac{b_0}4.
$$
Rearranging yields
$$
B\ge
\frac{a_n(1-2b_0)}{1+2b_0}
\ge\frac79a_n.
$$
Finally
$$
a_n=\frac{(b_0/4)nM^{-s/d}}{1+(b_0/4)M^{-s/d}}
\ge \frac{b_0\,3^{-s}}{4(1+b_0/4)}n^{d/(d+s)}.
$$
For example $C_{d,s,H}=b_0\,3^{-s}/8$ is a valid smaller constant.
The supremum risk is at least the finite-prior average $B$.
For universally valid algorithms $L_n=R_n$ almost surely. $\square$

The proof makes the normalization issue explicit: adding or removing a lone
bump is not the adversary. Swapping a positive and a zero cell preserves
normalization and all observed values.

## 8. Positive-floor lower bound and prior attribution

We rederive the signed-cell mechanism of Achddou et al. [1], explicitly for every fixed $H>0$, $0 \lt c<1$, and with the
posterior first-gamble argument spelled out. This is a rederivation of the established polynomial exponent, included to make the parameter range and penalized-risk comparison self-contained.

Let
$$
\mathcal F_{d,s,H}(c)=\{f\in\mathcal F_{d,s,H}:\ f\ge c\},
\qquad 0 \lt c<1,\quad H>0.
$$

### Lemma 8.1 (signed bumps across neighboring cubes)

Partition $D$ into $M=k^d$ congruent cubes of side $h=1/k$. In each
cube let $\phi_i(x)=\gamma\operatorname{dist}_\infty(x,Q_i^c)^s$, extended
by zero. If $\sigma_i\in\{-1,1\}$, then the function
$\sum_i\sigma_i\phi_i$ is $s$-Hölder with constant at most
$2^{1-s}\gamma$.

**Proof.** Within one cube the Hölder constant is $\gamma$. For points in
different cubes, a coordinate separates the interiors of those cubes.
The two within-cube distances $r_i(x)$, $r_j(y)$ satisfy
$r_i(x)+r_j(y)\le\|x-y\|_\infty$. Hence
$$
|\sigma_i\phi_i(x)-\sigma_j\phi_j(y)|
\le \gamma(r_i(x)^s+r_j(y)^s)
\le 2^{1-s}\gamma\|x-y\|_\infty^s.
$$
Boundary and same-sign cases satisfy this bound too. $\square$

### Theorem 8.2 (positive-floor minimax lower rate)

For each $d\ge1$, $0 \lt s\le1$, $H>0$, and $0 \lt c<1$, a constant
$C'_{d,s,H,c}>0$ exists such that every algorithm in the penalized ARS model
satisfies
$$
\sup_{f\in\mathcal F_{d,s,H}(c)} E_fL_n
\ge C'_{d,s,H,c} n^{1-s/d}.
$$
It applies in particular to universally valid samplers with $L_n=R_n$.
When $d>s$, an $O(n^{1-s/d})$ upper bound is therefore matching.
At $d=s=1$ this theorem alone gives only a constant; Section 9 supplies
the stronger logarithmic lower bound for universally valid samplers.

**Proof.** Set
$$
\gamma=\min\{2^{s-1}H,\ 2^s(1-c)\}>0,\qquad
k=2\left\lceil\frac{(4n)^{1/d}}2\right\rceil,\qquad M=k^d.
$$
Then $M$ is even and
$$
4n\le M\le 4\cdot3^d n.
$$
Use the partition and bumps from Lemma 8.1. Each bump has integral
$b=\gamma v_{d,s}M^{-1-s/d}$.
For each sign vector $\sigma$ having exactly $M/2$ positive signs, put
$$
f_\sigma(x)=1+\sum_i\sigma_i\phi_i(x).
$$
Its integral is one. The Hölder seminorm is at most $H$. Also
$$
f_\sigma\ge1-\gamma(h/2)^s
\ge1-\gamma2^{-s}\ge c.
$$
Thus the whole finite family belongs to the asserted positive-floor class.

Give the balanced sign vectors the uniform prior. Each query in a cube
interior reveals exactly its sign. As in Lemma 7.2, conditional on the
history the remaining signs are uniform subject to their known total.
Since at most $n\le M/4$ cells can be revealed, every unrevealed cell always
has positive-sign probability at least $1/4$, and at least $M/4$
negative cells remain unrevealed.

Call an envelope a gamble when it fails to dominate some compatible family
member. Before its first occurrence, all envelopes are valid for all
compatible members. At the first occurrence, failure of the actual envelope
has posterior probability at least $1/4$: on a revealed cell there is no
uncertainty; on an unrevealed cell the upper of the two alternatives is
$1+\phi_i$, whose positive sign has conditional probability at least
$1/4$. Let $G$ be the event of any gamble by $n$, and let
$B=E L_n$ denote the finite-prior risk. Then
$$
P(G)\le4P(F_n)\le4B/n.
$$

At every round before any gamble, each unrevealed negative cell forces the
envelope to dominate $1+\phi_i$, whereas the true target there is
$1-\phi_i$. Consequently
$$
M_t-1=\int(U_t-f_\sigma)\ge 2(M/4)b
= e:=\frac{\gamma v_{d,s}}2 M^{-s/d}.
$$
The conditional rejection probability is at least $e/(1+e)$.
At every round the probability of having no earlier or present gamble is at
least $1-4B/n$. Since $L_n\ge R_n$,
$$
B\ge \frac{ne}{1+e}(1-4B/n),
\quad\text{and hence}\quad B\ge\frac{ne}{1+5e}.
$$
This remains valid if $1-4B/n<0$. Inserting the bounds on $M$ and noting
that $e\le\gamma v_{d,s}/2$, we obtain
$$
B\ge
\frac{\gamma v_{d,s}(4\cdot3^d)^{-s/d}}
     {2+5\gamma v_{d,s}}\,
n^{1-s/d}.
$$
The supremum risk dominates the finite-prior average. $\square$

## 9. The logarithmic endpoint for exact policies

This result is separate from the penalized lower bound: it is asserted only
for universally valid algorithms.

Let $d=s=1$, $H>0$, and $0 \lt c<1$. Consider the normalized Lipschitz class
$$
\mathcal F(H,c)=\{f:[0,1]\to[c,\infty):\ \int_0^1f=1,\
|f(x)-f(y)|\le H|x-y|\}.
$$
Put $a_*=\min\{H,4(1-c)\}>0$.

### Lemma 9.1 (countable same-history transfer)

Suppose an algorithm is universally exact on $\mathcal F(H,c)$. Let
$f_0\equiv1$. For any fixed alternative $g\in\mathcal F(H,c)$ equal to
one outside an interval $I$, the measures of pre-round histories under
$f_0$ and $g$, restricted to histories whose previous proposals all avoid
the interior of $I$, are identical. Therefore on this event the envelope
under $f_0$ dominates $g$ almost surely. The conclusion holds
simultaneously for a countable collection of such alternatives and all
integer rounds.

**Proof.** Couple the algorithms with the same private randomness, proposal
randomness, and acceptance uniforms. Until a proposal enters the interior of
$I$, every queried target value is one under both targets. Inductively the
policy, proposal kernel and acceptance decision are identical. Equivalently,
the killed-history kernels before entry into $I$ agree. A zero-probability
envelope-validity failure under $g$, intersected with such histories, has
zero probability under $f_0$. Countable unions preserve zero probability.
$\square$

### Theorem 9.2 (endpoint lower bound at the uniform target)

Every universally exact sampler on $\mathcal F(H,c)$ satisfies
$$
E_{f_0}R_n\ge
\frac{a_*}{8+a_*}\sum_{t=1}^n\frac1t.
$$
Consequently a horizon-free upper bound $O(\log n)$ is minimax sharp in this
exact class.

**Proof.** Define the continuous piecewise-linear function
$$
\psi(u)=
\begin{cases}
u,&0\le u\le1/4,\\
1/2-u,&1/4\le u\le3/4,\\
u-1,&3/4\le u\le1.
\end{cases}
$$
It has Lipschitz constant one, endpoints zero, mean zero,
$\|\psi\|_\infty=1/4$, and $\int_0^1|\psi|=1/8$.
For every nonempty interval $I=(l,r)\subseteq(0,1)$ with rational endpoints
(endpoints zero and one are also permitted), put
$$
\phi_I(x)=
\begin{cases}
a_*|I|\psi((x-l)/|I|),&x\in I,\\
0,&x\notin I.
\end{cases}
$$
The two alternatives $f_I^\pm=1\pm\phi_I$ have integral one, Lipschitz
constant at most $a_*\le H$, and minimum at least
$1-a_*/4\ge c$. This is a countable family.

Outside a single null set under $f_0$, Lemma 9.1 shows at every round $t$
that the envelope dominates both $f_I^+$ and $f_I^-$ for every rational
interval containing no previous proposal in its interior. In particular
$$
U_t\ge1+|\phi_I|
$$
almost everywhere for every such interval. Also $U_t\ge1$ almost everywhere.

The at most $t-1$ previous proposal points split $[0,1]$ into at most
$t$ open gaps, of lengths $\ell_j$ summing to one (zero lengths may be
discarded). Choose rational-endpoint intervals strictly inside each gap with
lengths tending to its full length. The chosen intervals from distinct gaps
are disjoint. Integrating the above lower bounds and taking a finite limit
gives
$$
M_t-1=\int(U_t-1)\ge
\frac{a_*}{8}\sum_j\ell_j^2\ge\frac{a_*}{8t},
$$
where the final inequality is Cauchy--Schwarz. Conditional rejection
probability under $f_0$ is therefore at least
$$
\frac{a_*}{8t+a_*}\ge\frac{a_*}{8+a_*}\frac1t.
$$
Sum and take expectation. $\square$

### Scope of Theorem 9.2

1. This logarithmic endpoint theorem is not extended to the penalized
   algorithm class. The countable transfer uses almost-sure exactness.
2. At $c=1$, the class is the singleton $f=1$, and zero rejection is
   possible. The strict assumption $c<1$ matters.
3. At $H=0$, the same singleton conclusion holds. The strict $H>0$ matters.
4. The theorem is for the evaluation-per-proposal model; squeeze methods can
   emit samples without new evaluations and are excluded by definition.


## 10. A fixed number of accepted outputs

### Proposition 10.1 (evaluation overhead for an output budget)

Let $T_m$ be the time of the $m$th acceptance under Algorithm 4.1, for integer $m\ge1$. Uniformly over $\mathcal F_{d,s,H}$,
$$
\mathbb E_f(T_m-m)\le C_{d,s,H}m^{d/(d+s)}.                         \tag{10.1}
$$
On each positive-floor class this improves to $C_{d,s,H,c}m^{1-s/d}$ if $d>s$, and $C_{H,c}\log(m+1)$ if $d=s=1$.

**Proof.** Write $p_0=(1+H)^{-1}$. Conditional acceptance probabilities are at least $p_0$. Introducing independent uniform variables sequentially realizes acceptance indicators with those conditional probabilities and makes them dominate iid Bernoulli($p_0$) indicators. Hence the acceptance count at time $t$ stochastically dominates $\operatorname{Bin}(t,p_0)$. For $t\ge2m/p_0$, the elementary multiplicative Chernoff inequality gives
$$\mathbb P(T_m>t)\le \exp(-p_0t/8).$$
For completeness, this bound follows from $\mathbb E e^{-\lambda\operatorname{Bin}(t,p_0)}=(1-p_0+p_0e^{-\lambda})^t$ and Markov's inequality, taking a fixed positive $\lambda$; the usual half-mean bound has exponent $-tp_0/8$.

Set $N=\lceil2m/p_0\rceil$. Pathwise,
$$R_{T_m}\le R_N+(T_m-N)_+.$$
Also $T_m-m=R_{T_m}$ and
$\mathbb E(T_m-N)_+=\sum_{t=N}^\infty\mathbb P(T_m>t)$.
The geometric tail is at most $C_H e^{-c_Hm}$. Apply Proposition 4.4 to the deterministic budget $N=O_H(m)$ and absorb the tail into its bound. $\square$

This proposition proves only output-budget upper bounds. It neither exchanges the two minimax problems nor claims matching output-budget lower bounds.

## 11. Interpretation, accounting, and limits

The nonnegative worst case combines smooth local bumps with a region containing few genuine target draws. A valid envelope must reserve mass in unobserved cells, and observing those cells costs either a rejection or a scarce accepted point in that region. Balancing the number of cells with their total target mass produces $n^{d/(d+s)}$. Under a positive floor, ordinary accepted draws can refine all regions more rapidly, producing $n^{1-s/d}$. The profile bound shows that a floor is sufficient but not necessary for that faster rate.

All constants are for fixed $d,s,H$ and, where present, $c,A,\beta$. No uniformity as $H\downarrow H_{\mathrm{crit}}$, $c\downarrow0$, $s\downarrow0$, or $d\to\infty$ is asserted. The algorithm creates $2^d$ children on each visit, so oracle efficiency does not establish high-dimensional practical efficiency. Floating-point simulations can check implementation behavior but cannot certify the exact envelope inequalities in this ideal-real model.

The accompanying reproducibility package contains finite algebraic checks and a seeded implementation diagnostic. It does not substitute for any proof in this paper. Theorems 3.1–3.3 follow from the preceding mathematical arguments independently of those computations. No theorem here has been checked by a proof assistant.

The remaining scope boundaries are substantive. The full-class minimax at $H=H_{\mathrm{crit}}$, a sharp penalized-risk logarithmic endpoint, minimax rates for the sublevel subclasses, unknown normalization, noisy evaluations, higher smoothness, and unrestricted exact simulation all require separate analyses. The normalized signed family, the first unsafe-envelope argument, and the countable transfer in Section 9 are explicit because omitting these points would change the information model or the quantifiers of the claims.

## References

1. J. Achddou, J. Lam-Weil, A. Carpentier and G. Blanchard. **A minimax near-optimal algorithm for adaptive rejection sampling.** ALT 2019, PMLR 98:94–126. [Official proceedings](https://proceedings.mlr.press/v98/achddou19a.html); [official full text](https://proceedings.mlr.press/v98/achddou19a/achddou19a.pdf). The positive-floor lower mechanism and original efficiency question are credited to this work.
2. A. Erraqabi, M. Valko, A. Carpentier and O. Maillard. **Pliable Rejection Sampling.** ICML 2016, PMLR 48:2121–2129. [Official proceedings](https://proceedings.mlr.press/v48/erraqabi16.html). A later arXiv upload does not change its 2016 publication date.
3. B. Delyon and F. Portier. **Safe adaptive importance sampling: A mixture approach.** The Annals of Statistics 49(2):885–917, 2021. [DOI: 10.1214/20-AOS1983](https://doi.org/10.1214/20-AOS1983). Detailed method comparison uses the [author preprint, arXiv:1903.08507v4](https://arxiv.org/abs/1903.08507v4); official metadata and the abstract excerpt were separately checked.
4. S. Chewi, P. R. Gerber, C. Lu, T. Le Gouic and P. Rigollet. **Rejection sampling from shape-constrained distributions in sublinear time.** AISTATS 2022, PMLR 151:2249–2265. [Official proceedings](https://proceedings.mlr.press/v151/chewi22a.html).
5. J. Awan and V. Rao. **Privacy-Aware Rejection Sampling.** Journal of Machine Learning Research 24(74):1–32, 2023. [Official article](https://jmlr.org/papers/v24/21-0870.html).
6. A. Block and Y. Polyanskiy. **The Sample Complexity of Approximate Rejection Sampling with Applications to Smoothed Online Learning.** COLT 2023, PMLR 195:228–273. [Official proceedings](https://proceedings.mlr.press/v195/block23a.html).
7. D. Holzmüller and F. Bach. **Convergence Rates for Non-Log-Concave Sampling and Log-Partition Estimation.** Journal of Machine Learning Research 26(249):1–72, 2025. [Official article](https://jmlr.org/papers/v26/24-1494.html).
8. S. Shin, J. Pang and K.-S. Jun. **Uniform Race: Parameter-Free Approximate Rejection Sampling.** arXiv:2609.34639v2, 2026. [Versioned preprint](https://arxiv.org/abs/2609.34639v2). The source audit records the exact metadata and limited portions inspected; this preprint is not used as a formal-publication benchmark.
9. R. Sainudiin and T. York. **Auto-validating von Neumann rejection sampling from small phylogenetic tree spaces.** Algorithms for Molecular Biology 4:1, 2009. [DOI: 10.1186/1748-7188-4-1](https://doi.org/10.1186/1748-7188-4-1). Interval enclosures provide more information than our point oracle.
10. W. R. Gilks and P. Wild. **Adaptive Rejection Sampling for Gibbs Sampling.** Journal of the Royal Statistical Society, Series C 41(2):337–348, 1992. [DOI: 10.2307/2347565](https://doi.org/10.2307/2347565).
