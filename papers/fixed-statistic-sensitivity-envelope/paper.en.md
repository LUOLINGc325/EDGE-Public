---
title: "Sharp fixed-statistic sensitivity envelopes for Gaffke's statistic"
fontsize: 11pt
geometry: margin=1.1in
abstract: |
  Gaffke's statistic has a common leave-one-out sensitivity coefficient. At fixed statistic and fixed coordinates below one, collapsing the coordinates above one gives the known lower envelope. We determine the complementary upper envelope. At every fixed positive count, equal coefficients uniquely maximize sensitivity. The attainable interval is exact, and its upper endpoint increases to the value of a deterministic positive sum. We give a strictly positive first-order coefficient for its convergence with the count. The central step is a log-convex density ratio between unequal exponentials and their equal-weight gamma counterpart.
---

## 1. Setting and main results

Let \(E_0,E_1,\ldots\) be independent unit-rate exponentials. Write the positive and negative parts of the weighted sum in Gaffke's statistic as
\[
P=\sum_{i=1}^{q}a_iE_i,\qquad N=\sum_{j=1}^{r}d_jE_{q+j},
\qquad a_i>0,\quad 0<d_j\le1,\quad r,q\ge1.
\]
These correspond to data coordinates \(1+a_i\) and \(1-d_j\). Remaining coordinates may equal one. Set \(W=E_0\), \(M=N+W\), and
\[
K=\mathbb E e^{-(P-N)_+},\qquad D=1-K=\mathbb P(P>M),
\qquad A=\mathbb P(P>N).
\tag{1}
\]
The common leave-one-out coefficient is \(\Delta=A-D\) by [1]. We fix \(N\), \(D\in(0,1)\), and the number \(q\) of positive coefficients. The one-exponential lower envelope follows from the same-statistic compression in [1].

Let \(Z_q\) be the average of \(q\) independent unit-rate exponentials. Define \(\mu_q>0\) by \(\mathbb P(\mu_q Z_q>M)=D\), and put
\[
\Delta_q=\mathbb P(\mu_q Z_q>N)-D.
\tag{2}
\]
The matched scale \(\mu_q\) is unique by continuous strict monotonicity of the probability, with endpoints zero and one.

**Theorem 1.** At a fixed \(q\), \(\Delta_q\) is the largest sensitivity and is attained precisely at \(a_i=\mu_q/q\) for every \(i\). For \(q=1\) the attainable set is the singleton \(\{\Delta_1\}\). For \(q\ge2\) it is exactly \((\Delta_1,\Delta_q]\). The upper endpoint increases strictly with \(q\).

**Theorem 2.** Let \(F_N,F_M\) be the cumulative distribution functions of \(N,M\), with densities \(f_N,f_M\), and define \(\mu_*=F_M^{-1}(D)\), \(\Delta_*=F_N(\mu_*)-D\). Then
\[
\Delta_q\uparrow\Delta_*,
\qquad
\Delta_*-\Delta_q
=\frac{\mu_*^2 f_N(\mu_*)}{2q}
 \left.\frac{d}{dt}\log\frac{f_M(t)}{f_N(t)}\right|_{t=\mu_*}
 +O(q^{-3/2}).
\tag{3}
\]
The coefficient of \(1/q\) is strictly positive. Among all nonnegative laws of \(P\) independent of \(N,W\) with the same \(D\), the deterministic \(P=\mu_*\) achieves \(\Delta_*\).

## 2. A survival comparison from a density ratio

The density of a finite sum of positive-rate exponentials is positive on \((0,\infty)\) and log-concave by convolution. For our nontrivial \(N\), the ratio
\[
R(t)=\frac{f_M(t)}{f_N(t)}
=\int_0^t e^{-u}\frac{f_N(t-u)}{f_N(t)}\,du,\qquad t>0 ,
\tag{4}
\]
is strictly increasing, as used in [1]. For each fixed \(u>0\), concavity of \(\log f_N\) makes \(f_N(t-u)/f_N(t)\) nondecreasing in \(t>u\). Extending the integrand by zero for \(t\le u\) preserves monotonicity, and a strictly larger positive integration interval enters as \(t\) grows.

Consider positive random variables \(X,Y\) independent of \(N,W\), with continuous positive densities \(f_X,f_Y\) on \((0,\infty)\). Suppose the logarithm of \(f_X/f_Y\) is convex. Then the set \(f_X\le f_Y\) is an interval. The density difference is nonnegative, nonpositive, then nonnegative, allowing an empty outer piece. Its cumulative integral starts and ends at zero, increasing on the outer pieces and decreasing in the middle. Therefore it can cross zero only from positive to negative, and the survival difference \(h=H_X-H_Y\) can cross only from negative to positive.

If \(\mathbb E h(N)=0\) and the laws differ, both survival signs occur on intervals of positive length because \(f_N>0\). Choose \(t_0\) between the signs. By (4),
\[
\mathbb E h(M)
=\int_0^\infty (R(t)-R(t_0))h(t)f_N(t)\,dt>0 .
\tag{5}
\]
The equality subtracts the zero \(\mathbb E h(N)\) term. The sign order and strict increase of \(R\) give the last inequality.

## 3. Equal positive coefficients and the exact interval

Put \(\lambda_i=1/a_i\). Changing variables from the \(q\) independent exponential values to their sum \(t\) and simplex proportions gives
\[
f_P(t)=
\frac{t^{q-1}\prod_i\lambda_i}{(q-1)!}
\mathbb E\exp\left[-t\sum_i\lambda_iU_i\right],
\qquad t>0,
\tag{6}
\]
where \(U\) is uniform on the simplex of \(q\) nonnegative coordinates summing to one. The power of \(t\) is the simplex volume scaling, with \(U_1=1\) for \(q=1\). A gamma of shape \(q\) and common rate \(\lambda\) has density \(t^{q-1}\lambda^qe^{-\lambda t}/(q-1)!\). The logarithm of the density ratio is convex by Hölder's inequality applied to the exponential mixture in (6). It is strictly convex when some \(\lambda_i\) differ because the simplex linear form is then nonconstant. This also ensures that the two densities differ.

Choose the unique common-rate gamma \(Y\) of shape \(q\) with \(\mathbb P(Y>N)=A\). If the positive coefficients are unequal, (5) gives \(\mathbb P(P>M)>\mathbb P(Y>M)\). Increasing the scale of \(Y\) to match the fixed \(D\) strictly increases \(\mathbb P(Y>N)\). Thus its sensitivity strictly exceeds that of \(P\). This gives the unique maximizing profile in (2); when the original coefficients are equal its law is already that profile.

The density ratio of a gamma of shape \(q\) to a gamma of shape \(q+1\), at any respective positive rates, is a positive constant times \(t^{-1}e^{bt}\) for some real \(b\). Its log is strictly convex and the densities differ. Matching the probability of exceeding \(N\), applying (5), and then raising the shape-\((q+1)\) scale to match \(D\) proves \(\Delta_{q+1}>\Delta_q\).

For \(q\ge2\), the pinned same-statistic result [1] proves that \(\Delta\) is strictly greater than the one-exponential \(\Delta_1\), since \(N\) is nontrivial. To see sharpness and attainability of the interior, write \(a_i=\mu b_i\) with positive \(b_i\) summing to one. The scale \(\mu\) satisfying \(D=\mathbb E F_M(\mu\sum_i b_iE_i)\) is unique since the right side is strictly increasing and continuous from zero to one. This remains true at any boundary shape of the closed simplex. Bounded convergence and strict root bracketing give continuity of \(\mu\) and \(\Delta\) as functions of that shape. On a line segment from equal weights to a one-coordinate shape, all points other than the collapsed endpoint have strictly positive weights. The two endpoints have values \(\Delta_q,\Delta_1\). The intermediate value theorem and the bounds give the claimed interval.

## 4. The limit and its leading gap

Write \(H_*(t)=\mathbf1_{\{t<\mu_*\}}\) for the survival profile of the deterministic comparator. For any survival profile \(H\) with the same \(D\), \(H-H_*\) is nonpositive below \(\mu_*\) and nonnegative above it. Equation (4) gives
\[
0=\int (H-H_*) f_M
\ge R(\mu_*)\int (H-H_*) f_N.
\tag{7}
\]
The inequality is strict if the profiles differ on a set of positive measure, including for every positive exponential sum. This proves the deterministic upper bound.

By the law of large numbers \(Z_q\to1\) in probability. For fixed \(\mu>0\), bounded continuity gives \(\mathbb E F_M(\mu Z_q)\to F_M(\mu)\). Evaluating at two fixed scales bracketing \(\mu_*\) shows \(\mu_q\to\mu_*\). The same argument for \(F_N\) gives \(\Delta_q\to\Delta_*\), and Theorem 1 gives monotonicity.

For the leading term, the densities are smooth on \((0,\infty)\) by (6). The centered \(Z_q\) has mean zero after subtracting one, variance \(1/q\), and fourth central moment \(3/q^2+6/q^3\), by independence and the exponential moments. Its third absolute centered moment is therefore \(O(q^{-3/2})\). For \(F=F_N\) or \(F_M\), uniformly for \(\mu\) near the fixed \(\mu_*>0\),
\[
\mathbb E F(\mu Z_q)=F(\mu)+\frac{\mu^2}{2q}F''(\mu)+O(q^{-3/2}).
\tag{8}
\]
On a fixed neighborhood of \(Z_q=1\), this is Taylor's theorem on a compact positive interval. Outside that neighborhood, the bounded \(F\) and Taylor polynomial terms of degree at most two are each bounded by a constant times \(|Z_q-1|^3\). This justifies the uniform remainder.

Applying (8) to \(F_M\) at \(\mu_q\), positivity of \(f_M(\mu_*)\) first gives \(\mu_q-\mu_*=O(q^{-1})\) by the mean-value theorem. Expanding again gives
\[
\mu_q=\mu_*-\frac{\mu_*^2f_M'(\mu_*)}{2qf_M(\mu_*)}+O(q^{-3/2}).
\tag{9}
\]
Substituting in (8) for \(F_N\) gives
\[
F_N(\mu_*)-\mathbb E F_N(\mu_qZ_q)
=\frac{\mu_*^2}{2q}
 \left(\frac{f_N(\mu_*)f_M'(\mu_*)}{f_M(\mu_*)}-f_N'(\mu_*)\right)
 +O(q^{-3/2}),
\]
which is (3).

For positivity, differentiate (4). If \(r=1\), the upper-end boundary term \(e^{-t}f_N(0+)/f_N(t)\) is positive and the interior derivative is nonnegative. For \(r\ge2\), \(f_N(0+)=0\) by (6), and \(f_N\) is positive and real analytic on \((0,\infty)\). Its log derivative is strictly decreasing: equality at distinct points of a nonincreasing derivative would make the log affine on the interval and hence everywhere by analyticity, contradicting the zero right limit of the density at zero. Accordingly, for \(0<u<t\) the derivative of \(f_N(t-u)/f_N(t)\) is positive. Differentiation under the integral is valid because \(f_N\) and its first derivative have finite right limits at zero by (6). Thus \(R'(t)>0\) for each \(t>0\), proving strict positivity in (3).

For instance, when \(N\) is unit-rate exponential and \(D=1-2/e\), \(M\) is gamma of shape two and rate one. Here \(\mu_*=1\) and \(R(t)=t\), so \(\Delta_*=1/e\) and \(\Delta_*-\Delta_q=1/(2eq)+O(q^{-3/2})\).

## 5. Provenance

The pinned work [1] supplies the deletion identity and the sharp one-exponential compression in the lower direction. The upper comparison uses the opposite survival sign order at a matched gamma law. This gives the complementary extremum, its attained range, and its finite-count convergence. Log-concavity of convolution and gamma moment computations are standard. Without negative coordinates, the pinned identity is \(\Delta=K\).

**Reference**

1. *A sharp lower bound for Gaffke's leave-one-out coefficient*, earlier research manuscript, fixed commit 230a3dae9d29, Section 3 and the same-statistic compression. The source manifest gives the full commit and manuscript blob.
