---
title: "Global Learning, Sharp Attractor Bounds, and the Critical Discrete Step in Scalar Linear-Quadratic Games"
date: "25 November 2026"
lang: en
---

# Abstract

Consider an infinite-horizon scalar linear-quadratic game with a common discount factor, an arbitrary finite number of players, strictly positive private state costs, and stationary linear feedback policies. We give a common structural proof of global learning results without a contraction, weak-coupling, equilibrium-uniqueness, or nondegeneracy assumption. The product of the private quadratic numerators divided by the common discounted-stability denominator is a proper ordinal potential. An exact square identity for each best response supplies a uniform descent certificate. A polynomial obtained from all conjugates of the known square-root equilibrium parametrization proves that the equilibrium set is finite, including degenerate parameter values. These facts imply full-sequence convergence of every bounded-gap sequential exact-best-response schedule, almost-sure full-sequence convergence under independent random activation, and full-trajectory convergence of continuous raw policy-gradient and continuous best-response dynamics from every finite-cost initial profile. Explicit bounds on squared best-response or gradient residuals are of order $1/T$.

For symmetric costs, we classify all finite-cost equilibria for every player count and every parameter value. A strictly increasing normalized branch derivative gives the complete fold structure and counts distinct policy vectors at folds and at complete branch coalescence. We then give an exact branchwise test for physical plant stability, distinguish it from finite discounted cost, and determine the potential's full inertia on every nondegenerate branch. For at least three players, the numbers of local potential minima are $1$, $N+1$, and $N$ in three precisely specified parameter regions. All degenerate boundaries are resolved: the first fold is not a local minimum, the complete coalescence is not a minimum when $N\ge3$, whereas the two-player coalescence is a strict global minimum with an explicit sum-of-squares certificate. Local simultaneous-best-response spectra and a one-step loss-of-stability example show why the different learning rules cannot be interchanged.

Beyond symmetry, we classify every local potential minimum for arbitrary positive cost vectors. This includes interior fourth-order minima and repeated-maximum-cost endpoints with a sixth-order reduced potential. The minima are exactly the locally asymptotically stable equilibria of the two continuous learning flows. Their sharp maximum number is two for two players and $N+1$ for $N\ge3$, attained by explicit pairwise-distinct positive costs. An exhaustive procedure needs only $N+1$ candidate branches and a linear number of monotone intervals, rather than all sign patterns; this is not a bit-complexity claim.

The square-root representation, large-parameter multiplicity, two-player learning results, previously studied three-player threshold, and continuous-time antecedents of the branch-shape method are attributed to their sources. The claimed increment combines heterogeneous global learning, complete attractor classification with a sharp bound, and the complete symmetric equilibrium landscape. With heterogeneous discounts, an inverse-slope potential provides global continuous convergence and an autonomous fixed-step discrete update. The update's power of the common boundary slack is sharp: power two is the only one in the stated family that guarantees joint-feasibility and a uniform inward shift from the entire strip.

# 1. Model, scope, and relation to prior work

## 1.1. The normalized game

Let $N\ge1$, $a\in\mathbb R$, $0<\gamma\le1$, and $\sigma_i>0$ for every $i\in\{1,\ldots,N\}$. The state and controls are scalar:

$$
x_{t+1}=a x_t+\sum_{i=1}^N u_{i,t},\qquad
\mathcal J_i=\sum_{t=0}^{\infty}\gamma^t(\sigma_i x_t^2+u_{i,t}^2).
$$

Player $i$ uses a stationary linear policy $u_{i,t}=k_i x_t$. Define

$$
r(k)=a+\sum_i k_i,\quad D(k)=1-\gamma r(k)^2,\quad
f_i(k_i)=\sigma_i+k_i^2,
$$

and the finite-cost domain

$$
\mathcal D=\{k\in\mathbb R^N:D(k)>0\}.
$$

For any nonzero initial state, the normalized value coefficient is

$$
J_i(k)=\mathcal J_i/x_0^2=\frac{f_i(k_i)}{D(k)},\qquad k\in\mathcal D.
\tag{1.1}
$$

Outside $\mathcal D$, the cost is infinite. We define an equilibrium using these normalized coefficients, equivalently by requiring the equilibrium inequalities for every initial state. The identically zero initial state alone cannot define the intended problem because it makes all deterministic costs zero.

A **feedback Nash equilibrium**, abbreviated FNE, is a profile at which every stationary linear unilateral deviation has at least the player's current cost. A unilateral choice that makes $r=0$ always has finite cost. Consequently every FNE lies in $\mathcal D$. Within that domain, each player optimizes over an open interval determined by the opponents. The domain is a joint strip, not a Cartesian product of fixed action sets.

We call a profile **plant stable** when $|r(k)|<1$. This is stronger than finite discounted cost when $\gamma<1$. Statements about learning within $\mathcal D$ will retain this distinction throughout.

The normalized model covers dynamics $x_{t+1}=a x_t+\sum_i b_i u_{i,t}$ with $b_i\ne0$ and positive weights $q_i,r_i^{\mathrm{cost}}$, after setting $v_i=b_i u_i$ and $\sigma_i=b_i^2q_i/r_i^{\mathrm{cost}}$. Multiplying player $i$'s objective by a positive constant does not change best responses. The positive diagonal learning gains allowed below also accommodate the corresponding rescaling of raw policy gradients.

Sections 1–10 concern stationary scalar feedback with strictly positive state costs and a common discount. Sections 11–12 extend the global learning results to heterogeneous discounts. The equilibrium-count and attractor classifications retain the common discount.

## 1.2. What is already known, and the remaining increment

Nortmann, Sassano, and Mylvaganam [R1] give a graphical square-root representation of scalar $N$-player FNE and derive existence, uniqueness in some regimes, and the large-$|a|$ count $2^N-1$. Our scalar equilibrium coordinate is their representation specialized to positive costs and a common discount. Salizzoni, Ouhamma, and Kamgarpour [R2] give a polynomial characterization and the three-equilibrium upper bound for two players. Neither representation nor that small-player bound is presented here as new.

Cavalagli, Bemporad, and Zanon [R3] study the discounted $N$-player model. Their symmetric multiplicity analysis uses a root-structure assumption: Assumption 4.2 in the institutional postprint, corresponding to Assumption 1 in the journal version. Our normalized-derivative argument supplies an all-$N$ shape theorem and counts distinct profiles at the exceptional parameter values. Their revised two-player paper, arXiv:2603.13122v3 [R4], already studies local simultaneous-best-response behavior and symmetric two-player formulas. Our general spectral formulas must be read as all-player extensions, not as the first local two-player analysis.

The author-hosted manuscript [R7] already uses an aggregate coordinate for general $N,p$, describes a stationary polynomial of degree at most four, and studies the exact three-player threshold. We attribute those methods and that threshold accordingly. Its explicit discussion of converse enumeration and two-root structure motivates the complete branch analysis here. A minimum-level criterion and a count of distinct feedback vectors are different objects at a double root or a coalescence; our counting conventions are stated explicitly, without inferring an error in another result from that difference alone.

The principal learning comparison is Salizzoni and Kamgarpour [R5], whose institutional record confirms a two-agent scalar gradient-convergence result. We do not claim the first scalar LQ learning-convergence theorem. The full text of [R5] was not obtainable in this research session, so we cannot certify the absence there of a related potential argument. Hosseinirad et al. [R6] study finite-horizon exact-potential structure; that setting and notion differ from the infinite-horizon stationary-policy ordinal potential used here. Substantive publisher-indexed portions of [R6], but not its full PDF, were available.

The contribution established below is a unified arbitrary-$N$, arbitrary-positive-heterogeneity, full-domain convergence argument for several explicitly distinguished learning rules, with quantitative residual certificates, a complete all-parameter symmetric landscape, and a sharp heterogeneous attractor theorem including its degenerate boundaries. Engwerda's continuous-time branch analysis [R8, R9] and a different-model global learning result of Plank and Zhang [R10] are compared explicitly in Section 9. Search and access limitations prevent an exhaustive priority assertion. Formalization and computational verification are separate deliverables; no claim of full kernel verification follows merely from this manuscript.

# 2. Exact best responses, a proper potential, and finite equilibrium sets

We first establish the common structure used by every learning theorem.

**Theorem T1 (global scalar structure).** For every parameter tuple in Section 1, each unilateral finite-cost problem has a unique smooth exact best response. The function

$$
Q(k)=\frac{\prod_i f_i(k_i)}{D(k)}
\tag{2.1}
$$

is an ordinal potential for the original value coefficients, and $P=\log Q$ is an exact potential for their logarithms. Every sublevel of $Q$ is a compact subset of $\mathcal D$. The set of FNE is nonempty and finite, including repeated-cost and degenerate parameter values. Moreover, exact one-coordinate updates satisfy the square identity and uniform decrease bound (2.6) below.

## 2.1. Coordinate optimization

Fix player $i$ and opponents, and put $s=a+\sum_{j\ne i}k_j$. The coordinate problem is

$$
j_i(z;s)=\frac{\sigma_i+z^2}{1-\gamma(s+z)^2},\qquad
z\in I_s=(-s-\gamma^{-1/2},-s+\gamma^{-1/2}).
$$

For $q=\sqrt\gamma(s+z)$, $\theta=\sqrt\gamma s$, define

$$
A_s=\frac{(1-\theta)^2+\gamma\sigma_i}{2},\qquad
B_s=\frac{(1+\theta)^2+\gamma\sigma_i}{2}.
$$

Both coefficients are positive, and direct combination of fractions gives

$$
j_i(z;s)=\gamma^{-1}\left(\frac{A_s}{1-q}+\frac{B_s}{1+q}-1\right).
$$

The value tends to infinity at both endpoints of $I_s$. Differentiating twice gives

$$
\partial_z^2j_i(z;s)
=2\left(\frac{A_s}{(1-q)^3}+\frac{B_s}{(1+q)^3}\right)
\ge2\gamma\sigma_i>0.
\tag{2.2}
$$

The inequality uses $A_s,B_s\ge\gamma\sigma_i/2$ and
$(1-q)^{-3}+(1+q)^{-3}\ge2$. The coordinate problem therefore has exactly one minimizer, lying in its interior.

For an explicit formula, let

$$
A_i(s)=1+\gamma\sigma_i+\gamma s^2,\qquad
\Delta_i(s)=A_i(s)^2-4\gamma s^2.
$$

Since $A_i(s)>2\sqrt\gamma|s|$, the discriminant and the following denominator are strictly positive. The unique best response is

$$
b_i(s)=\frac{2s}{A_i(s)+\sqrt{\Delta_i(s)}}-s.
\tag{2.3}
$$

To verify it, write $u=s+b_i(s)$. The first-order condition is equivalent to
$\gamma s u^2-A_i(s)u+s=0$. Formula (2.3) satisfies this equation, including $s=0$, and $|u|<\gamma^{-1/2}$ follows from its denominator. Uniqueness proves the claim. The formula also shows that $b_i$ is smooth on the whole real line.

At any feasible profile, coordinate stationarity is

$$
k_iD(k)+\gamma r(k)f_i(k_i)=0.
\tag{2.4}
$$

By strict coordinate convexity, these equations characterize FNE exactly.

## 2.2. Exact improvement and compactness

Fix $s$, let $b=b_i(s)$, $v=j_i(b;s)$, and $D_s(z)=1-\gamma(s+z)^2$. The quadratic polynomial
$\sigma_i+z^2-vD_s(z)$ vanishes at $b$ together with its derivative. Its leading coefficient is $1+\gamma v$. Hence

$$
j_i(z;s)-j_i(b;s)
=\frac{1+\gamma v}{D_s(z)}(z-b)^2.
\tag{2.5}
$$

For a unilateral update, $C_{-i}(k)=\prod_{j\ne i}f_j(k_j)$ is fixed and positive. Therefore $\Delta Q=C_{-i}\Delta J_i$, and $\Delta P=\Delta\log J_i$. This proves the stated potential properties. The factor $C_{-i}$ depends on the opponents, so the original costs should not be called an exact-potential game on this basis.

Let

$$
S=\prod_i\sigma_i,\qquad
c_* =\min_i\frac{S}{\sigma_i}(1+\gamma\sigma_i)
=S\left(\gamma+\frac1{\sigma_{\max}}\right)>0.
$$

If $T_i k$ replaces coordinate $i$ by (2.3), then $T_i k\in\mathcal D$, and (2.5) gives

$$
Q(k)-Q(T_i k)
=\frac{C_{-i}(k)[1+\gamma J_i(T_i k)]}{D(k)}
   |(T_i k)_i-k_i|^2
\ge c_*\|T_i k-k\|^2.
\tag{2.6}
$$

Here $D(k)\le1$, $J_i(T_i k)\ge\sigma_i$, and $C_{-i}\ge S/\sigma_i$. All denominators are positive. The weaker constant $\gamma S$ is also valid, but we retain $c_*$.

For any nonempty sublevel $K_M=\{k\in\mathcal D:Q(k)\le M\}$, we have $Q\ge S$ and

$$
D(k)\ge\frac{S}{M}>0,\qquad
f_i(k_i)\le\frac{M\sigma_i}{S}.
\tag{2.7}
$$

These inequalities bound every coordinate, including directions with cancellation in their sum, and separate the sublevel from the boundary of $\mathcal D$. A convergent sequence in $K_M$ has a limit satisfying the same strict-domain lower bound; continuity then preserves $Q\le M$. Thus $K_M$ is compact in the ambient Euclidean space and is contained in $\mathcal D$.

A finite-cost profile exists, for example by choosing one player to make $r=0$. Minimize $Q$ on its nonempty compact sublevel. An improving unilateral deviation at a minimizer would decrease $Q$, contradicting minimality. This proves equilibrium existence.

## 2.3. A finite set at every parameter value

If $r=0$ at a stationary profile, (2.4) gives all $k_i=0$, hence $a=0$. If $r>0$, every $k_i<0$ and $a=r-\sum_i k_i>0$. The opposite signs hold when $r<0$. It follows that $a=0$ has only the zero equilibrium, while a nonzero $a$ and its equilibrium closed loop have the same sign.

Reflection reduces the remaining argument to $a>0$. Put

$$
z=\frac{1-\gamma r^2}{2\gamma r}>0.
$$

Equation (2.4) is equivalent to

$$
k_i=-z-\varepsilon_i\sqrt{z^2-\sigma_i},\qquad
\varepsilon_i\in\{-1,1\},\qquad
z\ge z_0:=\sqrt{\max_i\sigma_i}.
$$

The closed loop is $r=\sqrt{z^2+\gamma^{-1}}-z$, and its aggregate equation is

$$
a=(N-1)z+\sqrt{z^2+\gamma^{-1}}
       +\sum_i\varepsilon_i\sqrt{z^2-\sigma_i}.
\tag{2.8}
$$

Conversely, every solution with the stated joint domain reconstructs an FNE. Each policy is real and negative; $r$ is positive and strictly below $\gamma^{-1/2}$; and (2.4) holds. Cancellation of aggregate radicals cannot enlarge this joint domain. Formula (2.8) is attributable background from [R1, R3].

For completeness, finiteness follows by a direct algebraic certificate that does not assume generic parameters. Introduce formal independent variables $Y_0,\ldots,Y_N$, and multiply

$$
\prod_{\eta\in\{-1,1\},\,\varepsilon\in\{-1,1\}^N}
\left((N-1)Z-a+\eta Y_0+\sum_i\varepsilon_iY_i\right).
$$

This polynomial is invariant under each individual sign reversal $Y_i\mapsto-Y_i$. Every monomial therefore has even degree in every $Y_i$. Substitute
$Y_0^2=Z^2+\gamma^{-1}$ and $Y_i^2=Z^2-\sigma_i$. The result is a real polynomial $H(Z)$, including when some costs coincide.

It is not identically zero. At sufficiently large positive $z$, each real conjugate factor has expansion

$$
\left(N-1+\eta+\sum_i\varepsilon_i\right)z-a+O(z^{-1}).
$$

A nonzero linear coefficient makes the factor eventually nonzero. A zero coefficient makes it tend to $-a\ne0$. Their finite product is eventually nonzero. Every solution of (2.8) is a real root of $H$; hence there are finitely many possible $z$ and finitely many policy profiles. Repeated polynomial roots and coincident branch labels do not change that conclusion. The degree bound $\deg H\le2^{N+1}$ is merely a convenient finite bound, not a sharp heterogeneous equilibrium-count claim. This completes the proof of T1.

# 3. Global learning with explicit residual certificates

Write

$$
R_i(k)=b_i\left(a+\sum_{j\ne i}k_j\right)-k_i,
\qquad G_i(k)=\partial_{k_i}J_i(k).
$$

Both vanish simultaneously exactly at FNE. Fix $k^0\in\mathcal D$ and $M=Q(k^0)$. All constants below are finite for the stated positive-cost parameters.

## 3.1. Sequential activation with bounded gaps

**Theorem T2 (deterministic full-sequence convergence).** Let $i_t$ be any activation sequence for which every player appears in every $B$ consecutive activations, for some finite integer $B$. Update only player $i_t$ to its exact best response. Then the entire sequence converges to one FNE. With

$$
L_i=\sqrt{1+\frac1{\gamma\sigma_i}},\qquad
\Lambda=\sum_i L_i^2,
$$

the following explicit bound holds for every integer $T\ge1$:

$$
\min_{0\le t<T}\|R(k^t)\|^2
\le \frac{B^2\Lambda(M-S)}{c_*T}.
\tag{3.1}
$$

A fixed cyclic order is the case $B=N$. Bound (3.1) concerns a best residual among the first $T$ profiles, not a last-iterate distance to a chosen equilibrium.

**Proof.** By (2.6), all iterates stay in $K_M$ and

$$
\sum_{t=0}^{\infty}\|k^{t+1}-k^t\|^2
\le\frac{M-S}{c_*}.
\tag{3.2}
$$

Thus each step tends to zero. If $k^{t_\ell}\to\bar k$, each player $j$ updates at some $u_\ell\in[t_\ell,t_\ell+B-1]$. At most $B$ vanishing steps separate those profiles, so both $k^{u_\ell}$ and $k^{u_\ell+1}$ tend to $\bar k$. Continuity of $b_j$ makes $R_j(\bar k)=0$. Every cluster point is an FNE.

There are finitely many FNE by T1. Choose disjoint small balls around that finite set. Eventually every iterate lies in their union, since otherwise compactness would supply a non-FNE cluster point. Eventually the step lengths are shorter than the positive separation between the balls. The sequence can then never change balls. Repeating with smaller radii proves convergence to a single FNE. This supplies the full-sequence step that does not follow from square summability alone.

To prove the residual estimate, first bound the scalar best-response derivative. At its optimum let $u=s+b_i(s)$. When $s\ne0$, stationarity gives opposite signs for $u$ and $b_i(s)$ and

$$
\frac{1-\gamma u^2}{\gamma|u|}
=|b_i(s)|+\frac{\sigma_i}{|b_i(s)|}\ge2\sqrt{\sigma_i}.
$$

Hence $|u|\le U_i=\sqrt{\sigma_i+\gamma^{-1}}-\sqrt{\sigma_i}$. Implicit differentiation of the coordinate first-order equation gives

$$
|b_i'(s)|
=\frac{|b_i(s)|(1+\gamma u^2)}
 {(1-\gamma u^2)(|u|+|b_i(s)|)}
\le\frac{1+\gamma U_i^2}{1-\gamma U_i^2}
=L_i.
$$

At $s=0$ the derivative is $-\gamma\sigma_i/(1+\gamma\sigma_i)$, and the same bound holds. Thus $b_i$ is globally $L_i$-Lipschitz.

Let $d_v=\|k^{v+1}-k^v\|$, and let $u$ be the first activation of player $i$ at or after $t$. It is at most $t+B-1$. Before that activation coordinate $i$ does not change. The Lipschitz estimate therefore gives

$$
|R_i(k^t)|\le d_u+L_i\sum_{v=t}^{u-1}d_v
\le L_i\sum_{v=t}^{t+B-1}d_v.
$$

By Cauchy--Schwarz and summing in $i$,

$$
\|R(k^t)\|^2\le B\Lambda\sum_{v=t}^{t+B-1}d_v^2.
$$

When this is summed for $0\le t<T$, each squared step is counted at most $B$ times. Applying (3.2) proves (3.1). The constants are conservative; no optimal dependence on $N$ or $B$ is asserted. $\square$

## 3.2. Independent random activation

**Theorem T3 (almost-sure convergence and expected residual).** Suppose at each step exactly one player is drawn independently with probabilities $p_i>0$. The sequential exact-best-response iterates converge almost surely to an FNE. If $p_{\min}=\min_i p_i$, then

$$
\min_{0\le t<T}\mathbb E\|R(k^t)\|^2
\le\frac{M-S}{c_*p_{\min}T}.
\tag{3.3}
$$

**Proof.** Let $\mathcal F_t$ contain the history up to $k^t$. Conditional on it, (2.6) implies

$$
\mathbb E[Q(k^t)-Q(k^{t+1})\mid\mathcal F_t]
\ge c_*\sum_i p_iR_i(k^t)^2
\ge c_*p_{\min}\|R(k^t)\|^2.
$$

Take expectations, telescope, and use $Q\ge S$. This proves (3.3) and, on letting $T\to\infty$, gives

$$
\mathbb E\sum_{t=0}^{\infty}\|R(k^t)\|^2
\le\frac{M-S}{c_*p_{\min}}<\infty.
$$

The nonnegative series is finite almost surely. On that probability-one event all residuals tend to zero, all cluster points in $K_M$ are FNE, and the actual one-coordinate steps tend to zero. The finite-cluster argument used in T2 proves almost-sure full-sequence convergence. The bound is a minimum of expectations; it is not a last-iterate guarantee. $\square$

The proof also applies to history-dependent activation whose conditional probabilities are uniformly bounded below by a positive constant. The stated theorem needs only independent activation. Deterministic activation merely infinitely often, with no bounded gaps, is not asserted by T2.

## 3.3. Continuous raw gradients and continuous best responses

**Theorem T4 (global continuous trajectories).** Let $\lambda_i>0$ be fixed. Each of the following two systems has a unique solution for every $t\ge0$ from every $k^0\in\mathcal D$, remains in $K_M$, and converges as a full trajectory to one FNE:

$$
\dot k_i=-\lambda_iG_i(k)
\quad\text{and}\quad
\dot k_i=\lambda_iR_i(k).
\tag{3.4}
$$

The first includes raw simultaneous policy-gradient flow; the second is continuous best-response relaxation. Set

$$
c_G=\min_i\lambda_iS/\sigma_i,\qquad
\lambda_{\min}=\min_i\lambda_i.
$$

For every $T>0$, the gradient flow satisfies

$$
\min_{0\le t\le T}\|G(k(t))\|^2\le\frac{M-S}{c_GT},\qquad
\min_{0\le t\le T}\|R(k(t))\|^2
\le\frac{M-S}{4\gamma^2\sigma_{\min}^2c_GT}.
\tag{3.5}
$$

For continuous best-response relaxation,

$$
\min_{0\le t\le T}\|R(k(t))\|^2
\le\frac{M-S}{2\gamma S\lambda_{\min}T}.
\tag{3.6}
$$

**Proof.** Coordinate differentiation of $Q=C_{-i}J_i$ gives $\partial_iQ=C_{-i}G_i$. Along the raw-gradient flow,

$$
\dot Q=-\sum_i\lambda_iC_{-i}G_i^2
\le-c_G\|G\|^2.
\tag{3.7}
$$

Along the best-response flow, strong coordinate convexity (2.2) and the zero derivative at the best response give
$G_i(k)(k_i-b_i)\ge2\gamma\sigma_i|R_i(k)|^2$. Thus

$$
\dot Q=\sum_i\lambda_i C_{-i}G_iR_i
\le-2\gamma S\lambda_{\min}\|R\|^2.
\tag{3.8}
$$

Both vector fields are smooth on $\mathcal D$. A local solution cannot leave $K_M$, by the appropriate decrease identity. That compact set is uniformly separated from the domain boundary. The vector field is bounded and Lipschitz on a neighborhood of it, so a solution approaching a finite maximal time has a limit there and can be extended by local existence. Hence the maximal time is infinite.

Integrating (3.7) or (3.8) bounds the integral of the corresponding squared residual. On $K_M$, the residual, its derivative, and the vector field are bounded. Its squared norm along a trajectory consequently has bounded derivative and is uniformly continuous. A nonnegative uniformly continuous function with finite integral tends to zero: otherwise fixed-height peaks would have uniformly positive widths and force an infinite integral. Thus the relevant residual tends to zero. Coordinate strict convexity identifies its zeros with FNE.

The omega-limit set is nonempty and compact. It is connected because it is the intersection of the nested compact connected closures of continuous tail trajectories. It is contained in the finite FNE set, and hence consists of one point. Compactness then implies convergence of the entire trajectory to that point.

Time averaging proves the first inequality in (3.5) and (3.6). Finally (2.2), integrated between $k_i$ and its best response, gives $|G_i(k)|\ge2\gamma\sigma_i|R_i(k)|$. The second inequality in (3.5) follows. $\square$

These theorems do not claim convergence to a social optimum, equal attraction basins, a sharp global rate to a specific equilibrium, or convergence of arbitrary fixed-step discrete gradient descent. Degenerate equilibria are included in the convergence statements because finiteness, rather than hyperbolicity, closes the argument.

# 4. Complete symmetric equilibrium geometry

Assume from now on $N\ge2$ and $\sigma_i=\sigma>0$. Negative $a$ is handled by negating every policy, and $a=0$ has the unique zero equilibrium. We therefore use $a>0$ and write

$$
c=\frac1{\gamma\sigma},\qquad A=\frac{a}{\sqrt\sigma},\qquad
A_0=N-1+\sqrt{1+c}.
$$

For $t\ge0$ define

$$
H(t)=\sqrt\sigma e^t,\quad L(t)=\sqrt\sigma e^{-t},\quad
r(t)=\sqrt{\sigma\cosh^2t+\gamma^{-1}}-\sqrt\sigma\cosh t,
$$

and, for $0\le m\le N$,

$$
F_m(t)=(N-1)\cosh t+\sqrt{\cosh^2t+c}+(2m-N)\sinh t.
\tag{4.1}
$$

**Theorem T5 (complete symmetric enumeration).** All FNE are obtained by solving $A=F_m(t)$ and assigning $m$ players policy $-H(t)$ and the others policy $-L(t)$. For $1\le m<N/2$, there is a unique strict minimum at $t_m>0$; let $A_m=F_m(t_m)$. These thresholds satisfy

$$
0<A_1<\cdots<A_{\lfloor(N-1)/2\rfloor}<A_0.
$$

The number of distinct feedback vectors is

$$
\begin{cases}
1+\displaystyle\sum_{m=1}^{\lfloor(N-1)/2\rfloor}
\binom Nm\bigl(\mathbf1_{\{A=A_m\}}+2\mathbf1_{\{A>A_m\}}\bigr),
&0<A<A_0,\\[3pt]
1+\displaystyle\sum_{m=1}^{\lfloor(N-1)/2\rfloor}\binom Nm,
&A=A_0,\\[3pt]
2^N-1,&A>A_0.
\end{cases}
\tag{4.2}
$$

Empty sums are zero. In particular, for $N=2$ the count is one through $A=A_0$ and three above it. For odd $N\ge3$, the maximal count $2^N-1$ holds exactly on $A_{(N-1)/2}<A<A_0$ and $A>A_0$; both exceptional endpoints are excluded. For even $N$ it holds exactly when $A>A_0$.

**Proof.** In (2.8) set $z=\sqrt\sigma\cosh t$. The two quadratic roots become $-H(t)$ and $-L(t)$. Their aggregate equation is (4.1). Conversely the reconstruction in T1 proves every resulting profile is an FNE. The equivalent identity

$$
\sqrt\sigma F_m(t)=r(t)+mH(t)+(N-m)L(t)
\tag{4.3}
$$

shows all branch values are positive.

The shape follows from a single derivative calculation:

$$
\frac{F_m'(t)}{\cosh t}=G(t)+2m-N,
\quad
G(t)=(N-1)\tanh t+\frac{\sinh t}{\sqrt{\cosh^2t+c}},
$$

$$
G'(t)=\frac{N-1}{\cosh^2t}
+\frac{(1+c)\cosh t}{(\cosh^2t+c)^{3/2}}>0,
\quad G(0)=0,\quad\lim_{t\to\infty}G(t)=N.
\tag{4.4}
$$

Thus $F_0$ strictly decreases from $A_0$ to zero, and $F_N$ strictly increases from $A_0$ to infinity. They form the two halves of one unique symmetric equilibrium. For $1\le m<N/2$, equation $G(t)=N-2m$ has one positive solution $t_m$. The branch strictly decreases before it and strictly increases after it, with
$F_m''(t_m)=\cosh(t_m)G'(t_m)>0$. For $N/2\le m\le N-1$, the branch strictly increases on $(0,\infty)$. At even $N$ and $m=N/2$, only its endpoint derivative is zero.

All mixed branches tend to infinity, by (4.3). The minima lie below $A_0$. Whenever both indices exist,
$F_{m+1}(t)=F_m(t)+2\sinh t$. Evaluating at $t_{m+1}>0$ gives
$A_{m+1}>F_m(t_{m+1})\ge A_m$, proving their strict order.

For $t>0$, the high and low values are distinct. Every mixed root then yields exactly $\binom Nm$ profiles, and different $t,m$ or high-player subsets cannot yield the same vector. At $t=0$, every branch label represents the single symmetric vector $(-\sqrt\sigma,\ldots,-\sqrt\sigma)$. Below $A_0$, each mixed branch with $m<N/2$ has zero, one, or two positive roots according as $A$ is below, at, or above its minimum. At $A_0$ it has one positive root in addition to the common endpoint; all other mixed labels have only that endpoint. Above $A_0$, every mixed branch has one positive root. This proves (4.2). Summing binomial coefficients gives the final maximal-count assertions. $\square$

The proof resolves distinct-profile counts at folds and coalescence; roots with algebraic multiplicity would give different quantities. The large-parameter count itself is already known from [R1].

For computation, put $y=\tanh t_m$, $n=N-1$, and $b=N-2m$. The critical equation is

$$
ny+\frac{y}{\sqrt{1+c(1-y^2)}}=b,
\qquad 0<y<b/n<1.
$$

Equivalently, it is the unique admissible root of

$$
(b-ny)^2(1+c-cy^2)-y^2=0,
\tag{4.5}
$$

with the displayed interval and positive unsquared right-hand condition. Monotonicity supplies certified isolation. Aggregate coordinates and a general quartic stationarity reduction already appear in [R7]; (4.5) is a computational consequence of the shape theorem, not an independent novelty claim.

# 5. Exact physical-stability filtering

The learning theorems operate on finite discounted cost. We now count exactly which symmetric equilibria also stabilize the original plant.

**Theorem T6 (all stability boundaries).** Let

$$
C=\frac{\gamma^{-1}-1}{2\sqrt\sigma},\qquad
\tau=\operatorname{arcosh}(\max\{1,C\}).
$$

A branch equilibrium is plant stable exactly when $\cosh t>C$. If $C<1$, every finite-cost equilibrium is plant stable. If $C=1$, precisely the common $t=0$ profile is excluded. If $C>1$, precisely the roots with $t>\tau$ are stable.

More explicitly, for $1\le m<N/2$ define

$$
\begin{aligned}
R_m^{\mathrm{st}}(A)={}&
\mathbf1_{\{\tau<t_m,\ A_m<A<F_m(\tau)\}}\\
&+\mathbf1_{\{\tau<t_m,\ A=A_m\}}\\
&+\mathbf1_{\{A>F_m(\max\{\tau,t_m\})\}}.
\end{aligned}
\tag{5.1}
$$

For $N/2\le m\le N-1$, set
$R_m^{\mathrm{st}}(A)=\mathbf1_{\{A>F_m(\tau)\}}$.
The exact number of plant-stable mixed profiles is

$$
\sum_{m=1}^{N-1}\binom Nm R_m^{\mathrm{st}}(A).
\tag{5.2}
$$

Add the unique symmetric equilibrium whenever $C<1$. For $C\ge1$, add it exactly when

$$
0<A<F_0(\tau)\quad\text{or}\quad A>F_N(\tau).
\tag{5.3}
$$

For $a=0$, the unique zero equilibrium is always plant stable.

**Proof.** The positive closed loop solves $r^2+2\sqrt\sigma\cosh(t)r=\gamma^{-1}$. As its left-hand side is strictly increasing for $r\ge0$, $r<1$ is equivalent to $1+2\sqrt\sigma\cosh t>\gamma^{-1}$. This proves the root test.

Mixed profiles have $t>0$. Their stable domain is therefore $t>\tau$, including when $C<1$ and $\tau=0$. For a branch with a positive minimum, its decreasing interval contributes one stable root exactly when $\tau<t_m$ and $A_m<A<F_m(\tau)$. Its minimum contributes once exactly when $\tau<t_m$ and $A=A_m$. Its increasing open interval after $\max\{\tau,t_m\}$ contributes once exactly when $A>F_m(\max\{\tau,t_m\})$. These are (5.1). A monotone mixed branch contributes once exactly when $A>F_m(\tau)$. The strict inequalities exclude both marginal $r=1$ roots and the common endpoint from the mixed count.

The symmetric equilibrium is on $F_0$ below $A_0$, on $F_N$ above it, and at $t=0$ at equality. Their strict monotonicities give (5.3), with the stated automatic-stability exception when $C<1$. $\square$

For $C\ge1$, the stability boundaries can also be written using the two positive roots $H_\tau,L_\tau$ of

$$
x^2-(\gamma^{-1}-1)x+\sigma=0.
$$

Since the boundary closed loop is one, the branch-$m$ boundary is
$a=1+mH_\tau+(N-m)L_\tau$. Repeated roots at $C=1$ are included. These explicit thresholds show why global convergence to a finite-cost FNE need not imply convergence to a plant-stabilizing controller.

# 6. The potential landscape and all degenerate boundaries

The function $P=\log Q$ has exactly the same local minima as $Q$. Its Hessian on the entire feasible strip is

$$
\nabla^2P=\operatorname{diag}(\alpha_i)+\beta\mathbf1\mathbf1^T,
\quad
\alpha_i=\frac{2(\sigma_i-k_i^2)}{(\sigma_i+k_i^2)^2},
\quad
\beta=\frac{2\gamma(1+\gamma r^2)}{(1-\gamma r^2)^2}>0.
\tag{6.1}
$$

At a FNE each diagonal Hessian entry is positive, since it is $\partial_i^2J_i/J_i$ there and (2.2) applies.

**Theorem T7 (complete symmetric landscape).** For $t>0$, a mixed branch with $m$ high-control players has exactly

$$
m-1+\mathbf1_{\{F_m'(t)<0\}}
\tag{6.2}
$$

negative Hessian eigenvalues when $F_m'(t)\ne0$. At a fold it has $m-1$ negative eigenvalues, one zero eigenvalue, and all other eigenvalues positive. The only nondegenerate mixed local minima are the $m=1$ increasing-branch equilibria. The all-low symmetric equilibrium is a strict local minimum; the all-high symmetric equilibrium has $N-1$ negative directions.

Every positive-$t$ fold fails to be a local minimum. At the common endpoint $a_0=\sqrt\sigma A_0$, the symmetric profile fails to be a local minimum when $N\ge3$, but is a strict global minimum when $N=2$.

For $N\ge3$, let $a_1=\sqrt\sigma A_1$. The exact number of local potential minima is

$$
\begin{cases}
1,&0\le |a|\le a_1,\\
N+1,&a_1<|a|<a_0,\\
N,&|a|\ge a_0.
\end{cases}
\tag{6.3}
$$

For $N=2$ it is one for $|a|\le a_0$ and two above $a_0$. These are finite-cost learning-landscape counts; plant stability must separately be checked by T6.

## 6.1. Inertia from the response matrix

Let $\mathcal B(k)$ denote the simultaneous vector of coordinate best responses, and $M_B$ its Jacobian at a FNE. Differentiating the first-order condition $\partial_iP=0$ along a best response gives

$$
M_B-I=-D_H^{-1}\nabla^2P,
\qquad D_H=\operatorname{diag}((\nabla^2P)_{ii})>0.
\tag{6.4}
$$

The matrix on the right is similar to a symmetric matrix congruent to $-\nabla^2P$. Thus the continuous response linearization has the opposite inertia to the Hessian.

For $a>0$ set

$$
s_i=\frac{(-k_i)(1+\gamma r^2)}{(1-\gamma r^2)(r-k_i)}>0.
$$

Direct implicit differentiation of the coordinate optimality equation gives zero diagonal and off-diagonal entries $-s_i$ in $M_B$. Therefore

$$
M_B=\operatorname{diag}(s)-s\mathbf1^T
\sim \operatorname{diag}(s)-\sqrt s\sqrt s^T.
\tag{6.5}
$$

For a symmetric mixed profile write $l=N-m$ and

$$
s_H=\frac{H(1+\gamma r^2)}{(1-\gamma r^2)(r+H)},\qquad
s_L=\frac{L(1+\gamma r^2)}{(1-\gamma r^2)(r+L)}.
$$

The identity $H+L=(1-\gamma r^2)/(\gamma r)$ yields

$$
1-s_H=\frac{r(L-H)}{(H+L)(r+H)}<0,\qquad
1-s_L=\frac{r(H-L)}{(H+L)(r+L)}>0.
$$

Thus $s_H>1$ and $0<s_L<1$. The eigenvalues of $M_B$ are $s_H$ with multiplicity $m-1$, $s_L$ with multiplicity $l-1$, and the eigenvalues of

$$
\begin{pmatrix}
-(m-1)s_H&-ls_H\\
-ms_L&-(l-1)s_L
\end{pmatrix}.
$$

The latter have opposite signs because their determinant is $-(N-1)s_Hs_L$. Put

$$
T_m=(m-1)s_H+(l-1)s_L,\qquad
\lambda_\pm=\frac{-T_m\pm\sqrt{T_m^2+4(N-1)s_Hs_L}}2.
\tag{6.6}
$$

In particular $\lambda_-<0<\lambda_+$. To locate $\lambda_+$ relative to one, set $S_t=r+(H+L)/2$. Direct differentiation of (4.3), using $r'= -r(H-L)/(2S_t)$, gives

$$
\frac{d}{dt}(\sqrt\sigma F_m)
=mH-lL-\frac{r(H-L)}{2S_t}.
$$

The determinant lemma, or direct substitution of the displayed formulas for $1-s_H$ and $1-s_L$, now yields

$$
(1-\lambda_+)(1-\lambda_-)
=\frac{2S_t r(H-L)}{(H+L)^2(r+H)(r+L)}
\frac{d}{dt}(\sqrt\sigma F_m).
\tag{6.7}
$$

For clarity, the determinant-lemma calculation uses

$$
1+\frac{m s_H}{1-s_H}+\frac{l s_L}{1-s_L}
=-\frac{2S_t}{r(H-L)}\frac{d}{dt}(\sqrt\sigma F_m),
$$

and multiplies by $(1-s_H)(1-s_L)$; the product equals the left side of (6.7). Every prefactor in (6.7) is positive. It follows that $\lambda_+<1$ on an increasing branch, $\lambda_+=1$ at a fold, and $\lambda_+>1$ on a decreasing branch. Equations (6.4)--(6.6) prove the stated inertia.

For a symmetric unmixed profile, the BR eigenvalues are $s$ with multiplicity $N-1$ and $-(N-1)s$ once. The all-low half has $s<1$, and the all-high half has $s>1$. This proves their inertia. At $a=0$, (6.1) is positive definite directly.

The rank-one Hessian has an additional heterogeneous implication: if two coordinates satisfy $|k_i|>\sqrt{\sigma_i}$, a perturbation supported on those two coordinates with sum zero has strictly negative Hessian quadratic form. Thus no local minimum can have two strictly high-control players even in the heterogeneous game. Threshold coordinates with equality require separate analysis and are not covered by that short argument.

## 6.2. The folds are not minima

Only the $m=1$ fold needs a higher-order argument, because folds with $m\ge2$ already have a negative direction. Fix a high-player subset and regard $k(t)$ and $a(t)=\sqrt\sigma F_m(t)$ as an equilibrium curve. Let $g(k,a)=\nabla_kP(k,a)$. Along this curve $g(k(t),a(t))=0$. At a fold, $a'=0$, so $\nabla_k^2P\,k'=0$.

Differentiate once more and take the inner product with $k'$. The Hessian term vanishes, as do all terms containing $a'$. Since $\partial_ag=\beta\mathbf1$, we obtain

$$
D_k^3P[k',k',k']=-\beta\left(\sum_i k_i'\right)a''.
\tag{6.8}
$$

At the fold $a''>0$ by (4.4). Also
$\sum_i k_i'=-mH+lL=-r(H-L)/(2S_t)<0$, using $a'=0$ in the derivative formula preceding (6.7). The cubic directional derivative (6.8) is therefore strictly positive. Along positive and negative small multiples of the nonzero kernel vector $k'$, the potential difference has opposite signs. The fold is not a local minimum. This conclusion uses the cubic term and cannot be inferred merely from a zero eigenvalue.

## 6.3. The complete coalescence and its two-player exception

Let $u=\sqrt\sigma$ and $k_*=(-u,\ldots,-u)$ at $a=a_0$. On the plane $\sum_i\delta_i=0$, the denominator is unchanged. For $f(x)=\log(\sigma+x^2)$,

$$
f''(-u)=0,\qquad f'''(-u)=u^{-3},\qquad f''''(-u)=3u^{-4}.
$$

When $N\ge3$, choose $\delta=(\varepsilon,\varepsilon,-2\varepsilon,0,\ldots,0)$. The linear term cancels, the quadratic term vanishes, and the cubic term in $P(k_*+\delta)-P(k_*)$ is $-\varepsilon^3/u^3$. Its sign reverses with $\varepsilon$. The merged profile is not a local minimum.

For $N=2$, vanishing of the cubic term on that plane is insufficient by itself, because transverse adjustments can change a quartic conclusion. We instead give an exact global certificate. Put

$$
r_0=\sqrt{\sigma+\gamma^{-1}}-u,\quad a_0=2u+r_0,\quad
D_0=1-\gamma r_0^2=2\gamma r_0u,\quad Q_*=4u^4/D_0,
$$

$$
v=(k_1+k_2+2u)/2,\qquad y=(k_1-k_2)/2,
\qquad D=1-\gamma(a_0+k_1+k_2)^2.
$$

Expanding both sides gives the polynomial identity

$$
D(Q-Q_*)=(v^2-y^2-2uv)^2+4u^2(1+2u/r_0)v^2.
\tag{6.9}
$$

Here $D>0$, $u>0$, and $r_0>0$. Equality forces $v=0$ and then $y=0$. Thus $k_*$ is the unique global minimizer on the entire feasible strip. It is a strict degenerate minimum with a singular Hessian.

## 6.4. Counting the minima and interpreting attraction

Every local minimum lies in the open domain and is stationary; T1 therefore makes it an FNE. For $N\ge3$, the unique symmetric equilibrium remains a minimum below $a_0$. At $a_1$ the new one-high folds are not minima, by (6.8). Above $a_1$ their increasing roots give $N$ strict minima. At $a_0$ the symmetric minimum is lost, while the positive-$t$ one-high increasing roots remain. All other mixed equilibria have a negative direction or a non-minimal fold. This proves (6.3). The two-player conclusion follows from (6.9) and the enumeration in T5.

At any nondegenerate minimum, continuous best-response flow is locally exponentially attracting by (6.4). For raw-gradient flow the linearization is also a negative positive-diagonal multiple of $\nabla^2P$, because $G_i=J_i\partial_iP$ and $\partial_iP=0$ at equilibrium. Thus it has the same inertia. This explains the generic attraction phases for both continuous flows. Their global convergence does not imply that exceptional initial conditions cannot converge to a saddle. No claim about basin volume or random selection probabilities is made. The undamped simultaneous discrete rule has a stricter stability test, treated next.

*Figure: Complete symmetric branches and exact counts for $N=5$, $\gamma=\sigma=1$. The fold thresholds are $A_1\approx4.3472905105$ and $A_2\approx5.3068598520$, while $A_0=4+\sqrt2\approx5.4142135624$. Dots mark counts at the exceptional parameter values; they are not limits from an adjacent interval. The attracting-equilibrium curve refers specifically to continuous best-response flow.*

# 7. Local simultaneous spectra, damping, and a global obstruction

**Theorem T8 (what simultaneous best responses can and cannot do).** At a symmetric mixed equilibrium with $t>0$, the simultaneous BR spectrum is given by (6.6) together with the repeated $s_H,s_L$ eigenvalues. Every mixed equilibrium with $m\ge2$ is unstable for simultaneous discrete BR. For $m=1$, local exponential stability holds exactly when

$$
s_L\bigl((N-2)+(N-1)s_H\bigr)<1.
\tag{7.1}
$$

The symmetric profile is locally exponentially stable exactly when $(N-1)s<1$. At $a=0$, the unique zero equilibrium has $s=\gamma\sigma/(1+\gamma\sigma)$, and its BR spectrum is again $s$ with multiplicity $N-1$ and $-(N-1)s$ once, as follows by differentiating (2.3) at $s=0$ in the opponents' scalar argument. More generally, for a BR Jacobian with real extreme eigenvalues $\lambda_{\min},\lambda_{\max}$, damped simultaneous updates
$k^+=(1-\alpha)k+\alpha\mathcal B(k)$ are locally exponentially stable exactly when

$$
\lambda_{\max}<1,\qquad 0<\alpha<\frac{2}{1-\lambda_{\min}}.
\tag{7.2}
$$

The condition applies to the positive-damping regime. Unit-modulus boundary cases are not classified by linearization alone. Finally, simultaneous exact BR can leave the finite-cost domain after one update, even from a plant-stable profile with undiscounted positive costs.

**Proof.** The spectral formulas were proved in Section 6. If $m\ge2$, the repeated eigenvalue $s_H>1$ is already unstable. If $m=1$, the two remaining eigenvalues have characteristic polynomial
$q(\lambda)=\lambda^2+(N-2)s_L\lambda-(N-1)s_Hs_L$. Since one root is negative and one positive, $\lambda_->-1$ is equivalent to
$q(-1)=1-(N-2)s_L-(N-1)s_Hs_L>0$. This condition also implies $q(1)>0$, hence $\lambda_+<1$. The repeated $s_L$ eigenvalues are inside the unit interval. This proves (7.1). The unmixed spectrum immediately proves its stated test.

A damped eigenvalue is $1-\alpha+\alpha\lambda$. Since all BR eigenvalues are real by (6.5), every damped eigenvalue lies strictly between minus one and one exactly under (7.2). If $\lambda_{\max}>1$, no positive damping can make the corresponding eigenvalue smaller than one. At equality it remains one. These are local statements and do not assert global feasibility of simultaneous steps.

For the obstruction, take $N=6$, $\gamma=1$, $\sigma_i=1$, $a=1/2$, and $k^0=0$. Initially $r=1/2$. Each player responding against the old profile chooses

$$
b=\frac{7-\sqrt{65}}4.
$$

This is the feasible root of its coordinate first-order quadratic. If all six update at once, the new closed loop is

$$
r^1=\frac12+6b=\frac{22-3\sqrt{65}}2<-1,
$$

because $\sqrt{65}>8$. Thus the next profile has infinite undiscounted cost. This does not conflict with T2--T4, whose update rules and feasibility arguments are different. $\square$

# 8. Consequences, limitations, and reproducibility scope

The global learning mechanism uses a scalar shared denominator, positive private numerator factors, exact one-coordinate minimization or continuous descent, and a finite equilibrium set. None of these ingredients supplies convexity of the joint game or uniqueness of its equilibrium. In the symmetric specialization, the distinction is concrete: as many as $2^N-1$ equilibrium profiles coexist, yet only $N+1$ or $N$ are local potential minima in the appropriate regions. The convergence proof handles the folds and coalescence without deleting them from its assumptions.

The strongest general conclusion is full-sequence or full-trajectory convergence to an equilibrium from every finite-cost initialization, not optimal equilibrium selection. The explicit residual inequalities give an auditable complexity certificate but do not resolve sharp iteration complexity, basin geometry, or convergence speed near a degenerate equilibrium. The all-player symmetric count is sharp; a sharp universal count of all FNE for fully heterogeneous costs is not asserted.

Strict positive state costs are substantive. They make the coordinate minimizers unique, keep potential sublevels away from the finite-cost boundary, and ensure the nonzero factors used in the proof. Extending the same statements to zero costs would require a new boundary analysis. Likewise, the proof does not extend by mere notation to matrix-state or unequal-discount games. Discounted finite-cost convergence remains distinct from physical stability; T6 is the exact symmetric filter needed for that interpretation.

The accompanying reproducibility package is intended to test explicit algebraic identities, reconstruct equilibria, compare branch counts against independent equations, and illustrate the named learning algorithms. Such finite computations are checks of their stated scope, not proofs of the universal theorems. Lean source coverage, compilation, axiom audit, and independent review are tracked separately in the case status and claim map. No uncompiled source is counted as formal verification in this manuscript.

The recorded numerical run checks 201 symmetric parameter cases and 816 representative equilibria, and runs 72 heterogeneous cyclic-learning instances with the recorded seed 20261125. The six representative traces in Figure 2 report the best-response residual after complete cyclic sweeps. They illustrate T2 but neither establish its universal quantifiers nor verify every schedule in T2--T4. Exact symbolic checks and floating-point checks are recorded separately in [results/verification.json](evidence/results/verification.json); points near a physical-stability boundary are explicitly treated as ambiguous by floating-point classification.

*Figure: Representative heterogeneous cyclic exact-best-response runs. The vertical coordinate is $\|R(k)\|_2$, not its square; the horizontal coordinate counts full sweeps, each containing $N$ individual activations. The dotted line is the prespecified numerical stopping tolerance $10^{-9}$. Potential descent does not require the plotted residual to decrease at every sweep.*

The closest prior-work comparisons are given in Section 1. In particular, the full-text unavailability of [R5] limits method-level novelty verification. The new argument is presented with explicit assumptions and complete proofs so that its overlap and incremental scope can be assessed without relying on a broad priority claim.

# 9. Sharp heterogeneous attractor bounds and complete degenerate classification

We now remove symmetry from the landscape analysis. The objective is the complete set of attracting equilibria, including degenerate ones, rather than a sharp count of all saddle equilibria. The branch-shape mechanism has an important antecedent: for scalar continuous-time regulator games, Engwerda [R9, Lemma 3.2] already gives a decreasing all-low branch and a highest-cost branch with at most a maximum and a minimum, which may merge. That paper attributes the underlying analysis to [R8]. The additional square root in our discrete-time equations requires its own verification. Neither square-root curvature comparisons nor the idea of using a few distinguished branches is claimed as a first here. The results below connect those shapes to the potential Hessian, resolve every degenerate minimum, and give a sharp bound and an exhaustive enumeration of all continuous-learning attractors in the present game.

## 9.1. Candidate branches and the classification theorem

In this section use the local notation

$$
c_\gamma=\gamma^{-1},\qquad
\mu=\max_i\sigma_i,\qquad \zeta=\sqrt\mu,\qquad
\rho(z)=\sqrt{z^2+c_\gamma}-z.
$$

By reflection assume $a>0$. At every equilibrium $z\ge\zeta$, and a coordinate is either low, $k_j=-z+\sqrt{z^2-\sigma_j}$, or high, $k_j=-z-\sqrt{z^2-\sigma_j}$. A high coordinate is **strictly high** when $z^2>\sigma_j$. Define

$$
\begin{aligned}
\Phi_0(z)&=(N-1)z+\sqrt{z^2+c_\gamma}
                   -\sum_j\sqrt{z^2-\sigma_j},\\
\Phi_i(z)&=\Phi_0(z)+2\sqrt{z^2-\sigma_i},\qquad 1\le i\le N,\\
a_c&=\Phi_0(\zeta).
\end{aligned}
\tag{9.1}
$$

Thus $\Phi_0=a$ describes all-low equilibria and $\Phi_i=a$ describes equilibria with player $i$ high and everyone else low. These $N+1$ labels suffice for every possible local minimum, although they do not enumerate all saddles.

**Theorem T9 (complete heterogeneous classification of attractors).** For arbitrary strictly positive costs, every local minimum of $P$ is strict. These minima are exactly the locally asymptotically stable equilibria of each continuous flow in T4, for every choice of positive gains. For $a>0$, the following list is exhaustive.

1. At $z>\zeta$, an all-low equilibrium has positive-definite Hessian. Any equilibrium with at least two strictly high coordinates is not a minimum. At a one-high root $\Phi_i(z)=a$, the classification is

| Condition at the root | Local potential structure |
| --- | --- |
| $\Phi_i'>0$ | Positive-definite Hessian; strict minimum |
| $\Phi_i'<0$ | Exactly one negative Hessian eigenvalue |
| $\Phi_i'=0$, $\Phi_i''\ne0$ | One-dimensional kernel and nonzero reduced cubic term; not a minimum |
| $\Phi_i'=\Phi_i''=0$ | $\Phi_i'''>0$ and a positive reduced quartic term; strict minimum |

2. At $z=\zeta$, any strictly high nonmaximal-cost coordinate rules out a minimum. Otherwise all nonmaximal-cost coordinates are low, the corresponding parameter is $a=a_c$, and only the multiplicity $q=\#\{i:\sigma_i=\mu\}$ remains to be considered. For $q=1$ the Hessian is positive definite; for $q\ge3$ the point is not a minimum. For $q=2$, relabel the two maximum costs as 1 and 2 and set

$$
\mathcal L(z)=(N-1)z+\sqrt{z^2+c_\gamma}
                   -\sum_{j=3}^N\sqrt{z^2-\sigma_j},\qquad
d=\mathcal L'(\zeta).
\tag{9.2}
$$

The endpoint is a strict minimum exactly when $d\ge0$. Its true reduced potential has order four when $d>0$ and order six when $d=0$; if $d<0$, it has a negative quartic term.

For $a=0$ the zero profile is the unique global minimum. For negative $a$, reflect the policies. The word endpoint here refers to a square-root parameter endpoint, not to the boundary $D=0$. The interior condition $\Phi_i'=\Phi_i''=0$ will be called a cusp condition; the classification does not require a claim about a universal multiparameter unfolding.

## 9.2. Branch shape with arbitrary positive costs

For $z>\zeta$,

$$
\Phi_0'(z)=N-1+\frac z{\sqrt{z^2+c_\gamma}}
                     -\sum_j\frac z{\sqrt{z^2-\sigma_j}}<0.
\tag{9.3}
$$

Each term in the sum exceeds one, whereas the positive fraction is below one. Moreover $\Phi_0$ is positive, has endpoint value $a_c$, and tends to zero at infinity. Hence it gives exactly one interior equilibrium for $0<a<a_c$, and none for $a\ge a_c$.

The one-high branches satisfy $\Phi_i(z)\to\infty$, $\Phi_i'(z)\to2$, and

$$
\Phi_i''(z)=\frac{c_\gamma}{(z^2+c_\gamma)^{3/2}}
-\frac{\sigma_i}{(z^2-\sigma_i)^{3/2}}
+\sum_{j\ne i}\frac{\sigma_j}{(z^2-\sigma_j)^{3/2}}.
\tag{9.4}
$$

For fixed $z$, the map $s\mapsto s/(z^2-s)^{3/2}$ is strictly increasing on $(0,z^2)$. If $i$ is not the unique maximum-cost player, some $j\ne i$ has $\sigma_j\ge\sigma_i$. Its term cancels or exceeds the negative term in (9.4), leaving the strictly positive first term. Thus $\Phi_i''>0$. Such a branch has at most one stationary point, necessarily a strict minimum, and at most one root on its increasing part.

Suppose instead that $i$ is the unique maximum-cost player. Divide (9.4) by $\mu/(z^2-\mu)^{3/2}$ and write

$$
\Psi(z)=-1+\frac{c_\gamma}{\mu}
\left(\frac{z^2-\mu}{z^2+c_\gamma}\right)^{3/2}
+\sum_{j\ne i}\frac{\sigma_j}{\mu}
\left(\frac{z^2-\mu}{z^2-\sigma_j}\right)^{3/2}.
\tag{9.5}
$$

Every nonconstant term is strictly increasing. Indeed, for $b> -\mu$,

$$
\frac d{dz}\left(\frac{z^2-\mu}{z^2+b}\right)^{3/2}
=\frac{3z(\mu+b)\sqrt{z^2-\mu}}{(z^2+b)^{5/2}}>0.
$$

We have $\Psi(\zeta+)=-1$ and
$\Psi(\infty)=(c_\gamma+\sum_{j\ne i}\sigma_j-\mu)/\mu$.
If this last value is nonpositive, $\Phi_i''<0$ everywhere and $\Phi_i'$ decreases from $+\infty$ to 2, remaining positive. If the last value is positive, $\Psi$ has exactly one zero $z_c$. Then $\Phi_i'$ strictly decreases up to $z_c$ and strictly increases afterwards. According as $\Phi_i'(z_c)$ is positive, zero, or negative, $\Phi_i$ is strictly increasing with no stationary point, is strictly increasing with one stationary inflection, or has two stationary points consisting of a maximum followed by a minimum. In the last case it has two increasing intervals separated by a decreasing interval.

At a zero of $\Phi_i''$, differentiation of its product representation yields

$$
\Phi_i'''(z_c)
=\frac{\mu}{(z_c^2-\mu)^{3/2}}\Psi'(z_c)>0.
\tag{9.6}
$$

Thus no higher interior degeneracy is omitted. This is the discrete-time extension of the relevant shape mechanism in [R8, R9].

## 9.3. Interior Hessian and genuine transverse reduction

Let $h_j(x)=\log(\sigma_j+x^2)$ and
$\varphi(r)=2\gamma r/(1-\gamma r^2)$, so $\varphi'(r)=\beta>0$.
On any fixed interior sign branch $k(z)$, let $K(z)=\sum_jk_j(z)$ and $\Phi(z)=\rho(z)-K(z)$. Differentiating the coordinate identities gives

$$
h_j'(k_j(z))=-\frac1z,\qquad
\alpha_jk_j'(z)=\frac1{z^2},\qquad
\beta\rho'(z)=-\frac1{z^2}.
$$

Consequently

$$
1+\beta\sum_j\alpha_j^{-1}
=1+\beta z^2K'(z)=-\beta z^2\Phi'(z).
\tag{9.7}
$$

All-low points have every $\alpha_j>0$, so their Hessian is positive definite. Two negative $\alpha_j$ give a negative quadratic form on a vector supported on those coordinates with sum zero, excluding every point with two strictly high players.

At a one-high point, the principal Hessian block on the low coordinates is positive definite. Eliminating it gives the scalar Schur complement

$$
S_i=\alpha_i+
\frac{\beta}{1+\beta\sum_{j\ne i}\alpha_j^{-1}}
=\frac{\alpha_i(1+\beta\sum_j\alpha_j^{-1})}
       {1+\beta\sum_{j\ne i}\alpha_j^{-1}}.
\tag{9.8}
$$

Since $\alpha_i<0$, equations (9.7)--(9.8) show that $S_i$ has the sign of $\Phi_i'$. This proves the nondegenerate classification and shows that a stationary root has a positive-semidefinite Hessian with a one-dimensional kernel.

At such a root $z_*$, $Hk'(z_*)=0$ and
$K'(z_*)=\rho'(z_*)=-1/(\beta z_*^2)<0$.
The kernel therefore is not contained in $\mathbf1^\perp$. The Hessian restricted to that zero-sum subspace is positive definite. On the subspace the rank-one term vanishes, so the same is true for the restriction of $\operatorname{diag}(\alpha_j)$.

Fix $a_* =\Phi_i(z_*)$ while varying policies. The map
$k=k(z)+\eta$, $\eta\in\mathbf1^\perp$, is an analytic local coordinate system because $K'(z_*)\ne0$. For fixed $z$, the denominator of $P$ is unchanged by $\eta$, and its first derivative in every such direction is $-z^{-1}\sum_j\eta_j=0$. Uniform positive definiteness in a sufficiently small neighborhood gives

$$
P(k(z)+\eta;a_*)\ge V(z)+\lambda\|\eta\|^2,
\qquad V(z)=P(k(z);a_*),\quad \lambda>0.
\tag{9.9}
$$

This eliminates all transverse variables: $k(z)$ is the local minimizing profile for its prescribed sum, so a positive reduced term really proves a full-space minimum.

Direct differentiation gives

$$
V'(z)=K'(z)[\varphi(a_*+K(z))-\varphi(\rho(z))]
      =A(z)[\Phi_i(z)-a_*],
\tag{9.10}
$$

where
$A(z)=-K'(z)\int_0^1\varphi'(\rho(z)+\theta[a_*-\Phi_i(z)])\,d\theta>0$
near $z_*$, and $A(z_*)=1/z_*^2$. Thus, with $u=z-z_*$, a simple stationary point has

$$
V(z)-V(z_*)=\frac{\Phi_i''(z_*)}{6z_*^2}u^3+O(u^4),
$$

whereas a cusp has

$$
V(z)-V(z_*)=\frac{\Phi_i'''(z_*)}{24z_*^2}u^4+O(u^5).
\tag{9.11}
$$

The cubic changes sign. The quartic is strictly positive by (9.6), and (9.9) controls all remaining directions. This proves the entire interior part of T9.

## 9.4. Repeated maximum costs and the sixth-order boundary

At $z=\zeta$, all maximum-cost coordinates equal $-\zeta$ and have $\alpha_j=0$. A strictly high nonmaximum coordinate has $\alpha_j<0$; pairing it with a maximum coordinate in a zero-sum perturbation gives a negative Hessian direction. Hence only the endpoint with all other coordinates low can be a minimum.

For that endpoint, if $q=1$, the quadratic form
$\sum_{\sigma_j<\mu}\alpha_j\xi_j^2+\beta(\sum_j\xi_j)^2$
is strictly positive on every nonzero vector. If $q\ge3$, the direction $(1,1,-2)$ supported on three maximum coordinates keeps the denominator fixed and gives
$P(k+u(1,1,-2))-P(k)=-u^3/\zeta^3+O(u^4)$.
It therefore is not a minimum.

It remains to treat $q=2$. This is a full transverse minimization, not an expansion with the other variables artificially fixed. Use coordinates

$$
k_1=-v+x,\quad k_2=-v-x,\quad k_j=y_j\ (j\ge3).
$$

At the endpoint, $x=0$, $v=\zeta$, and
$y_j=-\zeta+\sqrt{\mu-\sigma_j}$.
The Hessian in the transverse variables $(v,y)$ has quadratic form

$$
\sum_{j\ge3}\alpha_j(\delta y_j)^2
+\beta\left(-2\delta v+\sum_{j\ge3}\delta y_j\right)^2>0
$$

for every nonzero transverse vector. The analytic implicit-function theorem therefore gives a unique transverse minimizer $(v_*(x),y_*(x))$. Exchange of players 1 and 2 shows that it is even in $x$, hence analytic in $w=x^2$. On a neighborhood,

$$
P(x,v,y)\ge V(x)+\lambda\|(v,y)-(v_*(x),y_*(x))\|^2,
\quad \lambda>0.
\tag{9.12}
$$

We calculate that actual minimizing path explicitly. Define $z$ by $\varphi(r)=1/z$ on the path. The low-player stationarity equations and the sum constraint imply

$$
y_j(z)=-z+\sqrt{z^2-\sigma_j},\qquad
v(z)=z-\frac{\mathcal L(z)-a_c}{2}.
\tag{9.13}
$$

Let $W=\mu+v(z)^2-w$ and $B=W^2+4\mu w$. The transverse $v$ equation is exactly

$$
E(z,w):=W^2+4\mu w-2zv(z)W=0.
\tag{9.14}
$$

At $(z,w)=(\zeta,0)$, if $v$ is temporarily independent, the partial derivatives are $E_z=-4\zeta^3$, $E_v=0$, and $E_w=2\zeta^2$. Substituting $v=v(z)$ therefore leaves $E_z=-4\zeta^3\ne0$. It follows that

$$
z(w)=\zeta+\frac{w}{2\zeta}+O(w^2),
\tag{9.15}
$$

and $z(w)>\zeta$ for small positive $w$.

Envelope differentiation gives $V'(x)=4x(\mu-v^2+w)/B$. The exact polynomial identity

$$
B-2v^2W=(\mu-v^2+w)(W+2w)
$$

and (9.14) give

$$
V'(x)=
\frac{2x[\mathcal L(z(x^2))-a_c]}
 {z(x^2)[\mu+v(z(x^2))^2+x^2]}.
\tag{9.16}
$$

Its denominator is positive. Also

$$
\mathcal L''(z)=\frac{c_\gamma}{(z^2+c_\gamma)^{3/2}}
+\sum_{j\ge3}\frac{\sigma_j}{(z^2-\sigma_j)^{3/2}}>0.
\tag{9.17}
$$

Since $z(x^2)>\zeta$, the sign of $xV'(x)$ near zero is positive for $d=\mathcal L'(\zeta)\ge0$ and negative for $d<0$. Combining this with (9.12) proves the endpoint classification without relying solely on a truncated expansion. More precisely,

$$
V(x)-V(0)=
\begin{cases}
\displaystyle\frac{d}{8\mu^2}x^4+O(x^6),&d\ne0,\\[3pt]
\displaystyle\frac{\mathcal L''(\zeta)}{48\mu^{5/2}}x^6+O(x^8),&d=0.
\end{cases}
\tag{9.18}
$$

All minima in the classification are strict. For $a=0$, $Q(k)\ge\prod_j\sigma_j=Q(0)$, with equality only at zero. Reflection handles $a<0$.

Finally, strict minima are locally asymptotically stable for both flows in T4. Choose a small closed ball containing no other FNE. Strict minimality gives a positive potential gap on its boundary; a sufficiently small connected sublevel neighborhood cannot leave that ball because the potential decreases. T4 then forces every trajectory in it to converge to the sole FNE there. Conversely, if an equilibrium is not a local minimum, arbitrarily nearby profiles have smaller potential. Their nonincreasing potential prevents convergence to that equilibrium. This proves the claimed equivalence, including quartic and sixth-order minima, and completes T9.

## 9.5. A sharp bound and explicit strictly heterogeneous constructions

**Theorem T10 (sharp number and candidate reduction).** For $N\ge2$, over all parameters allowed in Section 1, the largest possible number of local minima, equivalently of locally asymptotically stable equilibria for either flow in T4, is

$$
\begin{cases}
2,&N=2,\\
N+1,&N\ge3.
\end{cases}
\tag{9.19}
$$

Every bound is attained with positive pairwise-distinct costs and $\gamma=1$. Thus the same bounds are sharp even if only physically stable attractors are counted. All minima can be enumerated using the $N+1$ branches (9.1), at most $N+2$ monotone candidate intervals, and the single possible endpoint profile with its T9 test. This is a bound on the number of scalar candidate problems, not a linear arithmetic or bit-complexity claim.

**Upper-bound proof.** Each nonexceptional one-high branch is strictly convex and has at most one interior minimum-bearing root. Only the unique maximum-cost player can have two such roots. Its first increasing interval starts at the value $a_c$ and lies strictly above that value. Consequently its early root cannot coexist with the all-low interior root, which requires $a<a_c$. At $a=a_c$, the endpoint replaces both possibilities. If the maximum branch instead has a stationary inflection, it is strictly increasing through that point and contributes only one root; the cusp must not be counted twice by splitting the increasing interval there. Thus the all-low/endpoint/early-maximum alternatives together contribute at most one, the late maximum branch at most one, and the other $N-1$ players at most one each. This gives $N+1$ when the largest cost is unique.

When the largest cost is repeated, every one-high branch is strictly convex. There are at most $N$ interior minimum-bearing roots plus one all-low or eligible endpoint profile, so the same upper bound holds. T9 excludes all ordinary folds and all other endpoints, and includes the degenerate minima, so no generic-parameter restriction is hidden in the count.

For $N=2$ with distinct costs, let $\sigma_i=\mu>\sigma_j$. Then

$$
\Phi_i'(z)=1+\frac z{\sqrt{z^2+c_\gamma}}
+\frac z{\sqrt{z^2-\mu}}-\frac z{\sqrt{z^2-\sigma_j}}>1.
$$

The maximum branch has only one increasing interval, and the all-low, endpoint, and maximum-branch alternatives contribute exactly one in total. The other branch contributes at most one, giving two. For equal costs, both one-high branches are $z+\sqrt{z^2+c_\gamma}$, strictly increasing from $a_c$; below or at $a_c$ only the all-low or endpoint minimum remains, and above it the two distinct one-high profiles give two. For $N=1$, strict coordinate convexity gives one. This proves all upper bounds.

**Sharpness for every $N\ge3$.** Take $\gamma=1$ and define

$$
h=\frac1{4N^2},\quad \bar z=1+h,\quad
\delta=\bar z^2-1,\quad A_0=N-1+\sqrt2,
$$

$$
B=(N-1)\bar z+\sqrt{\bar z^2+1}-(N-2)\sqrt\delta.
$$

The derivative of $\sqrt{z^2+1}$ is below one, so
$B-A_0<Nh-(N-2)\sqrt{2h}<0$ for $N\ge3$.
Choose any $a$ strictly between $B$ and $A_0$, and let
$C_N=\sum_{j=0}^{N-1}\sqrt j$. Choose

$$
0<\varepsilon<\min\left\{
\frac{\delta}{N-1},\quad
\frac{2\sqrt\delta(a-B)}{N(N-1)},\quad
\left(\frac{A_0-a}{C_N}\right)^2
\right\},\qquad
\sigma_i=1+(i-1)\varepsilon.
\tag{9.20}
$$

All costs are positive and distinct, and $\bar z>\sqrt\mu$. The elementary identity

$$
\sqrt\delta-\sqrt{\delta-j\varepsilon}
=\frac{j\varepsilon}{\sqrt\delta+\sqrt{\delta-j\varepsilon}}
\le\frac{j\varepsilon}{\sqrt\delta}
$$

implies, for every $i$,
$\Phi_i(\bar z)\le B+N(N-1)\varepsilon/(2\sqrt\delta)<a$.
At the endpoint,
$a_c\ge A_0-C_N\sqrt\varepsilon>a$.
Hence there is one all-low minimum. Each nonmaximum one-high branch, by convexity, crosses the level $a$ once with positive derivative after $\bar z$. The maximum branch starts above $a$, is below $a$ at $\bar z$, and tends to infinity; its shape from Section 9.2 therefore gives a late positive-derivative crossing. These are $N$ distinct additional positive-definite minima. The upper bound makes the count exactly $N+1$. Both $a$ and $\varepsilon$ may be selected rationally inside the displayed strict intervals.

For $N=2$, take $\gamma=1$, $(\sigma_1,\sigma_2)=(1,2)$, and $a=4$. The maximum branch is strictly increasing from
$a_c=\sqrt2+\sqrt3-1<4$, so contributes one minimum. The other branch has endpoint value $\sqrt2+\sqrt3+1>4$, but
$\Phi_1(3/2)=1+(\sqrt{13}+\sqrt5)/2<4$.
Its strict convexity and divergence give an increasing root and hence a second minimum. For completeness, the one-player problem has one minimum by strict coordinate convexity. All constructions use $\gamma=1$, so finite cost implies physical stability. $\square$

## 9.6. Enumeration, exact degenerate examples, and verification limits

The proof gives the following exhaustive procedure. Reflect to $a>0$, with $a=0$ handled directly. Compute $\mu,\zeta,q,a_c$. Solve the all-low equation on its strictly decreasing interval if $a<a_c$. For each nonexceptional $\Phi_i$, its strictly increasing derivative locates at most one minimum; keep only the increasing interval. For the unique maximum branch, use the strictly increasing function $\Psi$ to locate its possible curvature change, then test the minimum of $\Phi_i'$ to obtain either one globally increasing interval, a monotone interval containing a cusp, or two increasing intervals. Solve $\Phi_i=a$ only on those intervals, count a cusp once, and exclude ordinary stationary folds by T9. Finally test the endpoint once, merging every sign label that represents that same policy.

There are at most $N+2$ monotone intervals bearing candidate minima. Each retained root reconstructs its policy explicitly. Physical stability is additionally equivalent to $z>(\gamma^{-1}-1)/2$, since $\rho^2+2z\rho=\gamma^{-1}$. For exact algebraic input, the radical equations and derivative equality tests admit algebraic root isolation with the displayed inequalities imposed; comparisons at folds and cusps require exact or certified arithmetic. Floating-point near-equalities alone are not a boundary certificate. The procedure reduces the number of branches, but does not provide a uniform bit-complexity bound near degeneracy.

The sixth-order and cusp cases actually occur. For a rational sixth-order example, take

$$
N=3,\quad \gamma=\frac45,\quad
(\sigma_1,\sigma_2,\sigma_3)=\left(1,1,\frac{55}{64}\right),\quad
a=\frac{25}{8},\quad k_* =\left(-1,-1,-\frac58\right).
$$

Then $r=1/2$, $D=4/5$, $\zeta=1$, and
$d=2+2/3-8/3=0$,
$\mathcal L''(1)=10/27+440/27=50/3$.
Along the true transverse minimizer with $x=(k_1-k_2)/2$, (9.18) becomes

$$
V(x)-V(0)=\frac{25}{72}x^6+O(x^8).
\tag{9.21}
$$

For a physically stable interior cusp with rational costs, take

$$
N=3,\quad\gamma=1,\quad z_* =\frac5{\sqrt{231}},\quad
\sigma_1=\frac{375}{3721},\quad
\sigma_2=\sigma_3=\frac{1625}{16807},\quad
a_* =\frac{2178\sqrt{231}}{20923}.
$$

Choose player 1 high. The exact ratios

$$
\frac{z_*}{\sqrt{z_*^2+1}}=\frac5{16},\quad
\frac{z_*}{\sqrt{z_*^2-\sigma_1}}=\frac{61}{16},\quad
\frac{z_*}{\sqrt{z_*^2-\sigma_2}}=\frac{49}{16}
$$

give $\Phi_1'(z_*)=\Phi_1''(z_*)=0$ and
$z_*^2\Phi_1'''(z_*)=26413695/32768>0$.
Its closed loop is $11/\sqrt{231}<1$. Thus the fourth- and sixth-order alternatives are not vacuous formal cases.

The secondary computation record, [results/secondary_verification.json](evidence/results/secondary_verification.json), checks the explicit sharp constructions for $N=2,\ldots,12$, 160 additional generic parameter instances, and exact identities for the transverse reduction and degenerate examples. Its status is a reproducibility check, not a proof of T9--T10 or of untested parameter values. The universal claims rest on the curvature, Hessian, full transverse reduction, and counting arguments above.

This extension remains within the scalar shared-state model. Plank and Zhang [R10] already prove potential-based global policy-gradient convergence in a different finite-horizon stochastic model with distributed policies and pairwise interaction structure. Their result prevents a broad claim to the first general-$N$ LQ potential-based learning theorem; it does not identify the attractor count in the infinite-horizon shared-scalar game studied here. The earlier full-text limitation concerning [R5] remains in force.


# 10. Synchronous descent with a common discount

Let $P=\log Q$ be the common-discount ordinal potential, $g=(\partial_i J_i)_i$, and let $0<\beta,\theta<1$. From any finite-cost initial profile, propose $k-sg$, starting with $s=1$ and multiplying by $\beta$ until the profile is feasible and
$$
P(k-sg)\le P(k)-\theta s\langle\nabla P(k),g(k)\rangle .
$$
At a stationary point the sequence is constant. The initial sublevel is compact inside the stability strip. On it the cost factors are positive and bounded, and $g_i=J_i\partial_iP$. Thus $\|g\|^2\le M\langle\nabla P,g\rangle$ with a finite uniform $M$. The Hessian of $P$ is bounded on a closed neighborhood of this sublevel and $g$ is bounded on the sublevel, so a uniform small step is feasible and the descent lemma shows it is accepted. Backtracking has a positive lower step. Summing sufficient decrease gives summability of $\|g\|^2$, hence the minimum squared gradient through step $T$ is $O(T^{-1})$. All accumulation points are stationary Nash points, and the iterates are bounded with vanishing step differences. Since the stationary set is finite, the iterates converge to one of them. This update queries the shared potential.

# 11. Heterogeneous discounts and an inverse-slope potential

Let $0<\gamma_i\le1$, $\gamma_*=\max_i\gamma_i$, $R=\gamma_*^{-1/2}$, and $r=a+\sum_i k_i$. Write $J_i=(\sigma_i+k_i^2)/(1-\gamma_i r^2)$ for $|r|<R$, the common finite-cost strip. On its individual stability interval define
$$
u_i(k)=\frac{k}{\sigma_i+k^2},\qquad
h_i(r)=\frac{\gamma_i r}{1-\gamma_i r^2},\qquad
F_i(k)=h_i^{-1}(-u_i(k)).
$$
The map $h_i$ is strictly increasing onto the real line. The smooth bounded $F_i$ has the sign opposite to $k$ and satisfies $-F_i(k)\sim1/(\gamma_i k)$ at both ends. Thus the function
$$
\mathcal L(k)=\tfrac12 r^2-\sum_i\int_0^{k_i}F_i(w)\,dw
$$
has compact sublevel sets. Its gradient is $G_i=r-F_i(k_i)$, and
$\partial_iJ_i=2J_i[h_i(r)-h_i(F_i(k_i))]$.
The ratio to $G_i$ extends continuously and positively by integration of $h_i'$ between the two arguments.

For arbitrary positive constants $c_i$, the simultaneous flow $\dot k_i=-c_i\partial_iJ_i$ strictly decreases this potential off its stationary set. On a sublevel the smaller-discount contributions to $\dot r$ remain uniformly bounded near the two strip endpoints. Every maximal-discount gradient diverges uniformly outward there, since $u_i$ is bounded and $J_i\ge\sigma_i/(1-\gamma_i r^2)$. Therefore $\dot r$ points strictly inward on sufficiently narrow endpoint intervals, giving a compact invariant part of the interior containing the given initial condition. Continuation yields a global trajectory. The gradient-ratio factors on the compact invariant set have positive lower bounds, so the integral of $\|G\|^2$ is finite and uniform continuity gives $G\to0$.

For fixed opponents, a critical point $z$ in player $i$'s individual stability interval is the unique optimum: for its cost $v$ the numerator minus $v$ times the denominator is $(1+\gamma_i v)(k_i-z)^2$. Simultaneous stationary points are therefore Nash. When $r=0$ all coordinates and $a$ are zero. If $r>0$ then all coordinates are negative and $a>0$. Write $z_i(r)=(1-\gamma_i r^2)/(2\gamma_i r)$, so each coordinate is $-z_i\pm\sqrt{z_i^2-\sigma_i}$. Multiply the aggregate equation over all signs. Invariance under each flip makes the product a rational function of $r$. It is nonzero as a rational function: near $r=0$ the factor with all small roots approaches $-a$, while any other factor is asymptotic to a positive constant times $1/r$. Its nonzero numerator has finitely many roots and each has finitely many coordinate choices. Reflection treats negative $r$. The compact connected limit set of a continuous trajectory is therefore a singleton. The argument includes repeated discounts and state penalties.

# 12. Autonomous discrete updates and the critical power

Set $d_i=1-\gamma_i r^2$ and $d_*=1-\gamma_* r^2$. For power $\alpha$, consider
$$
k_i^+=k_i-\eta_i d_*^\alpha\frac{\partial_iJ_i}{2(\sigma_i+k_i^2)}.
$$
For every $\alpha\ge2$ the fixed positive steps specified below give feasibility throughout and full-sequence convergence to a finite-cost Nash equilibrium from all $|r|<R$. The minimum squared potential gradient up to $T$ is $O(T^{-1})$. Power two also gives a uniform inward margin after one step from the whole strip and is the only power in this update family with both properties.

For $\alpha=2$, the step direction is $v_i(r,u)=(d_*/d_i)^2(d_i u+\gamma_i r)$. Write $U_i=1/(2\sqrt{\sigma_i})$ and let $D_i$ be the maximum of $|\partial_r v_i(r,u)|$ for $|r|\le R$, $|u|\le U_i$. In the maximal-discount case cancel the identical factors first. For smaller discounts there is no endpoint pole. The direction is affine in $u$, so an endpoint comparison reduces the bound to one-dimensional functions of $r$ with $u=\pm U_i$. Set $\rho_i=\sqrt{\gamma_i}\sup_k|F_i(k)|<1$, $B_i=\gamma_i/(1-\rho_i)$, and $L_i=1/(\gamma_i\sigma_i)$. Since $h_i'\ge\gamma_i$ and $|u_i'|\le1/\sigma_i$, $L_i$ bounds $|F_i'|$. Use
$$
0<\eta_i\le
\min\{[2N(1+D_i)]^{-1},[(N+L_i)(1+B_i)]^{-1}\}.
$$
A player uses its private parameters and gain, the common $N,\gamma_*$, and the observed common closed-loop coefficient $r$.

With the current $u_i$ fixed, $\phi(r)=r-\sum_i\eta_i v_i(r,u_i)$ is strictly increasing, with derivative at least $1/2$. At the endpoints smaller-discount directions vanish. The others equal $\pm\sqrt{\gamma_*}$, giving $\phi(\pm R)=\pm(R-\xi)$ for $\xi=\sqrt{\gamma_*}\sum_{\gamma_i=\gamma_*}\eta_i$. Strict monotonicity gives $0<\xi<R$ and the uniform bound $|r^+|\le R-\xi$.

Direct calculation gives $v_i=b_iG_i$ with
$$
b_i=(d_*/d_i)^2
\frac{\gamma_i(1+\gamma_i rF_i)}{1-\gamma_i F_i^2}.
$$
On the strip this is positive and at most $B_i$, and it is bounded below by a positive constant on each fixed inner strip. For any displacement $z$ the potential obeys
$$
\mathcal L(k+z)\le\mathcal L(k)+G(k)\cdot z+
\tfrac12\sum_i(N+L_i)z_i^2,
$$
by expanding the square of $r$ and using the Lipschitz bounds on $F_i$. With $z_i=-\eta_i b_iG_i$, the decrease is at least $\tfrac12\sum_i\eta_i b_i G_i^2$. Compact sublevels and the inner-strip bound give summable squared gradients and vanishing step differences. The single initial step has finite parameters and can be included with its own positive lower coefficient for the $O(T^{-1})$ residual bound. Every accumulation point is one of the finitely many stationary points from Section 11. An infinite sequence with vanishing step differences cannot repeatedly move between separated neighborhoods of those points without an accumulation point between them, so the full sequence converges.

For $\alpha>2$ the update is the convex combination of the current profile and the power-two update with latter weight $d_*^{\alpha-2}$. Thus the entire sequence satisfies $|r_j|\le\max(|r_0|,R-\xi)<R$, and the additional weight is bounded below on that strip. The same potential argument applies. For necessity take one player, $\gamma=1/4$, $\sigma=1$, $a=0$ and $r\uparrow2$. The direction for power $\alpha$ is $d_*^{\alpha-2}(d_*u+r/4)\sim d_*^{\alpha-2}/2$. Every fixed positive step crosses the opposite endpoint when $\alpha<2$ and $r$ is close enough to 2. For $\alpha>2$ the displacement tends to zero, precluding a uniform one-step inward margin. As a heterogeneous check, for two players with $\gamma_1=1/4$ and $\gamma_2=1/9$, the second player's direction vanishes at $\pm2$ while the first player's tends to $\pm1/2$.

Mazumdar et al. [R11] give nonconvergence examples for more general matrix games. Hambly, Xu and Yang [R12, §3] prove convergence of natural policy gradients in stochastic finite-horizon games under a noise condition. The autonomous rule here is for the normalized shared-scalar infinite-horizon setting, requires the observed common closed-loop coefficient, and uses a boundary-dependent rescaling instead of backtracking. The power characterization concerns exactly the displayed family. The two-player scalar gradient comparison in [R5] remains limited to the record and available summary. Full Lean formalization will be delivered separately.

# References

**[R1]** B. Nortmann, M. Sassano, and T. Mylvaganam. *Feedback Nash equilibria for scalar N-player linear quadratic dynamic games*. Automatica 174 (2025), 112133. DOI: [10.1016/j.automatica.2025.112133](https://doi.org/10.1016/j.automatica.2025.112133). [arXiv:2411.19377](https://arxiv.org/abs/2411.19377). [Institutional full text](https://spiral.imperial.ac.uk/server/api/core/bitstreams/af3f8901-8d0b-43ef-8e5d-be51e6a1aa34/content).

**[R2]** G. Salizzoni, R. Ouhamma, and M. Kamgarpour. *Nash equilibria in scalar discrete-time linear quadratic games*. European Control Conference, 2025. [arXiv:2410.12544v2](https://arxiv.org/abs/2410.12544v2). [Full HTML](https://arxiv.org/html/2410.12544v2).

**[R3]** C. Cavalagli, A. Bemporad, and M. Zanon. *Characterization and computation of feedback Nash equilibria in scalar discounted N-player linear quadratic games*. IEEE Control Systems Letters 10 (2026), 919--924. DOI: [10.1109/LCSYS.2026.3703771](https://doi.org/10.1109/LCSYS.2026.3703771). [Institutional record and full-text files](https://iris.imtlucca.it/handle/20.500.11771/44278). [arXiv:2606.13087](https://arxiv.org/abs/2606.13087). Both journal and postprint numbering are distinguished in Section 1.

**[R4]** C. Cavalagli, A. Bemporad, and M. Zanon. *On Two-Player Scalar Discounted Linear Quadratic Games*. [arXiv:2603.13122v3](https://arxiv.org/abs/2603.13122v3), revised 2 October 2026. The current comparison uses the revised version rather than only the March 2026 first version.

**[R5]** G. Salizzoni and M. Kamgarpour. *On the Convergence of Gradient Descent in Scalar Two-Agent Infinite-Horizon LQ Games*. IEEE Control Systems Letters 9 (2025), 517--522. DOI: [10.1109/LCSYS.2025.3574107](https://doi.org/10.1109/LCSYS.2025.3574107). [EPFL institutional record](https://infoscience.epfl.ch/entities/publication/a616b6f7-61ee-4cfe-84bb-f7e2cc59fa90). Bibliographic identity and two-player scope were verified; full text was unavailable for method-level comparison in this session.

**[R6]** S. Hosseinirad, G. Salizzoni, A. Alian Porzani, and M. Kamgarpour. *On linear quadratic potential games*. Automatica 183 (2026), 112643. DOI: [10.1016/j.automatica.2025.112643](https://doi.org/10.1016/j.automatica.2025.112643). Substantive publisher-indexed text was inspected; the full PDF was not retrieved.

**[R7]** Machina Mathematica, released by Korea Superintelligence Labs. *The exact three-player threshold for maximal multiplicity of feedback Nash equilibria in the symmetric scalar discounted linear-quadratic game*. Author-hosted research manuscript, snapshot 7 September 2026. [Record](https://ideosphere.ai/papers/symfne-oddn). [Full manuscript](https://ideosphere.ai/papers/symfne-oddn-v1.pdf). Its aggregate-coordinate method and general stationary polynomial are prior art; its reported Lean status is not used as evidence of priority or as a substitute for comparison of theorem scopes.

**[R8]** J. Engwerda. *Properties of feedback Nash equilibria in scalar LQ differential games*. Automatica 69 (2016), 364--374. DOI: [10.1016/j.automatica.2016.03.014](https://doi.org/10.1016/j.automatica.2016.03.014). [Institutional record](https://research.tilburguniversity.edu/en/publications/properties-of-feedback-nash-equilibria-in-scalar-lq-differential-/). The branch-shape attribution used here is also explicitly stated and recalled in the accessible full text of [R9].

**[R9]** J. Engwerda. *A Numerical Algorithm to Calculate the Unique Feedback Nash Equilibrium in a Large Scalar LQ Differential Game*. Dynamic Games and Applications 7 (2017), 635--656. DOI and [open full text](https://doi.org/10.1007/s13235-016-0201-7). In particular, Lemma 3.2 states the regulator branch shapes and Theorem 3.4 applies them to equilibrium uniqueness; the model has continuous-time plant dynamics.

**[R10]** P. Plank and Y. Zhang. *Learning Distributed Equilibria in Linear-Quadratic Stochastic Differential Games: An $\alpha$-Potential Approach*. [arXiv:2602.16555v1](https://arxiv.org/abs/2602.16555v1), 18 February 2026. [Full HTML](https://arxiv.org/html/2602.16555v1). The comparison concerns their finite-horizon stochastic game with distributed policies; its global learning results are not claimed as new here.

**[R11]** E. Mazumdar, L. J. Ratliff, M. I. Jordan, and S. S. Sastry. *Policy-Gradient Algorithms Have No Guarantees of Convergence in Linear Quadratic Games*. [arXiv:1907.03712](https://arxiv.org/abs/1907.03712).

**[R12]** B. Hambly, R. Xu, and H. Yang. *Policy Gradient Methods Find the Nash Equilibrium in N-player General-sum Linear-quadratic Games*. JMLR 24, 1–56 (2023). [Full text](https://www.jmlr.org/papers/volume24/21-0842/21-0842.pdf).
