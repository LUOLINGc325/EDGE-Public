---
title: "A square-root mixed-null inflation for weighted conformal BH"
lang: en
---

# A square-root mixed-null inflation for weighted conformal BH

## Abstract

The global-null false discovery rate of Benjamini–Hochberg applied to randomized weighted split-conformal p-values differs from the nominal level by at most a linear term in the test-to-calibration size ratio. We show that the corresponding mixed-null statement fails even with two tests and bounded weights. For one true null and one alternative, we compute the exact first-order correction under a continuous uniform null score. It is of order \(n^{-1/2}\) when the alternative has an atom at the second testing threshold and the two adjacent null score bands have unequal weighted variances. An explicit covariate-shift example has positive correction. For arbitrary score laws, including atoms, and arbitrary independent alternatives, we also give a finite-sample upper bound of relative order \(\sqrt{mB/(n\alpha)}+mB/(n\alpha)\), where \(\alpha\) is the testing level and \(B\) is the weight ratio bound. This matches the calibration-size exponent of the two-test example.

## 1. Model and main results

Let the calibration sample \(\mathcal C\) have \(n\ge1\) iid units from \(P\). There are \(m\ge1\) test units, independent of \(\mathcal C\) and of one another. Let \(m_0\) of them be true nulls, each with law \(Q=wP/\mu\), where \(\mu=\mathbb E_P w\) and the common scaling of the raw weights is chosen so that \(1\le w\le B\). A fixed measurable real score \(V\) is used for every unit. Test alternatives may have other laws and need only use weights in \([1,B]\). For each test unit an independent uniform \(U\) on \([0,1]\) is used. All auxiliary uniforms are independent of the data.

Write \(S=\sum_{i=1}^n w_i\), \(S_<(v)=\sum_i w_i\mathbf 1_{\{V_i<v\}}\), and \(S_=(v)=\sum_i w_i\mathbf 1_{\{V_i=v\}}\). The randomized weighted p-value of a test unit is
\[
p=\frac{S_<(V)+U[S_=(V)+w]}{S+w}. \tag{1}
\]
At testing level \(0<\alpha<1\), BH uses thresholds \(t_k=\alpha k/m\), \(1\le k\le m\). The FDR is the expectation of the number of false rejections divided by the maximum of one and the total number of rejections. Under the null, (1) is marginally uniform by the tilted augmented-sample argument of [1, Section 2]. Test p-values are independent conditional on \(\mathcal C\), but they need not be independent after averaging over the shared calibration.

**Theorem 1 (general mixed-null upper bound).** There is a universal constant \(C\) such that for the above model, with arbitrary score atoms,
\[
\operatorname{FDR}\le
\frac{\alpha m_0}{m}\left[1+C\left(\sqrt{\theta}+\theta\right)\right],
\qquad \theta=\frac{mB}{n\alpha}. \tag{2}
\]

**Theorem 2 (two-test first-order correction).** Let \(m=2\), with one null and one alternative. Suppose the score under \(Q\) is uniform on \([0,1]\), and the alternative has a fixed score law on \([0,1]\). Write \(\beta=\Pr_{\rm alt}(V=\alpha)\) and
\[
\Gamma(s,t)=\mu^{-2}\mathbb E_P\bigl[w^2(\mathbf 1_{\{V\le s\}}-s)(\mathbf 1_{\{V\le t\}}-t)\bigr].
\]
Then
\[
\sqrt n\left(\operatorname{FDR}-\frac{\alpha}{2}\right)
\longrightarrow
-\frac{\beta\,[\Gamma(\alpha/2,\alpha)-\frac12\Gamma(\alpha,\alpha)]}
{\sqrt{2\pi}\sqrt{\Gamma(\alpha,\alpha)}}. \tag{3}
\]
In particular, when the alternative has no atom at \(\alpha\), the excess is \(o(n^{-1/2})\). With an atom there, its limiting sign is the sign of
\[
\mathbb E_P[w^2\mathbf 1_{\{\alpha/2<V\le\alpha\}}]
-\mathbb E_P[w^2\mathbf 1_{\{V\le\alpha/2\}}].
\]

**Corollary 3 (strict inflation).** At \(\alpha=1/2\), take \(w=2\) in the null score band \((1/4,1/2]\) and \(w=1\) elsewhere. Set the null calibration score density to \((8/7)/w\), so the null test score is uniform. An alternative concentrated at score \(1/2\) gives
\[
\operatorname{FDR}
=\frac14+\frac{7}{16\sqrt{35\pi}}\frac1{\sqrt n}+o(n^{-1/2}).
\]
The example can use the same test feature marginal for the null and alternative, as described in Section 4. Therefore a universal mixed-null analogue of the global-null linear excess bound in [1] is impossible even at \(m=2\) and \(B=2\).

## 2. A conditional CDF bound for arbitrary score laws

Let \(F_{\mathcal C}(t)=\Pr(p\le t\mid\mathcal C)\) be the conditional CDF of a null p-value. For a designated null \(j\), replace its p-value by zero and let \(R_j^0\ge1\) be the resulting BH count. An elementary BH identity gives that \(j\) is rejected in the actual run exactly when its original p-value is at most \(t_{R_j^0}\), in which case the actual count is \(R_j^0\). To verify it, if \(p_j\le t_{R_j^0}\), feasibility at that count is preserved and no larger count can become feasible by increasing a p-value. If \(j\) is rejected at the actual count, changing \(p_j\) to zero does not change any feasibility test at least as large as that count. Conditional independence from the other p-values therefore implies
\[
\operatorname{FDR}
=\sum_{j\in H_0}\mathbb E\frac{F_{\mathcal C}(t_{R_j^0})}{R_j^0}
\le\frac{\alpha m_0}{m}\,\mathbb E\max_{1\le k\le m}\frac{F_{\mathcal C}(t_k)}{t_k}. \tag{4}
\]

For a score value \(v\), write \(G_<(v)=Q(V<v)\), \(G_=(v)=Q(V=v)\). Under a null draw, the randomized population rank \(s_*=G_<(V)+U G_=(V)\) is uniform on \([0,1]\). For a fixed \(s\in[0,1]\) define
\[
\ell_s(v)=\Pr_\xi\{G_<(v)+\xi G_=(v)\le s\},\qquad
H_{\mathcal C}(s)=\frac{\sum_i w_i\ell_s(V_i)}S ,
\]
where \(\xi\) is an independent uniform variable. The function \(H_{\mathcal C}\) is nondecreasing. Under the tilted law \(Q\), the same randomized population rank is uniform, hence \(\mathbb E_P[w\ell_s(V)]=\mu s\).

For the null unit and almost every calibration, one has \(H_{\mathcal C}(s_*)=(S_<(V)+U S_=(V))/S\) almost surely. A smaller calibration score contributes one, a larger score zero, and a tied score with positive mass contributes \(U\). To handle flat portions of the population CDF, give each calibration score its own independent jitter. Its population rank under \(P\) has a continuous distribution because \(P\) is equivalent to \(Q\), under which that rank is uniform. Equality with the independent test rank therefore has probability zero. Ties between independent draws at non-atomic scores also have probability zero. Averaging over calibration jitters gives the displayed equality, with the null-unit conditional assertion following by Fubini. Equation (1) now gives the almost-sure conditional bound
\[
|p-H_{\mathcal C}(s_*)|\le \kappa,\qquad \kappa=B/n . \tag{5}
\]
Indeed the test weight mixes the calibration term with \(U\) in proportion at most \(B/n\).

Fix \(t=t_k\) and \(x>0\). When \(s=t(1+x)\le1\), (5) and monotonicity imply
\[
\{F_{\mathcal C}(t)>s\}\subseteq\{H_{\mathcal C}(s)\le t+\kappa\}.
\]
The first event is empty if \(s>1\). For \(r=t+\kappa\le s\), set \(Y_i=w_i(\ell_s(V_i)-r)\). Its mean is \(\mu(s-r)\), and
\[
\mathbb E Y_i^2\le B\mu(s+r^2)\le2 B\mu s,
\qquad |Y_i-\mathbb E Y_i|\le2B.
\]
For the moment bound use \(\ell_s^2\le\ell_s\), then discard the negative cross term and use \(r^2\le s\). The event \(H_{\mathcal C}(s)\le r\) is \(\sum_i Y_i\le0\). Bernstein's exponential bound gives
\[
\Pr\{H_{\mathcal C}(s)\le r\}
\le \exp\!\left[-c\frac{n(s-r)^2}{Bs}\right]
\]
for a universal \(c>0\), using the displayed variance and range and \(\mu\ge1\).

Let \(X=(\max_k F_{\mathcal C}(t_k)/t_k-1)_+\). For \(x\ge2\theta\), \(s-r=t_k x-\kappa\ge t_k x/2\), and \(n t_k/B=k/\theta\). The preceding estimate and the geometric sum over possible \(k\) give
\[
\Pr(X>x)\le
\min\left\{1,\frac1{\exp(c' x^2/(\theta(1+x)))-1}\right\}. \tag{6}
\]
Here \(c'>0\) is universal. Choose \(x_0=C_0(\sqrt{\theta}+\theta)\) large enough that \(x_0\ge2\theta\) and the exponent in (6) is at least one for all \(x\ge x_0\). Below \(x_0\), integrate the bound one. Above \(x_0\), the right side is bounded by twice the exponential of the negative exponent. On \(x\le1\) it is bounded by a Gaussian in \(x/\sqrt\theta\). On \(x\ge1\) it is bounded by an exponential in \(x/\theta\). Integrating yields \(\mathbb E X\le C(\sqrt\theta+\theta)\). Equation (4) proves Theorem 1.

## 3. Two tests and the calibration fluctuation

In the continuous-score setting of Theorem 2, let \(H_n(s)=\sum_i w_i\mathbf 1_{\{V_i\le s\}}/S\) be the ordinary weighted empirical CDF. We have \(H_{\mathcal C}=H_n\) almost surely. Since \(Q\) is uniform and \(P\) is equivalent to \(Q\), there are no independent test-calibration ties, even for a fixed atom of the alternative. Thus (5) becomes \(|p-H_n(V)|\le\kappa\) for either test unit. Define \(Z_n(t)=\sqrt n(H_n(t)-t)\).

### 3.1. First-order inverse CDF

For any fixed \(0<t<1\),
\[
\sqrt n(F_{\mathcal C}(t)-t)=-Z_n(t)+o_{L^1}(1). \tag{7}
\]
First consider the local empirical slope. For fixed \(M_0\), uniformly over \(|x|\le M_0\),
\[
\sqrt n[H_n(t+x/\sqrt n)-H_n(t)]=x+o_{\Pr}(1). \tag{8}
\]
For a finite grid of \(x\)'s on this interval, take the weighted numerator before dividing by \(S/n\). Its mean increment is \(\mu x/\sqrt n\). The variance of its centered increment after multiplication by \(\sqrt n\) is at most \(B\mu|x|/\sqrt n\), using the uniform law under \(Q\) and bounded weights. Chebyshev's inequality gives simultaneous convergence on each fixed grid, and \(S/n\to\mu\). Between adjacent grid points use monotonicity and then let the grid mesh decrease. This proves (8) for either sign of \(x\).

The variables \(Z_n(t)\) are tight, since the centered weighted numerator has bounded variance at scale \(\sqrt n\) and \(S/n\ge1\). Evaluate (8) at \(x=-Z_n(t)\pm\eta\) for a fixed \(\eta>0\), restricting first to a fixed interval of \(x\)'s by tightness. With probability tending to one as the interval grows, the corresponding \(H_n\) values are on opposite sides of \(t\), each separated from \(t\) by more than \(\kappa\). The conditional null score is uniform. The lower evaluation and (5) give a lower bound on \(F_{\mathcal C}(t)\) by that score, while the upper evaluation gives an upper bound. This proves (7) in probability.

For the \(L^1\) conclusion, set \(s=t\pm x/\sqrt n\). If \(F_{\mathcal C}(t)>t+x/\sqrt n\) and \(s\le1\), then \(H_n(s)\le t+\kappa\). If \(F_{\mathcal C}(t)<t-x/\sqrt n\) and \(s\ge0\), then \(H_n(s)>t-\kappa\) by the other direction of (5); otherwise all scores at most \(s\) give \(p\le t\). Out-of-range deviations are empty. In either case, for \(x\ge2B/\sqrt n\) the weighted empirical deviation from \(s\) has magnitude at least \(x/(2\sqrt n)\). The centered numerator \(\sum_i w_i(\mathbf 1_{\{V_i\le s\}}-s)\) has independent bounded summands, and \(S\ge n\). Hoeffding's inequality gives a bound \(2\exp(-c x^2/B^2)\) on the two tails of \(\sqrt n(F_{\mathcal C}(t)-t)\). Thus this expression and \(Z_n(t)\) have bounded second moments uniformly in \(n\). Uniform integrability turns convergence in probability of their sum into (7).

### 3.2. The alternative at the boundary

Write \(g_n=\Pr(p_{\rm alt}\le\alpha\mid\mathcal C)\). We claim
\[
g_n=\Pr_{\rm alt}(V<\alpha)+\beta\mathbf 1_{\{Z_n(\alpha)\le0\}}+o_{L^2}(1). \tag{9}
\]
The weighted empirical CDF tends uniformly to the identity in probability, by the law of large numbers on a fixed fine grid and monotonicity. Scores of the alternative bounded away from \(\alpha\) therefore make the deterministic decision indicated in (9), with probability tending to one. The mass of scores within a shrinking neighborhood but distinct from \(\alpha\) tends to zero because the alternative score law is fixed. At \(V=\alpha\), the test decision agrees with \(\mathbf 1_{\{Z_n(\alpha)\le0\}}\) whenever \(|Z_n(\alpha)|>\sqrt n\,\kappa\). Indeed, the perturbation from \(H_n(\alpha)\) in (5) is at most \(\kappa\). The central limit theorem gives a nondegenerate continuous normal limit for \(Z_n(\alpha)\), since \(0<\alpha<1\), \(Q\) is uniform, and the weights are positive. Hence the shrinking error slab has probability tending to zero. This proves (9) in probability and then in \(L^2\) by boundedness.

### 3.3. BH and the Gaussian coefficient

For two tests the null is rejected alone when its p-value is at most \(\alpha/2\) and the alternative p-value exceeds \(\alpha\). If both p-values are at most \(\alpha\), both are rejected and the null contributes \(1/2\). These are exactly the cases in which the null contributes. Conditional independence and marginal null uniformity yield
\[
\operatorname{FDR}=\frac{\alpha}{2}
+\mathbb E\!\left[g_n\left\{\tfrac12 F_{\mathcal C}(\alpha)-F_{\mathcal C}(\alpha/2)\right\}\right]. \tag{10}
\]
The two quantities \(Z_n(\alpha/2),Z_n(\alpha)\) converge jointly to centered normal variables \(Z(\alpha/2),Z(\alpha)\) with covariance \(\Gamma\). This follows from the multivariate central limit theorem for the centered weighted numerators and \(S/n\to\mu\). By (7) the scaled term in braces is \(Z_n(\alpha/2)-\tfrac12 Z_n(\alpha)+o_{L^1}(1)\). Equations (7)–(9) and the bounded second moments allow passage to expectations in (10), including the indicator in (9). Its discontinuity has zero probability under the limiting normal law of \(Z(\alpha)\). The constant part of \(g_n\) contributes zero in the limit since the normal variables are centered.

If \(Y\) is a centered normal variable and \(X\) is jointly centered normal with it, with \(\operatorname{Var}(Y)>0\), then
\(\mathbb E[X\mathbf 1_{\{Y\le0\}}]=-\operatorname{Cov}(X,Y)/\sqrt{2\pi\operatorname{Var}(Y)}\).
This follows by taking the linear conditional expectation of \(X\) given \(Y\) and integrating the lower half of the normal density. Apply it to \(X=Z(\alpha/2)-\tfrac12 Z(\alpha)\), \(Y=Z(\alpha)\). This gives (3). Finally,
\[
\Gamma(\alpha/2,\alpha)-\tfrac12\Gamma(\alpha,\alpha)
=\frac{1-\alpha}{2\mu^2}
\left\{\mathbb E_P[w^2\mathbf 1_{\{V\le\alpha/2\}}]
-\mathbb E_P[w^2\mathbf 1_{\{\alpha/2<V\le\alpha\}}]\right\}.
\]
Indeed the first centered factor in this difference is \(1_{\{V\le\alpha/2\}}-\frac12 1_{\{V\le\alpha\}}\), zero outside the two displayed bands. This completes Theorem 2.

## 4. An explicit covariate-shift example

With \(\alpha=1/2\), define a binary feature \(X=1_{\{1/4<V\le1/2\}}\) under the calibration and null laws, and let \(w=1+X\). Under \(P\), choose score density \((8/7)/(1+X)\). Its integral is one, its mean weight is \(\mu=8/7\), and under \(Q\) the score is uniform. Under the alternative draw \(X\) from the same marginal \(Q_X\) as the null and set \(V=1/2\) deterministically. This changes the conditional score law and keeps the test feature marginal and the weighting function fixed. We have \(\beta=1\).

The two lower-band weight-square expectations are \(\mu/4\) and \(\mu/2\), giving \(\Gamma(1/4,1/2)-\tfrac12\Gamma(1/2,1/2)=-7/128\). At \(t=1/2\) the squared centered indicator is \(1/4\) everywhere. The integral of the raw weight against the uniform score measure is \(5/4\), so \(\Gamma(1/2,1/2)=35/128\). Substitution into (3) gives Corollary 3.

## 5. Scope and relation to the global-null rate

The pinned global-null analysis [1] uses randomized p-value marginal uniformity and controls each BH threshold window using other null test units. Arbitrary alternatives can put a fixed population score exactly at a BH threshold. Then the calibration fluctuation determines whether an alternative enters the count, and the resulting correlation with the conditional null CDF contributes at first order. Theorem 2 computes this term and shows why its sign depends on the adjacent score bands. Theorem 1 gives a general bound with the matching \(n^{-1/2}\) exponent for fixed \(m=2\). We do not claim a matching lower bound for the dependence on \(m\) or \(B\) as they grow, or a second-order rate when the first-order coefficient is zero.

## Reference

1. *A linear finite-sample bound for the global-null FDR of weighted conformal BH*, earlier research manuscript at  (archived version), especially Sections 1–2.
