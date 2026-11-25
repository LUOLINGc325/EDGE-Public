# Stockout calibration for prophet secretary

*The exact performance curve and the Arnosti–Ma conjecture*

Research manuscript · 24 November 2026

## Abstract

A static threshold allocates at most $k$ identical units to the first eligible applicants in a random arrival order. Arnosti and Ma conjectured that setting the probability of exhausting the units to $\Pr\{\operatorname{Pois}(k)\ge k\}$ guarantees the sharp static-threshold factor $1-e^{-k}k^k/k!$. We prove this conjecture for arbitrary independent, nonnegative, integrable values, including distributions with atoms. More generally, we determine the exact worst-case guarantee for every prescribed stockout probability $\beta\in(0,1)$, against both the offline prophet and the stronger ex-ante relaxation. The guarantee is the minimum of two elementary Poisson expectations, and its unique maximizer is the proposed calibration. Matching limiting examples can be chosen IID. The proof combines classical relative log-concavity with a comparison at an equal-tail cut and the established utilization/acceptance-rate reduction. We do not claim these probability tools or the general reduction as new. This is an unrefereed research manuscript with bounded literature review and reproducible checks.

## 1. The question and the contribution

Suppose $n$ applicants arrive one at a time and at most $k$ can be accepted. An accepted applicant gives its observed value; a rejected applicant cannot be recalled. A static threshold is easy to explain: accept the first $k$ applicants above a fixed eligibility level. The level must balance unused capacity against accepting ordinary values before unusually valuable applicants arrive.

Arnosti and Ma [1, Section 5.2, printed p. 24] ask whether a threshold chosen from the **probability of running out of units** can achieve their sharp factor. Their proposed stockout probability is slightly above one half for large capacities. The question concerns the paper's independent, random-arrival model, and is not restricted to identically distributed values.

Our main result proves the precise stockout conjecture. A stronger result gives the whole stockout-calibrated performance curve and its sharpness. The novelty claimed here is limited to this application and its exact stockout parameterization. The constant itself, the optimality of that constant for all static thresholds, the utilization-based curve, and the two-risk proof architecture are already present in [1]. Relative log-concavity and sign-change comparisons are classical [2]; a closely related equal-tail comparison appears in [3]. Section 8 records these distinctions.

The intended reader has master's-level probability: independence, expectation, distribution functions, and elementary convergence of binomial probabilities. The only structural inequality imported is the classical Newton inequality for a real-rooted polynomial with nonnegative coefficients. Its exact use is displayed below.

## 2. Model and main theorem

Fix integers $n\ge k\ge1$. The values $V_1,\ldots,V_n$ are independent, nonnegative random variables with finite expectations. The arrival order is a uniform random permutation independent of the values. A policy is specified by $t\ge0$ and $\theta\in[0,1]$: values greater than $t$ are eligible, and values equal to $t$ are eligible with probability $\theta$, using independent coins. All coins are independent of the values and arrival order. The policy accepts the first $k$ eligible applicants.

Write

$$
B_i=\mathbf1_{\{V_i>t\}}+\mathbf1_{\{V_i=t\}}C_i,
\qquad D=\sum_{i=1}^n B_i,
$$

where $C_i\sim\operatorname{Bernoulli}(\theta)$. The number $D$ is a sum of independent Bernoulli variables, also called a Poisson-binomial variable. Its stockout probability is $\Pr(D\ge k)$.

Let $\mathrm{ALG}$ be expected policy reward, and $\mathrm{OPT}$ the expected sum of the $k$ largest values. Define the ex-ante relaxation by

$$
\mathrm{LP}
=\sup\left\{\sum_i\mathbb E[V_i x_i(V_i)]:
0\le x_i\le1,\ \sum_i\mathbb E x_i(V_i)\le k\right\}.
$$

Here each $x_i$ is measurable. This relaxation limits capacity in expectation. Conditioning the offline selection indicators on each applicant's own value shows $\mathrm{OPT}\le\mathrm{LP}$.

For $Z_\lambda\sim\operatorname{Pois}(\lambda)$, define

$$
b_k(\lambda)=\Pr(Z_\lambda\ge k),\qquad
u_k(\lambda)=\frac{\mathbb E\min(Z_\lambda,k)}{k},
\qquad
a_k(\lambda)=\mathbb E\min\left(1,\frac{k}{Z_\lambda+1}\right).
$$

The function $b_k$ increases continuously from zero to one. Thus each $\beta\in(0,1)$ specifies a unique $\lambda>0$ with $b_k(\lambda)=\beta$.

**Theorem 1 (exact stockout guarantee).** For every policy in the stated model with $\Pr(D\ge k)=\beta$,

$$
\mathrm{ALG}\ \ge\ G_k(\beta)\,\mathrm{LP}
\ \ge\ G_k(\beta)\,\mathrm{OPT},
\qquad
G_k(\beta)=\min\{u_k(\lambda),a_k(\lambda)\}.
\tag{1}
$$

For fixed $k,\beta$, the infimum of either ratio over all finite instances with positive benchmark is exactly $G_k(\beta)$. The same infimum holds when values are required to be IID. Consequently this is an exact worst-case curve, not only a lower estimate.

**Corollary 2 (Arnosti–Ma stockout conjecture).** The unique stockout level maximizing $G_k$ is

$$
\beta_k=b_k(k)=\Pr\{\operatorname{Pois}(k)\ge k\}.
$$

At that calibration,

$$
\mathrm{ALG}\ge\gamma_k\,\mathrm{LP}
\ge\gamma_k\,\mathrm{OPT},
\qquad
\gamma_k=1-e^{-k}\frac{k^k}{k!}.
\tag{2}
$$

The ratio language in the infimum assumes a positive benchmark. If it is zero, the multiplicative statements remain valid. If $n<k$, accept everyone; exact positive stockout calibration is unnecessary and impossible.

## 3. Comparing counts at the same tail probability

The next lemma isolates the classical comparison mechanism, with an explicit treatment of equality points.

**Lemma 3 (comparison at a calibrated cut).** Let $p_j,q_j$ be probability mass functions on the nonnegative integers, with $q_j>0$ for every $j$. Suppose

$$
I=\{j:p_j\ge q_j\}
$$

is an integer interval. For $m\ge0$, assume $\sum_{j=0}^m p_j=\sum_{j=0}^m q_j$. Then

$$
\sum_{i=0}^j p_i\le\sum_{i=0}^j q_i\quad(0\le j\le m),
\qquad
\sum_{i=0}^j p_i\ge\sum_{i=0}^j q_i\quad(j\ge m).
\tag{3}
$$

**Proof.** Put $d_i=p_i-q_i$ and $H(j)=\sum_{i=0}^j d_i$. We have $\sum_i|d_i|\le2$, total sum zero, and $H(m)=0$.

Suppose $j<m$ and $H(j)>0$. Some $i\le j$ has $d_i>0$. The tail after $m$ sums to zero, so it contains an index $s>m$ with $d_s\ge0$: if all its terms were strictly negative, its sum would be strictly negative. Since $I$ is an interval, every term from $j+1$ to $m$ is nonnegative. Thus $H(m)\ge H(j)>0$, a contradiction.

Suppose instead $j>m$ and $H(j)<0$. The tail after $j$ has positive sum, so some $s>j$ has $d_s>0$. The finite, nonempty prefix through $m$ sums to zero, hence contains $i\le m$ with $d_i\ge0$. The interval property makes every term from $m+1$ to $j$ nonnegative, contradicting $H(j)<0$. Equality at $j=m$ is the hypothesis. $\square$

The weak inequality in the definition of $I$ matters. Merely asserting that the nonzero signs of $d$ are negative, positive, negative is insufficient: the sequence $(0,-1,2,-1)$ has a zero initial prefix followed by a negative prefix. Its nonnegative set is not an interval. The argument above excludes this equality-point error.

**Lemma 4 (Poisson-binomial comparison).** If $D$ is a finite sum of independent Bernoulli variables and

$$
\Pr(D\ge k)=\Pr(Z_\lambda\ge k),
$$

then

$$
F_D(j)\le F_{Z_\lambda}(j)\quad(j\le k-1),
\qquad
F_D(j)\ge F_{Z_\lambda}(j)\quad(j\ge k-1).
\tag{4}
$$

**Proof.** Let $p_j=\Pr(D=j)$ and $q_j=e^{-\lambda}\lambda^j/j!$. When all Bernoulli parameters belong to $(0,1)$, the generating polynomial is

$$
\sum_{j=0}^n p_j z^j
=\prod_{i=1}^n(1-p_i^{\mathrm{Ber}}+p_i^{\mathrm{Ber}}z).
$$

All roots are real and negative. Newton's inequalities give, for $1\le j<n$,

$$
\left(\frac{p_j}{\binom nj}\right)^2
\ge
\frac{p_{j-1}}{\binom n{j-1}}
\frac{p_{j+1}}{\binom n{j+1}}.
$$

For $r_j=p_j/q_j$, this implies

$$
r_j^2\ge\frac{n-j+1}{n-j}\,r_{j-1}r_{j+1}
\ge r_{j-1}r_{j+1}.
\tag{5}
$$

Parameters equal to zero or one are covered by continuity of the polynomial coefficients. The positive support is an integer interval, from the number of certain successes to the number of possible successes. Thus $r$ has no internal zeros and is log-concave. On its positive support, the successive differences of $\log r_j$ are nonincreasing, so every superlevel set of $r$ is an interval. In particular, $\{j:r_j\ge1\}$ is an interval. Applying Lemma 3 at $m=k-1$ proves (4). $\square$

This is relative log-concavity with respect to a Poisson distribution. It holds for every $\lambda>0$, not only for $\lambda=\mathbb E D$. Matching the *tail*, rather than the mean, places the comparison at the capacity cut.

Set

$$
U_k(d)=\min(d/k,1),\qquad A_k(d)=\min(1,k/(d+1)).
$$

For any nonnegative integer-valued $Y$,

$$
\mathbb E U_k(Y)
=1-\frac1k\sum_{j=0}^{k-1}F_Y(j),
\tag{6}
$$

and

$$
\mathbb E A_k(Y)
=\sum_{j=k-1}^{\infty}
\frac{k}{(j+1)(j+2)}F_Y(j).
\tag{7}
$$

To see (7), telescope $A_k(d)$ from its successive differences, which vanish below $k-1$ and equal $k/((j+1)(j+2))$ thereafter. Interchanging the nonnegative sums is legitimate; the weights sum to one. Equations (4), (6), and (7) establish both bounds

$$
\mathbb E U_k(D)\ge u_k(\lambda),
\qquad
\mathbb E A_k(D)\ge a_k(\lambda).
\tag{8}
$$

For finite $D$, the second inequality is strict because its distribution function equals one beyond its support while a Poisson distribution still has positive tail mass. For $k\ge2$, the first is also strict. Indeed, equality in (6) would imply $p_0=q_0$ and $p_1=q_1$ using calibration as well. Then $r_0=r_1=1$, and log-concavity forces $r_j\le1$ for all later $j$. The strictly smaller far tail would make the total mass of $p$ less than one. For $k=1$, the first inequality is exactly the calibration equality.

## 4. From count comparison to online reward

We include the established two-risk reduction [1, Lemma 1] to make the proof self-contained. Define $D_{-i}=\sum_{\ell\ne i}B_\ell$ and $S=\sum_i\mathbb E(V_i-t)_+$. Conditional on values and eligibility coins, the eligible applicants have a uniformly random relative order. Splitting reward into threshold value and surplus gives the exact identity

$$
\mathrm{ALG}
=t\,\mathbb E\min(D,k)
+\sum_i \mathbb E(V_i-t)_+\,\mathbb E A_k(D_{-i}).
\tag{9}
$$

An applicant with positive surplus is eligible with certainty. Its surplus is independent of $D_{-i}$, and its conditional acceptance probability is $A_k(D_{-i})$. This proves the surplus part of (9); the threshold part is $t$ times the number accepted.

Since $A_k$ is decreasing and $D_{-i}\le D$, equations (8) and (9) imply

$$
\mathrm{ALG}\ge kt\,u_k(\lambda)+S\,a_k(\lambda)
\ge G_k(\beta)(kt+S).
\tag{10}
$$

For any feasible ex-ante selection, the pointwise inequality

$$
V_i x_i(V_i)\le t\,x_i(V_i)+(V_i-t)_+
$$

shows $\mathrm{LP}\le kt+S$. Combining this with (10) proves (1), without requiring the existence of an ex-ante optimizer.

**Calibration, including atoms.** Let $W$ be the $k$th largest value. A finite quantile $t\ge0$ exists with

$$
\Pr(W>t)\le\beta\le\Pr(W\ge t).
$$

At this $t$, the eligibility probabilities are affine in $\theta$. Therefore the stockout probability is a continuous nondecreasing polynomial in $\theta$, with the displayed probabilities as endpoints. The intermediate value theorem supplies a common $\theta\in[0,1]$ attaining $\beta$. This covers zero values, deterministic values, atoms, and $n=k$. It does not require applicant-specific tie probabilities.

## 5. Evaluating and optimizing the curve

For $\lambda>0$,

$$
b_k(\lambda)=1-e^{-\lambda}
\sum_{j=0}^{k-1}\frac{\lambda^j}{j!},
\qquad
b_k'(\lambda)=e^{-\lambda}\frac{\lambda^{k-1}}{(k-1)!}>0.
\tag{11}
$$

A convenient finite expression is

$$
u_k(\lambda)
=1-\frac{e^{-\lambda}}{k}
\sum_{j=0}^{k-1}(k-j)\frac{\lambda^j}{j!}.
\tag{12}
$$

The elementary Poisson identity $j\Pr(Z_\lambda=j)=\lambda\Pr(Z_\lambda=j-1)$ yields the following relation, already recorded in [1, online appendix, Lemma 7]:

$$
\lambda a_k(\lambda)=\mathbb E\min(Z_\lambda,k)
=k u_k(\lambda).
\tag{13}
$$

Thus the exact curve can be computed by a scalar root and a finite sum:

$$
G_k(\beta)=
\begin{cases}
u_k(\lambda),&0<\lambda\le k,\\
\dfrac{k}{\lambda}u_k(\lambda),&\lambda\ge k.
\end{cases}
\tag{14}
$$

The function $u_k$ is strictly increasing and $a_k$ strictly decreasing. For $\lambda_2>\lambda_1$, couple $Z_{\lambda_2}=Z_{\lambda_1}+Y$ with an independent, nondegenerate Poisson increment. Monotonicity follows from the functions $U_k,A_k$. Strictness follows, respectively, on the positive-probability events $\{Z_{\lambda_1}=0,Y\ge1\}$ and $\{Z_{\lambda_1}=k-1,Y\ge1\}$. Equation (13) proves that the unique maximum of (14) is at $\lambda=k$.

At $\lambda=k$, shifting the finite sum gives

$$
u_k(k)
=\Pr(Z_k\le k-2)+\Pr(Z_k\ge k)
=1-\Pr(Z_k=k-1)=1-e^{-k}k^k/k!,
$$

where the first probability is zero for $k=1$. Equation (13) gives the same value for $a_k(k)$, proving Corollary 2.

The two branches of the exact curve represent unused-capacity and crowding losses; the maximum is at the Poisson capacity calibration.

**Corollary 5 (a certified calibration interval).** If the actual stockout probability is known to lie in $[\beta_-,\beta_+]\subset(0,1)$, put $\lambda_\pm=b_k^{-1}(\beta_\pm)$. Then

$$
\mathrm{ALG}\ge
\min\{u_k(\lambda_-),a_k(\lambda_+)\}\,\mathrm{LP}.
\tag{15}
$$

This is sharp over that interval because the minimum of the increasing-then-decreasing curve is at an endpoint. The claim is conditional on a valid bound on the true stockout probability; it is not a claim about the sample complexity of estimating or selecting a threshold.

## 6. Matching IID examples

Fix $k,\beta$ and its associated $\lambda$. For $n\ge k$, let $r_n\in(0,1)$ be the unique solution of

$$
\Pr\{\operatorname{Bin}(n,r_n)\ge k\}=\beta.
\tag{16}
$$

For any $0<\varepsilon<\lambda$, evaluating the binomial tail at $(\lambda-\varepsilon)/n$ and $(\lambda+\varepsilon)/n$ converges to Poisson tails strictly below and above $\beta$. Monotonicity brackets $nr_n$ between these two parameters for all large $n$. Hence $nr_n\to\lambda$. The variables $\operatorname{Bin}(n,r_n)$ and $\operatorname{Bin}(n-1,r_n)$ both converge to $Z_\lambda$; expectations of the bounded functions used here converge.

**Unused-capacity branch.** Take every value identically equal to one. The calibrated policy must have $t=1$ and tie probability $r_n$. Its reward is $\mathbb E\min(\operatorname{Bin}(n,r_n),k)$, while $\mathrm{OPT}=\mathrm{LP}=k$. Both ratios tend to $u_k(\lambda)$.

**Crowding branch.** For all sufficiently large $n$, set

$$
\varepsilon_n=n^{-3},\qquad M_n=n^4,\qquad
V_i=
\begin{cases}
M_n,&\text{with probability }\varepsilon_n,\\
1,&\text{otherwise},
\end{cases}
$$

independently and identically. Use $t=1$ and

$$
\theta_n=\frac{r_n-\varepsilon_n}{1-\varepsilon_n}.
$$

This belongs to $(0,1)$ eventually because $nr_n\to\lambda>0$, and gives eligibility probability $r_n$. Put $H_n\sim\operatorname{Bin}(n,\varepsilon_n)$. Direct conditioning gives

$$
\mathrm{ALG}
=\bigl[nr_n+n\varepsilon_n(M_n-1)\bigr]\,
\mathbb E A_k(\operatorname{Bin}(n-1,r_n)),
\tag{17}
$$

$$
\mathrm{LP}=k+n\varepsilon_n(M_n-1),\qquad
\mathrm{OPT}=k+(M_n-1)\mathbb E\min(H_n,k).
\tag{18}
$$

The ex-ante formula accepts every high value and fills the remaining expected capacity with unit values. For integer $h\ge0$ and $k\ge1$, $(h-k)_+\le h(h-1)/2$. Consequently

$$
0\le n\varepsilon_n-\mathbb E\min(H_n,k)
\le\frac{n(n-1)}2\varepsilon_n^2=O(n^{-4}).
$$

The difference between the two benchmarks is $O(1)$, whereas both grow as $n^2$. Equations (17) and (18), together with $nr_n\to\lambda$, show that both reward ratios tend to $a_k(\lambda)$.

There is no unfavorable arbitrary tie choice hidden in either example. In the second family, thresholds below one have stockout probability one. Thresholds above one have stockout probability at most $\Pr(H_n\ge k)\to0$. Thus every policy calibrated to fixed $\beta$ must eventually use $t=1$ and the specified unique tie probability.

The universal lower bound and these two limiting IID families prove the exact infima in Theorem 1. Each example has finite expectations; the infimum need not be attained at finite $n$. For $k\ge2$, Section 3 in fact gives strict improvement over $\gamma_k$ for every individual finite instance with positive benchmark at the optimal calibration.

If atomless values are desired, replace each unit atom by a uniform distribution on $[1,1+\eta_n]$ and each high atom by one on $[M_n,M_n+\eta_n]$, with $\eta_n\downarrow0$ and the two intervals disjoint. For a low value, use the same independent uniform variable $T_i$ to set its perturbed value to $1+\eta_n T_i$ and its original tie coin to $\mathbf1_{\{T_i>1-\theta_n\}}$. The threshold $1+\eta_n(1-\theta_n)$ then preserves the entire eligibility vector. Couple high values by adding an independent amount in $[0,\eta_n]$; they remain eligible. In the constant-value family use $\theta_n=r_n$ in the same construction. Coupling changes each policy or offline reward by at most $k\eta_n$; conditioning ex-ante choices on the unperturbed value gives the same bound for that benchmark. The limiting ratios are unchanged.

## 7. Verification and scope

The mathematical proof covers all $k\ge1$, all finite $n\ge k$, heterogeneous independent values, and randomized treatment of atoms. It requires an independent uniform arrival order. It does not establish the result for correlated values or adversarial arrival orders.

The accompanying code recomputes the curve, the two sharpness families, and exact rational comparisons for selected Poisson-binomial laws. An independently written stress test checks heterogeneous and degenerate Bernoulli parameters. These finite computations are checks of formulas and boundary handling, not proofs of the universally quantified theorem.

The original manuscript reports partial Lean verification of the finite signed-sum comparison underlying Lemma 3, including equality points. Newton's inequality, the probability distributions, the infinite Poisson sums, the online model, and the asymptotic sharpness constructions are not claimed to be end-to-end formalized.

This AI-assisted manuscript has not undergone external peer review. The computation files and Lean source are not included in this edition; no new compilation is claimed.

## 8. Relation to prior work and bounded novelty statement

Arnosti–Ma [1] already establish $\gamma_k$ as the sharp worst-case factor for static thresholds, prove the utilization/acceptance-rate reduction, give an optimal expected-utilization rule, discuss its tight performance curve, and use low-value/rare-high-value extremal constructions. Their Section 5.2 leaves the proposed stockout rule as a conjecture. We prove that rule and give its exact curve as a function of stockout probability; we do not claim the constant, reduction, or extremal construction pattern.

Yu [2, Section 2.1 and Section 3, Lemma 1] explains Poisson-relative log-concavity of Bernoulli sums and the classical change-of-sign mechanism. Equal-mean convex-order results do not directly locate a crossing at a prescribed capacity; here calibration supplies that location. Braida, Bermot, and Apers [3, Section 4.2, Lemma 14] explicitly compare tails under relative log-concavity and tail-mass calibration in a spectral-gap application. Lemma 3 is presented as a self-contained version of this existing comparison principle, with equality points and the infinite positive Poisson tail handled explicitly.

The recorded search found no earlier proof of the stockout conjecture or the exact stockout-parameterized guarantee in the checked material. This is a bounded literature finding, not a worldwide priority certificate. The original authors currently link the verified arXiv author manuscript as the open full text of the journal article; the publisher's official online appendix was also checked. The separately typeset final main article was not obtained, so its word-for-word agreement with the author manuscript is not certified. The audit records these version boundaries and the exact reading scope.

## References

1. Nick Arnosti and Will Ma. *Tight Guarantees for Static Threshold Policies in the Prophet Secretary Problem*. Operations Research 71(5), 1777–1788 (2023). [DOI: 10.1287/opre.2022.2419](https://doi.org/10.1287/opre.2022.2419). Proof interfaces and open question checked in [arXiv:2108.12893v2](https://arxiv.org/abs/2108.12893v2), [author-hosted full text](https://www.columbia.edu/~wm2428/papers/prophet_secretary.pdf).

2. Yaming Yu. *Relative log-concavity and a pair of triangle inequalities*. Bernoulli 16(2), 459–470 (2010). [DOI: 10.3150/09-BEJ216](https://doi.org/10.3150/09-BEJ216). [Author reprint, arXiv:1010.2043](https://arxiv.org/abs/1010.2043).

3. Arthur Braida, Elie Bermot, and Simon Apers. *Log-Concavity and Tunneling: Quantum Adiabatic Algorithm for Convex Functions (With a Spike)*. ESA 2026, LIPIcs 388, Article 110. [DOI: 10.4230/LIPIcs.ESA.2026.110](https://doi.org/10.4230/LIPIcs.ESA.2026.110). [Published full text](https://drops.dagstuhl.de/storage/00lipics/lipics-vol388-esa2026/html/LIPIcs.ESA.2026.110/LIPIcs.ESA.2026.110.html); comprehensive version [arXiv:2606.23614](https://arxiv.org/abs/2606.23614).
