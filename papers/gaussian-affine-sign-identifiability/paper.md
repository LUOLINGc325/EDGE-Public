# Gaussian scale calibration with finite affine-sign and offset budgets

## Abstract

A homogeneous sign identifies a half-space containing a Gaussian observation and is invariant to simultaneous rescaling of the observation and its mean. Affine signs can identify absolute covariance scale, even when their total offset is small. We determine the minimax squared covariance error when each observation may give at most \(K\) simultaneous signs with total absolute offset at most \(B\le1\). For \(K\ge2\), the error is of order \(d\min\{1,(nB)^{-2}+(nB\sqrt{\min(d,K)})^{-1}\}\). For \(K=1\), it is of order \(d\min\{1,(nB^2)^{-1}\}\). These rates hold with an unknown location whose standardized coordinates are bounded. The centered Fisher information is of order \(B\sqrt{\min(d,K)}\) for \(K\ge2\) and \(B^2\) for \(K=1\). The isotropic upper bounds use a fixed schedule of arrays. The main array uses an affine comparison and a count of homogeneous comparisons involving the same coordinate. An order-statistic calibration keeps the error from estimating the other coordinate means within the minimax rate. For arbitrary centered Gaussian covariance with spectrum in a fixed positive interval, the \(K\ge2\) risk is the sum of the sharp scalar calibration rate and the shape cost \(d^4/(n\min\{K,d\}^2)\), capped at order \(d\). The \(K=1\) full-covariance rate is of order \(\min\{d,d^4/(nB^2)\}\). For two or more comparisons, homogeneous signs first estimate shape and the offset comparisons then estimate scale with a bound robust to shape error. The one-comparison design uses nonzero offsets to estimate covariance directly. If the location is unrestricted in the isotropic model, every finite protocol has minimax error of order \(d\), even with arbitrarily many finite comparisons per sample.

## Reading guide

A homogeneous comparison only reports which side of a hyperplane through the origin contains the sample. Such comparisons can reveal covariance shape because the scale cancels. An affine comparison moves the hyperplane and can also reveal scale. The two budgets limit the total offset and the number of comparisons on each sample.

Sections 1–8 treat scale when the covariance is isotropic, including the effect of an unknown mean. Sections 9 and 10 treat centered Gaussian vectors with a general covariance in a prescribed spectral range. They show how the cost of learning shape and the cost of calibrating scale combine, including the separate regime with one comparison per sample.

## 1. Experiment and result

Let \(X_i\sim N_d(0,\sigma^2 I_d)\), \(i=1,\dots,n\), be independent, where \(\sigma\in[5/4,7/4]\). For a finite simultaneous arrangement of unit normals \(u_j\) and offsets \(\beta_j\), the output on one sample is the labelled vector
\[
Y_j=\mathbf1\{u_j^\top X\le\beta_j\},\qquad \sum_j|\beta_j|\le B.
\]
There may be arbitrarily many, but finitely many, zero-offset comparisons. Later arrangements can be chosen from the past transcript and independent randomness, before seeing the next sample. The offset restriction holds on every realization and each sample. The estimator can use the full transcript. Write \(\mathcal R_{n,d}^{\mathrm{iso}}(B)\) for the infimum of the worst squared Frobenius covariance loss over all such protocols and estimators. Set \(\eta=\log\sigma\). Use \(H^2(P,Q)=\int(\sqrt{dP}-\sqrt{dQ})^2\).

**Theorem 1.** For every \(d,n\ge1\) and \(0 < B\le1\), with numerical comparison constants,
\[
\sup_{\text{one-sample arrangements}}\mathcal I_\eta(Y)\asymp \sqrt d\,B
\quad\text{uniformly over }\sigma\in[5/4,7/4],
\tag{1}
\]
and
\[
\mathcal R_{n,d}^{\mathrm{iso}}(B)
\asymp d\min\left\{1,\frac{1}{(nB)^2}+\frac{1}{nB\sqrt d}\right\}.
\tag{2}
\]
A fixed arrangement with one nonzero-offset comparison per sample and finitely many homogeneous signs attains the information lower bound uniformly in scale and yields the risk upper bound. At \(B=0\) the law of all observations is independent of \(\sigma\), so the risk is of order \(d\) and the Fisher information is zero. The lower bound of (2) also applies to any larger Gaussian parameter class containing the stated isotropic submodel.

## 2. Directional conditioning and the general information upper bound

Write \(X=\sigma R U\), with \(U\) uniform on the unit sphere, \(R\sim\chi_d\), and \(R\) independent of \(U\). Revealing \(U\) can only increase information. Given \(U\), each nonconstant sign is a radial threshold at \(|\beta_j|/(\sigma|u_j^\top U|)\) in the standardized \(R\) coordinate. A bit that is deterministic given \(U\) can be omitted. In the physical radial coordinate, the thresholds are fixed while differentiating the log scale. The full physical radial score at the true scale is \(R^2-d\), which increases with the radius.

We use a partition lemma. Let \(S(Z)\) be a square-integrable, increasing, mean-zero score for an ordered real variable \(Z\). For a partition at \(a_1 < \cdots < a_J\), set \(M=E[S\mid\text{interval}]\). The jumps of \(M\) across cuts are nonnegative, denoted \(\delta_j\). Thus
\[
M=\sum_j\delta_j\bigl(\mathbf1\{Z>a_j\}-P(Z>a_j)\bigr).
\]
The covariances between upper-threshold indicators are nonnegative, hence
\(\mathrm{Cov}(M,I_j)\ge\delta_j\mathrm{Var}(I_j)\) for \(I_j=\mathbf1\{Z>a_j\}\).
Consequently
\[
E M^2
=\sum_j\delta_j\mathrm{Cov}(M,I_j)
\le\sum_j\frac{\mathrm{Cov}(S,I_j)^2}{\mathrm{Var}(I_j)} .
\tag{3}
\]
This is the sum of the binary threshold informations. Cuts with zero indicator variance can be removed. The conditional score identity follows by differentiating a fixed cell probability and dividing by its mass. Standard dominated differentiation for a Gaussian scale family applies on any compact positive interval.

Let \(f_d,F_d\) be the density and distribution function of \(\chi_d\). The binary log-scale information at standardized cut \(a>0\) is
\[
I_d(a)=\frac{a^2 f_d(a)^2}{F_d(a)(1-F_d(a))}.
\tag{4}
\]
We show
\[
\int_0^\infty \frac{f_d(a)^2}{F_d(a)(1-F_d(a))}\,da\le C\quad(d\ge3).
\tag{5}
\]
Put \(m=\sqrt{d-1}\), the mode. For \(a\ge m\), on a right interval of length \(1/(1+a-m)\), the log derivative \((m^2/r)-r\) is at least \(-2(r-m)\), which bounds the integrated log decrease by a numerical constant. The same right interval argument of length one for \(a < m\) uses the derivative bound \(-2\) up to \(m+1\). Thus \(f_d(a)/(1-F_d(a))\le C(1+(a-m)_+)\). For \(a\ge m/2\), a left interval of length \(c/(1+(m-a)_+)\) stays above \(m/4\), and on it the positive part of the log derivative is at most \(5(m-r)_+\). This gives \(f_d(a)/F_d(a)\le C(1+(m-a)_+)\). When \(a < m/2\), on \([a(1-1/d),a]\) the density is at least \(e^{-1}f_d(a)\), so \(f_d(a)/F_d(a)\le Cd/a\). Here
\[
E(R-m)^2\le (2d+1)/(d-1),\quad E(R^{-2})=1/(d-2),\quad P(R\le m/2)\le e^{-c_0 d}.
\]
The first inequality uses \(|R-m|=|R^2-m^2|/(R+m)\); the others follow by the Gamma integral and the negative exponential Markov bound for \(R^2\). Cauchy–Schwarz bounds the integral on the small-radius part uniformly. Using \(1/[F(1-F)]=1/F+1/(1-F)\) proves (5).

For \(d\ge3\), the density of \(z=u_j^\top U\) has supremum at most \(C\sqrt d\), by its formula proportional to \((1-z^2)^{(d-3)/2}\) and normalization. The expected (4) with \(a=|\beta_j|/(\sigma |z|)\) over the half-sphere of nonconstant bits is therefore at most \(C\sqrt d|\beta_j|\) by the substitution \(z=|\beta_j|/(\sigma a)\) and (5). In dimension two the spherical density is bounded for \(|z|\le1/2\) and the integral in (5) is finite by the explicit Rayleigh density. For \(|z|>1/2\), the Rayleigh formula gives \(I_2(a)=a^4/(\exp(a^2/2)-1)\le2a^2\), so the contribution is \(O(\beta_j^2)\). In dimension one the sign of \(U\) is a fair bit and \(I_1(a)\le Ca\) for \(0 < a\le 4/5\) by the half-normal density. Applying (3) proves the upper bound in (1).

## 3. A one-cut experiment and its testing distance

Let \(P_\eta\) denote the law of \((U,\mathbf1\{X_1\le B\})\). Its only possibly informative conditional bit has \(U_1=z>0\) and success probability \(F_d(B e^{-\eta}/z)\). For \(d\ge3\), on \(a\in[m,m+1]\) one has \(f_d(a)\ge c\). Indeed \((\log f_d)''\le-1\) gives \(f_d(m)\ge1/\sqrt{2\pi}\), and the log-derivative bound near the mode controls the change to the right. The spherical density at \(z=B e^{-\eta}/a\) is bounded below by \(c\sqrt d\) since \(z^2\le C/d\). Thus this interval, with density in \(a\) at least \(cB/\sqrt d\), contributes at least \(cB\sqrt d\) to the Fisher information. Dimensions two and one follow by the Rayleigh or half-normal formulas on fixed positive radial intervals, with the half-normal cut of order \(B\).

For \(\eta' < \eta\) interchange the parameter labels, so it suffices to consider \(\eta'=\eta+\delta\), \(\delta>0\). We claim uniformly
\[
H^2(P_\eta,P_{\eta+\delta})\ge c B\min(\sqrt d\,\delta^2,\delta).
\tag{6}
\]
For large \(d\) and \(0 < \delta\le4/m\), transform the orientation variable to \(a=B e^{-\eta}/z\) and restrict to \(a\in[m,m+1]\). Both \(a\) and \(e^{-\delta}a\) stay in a fixed-width band around \(m\), where the density \(f_d\) is bounded below numerically by the derivative formula. The difference of success probabilities is at least \(c m\delta\). The probability mass of these orientations is at least \(cB/\sqrt d\). Binary squared Hellinger distance bounds below the squared difference of the probabilities. For \(\delta>4/m\), restrict to \(a\in[m+1,e^\delta(m-1)]\). Its length is at least \(c m\delta\) for all sufficiently large \(m\), and throughout it the success probabilities differ by at least \(P(m-1 < R < m+1)\ge c\). Since \(a\asymp m\) there, its orientation mass is at least \(cB\delta\). The remaining dimensions \(2\le d\le d_0\) for a fixed numerical \(d_0\) follow on \(a\in[1,2]\): on the corresponding compact positive radial interval the densities have common positive lower bounds and \(z\le4/5\), giving \(c B\delta^2\). For \(d=1\), conditional on the positive sign, the half-normal threshold probabilities are of order \(B\) and their difference is at least \(c B\delta\); the squared difference of their square roots gives \(c B\delta^2\). This proves (6), also for all admissible endpoint pairs.

## 4. Minimax loss and finite implementation

For any arrangement the Hellinger distance along scale is bounded above by the integral of the square-root Fisher metric. Thus the uniform bound in (1) gives
\[
H^2\le C B\sqrt d\,|\eta'-\eta|^2
\]
per sample. An independent linear upper bound follows by coupling the two experiments using the same standard Gaussian \(Z\) in \(X=e^\eta Z\). A bit can differ only if its unit projection lies between its two normalized thresholds. The univariate normal density is bounded, so a union bound gives \(H^2\le2\mathrm{TV}\le C B|\eta'-\eta|\). With predictable arrangements, conditional on the same history the same design kernel and each conditional bound apply. Integrating square-root likelihood affinities over histories gives \(H^2\) for the transcript at most \(n\) times either uniform one-step bound. For example, if the conditional affinity is at least \(1-\epsilon\) at each history, iterated integration gives joint affinity at least \((1-\epsilon)^n\). The bound includes explicit independent seed randomization.

Choose two interior \(\eta\)'s with separation a small multiple of \(\min(1,1/(nB))\) using the linear bound, or a small multiple of \(\min(1,1/\sqrt{nB\sqrt d})\) using the quadratic one. In either case testing error is bounded away from zero. The covariance separation squared is of order \(d\delta^2\). The two-point lower bound and the larger of these obstructions give the lower bound in (2).

In the direction-revealed experiment the conditional likelihood as a function of \(\eta\) is log-concave: the density of \(\log R\) is proportional to \(\exp(dy-e^{2y}/2)\), whose distribution and survival functions are log-concave by marginalization. The degenerate bit on \(z\le0\) contributes constant likelihood. For a constrained maximum likelihood estimator on the compact log-scale interval, the event that it is at least \(\delta\) too large implies that the likelihood at \(\eta+\delta\) is at least the likelihood at \(\eta\), by concavity. An analogous argument applies in the opposite direction. Markov's inequality for the square-root likelihood ratio and (6) bound either event by
\[
\exp\{-c n B\min(\sqrt d\,\delta^2,\delta)\}.
\]
One can take the leftmost maximizer, which is measurable by continuity and compactness. Integrating the two tails, and using the fixed parameter cap, gives squared log-scale error at most \(C\min(1,(nB)^{-2}+(nB\sqrt d)^{-1})\). Multiplying by \(O(d)\) gives the requested covariance loss.

Finally finite sets of homogeneous comparisons approximate direction. A sufficiently fine finite net of normals separates any two directions a prescribed distance apart, because the normal parallel to their difference separates them with positive margin. The resulting sign cells have diameter tending to zero as the net mesh tends to zero. Given a cell, uniformly resample a direction from that cell on the sphere. Its joint law with the offset bit has TV distance tending uniformly to zero from the direction-revealed experiment. In fact \(F_d(B e^{-\eta}/z)\), extended by one on \(z\le0\), is jointly continuous in \(z,\eta\) on the compact domain, so replacement by its cell average costs at most the uniform oscillation. Choose the net for the prescribed \(d,n,B\) so the product TV error times the \(O(d)\) cap on loss is at most the rate in (2). This yields a genuine finite arrangement. For the lower bound in (1), nested finite sign partitions may also approximate the direction-revealed conditional score in \(L^2\) by the conditional-expectation martingale convergence theorem. For each finite partition the information is continuous in scale: nonempty cells have positive probability at all scales and their probabilities and derivatives are continuous. The direction-revealed information is continuous as well by dominated convergence, since its conditional binary information is continuous at each direction and bounded by the full radial information \(2d\). The finite-partition information increases pointwise to this continuous limit on the compact scale interval, so Dini’s theorem gives uniform convergence. Taking a refinement of the partitions used for the risk bound produces one finite arrangement satisfying both bounds.

## 5. Charging every sign and allowing unknown location

Fix a positive integer \(K\), and require at most \(K\) comparisons of any kind per observation. The sum of the absolute offsets in each arrangement is still at most \(B\). An array is simultaneous: it is determined before observing the sample to which it is applied. Arrays may depend on previous outcomes and independent randomness. For a fixed \(H<\infty\) allow the independent observations to have law
\[
 X=\sigma(Z+h),\qquad Z\sim N_d(0,I_d),\qquad
 \sigma\in[5/4,7/4],\qquad h\in[-H,H]^d .
\]
Here \(h=\mu/\sigma\) is the unknown standardized location in the fixed coordinate system used by the design. Write \(\mathcal R_{n,d,K}(B,H)\) for the minimax squared Frobenius risk of estimating \(\sigma^2 I_d\) in this experiment. Let \(q=\min(K,d)\).

**Theorem 2.** For \(d,n,K\ge1\), \(0\lt B\le1\), and every fixed \(H\ge0\),
\[
 \mathcal R_{n,d,K}(B,H)\asymp_H
 \begin{cases}
  d\min\{1,(nB^2)^{-1}\},&K=1,\\[2pt]
  d\min\{1,(nB)^{-2}+(nB\sqrt q)^{-1}\},&K\ge2 .
 \end{cases}
\tag{7}
\]
The lower bounds allow any randomized predictable design. A fixed schedule of simultaneous arrays attains the upper bounds. In the centered model \(H=0\), the largest one-sample log-scale Fisher information is \(\asymp B^2\) for \(K=1\) and \(\asymp B\sqrt q\) for \(K\ge2\), uniformly over the scale interval. Every comparison is charged against \(K\), even if its offset is zero. At \(B=0\) the risk is of order \(d\) and the centered Fisher information is zero.

In particular, for \(d\ge2\) the unlimited-comparison rate in (2) is attained with \(d\) signs per sample. Along regimes with \(d\to\infty\) and \(nB/\sqrt d\to\infty\), keeping a numerical-constant multiple of that rate requires \(K\) of order at least \(d\). The budget \(K=1\) gives a separate \(B^2\) information law. This separation already occurs in one dimension.

*Lower bounds and the one-sign case.* We may restrict to \(h=0\). Conditional on a past history the comparison normals of a fixed array span a space of dimension at most \(q\), and their joint observations depend only on the orthogonal projection to that space. This projected centered law is isotropic with the same \(\sigma\). For \(K\ge2\), Section 2 gives a one-step Fisher bound \(CB\sqrt q\) and Section 4 gives a one-step TV bound \(CB|\log(\sigma'/\sigma)|\). The affinity argument and the two choices of separated scale points from Section 4 now give the lower bound in (7) with \(\sqrt q\) in place of \(\sqrt d\) in the information term. The Frobenius separation still uses the full dimension \(d\). If \(K=1\), the one-bit success probability is \(\Phi(\beta/\sigma)\) for some \(|\beta|\le B\), where \(\Phi\) is the standard normal distribution function. It is bounded away from zero and one. Its derivative in log scale is \(O(B)\), so the one-step Fisher information is \(O(B^2)\) and the one-step squared Hellinger distance is \(O(B^2|\log(\sigma'/\sigma)|^2)\). Taking the threshold \(\beta=B\) attains \(\Omega(B^2)\) in the centered model. For the minimax lower bound use affinity and the second Hellinger bound at a separation of order \(\min(1,1/(\sqrt n B))\).

For the \(K=1\) upper bound with unknown location, split observations between cutoffs \(0\) and \(B\) on the first coordinate. The Bernoulli probabilities are \(\Phi(-h_0)\) and \(\Phi(B/\sigma-h_0)\). Their inverse normal cdf difference is \(B/\sigma\). Both probabilities lie in a fixed compact subinterval of \((0,1)\) depending only on \(H\). Estimate the two probabilities by their sample frequencies and take the difference of their inverse normal cdf values, extended Lipschitz continuously to frequencies outside that compact subinterval. Dividing by \(B\) and projecting onto \(J=[4/7,4/5]\) gives squared error \(O_H(1/(nB^2))\) in \(\tau=1/\sigma\). The fixed scale interval bounds the risk by a constant even for small \(n\). On this interval squared covariance error is comparable to \(d|\hat\tau-\tau|^2\).

## 6. A finite layout with the sharp centered information

Use the first \(q\) coordinate directions \(e_0,\ldots,e_m\) with \(m=q-1\) and use notation \(X_j=e_j^\top X\). The main array records the offset bit \(D=\mathbf1\{X_0\le B\}\) and the \(m\) zero-offset bits \(Y_j=\mathbf1\{BX_j\le X_0\}\). Their unit normals are \((Be_j-e_0)/\sqrt{1+B^2}\) for \(1\le j\le m\). Let \(S=\sum_jY_j\). If \(h=0\) and \(t=Z_0/B\), then \(D=\mathbf1\{t\le\tau\}\) and \(S\) given \(t\) is \(\operatorname{Bin}(m,\Phi(t))\). The density of \(t\) is \(B\phi(Bt)\), where \(\phi\) is the standard normal density.

For large enough \(m\), there are at least \(c\sqrt m\) integers \(s\) within \(\sqrt m\) of \(m\Phi(\tau)\). Uniformly at such integers the binomial mass \(b_{m,s}(\Phi(\tau))\) is at least \(c/\sqrt m\) by Stirling's formula. Their ratios \(s/m\) lie in a fixed compact subinterval of \((0,1)\). Their marginal masses satisfy
\[
 \Pr(S=s)\le CB\int_{\mathbb R} b_{m,s}(\Phi(t))\,dt\le CB/m .
\tag{8}
\]
On a bounded interval in \(t\) use the substitution \(p=\Phi(t)\) and the beta identity \(\int_0^1b_{m,s}(p)\,dp=1/(m+1)\). On its complement, use \(b_{m,s}(\Phi(t))\le 2^m e^{-cmt^2}\), by either Gaussian tail and the compact bound on \(s/m\). For a sufficiently large fixed bounded interval the remaining integral is \(O(1/m)\). This proves (8).

Differentiating the joint mass of \(D=1,S=s\) in \(\tau\) gives \(B\phi(B\tau)b_{m,s}(\Phi(\tau))\). For the selected counts this is at least \(cB/\sqrt m\), and the joint mass is at most \(CB/m\). Each such cell contributes at least \(cB\) to the Fisher information, so the joint information is \(\Omega(B\sqrt q)\). Changing from \(\tau\) to log scale only changes the comparison constants. For small \(q\) with \(K\ge2\), take the two parallel thresholds \(0,B\) on the first coordinate. Their rare cell has mass \(\Phi(B\tau)-1/2\asymp B\) and derivative \(\asymp B\), proving \(\Omega(B)\) there. The upper bound was established in Section 5. This proves the centered information assertion with explicit arrays. Their count need not be made arbitrarily large to approximate direction.

## 7. Uniform scale estimation with bounded unknown location

Use a fixed split into \(n_0\) pilot samples and \(n_1\) main samples, with both proportional to \(n\) when \(n\ge4\). Values \(n<4\) are covered by a fixed estimate and the bounded parameter interval. For bounded \(q\) with \(K\ge2\) use the zero sign of \(X_0\) for the pilot and the two cuts \(0,B\) for the main sample. The pilot sign frequency estimates \(h_0\) with mean squared error \(O_H(1/n_0)\) by inversion of \(\Phi\) on its interior compact range. The rare interval probability in the main stage is
\[
 r(h_0,\tau)=\Phi(B\tau-h_0)-\Phi(-h_0).
\]
It lies between \(c_H B\) and \(C_H B\). Its derivative in \(\tau\) is at least \(c_H B\) and its absolute derivative in \(h_0\) is at most \(CB\). Invert \(r(\widehat h_0,\tau)\) against the rare interval frequency, clipping to \(J\). The resulting squared error is \(O_H(1/(nB))\), using the \(O_H(B/n_1)\) variance of that frequency and the pilot error. Combined with the constant risk cap this is the rate in (7) for any \(q\) below a fixed threshold depending only on \(H\).

For larger \(q\), use the \(q\) homogeneous coordinate signs in each pilot observation and the array of Section 6 in each main observation. Estimate each \(h_j\) from its pilot frequency of \(X_j\ge0\). Use a smooth extension of \(\Phi^{-1}\) on \([0,1]\), with range in \([-H-1,H+1]\) and equal to \(\Phi^{-1}\) on a neighborhood of \([\Phi(-H),\Phi(H)]\). Its first and second derivatives are bounded by constants depending only on \(H\). Taylor's formula gives coordinate biases \(O_H(1/n_0)\) and mean squared errors \(O_H(1/n_0)\). Each pilot bit changes its coordinate estimate by \(O_H(1/n_0)\). All the pilot signs are independent across coordinates and observations. In the centered model the location vector is known, so we omit the pilot and use the main array on every sample.

### 7.1. Calibrated thresholds on counts

Put \(\nu=h_0\), \(a_j=h_j\) for \(1\le j\le m\), and denote the pilot values by \(\widehat\nu,\widehat a\). On each main observation, \(t=(Z_0+\nu)/B\) has cdf \(G_\nu(t)=\Phi(Bt-\nu)\). The \(m\) independent auxiliary values \(Z_j+a_j\) are independent of \(t\). With \(V_s(a)\) their \(s\)-th order statistic, we have \(S\ge s\) if and only if \(t\ge V_s(a)\). At \(s=0,m+1\) use \(-\infty,+\infty\), respectively. For a real threshold \(b=s+\lambda\) with \(s\) integer and \(0\le\lambda<1\), let \(V_b(a)\) be \(V_s(a)\) with probability \(1-\lambda\) or \(V_{s+1}(a)\) with probability \(\lambda\), chosen independently. Equivalently, if \(U\) is independent uniform on \([0,1]\), the comparison \(S+U\ge b\) is equivalent to \(t\ge V_b(a)\) using the same \(U\) to choose between the two adjacent ranks.

For a candidate \(\tau\in J\), calculate \(b(\tau)\) as the \(G_{\widehat\nu}(\tau)\)-quantile of \(S+U\) under the fitted nuisance vector. All \(m+1\) count outcomes have positive probabilities at every finite fitted vector. Consequently the cdf of \(S+U\) is continuous and strictly increasing on its support and this quantile is unique. At that threshold,
\[
 \mathbb E\,G_{\widehat\nu}(V_{b(\tau)}(\widehat a))
    =G_{\widehat\nu}(\tau).
\tag{9}
\]
The left side is the fitted probability of \(S+U\lt b(\tau)\). We use the statistic
\[
 W_\tau=D+\Pr_U(S+U\ge b(\tau)\mid S)-1 .
\tag{10}
\]
This uses only the observed bits. It is nonincreasing in \(\tau\) for each observation because \(b(\tau)\) increases. The expectation of \(W_\tau\) under the true model is \(G_\nu(\tau_*)-\mathbb E G_\nu(V_{b(\tau)}(a))\) for the true \(\tau_*\). Its second moment is bounded by the probability that \(t\) lies between \(\tau_*\) and \(V_{b(\tau)}(a)\). Indeed the version with realized \(\mathbf1\{S+U\ge b(\tau)\}\) instead of its conditional probability is zero off this interval and has absolute value one on it. Conditional averaging cannot increase the second moment.

### 7.2. Concentration and sensitivity of the order statistics

For a vector \(a\) in a fixed bounded cube and a rank fraction \(s/m\in[\alpha,1-\alpha]\), define \(v_s(a)\) by
\[
 \overline p_a(v_s(a))=s/m,\qquad
 \overline p_a(x)=m^{-1}\sum_{j=1}^m\Phi(x-a_j).
\]
Here \(\alpha>0\) is a fixed constant depending only on \(H\), to be chosen below. All such \(v_s(a)\) lie in a common compact interval on which \(\overline p_a'\) is bounded below by a positive constant. Other constants in this subsection can depend on this fixed \(\alpha\). For \(0\le u\le1\), compare the independent counts below \(v_s(a)\pm u\) to \(s\). The difference of their means from \(s\) is at least \(c_H m u\), so Hoeffding's inequality gives a tail bound \(2e^{-c_H m u^2}\) for \(|V_s(a)-v_s(a)|>u\). For \(1\lt u\le u_0\) use the bound at 1, with \(u_0\) a sufficiently large fixed constant. Beyond \(u_0\), at least \(\alpha m\) independent Gaussian coordinates must lie in a tail of threshold at least \(u-C_H\) on the corresponding side. A union bound over at most \(2^m\) subsets then gives \(2e^{-c_H m u^2}\) for sufficiently large \(u_0\). Integrating shows
\[
 \mathbb E|V_s(a)-v_s(a)|\le C_H/\sqrt m .
\tag{11}
\]
The probability that such \(V_s(a)\) leaves a fixed larger compact interval is at most \(C_H e^{-c_H m}\). Adjacent central \(v_s(a)\) differ by \(O_H(1/m)\) by the derivative bound.

For every fitted vector and \(\tau\in J\) the fraction \(\overline p_{\widehat a}(\tau)\) stays in \([2\alpha,1-2\alpha]\) for a common \(\alpha>0\). Consider ranks just below and above \(m\overline p_{\widehat a}(\tau)\pm L_H\sqrt m\) for a sufficiently large fixed \(L_H\). For \(m\) above a threshold depending only on \(H\), both ranks and all ranks between them are central. Their population locations bracket \(\tau\) by at least \(c L_H/\sqrt m\) on each side because \(\overline p'_{\widehat a}\) is bounded above. On the common compact interval,
\[
 c_H B\le G_\nu'(x)\le CB
\]
for all fitted and true \(\nu\). By (11), replacing each order statistic by its population location in \(\mathbb E G_{\widehat\nu}(V_s(\widehat a))\) costs at most \(C_H B/\sqrt m\). Choosing \(L_H\) large enough makes these two expectations strictly bracket \(G_{\widehat\nu}(\tau)\). Thus both ranks entering \(V_{b(\tau)}(\widehat a)\) in (9) are central, with population locations within \(O_H(1/\sqrt m)\) of \(\tau\) by the lower derivative bound on \(\overline p_{\widehat a}\). The fitted mixture satisfies
\[
 \mathbb E|V_{b(\tau)}(\widehat a)-\tau|\le C_H/\sqrt m .
\tag{12}
\]

For an integer central rank write \(A_{\nu,s}(a)=\mathbb E G_\nu(V_s(a))\). We next show
\[
 |\partial_{a_j}A_{\nu,s}(a)|+|\partial_{a_j}^2A_{\nu,s}(a)|\le C_H B/m .
\tag{13}
\]
Fix the other coordinates. As a function of the value of coordinate \(j\), \(G_\nu(V_s)\) is absolutely continuous with derivative \(G_\nu'\) on the interval where this coordinate has rank \(s\), and zero derivative otherwise. Gaussian shift differentiation gives the first derivative as the expectation of \(G_\nu'(Z_j+a_j)\) on that rank event. Differentiating the shifted density against the same derivative gives the second derivative with an additional factor \(Z_j\). These differentiations follow by conditioning and dominated integration against Gaussian densities.

On a fixed compact interval of \(x\), the contributions
\[
 \ell_j(x)=\phi(x-a_j)\Pr\{N_{-j}(x)=s-1\}
\]
to the density of \(V_s(a)\) are comparable uniformly in \(j\). Here \(N_{-j}(x)\) counts all coordinates other than \(j\) at most \(x\). For \(j\ne k\), both counts' displayed probabilities are mixtures of \(\Pr\{N_{-\{j,k\}}(x)=s-1\}\) and \(\Pr\{N_{-\{j,k\}}(x)=s-2\}\). The two possible mixing weights are bounded away from zero and one on the compact interval, as are the Gaussian density factors away from zero. Thus \(\ell_j(x)\le C_H m^{-1}\sum_k\ell_k(x)\) there. It follows that the event that \(j\) has rank \(s\) and that its value lies in the interval has probability at most \(C_H/m\). On that event \(Z_j\) is bounded. Off the interval, extend it if necessary and apply the exponential bound following (11), using Cauchy–Schwarz for the term with \(|Z_j|\). Both expectations defining the derivatives are then \(O_H(B/m)\), since \(G_\nu'\le CB\). This proves (13).

### 7.3. Effect of estimating the nuisance vector

Replace the true auxiliary means by their estimates one at a time in \(A_{\nu,s}\). The independence of pilot estimates across coordinates and the first- and second-derivative bounds (13) give
\[
 |\,\mathbb E A_{\nu,s}(\widehat a)-A_{\nu,s}(a)\,|\le C_H B/n_0 .
\tag{14}
\]
Indeed, condition on all estimates except the coordinate being replaced. Its bias and second moment are each \(O_H(1/n_0)\), so Taylor's formula costs \(O_H(B/(m n_0))\) at each replacement. Also, changing one of the \(m n_0\) independent pilot bits changes \(A_{\nu,s}(\widehat a)\) by at most \(C_H B/(m n_0)\). The bounded-differences inequality gives a sub-Gaussian tail around its mean with scale \(C_H B/\sqrt{m n_0}\). Summing the tail bound over at most \(m\) ranks and integrating the squared maximum, then using (14), yields
\[
 \mathbb E\!\left[
       \left(B^{-1}\max_{s/m\in[\alpha,1-\alpha]}
       |A_{\nu,s}(\widehat a)-A_{\nu,s}(a)|\right)^2
       \right]
 \le C_H\!\left(n_0^{-2}+\frac{\log(m+1)}{m n_0}\right).
\tag{15}
\]

For the fitted \(\widehat\nu\), use (9) to compare the conditional moment at the same threshold to its counterpart with the true \(\nu\). The derivative in \(x\) of \(G_\nu(x)-G_{\widehat\nu}(x)\) has absolute value at most \(CB|\widehat\nu-\nu|\). Applied between \(\tau\) and \(V_{b(\tau)}(\widehat a)\), (12) bounds the resulting error by \(C_H B|\widehat\nu-\nu|/\sqrt m\). The remaining error when replacing \(\widehat a\) by \(a\) is bounded by the maximum in (15), since the calibrated threshold mixes two central ranks. Thus, for a nonnegative pilot-dependent \(e\), simultaneously for all \(\tau\in J\),
\[
 \left|G_\nu(\tau)-\mathbb E G_\nu(V_{b(\tau)}(a))\right|\le Be,
 \qquad
 \mathbb E e^2\le C_H\!\left(n_0^{-2}+\frac{\log(m+1)}{m n_0}\right).
\tag{16}
\]
In the centered case both perturbations are zero and we take \(e=0\).

For the true auxiliary vector, the same two ranks are central and their population locations differ by \(O_H(1/m)\). Comparing the expectation in (16) to \(G_\nu(v_s(a))\) costs at most \(C_H B/\sqrt m\) by (11). Since \(G_\nu'\ge c_H B\) on the common compact interval, the distance from \(v_s(a)\) to \(\tau\) is at most \(C_H(e+1/\sqrt m)\). Hence \(\mathbb E|V_{b(\tau)}(a)-\tau|\le C_H(e+1/\sqrt m)\). Use the second-moment observation after (10) and \(G_\nu'\le CB\) to get
\[
 \mathbb E W_\tau^2\le C_HB\bigl(|\tau-\tau_*|+e+m^{-1/2}\bigr).
\tag{17}
\]
All main expectations in (16)–(17) are conditional on the pilot. Also by (16), the mean of \(W_\tau\) has the sign of \(\tau_*-\tau\) with magnitude at least \(c_H B|\tau-\tau_*|\) whenever \(|\tau-\tau_*|\ge C_H e\), enlarging the constant as needed.

### 7.4. The estimator

Take the first nonpositive crossing of the empirical average of (10) on \(J\), with the upper endpoint used if the crossing set is empty. This defines a measurable estimator \(\widehat\tau\), since the conditional survival probability in (10) is piecewise linear in \(b\) and \(b(\tau)\) is continuous. By monotonicity, a deviation of \(\widehat\tau\) from \(\tau_*\) by more than \(\delta\) requires the wrong sign of the empirical statistic at the point a distance \(\delta/2\) away on the same side. If this point is outside \(J\) that deviation is impossible. Conditional on the pilot, the main observations are independent. The mean bound, (17), and Bernstein's inequality for the bounded statistic give
\[
 \Pr\{|\widehat\tau-\tau_*|>\delta\mid\text{pilot}\}
 \le 2\exp\!\left\{-\frac{c_H n_1B\delta^2}{\delta+m^{-1/2}}\right\}
 \qquad (\delta>C_H e).
\tag{18}
\]
Below \(C_H e\) bound the conditional probability by one. Integrate the squared-error tail using
\(\delta^2/(\delta+m^{-1/2})\ge\frac12\min(\delta,\sqrt m\,\delta^2)\).
This gives squared error at most a constant times
\[
 \mathbb E e^2+(nB)^{-2}+(nB\sqrt m)^{-1}.
\]
The first term is absorbed by the last two, since \(B\le1\), \(n_0\) is proportional to \(n\), and \(\log(m+1)/m\le C/\sqrt m\). In the centered case the same conclusion uses \(n_1=n\) and \(e=0\). Clipping to the fixed interval gives the constant cap. Multiplying by \(d\) for covariance loss and recalling \(m=q-1\) concludes the proof of Theorem 2.

## 8. Unbounded location

**Theorem 3.** If the common mean \(\mu\) of \(N_d(\mu,\sigma^2 I_d)\) is unrestricted in \(\mathbb R^d\), the minimax squared Frobenius risk for \(\sigma^2 I_d\) is of order \(d\) for every finite \(n\). The lower bound allows arbitrary randomized predictable arrangements with a finite number of comparisons at each sample, even if the design has no uniform comparison-count bound. It suffices that every chosen offset is finite.

Fix an arbitrary protocol and two distinct scales in the interior of the allowed interval. Under either scale put a prior on the mean \(\mu=R\Theta\), where \(\Theta\) is a uniform unit direction, common to all samples. For fixed independent random seeds the decision tree has finite depth \(n\) and finitely many nodes, since every node collects finitely many binary outcomes. For almost every \(\Theta\) none of the normals at any node is orthogonal to it. In dimension one this condition holds at both unit directions. At each such direction and seed, all comparisons on the deterministic path defined by the signs of the mean projections become deterministic in probability as \(R\to\infty\). Their offsets are finite and the two scales are fixed. A finite union bound along that path gives convergence to the same deterministic replies under either scale. Integrating over directions and protocol seeds gives total variation convergence of both enriched transcript laws to the common deterministic-response law, by dominated convergence. This remains true for ordinary transcripts by data processing.

Consequently for a sufficiently large \(R\) the two transcript laws have testing error bounded below by a numerical constant. The scale choices have covariance separation squared a numerical constant times \(d\). The two-hypothesis inequality under these priors lower bounds the worst-case risk of the fixed protocol by \(cd\), and the bound survives taking the infimum over protocols. A fixed covariance estimate gives the upper bound. The result concerns uniform risk over location. In particular it is compatible with pointwise estimation at any fixed finite location.

## 9. Estimating the full covariance under bounded spectrum

Fix \(0\lt a\lt b<\infty\) and suppose \(X\sim N_d(0,\Sigma)\) with \(aI\preceq\Sigma\preceq bI\). The same count and offset caps apply. The estimand is now the entire matrix \(\Sigma\), with squared Frobenius loss. Denote the corresponding minimax risk by \(\mathcal R_{n,d,K}^{[a,b]}(B)\).

**Theorem 4.** For \(0\lt B\le1\) and \(K\ge\max\{2,3d-2\}\),
\[
 \mathcal R_{n,d,K}^{[a,b]}(B)
 \asymp_{a,b}
 d\min\left\{1,\frac{d}{n}+\frac1{(nB)^2}
                        +\frac1{nB\sqrt d}\right\}.
\tag{19}
\]
The lower bound holds even without a comparison-count cap. A two-stage design attains the upper bound. Its first stage uses homogeneous comparisons to estimate shape. Its second stage uses \(d\) comparisons per sample in dimensions sufficiently large, with one nonzero offset. At \(B=0\) the risk is of order \(d\).

The proof uses only the centered model in this section. In particular, (7) addresses unknown location with isotropic covariance, and (19) addresses unknown covariance shape with zero location.

### 9.1. Lower bounds

The isotropic restriction gives the last two terms of (19) and the risk cap, by the proof of (2) on a fixed positive scale interval inside \([\sqrt a,\sqrt b]\). The bounds there depend only on the scale interval: in dimension at least three (5) is dimension-uniform with any offset divided by the lower limit of the scale, and in dimensions one and two the same binary information bounds are uniform up to the corresponding fixed upper limit of the standardized threshold. The normal projection coupling and the trace loss of the two points apply without change. At \(B=0\), the two isotropic scales are exactly indistinguishable.

Even fully observing the Gaussian samples entails squared Frobenius risk at least \(c_{a,b}\min(d,d^2/n)\). Here is a packing proof for large \(d\). Consider real symmetric matrices \(U\) with zero diagonal and independent Rademacher entries above the diagonal. At least half have \(\|U\|_{\rm op}\le C\sqrt d\), since each unit-vector quadratic form is a bounded-variance Rademacher sum with a numerical sub-Gaussian constant. Apply a fixed-radius net of at most \(9^d\) points to bound its maximum. Among the matrices with this operator bound greedily pack at least \(\exp(c d^2)\) matrices with pairwise Hamming distance at least \(c d^2\) among their upper-triangular entries. A Hamming ball of radius a sufficiently small fixed fraction of \(d(d-1)/2\) has size at most \(\exp(c' d^2)\) with \(c'\) strictly smaller than the exponent in the total number of candidates. Use covariances
\[
 \Sigma_U=\frac{a+b}{2}I+\frac{\xi U}{\sqrt{\max(n,d)}}
\]
for sufficiently small \(\xi>0\) depending on \(a,b\). They lie in the spectral set and have pairwise squared Frobenius distance at least \(c_{a,b}d^2/\max(n,d)\). Their relative entropies to \(n\) samples from the central covariance are at most \(C_{a,b}n\xi^2\|U\|_F^2/\max(n,d)\), by the quadratic bound for \(x-\log(1+x)\) on a small interval about zero. Taking \(\xi\) smaller than a fixed multiple of the packing exponent lets the testing bound of Fano apply. In bounded dimensions the isotropic restriction already supplies the same lower order, since \(B\le1\). A sign experiment is a randomized function of the full samples, so the packing applies to its risk. Taking the larger of these two lower bounds yields (19) up to constants.

### 9.2. Learning normalized shape using only homogeneous signs

Normalize the target shape by a reference variance: write \(\sigma_0^2=\Sigma_{00}\) and \(P=\Sigma/\sigma_0^2\). Its spectrum lies in \([l,u]=[a/b,b/a]\). We show that \(n_0\) pilot observations with no offset and \(3d-2\) comparisons each give a positive-definite \(\widehat P\) with spectrum in \([l,u]\) and
\[
 \mathbb E\|\widehat P-P\|_{\rm op}^2
 \le C_{a,b}\min\{1,d/n_0\}.
\tag{20}
\]
Use the \(d\) coordinate signs \(Y=\operatorname{sgn}(X)\). If \(R\) is the population correlation matrix of \(X\), then \(G=\mathbb E YY^\top=(2/\pi)\arcsin R\), with the functions here applied entrywise. The correlation matrix has spectrum in \([l,u]\). Linear forms of \(Y\) are uniformly sub-Gaussian with scale \(C_{a,b}\|v\|_2\) for \(v^\top Y\). To see this, represent the standardized Gaussian vector as \(V+W\) with \(W\sim N(0,l I)\) independent of \(V\) of covariance \(R-l I\). Given \(V\), the centered coordinate signs are independent and bounded, giving a sub-Gaussian bound for their linear combination around its conditional mean. The conditional mean of \(v^\top Y\) is \(\sum_j v_j(2\Phi(V_j/\sqrt l)-1)\). As a function of \(V\) its gradient norm is at most \(C\|v\|_2/\sqrt l\). Gaussian concentration proves the same sub-Gaussian bound for its fluctuations, and its unconditional mean is zero. Conditional integration gives the assertion for \(v^\top Y\).

Consequently the empirical moment \(\widehat G=n_0^{-1}\sum_i Y_iY_i^\top\) satisfies
\[
 \Pr\left\{\|\widehat G-G\|_{\rm op}>
   C_{a,b}\bigl(\sqrt{(d+x)/n_0}+(d+x)/n_0\bigr)\right\}
 \le 2e^{-x}\quad(x\ge0).
\tag{21}
\]
A unit-vector quadratic form of the error is a mean of centered subexponential variables, by the just-proved sub-Gaussian bound. Bernstein's inequality on a fixed-radius sphere net and its cardinality imply (21). Invert the arcsine coordinatewise to obtain \(\widehat R=\sin(\pi\widehat G/2)\). The inversion is uniformly operator-Lipschitz on correlation-matrix inputs. For any two of these inputs, a difference of their entrywise powers telescopes into terms that are the Schur product of the difference with correlation matrices. This operation contracts the operator norm for symmetric matrices: it is positive by the Schur product theorem and preserves \(I\). Summing the operator bounds with the absolutely summable differentiated sine series gives
\[
 \|\widehat R-R\|_{\rm op}\le C\|\widehat G-G\|_{\rm op}.
\tag{22}
\]
Thus for \(n_0\ge d\) its expected squared operator error is \(O_{a,b}(d/n_0)\).

The remaining homogeneous comparisons are the signs of \(X_j-X_0\) and \(X_j+X_0\) for \(j>0\). They tell whether \(|X_j|\le |X_0|\) from the sign of the product, and cost \(2d-2\) bits. Set \(t_j=\sqrt{\Sigma_{jj}}/\sigma_0\) and \(\rho_j=R_{0j}\). The ratio \(X_j/X_0\) has the law of \(t_j(\rho_j+\sqrt{1-\rho_j^2}\,C)\) with standard Cauchy \(C\), by the conditional Gaussian representation. Hence the event probability is
\[
 p(t_j,\rho_j)=\Pr\{|\rho_j+\sqrt{1-\rho_j^2}\,C|\le 1/t_j\}.
\]
The \(t_j\) lie in \([\sqrt l,\sqrt u]\) and the \(\rho_j\) in a fixed compact subinterval of \((-1,1)\) because \(R\succeq l I\). On these intervals the Cauchy cdf formula shows that \(-\partial_t p\) has a positive lower bound and \(\partial_\rho p\) is bounded. Indeed the derivative in \(t\) is minus \(t^{-2}\) times the sum of the two positive Cauchy densities at the moving endpoints, uniformly bounded away from zero there. Estimate \(t_j\) by inverting \(p(t,\widehat\rho_j)\) against the empirical event frequency, clipping both the correlation estimate and the resulting ratio to their fixed intervals. The ratio error is bounded by a constant times the event probability error plus \(|\widehat\rho_j-\rho_j|\). Hoeffding's inequality and a union bound give an expected squared maximum event probability error of \(O(\log(d+1)/n_0)\). The maximum correlation error is at most the operator error in (22), since clipping cannot increase it. With \(t_0=\widehat t_0=1\), \(\widehat P^{(0)}=\operatorname{diag}(\widehat t)\widehat R\operatorname{diag}(\widehat t)\) therefore has expected squared operator error \(O_{a,b}(d/n_0)\). Clip its eigenvalues to \([l,u]\) to obtain \(\widehat P\). The change in operator norm from clipping is no larger than its operator error, by the eigenvalue perturbation inequality and the true spectral interval. The clipped matrix also has a bounded error for every pilot sample. This proves (20), with a fixed estimate permitted when \(n_0\lt d\).

### 9.3. Calibration after estimating shape

Take \(n_0,n_1\) proportional to \(n\). If \(n\) is below a fixed multiple of \(d\), the constant covariance estimate has the required order, so take \(n_0\ge d\). If \(d\) is less than a fixed numerical threshold depending on \(a,b\), learn shape as above and estimate \(\sigma_0\) using two parallel cuts at \(0,B\) on the original first coordinate. The rare interval calculation in Section 7 gives scale squared error \(O_{a,b}(1/(nB))\), or a constant with the risk cap. This is sufficient for (19) in bounded dimension. In what follows \(d\) is larger.

Conditional on the pilot, put \(L=\widehat P^{-1/2}\) and \(W=LX\). Set \(A=LPL\), so \(W/\sigma_0\sim N(0,A)\) and \(\|A-I\|_{\rm op}\le C_{a,b}\|\widehat P-P\|_{\rm op}\). Write \(e=\|\widehat P-P\|_{\rm op}\). Use one offset comparison \(D=\mathbf1\{W_0\le b_0\}\) at \(b_0=B/\sqrt u\). In original coordinates this is a unit-normal comparison with offset \(b_0/\|Le_0\|\le B\). Draw \(m=d-1\) independent vectors \(g_j\sim N_m(0,I_m/m)\) before observing each main sample and collect the homogeneous comparisons
\[
 Y_j=\mathbf1\{b_0\,g_j^\top W_\perp\le W_0\},
 \qquad j=1,\ldots,m .
\]
Their original normals can be scaled to unit length since their first transformed coordinate is nonzero. The estimator uses only \(D\) and the count \(S=\sum_jY_j\), without needing the drawn vectors. Conditional on \(W\), the comparisons are independent Bernoulli with probability \(\Phi(W_0/(b_0\|W_\perp\|/\sqrt m))\). Thus for the joint law used by the estimator one can generate \(S\) as the count of independent standard normal auxiliaries below this scalar argument, drawn independently of \(W\).

Write \(v=A_{00}\), \(\lambda=A_{\perp 0}/v\), and \(C=A_{\perp\perp}-A_{\perp0}A_{0\perp}/v\). Use the Gaussian regression representation
\[
 W_0/\sigma_0=\sqrt v\,Z_0,\qquad
 W_\perp/\sigma_0=\lambda\sqrt v\,Z_0+C^{1/2}Z ,
\]
where \(Z_0\) and \(Z\sim N_m(0,I_m)\) are independent. Put \(t=Z_0/b_0\), and \(G(t)=\Phi(b_0 t)\) for its cdf. The cutoff bit is \(D=\mathbf1\{t\le\tau_{\rm eff}\}\) at \(\tau_{\rm eff}=(1/\sigma_0)/\sqrt v\). The scale interval and the positive spectral bounds on \(A\) place \(\tau_{\rm eff}\) in a fixed compact positive interval \(J_1\), which we choose also to contain \([1/\sqrt b,1/\sqrt a]\). For a central rank \(s\) of \(m\) independent standard normal auxiliary values let \(V_s\) denote its order statistic. It is independent of \(t,Z\). Then \(S\ge s\) if and only if
\[
 t\ge V_s\,r(t,Z),\qquad
 r(t,Z)=\frac{\|\lambda b_0\sqrt v\,t+C^{1/2}Z\|}{\sqrt{mv}}.
\tag{23}
\]
The nominal reference model uses \(A=I\), with \(r(t,Z)=R_0=\|Z\|/\sqrt m\) independent of \(t\).

For candidate \(\tau\in J_1\), calibrate \(b(\tau)\) as the \(G(\tau)\)-quantile of \(S+U\) in this nominal model, with \(U\) uniform as in Section 7.1. Hence \(\mathbb E G(R_0 V_{b(\tau)})=G(\tau)\), again with the two adjacent ranks mixed. Uniformly for central ranks, (11) and the chi moment bound \(\mathbb E|R_0-1|\le\sqrt{2/m}\) give
\[
 \mathbb E|R_0 V_s-\Phi^{-1}(s/m)|\le C/\sqrt m .
\]
Here \(R_0\) and \(V_s\) are independent, \(\mathbb E R_0\le1\), and the population quantile stays in a compact interval for central ranks. Choose ranks surrounding \(m\Phi(\tau)\) by a sufficiently large fixed multiple of \(\sqrt m\). As in the proof of (12), their nominal cdf values strictly bracket \(G(\tau)\) because \(G'\asymp_{a,b}B\) on compacts and \(G'\le CB\) globally. All selected ranks are central with a fraction bounded away from zero and one uniformly on \(J_1\). Their mixture satisfies
\[
 \mathbb E |R_0 V_{b(\tau)}-\tau|\le C_{a,b}/\sqrt m,\qquad
 \mathbb E |V_{b(\tau)}|^2\le C_{a,b}.
\tag{24}
\]
The moment bound also follows by integrating the order-statistic tails used for (11).

Assume first that \(e\) is below a fixed positive constant depending only on \(a,b\). The regression parameters satisfy
\[
 |\sqrt v-1|+\|\lambda\|+\|C^{1/2}-I\|_{\rm op}\le C_{a,b}e .
\]
For the square root, \(C-I\) is \(O_{a,b}(e)\) and diagonalization bounds the eigenvalue square roots. The map \(r(t,Z)\) is Lipschitz in \(t\) with constant \(\Lambda=b_0\|\lambda\|/\sqrt m\). Also \(|r(0,Z)-R_0|\le C_{a,b}e R_0\). For fixed \(V=V_{b(\tau)}\) and \(Z\), on the event \(\Lambda |V|\le1/2\), the function \(V r(t,Z)\) is a contraction, with unique fixed point \(z_*\). The difference \(t-Vr(t,Z)\) is strictly increasing, so (23) is a threshold at \(z_*\) on this event. The fixed point satisfies \(|z_*|\le2|V|r(0,Z)\). Therefore
\[
 |z_*-V R_0|
 \le |V|\,\bigl(C_{a,b}e R_0+\Lambda|z_*|\bigr)
 \le C_{a,b}eR_0 (|V|+|V|^2).
\tag{25}
\]
The complementary event has probability at most \(2\Lambda\,\mathbb E|V|\le C_{a,b}Be/\sqrt m\), vanishing when \(\Lambda=0\). This bound retains its factor \(B\) even when the offset is arbitrarily small.

Compute the same statistic (10), with the nominal threshold used here. Compare its expectation to \(G(\tau_{\rm eff})-G(\tau)\). On the contraction event the probability change from replacing the nominal order-statistic threshold \(V R_0\) by the actual threshold \(z_*\) is at most \(CB|z_*-V R_0|\) by the bounded density of \(t\). Its expected value is \(O_{a,b}(Be)\) by (24)–(25) and \(\mathbb E R_0\le1\). Add the complementary event bound. This proves that the actual mean differs from \(G(\tau_{\rm eff})-G(\tau)\) by at most \(C_{a,b}Be\). On the contraction event the square of the realized-comparison version of \(W_\tau\) is the indicator that \(t\) lies between \(\tau_{\rm eff}\) and \(z_*\). Its conditional probability is bounded by \(CB|\tau_{\rm eff}-z_*|\). Use (24)–(25), and again add the complementary event bound, to obtain
\[
 \mathbb E W_\tau^2
 \le C_{a,b}B\bigl(|\tau-\tau_{\rm eff}|+e+m^{-1/2}\bigr).
\tag{26}
\]
Conditional averaging over \(U\) only decreases the second moment. The calibrated statistic is still nonincreasing in \(\tau\) for every observation.

The crossing estimator from Section 7.4 on \(J_1\) now obeys (18), conditionally on the shape pilot, with \(\tau_{\rm eff}\) as center and a constant multiple of \(e\) as the calibration error. Integration gives squared error \(O_{a,b}(e^2+(nB)^{-2}+(nB\sqrt m)^{-1})\). Because \(|\tau_{\rm eff}-1/\sigma_0|\le C_{a,b}e\) when \(e\) is small, clipping to \([1/\sqrt b,1/\sqrt a]\) gives the same bound for the original inverse scale. When \(e\) exceeds the fixed threshold we use the constant cap on inverse scale loss, which is bounded by a larger constant times \(e^2\). This is an analysis of the same clipped estimator and requires no knowledge of \(e\). Average over the pilot and apply (20). Finally use \(\widehat\Sigma=\widehat\sigma_0^2\widehat P\). The spectral bounds and \(\|\widehat P-P\|_F^2\le d\|\widehat P-P\|_{\rm op}^2\) give
\[
 \mathbb E\|\widehat\Sigma-\Sigma\|_F^2
 \le C_{a,b}d\left[d/n+(nB)^{-2}+(nB\sqrt d)^{-1}\right].
\]
Both matrices have bounded spectrum, giving the additional \(O_{a,b}(d)\) cap. This completes (19).

## 10. The full-covariance rate at every comparison count

The restriction \(K\ge\max\{2,3d-2\}\) in Theorem 4 can be removed. A smaller count reduces the information about shape as well as the information about scale. Both effects have sharp orders, with a separate transition at one comparison.

**Theorem 5.** Under the full-covariance model of Section 9, let \(q=\min(K,d)\). For every \(0\lt B\le1\),
\[
 \mathcal R_{n,d,K}^{[a,b]}(B)\asymp_{a,b}
 \begin{cases}
   d\min\{1,d^3/(nB^2)\}, &K=1,\\[2pt]
   d\min\{1,d^3/(nq^2)+(nB)^{-2}+(nB\sqrt q)^{-1}\}, &K\ge2 .
 \end{cases}
\tag{27}
\]
The lower bounds hold for every randomized predictable sequence of simultaneous arrays. For \(K\ge2\), the upper bound uses independent batches of homogeneous signs for shape and at most \(q\) comparisons, with one nonzero offset, for each scale observation when \(q\) is sufficiently large. For small \(q\), two parallel comparisons suffice for scale. The \(K=1\) upper bound uses only one affine comparison on each observation. At \(B=0\) the unrestricted covariance risk is of order \(d\).

### 10.1. Fisher information for shape under arbitrary predictable arrays

Use \(p=d(d+1)/2\) orthonormal Frobenius coordinates for symmetric matrices, and write \(I_{\Sigma}\) for the Fisher information on these coordinates. At any history consider the subspace spanned by the current normals, of dimension \(r\le q\), and let \(V\) be an isometric basis matrix. Revealing \(V^\top X\) can only increase information. Its covariance is \(\Sigma_V=V^\top\Sigma V\). The Fisher quadratic form in a covariance direction \(E\) is
\[
 E^\top I_{\Sigma}E=
   \tfrac12\|\Sigma_V^{-1/2}V^\top E V\Sigma_V^{-1/2}\|_F^2
\tag{28}
\]
for the revealed projection, with \(E\) identified with its coordinate vector on the left. This follows by differentiating the Gaussian density and taking the variance of the resulting centered quadratic score. The linear map on the right has rank at most \(r(r+1)/2\) and operator norm at most \(1/a\) between the Frobenius spaces. Thus the conditional Fisher trace of the signs is at most \(C_{a,b}q^2\).

If \(K=1\), its Bernoulli probability in a direction \(v\) is \(\Phi(\beta/\sqrt{v^\top\Sigma v})\). It is bounded away from zero and one uniformly. The probability gradient with respect to the Frobenius coordinates is a scalar multiple of \(vv^\top\) with norm at most \(C_{a,b}B\), since \(|\beta|\le B\). This bounds the one-step Fisher trace by \(C_{a,b}B^2\).

To justify the adaptive summation, condition on the independent protocol seeds. At each history an array is then fixed. Each sign cell of positive mass has strictly positive probability throughout the parameter set, since the full Gaussian densities have the same support and their densities are strictly positive. A zero-mass cell stays zero. Nonzero cell probabilities are differentiable by dominated Gaussian differentiation on compact positive-definite sets. The score of the finite transcript is the sum of successive conditional scores. Each conditional score has mean zero given the past, so the trace of the transcript information is the sum of expected conditional traces. The bounds \(C_{a,b}nq^2\) and \(C_{a,b}nB^2\) hold for every seed. They remain valid if the seed itself is included in the transcript.

Use a prior supported in the interior of the spectral parameter set. Center at \((a+b)I/2\) and let \(E\) have independent \(N(0,\gamma^2/d)\) coordinates in a Frobenius orthonormal basis. Multiply its density by \(\chi(\|E\|_{\rm op})^2\) and normalize, with a fixed smooth cutoff equal to one on \([0,(b-a)/4]\) and zero for radii at least \(3(b-a)/8\). The normalizing constant is bounded below for sufficiently small \(\gamma>0\) depending on \(a,b\). Indeed, \(v^\top E v\) has variance \(\gamma^2/d\) for every unit \(v\). A sphere net of at most \(9^d\) points shows that at least half the Gaussian mass has \(\|E\|_{\rm op}\le (b-a)/4\). The prior Fisher trace \(4\int\|\nabla\sqrt{\pi}\|_2^2\) is \(O_{a,b}(d^3)\). To see this, the logarithmic gradient of the uncut Gaussian is \(-d E/\gamma^2\) in Frobenius coordinates and \(\mathbb E\|E\|_F^2=p\gamma^2/d=O_{a,b}(d)\). The operator norm is 1-Lipschitz for the Frobenius metric, so the cutoff gradient is bounded almost everywhere. Differentiate the product defining \(\sqrt{\pi}\), square using the sum of the two contributions, and use the normalizer bound. The cutoff has absolutely continuous coordinate sections, which suffice for integration by parts despite the nonsmoothness of the norm on a null set.

For completeness, integration by parts in the joint prior and likelihood gives
\[
 \mathbb E\langle \widehat\Sigma-\Sigma,\,
       \nabla\log p_{\Sigma}(\text{transcript})+\nabla\log\pi(\Sigma)\rangle_F=p .
\]
The cutoff kills boundary terms and the estimator is fixed when differentiating a transcript. It can be assumed symmetrized and clipped to the spectral set to ensure integrability. This is the trace form of the van Trees inequality after applying Cauchy–Schwarz. The squared norm of the score sum has expectation equal to the sum of the likelihood and prior Fisher traces, since the likelihood score has mean zero under each \(\Sigma\). Therefore the Frobenius risk is at least a constant times
\[
 \frac{d^4}{n q^2+d^3}\quad (K\ge2),
 \qquad
 \frac{d^4}{n B^2+d^3}\quad (K=1).
\tag{29}
\]
For \(K\ge2\), also apply the two-point isotropic lower bound in Section 5 on a fixed positive scale interval inside \([\sqrt a,\sqrt b]\), as in Section 9.1. It contributes the two scalar calibration terms with \(\sqrt q\). The maximum of the two lower bounds, with their common cap \(d\), agrees with the \(K\ge2\) expression of (27) up to constants.

### 10.2. Upper bound with one comparison

For each coordinate vector \(e_i\) and each direction \((e_i+e_j)/\sqrt 2\), \(i\lt j\), allocate a separate equal-sized batch of observations and record their signs with offset \(B\). There are \(p\) directions. If \(n\) is smaller than a fixed multiple of \(d^3/B^2\), a fixed covariance has squared risk \(O_{a,b}(d)\), within constant of (27). Otherwise there are \(\asymp n/p\) observations in each batch. A direction with variance \(v\in[a,b]\) gives probability \(\Phi(B/\sqrt v)\), whose derivative has absolute value at least \(c_{a,b}B\) throughout the interval. Invert the clipped frequency to obtain its variance with mean squared error \(O_{a,b}(p/(nB^2))\). The variance along \((e_i+e_j)/\sqrt 2\) is \((\Sigma_{ii}+\Sigma_{jj})/2+\Sigma_{ij}\). Use this to recover each off-diagonal entry. Its error is bounded in mean square by a constant times the sum of the three constituent variance errors. Summing over all matrix entries yields the risk \(O_{a,b}(d^4/(nB^2))\).

### 10.3. Shape recovery with a small comparison count

For \(K\ge2\), put \(r=\min(d,\lfloor K/2\rfloor)\) and partition the \(d\) coordinates into \(J=\lceil d/r\rceil\) blocks of size at most \(r\). Then \(J\asymp d/q\), uniformly over the two integer ranges. Use a fixed positive fraction of the observations for correlation estimation, another for diagonal-ratio estimation, and the remaining fraction for scale. If \(n\) is below a sufficiently large constant times \(dJ^2\), use a fixed covariance and the \(O_{a,b}(d)\) cap. Otherwise the allocations below have at least a constant times \(d\) observations in every correlation batch.

For each unordered pair of coordinate blocks, including a block paired with itself, use a separate equal-sized batch of \(N\asymp n/J^2\) observations. Measure the homogeneous coordinate signs in the union of the pair. These arrays use at most \(2r\le K\) comparisons. Let \(\widetilde G\) assemble the block empirical means of \(YY^\top\), with off-diagonal blocks reflected across the diagonal. It is unbiased for the sign moment matrix \(G\) of Section 9.2. Its operator error obeys
\[
 \mathbb E\|\widetilde G-G\|_{\rm op}^2\le C_{a,b}d/N .
\tag{30}
\]
For a unit vector \(u\), decompose \(u\) into blocks \(u_A\). The contribution of any pair \(A,D\) to its error quadratic form is a batch average of centered products of sign linear forms, weighted by a factor two for distinct blocks. Each product is subexponential with scale at most \(C_{a,b}\|u_A\|_2\|u_D\|_2\) by the sub-Gaussian result of Section 9.2 and Cauchy–Schwarz on the exponential moments. For the sum of the independent weighted observations, the Bernstein variance parameter is bounded by
\[
 C_{a,b}N^{-1}\sum_{A,D}\|u_A\|_2^2\|u_D\|_2^2=C_{a,b}/N
\]
and its maximum scale by \(C_{a,b}/N\). Apply a sphere net and integrate (21) with \(N\) in place of \(n_0\), which proves (30) since \(N\gtrsim d\).

The assembled matrix need not be positive semidefinite. Before the sine inversion choose a nearest correlation matrix to it in operator norm, over the compact set of positive semidefinite matrices with unit diagonal. Since \(G\) is feasible, this at most doubles the operator error. The measured sign histories in this stage have finitely many possibilities, so any fixed tie resolution gives a measurable estimator. Apply the Schur-series bound (22) to the projected matrix and \(G\).

To estimate diagonal ratios, use the two homogeneous signs \(X_j\pm X_0\) for every non-reference index in one block, with separate batches of \(\asymp n/J\) observations across blocks. This again uses no more than \(2r\) comparisons per observation. Estimate the corresponding probabilities by their empirical frequencies. Their maximum squared error has expectation \(O(J\log(d+1)/n)\) by Hoeffding's inequality and a union bound. This is at most \(C dJ^2/n\). The Cauchy inversion from Section 9.2 combines these frequencies with the estimated correlations to obtain the variance ratios. Assemble the normalized shape estimate and clip its eigenvalues exactly as before. Equations (22) and (30) give
\[
 \mathbb E\|\widehat P-P\|_{\rm op}^2
  \le C_{a,b}\min\{1,d^3/(nq^2)\}.
\tag{31}
\]

### 10.4. Combine shape and scale

Conditional on the shape pilot, form \(W=\widehat P^{-1/2}X\) and run the randomized comparisons of Section 9.3 in just the first \(q\) coordinates of \(W\). Use the reference coordinate and \(q-1\) Gaussian auxiliary projections in the span of the other selected coordinates. All the information for this operation lies in the corresponding principal submatrix of the residual covariance \(A\), whose deviation from \(I\) in operator norm is bounded by the same \(C_{a,b}\|\widehat P-P\|_{\rm op}\). Unit normalization still enforces the physical offset budget, and there are \(q\le K\) comparisons. The regression argument uses only this restricted covariance. Equations (23)–(26) therefore hold with \(q-1\) in place of \(m=d-1\), while the shape matrix and its error bound retain their original dimension. If \(q\) is bounded by the fixed threshold required for the central-rank argument, use the two parallel cuts as in Section 9.3. For \(d=1\) this also applies directly, with shape equal to one. In all cases, the squared scale error is bounded by a constant times
\[
 \min\{1,d^3/(nq^2)+(nB)^{-2}+(nB\sqrt q)^{-1}\}.
\]
Combine it with (31), using \(\|\widehat P-P\|_F^2\le d\|\widehat P-P\|_{\rm op}^2\) and the same spectral caps. The resulting covariance risk achieves (27). Taking \(q=d\) recovers Theorem 4, with \(d\) signs per sample sufficient in dimensions at least two.

## 11. Relation to prior quantized estimation

Dirksen, Maly and Rauhut establish both a scale-invariant coordinate-sign result for centered Gaussian correlation matrices and a general covariance result based on two independently dithered signs per coordinate. Their full-covariance theorem uses dithering amplitude tied to the largest variance. The present constraints apply pathwise to the total absolute offsets and also bound the number of comparisons. We determine the optimal joint effect of both resources in an isotropic covariance model and separate scalar calibration from shape estimation for arbitrary centered covariances with bounded spectrum. The upper bound uses one nonzero offset and homogeneous comparisons involving several coordinates of the same sample. The matching adaptive-design lower bound identifies the role of their linear span. The bounded-location extension estimates the same scale with an unknown location in every coordinate. The centered full-covariance result estimates shape through homogeneous measurements before applying a separate offset comparison. For $K\ge2$, the shape term has the factor $d^2/\min(K,d)^2$ relative to full observation before the overall risk cap. The offset budget determines the separate scale term in this regime. For $K=1$, Theorem 5 gives a different result with an offset penalty for the whole covariance. [Dirksen, Maly and Rauhut, Annals of Statistics 50(6), author version Theorems 1 and 4](https://doi.org/10.1214/22-AOS2239)

Azizyan, Krishnamurthy and Singh established the squared compression-dimension penalty in covariance estimation from real-valued projections onto uniformly random subspaces. Their proof controls the Kullback–Leibler divergence for a fixed random design and gives spectral- and entrywise-norm lower bounds. The same dimension penalty appears for shape in (27), even with simultaneous sign outputs and adaptive choice of subspaces. The shape lower bound here controls the trace of the Fisher information conditionally on each design and gives a squared Frobenius conclusion. The separate scale terms and the one-comparison offset penalty reflect the further restriction to affine signs. [Azizyan, Krishnamurthy and Singh, IEEE Transactions on Information Theory 64(12), author version Corollary 1, Theorems 3–4 and Lemma 3](https://doi.org/10.1109/TIT.2018.2871077)

Xiao et al. analyze Gaussian covariance recovery from coordinate signs at specified nonzero and time-varying cutoffs. Their Theorem 1 derives the pointwise asymptotic MSE of a likelihood estimator through the inverse Fisher information. Dirksen and Maly also use data-driven dithering of coordinate signs and obtain general subgaussian covariance bounds up to logarithms. Equation (27) determines the uniform risk as the number and total absolute offset of the affine comparisons vary. For two or more comparisons the design learns shape from homogeneous signs and calibrates scale through one small offset per scale observation. With one comparison, all variance measurements use nonzero offsets. [Xiao et al., IEEE Transactions on Signal Processing 71](https://doi.org/10.1109/TSP.2023.3325664) · [Dirksen and Maly, IEEE Transactions on Information Theory 70(7), author version Sections 2.1–2.2](https://doi.org/10.1109/TIT.2024.3358994)

Barnes, Han and Özgür derive Fisher-information lower bounds for distributed experiments with unrestricted finite-alphabet encoders, including Gaussian models with a communication budget. Encoding an unrestricted real-valued sample into \(K\) bits and observing \(K\) simultaneous affine signs are distinct experiments. In our setting the lower bound also uses the offset budget and the smaller of linear and quadratic testing distances. [Barnes, Han and Özgür, Journal of Machine Learning Research 21(236)](https://jmlr.org/papers/v21/19-737.html)

Kumar and Vatedka study scalar location estimation with unknown scale from a single communicated bit per user. Their location-scale procedures use different scalar thresholds in different groups and the adaptive procedure can center thresholds using the first-stage location estimate. The \(K=1\) upper bound here uses the same basic inversion of two normal cdf values. The comparison-count transition begins with two jointly observed signs on one sample. The higher-dimensional rate and the bounded-location calibration use a single sample's count and offset bit together. [Kumar and Vatedka, Transactions on Machine Learning Research, 2026](https://openreview.net/forum?id=g95C4zIEPg) · [Author version](https://arxiv.org/abs/2501.18502)

The log-concavity argument for the direction-revealed comparison in Section 4 uses the marginal log-concavity theorem of Prékopa. The finite-array location argument instead uses explicit calibration of order statistics and their sensitivity to independent coordinate shifts. [Prékopa, Acta Scientiarum Mathematicarum 34, 335–343, 1973](https://acta.bibl.u-szeged.hu/14411/)
