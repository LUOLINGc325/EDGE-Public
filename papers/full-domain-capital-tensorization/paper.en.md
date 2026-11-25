---
title: "Finite-grid witnesses and full-domain tensorization for read-once e-value capital"
lang: en
geometry: margin=1in
---

# Abstract

A read-once martingale strategy sees a vector of nonnegative inputs one coordinate at a time. It selects the next coordinate and a fraction of wealth to wager before seeing that coordinate. We prove that the minimum capital for pointwise domination of any nonnegative monotone target on the full domain is the supremum of its finite-grid capitals. At a fixed multiplicative mesh, the limiting grid capital approximates the full one within the mesh factor raised to the number of coordinates. This yields exact multiplicativity for arbitrary monotone targets on separate blocks, even against strategies that adaptively interleave the blocks. For symmetric precise independent e-value mergers on two inputs, we derive a universal representation and the sharp capital bound at every value of the target at the origin. The resulting sharp worst-case cost is \(3/2\) per pair.

# 1. Model and results

An input vector \(x\) belongs to \([0,\infty)^n\). A pure strategy selects an unread coordinate \(i\) and a fraction \(s\in[0,1]\) before observing that coordinate. It multiplies its current wealth by \(1+s(x_i-1)\) and retains the revealed index and value. It reads every coordinate once, using measurable rules of the reveal history. A strategy can also use an independent seed to mix pure strategies, in which case its pointwise payoff is the mean terminal wealth over the seed. Its **capital cost** \(\mathcal C(T)\) for a finite-valued nonnegative Borel target \(T\) is the infimum initial wealth at which it dominates \(T\) at every input. With domain restricted to \(A^n\) for a finite nonempty set \(A\subset[0,\infty)\), write \(\mathcal C_{A^n}(T)\). We also use costs on finite product grids with different coordinate sets. The full cost is allowed to be infinite.

**Theorem 1.** Let \(T\) be coordinatewise nondecreasing. For \(q>1\) define \(A_{q,m}=\{0\}\cup\{q^j:-m\le j\le m\}\) and \(M_q(T)=\lim_{m\to\infty}\mathcal C_{A_{q,m}^n}(T)\). Then
\[
 M_q(T)\le\mathcal C(T)\le q^n M_q(T),\qquad
 \mathcal C(T)=\sup_{\substack{A\subset[0,\infty)\\ 0<|A|<\infty}}
                    \mathcal C_{A^n}(T).
\]
The supremum can be taken over rational geometric grids \(A_{q,m}\) with rational \(q>1\).

**Corollary 2.** For nonnegative monotone Borel targets \(T_i\) on finitely many disjoint finite-dimensional blocks, the full capital of \(\prod_i T_i\) equals \(\prod_i\mathcal C(T_i)\) when the factors are positive and finite. A zero-cost block makes the product cost zero. If all block costs are positive and some is infinite, the product cost is infinite.

An independent e-value merger is a nonnegative Borel function of independent nonnegative random variables of means at most one whose mean is at most one under every such law. It is **precise** if its mean equals one whenever all the means are one.

**Theorem 3.** For a symmetric coordinatewise nondecreasing precise two-input independent e-value merger \(T\),
\[
 \mathcal C(T)\le 1+\frac{1-T(0,0)}{2}.
\]
For every prescribed value of \(T(0,0)\) in \([0,1]\) this upper bound is attained by a target in the class. In particular the maximum cost is \(3/2\) per pair. For products of \(k\) such pairs the sharp worst cost is \((3/2)^k\) even with adaptive interleaving.

# 2. The finite-grid principle

On a finite product grid a pure policy can be replaced, in mean payoff at every input, by a mixture of policies with stakes in \(\{0,1\}\). For a fixed pure policy, both its choice of index and its chosen stake can be recorded as functions of the finite ordered reveal history, since its wealth is already a function of that history. Keep its index table fixed and independently resample each entry of the stake table as a Bernoulli variable with mean equal to the original stake. At any fixed input, the sequence of reveals is unchanged and the visited stake bits are independent. The expectation of the product of the new multipliers is the original product. Applying this argument conditional on the seed establishes the reduction for any mixture. There are only finitely many such deterministic bit policies on a finite grid. Consequently their mixtures form a polytope of unit-capital payoff vectors. The finite least-capital problem is a feasible linear program, as cash dominates any grid target at sufficient capital, and attains its optimum.

Fix \(q>1\) and write \(S=\{0\}\cup\{q^j:j\in\mathbb Z\}\). The first inequality \(M_q(T)\le\mathcal C(T)\) follows by restriction. If \(M_q(T)=\infty\) there is nothing further to prove for this \(q\). If \(M_q(T)=0\), every finite-grid target vanishes: at a fixed input, any unit-capital payoff is at most \(\prod_i\max(1,x_i)\), so a positive target value has positive cost. Then \(T\) vanishes on \(S^n\), and every full-domain input has a coordinatewise majorant in \(S^n\). Monotonicity gives \(T\equiv0\).

Suppose \(0<M_q(T)<\infty\). A finite-grid optimal policy for \(A_{q,m}^n\) can be padded by a cash allocation to have capital exactly \(M_q(T)\). View it as \(M_q(T)\) times a unit-capital mixture of deterministic bit policies, and extend their action tables arbitrarily to ordered histories with values in \(S\) outside the grid. The set of all extended tables is a countable product of finite discrete spaces: an entry specifies an unread index and a stake bit at a given history. This space is compact metrizable and its probability laws are sequentially compact for weak convergence. Let a subsequence of the finite-grid policy laws converge to a law on this space. At a fixed input in \(S^n\), its terminal payoff depends on finitely many entries, since there are only finitely many possible ordered reveal histories at that input. It is a bounded continuous function of the table. The input belongs to all sufficiently large grids, so the limiting law at capital \(M_q(T)\) dominates it. The same law works on every input in \(S^n\).

To implement the law on real data, use
\[
 r_q(x)=
 \begin{cases}
   0,&x=0,\\
   q^{\lceil \log_q x\rceil},&x>0.
 \end{cases}
\]
The strategy sees the actual selected input but stores its rounded value \(r_q(x)\) in its internal history. This rule is Borel and implements the same index and stake choices that the sampled table would use on the rounded input. Wealth evolves using the actual values. Because \(x\le r_q(x)\le qx\), for any \(0\le s\le1\),
\[
 1+s(x-1)\ \ge\ q^{-1}\bigl[1+s(r_q(x)-1)\bigr].
\]
With capital \(q^n M_q(T)\), the expectation of actual wealth is therefore at least \(T(r_q(x_1),\ldots,r_q(x_n))\), which is at least \(T(x)\). This proves the mesh bound. Let \(q\) decrease to \(1\) through rational values. The supremum of finite-grid costs cannot exceed the full cost, and a finite supremum \(M\) gives \(\mathcal C(T)\le q^n M\) for each such \(q\). This proves the exact formula, including the infinite case.

# 3. Dual witnesses and adaptive interleaving

On a finite product grid \(B\), the least-capital linear program has one nonnegative allocation variable \(c_j\) per deterministic unit-capital bit policy \(W_j\). Its constraints are \(\sum_j c_j W_j(x)\ge T(x)\) for \(x\in B\) and its objective is \(\min \sum_j c_j\). Its dual maximizes \(\sum_x \lambda_xT(x)\) over \(\lambda_x\ge0\) with \(\sum_x\lambda_xW_j(x)\le1\) for every \(j\). For a probability law \(Q\) on the grid, write \(V_Q\) for the maximum expected terminal wealth of a unit-capital strategy under \(Q\). It is at least one by the cash strategy. Normalizing any nonzero dual direction to a probability law and scaling it maximally along that direction gives the ratio \(\mathbb E_Q T/V_Q\). The maximum over laws equals the grid capital, also when the target vanishes. Any finitely supported law on the full domain lies on some finite grid, and its optimal expected unit payoff is unchanged by extending finite-grid policies. Theorem 1 gives the dual formula
\[
 \mathcal C(T)=\sup_{Q\ \mathrm{finitely\ supported}}\frac{\mathbb E_Q T}{V_Q}.
\]
The law in this formula can have dependent coordinates.

For completeness, the finite-grid multiplication argument from the pinned source is as follows. Choose a maximizing dual law for each block with nonzero target and take their product across blocks. At any reachable reveal history of a fixed interleaving strategy, conditional laws in different blocks remain independent, each subject to the observations made in its own block. Indeed, after fixing the seed, each choice of index is a function of previous revealed values; a feasible history imposes exactly the indicated coordinate equalities. Write \(V_i(h_i)\) for the optimal expected unit payoff within block \(i\) given its revealed partial assignment \(h_i\), so all the \(V_i\) equal one at termination. The finite Bellman inequality for an action in block \(i\) states that the conditional expectation of the next multiplier times the updated \(V_i\) is at most the current \(V_i\). Thus current wealth times \(\prod_i V_i(h_i)\) is a supermartingale under the block product law. This bounds expected terminal wealth for any seed, and hence for mixed strategies. Domination of the target product then forces the initial capital to be at least the product of the optimizing block ratios. Reading blocks successively with independent seeds attains that product. Zero targets are immediate. This proves the finite-grid multiplicativity used here.

For any fixed \(q\), apply finite-grid multiplicativity on the same \(A_{q,m}\) in each coordinate of every block. The cost of the full product is at least each resulting product of grid costs. If all full block costs are finite and positive, the limits in \(m\) and Theorem 1 give the lower bound \(q^{-\sum_i n_i}\prod_i\mathcal C(T_i)\), with \(n_i\) the block dimensions. Send \(q\) down to one. For the upper bound, read blocks consecutively using independent near-optimal block strategies and multiply their capital allocations. Their expected terminal payoff at each fixed input is the product of the independently randomized block payoffs; take their initial capitals to the respective infima. If any factor is infinite and all are positive, its finite-grid costs diverge at fixed \(q\), while the other finite-grid costs are bounded below by positive constants for sufficiently large \(m\). A zero full cost entails an identically zero block by the unit-payoff bound. These arguments prove Corollary 2.

# 4. All symmetric precise pairs

Put \(U(u,v)=T(1+u,1+v)\) on \([-1,\infty)^2\). Precision means that \(\mathbb E U(A,B)=1\) for independent centered variables supported on \([-1,\infty)\). For the moment only centered laws with at most two atoms in each coordinate are needed. The constant law gives \(U(0,0)=1\). When the second coordinate equals zero, a two-point centered law in the first shows the ratio \((U(u,0)-1)/u\) is equal for any nonzero arguments on opposite sides of zero. It is therefore a single constant \(k\), and symmetry gives \(U(0,v)=1+kv\).

Define \(D(u,v)=(U(u,v)-1-k(u+v))/(uv)\) for \(uv\ne0\). Centered laws on \(\{a,p\}\) and \(\{b,q\}\), where \(a,b<0<p,q\), give
\[
 D(a,b)-D(a,q)-D(p,b)+D(p,q)=0 .
\]
In each coordinate the positive and negative contributions of the shifted variable to its mean have equal magnitude, which gives the alternating signs. This identity implies
\[
 D(u,v)=D(u,1)+D(1,v)-D(1,1)\quad(uv\ne0).
\]
For two negative arguments set \(p=q=1\). For one negative and one positive, fix a negative argument in the second coordinate and \(p=1\), compare with \(q=1\), and use symmetry for the other mixed quadrant. For two positive arguments fix \(a=b=-1\), compare the identity with each of \(p=1\) and \(q=1\), and subtract the identity with both anchors. By symmetry, taking \(h(0)=k\) and \(h(u)=k+u[D(u,1)-D(1,1)/2]\) at \(u\ne0\) gives a Borel representation
\[
 U(u,v)=1+v h(u)+u h(v).
\]

Write \(c=h(-1)=(1-T(0,0))/2\). Monotonicity and nonnegativity imply \(0\le c\le1/2\). Comparing \(U(u,-1)\) with \(U(-1,-1)\) gives \(h(u)\le c(u+2)\). Comparing \(U(u,t)\) with \(U(-1,t)\) at \(t>0\) gives
\[
 h(u)\ge c-(u+1)h(t)/t.
\]
Substitute the preceding upper bound and let \(t\) tend to infinity to obtain \(h(u)\ge -cu\). Comparing \(U(t,t)\) with \(U(0,0)\) shows \(h(t)\ge0\) for \(t>0\). Also \(h(0)=k\ge0\) by axis monotonicity. In total,
\[
 c(-u)_+\le h(u)\le c(u+2), \qquad u\ge-1 .
\]

Use total capital \(1+c\), assigning half to each reading order. In a given order, put the first dollar wager equal to \(c\), then the second dollar wager equal to \((h(u)-c)_+\) after observing shift \(u\). The first wager fits its allocation since \(c\le(1+c)/2\). The second is at most \(c(u+1)\le (1+c)/2+cu\), so it fits the resulting wealth. If \(\delta(u)=(c-h(u))_+\), the sum of the two ordered payoffs exceeds \(U(u,v)\) by
\[
 c+v\delta(u)+u\delta(v).
\]
Each \(\delta\) is at most \(c\). On mixed signs there is at most one negative term, of magnitude at most \(c\). With both shifts nonnegative there is none. On \(u=-b,v=-d\) with \(b,d\in[0,1]\), the loss is at most
\(c[b(1-d)+d(1-b)]\le c\), since the bilinear bracket has maximum one at the corners of the square. This strategy dominates \(T\), proving the stated upper bound.

For every \(c\in[0,1/2]\) take the archived absolute-value profile \(h(u)=c|u|\). It has \(U(u,v)=1+2cuv\) on the nonnegative quadrant, \(1-2cuv\) on the nonpositive quadrant, and value one on opposite signs. These formulas imply monotonicity and nonnegativity. The linear growth bound lets expectations factor by independence in the representation, giving precision and independent e-validity. For a symmetric target, a dominating strategy can be averaged with its swapped order. At initial capital \(C\), each order then carries capital \(C/2\) and uses the same first dollar stake \(s\). Its second dollar wager \(f(u)\) lies between zero and \(C/2+su\). The aggregate payoff is \(C+s(u+v)+f(u)v+f(v)u\). At \((-1,0)\) the target is one and the payoff is at most \(C-s\), so \(C\ge1+s\). At \((t,t)\), divide by \(t^2\) and let \(t\) tend to infinity. The target has asymptotic coefficient \(2c\) and the maximum possible coefficient of the payoff is \(2s\); hence \(s\ge c\). The capital is exactly \(1+c\). This proves sharpness for the entire range \(T(0,0)=1-2c\), and Corollary 2 gives the product statement.

# 5. Scope and pinned comparison

The archived convex-profile supplement proves a finite-grid product theorem for arbitrary block targets and a full-domain result for its convex-profile family via a specific four-value witness. The finite-grid theorem is credited in Section 3. The full-domain extension here holds for arbitrary coordinatewise nondecreasing targets and provides a mesh factor independent of the target. The sharp bound in Theorem 3 covers all symmetric monotone precise pairs, with the archived profile providing equality. The comparison concerns the pinned repository versions and makes no external priority claim.
