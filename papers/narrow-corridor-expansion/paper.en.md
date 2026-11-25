---
title: "Narrow corridors in critical online conformal prediction"
subtitle: "A uniform expansion of the unknown-reference control cost"
date: "25 November 2026"
geometry: margin=0.82in
---

## Abstract

A critical online conformal constraint keeps cumulative misses in a square-root corridor. We compute the small-width expansion of the optimal worst-case disagreement with the nearest exact oracle when the distribution is unknown. The excess over the known-distribution reflection cost has a constant term, a linear term, and a quadratic term that are uniform across all allowed corridor centers. The first center-dependent difference in total cost is cubic and has an explicit coefficient. The quadratic term separates a stationary Gaussian contribution from an initial Dirichlet-heat transient. A discrete comparison with fixed additive padding makes arbitrarily narrow, genuinely two-sided corridors admissible and transfers the expansion back to the original minimax prediction model.

## 1. Setting and result

Use the unknown-distribution model of Gui, Barber and Ma [1], with a fixed score having an atomless distribution, target miss probability \(\alpha\in(0,1)\), and nearest-exact-oracle cumulative disagreement. Let \(\sigma^2=\alpha(1-\alpha)\). At time \(t\), constrain the cumulative miss count \(N_t\) by
\[
 -B-c_-\sqrt t\ \le N_t-\alpha t\ \le B+c_+\sqrt t,
 \qquad B\ge1,\qquad c_-,c_+\ge0,\quad c_-+c_+>0 .
 \qquad\text{(1)}
\]
The constraints hold on every data path and at every prefix. Write \(M_T\) for the worst-distribution minimax cumulative expected disagreement over \(T\) rounds, using the deterministic measurable predictors and nearest exact oracle of [1,2]. Define half-width and center parameters by
\[
 K=\frac{c_-+c_+}{2\sigma},\qquad
 \mu=\frac{c_+-c_-}{c_++c_-}\in[-1,1].
\]
Write the limiting scaled value as
\(\mathcal C(K,\mu)=\lim_{T\to\infty}M_T/(\sigma\sqrt T)\).
The value is independent of the fixed padding \(B\). The scaled known-oracle coefficient is
\[
 c_{\mathrm{ref}}(K,\mu)=
 \frac{e^{-K^2(\mu-1)^2/2}+e^{-K^2(\mu+1)^2/2}}
      {K\int_{-1}^1 e^{-K^2(x+\mu)^2/2}\,dx}.
 \qquad\text{(2)}
\]

The pinned variational and parabolic results [3,4] gave a continuous value and an evaluation equation. The pinned large-width theorem [5] treated \(K\to\infty\) in the symmetric corridor. We treat the opposite limit and allow asymmetry. Padding in (1) is needed to apply discrete admissibility to arbitrary positive \(K\) simultaneously on both sides. Its disappearance after normalization is proved below.

Let \(\varphi,\Phi\) be the standard normal density and distribution function. Extend the function
\[
 H(x)=2\varphi\!\left(\Phi^{-1}\left(\frac{1+x}{2}\right)\right),
 \qquad |x|<1,
\]
by \(H(\pm1)=0\). Let \(U\) be uniform on \([-1,1]\), \(\langle f\rangle=\mathbb E f(U)\), and
\(S_s\) be the zero-boundary Dirichlet heat semigroup with generator \(\tfrac12\partial_{xx}\) on \((-1,1)\). Define
\[
 J_0=\int_0^\infty
       \left\langle H(x-S_s x)-H(x)\right\rangle\,ds .
 \qquad\text{(3)}
\]
The notation \(S_s x\) means that the semigroup acts on the identity function.

**Theorem 1.** For every fixed set of parameters in (1), \(\mathcal C(K,\mu)\) exists. As \(K\downarrow0\), uniformly for \(|\mu|\le1\),
\[
 \begin{aligned}
 \mathcal C(K,\mu)-c_{\mathrm{ref}}(K,\mu)
 &=\frac2{\sqrt\pi}+
 \frac4\pi\left(\frac2{\sqrt3}-1\right)K+\mathcal B K^2+O(K^3),\\
 \mathcal B
 &=8\left\langle (H-\langle H\rangle)^3\right\rangle
     -2\operatorname{Cov}(H(U),U^2)+J_0.
 \end{aligned}
 \qquad\text{(4)}
\]
In particular, the total cost is \(1/K+2/\sqrt\pi+
[4(2/\sqrt3-1)/\pi-1/3]K+\mathcal B K^2+O(K^3)\).
The stationary terms in \(\mathcal B\) are
\[
 \left\langle (H-\langle H\rangle)^3\right\rangle
   =\frac{\sqrt2-2\sqrt3+2}{\pi^{3/2}},
 \qquad
 \operatorname{Cov}(H(U),U^2)
   =\frac1{\sqrt\pi}
     \left[\frac2\pi\arcsin(1/3)-\frac13\right].
 \qquad\text{(5)}
\]
The transient integral satisfies the strict bounds
\[
 \frac13\int_0^1(1-x^2)\bigl(H(0)-H(x)\bigr)\,dx
 < J_0 < -\operatorname{Cov}(H(U),U^2).
 \qquad\text{(6)}
\]
Consequently \(0.0902<\mathcal B<0.1264\), with a rational verification of the displayed decimal bounds. Also
\[
 \mathcal C(K,\mu)-\mathcal C(K,0)
   =\frac{\mu^2}{3}K^3+O\!\left(K^4\log(1/K)\right)
 \qquad\text{(7)}
\]
uniformly for \(|\mu|\le1\). The limit \(T\to\infty\) is taken at fixed \(K,\mu\) before this small-width expansion.

## 2. Padded discrete corridors and the continuous value

The exact finite-rank result of [2] applies to any nonnegative nondecreasing corridor bounds whose sum is at least one. Its state is the integer miss count. At time \(t\) an action \(k\in\{0,\ldots,t\}\) makes the next miss bit Bernoulli with parameter \(k/t\), and has stage loss
\[
 \psi_t(k)=t^{-1}\mathbb E|\operatorname{Bin}(t,\alpha)-k|.
\]
Only changes with positive probability have to end in the legal integer interval. This rank dynamic program equals the original minimax value, including against arbitrary deterministic measurable predictors in the stated model [2].

For (1) the legal interval consists of the integers in
\([\alpha t-B-c_-\sqrt t,\alpha t+B+c_+\sqrt t]\cap[0,t]\).
Both rounded, clipped endpoints are nondecreasing with increments at most one. For the lower endpoint, the unrounded expression increases by at most \(\alpha\), and once it is positive its increments are positive. Indeed \(c_-\sqrt t<\alpha t\) there. For the upper endpoint the expression is increasing. Once it is below \(t\), \(c_+\sqrt t<(1-\alpha)t\), which makes the next increment smaller than one. At a clipped endpoint the claims follow from clipping and the same one-step estimates. At \(t=0\) the only state is zero, and the first move is legal. Thus from any legal state there is at least one legal bit, and projecting a proposed count to the next interval changes at most one bit.

The startup comparison needed in [3] can be verified directly for these small widths. Use the nominal action \(k_t^0=\lfloor\alpha t\rfloor\) and force the bit only when one possible value is illegal. Couple its actual bit to the nominal Bernoulli bit, denoted \(A_t^0\), by shared uniforms. Let \(m_t=(c_+-c_-)\sqrt t/2\) and center the actual count by \(Z_t=N_t-\alpha t-m_t\). Before correcting an illegal move the proposed value is
\(Z'_t=Z_{t-1}+A_t^0-\alpha-(m_t-m_{t-1})\).
If a correction occurs at the lower edge, \(Z'_t<-(c_-+c_+)\sqrt t/2-B\). At the upper edge it is greater than \((c_-+c_+)\sqrt t/2+B\). This holds with integer rounding because a proposed integer below the ceiling of the lower bound is strictly below the unrounded lower bound, and analogously above the upper floor. Proposed counts already lie in \([0,t]\). Since \(B\ge1\), the correction reduces the squared value by at least \((c_-+c_+)\sqrt t\). On the other hand,
\[
 \mathbb E[(Z'_t)^2-Z_{t-1}^2\mid\text{past}]=O(1),
\]
as \(|Z_{t-1}|\le B+(c_-+c_+)\sqrt{t-1}/2\), the proposed mean increment is \(O(1/t+1/\sqrt t)\), and the increment has bounded square. On a dyadic block \(m\le t<2m\), summing and discarding the nonnegative final square yields an expected \(O(\sqrt m)\) corrections, with constants allowed to depend on the fixed width and padding. Summing over blocks gives \(O(\sqrt r)\) through time \(r\). The nominal cost is \(O(\sqrt r)\) by \(\psi_t(k_t^0)\le\sigma/\sqrt t+1/t\). The change in cost on a forced round is at most its conditional actual-correction probability, because \(\psi_t\) is \(1/t\)-Lipschitz in the rank. Thus the total prefix risk is \(O(\sqrt r)\).

For clarity, we detail how this gives the same Brownian value as [3] without the earlier positive lower bound on the unpadded initial width. Let \(r=\lfloor\varepsilon T\rfloor\) and consider the suffix from a central legal integer count. The initial-count stability lemma of [2] gives a value difference at most the separation of two starting counts. Its coupling uses shared proposed bits until a correction reduces that separation by one. Here every legal time-\(r\) state is within \(O(\sqrt r+1)\) of the central one. The prefix estimate then gives an \(O(\sqrt{\varepsilon T}+1)\) difference between the whole value and that suffix value.

For fixed \(\varepsilon>0\), the suffix convergence proof in [3, §§2–5] uses the following geometric properties. The rounded scaled endpoints converge uniformly on \([\varepsilon,1]\) to \(-c_-\sqrt s,c_+\sqrt s\). The limiting intervals are nested with positive width on the window, and on the original scale their midpoints change by \(O_\varepsilon(T^{-1/2})\) per step before rounding. All of these hold here, since the padding contributes \(O(T^{-1/2})\) on the scaled window and cancels from the midpoint. The compactness argument in [3, §2] uses bounded total absolute proposed drift, the shared-uniform martingale comparison and the conditional binomial stage-cost limit. The proof works with these same endpoints because the path restriction passes to the limit by uniform boundary convergence. The recovery in [3, §§3–5] uses one-sided smoothing, bounded adapted step controls and the projection onto the integer interval. The time-dependent reflection argument applies because the limiting width is positive and nested. The uniform second-moment estimate for the number of corrections uses the limiting width times \(\sqrt T\) and the same squared centered state calculation as above. Comparing the integer overshoot to the unrounded bounds accounts for rounding. In particular the padding creates no term of order \(\sqrt T\) on a fixed window. These steps give the same lower and upper suffix limits as in [3]. Sending \(\varepsilon\downarrow0\) by the prefix comparison proves convergence for (1) and its equality to the continuous value of the limiting moving interval. The known-oracle analysis of [6] extends with the same projection and the reference bit in place of the estimated-rank bit. Its centered square identity uses raw width \(2B+(c_-+c_+)\sqrt t\), so its scaled limit gives (2) for the padded known-distribution problem as well. In what follows the parabolic representation computes the continuous value directly.

## 3. Normalization and uniform relaxation

Rescale space by \(\sigma\) and divide the cost by \(\sigma\). The ratio \(K\) is then the half-width of the interval and the normalization in (2) is unchanged. Define \(G(u)=\mathbb E|Z-u|\) for standard normal \(Z\), and \(H_M(p)=\min_{|u|\le M}[G(u)+pu]\). The bounded-control representation of [4] gives, in these units,
\[
 \mathcal C_M-c_{\mathrm{ref}}
 =\int_0^\infty e^{-r/2}\,
      \left\langle H_M\bigl(P(r/K^2,\cdot)\bigr)\right\rangle_K\,dr,
 \quad 0\le\mathcal C_M-\mathcal C\le 2[G(M)-M],
 \qquad\text{(8)}
\]
where \(\langle\cdot\rangle_K\) uses the density proportional to \(e^{-K^2(x+\mu)^2/2}\) on \([-1,1]\). Translating and rescaling the interval to \([-1,1]\), the gradient \(P(s,x)\) satisfies
\[
 P_s=\tfrac12P_{xx}+K\partial_x H_M(P)-\tfrac{K^2}{2}(x+\mu)P_x,
 \quad P(s,\pm1)=\pm1,\quad P(0,x)=0\quad(-1<x<1).
 \qquad\text{(9)}
\]
The derivative is with respect to the stationary interval variable. Equation (9) follows from [4] with \(s=r/K^2\), where \(r\) is remaining normalized time. The known-control reflection term in (8) is (2).

For \(|p|<1\) the minimizer without a cap is \(-\Phi^{-1}((1+p)/2)\), since \(G'(u)=2\Phi(u)-1\). Thus its Hamiltonian is \(H(p)\) as above. The bound \(0\le H_M(p)-H(p)\le G(M)-M\) on \([-1,1]\) is in [4]. Also \(|H_M'(p)|\le |H'(p)|\) there when \(|p|<1\), by clipping the minimizing argument. For this proof take \(M=\sqrt{10\log(1/K)}\) for small \(K\). Then \(KM\to0\) and \(G(M)-M\le2\varphi(M)=O(K^5)\).

Put \(d(x)=1-|x|\). For \(x\in(-1,1)\),
\[
 H'(x)=-\Phi^{-1}((1+x)/2),\qquad
 H''(x)=-\frac{1}{2\varphi(\Phi^{-1}((1+x)/2))}.
\]
A Gaussian tail bound gives
\[
 d|H'|+d^2|H''|+d^3|H'''|\le C,
 \qquad
 |H'|\le C d^{-1/2},\qquad |H''|\le C/d .
 \qquad\text{(10)}
\]
For instance if \(z=|\Phi^{-1}((1+x)/2)|\), then \(d=2\overline\Phi(z)\le C\varphi(z)\) and \(d^a z\) is bounded for every fixed \(a>0\). Differentiation gives \(|H'''|=z/(4\varphi(z)^2)\). These estimates also imply a uniform \(1/2\)-Hölder bound for \(H_M\) on \([-1,1]\) and an almost-everywhere bound \(|H_M''|\le C/d\), since the derivative agrees with \(H'\) before clipping and is constant past clipping. The finite-\(M\) derivative is Lipschitz.

Let \(S_s\) be the interval heat semigroup in Section 1. Its sup-norm operator bound is \(Ce^{-\lambda s}\) for some \(\lambda>0\). For its action on a spatial divergence of a bounded function, the bound is \(C(1+s^{-1/2})e^{-\lambda s}\). These estimates follow from the Dirichlet interval heat kernel. Its reflected Gaussian formula gives the \(L^1\) bound on the source derivative for \(s\le1\), by integrating the absolute Gaussian derivatives over translates of a bounded interval. Its sine expansion gives exponential bounds for \(s\ge1\). The divergence acts through minus the source derivative, with no boundary term because the kernel vanishes there. Both kernels are integrable in time, including with a sufficiently small positive exponential weight.

Rewrite the Ornstein–Uhlenbeck term in (9) as
\(-K^2\partial_x[(x+\mu)P]/2+K^2 P/2\). Subtract the affine function \(x\) to get a homogeneous Dirichlet condition. The stationary integral equation on continuous functions uses \(\int_0^\infty S_s\,ds\) applied to these forcing terms. Its Lipschitz constant in the sup norm is \(O(KM+K^2)\), using the heat estimates and the global \(M\)-Lipschitz property of \(H_M\). It is a contraction for all small \(K\), uniformly in \(\mu\), giving a unique stationary function \(\bar P\). The integrated equation shows that \(\bar P\) is \(C^1\) and satisfies the stationary equation. Since \(H_M\) is \(C^1\), \(\bar P\) is \(C^2\). Its derivative satisfies the linear equation
\[
 \bar P''=\bigl[K^2(x+\mu)-2K H_M'(\bar P)\bigr]\bar P'.
\]
It is strictly positive by the boundary conditions and uniqueness for the first-order equation for \(\bar P'\). Thus \(\bar P\in[-1,1]\).

For the parabolic solution minus \(\bar P\), subtract their Duhamel equations and use the same Lipschitz constant in the norm \(\sup_{s\ge0} e^{\eta s}\|\cdot\|_\infty\), for sufficiently small fixed \(\eta>0\). The heat forcing estimate on any finite time interval bounds that norm by the initial term plus a constant strictly below one times the norm itself. Letting the interval grow gives
\[
 \|P(s)-\bar P\|_\infty\le C e^{-\eta s}.
 \qquad\text{(11)}
\]
All constants can be chosen independently of small \(K\), \(\mu\), and the chosen \(M\). For the heat solution \(P^0(s,x)=x-S_s x\), the Duhamel equation directly gives
\(\sup_{s\ge0}\|P(s)-P^0(s)\|_\infty=O(K)\), because \(|P|\le1\) and \(H_M\) is uniformly bounded on that range. This maximum bound for \(P\) is inherited from [4] or follows by parabolic comparison. The heat solution satisfies \(|P^0(s,x)|\le|x|\) by odd symmetry and the half-interval comparison principle.

## 4. Stationary expansion

Let \(\mathcal A f=f-\langle f\rangle\) center a function under the uniform probability measure. Integrate the stationary equation once and use \(\langle\bar P'\rangle=1\). The result is
\[
 \bar P'(x)=1-2K\mathcal A[H_M(\bar P)](x)
   +K^2\mathcal A[B_\mu(\bar P)](x),\qquad
 B_\mu(P)(x)=\int_0^x(y+\mu)P'(y)\,dy.
 \qquad\text{(12)}
\]
Monotonicity of \(\bar P\) and its boundary values give \(B_\mu(\bar P)=O(1)\). Hence \(\bar P'-1=O(K)\) and \(\bar P-x=O(Kd(x))\), uniformly. This relative endpoint estimate allows use of the singular derivatives in (10). Along the whole line segment between \(x\) and \(\bar P(x)\), the endpoint distance is at least a fixed multiple of \(d(x)\). In particular \(H(\bar P)-H(x)=O(K)\) uniformly.

Using \(\|H_M-H\|_\infty=O(K^5)\), expand (12) twice. The successive remainders for \(\bar P'\) are \(O(K^2)\) and \(O(K^3)\), and integrating from the closer endpoint gains a factor \(d(x)\). Explicitly,
\[
 \begin{aligned}
 \bar P(x)&=x+K w(x)+K^2 v_\mu(x)+O(K^3 d(x)),\\
 w'&=-2\mathcal A H,\qquad
 v_\mu'=-2\mathcal A(H'w)+\mathcal A(x^2/2+\mu x),\\
 w(\pm1)&=v_\mu(\pm1)=0.
 \end{aligned}
 \qquad\text{(13)}
\]
For the second step, \(H(\bar P)=H+K H'w+O(K^2)\) uniformly by (10) and the relative error, while \(B_\mu(\bar P)=x^2/2+\mu x+O(K)\). Taylor expansion one more time gives
\(H_M(\bar P)=H+K H'w+K^2(H'v_\mu+H''w^2/2)+O(K^3)\)
uniformly, since the error products in (10) are bounded. The density for \(\langle\cdot\rangle_K\) relative to \(dx/2\) has expansion
\[
 1+\tfrac{K^2}{2}(1/3-x^2-2\mu x)+O(K^4).
\]
The \(\mu x\) term integrates to zero against even \(H\). Also \(w\) is odd and \(v_\mu-v_0=\mu(x^2-1)/2\) is even, so the contribution of this last term to \(\langle H'v_\mu\rangle\) vanishes.

Write \(Q=H-\langle H\rangle\). Integration by parts in (13) yields \(\langle H'w\rangle=2\langle Q^2\rangle\), and
\[
 \left\langle H'v_\mu+\tfrac12H''w^2\right\rangle
 =4\langle Q^3\rangle-\tfrac12\operatorname{Cov}(H(U),U^2).
\]
Indeed \(\langle H'v_\mu\rangle=-\langle H v_\mu'\rangle
=2\langle QH'w\rangle-\operatorname{Cov}(H,U^2)/2\).
The other term gives \(-\langle H' w w'\rangle=2\langle QH'w\rangle\).
Then \(\langle QH'w\rangle=-\langle Q^2 w'\rangle/2=\langle Q^3\rangle\).
All endpoint terms vanish by (10), boundedness of \(H\), and the endpoint zeros. The remaining Gaussian density correction supplies another \(-\operatorname{Cov}(H,U^2)/2\). Consequently
\[
 \left\langle H_M(\bar P)\right\rangle_K
 =\langle H\rangle+2K\operatorname{Var}(H(U))
    +K^2[4\langle Q^3\rangle-\operatorname{Cov}(H(U),U^2)]+O(K^3).
 \qquad\text{(14)}
\]

## 5. The initial heat transient

Changing variables \(r=K^2s\) in (8), the integral is twice the stationary average plus
\[
 K^2\int_0^\infty e^{-K^2s/2}
       \left\langle H_M(P(s))-H_M(\bar P)\right\rangle_K\,ds .
 \qquad\text{(15)}
\]
The bracket has uniform exponential decay by (11) and the uniform Hölder bound in (10). We show that (15) is \(K^2J_0+O(K^3)\), so the transient contributes already at quadratic order.

Let \(b=\bar P-x\), which is \(O(Kd(x))\), and \(q^0(s)=P^0(s)-x=-S_s x\). Subtract homogeneous heat evolution for \(q^0\) from the equation for \(P-\bar P\). The initial discrepancy is \(-b\). The new forcing is the divergence of \(K[H_M(P)-H_M(\bar P)]\) plus a term of order \(K^2\) from the Ornstein–Uhlenbeck part in conservative form. All the bounded factors decay exponentially by (11) and the uniform Hölder bound. Convolving with the heat kernels used above gives
\[
 \|(P(s)-\bar P)-q^0(s)\|_\infty\le C K e^{-\eta' s}
\]
for a fixed \(\eta'>0\).

The function \(P^0+b\) has endpoint distance at least \(d(x)/2\) for small \(K\). To compare \(H_M(P)\) with \(H_M(P^0+b)\) in spatial \(L^1\), write \(\delta=C K e^{-\eta's}\). On \(d(x)\le4\delta\), boundedness gives \(O(\delta)\) after integration. Else the entire line segment between these two arguments has endpoint distance at least \(d(x)/4\), and (10) bounds the pointwise difference by \(C\delta d(x)^{-1/2}\). This yields a total \(O(\delta)\).

It remains to compare the two increments \(H_M(P^0+b)-H_M(P^0)\) and \(H_M(x+b)-H_M(x)\). The arguments between the respective points and their translates stay at distance at least \(d(x)/2\) from the endpoints. Integrating the bound on \(|H_M''|\) in (10) shows that the difference of increments is bounded by \(C|b||P^0-x|/d(x)\), hence by \(C K e^{-\eta' s}\). Thus the integrated transient differs from the heat transient with Hamiltonian \(H_M\) by \(O(K)\). Replacing \(H_M\) by \(H\) in that heat transient costs at most the integral of
\(\min(2[G(M)-M],C e^{-\eta's})\). This is \(O(K^5\log(1/K))\). Replacing the discount and the density by one and the uniform probability measure affects the integral by \(O(K^2)\), using exponential domination. These estimates prove the claimed error in (15).

On \((0,1)\), \(0<S_s x<x\) for \(s>0\) by strict comparison with the stationary function and zero boundary. Concavity of \(H\) there bounds \(H(x-S_s x)-H(x)\) strictly between the chord estimate \(S_s x\, [H(0)-H(x)]/x\) and the tangent estimate \((S_s x)(-H'(x))\). The heat integral \(\int_0^\infty S_s x\,ds=(x-x^3)/3\) solves the zero-boundary Poisson equation on the half-interval. This proves (6), with the upper value simplified by integration by parts.

Under the substitution \(x=2\Phi(z)-1\), the moments have the formula
\[
 \langle H^j\rangle
 =2^j\int_{\mathbb R}\varphi(z)^{j+1}\,dz
 =\frac{2^j}{(2\pi)^{j/2}\sqrt{j+1}}.
\]
Thus \(\langle H\rangle=1/\sqrt\pi\),
\(\operatorname{Var}(H)=\pi^{-1}(2/\sqrt3-1)\), and the third centered moment is as in (5). For the mixed moment \(\langle x^2 H(x)\rangle\), the same substitution gives \(\langle H\rangle\) times \(\mathbb E(2\Phi(Z_0)-1)^2\) with \(Z_0\sim N(0,1/2)\). Using two independent \(N(0,1)\) variables \(X,Y\), this expectation is the sign product of \(Z_0-X\) and \(Z_0-Y\), whose correlation is \(1/3\). For a centered normal pair with correlation \(r\), the two signs differ with probability \(\arccos(r)/\pi\). This follows by expressing the pair as projections of an isotropic planar Gaussian onto axes separated by angle \(\arccos(r)\). The expectation is \(2\arcsin(r)/\pi\), giving (5). The lower integral in (6) is
\(\tfrac13[(2/3)H(0)-\langle H\rangle+\langle U^2H(U)\rangle]\), so the bounds on \(\mathcal B\) need only the closed expressions. Equations (8), (14) and (15) now prove (4).

## 6. Center shifts

For this section let \(\bar P_\mu\) denote the stationary profile at center parameter \(\mu\) and \(D=\bar P_\mu-\bar P_0\). Subtract (12) at the two centers. Since \(D(\pm1)=0\), its sup norm at \(x\) is at most \(d(x)\|D'\|_\infty\). Combining the uniform relative endpoint estimates with (10) gives
\(\|H_M(\bar P_\mu)-H_M(\bar P_0)\|_\infty\le C\|D'\|_\infty\).
Also \(B_\mu(\bar P_\mu)-B_0(\bar P_0)\) is bounded by \(O(1)+O(\|D'\|_\infty)\). Absorbing the terms with small factors \(K,K^2\) in the difference equation shows \(D'=O(K^2)\).

Next the same equation and (13) give \(D'=\mu K^2 x+O(K^3)\), and hence \(D=\mu K^2(x^2-1)/2+O(K^3d(x))\). Substitute this once more into the difference equation, using \(H_M=H+O(K^5)\), the relative endpoint Taylor bound, and \(\bar P_\mu'=1+K w'+O(K^2)\). The result is
\[
 D'=\mu K^2 x+\mu K^3\bigl[-2\mathcal A(H'(x)(x^2-1)/2)+w(x)\bigr]+O(K^4).
\]
The bracket is odd. Integrating from the endpoints shows that \(D\) through order \(K^3\) is even, with an \(O(K^4d(x))\) remainder. Since \(\bar P_0\) is odd by symmetry, pairing this difference with \(H'(\bar P_0)\) has zero uniform average through order \(K^3\). The Taylor remainder from the squared difference is \(O(K^4)\) by (10). The leading difference of the normalized Gaussian densities relative to \(dx/2\) is \(-\mu K^2 x\), which also integrates to zero against the even \(H_M(\bar P_0)\). Density differences of order \(K^2\) multiplied by the profile dependence contribute \(O(K^4)\). Thus the stationary averages at the two centers differ by \(O(K^4)\).

For the parabolic profiles at the two centers, their Duhamel equations and identical initial data give a uniform \(O(K^2)\) sup-norm difference. The change of the drift parameter introduces bounded forcing of order \(K^2\), and all other differences are absorbed using the unweighted time kernel and \(KM\to0\). Both profiles remain within \(O(K)\) of \(P^0\), where \(|P^0|\le |x|\). Off a strip of width \(O(K)\) at the endpoints use \(|H_M'|\le C d(x)^{-1/2}\) to control the spatial \(L^1\) effect of the \(O(K^2)\) difference. On the strip the \(1/2\)-Hölder bound gives \(O(K)\) there, integrated over width \(O(K)\). Thus the transient bracket difference in (15), including the stationary and density terms, is uniformly \(O(K^2)\). It is also exponentially small in \(s\), independently of \(K\). Integrating the minimum of the two bounds makes the excess-cost difference \(O(K^4\log(1/K))\). Finally, (2) gives
\[
 c_{\mathrm{ref}}(K,\mu)=1/K-K/3+(2/45+\mu^2/3)K^3+O(K^5)
\]
by a uniform Taylor expansion. Equation (7) follows.

The centered corridor minimizes the cost at every fixed positive width. In the finite-initial-time Brownian problem of [3], use its canonical Brownian filtration for two nearly minimizing controls at different centers. Their convex combination drives the convex combination of the two controlled states, feasible for the correspondingly interpolated center because the endpoints are affine in the center. The integral loss and the total variation of the singular part are convex in the control. Taking infima and then the initial time to zero shows convexity in \(\mu\). Reflection of Brownian motion and the control proves evenness, so \(\mu=0\) is a minimizer. The cubic term in (7) quantifies the cost difference at fixed nonzero shift in the narrow-width limit.

## References

[1] Yu Gui, Rina Foygel Barber, and Cong Ma. *The cost of enforcing long-run coverage: a phase transition in online conformal prediction*, arXiv:2611.21542v1, especially §§1.4, 2 and Appendix D. <https://arxiv.org/abs/2611.21542v1>.

[2] earlier research manuscript. *Exact finite-horizon minimax values for unknown-distribution online conformal coverage*. Fixed archive at commit bb30fe2. Manuscript.

[3] earlier research manuscript. *Exact critical variational limit for unknown-distribution conformal prediction*, especially §§1–6. Fixed manuscript.

[4] earlier research manuscript. *Fixed-interval parabolic evaluation of the critical constant*, especially §§1–5. Fixed manuscript.

[5] earlier research manuscript. *Exact asymptotics for wide symmetric corridors*. Fixed manuscript.

[6] earlier research manuscript. *Exact critical cost for a known distribution*. Fixed manuscript.
