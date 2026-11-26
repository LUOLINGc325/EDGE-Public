# Sharp Rare-Erasure Asymptotics for Remote Estimation with Distinguishable Silence

**Research manuscript — 25 November 2026**

## Abstract

A sensor observes a random vector and either remains silent or attempts to transmit its exact value over an erasure channel. Silence and attempted-but-erased transmission produce different receiver symbols. For squared-error estimation, this distinction makes the scheduling action an information-bearing observation. We determine the sharp improvement over always transmitting when the erasure probability is $\lambda\downarrow0$ and the cost per transmission attempt is $c=\kappa\lambda$, for every fixed dimension and fixed $\kappa\ge0$. For an everywhere positive continuous density $f$ with mean zero, finite second moment, and $(1+\|x\|)^{d+2}f(x)\to0$, the improvement divided by $\lambda^{1+d/2}$ converges to
```math
\frac{2v_d}{d+2}\max_{a\in\mathbb R^d}
f(a)(\|a\|^2+\kappa)^{(d+2)/2}.
```
Here $v_d$ is the volume of the Euclidean unit ball. We establish attainment over all measurable randomized schedules, use the known quadratic quantizer geometry to characterize every optimizer as a silent ball, and prove that all optimal centers remain bounded and approach the explicit maximizing set. We also obtain the radius, silence-probability, and nonsuccess-decoder scales, and an implementable asymptotically optimal design from any fixed maximizer. For a standard Gaussian source, the limiting center radius is $\sqrt{(d+2-\kappa)_+}$, and we compute the exact loss of restricting to even kernels at the main asymptotic scale. A smooth positive bounded-density construction with finite second moment shows that, without suitable tail control, the normalized improvement can diverge and every optimal center can escape. Finally, a separate horizon-one example with positive measurement noise, positive process noise, positive transmission cost, and interior erasure probabilities contradicts the global symmetric-scheduling assertion in the specifically inspected arXiv version 2501.13192v2. The scalar/vector quantizer geometry and the qualitative usefulness of asymmetric silence are established prior results; the main contribution here is the sharp global asymptotic law and optimizer selection.

## 1. Introduction

A failed communication attempt and an intentional absence of communication need not convey the same information. If a receiver observes which of these events occurred, the two events identify complementary parts of the sensor's observation space. An estimator can then use two different conditional means even when no numerical payload arrives. This effect persists when the underlying source is symmetric, because a scheduling rule may assign an asymmetric silent region.

This mechanism and its quantizer geometry are established. Vasconcelos and Martins studied estimation over collision channels and derived threshold descriptions of globally optimal policies, including asymmetric Gaussian examples [1,2]. The vector extension produces quadratic decision surfaces [1,3]. Zhang and Vasconcelos' fixed-parameter reactive-jamming subproblem contains the expected minimum of the same two quadratic losses used here [4]. The corresponding finite-dimensional reduction is therefore a starting point, rather than a new contribution of this manuscript.

The remaining quantitative question considered here is a global one. When erasures become rare, how much can an optimally chosen silent region improve on always transmitting? What determines its location? Can a local calculation near a proposed center miss a more competitive region in a remote tail? A fixed-center Taylor expansion alone cannot answer these questions, because both the center and the size of a globally optimal region may depend on the erasure probability.

We answer them for a broad class of continuous source densities. The cost scale $c=\kappa\lambda$ places the transmission price and erasure probability at comparable first order. The optimal improvement is smaller, of order $\lambda^{1+d/2}$. Its exact coefficient is a maximization of a weighted density:
```math
a\longmapsto f(a)(\|a\|^2+\kappa)^{(d+2)/2}.
```
The same function selects all limiting optimal centers. A mild-looking local construction supplies the lower bound; the substantive global step is to show that no optimizing sequence can escape to a tail or degenerate on a different scale.

### 1.1. Results and scope

The main results are as follows.

1. **Global sharp asymptotics.** Theorem 2.1 gives the exact optimal-risk coefficient over all measurable randomized scheduling kernels and all measurable decoders. The hypotheses require neither differentiability of the density nor log-concavity.

2. **All-optimizer selection and a usable design.** The theorem locates every global optimizer, proves nondegeneracy of its scaled radius and silence probability, and describes its two nonsuccess decoder values. Corollary 6.1 gives an explicit family of asymptotically optimal schedules from any fixed maximizer of the weighted density.

3. **Gaussian consequences.** Theorem 7.1 gives the dimension-dependent limiting center transition at $\kappa=d+2$. Theorem 7.2 gives the exact even-kernel optimum for all finite parameters and its loss relative to unrestricted scheduling on the sharp asymptotic scale.

4. **A tail obstruction.** Theorem 8.1 constructs an everywhere positive, bounded, smooth density with finite second moment for which the normalization in the main theorem diverges. In this construction all optimal centers escape. This demonstrates a real need for tail control; it does not assert that our sufficient tail assumption is necessary.

5. **A version-specific correction.** Proposition 9.1 gives a fully nondegenerate horizon-one counterexample to the global symmetric-scheduling assertion in arXiv:2501.13192v2 [5]. The comparison covers every even randomized scheduling kernel. It does not claim that the exhibited sign schedule is globally optimal.

The asymptotic parameter is $\lambda\downarrow0$ with $d$ and $\kappa$ fixed. We do not classify finite-$\lambda$ symmetry transitions, study growing dimension, or solve a general multistage control problem. The receiver distinguishes silence from erasure. Models in which these observations are merged require a different analysis.

### 1.2. Relation to prior work

The closest structural predecessor is the single-sensor subproblem in Vasconcelos–Martins [1, Problem 2 and Theorem 2]. It allows a continuous source, a randomized transmission decision, an independent channel-occupation event, a transmission price, and distinct nonsuccess symbols. Its interval reduction and discussion of asymmetric Gaussian thresholds already capture the qualitative mechanism. The continuous-vector extension is stated in [1, Section VII-A] and [3, Section 3.5]. The conference predecessor is [2].

A second direct overlap is [4, Section III-C, equation (59)]. Fixing its reactive-jamming parameters to no idle interference, transmission-time interference probability $\lambda$, and zero jammer price gives the same fixed-decoder expression
```math
\mathbb E\min\{\|X-a\|^2,\lambda\|X-b\|^2+c\}.
```
We include a self-contained derivation to settle attainment and all-optimizer statements, without claiming originality for this expression, ball geometry, or finite-dimensional optimization.

The high-reliability result here differs from asymptotic discussions of an iteration or a large network. Our limit optimizes the actual one-source estimation risk globally while $\lambda\downarrow0$ and $c=\kappa\lambda$. The proof must exclude moving centers in an unbounded state space and establish matching constants and selection for every global optimizer. Within the primary sources compared for this manuscript, we did not locate this full quantitative theorem. This is a bounded literature comparison, not an assertion of exhaustive priority.

The counterexample in Section 9 addresses the precise information pattern and theorem statement of the inspected arXiv version [5]. It has no bearing on a model in which an unobserved action merges silence and erasure, or on a reliable-forward-channel result. We make no claim about a journal version whose full text has not been inspected.

## 2. Model and main theorem

Fix an integer $d\ge1$. Let $X$ have an everywhere positive continuous density $f$ on $\mathbb R^d$, with
```math
\mathbb EX=0,\qquad M_2:=\mathbb E\|X\|^2<\infty.
\tag{2.1}
```
The sensor observes $X$ and chooses an action $U\in\{0,1\}$. All measurable randomized scheduling kernels are admissible. Equivalently, write
```math
w(x)=\Pr(U=0\mid X=x),\qquad 0\le w(x)\le1.
\tag{2.2}
```
The scheduling randomization is private; the receiver observes only the output described below. Let the latent erasure coin be independent of the source and scheduling randomization, with erasure probability $\lambda\in(0,1)$. The output is
```math
Y=
\begin{cases}
E,&U=0,\\
F,&U=1\text{ and the packet is erased},\\
X,&U=1\text{ and the packet succeeds}.
\end{cases}
\tag{2.3}
```
The symbols $E$ and $F$ are distinct and are not numerical payload values. A transmission attempt costs $c\ge0$. Define
```math
V_f(\lambda,c)
=\inf_{w,\widehat X}
\left\{\mathbb E\|X-\widehat X(Y)\|^2+c\,\Pr(U=1)\right\}.
\tag{2.4}
```
The decoder may be any measurable function; conditional expectation minimizes its squared-error term. Randomizing the decoder cannot improve this objective.

Always transmitting has value $\lambda M_2+c$. Define its optimal improvement by
```math
\mathcal G_f(\lambda,c)=\lambda M_2+c-V_f(\lambda,c).
\tag{2.5}
```
Let $B(z,r)$ denote the Euclidean ball of center $z$ and radius $r$, and let $v_d$ be the volume of $B(0,1)$. Boundaries of balls have zero probability, so open and closed versions are interchangeable.

For the asymptotic theorem, assume additionally
```math
(1+\|x\|)^{d+2}f(x)\longrightarrow0
\qquad(\|x\|\to\infty).
\tag{2.6}
```
For fixed $\kappa\ge0$, set
```math
p=1+\frac d2,\qquad
S_\kappa(a)=\|a\|^2+\kappa,\qquad
h_\kappa(a)=f(a)S_\kappa(a)^p,
\tag{2.7}
```
and
```math
H_\kappa=\max_{a\in\mathbb R^d}h_\kappa(a),\qquad
A_\kappa=\operatorname*{argmax}_{a\in\mathbb R^d}h_\kappa(a).
\tag{2.8}
```

**Theorem 2.1 (sharp value and selection of all optimizers).**  
Under (2.1) and (2.6), $0 \lt H_\kappa<\infty$ and $A_\kappa$ is nonempty and compact. For every $0<\lambda<1$ and finite $c\ge0$, the infimum in (2.4) is attained. Every optimal kernel equals the indicator of a ball $B(z,r)$ almost everywhere, with $0 \lt r<\infty$ and $0<\Pr(X\in B(z,r))<1$.

With $c=\kappa\lambda$,
```math
\lim_{\lambda\downarrow0}
\frac{\mathcal G_f(\lambda,\kappa\lambda)}{\lambda^p}
=\frac{2v_d}{d+2}H_\kappa.
\tag{2.9}
```
For every choice of optimal balls $B(z_\lambda,r_\lambda)$, put
```math
q_\lambda=\Pr(X\in B(z_\lambda,r_\lambda)).
```
Then
```math
\operatorname{dist}(z_\lambda,A_\kappa)\longrightarrow0,
\tag{2.10}
```
```math
\frac{r_\lambda}{\sqrt\lambda}
-\sqrt{S_\kappa(z_\lambda)}\longrightarrow0,
\tag{2.11}
```
and
```math
\frac{q_\lambda}{\lambda^{d/2}}
-v_df(z_\lambda)S_\kappa(z_\lambda)^{d/2}
\longrightarrow0.
\tag{2.12}
```
All these convergences are uniform over the global optimizers at each $\lambda$. In particular, some positive finite constants $c_i,C_i$ satisfy, for every optimizer and all sufficiently small $\lambda$,
```math
c_1\sqrt\lambda\le r_\lambda\le C_1\sqrt\lambda,
\qquad
c_2\lambda^{d/2}\le q_\lambda\le C_2\lambda^{d/2}.
\tag{2.13}
```

Let $a_{E,\lambda}$ and $a_{F,\lambda}$ be its Bayes decoder values at $E$ and $F$. Uniformly over the same optimizers,
```math
a_{E,\lambda}-z_\lambda=o(\sqrt\lambda),
\tag{2.14}
```
```math
\frac{a_{F,\lambda}}{\lambda^{d/2}}
+v_df(z_\lambda)z_\lambda S_\kappa(z_\lambda)^{d/2}
\longrightarrow0
\quad\text{in }\mathbb R^d.
\tag{2.15}
```

Convergence in (2.10) is to a set. Multiple maximizers or rotational symmetry can prevent a chosen sequence of centers from converging to a single point. The radius and silence-probability constants in (2.11)–(2.12) are correspondingly stated at the current center; they specialize to fixed constants along any convergent subsequence.

## 3. Exact risk and the established ball geometry

This section proves the attainment and geometric parts of Theorem 2.1. The geometry is the established quantizer mechanism described in Section 1.2.

For a kernel $w$, write
```math
q=\int w\,dP,\qquad
m=\int xw(x)\,dP(x),\qquad
t=\int\|x\|^2w(x)\,dP(x).
\tag{3.1}
```
If $0 \lt q<1$, define
```math
\mu=\frac mq,\qquad
\nu=-\frac m{1-q},\qquad
\sigma_E^2=\frac tq-\|\mu\|^2.
\tag{3.2}
```
Independence of the latent erasure coin implies
```math
\mu=\mathbb E[X\mid Y=E],\qquad
\nu=\mathbb E[X\mid Y=F].
```
The centering assumption in (2.1) is used in the formula for $\nu$.

**Lemma 3.1 (exact objective and gain).**  
For $0 \lt q<1$, the Bayes objective of $w$ is
```math
J_{\lambda,c}(w)
=\lambda M_2+c+(1-\lambda)t
-\frac{\|m\|^2}{q}
-\lambda\frac{\|m\|^2}{1-q}-cq.
\tag{3.3}
```
Consequently its gain over always transmitting is
```math
G_{\lambda,c}(w)
=\frac{\lambda q\|\mu\|^2}{1-q}
+cq-(1-\lambda)q\sigma_E^2.
\tag{3.4}
```
At $q=0$, $J_{\lambda,c}=\lambda M_2+c$; at $q=1$, $J_{\lambda,c}=M_2$.

*Proof.* The silence distortion is $t-\|m\|^2/q$. The failure distortion is
```math
\lambda\left(M_2-t-\frac{\|m\|^2}{1-q}\right).
```
Successful transmissions reveal $X$ and contribute zero distortion. The expected cost is $c(1-q)$. Summing gives (3.3). Substituting $t=q(\sigma_E^2+\|\mu\|^2)$ and $m=q\mu$ gives (3.4). The endpoint values follow directly from the constant actions. ∎

**Lemma 3.2 (attainment and exclusion of constant actions).**  
Under (2.1) and everywhere positivity of the continuous density, an optimal kernel exists for every $0<\lambda<1$ and finite $c\ge0$. Every optimizer has $0 \lt q<1$.

*Proof.* The set
```math
\mathcal W=\{w\in L^\infty(P):0\le w\le1\text{ almost surely}\}
```
is weak-star compact. Indeed, it is a weak-star closed subset of the unit ball of $L^\infty(P)$; the inequalities are preserved by testing against nonnegative $L^1(P)$ functions. The coordinates $1,X_i,\|X\|^2$ belong to $L^1(P)$, so $w\mapsto(q,m,t)$ is weak-star continuous. Its image is therefore compact in a finite-dimensional space.

We check continuity of (3.3) on this image, including its apparent singular endpoints. For every $R>0$,
```math
\int\|x\|^2w(x)\,dP(x)
\le R^2q+
\int_{\{\|x\|>R\}}\|x\|^2\,dP(x).
\tag{3.5}
```
Thus $q\to0$ implies $t\to0$, uniformly over $\mathcal W$. Cauchy–Schwarz gives $\|m\|^2/q\le t$, so the quotient tends to zero there. When $q\to1$, apply (3.5) to $1-w$ and use $\mathbb EX=0$ to obtain
```math
\frac{\|m\|^2}{1-q}
\le\int\|x\|^2(1-w(x))\,dP(x)\longrightarrow0.
```
All other terms are continuous at the relevant endpoints. Hence the objective extends continuously to the compact moment image and attains its minimum.

Always transmitting is strictly suboptimal. Fix $a\ne0$ and take $w=\mathbf1_{B(a,r)}$. As $r\downarrow0$, continuity and positivity give $q\to0$, $\mu\to a$, and $\sigma_E^2\to0$. From (3.4),
```math
G_{\lambda,c}(w)/q\longrightarrow\lambda\|a\|^2+c>0.
```

Always remaining silent is also strictly suboptimal. The set
```math
S=\{x:(1-\lambda)\|x\|^2>c+1\}
```
has positive probability because $f$ is everywhere positive. Transmit on $S$, decode nonsuccess outputs as zero, and decode a success as $X$. This feasible pair has objective
```math
M_2-\int_S\big((1-\lambda)\|x\|^2-c\big)\,dP \lt M_2.
```
Using its Bayes decoder can only reduce the objective. This excludes both endpoint kernels. ∎

**Lemma 3.3 (every optimal kernel is a ball).**  
For every optimizer there are finite $z\in\mathbb R^d$ and $r>0$ with $w=\mathbf1_{B(z,r)}$ almost everywhere. Let $q,\mu$ be its silence probability and silence conditional mean, and set
```math
D=1-(1-\lambda)q=(1-q)+\lambda q.
\tag{3.6}
```
Then
```math
z=\frac{D\mu}{(1-\lambda)(1-q)},
\tag{3.7}
```
```math
r^2=\frac{\lambda\|z\|^2}{D^2}+\frac{c}{1-\lambda}.
\tag{3.8}
```
Equivalently,
```math
\mu=\left(1-\frac{\lambda}{D}\right)z.
\tag{3.9}
```

*Proof.* Fix an optimal kernel and its Bayes decoder values $\mu,\nu$. Keeping these decoder values fixed, the conditional costs of silence and transmission at $x$ are
```math
L_E(x)=\|x-\mu\|^2,\qquad
L_T(x)=\lambda\|x-\nu\|^2+c.
```
The optimal kernel must choose the smaller cost almost everywhere. Otherwise pointwise minimization would strictly improve the objective without changing the decoder, contradicting optimality. Their difference is
```math
(1-\lambda)\|x\|^2-2(\mu-\lambda\nu)\cdot x
+\|\mu\|^2-\lambda\|\nu\|^2-c.
```
Completing the square gives a ball of center
```math
z=\frac{\mu-\lambda\nu}{1-\lambda}.
```
Since $\nu=-q\mu/(1-q)$, this is (3.7). Its squared radius is
```math
\frac{\lambda\|\mu-\nu\|^2}{(1-\lambda)^2}
+\frac{c}{1-\lambda},
```
which equals (3.8). The quadratic boundary has probability zero, and the radius is positive because Lemma 3.2 gives $q>0$. The centroids and radius are finite by the finite second moment. Finally,
```math
D-(1-\lambda)(1-q)=\lambda,
```
which proves (3.9). ∎

**Remark 3.4.** The preceding argument proves the statement for every global optimizer. It does not merely construct one deterministic optimum. Randomization on the boundary is irrelevant because that boundary has zero probability. At $c=0$, an optimal center cannot be zero, since (3.8) would then force $r=0$.

**Corollary 3.5 (finite-dimensional representation; known structure).**  
Under the hypotheses of Lemma 3.2,
```math
V_f(\lambda,c)
=\min_{a,b\in\mathbb R^d}
\mathbb E\min\{\|X-a\|^2,\lambda\|X-b\|^2+c\}.
\tag{3.10}
```
The minimum is attained at the nonsuccess Bayes centroids of an optimal kernel.

*Proof.* For any fixed $a,b$, choose the smaller of the two pointwise costs, decode $E$ as $a$, decode $F$ as $b$, and decode success as $X$. This is feasible and has the displayed expected cost, so $V_f$ is at most its infimum. Conversely, Lemma 3.3 shows that an optimal kernel and its Bayes centroids achieve the pointwise minimum, so its value equals one member of the displayed family. ∎

Equation (3.10) is included as a dependency and practical representation. The directly overlapping expression in [4, equation (59)] and the quantizer reductions in [1,3] preclude treating it as a new result.

## 4. Local expansions and a positive comparison bound

We first establish two estimates that do not presume compactness of optimal centers.

**Lemma 4.1 (bounded-density moment inequality).**  
Let $g$ be a nonnegative Lebesgue density of total mass $q>0$, with $g\le M<\infty$ and finite second moment. For every $a\in\mathbb R^d$,
```math
\int\|x-a\|^2g(x)\,dx
\ge\frac d{d+2}q\left(\frac q{Mv_d}\right)^{2/d}.
\tag{4.1}
```

*Proof.* Set $R=(q/(Mv_d))^{1/d}$. The function
```math
g-M\mathbf1_{B(a,R)}
```
has integral zero. Its product with $\|x-a\|^2-R^2$ is pointwise nonnegative: inside the ball both factors are nonpositive, while outside both are nonnegative. After integration, equality of masses cancels the constant term. Therefore the second moment of $g$ about $a$ is at least that of $M\mathbf1_{B(a,R)}$, namely
```math
\frac{Md v_d}{d+2}R^{d+2}
=\frac d{d+2}qR^2.
```
This proves (4.1). ∎

Under (2.6), continuity gives $M:=\sup_x f(x)<\infty$. Define
```math
b_{d,M}=\frac d{d+2}(Mv_d)^{-2/d}>0.
\tag{4.2}
```
For any optimizer at $c=\kappa\lambda$, apply Lemma 4.1 to $g=wf$ and its centroid $\mu$. The silence distortion is one nonnegative component of the full objective, so
```math
b_{d,M}q^{1+2/d}
\le q\sigma_E^2
\le V_f(\lambda,\kappa\lambda)
\le\lambda(M_2+\kappa).
\tag{4.3}
```
Consequently,
```math
q\le
\left(\frac{\lambda(M_2+\kappa)}{b_{d,M}}\right)^{d/(d+2)}
\longrightarrow0
\tag{4.4}
```
uniformly over all optimizers. In particular, $D\to1$ uniformly. This argument does not assume a bounded center or small radius. It will also apply to the bounded-density counterexample of Section 8, without (2.6).

**Lemma 4.2 (uniform local ball moments).**  
Let $K\subset\mathbb R^d$ be compact and $f$ continuous and positive on a neighborhood of $K$. As the maximum permitted positive radius tends to zero, uniformly for centers $z\in K$,
```math
P(B(z,r))=v_df(z)r^d(1+o(1)),
\tag{4.5}
```
```math
\mathbb E[X\mid X\in B(z,r)]=z+o(r),
\tag{4.6}
```
```math
\operatorname{tr}\operatorname{Cov}(X\mid X\in B(z,r))
=\frac d{d+2}r^2+o(r^2).
\tag{4.7}
```
No positive lower bound on $r$ is required.

*Proof.* On a compact neighborhood of $K$, the density has a positive minimum and is uniformly continuous. Let $\omega(\rho)$ be a modulus of continuity on that neighborhood. For $\|y\|\le1$,
```math
f(z+ry)=f(z)(1+\varepsilon_{z,r}(y)),
\qquad
\sup_{z\in K,\ 0 \lt r\le\rho,\ \|y\|\le1}
|\varepsilon_{z,r}(y)|\longrightarrow0.
```
Changing variables $x=z+ry$ gives (4.5). The conditional law of $(X-z)/r$ on the unit ball converges uniformly in density to the uniform law on that ball. Its mean tends to zero, while its radial second moment tends to $d/(d+2)$. Subtracting the squared conditional mean yields (4.7), and the mean itself yields (4.6). The displayed supremum proves the asserted uniformity for arbitrarily small positive radii. ∎

**Lemma 4.3 (fixed-center comparison).**  
Fix $a\in\mathbb R^d$ with $S_\kappa(a)>0$. For the feasible silence ball
```math
B\big(a,\sqrt{\lambda S_\kappa(a)}\big),
\tag{4.8}
```
equipped with its Bayes decoder,
```math
\frac{G_{\lambda,\kappa\lambda}
(\mathbf1_{B(a,\sqrt{\lambda S_\kappa(a)})})}{\lambda^p}
\longrightarrow
\frac{2v_d}{d+2}h_\kappa(a).
\tag{4.9}
```

*Proof.* Lemma 4.2 gives
```math
\frac q{\lambda^{d/2}}\longrightarrow
v_df(a)S_\kappa(a)^{d/2},
\quad
\mu\longrightarrow a,
\quad
\frac{\sigma_E^2}{\lambda}\longrightarrow
\frac d{d+2}S_\kappa(a).
```
By (3.4),
```math
\frac{G_{\lambda,\kappa\lambda}}{\lambda q}
=\frac{\|\mu\|^2}{1-q}
+\kappa-(1-\lambda)\frac{\sigma_E^2}{\lambda}
\longrightarrow
\frac2{d+2}S_\kappa(a).
```
Multiplication proves (4.9). ∎

In particular, choosing any fixed $a\ne0$ supplies constants $\eta>0$ and $\lambda_0>0$ such that
```math
\mathcal G_f(\lambda,\kappa\lambda)\ge
\eta\lambda^p
\qquad(0<\lambda<\lambda_0).
\tag{4.10}
```
This positive comparison bound does not assume that the constructed ball satisfies the exact optimality identities (3.7)–(3.8).

## 5. Global compactness and proof of the sharp limit

The local calculation above is insufficient by itself: an optimal ball may have a center depending on $\lambda$. The next lemma closes this noncompact optimization issue.

**Lemma 5.1 (uniform exclusion of escaping optimal centers).**  
Under (2.1) and (2.6), there are $R_0<\infty$ and $\lambda_0>0$ such that every optimal ball at every $0<\lambda<\lambda_0$ has $\|z\|\le R_0$.

*Proof.* Suppose otherwise. Choose $\lambda_n\downarrow0$ and optimal balls $B(z_n,r_n)$ with $a_n:=\|z_n\|\to\infty$. From (4.4), $q_n\to0$ and $D_n\to1$. The exact radius relation is
```math
r_n^2=\lambda_n
\left(\frac{a_n^2}{D_n^2}+\frac{\kappa}{1-\lambda_n}\right).
\tag{5.1}
```
For sufficiently large $n$, $D_n\ge1/2$, $1-\lambda_n\ge1/2$, and $a_n^2\ge\kappa$. Hence
```math
r_n\le\sqrt6\,\sqrt{\lambda_n}\,a_n,
\qquad
r_n\le a_n/2.
\tag{5.2}
```
Introduce the tail envelope
```math
T(R)=\sup_{\|x\|\ge R}(1+\|x\|)^{d+2}f(x).
\tag{5.3}
```
Assumption (2.6) gives $T(R)\to0$. Every point of $B(z_n,r_n)$ has norm at least $a_n/2$, so
```math
\begin{aligned}
q_n
&\le v_dr_n^d\frac{T(a_n/2)}{(1+a_n/2)^{d+2}}\\
&\le C\lambda_n^{d/2}\frac{T(a_n/2)}{a_n^2}.
\end{aligned}
\tag{5.4}
```
Here and below $C$ denotes a finite constant independent of $n$.

The centroid of a distribution supported on a ball lies in its closure, giving $\|\mu_n\|\le3a_n/2$. Discard the nonpositive variance term in (3.4). Since $q_n\le1/2$ eventually,
```math
G_n
\le\lambda_nq_n
\left(\kappa+\frac{\|\mu_n\|^2}{1-q_n}\right)
\le C'\lambda_nq_na_n^2.
\tag{5.5}
```
Combining (5.4)–(5.5),
```math
\frac{G_n}{\lambda_n^p}
\le C''T(a_n/2)\longrightarrow0.
```
This contradicts the positive lower bound (4.10) for the global optimum. Notice that $r_n$ was not assumed to tend to zero: its small ratio to the escaping center was sufficient. ∎

*Proof of Theorem 2.1.* Attainment and the ball representation were proved in Lemmas 3.2–3.3. The function $h_\kappa$ is continuous, and (2.6) implies $h_\kappa(a)\to0$ as $\|a\|\to\infty$. It is positive at any nonzero $a$. Thus it has a finite positive maximum, attained on a nonempty compact set $A_\kappa$. Moreover, $S_\kappa$ is positive on that set.

By Lemma 5.1 all optimal centers lie in one compact set for small $\lambda$. Equations (3.8) and (4.4) now give, uniformly over optimizers,
```math
\frac{r^2}{\lambda}
=\frac{\|z\|^2}{D^2}+\frac{\kappa}{1-\lambda}
=S_\kappa(z)+o(1).
\tag{5.6}
```
In particular $r=O(\sqrt\lambda)$, so Lemma 4.2 applies uniformly. Uniform continuity of powers on bounded nonnegative intervals gives
```math
\frac q{\lambda^{d/2}}
=v_df(z)S_\kappa(z)^{d/2}+o(1).
\tag{5.7}
```
This remains valid even before a positive lower bound on $S_\kappa(z)$ has been proved. The same expansions give
```math
\frac{\|\mu\|^2}{1-q}=\|z\|^2+o(1),
\qquad
\frac{\sigma_E^2}{\lambda}
=\frac d{d+2}S_\kappa(z)+o(1).
\tag{5.8}
```
Substituting (5.7)–(5.8) into (3.4), we obtain the uniform expansion at every global optimizer:
```math
\frac{G_{\lambda,\kappa\lambda}(w)}{\lambda^p}
=\frac{2v_d}{d+2}h_\kappa(z)+o(1).
\tag{5.9}
```
It yields an upper limit at most $2v_dH_\kappa/(d+2)$. Conversely, fix any $a\in A_\kappa$ and use Lemma 4.3. Its feasible ball gives the matching lower limit. This proves (2.9).

Equation (5.9) also shows, uniformly over optimizers, that
```math
h_\kappa(z_\lambda)\longrightarrow H_\kappa.
\tag{5.10}
```
If (2.10) failed, compactness would give a subsequence converging to a point at positive distance from $A_\kappa$ but attaining value $H_\kappa$, a contradiction. Thus (2.10) holds. Taking square roots in (5.6) proves (2.11), and (5.7) proves (2.12).

Since $A_\kappa$ is compact, $S_\kappa>0$ on $A_\kappa$, and $f>0$ everywhere, the values of $S_\kappa(z_\lambda)$ and $f(z_\lambda)$ are bounded above and bounded away from zero for all optimal centers at sufficiently small $\lambda$. Equations (2.11)–(2.12) therefore imply (2.13). In particular, when $\kappa=0$, all optimal centers are eventually bounded away from zero.

For the decoder statements, the exact identity (3.9) and boundedness of $z_\lambda$ imply
```math
a_{E,\lambda}-z_\lambda
=-\frac{\lambda}{D_\lambda}z_\lambda
=O(\lambda)=o(\sqrt\lambda).
\tag{5.11}
```
Furthermore,
```math
a_{F,\lambda}
=-\frac{q_\lambda a_{E,\lambda}}{1-q_\lambda}.
```
Use $q_\lambda\to0$, (2.12), and $a_{E,\lambda}-z_\lambda\to0$ to obtain (2.15). Every estimate used was uniform over the optimizer set. Equivalently, a failure of uniformity would produce a sequence of optimizers contradicting one of the preceding arguments. ∎

## 6. An asymptotically optimal design from one fixed maximizer

The main theorem describes unknown exact optimizers. Its lower-bound construction also gives a policy that does not require solving the exact finite-$\lambda$ fixed-point equations.

**Corollary 6.1 (fixed-maximizer design).**  
Under Theorem 2.1, fix any $a\in A_\kappa$. Set
```math
r_\lambda^{(a)}=\sqrt\lambda\,\sqrt{\|a\|^2+\kappa},
\qquad
w_\lambda^{(a)}=\mathbf1_{B(a,r_\lambda^{(a)})}.
\tag{6.1}
```
Let
```math
q_\lambda^{(a)}=\int_{B(a,r_\lambda^{(a)})}f(x)\,dx,
\qquad
m_\lambda^{(a)}=\int_{B(a,r_\lambda^{(a)})}xf(x)\,dx.
```
Decode $E$ as $m_\lambda^{(a)}/q_\lambda^{(a)}$, decode $F$ as $-m_\lambda^{(a)}/(1-q_\lambda^{(a)})$, and decode success as its payload. Then
```math
J_{\lambda,\kappa\lambda}(w_\lambda^{(a)})
=V_f(\lambda,\kappa\lambda)+o(\lambda^p).
\tag{6.2}
```

*Proof.* The chosen ball has positive finite radius because $S_\kappa(a)>0$, and its probability lies strictly between zero and one. The displayed decoder is its Bayes decoder by (3.2). Lemma 4.3 gives its gain as
```math
\frac{2v_d}{d+2}H_\kappa\lambda^p+o(\lambda^p).
```
Subtract this expression from the common always-transmit baseline and compare with (2.9). The resulting difference is nonnegative by the definition of $V_f$ and is $o(\lambda^p)$. ∎

Thus the design requires optimizing a fixed weighted-density function once and computing two integrals over a small ball. It does not require selecting a limiting direction uniquely when the maximizing set is a sphere. For a Gaussian source below the transition, any fixed direction with the prescribed center radius has the same asymptotic performance.

## 7. Gaussian centers and the exact cost of the even restriction

Let $X\sim N(0,I_d)$ and write
```math
K_d=\frac{2v_d}{d+2}(2\pi)^{-d/2},
\qquad
p=\frac{d+2}{2},
\qquad
s_*=(d+2-\kappa)_+.
\tag{7.1}
```

**Theorem 7.1 (Gaussian limiting center transition).**  
Define
```math
H_d(\kappa)=
\begin{cases}
(d+2)^p\exp\!\left[-\dfrac{d+2-\kappa}{2}\right],
&0\le\kappa \lt d+2,\\[4pt]
\kappa^p,&\kappa\ge d+2.
\end{cases}
\tag{7.2}
```
Then
```math
\mathcal G_{\mathrm G}(\lambda,\kappa\lambda)
=K_dH_d(\kappa)\lambda^p+o(\lambda^p).
\tag{7.3}
```
The maximizing set in Theorem 2.1 is
```math
A_\kappa=
\begin{cases}
\{a:\|a\|^2=d+2-\kappa\},&0\le\kappa \lt d+2,\\
\{0\},&\kappa\ge d+2.
\end{cases}
\tag{7.4}
```
For every global optimizer,
```math
\|z_\lambda\|\longrightarrow\sqrt{s_*},
\qquad
\frac{r_\lambda}{\sqrt\lambda}
\longrightarrow\sqrt{s_*+\kappa}
=\sqrt{\max\{d+2,\kappa\}},
\tag{7.5}
```
and
```math
\frac{q_\lambda}{\lambda^{d/2}}
\longrightarrow
v_d(2\pi)^{-d/2}e^{-s_*/2}(s_*+\kappa)^{d/2}.
\tag{7.6}
```

*Proof.* The Gaussian density satisfies all hypotheses of Theorem 2.1. With $s=\|a\|^2$,
```math
h_\kappa(a)=(2\pi)^{-d/2}e^{-s/2}(s+\kappa)^p.
```
For $s+\kappa>0$, the logarithmic derivative of its nonconstant factor with respect to $s$ is
```math
-\frac12+\frac p{s+\kappa}
=\frac{d+2-\kappa-s}{2(s+\kappa)}.
\tag{7.7}
```
It changes sign at $s=d+2-\kappa$ when this value is positive, and is negative for all $s>0$ when $\kappa\ge d+2$. At $\kappa=d+2$, the endpoint $s=0$ remains the unique maximizing radius. At $\kappa=0$, the value at $s=0$ is zero and does not maximize. This proves (7.2)–(7.4). The radius and mass statements follow by substituting the selected radius into (2.11)–(2.12). ∎

The transition in (7.4) concerns limiting location. Below it, rotational symmetry permits any limiting direction. At and above it, centers approach zero, but Theorem 7.1 makes no assertion that the exact center is zero for every sufficiently small positive $\lambda$.

We next quantify a symmetry restriction without assuming it is globally harmless. Say that a kernel is even if $w(x)=w(-x)$ almost everywhere.

**Theorem 7.2 (exact even-kernel optimum and its asymptotic loss).**  
For any centrally symmetric source with an everywhere positive density and finite second moment,
```math
V_{\mathrm{even}}(\lambda,c)
=\lambda M_2+c-
\mathbb E\big[(c-(1-\lambda)\|X\|^2)_+\big].
\tag{7.8}
```
An optimal even kernel is
```math
w_{\mathrm{even}}(x)
=\mathbf1_{\{\|x\|^2 \lt c/(1-\lambda)\}}.
\tag{7.9}
```
It is unique up to a null set; at $c=0$ it is the always-transmit kernel.

For the standard Gaussian and fixed $\kappa\ge0$,
```math
\lim_{\lambda\downarrow0}
\frac{\lambda d+\kappa\lambda-
V_{\mathrm{even}}(\lambda,\kappa\lambda)}
{\lambda^p}
=K_d\kappa^p,
\tag{7.10}
```
and
```math
\lim_{\lambda\downarrow0}
\frac{V_{\mathrm{even}}(\lambda,\kappa\lambda)
-V_{\mathrm G}(\lambda,\kappa\lambda)}
{\lambda^p}
=K_d\big[H_d(\kappa)-\kappa^p\big].
\tag{7.11}
```
The right side is strictly positive for $0\le\kappa \lt d+2$ and zero for $\kappa\ge d+2$.

*Proof.* Central symmetry and evenness imply
```math
m=\int xw(x)\,dP(x)=0.
```
Both nonsuccess Bayes decoder values are therefore zero whenever their symbols have positive probability. The objective becomes the linear functional
```math
J_{\lambda,c}(w)
=\lambda M_2+c+
\int w(x)\big((1-\lambda)\|x\|^2-c\big)f(x)\,dx.
\tag{7.12}
```
Its pointwise minimizing kernel is exactly (7.9), which is itself even. The zero set of the coefficient is a sphere of probability zero, including the radius-zero case. This proves (7.8), (7.9), and uniqueness.

For $\kappa>0$, change variables $x=\sqrt\lambda\,y$ in the gain term of (7.8):
```math
\begin{aligned}
&\frac{\lambda d+\kappa\lambda-
V_{\mathrm{even}}(\lambda,\kappa\lambda)}{\lambda^p}\\
&\quad =
\int_{\mathbb R^d}
\big(\kappa-(1-\lambda)\|y\|^2\big)_+
(2\pi)^{-d/2}e^{-\lambda\|y\|^2/2}\,dy.
\end{aligned}
\tag{7.13}
```
For small $\lambda$, the integrands are supported on one fixed bounded ball and uniformly bounded there. Dominated convergence gives
```math
(2\pi)^{-d/2}
\int_{\|y\|<\sqrt\kappa}(\kappa-\|y\|^2)\,dy
=K_d\kappa^p.
```
For $\kappa=0$, the gain is exactly zero for every $\lambda$. This proves (7.10), and subtracting it from (7.3) gives (7.11).

For $0<\kappa \lt d+2$, put $u=\kappa/(d+2)\in(0,1)$. Then
```math
\log\frac{H_d(\kappa)}{\kappa^p}
=p(u-1-\log u)>0.
```
At $\kappa=0$ positivity is immediate. For $\kappa\ge d+2$, (7.2) gives equality of the leading coefficients. ∎

When the coefficient in (7.11) is positive, it is an asymptotic equivalence for the nonzero restriction loss. When it is zero, the theorem states precisely
```math
V_{\mathrm{even}}-V_{\mathrm G}=o(\lambda^p).
```
It does not identify a sharper nonzero term or a finite-$\lambda$ phase boundary. Formula (7.8), in contrast, is exact for the even class at every finite parameter pair.

## 8. A smooth tail obstruction and escape of all optimal centers

The weighted tail assumption was used in Lemma 5.1. The next construction shows why bounded density and finite second moment alone do not ensure the main conclusion.

**Theorem 8.1 (divergent normalized gain without tail control).**  
There exists an everywhere positive, bounded, even $C^\infty$ probability density $f$ on $\mathbb R$, with mean zero and finite second moment, such that
```math
\frac{\lambda\mathbb EX^2-V_f(\lambda,0)}
{\lambda^{3/2}}\longrightarrow+\infty
\qquad(\lambda\downarrow0).
\tag{8.1}
```
For this density, every optimal silent-ball center satisfies
```math
|z_\lambda|\longrightarrow\infty.
\tag{8.2}
```
More precisely, for each finite $R$, all optimal centers lie outside $[-R,R]$ once $\lambda$ is sufficiently small.

*Proof.* Choose an even smooth bump $\psi:\mathbb R\to[0,1]$, supported on $[-1,1]$, with $\psi(0)=1$. One explicit choice is
```math
\psi(t)=
\begin{cases}
\exp\!\big(1-1/(1-t^2)\big),&|t|<1,\\
0,&|t|\ge1.
\end{cases}
```
Write
```math
I_0=\int\psi(t)\,dt>0,\qquad
I_2=\int t^2\psi(t)\,dt<\infty,\qquad
a_n=2^{n+2}\quad(n\ge1).
```
Let $\phi$ be the standard Gaussian density and define
```math
\widetilde f(x)=\phi(x)+
\sum_{n\ge1}a_n^{-2}
\left[
\psi\big(a_n(x-a_n)\big)
+\psi\big(a_n(x+a_n)\big)
\right],
\tag{8.3}
```
```math
Z_0=1+2I_0\sum_{n\ge1}a_n^{-3},
\qquad
f(x)=\widetilde f(x)/Z_0.
\tag{8.4}
```
The bump supports are pairwise disjoint and the sum is locally finite. Thus $f$ is smooth, bounded, and even, and its Gaussian component makes it everywhere positive. The integral in (8.4) is the exact normalization. The second moment of the pair of unnormalized bumps at $\pm a_n$ is
```math
2I_0a_n^{-1}+2I_2a_n^{-5}.
\tag{8.5}
```
This is summable, proving finite second moment; evenness gives mean zero. At the spike centers,
```math
f(a_n)\ge\frac{a_n^{-2}}{Z_0},
\qquad
a_n^3f(a_n)\ge\frac{a_n}{Z_0}\longrightarrow\infty.
\tag{8.6}
```

For any fixed $a>0$, the fixed-center calculation in Lemma 4.3, whose proof did not use a tail assumption, applies with $d=1$ and $\kappa=0$:
```math
\frac{G_{\lambda,0}
(\mathbf1_{B(a,a\sqrt\lambda)})}{\lambda^{3/2}}
\longrightarrow\frac43f(a)a^3.
\tag{8.7}
```
The global gain is at least this feasible gain. Applying (8.7) separately to each fixed $a=a_n$ gives
```math
\liminf_{\lambda\downarrow0}
\frac{\lambda\mathbb EX^2-V_f(\lambda,0)}
{\lambda^{3/2}}
\ge\frac43f(a_n)a_n^3
\ge\frac{4a_n}{3Z_0}
\quad\text{for every }n.
\tag{8.8}
```
Let $n\to\infty$ to prove (8.1). This order of quantifiers is essential: for any desired finite lower bound, one first fixes a spike and then takes all sufficiently small $\lambda$. No expansion uniform across moving spikes is needed.

It remains to prove (8.2). Lemmas 3.2–3.3 apply to this density, so global optimizers exist and are balls. Since $f$ is bounded, (4.4) gives $q_\lambda\to0$ even though (2.6) fails. Suppose there were a sequence $\lambda_n\downarrow0$ with optimal centers in a fixed bounded interval. Then $D_n\to1$ and, because $c=0$,
```math
r_n^2=\lambda_n z_n^2/D_n^2.
```
The radii tend to zero. The compact-center expansions of Lemma 4.2 and the gain identity imply, along this sequence,
```math
\frac{G_{\lambda_n,0}}{\lambda_n^{3/2}}
=\frac43 f(z_n)|z_n|^3+o(1).
\tag{8.9}
```
The right side is bounded on that compact interval, contradicting (8.1). This proves the uniform escape assertion. ∎

**Remark 8.2 (an explicit diagnostic sequence).** For the same construction, take $\lambda_n=a_n^{-8}$ and radius $r_n=a_n^{-3}$. This radius is $a_n^{-2}$ times the spike width. Uniformly on the silent interval, $f\sim a_n^{-2}/Z_0$, so
```math
q_n\sim\frac{2}{Z_0}a_n^{-5},
\quad
\mu_n/a_n\to1,
\quad
\sigma_{E,n}^2\sim\frac13a_n^{-6}.
```
The gain identity then gives
```math
G_{\lambda_n,0}\sim\frac4{3Z_0}a_n^{-11},
\qquad
G_{\lambda_n,0}/\lambda_n^{3/2}
\sim\frac4{3Z_0}a_n\to\infty.
```
The full-limit argument (8.8) is stronger than this particular sequence.

Theorem 8.1 does not characterize the weakest sufficient tail condition. Some densities violating (2.6) may still have a finite limit or compact optimal centers. What is ruled out is a theorem with the same finite-constant conclusion based only on positivity, smoothness, boundedness, centering, and a finite second moment.

## 9. A horizon-one counterexample in the inspected remote-state model

We now give a separate finite-parameter example. Its purpose is to test the global symmetric-scheduling assertion in the specifically identified version [5], rather than derive another asymptotic theorem.

### 9.1. Model alignment

The inspected source uses a Gauss–Markov state, noisy local observations, a one-step forward transmission delay, and unreliable feedback. Its forward output distinguishes an attempted-but-failed transmission from no attempt; its decoder information also includes the preceding scheduling decision [5, Sections II-B–II-C, especially Remark 3 and equation (10)]. The admissible policy class consists of measurable kernels. Symmetry is a claimed optimal structure, rather than an admissibility assumption.

For the example, independent latent channel-success coins generate the operational outputs. A recorded indicator may be set to zero when its channel is unused, as a bookkeeping convention. Such a masked indicator need not remain independent of the source or policy. All independence statements below concern the latent coins, avoiding any reliance on this notational distinction.

**Proposition 9.1 (positive-noise, positive-cost separation from every even kernel).**  
In the horizon-one instance specified below, every origin-symmetric randomized scheduling kernel has full objective at least $9/2$, whereas an admissible asymmetric sign schedule has full objective
```math
\frac{39}{8}-\frac{3}{2\pi}<\frac92.
\tag{9.1}
```
Thus the global symmetric-scheduling conclusion of Theorem 1 in arXiv:2501.13192v2 does not hold for its stated information pattern and admissible policy class.

*Proof.* Set the horizon to $N=1$ and take independent variables
```math
x_0\sim N(0,2),\qquad v_0\sim N(0,2),\qquad w_0\sim N(0,1).
```
Let
```math
y_0=x_0+v_0,\qquad x_1=x_0+w_0,
\tag{9.2}
```
so $A_0=C_0=1$. The forward erasure probability and backward erasure probability are both $1/2$. All latent channel coins are independent of each other, of the Gaussian variables, and of private scheduling randomization. The time-zero attempt price is $\alpha_0=1/4$.

Set $u_1=0$. The terminal attempt cannot affect any estimate in a horizon-one objective because of the forward delay. One may take $\alpha_1=1/4$ and all otherwise unused noise covariances strictly positive, for example $V_1=2$ and $W_1=1$, to complete the source's index ranges. The active measurement and process noises in (9.2) are already strictly positive.

Gaussian regression gives
```math
Z=\mathbb E[x_0\mid y_0]=y_0/2\sim N(0,1),
\qquad
x_0=Z+\xi,
\tag{9.3}
```
where $\xi\sim N(0,1)$ is independent of $Z$. Therefore
```math
x_1=Z+\eta,\qquad
\eta=\xi+w_0\sim N(0,2),\qquad \eta\perp Z.
\tag{9.4}
```
The encoder knows $Z$ because it observes $y_0$. The payload $Z$ is exactly the source model's local conditional-mean payload at time zero. The encoder's action is a measurable function or kernel of its allowed information.

The time-zero decoder has no informative received observation, so its Bayes loss is $2$. At time one, $\eta$ is independent of the decision and output and contributes another unavoidable loss $2$. Consequently the full objective equals
```math
4+R(s),
\tag{9.5}
```
where $s(z)=\Pr(u_0=1\mid Z=z)$ and $R$ is the one-shot objective for the standard normal $Z$ with $\lambda=1/2$ and $c=1/4$. The backward result cannot influence the already chosen unique useful action $u_0$, so an interior feedback erasure probability is compatible with the calculation.

First consider any even randomized kernel:
```math
0\le s(z)\le1,\qquad s(z)=s(-z).
\tag{9.6}
```
Both nonsuccess events have even conditional densities, so their Bayes means are zero whenever they occur. Successful reception reveals $Z$. It follows that
```math
R(s)
=\mathbb E\!\left[Z^2\left(1-\frac12s(Z)\right)\right]
+\frac14\mathbb E[s(Z)]
\ge\frac12.
\tag{9.7}
```
This lower bound covers every even randomized kernel, including both constant actions; it is not a numerical threshold comparison. Equations (9.5)–(9.7) give full objective at least $9/2$.

Now choose the deterministic sign schedule
```math
u_0=\mathbf1_{\{Z\ge0\}}.
\tag{9.8}
```
Write $a=\sqrt{2/\pi}$. Its receiver events and Bayes values for $Z$ are:

| Receiver event | Probability | Conditional mean of $Z$ | Conditional variance of $Z$ |
| --- | ---: | ---: | ---: |
| No attempt, $E$ | $1/2$ | $-a$ | $1-2/\pi$ |
| Attempt erased, $F$ | $1/4$ | $a$ | $1-2/\pi$ |
| Successful payload | $1/4$ | received $Z$ | $0$ |

The half-normal moments follow from
```math
\mathbb E[Z\mathbf1_{\{Z\ge0\}}]=\frac1{\sqrt{2\pi}},
\qquad
\mathbb E[Z^2\mid Z\ge0]=1.
```
The resulting reduced risk including the attempt cost is
```math
R_{\mathrm{sign}}
=\frac34\left(1-\frac2\pi\right)+\frac14\cdot\frac12
=\frac78-\frac{3}{2\pi}.
\tag{9.9}
```
Since $\pi<4$,
```math
\frac12-R_{\mathrm{sign}}
=\frac{3}{2\pi}-\frac38>0.
\tag{9.10}
```
Adding the common constant $4$ proves (9.1).

At the initial stage of this instance, the only nonconstant innovation is proportional to $Z$, with deterministic covariance state and no informative previous feedback. The symmetry stipulated in the source's displayed global threshold conclusion therefore places its schedule in the even class (9.6), which is strictly dominated by (9.8). ∎

### 9.2. Meaning and limits of the counterexample

The example uses positive measurement noise, positive process noise, positive price, and an interior forward erasure probability. It does not exploit a zero-noise limit or merge the two nonsuccess symbols. It also retains the original full-objective normalization: the sign schedule's value is approximately $4.397535$, not the reduced value approximately $0.397535$.

The argument establishes a separation from every even kernel. It does not identify the unrestricted finite-parameter optimum, and it does not assert that the sign schedule is optimal. The same mechanism was already visible in earlier collision-channel work [1–3]; the contribution of this proposition is its exact nondegenerate embedding and version-specific comparison.

We do not extend the proposition to the unread final journal text, to a reliable forward channel, or to a model in which the receiver cannot distinguish the two actions after a nonsuccess. A symmetric-threshold analysis that explicitly imposes the symmetric class, such as the scope described in [8], is a different claim and is not contradicted.

## 10. Reproducibility and interpretation

The analytic statements above have complete proofs in this manuscript. The accompanying repository also contains a deterministic numerical diagnostic for the Gaussian fixed-maximizer design of Corollary 6.1:

- [Gaussian diagnostic implementation](reproducibility/gaussian_diagnostics.js).
- [Recorded diagnostic results](reproducibility/results.json).

The diagnostic evaluates feasible ball policies for dimensions $d\in\{1,2,3,5\}$, ratios $\kappa\in\{0,1,d+2,d+3\}$, and erasure probabilities $\lambda\in\{10^{-2},10^{-3},10^{-4}\}$, giving 48 parameter combinations. It compares their Bayes gains with the predicted leading coefficient. The recorded comparison of 32- and 64-point quadratures has a largest discrepancy of approximately $1.3\times10^{-14}$; at $\lambda=10^{-4}$ the largest reported relative discrepancy from the leading asymptotic term is approximately $5.1\times10^{-3}$.

These calculations evaluate specified feasible policies. They neither search the unrestricted policy space nor certify a numerical global optimizer. Their role is to expose normalization, implementation, or leading-constant errors independently of the written derivation. The global optimality and compactness conclusions rest on Sections 3–5.

The exact sign-policy comparison in Section 9 needs only Gaussian moments and $\pi<4$; no floating-point computation is required for its strict inequality. The smooth tail obstruction is an analytic construction, not an empirical simulation.

## 11. Assumptions, literature limits, and further questions

The proof separates the roles of its assumptions. Finite second moment supplies continuity at the endpoint kernels and finite Bayes distortion. Everywhere positivity rules out a globally optimal constant-silence action for finite cost and supports uniform local conditional moments. Boundedness of the density gives the small-mass estimate (4.4). The weighted tail decay (2.6) supplies the global escape exclusion in Lemma 5.1. Local expansions use continuity alone on compact neighborhoods, with no differentiability requirement.

The tail example shows that smoothness and finite second moment cannot replace all tail control. It leaves open weaker sufficient hypotheses, including situations in which the weighted density has a finite supremum that is approached only at infinity. A complete classification of such cases would require a separate compactness analysis.

The Gaussian boundary $\kappa=d+2$ is an asymptotic statement for fixed $\kappa$. A transition window in which $\kappa$ changes with $\lambda$, the next nonzero even-restriction loss at or above that boundary, and an exact finite-$\lambda$ phase diagram are not established here. The results also do not supply uniform estimates as dimension grows.

The information pattern matters. If silence and failed transmission are merged and no separate action indicator is observed, their conditional laws cannot be decoded using two independent centroids. The pointwise comparison and the counterexample in this manuscript concern the distinguishable-symbol model only.

Our nearest-work comparison uses the full relevant sections of [1], [3], [4], and the exact arXiv version [5]. Reference [2] is included as a bibliographic predecessor rather than as a fully inspected conference text. The available abstract of [6] describes asymmetry in a different noisy/perfect-channel choice problem. The publisher abstract of [8] explicitly imposes symmetric thresholds. For the recent work [7], the available indexed abstract and author bibliography describe belief-state structure, but its full text was not accessible in the source check. We therefore do not claim a theorem-by-theorem exclusion of overlap with that unread text. None of our mathematical proofs depends on an uninspected theorem.

The manuscript is a written research result with a reproducibility package. It makes no claim of external peer review, journal acceptance, or completed proof-assistant verification.

## References

[1] Marcos M. Vasconcelos and Nuno C. Martins. **Optimal Estimation Over the Collision Channel.** *IEEE Transactions on Automatic Control*, 62(1):321–336, 2017. DOI: [10.1109/TAC.2016.2558644](https://doi.org/10.1109/TAC.2016.2558644). [Author-hosted published text](https://mullervasconcelos.github.io/Resources/Collision_Channel_MMSE.pdf).

[2] Marcos M. Vasconcelos and Nuno C. Martins. **Optimal threshold strategies for remote estimation over the collision channel with communication costs.** *54th IEEE Conference on Decision and Control*, pp. 1112–1119, 2015. DOI recorded in bibliographic sources: [10.1109/CDC.2015.7402360](https://doi.org/10.1109/CDC.2015.7402360). [Author publication list](https://mullervasconcelos.github.io/Publications.html). The conference full text was not used for a detailed theorem comparison.

[3] Marcos Müller Vasconcelos. **Optimality of Event-Based Policies for Decentralized Estimation over Shared Networks.** Ph.D. dissertation, University of Maryland, 2016. [Persistent institutional record](https://hdl.handle.net/1903/19045). [Official full text](https://api.drum.lib.umd.edu/server/api/core/bitstreams/99fcf091-93d3-474a-aea8-aee88f0dc18c/content). The vector extension appears in Section 3.5.

[4] Xu Zhang and Marcos M. Vasconcelos. **Robust one-shot estimation over shared networks in the presence of denial-of-service attacks.** arXiv:2302.14689v1, 28 February 2023. [Version-specific text](https://arxiv.org/html/2302.14689v1). DOI: [10.48550/arXiv.2302.14689](https://doi.org/10.48550/arXiv.2302.14689). In particular, Section III-C, Proposition 3, and equation (59).

[5] Touraj Soleymani, Mohamad Assaad, and John S. Baras. **Remote State Estimation over Unreliable Channels with Unreliable Feedback: Strategies and Limits.** arXiv:2501.13192v2, revised 22 February 2026. [Exact version addressed here](https://arxiv.org/html/2501.13192v2). DOI: [10.48550/arXiv.2501.13192](https://doi.org/10.48550/arXiv.2501.13192). All negative comparisons in Section 9 are restricted to this version.

[6] Xiaobin Gao, Emrah Akyol, and Tamer Basar. **On Remote Estimation with Multiple Communication Channels.** arXiv:1510.00059v1, 30 September 2015. [Official record and abstract](https://arxiv.org/abs/1510.00059). DOI: [10.48550/arXiv.1510.00059](https://doi.org/10.48550/arXiv.1510.00059). Abstract-level contextual comparison only.

[7] Ioannis Tzortzis and Themistoklis Charalambous. **Remote State Estimation with Unreliable Communication: Information Asymmetry and Belief Structure.** arXiv:2609.24178, 2026. [arXiv record](https://arxiv.org/abs/2609.24178). [Author publication list](https://themistoklis.org/publications.html), which lists CDC 2026. The source check accessed the indexed abstract and author bibliography, not the full text.

[8] Xu Zhang, Marcos M. Vasconcelos, Wei Cui, and Urbashi Mitra. **An Optimal Symmetric Threshold Strategy for Remote Estimation Over The Collision Channel.** *IEEE International Conference on Acoustics, Speech and Signal Processing*, 2020. DOI: [10.1109/ICASSP40776.2020.9053596](https://doi.org/10.1109/ICASSP40776.2020.9053596). [Publisher abstract](https://ieeexplore.ieee.org/abstract/document/9053596). Abstract-level comparison: the stated optimization is within an imposed symmetric-threshold class.

