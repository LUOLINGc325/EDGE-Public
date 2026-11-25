---
title: "Exact finite-power prediction with corrupted smooth feedback"
subtitle: "A sharp Lipschitz bound and eventual equality for every fixed Sobolev exponent"
lang: en
geometry: margin=1in
fontsize: 11pt
---

## Abstract

A learner predicts an unknown one-dimensional function from sequential queries when a known finite number of reported values can be arbitrary. Loss is measured against the true function, and the initial observations are unscored. We prove that for every corruption budget \(\eta\) and every finite power \(p\ge2\), the exact minimax total loss for \(1\)-Lipschitz functions is \(2\eta+1\). The learner uses a midpoint of two order-statistic Lipschitz envelopes. Every truthful observation reduces an integrated potential by at least its squared prediction error. The potential gives a location-sensitive pathwise bound and extends to general moduli of continuity. For every fixed finite Sobolev exponent above one, a version-space learner attains the same exact value at all sufficiently large finite powers. The proof isolates the largest errors and uses near-affinity of the remaining feasible targets. An independent midpoint perturbation prevents equality below power two for these finite derivative exponents. A dyadic ramp construction gives a quantitative lower bound as the Sobolev exponent approaches one.

## 1. Model and exact theorem

Fix an integer \(\eta\ge0\), and let \(k=2\eta+1\). At round \(t\) the learner receives \(x_t\in[0,1]\), predicts \(\widehat y_t\), and sees a report \(z_t\). A single fixed target \(f\) satisfies \(z_t=f(x_t)\) except at at most \(\eta\) rounds. Values on corrupted rounds may be arbitrary. Queries may repeat. The loss after a warmup of \(w\) unscored rounds is the sum of \(|\widehat y_t-f(x_t)|^p\) over scored rounds. The horizon can be any finite value, and the additive constant of \(f\) is unrestricted.

Write \(V_{p,\eta,w}(\mathcal F)\) for the minimax total loss over this model for deterministic learners. The expected-loss formulation for randomized learners takes the same supremum after expectation over the learner's randomness. Our upper bounds hold on each admissible trajectory, and our lower bounds use distributions over fixed admissible instances.

**Theorem 1.** Let \(\mathcal F_\infty\) be the \(1\)-Lipschitz functions on \([0,1]\). For every \(w\ge k\) and every finite real \(p\ge2\),
\[
V_{p,\eta,w}(\mathcal F_\infty)=2\eta+1 .
\]
The same value holds for randomized expected loss. If \(0\le w<k\), the minimax value is infinite for every finite \(p\ge1\), for both types of learner.

The archived precursor proves that the noisy minimax value approaches \(2\eta+1\) as \(p\) tends to infinity at fixed Sobolev exponent, and asks whether equality already holds over a finite range of \(p\). Theorem 1 gives such a range for the Lipschitz endpoint. Theorem 2 resolves the finite-power equality question for every fixed derivative exponent above one. Fixed precursor, §7

## 2. The order-statistic envelope learner

Let \(h=\eta+1\). From all earlier reports, define \(U(x)\) as the \(h\)-th smallest of \(z_i+|x-x_i|\), and \(L(x)\) as the \(h\)-th largest of \(z_i-|x-x_i|\). Count repeated observations separately. Predict \((U(x_t)+L(x_t))/2\) at each scored round.

Every truthful upper cone is at least \(f(x)\), and every truthful lower cone is at most \(f(x)\). Thus at most \(\eta\) cones violate either inequality, and \(L(x)\le f(x)\le U(x)\). Each order statistic is \(1\)-Lipschitz because every entry has that modulus and coordinatewise perturbation by at most \(d\) changes an order statistic by at most \(d\). Take any \(h\) truthful warmup indices \(H\). Then
\[
\begin{aligned}
U(x)-L(x)
&\le \max_{i,j\in H}\big(f(x_i)-f(x_j)+|x-x_i|+|x-x_j|\big)\\
&\le \max_{i,j\in H}\big(|x_i-x_j|+|x-x_i|+|x-x_j|\big)
\le 2 .
\end{aligned}
\]
The last sum equals twice the span of three points on \([0,1]\). In particular the prediction error \(e_t=|\widehat y_t-f(x_t)|\) never exceeds one. The warmup supplies at least \(h\) truthful points because \(w\ge2\eta+1\).

For the analysis only, define nonnegative slacks at each location \(x\):
\[
u_i(x)=(z_i+|x-x_i|-f(x))_+,\qquad
l_i(x)=(f(x)-z_i+|x-x_i|)_+ .
\]
Let \(\Psi\) be the integral over \([0,1]\) of the sum of the \(h\) smallest upper slacks and the sum of the \(h\) smallest lower slacks. Inserting any report can only decrease \(\Psi\). The \(h\)-th smallest upper slack is \(U(x)-f(x)\), since clamping at zero commutes with taking that order statistic and the raw value is nonnegative. The corresponding lower value is \(f(x)-L(x)\).

Let \(\Psi_{\mathrm{warm}}\) be the potential just after warmup. Using the truthful subset \(H\) as an upper bound for both sums gives
\[
\Psi_{\mathrm{warm}}\le\sum_{i\in H}\int_0^1 2|x-x_i|\,dx
=\sum_{i\in H}\big[x_i^2+(1-x_i)^2\big]\le h. \qquad\text{(1)}
\]
The inequality holds for every such \(H\), so it automatically improves when enough truthful warmup inputs are in the interior.

## 3. Charging a truthful prediction

Consider a scored query at \(x_0\) with true report \(f(x_0)\). Put \(a=U(x_0)-f(x_0)\) and \(b=f(x_0)-L(x_0)\), so the error is \(e=|a-b|/2\). Choose the larger side. Suppose it is the upper side, with \(a\ge2e\). For any \(x\), let \(d=|x-x_0|\). The newest upper slack is \(f(x_0)+d-f(x)\), which is nonnegative. Inserting a new number into the list of upper slacks decreases the sum of the \(h\) smallest by the positive part of the difference between the old \(h\)-th smallest and that new number. Here that difference is
\[
[U(x)-f(x)]-[f(x_0)+d-f(x)]=U(x)-f(x_0)-d\ge a-2d.
\]
The same proof with lower envelopes applies when \(b\) is larger. Therefore the potential drop at this round is at least
\[
\int_0^1(2e-2|x-x_0|)_+\,dx\ge e^2. \qquad\text{(2)}
\]
For the last inequality, the integral of any nonnegative decreasing function of distance from \(x_0\) is smallest at an endpoint: splitting the integral at \(x_0\) yields the sum of the integrals over \([0,x_0]\) and \([0,1-x_0]\). The endpoint integral in this case is \(\int_0^e(2e-2x)\,dx=e^2\), using \(e\le1\).

Sum (2) over truthful scored rounds. Other insertions have nonnegative potential drop. Hence the sum of squared truthful prediction errors is at most (1). There are at most \(\eta\) corrupted scored rounds, each with error at most one. Since \(e^p\le e^2\) for \(p\ge2\) and \(0\le e\le1\), the total loss is at most \(h+\eta=k\). This also proves the sharper pathwise bound given by (1) plus the number of corrupted scored rounds.

For the lower bound, use the two-target sign construction of Xie. Make all \(w\) warmup queries at zero, with zero reports. Then make \(k\) scored queries at one. The first \(\eta\) scored reports are \(-1\), the next \(\eta\) are \(+1\), and the last report reveals the true value. The two targets are \(f_\pm(x)=\pm x\). There are exactly \(\eta\) corruptions under either target, and every one of the \(k\) predictions is made from a sign-independent transcript. Under an independent uniform sign, the mean \(p\)-power loss of each prediction is at least one by convexity. This remains valid conditional on the learner's random choices. Some fixed target therefore forces expected total loss at least \(k\).

If \(w\le2\eta\), use two constant targets with values \(-M,+M\), all queried at the same point. The warmup reports may be split between the two values so that each occurs at most \(\eta\) times. Both targets are admissible under the same warmup, and the first scored prediction incurs average expected loss at least \(M^p\) over the two targets. All subsequent reports can be truthful. Letting \(M\to\infty\) shows the claimed warmup obstruction.

## 4. A bound for a general modulus of continuity

Let \(\nu:[0,\infty)\to[0,\infty)\) be nondecreasing and subadditive, with \(\nu(0)=0\) and \(\nu(1)=1\). Assume the target satisfies \(|f(x)-f(y)|\le\nu(|x-y|)\). Use this modulus in the prediction cones and the slack potential. The associated distance obeys the triangle inequality. Each cone has modulus \(\nu\) and so do the order statistics. On any query both side gaps \(U-f\) and \(f-L\) are at most two, by comparison with an \(h\)-element truthful warmup set, so the midpoint error is at most one.

The sum of the trimmed slacks just after warmup is bounded pointwise by \(2\sum_{i\in H}\nu(|x-x_i|)\). The same subtraction of the newest genuine slack as above gives a pointwise decrease at least \((2e_t-2\nu(|x-x_t|))_+\) on the larger side. Telescope these decreases at each \(x\), then integrate their lower bound and the warmup upper bound. This only integrates functions of the modulus and the observed locations, so no separate measurability property of the class of targets is needed. The integral of increasing functions of distance is largest at an endpoint, and the integral of decreasing functions of distance is smallest there. Therefore
\[
\sum_{\text{truthful scored }t}
\int_0^1 (2e_t-2\nu(s))_+\,ds
\ \le\ 2h\int_0^1\nu(s)\,ds . \qquad\text{(3)}
\]
For \(\nu(s)=s^\alpha\) with \(0<\alpha\le1\), the integral on the left is \(2\alpha e_t^{\,1+1/\alpha}/(1+\alpha)\). Thus for \(p\ge1+1/\alpha\) the total loss is at most \(h/\alpha+\eta\). The derivative constraint \(\|f'\|_q\le1\) supplies this modulus with \(\alpha=1-1/q\) by Hölder's inequality. The Lipschitz theorem uses \(\alpha=1\), for which the potential and the two-target lower bound match.

## 5. Exact finite powers at every fixed Sobolev exponent

For \(1<q<\infty\), let \(\mathcal F_q\) consist of absolutely continuous real functions with \(\int_0^1|f'|^q\le1\). Set \(\alpha=1-1/q\).

**Theorem 2.** For every fixed \(1<q<\infty\) and \(\eta\ge0\), there is a finite explicit \(p_*(q,\eta)\) such that
\[
V_{p,\eta,w}(\mathcal F_q)=2\eta+1
\qquad(w\ge2\eta+1,\ p\ge p_*(q,\eta)).
\]
The same holds in randomized expected loss. Together with Theorem 1, this gives an exact finite-power range at every fixed exponent \(1<q\le\infty\).

Use a different learner in this section. At every scored query, form the class of all \(g\in\mathcal F_q\) agreeing with all but at most \(\eta\) previous reports. Predict the midpoint of the smallest and largest possible value of \(g(x_t)\). The class includes the true function. The rule is finite: enumerate subsets of at most \(\eta\) excluded reports. Within each retained subset, discard it if repeated locations have conflicting labels. For a tentative query value, the least possible derivative energy equals the sum of \(|\Delta y|^q/|\Delta x|^{q-1}\) over consecutive distinct constrained locations. Hölder's inequality gives this lower bound, and piecewise-affine interpolation, constant outside the extreme locations, attains it. Thus each retained subset gives an empty set, a fixed value, or a compact interval of possible values at the query. At least one prior report is retained, so the possible query values are bounded and both extremes are attained. This defines a deterministic online rule without requiring an efficient implementation.

**A uniform moment bound.** For \(t\ge k\), let \(r_t\) be the \(k\)-th nearest distance from the query to previous observations, with multiplicity. Any two feasible candidates share a report among the \(k\) nearest, because each excludes at most \(\eta\). Hölder's inequality bounds their difference at the query by \(2r_t^\alpha\). The midpoint error thus satisfies \(e_t\le r_t^\alpha\le1\).

Choose \(p_0=2/\alpha\) and \(M=3k/2\). The geometric estimate of the precursor gives \(\sum_t e_t^{p_0}\le M\). Here is the squared-distance calculation for completeness. For the ordinary nearest predecessor, the sum of squared lengths of consecutive gaps increases by \(d^2\) on a hull extension of distance \(d\). An interior insertion dividing a gap into two lengths \(u,v\) decreases it by \(2uv\ge2\min(u,v)^2\). The hull extensions have total length at most one, so their squared sum is at most one, and the total interior squared nearest distances is at most one half. For rank \(k\), color the first \(k\) observations distinctly, and color each next observation with a color absent from its \(k-1\) closest previous observations. Its ordinary nearest distance in its color is then at least \(r_t\). Sum over the \(k\) colors to get \(\sum_t r_t^2\le3k/2\). The estimate includes all later observations even if some are unscored. It suffices below to prove the result with exactly \(k\) warmup observations, because further unscored rounds can be included in the analysis of the same algorithm.

**Isolation of near-unit errors.** Consider a finite horizon with at least \(k\) scored rounds, select its \(k\) largest errors, and write \(1-\delta\) for the least selected error, breaking ties arbitrarily. Assume for now that \(\delta\) is sufficiently small, and put \(\varepsilon=1-(1-\delta)^{1/\alpha}\). Let \(I_{\mathrm L}=[0,\varepsilon]\), \(I_{\mathrm R}=[1-\varepsilon,1]\). Each selected query has \(r_t\ge1-\varepsilon\) and must be in one of these bands. For a selected query in the left band, at most \(k-1\) previous observations can lie outside the right band, since each such distance is strictly below \(1-\varepsilon\). The analogous statement holds for a selected right query.

Suppose \(\ell\) of the \(k\) warmup points are in the left band and \(r\) in the right. The last selected left query, if present, gives that the total number of selected left queries is at most \(r\): all \(k-r\) warmup points outside the right band, plus every earlier selected left query, count against its \(k-1\) allowance. The same reasoning bounds the number of selected right queries by \(\ell\). Since the two selected counts sum to \(k\), all warmup points lie in the bands, the selected left count is \(r\), and the selected right count is \(\ell\). The allowance at the last selected left query is exactly saturated by the warmup and earlier selected queries. Thus every other scored query before it lies in the right band, and the reflected statement holds at the last selected right query. These two facts imply that every unselected query before the final selected time is in a band that already contains \(k\) previous observations. If one band has no selected queries, that band already had all \(k\) warmup observations. Otherwise no unselected query can precede both last selected times, and the band whose last selected time occurs first has acquired its \(k\) observations. This proves
\[
e_t\le\varepsilon^\alpha
\quad\text{for all unselected scored times before the final selected time}.
\qquad\text{(4)}
\]
After the final selected time both bands contain at least \(k\) previous observations.

**Near-affinity after the last selected time.** At one selected time the midpoint rule implies that some then-feasible \(g\) differs from the true \(f\) at that query by at least \(2(1-\delta)\). They share at least one of the first \(k\) reports, say at \(y\). Since \(|g(x_t)-g(y)|\le1\),
\[
|f(x_t)-f(y)|\ge1-2\delta .
\]
The two inputs must lie in opposite endpoint bands of width \(\widetilde\varepsilon=1-(1-2\delta)^{1/\alpha}\). For sufficiently small \(\delta\), this gives
\[
|f(1)-f(0)|\ge1-2\delta-2\widetilde\varepsilon^\alpha .
\]
Choose a sign \(\sigma\) orienting this endpoint difference. After the final selected time, every still-feasible \(g\) shares a report with \(f\) in each of the two bands of width \(\varepsilon\), by the \(k\)-observation count. Hence \(|g(0)-f(0)|\le2\varepsilon^\alpha\) and \(|g(1)-f(1)|\le2\varepsilon^\alpha\). It follows that both \(u=\sigma f'\) and \(u=\sigma g'\) satisfy
\[
\int_0^1 |u|^q\le1,\qquad
\int_0^1 u\ge1-\tau,\qquad
\tau=2\delta+2\widetilde\varepsilon^\alpha+4\varepsilon^\alpha .
\]

A quantitative form of rigidity for Hölder's inequality gives
\[
\|u-1\|_1\le C_q\sqrt{\tau}\qquad(0\le\tau\le1).
\]
To prove it, set \(J(t)=|t|^q-1-q(t-1)\). The integral of \(J(u)\) is at most \(q\tau\). For \(|t-1|\le1/2\), Taylor's theorem gives \(J(t)\ge c_q|t-1|^2\), where \(c_q=\tfrac12 q(q-1)\min\{(1/2)^{q-2},(3/2)^{q-2}\}\). Outside this range, convexity from \(t=1\) gives \(J(t)\ge(c_q/2)|t-1|\). Split the integral over the two ranges and use Cauchy–Schwarz. One can take \(C_q=\sqrt{q/c_q}+2q/c_q\).

Comparing \(f,g\) with their respective oriented affine functions now gives
\[
\|g-f\|_\infty\le2\varepsilon^\alpha+2C_q\sqrt{\tau}.
\]
The same bound controls the midpoint error. Since \(\varepsilon\le\delta/\alpha\) and \(\widetilde\varepsilon\le 2\delta/\alpha\), one has \(\tau\le K_q\delta^\alpha\), where \(K_q=2+2(2/\alpha)^\alpha+4(1/\alpha)^\alpha\). Combining this estimate with (4), every unselected error is at most \(D_q\delta^{\alpha/2}\), for example with \(D_q=2(1/\alpha)^\alpha+2C_q\sqrt{K_q}\). This also holds at \(\delta=0\), when the geometric bands are their endpoints and the rigidity inequality forces exact affinity.

**Summation and an explicit power threshold.** Set \(\delta_0=\min\{\alpha/8,(2K_q)^{-1/\alpha},(2D_q)^{-2/\alpha}\}\). Then \(\delta_0<\alpha/4\), \(K_q\delta_0^\alpha<1\), and \(D_q\delta_0^{\alpha/2}\le1/2\). It suffices to take
\[
p_*(q,\eta)=p_0+
\max\left\{\frac2\alpha,\ \log_2(M/\delta_0),\
\frac{\log M}{-\log(1-\delta_0)}\right\}. \qquad\text{(5)}
\]
If a horizon has fewer than \(k\) scored queries, its loss is at most \(k\). If fewer than \(k\) errors are at least \(1-\delta_0\), their contribution is at most \(k-1\), and the others contribute at most \(M(1-\delta_0)^{p-p_0}\le1\). Otherwise select the top \(k\) with \(\delta\le\delta_0\) as above. Their contribution is at most \(k-1+(1-\delta)^p\), and the rest contribute at most
\[
M(D_q\delta^{\alpha/2})^{p-p_0}\le\delta .
\]
Indeed \(D_q\delta_0^{\alpha/2}\le1/2\), \(M2^{-(p-p_0)}\le\delta_0\), and \(\alpha(p-p_0)/2\ge1\). Since \((1-\delta)^p\le1-\delta\), the total is at most \(k\). This proves the upper bound uniformly over finite horizons. The two-sign lower bound in Section 3 uses \(f(x)=\pm x\), which lie in every \(\mathcal F_q\), finishing the theorem.

## 6. Two obstructions for finite Sobolev exponents

Let \(\mathcal F_q\) consist of absolutely continuous real functions with \(\int_0^1|f'|^q\le1\), for \(1<q<\infty\). Assume \(w\ge k\). The following are lower bounds for randomized expected loss and hence for deterministic loss as well.

**An interior bit at a nearly saturated endpoint.** For every \(1\le p<2\),
\[
V_{p,\eta,w}(\mathcal F_q)>k. \qquad\text{(6)}
\]
The same strict conclusion holds at \(p=2\) if \(q-1<1/(4k)\). To prove this, fix \(c>0\) with \(2(q-1)c^2<1\). Set \(a=1-\delta\), \(b=c\sqrt\delta\) with \(\delta>0\) small. Draw independent uniform signs \(\sigma,\tau\). Take the piecewise-affine target with endpoint values \(0,\sigma a\) and midpoint value \(\sigma a/2+\tau b\). For small \(\delta\) one has \(a>2b\), and its derivative energy is
\[
\frac{(a+2b)^q+(a-2b)^q}{2}
=1+q[\,2(q-1)c^2-1\,]\delta+O_q(\delta^{3/2})<1 .
\]
For each fixed \(c,q\) this follows by Taylor expansion at one. No derivative crosses zero for small \(\delta\).

Use the same warmup and \(k\) endpoint queries as in the lower bound for Theorem 1, with reports \(-a,+a\), and reveal the actual endpoint on the last. Add one truthful query at \(1/2\). The phase of the midpoint perturbation \(\tau\) is independent of the transcript before this query. The total average loss is at least \(k(1-\delta)^p+c^p\delta^{p/2}\) by symmetry and convexity. When \(p<2\), the added term dominates the decrement of order \(\delta\). At \(p=2\), choose \(c^2\) strictly between \(2k\) and \(1/[2(q-1)]\) when \(q-1<1/(4k)\). Then the bound strictly exceeds \(k\) for small positive \(\delta\). The targets and transcripts were sampled in advance.

**A dyadic ramp as \(q\) approaches one.** For every finite \(p\ge1\),
\[
V_{p,\eta,w}(\mathcal F_q)\ \ge\
\sup_{D\in\mathbb Z_{\ge0}}\ 2^{-(1-1/q)pD}(k+D\,2^{-p}). \qquad\text{(7)}
\]
For a fixed \(D\), put \(\ell=2^{-D}\), and choose a depth-\(D\) dyadic interval uniformly. The target is zero to its left, affine across it up to \(\sigma H\), and constant thereafter, with \(H=\ell^{1-1/q}\) and an independent uniform sign \(\sigma\). Its derivative energy equals one. First use the \(k\) sign-ambiguous endpoint queries of height \(H\) after the warmup and reveal the sign at the last report. Next locate the ramp using \(D\) truthful midpoint queries that bisect the current possible dyadic block. At each such query its value is either zero or \(\sigma H\) with equal probabilities conditional on the previous transcript. The bisection point never lies strictly inside a possible depth-\(D\) interval. The resulting lower bound is \(kH^p+D(H/2)^p\). Taking the supremum proves (7).

In particular \(V_{p,\eta,w}(\mathcal F_q)\) diverges as \(q\downarrow1\) for every fixed finite \(p\ge1\). For \(\alpha=1-1/q\), choosing \(D=\lfloor1/(p\alpha\log 2)\rfloor\) gives
\[
\liminf_{q\downarrow1}\alpha V_{p,\eta,w}(\mathcal F_q)\ \ge\ 
\frac{2^{-p}}{e\,p\log 2}.
\]
This lower bound and (6) use different target families. They give restrictions on extending the exact Lipschitz plateau to finite derivative exponents.

## 7. Sources and verification

Weian Xie, *Worst-case Error Bounds for Online Learning of Smooth Functions*, COLT 2026, PMLR 336, 6858–6884. The archived source record locates the model in Section 1.4, the original two-target lower bound in Section 4 and Appendix D.3, and the discussion of precise noisy-model values in Section 5. The numbered large-power conjecture belongs to the earlier preprint arXiv:2502.16388v1. [Official conference record](https://proceedings.mlr.press/v336/xie26a.html)

The fixed precursor obtains the large-power limit via nearest-reported-label medians and sharp geometric nearest-predecessor energy. Here the reported labels are first shifted by distance, then trimmed on each side. The new ingredient is the drop of an integrated sum of trimmed slacks. The integrated analysis gives the exact Lipschitz minimax value for \(p\ge2\) and the general-modulus bound (3). The geometric isolation and stability argument extends exact finite-power equality to every fixed Sobolev exponent above one. The complementary lower bounds describe restrictions on that range. The audit is restricted to the fixed repository archive and its documented source checks. The independent review and exact rational trajectory checks accompany this manuscript. Lean verification is tracked separately.
