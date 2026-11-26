# A Common Revenue Threshold for Regular Proportional Choice

A sharp half-approximation for arbitrary utility rank cutoffs

**Research manuscript, version 1.1.** The mathematical arguments are written proofs. This manuscript is not an externally peer-reviewed publication, and no machine-checked formalization is claimed.

## Abstract

We study unconstrained assortment optimization when the choice probability of each offered product is its fixed positive weight times a factor depending on the offered set. Suppose that adding products cannot increase an incumbent product's choice probability or the probability of no purchase. We prove a simultaneous replacement theorem: every assortment has one revenue-threshold replacement earning at least half its revenue under every model with the same product weights and revenues. The replacement threshold is half the weight-averaged revenue of the comparison assortment. The argument uses a weighted-set inequality and the two regularity inequalities; it does not require the comparison assortment to be optimal. We give a self-contained finite-ranking derivation showing that utility-based multinomial-logit rank-cutoff models satisfy the hypotheses for every independent cutoff distribution. This resolves the larger-cutoff revenue-ordering question posed by Bai, Feldman, Topaloglu and Wagner. Their cutoff-two lower-bound construction already makes the universal factor sharp. The simultaneous witness also implies a half-approximation for worst-case revenue over arbitrary families sharing product weights. A separate exact family shows why singleton-probability upper bounds used in nearby approximation results cannot establish a positive constant guarantee throughout this class. The result is a finite candidate reduction; efficient evaluation of an arbitrary robust objective is not asserted.

## 1. Problem, contribution, and comparison

An assortment is a subset of products offered to one arriving customer. A revenue-ordered assortment contains every product whose revenue is at least a common threshold, with equal-revenue products included together. Searching such assortments is attractive because their number is at most the number of products. Their performance depends strongly on the choice model.

Bai et al. [1] study independent Gumbel utilities with an independent cutoff on global utility rank. Products unavailable for purchase still affect those ranks. Their Appendix D proves a sharp half guarantee when the cutoff is at most two and explicitly leaves larger cutoffs open. Their general approximation scheme and our revenue-threshold guarantee answer different algorithmic questions: we do not improve their approximation-scheme accuracy or its running time.

The new mathematical statement is Theorem 2.2. It supplies one threshold that works for every scenario simultaneously, for an arbitrary comparison set. The rank-cutoff guarantee in Theorem 4.4 is its principal application. Corollary 3.2 is a direct robust consequence of the same witness, not an independent source of algorithmic difficulty. Section 5 credits and rederives the existing tightness mechanism. Proposition 6.1 provides a separation from a common alternative upper-bound approach.

The statement is restricted to fixed product revenues and fixed relative product weights. Scenario-dependent scaling of all weights can be absorbed into the common factor, but arbitrary changes in relative weights cannot. We impose no display, capacity, inventory, or cardinality constraints. A threshold produced here need not satisfy such constraints.

### Related results and the exact distinctions

Berbeglia and Joret [2] analyze revenue ordering for general regular discrete choice. Our additional proportionality assumption is substantial; the half guarantee below is not claimed for every regular model. Gallego and Berbeglia [3] obtain half guarantees for important models and provide sufficient conditions involving singleton purchase probabilities and purchase-to-outside odds. Gallego et al. [4] develop a broader independent-demand surrogate under bounding conditions. Proposition 6.1 shows that their singleton upper benchmark can be arbitrarily larger than the actual optimum in our class. Section 6.2 gives a small instance outside the fixed affine-denominator family and violating the relevant singleton-odds sufficient inequality. These comparisons distinguish hypotheses and benchmarks; they do not dispute the validity of the earlier guarantees on their stated domains.

Wang and Şahin [5, Theorem 3(b)] already prove a half guarantee in their homogeneous search-cost consideration model. That model and ours are not nested: their Example 2 violates outside-option regularity, while a two-product cutoff-one instance cannot be represented by their homogeneous deterministic-consideration model. We give the explicit comparison in Section 6.3. We do not claim to subsume that paper or exclude every heterogeneous search-cost mixture.

Sun et al. [11, Corollary 2] establish a half guarantee for the marginal distribution model (MDM), while their Theorem 6 gives a $1/(2G)$ guarantee for $G$-segment mixed MDM. These are essential close results. The representation used in their Proposition 2 and assortment formulation requires each product's choice probability to be nondecreasing in the outside probability. The common-option ordering condition in Ruan et al. [12] gives a related necessary property. Section 6.4 supplies a rank-cutoff instance with positive probability of cutoff three that violates both tests, so the single-MDM half theorem cannot be applied by model inclusion. We do not claim that no mixed-MDM representation exists. The relevant full statements and proofs in both sources were examined.

Guan et al. [13, Theorem 2(ii)] prove a half guarantee for markup-ordered assortments in the constant-parameter threshold focal MNL model (ctFMNL). Their broader regular threshold-FMNL result concerns joint assortment and price optimization. Section 6.5 gives a two-product rank-cutoff instance outside ctFMNL, so its static half theorem does not subsume ours by model inclusion. This comparison does not exclude representations in unrestricted set-dependent FMNL.

For ordinary MNL, robust revenue-order optimality is established by Rusmevichientong and Topaloglu [6]. Our robust result concerns generally non-MNL choice with uncertain cutoff distributions and a shared product-weight vector. Sturt [7] studies uncertainty over ranking-based models constrained by historical assortment observations; the candidate structure there depends on the historical data. Lu et al. [8] analyze specified ambiguity sets around nominal MNL. Those uncertainty sets and exact-optimality results differ from the unrestricted family of regular proportional models used here.

Recent inventory work by Feldman, Huang and Zhang [9] assumes an approximation oracle for a cardinality-constrained static assortment problem and transfers it to stochastic inventory decisions. Our unrestricted threshold theorem neither follows from nor supplies that stronger oracle. Sun and Udwani [10] optimize inventory sales at uniform prices; their nonuniform-price evaluation extension is explicitly distinct from a nonuniform-price optimization result. Neither inventory comparison changes the static benchmark studied below. Novelty claims are limited to the sources and versions audited through 26 November 2026.

## 2. A simultaneous threshold replacement theorem

Let $N$ be a nonempty finite set. Each $i\in N$ has a weight $v_i>0$ and revenue $r_i\ge0$. For $A\subseteq N$, define

$$
V(A)=\sum_{i\in A}v_i,\qquad W(A)=\sum_{i\in A}r_iv_i.
\tag{2.1}
$$

Let $\Theta$ be a nonempty set of scenarios. For every $\theta\in\Theta$ and nonempty $A$, let $q_\theta(A)\ge0$ satisfy $V(A)q_\theta(A)\le1$. Product and outside probabilities are

$$
p_i^\theta(A)=v_iq_\theta(A)\ (i\in A),\qquad
p_0^\theta(A)=1-V(A)q_\theta(A).
\tag{2.2}
$$

Unavailable products have probability zero. The empty set has no-purchase probability one and revenue zero; a value of $q_\theta(\varnothing)$ is unnecessary. For nonempty $A$ define

$$R_\theta(A)=q_\theta(A)W(A).\tag{2.3}$$

Our two assumptions, for $\varnothing\ne A\subseteq B\subseteq N$, are

$$
q_\theta(B)\le q_\theta(A),\tag{P}
$$

$$
V(B)q_\theta(B)\ge V(A)q_\theta(A).\tag{O}
$$

Condition (P) is equivalent to regularity for each incumbent product, since its weight is positive. Condition (O) says that the total purchase probability does not decrease; it is precisely regularity for the outside option. Both hold scenario by scenario. We call (2.2), (P), and (O) **regular proportional choice**. This terminology names the assumptions and does not assert a new behavioral characterization.

**Lemma 2.1 (weighted threshold mass).** Let $S\ne\varnothing$ and $W(S)>0$. Put

$$
t=\frac{W(S)}{2V(S)},\qquad H=\{i\in N:r_i\ge t\},\qquad U=S\cup H.
\tag{2.4}
$$

Then $t>0$, $H\ne\varnothing$, and $W(H)\ge tV(U)$.

**Proof.** Positivity of the weights gives $V(S)>0$. At least one element of $S$ has revenue at least its weighted average $W(S)/V(S)=2t$: otherwise summing the strict inequalities $r_i<2t$ against positive weights would contradict $W(S)=2tV(S)$. Thus $H$ is nonempty. Set $B=S\setminus H$ and $C=H\setminus S$. The threshold definition gives $W(B)\le tV(B)$ and $W(C)\ge tV(C)$. Disjoint finite sums yield

$$
\begin{aligned}
W(H)&=W(S)-W(B)+W(C)\\
&\ge 2tV(S)-tV(B)+tV(C)\\
&\ge tV(S)+tV(C)=tV(U),
\end{aligned}\tag{2.5}
$$

where the last inequality uses $B\subseteq S$ and positive weights. This includes empty $B$ or $C$ and ties at the threshold. $\square$

**Theorem 2.2 (common-threshold replacement).** Under (2.1)–(2.3), (P), and (O), every $S\subseteq N$ admits a revenue-threshold set $H$ such that

$$R_\theta(H)\ge\tfrac12R_\theta(S)\qquad\text{for every }\theta\in\Theta.\tag{2.6}$$

If $S\ne\varnothing$ and $W(S)>0$, the single set (2.4) works. If $S=\varnothing$ or $W(S)=0$, take $H=N$.

**Proof.** In the positive case, both $H$ and $S$ are nonempty. Apply (P) to $H\subseteq U$, Lemma 2.1, and then (O) to $S\subseteq U$:

$$
\begin{aligned}
R_\theta(H)
&=q_\theta(H)W(H)\\
&\ge q_\theta(U)W(H)\\
&\ge t q_\theta(U)V(U)\\
&\ge t q_\theta(S)V(S)
=\tfrac12R_\theta(S).
\end{aligned}\tag{2.7}
$$

Every multiplier has the required nonnegative sign. Neither $t$ nor $H$ depends on $\theta$. If $S$ is empty or has zero weighted revenue, its revenue is zero under every scenario, while $R_\theta(N)\ge0$. This proves all cases. $\square$

The threshold in (2.4) is half the weight-averaged product revenue, not half the expected revenue $R_\theta(S)$. Confusing those quantities would generally destroy the simultaneous witness.

## 3. Nominal and robust finite candidate reductions

Let

$$\mathcal H=\bigl\{\{i:r_i\ge r_j\}:j\in N\bigr\},\tag{3.1}$$

with repeated sets removed. This family has at most $|N|$ members and includes $N$. Every nonempty set of the form $\{i:r_i\ge t\}$ belongs to $\mathcal H$: choose a minimum-revenue member of that set; its revenue produces exactly the same set. No arbitrary tie breaking is needed.

**Corollary 3.1 (nominal guarantee).** For each scenario,

$$\max_{H\in\mathcal H}R_\theta(H)\ge\tfrac12\max_{S\subseteq N}R_\theta(S).\tag{3.2}$$

**Proof.** A maximizing $S$ exists because $2^N$ is finite. Apply Theorem 2.2 and (3.1). $\square$

**Corollary 3.2 (worst-case guarantee).** Define $F(S)=\inf_{\theta\in\Theta}R_\theta(S)$. Then

$$\max_{H\in\mathcal H}F(H)\ge\tfrac12\max_{S\subseteq N}F(S).\tag{3.3}$$

No compactness, convexity, finiteness, or attainment assumption on $\Theta$ is required.

**Proof.** With $r_{\max}=\max_i r_i$, the probability interpretation gives $0\le R_\theta(S)\le r_{\max}$. Thus each infimum is a finite real number. For the common $H$ supplied for $S$, (2.6) implies $R_\theta(H)\ge F(S)/2$ for every $\theta$, and hence $F(H)\ge F(S)/2$. A maximizer of $F$ exists over the finite family $2^N$. Apply the previous sentence to it. This proof never exchanges a maximum and an infimum. $\square$

Given an oracle for nominal revenue or for the specified worst-case revenue, evaluate each distinct set in (3.1) and select a maximum. This requires at most $|N|$ oracle evaluations after sorting revenues. The witness need not be computed from an unknown optimal $S$. This is an oracle-count statement: computing a general worst-case revenue or a rank-cutoff revenue with growing cutoff can itself be difficult. We do not claim an unconditional polynomial-time robust algorithm.

## 4. Embedding arbitrary utility rank cutoffs

We develop the needed representation directly. Its role is to verify the hypotheses of Theorem 2.2, not to claim novelty for the rank-cutoff model or its probability factorization, which are due to [1].

### 4.1 A finite ranking law and its utility interpretation

Add an outside alternative $0$ with weight $v_0>0$. A random permutation of $N\cup\{0\}$ is generated sequentially: from the remaining alternatives, choose the next alternative with probability equal to its weight divided by their total weight. This defines a probability law, since at each node the transition probabilities sum to one; induction on the number of remaining alternatives normalizes the finite tree. Conditional on the first alternative, the remaining order has the same law on the reduced universe. This is the Plackett–Luce ranking law.

**Lemma 4.1 (Gumbel-to-ranking bridge).** Independent utilities with distribution functions

$$\Pr(U_i\le u)=\exp(-v_i e^{-u}),\qquad i\in N\cup\{0\},\tag{4.1}$$

rank the alternatives according to this finite law, in decreasing utility order.

**Proof.** Set $E_i=e^{-U_i}$. For $t>0$, continuity gives $\Pr(E_i>t)=\exp(-v_it)$; these variables are independent exponentials with rates $v_i$. They have no ties with probability one, and decreasing utilities correspond to increasing $E_i$. If $D$ is the sum of all remaining rates, the probability that $i$ is the first arrival is

$$\int_0^\infty v_i e^{-Dt}\,dt=v_i/D.\tag{4.2}$$

The residual-law statement can be checked without conditioning on a zero-probability event. On the region where $i$ is first, write $E_i=t$ and $E_j=t+s_j$, $s_j>0$. The joint density is

$$v_i e^{-Dt}\prod_{j\ne i}v_j e^{-v_js_j}.$$

Integrating $t$ gives $(v_i/D)\prod_{j\ne i}v_j e^{-v_js_j}$. After division by $v_i/D$, the residuals are independent exponentials with the unchanged remaining rates. Induction proves the sequential ranking law. $\square$

The common-scale Gumbel location parameters are $\log v_i$ in this normalization; a common positive utility scale does not affect ranks. The original model [1] takes $v_0=1$.

Let $K$ be a nonnegative integer-valued cutoff independent of the ranking. Only its truncated value $\min\{K,|N|+1\}$ matters; allowing $K=0$ simply adds a never-purchase type. For an offered set $S$, inspect the first $K$ alternatives in the global ranking. Select the first encountered element of $S\cup\{0\}$ if there is one. Encountering $0$, or reaching the cutoff before encountering any such element, means no purchase. This exactly expresses the utility-rank rule, including unavailable products in the ranking.

### 4.2 Proportionality and the two regularities

For an auxiliary product universe $A\supseteq S\ne\varnothing$, let $D_A=v_0+V(A)$ and define, for integer $k\ge0$,

$$q_0^A(S)=0,$$

$$q_k^A(S)=\frac1{D_A}+\sum_{j\in A\setminus S}\frac{v_j}{D_A}\,q_{k-1}^{A\setminus\{j\}}(S),\qquad k\ge1.\tag{4.3}$$

**Lemma 4.2 (common factor).** With deterministic cutoff $k$ on universe $A$, the purchase probability of every $i\in S$ equals $v_iq_k^A(S)$. For independent cutoff probabilities $\lambda_k$ on the original universe,

$$p_i(S)=v_iq_\lambda(S),\qquad q_\lambda(S)=\sum_k\lambda_k q_k^N(S).\tag{4.4}$$

All probabilities are nonnegative and $V(S)q_\lambda(S)\le1$.

**Proof.** At cutoff zero no product is selected. At a positive cutoff, the first alternative is $i$ with probability $v_i/D_A$, which ends in purchase of $i$. A first alternative in $(S\setminus\{i\})\cup\{0\}$ prevents that purchase. If the first alternative is an unavailable $j\in A\setminus S$, delete $j$ and reduce the cutoff by one. The conditional ranking law proved above is unchanged on the remaining alternatives. Induction on $k$ therefore gives (4.3) multiplied by $v_i$. The expression is independent of the identity of $i$ except for this multiplier. Independence of $K$ permits the mixture in (4.4). The events of purchasing the different products are disjoint, proving the probability bound. $\square$

**Lemma 4.3 (pathwise regularity).** The factor in (4.4) satisfies (P) and (O).

**Proof.** Couple choices from $S\subseteq U$ by the same ranking and cutoff. If a product $i\in S$ is selected from $U$, no earlier offered product or outside alternative occurs before it, and its position is within the cutoff. The same is true after removing $U\setminus S$, so it is also selected from $S$. Hence $p_i(U)\le p_i(S)$; divide by $v_i>0$ to obtain (P).

If some product is purchased from $S$, the first element of $S\cup\{0\}$ is a product within the cutoff. The first element of $U\cup\{0\}$ occurs no later. It cannot be $0$, since that would also precede the purchased product in $S$. It is therefore a product within the cutoff, proving inclusion of the purchase events and (O). The second event argument holds for any fixed ranking law; proportionality is the extra input specific to (4.4). $\square$

**Theorem 4.4 (arbitrary-cutoff half guarantee).** For every finite utility rank-cutoff instance of [1], with nonnegative revenues, positive product weights, and any cutoff distribution independent of the utilities, the best revenue-ordered assortment earns at least half the unconstrained optimal revenue. The guarantee is uniform in the maximum cutoff and in the number of products. More strongly, every comparison assortment has the witness of Theorem 2.2. For an arbitrary family of cutoff distributions and positive outside weights with the same product weights and revenues, Corollary 3.2 holds.

**Proof.** Lemma 4.1 identifies the utility model with the finite law. Lemmas 4.2–4.3 verify every probability and regularity hypothesis; apply Theorem 2.2 and Corollaries 3.1–3.2. Changing the independent cutoff distribution or outside weight changes $q$, but not the common product weights. $\square$

For later calculations, two special cases follow directly. Cutoff one gives $q_1^N(S)=1/D_N$. If $S\ne\varnothing$, cutoff $k\ge |N|$ gives ordinary MNL, $q_k^N(S)=1/(v_0+V(S))$: among the first $|N|$ alternatives at least one belongs to $S\cup\{0\}$, and the earliest element of that set wins its exponential race. These facts also check the endpoint conventions. A cutoff depending on the realized ranking is not covered by the mixture argument.

## 5. Sharpness of the universal constant

The cutoff-two tightness mechanism is already present in [1, Appendix D]. We give an explicit variant of that mechanism and compute its limit so that the upper bound is independently reproducible; no exact change of parameter from their displayed instance is asserted. This is attributed tightness, not a new lower-bound claim.

**Proposition 5.1 (inherited sharpness).** The constant $1/2$ in Theorem 4.4 cannot be increased uniformly over all cutoff distributions and product numbers. The same is true of Corollary 3.2, since a singleton scenario family is allowed.

**Proof.** Take $0<\varepsilon<1$, three products, $v_0=1$, and $K=2$ with probability one. Set

$$r=(\varepsilon^{-1},1,1-\varepsilon),\qquad
v=(1,\varepsilon^{-2},\varepsilon^{-1}),\qquad
D=2+\varepsilon^{-2}+\varepsilon^{-1}.\tag{5.1}$$

Formula (4.3) gives

$$D R(S)=W(S)\left(1+\sum_{j\notin S}\frac{v_j}{D-v_j}\right).\tag{5.2}$$

The distinct threshold sets are $\{1\}$, $\{1,2\}$, and $N$. Compare them with $T=\{1,3\}$. Define $A(S)=\varepsilon^2D R(S)$; direct substitution yields

$$
\begin{aligned}
A(\{1\})&=\varepsilon+\frac1{1+2\varepsilon}
                  +\frac{\varepsilon^2}{1+2\varepsilon^2},\\
A(\{1,2\})&=(1+\varepsilon)
                  \left(1+\frac{\varepsilon}{1+2\varepsilon^2}\right),\\
A(N)&=1+2\varepsilon-\varepsilon^2,\\
A(T)&=(2-\varepsilon)
                  \left(\varepsilon+\frac1{1+2\varepsilon}\right).
\end{aligned}\tag{5.3}
$$

The first three expressions tend to one and the fourth tends to two as $\varepsilon\downarrow0$. Since the optimum is at least $R(T)>0$,

$$
\frac12\le
\frac{\max_{H\in\mathcal H}R(H)}{\max_{S\subseteq N}R(S)}
\le\frac{\max_{H\in\mathcal H}A(H)}{A(T)}\longrightarrow\frac12.
\tag{5.4}
$$

The first inequality follows from Theorem 4.4. A finite maximum preserves convergence, so the squeeze proves sharpness. It is unnecessary to prove that $T$ is optimal for every $\varepsilon$. $\square$

This establishes the best constant for the whole class. It does not establish the best constant separately for each fixed deterministic cutoff $k\ge3$.

## 6. Separating adjacent half-guarantee arguments

### 6.1 A singleton upper benchmark can be arbitrarily loose

For any regular model put $\omega_i=p_i(\{i\})$ and define

$$U^*=\min_{\tau\ge0}\left\{\tau+\sum_i\omega_i(r_i-\tau)^+\right\}.\tag{6.1}$$

This is the singleton benchmark used in [4] for the unrestricted setting. The minimum exists: the objective is continuous, piecewise linear, and at least $\tau$, so it suffices to minimize on a sufficiently large compact interval. It is an upper bound on every assortment revenue: for fixed $\tau$, write revenue as the contribution up to $\tau$ plus positive excess, use total purchase probability at most one, and use $p_i(S)\le\omega_i$. Minimizing preserves the upper bound. Additional assumptions are needed to guarantee an assortment earns a fixed fraction of $U^*$.

**Proposition 6.1 (unbounded singleton-benchmark gap).** Within the independent rank-cutoff model, no universal $c>0$ satisfies $\max_S R(S)\ge cU^*$.

**Proof.** For an integer $m\ge3$, take $m$ products with $v_i=r_i=1$ and one further product with $v=M=m^3$ and $r=1/M$. Let $v_0=1$, $n=m+1$, $D=1+m+M$, and

$$\Pr(K=1)=1-2/m,\qquad\Pr(K=n)=2/m.$$

By the endpoint calculations after Theorem 4.4,

$$q(S)=a+\frac b{1+V(S)},\qquad a=\frac{1-2/m}{D},\quad b=2/m.\tag{6.2}$$

Each high-revenue singleton has probability $a+b/2$, and

$$m(a+b/2)=1+(m-2)/D>1.$$

For $0\le\tau\le1$, the contribution of those $m$ products alone makes the expression in (6.1) at least $\tau+[1+(m-2)/D](1-\tau)\ge1$. For $\tau\ge1$ the expression is at least $\tau\ge1$, while $\tau=1$ attains one. Thus $U^*=1$.

A set of $k$ high-revenue products without the low-revenue product earns $k[a+b/(1+k)]$. Its increment from $k$ to $k+1$ is $a+b/[(k+1)(k+2)]>0$. A set containing the low-revenue product and $k$ high-revenue products earns $(k+1)[a+b/(1+M+k)]$. Its increment is $a+bM/[(1+M+k)(2+M+k)]>0$. Consequently the optimum is the larger of

$$R_{\rm high}=\frac{m-2}{D}+\frac2{m+1},\qquad
R_{\rm all}=\frac{m+1}{D}.\tag{6.3}$$

Their difference is $2/(m+1)-3/D>0$, because $2M>m+1$. Therefore the first is optimal, and it tends to zero as $m\to\infty$. Combined with $U^*=1$, this proves the claim. $\square$

An especially small rational certificate uses eight high-revenue products, $M=1024$, and cutoff probabilities $3/4,1/4$. The same calculation gives $U^*=1$ and $R^*=2120/9297<1/2$. This certificate uses the same construction with a different $M$; it is not the $m^3$ specialization.

This separation does not imply a bad revenue-ordered ratio: the high-revenue threshold set is optimal in the family above. It explains why a proof relative to actual optimal revenue can succeed where a fixed positive factor of the singleton upper bound is impossible.

### 6.2 A small nonlinear-denominator and odds certificate

Take three products with $v=(1,1,97)$, $v_0=1$, and $\Pr(K=1)=9/10$, $\Pr(K=3)=1/10$. Equation (4.4) gives

$$q(S)=\frac9{1000}+\frac1{10(1+V(S))}.$$

In particular, the values on $N,\{1\},\{1,2\},\{1,3\}$ are respectively

$$\frac1{100},\quad\frac{59}{1000},\quad\frac{127}{3000},\quad\frac{991}{99000}.$$

Their reciprocal mixed difference is

$$\frac1{q(N)}+\frac1{q(\{1\})}-\frac1{q(\{1,2\})}-\frac1{q(\{1,3\})}
=-\frac{48800700}{7425563}\ne0.\tag{6.4}$$

Any fixed-numerator model with a denominator affine in product-inclusion indicators has zero mixed difference here. If its positive numerators represent the probabilities of this example on all assortments, the ratios on $N$ force those numerators to be one common multiple of $v_i$; rescaling does not change the zero-difference condition. Thus this example has no such representation. This excludes the relevant fixed shadow-attraction denominator representation used for the GAM specialization in [3], without claiming to exclude arbitrary mixtures of those models.

For revenues $(1,1,1/100)$ the singleton-based auxiliary MNL threshold is $\tau=59/559$, with set $\{1,2\}$. Indeed, for $w=\omega_1=\omega_2=59/1000$, we have $2w(1-\tau)=\tau$ and $r_3<\tau$. Thus $\sum_{i\in S}\omega_i(r_i-\tau)\le\tau$ for every $S$, with equality on $\{1,2\}$, which certifies auxiliary MNL optimality. On that set the product-1 purchase-to-outside odds are $127/2746<59/1000=\omega_1$. The sufficient inequality requiring those odds to dominate the singleton probability in [3, v3, Theorem 5] therefore fails here. Theorem 2.2 still applies. Both (6.4) and the odds comparison are exact rational computations, not numerical fits.

### 6.3 The search-cost model has different hypotheses

In the homogeneous model of Wang and Şahin [5], a deterministic consideration set $\Psi(S)\subseteq S$ is chosen using expected utility and search cost before the random utilities are realized. Offered product $i$ then has probability

$$\frac{a_i\mathbf1\{i\in\Psi(S)\}}{a_0+\sum_{j\in\Psi(S)}a_j}.$$

Their Example 2 has $a_0=1$, $a=(11,8,7)$ and transformed cost $\widetilde w=3/4$. For completeness, normalize the utility scale to one, so $w=\log(7/4)$, and maximize $\log(1+\sum_{i\in T}a_i)-w|T|$ over $T\subseteq S$. Equivalently maximize $(1+\sum_{i\in T}a_i)/(7/4)^{|T|}$. On $S=\{2,3\}$, the best values for cardinalities $0,1,2$ are $1,36/7,256/49$, respectively, so the unique maximizer is $\{2,3\}$. On $S=N$, the corresponding values for cardinalities $0,1,2,3$ are $1,48/7,320/49,1728/343$, so the unique maximizer is $\{1\}$. Purchase probability therefore decreases from $15/16$ to $11/12$ on expansion, violating (O).

Conversely, with two products, $v_0=v_1=v_2=1$ and cutoff one, every offered product has probability $1/3$ in every assortment containing it. A homogeneous search-cost representation would have to put every offered product in its consideration set, because every such probability is positive. It would then be ordinary positive-attraction MNL, where adding product 2 strictly decreases product 1's probability. That contradicts the constant $1/3$. Hence neither of these two model classes contains the other. The heterogeneous market-share guarantee in [5, Theorem 2] has a different objective from the nonuniform-revenue statement here.

### 6.4 A rank-cutoff instance outside single MDM

We use only the following necessary property of the MDM in [12]: for any two assortments, including the always-available outside alternative, the probabilities of their common alternatives cannot move in strictly opposite directions. To see the obstruction directly at positive probabilities, write the marginal optimality condition as $g_i(p_i(S))=\lambda_S$, where $g_i(x)=\nu_i+F_i^{-1}(1-x)$ is strictly decreasing under the marginal assumptions of [12]. If $p_i(A)>p_i(B)$, then $\lambda_A<\lambda_B$; if simultaneously $p_j(A) \lt p_j(B)$ for another common alternative, then $\lambda_A>\lambda_B$, a contradiction. The same no-reversal implication follows from the characterization in [12, Section 3].

There is a direct link to the half theorem in [11]: the representation used in [11, Proposition 2 and (MDM-AO)] makes each $p_j$ nondecreasing in $p_0$. Under their Assumption 1 it has the form $p_j(S)=h_j(p_0(S))$, with $h_j(x)=1-F_j(F_0^{-1}(1-x)-\nu_j)$. Nondecreasing CDFs and quantiles imply that $h_j$ is nondecreasing; strict monotonicity is unnecessary. Thus an increase in the outside probability together with a strict decrease in a common product's probability is also impossible for the representation used in [11, Corollary 2].

**Proposition 6.2 (single-MDM exclusion).** There is a rank-cutoff model satisfying Theorem 4.4, with $\Pr(K=3)>0$, whose probabilities on all assortments have no single-MDM representation of the kind in [12].

**Proof.** Take $v_0=1$, $v=(1,1,1,5/2)$, $\Pr(K=2)=9/10$, and $\Pr(K=3)=1/10$. Let $A=\{1,2,3\}$ and $B=\{1,4\}$. Both cutoffs give $q(A)=1/4$, because there is only one unavailable product. Formula (4.3) gives $q_2(B)=30/143$, while cutoff three reaches an available alternative and gives $q_3(B)=2/9$. Therefore

$$
p_1(A)=p_0(A)=\frac14,\qquad
p_1(B)=q(B)=\frac{1358}{6435}<\frac14,\qquad
p_0(B)=\frac{1682}{6435}>\frac14.
\tag{6.5}
$$

Alternatives 1 and 0 occur in both augmented assortments and exhibit the prohibited strict reversal. Every probability used here lies strictly between zero and one. This proves the exclusion. $\square$

The same strict reversal violates the direct necessary condition from [11, Proposition 2 and (MDM-AO)], excluding application of its single-MDM half theorem by model inclusion. This is a model-distinction certificate. It does not make the broader MDM literature obsolete, and an arbitrary mixture need not preserve the single-MDM order condition. In particular, the $G$-dependent mixed-model guarantee in [11, Theorem 6] is not a uniform half guarantee when $G$ is unrestricted.

### 6.5 The constant-threshold focal-MNL half theorem has different scope

For the ctFMNL model in [13, equations (2) and (5)], put $S^+=S\cup\{0\}$. The attractions $a_i>0$, focal parameter $\delta\ge0$, and threshold parameter $w\ge0$ are fixed across assortments. The focal set, effective attractions, and choice probabilities are

$$
\begin{aligned}
F(S^+)&=\{i\in S^+:(1+w)a_i\ge\max_{j\in S^+}a_j\},\\
b_i(S)&=a_i\bigl(1+\delta\mathbf1\{i\in F(S^+)\}\bigr),\\
\pi_i(S)&=\frac{b_i(S)}{\sum_{j\in S^+}b_j(S)}.
\end{aligned}
\tag{6.6}
$$

The half guarantee in [13, Theorem 2(ii)] assumes this constant-$\delta$ structure. Theorem 3 instead gives an FPTAS for linear focal parameters, extended to certain functions of their sum. The broader regular tFMNL class of Section 5 is used in Proposition 1 and Theorem 4 for adjustable prices: its conditions concern a nondecreasing focal parameter and the effect of price increases on focal membership. They are not (P) and (O).

**Proposition 6.3 (ctFMNL exclusion).** There is a two-product rank-cutoff model satisfying Theorem 4.4 whose probabilities on all assortments have no ctFMNL representation (6.6).

**Proof.** Let $v_0=v_1=v_2=1$ and $K=1$ surely. Formula (4.4) gives $q(S)=1/3$ for every nonempty $S\subseteq\{1,2\}$. Each offered product therefore has probability $1/3$ in its singleton assortment and in the two-product assortment.

Suppose (6.6) represented these probabilities. In the two-product assortment, if $a_1>a_2$, threshold membership implies $\mathbf1\{1\in F(S^+)\}\ge\mathbf1\{2\in F(S^+)\}$, and hence $b_1(S)>b_2(S)$ because $\delta\ge0$. This contradicts equality of the two product probabilities. The reverse strict order gives the same contradiction, so $a_1=a_2$.

It follows that the maximum attraction among the offered products and the outside alternative is the same for $S=\{1\}$ and $S=\{1,2\}$. The focal memberships and effective attractions of alternatives 0 and 1 are unchanged; product 2 has the same effective attraction as product 1. Writing these positive effective attractions as $b_0$ and $b$, respectively, gives

$$
\pi_1(\{1\})=\frac{b}{b_0+b}
>\frac{b}{b_0+2b}=\pi_1(\{1,2\}),
\tag{6.7}
$$

contradicting the required equality to $1/3$. Thus no such representation exists. $\square$

This proves non-containment in the specific class covered by the static ctFMNL half theorem. We make no exclusion claim for general FMNL with assortment-dependent focal parameters or focal sets, and no converse containment claim.

## 7. Reproduction and scope

The accompanying exact-arithmetic program enumerates finite Plackett–Luce rankings and independently evaluates the first-step recurrence. It checks proportionality, both regularities, the common threshold for every comparison subset in its finite test suite, and the robust optimum over finite scenario collections. It also checks the displayed rational separation certificates and several members of the tight family. These finite calculations detect implementation or transcription errors; the universal theorems rest on the written arguments above.

All mathematical claims needed for Theorem 4.4 are explicit: normalization and conditioning of the finite ranking law, the Gumbel bridge, the factor recurrence, regularity, the weighted-set inequality, and finite candidate selection. Full future formalization must preserve those links rather than assume the desired model embedding as an unproved hypothesis. No Lean source, compilation result, kernel certificate, or external review is represented by the present manuscript.

The limitations are substantive. Nonnegative revenues, positive weights, shared relative product weights across scenarios, and independence of the cutoff from the realized ranking are retained. Capacity restrictions, learning from data, changing product preferences, dynamic inventory decisions, and oracle complexity under arbitrary uncertainty are not solved here. The universal tightness result does not determine every fixed-cutoff subclass. Finally, the literature comparisons establish distinctions within a documented search; they are not a proof of worldwide priority.

## References

1. Y. Bai, J. Feldman, H. Topaloglu, L. Wagner. *Assortment Optimization Under the Multinomial Logit Model with Utility-Based Rank Cutoffs*. Operations Research 72(4), 1453–1474 (2024). [DOI: 10.1287/opre.2021.0060](https://doi.org/10.1287/opre.2021.0060). Author manuscript, 29 September 2023, especially Theorem 3.1 and Appendix D: [full text](https://people.orie.cornell.edu/huseyin/publications/small_consideration_mnl.pdf).
2. G. Berbeglia, G. Joret. *Assortment Optimisation under a General Discrete Choice Model: A Tight Analysis of Revenue-Ordered Assortments*. Algorithmica 82, 681–720 (2020). [DOI: 10.1007/s00453-019-00610-8](https://doi.org/10.1007/s00453-019-00610-8); [preprint](https://arxiv.org/abs/1606.01371).
3. G. Gallego, G. Berbeglia. *The Limits of Personalization in Assortment Optimization*. [arXiv:2109.14861v5](https://arxiv.org/abs/2109.14861v5), 2024. Earlier [v3](https://arxiv.org/abs/2109.14861v3), 2022: *Bounds, Heuristics, and Prophet Inequalities for Assortment Optimization*. Versions are compared explicitly; neither is cited as a newly verified journal publication.
4. G. Gallego, P. Gao, S. Wang, G. Berbeglia. *Assortment Optimization with Downward Feasibility: Efficient Heuristics Based on Independent Demands*. Author preprint revised 11 January 2025. [DOI: 10.2139/ssrn.5021867](https://doi.org/10.2139/ssrn.5021867). Full author-uploaded text examined, including the singleton benchmark and bounding conditions.
5. R. Wang, Ö. Şahin. *The Impact of Consumer Search Cost on Assortment Planning and Pricing*. Management Science 64(8), 3649–3666 (2018). [DOI: 10.1287/mnsc.2017.2790](https://doi.org/10.1287/mnsc.2017.2790). Author PDF linked from [research page](https://sites.google.com/view/ruxianwang/research).
6. P. Rusmevichientong, H. Topaloglu. *Robust Assortment Optimization in Revenue Management Under the Multinomial Logit Choice Model*. Operations Research 60(4), 865–882 (2012). [DOI: 10.1287/opre.1120.1063](https://doi.org/10.1287/opre.1120.1063); [author text](https://people.orie.cornell.edu/huseyin/publications/logit_robust.pdf).
7. B. Sturt. *The Value of Robust Assortment Optimization Under Ranking-Based Choice Models*. Management Science 71(5), 4246–4265 (2025). [DOI: 10.1287/mnsc.2021.04059](https://doi.org/10.1287/mnsc.2021.04059); [author preprint v4](https://arxiv.org/html/2112.05010v4).
8. M. Lu, Y. Han, H. Zhong, Z. Zhou, J. Blanchet. *Robust Assortment Optimization from Observational Data*. [arXiv:2602.10696v3](https://arxiv.org/html/2602.10696v3), 2026. Preprint; nominal-MNL ambiguity-set comparison.
9. J. Feldman, Y. Huang, H. Zhang. *Inventory and Assortment Optimization under General Choice: A Unified Approximation Framework*. [arXiv:2611.05708v1](https://arxiv.org/html/2611.05708v1), 2026. Preprint; static-oracle assumption in Section 2.2.
10. S. Sun, R. Udwani. *Dynamic Assortment Optimization Under Arbitrary Demand Distributions: The Uniform Price Setting*. [arXiv:2611.18421v1](https://arxiv.org/pdf/2611.18421v1), 2026. Preprint; Theorems 1–3, Remark 9 and Section 5.
11. Z. Sun, S. D. Ahipasaoglu, X. Li, Y. Ruan. *A Unified Analysis for Assortment Planning with Multi-Purchase Using Marginal Distribution Models*. Author preprint, revised 22 August 2026, 60 pages. [DOI: 10.2139/ssrn.3638783](https://doi.org/10.2139/ssrn.3638783); [full author text](https://papers.ssrn.com/sol3/Delivery.cfm?abstractid=3638783). Examined Section 2.2, Section 4, Section 5 including Assumption 1, Proposition 2, (MDM-AO), Theorem 6 and Corollary 2, and the complete proofs in Appendices C.6 and C.12.
12. Y. Ruan, X. Li, K. Murthy, K. Natarajan. *A Nonparametric Approach with Marginals for Modeling Consumer Choice*. Management Science, published online 21 May 2026. [DOI: 10.1287/mnsc.2023.02287](https://doi.org/10.1287/mnsc.2023.02287). Examined author version: [arXiv:2208.06115v6](https://arxiv.org/html/2208.06115v6), 14 April 2025. Section 3 gives the MDM representation and common-option ordering conditions; the outside alternative is included as an always-available option.
13. L. Guan, K. Nip, R. Wang, L. Zhang. *The Focal Multinomial Logit Model: Threshold Effects on Consumer Choice, Assortment, Pricing and Estimation*. Manufacturing & Service Operations Management 28(3), 822–840 (2026), published online 29 December 2025. [DOI: 10.1287/msom.2023.0381](https://doi.org/10.1287/msom.2023.0381). Examined [SSRN author manuscript 4495817](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4495817), written 2 December 2025, revised 13 December 2025, 79 pages: Section 3.1, equations (2) and (5), Theorems 2–4, Proposition 1, and the complete Appendix A proof of Theorem 2(ii).
