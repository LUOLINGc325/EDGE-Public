---
title: "Exact capital for convex-profile e-value mergers"
subtitle: "A representation criterion and tensorization under adaptive reading"
lang: en
geometry: margin=1in
abstract: |
  We compute the minimum initial capital needed by a generalized read-once martingale strategy to dominate a symmetric family of precise independent-e-value mergers. The formula covers smooth, strictly increasing counterexamples and profiles that are constant near the origin. It gives an exact criterion for representation at unit capital and identifies where two small inputs impose a stronger constraint than the axis and the large-input diagonal. A finite-domain dual proves cost multiplication for arbitrary blocks under adaptive interleaving. A four-value approximation transfers this result to the full convex-profile family.
---

## 1. Model and main theorem

An e-variable is a finite nonnegative random variable of mean at most one. A nonnegative Borel function \(T\) of independent e-variables is an independent-e-value merger when its expectation is at most one under every such law. It is precise if its expectation is one whenever the independent inputs all have mean one.

A generalized read-once martingale strategy chooses an unread coordinate using the previously revealed inputs. Before observing the selected input \(x\), it chooses a stake fraction \(s\in[0,1]\) and multiplies its wealth by \(1+s(x-1)\). Strategies may be mixed using an independent seed. The terminal value of a mixture is the mean terminal wealth over its seed, at fixed input. Define \(\mathcal C(T)\) as the infimum average initial capital of mixtures whose terminal values dominate \(T\) at every input. Arbitrary nonnegative initial capital allocations are equivalent to a common initial capital and a reweighted strategy mixture, by linearity of wealth in its initial amount.

Write \(u=x-1\) and \(v=y-1\), so that \(u,v\in[-1,\infty)\). Let \(h:[0,\infty)\to[0,\infty)\) be finite, convex and nondecreasing, with finite asymptotic slope \(a=\lim_{t\to\infty}h(t)/t\). Assume that
\[
 h(t)\ge at\quad(t\ge0),\qquad h(1)\le\tfrac12.
 \qquad\text{(1)}
\]
Consider
\[
 T_h(x,y)=1+u h(|v|)+v h(|u|).
\]
Define \(\psi(t)=(a-h(t))_+\), where \(r_+=\max(r,0)\), and put
\[
 M(h)=\max_{b,d\in[0,1]}\{b\psi(d)+d\psi(b)\}.
 \qquad\text{(2)}
\]

**Theorem 1.** Each \(T_h\) is a continuous, symmetric, coordinatewise nondecreasing precise independent-e-value merger. Its exact capital is
\[
 \mathcal C(T_h)=1+M(h),
 \qquad\text{(3)}
\]
and a mixture of just the two reading orders attains it. Unit-capital representation is possible exactly when \(h(0)\ge a\).

For indices \(j=1,\ldots,n\) let each \(h_j\) satisfy (1), with parameters allowed to differ. On \(2n\) inputs, even when the strategy adaptively interleaves coordinates from all pairs,
\[
 \mathcal C\!\left(\prod_{j=1}^n T_{h_j}(x_{2j-1},x_{2j})\right)
 =\prod_{j=1}^n(1+M(h_j)).
 \qquad\text{(4)}
\]
All functions and budgets in (3) and (4) are on the full nonnegative input domain.

The unsmoothed profile \(h(t)=a t\) with \(a=\lambda/2\) is the elementary counterexample in the archived precursor. Its Section 6 explicitly leaves the exact capital of the smooth profile open. The proof here yields that coefficient and a function-space criterion. The tensorization proof establishes an intermediate theorem for arbitrary nonnegative finite-grid targets.

## 2. Precision and the two-input capital formula

Every secant slope of \(h\) lies in \([0,a]\) by convexity, monotonicity and the asymptotic slope. This also gives continuity at zero and the bound \(h(t)\le h(0)+at\). In particular \(a\le1/2\) by (1). If \(u\) increases by \(r>0\) while \(v\) is fixed, the change in \(T_h\) is at least \(r[h(|v|)-a|v|]\ge0\), since \(u\mapsto h(|u|)\) is \(a\)-Lipschitz. Symmetry gives monotonicity in the other coordinate. The minimum value is \(T_h(0,0)=1-2h(1)\ge0\), where arguments of \(T_h\) are original inputs. Independence and the linear bound on \(h\) justify factorizing the two cross terms. Both are nonpositive when the input means are at most one, and both vanish when they equal one. This proves precision and validity.

### 2.1. A representation of symmetric strategy payoffs

Any strategy dominating a symmetric target can be symmetrized by averaging it with the strategy that exchanges the input labels. Consequently, for capital \(C\), it suffices to use symmetric terminal values. In shifted coordinates they are exactly
\[
 G(u,v)=C+s(u+v)+f(u)v+f(v)u,\qquad
 0\le s\le C/2,\qquad 0\le f(u)\le C/2+s u.
 \qquad\text{(5)}
\]
To see this, the two orders each carry half of the capital after symmetrization. Their aggregate first wagers are the same dollar amount \(s\), and after a first observation with shift \(u\), their aggregate second wager is the same dollar function \(f(u)\). These wagers are bounded by the respective available wealths. Conversely, choose the orders with probabilities one half, bet first at fraction \(2s/C\) when \(C>0\), and use fraction \(f(u)/(C/2+s u)\) after the first reveal. At a zero denominator the wager is zero. This implements (5). The same statement applies on a common finite coordinate grid, with arbitrary zero-wager extensions when necessary.

### 2.2. Necessity

For a dominating \(G\), its value at \(u=v=0\) gives \(C\ge1\). Let \(K=C-1\) and \(e(u)=s+f(u)-h(|u|)\). The surplus over \(T_h\) at shifted coordinates \((u,v)\) equals \(K+v e(u)+u e(v)\). Taking \(u=v=t>0\) gives
\[
 e(t)\ge-K/(2t).
\]
The upper bound in (5) yields \(e(t)\le s+C/2+s t-h(t)\). Dividing by \(t\) and letting \(t\) tend to infinity gives \(s\ge a\).

At \((t,-b)\) for \(0\le b\le1\), domination gives
\[
 e(-b)\ge \frac{b e(t)}{t}-\frac{K}{t}
          \ge-\frac{bK}{2t^2}-\frac Kt .
\]
Passing to the limit shows \(e(-b)\ge0\). Also \(f(-b)\ge0\) gives \(e(-b)\ge s-h(b)\ge a-h(b)\); thus \(e(-b)\ge\psi(b)\). Applying domination in the square \((u,v)=(-b,-d)\) now gives \(K\ge b\psi(d)+d\psi(b)\). Taking the maximum proves the lower bound in (3).

### 2.3. Attainment and the representation criterion

Set \(C=1+M(h)\), \(s=a\), and \(f(u)=(h(|u|)-a)_+\). For \(u\ge0\) we have \(f(u)\le 1/2+a u\) by the growth bound. For \(u\in[-1,0]\) we have \(f(u)\le1/2-a\). Both inequalities imply the wager bound in (5), using \(C\ge1\) and \(a\le1/2\).

The resulting \(e(u)=\psi(|u|)\) is nonnegative. The surplus is therefore nonnegative when \(u,v\ge0\). On the square \(u,v\le0\) it is nonnegative by (2). For \(u\ge0\) and \(v=-b\le0\), the only negative term is at most \(b\psi(u)\le\psi(0)\). The choice \((b,d)=(1,0)\) in (2) yields \(M(h)\ge\psi(0)\), so the mixed quadrant is covered, as is its reflection. This proves (3) and attainment.

Monotonicity of \(h\) makes \(M(h)=0\) equivalent to \(h(0)\ge a\). If a unit-capital strategy dominates a precise target, it represents it pointwise. Indeed, any finite input vector can be given positive mass by independent mean-one laws, by adding a point on the opposite side of one to each coordinate or using the constant one. The strategy's expected wealth under those laws equals one by successive conditioning, so a nonnegative surplus has zero expectation and vanishes at the prescribed vector. This also gives pointwise admissibility among all independent-e-value mergers by replacing the dominating strategy with any valid merger.

Moreover, \(0\le M(h)\le a\le1/2\). For the upper bound, (1) gives \(\psi(b)\le a(1-b)\) on \([0,1]\), and \(b+d-2bd\le1\). If \(a>0\), equality \(M(h)=a\) requires \((b,d)\) to be \((1,0)\) or \((0,1)\), the only points where \(b+d-2bd=1\). It then requires \(h(0)=0\). Conversely \(h(0)=0\) forces \(h(t)=at\) by (1) and the Lipschitz bound, and that profile attains \(M(h)=a\). Thus the largest cost in this class is \(3/2\), attained by the unsmoothed profile with \(a=1/2\).

## 3. Finite-domain tensorization

For a finite product grid of nonnegative input values and a nonnegative target \(T\), let \(\mathcal C_{\mathrm{grid}}(T)\) be the minimum capital to dominate \(T\) on the grid. Reading rules and fraction constraints are as before.

**Theorem 2.** For any finite collection of such grids on disjoint coordinate blocks, the capital of the product of their targets on the combined grid is the product of their individual capitals, even with adaptive interleaving.

**Proof.** On a finite grid there are finitely many histories of revealed coordinates and values. A deterministic strategy with fractional stakes is pointwise equivalent in mean wealth to a randomized strategy with stakes zero or one. For each history independently preassign a Bernoulli stake with mean equal to its specified fraction. Conditional on the original seed, fix the order rules, including any dependence on the strategy's own wealth, by expressing them as functions of the revealed history under the original strategy. For any fixed complete input, the resulting read path is fixed and uses distinct histories. The expected product of the stake multipliers therefore equals the original terminal wealth. Thus the set of unit-capital terminal mixtures on the grid is the convex hull of the finitely many deterministic unit-capital terminal vectors \(W_j\) whose stakes are zero or one.

The single-block primal and dual programs are
\[
\begin{aligned}
 C_{\mathrm{grid}}
  &=\min\Big\{\sum_j c_j:
       c_j\ge0,\ \sum_j c_j W_j(z)\ge T(z)\text{ for all }z\Big\}\\
  &=\max\Big\{\sum_z \lambda_zT(z):
       \lambda_z\ge0,\ \sum_z\lambda_zW_j(z)\le1\text{ for all }j\Big\}.
\end{aligned}
\]
The constant unit strategy gives primal feasibility and confines dual weights to a compact simplex, so both optima are attained. If a block target vanishes identically, its cost and the product cost are zero. Otherwise the optimal dual weights are nonzero and attain equality in at least one strategy constraint, since the positive objective could otherwise be increased by scaling. Normalize the weights to a probability law \(Q\) on the block. If \(V(\varnothing)\) denotes the best expected terminal value of a unit-capital strategy under \(Q\), then
\[
 \mathcal C_{\mathrm{grid}}(T)=\frac{\mathbb E_Q T}{V(\varnothing)} .
 \qquad\text{(6)}
\]

For each block, at each positive-probability partial revealed state \(\zeta\), let \(V(\zeta)\) be the maximum expected final wealth from one unit at that state, using that block's conditional law. It depends only on the partial assignment in the block because past order carries no information beyond revealed values in this one-block decision problem. If all inputs in the block have been read it is one. At other states the Bellman inequality gives
\[
 \mathbb E_Q[(1+s(X-1))V(\zeta')\mid \zeta]\le V(\zeta)
\]
for every unread coordinate choice and stake, with \(\zeta'\) the state after revealing that coordinate. This follows by taking that action and then the optimal remaining choices at each possible observation.

Now take the product of the block laws \(Q_j\) and fix the interleaving strategy's seed. Conditional on a feasible reveal history, the set of compatible inputs is exactly the set matching the revealed values in each block. This holds by induction, because the deterministic action at a history is determined before seeing the next input. Hence the conditional structure is again a product of the updated block laws. With \(W\) the current wealth, the Bellman inequalities show that
\[
 W\prod_j V_j(\zeta_j)
\]
is a supermartingale. At the end its value is the terminal wealth, and initially it is the initial capital times \(\prod_j V_j(\varnothing)\). The bound also holds averaged over the seed. Any dominating strategy's final expectation is at least \(\prod_j\mathbb E_{Q_j}T_j\). Equation (6) now forces capital at least \(\prod_j\mathcal C_{{\mathrm{grid}},j}(T_j)\). Process the blocks consecutively with independently randomized optimal strategies to attain this lower bound. This proves Theorem 2.

## 4. Four-value witnesses and the full-domain product

Choose \((b,d)\in[0,1]^2\) attaining (2), and let \(C_t\) be the optimal grid capital for \(T_h\) on both coordinates with shifted values in \(\{0,-b,-d,t\}\), \(t\ge1\). Repeated grid values can be removed. We claim the explicit bounds
\[
 1+M(h)-4/t\le C_t\le1+M(h).
 \qquad\text{(7)}
\]
The upper bound follows by restriction of the full-domain strategy. In particular \(1\le C_t\le3/2\). Let \(K_t=C_t-1\) and let \(s_t,e_t\) be the quantities in Section 2 for a symmetrized optimal grid strategy. The diagonal comparison and \(h(t)\ge at\) give
\[
 s_t \ge a-\frac{s_t+C_t/2+K_t/(2t)}{t}\ge a-2/t.
\]
For \(r\in\{b,d\}\), the point \((t,-r)\) gives \(e_t(-r)\ge-rK_t/(2t^2)-K_t/t\ge-2/t\). Together with \(e_t(-r)\ge s_t-h(r)\), this shows \(e_t(-r)\ge\psi(r)-2/t\). The lower-square comparison at \((-b,-d)\) therefore gives \(K_t\ge M(h)-2(b+d)/t\ge M(h)-4/t\). This proves (7).

Apply Theorem 2 on the product of these grids for the individual profiles. Every strategy on the full domain restricts to a strategy on that grid, so its capital is at least the product of the grid optima. Send \(t\) to infinity for a fixed number of blocks and use (7). Processing blocks consecutively with the attaining strategies of Section 2 yields the upper bound. This establishes (4).

## 5. Exact coefficients for two profile families

### 5.1. Analytical smoothing

Let \(0\le\rho<1\), \(\lambda>0\), and \(\lambda\sqrt{1+\rho^2}\le1\). The archived smoothed family is the profile
\[
 h_\rho(t)=(\lambda/2)\sqrt{t^2+\rho^2},\qquad a=\lambda/2.
\]
For \(\rho>0\) it gives a real-analytic merger with strictly positive partial derivatives, since \(h_\rho(t)>at\) at each finite \(t\) and its Lipschitz constant is \(a\). For \(b\in[0,1]\) write \(r=\sqrt{b^2+\rho^2}\). When \(r\le1\) and \(r+\rho>0\), the identity \(r-\rho=b^2/(r+\rho)\) gives
\[
 (1-r)_+\le(1-\rho)(1-b^2)
\]
using \(r+\rho\le1+\rho\) and \(1/(1+\rho)\ge1-\rho\). At \(r+\rho=0\) the inequality is equality, and at \(r>1\) it follows from a zero left side. Then
\[
 b(1-d^2)+d(1-b^2)=(b+d)(1-bd)\le(1+bd)(1-bd)\le1 .
\]
It follows that \(M(h_\rho)\le(\lambda/2)(1-\rho)\), with equality at \((b,d)=(1,0)\). Thus the full-domain capital is exactly
\[
 1+\frac{\lambda}{2}(1-\rho).
\]
For any admissible \(\rho\ge1\) the same profile satisfies the assumptions with \(h_\rho(0)\ge a\), so its cost is one.

### 5.2. A flat central profile

Let \(0\le\rho\le1\), \(0<a\le1/2\), and \(h(t)=a\max(\rho,t)\). The objective in (2) is bilinear on each rectangle formed by subdividing both variables at \(\rho\). Its maximum on each rectangle is attained at a vertex by successive one-variable maximization. On the vertex grid \(\{0,\rho,1\}^2\), the positive contenders are \(a(1-\rho)\) from \((1,0)\) or \((1,\rho)\), and \(2a\rho(1-\rho)\) from \((\rho,\rho)\); the remaining values are at most their maximum. Consequently
\[
 \mathcal C(T_h)=1+a(1-\rho)\max(1,2\rho).
\]
For \(1/2<\rho<1\) two interior subunit inputs give a strictly stronger bound than the axis-and-large-diagonal comparison. This shows why the two-variable maximum in (2) is required even within the convex-profile class.

## 6. Archival relation and scope

The archived manuscript *Precise independent e-merging beyond reordered martingales*, Sections 4–6, proves the exact unsmoothed two-input cost and tensorization for that explicit family using one positive three-point law. The analytical smoothing section proves separation and leaves its cost undetermined. We obtain the full-domain coefficient for that family, classify representation for the enlarged profile class, and establish the finite-grid theorem for arbitrary targets. The finite-grid result concerns the same fraction-constrained, read-once class as the precursor. Here it is used to transfer the profile costs to arbitrary adaptive interleaving. The mathematical claim concerns pointwise capital, with external priority outside the pinned comparison unverified.
