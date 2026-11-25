---
title: "Parity under anisotropic noise applied after qubit Haar conjugation"
lang: en
---

# Parity under anisotropic noise applied after qubit Haar conjugation

## Abstract

We study relative Loewner errors of qubit Haar moments when a unital channel is applied after the Haar conjugation, independently on every copy of the resulting state. At orders two and three we compute the error for every unital qubit channel. Every anisotropy of its squared Bloch singular values gives a strict odd–even gap at small nonzero radius, with an explicit crossover. For channels whose Bloch matrix has rank at most one, we compute the extremal ratios at every order and prove a unique crossover whenever the gap is present. At large order the crossover is governed by a one-dimensional Gaussian integral, while the rescaled maximal gap has the same leading constant for all rank-one contraction factors. These results concern post-conjugation anisotropy, where a scalar shrinkage of the original input radius does not describe the noisy Haar moment.

## 1. Model and main results

Let \(u\) be uniform on the unit sphere in \(\mathbb R^3\), and write \(\rho_u=(I+r\,u\cdot\sigma)/2\), \(0\le r<1\), where \(\sigma=(\sigma_1,\sigma_2,\sigma_3)\) are the Pauli matrices. The ideal order-\(m\) moment is \(A_m(r)=\mathbb E_u\rho_u^{\otimes m}\). If \(\mathcal N\) is a unital qubit channel with Bloch matrix \(T\), the post-conjugation moment is
\[
B_m(r,T)=\mathbb E_u\,\mathcal N(\rho_u)^{\otimes m},
\qquad \mathcal N(\rho_u)=\tfrac12(I+r(Tu)\cdot\sigma).
\]
Let \(E_m(r,T)\) be the least \(\epsilon\ge0\) with
\((1-\epsilon)A_m(r)\preccurlyeq B_m(r,T)\preccurlyeq(1+\epsilon)A_m(r)\).
For \(r<1\) the ideal moment is positive definite, so the error is the maximum of the upper and lower deviations of the eigenvalues of \(A_m^{-1/2}B_m A_m^{-1/2}\) from one. Conjugating all output copies by the same unitary does not affect those ratios, since \(A_m\) is invariant.

Let \(c_i\in[0,1]\) be the eigenvalues of \(TT^{\mathsf T}\). They lie in this interval because the channel maps the Bloch ball to itself. Write \(x=r^2\) and set
\[
S=c_1+c_2+c_3,\qquad \alpha=3-S,\qquad
D=\sqrt{c_1^2+c_2^2+c_3^2-c_1c_2-c_1c_3-c_2c_3}.
\]

**Theorem 1 (arbitrary unital channel at orders two and three).** With \(G=\alpha x/[3(1-x)]\),
\[
E_2(r,T)=G,\qquad
E_3(r,T)=\max\left\{G,\frac{x(\alpha+2D)}{3(1+x)}\right\}. \tag{1}
\]
If \(D=0\), these errors coincide at every radius. If \(D>0\), the odd error strictly exceeds the even error exactly when
\[
0<r^2<\frac{D}{\alpha+D}. \tag{2}
\]

For the all-order result use the ideal block polynomials of [1],
\[
h_\ell(r^2)=\frac{(1+r)^{\ell+1}-(1-r)^{\ell+1}}{2r(\ell+1)},
\qquad h_\ell(0)=1 .
\]
If the rank of \(T\) is at most one, let \(\lambda\in[0,1]\) be its only possibly nonzero singular value, with \(\lambda=0\) when \(T=0\), and define
\[
P_k(x,\lambda)=\int_0^1(1-\lambda^2 x u^2)^k\,du .
\]

**Theorem 2 (all orders for rank at most one).** For \(k=\lfloor m/2\rfloor\), the extremal eigenvalue ratios are
\[
R_{\rm max}=\frac{P_k(x,\lambda)}{(1-x)^k},\qquad
R_{\rm min}=\frac{P_k(x,\lambda)}{h_m(x)}. \tag{3}
\]
Thus \(E_m=\max\{R_{\rm max}-1,1-R_{\rm min}\}\). For each \(k\ge2\), and also for \(k=1\) with \(\lambda>0\), there is a unique positive crossover \(r_k(\lambda)<1\). The order-\((2k+1)\) error strictly exceeds the order-\(2k\) error exactly on \(0<r<r_k(\lambda)\). For \(k=1\), \(r_1(\lambda)^2=\lambda^2/3\) when \(\lambda>0\), and at \(\lambda=0\) the errors coincide everywhere.

**Theorem 3 (large order for rank at most one).** If \(\lambda_k\to\lambda\in[0,1]\), then \(k r_k(\lambda_k)^2\to b_\lambda\), where \(b_\lambda>0\) is the unique solution of
\[
\int_0^1 \exp(b_\lambda[1-\lambda^2u^2])\,du=2 . \tag{4}
\]
It increases strictly with \(\lambda\), with \(b_0=\log2\). For \(\Delta_k(r,\lambda)=E_{2k+1}(r,T)-E_{2k}(r,T)\) in the rank-at-most-one model,
\[
2k\max_{0\le r<1}\Delta_k(r,\lambda)\longrightarrow
\max_{y\ge0}\frac{y}{\sinh y}(y\coth y-1), \tag{5}
\]
uniformly over \(\lambda\in[0,1]\). The limiting profile at \(r=y/(2k)\) is the function inside the maximum, extended to zero at \(y=0\).

At \(r=1\) and \(m\ge2\), if \(T\) is nonorthogonal then \(\|Tu\|<1\) except on a measure-zero set of directions. The noisy moment is positive definite, while the ideal moment is supported on the symmetric subspace. Its relative Loewner error is then infinite. An orthogonal \(T\) preserves the population of Haar orientations and gives zero error, including at \(r=1\). The finite formulas below are for \(r<1\).

## 2. The two lowest nontrivial orders

Rotate output axes so that \(TT^{\mathsf T}=\operatorname{diag}(c_1,c_2,c_3)\); this diagonalization can be chosen to be a proper rotation. The first and third moments of the centered Bloch random vector vanish by \(u\mapsto-u\), and its second moment gives \(\mathbb E(Tu)_i(Tu)_j=c_i\delta_{ij}/3\).

### 2.1. Order two

Expanding the tensor product gives
\[
B_2=\tfrac14\left[I+\frac{x}{3}\sum_i c_i\sigma_i\otimes\sigma_i\right].
\]
In the Bell basis the singlet has sign pattern \((-1,-1,-1)\), and the three triplets have two positive signs and one negative sign. The normalized ratios are therefore
\[
\frac{1-xS/3}{1-x}\quad\text{and}\quad
\frac{1+x(S-2c_i)/3}{1+x/3}\quad(i=1,2,3).
\]
Write \(c_{\min}=\min_i c_i\) and \(c_{\max}=\max_i c_i\). Comparing the singlet to the largest triplet by cross multiplication gives the difference
\[
\frac{2x}{3}(2-S+c_{\min})
+\frac{2x^2}{9}(S-3c_{\min})\ge0 .
\]
Indeed the two other \(c_i\)'s sum to at most two. The deviation below one of the smallest triplet ratio is \(x(1-S+2c_{\max})/(3+x)\), which is at most \(G\) because \(1-S+2c_{\max}\le\alpha\) and \(3+x\ge3(1-x)\). The singlet lies above or at one and gives deviation \(G\). Thus \(E_2=G\).

### 2.2. Order three

In this case
\[
B_3=\tfrac18\left[I+\frac{x}{3}\sum_i c_i
\sum_{a<b}\sigma_i^{(a)}\sigma_i^{(b)}\right].
\]
For \(J_i=\tfrac12\sum_a\sigma_i^{(a)}\), the pair sum is \(2J_i^2-\tfrac32 I\). On each spin-\(1/2\) copy one has \(J_i^2=I/4\). The resulting normalized ratio is the same \((1-xS/3)/(1-x)\) as the order-two singlet.

On the spin-\(3/2\) block let \(Q=\sum_i c_i J_i^2\) and take the usual \(J_3\) eigenbasis. The first two squared-spin terms can be written as
\[
c_1J_1^2+c_2J_2^2=
\tfrac12(c_1+c_2)(J^2-J_3^2)
+\tfrac14(c_1-c_2)(J_+^2+J_-^2).
\]
The second term connects magnetic labels two apart, giving two \(2\times2\) blocks. Each block has diagonal average \(5S/4\), diagonal half-difference \((2c_3-c_1-c_2)/2\) up to sign, and off-diagonal magnitude \(\sqrt3\,|c_1-c_2|/2\). This follows from the \(2\sqrt3\) two-step raising matrix element. Thus the eigenvalues of \(Q\) are \(5S/4\pm D\), each twice. The normalized ratios on spin \(3/2\) are
\[
\frac{1+x(S\pm2D)/3}{1+x}.
\]
The minus ratio is at most one. With deficits \(a_i=1-c_i\), one has
\(\alpha^2-D^2=3\sum_{i<j}a_i a_j\ge0\), so \(D\le\alpha\). The cross-multiplied difference of the spin-\(1/2\) ratio and the plus ratio is \((2x/3)(\alpha-D+xD)\ge0\). Hence the maximal ratio is the spin-\(1/2\) one, and the minimal ratio is the spin-\(3/2\) minus one. This proves (1). For \(x>0\), the lower deviation exceeds \(G\) exactly when
\((\alpha+2D)(1-x)>\alpha(1+x)\), which gives (2). If \(\alpha=D=0\) both errors vanish. Otherwise the isotropic case has \(D=0\) and yields a plateau.

## 3. Exact spectrum for rank-at-most-one noise

After rotating the output, the Bloch vector \(rTu\) has the same law as \((0,0,\lambda r U)\), where \(U\) is uniform on \([-1,1]\), by the distribution of a coordinate of a uniform sphere point. Write \(d=(m-\ell)/2\) on the spin label \(\ell=m,m-2,\ldots\). The ideal Haar moment has scalar eigenvalue \(2^{-m}(1-x)^d h_\ell(x)\) on that block [1, equation (2)]. For the diagonal output state, the determinant factor contributes \((1-\lambda^2x U^2)^d\). On the symmetric-power factor of degree \(\ell\), a magnetic basis point with \(j\) up entries has product \((1+\lambda r U)^j(1-\lambda r U)^{\ell-j}\). Hence the noisy eigenvalues, apart from the common \(2^{-m}\), are
\[
\mathbb E_U[(1+\lambda r U)^{d+j}(1-\lambda r U)^{d+\ell-j}],
\qquad 0\le j\le\ell .
\]
This calculation uses the same spin blocks as the ideal moment and preserves the identity on the permutation multiplicity space. Consequently division by the displayed ideal value gives every ratio.

For \(s=\lambda r |U|\), averaging the two signs of \(U\) gives \((1-s^2)^{m/2}\cosh((2j-\ell)\operatorname{arctanh}s)\). It is minimized at the most balanced magnetic label and maximized at the extreme ones. At a balanced label, the average numerator is \(P_k(x,\lambda)\) regardless of \(\ell\). Indeed there are \(k\) paired factors, and when \(m\) is odd the extra linear term averages to zero. The ideal denominator is at most \(h_m(x)\), since \((1-x)^d\le1\) and \(h_\ell(x)\le h_m(x)\) from their nonnegative binomial coefficients. At \(\ell=m\) this denominator is achieved. It follows that \(P_k/h_m\) is the global minimum.

For the maximum write \(\ell=2h+e\) and \(m=2k+e\), where \(e\in\{0,1\}\) and \(d=k-h\). Let \(C_\ell(s)=((1+s)^\ell+(1-s)^\ell)/2\). The numerator at an extreme magnetic label is the expectation of \((1-s^2)^{k-h} C_\ell(s)\) over \(s=\lambda r|U|\). Multiplying by \((1-x)^h\) gives at most
\(\mathbb E[(1-s^2)^k C_\ell(s)]\) because \(s^2\le x\). As a function of \(s\in[0,1)\), the first factor decreases and the second increases. Their covariance is nonpositive, by multiplying their opposite-signed increments on two independent copies and taking the expectation. Thus the last expectation is at most \(P_k(x,\lambda)\mathbb E C_\ell(\lambda r|U|)=P_k(x,\lambda)h_\ell(\lambda^2x)\le P_k(x,\lambda)h_\ell(x)\). Dividing by \((1-x)^k h_\ell(x)\) gives the claimed upper bound in (3). The minimum spin label \(\ell=e\) attains it, since \(h_e=1\) and all its magnetic labels are balanced. This proves the extremal formula.

### 3.1. The parity crossover

The two adjacent orders share the upper branch \(G_k=P_k/(1-x)^k-1\). The lower branch at order \(m\) is \(F_m=1-P_k/h_m\), so \(F_{2k+1}>F_{2k}\) when \(x>0\). Here the strict inequality follows from \(h_{2k+1}(x)>h_{2k}(x)>0\) for \(k\ge1\), by comparing their binomial coefficients. In particular the parity gap is positive exactly when \(F_{2k+1}>G_k\).

As a function of \(x\in[0,1)\), \(G_k\) is strictly convex for \(k\ge1\). Under its integral each ratio is
\((1+(1-\lambda^2u^2)x/(1-x))^k\), strictly convex whenever its coefficient is positive, which holds almost everywhere. The function \(F_{2k+1}\) is strictly concave. Indeed \(P_k(x,\lambda)\) is positive, nonincreasing and convex by differentiating its integral. The reciprocal of \(h_m\) shares these properties and is strictly convex for \(m\ge2\). To see this, the closed formula for \(h_m\) has its distinct roots at \(-\tan^2(\pi j/(m+1))\), \(1\le j\le\lfloor m/2\rfloor\), by setting \(r=i\tan(\pi j/(m+1))\). Its constant term is one, so the reciprocal is a product of factors \((1+x\cot^2(\pi j/(m+1)))^{-1}\). Each is positive, decreasing and strictly convex, and their product is also strictly convex. The product with \(P_k\) preserves strict convexity, since both factors are positive and nonincreasing. Thus \(F_m=1-P_k/h_m\) is strictly concave at the relevant orders.

Both competing branches vanish at \(x=0\). Their right derivatives there are
\[
G_k'(0)=k(1-\lambda^2/3),\qquad
F_{2k+1}'(0)=k(2k+1+\lambda^2)/3 .
\]
The second strictly exceeds the first exactly when \(k\ge2\) or \(k=1,\lambda>0\). Dividing both branches by \(x>0\), the ratio for the strictly convex branch strictly increases and the ratio for the strictly concave branch strictly decreases. Near \(x=1\), \(G_k\to\infty\) because \(P_k(1,\lambda)>0\), whereas \(F_{2k+1}\le1\). This proves the unique crossover in those cases and its absence for \(k=1,\lambda=0\). Formula (2) reduces to \(x=\lambda^2/3\) for rank one at \(k=1\), as \(S=D=\lambda^2\). This completes Theorem 2.

## 4. Large-order behavior

### 4.1. Crossover radius

Let \(\lambda_k\to\lambda\) and fix \(y>0\). At \(x=y/k\), dominated convergence gives
\[
1+G_k=\int_0^1
\left(\frac{1-\lambda_k^2(y/k)u^2}{1-y/k}\right)^k du
\longrightarrow \int_0^1 e^{y(1-\lambda^2u^2)}\,du .
\]
At the same radius \(h_{2k+1}(x)\ge1+(2k+1)y/3\to\infty\), by keeping its first nonconstant coefficient. Thus \(1-P_k/h_{2k+1}\to1\). The limiting integral starts at one, strictly increases, and is unbounded as \(y\to\infty\). This holds for \(\lambda=1\) as well because the exponent coefficient is positive for \(u<1\). It therefore equals two at a unique \(b_\lambda>0\). Evaluating the finite crossover inequality at fixed \(y\)'s on either side of \(b_\lambda\) proves (4). The integral is strictly decreasing with \(\lambda\) for any fixed positive \(y\), giving strict increase of \(b_\lambda\). At zero contraction factor it is \(e^y\).

### 4.2. Maximum parity gap

For \(m=2k\), the shared upper branch implies the pointwise bound
\[
0\le\Delta_k(r,\lambda)\le
P_k(x,\lambda)\left(\frac1{h_m(x)}-\frac1{h_{m+1}(x)}\right)
\le\frac1{h_m(x)}-\frac1{h_{m+1}(x)}.
\tag{6}
\]
The first inequality is equality if \(G_k\le1-P_k/h_m\). The last difference is precisely the raw consecutive-order difference in the completely depolarizing radial model. In [2, Sections 2 and 4] its scaling at \(r=y/m\) is proved to be
\(\Psi_0(y)=(y/\sinh y)(y\coth y-1)\) after multiplying by \(m\). The convergence is uniform on compact \(y\)-intervals, and the scaled difference is bounded by \(C y e^{-c y}\) for large \(y=mr\) and by \(y\) near zero, with constants independent of the radius. These facts follow from the consecutive-order logarithmic derivative of \(h_m^{-1}\) and the geometric decay in \(mr\). In particular (6) bounds the limiting maximal gap above by \(\max\Psi_0\).

For a fixed \(y>0\) and \(r=y/m\), \(P_k(x,\lambda)=1+O(kx)\to1\) uniformly in \(\lambda\), using \(0\le1-(1-\lambda^2 x u^2)^k\le kx\). Also \(G_k\to0\) uniformly, while \(1-P_k/h_m(x)\to1-y/\sinh y>0\). Thus the first bound in (6) is an equality for every \(\lambda\) for all large \(k\) at such a radius. The pointwise gap profile follows uniformly there. Together with the compact limit and tail bounds for the raw difference, it proves (5) uniformly over the whole contraction range. In particular the radius of maximum violation has scale \(1/k\), whereas its endpoint has scale \(1/\sqrt k\).

## 5. Source comparison and scope

The finite ideal spin block formula and the radial shrinkage error for pre-conjugation unital channels and post-conjugation depolarization come from [1]. The consecutive-order radial calculation at complete depolarization used in (6) comes from [2]. The contribution here is an exact post-conjugation anisotropy criterion at orders two and three, and an all-order extremal spectrum and sharp limiting laws for the rank-at-most-one post-conjugation model. The all-order formulas require the rank-at-most-one channel structure after the Haar conjugation. Higher-rank spectra above order three remain open in this treatment.

## References

1. *Exact parity criterion for noise in single-qubit unitary designs* (Chinese manuscript), earlier research manuscript at  (archived version), Sections 1–3.
2. *High-order parity gaps and crossover radii for noisy qubit designs*, earlier research manuscript supplement at  (archived version), Sections 2 and 4.
