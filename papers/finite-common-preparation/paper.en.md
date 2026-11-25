---
title: "Optimal finite preparation for delayed Newton cooling"
subtitle: "The unique control and sharp short- and long-preparation asymptotics"
lang: en
---

# Optimal finite preparation for delayed Newton cooling

## Abstract

We consider delayed Newton cooling when two samples begin in a common equilibrium and may be prepared for only a fixed duration before entering the same cold bath. For every positive duration and every delay up to the nonoscillation threshold, the unique optimal preparation uses opposite extreme baths and switches them once. We give its exact reversal window, an objective balance characterization, and strict monotonicity in available preparation time. As the duration tends to zero, the optimal reversal magnitude is quadratic with an explicit cubic correction. As the duration tends to infinity, its gap to the unrestricted-history optimum has a positive leading coefficient times the tail of the relaxation function.

## 1. Model and theorem

In normalized temperature and time units, each sample follows

~~~text
x'(t) = −x(t−τ) + u(t),    0<τ≤1/e.
~~~

The permitted bath temperatures are 0≤u≤1. Fix a preparation duration L>0. The two samples and their baths share the same specified equilibrium for t<−L. The two baths may be arbitrary measurable functions on [−L,0], and both baths equal zero for t≥0. Write Δ=x_A−x_B. For Δ(0)>0 the objective is

~~~text
M = min{Δ(0), sup_(t≥0)[−Δ(t)]}.
~~~

A positive value means that the initial ordering is later reversed. The supremum is nonnegative because the temperature difference tends to zero. Labels can be exchanged to make the initial difference positive when it is nonzero.

Write r for the fundamental response and E(t)=∫_t^∞r(s) ds for t≥0. The pinned unrestricted-history analysis supplies the following properties. The response is positive, nonincreasing, and log-concave, with unit integral. It equals one on [0,τ] and satisfies r'(t)=−r(t−τ) for t>0 with r zero at negative arguments. Also E(t)=r(t+τ), E'(t)=−r(t), and h(t)=−r'(t)/r(t) is zero before τ and strictly increases on [τ,∞) to κ, the smallest positive solution of κ=exp(κτ). These properties include τ=1/e.

**Theorem 1.** For every L>0, the unique maximizing bath pair up to null sets uses opposite extreme baths throughout preparation. First A uses bath 1 and B uses bath 0. At time −w_L the two baths exchange, and at time zero both enter bath 0. For 0<w<L define

~~~text
A_L(w)=2E(w)−1−E(L),
B_L(w)=sup_(t≥0)[E(t)+E(t+L)−2E(t+w)].                         (1)
~~~

The optimal switch age w_L is the unique positive balance A_L(w_L)=B_L(w_L)>0. With M_L the optimal value, the unique post-preparation crossing c_L and the minimum time t_L satisfy

~~~text
2E(c_L+w_L)=E(c_L)+E(c_L+L),     t_L=c_L+τ.                   (2)
~~~

The value M_L is strictly increasing in L. Its finite-duration asymptotics are given in Sections 4 and 5.

The unrestricted-history optimum permits different equilibrated baths in the remote past. The finite-duration constraint here requires identical incoming equilibria and uses at most L time to create the initial temperature difference. The value and optimal switching time depend on that constraint.

## 2. Pointwise optimum at a fixed initial difference

Using the age s before time zero, write v(s)=u_A(−s)−u_B(−s) for 0≤s≤L. Every measurable v in [−1,1] is achievable, for example by the pair ((1+v)/2,(1−v)/2) on the preparation interval. Since the difference is initially zero, variation of constants gives

~~~text
Δ_v(t)=∫_0^L r(t+s)v(s) ds,    t≥0.
~~~

Indeed, the convolution solves the linear delay equation and has zero difference before the forcing starts, so uniqueness by the method of steps identifies it with the actual difference.

Every feasible initial difference m in (0,1−E(L)] has a unique w≥0 with m=A_L(w), because E is continuous and strictly decreasing. Let v_w=−1 for 0≤s<w and v_w=1 for w<s≤L. This is the chronological extreme-bath exchange in the theorem. The response is

~~~text
Δ_(L,w)(t)=2E(t+w)−E(t)−E(t+L).
~~~

For any v with the same m, set δ=v−v_w. The function δ is nonnegative below w and nonpositive above w, and ∫_0^Lr(s)δ(s) ds=0. For each t, the ratio q_t(s)=r(t+s)/r(s) is nonincreasing in s by log-concavity of r. Thus

~~~text
Δ_v(t)−Δ_(L,w)(t)=∫_0^L r(s)[q_t(s)−q_t(w)] δ(s) ds ≥ 0.       (3)
~~~

For t>τ the ratio is strictly decreasing at every finite age, since h(t+s)>h(s). The inequality is then strict whenever v differs from v_w on a set of positive measure. The same result is immediate for w=0, since m is then its maximal feasible value and forces v=1.

## 3. Reversal window, optimum, and monotonicity

Put w₀(L)=E⁻¹((1+E(L))/2). Then 0<w₀(L)<L, and the requirement m>0 is equivalent to w<w₀(L). For 0<w<L let

~~~text
P(t)=∫_w^L r(t+s) ds,    N(t)=∫_0^w r(t+s) ds.
~~~

The sign of Δ_(L,w)(t) is the sign of P(t)/N(t)−1. The derivative of log(P/N) equals the weighted average of h(t+s) on the early ages minus its weighted average on the later ages, with weights r(t+s). It is nonpositive. It is strictly negative almost everywhere once t+L>τ since h is strictly increasing after τ and the later interval has positive length there. When t+L≤τ the ratio is constant. Both integrals are positive, and the derivative calculation holds almost everywhere by local absolute continuity.

The ratios r(t+s)/r(t) converge uniformly for s∈[0,L] to exp(−κs), by the convergence of h. Thus the limiting sign is determined by

~~~text
∫_w^L exp(−κs) ds − ∫_0^w exp(−κs) ds
  = [2 exp(−κw)−1−exp(−κL)]/κ.
~~~

If the limiting ratio equals one, it stays strictly above one at every finite time, because it eventually decreases strictly. Therefore a positive initial difference leads to reversal exactly for

~~~text
w_c(L) < w < w₀(L),    w_c(L)=−κ⁻¹ log[(1+exp(−κL))/2].        (4)
~~~

At w=w₀(L) the ratio starts at one and eventually decreases strictly, so the limiting ratio is strictly below one and w_c(L)<w₀(L). In the open reversal window the unique crossing occurs strictly after zero.

For these histories Δ stays nonnegative throughout preparation. During its first, positive-forcing stage the derivative is −Δ(t−τ)+1≥0 because each normalized sample stays in [0,1]. During its negative-forcing stage the derivative is −Δ(t−τ)−1≤0, and its terminal value is m>0. The bound on each sample follows by convolving its bath history with the nonnegative unit-mass response, extending its constant bath before preparation. After time zero the derivative of Δ equals −Δ(t−τ). The unique crossing therefore gives the unique global negative minimum at time c+τ, proving (2) at the optimum.

On [0,w₀(L)], A_L decreases strictly from a positive number to zero. The function B_L is continuous with Lipschitz constant at most two because |E'|≤1. It is nondecreasing and is strictly increasing wherever its smaller value in a comparison is positive. Indeed, a positive supremum occurs at a finite time, and increasing w strictly increases the expression at that time. By (4), B_L=0 at w_c and B_L>0 at w₀(L). There is a unique balance w_L in the reversal window. Before it, B_L is smaller than the optimal magnitude; after it, A_L is smaller. Inequality (3) proves global optimality. If a different history with the same m achieved the same positive optimal magnitude, its minimum would occur at some finite time. At that time the threshold response is no higher, and its sole minimum occurs at t_L>τ. Equality would therefore require equality in (3) at t_L, forcing v=v_w almost everywhere. A bath difference of ±1 uniquely determines both bounded baths. This establishes uniqueness.

If L₂>L₁, extend the optimal L₁ history by zero difference on the new older ages. It has the same m and the same response as before. Its difference is strictly between the extremes on a set of positive measure, so the L₂ threshold with that m gives a strictly smaller response at the old finite minimum time, by (3). Its possible depth of reversal is therefore strictly larger than m=M_(L₁). Increasing m slightly in the L₂ threshold family preserves a depth larger than the new m by continuity, since m is in the interior of that feasible range. Hence M_(L₂)>M_(L₁).

## 4. Short preparation

Fix 0<τ≤1/e and put

~~~text
k₀ = 1/[4(2−τ)],
z₀ = √[(1−τ)/(2(2−τ))],
k₁ = {k₀(1/2−z₀) − (1−z₀)³/6 + (1/2−z₀)³/3}/(2−τ).
~~~

**Theorem 2.** As L decreases to zero,

~~~text
M_L = k₀ L² + k₁ L³ + O(L⁴),
w_L = L/2 − (k₀/2)L² + O(L³),
c_L = τ−z₀L + O(L²),    t_L = 2τ−z₀L + O(L²).                (5)
~~~

A local polynomial system supplies the exact optimizer for all sufficiently small L.

**Proof.** The method of steps gives, for 0≤t≤3τ,

~~~text
r(t) = 1 − (t−τ)_+ + (t−2τ)_+²/2,
~~~

where a positive part is zero below its threshold. For L<τ, A_L(w)=L−2w. Set m=L−2w and seek a crossing c=τ−x with 0<x<w<L. Then r(c+s)=1−(s−x)_+ and

~~~text
m=(L−x)²/2−(w−x)².                                          (6)
~~~

This is precisely the zero equation from integrating r(c+s)v_w(s). At the minimum candidate c+τ=2τ−x, the kernel is 1−τ+x−s+(s−x)_+²/2. Integrating and imposing balance gives

~~~text
m(2−τ+x) = L²/2−w² − (L−x)³/6 + (w−x)³/3.                   (7)
~~~

For existence on this branch put m=L²k, x=Lz, and w=L/2−m/2. After dividing (6) and (7) by L², the equations are polynomial in L,k,z. At L=0 they read

~~~text
k=1/4−z²/2,    (2−τ)k=1/4.
~~~

Thus k=k₀ and z=z₀, with 0<z₀<1/2. The determinant in the variables k,z is −(2−τ)z₀ and is nonzero. The analytic implicit function theorem gives k(L),z(L) near zero. Since z₀<1/2 and k₀>0, the solution has 0<x<w<L, positive m, and c>0 for all sufficiently small positive L. The crossing identity and uniqueness imply that 2τ−x is indeed the minimum time, and (7) makes this history the optimum in Theorem 1.

Expand (7) after substituting k=k₀+k₁L+O(L²), x=Lz₀+O(L²), and w=L/2−k₀L²/2+O(L³). The coefficient at order L³ satisfies

~~~text
(2−τ)k₁ + k₀z₀ = k₀/2 − (1−z₀)³/6 + (1/2−z₀)³/3.
~~~

Using k₀=1/4−z₀²/2, the coefficient also equals −z₀²(3−4z₀)/[12(2−τ)] and is strictly negative. The expansions of the remaining variables follow from their definitions. This proves (5).

## 5. Long preparation

Use w_* and t_* for the unique optimal switching age and minimum time in the unrestricted-history case. Set M_* for its magnitude, and put r₁=r(w_*), r₂=r(t_*+w_*) and z_*=exp(−κt_*). The archived theorem gives w_*, t_*, and M_*>0 through the balance of

~~~text
A(w)=2E(w)−1,    B(w)=sup_(t≥0)[E(t)−2E(t+w)].
~~~

**Theorem 3.** As L tends to infinity,

~~~text
w_*−w_L = [(1+z_*)/(2(r₁+r₂))] E(L) + o(E(L)),
M_*−M_L = [(r₂−r₁ z_*)/(r₁+r₂)] E(L) + o(E(L)).               (8)
~~~

The leading coefficient in the optimal magnitude gap is strictly positive, including at τ=1/e.

**Proof.** By (1), A_L=A−E(L), while B_L differs from B by at most E(L), uniformly on w≥0. For L sufficiently large, a fixed neighborhood of w_* lies inside [0,w₀(L)] because w₀(L) tends to the unrestricted positive zero of A. The strict signs of A−B on either side of its root and uniform convergence imply w_L→w_*.

With w near w_*, the maxima defining B and B_L occur in one fixed compact time interval, since their values at t_* stay bounded below by a positive constant and their objective is bounded above by 2E(t). For w=w_L, every choice of optimizing times for B or B_L tends to t_*, by uniform convergence on that compact interval and uniqueness of the optimum at w_*. Likewise any optimizing times for B(w) converge to t_* as w tends to w_*.

The hazard limit gives E(L+t)/E(L)→exp(−κt) uniformly on bounded time intervals, by integrating h from L+τ to L+τ+t. Evaluate the finite objective at an optimizer for B(w_L) for a lower bound, and evaluate its added tail term at an optimizer for B_L(w_L) for an upper bound. These two comparisons yield

~~~text
B_L(w_L) = B(w_L) + z_* E(L) + o(E(L)).                        (9)
~~~

The same compactness and unique optimizer argument, together with the continuous w-derivative 2r(t+w) of the objective at any fixed t, gives B'(w_*)=2r₂. Indeed, for each w near w_*, the difference in objective values at t_* and at any optimizer for B(w) bounds the two difference quotients for B by using each time in both objectives. Both time arguments tend to t_* as w tends to w_*. Since A'(w_*)=−2r₁, the balance of A_L and B_L and (9) give

~~~text
(A−B)(w_L) = (1+z_*)E(L)+o(E(L)),
(A−B)'(w_*) = −2(r₁+r₂).
~~~

The derivative is nonzero, so the first expansion in (8) follows by linearization. Then M_L=A(w_L)−E(L) gives the second expansion. Finally log(r₂/r₁)=−∫_(w_*)^(w_*+t_*) h(s) ds>−κt_*, because h is strictly below κ at each finite s. Hence r₂>r₁ z_* and the coefficient is positive.

### 5.1. Explicit scale in the preparation duration

The relaxation tail in (8) has the following two forms:

~~~text
E(L) ∼ exp(−κL)/[κ(1−κτ)]           for 0<τ<1/e,
E(L) ∼ 2L exp(−eL)                 for τ=1/e.              (10)
~~~

To prove them without a spectral expansion, define p(t)=exp(κt)r(t) for t≥0 and p(t)=0 for t<0. The differentiated response equation, together with exp(κτ)=κ, gives

~~~text
p(t) = 1+κ ∫_((t−τ)_+)^t p(s) ds .
~~~

It follows either by differentiating this identity and matching p(0)=1, or by integrating p'(t)=κ[p(t)−p(t−τ)]. Let S_j be the sum of j independent uniform variables on [0,τ], with S₀=0. Iterating the identity gives

~~~text
p(t)=∑_(j≥0) (κτ)^j Pr(S_j≤t).
~~~

The iteration remainder tends to zero at fixed t because p is bounded on [0,t], κτ≤1, and Pr(S_j≤t)→0. For example the latter follows by the exponential Markov bound using E[exp(−S_j)].

When κτ<1, dominated convergence gives p(t)→1/(1−κτ). When κτ=1, let N(t)=max{j:S_j≤t}. The series says p(t)=E[N(t)+1]. By independence of each increment from the event that the previous partial sum has not crossed t,

~~~text
E[S_(N(t)+1)] = (τ/2) E[N(t)+1].
~~~

This identity also follows directly by summing the expectations of each retained increment. The overshoot is at most τ, so t<E[S_(N(t)+1)]≤t+τ and p(t)=2t/τ+O(1). Since E(L)=r(L+τ)=exp(−κL)p(L+τ)/κ, both expressions in (10) follow. In particular the strictly positive coefficient in (8) multiplies a pure exponential below the endpoint and a duration times an exponential at the endpoint.

## 6. Source relation and scope

The pinned unrestricted-history theorem proves log-concavity, pointwise threshold dominance, and a unique optimal balancing protocol in a model that permits opposite remote equilibria. Those ingredients are credited to the pinned case. This work imposes a common incoming equilibrium and a finite preparation horizon. Its additional conclusions are the exact finite-duration reversal window and optimum, the strict improvement with preparation time, the short-horizon cubic response, and the positive long-horizon gap coefficient. They concern the scalar delayed Newton model for delays through its nonoscillatory endpoint. The comparison is limited to the pinned repository record.
