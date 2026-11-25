---
title: "Prefix constraints and optimal rank protection in online contention resolution"
lang: en
---

# Prefix constraints and optimal rank protection in online contention resolution

## Abstract

In online contention resolution, an algorithm knows the activation law and must accept items irrevocably under a capacity constraint. We consider an adversary who knows the active set and can use past decisions to order arrivals, with the algorithm's private randomness hidden. For every exchangeable activation law under a uniform matroid, we compute the exact optimal selectability among all randomized adaptive policies. An optimal policy uses only the active arrival rank. Its value is the concave envelope of the size-biased count distribution at the capacity. The converse couples nested active sets so that the corresponding expectations of early accepts coexist on one longer execution. The two-layer consequence transfers the sharp fixed-independence loss exponents from greedy families to arbitrary adaptive policies, for both uniform matroids and small-item knapsacks. For exchangeable pairwise-independent activations with \(2k\) half-marginal items and capacity \(k\), we also determine the worst-law leading loss constant, \((3/2)^{1/3}\). A quadratic rank profile and a matching moment-exact activation law give error \(O(k^{-2/3})\).

## 1. Model and results

The finite ground set is \(\mathcal E\), and \(M=|\mathcal E|\). The activation law \(\mathcal D\) of \(R\subseteq\mathcal E\) is known to the online policy. An arrival reveals the item's identity and activation status. Acceptances are irrevocable, only active items can be accepted, and at most \(k\) may be accepted on any execution. We take \(1\le k\le M\), since larger capacities accept all items. The order and final active count are not announced. The policy may remember the entire observed history and use arbitrary private randomization independent of \(R\). An adversary sees \(R\) and chooses the next label before its accept-or-reject decision. It can adapt to earlier decisions, with the policy's internal random choices hidden, and must present every label in the specified stream. The same results hold when arrivals list only the active items, provided each decision precedes any end-of-stream signal or other announcement that the current item is the last.

Write \(x_i=\Pr(i\in R)\). A policy is \(c\)-selectable if for every fixed item with \(x_i>0\), under every allowed order rule, its conditional probability of acceptance given activation is at least \(c\). The order rule may depend on the law, the policy, a fixed target label, \(R\), and the past accept-or-reject decisions. The target label need not be chosen after the draw. The adversary can choose the whole order from \(R\) in advance for all the converses here. The upper bounds also hold when it adapts to past decisions.

An activation law is exchangeable if permutations of \(\mathcal E\) preserve it. It then draws \(N=|R|\) from a count law and, conditional on \(N=n\), selects a uniform \(n\)-subset. When \(\mathbb E N>0\), put
\[
Q(j)=\frac{\mathbb E[N\,\mathbf 1_{\{N\le j\}}]}{\mathbb E N},\qquad 0\le j\le M .
\]
If \(\mathbb E N=0\), selectability is vacuous and its optimum is set to one.

**Theorem 1 (exact exchangeable value).** For an exchangeable law with \(\mathbb E N>0\), the optimal selectability \(c(\mathcal D,k)\) over arbitrary policies is
\[
c(\mathcal D,k)=
\max\{\mathbb E Q(J): J\in\{0,\ldots,M\},\ \mathbb E J\le k\}. \tag{1}
\]
This is the least concave majorant of the points \((j,Q(j))\) evaluated at \(k\). An optimizer either accepts the first \(k\) active ranks, or accepts the first \(L\) active ranks and a uniformly chosen \((k-L)\)-subset of the ranks \(L+1,\ldots,H\), for some integers \(0\le L<k<H\le M\).

**Theorem 2 (arbitrary-policy exponents).** Let \(r\ge1\) be fixed and \(t\in\{2r,2r+1\}\). For the above uniform-matroid model on \(t\)-wise independent activations satisfying \(\sum_i x_i\le k\), the optimal worst-law loss is \(\Theta_r(k^{-r/(2r+1)})\). For a unit-capacity knapsack with maximum item weight at most \(d\) and expected active weight at most one, the optimal worst-law loss is \(\Theta_r(d^{r/(2r+1)})\) as \(d\downarrow0\). The pinned all-rank pairwise-independent lower bounds [1, Theorem 1] also hold against arbitrary policies in this model.

**Theorem 3 (sharp exchangeable PI constant).** Let \(L_k^{\mathrm{ex}}\) be the supremum over exchangeable pairwise-independent laws on \(2k\) items with every activation marginal \(1/2\) of \(1-c(\mathcal D,k)\). Then
\[
L_k^{\mathrm{ex}}=(3/2)^{1/3}k^{-1/3}+O(k^{-2/3}). \tag{2}
\]
The upper bound uses one size-based randomized rank schedule for the entire class. The lower bound uses an explicit construction of rational count probabilities, with consecutive high counts and at most two adjacent low counts.

## 2. Nested-prefix inequalities

Fix any policy knowing \(\mathcal D\). For \(i\in R\), let
\(p_i(R)=\min_\pi\Pr_{\mathrm{seed}}(i\text{ is accepted on }R,\pi)\), where the minimum is over fixed valid arrival permutations for that active set. There are finitely many orders. The adversary for item \(i\) can choose a minimizing order separately for every realized \(R\) before any private seed is seen. Thus a \(c\)-selectable policy satisfies
\(\mathbb E[\mathbf 1_{\{i\in R\}}p_i(R)]\ge c x_i\).
In particular, summing over labels gives
\[
c\,\mathbb E N\le \mathbb E\sum_{i\in R} p_i(R). \tag{3}
\]

**Lemma 4 (prefix inequality).** For \(S_0=\varnothing\subset S_1\subset\cdots\subset S_m\subseteq\mathcal E\),
\[
\sum_{j=1}^m\sum_{i\in S_j\setminus S_{j-1}}p_i(S_j)\le k . \tag{4}
\]
The policy is the same for all the sets in (4), even if some sets are considered under a component of a mixture. In a knapsack, one has the weighted version with \(w_i p_i(S_j)\) and right side one.

To prove this, present \(S_m\) in a single order starting with the block \(S_1\), then \(S_2\setminus S_1\), and so on through \(S_m\setminus S_{m-1}\), with all these items active. The rest follows this prefix. For the activation set \(S_j\), there exists an order having the very same active prefix through block \(j\). It can then present the remaining items as inactive. In the active-only model, the second history may end after block \(j\), after its last accept-or-reject decision. Any observed history up to and including a decision in block \(j\) therefore has the same law on those two executions. This holds for each fixed random tape, since the policy receives identical inputs through that decision. Hence on the one full execution with active set \(S_m\), the probability of accepting any \(i\) in block \(j\) is at least \(p_i(S_j)\). Summing expected accepted counts on that one execution proves (4). The same reasoning with weights proves its knapsack form.

For \(n>0\), define
\[
g_n=\mathbb E_{|S|=n}\left[\frac1n\sum_{i\in S}p_i(S)\right],
\]
using a uniform \(n\)-subset. Whenever \(0=n_0<n_1<\cdots<n_m\le M\), draw the nested \(S_j\) as the first \(n_j\) coordinates of a uniformly permuted ground set. Conditional on \(S_j\), the new block is a uniform \((n_j-n_{j-1})\)-subset of \(S_j\). Taking expectations in (4) gives
\[
\sum_{j=1}^m(n_j-n_{j-1})g_{n_j}\le k . \tag{5}
\]
This conclusion uses the same policy on the different activation sets. It requires neither a greedy decision rule nor publicly observed randomization.

## 3. Exact optimization for a known exchangeable law

For \(1\le i\le M\), define \(h_i=\max\{g_n:n\ge i,\ \Pr(N=n)>0\}\), interpreting a max over an empty set as zero. This is a nonincreasing vector in \([0,1]^M\). Partition the ranks through the maximum support by choosing the largest maximizer of \(g_n\) among supported positive sizes, then the largest maximizer strictly after that size, and continuing. On the block ending at a chosen maximizer \(n_j\), the vector \(h_i\) equals \(g_{n_j}\). Each block has this value because its maximizing size is still available at every \(i\) in the block and all later allowed sets are subsets of those considered at the block start. Thus (5) gives
\[
\sum_{i=1}^M h_i\le k,\qquad g_n\le h_n\text{ for every supported }n>0 . \tag{6}
\]
Together with exchangeability and (3), this bounds the value of the fixed policy by \(\mathbb E[N h_N]/\mathbb E N\).

To attain these upper values, let \(h\in[0,1]^M\) be any nonincreasing vector with sum at most \(k\). Define \(\Pr(J=j)=h_j-h_{j+1}\) for \(1\le j\le M\), \(h_{M+1}=0\), and \(\Pr(J=0)=1-h_1\). Then \(\mathbb E[N h_N]/\mathbb E N=\mathbb E Q(J)\) and \(\mathbb E J=\sum_i h_i\). The reverse is \(h_i=\Pr(J\ge i)\).

The possible laws for \(J\) form the finite probability polytope with mean at most \(k\). Every extreme point is a single value \(J=L\le k\), or two values \(L<k<H\) of mean exactly \(k\). Indeed, three positive entries admit a nonzero perturbation preserving mass and mean in both signs. A point with two positive entries and slack in its mean bound admits a perturbation preserving mass, so is also nonextreme. Expand the law of \(J\) as a mixture of such extreme points. For a single value \(L\), accept deterministically at ranks \(1,\ldots,L\). For two values, accept ranks \(1,\ldots,L\) and choose a uniform subset of exactly \(k-L\) slots from \(L+1,\ldots,H\). Each active rank has the marginal assigned by that component, and none of these schedules accepts more than \(k\) items. Sample the mixture component once, independently of \(R\).

### 3.1. Protection when the order reacts to past decisions

Fix \(R\), the target \(i\in R\), and one schedule component. Conditional on the component, let \(X_j\) indicate that active rank \(j\) has been selected, including any hypothetical slots after \(|R|\). Set \(b_j=\mathbb E[X_j\mid X_1,\ldots,X_{j-1}]\). For a quota component, this equals one through rank \(L\), then the quota remaining divided by the number of slots remaining in \(L+1,\ldots,H\), and then zero. It is a martingale during the quota phase because sampling is uniform without replacement. Its changes at the phase boundaries are downward, so \(\mathbb E[b_{j+1}-b_j\mid X_1,\ldots,X_{j-1}]\le0\). A deterministic cutoff component has the same inequality.

The active rank \(T\) of item \(i\) is chosen before its decision, so whether \(T=j\) is known from \(R\), the adversary's own randomness and the rank outcomes before \(j\). Inactive arrivals reveal no additional policy randomness. Condition on the adversary's tape as well. Writing \(n=|R|\), we get \(\Pr(i\text{ accepted}\mid R,\text{component})=\mathbb E b_T\ge\mathbb E b_n\). In detail,
\[
b_n-b_T=\sum_{j=1}^{n-1}\mathbf 1_{\{T\le j\}}(b_{j+1}-b_j),
\]
and every term on the right has nonpositive conditional mean given all outcomes before rank \(j\). This proof works even if the adversary knows the component, as long as its future selected slots remain private. It yields conditional acceptance at least \(h_n\) after averaging over components. An order putting the target at rank \(n\) achieves exactly \(h_n\).

Exchangeability gives \(\Pr(N=n\mid i\in R)=n\Pr(N=n)/\mathbb E N\) for every item of positive marginal. Thus the implemented value is exactly \(\mathbb E[N h_N]/\mathbb E N\). Maximizing \(\mathbb E Q(J)\) over the mean polytope proves (1). As \(Q\) is nondecreasing, a law of \(J\) with slack can be moved toward point mass at \(M\) until its mean reaches \(k\) without decreasing its objective. Therefore some extreme point of the mean-\(k\) slice attains the optimum. Such a point is \(J=k\) or a two-cutoff component with \(L<k<H\). This proves the stated optimal schedules.

The distribution of \(J\) is a representation of the rank marginals. The hard capacity is enforced by the sampled subset of ranks with at most \(k\) slots. The objective is determined by the count probabilities and can be evaluated by checking the line segments between pairs of integer levels bracketing \(k\).

## 4. Transfer of the fixed-independence lower bounds

Fix a policy, even if it has been designed using a full mixture law containing the component below. Let \(a,b\) be positive integers with \(a\le k\), \(k+b\le M\), and \(b^2\le ak\). Consider the component that picks a uniform \((k-a)\)-set with probability \(b/(a+b)\) and a uniform \((k+b)\)-set otherwise. It has mean active count \(k\). Set \(L=k-a\) and \(H=k+b\), and let \(s\) and \(t'\) denote the mean of \(\sum_{i\in R} p_i(R)\) in the respective layers. If \(L=0\) set \(s=0\). The two-layer inequality (5) and the one-layer inequality give
\[
s+\frac{H-L}{H}t'\le k,\qquad t'\le k.
\]
The component's mean sum of worst-order acceptances is bounded by
\[
\frac{b s+a t'}{a+b}\le\frac{bk}{a+b}+
\left(\frac{a}{a+b}-\frac{b}{k+b}\right)t'\le\frac{k^2}{k+b}.
\]
Indeed the coefficient of \(t'\) has sign \(ak-b^2\). Thus the expected shortfall in the component is at least \(k b/(k+b)\). In any larger mixture it contributes that bound times its weight, since every layer shortfall is nonnegative. When the full mixture also has mean \(k\), (3) gives the corresponding loss lower bound.

The pinned source [1, Theorem G and Sections 5–6] supplies exchangeable laws on \(2k\) labels with mean \(k\), all marginals \(1/2\), and \((2r+1)\)-wise independence, for every sufficiently large \(k\) at fixed \(r\). Their two-layer component has positive weight bounded below and \(b/k\) of order \(k^{-r/(2r+1)}\), with \(b^2\le ak\). The preceding comparison applies to every policy on those laws and gives the lower rate for both \(t=2r\) and \(t=2r+1\). The same comparison preserves the all-rank pairwise bounds from [1, Theorem 1], using its exact two- and three-layer witnesses. The constructive upper bounds in [1] use greedy families, which are admissible policies and even allow an adversary to view the private family draw. This supplies the matching upper rates here. For knapsack, use equal weights \(1/k\) in a hard instance with \(k=\lceil1/d\rceil\) to obtain the lower rate, and use the heterogeneous-weight upper bound from [1]. This proves Theorem 2.

The finite moment-matching laws and greedy upper methods come from [1]. The prefix argument is what removes the greedy restriction and the need for the lower adversary to observe a private random seed.

## 5. The sharp exchangeable pairwise-independent loss constant

Exchangeability on \(2k\) items with half marginals and pairwise independence is equivalent to the count conditions
\[
\mathbb E N=k,\qquad \operatorname{Var}(N)=k/2 .
\]
Indeed the first determines the marginal and the second gives \(\mathbb E[N(N-1)]=k^2-k/2\), making the probability of any distinct pair active equal to \(1/4\). Conversely the Bernoulli indicator moments give these count moments.

Put \(v=1/2\), \(T=(3v)^{1/3}\), \(\eta=k^{-1/3}\), and \(w_0=T k^{2/3}\). Big-O constants in this section are uniform in the activation law or rank vector being bounded.

### 5.1. A universal rank profile

Use the nonincreasing raw profile \(a_j=1\) for \(1\le j\le k\) and \(a_{k+x}=(1-x^2/w_0^2)_+\) for \(1\le x\le k\), where the subscript plus means maximum with zero. Its sum \(A\) is at most \(k+2w_0/3\). For the tail this follows by bounding the sum of right-endpoint values of the decreasing profile by \(\int_0^{w_0}(1-x^2/w_0^2)\,dx=2w_0/3\). Use actual rank marginals \(h_j=(k/A)a_j\).

For \(x=N-k>0\) one has
\[
(1+x/k)(1-a_N)\le (1+w_0/k)x^2/w_0^2 .
\]
This is immediate for \(x\le w_0\). For \(x>w_0\), \(1-a_N=1\) and the function \(x\mapsto(1+x/k)/x^2\) decreases. For \(N\le k\), the raw profile has zero rejection probability when an item is active. The loss of the implemented profile is therefore bounded by
\[
1-\frac{\mathbb E[N h_N]}k
\le\frac{2w_0}{3k}+(1+w_0/k)\frac{vk}{w_0^2}
=T\eta+O(\eta^2).
\]
Here \(\mathbb E[N]=k\) controls scaling the profile, and \(\mathbb E[(N-k)_+^2]\le vk\) controls its tail loss. The leading equality follows from \(T^3=3v\). This policy is independent of the count law.

### 5.2. A matching exact-moment law

For sufficiently large \(k\), put \(w=\lceil w_0\rceil<k\), let \(S_1=\sum_{j=1}^w j\), \(S_2=\sum_{j=1}^w j^2\), and assign a common preliminary probability \(p\in[0,1/k]\) to each of the counts \(k+1,\ldots,k+w\). The remaining probability \(1-wp\) lies at one or two adjacent counts at or below \(k\). Write their deficits from \(k\) as \(\lfloor a(p)\rfloor,\lceil a(p)\rceil\), with the two probabilities chosen so their conditional mean deficit is
\[
a(p)=\frac{p S_1}{1-wp}.
\]
This ensures \(\mathbb E N=k\). Uniformly on the interval for \(p\), \(a(p)=O(k^{1/3})\), so all these counts lie in \([0,2k]\) for large \(k\). The conditional second moment of the deficit is the piecewise linear interpolation of the squares at consecutive integers. The overall variance is continuous in \(p\), starting at zero. At \(p=1/k\) it is at least \(S_2/k\ge w^3/(3k)\ge vk\). Thus there is a feasible \(p\) giving exactly \(vk\). It can be found with rational arithmetic. For \(z=\lfloor a(p)\rfloor\), the variance on the interval \(z\le a(p)\le z+1\) is
\[
p[S_2+(2z+1)S_1+w z(z+1)]-z(z+1).
\]
All breakpoints are rational, and \(vk=k/2\) is rational, so solve on the appropriate interval. The resulting exchangeable law is exactly pairwise independent.

The variance contributed by the low counts is \(O(k^{2/3})\). Since \(S_2/k=vk+O(k^{1/3})\), it follows that \(pk=1+O(\eta)\). The size-biased probability of each high count \(k+j\) is \((k+j)p/k=1/k+O(\eta/k)\), uniformly over \(1\le j\le w\). The aggregate difference between their true weights and the approximating weights \(1/k\) is \(O(\eta^2)\). The low counts together have size-biased mass \(1-w/k+O(\eta^2)\).

Consider any nonincreasing rank vector \(h\) with sum at most \(k\), and let \(\ell\) be the smallest low count of positive probability. It satisfies \(\ell\ge k-O(k^{1/3})\). Set \(g=h_\ell\). The low counts have acceptance probability at most \(g\). The sum of the high rank marginals is at most \(wg\) by monotonicity and at most \(k-\ell g\) by the capacity budget. Theorem 1, or its equivalent rank-vector objective, now gives the upper envelope on any policy's success,
\[
(1-w/k)g+\min\{w g,k-\ell g\}/k+O(\eta^2).
\]
The first branch increases up to \(g_*=k/(\ell+w)\), and the second decreases after that point because \(\ell+w>k\) for all large \(k\). At the crossing the displayed expression without its error term equals \(g_*\). Since \(\ell+w=k+T k^{2/3}+O(k^{1/3})\), every policy's selectability is at most \(1-T\eta+O(\eta^2)\). This completes Theorem 3.

## 6. Scope and attribution

The exact formula in Theorem 1 concerns exchangeable activations under a seed-hidden, activation-aware order rule that may react to previous decisions. The exponent transfer only uses the prefix obstruction, so its lower bound holds for any larger adversary class that permits the same order rules. Its matching upper bound also applies when the adversary sees the private seed. The exact exchangeable value and its constant here use the private-randomization hypothesis. They do not assert the same constant for all PI laws, independent-of-activation orders, or known future activations. The fixed-order-of-independence statement keeps that independence order fixed as the capacity grows.

The pinned work of [1] proves the sharp greedy exponents from a robust-core comparison and constructs the exact fixed-independence witnesses. The nested-prefix inequality controls arbitrary policies by their worst-order marginal probabilities. It leads both to the full-exchangeability optimum and to the sharp exchangeable PI constant.

## Reference

1. *Sharp independence-dependent loss in greedy online contention resolution*, pinned earlier research manuscript manuscript at  (archived version), Theorems G and 1 and Sections 4–6.
