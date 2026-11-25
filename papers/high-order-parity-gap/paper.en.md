---
title: "High-order parity gaps and crossover radii for noisy qubit designs"
lang: en
---

# High-order parity gaps and crossover radii for noisy qubit designs

## Abstract

For Haar moments of a noisy qubit, the relative Loewner errors at orders \(2k\) and \(2k+1\) coincide above a contraction-dependent Bloch radius and differ below it. We determine the large-order location of this crossover, including joint limits in which the contraction vanishes. At fixed contraction the radius is of order \(k^{-1/2}\), while the largest error gap occurs on the smaller \(k^{-1}\) scale and has an explicit one-dimensional limiting profile. For contraction approaching the identity, the crossover and the maximum gap have three regimes according to \(k\) times the radial contraction deficit. The maximal gap has a sharp plateau with limit \(1/e\) after multiplication by \(2k\), above an explicit threshold in this rescaled deficit.

## 1. Error formula and results

Let \(r\in[0,1)\) be a qubit Bloch radius and \(\lambda\in[0,1]\) its radial contraction factor. We use the relative Loewner error between the noiseless and noisy Haar moments. For a given radius \(r\), this is the least \(\epsilon\ge0\) for which the noisy moment lies between \(1-\epsilon\) and \(1+\epsilon\) times the ideal moment in the positive-semidefinite order. The model includes a depolarizing channel before or after Haar conjugation. For a pre-conjugation unital channel and a truncated ball of inputs, \(\lambda\) can be taken as the smallest singular value of its Bloch matrix, by the monotonicity and extremal result in [1].

The archived exact formula [1, Section 2] at order \(m\) is
\[
E_m(r,\lambda)=
\max\{G_{\lfloor m/2\rfloor}(r,\lambda),1-A_m(r,\lambda)\},
\]
where
\[
G_k(r,\lambda)=\left(\frac{1-\lambda^2r^2}{1-r^2}\right)^k-1,
\qquad
A_m(r,\lambda)=\frac{h_m(\lambda^2r^2)}{h_m(r^2)},
\]
and
\[
h_m(r^2)=\frac{(1+r)^{m+1}-(1-r)^{m+1}}{2r(m+1)} .
\]
The expressions extend continuously at zero. For \(k\ge2\), \(0\le\lambda<1\), the source proves there is a unique \(r_k(\lambda)\in(0,1)\) satisfying
\[
G_k(r_k,\lambda)=1-A_{2k+1}(r_k,\lambda),
\]
and the gap
\(\Delta_k(r,\lambda)=E_{2k+1}(r,\lambda)-E_{2k}(r,\lambda)\)
is strictly positive exactly when \(0<r<r_k(\lambda)\). It vanishes at zero and at all radii \(r\ge r_k(\lambda)\). We let \(D_k(\lambda)=\max_{0\le r<1}\Delta_k(r,\lambda)\), which is attained by continuity and this bounded support interval. Put \(m=2k\).

**Theorem 1 (crossover).** Let \(\lambda_k\in[0,1)\), \(\delta_k=1-\lambda_k\), and \(\theta_k=k\delta_k\).

- If \(\theta_k\to0\), then \(r_k(\lambda_k)\to1/2\).
- If \(\theta_k\to\theta\in(0,\infty)\), then \(r_k(\lambda_k)\to R_\theta\). Here \(R_\theta\in(0,1/2)\) is the unique positive root of
\[
\exp\!\left(\frac{2\theta r^2}{1-r^2}\right)
+\exp\!\left(-\frac{2\theta r}{1+r}\right)=2. \tag{1}
\]
- If \(\theta_k\to\infty\), then \(k(1-\lambda_k^2)r_k(\lambda_k)^2\to\log 2\).

**Theorem 2 (maximal parity gap).** In the same notation:

1. If \(\lambda_k\to\lambda_0<1\), then \(2kD_k(\lambda_k)\to\max_{y\ge0}\Psi_{\lambda_0}(y)\), where for \(y>0\)
\[
\Psi_\lambda(y)=y\,\frac{\sinh(\lambda y)}{\lambda\sinh y}
\bigl(\coth y-\lambda\coth(\lambda y)\bigr).
\tag{2}
\]
The \(\lambda=0\) factors are interpreted as \(y/\sinh y\) and \(1/y\) for the ratio and the product \(\lambda\coth(\lambda y)\), respectively. Set \(\Psi_\lambda(0)=0\). This profile is the limit of \(2k\Delta_k(y/(2k),\lambda_k)\).
2. If \(\theta_k\to0\), then \(D_k(\lambda_k)/\delta_k\to1/3\).
3. If \(\theta_k\to\theta\in(0,\infty)\), put \(z_\theta=2\theta R_\theta/(1+R_\theta)\) and \(z_\theta'=\min(1,z_\theta)\). Then \(2kD_k(\lambda_k)\to z_\theta' e^{-z_\theta'}\).
4. If \(\lambda_k\to1\) and \(\theta_k\to\infty\), then \(2kD_k(\lambda_k)\to1/e\).

In item 3 the limit equals \(1/e\) exactly for
\[
\theta\ge\theta_*:=1+\frac{1}{2\log(2-e^{-1})}. \tag{3}
\]
The contraction \(\lambda_k=1\) gives identically zero errors and is outside the crossover definition.

## 2. Two estimates for adjacent orders

Throughout the proof \(r>0\) unless a continuity statement is used. The finite-order coefficient comparison of [1] gives \(A_{m+1}\le A_m\). Since the two orders share \(G_k\), their gap has
\[
0\le\Delta_k\le A_m-A_{m+1},
\quad
\Delta_k=A_m-A_{m+1}\ \text{if }G_k\le1-A_m.
\tag{4}
\]
Equivalently, the exact gap is
\[
\Delta_k=\min\{A_m-A_{m+1},(1-A_{m+1}-G_k)_+\},
\]
where \(x_+=\max(x,0)\). This includes the case near the crossover in which the even order is clipped by \(G_k\).

For \(0<\lambda<1\) let \(\delta=1-\lambda\), set \(N=m+1\), and write
\[
d(r,\lambda)=\frac{1+\lambda r}{1+r}=1-\frac{\delta r}{1+r},\qquad
T(r)=\log\frac{1+r}{1-r},\qquad
g_N=\frac{1-e^{-N T(\lambda r)}}{1-e^{-N T(r)}}.
\]
The exact formula is
\[
A_m=\lambda^{-1}d(r,\lambda)^N g_N. \tag{5}
\]
For fixed \(r,\lambda\), \(g_N\le1\) and it increases as a function of real \(N>0\). In fact its logarithmic derivative is the difference of \(t/(e^{Nt}-1)\) at \(t=T(\lambda r)\) and \(t=T(r)\). This function of \(t>0\) decreases, and \(T(\lambda r)<T(r)\). Hence \(A_{m+1}/A_m\ge d\), giving
\[
0\le\Delta_k\le A_m-A_{m+1}\le\frac{\delta r}{1+r}\,A_m. \tag{6}
\]
Continuity gives (6) at \(\lambda=0\). For \(\lambda>0\), (5) also gives
\[
A_m\le\lambda^{-1}\exp\!\left[-\frac{(m+1)\delta r}{1+r}\right]. \tag{7}
\]
For \(\lambda\le1/2\) we may use (7) with \(\lambda=1/2\), since \(A_m\) increases with \(\lambda\).

We next sharpen (6) when \(\lambda\to1\), \(m r\to\infty\) and \(r\le r_0<1\). These conditions can include \(r\to0\). Eventually \(\lambda\ge1/2\), and
\(0\le T(r)-T(\lambda r)\le C\delta r\), while \(T(\lambda r)\ge r\). The derivative of \(\log(1-e^{-Nt})\) shows
\[
|\log g_N|\le C\delta N r\,e^{-c N r}. \tag{8}
\]
The constants here and below may depend on \(r_0\).

For adjacent orders, put
\(f_N(t)=\log(1-e^{-(N+1)t})-\log(1-e^{-Nt})\).
Then
\(\log(g_{N+1}/g_N)=f_N(T(\lambda r))-f_N(T(r))\).
The derivative \(f_N'(t)\) is the difference of \(s/(e^{st}-1)\) at \(s=N+1,N\). Its magnitude is bounded by
\[
|f_N'(t)|\le C(1+Nt)e^{-Nt}
\quad\text{for }Nt\ge1,\quad 0<t\le T(r_0),
\]
by the mean-value theorem in \(s\). Indeed the derivative in \(s\) has numerator \(e^{st}-1-st e^{st}\) and denominator \((e^{st}-1)^2\). Along the interval between \(T(\lambda r)\) and \(T(r)\), the bound tends to zero as \(Nr\to\infty\). Thus \(\log(g_{N+1}/g_N)=o(\delta r)\), an estimate relative to the actual contraction even if \(\delta\) tends to zero very quickly. Applying (5) to successive orders gives
\[
A_m-A_{m+1}=\frac{\delta r}{1+r}\,A_m(1+o(1))
\tag{9}
\]
under these conditions. In detail, \(A_{m+1}/A_m=d\,\exp(o(\delta r))=1-\delta r/(1+r)+o(\delta r)\). This establishes (9) uniformly along every sequence in the stated regime.

## 3. Crossover regimes

First let \(\theta_k\to\theta\in[0,\infty)\), so \(\lambda_k\to1\). For each fixed \(r\in(0,1)\), (5) and (8) imply
\[
\frac{\log A_j(r,\lambda_k)}{2k\delta_k}\to-\frac{r}{1+r}
\quad\text{for }j=2k,2k+1 .
\]
Indeed \(-\log\lambda_k=O(\delta_k)\), \(j+1\sim2k\), and \(\log d=-\delta_k r/(1+r)+O(\delta_k^2)\). The corresponding expansion for the shared branch is
\[
\frac{\log(1+G_k(r,\lambda_k))}{2k\delta_k}\to\frac{r^2}{1-r^2}.
\tag{10}
\]
When \(\theta=0\), the logarithms tend to zero. Dividing \(1-A_j-G_k\) by \(2k\delta_k\) then gives limit \(r/(1+r)-r^2/(1-r^2)\), which is positive for \(r<1/2\) and negative for \(r>1/2\). Applying the known uniqueness and sign of the odd crossover at fixed radii on either side proves the first regime.

For \(\theta>0\), put \(a(r)=2\theta r^2/(1-r^2)\) and \(b(r)=2\theta r/(1+r)\). The shared branch tends to \(e^{a(r)}-1\) and \(1-A_j\) tends to \(1-e^{-b(r)}\) for either order. For \(r\in(0,1)\) their ratio is
\[
\frac{e^{a(r)}-1}{1-e^{-b(r)}}=
\frac{r}{1-r}
\frac{(e^{a(r)}-1)/a(r)}{(1-e^{-b(r)})/b(r)}.
\]
The first factor strictly increases from zero to infinity. The numerator of the second factor increases with \(a(r)\), and its denominator decreases with \(b(r)\), as is immediate from their integral representations on \([0,1]\). The ratio consequently crosses one exactly once, and at \(r=1/2\) it exceeds one because \(a=b>0\). This gives the unique root \(R_\theta\in(0,1/2)\). Evaluating the finite-order inequality on either side of \(R_\theta\) establishes the second regime.

For \(\theta_k\to\infty\), choose any fixed \(y>0\) and set
\(r=\sqrt{y/[k(1-\lambda_k^2)]}\), which tends to zero. Then
\[
\log(1+G_k)=k\log\left(1+\frac{y}{k(1-r^2)}\right)\to y.
\]
When \(\lambda_k\ge1/2\), (7) gives \(A_{2k+1}\to0\), since \((2k+2)\delta_k r\) diverges proportionally to \(\sqrt{k\delta_k}\) up to constants. When \(\lambda_k<1/2\), use the comparison with \(\lambda=1/2\) after (7) and \(k r\to\infty\). Thus \(1-A_{2k+1}\to1\) at these test radii. Take \(y\) arbitrarily close to \(\log 2\) from above and below to bracket the crossover. This proves the third regime.

## 4. Maximal gap with contraction bounded away from the identity

Suppose \(\lambda_k\to\lambda_0<1\). Take \(r=y/m\) with \(m=2k\). In this section set \(\alpha=\operatorname{arctanh}r\) and \(\beta=\operatorname{arctanh}(\lambda r)\). The expression for \(h_m\) can be written as
\[
h_m(r^2)=(1-r^2)^{(m+1)/2}\frac{\alpha}{r}\,
\frac{\sinh((m+1)\alpha)}{(m+1)\alpha}.
\]
It is continuous at \(r=0\). On compact \(y\)-intervals, \(m\alpha\to y\), \(m\beta\to\lambda_0 y\), and \(m r^2\to0\). This implies
\[
A_m(y/m,\lambda_k)\to\frac{\sinh(\lambda_0 y)}{\lambda_0\sinh y}
\]
uniformly on these intervals with the stated continuous conventions.

We also need the change between successive orders, since the difference is of smaller order than either term. Interpolate in the real exponent \(N=m+1\) of the exact formula. Its logarithmic derivative is
\[
\partial_N\log A_{N-1}
=\frac12\log\frac{1-\lambda^2 r^2}{1-r^2}
+\frac{f(N\beta)-f(N\alpha)}{N},
\qquad f(v)=v\coth v,\quad f(0)=1.
\]
This follows by differentiating the hyperbolic sines, and holds at \(\lambda=0\) by continuity of the formula using \(\sinh v/v\). Taking the integral of this derivative over a unit interval in \(N\) gives the logarithm of \(A_{m+1}/A_m\). Multiplying that logarithm by \(m\) yields the uniform compact limit \(f(\lambda_0 y)-f(y)\); the first term of the derivative contributes \(O(mr^2)\). Therefore
\[
m(A_m-A_{m+1})\to\Psi_{\lambda_0}(y)
\]
uniformly on compact \(y\)-intervals.

For each compact interval bounded away from \(y=0\), \(1-A_m\) has a positive limit bounded away from zero and \(G_k\to0\). The common threshold branch does not clip either error there, by (4). Near \(y=0\), (6) gives a uniform bound \(m\Delta_k\le y\). For large \(y=mr\), (6)–(7) give \(m\Delta_k\le C y e^{-c y}\), uniformly over \(r<1\) and all sufficiently large \(k\). To see it for small \(\lambda_k\) use the comparison with \(1/2\); otherwise \(\lambda_k^{-1}\le2\) and \(1-\lambda_k\) is bounded below. Thus the maximum can be passed to the continuous profile, which vanishes at zero and at infinity and is positive on \(y>0\). Positivity follows since \(f(v)=v\coth v\) strictly increases for \(v>0\). This proves item 1 of Theorem 2. In particular, any sequence of maximizing radii for fixed limiting \(\lambda_0<1\) has \(2k r\) bounded away from zero and infinity, and its limit points maximize (2).

## 5. Maximal gap under weak contraction

Assume \(\lambda_k\to1\) and put \(z=m\delta_k r/(1+r)\). Equations (6)–(7) give the global estimate
\[
m\Delta_k(r,\lambda_k)\le \lambda_k^{-1}z e^{-z}. \tag{11}
\]

If \(\theta_k\to0\), the gap vanishes for \(r\ge r_k(\lambda_k)\), and (6) gives
\(D_k/\delta_k\le r_k/(1+r_k)\) because \(A_m\le1\). This has limit \(1/3\). For any fixed \(0<r<1/2\), the sign calculation in Section 3 shows \(1-A_m>G_k\) eventually. In that case (4) and (9) apply, with \(A_m\to1\). Thus \(\liminf D_k/\delta_k\ge r/(1+r)\). Taking \(r\uparrow1/2\) proves equality.

If \(\theta_k\to\theta\in(0,\infty)\), again the gap vanishes at and above the crossover. The range of \(z\) on its support has upper limit \(z_\theta=2\theta R_\theta/(1+R_\theta)\). Equation (11) gives the upper limit \(\max_{0\le z\le z_\theta}z e^{-z}\). For a fixed \(0<r<R_\theta\), the finite crossover asymptotic shows that \(1-A_m>G_k\) eventually. Then (9), with \(A_m\to\exp(-2\theta r/(1+r))\), attains the corresponding limiting value. The range of these interior \(r\)'s approaches the entire interval up to \(z_\theta\), proving the claimed maximum.

To evaluate when this coefficient reaches \(1/e\), let \(z=z_\theta\) and \(a=\log(2-e^{-z})\). Equation (1) gives \(a/z=R_\theta/(1-R_\theta)\). Hence \(R_\theta=a/(a+z)\) and \(\theta=z+z^2/(2a)\). The positive function \(a(z)\) is strictly increasing and concave with \(a(0)=0\). Consequently \(a(z)/z\) decreases and the map from \(z\) to \(\theta\) increases continuously from zero to infinity. The threshold \(z=1\) is exactly (3). Since \(z e^{-z}\) is maximal at one, the plateau assertion follows.

Finally if \(\theta_k\to\infty\) with \(\lambda_k\to1\), (11) gives \(\limsup mD_k\le1/e\). Set \(r=1/(m\delta_k-1)\) for all sufficiently large \(k\). This is positive, tends to zero, and gives \(z=1\) and \(mr\to\infty\). Equation (5) gives \(A_m\to1/e\), since \(d=1-1/m\), \(\lambda_k\to1\), and \(g_{m+1}\to1\). Also \(\log(1+G_k)=O(k\delta_k r^2)\to0\), so neither error is clipped. Equation (9) now gives \(m\Delta_k\to1/e\). This completes Theorem 2.

## 6. Scope and relation to the archived result

The finite-order block formula and unique parity crossover are from [1]. The new results concern the limiting radius, the scale of maximal parity violation, and its leading constants under joint weak noise. They also distinguish the crossover radius from the smaller radius that controls the largest gap under fixed contraction. The estimates require the scalar radial-contraction formula. They apply to the pre-conjugation unital and depolarizing cases already covered by that formula.

## Reference

1. *Exact parity criterion for noise in single-qubit unitary designs* (Chinese manuscript), earlier research manuscript at  (archived version), Sections 1–3.
