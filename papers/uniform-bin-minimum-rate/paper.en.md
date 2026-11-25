---
title: 'An order \(1/n\) horizon bound for record-constrained prophet inequalities'
fontsize: 11pt
geometry: margin=1.1in
abstract: |
  A known-law online selector may accept one observation only at a running record. We compare optimal selection in a marked Poisson process and in the independent minima of its equal time bins. The two models have exactly the same prophet payoff. Uniformly over all decreasing mark rewards with finite prophet expectation, the two optimal rewards differ by at most \((2+1/e)/n\) times that expectation. A two-level reward gives a positive first-order gap. The comparison identifies the global worst-case weak-record ratio with a finite-rate Poisson infimum and improves the horizon error to order \(1/n\). Combined with the existing active-quantile linear programs, it gives certification with \(O(\varepsilon^{-2}\log(1/\varepsilon))\) variables and constraints.
---

## 1. Model and results

Let \(X_1,\ldots,X_n\) be independent draws from a known nonnegative law \(F\). An online selector may accept at most one draw and may accept \(X_i\) only when \(X_i\ge \max_{j<i}X_j\). Never accepting yields zero. Strategies may observe the whole past and randomize. For laws with positive finite \(P_n(F)=\mathbb E\max_i X_i\), denote the optimal expected online reward by \(V_n^{\mathrm{weak}}(F)\) and put
\[
c_n=\inf_F \frac{V_n^{\mathrm{weak}}(F)}{P_n(F)},
\qquad c_*=\inf_{n\ge1} c_n.
\]
A prior manuscript [1] proves an explicit horizon bound of order \((\log n)^3/n\) and an effective all-horizon certificate. Its comparison discards the remaining attempt when the Poisson and Bernoulli slots first have different active counts. Here the discrete observations are the bin minima of the Poisson process. This shares the prophet pathwise and gives a comparison without imposing a rarity cutoff in the horizon bound.

Fix \(R>0\) and a nonnegative nonincreasing Borel payoff \(w\) on \((0,R)\). Observe a Poisson process of intensity \(dt\,dx\) on \([0,1]\times(0,R)\). A selection is legal only at a mark strictly smaller than all earlier marks, so smaller marks are better. The optimal causal reward is \(V_R(w)\). Partition time into \(n\) consecutive bins of length \(h=1/n\). In the discrete model, reveal each bin's smallest mark, or an empty symbol, at its decision time. An allowed selection must be a new smallest nonempty mark. Write \(D_{n,R}(w)\) for its optimal reward. Empty bins and failure to select pay zero. Both prophets receive the maximum reward across the original points, taking zero if there are no points, with mean
\[
P_R(w)=\int_0^R w(x)e^{-x}\,dx.
\]
Throughout, \(0<P_R(w)<\infty\).

**Theorem 1 (shared-prophet comparison).** If \(n\ge2\), then for every integer \(1\le m<n\),
\[
0\le \frac{D_{n,R}(w)-V_R(w)}{P_R(w)}
\le \frac{h}{2e(1-mh)}
  +h\left(\frac{1}{mh}-1\right).
\tag{1}
\]
In particular the gap is at most \((2+1/e)/n\), using \(m=\lfloor n/2\rfloor\). This last bound also holds at \(n=1\). The profile-uniform order \(1/n\) is sharp.

**Theorem 2 (worst-case ratio and certification).** Let \(\beta_R=\inf_w V_R(w)/P_R(w)\) in the finite-rate model. Then
\[
c_*=\inf_{R>0}\beta_R,\qquad
0\le c_n-c_*\le\frac{2+1/e}{n},\qquad
0\le\beta_R-c_*\le e^{-R}.
\tag{2}
\]
For any rational \(0<\varepsilon<1\), two finite rational linear programs give an interval of width at most \(\varepsilon\) enclosing \(c_*\). Their numbers of variables and constraints are \(O(\varepsilon^{-2}\log(1/\varepsilon))\). This count concerns the formulations. A certificate may use exact optima, or suitably certified conservative bounds on their optima.

## 2. Coupling the optimal values

### 2.1. Each minimum summarizes a bin for the prophet

The full minimum, if present, has subprobability density \(e^{-x}\,dx\) on \((0,R)\), giving the stated prophet formula. Similarly the minimum of one bin has density \(h e^{-hx}\,dx\) there and an empty atom of mass \(e^{-hR}\). Bins are independent.

A discrete selector can simulate a given Poisson selector. For each observed nonempty minimum \(x\), generate a uniform time within that bin for the minimum, and independent Poisson points in that bin with marks greater than \(x\). This is the conditional law given the minimum. For example, it follows by expanding the bin as a Poisson number of independent uniform points, then conditioning on their smallest mark. Generate bins sequentially. If the simulated selector accepts mark \(y\) in a bin, accept its true minimum \(x\le y\). The simulated acceptance was a record, so \(y\), and hence \(x\), beats all preceding bin minima. The selection is legal and its payoff is at least \(w(y)\). Applying this to any admissible Poisson selector proves \(D_{n,R}(w)\ge V_R(w)\).

### 2.2. An optimal discrete policy has one mark threshold per slot

Write \(W_k(x)\) for the optimal discrete continuation value with \(k\) bins left and previous smallest mark \(x\). Use \(x=R\) before the first nonempty bin. One-step conditioning gives the finite-horizon Bellman recursion. At a new record \(x\), acceptance is optimal with \(k\) future bins precisely when \(w(x)\ge W_k(x)\), with either action optimal at equality. At an ineligible mark the strategy must continue. Bellman comparisons are measurable by induction, cover every full-history randomized policy by conditional expectation, and yield deterministic attainment.

The function \(W_k(x)\) is nondecreasing in \(x\). From a looser initial state, emulate a tighter state's policy on the same future marks, keeping its hypothetical threshold. The real running minimum is always at least the hypothetical one, so every hypothetical acceptance is legal. Also \(W_k(x)\) is nondecreasing in \(k\), since a policy can use the first \(k\) bins of a longer horizon and forgo every later choice. Consequently the acceptable new marks, when \(k\) bins will remain, are an initial interval of \((0,R)\). Choose the policy with this decision rule. The right endpoint may be used as a cutoff because the mark distributions have densities.

At every acceptable \(x\), all future records \(y<x\) are acceptable when seen. Indeed their continuation values are at most \(W_k(x)\), whereas \(w(y)\ge w(x)\). After declining \(x\), the optimal continuation therefore accepts the first bin minimum below \(x\), if one occurs. This proves, for acceptable \(x\),
\[
W_k(x)=(1-e^{-khx})A_h(x),\qquad
A_h(x)=\frac{h\int_0^x w(y)e^{-hy}\,dy}{1-e^{-hx}}.
\tag{3}
\]
Before bin \(i\), let \(C\) be the smaller of the previous running minimum and the slot's acceptance cutoff, using \(R\) for a missing previous minimum. Conditional on reaching this bin, the discrete rule accepts exactly if the bin minimum is below \(C\). If \(C>0\), then the preceding inequality \(w(x)\ge W_k(x)\) holds for \(0<x<C\), where \(k=n-i\). By (3) and continuity of its integral at \(C>0\),
\[
w(C-)\ge (1-e^{-khC})A_h(C).
\tag{4}
\]
Left limits accommodate jumps and \(C=R\). The expected block contribution is zero when \(C=0\).

### 2.3. The first qualifying mark loses at most order \(1/n\)

Define a Poisson selector using the same cutoffs. In the current bin, it accepts the first mark \(x<C\), if any. Such a mark beats all previous bin minima and all earlier marks in the bin. If no qualifying mark arrives, track the actual bin minimum before the next bin. Under the joint construction the Poisson strategy and deterministic discrete strategy stop in the same bin, if either stops.

Conditional on the preceding bins and a positive \(C\), the discrete accepted mark and the Poisson accepted mark have subprobability densities on \((0,C)\)
\[
h e^{-hx}
\qquad\text{and}\qquad
\frac{1-e^{-hC}}{C},
\tag{5}
\]
respectively. Their masses agree. Let \(S(C)=h\int_0^C w(x)e^{-hx}\,dx\) and let \(\mathcal L_h(C)\) be the expected discrete payoff less the expected Poisson payoff in this bin, without conditioning on acceptance. The Poisson density is at least \((1-hC/2)\) times the discrete density, since \(1-e^{-u}\ge u-u^2/2\) for \(u\ge0\). For a nonnegative integrand this gives \(\mathcal L_h(C)\le hC S(C)/2\). The equal masses also allow us to subtract \(w(C-)\) from both payoffs. Applying the density bound to \(w(x)-w(C-)\ge0\) and then (4) gives the stronger estimate
\[
\mathcal L_h(C)
\le\frac{hC}{2}\bigl(S(C)-(1-e^{-hC})w(C-)\bigr)
\le\frac{hC}{2}e^{-khC}S(C).
\tag{6}
\]

For bins \(i\le m\), we have \(kh\ge1-mh>0\). The maximum of \(C e^{-khC}\) for \(C\ge0\) is \(1/(e kh)\). Expected \(S(C)\), multiplied by the indicator that this bin is reached, is the expected contribution of the discrete strategy from that bin. Its sum over the early bins is at most \(D_{n,R}(w)\le P_R(w)\). Thus their combined expected loss is bounded by
\[
\frac{h}{2e(1-mh)} P_R(w).
\tag{7}
\]

For each bin \(i>m\), set \(s=(i-1)h>0\) and calculate its cutoff from all earlier bins even on paths that would already have stopped. For \(x\in(0,R]\), the event \(C\ge x\) requires no mark below \(x\) before this bin. Therefore
\[
\mathbb P(C\ge x)\le e^{-s x},\qquad
\mathbb E[C\mathbf 1_{\{C\ge x\}}]\le (x+1/s)e^{-s x}.
\tag{8}
\]
The second bound follows by integrating the first, with the survival function set to zero beyond \(R\). Dropping the indicator of reaching this bin in the nonnegative upper bound \(hC S(C)/2\), and exchanging nonnegative integrals, bounds the expected loss by
\[
\frac{h^2}{2}\int_0^R w(x)(x+1/s)e^{-(s+h)x}\,dx.
\tag{9}
\]
Extend \(w\) by zero above \(R\). Under an exponential random variable of rate one, \(w(x)\) is decreasing and \((x+1/s)e^{(1-s-h)x}\) is increasing, since \(s+h\le1\). Their covariance is nonpositive, by integrating the product of their differences on two independent arguments. Their expectations and the mixed expectation are finite by \(P_R(w)<\infty\), finite \(R\), and \(s+h>0\). Thus (9) is at most
\[
\frac{h^2 P_R(w)}{2}
\left(\frac{1}{(s+h)^2}+\frac{1}{s(s+h)}\right)
\le h P_R(w)\left(\frac1s-\frac1{s+h}\right).
\tag{10}
\]
Sum (10) over \(i>m\) and add (7). This proves (1), since \(V_R(w)\) is at least the reward of the Poisson selector just constructed. The split \(m=\lfloor n/2\rfloor\) has \(1/3\le mh\le1/2\) for \(n\ge2\). For \(n=1\) the comparison \(0\le D_{1,R}-V_R\le P_R\) suffices.

### 2.4. A sharp-order family at one fixed reward profile

Take \(R=b=1/2\), \(a=1/4\), and \(w(x)=1+\mathbf 1_{\{x<a\}}\). At every opportunity the largest possible conditional expected future reward is at most \(2(1-e^{-b})<1\), using independence and the maximum remaining time of one. This also bounds the discrete continuation conditional on past bins. Both optimum policies accept at their first nonempty opportunity. By (5),
\[
D_{n,b}(w)-V_b(w)=
(1-e^{-b})\left[\frac{1-e^{-a/n}}{1-e^{-b/n}}-\frac ab\right].
\tag{11}
\]
The bracket is \(a(b-a)/(2bn)+O(n^{-2})\), whose leading coefficient is positive. Its prophet value \((1-e^{-b})+(1-e^{-a})\) is fixed. This example establishes the sharp order of the profile-uniform comparison.

## 3. From strict marks to the weak-record minimax

A known-law observation can be written as a nondecreasing quantile payoff \(f(U)\) with \(U\) uniform on \((0,1)\). Define the strict quantile model to observe \(U\) and allow acceptance only at a new largest \(U\). Its minimax ratio at horizon \(n\) equals \(c_n\). To see one direction, the weak numeric selector can draw independent conditional quantiles given the observed values and simulate the strict selector. Every such acceptance is a weak numeric record. To see the reverse, perturb any \(f\) to \(f(u)+\eta u\). The map becomes injective, so weak numerical eligibility is equivalent to strict quantile eligibility almost surely. Perturbation changes the payoff of any given rule and the expected prophet by at most \(\eta\). Letting \(\eta\downarrow0\) proves equality of the two infima.

For our \(h=1/n\), an independent exponential mark of rate \(h\), transformed by \(x\mapsto e^{-hx}\), is uniform. Every full quantile payoff can therefore be treated as a decreasing reward profile on \((0,\infty)\) for \(n\) iid exponential marks. Its prophet payoff has mean \(\int_0^\infty w(x)e^{-x}\,dx\). Restricting to marks below \(R\) produces exactly the bin-minimum law of Section 1. The restricted optimum approaches the full optimum at fixed \(n\) as \(R\to\infty\). Indeed, one can fill each empty slot with an internal exponential mark conditioned to exceed \(R\), run the full strategy, and abandon if its virtual choice is an inserted mark. All simulated selections below \(R\) are legal. The maximal payoff lost is bounded in expectation by \(n w(R)e^{-hR}\), which tends to zero by monotonicity and finiteness of the prophet. Conversely a restricted strategy is feasible for the full mark sequence by ignoring marks above \(R\). The prophets converge by monotone convergence.

Write \(\beta_\infty=\inf_{R>0}\beta_R\). For any full profile, (1) in the direction \(D_{n,R}\ge V_R\) and the preceding truncation argument give a strict-quantile ratio of at least \(\beta_\infty\). Hence \(c_n\ge\beta_\infty\). In the other direction, a profile on \((0,R)\) may be extended by zero. The full optimum of that extension equals the restricted discrete optimum: ignoring inactive marks works in one direction, and in the other direction restore simulated inactive marks and abandon at zero-payoff inactive selections. The prophets agree. Thus (1) implies \(c_n\le\beta_R+(2+1/e)/n\) for every \(R\). Taking the infimum in \(R\) gives the horizon comparison and \(c_*=\beta_\infty\).

To compare a fixed \(R\) with larger \(L>R\), keep only the marks below \(R\) from a profile on \((0,L)\). A selector in the larger model can emulate the restricted Poisson strategy because discarded marks have larger coordinates and cannot impede eligibility. The restricted prophet is at least \((1-e^{-R})\) times the original prophet, by monotonicity of \(w\) under the exponential law, extending it by zero beyond \(L\). Consequently \(\beta_L\ge (1-e^{-R})\beta_R\); the same inequality for \(L\le R\) follows by zero extension. Since \(\beta_R\le1\), this gives the final bound in (2).

## 4. Sparse rational certification

Choose integers \(r>0\), \(n>r\), and set \(p=r/n\) and \(R=-n\log(1-p)\). A bin minimum is active with probability exactly \(p\), and \(R\ge r\). Its conditional quantile is uniform and its order represents the mark order. The minimax of \(D_{n,R}/P_R\), denoted \(d_{n,p}\), is therefore the active-quantile Bernoulli model with inactive probability \(1-p\). Theorem 1 and (2) show
\[
c_*\le d_{n,p}\le c_*+e^{-R}+3/n .
\tag{12}
\]
We use the two sparse rational programs in [1, §8.6, equations (45)–(51)]. In that construction the active quantile interval is divided into \(M\) equiprobable labels, each of mass \(p/M\). One program requires a new maximum label to accept and the other permits a tie at the current maximum label. The sorted payoff vector is normalized by the exact label prophet mean. If their optima are \(A,B\), the established bracket is
\[
L=\frac{1-(1-p/M)^n}{np/M}\,A
\ \le d_{n,p}\le\ U=B,
\qquad U-L\le \frac{3(n-1)p}{2M}.
\tag{13}
\]
The formulations use rational Bellman epigraphs with suffix variables and have \(O(nM)\) variables and constraints. No numerical approximation to \(R\) is required.

Take \(r=\lceil\log_2(8/\varepsilon)\rceil\), \(n=\max\{\lceil12/\varepsilon\rceil,2r\}\), and \(M=\lceil3r/\varepsilon\rceil\). By (12)–(13),
\[
\bigl[L-2^{-r}-3/n,\, U\bigr]
\tag{14}
\]
contains \(c_*\). Its width is at most \(\varepsilon/2+\varepsilon/8+\varepsilon/4<\varepsilon\) with exact LP endpoints. The spare error budget allows conservative approximate endpoints if desired. The variable and constraint count in Theorem 2 follows.

## 5. Provenance and scope

Determining the sharp worst-case constant and the asymptotically extremizing priors remains open. Equation (11) is a fixed-profile lower bound on the loss between two specified models. The nearest pinned manuscript [1] provides prior finite Bellman and quantile-program results, and credits earlier work on record thresholds, sharding and Poissonization. The present comparison uses identical prophet samples, then controls the online gap by the acceptance inequality early and the record-survival bound late. The faster sparse certificate uses the programs from [1] with different horizon and cutoff parameters.

**Reference**

1. *Record-constrained prophet inequalities: strict separation and effective global certification*, earlier research manuscript, fixed commit fa5aae520aa7, particularly §8.5 and §8.6. The source manifest records the manuscript path and blob.
