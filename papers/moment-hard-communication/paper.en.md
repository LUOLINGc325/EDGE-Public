# Hard Communication Budgets for Heavy-Tailed Mean Estimation

## A uniform resource characterization for finite alphabets, localization, and heterogeneous sensors

**Research manuscript, 26 November 2026.** Written proofs are supplied below. No formal proof code has been produced or checked for this manuscript. This is a research draft, not an externally peer-reviewed or accepted publication.

## Abstract

We study scalar mean estimation when each independent observation is encoded once into a finite alphabet. The encoder may depend on the public transcript and use independent randomization; it cannot retain past observations or reveal information through an uncharged channel. For distributions with variance at most $\sigma^2$ and mean in $[-\lambda,\lambda]$, we characterize the minimax number of samples uniformly over the alphabet size $M$, the accuracy $\epsilon$, the confidence $\delta$, and the location range $\lambda$. Writing $S=\sigma/\epsilon$, the answer, up to universal multiplicative constants, is

$$
\frac{\log(1+\lambda/\sigma)}{\log M}
+S^2\max\left\{1,\frac{\log S}{M-1}\right\}\log(1/\delta).
$$

A two-stage protocol attains this rate. A more detailed resource theorem identifies the sufficient and necessary cumulative information supplied by a prescribed heterogeneous sequence of alphabets. It also yields the optimal total hard bit budget, including protocols that choose each round's bit allowance from the observed history. The latter budget has order

$$
\log(1+\lambda/\sigma)
+S^2\log(1+\log S)\log(1/\delta).
$$

For a known-center raw $k$th-moment bound, we further prove a joint alphabet and moment-index theorem with constants uniform over $3/2\le k\le5/2$. A nearly flat window of geometric scales supplies a matching converse throughout the critical region $|k-2|\log S=O(1)$, including a moving $k$ rather than only a fixed moment index.

The one-bit finite-variance hard pair, geometric quantization, and the sufficiency of a doubly logarithmic precision have antecedents. Our contribution is the uniform resource characterization and its converse for arbitrary randomized sequential encoders, together with the uniform critical-window converse and a localization argument that accounts for the full alphabet size. We do not claim sharp leading constants, the original one-bit finite-variance lower bound, or the first noninteractive one-bit estimator.

## 1. Problem and contribution boundaries

For known $\lambda\ge\sigma>0$, define

$$
\mathcal P(\lambda,\sigma)
=\{P:|\mu(P)|\le\lambda,\ \operatorname{Var}_P(X)\le\sigma^2\},
\qquad \mu(P)=\mathbb E_P X.
$$

We also use the localized raw-moment class

$$
\mathcal C(\sigma)=\{P:\mathbb E_P X^2\le\sigma^2\}.
$$

The two classes are distinct. A bound on the central variance alone does not give a bound on the raw second moment about the origin. Section 5 supplies the recentering needed to pass from the second class to the first.

### 1.1 Communication model

The unknown distribution $P$ generates independent samples $X_1,X_2,\ldots$. In round $t$, the learner specifies a measurable stochastic kernel from $\mathbb R$ to an alphabet with at most $M_t$ symbols. The kernel is selected using the transcript before round $t$, parameters of the problem, and randomness independent of the samples. The agent observes only $X_t$ and sends one symbol. The agent does not retain previous observations. A sample cannot be queried again under a new free communication allowance.

Public random seeds are known to both parties and included in the transcript. Private encoder randomization is allowed. Downlink query descriptions, public random bits, and computation are not charged. These are explicit choices of model, not claims that the implementation has small computational or downlink complexity.

In the fixed-alphabet problem $M_t=M\ge2$ and the number of observations is a deterministic upper bound $n$. A protocol is $(\epsilon,\delta)$-accurate if

$$
\sup_{P\in\mathcal P(\lambda,\sigma)}
\Pr_P\{ |\widehat\mu-\mu(P)|>\epsilon\}\le\delta.
$$

Let $n_*(\lambda,\sigma,\epsilon,\delta;M)$ denote the smallest such upper bound, allowing all protocols just described. Define $n_{*,0}$ analogously on $\mathcal C(\sigma)$.

For total-bit statements, the learner chooses a nonnegative integer $b_t$ before $X_t$ is observed and uses an alphabet of size at most $2^{b_t}$. The total bound $B$ holds on every transcript: $\sum_t b_t\le B$. Stopping and round boundaries are determined by the public history. A zero-bit round conveys no observation-dependent information and can be omitted. In particular, silence, message length, sample-dependent stopping, and choice of the encoder itself cannot carry an extra uncharged signal. The number of informative rounds is at most $B$.

All logarithms are natural unless a base is shown. Universal constants below do not depend on $M,\lambda,\sigma,\epsilon,\delta$. Throughout Sections 2--8,

$$
0<\epsilon\le\sigma/256,\qquad 0<\delta\le1/8.
\tag{1}
$$

### 1.2 Position relative to previous work

Lau and Scarlett [LS26a] establish the sharp one-bit finite-variance rate and introduce the multiscale null/alternative pair used in our converse. Their later paper [LS26b], as well as concurrent work including [M26], establishes nonadaptive one-bit attainability. Those results are prior work; our two-stage construction does not improve their interaction count at $M=2$.

Mayekar and Tyagi [MT21] develop adaptive gain quantization under a mean-square bound. Its high-precision guarantees already show that a doubly logarithmic gain precision can preserve the unquantized order. Geometric ranges, randomized rounding, and this sufficiency phenomenon are not claimed as new. The lower bounds for particular gain-shape or uniform-gain schemes in that work are not converses for every stochastic encoder in our model.

Kipnis and Duchi [KD22] study one-bit mean estimation for structured symmetric log-concave location families, including asymptotic efficiency and interaction. That setting supplies an important information-theoretic comparison, but does not give the nonparametric heavy-tail resource formulas proved here.

Cai and Wei [CW24] give sharp distributed Gaussian mean-estimation rates with possibly unequal machine budgets. Their scalar Gaussian result depends on the total budget and the number of machines, rather than on its particular allocation, and already uses localization and refinement. Their model permits local batches and assumes a Gaussian family; the extensions impose additional distributional conditions. Our scalar heavy-tail capacity law concerns a different, nonparametric single-observation model. We do not claim that heterogeneous budgets or the localization/refinement decomposition were first studied here.

The results below give a joint, nonasymptotic characterization of alphabet size, location uncertainty, reliability, heterogeneous allowances, and predictable hard-bit allocation. They also establish the necessity of the critical moment-index penalty with constants uniform in a moving $k$. The proofs combine earlier tools with a uniform output-cell bound, a public subset code, a multiary location sketch, and a dominant nearly flat window of scales. We also acknowledge that a rejection-sampling simulation reduces an $M$-symbol channel to one-bit queries with order-$M$ sample overhead; hence the fixed-$M$ converse in isolation should not be presented as an independent major invention.

## 2. Main results

### Theorem 2.1 (Uniform fixed-alphabet sample complexity).

Under (1), for every integer $M\ge2$ and $\lambda\ge\sigma>0$,

$$
n_*(\lambda,\sigma,\epsilon,\delta;M)
\asymp
\frac{\log(1+\lambda/\sigma)}{\log M}
+\frac{\sigma^2}{\epsilon^2}
\max\left\{1,\frac{\log(\sigma/\epsilon)}{M-1}\right\}
\log(1/\delta).
\tag{2}
$$

The upper bound uses two batches, with the first batch determining a center for the second. The lower bound applies to arbitrary sequential interaction and to both public and private randomization. For the localized class,

$$
n_{*,0}(\sigma,\epsilon,\delta;M)
\asymp
\frac{\sigma^2}{\epsilon^2}
\max\left\{1,\frac{\log(\sigma/\epsilon)}{M-1}\right\}
\log(1/\delta),
\tag{3}
$$

and its upper bound is nonadaptive.

Here and below $a\asymp b$ means that $c b\le a\le C b$ for positive universal constants. It does not assert equality of leading constants.

### Theorem 2.2 (Heterogeneous alphabet capacity).

Set

$$
L=\left\lfloor\tfrac12\log_2\!\left(\frac{\sigma}{3\epsilon}\right)\right\rfloor
\quad\text{and}\quad
\mathcal I_L(M_1,\ldots,M_n)
=\sum_{t=1}^n\min\left\{1,\frac{M_t-1}{L}\right\}.
\tag{4}
$$

There are universal $c,C>0$ with the following properties on $\mathcal C(\sigma)$. For any prescribed deterministic sequence of integers $M_t\ge1$, an accurate protocol exists if

$$
\mathcal I_L\ge C\frac{\sigma^2}{\epsilon^2}\log(1/\delta).
\tag{5}
$$

Conversely, accuracy requires

$$
\mathcal I_L\ge c\frac{\sigma^2}{\epsilon^2}\log(1/\delta).
\tag{6}
$$

For history-dependent predictable $M_t$, the same necessary bound holds with $\mathbb E_{P_1}\mathcal I_L$ for the specific alternative $P_1$ constructed in Section 3. Thus any almost-sure upper bound on this capacity is also subject to (6). The sufficiency claim in (5) is for a prescribed sequence; it is not a claim about every adaptive budget-allocation policy.

### Theorem 2.3 (Optimal total hard bit budget).

Let $B_*(\lambda,\sigma,\epsilon,\delta)$ be the smallest pathwise hard uplink budget in the bit model of Section 1.1. Under (1),

$$
B_*(\lambda,\sigma,\epsilon,\delta)
\asymp
\log(1+\lambda/\sigma)
+\frac{\sigma^2}{\epsilon^2}
\log\!\bigl(1+\log(\sigma/\epsilon)\bigr)
\log(1/\delta).
\tag{7}
$$

The lower bound permits predictable changes in the bit allowance, randomized encoders, and history-dependent stopping. It does not apply to uncharged observation-dependent stopping or to an expected-length code with a different communication convention.

## 3. An alphabet-uniform information bound

### Lemma 3.1 (The dyadic testing pair).

Let $L$ be as in (4), $x_j=2^j\sigma$ for $1\le j\le L$, and

$$
q_j=\frac{1}{2L4^j},\qquad
d_j=\frac{3\epsilon}{L2^{j+1}\sigma},\qquad
q_0=1-2\sum_{j=1}^Lq_j.
\tag{8}
$$

Define $P_0$ by masses $q_j$ at both $x_j$ and $-x_j$, and mass $q_0$ at zero. Define $P_1$ by replacing these masses by $q_j+d_j$ and $q_j-d_j$, respectively, leaving $q_0$ unchanged. Then both are probability distributions in $\mathcal C(\sigma)$,

$$
\mu(P_0)=0,\quad \mu(P_1)=3\epsilon,\quad
\mathbb E_{P_i}X^2=\sigma^2,\quad q_0>1/2,
\tag{9}
$$

and

$$
\chi^2(P_1\Vert P_0)=9\epsilon^2/\sigma^2.
\tag{10}
$$

**Proof.** Under (1), $L\ge3$ and $2^L\le\sqrt{\sigma/(3\epsilon)}$. Hence

$$
\frac{d_j}{q_j}=\frac{3\epsilon 2^j}{\sigma}
\le\sqrt{3\epsilon/\sigma}<1.
$$

This proves positivity. Also $2\sum_jq_j<1/(3L)$, so $q_0>1/2$. The two opposite perturbations preserve total mass and the second moment; their mean contributions are $2d_jx_j=3\epsilon/L$. Finally,

$$
\sum_{j=1}^L\frac{2d_j^2}{q_j}
=\sum_{j=1}^L\frac{9\epsilon^2}{L\sigma^2}
=\frac{9\epsilon^2}{\sigma^2}.
$$

This is the null/mixture pair of [LS26a], written directly as a mass perturbation. The pair itself is not a new construction. $\square$

### Lemma 3.2 (Output-cell contraction).

For every deterministic measurable quantizer $Q$ with at most $M\ge2$ outputs,

$$
\chi^2(P_1Q\Vert P_0Q)
\le\frac{\epsilon^2}{\sigma^2}
\min\left\{9,\frac{36(M-1)}{L}\right\}.
\tag{11}
$$

**Proof.** Only the $2L+1$ atoms matter. Let a cell $A$ not contain zero. If it is empty on the support, its contribution is zero. Otherwise let $j_*$ be the smallest scale represented in $A$. Put $q(A)=P_0(A)$ and $d(A)=P_1(A)-P_0(A)$. Since a scale contributes either $d_j$, $-d_j$, or zero,

$$
q(A)\ge\frac{1}{2L4^{j_*}},\qquad
|d(A)|\le\sum_{j=j_*}^Ld_j
\le\frac{3\epsilon}{L\sigma2^{j_*}}.
$$

Therefore $d(A)^2/q(A)\le18\epsilon^2/(L\sigma^2)$. There are at most $M-1$ such cells. Let $A_0$ be the cell containing zero. It has $q(A_0)>1/2$, and $d(A_0)=-\sum_{A\ne A_0}d(A)$. Weighted Cauchy--Schwarz gives

$$
\frac{d(A_0)^2}{q(A_0)}
\le\frac{\sum_{A\ne A_0}q(A)}{q(A_0)}
\sum_{A\ne A_0}\frac{d(A)^2}{q(A)}
\le\sum_{A\ne A_0}\frac{d(A)^2}{q(A)}.
$$

Summing proves the second bound in (11). Applying Cauchy--Schwarz inside each cell also proves the data-processing inequality for $\chi^2$, so (10) gives the first bound. Zero-probability cells have zero perturbation and are omitted. $\square$

### Lemma 3.3 (Randomization and sequential composition).

For an arbitrary stochastic $M$-output kernel, the Kullback--Leibler divergence between its outputs under $P_1$ and $P_0$ is bounded by the right side of (11). For a sequential transcript $T_n$ with predictable $M_t$,

$$
D_{\mathrm{KL}}(\mathcal L_1(T_n)\Vert\mathcal L_0(T_n))
\le\frac{36\epsilon^2}{\sigma^2}
\mathbb E_{P_1}\sum_{t=1}^n
\min\left\{1,\frac{M_t-1}{L}\right\}.
\tag{12}
$$

**Proof.** A finite-output stochastic kernel is realized by a deterministic map of the input and an independent uniform seed, using cumulative output probabilities. Revealing that seed gives conditional deterministic channels. Their $\chi^2$ bounds average to (11), and $D_{\mathrm{KL}}\le\chi^2$. Forgetting a private seed cannot increase divergence. The same argument applies to a fresh randomized kernel after conditioning on any history. Under either hypothesis the next sample is fresh with law $P_i$, while the learner's query-selection rule is the same conditional on that history. The conditional divergence of this rule is zero. The chain rule now sums the per-round bounds, with the expectation under $P_1$, which is the first argument of the divergence. The same reasoning handles shared seeds by conditioning on them once. A one-output round contributes zero. $\square$

### Lemma 3.4 (Testing consequence).

Any estimator accurate for both distributions in Lemma 3.1 satisfies

$$
D_{\mathrm{KL}}(\mathcal L_1(T)\Vert\mathcal L_0(T))
\ge\log\frac{1}{4\delta}.
\tag{13}
$$

**Proof.** Declare hypothesis one when $\widehat\mu>3\epsilon/2$. Accuracy gives each error probability at most $\delta$, since the two means differ by $3\epsilon$. The sum of testing errors is at least $\tfrac12\exp(-D_{\mathrm{KL}}(P_1^T\Vert P_0^T))$, the Bretagnolle--Huber inequality. Comparing it with $2\delta$ proves (13). For completeness, this inequality follows by writing the optimal error sum as $1-\operatorname{TV}$, bounding the Hellinger affinity below by $\exp(-D_{\mathrm{KL}}/2)$ through Jensen's inequality, and using $\operatorname{TV}\le\sqrt{1-\mathrm{affinity}^2}$ and $1-\sqrt{1-u}\ge u/2$. $\square$

Since $\delta\le1/8$, $\log(1/(4\delta))\ge\tfrac13\log(1/\delta)$. For $S\ge256$, $L\asymp\log S$ uniformly. Lemmas 3.3--3.4 therefore prove the lower bound in (3) and the necessity statement of Theorem 2.2.

## 4. A public subset quantizer

### Lemma 4.1 (Signed layers and truncation).

Let

$$
J=\lceil\log_2(4\sigma/\epsilon)\rceil,
\qquad R=2^J\sigma,\qquad D=2(J+1).
\tag{14}
$$

Partition $0<|x|\le R$ into two signed central layers $0<|x|\le\sigma$ and two signed layers $2^{j-1}\sigma<|x|\le2^j\sigma$, $1\le j\le J$. On a layer $\ell$, let $s_\ell\in\{-1,1\}$ be its sign and $a_\ell$ its absolute upper endpoint. With $\mu_R=\mathbb E[X\mathbf1_{\{|X|\le R\}}]$, every $P\in\mathcal C(\sigma)$ satisfies

$$
|\mu-\mu_R|\le\epsilon/4,
\qquad
\sum_\ell\mathbb E[a_\ell|X|\mathbf1_{\{X\in\ell\}}]
\le3\sigma^2.
\tag{15}
$$

**Proof.** The tail bias is at most $\mathbb EX^2/R$. On noncentral layers, $a_\ell<2|X|$. On the central pair, the contribution is $\sigma\mathbb E[|X|\mathbf1_{\{|X|\le\sigma\}}]\le\sigma(\mathbb EX^2)^{1/2}\le\sigma^2$. This last expectation argument is essential: the pointwise inequality $\sigma|x|\le x^2$ is false near zero. $\square$

### Lemma 4.2 (Exact subset-code moments).

Put $r=\min\{M-1,D\}$. Independently for each sample, choose a uniformly random $r$-subset $U$ of the $D$ layers using a public seed. If $x$ lies in a selected layer $\ell$, send its index within the public list with probability $|x|/a_\ell$; otherwise send the symbol zero. There are at most $r+1\le M$ outputs. Decode a nonzero symbol as

$$
Y=\frac{D}{r}s_\ell a_\ell
$$

and decode zero as zero. Then

$$
\mathbb E[Y\mid X=x]=x\mathbf1_{\{|x|\le R\}},\qquad
\mathbb EY^2\le3\sigma^2D/r.
\tag{16}
$$

**Proof.** A layer is selected with probability $r/D$. Multiplying this by the rounding probability and the decoded value proves the conditional mean identity, including $x=0$ and the truncated tail. For the second moment, the contribution of layer $\ell$ is $(D/r)\mathbb E[a_\ell|X|\mathbf1_{\ell}]$. Sum and apply Lemma 4.1. The random subset and random rounding must be fresh or otherwise chosen to preserve the asserted cross-sample independence; our construction uses fresh independent seeds. $\square$

### Lemma 4.3 (Confidence amplification).

Take an odd number $k\ge8\log(1/\delta)$ of independent blocks, each containing

$$
m=\left\lceil\frac{48\sigma^2D}{r\epsilon^2}\right\rceil
\tag{17}
$$

samples encoded as above. The median of their empirical averages is $(\epsilon,\delta)$-accurate on $\mathcal C(\sigma)$.

**Proof.** Each average has mean $\mu_R$ and variance at most $3\sigma^2D/(rm)\le\epsilon^2/16$. Chebyshev bounds the probability of an error exceeding $\epsilon/2$ by $1/4$. The independent bad-block indicators have means at most $1/4$, so Hoeffding bounds the probability that at least half the blocks are bad by $e^{-k/8}\le\delta$. Otherwise the median is within $\epsilon/2$ of $\mu_R$ and hence within $3\epsilon/4$ of $\mu$. $\square$

Because $D\asymp\log S$ and $D/r=\max\{1,D/(M-1)\}$, (17) proves the upper bound in (3), with all rounding terms absorbed uniformly under (1).

## 5. Localization with the full alphabet

### Lemma 5.1 (Multiary public-hash localization).

For $P\in\mathcal P(\lambda,\sigma)$ and integer $M\ge2$, a nonadaptive first batch of

$$
n_{\mathrm{loc}}
\le C\left(\frac{\log(1+\lambda/\sigma)}{\log M}
+\log(1/\delta)\right)
\tag{18}
$$

samples suffices to output a center $c$ with $|c-\mu|\le8\sigma$ except with probability $\delta$.

**Proof.** Let $a=-\lambda-8\sigma$ and $K=\lceil\lambda/(4\sigma)\rceil+2$. Use the $K$ half-open bins

$$
I_j=[a+8\sigma j,a+8\sigma(j+1)),\qquad 0\le j \lt K,
$$

and one overflow symbol $\star$ for the rest of the line. The interval $A=[\mu-4\sigma,\mu+4\sigma]$ lies strictly inside the covered interval and meets at most two bins. Chebyshev gives $P(A)\ge15/16$. Hence one bin $j_*$ has probability at least $15/32$.

For every round, publicly choose an independent random map $h_t:\{0,\ldots,K-1,\star\}\to\{1,\ldots,M\}$, whose values are independent uniform symbols. Send $Z_t=h_t(\operatorname{bin}(X_t))$. For each finite bin define

$$
S_j=\sum_{t=1}^n\mathbf1\{h_t(j)=Z_t\},
\quad p=1/M,
\quad \tau=p+(1-p)/4.
\tag{19}
$$

Output the midpoint of any bin satisfying $S_j\ge n\tau$, using a fixed tie-breaking rule; if none exists, output zero.

Let $N_j$ be the number of samples in bin $j$. Except on an event of probability at most $2e^{-n/128}$, both $N_{j_*}\ge3n/8$ and the total number of samples outside $A$ is at most $n/8$. This follows from Hoeffding, using respectively the gaps $15/32-3/8=3/32$ and $1/8-1/16=1/16$.

Condition on a sample vector satisfying these two properties. Then

$$
S_j=N_j+\operatorname{Bin}(n-N_j,p)
\tag{20}
$$

in distribution for each fixed $j$; independence across different candidate bins is not required. The conditional expectation of $S_{j_*}/n$ is at least $p+3(1-p)/8$, so another Hoeffding bound gives

$$
\Pr\{S_{j_*} \lt n\tau\mid X_1,\ldots,X_n\}\le e^{-n/128}.
$$

For any bin disjoint from $A$, $N_j\le n/8$. To pass the threshold, its nonforced collisions must have frequency at least

$$
q\ge p+(1-p)/7.
$$

The binomial Chernoff bound is $\exp(-(n-N_j)D_{\mathrm{KL}}(\operatorname{Bern}(q)\Vert\operatorname{Bern}(p)))$. If $\log M\le16$, Pinsker's inequality and $q-p\ge1/14$ give divergence at least $1/98\ge\log M/1568$. If $\log M>16$, the entropy bound gives divergence at least $q\log M-\log2\ge\log M/14$. Thus in all cases the divergence is at least $\log M/1568$, and the probability is at most $e^{-n\log M/1792}$.

A union bound over the $K$ bins yields the explicit failure bound

$$
3e^{-n/128}+K e^{-n\log M/1792}.
\tag{21}
$$

For example, taking

$$
n=\left\lceil
128\log(6/\delta)
+\frac{2048\log(2K/\delta)}{\log M}
\right\rceil
$$

makes (21) at most $\delta$ and has the order in (18). On success the chosen bin meets $A$, and its midpoint is within $4\sigma$ of a point of $A$. Consequently it is within $8\sigma$ of $\mu$. $\square$

### Lemma 5.2 (Location counting converse).

Every fixed-alphabet accurate protocol satisfies

$$
n\log M\ge\log((1-\delta)K_0),
\qquad K_0=\lfloor2\lambda/\sigma\rfloor+1.
\tag{22}
$$

Every hard-$B$-bit accurate protocol similarly satisfies $B\log2\ge\log((1-\delta)K_0)$.

**Proof.** Consider $K_0$ point masses at positions $-\lambda+j\sigma$. They belong to the distribution class. Their $\epsilon$-accuracy intervals are disjoint by (1). Fix all public, private, and decoder random seeds. The resulting deterministic $M$-ary depth-$n$ transcript tree has at most $M^n$ leaves, each of which can be correct for at most one of the point masses. Average this count over the seeds and over the uniformly chosen point mass. The average success probability is at most $M^n/K_0$, and accuracy bounds it below by $1-\delta$.

For a predictable hard-bit protocol, replace every $2^{b_t}$-ary node by its binary representation. The tree has binary depth at most $B$, so it has at most $2^B$ leaves. Early stopping does not change the bound. This uses the absence of an observation-dependent uncharged termination signal specified in Section 1.1. $\square$

### Proof of Theorem 2.1.

Run Lemma 5.1 at confidence $\delta/2$. On its success event, fresh second-stage observations obey

$$
\mathbb E[(X-c)^2]=\operatorname{Var}(X)+(\mu-c)^2\le65\sigma^2.
\tag{23}
$$

Conditionally on the first batch, apply Lemma 4.3 to $X-c$ with known raw-moment bound $\sqrt{65}\sigma$ and confidence $\delta/2$, then add $c$ back. The conditional sample law remains iid. The total error is at most $\delta$. Replacing $\sigma$ by this constant multiple changes the refinement order only by a universal factor; the extra $\log(1/\delta)$ in localization is dominated by refinement under (1). This proves the upper bound in (2).

For the converse, the testing pair of Section 3 also belongs to $\mathcal P(\lambda,\sigma)$ because $\lambda\ge\sigma\ge256\epsilon$. It supplies the refinement lower bound. Lemma 5.2 supplies the location lower bound, uniformly since $K_0\ge3$. The maximum of these two nonnegative bounds is at least half their sum. No product lower bound or simultaneous hard instance is being asserted. $\square$

## 6. Heterogeneous sensors

### Lemma 6.1 (Weighted block estimator).

Let $D$ be as in (14), and for a prescribed sequence $M_t$ put $r_t=\min\{M_t-1,D\}$. Ignore rounds with $r_t=0$. Use the subset code of Lemma 4.2 with $r=r_t$, and let its decoded value be $Y_t$. For a deterministic block $G$, define

$$
W_G=\frac{\sum_{t\in G}r_tY_t}{\sum_{t\in G}r_t},
\qquad R_G=\sum_{t\in G}r_t>0.
$$

Then $\mathbb EW_G=\mu_R$ and

$$
\operatorname{Var}(W_G)\le\frac{3\sigma^2D}{R_G}.
\tag{24}
$$

**Proof.** The mean is immediate from (16). Independence and $\operatorname{Var}(Y_t)\le3\sigma^2D/r_t$ bound the variance of the numerator by $3\sigma^2D\sum_{t\in G}r_t$. Division by $R_G^2$ gives (24). $\square$

### Proof of Theorem 2.2.

The necessity statement, including the predictable-budget variant, follows from (12)--(13). For sufficiency, let $A=48\sigma^2D/\epsilon^2$ and greedily end each block when its cumulative $r_t$ reaches $A$. Each completed block consumes less than $A+D$ capacity because every increment is at most $D$. If total $\sum_t r_t$ is at least $k(A+D)$, at least $k$ blocks can be completed. Take the first odd $k\ge8\log(1/\delta)$, and apply Chebyshev and the independent-block median argument of Lemma 4.3 using (24).

For $S\ge256$, the integer choices in (4) and (14) satisfy $L\le D\le12L$. Consequently

$$
\frac{r_t}{D}=\min\left\{1,\frac{M_t-1}{D}\right\}
\ge\frac1{12}\min\left\{1,\frac{M_t-1}{L}\right\}.
$$

A sufficiently large universal constant in (5) ensures the required number of blocks. Neither identical alphabet sizes nor identical variances of the decoded messages is needed. $\square$

This result describes capacity in terms of useful output symbols, capped by the number of statistically relevant scales. Total bit count alone is not the capacity in (4): many one-bit sensors and fewer sensors with the same total number of bits can have different values of (4).

## 7. Predictable hard bit allocation

### Lemma 7.1 (Capacity per bit).

For $L\ge1$ and real $b\ge0$,

$$
\min\left\{1,\frac{2^b-1}{L}\right\}
\le\frac{b}{\log_2(1+L)}.
\tag{25}
$$

**Proof.** Write $g=\log_2(1+L)$. On $0\le b\le g$, convexity puts $2^b-1$ below the chord joining its values $0$ and $L$, so $(2^b-1)/L\le b/g$. On $b\ge g$, the left side is at most one and $b/g\ge1$. $\square$

### Proof of Theorem 2.3.

For the converse, conditional on any history the message alphabet is at most $2^{b_t}$. By (12) and (25), a pathwise budget $B$ bounds transcript divergence by

$$
\frac{36\epsilon^2}{\sigma^2}
\mathbb E_{P_1}\sum_t
\min\left\{1,\frac{2^{b_t}-1}{L}\right\}
\le\frac{36\epsilon^2 B}{\sigma^2\log_2(1+L)}.
$$

Padding stopped transcripts with zero-bit rounds justifies the finite chain rule. Combine this with (13). This proves the refinement part of (7), while Lemma 5.2 proves its location part. Combine the two by the maximum-to-sum inequality used earlier.

For attainability, set $b=\lceil\log_2(1+L)\rceil$ and $M=2^b$. Apply the two-stage protocol in Theorem 2.1. Since $M-1\ge L$ and $L\asymp\log S$, refinement has the unquantized sample order. Multiplication by $b\asymp\log(1+\log S)$ gives its bit cost. The location term costs $b\log(1+\lambda/\sigma)/\log M=\log(1+\lambda/\sigma)/\log2$. Rounding and reliability terms are absorbed by refinement. The resulting fixed bit budget is deterministic and hence pathwise valid. $\square$

## 8. A uniform theorem near the critical moment index

This section concerns a known-center **raw** moment, not an unspecified central-moment class. For known $k\in[3/2,5/2]$, put

$$
\mathcal C_k(\sigma)=\{P:\mathbb E_P|X|^k\le\sigma^k\},\quad
S=\sigma/\epsilon\ge256,\quad 0<\delta\le1/8.
$$

The protocol conventions are unchanged. Write $n_{*,k}$ for the minimax sample budget on this class. Define

$$
J_k=\left\lfloor\frac{\log_2(S/6)}{k-1}\right\rfloor,\quad
w_j=2^{(2-k)j},\quad
H=\sum_{j=0}^{J_k}w_j,\quad W=\max_{0\le j\le J_k}w_j.
\tag{26}
$$

### Theorem 8.1 (Uniform moment-index and alphabet frontier).

For all the parameters above and every integer $M\ge2$,

$$
n_{*,k}\asymp S^2\max\{W,H/(M-1)\}\log(1/\delta).
\tag{27}
$$

The constants are uniform in $k$, including sequences of $k$ approaching two as $S$ grows. One may take lower and upper constants $1/1296$ and $400000$, respectively. The upper bound is nonadaptive. The geometric-sum upper structure in [LS26a] is prior work; the necessity uniformly in a moving moment index is the additional claim.

### Lemma 8.2 (A nearly flat dominant window).

Let $H_- =\sum_{j=1}^{J_k}w_j$, $W_- =\max_{1\le j\le J_k}w_j$, and $d=|k-2|$. For $d>0$ set $\ell=\min\{J_k,1+\lfloor1/d\rfloor\}$; for $d=0$ set $\ell=J_k$. Use the lowest $\ell$ noncentral scales if $k>2$, the highest $\ell$ if $k<2$, and all scales if $k=2$. Denote this window by $I$. Then

$$
W_-/2\le w_j\le W_-\ (j\in I),\qquad
\tfrac12W_-\ell\le H_-\le2W_-\ell,
\tag{28}
$$

and $W\le\sqrt2W_-$, $H\le3H_-$.

**Proof.** We have $J_k\ge3$. Across the window the exponent varies by at most $d(\ell-1)\le1$, proving the pointwise bound. Normalizing all noncentral weights by their maximum gives a geometric sequence of ratio $2^{-d}$. If $\ell=J_k$, its sum is at most $\ell$. Otherwise $0 \lt d\le1/2$ and $1-2^{-d}\ge d/2$, so the sum is at most $2/d<2\ell$. The selected window gives the lower bound. Finally $w_1\ge2^{-1/2}$ and $w_0=1$ imply the two central-weight comparisons. $\square$

### Lemma 8.3 (Fractional subset selection).

For any finite list $p_1,\ldots,p_N\in[0,1]$ and integer $r\ge1$ with $\sum_i p_i\le r$, there is a public random subset of size at most $r$ having exactly these inclusion probabilities.

**Proof.** Put $b_i=\sum_{h\le i}p_h$ and draw $U$ uniformly on $[0,1)$. Select interval $[b_{i-1},b_i)$ if it contains a point $U+m$ for an integer $m\ge0$. Each interval has length at most one, so contains at most one such point; its projection modulo one has measure $p_i$. There are at most $\lceil\sum_i p_i\rceil\le r$ grid points in the union. Half-open intervals remove endpoint ambiguity, and zero-length intervals are never selected. $\square$

### Lemma 8.4 (Moment-adapted quantization upper bound).

Set

$$
J_+=\left\lceil\frac{\log_2(2S)}{k-1}\right\rceil,\quad
R=\sigma2^{J_+},\quad
H_+=\sum_{j=0}^{J_+}w_j,\quad W_+=\max_{0\le j\le J_+}w_j,
$$

and $T=\max\{W_+,2H_+/(M-1)\}$. Use the signed layers of Section 4, now through $J_+$, with endpoint $a_j=\sigma2^j$. Give each signed layer inclusion probability $p_{s,j}=w_j/T$. Their sum is at most $M-1$ and each is at most one, so Lemma 8.3 supplies a subset of the required hard size. Given a selected layer, send its label with probability $|x|/a_j$ and decode the label as $s a_j/p_{s,j}$; otherwise decode zero. The resulting $Z$ obeys

$$
\mathbb E[Z\mid X=x]=x\mathbf1_{\{|x|\le R\}},\qquad
|\mathbb EZ-\mu|\le\epsilon/2,\qquad
\mathbb EZ^2<4T\sigma^2.
\tag{29}
$$

**Proof.** The mean identity follows by multiplying inclusion, rounding, and decoding factors. The tail bias is at most $\sigma^k/R^{k-1}\le\epsilon/2$. On an outer layer,

$$
\mathbb E[Z^2\mid X=x]
=T\sigma^{2-k}a_j^{k-1}|x|
\le2^{k-1}T\sigma^{2-k}|x|^k.
$$

The central-layer contribution is at most $T\sigma^2$. Integration gives the second-moment bound because $1+2^{k-1}<4$ in the stated range.

Blocks of $m=\lceil64TS^2\rceil$ samples have deviation probability at most $1/4$ at tolerance $\epsilon/2$ about $\mathbb EZ$. The median of $2\lceil4\log(1/\delta)\rceil+1$ blocks succeeds with probability at least $1-\delta$, by the same argument as Lemma 4.3. Fresh independent seeds are used across samples.

Finally $0\le J_+-J_k\le9$. Each additional weight is at most $32W$, so $W_+\le32W$ and $H_+\le289H$. Thus $T\le578\max\{W,H/(M-1)\}$. The stated number of blocks and rounding of $m$ give an upper constant below $400000$ in (27). $\square$

### Lemma 8.5 (Uniform critical-window converse).

On the window $I$ of Lemma 8.2, set

$$
a_j=\sigma2^j,\qquad q_j=\frac{\sigma^k}{2\ell a_j^k},\qquad
d_j=\frac{3\epsilon}{2\ell a_j}.
\tag{30}
$$

Form a symmetric null with mass $q_j$ at $\pm a_j$ and the remaining mass at zero. Shift mass $d_j$ from $-a_j$ to $+a_j$ at every window scale to form the alternative. Both laws are in $\mathcal C_k(\sigma)$ with means $0,3\epsilon$, and every stochastic $M$-symbol encoder satisfies

$$
D_{\mathrm{KL}}(P_1Q\Vert P_0Q)
\le\frac{432}{S^2}\min\{1/W,(M-1)/H\}.
\tag{31}
$$

**Proof.** The total nonzero null mass is $\ell^{-1}\sum_{j\in I}2^{-kj}\le2^{-k}<1/2$. Moreover

$$
d_j/q_j=3\epsilon a_j^{k-1}/\sigma^k
\le(3/S)2^{J_k(k-1)}\le1/2.
$$

Positivity, normalization, the means, and the unchanged raw $k$th moment now follow exactly by summing the opposite perturbations. The raw chi-square divergence is

$$
\chi^2(P_1\Vert P_0)
=\frac{9\epsilon^2}{\ell\sigma^k}\sum_{j\in I}a_j^{k-2}
\le\frac{18}{S^2W_-}.
\tag{32}
$$

For a cell not containing zero, let $j_*$ be its smallest represented scale. Its base mass is at least $q_{j_*}$ and its absolute perturbation is at most $2d_{j_*}$. Therefore its chi-square contribution is at most

$$
\frac{18\epsilon^2a_{j_*}^{k-2}}{\ell\sigma^k}
\le\frac{36}{S^2\ell W_-}.
$$

The cell containing zero is again controlled by the sum of the other contributions. There are at most $M-1$ nonzero cells, so data processing and (32) give

$$
D_{\mathrm{KL}}(P_1Q\Vert P_0Q)
\le\frac{18}{S^2W_-}\min\{1,4(M-1)/\ell\}.
$$

Using (28) and then $W\le\sqrt2W_-$, $H\le3H_-$ gives (31). Stochastic kernels are treated by independent seed realization, just as in Lemma 3.3. Conditional use of (31), the KL chain rule, and the test in Lemma 3.4 prove the lower bound in (27), with constant $1/1296$. $\square$

Lemmas 8.4--8.5 complete the proof of Theorem 8.1.

### Corollary 8.6 (Critical window, heterogeneous capacity, and total bits).

Uniformly in this moment range,

$$
W\asymp\max\{1,S^{(2-k)/(k-1)}\},\qquad
H/W\asymp\min\{1+\log S,\ 1+1/|k-2|\},
\tag{33}
$$

where $1/0=+\infty$. Thus the relative quantization penalty is controlled by $H/W$, and the crossover occurs at $|k-2|\log S$ of constant order.

For a prescribed sequence $M_t\ge1$, the necessary and sufficient effective resource, up to universal constants, is

$$
\sum_t\min\{1/W,(M_t-1)/H\}
\asymp S^2\log(1/\delta).
\tag{34}
$$

Here, as in Theorem 2.2, necessity means a lower threshold and sufficiency means an upper threshold with possibly different universal constants. For predictable adaptive alphabets the necessary threshold uses the expectation under the alternative in Lemma 8.5. In the raw-moment class the smallest total hard bit budget is

$$
B_{*,k}\asymp S^2W\log(1+H/W)\log(1/\delta).
\tag{35}
$$

**Proof.** The formula for $W$ follows directly from (26) and the floor operation; the factor six changes its value by a bounded factor because $|2-k|/(k-1)\le1$. Lemma 8.2 gives $H/W\asymp\ell$, while $J_k\asymp\log S$ uniformly, proving (33).

For (34), sum (31) and use (13). To achieve it, omit $M_t=1$ rounds, set $T_t=\max\{W_+,2H_+/(M_t-1)\}$ and weight each independent decoded observation by $\alpha_t=1/T_t$. A block of total weight $A$ has mean equal to the common truncated mean and variance at most $4\sigma^2/A$. Since $\alpha_t\le1$, greedy blocks reaching weight $64S^2$ each use less than $64S^2+1$. The median argument gives confidence $1-\delta$. From Lemma 8.4,

$$
\alpha_t\ge\frac1{578}\min\{1/W,(M_t-1)/H\},
$$

so a universal multiple of the resource in (34) suffices.

For (35), put $D_0=H/W\ge1$. The per-round divergence bound is at most $432/(S^2W)$ times $\min\{1,(2^{b_t}-1)/D_0\}$. Lemma 7.1 with real parameter $D_0$ and the pathwise bit bound give the converse. For the upper bound choose $b=\lceil\log_2(1+D_0)\rceil$, so Theorem 8.1 needs $O(S^2W\log(1/\delta))$ observations, each using $b$ bits. Since $D_0\ge1$, rounding $b$ changes the order only by a universal constant. $\square$

This section does not claim a new geometric-sum upper-bound architecture: [LS26a, Remark 8 and Appendix A] already display that structure and its near-critical upper constants. The lower proof selects a nearly flat window at the dominant end of those weights, making the same divergence necessary with constants uniform in a moving moment index. The supplementary theorem is deliberately confined to a known-center raw-moment bound; the finite-variance unknown-location theorem in Section 5 is the separate result that treats central variance.

## 9. Interpretation, reproducibility, and limitations

For a fixed hard precision $b$ with $M=2^b$, the refinement penalty is of order $\max\{1,\log S/(2^b-1)\}$. Thus the required number of output symbols, and not only the number of bits, controls the finite-variance penalty. Once the number of symbols is comparable with $\log S$, additional precision does not improve the minimax sample order. Allocating precision beyond this saturation point may waste bits even though it can change constants.

The total-bit converse makes a separate statement: even when the bit allocation is chosen from earlier observations, the worst-case hard budget must pay the doubly logarithmic refinement factor. It does not prohibit advantages from batching several local observations, correlated sources, retained local state, distribution-specific assumptions, expected-length codes, or charged interactive protocols different from the present model.

The supplied standard-library program checks the finite testing pair, enumerates all set partitions for small supports, and verifies exact moments of the subset quantizer on finite rational distributions. These checks can expose implementation and algebraic mistakes. They do not establish the statements for every distribution or every sequential protocol; those are supplied by the written arguments. No experimental data, simulated confidence curve, or finite enumeration replaces any of the proofs above.

The location sketch uses a publicly specified random table of size proportional to the number of coarse bins. We make no claim of a computationally optimal decoder or a short description of that table. The values of $\sigma,\lambda,\epsilon,\delta$ are known; adaptation to an unknown scale and time-uniform confidence are outside the stated scope. Lower bounds use a fixed sample budget or a pathwise hard communication budget. Sharp constants and unrestricted nonadaptive attainability for every $M$ in the unknown-location model are not asserted.

## References

- **[LS26a]** Ivan Lau and Jonathan Scarlett. *Order-Optimal Sequential 1-Bit Mean Estimation in General Tail Regimes*. arXiv:2604.07796v2, 22 May 2026. [Full text](https://arxiv.org/html/2604.07796v2). The finite-variance construction is in Appendix B.1; the geometric allocation and moment-bound transition are in Appendix A.
- **[LS26b]** Ivan Lau and Jonathan Scarlett. *Non-Adaptive 1-Bit Mean Estimation: Minimax Rates and the Sample-Interval Tradeoff*. arXiv:2609.08564v1, 8 September 2026. [Full text](https://arxiv.org/pdf/2609.08564v1). Its interval-complexity parameter constrains the sets used by binary queries; it is not an output alphabet size.
- **[MT21]** Prathamesh Mayekar and Himanshu Tyagi. *RATQ: A Universal Fixed-Length Quantizer for Stochastic Optimization*. IEEE Transactions on Information Theory 67(5), 3130--3154, 2021. DOI: [10.1109/TIT.2021.3058663](https://doi.org/10.1109/TIT.2021.3058663). [Accessible author manuscript](https://arxiv.org/pdf/1908.08200v3). The technical comparison uses the accessible manuscript, especially Sections 4.1--4.3; it does not assume that every detail is byte-identical to the publisher version.
- **[KD22]** Alon Kipnis and John C. Duchi. *Mean Estimation from One-Bit Measurements*. IEEE Transactions on Information Theory 68(9), 6276--6296, 2022. DOI: [10.1109/TIT.2022.3174409](https://doi.org/10.1109/TIT.2022.3174409). [Author manuscript](https://arxiv.org/abs/1901.03403v4).
- **[CW24]** T. Tony Cai and Hongji Wei. *Distributed Gaussian Mean Estimation under Communication Constraints: Optimal Rates and Communication-Efficient Algorithms*. Journal of Machine Learning Research 25(37), 1--63, 2024. [Publisher full text](https://www.jmlr.org/papers/volume25/21-0316/21-0316.pdf). The comparison uses the model, scalar rates, and the non-Gaussian extensions in Sections 1 and 4.
- **[M26]** Yuchen Miao. *Universal Refinement without Interaction: Order-Optimal 1-Bit Mean Estimation*. arXiv:2607.24358. [Author's accompanying repository](https://github.com/yuchenmiao04/onebitmean). Used to delimit prior nonadaptive one-bit attainability, not as an ingredient in our proofs; the author repository was inspected, while the paper's full text was not retrievable in this audit.

The literature statement is restricted to the sources and versions actually checked. No worldwide priority or external acceptance is certified by this manuscript.
