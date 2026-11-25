---
title: "Two scales of private e-power when epsilon tends to zero"
lang: en
---

# Two scales of private e-power when epsilon tends to zero

## Abstract

For two fully supported distributions on a fixed finite alphabet, we study optimal expected log e-value under central approximate differential privacy when the per-record privacy parameter \(\varepsilon_n\) vanishes but \(n\varepsilon_n\) diverges. The limiting e-power per observation is the minimum null relative entropy in a total-variation ball around the alternative. Its radius is set by \(\log(\varepsilon_n/\delta_n)\) on the \(n\varepsilon_n\) scale. Beyond saturation the per-observation limit vanishes, but an output that is rare under the alternative can dominate the usual pure-private scale. We determine the exact logarithmic rate in this region and construct two privacy budgets with the same limiting exponents but with different normalized e-power at the critical boundary. The constructions use scalar sensitivity-one releases and binary postprocessing.

## 1. Model and main results

Let \(P,Q\) be distinct, strictly positive distributions on a fixed finite alphabet \(\mathcal X\). Observations are iid under either distribution. Write
\[
t_0=\operatorname{TV}(P,Q),\qquad
D(R\Vert P)=\sum_{x\in\mathcal X}R(x)\log\frac{R(x)}{P(x)} .
\]
We use natural logarithms, \(0\log 0=0\), and \(x_+=\max(x,0)\). A mechanism \(K\) on \(\mathcal X^n\) is \((\varepsilon_n,\delta_n)\)-differentially private if \(K(x,S)\le e^{\varepsilon_n}K(y,S)+\delta_n\) for every measurable output event \(S\) and ordered replacement-adjacent databases \(x,y\). The condition applies on the full input domain.

Let \(V_n\) be the supremum of \(\mathbb E_{Q^n}\log E\) among nonnegative private e-values \(E\) with \(\mathbb E_{P^n} E\le1\). The expectation includes mechanism randomness. Throughout,
\[
\varepsilon_n>0,\quad \varepsilon_n\to0,\quad a_n=n\varepsilon_n\to\infty,\quad 0\le\delta_n<1/2 .
\]
Put
\[
u_n=\frac{[\log(\varepsilon_n/\delta_n)]_+}{a_n},\qquad
\lambda_n=\frac{\log(1/\varepsilon_n)}{a_n}.
\]

We set \(u_n=\infty\) when \(\delta_n=0\), with zero accumulated privacy slack. A finite limit of \(u_n\) implies that \(\delta_n>0\) eventually.

**Theorem 1 (per-observation limit).** If \(u_n\to u\in[0,\infty]\), then
\[
\frac{V_n}{n}\longrightarrow J(u)
=\min_{\operatorname{TV}(R,Q)\le u}D(R\Vert P). \tag{1}
\]
At \(u=\infty\) the minimization is unrestricted. Thus the limit is positive when \(u<t_0\) and zero when \(u\ge t_0\).

**Theorem 2 (rates beyond saturation).** Suppose \(u_n\to u\in(t_0,\infty)\) and \(\lambda_n\to\lambda\in[0,\infty]\). Then
\[
-\frac1{a_n}\log(V_n/n)\longrightarrow \min\{\lambda,u-t_0\}. \tag{2}
\]
If \(u-t_0>\lambda\), then \(V_n/(n\varepsilon_n)\to t_0\). If \(u-t_0<\lambda\), then
\[
\frac1{a_n}\log\frac{V_n}{n\varepsilon_n}\longrightarrow\lambda-(u-t_0),
\]
including a limit of infinity when \(\lambda=\infty\).

**Theorem 3 (critical dependence on the budget).** For every \(\kappa>0\), take \(\varepsilon_n=\kappa\log n/n\) and, for sufficiently large \(n\),
\[
\delta_n^\pm=\varepsilon_n^2\exp(-a_n t_0\pm\sqrt{a_n}).
\]
Both sequences have \(u=t_0+1/\kappa\) and \(\lambda=1/\kappa\). For the minus sequence \(V_n/(n\varepsilon_n)\to t_0\), whereas for the plus sequence it tends to infinity. The limits in Theorems 1–2 still hold for both.

The pinned fixed-\(\varepsilon\) result [1] gives the variational expression with a total-variation radius and a linear transport penalty when the privacy parameter is held fixed. Its proof already contains the exact finite group-privacy multiplier. When \(\varepsilon_n\) tends to zero, the denominator of that multiplier contributes to the leading radius. It also permits a smaller multiplier at the level of probabilities to affect the leading expected log evidence beyond saturation.

## 2. A uniform converse for all mechanisms

Let \(A=Q^n K\), \(B=P^n K\) for a fixed private kernel. The output laws are equivalent by strict input positivity, and their log likelihood ratio lies between \(n\min_x\log(Q(x)/P(x))\) and \(nL_+\), where \(L_+=\max_x\log(Q(x)/P(x))\). Optimizing the output e-value under its null budget gives exactly \(D(A\Vert B)\), by Jensen's inequality or the relative-entropy variational formula. The likelihood ratio itself is admissible and is a postprocessing of the kernel. Conversely an e-value is a kernel, so
\[
V_n=\sup_{K\ \mathrm{private}}D(Q^nK\Vert P^nK)\le nD(Q\Vert P). \tag{3}
\]

We use the comparison argument in [1, Section 3]. If \(A(S)\le e^b B(S)+\tau\) for all events, with \(b\ge0\), then
\[
D(A\Vert B)\le b+[1+(nL_+-b)_+]\tau . \tag{4}
\]
Indeed, with \(f=dA/dB\), the domination gives \(\int(f-e^b)_+\,dB\le\tau\). On \(f>e^b\), split \(f\log(f/e^b)=(f-e^b)\log(f/e^b)+e^b\log(f/e^b)\). The log-likelihood cap bounds the first term and \(\log z\le z-1\) bounds the second, giving \(f\log(f/e^b)\le(f-e^b)[1+(nL_+-b)_+]\). Elsewhere its integrand is nonpositive. This proves (4).

Fix an intermediate distribution \(R\), and set \(t=\operatorname{TV}(R,Q)\). An independent product of maximal one-coordinate couplings of \(Q,R\) has Hamming distance distributed as \(\operatorname{Bin}(n,t)\). For an integer \(k\le n\), group privacy across at most \(k\) replacements gives the multipliers \(e^{\varepsilon_n k}\) and
\(\delta_n G_{\varepsilon_n}(k)\), where
\[
G_\varepsilon(k)=\sum_{j=0}^{k-1}e^{j\varepsilon}
\le e^{\varepsilon k}/\varepsilon .
\]
Restrict the coupled comparison to Hamming distance at most \(k\) and to the event where \(\log(dR^n/dP^n)\le n[D(R\Vert P)+\eta]\). The excluded mass is at most the sum of the binomial tail and the probability of failure of this likelihood bound under \(R^n\). On the retained event the group multiplier followed by the likelihood bound gives
\[
A(S)\le e^{n[D(R\Vert P)+\eta]+\varepsilon_n k}B(S)
+\Pr\{\operatorname{Bin}(n,t)>k\}+\beta_{n,R}(\eta)+\delta_n G_{\varepsilon_n}(k), \tag{5}
\]
where \(\beta_{n,R}(\eta)\to0\) for any fixed \(\eta>0\) by the law of large numbers. For \(R=P\) one can take \(\eta=0\) and \(\beta_{n,P}(0)=0\). These bounds hold uniformly over mechanisms.

When \(u>0\), eventually \(\log(\varepsilon_n/\delta_n)>0\). For \(t<s<\min\{1,u\}\) and \(k=\lceil ns\rceil\), the binomial tail tends to zero. Also
\[
\delta_n G_{\varepsilon_n}(k)
\le(\delta_n/\varepsilon_n)e^{\varepsilon_n k}\longrightarrow0 .
\]
Here the logarithm divided by \(a_n\) is at most \(-u_n+s+O(1/n)\). Combined with (4)–(5), this gives \(\limsup V_n/n\le D(R\Vert P)+\eta\) for every \(R\) with \(t<u\). We can choose \(s\) as stated because \(Q\) is positive and \(t<1\). Let \(\eta\downarrow0\). To reach a point with \(t=u>0\), mix \(R\) slightly with \(Q\); continuity of entropy and the strict distance contraction allow the closed ball. When \(u=0\), (3) gives \(J(0)=D(Q\Vert P)\) directly. The same strict-ball argument for \(u=\infty\) permits \(R=P\). This proves the converse of Theorem 1.

## 3. The attainable total-variation radius

For finite \(u\) choose a deterministic histogram \(h_n^Q\) with total count \(n\) and \(h_n^Q/n\to Q\), by rounding coordinates. Given the data histogram \(h(X)\), let \(D_n(X)=\|h(X)-h_n^Q\|_1/2\). This is integer-valued and has replacement sensitivity one. Release \(W=D_n(X)+Z_n\), where \(Z_n\) is independent with probabilities proportional to \(e^{-\varepsilon_n|j|}\) on the integers \(-r_n,\ldots,r_n\), and
\[
r_n=\left\lceil \frac{1+[\log(\varepsilon_n/\delta_n)]_+}{\varepsilon_n}\right\rceil .
\]
Then \(r_n/n\to u\).

For a one-unit shift of the query, the overlapping output point masses have ratio at most \(e^{\varepsilon_n}\). Only one endpoint can be unmatched in either direction. The normalizing sum is at least \((1-e^{-1})/\varepsilon_n\) by summing its nonnegative geometric terms and using \(r_n\varepsilon_n\ge1\). The unmatched endpoint probability is at most
\(\varepsilon_n e^{-\varepsilon_n r_n}/(1-e^{-1})\le\delta_n\).
Summing over events proves approximate privacy on the entire input domain. The same normalizing estimate and the first moment of the untruncated two-sided geometric series give \(\mathbb E|Z_n|=O(1/\varepsilon_n)\). Thus \(Z_n/n\to0\) in probability because \(a_n\to\infty\).

Fix \(\eta>0\) and keep only the output event \(W\le n\eta\). Its probability \(A_1\) under \(Q^n\) tends to one by the law of large numbers and the noise moment bound. Under \(P^n\), this event requires \(D_n(X)\le r_n+n\eta\). Consequently its probability \(B_1\) is bounded above by the probability of types within total variation \(u+\eta+o(1)\) of \(Q\). The fixed finite alphabet has only polynomially many types and each type \(R\) has \(P^n\)-probability at most \(e^{-nD(R\Vert P)}\). This follows by comparing its probability with the same histogram probability under \(R^n\), which is at most one. Compactness and continuity then give \(\liminf -n^{-1}\log B_1\ge J(u+\eta)\).

Binary relative entropy is at least \(A_1\log(1/B_1)-\log 2\). Thus \(\liminf V_n/n\ge J(u+\eta)\). Letting \(\eta\downarrow0\) is legitimate by compactness of the simplex and continuity of the objective on decreasing closed balls. At \(u=\infty\), the lower bound of zero already follows from a constant e-value. This proves (1), including \(u=0\). Using a scalar distance release avoids any dimensional dependence of the endpoint noise calibration.

## 4. Refined rates above saturation

### 4.1. The pure-private scale

Let \(\mathcal A=\{x:Q(x)>P(x)\}\), \(p=P(\mathcal A)\), \(q=Q(\mathcal A)\). Full support and \(P\ne Q\) imply \(0<p<q<1\) and \(q-p=t_0\). The count \(C_n(X)\) of records in \(\mathcal A\) has sensitivity one. Adding continuous Laplace noise of scale \(1/\varepsilon_n\) is pure private, by the pointwise shifted density ratio. For fixed \(0<\eta<t_0/2\), take the binary event that the noisy count is at least \(n(q-\eta)\). Its \(Q^n\)-probability tends to one. Under \(P^n\), either the empirical count exceeds \(n(p+\eta)\), of probability \(e^{-\Omega(n)}\), or the Laplace noise is at least \(n(t_0-2\eta)\). Thus its null probability is at most
\(e^{-\Omega(n)}+\tfrac12 e^{-a_n(t_0-2\eta)}\).
Here \(a_n=o(n)\). By binary relative entropy followed by \(\eta\downarrow0\), this proves
\[
\liminf_n \frac{V_n}{n\varepsilon_n}\ge t_0 . \tag{6}
\]

### 4.2. A rare output with large evidence

Fix \(0<\eta<t_0/2\), and define the integer query
\(d(X)=(C_n(X)-\lfloor n(p+\eta)\rfloor)_+\).
Release a Bernoulli output with success probability
\[
p_d=\min\left\{\tfrac12,\ \frac{\delta_n}{e^{\varepsilon_n}-1}(e^{\varepsilon_n d}-1)\right\} . \tag{7}
\]
An adjacent input changes \(d\) by at most one. For successive \(d,d+1\), \(p_{d+1}\le e^{\varepsilon_n}p_d+\delta_n\) follows from the geometric sum formula and the cap. Also \(p_d\le p_{d+1}\le1/2\). For the nontrivial complement inequality, use
\[
p_{d+1}-p_d\le(e^{\varepsilon_n}-1)p_d+\delta_n
\le(e^{\varepsilon_n}-1)(1-p_{d+1})+\delta_n .
\]
The remaining ordered inequalities follow from monotonicity. This proves full-domain privacy for the two outputs.

Under \(Q^n\) the count is at least \(n(q-\eta)\) with probability tending to one, so \(d\ge n(t_0-2\eta)\) on that event. Since \(u>t_0\), \(u_n\to u\), and \((e^{\varepsilon_n}-1)/\varepsilon_n\to1\), the success probability \(A_1\) under \(Q^n\) satisfies
\[
\liminf_n a_n^{-1}\log A_1\ge -(u-t_0+2\eta).
\]
The geometric term at this lower bound on \(d\) is exponentially below \(1/2\) on the \(a_n\) scale, so it gives the asserted lower bound even when the cap is reached at other inputs. Under \(P^n\), success requires \(C_n>n(p+\eta)\). Thus \(B_1\le e^{-2n\eta^2}\).

A binary divergence also satisfies
\[
D(\operatorname{Bern}(A_1)\Vert\operatorname{Bern}(B_1))
\ge A_1\{\log(1/B_1)+\log A_1-1\} .
\]
This follows by using \((1-A_1)\log(1-A_1)\ge-A_1\) and dropping the nonnegative complement term involving \(B_1\). With \(a_n=o(n)\), the braces are at least \(n\eta^2\) for all large \(n\). Therefore
\[
\limsup_n -a_n^{-1}\log(V_n/n)\le u-t_0+2\eta .
\]
Letting \(\eta\downarrow0\) and using (6) proves the upper bound on the rate in (2).

### 4.3. Matching rate and first-order regimes

For the converse, use (5) with \(R=P\), \(\eta=0\) in that comparison, and \(k=\lceil ns\rceil\) for a fixed \(t_0<s<\min\{u,1\}\). Inequality (4) gives
\[
V_n/n\le \varepsilon_n(s+O(1/n))+C\left[e^{-c_s n}+(\delta_n/\varepsilon_n)e^{\varepsilon_n k}\right] \tag{8}
\]
with \(c_s>0\) and \(C\) independent of the mechanism. The last term has exponential rate \(u-s\) on the \(a_n\) scale, while \(e^{-c_s n}\) has infinite rate on that scale. The first term has rate \(\lambda\). Taking \(s\downarrow t_0\) gives the matching lower bound on the rate in (2). If \(u-t_0>\lambda\), choose \(s\) arbitrarily close to \(t_0\) with \(u-s>\lambda\). Then both error terms in (8) are \(o(\varepsilon_n)\), and (6) proves \(V_n/(n\varepsilon_n)\to t_0\). If \(u-t_0<\lambda\), subtract the logarithmic rate of \(\varepsilon_n\) in (2) to obtain the claimed divergence. This proves Theorem 2. The same argument gives the pure-private first order whenever \(\liminf_n a_n^{-1}\log(\varepsilon_n^2/\delta_n)>t_0\), with an infinite logarithm when \(\delta_n=0\). It includes \(u=\infty\) and finite \(\lambda\).

## 5. The critical boundary

Take the sequences in Theorem 3 and note \(a_n=\kappa\log n\). They have the same limiting \(u_n\) and \(\lambda_n\) because \(\log(\varepsilon_n/\delta_n^\pm)=\log(1/\varepsilon_n)+a_n t_0\mp\sqrt{a_n}\). They satisfy the strict positivity and upper restrictions on \(\delta_n\) for all large \(n\).

For the minus budget use \(R=P\) and distance cutoff \(k=\lceil n(t_0+1/a_n)\rceil\) in (4)–(5). The binomial error is bounded by \(e^{-2n/a_n^2}\), and the group-privacy error is at most \(\varepsilon_n\exp(-\sqrt{a_n}+1+o(1))\). Both are \(o(\varepsilon_n)\). The exponent term in (5) divided by \(n\varepsilon_n\) tends to \(t_0\). Together with (6), this gives the pure-private asymptotic.

For the plus budget use (7) with \(\eta_n=1/a_n\). The alternative count is at least \(n(q-\eta_n)\) with probability tending to one, since \(n\eta_n^2\to\infty\). The corresponding geometric lower bound gives \(A_1\ge c\,\varepsilon_n e^{\sqrt{a_n}}\) for some \(c>0\) and all large \(n\). The right-hand side tends to zero, so the cap does not obstruct the lower bound. The null probability is at most \(e^{-2n/a_n^2}\). As \(\log A_1\ge -O(\log n)\), the binary entropy inequality from Section 4.2 gives \(V_n\ge c' n A_1/a_n^2\) for some \(c'>0\). Therefore
\[
\frac{V_n}{n\varepsilon_n}\ge c''\,\frac{e^{\sqrt{a_n}}}{a_n^2}\longrightarrow\infty .
\]
This proves Theorem 3 and shows that the two logarithmic limits alone do not determine the first-order normalization at equality.

## 6. Source comparison and model boundaries

The output-KL reduction, group-privacy comparison, and fixed-parameter variational problem are developed in [1]. The new regime keeps the exact dependence of group privacy on the vanishing \(\varepsilon_n\), calibrates a scalar distance release at the resulting radius, and identifies an additional rate from rare binary outputs. The fixed alphabet, strict positivity of \(P,Q\), replacement adjacency, and iid sampling are used throughout. The results concern fixed-sample expected log evidence. They leave open uniform limits for changing distribution pairs and other normalizations exactly at the saturation radius \(u=t_0\).

## Reference

1. *The Privacy-Failure Exponent in Optimal Differentially Private E-Power*, earlier research manuscript at  (archived version), Theorem 2.1 and Sections 3–5.
