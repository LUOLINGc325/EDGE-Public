# Optimal fibers in information bottlenecks: stability, tensor products, and regular continuation

## Abstract

The information-bottleneck value curve, the collection of optimal representations, and the roots followed by an optimization algorithm contain different information. We connect these objects through posterior contact sets. For arbitrary independent finite source pairs, a uniform strong-data-processing coefficient bounds conditional source dependence by the deficit from the optimal bottleneck objective. We characterize every contact of a product problem, including channels with zeros, by a graph of overlapping output supports. Under strict curvature of the individual posterior contacts, we prove that the normalized Blahut–Arimoto residual has exactly the kernel of the posterior mixing matrix: its nullity is the number of active contacts minus their rank. This gives both sparse nonsingular representatives and an analytic entropy-selected section of a persistently singular optimal family.

A strictly positive six-state channel realizes all these phenomena on a certified nonempty low-rate interval. For its $k$-fold product, we determine every optimal posterior measure. On the nonunique side of an exact scalar parameter threshold, the optimal fiber has dimension $6^k-5^k$ and minimum cardinality $3^k$. At least $2^{(3^k-1)/2}$ different minimum representations exist; for two factors the exact number is 28, of which 24 are not independent products of scalar encoders. The positive interior representations have precisely $6^k-5^k$ BA null directions, although each individual posterior contact has a strictly negative Hessian on its full simplex. Every minimum representation is nonsingular and distinct minimum representations are Blackwell-incomparable.

These are finite-alphabet structural and local-continuation results. The original conjecture that strict concavity on the entire rate interval implies canonical uniqueness remains open. We do not assert an effective numerical size for the certified low-rate interval, generic persistent singularity, a globally convergent bottleneck algorithm, external peer review, or completed Lean verification.

## 1. Definitions, scope, and prior work

### 1.1 Posterior representations

All alphabets are finite, all logarithms are natural, and priors are strictly positive on their actual supports. A channel is written $K(y\mid x)$, with columns summing to one. For a source prior $p$ on $n$ symbols, an encoder satisfies $T-X-Y$. Its positive posterior columns and weights are

$$
q_t=P_{X\mid T=t},\qquad w_t=P_T(t),\qquad Qw=p.
$$

A representation is canonical when its positive posterior columns are pairwise distinct. Its weighted posterior measure $\sum_t w_t\delta_{q_t}$ determines the encoder up to label permutation, since $P(T=t\mid X=x)=w_tq_t(x)/p(x)$. Linear independence of these probability columns is equivalent to injectivity of their mixing map on the label simplex.

We use the rate-constrained value and its supporting objective

$$
F(R)=\max\{I(Y;T):I(X;T)\le R,\ |T|\le n+1\},\qquad
\mathcal L(c)=\max_T\{I(Y;T)-cI(X;T)\},\quad c>0.
$$

The Markov condition is understood in the first maximum. An auxiliary variable may be randomized and depend jointly on all inputs of a product source. A *contact* is a posterior attaining an affine upper certificate for the supporting objective; its definition in Section 3 accommodates a nonuniform prior. A *fiber* is the polytope of weights on a fixed contact set with barycenter $p$.

**Lemma 1.1 (finite-support reduction).** Every finite representation can be replaced by one with at most $n+1$ positive labels, the same input information, and at least the same output information.

**Proof.** Fix its posterior matrix $Q$, let $h_t=H(q_t)$ and $k_t=H(Kq_t)$, and minimize $k^Tv$ subject to $v\ge0$, $Qv=p$, and $h^Tv=h^Tw$. The feasible set is nonempty and compact: column normalization implies $\sum_t v_t=1$. At an extreme minimizer, its positive columns of $[Q;h^T]$ are independent, since a supported kernel vector would give a two-sided feasible displacement. There are at most $n+1$ such columns. The encoder formula above realizes them and proves the claim. $\square$

Consequently any temporary finite auxiliary alphabet can be used in a proof of a value inequality. Time sharing followed by this reduction proves concavity of $F$. The compact formulation with $n+1$ labels gives existence of optima. These observations do not imply that every canonical optimal representation uses $n$ labels; the distinction emphasized by Benger, Asoodeh, and Chen [2] is retained.

### 1.2 What is inherited and what is added

The starting case asked the canonical uniqueness and posterior-injectivity question in Appendix D of Charvin, Catenacci Volpi, and Polani [1], under strict concavity of $F$ on the **entire** interval $[0,H(X)]$. The earlier manuscript established a six-state low-rate family with a complete local optimal fiber, including a parameter threshold, but did not prove that full-interval hypothesis. Appendix A supplies the inherited low-rate argument in full so that the present paper does not rely on an unpublished assertion.

The present results address a closed structural question: how do all optimal posterior measures, approximate optimizers, and BA continuation roots behave under products and linear dependence of contacts? Section 2 gives an objective-deficit bound for every joint encoder. Section 3 gives all equality cases, even for channels with zeros. Sections 4–5 determine the complete product fibers and minimum representations in the explicit family. Section 6 proves full posterior nondegeneracy. Section 7 identifies the entire normalized BA residual kernel, not merely visible weight directions. Sections 8–9 give a persistent global-optimum realization and two regular representative selections.

Value tensorization and the existence of a product optimizer are classical. Asoodeh and Calmon [4, Theorem 5 and Appendix A] give this result and attribute it to Witsenhausen–Wyner; the 1975 original is not used as an unaudited proof input here. Strong-data-processing coefficients and their conditional-information applications are prior tools [5]. The short stability deduction in Section 2 is useful in combination with the equality and representation theory; it is not offered as a new foundation of SDPI. Learning-onset perturbation and its SDPI connection also predate this paper [3].

Convex optimal-root families and associated kernel directions are explicitly discussed by Agmon [6, Section 5.3]. Persistent Hessian kernels, projections, and symmetry-breaking analyses also appear in Parker and Dimitrov [7], with earlier information-theoretic bifurcation theory in Parker, Dimitrov, and Gedeon [8]. We do not claim to discover the mere existence of singular families, the implicit function theorem, or entropy maximization. The additional conclusion is the exact posterior-rank characterization of the **whole** normalized BA kernel under strict contact curvature, together with a positive globally optimal interval realizing it and precisely delimited selection rules.

Agmon's reduced-root convention in [6, Section 5.1] removes zero weights and duplicate decoders. The explicit family below still has a persistent kernel after this reduction. The literal nonsingularity criterion therefore needs an additional rank or uniqueness qualification; no claim is made that singularity persists for generic perturbations of a channel. Agmon's rate-distortion root-tracking work [9] is a close methodological comparator, but comparisons refer to the retrieved author version and do not allege an error in an unavailable final publisher text. The separate critical-slowing-down work [10] assumes uniqueness of the optimal reproduction marginal; our nonunique family does not satisfy that assumption and is not a counterexample to its conditional theorem.

Gedeon, Parker, and Dimitrov [11, Section 3.1] already analyze blockwise scaling kernels and constrained degeneracy associated with repeated encoder blocks. The rank criterion here treats linear relations among distinct posterior contacts and identifies the entire normalized BA residual kernel under strict contact curvature. Their symmetry and kernel methods are prior work; a possible correction of a particular earlier nonsingularity statement is not used as the foundation of our contribution.

Posterior-coordinate optimization and entropy-based numerical methods also have prior formulations [12,13]. Chen et al. [12] develop an alternating Sinkhorn scheme; Alpay [13] considers modified objectives with conditional-entropy regularization and implicit continuation. Section 9 instead maximizes entropy only over the exact unregularized optimum fiber after the contacts are fixed. All-minimizer correspondence under source-side sufficient-statistic reduction is studied in [14]; its reduction through a deterministic sufficient statistic differs from the product-posterior equality and correlated mixing measures studied here. These comparisons concern the retrieved definitions and constructions, and do not assume that every broader claim of a compared preprint has been independently verified.

The literature search is bounded, not a proof of worldwide priority. The cited source versions and comparison limits are stated in the text and references.

## 2. A quantitative deficit for the actual IB objective

Throughout Sections 2–3, the finite source pairs $(X_i,Y_i)$ are mutually independent, with priors $p_i$ and channels $K_i$. Each $p_i$ is strictly positive on its support. The joint source prior and channel are the corresponding tensor products. We first consider two factors.

For $c>0$, define

$$
\mathcal L_i(c)=\sup_{T-X_i-Y_i}\{I(Y_i;T)-cI(X_i;T)\}.
$$

The supremum can be taken over arbitrary finite auxiliaries, or over at most
$|X_i|+1$ symbols, with the same value. Lemma 1.1 proves this: preserve rate and improve relevance. The
standard compact finite-alphabet formulation makes the supremum a maximum.

Define the common-output mass of the first channel by

$$
\varepsilon_1=\sum_{y}\min_x K_1(y\mid x).
$$

### Theorem G1 (quantitative conditional independence)

For the independent source pairs above and every joint encoder $T-(X_1,X_2)-(Y_1,Y_2)$,

$$
\mathcal L_1(c)+\mathcal L_2(c)
-\{I(Y_1,Y_2;T)-cI(X_1,X_2;T)\}
\ \ge\ c\varepsilon_1 I(X_1;X_2\mid T).
\tag{G1}
$$

In particular the optimum value tensorizes. If $\varepsilon_1>0$, every exact global
optimizer has independent source coordinates conditional on each positive
encoder label. A representation within $\delta$ of the global optimum satisfies

$$
I(X_1;X_2\mid T)\le {\delta\over c\varepsilon_1},\qquad
\sum_tP_T(t)\|P_{X_1X_2\mid t}
-P_{X_1\mid t}\otimes P_{X_2\mid t}\|_1^2
\le {2\delta\over c\varepsilon_1}.
\tag{G2}
$$

**Proof.** When $0<\varepsilon_1<1$, decompose

$$
K_1(y\mid x)=\varepsilon_1 r(y)+(1-\varepsilon_1)\widetilde K_1(y\mid x),
\quad r(y)={\min_xK_1(y\mid x)\over\varepsilon_1}.
$$

Generate the first component using a flag $B$ independent of the source and
encoder; on the common branch the output is independent of all source
coordinates. Revealing $B$ to the observer cannot reduce information. Conditional
data processing on the other branch gives

$$
I(Y_2;T,Y_1)
\le \varepsilon_1 I(Y_2;T)+(1-\varepsilon_1)I(Y_2;T,X_1).
\tag{G3}
$$

The same inequality holds at $\varepsilon_1=0,1$ by dropping the absent branch. Because
$X_1$ and $X_2$ are independent, and so are $Y_1$ and $Y_2$, chain rules give

$$
\begin{aligned}
I(Y_1,Y_2;T)-cI(X_1,X_2;T)
={}&[I(Y_1;T)-cI(X_1;T)]\\
&+I(Y_2;T,Y_1)-cI(X_2;T,X_1).
\end{aligned}
$$

Insert (G3). The last line becomes at most

$$
\begin{aligned}
&\varepsilon_1[I(Y_2;T)-cI(X_2;T)]\\
&+(1-\varepsilon_1)[I(Y_2;T,X_1)-cI(X_2;T,X_1)]
-c\varepsilon_1 I(X_1;X_2\mid T).
\end{aligned}
$$

Both $T$ and $(T,X_1)$ are valid finite auxiliaries for the second source pair.
The first bracket in the earlier display is a valid objective for the first
pair. Bound these three objectives by their respective optima to obtain (G1).
Independent optimal encoders attain $\mathcal L_1(c)+\mathcal L_2(c)$, so the value tensorizes. Zero
conditional mutual information is exactly conditional independence on every
positive label. Pinsker's inequality, applied to each conditional joint law,
proves (G2). $\square$

### Theorem G1b (general strong-data-processing form)

Let $\theta_1\in[0,1]$ be a uniform mutual-information contraction bound for $K_1$:
for every input law and finite Markov chain $U-X_1-Y_1$ through that channel,
$I(U;Y_1)\le \theta_1 I(U;X_1)$. Then (G1) holds with $\varepsilon_1$ replaced by $1-\theta_1$. The stability and conditional-independence conclusions (G2) require $\theta_1<1$. The common-output construction supplies the valid uniform bound
$\theta_1=1-\varepsilon_1$; equivalently, the optimal uniform coefficient is at most $1-\varepsilon_1$. If bounds for both channels are available, exchanging the
two source roles permits the coefficient
$\max(1-\theta_1,1-\theta_2)$ (or $\max(\varepsilon_1,\varepsilon_2)$ for the explicit version).

**Proof.** Conditional on any encoder label, $Y_2-X_1-Y_1$ is a Markov chain
through $K_1$, although its input law may depend on that label. Apply the
uniform contraction bound and average:

$$
I(Y_2;Y_1\mid T)\le\theta_1 I(Y_2;X_1\mid T).
$$

This is exactly (G3) with $\varepsilon_1=1-\theta_1$; the rest of the proof is unchanged.
The common-output proof above proves the displayed explicit contraction bound
and does not require knowledge of its optimal constant. $\square$

No sharpness claim is made for the optimal per-channel stability coefficient;
the equality example below concerns the explicit uniform Doeblin bound.

**Sharpness qualification.** The universal coefficient $\varepsilon_1$ cannot be
uniformly improved in (G1). At $c=1$, take independent fair binary sources,
let $K_1$ erase its bit with probability $\varepsilon_1$, let $K_2$ reveal its bit, and
take $T=X_1 \mathbin{\oplus} X_2$. Each individual optimum is zero, the objective deficit is
$\varepsilon_1 \log 2$, and $I(X_1;X_2|T)=\log 2$. Equality holds. This example establishes
sharpness for the class stated and at $c=1$; it is not a statement that the
bound is sharp for every fixed channel or every slope.

### Corollary G1a (all optimizers and multi-coordinate stability)

If each factor channel has positive common-output mass, every global optimizer
for any finite product source has a product posterior at each encoder label.
For $k\ge 2$, any coordinate ordering gives the sufficient quantitative bound

$$
\sum_{i=1}^k\mathcal L_i(c)-\mathcal L_{1:k}(T;c)
\ge c\left(\prod_{i=1}^{k-1}\varepsilon_i\right)
\operatorname{TC}(X_1,\ldots,X_k\mid T),
\tag{G4}
$$

Here $\mathcal L_{1:k}(T;c)=I(Y_{1:k};T)-cI(X_{1:k};T)$, and conditional total correlation is
$\operatorname{TC}=\sum_i H(X_i|T)-H(X_1,\ldots,X_k|T)$. No dimension-free optimality of this
coefficient is claimed.

**Proof.** Induct using the three-objective decomposition in the proof of G1,
with the remaining block as the second source. Apply the induction bound to
the encoders $T$ and $(T,X_1)$ of that block. Discard the nonnegative term with
coefficient $1-\varepsilon_1$, retain the term with coefficient $\varepsilon_1$, and use

$$
\operatorname{TC}(X_{1:k}\mid T)
=I(X_1;X_{2:k}\mid T)+\operatorname{TC}(X_{2:k}\mid T).
$$

All common masses are at most one, giving (G4). Exact equality at the optimum
forces zero total correlation and hence product posteriors. $\square$

The conclusion concerns the posterior at each label. It **does not** imply
that every optimal encoder is an independent product of scalar encoders.
The weight measures in Section 5 give explicit correlated counterexamples to
that stronger claim.

## 3. Complete posterior contacts, including channels with zeros

For a prior $p$, channel $K$, slope $c>0$, and arbitrary affine tilt $a$, write

$$
g(q)=D(Kq\Vert Kp)-cD(q\Vert p)-a\cdot q,
\quad G=\max_{q\in\Delta_X}g(q),\quad C=\arg\max g.
$$

The affine term can be zero. It also allows the supporting hyperplane of the
concave envelope defining the actual fixed-prior IB objective. For products,
use the additive tilt $(a_1\oplus a_2)(x_1,x_2)=a_1(x_1)+a_2(x_2)$.

### Lemma G2 (no two contacts have the same output)

$K$ is injective on the contact set $C$: if $q,q'$ belong to $C$ and $Kq=Kq'$,
then $q=q'$.

**Proof.** Along a nontrivial segment with fixed output, the output divergence
is constant and the affine term is linear, while $-cD(q\Vert p)$ is strictly
concave. The midpoint of two distinct contacts would exceed $G$. $\square$

### Theorem G3 (exact two-factor contact set)

$G_{12}=G_1+G_2$. A joint posterior $q$ attains this maximum exactly when:

1. Its first marginal $q_1$ is in $C_1$.
2. Each conditional $q_{2|x_1}$ at $q_1(x_1)>0$ belongs to $C_2$.
3. Those conditional posteriors are constant on each connected component of
   the following graph on $\operatorname{supp}(q_1)$: connect $x_1,x'_1$ if a channel output
   $y_1$ has both $K_1(y_1|x_1)>0$ and $K_1(y_1|x'_1)>0$.

In particular, if this graph is connected for every first-factor contact,
then $C_{12}=\{q_1\otimes q_2:q_i\in C_i\}$. Positive common-output mass is a
sufficient condition. Strict positivity of all channel entries is stronger
than necessary.

**Proof.** Let $\nu_1=K_1q_1$. Chain rules for relative entropy and Jensen's
inequality give

$$
\begin{aligned}
D(K_{12}q\Vert K_1p_1\otimes K_2p_2)
={}&D(K_1q_1\Vert K_1p_1)\\
&+\sum_{y_1}\nu_1(y_1)
D\left(\sum_{x_1}q(x_1\mid y_1)K_2q_{2|x_1}\,\middle\Vert\,K_2p_2\right)\\
\le{}&D(K_1q_1\Vert K_1p_1)
+\sum_{x_1}q_1(x_1)D(K_2q_{2|x_1}\Vert K_2p_2).
\end{aligned}
$$

The input divergence and the additive tilt decompose exactly. Thus

$$
g_{12}(q)\le g_1(q_1)+\sum_{x_1}q_1(x_1)g_2(q_{2|x_1})\le G_1+G_2.
$$

Products attain the bound. Equality in the last inequality is exactly
conditions 1 and 2. Equality in Jensen, by strict convexity of divergence in
its first probability vector, says that conditional outputs agree whenever
their source vertices share a positive channel output. Lemma G2 then makes
the conditional posteriors themselves agree along every edge, hence on each
connected component. Conversely condition 3 makes every mixture in Jensen
constant and gives equality. $\square$

For actual IB optimizers, choose an affine supporting hyperplane at the
interior prior for the concave envelope of the un-tilted posterior objective.
Every optimal posterior measure is supported on its contact set, and every
measure on that set with barycenter $p$ is optimal. Theorem G3 consequently
classifies all product-source optimal posterior measures, rather than only
exhibiting one optimal encoder.

The value-additivity argument uses standard entropy chain rules and convexity.
The prior tensorization result [4] is distinguished here from the all-contact equality conditions and the applications below.

## 4. Complete optimal fibers for independent six-state blocks

Consider the family

$$
K_s((j,\sigma)\mid(a,b))
={1+\sigma\sqrt3s(1_{a=j}-1_{b=j})\over6},
\quad 0 \lt s<1/\sqrt3,
$$

with uniform prior on the six ordered distinct pairs $(a,b)$ from three
indices. Its common-output mass is $\varepsilon=1-\sqrt3s>0$. Let
$s_0=24^{-1/4}$. With the equivalent parameter $\eta=\sqrt3s$, the self-contained scalar Theorem A.6 in Appendix A supplies, for each fixed $s$,
a positive interval $(0,R_0(s))$, with strict IB curvature and a complete
six-contact classification. Choose any scalar rate $r$ in that interval and
its positive support slope $c$.

For $k$ independent copies, the exact value is

$$
F_{s,k}(R)=kF_s(R/k),\qquad 0\le R\le k\log6.
\tag{G5}
$$

This is the standard identical-source single-letterization, and it follows
directly by chain rules: put $T_i=(T,Y_1,\ldots,Y_{i-1})$, note
$\sum_i I(X_i;T_i)\le I(X_{1:k};T)$, and use scalar concavity. Independent scalar
encoders attain equality; the finite-support reduction handles any temporary
auxiliary-cardinality excess. Hence strict curvature holds for
$0 \lt R \lt kR_0(s)$. No assertion about whole-interval strict curvature is made.

### Theorem G4 (complete phase and exact dimension)

At total rate $R=kr$, let $Q$ be the scalar six-contact posterior matrix.
Every canonical product-source optimizer, and only such an optimizer, is
obtained by choosing

$$
\mathcal P_k=\{w\ge0:Q^{\otimes k}w=u_6^{\otimes k}\},
\tag{G6}
$$

and deleting zero-weight columns. These are all distinct tensor-product
contacts. There are only $6^k$ of them, so every such representation obeys the
cardinality cap $|T|\le |X|+1=6^k+1$.

For $0 \lt s\le s_0$, the scalar $Q$ is invertible. The sole weight is uniform,
and the unique canonical optimizer has $6^k$ labels and full rank $6^k$.

For $s_0 \lt s<1/\sqrt3$, the scalar rank is five, with kernel spanned by
$v(i,+)=1$, $v(i,-)=-1$. Then

$$
\dim\mathcal P_k=6^k-5^k.
\tag{G7}
$$

An interior optimizer has $6^k$ labels, posterior rank $5^k$, and that exact
nullity. Every optimizer has at least $3^k$ labels, and the lower bound is
attained. Thus the minimum canonical cardinality changes exactly from $6^k$
to $3^k$ across the scalar local threshold, with equality at the threshold on
the unique side. Every minimum-cardinality optimizer has an injective
posterior matrix, despite the multiplicity of such optimizers.

**Proof.** The scalar contact set is exhaustive by Theorem A.6.
Theorem G3 and positivity show that the product contact set is exactly its
Cartesian product. All such contacts have rate $kr$ and relevance $kF_s(r)$.
Uniform weights attain the prior and these costs. Every optimal encoder must
saturate the positive-slope inequality and be supported on these contacts.
Conversely every weight in (G6) attains the same costs, proving completeness.

The tensor matrix has rank $(\operatorname{rank}Q)^k$. Uniform weights are strictly
positive, so (G6) has relative dimension its affine kernel dimension, giving
(G7). The invertible case follows at once.

For the minimum-cardinality assertion, let $b_i$ be the length-six row vector
which is one on the two columns $(i,+),(i,-)$ and zero elsewhere. It is
orthogonal to the sole scalar kernel vector and therefore belongs to the row
space of $Q$. Consequently every tensor row
$b_{i_1}\otimes\ldots\otimes b_{i_k}$ belongs to the row space of $Q^{\otimes k}$.
Comparing any feasible $w$ to the uniform feasible weight gives

$$
\sum_{\sigma_1,...,\sigma_k\in\{+,-\}}
w_{(i_1,\sigma_1),...,(i_k,\sigma_k)}=3^{-k}
\quad\text{for every }(i_1,...,i_k)\in\{1,2,3\}^k.
\tag{G8}
$$

At least one positive weight is required in each of $3^k$ disjoint groups.
The scalar three positive-sign columns average to the prior; their tensor
product realizes exactly one column per group with weight $3^{-k}$ and has
exactly $3^k$ labels. For any minimum-support choice, the group-indicator rows
restricted to its columns form the identity matrix, so those columns are
linearly independent. $\square$

## 5. Correlated minimum representations and their exact count

The minimum-cardinality representations are not limited to independent
products of the two scalar three-label endpoint choices.

### Theorem G5 (many minimum encoders)

In the nonunique phase, for every $k\ge 1$ there are at least

$$
2^{1+3+...+3^{k-1}}=2^{(3^k-1)/2}
\tag{G9}
$$

distinct minimum-cardinality canonical global optimizers at the same rate.
Every two different members are Blackwell-incomparable.

**Proof.** Choose independently arbitrary sign functions

$$
\sigma_j=f_j(i_{j+1},...,i_k),\quad 1\le j \lt k,
\qquad \sigma_k\in\{+,-\}.
$$

For each index tuple $i$, place weight $3^{-k}$ on precisely the product
contact with these signs. Summing first over $i_1$ replaces its scalar
posterior by $u_6$, because its sign is fixed conditional on the later indices.
Continue over $i_2,\ldots,i_k$; the barycenter is $u_6^{\otimes k}$. Thus (G6)
holds, and (G8) makes the support minimum. The number of independent binary
choices is $1+3+\ldots+3^{k-1}$. Different choices give different posterior
measures because all product contacts are distinct.

If one finite canonical representation is a garbling of another with the
same $I(X;T)$, each coarser posterior is a mixture of finer posteriors.
Equality of the average entropies and strict concavity of entropy require
every positive mixture to combine identical posteriors. Canonicalization
then leaves exactly the same weighted posterior measure. Two distinct
members therefore cannot be garblings of each other. $\square$

The count (G9) is a constructive lower bound for $k\ge 3$, not a classification
of all minimum encoders or all polytope vertices. The next statement is exact
only for two factors.

### Theorem G6 (exactly 28 minimum representations for two factors)

For $k=2$, the nonunique phase has exactly 28 canonical minimum-support
posterior measures, all with nine labels and equal weights $1/9$. Their signs
at index pair $(i,j)$ have the form

$$
\sigma_1=f(j),\qquad \sigma_2=g(i),
$$

where $f,g:\{1,2,3\}\to\{-1,+1\}$ and at least one of $f,g$ is constant.

**Proof.** By (G8), a nine-support measure chooses one sign pair at each
index pair and assigns it weight $1/9$. The scalar row space is exactly

$$
W=\{a(i)+\sigma b(i):\ a\in\mathbb R^3,
\ b\in\mathbb R^3,\ \sum_i b(i)=0\}.
$$

Tensor feasibility is equivalent to matching uniform-weight expectations
for every function in $W\otimes W$. Taking a centered sign-bearing factor
in the first coordinate and an arbitrary sign-free function in the second
forces, for each fixed $j$, the first sign to be constant in $i$. Similarly
the second sign is constant in $j$. Thus the signs have the displayed form.

For the remaining sign-bearing/sign-bearing constraints, the expectation
factorizes as

$$
{1\over9}\left(\sum_i g(i)b_1(i)\right)
\left(\sum_j f(j)b_2(j)\right)=0
$$

for every pair of centered vectors $b_1,b_2$. This holds if and only if $f$
or $g$ is constant. These conditions also suffice, since the four tensor
types span $W\otimes W$. There are $8\cdot2=16$ choices with $g$ constant and
another 16 with $f$ constant, of which four have both constant. The total is
$16+16-4=28$. $\square$

## 6. Full posterior curvature

Fix $(3/8)^{1/4}<\eta<1$ throughout this section. This is the strictly positive edge phase; every global-optimality assertion below uses this range. Some algebraic formulas also apply outside it, as explicitly indicated.

### 6.1 Channel and exact edge contact

Let $X$ be uniform on the six ordered pairs $(a,b)$, $a,b\in\{1,2,3\}$, $a\ne b$. The channel is

$$
K_\eta((j,\sigma)\mid(a,b))
=\frac{1+\sigma\eta(\mathbf1_{a=j}-\mathbf1_{b=j})}{6},
\qquad j\in\{1,2,3\},\quad\sigma\in\{-1,1\}.
$$

All entries are strictly positive when $0<\eta<1$. Both marginals are uniform. The parameter in Appendix A is $s=\eta/\sqrt3$, and its nonunique edge phase is exactly $\eta^4>3/8$.

For $h>0$, select the contact

$$
q_h(a,b)=\frac{\exp[h(\mathbf1_{a=1}-\mathbf1_{b=1})]}{Z_h},
\qquad Z_h=2(1+2\cosh h),
\qquad r_h=\frac{\sinh h}{1+2\cosh h}.
$$

Its divergence vector is $d_h=(2r_h,-r_h,-r_h)$. Its input/output divergences and supporting slope are

$$
R_h=2hr_h-\log\frac{1+2\cosh h}{3},
\qquad
C_h=\frac{f(2\eta r_h)+2f(\eta r_h)}3,
$$

$$
c_h=\frac{\eta}{3h}\bigl[\operatorname{atanh}(2\eta r_h)
+\operatorname{atanh}(\eta r_h)\bigr],
$$

where

$$
f(z)=\tfrac12[(1+z)\log(1+z)+(1-z)\log(1-z)].
$$

Define the single-posterior supporting objective

$$
L_h(q)=D(K_\eta q\Vert u_6)-c_hD(q\Vert u_6).
$$

The slope is positive. For sufficiently small $h>0$, Theorem A.6 shows that $q_h$ and its five symmetry mates exhaust all global posterior maximizers. The following calculations also hold at any positive $h$ as calculations of the edge stationary branch, without asserting global optimality there.

### 6.2 Exact two-dimensional Hessian

Put $v_{ab}=(e_a-e_b)/\sqrt2$ in the zero-sum Euclidean plane, and let $m=\sum q_{ab}v_{ab}$. Thus $d=\sqrt2m$. Let $I(m)$ be the minimum input divergence among posteriors with mean $m$, and let $q_m$ be its unique positive entropy minimizer in a neighborhood of $m_h$. It is a two-parameter exponential family. The reduced objective is

$$
\ell_h(m)=C_\eta(m)-c_hI(m),
\qquad C_\eta(m)=\frac13\sum_jf(\sqrt2\eta m_j).
$$

Choose orthonormal vectors

$$
e_r=(2,-1,-1)/\sqrt6,
\qquad e_t=(0,1,-1)/\sqrt2.
$$

At the selected contact $m_h=\sqrt3r_he_r$, reflection exchanging vertices 2 and 3 changes the sign of $e_t$, fixes $e_r$, and preserves the objective. Hence all radial/tangential cross derivatives vanish exactly.

Write $b=\cosh h$. A direct expectation under $q_h$ gives the covariance of $v_X$:

$$
V_r=\operatorname{Var}_{q_h}\langle v_X,e_r\rangle
=\frac{3(b+2)}{2(1+2b)^2},
\qquad
V_t=\operatorname{Var}_{q_h}\langle v_X,e_t\rangle
=\frac{b+2}{2(1+2b)}.
$$

For completeness, $\langle v_X,e_r\rangle$ takes values $\sqrt3/2,0,-\sqrt3/2$, with unnormalized weights $2e^h,2,2e^{-h}$. The tangential squared coordinate equals $1/4$ on the four pairs incident to vertex 1 and equals 1 on the other two pairs; its expectation is therefore $(b+2)/Z_h$. The covariance is diagonal by reflection. Legendre duality consequently gives $I_{rr}=1/V_r$ and $I_{tt}=1/V_t$.

Because $f''(z)=1/(1-z^2)$, direct differentiation of $C_\eta$ gives

$$
C_{rr}=\frac{2\eta^2}{9}
\left[\frac2{1-4\eta^2r_h^2}+\frac1{1-\eta^2r_h^2}\right],
\qquad
C_{tt}=\frac{2\eta^2}{3(1-\eta^2r_h^2)}.
$$

Therefore the **exact** two eigenvalues of the reduced Hessian are

$$
\boxed{\lambda_r(h)=C_{rr}-\frac{c_h}{V_r}},
\qquad
\boxed{\lambda_t(h)=C_{tt}-\frac{c_h}{V_t}}.
$$

These are eigenvalues in the Euclidean mean plane; they are not claimed to equal the eigenvalues of the five-dimensional Hessian in raw posterior coordinates.

### 6.3 Strict signs throughout a punctured neighborhood

All exact expressions are real analytic at $h=0$ after the removable singularity in $c_h$ is filled. Taylor expansion yields

$$
c_h=\frac{\eta^2}3
+\frac{\eta^2(2\eta^2-3)}{54}h^2
+\frac{\eta^2(88\eta^4-180\eta^2+117)}{9720}h^4
+O(h^6),
$$

$$
\lambda_r(h)=\frac{2\eta^2(2\eta^2-3)}{27}h^2
+\frac{2\eta^2(44\eta^4-45\eta^2-9)}{1215}h^4
+O(h^6),
$$

$$
\lambda_t(h)=-\frac{\eta^2(8\eta^4-3)}{810}h^4+O(h^6).
$$

For $0<\eta\le1$, the leading radial coefficient is negative. For $\eta^4>3/8$, the leading tangential coefficient is also negative. Analytic remainder control therefore gives a positive $h_0(\eta)$ for which both are strictly negative for all $0 \lt h \lt h_0$. This is a whole open-interval statement, not a sign inference from finitely many numerical evaluations.

The same calculation independently detects the phase boundary in Theorem A.6: when $\eta^4<3/8$, the edge branch has a positive tangential Hessian eigenvalue for sufficiently small $h>0$, so it is a saddle and cannot be a posterior maximum. This observation does not replace the exhaustive vertex-phase proof in Appendix A.

#### A rational strictly positive channel

The convenient exact choice $\eta=4/5$ lies above the threshold because $256/625>3/8$. Every channel entry then belongs to $\{1/30,1/6,3/10\}$, so the channel and joint law are rational and strictly positive. The above expressions become

$$
c_h=\frac{16}{75}-\frac{344}{16875}h^2
+\frac{47306}{18984375}h^4+O(h^6),
$$

$$
\lambda_r(h)=-\frac{1376}{16875}h^2
-\frac{395552}{18984375}h^4+O(h^6),
$$

$$
\lambda_t(h)=-\frac{1384}{6328125}h^4
+\frac{8684}{10546875}h^6+O(h^8).
$$

The accompanying `global/verify_posterior_hessian.py` checker regenerates these coefficients from the exact covariance/output formulas. It is an algebra check, not a numerical global-optimization certificate.

### 6.4 Lift to the full posterior simplex

Let $Aq=\sum_xq(x)v_x$. For all posteriors near a positive contact, the exponential-family identity gives the exact relative-entropy decomposition

$$
D(q\Vert u_6)=I(Aq)+D(q\Vert q_{Aq}).
\tag{H1}
$$

Indeed $\log(q_m(x)/u_6(x))=t(m)\cdot v_x-\psi(t(m))$; its expectations under $q$ and $q_m$ agree whenever $Aq=m$. Subtracting the two relative entropies proves (H1).

Choose coordinates $(m,z)$ with

$$
q=q_m+z,
\qquad \sum_xz(x)=0,
\qquad Az=0.
$$

The space of such $z$ has dimension three. These are valid local coordinates on the five-dimensional simplex because $A(Dq_m\,dm)=dm$. Since the output law depends only on $m$, (H1) implies the exact identity

$$
L_h(q_m+z)=\ell_h(m)-c_hD(q_m+z\Vert q_m).
$$

At $z=0$, the quadratic expansion of the last divergence is $\frac12\sum_xz(x)^2/q_m(x)$. Its mixed quadratic derivatives in $m,z$ vanish. At the stationary contact, the full Hessian is therefore congruent to

$$
\begin{pmatrix}\lambda_r&0\\0&\lambda_t\end{pmatrix}
\quad\oplus\quad
\left[-c_h\sum_x\frac{z(x)^2}{q_h(x)}\right]_{
\{\mathbf1^Tz=0,\,Az=0\}}.
\tag{H2}
$$

Equivalently, for every tangent displacement $\dot q=Dq_{m_h}\dot m+z$,

$$
D^2L_h(q_h)[\dot q,\dot q]
=D^2\ell_h(m_h)[\dot m,\dot m]
-c_h\sum_x\frac{z(x)^2}{q_h(x)}.
$$

Strict positivity of $q_h$ and $c_h$, together with Section 6.3, makes this negative for every nonzero simplex tangent. The five-dimensional Hessian is strictly negative definite. Symmetry gives the same result for all six contacts.

### 6.5 Tensor products preserve strict posterior curvature

The nondegeneracy is stable under arbitrary finite products. This statement concerns curvature and does not assume that a tensorized posterior is globally optimal unless that is independently supplied by a tensorization theorem.

For a positive posterior $q$, put $p_Y=Kq$ and define the normalized Fisher matrix

$$
M_q=\operatorname{diag}(\sqrt q)K^T
\operatorname{diag}(1/p_Y)K\operatorname{diag}(\sqrt q).
$$

It is symmetric positive semidefinite, has $M_q\sqrt q=\sqrt q$, and satisfies $M_q\preceq I$. The latter inequality is conditional Jensen: writing $z_x=\sqrt{q_x}a_x$, its quadratic form is $\mathbb E[(\mathbb E[a(X)\mid Y])^2]\le\mathbb E[a(X)^2]$. The posterior Hessian is

$$
D^2L(q)=\operatorname{diag}(1/\sqrt q)
(M_q-cI)\operatorname{diag}(1/\sqrt q).
$$

The simplex tangent corresponds to $\sqrt q^\perp$. Thus strict posterior curvature is equivalent to every eigenvalue of $M_q$ on that orthogonal complement being strictly less than $c$.

For independent product contacts $q^{(1)}\otimes\cdots\otimes q^{(k)}$ under the product channel, the normalized Fisher matrix is exactly $M_{q^{(1)}}\otimes\cdots\otimes M_{q^{(k)}}$. Assume the factors have strict posterior curvature at the same slope $0 \lt c<1$. Every nonconstant eigenvalue of the tensor product has at least one factor strictly below $c$; all other factors lie in $[0,1]$. Therefore every such eigenvalue is below $c$. The product posterior Hessian is strictly negative definite on its entire $(6^k-1)$-dimensional simplex tangent.

Theorem G4 identifies the $6^k$ product contacts as the complete contact set, with matrix $Q^{\otimes k}$. The general constrained-Hessian theorem in Section 7 then applies. Since $\operatorname{rank}(Q^{\otimes k})=5^k$, the constrained representation Hessian has exact nullity

$$
\boxed{6^k-5^k}.
$$

All these directions change weights only. No zero direction occurs at an individual posterior contact, even though the dimension of the global optimum fiber grows exponentially.

## 7. The exact normalized BA residual kernel

### 7.1 A general exposed-contact hypothesis

Let the source probability vector $p$ have $n$ strictly positive coordinates, let the channel $K$ have strictly positive entries, and put $r=Kp$. Fix $c>0$ and define

$$
L_c(q)=D(Kq\Vert r)-cD(q\Vert p),\qquad q\in\Delta_n.
$$

Suppose there is an affine supporting certificate

$$
L_c(q)-a^Tq\le b
\tag{B1}
$$

whose equality set consists of $m$ distinct, strictly positive posterior vectors $q_1,\ldots,q_m$. Let $Q$ be the $n\times m$ matrix of those columns. Assume $Qw=p$ has a solution $w>0$. Finally, assume the Hessian of $L_c$ at each $q_i$ is strictly negative definite on the simplex tangent space $\{v:\mathbf1^Tv=0\}$. The Hessian of the affine term is zero. For the explicit cardinality-limited classification below, take $m\le n+1$; the local Jacobian result itself does not require this cap.

Every feasible weight vector $w\ge0$ with $Qw=p$ defines the encoder

$$
e_i(x)=P(T=i\mid X=x)=w_iq_i(x)/p_x.
\tag{B2}
$$

The weighted sum of its posterior supporting objectives is exactly $b+a^Tp$. All encoders have value at most this number by averaging (B1). Equality is possible only on the contact set. Thus the polytope

$$
\mathcal P=\{w\ge0:Qw=p\}
\tag{B3}
$$

is the entire family of canonical optimal representations, with zero weights removed. If its interior relative to the affine constraint contains a positive vector, its dimension is $m-\operatorname{rank}Q$. This is an elementary consequence of a supporting certificate; the new algorithmic conclusion is the exact Jacobian criterion below.

Two distinct contacts cannot have the same decoder $Kq$. Indeed, on a line with $Kq$ fixed, $L_c(q)-a^Tq$ is strictly concave because $c>0$ and relative entropy is strictly convex. The midpoint of two distinct maximizing contacts with equal decoder would exceed $b$. Therefore all decoders $d_i=Kq_i$ are distinct. In particular, positive weights in (B3) yield reduced roots in the convention that removes only zero weights and duplicate decoders.

### 7.2 Exact constrained Hessian

Write the IB maximand as

$$
J_c(e)=I(Y;T)-cI(X;T)=\sum_i w_i L_c(q_i).
$$

Positive encoder arrays with row sums one are smoothly and invertibly represented by positive $(w,q)$ satisfying $\mathbf1^Tq_i=1$ and $\sum_iw_iq_i=p$. The inverse is (B2). For a tangent vector, write $v_i=\dot w_i$ and $z_i=\dot q_i$. Its constraint is

$$
Qv+\sum_iw_i z_i=0,\qquad 1^Tz_i=0.
\tag{B4}
$$

Subtracting the mixture-constraint multiplier $a$ from $J_c$ and subtracting $b$ times the total-weight constraint gives a stationary Lagrangian. At a contact, $\nabla L_c(q_i)-a$ is a multiple of the all-ones vector. Consequently the second variation on (B4) is exactly

$$
\operatorname{Hess}J_c[(v,z),(v,z)]
=\sum_i w_i z_i^T\nabla^2L_c(q_i)z_i.
\tag{B5}
$$

The mixed terms vanish because $z_i$ is tangent to its simplex. One can equivalently differentiate a feasible twice-differentiable path: all terms involving second derivatives of $w$ and $q$ cancel using the second derivative of the mixture constraint and the contact equality (B1).

Under the strict contact-Hessian assumption, (B5) is negative semidefinite and its kernel is exactly

$$
z_i=0\ \hbox{for every }i,\qquad Qv=0.
\tag{B6}
$$

In particular, the kernel has dimension $m-\operatorname{rank}Q$. This is a statement about all encoder perturbations, including changes in the posterior columns, and not just a lower bound supplied by visibly flat weights.

### 7.3 The normalized BA maps and their kernels

Set $\beta=1/c$. Use encoder coordinates $e_i(x)>0$ with $\sum_i e_i(x)=1$. Define the decoder-coordinate map $\Phi$ by

$$
w_i=\sum_xp_x e_i(x),\qquad
d_i(y)=\frac{\sum_xp_xK(y\mid x)e_i(x)}{w_i}.
\tag{B7}
$$

For positive normalized $(w,d)$, define $\Psi$ by

$$
\Psi_i(x;w,d)=
\frac{w_i\exp\{\beta\sum_yK(y\mid x)\log d_i(y)\}}
{\sum_j w_j\exp\{\beta\sum_yK(y\mid x)\log d_j(y)\}}.
\tag{B8}
$$

The usual KL form differs only by a factor depending on $x$, which cancels in (B8). The encoder BA map is $B_E=\Psi\circ\Phi$, and the decoder BA map is $B_D=\Phi\circ\Psi$. Every positive IB stationary point is a fixed point of these maps, by differentiating $\mathcal L_\beta=I(X;T)-\beta I(Y;T)$ under the encoder row constraints.

Here is the exact Hessian-to-Jacobian calculation. The encoder gradient satisfies

$$
\frac1{p_x}\frac{\partial\mathcal L_\beta}{\partial e_i(x)}
=\log e_i(x)-\log w_i
-\beta\sum_yK(y\mid x)\log\frac{d_i(y)}{r_y}.
\tag{B9}
$$

The right side is $\log(e_i(x)/B_{E,i}(x))+A_x$, with $A_x$ independent of label $i$. At a fixed point, for any encoder-simplex tangent vectors $u,v$, differentiation and cancellation of the row-constant derivative give

$$
\operatorname{Hess}\mathcal L_\beta[u,v]
=\sum_{x,i}\frac{p_x}{e_i(x)}u_i(x)
\bigl[(I-DB_E)v\bigr]_i(x).
\tag{B10}
$$

Since $B_E$ is row-normalized, $(I-DB_E)v$ is a row-sum-zero tangent vector. The positive diagonal form on the right of (B10) is nondegenerate on the tangent space. More explicitly, if it vanishes against every tangent $u$, then $p_x[(I-DB_E)v]_i(x)/e_i(x)$ is constant in $i$. Summing $(I-DB_E)v$ over $i$ makes that constant zero. Hence

$$
\ker\operatorname{Hess}\mathcal L_\beta
=\ker(I-DB_E).
\tag{B11}
$$

No claim about a numerical eigensolver is used here.

For any compatible linear maps $A$ and $B$, their restrictions give mutually inverse maps between $\ker(I-BA)$ and $\ker(I-AB)$. Apply this to $A=D\Phi$ and $B=D\Psi$. It follows that the encoder and decoder BA residuals have isomorphic kernels. In particular, a vector from (B6) maps to

$$
\dot d_i=0,\qquad \dot w_i=v_i.
\tag{B12}
$$

Positive logarithmic coordinates are a smooth change of coordinates on the normalized manifolds. Thus the log-decoder residual has the same nullity, with kernel vectors

$$
\dot{\log d_i(y)}=0,\qquad
\dot{\log w_i}=v_i/w_i,\quad Qv=0.
\tag{B13}
$$

If the BA map is extended to an ambient positive coordinate space before imposing normalization, every residual-kernel vector is nevertheless tangent to the normalized output manifold, because $v=DB_Dv$ and the output of $B_D$ is normalized. This introduces no additional residual-kernel directions.

### Theorem B1 (exact reduced-root nullity)

Under the exposed-contact and strict contact-curvature hypotheses of Section 7.1, the BA residual Jacobian at every positive-weight optimal representation has nullity

$$
\boxed{\dim\ker(I-DB)=m-\operatorname{rank}Q.}
\tag{B14}
$$

This holds in encoder, decoder and normalized log-decoder coordinates. The root is reduced because its positive-weight decoders are pairwise distinct. Its residual Jacobian is nonsingular exactly when its posterior columns are linearly independent.

For a boundary weight vector, delete its zero labels. The local kernel proof uses only the active contacts and applies to the support $S$, without asserting that inactive global contacts cease to exist. The nullity is then $|S|-\operatorname{rank}Q_S$.

The implication that a smooth family of roots yields a Jacobian kernel is familiar. Equation (B14) additionally proves that there are no other kernel directions under a checkable single-posterior condition, and separates information-cost curvature from representation identifiability.

## 8. Persistent singular global optima

Section 6 proves strict negative contact Hessians throughout a nonempty low-rate interval of the channel

$$
K_\eta((j,\sigma)\mid(a,b))
=\frac{1+\sigma\eta(\mathbf1_{a=j}-\mathbf1_{b=j})}{6},
\quad (3/8)^{1/4}<\eta<1.
$$

On this interval its complete six-contact matrix $Q_h$ has rank five. In the grouped order $(1,+),(2,+),(3,+),(1,-),(2,-),(3,-)$, its kernel is spanned by $(1,1,1,-1,-1,-1)^T$. Its globally optimal weights are

$$
w_{i,+}=(1+\delta)/6,\qquad
w_{i,-}=(1-\delta)/6,\qquad -1\le\delta\le1.
\tag{B15}
$$

At every interior $-1<\delta<1$, Theorem B1 gives exactly one null direction. At each endpoint, the remaining three posterior columns are independent and its three-label residual Jacobian is nonsingular. All six decoders at interior weights are distinct, every source/channel/encoder/decoder probability is positive, and the attained scalar tradeoff has strictly negative second derivative.

For $\eta=4/5$, the channel entries are rational and belong to $\{1/30,1/6,3/10\}$. The supporting slope $c_h$ is analytic for $h>0$ and strictly decreases on a sufficiently small interval. Thus $h$ and $\beta=1/c_h$ are smooth local coordinates there. The contact cardinality, symmetry type, and posterior rank are constant throughout the interval; the contact positions vary analytically. Around any positive-weight root, split the encoder tangent space into the fiber (B6) and a complementary space. The Hessian is invertible on the complement. The implicit function theorem applied to the complementary stationary equations shows that the displayed family exhausts all nearby stationary roots; no other nearby stationary branch appears. Allowing $\beta$ to vary gives a local product of a $\beta$ interval and a weight interval.

This supplies persistent singular reduced roots without changing the local root-manifold type, merging decoder clusters, losing labels, or producing an affine segment of the tradeoff on the interval in question. It addresses a stronger claim that reduction alone ensures isolated, nonsingular roots. It does not assert genericity under arbitrary perturbations of a six-by-six channel, and it does not settle the original conjecture requiring strict concavity on the entire rate range.



### Corollary B2 (all finite block lengths)

Fix $(3/8)^{1/4}<\eta<1$. For every finite $k\ge1$, there is a nonempty rate interval on which the $k$-block IB value is strictly concave, all individual optimal posterior contacts have a strictly negative full-simplex Hessian, and every positive-weight representation on all $6^k$ contacts has exactly $6^k-5^k$ normalized BA null directions. Every minimum $3^k$-label canonical optimum is nonsingular. Distinct minimum optima remain statistically distinct and Blackwell-incomparable.

**Proof.** Intersect the scalar global-contact interval of Theorem A.6 with the strict-curvature interval of Section 6; it is nonempty for each fixed $\eta$ and needs no effective numerical endpoint. Theorem G4 gives all product contacts, their exact ranks, and their minimum supports. Section 6.5 gives strict curvature at every product contact. Theorem B1 gives the exact residual nullity on any active support, and the independent columns of every minimum support give nullity zero. Theorem G5's entropy argument proves incomparability for every two distinct optimal measures at the same rate. The contact paths and their positive weight fibers are analytic with constant rank on the interval, so the same complementary implicit-function argument gives a local product of the slope interval and the fiber interior at each positive root. $\square$

The exponential nullity counts representation freedom, not a failure of value tensorization. The two-factor examples have 36 contacts, posterior rank 25, fiber dimension 11, and exactly 28 minimum nine-label optima. Only four of those are independent products of scalar minimum encoders. Thus posterior factorization at each label and independent factorization of the entire encoder are distinct assertions.

## 9. Two regular ways to select a continuation

### 9.1 Sparse nonsingular selections

A feasible $w$ in (B3) is a vertex of that polytope exactly when $Q_S$ has independent columns on its positive support $S$. A dependence gives a two-sided feasible displacement; independence rules one out. Therefore every exposed-contact optimal family in Section 7.1 contains at least one supported optimum with a nonsingular residual Jacobian. Such an optimum has at most $\operatorname{rank}Q$ positive labels. This assertion does not say that the selection is unique, nor that different selected optima represent the same statistical experiment.

As long as a fixed independent support remains feasible with positive weights and the contact conditions persist, it has an ordinary local nonsingular BA continuation. Choosing a vertex is an additional selection rule beyond deleting duplicate or zero-mass labels.

### 9.2 An analytic entropy-selected section of the entire fiber

Suppose $Q(c)$ is analytic, has constant rank $r_Q$, and its positive fiber remains nonempty on a parameter neighborhood. Define $w_*(c)$ to maximize Shannon entropy $-\sum_iw_i\log w_i$ over $Q(c)w=p$. Strict concavity gives uniqueness. Existence of a strictly positive feasible vector excludes a boundary maximizer: mixing such a vector into a boundary candidate gives an entropy gain of order $t\log(1/t)$, dominating the $O(t)$ changes in its positive coordinates. Hence $w_*$ is positive.

Choose $r_Q$ independent rows $A(c)$ of $Q(c)$ on a fixed neighborhood, and denote the corresponding entries of $p$ by $p_A$. All remaining row constraints are locally implied: constant rank gives row dependence, and the existing full feasible vector forces the same dependence for $p$. The selected weights and multipliers $\lambda$ obey

$$
\log w_*+\mathbf1+A^T\lambda=0,\qquad Aw_*=p_A.
\tag{B16}
$$

Their derivative matrix is the bordered system

$$
M=\begin{pmatrix}\operatorname{diag}(1/w_*)&A^T\\A&0\end{pmatrix}.
\tag{B17}
$$

It is nonsingular: writing $D=\operatorname{diag}(1/w_*)$, if $Dv+A^T\mu=0$ and $Av=0$, then $v^TDv=0$, hence $v=0$ and then $\mu=0$ by full row rank. The analytic implicit function theorem proves that the entropy-selected section is analytic. Its velocity is obtained from the well-defined linear system

$$
M\binom{w_*'}{\lambda'}
=\binom{-A'^T\lambda}{-A'w_*}.
\tag{B18}
$$

For the symmetric six-state contacts, the unique entropy maximizer is the uniform vector, so this rule fixes $\delta=0$ and the selected weights have zero derivative. If contacts are specified as isolated maxima of an analytic $L_c$ with affine multiplier $a(c)$, their simplex-coordinate derivatives satisfy

$$
H_i q_i'=\nabla_T D(q_i\Vert p)+a_T',
\tag{B19}
$$

where $H_i$ is the invertible contact Hessian and the subscript $T$ denotes projection into simplex tangent coordinates. In the symmetric case $a=0$. Equations (B18)–(B19) avoid inversion of the persistently singular full BA residual Jacobian.

These are local continuation statements conditional on the stated contact and rank hypotheses. In the general setting they select optima at a fixed supporting slope $c$; contacts may have different input costs, so a separately prescribed rate would require an additional cost-row constraint. The six-state and product applications have equal contact costs and hence automatically preserve their common rate. These results do not provide a globally convergent arbitrary-channel IB algorithm, do not determine unknown contact sets, and give no crossing rule at a change of contact set or rank. Entropy selection chooses one of many statistically distinct optimal representations; it does not make the others redundant.

## 10. Reproduction, comparison, and unresolved scope

Three independent kinds of computation accompany the analytic proofs. The exact rational enumeration in `general/check_exact_fibers.py` checks all $4^9=262144$ two-block minimum-support sign choices at $e^h=2$ and returns precisely the 28 measures classified in Theorem G6, with ranks 5 and 25. The symbolic program `global/verify_posterior_hessian.py` regenerates the stated curvature series and their rational specialization. The program `verify_ba_kernel.py` checks exact posterior ranks, barycenters, distinct decoders, BA fixed points, explicit kernel vectors, and the analytic log-decoder derivative against an independent numerical derivative. Saved JSON records state the precision, tolerances, and scope of these checks.

These computations corroborate identities and finite classifications. They do not turn the sample values of $h$ into certificates of global optimality. That certificate is the analytic localization and complete angular classification in Appendix A, combined with Section 3. No plotted phase diagram, floating-point singular value, or search failing to find a competitor is used as a proof of the existence or extent of a global phase.

The comparison with flagship information-theory work concerns substantive structure. Parker, Dimitrov, and Gedeon [8] connect bifurcation theory to information-theoretic optimization and algorithmic behavior; those methods and their prior achievements are credited. Agmon [9] develops general implicit-derivative root tracking under its stated hypotheses. The contribution here is an exact criterion for all kernel directions under posterior nondegeneracy, a certified positive family where zero/duplicate removal leaves a persistent optimum manifold, its full product representation theory, and concrete regular selections. We do not claim arbitrary-channel global convergence, a new operational coding region, optimal dimension-free stability constants, or a comprehensive classification of all minimal sign patterns for $k\ge3$.

The whole-interval question in [1] has not been settled. Strict concavity on the local intervals proved here cannot be substituted for strict concavity on $[0,H(X)]$. The present bounded contribution stands on the explicitly stated and proved structural theorems. Full-manuscript Lean verification has not been completed.

## Appendix A. The inherited scalar low-rate foundation

This appendix restates and proves the scalar results inherited from the
earlier manuscript. They supply the six-state factor used in the new
product and representation theorems; they are not counted as new discoveries
of the present expansion. The canonical-representation question comes from
[1], and the distinction between existence and classification of all optimal
representations is emphasized in [2]. Learning-onset perturbation and its
connection to strong data processing are established methods [3]. We give
the finite-dimensional calculation and the global-localization argument in
full because both the exact critical parameter and exclusion of off-axis
competitors are needed here. The result concerns a nonempty low-rate
interval. It makes no claim that the complete bottleneck curve is strictly
concave.

### A.1. Source, channel, and mean coordinates

Let
$$
\mathcal X=\{(a,b):a,b\in\{1,2,3\},\ a\ne b\},
\qquad P_X=u_6.
$$
For a fixed parameter $0<\eta<1$, let the output alphabet be
$\mathcal Y=\{(j,\sigma):j\in\{1,2,3\},\ \sigma\in\{-1,1\}\}$ and set
$$
K_\eta((j,\sigma)\mid(a,b))
=\frac{1+\sigma\eta(\mathbf1_{a=j}-\mathbf1_{b=j})}{6}.
\tag{A.1}
$$
This channel is strictly positive, both marginals are $u_6$, and its common
output mass is $1-\eta$. Write
$$
s=\frac\eta{\sqrt3},\qquad k=s^2=\frac{\eta^2}{3}.
\tag{A.2}
$$

For any posterior $q\in\Delta_6$, define
$$
d_i(q)=\sum_{b\ne i}q_{ib}-\sum_{a\ne i}q_{ai}.
\tag{A.3}
$$
Its feasible set is the hexagon
$$
\mathcal K=\{d\in[-1,1]^3:d_1+d_2+d_3=0\},
$$
the convex hull of the six vectors $e_a-e_b$. The posterior output law is
$(K_\eta q)_{i,\pm}=(1\pm\eta d_i(q))/6$. With
$$
f(z)=\frac{(1+z)\log(1+z)+(1-z)\log(1-z)}2,
$$
continuously extended to $[-1,1]$, its divergence is
$$
C_\eta(d):=D(K_\eta q\Vert u_6)
=\frac13\sum_{i=1}^3 f(\eta d_i).
\tag{A.4}
$$

The input cost at a fixed mean is
$$
I(d)=\min\{D(q\Vert u_6):d(q)=d\}.
\tag{A.5}
$$
Let $E=\{z\in\mathbb R^3:\sum_i z_i=0\}$ with its Euclidean inner product.
The unit vectors
$$
v_{ab}=\frac{e_a-e_b}{\sqrt2}
$$
form a regular hexagon in $E$. The normalized posterior mean is
$m=d/\sqrt2\in E$. Fix the orthonormal basis
$$
b_1=\frac{(1,-1,0)}{\sqrt2},\qquad
b_2=\frac{(1,1,-2)}{\sqrt6}.
$$
Write
$$
m=\rho(\cos\theta\,b_1+\sin\theta\,b_2),
\qquad \rho^2=\frac12\sum_i d_i^2.
\tag{A.6}
$$
Thus $\theta=0$ points at source vertex $v_{12}$ and $\theta=\pi/6$ points at
the adjacent edge midpoint direction. The ordered source vertices
$(12,13,23,21,31,32)$ have angles $0,\pi/3,\ldots,5\pi/3$.

### Proposition A.1. Exact entropy minimization and analyticity

For
$$
M(a)=\frac16\sum_{i\ne j}e^{a_i-a_j},
$$
one has
$$
I(d)=\sup_{a\in\mathbb R^3}\{a\cdot d-\log M(a)\}.
\tag{A.7}
$$
For every $d$ in the relative interior of $\mathcal K$, the minimum in (A.5)
is unique and has the form
$$
q_{ij}(a)=\frac{e^{a_i-a_j}}{6M(a)}.
\tag{A.8}
$$
Near zero, $J(m):=I(\sqrt2m)$ is real analytic and is the Legendre transform
of
$$
\psi(t)=\log\left(\frac16\sum_{a\ne b}e^{\langle t,v_{ab}\rangle}\right),
\qquad t\in E.
\tag{A.9}
$$

**Proof.** For a posterior with mean $d$, the identity
$$
D(q\Vert q(a))=D(q\Vert u_6)-a\cdot d+\log M(a)
$$
gives the lower bound in (A.7). A minimizing posterior exists by compactness
and is unique by strict convexity of divergence. An interior mean has a
strictly positive feasible posterior. If its minimizer had a zero coordinate,
mixing it toward that positive posterior would preserve the mean and have
negative infinite first derivative of input divergence, a contradiction.
Lagrange multipliers on the positive minimizer therefore give (A.8), attaining
(A.7). The log partition function in (A.9) has gradient zero and Hessian
$\tfrac12\operatorname{Id}_E$ at the origin. The analytic inverse function
theorem gives an analytic inverse mean-to-tilt map near zero and hence the
analytic Legendre transform. Boundary identities follow by radial limits:
if $q$ minimizes at $d$, then $(1-r)u_6+rq$ is feasible at $rd$; continuity of
divergence and lower semicontinuity of the minimum imply
$I(rd)\to I(d)$ as $r\uparrow1$. $\square$

### A.2. Strict contraction and global localization

### Theorem A.2. Sharp fixed-prior contraction

For the uniform input prior and every posterior $q\ne u_6$,
$$
D(K_\eta q\Vert u_6) \lt kD(q\Vert u_6),
\qquad k=\frac{\eta^2}{3},
\tag{A.10}
$$
and $k$ is the sharp fixed-prior coefficient. More precisely,
$$
I(d)\ge\sum_i f(d_i)
-\log\left(1-\frac{(\sum_i d_i^2)^2}{64}\right)
\quad(d\in\mathcal K).
\tag{A.11}
$$

**Proof.** Since $M(a)$ is invariant under common shifts, shift $a$ so as to
minimize $\sum_i\log\cosh a_i$. Its strictly convex derivative equation gives
$u_i=\tanh a_i$ with $\sum_i u_i=0$. Directly pairing the six terms gives
$$
\frac{M(a)}{\prod_i\cosh a_i}
=\frac13\sum_{k=1}^3
(1-u_i u_j)\sqrt{1-u_k^2},
\tag{A.12}
$$
where $\{i,j\}=\{1,2,3\}\setminus\{k\}$ in the $k$th term.
The zero-sum identities give
$$
\sum_k(1-u_i u_j)(1-u_k^2/2)=3,
\qquad
\sum_i u_i^4=\tfrac12\left(\sum_i u_i^2\right)^2.
\tag{A.13}
$$
Indeed, $\sum_{i \lt j}u_i u_j=-\tfrac12\sum_i u_i^2$ and
$\sum_k u_i u_j u_k^2=u_1u_2u_3\sum_k u_k=0$ prove the first identity.
Moreover $u_i u_j\le1/4$: when the product is positive, the zero-sum condition
and $|u_k|\le1$ imply $|u_i|+|u_j|\le1$. Therefore
$$
\sqrt{1-x}\le1-\frac x2-\frac{x^2}{8}\quad(0\le x\le1)
$$
in (A.12) yields
$$
\frac{M(a)}{\prod_i\cosh a_i}
\le1-\frac{(\sum_i u_i^2)^2}{64}.
\tag{A.14}
$$

For $d$ with $|d_i|<1$ and zero sum, choose $a_i=\operatorname{atanh}d_i$.
Its minimizing common shift is already zero. Evaluate (A.7), use (A.14),
and use $a_id_i-\log\cosh a_i=f(d_i)$ to get (A.11). Radial continuity from
Proposition A.1 extends it to the boundary. The logarithm is finite there
since $\sum_i d_i^2\le2$.

The convergent positive-coefficient series
$$
f(z)=\sum_{j\ge1}\frac{z^{2j}}{2j(2j-1)}
$$
implies $f(\eta z)\le\eta^2f(z)$ for $0\le\eta\le1$. If $d\ne0$, (A.11)
is strictly larger than $\sum_i f(d_i)$, so
$$
C_\eta(d)\le\frac{\eta^2}{3}\sum_i f(d_i) \lt k I(d)
\le kD(q\Vert u_6).
$$
If $d=0$ and $q\ne u_6$, the output divergence vanishes and the input
divergence is positive. Finally, along a nonzero mean direction tending to
zero, Proposition A.1 and (A.4) give
$$
J(m)=\rho^2+O(\rho^4),\qquad
C_\eta(\sqrt2m)=k\rho^2+O(\rho^4).
$$
The ratio tends to $k$, proving sharpness. $\square$

The coefficient in (A.10) is for the fixed uniform prior. It must not be
substituted for a uniform, all-input-law channel contraction coefficient in
the stability theorem of the main text. The common-output mass $\varepsilon=1-\eta$ gives the valid uniform contraction bound $\theta=\eta$, and hence the stability coefficient $\varepsilon$.

### Corollary A.3. Global localization of all posterior maximizers

Let
$$
L_c(q)=D(K_\eta q\Vert u_6)-cD(q\Vert u_6),
\qquad G(c)=\max_qL_c(q).
\tag{A.15}
$$
As $c\uparrow k$, every global maximizer converges to $u_6$. For all
sufficiently close $c \lt k$, every nontrivial maximizer is the unique
minimum-input-divergence posterior (A.8) at a mean tending to zero.

**Proof.** Theorem A.2 makes $u_6$ the unique global maximizer at $c=k$.
The functions $L_c$ are jointly continuous on a compact simplex. If some
maximizers remained outside a fixed neighborhood of $u_6$, a convergent
subsequence would give another maximizer at $c=k$, a contradiction. For
$c>0$, replacing a posterior by the entropy minimizer with the same mean
preserves its output divergence and strictly improves $L_c$ unless it was
already that minimizer. $\square$

The cyclic rotations of any posterior average to $u_6$, preserve both
information costs, and use at most six labels. Consequently the posterior
support value $G(c)$ is attained by a valid representation under the
cardinality cap seven. In particular, the global maximizers analyzed below
provide global encoder optima, not just stationary encoders.

### A.3. Eighth-order mean expansion and exact angular selection

Put $u=\rho^2$ and $z=\cos6\theta$. In these coordinates the source and
output divergences have the expansions
$$
\begin{aligned}
J(m)={}&u+\frac{u^2}{4}
+\left(\frac5{36}-\frac z{360}\right)u^3
+\left(\frac{19}{192}-\frac z{168}\right)u^4+O(u^5),\\
C_\eta(\sqrt2m)={}&ku+\frac{k^2}{2}u^2
+k^3\left(\frac23-\frac z{15}\right)u^3
+k^4\left(\frac54-\frac{2z}{7}\right)u^4+O(u^5).
\end{aligned}
\tag{A.16}
$$
Here and below, for each fixed $\eta$, the remainders and the derivatives
used in the proof are uniform in the full angular sector.

For clarity, the finite calculation of the input coefficients can be
reproduced using just two one-variable series. The log partition functions
on the vertex and edge axes are
$$
\psi_v(t)=\log\frac{\cosh t+2\cosh(t/2)}3,
\qquad
\psi_e(t)=\log\frac{1+2\cosh(\sqrt3t/2)}3.
\tag{A.17}
$$
On either reflection axis the mean stays on that axis. Invert
$\rho=\psi'_v(t)$ or $\rho=\psi'_e(t)$ as a power series and integrate
$J'(\rho)=t$. This gives, respectively,
$$
\begin{aligned}
J_v(\rho)&=\rho^2+\frac{\rho^4}{4}
+\frac{49\rho^6}{360}+\frac{125\rho^8}{1344}+O(\rho^{10}),\\
J_e(\rho)&=\rho^2+\frac{\rho^4}{4}
+\frac{17\rho^6}{120}+\frac{47\rho^8}{448}+O(\rho^{10}).
\end{aligned}
\tag{A.18}
$$
The source function is invariant under rotation by $\pi/3$ and reflection.
Through degree eight these symmetries allow only the constant angular
harmonic and $\cos6\theta$; (A.18) therefore determines the entire input
expansion in (A.16), in mean rather than tilt coordinates. The two output
axis formulas are
$$
C_v(\rho)=\frac23f(\sqrt3s\rho),\qquad
C_e(\rho)=\frac{f(2s\rho)+2f(s\rho)}3.
\tag{A.19}
$$
Expanding the explicit series of $f$ and using the same symmetry gives the
output expansion.

### Lemma A.4. Uniform radial maximum and angular factorization

Let $c=k-\varepsilon$, where $\varepsilon>0$ is sufficiently small, and put
$$
A=\frac{k(1-2k)}4>0.
\tag{A.20}
$$
For every angle, the local radial function has one positive maximum
$u_*(\theta,\varepsilon)$, and
$$
u_*(\theta,\varepsilon)=\frac{\varepsilon}{2A}+O(\varepsilon^2)
\tag{A.21}
$$
uniformly in angle. Every global maximizer is one of these radial maxima.
Its exact angular derivative is controlled by
$$
\partial_\theta L_c
=-6u^3\sin6\theta\,[a_6+u a_8+O(u^2)],
\tag{A.22}
$$
where
$$
a_6=\frac c{360}-\frac{k^3}{15},\qquad
a_8=\frac c{168}-\frac{2k^4}{7}.
\tag{A.23}
$$

**Proof.** Subtract the two expansions in (A.16):
$$
L_c=\varepsilon u-Au^2+O(\varepsilon u^2+u^3).
\tag{A.24}
$$
Choose a fixed sufficiently small radius neighborhood, and then sufficiently
small $\varepsilon$. Its second derivative in $u$ is at most $-A$ throughout
that neighborhood. The first derivative at zero is $\varepsilon$, and is
negative at the chosen outer radius. It therefore has exactly one positive
root, with (A.21) by the implicit function theorem. Its value is positive,
whereas the value at zero is zero. Corollary A.3 puts every global maximizer
inside this fixed neighborhood, so no external maximizer has been omitted.

To justify the factorization including the sector endpoints, expand the
analytic function in the complex mean coordinate $w=\rho e^{i\theta}$ and
its conjugate. Rotation permits only monomials with exponent difference
divisible by six, and reflection pairs their angular parts into cosine
harmonics. Every nonconstant harmonic has degree at least six. After
differentiation, $\sin(6j\theta)/\sin6\theta$ is a polynomial in
$\cos6\theta$ and extends to the closed sector. Absolute analytic convergence
on a smaller fixed disk controls the resulting quotient and its derivatives.
The unlisted terms have degree at least ten; after factoring $u^3\sin6\theta$
their contribution is $O(u^2)$ uniformly. The degree-six and degree-eight
coefficients in (A.16) give (A.23), proving (A.22). $\square$

### Proposition A.5. Exact critical parameter and absence of off-axis maxima

For each fixed $0<\eta<1$, all global posterior maximizers at slopes
$c=k-\varepsilon$ with sufficiently small $\varepsilon>0$ lie on the six
vertex axes when
$$
\eta^4\le\frac38,
$$
and on the six edge axes when
$$
\eta^4>\frac38.
$$
There is one positive maximizing radius on each selected axis and no other
global maximizing posterior.

**Proof.** If $24k^2\ne1$, the leading angular bracket tends uniformly to
$k(1-24k^2)/360$. In the fundamental sector $0<\theta<\pi/6$ the sine in
(A.22) is positive. The radially optimized envelope has the same angular
derivative as the angular partial derivative, since its radial derivative
vanishes. It is therefore strictly decreasing across the sector when
$24k^2<1$, and strictly increasing when $24k^2>1$. This proves exact vertex
or edge selection and excludes off-axis competitors.

At $24k^2=1$, the sixth-degree angular term at $c=k$ vanishes. Both its slope
perturbation and the eighth-degree term must be retained. Using (A.21),
the bracket at a radial maximum equals
$$
-\frac\varepsilon{360}
+\frac{k-1/12}{168}\,u_*(\theta,\varepsilon)
+O(\varepsilon u_*+u_*^2).
$$
The critical identity $k-1/12=k(1-2k)=4A$ turns this into
$$
\varepsilon\left(-\frac1{360}+\frac1{84}\right)
+O(\varepsilon^2)
=\frac{23}{2520}\varepsilon+O(\varepsilon^2)>0
\tag{A.25}
$$
uniformly in angle. The envelope is strictly decreasing on the open sector
also at the critical parameter, so equality belongs to the vertex side.
Finally, $24k^2=24\eta^4/9=1$ is exactly $\eta^4=3/8$. The radial uniqueness
and exhaustive localization come from Lemma A.4. $\square$

This argument uses the optimized angular derivative, not merely a comparison
of the values on two symmetry axes. In particular it excludes interior-angle
contacts at the critical parameter. The small neighborhood is allowed to
depend on the fixed value of $\eta$; no common rate neighborhood across the
transition is asserted.

### A.4. All canonical optimal encoders and their ranks

### Theorem A.6. Complete scalar low-rate classification

For every fixed $0<\eta<1$, there exists $R_0(\eta)>0$ such that at every
$0 \lt R \lt R_0(\eta)$ the global posterior contact set consists of exactly six
points. If $\eta^4\le3/8$, these are the six cyclic shifts of
$$
q_t^0(j)=\frac{e^{t\cos(\pi j/3)}}{Z_v(t)},\qquad
Z_v(t)=2\cosh t+4\cosh(t/2),\quad t>0.
\tag{A.26}
$$
Their posterior matrix is invertible and the only feasible canonical weights
are uniform, so the canonical optimizer is unique and has six labels.

If $\eta^4>3/8$, the contacts are
$$
q_h^{i,\pm}(a,b)
=\frac{\exp\{\pm h(\mathbf1_{a=i}-\mathbf1_{b=i})\}}{Z_h},
\qquad Z_h=2(1+2\cosh h),\quad h>0,
\tag{A.27}
$$
and every canonical optimizer is obtained from
$$
w_{i,+}=\frac{1+\delta}{6},\qquad
w_{i,-}=\frac{1-\delta}{6},\qquad -1\le\delta\le1,
\tag{A.28}
$$
after deleting zero weights. The full contact matrix has rank five and its
sole kernel direction assigns $+1$ to the three positive contacts and $-1$
to the three negative contacts. Interior weights have six labels; the two
endpoint measures have three labels and rank three.

**Proof.** Proposition A.5 determines every global contact mean. Its unique
entropy-minimizing posterior from Proposition A.1 yields (A.26) or (A.27).
On a vertex axis the normalized tilt length is $t$; on an edge axis it is
$2h/\sqrt3$, giving the stated exponential coefficients. The six contacts
are distinct, and cyclic averaging gives the uniform input prior. Their
common input divergence and common output divergence provide an attainable
supporting information pair under the cap seven.

For the vertex matrix, the circulant eigenvalues before division by $Z_v(t)$
are $Z_v(t)$, the twice-repeated values
$$
2\sinh t+2\sinh(t/2),\qquad
2\cosh t-2\cosh(t/2),
$$
and
$$
2\sinh t-4\sinh(t/2)
=4\sinh(t/2)[\cosh(t/2)-1].
\tag{A.29}
$$
They are all positive for $t>0$. Thus the matrix is invertible, and its known
uniform feasible weight is the only one.

In cyclic coordinates an edge-aligned column is
$$
\frac{(e^h,e^h,1,e^{-h},e^{-h},1)}{Z_h}.
$$
Its discrete Fourier coefficients in modes $1,5$ are nonzero multiples of
$\sinh h$, those in modes $2,4$ are nonzero multiples of $\cosh h-1$, mode
$0$ is nonzero, and mode $3$ vanishes. Hence its circulant matrix has rank
five and one-dimensional kernel. Directly, each triple
$\{q_h^{i,+}:i=1,2,3\}$ and $\{q_h^{i,-}:i=1,2,3\}$ separately averages to
$u_6$, identifying that kernel as the indicated difference of triples.
All prior-preserving weights are therefore exactly (A.28). The three columns
within either triple are independent: a dependence restricted to one triple
would produce a kernel vector of the full matrix supported there, whereas
the identified kernel has all six entries nonzero.

To check exhaustion at the specified budget, let $c>0$ be the supporting
slope. Every encoder with actual rate $r\le R$ satisfies
$$
I(Y;T)\le cr+G(c)\le cR+G(c).
\tag{A.30}
$$
The displayed symmetric encoder attains the last quantity. Equality therefore
requires $r=R$ and requires each positive-weight posterior to attain the
individual support bound. Thus every optimizer uses only the six contacts
and the weights just classified. No local stationarity assumption or extra
auxiliary cardinality is used. $\square$

### Corollary A.7. Rate parametrization and strict curvature

The interval in Theorem A.6 can be chosen so that the IB function is strictly
increasing and strictly concave on $[0,R_0(\eta)]$. At the origin,
$$
F_\eta(R)=kR-\frac{k(1-2k)}4R^2+O(R^3),
\qquad
F_\eta''(R)=-\frac{k(1-2k)}2+O(R)<0.
\tag{A.31}
$$

**Proof.** On each selected axis the radial maximum depends analytically on
$\varepsilon$ near zero, with (A.21). Its input cost satisfies
$$
R(\varepsilon)=J(m_*(\varepsilon))
=\frac\varepsilon{2A}+O(\varepsilon^2),
$$
so its derivative is positive for small positive $\varepsilon$. The inverse
parametrization is analytic and its supporting slope is
$F_\eta'(R)=c=k-\varepsilon(R)$. Hence
$F_\eta''(R)=-2A+O(R)<0$. Integration from $F_\eta(0)=0$ gives (A.31).
Shrinking the interval keeps the slope positive. Continuity at zero extends
strict concavity to the closed initial interval. At $R=0$, canonicalization
leaves the single posterior $u_6$. $\square$

The small-rate classification, its critical equality, and its rank statements
are the sole inherited scalar inputs used for the product phase diagram.
They neither assert nor require a resolution of the original full-interval
strict-concavity question.

## References

1. Hippolyte Charvin, Nicola Catenacci Volpi, and Daniel Polani. *Exact and Soft Successive Refinement of the Information Bottleneck*. Entropy 25(9), 1355 (2023). [doi:10.3390/e25091355](https://doi.org/10.3390/e25091355). Publisher full text; especially Appendix D.
2. Etam Benger, Shahab Asoodeh, and Jun Chen. *The Cardinality Bound on the Information Bottleneck Representations is Tight*. [arXiv:2305.07000v2](https://arxiv.org/abs/2305.07000). Primary full text; cardinality and Hamming construction.
3. Vudtiwat Ngampruetikorn and David J. Schwab. *Perturbation Theory for the Information Bottleneck*. NeurIPS 2021; [arXiv:2105.13977v2](https://arxiv.org/abs/2105.13977). Primary full text; learning-onset and SDPI methods.
4. Shahab Asoodeh and Flavio P. Calmon. *Bottleneck Problems: An Information and Estimation-Theoretic View*. Entropy 22(11), 1325 (2020). [doi:10.3390/e22111325](https://doi.org/10.3390/e22111325). Publisher full text; Theorem 5 and Appendix A.
5. Yury Polyanskiy and Yihong Wu. *Strong Data-Processing Inequalities for Channels and Bayesian Networks*. [arXiv:1508.06025](https://arxiv.org/abs/1508.06025); [author full text](https://people.lids.mit.edu/yp/homepage/data/simple-IMA.pdf). Uniform mutual-information contraction and conditional-information methods.
6. Shlomi Agmon. *The Information Bottleneck's Ordinary Differential Equation: First-Order Root Tracking for the Information Bottleneck*. Entropy 25(10), 1370 (2023). [doi:10.3390/e25101370](https://doi.org/10.3390/e25101370). Publisher full text; Sections 5.1 and 5.3, Conjecture 1, and Corollaries 1 and 3.
7. Albert E. Parker and Alexander G. Dimitrov. *Symmetry-Breaking Bifurcations of the Information Bottleneck and Related Problems*. Entropy 24(9), 1231 (2022). [doi:10.3390/e24091231](https://doi.org/10.3390/e24091231). Publisher full text; persistent kernels and projection methods.
8. Albert E. Parker, Alexander G. Dimitrov, and Tomáš Gedeon. *Symmetry Breaking in Soft Clustering Decoding of Neural Codes*. IEEE Transactions on Information Theory 56(2), 901–927 (2010). [doi:10.1109/TIT.2009.2037045](https://doi.org/10.1109/TIT.2009.2037045). [Author-hosted IEEE proof full text](https://math.montana.edu/gedeon/documents/clanky/reviewParkerAlexGEd2010.pdf).
9. Shlomi Agmon. *Root Tracking for Rate-Distortion: Approximating a Solution Curve With Higher Implicit Multivariate Derivatives*. IEEE Transactions on Information Theory 70(3), 1540–1587 (2024). [doi:10.1109/TIT.2023.3329618](https://doi.org/10.1109/TIT.2023.3329618). Technical comparison uses [arXiv:2206.11369v2](https://arxiv.org/abs/2206.11369); final publisher full text was unavailable.
10. Shlomi Agmon, Etam Benger, Or Ordentlich, and Naftali Tishby. *Critical Slowing Down Near Topological Transitions in Rate-Distortion Problems*. ISIT 2021, 2625–2630. [doi:10.1109/ISIT45174.2021.9517956](https://doi.org/10.1109/ISIT45174.2021.9517956). Technical comparison uses [arXiv:2103.02646v3](https://arxiv.org/abs/2103.02646); its uniqueness assumption is respected.
11. Tomáš Gedeon, Albert E. Parker, and Alexander G. Dimitrov. *The Mathematical Structure of Information Bottleneck Methods*. Entropy 14(3), 456–479 (2012). [doi:10.3390/e14030456](https://doi.org/10.3390/e14030456). Publisher full text; Section 3.1 on block kernels and constrained degeneracy.
12. Lingyi Chen et al. *Information Bottleneck Revisited: Posterior Probability Perspective with Optimal Transport*. [arXiv:2308.11296v1](https://arxiv.org/abs/2308.11296), 2023. Primary author text; posterior optimization and the generalized alternating Sinkhorn construction.
13. Faruk Alpay. *Stable and Convexified Information Bottleneck Optimization via Symbolic Continuation and Entropy-Regularized Trajectories*. [arXiv:2505.09239v1](https://arxiv.org/abs/2505.09239), 2025. Primary author text; modified objective, conditional-entropy regularization, and continuation equations. Its broader convexity and uniqueness assertions are not proof premises here.
14. Joss Armstrong. *Source-Side Sufficiency for the Information Bottleneck: Exact Reduction and Finite-Block Equivalence*. [arXiv:2604.26744v2](https://arxiv.org/abs/2604.26744), 2026. Primary author text; Theorem 6 and the sufficient-statistic encoder correspondence.
