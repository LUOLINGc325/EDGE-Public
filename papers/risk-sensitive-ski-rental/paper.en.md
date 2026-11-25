# Exact risk phases in discrete ski rental

*A rational capacity construction for the complete CVaR tradeoff*

AI-assisted research draft

24 November 2026

## Abstract

Discrete ski rental under conditional value-at-risk (CVaR) has an optimal randomized regime and a regime in which the deterministic competitive ratio is optimal. We give an exact finite construction of the entire tradeoff for every integer purchase cost. Dividing purchase probabilities by the tail mass removes the risk parameter from the feasibility constraints. A cumulative capacity recursion then determines the optimum, all its rational breakpoints, and the unique optimal distribution below the deterministic plateau. Every nonconstant value piece has the form $A+C/(1-\delta)$ with rational coefficients, while every optimal purchase probability is affine in $1-\delta$ on that piece. The threshold is rational, and its sharp asymptotic form is $\delta_c(B)=1-c/\log B+O((\log B)^{-2})$, where the positive root of $e^c=1+2c$ is $c\approx1.2564312086$. A discrete logarithmic barrier proves the matching leading constant. The randomized optimum approaches a fully supported distribution at the threshold, rather than the deterministic policy. We distinguish these exact constructions from previously established equalization and numerical approximation results. Verification scope is stated separately; this manuscript has not undergone external peer review.

## 1. Problem and contribution

Buying costs $B\in\mathbb N$, $B\ge2$, and renting costs one per day. The season length $s$ is a positive integer. The random purchase day $J$ is a positive integer or $\infty$ (never buying), and $0\le\delta\le1$. For finite $J$, the cost of buying at the start of day $J$ in a season lasting $s$ days is

$$C_s(J)=s\mathbf1_{J>s}+(B+J-1)\mathbf1_{J\le s}.$$

Define $C_s(\infty)=s$ separately. The adversary fixes $s$ without observing the algorithm's random choices. The offline cost is $\min(s,B)$. Put $q=1-\delta$. For $q>0$, CVaR averages the most expensive probability mass $q$, splitting an atom if necessary. At $q=0$ it means essential supremum. The objective is

$$V_B(\delta)=\inf_{\mathcal L(J)}\sup_{s\ge1}
\frac{\operatorname{CVaR}_{\delta}(C_s(J))}{\min(s,B)}.$$

The classical deterministic value is $D_B=2-1/B$. Write $h_B=D_B-1=(B-1)/B$.

Christianson, Sun, Low and Wierman [R1] introduced this problem, proved an order estimate for its phase transition, and derived the small-risk solution. Their Appendix C gives the CVaR finite optimization and equal-risk structure below $D_B$; their Section 4 also describes numerical approximation. We use that problem and credit those facts. Our contribution is an explicit rational capacity construction, exact phase endpoints, optimality and uniqueness certificates, and the limiting optimizer at the transition. The description is finite and constructive for every $B$; we do not claim a closed formula for the number of pieces as a function of $B$.

The distinctions from related work are substantive. Tail-probability constraints with an expected-cost objective [R2,R3] use a different risk criterion. Distributional predictions and deterministic policies [R4] place randomness in the input. Risk-sensitive online selection [R5] changes the decision problem. The present theorem concerns the algorithm's private random purchase day in the precise model above. The constant $c$ itself already appears in an upper-bound strategy in [R1]; the new asymptotic claim is that it is the exact leading constant for the discrete transition.

## 2. The exact construction

Throughout the construction, $r$ denotes the competitive ratio minus one. For a prefix $0=u_0\le u_1\le\cdots\le u_{i-1}$ and $t\ge u_{i-1}$, define

$$F_i(t;u)=(B-1)\min(1,t)
-\sum_{j=1}^{i-1}\bigl(\min(1,t)-t+u_j\bigr)_+,
\qquad x_+=\max(x,0). \tag{1}$$

An empty sum is zero. Set $U_0(r)=0$. For $0<r<h_B$, recursively choose $U_i(r)$ to solve

$$F_i\bigl(U_i(r);U(r)\bigr)=ir,
\qquad U_{i-1}(r)<U_i(r)<U_{i-1}(r)+1. \tag{2}$$

At $r=0$, define all $U_i(0)=0$. For $i<B$ the same recursion extends to $r=h_B$. Define

$$K_B=1+U_{B-1}(h_B),\qquad
q_c(B)=K_B^{-1},\qquad \delta_c(B)=1-K_B^{-1}. \tag{3}$$

**Theorem 1 (complete exact solution).** For every $B\ge2$:

1. The recursion is well defined. Each $U_i$ is continuous and strictly increasing on $[0,h_B)$, with $0<U_i-U_{i-1}<1$ for $r>0$.
2. If $q>q_c(B)$, there is a unique $r\in(0,h_B)$ satisfying $U_B(r)=1/q$. Then

$$V_B(1-q)=1+r,\qquad
p_i^*=q\bigl(U_i(r)-U_{i-1}(r)\bigr),\quad 1\le i\le B. \tag{4}$$

This optimal distribution is unique, including among purchase days not initially restricted to $[B]$.

3. If $0<q\le q_c(B)$, then $V_B(1-q)=D_B$. At $q=0$, buying on day $B$ is uniquely optimal.
4. There is a finite rational common partition for the value and the unique optimizer below the plateau. On each open nonconstant piece,

$$V_B(1-q)=A+\frac Cq,\qquad A,C\in\mathbb Q,\ C>0, \tag{5}$$

and every $p_i^*$ is affine in $q$ with rational coefficients. The recursion below constructs all pieces and their exact endpoints using rational arithmetic. Formulas agree at shared endpoints.

The finite construction makes no assumption that $q$ itself is rational. Rational input gives exact rational output; irrational input is described by the same formulas.

## 3. Removing the unbounded action space

Replacing $J$ by $\widehat J=\min(J,B)$ is not a pointwise improvement at every season length. For example, buying at $B$ can cost more at season $B$ than continuing to rent. The correct comparison uses the worst long season.

For $s<B$, costs are unchanged. For the capped policy every $s\ge B$ has the same cost $B+\widehat J-1$. Pointwise,

$$B+\widehat J-1\le C_{2B-1}(J).$$

Indeed, equality holds for $J\le B$; a later purchase before $2B-1$ costs more, and a still later purchase leaves rental cost $2B-1$. Monotonicity of CVaR proves that capping cannot worsen the worst-case objective. Hence it suffices to work on $[B]$, and only seasons $1,\ldots,B$ remain.

Moreover, capping is strictly improving in the relevant terminal comparison whenever an optimal uncapped policy would have positive mass at $J>B$. At season $2B$, each such outcome costs at least one more than the largest capped cost $2B-1$. These outcomes lie above every capped outcome. Selecting the most expensive $q$ mass therefore increases the terminal tail integral by at least $\min\{q,\Pr(J>B)\}>0$. If the capped policy is optimal and its season-$B$ value equals the optimum, the uncapped policy cannot be optimal. We will establish that equality for all the capped optimizers used in the uniqueness assertion.

## 4. A risk-independent capacity problem

Let $p_i=\Pr(J=i)$ and normalize

$$x_i=p_i/q,\qquad S_i=\sum_{j=1}^i x_j,\qquad S_0=0.$$

The full normalized mass is $S_B=1/q\ge1$: one normalized unit represents the entire risk tail $q$, not the entire probability distribution. At season $i$, an unpurchased outcome has cost $i$; a purchase at $j\le i$ has excess cost $B+j-1-i$. These excess costs increase with $j$. Thus the tail selects the latest one unit of normalized purchase mass, using zero excess cost to fill any shortfall.

**Lemma 2 (tail formula).** The exact season-$i$ competitive ratio is

$$1+\frac1i F_i(S_i;S). \tag{6}$$

**Proof.** Put $m=\min(1,S_i)$. All selected purchase mass has total $m$. If it were located at day $i$, the excess integral would be $(B-1)m$. Each selected unit bought at $j<i$ loses one unit of excess for every index $k$ from $j$ to $i-1$. The selected mass at indices at most $k$ equals $(m-S_i+S_k)_+$. Subtracting these deficits gives (1). Zero-excess outcomes supply the remaining mass $1-m$. Multiplication by $q$, followed by the CVaR factor $1/q$, cancels. This proves (6). $\square$

For an arbitrary finite nonnegative vector $x$, even before its total mass is fixed, the same expression defines its upper-one-unit excess integral with unlimited zero padding. Equivalently it maximizes $\sum_{j\le i}(B+j-1-i)z_j$ subject to $0\le z_j\le x_j$ and $\sum_jz_j\le1$. Decreasing every coordinate of $x$ shrinks that feasible set, so it cannot increase any row value.

The feasibility constraints for competitive ratio at most $1+r$ are now simply

$$F_i(S_i;S)\le ir,\qquad 1\le i\le B. \tag{7}$$

The risk parameter appears only in the required final mass $S_B=1/q$.

## 5. Why the recursion exists and is maximal

**Lemma 3 (row geometry).** For $0<r<h_B$, equation (2) has one and only one root in its displayed interval.

**Proof.** For $t\le1$ in its valid domain,

$$F_i(t;u)=(B-1)t-\sum_{j<i}u_j.$$

For $t>1$,

$$F_i(t;u)=B-1-\sum_{j<i}(1-t+u_j)_+.$$

It is continuous. Its slope is $B-1>0$ below one, and above one it is the number of active summands. On $[u_{i-1},u_{i-1}+1)$ this number is positive whenever that part of the interval lies above one. Therefore the row is strictly increasing until its saturation value $B-1$.

At the left endpoint the preceding root identity gives

$$F_i(U_{i-1};U)=(i-1)r-\min(1,U_{i-1})<ir.$$

For $i=1$ the left value is zero and the inequality follows from $r>0$. At $t=U_{i-1}+1$ the row equals $B-1$, which exceeds $ir$ because $i\le B$ and $r<h_B$. The intermediate value theorem and strict increase give the claim. $\square$

Increasing any earlier cumulative value decreases or preserves $F_i(t;u)$ at fixed $t$. This order property is the main comparison mechanism.

**Lemma 4 (maximum cumulative capacity).** Every nonnegative vector satisfying (7) has

$$S_i\le U_i(r)\quad\hbox{for every }i. \tag{8}$$

Conversely, the increments of $U$ satisfy every row with equality and attain total mass $U_B(r)$.

**Proof.** Induct on $i$. Suppose earlier cumulative inequalities hold. If $S_i>U_i$, then

$$F_i(S_i;S)\ge F_i(S_i;U)>F_i(U_i;U)=ir.$$

The first inequality is prefix antitonicity. The second is strict increase before saturation, followed by the fact that the saturation level also exceeds $ir$. This contradicts (7). The converse follows directly from (2) and positive increments. The identical proof applies at $r=h_B$ to the first $B-1$ rows, because their targets remain strictly below $B-1$. $\square$

**Corollary 5 (capacity criterion).** For $0<r<h_B$, a probability strategy with value at most $1+r$ exists if and only if

$$qU_B(r)\ge1. \tag{9}$$

**Proof.** Necessity follows from $S_B=1/q$ and (8). For sufficiency, multiply all canonical increments by $\lambda=(qU_B)^{-1}\le1$ and then by $q$ to obtain probabilities summing to one. Coordinatewise reduction of the normalized masses cannot increase the padded upper-tail integral. $\square$

This is a global feasibility certificate. It does not minimize a concave function by incorrectly treating the problem as one linear program.

## 6. Continuity, the exact transition, and uniqueness

**Lemma 6 (parameter behavior).** Each $U_i$ is continuous and strictly increasing in $r$. For $i<B$ this remains true up to $r=h_B$. Finally,

$$\lim_{r\uparrow h_B}U_B(r)=1+U_{B-1}(h_B)=K_B. \tag{10}$$

**Proof.** Induct on $i$. Continuity follows from continuity of the row and the unique strictly increasing root. This argument also applies at $r=0$: earlier values tend to zero and the new root tends to zero. For strict increase, increase $r$ and all preceding canonical values. If the new predecessor already exceeds the old root, the new root is larger immediately. Otherwise the old root is in the new row's domain; at that point the new row is no larger than before, while its target is strictly larger. Again the new root is larger. For $i<B$, the endpoint target $ih_B$ remains below $B-1$, so the same reasoning extends to $h_B$.

The last root is bounded above by $1+U_{B-1}(r)$. Any limit smaller than $1+U_{B-1}(h_B)$ leaves its predecessor summand strictly positive in (1), and hence leaves the row strictly below $B-1$. This contradicts $Br\to B-1$. $\square$

Because $U_{B-1}(h_B)>0$, we have $K_B>1$. The capacity increases from zero to $K_B$. Thus if $1/q<K_B$, equation (9) first becomes feasible at its unique equality root; if $1/q\ge K_B$, every value strictly below $D_B$ is infeasible. Buying at $B$ supplies the value $D_B$. This proves the value and threshold assertions in Theorem 1.

To prove uniqueness below the plateau, let $S$ be any optimal normalized cumulative vector. Lemma 4 gives $S_i\le U_i$, and normalization gives $S_B=U_B$. If $S_i=U_i$ for some $i\ge2$, then

$$F_i(U_i;S)\ge F_i(U_i;U)=ir.$$

Feasibility forces equality. Every difference between the corresponding positive-part summands is nonnegative, so each difference vanishes. In particular the predecessor term is strictly positive on the canonical side: it is $U_{i-1}>0$ if $U_i\le1$, and $1-U_i+U_{i-1}>0$ otherwise. Equality of this term therefore forces $S_{i-1}=U_{i-1}$. Backward induction gives all cumulative equalities and then (4). All horizons have value $1+r$. Section 3 excludes any additional uncapped optimizer.

At $q=0$, any supported day $j<B$ yields the season-$j$ ratio $1+(B-1)/j>D_B$. Any supported day $j>B$, or never buying, yields a larger ratio for a sufficiently long season. Hence only day $B$ is optimal.

### 6.1. What happens at the transition

Let $u_i=U_i(h_B)$ for $i<B$ and $u_0=0$. As $q\downarrow q_c$ from the randomized regime, the unique optimizer converges to

$$p_i^c=q_c(u_i-u_{i-1})\ (i<B),\qquad p_B^c=q_c. \tag{11}$$

All entries are positive. The limiting policy is therefore not deterministic.

For every $0<q\le q_c$ and every $\lambda\in[0,1]$, the probabilities

$$p_i=\lambda q(u_i-u_{i-1})\ (i<B),\qquad
p_B=1-\lambda q u_{B-1} \tag{12}$$

are optimal. The earlier rows satisfy (7) by coordinatewise reduction. Also $p_B\ge q$, so the terminal tail consists of cost $2B-1$. Thus deterministic and randomized optimizers coexist throughout the positive-tail plateau. Conversely, every capped optimum there has $p_B\ge1-qu_{B-1}\ge q$, by applying Lemma 4 only to the first $B-1$ rows at $h_B$. Formula (12) provides a family, not a claim to enumerate every optimizer on the plateau.

## 7. Constructing all exact pieces

No nonlinear root solving is needed after an active set is fixed. If the new cumulative root satisfies $t\le1$, then

$$t=\frac{ir+\sum_{j<i}U_j}{B-1}. \tag{13}$$

If $t>1$ and precisely the suffix $j=\ell,\ldots,i-1$ is active, then

$$t=1+\frac{ir-(B-1)+\sum_{j=\ell}^{i-1}U_j}{i-\ell}. \tag{14}$$

Here $1\le\ell\le i-1$, and validity means

$$1+U_{\ell-1}\le t\le1+U_\ell,$$

where $U_0=0$. Equality at a boundary is harmless because the disappearing summand is zero. For $i=1$ only (13) is needed.

Start with the rational interval $[0,h_B]$. Suppose all earlier cumulative functions are affine on a current cell, with rational coefficients. Every candidate in (13)–(14) is affine in $r$. Its validity conditions are linear inequalities with rational coefficients. Intersecting those inequalities with the cell produces a finite rational refinement. The unique-root lemma guarantees that the candidates cover the interval and agree wherever their valid cells touch. Induction proves finite rational piecewise affinity. For the last row use the left-continuous endpoint extension (10); do not replace it by an unconstrained root at $h_B$.

On a cell write $U_B(r)=ar+b$, with $a>0$. Solving the normalization exactly gives

$$r=\frac{1/q-b}{a},\qquad A=1-b/a,\qquad C=1/a.$$

An endpoint $r_0$ becomes $q_0=1/U_B(r_0)$. Discard the part with $U_B<1$, since $q\le1$. If $U_i(r)=a_i r+b_i$, then

$$p_i^*=\frac{a_i-a_{i-1}}a
+q\left[b_i-b_{i-1}-\frac{b(a_i-a_{i-1})}{a}\right]. \tag{15}$$

This proves every constructive claim in Theorem 1. The reference implementation retains all cumulative formulas, rather than only the value, so that it also certifies the strategy. Its running time depends on the number of generated cells; no polynomial bound on that number is asserted here.

### 7.1. Linear arithmetic cost for one capacity evaluation

For a fixed $r<h_B$, the entire capacity vector can be evaluated with $O(B)$ arithmetic operations. In the branch $U_i\le1$, maintain the prefix sum in (13). Once the roots exceed one, maintain a queue of the active suffix and its sum. As $i$ increases, $U_i$ increases, so the cutoff $U_i-1$ also increases; discarded prefix entries never become active again. Evaluate (14) with the current suffix. If the leftmost entry is below the proposed cutoff, discard it and recompute. Removing it raises or preserves the candidate root, so previously removed entries remain inactive. The previously valid lower cutoff remains valid at the next step: at the preceding root the new target has increased, while the new row has decreased. Thus the process stops with the unique valid root. Each entry is inserted and removed at most once.

This count concerns arithmetic operations for a single given $r$, not rational bit complexity and not the cost of producing all symbolic cells. At the critical endpoint evaluate only the first $B-1$ roots and then add one.

## 8. The sharp leading transition constant

**Theorem 7.** Let $c>0$ be the unique positive solution of $e^c=1+2c$. Then

$$K_B=\frac{\log B}{c}+O(1),\qquad
\delta_c(B)=1-\frac{c}{\log B}+O\bigl((\log B)^{-2}\bigr). \tag{16}$$

In particular, the leading constant in the previously known logarithmic transition is exactly $c\approx1.2564312086$. A useful explicit pair of bounds for $B\ge16$ is

$$1+\frac{\log B-\log16}{c}\le K_B\le3+\frac{\log B}{c}. \tag{17}$$

**Proof.** All logarithms are natural. Convexity of $e^x-1-2x$ shows that besides zero it has a unique positive root, lying between $1$ and $3/2$. For $x>0$, set

$$f_x(y)=\left(1-\frac1c\log\frac yx\right)_+,\qquad y\ge x.$$

Direct integration using $e^c=1+2c$ gives $\int_x^\infty f_x(y)\,dy=x$. Since $f_x$ decreases from one to zero, the integral comparison for unit rectangles yields

$$x-1\le\sum_{k=1}^{\infty}f_x(x+k)\le x. \tag{18}$$

Write $m=B-i$ and $V_m=U_{B-m}(h_B)$. Testing a proposed root $t\ge1$ amounts to comparing

$$G_m(t;V)=\sum_{\ell=m+1}^{B-1}(1-t+V_\ell)_+
\quad\hbox{with}\quad (1-1/B)m. \tag{19}$$

The function $G_m$ is nonincreasing in $t$, while the original row function is nondecreasing.

For an upper bound, take

$$v_m=1+\frac1c\log\frac B{m-1},\qquad m\ge2.$$

Induct in decreasing $m$. These proposed roots exceed one and the preceding upper barrier. If earlier actual values lie below their barriers, then at $t=v_m$,

$$G_m(v_m;V)\le
\sum_{\ell>m}\left(1-\frac1c\log\frac{\ell-1}{m-1}\right)_+
\le m-1\le(1-1/B)m.$$

The infinite sum only enlarges the finite sum. The second inequality is (18) with $x=m-1$. Therefore the actual root lies below $v_m$. In particular, $U_{B-2}(h_B)\le1+\log B/c$. The next increment is less than one, proving the upper bound in (17).

For a self-contained lower bound, suppose $B\ge16$ and put $m_0=\lfloor B/8\rfloor$, $i_0=B-m_0$. We first show $U_{i_0}(h_B)>1$. Otherwise every preceding root is at most one, so solving the first-branch recurrence gives

$$U_{i_0}(h_B)=(1-1/B)
\left[\left(1+\frac1{B-1}\right)^{i_0}-1\right]
\ge\frac{15}{16}(e^{7/8}-1)>1,$$

a contradiction. We used $\log(1+1/(B-1))\ge1/B$.

Now set

$$u_m=\frac1c\log\frac{m_0+1}{m+1}.$$

For $m\ge m_0$ this is nonpositive. For $m<m_0$ and $u_m\le1$, the preceding observation makes it a lower bound as well. In the remaining case use decreasing-$m$ induction. If $u_m$ is below the previous actual cumulative value, the conclusion is immediate. Otherwise it is a valid proposed root, and

$$G_m(u_m;V)\ge
\sum_{\ell=m+1}^{B-1}
\left(1-\frac1c\log\frac{\ell+1}{m+1}\right)_+\ge m.$$

For the last inequality use (18) with $x=m+1$. No positive terms are lost by truncation: $e^c<4$ and $m<m_0$ imply $e^c(m+1)<4(B/8+1)\le B$. Hence the finite sum contains the full support of the infinite sum. Since $m\ge(1-1/B)m$, comparison in (19) gives $V_m\ge u_m$. At $m=1$,

$$K_B\ge1+\frac1c\log\frac{m_0+1}{2}
\ge1+\frac{\log B-\log16}{c}.$$

This proves (17). Inverting $K_B=\log B/c+O(1)$ proves (16). $\square$

The argument stays discrete; it does not infer an asymptotic theorem from a numerical fit or a formal continuum limit. The strategy bound in [R1, Theorem 9(i)] also implies $K_B\ge\log(B+1)/c$: strict improvement holds whenever $q>c/\log(B+1)$, whereas our exact criterion is $q>1/K_B$, so $1/K_B\le c/\log(B+1)$. If the latter bound is at least one, the conclusion already follows from $K_B>1$. This external comparison is not needed for the self-contained proof above.

## 9. Exact examples

For $B=2$, the complete value is

$$V_2(\delta)=
\begin{cases}
1+\dfrac1{3(1-\delta)},&0\le\delta\le1/3,\\
3/2,&1/3\le\delta\le1.
\end{cases}$$

For $B=3$, the complete value has two nonconstant pieces:

$$V_3(\delta)=
\begin{cases}
1+\dfrac8{19(1-\delta)},&0\le\delta\le4/19,\\
\dfrac{21}{17}+\dfrac4{17(1-\delta)},&4/19\le\delta\le5/11,\\
5/3,&5/11\le\delta\le1.
\end{cases} \tag{20}$$

The first optimal distribution is $(4,6,9)/19$. On the second piece, writing $q=1-\delta$, it is

$$p^*=\bigl((2q+2)/17,\ (3q+3)/17,\ (12-5q)/17\bigr).$$

At the threshold the limiting randomized policy is $(2,3,6)/11$, with the same value as buying deterministically on day three.

The next exact thresholds are

| $B$ | $\delta_c(B)$ | Decimal, for orientation |
|---:|---:|---:|
| 2 | $1/3$ | 0.333333 |
| 3 | $5/11$ | 0.454545 |
| 4 | $25/49$ | 0.510204 |
| 5 | $193/353$ | 0.546742 |
| 8 | $224647/368707$ | 0.609283 |
| 10 | $22835647/36121672$ | 0.632187 |

Exact tables and their generating code are included with the release. The decimal values are displays of rational certificates, not estimates of the general theorem.

At the threshold for $B=3$, both the limiting randomized distribution and the deterministic day-three policy are optimal.

## 10. Verification and scope

The mathematical argument covers every integer $B\ge2$ and every real risk level. Reproducible exact arithmetic checks cover the explicitly generated finite tables. An independent global optimization check enumerates the finite CVaR quantile choices rather than reusing the capacity proof. The numerical and exact computation files are not included in this edition.

The Lean component, when accompanied by a successful build, verifies the finite positive-part comparison and uniqueness certificate under explicitly listed root conditions. The probability interpretation, analytic root existence, symbolic piece partition, and the entire ski-rental theorem are not thereby fully formalized. The Lean source and build evidence are not included in this edition.

The literature comparison is limited to the primary papers and follow-up searches as of the stated date. It establishes no worldwide priority guarantee. We do not solve continuous-time CVaR ski rental anew, two-slope rental, prediction-based risk, or tail-probability constrained expected-cost optimization. A formula for the number of risk pieces, and efficient bounds on symbolic output size, are separate questions.

## References

[R1] Nicolas Christianson, Bo Sun, Steven Low and Adam Wierman. *Risk-Sensitive Online Algorithms*. arXiv:2405.09859v2 (2024), especially Section 4 and Appendix C. COLT 2024 extended abstract, PMLR 247:1140–1141. <https://arxiv.org/abs/2405.09859>.

[R2] Michael Dinitz, Sungjin Im, Thomas Lavastida, Benjamin Moseley and Sergei Vassilvitskii. *Controlling Tail Risk in Online Ski-Rental*. SODA 2024, pp. 4247–4263. <https://doi.org/10.1137/1.9781611977912.147>.

[R3] Qiming Cui and Michael Dinitz. *Controlling Tail Risk in Two-Slope Ski Rental*. arXiv:2508.06809 (2025). <https://arxiv.org/abs/2508.06809>.

[R4] Spyros Angelopoulos, Christoph Dürr and Georgii Melidi. *Decision-Theoretic Approaches for Improved Learning-Augmented Algorithms*. arXiv:2501.17701v2 (2025). <https://arxiv.org/abs/2501.17701>.

[R5] Hossein Nekouyan, Bo Sun, Raouf Boutaba and Xiaoqi Tan. *Risk-Sensitive Online Selection with Bounded Adaptivity*. arXiv:2512.02427v2 (2026). <https://arxiv.org/abs/2512.02427>.
