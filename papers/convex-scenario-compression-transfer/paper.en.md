# Strictly feasible convex scenario programs: exact realizations and minimax risk calibration

## Finite-sample lower bounds and the sharp high-confidence logarithmic correction

Research manuscript, substantive second research round, 25 November 2026. Written proofs and computational certificates are provided. Lean verification is a separate, unfinished deliverable. This manuscript has not undergone external peer review.

## Abstract

We study risk guarantees for convex scenario optimization when the number of determining observations is globally bounded by d, even though the ambient dimension may be larger. An explicit realization theorem converts every finite ordered feasible-choice system with a universal fallback into a compact, full-dimensional linear program with a common strict interior point and a unique optimizer for every sample. It preserves all support sublists and fresh-scenario violations. This answers the second open question in Garatti and Campi, Mathematical Programming 209 (2025), and transfers finite combinatorial obstructions into regular convex optimization. Null-scenario dilution gives a new finite-sample lower bound for the worst risk tail over this class. At compression two it strictly exceeds the proposed beta tail for every nontrivial sample-size/risk pair. A single nine-dimensional geometry also gives low-risk violations for every sample size N>=2 and a nonvanishing absolute gap for all sufficiently large sample sizes under explicitly varying laws. In the rare-risk scale, the lower bound is exp(-c)(1+c/d)^d. Combined with a known compression upper bound, it locates the least uniformly valid normalized sample count within an additive d, and proves that its high-confidence second-order term is d log log(1/beta), rather than the (d-1) coefficient of beta calibration. The exact minimax constant remains unidentified. All lower bounds survive smooth strong convexity and atomless laws with distinct scenario sets. Full formalization remains a separate unfinished task.

## 1. Problem, notation, and contribution

For a measurable scenario space (Delta, P), let X be a deterministic convex domain in R^D and let C_delta be a convex scenario set. A finite ordered sample S=(delta_1,...,delta_m), with repetitions permitted, produces the unique solution

$$
x(S)=\mathop{\rm argmin}_{x\in X\cap\bigcap_{i=1}^{m}C_{\delta_i}} c(x).
\tag{1}
$$

The empty sample is included. Its feasible domain is X. Define

$$
V(x)=\mathbb P\{\delta:x\notin C_\delta\},\qquad
s(S)=\min\{|I|:I\subseteq[m],\ x(S_I)=x(S)\}.
\tag{2}
$$

Here S_I retains the original order. A determining sublist need not be irreducible; an irreducible determining sublist is a support list in the terminology of [2]. Minimum cardinality agrees with (2). We never substitute the number of individually indispensable constraints for s(S).

For integers 1<=d<=N, write

$$
B_{d,N}(\epsilon)=\sum_{i=0}^{d-1}\binom Ni
\epsilon^i(1-\epsilon)^{N-i},\qquad 0\le\epsilon\le1.
\tag{3}
$$

This is the upper tail of a Beta(d,N-d+1) variable. The question is whether convexity, unique solutions, nonempty interior for every sampled feasible domain, and the global bound s(S)<=d imply

$$
\mathbb P^N\{V(x(S))>\epsilon\}\le B_{d,N}(\epsilon)
\tag{4}
$$

when d is smaller than D. Garatti and Campi [2, Remark 2] give a convex counterexample without interior and leave the interior case open. Their adjacent question about retaining the *ambient-dimensional* bound without interior is different; it has since been addressed in [4]. We do not claim a new result about that question.

Our conclusions are:

1. **Theorem 2.2:** an exact realization of every finite ordered-choice system as a strictly feasible full-dimensional LP, preserving the entire sample-to-decision map up to an injection, all supports, and all violation indicators.
2. **Theorems 3.2 and 4.1:** a family of counterexamples for every d>=2, its exact risk law at every sample size, and an unbounded ratio to (3) for every fixed N>=d.
3. **Theorem 5.1 and Proposition 5.2:** the same decisions under smooth strongly convex costs, and atomless versions with pairwise distinct scenario sets.
4. **Theorem 6.1:** compression one is sufficient in the finite ordered-choice class, so two is the smallest possible failure level in this class.
5. **Theorems 7.2 and 7.4:** a finite-sample lower bound on the worst tail over regular convex programs, failure at every risk target for compression two, and fixed-dimensional low-risk witnesses with arbitrarily large sample size.
6. **Theorems 7.6 and 7.7:** lower and upper rare-risk calibration bounds whose inverse thresholds differ by exactly d, giving the sharp high-confidence second-order coefficient d in the logarithm of the confidence level. The upper bound itself is credited to [8].

The finite ordered-choice framework is classical concrete LP-type optimization [6]. Neither that framework, multiple bases, nor the insufficiency of an observed complexity value alone is presented as new. The contribution is the precise geometric realization together with finite-sample and asymptotically matching uniform risk-calibration consequences for the regular convex class. Novelty statements are limited to the sources and access levels recorded in Section 8 and the accompanying audit.

## 2. An exact full-dimensional realization

### 2.1. Finite ordered choices

The one-choice case K=0 has the trivial realization in R^0: the only decision is the fallback, the cost is zero, every sample has the same optimizer, and all violations and minimum support sizes are zero. The singleton R^0 is open in its own ambient space. In the substantive construction, fix an integer K>=1 and the ordered set H={1,...,K,infinity}, where infinity is last. For each scenario delta choose A_delta subset H with infinity in A_delta. Assume every membership event {delta:j in A_delta} is measurable. For any finite sample, define

$$
A(S)=\bigcap_{\delta\in S}A_\delta,\qquad
h(S)=\min A(S),\qquad A(\varnothing)=H.
\tag{5}
$$

The discrete violation indicator is 1{h(S) notin A_delta}. A fixed ordered fallback is sufficient; no probability law is used in the construction.

Choose 0<tau<1/K and set

$$
X=\{x\in\mathbb R^K:x_j\ge0,\ \sum_{j=1}^Kx_j\le1\},
\qquad
C_\delta=\{x:x_j\le\tau\text{ for every }j\notin A_\delta\}.
\tag{6}
$$

In (6), j always ranges over 1,...,K. The fallback has no coordinate. An empty list of caps means C_delta=R^K. Minimize the fixed linear cost

$$
c(x)=-\sum_{j=1}^K(K+1-j)x_j.
\tag{7}
$$

Define phi:H->X by

$$
\phi(k)_j=
\begin{cases}
\tau,&j<k,\\
1-(k-1)\tau,&j=k,\\
0,&j>k,
\end{cases}
\quad (1\le k\le K),
\qquad \phi(\infty)_j=\tau.
\tag{8}
$$

Every finite phi(k) has exactly one coordinate greater than tau, namely coordinate k. This follows from 1-(k-1)tau>tau, which is equivalent to ktau<1. The map phi is therefore injective, including the fallback value.

### Lemma 2.1. Prefix-sum maximization

Let J subset {1,...,K} denote the coordinates not capped by a sample, and let k be its smallest member, or infinity if J is empty. On X with x_j<=tau for j outside J, the unique minimizer of (7) is phi(k).

**Proof.** Put F_m(x)=sum_{j<=m}x_j. Reversing the order of summation gives

$$
-c(x)=\sum_{m=1}^K F_m(x).
\tag{9}
$$

If k is finite, every coordinate preceding k is capped. Thus F_m(x)<=m tau for m<k and F_m(x)<=1 for m>=k. The feasible point phi(k) attains all these inequalities simultaneously. Consequently

$$
c(x)-c(\phi(k))=\sum_{m=1}^K
\bigl(F_m(\phi(k))-F_m(x)\bigr)\ge0.
\tag{10}
$$

Each summand is nonnegative. Equality forces every prefix sum to agree, and subtracting consecutive prefix sums gives x=phi(k). When J is empty, all F_m(x)<=m tau, and phi(infinity) simultaneously attains these bounds. The same equality argument applies. This also covers the empty sample, for which J={1,...,K} and the solution is phi(1). QED.

### Theorem 2.2. Exact realization and support preservation

The program (6)-(7) has the following properties for every finite ordered-choice system (5), every finite sample, and every scenario probability law.

(a) X is compact and full-dimensional. Every sampled feasible set is nonempty, compact, convex and full-dimensional. All these sets have the common strict interior point x^circ=(tau/2,...,tau/2).

(b) The optimizer exists, is unique, and is exactly x(S)=phi(h(S)).

(c) For every sublist S_I,

$$
x(S_I)=x(S)\quad\Longleftrightarrow\quad h(S_I)=h(S).
\tag{11}
$$

Hence all determining sublists, all irreducible support lists, and their cardinalities are preserved exactly.

(d) For every fresh scenario, including scenarios of probability zero,

$$
\boldsymbol1\{x(S)\notin C_\delta\}
=\boldsymbol1\{h(S)\notin A_\delta\}.
\tag{12}
$$

The solution maps are measurable, and the risk random variables and all their distributions coincide.

**Proof.** Compactness follows because X is a closed bounded simplex and every cap is closed. At x^circ, each positivity condition is strict, the sum is Ktau/2<1, and every imposed upper bound has slack tau/2. For example the Euclidean ball of radius

$$
\eta=\min\left\{\frac\tau4,
\frac{1-K\tau/2}{2\sqrt K}\right\}>0
\tag{13}
$$

around x^circ satisfies all inequalities strictly. This proves (a), including all finite intersections at once.

A coordinate is uncapped after sampling precisely when it belongs to every A_delta. Lemma 2.1 gives (b). Injectivity of phi proves (c); applying (11) also to all smaller sublists proves the irreducibility assertion.

For finite h(S)=k, all coordinates other than k are at most tau, while coordinate k is greater than tau. Therefore a new cap is violated exactly when it caps k, or equivalently k is notin A_delta. The fallback vector satisfies every cap and infinity belongs to every A_delta. This proves (d). There are finitely many membership patterns, and the event h(S)=k is a finite combination of measurable membership events. Thus h(S), x(S), the joint violation indicator and the risk variable are measurable. Integrating the pointwise equality gives every distributional assertion. QED.

Theorem 2.2 imposes no dimension-efficiency claim: its ambient dimension is K, the number of nonfallback decisions. It is a behavior-preserving realization, not a polynomial-time reduction in a compact implicit description of an enormous candidate space. The strict inequality tau<1/K is necessary for this proof; the boundary tau=1/K would destroy the injective large-coordinate encoding.

## 3. Coordinate-grid systems and their complete risk law

Fix integers d>=2 and r>=2. Let the nonfallback choices be the r^d grid points

$$
H_0=[r]^d,
\tag{14}
$$

in lexicographic order, with infinity appended. There are dr equally likely scenario types (ell,a), with ell in [d] and a in [r]. Such a scenario allows exactly the grid points whose ell-th coordinate is a, together with infinity:

$$
A_{\ell,a}=\{u\in[r]^d:u_\ell=a\}\cup\{\infty\}.
\tag{15}
$$

Realize this system by Theorem 2.2 with K=r^d and, for definiteness, tau=1/(2K). Thus d is the proposed compression parameter and D=r^d is the ambient dimension; they are not the same quantity.

### Lemma 3.1. Sample classification and global support bound

A sample is **compatible** if it never gives two different values to the same coordinate group. On a compatible sample, its preferred grid point has the prescribed value in every observed group and value 1 in every unobserved group. On an incompatible sample, its decision is infinity. Every irreducible support list has size at most d, for every finite sample, including repeated scenarios. Moreover some samples have minimum support size exactly d.

**Proof.** An inconsistent pair (ell,a),(ell,b), a!=b, excludes every grid point and already determines the fallback. Thus a support list for an incompatible sample that contains more than two scenarios cannot be irreducible: the pair is a proper determining sublist. In a compatible sample, repeated occurrences of the same scenario are redundant. There is at most one distinct observed value per group, so retaining one occurrence per observed group gives at most d scenarios and leaves the complete allowed intersection unchanged. Any irreducible list therefore has size at most d. Finally the sample (1,2),...,(d,2) has preferred point (2,...,2). Removing the only constraint on any group changes that coordinate to 1. This sample has minimum support d. QED.

Let S(N,j) be the Stirling number of the second kind, counting partitions of [N] into j nonempty unlabeled blocks, and write (d)_j=d!/(d-j)!. Define

$$
a_r=1-\frac1r,\qquad
p_{d,r,N}=\frac{1}{(dr)^N}
\sum_{j=1}^{\min(d,N)}(d)_j S(N,j)r^j
\quad (N\ge1).
\tag{16}
$$

### Theorem 3.2. Exact two-point risk distribution

For every N>=1, the optimizer in the grid LP has risk a_r with probability p_{d,r,N} and risk zero with probability 1-p_{d,r,N}. Thus

$$
\mathbb P^N\{V(x(S))>\epsilon\}=
\begin{cases}
p_{d,r,N},&0\le\epsilon<a_r,\\
0,&a_r\le\epsilon\le1.
\end{cases}
\tag{17}
$$

For the empty sample, the risk is a_r deterministically.

**Proof.** A fixed grid point is accepted by exactly d of the dr types, one per coordinate. Its risk is a_r, independent of the grid point. The fallback is accepted by every type. Lemma 3.1 and Theorem 2.2 reduce the probability in question to the probability of a compatible sample.

For a compatible ordered sequence using exactly j coordinate groups, partition its N positions according to group, in S(N,j) ways. Assign distinct group names to the blocks in (d)_j ways. Each group has one common value, chosen in r^j ways. This counts each compatible sequence exactly once. Divide by (dr)^N and sum over j. For N=0 there are no constraints and the chosen point is (1,...,1). The strict inequality in (17), particularly the zero tail at epsilon=a_r, follows directly from the two-point law. QED.

For d=2 the count reduces to

$$
p_{2,r,N}=\frac{r^2(2^N-2)+2r}{(2r)^N}
=r^{2-N}\left[1-2^{1-N}\left(1-\frac1r\right)\right].
\tag{18}
$$

The term 2r counts sequences consisting of a single repeated type. The other term counts sequences containing a row and a column, and no other distinct type. This explicitly includes the repeated-scenario contribution.

### Corollary 3.3. A rational nine-dimensional counterexample

Take d=2, r=3, K=D=9 and tau=1/18. In row-major grid order j=3(u_1-1)+u_2, use

$$
X=\{x\ge0:\sum_{j=1}^9x_j\le1\},
\qquad c(x)=-9x_1-8x_2-\cdots-x_9.
\tag{19}
$$

Each of the six equiprobable scenarios caps the six coordinates outside its row or column at 1/18. The common strict interior point is x_j=1/36. Every finite sample has a unique optimizer and minimum compression at most two. With N=2 and epsilon=3/5,

$$
\mathbb P^2\{V(x(S))>3/5\}=\frac23
>\frac{16}{25}=B_{2,2}(3/5),
\qquad \frac23-\frac{16}{25}=\frac{2}{75}.
\tag{20}
$$

**Proof.** Eighteen of the 36 ordered pairs are a row and a column. Six consist of a single type repeated. They are compatible and have risk 2/3. The remaining twelve pairs contain distinct rows or distinct columns, and have zero risk. Equation (3) gives B_{2,2}(epsilon)=1-epsilon^2. The structural assertions follow from Theorem 2.2 and Lemma 3.1. QED.

For the sample containing each of the six types once, deleting any one type leaves an incompatible pair elsewhere, so the decision remains the fallback. The set of individually indispensable scenarios is consequently empty, even though the minimum support size is two. There are exactly six minimal support pairs: the three distinct-row pairs and the three distinct-column pairs. This is an explicit failure of support reconstruction from the leave-one-out support set, not a failure of optimizer uniqueness.

## 4. Failure for every compression level and fixed sample size

### Theorem 4.1. An unbounded multiplicative gap

Fix integers d>=2 and N>=d. For the grid family and

$$
\epsilon_r=1-\frac1r-\frac1{r^2},\qquad r\ge2,
\tag{21}
$$

we have

$$
\lim_{r\to\infty}\frac1r
\frac{\mathbb P^N\{V(x(S))>\epsilon_r\}}
{B_{d,N}(\epsilon_r)}
=\frac{d!\,S(N,d)}{d^N\binom N{d-1}}>0.
\tag{22}
$$

In particular, for every prescribed factor L>0 there is a finite strictly feasible convex scenario program with global minimum compression at most d, and a threshold in (0,1), whose risk tail is more than L times (3).

**Proof.** Since 0<epsilon_r<a_r, Theorem 3.2 identifies the numerator as p_{d,r,N}. The term j=d is the leading term in (16), and S(N,d)>0. Hence

$$
p_{d,r,N}=\frac{d!S(N,d)}{d^N}\,r^{d-N}
\bigl(1+O(r^{-1})\bigr).
\tag{23}
$$

Put q_r=1-epsilon_r=(1+r^{-1})/r. In (3), the term i=d-1 has the smallest power of q_r, and all other terms have at least one additional power. Thus

$$
B_{d,N}(\epsilon_r)=\binom N{d-1}
r^{-(N-d+1)}\bigl(1+O(r^{-1})\bigr).
\tag{24}
$$

Dividing (23) by (24) proves (22). The positive limit gives the final assertion by the definition of a limit. All constructed programs are finite, with D=r^d and D>d. QED.

The quantifiers in Theorem 4.1 matter. Here d and N are fixed while r, the number of scenario types, and the ambient dimension increase. It is not a claim of an unbounded ratio within one fixed-dimensional model as N tends to infinity. The smallest example has N=2<D=9. The proposed replacement (4) is quantified for N>=d, exactly as in the source question; Theorem 4.1 by itself does not assert a failure of the classical ambient-dimensional beta bound or provide a fixed-D large-N counterexample. Section 7 supplies a fixed-dimensional large-sample construction under laws that vary with N.

## 5. Strong convexity and atomless scenarios

### Theorem 5.1. Smooth strongly convex costs preserve the realization

In Theorem 2.2 replace (7) by

$$
c_\lambda(x)=-\sum_{j=1}^K(K+1-j)x_j
+\frac\lambda2\sum_{j=1}^Kx_j^2,
\qquad 0<\lambda<1.
\tag{25}
$$

The unique optimizer remains phi(h(S)) for every finite sample. All support and risk preservation conclusions remain valid. In particular, all counterexamples above have versions with a smooth strongly convex objective.

**Proof.** On X, every partial derivative is negative because

$$
\partial_jc_\lambda(x)=-(K+1-j)+\lambda x_j\le-1+\lambda<0.
\tag{26}
$$

For j<ell,

$$
\partial_jc_\lambda(x)-\partial_\ell c_\lambda(x)
=-(\ell-j)+\lambda(x_j-x_\ell)<0.
\tag{27}
$$

Consider any minimizer, which exists by compactness. If a higher-priority coordinate j is below its individual upper bound (tau if capped, 1 otherwise) while a lower-priority coordinate ell>j is positive, a sufficiently small transfer from ell to j preserves feasibility. Equation (27), along the transfer segment, makes the objective strictly decrease, a contradiction. If total mass is less than one and some coordinate is below its upper bound, increasing it slightly strictly decreases the objective by (26).

When the first uncapped coordinate is k, these two facts force all coordinates before k to equal tau: otherwise either a later positive coordinate could transfer mass, or total mass could be increased. Total mass must be one because coordinate k has upper bound one and all preceding caps sum to less than one. No coordinate after k can be positive, since coordinate k is then below one and a transfer would improve the cost. This gives (8). If every coordinate is capped, their total cap is Ktau<1, so the second fact forces every coordinate to equal tau. The same reasoning covers k=1 and the empty sample. The Hessian is lambda times the identity, so the objective is smooth and strongly convex. QED.

Strong convexity is a property of the cost, not uniqueness of a determining sublist. No assertion is made that an arbitrary ridge penalty, arbitrary linear perturbation, or arbitrary constraint smoothing preserves the construction.

### Proposition 5.2. Atomless laws and distinct scenario sets

Every grid counterexample has a version in dimension D+1 with an atomless scenario law and distinct feasible scenario sets, while retaining exactly the same support lists and risk distribution.

**Proof.** Attach to each grid type ell,a an independent t uniform on (0,1). Use the deterministic domain X times [0,1], write its extra coordinate z, and impose

$$
\widetilde C_{\ell,a,t}
=\{(x,z):x\in C_{\ell,a},\ z\le(1+t)/2\}.
\tag{28}
$$

Use the cost c(x)+z, or c_lambda(x)+z+lambda z^2/2. Every optimizer has z=0, because that value is feasible and minimizes the extra term. The optimizer is therefore (phi(h(S)),0). Every new z inequality accepts it, so all supports and violations are unchanged. The common point (x^circ,1/4) is strictly interior for every sampled domain. The product probability measure assigns zero mass to every individual scenario.

For a fixed type, different t values give different upper bounds for z. For different types, choose a grid point allowed by one and not the other; its unit coordinate vector at z=0 distinguishes their feasible sets. Thus scenario feasible sets are pairwise distinct, even after intersection with the deterministic domain. QED.

The extra marked coordinate is deliberately inactive at the optimizer. This removes reliance on atoms or repeated identical feasible sets, but not on the multiple-support phenomenon responsible for failure.

## 6. Compression one has the beta tail

### Theorem 6.1. The sharp one-versus-two boundary in finite ordered choice

Consider a finite ordered-choice system (5). Suppose, pointwise for every finite sample, that its minimum determining-sublist size is at most one. Then, for every probability law, every N>=1 and epsilon in [0,1],

$$
\mathbb P^N\{V(h(S))>\epsilon\}\le(1-\epsilon)^N.
\tag{29}
$$

The bound is best possible as a supremum over finite ordered-choice systems. Combined with Corollary 3.3, the first possible failure of the complexity-parameter beta guarantee in this class is complexity two.

**Proof.** Put Y_delta=h((delta)). Restriction of a feasible set can only increase its least element, so h(S)>=Y_delta for every sampled delta. The compression assumption says h(S) is either h(empty)=1 or one of the singleton choices. Therefore

$$
h(S)=\max\{1,Y_{\delta_1},...,Y_{\delta_m}\}.
\tag{30}
$$

A new scenario rejects the current choice exactly when the choice strictly increases after adding it. By (30), this happens exactly when Y_delta>h(S). Consequently V(h(S))=1-F(h(S)), where F is the finite ordered distribution function of Y_delta.

For N>=1, let M_N be the maximum of the N singleton choices. If no value y satisfies F(y)<1-epsilon, the event in (29) is empty. Otherwise let y_* be the greatest value satisfying that strict inequality. Then

$$
\mathbb P^N\{1-F(M_N)>\epsilon\}
=F(y_*)^N\le(1-\epsilon)^N.
\tag{31}
$$

This includes epsilon=0 and epsilon=1, with the empty-event convention when appropriate. For sharpness, let the scenarios be uniform on {1,...,m} and let A_delta={delta,delta+1,...,m,infinity}. The chosen decision is the sample maximum, determined by one sampled scenario. For every fixed 0<epsilon<1, the probability in (31) tends to (1-epsilon)^N as m tends to infinity. At epsilon=0 it tends to one; at epsilon=1 both sides are zero. These finite systems have the LP realizations of Theorem 2.2. QED.

The hypothesis in this section is pointwise global compression one in the finite ordered-choice class. We do not infer it from a single observed support size, and do not assert an unproved classification of all infinite-dimensional decision rules.

## 7. Low-risk calibration and the price of degeneracy

The preceding construction also gives a finite-sample lower bound for an entire class of risk guarantees. This section distinguishes three quantifiers: a model may be chosen for a specified risk target; a fixed geometric model may be used with laws that vary with the sample size; and a uniform guarantee must cover every such model and law. No result below asserts a persistent large-sample failure under one fixed finite model and one fixed law.

Let $\mathcal C_d$ consist of finite-dimensional convex scenario programs with a compact deterministic domain, closed convex scenario sets, a fixed convex objective, a common point $x^\circ\in\operatorname{int}(X)\cap\bigcap_\delta\operatorname{int}(C_\delta)$, and a unique optimizer for every finite sample, including the empty sample. Assume the decision maps are measurable and the set $\{(x,\delta):x\notin C_\delta\}$ is jointly measurable, and that every finite sample has a determining sublist of size at most $d$. The dimension and the scenario law may vary across members of this class. Define

$$
\mathcal R_d(N,\epsilon)=
\sup_{(\Pi,\mathbb P)\in\mathcal C_d}
\mathbb P^N\{V_{\mathbb P}(x(S))>\epsilon\},
\qquad N\ge d,\quad 0<\epsilon<1.
\tag{32}
$$

The supremum is a numerical worst-case risk tail; it need not be attained by a finite instance. The same lower bounds below hold if the class is restricted to smooth strongly convex objectives and atomless laws with pairwise different scenario sets, using Section 5. The upper bounds hold for the larger class in (32).

### Proposition 7.1. Exact null-scenario dilution

Add to the coordinate-grid model a null scenario whose allowed set is all of $H$. Give it probability $1-q$, and give each of the $dr$ original types probability $q/(dr)$, where $0\le q\le1$. The geometry and the global support bound $d$ are unchanged. Each grid decision has risk $q(1-1/r)$, and the fallback has risk zero. The probability of a grid decision is

$$
Q_{d,r,N}(q)=
\sum_{j=0}^{d}\binom dj r^j(1-r)^{d-j}
\left(1-q+\frac{jq}{dr}\right)^N,
\qquad N\ge0.
\tag{33}
$$

As usual, a zeroth power is one. In particular, for every threshold $0\le\epsilon<q(1-1/r)$, the risk tail equals (33). A threshold at or above that risk has zero strict tail.

**Proof.** A null scenario imposes no cap and cannot affect the optimizer or any determining sublist. Remove all null entries and apply Lemma 3.1. For one coordinate group, the indicator of compatibility is the sum, over its $r$ labels, of the indicator that every entry from this group has that label, minus $(r-1)$ times the indicator that the group is absent. This identity gives one for an absent or single-label group and zero for a conflicting group. Multiply the identities for the $d$ groups. A term selecting $j$ groups and one label for each permits only the null scenario and those $j$ labels; its one-draw probability is $1-q+jq/(dr)$. There are $\binom djr^j$ such terms, with coefficient $(1-r)^{d-j}$. Independence proves (33). The null scenario never rejects any decision, so all original risks are multiplied by $q$. This argument includes the empty sample. QED.

Equivalently, with $p_{d,r,0}=1$ and $p_{d,r,m}$ as in (16) for positive $m$,

$$
Q_{d,r,N}(q)=
\sum_{m=0}^{N}\binom Nm q^m(1-q)^{N-m}p_{d,r,m}.
\tag{34}
$$

This is conditioning on the number of non-null observations, and is often preferable for numerical evaluation because all its terms are nonnegative.

### Theorem 7.2. A finite-sample lower bound

For every $d\ge2$, $N\ge d$ and $0<\epsilon<1$,

$$
\mathcal R_d(N,\epsilon)\ \ge\
L_{d,N}(\epsilon):=
\sum_{j=0}^{d}\binom Nj(d)_j
\left(\frac{\epsilon}{d}\right)^j(1-\epsilon)^{N-j}.
\tag{35}
$$

**Proof.** For all sufficiently large integers $r$, choose

$$
q_r=\frac{\epsilon}{1-1/r}+\frac1{r^2}<1.
\tag{36}
$$

The positive risk is then strictly greater than $\epsilon$, while $q_r\to\epsilon$. For a fixed positive number $m$ of non-null observations, (16) gives

$$
\lim_{r\to\infty}p_{d,r,m}=
\begin{cases}(d)_m/d^m,&m\le d,\\0,&m>d.\end{cases}
\tag{37}
$$

Indeed, only the summand with $j=m$ can survive the power $r^{j-m}$, and $S(m,m)=1$; that summand exists exactly when $m\le d$. For $m=0$ the limit is one. Apply this limit to the finite sum (34) and use $q_r\to\epsilon$. The resulting expression is (35). Every member of the approximating sequence is a finite strictly feasible LP in the class, so the supremum is at least its limiting tail. Applying Theorem 5.1 and Proposition 5.2 before taking the limit proves the statement for the stated regular subclasses as well. QED.

### Corollary 7.3. Failure at every nontrivial risk target when d=2

For every $N\ge2$ and every $0<\epsilon<1$, a finite strictly feasible convex scenario program with global minimum support at most two violates (4). In fact,

$$
L_{2,N}(\epsilon)=B_{2,N}(\epsilon)
+\frac12\binom N2\epsilon^2(1-\epsilon)^{N-2}
>B_{2,N}(\epsilon).
\tag{38}
$$

**Proof.** Expand the three terms of (35). The first two are precisely $B_{2,N}$, and the third is positive. Although (35) is a supremum statement, its proof gives finite models whose tails converge to the strictly larger value in (38); a sufficiently large finite member therefore already violates (4). QED.

This corollary does not claim a dimension bound independent of $N$ and $\epsilon$. A complementary fixed-dimensional statement follows next.

### Theorem 7.4. A fixed nine-dimensional low-risk family

Use the same nine-dimensional geometry as Corollary 3.3 and add its null scenario. There are seven fixed scenario sets.

(a) For every fixed $N\ge2$, arbitrarily small positive $q$ give a strict violation at $\epsilon=3q/5$.

(b) For every integer $N\ge250$, set $q=3/N$ and $\epsilon_N=2/N-1/N^2$. Then the nonzero risk is $2/N>\epsilon_N$, and the tail is

$$
Q_N=9\left(1-\frac2N\right)^N
-12\left(1-\frac5{2N}\right)^N
+4\left(1-\frac3N\right)^N.
\tag{39}
$$

For all these $N$, $Q_N>B_{2,N}(\epsilon_N)$. Moreover,

$$
\lim_{N\to\infty}\left[Q_N-B_{2,N}(\epsilon_N)\right]
=6e^{-2}-12e^{-5/2}+4e^{-3}
\approx0.0261399894>0.
\tag{40}
$$

**Proof.** The first conflict among two active observations has probability $1/3$ in the six-type model. Equivalently, expand the polynomial (33) at zero. For each fixed $N$ this gives

$$
Q_{2,3,N}(q)-B_{2,N}(3q/5)
=\frac{2}{75}\binom N2q^2+O_N(q^3).
\tag{41}
$$

The coefficient is positive and $3q/5<2q/3$, proving (a). For (b), substitute $q=3/N$ in (33). For $0<a<N$, integration of the geometric series, or its positive remainder bound, gives

$$
-a-\frac{a^2}{2(N-a)}
\le N\log(1-a/N)\le-a.
\tag{42}
$$

Using $e^{-t}\ge1-t$ on the lower bound, and using the upper bound for the negative term in (39), bounds $Q_N$ from below. Also $1-\epsilon_N=(1-1/N)^2$, so

$$
B_{2,N}(\epsilon_N)
\le e^{-2}\frac{3N^2-3N+1}{(N-1)^2}
\le e^{-2}\left(3+\frac6{N-2}\right).
\tag{43}
$$

Combining these estimates yields

$$
Q_N-B_{2,N}(\epsilon_N)
\ge e^{-3}\left[
6e-12\sqrt e+4-\frac{24e}{N-2}-\frac{18}{N-3}
\right].
\tag{44}
$$

The exponential series gives $27/10<e<1631/600<11/4$ and hence $\sqrt e<33/20$. For example, the sum through degree four is $65/24$, and the remaining terms are strictly less than $1/100$. For $N\ge250$, the bracket in (44) is strictly larger than

$$
\frac25-\frac{66}{248}-\frac{18}{247}
=\frac{9341}{153140}>0.
\tag{45}
$$

Finally, take the elementary exponential limits in (39) and (43)'s exact Beta expression to obtain (40). Its positivity follows also from $6e-12\sqrt e+4>2/5$. QED.

Thus large sample sizes relative to the ambient dimension do not rescue the proposed uniform calibration. In (b), the geometric program and its seven constraint sets are fixed, but their law depends on $N$. Strong convexity leaves this example in dimension nine; imposing atomless laws with different sets uses the additional coordinate of Proposition 5.2 and dimension ten. We have not claimed a fixed-law asymptotic counterexample or the smallest valid value of $N$.

### Lemma 7.5. The existing compression upper bound

For the class (32),

$$
\mathcal R_d(N,\epsilon)\le
U_{d,N}(\epsilon):=
\binom Nd\min_{m=d,\ldots,N}
\binom md^{-1}(1-\epsilon)^{N-m}.
\tag{46}
$$

This is the bound of Berger [8, Theorem 2], not a new upper bound. We include a direct argument in the present optimization class to make the assumption match explicit.

**Proof.** Fix $d\le m\le N$, an iid sample $S$ of size $N$, and an independent uniformly chosen $m$-element index subset $I$. Every $S$ has a determining subset of at most $d$ indices. Enlarge one such subset to exactly $d$ indices, which is possible because $N\ge d$. Every intermediate sublist containing it has the same optimizer: the full-sample optimizer is feasible there and already minimizes the objective over the less constrained determining sublist; uniqueness identifies the solutions. Conditional on $S$, the probability that $I$ contains the chosen $d$ indices is $\binom md/\binom Nd$. It follows that

$$
\frac{\binom md}{\binom Nd}
\mathbb P^N\{V(x(S))>\epsilon\}
\le\mathbb P\{V(x(S_I))>\epsilon,\ x(S_I)=x(S)\}
\le(1-\epsilon)^{N-m}.
\tag{47}
$$

For the last inequality, permutation invariance and iid sampling let $I$ be the first $m$ positions. Equality of the two optimizers implies that all remaining constraints accept $x(S_I)$. Conditional on the first $m$ observations, this has probability $(1-V(x(S_I)))^{N-m}$, which is at most $(1-\epsilon)^{N-m}$ on the event being bounded. Measurability of selecting a determining subset causes no difficulty: select the first qualifying subset in a fixed finite ordering. Minimize over $m$ and take the supremum over programs and laws. QED.

### Theorem 7.6. Rare-risk bounds for the regular convex class

For fixed $d\ge2$ and $c>0$, put

$$
f_d(c)=e^{-c}\left(1+\frac cd\right)^d,
\qquad
u_d(c)=
\begin{cases}1,&0\le c\le d,\\
e^{d-c}(c/d)^d,&c>d.
\end{cases}
\tag{48}
$$

Then

$$
f_d(c)\le
\liminf_{N\to\infty}\mathcal R_d(N,c/N)
\le\limsup_{N\to\infty}\mathcal R_d(N,c/N)
\le u_d(c).
\tag{49}
$$

The same sandwich holds for the subclass with smooth strongly convex objectives, atomless laws and different scenario sets. For each $c$ and any accuracy $\eta>0$, the lower bound can be approached within $\eta$ by fixing one finite geometric model for all sufficiently large $N$, while varying its scenario law.

**Proof.** In (35), each fixed-$j$ summand at $\epsilon=c/N$ converges to $e^{-c}\binom dj(c/d)^j$. Summing gives $f_d(c)$. For $c>d$, choose integers $m_N$ with $m_N/N\to d/c$ in (46). The binomial-coefficient ratio tends to $(c/d)^d$, and the other factor tends to $e^{d-c}$. For $c\le d$, choose $m=N$ and use the upper bound one. This proves (49).

For the assertion with a fixed geometric model, choose an integer $r\ge2$, retain its grid and null scenario, and for large $N$ take

$$
q_N=\frac{c+1/N}{(1-1/r)N}.
\tag{50}
$$

The nonzero risk is exactly $c/N+1/N^2$, strictly above the threshold. Formula (33) gives the limiting tail

$$
e^{-c}\left[r-(r-1)
e^{-c/[d(r-1)]}\right]^d.
\tag{51}
$$

As $r\to\infty$ this converges to $f_d(c)$. First choose a finite $r$ to meet the desired accuracy, then take sufficiently large $N$ for that fixed model; no interchange of uniform limits is used. Sections 5.1 and 5.2 preserve each distributional statement in the more regular subclass. QED.

The classical Beta calibration has the rare-risk limit $g_d(c)=e^{-c}\sum_{j=0}^{d-1}c^j/j!$. Consequently $f_d(c)/g_d(c)\sim c(d-1)!/d^d$ as $c\to\infty$. Equations (50)--(51) therefore also give arbitrarily large multiplicative separations at arbitrarily small risk targets, with $N$ larger than the fixed dimension of the chosen instance. Dimension may depend on the requested separation factor, and the law varies with $N$.

### Theorem 7.7. Minimax sample calibration within an additive d

For fixed $d\ge2$ and $0<\beta<1$, define the least sample size giving a uniform guarantee over (32):

$$
n_d(\epsilon,\beta)=
\min\{N\ge d:\mathcal R_d(N,\epsilon)\le\beta\}.
\tag{52}
$$

Let $c_d(\beta)$ be the unique positive solution of $f_d(c)=\beta$. Then

$$
c_d(\beta)
\le\liminf_{\epsilon\downarrow0}\epsilon n_d(\epsilon,\beta)
\le\limsup_{\epsilon\downarrow0}\epsilon n_d(\epsilon,\beta)
\le c_d(\beta)+d.
\tag{53}
$$

In particular, writing $b=\log(1/\beta)$, the high-confidence expansion after the low-risk limit has the sharp second-order coefficient $d$:

$$
c_d(\beta)=b+d\log b-d\log d+o(1),
\qquad \beta\downarrow0.
\tag{54}
$$

In contrast, the root $a_d(\beta)$ of $g_d(c)=\beta$ satisfies

$$
a_d(\beta)=b+(d-1)\log b-\log((d-1)!)+o(1).
\tag{55}
$$

Thus replacing the valid uniform calibration by the Beta-$d$ calibration omits a necessary $\log\log(1/\beta)+O_d(1)$ term in the low-risk normalized sample count. The upper bound in (53) is inherited from the known upper bound (46); the new contribution is the matching lower order within the strictly feasible convex class.

**Proof.** The set in (52) is nonempty: using $m=d$ in (46) bounds the tail by $\binom Nd(1-\epsilon)^{N-d}$, which tends to zero. Also $n_d(\epsilon,\beta)\to\infty$ as $\epsilon\downarrow0$, since the $j=0$ term of (35) tends to one uniformly over any bounded collection of sample sizes. The function $f_d$ decreases strictly from one to zero, because its logarithmic derivative for $c>0$ is $-c/(d+c)$.

Suppose along a sequence approaching zero that $\epsilon n_d(\epsilon,\beta)$ tends to a finite value $c<c_d(\beta)$. Since the sample sizes tend to infinity, the finite sum (35) along that sequence tends to $f_d(c)>\beta$, contradicting (52). The same argument at $c=0$ uses $f_d(0)=1$. Subsequence selection proves the lower bound on the liminf, without assuming monotonicity of $\mathcal R_d$ in $N$.

For the upper bound, observe the exact identity

$$
u_d(c+d)=f_d(c),\qquad c\ge0.
\tag{56}
$$

Choose any $c>c_d(\beta)+d$ and set $N=\lceil c/\epsilon\rceil$. Select $m/N\to d/c$ in (46). The resulting upper bound tends to $u_d(c)<\beta$, so for all sufficiently small $\epsilon$ this sample size is admissible in (52). Hence the limsup is at most $c$, and then at most $c_d(\beta)+d$ by letting $c$ decrease. This also shows that the lower and upper inverse calibration bounds differ by exactly $d$, although the true minimax value within that interval is not identified.

Finally, the defining equation for $c_d$ is $c-d\log(1+c/d)=b$. It first implies $c/b\to1$ and then, upon substitution, (54). Similarly, $\sum_{j=0}^{d-1}c^j/j!=c^{d-1}/(d-1)![1+O_d(1/c)]$ gives (55). Subtracting yields the stated missing term. These are ordered limits: first $\epsilon\downarrow0$ at fixed $\beta$, then $\beta\downarrow0$. No arbitrary joint-rate asymptotic or exact minimax tail formula is asserted. QED.

The proof also applies verbatim to the smooth, atomless subclass because both its lower constructions and the general upper bound are available. These conclusions concern uniform, one-stage scenario optimization guarantees based only on a global minimum-support parameter. They do not invalidate methods that retain ambient dimension, impose an effective nondegeneracy condition, or obtain an independent additional validation sample, such as FAST [9].


## 8. Literature position, evidence, and limitations

### 8.1. The precise open question

Campi and Garatti [1] prove the classical bound using the decision-space dimension. Garatti and Campi [2, Definition 1 and Corollary 8] distinguish the minimum support-list complexity from ambient dimension, and their Remark 2 explicitly asks whether the smaller-complexity beta bound can fail while nonempty interior is retained. Corollary 3.3 establishes such failure under compact polyhedral domains and unique solutions. The pointwise global support bound is stronger than a statement at the tested sample size alone.

The 2026 paper of Zhang and Yang [4] concerns the ambient-dimensional bound without interior. We checked its publisher abstract, metadata and publicly posted computational supplement, not its subscription full text. The supplement concerns interval-endpoint risk calculations and does not contain our grid construction. We make no blanket claim about everything discussed in the inaccessible body. Our proofs do not depend on it.

### 8.2. Classical representation and degeneracy

Concrete LP-type problems and basis equivalence are established in [6, Definition 3 and Theorem 8]. Our source model is an instance of that framework. Matousek and Skovron [7] show that removing degeneracy may require large dimension increases, and give a three-dimensional realization of a four-element degenerate example. Their displayed realization has a singleton full-sample feasible set. These are important antecedents; our contribution is not the existence of alternative bases.

Theorem 2.2 supplies an explicit common-interior Euclidean realization preserving all sample outputs and every acceptance event. It is useful even where dimension efficiency is irrelevant. For the grid family, both the global minimum support bound and the largest irreducible-list size equal d, as shown in Lemma 3.1. More generally, a pointwise minimum-support bound over all finite samples also bounds every irreducible list: apply that bound to the list itself as a sample. This global statement must not be confused with the size of the leave-one-out support set of one observed sample, which can be zero in our example.

### 8.3. Boundary stability is an additional hypothesis

Calafiore [5, Corollary 4.6 and Proposition 5.2] obtains beta laws under proper projective-boundary and support-reconstruction conditions. Section 10 of that paper distinguishes those conditions from nominal observed boundary sizes. Our sample containing all six row-column types has empty leave-one-out support but minimum support two, as shown after Corollary 3.3. It does not satisfy the reconstruction premise. Thus neither theorem contradicts the other.

Berger [8, Theorem 1(2)] summarizes beta guarantees while citing [1]. The dimension parameter in the cited [1] is the ambient decision dimension. That summary cannot extend the cited ambient theorem to an arbitrary smaller global minimum support bound: Corollary 3.3 is a counterexample to such a reading of its convex-interior branch. This observation does not challenge [8]'s separate new compression-based PAC bounds. The explicit open-question formulation in [2] explains why the dimension distinction is necessary.

### 8.4. Existing upper bounds and recent tightness results

Berger [8, Theorem 2] supplies the compression upper bound used in Lemma 7.5. We neither claim that bound as new nor infer a currently open optimality problem solely from the outlook of that 2025 paper. Paccagnan and Tirlea [10] subsequently prove tightness of preferent-compression certificates whose threshold depends on the observed, random compression size. Their Theorem 4 and Construction 5 use compression outputs capped at the tested sample size N; the construction does not impose a fixed global cap d as N grows. That posterior tightness theorem therefore does not directly give the fixed-d prior lower bound (35), nor its realization inside the common-interior convex class. The distinction concerns hypotheses and quantifiers, not the validity of their tightness result.

The FAST method of Care, Garatti and Campi [9] provides a technically relevant comparison in stochastic optimization: it combines an initial scenario program with additional sampling and adjustment to obtain a rigorously calibrated certificate and an associated sample-complexity analysis. Our results concern the limits of a one-stage guarantee based only on global minimum-support size. They do not exclude improvements from additional validation data or the different algorithm in [9]. The substantive implication is that strict feasibility, uniqueness and even strong convexity do not remove the d log log(1/beta) term required by uniform high-confidence calibration. We do not claim a new general upper bound, an exact minimax risk function, or a limit with a prescribed joint rate for risk and confidence.

### 8.5. What is and is not delivered

The main proofs are self-contained finite-dimensional arguments. The independent certificate enumerates all 64 scenario-type subsets in the nine-dimensional example, supplies exact rational primal-dual LP certificates and full-rank active equalities, and checks them against a separate numerical LP solver. Because repeated labels do not change a feasible set, these 64 subsets cover the optimizer/support possibilities of that one fixed model for arbitrary finite sample lists. Exact sequence counts and state recursions additionally check the risk formula. A separate secondary certificate compares the diluted-law formula with binomial mixing and an integer-state recursion, and supplies an exact rational witness at N=250. These checks supplement, and do not replace, the general proofs.

The result is a limitation on an exact risk calibration, not a universal impossibility of learning from compression. Distribution-free compression bounds, wait-and-judge bounds and properly conditioned projective-boundary guarantees remain valid under their respective hypotheses. We do not claim the best possible dimension for a counterexample, robust violation under arbitrary perturbations of constraints, or a fixed-law large-sample separation in one finite decision model. All search conclusions are limited to the examined primary literature. No external peer review or worldwide priority certification is claimed.

The manuscript's full mathematical content is to be covered by separate version-bound formalization task cards. No Lean source, Lean compilation, or kernel-verified theorem is supplied in this research session; full formalization remains required and has not been waived.

## References

[1] M. C. Campi and S. Garatti. The exact feasibility of randomized solutions of uncertain convex programs. *SIAM Journal on Optimization* 19(3), 1211-1230 (2008). DOI: [10.1137/07069821X](https://doi.org/10.1137/07069821X). Author full text: [PDF](https://marco-campi.unibs.it/pdf-pszip/Campi-Garatti-exact.pdf).

[2] S. Garatti and M. C. Campi. Non-convex scenario optimization. *Mathematical Programming* 209, 557-608 (2025; online 2024). DOI: [10.1007/s10107-024-02074-3](https://doi.org/10.1007/s10107-024-02074-3). [Publisher full text](https://link.springer.com/article/10.1007/s10107-024-02074-3).

[3] S. Garatti and M. C. Campi. Risk and complexity in scenario optimization. *Mathematical Programming* 191, 243-279 (2022). DOI: [10.1007/s10107-019-01446-4](https://doi.org/10.1007/s10107-019-01446-4). Background comparison only.

[4] Y. Zhang and Y. Yang. Interior-free beta tails for convex scenario programs. *Journal of Applied Mathematics and Computing* 72, article 259 (2026). DOI: [10.1007/s12190-026-02915-8](https://doi.org/10.1007/s12190-026-02915-8). Publisher abstract, metadata and public computational supplement verified; subscription full text unavailable in this audit.

[5] G. C. Calafiore. Exact Risk-Complexity Laws for Projective Boundaries in Scenario Optimization and Distribution-Free Certification. [arXiv:2609.01355v1](https://arxiv.org/abs/2609.01355), 2026. Author manuscript, especially Corollary 4.6, Proposition 5.2 and Section 10.

[6] B. Gartner, J. Matousek, L. Rust and P. Skovron. Violator spaces: Structure and algorithms. *Discrete Applied Mathematics* 156(11), 2124-2141 (2008). DOI: [10.1016/j.dam.2007.08.048](https://doi.org/10.1016/j.dam.2007.08.048). Author manuscript: [arXiv:cs/0606087v3](https://arxiv.org/abs/cs/0606087).

[7] J. Matousek and P. Skovron. Removing degeneracy may require a large dimension increase. *Theory of Computing* 3, 159-177 (2007). DOI: [10.4086/toc.2007.v003a008](https://doi.org/10.4086/toc.2007.v003a008). [Open full text](https://theoryofcomputing.org/articles/v003a008/v003a008.pdf), particularly Section 6.

[8] G. O. Berger. Improved Compression-Based PAC Bounds for General Scenario Decision Making. [arXiv:2501.08884v2](https://arxiv.org/abs/2501.08884), 2025. [Author full text](https://arxiv.org/html/2501.08884v2). The cited ambient-dimensional theorem and the smaller compression parameter must be distinguished.

[9] A. Care, S. Garatti and M. C. Campi. FAST—Fast Algorithm for the Scenario Technique. *Operations Research* 62(3), 662–671 (2014). DOI: [10.1287/opre.2014.1257](https://doi.org/10.1287/opre.2014.1257). [Author-hosted published PDF](https://marco-campi.unibs.it/pdf-pszip/OR-FAST.pdf), particularly Sections 2–4 and Theorems 1–4.

[10] D. Paccagnan and M. Tirlea. Preferent Compression Bounds Are Tight. [arXiv:2609.36030v1](https://arxiv.org/abs/2609.36030), 2026. Original manuscript, especially Theorem 4 and Construction 5; posterior thresholds and the N-dependent compression cap must be distinguished from a fixed global d.
