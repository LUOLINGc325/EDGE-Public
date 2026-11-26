---
title: "Universal convex-order bounds for coalescent tree lengths and exact merger-cost criteria"
author: "Collaborative research manuscript"
date: "26 November 2026"
---

# Abstract

Let $L_n^\Xi$ be the total tree length of the $n$-sample, time-homogeneous $\Xi$-coalescent, normalized so that each pair of ancestral blocks merges at rate one. We prove the sharp comparison
$$
L_n^{\mathrm K}\ \le_{\mathrm{icx}}\ L_n^\Xi\ \le_{\mathrm{icx}}\ nE,
\qquad E\sim\operatorname{Exp}(1),
$$
for every characteristic probability measure $\Xi$ on the infinite simplex and every finite $n\ge2$. Here $\le_{\mathrm{icx}}$ denotes increasing convex order and $L_n^{\mathrm K}$ is Kingman's total tree length. Thus the comparison holds simultaneously for every stop-loss threshold and every increasing convex loss, including when disjoint groups merge simultaneously. Its mean specialization for $\Lambda$-coalescents proves the finite-sample extremality statement formulated by Der and Plotkin. The stronger comparison gives sharp bounds for moments of every real order at least one and for mutation counts on a fully linked genealogy. Within the $\Lambda$ subclass, equality of a positive-threshold stop-loss transform identifies the corresponding extremal measure when $n\ge3$.

The main additional ingredient is a harmonic occupancy inequality for every paintbox, obtained from a convex-order comparison for random circular differences. An arc-mass variance identity gives a nonnegative-square certificate for that comparison. We also characterize exactly the state costs for which the same two extremal mechanisms bound all finite chains under a pair-merger budget, both with single merging groups and with arbitrary simultaneous partitions. These conditions are finite linear systems in the cost vector, and failure produces an explicit mean counterexample. For costs $c_b=b^\alpha$, the sharp two-sided threshold changes from $\alpha=1$ for single groups to $\alpha=\log 2/\log(4/3)$ for arbitrary simultaneous partitions. A four-sample counterexample explains why the ordinary tree-length theorem requires stronger structure than normalized pair rates and consistency only through a fixed sample size.

# 1. Scope and relation to earlier work

The $\Lambda$-coalescent permits any number of ancestral blocks to merge into one, while two disjoint merging groups do not merge simultaneously [P99]. Its finite-sample rates, its consistency as the sample changes, and its relation to population models are established parts of coalescent theory. We use these rates without claiming a new construction of the process.

Der and Plotkin [DP14] studied equilibrium diversity under reproductive skew. Their recursion for expected diversity, pure-measure formulas and asymptotic results led them to conjecture that the Wright-Fisher and star models minimize and maximize diversity for every finite sample size. The explicit finite-sample conjecture appears on PDF pages 14--15 of their author manuscript [DP13]; the numbering differs from the journal version. We address the probability-measure normalization used there. Existing formulas for four-sample diversity are not new results of this paper.

The contribution proved here is a comparison of the entire family of stop-loss transforms for every normalized $\Xi$-coalescent, together with exact cost criteria in two larger finite rate-budget classes. The $\Xi$ construction and its paintbox representation are due to earlier work [S00]; we use them without claiming a new characterization of exchangeable coalescents. The comparison implies the finite-sample mean bounds, but mean bounds alone do not imply the stronger statement. The harmonic occupancy estimate and its random circular representation supply the additional constraint that arbitrary finite simultaneous partitions lack.

Earlier work gives asymptotic sampling formulas and limits for tree lengths [BBL14, K12, DK19]. General expected site-frequency-spectrum recursions and inference questions are treated in [BBE13, SKS16]. These works concern different questions from a uniform finite-sample order comparison. Our argument does not replace their asymptotic or inferential results. The exponential-maximum representation of Kingman's total length is classical [DDS08]; the comparison with other merger mechanisms, rather than this representation, is the result at issue here.

Generator and positive-semigroup comparison are classical tools [M87]. Phase-type extremality has also been studied under other constraints, including fixed order and mean [OC91] and restrictions on generator column sums [HZV13]. Control of remaining absorption times is a classical route to exponential bounds [FK06]. The present cost criteria specify when these mechanisms apply under a row-wise pair budget; the contribution is not the general semigroup identity or exponential comparison principle. The full text of [OC91] was not available in the literature check, so exclusion of every result in that paper is not claimed.

The circular arc-variance identity used below is an elementary instance of discrepancy--intersection-energy identities associated with Stolarsky invariance; see the fixed-cap comparison in [HBZO19, Theorem 3]. We prove the exact weighted circle form needed here. The additional bridge is the random cyclic representation of the paintbox measure in (7.5), followed by the missing-mass recursion and the coalescent comparison; novelty of the general discrepancy identity is not claimed.

The literature check found no equivalent theorem in the sources and searches described with this manuscript. This is a bounded literature check, not a proof of priority. In particular, the full proof of every result in the broader coalescent and stochastic-comparison literature has not been checked. This manuscript has not undergone external peer review. Its arguments are written mathematical proofs; they have not been checked by a proof assistant.

# 2. Finite chains and cumulative costs

Fix an integer $N\ge2$. At state $b\in\{2,\ldots,N\}$, let a pure-death chain jump to $b-k+1$ at rate $q_{b,k}\ge0$, for $2\le k\le b$. State $1$ is absorbing. We impose the rate budget
$$
\sum_{k=2}^{b}\binom{k}{2}q_{b,k}=\binom{b}{2}. \tag{2.1}
$$
Write $\mathcal Q_N$ for the class of all such arrays. The arrays at different states need not come from one measure or satisfy sampling consistency. In particular, (2.1) describes a class of block-count chains, not a characterization of all exchangeable coalescents.

Let $q_b=\sum_kq_{b,k}$. Since $1\le\binom{k}{2}\le\binom b2$, (2.1) gives
$$
1\le q_b\le\binom b2. \tag{2.2}
$$
For costs $c_1=0$ and $c_b>0$ for $2\le b\le N$, define
$$
T_b^q(c)=\int_0^\tau c_{B_t}\,dt,
\qquad \tau=\inf\{t:B_t=1\},\quad B_0=b. \tag{2.3}
$$
There are at most $b-1$ jumps before absorption. Each visited state's waiting time is exponential with a positive finite rate, so $T_b^q(c)$ has finite moments of every positive order.

Two arrays will be used repeatedly. The binary array, denoted $\mathrm K$, has $q^{\mathrm K}_{b,2}=\binom b2$ and all other rates zero. The star array, denoted $\star$, has $q^\star_{b,b}=1$ and all other rates zero. Consequently
$$
T_b^{\mathrm K}(c)\ \overset d=\ \sum_{j=2}^{b}a_jE_j,
\qquad a_j=\frac{c_j}{\binom j2},
\qquad T_b^\star(c)\ \overset d=\ c_bE, \tag{2.4}
$$
where the $E_j$ and $E$ have the unit exponential law and the $E_j$ are independent. Put $h_1=0$ and $h_b=\sum_{j=2}^ba_j$.

For integrable nonnegative $X,Y$, increasing convex order can be expressed as
$$
X\le_{\mathrm{icx}}Y
\quad\Longleftrightarrow\quad
\mathbb E(X-s)_+\le\mathbb E(Y-s)_+
\quad\text{for every }s\ge0. \tag{2.5}
$$
It is equivalently the comparison of expectations for every increasing convex function for which the expectations exist, with the usual extended nonnegative interpretation. To see why the stop-loss functions suffice, an increasing convex function on $[0,\infty)$ has a nonnegative linear part and a nonnegative integral of $(x-s)_+$; the linear part is covered by $s=0$. Additive constants cancel.

## 2.1. The clock of accumulated cost

Changing from physical time to accumulated-cost time divides every rate at state $b$ by $c_b$. On the transient states $2,\ldots,N$, the resulting matrix is
$$
A^q_{b,b}=-q_b/c_b,
\qquad
A^q_{b,m}=q_{b,b-m+1}/c_b\quad(2\le m\lt b). \tag{2.6}
$$
The omitted transition to $1$ is killing. The lifetime of this killed chain, starting at $b$, has law $T_b^q(c)$.

All off-diagonal entries of $A^q$ are nonnegative. For a sufficiently large $r$, $A^q+rI$ is entrywise nonnegative; its exponential series shows that $e^{tA^q}$ is entrywise nonnegative for $t\ge0$. Let $v_b^q=\mathbb ET_b^q(c)$, let $\mathbf1$ be the vector of ones on transient states, and define
$$
W_b^q(s)=\mathbb E(T_b^q(c)-s)_+.
$$
The first-jump recurrence and the Markov property give
$$
(-A^q)v^q=\mathbf1,
\qquad W^q(s)=e^{sA^q}v^q,
\qquad S^q(s)=e^{sA^q}\mathbf1,
\qquad (W^q)'(s)=-S^q(s). \tag{2.7}
$$
Here $S_b^q(s)=\mathbb P(T_b^q(c)>s)$. These identities can also be checked by conditioning on the state occupied at cost-time $s$. In particular, no infinite-state interchange or asymptotic approximation is used below.

# 3. Exact conditions for universal cost comparisons

For $2\le b\le N$ and $2\le k\le b$, define the lower condition
$$
h_b-h_{b-k+1}\le\binom k2a_b. \tag{L}
$$
For $1\le m\lt b\le N$, define the upper condition
$$
c_m\le c_b\left(1-\frac{\binom{b-m+1}{2}}{\binom b2}\right). \tag{U}
$$
Each displayed family consists of linear inequalities in $c_2,\ldots,c_N$. Condition (U) at $m=1$ is the identity $0\le0$.

**Theorem 3.1 (lower comparison).** The following statements are equivalent:

1. Condition (L) holds for every indicated $b,k$.
2. For every $q\in\mathcal Q_N$ and every starting state $b\le N$,
   $$T_b^{\mathrm K}(c)\le_{\mathrm{icx}}T_b^q(c).$$
3. For every $q\in\mathcal Q_N$ and every starting state $b\le N$, $h_b\le v_b^q$.

**Theorem 3.2 (upper and two-sided comparisons).** The following statements are equivalent:

1. Condition (U) holds for every indicated $b,m$.
2. For every $q\in\mathcal Q_N$ and every starting state $b\le N$,
   $$T_b^q(c)\le_{\mathrm{icx}}c_bE.$$
3. For every $q\in\mathcal Q_N$ and every starting state $b\le N$, $v_b^q\le c_b$.
4. For every $q\in\mathcal Q_N$ and every starting state $b\le N$,
   $$T_b^{\mathrm K}(c)\le_{\mathrm{icx}}T_b^q(c)\le_{\mathrm{icx}}c_bE.$$

Whenever (U) holds, the following stronger upper estimate also holds:
$$
W_b^q(s)\le v_b^q\exp(-s/c_b),\qquad s\ge0. \tag{3.1}
$$

The quantifiers over all starting states are essential to these equivalences. No necessity is asserted for a single prescribed measure $\Lambda$, a single initial state alone, or the smaller class of sampling-consistent models.

## 3.1. Proof of Theorem 3.1

Assume (L). The first-jump recurrence is
$$
q_bv_b^q=c_b+\sum_{k=2}^bq_{b,k}v_{b-k+1}^q,
\qquad v_1^q=0. \tag{3.2}
$$
Inductively assume $v_m^q\ge h_m$ for $m\lt b$. Subtracting $q_bh_b$ from (3.2) gives
$$
q_b(v_b^q-h_b)
=c_b-\sum_kq_{b,k}(h_b-h_{b-k+1})
  +\sum_kq_{b,k}(v_{b-k+1}^q-h_{b-k+1})\ge0, \tag{3.3}
$$
because the first sum is at most $a_b\binom b2=c_b$. This proves the mean comparison.

Let
$$
f_b(s)=\mathbb E(T_b^{\mathrm K}(c)-s)_+,
\qquad u_b(s)=\mathbb P(T_b^{\mathrm K}(c)>s),
\qquad f_1(s)=0.
$$
The binary chain has cost-time jump rate $1/a_b$, so (2.7) gives
$$
f_b(s)-f_{b-1}(s)=a_bu_b(s). \tag{3.4}
$$
The representation (2.4) couples $T_j^{\mathrm K}(c)\le T_b^{\mathrm K}(c)$ when $j\le b$. Therefore $u_j(s)\le u_b(s)$. For $m=b-k+1$,
$$
f_b(s)-f_m(s)
=\sum_{j=m+1}^ba_ju_j(s)
\le u_b(s)(h_b-h_m)
\le\binom k2a_bu_b(s). \tag{3.5}
$$
It follows from (2.1) that
$$
(A^qf(s))_b
=-\frac1{c_b}\sum_kq_{b,k}(f_b(s)-f_{b-k+1}(s))
\ge-u_b(s)=f'_b(s). \tag{3.6}
$$
The vector $d(s)=A^qf(s)-f'(s)$ is thus nonnegative. Variation of constants yields the exact identity
$$
W^q(s)-f(s)
=e^{sA^q}(v^q-h)
 +\int_0^se^{(s-t)A^q}d(t)\,dt. \tag{3.7}
$$
Both terms are entrywise nonnegative by (3.3) and positivity of the semigroup. Equation (2.5) proves the increasing-convex comparison.

Conversely, increasing convex order implies comparison of the means. If (L) fails at $(b,k)$, choose an array with the sole outgoing jump at state $b$ equal to the $k$-merger, at rate $\binom b2/\binom k2$, and choose binary rates at every other state. Starting at $b$, its expected cost is
$$
\binom k2a_b+h_{b-k+1}\lt h_b. \tag{3.8}
$$
This array satisfies (2.1) and disproves the universal mean comparison. All three statements are equivalent.

## 3.2. Proof of Theorem 3.2

Assume (U). It says exactly that
$$
c_b-c_{b-k+1}\ge\frac{\binom k2}{\binom b2}c_b.
$$
Using (3.2), induction on $b$ now proves $v_b^q\le c_b$. Moreover, (U) implies $c_m\lt c_b$ for $2\le m\lt b$, while $c_1=0$. At cost-time $s$, conditional on survival and on occupying a state $m\le b$, the remaining expected cost is $v_m^q\le c_m\le c_b$. Hence
$$
W_b^q(s)\le c_bS_b^q(s).
$$
Together with (2.7), this gives
$$
(W_b^q)'(s)\le-W_b^q(s)/c_b.
$$
Multiplying by $e^{s/c_b}$ and integrating proves (3.1), which is at most $c_be^{-s/c_b}=\mathbb E(c_bE-s)_+$. This proves the upper order.

For necessity, if (U) fails at $(b,m)$, set $k=b-m+1$, use the sole $k$-merger at state $b$ with rate $\binom b2/\binom k2$, and use star rates at every other state. Then
$$
v_b^q=\frac{\binom k2}{\binom b2}c_b+c_m>c_b. \tag{3.9}
$$
Thus the mean, and consequently the increasing-convex comparison, fails.

It remains to show that (U) implies (L). Set $j=b-r+1\ge2$, where $1\le r\le b-1$. The case $r=1$ is an identity. For $r>1$, apply (U) with $m=j$ to obtain
$$
\frac{a_j}{a_b}
\le\frac{b(b-1)-r(r-1)}{j(j-1)}
=\frac{2b}{j}-1
\le r. \tag{3.10}
$$
The last inequality is equivalent to $(r-1)(j-2)\ge0$, using $b=r+j-1$. Summing (3.10) for $r=1,\ldots,k-1$ gives (L). Theorem 3.1 supplies the lower comparison, completing all equivalences.

## 3.3. A sufficient cost class and sharp failures

**Corollary 3.3.** If $c_b/b$ is nondecreasing for $b\ge2$, then (U) holds. In particular, for every $\alpha\ge1$, costs $c_b=b^\alpha$ satisfy both comparisons for every finite $N$.

For $2\le m\lt b$, the hypothesis gives $c_m/c_b\le m/b$. With $k=b-m+1\le b-1$,
$$
1-\frac mb=\frac{k-1}{b}
\ge\frac{k(k-1)}{b(b-1)},
$$
which proves (U); $m=1$ is separate and exact. The condition is sufficient, not necessary. For example, $(c_2,c_3,c_4)=(2,4,5)$ satisfies (U), although $c_3/3>c_4/4$.

The power threshold is sharp once state $3$ is included. For $\alpha\lt 1$,
$$
\mathbb ET_3^{\mathrm K}(c)=2^\alpha+3^\alpha/3>3^\alpha
=\mathbb ET_3^\star(c). \tag{3.11}
$$
Thus neither proposed direction can hold universally for that power family. No assertion about state costs under changing population size is implied.

The lower condition is strictly weaker than the upper condition. At $N=4$, the vector $(2,3,37/10)$ satisfies (L) but violates (U) at $(b,m)=(4,2)$. The array $q_{4,3}=2$, $q_{2,2}=1$ produces
$$
v_4=\frac{37}{20}+2=\frac{77}{20}>\frac{37}{10}.
$$
Unspecified states may use binary or star rates. This is an admissible rate-budget chain; it is not presented as a sampling-consistent $\Lambda$- or $\Xi$-coalescent.

# 4. Total tree length of a $\Lambda$-coalescent

Let $\Lambda$ be a probability measure on $[0,1]$. Its block-count transition rates are
$$
q^\Lambda_{b,k}=\binom bk\int_0^1x^{k-2}(1-x)^{b-k}\,\Lambda(dx),
\qquad 2\le k\le b. \tag{4.1}
$$
The integrands are polynomials with their continuous endpoint values; in particular the $x=0$ contribution is nonzero only for $k=2$. The elementary identity
$$
\binom bk\binom k2=\binom b2\binom{b-2}{k-2}
$$
and the binomial theorem show that (4.1) satisfies (2.1). We take $c_b=b$ for $b\ge2$ and $c_1=0$. Then (2.3) is total tree length, denoted $L_b^\Lambda$. The two endpoint measures $\delta_0$ and $\delta_1$ give the binary and star arrays respectively.

**Theorem 4.1 (sharp tree-length envelope).** For every $n\ge2$ and every probability measure $\Lambda$ on $[0,1]$,
$$
L_n^{\mathrm K}\le_{\mathrm{icx}}L_n^\Lambda\le_{\mathrm{icx}}nE. \tag{4.2}
$$
Writing $v_n=\mathbb EL_n^\Lambda$, the explicit stop-loss form is
$$
2\int_0^{e^{-s/2}}\frac{1-(1-u)^{n-1}}u\,du
\ \le\ \mathbb E(L_n^\Lambda-s)_+
\ \le\ v_ne^{-s/n}\ \le\ ne^{-s/n},\qquad s\ge0. \tag{4.3}
$$
In particular,
$$
2H_{n-1}\le v_n\le n. \tag{4.4}
$$
The two endpoint laws attain the corresponding extremes simultaneously for all thresholds.

The order and the upper estimates follow immediately from Corollary 3.3. To obtain the explicit lower transform, (2.4) gives
$$
L_n^{\mathrm K}\overset d=2\sum_{j=1}^{n-1}E_j/j
\overset d=2\max_{1\le j\le n-1}E_j. \tag{4.5}
$$
For completeness, the ordered values of $m$ independent exponentials of rate $1/2$ have independent successive spacings of rates $m/2,(m-1)/2,\ldots,1/2$. This follows by writing their joint density on the ordered region in terms of spacings: its exponential factor separates, and the normalizing factors are exactly these rates. The maximum is their sum, proving (4.5) with $m=n-1$. Therefore
$$
\mathbb P(L_n^{\mathrm K}>t)=1-(1-e^{-t/2})^{n-1}.
$$
Integrating this tail from $s$ to infinity and substituting $u=e^{-t/2}$ yields (4.3). At $s=0$, the geometric sum $(1-(1-u)^{n-1})/u$ integrates to $H_{n-1}$.

## 4.1. Equality and boundary cases

For $n=2$, all normalized measures give $L_2\overset d=2E$. For $n=3$, all measures have mean $3$; this does not imply equality of distributions.

**Proposition 4.2.** Fix $n\ge3$ and $s>0$. Equality in the first inequality of (4.3) holds if and only if $\Lambda=\delta_0$. Equality with the last expression $ne^{-s/n}$ holds if and only if $\Lambda=\delta_1$. For $n\ge4$, equality in the respective mean bounds (4.4) has the same characterization.

Here are the strictness arguments. For the lower transform, put $w=1-e^{-s/2}\in(0,1)$. Adjacent differences of the binary transform are
$$
d_j(s)=f_{j+1}(s)-f_j(s)=\frac{2(1-w^j)}j.
$$
For $r\ge2$ and $j=b-r\lt b-1$, both $1-w^j\lt 1-w^{b-1}$ and $r(b-r)\ge b-1$ hold. Thus $d_{b-r}(s)\lt r\,d_{b-1}(s)$. Every jump with $k\ge3$ makes the corresponding loss comparison strict. If $\Lambda\ne\delta_0$, then $q^\Lambda_{n,n}=\int x^{n-2}\Lambda(dx)>0$. Consequently the initial-state component of $d(t)$ in (3.7) is positive for every $t>0$. The diagonal semigroup entry is $e^{-q_n(s-t)/n}>0$, so the integral in (3.7) is strictly positive for every $s>0$.

At threshold zero, $d_j(0)=2/j$. For $b\ge4$, the inequality at $r=2$ is strict because $2(b-2)>b-1$. A positive $n$-merger rate therefore makes the mean lower bound strict when $n\ge4$.

For the upper transform, if $\Lambda\ne\delta_1$, then $q^\Lambda_{n,2}=\binom n2\int(1-x)^{n-2}\Lambda(dx)>0$. There is positive probability, at every positive cost-time, of being in state $n-1$ after one jump and before the next. Its remaining expected tree length is at most $n-1\lt n$. Hence $W_n(s)\lt nS_n(s)$ for $s>0$, and integrating the differential inequality gives $W_n(s)\lt v_ne^{-s/n}\le ne^{-s/n}$. For $n\ge4$, a binary jump makes $n-(n-1)=1>2/(n-1)$ in the upper drift inequality, so the mean upper bound is strict as well. The endpoint measures attain equality by construction.

## 4.2. Increasing convex order is not ordinary stochastic order

At $n=3$, the two extremal survival functions are
$$
\mathbb P(L_3^{\mathrm K}>s)=2e^{-s/2}-e^{-s},
\qquad
\mathbb P(L_3^\star>s)=e^{-s/3}. \tag{4.6}
$$
Near zero the binary survival is larger, while for sufficiently large $s$ the star survival is larger. Thus neither law stochastically dominates the other. Their means are both $3$, and their variances are $5$ and $9$. For $n\ge4$, the different endpoint means also preclude replacing increasing convex order by ordinary convex order, which requires equal means. We do not claim that variance is minimized by Kingman merely from (4.2).

# 5. Moments, exponential costs, and mutation counts

For every real $p\ge1$, Theorem 4.1 gives the sharp moment bounds
$$
2^p\Gamma(p+1)\sum_{j=1}^{n-1}(-1)^{j+1}\binom{n-1}{j}j^{-p}
\ \le\ \mathbb E(L_n^\Lambda)^p
\ \le\ n^p\Gamma(p+1). \tag{5.1}
$$
For $p>1$, a useful mean-dependent refinement is
$$
\mathbb E(L_n^\Lambda)^p\le\Gamma(p+1)v_nn^{p-1}. \tag{5.2}
$$
To prove (5.1), expand the binary survival function and integrate $pt^{p-1}$ times that tail. The finite sum causes no interchange issue. For (5.2), apply
$$
\mathbb EX^p=p(p-1)\int_0^\infty s^{p-2}\mathbb E(X-s)_+\,ds
$$
to (4.3); this identity follows from integrating the pointwise identity for $x^p$ and using nonnegativity. At $p=1$, the mean is simply $v_n$.

In particular $\mathbb EL_n^2\le2nv_n$ and $\operatorname{Var}(L_n)\le2nv_n-v_n^2\le n^2$. The final variance upper bound is attained by the star model. It is an upper bound, not a variance ordering for the full family.

For $0\le t\lt 1/n$, comparison with the increasing convex function $e^{tx}$ gives
$$
\prod_{j=1}^{n-1}(1-2t/j)^{-1}
\ \le\ \mathbb E e^{tL_n^\Lambda}
\ \le\ (1-nt)^{-1}. \tag{5.3}
$$
The interval $t\lt 1/n$ is the largest nonnegative interval on which a finite uniform upper bound over all $\Lambda$ is possible, because the star moment-generating function diverges at and beyond $1/n$.

## 5.1. Mutation counts on a linked genealogy

Fix a scaled mutation intensity $\theta\ge0$. In the infinite-sites model on a single fully linked genealogy, define
$$
M_n^\Lambda\mid L_n^\Lambda\sim\operatorname{Poisson}(\theta L_n^\Lambda/2). \tag{5.4}
$$
This is a mixed Poisson count after averaging over genealogies. It is distinct from the independent-site/free-recombination construction in [DP14], which has a Poisson limit with deterministic mean. The expectation bridge $\mathbb EM_n=\theta\mathbb EL_n/2$ is common to the two settings; their count distributions must not be identified.

**Corollary 5.1.** Under (5.4),
$$
\sum_{j=1}^{n-1}G_j\ \le_{\mathrm{icx}}\ M_n^\Lambda
\ \le_{\mathrm{icx}}\ G_\star, \tag{5.5}
$$
where $G_j$ are independent geometric random variables on $\{0,1,\ldots\}$ with means $\theta/j$, and $G_\star$ is geometric on the same support with mean $n\theta/2$.

For the integer stop-loss function $\phi_k(j)=(j-k)_+$, $k\ge0$, set $g_k(\lambda)=\mathbb E\phi_k(\operatorname{Poisson}(\lambda))$. These functions grow at most linearly, and their bounded first and second differences justify differentiation of the Poisson series on compact intervals. It gives
$$
g_k'(\lambda)=\mathbb E\Delta\phi_k(\operatorname{Poisson}(\lambda))\ge0,
\qquad
g_k''(\lambda)=\mathbb E\Delta^2\phi_k(\operatorname{Poisson}(\lambda))\ge0. \tag{5.6}
$$
It is enough to use these at integer thresholds, since the stop-loss transform of an integer-valued variable is linear between consecutive integers. Thus the Poisson mixing kernel preserves increasing convex order. Applying it to (4.2) proves (5.5). Mixing a Poisson mean with an exponential variable gives a geometric variable: its probability-generating function is $(1+\mu(1-z))^{-1}$ when the mixed mean has expectation $\mu$. Independent exponential cost intervals in (4.5) give the independent geometric summands.

Both ends of (5.5) are attained by the corresponding coalescent measures. This is a model-based risk envelope and does not by itself give a confidence interval, an estimator of reproductive skew, or a result for selection or changing population size.

# 6. Arbitrary simultaneous partitions: exact criteria and a boundary

We now enlarge the finite class in Section 2. An event at state $b$ has a partition type $\pi=(k_1,\ldots,k_m)$, where every $k_i\ge1$, $\sum_i k_i=b$, and $1\le m\lt b$. It reduces the block count from $b$ to $m$ and merges
$$
w(\pi)=\sum_{i=1}^m\binom{k_i}{2}
$$
pairs. Singleton groups are included in the type. Event rates $r_{b,\pi}\ge0$ obey
$$
\sum_\pi r_{b,\pi}w(\pi)=\binom b2. \tag{6.1}
$$
All such arrays form a class denoted $\mathcal P_N$. There is no requirement of consistency across sample sizes. A type may be assigned uniformly among label partitions with that type; then (6.1) gives each specified pair merger rate one.

For fixed $b,m$, write $b=m\ell+r$ with $0\le r\lt m$. The smallest and largest possible pair weights are
$$
\begin{aligned}
w_{\min}(b,m)&=(m-r)\binom{\ell}{2}+r\binom{\ell+1}{2},\\
w_{\max}(b,m)&=\binom{b-m+1}{2}. \tag{6.2}
\end{aligned}
$$
To minimize, if two group sizes differ by at least two, move one element from the larger to the smaller; this strictly reduces the sum of pair counts. Repetition yields the balanced sizes $\ell,\ell+1$. To maximize, move all but one element of a smaller nonsingleton group into a larger group; this increases the sum. Repetition leaves one group of size $b-m+1$ and $m-1$ singletons.

**Theorem 6.1 (simultaneous-partition criteria).** With $a_b,h_b$ as in Section 2, the following are equivalent:

1. For all $1\le m\lt b\le N$,
   $$h_b-h_m\le w_{\min}(b,m)a_b. \tag{LS}$$
2. For every array in $\mathcal P_N$ and every starting state $b\le N$, the Kingman cost is an increasing-convex lower bound.
3. For every such array and starting state, the Kingman expected cost is a lower bound.

The corresponding universal star upper bound, in either mean or increasing convex order, holds if and only if (U) holds. Under (U), the sharper estimate (3.1) remains valid. Thus the exact two-sided cost class is the intersection of (LS) and (U).

For the lower sufficiency, the binary increment identity (3.4) gives, for an event with $m$ groups,
$$
f_b(s)-f_m(s)\le u_b(s)(h_b-h_m)
\le w_{\min}(b,m)a_bu_b(s)
\le w(\pi)a_bu_b(s).
$$
Multiplying by $r_{b,\pi}/c_b$ and summing yields the same cost-time generator inequality as in (3.6). The mean induction and positive-semigroup identity (3.7) apply without change. If (LS) fails, use only a balanced partition at the offending state $b$, with event rate $\binom b2/w_{\min}(b,m)$, and use binary rows below. Its mean is $w_{\min}(b,m)a_b+h_m\lt h_b$, proving necessity.

For the upper sufficiency, (U) and (6.2) imply
$$
c_b-c_m\ge w_{\max}(b,m)a_b\ge w(\pi)a_b.
$$
The drift and remaining-mean arguments of Theorem 3.2 therefore apply. Necessity follows from the single-group counterexample (3.9), since that class is contained in $\mathcal P_N$. In contrast with the single-group case, (U) need not imply (LS).

**Corollary 6.2 (sharp power threshold).** For $c_b=b^\alpha$ and $N\ge4$, the universal Kingman lower bound over $\mathcal P_N$ holds if and only if
$$
\alpha\ge\alpha_*:=\frac{\log2}{\log(4/3)}\simeq2.40942083965. \tag{6.3}
$$
The universal star upper bound holds if and only if $\alpha\ge1$. Hence the two-sided comparison over $\mathcal P_N$ has threshold $\alpha_*$. For $N=3$ the two-sided threshold is $1$, and for $N=2$ every positive cost gives equality.

Necessity in (6.3) uses the partition $(2,2)$ at state four. Condition (LS) requires $a_3+a_4\le2a_4$, or $(4/3)^\alpha\ge2$. Equivalently, the chain $4\to2$ at rate $3$, followed by $2\to1$ at rate $1$, has mean minus the binary mean equal to
$$
\frac{4^\alpha}{6}-\frac{3^\alpha}{3}. \tag{6.4}
$$
This is negative exactly when $\alpha\lt \alpha_*$.

For sufficiency, $a_b\ge a_{b-1}$ for $b\ge4$ is equivalent to
$$
\alpha\ge R_b:=\frac{\log[b/(b-2)]}{\log[b/(b-1)]}.
$$
These thresholds decrease with $b$. Indeed, putting $u=1/(b-1)$ gives $R_b=1+[-\log(1-u)]/\log(1+u)$. The ratio after the plus sign is increasing in $u$: it is the $\bigl(1/(1+t)\bigr)$-weighted average on $[0,u]$ of the increasing function $(1+t)/(1-t)$. Its maximum for $b\ge4$ is therefore $R_4=\alpha_*$. Consequently $a_3\le a_4\le\cdots$ when $\alpha\ge\alpha_*$. For $m\ge2$,
$$
h_b-h_m\le(b-m)a_b\le w_{\min}(b,m)a_b,
$$
because $\binom{k_i}{2}\ge k_i-1$. For $m=1$, (LS) is $h_b\le c_b$, which follows from the already proved single-group comparison for $\alpha\ge1$. This proves (LS) in every case. The upper threshold is unchanged since its exact condition is (U).

## 6.1. A consistent family through four samples

For four labelled blocks, give each of the three perfect matchings event rate one, merging its two pairs simultaneously. From three blocks use binary mergers at rate one per pair, and from two blocks merge at rate one. Restriction to any three labels turns the three matching events into the three possible pair mergers, each at rate one. Pair restrictions also have rate one; invisible mergers do not change that rate. Thus this family is exchangeable and consistent for sample sizes at most four.

Nevertheless, for ordinary length,
$$
\mathbb EL_4=\frac43+2=\frac{10}{3}
\lt \frac{11}{3}=\mathbb EL_4^{\mathrm K}. \tag{6.5}
$$
This does not extend to an infinite $\Xi$-coalescent. Its triple-merger rate is zero. In a nonzero paintbox, the probability that three samples enter one atom is $\sum_i p_i^3>0$. The representation in [S00] would therefore force every nonbinary paintbox component to vanish, whereas a purely binary component cannot create disjoint simultaneous pairs. Infinite consistency imposes a substantive additional constraint. The next section uses that constraint to restore the ordinary tree-length lower bound.

# 7. Paintbox occupancy and the full $\Xi$ comparison

Let $p=(p_i)_{i\ge1}$ have $p_i\ge0$ and $\sum_i p_i\le1$. A sample chooses atom $i$ with probability $p_i$; the remaining probability is diffuse dust, and every dust draw creates a distinct class. Let $K_b(p)$ count the classes occupied by $b$ independent samples. Put
$$
P_2(p)=\sum_i p_i^2,\qquad H_0=0.
$$

**Theorem 7.1 (harmonic occupancy).** For every such paintbox and every integer $b\ge2$,
$$
H_{b-1}-\mathbb E H_{K_b(p)-1}\le\frac b2 P_2(p). \tag{7.1}
$$
For the binary stop-loss function $f_b(s)$ in (4.3), this implies
$$
\mathbb E[f_b(s)-f_{K_b(p)}(s)]
\le\binom b2P_2(p)[f_b(s)-f_{b-1}(s)],
\qquad s\ge0. \tag{7.2}
$$

We give a self-contained proof of the occupancy estimate.

## 7.1. A circular difference comparison

Let $\sigma=\sum_{i=1}^M\beta_i\delta_{z_i}$ be a probability measure on the unit circle, with distinct points $z_i$ and positive weights $\beta_i$. For $i\ne j$, let $d_{ij}\in(0,1)$ represent $z_j-z_i$ modulo one. Define on the interval $[0,1]$
$$
\rho_\sigma=
\frac{\sum_i\beta_i^2}{2}(\delta_0+\delta_1)
+\sum_{i\ne j}\beta_i\beta_j\delta_{d_{ij}}. \tag{7.3}
$$
The diagonal mass is split equally between endpoints. The distribution is symmetric about $1/2$ and has mean $1/2$.

**Lemma 7.2 (circle discrepancy identity).** The uniform distribution on $[0,1]$ is below $\rho_\sigma$ in convex order. More precisely, if $Z\sim\rho_\sigma$ and
$$
A_h(u)=\sigma((u,u+h]\bmod1),
\qquad U\sim\operatorname{Unif}[0,1],
$$
then, for $0\le h\le1$,
$$
\mathbb E(Z-h)_+-\frac{(1-h)^2}{2}
=\frac12\operatorname{Var}[A_h(U)]\ge0. \tag{7.4}
$$

To prove the identity, first $\int_0^1A_h(u)\,du=h$. Two circular arcs of length $h$ with relative displacement $x$ overlap in length
$$
(h-x)_++(h-(1-x))_+.
$$
This formula remains valid for $h>1/2$, when both terms may be positive. Expanding the square and integrating therefore gives
$$
\int_0^1A_h(u)^2\,du
=\mathbb E[(h-Z)_++(h-(1-Z))_+]
=2\mathbb E(h-Z)_+.
$$
The endpoint convention is harmless because the overlap function has the same value $h$ at $0$ and $1$. Symmetry gives the last equality. Finally $\mathbb E(Z-h)_+-\mathbb E(h-Z)_+=1/2-h$, proving (7.4). These stop-loss inequalities, with equal means, prove convex order; thresholds outside $[0,1]$ give equality automatically.

## 7.2. Random cyclic order represents the paintbox measure

First suppose $p_1,\ldots,p_M>0$ and $\sum_i p_i=1$. For $t\in(0,1)$ let $B_i(t)$ be independent Bernoulli variables of success probability $t$, and set $W_t=\sum_i p_iB_i(t)$. Define finite measures
$$
\begin{aligned}
\nu_p(A)
&=\int_0^1
 \frac{\mathbb E[W_t(1-W_t)\mathbf1_{\{W_t\in A\}}]}{t(1-t)}\,dt,\\
\mu_p&=\nu_p+\frac{P_2(p)}2(\delta_0+\delta_1). \tag{7.5}
\end{aligned}
$$
Since $\mathbb E[W_t(1-W_t)]=(1-P_2(p))t(1-t)$, the measure $\mu_p$ is a probability measure.

Place arcs of lengths $p_i$ in a uniformly random cyclic order around the circle. Let $z_i$ be the start of arc $i$, and give that point weight $p_i$. For fixed ordered labels $i\ne j$, the distance from $z_i$ to $z_j$ is $p_i+\sum_{k\in S}p_k$, where $S$ is the set of labels between them. For any specified subset $S$ of the other $M-2$ labels,
$$
\mathbb P(\text{between-set}=S)
=\frac{|S|!(M-2-|S|)!}{(M-1)!}
=\int_0^1t^{|S|}(1-t)^{M-2-|S|}\,dt. \tag{7.6}
$$
The first equality counts cyclic orders after fixing label $i$ as the origin. Thus the distance has the mixture law of $p_i+\sum_{k\ne i,j}p_kB_k(t)$ with uniform mixing in $t$.

On the other hand,
$$
W_t(1-W_t)=\sum_{i\ne j}p_ip_jB_i(t)(1-B_j(t)).
$$
Conditioning on $B_i=1,B_j=0$ in (7.5) yields
$$
\nu_p
=\sum_{i\ne j}p_ip_j\int_0^1
\operatorname{Law}\left(p_i+\sum_{k\ne i,j}p_kB_k(t)\right)\,dt. \tag{7.7}
$$
Comparison with (7.6), including the common endpoint masses, proves that $\mu_p$ is the average of the circular difference measures (7.3). Lemma 7.2 and preservation of convex order under mixtures give
$$
\operatorname{Unif}[0,1]\le_{\mathrm{cx}}\mu_p. \tag{7.8}
$$
For $M=1$, the conclusion holds directly for $(\delta_0+\delta_1)/2$.

## 7.3. Missing mass gives the harmonic recursion

Let $M_n$ denote the probability that the next draw creates a new class, conditional on the first $n$ draws. For a general paintbox it includes the entire dust mass. The one-step class-count recursion gives
$$
\mathbb E H_{K_{n+1}-1}-\mathbb E H_{K_n-1}
=\mathbb E\frac{M_n}{K_n}. \tag{7.9}
$$
In the finite dust-free case, independently marking each atom with success probability $t$ gives
$$
\mathbb E[t^{K_n}]=\mathbb E[W_t^n].
$$
Also
$$
\mathbb E[t^{K_{n+1}}]-\mathbb E[t^{K_n}]
=(t-1)\mathbb E[M_nt^{K_n}].
$$
Combining these identities and integrating nonnegative functions yields
$$
\mathbb E\frac{M_n}{K_n}
=\int_0^1\frac{\mathbb E[W_t^n(1-W_t)]}{t(1-t)}\,dt
=\int_0^1x^{n-1}\nu_p(dx). \tag{7.10}
$$
For $n\ge2$, the polynomial $x^{n-1}$ is convex. Applying (7.8) gives
$$
\frac1n\le\int x^{n-1}\mu_p(dx)
=\frac{P_2(p)}2+\mathbb E\frac{M_n}{K_n}. \tag{7.11}
$$
The restriction $n\ge2$ is essential: at $n=1$ the last expectation is $1-P_2(p)$.

Set $D_b=H_{b-1}-\mathbb E H_{K_b-1}$. Equations (7.9)--(7.11) give $D_{n+1}-D_n\le P_2(p)/2$ for $n\ge2$. Since $D_2=P_2(p)$, summing proves (7.1). In particular $b=2,3$ give equality, because the polynomial used at $n=2$ is linear.

To include infinitely many atoms and dust, retain the first $M$ masses and replace the residual $r_M=1-\sum_{i\le M}p_i$ by $R$ equal atoms of mass $r_M/R$. Couple the retained-atom choices in the original and approximating samples. Both class counts agree with the model in which every residual observation is unique unless a residual collision occurs. A union bound bounds the disagreement probability by
$$
\binom b2\left(\sum_{i>M}p_i^2+\frac{r_M^2}{R}\right). \tag{7.12}
$$
First take $R\to\infty$ and then $M\to\infty$. The class-count laws and the pair probabilities converge. Since the harmonic statistic is bounded for fixed $b$, (7.1) passes to the limit.

Finally put $r=1-e^{-s/2}\in[0,1)$. The explicit binary transform has increments $f_{j+1}(s)-f_j(s)=2(1-r^j)/j$. Therefore for every $1\le k\le b$,
$$
f_b(s)-f_k(s)
\le2(1-r^{b-1})(H_{b-1}-H_{k-1}).
$$
Take expectations, apply (7.1), and use
$$
f_b(s)-f_{b-1}(s)=\frac{2(1-r^{b-1})}{b-1}
$$
to obtain (7.2). This completes the proof of Theorem 7.1.

## 7.4. The full normalized coalescent

Write $\Delta=\{p_1\ge p_2\ge\cdots\ge0:\sum_i p_i\le1\}$ and let $\Xi$ be a probability measure on $\Delta$. Decompose $\Xi=\kappa\delta_{\mathbf0}+\Xi_0$, where $\Xi_0$ has no atom at zero and $\kappa+\Xi_0(\Delta)=1$. In the usual paintbox representation [S00], the block-count generator is
$$
(G^\Xi g)(b)
=\kappa\binom b2[g(b-1)-g(b)]
+\int_\Delta
\frac{\mathbb E[g(K_b(p))-g(b)]}{P_2(p)}\,\Xi_0(dp). \tag{7.13}
$$
The pair merger rate is one. Formula (7.13) is well defined on every finite restriction: the probability of any collision is at most $\binom b2P_2(p)$, so its apparent singularity at small $P_2$ causes no problem. In particular the total rate is finite. The corresponding partition events satisfy (6.1), and their total nontrivial event rate is at least one, since no event merges more than $\binom b2$ pairs.

**Theorem 7.3 (universal tree-length bounds).** For every $\Xi$ as above and every finite $n\ge2$,
$$
L_n^{\mathrm K}\le_{\mathrm{icx}}L_n^\Xi\le_{\mathrm{icx}}nE. \tag{7.14}
$$
More explicitly, writing $v_n^\Xi=\mathbb EL_n^\Xi$,
$$
f_n(s)\le\mathbb E(L_n^\Xi-s)_+
\le v_n^\Xi e^{-s/n}\le ne^{-s/n},
\qquad s\ge0. \tag{7.15}
$$
Both extremes are attained, by $\Xi=\delta_{\mathbf0}$ and $\Xi=\delta_{(1,0,\ldots)}$ respectively.

For the upper bound, linear cost $c_b=b$ satisfies (U), so Theorem 6.1 applies to the event rates in (7.13). For the lower bound, (7.2) and $\kappa+\Xi_0(\Delta)=1$ give
$$
G^\Xi f(s)(b)\ge-\binom b2[f_b(s)-f_{b-1}(s)]. \tag{7.16}
$$
At $s=0$, $f_b(0)=2H_{b-1}$; hence $G^\Xi f(0)(b)\ge-b$. The same finite downward recurrence as (3.3) proves $v_b^\Xi\ge2H_{b-1}$.

In cumulative-length time, the transient generator is $A^\Xi_{b,m}=G^\Xi_{b,m}/b$, including the similarly divided diagonal. The right side of (7.16), divided by $b$, is exactly $f_b'(s)$, by the binary backward equation. Thus $A^\Xi f(s)-f'(s)\ge0$. Apply the positive-semigroup identity (3.7), now with $A^\Xi$ and $v^\Xi-f(0)\ge0$. It gives $\mathbb E(L_b^\Xi-s)_+\ge f_b(s)$ at every threshold and completes the proof.

Every moment, moment-generating-function and linked-mutation comparison in Section 5 consequently remains valid with $\Lambda$ replaced by $\Xi$. This follows by applying the same increasing convex test functions and the same Poisson kernel to (7.14); it does not require new assumptions about the original independent-site model. The uniqueness statements of Proposition 4.2 are stated only for the $\Lambda$ subclass.

# 8. Finite verification and limitations

The mathematical proofs above cover the stated infinite families. A separate reproducible calculation checks exact rate normalization, the finite cost inequalities and their counterexamples, rational first and second moments, and numerical stop-loss transforms from the cost-time matrix exponential. Finite calculations are diagnostics and are not substitutes for the proofs.

The cost calculations use rational arithmetic for 517 normalized $\Lambda$ rows, 1,296 positive integer cost vectors, and 15,598 explicit mean witnesses for failed inequalities. Numerical cost-time checks cover 23,783 state--threshold combinations. The paintbox calculations separately compare three constructions of $\mu_p$ for six mass vectors, check the arc-variance identity at 75 thresholds by exact interval integration, and cross-check 190 occupancy distributions using two algorithms. They also test 54 finite paintbox/binary mixtures and 1,881 numerical state--threshold combinations. The scripts, exact counts, seeds and tolerances accompany the manuscript; the numerical tests do not certify arbitrary real parameters or replace the countable-paintbox limit argument.

The following restrictions are material:

- The coalescent theorem assumes a time-homogeneous characteristic probability measure. A change of physical time or mutation scale changes the numerical bounds.
- The classes $\mathcal Q_N$ and $\mathcal P_N$ allow arbitrary rows and are not characterizations of infinitely consistent coalescents. Section 6.1 shows why this distinction matters.
- The necessary and sufficient cost criteria concern every array in their specified finite class and every initial state. Necessity for a single characteristic measure is not proved.
- The $\Xi$ theorem concerns continuous-time coalescent limits. It does not assert an exact finite-population Cannings result, or a result for nonconstant demographies or selection.
- Ordinary stochastic order, general variance minimization, and identifiability of the full reproductive measure are outside the proved claims.
- The count-distribution application uses one linked genealogy and must not be substituted for the independent-site distribution in the original diversity paper.

# References

[P99] J. Pitman. *Coalescents with multiple collisions*. The Annals of Probability **27**(4), 1870--1902 (1999). DOI: [10.1214/aop/1022874819](https://doi.org/10.1214/aop/1022874819). [Author manuscript](https://www.stat.berkeley.edu/~pitman/495.pdf).

[DP14] R. Der and J. B. Plotkin. *The Equilibrium Allele Frequency Distribution for a Population with Reproductive Skew*. Genetics **196**(4), 1199--1216 (2014). DOI: [10.1534/genetics.114.161422](https://doi.org/10.1534/genetics.114.161422).

[DP13] R. Der and J. B. Plotkin. Author version of [DP14], [arXiv:1306.4747v1](https://arxiv.org/pdf/1306.4747v1) (submitted 20 June 2013). Relevant conjecture: PDF pp. 14--15; recurrence and optimization discussion: pp. 20--23. The PDF's typeset date differs from its repository submission date.

[BBL14] J. Berestycki, N. Berestycki and V. Limic. *Asymptotic sampling formulae for $\Lambda$-coalescents*. Annales de l'Institut Henri Poincare, Probabilites et Statistiques **50**(3), 715--731 (2014). DOI: [10.1214/13-AIHP546](https://doi.org/10.1214/13-AIHP546). [Author manuscript](https://arxiv.org/abs/1201.6512).

[K12] G. Kersting. *The asymptotic distribution of the length of Beta-coalescent trees*. The Annals of Applied Probability **22**(5), 2086--2107 (2012). DOI: [10.1214/11-AAP827](https://doi.org/10.1214/11-AAP827). [Author manuscript](https://arxiv.org/abs/1107.2855).

[DK19] C. Diehl and G. Kersting. *Tree lengths for general $\Lambda$-coalescents and the asymptotic site frequency spectrum around the Bolthausen-Sznitman coalescent*. The Annals of Applied Probability **29**(5), 2700--2743 (2019). DOI: [10.1214/19-AAP1462](https://doi.org/10.1214/19-AAP1462). [Author manuscript](https://arxiv.org/abs/1804.00961).

[BBE13] M. Birkner, J. Blath and B. Eldon. *Statistical Properties of the Site-Frequency Spectrum Associated with $\Lambda$-Coalescents*. Genetics **195**(3), 1037--1053 (2013). DOI: [10.1534/genetics.113.156612](https://doi.org/10.1534/genetics.113.156612).

[SKS16] J. P. Spence, J. A. Kamm and Y. S. Song. *The Site Frequency Spectrum for General Coalescents*. Genetics **202**(4), 1549--1561 (2016). DOI: [10.1534/genetics.115.184101](https://doi.org/10.1534/genetics.115.184101). [Author manuscript](https://arxiv.org/abs/1510.05631).

[DDS08] J.-F. Delmas, J.-S. Dhersin and A. Siri-Jegousse. *Asymptotic results on the length of coalescent trees*. The Annals of Applied Probability **18**(3), 997--1025 (2008). DOI: [10.1214/07-AAP476](https://doi.org/10.1214/07-AAP476). [Author manuscript](https://cermics.gitlab.enpc.fr/delmas/Publi/long-a.pdf). The classical Kingman maximum representation is used only as background and is also derived in Section 4.

[S00] J. Schweinsberg. *Coalescents with simultaneous multiple collisions*. Electronic Journal of Probability **5**, paper 12, 1--50 (2000). DOI: [10.1214/EJP.v5-68](https://doi.org/10.1214/EJP.v5-68). [Journal full text](https://www.maths.tcd.ie/EMIS/journals/EJP-ECP/article/download/68/135.pdf). Theorem 2 and Section 3 provide the representation used in Section 7.4.

[M87] W. A. Massey. *Stochastic Orderings for Markov Processes on Partially Ordered Spaces*. Mathematics of Operations Research **12**(2), 350--367 (1987). DOI: [10.1287/moor.12.2.350](https://doi.org/10.1287/moor.12.2.350). [Author-hosted full text](https://wmassey.princeton.edu/sites/g/files/toruqf5871/files/documents/stochord.pdf).

[OC91] C. A. O'Cinneide. *Phase-Type Distributions and Majorization*. The Annals of Applied Probability **1**(2), 219--227 (1991). DOI: [10.1214/aoap/1177005935](https://doi.org/10.1214/aoap/1177005935).

[HZV13] Q.-M. He, H. Zhang and J. C. Vera. *Majorization and Extremal PH Distributions*. In Matrix-Analytic Methods in Stochastic Models, Springer Proceedings in Mathematics & Statistics **27**, 107--121 (2013). DOI: [10.1007/978-1-4614-4909-6_6](https://doi.org/10.1007/978-1-4614-4909-6_6). [Author-hosted proof version](https://www.engineering.uwaterloo.ca/~q7he/Z_PDF_PS_Published/2013_MAM7_2011_273577_1_En_6.pdf).

[FK06] J.-M. Fourneau and L. Kloul. *A Precedence PEPA Model for Performance and Reliability Analysis*. EPEW 2006, Lecture Notes in Computer Science **4054**, 1--15 (2006). [Author-hosted full text](https://www.dcs.ed.ac.uk/pepa/precedencepepa.pdf).

[HBZO19] H. Y. He, K. Basu, Q. Zhao and A. B. Owen. *Permutation p-value approximation via generalized Stolarsky invariance*. The Annals of Statistics **47**(1), 583--611 (2019). DOI: [10.1214/18-AOS1702](https://doi.org/10.1214/18-AOS1702). [Author manuscript, version 2](https://arxiv.org/pdf/1603.02757v2). The fixed-cap identity in Theorem 3 is the relevant discrepancy-theory background.
