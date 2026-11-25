# Exact finite-decision realizations in strictly feasible convex scenario optimization

## Compression-preserving linear programs and failure of dimension-reduced beta tails

Research manuscript, 25 November 2026. Written proofs and computational certificates are provided. Lean verification is a separate, unfinished deliverable. This manuscript has not undergone external peer review.

## Abstract

Does a uniform bound on the size of a smallest support subsample replace ambient dimension in the classical beta risk bound for convex scenario optimization when every feasible domain has nonempty interior? We give a negative answer to the second open question in Remark 2 of Garatti and Campi, *Mathematical Programming* 209 (2025). The main tool is an explicit realization theorem. Every finite ordered feasible-choice problem with a universally feasible fallback has a compact, full-dimensional linear-programming realization with a common strict interior point and a unique optimizer for every sample, including the empty sample. The realization preserves every support sublist and every fresh-scenario violation, pointwise. A coordinate-grid family then has global minimum compression at most d, and indeed every irreducible support list has size at most d, for each d at least two. We calculate its complete risk law. In nine dimensions, with d=N=2, the violation risk exceeds 3/5 with probability 2/3, whereas the proposed beta tail is 16/25. For every fixed d at least two and N at least d, the ratio to the proposed beta tail can be arbitrarily large as the finite model grows. The examples also admit smooth strongly convex objectives and atomless scenario laws with distinct feasible sets. Conversely, within the finite ordered-choice class, global compression one implies the beta-one tail bound. The obstruction is alternative determining sublists, and survives strict feasibility and unique optimization.

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

The finite ordered-choice framework is classical concrete LP-type optimization [6]. Neither that framework, multiple bases, nor the insufficiency of an observed complexity value alone is presented as new. The contribution is the precise geometric realization and its unconditional, globally bounded-compression risk consequences. Novelty statements are limited to the sources and access levels recorded in Section 7 and the accompanying audit.

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

The quantifiers in Theorem 4.1 matter. Here d and N are fixed while r, the number of scenario types, and the ambient dimension increase. It is not a claim of an unbounded ratio within one fixed-dimensional model as N tends to infinity. The smallest example has N=2<D=9. The proposed replacement (4) is quantified for N>=d, exactly as in the source question; our theorem does not assert a failure of the classical ambient-dimensional beta bound or give a fixed-D large-N counterexample.

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

## 7. Literature position, evidence, and limitations

### 7.1. The precise open question

Campi and Garatti [1] prove the classical bound using the decision-space dimension. Garatti and Campi [2, Definition 1 and Corollary 8] distinguish the minimum support-list complexity from ambient dimension, and their Remark 2 explicitly asks whether the smaller-complexity beta bound can fail while nonempty interior is retained. Corollary 3.3 establishes such failure under compact polyhedral domains and unique solutions. The pointwise global support bound is stronger than a statement at the tested sample size alone.

The 2026 paper of Zhang and Yang [4] concerns the ambient-dimensional bound without interior. We checked its publisher abstract, metadata and publicly posted computational supplement, not its subscription full text. The supplement concerns interval-endpoint risk calculations and does not contain our grid construction. We make no blanket claim about everything discussed in the inaccessible body. Our proofs do not depend on it.

### 7.2. Classical representation and degeneracy

Concrete LP-type problems and basis equivalence are established in [6, Definition 3 and Theorem 8]. Our source model is an instance of that framework. Matousek and Skovron [7] show that removing degeneracy may require large dimension increases, and give a three-dimensional realization of a four-element degenerate example. Their displayed realization has a singleton full-sample feasible set. These are important antecedents; our contribution is not the existence of alternative bases.

Theorem 2.2 supplies an explicit common-interior Euclidean realization preserving all sample outputs and every acceptance event. It is useful even where dimension efficiency is irrelevant. For the grid family, both the global minimum support bound and the largest irreducible-list size equal d, as shown in Lemma 3.1. More generally, a pointwise minimum-support bound over all finite samples also bounds every irreducible list: apply that bound to the list itself as a sample. This global statement must not be confused with the size of the leave-one-out support set of one observed sample, which can be zero in our example.

### 7.3. Boundary stability is an additional hypothesis

Calafiore [5, Corollary 4.6 and Proposition 5.2] obtains beta laws under proper projective-boundary and support-reconstruction conditions. Section 10 of that paper distinguishes those conditions from nominal observed boundary sizes. Our sample containing all six row-column types has empty leave-one-out support but minimum support two, as shown after Corollary 3.3. It does not satisfy the reconstruction premise. Thus neither theorem contradicts the other.

Berger [8, Theorem 1(2)] summarizes beta guarantees while citing [1]. The dimension parameter in the cited [1] is the ambient decision dimension. That summary cannot extend the cited ambient theorem to an arbitrary smaller global minimum support bound: Corollary 3.3 is a counterexample to such a reading of its convex-interior branch. This observation does not challenge [8]'s separate new compression-based PAC bounds. The explicit open-question formulation in [2] explains why the dimension distinction is necessary.

### 7.4. What is and is not delivered

The main proofs are self-contained finite-dimensional arguments. The independent certificate enumerates all 64 scenario-type subsets in the nine-dimensional example, supplies exact rational primal-dual LP certificates and full-rank active equalities, and checks them against a separate numerical LP solver. Because repeated labels do not change a feasible set, these 64 subsets cover the optimizer/support possibilities of that one fixed model for arbitrary finite sample lists. Exact sequence counts and state recursions additionally check the risk formula. These checks supplement, and do not replace, the general proofs.

The result is a limitation on an exact risk calibration, not a universal impossibility of learning from compression. Distribution-free compression bounds, wait-and-judge bounds and properly conditioned projective-boundary guarantees remain valid under their respective hypotheses. We do not claim the best possible dimension for a counterexample, robust violation under arbitrary perturbations of constraints, or a fixed-dimensional asymptotic separation. All search conclusions are limited to the examined primary literature. No external peer review or worldwide priority certification is claimed.

The manuscript provides written proofs of the stated finite-decision realization results.

## References

[1] M. C. Campi and S. Garatti. The exact feasibility of randomized solutions of uncertain convex programs. *SIAM Journal on Optimization* 19(3), 1211-1230 (2008). DOI: [10.1137/07069821X](https://doi.org/10.1137/07069821X). Author full text: [PDF](https://marco-campi.unibs.it/pdf-pszip/Campi-Garatti-exact.pdf).

[2] S. Garatti and M. C. Campi. Non-convex scenario optimization. *Mathematical Programming* 209, 557-608 (2025; online 2024). DOI: [10.1007/s10107-024-02074-3](https://doi.org/10.1007/s10107-024-02074-3). [Publisher full text](https://link.springer.com/article/10.1007/s10107-024-02074-3).

[3] S. Garatti and M. C. Campi. Risk and complexity in scenario optimization. *Mathematical Programming* 191, 243-279 (2022). DOI: [10.1007/s10107-019-01446-4](https://doi.org/10.1007/s10107-019-01446-4). Background comparison only.

[4] Y. Zhang and Y. Yang. Interior-free beta tails for convex scenario programs. *Journal of Applied Mathematics and Computing* 72, article 259 (2026). DOI: [10.1007/s12190-026-02915-8](https://doi.org/10.1007/s12190-026-02915-8). Publisher abstract, metadata and public computational supplement verified; subscription full text unavailable in this audit.

[5] G. C. Calafiore. Exact Risk-Complexity Laws for Projective Boundaries in Scenario Optimization and Distribution-Free Certification. [arXiv:2609.01355v1](https://arxiv.org/abs/2609.01355), 2026. Author manuscript, especially Corollary 4.6, Proposition 5.2 and Section 10.

[6] B. Gartner, J. Matousek, L. Rust and P. Skovron. Violator spaces: Structure and algorithms. *Discrete Applied Mathematics* 156(11), 2124-2141 (2008). DOI: [10.1016/j.dam.2007.08.048](https://doi.org/10.1016/j.dam.2007.08.048). Author manuscript: [arXiv:cs/0606087v3](https://arxiv.org/abs/cs/0606087).

[7] J. Matousek and P. Skovron. Removing degeneracy may require a large dimension increase. *Theory of Computing* 3, 159-177 (2007). DOI: [10.4086/toc.2007.v003a008](https://doi.org/10.4086/toc.2007.v003a008). [Open full text](https://theoryofcomputing.org/articles/v003a008/v003a008.pdf), particularly Section 6.

[8] G. O. Berger. Improved Compression-Based PAC Bounds for General Scenario Decision Making. [arXiv:2501.08884v2](https://arxiv.org/abs/2501.08884), 2025. [Author full text](https://arxiv.org/html/2501.08884v2). The cited ambient-dimensional theorem and the smaller compression parameter must be distinguished.
