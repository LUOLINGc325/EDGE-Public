# Sharp independence-dependent loss in greedy online contention resolution

**Research manuscript, 25 November 2026.** Written proofs and computational evidence are distinct from full proof-assistant verification. This manuscript is not an externally peer-reviewed publication. The main theorem concerns the greedy selectable model defined below; it does not assert an optimal bound for all adaptive online policies.

## Abstract

We determine the optimal asymptotic loss of law-known greedy selectable online contention resolution for every fixed finite independence order. If $t\ge2$ is fixed and $r=\lfloor t/2\rfloor$, the optimal loss for a rank-$k$ uniform matroid is $\Theta_r(k^{-r/(2r+1)})$. For a unit-capacity knapsack with maximum item weight at most $d$ and expected active weight at most one, the optimal loss is $\Theta_r(d^{r/(2r+1)})$. The upper bounds already hold under $2r$-wise independence, while the matching obstructions are $(2r+1)$-wise independent. A covariance estimate controls the aggregate mass of coordinates with large conditional overload probability; conditional falling-factorial moments then complete a two-bucket greedy scheme. For the lower bound, a robust-core inequality transfers feasible capacity between nested uniform subset layers. A hard two-layer component is embedded in an exactly moment-matched finite distribution using strictly positive quadrature weights and integer-rounded moment interpolation. Explicit constants and elementary witnesses are given for orders two through five, including the all-rank pairwise loss $\Theta(k^{-1/3})$. No symmetry or product structure is imposed on the competing scheme’s internal randomness, which remains independent of the activation draw. Constants and thresholds may depend on the fixed order; no growing-order or arbitrary non-greedy policy claim is made.

## 1. Model, contribution, and limits

Let $E$ be finite and let $k\ge1$ be an integer. An activation law $D$ is a probability distribution on subsets $R\subseteq E$. Write $x_i=\Pr(i\in R)$ and assume

$$
\sum_{i\in E}x_i\le k,
\qquad \Pr(i,j\in R)=x_ix_j\quad(i\ne j).
\tag{1}
$$

The algorithm knows the complete law $D$. Before observing $R$, it samples a family $\mathcal F\subseteq2^E$, independently of $R$, such that $\varnothing\in\mathcal F$, the family is downward closed, and every member has size at most $k$. Internal randomization may be arbitrarily correlated across elements. On arrival of an active element, the algorithm accepts it exactly when adjoining it to the accepted set preserves membership in $\mathcal F$.

For fixed $\mathcal F$ and $R$, define the **robust core**

$$
C_{\mathcal F}(R)=\{i\in R:\ I\cup\{i\}\in\mathcal F
\text{ for every }I\subseteq R\text{ with }I\in\mathcal F\}.
\tag{2}
$$

A scheme is $c$-selectable if $\Pr(i\in C_{\mathcal F}(R))\ge cx_i$ for every $i$. This formulation also handles zero marginals. Let $c_k$ be the supremum of the constants achievable for every finite instance satisfying (1), and put $L_k=1-c_k$.

This is the greedy selectable PI-OCRS model of Gupta, Hu, Kehne, and Levin (GHKL), Definitions 2.5–2.6 [1]. Their Theorem 3.1(ii) establishes loss $O(k^{-1/5})$; their $O(k^{-1/3})$ statement in part (i) is an **offline** result. The good/bad bucket architecture and thinning reduction are prior methods from [1]. For fully independent activations, Dinev and Weinberg [2] establish optimal almighty-adversary loss $\Theta(\sqrt{\log k/k})$; their fixed-order bound has a different rate and a different adversary. Our question is the sharp PI rate in the specified greedy model, inferred from these nonmatching bounds, not a numbered conjecture quoted from either source.


### Fixed-order and weighted formulations

A law is $t$-wise independent when every subfamily of at most $t$ activation indicators has its product Bernoulli distribution. Write $c_k^{(t)}$ for the uniform-matroid optimum in this class and $L_k^{(t)}=1-c_k^{(t)}$; thus $L_k=L_k^{(2)}$.

For knapsack, the capacity is one, item weights satisfy $0<w_i\le d$, and $\sum_i w_i x_i\le1$. The algorithm again knows the entire activation law and draws a nonempty downward-closed family independently of the actual activations, with every member having weight at most one. The robust-core and per-item selectability definitions are unchanged. Let $L_{\mathrm{knap}}^{(t)}(d)$ denote the corresponding optimal worst-instance loss. The size bound means *at most* $d$, with arbitrary heterogeneous weights and arbitrary finite ground sets.

### Theorem G. Fixed finite-independence classification

For every fixed integer $r\ge1$ and $t\in\{2r,2r+1\}$,

$$
\boxed{L_k^{(t)}=\Theta_r\!\left(k^{-r/(2r+1)}\right),\qquad
L_{\mathrm{knap}}^{(t)}(d)=\Theta_r\!\left(d^{r/(2r+1)}\right).}
$$

Precisely, for each fixed $r$ there are strictly positive lower and upper constants and finite thresholds such that the first two-sided bound holds for every integer $k\ge K_r$, and the second for every real $0<d\le d_r$. They may depend on $r$. The lower instances have $2k$ elements with all activation marginals $1/2$ and are $(2r+1)$-wise independent. Section 6 proves the classification; Sections 7–9 give explicit elementary constants for the first two pairs. The original sharp pairwise target is retained as the following all-rank theorem.

| Independence order | Uniform-matroid loss | Small-item knapsack loss |
|---|---|---|
| $2,3$ | $\Theta(k^{-1/3})$ | $\Theta(d^{1/3})$ |
| $4,5$ | $\Theta(k^{-2/5})$ | $\Theta(d^{2/5})$ |
| $6,7$ | $\Theta(k^{-3/7})$ | $\Theta(d^{3/7})$ |
| Fixed $2r,2r+1$ | $\Theta_r(k^{-r/(2r+1)})$ | $\Theta_r(d^{r/(2r+1)})$ |

The even/odd pairing of limited independence and the use of factorial-moment constructions already occur in earlier offline single-item work [1]. Classical moment methods and positive quadrature are also established tools [4–6]. The contribution here is the growing-capacity greedy-online exponent and its sharp weighted counterpart, with the new robust-core obstruction and overload-mass analysis. No classical probability or quadrature theorem is claimed as new.

### Theorem 1. Sharp pairwise rate

For every integer $k\ge1$,

$$
\boxed{\frac1{8k^{1/3}}\le L_k\le4k^{-1/3}.}
\tag{3}
$$

More precisely,

$$
c_k\ge\max\left\{\frac14,(1-2k^{-1/3})_+^2\right\}.
\tag{4}
$$

For each $k$, let

$$
a=\lceil k^{1/3}\rceil,\quad
b=\left\lceil\frac{k}{2a}\right\rceil.
$$

There is an explicit PI instance on $2k$ elements for which every admissible randomized family has some element with conditional selectability at most

$$
1-\frac{k}{2a(k+b)}.
\tag{5}
$$

On the subsequence $k=2m^3$, a two-layer instance gives the stronger explicit bound

$$
c_{2m^3}\le1-\frac1{2m+1}.
\tag{6}
$$

The constants in (3) are not claimed optimal. Computing an optimal leading constant, the sharp rate for arbitrary non-greedy adaptive policies, and guarantees from only marginal or sample access remain outside this theorem. The result is an existence and explicit-law algorithm theorem, not a claim of polynomial preprocessing from a compact representation of an arbitrary joint law.

The robust-core event also has an operational meaning. An active element in the core is accepted under every order. If it is outside the core, take a witness $I\subseteq R$ with $I\in\mathcal F$ but $I\cup\{i\}\notin\mathcal F$. Necessarily $i\notin I$. Presenting all elements of $I$ first makes the greedy rule accept them, because the family is downward closed; presenting $i$ next forces rejection. Thus a fully informed adversary can realize failure whenever the robust-core condition fails. This does not extend the definition to non-greedy algorithms.

## 2. A conditional overload-mass estimate

The next estimate is an elementary application of covariance and Cauchy–Schwarz. Its use in this selection problem, rather than the probability inequality itself, is the contribution.

### Lemma 2. Bad-coordinate mass

Let $(J_i)_{i\in E}$ be pairwise-independent Bernoulli variables with means $y_i$. For any event $A$, put $p=\Pr(A)$, and let $u>p$. Define

$$
B=\{i:y_i>0,\ \Pr(A\mid J_i=1)>u\},\qquad
\mu_B=\sum_{i\in B}y_i.
$$

Then

$$
\mu_B\le\frac{p(1-p)}{(u-p)^2}.
\tag{7}
$$

**Proof.** Set $Z=\sum_{i\in B}J_i$. Linearity gives

$$
\operatorname{Cov}(Z,1_A)
=\sum_{i\in B}y_i\bigl(\Pr(A\mid J_i=1)-p\bigr)
\ge(u-p)\mu_B.
$$

Pairwise independence gives $\operatorname{Var}(Z)=\sum_{i\in B}y_i(1-y_i)\le\mu_B$. Therefore

$$
(u-p)^2\mu_B^2\le\operatorname{Cov}(Z,1_A)^2
\le\operatorname{Var}(Z)\operatorname{Var}(1_A)
\le\mu_Bp(1-p).
$$

When $\mu_B>0$, division proves (7); when $\mu_B=0$, it is immediate. No independence between $A$ and the indicators is assumed. Coordinates of mean zero are excluded from $B$. A coordinate of mean one has conditional event probability $p$, so it cannot belong to $B$. $\square$


### Lemma 2W. Weighted bad-coordinate mass

If additionally $0<w_i\le d$, define $M=\sum_{i\in B}w_i y_i$. Then

$$
M\le\frac{d\,p(1-p)}{(u-p)^2}. \tag{7W}
$$

Indeed, for $Z=\sum_{i\in B}w_iJ_i$, the same covariance expansion gives $\operatorname{Cov}(Z,1_A)\ge(u-p)M$, while pairwise independence gives

$$
\operatorname{Var}(Z)=\sum_{i\in B}w_i^2 y_i(1-y_i)\le dM.
$$

Cauchy–Schwarz yields $(u-p)^2M^2\le dM p(1-p)$. Divide when $M>0$; when $M=0$ the claim is immediate. This is a weighted use of the same classical inequality. $\square$

## 3. The pairwise upper bound

First suppose $k\ge9$ and set

$$
\delta=k^{-1/3},\qquad q=1-2\delta,\qquad
h=\lceil\delta k\rceil,\qquad g=k-h.
\tag{8}
$$

Then $0<q<1$ and $1\le h\le k-1$. From the known law $D$, compute the law $D'$ of $R'=R\cap S$, where $S$ is an independent product mask retaining each element with probability $q$. This is a calculation on the law, before any actual mask or activation set is realized. Under $D'$, the indicators $J_i=1_{\{i\in R'\}}$ are PI with means $y_i=qx_i$.

Let $W=|R'|$, $A=\{W>g\}$, and $p=\Pr(A)$. Compute the deterministic partition

$$
B=\{i:y_i>0,\ \Pr(A\mid J_i=1)>2\delta\},\qquad G=E\setminus B.
\tag{9}
$$

Now draw the actual mask $S$ independently of the actual $R$, and sample the family

$$
\mathcal F_S=\{I\subseteq S:|I\cap G|\le g, |I\cap B|\le h\}.
\tag{10}
$$

This family contains the empty set, is downward closed, and has rank at most $g+h=k$. The online implementation accepts a masked active element if its bucket has room. The partition in (9) is determined by $D'$, not by the realized mask. Consequently $\mathcal F_S$ is independent of $R$, including when an almighty adversary sees both of them.

### 3.1 Unconditional overload and bad mass

Write $m=\mathbb EW$. Then

$$
m\le(1-2\delta)k,\qquad
\operatorname{Var}(W)=\sum_i y_i(1-y_i)\le k.
$$

Since $W$ is integer valued, $A=\{W\ge g+1\}$, and

$$
g+1-m
\ge k-\lceil\delta k\rceil+1-(1-2\delta)k
\ge\delta k.
$$

Chebyshev's inequality yields

$$
p\le\frac{k}{\delta^2k^2}=\delta,
\tag{11}
$$

using $\delta^3k=1$. Lemma 2, with $u=2\delta$, now gives

$$
\mu_B=\sum_{i\in B}y_i
\le\frac{p(1-p)}{(2\delta-p)^2}
\le\frac1\delta.
\tag{12}
$$

The entire argument is unconditional until this point. It does not incorrectly assume that pairwise independence survives conditioning on an active coordinate.

### 3.2 Exact extension event

Fix $i$ with $x_i>0$. Let $H$ be its bucket and $t$ that bucket's capacity. Conditional on $i\in R$, its robust-core event is precisely

$$
\{i\in S, |R\cap S\cap H|\le t\}.
\tag{13}
$$

If $i\notin S$, the empty feasible set witnesses failure. If $i\in S$ and the bucket contains at most $t$ masked active elements, every feasible set not already containing $i$ uses at most $t-1$ of them; adjoining $i$ remains feasible. Conversely, if there are more than $t$, choose $t$ masked active elements of that bucket other than $i$. That set is feasible but cannot be extended by $i$. This proves (13), including the capacity-zero interpretation.

For $i\in G$, conditional on $J_i=1$, the bucket-overload probability is at most $\Pr(A\mid J_i=1)\le2\delta$. For $i\in B$, the relevant failure event, under this conditioning, is

$$
\sum_{j\in B\setminus\{i\}}J_j\ge h.
$$

The current coordinate is explicitly excluded. Pairwise independence determines the remaining conditional first moments, so Markov's inequality and (12) give

$$
\Pr(|R'\cap B|>h\mid J_i=1)
\le\frac{\sum_{j\in B\setminus\{i\}}y_j}{h}
\le\frac1{\delta h}
\le\frac1{\delta^2k}=\delta.
\tag{14}
$$

Independence of $S$ and $R$, followed by (13), therefore proves

$$
\Pr(i\in C_{\mathcal F_S}(R)\mid i\in R)
=q\Pr(|R'\cap H|\le t\mid J_i=1)
\ge(1-2\delta)^2.
\tag{15}
$$

No independence between $S$ and $R'$ is used or needed.

### 3.3 All ranks and boundary cases

For every $k\ge1$, a simpler scheme retains each element independently with probability $1/2$ and uses $\{I\subseteq S:|I|\le k\}$. Conditional on $i$ being active and retained, the mean number of other active retained elements is at most $k/2$. Markov gives a conditional blocking probability at most $1/2$. Multiplication by the retention probability gives selectability at least $1/4$.

Use this baseline below $64$ and (10) at or above $64$. The two certified bounds agree at $64$; for $9\le k<64$ the two-bucket certificate is no larger, and for $k\le8$ its positive-part expression is zero. This proves (4). It implies the right side of (3): for $k\le8$, $4k^{-1/3}\ge2\ge L_k$; otherwise $L_k\le4\delta-4\delta^2\le4\delta$.

Zero marginals require no conditional assertion. Marginals equal to one are allowed and become strictly less than one after thinning. A slack total mean $\sum_i x_i<k$ only improves the estimates. For an empty ground set, the constructed family is still $\{\varnothing\}$.

## 4. A transfer inequality for arbitrary greedy families

### Lemma 3. Core extension

For every fixed admissible family, every $R$, and every feasible $I\subseteq R$,

$$
I\cup C_{\mathcal F}(R)\in\mathcal F.
\tag{16}
$$

**Proof.** Enumerate the finitely many core elements. Starting from $I$, each successive addition preserves feasibility by (2), because the current set remains a subset of $R$. This finite induction proves (16). Taking $I=\varnothing$ shows that the core itself is feasible and hence has size at most $k$. $\square$

### Lemma 4. Two-layer transfer

Let $0\le L\le H\le|E|$ and $H>0$. Draw $R$ uniformly among $H$-subsets and then $S$ uniformly among the $L$-subsets of $R$. Let $\mathcal F$ have any distribution independent of this coupling. Put

$$
s=\mathbb E|C_{\mathcal F}(S)|,\qquad
t=\mathbb E|C_{\mathcal F}(R)|.
$$

Then

$$
\boxed{s+\frac{H-L}{H}t\le k.}
\tag{17}
$$

**Proof.** $S$ is marginally uniform on the $L$-layer: for any specified $L$-subset, the number of containing $H$-subsets is $\binom{|E|-L}{H-L}$, and

$$
\binom{|E|}{H}\binom HL
=\binom{|E|}{L}\binom{|E|-L}{H-L}.
$$

For every realized $\mathcal F,S,R$, Lemma 3 gives

$$
C_{\mathcal F}(S)\cup C_{\mathcal F}(R)\in\mathcal F,
$$

because the first core is feasible and contained in $R$. Since $C_{\mathcal F}(S)\subseteq S$,

$$
|C_{\mathcal F}(S)|+|C_{\mathcal F}(R)\setminus S|\le k.
\tag{18}
$$

For fixed $\mathcal F,R$, each element of its core lies outside the uniformly chosen $S$ with probability $(H-L)/H$. Averaging (18) proves (17). This argument does not symmetrize the algorithm. A family selected using the full input law remains the same family at both layers. $\square$

### Lemma 5. Two-layer obstruction

Let $1\le a\le k$, $b\ge1$, $k+b\le|E|$, and $b^2\le ak$. Let $D_{a,b}$ choose a uniform $(k-a)$-subset with probability $b/(a+b)$ and a uniform $(k+b)$-subset with probability $a/(a+b)$. For every admissible random family independent of this draw,

$$
\mathbb E_{D_{a,b}}|C_{\mathcal F}(R)|\le\frac{k^2}{k+b}.
\tag{19}
$$

**Proof.** Set $L=k-a$, $H=k+b$, and use the notation of Lemma 4. We have $t\le k$ and $s\le k-(a+b)t/(k+b)$. Thus

$$
\frac{bs+at}{a+b}
\le\frac{bk}{a+b}
+\left(\frac a{a+b}-\frac b{k+b}\right)t.
$$

The coefficient of $t$ is $(ak-b^2)/((a+b)(k+b))\ge0$. Substituting $t\le k$ gives (19). The count under $D_{a,b}$ has mean $k$ and variance $ab$. Pairwise independence of $D_{a,b}$ is not needed for this lemma. $\square$

## 5. Explicit PI lower-bound instances

### 5.1 An exchangeable count calculation

Suppose a law on subsets of $[n]$ first draws an integer $N\in[0,n]$ and then a uniform subset of size $N$. For distinct $i,j$,

$$
\Pr(i\in R)=\frac{\mathbb EN}{n},\qquad
\Pr(i,j\in R)=\frac{\mathbb E[N(N-1)]}{n(n-1)}.
\tag{20}
$$

These follow by counting memberships and ordered distinct pairs on each layer. In particular, if $n=2k$, $\mathbb EN=k$, and $\operatorname{Var}(N)=k/2$, both probabilities are respectively $1/2$ and $1/4$. Thus the activation indicators are PI.

For any law and any admissible family distribution,

$$
\mathbb E|C_{\mathcal F}(R)|
=\sum_i x_i\Pr(i\in C_{\mathcal F}(R)\mid i\in R).
\tag{21}
$$

Accordingly, if $\mathbb E|R|=k$, a bound on $\mathbb E|C|/k$ bounds the minimum conditional selectability. All marginals in the instances below are positive.

### 5.2 A two-layer family at cubic ranks

Let $m\ge1$, $k=2m^3$, $n=4m^3$, $a=m$, and $b=m^2$. Use $D_{a,b}$. Its count has mean $k$ and variance $m^3=k/2$, so (20) proves PI. Since $b^2=m^4\le ak=2m^4$, Lemma 5 and (21) give

$$
1-c\ge\frac b{k+b}=\frac1{2m+1}
$$

for every scheme on this instance. This proves (6).

### 5.3 A three-layer family at every rank

For an arbitrary $k\ge1$, define $a,b$ as in Theorem 1 and set

$$
\theta=\frac{k}{2ab},\qquad n=2k.
$$

Draw the count according to

$$
\Pr(N=k-a)=\theta\frac b{a+b},\quad
\Pr(N=k)=1-\theta,\quad
\Pr(N=k+b)=\theta\frac a{a+b},
\tag{22}
$$

and draw a uniform subset conditional on that count. This is an exact finite distribution with rational probabilities.

We check every parameter condition. The ceiling definitions give $1\le a\le k$, $1\le b\le k$, and $ab\ge k/2$, so $0<\theta\le1$ and all count values lie between zero and $2k$. Also $b^2\le ak$. For $k=1$ this is immediate. For $k\ge2$, $a\ge2$, $a^3\ge k$, and $ak\ge4$, so

$$
b^2\le\left(\frac{k}{2a}+1\right)^2
=\frac{k^2}{4a^2}+\frac ka+1
\le\frac{ak}{4}+\frac{ak}{4}+\frac{ak}{4}
\le ak.
\tag{23}
$$

The first and third layers together are the $D_{a,b}$ component with weight $\theta$; the middle component has count exactly $k$. Both have mean $k$. The variance of the mixture is therefore $\theta ab=k/2$. Equation (20) gives exact PI Bernoulli-$1/2$ marginals, satisfying (1) with equality.

Fix any family distribution chosen using the entire law (22). On its two-layer component, Lemma 5 forces expected bad active count at least $kb/(k+b)$. The bad count is nonnegative on the middle layer. Independence of the family and the activation draw means that the same family distribution can be used in this conditioning. Therefore (21) gives

$$
1-c\ge\theta\frac b{k+b}
=\frac{k}{2a(k+b)}.
\tag{24}
$$

Finally $b\le k$ and $a\le k^{1/3}+1\le2k^{1/3}$ imply (3)'s lower bound. This finishes Theorem 1.


## 6. Proof of the fixed-order classification

### 6.1. A finite high-moment bound

Set $A_r=(2r)^{2r}+2^r$. For $2r$-wise independent Bernoulli indicators $J_i$ of means $y_i$ with $\sum_i y_i\le k$ and $k\ge1$,

$$
\mathbb E\left(\sum_i(J_i-y_i)\right)^{2r}\le A_r k^r. \tag{G1}
$$

For positive weights $w_i\le d\le1$ with $\sum_i w_i y_i\le1$,

$$
\mathbb E\left(\sum_iw_i(J_i-y_i)\right)^{2r}\le A_r d^r. \tag{G2}
$$

**Proof.** Expand the $2r$ factors and group ordered coordinate tuples by the partition of their positions into equal-coordinate blocks. A singleton block makes the expectation zero, since there are at most $2r$ distinct coordinates and its centered factor has zero mean. Every surviving partition has $\ell\le r$ blocks, each of size at least two. There are at most $(2r)^{2r}$ such partitions. For any block size $s\ge2$,

$$
\mathbb E|J_i-y_i|^s\le\mathbb E(J_i-y_i)^2=y_i(1-y_i)\le y_i.
$$

Independence factors the moment over distinct blocks. In the unweighted case, the absolute sum for a fixed partition is at most $(\sum_i y_i)^\ell\le k^r$, after dropping distinctness restrictions. In the weighted case with block sizes $s_1+\cdots+s_\ell=2r$, it is at most

$$
\prod_{j=1}^{\ell}\sum_i w_i^{s_j}y_i
\le d^{2r-\ell}\left(\sum_iw_i y_i\right)^\ell
\le d^r.
$$

The last inequality uses $0<d\le1$ and $\ell\le r$. Taking absolute values of possibly signed block moments only increases this upper bound. Summing proves (G1)--(G2). The extra $2^r$ in $A_r$ is reserved for the conditional estimate below. $\square$

### 6.2. Uniform-matroid upper bound under only $2r$-wise independence

Put

$$
\delta=(A_r/k^r)^{1/(2r+1)},\qquad q=1-2\delta,
\qquad h=\lceil\delta k\rceil,\quad g=k-h.
$$

For every fixed $r$, choose $k$ large enough that $\delta\le1/4$, $h\ge2r$, and $h\le k-1$. Such a threshold exists because $\delta\to0$ and $\delta k\to\infty$. Independently thin by retention $q$, compute the thinned law before observing its realization, and use the same deterministic bad set

$$
B=\{i:y_i>0,\ \Pr(W>g\mid J_i=1)>2\delta\}
$$

and masked two-bucket feasible family as in Section 3. Independent product thinning preserves $2r$-wise independence: for every set of at most $2r$ coordinates the retained activations still have the product Bernoulli law.

The integer ceiling argument gives $W>g\Longrightarrow W-\mathbb EW\ge\delta k$. Hence (G1) and Markov give

$$
p=\Pr(W>g)\le\frac{A_r k^r}{\delta^{2r}k^{2r}}=\delta.
$$

The proved covariance bad-mass bound gives $\mu_B=\sum_{i\in B}y_i\le1/\delta$. For a bad item $i$, condition on $J_i=1$ and write $Z=\sum_{j\in B\setminus\{i\}}J_j$. Conditional joint moments of any $r$ distinct other coordinates factor: they require only $r+1\le2r$ original coordinates. Consequently the falling factorial satisfies

$$
\mathbb E[(Z)_r\mid J_i=1]
=\sum_{j_1,\ldots,j_r\text{ distinct in }B\setminus\{i\}}
 y_{j_1}\cdots y_{j_r}\le\mu_B^r\le\delta^{-r}.
$$

The integer-valued statistic $(Z)_r$ is nonnegative on every outcome. On blocking, $Z\ge h$, so

$$
(Z)_r\ge(h)_r\ge(h/2)^r\ge(\delta k/2)^r
$$

because $h\ge2r$. Thus

$$
\Pr(Z\ge h\mid J_i=1)
\le\frac{2^r}{\delta^{2r}k^r}
=\frac{2^r}{A_r}\delta\le\delta.
$$

Good items have conditional blocking probability at most $2\delta$ by definition. The independent mask and the previously proved exact cardinality-bucket extension event imply selectability at least $(1-2\delta)^2$. The loss is therefore at most $4A_r^{1/(2r+1)}k^{-r/(2r+1)}$.

### 6.3. Heterogeneous knapsack upper bound

Use

$$
\delta=(A_r d^r)^{1/(2r+1)},\quad q=1-2\delta,
\quad t_G=1-\delta,\quad t_B=\delta.
$$

For fixed $r$ and sufficiently small $d>0$, we have $\delta\le1/4$ and $\delta\ge2rd$. Both follow from $\delta\to0$ and $\delta/d\to\infty$. Every item then fits either bucket. To state the weighted algorithm explicitly, under the retained law put

$$
W=\sum_iw_iJ_i,\quad A=\{W>1-\delta\},\quad
B=\{i:y_i>0,\ \Pr(A\mid J_i=1)>2\delta\},\quad G=E\setminus B.
$$

The partition is fixed from that law. For the actual independent mask $S$, use

$$
\mathcal F_S=\left\{I\subseteq S:
\sum_{i\in I\cap G}w_i\le1-\delta,\quad
\sum_{i\in I\cap B}w_i\le\delta\right\}. \tag{G2W}
$$

It contains the empty set, is downward closed, and every member has total weight at most one. By (G2), the probability of total thinned weight exceeding $1-\delta$ is at most $\delta$. The weighted covariance estimate gives bad expected load

$$
M=\sum_{i\in B}w_i y_i\le d/\delta.
$$

Fix a bad item $i$ and condition on its retained activation. Let $Z$ be the realized total weight of all other bad active items. Define $Q_0=1$ and, for $1\le j\le r$, let $Q_j$ be the sum of products of weights over all ordered $j$-tuples of distinct other bad active items. Each $Q_j$ is nonnegative on every outcome. Conditional $r$-fold product moments factor, so

$$
\mathbb E[Q_r\mid J_i=1]\le M^r\le(d/\delta)^r. \tag{G3}
$$

For any realized list of nonnegative item weights at most $d$,

$$
Q_j=\sum_{(a_1,\ldots,a_{j-1})\text{ distinct}}
 w_{a_1}\cdots w_{a_{j-1}}
 \left(Z-\sum_{b=1}^{j-1}w_{a_b}\right)
\ge (Z-(j-1)d)Q_{j-1}. \tag{G4}
$$

When the distinguished item overflows the bad bucket, $Z>\delta-w_i\ge\delta-d$. Each factor in the iteration of (G4) is then at least $\delta-rd\ge\delta/2$. It follows that $Q_r\ge(\delta/2)^r$ on this event. Markov is applied to the genuinely nonnegative $Q_r$, not to a polynomial that may be negative outside the event. With (G3), blocking probability is at most

$$
\frac{2^r d^r}{\delta^{2r}}=\frac{2^r}{A_r}\delta\le\delta.
$$

Good items again lose at most $2\delta$ conditionally. Total own-bucket active weight at most its capacity is a sufficient universal-extension event for heterogeneous weights. Thus the same independently masked family gives selectability at least $(1-2\delta)^2$, proving the upper exponent.

### 6.4. Strictly positive finite moment interpolation

The following classical positive-quadrature argument [6] is supplied to prove the needed feasibility. Its role is to ensure that the subsequent exact finite moment correction has positive weights.

Let $\mu$ be the probability measure on $(0,\infty)$ with density proportional to $z^{-1/2}e^{-z}$. All moments exist, and integration by parts yields

$$
\nu_j=\int z^j\,d\mu(z)=\frac{(2j)!}{4^j j!},\qquad \nu_0=1. \tag{G5}
$$

For a fixed $r$, there exist distinct positive numbers $z_0,\ldots,z_r$ and strictly positive numbers $\alpha_0,\ldots,\alpha_r$ with

$$
\sum_{\ell=0}^r\alpha_\ell z_\ell^j=\nu_j\quad(0\le j\le r). \tag{G6}
$$

**Proof including strict positivity.** The inner product $\langle f,g\rangle=\int fg\,d\mu$ is strictly positive on every nonzero real polynomial squared, since the density is positive on $(0,\infty)$. Solving the corresponding positive-definite Gram system gives a monic polynomial $P$ of degree $r+1$ orthogonal to every polynomial of degree at most $r$.

If $P$ had at most $r$ distinct positive roots of odd multiplicity, let $Q$ be the product of the corresponding linear factors, taking $Q=1$ if there are none. Then $\deg Q\le r$, while $PQ$ has a constant nonzero sign except at its finitely many positive roots. Its integral could not vanish, contradicting orthogonality. Therefore $P$ has exactly $r+1$ distinct simple positive roots $z_0,\ldots,z_r$.

Let $\ell_j$ be the Lagrange basis polynomial for these roots and set $\alpha_j=\int\ell_j^2\,d\mu>0$. The polynomial $\ell_j^2-\ell_j$ vanishes at every root of $P$ and has degree at most $2r$, so its quotient by $P$ has degree at most $r-1$. Orthogonality gives $\alpha_j=\int\ell_j\,d\mu$. Interpolating any polynomial of degree at most $r$ proves (G6), including $\sum_j\alpha_j=1$. This also proves the existence of a nondegenerate Vandermonde representation with strictly positive weights. $\square$

Strict positivity matters: a representation on the boundary of the moment cone would not justify the perturbation argument that follows.

### 6.5. Binomial moments and a symmetric hard component

Let $B_k\sim\operatorname{Bin}(2k,1/2)$ and set

$$
\beta_j(k)=\mathbb E(B_k-k)^{2j}/k^j\quad(0\le j\le r),
$$

where $\beta_0=1$. Then

$$
\beta_j(k)\longrightarrow\nu_j. \tag{G7}
$$

For completeness, write $B_k-k$ as a sum of $2k$ independent fair variables taking values $\pm1/2$. In its $2j$-th moment expansion, odd multiplicities vanish. Terms with $j$ distinct indices each appearing twice contribute

$$
(2j-1)!!\,(2k)_j\,4^{-j}.
$$

Every other surviving multiplicity pattern uses at most $j-1$ indices and contributes a polynomial in $k$ of degree at most $j-1$. Dividing by $k^j$ yields $(2j-1)!!/2^j=(2j)!/(4^j j!)$. This proves (G7) without invoking a limit distribution. All odd centered binomial moments vanish exactly.

For every sufficiently large integer $k$, put

$$
m=\lfloor k^{1/(4r+2)}\rfloor,\qquad
 a=m^2,\qquad b=m^{2r+2}.
$$

Then $m^{4r+2}\le k<(m+1)^{4r+2}$, $a,b\le k$, and $b^2\le ak$. Let $D_{a,b}$ put counts $k-a,k+b$ at probabilities $b/(a+b),a/(a+b)$, and let $T_k$ be its average with reflection about $k$. This is a symmetric mean-$k$ count law supported in $[0,2k]$; it need not itself be $t$-wise independent.

Its normalized even moments are $\tau_0(k)=1$ and

$$
\tau_j(k)=\frac{b a^{2j}+a b^{2j}}{(a+b)k^j}\quad(1\le j\le r).
$$

As $k\to\infty$ through all integers,

$$
\tau_j(k)\longrightarrow
\begin{cases}0,&1\le j<r,\\1,&j=r.\end{cases} \tag{G8}
$$

Indeed, $k/m^{4r+2}\to1$, $a/b\to0$, and the dominant numerator-over-denominator scale is

$$
\frac{a b^{2j-1}}{k^j}\sim m^{2j-2r}.
$$

The ratio limit is uniform over the entire defining integer interval for each $m$, because its endpoint ratio is $(1+1/m)^{4r+2}\to1$. Thus (G8) is an all-large-integer assertion rather than a subsequence calculation. For $r=1$, the range $1\le j<r$ is empty and the limit vector is simply $(1,1)$.

### 6.6. Positive exact matching after integer rounding

Use the nodes from (G6) and put

$$
s_\ell(k)=\lceil\sqrt{k z_\ell}\rceil,
\qquad (A_k)_{j\ell}=s_\ell(k)^{2j}/k^j
\quad(0\le j,\ell\le r).
$$

Then $A_k\to A$, where $A_{j\ell}=z_\ell^j$ is invertible by distinctness of the nodes. In particular $A_k$ is invertible for all sufficiently large $k$. The rounded $s_\ell$ are positive integers at most $k$ at that threshold. Rounding contributes $s_\ell(k)/\sqrt k=\sqrt{z_\ell}+O(k^{-1/2})$, so it does not assume exact realizability of the continuous nodes.

Write $\nu=(\nu_0,\ldots,\nu_r)$ and $\tau_*=(1,0,\ldots,0,1)$, interpreting $\tau_*=(1,1)$ for $r=1$. We have $A^{-1}\nu=\alpha>0$ coordinatewise. Choose a fixed $w\in(0,1/2)$ so small that

$$
\lambda_*:=A^{-1}(\nu-w\tau_*)>0
$$

coordinatewise. Such a choice exists by strict positivity of $\alpha$ and finiteness of the coordinates of $A^{-1}\tau_*$. One explicit sufficient choice is any positive $w$ less than

$$
\min\left\{\frac12,\ \min_\ell
 \frac{\alpha_\ell}{2(1+|(A^{-1}\tau_*)_\ell|)}\right\}.
$$

Now define the exact finite-$k$ weights

$$
\lambda(k)=A_k^{-1}\bigl(\beta(k)-w\tau(k)\bigr). \tag{G9}
$$

Matrix inversion is continuous at an invertible matrix, so (G7)--(G8) give $\lambda(k)\to\lambda_*>0$. Consequently every coordinate of $\lambda(k)$ is positive for all sufficiently large integers $k$. Row zero of (G9) gives $\sum_\ell\lambda_\ell(k)=1-w$ exactly.

Define $Q_k$ as the count law that uses $T_k$ with probability $w$ and, for each $\ell$, uses the symmetric two-point counts $k\pm s_\ell(k)$ with total probability $\lambda_\ell(k)$. All weights are nonnegative and sum to one; all counts are integers in $[0,2k]$. By (G9), its even centered moments through order $2r$ equal those of $B_k$ exactly. Odd centered moments through order $2r+1$ vanish by symmetry. Therefore the expectations of every polynomial of degree at most $2r+1$ match those of $B_k$.

Conditional on the count, choose a uniformly random subset of $[2k]$. For any $j\le2r+1$ specified distinct coordinates, the all-one probability is

$$
\frac{\mathbb E(N)_j}{(2k)_j}=2^{-j}.
$$

Here increase the threshold if necessary so that $2k\ge2r+1$. Inclusion-exclusion gives all joint zero-one patterns: for disjoint specified-one and specified-zero sets $U,V$ with $|U|+|V|\le2r+1$,

$$
\Pr(U\subseteq R,\ V\cap R=\varnothing)
=\sum_{T\subseteq V}(-1)^{|T|}2^{-|U|-|T|}
=2^{-|U|-|V|}.
$$

Thus this is a genuine $(2r+1)$-wise independent finite activation law with all marginals $1/2$. Positive mixture feasibility, integer support, exact moments, and full pattern independence have each been proved rather than imposed as assumptions.

### 6.7. The selection obstruction and knapsack transfer

Freeze any independently randomized greedy feasible family selected using the complete law $Q_k$. The original $D_{a,b}$ has weight $w/2$ in $Q_k$, and $b^2\le ak$. The already proved robust-core two-layer obstruction applies to this same family, irrespective of which complete law was used to design it. It forces average conditional failure at least $b/(k+b)$ on that component. Every component has mean count $k$, and bad active count is nonnegative. The whole-law average conditional failure is therefore at least

$$
\frac{w b}{2(k+b)}.
$$

For all sufficiently large $m$, $k\le2m^{4r+2}$ and $b\le m^{4r+2}$. Hence

$$
L_k^{(2r+1)}\ge\frac{w}{6m^{2r}}
\ge\frac w6 k^{-r/(2r+1)}. \tag{G10}
$$

The last direction uses $k\ge m^{4r+2}$. Since this law is also $2r$-wise, (G10) gives the same lower bound in the weaker independence class. Combining with Section 6.2 proves the uniform-matroid part of Theorem G.

For knapsack, given sufficiently small real $d>0$, take $k=\lceil1/d\rceil$ and give each item in the lower instance weight $1/k\le d$. Expected active weight is exactly one, and weight feasibility is exactly cardinality at most $k$. Since $k\le2/d$, (G10) gives

$$
L_{\mathrm{knap}}^{(t)}(d)\ge\frac w6\,2^{-r/(2r+1)}d^{r/(2r+1)}
\qquad(t\in\{2r,2r+1\}).
$$

Together with Section 6.3, this proves the weighted part and completes Theorem G. $\square$


## 7. Explicit four-wise upper constants

The general proof uses deliberately loose order-dependent constants. At order four, direct expansion improves them. Put

$$
\delta=(4/k^2)^{1/5},\quad q=1-2\delta,\quad
h=\lceil\delta k\rceil,\quad g=k-h.
$$

For $k\ge64$, $\delta\le1/4$ and $\delta k\ge16$, so $h\ge2$. For thinned four-wise indicators, $X_i=J_i-y_i$ and $v_i=y_i(1-y_i)$ satisfy

$$
\mathbb E\left(\sum_iX_i\right)^4
=\sum_i\mathbb EX_i^4+6\sum_{i<j}v_iv_j
\le k+3k^2\le4k^2. \tag{F1}
$$

Terms with a singleton coordinate vanish; the Bernoulli identity is $\mathbb EX_i^4=v_i(1-3v_i)\le y_i$. The integer overload event gives $p\le4/(\delta^4k^2)=\delta$, and Lemma 2 gives $\mu_B\le1/\delta$.

Conditional on a bad retained item, the other coordinates are pairwise independent because the original law is at least three-wise. For their count $Z$,

$$
\mathbb E[Z(Z-1)\mid J_i=1]\le\mu_B^2,\qquad
\Pr(Z\ge h\mid J_i=1)
\le\frac{\mu_B^2}{h(h-1)}
\le\frac2{\delta^4k^2}=\frac\delta2.
$$

The statistic $Z(Z-1)$ is nonnegative for nonnegative integer $Z$. Good items lose at most $2\delta$ conditionally, giving

$$
c_k^{(4)},c_k^{(5)}\ge
\max\left\{\frac14,\left(1-2(4/k^2)^{1/5}\right)_+^2\right\}. \tag{F2}
$$

For $k<64$, the positive-part expression is at most $1/4$, so the pairwise baseline proves the same displayed bound. In particular the loss is at most $4\cdot4^{1/5}k^{-2/5}$ for $k\ge64$.

## 8. Elementary three- and five-wise witnesses

### 8.1 Three-wise independence at every rank

Start with the all-rank PI law $D_k$ from Section 5 and mix it equally with its complement in $[2k]$. For any three distinct fair PI bits, writing $p=\Pr(X_i=X_j=X_\ell=1)$, inclusion-exclusion gives

$$
\Pr(X_i=X_j=X_\ell=0)=1-3/2+3/4-p=1/4-p.
$$

After a fair common complementation, the all-one triple has probability $1/8$. The one- and two-coordinate laws are unchanged. Inclusion-exclusion supplies every prescribed zero-one pattern, proving three-wise independence. When $2k<3$ the triple condition is vacuous under the definition using subfamilies of at most three coordinates.

Freeze the same random feasible family for the complete symmetrized law. Its bad active count on the original component still obeys Section 5's lower bound, while the count on the other component is nonnegative. Thus

$$
L_k^{(3)}\ge\frac{k}{4a(k+b)}\ge\frac1{16k^{1/3}}
\qquad(k\ge1). \tag{F3}
$$

The PI upper bound applies unchanged. This yields the sharp three-wise cube-root rate at every rank. The complement symmetrization is a standard limited-independence tool; the new obstruction is its use with the family-uniform two-layer bound.

### 8.2 Five-wise independence on an explicit sequence

For $m\ge2$, take

$$
k=m^{10},\quad a=m^2,\quad b=m^6,
$$

and let $T$ average the mean-$k$ two-layer law $D_{a,b}$ with its reflection about $k$. For $Z=N-k$,

$$
\mathbb E_TZ^2=m^8,\qquad
\mathbb E_TZ^4=m^{20}-m^{16}+m^{12}.
$$

Let $A$ be the symmetric count law $k\pm m^5$ and let $O$ put all mass at count $k$. Set

$$
w=\frac{m^{10}-1}{4m^2(m^8-m^6-m^4+1)},\qquad
u=\frac12-\frac{w}{m^2},\qquad v=1-w-u,
\quad Q=wT+uA+vO. \tag{F4}
$$

All weights are nonnegative. To check this directly, put $t=m^2\ge4$ and cancel the common factor to get

$$
w=\frac{t^4+t^3+t^2+t+1}{4t(t^3-t-1)}.
$$

The denominator is positive, and $w\ge1/4$ follows by subtracting $t(t^3-t-1)$ from the numerator. For $w\le1/2$, the required numerator difference is

$$
t^4-t^3-3t^2-3t-1
=s^4+15s^3+81s^2+181s+131>0,
\qquad t=4+s.
$$

Consequently $u\ge3/8$ and $v=1/2-w(1-1/t)\ge0$. The weights sum to one. The variance and fourth centered moment are exactly

$$
\mathbb E_QZ^2=k/2,\qquad
\mathbb E_QZ^4=k(3k-1)/4.
$$

For the fourth moment, substituting $u$ leaves

$$
\frac12m^{20}+w(m^{20}-m^{18}-m^{16}+m^{12})
=\frac34m^{20}-\frac14m^{10}.
$$

Odd centered moments through five vanish by symmetry. These are the centered moments of $\operatorname{Bin}(2k,1/2)$, so uniform-subset sampling conditional on count gives five-wise independence by the factorial-moment and inclusion-exclusion argument in Section 6.6. Since $b^2=ak$ and the hard original component has weight $w/2$,

$$
L_{m^{10}}^{(5)}\ge\frac{w}{2(m^4+1)}\ge\frac1{16k^{2/5}}. \tag{F5}
$$

### 8.3 Five-wise independence at every sufficiently large rank

Here is an elementary construction with explicit threshold, independent of the general quadrature argument. Let

$$
K_0=64^{10}=1152921504606846976,
\quad k\ge K_0,
\quad m=\lfloor k^{1/10}\rfloor,
\quad a=m^2,\ b=m^6,\ s=\lceil\sqrt k\rceil.
$$

Use the same symmetric two-layer law $T$, a symmetric law $A_s$ on $k\pm s$, and the center law $O$. Put

$$
V_T=m^8,\quad Q_T=m^{20}-m^{16}+m^{12},\quad
D=Q_T-V_Ts^2,\quad N=\frac{k(3k-1)}4-\frac{ks^2}2,
$$

$$
w=N/D,\qquad u=(k/2-wV_T)/s^2,\qquad v=1-w-u. \tag{F6}
$$

All support points are valid since $a,b,s\le k$. For $m\ge64$,

$$
m^{10}\le k<(m+1)^{10}\le\frac54m^{10},
\qquad k\le s^2\le\frac{17k}{16}.
$$

The first bound uses $(65/64)^{10}<5/4$. For the second, $s\le\sqrt k+1$, and $k\ge4096$ implies $2\sqrt k+1\le k/16$. Hence

$$
\frac{3k^2}{16}\le N\le\frac{k^2}{4},\qquad
\frac78m^{20}\le\frac{935}{1024}m^{20}\le D\le m^{20}.
$$

For the lower bound on $D$, use

$$
D\ge m^{20}-m^{16}-\frac{85}{64}m^{18},
$$

then $m^{-4}\le1/256$ and $m^{-2}\le1/16$; the bound already holds for $m\ge4$. The numerator lower bound follows from $N\ge7k^2/32-k/4$ and $k\ge8$. Therefore

$$
3/16\le w\le25/56<1/2,\qquad 0\le u\le1/2,\quad v\ge0.
$$

The two defining equations give exact variance $k/2$ and fourth centered moment $k(3k-1)/4$. Symmetry and uniform-subset sampling yield a five-wise independent law. Moreover $b^2\le ak$ and the original hard component has probability $w/2\ge1/16$, so

$$
L_k^{(5)}\ge\frac{b}{16(k+b)}
\ge\frac1{36m^4}\ge\frac1{36k^{2/5}}
\qquad(k\ge K_0). \tag{F7}
$$

Here $k+b\le(9/4)m^{10}$. The same lower instance is four-wise independent, so (F7) holds for $L_k^{(4)}$ as well. The large displayed threshold is a conservative proof threshold, not a claim that the exponent starts only there.

## 9. Explicit small-item knapsack bounds

For $0<d\le1/64$, pairwise independence permits

$$
c_{\mathrm{knap}}^{(2)}(d),c_{\mathrm{knap}}^{(3)}(d)
\ge(1-2d^{1/3})^2. \tag{F8}
$$

To obtain this sharper small-order constant, set $\delta=d^{1/3}$, $q=1-2\delta$, with weighted bucket capacities $1-\delta$ and $\delta$. The unconditional weighted variance is at most $d$, so overload above $1-\delta$ has probability at most $d/\delta^2=\delta$. Lemma 2W gives bad expected load $M\le d/\delta=\delta^2$. For a bad retained item, exclude its own weight before Markov:

$$
\Pr\left(\sum_{j\in B}w_jJ_j>\delta\mid J_i=1\right)
\le\frac{M}{\delta-w_i}
\le\frac{\delta}{1-\delta^2}\le2\delta.
$$

This uses only conditional first moments supplied by PI and the positive threshold $\delta-w_i\ge\delta-d>0$. Good items lose at most $2\delta$, proving (F8).

For four- or five-wise independence and the same size interval,

$$
c_{\mathrm{knap}}^{(4)}(d),c_{\mathrm{knap}}^{(5)}(d)
\ge\left(1-2(4d^2)^{1/5}\right)^2. \tag{F9}
$$

Put $\delta=(4d^2)^{1/5}$. Then $\delta\le1/4$ and $\delta\ge4d$. The direct fourth-moment expansion gives

$$
\mathbb E(W-\mathbb EW)^4
\le\sum_iw_i^4y_i+3\left(\sum_iw_i^2y_i\right)^2
\le d^3+3d^2\le4d^2.
$$

Thus overload probability is at most $\delta$ and $M\le d/\delta$. Conditional on a bad retained item, let $Z$ be the other bad weight and let

$$
Q=\sum_{j\ne\ell\in B\setminus\{i\}}w_jw_\ell J_jJ_\ell\ge0.
$$

Conditional pairwise moments give $\mathbb EQ\le M^2$. The identity $Q=Z^2-\sum_jw_j^2J_j\ge Z^2-dZ$ implies, on overflow,

$$
Q\ge(\delta-d)(\delta-2d)\ge3\delta^2/8.
$$

Indeed $Z>\delta-d$ and the polynomial is increasing there; for $z\ge t=\delta-d$, its difference is $(z-t)(z+t-d)\ge0$. Applying Markov to $Q$ gives bad blocking probability at most $8d^2/(3\delta^4)=2\delta/3$. This proves (F9). The load condition used for heterogeneous buckets is sufficient for universal extension; necessity is not asserted.

For lower bounds at every real $d$ in the respective intervals, choose $k=\lceil1/d\rceil$ and weight $1/k$ on the uniform-matroid witnesses. Then $1/k\le d$, expected load is one, and feasibility coincides exactly with cardinality at most $k$. Since $k\le2/d$,

$$
L_{\mathrm{knap}}^{(2)}(d)\ge\frac{d^{1/3}}{8\,2^{1/3}},\qquad
L_{\mathrm{knap}}^{(3)}(d)\ge\frac{d^{1/3}}{16\,2^{1/3}}.
\tag{F10}
$$

These lower bounds hold for $0<d\le1$; their matching upper bound (F8) is stated for $d\le1/64$. Likewise (F7) gives

$$
L_{\mathrm{knap}}^{(4)}(d),L_{\mathrm{knap}}^{(5)}(d)
\ge\frac{d^{2/5}}{36\,2^{2/5}}
\qquad(0<d\le1/K_0). \tag{F11}
$$

The smaller interval in (F11) is necessary for the displayed explicit constant derived here. The asymptotic sharp exponent follows. Independent-activation offline small-item schemes [3] use a different activation and decision model.

## 10. Interpretation, reproduction, and boundaries

The fixed-order exponent identifies the quantitative cost of finite independence in an almighty-adversary greedy model. The difference between $2r$ and $2r+1$ does not change this exponent; passing to the next even order improves it. For every fixed $r$, the lower loss exceeds the fully independent benchmark $\Theta(\sqrt{\log k/k})$ by an unbounded factor of order $k^{1/(4r+2)}/\sqrt{\log k}$ [2]. This comparison holds with $r$ fixed. It supplies no justified growing-order interpolation.

The mechanism is reusable. A covariance bound makes the total difficult-coordinate mass small without claiming conditional independence that the input does not supply. Factorial or distinct-weight moments then exploit precisely the available conditional joint moments. On the opposite side, the nested robust-core transfer applies to arbitrary feasible families, without symmetrizing the algorithm. A positive finite moment correction embeds a hard component while preserving exact independence, integer support and a nonvanishing hard-component weight.

The upper algorithms require complete-law preprocessing to identify conditional-overload probabilities. Their existence does not imply efficient preprocessing from a compact marginal description or a bounded sample budget. The lower bounds apply to the defined nonempty downward-closed greedy families, including arbitrary correlated internal randomness independent of the draw. They do not establish impossibility for every adaptive non-greedy policy. General matroids, optimal leading constants and a sharp dependence on growing independence order remain open boundaries of this manuscript.

The reproducible checks use exact rational arithmetic. The core verifier enumerates all nonempty downward-closed families on ground sets of size at most five; it tests 1,856,031 nested-set inequalities and 154,138 uniform-layer transfers. The explicit count-law verifier checks all PI and three-wise ranks through 10,000, the five-wise tenth-power sequence, and thousands of all-large-rank boundary points. The upper verifier evaluates the true universal-extension event over finite activation and mask laws, and includes a 258-item affine-field instance with a nonempty bad-coordinate set. These finite computations test actual distributions and scheme events; they do not replace the general written proof. The computational files and execution reports are not included in this edition.

The formal verification scope is incomplete. A compiled finite-set or probability lemma certifies that lemma and its assumptions; it does not certify the entire exponent classification, the exact high-order distributions, or the complete online scheme. No external peer review or global priority certificate is claimed. The literature comparison is restricted to the sources examined.

## References

[1] A. Gupta, J. Hu, G. Kehne, R. Levin. *Pairwise-independent contention resolution*. Mathematical Programming, DOI [10.1007/s10107-025-02253-w](https://doi.org/10.1007/s10107-025-02253-w). [Author manuscript](https://arxiv.org/pdf/2406.15876). Definitions 2.5–2.6; Theorem 3.1(ii); Appendix A.

[2] A. Dinev, S. M. Weinberg. *Simple and Optimal Online Contention Resolution Schemes for k-Uniform Matroids*. ITCS 2024, LIPIcs 287, Article 39. DOI [10.4230/LIPIcs.ITCS.2024.39](https://doi.org/10.4230/LIPIcs.ITCS.2024.39). [Publisher PDF](https://drops.dagstuhl.de/storage/00lipics/lipics-vol287-itcs2024/LIPIcs.ITCS.2024.39/LIPIcs.ITCS.2024.39.pdf). Almighty lower bound: Theorem 27.

[3] C. Chekuri, J. Vondrák, R. Zenklusen. *Submodular Function Maximization via the Multilinear Relaxation and Contention Resolution Schemes*. STOC 2011. [Author PDF](https://theory.stanford.edu/~jvondrak/data/contention-res.pdf), Lemma 4.10.

[4] I. Benjamini, O. Gurel-Gurevich, R. Peled. *On K-wise Independent Distributions and Boolean Functions*. [arXiv:1201.3261](https://arxiv.org/abs/1201.3261). Classical moment methods in limited-independence questions.

[5] R. Peled, A. Yadin, A. Yehudayoff. *The maximal probability that k-wise independent bits are all 1*. Random Structures & Algorithms. DOI [10.1002/rsa.20329](https://doi.org/10.1002/rsa.20329). Prior discrete moment methods and sharp limited-independence asymptotics in a different problem.

[6] NIST Digital Library of Mathematical Functions. [§3.5(v), Gauss quadrature](https://dlmf.nist.gov/3.5#v). Positive orthogonal-polynomial quadrature; a self-contained finite interpolation proof needed here appears in Section 6.4.
