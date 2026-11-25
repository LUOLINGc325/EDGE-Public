---
title: "The exact principal entropy endpoint near a three-state sampling resonance"
subtitle: "Homogeneous maximizers and a sixth-order expansion"
lang: en
geometry: margin=1in
abstract: |
  A uniformly stationary three-state continuous-time Markov chain can yield the same sampled transition matrix on different logarithm branches. For a Frobenius tolerance around a symmetric sampled matrix with a repeated positive eigenvalue, we determine the upper entropy-production endpoint of the principal branch at every positive tolerance in an explicit relative-radius interval. Exactly two generators maximize entropy, and both are homogeneous cycles with opposite orientations. The exact endpoint is the value at a unique solution of a scalar equation. Its expansion through sixth order, and the optimizer's expansion through third order, hold uniformly throughout the positive resonance regime after rescaling by the repeated eigenvalue.
---

## 1. Setup and results

Let \(\mathbf 1=(1,1,1)^{\mathsf T}\), \(\Pi=\mathbf1\mathbf1^{\mathsf T}/3\), \(H=I-\Pi\), and
\[
 J=\frac1{\sqrt3}
 \begin{pmatrix}
 0&1&-1\\
 -1&0&1\\
 1&-1&0
 \end{pmatrix}.
\]
Thus \(J^2=-H\). Fix sampling interval \(t>0\) and center \(P_\lambda=\Pi+\lambda H\) with \(0<\lambda<\exp(-2\pi\sqrt3)\). Write
\[
 L=-\log\lambda,\qquad \eta=1/L,\qquad r=\varepsilon/(\sqrt2\lambda).
\]
The tolerance \(\varepsilon\) bounds the Frobenius distance between the sampled transition matrix and \(P_\lambda\). We consider exactly three observed states, complete observation of the matrix, known uniform stationarity, and time-homogeneous generators. For a generator with strictly positive off-diagonal rates its entropy-production rate is
\[
 \sigma(Q)=\frac13\sum_{i<j}(q_{ij}-q_{ji})\log(q_{ij}/q_{ji}).
\]
The archived analysis *Sharp Entropy Bands for Finite-Resolution Observations of Three-State Markov Chains* shows that the principal branch has entropy image \([0,M_\varepsilon]\) for sufficiently small tolerance. It supplies the sharp quadratic asymptotic and leaves the finite positive endpoint \(M_\varepsilon\) undetermined.

For \(A>\sqrt3 B>0\), define
\[
 F(A,B)=\frac{2B}{\sqrt3}\log\frac{A+\sqrt3 B}{A-\sqrt3 B}.
\]
For \(|w|<1\) and \(r>0\) sufficiently small let
\[
 z_r(w)=1+r\big(w+i\sqrt{1-w^2}\big),\quad
 A_r(w)=L-\tfrac12\log(1+2rw+r^2),\quad
 B_r(w)=\arg z_r(w),
\]
where the argument lies in the right half-plane.

**Theorem 1.** For \(0<r\le 2^{-12}\), all principal-branch entropy maxima are realized by exactly two generators,
\[
 Q_\pm=\frac1t[-A_r(w_*)H\pm B_r(w_*)J].
\]
Here \(w_*\) is the unique solution in \((-1/2,1/2)\) of
\[
 \frac{w_*+r}{\sqrt{1-w_*^2}}=
 -\frac{\partial_A F(A_r(w_*),B_r(w_*))}
        {\partial_B F(A_r(w_*),B_r(w_*))}.
 \qquad\text{(1)}
\]
The exact endpoint is \(M_\varepsilon=t^{-1}F(A_r(w_*),B_r(w_*))\), and \(\|e^{tQ_\pm}-P_\lambda\|_F=\varepsilon\).

**Theorem 2.** Uniformly for \(L>2\pi\sqrt3\), the optimizer and the attained endpoint have expansions
\[
 w_*=\Big(-1+\frac\eta2\Big)r+
       \Big(-\frac\eta6+\frac{5\eta^3}{8}\Big)r^3+O(r^5)
\]
and
\[
\begin{aligned}
 \frac{Lt M_\varepsilon}{4}
 &=r^2+\left(\frac13-\frac\eta2+\frac{5\eta^2}{4}\right)r^4\\
 &\quad+\left(\frac8{45}-\frac{5\eta}{12}
              +\frac{7\eta^2}{6}-\frac{15\eta^3}{8}
              +\frac{117\eta^4}{40}\right)r^6+O(r^8).
\end{aligned}
\]
In particular the quartic correction is strictly positive on the stated regime. The absence of odd orders follows from an exact reflection symmetry of the optimizer.

## 2. Principal logarithm and scaled entropy

Let \(\mathcal V\) be the real linear space of \(3\times3\) matrices with zero row and column sums. Every stochastic perturbation with uniform stationarity can be written \(P_\lambda+E\) with \(E\in\mathcal V\). Conversely all \(E\in\mathcal V\) satisfying \(\|E\|_F\le\varepsilon\) yield strictly positive doubly stochastic matrices when \(r\) is uniformly small. In fact their smallest entry is at least \((1-\lambda)/3-\varepsilon>0\). Write \(E=\sqrt2\lambda r U\) with \(U\in\mathcal V\) and \(\|U\|_F\le1\). The principal logarithm is the generator
\[
 Q=(-LH+R)/t,\qquad
 R=\log(I+\sqrt2 rU).
 \qquad\text{(2)}
\]
The logarithm is given by its convergent power series for \(\sqrt2 r<1\), preserves the zero-sum constraints, and has \(\|R\|_F\le-\log(1-\sqrt2 r)\). Hence \(tq_{ij}\ge L/3+\log(1-\sqrt2 r)>0\) for \(i\ne j\) and all sufficiently small \(r\), uniformly in \(L\). Formula (2) exponentiates to \(P_\lambda+E\), and describes its principal logarithm on \(\mathbf1^\perp\) and on the stationary direction.

For \(r\ne0\) scale the objective by defining \(\Phi(r,U,\eta)=Lt\sigma(Q)/(4r^2)\). For the physical values \(\eta>0\), the difference-of-logs integral gives
\[
 \Phi(r,U,\eta)=
 \sum_{i<j}\left(\frac{R_{ij}-R_{ji}}{2r}\right)^2
 \int_0^1
 \frac{ds}{1+3\eta[R_{ji}+s(R_{ij}-R_{ji})]} .
 \qquad\text{(3)}
\]
The formula extends real analytically to \(r=0\) and \(\eta=0\). Indeed, the matrix logarithm starts at order \(r\), and the denominators stay bounded away from zero on an open neighborhood of the compact domain \(\|U\|_F\le1,\ 0\le\eta\le(2\pi\sqrt3)^{-1},\ r=0\). The reciprocal-denominator power series is locally uniformly convergent there, so integration preserves analyticity. At \(r=0\),
\[
 \Phi(0,U,\eta)=\frac12\sum_{i<j}(U_{ij}-U_{ji})^2
 =\|\operatorname{skew}U\|_F^2.
 \qquad\text{(4)}
\]
Here are explicit convergence bounds. Complexify \(r,U\), take \(|r|\le1/16\), \(\|U\|_F\le2\), and keep \(0\le\eta\le1/10\) real. Frobenius submultiplicativity gives \(\|R\|_F\le4|r|\) by summing the matrix logarithm series. In (3) the denominators have modulus at least \(37/40\), and the sum of squared moduli of the prefactors is at most \(8\), since \(\sum_{i<j}|R_{ij}-R_{ji}|^2\le2\|R\|_F^2\). Thus \(|\Phi|\le10\). Cauchy's coefficient estimate in \(r\) bounds \(|\Phi(r,U,\eta)-\Phi(0,U,\eta)|\le320|r|\) for \(|r|\le1/32\) and \(\|U\|_F\le2\). For real \(\|U\|_F\le1\), apply the estimate on \(U+zD\) with \(|z|\le1\) and \(\|D\|_F=1\). Cauchy's derivative estimates in \(z\) bound the first and second directional derivatives of the difference by \(320|r|\) and \(640|r|\), respectively. These constants are uniform on the physical range of \(\eta\).

## 3. Identifying every optimizer

Every \(U\in\mathcal V\) decomposes as \(U=S+cJ/\sqrt2\), where \(S\in\mathcal V\) is symmetric, \(c\in\mathbb R\), and \(\|U\|_F^2=\|S\|_F^2+c^2\). This uses the one-dimensionality of the skew matrices on the two-dimensional space \(\mathbf1^\perp\). By (4) the leading objective is \(c^2\).

For \(0<r\le2^{-12}\) the uniform difference between \(\Phi\) and \(c^2\) is at most \(320r<1/8\). At \(U=J/\sqrt2\) the objective exceeds \(7/8\). Any maximizing \(U\) therefore has \(c^2>3/4\), so it lies in one of two caps where \(\|S\|_F<1/2\). In both caps, the derivative with respect to \(c\) has the sign of \(c\), since it differs from \(2c\) by at most \(320r\). A maximizer must be on \(\|U\|_F=1\), since otherwise moving a small distance increasing \(|c|\) improves the objective.

On the boundary of each cap use the chart
\[
 U=S\ \pm\sqrt{1-\|S\|_F^2}\,J/\sqrt2,\qquad \|S\|_F\le1/2.
\]
For every unit direction in the symmetric variable, the chart's first derivative has squared Frobenius norm at most \(4/3\), and its second derivative has norm at most \(8/(3\sqrt3)<2\). These bounds follow by differentiating \(\sqrt{1-\|S\|_F^2}\) and using \(\|S\|_F\le1/2\). The chain rule and the preceding Cauchy bounds show that the chart objective's Hessian differs from that of \(1-\|S\|_F^2\) by at most \(1500r<2\) in each unit direction. The Hessian is therefore negative definite throughout the ball. Transposition preserves the objective and exchanges the caps, because the matrix logarithm commutes with transposition and the entropy formula is unchanged by it. Existence of a global maximizer by compactness, together with strict concavity in each chart and this symmetry, gives exactly one maximizing point in each cap.

A cyclic permutation of the three labels preserves each cap and the objective. Uniqueness forces each maximizing \(S\) to be fixed by the permutation. Its two-dimensional restriction commutes with the rotation by \(2\pi/3\). The commutant on that real plane is spanned by the identity and the quarter-turn, and a symmetric member is a scalar. Equivalently, invariance under a cyclic shift makes every diagonal entry equal and all symmetric off-diagonal entries equal, and the zero-sum condition fixes their ratio. Thus \(S=w H/\sqrt2\) for some \(|w|<1/2\).

On this subfamily the observed eigenvalues on \(\mathbf1^\perp\) are \(\lambda z_r(w)\) and its conjugate, and (2) gives the two rate parameters in Theorem 1. The directed off-diagonal rates of the positive orientation are \((A+\sqrt3 B)/(3t)\) and \((A-\sqrt3 B)/(3t)\), so \(t\sigma=F(A,B)\). The same value holds for the opposite orientation. Direct differentiation gives
\[
 A_r'(w)=-\frac{r}{1+2rw+r^2},\qquad
 B_r'(w)=-\frac{r(w+r)}
                 {\sqrt{1-w^2}(1+2rw+r^2)}.
\]
Here \(\partial_B F>0\) for \(B>0\) and \(A>\sqrt3 B\). Setting the derivative of the scalar objective to zero gives (1). The chart Hessian bound yields strict concavity also along the scalar line, so (1) has just one solution in \((-1/2,1/2)\). At \(w=-r\), the left side of (1) vanishes and the right side is positive. At \(w=0\), its left side is \(r\). To bound the right side there, write \(F(A,B)=A g(B/A)\). Then \(-F_A/F_B=B/A-g(B/A)/g'(B/A)<B/A\), since \(g\) and \(g'\) are positive. At \(w=0\) we have \(A>1\) and \(B=\arctan r<r\), so the right side is smaller than \(r\). Continuity places the root in \((-r,0)\). This proves Theorem 1.

## 4. Uniform endpoint expansion

At \(r=0\) the scalar chart objective is \(1-w^2\). The derivative equation for its analytic continuation in \(r,w,\eta\) has a simple root at \(w=0\), since the derivative with respect to \(w\) of the stationarity function is \(-2\) there. The analytic implicit function theorem and compactness of \(0\le\eta\le(2\pi\sqrt3)^{-1}\) give a uniform analytic expansion of \(w_*\) near \(r=0\). Conjugating \(z_r(w)\) is equivalent to replacing \((r,w)\) by \((-r,-w)\). The entropy is invariant under the resulting reversal of the cycle, and the optimizer is unique in the scalar chart. Hence \(w_*(-r,\eta)=-w_*(r,\eta)\). The endpoint is even in \(r\).

To compute its coefficients, substitute \(w=kr\) with \(k\) bounded. The elementary log and arctangent series give
\[
\begin{aligned}
 A&=L+A_2r^2+A_4r^4+O(r^6),&
 A_2&=-(k+\tfrac12),& A_4&=(2k+1)^2/4,\\
 B&=r+B_3r^3+B_5r^5+O(r^7),&
 B_3&=-k-k^2/2-\tfrac13,&
 B_5&=k^3/2-k^4/8+3k^2/2+k+\tfrac15.
\end{aligned}
\]
Using \(F=4B^2/A+4B^4/A^3+36B^6/(5A^5)+O(B^8/A^7)\), the coefficient of \(r^4\) in \(LF/4\) is
\[
 C_4(k)=2 B_3-\eta A_2+\eta^2
 =-k^2+(\eta-2)k-\tfrac23+\tfrac\eta2+\eta^2.
\]
The coefficient of \(r^6\) is
\[
 C_6(k)=B_3^2+2B_5-2\eta A_2B_3+\eta^2 A_2^2-\eta A_4
                +\eta^2(4B_3-3\eta A_2)+\tfrac95\eta^4.
\]
All expansions here have uniform remainders for \(k\) in a compact neighborhood of \([-1,0]\) and \(\eta\) over its full range. The bounds on \(w_*\) put \(k=w_*/r\) in this range. The stationarity equation gives
\[
 k=k_0+\tfrac12 C_6'(k_0)r^2+O(r^4),\qquad k_0=-1+\eta/2,
\]
where the prime denotes differentiation with respect to \(k\). This follows by differentiating \(LF/4=r^2+C_4(k)r^4+C_6(k)r^6+O(r^8)\) in \(k\) and using \(C_4'(k)=-2(k-k_0)\). The series and its differentiated form converge uniformly near these parameters by the analytic expansions above. Since \(C_4'(k_0)=0\), shifting \(k\) by order \(r^2\) changes the attained value first at order \(r^8\). Substitution yields
\[
\begin{aligned}
 C_4(k_0)&=\tfrac13-\tfrac\eta2+\tfrac54\eta^2,\\
 C_6(k_0)&=\tfrac8{45}-\tfrac5{12}\eta+\tfrac76\eta^2-\tfrac{15}{8}\eta^3+\tfrac{117}{40}\eta^4,\\
 C_6'(k_0)/2&=-\tfrac\eta6+\tfrac58\eta^3 .
\end{aligned}
\]
This proves Theorem 2. The quartic coefficient is positive, for example by \(\eta<1/10\). The \(\eta=0\) extension also gives a check: then the scaled objective is proportional to \(B^2\) and is maximized at \(w=-r\), where \(B=\arcsin r\).

## 5. Entropy interval and comparison

The admissible principal parameter ball in Section 2 is connected and compact. Its entropy image remains exactly \([0,M_\varepsilon]\) at every positive tolerance in Theorem 1. The center realizes zero entropy, and every intermediate value follows by continuity. At \(\varepsilon=0\) the sole principal generator is \(-LH/t\).

The source case used a homogeneous rotation as one feasible lower witness for \(M_\varepsilon\), and its estimates gave only the leading quadratic coefficient. The strict-concavity and cyclic-symmetry argument here forces every maximizer to be homogeneous, even though the tolerance ball includes nonnormal perturbations. The formula also optimizes the shared damping rate, which the fixed-damping witness held at \(L/t\). The above theorem applies to the principal branch for known uniform stationarity, complete observations, and the indicated relative Frobenius radii. The source case treats other branches and the total entropy image under its own stated conditions.
