# Approximate Local Privacy: Blackwell Structure, Exact Pearson Information, and Minimax Estimation

*Finite-channel structure and sharp information–estimation tradeoffs*

25 November 2026


## Research status

This is an AI-assisted research manuscript. It is not externally peer reviewed and makes no global-priority claim.

The written paper and partial Lean verification have distinct scopes.
The four structural main theorems, both prototype-counting formulas,
ordinary event-privacy equivalence, the Pearson normalization identity and
the six-output obstruction have native Lean proofs. The general Pearson
frontier and statistical minimax theorems are not represented as fully
formalized. The Lean source and verification records are not included in this edition. No new compilation or kernel verification is claimed.
Literature screening is bounded; global priority and external peer-review
acceptance are not asserted.

## Abstract

We study stochastic channels with a finite input alphabet, arbitrary finite output alphabets, and directed approximate local differential privacy budgets. With a common likelihood-ratio multiplier $E\ge1$, feasibility is expressed by the hockey-stick inequalities $\sum_y(Q(y\mid i)-E Q(y\mid j))_+\le\delta_{ij}$. We characterize Blackwell-maximal channels by a graph on the positive support of each likelihood column: an edge is present exactly when a tight directed privacy budget and a tight column likelihood ratio coincide. A channel is maximal if and only if every such graph is connected. A disconnected column admits a feasible strict refinement with one extra output, for which an explicit quadratic information gain certifies strictness against arbitrary stochastic reverse garblings.

We further prove an exact, loss-preserving refinement into a fixed finite set of normalized column prototypes. For $E>1$, these prototypes are singleton supports and surjective consecutive geometric levels $1,E,\ldots,E^m$ on arbitrary supports. For $E=1$, they are normalized nonempty subset indicators. The number of prototypes is the sharp universal bound on the outputs needed for feasible Blackwell domination, even when all directed budgets share one common value. This information-preserving bound is distinct from the utility-specific bound: every continuous convex positively homogeneous additive column utility has an attained finite linear-program representation and an optimizer with at most $k^2$ nonzero outputs. We provide a six-output three-level example, exact rational primal–dual certificates, and independent finite stress comparisons. The model is noninteractive and finite; no universal greatest mechanism, infinite-alphabet extension, or general polynomial-time algorithm is asserted.

For a common approximate-privacy budget, we derive the exact uniform-input
Pearson information frontier for every alphabet size and every finite
output channel. It is the affine interpolation between the optimal pure
subset mechanism and full revelation, and we characterize all equality
mechanisms. The proof uses the canonical decomposition and a strict
lowest-layer perturbation to eliminate multilevel extremizers. This sharp
trace bound yields an attainable finite-sample minimax risk in the globally
unbiased class and the exact asymptotic minimax constant for arbitrary
estimators in noninteractive categorical distribution estimation. The
asymptotic lower bound is uniform over mechanisms and finite output sizes
that vary with sample size. Known pure-private and binary approximate-
private results, the $E=1$ endpoint, and prior
interpolation ideas are explicitly credited.

**Keywords:** approximate local differential privacy; Blackwell order; statistical experiments; polyhedral refinement; information comparison; exact optimization; Pearson information; minimax estimation.

## 1. The structural question

Pure local privacy imposes a homogeneous restriction on every likelihood column separately. Approximate privacy instead couples all output columns through a total directed hockey-stick loss. This distinction prevents a direct substitution of an additive slack into the usual pure-privacy column cone. Our question is whether the full information order nevertheless admits an explicit description that is uniform over the output alphabet.

The structural question is concrete and bounded. Fix the number $k$ of inputs, a real multiplier $E\ge1$, and all directed budgets. We ask which finite channels cannot be strictly improved without violating those budgets, and which finite list of likelihood directions suffices to dominate every feasible channel. The desired result concerns all finite output alphabets at once. It is stronger than identifying the vertices of a polytope after fixing an output count, and it makes no assertion about interactive protocols.

### 1.1 Relation to earlier work and the novelty boundary

Kairouz, Oh and Viswanath established the staircase mechanism and finite optimization approach for pure local privacy. They also proved universal optimality of a four-output approximate-private mechanism for a binary input alphabet [1, Theorem 18]. Thus neither pure staircase reduction, finite linear programming in itself, nor the binary approximate case is an original claim here.

Nam, Park and Lee study maximal channels and convex geometry for pure local privacy. Their general column-cone extension already covers pointed polyhedral restrictions on individual columns [2, Proposition 8 and Remark 4]. Their discussion explicitly identifies the matrix coupling in approximate privacy as a remaining obstacle. Our construction addresses this coupling by decomposing each column inside a common sign cell, preserving every directed loss exactly, and by using the activity pattern of the *whole channel* in the maximality test.

Pensia, Asadi, Jog and Loh discuss approximate local privacy, distinguish it from singleton-event relaxations, and identify output-alphabet bounds as an open structural issue [3, Sections 6–7]. The present result supplies a bound for the specified family of additive homogeneous utilities, together with a stronger Blackwell representation theorem. It does not establish their threshold-channel decomposition or resolve the advantages of interaction.

Elangovan and Jog, and more recently Rawat, Vajha, Kurri and Sarwate, investigate extreme points of fixed-output $(0,\delta)$-privacy polytopes [4,5]. The latter work characterizes the small-input cases $k=2,3$ and constructs larger-input examples. Its Remark 1 also states, for general $k$, that nonzero columns of an extreme $(0,\delta)$-private matrix have different supports and obtains the bound $2^k-1$. We therefore do not claim that numerical bound at $E=1$ as new. Our additional assertions concern exact directed-loss-preserving Blackwell refinement and a matching universal Blackwell lower bound; the $E>1$ prototype count is different. Fixed-output extremality and arbitrary-output Blackwell maximality are distinct: a convex extreme point need not be maximal in the information order. The full primary HTML of [5, v2] was checked, including Remark 1 and its neighboring perturbation argument. The original PDF was unavailable, and the full text of [4] was not obtained; these access limits restrict the literature comparison.

Metric-privacy work by Fernandes, McIver, Palamidessi and Ding supplies important precedents for channel refinement and utility comparisons under pure constraints [6]. The contribution claimed for further review here is the combination of the active-budget graph criterion, exact directed-loss preservation, the explicit consecutive-level prototype family, and the sharp universal Blackwell alphabet. Generic convexity, perturbation arguments, quadratic perspectives, and finite linear optimization are standard mathematical tools.

The literature search was bounded, dated, and source-based. Failure to find an equivalent theorem is not a proof of priority. The literature comparison is limited to the sources and versions inspected.

The information and estimation results require a second, more specific
novelty boundary. The pure-private subset benchmark $C_k(E)$ is known;
Ye and Barg obtain its associated exact asymptotic squared-error constant
for discrete-distribution estimation [7]. Kairouz, Oh and Viswanath's
binary theorem [1] already implies the entire $k=2$ approximate-private
Pearson frontier, and it already uses a flagged revelation/randomized-
response mixture. At $E=1$, the general contraction bound of Asoodeh,
Aliakbarpour and Calmon [8, Lemma 1] implies that every uniform tangent
eigenvalue is at most $\delta$, hence $I_{\chi^2}(Q)\le(k-1)\delta$.
That endpoint also is not new.

Cheng and Tang explicitly conjecture an affine interpolation bound for
Shannon mutual information under approximate local privacy [9, Eq. (15)].
Their pure-private term is an envelope over alphabet sizes and input
distributions. This is a substantive precedent for the interpolation idea.
Our fixed-$k$, uniform-input Pearson theorem neither originates that idea
nor resolves their Shannon-information conjecture. A bounded search did
not locate a verified subsequent resolution; we make no claim that the
Shannon conjecture remains open.

Fisher information and the van Trees method are established tools in
private estimation [10,11]. Pan's recent pure-private analysis also uses
permutation symmetry, subset mechanisms and unbiased reconstruction
[12]. A sharp contraction coefficient is a largest-eigenvalue statement,
whereas our objective is a tangent trace. For example, at $k=3,E=2$ the
pure optimum is $1/8$, while multiplying the sharp global contraction
coefficient by the tangent dimension gives $2/9$. Thus the sharp
single-direction contraction bound in [11] does not supply our exact
trace constant.

The additional contribution claimed here is the all-finite-channel
Pearson upper bound and complete equality classification in the remaining
range $k\ge3$, $E>1$, $0<\delta<1$, together with the resulting exact
approximate-private estimation constants. Its key extremal step excludes
the multilevel columns that are genuinely necessary for general
Blackwell representation. The statistical consequences apply known
methods to the new sharp channel inequality. We distinguish the exact
finite-sample unbiased conclusion from the asymptotic conclusion for all
estimators; finite-sample minimax equality for arbitrary biased estimators
is not asserted.


### 1.2 Definitions

Let $X=[k]$, $k\ge2$, and let $Y$ be any nonempty finite set. Write the likelihood columns of a channel as $v_y\in\mathbb R_+^k$, where $v_y(i)=Q(y\mid i)$ and $\sum_yv_y=\mathbf1$. Put

$$
m(v)=\sum_i v_i,\qquad d_{ij}(v)=v_i-Ev_j,\qquad
h_{ij}(v)=(d_{ij}(v))_+,\qquad H_{ij}(Q)=\sum_yh_{ij}(v_y).
$$

For $i\ne j$, fix $0\le\delta_{ij}\le1$. The feasible class $\mathcal C(E,\delta)$ consists of all finite channels with $H_{ij}(Q)\le\delta_{ij}$. For a finite alphabet,

$$
\max_{B\subseteq Y}\sum_{y\in B}(Q(y\mid i)-E Q(y\mid j))
=\sum_y(Q(y\mid i)-E Q(y\mid j))_+.
$$

Indeed, every selected negative summand can be removed, every positive summand can be selected, and zero summands are immaterial. Thus the hockey-stick definition imposes the privacy inequality for *every event*, including events containing several outputs. It is not the singleton-event relaxation. Equal budgets and $E=e^\epsilon$ recover ordinary finite $(\epsilon,\delta)$-LDP.

We write $R\succeq_B Q$ when a stochastic kernel $K(y\mid z)$ satisfies $v_y=\sum_zK(y\mid z)r_z$. This is a comparison of complete experiments, independent of a selected prior or scalar utility. Feasible $Q$ is **maximal** when every feasible $R\succeq_BQ$ also satisfies $Q\succeq_BR$. A **greatest** feasible experiment would dominate every feasible experiment; we neither use nor assert that stronger property.

Zero likelihood columns are allowed. They can be removed without affecting feasibility or informativeness. A singleton positive support counts as connected.

## 2. Main results

### Theorem 1. Active-budget characterization of maximality

Let $Q$ be a feasible finite channel. Define

$$\mathcal A(Q)=\{(i,j):i\ne j,\ H_{ij}(Q)=\delta_{ij}\}.$$

For every nonzero likelihood column $v$, form an undirected graph on $S(v)=\{i:v_i>0\}$, joining distinct $i,j$ when

$$
[(i,j)\in\mathcal A(Q),\ v_i=Ev_j]
\quad\text{or}\quad
[(j,i)\in\mathcal A(Q),\ v_j=Ev_i].
$$

Then $Q$ is maximal in $\mathcal C(E,\delta)$ **if and only if every one of these graphs is connected**. If a graph is disconnected, a feasible strict dominator exists with only one additional output. It preserves every active $H_{ij}$ exactly and leaves every originally inactive budget strictly slack.

The proof is given in Appendix A. The necessity argument uses the globally monotone statistic

$$\Phi(Q)=\sum_y\frac{\sum_i v_y(i)^2}{m(v_y)},$$

with zero contribution for a zero column. A strict increase in this statistic rules out every possible reverse stochastic kernel; local nonproportionality alone would be insufficient.

### Theorem 2. Explicit canonical refinement

For $E=1$, let

$$\mathcal R_1(k)=\{\mathbf1_S/|S|:\varnothing\ne S\subseteq[k]\}.$$

For $E>1$, let $\mathcal R_E(k)$ contain the $k$ unit vectors and, for every support $S$ of size at least two, every vector

$$
r_i=\frac{E^{\ell(i)}}{\sum_{j\in S}E^{\ell(j)}}\quad(i\in S),\qquad r_i=0\quad(i\notin S),
$$

where $\ell:S\to\{0,\ldots,m\}$ is surjective and $1\le m\le|S|-1$.

For every finite channel $Q$ there are nonnegative coefficients $a_{y,r}$ such that

$$v_y=\sum_r a_{y,r}r,\qquad h_{ij}(v_y)=\sum_r a_{y,r}h_{ij}(r)$$

for all outputs and ordered pairs. The channel with columns $a_r r$, $a_r=\sum_y a_{y,r}$, dominates $Q$ and satisfies $H_{ij}(R)=H_{ij}(Q)$ for every ordered pair. The reconstruction kernel is $K(y\mid r)=a_{y,r}/a_r$ on nonzero columns. A finite list of prototypes with continuously variable weights is intended; this is not a finite set of complete channels.

### Theorem 3. Sharp universal Blackwell alphabet

Write $M_E(k)=|\mathcal R_E(k)|$. Then

$$
M_1(k)=2^k-1,
\qquad
M_E(k)=k+\sum_{s=2}^k\binom ks\sum_{L=2}^s L!\,S(s,L)\quad(E>1),
$$

where $S(s,L)$ is a Stirling number of the second kind. This is the least output bound that works for feasible Blackwell domination uniformly over all admissible budgets: Theorem 2 gives the bound for every budget vector, and some single common budget $\delta_*\in(0,1)$ requires all $M_E(k)$ outputs.

The lower-bound channel has columns $(k/M_E(k))r$, one for each prototype. Its maximality follows from Theorem 1, and equality in the quadratic perspective shows that any equivalent experiment retains every distinct posterior direction. Sharpness is uniform over budgets; it is not a lower bound for each fixed budget separately.

| Inputs $k$ | $M_1(k)$ | $M_E(k)$ for $E>1$ | Utility support bound $k^2$ |
|---:|---:|---:|---:|
| 2 | 3 | 4 | 4 |
| 3 | 7 | 21 | 9 |
| 4 | 15 | 138 | 16 |
| 5 | 31 | 1055 | 25 |

### Theorem 4. Exact utility reduction and attained optimum

Let $\mu:\mathbb R_+^k\to\mathbb R$ be continuous, convex and positively homogeneous, with $\mu(0)=0$, and set $U(Q)=\sum_y\mu(v_y)$. Define

$$
\mathcal P(E,\delta)=\left\{a\ge0:
\sum_r a_r r_i=1\ (i\in[k]),\quad
\sum_r a_rh_{ij}(r)\le\delta_{ij}\ (i\ne j)\right\}.
$$

Then

$$
\sup_{Q\in\mathcal C(E,\delta)}U(Q)
=\max_{a\in\mathcal P(E,\delta)}\sum_r a_r\mu(r).
$$

The maximum is attained. An optimizer exists with at most $k^2$ positive coefficients. This support compression preserves normalization, every realized directed privacy loss, and the chosen optimal objective. It is not claimed to preserve dominance over an arbitrary preassigned channel. In particular it is consistent with Theorem 3.

The proof uses Theorem 2 and finite-dimensional compactness; the support bound follows by eliminating a linear dependence among the $k^2$ normalization and privacy features. General LP strong duality is not needed as a theorem of this manuscript. Weak duality supplies directly checkable certificates for the numerical instances below.

### Theorem 5. Exact Pearson frontier and every maximizing mechanism

In this theorem the directed budgets have a common value $\delta\in[0,1]$.
For a uniform input, define

$$
I_{\chi^2}(Q)=\sum_{y:m(v_y)>0}\frac{\|v_y\|_2^2}{m(v_y)}-1,
\qquad
C_k(E)=\max_{1\le d\le k-1}
\frac{d(k-d)(E-1)^2}{[k+d(E-1)]^2}.
$$

Then the exact maximum over all feasible finite-output channels is

$$
\boxed{A_k(E,\delta):=\max_Q I_{\chi^2}(Q)
=(1-\delta)C_k(E)+\delta(k-1).}
$$

Every maximizing channel, after collecting proportional revealing columns,
has a $\delta I_k$ part on separate output labels. For $\delta<1$, its
remaining columns, divided by $1-\delta$, form a pure-private channel
maximizing the same Pearson objective. If $E>1$, every nonzero column of
this pure portion has full support and exactly two levels with ratio $E$;
the number $d$ of higher coordinates maximizes the displayed formula for
$C_k(E)$. Different maximizing values of $d$ may occur in the same
channel. If $E=1$, the pure portion is input-independent. At $\delta=1$,
only the revealing portion remains. These conditions are also sufficient.

The upper bound follows from the following sharp inequality for every
probability vector $p$:

$$
k\|p\|_2^2-1
\le C_k(E)+\frac{k-1-C_k(E)}{k-1}
\sum_{i\ne j}(p_i-Ep_j)_+.
\tag{P}
$$

For $E>1$, equality in (P) occurs exactly at unit vectors and normalized
full-support two-level vectors with an optimizing $d$. For $E=1$, the
nonvertex equality case is the uniform vector. Appendix C proves the
inequality and its complete equality classification. The proof first uses
the canonical refinement to establish a genuine global extremum, then
rules out zero coordinates and three or more geometric levels by strict
local improvements. The construction of a revealing mixture alone would
only prove achievability.

For an attaining symmetric mechanism, choose an optimizing $d$, set
$N=\binom{k}{d}$ and $L=k+d(E-1)$, and let the pure component output a
$d$-subset $B$ with probabilities

$$
Q_0(B\mid i)=\frac{k}{NL}\bigl[1+(E-1)\mathbf1_{\{i\in B\}}\bigr].
$$

Use $(1-\delta)Q_0$ and $\delta I_k$ on disjoint labels. The branch label
is part of the output. A smaller Pearson-optimal construction uses the
$k$ cyclic translates of any fixed $d$-subset, with probabilities
$[1+(E-1)\mathbf1_{\{i\in B+t\}}]/L$. It has at most $2k$ outputs after
adding revelation. This is an upper bound, not a minimum-output theorem;
cyclic symmetry alone need not make its Fisher information isotropic.

The optimizing subset size can be found without enumerating prototypes.
For $E>1$, the continuous extension of $C_d$ increases up to
$d=k/(E+1)$ and decreases afterward. It suffices to compare the adjacent
integers, clipped to $1,\ldots,k-1$. More precisely, the sign of
$C_d-C_{d+1}$ is the sign of
$d(d+1)E^2-(k-d)(k-d-1)$. These elementary consequences of the known pure
benchmark are included for implementation, not as separate novelty claims.

### Theorem 6. Exact finite-sample risk in the unbiased class

Let $X_1,\ldots,X_n$ be independent categorical samples with an unknown
distribution $p\in\Delta_k$, and privatize each independently through the
same fixed finite channel satisfying the common $(E,\delta)$ budget.
Write $u=\mathbf1/k$ and assume $A=A_k(E,\delta)>0$.

Among all such channels and all finite-variance $\mathbb R^k$-valued
estimators that are locally unbiased at $u$, the smallest risk at $u$ is

$$
\boxed{\frac{(k-1)^2}{nkA}.}
$$

The same expression is the exact minimax risk when estimators are required
to be globally unbiased for every $p\in\Delta_k$. An attaining mechanism
is the fully symmetric subset/revelation mechanism above. Let
$\lambda=A/(k-1)$ and, for an observed nonzero column $v_y$, write
$r_y=v_y/m(v_y)$. An attaining estimator is

$$
\widehat p=u+\frac{1}{n\lambda}\sum_{a=1}^n(r_{Y_a}-u).
\tag{E}
$$

Its coordinates sum to one but may be negative. Its exact risk is

$$
\mathbb E_p\|\widehat p-p\|_2^2
=\frac1n\left[\frac{(k-1)^2}{kA}+\frac1k-\|p\|_2^2\right],
\tag{R}
$$

so the worst case is the uniform distribution. The proof identifies the
tangent Fisher trace as $kI_{\chi^2}(Q)$, uses the covariance inequality,
and obtains equality by permutation symmetry. These statistical tools are
standard; the contribution is the sharp approximate-privacy constant
supplied by Theorem 5. Local unbiasedness is essential for the pointwise
statement. A constant estimator equal to $u$ would otherwise have zero
risk at $u$.

### Theorem 7. Exact asymptotic minimax risk without an unbiasedness restriction

For fixed $k,E,\delta$ with $A=A_k(E,\delta)>0$, define

$$
\mathcal R_n(E,\delta)=
\inf_{Q,\widehat p}\ \sup_{p\in\Delta_k}
\mathbb E_{p,Q}\|\widehat p-p\|_2^2,
$$

where $Q$ ranges over the finite channels just specified and
$\widehat p$ ranges over all estimators based on the $n$ privatized
observations. The channel and its finite output size may depend on $n$.
Estimators may be biased and may be required to take values in
$\Delta_k$ without changing the conclusion. Then

$$
\boxed{\lim_{n\to\infty}n\mathcal R_n(E,\delta)
=\frac{(k-1)^2}{kA_k(E,\delta)}.}
$$

For every $0<\rho<1/k$, the proof gives the explicit, mechanism-uniform
lower bound

$$
\mathcal R_n(E,\delta)\ge
\frac{(k-1)^2}
{nkA/(1-k\rho)+\pi^2(k-1)^2/\rho^2}.
\tag{V}
$$

The upper bound follows by projecting estimator (E) onto the simplex.
For the lower bound, a compactly supported continuously differentiable prior around $u$ and
an integration-by-parts identity give a vector van Trees bound. The
Fisher trace is bounded uniformly over every feasible $Q$ throughout the
prior support. This uniformity permits optimization over mechanisms that
vary with $n$; a pointwise Cramér–Rao argument would not suffice.
Appendix D supplies all steps. The result extends the pure-private exact
asymptotic constant of Ye and Barg [7] to ordinary approximate privacy;
it does not introduce the van Trees method [10].

The only zero-information case is $E=1,\delta=0$. In that case every
channel is input-independent, the unrestricted minimax risk is
$(k-1)/k$ for every $n$, and no estimator is locally unbiased in all
tangent directions. The reciprocal formulas above deliberately exclude
this case. No interactive protocol is included in Theorems 6–7.


## 3. A three-input obstruction to a two-level representation

Take $E=2$, all directed budgets equal to $1/7$, and

$$
Q=\frac1{14}\begin{pmatrix}
1&1&2&2&4&4\\
2&4&1&4&1&2\\
4&2&4&1&2&1
\end{pmatrix}.
$$

All row sums are one. For each directed input pair, precisely one output has values $(4,1)/14$, contributing $1/7$ to the hockey-stick sum; the other five contributions vanish. In every column, the two consecutive ratio equalities link the values $1,2,4$ into a path. Every budget is active, so Theorem 1 proves maximality.

Moreover, no feasible channel all of whose columns have at most two distinct positive values can dominate this channel. A feasible dominator must be equivalent, and equivalent experiments have the same set of normalized nonzero column directions. Each of the six directions above has three positive levels. This is a structural necessity result, not a claim that the example optimizes every scalar utility.

For instance its uniform-input Pearson information is $2/7$, whereas Theorem 5 gives the exact optimum $11/28$, a gap of $3/28$. A flagged mixture of three revealing outputs and the three-output pure randomized-response mechanism attains that value, also with six outputs. There is no contradiction: two different maximal experiments may optimize different decisions or information functionals.

## 4. Exact computation and reproducibility

The computations use Python's `Fraction` throughout. Prototype construction by support and level surjections is compared with an independent enumeration of rank-$k-1$ intersections of the hyperplanes $v_i=0$ and $v_i-Ev_j=0$. The intersection enumerator uses exact Gaussian elimination and retains nonnegative one-dimensional kernels. Agreement was checked for $k=1,\ldots,5$ and $E\in\{1,3/2,2,3\}$, a total of 20 instances. The $k=1$ checks are arithmetic controls outside the stated research domain.

A separate refinement LP, which does not consult the graph criterion, searches decompositions of each original column and maximizes the quadratic perspective. Across 312 enumerated two-output channels and tight, slack and asymmetric budget patterns, it finds positive gain exactly when the active-graph test predicts nonmaximality. These are finite stress tests; they are not a substitute for Theorem 1.

Ten utility LP instances include exact primal weights, free normalization multipliers, nonnegative privacy multipliers, and matching rational objective values. The certificate verifier imports neither the simplex solver nor its prototype generator. Its independent code checks normalization, all privacy inequalities, every dual inequality, and zero duality gaps.

| $k$ | $E$ | Common $\delta$ | Optimal uniform-input Pearson information |
|---:|---:|---:|---:|
| 2 | 2 | 0 | $1/9$ |
| 2 | 2 | $1/3$ | $11/27$ |
| 3 | 1 | 0 | $0$ |
| 3 | 1 | $1/3$ | $2/3$ |
| 3 | 1 | 1 | $2$ |
| 3 | 2 | 0 | $1/8$ |
| 3 | 2 | $1/7$ | $11/28$ |
| 3 | 2 | $1/2$ | $17/16$ |
| 3 | 2 | 1 | $2$ |
| 4 | 2 | $1/5$ | $87/125$ |

For uniform input, the information in this table equals $\Phi(Q)-1$. To verify this identity, $P_X(i)=1/k$, $P_Y(y)=m(v_y)/k$, and the joint-to-product chi-square sum is

$$\sum_{i,y}\frac{(v_y(i)/k)^2}{(1/k)(m(v_y)/k)}-1
=\sum_y\frac{\sum_i v_y(i)^2}{m(v_y)}-1.$$

All nonzero terms have positive denominators; zero outputs contribute zero. Theorem 5 independently evaluates every listed common-budget optimum. An exploratory exact scan had first tested 64,888 geometric composition orbits across $k=2,\ldots,12$ and eight rational values of $E$; it suggested the general law but was not used as its proof. Independent symbolic checks verify the polynomial identities in Appendix C; all sign and equality arguments are supplied analytically. The independent verifier checks the listed finite values, while the arbitrary-parameter theorem depends on the general proofs.

## 5. Consequences and limits

The structural and statistical conclusions address different design
questions. The active graph decides whether any feasible experiment can
strictly improve a given channel in the Blackwell order. The canonical
family represents every feasible experiment without losing any directed
privacy information. Its sharp universal size can be much larger than
$k^2$. Once a single convex homogeneous utility is fixed, an optimizer
needs at most $k^2$ outputs. For the uniform Pearson objective, Theorem 5
goes further: an explicit construction with at most $2k$ outputs suffices,
and all optimum posterior types are known. Full permutation symmetry
supplies the isotropic mechanism needed for the sharp estimation risk.

The three-level example shows why these conclusions are compatible.
Multilevel columns cannot be discarded from a universal Blackwell
representation, yet they are strictly suboptimal for this selected
information objective. The pointwise strictness in Appendix C explains
this separation for every alphabet size, beyond the numerical example.

For fixed $k$ and $\epsilon\downarrow0$, the known pure benchmark satisfies

$$
C_k(e^\epsilon)
=\frac{\lfloor k^2/4\rfloor}{k^2}\epsilon^2+O(\epsilon^3).
$$

The exact law therefore identifies the contribution of the approximate
budget as $\delta(k-1)$ in the information numerator. The effective
isotropic information fraction is
$A_k/(k-1)=\delta+(1-\delta)C_k/(k-1)$.
This is a direct consequence of the proved formula, not a separate
privacy definition or a claim about interactive protocols.

The full prototype list grows rapidly with $k$. Its finiteness is useful
for exact representation and certification but does not establish an
efficient algorithm for arbitrary utilities. The explicit Pearson
solution avoids this general LP enumeration for its particular objective.
The structural results allow asymmetric directed additive budgets; the
closed information frontier and statistical constants require a common
budget. Pair-dependent likelihood multipliers, nonuniform-prior Pearson
optimization, continuous alphabets, interaction, and exact minimum output
size for each selected utility remain outside the proved scope.

The finite-sample result distinguishes locally or globally unbiased
$\mathbb R^k$-valued reconstruction from arbitrary biased estimation.
Simplex projection is used only for the asymptotic upper bound, where
risk cannot increase. The integrated lower bound proves the asymptotic
claim without an unbiasedness assumption. The finite-sample unrestricted
minimax value is not identified by these arguments.

The separate review records specify which mathematical statements,
literature comparisons, computations, and Lean sources were checked. A
native kernel proof of the structural core does not imply a kernel proof
of the new information and estimation results, and no unavailable remote
CI execution is counted as successful verification.


# Appendix A. Complete proof of the active-graph theorem

## A.1 Definitions and precise statement

Let $X$ be a finite nonempty input set, $E\ge 1$, and let $\delta_{ij}\in[0,1]$ be fixed for every distinct $i,j\in X$. A finite-output channel $Q$, with output set $Y$, has columns $v_y\in\mathbb R_+^X$ satisfying

$$
\sum_{y\in Y}v_y(i)=1\qquad(i\in X).
$$

Write

$$
d_{ij}(v)=v(i)-E v(j),\qquad
\phi_{ij}(v)=(d_{ij}(v))_+,
\qquad H_{ij}(Q)=\sum_y\phi_{ij}(v_y).
$$

The feasible class consists of all such channels, with arbitrary finite output sets, for which $H_{ij}(Q)\le\delta_{ij}$. For the fixed channel $Q$, define its active ordered-pair constraints by

$$
\mathcal A(Q)=\{(i,j):i\ne j,\ H_{ij}(Q)=\delta_{ij}\}.
$$

For each nonzero column $v$, let $S(v)=\{i:v(i)>0\}$. Its **active equality graph** is an undirected graph on $S(v)$: distinct $i,j$ are adjacent when

$$
[(i,j)\in\mathcal A(Q)\text{ and }v(i)=E v(j)]
\quad\text{or}\quad
[(j,i)\in\mathcal A(Q)\text{ and }v(j)=E v(i)].
$$

A singleton graph is connected. Zero columns are not tested by this condition.

For channels $R=(r_z)_{z\in Z}$ and $Q=(v_y)_{y\in Y}$, write $R\succeq_B Q$ if a row-stochastic kernel $K(y\mid z)\ge0$, $\sum_yK(y\mid z)=1$, satisfies

$$
v_y=\sum_z K(y\mid z)r_z.
$$

Here maximality means

$$
R\text{ feasible and }R\succeq_BQ
\quad\Longrightarrow\quad Q\succeq_BR.
$$

It is not the assertion that $Q$ dominates every feasible channel.

**Theorem.** A feasible finite-output channel $Q$ is maximal in the Blackwell order within the specified feasible class if and only if the active equality graph of every nonzero column of $Q$ is connected.

The theorem includes $E=1$, zero privacy budgets, saturated privacy budgets, zero output columns, and single-element column supports. It does not need symmetry of the ordered-pair budgets.

## A.2 Elementary graph lemma

Let $v\ge0$ be nonzero. Let $G$ be a connected graph on $S(v)$, and attach to every edge an orientation $i\to j$ for which $v(i)=E v(j)$. Suppose $u\ge0$ satisfies:

1. $u(i)=0$ whenever $v(i)=0$;
2. $u(i)=E u(j)$ for every oriented edge.

Then $u=cv$ for a scalar $c\ge0$.

**Proof.** The ratios $u(i)/v(i)$ are defined on $S(v)$. At any oriented edge, $E>0$ and the two equalities imply equality of the ratios. Along a path the ratio is constant. Connectivity makes it constant on $S(v)$; outside that set both vectors vanish. Nonnegativity makes the common scalar nonnegative. For a singleton support the same statement follows without using an edge. $\square$

## A.3 Hockey-stick data processing and its equality consequence

The positive-part function satisfies

$$
(a+b)_+\le a_++b_+,
\qquad (ca)_+=ca_+\quad(c\ge0).
$$

Consequently $R\succeq_BQ$ implies $H_{ij}(Q)\le H_{ij}(R)$ for each ordered pair. Indeed, summing subadditivity over $y$ and then using the row sums of $K$ gives the assertion.

More specifically, introduce the nonnegative refined columns

$$
u_{zy}=K(y\mid z)r_z,
\qquad \sum_z u_{zy}=v_y.
$$

For a fixed ordered pair, every column defect

$$
D_y=\sum_z\phi_{ij}(u_{zy})-\phi_{ij}(v_y)
$$

is nonnegative. If $(i,j)\in\mathcal A(Q)$ and $R$ is feasible, then

$$
H_{ij}(Q)\le H_{ij}(R)\le\delta_{ij}=H_{ij}(Q).
$$

Thus $\sum_yD_y=0$, so $D_y=0$ for every $y$.

Suppose also that $v_y(i)=E v_y(j)$. Then $\phi_{ij}(v_y)=0$, and

$$
\sum_z(d_{ij}(u_{zy}))_+=0.
$$

Every summand is zero, hence every $d_{ij}(u_{zy})\le0$. Their sum is $d_{ij}(v_y)=0$, so in fact

$$
u_{zy}(i)=E u_{zy}(j)\qquad\text{for every }z.
$$

This argument needs only the indicated active orientation; it does not assume that the reversed constraint is active.

## A.4 Sufficiency: construct an explicit reverse channel

Assume all the nonzero column graphs of $Q$ are connected. Let $R$ be feasible and $R\succeq_BQ$, witnessed by $K$.

For each fixed $y$, $\sum_z u_{zy}=v_y$ and all summands are nonnegative. Therefore $u_{zy}(i)=0$ whenever $v_y(i)=0$. Section A.3 supplies all the active-edge equalities for $u_{zy}$. The graph lemma gives

$$
u_{zy}=c_{yz}v_y,
\qquad c_{yz}\ge0,
$$

whenever $v_y\ne0$.

Let $m(v)=\sum_i v(i)$. For such columns an explicit coefficient is

$$
c_{yz}=\frac{m(u_{zy})}{m(v_y)},
\qquad \sum_z c_{yz}=1.
$$

Both output sets are nonempty: a channel on the nonempty input set has a row summing to one. Choose $z_0\in Z$. Define a kernel from $Y$ to $Z$ by

$$
L(z\mid y)=
\begin{cases}
c_{yz},&v_y\ne0,\\
\mathbf1_{z=z_0},&v_y=0.
\end{cases}
$$

Each row of $L$ is a probability distribution. If $v_y=0$, nonnegativity of the $u_{zy}$ also gives $u_{zy}=0$. Hence, for every $z$,

$$
\sum_yL(z\mid y)v_y
=\sum_yu_{zy}
=\left(\sum_yK(y\mid z)\right)r_z
=r_z.
$$

Thus $Q\succeq_BR$, proving maximality. Notice that the proof handles a genuinely stochastic garbling, not just deterministic column aggregation.

## A.5 A scalar functional that certifies strict Blackwell improvement

For $v\ge0$, define

$$
\Psi(v)=
\begin{cases}
\displaystyle\frac{\sum_i v(i)^2}{m(v)},&m(v)>0,\\
0,&m(v)=0,
\end{cases}
\qquad
\Phi(Q)=\sum_y\Psi(v_y).
$$

Nonnegative $v$ has $m(v)=0$ exactly when $v=0$. The functional is positively homogeneous: $\Psi(cv)=c\Psi(v)$ for $c\ge0$.

It is also subadditive on the nonnegative cone. A complete identity proving this is as follows. For finitely many $u_z\ge0$, let $v=\sum_z u_z$, $m=m(v)>0$, and $m_z=m(u_z)$. Ignore terms with $m_z=0$, since their vectors are zero. Expanding the squares gives

$$
\sum_z\Psi(u_z)-\Psi(v)
=\sum_{z:m_z>0}m_z
\sum_i\left(\frac{u_z(i)}{m_z}-\frac{v(i)}m\right)^2
\ge0.
$$

The identity follows from $\sum_zm_z=m$ and $\sum_zu_z(i)=v(i)$. If $m=0$, every vector vanishes and the inequality is equality. Consequently, for any garbling $R\succeq_BQ$,

$$
\Phi(Q)
\le\sum_{y,z}\Psi(K(y\mid z)r_z)
=\sum_z\left(\sum_yK(y\mid z)\right)\Psi(r_z)
=\Phi(R).
$$

This global monotonicity is essential. The assertion that one column has been split into nonproportional pieces would not by itself justify strictness against arbitrary remixing with the other output columns.

## A.6 Necessity: a constructive strict improvement from a disconnected column

Suppose a nonzero column $v=v_{y_*}$ has a disconnected active equality graph. Choose a nonempty proper union $C\subset S(v)$ of connected components, and set $D=S(v)\setminus C$. Define

$$
a=\sum_{i\in C}v(i)>0,
\qquad b=\sum_{i\in D}v(i)>0,
$$

and a signed perturbation direction

$$
h(i)=
\begin{cases}
bv(i),&i\in C,\\
-av(i),&i\in D,\\
0,&i\notin S(v).
\end{cases}
$$

Then $\sum_i h(i)=ba-ab=0$, and $h\ne0$.

### A.6.1 Every active equality is preserved

For any active ordered pair put $\alpha_{ij}=d_{ij}(v)$ and $\beta_{ij}=d_{ij}(h)$. If $\alpha_{ij}=0$, then $\beta_{ij}=0$.

To see this, since $E>0$, the equality $v(i)=Ev(j)$ says either both coordinates are zero or both are positive. In the zero case both perturbation coordinates vanish. In the positive case the active equality defines a graph edge, so $i,j$ lie together in $C$ or together in $D$. On either block $h$ is a constant multiple of $v$, which preserves this equality. No graph edge can cross the chosen component partition.

### A.6.2 Choose one explicit positive perturbation size

For an inactive ordered pair let its slack be

$$
s_{ij}=\delta_{ij}-H_{ij}(Q)>0.
$$

Define the finite positive number

$$
M=1+a+b
+\sum_{\substack{(i,j)\in\mathcal A(Q)\\\alpha_{ij}\ne0}}
\frac{|\beta_{ij}|}{|\alpha_{ij}|}
+\sum_{(i,j)\notin\mathcal A(Q)}\frac{|\beta_{ij}|}{s_{ij}},
\qquad t=\frac1{2M}>0.
$$

All denominators in these sums are strictly positive. Empty sums are zero. It follows that $ta<1/2$, $tb<1/2$, that

$$
t|\beta_{ij}|<\tfrac12|\alpha_{ij}|
\quad\text{for each active pair with }\alpha_{ij}\ne0,
$$

and that $t|\beta_{ij}|<s_{ij}/2$ for each inactive pair. These inequalities also hold when the relevant numerator is zero.

Replace $v$ by two output columns

$$
v^+=\tfrac12(v+th),\qquad v^-=\tfrac12(v-th).
$$

Both are nonnegative, since on each positive-support block their multiplicative factors are $1\pm tb$ or $1\pm ta$, and both sum to $v$. Leave all other columns unchanged, obtaining a finite channel $Q'$. The deterministic kernel that merges the two new outputs witnesses $Q'\succeq_BQ$.

### A.6.3 Feasibility of the perturbed channel

For active pairs with $\alpha_{ij}=0$, Section A.6.1 gives $\beta_{ij}=0$. For active pairs with nonzero $\alpha_{ij}$, the two numbers $\alpha_{ij}\pm t\beta_{ij}$ have the same sign as $\alpha_{ij}$. In every case,

$$
\phi_{ij}(v^+)+\phi_{ij}(v^-)
=\tfrac12(\alpha_{ij}+t\beta_{ij})_+
+\tfrac12(\alpha_{ij}-t\beta_{ij})_+
=(\alpha_{ij})_+.
$$

Thus every active budget remains exactly unchanged.

For an inactive pair, the elementary Lipschitz inequality $(r+s)_+\le r_++|s|$ gives

$$
\phi_{ij}(v^+)+\phi_{ij}(v^-)
\le\phi_{ij}(v)+t|\beta_{ij}|.
$$

Therefore

$$
H_{ij}(Q')\le H_{ij}(Q)+t|\beta_{ij}|
<H_{ij}(Q)+s_{ij}/2<\delta_{ij}.
$$

All constraints hold. This step accounts for inactive pairs whose original column difference is zero; no unjustified sign-preservation assumption is imposed on them.

### A.6.4 Strictness

Set $m=m(v)=a+b>0$. Because $\sum_i h(i)=0$, both new columns have mass $m/2$. Expansion yields the exact identity

$$
\Psi(v^+)+\Psi(v^-)-\Psi(v)
=\frac{t^2}{m}\sum_i h(i)^2>0.
$$

The strict inequality follows from $t>0$, $m>0$ and $h\ne0$. Hence $\Phi(Q')>\Phi(Q)$. If $Q\succeq_BQ'$, Section A.5 would imply the reverse inequality. Thus $Q\not\succeq_BQ'$, so $Q$ is not maximal. $\square$


# Appendix B. Canonical refinement and optimization

## B.1 A finite sign-cell decomposition

Fix $k\ge2$ and $E\ge1$. For a nonnegative vector let $m(v)=\sum_i v_i$ and $h_{ij}(v)=(v_i-Ev_j)_+$. First normalize a nonzero vector so that $m(v)=1$. For every ordered pair choose the closed halfspace
$w_i-Ew_j\ge0$ when $v_i-Ev_j\ge0$, and $w_i-Ew_j\le0$ otherwise. Intersect these halfspaces with $w\ge0$ and $m(w)=1$, and call the resulting bounded polytope $P_v$. On this sign cell each $h_{ij}$ is either the linear functional $w_i-Ew_j$ or the zero functional. Every convex combination in $P_v$ therefore preserves every directed loss exactly.

For $w\in P_v$, let $G(w)$ be the undirected graph on its positive support, with an edge between distinct $i,j$ when $w_i=Ew_j$ or $w_j=Ew_i$. We prove directly that its connected points are precisely the vertices of $P_v$, and that every point has a finite decomposition into such points.

Suppose $G(w)$ is disconnected. Choose one component $C$ and let $D=S(w)\setminus C$. Put $a=\sum_{i\in C}w_i>0$ and $b=\sum_{i\in D}w_i>0$, so $a+b=1$, and define

$$
d_i=
\begin{cases}
b w_i,&i\in C,\\
-a w_i,&i\in D,\\
0,&i\notin S(w).
\end{cases}
$$

Then $\sum_i d_i=0$. A tight coordinate constraint is preserved because $w_i=0$ implies $d_i=0$. A tight ratio constraint is also preserved: its two coordinates are both zero, or they are joined by an equality edge and receive the same multiplier. Every other defining inequality is strict at $w$.

Consequently the feasible parameters in $w+td$ form a closed interval $[-t_-,t_+]$ with $t_-,t_+>0$. To see both positivity and finiteness explicitly, intersect the finitely many linear halfspace bounds. A bound from a strict inequality lies at positive distance from zero. Coordinate positivity gives $t\le1/a$ on $D$ and $t\ge-1/b$ on $C$, so both endpoints are finite and attained.

At $t=t_+$, either all of $D$ becomes zero, or a formerly strict ratio constraint becomes tight while both involved coordinates stay positive. In the second case the new edge joins $C$ to a component in $D$: ratios within $C$ and within $D$ are unchanged. At $t=-t_-$ the corresponding alternatives are that $C$ vanishes or a new cross-component edge appears. Existing edges persist on surviving coordinates. Each endpoint thus has strictly fewer positive-support components than $w$.

Now use the exact identity

$$
w=\frac{t_-}{t_++t_-}(w+t_+d)
 +\frac{t_+}{t_++t_-}(w-t_-d).
$$

Both weights are positive. Recursion on the number of components stops after at most $k-1$ splits along a branch and produces at most $2^{k-1}$ leaves. Every descendant remains in the original $P_v$, so all losses are preserved throughout. This constructs the required finite decomposition.

For the vertex characterization, let a connected $w$ satisfy
$w=\lambda u+(1-\lambda)z$ with $u,z\in P_v$ and $0<\lambda<1$. Zero coordinates of $w$ force the corresponding coordinates of $u,z$ to vanish. A tight ratio halfspace at $w$ forces equality separately in $u,z$. Along $G(w)$ the ratios $u_i/w_i$ are therefore constant. Thus $u=cw$, and normalization gives $c=1$; likewise $z=w$. Conversely, the perturbation above makes every disconnected $w$ nonextreme. Intersecting the corresponding nonnegative cone with the mass-one hyperplane gives the equivalent statement for its nonzero extreme rays.

## B.2 Complete list of connected equality patterns

### The case $E=1$

Connectedness forces all positive coordinates to be equal. The prototypes are exactly

$$
r_S=\frac{\mathbf1_S}{|S|},\qquad
\varnothing\ne S\subseteq[k].
$$

Each graph is complete on $S$, and there are $M_1(k)=2^k-1$ prototypes. The numerical bound alone is not a novelty claim; see Section 1.1.

### The case $E>1$

Singleton supports give the $k$ unit vectors. On a support $S$ of size $s\ge2$, choose a minimum positive coordinate $a$. Every equality edge changes a coordinate by a factor $E$ or $E^{-1}$. Connectedness implies that each coordinate is $aE^z$ for an integer $z$. Exponents are independent of the chosen path because $z\mapsto E^z$ is injective. Minimality of $a$ gives $z\ge0$.

Let $m$ be the largest exponent. A path from exponent $0$ to exponent $m$ changes the exponent by one in either direction at each edge, and hence visits every intermediate integer. A connected graph with at least two vertices contains an edge, so $m\ge1$; surjectivity of the levels gives $m\le s-1$. Conversely, if every level $0,\ldots,m$ occurs, all vertices on adjacent levels are joined, and the graph is connected.

Thus the complete family consists of

$$
r_i=
\begin{cases}
\displaystyle\frac{E^{\ell(i)}}{\sum_{j\in S}E^{\ell(j)}},&i\in S,\\
0,&i\notin S,
\end{cases}
$$

where a singleton uses $\ell=0$, and otherwise
$\ell:S\to\{0,\ldots,m\}$ is surjective with $1\le m\le|S|-1$. The patterns are distinct: the support and the ratios to the minimum positive coordinate recover all exponent labels.

For a fixed support of size $s$ and $L=m+1$ levels, there are $L!\,S(s,L)$ surjections: partition the support into $L$ nonempty blocks and then label the blocks. Consequently

$$
M_E(k)=k+\sum_{s=2}^{k}\binom{k}{s}
               \sum_{L=2}^{s}L!\,S(s,L),\qquad E>1.
$$

The count is independent of the numerical value of $E>1$. For $k=1,\ldots,6$ it is $1,4,21,138,1055,9308$. The first entry is only a counting check outside the research domain. The finite list does not imply an efficient algorithm as $k$ grows.

## B.3 Assemble a channel and its explicit reverse garbling

For every nonzero column $v_y$ of $Q$, decompose $v_y/m(v_y)$ by Sections B.1–B.2 and multiply its weights by $m(v_y)$. Assign only zero coefficients to a zero column. Collecting occurrences of a prototype yields $a_{y,r}\ge0$ with

$$
v_y=\sum_r a_{y,r}r,\qquad
h_{ij}(v_y)=\sum_r a_{y,r}h_{ij}(r).
$$

Put $a_r=\sum_y a_{y,r}$ and let $R$ have columns $a_r r$. Then

$$
\sum_r a_r r_i=\sum_yv_y(i)=1,\qquad
H_{ij}(R)=\sum_r a_rh_{ij}(r)=H_{ij}(Q).
$$

In particular, all realized losses are preserved exactly, and at most $M_E(k)$ columns are nonzero. For $a_r>0$, define $K(y\mid r)=a_{y,r}/a_r$. When $a_r=0$, choose any probability distribution on the nonempty original output alphabet. These rows sum to one and satisfy

$$
\sum_r K(y\mid r)\,a_r r=v_y.
$$

Therefore $R\succeq_BQ$. Collection of equal rays does not require deterministic reconstruction of the old output label: the displayed stochastic kernel supplies the reconstruction. The family is cofinal under feasible Blackwell domination for every budget vector; it need not consist exclusively of maximal channels.

## B.4 Invariance of the posterior support under Blackwell equivalence

For a nonzero vector write $p(v)=v/m(v)$, and let
$\Psi(v)=\sum_i v_i^2/m(v)$, with $\Psi(0)=0$. For nonnegative $u_z$ whose sum $v$ is nonzero, the variance identity from Appendix A.5 is

$$
\sum_z\Psi(u_z)-\Psi(v)
=\sum_{z:m(u_z)>0}m(u_z)\|p(u_z)-p(v)\|_2^2.
$$

If $v=0$, all $u_z$ vanish and the deficit is zero. Apply the identity to $u_z=K(y\mid z)r_z$ for each output $y$. Equality in the full-channel data-processing inequality holds precisely when every nonzero contribution to each $y$ has
$p(r_z)=p(v_y)$.

If $Q$ and $R$ dominate one another, monotonicity forces equality of their quadratic perspectives. Every nonzero $v_y$ receives at least one nonzero contribution, so its posterior appears among the nonzero columns of $R$. Interchanging $Q,R$ proves equality of their sets of normalized nonzero columns. A channel with $M$ distinct posterior directions therefore cannot be equivalent to one with fewer than $M$ nonzero outputs. The posterior set alone does not characterize equivalence; its weights also matter.

## B.5 The universal Blackwell alphabet bound is sharp

Let $M=|\mathcal R_E(k)|$ and form $Q_*$ with one column $(k/M)r$ for every prototype. The family is invariant under coordinate permutations. Its sum has equal coordinates and total coordinate sum $M$, so every row of $Q_*$ sums to one.

Permutation symmetry also makes all directed losses equal to a common $\delta_*$. The unit vector $e_i$ contributes $k/M>0$ to $H_{ij}(Q_*)$, so $\delta_*>0$. Moreover,

$$
H_{ij}(Q_*)=
1-\sum_{r\in\mathcal R_E(k)}\frac{k}{M}\min(r_i,Er_j).
$$

The subtracted sum is positive because the family contains a prototype positive on every coordinate: use $\mathbf1/k$ at $E=1$, or one high level and $k-1$ low levels at $E>1$. Hence $\delta_*<1$.

Give every directed pair the budget $\delta_*$. All constraints are then active, and every column has a connected full equality graph. Theorem 1 makes $Q_*$ maximal. Any feasible channel dominating it must be equivalent, and Section B.4 forces that channel to retain all $M$ distinct posterior directions. It therefore has at least $M$ nonzero outputs. Together with Section B.3, this proves the sharp universal bound, already for one common budget in $(0,1)$.

The lower bound is uniform over the collection of admissible budgets. It does not say that each fixed budget needs $M$ outputs. It also does not bound below the number of outputs needed to optimize one selected scalar utility.

## B.6 Exact optimization for a selected column utility

Let $\mu:\mathbb R_+^k\to\mathbb R$ be continuous, convex and positively homogeneous, with $\mu(0)=0$. Convexity at weight $1/2$ and homogeneity give
$\mu(u+v)\le\mu(u)+\mu(v)$; induction gives finite subadditivity. The refinement of Section B.3 therefore satisfies
$U(R)\ge U(Q)$, where $U(Q)=\sum_y\mu(v_y)$.

The finite feasible weight set is

$$
\mathcal P(E,\delta)=
\left\{a\ge0:
 \sum_r a_r r_i=1\quad(i\in[k]),\
 \sum_r a_rh_{ij}(r)\le\delta_{ij}\quad(i\ne j)
\right\}.
$$

It is nonempty: the one-output input-independent channel is feasible, since $E\ge1$, and Section B.3 gives a canonical refinement with the same zero losses. The set is closed. Since each prototype has mass one, summing the row constraints gives $\sum_r a_r=k$, proving boundedness. Finite-dimensional compactness and continuity of the linear objective imply attainment. Every canonical feasible weight vector is a feasible finite channel, while every feasible finite channel admits an objective-improving canonical refinement. Therefore

$$
\sup_{Q\in\mathcal C(E,\delta)}U(Q)
=\max_{a\in\mathcal P(E,\delta)}\sum_r a_r\mu(r).
$$

For the support bound, start from a maximizer with more than $k^2$ positive coordinates. Its corresponding feature vectors

$$
F(r)=\bigl((r_i)_{i=1}^k,\ (h_{ij}(r))_{i\ne j}\bigr)
\in\mathbb R^{\,k+k(k-1)}
$$

are linearly dependent. Choose nonzero $b$ supported on the positive coordinates with $\sum_r b_rF(r)=0$. Summing the normalization features gives $\sum_r b_r=0$, so $b$ has both positive and negative entries. Replace $b$ by $-b$ if necessary to ensure $\sum_r b_r\mu(r)\ge0$. Then take

$$
t=\min_{\{r:b_r<0\}}\frac{a_r}{-b_r}>0,\qquad a'=a+tb.
$$

Every coefficient stays nonnegative and at least one becomes zero. All normalization features and every actual directed loss remain unchanged. The objective cannot decrease and, by optimality of $a$, cannot increase either. Iteration terminates with at most $k^2$ positive coefficients. This compression need not preserve domination of a previously specified channel.

For the finite certificates, use free multipliers $\lambda_i\in\mathbb R$ and nonnegative multipliers $\gamma_{ij}\ge0$, with

$$
\sum_i\lambda_i r_i+\sum_{i\ne j}\gamma_{ij}h_{ij}(r)\ge\mu(r)
\qquad(r\in\mathcal R_E(k)).
$$

Multiplication by feasible $a_r$ and summation give the weak-duality bound

$$
\sum_r a_r\mu(r)
\le\sum_i\lambda_i+\sum_{i\ne j}\delta_{ij}\gamma_{ij}.
$$

The reported primal and dual certificates are feasible and have equal rational objective values, which proves optimality for those instances. No general strong-duality theorem or floating-point solver status is used as evidence.

## B.7 A six-output three-level example

For $k=3$ and $E=2$, take the six permutations of $(1,2,4)/14$. Every row sums to $2(1+2+4)/14=1$. For a fixed directed pair, the six value pairs are
$(1,2),(1,4),(2,1),(2,4),(4,1),(4,2)$, divided by $14$. Only $(4,1)$ gives a positive value of $v_i-2v_j$, equal to $1/7$. With all budgets $1/7$, every constraint is active and each column has the connected path through the values $1,2,4$.

The channel is maximal by Theorem 1. Every feasible dominator is equivalent and must retain all six three-level posterior directions by Section B.4. Hence no feasible channel whose columns each have at most two distinct positive values can dominate it.

Each column contributes $(1^2+2^2+4^2)/(14(1+2+4))=3/14$ to $\Phi$, giving $\Phi(Q)-1=2/7$. The exact optimum for the uniform-input Pearson objective at the same budget is $11/28$, by Theorem 5 and the separate rational certificate. Maximality is thus compatible with failure to maximize this particular scalar utility.


# Appendix C. Complete proof of the Pearson frontier

The only project-specific input is the normalized loss-preserving decomposition in Theorem 2. The remaining extremal argument is given in full.

## C.1 Statement

Fix an integer $k\ge2$, a finite real $E\ge1$, and a probability vector
$p\in\mathbb R_+^k$. Define

$$
C=C_k(E):=\max_{1\le d\le k-1}
 \frac{d(k-d)(E-1)^2}{[k+d(E-1)]^2},
\qquad
\alpha:=\frac{k-1-C}{k-1}.
$$

Then $0\le C<k-1$, so $\alpha>0$, and

$$
\boxed{\quad
k\sum_i p_i^2-1
\le C+\alpha\sum_{i\ne j}(p_i-Ep_j)_+.
\quad} \tag{C1}
$$

For $E>1$, equality holds precisely when either:

* $p$ is a coordinate unit vector; or
* for some maximizing $d$ in the definition of $C$, all $k$ coordinates
  are positive, exactly $d$ are $E/[k+d(E-1)]$, and the other $k-d$ are
  $1/[k+d(E-1)]$.

For $E=1$, equality holds precisely at coordinate unit vectors and the
uniform probability vector.

## C.2 Homogeneous notation and a universal auxiliary bound

For a nonnegative vector $x$ on its positive support of size $s\ge2$, put

$$
S=\sum_i x_i,\quad V=\sum_i x_i^2,\quad D=S^2-V>0,
$$
$$
T_E(x)=\sum_{i\ne j}\min(x_i,E x_j),\qquad
R_E(x)=\frac{S T_E(x)}{D}.
$$

The quantity $R_E$ is invariant under multiplication of $x$ by a positive
scalar. Zero coordinates do not change it. If $x=p$ is a probability vector,
then

$$
R_E(p)=\frac{T_E(p)}{1-\sum_i p_i^2},\qquad
T_E(p)=k-1-\sum_{i\ne j}(p_i-Ep_j)_+.
$$

For every such $x$,

$$
\boxed{R_E(x)\le\frac{s(E+1)}2.} \tag{C2}
$$

Indeed, for each unordered pair, orient its coordinates as $x_i\ge x_j$.
Then its contribution to $T_E$ is at most $(E+1)x_j$. Also

$$
2\sum_{i<j}\min(x_i,x_j)
=(s-1)S-\sum_{i<j}|x_i-x_j|.
$$

Because $|x_i-x_j|\le S$, one has
$|x_i-x_j|\ge(x_i-x_j)^2/S$. The identity
$\sum_{i<j}(x_i-x_j)^2=sV-S^2$ therefore gives

$$
2\sum_{i<j}\min(x_i,x_j)
\le\frac{s(S^2-V)}S.
$$

Multiplying by $(E+1)/2$ proves (C2). No ratio constraint on $x$ is needed.

## C.3 Why a global maximum is attained at a canonical prototype

Suppose first that $E>1$. The finite normalized canonical family consists
of coordinate unit vectors and the geometric prototypes whose nonzero
coordinates are proportional to

$$
1,E,\ldots,E^m,
$$

where every intermediate level is occupied. Each probability vector has a
finite convex decomposition $p=\sum_r\lambda_r r$, with
$\lambda_r\ge0$, $\sum_r\lambda_r=1$, that preserves every directed
positive-part loss. In particular,

$$
T_E(p)=\sum_r\lambda_rT_E(r).
$$

Let $M$ be the maximum of $R_E(r)$ over the nonsingleton prototypes.
There are finitely many, and at least one exists, so $0<M<\infty$.
For existence, normalize $(1,E,0,\ldots,0)$, whose two positive
coordinates form a connected ratio graph and whose ratio $R_E$ is positive.
Singletons satisfy $T_E(r)=1-\|r\|_2^2=0$. Thus

$$
T_E(p)
\le M\sum_r\lambda_r(1-\|r\|_2^2)
\le M(1-\|p\|_2^2). \tag{C3}
$$

The second inequality is Jensen's inequality for the squared Euclidean norm.
Consequently, $M$ is also the global maximum of $R_E$ over all
nonvertex probability vectors, and some nonsingleton prototype attains it.
This argument avoids an unjustified continuity assertion at the simplex
vertices, where the displayed quotient has denominator zero.

Furthermore, equality in (C3) at a nonvertex probability vector forces all
positive-weight $r$'s in the decomposition to be identical: the squared
Euclidean norm is strictly convex, and $M>0$. Every global maximizer is
therefore itself a canonical prototype. This observation will yield the
complete equality classification after locating the maximizing prototypes.

## C.4 A maximizer has full support

Suppose a maximizer has positive support size $2\le s<k$. Keep its positive
coordinates $x$, and replace one zero coordinate by $t>0$, choosing
$t<\min_i x_i/E$. With $S,V,D,T=T_E(x)$ as above,

$$
R_E(x,t)=\frac{(S+t)[T+s(E+1)t]}{D+2St}.
$$

The numerator of the derivative at $t=0$, after multiplying by the
positive denominator squared, is

$$
S\,s(E+1)D-T(S^2+V)
=SD\left[s(E+1)-R_E(x)\left(1+\frac V{S^2}\right)\right].
$$

By (C2), $R_E(x)\le s(E+1)/2$; and $V/S^2<1$, since $s\ge2$.
The bracket is therefore strictly positive. Adding a sufficiently small
positive coordinate increases $R_E$, contrary to global maximality.
Every maximizing prototype has all $k$ coordinates positive.

## C.5 A maximizer cannot occupy three or more geometric levels

This is the main extremal step. Suppose a geometric prototype has at least
three occupied levels. Rescale its bottom level to $1$. Write its
coordinates as

* $a\ge1$ copies of $1$;
* $b\ge1$ copies of $E$;
* $c\ge1$ remaining coordinates $z_1,\ldots,z_c$, each at least $E^2$.

No geometric assumption on the remaining coordinates is needed below.
Put

$$
r=a+b,\quad \ell=a+bE,\quad v=a+bE^2,
\quad u=\sum_jz_j,\quad w=\sum_jz_j^2,\quad d=u^2-w\ge0,
$$
$$
\gamma=\frac{c(E+1)}2,\qquad
K=r-1+(E+1)c=r-1+2\gamma,
\qquad \tau=T_E(z).
$$

The auxiliary bound, with the singleton case interpreted directly, gives

$$
\tau\le\gamma\frac d u. \tag{C4}
$$

When $c=1$, one has $\tau=d=0$, so (C4) holds directly without applying
the quotient bound to a singleton.

Replace all $a$ bottom coordinates by $x$, where $1\le x\le E$.
For this whole interval, every ratio inside the first two groups is at most
$E$, and every coordinate in the last group is at least $E$ times each
coordinate in the first two groups. Hence the following expressions are
exact, including all boundary equalities:

$$
S(x)=ax+bE+u,\qquad
V(x)=ax^2+bE^2+w,\qquad
T_E(x)=K(ax+bE)+\tau.
$$

At $x=1$, abbreviate $S=\ell+u$, $V=v+w$, and $D=S^2-V$.
Differentiating $R_E(x)=S(x)T_E(x)/(S(x)^2-V(x))$ shows that the sign of
its right derivative at $1$ is the sign of

$$
P=KS(S^2-V)-(K\ell+\tau)(S^2+V-2S). \tag{C5}
$$

All original coordinates are at least $1$, and there are at least three
of them. Thus $S^2+V-2S>0$. Inserting (C4) into (C5) gives

$$
uP\ge Ku B_0+dB_1+\gamma d^2, \tag{C6}
$$

where the following is an exact polynomial expansion:

$$
B_0=(\ell^2-v+2\ell)u-2\ell(v-\ell),
$$
$$
B_1=(K-2\gamma)u^2+2(K-\gamma)\ell u+2\gamma u
 -\gamma(\ell^2+v-2\ell).
$$

Both coefficients have transparent positive bounds. First,
$u\ge cE^2\ge E^2$ and $\ell^2-v\ge0$. Consequently,

$$
\begin{aligned}
B_0&\ge(\ell^2-v+2\ell)E^2-2\ell(v-\ell)\\
&=E\Bigl[a(a+1)E+2ab(E^2-E+1)\\
&\hspace{30mm}+b(b-1)E\bigl((E-1)^2+1\bigr)+2bE\Bigr]>0.
\end{aligned} \tag{C7}
$$

Second, $\gamma\ge1$, $K-\gamma=r-1+\gamma\ge r$,
$u\ge cE^2\ge\gamma E$, and $\ell\le rE$. Therefore
$(K-\gamma)u\ge\gamma\ell$, and

$$
B_1\ge(r-1)u^2+\gamma(\ell^2-v+2\ell)+2\gamma u>0. \tag{C8}
$$

Equations (C6)–(C8), with $K,u>0$ and $d\ge0$, imply $P>0$.
Since $E>1$, there is a nonempty interval immediately to the right of
$x=1$. Increasing the bottom level slightly therefore increases
$R_E$, contradicting global maximality.

Thus every maximizing prototype has exactly two occupied levels and full
support. This proof does not assume that a long geometric chain can simply
be collapsed without affecting the objective; it supplies a strict feasible
local improvement with its complete sign calculation.

## C.6 Evaluation of the maximum and the equality cases

A full-support two-level prototype has $k-d$ entries $1$ and $d$
entries $E$, for $1\le d\le k-1$. Write
$L=k+d(E-1)$, $V_d=k+d(E^2-1)$. Its directed losses vanish, so

$$
R_d=\frac{(k-1)L^2}{L^2-V_d}
=\frac{k(k-1)}{k-1-C_d},\qquad
C_d=\frac{d(k-d)(E-1)^2}{L^2}.
$$

Since the last expression for $R_d$ is strictly increasing in $C_d$,

$$
M=\frac{k(k-1)}{k-1-C}.
$$

Also $V_d<L^2$, so $C_d<k-1$, proving the earlier positivity claim
for $\alpha$. Inequality (C3) becomes

$$
T_E(p)\le\frac{k(k-1)}{k-1-C}(1-\|p\|_2^2),
$$

which is algebraically equivalent to (C1). Sections C.3–C.5 show that its
nonvertex equality cases are exactly the maximizing full-support two-level
prototypes. Simplex vertices satisfy (C1) with equality directly.

If $E=1$, (C2) with support size at most $k$ immediately proves
$T_1(p)\le k(1-\|p\|_2^2)$, and $C=0$. For nonvertex equality,
the support must have size $k$. Equality in the pairwise estimate used
in (C2) then requires every difference $|p_i-p_j|$ to be either $0$
or $1$. Full support with $k\ge2$ excludes difference $1$, so
all coordinates are equal. The remaining equality cases are the vertices.

## C.7 Exact finite-channel optimum and all optimizer types

Fix a common budget $0\le\delta\le1$. Let $Q$ be any finite-output
channel on $k$ inputs satisfying

$$
H_{ij}(Q)=\sum_y(Q(y\mid i)-E Q(y\mid j))_+\le\delta
\quad(i\ne j).
$$

With a uniform input, write the nonzero output columns as
$v_y=m_y p_y$, where $m_y=\sum_i v_{y,i}$, and let
$w_y=m_y/k$ be the output probability. The Pearson information is

$$
I_{\chi^2}(Q)=\sum_yw_y(k\|p_y\|_2^2-1)
=\sum_y\frac{\|v_y\|_2^2}{m_y}-1.
$$

Summing (C1) with weights $w_y$ yields

$$
\begin{aligned}
I_{\chi^2}(Q)
&\le C+\frac\alpha k\sum_{i\ne j}H_{ij}(Q)\\
&\le C+\alpha(k-1)\delta\\
&=\boxed{(1-\delta)C+\delta(k-1)}. \tag{C9}
\end{aligned}
$$

The bound is attained by a flagged mixture of two finite mechanisms. Choose
a maximizing $d$, let $N=\binom{k}{d}$, $L=k+d(E-1)$, and output
one label for every $d$-subset $A$ of the inputs, with column

$$
Q_0(A\mid i)=\frac{k}{NL}
 \begin{cases}E,&i\in A,\\1,&i\notin A.\end{cases}
$$

Symmetry gives row sums one. The mechanism is pure $E$-private, and
$I_{\chi^2}(Q_0)=C$. Using disjoint output labels, the channel
$(1-\delta)Q_0\oplus\delta I_k$ has every directed loss exactly
$\delta$ and information exactly (C9). Therefore (C9) is the exact
maximum over all finite output alphabets.

There is also a complete optimizer characterization. Because $\alpha>0$,
equality in (C9) forces every directed budget to be tight and every nonzero
column posterior to be a pointwise equality case from Section C.1. All
nonsingleton equality columns have zero directed privacy loss. If $s_i$
is the total coefficient of singleton columns supported on input $i$,
then $H_{ij}(Q)=s_i$ for every $j\ne i$. Thus $s_i=\delta$ for
all inputs. After collecting proportional singleton columns, the channel
has exactly a $\delta I_k$ part; the remaining rows have total mass
$1-\delta$, and all remaining nonzero column posteriors are pure-optimal
ones. Conversely every channel of this form attains (C9).

For $\delta<1$, division of the remaining columns by $1-\delta$
produces a pure optimal channel. For $\delta=1$ the remaining columns
vanish. For $E=1$, the pure portion is input-independent. These statements
cover $\delta=0$, $\delta=1$, and $E=1$ without a limiting argument.



# Appendix D. Complete statistical proofs

The model is categorical distribution estimation from independent privatized samples. The information input is Theorem 5. The integrated information method is standard [10]; its uniform application and exact resulting constant are proved below.

## D.1 Model and theorem

Fix $k\ge2$, $E\ge1$, $0\le\delta\le1$, and write

$$
d=k-1,\qquad
C_k(E)=\max_{1\le j\le k-1}
 \frac{j(k-j)(E-1)^2}{[k+j(E-1)]^2},
$$
$$
A=(1-\delta)C_k(E)+\delta(k-1)>0.
$$

An unknown categorical distribution $p\in\Delta_k$ generates
$X_1,\ldots,X_n$ independently. The same fixed finite-output channel
$Q$ is applied independently to each sample, and the statistician observes
$Y_1,\ldots,Y_n$. The channel obeys

$$
\sum_y(Q(y\mid i)-E Q(y\mid j))_+\le\delta\qquad(i\ne j).
$$

For each $n$, the channel and its finite output alphabet may be chosen
anew. Define

$$
\mathcal R_n=
\inf_{Q\ \mathrm{feasible}}\ \inf_{\widehat p:Y^n\to\Delta_k}
\ \sup_{p\in\Delta_k}
\mathbb E_p\|\widehat p-p\|_2^2.
$$

This includes arbitrary biased estimators. Randomized estimators do not
lower the infimum, since their conditional mean given the observations
remains in the convex simplex and has no greater squared loss.

**Theorem.** For every $0<\rho<1/k$ and every positive integer $n$,

$$
\boxed{
\frac{d^2}{nkA/(1-k\rho)+\pi^2d^2/\rho^2}
\le\mathcal R_n\le\frac{d^2}{nkA}.} \tag{D1}
$$

Consequently,

$$
\boxed{\lim_{n\to\infty} n\mathcal R_n
=\frac{(k-1)^2}{k[(1-\delta)C_k(E)+\delta(k-1)]}.} \tag{D2}
$$

The theorem concerns fixed noninteractive channels, possibly depending on
$n$. It makes no claim about interactive or adaptive mechanisms.

## D.2 Uniform Fisher trace bound near the center

Let $u=\mathbf1/k$, and choose a $k\times d$ matrix $B$ whose columns
form an orthonormal basis of $\mathbf1^\perp$. Parameterize the simplex
near its center by $p_\theta=u+B\theta$. Write $q_y\in\mathbb R_+^k$
for the output columns, and delete zero columns. Set

$$
m_y=\mathbf1^Tq_y>0,\qquad
r_y(\theta)=q_y^Tp_\theta,\qquad
M_Q=\sum_y\frac{q_yq_y^T}{m_y}.
$$

The one-observation Fisher information in the $\theta$ coordinates is

$$
I_Q(\theta)=\sum_y
 \frac{B^Tq_yq_y^TB}{r_y(\theta)}.
$$

At $\theta=0$, $r_y(0)=m_y/k$, so

$$
I_Q(0)=kB^TM_QB.
$$

Row normalization gives $M_Q\mathbf1=\mathbf1$. Since
$BB^T=I_k-\mathbf1\mathbf1^T/k$, the uniform-input Pearson information
$U(Q)=\operatorname{tr}M_Q-1$ satisfies

$$
\operatorname{tr}I_Q(0)=kU(Q)\le kA. \tag{D3}
$$

The final inequality is the exact approximate-privacy Pearson frontier.

If $\|\theta\|_2\le\rho<1/k$, then
$|(B\theta)_i|\le\rho$, and therefore

$$
p_{\theta,i}\ge1/k-\rho=\frac{1-k\rho}{k},
\qquad r_y(\theta)\ge(1-k\rho)r_y(0)>0.
$$

Comparing each positive-semidefinite summand gives

$$
I_Q(\theta)\preceq\frac{I_Q(0)}{1-k\rho},\qquad
\operatorname{tr}I_Q(\theta)\le\frac{kA}{1-k\rho}. \tag{D4}
$$

Both bounds hold uniformly over every feasible finite channel. No uniform
bound on the alphabet cardinality is required.

## D.3 An explicit compact prior with finite information

Put $a=\rho/\sqrt d$. On the cube $[-a,a]^d$, use the product density

$$
\pi_\rho(\theta)=\prod_{j=1}^d
 \left[\frac1a\cos^2\!\left(\frac{\pi\theta_j}{2a}\right)
 \mathbf1_{\{|\theta_j|<a\}}\right].
$$

Each factor integrates to one. Extended by zero, the density is
continuously differentiable, with zero boundary value and zero first
derivative on each face. Its support lies in $\|\theta\|_2\le\rho$,
hence strictly inside the categorical parameter space.

On the interior of the cube,

$$
\partial_j\log\pi_\rho(\theta)
=-\frac\pi a\tan\!\left(\frac{\pi\theta_j}{2a}\right).
$$

Consequently, its scalar Fisher information is finite and equals

$$
J_\rho:=\mathbb E_{\pi_\rho}\|\nabla\log\pi_\rho\|_2^2
=\frac{d\pi^2}{a^2}
=\frac{\pi^2d^2}{\rho^2}. \tag{D5}
$$

The score can be assigned any value on the boundary, which has prior
probability zero. The displayed finite value follows directly by
cancelling $\cos^2$ against $\tan^2$ and integrating $\sin^2$.

## D.4 Integrated information inequality for arbitrary estimators

Let

$$
L(y_1,\ldots,y_n\mid\theta)=\prod_{t=1}^nr_{y_t}(\theta)
$$

and let the joint prior-data score be

$$
S(\theta,Y^n)=\nabla_\theta\log L(Y^n\mid\theta)
 +\nabla_\theta\log\pi_\rho(\theta).
$$

Given an arbitrary estimator $\widehat p:Y^n\to\Delta_k$, put
$\widehat\theta=B^T(\widehat p-u)$. For every pair of coordinates
$j,\ell$, integration by parts yields

$$
\begin{aligned}
\mathbb E[(\widehat\theta_j-\theta_j)S_\ell]
&=\sum_{y^n}\int
 (\widehat\theta_j(y^n)-\theta_j)
 \partial_\ell[\pi_\rho(\theta)L(y^n\mid\theta)]\,d\theta\\
&=\delta_{j\ell}.
\end{aligned} \tag{D6}
$$

There is no unbiasedness assumption in this identity. The estimator is
independent of the unknown parameter, so differentiating
$\widehat\theta_j(y^n)-\theta_j$ gives $-\delta_{j\ell}$; the prior
vanishes at the boundary. Every output alphabet is finite, all active
likelihoods are positive on the prior support, and the simplex-valued
estimator is bounded. Thus these sums, derivatives, and integrations by
parts are justified directly without asymptotic regularity assumptions.

Conditional on $\theta$, each data score has mean zero. Independence
therefore gives

$$
\mathbb E\|S\|_2^2
=n\mathbb E_{\pi_\rho}\operatorname{tr}I_Q(\theta)+J_\rho
\le\frac{nkA}{1-k\rho}+J_\rho. \tag{D7}
$$

Take the trace of (D6) and apply Cauchy–Schwarz:

$$
d^2=\left(\mathbb E[(\widehat\theta-\theta)^TS]\right)^2
\le\mathbb E\|\widehat\theta-\theta\|_2^2\,
 \mathbb E\|S\|_2^2.
$$

Both $\widehat p$ and $p_\theta$ have coordinate sum one, so their
difference lies in $\mathbf1^\perp$, and the $B$ coordinates preserve
its Euclidean norm. Equations (D5)–(D7) give the Bayes lower bound

$$
\mathbb E_{\pi_\rho}\mathbb E_{p_\theta}
 \|\widehat p-p_\theta\|_2^2
\ge\frac{d^2}{nkA/(1-k\rho)+\pi^2d^2/\rho^2}.
$$

Worst-case risk dominates Bayes risk. The bound is uniform over the channel
and estimator, so taking their infima proves the lower inequality in (D1).
In particular it already applies to any sequence $Q_n$ of channels and
any sequence of growing finite output alphabets.

Allowing estimators to take values in $\mathbb R^k$ does not change the
minimax value. Euclidean projection onto the closed convex simplex weakly
reduces squared distance to every $p\in\Delta_k$; thus every such
estimator has a simplex-valued replacement with no larger risk. Estimators
of infinite risk cannot improve the infimum.

## D.5 A symmetric finite mechanism attains the upper constant

Use a Pearson-optimal mechanism $Q_*$ that is equivariant under every
permutation of the $k$ inputs. Such a finite mechanism is given by the
all-subsets pure optimizer, mixed on disjoint output labels with the
$\delta I_k$ reveal mechanism. Its Pearson information is exactly $A$.

Permutation symmetry forces the matrix $M_{Q_*}$ to have a common
diagonal and a common off-diagonal entry. Together with
$M_{Q_*}\mathbf1=\mathbf1$ and
$\operatorname{tr}M_{Q_*}=1+A$, this gives

$$
M_{Q_*}=\frac{\mathbf1\mathbf1^T}{k}
 +\frac A d\left(I_k-\frac{\mathbf1\mathbf1^T}{k}\right). \tag{D8}
$$

For each nonzero column, let $p_y=q_y/m_y$ be its posterior under the
uniform input. Define the one-observation reconstruction and its average by

$$
g(y)=u+\frac dA(p_y-u),\qquad
\widetilde p_n=\frac1n\sum_{t=1}^ng(Y_t).
$$

The reconstruction can have negative coordinates; it is an intermediate
$\mathbb R^k$-valued estimator with coordinate sum one. Since

$$
\mathbb E_p[p_Y]=M_{Q_*}p
=u+\frac A d(p-u),
$$

equation (D8) implies $\mathbb E_p[g(Y)]=p$ for every categorical
distribution, including boundary points. At the uniform distribution,

$$
\mathbb E_u\|g(Y)-u\|_2^2
=\frac{d^2}{A^2}\mathbb E_u\|p_Y-u\|_2^2
=\frac{d^2}{kA}. \tag{D9}
$$

The mechanism and reconstruction are equivariant under every input
permutation. Thus $\mathbb E[\|g(Y)\|_2^2\mid X=i]$ is the same for
every $i$. It follows that $\mathbb E_p\|g(Y)\|_2^2$ is independent
of $p$, and (D9) determines it. Independence of the samples yields the
exact finite-sample identity

$$
\mathbb E_p\|\widetilde p_n-p\|_2^2
=\frac{d^2}{nkA}+\frac{1/k-\|p\|_2^2}{n}
\le\frac{d^2}{nkA}. \tag{D10}
$$

Finally use $\widehat p_n=\Pi_{\Delta_k}(\widetilde p_n)$. Projection
does not increase the loss at any parameter, proving the upper inequality
in (D1) for admissible simplex-valued estimators. This estimator need not
remain unbiased after projection; no unbiasedness is required by the
minimax theorem.

## D.6 Order of limits and boundary cases

For every fixed $0<\rho<1/k$, the lower bound implies

$$
\liminf_{n\to\infty}n\mathcal R_n
\ge\frac{d^2(1-k\rho)}{kA}.
$$

The prior is held fixed in this first limit. Letting $\rho\downarrow0$
afterwards gives the lower constant $d^2/(kA)$. Equation (D10) gives
the matching upper limit, proving (D2). There is no exchange of an
infimum with an unproved pointwise limit.

The theorem includes $\delta=0$ when $E>1$, $E=1$ when
$\delta>0$, and $\delta=1$. In the last case the constant becomes
$(k-1)/k$, matching the ordinary categorical experiment.

The excluded case $A=0$ is exactly $E=1,\delta=0$. Then every
feasible channel is independent of the input. No observations identify
$p$, and $\mathcal R_n=1-1/k$ for every $n$: the constant estimator
$u$ attains this value, and averaging the risk over the $k$ vertices
gives the matching lower bound. Hence no finite $n\mathcal R_n$ limit
of the form (D2) is available in that degenerate experiment.

## D.7 Finite-sample local and global unbiased optimality

We now prove Theorem 6 with its separate unbiasedness condition. Let
$S_n=\nabla_\theta\log L(Y^n\mid\theta)|_{\theta=0}$ be the ordinary
data score, without a prior term. It has mean zero and second moment
$\mathbb E_u\|S_n\|^2=n\operatorname{tr}I_Q(0)$.
For an $\mathbb R^k$-valued estimator locally unbiased at $u$, require

$$
\mathbb E_u\widehat p=u,\qquad
\left.\frac{\partial}{\partial\theta}
\mathbb E_{u+B\theta}\widehat p\right|_{\theta=0}=B.
$$

With $\widehat\theta=B^T(\widehat p-u)$, differentiating the finite
likelihood sum gives

$$
\mathbb E_u[\widehat\theta S_n^T]=I_d.
$$

The regularity here is elementary: zero channel columns have been deleted,
every remaining output sequence has positive probability near $u$, and
the output alphabet is finite. Finite second moments justify replacing a
randomized estimator by its conditional mean if needed. Taking the trace
and applying Cauchy–Schwarz gives

$$
d^2\le\mathbb E_u\|\widehat\theta\|^2\,
n\operatorname{tr}I_Q(0)
\le\mathbb E_u\|\widehat p-u\|^2\,nkA.
$$

This proves the pointwise lower bound in Theorem 6. If $I_Q(0)$ is
singular, a nonzero vector $h$ in its kernel has $h^TS_n=0$ almost surely.
Multiplying the cross-moment identity by $h$ would then give $h=0$, a
contradiction. Thus no finite-variance estimator can be locally unbiased
in every tangent direction for such a channel. In particular, the
zero-information case has no finite-risk locally unbiased solution.

For the fully symmetric attaining channel, Section D.5 constructs the
globally unbiased affine reconstruction and proves its exact risk (D10).
At $u$ this risk is $d^2/(nkA)$, so the pointwise lower bound is attained
for every positive integer $n$. Its worst risk also occurs at $u$ because
$\|p\|^2\ge1/k$. Every globally unbiased estimator is locally unbiased
at the interior point $u$, so the same lower bound applies to its
worst-case risk. The construction attains it, proving the exact global
minimax value within the unbiased $\mathbb R^k$-valued class.

This finite-sample equality uses the affine estimator before simplex
projection. Projection can introduce bias. The unrestricted asymptotic
result instead uses the projected estimator and the prior-based lower
bound; its proof does not rely on a false pointwise bound for biased
estimators.



# References

[1] Peter Kairouz, Sewoong Oh and Pramod Viswanath. **Extremal Mechanisms for Local Differential Privacy.** Journal of Machine Learning Research 17(17):1–51, 2016. [Official full text](https://www.jmlr.org/papers/volume17/15-135/15-135.pdf).

[2] Seung-Hyun Nam, Hyun-Young Park and Si-Hyeon Lee. **Optimal Privacy-Utility Trade-Offs in LDP: Functional and Geometric Perspectives.** arXiv:2605.02319v2, 11 November 2026. [Primary source](https://arxiv.org/abs/2605.02319v2).

[3] Ankit Pensia, Amir R. Asadi, Varun Jog and Po-Ling Loh. **Simple Binary Hypothesis Testing under Local Differential Privacy and Communication Constraints.** IEEE Transactions on Information Theory 71(1):592–617, 2025; consulted arXiv:2301.03566v2, 15 December 2023. [Primary full text](https://arxiv.org/html/2301.03566v2).

[4] Karan Elangovan and Varun Jog. **On the Extreme Points of the (0, δ)-Differential Privacy Polytope.** IEEE ISIT 2024, pp. 3059–3064. [DOI](https://doi.org/10.1109/ISIT57864.2024.10619506). Bibliographic record verified through the author's Cambridge page and the official conference program; the full paper was not independently retrieved.

[5] Supriya Rawat, Myna Vajha, Gowtham R. Kurri and Anand Sarwate. **Extreme Points of the (0, δ)-LDP Polytope with Small Input Size and Arbitrary Output Sizes.** arXiv:2606.09161v2, 15 October 2026. [Primary full HTML](https://arxiv.org/html/2606.09161v2). Remark 1 explicitly states the general-$k$ bound $2^k-1$ for extreme $(0,\delta)$-private matrices. The HTML was inspected; the original PDF endpoint was unavailable. [Author seminar page](https://people.iith.ac.in/mynav/hyts.html).

[6] Natasha Fernandes, Annabelle McIver, Catuscia Palamidessi and Ming Ding. **Universal Optimality and Robust Utility Bounds for Metric Differential Privacy.** Consulted arXiv:2205.01258v1, 3 May 2022. [Primary full text](https://arxiv.org/pdf/2205.01258).


[7] Min Ye and Alexander Barg. **Asymptotically optimal private estimation under mean square loss.** Consulted arXiv:1708.00059v1, 31 July 2017. [Primary full text](https://arxiv.org/pdf/1708.00059).

[8] Shahab Asoodeh, Maryam Aliakbarpour and Flavio P. Calmon. **Local Differential Privacy Is Equivalent to Contraction of $E_\gamma$-Divergence.** Consulted arXiv:2102.01258v1, 2 February 2021. [Primary full text](https://arxiv.org/pdf/2102.01258).

[9] Jiangnan Cheng and Ao Tang. **Maximum Mutual Information under Local Differential Privacy Constraint.** IEEE ISIT 2022, pp. 2202–2206. DOI: 10.1109/ISIT50566.2022.9834741. [Author-hosted full text](https://people.ece.cornell.edu/atang/pub/22/Maximum_Mutual_Information_under_LDP.pdf).

[10] Leighton Pate Barnes, Wei-Ning Chen and Ayfer Özgür. **Fisher Information under Local Differential Privacy.** Consulted arXiv:2005.10783v1, 21 May 2020. [Primary full text](https://arxiv.org/pdf/2005.10783).

[11] Shahab Asoodeh and Huanyu Zhang. **Contraction of Locally Differentially Private Mechanisms.** Consulted arXiv:2210.13386v4, 3 May 2024. [Primary full text](https://arxiv.org/pdf/2210.13386).

[12] Mingen Pan. **Strict Optimality of Frequency and Distribution Estimation Under Local Differential Privacy.** arXiv:2603.11523v2, 22 March 2026. [Primary full text](https://arxiv.org/html/2603.11523v2).
