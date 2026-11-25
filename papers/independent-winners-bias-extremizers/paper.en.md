# Sharp bounds for the expected maximum at prescribed winning probabilities

## Abstract

Let independent centered scores have total variance $V$, and let $p_i$ be the probability that score $i$ wins. We prove that their expected maximum is at most $\sqrt{V(1-\sum_i p_i^2)/2}$. The bound holds for every rule for resolving ties and is attained for every strictly positive probability vector. We identify all attaining laws at such vectors. One score is identically zero and the others have explicitly determined two-point laws. Uniform winning probabilities recover the previously known sharp constant and settle the deterministic-arm conjecture of Viakhirev, Borodin and Mkrtchian. A formula for the loss in the two-point bound also yields a short proof of the sharp constant. [Viakhirev, Borodin and Mkrtchian, Theorem 3 and §7](https://arxiv.org/html/2610.31948v1#S7)

## 1. The bounds and their equality cases

Let $M\ge2$. Let $Z_1,\ldots,Z_M$ be independent real random variables with mean zero and finite second moments. Write

$$
 T=\max_i Z_i,\qquad V=\sum_i\mathbb E Z_i^2,\qquad b=\mathbb E T.
$$

A winner is a random index $I$ with $Z_I=T$ almost surely. Its law is $p_i=\Pr(I=i)$. Ties can depend on the data and on auxiliary randomness. Define

$$
 H(p)=\frac{1-\sum_i p_i^2}{2}=\sum_{i<j}p_ip_j.
$$

Twice $H(p)$ is the probability that two independent repetitions have different winners.

**Theorem 1.** Every such experiment satisfies

$$
 b^2\le V H(p). \tag{1}
$$

For every $p$ with all coordinates positive, the largest possible value of $b/\sqrt V$ for $V>0$ is exactly $\sqrt{H(p)}$. The following construction gives all the maximizing joint laws. Choose an ordering of the labels, write them as $1,\ldots,M$ in that order, and put $s_i=\sum_{j=i}^M p_j$. Choose $c>0$, take $Z_M=0$, and independently for $i<M$ set

$$
 Z_i=\begin{cases}
 c s_{i+1} &\text{with probability }p_i/s_i,\\
 -c p_i &\text{with probability }s_{i+1}/s_i.
 \end{cases} \tag{2}
$$

Here the last label is the deterministic score. Each constructed experiment has a unique winning index on every outcome.

**Corollary 2.** The unrestricted maximum of $b/\sqrt V$ equals $C_M=\sqrt{(M-1)/(2M)}$. Equality holds exactly when all winning probabilities equal $1/M$ and the joint distribution has form (2). Equivalently, up to permutation and a common positive scale $d$, one score is zero and each remaining score $k$, for $1\le k<M$, equals $kd$ with probability $1/(k+1)$ and $-d$ otherwise.

Viakhirev, Borodin and Mkrtchian established the value $C_M$, exhibited the uniform-probability cascade and proved that a deterministic score is necessary when $M=2$. Their §7 and Appendix D.5 explicitly leave necessity open for general $M$. Their Appendix C uses a first-positive-score decomposition with a deterministic floor. The proof below retains the vector of winning probabilities and treats the all-negative outcome explicitly. This gives the bound at prescribed $p$ and identifies every attaining law. [Prior sharp bound and construction](https://arxiv.org/html/2610.31948v1#A3) · [Conjecture and proved two-score case](https://arxiv.org/html/2610.31948v1#A4.SS5)

For example, take $p=(1/2,1/3,1/6)$ and $c=1$. The three scores are a symmetric $\pm1/2$ score, a score equal to $1/6$ with probability $2/3$ and $-1/3$ otherwise, and the deterministic zero. Their expected maximum and total variance both equal $11/36$. The resulting ratio $\sqrt{11}/6$ is the largest possible for those winning probabilities.

## 2. The finite two-point calculation

First resolve ties by a fixed total priority on the labels. Suppose that every score is either identically zero or has positive value $u_i$ with probability $x_i\in(0,1)$ and negative value $-x_i u_i/q_i$ with probability $q_i=1-x_i$. List the nonconstant scores in decreasing order of $u_i$, using the priority to order equal heights. If there are $m$ of these scores, define

$$
 s_1=1,\quad s_{i+1}=s_iq_i,\quad r_i=s_i x_i,\quad Q=s_{m+1}.
$$

The event that $i$ is the first positive score has probability $r_i$. The probability that all are negative is $Q$. In particular $s_{i+1}=\sum_{j>i}r_j+Q$. Write $w_i=x_i u_i$, so that the total variance is $W=\sum_i w_i^2/(x_i q_i)$.

If a deterministic zero is present, the priority chooses a fixed zero label on the all-negative outcome. The nonzero winning probabilities are thus $r_1,\ldots,r_m,Q$. The conditional expected maximum for this finite experiment, denoted by $e$, is $\sum_i w_i s_i$. Cauchy–Schwarz gives

$$
 e^2\le W\sum_i x_iq_i s_i^2
 =W\sum_i r_i s_{i+1}=W H(\pi), \tag{3}
$$

where $\pi$ is the full vector of winning probabilities. The last sum counts every unordered pair amongst the $m+1$ outcome probabilities once. This includes the case with all scores deterministic, in which both sides are zero. When $W>0$, equality holds precisely when some $c>0$ satisfies $u_i=c q_i s_i=c s_{i+1}$ for all random scores.

Suppose now that all $M=m$ scores are nonconstant. On the all-negative outcome let $k$ win by the fixed priority among the largest negative scores. Thus $\pi_k=r_k+Q$ and $\pi_i=r_i$ for $i\ne k$. The linear expression for the expected maximum is

$$
 e=\sum_i w_i s_i-Qw_k/q_k.
$$

Writing $S=s_{k+1}>0$, Cauchy–Schwarz now gives $e^2\le W h_k$, where

$$
\begin{aligned}
 h_k&=\sum_{i\ne k}x_iq_i s_i^2+x_kq_ks_k^2(1-Q/S)^2\\
    &=H(\pi)-r_kQ(1-Q/S).
\end{aligned}\tag{4}
$$

Indeed, replacing $r_k S$ by $r_k S(1-Q/S)^2$ subtracts $2r_kQ-r_kQ^2/S$ from the unordered pair sum on $(r_1,\ldots,r_m,Q)$. Combining the outcomes of masses $r_k,Q$ changes that pair sum to $H(\pi)$ by subtracting $r_kQ$.

When $k<M$, the scores following $k$ have positive probabilities of taking positive values, so $Q<S$, and (4) is strictly below $H(\pi)$. When $k=M$, the coefficient of $w_k$ in $e$ is zero. The variance term $w_k^2/(x_kq_k)$ is strictly positive, and the other coefficients are positive since $M\ge2$. Cauchy–Schwarz is therefore strict. **Every two-point experiment in which all scores are nonconstant has $e^2<W H(\pi)$.**

## 3. From mixture components to arbitrary scores

Two-point disintegrations of centered laws are classical. We use a product mixing measure whose strictly positive density will also identify equality cases. [Pinelis, 2009](https://doi.org/10.1214/EJP.v14-633) · [Ming et al., Lemma 3.2](https://arxiv.org/html/2607.18661v1#S3.SS2)

A centered integrable law $\mu$ has the following mixture representation. Let $\mu_+$ and $\mu_-$ be its restrictions to strictly positive and strictly negative values, mapping the latter to its positive magnitude. Let $m_0=\int u\,d\mu_+(u)=\int d\,d\mu_-(d)$. If $m_0=0$, the law is $\delta_0$. Otherwise use a zero component of mass $\mu(\{0\})$ and mixing measure

$$
 d\nu(u,d)=\frac{u+d}{m_0}\,d\mu_+(u)\,d\mu_-(d)
 \qquad (u,d>0).
$$

On that component use the centered law on $u,-d$ with respective probabilities $d/(u+d),u/(u+d)$. Integrating the positive and negative component masses recovers $\mu_+$ and $\mu_-$, so the displayed weights, together with the zero component, sum to one. The component variance is $ud$.

Independently sample one component for each marginal law. Given the component vector $\Theta$, let $W$ denote the sum of conditional variances, $e$ the conditional expected maximum, and $\pi$ the conditional winner vector for the fixed priority. Conditional means vanish, so $\mathbb EW=V$. Also $\mathbb Ee=b$ and $\mathbb E\pi=p$. These expectations exist since $|T|\le\sum_i|Z_i|$. From (3)–(4), Cauchy–Schwarz and the concavity of $H$,

$$
 b\le\mathbb E\sqrt{W H(\pi)}
 \le\sqrt{V\,\mathbb E H(\pi)}\le\sqrt{V H(p)}. \tag{5}
$$

Here $\mathbb E T\ge0$ since $T\ge Z_1$. This proves (1) for each fixed priority.

The same bound holds for any measurable winner. Write $A=\{i:Z_i=T\}$. For each fixed priority $\rho$ let $p^\rho$ be its winner vector. For every real vector $v$,

$$
 v\cdot p=\mathbb E[v_I]\le\mathbb E\max_{i\in A}v_i
          =\max_\rho v\cdot p^\rho.
$$

Sorting the priority by decreasing $v_i$ gives the last equality. Finite-dimensional separation places $p$ in the convex hull of the $p^\rho$. Write $p=\sum_\rho\lambda_\rho p^\rho$. Then $b^2/V\le\sum_\rho\lambda_\rho H(p^\rho)\le H(p)$ if $V>0$. The case $V=0$ is immediate.

## 4. Attainment and rigidity

In (2), the probability that score $i$ is the first positive score is exactly $p_i$, and the event on which the deterministic score wins has probability $p_M$. The heights are strictly decreasing. Since the variance of a centered two-point law on $u,-d$ is $ud$,

$$
 b=c\sum_{i<M}p_i s_{i+1}=cH(p),\qquad
 V=c^2\sum_{i<M}p_i s_{i+1}=c^2 H(p).
$$

This proves attainability for every strictly positive $p$.

Conversely, assume $V>0$, all $p_i>0$, and equality in (1). For any priority carrying positive weight in the convex decomposition above, equality holds in the fixed-priority bound and $p^\rho=p$. Indeed, the concavity gap is $\tfrac12\sum_\rho\lambda_\rho\|p^\rho-p\|_2^2$, and the other gaps also have one sign. Fix one such priority. Equality in (5) similarly gives $\pi=p$ almost surely. As $H(p)>0$, equality in Cauchy–Schwarz in (5) forces $W=V$ almost surely.

The component variances $V_i(\Theta_i)$ are independent and nonnegative, and they sum to the constant $V$. Each is bounded by $V$, so additivity of variances implies that each is itself constant. Its value is $v_i=\mathbb E Z_i^2$. If $v_i>0$, the marginal mixture has no zero component. Moreover $ud=v_i$ for $\nu_i$-almost every $(u,d)$. This measure has strictly positive density with respect to $\mu_{i,+}\otimes\mu_{i,-}$. Fubini's theorem, first fixing a typical $d>0$, forces $\mu_{i,+}$ to be concentrated at the single point $v_i/d$. The identity then forces $\mu_{i,-}$ to be concentrated at a single point as well. Thus every nonconstant original score already has a centered two-point law.

The strict inequality following (4) now forces a deterministic zero score. There is exactly one. Under the fixed priority a second deterministic zero could never win, contrary to $p_i>0$. In the notation of (3), the first-positive probabilities give $s_i=\sum_{j\ge i}p_j$, $x_i=p_i/s_i$. Equality in (3) gives $u_i=c s_{i+1}$, so the negative atom is $-x_i u_i/q_i=-c p_i$. These are precisely the laws in (2). This finishes Theorem 1. Finally, $H(p)\le (M-1)/(2M)$, with equality precisely at the uniform vector. Substitution into (2) proves Corollary 2.

## 5. Stability near the sharp constant

The winning probabilities satisfy an explicit estimate whenever $V>0$,

$$
 \sum_i(p_i-1/M)^2\le2\left(C_M^2-\frac{b^2}{V}\right). \tag{6}
$$

This follows by subtracting (1) from the identity $H(p)=C_M^2-\tfrac12\sum_i(p_i-1/M)^2$.

There is also a qualitative stability statement for the score distributions. Normalize $V=1$ and keep $M$ fixed. Let $\mathcal E_M$ be the finite set of labeled normalized cascade laws from Corollary 2. If a sequence of independent centered score vectors has $b\to C_M$, the distance of its vector of marginal laws to $\mathcal E_M$ tends to zero in the product of the quadratic Wasserstein metrics.

To prove this, take any subsequence. The marginal second-moment bounds give tightness, so a further subsequence has weak marginal limits. Independence gives the joint product limit. The same bounds imply uniform integrability of the absolute coordinates and of the maximum, so means and $b$ pass to the limit. Lower semicontinuity gives limiting total variance at most one. The sharp bound at the limit, where $b=C_M$, forces that total to equal one. Since there are finitely many coordinates and each second moment is lower semicontinuous, every marginal second moment converges. Weak convergence together with convergence of second moments is convergence in quadratic Wasserstein distance. Corollary 2 identifies the limit as a member of $\mathcal E_M$. This proves the assertion by the subsequence criterion. In particular, requiring each score to carry at least a fixed positive share of total variance forces a strict gap below $C_M$, uniformly over all such independent centered laws.
