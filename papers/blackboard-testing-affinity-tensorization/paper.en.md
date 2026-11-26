# Exact Affinity Tensorization for Fully Interactive Testing under Local Bit Budgets

Research manuscript • 25 November 2026  
Written proofs.

## Abstract

Consider simple binary testing from independent observations held by separate sensors. Each sensor may be revisited in an arbitrary adaptive blackboard protocol, but its total number of transmitted bits is bounded on every execution. We prove an exact identity: at every Hellinger order between zero and one, the smallest transcript affinity equals the product of the optimal single-sensor quantized affinities. The identity holds at finite sample size, for heterogeneous sensors and budgets, and on finite or countable alphabets. Its proof uses a partition envelope that records the sender's remaining communication budget; a product of these envelopes is a monotone potential on the protocol tree. Independent deterministic quantizers attain the bound. An exact nonnegative slack decomposition describes equality for deterministic protocols. For identical observations, the identity implies that the best identical noninteractive quantizer requires at most three times as many samples as an arbitrary fully interactive protocol, uniformly over the distributions, bit budget, prior $0<\pi\le 1/2$, and error target $0<\delta\le\pi/16$. A more precise error-dependent comparison has a coefficient tending to two. For finite strictly positive input laws, we also give exact identities for every positive Rényi order, including relative entropy; the Chernoff-information identity retains the full scope of the affinity theorem. An exact example shows that interaction nevertheless strictly improves the Bayes risk at a fixed sample size.

## 1. Problem, contribution, and prior work

Distributed testing separates two resources: the number of independent observations and the information that each holder can transmit. A sequential protocol visits each holder once. A fully interactive protocol may return to a holder after receiving messages from others. On a return visit, the holder's observation has already been restricted by earlier answers, so a sequential one-channel tensorization argument does not apply directly.

Kazemi, Pensia, and Jog [KPJ, Theorem 3] compare sequentially interactive testing with identical-channel testing, uniformly over a skewed prior and small target error. Their revised manuscript, dated 20 November 2026, still leaves the fully interactive blackboard question open in Section 5. We address its **hard per-sensor communication-budget branch**. The model below fixes how budgets compose across return visits. We do not claim to settle arbitrary channel constraints or interactive local differential privacy.

The substantive new assertion is the exact finite-protocol identity in Theorem 3.1, followed by the sample comparison in Theorem 4.2. Heterogeneous observations, arbitrary interleaving, early stopping, and randomization are included in the same argument. The improvement from a fourfold to a threefold sample comparison uses an elementary refinement of the familiar error-affinity bridge; that constant refinement is not the principal contribution.

Classical feedback detection already contains important no-gain results. Tay [Tay12] studies specified one-message and two-message architectures. In particular, Lemma 4 and equation (15) contain a finite-$n$ moment bound for two-message full feedback, which is then used for error exponents. Our comparison therefore does **not** describe all earlier moment methods as merely asymptotic. The additional step here covers arbitrary adaptive interleaving and repeated visits under a total local bit budget, and yields a finite-sample comparison for every stated prior and error. We make no general equality claim about the optimal Bayes error exponent.

Pensia, Jog, and Loh [PJL24] provide the communication-constrained simple-testing baseline, including quantization and reverse data processing. Their single-channel problem is retained as the local optimization in our theorem; it is not presented as newly solved. Kazemi and Jog [KJ26] characterize broadcast-model information complexity at constant advantage. Information cost and a hard worst-case bit budget for each sensor are different constraints, so that result is not by itself the finite-sample identity proved here. Likelihood-ratio quantizer structure and efficient single-channel optimization are also prior subjects [Tsi93, PJL24]; neither is needed as a black box in our proof.

The claims of distinction are limited to the literature cited in this manuscript. The manuscript has not undergone external peer review.

## 2. Model and elementary facts

### 2.1. Protocols and observations

Fix a positive integer $n$. Sensor $i$ holds one observation in a finite or countable nonempty set $\mathcal X_i$. Under hypothesis $H=1$, the joint law is $\bigotimes_{i=1}^n P_i$; under $H=0$, it is $\bigotimes_{i=1}^n Q_i$. Thus the observations are independent conditional on either hypothesis. Fix integers $b_i\ge0$ and write $B=\sum_i b_i$.

A deterministic admissible protocol is a binary decision tree. Each internal node specifies a sensor $i$ and a binary function of that sensor's observation. These choices may depend on the complete preceding transcript. On every path, sensor $i$ appears at most $b_i$ times. Each leaf is a public stopping point. The communicated transcript is the root-to-leaf bit string. Sender identities, queries, and stopping are determined by the public history, so they reveal no additional private information. The tree has depth at most $B$.

This model permits arbitrary numbers of visits within the stated budgets, adaptive sender order, unequal numbers of bits on different paths, and early stopping. An equivalent variable-length message description must charge all information-bearing delimiters. Input-dependent timing, uncharged silence, and a private choice of the next sender are not extra free channels in this model. Public messages that are deterministic functions of the transcript can be removed without changing the experiment.

A randomized admissible protocol additionally uses public and private random seeds independent of the observations and hypothesis. Its budgets hold on every input and admissible seed execution. Conditional on all seeds, it is a deterministic tree of the kind just defined. Public seeds are part of the observable transcript; private seeds are not. Presampling all randomness covers adaptive use of random bits. The scheduler's choice is determined by the public history and public seeds; private seeds affect the prescribed sender's answer, not an uncharged choice of sender. No agent or fusion centre has an additional private data source.

### 2.2. Affinity and finite-output quantization

For $0<\lambda<1$ and probability laws on a countable set, define

$$
\mathcal B_\lambda(P,Q)=\sum_x P(x)^\lambda Q(x)^{1-\lambda}.
\tag{2.1}
$$

Every positive power of zero is zero. For a transcript with a nondiscrete public seed, use the same integral with densities relative to the sum of its two laws. The value lies in $[0,1]$.

For a positive integer $D$, define the optimal local affinity

$$
a_\lambda(P,Q;D)=
\inf_{q:\mathcal X\to[D]}
\sum_{j=1}^D P(q^{-1}(j))^\lambda Q(q^{-1}(j))^{1-\lambda}.
\tag{2.2}
$$

Empty output cells are allowed. A deterministic $D$-output quantizer is simply such a map $q$.

**Lemma 2.1 (coarsening, mixing, and products).** Affinity increases under a measurable coarsening or stochastic channel, is jointly concave in its two laws, and satisfies

$$
\mathcal B_\lambda\!\left(\bigotimes_i R_i,\bigotimes_i S_i\right)
=\prod_i\mathcal B_\lambda(R_i,S_i).
\tag{2.3}
$$

*Proof.* For nonnegative families $(r_x),(s_x)$, Hölder gives
$\sum_x r_x^\lambda s_x^{1-\lambda}\le(\sum_x r_x)^\lambda(\sum_x s_x)^{1-\lambda}$.
Apply this separately to the cells of a coarsening. For a stochastic channel, apply it to $r_x=P(x)K(y\mid x)$ and $s_x=Q(x)K(y\mid x)$ for each $y$, then sum over $y$. The same inequality, with integration over a mixing seed, gives joint concavity. Product factorization follows by distributing the nonnegative sums; Tonelli justifies countable sums. The integral versions follow from the integral form of Hölder. $\square$

**Lemma 2.2 (attainment and deterministic quantizers).** On a finite or countable alphabet, the infimum in (2.2) is attained. Allowing randomized channels with $D$ outputs does not change its value. Both assertions also hold for finite subprobability masses restricted to a subset of the alphabet.

*Proof.* Enumerate the alphabet. From any sequence of maps to the finite set $[D]$, successive extraction yields a subsequence eventually constant at each fixed input point. Call its coordinatewise limit $q$. For each output $j$, the difference between its output masses is bounded by the mass of the tail once the quantizers agree on a sufficiently long finite prefix. The tail bound is uniform over all quantizers and tends to zero for both measures. Thus all $D$ pairs of output masses converge. The objective is a finite sum of functions $(u,v)\mapsto u^\lambda v^{1-\lambda}$ continuous on the closed nonnegative quadrant. A minimizing sequence therefore has a minimizing limit.

For a stochastic channel $K$, take a uniform seed $U$ and let $q_U(x)$ be the inverse-CDF output of $K(\cdot\mid x)$. This uses the same analytical seed for all input points, but it represents exactly the prescribed channel at each individual input. Joint concavity gives

$$
\mathcal B_\lambda(KP,KQ)
\ge\int_0^1\mathcal B_\lambda((q_u)_\#P,(q_u)_\#Q)\,du
\ge a_\lambda(P,Q;D).
\tag{2.4}
$$

Deterministic channels are included among stochastic ones, so the two infima coincide. Restricting the masses to a subset changes none of the tail or continuity arguments. $\square$

## 3. Exact affinity of arbitrary blackboard protocols

**Theorem 3.1 (exact affinity tensorization).** In the model of Section 2, let $P_\Pi,Q_\Pi$ be the observable transcript laws of an admissible protocol. For every $0<\lambda<1$,

$$
\mathcal B_\lambda(P_\Pi,Q_\Pi)
\ge \prod_{i=1}^n a_\lambda(P_i,Q_i;2^{b_i}).
\tag{3.1}
$$

The lower bound is attained by a noninteractive protocol: sensor $i$ independently applies an optimal deterministic quantizer with at most $2^{b_i}$ outputs. Consequently,

$$
\min_{\Pi\text{ admissible}}\mathcal B_\lambda(P_\Pi,Q_\Pi)
=\prod_{i=1}^n a_\lambda(P_i,Q_i;2^{b_i}).
\tag{3.2}
$$

The optimizing quantizers may depend on $\lambda$. The theorem does not provide one quantizer simultaneously optimizing every order.

### 3.1. The remaining-budget envelope

For $S\subseteq\mathcal X_i$ and integer $k\ge0$, put

$$
V_i(S,k)=\min_{S=A_1\sqcup\cdots\sqcup A_{2^k}}
\sum_{j=1}^{2^k}P_i(A_j)^\lambda Q_i(A_j)^{1-\lambda}.
\tag{3.3}
$$

The measures in (3.3) are **not normalized on $S$**. Empty cells are permitted. Lemma 2.2 supplies attainment, although the lower-bound proof could use infima and near-minimizers.

**Lemma 3.2 (local splitting).** For all $S$ and $k$,

$$
0\le V_i(S,k)\le P_i(S)^\lambda Q_i(S)^{1-\lambda},
\qquad V_i(S,0)=P_i(S)^\lambda Q_i(S)^{1-\lambda}.
\tag{3.4}
$$

The value is nonincreasing in $k$. If $k\ge1$ and $S=A\sqcup C$, then

$$
V_i(S,k)\le V_i(A,k-1)+V_i(C,k-1).
\tag{3.5}
$$

In fact, minimizing the right side of (3.5) over all such binary splits gives equality.

*Proof.* The one-cell partition proves the upper bound; nonnegativity and the $k=0$ identity follow from the definition. Padding by empty cells proves monotonicity. Join optimal partitions of $A$ and $C$, each with at most $2^{k-1}$ cells. Their union has at most $2^k$ cells and proves (3.5). Conversely, split any minimizing $2^k$-cell partition into two groups of at most $2^{k-1}$ cells and let $A,C$ be their unions. Optimizing within each group cannot increase the sum. Combine this with (3.5) to obtain equality of the minima. $\square$

### 3.2. Rectangles and a product potential

**Lemma 3.3 (rectangle representation).** At each node $t$ of a deterministic admissible tree, the inputs producing its history form a Cartesian product $\prod_i S_i(t)$. If the next sender is $j$, its two children replace only $S_j(t)$ by a disjoint split $S_j(t0),S_j(t1)$.

*Proof.* At the root take $S_i=\mathcal X_i$. At a node, the sender and its binary query are already fixed by the preceding history. Conditioning on the next answer therefore intersects only the sender's current set with the corresponding inverse image. This is the inductive assertion. The leaves partition the entire input product, including any unreachable empty rectangles. $\square$

Let $k_i(t)$ be sensor $i$'s unspent bit budget at node $t$, and define

$$
\Phi(t)=\prod_i V_i(S_i(t),k_i(t)).
\tag{3.6}
$$

For an internal node with sender $j$, all other factors are unchanged. That sender's budget drops by one on each branch, so (3.5) gives

$$
\Phi(t0)+\Phi(t1)\ge\Phi(t).
\tag{3.7}
$$

At a terminal node the conditional-independence assumption and Lemma 3.3 give

$$
P_\Pi(t)^\lambda Q_\Pi(t)^{1-\lambda}
=\prod_i P_i(S_i(t))^\lambda Q_i(S_i(t))^{1-\lambda}
\ge\Phi(t).
\tag{3.8}
$$

The last inequality covers early stopping with unused bits.

*Proof of Theorem 3.1 for deterministic protocols.* Sum (3.8) over the leaves and telescope (3.7) upward along the finite tree. The result is
$\mathcal B_\lambda(P_\Pi,Q_\Pi)\ge\Phi(\varnothing)=\prod_i a_\lambda(P_i,Q_i;2^{b_i})$.
Zero-mass sets cause no difficulty because every factor is finite and nonnegative.

To attain equality, take the local minimizers provided by Lemma 2.2. Encode each of their output labels with exactly $b_i$ bits, padding unused labels if needed, and transmit them in a fixed order. The transcript identifies the whole output tuple. Independence and (2.3) give the product in (3.2). A sensor with $b_i=0$ has a constant quantizer and contributes one. $\square$

### 3.3. Randomness and equality certificates

*Randomized protocols.* Conditional on a fixed public seed, average over all private seeds. For each full seed realization the deterministic lower bound holds with the same right side. Joint concavity under marginalization of the hidden seed implies that the actual conditional transcript affinity is no smaller than the average of these deterministic affinities. Finally integrate over the public seed, which has the same distribution under the two hypotheses and is observed. This proves (3.1). Deterministic independent protocols already attain the bound. The argument does not assume that the sender's observation remains unconditioned on a return visit. $\square$

**Proposition 3.4 (exact nonnegative slack and equality).** For a fixed deterministic protocol, let $I$ and $L$ be its internal nodes and leaves. Define

$$
\sigma_t=\Phi(t0)+\Phi(t1)-\Phi(t)\quad(t\in I),
\qquad
\tau_t=P_\Pi(t)^\lambda Q_\Pi(t)^{1-\lambda}-\Phi(t)\quad(t\in L).
\tag{3.9}
$$

Then all these numbers are nonnegative and

$$
\mathcal B_\lambda(P_\Pi,Q_\Pi)
-\prod_i a_\lambda(P_i,Q_i;2^{b_i})
=\sum_{t\in I}\sigma_t+\sum_{t\in L}\tau_t.
\tag{3.10}
$$

Thus equality holds exactly when every listed slack is zero.

*Proof.* In the finite sum of child potentials minus parent potentials, every nonroot internal potential cancels. The surviving terms are $\sum_{t\in L}\Phi(t)-\Phi(\varnothing)$. Add the leaf slacks. Nonnegativity follows from (3.7)--(3.8); a finite sum of nonnegative terms vanishes exactly when each vanishes. $\square$

This is a certificate for a given protocol, not a claim that every optimal protocol must be noninteractive. In particular, zero factors can make a splitting slack vanish without requiring the corresponding local split to be uniquely optimal.

## 4. Finite-sample consequences for binary testing

Now take $P_i=P$, $Q_i=Q$, and $b_i=b$. Under prior $\Pr(H=1)=\pi\le1/2$, the Bayes error of a decision event $E$ is

$$
\pi P_\Pi(E^c)+(1-\pi)Q_\Pi(E).
\tag{4.1}
$$

Write $n_{\rm bb}$ for the least number of sensors for which an admissible blackboard protocol achieves error at most $\delta$. Write $n_{\rm id}^{\rm det}$ for the corresponding minimum when one deterministic $2^b$-output quantizer is applied identically and independently to every observation, followed by an optimal server decision. If identical stochastic channels are permitted, denote that minimum by $n_{\rm id}^{\rm rand}$. A minimum is $+\infty$ when no finite sample size is feasible. These are existence-based integer minima, not unattained risk infima.

### 4.1. A balanced error-affinity inequality

For $0<\delta<\pi$, put $r=\delta/\pi$, $q=1-\pi$, and

$$
\lambda=\frac{\log(q/\delta)}{\log(q/\delta)+\log(\pi/\delta)},
\qquad t=r^\lambda,
\qquad c=\pi^\lambda q^{1-\lambda}.
\tag{4.2}
$$

Then $1/2\le\lambda<1$ and

$$
t=(\delta/q)^{1-\lambda},\qquad ct^2=\delta.
\tag{4.3}
$$

This balancing choice is the one in [KPJ]. The following refinement retains the joint budget of the two kinds of error.

**Lemma 4.1 (weighted error bound).** If a pair of transcript laws $R,S$ admits a test with Bayes error at most $\delta$, then

$$
\mathcal B_\lambda(R,S)\le(2\delta/\pi)^\lambda.
\tag{4.4}
$$

*Proof.* Use an optimal deterministic decision event $E$, and let $\alpha=S(E)$, $\beta=R(E^c)$. Hölder on $E$ and $E^c$ gives

$$
\mathcal B_\lambda(R,S)
\le(1-\beta)^\lambda\alpha^{1-\lambda}
+\beta^\lambda(1-\alpha)^{1-\lambda}
\le\alpha^{1-\lambda}+\beta^\lambda.
\tag{4.5}
$$

Set $u=\pi\beta/\delta$ and $v=q\alpha/\delta$. The error constraint gives $u+v\le1$, and (4.3) turns the last expression into $t(u^\lambda+v^{1-\lambda})$. We claim

$$
u^\lambda+v^{1-\lambda}\le2^\lambda
\quad\text{when }u,v\ge0,\ u+v\le1,\ 1/2\le\lambda<1.
\tag{4.6}
$$

At $\lambda=1/2$, Cauchy--Schwarz proves the claim. Otherwise put $\theta=2(1-\lambda)\in(0,1)$. The two-term Hölder inequality yields

$$
\begin{aligned}
u^\lambda+v^{1-\lambda}
&=(\sqrt u)^\theta u^{1-\theta}+(\sqrt v)^\theta 1^{1-\theta}\\
&\le(\sqrt u+\sqrt v)^\theta(u+1)^{1-\theta}\\
&\le(\sqrt2)^\theta 2^{1-\theta}=2^\lambda.
\end{aligned}
\tag{4.7}
$$

All exponents in this nonendpoint argument are positive, so zero values of $u$ or $v$ are included without a $0^0$ convention. Multiplication by $t=r^\lambda$ proves (4.4). $\square$

### 4.2. A universal sample comparison

**Theorem 4.2 (full-interaction sample comparison).** For finite or countable $\mathcal X$, integer $b\ge1$, $0<\pi\le1/2$, and $0<\delta<\pi/2$, every successful blackboard protocol on $n$ observations has an identical deterministic-quantizer replacement on at most

$$
m=\left\lceil\kappa(r)n\right\rceil,
\qquad
\kappa(r)=\frac{2\log(1/r)}{\log(1/(2r))},
\qquad r=\delta/\pi,
\tag{4.8}
$$

fresh observations. In particular, for $0<\delta\le\pi/16$,

$$
n_{\rm bb}\le n_{\rm id}^{\rm rand}\le n_{\rm id}^{\rm det}
\le\left\lceil\frac83 n_{\rm bb}\right\rceil
\le3n_{\rm bb}.
\tag{4.9}
$$

*Proof.* Fix a successful protocol on $n$ sensors. Zero sensors have error $\pi>\delta$, so $n\ge1$. Let $a=a_\lambda(P,Q;2^b)$ with $\lambda$ from (4.2). Theorem 3.1 and Lemma 4.1 imply

$$
a^n\le(2r)^\lambda.
\tag{4.10}
$$

Take an attaining local quantizer from Lemma 2.2. For its repeated output laws $U,V$, the termwise inequality $\min\{s,t\}\le s^\lambda t^{1-\lambda}$ gives the familiar Chernoff upper bound

$$
e_\pi(U^{\otimes m},V^{\otimes m})\le c a^m.
\tag{4.11}
$$

If $a=0$, one observation already succeeds. Otherwise (4.10) rules out $a=1$, since $2r<1$. The choice (4.8) satisfies
$\lambda m\log(1/(2r))/n\ge2\lambda\log(1/r)$.
Consequently (4.10)--(4.11) give $ca^m\le c r^{2\lambda}=\delta$.

Every identical stochastic scheme is a legal randomized blackboard protocol, and deterministic identical schemes are a subclass of stochastic ones. This proves the first two inequalities in (4.9). For $r\le1/16$, direct division gives $\kappa(r)\le8/3$. Finally $\lceil8n/3\rceil\le3n$ for every positive integer $n$. Apply the result to the existence-minimizing $n_{\rm bb}$. If it is infinite, admissible-class inclusion forces both other complexities to be infinite as well. $\square$

**Corollary 4.3 (threefold replacement without attainment).** Under the assumptions of Theorem 4.2 with $0<\delta\le\pi/16$, the threefold conclusion also follows from the affinity lower bound alone, if the local optimum is only an infimum over implementable quantizers.

*Proof.* Equation (4.10) gives

$$
ca^{3n}\le c(2r)^{3\lambda}
=\delta(8r)^\lambda
\le\delta\,2^{-\lambda}<\delta.
\tag{4.12}
$$

The strict margin permits a sufficiently close local near-minimizer. If $a=0$, choose an appropriately small positive affinity; if $a=1$, no successful finite protocol could have satisfied (4.10). $\square$

**Corollary 4.4 (a single local quantity bounds both complexities).** If $0 \lt a_\lambda(P,Q;2^b)<1$ and $0<\delta<\pi/2$, then

$$
\left\lceil\frac{\lambda\log(\pi/(2\delta))}{\log(1/a_\lambda)}\right\rceil
\le n_{\rm bb}\le n_{\rm id}^{\rm det}
\le\left\lceil\frac{2\lambda\log(\pi/\delta)}{\log(1/a_\lambda)}\right\rceil.
\tag{4.13}
$$

*Proof.* Take logarithms in (4.10) for the lower bound. For the upper bound, insert the displayed integer into (4.11) and use (4.3). $\square$

The coefficient $\kappa(r)$ tends to two as $r\downarrow0$. This is a statement about an upper-bound coefficient, not about the actual optimal efficiency ratio or the necessity of the constant two. The ceiling in (4.8) cannot be discarded. With a fixed positive $n$, that displayed integer is eventually $2n+1$.

### 4.3. Degenerate cases

If $P=Q$, every transcript has identical laws under the two hypotheses and no error below $\pi$ is possible. If $b=0$, the same conclusion holds because no input-dependent communication is allowed. All three complexities are then infinite.

If $P$ and $Q$ are mutually singular and $b\ge1$, a one-bit support-membership quantizer gives zero error, and all three complexities equal one. Conversely, zero optimal local affinity implies singularity by Lemma 2.1 and the definition (2.1).

If $P\ne Q$, there is an event $A$ with $P(A)\ne Q(A)$. Its binary quantizer has affinity strictly below one, by the strict equality condition in Hölder for distinct Bernoulli laws. Repetition therefore gives finite sample complexity. If the original laws are not singular, their affinity is positive; data processing makes every quantized affinity at least this positive number. Thus the logarithms in (4.13) are used only in the nondegenerate case.

## 5. Other exact information identities

These consequences express the reusable scope of the same tree argument; they are not separate claims of solving the local quantization problem.

### 5.1. Rényi divergence

For this subsection assume each $\mathcal X_i$ is finite and $P_i,Q_i$ are strictly positive at every input point. Let $D_\alpha$ be Rényi divergence for $\alpha>0$, $\alpha\ne1$, and let $D_1$ be relative entropy.

**Theorem 5.1 (optimal Rényi information).** For every $\alpha>0$, including $\alpha=1$ by continuity,

$$
\sup_{\Pi\text{ admissible}}D_\alpha(P_\Pi\Vert Q_\Pi)
=\sum_i\max_{q_i:\mathcal X_i\to[2^{b_i}]}
D_\alpha((q_i)_\#P_i\Vert(q_i)_\#Q_i).
\tag{5.1}
$$

*Proof.* For $0<\alpha<1$, the factor $1/(\alpha-1)$ reverses inequalities after taking logarithms in Theorem 3.1. The product becomes the sum in (5.1).

For $\alpha>1$, define instead

$$
U_i(S,k)=\max_{S=\bigsqcup_{j=1}^{2^k} A_j}
\sum_j P_i(A_j)^\alpha Q_i(A_j)^{1-\alpha},
\tag{5.2}
$$

where an empty cell contributes zero. Positivity on a finite alphabet makes every nonempty cell have positive $Q_i$ mass, so all values are finite. The same partition concatenation now gives
$U_i(S,k)\ge U_i(A,k-1)+U_i(S\setminus A,k-1)$,
and the one-cell partition gives $U_i(S,k)\ge P_i(S)^\alpha Q_i(S)^{1-\alpha}$.
The product potential therefore has child sum at most its parent, and each terminal moment is at most its terminal potential. Telescoping gives an upper bound by the product of the local maxima. The function $(p,q)\mapsto p^\alpha q^{1-\alpha}$ is convex for $q>0$ (the perspective of $x^\alpha$), so marginalizing a private random seed cannot increase the moment beyond the mean of the deterministic moments. Conditioning on public seeds completes the randomized case. Independent maximizing quantizers attain the product. Taking the logarithm and dividing by $\alpha-1$ proves (5.1).

For $\alpha=1$, there are only finitely many deterministic trees of depth at most $B$ on the fixed finite alphabets: at a node there are finitely many sender choices and binary functions. The deterministic maximum therefore commutes with the limit $\alpha\to1$. The same is true of each local maximum. Relative entropy is jointly convex, so randomization cannot exceed the deterministic maximum. This proves the $\alpha=1$ assertion. $\square$

The strict positivity restriction in this theorem avoids any interchange involving unbounded likelihood ratios. The affinity theorem itself has no such restriction. Equation (5.1) optimizes separately at each order; it is not Blackwell equivalence of the two families of experiments.

### 5.2. Chernoff information

Define $C(R,S)=\sup_{0<\lambda<1}[-\log\mathcal B_\lambda(R,S)]$, with $-\log0=+\infty$.

**Corollary 5.2 (optimal transcript Chernoff information).** Under the full assumptions of Theorem 3.1,

$$
\sup_{\Pi\text{ admissible}}C(P_\Pi,Q_\Pi)
=\sup_{0<\lambda<1}\sum_i[-\log a_\lambda(P_i,Q_i;2^{b_i})].
\tag{5.3}
$$

In the identical setting this equals
$n\sup_q C(q_\#P,q_\#Q)$, where $q$ has at most $2^b$ outputs.

*Proof.* Theorem 3.1 evaluates the supremum of $-\log\mathcal B_\lambda$ over protocols at every fixed $\lambda$. Suprema over the product of two index sets may be interchanged. In the identical case, the same interchange applies to $q$ and $\lambda$. $\square$

Equation (5.3) evaluates a divergence functional of finite transcript experiments. It does not identify the exact Bayes-risk exponent of every sequence of adaptive protocols. Establishing such an identification would require an additional operational argument.

## 6. Interaction can still improve a fixed-sample Bayes risk

**Proposition 6.1 (an exact strict improvement).** Take two independent sensors with alphabet $\{1,2,3\}$, one bit each, equal prior, and

$$
P=(1,3,6)/10,\qquad Q=(3,4,3)/10.
\tag{6.1}
$$

The smallest Bayes error among all noninteractive protocols, allowing different sensor quantizers and all public or private randomness, is $67/200$. A legal adaptive protocol has error $64/200=8/25$.

*Proof.* Up to output relabeling, every nonconstant deterministic binary quantizer on three points is one of the singleton partitions
$A=\{1\}\mid\{2,3\}$, $B=\{2\}\mid\{1,3\}$, and $C=\{3\}\mid\{1,2\}$.
For quantizers $q_1,q_2$, calculate their risk by

$$
\frac12\sum_{y_1,y_2}
\min\{P(q_1^{-1}(y_1))P(q_2^{-1}(y_2)),
Q(q_1^{-1}(y_1))Q(q_2^{-1}(y_2))\}.
\tag{6.2}
$$

In units of $1/200$, the nine values are

| First sensor / second sensor | $A$ | $B$ | $C$ |
|---|---:|---:|---:|
| $A$ | 68 | 79 | 67 |
| $B$ | 79 | 87 | 70 |
| $C$ | 67 | 70 | 67 |

If one sensor is constant, the best risk is $70/200$; if both are constant, it is $100/200$. These values exhaust deterministic noninteractive protocols. For a randomized one, reveal all its coins to the decoder. Conditional on the coins, its risk is bounded below by the deterministic optimum; hiding coins can only worsen optimal risk. Therefore $67/200$ is also the randomized optimum.

For the adaptive construction, ask sensor 1 whether $X_1\in\{1,2\}$. If yes, ask sensor 2 whether $X_2\in\{1,2\}$. If no, ask sensor 2 whether $X_2=1$. The four leaf likelihood masses, in units of $1/100$, are

| Leaf | $P^{\otimes2}$ mass | $Q^{\otimes2}$ mass | Risk contribution in $1/200$ |
|---|---:|---:|---:|
| yes, yes | 16 | 49 | 16 |
| yes, no | 24 | 21 | 21 |
| no, yes | 6 | 9 | 6 |
| no, no | 54 | 21 | 21 |

Summing the last column gives $64/200$. $\square$

The example does not assert optimality among all adaptive protocols. It suffices to prove strict finite-risk improvement and prevents an overinterpretation of Theorems 3.1 and 4.2. Its risk level is outside the small-error regime of (4.9), which is not needed for this logical distinction.

## 7. Verification, scope, and open boundaries

The mathematical proofs above are independent of the computations. The accompanying exact-arithmetic program recomputes Proposition 6.1, including all binary maps and both sensors' different choices. A separately written finite dynamic program directly minimizes leaf affinity over sender choices, local binary splits, and early stopping; it agrees with the product formula on the recorded test instances. Its floating-point checks are diagnostics, not a proof for untested alphabets or all parameters.

Conditional independence is essential to the rectangle-mass factorization. For example, let the two-sensor law under one hypothesis be uniform on $\{(0,0),(1,1)\}$ and under the other be uniform on $\{(0,1),(1,0)\}$. Each single-sensor marginal is the same under both hypotheses, yet transmitting both bits distinguishes the two laws perfectly. Applying (3.1) with the identical marginals would give a false bound; the product-hypothesis assumption excludes this example.

The proof is specific to a separate hard bit budget for every sensor. Expected budgets, unrestricted global budget allocation, noisy interactive communication links, additional private side information, composite hypotheses, and general constraint sets without a partition-concatenation property are not covered. A fixed $b$-bit message has $2^b$ possible labels; an arbitrary non-power-of-two label budget is not silently substituted for this pathwise bit model. The same observations cannot be reused as independent fresh samples in the replacement argument.

The factor three is a proved upper bound, not an optimality claim. Exact finite-sample Bayes-risk equivalence is false by Proposition 6.1. A single local quantizer need not optimize all priors, errors, or Rényi orders. The manuscript's formal-verification status is **not started**. No Lean source or compilation result is claimed.

## References

[KPJ] Hadi Kazemi, Ankit Pensia, and Varun Jog. *The Sample Complexity of Distributed Simple Binary Hypothesis Testing under Information Constraints*. arXiv:2506.13686v2, revised 20 November 2026. [Official full text](https://arxiv.org/html/2506.13686v2). The authors report acceptance in IEEE Transactions on Information Theory. DOI listed by the authors' institution: [10.1109/TIT.2026.3740318](https://doi.org/10.1109/TIT.2026.3740318). The inspected technical version is the arXiv v2, not an independently retrieved publisher PDF.

[PJL24] Ankit Pensia, Varun Jog, and Po-Ling Loh. *Communication-Constrained Hypothesis Testing: Optimality, Robustness, and Reverse Data Processing Inequalities*. IEEE Transactions on Information Theory **70**(1), 389--414, 2024. [DOI:10.1109/TIT.2023.3334024](https://doi.org/10.1109/TIT.2023.3334024). [Author manuscript](https://arxiv.org/abs/2206.02765).

[Tay12] Wee Peng Tay. *The Value of Feedback in Decentralized Detection*. IEEE Transactions on Information Theory **58**(12), 7226--7239, 2012. [DOI:10.1109/TIT.2012.2211331](https://doi.org/10.1109/TIT.2012.2211331). [Author manuscript](https://arxiv.org/abs/1108.6121). The finite-moment comparison in Lemma 4 and equation (15), as well as its architecture restrictions, is part of the credited baseline.

[KJ26] Hadi Kazemi and Varun Jog. *Tight Information Complexity of the Coin Problem in the Broadcast Model*. arXiv:2608.02776v1, 3 August 2026. [Official full text](https://arxiv.org/html/2608.02776v1).

[Tsi93] John N. Tsitsiklis. *Extremal Properties of Likelihood-Ratio Quantizers*. IEEE Transactions on Communications **41**(4), 550--558, 1993. [DOI:10.1109/26.223779](https://doi.org/10.1109/26.223779). Background on single-sensor optimization; not a proof dependency for the results here.
