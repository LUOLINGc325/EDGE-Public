# Sharp fixed-cap curvature of all-null weighted conformal Simes tests

## Abstract

For the Simes test on oracle weighted-conformal p-values sharing one calibration sample, we identify the exact leading all-null false discovery rate (FDR) error. With the number of tests, nominal level and weight cap fixed, the expansion is uniform over score laws, including atoms. Its coefficient contracts the Simes Hessian with a weighted covariance of the conditional randomized rank. For continuous scores, a sorted-band calculation gives the sharp worst-case coefficient and an attaining likelihood ratio. For two tests the same optimum holds over every score law, with an explicit coefficient attained by either continuous scores or a three-point distribution. This settles a bounded-cap part of the all-null constant problem raised by Lim.

## 1. Model and result

There are $n$ independent calibration units $Z_i\sim P$ and $m$ independent test units $Z^*\sim Q$, with the two groups independent. For a real score $V=V(Z)$ assume $dQ/dP=w/\mu$, where $\mu=E_Pw$ and $1\le w\le B<\infty$. Each test uses its own $U\sim\mathrm{Unif}(0,1)$, independent of everything else, in the oracle p-value
$$p_n=\frac{\sum_i w(Z_i)\mathbf 1_{\{V_i<V^*\}}+
 U\left[w(Z^*)+\sum_i w(Z_i)\mathbf 1_{\{V_i=V^*\}}\right]}{\sum_i w(Z_i)+w(Z^*)}.$$
Let $m\ge2$, $q\in(0,1)$ and $t_k=qk/m$. Let $\psi_m(g_1,\ldots,g_m)$ be the probability that i.i.d. p-values with CDF $g_k$ at $t_k$ cross at least one Simes threshold. Set $H=\nabla^2\psi_m(\mathbf t)$. The rejection event is determined by the vector of band counts, so $\psi_m$ extends to a polynomial in $g_1,\ldots,g_m$.

Write $F(v)=Q(V\le v)$ and $F(v-)=Q(V<v)$. Let $A_s(v)$ be the probability that an independent randomized rank uniform on $[F(v-),F(v)]$ is at most $s$, with the point mass convention when the interval is degenerate. Define $x_k(v)=A_{t_k}(v)-t_k$. With $m,q,B$ fixed,
$$
\mathrm{FDR}_n=q+\frac{1}{2n} E_Q\!\left[\frac{w}{\mu}x(V)^{\mathsf T} Hx(V)\right]
 +O_{m,q,B}\!\left(n^{-5/4}\log(en)^{3/4}\right). \tag{1}
$$
The error is uniform in $P,Q,w,V$. Here all units are oracle nulls, so FDR is the probability of a Simes rejection. The order is for $n\to\infty$ with a common upper bound on the weight ratios.

## 2. Uniform coefficient proof

The randomized probability-integral transform $T=F(V^*-) + U[F(V^*)-F(V^*-)]$ is uniform under the test law, so $E_Q A_s(V)=s$. Define the nondecreasing function
$$J_n(s)=\frac{\sum_i w(Z_i) A_s(V_i)}{\sum_i w(Z_i)},\qquad D_n(s)=J_n(s)-s.$$
Almost surely $A_T(V_i)=\mathbf1_{\{V_i<V^*\}}+U\mathbf1_{\{V_i=V^*\}}$. To see this, the randomized intervals for different scores are ordered. The test rank has probability zero of equaling a calibration interval endpoint, by its conditional uniformity given the calibration sample. For equal scores with positive mass the equality follows from affine interpolation inside their interval. The equality of two scores of zero individual mass has probability zero, by independence and $P\ll Q$. Consequently
$$|p_n-J_n(T)|\le B/n. \tag{2}$$
Indeed $p_n$ is a convex combination of $J_n(T)$ and $U$, with coefficient of $U$ at most $B/n$.

Fix a grid point $t$. Put $\ell=\log(en)$ and $r=4B\sqrt{\ell/n}$. Restrict to $n$ sufficiently large that $[t-r,t+r]\subset(0,1)$. Hoeffding gives
$$\Pr(|D_n(t)|>r/2)\le2e^{-8\ell},$$
since the denominator average is at least one and $w(A_t-t)$ has mean zero and range length at most $B$. For any $s\ge t$ with $s-t\le r$, write $d=s-t$, $\Delta=A_s(V)-A_t(V)$ and $Y=w(\Delta-d)$. Then $E_PY=0$, $|Y|\le B$ and
$$E_PY^2 \le B\mu E_Q(\Delta-d)^2\le B^2 d.$$
The same bound applies to the signed reverse difference when $s<t$. At any fixed $s$ of the local interval, Bernstein applied before dividing by the denominator average gives
$$
\Pr\!\left(|D_n(s)-D_n(t)|>
 B\sqrt{16 r\ell/n}+\frac{16B\ell}{3n}\right)\le2e^{-8\ell}.
$$
Use a deterministic mesh of spacing at most $1/n$, including both endpoints and with at most $2n+4$ points. Between mesh points, monotonicity of $J_n$ extends the bound on $D_n(s)-D_n(t)$ at the cost of $1/n$. Thus with probability $1-O(n^{-7})$ both $|D_n(t)|\le r/2$ and
$$\sup_{|s-t|\le r}|D_n(s)-D_n(t)|\le\eta,\qquad
 \eta=B\sqrt{16r\ell/n}+\frac{16B\ell}{3n}+\frac1n.$$
The constants are common to all laws. For sufficiently large $n$, $\eta+2B/n\le r/2$. On this event set $s_\pm=t-D_n(t)\pm(\eta+2B/n)$. They lie in the local interval and $J_n(s_-)\le t-2B/n$, $J_n(s_+)\ge t+2B/n$. Let $G_n(t)$ be the conditional CDF of $p_n$ given the calibration units. By (2), monotonicity and uniformity of $T$ conditional on calibration, $s_-\le G_n(t)\le s_+$. In particular
$$\|G_n(t)-t+D_n(t)\|_{L^j}
 =O_B(n^{-3/4}\ell^{3/4}),\qquad j\in\{2,3\}.$$
On the exceptional event the absolute expression is at most two, so its contribution to either norm is absorbed in the bound. Hoeffding also yields $\|D_n(t)\|_{L^3}=O_B(n^{-1/2})$ by integrating the pointwise bound $\Pr(|D_n(t)|>u)\le2e^{-2nu^2/B^2}$. It follows that $\|G_n(t)-t\|_{L^3}=O_B(n^{-1/2})$.

Let $L_n(t)=n^{-1}\sum_i w_i(A_t(V_i)-t)/\mu$. Both the numerator average and $n^{-1}\sum_i w_i-\mu$ have fourth norms $O_B(n^{-1/2})$, by Hoeffding and integration. Since the two denominators are at least one, Hölder gives $\|D_n(t)-L_n(t)\|_{L^2}=O_B(n^{-1})$. Writing $g=\bigl(G_n(t_k)-t_k\bigr)_{k=1}^m$ and $L=\bigl(L_n(t_k)\bigr)_{k=1}^m$ gives
$$E(gg^{\mathsf T})=E(LL^{\mathsf T})+O_{m,q,B}(n^{-5/4}\ell^{3/4})
=\frac{E_P[w^2x(V)x(V)^{\mathsf T}]}{n\mu^2}
 +O_{m,q,B}(n^{-5/4}\ell^{3/4}),$$
entrywise, using Cauchy–Schwarz on the products containing $g+L$.

Conditional on calibration, test p-values are i.i.d., so $\mathrm{FDR}_n=E\psi_m(\mathbf t+g)$. Lim's weighted-exchangeability argument (Lemma 1) proves $Eg=0$ exactly, including ties. One can condition on the pooled multiset of the $n+1$ units for a single test: the test label belongs to each score group with probability equal to its fraction of pooled weight, and its p-value is uniform on that group's contiguous interval of the same length. Also $\psi_m(\mathbf t)=q$ by the Simes identity for i.i.d. uniforms. For example, for each designated test replace its p-value by zero. Conditional on the other tests, let $R_0\ge1$ be this modified BH count. The designated test contributes its original rejection indicator divided by the original count, with zero contribution if it is unselected. By the step-up rule it is selected exactly when its p-value is at most $qR_0/m$, and in that case the original count is $R_0$. The expected contribution under independent uniforms is $q/m$, giving $q$ after summing over tests. Taylor's theorem for the fixed polynomial now gives a bounded cubic remainder of mean $O_{m,q,B}(n^{-3/2})$. The linear term has mean zero. Using the second moment above and $E_P[w^2f]/\mu^2=E_Q[wf]/\mu$ gives (1).

## 3. Sharp continuous-score coefficient

For $s\in[0,1]$ set $z_k(s)=\mathbf1_{\{s\le t_k\}}-t_k$ and $D(s)=z(s)^{\mathsf T}Hz(s)$. When $F$ is continuous, $x(V)=z(F(V))$ almost surely. The function $D$ is constant on each Simes band. It satisfies $\int_0^1D(s)\,ds=0$, equals $-m(m-1)(1-q)$ on the first band, and equals zero above $q$ (Lim, Lemmas 48–50). For the integral identity, the second derivative at zero of $\psi_m$ along the law $(1-\theta)\mathrm{Unif}(0,1)+\theta\delta_s$ is $D(s)$. Expanding in the number of forced positions, it is $m(m-1)$ times the second difference of rejection probabilities with zero, one and two fixed positions at $s$. Upon averaging over $s$, the one-position term is $q$. The two-position term averaged over equal positions need not follow from independence; the following argument evaluates it. With $m-2$ independent uniforms and two identical copies of an independent uniform $S$, the probability of no Simes rejection is $1-q$. This follows directly from the leave-one-out rule applied to independent blocks: a block of one or two equal uniforms, replaced by zeros, has the same final rejection count when its uniform lies below the resulting BH threshold, and contributes its block size divided by that count. Conditional on the other blocks, its expected contribution is its block size times $q/m$. Summing over blocks gives $q$. For the first band, any configuration with a fixed copy rejects. Above $q$, the rejection probabilities for one and two fixed copies are $q(m-1)/m$ and $q(m-2)/m$, respectively, by Simes on the remaining uniforms.

Let $p_+=|\{s:D(s)>0\}|$, and let $A(p)$ be the integral of the $p$ largest values of $D$ on its positive bands, for $0\le p\le p_+$. Compute $A$ by concatenating those bands in decreasing order of $D$, allowing a final fractional band. Set $\gamma=1-1/B$. The sharp coefficient over continuous score laws is
$$
C_{m,q,B}=\frac{B-1}{2}\max_{0\le p\le p_+}(1-\gamma p)A(p). \tag{3}
$$
Indeed, since $E_Q(1/w)=1/\mu$, the coefficient is $\tfrac12 E_Q(1/w) E_Q[wD(T)]$. If the second factor is nonpositive, the coefficient is at most zero, attained by constant weight. If it is positive, replacing $w$ by $1$ on nonpositive bands increases both factors. On positive bands replace the weight with a mixture of $1$ and $B$ having the same conditional mean given $T$. This retains $E_Q[wD(T)]$ while increasing $E_Q(1/w)$ by the chord bound for the convex function $1/w$. The case $B=1$ follows directly. For the resulting endpoint weights, let $\pi(s)$ be the conditional probability of weight $B$ at rank $s$, and $p=\int\pi(s)\,ds$. Then
$$E_Q(1/w)=1-\gamma p,\qquad E_Q[wD(T)]=(B-1)\int_0^1 D(s)\pi(s)\,ds.$$
For each $p$ the latter integral is maximized by taking the $p$-measure set of largest positive curvatures. This follows by subtracting a cutoff value of $D$ in the integral of the difference between the two allocation policies, which have equal mass. The maximum in (3) occurs at a breakpoint or at a stationary point of one of the quadratic pieces.

To attain (3), take a uniform score under $Q$, choose weight $B$ on the maximizing set and weight $1$ elsewhere, and define $dP/dQ=\mu/w$ with $\mu=1/E_Q(1/w)$. The same coefficient can also be attained with finitely many scores: subdivide every Simes band into contiguous pieces of constant weight, then collapse each piece into one ordered atomic score with the same $Q$ mass. Its randomized rank stays in the original band, so $x$ is unchanged on that piece. Formula (1) makes (3) the limit of $n$ times the supremum of the excess over continuous score laws, even if the optimizing law can vary with $n$.

## 4. Sharp coefficient for two tests with arbitrary scores

Simes rejects with probability $\psi_2(g)=2g_1+g_2^2-2g_1g_2$, hence $H_{11}=0$, $H_{12}=-2$ and $H_{22}=2$. The point curvatures on the three bands are $-2(1-q),\,2(1-q),\,0$. An atom replaces the point direction by its mean over the atom's contiguous randomized-rank interval. If it only crosses $t_1$, Jensen's inequality is equality because the direction varies only in coordinate 1 and $H_{11}=0$. If it only crosses $t_2$, Jensen's inequality follows from $H_{22}=2$. If it crosses both, let $a,b,c$ be the interval's mass fractions in the first, second and third bands. The interval contains the entire second band and at most the entire first, both of length $q/2$, so $b\ge a$. The quadratic at the mean direction is
$$2(a+b-q)(b-a)\le2(1-q)(b-a),$$
which is its mean point curvature. An atom contained within a band gives equality. Therefore smoothing the score using the randomized rank and keeping its weight increases or preserves the coefficient. This defines a continuous-score model on the augmented unit space since the new random variable is drawn with the same independent law under $P$ and $Q$. The weight on each atom can vary between units, as the smoothing argument holds for every unit conditional on its score and weight.

In (3) we now have $A(p)=2(1-q)p$ on $[0,q/2]$. The objective is increasing there since $1-2\gamma p\ge1-\gamma q>0$. Uniformity of (1) proves
$$
\lim_{n\to\infty} n \sup_{\substack{\text{all score laws}\\1\le w\le B}}(\mathrm{FDR}_n-q)
=(B-1)(1-q)\frac q2\left[1-\left(1-\frac1B\right)\frac q2\right].
\tag{4}
$$
One maximizing model uses three ordered score values with respective $Q$ masses $q/2,q/2,1-q$ and weights $1,B,1$. For instance, $q=1/2$ and $B=2$ give coefficient $7/64$.

A further class where (3) is sharp even with atoms is $q\le1/e$ when no atom has $t_1$ strictly inside its rank interval. The first direction coordinate is then constant on each rank interval up to endpoints of zero length, and Lim's Theorem 58 gives positive semidefiniteness of the Hessian on the remaining coordinates. Jensen thus applies after holding the first coordinate fixed. When an atom can straddle $t_1$ and there are three or more tests, (1) still applies.

## 5. Relation to the source question

Lim's Conjecture 20 and Section 7 ask for the sharp all-null constant in the linear regime. His Theorem 54 uses a Poisson window model with $B=\kappa n$; Remark 55 gives its order of limits. Formula (1) fixes the cap and number of tests while permitting arbitrary atomic scores, and its uniform error allows the optimized finite-sample limits in (3) and (4). Pournaderi's Theorems 3.1 and 4.1 derive a first-order conditional coverage process for weighted split conformal prediction. Its covariance agrees with the continuous-score version of the influence covariance here. Other regimes in which the weight cap grows or the number of tests varies require a separate uniform analysis. For higher-dimensional atomic optimization, (3) is proved under the stated smoothing condition.

## References

- Ryan Lim. *Almost Controlled: The FDR of Benjamini–Hochberg on Weighted Conformal p-Values*. arXiv:2611.21509v1, 2026. Lemmas 1, 4 and 48–50, Theorems 54 and 58, Remark 55, Conjecture 20 and §7. <https://arxiv.org/abs/2611.21509v1>
- Mehrdad Pournaderi. *Weighted conformal prediction under covariate shift: process limits, estimated weights and efficiency*. arXiv:2611.20052v1, 2026. <https://arxiv.org/abs/2611.20052v1>
- R. John Simes. *An improved Bonferroni procedure for multiple tests of significance*. Biometrika, 73(3), 751–754, 1986. <https://doi.org/10.1093/biomet/73.3.751>
