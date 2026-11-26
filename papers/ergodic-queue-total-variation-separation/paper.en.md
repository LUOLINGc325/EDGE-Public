# Stable FCFS queues with maximal total-variation separation

## Bounded rational input, geometric absolute regularity, and a minimum-driven workload

Research manuscript, 26 November 2026. This manuscript has not undergone external peer review. Formal proof-assistant verification has not been completed.

## Abstract

We construct a strictly subcritical first-come-first-served two-server queue whose input is bounded, strictly positive, rational-valued, geometrically absolutely regular, and regenerative, but whose empty-start workload distribution has total-variation distance one from the minimal stationary law at every finite arrival index. The utilization is exactly $13/16$. A three-phase countable Markov environment has an explicit three-step Doeblin minorization; its edge observations give the arrival and service inputs. The stationary workload is a graph over this environment. A split service step preserves a two-step recursion in which the initialization deficit is a running minimum of independent positive marks. A difference-free support makes all finite-time workloads avoid a single set carrying the entire minimal stationary law. Nevertheless the workload converges under the synchronous coupling, and its finite-order Wasserstein distances decay at a matching polynomial rate. We also give a general bounded-potential embedding and a unit-interarrival counterexample with exactly three service values. The constructions answer negatively the stationary-ergodic conjecture stated in Foss (2009, Section 1.1). Literature priority is limited to the sources actually inspected; the full text of Foss's directly related 2022 note was not available.

## 1. The precise question and contribution

For a first-come-first-served (FCFS) queue with $m$ identical unit-speed servers, let $\sigma_n$ be the service requirement of customer $n$ and let $\tau_n$ be the time until customer $n+1$. The Kiefer-Wolfowitz vector records the ordered virtual workloads immediately before arrival $n$. Under jointly stationary ergodic input, the usual strict load inequality is

$$
\mathbb E\sigma_0 \lt m\mathbb E\tau_0.
$$

Foss [F09, Section 1.1] asks whether this assumption, with an empty initial system, is sufficient for convergence in total variation to the **minimal** stationary workload law. The note distinguishes this question from weak convergence and from the possible existence of other stationary regimes. Its Section 1.1 does not require independent service times, independence of service and interarrival sequences, or a nonlattice assumption. Independence assumptions introduced in its later Section 1.2 concern a different question.

Our main result disproves the precise Section 1.1 assertion already for $m=2$. The strongest construction has rational input with a countable alphabet, interarrival times in $\{1/2,1\}$, utilization $13/16$, and an explicit geometric $\beta$-mixing bound. It even has observable regenerative input cycles. The obstruction is not a failure of input mixing: the workload recursion retains a positive finite-history minimum that tends to zero without ever reaching zero. An arithmetic separation of supports turns this pathwise fact into maximal distributional separation. A separate construction has deterministic interarrivals and a three-value service alphabet, but that construction is only claimed to be stationary ergodic.

The general fact that weak convergence does not imply total-variation convergence is classical. So are irrational rotations, Loynes backward iteration, Doeblin coupling, and nonuniqueness phenomena under dependent input. The new mathematical content asserted here is their exact realization in the stated FCFS recursion, including identification of the minimal stationary law, maximal separation at every finite index, and the stronger rational mixing and regenerative realization. No uniqueness claim for all stationary regimes is needed.

### 1.1 Related results and source limitations

The original question is [F09]. The title and publication details of the directly related note [F22] are verified, but its full text was not obtained. We therefore neither attribute a theorem to [F22] nor claim an exhaustive search or certified global priority. The source-specific status is recorded in the accompanying source and novelty files.

Baccelli, Foss, and Mairesse [BFM96, Section 3.1] describe dependent-network phenomena, including multiple stationary regimes and periodic examples. Those phenomena are not, by themselves, the empty-start/minimal-law separation proved here. Foss and Sapozhnikov [FS06] develop total-variation convergence results using additional hypotheses, including positive-probability renovating events; their multiserver application uses independent identically distributed primitive sequences. Our example does not satisfy those independence assumptions. Section 8 explains explicitly why input regeneration does not renovate the workload.

Araman and Glynn [AG25] show how dependent scheduled traffic changes the stability boundary of a critically loaded single-server queue, including a time-reversal asymmetry. That work concerns a different model and a different conclusion. The present paper addresses a strictly subcritical two-server queue and separates strong distributional convergence from stability. Foss and Glynn [FG26] study an infinite-server maximum-dater recursion, not the finite-server Kiefer-Wolfowitz recursion used here.

## 2. Recursion, metrics, and minimality

Write $\mathcal W=\{(u,v)\in\mathbb R^2:0\le u\le v\}$ and $x^+=\max(x,0)$. For positive $s,t$, define

$$
\Phi_{s,t}(u,v)=\operatorname{sort}\big((u+s-t)^+,(v-t)^+\big).
\tag{2.1}
$$

Adding a customer's service to the smallest virtual workload, then decreasing both coordinates by the next interarrival time and sorting, is the FCFS Kiefer-Wolfowitz update. Let

$$
W_0^0=(0,0),\qquad W_{n+1}^0=\Phi_{\sigma_n,\tau_n}(W_n^0).
\tag{2.2}
$$

Write $\mu_n=\mathcal L(W_n^0)$ for the empty-start workload law.

All stationarity statements below refer to **arrival index**, with the input environment initially in its invariant law. The workload itself is started empty. No claim of stationary sampling at an arbitrary physical time is implicit.

**Lemma 2.1 (Order and continuity).** Each map $\Phi_{s,t}$ preserves the coordinatewise order on $\mathcal W$ and is continuous.

**Proof.** Both positive-part coordinates are increasing and continuous in their respective input coordinates. Sorting a pair returns its minimum and maximum. Minimum and maximum are coordinatewise increasing and continuous. Their composition has the stated properties. $\square$

For a two-sided stationary input, let $L_N$ be the workload at index zero obtained by starting empty at index $-N$. If a finite stationary workload $W_0^*$ dominates these iterates, then

$$
0\le L_N\le L_{N+1}\le W_0^*.
\tag{2.3}
$$

The limit $L$ exists. Continuity makes it shift-covariant and stationary. Any other nonnegative stationary solution on the same input, including on a stationary extension, dominates every $L_N$ and hence $L$. We call $\pi_{\min}=\mathcal L(L)$ the minimal Loynes law. We will prove that each displayed stationary solution is this limit, rather than assume it.

For probabilities on $\mathcal W$, use

$$
d_{\rm TV}(\mu,\nu)=\sup_{A\in\mathcal B(\mathcal W)}|\mu(A)-\nu(A)|\in[0,1].
$$

For $1\le p<\infty$, $\mathsf W_p$ is the Wasserstein distance for the metric $d_\infty(w,z)=\|w-z\|_\infty$. For two sigma fields define

$$
\beta(\mathcal A,\mathcal B)=\frac12\sup\sum_{i,j}|\mathbb P(A_i\cap B_j)-\mathbb P(A_i)\mathbb P(B_j)|,
\tag{2.4}
$$

where the supremum ranges over finite measurable partitions from the two sigma fields. For a stationary sequence $Y$, set

$$
\beta_Y(k)=\beta\big(\sigma(Y_j:j\le0),\sigma(Y_j:j\ge k)\big).
$$

This is absolute regularity, also called $\beta$-mixing. The normalization is fixed to avoid factors of two in the bounds.

## 3. A rational support and a three-phase environment

Set

$$
a=\frac14,\quad d=\frac12,\quad c_j=\frac1{4\,3^j},\quad
C=\{c_j:j\ge1\},\quad \nu(\{c_j\})=2^{-j}.
\tag{3.1}
$$

The set $C$ lies in $(0,1/12]$, has infimum zero, and has no zero element. The displayed masses sum to one.

**Lemma 3.1 (Difference-free marks).** $(C-C)\cap C=\varnothing$.

**Proof.** A positive difference $c_i-c_j$ requires $i \lt j$. Equality $c_i-c_j=c_k$ would imply

$$
3^{j-i}-1=3^{j-k}.
$$

The left side is an integer at least two. If $k>j$, the right side is less than one; if $k=j$, it is one; if $k \lt j$, it is divisible by three, while the left side is two modulo three. All possibilities are excluded. Zero and negative differences are not elements of $C$. $\square$

Let $Z_n=(S_n,X_n)$ be the stationary Markov chain on $\{A,B,D\}\times C$ specified by the following transitions and edge observations $I_n=(\sigma_n,\tau_n)$.

| Current state | Next state | Probability | Service $\sigma_n$ | Interarrival $\tau_n$ |
|:--|:--|:--|:--|:--|
| $(A,x)$ | $(B,x)$ | $1/2$ | $5/4$ | $1$ |
| $(A,x)$ | $(D,x)$ | $1/2$ | $1/2$ | $1/2$ |
| $(D,x)$ | $(B,x)$ | $1$ | $3/4$ | $1/2$ |
| $(B,x)$ | $(A,y)$ | $\nu(\{y\})$ | $2+y-x$ | $1$ |

At a $B\to A$ transition a fresh mark $y$ is sampled independently of the past. The random choice between the two $A$ routes is also independent of the marks and previous choices. A cycle from one $A$ entrance to the next uses either two or three customer steps. Its total elapsed physical time is always two.

**Lemma 3.2 (Invariant environment and load).** The environment has invariant probability

$$
\bar\pi=\left(\frac25\delta_A+\frac25\delta_B+\frac15\delta_D\right)\otimes\nu.
\tag{3.2}
$$

Its input is strictly positive, bounded, rational-valued, and countable-valued, and

$$
\mathbb E\sigma_0=\frac{13}{10},\qquad
\mathbb E\tau_0=\frac45,\qquad
\rho=\frac{\mathbb E\sigma_0}{2\mathbb E\tau_0}=\frac{13}{16}<1.
\tag{3.3}
$$

**Proof.** Incoming $A$ mass is $2/5$ and always has mark law $\nu$. Incoming $D$ mass is $(2/5)/2=1/5$; incoming $B$ mass is $(2/5)/2+1/5=2/5$. Retained marks have the same law as refreshed marks, proving (3.2). The state space is countable, so the invariant measure and kernel give a two-sided stationary Markov law by their consistent finite-dimensional distributions.

The interarrival times are $1/2$ or $1$, excluding finite-time accumulation of arrivals. The three short service values are $1/2,3/4,5/4$. For a long service,

$$
\frac{23}{12}<2+y-x<\frac{25}{12}.
$$

All values are rational. The old and new marks at a refresh both have law $\nu$, hence the conditional mean long service is two. Therefore

$$
\mathbb E\sigma_0=\frac25\frac{5/4+1/2}{2}+\frac15\frac34+\frac25\,2=\frac{13}{10},
$$

$$
\mathbb E\tau_0=\frac25\frac{1+1/2}{2}+\frac15\frac12+\frac25=\frac45.
$$

This proves (3.3). $\square$

## 4. Geometric absolute regularity of the input

**Lemma 4.1 (Three-step minorization).** If $P$ is the environment kernel and $\eta=\delta_B\otimes\nu$, then

$$
P^3(z,\cdot)\ge\frac14\eta(\cdot)\qquad\text{for every }z.
\tag{4.1}
$$

**Proof.** From phases $A,B,D$, respectively, use the paths

$$
A\to B\to A\to B,\qquad
B\to A\to D\to B,\qquad
D\to B\to A\to B.
$$

Their probabilities are $1/4,1/2,1/2$. Each path refreshes its mark once and then retains it to the final $B$ state. The final mark therefore has law $\nu$ independently of the starting mark. Keeping only these path contributions proves the common lower bound. $\square$

**Proposition 4.2 (Uniform mixing and the edge shift).** For all $n\ge0$,

$$
\sup_z d_{\rm TV}(P^n(z,\cdot),\bar\pi)\le(3/4)^{\lfloor n/3\rfloor}.
\tag{4.2}
$$

The stationary input satisfies, for all $k\ge1$,

$$
\beta_I(k)\le(3/4)^{\lfloor(k-1)/3\rfloor}.
\tag{4.3}
$$

In particular it is strictly stationary and ergodic.

**Proof.** Decompose $P^3(z,\cdot)$ as a common $\eta$ component of mass $1/4$ plus a residual kernel of mass $3/4$. Couple a chain from $z$ and a stationary chain at each three-step epoch by selecting the common component together. After success use identical transitions. Failure through $r$ attempts has probability at most $(3/4)^r$, proving (4.2); additional transitions cannot increase total variation.

For a stationary Markov chain, conditional future laws given the whole past depend only on the current state. Coupling the states at a specified future epoch and then their entire futures gives the same bound on $\beta_Z(k)$ under (2.4). Equivalently, the conditional future kernel contracts total variation and averaging the conditional discrepancy cannot exceed the uniform bound (4.2).

Each $I_j$ is a measurable function of $(Z_j,Z_{j+1})$. Thus the input past through time zero is contained in the environment past through time one, while the input future from time $k$ is contained in the environment future from time $k$. Monotonicity of $\beta$ under sigma-field restriction and stationarity give

$$
\beta_I(k)\le\beta_Z(k-1),
$$

which proves (4.3). Decay of absolute regularity implies mixing of finite cylinder events; approximation by cylinders extends mixing to the path sigma field. Every invariant event is therefore independent of itself and has probability zero or one, establishing ergodicity. $\square$

## 5. The stationary graph and the finite-history deficit

Define

$$
w(A,x)=(0,1+x),\quad
w(D,x)=(0,1/2+x),\quad
w(B,x)=(x,1/4).
\tag{5.1}
$$

**Lemma 5.1 (Exact stationary graph).** The process $W_n^*=w(Z_n)$ obeys the Kiefer-Wolfowitz recursion with input $I_n$.

**Proof.** The four transition identities are

$$
\Phi_{5/4,1}(0,1+x)=(x,1/4),\qquad
\Phi_{1/2,1/2}(0,1+x)=(0,1/2+x),
$$

$$
\Phi_{3/4,1/2}(0,1/2+x)=(x,1/4),\qquad
\Phi_{2+y-x,1}(x,1/4)=(0,1+y).
\tag{5.2}
$$

They follow directly from (2.1), using $0 \lt x\le1/12<1/4$. $\square$

The optional split does not alter the completed $A\to B$ update.

**Lemma 5.2 (Split identity).** For every $h\ge0$,

$$
\Phi_{3/4,1/2}\big(\Phi_{1/2,1/2}(0,h)\big)
=\operatorname{sort}(1/4,(h-1)^+)
=\Phi_{5/4,1}(0,h).
\tag{5.3}
$$

**Proof.** The first split step is $(0,(h-1/2)^+)$. The second subtracts another $1/2$ from its second coordinate. The identity $((h-1/2)^+-1/2)^+=(h-1)^+$ proves the claim, including $h\le1/2$. $\square$

**Lemma 5.3 (Startup and running minimum).** From an empty workload in any initial environment phase, the first $B\to A$ transition occurs within three steps. At that time the workload has the form $(0,1+Y-X)$ for two marks $X,Y\in C$. Thereafter, at a phase $A$ boundary with current mark $X$, it has the representation

$$
W^0=(0,1+X-M),\qquad M\in C.
\tag{5.4}
$$

Its states along the optional $D$ phase and subsequent $B$ phase are, respectively,

$$
(0,1/2+X-M),\qquad ((X-M)^+,1/4).
\tag{5.5}
$$

At the next refresh to $Y$, the new deficit is $\min(M,X)$.

**Proof.** An empty $A$ state becomes $(0,1/4)$ at $B$ by either route; along the split route the intermediate empty $D$ state is zero. An initially empty $D$ state becomes $(0,1/4)$ at its next $B$. An initially empty $B$ state refreshes immediately. In all three cases the first refresh gives $(0,1+Y-X)$, so initialize $M=X$.

In (5.4), $|X-M|<1/12$. Hence the second coordinates in the $A$ and $D$ representations are positive; at $B$ the positive-part coordinate is smaller than $1/4$. Formula (5.3) handles both routes. The following refresh gives

$$
\Phi_{2+Y-X,1}((X-M)^+,1/4)
=(0,1+Y-X+(X-M)^+)
=(0,1+Y-\min(M,X)).
\tag{5.6}
$$

This proves the invariant representation. $\square$

**Proposition 5.4 (Synchronous convergence).** Under the common stationary input,

$$
W_n^0\le W_n^*,\qquad
\|W_n^0-W_n^*\|_\infty\longrightarrow0
\quad\text{almost surely and in every finite }L^p.
\tag{5.7}
$$

**Proof.** Order follows from Lemma 2.1. At $A$ and $D$ the deficit is $M$ in just the second coordinate; at $B$ it is $\min(M,X)$ in just the first coordinate. Successive refreshed marks are independent with law $\nu$. Every interval $(0,\epsilon)$ has positive $\nu$ mass. The probability that the first $N$ fresh marks all avoid that interval tends to zero; intersecting the resulting almost-sure events over $\epsilon=1/j$ proves that their running minimum tends to zero. Every cycle has at most three steps, so infinitely many marks are seen as $n\to\infty$. Finally, all workloads are uniformly bounded by (5.1). Bounded convergence proves the $L^p$ assertion. $\square$

## 6. Minimal stationarity and maximal total-variation separation

**Proposition 6.1 (Identification of the Loynes limit).** The stationary graph law

$$
\pi_W=\frac25\mathcal L(0,1+X)+\frac15\mathcal L(0,1/2+X)
+\frac25\mathcal L(X,1/4),\qquad X\sim\nu,
\tag{6.1}
$$

is the minimal stationary workload law $\pi_{\min}$.

**Proof.** Apply (2.3) with the stationary graph as upper bound. The pullback limit $L$ is the minimal stationary solution. The input is stationary, so $\mathcal L(L_N)=\mathcal L(W_N^0)$ for every $N$. Proposition 5.4 gives convergence of the expectations of the bounded coordinate sums to the expectation under (6.1). Monotone convergence therefore gives

$$
\mathbb E(L_1+L_2)=\mathbb E(W_{0,1}^*+W_{0,2}^*).
$$

Since $L\le W_0^*$ coordinatewise, their two nonnegative coordinate differences have zero sum in expectation, and both vanish almost surely. Thus $L=W_0^*$ almost surely. $\square$

**Theorem 6.2 (One set separates every finite time).** Let

$$
\mathcal S=\{(0,1+x):x\in C\}\cup\{(0,1/2+x):x\in C\}
\cup\{(x,1/4):x\in C\}.
\tag{6.2}
$$

For every finite $n\ge0$,

$$
\mathbb P(W_n^0\in\mathcal S)=0,\qquad
\pi_{\min}(\mathcal S)=1,\qquad
d_{\rm TV}(\mathcal L(W_n^0),\pi_{\min})=1.
\tag{6.3}
$$

**Proof.** The set $\mathcal S$ is countable and therefore Borel. Its stationary mass is one by Proposition 6.1. Before the first refresh the empty-start states are only $(0,0)$ and $(0,1/4)$, neither in $\mathcal S$. Afterwards Lemma 5.3 applies.

At an $A$ phase the second coordinate lies in $(11/12,13/12)$, so the only possible component of $\mathcal S$ is its $A$ component. Membership would require $X-M\in C$, contradicting Lemma 3.1. At a $D$ phase the second coordinate lies in $(5/12,7/12)$; only the $D$ component is possible, and the same difference-free argument applies. At $B$, the second coordinate is $1/4$ and the first is zero or a positive difference of two marks. It cannot belong to $C$. These ranges also exclude every cross-phase coincidence.

Thus no admissible finite empty-start path enters $\mathcal S$. Taking $\mathcal S$ in the definition of total variation gives a lower bound of one, its maximum possible value. $\square$

**Corollary 6.3 (Failure under geometric input mixing).** There exists a bounded positive rational FCFS $G/G/2$ input satisfying (3.3) and (4.3) for which the empty-start law converges weakly and in every finite Wasserstein distance to the minimal stationary law, while (6.3) holds at every finite arrival index.

**Proof.** Combine Lemma 3.2, Proposition 4.2, Proposition 5.4, Proposition 6.1, and Theorem 6.2. The explicit synchronous coupling bounds every finite Wasserstein distance by an $L^p$ error tending to zero. $\square$

## 7. Quantitative separation of convergence scales

Put $\gamma=\log 3/\log 2$. The same rational construction has polynomial, rather than geometric, workload convergence in Wasserstein distance. This section gives matching orders and explicit constants.

**Lemma 7.1 (Running-minimum moments).** Let $J_1,\ldots,J_N$ be independent with $\mathbb P(J_i=j)=2^{-j}$, $j\ge1$, and let $M_N=\min_{1\le i\le N}a3^{-J_i}$. For $N\ge1$ and $p>0$,

$$
\mathbb E M_N^p=a^p(1-3^{-p})\sum_{j\ge1}3^{-pj}(1-2^{-j})^N.
\tag{7.1}
$$

For $p\ge1$ and $N\ge1$,

$$
\frac{a^p}{2\,9^p}N^{-p\gamma}
\le\mathbb E M_N^p
\le a^p(3^p-1)\Gamma(p\gamma)N^{-p\gamma}.
\tag{7.2}
$$

**Proof.** Set $K_N=\max_i J_i$ and $F_N(j)=\mathbb P(K_N\le j)=(1-2^{-j})^N$, with $F_N(0)=0$. Summation by parts with $r=3^{-p}$ gives

$$
\sum_{j\ge1}r^j\big(F_N(j)-F_N(j-1)\big)
=(1-r)\sum_{j\ge1}r^jF_N(j).
$$

The truncation boundary vanishes because $r^j\to0$, proving (7.1).

For the lower bound choose $j_N=\lceil\log_2(2N)\rceil$. Bernoulli's inequality gives $F_N(j_N)\ge1-N2^{-j_N}\ge1/2$. On this event $M_N^p\ge a^p3^{-pj_N}$. Since $j_N<\log_2(2N)+1$, this last quantity is at least $a^p9^{-p}N^{-p\gamma}$.

For the upper bound put $b=p\gamma>1$ and use $(1-u)^N\le e^{-Nu}$. For $u=2^{-j}$ and $x\in[u,2u]$,

$$
x^{b-1}\ge u^{b-1},\qquad e^{-Nx/2}\ge e^{-Nu}.
$$

Consequently

$$
u^b e^{-Nu}\le\int_u^{2u}x^{b-1}e^{-Nx/2}\,dx.
$$

The intervals $[2^{-j},2^{1-j}]$ partition $(0,1]$ up to endpoints, so

$$
\sum_{j\ge1}2^{-bj}e^{-N2^{-j}}
\le\int_0^1 x^{b-1}e^{-Nx/2}\,dx
\le\Gamma(b)(2/N)^b.
$$

Here $\Gamma(b)=\int_0^\infty x^{b-1}e^{-x}\,dx$. Since $2^b=3^p$, substitution into (7.1) proves (7.2). If an elementary constant is preferred, $\Gamma(b)\le1+(\lceil b\rceil-1)!$ for $b\ge1$: split the defining integral at one, bound its first part by one, and dominate the second by the full integer gamma integral. $\square$

**Lemma 7.2 (Customer-index deficit sandwich).** Let $X_0$ be the initial environment mark, let $X_r$ be the fresh mark at the $r$th $B\to A$ transition, and set $M_r=\min\{X_0,\ldots,X_{r-1}\}$ for $r\ge1$. These marks are independent with law $\nu$. If $N_n$ counts such transitions during the first $n$ updates and $E_n=\|W_n^0-w(Z_n)\|_\infty$, then, for $n\ge3$,

$$
\left\lfloor\frac n3\right\rfloor\le N_n\le
\left\lfloor\frac{n+1}2\right\rfloor,
\qquad
E_n=M_{N_n+\mathbf1_{\{S_n=B\}}},
\tag{7.3}
$$

$$
M_n\le E_n\le M_{\lfloor n/3\rfloor},\qquad
w_1(Z_n)+w_2(Z_n)-W_{n,1}^0-W_{n,2}^0=E_n.
\tag{7.4}
$$

**Proof.** Starting in phase $A,D,B$, respectively, the first refresh takes two or three, two, or one updates. Subsequent refreshes are two or three updates apart. The $r$th refresh is therefore no later than $3r$ and no earlier than $2r-1$, proving the count bounds. By Lemma 5.3, after the first refresh the states in phases $A,D,B$ are, respectively,

$$
(0,1+X_{N_n}-M_{N_n}),\quad
(0,1-d+X_{N_n}-M_{N_n}),\quad
((X_{N_n}-M_{N_n})^+,a).
$$

The intermediate $D$ coordinate is at least $1-d-1/12=5/12$, so no omitted clipping occurs. The deficits from the stationary graph are $M_{N_n}$ in phases $A,D$ and $\min(M_{N_n},X_{N_n})=M_{N_n+1}$ in phase $B$. Only one coordinate can differ, proving the sum identity in (7.4). For $n\ge3$, the index in (7.3) lies between $\lfloor n/3\rfloor$ and $\lfloor(n+1)/2\rfloor+1\le n$. Running minima decrease with their index, giving the sandwich. This pathwise argument avoids treating a random refresh count as deterministic or independent of the queue. $\square$

**Theorem 7.3 (Sharp polynomial Wasserstein order).** For the rational construction, every fixed $p\ge1$ and every integer $n\ge6$ satisfy

$$
\frac{a}{36}\,n^{-\gamma}
\le\mathsf W_p(\mu_n,\pi_{\min})
\le6^\gamma a\big[(3^p-1)\Gamma(p\gamma)\big]^{1/p}n^{-\gamma}.
\tag{7.5}
$$

In particular $\mathsf W_p(\mu_n,\pi_{\min})=\Theta_p(n^{-\log_2 3})$, with lower constant $1/144$ for $a=1/4$.

**Proof.** The synchronous construction is an admissible coupling. Equations (7.2) and (7.4) imply

$$
\mathsf W_p(\mu_n,\pi_{\min})
\le(\mathbb E E_n^p)^{1/p}
\le a\big[(3^p-1)\Gamma(p\gamma)\big]^{1/p}
\lfloor n/3\rfloor^{-\gamma}.
$$

For $n\ge6$, $\lfloor n/3\rfloor\ge n/6$, proving the upper bound. For the lower bound use the function $f(u,v)=(u+v)/2$, which is 1-Lipschitz for $d_\infty$. Stationarity, (7.4), and (7.2) with $p=1$ give

$$
\int f\,d\pi_{\min}-\int f\,d\mu_n
=\frac12\mathbb E E_n
\ge\frac12\mathbb E M_n
\ge\frac{a}{36}n^{-\gamma}.
$$

For any coupling the absolute difference of the two means is at most its expected distance, which is at most its $p$th distance moment to the power $1/p$. Taking the infimum proves the lower bound. No optimality assertion about the synchronous coupling is needed. $\square$

## 8. Regeneration of the input does not renovate the workload

The main input is regenerative; this property must not be denied to explain away its convergence behavior. We give an observable boundary, rather than rely only on a hidden environment state.

**Lemma 8.1 (Unique observable marker).** The input letter

$$
(\sigma,\tau)=(2+1/18,1)
\tag{8.1}
$$

occurs exactly on a transition $(B,c_2)\to(A,c_1)$.

**Proof.** None of the three short service types can equal $2+1/18$. For a long service we need $y-x=1/18=c_1-c_2$. A positive difference $c_i-c_j$, $i \lt j$, has a rational denominator whose power of three after reduction is exactly $3^j$, because $3^{j-i}-1$ is not divisible by three. Equality of two such differences forces their larger indices to agree, then their smaller indices to agree. Thus $i=1,j=2$. $\square$

**Proposition 8.2 (Regenerative input with exponential cycle tails).** The customer index immediately after an occurrence of (8.1) is a regeneration boundary for the future input. After the initial delayed boundary, the input blocks between successive boundaries are independent and identically distributed. If $T$ is the next boundary time from any environment state, then

$$
\mathbb P(T>4k)\le(31/32)^k\qquad(k\ge0).
\tag{8.2}
$$

**Proof.** Lemma 8.1 makes the boundary observable from input already seen and fixes the new environment state to $(A,c_1)$. The strong Markov property at successive boundaries gives identical future laws and independent consecutive blocks. For the tail bound, (4.1) gives probability at least $(1/4)\nu(\{c_2\})=1/16$ of state $(B,c_2)$ after three steps, uniformly over the initial state. The next refresh chooses $c_1$ with probability $1/2$. Thus a marker is seen within the next four steps with probability at least $1/32$, even if there was an earlier occurrence in that interval. Iterating this conditional bound over four-step blocks proves (8.2), hence finite mean and an exponential tail. $\square$

This is input regeneration, not regeneration of the joint environment-workload state. At every input boundary the empty-start workload still lies outside $\mathcal S$, while the minimal stationary workload lies inside it. The joint Markov process started empty is therefore not irreducible with respect to its displayed stationary graph measure: the positive-measure graph cannot be reached.

The informal discussion preceding the conjecture in [F09] mentions regenerative cases among favorable input conditions. Our precise construction shows that the bare existence of independent regenerative input blocks cannot be used as an unconditional substitute for the actual hypotheses of a workload-convergence theorem. In particular, [FS06] uses positive-probability renovating events and, in its multiserver application, independent primitive sequences. Those are stronger requirements than the input properties verified here. We do not claim to refute that theorem or any classical independent-input result.

## 9. General embedding and a finite-alphabet companion

**Theorem 9.1 (Bounded-potential embedding).** Let $(\Omega,\mathcal F,\mathbb P,R)$ be an invertible probability-preserving ergodic system. Let $0 \lt a<1$ and $X:\Omega\to[0,a]$ have essential infimum zero. Write $X_k=X\circ R^k$. On $\Omega\times\{0,1\}$ with the uniform independent phase, set

$$
T(\omega,0)=(\omega,1),\qquad T(\omega,1)=(R\omega,0),
$$

$$
\tau\equiv1,\qquad \sigma(\omega,0)=1+a,\qquad
\sigma(\omega,1)=2+X_1(\omega)-X_0(\omega).
\tag{9.1}
$$

This is strictly stationary ergodic input with $\mathbb E\sigma=(3+a)/2<2$. Its minimal stationary workload is

$$
v(\omega,0)=(0,1+X_0),\qquad v(\omega,1)=(X_0,a).
\tag{9.2}
$$

For a phase-zero empty start and $k\ge1$, writing $m_k=\min_{0\le j \lt k}X_j$, the exact workloads are

$$
W^0_{2k}=(0,1+X_k-m_k),\qquad
W^0_{2k+1}=(X_k-m_{k+1},a).
\tag{9.3}
$$

They converge under the synchronous coupling almost surely and in every finite $L^p$. This coupling occurs at a finite index almost surely if $\mathbb P(X=0)>0$, and at no finite index almost surely if $\mathbb P(X=0)=0$. The latter fact alone is not a total-variation claim.

**Proof.** The map $T$ preserves the product probability. A $T$-invariant event has equal phase sections, each invariant under $R$ because $T^2$ acts as $R$. The sections therefore have probability zero or one, proving ergodicity. The input is a factor. Its service is positive and bounded since $2-a\le\sigma(\omega,1)\le2+a$; the mean follows by cancellation of $\mathbb E(X_1-X_0)$.

The stationary recursion is checked by

$$
\Phi_{1+a,1}(0,1+X_0)=(X_0,a),\qquad
\Phi_{2+X_1-X_0,1}(X_0,a)=(0,1+X_1).
$$

For a dominated phase-zero state $(0,h)$, $0\le h\le1+a$, two updates give

$$
h_{k+1}=\max(h_k,1)+X_{k+1}-X_k.
$$

Set $z_k=h_k-1-X_k$. Then $z_{k+1}=\max(z_k,-X_k)$ and $z_0=-1-X_0$. This gives (9.3), including the first odd state $(0,a)$. A phase-one empty start reaches in one step the same phase-zero state reached by a complete initial pair, namely $(0,1+X_1-X_0)$, so its analysis has only an index shift.

Ergodicity and essential infimum zero imply that the forward and backward running minima of $X$ tend to zero almost surely. One may apply the ergodic theorem to the indicators of $X<1/j$ for positive integers $j$. The error formulas (9.3), boundedness, and their shifted versions give synchronous and $L^p$ convergence. To identify the minimal law directly, a pullback of length $2k$ at phase zero equals

$$
(0,1+X_0-\min_{-k\le j<0}X_j),
$$

while a pullback of length $2k+1$ at phase one equals

$$
(X_0-\min_{-k\le j\le0}X_j,a).
$$

These subsequences tend to (9.2); monotonicity bounds all intermediate pullbacks and proves minimality. If $X$ has positive mass at zero, the forward orbit hits zero almost surely and the error thereafter vanishes. If it has no mass at zero, all finitely many encountered marks are positive almost surely and each finite error is positive. $\square$

**Corollary 9.2 (Three service values and unit interarrivals).** Fix $a=1/4$, an irrational $\alpha\in(0,1)$, and a uniform $U\in[0,1)$. Use $R(u)=\{u+\alpha\}$ and $X(u)=au$ in Theorem 9.1. The service alphabet is exactly

$$
\{1+a,\ 2+a\alpha,\ 2+a\alpha-a\}.
\tag{9.4}
$$

For every finite $n$, its empty-start law has total-variation distance one from its minimal stationary law, although synchronous and finite-order Wasserstein convergence hold.

**Proof.** Lebesgue measure is invariant under the rotation. To verify ergodicity, an invariant square-integrable function has Fourier coefficients $b_j=e^{2\pi i j\alpha}b_j$; irrationality forces every nonzero-frequency coefficient to vanish, so invariant indicators are constant almost surely. Theorem 9.1 applies. The two rotation increments are $\alpha$ and $\alpha-1$, giving (9.4); with $a=1/4$ these are three distinct positive values.

At every finite time the zero-start workload is a function of a finite service word and therefore has finite support. The minimal stationary law is

$$
\frac12\mathcal L(0,1+aU)+\frac12\mathcal L(aU,a),
$$

which is nonatomic. The finite support of each time law separates it from the stationary law, giving total variation one. A single countable union of these finite supports also separates every finite time from the stationary law. No mixing property is claimed for this companion construction. $\square$

## 10. Scope, verification, and consequences

The rational construction distinguishes three objects: a rapidly mixing exogenous input, an asymptotically close workload under the common-input metric, and a workload law that remains maximally separated in total variation. Input mixing does not supply the accessibility or renovation condition missing from the workload recursion. The conclusions concern exact distributions and measurable sets; they do not imply that every bounded smooth performance functional has a large initialization bias.

The results are for the ordered two-server FCFS workload at arrival indices. They do not classify all stationary regimes, prove a necessary and sufficient convergence criterion for arbitrary input, or claim the same result for every $m\ge2$. A counterexample at $m=2$ suffices to disprove the universally stated multiserver assertion. The finite-alphabet and geometrically mixing examples are distinct; their assumptions must not be merged into a claim of a finite-alphabet geometrically $\beta$-mixing example. No numerical experiment proves stationarity, ergodicity, a universal inequality, or novelty.

The accompanying exact-rational checks verify the transition identities, invariant weights, minorization certificate, deficit updates, and finite diagnostic instances. The general claims are established by the written arguments above. Full formal verification has not been implemented or run. The source-specific 2022 access limitation remains part of the scholarly scope and is not an unresolved step in the mathematical proofs.

## References

[F09] S. Foss. *Some Open Problems Related to Stability*. arXiv:0909.0462v1, 2009, Section 1.1. <https://arxiv.org/html/0909.0462v1>.

[F22] S. Foss. *Convergence in the total variation norm in multiserver queues*. Queueing Systems 100(3-4), 293-295, 2022. DOI: [10.1007/s11134-022-09807-1](https://doi.org/10.1007/s11134-022-09807-1). Bibliographic record verified; full text unavailable in this study.

[BFM96] F. Baccelli, S. Foss, and J. Mairesse. *Stationary Ergodic Jackson Networks: Results and Counter-Examples*. In *Stochastic Networks: Theory and Applications*, 1996, pp. 281-307. DOI: [10.1093/oso/9780198523994.003.0017](https://doi.org/10.1093/oso/9780198523994.003.0017). The inspected full text was author report HPL-BRIMS-96-11 (March 1996), not a byte-verified final chapter.

[FS06] S. Foss and A. Sapozhnikov. *Convergence Rates in Monotone Separable Stochastic Networks*. Queueing Systems 52(2), 125-137, 2006. DOI: [10.1007/s11134-006-4261-z](https://doi.org/10.1007/s11134-006-4261-z). Author full text: <https://www.math.uni-leipzig.de/~sapozhnikov/sapozhnikov_2.pdf>. The proof hypotheses used for comparison are in the introduction, Section 3, and the multiserver application in Section 5.

[AG25] V. F. Araman and P. W. Glynn. *Technical Note-Stability of a Queue Fed by Scheduled Traffic at Critical Loading*. Operations Research 73(5), 2567-2571, 2025; first published online 16 September 2024. DOI: [10.1287/opre.2023.0039](https://doi.org/10.1287/opre.2023.0039). Author preprint arXiv:2212.04164v1 was inspected separately from the publisher metadata and abstract.

[FG26] S. Foss and P. W. Glynn. *On Recurrence of the Infinite Server Queue*. Queueing Systems 110, article 11, 2026. DOI: [10.1007/s11134-026-09972-7](https://doi.org/10.1007/s11134-026-09972-7).
