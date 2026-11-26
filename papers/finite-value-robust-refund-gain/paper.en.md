# Quantitative gains from refunds under finite valuation uncertainty

**Verification scope.** This is a written mathematical research manuscript. Its mathematical claims are separated from finite arithmetic checks. It has not undergone external peer review, and no Lean source or kernel verification accompanies this version.

## Abstract

A seller knows the finite distribution of an experience-good valuation but does not know the buyer's pre-purchase information. We prove that, when the prior has positive mass at valuation zero, every finite restocking cost permits a uniformly positive gain over optimal non-refundable randomized pricing. A finite lottery with only one positive refund amount suffices. The guarantee holds against every Bayes-plausible information structure and every choice at purchasing indifference. Starting from the established equal-revenue/convex-order benchmark, we show that an experiment with nearly minimal monopoly revenue must have small truncation Jensen gap and small tail deficit simultaneously. These two defects control the losses of one common near-full-refund price band. We give an explicit, conservative gain, convert the separating offers into a single ex-ante committed finite lottery, and prove an exact finite verification theorem: for a dictionary with one positive refund level, a worst experiment uses at most as many signals as valuation states, and each relevant posterior pools at most three states. A rational three-valuation instance is certified over all posterior distributions. We do not identify the exact optimal refundable revenue or an optimal asymptotic gain rate.

## 1. Contribution, scope, and prior work

The main question is whether costly returns can improve a seller's revenue guarantee when the buyer's entire information structure is unknown. Hinnosaar and Kawai [HK20] solve the binary-valuation problem and discuss the difficulty of extending refund gains beyond two values. The obstacle is substantive: expected valuation determines demand without returns, but generally does not determine either demand or return risk with refunds.

Our contribution is a quantitative result for every finite valuation prior with a positive zero atom and every finite restocking cost. The guarantee uses a single positive refund level, independent of the unknown information structure. Its finite-price implementation is robust to unfavorable purchasing ties. The key stability argument concerns the full posterior experiment rather than only its distribution of means. A second result turns any such finite dictionary into an exact linear program using posteriors of support at most three. Generic convex-order, separation, polyhedral, and linear-programming tools are classical; the new claims concern their specific combination with the quantitative refund bound and its all-posterior certificate.

The non-refundable benchmark, equal-revenue laws, and truncation-contact construction in Section 2 belong to the Roesler--Szentes and Du line of work [RS17, D18]. We give the finite-support derivation to make every assumption and constant checkable. Neither the benchmark nor the existence of a Jensen contact is claimed as a new discovery.

The closest later comparison is von Wangenheim [W25]. The available 2024 author manuscript studies information design followed by a seller's deterministic option-contract menu. It characterizes a zero-return-cost surplus region and discusses the persistence of its no-return construction under positive return costs. Its Section 5.1 must be taken into account: the construction remaining attainable does not by itself provide the uniform guarantee for the restricted single-offer lottery studied here. Our result neither contradicts that construction nor replaces its surplus characterization. We verified the published 2025 metadata and abstract, but obtained the complete text only of the 2024 author version; comparisons to its detailed arguments are limited accordingly.

Known-type sequential screening is another distinct setting. Alaei et al. [ACHMM25] study deterministic refund menus for a known ordered family of type-dependent distributions, and Lyu [L26] studies costly endogenous buyer learning in a binary model. These do not provide the quantitative all-information guarantee proved below. These comparisons are bounded literature checks, not a claim of exhaustive priority verification.

**Main result, informal form.** For the prior, benchmark $R$, and active contact $t$ defined below, let $u>0$ be (Q1). There is a precommitted finite lottery with non-returnable offers and one positive refund amount that guarantees at least $R+u/2$ against all feasible experiments and purchasing ties. For a fixed finite dictionary of this form, its exact optimal robust value has the finite LP representation in Sections 7–8.

The theorem does not cover arbitrary continuous or unbounded priors, unknown group heterogeneity, information chosen after the seller's realized random draw, or an unrestricted optimal dynamic mechanism. It does not assert a sharp gain, a minimal number of prices, or polynomial complexity of the unrestricted policy search.

## 2. Model and the established non-refundable benchmark

### 2.1. Primitives and benchmark parameters

Let the known valuation prior have finite support

```math
0=v_0 \lt v_1<\cdots \lt v_k=B,
\qquad \pi_j>0,
\qquad k\ge1.
```

The restocking cost is a fixed finite number $c\ge0$. Production cost is zero. A posterior is $q\in\Delta_k$, its mean is $m(q)=\sum_jv_jq_j$, and an admissible information structure is a probability measure $\tau$ on $\Delta_k$ satisfying $\int q_j\,d\tau=\pi_j$. Denote this compact convex set by $\mathcal K$. Randomization of offers is independent of the state and signal and occurs after the information structure is fixed, as in the original robust-pricing game. The buyer sees the realized offer before choosing whether to buy. After buying, the buyer observes the valuation and may return for the stated refund.

A nonrefundable offer provides no return right. When its refund is written as $r=0$, this is only a label for the absence of returns, not a right to return a zero-value item for zero payment and impose a restocking cost. A deterministic refundable offer $(p,r)$, with $0 \lt r\le p\le B$, is purchased when

```math
W_r(q):=\sum_jq_j\max(v_j,r)>p.
```

For refunds strictly between adjacent support points, the return probability is
$L_r(q)=\sum_{v_j \lt r}q_j$, and the seller's conditional profit upon purchase is $p-(r+c)L_r(q)$. The intermediate refund price bands have continuous densities, so purchasing ties have probability zero for every posterior at that stage. The final finite lottery is treated separately and permits arbitrary purchasing ties. The chosen positive refund is not a valuation support point, so final-stage return ties are absent.

Purchasing ties may always be resolved arbitrarily. The signal may depend on the publicly committed lottery, but not on its independent realized draw.

Write

```math
S(t)=\mathbb E\min(V,t),\quad \mu=\mathbb EV.
```

For each positive support point $v_i$, let $R_i\in(0,v_i)$ be the unique solution

```math
S(v_i)=R_i[1+\log(v_i/R_i)].
```

Existence and uniqueness follow because $0 \lt S(v_i) \lt v_i$, using positive mass at 0, and the function $x\mapsto x[1+\log(v_i/x)]$ is continuous and strictly increasing on $(0,v_i)$, with endpoint limits 0 and $v_i$. Let

```math
R=\max_{1\le i\le k}R_i.
```

The established no-refund robust benchmark is $R$. An elementary verification is included in Section 2.2; the convex-order implementation step is standard martingale coupling, and is not claimed as a new result.

Fix any active index $i$, meaning $R=R_i$, and put

```math
t=v_i,\qquad d=v_i-v_{i-1}>0,\qquad
\ell=\log(t/R)>0.
```

In particular, $0 \lt R \lt t$. There is no need to assume $\delta \lt R$ anywhere below.

### 2.2. Verification of the benchmark

For each $i$, use the log-uniform nonrefundable price on $[R_i,v_i]$. For posterior mean $m$, its profit is

```math
\phi_i(m)=\frac{(\min(m,v_i)-R_i)_+}{\log(v_i/R_i)}.
```

By concavity of $x\mapsto\min(x,v_i)$ and Bayes plausibility,

```math
\mathbb E\phi_i(M)
\ge\frac{S(v_i)-R_i}{\log(v_i/R_i)}=R_i.
```

Thus no-refund robust value is at least $R$.

For the upper bound, set $B_R=R\exp(\mu/R-1)$. Since $R\ge R_k$, $B_R\le B$; and $R<\mu$, so $B_R>R$. Let $Y$ be the equal-revenue law with survival 1 below $R$, $R/y$ on $[R,B_R)$, and a terminal atom of size $R/B_R$ at $B_R$. Its mean is $\mu$ and its monopoly revenue is $R$.

For $R\le x\le B_R$, its integrated CDF is

```math
\mathbb E(x-Y)_+=x-R-R\log(x/R).
```

We claim this is at most $\mathbb E(x-V)_+=x-S(x)$. At each support endpoint $v_j\ge R$, this follows from $R\ge R_j$ and monotonicity of $z[1+\log(v_j/z)]$ for $z\le v_j$. At $x=R$, it follows from $S(R)\le R$. Between consecutive support endpoints, $S$ is affine and $R[1+\log(x/R)]$ is concave, so the inequality holds throughout. Below $R$ it is automatic. Above $B_R$, the integrated CDF is $x-\mu\le\mathbb E(x-V)_+$. Thus $Y\preceq_{cx}V$ with equal means.

By the finite-target martingale-coupling theorem (proved in Appendix A and historically due to the convex-order/martingale theory [S65]), there exists a joint law with $\mathbb E[V\mid Y]=Y$, inducing a Bayes-plausible posterior experiment whose posterior mean is $Y$. This experiment bounds every random nonrefundable pricing policy by $R$. This proves the benchmark.

## 3. Exact worst-experiment contact rigidity

For an experiment $\tau$, define its monopoly revenue
```math
\operatorname{Mon}(\tau)=\sup_{p\in[0,B]}p\Pr_\tau(M\ge p).
```
This upper envelope is also the supremum approached by continuous price bands from below, so its use does not impose favorable ties on our eventual policies.

**Proposition 3.1 (all worst experiments).** If $\operatorname{Mon}(\tau)\le R$, then for every active contact $t$:

1. $M\ge R$ almost surely; on $(R,t)$ its density is $R/x^2$, and $\Pr(M\ge t)=R/t$.
2. Almost every posterior is supported wholly in $\{v_j\le t\}$ or wholly in $\{v_j\ge t\}$. If its mean is $t$, the posterior is the point mass at $t$.

**Proof.** The revenue cap bounds the survival function by $\min(1,R/x)$. Integrating up to $t$ gives $\mathbb E\min(M,t)\le R[1+\log(t/R)]=S(t)$. Jensen and Bayes plausibility give the reverse inequality. The integral of the nonnegative survival deficit therefore vanishes. Monotonicity and right/left survival limits yield the stated density and the tail at $t$, with possible mass at $t$ included in that tail. Likewise the conditional truncation Jensen gap is nonnegative with zero expectation. At a posterior $q$, the gap equals the minimum of its expected shortfall below $t$ and expected excess above $t$; it vanishes exactly when these two sides do not both carry positive mass. A one-sided posterior of mean exactly $t$ must be concentrated at $t$. $\square$

This proposition is an application of the established contact geometry to every joint posterior realization. The quantitative estimate in Sections 4--5 is the ingredient that avoids restricting the subsequent theorem to an exactly worst experiment.

## 4. Quantitative constants and one refundable price band

Define

```math
\delta=\min\left\{\frac{t-R}{4},\frac{dt}{8(t+c)}\right\},
\qquad \varepsilon=\frac{\delta}{8},
\qquad
u=\frac{R\delta^2}{52t(t+c)\ell}>0.
\tag{Q1}
```

Set

```math
r=t-\varepsilon,
\quad \gamma_- =\frac{t}{4(t+c)},
\quad \gamma_+ =\frac{t}{2(t+c)},
\quad
p=t-\varepsilon\gamma,
\qquad \gamma\sim\operatorname{Unif}[\gamma_-,\gamma_+].
\tag{Q2}
```

Call this randomized refundable offer $G$, and write $g(q)$ for its expected conditional profit. It uses one refund level $r$ and a uniform sales-price interval. Its mean price is $\bar p$, and

```math
t-\varepsilon\le \bar p \lt t.
```

Parameter checks:

1. $0<\delta\le(t-R)/4 \lt t/4$.
2. $\delta\le d/8$ because $t/(t+c)\le1$; hence $0<\varepsilon\le d/64$.
3. Consequently $v_{i-1} \lt r \lt t$, and $0 \lt r \lt p \lt t\le B$.
4. $0<\gamma_-<\gamma_+\le1/2$.
5. Let $K=R+u$. Since $\ell\ge(t-R)/t$,

```math
u\le\frac{R(t-R)}{832(t+c)}<\frac{t-R}{832}.
\tag{Q3}
```

Thus $R \lt K \lt t-\delta$. The weak inequality in the first display follows from $\delta^2\le(t-R)^2/16$; the final strict inequality uses $R \lt t+c$.
6. Also

```math
\frac{u}{R\delta/(4t)}
=\frac{\delta}{13(t+c)\ell}
\le\frac{t}{52(t+c)}\le\frac1{52}.
\tag{Q4}
```

## 5. Stability of all near-worst experiments

### 5.1. A pointwise bound for off-contact losses

For a posterior $q$, define

```math
A(q)=\mathbb E_q(t-V)_+,
\quad Z(q)=\mathbb E_q(V-t)_+,
\quad D(q)=\min\{A(q),Z(q)\}.
```

Then $m-t=Z-A$, and the Jensen gap of the concave truncation is exactly

```math
D(q)=\min(m(q),t)-\mathbb E_q\min(V,t).
\tag{Q5}
```

Let $L(q)=\Pr_q(V \lt t)$. Since the refund lies strictly between $v_{i-1}$ and $t$, this is also the return probability. The finite support gap gives

```math
dL\le A.
\tag{Q6}
```

The buyer's expected value with the refund is exactly

```math
W_r(q)=t-\varepsilon L(q)+Z(q).
\tag{Q7}
```

Put $L_0=t-\delta$, $a=(t+c)/d$, and $C=(t+c)/\varepsilon=8(t+c)/\delta$. Define a nonnegative function

```math
h(m)=\left[\bar p-a(t-m)_+\right]\mathbf1_{\{m\ge L_0\}}.
\tag{Q8}
```

**Pointwise claim.** For every posterior,

```math
g(q)\ge h(m(q))-C D(q).
\tag{Q9}
```

Proof, region by region:

* If $m\ge t$, every realized price is strictly below $m\le W_r$, so the buyer always purchases. Here $D=A$, and (Q6) yields
  $g=\bar p-(r+c)L\ge\bar p-aD=h(m)-aD\ge h(m)-CD$, because $\varepsilon \lt d$.

* If $t-\delta\le m \lt t$, then $D=Z$ and $A=t-m+D$. Equations (Q6)–(Q7) imply

  ```math
  W_r\ge t-\frac{\varepsilon}{d}(t-m)
      +\left(1-\frac{\varepsilon}{d}\right)D
      \ge t-\frac{\varepsilon\delta}{d}.
  ```

  Since $\delta/d\le t/[8(t+c)]=\gamma_-/2$, this lower bound is strictly above the largest offered price $t-\varepsilon\gamma_-$. Every realized offer is purchased, and

  ```math
  g\ge\bar p-a(t-m)-aD=h(m)-aD\ge h(m)-CD.
  ```

* If $m \lt t-\delta$, then $D=Z$. If the buyer purchases a realized offer, (Q7) and $W_r>p=t-\varepsilon\gamma$ give
  $L<\gamma+D/\varepsilon$. Hence the realized conditional profit is at least

  ```math
  t-\varepsilon\gamma-(t-\varepsilon+c)(\gamma+D/\varepsilon)
  =t-(t+c)\gamma-\frac{t-\varepsilon+c}{\varepsilon}D
  \ge t/2-CD.
  ```

  If the buyer does not purchase, profit is zero. In either event it is at least $-CD$, which proves (Q9) because $h=0$ here.

Nonnegativity of $h$ follows from $a\delta\le t/8$ and $\bar p\ge t-\varepsilon$, with $\varepsilon \lt t/32$. These arguments cover endpoint means as well. The potential initial tie is null under the continuous price randomization.

### 5.2. Tail deficit and truncation deficit

Let $\tau\in\mathcal K$, write $M=m(q)$, and let

```math
\operatorname{Mon}(\tau)=\sup_{p\in[0,B]}p\Pr(M\ge p)
```

be its monopoly revenue with favorable purchase ties. Suppose

```math
\operatorname{Mon}(\tau)\le K=R+u.
\tag{Q10}
```

This assumption is only used as a convenient pointwise upper bound. The final constructed policies themselves do not depend on tie conventions.

Define

```math
U(x)=x[1+\log(t/x)]\quad(0 \lt x \lt t).
```

The active contact gives $S(t)=U(R)$. The tail cap from (Q10) implies

```math
\mathbb E\min(M,t)\le\int_0^t\min(1,K/y)\,dy=U(K).
```

Jensen gives $\mathbb E\min(M,t)\ge S(t)$. Write

```math
J=\mathbb E D=\mathbb E\min(M,t)-S(t),
\qquad
T=U(K)-\mathbb E\min(M,t).
```

Both are nonnegative and

```math
J+T=U(K)-U(R)\le\ell u,
\tag{Q11}
```

because $U'(x)=\log(t/x)\le\ell$ on $[R,K]$. In particular each is at most $\ell u$.

Let $S_M(y)=\Pr(M\ge y)$. For integration, replacing $\ge$ by $>$ changes nothing. Since $K \lt L_0$, the tail deficit on $[L_0,t]$ is nonnegative and has integral at most $T$:

```math
\int_{L_0}^t[K/y-S_M(y)]\,dy\le T.
\tag{Q12}
```

Set $h_0=\delta/4$. Monotonicity of the survival function yields

```math
S_M(L_0)\ge\frac K{L_0+h_0}-\frac T{h_0}.
\tag{Q13}
```

Indeed, over $[L_0,L_0+h_0]$, the deficit is at least
$K/(L_0+h_0)-S_M(L_0)$, and integrating proves (Q13), including when that lower bound is negative.

The tail-integral identity for the function (Q8) is

```math
\mathbb E h(M)
=(\bar p-a\delta)S_M(L_0)+a\int_{L_0}^t S_M(y)\,dy.
\tag{Q14}
```

Combining (Q12)–(Q14), using $\bar p-a\delta>0$, gives

```math
\mathbb E h(M)
\ge K\left[\frac{\bar p-a\delta}{t-3\delta/4}
                +a\log\frac t{t-\delta}\right]
 -T\left[\frac{4(\bar p-a\delta)}\delta+a\right].
\tag{Q15}
```

The bracket multiplying $K$ is at least $1+\delta/(2t)$. To check constants, use $\bar p\ge t-\varepsilon$, $-\log(1-z)\ge z$, $a\delta\le t/8$, and $\varepsilon=\delta/8$:

```math
\begin{aligned}
\frac{\bar p-a\delta}{t-3\delta/4}
 +a\log\frac t{t-\delta}
&\ge 1+\frac{3\delta/4-\varepsilon-3a\delta^2/(4t)}{t-3\delta/4}\\
&\ge 1+\frac{17\delta/32}{t-3\delta/4}
\ge 1+\frac\delta{2t}.
\end{aligned}
\tag{Q16}
```

Using (Q9), (Q15), and (Q16), followed by the deliberately conservative separate bounds $J,T\le\ell u$,

```math
\mathbb E g(q)
\ge K\left(1+\frac\delta{2t}\right)
 -\left[\frac{4t}\delta+a+C\right]\ell u.
```

Since $a\le t/(8\delta)$ and $C=8(t+c)/\delta$,

```math
\frac{4t}\delta+a+C
\le\frac{(4+1/8)t+8(t+c)}\delta
<\frac{13(t+c)}\delta.
\tag{Q17}
```

Therefore

```math
\begin{aligned}
\mathbb E g(q)
&\ge R+\frac{R\delta}{2t}
       -\frac{13(t+c)\ell u}\delta\\
&= R+\frac{R\delta}{4t}
\ge R+52u.
\end{aligned}
\tag{Q18}
```

The last inequality follows from (Q4). Thus every information structure whose monopoly revenue is at most $R+u$ is defeated by the same refundable band by a larger uniform margin. This is the main quantitative statement; no exact optimal-refund-value claim is made.

## 6. A precommitted finite policy

**Theorem 6.1 (uniform quantitative refund gain).** For every finite prior satisfying Section 2, every finite cost $c\ge0$, and any active contact $t$, define $\delta,\varepsilon,u$ by (Q1). There exists a finite lottery, committed before the unknown Bayes-plausible experiment and randomized independently of it, with non-returnable offers and refundable offers using the single amount $r=t-\varepsilon$, whose expected profit is at least $R+u/2>R$ for every admissible experiment and every purchasing tie choice. All its prices lie in $[0,B]$, each refundable price is at least $r$, and the number of offers satisfies (Q21).

**Proof.**

For every $\tau\in\mathcal K$, either $\operatorname{Mon}(\tau)>R+u$, or (Q18) gives $G(\tau)\ge R+52u$. Hence

```math
\inf_{\tau\in\mathcal K}
\max\{\operatorname{Mon}(\tau),G(\tau)\}\ge R+u.
\tag{Q19}
```

This is not by itself a committed-policy result; the following finite continuous-game argument is required.

For a nonrefundable price uniformly distributed on any nontrivial interval in $[0,B]$, expected profit is a continuous function of the posterior. The supremum over such price bands equals $\operatorname{Mon}(\tau)$: approximate any deterministic price from below with a narrow uniform interval. This approximation also shows that the chosen buyer tie convention is immaterial for the supremum.

The refundable band $G$ has continuous payoff in $q$, since it integrates $(p-(r+c)L(q))\mathbf1_{p \lt W_r(q)}$ against a uniform density. Every payoff is bounded. The set $\mathcal K$ is compact in the weak topology because the posterior simplex is compact and the barycenter constraints are closed. Consequently the continuous affine game satisfies minimax when the seller is allowed finite mixtures of uniform nonrefund bands and $G$. One may use the finite-dimensional separation argument stated below. Combining this with (Q19) gives a robust value of at least $R+u$, although this statement is about a supremum and need not assert attainment by a particular limiting policy.

There is an explicit finite reduction. Let $\zeta=u/8$, and include the uniform nonrefundable bands on a consecutive price mesh of width at most $\zeta$, including the last truncated band when needed. There are at most $\lceil B/\zeta\rceil$ such bands. For any target deterministic price $p$, a full band immediately below it has all its prices at least $p-2\zeta$; when $p<2\zeta$, the revenue itself is at most $2\zeta$. Thus, uniformly over all information structures,

```math
\max_{\text{mesh bands}}\operatorname{Revenue}(\tau)
\ge\operatorname{Mon}(\tau)-2\zeta.
```

The finite-action continuous game, with those bands and $G$, therefore has value at least

```math
R+u-2\zeta=R+3u/4.
```

Finite-dimensional minimax gives a probability vector over these bands achieving this lower bound. Each band can then be replaced by a sufficiently fine, equally weighted price grid. For a fixed posterior and fixed refund, as a function of price the payoff is affine up to a single purchase cutoff and zero above it. On $[0,B]$, its total variation, even with arbitrary behavior at the cutoff, is bounded by $3B+2c$; this conservative bound is used to avoid unnecessary dependence on the endpoint convention. A normalized $n$-point Riemann approximation therefore has a uniform error of at most $(3B+2c)/n$. Choose

```math
n\ge \left\lceil \frac{4(3B+2c)}u\right\rceil.
```

The resulting finite randomized collection of deterministic price-refund pairs guarantees at least

```math
\boxed{R+u/2>R.}
\tag{Q20}
```

Its refunds take only the two values 0 and $r=t-\varepsilon$. The crude number of offers is bounded by

```math
\left(\left\lceil\frac{8B}u\right\rceil+1\right)
\left\lceil\frac{4(3B+2c)}u\right\rceil.
\tag{Q21}
```

The cardinality bound is deliberately conservative. The finite mixture weights need not be given by a closed formula. Their existence follows from a finite continuous game, and the exact finite dictionary theorem in Sections 7–8 supplies a constructive certificate after price discretization. No global optimality of the refundable policy is asserted.

**Finite minimax justification.** The vector of payoffs of the finitely many continuous price bands, as the experiment varies over its compact convex feasible set, ranges over a compact convex subset of a Euclidean space. If every such vector has some coordinate at least $V$, this set is disjoint from the open orthant whose coordinates are all below $V$. A separating vector must be nonnegative because the orthant is unbounded downwards. Normalizing its coordinates to sum to one gives a single mixture with payoff at least $V$ at every experiment. This proves the finite minimax step used above without interchanging a discontinuous deterministic-price game by assumption. $\square$

**Corollary 6.2 (large-cost rate of this lower bound).** Whenever $dt/[8(t+c)]\le(t-R)/4$, the guaranteed increment in (Q20) is
```math
\frac{u}{2}=\frac{R d^2 t}{6656(t+c)^3\log(t/R)}.
```
For each fixed prior this provides a positive order-$c^{-3}$ lower bound at large finite cost. It is a guarantee from this construction, not the optimal asymptotic order. The exact binary theory [HK20] is stronger in its own special setting.


## 7. Exact sparse posterior certificates for finite dictionaries

Let $n$ valuation states be fixed, with any prior on their simplex, a cost $c\ge0$, $N_0$ non-returnable prices, and $N_1$ refundable prices sharing one positive refund $r$ off the valuation support. The refund prices satisfy $r\le p\le B$. This section does not need a positive zero atom: it is a finite-dictionary verification theorem, not a strict-improvement assertion.

Write $m(q)=\sum_jv_jq_j$, $w(q)=\sum_j\max(v_j,r)q_j$, and $l(q)=\sum_{v_j \lt r}q_j$. Non-returnable purchase hyperplanes have the form $m=p$; refundable purchase hyperplanes have the form $w=p$. Let $\mathcal V$ be all vertices of the closures of all faces of their arrangement in the posterior simplex, including boundary faces.

### 7.1. Sparse vertices and exact enumeration

Every vertex of this arrangement has at most three nonzero coordinates. On the relative interior of a support of size $s$, the simplex has dimension $s-1$. At most one hyperplane from each of the two parallel families can be active; hence the active rank is at most two. A vertex must have $s-1\le2$. Degenerate or coincident hyperplanes lower the rank and cannot create a larger-support vertex.

Enumerate all simplex vertices, all intersections of one threshold hyperplane with simplex edges, and all intersections of one threshold from each family with simplex triangles. Retain solutions lying in the simplex and deduplicate. Rank-deficient triples do not yield isolated three-support vertices; their edge/vertex endpoints are already included. The number of candidates is at most

```math
\#\mathcal V\le n+\binom n2(N_0+N_1)+\binom n3N_0N_1.\tag{S1}
```

All coordinates are rational if valuations, prices, and refund are rational.

### 7.2. Adverse ties and replacement by vertex experiments

For each offer $j$ let $f_j(q)$ be its expected profit: zero if strictly rejected; the appropriate affine profit if strictly purchased; and the minimum of zero and the affine purchase profit at buying indifference. For a lottery $w_j\ge0$, $\sum_j w_j=1$, put $f_w=\sum_j w_j f_j$.

Fix any relative open arrangement face $F$. The strict acceptance decisions are constant on $F$. Its tied offers contribute a minimum of two affine functions, so the function obtained by retaining these decisions and extending to the closed face is concave. Call this extension $F_w$. At any newly encountered boundary hyperplane the true worst-tie payoff is no larger than the corresponding one-sided payoff. Thus $f_w(v)\le F_w(v)$ at every vertex $v$ of the closed face.

For any $q\in F$ and a vertex decomposition $q=\sum_v\alpha_vv$,

```math
f_w(q)=F_w(q)\ge\sum_v\alpha_vF_w(v)\ge\sum_v\alpha_v f_w(v).\tag{S2}
```

Consequently an affine function $\lambda\cdot q$ is a global lower bound for $f_w$ on the whole posterior simplex if and only if it is such a lower bound at every $v\in\mathcal V$. Every posterior can be replaced by a lottery over $\mathcal V$ with the same mean and no larger payoff. A finite triangulation of each closed face gives a Borel choice of the weights; one can also obtain the equality of infima by convex-envelope duality without a measurable-selection shortcut.

It follows that the exact worst-case profit of this fixed policy, against all Borel Bayes-plausible experiments and all buying ties, is

```math
\min_{z_v\ge0}\sum_{v\in\mathcal V}z_v f_w(v)\quad\text{subject to}\quad\sum_{v\in\mathcal V}z_v v=\pi.\tag{S3}
```

The constraints imply $\sum_v z_v=1$. An extreme optimum uses at most $n$ positive $z_v$, since the $n$ barycenter equations have rank $n$ ($\mathcal V$ contains all simplex vertices). Thus a worst experiment can be chosen to have at most $n$ signal realizations, each pooling at most three valuation states.

## 8. Exact finite optimization and a terminating rational search

### 8.1. Exact finite optimization

For a fixed dictionary, its optimal robust lottery is exactly the value of the finite linear program

```math
\begin{aligned}\max_{w,\lambda}\quad&\lambda\cdot\pi\\\text{subject to}\quad&w_j\ge0,\quad\sum_jw_j=1,\\&\lambda\cdot v\le\sum_jw_jf_j(v)\quad(v\in\mathcal V).\end{aligned}\tag{S4}
```

This follows from finite LP duality, or the finite zero-sum game between lotteries $w$ and feasible barycenter mixtures $z$. For rational inputs there are rational optimal primal and dual solutions. An independent verifier need only regenerate $\mathcal V$, evaluate the finite payoffs with exact fractions, check all inequalities, and compare $\lambda\cdot\pi$ against a certified upper bound for the no-return benchmark $R$.

The guarantee is exact for the specified finite dictionary; it does not assert that the dictionary is globally optimal among all refundable mechanisms. Ordinary hyperplane arrangements, concavity, and LP duality are established methods. The application supplies a sparse all-posterior certificate and a practical companion to the arbitrary-finite-cost strict-improvement theorem.

### 8.2. Rational-instance search

For termination, assume the rational-input subclass of the main theorem: finitely many rational valuations with a positive atom at zero and at least one positive valuation, positive rational prior masses, and a finite rational cost $c\ge0$. The exact finite-dictionary LP of Section 8.1 remains valid for arbitrary priors; only the strict-improvement search in this subsection requires the zero atom.

Enumerate rational refund levels strictly between valuation points, rational prices, and finite dictionaries in a fair order. For each dictionary solve the finite LP and verify a rational optimal solution. Retain the best certified lower value and its policy found so far. Independently refine rational upper enclosures of $R$ from monotone root bisection and rigorous logarithm bounds at every enumeration step. Stop when the retained lower certificate exceeds the current upper enclosure.

The quantitative improvement theorem ensures termination. Its continuous-price strategy has a strict uniform margin. Refunds and nondegenerate price-band endpoints can first be approximated rationally without crossing a valuation, uniformly in $q$ because the smoothed payoff is jointly continuous on a compact parameter neighborhood. Mixture weights can likewise be approximated rationally using boundedness. A sufficiently fine rational midpoint discretization then preserves a strict margin, even under adverse buying ties. That rational dictionary eventually appears, and LP duality supplies a rational minorant with value above $R$. The best-value record retains this certificate, and the converging root upper enclosures eventually certify the strict inequality.

No runtime bound or practical efficiency of this exhaustive search is asserted. The fixed-dictionary vertex count is polynomial for a single positive refund layer; this does not make the unrestricted search polynomial.

## 9. A rational three-valuation certificate

The reproducible instance is
```math
(v_0,v_1,v_2)=(0,1/2,1),\qquad
\pi=(1/4,1/2,1/4),\qquad c=1.
```
The active contact is $t=1/2$, with
```math
R(1+\log((1/2)/R))=3/8,
\qquad
0.191201784801 \lt R<0.191201784802.
\tag{E1}
```
The other support root is strictly smaller. The formula (Q1) has $d=1/2$, $\delta=1/48$, and gives approximately $u/2=1.10679\times10^{-6}$. These decimal values are explanatory approximations.

A numerically optimized finite dictionary gives a stronger instance-specific certificate. Its positive refund is exactly $49/100$. The selected lottery contains 618 positive-weight offers, of which 615 are non-returnable and three offer this refund. The three refundable sale prices are $497/1000$, $249/500$, and $499/1000$. All weights, prices, and the affine minorant in `results/certificate.json` are rational. The probabilities sum exactly to one.

There are exactly 2488 relevant posterior vertices for this selected dictionary. The exact verifier checks the inequality (S4) at every vertex, including adverse purchasing ties. It certifies
```math
\inf_{\tau,\,\text{buying ties}}\mathbb E_\tau f_w(Q)
\ \ge\ \lambda\cdot\pi
\ =\frac{670161140300775455274053}{3499999999972000000000000}
\ >\frac{19147}{100000}.
\tag{E2}
```
In particular, using the coarser certified bound $R<95601/500000$, the improvement is strictly greater than $67/250000$. This is a global certificate for the specified finite dictionary, not a simulation or a claim that this dictionary attains the unrestricted optimum.

One verification implementation generates vertices from supports of size at most three. A separate implementation works in the two free posterior coordinates and intersects all pairs of simplex-edge and purchase lines. The separate implementation independently regenerated 2,488 vertices and verified every certificate inequality, with its vertex count agreeing with the first implementation; it includes negative-profit purchase ties. Logarithm bounds use rational series, and the final verification requires no numerical optimizer. Floating-point linear programming was used only to discover the candidate weights before rationalization and exact rechecking. The arithmetic certificate supports this one example; the general theorem is proved analytically.

## 10. Boundary conditions and limitations

**Proposition 10.1 (a positive lower bound can eliminate all improvement).** If values are $1,2,3$ with probabilities $3/4,1/8,1/8$, the supremal guaranteed revenue of both non-returnable randomized pricing and refundable single-offer lotteries equals 1 for every $c\ge0$.

**Proof.** Prices tending to 1 from below guarantee revenues tending to 1 under every information structure. For the reverse bound, let the experiment fully reveal the valuation. For any ordinary refund offer with $r\le p$, a type with $v \lt p$ either strictly rejects or is indifferent at a full refund. At such indifference the adversary can reject; buying and returning would in any case give the seller nonpositive profit if $p=r$. Any type that strictly buys and keeps has $v\ge p$. Thus the revenue is at most the ordinary full-information monopoly revenue $\sup_p p\Pr(V\ge p)=1$. Randomizing offers cannot raise this bound. $\square$

The example shows that the zero-atom assumption cannot simply be dropped from the universal strict-improvement assertion. It is not a classification of all positive-floor priors. The theorem concerns a known valuation prior, risk neutrality, costless information for the buyer conditional on the signal, full learning after purchase, zero production cost, and one buyer. It allows arbitrary signals within those primitives. It does not allow the adversary to observe and condition its information experiment on the seller's independent realized random price.

The price-count bound and the quantitative increment are conservative. The fixed-dictionary LP is exact; exhaustive search over dictionaries is not claimed efficient. A policy may lose money at individual posteriors, although its expected guarantee over every Bayes-plausible experiment is positive. We therefore do not claim the separate pointwise-nonnegative-refund suggestion in [HK20], nor its distinct hidden-group conjecture.

The literature verification is limited by access to [W25]'s final published full text. We compared its complete 2024 author manuscript, including the positive-cost discussion, and the formal 2025 metadata and abstract. No global-priority or external-publication-quality certification is asserted.

## Appendix A. Finite-target martingale realization

We give the standard realization fact used in Section 2, retaining its classical convex-order attribution [S65]. Suppose $\nu$ is a probability law on $[0,B]$, with the same mean as the finite prior $\pi$, and
```math
\int(x-y)_+\,d\nu(y)\le\sum_i\pi_i(x-v_i)_+\quad\text{for every }x.
\tag{A1}
```
Then a feasible posterior experiment exists whose mean has law $\nu$.

First, (A1) and equality of means imply $\int\phi\,d\nu\le\sum_i\pi_i\phi(v_i)$ for every continuous convex $\phi$ on $[0,B]$. One proves this first for convex piecewise-linear functions, which are an affine function plus nonnegative combinations of hinge functions, and then uses uniform polygonal approximation.

Let $\Gamma$ be the set of probability measures on $[0,B]\times\{v_0,\ldots,v_k\}$ whose first marginal is $\nu$ and for which
```math
\int f(y)(v-y)\,d\gamma(y,v)=0\quad\text{for every continuous }f.
\tag{A2}
```
This set is nonempty: conditional on $y$, mix values 0 and $B$ with probabilities $1-y/B$ and $y/B$. It is convex and weakly compact because the underlying space is compact and the displayed constraints are closed. Its set $C$ of second marginals is therefore a compact convex subset of the finite simplex.

For any real cost vector $a=(a_i)$, let $\underline a(y)$ be the minimum of $\sum_i a_iq_i$ over $q$ in the simplex with $\sum_i v_iq_i=y$. It is the lower convex polygonal envelope of the points $(v_i,a_i)$. An optimizing mixture uses at most two states on each of its finitely many linear pieces; a measurable choice is obtained by choosing one minimizing edge on each piece. Hence
```math
\min_{\rho\in C}a\cdot\rho=\int\underline a(y)\,d\nu(y)
\le\sum_i\pi_i\underline a(v_i)\le a\cdot\pi.
\tag{A3}
```
If $\pi\notin C$, finite-dimensional strict separation would give some $a$ with $a\cdot\pi<\min_{\rho\in C}a\cdot\rho$, a contradiction. Choose $\gamma\in\Gamma$ with second marginal $\pi$. The component measures $\gamma_i(dy)=\gamma(dy,\{v_i\})$ are dominated by $\nu$; their Radon--Nikodym densities $q_i(y)$ sum to one. Equation (A2), by uniqueness of finite measures from continuous test functions, implies $\sum_i v_iq_i(y)=y$ almost surely. Their means are $\pi_i$, so the law of the posterior vector $q(y)$ is the required experiment. $\square$

## References and checked versions

- **[HK20]** T. Hinnosaar and K. Kawai. *Robust Pricing with Refunds*. RAND Journal of Economics 51(4), 1014--1036 (2020). [DOI 10.1111/1756-2171.12348](https://doi.org/10.1111/1756-2171.12348). Complete author version dated 14 April 2020: [arXiv:1808.02233](https://arxiv.org/pdf/1808.02233). The non-binary discussion motivates the present finite-support direction; the hidden-group conjecture is not addressed.
- **[RS17]** A.-K. Roesler and B. Szentes. *Buyer-Optimal Learning and Monopoly Pricing*. American Economic Review 107(7), 2072--2080 (2017). [DOI 10.1257/aer.20160145](https://doi.org/10.1257/aer.20160145). Source of the buyer-optimal/equal-revenue benchmark.
- **[D18]** S. Du. *Robust Mechanisms Under Common Valuation*. Econometrica 86(5), 1569--1588 (2018). [DOI 10.3982/ECTA14993](https://doi.org/10.3982/ECTA14993). [Complete published PDF](https://econweb.ucsd.edu/~sodu/robust.pdf), especially Section 5 and Proposition 1. The no-return robust guarantee and contact-based random-pricing construction are prior results.
- **[W25]** J. von Wangenheim. *Optimal Information Design of Online Marketplaces with Return Rights*. Journal of Political Economy 133(9), 3019--3043 (2025). [DOI 10.1086/736214](https://doi.org/10.1086/736214). Formal metadata and abstract checked; complete text checked only in the [11 March 2024 author manuscript](https://www.crctr224.de/research/discussion-papers/archive/dp352/@@download/file/CRCTR224_2022_352v2.pdf), including Sections 2 and 5.1. In that paper production cost is denoted $c$ and return cost $\gamma$; our $c$ is the return cost.
- **[ACHMM25]** S. Alaei, S. Chawla, Z. Huang, A. Makhdoumi, and A. Malekian. *Deterministic Refund Mechanisms*. SAGT 2025, 363--380. [DOI 10.1007/978-3-032-03639-1_20](https://doi.org/10.1007/978-3-032-03639-1_20). Complete checked preprint: [arXiv:2507.04148](https://arxiv.org/pdf/2507.04148). Known-type/FOSD mechanism optimization; not the unknown-information ambiguity class here.
- **[L26]** Q. Lyu. *Optimal Refund Mechanism With Consumer Learning*. RAND Journal of Economics 57(1), 205--224 (2026). [DOI 10.1111/1756-2171.70046](https://doi.org/10.1111/1756-2171.70046). Complete checked author version dated 1 September 2025: [author PDF](https://www.qianjunlyu.com/uploads/1/2/2/7/122704715/optimal_refund_mechanism_with_consumer_learning.pdf). Costly endogenous Poisson learning with binary values.
- **[S65]** V. Strassen. *The Existence of Probability Measures with Given Marginals*. Annals of Mathematical Statistics 36(2), 423--439 (1965). [DOI 10.1214/aoms/1177700153](https://doi.org/10.1214/aoms/1177700153). Classical attribution for martingale/convex-order coupling; Appendix A gives the finite-target argument used here.
