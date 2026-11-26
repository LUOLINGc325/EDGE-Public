# Loss geometry, evidence efficiency, and adaptive repair in multivariate mean testing

Research manuscript · 25 November 2026

## Abstract

Generalized universal inference (GUe) expresses evidence as the exponential of a nonnegative learning rate times a loss contrast. For every finite dimension and every compact convex observation domain with an interior tested mean, we characterize the complete envelope of all globally valid GUe factors with finite, observation-dependent rates and a Bregman loss. The envelope is governed by a cone determined by the loss-comparison halfspace. This reveals an angular obstruction absent from the scalar analysis: removing the loss cutoff can leave only a single betting direction. On an explicit planar family we compute both optimal growth rates and obtain a relative efficiency asymptotic to four times the mean displacement. More generally, two alternatives with the same mean defeat every fixed differentiable strictly convex Bregman score in at least one direction, even though the empirical-risk minimizer is always the same sample mean. We then characterize exactly when a positive affine factor admits arbitrarily accurate pointwise approximation from below from a prescribed prediction by changing the Bregman score: a nonzero betting vector must have positive inner product with the prediction displacement. An explicit smooth strictly convex construction makes the uniform logarithmic representation loss arbitrarily small. A compatible regularized-leader mixture converts this one-step result into a single predictable-loss GUe with a cumulative representation loss below one, deterministic sublinear regret on every data path, and optimal growth for every bounded iid alternative, even when compared with all terminal-valid e-values for the same iid null. A threshold-hitting corollary turns the fixed-score efficiency loss into an unbounded first-order sampling penalty. Affine completeness, numeraire optimality, Bregman mean elicitation and standard online-learning tools are attributed ingredients; the contribution is their exact interaction with the GUe representation and its constructive repair.

## 1. Question and contribution

Dey, Martin and Williams [DMW] introduce GUe inference for risk minimizers and leave a precise growth-optimality theory for further work. Their adaptive formulation permits the learning rate to depend on the current observation. We retain that large rate class and impose conditional unit dominance under every law in an explicit null model. This distinction matters: a failure proved here cannot be repaired by choosing a different finite nonnegative rate within that class.

The preceding scalar study in this project identified clipping of positive evidence by the sign of a mean-eliciting loss. It also gave scalar support-free repair by concentrating loss curvature. The present paper adds a different obstruction. In vector problems, a score chooses a direction as well as a cutoff. Two data-generating laws may have the same mean, and hence the same optimal point predictor, while requiring different directions for efficient evidence. A fixed score can therefore lose nearly all relative evidence efficiency without any point-estimation error. Radial cutoff repair alone still fails.

The positive result gives an exact boundary for score adaptation. A prescribed nonzero strictly positive affine bet admits an arbitrarily accurate, pointwise dominated finite-rate GUe approximation from a smooth strictly convex Bregman score if and only if it points positively along the prediction displacement. Whenever this holds, the score can be chosen with any prescribed positive uniform log-loss budget. We construct an evidence strategy that satisfies this compatibility at every history while retaining the ordinary empirical mean of all preceding observations. Its finite-sample guarantee covers arbitrary observation sequences and the full closed affine class, including boundary comparators.

The all-path regret bound proved for this elementary compatible strategy is sublinear, with order $n^{2/3}(d\log n)^{1/3}$ at fixed geometry. We do not claim an optimal portfolio-regret rate. The dimension-independent statement is instead the additional score-representation loss: it is below one at every horizon. Under each fixed iid alternative, this suffices for exact optimal first-order growth. The construction uses finitely many active optimization problems at each round; no finite-precision complexity or conditioning guarantee is claimed.

### 1.1 Relation to the closest work

| Prior result | Ingredient retained here | Additional question settled in this paper |
| --- | --- | --- |
| [CLZ], score and identification test martingales; score-linearization dominance; regret-based power | General functional betting and the fact that a score may be dominated are established | Complete optimization over every finite observation-dependent exponential rate; exact cap-cone boundary; uniform same-mean score obstruction |
| [LRR-C], expectation-constraint complete classes | Vector-mean e-factors admit affine majorants | Which of these factors survive the loss-sign restriction and when equality is possible |
| [LRR-N], numeraire and reverse information projection | The unrestricted growth benchmark and comparison principle | Exact representability from a fixed point predictor, with a quantitative constructive score transfer |
| [RR], general iid-null achievable and unbeatable growth rates | General sequential growth optimality is established | The optimal rate must be recovered inside the prescribed GUe representation while preserving its exact empirical-mean predictor |
| [DFZ], M/Z estimation efficiency gap | Multivariate score/identification efficiency distinctions are established | Here the point estimator is identical throughout; the gap occurs in best valid evidence growth |
| [SR], constrained e-variable optimization | Clipping and constrained optimization are established techniques | A predictor-dependent sign constraint creates an observation-space cone, with an exact compatible-score repair |
| [CO], [HAK], [SS], [OJ], portfolio and online-learning tools | Mixtures, regularized leaders, stability and log-determinant bounds | A compatible all-history empirical-mean interface that permits a single adaptive-score GUe |

This comparison does not claim a first general theory of e-variables, scoring rules or optimal portfolios. It identifies the extra mathematical statements after those ingredients have been removed. The literature audit is bounded and records the versions actually inspected; it is not a worldwide priority certificate.

### 1.2 Standing conventions

Fix a finite integer $d\ge1$, a compact convex $K\subset\mathbb R^d$ with nonempty interior, and a separately fixed $q\in\operatorname{int}K$. The one-step null is every Borel law on $K$ with mean $q$. Predictions, losses and betting vectors use the past only. The nonnegative learning rate may also use the current observation, but is finite at every history and observation. Conditional validity under every iid null is the defining requirement for the compared GUe class; the constructed process will satisfy the stronger conditional-mean-null validity.

For a differentiable strictly convex generator $\Phi$ on a neighborhood of $K$, the loss is

```math
\ell_\Phi(a,x)=D_\Phi(x,a)
=\Phi(x)-\Phi(a)-\nabla\Phi(a)^\mathsf T(x-a).
```

Every nonempty empirical distribution has its unique risk minimizer at its mean. At round $t\ge2$, the prescribed predictor is therefore $a_t=\bar X_{t-1}$; at round one we initialize $a_1=q$. The initial choice is not asserted to be a unique minimizer of an empty empirical risk.

All logarithms are natural. Comparison factors may be zero, with $\log0=-\infty$; actual finite-rate GUe factors are strictly positive. Almost-sure statements hold for each fixed alternative and procedure, without claiming one probability-one event for all uncountably many laws or procedures. Constant symbols in the geometric and online-learning parts are defined locally. Results G1.1–G7 and R1–R4 retain their labels for traceable cross-reference.

## Part I. Vector loss geometry and the obstruction for fixed losses

### G1. Model and the affine complete class

Translate the tested mean to zero. Let $K\subset\mathbb R^d$ be compact and convex, with
```math
B(0,r)\subseteq K\subseteq B(0,R),
\qquad 0 \lt r\le R<\infty,
```
where balls are closed and the norm is Euclidean. The null class is
```math
\mathcal Q_0
=\{Q:Q\text{ is a Borel probability law on }K,\ \mathbb E_QX=0\}.
```
A one-step e-factor is a finite nonnegative Borel function $f$ satisfying $\mathbb E_Qf\le1$ for every $Q\in\mathcal Q_0$. Define
```math
L_\lambda(x)=1+\lambda\cdot x,\qquad
\Lambda=\{\lambda\in\mathbb R^d:L_\lambda(x)\ge0\text{ for all }x\in K\}.
```
The set $\Lambda$ is compact and convex and contains a neighborhood of zero. In particular, $\|\lambda\|\le1/r$ on $\Lambda$, and hence $L_\lambda\le1+R/r$ on $K$. Write $\Lambda^\circ$ for its interior, equivalently the set of coefficients for which $L_\lambda$ is strictly positive on all of $K$.

For sequential results, $\mathcal F_t=\sigma(X_1,\ldots,X_t)$. Each prediction and loss-selection rule is a Borel function of the observed past. A contrast $c_t(h,x)$ is finite and jointly Borel in history and observation, and the rate $\eta_t(h,x)$ is finite, nonnegative and Borel; the rate may use the current observation. The actual factors and wealth are
```math
f_t(h,x)=\exp\{\eta_t(h,x)c_t(h,x)\},
\qquad
E_0=1,\qquad E_n=\prod_{t=1}^n f_t(X_{ \lt t},X_t).
```
An additional unconditioned private-randomization variable is not part of this model. The validity requirement is the original conditional iid-null convention:
```math
\mathbb E_{Q^{\otimes\infty}}
 [f_t(X_{ \lt t},X_t)\mid\mathcal F_{t-1}]
\le1
\quad Q^{\otimes\infty}\text{-almost surely},
\qquad Q\in\mathcal Q_0,\quad t\ge1.
```
Thus every actual GUe factor is strictly positive, and its product is a test supermartingale for every iid null. No uniform numerical bound on the learning rates is imposed.

#### Lemma G1.1. Affine domination

Every finite nonnegative null-valid Borel factor $f$ is dominated on $K$ by some $L_\lambda$ with $\lambda\in\Lambda$. If $f>0$ everywhere, the dominating coefficient belongs to $\Lambda^\circ$.

**Proof.** For every finite collection $x_1,\ldots,x_m\in K$, the linear inequalities
```math
\lambda\cdot x_i\ge f(x_i)-1,\qquad i=1,\ldots,m,
```
are feasible. Otherwise the finite-dimensional theorem of alternatives gives weights $w_i\ge0$, not all zero, such that
```math
\sum_iw_ix_i=0,\qquad
\sum_iw_i\{f(x_i)-1\}>0.
```
The probability law obtained by normalizing these weights has mean zero and violates validity.

Include the points $\pm r e_j$ in every finite collection. Since $f\ge0$, the corresponding inequalities restrict every feasible coefficient to the compact box $[-1/r,1/r]^d$. The finite-intersection property then gives one coefficient satisfying all pointwise inequalities. It belongs to $\Lambda$ because $L_\lambda\ge f\ge0$. If $f>0$, the continuous function $L_\lambda$ attains its minimum at some $x_0\in K$, and that minimum is at least $f(x_0)>0$. Hence $\lambda\in\Lambda^\circ$. $\square$

This lemma is the familiar finite-constraint affine complete-class ingredient. Its elementary proof fixes the conventions needed below; affine completeness itself is not a new contribution.

#### Lemma G1.2. Conditional validity at every finite history

The conditional iid-null validity requirement implies that, at every fixed finite history $h$,
```math
\int_K f_t(h,x)\,Q(dx)\le1
\qquad\text{for every }Q\in\mathcal Q_0.
```

**Proof.** Assign sufficiently small positive masses to the finitely many coordinates of $h$, and add one compensating point in $B(0,r)$ so that the resulting atomic law $R_h$ has mean zero. Given $Q\in\mathcal Q_0$, the mixture
```math
Q_\epsilon=(1-\epsilon)Q+\epsilon R_h,\qquad 0<\epsilon<1,
```
is a null law under which the exact history has positive probability. Conditional validity at that history and nonnegativity of the factor give
```math
(1-\epsilon)\int_Kf_t(h,x)\,Q(dx)\le1.
```
Let $\epsilon\downarrow0$. This also rules out an infinite integral. $\square$

### G2. The exact cap cone and complete GUe envelope

Fix $v\ne0$ and a cutoff $b$, and consider a finite Borel contrast with the same sign, including the same zero set, as
```math
c(x)=v\cdot x-b.
```
A positive multiplicative scale changes none of the assertions. We impose $\|v\|=1$ when discussing angular bounds. Define the cone
```math
C(v,b)=
\{\lambda\in\mathbb R^d:
  \lambda\cdot x\ge0
  \text{ for every }x\in K\text{ with }v\cdot x\ge b\}.
```
The equality part of the cap is included because a GUe factor equals one whenever its contrast is zero. For $\lambda\in\Lambda\cap C(v,b)$, put
```math
H_{v,b,\lambda}(x)=
\begin{cases}
L_\lambda(x),&v\cdot x>b,\\
\min\{1,L_\lambda(x)\},&v\cdot x \lt b,\\
1,&v\cdot x=b.
\end{cases}
```
Equivalently, on this feasible set,
```math
H_{v,b,\lambda}(x)
=L_\lambda(x)-[\lambda\cdot x]_+
  \mathbf1_{\{v\cdot x\le b\}}.
```

#### Theorem G2.1. Exact complete envelope

Every null-valid factor $\exp\{\eta(x)c(x)\}$, with finite nonnegative Borel rate $\eta$, is dominated by some $H_{v,b,\lambda}$ with $\lambda\in\Lambda^\circ\cap C(v,b)$. Conversely every such envelope with $\lambda\in\Lambda^\circ$ is null-valid and has exactly this finite-rate GUe representation.

**Proof.** Lemma G1.1 supplies an affine majorant $L_\lambda$ with $\lambda\in\Lambda^\circ$. On $c>0$, the GUe factor is at least one; on $c=0$, it equals one. Thus $L_\lambda\ge1$ throughout the closed cap, giving $\lambda\in C(v,b)$. On $c<0$, the factor is at most one and hence is bounded by $\min\{1,L_\lambda\}$. These three regions give the stated envelope.

Conversely $H>0$, $H\le L_\lambda$, and $\mathbb E_QL_\lambda=1$ under every null, so $H$ is valid. Its logarithm is nonnegative on $c>0$, nonpositive on $c<0$, and zero on $c=0$. Consequently
```math
\eta(x)=
\begin{cases}
\log H(x)/c(x),&c(x)\ne0,\\
0,&c(x)=0
\end{cases}
```
is finite, nonnegative and Borel and satisfies $\exp\{\eta c\}=H$. The same argument applies to any finite Borel contrast with the stated sign and zero set by using that contrast in the denominator. $\square$

For any Borel alternative $P$ on $K$, define
```math
\begin{aligned}
G(P)&=\max_{\lambda\in\Lambda}
       \mathbb E_P\log L_\lambda(X),\\
V(P;v,b)&=\max_{\lambda\in\Lambda\cap C(v,b)}
       \mathbb E_P\log H_{v,b,\lambda}(X).
\end{aligned}
```
We use $\log0=-\infty$. Both maxima exist and are at least zero because $\lambda=0$ is feasible. The factors have the common upper bound $1+R/r$, and reverse Fatou gives upper semicontinuity of their expected logarithms on the compact feasible sets. Finite support is unnecessary.

By Lemma G1.1, $G(P)$ is also the growth supremum over all one-step e-factors. By Theorem G2.1, $V(P;v,b)$ is the growth supremum over actual finite-rate GUe factors. For the latter assertion, a closed-envelope optimizer can be approached by replacing $\lambda$ with $(1-\epsilon)\lambda$. Its envelope becomes
```math
H_{v,b,(1-\epsilon)\lambda}
=\epsilon+(1-\epsilon)H_{v,b,\lambda}>0.
```
On $H\ge1$, bounded convergence applies to its logarithm. On $H<1$, monotone convergence applies to the negative logarithm as $\epsilon\downarrow0$. Thus the expected log converges to that of the closed optimizer. This is a supremum statement, without an assertion of endpoint finite-rate attainment.

#### Corollary G2.2. Exact equality with unrestricted growth

The equality $V(P;v,b)=G(P)$ holds if and only if there exists an unrestricted maximizing coefficient $\lambda_*\in\Lambda$ such that
```math
\lambda_*\in C(v,b),
\qquad
P\{v\cdot X\le b,\ \lambda_*\cdot X>0\}=0.
```

**Proof.** If $V=G$, choose an envelope optimizer $\lambda$. Then
```math
G(P)\ge
\mathbb E_P\log L_\lambda
\ge\mathbb E_P\log H_{v,b,\lambda}
=G(P).
```
These expectations are finite at the optimizer. Hence $\lambda$ is unrestricted-optimal, and its nonnegative log gap is zero almost surely. That is exactly the displayed no-clipping-mass condition. Conversely, the two conditions imply $H_{v,b,\lambda_*}=L_{\lambda_*}$ $P$-almost surely, yielding equality. $\square$

The coefficient vector need not be unique: $P$ can be supported on a proper affine subspace. The criterion is existential over all unrestricted-optimal representations. Strict concavity of the logarithm gives uniqueness of the optimal payoff $P$-almost surely when its value is finite, which does not by itself imply uniqueness of its coefficient vector.

### G3. Quantitative angular rigidity and a vanishing cutoff

#### Lemma G3.1. Width of the feasible cone

Suppose $\|v\|=1$ and $0\le b \lt r$. Write $\lambda=\alpha v+\beta$, where $\beta\perp v$. If $\lambda\in C(v,b)$, then
```math
\alpha\ge0,\qquad
\|\beta\|\le\frac{\alpha b}{\sqrt{r^2-b^2}}.
```
At zero cutoff,
```math
C(v,0)=\{\alpha v:\alpha\ge0\}.
```

**Proof.** The cap contains $rv$, so $\alpha\ge0$. For $b>0$, it contains
```math
bv\pm\sqrt{r^2-b^2}\,u
```
for every unit $u\perp v$. Feasibility therefore gives
```math
\alpha b\pm\sqrt{r^2-b^2}\,\beta\cdot u\ge0.
```
Choosing $u$ along $\beta$, when $\beta\ne0$, proves the bound. For $b=0$, the same perpendicular ball points force $\beta=0$, while the reverse inclusion holds on all of $K$. In dimension one the perpendicular component is absent and the same conclusions are immediate. $\square$

For general $K$, this is an outer bound, not necessarily an exact formula for the cone. A positive cutoff permits angular slack. Exact parallelism is asserted only at zero cutoff.

Define the nonnegative-ray benchmark
```math
G_v(P)=
\max_{\substack{t\ge0\\tv\in\Lambda}}
\mathbb E_P\log(1+t\,v\cdot X).
```

#### Theorem G3.2. Vanishing-cutoff limit

For every Borel $P$ on $K$,
```math
\lim_{b\downarrow0}V(P;v,b)=G_v(P).
```
More generally, the same limit holds along unit vectors $v_n\to v$ and nonnegative cutoffs $b_n\downarrow0$.

**Proof.** Take optimizing coefficients along a sequence of cutoffs. Compactness supplies convergent subsequences, and Lemma G3.1 forces each subsequential limit to have the form $tv$, with $t\ge0$ and $tv\in\Lambda$. Since $H\le L$, upper semicontinuity yields the upper bound $G_v(P)$.

For the lower bound, first fix $t$ with $tv\in\Lambda^\circ$. The only difference between $L_{tv}$ and $H_{v,b,tv}$ lies in the strip $0 \lt v\cdot x\le b$. On that strip $H=1$, and everywhere
```math
0\le\log L_{tv}(x)-\log H_{v,b,tv}(x)\le tb.
```
Thus the lower limit is at least $\mathbb E_P\log L_{tv}$. Scaling toward zero approximates any boundary optimizer by interior ray coefficients, as in the preceding section, proving the result.

If $v_n$ varies, use $tv_n$ for all sufficiently large $n$. These coefficients remain strictly feasible, and their affine factors converge uniformly to the strictly positive $L_{tv}$. The clipping log loss is at most $tb_n$, giving the same lower bound. $\square$

Shrinking a loss cutoff therefore cannot recover an unrestricted direction outside the loss-normal ray. This angular obstruction is additional to the scalar interval-clipping mechanism.

### G4. Sequential upper bounds with arbitrary finite rates

Throughout this section, the data are iid from a fixed Borel law $P$ on $K$. Every factor obeys the conditional iid-null convention in Section G1, and every contrast has a predictable halfspace sign description. Lemma G1.2 makes the pointwise envelope applicable at each finite history. No bound on the negative part of $\log f_t$ is assumed.

For $M>0$, put
```math
\ell_M(z)=\max\{\log z,-M\},\qquad \ell_M(0)=-M.
```
Lemma G1.1 bounds all actual factors by $1+R/r$, so the truncated logarithms are uniformly bounded. Their centered martingale differences obey an almost-sure Cesàro law: Azuma's inequality gives a summable exponential tail at each fixed positive deviation, and Borel–Cantelli followed by a countable sequence of deviations gives convergence to zero.

#### Proposition G4.1. A predictable angular limit

Suppose the contrast at time $t$ has the sign and zero set of $v_t\cdot x-b_t$, where $v_t$ are predictable unit vectors and $b_t\ge0$ are predictable. Assume
```math
v_t\longrightarrow v,\qquad b_t\longrightarrow0
\quad P^{\otimes\infty}\text{-almost surely}.
```
Then every valid finite-rate GUe satisfies
```math
\limsup_{n\to\infty}
\frac1n\sum_{t=1}^n\log f_t(X_{ \lt t},X_t)
\le G_v(P)
\quad P^{\otimes\infty}\text{-almost surely}.
```

**Proof.** At each history, the conditional expected truncated log is at most
```math
\Psi_M(v_t,b_t)=
\max_{\lambda\in\Lambda\cap C(v_t,b_t)}
\mathbb E_P\ell_M(H_{v_t,b_t,\lambda}(X)).
```
Compactness, the nonnegative cutoffs, and Lemma G3.1 imply
```math
\limsup_{t\to\infty}\Psi_M(v_t,b_t)
\le
\max_{\substack{u\ge0\\uv\in\Lambda}}
\mathbb E_P\ell_M(L_{uv}(X))
 =:G_v^M(P).
```
Indeed, optimizing subsequences have ray limits; $H\le L$, and $\ell_M$ is continuous and bounded on $[0,1+R/r]$. The martingale Cesàro law and $\log f_t\le\ell_M(f_t)$ then bound the upper growth by $G_v^M(P)$.

Finally, $G_v^M(P)\downarrow G_v(P)$. To justify this passage, take maximizing ray coefficients for a sequence of increasing integer $M$, extract a convergent subsequence, and compare its values first with every fixed truncation level. Only after this comparison let that fixed level tend to infinity. Compactness and monotone convergence show that the limit of the maxima cannot exceed $G_v(P)$; the reverse inequality is immediate. Intersect the probability-one statements over positive integers $M$. $\square$

#### Proposition G4.2. A stable nonzero cutoff

Suppose predictable unit normals and cutoffs satisfy $v_t\to v$ and $b_t\to b$ almost surely. Assume the open cap
```math
\{x\in K:v\cdot x>b\}
```
is nonempty and $P\{v\cdot X=b\}=0$. Then every valid finite-rate GUe with these contrast signs satisfies
```math
\limsup_{n\to\infty}
\frac1n\sum_{t=1}^n\log f_t(X_{ \lt t},X_t)
\le V(P;v,b)
\quad P^{\otimes\infty}\text{-almost surely}.
```

**Proof.** We need upper semicontinuity of $\Psi_M$ at $(v,b)$. Take convergent feasible coefficients $\lambda_n$ along converging parameters. Every point in the limiting open cap lies in the approximating open caps eventually, so $\lambda\cdot x\ge0$ there. By convexity of $K$, mixing an equality point with a fixed point in the open cap approximates that equality point from within the cap. Hence $\lambda$ is feasible on the entire closed cap.

Outside the limiting hyperplane, the branch defining the envelope is eventually stable, and
```math
H_{v_n,b_n,\lambda_n}(x)\longrightarrow H_{v,b,\lambda}(x).
```
The hyperplane has zero $P$-mass. Bounded convergence therefore applies to the truncated logarithms and establishes the required upper semicontinuity. The bounded-martingale argument and decreasing-maximum argument from Proposition G4.1 now give the claimed bound. $\square$

The zero-hyperplane-mass assumption is substantive. Positive mass at a moving boundary requires a separate one-sided or regime analysis; it cannot be omitted by treating a convergent contrast as a fixed one.

### G5. Exact squared-loss separation in two dimensions

Set $K=[-1,1]^2$, $q=0$, $s=1/2$, and $0<\varepsilon\le1/8$. Let $P_\varepsilon$ assign mass $1/2$ to each of
```math
x_+=(\varepsilon+s,s),\qquad
x_-=(\varepsilon-s,-s).
```
Its mean is $a=(\varepsilon,0)$. Ordinary squared Euclidean loss gives the contrast
```math
\|x\|^2-\|x-a\|^2
=2\varepsilon(x_1-\varepsilon/2).
```
The affine feasible set and the exact cap cone are
```math
\Lambda=\{\lambda:|\lambda_1|+|\lambda_2|\le1\},
\qquad
C=\{\lambda:\lambda_1\ge0,\ |\lambda_2|\le(\varepsilon/2)\lambda_1\}.
```
The cone conditions follow by testing $(1,0)$ and $(\varepsilon/2,\pm1)$. Conversely they imply $\lambda\cdot x\ge0$ throughout the cap $x_1\ge\varepsilon/2$.

#### Theorem G5.1. Exact constrained and unrestricted values

The finite-rate GUe growth supremum at prediction $a$ is
```math
V_{\mathrm{sq}}(\varepsilon)
=-\frac12\log\!\left(
  1-\frac{4\varepsilon^2}{(1-\varepsilon/2)^2}
 \right).
```
The unrestricted one-step e-value growth is
```math
G(\varepsilon)
=\log(1+\varepsilon/2)-\frac12\log(1-\varepsilon^2).
```
In particular,
```math
\frac{V_{\mathrm{sq}}(\varepsilon)}{G(\varepsilon)}
\sim4\varepsilon
\qquad(\varepsilon\downarrow0).
```
For every predictable $a_t\to a$ almost surely, $V_{\mathrm{sq}}(\varepsilon)$ is also an upper bound on the asymptotic growth of every valid squared-loss GUe using those predictions.

**Proof of the GUe value.** For $\lambda\in C$, no additional clipping occurs on either support point: $\lambda\cdot x_+\ge0$, whereas
```math
\lambda\cdot x_-
\le\lambda_1\{\varepsilon-s(1-\varepsilon/2)\}\le0.
```
The expected logarithm is therefore
```math
\frac12\log\!\left[
  (1+\varepsilon\lambda_1)^2
  -s^2(\lambda_1+\lambda_2)^2
\right].
```
For fixed $u=\lambda_1$, the cone gives
$\lambda_1+\lambda_2\ge(1-\varepsilon/2)u$. Put
```math
c=s^2(1-\varepsilon/2)^2-\varepsilon^2>0.
```
The objective is at most $\frac12\log(1+2\varepsilon u-cu^2)$, maximized over $u\ge0$ at $u_*=\varepsilon/c$. The pair
```math
\lambda_1=u_*,
\qquad
\lambda_2=-(\varepsilon/2)u_*
```
attains this bound and is feasible. Indeed, $u_*(1+\varepsilon/2)\le1$ follows from
```math
s^2(1-\varepsilon/2)^2
\ge\varepsilon+\frac32\varepsilon^2.
```
Over the declared range the left side is at least $225/1024$, while the right side is at most $19/128$. Substitution gives the stated $V_{\mathrm{sq}}$. Closed-boundary comparisons retain the supremum convention for finite-rate factors.

**Proof of the unrestricted value.** A coefficient with $\lambda_1<0$ has expected log at most
$\mathbb E(\lambda\cdot X)=\varepsilon\lambda_1<0$.
For $u=\lambda_1\in[0,1]$, the least attainable value of
$|\lambda_1+\lambda_2|$ is $\max\{0,2u-1\}$.
On $[0,1/2]$ the objective increases to $\log(1+\varepsilon/2)$.
On $[1/2,1]$, maximizing it is equivalent to maximizing
```math
(1+\varepsilon u)^2-s^2(2u-1)^2.
```
The unique maximizer in the declared range is
```math
u^*=\frac{\varepsilon+2s^2}{4s^2-\varepsilon^2}
=\frac{\varepsilon+1/2}{1-\varepsilon^2},
\qquad
\lambda_2^*=u^*-1.
```
The maximizing quadratic value is
```math
\frac{s^2(2+\varepsilon)^2}{4s^2-\varepsilon^2},
```
which gives the displayed formula for $G$. Lemma G1.1 makes this the full one-step benchmark. For the sequential assertion, consistent predictions give convergent squared-loss normals and cutoffs, and neither support point lies on the limiting hyperplane $x_1=\varepsilon/2$. Apply Proposition G4.2. $\square$

The unrestricted coefficient hedges the two coordinates. The GUe cone permits only
$|\lambda_2|\le(\varepsilon/2)\lambda_1$, which prevents that hedge. Thus this family exhibits an angular loss even though neither support point is directly clipped by the cutoff.

For reference, the following rational optimizers reproduce the exact formulas; the decimal ratios are diagnostics, not substitutes for the proof.

| $\varepsilon$ | GUe optimizer $(\lambda_1,\lambda_2)$ | Unrestricted optimizer | $V_{\mathrm{sq}}/G$ |
|---|---|---|---:|
| $1/8$ | $(128/209,-8/209)$ | $(40/63,-23/63)$ | 0.5384484832 |
| $1/20$ | $(64/301,-8/1505)$ | $(220/399,-179/399)$ | 0.2038051697 |
| $1/100$ | $(320/7917,-8/39585)$ | $(1700/3333,-1633/3333)$ | 0.0401100062 |
| $1/1000$ | $(3200/799197,-8/3995985)$ | $(167000/333333,-166333/333333)$ | 0.0040010099 |

### G6. Uniform impossibility for every fixed Bregman loss

For $\sigma\in\{-1,+1\}$, let $P_{\varepsilon,\sigma}$ assign equal mass to
```math
(\varepsilon+s,\sigma s),
\qquad
(\varepsilon-s,-\sigma s),
\qquad s=\frac12.
```
Both alternatives have mean $(\varepsilon,0)$. Reflection of the second coordinate shows that both have the unrestricted growth $G(\varepsilon)$ of Theorem G5.1.

Let $\Phi$ be a differentiable strictly convex generator on an open neighborhood of $K$, with Bregman loss
```math
\ell(a,x)=D_\Phi(x,a)
=\Phi(x)-\Phi(a)-\nabla\Phi(a)\cdot(x-a).
```
The generator may depend on $\varepsilon$, $q=0$, and the true mean $a=(\varepsilon,0)$. It is fixed without knowing which of the two alternatives generates the observations. Its contrast at $a$ is
```math
c(x)=w\cdot x-D_\Phi(0,a),
\qquad
w=\nabla\Phi(a)-\nabla\Phi(0).
```
Strict convexity gives
```math
w\cdot a
=D_\Phi(a,0)+D_\Phi(0,a)
>D_\Phi(0,a)>0.
```
With $v=w/\|w\|$ and $b=D_\Phi(0,a)/\|w\|$, it follows that
```math
v_1>0,\qquad 0 \lt b<\varepsilon v_1\le\varepsilon.
```
Write $V_\Phi(P_{\varepsilon,\sigma})=V(P_{\varepsilon,\sigma};v,b)$ for the frozen-prediction GUe supremum.

#### Theorem G6.1. A same-mean alternative defeats every fixed Bregman score

For every $0<\varepsilon\le1/8$ and every generator $\Phi$ just specified, there exists $\sigma\in\{-1,+1\}$ such that
```math
V_\Phi(P_{\varepsilon,\sigma})
\le-\frac12\log(1-16\varepsilon^2).
```
Consequently
```math
\min_{\sigma\in\{-1,+1\}}
\frac{V_\Phi(P_{\varepsilon,\sigma})}{G(\varepsilon)}
\le
\frac{-\frac12\log(1-16\varepsilon^2)}{G(\varepsilon)}
=16\varepsilon+O(\varepsilon^2),
```
uniformly over $\Phi$. The same upper growth bound holds for every GUe using this fixed loss with any predictable $a_t\to(\varepsilon,0)$, and arbitrary finite nonnegative observation-dependent rates.

**Proof.** Choose $\sigma$ such that $\sigma v_2\ge0$, choosing either sign if $v_2=0$. Since $v_1>0$ and $\|v\|=1$,
```math
v_1+\sigma v_2\ge1.
```
The cube contains the unit ball. Lemma G3.1 therefore gives, for any feasible affine majorant,
```math
\lambda=\alpha v+\beta,\qquad
\beta\perp v,\qquad \alpha\ge0,\qquad
\|\beta\|
\le\frac{\alpha b}{\sqrt{1-b^2}}
\le2\varepsilon\alpha.
```
Hence
```math
\begin{aligned}
\lambda_1+\sigma\lambda_2
&\ge\alpha-\sqrt2\|\beta\|
 \ge\alpha(1-3\varepsilon),\\
\lambda_1&\le\alpha(1+2\varepsilon).
\end{aligned}
```
For $\varepsilon\le1/8$, the ratio
$(1-3\varepsilon)/(1+2\varepsilon)$ is at least $1/2$.
Thus, whenever $\lambda_1>0$,
```math
\lambda_1+\sigma\lambda_2\ge\lambda_1/2.
```
If $\lambda_1\le0$, then
```math
\mathbb E_P\log H
\le\mathbb E_P\log L
\le\mathbb E_P(\lambda\cdot X)
=\varepsilon\lambda_1\le0.
```
If $\lambda_1=u>0$, the two support points and domination by $L$ give
```math
\begin{aligned}
\mathbb E_P\log H
&\le\frac12\log\!\left[
(1+\varepsilon u)^2-s^2(\lambda_1+\sigma\lambda_2)^2
\right]\\
&\le\frac12\log\!\left[
(1+\varepsilon u)^2-\frac{s^2}{4}u^2
\right].
\end{aligned}
```
Maximizing the final quadratic over $u\ge0$ gives
```math
-\frac12\log\!\left(1-\frac{4\varepsilon^2}{s^2}\right)
=-\frac12\log(1-16\varepsilon^2).
```
This is an upper bound; its attainment is not needed.

For consistent predictions, convex differentiability on an open set implies continuity of $\nabla\Phi$, so the normalized contrasts converge to $(v,b)$. The selected support points are away from the limiting hyperplane. The contrast at the upper point is positive because $\varepsilon v_1-b>0$; at the lower point it is at most $\varepsilon-s-b<0$. Proposition G4.2 gives the same asymptotic upper bound. $\square$

The order of quantifiers is essential. The result permits a fixed loss chosen using the true alternative mean and even an oracle predictor. The defeating alternative is then chosen from two laws with that same mean. The theorem does not exclude loss selection from the observed history, an arbitrary schedule or mixture of different losses, or predictions that are not mean-consistent. In particular, it does not prohibit learning the covariance information that distinguishes the two alternatives. The obstruction established here is not error in estimating the mean.

### G7. Radial cutoff shrinking retains the angular obstruction

Consider the smooth strictly convex radial generators
```math
\Phi_\gamma(a)=\sqrt{\gamma^2+\|a\|^2},
\qquad \gamma>0.
```
At $a\ne0$, their normalized contrast normal and cutoff are
```math
v=\frac{a}{\|a\|},
\qquad
b=\frac{\gamma\{\sqrt{\gamma^2+\|a\|^2}-\gamma\}}{\|a\|}
\le\gamma.
```
Let $\gamma_t>0$ be deterministic or predictable with $\gamma_t\to0$, and let $a_t$ be mean-consistent under $P_\varepsilon$. Eventually $a_t\ne0$ almost surely, because its limit is $(\varepsilon,0)\ne0$. At a time with $a_t=0$, the contrast is identically zero and the factor equals one; this causes no asymptotic difficulty. The remaining contrasts have $v_t\to e_1$ and $0\le b_t\le\gamma_t\to0$. Proposition G4.1 therefore bounds every valid GUe's growth by
```math
G_{e_1}(P_\varepsilon)
=-\frac12\log(1-4\varepsilon^2).
```
The formula follows by maximizing
```math
\frac12\log\{(1+\varepsilon t)^2-s^2t^2\},
\qquad 0\le t\le1,
```
whose optimizer $t=\varepsilon/(s^2-\varepsilon^2)$ is feasible over the declared range. Its ratio to $G(\varepsilon)$ is again asymptotic to $4\varepsilon$.

Thus the direct radial counterpart of scalar cutoff repair does not recover vector growth. The additional mechanism required by these examples is a change in the loss normal informed by features of the distribution beyond its mean.

## Part II. Exact compatible-score representation

Return to a general tested mean $q$, and write

```math
\Lambda=\{\lambda: L_\lambda(x)=1+\lambda^\mathsf T(x-q)\ge0
\text{ for every }x\in K\}.
```

Membership in $\operatorname{int}\Lambda$ is equivalent to strict positivity of the affine factor on all of $K$.

### Theorem T1. Necessary and sufficient compatibility

Fix a prediction $a\in K$ and a nonzero $\lambda\in\operatorname{int}\Lambda$. The following are equivalent:

1. $\lambda^\mathsf T(a-q)>0$.
2. There is a differentiable strictly convex Bregman generator and a finite nonnegative Borel rate whose GUe factor $f$ satisfies $f\le L_\lambda$ on all of $K$.
3. For every $e>0$, such a generator can be chosen smooth with positive-definite Hessian everywhere on $\mathbb R^d$, and the factor satisfies

```math
0 \lt f(x)\le L_\lambda(x),\qquad
0\le\log L_\lambda(x)-\log f(x)\le e
\quad(x\in K).
\tag{T1}
```

The zero bet has the trivial representation $f=1$, without a compatibility requirement.

**Proof of sufficiency.** Put $\delta=a-q$ and $m=\lambda^\mathsf T\delta>0$. Define

```math
H=\frac{\lambda\lambda^\mathsf T}{m}
   +I_d-\frac{\delta\delta^\mathsf T}{\|\delta\|^2}.
\tag{T2}
```

Then $H\delta=\lambda$. For any nonzero $z$,

```math
z^\mathsf THz
=\frac{(\lambda^\mathsf Tz)^2}{m}
 +\|\operatorname{proj}_{\delta^\perp}z\|^2>0.
```

Indeed, if the second term vanishes, $z$ is a nonzero multiple of $\delta$, so the first is positive. Choose

```math
b=\min(m/4,e),\qquad
\tau=\frac b{\sqrt{m-2b}},\qquad
\Phi(x)=\sqrt{\tau^2+(x-q)^\mathsf TH(x-q)}.
\tag{T3}
```

This generator is smooth on all of $\mathbb R^d$. Writing $y=x-q$ and $s_x=\sqrt{\tau^2+y^\mathsf THy}$, its Hessian satisfies

```math
\nabla^2\Phi(x)=\frac H{s_x}
 -\frac{Hy y^\mathsf TH}{s_x^3},\qquad
z^\mathsf T\nabla^2\Phi(x)z
\ge\frac{\tau^2z^\mathsf THz}{s_x^3}>0.
\tag{T4}
```

The inequality is Cauchy–Schwarz in the $H$-inner product. Thus the generator is strictly convex. Its gradients at $q$ and $a$ are zero and $\lambda/\sqrt{\tau^2+m}$. The identity

```math
b=\tau\big(\sqrt{\tau^2+m}-\tau\big)
```

follows directly from (T3). The loss contrast is consequently

```math
c(x)=\ell_\Phi(q,x)-\ell_\Phi(a,x)
=\frac{\lambda^\mathsf T(x-q)-b}{\sqrt{\tau^2+m}}.
\tag{T5}
```

With $z=\lambda^\mathsf T(x-q)$, set

```math
f(x)=\begin{cases}
1,&0 \lt z\le b,\\
1+z,&\text{otherwise}.
\end{cases}
\qquad
\eta(x)=\begin{cases}
\log f(x)/c(x),&c(x)\ne0,\\
0,&c(x)=0.
\end{cases}
\tag{T6}
```

The logarithm of $f$ has the sign of $c$ wherever it is nonzero, and $f=1$ at zero contrast. Therefore $\eta$ is finite, nonnegative and Borel, and $f=\exp(\eta c)$. Strict positivity uses the interior assumption on $\lambda$. No uniform rate bound is asserted near the clipping boundary. Since $f\le L_\lambda$, the factor is null-valid. The only log difference occurs on $0 \lt z\le b$, where it is at most $\log(1+b)\le b\le e$. This proves (T1). For $\lambda=0$, use a quadratic generator and rate zero.

**Proof of necessity.** If $a=q$, every contrast is zero and $f=1$. A nonzero affine bet is below one somewhere because $q$ is interior, contradicting pointwise domination. If $a\ne q$, strict convexity gives $c(a)=D_\Phi(a,q)>0$. A negative value of $\lambda^\mathsf T(a-q)$ contradicts $f(a)\ge1>L_\lambda(a)$. If this inner product is zero, choose $x\in K$ with $\lambda^\mathsf T(x-q)<0$. A sufficiently short move from $a$ toward $x$ remains in $K$, retains positive contrast, and makes the affine factor strictly below one. This is the same contradiction. Hence the inner product must be strictly positive. The implication from statement 3 to statement 2 is immediate. $\square$

The necessity is for the pointwise dominated representation class, precisely the class in (T1). It does not assert necessity for comparisons that permit the GUe factor to exceed the target at some observations and compensate elsewhere.

### Theorem T2. Predictable transfer with bounded total loss

Let $a_t$ and $\lambda_t\in\operatorname{int}\Lambda$ be predictable and satisfy, at every history,

```math
\lambda_t=0\quad\text{or}\quad
\lambda_t^\mathsf T(a_t-q)>0.
\tag{T7}
```

Apply Theorem T1 with a positive predictable budget $e_t$. The resulting predictable scores and observation-dependent rates define a GUe product $E_n$ with

```math
0\le\sum_{t=1}^n\log L_{\lambda_t}(X_t)-\log E_n
\le\sum_{t=1}^n e_t
\tag{T8}
```

on every data path in $K$. It is a test supermartingale under every process satisfying $\mathbb E[X_t\mid\mathcal F_{t-1}]=q$. If the predictions are empirical means of nonempty past samples, each remains the exact unique empirical-risk minimizer under its current score.

**Proof.** The formulas of Theorem T1 are Borel on the nonzero branch; the zero branch uses the stated quadratic score. Thus the scores depend only on the past, even though rates may use $X_t$. Pointwise domination gives conditional expected multiplier at most one. Adding the pointwise log inequalities gives (T8). For any nonempty empirical law with mean $\bar x$,

```math
\frac1N\sum_{i=1}^N
 \big\{D_\Phi(x_i,a)-D_\Phi(x_i,\bar x)\big\}
=D_\Phi(\bar x,a).
\tag{T9}
```

Strict convexity makes its unique minimizer $a=\bar x$. This identity holds after the current generator is fixed; no independence from the past observations is required. At round one, use the explicit initialization and zero bet. $\square$

The deterministic choice $e_t=1/[t(t+1)]$ makes the cumulative bound in (T8) equal to at most $1-1/(n+1)<1$. The theorem preserves exact empirical minimization, not the consistency of arbitrary approximate minimizers for a changing, potentially poorly conditioned loss. Neither a single score for all tested $q$ nor a loss chosen before observing the history is claimed.

## Part III. A compatible strategy with deterministic regret

The regularized-leader stability and mixture machinery are established online-learning tools [HAK, SS, CO]. The required additional interface is strict compatibility with the full-history empirical mean. Maintain the raw affine expert accounts throughout; the transferred GUe product is a separate account. Its clipping losses are not fed back into the raw posterior weights.

### R2. Geometry and the strategy

Let $K\subset\mathbb R^d$ be compact and convex with nonempty interior, and
fix $q\in\operatorname{int}K$. Set

```math
Y_t=X_t-q,\qquad
\Lambda=\{\lambda\in\mathbb R^d:
                 1+\lambda^\mathsf T(x-q)\ge0\text{ for every }x\in K\}.
\tag{R1}
```

Every sequence in this note has $X_t\in K$. No stochastic assumption is
needed for the regret claims. For validity alone, assume
$\mathbb E[X_t\mid\mathcal F_{t-1}]=q$ almost surely, where each betting
vector is $\mathcal F_{t-1}$-measurable.

The set $\Lambda$ is compact, convex and has the origin in its interior.
Indeed it is an intersection of closed halfspaces. Since a ball
$q+r\mathbb B$ is contained in $K$, its defining inequality implies
$\|\lambda\|\le1/r$. Since $K$ is bounded, a sufficiently small ball
around zero is contained in $\Lambda$. Write

```math
B=\max_{x\in K}\|x-q\|,\quad
R=\max_{\lambda\in\Lambda}\|\lambda\|,\quad M=1+RB.
\tag{R2}
```

Thus $1+\lambda^\mathsf TY\le M$ for all feasible pairs.
Fix $a>0$ and $0<\varepsilon<1$, and let

```math
D_\varepsilon=(1-\varepsilon)\Lambda,
\quad
\lambda_t^{(\varepsilon)}=
\mathop{\rm argmax}_{\lambda\in D_\varepsilon}
\left\{\sum_{s \lt t}\log(1+\lambda^\mathsf TY_s)
                     -\frac a2\|\lambda\|^2\right\}.
\tag{R3}
```

The unique maximizer exists because the domain is compact, all factors are at
least $\varepsilon$, and the objective is strictly concave. It is a
measurable, in fact continuous, function of the finite data history, by the
maximum theorem and uniqueness. Its initial value is zero. The resulting
wealth is

```math
W_n^{(\varepsilon)}=
\prod_{t=1}^n(1+(\lambda_t^{(\varepsilon)})^\mathsf TY_t).
\tag{R4}
```

Each multiplier is strictly positive. Under every conditional-mean null it
has conditional expectation one, so (R4) is a nonnegative martingale starting
at one. This is stronger than the iid-null validity required by the original
manuscript, although it does not by itself compare the procedure to every
possible iid-null e-process.

### R3. Strict alignment with the empirical mean

**Lemma R1.** Put $S_{t-1}=\sum_{s \lt t}Y_s$. Then

```math
(\lambda_t^{(\varepsilon)})^\mathsf TS_{t-1}
\ge\frac a2\|\lambda_t^{(\varepsilon)}\|^2.
\tag{R5}
```

If $S_{t-1}=0$, the betting vector is zero. If $S_{t-1}\ne0$, the
betting vector is nonzero and its inner product with $S_{t-1}$ is strictly
positive. For $t\ge2$, it therefore has strictly positive inner product
with $\bar X_{t-1}-q$ whenever that displacement is nonzero.

**Proof.** Comparing the maximizer in (R3) with zero and using
$\log(1+u)\le u$ gives

```math
0\le\sum_{s \lt t}\log(1+\lambda_t^\mathsf TY_s)
       -\frac a2\|\lambda_t\|^2
\le\lambda_t^\mathsf TS_{t-1}-\frac a2\|\lambda_t\|^2.
```

This proves (R5) and forces $\lambda_t=0$ when $S_{t-1}=0$. If
$S_{t-1}\ne0$, the derivative at zero of the objective is
$S_{t-1}\ne0$. Since zero is an interior point of $D_\varepsilon$,
zero cannot maximize it. Thus the right side of (R5) is positive. $\square$

The conclusion concerns a vector inner product, not coordinatewise signs.
The latter is neither needed nor asserted.

### R4. A fixed-interior deterministic regret bound

Define

```math
\mathcal D_n=\log\det\left(I_d+
             \frac{1}{aM^2}\sum_{t=1}^nY_tY_t^\mathsf T\right).
\tag{R6}
```

**Theorem R2.** For every data sequence in $K$, every $n\ge1$, and
every $u\in D_\varepsilon$,

```math
\sum_{t=1}^n\log(1+u^\mathsf TY_t)-\log W_n^{(\varepsilon)}
\le \frac a2\|u\|^2+\frac{M^2}{\varepsilon^2}\mathcal D_n
\le\frac{aR^2}{2}+
\frac{M^2d}{\varepsilon^2}
\log\left(1+\frac{nB^2}{aM^2d}\right).
\tag{R7}
```

**Proof.** Put $f_t(\lambda)=-\log(1+\lambda^\mathsf TY_t)$ and
$F_t(\lambda)=a\|\lambda\|^2/2+\sum_{s\le t}f_s(\lambda)$, so
$\lambda_{t+1}$ minimizes $F_t$. Write

```math
A_t=aI_d+M^{-2}\sum_{s\le t}Y_sY_s^\mathsf T.
```

Throughout $D_\varepsilon$,

```math
\nabla^2F_t(\lambda)=aI_d+
\sum_{s\le t}\frac{Y_sY_s^\mathsf T}
                        {(1+\lambda^\mathsf TY_s)^2}
\succeq A_t.
\tag{R8}
```

Let $\Delta_t=\lambda_t-\lambda_{t+1}$ and
$g_t=\nabla f_t(\lambda_t)$. The two constrained first-order
optimality inequalities imply

```math
\nabla F_{t-1}(\lambda_t)^\mathsf T\Delta_t\le0,
\qquad
\nabla F_t(\lambda_{t+1})^\mathsf T\Delta_t\ge0.
```

Together with (R8), they give

```math
\|\Delta_t\|_{A_t}^2
\le [\nabla F_t(\lambda_t)-
        \nabla F_t(\lambda_{t+1})]^\mathsf T\Delta_t
\le g_t^\mathsf T\Delta_t.
```

Consequently $\|\Delta_t\|_{A_t}\le\|g_t\|_{A_t^{-1}}$.
Convexity of $f_t$ and Cauchy–Schwarz yield the stability bound

```math
f_t(\lambda_t)-f_t(\lambda_{t+1})
\le g_t^\mathsf T\Delta_t
\le \|g_t\|_{A_t^{-1}}^2
\le \varepsilon^{-2}Y_t^\mathsf TA_t^{-1}Y_t.
\tag{R9}
```

For completeness, the usual be-the-leader telescoping inequality applied to
the successive minimizers of $F_t$, with the regularizer as the initial
loss, states

```math
\sum_{t=1}^nf_t(\lambda_t)-\sum_{t=1}^nf_t(u)
\le\frac a2\|u\|^2+
        \sum_{t=1}^n[f_t(\lambda_t)-f_t(\lambda_{t+1})].
\tag{R10}
```

It follows by induction from
$\sum_{t=1}^nf_t(\lambda_{t+1})\le F_n(u)$, since the initial
regularizer has minimum zero. This also covers constrained boundary
minimizers; no unconstrained stationarity equation was used.

Let $z_t=M^{-2}Y_t^\mathsf TA_{t-1}^{-1}Y_t\ge0$. The rank-one
inverse and determinant identities give

```math
Y_t^\mathsf TA_t^{-1}Y_t
=M^2\frac{z_t}{1+z_t}
\le M^2\log(1+z_t)
=M^2\log\frac{\det A_t}{\det A_{t-1}}.
\tag{R11}
```

Sum (R9)–(R11) to obtain the first inequality in (R7). For the second,
apply the arithmetic–geometric mean inequality to the nonnegative
eigenvalues of $(aM^2)^{-1}\sum Y_tY_t^\mathsf T$, whose sum is at
most $nB^2/(aM^2)$. $\square$

At any fixed $\varepsilon>0$ and fixed geometry, (R7) is
$O(d\log n)$. The dependence on $\varepsilon^{-2}$ is part of
the theorem and must not be suppressed when approaching the boundary.

### R5. One full-domain strategy, still aligned

For $k\ge1$, take $\varepsilon_k=2^{-k}$, use the same positive
ridge constant $a$, and run (R3) separately at each $k$. Let

```math
\pi_k=\frac1{k(k+1)},\qquad
W_n=\sum_{k=1}^\infty\pi_kW_n^{(\varepsilon_k)},\qquad W_0=1.
\tag{R12}
```

This is a mathematical countable mixture, not a claim of constant-time or
finite-precision implementation. It converges, because every component
wealth lies in $(0,M^n]$. Its next multiplier equals

```math
\frac{W_t}{W_{t-1}}=1+\bar\lambda_t^\mathsf TY_t,
\quad
\bar\lambda_t=\sum_{k\ge1}\rho_{k,t-1}\lambda_t^{(\varepsilon_k)},
\quad
\rho_{k,t-1}=\frac{\pi_kW_{t-1}^{(\varepsilon_k)}}{W_{t-1}}.
\tag{R13}
```

All posterior weights are strictly positive and sum to one. The series of
vectors converges absolutely because $\|\lambda_t^{(\varepsilon_k)}\|\le R$.
Thus $\bar\lambda_t\in\Lambda$, and every actual multiplier is
strictly positive. All rules are measurable by countable limits.

**Theorem R3.** The mixture (R12) is a positive martingale under every
conditional-mean null. At every history,

```math
S_{t-1}=0\Longrightarrow\bar\lambda_t=0,
\qquad
S_{t-1}\ne0\Longrightarrow\bar\lambda_t^\mathsf TS_{t-1}>0.
\tag{R14}
```

For every sequence in $K$, define the unrestricted affine hindsight
benchmark

```math
B_n^*=\max_{u\in\Lambda}\prod_{t=1}^n(1+u^\mathsf TY_t).
\tag{R15}
```

The maximum exists by continuity and compactness, and is at least one. Then

```math
\log B_n^* -\log W_n
\le\frac{aR^2}{2}+\inf_{k\ge1}
\left\{
n\log\frac1{1-2^{-k}}+
M^2 4^k\mathcal D_n+\log(k(k+1))
\right\}.
\tag{R16}
```

For fixed $K,q,d,a$, its right side admits the deterministic upper order

```math
O\!\left(n^{2/3}(d\log(n+1))^{1/3}+\log\log(n+3)+1\right)=o(n).
\tag{R17}
```

**Proof.** Conditional validity follows either from (R13) or from conditional
Tonelli applied to the nonnegative component martingales. Lemma R1 proves
(R14): when $S\ne0$, every summand has strictly positive inner product
with $S$, and its weight is positive.

Fix $u\in\Lambda$ and $k$. The shrinkage
$u_k=(1-\varepsilon_k)u$ lies in $D_{\varepsilon_k}$, and

```math
1+u_k^\mathsf TY_t
=\varepsilon_k+(1-\varepsilon_k)(1+u^\mathsf TY_t)
\ge(1-\varepsilon_k)(1+u^\mathsf TY_t).
```

Also $W_n\ge\pi_kW_n^{(\varepsilon_k)}$. Combine these facts with
Theorem R2, then maximize over $u$, to obtain (R16). If a particular
comparator product is zero the logarithmic comparison is vacuous; a
maximizer of (R15) has positive product because the maximum is at least one.

For the order claim put
$H_n=M^2d\log(1+nB^2/(aM^2d))$, which upper bounds
$M^2\mathcal D_n$. For all sufficiently large $n$,
$h_n=(H_n/n)^{1/3}\le1/2$. Choose
$k_n=\lceil\log_2(1/h_n)\rceil$, so
$h_n/2<2^{-k_n}\le h_n$. Using
$-\log(1-v)\le2v$ for $v\le1/2$, the first two terms in
braces in (R16) are at most

```math
2nh_n+4H_n/h_n^2=6n^{2/3}H_n^{1/3}.
```

The weight penalty is $O(\log\log(n+3)+1)$. The finitely many remaining
horizons can be absorbed into the fixed constant in (R17). $\square$

The full-domain bound here is sublinear, **not logarithmic**. It is not
claimed minimax-optimal. The logarithmic statement applies only to a fixed
interior domain as in Theorem R2.

### R6. Applying the compatible-score transfer

Set $a_1=q$ and, for $t\ge2$, $a_t=\bar X_{t-1}$. Equation
(R14) is precisely the compatibility condition of Theorem T2:

```math
a_t=q\Longrightarrow\bar\lambda_t=0,
\qquad
a_t\ne q\Longrightarrow\bar\lambda_t^\mathsf T(a_t-q)>0.
\tag{R18}
```

Theorem T2 supplies positive
valid GUe multipliers $f_t$ with the same predictions and

```math
\log f_t(x)\ge
\log(1+\bar\lambda_t^\mathsf T(x-q))-\epsilon_t
\quad\text{for every }x\in K,
\qquad\sum_t\epsilon_t<\infty.
\tag{R19}
```

Then summation, with no stochastic assumptions, immediately gives

```math
\log B_n^*-\sum_{t=1}^n\log f_t(X_t)
\le\text{right side of (R16)}+\sum_{t=1}^n\epsilon_t.
\tag{R20}
```

In particular, the scalar prediction-direction mismatch count is absent.
This is a full-support and all-data-sequence comparison to the affine
benchmark. A further claim of iid optimality over **all** null e-values
requires a correctly stated numeraire/reverse-projection theorem for the
multivariate moment null; Proposition B1 supplies that comparison.

### R7. What this does and does not resolve

This provides a stronger mathematical interface than an eventual
direction argument: one strategy is compatible with ordinary empirical-mean
predictions at every history and has deterministic sublinear regret against
the full affine class in every fixed dimension. It also identifies the
honest finite-sample price incurred by this elementary implementation.

This does not establish a new optimal portfolio algorithm, a sharp minimax-regret coefficient, finite arithmetic complexity of the continuous convex optimizations, or numerical stability of the adaptive loss realization. The next section replaces the infinite sum by a finite active sum with an explicit cash tail.

### R8. Preferred implementation: finitely many active experts

The countable strategy in Part III §5 is conceptually simple but unnecessary.
The following sleeping-expert version uses only finitely many active
continuous convex optimizations at each finite time, retains the global
empirical-mean prediction, and has the same proved regret order.

Retain $\varepsilon_k=2^{-k}$, $\pi_k=1/[k(k+1)]$, and the
full-history FTRL vector $\lambda_t^{(\varepsilon_k)}$ defined by (R3).
Set $T_k=2^k$. Expert $k$ holds cash until round $T_k$, then
uses those full-history FTRL vectors. Its actual wealth is

```math
V_n^{(k)}=
\begin{cases}
1,&n \lt T_k,\\
\displaystyle\prod_{t=T_k}^n
 (1+(\lambda_t^{(\varepsilon_k)})^\mathsf TY_t),&n\ge T_k.
\end{cases}
\tag{R21}
```

Its optimization at round $t$ always includes **all** raw observations
$Y_1,\ldots,Y_{t-1}$, including those before it was activated. It does
not restart its statistical training history. The hypothetical full-history
wealth $W_n^{(\varepsilon_k)}$ before activation is used only in the
regret comparison; it is not included in the actual account (R21).

Let $m(n)=\lfloor\log_2 n\rfloor$ for $n\ge1$, and $m(0)=0$.
Define

```math
\widetilde W_n
=\sum_{k\ge1}\pi_kV_n^{(k)}
=\sum_{k=1}^{m(n)}\pi_kV_n^{(k)}+\frac1{m(n)+1}.
\tag{R22}
```

The last equality uses the telescoping prior tail. Thus the actually
computed sum is finite. At round $t$, define

```math
\widetilde\lambda_t=
\sum_{k=1}^{m(t)}
\frac{\pi_kV_{t-1}^{(k)}}{\widetilde W_{t-1}}
          \lambda_t^{(\varepsilon_k)},
\qquad
\frac{\widetilde W_t}{\widetilde W_{t-1}}
=1+\widetilde\lambda_t^\mathsf TY_t.
\tag{R23}
```

For an expert first activated at $t$, its value
$V_{t-1}^{(k)}$ in this formula is one. The remaining normalized wealth
is a strictly positive cash weight. Consequently
$\widetilde\lambda_t\in\operatorname{int}\Lambda$ at every finite
history: the factor on all of $K$ is bounded below by that cash weight.
This is also immediate at $t=1$, where the betting vector is zero.

**Theorem R4.** The wealth (R22) is a positive martingale under every
conditional-mean null. It satisfies the same strict alignment dichotomy
(R14) with $\widetilde\lambda_t$ in place of $\bar\lambda_t$.
For every sequence in $K$,

```math
\begin{split}
\log B_n^* -\log\widetilde W_n
\le\frac{aR^2}{2}+\inf_{k\ge1}\bigg\{
&n\log\frac1{1-2^{-k}}+M^2 4^k\mathcal D_n\\
&+\min(n,2^k-1)\log M+\log(k(k+1))\bigg\}.
\end{split}
\tag{R24}
```

For fixed geometry and dimension this is still
$O(n^{2/3}(d\log(n+1))^{1/3}+\log\log(n+3)+1)=o(n)$.
It uses $\lfloor\log_2 t\rfloor$ active FTRL programs at round
$t$. No arithmetic-complexity bound for solving those programs to
finite precision is included.

**Proof.** Every component is a mean-null martingale, because it uses unit
factors before activation and predictable feasible linear factors
afterwards. The finite expression (R22), or conditional Tonelli, gives
validity of the mixture. Formula (R23) follows by expanding the next wealth
increment. When $S_{t-1}=0$, all active vectors vanish by Lemma R1.
When $S_{t-1}\ne0$, necessarily $t\ge2$, and the first expert is
already active. Every active inner product is positive and every active
weight is positive, proving strict alignment.

Let $j=\min(n,T_k-1)$. Exactly,

```math
V_n^{(k)}=
\frac{W_n^{(\varepsilon_k)}}{W_j^{(\varepsilon_k)}}
\ge M^{-j}W_n^{(\varepsilon_k)},
\tag{R25}
```

because each hypothetical prefix factor is at most $M$. This identity
also covers $n \lt T_k$, when numerator and denominator are equal. Since
$\widetilde W_n\ge\pi_kV_n^{(k)}$, the proof of Theorem R3 now
adds only $j\log M$, yielding (R24).

For the asymptotic order use the same $k_n$ as in the proof of (R17).
The extra term is at most
$2\log M\,(n/H_n)^{1/3}$, which is of smaller order than
$n^{2/3}H_n^{1/3}$ for fixed nondegenerate geometry, since
$H_n$ is of order $\log n$. $\square$

The GUe interface (R18)–(R20) applies verbatim with this preferred finite
activation strategy and bound (R24). At rounds $t\ge2$ the adaptive score has the
ordinary empirical mean of **all** previous observations as its unique
empirical-risk minimizer. The sleeping-expert schedule does not change the
prediction target or discard early observations.

## Part IV. Full iid optimality and a sampling consequence

The next benchmark is an elementary compact-vector specialization of the established Kelly/numeraire and sequential growth theory [LRR-N, RR]. It is proved here to make the Borel, boundary and terminal-e-value comparisons explicit; the benchmark itself is not claimed as a new invention.

### Proposition B1. The all-terminal-e-value benchmark

For a Borel alternative $P$ on $K$, put

```math
G(P,q)=\max_{\lambda\in\Lambda}
 \mathbb E_P\log\{1+\lambda^\mathsf T(X-q)\}.
\tag{B1}
```

This maximum is finite, nonnegative and attained. There is a mean-$q$ probability law $Q_*$ and a maximizing factor $L_*$ such that $L_*\,dQ_*=dP$. For every sequence of nonnegative time-$n$ e-values $T_n$ valid under all iid mean-$q$ null laws,

```math
\limsup_{n\to\infty}\frac{\log T_n}{n}\le G(P,q)
\quad P^{\otimes\infty}\text{-almost surely}.
\tag{B2}
```

No product or conditional-validity assumption is imposed on $T_n$.

**Proof.** The affine factors have a common finite upper bound $M$. Reverse Fatou makes their expected logs upper semicontinuous on compact $\Lambda$, and the zero bet has value zero. A maximizing $L_*$ is therefore positive $P$-almost surely with integrable logarithm. Optimality along mixtures with any $L_\lambda$ gives

```math
\mathbb E_P[L_\lambda/L_*]\le1.
\tag{B3}
```

For precision, divide $\log[1+t(L_\lambda/L_*-1)]$ by $t$ and let $t\downarrow0$. These quotients increase to $L_\lambda/L_*-1$ and have a uniform finite lower bound for $0 \lt t\le1/2$. Monotone convergence justifies (B3) without first assuming reciprocal integrability. Taking $\lambda=0$ gives $A=\mathbb E_P(1/L_*)\le1$. Bounded support makes $D=\mathbb E_P[(X-q)/L_*]$ finite. With $c=1-A$,

```math
A+\lambda_*^\mathsf TD=1,\qquad
\lambda^\mathsf TD\le c\quad(\lambda\in\Lambda).
\tag{B4}
```

If $c=0$, the neighborhood of zero in $\Lambda$ forces $D=0$, and $Q_*=P/L_*$ works. If $c>0$, put $z=-D/c$. The polar description of the compact convex set $K-q$ implies $z\in K-q$: otherwise strict separation, with zero in the interior of that set, would give some $\lambda\in\Lambda$ for which $1+\lambda^\mathsf Tz<0$, contradicting (B4). Also $\lambda_*^\mathsf Tz=-1$. Define

```math
Q_*(dx)=\frac{P(dx)}{L_*(x)}+c\,\delta_{q+z}(dx).
\tag{B5}
```

Its total mass is one and its mean is $q$. The extra mass is at a zero of $L_*$, a $P$-null point, so $L_*dQ_*=dP$.

Let $B_n=\prod_{t\le n}L_*(X_t)$. Change of measure gives $\mathbb E_P[T_n/B_n]\le1$. Markov's inequality, Borel–Cantelli and a countable sequence of positive thresholds imply $\limsup n^{-1}\log(T_n/B_n)\le0$. The iid strong law applies to the integrable $\log L_*$, proving (B2). $\square$

Jensen gives $G=0$ at mean $q$. Otherwise a small positive multiple of $\mathbb E_PX-q$ has a positive derivative of expected log at zero, so $G>0$. Interior slopes approximate the maximum: concavity gives

```math
\mathbb E_P\log L_{(1-\epsilon)\lambda_*}
\ge(1-\epsilon)G.
\tag{B6}
```

A countable dense collection of interior slopes suffices, because their log objectives are locally continuous and bounded.

### Theorem B2. One empirical-mean GUe attains the benchmark

Use the finite-activation strategy of Theorem R4, the predictor $a_1=q$, $a_t=\bar X_{t-1}$ for $t\ge2$, and the score conversion in Theorem T2 with $e_t=1/[t(t+1)]$. This specifies one measurable rule independent of the alternative law. It is conditionally mean-null-valid. On every path, its log wealth is within less than one of the raw compatible strategy, and its regret against the full affine class is bounded by the right side of (R24) plus one. For every fixed Borel iid alternative,

```math
\frac{\log E_n}{n}\longrightarrow G(P,q)
\quad P^{\otimes\infty}\text{-almost surely}.
\tag{B7}
```

**Proof.** Theorem R4 proves strict compatibility at every nonzero empirical-mean displacement, with a zero bet otherwise. Its positive cash weight puts every mixed bet in $\operatorname{int}\Lambda$, so Theorems T1–T2 apply. Theorem R4's regret is $o(n)$ uniformly over paths at fixed geometry and dimension. Comparing with any fixed interior affine factor and applying its bounded-log iid strong law gives the lower growth bound. Take a countable dense collection of interior slopes and use (B6). Proposition B1 gives the upper bound, including when $P$ has mean $q$. $\square$

The upper benchmark allows every terminal-valid e-value under the smaller iid null. The constructed process is valid under the larger class of conditional-mean-null laws. The first-order optimality claim is for iid alternatives; all-path regret itself needs no distributional assumption.

### Corollary B3. An unbounded first-order evidence-threshold penalty

For a single fixed process $E$, define

```math
\tau_E(h)=\inf\{n\ge1:\log E_n\ge h\},\qquad
\inf\varnothing=\infty.
\tag{B8}
```

If $n^{-1}\log E_n\to g>0$ and every finite-time log is finite, then $\tau_E(h)/h\to1/g$ almost surely as $h\to\infty$. If $\limsup n^{-1}\log F_n\le v$ with $v>0$, and every finite-time $\log F_n$ is finite, then $\liminf\tau_F(h)/h\ge1/v$, allowing infinite hitting times.

**Proof.** For any $0<\eta \lt g$, eventually $(g-\eta)n\le\log E_n\le(g+\eta)n$. The maximum of the finitely many preceding log values is finite on each path. Once $h$ exceeds that maximum, crossing is impossible before $h/(g+\eta)$ and occurs by $\lceil h/(g-\eta)\rceil$ for large $h$. Let $\eta\downarrow0$. The one-sided statement uses only the upper envelope with $v+\eta$. $\square$

Apply this to the fixed-square-loss family in Theorem G5.1 and the repaired process in Theorem B2. Every fixed squared-loss GUe with consistent predictions satisfies

```math
\liminf_{h\to\infty}
\frac{\tau_{\rm fixed}(h)}{\tau_{\rm repaired}(h)}
\ge\frac{G(\epsilon)}{V_{\rm sq}(\epsilon)}
\sim\frac1{4\epsilon}.
\tag{B9}
```

Thus the first-order sampling penalty can be arbitrarily large despite the identical empirical-mean estimator. This is a pathwise threshold result, equivalently $\alpha=e^{-h}\downarrow0$, for procedures whose rule is not changed with $\alpha$. It is not an expected-stopping-time theorem, a finite-$\alpha$ approximation or an interchange of the $\epsilon\downarrow0$ and $h\to\infty$ limits.

## Scope and verification

The results concern finite-dimensional bounded means, a known compact convex support, an interior separately fixed null mean, Bregman mean-eliciting losses, and finite nonnegative observation-dependent rates under conditional unit dominance. The general envelope covers all Borel alternatives; stable-prediction upper bounds at a nonzero cutoff explicitly exclude an atom on the limiting hyperplane. The exact examples satisfy that condition. The fixed-score impossibility does not exclude arbitrary predictable changes of score; the repair uses them deliberately. It does not solve an arbitrary risk-functional problem, growing-dimensional minimax inference, boundary nulls, unbounded data, or construction of one common score and rate for an entire confidence curve.

All formal proofs in this manuscript are written mathematics. The accompanying rational checks verify optimizer identities and finite feasible-slope grids; numerical diagnostics verify constructed Hessians, contrasts, rates, finite-activation updates, optimization residuals and regret on declared paths, including paths deliberately entering the clipping strip. These computations corroborate algebra and implementation and do not replace universal proofs or Lean kernel verification. No sharp boundary-regret rate, efficient finite-precision algorithm, uniform conditioning bound, external peer review or journal acceptance is claimed.

## References

- **[DMW]** N. Dey, R. Martin, J. P. Williams. *Generalized universal inference on risk minimizers*. JRSS B **88**(3), 756–778 (2026). [DOI 10.1093/jrsssb/qkaf065](https://doi.org/10.1093/jrsssb/qkaf065). [Inspected author version v3](https://arxiv.org/html/2402.00202v3).
- **[CLZ]** P. Casgrain, M. Larsson, J. Ziegel. *Sequential testing for elicitable functionals via supermartingales*. Bernoulli **30**(2), 1347–1374 (2024). [DOI 10.3150/23-BEJ1634](https://doi.org/10.3150/23-BEJ1634). [Author manuscript](https://arxiv.org/pdf/2204.05680).
- **[LRR-C]** M. Larsson, A. Ramdas, J. Ruf. *Testing Hypotheses Generated by Constraints*. Mathematics of Operations Research, online 2026. [DOI 10.1287/moor.2025.1129](https://doi.org/10.1287/moor.2025.1129). [Inspected author version v5](https://arxiv.org/html/2504.02974v5).
- **[LRR-N]** M. Larsson, A. Ramdas, J. Ruf. *The numeraire e-variable and reverse information projection*. Annals of Statistics **53**(3), 1015–1043 (2025). [DOI 10.1214/24-AOS2487](https://doi.org/10.1214/24-AOS2487). [Inspected author version v4](https://arxiv.org/html/2402.18810v4).
- **[RR]** A. Ram, A. Ramdas. *The optimal betting wealth growth rate*. [arXiv:2604.25280v1](https://arxiv.org/html/2604.25280v1), 2026.
- **[DFZ]** T. Dimitriadis, T. Fissler, J. Ziegel. *The Efficiency Gap*. [arXiv:2010.14146v3](https://arxiv.org/html/2010.14146v3), 2022. The inspected preprint is the cited version; no unverified journal metadata is assigned.
- **[SR]** A. Saha, A. Ramdas. *Optimal e-variables under constraints*. [arXiv:2604.21680v1](https://arxiv.org/html/2604.21680v1), 2026.
- **[CO]** T. Cover, E. Ordentlich. *Universal portfolios with side information*. IEEE Transactions on Information Theory **42**(2), 348–363 (1996). [DOI 10.1109/18.485708](https://doi.org/10.1109/18.485708).
- **[HAK]** E. Hazan, A. Agarwal, S. Kale. *Logarithmic regret algorithms for online convex optimization*. Machine Learning **69**, 169–192 (2007). [DOI 10.1007/s10994-007-5016-8](https://doi.org/10.1007/s10994-007-5016-8).
- **[SS]** S. Shalev-Shwartz. *Online Learning and Online Convex Optimization*. Foundations and Trends in Machine Learning **4**(2), 107–194 (2012). [DOI 10.1561/2200000018](https://doi.org/10.1561/2200000018).
- **[OJ]** F. Orabona, K.-S. Jun. *Tight Concentrations and Confidence Sequences From the Regret of Universal Portfolio*. IEEE Transactions on Information Theory **70**(1), 436–455 (2024). [DOI 10.1109/TIT.2023.3330187](https://doi.org/10.1109/TIT.2023.3330187).
- **[BGW]** A. Banerjee, X. Guo, H. Wang. *On the optimality of conditional expectation as a Bregman predictor*. IEEE Transactions on Information Theory **51**(7), 2664–2669 (2005). [DOI 10.1109/TIT.2005.850145](https://doi.org/10.1109/TIT.2005.850145).

The comparisons are limited to the source versions cited here. The arguments above are self-contained where used; inaccessible publisher text is not an unstated proof premise.
