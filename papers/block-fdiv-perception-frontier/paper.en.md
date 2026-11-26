# Fixed Block Perception Budgets

Exact rate-distortion laws and the cost of iid reconstruction

## Abstract

Perception constraints in lossy compression compare the law of a reconstruction with the source law. A constraint on an entire block has a different asymptotic meaning from a constraint on its one-letter marginal. We determine the exact first-order optimum for every finite-alphabet iid source, bounded distortion, fixed-length communication rate, and fixed, unnormalized block f-divergence budget, when independent common and private randomness are unrestricted. The optimum is an explicit interpolation between the ordinary distortion-rate function and the distortion-rate function with an exactly preserved output distribution. Its mixing weight is the inverse of a scalar binary f-divergence. A finite-block postselection information inequality supplies the converse for arbitrary dependent reconstructions; a block mixture of two same-rate codes attains it. We give a self-contained finite-alphabet construction with an exact output law, including the correction needed when f-divergence is not continuous under total variation. We also determine the optimum under an iid-output restriction, prove strict gaps at every nontrivial rate for biased Bernoulli sources, and give a finite-randomness zero-rate counterexample to the iid-optimality conjecture in Niu et al. (2025). Fixed source-to-output KL budgets permit an exponential interpolation weight, whereas every finite reverse-KL budget has the perfect-realism first-order limit. Simultaneous divergence budgets and a finite-block converse follow from the same argument. These are mathematical results within the stated model, not claims about practical compression efficiency or rate-limited randomness.

**Keywords:** source coding; perception; f-divergence; output constraints; postselection; common randomness.

## 1. Problem and contribution boundary

An iid source need not have an iid optimal reconstruction when a nonzero perception budget is imposed on the **whole reconstruction block**. This distinction matters because block laws can retain an entire source-like component while placing the remaining mass on a different coding mode. Independent randomization across individual coordinates does not have the same effect.

Niu et al. [1, Section 6.2.1, Conjecture 1] propose iid optimality for f-divergence constraints on entire block laws. We study that precise normalization in a finite-alphabet model. The main theorem characterizes all reconstruction laws, rather than only exhibiting a competing code. Section 8 also gives a counterexample with no communication, no common randomness, and a finite number of decoder random bits, so the failure of the unrestricted iid claim is not an artifact of unbounded common randomness.

The ordinary and fixed-output distortion-rate functions, randomized coding, soft covering, and exact output correction are established tools. In particular, Saldi, Linder and Yüksel [2, 3] characterize fixed-output coding, and Wagner [4] and Hamdi, Wagner and Gündüz [5] study perfect or near-perfect realism. We credit those endpoint theorems. Our contribution is the matching operational law for a fixed nonzero **unnormalized block budget**, together with its dependence on the divergence direction, the exact iid restriction penalty, and a finite-block conditional converse. The derivation of the coding lemma below is included for completeness, not as a claim to a new endpoint coding theorem.

This paper does not characterize prescribed finite common-randomness rates, side information, continuous alphabets, unbounded distortions, stationary sources with memory, or a budget on $n^{-1}D_f$. It also does not identify perception with human judgments of image quality. Expected-length communication requires a different formula: Appendix A derives it under an explicit seed-conditioned prefix condition and proves a strict low-rate separation from fixed length.

## 2. Model and notation

Let $\mathcal A$ be a nonempty finite alphabet, let $p$ be a probability mass function on it, and let

$$0\le d(x,y)\le d_{\max}<\infty,\qquad x,y\in\mathcal A.$$

Zero-probability source symbols are permitted. Every source-relative logarithm is evaluated on $\operatorname{supp}p$; source strings outside that support have probability zero. Reconstruction symbols remain in $\mathcal A$.

The source is $X^n\sim p^{\otimes n}$. A randomized length-$n$ code sends a message $M$ in a set of cardinality at most $m_n$. Its common and private random seeds are independent of the source and unrestricted in amount. Its output is $Y^n$, with law $Q_n$. Put

$$d_n(x^n,y^n)=\frac1n\sum_{i=1}^n d(x_i,y_i),\qquad r_n=\frac{\log m_n}{n}. \tag{1}$$

Logarithms are natural unless bits are explicitly specified. The amount of randomness is not included in $r_n$. For converse arguments, pool all independent seeds into $K$: then $K\perp X^n$, $M=e(X^n,K)$ and $Y^n=h(M,K)$. Revealing a private seed for analysis does not increase the message alphabet. Equivalently, for a fixed finite block one can group seed outcomes according to the deterministic encoder and decoder tables they select; there are finitely many such table pairs. Thus the proof may use a finite $K$ without restricting the observable joint law.

Let $f$ be convex and finite on $(0,\infty)$, with $f(1)=0$, and extended lower-semicontinuously at zero. Write

$$f_0=\lim_{t\downarrow0}f(t),\qquad f_\infty=\lim_{t\to\infty}\frac{f(t)}t.$$

Subtracting a supporting affine function $a(t-1)$ changes no divergence. We may therefore, and do in endpoint arguments, normalize $f\ge0$. Both endpoints are then in $[0,\infty]$. On finite spaces define

$$D_f(P\Vert Q)=\sum_{z:Q(z)>0}Q(z)f\!\left(\frac{P(z)}{Q(z)}\right)
+f_\infty\sum_{z:Q(z)=0}P(z). \tag{2}$$

Terms with $P(z)=Q(z)=0$ contribute zero. An infinite endpoint times a zero mass contributes zero in this closed-perspective convention. The divergence direction in (2) is fixed throughout.

For finite $R,\delta\ge0$, define

$$\mathsf D_f(R,\delta)=\inf\limsup_{n\to\infty}\mathbb E d_n(X^n,Y^n), \tag{3}$$

where the infimum is over code sequences satisfying

$$\limsup_n r_n\le R,\qquad
\limsup_n D_f(p^{\otimes n}\Vert Q_n)\le\delta. \tag{4}$$

There is **no division by $n$ in the second constraint**. We also consider the stricter convention requiring that divergence to be at most $\delta$ for every block; the theorem gives the same answer.

For a coupling $\pi$ on $\mathcal A^2$, write $I(\pi)=I_\pi(X;Y)$. The two endpoint functions are

$$D_0(R)=\min_{\pi_X=p,\ I(\pi)\le R}\mathbb E_\pi d(X,Y),\qquad
D_p(R)=\min_{\pi_X=\pi_Y=p,\ I(\pi)\le R}\mathbb E_\pi d(X,Y). \tag{5}$$

The constraint sets are nonempty compact sets and the objective and mutual information are continuous, so both minima exist, including at $R=0$. Always $D_p(R)\ge D_0(R)$. These functions are nonincreasing and convex: mix the channels of two feasible couplings with the same input marginal, use convexity of mutual information in the channel, and preserve the output marginal when required. Right continuity at zero also follows directly by compactness. The proofs below do not presume left continuity at a boundary rate.

Define the scalar retention cost by an actual binary divergence:

$$G_f(q)=D_f\bigl((1,0)\Vert(q,1-q)\bigr). \tag{6}$$

In particular,

$$G_f(q)=q f(1/q)+(1-q)f_0\quad(0 \lt q<1),\qquad
G_f(1)=0,\qquad G_f(0)=f_\infty+f_0. \tag{7}$$

Definition (6) determines the endpoints even when an informal expression in (7) would contain $0\cdot\infty$. Finally put

$$q_f(\delta)=\min\{q\in[0,1]:G_f(q)\le\delta\}. \tag{8}$$

## 3. Scalar geometry and the main theorem

### Proposition 1. Scalar budget geometry

The function $G_f$ is convex, lower-semicontinuous and nonincreasing on $[0,1]$. Its sublevel in (8) is the nonempty closed interval $[q_f(\delta),1]$. For arbitrary finite distributions $P,Q$ and $q\in[0,1]$,

$$D_f\bigl(P\Vert qP+(1-q)Q\bigr)\le G_f(q). \tag{9}$$

If $G_f(0)<\infty$, every pair of distributions on the same finite alphabet satisfies $D_f(P\Vert Q)\le G_f(0)$.

**Proof.** The closed perspective of a convex function is jointly convex and lower-semicontinuous; summing its two terms proves the first two properties. To prove monotonicity, take $q_1\le q_2<1$ and apply a binary channel that keeps symbol 1 and changes symbol 0 to symbol 1 with probability $(q_2-q_1)/(1-q_1)$. It fixes $(1,0)$ and sends $(q_1,1-q_1)$ to $(q_2,1-q_2)$. Data processing proves the claim. The remaining endpoint is immediate from $G_f(1)=0$. Data processing itself follows from Jensen's inequality for each output fiber, with the perspective convention treating zero masses.

For (9), introduce a label $B$. Under a first joint law let $B=1$ and $Z\sim P$. Under a second law let $(B,Z)$ have masses $qP$ on $B=1$ and $(1-q)Q$ on $B=0$. The divergence of these labeled laws is exactly (6). Forgetting $B$ proves (9), including both endpoints. Taking $q=0$ proves the last assertion. No continuity of divergence under total variation is assumed. $\square$

### Theorem 2. Exact fixed-length block-budget law

For every model specified in Section 2,

$$\boxed{\mathsf D_f(R,\delta)
=q_f(\delta)D_p(R)+\bigl(1-q_f(\delta)\bigr)D_0(R).} \tag{10}$$

Every admissible code sequence satisfies the corresponding lower bound on its **liminf** expected distortion. There is a sequence attaining (10), with rate at most $R$ in the sense of (4), whose block divergence is at most $\delta$ for every $n$.

The mixture in (10) uses two codes of the **same allowed asymptotic rate**, selected once per block by independent shared randomness. This is why the two functions are evaluated at $R$ rather than at separately optimized conditional rates. Sections 4--6 prove the theorem.

### Theorem 3. Exact iid-output restriction

Restrict the reconstruction law to $Q_n=s_n^{\otimes n}$, allowing $s_n$ to depend on $n$. If $0\le\delta \lt G_f(0)$, the optimal distortion in this restricted class is

$$\mathsf D_f^{\mathrm{iid}}(R,\delta)=D_p(R). \tag{11}$$

If $G_f(0)<\infty$ and $\delta\ge G_f(0)$, it is $D_0(R)$. Consequently, whenever $\delta \lt G_f(0)$, the exact restriction penalty is

$$\mathsf D_f^{\mathrm{iid}}(R,\delta)-\mathsf D_f(R,\delta)
=\bigl(1-q_f(\delta)\bigr)\bigl(D_p(R)-D_0(R)\bigr). \tag{12}$$

Thus iid optimality fails strictly whenever both factors in (12) are positive. Section 7 proves the classification, including sources with zero-probability symbols.

## 4. A finite-block postselection converse

Conditioning on an output event generally destroys independence between the source and the random seed. Ignoring this effect would make the converse invalid. The following lemma charges the induced dependence and all source-coordinate dependence to one relative-entropy budget.

### Lemma 4. Conditional information bound

For a randomized code with message cardinality at most $m$, let $E$ be **any** event with $a=\Pr(E)>0$, and define the average conditional coordinate coupling

$$\bar\pi_E=\frac1n\sum_{i=1}^n\mathcal L(X_i,Y_i\mid E).$$

Then

$$D((\bar\pi_E)_X\Vert p)\le\frac{\log(1/a)}n, \tag{13}$$

$$I(\bar\pi_E)+D((\bar\pi_E)_X\Vert p)
\le\frac{\log m+\log(1/a)}n. \tag{14}$$

**Proof.** Denote conditioning on $E$ by $Q$. The density of $Q_{X^n,K}$ relative to $p^{\otimes n}P_K$ is at most $1/a$, because it equals $\Pr(E\mid X^n,K)/a$. Therefore

$$D(Q_{X^n}\Vert p^{\otimes n})+I_Q(X^n;K)+D(Q_K\Vert P_K)
\le\log(1/a). \tag{15}$$

Product-reference tensorization and convexity give

$$nD((\bar\pi_E)_X\Vert p)
\le\sum_iD(Q_{X_i}\Vert p)
\le D(Q_{X^n}\Vert p^{\otimes n}),$$

which proves (13). The deterministic identity $Y^n=h(M,K)$ remains true after conditioning, even for an event depending on all variables. Hence

$$I_Q(X^n;Y^n)\le I_Q(X^n;K)+H_Q(M\mid K)
\le I_Q(X^n;K)+\log m. \tag{16}$$

Subadditivity and concavity of conditional entropy imply

$$H_Q(X^n\mid Y^n)\le\sum_i H_Q(X_i\mid Y_i)
\le nH_{\bar\pi_E}(X\mid Y).$$

Since cross entropy against $p$ is linear in the coordinate marginal,

$$\begin{aligned}
n\{I(\bar\pi_E)+D((\bar\pi_E)_X\Vert p)\}
&=\mathbb E_Q[-\log p^{\otimes n}(X^n)]-nH_{\bar\pi_E}(X\mid Y)\\
&\le D(Q_{X^n}\Vert p^{\otimes n})+I_Q(X^n;Y^n)\\
&\le\log m+\log(1/a),
\end{aligned} \tag{17}$$

by (15)--(16). Zero-probability source symbols never occur under $Q$, so the same calculation applies after restriction to $\operatorname{supp}p$. $\square$

This proof does not put the random coordinate index into the decoder's observation or assume that coordinate marginals agree after selection. Concavity in (17) handles their average explicitly.

### Proof of the converse in Theorem 2

Let $\epsilon_n=n^{-1/4}$ and let

$$T_n=\{y^n:\|\widehat p_{y^n}-p\|_1\le\epsilon_n\},\qquad
b_n=p^{\otimes n}(T_n),\quad a_n=Q_n(T_n). \tag{18}$$

The weak law gives $b_n\to1$. For example, the expectation of each absolute empirical-frequency error is at most $1/(2\sqrt n)$, so Markov's inequality suffices for this choice of $\epsilon_n$. Binary data processing gives

$$D_f\bigl((b_n,1-b_n)\Vert(a_n,1-a_n)\bigr)
\le D_f(p^{\otimes n}\Vert Q_n). \tag{19}$$

Take a subsequence realizing the liminf of distortion, and then a further subsequence on which $a_n\to a$. Joint lower semicontinuity of the binary divergence and (4) imply

$$G_f(a)\le\delta,\qquad a\ge q_f(\delta). \tag{20}$$

If $a>0$, apply Lemma 4 to $E_n=\{Y^n\in T_n\}$. Equation (13) makes the source marginal of $\bar\pi_{E_n}$ tend to $p$. Each output in $E_n$ is typical, so its average output marginal also tends to $p$. Equation (14) and the rate constraint give mutual information at most $R+o(1)$. Compactness of the finite coupling simplex shows that every limit of these couplings is feasible for $D_p(R)$. Thus

$$\liminf_n\mathbb E[d_n\mid E_n]\ge D_p(R). \tag{21}$$

If $a<1$, the same argument on $E_n^c$ gives

$$\liminf_n\mathbb E[d_n\mid E_n^c]\ge D_0(R), \tag{22}$$

without imposing an output marginal. A branch whose probability tends to zero has distortion contribution between zero and its probability times $d_{\max}$, and hence vanishes. Decomposing total expected distortion gives

$$\liminf_n\mathbb E d_n\ge aD_p(R)+(1-a)D_0(R)
\ge q_f(\delta)D_p(R)+(1-q_f(\delta))D_0(R). \tag{23}$$

For completeness, the implication from (13) to marginal convergence does not require a separate inequality: on the compact source-support simplex, relative entropy is continuous, nonnegative, and zero only at $p$; any nonconvergent subsequence would have a different zero-divergence limit. This also explains why no source full-support assumption is hidden. $\square$

## 5. Exact-output achievability, with a quantitative construction

### Lemma 5. An established coding endpoint, proved here for finite alphabets

Let $\pi$ be any coupling with $\pi_X=p$, let $s=\pi_Y$, and put $I=I(\pi)$. There are randomized fixed-length codes with

$$\limsup_n\frac{\log m_n}{n}\le I,\qquad
\mathcal L(Y^n)=s^{\otimes n}\ \text{exactly},\qquad
\mathbb E d_n\longrightarrow\mathbb E_\pi d. \tag{24}$$

The output-constrained coding theorem is due to prior work [2, 3]. We give a finite-alphabet proof to expose both the approximation and the exact marginal correction used in Theorem 2.

**Proof.** Choose $\eta>0$ and $m=\lceil e^{n(I+2\eta)}\rceil$. Shared randomness generates a codebook $C=(Y^n(1),\ldots,Y^n(m))$ of independent words from $s^{\otimes n}$. For fixed $C$, define an ideal joint law by choosing $J$ uniformly in $[m]$, putting $Y^n=Y^n(J)$, and drawing $X^n$ from the reverse channel $\pi_{X|Y}^{\otimes n}(\cdot\mid Y^n(J))$. Write $Q_C^X$ for its source marginal.

For $x$ in the source support set

$$L_y(x)=\frac{\pi_{X|Y}^{\otimes n}(x\mid y)}{p^{\otimes n}(x)},\qquad
T=e^{n(I+\eta)}.$$

For a random codeword, $\mathbb E_Y L_Y(x)=1$. Split $L=L\mathbf1_{\{L\le T\}}+L\mathbf1_{\{L>T\}}$. The second moment of the first term is at most $T$ times its mean, hence at most $T$. Cauchy--Schwarz bounds the expected absolute deviation of its average from its mean by $\sqrt{T/m}$. The difference of that mean from 1, together with the expected bad part, contributes twice the bad mass. Summing with weights $p^{\otimes n}(x)$ proves

$$\mathbb E_C\|Q_C^X-p^{\otimes n}\|_{\mathrm{TV}}
\le\frac12\sqrt{\frac{e^{n(I+\eta)}}m}
+\Pr_{\pi^{\otimes n}}\{\imath(X^n;Y^n)>n(I+\eta)\}
=:\tau_n. \tag{25}$$

Here $\imath(x^n;y^n)=\log[\pi^{\otimes n}(x^n,y^n)/(p^{\otimes n}(x^n)s^{\otimes n}(y^n))]$ on the joint support.

In the actual code, $X^n\sim p^{\otimes n}$ is independent of $C$. The encoder samples $J$ from the ideal posterior $Q_C(J\mid X^n)$. Where $Q_C^X$ is zero, assign any posterior. Extending the same posterior on those null inputs, actual and ideal laws of $(X^n,J)$ at fixed $C$ differ in total variation exactly by $\|p^{\otimes n}-Q_C^X\|_{\mathrm{TV}}$. Decoding $Y^n(J)$ cannot increase it. Averaging over codebooks, the ideal pair law is exactly $\pi^{\otimes n}$, so the actual pair law is within $\tau_n$ of this target.

Let $s_n$ be the actual output marginal before correction. A finite maximal coupling of $s_n$ and $s^{\otimes n}$ has disagreement probability $\|s_n-s^{\otimes n}\|_{\mathrm{TV}}\le\tau_n$: put mass $\min\{s_n(y),s^{\otimes n}(y)\}$ on each diagonal pair and couple the remaining disjoint residual masses. Its conditional kernel is a decoder postprocessing operation. Applying it yields output marginal exactly $s^{\otimes n}$, changes no transmitted message, and changes average distortion by at most $d_{\max}\tau_n$. Before correction, boundedness already bounds the difference from $\mathbb E_\pi d$ by $d_{\max}\tau_n$. Thus the final distortion differs by at most $2d_{\max}\tau_n$.

On the finite positive joint support, the one-letter information density has finite variance $V$. Take $\eta_n=n^{-1/4}$. Chebyshev's inequality and (25) give the explicit estimate

$$\tau_n\le\tfrac12 e^{-n^{3/4}/2}+\frac{V}{\sqrt n},\qquad
\frac{\log m_n}{n}\le I+2n^{-1/4}+\frac{\log2}{n}. \tag{26}$$

This proves (24). If $I=0$, $\pi=p\otimes s$ and the decoder can instead generate $s^{\otimes n}$ independently with one possible message. The construction is existential and may use enormous shared randomness; no computational efficiency or optimal seed rate is asserted. $\square$

**Why exact correction is necessary.** Small total variation alone does not imply small KL or general f-divergence. In our use of Lemma 5, exact output repair is performed **before** the block mixture. The perception guarantee then follows from (9), not from any unproved divergence continuity claim.

## 6. Completing the main theorem

Choose minimizers in (5). Lemma 5 gives one code sequence with exact output $p^{\otimes n}$ and distortion tending to $D_p(R)$, and another with distortion tending to $D_0(R)$; its output can also be taken exactly iid with the marginal of its optimizing coupling. Both have rate at most $R+o(1)$.

An independent common selector chooses the first code with probability $q$. Pad the smaller message alphabet into the larger. The message alphabet of the selected code has size the maximum of the two sizes, because the selector is already known to the decoder. The output law and distortion are

$$q p^{\otimes n}+(1-q)Q_n^0,\qquad
q d_{p,n}+(1-q)d_{0,n}. \tag{27}$$

Set $q=q_f(\delta)$. Proposition 1 gives the exact finite-block perception bound. If $q=1$, use only the first sequence; if $q=0$, use only the second, since $G_f(0)\le\delta$ and the last assertion of Proposition 1 applies. Thus (27) attains (10) with no asymptotic overshoot of the perception budget. The rate overhead in (26) is allowed by (4); it is not a claim of a uniform finite-$n$ optimum. Together with Section 4 this proves Theorem 2. $\square$

Affine or non-strictly convex generators cause no gap in the proof. The sublevel in (8) can have flat parts; neither uniqueness of the mixing weight among all optimal codes nor uniqueness of a code is claimed. A divergence that does not distinguish some different distributions can even have $q_f(0)<1$. Accordingly, zero budget is called perfect realism only when the generator identifies equality of distributions.

## 7. Iid restriction and divergence direction

### Proof of Theorem 3

Suppose $\delta \lt G_f(0)$ and a feasible iid-output sequence has marginal $s_n$. If $s_n$ does not tend to $p$, a subsequence satisfies $\|s_n-p\|_1\ge\gamma>0$. The empirical distribution of iid draws from $s_n$ differs from $s_n$ in expected $\ell_1$ distance at most $|\mathcal A|/(2\sqrt n)$, uniformly over $s_n$. Therefore $s_n^{\otimes n}(T_n)\to0$ on this subsequence, while $p^{\otimes n}(T_n)\to1$. Equations (19) and lower semicontinuity imply a liminf divergence at least $G_f(0)>\delta$, a contradiction.

Hence $s_n\to p$. Apply Lemma 4 to the full event, of probability one. The average pair coupling has source marginal exactly $p$, output marginal $s_n$, and mutual information at most $r_n$. Every limit is feasible for $D_p(R)$, which proves the lower bound in (11). Lemma 5 with output $p^{\otimes n}$ attains it.

If $G_f(0)<\infty$ and $\delta\ge G_f(0)$, all output laws obey the perception constraint. Apply Lemma 5 to an ordinary minimizing coupling in (5); its output is exactly iid and its distortion tends to $D_0(R)$. This proves the second case and (12). $\square$

### Corollary 6. Endpoint classification

If $f_0=\infty$, then $q_f(\delta)=1$ for every finite $\delta$, and (10) equals $D_p(R)$. If $f_0<\infty$, then $G_f(q)\to0$ as $q\uparrow1$, because $f$ is continuous at 1. Consequently $q_f(\delta)<1$ for every $\delta>0$. If also $D_p(R)>D_0(R)$, every such positive budget strictly improves on the perfect-realism first-order distortion.

The following formulas use the direction $D_f(p^{\otimes n}\Vert Q_n)$; changing the generator changes the divergence, not this convention.

| Divergence | $G_f(q)$ for $0 \lt q<1$ | $q_f(\delta)$ |
|:--|:--|:--|
| $D_{\rm KL}(p^{\otimes n}\Vert Q_n)$ | $-\log q$ | $e^{-\delta}$ |
| $D_{\rm KL}(Q_n\Vert p^{\otimes n})$ | $\infty$ | $1$ |
| Total variation | $1-q$ | $(1-\delta)_+$ |
| Squared Hellinger, no factor $1/2$ | $2(1-\sqrt q)$ | $(1-\delta/2)_+^2$ |
| Pearson $\chi^2(p^{\otimes n}\Vert Q_n)$ | $q^{-1}-1$ | $(1+\delta)^{-1}$ |
| Reverse Pearson $\chi^2$ | $\infty$ | $1$ |

Here $u_+=\max\{u,0\}$. These follow by substituting, respectively, $f(t)=t\log t$, $-\log t$, $|t-1|/2$, $(\sqrt t-1)^2$, $(t-1)^2$, and $(t-1)^2/t$ into (6). The harmless affine normalization in Section 2 may be applied before evaluating endpoint limits.

For Jensen--Shannon divergence with equal weights and natural logarithms,

$$G_{\rm JS}(q)=\log2+\tfrac12\{q\log q-(1+q)\log(1+q)\}. \tag{28}$$

It decreases from $\log2$ to zero; (8) gives its inverse weight, with zero retained mass for budgets at least $\log2$. Formula (28) follows by substituting $f(t)=\tfrac12[t\log(2t/(1+t))+\log(2/(1+t))]$ and collecting terms.

The contrast between the two KL directions is qualitative. A constant source-to-output KL budget allows a nonzero block mode that is asymptotically distinguishable from the source; its weight is exactly controlled by $e^{-\delta}$. A finite reverse-KL budget rules out any such nonvanishing mode in the first-order distortion optimum. Neither assertion applies unchanged to a KL budget that grows linearly with block length.

## 8. Strict gaps and an exact finite-randomness counterexample

### Proposition 7. Biased Bernoulli sources

Let $p=\Pr(X=1)\in(0,1/2)$ and let $d$ be Hamming distortion. Write $h(u)=-u\log u-(1-u)\log(1-u)$ and use the inverse of $h$ on $[0,1/2]$. For $0\le R\le h(p)$,

$$D_0(R)=h^{-1}(h(p)-R). \tag{29}$$

The value $D_p(R)=2a$ is the unique solution with $0\le a\le p(1-p)$ of

$$R=h(p)-(1-p)h\!\left(\frac a{1-p}\right)-p h\!\left(\frac a p\right). \tag{30}$$

For every $0\le R \lt h(p)$,

$$D_p(R)>D_0(R). \tag{31}$$

Both values are zero for $R\ge h(p)$.

**Proof.** For any binary coupling with error probability $D\le p$, $H(X\mid Y)\le h(D)$, because the error bit determines $X$ given $Y$. This gives the lower bound in (29). For $0\le D\le p$, choose $Y\sim\operatorname{Bern}((p-D)/(1-2D))$ and an independent error $Z\sim\operatorname{Bern}(D)$, and put $X=Y\oplus Z$. This has source marginal $p$, distortion $D$, and information $h(p)-h(D)$, proving (29).

A coupling with both marginals $p$ has table

$$\begin{pmatrix}1-p-a&a\\a&p-a\end{pmatrix}$$

and distortion $2a$. Its information is the right side of (30). It decreases continuously from $h(p)$ to zero as $a$ goes from 0 to $p(1-p)$: in the interior its derivative is $\log[a^2/((p-a)(1-p-a))]<0$. For minimizing distortion no $a>p(1-p)$ is needed, since the independent coupling already gives the smaller distortion $2p(1-p)$ at zero information. This proves (30).

If equality held in (31), put $D=D_0(R)>0$. The equal-marginal coupling would attain equality in $H(X\mid Y)\le h(D)$, so its error bit would be independent of $Y$. Then $X=Y\oplus Z$ with independent $Z\sim\operatorname{Bern}(D)$ and both $X,Y$ of mean $p$ forces $D(1-2p)=0$, impossible. At $R=0$ the same conclusion also follows directly from $D_p(0)=2p(1-p)>p=D_0(0)$. Lossless transmission handles $R\ge h(p)$. $\square$

Combining (12) and (31) gives a strictly positive iid penalty at **every** rate $R \lt h(p)$ whenever $q_f(\delta)<1$ and $\delta \lt G_f(0)$. This is a complete interval of nontrivial rates, not only a zero-rate anomaly.

### Proposition 8. An exact no-message certificate

Take $p=1/4$, use Hamming distortion, and send no message. Independently of the source, flip a fair selector coin. On one outcome generate an iid $\operatorname{Bern}(1/4)$ word, and on the other output $0^n$. Thus

$$Q_n=\tfrac12p^{\otimes n}+\tfrac12\delta_{0^n}. \tag{32}$$

The source is independent of the output, and the one-coordinate output mean is $1/8$. Therefore, for every $n$,

$$\mathbb E d_n=\tfrac14\cdot\tfrac78+\tfrac34\cdot\tfrac18=\tfrac5{16}. \tag{33}$$

Also, exactly,

$$\|p^{\otimes n}-Q_n\|_{\rm TV}=\tfrac12\bigl(1-(3/4)^n\bigr)\le\tfrac12,\qquad
D_{\rm KL}(p^{\otimes n}\Vert Q_n)\le\log2. \tag{34}$$

Any feasible iid-output sequence under either of these fixed budgets has marginal tending to $1/4$ by Theorem 3, and its zero-rate limiting distortion is at least $3/8$. The unrestricted optimum is $5/16$ by Theorem 2. The difference is $1/16$, or one sixth of the iid value.

Sampling a Bernoulli$(1/4)$ symbol as the AND of two independent fair bits uses $2n$ private decoder bits; the selector uses one more. Thus at most $2n+1$ fair private bits suffice, with zero common randomness and one possible transmitted message. A uniform budget of $3n$ private bits covers every positive $n$. This is a counterexample within a finite-randomness specialization of the conjectured model [1], not only within an ideal infinite-randomness limit.

It does not prove that all finite-randomness rate tradeoffs are given by (10). The exact general theorem retains the unlimited-randomness assumption.

## 9. Finite-block certificates and simultaneous constraints

### Proposition 9. A finite-block converse optimization

Fix any set $T\subseteq\mathcal A^n$ all of whose words have type within $\epsilon$ of $p$. Put $b=p^{\otimes n}(T)$, $a=Q_n(T)$, and $r=(\log m)/n$. For $a\in(0,1]$ define $L_p(r,a,\epsilon)$ as the minimum of $\mathbb E_\pi d$ over couplings satisfying

$$D(\pi_X\Vert p)\le\frac{\log(1/a)}n,\quad
I(\pi)+D(\pi_X\Vert p)\le r+\frac{\log(1/a)}n,\quad
\|\pi_Y-p\|_1\le\epsilon. \tag{35}$$

Define $L_0(r,a)$ by omitting the last constraint. Set the weighted expression $aL_p$ or $aL_0$ to zero at $a=0$. If the block divergence is at most $\delta$, then

$$\mathbb E d_n\ge\inf_{\substack{a\in[0,1]\\
D_f((b,1-b)\Vert(a,1-a))\le\delta}}
\bigl[aL_p(r,a,\epsilon)+(1-a)L_0(r,1-a)\bigr]. \tag{36}$$

**Proof.** Use Lemma 4 on $\{Y^n\in T\}$ and its complement; the conditional average output type in the first event obeys the last constraint in (35). Equation (19) gives the restriction on $a$. Omit a null branch. Minimizing over allowed $a$ proves (36). The inner problems are convex: $I(\pi)+D(\pi_X\Vert p)=D(\pi\Vert p\otimes\pi_Y)$ is jointly convex in $\pi$ by the log-sum inequality, and the other constraints are convex. The outer one-dimensional optimization need not be called convex. Infeasible inner problems are assigned value $+\infty$. This is a rigorous relaxation for each block, not an assertion that the finite-block operational optimum is attained by the relaxation. $\square$

### Corollary 10. Simultaneous f-divergence budgets

Let a finite nonempty family of generators $f_j$ have finite budgets $\delta_j$, all in the orientation $D_{f_j}(p^{\otimes n}\Vert Q_n)$. Put

$$q_* =\max_j q_{f_j}(\delta_j). \tag{37}$$

Under all the constraints simultaneously, the optimum is exactly

$$q_*D_p(R)+(1-q_*)D_0(R). \tag{38}$$

**Proof.** Every subsequential limit $a$ in the converse must lie in every sublevel $[q_{f_j}(\delta_j),1]$, so $a\ge q_*$. The mixture (27) with weight $q_*$ satisfies each finite-block constraint by Proposition 1. $\square$

A reverse-KL constraint with any finite budget therefore dominates the first-order law even if other, more permissive divergence budgets are also imposed. This conclusion concerns this resource model and orientation, not an arbitrary mixture of normalized or one-letter constraints.

## 10. Relation to prior work and limits of novelty verification

The distinction from the closest sources is mathematical, not terminological.

| Prior result | Role here | Additional result in this paper |
|:--|:--|:--|
| Fixed prescribed iid output distribution [2, 3] | Supplies the established endpoint $D_p$ and coding background | Optimizes over all dependent outputs under a fixed nonzero block budget |
| Perfect or near-perfect strong realism [4, 5] | Explains zero or vanishing-TV endpoints and randomness models | Determines the full fixed-budget scalar law and its directional phase distinction |
| One-shot and information RDP coding [6] | Provides related randomized coding methodology | Proves a matching converse for the unnormalized entire-block constraint |
| General-source information-spectrum RDP [7, 8] | Relevant earlier formulations with different coding/randomness restrictions | A computable finite-alphabet, unlimited-randomness first-order frontier |
| Iid optimality conjecture [1] | Explicit question being tested | Exact iid penalty, all-rate strict examples, and a finite-randomness counterexample |

The cited literature distinguishes exact iid output, empirical realism, vanishing total variation, one-letter f-divergence, normalized block divergence, fixed nonzero whole-block budgets, and available randomness. A statement proved for one of these models is not silently transferred to another.

Chen and Khisti, *An Overview of Rate-Distortion-Perception Theory*, [arXiv:2609.15580v1](https://arxiv.org/abs/2609.15580v1) (2026), uses a normalized block optimal-transport criterion and an iid-reconstruction variant in Sections 3.1–3.2. Equation (4) uses a fixed unnormalized constraint.

The endpoint construction is credited to prior theory, even though Section 5 proves the needed finite-alphabet form. The new theorem is the exact reduction (10) and its converse for arbitrary dependent reconstructions, rather than the scalar evaluation of an f-divergence or the existence of block time sharing by itself.

The scientific limits are substantive. Bounded loss is used in exact-output repair and in discarding vanishing-probability branches. Finite alphabets supply compactness and finite information-density variance. Unlimited independent randomness enables the endpoint codes. A fixed-length constraint bounds every selected branch by the same message cardinality. Removing any of these assumptions requires a new argument. The theorem does not assert that the demonstrated non-iid construction is efficient or visually desirable, nor that its full dependence pattern is unique.

Chen et al. [9] provide an especially relevant distinction. Their symbolwise formulation and their block formulation with an explicit $1/n$ normalization are different from (4); the block theorem also imposes tensorization and decomposition assumptions on the perception measure. Consequently it does not already yield (10). In particular, one must not assume that source-to-output KL against an arbitrary correlated output automatically dominates the sum of its one-letter source-to-output KL divergences: the block mixture in (32) keeps its block divergence bounded while that sum grows linearly.

## 11. Reproduction and validation scope

The companion case includes exact rational certificates for (32)--(34), numerical tests of the finite-block conditional bound under genuine postselection, independent f-divergence mixture checks, and the Bernoulli endpoint curves. The programs enumerate finite examples or evaluate formulas; they do not replace the continuum of parameters covered by the written proofs. Their random seeds, tolerances and actual outputs are recorded separately.

This research manuscript has not undergone external peer review.

## References

1. X. Niu, B. Bai, N. Guo, W. Zhang and W. Han. *Rate-Distortion-Perception Trade-Off in Information Theory, Generative Models, and Intelligent Communications*. Entropy **27**(4), 373 (2025). [DOI: 10.3390/e27040373](https://doi.org/10.3390/e27040373). See Section 6.2.1, Conjecture 1; the budget is on the entire block law.

2. N. Saldi, T. Linder and S. Yüksel. *Randomized Quantization and Source Coding With Constrained Output Distribution*. IEEE Transactions on Information Theory **61**(1), 91--106 (2015). [DOI: 10.1109/TIT.2014.2373382](https://doi.org/10.1109/TIT.2014.2373382). Author manuscript: [arXiv:1309.2915v2](https://arxiv.org/abs/1309.2915v2).

3. N. Saldi, T. Linder and S. Yüksel. *Output Constrained Lossy Source Coding With Limited Common Randomness*. IEEE Transactions on Information Theory **61**(9), 4984--4998 (2015). [DOI: 10.1109/TIT.2015.2450721](https://doi.org/10.1109/TIT.2015.2450721). Author manuscript: [arXiv:1411.5767v2](https://arxiv.org/abs/1411.5767v2).

4. A. B. Wagner. *The Rate-Distortion-Perception Tradeoff: The Role of Common Randomness*. [arXiv:2202.04147](https://arxiv.org/abs/2202.04147) (2022). The perfect/near-perfect realism model is the relevant comparison; no publication status is inferred from this preprint citation.

5. Y. Hamdi, A. B. Wagner and D. Gündüz. *Rate-Distortion-Perception Trade-Off With Strong Realism Constraints: Role of Side Information and Common Randomness*. IEEE Transactions on Information Theory **72**(9), 6401--6421 (2026). [DOI: 10.1109/TIT.2026.3702694](https://doi.org/10.1109/TIT.2026.3702694). The compared author version is [arXiv:2507.14825v1](https://arxiv.org/abs/2507.14825v1); version-of-record text is not claimed byte-identical.

6. L. Theis and A. B. Wagner. *A Coding Theorem for the Rate-Distortion-Perception Function*. ICLR 2021 workshop contribution; [arXiv:2104.13662](https://arxiv.org/abs/2104.13662). This is methodological background and is not used as a flagship main-conference benchmark.

7. R. Matsumoto. *Rate-distortion-perception tradeoff of variable-length source coding for general information sources*. IEICE Communications Express **8**(2), 38--42 (2019). [DOI: 10.1587/comex.2018XBL0139](https://doi.org/10.1587/comex.2018XBL0139).

8. R. Nomura. *Optimum Self Random Number Generation Rate and Its Application to Rate Distortion Perception Function*. [arXiv:2311.15220v2](https://arxiv.org/abs/2311.15220v2). Used to check the deterministic-code, general-source formulation; no claim that it studies unrestricted shared randomness.

9. J. Chen, L. Yu, J. Wang, W. Shi, Y. Ge and W. Tong. *On the Rate-Distortion-Perception Function*. IEEE Journal on Selected Areas in Information Theory **3**(4), 664--673 (2022). [DOI: 10.1109/JSAIT.2022.3231820](https://doi.org/10.1109/JSAIT.2022.3231820). Author manuscript: [arXiv:2204.06049v1](https://arxiv.org/abs/2204.06049v1); see Section IV, Definition 4, equation (23), and Theorem 9.

## Appendix A. Expected prefix length: the same mass, a different allocation

This appendix changes only the communication resource. A message is now a finite binary word $W_n$, and for each value of the independent random seed known to the coding functions, the possible transmitted words form a prefix-free set. Any original code whose possible words are prefix-free conditional on its common seed also has this property after all private seeds are pooled for the converse. Length zero, with the empty word as the only message, is permitted. The constraint is

$$\limsup_n\frac{\mathbb E\ell(W_n)\log2}{n}\le R. \tag{39}$$

Randomness is still independent of the source and unrestricted. The perception and distortion definitions remain (2)--(4). Denote this optimum by $\mathsf D_{f,\mathrm{vl}}$.

### Theorem 11. Exact expected-length allocation

For $q=q_f(\delta)$,

$$\boxed{\mathsf D_{f,\mathrm{vl}}(R,\delta)
=\min_{\substack{r_1,r_0\ge0\\qr_1+(1-q)r_0\le R}}
\{qD_p(r_1)+(1-q)D_0(r_0)\}.} \tag{40}$$

At $q=0$ and $q=1$, the formula means $D_0(R)$ and $D_p(R)$, respectively. The active rates can be restricted to $[0,H(p)]$, since no coupling of a source with law $p$ has larger mutual information. Equivalently, (40) is the compact optimization over two couplings with source marginal $p$, output marginal $p$ in the first coupling, and weighted mutual information at most $R$.

**Proof.** Let $B$ be any finite-valued function of $Y^n$, let $a_b=\Pr(B=b)$, and let $\bar\pi_b$ be its conditional average coordinate coupling. The first inequality in (17), before invoking the message bound, gives

$$\begin{aligned}
n\sum_b a_b\{I(\bar\pi_b)+D((\bar\pi_b)_X\Vert p)\}
&\le\sum_b a_b\{D(P_{X^n|b}\Vert p^{\otimes n})+I(X^n;Y^n\mid B=b)\}\\
&=I(X^n;B)+I(X^n;Y^n\mid B)\\
&=I(X^n;Y^n)\\
&\le I(X^n;W_n\mid K)\le H(W_n\mid K)
\le\mathbb E\ell(W_n)\log2.
\end{aligned} \tag{41}$$

The penultimate step uses $X^n\perp K$ and $Y^n=h(W_n,K)$. For the last step apply Kraft's inequality for each fixed seed and the entropy bound for a distribution on a prefix-free set; equivalently compare its message probabilities with the subprobability weights $2^{-\ell(w)}$ using nonnegativity of relative entropy. This is valid whenever the expected length is finite. In particular, there is no additional $H(B)$ loss in (41).

Take the binary partition in (18). As before, any limit of its first mass is $a\ge q$, every nonvanishing conditional source marginal tends to $p$, and the typical branch has output marginal tending to $p$. Compactness and (41) give limit couplings $\pi_1,\pi_0$ with weighted information at most $R$ and the corresponding weighted distortion. Null branches can be filled with arbitrary feasible couplings; their contributions vanish.

If $0 \lt q<1$ and $a\ge q$, retain $\widetilde\pi_1=\pi_1$ and set

$$\widetilde\pi_0=\frac{(a-q)\pi_1+(1-a)\pi_0}{1-q}. \tag{42}$$

Both source marginals are $p$. Mutual information is convex for a fixed source marginal, so the weighted information with masses $(q,1-q)$ does not exceed that with masses $(a,1-a)$; distortion is exactly preserved. This proves the lower bound in (40). For $q=0$, combine both couplings into the ordinary feasible coupling; for $q=1$, necessarily $a=1$ and only the exact-output coupling remains.

Conversely, choose minimizers in (40). Lemma 5 supplies fixed-length component codes at rates $r_1+o(1)$ and $r_0+o(1)$ with their required exact output marginals. Select the branch using shared independent randomness. Conditional on that selector, use a binary fixed-length word of length $\lceil\log_2 m_{b,n}\rceil$; the decoder knows which codebook and length apply. These sets are prefix-free for each seed, and the expected rate tends to the weighted rate in (40). Proposition 1 supplies the exact block perception bound, and the weighted distortion converges to the objective. This achieves the lower bound, including the endpoints. $\square$

### Corollary 12. Strict small-rate length advantage

For the biased Bernoulli source of Proposition 7 and fixed $q=q_f(\delta)\in(0,1)$, as $R\downarrow0$,

$$\mathsf D_f(R,\delta)-\mathsf D_{f,\mathrm{vl}}(R,\delta)
=2\sqrt2\,p(1-p)(\sqrt q-q)\sqrt R+O(R)>0 \tag{43}$$

for all sufficiently small positive $R$.

**Proof.** Taylor expansion of (29) gives

$$D_0(R)=p-\frac{R}{\log((1-p)/p)}+O(R^2).$$

At the independent coupling $a_0=p(1-p)$, the first derivative of the information in (30) vanishes and its second derivative is $[p^2(1-p)^2]^{-1}$. Hence

$$D_p(R)=2p(1-p)-2\sqrt2\,p(1-p)\sqrt R+O(R).$$

The fixed-length expansion follows from (10). In (40), allocating $r_1=R/q$ and $r_0=0$ achieves a leading decrease $2\sqrt2 p(1-p)\sqrt q\sqrt R$. No allocation can have a larger leading decrease: $r_1\le R/q$, while the ordinary branch decreases by at most $O(R)$ because $r_0\le R/(1-q)$ and $D_0$ has a finite right derivative at zero. The error bounds are uniform over these shrinking rate intervals for fixed $p,q$. Subtracting the two expansions proves (43); its coefficient is strictly positive. $\square$

The prefix-length endpoint simulation itself is established coding theory [6]; our achievability already follows from the fixed-output construction in Section 5. The additional content here is evaluation of the fixed nonzero block-budget optimum and the proven separation from fixed length. Earlier variable-length RDP work [7] uses a different randomness model, so (40) is not asserted for its deterministic decoder constraint.
