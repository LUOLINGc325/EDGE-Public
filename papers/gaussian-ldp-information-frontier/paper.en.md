# A sharp privacy–communication frontier for Gaussian Fisher information

Scalar score laws, exact constants, and finite-output attaining mechanisms

## Abstract

We determine the sharp loss of local Fisher information when a scalar Gaussian observation is released through a pure locally differentially private channel with a growing output alphabet. Write $c=e^\varepsilon-1$ and suppose the alphabet budget satisfies $K_c/c^{1/3}\to\kappa\in(0,\infty]$. The optimal information loss, multiplied by $c^{2/3}$, converges to an explicit variational frontier. Its integrand consists of the usual scalar quantization term $\phi/(12g^2)$ and a spatial privacy cost $(1+x^2)g$. The unique minimizing cell density is proportional to $[\phi/(1+x^2+\lambda)]^{1/3}$, with a multiplier determined by the communication budget. A finite critical budget separates a strictly decreasing frontier from a plateau. The converse applies to every admissible channel, and the unconstrained result allows every standard Borel output space. We give finite-output attaining constructions with controlled Gaussian tails. The same theorem holds for centered score laws with a continuous strictly positive density on a nondegenerate compact interval. Finite-alphabet sort–partition–randomize structure, high-resolution quantization principles, the privacy exponent, and cube-root alphabet scales all have precedents; the contribution studied here is the sharp joint all-channel limit and its complete budget dependence.

This research manuscript presents analytical proofs and a numerical reproduction program. The proofs have not been machine checked.

## 1. Problem, contribution, and previous work

For a centered real random variable $X$ with variance $v$, a released observation $Z$ retains the scalar score information

$$
J(Q)=\mathbb E\!\left[(\mathbb E[X\mid Z])^2\right].
\tag{1}
$$

The loss $v-J(Q)$ is the smallest mean squared error for reconstructing $X$ from $Z$. For a Gaussian location model at a fixed operating point, (1) is also the Fisher information of the privatized observation. This equivalence connects mechanism design to scalar approximation without imposing unbiasedness on the reconstruction.

Steinberger [R1] establishes the statistical efficiency meaning of the supremal private Fisher information. Kalinin and Steinberger [R2] identify the exact Gaussian sign mechanism in a high-privacy range and leave larger privacy parameters as an open mechanism-optimization direction. The present work resolves one precise asymptotic portion of that direction: privacy weakens, meaning $\varepsilon\to\infty$, while the communication budget grows on the relevant scale. It does not identify the finite-$\varepsilon$ optimizer or the first departure from sign randomization.

Several ingredients must be credited separately. Kairouz, Oh, and Viswanath [R3] develop finite staircase mechanisms. Ghazi, Nasser, Calmon, and Issa [R4] prove the finite-input sort–partition–randomize structure, including a bounded output alphabet and an interval-flow decomposition. Their quadratic-divergence consequence already covers finite scalar-score information. Amorino and Gloter [R5, version 2] establish continuous extremal factorization and strong duality, while [R6] gives mechanisms recovering nonprivate information as privacy weakens. We provide a direct continuous squared-loss reduction because its preservation of the output budget is needed below; finite SPR and interval-flow decomposition are not new principles here.

The high-resolution point-density method is classical; [R7] is a technically relevant quantization reference. The exponent $e^{-2\varepsilon/3}$ is also not new: it occurs in additive central privacy [R8] and in a bounded-input local-privacy construction [R9, Eq. (33)]. More closely, SSTQ [R10, version 3, Section 4] analyzes stochastic interpolation followed by randomized response, includes a spatial privacy penalty, and uses a cube-root effective alphabet construction. These are real precedents for the mechanism and scale. They do not supply the all-channel Fisher-information converse, the Gaussian tail analysis, or the exact function of $K_c/c^{1/3}$ proved below. Privacy with communication constraints is also studied for hypothesis testing in [R11], with a different statistical objective and approximation criterion.

Our contribution is a single linked statement: matching converse and construction over the complete channel class, an exact leading constant for every positive limiting normalized alphabet budget, an explicit unique optimizing cell density, and a finite saturation threshold. The compact score-law extension shows how the constant depends on the source rather than on a Gaussian calculation alone.

Earlier LDP distortion optimization includes Sarwate and Sankar [R12], whose main exact result concerns binary Hamming distortion. One access limitation remains: the full journal text of Zhang and Venkitasubramaniam [R13] was not obtained. Its available abstract describes distribution-level inference privacy, consistent with the source-label model in the fully inspected precursor [R14]. That precursor cannot establish the journal version's precise definitions or complete theorem scope. The novelty assessment is restricted to the sources and versions actually inspected; it is not a claim that every relevant journal full text has been checked.

## 2. Definitions and main theorem

### 2.1 Admissible score laws and channels

Let $S$ and $f$ satisfy one of the following conditions:

1. **Gaussian case:** $S=\mathbb R$ and $f=\phi$, where $\phi(x)=(2\pi)^{-1/2}e^{-x^2/2}$.
2. **Compact case:** $S=[a,b]$ with $a \lt b$, $f$ is continuous and strictly positive on $[a,b]$, $\int_a^b f=1$, and $\int_a^b xf(x)\,dx=0$.

In both cases write $v=\int_S x^2f(x)\,dx>0$ and $w(x)=v+x^2$. Continuity at compact endpoints is meant on the interval; extending $f$ by zero need not give a continuous function on the line.

For $c>0$, a channel $Q$ is admissible if it is a Markov kernel from $S$ to its stated output space and

$$
Q(A\mid x)\le(1+c)Q(A\mid x')
\quad\text{for every }x,x'\in S\text{ and every measurable }A.
\tag{2}
$$

This is pure $\varepsilon$-local differential privacy with $\varepsilon=\log(1+c)$. The condition holds for all inputs, not merely almost every pair. Kernels on compact $S$ can be extended to all real inputs by using an endpoint row outside $S$; this changes neither attainable information nor privacy.

For an integer $K\ge1$, let $I_f^*(c,K)$ be the supremum of (1) over channels with at most $K$ output symbols. The unrestricted quantity $I_f^*(c,\infty)$ takes the supremum over all standard Borel output spaces. Set

$$
\delta_f^*(c,K)=v-I_f^*(c,K).
\tag{3}
$$

Neither supremum is assumed attained. The budget counts transmitted symbols, not expected code length. A fixed $b$-bit representation is included by taking $K\le2^b$.

### 2.2 The exact frontier

Define $A_0=3/(2\,6^{1/3})$ and, for $\lambda\ge0$,

$$
g_\lambda(x)=\left[\frac{f(x)}{6(w(x)+\lambda)}\right]^{1/3},
\qquad G(\lambda)=\int_S g_\lambda(x)\,dx,
\qquad \kappa_*=G(0).
\tag{4}
$$

For $0<\kappa<\infty$ put

$$
\mathcal C_f(\kappa)=
\inf_{\substack{g>0\ {\rm a.e.}\\ \int_Sg\le\kappa}}
\int_S\left\{\frac{f(x)}{12g(x)^2}+w(x)g(x)\right\}dx.
\tag{5}
$$

The infimum is over measurable functions; an infinite integral is allowed as a candidate value. Let $\mathcal C_f(\infty)$ denote the same problem without a mass constraint. All quantities in (4) are finite for the stated laws.

**Theorem 1 (sharp joint frontier).** For either admissible score law, for every sequence $c\to\infty$ and every integer budget sequence $K_c\ge1$ such that $K_c/c^{1/3}\to\kappa\in(0,\infty]$,

$$
\lim_{c\to\infty}c^{2/3}\delta_f^*(c,K_c)=\mathcal C_f(\kappa).
\tag{6}
$$

For unrestricted standard Borel outputs,

$$
\lim_{c\to\infty}c^{2/3}\delta_f^*(c,\infty)
=\mathcal C_f(\infty)
=A_0\int_S f(x)^{1/3}w(x)^{2/3}\,dx.
\tag{7}
$$

If $0<\kappa<\kappa_*$, there is a unique $\lambda>0$ with $G(\lambda)=\kappa$. Otherwise take $\lambda=0$. In every case the unique optimizer of (5), up to null sets, is $g_\lambda$, and

$$
\mathcal C_f(\kappa)
=A_0\int_S f(x)^{1/3}(w(x)+\lambda)^{2/3}\,dx-\lambda\kappa
\quad(\kappa<\infty).
\tag{8}
$$

Thus $\mathcal C_f(\kappa)=\mathcal C_f(\infty)$ exactly when $\kappa\ge\kappa_*$. Finite interval quantizers followed by randomized response attain every limit in (6) and (7), as specified in Sections 6 and 7.

The theorem imposes neither additive noise, symmetry, unbiased reconstruction, nor a prescribed quantizer on competing channels. Interval mechanisms suffice before any high-resolution approximation is made.

### 2.3 Fisher-information interpretation

**Proposition 2 (local Gaussian information).** Fix a design point $\theta_0$ in $Y\sim N(\theta,1)$, apply a fixed channel to $X=Y-\theta_0$, and differentiate the resulting experiment at $\theta=\theta_0$. Its Fisher information is $J(Q)$ in (1) with $X\sim N(0,1)$.

**Proof.** At the design point, the likelihood ratio for an input displacement $t$ is $L_t(X)=e^{tX-t^2/2}$. Its image likelihood ratio relative to the output law at zero is $r_t(Z)=\mathbb E[L_t(X)\mid Z]$. Gaussian exponential moments imply $(L_t-1)/t\to X$ in $L^2$. Conditional expectation is a contraction, so $(r_t-1)/t\to H:=\mathbb E[X\mid Z]$ in $L^2$, and $r_t\to1$ in probability. The identity

$$
\frac{\sqrt{r_t}-1}{t}=\frac{(r_t-1)/t}{\sqrt{r_t}+1}
$$

and $1/(\sqrt{r_t}+1)\le1$ give convergence to $H/2$ in $L^2$: separate the numerator's $L^2$ error and use dominated convergence in probability for the remaining $H$ term. This is differentiability in quadratic mean with score $H$, whose second moment is (1). Standard Borel outputs are included. $\square$

The mechanism is held fixed when differentiating and does not observe the unknown true mean. Theorem 1 is local channel optimization. A theorem in which privacy, communication, and sample size change jointly would require additional statistical work.

## 3. Exact reduction to interval randomized response

### 3.1 Squared loss and finite output channels

**Lemma 3 (Bayes loss).** For every admissible channel,

$$
v-J(Q)=\mathbb E[(X-\mathbb E[X\mid Z])^2]
=\inf_a\mathbb E[(X-a(Z))^2].
\tag{9}
$$

**Proof.** Conditional expectation gives
$\mathbb E[(X-a(Z))^2]=\mathbb E[(X-H)^2]+\mathbb E[(H-a(Z))^2]$ whenever the risk is finite, and $\mathbb E[XH]=\mathbb E[H^2]$. Reconstructions of infinite risk cannot lower the infimum. $\square$

An interval partition $\pi=(I_1,\ldots,I_k)$ consists of consecutive intervals covering $S$, with disjoint interiors and positive lengths. Endpoints are assigned consistently. Its randomized-response channel is

$$
Q_\pi(j\mid x)=\frac{1+c\mathbf1_{I_j}(x)}{c+k}.
\tag{10}
$$

Rows sum to one and the column ratios are at most $1+c$, so (10) satisfies (2).

**Lemma 4 (continuous SPR with preserved alphabet budget).** For every finite-output admissible channel with at most $K$ active symbols, there exists a partition channel (10) with $k\le K$ and $J(Q_\pi)\ge J(Q)$.

**Proof.** Write $q_i(x)=Q(i\mid x)$ for the $m\le K$ active columns and $a_i=\mathbb E[X\mid Z=i]$. Merge columns with equal reconstruction means. This preserves privacy and Bayes risk, so the remaining means are distinct. In the compact case all $a_i$ lie strictly inside $[a,b]$ because active private columns and the input density are everywhere positive.

Let

$$
b_i=\inf_{x\in S}q_i(x),\qquad B=\sum_i b_i,\qquad h=\frac{1-B}{c}.
\tag{11}
$$

Each $b_i>0$: an active column is positive at some input, and privacy bounds every other value below by that value divided by $1+c$. Taking an infimum in the reverse comparison gives $q_i(x)\le(1+c)b_i$ even if the infimum is not attained. Thus $1/(1+c)\le B\le1$ and $0\le h\le B$.

If $h=0$, then $B=1$ and $q_i(x)=b_i$ everywhere; a one-cell uninformative channel suffices. Otherwise fix the reconstruction values $a_i$. Allocate the remaining mass $h$ among capacities $b_i$, in increasing order of $(x-a_i)^2$:

$$
q_i'(x)=b_i+c\,t_i(x),\qquad
t_i(x)=\min\{b_i,(h-B_i(x))_+\},
\tag{12}
$$

where $B_i(x)$ is the sum of capacities ranked before $i$, with a fixed tie order. This minimizes a finite linear allocation problem: shifting mass from a more costly available position to a less costly unfilled position cannot increase risk, and successive shifts give (12). Rows still sum to one, columns stay in their privacy boxes, and the loss with fixed $a_i$ does not increase.

For $x\le a_i$, a center to the right of $a_i$ cannot be closer than $a_i$, and a center to its left ceases to be closer when $x$ crosses their midpoint. Therefore $B_i$ is nonincreasing on the left of $a_i$ and nondecreasing on its right. The finite step function $t_i$ is consequently nondecreasing to $a_i$ and nonincreasing afterwards. All its nonempty positive-level sets are nested intervals containing a neighborhood of $a_i$. The finitely many ties have probability zero. Redefine their rows by the appropriate one-sided limiting row, retaining the boxes and row sum and assigning interval endpoints consistently. In the compact case the right endpoint uses the left limiting row. These changes preserve information and pointwise privacy.

Use the layer-cake identity

$$
q_i'(x)=\int_0^{b_i}\left(1+c\mathbf1_{\{t_i(x)>u\}}\right)du.
\tag{13}
$$

There are finitely many levels. Thus each column splits into finitely many columns $\alpha_e(1+c\mathbf1_{I_e})$, with empty level sets giving constant columns. Refinement can only improve Bayes risk. Row normalization gives

$$
\sum_{e:\ I_e\ne\varnothing}\alpha_e\mathbf1_{I_e}(x)=h.
\tag{14}
$$

Represent each nonempty interval as a directed edge between its endpoints, including the endpoints of $S$ (infinite in the Gaussian case). Order all endpoints. Equation (14) implies equal incoming and outgoing weights at every internal endpoint. This is a finite acyclic flow of value $h$. Follow positive edges from the first endpoint to the last, subtract the minimum edge weight on the path, and repeat. Conservation guarantees continuation, and each subtraction exhausts at least one edge. This gives a finite path decomposition with weights $r_\pi>0$.

Each path is an interval partition with $k_\pi$ cells. Its raw columns $r_\pi(1+c\mathbf1_I)$ have total probability $(c+k_\pi)r_\pi$, independent of $x$; normalization gives (10). Empty-interval columns are uninformative one-output components. The mixture weights sum to one:

$$
\sum_\pi(c+k_\pi)r_\pi+\sum_{e:\ I_e=\varnothing}\alpha_e
=ch+\sum_e\alpha_e=ch+B=1.
\tag{15}
$$

A column contributes $(\int xqf)^2/\int qf$ to $J$, a positively homogeneous function of $q$. Splitting a column proportionally among paths therefore preserves utility. The refined utility is the weighted average of the component utilities, so one partition component is at least as informative as the original. If all components have zero information, the one-cell partition suffices.

Finally, all nonempty layer intervals from one original column $i$ are nested and share a neighborhood of $a_i$. A path has cells with disjoint interiors, so it cannot use two such layers. Each path therefore has at most $m\le K$ cells. The intermediate refinement may have more symbols, but the selected partition respects the original alphabet cap. $\square$

### 3.2 Unrestricted outputs

**Lemma 5 (finite approximation of unrestricted information).** For every fixed $c>0$,

$$
I_f^*(c,\infty)=\sup_{K<\infty}I_f^*(c,K).
\tag{16}
$$

**Proof.** For a standard Borel output choose a measurable version $H(Z)=\mathbb E[X\mid Z]\in L^2$. Truncate and quantize it to finite-valued $H_n(Z)$ with $\|H_n-H\|_2\to0$, and let $T_n$ label their level sets. Postprocessing preserves (2), while

$$
\mathbb E[X\mid T_n]=\mathbb E[H\mid T_n],\qquad
\|H-\mathbb E[H\mid T_n]\|_2\le\|H-H_n\|_2.
$$

Thus their information converges to $J(Q)$. Taking suprema gives (16), after which Lemma 4 gives partition approximants. No uniform cardinal bound is assumed. $\square$

## 4. Exact information loss for a partition

For a partition cell define

$$
p_j=\int_{I_j}f,\quad m_j=\int_{I_j}xf,\quad
\mu_j=m_j/p_j,\quad
D=\sum_j\int_{I_j}(x-\mu_j)^2f(x)\,dx.
\tag{17}
$$

All $p_j>0$, and $D=v-\sum_j\mu_j^2p_j$.

**Lemma 6 (exact loss identity).** For (10),

$$
J(Q_\pi)=\frac{c^2}{c+k}\sum_j\frac{m_j^2}{1+cp_j}.
\tag{18}
$$

Writing $\delta=v-J(Q_\pi)$ gives the equivalent identities

$$
\left(1+\frac{k}{c}\right)\delta
=D+\frac{kv}{c}+\sum_j\frac{\mu_j^2p_j}{1+cp_j},
\tag{19}
$$

$$
\delta=D+\frac{k}{c+k}(v-D)
+\frac{c}{c+k}\sum_j\frac{\mu_j^2p_j}{1+cp_j}.
\tag{20}
$$

In particular,

$$
D\le\delta,\qquad \frac{kv}{c+k}\le\delta,\qquad
\delta\le D+\frac1c\sum_j(v+\mu_j^2).
\tag{21}
$$

**Proof.** Output $j$ has probability $(1+cp_j)/(c+k)$ and unnormalized score mean $cm_j/(c+k)$, since $\int xf=0$. This gives (18). Substitute $m_j=\mu_jp_j$, use $cp_j/(1+cp_j)=1-1/(1+cp_j)$ and $\sum\mu_j^2p_j=v-D$, and simplify. All terms of (20) are nonnegative. The second bound follows from (19). For the last, use $v-D\le v$, $c+k\ge c$, and $p_j/(1+cp_j)\le1/c$. $\square$

No expansion of $1/(cp_j)$ is used, which is essential for tiny cells. A partition sequence with $\delta=O(c^{-2/3})$ has $D=O(c^{-2/3})$ and $k=O(c^{1/3})$: (21) implies $k/c\le\delta/(v-\delta)$ eventually. This bound concerns the selected partition representation. An arbitrary channel can split symbols into redundant labels without changing information, so its literal alphabet size need not satisfy this upper bound.

## 5. Converse for every admissible channel

**Lemma 7 (sharp cell inequality).** For $a,w,\Delta,c>0$,

$$
\frac{a\Delta^3}{12}+\frac wc
\ge A_0c^{-2/3}a^{1/3}w^{2/3}\Delta,
\tag{22}
$$

with equality exactly when $\Delta^3=6w/(ca)$.

**Proof.** Divide by $\Delta$ and minimize $a\Delta^2/12+w/(c\Delta)$. Its derivative changes from negative to positive at the stated point, whose value is the right-hand coefficient. $\square$

**Lemma 8 (partition converse).** Suppose $k_c\le K_c$, $K_c/c^{1/3}\to\kappa<\infty$, and a partition sequence has bounded $c^{2/3}\delta_c$. For every fixed $\lambda\ge0$,

$$
\liminf_{c\to\infty}c^{2/3}\delta_c
\ge A_0\int_S f(x)^{1/3}(w(x)+\lambda)^{2/3}\,dx-\lambda\kappa.
\tag{23}
$$

Without an alphabet cap, the same assertion with $\lambda=0$ holds for every partition sequence with bounded scaled loss.

**Proof.** By (21), $D_c=O(c^{-2/3})$, $k_c=O(c^{1/3})$, and $k_c/c\to0$. Work on a fixed compact interval $J$ where $f$ has positive minimum $m_J$. Take $J=[-T,T]$ for the Gaussian and $J=S$ for compact support. A cell intersecting $J$ in length $\ell$ contributes at least

$$
m_J\inf_u\int_{\text{intersection}}(x-u)^2dx=m_J\ell^3/12
\tag{24}
$$

to $D_c$. Thus the maximum intersection length tends to zero. For the Gaussian discard the at most two cells crossing the boundary of $J$; their total length inside $J$ tends to zero. Compact support has no such cells.

Set $A_c=c^{1/6}$. Discard also interior cells with $cp_j \lt A_c$. Their total length is at most

$$
\frac{k_cA_c}{cm_J}=O(c^{-1/2})\longrightarrow0,
\tag{25}
$$

because $p_j\ge m_J\Delta_j$. Put $\eta_c=A_c/(1+A_c)\to1$. Retained cells satisfy $cp_j/(1+cp_j)\ge\eta_c$ and $\mu_j\in I_j$. Their distortion is at least $f_{j,\min}\Delta_j^3/12$. Add $\lambda k_c/c$ to both sides of (19), allocate $(v+\lambda)/c$ to each cell, and discard nonretained nonnegative terms:

$$
\left(1+\frac{k_c}{c}\right)\delta_c+\frac{\lambda k_c}{c}
\ge\sum_{j\ {\rm retained}}\left\{
\frac{f_{j,\min}\Delta_j^3}{12}
+\frac{\eta_c(v+\lambda+\mu_j^2)}c\right\}.
\tag{26}
$$

Apply (22). On $J$, continuity is uniform, the retained mesh tends to zero, and discarded length tends to zero. Therefore

$$
\sum_{j\ {\rm retained}}
f_{j,\min}^{1/3}(v+\lambda+\mu_j^2)^{2/3}\Delta_j
\longrightarrow\int_J f^{1/3}(w+\lambda)^{2/3}.
\tag{27}
$$

After multiplication by $c^{2/3}$ the extra loss factor disappears, since $(k_c/c)c^{2/3}\delta_c\to0$. For finite $\kappa$, use $\lambda k_c/c^{1/3}\le\lambda K_c/c^{1/3}\to\lambda\kappa$. This proves (23) on $J$. Let $T\to\infty$ for the Gaussian, using the positive integrable full-line integrand. The compact case is already complete. In the uncapped case use $\lambda=0$; the necessary bound on $k_c$ came from the loss, not the budget. $\square$

To pass to infima, any unbounded scaled liminf already satisfies the lower bound. On a subsequence with finite scaled liminf choose channels within $c^{-1}=o(c^{-2/3})$ of the optimal loss. For finite $K$, Lemma 4 gives a dominating partition without exceeding the budget. For unrestricted outputs first choose a finite postprocessing using Lemma 5 with information loss at most another $c^{-1}$, then apply Lemma 4. These approximants may depend on $c$; uniformity in cardinality is not assumed. Lemma 8 proves the converse for the original complete channel classes.

## 6. Solving the variational problem and the compact construction

### 6.1 Explicit optimizer and dual formula

**Lemma 9 (variational solution).** Formula (8) and its unique optimizer hold, and

$$
\mathcal C_f(\kappa)=\sup_{\lambda\ge0}
\left\{A_0\int_S f^{1/3}(w+\lambda)^{2/3}-\lambda\kappa\right\},
\quad 0<\kappa<\infty.
\tag{28}
$$

**Proof.** For $\lambda\ge0$, pointwise minimization over $g>0$ gives

$$
\frac{f}{12g^2}+(w+\lambda)g
\ge A_0 f^{1/3}(w+\lambda)^{2/3},
\tag{29}
$$

with equality precisely at $g_\lambda$. The function $G$ is continuous and strictly decreasing from $0 \lt G(0)<\infty$ to zero. Dominated convergence and strict pointwise monotonicity prove this: Gaussian envelopes are a polynomial times $e^{-x^2/6}$; compact bounds are immediate. Choose the unique positive multiplier with $G(\lambda)=\kappa$ if $\kappa \lt G(0)$, and zero otherwise. Then $g_\lambda$ is feasible and $\lambda(G(\lambda)-\kappa)=0$.

Integrating (29), and using $-\lambda\int g\ge-\lambda\kappa$, bounds every feasible objective below. The chosen $g_\lambda$ attains equality. This proves (8) and (28) without an additional infinite-dimensional duality theorem. Strict convexity of the integrand where $f>0$ forces uniqueness almost everywhere. For the unconstrained problem take $\lambda=0$. $\square$

Optimizing (23) now gives the lower half of Theorem 1.

### 6.2 Compact support

**Lemma 10 (compact attainment construction).** For compact $S$ and $\kappa\in(0,\infty]$, partition channels with at most $K_c$ symbols attain a scaled limsup at most $\mathcal C_f(\kappa)$ when $K_c/c^{1/3}\to\kappa$. The construction also works without a budget.

**Proof.** Fix $g=g_\lambda$ and $\gamma=\int_S g$. For finite $\kappa$, $\gamma=\min(\kappa,\kappa_*)$; otherwise $\gamma=\kappa_*$. Set

$$
n_c=\min\{K_c,\lceil c^{1/3}\gamma\rceil\},
\tag{30}
$$

omitting the minimum when unrestricted. Then $n_c/(c^{1/3}\gamma)\to1$. Partition $[a,b]$ into $n_c$ cells of equal $g$-mass $a_c=\gamma/n_c$. Their endpoints are uniquely specified by the continuous strictly increasing integral of $g$. Since $g$ is bounded below by a positive constant, the maximal cell width is $O(c^{-1/3})$ and $c^{1/3}a_c\to1$.

A cell of width $\Delta$ has centroid distortion between $f_{\min}\Delta^3/12$ and $f_{\max}\Delta^3/12$: minimize the constant-density integral for the lower bound and use the midpoint for the upper bound. Uniform continuity and positivity of $f,g$ therefore yield

$$
D=(1+o(1))\frac{a_c^2}{12}\int_S\frac{f}{g^2}.
\tag{31}
$$

Indeed $a_c=(1+o(1))g(x)\Delta$ uniformly on each cell, so its distortion equals $(1+o(1))a_c^2\int_I f/g^2\,/12$. Likewise $\mu_j\in I_j$ and $w\ge v>0$ give

$$
\frac1c\sum_jw(\mu_j)
=(1+o(1))\frac1{ca_c}\int_Sw(x)g(x)\,dx.
\tag{32}
$$

Use (21), multiply by $c^{2/3}$, and note that $c^{2/3}a_c^2\to1$ and $c^{-1/3}/a_c\to1$. The limiting upper bound is the objective at $g_\lambda$. $\square$

## 7. Gaussian construction with controlled tails

**Lemma 11 (Gaussian attainment construction).** Lemma 10 holds for the Gaussian score law, with the following expanding-core construction.

**Proof.** Fix $g=g_\lambda$. For sufficiently large $c$ set

$$
T_c=\sqrt{\frac53\log c},\qquad
G_c=\int_{-T_c}^{T_c}g(x)\,dx,\qquad
n_c=\min\{K_c-2,\lceil c^{1/3}G_c\rceil\}.
\tag{33}
$$

Take $\lambda=0$ when $\kappa=\infty$ or there is no budget, and omit the minimum in the no-budget case. Since $\kappa>0$, eventually $K_c>2$, $n_c\ge1$, and $n_c/(c^{1/3}G_c)\to1$. Use $n_c$ equal-$g$-mass core cells and the two tail cells, giving $n_c+2\le K_c$. Finitely many smaller $c$ can use a one-cell channel.

Write $a_c=G_c/n_c$, so $c^{1/3}a_c\to1$. The function $g$ is even and decreasing on the positive half-line, and

$$
g(T_c)\asymp c^{-5/18}(\log c)^{-1/3},\qquad
\Delta_{\max}\le\frac{a_c}{g(T_c)}
=O\!\left(c^{-1/18}(\log c)^{1/3}\right).
\tag{34}
$$

Consequently $T_c\Delta_{\max}\to0$. The logarithmic derivatives of $\phi$, $g$, and $w=1+x^2$ are bounded by a constant times $T_c+1$ on the core. Their within-cell ratios tend uniformly to one. The arguments for (31) and (32) now give

$$
D_{\rm int}=(1+o(1))\frac{a_c^2}{12}
\int_{-T_c}^{T_c}\frac{\phi(x)}{g(x)^2}\,dx,
\tag{35}
$$

$$
\frac1c\sum_{j\ {\rm interior}}(1+\mu_j^2)
=(1+o(1))\frac1{ca_c}
\int_{-T_c}^{T_c}(1+x^2)g(x)\,dx.
\tag{36}
$$

Both full-line integrands are $e^{-x^2/6}$ times functions of at most polynomial growth. It remains to control the two tails without assuming $cp_j$ large.

With $\overline\Phi(T)=\int_T^\infty\phi$, integration by parts gives

$$
\int_{|x|>T}x^2\phi(x)\,dx
=2\{T\phi(T)+\overline\Phi(T)\}.
\tag{37}
$$

Using zero instead of the optimal tail centroid bounds tail distortion above, so

$$
D_{\rm tail}\le2\{T_c\phi(T_c)+\overline\Phi(T_c)\}
=O\!\left(c^{-5/6}\sqrt{\log c}\right)=o(c^{-2/3}).
\tag{38}
$$

The tail centroids are $\pm\phi(T_c)/\overline\Phi(T_c)$. For $T>0$,

$$
\overline\Phi(T)=\frac{\phi(T)}T-\int_T^\infty\frac{\phi(x)}{x^2}dx
\ge\frac{\phi(T)}T-\frac{\overline\Phi(T)}{T^2}.
$$

Hence $|\mu_{\rm tail}|\le T_c+1/T_c$, and their contribution to the upper bound (21) is $O(\log c/c)=o(c^{-2/3})$. Combining (35), (36), (38), and (21),

$$
\limsup_{c\to\infty}c^{2/3}\delta_c
\le\int_\mathbb R\left\{\frac{\phi}{12g^2}+(1+x^2)g\right\}
=\mathcal C_\phi(\kappa).
\tag{39}
$$

No approximation of the small-probability denominators was used. $\square$

**Completion of Theorem 1.** Lemmas 10–11 give matching upper bounds and bounded scaled optimal loss. Lemmas 4–5 and 8 give the lower bounds for every admissible channel. Lemma 9 identifies the common value, unique density, and plateau. For $\kappa=\infty$, use the $\lambda=0$ converse and the $g_0$ construction; its alphabet is asymptotic to $\kappa_*c^{1/3}$ and eventually lies below $K_c$. This also proves the unrestricted statement. $\square$

## 8. Shape, endpoints, and scale of the frontier

**Proposition 12 (budget geometry).** The frontier is strictly decreasing and strictly convex on $(0,\kappa_*)$, with $\mathcal C_f'(\kappa)=-\lambda(\kappa)$. It meets the constant plateau continuously with derivative zero. Moreover,

$$
G'(\lambda)=-\frac13\int_S\frac{g_\lambda(x)}{w(x)+\lambda}\,dx<0,
\tag{40}
$$

and

$$
\mathcal C_f(\kappa)-\mathcal C_f(\kappa_*)
\sim\frac{(\kappa_*-\kappa)^2}{2[-G'(0)]}
\qquad(\kappa\uparrow\kappa_*).
\tag{41}
$$

**Proof.** Differentiation under the integral follows from $w\ge v>0$ and the same integrable envelopes as above. For $A(\lambda)=A_0\int f^{1/3}(w+\lambda)^{2/3}$, one has $A'(\lambda)=G(\lambda)$. Differentiate (8) with $G(\lambda)=\kappa$ to obtain $\mathcal C_f'=-\lambda$ and $\mathcal C_f''=-1/G'(\lambda)>0$. As $\kappa\uparrow\kappa_*$, $\lambda\downarrow0$. Taylor expansion gives $\lambda=(\kappa_*-\kappa)/[-G'(0)]+o(\kappa_*-\kappa)$. Integrating the derivative from $\kappa$ to $\kappa_*$ proves (41). $\square$

**Proposition 13 (communication-poor endpoint).** Let $S_f=\int_S f(x)^{1/3}\,dx$. Then

$$
\mathcal C_f(\kappa)\sim\frac{S_f^3}{12\kappa^2}
\qquad(\kappa\downarrow0).
\tag{42}
$$

For the standard Gaussian, $S_\phi^3/12=\sqrt3\,\pi/2$. If $K_c/c^{1/3}\to0$, then $c^{2/3}\delta_f^*(c,K_c)\to\infty$.

**Proof.** Dominated convergence as $\lambda\to\infty$ gives $G(\lambda)\sim S_f/(6\lambda)^{1/3}$ and $A(\lambda)\sim A_0S_f\lambda^{2/3}$. Therefore $\lambda\sim S_f^3/(6\kappa^3)$ under $G(\lambda)=\kappa$. Substitute into $A(\lambda)-\lambda\kappa$ to obtain (42). The envelopes are $f^{1/3}$ and $f^{1/3}(1+w)^{2/3}$, integrable in both cases. Gaussian integration gives $S_\phi=(2\pi)^{-1/6}\sqrt{6\pi}$ and the stated coefficient. For the last assertion fix $\tau>0$. Eventually $K_c\le\lceil\tau c^{1/3}\rceil$. Monotonicity in the cap and Theorem 1 bound the scaled liminf below by $\mathcal C_f(\tau)$. Let $\tau\downarrow0$. $\square$

This endpoint statement does not assert a uniform equivalence $\delta_f^*(c,K_c)\sim S_f^3/(12K_c^2)$ for every sequence with vanishing normalized budget; fixed small alphabets are not high resolution.

**Proposition 14 (change of scale).** If $Y=tX$ with $t>0$, input relabeling gives a bijection of private channel classes and

$$
I_Y^*(c,K)=t^2I_X^*(c,K),\qquad
\delta_Y^*(c,K)=t^2\delta_X^*(c,K).
\tag{43}
$$

For $f_t(y)=f(y/t)/t$, the frontier satisfies $\mathcal C_{f_t}(\kappa)=t^2\mathcal C_f(\kappa)$ and $\kappa_{f_t,*}=\kappa_{f,*}$.

**Proof.** The privacy ratios are unchanged by an invertible input relabeling, and $\mathbb E[Y\mid Z]=t\mathbb E[X\mid Z]$. Equivalently substitute $y=tx$, $\lambda_t=t^2\lambda$, and $g_{t,\lambda_t}(y)=t^{-1}g_\lambda(y/t)$ in (4) and (5). $\square$

For the Gaussian, $\kappa_*c^{1/3}$ symbols suffice asymptotically to retain the unrestricted leading constant. A fixed-length representation needs $\log_2(c)/3+O(1)$ bits in this sense. The exact parameter is the integer alphabet cap; no finite-privacy bit threshold or suppressed rounding effect is claimed.

## 9. Numerical evidence and reproducibility boundaries

Exact constants are defined by the integrals and multiplier equations, not by decimals. Floating-point quadrature during this research gave:

| Gaussian quantity | Approximate value |
|:--|--:|
| $\kappa_*$ | 1.3024810109644 |
| $\mathcal C_\phi(\infty)$ | 6.0867735501202 |
| $\lambda$ for $\kappa=0.5$ | 39.762850068903 |
| $\mathcal C_\phi(0.5)$ | 12.851741615151 |
| $\lambda$ for $\kappa=1$ | 2.4759413172612 |
| $\mathcal C_\phi(1)$ | 6.3843816666422 |

The delivered self-contained ECMAScript program was executed in a V8 runtime on 24 explicit mechanisms: Gaussian and variance-one uniform laws, four budgets, and $c=10^3,10^6,10^9$. All respected integer output caps. Maximum probability-mass error was $9.99\times10^{-16}$, the largest discrepancy between the exact loss identities and direct information was $2.30\times10^{-15}$, and the largest primal–dual numerical discrepancy was $7.82\times10^{-13}$. At $c=10^9$ the largest relative difference between constructed scaled loss and its limiting constant was about $0.467\%$. The source and all 24 rows are archived with this manuscript. Quadrature tolerances are computational settings, not rigorous error enclosures.

The analytical proof in Sections 3–8 is independent of the numerical reproduction. The decimal values do not have rigorous interval certificates.

## 10. Scope

The completed analytical target is the all-channel scalar-score joint limit in Theorem 1, its optimizer, and the stated frontier geometry. The compact extension assumes continuity and strict positivity on a nondegenerate interval. No generalization to densities with zeros or arbitrary heavy tails is asserted; Gaussian tails have a separate explicit proof.

The work does not solve exact finite-$\varepsilon$ optimization, the sign-to-multisymbol transition, multivariate scores, approximate privacy, interactive finite-sample estimation, or a joint limit with changing sample size. Uniqueness concerns the variational density, not a finite-$c$ optimal channel or all of its output representations.

## References

[R1] L. Steinberger. *Efficiency in local differential privacy*. Annals of Statistics 52(5), 2139–2166, 2024. DOI: [10.1214/24-AOS2425](https://doi.org/10.1214/24-AOS2425). [Author version, arXiv:2301.10600v3](https://arxiv.org/html/2301.10600v3).

[R2] N. Kalinin and L. Steinberger. *Efficient Estimation of a Gaussian Mean with Local Differential Privacy*. AISTATS 2025, PMLR 258, 118–126. [Proceedings](https://proceedings.mlr.press/v258/nikita25a.html); [arXiv:2402.04840v3](https://arxiv.org/abs/2402.04840v3).

[R3] P. Kairouz, S. Oh, and P. Viswanath. *Extremal Mechanisms for Local Differential Privacy*. Journal of Machine Learning Research 17(17), 1–51, 2016. [Original article](https://www.jmlr.org/papers/v17/15-135.html).

[R4] E. Ghazi, J. Nasser, F. Calmon, and I. Issa. *Sort, Partition, Randomize: Optimal Binary Hypothesis Testing under Local Differential Privacy*. [arXiv:2606.07443v1](https://arxiv.org/html/2606.07443v1), 2026. Theorem 3.1, Corollary 3.2, Section 4.2, Appendix B.

[R5] C. Amorino and A. Gloter. *Factorization by extremal privacy mechanisms: new insights into efficiency*. [arXiv:2507.21769v2](https://arxiv.org/html/2507.21769v2), 2 October 2026. Section 4.4, Proposition 3. The version matters for the strong-duality comparison.

[R6] C. Amorino and A. Gloter. *On the role of symmetry for staircase mechanisms in local differential privacy efficiency across different privacy regimes*. [arXiv:2603.27572v1](https://arxiv.org/html/2603.27572v1), 2026. Proposition 3.

[R7] V. Misra, V. K. Goyal, and L. R. Varshney. *Distributed scalar quantization for computing: High-resolution analysis and extensions*. IEEE Transactions on Information Theory 57(8), 5298–5325, 2011. DOI: [10.1109/TIT.2011.2158882](https://doi.org/10.1109/TIT.2011.2158882).

[R8] Q. Geng and P. Viswanath. *The Optimal Noise-Adding Mechanism in Differential Privacy*. IEEE Transactions on Information Theory 62(2), 925–951, 2016. DOI: [10.1109/TIT.2015.2504967](https://doi.org/10.1109/TIT.2015.2504967).

[R9] Y. Zhao et al. *Local Differential Privacy based Federated Learning for the Internet of Things*. [arXiv:2004.08856v2](https://arxiv.org/pdf/2004.08856v2), 2020. Section V.C, PM-SUB, Eq. (33).

[R10] A. Javanmard et al. *SSTQ: Privacy-Preserving Vector Quantization via Subsampled Stochastic TurboQuant*. [arXiv:2608.05127v3](https://arxiv.org/html/2608.05127v3), 28 September 2026. Section 4, Eqs. (3)–(6), Theorem 4.3, Appendix C.3.

[R11] A. Pensia, A. Asadi, V. Jog, and P.-L. Loh. *Simple Binary Hypothesis Testing Under Local Differential Privacy and Communication Constraints*. IEEE Transactions on Information Theory, 2025. DOI: [10.1109/TIT.2024.3461361](https://doi.org/10.1109/TIT.2024.3461361). [arXiv:2301.03566v2](https://arxiv.org/abs/2301.03566v2).

[R12] A. D. Sarwate and L. Sankar. *A Rate-Distortion Perspective on Local Differential Privacy*. Allerton, 2014. [Author manuscript](https://adsarwate.github.io/assets/pdf/papers/SarwateS14allerton.pdf). Eq. (4), Theorem 1, conclusion.

[R13] R. Zhang and P. Venkitasubramaniam. *Optimal Local Differentially Private Quantization*. IEEE Transactions on Signal Processing 68, 6509–6520, 2020. DOI: [10.1109/TSP.2020.3033483](https://doi.org/10.1109/TSP.2020.3033483). Bibliographic record and abstract checked; full journal text unavailable during this study.

[R14] R. Zhang and P. Venkitasubramaniam. *Optimal Distribution Mapping for Inference Privacy*. APSIPA ASC, 2018. [Official proceedings](https://www.apsipa.org/proceedings/2018/pdfs/0001179.pdf). Sections II–IV; a precursor, not a substitute for the journal version [R13].
