---
title: "Ordinal predictions attain the exact finite-job scheduling frontier"
subtitle: "Causal realization of the numerical-advice snapshots"
lang: en
---

# Ordinal predictions attain the exact finite-job scheduling frontier

## Abstract

A non-clairvoyant scheduler with numerical processing-time predictions has an exact finite-job tradeoff between consistency and robustness. We show that the same tradeoff is attainable when advice supplies only a permutation of the jobs. The optimal snapshot construction depends on a completed prefix and the next job size, but each next size is available only at completion. We implement the snapshots causally by first interpolating toward the last observed size and then letting the next attained service vary along an affine ray. An invariant certifies every point of that ray, including when the advised order is wrong. The result holds for every fixed job count and includes all tie and endpoint regimes.

## 1. Model and claim

There are exactly n≥2 jobs, all released at time zero. Their positive processing sizes x_i are unknown until completion. A deterministic preemptive scheduler can split one unit of processing rate among unfinished jobs and observes completion events. Cost is the sum of completion times. The advice is a permutation, and we relabel jobs in that advised order as 1,…,n. It is correct whenever x_1≤⋯≤x_n, with ties permitted.

Let e_i(t) be the attained service of job i, and put

~~~text
P_n(x)=∑_i x_i+∑_(i<j) min(x_i,x_j),   b_n=2n/(n+1).
~~~

P_n(x) is the offline shortest-processing-time cost. For ordinal advice, consistency is the supremum of cost/P_n(x) over correct orders, and robustness is the supremum over all positive sizes and all permutations. The archived *The exact finite-job consistency–robustness frontier for non-clairvoyant scheduling* proves the exact deterministic frontier c_n(R) for numerical predictions and gives an optimal construction from service snapshots.

**Theorem 1.** For every R∈[b_n,n], the minimum ordinal-advice consistency at robustness at most R is exactly c_n(R). It is attained by a deterministic ordinal scheduler. The scheduler uses only the advised order, past completion sizes, and attained processing. It requires a polynomial number of arithmetic operations for rates and switch calculations, and can always be continued with ordinary round-robin after detecting an inconsistency.

Numerical predictions supply the entire proposed size vector. Ordinal predictions supply none of its scale information. The theorem shows that discarding those magnitudes leaves the full fixed-n deterministic tradeoff intact in this model.

## 2. The archived snapshot family

We recall the ingredients needed to implement the result. For sorted y_1≤⋯≤y_n with y_0=0 and nonnegative gaps Δ_k=y_k−y_(k−1), the archive makes one plan for each all-unit suffix of length n−k+1. At its marked completion stage j, the first j suffix coordinates equal one, and all unfinished coordinates equal q_j^(m) for suffix length m. The sequence q_j^(m) is nondecreasing in j and belongs to [0,1], with q_0^(m)=0. The numerical plan is a sum of these suffix plans weighted by Δ_k. At marked stage i its service vector is

~~~text
e^i(y)= ∑_(k≤i) Δ_k E_(k,i),                                 (1)
~~~

where E_(k,i) embeds suffix stage i−k+1 with zeros before k. Terms from suffixes starting after i are zero. In particular this vector depends only on y_1,…,y_i. Its entries are y_j for j≤i, and every later entry is the same number in [0,y_i], because it sums the nonnegative gaps with coefficients at most one. Also e^0=0. All snapshots of a fixed y are coordinatewise nondecreasing.

For completeness, the unit coefficients in this representation can be precomputed directly from the archive's recurrence. For m=1 or R≥m use the serial plan, with q_j^(m)=0 for j<m. Otherwise put a=⌊(m+1)/(R+1)⌋ and set

~~~text
d_j=[(R−2)(m+1)+(R+2)j]/2,     δ_j=m+1−(R+1)j,
q_j=q_(j−1)+[δ_j/((m−j)d_j)](1−q_(j−1))   for 1≤j≤a.
~~~

For a<j<m keep q_j constant at q_a. The stage m has every entry one. Here R≥b_n≥b_m, so the coefficients are in the regime of the archived theorem.

For every positive sorted y the plan is feasible in the following sense. Write t_i(y)=∑_j e_j^i(y) and

~~~text
F_i(y)=∑_(j<i)t_j(y)+(n−i+1)t_i(y).
~~~

Then F_i(y)≤R P_n(e^i(y)) at each mark, and the marked total cost ∑_i t_i(y) is at most c_n(R)P_n(y). These are the finite snapshot and optimality conclusions of the pinned paper. In our construction the vector y used to justify the inequality is a mathematical variable and is not input advice.

## 3. Ordinal scheduler

During an ordinal phase i, jobs 1,…,i−1 have completed in the advised order and their sizes a_1≤⋯≤a_(i−1) are known. The attained vector is e^(i−1), computed from that completed prefix by (1). All other jobs are unfinished at the start of a phase. Put a_0=0.

For a real u≥a_(i−1), define the fictitious size vector y(u) by setting its first i−1 entries to the observed prefix and its remaining entries all equal to u. Let V_i(u)=e^i(y(u)). By (1),

~~~text
V_i(u)=V_i(a_(i−1))+(u−a_(i−1)) E_(i,i).                    (2)
~~~

Its preferred coordinate i equals u. The vector E_(i,i) has a one in coordinate i, the common suffix coefficient q_1^(n−i+1) in all later coordinates, and zero in the earlier ones. No future actual size enters (2).

First interpolate from e^(i−1) to V_i(a_(i−1)) at constant rates until the endpoint or a completion event. This segment is coordinatewise nondecreasing, since it joins consecutive snapshots for y(a_(i−1)). For i=1 it is the zero segment, which is omitted. Then increase u along (2) until a completion event. Normalize the positive direction by its coordinate sum so that the machine works at unit total rate. Each segment uses constant rates and never allocates to previously completed jobs.

At an event, try to mark job i and any simultaneous completions. This is allowed if the new completions are a consecutive prefix starting at i, have the same size a_i≥a_(i−1), and the attained state agrees with every newly marked snapshot of (1) at their observed sizes. If any check fails, give equal rates to all actually unfinished jobs thereafter. If the checks pass, skip directly to the next unmarked job.

For a single accepted completion, the test is that the event completes job i with size at least a_(i−1) at the vector V_i(a_i). Batches are verified using their observed sizes only. All checks are causal. If the active ray has no earlier completion it eventually finishes its preferred job because that coordinate's rate is positive. Thus every active phase ends at a finite time, as does any round-robin continuation.

## 4. Robustness for every advised order

Let F(t)=∫_0^t N(s) ds where N(s) is the number of actually unfinished jobs. We maintain F(t)≤R P_n(e(t)). Work conservation gives t=∑_j e_j(t). Immediately before the next completion in phase i, there are exactly n−i+1 unfinished jobs, and the previous completion times are the corresponding marked snapshot sums. Accordingly

~~~text
F(t)=∑_(j<i)t_j+(n−i+1)t.                                    (3)
~~~

At the interpolation endpoint use the archived snapshot for the fictitious y(a_(i−1)). The earlier times depend only on the completed sizes, so the inequality for that endpoint uses the same expression (3). It also holds at the initial endpoint by the previous accepted mark. The function P_n is concave, so along the segment P_n(e(t)) lies above the chord between endpoint values, while (3) is affine. This proves the inequality there even if the actual run ends the segment early.

On the ray, each point is the marked snapshot V_i(u) of the sorted y(u). For i=1 use only u>0 and obtain the initial inequality by continuity. Its earlier marked times agree with the actual earlier ones. Thus its snapshot inequality is exactly the desired bound for (3). Completion events do not change attained services or accumulated cost discontinuously. Accepting a batch whose marked states coincide preserves both the invariant and the phase-start premise.

On switching to equal rates, if N jobs remain, the linear part of P_n grows at rate one. Unfinished-unfinished minima grow at total rate (N−1)/2, and completed-unfinished minima contribute a nonnegative rate. Thus almost everywhere

~~~text
(P_n(e))' ≥ (N+1)/2,     (F−RP_n(e))' ≤ N−R(N+1)/2 ≤ 0,
~~~

since R≥b_n≥2N/(N+1). The inequality remains true through completions by continuity. At termination e=x and F is the total completion cost, proving the R robustness guarantee.

## 5. Correct advice never triggers the fallback

Assume the advised order is correct. At the start of phase i all later service coordinates are equal. Along the interpolation the preferred coordinate i is at least every later coordinate, since this holds at both endpoints. On the ray it equals u and later coordinates are at most u. A later job therefore cannot complete strictly before the preferred job.

On the interpolation the preferred job approaches the preceding completed size a_(i−1). Since x_i is at least that large, it cannot finish before the endpoint when the interpolation changes its service. If its service at the start already equaled a_(i−1)=x_i, it would have completed in the preceding batch, so it would already be marked. This covers a constant preferred coordinate on a nonzero interpolation. Thus its actual completion occurs at V_i(x_i), either at the endpoint or on the ray.

If another job completes at the same event, both the nonpreferred service and that job's size must equal x_i: the service is at most x_i and its true size is at least x_i. All later coordinates have that same service. Consequently all simultaneous completions form precisely the next consecutive block of jobs tied at x_i. Their subsequent snapshots in (1) agree with V_i(x_i). Indeed the unfinished service x_i is the sum of positive gaps times coefficients in [0,1], and the sum of those gaps equals x_i. This forces each positive-weight unfinished coefficient to be one. Such coefficients remain one at later stages by monotonicity, and all additional gaps inside the tied block vanish. Thus every mark in the batch occurs at the same attained vector and all event checks pass. For a final batch ending at n the same reasoning gives the final all-completed vector.

Induction proves that the ordinal scheduler realizes exactly the marked snapshots of the numerical plan for the actual sorted size vector, including coincident marks. Its cost is therefore at most c_n(R)P_n(x). The numerical magnitudes are recovered only for the completed prefix; the ray executes a fixed rate vector while waiting for the next unknown size.

For the matching lower bound, any ordinal algorithm induces a numerical-advice algorithm by sorting the predicted sizes, with a fixed tie rule. Arbitrary numerical inputs give only valid ordinal permutations, so robustness cannot increase. When numerical advice is correct its order is correct, so numerical consistency is no greater than the ordinal consistency. The pinned optimal numerical frontier therefore lower-bounds the ordinal frontier. Together with the construction this proves Theorem 1.

## 6. Arithmetic and scope

All unit coefficients for suffixes have O(n²) entries. Their recurrence takes O(n²) arithmetic operations. The snapshot at a mark uses the known prefix and a single common service for the remaining jobs. Evaluating it takes O(n) arithmetic operations, and at most n marks need to be evaluated. Each phase has at most one interpolation and one ray. A round-robin continuation requires only rates based on the number of remaining jobs. The O(n²) arithmetic bound excludes the physical execution and is in the same continuously divisible-rate model as the archive.

The proof uses the pinned numerical frontier and its prefix-dependent snapshot construction. Its contribution is an online implementation using order alone, including the robust path before any observed misordering and the handling of exact ties. The theorem concerns deterministic algorithms, positive processing sizes, unit capacity, fractional service, and common release time. It does not claim the same result for indivisible service or for other scheduling objectives. The source comparison is limited to the pinned repository record.
