# A shared pilot for density-free replicable conformal calibration

## Abstract

Two analysts calibrate the same prediction score on independent private samples and share a smaller pilot sample. We give an order-based conformal rule whose probability of returning different thresholds and whose coverage inflation have exact finite-sample laws for every continuous score distribution. The formulas depend only on sample sizes and ranks. For a target coverage band of width of order $\varepsilon$, a public pilot of order $\varepsilon^{-1}\log(1/\delta)$ suffices for an accuracy failure probability $\delta$, with a separately specified private sample size controlling disagreement. A second guarantee conditions on a reusable pilot. We also prove a public-sample lower bound for all threshold procedures equivariant under increasing changes of score scale. These results answer the finite-sample density-ratio question of Papamichalis, Ruane and Papamichalis in the setting with an explicitly counted shared pilot. [Source problem, §§5 and 9](https://arxiv.org/html/2608.23638v1#S9)

## 1. Calibration by public pilot ranks

Fix a score function $s(x,y)$, shared by the analysts. Write $F$ for the continuous distribution function of a score on an independent example. It may have flat intervals. Let $p=1-\alpha\in(0,1)$, and let $T$ be the $k=\lceil (n+1)p\rceil$th smallest of $n$ private calibration scores, with $k\le n$. A new example is included in the prediction set $\{y:s(x,y)\le\tau\}$ with conditional probability $F(\tau)$ when the deployed threshold is $\tau$.

The analysts share $m\ge1$ pilot scores with order statistics $P_{(1)},\ldots,P_{(m)}$. Each private calibration sample, the pilot and the future test observation are independent samples from the same score law. Independently draw a common uniform residue $R\in\{1,\ldots,b\}$, for an integer block size $b\ge1$. Select pilot indices $R,R+b,R+2b,\ldots$ up to $m$. An analyst returns the first selected pilot score strictly above $T$, and returns $+\infty$ if no such score exists. In particular the procedure uses $n$ private scores per analyst and $m$ public scores shared once. The pilot supplies observed values from the target distribution. Public random bits alone supply only $R$.

Papamichalis, Ruane and Papamichalis round $T$ upward on a randomly shifted grid in score space. Their Theorem 2 uses a local density ratio. Their Proposition 2 uses a public pilot to estimate a grid width and retains a certified bound on that ratio. Section 9 asks about uniform removal of the ratio at finite sample size. Their Appendix E gives a separate distribution-free result on a known finite score grid, building on replicable quantile search. Here the actual score values used for rounding come from the pilot, so no numerical score grid is needed. The private-only problem for general score-scale-dependent rules remains open. [Source, §5](https://arxiv.org/html/2608.23638v1#S5) · [Source, Appendix E](https://arxiv.org/html/2608.23638v1#A5) · [Kalavasis et al., Theorem B.6](https://arxiv.org/abs/2405.15599)

## 2. Exact probabilities

Let $V=F(T)$ and let $V'$ be an independent copy. They have the $\operatorname{Beta}(k,n+1-k)$ law. Set $D=|V-V'|$, $d_n=\mathbb E D$, and $I=F(\tau)-V$, taking $F(+\infty)=1$. In expressions with a binomial argument, the binomial draw is conditional on its displayed success probability.

**Theorem 1.** Let $\tau,\tau'$ be the thresholds from two independent private calibrations using the same pilot and residue. Then

$$
 \Pr(\tau\ne\tau')
 =\mathbb E\min\left\{1,\frac{\operatorname{Bin}(m,D)}{b}\right\}
 \le \frac{m d_n}{b}. \tag{1}
$$

For $0\le x<1$, the excess coverage mass has tail

$$
 \Pr(I>x)=\Pr(V<1-x)\,
       \mathbb E\left(1-\frac{\operatorname{Bin}(m,x)}{b}\right)_+,
 \qquad
 0\le\mathbb E I\le\frac{b+1}{2(m+1)}. \tag{2}
$$

For every fixed pilot and residue, a fresh private calibration and test example have marginal coverage at least $k/(n+1)\ge p$. Agreement of the thresholds gives equality of the deployed prediction sets at every input.

*Proof.* The continuous probability integral transform gives independent uniform ranks for all scores, with their order preserved almost surely. Let $K,K'$ count pilot scores at or below the two private thresholds. If $K\le K'$, the outputs differ exactly when the integer interval $\{K+1,\ldots,K'\}$ contains a selected index. Every such index is an actual pilot index even when the larger threshold rounds to infinity. The interval contains $\min(b,K'-K)$ distinct residues. Interchanging the private runs gives the same formula with $|K-K'|$. Given $V,V'$, this difference counts pilot ranks in an interval of length $D$, proving (1).

Conditional on $V=v$ and all pilot ranks, the distance from $K$ to the next selected index on the unbounded integer lattice is uniform on $1,\ldots,b$, because the residue is independent. If $v+x<1$, the event $I>x$ occurs exactly when that distance exceeds the number of pilot ranks in $(v,v+x]$. This count has distribution $\operatorname{Bin}(m,x)$ conditional on $v$. If $v+x\ge1$, $I\le x$. Integrating proves the tail identity. To bound its integral, drop the factor $\Pr(V<1-x)$. The remaining factor is the average over $h=1,\ldots,b$ of $\Pr(\operatorname{Bin}(m,x)<h)$. Its integral on $[0,1]$ is the mean of the $h$th of $m$ uniform order statistics, $h/(m+1)$ for $h\le m$, and equals 1 for $h>m$. Averaging gives the stated upper bound. Finally, $\tau\ge T$ for every pilot and shift, and the independent test score has uniform rank among $n+1$ private calibration and test scores. $\square$

For exact tuning, with $a=k,\ c=n+1-k$ and $\mathrm B$ denoting the beta function,

$$
 d_n=\frac{4\mathrm B(2a,2c)}{(a+c)\mathrm B(a,c)^2}
 \le\sqrt{\frac{2\mu(1-\mu)}{n+2}},\qquad \mu=\frac{k}{n+1}. \tag{3}
$$

Indeed, for the beta density $f$ and distribution function $H$, symmetry gives $d_n=2\int_0^1 x(2H(x)-1)f(x)\,dx$. The identity $(x(1-x)f)'=(a-(a+c)x)f$, integration by parts and $\int(2H-1)f=0$ reduce the integral to $4\int_0^1 x(1-x)f(x)^2\,dx/(a+c)$. The variance bound follows by Cauchy–Schwarz.

## 3. Sample sizes and conditioning on the pilot

Fix $0<\varepsilon<\min(p,1-p)$, $0<\rho,\delta<1$, and put $q_n=\Pr(|V-p|>\varepsilon/2)$, an exact beta tail. A pilot with at least $b$ probability ranks in $(p+\varepsilon/2,p+\varepsilon]$ will be called good for accuracy. Those ranks occupy consecutive pilot indices, so every residue selects at least one of them. On such a pilot, every private sample with $|V-p|\le\varepsilon/2$ satisfies, simultaneously for all residues,

$$
 p-\varepsilon/2\le F(\tau)\le p+\varepsilon. \tag{4}
$$

Consequently the probability of a pilot failing this condition is at most $\Pr(\operatorname{Bin}(m,\varepsilon/2)<b)$. For every good pilot the private failure probability of the simultaneous band is at most $q_n$.

**Corollary 2.** Choose $b=\lceil4\log(2/\delta)\rceil$, $m=\lceil4b/\varepsilon\rceil$, and $n$ with $k\le n$, $d_n\le\rho\varepsilon/5$ and $q_n\le\delta/2$. Ex ante disagreement is at most $\rho$, and (4) holds with probability at least $1-\delta$ over the pilot and one private calibration, for every residue at once. The public sample size is $O(\varepsilon^{-1}\log(1/\delta))$.

*Proof.* Since $m/b\le5/\varepsilon$, (1) gives the agreement claim. The mean pilot count in the stated interval is at least $2b$, so a binomial Chernoff bound gives failure probability at most $e^{-b/4}\le\delta/2$. Combining the two failure probabilities gives (4). For explicit private sample sizes, $|k/n-p|\le 2/n$ and the Dvoretzky–Kiefer–Wolfowitz inequality give $q_n\le2e^{-n\varepsilon^2/8}$ if $n\ge8/\varepsilon$. Further, $\mu(1-\mu)\le p(1-p)+1/(n+1)$. Thus the conditions admit private size of order

$$
 \frac{p(1-p)}{\rho^2\varepsilon^2}
 +\frac1{\rho\varepsilon}
 +\frac{\log(1/\delta)}{\varepsilon^2}
$$

apart from the stated valid-rank condition. $\square$

**Proposition 3 (reusing a fixed public pilot).** Write $Z_i=F(P_i)$ for the unsorted pilot ranks. For a fixed pilot, disagreement over two independent private calibrations and the common random residue is at most

$$
 \frac1b\sum_{i=1}^m 2H(Z_i)(1-H(Z_i)).
$$

For $s>0$, with pilot probability at least $1-e^{-s}$ this is at most

$$
 \frac{m d_n+\sqrt{m d_n s}+s/3}{b}. \tag{5}
$$

*Proof.* The residue calculation gives a conditional bound by $\mathbb E(|K-K'|\mid P)/b$. A pilot rank $z$ lies between the two private ranks with probability $2H(z)(1-H(z))$. The independent summands lie in $[0,1/2]$, have mean $d_n$ by integration of the interval length, and have variance at most $d_n/2$. Bernstein's inequality gives (5). $\square$

For example, for pilot failure probability $\eta$, choose $s=\log(2/\eta)$, $b=\lceil4s/\rho\rceil$, $m=\lceil4b/\varepsilon\rceil$ and $d_n\le\rho\varepsilon/10$. With probability at least $1-\eta$, one pilot is good for accuracy and has conditional disagreement at most $\rho$. Indeed $m d_n/b\le\rho/2$, the square-root term in (5) divided by $b$ is at most $\rho/\sqrt8$, and its last term is at most $\rho/12$. The accuracy event costs at most $e^{-b/4}$. Disagreement here averages over the common residue after fixing the pilot. The accuracy event in (4) holds for all residues simultaneously.

At $p=0.9,\ \varepsilon=0.02,\ n=500000,\ m=800,\ b=4$, equation (1) bounds ex ante disagreement by $0.095746$, and (2) bounds expected excess by $5/1602$. The probability of fewer than four pilot points in $(0.91,0.92]$ on the probability scale is $0.041666$ rounded upward to six decimals. The beta probability outside $[0.89,0.91]$ is below $2\cdot10^{-116}$. Thus the band $[0.89,0.92]$ holds with probability above $0.9583$ for every realization of the shared residue on the same pilot-and-private-sample event.

## 4. A converse for order-equivariant calibration

Call a real or extended-real threshold procedure order-equivariant if applying any increasing homeomorphism of $\mathbb R$ to every private and public input score transforms the output by the same map, for every fixed realization of its auxiliary randomness. Extend each map to preserve $\pm\infty$. The procedure above has this property.

**Theorem 4.** Suppose two runs with independent private data and a common pilot of $m$ observations agree with probability at least $1-\rho$. Suppose one run's coverage $F(\tau)$ lies in a fixed closed interval contained in $(0,1)$, of length $w$, with probability at least $1-\delta$. Every order-equivariant threshold procedure satisfies

$$
 (1-w)^m\le\rho+\delta. \tag{6}
$$

If the procedure always returns a pilot score or an infinite endpoint, the sharper inequality $(1-w)^m\le\delta$ holds. For this latter class, the order of the public sample size in Corollary 2 is necessary when $w$ is proportional to $\varepsilon$.

*Proof.* Fix the data and all randomness. An increasing piecewise-linear homeomorphism can fix every observed value and move any specified finite point outside the observed values, including a point on an outer ray. Equivariance therefore forces each finite output to equal an observed input. By continuity and independence, the only observations shared between the two runs are their public pilot values almost surely. Agreement at a finite threshold consequently requires a pilot value. With probability $(1-w)^m$, no pilot probability rank lies in the specified interval. On this event, agreement and a correctly located first-run threshold cannot both occur, yielding (6). If all possible finite outputs are already pilot values, the same event forces first-run failure. $\square$

In particular an order-equivariant private-only procedure with $m=0$ must have $\rho+\delta\ge1$ for an interior coverage band. Score-scale-dependent procedures, including rounding on an externally specified numerical grid, fall outside this converse.
