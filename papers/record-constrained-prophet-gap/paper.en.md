# Record Constraints in IID Prophet Selection

*Strict separation and effective global minimax certification*

Research manuscript · 25 November 2026

## Abstract

We study selection from a known nonnegative iid law when an online policy may accept only a running record. Policies observe all values, may use the complete history, and may randomize. An exact thirty-point instance has optimal record ratio below $18/25$, separating this class from the unrestricted iid guarantee of at least $0.745$ and answering the negative branch of the record-threshold question in Bai, Huang, Lee and Li [1, Section 3.3].

We also give an effective characterization of the worst ratio over all distributions and all horizons. At fixed horizon $n$, strict-label and weak-label rational LPs on $m$ quantile bins give width at most $3(n-1)/(2m)$. To control arbitrarily large horizons, we combine high-quantile sparsification with a two-way causal Bernoulli–Poisson comparison that preserves record eligibility. Its reward-weighted error is uniform over unbounded integrable payoffs. Maximum sharding then identifies the global infimum with the limit of finite-horizon values and supplies an explicit convergence bound. Discretizing only active marks yields two rational LPs of $O(\log^4(1/\varepsilon)/\varepsilon^2)$ variables and constraints for any prescribed rational accuracy $\varepsilon>0$; coefficient bit lengths and certified solver gaps are accounted for separately.

A downward-rounded integer certificate for an explicit randomized policy, together with the finite upper witness, proves $0.6817<c_{\rm rec}<0.7172690288$. The sharp constant and a matching extremal distribution remain undetermined. Generic Poissonization, sharding, quantile LPs, and occupancy certificates are established methods; the claimed contribution is their record-preserving uniform transfer and effective global certification. This is an unrefereed research manuscript. The written proof and the numerical certificate have distinct verification requirements. Full Lean verification is incomplete; the action table and numerical verification files are not included in this edition.

## 1. Problem and contribution

An observer sees $X_1,\ldots,X_n$ sequentially and can accept at most one value. A prophet sees the entire sequence and receives its maximum. In the usual iid prophet problem, the observer may accept any current value. We impose an additional action constraint: acceptance is permitted only at a weak running record. In particular, a policy that rejects a large value cannot later accept a smaller one, even if accepting that smaller value would then be optimal without the constraint.

The distribution and horizon are known. Thus the loss studied here persists with correct distributional information. It is neither a lower-information secretary problem nor a requirement to remain robust to an incorrect predicted prior.

Bai et al. [1] ask whether a narrower family, using nonincreasing thresholds of independent uniform arrival time and accepting only records, can achieve the unrestricted iid prophet benchmark. Their fixed-distribution threshold optimization is already available. We address the worst distribution, and our negative result applies to the larger class of all history-dependent record policies. Containment of the classes gives the implication to their question. A positive guarantee for our larger class would not give the reverse implication.

The separation, fixed-horizon approximation and effective global certification are complementary results.

**Theorem 1 (strict separation).** There is an iid distribution on thirty explicitly listed nonnegative values, with $n=100$, for which every randomized, history-dependent weak-record policy satisfies

$$
\frac{\mathbb E[\text{accepted reward}]}{\mathbb E\max_iX_i}
\le 0.7172690287559823 < \frac{18}{25}.
$$

The displayed decimal is an outward upper display of an exact rational certificate; the proof uses the strict integer comparison $25R<18P$. Atomless examples with ratio below $18/25$ also exist. A smaller seven-point example with $n=20$ already gives a ratio below $149/200=0.745$.

**Theorem 2 (uniform finite certification).** Let $c_n$ be the infimum of the optimal record ratio over all admissible distributions at horizon $n\ge1$. Define the normalized strict-label and weak-label minimax values $a_{n,m}$ and $b_{n,m}$ in Section 4. Then

$$
\boxed{\rho_{n,m}a_{n,m}\le c_n\le b_{n,m}
\le a_{n,m}+\frac{n-1}{m}},
\qquad
\rho_{n,m}=\frac mn\left[1-\left(1-\frac1m\right)^n\right].
\tag{1}
$$

Both finite values are rational LP optima with $2nm$ variables and $O(nm)$ constraints. Their exact bracket has width at most $3(n-1)/(2m)$. Thus, at fixed $n$, all-distribution minimax certification to any positive additive accuracy reduces to finite rational computation. No tail bound, bounded support, density, or moment beyond the first is required.

**Effective global certification (Theorems 5–6).** The values $c_n$ converge to $c_{\rm rec}=\inf_{h\ge1}c_h$. For every $R>0$ and integer $N\ge R$,
$$
0\le c_N-c_{\rm rec}\le e^{-R}
+\frac{2R^2(R+2)}{N(1-e^{-R})}.
$$
A sparse active-label formulation gives a more efficient all-horizon rational certificate. With the parameters in (54), two finite LPs bracket $c_{\rm rec}$ to any specified rational additive accuracy. Their size statement concerns variables and constraints, not an assertion that the large coefficient arrays have been solved in the experiments. Section 8.9 supplies an actual global policy certificate, giving $c_{\rm rec}>0.6817$.

Bellman recursion, quantile representations, linear programming, and rational weak-duality certificates are established tools. Goldenshluger, Malinovsky and Zeevi [4] already give sharp fixed-horizon single-threshold games and certified finite approximation. Our claimed increment is specific to record eligibility: the strict/weak transfer theorem, its sharp prophet contraction factor, and the resulting uniform record-class bracket, together with the explicit all-policy separation. We do not claim priority for the general use of LPs in prophet inequalities.

## 2. Definitions and policy scope

Let $F$ be a Borel probability law on $[0,\infty)$, and let the observations be independent with law $F$. Assume

$$
0<M_n(F):=\mathbb E\left[\max_{1\le i\le n}X_i\right]<\infty.
$$

A policy can accept at time $i$ only when $X_i\ge\max_{h<i}X_h$; the first observation is eligible. Its decision is measurable with respect to the observed history and independent auxiliary randomization. It knows $n,F$. Acceptance is irrevocable, and the reward is zero if the policy never accepts. There is no forced final acceptance of an ineligible value. Write

$$
V_n(F)=\sup_\pi\mathbb E_F[\text{reward of }\pi],
\qquad c_n=\inf_F\frac{V_n(F)}{M_n(F)},
\qquad c_{\rm rec}=\inf_{n\ge1}c_n.
\tag{2}
$$

These quantifiers permit a different optimal policy for each known law. A distribution-independent policy is not being substituted for this model. The allowance of auxiliary randomization includes independent arrival clocks. Ordering iid values by independent random timestamps leaves the chronological values iid and independent of the ordered timestamps. Conditioning on the full auxiliary randomness fixes a history-dependent policy; future values retain their original independent laws. Consequently independent timing information cannot invalidate the finite Bellman upper bounds below.

Our positive certification concerns $c_n$ and $c_{\rm rec}$ for the full adaptive record class, not the smaller time-only class in [1]. Our upper bound concerns the larger class, so it does apply to that smaller class. The exact value of $c_{\rm rec}$ remains open in this manuscript.

## 3. Exact finite witnesses

### 3.1 Bellman domination and attainment

Suppose $F$ has strictly increasing support $x_1<\cdots<x_d$ and positive masses $p_j$. Let $W_{k,r}$ be the optimal continuation value when $k$ observations remain, no acceptance has occurred, and the previous maximum is $x_r$. Set $W_{0,r}=0$. Independence gives

$$
W_{k,r}=\left(\sum_{j<r}p_j\right)W_{k-1,r}
+\sum_{j\ge r}p_j\max\{x_j,W_{k-1,j}\}.
\tag{3}
$$

For an empty history,

$$
V_n(F)=\sum_{j=1}^dp_j\max\{x_j,W_{n-1,j}\}=W_{n,1}.
\tag{4}
$$

To justify (3) against the full policy class, condition on any reached history and on the next value. A value below the previous maximum must be rejected, leaving state $r$. At an eligible value $x_j$, a randomized decision is a convex combination of accepting $x_j$ and continuing. By induction the latter reward is at most $W_{k-1,j}$, whatever the preceding history. Their maximum bounds the convex combination. This proves domination by backward induction without first restricting the policies to Markov form. Conversely, choose an action attaining each displayed maximum and use the inductively optimal continuation. This deterministic policy is legal and attains the recursion. Integrating the same bound over independent private randomness or timestamps proves the stated extension.

### 3.2 Integer arithmetic

For $p_j=a_j/Q$, $x_j=b_j/B$, put $A_j=\sum_{h\le j}a_h$ and $A_0=0$. Let $R_{k,r}=BQ^kW_{k,r}$. Then every quantity below is an integer:

$$
R_{0,r}=0,\qquad
R_{k,r}=A_{r-1}R_{k-1,r}
+\sum_{j=r}^d a_j\max\{b_jQ^{k-1},R_{k-1,j}\}.
\tag{5}
$$

The prophet has the same denominator $BQ^n$, with numerator

$$
P=\sum_{j=1}^d b_j(A_j^n-A_{j-1}^n).
\tag{6}
$$

Thus the optimal ratio is exactly $R_{n,1}/P$. Neither a floating-point optimizer nor a simulation is needed to verify a claimed witness. The included verifier evaluates all states and compares the resulting integers. An independent review implementation sums transitions directly, includes a separate empty-history state, and recomputes the prophet through the equivalent tail-layer expression

$$
b_1Q^n+\sum_{j=2}^d(b_j-b_{j-1})(Q^n-A_{j-1}^n).
$$

### 3.3 A seven-point example and the stronger certificate

For the smaller example take $n=20,Q=2000,B=100$, with

$$
(a_j)=(1400,300,150,80,40,29,1),
\qquad(b_j)=(0,31,43,49,50,54,5228).
$$

Its exact ratio lies in $(0.7361431558,0.7361431559)$. Equations (5)–(6) give $149P-200R_{20,1}>0$, settling the strict comparison with $0.745$. The full integer certificate is stored in the corresponding `results` file.

For the stronger example use $n=100,Q=10^8,B=10^6$ and the thirty pairs in Appendix A. The exact certificate gives

$$
0.7172690287<\frac{R_{100,1}}P<0.7172690288,
\qquad 18P-25R_{100,1}>0.
\tag{7}
$$

All support values are strictly increasing, including the small differences between the middle values. Those differences must be retained: rounding them into equal rewards changes the admissible weak-record decisions. The complete large integers, all optimal accept/reject decisions, and a digest of the integer Bellman rows are supplied; the rows themselves can be regenerated from (5).

The unrestricted iid problem has a proved universal guarantee of at least $0.745$ [2, Corollary 4.7]. Combining that lower bound with (7) proves a strict structural loss. No rounding of the classical limiting constant is needed.

### 3.4 Removing atoms without losing the upper bound

An atomic counterexample can be replaced by a continuous one. Write its quantile as a finite step function $f$, and define $f_\eta(u)=f(u)+\eta u$ for $0<u<1$. This function is strictly increasing. Any value-record policy for $f_\eta(U)$ accepts only at a quantile record, hence at a weak record of the original support indices. Given each index, a policy for the atomic law can independently simulate a uniform point in that quantile interval and replay the continuous policy. Its coarse reward is at most the atomic Bellman optimum, and differs from the continuous reward by at most $\eta$. Therefore

$$
V_n(F_\eta)\le V_n(F)+\eta,
\qquad M_n(F_\eta)\ge M_n(F).
$$

Choose $0<\eta<(18/25)M_n(F)-V_n(F)$, which is possible by (7). The atomless law $F_\eta$ still has ratio below $18/25$. This argument supplies an atomless, absolutely continuous example; it does not assert positive density on the whole nonnegative half-line.

## 4. Two quantile-label games

Fix positive integers $n,m$. Let $J_1,\ldots,J_n$ be independent uniform labels in $\{1,\ldots,m\}$, and let $0\le v_1\le\cdots\le v_m$. The label is observed, even if some rewards coincide. Define

$$
P_{n,m}(v)=\sum_{j=1}^m p_jv_j,
\qquad p_j=\left(\frac jm\right)^n-\left(\frac{j-1}{m}\right)^n.
\tag{8}
$$

This is the expected maximum reward. A strict-label policy can accept only if $J_i>\max_{h<i}J_h$; a weak-label policy can accept if $J_i\ge\max_{h<i}J_h$. The empty maximum is zero. Let $S(v)$ and $T(v)$ denote their respective optimal values, including all history-dependent randomized policies. Set

$$
a_{n,m}=\min_{v\uparrow,\ P_{n,m}(v)=1}S(v),
\qquad b_{n,m}=\min_{v\uparrow,\ P_{n,m}(v)=1}T(v).
\tag{9}
$$

The normalized domain is nonempty and compact: $v_j\le v_m\le 1/p_m$. Finite Bellman recursions show $S,T$ are continuous. Hence both minima exist. Homogeneity then gives $S(v)\ge a_{n,m}P_{n,m}(v)$ for every nonzero normalized or unnormalized vector, and the corresponding inequality for $T$. Also $0\le a_{n,m}\le b_{n,m}\le1$.

Label records and value records must not be identified when $v$ has plateaus. For example, with two draws, three uniform labels and $v=(1,1,3)$, the weak-label optimum is $2$; after merging equal rewards, the actual weak-value optimum is $19/9$. Section 6 uses a strict perturbation to avoid this false equivalence.

## 5. Sharp prophet approximation by bin means

**Lemma 3.** Let $f:(0,1)\to[0,\infty)$ be nondecreasing and measurable, let $U_i$ be independent uniform random variables, and assume $M=\mathbb E f(\max_iU_i)<\infty$. Put

$$
v_j=m\int_{(j-1)/m}^{j/m}f(u)\,du,
\qquad P=P_{n,m}(v).
$$

Then $\rho_{n,m}M\le P\le M$, with $\rho_{n,m}$ as in (1). No larger uniform multiplicative factor is possible for this bin-mean operation.

**Proof.** The bin means are finite because $\int_0^1f\le M$. They are nonnegative and ordered. By Tonelli's layer-cake formula, it suffices to prove the inequalities for tail indicators $f(u)=\mathbf{1}_{\{u>q\}}$, $0\le q<1$. An endpoint convention at a single quantile has no effect. Write $h=1/m$, and choose the grid interval $[a,a+h]$ containing $q=a+th$, $0\le t<1$; let $b=a+h$. Directly,

$$
M(q)=1-q^n,\qquad
P(q)=1-b^n+m(b-q)(b^n-a^n).
\tag{10}
$$

The deficit is

$$
E(a,t):=M(q)-P(q)
=(1-t)a^n+t(a+h)^n-(a+th)^n\ge0
\tag{11}
$$

by convexity of $x^n$ on the nonnegative half-line. This proves $P\le M$. For $n\ge2$, holding $t,h$ fixed,

$$
\partial_a E(a,t)
=n\big[(1-t)a^{n-1}+t(a+h)^{n-1}-(a+th)^{n-1}\big]\ge0.
\tag{12}
$$

Thus the nonnegative numerator $E(a,t)$ increases when the grid interval is shifted right, whereas the positive denominator $1-(a+th)^n$ decreases. Their ratio is largest in the last interval, $a=1-h$. In that interval,

$$
\frac{P(q)}{M(q)}
=\frac{m[1-(1-1/m)^n]}{1+q+\cdots+q^{n-1}}
\ge\frac mn[1-(1-1/m)^n]=\rho_{n,m}.
\tag{13}
$$

For $n=1$, equality is immediate. At $q=1$ both expectations vanish; there is no division at that endpoint. Every nonnegative nondecreasing $f$ is an integral of tail indicators up to null endpoints. Tonelli therefore integrates the same inequality even for unbounded $f$. Finally, take $q\uparrow1$ in the last interval: the denominator in (13) tends to $n$. The factor is sharp as an infimum. This sharpness concerns bin-mean approximation; it does not identify the worst record-stopping law. $\square$

The geometric-series identity yields

$$
\rho_{n,m}=\frac1n\sum_{k=0}^{n-1}(1-1/m)^k
\ge1-\frac{n-1}{2m},
\tag{14}
$$

where the last step sums the elementary inequality $(1-x)^k\ge1-kx$ for $x\in[0,1]$. The uniform control of the last quantile interval is essential: evaluating $f$ at finitely many points would not control an arbitrarily heavy upper tail.

## 6. Proof of the transfer theorem

### 6.1 Lower bound for every distribution

Represent $X=f(U)$ through a nondecreasing generalized quantile of $F$. This representation can be implemented by a randomized policy even when $F$ has atoms: after seeing $X_i$, draw an independent uniform $R_i$ and set

$$
U_i=F(X_i-)+R_i\big(F(X_i)-F(X_i-)\big).
\tag{15}
$$

The resulting $U_i$ are iid uniform, and $f(U_i)=X_i$ almost surely. To check the transform, at a cutoff inside a jump of $F$, the randomized fraction of that jump fills precisely the remaining length below the cutoff; away from jumps the ordinary quantile identity applies. Independence follows because each pair $(X_i,R_i)$ is independent of the others.

Apply a strict-label optimal policy to $J_i=\lceil mU_i\rceil$, using only these labels and independent policy coins. A strict label record exceeds every preceding quantile and therefore has a value at least as large as every preceding value. Every acceptance is legal. Conditional on the label history and policy coins, the selected quantile is uniform in its bin, because the policy has used no within-bin information. The expected selected reward is consequently the same as the finite policy's bin-mean reward. With $v$ from Lemma 3,

$$
V_n(F)\ge S(v)\ge a_{n,m}P_{n,m}(v)
\ge\rho_{n,m}a_{n,m}M_n(F).
\tag{16}
$$

Taking the infimum over all admissible $F$ proves the first inequality in (1).

### 6.2 Upper bound via strictly increasing perturbations

Take any ordered $v$ with $P_{n,m}(v)=1$, including vectors with plateaus. For $\eta>0$ define

$$
f_\eta(u)=v_{\lceil mu\rceil}+\eta u.
\tag{17}
$$

It is strictly increasing and generates an atomless law $F_\eta$. Any legal full-value record policy for this law accepts only at a quantile record, hence only at a weak label record. In the weak-label game, independently simulate a uniform within-bin quantile at each arrival and replay that policy. Its coarse reward is $v_{J_\tau}$, while the original reward is $v_{J_\tau}+\eta U_\tau$; their difference is in $[0,\eta]$, also allowing no acceptance. The simulation preserves arbitrary history dependence and private randomness. Therefore

$$
V_n(F_\eta)\le T(v)+\eta,\qquad M_n(F_\eta)\ge1.
\tag{18}
$$

Since $c_n$ is an infimum, first letting $\eta\downarrow0$ and then minimizing over $v$ gives $c_n\le b_{n,m}$. The limiting construction is part of the proof, not an assertion that a plateau vector itself is a valid upper witness after labels are forgotten.

### 6.3 The finite weak/strict difference

Simulate an optimal weak-label policy until it intends to accept. If its intended acceptance is a strict label record, accept; if it ties the previous maximum label, forfeit permanently and receive zero. This is a causal strict-label policy. Its lost reward is bounded pathwise by

$$
\sum_{i=2}^n v_{J_i}\mathbf{1}_{\{J_i=\max_{h<i}J_h\}}.
$$

Independence and uniform labels imply, for each $i\ge2$,

$$
\mathbb E\big[v_{J_i}\mathbf{1}_{\{J_i=\max_{h<i}J_h\}}\big]
=\frac1m\mathbb E v_{\max_{h<i}J_h}
\le\frac1mP_{n,m}(v).
\tag{19}
$$

Thus $T(v)-S(v)\le(n-1)P_{n,m}(v)/m$. Apply this at a normalized strict-game minimizer to get $b_{n,m}\le a_{n,m}+(n-1)/m$. Combining the three arguments proves (1). Finally, $a_{n,m}\le1$ and (14) give

$$
b_{n,m}-\rho_{n,m}a_{n,m}
\le1-\rho_{n,m}+\frac{n-1}{m}
\le\frac{3(n-1)}{2m}.
\tag{20}
$$

When $n=1$, every problem has value one, including $m=1$. No negative or undefined endpoint bound is being used.

**Corollary 4 (atomless laws suffice for the infimum).** At each fixed $n$, restricting the infimum in (2) to atomless laws does not change $c_n$. Indeed, that restricted infimum is at least $c_n$, while (18) bounds it above by $b_{n,m}$ for every $m$. Equation (20) and (1) imply $b_{n,m}\to c_n$. The piecewise uniform laws generated by (17) therefore approximate the worst ratio. This is an approximation assertion, not a claim that the infimum is attained.

## 7. Finite LPs and rational certificates

### 7.1 Sparse LP formulation

For either label game let $W_{0,r}=0$. The same full-history induction as in Section 3 gives

$$
W^{S}_{k,r}=\frac rmW^{S}_{k-1,r}
+\frac1m\sum_{j>r}\max\{v_j,W^{S}_{k-1,j}\},
\tag{21}
$$

$$
W^{T}_{k,r}=\frac{r-1}{m}W^{T}_{k-1,r}
+\frac1m\sum_{j\ge r}\max\{v_j,W^{T}_{k-1,j}\}.
\tag{22}
$$

The initial value in either game is $m^{-1}\sum_j\max\{v_j,W_{n-1,j}\}$. Introduce nonnegative variables $v_r$, $W_{k,r}$ for $1\le k<n$, and $s_{k,r}$ for $1\le k\le n$, $1\le r\le m$. Set the nonvariables $s_{k,m+1}=0$ and $W_{0,r}=0$. Add

$$
s_{k,r}-s_{k,r+1}\ge v_r/m,
\qquad s_{k,r}-s_{k,r+1}\ge W_{k-1,r}/m.
\tag{23}
$$

In the strict program impose $W_{k,r}=(r/m)W_{k-1,r}+s_{k,r+1}$; in the weak program impose $W_{k,r}=((r-1)/m)W_{k-1,r}+s_{k,r}$. These equations are needed only for $1\le k<n$. Add $v_r\le v_{r+1}$, the normalization (8), and minimize $s_{n,1}$.

For a fixed $v$, backward summation of (23) shows that each suffix $s$ dominates its sum of maxima. Induction on $k$, using nonnegative coefficients, then shows that every feasible solution dominates the corresponding exact Bellman values. Conversely, choose exact Bellman values and exact suffix sums; all constraints hold and the objective is the true optimum. Minimizing over $v$ proves that the two LP optima are exactly (9).

There are $2nm$ variables, $(m-1)+2nm$ inequalities and $1+(n-1)m$ equalities before optional box bounds. All coefficients are rational, with bit lengths polynomial in $n\log m$. Every normalized $v$ lies in $[0,B]$, $B=1/p_m\le m$; exact Bellman and suffix values also lie in this box. Adding the bound $z\le B$ on every variable leaves the optima unchanged. Taking $m\ge3(n-1)/(2\varepsilon)$ gives discretization width at most $\varepsilon$. This is a polynomial-size scheme in $n$ and $1/\varepsilon$, with finite rational LP solution complexity; it is not a claim of strong polynomiality. This fixed-horizon construction alone does not control all $n$; Section 8 supplies the effective horizon comparison.

### 7.2 Solver-independent lower and upper certificates

Write either boxed minimization LP as

$$
\min d^\mathsf Tz,\quad Az\le b,\quad Cz=e,\quad0\le z\le B.
$$

Choose any rational multipliers $y\le0$ and $\lambda$, and form the exact column residual $r=d-A^\mathsf Ty-C^\mathsf T\lambda$. For every feasible $z$,

$$
d^\mathsf Tz
\ge b^\mathsf Ty+e^\mathsf T\lambda
+B\sum_\ell\min\{0,r_\ell\}.
\tag{24}
$$

Indeed, $y^\mathsf TAz\ge y^\mathsf Tb$ because $y\le0$, the equality term is exact, and $r_\ell z_\ell\ge B\min(0,r_\ell)$. Thus rationalized numerical multipliers remain valid after the explicit residual correction, even if they are not exactly dual-feasible without it. In our LP $b=0$, and $e$ has only its normalization entry nonzero.

For an upper certificate, use any rational nonnegative ordered vector $v$ with $P(v)>0$, compute its Bellman value exactly, and divide by $P(v)$. Combining a strict LP lower certificate $L_S\le a_{n,m}$ with a weak LP upper certificate $b_{n,m}\le U_T$ gives the rigorous interval $[\rho_{n,m}L_S,U_T]$. Numerical residuals are thereby accounted for independently of the discretization error.

### 7.3 Certified examples

The following intervals are outward-rounded from the saved rational fractions. They concern the worst ratio over every allowed distribution at the specified fixed horizon.

| Horizon $n$ | Labels $m$ | Certified lower bound for $c_n$ | Certified upper bound for $c_n$ |
|---:|---:|---:|---:|
| 4 | 512 | 0.7489888665 | 0.7517489987 |
| 8 | 512 | 0.7217716715 | 0.7276291672 |

The strict and weak LPs have respectively the same dimensions: 4096 variables at $n=4$, and 8192 at $n=8$. SciPy/HiGHS supplied discovery solutions. Verification reconstructs all rational coefficients, checks the signs and residual correction in (24), and evaluates the primal candidate with Python integer fractions. The verification path does not import SciPy. The table is not inferred from floating-point solver success. It also is not a global lower bound for $c_{\rm rec}$.

## 8. Effective certification over all horizons

The fixed-horizon result does not by itself control the infimum over arbitrarily large horizons. This section supplies that missing step. The comparison is uniform over all nonnegative priors with positive finite expected maximum, including atoms and unbounded tails, and it covers every causal randomized record policy.

Poissonization and maximum sharding are established tools; see Harb [7], the implicit sharding argument of Bai et al. [1, Section 4], and the fixed-count/Poisson reductions of Kehne and Kesselheim [3, Section 2.3 and Appendix B]. The additional point here is a two-way causal comparison that preserves the record restriction and controls error relative to the expected prophet payoff. A discarded observation can obstruct later record eligibility, so a comparison for unrestricted stopping cannot simply be used without checking this condition.

### 8.1. A common strict-quantile policy class

Let $U_1,\ldots,U_n$ be independent uniform variables on $(0,1)$. For a nonnegative nondecreasing measurable function $f$, let $Q_n(f)$ be the supremum of expected payoff over all causal randomized policies that observe the full uniform history and accept only a strict running record of the uniforms. Payoff is $f(U_\tau)$ if a selection is made and zero otherwise. The admissible policy class is independent of $f$. Write
$$
M_n(f)=\mathbb E f\!\left(\max_{i\le n}U_i\right),\qquad
\mathcal F_n=\{f:0<M_n(f)<\infty\}.
$$
Then the original weak-value-record minimax value satisfies
$$
c_n=\inf_{f\in\mathcal F_n}\frac{Q_n(f)}{M_n(f)}.
\tag{25}
$$

To prove the lower direction, take any admissible value law $F$ and a generalized quantile $f$. After observing $X_i$, generate a fresh independent uniform variable $R_i$ and set
$$
U_i=F(X_i-)+R_i\bigl(F(X_i)-F(X_i-)\bigr).
$$
The randomized distributional transform gives independent uniform $U_i$ with $X_i=f(U_i)$ almost surely. A strict quantile record is a weak value record. Consequently every admissible quantile policy can be implemented causally in the original value model with the same payoff, and $V_n(F)\ge Q_n(f)$. Taking infima gives one inequality in (25).

Conversely, fix any $f\in\mathcal F_n$ and put $f_\eta(u)=f(u)+\eta u$ for $\eta>0$. This function strictly increases; the observations under its induced law determine their quantiles measurably almost surely. Its weak value records and strict quantile records coincide almost surely. Thus $V_n(F_\eta)=Q_n(f_\eta)$. Every policy in the common quantile class changes its payoff by at most $\eta$ when $f$ is replaced by $f_\eta$, so
$$
Q_n(f_\eta)\le Q_n(f)+\eta,\qquad M_n(f_\eta)\ge M_n(f).
$$
It follows that $c_n\le[Q_n(f)+\eta]/M_n(f)$. Letting $\eta$ decrease to zero and then taking the infimum over $f$ proves (25). Measurable monotone representatives may be modified at their countably many discontinuities without affecting these arguments.

Equation (25) is an equality of infima, not an equality of values for each fixed atomic prior. At an atom, weak value ties can permit selections that are forbidden by strict quantile records. The perturbation above is needed precisely to avoid identifying those two per-instance policy classes.

We will also use a simple observation about zero rewards. If a policy would accept a zero-reward observation, replacing that action by permanent forfeiture preserves its payoff. Therefore, in a model in which designated null observations always have payoff zero, one may require the policy never to select a null observation. Their observed auxiliary randomness can still be simulated; no information about future independent observations is lost.

### 8.2. Sparse quantiles and the two marked arrival models

For $0\le q<1$, define $f_q(u)=f(u)\mathbf{1}_{\{u\ge q\}}$. If $Z=\max_iU_i$, then
$$
(1-q^n)M_n(f)\le M_n(f_q)\le M_n(f).
\tag{26}
$$
Here is an integrable proof that does not truncate reward values. Let $A=\{Z<q\}$, let $s=\mathbb P(A)=q^n$, and let $Z'$ be an independent copy of $Z$. Monotonicity gives
$$
0\le
\mathbb E\!\left[(f(Z')-f(Z))\mathbf{1}_{\{Z<q\le Z'\}}\right]
=s\,\mathbb E[f(Z)\mathbf{1}_{A^c}]
 -(1-s)\mathbb E[f(Z)\mathbf{1}_A].
$$
Hence $\mathbb E[f(Z)\mathbf{1}_A]\le sM_n(f)$, proving (26). All terms are finite under the stated first-moment assumption. The case $q=0$ is immediate.

Let $\beta_{n,q}$ denote the infimum in (25) restricted to functions vanishing almost everywhere on $(0,q)$. Since the quantile policy class is unchanged and $f_q\le f$, we have $Q_n(f)\ge Q_n(f_q)$. Therefore
$$
(1-q^n)\beta_{n,q}\le c_n\le\beta_{n,q}.
$$
The upper inequality uses a subclass of adverse payoffs; the lower one follows by applying (26) to each $f$ before taking its infimum.

Fix $R>0$ and an integer $n\ge R$, and set $p=R/n$, $q=1-p$, and $\beta_n(R)=\beta_{n,q}$. Then
$$
(1-e^{-R})\beta_n(R)\le c_n\le\beta_n(R).
\tag{27}
$$
This reduction concerns minimax values. It does not assert that deleting the lower quantiles changes every individual prior's optimal ratio by an exponentially small amount.

For clarity, we now define the two models compared below.

* In the Bernoulli model there are $n$ slots. Each slot is active independently with probability $p=R/n$. An active slot has an independent mark uniform on $(0,R)$; a smaller mark is better. The policy knows the slot index, observes the full marked history, and may accept at most one active mark, only if it is smaller than every previous active mark.
* In the Poisson model, marks arrive on $[0,1]\times(0,R)$ according to a Poisson point process with intensity $dt\,dx$. Equivalently, arrivals have rate $R$ and independent uniform marks on $(0,R)$. The policy observes arrival times and marks causally and may accept only a new smallest mark. The total future number of arrivals is not revealed. An empty process, or no selection, gives payoff zero.

In both models an accepted mark $x$ earns $g(x)$, where $g:(0,R)\to[0,\infty)$ is measurable and nonincreasing. Let $V_B(n,R,g),M_B(n,R,g)$ and $V_P(R,g),M_P(R,g)$ denote optimal and prophet values. For a single uniform mark $X$, write $\mu_g=\mathbb E g(X)$. We restrict to $0<\mu_g<\infty$. Both prophet values obey
$$
(1-e^{-R})\mu_g
 \le \min\{M_B(n,R,g),M_P(R,g)\},
\qquad
\max\{M_B(n,R,g),M_P(R,g)\}\le R\mu_g.
\tag{28}
$$
Indeed, conditional on at least one arrival, the maximum dominates the first mark's payoff, whose distribution is independent of the count. The Bernoulli nonempty probability is $1-(1-p)^n\ge1-e^{-R}$; the Poisson probability is $1-e^{-R}$. The upper bound is the expected sum. Thus the common mark class is exactly the positive finite-prophet class for either model.

The sparse quantile problem has the exact representation
$$
\beta_n(R)=\inf_g\frac{V_B(n,R,g)}{M_B(n,R,g)},\qquad
\beta_P(R)=\inf_g\frac{V_P(R,g)}{M_P(R,g)}.
\tag{29}
$$
For the first identity, use the active mark $x=n(1-u)$ and payoff $g(x)=f(1-x/n)$. Inactive uniforms lie below all active uniforms, so they never prevent an active strict quantile record. Their conditional values are independent uniforms on $(0,q)$ and can be generated causally from the policy's private seed whenever a full-history policy needs them. A proposed zero-reward acceptance is replaced by forfeiture. Conversely, a marked policy can be run on the quantiles by ignoring inactive observations. These two constructions justify (29) even when $g$ has plateaus: the policy observes marks, not merely their possibly equal payoffs.

### 8.3. A causal coupling that preserves every record constraint

Partition $[0,1]$ into $n$ bins. In each bin independently draw $P_i\sim\operatorname{Poisson}(p)$. Set $B_i=1$ whenever $P_i\ge1$. If $P_i=0$, set $B_i=1$ with conditional probability
$$
a_p=\frac{p-1+e^{-p}}{e^{-p}}.
\tag{30}
$$
For $0<p\le1$, $0\le a_p\le1$, because $1-e^{-p}\le p\le1$. The resulting $B_i$ are independent Bernoulli variables with parameter $p$. Conditional Poisson times are ordered independent uniform positions in their bin.

When $P_i\ge1$, share the first chronological Poisson mark with the Bernoulli mark. Draw remaining Poisson marks independently. An augmented Bernoulli mark in an empty Poisson bin is another independent uniform mark. All marks are independent of the count and augmentation variables.

The bad event in a bin is
$$
E_i=\{P_i\ge2\}\cup\{P_i=0,\ B_i=1\},\qquad E=\bigcup_{i=1}^nE_i.
\tag{31}
$$
On $E^c$, the two processes contain the same single mark in each occupied bin and have the same order. This agreement alone is not enough: the policies must also be transferable without learning future bin counts.

To implement a Poisson policy in the Bernoulli model, observe the current slot's $B_i$ and generate $P_i$ from its conditional law given $B_i$. If $B_i=0$, necessarily $P_i=0$. If $B_i=1$ and the generated count is one, assign its time within the bin, feed the actual observed mark to the Poisson policy, and accept that actual mark if instructed. If $P_i\ne B_i$, permanently forgo selection while the constructed policy is still active. This conditional generation uses only current-slot internal randomness. At every acceptance before forfeiture, past active marks agree, so the selected Bernoulli mark is a genuine record. A full Poisson sample beyond a stopped path may be generated for analysis but is never supplied to the online policy.

Conversely, implement a Bernoulli policy in the Poisson model as follows. At the first arrival of a bin, it is already certain that $B_i=1$; feed that mark and the slot index to the Bernoulli policy and accept immediately if instructed. If a second point arrives while the constructed policy is still active, permanently forgo selection. If a bin is empty, perform the augmentation (30) at its endpoint: an augmented $B_i=1$ causes forfeiture, whereas $B_i=0$ is supplied as a null slot. Auxiliary randomness associated with a null observation can be generated at this stage. Before any detected mismatch, active histories coincide, so every actual acceptance is legal in the complete Poisson history, not merely among retained observations.

Forfeiture never cancels an already accepted value. In particular, accepting a bin's first record remains legal if a second point later arrives. Only agreement on $E^c$ is required; on bad paths we bound the loss. Neither direction recalls an expired observation or assumes knowledge at the first point of whether a second point will arrive. These constructions apply to arbitrary randomized full-history policies and to independently randomized clocks.

### 8.4. Weighted errors, unbounded marks, and normalized values

The coupling error must be controlled in expected payoff, not only in probability. Define $K_B=\sum_iB_i$ and $K_P=\sum_iP_i$. Direct calculation gives
$$
s_p:=\mathbb P(E_i)=p(1-e^{-p})\le p^2,\qquad
\mathbb E[B_i\mathbf{1}_{E_i}]
 =\mathbb E[P_i\mathbf{1}_{E_i}]=s_p.
\tag{32}
$$
The first equality for the moments uses $B_i=1$ on $E_i$; the second uses
$\mathbb E[P_i\mathbf{1}_{\{P_i\ge2\}}]=p-pe^{-p}$.
Independence between bins and the union bound imply, for either $K=K_B$ or $K_P$,
$$
\mathbb E[K\mathbf{1}_E]
 \le\sum_i\mathbb E[K\mathbf{1}_{E_i}]
 =ns_p\bigl[1+(n-1)p\bigr]
 \le D_{n,R}:=\frac{R^2(1+R)}n.
\tag{33}
$$
Conditional on all counts and augmentations, the expected sum of the $K$ marked payoffs is $K\mu_g$. Since a prophet payoff is at most this sum,
$$
\mathbb E[M_B^{\rm path}\mathbf{1}_E]\le D_{n,R}\mu_g,\qquad
\mathbb E[M_P^{\rm path}\mathbf{1}_E]\le D_{n,R}\mu_g.
$$
Here $M_B^{\rm path}$ and $M_P^{\rm path}$ denote the random realized maxima, whereas $M_B,M_P$ denote their expectations. The causal transfers agree on $E^c$ and have nonnegative payoff on $E$. Applying them to each admissible policy and then taking suprema yields
$$
|V_B(n,R,g)-V_P(R,g)|\le D_{n,R}\mu_g.
\tag{34}
$$
No existence of an optimal policy is needed.

A sharper estimate is available for the prophet difference. In each bin the two sets share their first mark whenever the Poisson bin is nonempty. The expected number of unmatched marks is
$$
\mathbb E|P_i-B_i|=2(p-1+e^{-p})\le p^2.
$$
Pointwise, the absolute difference of the two maxima is at most the sum of the unmatched nonnegative payoffs. Therefore
$$
|M_B(n,R,g)-M_P(R,g)|\le \frac{R^2}{n}\mu_g.
\tag{35}
$$
This estimate also holds if either realized process is empty.

For positive prophet expectations, write
$$
\left|\frac{V_B}{M_B}-\frac{V_P}{M_P}\right|
\le \frac{|V_B-V_P|}{M_B}
 +\frac{V_P}{M_P}\frac{|M_P-M_B|}{M_B}.
$$
Using $V_P\le M_P$, (28), (34), and (35), we obtain the uniform comparison
$$
\left|\frac{V_B(n,R,g)}{M_B(n,R,g)}
       -\frac{V_P(R,g)}{M_P(R,g)}\right|
\le\delta_n(R):=\frac{R^2(R+2)}{n(1-e^{-R})}.
\tag{36}
$$
Both infima in (29) range over the same class of nonincreasing integrable mark payoffs. Hence
$$
|\beta_n(R)-\beta_P(R)|\le\delta_n(R),\qquad n\ge R.
\tag{37}
$$
The constants do not depend on the magnitude, continuity, or tail shape of $g$. This weighted comparison is why unbounded rewards cause no missing uniform-integrability step.

### 8.5. Maximum sharding and an effective single-horizon theorem

We require only a comparison along integer multiples:
$$
c_{nk}\le c_n,\qquad n,k\ge1.
\tag{38}
$$
We give the construction to specify its direction and record semantics. This use of maximum sharding follows the established methodology of [7] and [1, Section 4].

Take any $f\in\mathcal F_n$, and put $g(u)=f(u^k)$. Group $nk$ independent uniforms into $n$ consecutive blocks of size $k$. Let $W_i$ be the maximum in block $i$ and $V_i=W_i^k$. Then the $V_i$ are independent uniforms and, under the coupling,
$$
\max_{i\le n}f(V_i)
=f\!\left[\left(\max_{j\le nk}U_j\right)^k\right]
=\max_{j\le nk}g(U_j).
\tag{39}
$$

A coarse policy observing $V_i$ can generate the current fine block conditional on its maximum $W_i=V_i^{1/k}$: choose its maximizing position uniformly and generate the other $k-1$ entries independently uniform on $(0,W_i)$. This is the correct conditional law. Fresh conditional randomness across blocks reconstructs the original iid fine sequence. Replay an arbitrary fine-horizon policy with its private seed and complete previously simulated history. If it stops within the current block, accept the current coarse observation. The coarse reward is $f(V_i)=g(W_i)\ge g(U_\tau)$. Moreover, the fine selected uniform exceeded every observation in preceding blocks, so $W_i$ exceeds each preceding block maximum and $V_i$ is a strict coarse record. If it does not stop, store the simulated block and continue.

Only the current coarse maximum is used to generate its block. The fine policy itself receives its simulated observations in order and is never shown the future part of the block. Thus the construction is causal in the coarse problem, and it gives $Q_n(f)\ge Q_{nk}(g)$ with equal prophet expectations. For every $f$,
$c_{nk}\le Q_{nk}(g)/M_{nk}(g)\le Q_n(f)/M_n(f)$; taking the infimum in (25) proves (38). The construction includes $n=1$ and $k=1$. It does not establish ordinary monotonicity from $n$ to $n+1$, and it does not perform the invalid reverse operation of recalling a past block maximum.

**Theorem 5 (Effective comparison with a single horizon).** For $R>0$ and an integer $N\ge R$, define
$$
E_N(R)=e^{-R}
       +\frac{2R^2(R+2)}{N(1-e^{-R})}.
\tag{40}
$$
Then
$$
c_N-E_N(R)\le c_{\rm rec}:=\inf_{n\ge1}c_n\le c_N.
\tag{41}
$$
In particular, if $0<\tau<1$, $R\ge1$ is an integer with $2^R\ge2/\tau$, and
$$
N\ge \frac{8R^2(R+2)}{\tau},
\tag{42}
$$
then $0\le c_N-c_{\rm rec}\le\tau$.

**Proof.** First fix $n\ge N$. By (27) and (37),
$$
\begin{aligned}
c_n
&\ge(1-e^{-R})\bigl(\beta_P(R)-\delta_n(R)\bigr)\\
&\ge(1-e^{-R})\bigl(c_N-\delta_N(R)-\delta_n(R)\bigr)\\
&\ge c_N-e^{-R}-2\delta_N(R).
\end{aligned}
$$
The last step uses $0\le c_N\le1$ and $\delta_n(R)\le\delta_N(R)$. For an arbitrary positive integer $h$, (38) gives $c_h\ge c_{hN}$, and the displayed comparison applies to $hN\ge N$. Hence the same lower bound holds for every $h$, proving (41). The upper bound is immediate from the definition of the infimum.

For (42), $1-e^{-R}\ge1/2$ and $e^{-R}\le2^{-R}\le\tau/2$. Thus $2\delta_N(R)\le4R^2(R+2)/N\le\tau/2$. The prescribed $N$ is automatically at least $R$. This proves the explicit error statement. $\square$

Combining (41) with the full-quantile LPs of Theorem 2 already gives
$$
\rho_{N,m}a_{N,m}-E_N(R)\le c_{\rm rec}\le b_{N,m}.
\tag{43}
$$
For a total target width $\varepsilon\in(0,1)$, take $\tau=\varepsilon/2$, choose $2^R\ge4/\varepsilon$, take $N=\lceil16R^2(R+2)/\varepsilon\rceil$, and take $m\ge\lceil3(N-1)/\varepsilon\rceil$. The analytic interval width is at most $\varepsilon$. This allocation counts both the horizon error and the finite-quantile error. The next two subsections reduce the LP dimension by discretizing only active marks.

We also record a useful consequence. Apply (38) with $hk\to\infty$ while keeping $h$ and $R$ fixed; (27) and (37) give $c_h\ge(1-e^{-R})\beta_P(R)$. Conversely, $c_{\rm rec}\le c_n\le\beta_n(R)$ for arbitrarily large $n$, so (37) gives
$$
(1-e^{-R})\beta_P(R)\le c_{\rm rec}\le\beta_P(R).
\tag{44}
$$
Thus the finite-rate Poisson minimax is itself an effective approximation to the global constant, with error at most $e^{-R}$. This conclusion follows from the proved comparisons, rather than an unquantified passage to a formal continuous limit.

### 8.6. Sparse active-label linear programs

Fix $R>0$, an integer $N\ge R$, and an integer $m\ge1$. Put $p=R/N$ and $h=p/m$. In each Bernoulli slot, let label $0$ denote inactivity, with probability $1-p$, and let each active label $j\in\{1,\ldots,m\}$ have probability $h$. Larger active labels are better. For sorted values $0\le v_1\le\cdots\le v_m$, define
$$
P_{N,R,m}(v)=\sum_{j=1}^m w_jv_j,\qquad
w_j=(1-p+jh)^N-(1-p+(j-1)h)^N.
\tag{45}
$$
Label $0$ has payoff zero and is never selected. Define $a^{\rm s}_{N,R,m}$ and $b^{\rm s}_{N,R,m}$ by minimizing, subject to $P_{N,R,m}(v)=1$, the optimal strict-active-label-record and weak-active-label-record rewards, respectively. Both policy classes observe complete label histories and allow independent randomization. Labels remain distinguishable when their assigned values coincide.

The sparse counterpart of Theorem 2 is
$$
\rho^{\rm s}_{N,R,m}a^{\rm s}_{N,R,m}
 \le\beta_N(R)\le b^{\rm s}_{N,R,m}
 \le a^{\rm s}_{N,R,m}+\frac{(N-1)p}{m},
\qquad
\rho^{\rm s}_{N,R,m}
 =\frac{1-(1-p/m)^N}{Np/m}.
\tag{46}
$$
In particular,
$$
b^{\rm s}_{N,R,m}
 -\rho^{\rm s}_{N,R,m}a^{\rm s}_{N,R,m}
 \le\frac{3(N-1)p}{2m}\le\frac{3R}{2m}.
\tag{47}
$$

We give the details because inactivity changes the initial-state recurrence. Regard an active payoff as a nondecreasing function of the original quantile on $(1-p,1)$ and zero below $1-p$. Divide that active interval into $m$ bins of width $h$, and let $v_j$ be the mean payoff in bin $j$. The discrete prophet in (45) lies between $\rho^{\rm s}$ times the original prophet and the original prophet. For the upper comparison, condition on the largest occupied active bin: its largest uniform quantile has expected nondecreasing payoff at least the bin mean.

For the lower estimate, the layer-cake argument reduces it to a payoff $\mathbf{1}_{\{u>z\}}$ with $z$ in an active bin $[a,a+h]$. Write $z=a+th$. The continuous prophet is $1-z^N$, and its bin-mean approximation is
$$
A(z)=1-(a+h)^N+(1-t)\bigl((a+h)^N-a^N\bigr).
$$
Their nonnegative difference is
$$
E(a,t)=(1-t)a^N+t(a+h)^N-(a+th)^N.
$$
For $N\ge2$, convexity of $x^{N-1}$ gives $\partial_aE(a,t)\ge0$ at fixed $h,t$, whereas $1-(a+th)^N$ decreases as the bin moves right. Thus the relative deficit is largest in the final bin. There
$$
\frac{A(z)}{1-z^N}
 =\frac{[1-(1-h)^N]/h}{1+z+\cdots+z^{N-1}}
 \ge\frac{1-(1-h)^N}{Nh}=\rho^{\rm s}.
$$
The endpoint $z=1$ is interpreted by a limit; $N=1$ is equality. Integrating this tail inequality proves the bound for unbounded integrable payoffs. It is sharp as a bin-mean factor when $z$ approaches one.

A strict active-label policy is a legal strict quantile-record policy, and its expected payoff equals its bin-mean payoff. This proves the first inequality in (46). For the reverse transfer, perturb a finite sorted vector by adding $\eta u$ on its active quantile interval and retaining zero payoff on the inactive interval. A quantile-record policy can be simulated by a weak active-label policy that generates independent uniforms within observed bins and generates any needed inactive quantiles. Its payoff differs by at most $\eta$. Sending $\eta$ to zero gives $\beta_N(R)\le b^{\rm s}$. This reasoning does not replace repeated label values by ordinary weak-value atoms.

For the last inequality in (46), simulate a weak-label policy, but permanently forgo selection if it would select the current active maximum label a second time. This is a causal strict-label policy. At slot $i\ge2$, conditional on the prior maximum active label $J^*_{i-1}$, a repeated active record has expected payoff
$$
h\,v_{J^*_{i-1}}\mathbf{1}_{\{J^*_{i-1}\ge1\}}.
$$
Its expectation is at most $hP_{N,R,m}(v)$. Summing over $i=2,\ldots,N$ gives the claimed loss bound and then the infimum comparison. Finally,
$\rho^{\rm s}=N^{-1}\sum_{k=0}^{N-1}(1-h)^k
\ge1-(N-1)h/2$
by Bernoulli's inequality. Together with $a^{\rm s}\le1$, this proves (47).

Here are explicit sparse LPs. Use nonnegative variables $v_j$, continuation values $W_{k,r}$ for $1\le k\le N$ and $0\le r\le m$, and suffix variables $s_{k,j}$ for $1\le k\le N$, $1\le j\le m$. Set $W_{0,r}=0$ and $s_{k,m+1}=0$. Impose
$$
s_{k,j}-s_{k,j+1}\ge h v_j,\qquad
s_{k,j}-s_{k,j+1}\ge h W_{k-1,j}.
\tag{48}
$$
For both LPs the empty-active-history recurrence is
$$
W_{k,0}=(1-p)W_{k-1,0}+s_{k,1}.
\tag{49}
$$
For $r\ge1$, use respectively
$$
\begin{aligned}
W^{\rm strict}_{k,r}
 &=(1-p+rh)W^{\rm strict}_{k-1,r}+s_{k,r+1},\\
W^{\rm weak}_{k,r}
 &=(1-p+(r-1)h)W^{\rm weak}_{k-1,r}+s_{k,r}.
\end{aligned}
\tag{50}
$$
Add $v_j\le v_{j+1}$ and $\sum_jw_jv_j=1$, and minimize $W_{N,0}$. The state $r=0$ is essential: a null slot consumes one opportunity without creating an active record.

Conditioning on the current maximum label and the remaining horizon proves Bellman sufficiency for all behavioral histories; future labels retain their original independent law. The exact suffix is
$s_{k,j}=h\sum_{\ell=j}^m\max\{v_\ell,W_{k-1,\ell}\}$.
Forward induction shows every feasible epigraph dominates these Bellman values, while the exact Bellman values give a feasible solution. Thus the two LP optima are exactly $a^{\rm s}$ and $b^{\rm s}$. Omit the unused variables $W_{N,r}$ for $r\ge1$ and their final-row equations. The remaining formulation has exactly $N(2m+1)$ variables and $O(Nm)$ constraints.

Every normalized sorted value vector satisfies
$$
0\le v_j\le v_m\le B:=\frac1{w_m}
 =\frac1{1-(1-p/m)^N}.
\tag{51}
$$
Exact continuation values and suffixes are also at most $B$. Consequently the LPs may restrict every variable to $[0,B]$ without changing their optima. For rational $R$, all coefficients are rational. The exact certification method used earlier therefore applies unchanged: rational dual multipliers with the appropriate inequality sign give a lower bound after compensating each negative column residual by $B$ times its magnitude. A rational sorted candidate evaluated by exact Bellman recursion gives an upper bound. Solver tolerances are not themselves certificates.

### 8.7. Two rational LPs certify the global constant

**Theorem 6 (Effective global certification by active-label LPs).** Let $R\ge1$ be an integer, $N\ge R$ and $m\ge1$ be integers, and put $C_R=R^2(R+2)$. Then
$$
(1-e^{-R})\rho^{\rm s}_{N,R,m}a^{\rm s}_{N,R,m}
 -\frac{C_R}{N}
 \le c_{\rm rec}\le b^{\rm s}_{N,R,m}.
\tag{52}
$$
Replacing $e^{-R}$ by $2^{-R}$ in the lower endpoint gives a completely rational interval of width at most
$$
\frac{3R}{2m}+2^{-R}+\frac{C_R}{N}.
\tag{53}
$$
For any rational $0<\varepsilon<1$, choose
$$
2^R\ge\frac3\varepsilon,\qquad
N=\left\lceil\frac{3R^2(R+2)}{\varepsilon}\right\rceil,\qquad
m=\left\lceil\frac{9R}{2\varepsilon}\right\rceil.
\tag{54}
$$
The two rational LPs then produce an interval containing $c_{\rm rec}$ with width at most $\varepsilon$.

**Proof.** By (44), (37), and (46),
$$
c_{\rm rec}
 \ge(1-e^{-R})\beta_P(R)
 \ge(1-e^{-R})\bigl(\rho^{\rm s}a^{\rm s}-\delta_N(R)\bigr).
$$
The denominator in $\delta_N(R)$ cancels, giving the lower endpoint in (52). For the upper endpoint, $c_{\rm rec}\le c_N\le\beta_N(R)\le b^{\rm s}$. Since $0\le\rho^{\rm s}a^{\rm s}\le1$ and $e^{-R}\le2^{-R}$, replacing $e^{-R}$ by $2^{-R}$ lowers the left endpoint. Equation (47) then bounds the resulting width by (53). Each of its three terms is at most $\varepsilon/3$ under (54), and the prescribed $N$ is at least $R$. $\square$

The lower endpoint may be replaced by its maximum with zero. If $L_a$ is an exactly verified rational lower bound for $a^{\rm s}$ and $U_b$ is an exactly verified rational upper bound for $b^{\rm s}$, the actually certified interval is
$$
\left[
\max\left\{0,(1-2^{-R})\rho^{\rm s}L_a-\frac{C_R}{N}\right\},
\ U_b
\right].
\tag{55}
$$
For exact LP optima, (54) gives the stated width directly. For numerical discovery followed by rational certificates, the remaining LP primal/dual gaps must also be budgeted. For example, use $\varepsilon/2$ in (54) and require the additional certified endpoint gap to be at most $\varepsilon/2$. The residual method makes this last check an explicit rational inequality.

Taking $R$ of order $\log(1/\varepsilon)$, the LPs have
$O(\log^4(1/\varepsilon)/\varepsilon^2)$ variables and constraints. Their coefficients have polynomial bit length: powers in (45) have exponent $N$ and rational bases with denominator at most $Nm$. This is an effective finite algorithm for the global infimum, not only a statement about each fixed horizon or a qualitative limit. The constants remain large. We have not solved every LP at the dimensions prescribed for small $\varepsilon$, and this theorem does not identify a sharp numerical constant or a matching extremal prior.

### 8.8. A classical baseline

For completeness, a classical single-threshold policy supplies a global lower bound. Let $q=1-1/n$ and accept the first uniform quantile at least $q$. Such an observation is automatically a strict record. Its expected payoff is
$$
(1-q^n)\,\frac1{1-q}\int_q^1 f(u)\,du.
\tag{56}
$$
If $Y$ is uniform on $(q,1)$ and $Z=\max_{i\le n}U_i$, then $Y$ stochastically dominates $Z$. Indeed, for $q\le z\le1$,
$$
\mathbb P(Y\le z)=nz-n+1\le z^n=\mathbb P(Z\le z),
\tag{57}
$$
where the inequality is the tangent-line bound for the convex function $z^n$; below $q$ the left side is zero. Thus $\mathbb E f(Y)\ge M_n(f)$. Equation (56), the randomized-PIT implementation for arbitrary value laws, and $(1-1/n)^n\le e^{-1}$ give
$$
c_{\rm rec}\ge1-\frac1e.
\tag{58}
$$
This argument includes $n=1$, for which the ratio is one. The lower bound is classical, consistent with the iid single-threshold guarantee discussed in [1, Section 1.4]; it is not claimed as a new contribution.

Combining (58) with the exact 100-observation certificate established earlier gives the following baseline interval, strengthened by the explicit certificate in Section 8.9:
$$
1-\frac1e\ \le\ c_{\rm rec}\
\le\frac{R_{100}}{P_{100}}
<0.7172690287559823.
\tag{59}
$$
Here $R_{100}/P_{100}$ denotes the earlier exact rational witness ratio; the displayed decimal is an outward upper bound. The lower endpoint in (59) is not a new lower bound obtained by solving the large LPs in (54). The new result of this section is the proved, quantitatively controlled procedure for narrowing the global interval to any prescribed rational accuracy, with full treatment of record legality, private randomization, atoms, and unbounded first moments.

The rare-event candidate developed separately is not used in Theorems 5–6 and is not asserted here to describe a worst prior. Maximum sharding, Poissonization, and the general quantile-LP viewpoint are credited to their existing literature. The contribution proved here is their record-preserving weighted transfer and the resulting effective certification over all horizons.

### 8.9. An explicit policy certificate above 0.6817

The effective approximation theorem also permits a concrete lower bound without solving a large LP to optimality. We give a frozen randomized policy for one sparse active-label instance, certify its performance simultaneously for every nonnegative ordered reward vector, and apply the transfer theorem.

Tail coverage and occupancy formulations are established methods in prophet inequalities; see Jiang, Ma, and Zhang [9, Section 1.1 and Proposition 4.8] for Type Coverage and finite approximation. We use those ideas with the additional past-record state and exact downward rounding. The multiplicative-weights search and occupancy-flow averaging used to discover the policy are not new methods and are not trusted by the certificate.

**The frozen policy.** Fix
$$
N=50000,\qquad m=1024,\qquad R=4,\qquad
p=\frac{R}{N},\quad h=\frac{p}{m},\quad
D=10^6,\quad S=2^{128}.
\tag{60}
$$
The original certificate uses a $128\times128$ table of integers $A_{uv}\in\{0,\ldots,D\}$, indexed by $0\le u,v<128$. At slot $t+1$, where $0\le t<N$, and active label $j\in\{1,\ldots,m\}$, put
$$
u(t)=\left\lfloor\frac{128t}{N}\right\rfloor,\qquad
v(j)=\left\lfloor\frac{128(j-1)}{m}\right\rfloor,\qquad
a_{tj}=\frac{A_{u(t),v(j)}}{D}.
\tag{61}
$$
The stored table is row-major, with offset $128u+v$. If the policy has not accepted and $j$ is strictly greater than every previously observed active label, it accepts with probability $a_{tj}$, using fresh private randomness. Otherwise it continues. Null slots never cause acceptance. The rule depends on the record state, slot, and observed label; it is independent of the reward vector.

**Exact occupancy recurrence.** Let $P_{t,r}$ be the probability that, after $t$ slots, there has been no acceptance and the largest active label seen is $r$, with $r=0$ meaning that all slots have been null. Let $q_{t,j}$ be the probability of having accepted label $j$ by that time. Initially $P_{0,0}=1$, all other entries are zero. Independence of the next label gives
$$
\begin{aligned}
P_{t+1,0}&=(1-p)P_{t,0},\\
P_{t+1,j}
 &= (1-p+jh)P_{t,j}
    +h(1-a_{tj})\sum_{r=0}^{j-1}P_{t,r},\\
q_{t+1,j}
 &=q_{t,j}+ha_{tj}\sum_{r=0}^{j-1}P_{t,r}
 \qquad(1\le j\le m).
\end{aligned}
\tag{62}
$$
For the second line, a state already at $j$ remains there whenever the next label is null or at most $j$; a state below $j$ enters $j$ only when the new observation is $j$ and is rejected. These are disjoint exhaustive ways to reach the state while remaining unaccepted. In particular, equal labels are rejected rather than counted as eligible records.

The verifier maintains integers $Z_{t,r}$ and $Q_{t,j}$ satisfying $Z_{t,r}/S\le P_{t,r}$ and $Q_{t,j}/S\le q_{t,j}$. Put $H=Nm$, $K_j=H-Rm+Rj$, and $F_{t,j}=\sum_{r<j}Z_{t,r}$. Starting from $Z_{0,0}=S$ and all other entries zero, it computes
$$
\begin{aligned}
Z_{t+1,0}
 &=\left\lfloor\frac{(N-R)Z_{t,0}}{N}\right\rfloor,\\
Z_{t+1,j}
 &=\left\lfloor
   \frac{D K_j Z_{t,j}+R(D-A_{u(t),v(j)})F_{t,j}}{HD}
   \right\rfloor,\\
Q_{t+1,j}
 &=Q_{t,j}+
   \left\lfloor\frac{R A_{u(t),v(j)}F_{t,j}}{HD}\right\rfloor.
\end{aligned}
\tag{63}
$$
All coefficients of the recurrence are nonnegative. Induction on $t$, using the monotonicity of each update and downward rounding, proves both lower-bound invariants. Lost probability mass is never redistributed. The argument requires no floating-point error estimate.

**Uniformity over reward vectors.** Write $q_j=q_{N,j}$, set $v_0=0$, and let $\Delta_\ell=v_\ell-v_{\ell-1}\ge0$. For any ordered vector $0\le v_1\le\cdots\le v_m$, the policy payoff and prophet value have the exact tail decompositions
$$
\begin{aligned}
\sum_{j=1}^m q_jv_j
 &=\sum_{\ell=1}^m\Delta_\ell
       \sum_{j=\ell}^m q_j,\\
P(v)
 &=\sum_{\ell=1}^m\Delta_\ell
       \left[1-(1-p+(\ell-1)h)^N\right].
\end{aligned}
\tag{64}
$$
Consequently, a lower bound on all $m$ tail ratios is a lower bound on the payoff ratio for every such vector with positive prophet value. No search over reward vectors is left to the numerical optimizer.

For each $\ell$, the integer power routine returns $L_\ell$ such that
$$
\frac{L_\ell}{S}\le
 \left(1-p+(\ell-1)h\right)^N.
$$
Then $1-L_\ell/S$ is an upper bound on the prophet tail probability. Define
$$
\underline\alpha
 =\min_{1\le\ell\le m}
   \frac{\sum_{j=\ell}^m Q_{N,j}}{S-L_\ell}.
\tag{65}
$$
The denominators are positive in this instance and are explicitly checked. Equations (63)–(65) show that the fixed policy guarantees at least $\underline\alpha$ for every ordered reward vector. In the notation of Section 8.6 this proves $a^{\rm s}_{N,R,m}\ge\underline\alpha$, since the optimal strict-label policy performs at least as well as the fixed policy for each vector.

For completeness, the power routine also returns upper bounds. For a rational base $b\in[0,1]$, it starts from $\lfloor Sb\rfloor$ and $\lceil Sb\rceil$, uses binary exponentiation, and after every multiplication divides by $S$, rounding down in the lower calculation and up in the upper calculation. Multiplication of nonnegative quantities preserves the enclosing inequalities, so induction through the squaring and multiplication steps certifies the final power enclosure. In particular, if $U/S\ge(1-h)^N$, then
$$
\underline\rho
 =\frac{m(S-U)}{RS}
 \le \rho^{\rm s}_{N,R,m}.
\tag{66}
$$

**Exact numerical certificate and global transfer.** Running the supplied integer verifier on the frozen table gives
$$
\begin{aligned}
\underline\alpha
 &=\frac{925667605166334915366180081210912158}
         {1326635276179195797879956125294843825}
   \approx0.6977559106013852,\\
\underline\rho
 &=\frac{10364338095149967170937157228865189}
         {10384593717069655257060992658440192}
   \approx0.9980494545601343.
\end{aligned}
\tag{67}
$$
The minimum certified tail ratio in (65) occurs at $\ell=1024$. This identifies the minimum among the computed lower bounds, not an optimal adversary or a matching worst-case prior.

To make the final transcendental comparison rational, put
$$
T_{60}=\sum_{k=0}^{60}\frac{(-1)^k}{k!},
\qquad e^{-1}\le T_{60},\qquad
\underline L=(1-T_{60}^{\,4})\,\underline\rho\,
                   \underline\alpha-\frac6{3125}.
\tag{68}
$$
The even alternating Taylor partial sum is an upper bound on $e^{-1}$; its positive fourth power therefore bounds $e^{-4}$ above. The penalty is exactly $R^2(R+2)/N=96/50000=6/3125$. Theorem 6, (65), and (66) imply $c_{\rm rec}\ge\underline L$. The report stores $\underline L$ as an exact rational number and checks by cross multiplication that
$$
\underline L>\frac{6817}{10000},
\qquad
\underline L\approx0.6817199883697221.
\tag{69}
$$
The decimals in (67) and (69) are for display only. Together with the earlier exact 100-observation upper witness, the resulting all-horizon interval is
$$
\boxed{\quad
0.6817<c_{\rm rec}<0.7172690287559823.
\quad}
\tag{70}
$$

The numerical lower bound relies on the fixed action table, integer verifier, and exact report described here; those three artifacts are not included in this edition. The bound has not been independently recomputed during preparation of this edition.

The report includes all 1024 acceptance-probability lower numerators, all tail-ratio lower bounds, the scaling denominator, and the exact final rational comparison. The certificate validates this explicit policy, not an LP optimum. Verification of the fixed policy does not rely on the discovery procedure.

The arithmetic program checks the finite recurrence and rational comparisons. The record-preserving quantile and Poisson transfer, which extend this guarantee to arbitrary horizons and arbitrary nonnegative priors with finite positive expected maximum, remain the analytic statements proved in Sections 8.1–8.7. No claim is made that the lower endpoint is sharp or the first such improvement in the literature, that a large LP has been solved to optimality, or that the analytic transfer has been verified by this arithmetic program.

## 9. Related work, interpretation and limits

The motivating question and fixed-prior threshold optimization are due to Bai et al. [1]. Correa et al. [2] provide the unrestricted lower benchmark used for separation. Kehne and Kesselheim [3] study simultaneous consistency and robustness and also give fixed-count/Poisson reductions. Our model has a correct known prior and no positive robustness requirement; our two-way comparison additionally preserves the record restriction while uniformly controlling integrable marked rewards.

Fixed-horizon all-distribution optimization and certified discretization already appear in Goldenshluger, Malinovsky and Zeevi [4]. Jiang, Ma and Zhang [9] develop type coverage, occupancy formulations, and fixed-horizon arbitrary-accuracy approximation. Brüstle, Perez-Salazar and Verdugo [6] connect multiple-selection quantile LPs to nonlinear systems and asymptotic guarantees. Allaart [5] instead restricts information to record indicators and uses a different terminal convention. None of these model distinctions makes general Bellman, quantile, occupancy or LP methods new.

Poissonization and maximum sharding are established by Harb [7] and are explicitly used in [1]. A recent unrefereed fixed-capacity manuscript [8] proves an unrestricted iid limiting game with lower and upper transfers for fixed policies or bounded profiles. Its stated results do not identify that limit with the all-horizon infimum or provide a rate uniform over the whole game. We inspected its frozen primary manuscript; we do not rely on its correctness. The specific increment here is a reward-weighted causal comparison uniform over all admissible mark payoffs, together with the record-preserving multiple-horizon comparison and an explicit rational global certificate.

The finite witness describes a concrete loss: rejecting an early useful record preserves a chance at a rare large reward, but the record restriction may then bar a later useful fallback. Correct prior knowledge does not restore that forbidden action. The all-horizon proof explains why arbitrarily rare and unbounded rewards do not escape the certification procedure.

The sharpness of the bin-mean factor is distinct from sharpness of the final minimax constant. We have proved effective global approximability and an explicit numerical interval; we have not identified the exact constant, proved attainment by an extremal law, or established a matching rare-event family. The theoretical LP schedules can be very large. The explicit policy certificate checks a feasible lower strategy, not an optimum of those large LPs. Positive guarantees for the larger adaptive class do not imply the corresponding guarantee for the smaller time-only threshold class.

The manuscript has not undergone external peer review. The literature comparison is limited to inspected sources and versions. The official indexed abstract of the recent kernel-method paper [10] was available, but its primary full text could not be retrieved; no uninspected theorem supports a proof or priority claim here. Full Lean formalization remains incomplete. Accepted finite Bellman and arithmetic checkpoints do not establish the measure-theoretic policy bridge, quantile integrals, causal Poisson transfer, global infimum argument or the whole-paper claim list. The Lean sources are not included in this edition.

## Appendix A. Thirty-point exact instance

Use $n=100,Q=100000000,B=1000000$, with $p_j=a_j/Q$ and $x_j=b_j/B$. All masses are positive, their sum is $Q$, and the $b_j$ are strictly increasing.

| $j$ | $a_j$ | $b_j$ | $j$ | $a_j$ | $b_j$ |
|---:|---:|---:|---:|---:|---:|
| 1 | 92000000 | 0 | 16 | 3440 | 518803 |
| 2 | 3076597 | 356140 | 17 | 2117 | 518804 |
| 3 | 1893416 | 395575 | 18 | 1303 | 518805 |
| 4 | 1165256 | 429711 | 19 | 802 | 518806 |
| 5 | 717128 | 457099 | 20 | 493 | 518807 |
| 6 | 441339 | 478800 | 21 | 304 | 518808 |
| 7 | 271611 | 490346 | 22 | 187 | 518809 |
| 8 | 167156 | 502721 | 23 | 115 | 518810 |
| 9 | 102872 | 506563 | 24 | 71 | 518811 |
| 10 | 63310 | 512936 | 25 | 44 | 518812 |
| 11 | 38963 | 514916 | 26 | 27 | 518813 |
| 12 | 23979 | 516337 | 27 | 16 | 518814 |
| 13 | 14757 | 516338 | 28 | 10 | 518815 |
| 14 | 9082 | 517313 | 29 | 6 | 518816 |
| 15 | 5589 | 518802 | 30 | 10 | 52170724577 |

## References

[1] T. Bai, Z. Huang, C. S. Lee and D. Li. *Optimal Stopping with a Predicted Prior*. arXiv:2511.03289v2, 2026. [Official version](https://arxiv.org/abs/2511.03289v2). The motivating question is in Section 3.3.

[2] J. Correa, P. Foncea, R. Hoeksma, T. Oosterwijk and T. Vredeveld. *Posted Price Mechanisms for a Random Stream of Customers*. ACM EC 2017, DOI [10.1145/3033274.3085137](https://doi.org/10.1145/3033274.3085137), Corollary 4.7. [Institutional author PDF](https://cris.maastrichtuniversity.nl/ws/files/77974044/Oosterwijk_2017_Posted_Price_mechanisms_for_a_random_stream.pdf).

[3] G. Kehne and T. Kesselheim. *Prophet and Secretary at the Same Time*. arXiv:2511.09531v1, 2025. [Official version](https://arxiv.org/abs/2511.09531v1).

[4] A. Goldenshluger, Y. Malinovsky and A. Zeevi. *Optimal single-threshold stopping rules and sharp prophet inequalities*. Journal of Applied Probability, 2026. DOI [10.1017/jpr.2026.10117](https://doi.org/10.1017/jpr.2026.10117). [Author preprint v4](https://arxiv.org/abs/2404.12949v4).

[5] P. C. Allaart. *A Sharp Ratio Inequality for Optimal Stopping When Only Record Times are Observed*. Sequential Analysis, 2009. DOI [10.1080/07474940903238136](https://doi.org/10.1080/07474940903238136). [Author PDF](https://sites.math.unt.edu/~allaart/papers/record-times.pdf).

[6] J. Brüstle, S. Perez-Salazar and V. Verdugo. *Splitting Guarantees for Prophet Inequalities via Nonlinear Systems*. arXiv:2406.17767v2, 2025. [Official version](https://arxiv.org/abs/2406.17767v2).

[7] E. Harb. *New Prophet Inequalities via Poissonization and Sharding*. arXiv:2307.00971v4, 2024. [Official version](https://arxiv.org/abs/2307.00971v4).

[8] Anonymous. *Asymptotic i.i.d. prophet inequalities: fixed-capacity limits and certified two-unit bounds*. Version 0.1.0-candidate, 2026. DOI [10.5281/zenodo.23404235](https://doi.org/10.5281/zenodo.23404235). Unrefereed candidate; [frozen primary manuscript](https://github.com/ipitchford/iid-multiunit-prophet-limits/blob/30789207c579d1a873e507fc7b22820056815093/paper.md).

[9] J. Jiang, W. Ma and J. Zhang. *Tightness without Counterexamples: A New Approach and New Results for Prophet Inequalities*. arXiv:2205.00588v5, 2025, Section 4.3 and Proposition 4.8. [Official version](https://arxiv.org/abs/2205.00588v5).

[10] P. Loiseau, M. Molina, V. Perchet, S. Perez-Salazar and V. Verdugo. *Kernel Methods for Refined Prophet Inequalities*. arXiv:2608.08662, 2026. [Official entry](https://arxiv.org/abs/2608.08662). Indexed abstract inspected; full primary text unavailable during this review.
