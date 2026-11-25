---
title: "Exact phase complexity of discrete CVaR ski rental"
subtitle: "A quadratic event bound and a cubic rational sweep"
date: "25 November 2026"
geometry: margin=0.9in
---

## Abstract

In discrete ski rental, the optimal competitive ratio under conditional value-at-risk (CVaR) depends on the risk level and the integer purchase cost \(B\). An earlier exact construction gave a finite rational partition of the risk interval but left the size of that partition open. We show that the randomized regime has at most \(B(B-1)/2\) pieces. The cumulative capacity functions have strictly ordered slopes on every affine interval. Each candidate event therefore happens at most once, and each interior event makes a strict change in the optimal value formula, even when events coincide. A sweep outputs all breakpoints and optimal probability formulas in \(O(B^3)\) rational operations using \(O(B\log B)\)-bit rational numbers. The number of row events, counted with multiplicity, is \(\Theta(B^2)\). The description extends through the deterministic-value plateau with an exact membership test for all optimal strategies.

## 1. Setting and result

Renting costs one per day and buying costs an integer \(B\ge2\). A strategy chooses a random purchase day \(J\in\mathbb N\cup\{\infty\}\). A season of length \(s\) costs \(s\) if \(J>s\) and \(B+J-1\) otherwise. The offline cost is \(\min(s,B)\). For a tail mass \(q\in(0,1]\), the objective is the maximum over positive integer \(s\) of the average cost in the worst probability mass \(q\), divided by \(\min(s,B)\). At \(q=0\) use the essential supremum. Denote the optimal value by \(v_B(q)\). The standard CVaR level is \(\delta=1-q\).

Christianson, Sun, Low and Wierman [1] introduced this risk-sensitive formulation and asked for the full discrete tradeoff near the end of their Section 4. The archived work [2] constructed it exactly for all \(B\), leaving a bound on the number of pieces and the cost of producing them open (§§7–7.1 and §10). We address that subsequent problem.

Write \(h=(B-1)/B\) and \(r=v_B(q)-1\) in the randomized regime. We use the cumulative capacities \(U_0=0,U_1,\dots,U_B\) from [2]. For \(r\in(0,h)\), \(U_i(r)\) is the unique root in \((U_{i-1}(r),1+U_{i-1}(r))\) of
\[
 F_i(t;U)=ir,\qquad
 F_i(t;u)=(B-1)\min(1,t)-\sum_{j=1}^{i-1}(\min(1,t)-t+u_j)_+.
\]
Here \(F_i\) is only used at \(t\ge u_{i-1}\), and \(x_+=\max(0,x)\). The capacities are continuous on \([0,h]\). At zero they vanish, and \(U_B(h)=1+U_{B-1}(h)\) is the left limit. For \(i<B\) the same root equation applies at \(h\). Put \(K=U_B(h)\), \(q_c=1/K\), and let \(a\) denote the unique value with \(U_B(a)=1\). By [2, Theorem 1 and Lemma 6], on \(q_c<q\le1\) there is a unique optimizer, given by
\[
 U_B(r)=1/q,\qquad v_B(q)=1+r,\qquad
 p_i=q(U_i(r)-U_{i-1}(r)).
\]
For \(0\le q\le q_c\), the value is \(1+h\), achieved by buying on day \(B\).

**Theorem 1.** The interior breakpoints of the *minimal* partition of \(v_B\) into formulas \(A+C/q\) on \(q_c<q<1\) correspond under \(q=1/U_B(r)\) to the distinct points \(r\in(a,h)\) satisfying
\[
 U_i(r)=1\quad (2\le i<B),
 \qquad\text{or}\qquad
 U_i(r)-U_j(r)=1\quad (1\le j\le i-2,\ i\le B).
 \qquad\text{(1)}
\]
Each indexed equality has at most one such point. It has one exactly when its left-hand side at \(h\) exceeds \(1\). Thus there are at most \(1+(B-2)+(B-1)(B-2)/2\le B(B-1)/2\) randomized pieces. The same partition supplies affine formulas in \(q\) for every optimizer probability. All rational endpoints and coefficients can be output in \(O(B^3)\) rational operations with \(O(B\log B)\) bits per rational (for example, \(O(B^6(\log B)^3)\) bit operations with elementary arithmetic). There are \(\Theta(B^2)\) indexed events for large \(B\), counted with multiplicity when they share a point.

## 2. Capacity geometry

For \(i\ge1\), define the candidates
\[
 L_i=\frac{ir+\sum_{j<i}U_j}{B-1},\qquad
 Q_{i,\ell}=1+\frac{ir-(B-1)+\sum_{\ell\le j<i}U_j}{i-\ell},
 \qquad 1\le\ell<i,
\]
where sums over \(j<i\) begin at \(j=1\). At \(t=U_i\le1\), the root equation gives \(t=L_i\) and
\[
 Q_{i,\ell}-1
 =\frac{(B-1)(t-1)-\sum_{j<\ell}U_j}{i-\ell}\le t-1.
\]
For \(t>1\), the positive terms \(1-t+U_j\) form a nonempty suffix. Its sum is \(B-1-ir\). Every suffix sum of the signed terms is at most that sum, with equality for the positive suffix. This gives \(Q_{i,\ell}\le t\) with equality at the positive suffix. Also,
\[
 (B-1)L_i=B-1+\sum_{j<i}\min(U_j,t-1)\le (B-1)t.
\]
We have established the identity
\[
 U_i=\max\{L_i,\ Q_{i,1},\ldots,Q_{i,i-1}\}.
 \qquad\text{(2)}
\]
By continuity it extends to both endpoints. Every form has nonnegative coefficients on the earlier capacities, and (2) proves inductively that all \(U_i\) are convex, continuous, finite piecewise-affine functions. Their affine coefficients are rational. In particular the one-sided slopes never decrease at a join.

### 2.1. Strictly ordered slopes

On a common open affine interval, write \(s_i=U_i'\), \(s_0=0\). One can refine the interval by active branches when proving the claim. Each root strictly increases in \(r\), and a positive root either uses \(L_i\) or uses the positive suffix starting at some \(\ell_i\). In any interior where \(U_i>1\) and a suffix term is identically zero, omitting that term gives the same candidate and derivative. Thus the following argument also applies to such an interval. We prove \(s_{i+1}>s_i\) by induction, starting with \(s_1=1/(B-1)>0\).

If both rows use \(L\), the increment is \((1+s_i)/(B-1)>0\). If row \(i\) uses \(L\) and row \(i+1\) uses the suffix starting at \(\ell\), the latter slope has numerator
\[
 i+1+\sum_{j=\ell}^i s_j
 = B s_i+1-\sum_{j<\ell}s_j
 \ \ge\ (B-\ell+1)s_i+1.
\]
Its denominator is \(i+1-\ell\), so the quotient exceeds \(s_i\). Once a row is above one, all subsequent rows are above one. If both rows use suffixes, \(U_{i+1}>U_i\) implies \(\ell_{i+1}\ge\ell_i\). Keeping \(\ell_i\) for the moment would give slope \(s_i+1/(i+1-\ell_i)\). Removing leading terms of slope at most \(s_i\) only increases that quotient. This proves the claim.

It follows by continuity and finite piecewise affinity that each difference \(U_i-U_j\) with \(i>j\) is strictly increasing on \([0,h]\). At \(a\), \(U_B(a)=1\) and \(0<U_j(a)<1\) for \(1\le j<B\), so each candidate in (1) starts below one. At \(h\), equality is an endpoint rather than an interior event. In the interior, \(U_1=r/(B-1)<1\) and the immediate-predecessor gap is less than one. This proves the occurrence test in Theorem 1.

### 2.2. Every interior event changes the optimal value formula

Consider first \(U_i=1\) for \(i<B\). The row changes from denominator \(B-1\) to denominator \(i-1\), retaining all older slopes in its numerator. Those slopes cannot fall, and the positive numerator was already at least \(i\). Hence the row has a strict slope increase.

At \(U_i-U_j=1\), \(U_j>0\), so the row is in its suffix regime. Because the earlier capacities are strictly ordered by index, exactly one suffix entry of row \(i\) is removed there. Let \(m\ge2\) be the preceding length and let \(\sigma\) be the preceding slope of row \(i\). The following slope is at least
\[
 \frac{m\sigma-U_j'{}^-}{m-1}>\sigma,
\]
using the strict slope ordering and convexity of the other entries. This argument allows other rows to change simultaneously.

A kink in \(U_i\) propagates to \(U_{i+1}\). Choose a candidate in (2) active at the given point for row \(i+1\). Both the linear candidate and every suffix candidate contain \(U_i\) with a positive coefficient. Consequently the candidate has a strict slope increase there. A convex function lying above it and touching there has left derivative at most the candidate's left derivative and right derivative at least its right derivative. Hence \(U_B\) has a strict slope increase at every event in (1). Conversely, away from those events the branch identities stay fixed locally, so all rows are affine there by induction. This proves that (1) describes exactly the interior kinks of \(U_B\) in \((a,h)\).

If on one interval \(U_i=s_i r+b_i\), including \(i=0\), the value and its optimizer on the corresponding \(q\) interval are
\[
 v_B(q)=1-\frac{b_B}{s_B}+\frac{1}{s_Bq},
\]
\[
 p_i(q)=\frac{s_i-s_{i-1}}{s_B}
 +q\left(b_i-b_{i-1}-\frac{b_B(s_i-s_{i-1})}{s_B}\right).
 \qquad\text{(3)}
\]
Adjacent capacity slopes differ at every event, so the two coefficients of \(1/q\) differ. Therefore these are actual changes in the value formula and (3) gives a common minimal partition. Continuity gives the usual endpoint values.

## 3. Exact sweep and bit cost

Set \(\rho=B/(B-1)\). The first branch for every row gives \(U_i(r)=r(\rho^i-1)\) as long as the last root is at most one. In particular the first sweep endpoint is \(a=1/(\rho^B-1)\). Suppose \(x\in[a,h)\) is the current endpoint.

1. Compute \(U_i(x)\) in order. Maintain their prefix sums and a pointer to the first active suffix index. If \(L_i(x)<1\), use the linear branch. If \(L_i(x)\ge1\), evaluate \(Q_{i,\ell}\) with the previously retained suffix extended by the new predecessor. Delete its oldest entry while \(Q_{i,\ell}(x)\ge 1+U_\ell(x)\), then recompute. The predecessor is strictly active and will remain in the suffix. At \(L_i=1\) the suffix contains all earlier rows and is the branch immediately to the right. This is the linear-time point evaluation of [2, §7.1] with equality entries removed. The first possible deletion point cannot move left as \(i\) increases because \(U_i(x)\) increases in \(i\).
2. These branches hold immediately to the right of \(x\) by the strict monotonicity of the individual capacities and differences. Compute the corresponding affine coefficient pairs in row order, maintaining two coefficient prefix sums. Their values at \(x\) are the capacities just computed.
3. In a linear row the next candidate is \(U_i=1\). In a suffix row the only candidate needed is \(U_i-U_{\ell}=1\), with \(\ell\) the oldest still active entry. It must be first among that row's possible drops because the active capacities are ordered. Test each affine equality using the coefficients from step 2. The least time strictly greater than \(x\), clipped at \(h\), is the next endpoint.

For step 1, if some retained entry is zero or negative according to the provisional threshold \(Q_{i,\ell}(x)-1\), removing it weakly raises the candidate, so it cannot revive. Earlier entries already removed are inactive for the true root by monotonicity of the roots in row order. When the oldest retained entry is positive, every retained entry is positive and removing any initial segment would lower the candidate. The current suffix thus maximizes among starts still under consideration. The exact positive suffix started among those starts, so the candidate equals the true root. For step 3, each selected equality has a positive candidate slope except when there is no such candidate. Before the earliest candidate time, none of the local branch inequalities can become invalid: the first equality in a changing branch would be among those tested. Continuity extends the formulas to the cell's right endpoint. Evaluation and restart there handle every simultaneous event in one step, with no duplicate or zero-length intervals.

With \(E\) distinct interior events, the sweep takes \(O(B(E+1))\) rational operations and writes \(O(B(E+1))\) rational entries in the dense formula table. For a fixed cell, let \(d_i\) be the denominator in the selected recurrence in row \(i\), so \(1\le d_i\le B-1\). All coefficients through row \(i\) have a common denominator dividing \(\prod_{k=1}^i d_k\). Their absolute values are at most \(B2^i\): in a new row the absolute value is bounded by \(B\) plus the sum of the preceding absolute values. Thus the bit lengths of the coefficients are \(O(B\log B)\). A breakpoint is a quotient of a difference of coefficients and an integer shift of another difference, so it has the same bit bound. The scalar inverse and all probabilities in (3) use only a constant number of operations on these rationals per row. During point evaluation the common denominator is controlled by the denominator of \(x\) times the product of the already selected \(d_i\), and at most one further trial denominator. Rational comparisons and arithmetic on reduced rationals of bit size \(L\) take at most \(O(L^3)\) bit operations by integer arithmetic and the Euclidean algorithm. This gives the stated conservative polynomial bit bound. Complexity is measured in \(B\), as the explicit output already includes \(B\) probabilities even on a single interval.

### All optimizers on the plateau

For \(0<q\le q_c\), the set of optimal strategies is exactly the set of distributions supported on days \(1,\ldots,B\) for which the normalized cumulative sums \(S_i=q^{-1}\sum_{j\le i}p_j\) satisfy
\[
 F_i(S_i;S)\le ih,\qquad 1\le i<B.
 \qquad\text{(4)}
\]
Indeed, these inequalities are necessary by the tail integral identity of [2, §4]. By its cumulative comparison lemma they imply \(S_{B-1}\le U_{B-1}(h)\). Hence \(p_B=1-qS_{B-1}\ge q\) and the largest loss in season \(B\) fills the whole tail. This proves sufficiency. Moreover, capping any optimum at day \(B\) gives a capped optimum by [2, §3]. Its terminal risk is \(1+h\) by the same argument. Any positive mass at later days strictly raises the terminal tail at season \(2B\) relative to that capped strategy, so the original strategy could not have been optimal. At \(q=0\) buying on day \(B\) is the unique optimum by [2]. A continuous selection through \(q_c\) uses \(p_i=q(U_i(h)-U_{i-1}(h))\) for \(i<B\), assigning the remainder to day \(B\), as in [2, §6.1].

## 4. Quadratically many indexed events

We use the explicit critical lower barrier proved in [2, §8]. For \(B\ge16\), \(m_0=\lfloor B/8\rfloor\), and \(1\le m\le B-1\), it gives
\[
 U_{B-m}(h)\ge \frac1c\log\frac{m_0+1}{m+1},
 \qquad e^c=1+2c,\qquad 1<c<\frac32.
\]
For \(B\ge256\) and \(1\le m\le\lfloor B/256\rfloor\), the ratio is at least \(16\), whereas \(e^{2c}=(1+2c)^2<16\). Thus \(U_{B-m}(h)>2\). For \(j\le\lfloor B/4\rfloor\), the formula for the sequence on its first branch at \(h\) is \(h(\rho^j-1)<e^{1/3}-1<1/2\): indeed \(j/(B-1)\le1/3\) for \(B\ge4\), and \(\log(3/2)>1/3\) by integration. These candidates are all below one, so they are the true roots by induction. Every such pair \(i=B-m,j\) gives \(U_i(h)-U_j(h)>1\) and thus one interior deletion. There are at least \(\lfloor B/4\rfloor\lfloor B/256\rfloor\) indexed deletions. This lower bound counts indexed events. Holding any one of these \(i\) fixed gives \(\lfloor B/4\rfloor\) distinct points, since two different \(U_j\) values cannot tie in one row. The exact distinct-point count is obtained by the sweep, which merges simultaneous events. For the count with multiplicity alone one can evaluate the endpoint vector in \(O(B)\) rational operations, as in [2, §7.1], and count \(U_i(h)>1\) for \(i<B\). For the gaps, each row counts earlier entries strictly below \(U_i(h)-1\). Because these cutoffs increase with \(i\), a single advancing pointer counts all such pairs in another \(O(B)\) operations. Equality is always excluded in this critical-endpoint count.

## References

[1] Nicolas Christianson, Bo Sun, Steven Low and Adam Wierman. *Risk-Sensitive Online Algorithms*. arXiv:2405.09859v2 (2024), §4 and Appendix C. COLT 2024 extended abstract, PMLR 247:1140–1141.

[2] earlier research manuscript. *Exact risk phases in discrete ski rental: A rational capacity construction for the complete CVaR tradeoff*, 24 November 2026. earlier research manuscript commit bb30fe2, §§2–8 and §10.
