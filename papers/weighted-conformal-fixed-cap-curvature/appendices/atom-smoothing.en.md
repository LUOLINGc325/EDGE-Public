---
title: "Supplement. The sharp Simes coefficient over arbitrary score laws"
geometry: margin=0.78in
---

## Result

Fix the number of tests $m\ge2$, nominal level $0<q<1$ and weight cap $B\ge1$. In the all-null oracle model of the main manuscript, its coefficient $C_{m,q,B}$ in (3) is sharp over **all** score laws. In particular,
$$\sup_{P,Q,w,V:\,1\le w\le B}\mathrm{FDR}_n
=q+\frac{C_{m,q,B}}{n}
+O_{m,q,B}\!\left(n^{-5/4}\log(en)^{3/4}\right).$$
The result uses the uniform error in (1) of the main manuscript. A maximizing coefficient is attained by the continuous endpoint-weight model or its band-aligned atomic version. This extends the all-score conclusion of the main manuscript from two tests to arbitrary fixed $m$ and any $q$.

## An interval inequality for the Simes Hessian

Use $z(s)=(\mathbf 1_{\{s\le t_k\}}-t_k)_{k=1}^m$, $H=\nabla^2\psi_m(\mathbf t)$ and $D(s)=z(s)^{\mathsf T}Hz(s)$ from the main manuscript. For every interval $I=[a,b]\subset[0,1]$ of positive length, set $\bar z_I=|I|^{-1}\int_I z(s)\,ds$. We claim
$$\bar z_I^{\mathsf T}H\bar z_I\le |I|^{-1}\int_I D(s)\,ds. \tag{S1}$$

To prove (S1), let a latent score have the uniform distribution on $[0,1]$, and use the observed score obtained by collapsing all of $[a,b]$ to its midpoint, preserving the score elsewhere. Take $P=Q$ and $w=1$. The new score law has exactly one atom, with randomized-rank interval $I$. Outside the atom, the rank equals the latent score almost surely. On the atom, the conditional randomized rank is uniform on $I$, so $x(V)=\bar z_I$. Formula (1) of the main manuscript and $\int_0^1 D(s)\,ds=0$ now give
$$\lim_{n\to\infty}n(\mathrm{FDR}_n-q)
=\tfrac12\left(|I|\,\bar z_I^{\mathsf T}H\bar z_I-\int_I D(s)\,ds\right).$$
Unweighted BH with the continuous tie randomization used here satisfies $\mathrm{FDR}_n\le q$ for every $n$, as verified below. Hence the limit is nonpositive and (S1) follows.

For any original model, extend each unit by an independent uniform variable and use its randomized rank $T$ as a continuous score, leaving $w$ fixed. Conditional on the original score and weight, $z(T)$ averages to $x(V)$. On a non-atomic score, the two directions agree almost surely. On an atom, (S1) applies to its rank interval with the same conditional law of $T$ even given $w$. Multiplying by $w/\mu>0$ and averaging shows the continuous model has a coefficient at least as large as the original coefficient. The endpoint attaining construction and the uniform remainder from the main manuscript prove the result.

## Unweighted BH with continuous tie randomization

The positive regression dependence result for exactly this p-value is given by Jin and Candès, Appendix B.1, equation (12) and Lemma 10. Here is a direct leave-one-out proof in the all-null i.i.d. setting.

Fix a designated test. Condition on the sorted values in the pool consisting of the $n$ calibration scores and that test's score. Condition also on the other test scores and their randomizers, but leave the designated test's randomizer unconditioned. The other tests and randomizers are independent of the pool and its designated label. Within the pool, a score group of size $b$ occupying ranks $a+1,\ldots,a+b$ contains the designated score with probability $b/(n+1)$. Given this group, the designated p-value is $(a+bU)/(n+1)$ and is uniform on the corresponding interval. Therefore its conditional law is uniform on $[0,1]$. For almost every value $u$ of the designated p-value, the remaining calibration multiset is obtained by deleting rank $1+\lfloor(n+1)u\rfloor$. If the deleted rank belongs to a tied group, every deletion within that group gives the same multiset.

As $u$ increases, the sorted remaining calibration scores weakly decrease coordinatewise. With each other score and tie randomizer fixed, the contribution of one calibration score to its numerator is successively $1$, $U_j$, $0$ as that calibration score increases. Thus the other test p-values weakly increase in $u$. Let $R_0(u)$ be the BH count when the designated p-value in this vector is set to zero. Then $R_0(u)\ge1$ is nonincreasing. By the step-up property, the designated test is rejected exactly on $\{u:u\le qR_0(u)/m\}$. The original count there is $R_0(u)$.

The rejection set is an initial interval with length $c$. If $c=0$, the designated contribution to FDR is zero. Otherwise let $r$ be the minimum of $R_0$ on $(0,c)$. This minimum is an integer attained there, and by monotonicity $R_0=r$ on a left neighborhood of $c$. Values of $u$ in that neighborhood satisfy $u\le qr/m$, so $c\le qr/m$. The conditional expected contribution is at most $c/r\le q/m$. Summing over designated tests proves $\mathrm{FDR}_n\le q$.

## The iterated limit with a fixed weight cap

Write $d_{m,k}=D(s)/[m(m-1)]$ for $t_k<s<t_{k+1}$, $1\le k<m$, and set $d_{m,k}=0$ for $k\ge m$. The companion curvature case, Theorems 1–2, establishes $d_{m,k}\to d_k(q)$ at fixed $k$ and the geometric envelope $|d_{m,k}|\le c(q)\theta(q)^k$ with $\theta(q)<1$. In its notation, $C_{\rm win}(q)=\tfrac12\sum_{k\ge1}(d_k(q))_+$. For (3) of the main manuscript, the decreasing factor $1-(1-1/B)p$ is at most one. Since the positive bands have width $q/m$ each, this gives
$$\frac{C_{m,q,B}}{Bqm}\le\left(1-\frac1B\right)\frac{m-1}{2m}\sum_{k\ge1}(d_{m,k})_+.$$
For a lower bound, assign weight $B$ to exactly the positive-curvature bands among the first $K$ internal bands. Their total length is at most $Kq/m$, so the decreasing factor tends to one at fixed $K$ as $m\to\infty$. Taking $m\to\infty$ and then $K\to\infty$ gives the reverse bound by geometric summability. Therefore, with $q,B$ fixed, first taking $n\to\infty$ at each $m$ gives
$$
\lim_{m\to\infty}\lim_{n\to\infty}\frac{n}{qmB}
 \sup_{P,Q,w,V:\,1\le w\le B}(\mathrm{FDR}_n-q)
=\left(1-\frac1B\right)C_{\rm win}(q).
$$
At $q=99/100$ and $B=5$, the order-four Taylor sum of $e^q$ exceeds $8/3$. The companion case gives $C_{\rm win}(q)\ge(1-q)(1-e^{-q})$, so the displayed limit is strictly larger than $(1-q)/2$. A diagonal sequence may take $m\to\infty$ and choose $n$ for each resulting attaining model sufficiently large that the normalized expansion error tends to zero and $mB/n\to0$. Thus this violation of Lim's unrestricted Conjecture 20 occurs even with a fixed cap.

## References

- Ryan Lim. *Almost Controlled: The FDR of Benjamini–Hochberg on Weighted Conformal p-Values*. arXiv:2611.21509v1, 2026. §7, Conjecture 20, and Appendix D.6. <https://arxiv.org/abs/2611.21509v1>
- Ying Jin and Emmanuel J. Candès. *Selection by Prediction with Conformal p-values*. JMLR 24, 1–41, 2023. §B.1, equation (12), Lemma 10. <https://jmlr.org/papers/v24/22-1176.html>
- *Exact sign changes of the Simes band curvature and a global-null counterexample*. Companion research case, 2026, Theorems 1–2. [Manuscript](../../simes-band-curvature/manuscript/manuscript.zh.md)
