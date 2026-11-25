# A finite counterexample to the threshold-two conjecture for empirical Wasserstein barycenters

Research manuscript, version 1 · 25 November 2026

**Verification scope.** This manuscript supplies a written proof and exact rational certificates. The discovery used semidefinite optimization; no numerical optimizer is needed to verify the result. Full Lean formalization is not complete. This manuscript has not undergone external peer review and makes no global priority claim.

## Abstract

We give a counterexample to Conjecture 1 of Hundrieser, Eltzner and Huckemann, *A lower bound for estimating Fréchet means* (2026), concerning a distribution-uniform parametric risk bound for empirical Wasserstein barycenters when the transport potentials have strong-convexity and smoothness gap less than two. The example lives in dimension three and fixes the parameters at $\alpha=1/10$ and $\beta=19/10$. Three measures, each uniform on four explicitly specified integer points, have two distinct barycenters. Their transports from one of these barycenters admit global continuously differentiable potentials with the required bounds. Adding an arbitrarily small mass at that barycenter makes it unique without changing the regularity parameters. For anchor mass $n^{-2}$, every measurable empirical barycenter selection has squared risk at least 4000 whenever $n\ge90000$ and $3\nmid n$, although the population variance stays below 30026. The risk in fact converges to 29200. Thus no constant independent of the population distribution can yield the conjectured bound. The main contradiction has an elementary finite-sample proof using symmetry and Chebyshev's inequality; a central limit theorem is needed only for the exact risk limit.

## 1. The question and the precise negative result

Write $\mathcal P_2(\mathbb R^3)$ for the Borel probability measures with finite second moment, equipped with quadratic Wasserstein distance $W_2$. For a probability law $P$ on this space, a barycenter minimizes

$$
F_P(\rho)=\int W_2^2(\rho,\mu)\,dP(\mu).
$$

The conjecture [H–E–H, §3.5, Conjecture 1] concerns laws with a unique barycenter $\nu$, such that every $\mu\in\mathrm{supp}(P)$ is $(\nabla\varphi^\mu)_\#\nu$ for a globally differentiable, $\alpha$-strongly convex and $\beta$-smooth function. It proposes

$$
\mathbb E W_2^2(\hat\nu_n,\nu)
\le \frac{C}{n(2-\beta+\alpha)^2}
\int W_2^2(\mu,\nu)\,dP(\mu), \tag{1.1}
$$

throughout $0\le\beta-\alpha<2$, with $C$ independent of $P$. Here $\hat\nu_n$ is any measurable barycenter of the empirical law of $n$ independent draws. The established sufficient regime is $\beta-\alpha<1$ [L–P–R–S, Corollary 4.4]. Neither the conjecture nor our example assumes densities.

**Theorem 1 (fixed-parameter counterexample).** There are four fixed, finitely supported measures $\nu,\mu_0,\mu_1,\mu_2$ on $\mathbb R^3$ such that, for every $0<\varepsilon<1$, the law

$$
P_\varepsilon=(1-\varepsilon)P_0+\varepsilon\delta_\nu,
\qquad P_0=\frac13\sum_{i=0}^2\delta_{\mu_i}, \tag{1.2}
$$

has unique barycenter $\nu$. Every measure in its support is the image of $\nu$ under the gradient of a global $C^1$, $1/10$-strongly convex, $19/10$-smooth potential. Moreover,

$$
\int W_2^2(\mu,\nu)\,dP_\varepsilon(\mu)
=(1-\varepsilon)30026. \tag{1.3}
$$

For $n\ge2$, take $n$ iid observations from $P_{n^{-2}}$. Every measurable empirical barycenter selection satisfies

$$
\mathbb E_{P_{n^{-2}}^{\otimes n}}
 W_2^2(\hat\nu_n,\nu)\ge4000
\quad\text{if }n\ge90000\text{ and }3\nmid n. \tag{1.4}
$$

In fact, without the divisibility restriction,

$$
\lim_{n\to\infty}\mathbb E_{P_{n^{-2}}^{\otimes n}}
 W_2^2(\hat\nu_n,\nu)=29200. \tag{1.5}
$$

Since $2-\beta+\alpha=1/5$, the right side of (1.1) is at most $750650C/n$ on this family. Equation (1.4) contradicts (1.1) for arbitrarily large $n$, even if $C$ may depend on the fixed dimension and the fixed regularity parameters.

The varying law $P_{n^{-2}}$ is essential to the statement. We refute uniformity over $P$; we do not assert inconsistency at any fixed $P_\varepsilon$. We also make no minimax claim about all estimators.

## 2. Integer data and global transport potentials

Let $S:\mathbb R^3\to\mathbb R^3$ be the orthogonal map

$$
S(u,v,w)=(-v,u,-w),\qquad S^4=I.
$$

Set

$$
x=(160,0,180),\qquad
a_0=(96,126,255),\quad
a_1=(288,0,30),\quad
a_2=(96,-126,255).
$$

For $j\in\{0,1,2,3\}$, write $x_j=S^jx$ and $y_{ij}=S^ja_i$, and define

$$
\nu=\frac14\sum_{j=0}^3\delta_{x_j},
\qquad
\mu_i=\frac14\sum_{j=0}^3\delta_{y_{ij}}.
\tag{2.1}
$$

All four points within each measure are distinct. Pointwise,

$$
\frac{y_{0j}+y_{1j}+y_{2j}}3=x_j,
\qquad \|x_j\|^2=58000. \tag{2.2}
$$

First-order balance (2.2) alone is not a global barycenter certificate. We will prove global optimality by inspecting every coupling orbit in Section 3.

### 2.1. Exact interpolation certificate

Fix $\alpha=1/10$, $\beta=19/10$ and $\Delta=\beta-\alpha=9/5$. Assign potential value zero to all $x_j$. The smooth strongly convex interpolation criterion [T–H–G, Theorem 4] is the nonnegativity, for every ordered pair, of

$$
M_i(j,k)=-\langle y_{ij},x_k-x_j\rangle
-\frac{\alpha}{2}\|x_k-x_j\|^2
-\frac1{2\Delta}
 \|y_{ik}-y_{ij}-\alpha(x_k-x_j)\|^2. \tag{2.3}
$$

Orthogonality of $S$ makes the margin depend only on $k-j$ modulo four. The following entries are **nine times** the margins:

| Source $i$ | $k-j=1$ | $k-j=2$ | $k-j=3$ |
|---|---:|---:|---:|
| 0 | 28570 | 7640 | 391450 |
| 1 | 59200 | 43520 | 59200 |
| 2 | 391450 | 7640 | 28570 |

This covers all 36 nontrivial ordered-pair inequalities. The remaining diagonal margins are zero. In particular, the least nontrivial margin is $7640/9>0$. These are complete interpolation conditions with specified function values, not just pairwise monotonicity tests.

### 2.2. An explicit construction of the potentials

For completeness, the sufficient interpolation argument can be realized directly. Put

$$
g_{ij}=y_{ij}-x_j/10,
\qquad
H_i(u)=\max_{0\le j<4}\left\{
 \langle x_j,u\rangle+2900+\frac5{18}\|u-g_{ij}\|^2
\right\}, \tag{2.4}
$$

and let $H_i^*(z)=\sup_u(\langle z,u\rangle-H_i(u))$. Define

$$
\varphi_i(z)=\frac{\|z\|^2}{20}+H_i^*(z). \tag{2.5}
$$

Each quadratic in (2.4) has Hessian $(5/9)I$. Therefore $H_i$ is finite, continuous, coercive and $5/9$-strongly convex. Its conjugate is finite and continuously differentiable on all of $\mathbb R^3$, with gradient Lipschitz constant $9/5$. One can see this directly: the defining supremum has a unique maximizer; strong monotonicity of $\partial H_i$ bounds the distance between two maximizers by $(9/5)$ times the distance between the two dual arguments. The unique-maximizer formula gives the gradient of the conjugate.

At $u=g_{ij}$, the $j$-th quadratic is the unique active branch. Indeed its difference from the $k$-th branch is precisely $M_i(j,k)>0$; the equality of the norms of $x_j$ is used here. Thus

$$
\nabla H_i(g_{ij})=x_j,\qquad
\nabla H_i^*(x_j)=g_{ij},\qquad
H_i^*(x_j)=-2900.
$$

Equations (2.4)–(2.5) imply

$$
\varphi_i(x_j)=0,\qquad
\nabla\varphi_i(x_j)=y_{ij}.
$$

Moreover $\varphi_i$ is globally $1/10$-strongly convex, and its gradient has Lipschitz constant at most $1/10+9/5=19/10$. Hence (2.1) gives exactly $(\nabla\varphi_i)_\#\nu=\mu_i$. The identity transport for $\nu$ is generated by $\|z\|^2/2$, which satisfies the same bounds.

These gradients also give optimal transports. Fenchel's inequality bounds $\langle z,u\rangle$ by $\varphi_i(z)+\varphi_i^*(u)$; equality holds on the gradient graph. Differentiability makes that graph the only equality set over each $z$, so the optimal plans from $\nu$ to $\mu_i$ are unique. No density assumption is involved.

## 3. All couplings, not just a proposed matching

### 3.1. The finite multimarginal identity

For nonnegative weights $q_i$ with sum one, let $\Gamma$ range over joint laws of $(Y_0,Y_1,Y_2)$ with marginals $\mu_i$. Set $Z=\sum_iq_iY_i$. The barycenter objective has minimum

$$
\sum_iq_i\int\|y\|^2\,d\mu_i(y)
-\max_\Gamma \mathbb E_\Gamma\|Z\|^2. \tag{3.1}
$$

An optimal joint law produces a barycenter as the law of $Z$, and every barycenter is produced this way. Here is a short proof covering the latter assertion. Given a barycenter random variable $V$, glue optimal couplings $(V,Y_i)$ along $V$. The identity

$$
\sum_iq_i\mathbb E\|Y_i-V\|^2
=\sum_iq_i\mathbb E\|Y_i-Z\|^2+\mathbb E\|Z-V\|^2
$$

and the competitor given by the law of $Z$ force the last term to vanish. Conversely, applying the couplings induced by any joint law to its weighted mean proves the matching upper bound in (3.1). Existence of the maximum follows from the finite coupling polytope.

### 3.2. Sixteen scores exhaust the optimization

Every one of the $4^3=64$ tuples has a unique representation

$$
(Y_0,Y_1,Y_2)=(S^ja_0,S^{j+r}a_1,S^{j+s}a_2),
\qquad j,r,s\in\mathbb Z/4\mathbb Z.
$$

Define

$$
B_{rs}(q)=\|q_0a_0+q_1S^ra_1+q_2S^sa_2\|^2. \tag{3.2}
$$

The tuple score does not depend on $j$, since $S$ is orthogonal. Every joint law therefore has score at most $\max_{r,s}B_{rs}(q)$. For each $(r,s)$, the law placing mass $1/4$ on the four corresponding tuples has all the required marginals and attains $B_{rs}(q)$. Consequently,

$$
\max_\Gamma\mathbb E_\Gamma\|Z\|^2
=\max_{r,s}B_{rs}(q). \tag{3.3}
$$

This argument includes nonsymmetric and fractional couplings. If one orbit has strictly largest score, every optimal joint law must be supported on that orbit. The uniform first marginal then forces weight $1/4$ on each of its four tuples, so both the joint optimizer and the barycenter are unique.

At $p=(1/3,1/3,1/3)$, the exact table is:

| $r$ $\backslash$ $s$ | 0 | 1 | 2 | 3 |
|---|---:|---:|---:|---:|
| 0 | **58000** | 34476 | 48672 | 7596 |
| 1 | 38912 | 34476 | **58000** | 11436 |
| 2 | 33424 | 6060 | 48672 | 11436 |
| 3 | 38912 | 6060 | 25744 | 7596 |

Only $(r,s)=(0,0)$ and $(1,2)$ are optimal. Their means have base points $x=(160,0,180)$ and $x'=(0,180,160)$, respectively. Put

$$
\nu'=\frac14\sum_{j=0}^3\delta_{S^jx'}.
$$

In fact the entire barycenter set of $P_0$ is

$$
\{(1-\lambda)\nu+\lambda\nu':0\le\lambda\le1\}. \tag{3.4}
$$

To check this, let $d_j$ and $e_j$ be masses on the two optimal tuples indexed by $j$. Marginals zero and one imply $d_j+e_j=1/4$ and $d_j+e_{j-1}=1/4$; thus all $e_j$ are equal and so are all $d_j$. This gives precisely the mixtures of the two uniform orbit plans.

### 3.3. Distances and the anchoring argument

For $j=0,1,2,3$, the inner products $\langle x,S^jx'\rangle$ are $28800,-57600,28800,0$. All atoms of the two measures $\nu$ and $\nu'$ have squared norm 58000. No coupling can have mean inner product above 28800, and the synchronized matching attains it. Hence

$$
W_2^2(\nu,\nu')=116000-57600=58400. \tag{3.5}
$$

The unique gradient matchings from Section 2 give

$$
\bigl(W_2^2(\nu,\mu_0),W_2^2(\nu,\mu_1),W_2^2(\nu,\mu_2)\bigr)
=(25597,38884,25597). \tag{3.6}
$$

Their mean is 30026. Since $\nu$ minimizes $F_{P_0}$, for any $\rho\ne\nu$,

$$
F_{P_\varepsilon}(\rho)-F_{P_\varepsilon}(\nu)
=(1-\varepsilon)\bigl(F_{P_0}(\rho)-F_{P_0}(\nu)\bigr)
+\varepsilon W_2^2(\rho,\nu)>0. \tag{3.7}
$$

This proves uniqueness for $P_\varepsilon$, while the potential for its new support point is the identity potential already verified. Equation (1.3) follows from (3.6).

## 4. Why empirical frequencies select the other barycenter

Write $q=(q_0,q_1,q_2)$, $b=q_1$, and $h=q_0-q_2$. The two competitive orbit means have base points

$$
D(q)=(96+192b,\ 126h,\ 255-225b),
$$

$$
A(q)=(96h,\ 126+162b,\ 255-285b). \tag{4.1}
$$

At $p$, these are $x$ and $x'$. Their score difference is

$$
\begin{aligned}
H(q)&=\|A(q)\|^2-\|D(q)\|^2\\
&=13320\bigl(2q_0q_2-q_1(q_0+q_2)\bigr)\\
&=6660\bigl((1-b)(1-3b)-h^2\bigr). \tag{4.2}
\end{aligned}
$$

Let $R^2=90117=\max_i\|a_i\|^2$. For any orbit and weights in the simplex,

$$
|B_{rs}(q)-B_{rs}(p)|\le2R^2\|q-p\|_1. \tag{4.3}
$$

Indeed the corresponding weighted means have norms at most $R$, and their difference has norm at most $R\|q-p\|_1$. If

$$
\|q-p\|_\infty\le1/150, \tag{4.4}
$$

then $\|q-p\|_1\le1/50$. Every other orbit remains below the diagonal orbit, because its initial gap is at least 9328 and

$$
9328-\frac{4\cdot90117}{50}=\frac{52966}{25}>0. \tag{4.5}
$$

Under (4.4), whenever $H(q)>0$, (3.3) therefore implies that **every** empirical barycenter is

$$
\nu_A(q)=\frac14\sum_{j=0}^3\delta_{S^jA(q)}. \tag{4.6}
$$

Synchronized coupling gives

$$
W_2(\nu_A(q),\nu')\le R\|q-p\|_1\le R/50<7.
$$

Since $W_2(\nu,\nu')=\sqrt{58400}>240$, the triangle inequality yields

$$
W_2^2(\nu_A(q),\nu)>233^2>50000. \tag{4.7}
$$

This establishes separation of the actual empirical minimizer. Merely comparing the empirical objective at the two fixed population barycenters would not establish (4.7).

## 5. An elementary finite-sample contradiction

First take iid observations from $P_0$, and let $q_i=N_i/n$ be their empirical source frequencies. Each has variance $2/(9n)$. A union of three Chebyshev bounds gives

$$
\mathbb P(\|q-p\|_\infty>1/150)\le15000/n. \tag{5.1}
$$

Exchangeability of the three counts and the fact that at least one count is minimal imply

$$
\mathbb P(q_1=\min(q_0,q_1,q_2))\ge1/3. \tag{5.2}
$$

On the intersection of this event with (4.4), write $q_0=q_1+u$, $q_2=q_1+v$, where $u,v\ge0$. Equation (4.2) becomes

$$
H(q)/13320=q_1(u+v)+2uv.
$$

Condition (4.4) ensures $q_1>0$. If $3\nmid n$, the integer counts cannot all be equal, so $u+v>0$ on this event. Thus $H(q)>0$. For $n\ge90000$, equations (5.1)–(5.2) give event probability at least $1/6$. By (4.7), every empirical barycenter then has squared error exceeding 50000.

Now sample from $P_{n^{-2}}$. The event $E_n$ that none of the observations equals the anchor $\nu$ has probability

$$
\mathbb P(E_n)=(1-n^{-2})^n\ge1-1/n\ge1/2.
$$

Conditional on $E_n$, the observations are iid from $P_0$. Hence, whenever $n\ge90000$ and $3\nmid n$,

$$
\mathbb E W_2^2(\hat\nu_n,\nu)
\ge\frac12\cdot\frac16\cdot50000
=\frac{12500}{3}>4000.
$$

This proves (1.4), and already disproves the conjecture. The population law has a unique barycenter for every positive anchor mass. No regularity assumption relative to the *other* unanchored barycenter is used.

## 6. The exact asymptotic risk

The finer statement (1.5) follows from the ordinary binomial central limit theorem. Under $P_0$,

$$
\sqrt n(q_1-1/3)\Rightarrow N(0,2/9),
\qquad \mathbb E(q_0-q_2)^2=2/(3n).
$$

Expanding (4.2) around $p$, and using the second-moment bound for its quadratic terms, gives

$$
\sqrt n H(q)=-13320\sqrt n(q_1-1/3)+o_{\mathbb P}(1)
\Rightarrow N(0,39427200). \tag{6.1}
$$

Therefore $\mathbb P(H(q)>0)\to1/2$, $\mathbb P(H(q)<0)\to1/2$, and $\mathbb P(H(q)=0)\to0$. Also $q\to p$ in probability. With probability tending to one, only the two orbits of Section 4 can be optimal. On the positive event, the unique barycenter is $\nu_A(q)$, whose squared distance to $\nu$ tends to 58400. On the negative event, it is the analogous orbit law based at $D(q)$, whose squared distance tends to zero. Continuity follows directly from synchronized couplings and the Wasserstein triangle inequality.

The passage to expectations is uniform over all selections. Every empirical barycenter is supported in the convex hull of the union of the observed supports, by the multimarginal identity. All these supports, including the anchor, lie in the radius-$R$ ball. Consequently its squared distance to $\nu$ is at most $4R^2=360468$. The exceptional and tie events therefore contribute a quantity tending to zero. Under $P_0$ the risk converges to $58400/2=29200$. Finally, $\mathbb P(E_n^c)\le1/n$ transfers the same limit to $P_{n^{-2}}$. This proves (1.5).

## 7. Interpretation, scope, and reproducibility

The obstruction is a competition between two cyclic couplings of three target measures. The interpolation certificate controls each transport from the selected reference barycenter, but does not eliminate a different globally optimal joint coupling. A small anchor enforces population uniqueness while empirical fluctuations continue to select the competing coupling with nonvanishing probability.

The result applies to the quantifiers of the original conjecture: fixed dimension, fixed positive strong convexity, fixed smoothness gap strictly below two, and unique population barycenter for each law in the family. It does not modify the valid sufficient condition below one, determine the sharp threshold between one and (9/5), or address stronger hypotheses such as a compatible global dual family or absolute continuity. The example uses singular measures, which the conjecture permits. It concerns empirical barycenters, not a lower bound against every possible estimator. The new contribution is the exact three-source coupling construction and its statistical consequence; finite interpolation, the multimarginal identity, anchoring, Chebyshev's inequality and the central limit theorem are established tools.

All numerical constants in Sections 2–5 are verified by a Python standard-library program using rational arithmetic. Its certificate checks all 36 interpolation inequalities, all 16 orbit scores, all 24 assignments for each reported Wasserstein distance, the score polynomial, and the finite-sample margins. These finite checks complement the written arguments for global potentials, arbitrary couplings and probabilities. They do not by themselves verify those analytic arguments. The independent review uses a separately written exact computation. Discovery scripts and optimizer tolerances are not part of the proof assumptions.

This version does not supply Lean source or end-to-end formal verification.

### Literature availability

The novelty assessment is limited to the sources actually checked as of 25 November 2026. For the recent preprint by G. Carlier, J. Guérin and Q. Mérigot, *Quantitative stability of classical, entropic, and doubly entropic Wasserstein barycenters* ([arXiv:2611.12497](https://arxiv.org/abs/2611.12497)), the review obtained an official abstract and institutional metadata, but not the full theorem text. It is not a proof input, and we do not claim to have excluded every possible overlap with that unavailable full text. The detailed comparisons and retrieval limitations accompany the manuscript. The full text of A. Kroshnin's 2021 thesis, *Inside and around Wasserstein barycenters*, was also not obtained. Its Theorem 4.6.1 is a relevant negative-result neighbor identified and described in [H–E–H, end of §3.5]; we have not independently checked its full assumptions or parameter range and do not treat that thesis as a proof input.

## References

**[H–E–H]** S. Hundrieser, B. Eltzner and S. F. Huckemann. *A lower bound for estimating Fréchet means*. Annals of the Institute of Statistical Mathematics, published 22 June 2026. DOI: [10.1007/s10463-026-00989-6](https://doi.org/10.1007/s10463-026-00989-6). Target: §3.5, Theorem 3, Proposition 3 and Conjecture 1. Official full text inspected on 25 November 2026. The same question appears as Conjecture 3.11 in the earlier [arXiv:2402.12290v1](https://arxiv.org/html/2402.12290v1), submitted 19 February 2024.

**[L–P–R–S]** T. Le Gouic, Q. Paris, P. Rigollet and A. J. Stromme. *Fast convergence of empirical barycenters in Alexandrov spaces and the Wasserstein space*. Journal of the European Mathematical Society 25 (2023), 2229–2250. DOI: [10.4171/JEMS/1234](https://doi.org/10.4171/JEMS/1234). Relevant results: Theorem 3.3 and Corollary 4.4; discussion of exponential barycenters in §4.3.2.

**[T–H–G]** A. B. Taylor, J. M. Hendrickx and F. Glineur. *Smooth strongly convex interpolation and exact worst-case performance of first-order methods*. Mathematical Programming 161 (2017), 307–345. DOI: [10.1007/s10107-016-1009-3](https://doi.org/10.1007/s10107-016-1009-3). Theorem 4. [Author manuscript](https://optimization-online.org/wp-content/uploads/2015/03/4814.pdf).

**[C–M–R–S]** S. Chewi, T. Maunu, P. Rigollet and A. J. Stromme. *Gradient descent algorithms for Bures-Wasserstein barycenters*. Proceedings of COLT, PMLR 125 (2020). [Official paper](https://proceedings.mlr.press/v125/chewi20a.html). Its compatible-potential variance conditions are stronger than the transport assumptions at issue here.

**[B–F–R–T]** J. Backhoff-Veraguas, J. Fontbona, G. Rios and F. Tobar. *Stochastic gradient descent for barycenters in Wasserstein space*. Journal of Applied Probability, online 2024, issue 2025. DOI: [10.1017/jpr.2024.39](https://doi.org/10.1017/jpr.2024.39). Definition 4 introduces pseudo-associativity as an additional condition; no such condition is assumed here.
