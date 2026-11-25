---
title: "The finite-population effect for Euclidean coordinate medians"
lang: en
---

# The finite-population effect for Euclidean coordinate medians

## Abstract

The sharp dimension-free cost ratio for a Euclidean coordinate median is a supremum over all odd population sizes. We determine the effect of fixing the population. An exact equal-weight reduction expresses the worst ratio for \(n\) agents as a scalar support-fraction problem, and an extremizer always exists in dimension at most \(n+1\). We evaluate the finite-population ratio for all odd sizes when the social-cost exponent lies between two and four. On the lower-exponent plateau, the ratio has an exact formula for all sufficiently large odd sizes, including at the transition exponent. For every finite exponent, we compute the leading \(1/n\) deficit from the unrestricted sharp constant. Its coefficient is determined by the unrestricted support slope and the mean radial cost at its contacts.

## 1. Model and results

Let \(n=2L+1\ge3\) and \(p\ge1\). For a nonconstant profile \(x_1,\ldots,x_n\) in a finite-dimensional Euclidean space, let \(m\) be its coordinate-wise median. For a facility \(f\), set
\[
S_p(f;x)=\left(\sum_{i=1}^n\|x_i-f\|_2^p\right)^{1/p}.
\]
Let \(C_n(p)\) be the supremum of \(S_p(m;x)/\min_fS_p(f;x)\) over these profiles with \(n\) fixed and dimension unrestricted. Let \(C(p)\) be the supremum over all odd sizes, evaluated in [1]. Put \(\tau=L/n\), and for \(r\ge0\), \(s\in[0,1]\) and \(0\le t<1\) define
\[
g_t(r,s)=(r^2+1-2r\sqrt s)^{p/2}-t r^p,\qquad
h_t(s)=\min_{r\ge0}g_t(r,s).
\]

**Theorem 1 (exact fixed-size reduction).** The function
\[
F_n(t)=\min_{\substack{0\le s_i\le1\\\sum_i s_i=L}}
\frac1n\sum_{i=1}^n h_t(s_i)
\]
has a unique zero \(t_n\in(0,1)\). The exact value is \(C_n(p)=t_n^{-1/p}\), and a profile attaining it exists in dimension at most \(n+1\).

**Theorem 2 (finite formulas).** For all odd \(n=2L+1\ge3\) and \(2\le p\le4\),
\[
C_n(p)=\left(1+\left(\frac{L}{L+1}\right)^{1/(p-1)}\right)^{1-1/p}. \tag{1}
\]
For \(2<p\le4\), every maximizing profile has \(L+1\) copies of one point and \(L\) copies of a distinct point. For each fixed \(p_*\le p<2\), where \(p_*\) is the lower transition exponent of [1], for all sufficiently large odd \(n\),
\[
C_n(p)=\sqrt{\frac{2n}{n+1}}. \tag{2}
\]

**Theorem 3 (sharp finite-size deficit).** Let \(t_*=C(p)^{-p}\) and let \(b_*>0\) be the explicit slope in the support inequality of [1],
\[
g_{t_*}(r,s)\ge b_*(1/2-s). \tag{3}
\]
Let \(S_*\) be the mean of \(r^p\) for a distribution of equality contacts in (3) with mean \(s=1/2\). This mean radial cost is positive and independent of the choice of such a distribution. Then
\[
\lim_{\substack{n\to\infty\\n\ {\rm odd}}}
n[C(p)-C_n(p)]=\frac{C(p)b_*}{2p\,t_*S_*}. \tag{4}
\]
On \(p_*\le p\le2\) the coefficient is \(C(p)/2\), and on \(2\le p\le4\) it is \(C(p)/p\). On either outer branch, the explicit contacts of [1] give the coefficient without any additional optimization.

## 2. Exact realization of the support fractions

The radial minimum is jointly continuous in \(t,s\) on compact subsets of \(t<1\), and is nonincreasing in \(s\). For continuity, if \(t\le\bar t<1\), the quantity \((r-1)^p-\bar t r^p\) grows to infinity as \(r\to\infty\), while \(g_t(0,s)=1\). Hence the minimizers can be restricted to a common compact interval. Monotonicity follows pointwise from the formula for \(g_t\).

The upper direction of the reduction uses the Euclidean argument in [1]. Translate the median to zero. For a nonzero reference facility, divide all vectors by its length and reflect axes to get \(f_j\ge0\) and \(\|f\|=1\). Put \(r_i=\|x_i\|_2\) and \(s_i=\sum_{j:x_{ij}>0} f_j^2\). The inner product \(f\cdot x_i\) is at most \(r_i\sqrt{s_i}\), by restricting to positive coordinates and applying Cauchy–Schwarz. Thus
\[
\sum_i(\|x_i-f\|_2^p-t\|x_i\|_2^p)\ge \sum_i g_t(r_i,s_i).
\]
In each coordinate there are at most \(L\) positive entries, so \(\sum_i s_i\le L\). Any vector of support fractions with sum below \(L\) can have some entries increased to reach exact sum \(L\), without increasing the sum of the nonincreasing \(h_t\)'s. Therefore \(F_n(t)\ge0\) implies the desired geometric inequality at every reference point. At \(f=m\), it also holds since \(t<1\).

For the reverse direction we realize every tuple \(s\in[0,1]^n\) with \(\sum_i s_i=L\), together with arbitrary radii \(r_i\ge0\). The polytope of such tuples is the convex hull of the indicator vectors of \(L\)-element subsets of \(\{1,\ldots,n\}\). Indeed, if a point has a fractional entry, it has at least two, and it admits a nonzero signed perturbation in opposite directions on those two entries within the polytope. Its vertices are therefore the asserted indicators. Since its affine dimension is \(n-1\), write \(s\) as a convex combination of at most \(n\) vertices, with positive weights \(\omega_j\) and vertex subsets \(A_j\). The bound on the number of vertices follows by eliminating an affine dependence among any larger set of positive coefficients. There is also a direct construction. Place intervals of lengths \(s_i\) consecutively in \([0,L)\), draw \(U\) uniformly in \([0,1)\), and take the rows whose intervals contain \(U,U+1,\ldots,U+L-1\). No interval can contain two of these points, and the probability of its being chosen is its length. The subsets change only at fractional parts of interval endpoints, of which there are at most \(n\) distinct values.

Use one spatial coordinate for each subset \(A_j\), with facility component \(f_j=\sqrt{\omega_j}\). For every row with \(s_i>0\), set \(x_{ij}=r_i f_j/\sqrt{s_i}\) when \(i\in A_j\) and zero otherwise. Then \(\|x_i\|_2=r_i\) and \(f\cdot x_i=r_i\sqrt{s_i}\). In each coordinate at most \(L\) entries are positive, and all others are zero. When \(s_i=0\) and \(r_i>0\), use one extra coordinate whose facility component is zero. Give each such row a value with magnitude \(r_i\), splitting their signs so that at most \(L\) are positive and at most \(L\) are negative. This is possible because \(s\) has at least one positive entry and hence at most \(2L\) zero entries. All other rows have zero in the extra coordinate. The median remains zero, \(\|f\|=1\), and the radial and dot-product identities hold for every row. The resulting sum of geometric differences equals \(\sum_i g_t(r_i,s_i)\) exactly.

Now \(F_n\) is continuous by compact minimization both in the radii and in \(s\). At \(t=0\) it is positive, since \(g_0\ge0\) can vanish only at \(s=1,r=1\) and the sum constraint excludes that for all rows. For \(t>(1-\tau)^{p/2}\), the trial \(s_i=\tau\), \(r_i=1/\sqrt\tau\) has negative average. Thus there is a root. At a root any minimizing tuple has \(\sum_i r_i^p>0\), because zero radii would give average one. At any larger \(t<1\), the same tuple has strictly negative average. This proves uniqueness. The upper direction gives \(C_n(p)\le t_n^{-1/p}\). The realization applied to a minimizing tuple at the root gives a nonconstant profile and a reference point with ratio \(t_n^{-1/p}\). Its optimum facility cost cannot be smaller than this reference cost by the upper direction. This proves Theorem 1 and attainment.

## 3. Exact evaluation between two and four

For \(p\ge2\) and \(0<t<1\), the endpoint values are
\[
h_t(0)=1,\qquad h_t(1)=-E_p(t),\qquad
E_p(t)=\left(\frac{t^{1/(p-1)}}{1-t^{1/(p-1)}}\right)^{p-1}.
\]
At \(s=0\) the radius is zero, by \((1+r^2)^{p/2}\ge1+r^p\). At \(s=1\), the derivative at \(r=1\) is \(-pt\), so that point is excluded from the minimizer. One-variable minimization gives the unique radius \(R(t)=1/(1-t^{1/(p-1)})\). Differentiation gives \(E_p'(t)=R(t)^p\).

For any \(0<s<1\), a radial minimizer has \(r>\sqrt s\) by stationarity and the negative initial derivative. Its equation is
\[
t=(1-\sqrt s/r)\left(\frac{r^2+1-2r\sqrt s}{r^2}\right)^{(p-2)/2}
\ge (1-\sqrt s/r)^{p-1}.
\]
The inequality uses \(r^2+1-2r\sqrt s\ge(r-\sqrt s)^2\). Thus
\(r\le\sqrt s\,R(t)\), also at both endpoints. For \(t_2>t_1>0\), evaluate the minimum at \(t_1\) using a minimizer at \(t_2\) to obtain
\[
h_{t_2}(s)-h_{t_1}(s)\ge-(t_2-t_1)s^{p/2}R(t_2)^p.
\]
Apply this bound along a partition of \([t_1,t_2]\) and pass to a Riemann integral to get
\[
h_{t_2}(s)-h_{t_1}(s)
\ge-s^{p/2}[E_p(t_2)-E_p(t_1)] . \tag{5}
\]

The source support inequality for \(2\le p\le4\) is \(h_{t_*}(s)\ge1-2s\), with \(E_p(t_*)=1\). By (5) and \(s^{p/2}\le s\), for \(t\ge t_*\) we have \(h_t(s)\ge1-(1+E_p(t))s\). For \(t>t_*\) and \(p>2\) this inequality is strict when \(0<s<1\). Summing it at total support \(L\) shows \(F_n(t)\ge[n-(1+E_p(t))L]/n\), and the tuple of \(L\) ones and \(L+1\) zeros attains equality. The root is specified by \(E_p(t_n)=(L+1)/L\). Solving gives (1).

For \(2<p\le4\), any maximizing profile has nonmedian optimal facility, because the ratio in (1) exceeds one. Normalize using that facility as in Section 2. Equality in the resulting bounds forces all \(s_i\) to be endpoints, and their sum to be \(L\). At \(s=0\) the radius must be zero. At \(s=1\) the unique radius is \(R(t_n)\); equality in the Euclidean bound then forces the point to be \(R(t_n)f\). Thus the profile consists of the asserted two point values, and the converse attainment also follows from the endpoint tuple.

## 4. Exact evaluation near the lower plateau

Fix \(p_*\le p<2\). The source [1] gives \(t_*=2^{-p/2}\) and \(b_*=p\). Equality in (3) among interior values of \(s\) occurs only at \(s=1/2,r=\sqrt2\). The endpoint \(s=1\) is a further equality contact only at \(p=p_*\), and \(s=0\) has no equality contact. In this section \(\tau\) is a real parameter tending to \(1/2\) from below. Set
\[
t(\tau)=(1-\tau)^{p/2},\qquad
b(\tau)=\frac{p}{2\tau}\left(\frac{1-\tau}{\tau}\right)^{(p-2)/2}.
\]
Writing \(u=\sqrt s\), consider \(Q_\tau(r,u)=g_{t(\tau)}(r,u^2)+b(\tau)(u^2-\tau)\). At \(r=1/\sqrt\tau,u=\sqrt\tau\), the value and first derivatives vanish. If \(D=r^2+1-2ru\), its Hessian at that point, divided by the positive \(pD^{(p-2)/2}\), has entries
\[
H_{rr}=\tau,\qquad H_{ru}=-(p-1),\qquad
H_{uu}=(p-2)/(1-\tau)+1/\tau.
\]
These follow by differentiating the radius power and the support term at the stated point, where \(r(r-u)=D\). The determinant is \((2-p)[p-\tau/(1-\tau)]>0\) in a neighborhood on the required side of \(1/2\). Thus in a fixed sufficiently small convex neighborhood of the interior contact, the Hessian stays positive definite for \(\tau\) near \(1/2\). The stationary point with value zero then makes \(Q_\tau\ge0\) on that neighborhood.

When \(p>p_*\), the source inequality has no other zero. The radial coercivity is uniform for \(\tau\) near \(1/2\), even after adding the bounded support term. Compactness then gives positive \(Q_\tau\) outside the interior neighborhood for sufficiently close \(\tau\), since \(Q_{1/2}\) is strictly positive there. At \(p=p_*\) we also check a neighborhood of the endpoint contact.

At that transition, set \(q=p/[2(p-1)]\in(3/2,2)\) and \(w=R(t_*)-1=(2^q-1)^{-1}>0\). The equation determining the transition in [1] gives \(w^{p-1}=p/2\), since the endpoint is an equality contact. At \(r=1+w,s=1\), the \(s\)-derivative of \(g_{t_*}(r,s)+p(s-1/2)\) is
\[
p-\frac p2(1+w)w^{p-2}<0 .
\]
For the strict inequality use \(w^{p-1}=p/2\), which reduces it to \(w<p/(4-p)\). This is equivalent to \(2^q>4-2/q\), true at \(q=3/2\) and increasing in difference on the interval, since \(2^q\log2>2/q^2\). Thus for \(\tau\) close to \(1/2\) the \(s\)-derivative remains negative in a neighborhood of the endpoint contact. There \(Q_\tau(r,\sqrt s)\ge Q_\tau(r,1)\). The minimum of the latter over \(r\) is \(b(\tau)(1-\tau)-E_p(t(\tau))\). To see it is nonnegative, write
\[
\frac{b(\tau)(1-\tau)}{E_p(t(\tau))}
=\frac p2\left(\frac{1-(1-\tau)^q}{\tau^q}\right)^{p-1}.
\]
This equals one at \(1/2\). The derivative of the inner ratio is \(q\tau^{-q-1}[(1-\tau)^{q-1}-1]<0\), so the ratio is at least one when \(\tau\le1/2\). This handles the endpoint neighborhood. Uniform coercivity and strict positivity away from the two neighborhoods now give \(Q_\tau\ge0\) globally for all sufficiently close \(\tau\le1/2\), also at \(p=p_*\).

Consequently \(h_{t(\tau)}(s)\ge b(\tau)(\tau-s)\) for these \(\tau\). Summing over the fixed-size feasible fractions yields \(F_n(t(\tau))\ge0\), and the uniform tuple \(s_i=\tau,r_i=1/\sqrt\tau\) attains zero. For all sufficiently large odd \(n\), its \(\tau=L/n\) is close enough. This proves (2).

## 5. The leading finite-population deficit

We first specify \(S_*\) using the source contact classification. On each outer branch, namely \(1\le p<p_*\) and \(p>4\), the line in (3) has a unique interior contact \((r_a,a)\) for some \(0<a<1/2\), and an endpoint contact \((r_b,1)\). Their mean-\(1/2\) probabilities are \(w=1/[2(1-a)]\) and \(1-w\). Hence
\(S_*=w r_a^p+(1-w)r_b^p\), with \(a,r_a,r_b\) explicit in [1]. On \(p_*\le p<2\), any mean-\(1/2\) contact law is concentrated at \((\sqrt2,1/2)\), even when \(s=1\) is an additional contact, so \(S_*=2^{p/2}\). On \(2<p\le4\) the contacts are \((0,0)\) and \((2,1)\), and \(S_*=2^{p-1}\). At \(p=2\),
\[
g_{t_*}(r,s)=1-2s+\tfrac12(r-2\sqrt s)^2 .
\]
Thus any equality law of mean \(1/2\) has \(\mathbb E r^2=2\), also matching \(S_*=2^{p-1}\). This proves the claimed uniqueness of the mean radial cost in every case.

For every finite optimum, (3) gives \(F_n(t_*)\ge b_*/(2n)>0\). To give a matching trial at leading order, take \(n\) contacts in proportions close to the appropriate mean-\(1/2\) law. On either outer branch, use the nearest integer to \((1-w)n\) copies of the endpoint \(s=1,r=r_b\). For all other rows keep radius \(r_a\) and use a common fraction
\[
s_{\rm low}=\frac{L-\#\{\text{endpoint rows}\}}{n-\#\{\text{endpoint rows}\}}
=a+O(n^{-1}).
\]
For large \(n\) this is an interior fraction in \([0,1]\), and the total equals \(L\) exactly. On the lower plateau simply use \(s_i=\tau,r_i=\sqrt2\) for all rows. At an interior contact, the first derivative in \(s\) of the nonnegative difference in (3) vanishes. At the fixed radius the expression is twice differentiable near the contact, since its squared distance there is positive. Hence each shifted row adds \(O(n^{-2})\) above the support line. For \(2\le p\le4\), use \(L\) rows at \((2,1)\) and \(L+1\) at \((0,0)\), with no contact error. In every case the trial average at \(t_*\) is \(b_*/(2n)+O(n^{-2})\) and its mean radial power is \(S_*+O(n^{-1})\). The same trial has zero average at a value of \(t\) at most
\[
t_*+\frac{b_*}{2S_* n}+O(n^{-2}).
\]
Since \(F_n\) is nonincreasing and has unique zero, this gives that upper bound on \(t_n\).

For the reverse bound, choose minimizing radii and support fractions at \(t_n\), and let \(S_n\) be their mean radial power. The equality \(F_n(t_n)=0\) and (3) give
\[
(t_n-t_*)S_n=\frac1n\sum_i g_{t_*}(r_i,s_i)\ge \frac{b_*}{2n}.
\]
All such radii lie in a common compact interval for large \(n\), since \(t_n\to t_*<1\). The empirical measures on \((r,s)\) therefore have subsequential limits. Every limit has mean \(s=1/2\), because the finite sums have mean \(\tau\). The mean of \(g_{t_*}\) is zero in the limit, since the last equality and uniform boundedness of \(S_n\) give convergence to zero. The nonnegative slack in (3) has limiting mean zero, so every limit is supported on equality contacts. Its mean radial power is \(S_*\). It follows that \(S_n\to S_*\), and hence \(n(t_n-t_*)\to b_*/(2S_*)\). Applying the derivative of \(t^{-1/p}\) at \(t_*\) proves (4).

## 6. Source comparison and scope

The unlimited-size constants, pointwise Euclidean reduction, global support line, and its contact classification come from [1]. The fixed-size result retains the individual support fractions and realizes them as a convex mixture of incidence vectors of \(L\)-subsets. This makes the fixed-size relaxation exact and yields a linear bound on the dimension needed for attainment. The finite formulas and the sharp deficit use the exact odd-size support budget. On the two outer exponent branches Theorem 1 is a finite characterization, while Theorem 3 evaluates the first-order asymptotic. No formula for the full finite-size value in those outer branches is asserted.

## Reference

1. *Sharp guarantees for the Euclidean coordinate median at every finite social-cost exponent*, earlier research manuscript at  (archived version), especially Sections 3–5 and 7.
