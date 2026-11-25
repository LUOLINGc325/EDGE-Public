# The exact finite-job consistency–robustness frontier for non-clairvoyant scheduling

**Research manuscript, 25 November 2026.** This manuscript is an AI-assisted research draft. It presents written proofs and finite certificate descriptions, without external peer review, global priority or full Lean verification. This version does not include the reproduction programs and formal source.

## Abstract

We study deterministic preemptive single-machine scheduling with positive predicted processing times and the sum of completion times objective. For every fixed number of jobs, we determine the exact tradeoff between performance on correct predictions and worst-case performance on arbitrary predictions. The frontier equals the finite-job lower bound proposed by Li, Christianson and Li, resolving their finite-job tightness conjecture in the stated model. The construction completes a finite-dimensional reduction: feasible completion snapshots are closed under nonnegative addition because the optimum of a frozen instance is superadditive. Every sorted prediction vector decomposes into equal-job suffixes. We construct optimal schedules on these generators, prove that their normalized costs increase with the number of jobs, and combine them into an optimal schedule for arbitrary predictions. A round-robin continuation preserves robustness after the first prediction error. The resulting algorithm uses a polynomial number of arithmetic operations and handles simultaneous completions and the boundary below robustness two. The proof is finite-sample and does not take a limit in the number of jobs.

## 1. Model, prior work, and the precise claim

There are exactly $n\ge2$ jobs, released at time zero. Their actual sizes $x_i>0$ are unknown until completion. The algorithm is given arbitrary predictions $y_i>0$. At each time it selects nonnegative processing rates with sum at most one, using only predictions and information already observed. Preemption and fractional sharing are allowed. The cost is the sum of all completion times. Randomized algorithms, release dates, weights, and multiple machines are outside the model.

For $v\in\mathbb R_+^n$, write

$$
 P_n(v)=\sum_i v_i+\sum_{i<j}\min(v_i,v_j),\qquad Q_n=\frac{n(n+1)}2,
 \qquad b_n=\frac{2n}{n+1}.
$$

The shortest-processing-time rule gives the offline optimum $P_n(x)$. For a fixed number of jobs, define

$$
 \operatorname{cons}_n(A)=\sup_{y>0}\frac{\operatorname{cost}_A(y,y)}{P_n(y)},
 \quad
 \operatorname{rob}_n(A)=\sup_{x,y>0}\frac{\operatorname{cost}_A(x,y)}{P_n(x)}.
$$

Wei and Zhang [S3] give the early tradeoff bounds and the exact two-job case. Li, Christianson and Li [S1] give a stronger finite-$n$ lower bound $\Phi^{(n)}(\lambda)$, defined by their finite Order-$a$ systems, and explicitly conjecture that it is attainable. Benomar and Perchet [S2] establish the exact frontier when the supremum also ranges over all job counts. Their frozen-instance invariant is a central input to the present work; their worst-case-over-$n$ theorem does not establish the fixed-$n$ conclusion below.

**Theorem 1 (exact finite-job frontier).** For every $n\ge2$ and every $R\in[b_n,n]$,

$$
 \inf_{\operatorname{rob}_n(A)\le R}\operatorname{cons}_n(A)=c_n(R),
$$

where $c_n$ is given by the explicit recurrence in Section 3. The infimum is attained by the deterministic algorithm in Section 6. The function $c_n$ is continuous and strictly decreasing on $[b_n,n]$, with

$$
 c_n(b_n)=b_n,\qquad c_n(n)=1.
$$

Equivalently, for $0\le\lambda\le(n-1)/(n+1)$,

$$
 \boxed{\inf_{\operatorname{cons}_n(A)\le1+\lambda}
 \operatorname{rob}_n(A)=\Phi^{(n)}(\lambda).}
$$

Here $\Phi^{(n)}$ is exactly the function defined in [S1, Definitions 3.7–3.8], not a replacement definition. Section 7 identifies the two descriptions.

The principal new step is the passage from equal-job witnesses to a feasible algorithm valid for every prediction vector, together with the all-parameter dimension comparison needed to preserve the exact finite-job ratio. The superadditivity argument for round-robin continuation already appears in [S1, Lemma 4.2], and the nonnegative gap decomposition appears in [S1, Section 4.3]. The inverse unit recursion, branch matching, and related product expressions are also present in [S1, Appendices A.1 and B.6]. Our use of those ingredients does not constitute a separate novelty claim. The frozen invariant, the earlier equal-job attack systems, and the worst-case-over-$n$ frontier retain their original attribution. We include a direct finite-$n$ lower-bound proof so that the conclusion does not depend on an unproved symmetry principle for arbitrary schedules. In particular, we do not assume that the MRC algorithm itself has an equal-length worst case.

## 2. A finite description of robust schedules

Let $e_i(t)$ be attained processing and let $N(t)$ count unfinished jobs. The cost paid by time $t$ is

$$
 F(t)=\int_0^t N(u)\,du.
$$

The frozen-instance invariant from [S2] is

$$
 F(t)\le R P_n(e(t)). \tag{1}
$$

It is necessary for any deterministic $R$-robust algorithm. Fix a run and a time $t$. Keep already completed sizes unchanged and set every unfinished size to $e_i(t)+\varepsilon$. Until $t$, this strictly positive instance is indistinguishable from the original run. Its optimum tends to $P_n(e(t))$ as $\varepsilon\downarrow0$, whereas the algorithm has already paid $F(t)$. This argument also permits an algorithm that idles. If a finite-cost schedule has completion times $T_1\le\cdots\le T_n$, then its cost paid at $T_k$ is $\sum_{j<k}T_j+(n-k+1)T_k$, including tied completions.

The same argument before the first completion shows that $R\ge b_n$ is necessary: if no job has finished and total attained work is at most $t$, then

$$
 P_n(e)\le\frac{n+1}{2}\sum_i e_i\le\frac{n+1}{2}t,
 \qquad F(t)=nt.
$$

The zero-work case would itself contradict a finite robustness guarantee. Ordinary round-robin attains $b_n$.

### 2.1 Completion snapshots

For a nonnegative predicted vector $y$ and the desired completion order $1,\ldots,n$, a snapshot plan consists of $e^0,\ldots,e^n$ satisfying

$$
 e^0=0,\quad 0\le e_i^{k-1}\le e_i^k\le y_i,
 \quad e_i^k=y_i\ (i\le k),\quad e^n=y.
$$

Define

$$
 t_k=\sum_i e_i^k,\quad t_0=0,\qquad
 F_k=\sum_{j<k}t_j+(n-k+1)t_k. \tag{2}
$$

Call the plan feasible at $R$ when $F_k\le R P_n(e^k)$ for every $k$. Its marked cost is $\sum_k t_k$.

**Lemma 2 (implementation).** For $R\ge b_n$, every feasible snapshot plan for a positive vector $y$ extends to a deterministic $R$-robust algorithm. On correct predictions its cost is at most the marked cost.

**Proof.** On $[t_{k-1},t_k]$, linearly interpolate $e^{k-1}$ and $e^k$. Skip zero-length intervals. Rates are nonnegative and sum to one. Give this interval a virtual unfinished count $n-k+1$. The resulting virtual accumulated cost is affine on each interval and has endpoint values (2).

The function $P_n$ is concave: each pairwise minimum is concave. Thus virtual cost minus $R P_n(e)$ is convex along each segment. Its endpoint values are nonpositive, so it is nonpositive throughout the segment. If a coordinate reaches $y_i$ earlier than its marked completion, the upper bound and monotonicity force that coordinate to remain constant in all later snapshots. Such an early completion therefore receives no subsequent processing, and the true unfinished count, and hence true cost, can only be smaller than the virtual count and cost.

Run this plan until a job finishes before receiving $y_i$, or reaches $y_i$ without finishing. Before this first mismatch, actual attained work is the planned work and (1) holds. At the mismatch time $F$ and $P_n(e)$ are continuous. Thereafter share the machine equally among all truly unfinished jobs. If their number is $N$, the diagonal part of $P_n$ grows at rate one, the unfinished–unfinished pairs contribute $(N-1)/2$, and completed–unfinished pairs contribute a nonnegative amount. Almost everywhere,

$$
 \frac{d}{dt}P_n(e(t))\ge\frac{N+1}{2},
 \quad
 \frac{d}{dt}(F-RP_n(e))\le N-R\frac{N+1}{2}\le0. \tag{3}
$$

The last inequality uses $R\ge b_n\ge b_N$. These functions are continuous and piecewise linear, and all jobs finish in finite time. At termination $P_n(e)=P_n(x)$, which proves robustness. This continuation uses no unknown processing time. Simultaneous mismatch and completion events use the unfinished set immediately after the event. ∎

### 2.2 Positive combinations of plans

For nonnegative $u,v$ and $s\ge0$,

$$
 P_n(su)=sP_n(u),\qquad
 P_n(u+v)\ge P_n(u)+P_n(v). \tag{4}
$$

Indeed, $\min(u_i+v_i,u_j+v_j)\ge\min(u_i,u_j)+\min(v_i,v_j)$. Snapshot times and marked costs are linear functions of the snapshots. Consequently, plans with the same marked completion order can be added with nonnegative coefficients while preserving feasibility. This assertion is about service snapshots, not sequential concatenation of schedules in physical time.

The finite optimization over snapshots is a linear program: introduce $z_{ij}^k\ge0$, impose $z_{ij}^k\le e_i^k,e_j^k$, and replace $P_n(e^k)$ by $\sum_i e_i^k+\sum_{i<j}z_{ij}^k$ in the lower bound on its right side. Existence of such $z$ is equivalent to the original constraint. For a fixed completion order its value is positively homogeneous and subadditive in $y$. The explicit construction below does not need to solve this LP on each prediction vector.

## 3. Optimal unit-job plans

Set $c_1(R)=1$ for $R\ge1$. For $m\ge2$ and $R\ge m$, use the serial unit-job plan and set $c_m(R)=1$. Consider henceforth

$$
 b_m\le R<m,\qquad
 a=\left\lfloor\frac{m+1}{R+1}\right\rfloor\in\{1,\ldots,m-1\}.
$$

An integer threshold may instead use $a-1$; both choices have the same value. Put

$$
 A_i=\frac{i(2m+1-i)-R i(i+1)}2,\quad
 d_i=\frac{(R-2)(m+1)+(R+2)i}{2},\quad
 \delta_i=m+1-(R+1)i. \tag{5}
$$

With $q_0=0$, define for $1\le i\le a$

$$
 q_i=q_{i-1}+\frac{\delta_i}{(m-i)d_i}(1-q_{i-1}), \tag{6}
$$

and set $q_i=q_a$ for $a<i<m$. The $k$-th snapshot has its first $k$ coordinates equal to one and the remaining $m-k$ coordinates equal to $q_k$; the last snapshot is the all-one vector. Define

$$
 E_i^*=(m-i)q_i,\quad S_i^*=\sum_{j=1}^iE_j^*,\qquad
 c_m(R)=1+\frac{S_{a-1}^*+(m-a)(m-a+1)q_a/2}{Q_m}. \tag{7}
$$

### 3.1 Feasibility at every time

First $d_i>0$: at the smallest allowed $R=b_m$, $d_1=m/(m+1)>0$, and $d_i$ increases with $i$ and $R$. Also $\delta_i\ge0$ for $i\le a$. The identity

$$
 (m-i)d_i-\delta_i=(m-i+1)(d_{i-1}+1) \tag{8}
$$

shows that the multiplier $\delta_i/((m-i)d_i)$ is at most one. For $i=1$, $d_0+1=((R-2)(m+1)+2)/2\ge0$; for subsequent indices it is positive. Hence $0\le q_{i-1}\le q_i\le1$. At $R=b_m$, $q_1=1$; all unit jobs then finish simultaneously.

Using $A_i-A_{i-1}=\delta_i$, (6) and (8) give

$$
 d_iE_i^*=A_i+S_{i-1}^* \qquad(1\le i\le a). \tag{9}
$$

At snapshot $i\le a$, the invariant deficit $F_i-RP_m(e^i)$ equals $A_i+S_{i-1}^*-d_iE_i^*=0$. For $i>a$, direct substitution gives

$$
 F_i-RP_m(e^i)=(1-q_a)(A_i-A_a)\le0. \tag{10}
$$

The inequality follows because $A_{i+1}-A_i=m-i-R(i+1)$, so $A_i$ is maximal at the selected $a$ (possibly also at $a-1$). Equation (10) includes the final snapshot. Linear interpolation and Lemma 2 now prove feasibility throughout the schedule, not merely at the attack times appearing in the prior lower bound.

### 3.2 Matching lower bound without a symmetry assumption

Consider any deterministic $R$-robust algorithm on $m$ jobs with correct unit predictions. Relabel by its actual completion order, breaking simultaneous ties arbitrarily. Let $T_i$ be the $i$-th completion time and $E_i$ the sum of attained service of the $m-i$ remaining jobs at that time. Define $S_i=\sum_{j\le i}E_j$. Capacity gives $T_i\ge i+E_i$, even if the algorithm idles. Therefore its excess over $Q_m$, denoted $H$, satisfies $H\ge\sum_{i<m}E_i$.

At completion $i$, write $Z_i$ for the sum of pairwise minima among the remaining attained services. Then

$$
 P_m(e(T_i))=Q_i+(i+1)E_i+Z_i,
 \qquad Z_i\le\frac{m-i-1}{2}E_i.
$$

The paid cost is at least $i(2m+1-i)/2+S_{i-1}+(m-i+1)E_i$. Substitution in the necessary invariant gives

$$
 d_iE_i\ge A_i+S_{i-1}. \tag{11}
$$

Since $d_i>0$, induction using (9) yields $E_i\ge E_i^*$ and $S_i\ge S_i^*$ for $i\le a$.

A tail term must be retained; merely summing these prefix inequalities is insufficient. The pairwise tail accounting and the ensuing inequality are already explicit in [S2, Lemma E.4 and its proof]; we retain the full finite expression to identify equality with the constructed plan. Every pair of jobs remaining at completion $a$ contributes at least the minimum of its two attained services to $\sum_{i>a}E_i$, when the earlier of that pair subsequently completes. Thus

$$
 H\ge S_{a-1}+E_a+Z_a.
$$

The unsimplified invariant at $a$ implies

$$
 RZ_a\ge A_a+S_{a-1}+(\delta_a-R)E_a,
$$

and consequently

$$
 H\ge(1+1/R)S_{a-1}+A_a/R+\delta_a E_a/R.
$$

Both coefficients multiplying $S_{a-1}$ and $E_a$ are nonnegative. Substitute their lower bounds and use

$$
 d_a+\delta_a=\frac{R(m-a+1)}2,
 \quad A_a+S_{a-1}^*=d_aE_a^*,
$$

to obtain

$$
 H\ge S_{a-1}^*+\frac{m-a+1}{2}E_a^*=(c_m(R)-1)Q_m. \tag{12}
$$

This equals the marked cost excess of the constructed plan. Equal service among unfinished jobs is therefore proved optimal for this unit instance; it was not assumed for an arbitrary algorithm. The recurrence and tail accounting here are a self-contained presentation of the relevant finite terms in [S1] and [S2], not a claim of a new lower-bound method.

## 4. Monotonicity in the finite number of jobs

The remaining essential inequality is

$$
 c_m(R)\le c_n(R)\quad (1\le m\le n, R\ge b_n). \tag{13}
$$

Dummy-job padding alone does not prove (13): it concerns the full problem, whereas $c_m$ has so far been established only on the unit instance.

### 4.1 Product formula

For $H=m+1$, (8) telescopes the factors $1-q_i$. Substitution in (7) yields

$$
 c_m(R)=R-
 \left(R-1+\frac{(R+1)a}{H}\right)
 \prod_{j=1}^{a}\left(1-\frac{R}{(R-2)H+(R+2)j}\right). \tag{14}
$$

An empty product, used when $m\le R$, gives $c_m=1$. We prove monotonicity by extending the expression continuously in the real variable $H$, with $a=\lfloor H/(R+1)\rfloor$. When $R<2$, the relevant domain is $H\le2/(2-R)$, exactly the restriction $R\ge b_{H-1}$.

At a branch boundary $H=(R+1)a$, the newest product factor is $1-1/(Ra)$. Its product with the leading factor $R$ is $R-1/a$, which is exactly the leading factor on branch $a-1$. Thus adjacent formulas agree. The endpoint $R=b_m$ follows by continuity when the first product factor vanishes.

### 4.2 Monotonicity on a branch

Suppose $a\ge1$ and the factors are positive. Write $g(H)=R-c_{H-1}(R)>0$, $s=(R-2)H$, and $L_j=s+(R+2)j$. Then

$$
 \frac{g'(H)}{g(H)}=
 -\frac{(R+1)a}{H((R-1)H+(R+1)a)}
 +(R-2)\sum_{j=1}^{a}\left(\frac1{L_j-R}-\frac1{L_j}\right). \tag{15}
$$

If $R\le2$, the second term is nonpositive and the first is strictly negative. Consider $R>2$, so $s>0$. Let $c=R+2$. A telescoping estimate gives

$$
 \sum_{j=1}^{a}\left(\frac1{L_j-R}-\frac1{L_j}\right)
 \le \frac{Ra(s+c+2)}{(s+c)(s+2)(s+ca+2)}. \tag{16}
$$

Indeed, the $j$-th term is

$$
 \frac R c\frac{L_j+2}{L_j}
 \left(\frac1{L_j-R}-\frac1{L_j+2}\right),
$$

the middle factor is largest at $j=1$, and the parenthesized differences telescope. To show that (16) makes (15) negative, it suffices to show

$$
 \mathcal N=(R+1)(s+c)(s+2)(s+ca+2)
 -R(s+c+2)s((R-1)H+(R+1)a)>0. \tag{17}
$$

This polynomial inequality is valid throughout the branch. Put $R=v+2$, $a=b+1$, and $H=(R+1)(a+\theta)$, where $v>0$, $b\ge0$, and $0\le\theta\le1$. Appendix A supplies the exact cubic Bernstein expansion of $\mathcal N$; all four coefficients are strictly positive polynomials on this domain. This is an algebraic positivity proof, with an independently recomputed identity certificate, not a numerical search.

Thus $g'(H)<0$ on every nonconstant branch. Continuity at branch boundaries, the constant value one before the first branch, and continuity at the feasible endpoint prove (13). In the case $m=1$, (13) follows from $c_n\ge1$.

## 5. From unit jobs to every positive prediction vector

Sort $y_1\le\cdots\le y_n$, using a fixed tie rule, and put $y_0=0$, $\Delta_k=y_k-y_{k-1}\ge0$. Let $b^k\in\{0,1\}^n$ be zero before coordinate $k$ and one from coordinate $k$ onward. Then

$$
 y=\sum_{k=1}^n\Delta_k b^k,
 \qquad P_n(y)=\sum_{k=1}^n\Delta_k Q_{n-k+1}. \tag{18}
$$

For each $k$, take the unit plan of Section 3 with $m=n-k+1$. Embed it into dimension $n$ by adding $k-1$ zero coordinates and $k-1$ initial zero snapshots. Its marked order is the common order $1,\ldots,n$, its marked cost is $Q_m c_m(R)$, and it is feasible at $R$. These vectors are algebraic generators; no zero-size job is input to the actual algorithm.

Take the weighted sum of these embedded snapshots with coefficients $\Delta_k$. By (4) the result is feasible for $y$, and its marked cost is

$$
 \sum_{k=1}^n\Delta_k Q_{n-k+1}c_{n-k+1}(R)
 \le c_n(R)\sum_{k=1}^n\Delta_k Q_{n-k+1}
 =c_n(R)P_n(y). \tag{19}
$$

Lemma 2 turns it into a deterministic $R$-robust algorithm. The unit $n$-job lower bound (12) proves that no such algorithm can have consistency below $c_n(R)$. This proves the first assertion of Theorem 1. Notice that the proof requires no assumption that a best algorithm always follows the predicted completion order: we choose that order for the constructed upper bound, while the lower bound permits every completion order.

## 6. Algorithm, complexity, and an exact example

**Algorithm: prediction-snapshot synthesis with round-robin continuation.**

1. Given $n,R,y$, sort the predictions and compute their nonnegative gaps.
2. For every suffix size $m$, generate its unit snapshots using (5)–(6), using serial snapshots if $R\ge m$.
3. Embed and add those snapshots with the gap weights as in Section 5.
4. Execute the linear interpolations, skipping intervals of zero length.
5. At the first predicted-size mismatch, permanently switch to equal-rate round-robin among the unfinished jobs.

Only the predictions, $n$, and $R$ determine the plan. The actual $x_i$ is used by a simulator to detect completion; the algorithm itself is informed only when a completion occurs. A late mismatch is detected by the observable event of having delivered $y_i$ units without completion.

Generating all unit arrays and combining them takes $O(n^3)$ exact arithmetic operations. One can stream the unit arrays into the final $n\times n$ array, using $O(n^2)$ working memory. The planned execution has at most $n$ nonzero phases. These are arithmetic-operation bounds. With rational $R,y$, the displayed recurrence and plan are rational and have polynomial bit length; selecting the exact algebraic value of $R$ from an arbitrary real consistency request is a separate input-representation issue. A rational robustness value can be used directly.

For example, take $n=5$ and $R=9/5$. The unit profile has

$$
 a=2,\qquad q_1=8/13,\qquad q_2=197/312,
 \qquad c_5(9/5)=17/12.
$$

Thus consistency $17/12$ is compatible with robustness exactly $9/5$, for every positive five-job prediction vector. At the same consistency request, substituting into the published mTSS upper bound gives $38/21>9/5$. The improvement at this particular point is small; the mathematical conclusion is the full exact frontier, not the numerical size of one example.

**Limitation: sensitivity to a small prediction error.** The permanent round-robin continuation need not be smooth in prediction error. In the five-job example, give every job prediction one, let the first marked job have actual size $1-\varepsilon$, and let the other four actual sizes be one. As $\varepsilon\downarrow0$, the early completion triggers round-robin with four attained services tending to $8/13$. The total completion cost tends to $305/13$, while the offline optimum tends to $15$. The ratio therefore tends to $61/39$, exceeding the perfect-prediction ratio $17/12$ by $23/156$. This does not affect either of the two endpoint guarantees in Theorem 1. It precludes an unproved claim that this construction also achieves a graceful error-dependent guarantee.

The accompanying code checks unit profiles, independent event-driven trajectories, gap combinations, and all pairwise crossing points within each checked segment using rational arithmetic. Such finite checks detect implementation and transcription errors. They do not replace the all-parameter arguments in Sections 2–5.

## 7. Continuity, strictness, and identification with the published conjecture

The recurrence and product formula are continuous in $R\in[b_n,n]$, with agreement at each branch change as in Section 4. At $R=b_n$, all unit snapshots are the all-one vector after the first, so the marked cost is $n^2$ and $c_n=b_n$. At $R=n$, serial completion costs $Q_n$, so $c_n=1$.

The value decreases strictly before $R=n$. To see this without differentiating (14), fix $b_n\le R_1<R_2\le n$. A minimizing unit plan at $R_1<n$ has marked cost strictly greater than $Q_n$, since $q_1>0$. At parameter $R_2$ every nonzero snapshot of that plan has a strictly negative invariant deficit. Take a sufficiently small positive convex combination of its snapshots with the serial unit snapshots. Finitely many continuous constraints remain feasible at $R_2$, while the marked cost strictly decreases toward $Q_n$. Therefore $c_n(R_2)<c_n(R_1)$.

Now set $\lambda=c_n(R)-1$. Equality (9), written in terms of $q_i$, reads

$$
 \frac{(2n+1-i)i}{2}+\sum_{j<i}(n-j)q_j
 +(n+1-i)(n-i)q_i
 =R\left(\frac{i(i+1)}2+\frac{(n+i+1)(n-i)}2q_i\right).
$$

Equation (7) gives

$$
 \lambda Q_n=\sum_{j<a}(n-j)q_j
 +\frac{(n+1-a)(n-a)}2q_a.
$$

These are exactly the Order-$a$ equations in [S1]. The chosen $a$ obeys its branch inequalities, with the harmless shared endpoint convention already noted. Thus the unique robustness coordinate specified there is $R=\Phi^{(n)}(\lambda)$. Since $c_n$ is continuous and strictly decreasing over the entire interval, every allowed $\lambda$ is covered. Any algorithm with consistency at most $1+\lambda$ and a strictly smaller robustness would violate the unit-job lower bound. The constructed algorithm attains the bound. This proves the second assertion of Theorem 1.

## Appendix A. Exact positivity certificate for the dimension comparison

Use $v=R-2$, $b=a-1$, $\theta=H/(R+1)-a$, and define $\mathcal N$ by (17). The exact identity is

$$
 \mathcal N=\sum_{k=0}^3 B_k(v,b)\binom3k\theta^k(1-\theta)^{3-k},
$$

where

$$
\begin{aligned}
B_0={}&2(v+3)[b^2(v^4+6v^3+9v^2)
+b(2v^4+14v^3+35v^2+38v+16)
+v^4+8v^3+26v^2+40v+24],\\
B_1={}&\tfrac{2(v+3)}3[b^2(2v^4+12v^3+18v^2)
+b(6v^4+41v^3+96v^2+96v+48)
+4v^4+31v^3+94v^2+132v+72],\\
B_2={}&\tfrac{2(v+3)}3[b^2(v^4+6v^3+9v^2)
+b(4v^4+28v^3+69v^2+78v+48)
+4v^4+31v^3+92v^2+126v+72],\\
B_3={}&2(v+2)(v+3)(v+4)(bv+2b+2v+3).
\end{aligned}
$$

Each coefficient is strictly positive for $v,b\ge0$. The Bernstein basis functions are nonnegative and sum to one for $0\le\theta\le1$. Hence $\mathcal N>0$. Expansion of both sides proves the identity; `code/verify_monotonicity.py` independently reconstructs the coefficients and checks the zero polynomial difference over exact rational arithmetic. No finite grid is used to assert positivity.

## Sources and scope of novelty

- **[S1]** Sizhe Li, Nicolas Christianson, Tongxin Li. *Near-Optimal Consistency–Robustness Bounds for Non-Clairvoyant Scheduling.* arXiv:2610.29037v2, 11 November 2026. [Official full text](https://arxiv.org/html/2610.29037v2). Definitions 3.7–3.8, Theorems 3.9 and 4.4, Lemma 4.2, Sections 4.3 and 5, Appendices A.1 and B.6.
- **[S2]** Ziyad Benomar, Vianney Perchet. *Pareto-optimal Non-Clairvoyant Scheduling with Predictions.* arXiv:2610.32503v2, 3 November 2026. [Official full text](https://arxiv.org/html/2610.32503v2). Sections 2–4 and Appendix E. The frozen invariant, MRC, and the exact worst-case-over-$n$ frontier are prior results.
- **[S3]** Alexander Wei, Fred Zhang. *Optimal Robustness-Consistency Trade-offs for Learning-Augmented Online Algorithms.* NeurIPS 2020; arXiv:2010.11443. [Official proceedings paper](https://proceedings.neurips.cc/paper/2020/file/5bd844f11fa520d54fa5edec06ea2507-Paper.pdf). Earlier scheduling lower bound and two-job frontier.

The literature comparison is limited to the source versions inspected as of 25 November 2026. The claim of added contribution is limited to that checked comparison: exact finite-$n$ attainment through snapshot synthesis, with a proved finite dimension comparison. Search results do not establish global priority. There is no claim to a randomized, weighted, ordinal-only, or arbitrary-arrival counterpart. The MRC simulations described in the original manuscript are supporting experiments; a new global theorem about MRC is not needed or asserted here.

## Formalization statement

The written proof is not a claim of end-to-end Lean verification. The analytic interpolation, all-parameter unit-job optimization and dimension comparison are stated and proved in the paper; this version does not provide a complete machine-checked proof.
