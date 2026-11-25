---
title: "Effective error certificates for Sibuya quantum resetting"
subtitle: "Finite nonresonance checks, explicit remainder constants, and a critical time scale"
lang: en
geometry: margin=1in
fontsize: 11pt
---

## Abstract

The finite-dimensional Sibuya reset reduction has a sharp asymptotic exponent and explicit oscillatory leading coefficients under a qualitative condition on the entire unit circle. We turn that result into an all-time, computable error certificate. A finite mesh certifies a nonresonance margin. That margin, a validated stable-power envelope and peripheral separation give a pole-free slit collar and explicit constants for both the main decay and the leading-term remainder. The construction retains arbitrary finite-dimensional noncommuting quantum channels and stable Jordan blocks. A depolarizing example exhibits the critical time scale $\mu^{-1/\gamma}$ as the certified margin $\mu$ tends to zero.

## 1. Model and quantitative problem

Use the occupied-step Sibuya model of the fixed predecessor. The finite Hilbert space dimension is $d_H\ge2$, and $\Phi,R$ are completely positive trace-preserving channels. A waiting time of length $\ell$ gives ordered cycle $R\Phi^{\ell-1}$. The independent waiting times have probabilities $p_\ell=(-1)^{\ell-1}\binom{\gamma}{\ell}$, where $0<\gamma<1$. Their survival probabilities are $s_t=(1-\gamma)_t/t!$, with $s_0=1$. Let $\rho_t^{\mathrm{par}}$ denote the averaged state under partial reset and $F_t(\rho)$ the matching complete-reset average with reset and initial state $\rho$.

Let $\mathcal V_{\mathbb C}$ be the complex traceless matrix space. Use its Hilbert--Schmidt norm and the corresponding induced operator norm throughout the estimates. Set $T=\Phi|_{\mathcal V_{\mathbb C}}$ and $A=R|_{\mathcal V_{\mathbb C}}$. Fix a density $\sigma$ of $\Phi$ and define $b=R(\sigma)-\sigma$ and $c=\rho_0-\sigma-b$. Write
$$
M(w)=\sum_{\ell\ge1}p_\ell w^\ell T^{\ell-1},\qquad
K=AM,\qquad H=(I-K)^{-1},\qquad
Z(w)=(I-wT)^{\gamma-1}.
$$
The assumption is the original condition (W): $I-K(w)$ is invertible at every $|w|=1$. The mean embedded channel $\sum_{\ell\ge1}p_\ell R\Phi^{\ell-1}$ then has a unique fixed density $\rho_{\mathrm{eff}}$. The error is $E_t=\rho_t^{\mathrm{par}}-F_t(\rho_{\mathrm{eff}})$. If $d_H=1$, this error is identically zero.

Let $\Lambda$ be the peripheral spectrum of $T$, $Q_\lambda$ the corresponding projections and $P_{\mathrm{st}}$ the complementary stable projection. The predecessor already identifies the terms
$$
D_\lambda=Q_\lambda\!\left[H(\lambda^{-1})c+
(1-\lambda^{-1})^{-\gamma}(H(\lambda^{-1})-H(1))b\right]\qquad(\lambda\ne1)
$$
and, if $1\in\Lambda$,
$$
D_1=Q_1H(1)c-Q_1H(1)A Q_1 H(1)b.
$$
The paper explicitly asks for computable constants in its concluding discussion. Here we obtain such constants, including a finite verification of the nonresonance margin. Fixed predecessor, §9

## 2. Parameters and explicit bound

Choose $R_*>1$ and $C_*\ge0$ so that
$$\|T^jP_{\mathrm{st}}\|\le C_*R_*^{-j}\quad(j\ge0),$$
and a certified $0<\mu\le1$ with $\sigma_{\min}(I-K(w))\ge\mu$ on the unit circle. Define the set of distinct endpoints $\mathcal S=\{1\}\cup\{\lambda^{-1}:\lambda\in\Lambda\}$ and $J=|\mathcal S|$. Let $d$ be the minimum of one and the pairwise distances of distinct endpoints, using $d=1$ for a singleton. Set
$$
B_Z=C_*\left(\frac{2R_*}{R_*-1}\right)^{1-\gamma},\qquad B_M=\gamma B_Z,\qquad
U=1+\|A\|+\sum_{\lambda\in\Lambda}\|Q_\lambda\|+B_M+B_Z+d^{-1},
$$
$$
\kappa=\min\left\{\frac{R_*-1}{2},\frac d8,\frac18,
  \left(\frac{\mu}{6U^2}\right)^{1/\gamma}\right\},
\qquad \beta=\min(2\gamma,1),\qquad B=1+\|b\|+\|c\|.
$$
Both $b=R(\sigma)-\sigma$ and $c=\rho_0-R(\sigma)$ are differences of densities, each of Hilbert--Schmidt norm at most $\sqrt2$. Thus $B<4$ uniformly over initial densities. Set
$$
\begin{aligned}
C_D&=5B U^3\mu^{-2},\\
C_{\mathrm{loc}}&=200B U^8\mu^{-3},\\
C_{\mathrm{out}}&=60B U^3\mu^{-2}/\kappa,\\
C_{\mathrm{rem}}&=
 J C_{\mathrm{loc}}\big(4+2\cdot4^\beta\Gamma(\beta)\big)
 + 2C_{\mathrm{out}}(5/\kappa)^\beta.
\end{aligned}
$$

**Theorem 1.** Under (W), for every initial density and every integer $t\ge0$,
$$
\left\|E_t-s_t\sum_{\lambda\in\Lambda}\lambda^tD_\lambda\right\|_1
 \le \sqrt{d_H}\, C_{\mathrm{rem}}(t+1)^{-\beta}.
$$
In addition $\sum_\lambda\|D_\lambda\|\le C_D$, and
$$
\|E_t\|_1\le\sqrt{d_H}(C_D+C_{\mathrm{rem}})(t+1)^{-\gamma}.
$$
Using $B=4$ makes both bounds uniform over the initial state. In particular the second bound gives an explicit time after which the error is at most any chosen tolerance. The proof also permits any larger value of $U$ and smaller positive value of $\kappa$. The constants trade sharp prefactors for direct finite verification. Section 6 demonstrates that inverse-margin dependence and a diverging near-resonance time scale are intrinsically necessary.

## 3. Effective continuation and local resolvent

The exact generating function from the predecessor is
$$
\widehat E(w)=Z(w)\left[H(w)c+(1-w)^{-\gamma}(H(w)-H(1))b\right].
\tag{1}
$$
It follows by conditioning on the final event and subtracting the complete-reset process. The identity preserves operator order. As in the predecessor, the completely positive trace-preserving restrictions contract the norm $\sup_\theta\|\operatorname{Re}(e^{i\theta}X)\|_1$. Thus $I-K(w)$ is invertible inside the unit disc by the Neumann series, and peripheral modes of the power-bounded $T$ are semisimple. The assumed boundary margin gives $\|H\|\le\mu^{-1}$ in the closed disc by the scalar maximum modulus principle applied to matrix elements in unit directions.

Use the principal continuation past the circle, cutting the outward radial ray at every point of $\mathcal S$. The peripheral parts are explicit:
$$
Z_{\mathrm{per}}=\sum_\lambda Q_\lambda(1-\lambda w)^{\gamma-1},
\qquad
M_{\mathrm{per}}=\sum_\lambda \lambda^{-1}Q_\lambda
  [1-(1-\lambda w)^\gamma].
$$
The stable part has $\|Z_{\mathrm{st}}\|\le B_Z$ and $\|M'_{\mathrm{st}}\|\le B_M$ for $|w|\le1+\kappa$. Indeed the scalar series for the survival probabilities and the derivative of $1-(1-z)^\gamma$ sum at $z=|w|/R_*\le (1+R_*)/(2R_*)$. The stable envelope treats Jordan blocks directly.

A useful scalar estimate is $|a^\gamma-b^\gamma|\le2|a-b|^\gamma$ on any line segment avoiding the negative real cut, with continuous endpoint limits allowed. To prove this, integrate the derivative along the segment. With $\delta=b-a\ne0$, let $t_0$ be the real projection parameter for the closest point on the ambient line to zero. Then $|a+t\delta|\ge|\delta||t-t_0|$. The integral of $|t-t_0|^{\gamma-1}$ on $[0,1]$ is at most $2/\gamma$. Passage to allowed endpoints gives the same bound.

For $1\le|w|\le1+\kappa$ in the slit region, set $\xi=w/|w|$. The radial segment for each branch stays in its continued domain. Applying the scalar estimate gives
$$\|K(w)-K(\xi)\|\le3U^2\kappa^\gamma\le\mu/2.$$
Consequently $H$ exists throughout this collar and has norm at most $2/\mu$ by the resolvent identity or singular-value perturbation.

Fix $\zeta\in\mathcal S$ and write $x=1-w/\zeta$, $r=|x|\le\kappa$. If $\zeta=\lambda^{-1}$ let $Q=Q_\lambda$; otherwise set $Q=0$. Split
$$
Z=Q x^{\gamma-1}+Z_0,\qquad
K(w)-K(\zeta)=-\zeta A Q x^\gamma+K_0.
$$
All other endpoints are at distance at least $d/2$ throughout this neighborhood, and their cuts lie outside it. Their values and derivatives together with the stable bounds give
$$
\|Z_0\|\le3U^2,\quad \|Z\|\le4U^2r^{\gamma-1},\quad
\|K_0\|\le3U^3 r,\quad \|K(w)-K(\zeta)\|\le4U^3r^\gamma .
\tag{2}
$$
For the third bound, each other derivative has scalar norm at most $\gamma(d/2)^{\gamma-1}\le2U$ and the stable derivative has norm at most $B_M$. Multiplication by $A$ gives the stated estimate. The derivatives can be integrated on the segment from the endpoint because the other cuts are disjoint from the local disc.

Put $H_\zeta=H(\zeta)$ and $L_\zeta=-\zeta H_\zeta A Q H_\zeta$. The resolvent identity and its second-order remainder give
$$
\|H-H_\zeta\|\le8U^3\mu^{-2}r^\gamma,\qquad
\|H-H_\zeta-L_\zeta x^\gamma\|\le35U^6\mu^{-3}r^\beta .
\tag{3}
$$
The linear regular term is bounded by $3U^3\mu^{-2}r$. The quadratic term is bounded by $\|H_\zeta\|^2\|H(w)\|\|K-K(\zeta)\|^2\le32U^6\mu^{-3}r^{2\gamma}$. This argument does not use commutation of any pair of channels.

## 4. Explicit transfer to coefficients

Let $\mathcal R(w)=\widehat E(w)-\sum_\lambda D_\lambda(1-\lambda w)^{\gamma-1}$. The displayed formulas for $D$ and the margin bound imply $\sum_\lambda\|D_\lambda\|\le C_D$. For $\zeta\ne1$ put $U_0(w)=(1-w)^{-\gamma}$. In the local disc, $|U_0|\le2U$ and $|U_0(w)-U_0(\zeta)|\le4U^2r$. The bracket $G(w)=H(w)c+U_0(w)(H(w)-H(1))b$ in (1) therefore satisfies
$$\|G(\zeta)\|\le4UB/\mu,\qquad
\|G(w)-G(\zeta)\|\le24B U^4\mu^{-2}r^\gamma .$$
Since $D_\lambda=QG(\zeta)$, the leading contribution cancels. The estimates (2) and the bounded contributions of all other leading terms yield $\|\mathcal R(w)\|\le C_{\mathrm{loc}}r^{\beta-1}$.

At $\zeta=1$, allow $Q=0$ if necessary. Insert (3) in (1) as
$$H-H(1)=L_1x^\gamma+\mathcal H,\qquad
\|\mathcal H\|\le35U^6\mu^{-3}r^\beta.$$
The two leading terms are $Q L_1 b\,x^{\gamma-1}$ and $QH(1)c\,x^{\gamma-1}$. The first regular factor $Z_0 L_1 b$ is bounded by $3B U^4\mu^{-2}$. The remainder $Z x^{-\gamma}\mathcal H b$ is bounded by $140B U^8\mu^{-3}r^{\beta-1}$. The terms $Z_0H(1)c$ and $Z(H-H(1))c$ are bounded by $3BU^2\mu^{-1}$ and $32BU^5\mu^{-2}r^{2\gamma-1}$. All other subtracted leading terms have total bound at most $10BU^4\mu^{-2}$. These bounds imply the same $C_{\mathrm{loc}}r^{\beta-1}$ estimate at $1$, including $\gamma=1/2$.

On the outer circle $|w|=1+\kappa/4$ off the cuts, every endpoint has distance at least $\kappa/4$. Thus $\|Z\|\le2U(4/\kappa)^{1-\gamma}$ and $|(1-w)^{-\gamma}|\le(4/\kappa)^\gamma$. Together with the continuation bound and the leading coefficient sum, this gives $\|\mathcal R(w)\|\le C_{\mathrm{out}}$.

For $t\ge0$ put $n=t+1$ and deform the Cauchy contour to the outer circle with an indentation about each $\zeta$. From the endpoint use rays at angles $\pm\pi/3$ from the outward radial direction. The rays meet the circle at local distance between $\kappa/4$ and $\kappa/2$, since $1+r/2\le|w|\le1+r$. Join them at inner radius $\epsilon_t=\min(\kappa/8,1/n)$ by the circular arc going around the endpoint on the side avoiding the cut. The indentations are mutually disjoint by the definition of $\kappa$. On each small arc, 
$$|w|^{-n}\le (1-\epsilon_t)^{-n}\le \exp(n\epsilon_t/(1-\epsilon_t))\le4.$$
Thus its contribution is at most $4C_{\mathrm{loc}}\epsilon_t^\beta\le4C_{\mathrm{loc}}n^{-\beta}$. On each ray $\log |w|\ge r/4$, giving a contribution bounded by
$$
C_{\mathrm{loc}}\int_0^\infty e^{-nr/4}r^{\beta-1}\,dr
= C_{\mathrm{loc}}(4/n)^\beta\Gamma(\beta).
$$
On the remaining outer arc $\log(1+\kappa/4)\ge\kappa/5$. With outer radius less than two, its full Cauchy contribution is bounded by $2C_{\mathrm{out}}(5/\kappa)^\beta n^{-\beta}$. This uses $v^\beta e^{-v}\le1$ for $v\ge0$ and $0<\beta\le1$. All estimates apply to $t=0$ as well.

Finally $\|X\|_1\le\sqrt{d_H}\|X\|_2$. The leading coefficients of $(1-\lambda w)^{\gamma-1}$ are $\lambda^t s_t$, and $s_t=\prod_{j=1}^t(1-\gamma/j)\le(t+1)^{-\gamma}$. This proves both conclusions of Theorem 1.

## 5. Finite validation of parameters

A validated peripheral split is an input. The stable spectral radius is strictly less than one, so one can choose a number $\rho_s$ strictly between it and one. The Cauchy formula for the restriction to the stable subspace gives the envelope with $R_*=\rho_s^{-1}$ and
$$
C_*=\rho_s\sup_{|z|=\rho_s}
   \|(zI-T_{\mathrm{st}})^{-1}P_{\mathrm{st}}\|.
$$
A larger upper bound is equally valid. On a finite mesh, lower bounds on the smallest singular value of $zI-T_{\mathrm{st}}$ extend by the distance to the nearest mesh point, because the change in the matrix is $(z-z_j)I$. Thus a strictly positive bound eventually results when enclosure errors and mesh spacing are reduced. The empty stable subspace may be assigned $C_*=0$ and any $R_*>1$.

For the boundary margin, if $w,z$ are on the unit circle and $|w-z|\le1$, the same scalar estimate and stable derivative bound give
$$\|K(w)-K(z)\|\le3U^2|w-z|^\gamma.$$
Here the connecting chord stays in the closed disc. Sample at $m\ge4$ equispaced points $w_j$. Suppose a computed approximation $\widetilde K_j$ has error at most $\eta$ in the induced Hilbert--Schmidt norm and a verified lower bound $v_j$ for $\sigma_{\min}(I-\widetilde K_j)$. Then one may use any positive $\mu\le1$ not exceeding
$$\min_j v_j-\eta-3U^2(\pi/m)^\gamma.$$
This follows from the unit-circle mesh distance and the singular-value perturbation inequality. Approximate $K(w_j)$ by its first $L$ terms. The tail has norm at most $\sqrt{d_H}s_L$, since each restricted $R\Phi^{\ell-1}$ has induced Hilbert--Schmidt norm at most $\sqrt{d_H}$. For this last fact apply trace-norm contraction to the Hermitian real and imaginary parts and use the norm comparison on each part. The error of arithmetic enclosures is added to the truncation bound.

Under (W) the true minimum is positive. For channel inputs admitting arbitrarily accurate certified enclosures and a validated spectral split, refinement of mesh, truncation and enclosure errors terminates with a positive certificate. This procedure does not assert that exact peripheral membership can be diagnosed from noisy numerical eigenvalues. For rational $\gamma=p/q$ and rational input certificates, the companion calculator uses the elementary estimates $\Gamma(\beta)\le1/\beta+1$, $4^\beta\le4$ and $(5/\kappa)^\beta\le5/\kappa$. It chooses a dyadic $\kappa$ using the exact integer-power test $\kappa^p\le(\mu/(6U^2))^q$, then finds a certified tolerance time by integer binary search. Thus its returned time uses only exact rational arithmetic.


The inputs can also be bounded using only the stable spectral radius, dimension, and the supplied separation lower bound. Write $D=d_H^2-1$ and suppose $r_s<1$ bounds the stable eigenvalue moduli. Put $\rho_s=(1+r_s)/2$, $g=(1-r_s)/2$ and $R_*=\rho_s^{-1}$. Every eigenvalue of $T$ is at distance at least $g$ from $|z|=\rho_s$. Hence
$$|\det(zI-T)|\ge g^D,\qquad
\|(zI-T)^{-1}\|\le(\rho_s+\sqrt{d_H})^{D-1}/g^D.$$
The second estimate follows by expressing the determinant in singular values and bounding the largest singular values by $\rho_s+\|T\|$. Integrate the full resolvent on that circle, using $T^jP_{\mathrm{st}}=(2\pi i)^{-1}\oint z^j(zI-T)^{-1}\,dz$. Thus one can take
$$C_*=\rho_s(\rho_s+\sqrt{d_H})^{D-1}/g^D.$$
For every peripheral $\lambda$ its projection is a limit of Cesàro averages of $\lambda^{-j}T^j$. The semisimple peripheral modes and decaying stable modes give this limit directly. Every power of $T$ has Hilbert--Schmidt induced norm at most $\sqrt{d_H}$ by trace contraction on Hermitian components, so $\sum_\lambda\|Q_\lambda\|\le D\sqrt{d_H}$. These choices give a version of the certificate using coarse spectral bounds without requiring accurate norms of eigenvector matrices.

## 6. A critical scale and margin obstruction

Take $\Phi=I$ on a qubit and $R(\rho)=(1-\delta)\rho+\delta I/2$, $0<\delta<1$. Then $T=I$, $A=(1-\delta)I$ on the traceless space and the true margin is $\mu=\delta$. Indeed $K(w)=(1-\delta)[1-(1-w)^\gamma]I$ and on the circle the generating function in brackets has magnitude at most one. At $w=1$ equality gives exactly $\delta$. For any nonstationary $\rho_0$, write $E_t=f_t(\delta)(\rho_0-I/2)$. The leading term of the predecessor, or Theorem 1, gives $\lim_{t\to\infty}t^\gamma f_t(\delta)=1/(\delta\Gamma(1-\gamma))$. Hence a uniform rate bound necessarily has a prefactor at least of order $\mu^{-1}$ in this family.

The entire critical profile admits a scalar quantitative bound that is independent of $\delta$ and $\gamma$. Put $n=t+1$, $h=\delta/(1-\delta)$ and write $E_\gamma(u)=\sum_{j\ge0}u^j/\Gamma(1+j\gamma)$. Then
$$0\le (1-\delta)f_t(\delta)-E_\gamma(-h n^\gamma)\le 2/n.$$
In particular $\delta_t t^\gamma\to a$ implies $f_t(\delta_t)\to E_\gamma(-a)$. The error order $1/n$ in the displayed corrected profile cannot be uniformly improved.

To prove the bound, let $N_t$ count completed events by time $t$. Then $f_t(\delta)=\mathbb E(1-\delta)^{N_t}$. The survival and complete-cycle generating functions give
$$(1-\delta)\sum_{t\ge0}f_t z^t=\frac{(1-z)^{\gamma-1}}{(1-z)^\gamma+h}.$$
For $x>0$, the scalar Laplace transform with variable $x$ has a positive Stieltjes representation
$$\frac{x^{\gamma-1}}{x^\gamma+h}
=\int_0^\infty \frac{\rho_h(u)}{x+u}\,du,\qquad
\rho_h(u)=\frac{h\sin(\pi\gamma)\,u^{\gamma-1}}
{\pi\big(u^{2\gamma}+2h\cos(\pi\gamma)u^\gamma+h^2\big)}.$$
Indeed, integrate $g(z)/(z-x)$ on a keyhole around the negative real axis, where $g(z)=z^{\gamma-1}/(z^\gamma+h)$. There are no poles of $g$ on the principal branch. At zero $g=O(|z|^{\gamma-1})$ and at infinity $g=O(|z|^{-1})$, so the small and large circles vanish. The two sides of the cut give the negative imaginary part of $g(-u+i0)$ divided by $\pi$, equal to the displayed density. As $x\to\infty$, the left side multiplied by $x$ tends to one. By monotone convergence, $\rho_h$ has total mass one. Applying the Laplace transform to the Mittag--Leffler series for sufficiently large positive $x$ gives the same $g(x)$: the integrals of the termwise absolute values sum geometrically when $x^\gamma>h$. Uniqueness of the Laplace transform yields
$$E_\gamma(-h y^\gamma)=\int_0^\infty e^{-yu}\rho_h(u)\,du\quad(y\ge0).$$

The coefficient formula at $z=0$ in the Stieltjes representation now gives
$$(1-\delta)f_t=\int_0^\infty(1+u)^{-n}\rho_h(u)\,du.$$
The expansion can be integrated termwise on compact subdiscs, or for real $0\le z<1$ by monotone convergence. For each $u\ge0$, telescoping the powers of $(1+u)^{-1}$ and $e^{-u}$ gives
$$0\le(1+u)^{-n}-e^{-nu}\le \frac n2 u^2(1+u)^{-n}.$$
Here $1-(1+u)e^{-u}=\int_0^u v e^{-v}dv\le u^2/2$. For $n\ge3$ the last bound has maximum $(2/n)(1-2/n)^{n-2}\le2/n$. For $n=1,2$ use that the original difference is at most one. Integrating against $\rho_h$ proves the uniform estimate.

To see sharpness, fix $a>0$ and choose $\delta_n=a/(n^\gamma+a)$. Then $h n^\gamma=a$ exactly. Under the substitution $v=nu$ one has $\rho_{a/n^\gamma}(u)\,du=\rho_a(v)\,dv$. Moreover
$$n\big((1+v/n)^{-n}-e^{-v}\big)\longrightarrow \tfrac12 v^2e^{-v}$$
for fixed $v$, and the integrand is bounded by two. Dominated convergence shows that $n$ times the corrected profile error converges to $\tfrac12\int_0^\infty v^2 e^{-v}\rho_a(v)dv>0$. At $a=0$ the critical limit is one. In particular no fixed fractional reduction of the initial error is guaranteed at times $t=o(\mu^{-1/\gamma})$ as the margin goes to zero. The general all-time bound remains conservative in its parameter dependence.

## 7. Scope and verification

The new statements concern computable constants and effective margin validation under the same assumptions as the archived asymptotic theorem. They retain all peripheral frequencies, arbitrary stable Jordan blocks and the original order of channel multiplication. The scalar critical profile illustrates the importance of the certified margin. It does not claim priority for the Mittag--Leffler law in renewal theory. The nearest source and its prior literature audit are fixed in the companion record. The finite verification script checks exact rational renewal coefficients in a scalar specialization. The general bound rests on the analytic argument, and Lean verification is tracked separately.
