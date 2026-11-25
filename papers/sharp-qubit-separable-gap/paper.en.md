---
title: "Optimal separable gaps for perfect exclusion with a pure two-qubit probe"
lang: en
---

# Abstract

Fix a pure entangled two-qubit state and choose uniformly among three labeled binary rank-one projective measurements on its first qubit. After observing the binary outcome, a decoder on the second qubit must exclude one measurement label. We maximize the minimum separable-probe error over the measurement triples that the fixed pure probe can exclude perfectly. If \(z\in[0,1)\) is the state's Schmidt probability imbalance, the optimum is constant up to \(z=1/\sqrt{3}\), attained by a trine, and then has a closed form attained by an isosceles Bloch triangle. We characterize all optimizers and obtain the sharp white-noise threshold in this class. The proof identifies perfect exclusion with containment of a centered segment in a triangle and solves the resulting unit-circle extremal problem.

# Setup and main result

Write the fixed probe in Schmidt bases as
\[
 |\psi_z\rangle=\sqrt{(1+z)/2}|00\rangle+\sqrt{(1-z)/2}|11\rangle,
 \qquad 0\le z<1.
\]
Let \(n_1,n_2,n_3\in\mathbb R^3\) be unit vectors. Measurement \(i\) has effects \((I\pm n_i\cdot\sigma)/2\), with the signs treated as labeled classical outcomes. The first qubit is discarded after the device returns its sign. For each sign, the decoder uses a three-effect positive operator-valued measure on the retained system, where effect \(i\) declares that measurement \(i\) was excluded. Error means declaring the label that was actually chosen. All labels have prior probability \(1/3\). The separable benchmark minimizes error over all separable probes with a qubit input and a retained finite-dimensional system, and over the same kind of decoder.

Let \(g(z)\) denote the largest separable benchmark among triples admitting zero error with \(|\psi_z\rangle\). Let \(v=1-z^2\), the squared concurrence, and set
\[
 u(z)=
 \begin{cases}
  1/4, &0\le z\le 1/\sqrt{3},\\[1mm]
  \bigl(4+v-\sqrt{(4+v)^2-32v}\bigr)/16, &1/\sqrt{3}<z<1.
 \end{cases}
\]

**Theorem 1.** The maximum is attained and equals
\[
 g(z)=\frac{1-\sqrt{1-u(z)}}{3}.
\]
For \(z\le 1/\sqrt{3}\) every optimizing triple is a trine on a great circle whose Bloch triangle contains the segment \([-ze_z,ze_z]\), with \(e_z\) the Schmidt axis. For \(1/\sqrt{3}<z<1\), put \(C=\arccos\sqrt{u(z)}\). Every optimizing triple has consecutive angular half-gaps \(C,C,\pi-2C\), in some cyclic order, on a great circle in the plane of \(e_z\). The axis goes through a farthest vertex of the intersection of the triangle with its reflection through the origin. Conversely, any triple satisfying these geometric conditions is optimal. For a trine with \(z>0\), the orientation condition is that \(e_z\) lie in the measurement plane and \(z|e_z\cdot n_i|\le 1/2\) for every \(i\). All in-plane directions work when \(z\le 1/2\). At \(z=1/\sqrt{3}\), the trine admits three unoriented axis lines through opposite farthest vertices. Above this transition the isosceles triangle admits two such lines. At \(z=0\), every great-circle trine is feasible.

In particular the plateau value is \((1-\sqrt{3}/2)/3\). As the squared concurrence \(v\) tends to zero, \(g(z)=v/24+O(v^2)\).

**Corollary 2.** Let \(\rho_\eta=\eta|\psi_z\rangle\langle\psi_z|+(1-\eta)I_4/4\), with \(0\le\eta\le1\). Within triples admitting perfect exclusion with the pure probe, \(\rho_\eta\) beats the separable benchmark for at least one triple exactly when \(\eta>\sqrt{1-u(z)}\). Thus the supremal tolerable white-noise fraction in this class is \(1-\sqrt{1-u(z)}\).

# Proof

## Perfect exclusion and the separable benchmark

For unit Bloch vectors \(b_i\) of pure qubit states, zero-error exclusion is equivalent to \(0\in\operatorname{conv}\{b_1,b_2,b_3\}\). Indeed a positive effect with zero expectation on a pure state is supported on its orthogonal line. It therefore has form \(w_i(I-b_i\cdot\sigma)\) for \(w_i\ge 0\). The three effects sum to \(I\) precisely when \(\sum_i w_i=1\) and \(\sum_i w_i b_i=0\). This argument includes zero effects.

Both signs for every device label occur with positive probability since \(z<1\). The conditional retained states are pure. If the chosen sign is \(s\in\{-1,1\}\), the conditional Bloch vector is
\[
 b_{i,s}=\frac{(s\sqrt v\,n_{ix},-s\sqrt v\,n_{iy},z+s n_{iz})}
                   {1+s z n_{iz}}.
\]
For example, if \(C_z=\operatorname{diag}(\sqrt{(1+z)/2},\sqrt{(1-z)/2})\), the unnormalized retained density matrix is \(C_z[(I+s n_i\cdot\sigma)/2]^{\mathsf T} C_z\). This has trace \((1+s z n_{iz})/2\) and yields the displayed vector. Multiplying each vector by a strictly positive scalar preserves the presence of zero in its convex hull, by rescaling its convex coefficients inversely and renormalizing. The numerators are an invertible affine image of the \(n_i\), with preimage of zero equal to \(-sze_z\). Thus, with \(T=\operatorname{conv}\{n_1,n_2,n_3\}\), the pure probe attains zero error if and only if
\[
 [-ze_z,ze_z]\subseteq T.                                               \tag{1}
\]

For a product probe with local Bloch vector \(r\), the retained state is independent of measurement label and of sign. For each sign the smallest conditional contribution is attained by declaring a label with smallest likelihood of that sign. The minimum error is
\[
 \frac{1}{3}\left(1-\frac{\max_i r\cdot n_i-\min_i r\cdot n_i}{2}\right).
\]
Maximizing the spread over \(|r|\le1\) gives \(D=\max_{i,j}|n_i-n_j|\) by Cauchy–Schwarz and by taking \(r\) parallel to the difference of a farthest pair when \(D>0\). Under a fixed decoder, each product component of a separable probe has error at least \((1-D/2)/3\). Linearity gives the same lower bound for the mixture. The product probe and deterministic sign decoder above attain it. Hence the separable benchmark is exactly
\[
 \operatorname{err}_{\mathrm{sep}}(T)=\frac{1-D/2}{3}.                    \tag{2}
\]
The optimization is consequently a minimum-diameter problem under (1).

## The largest centered segment of an inscribed triangle

Suppose \(0\in T\) and there is no antipodal pair. The origin lies strictly in the relative interior of a nondegenerate triangle in a plane through the origin. Indeed a boundary segment on a line through the origin with unit endpoints would give an antipodal pair. A degenerate convex hull containing zero would have the same property. Thus the vertices lie on a unit circle and their consecutive angular half-gaps \(a,b,c\) all lie in \((0,\pi/2)\), with \(a+b+c=\pi\). If \(C=\max(a,b,c)\), then \(D=2\sin C\) and \(C\ge\pi/3\).

Write \(P=T\cap(-T)\) in this plane. The squared length of the longest centered segment, divided by four, is \(R(T)^2\) with \(R(T)=\max_{p\in P}|p|\). We calculate
\[
 R(T)^2
 =1-\frac{4\cos a\cos b\cos c}{\sin^2 C}.                                \tag{3}
\]
A unit vertex of \(T\) lies in \(-T\) only if it is an original vertex of \(-T\), by strict convexity of the disk. This would imply an antipodal pair. Therefore each vertex of \(P\) is an intersection of a side of \(T\) and a reflected side with a different index. A side and its own reflection lie on distinct parallel lines. Choose the common vertex of the two original sides as \((1,0)\), with its neighbors at angles \(-2a\) and \(2b\). The crossed lines to intersect are
\[
 x-y\tan a=1,\qquad x+y\tan b=-1 .
\]
Their intersection is
\[
 (x,y)=\left(\frac{\tan b-\tan a}{\tan a+\tan b},\frac{-2}{\tan a+\tan b}\right).
\]
Squaring gives \(1+4(1-\tan a\tan b)/(\tan a+\tan b)^2\). Since
\(\tan a+\tan b=\sin c/(\cos a\cos b)\) and
\(1-\tan a\tan b=-\cos c/(\cos a\cos b)\), its squared norm equals
\(1-4\cos a\cos b\cos c/\sin^2 c\). In particular it is strictly within the unit disk, so it lies on both finite chord segments and belongs to \(P\). Interchanging the crossed sides gives its negative. This computation accounts for each pair. The maximum norm over the polygon is attained at a vertex by convexity of the norm. The largest squared norm corresponds to the largest denominator \(\sin^2 C\), proving (3).

For a prescribed largest half-gap \(c=C\in[\pi/3,\pi/2)\), the remaining half-gaps lie in \([\pi-2C,C]\) and have sum \(\pi-C\). Since
\[
 2\cos a\cos b=\cos(a+b)+\cos(a-b),
\]
their cosine product is minimized exactly at \(\{a,b\}=\{C,\pi-2C\}\), where \(|a-b|\) is greatest. With \(u=\cos^2 C\), the maximum feasible \(R(T)^2\) at this \(C\) is
\[
 F(C)=1-\frac{4u(1-2u)}{1-u}.                                             \tag{4}
\]
It follows by substituting \(\cos(\pi-2C)=1-2u\) in (3). The derivative of \(4u(1-2u)/(1-u)\) is \(4(1-4u+2u^2)/(1-u)^2>0\) for \(0<u\le1/4\), so \(F\) is strictly increasing in \(C\). It starts at \(1/3\) and tends to \(1\) as \(C\) approaches \(\pi/2\).

## Optimizers and white noise

A shape is feasible in some orientation exactly when \(R(T)\ge z\). For sufficiency, rotate a farthest point of \(P\) to the Schmidt axis and use the centered segment joining it to its negative. For necessity, (1) places the segment in \(P\). If \(z\le1/\sqrt{3}\), the unique minimizing value of \(C\) is \(\pi/3\), whose three half-gaps all agree. Its orientation need only satisfy (1). If \(z>1/\sqrt{3}\), (4) gives the unique smallest \(C\) by \(F(C)=z^2\), and the shape must attain equality in the cosine product bound. Equation (4) gives \(8u^2-(4+v)u+v=0\), whose smaller root is the stated value in \((0,1/4)\). This also gives \(u=v/4+O(v^2)\) near \(v=0\), which yields the expansion in the theorem. In the regimes where \(R(T)=z>0\), each endpoint of the segment has maximal norm in \(P\). The squared Euclidean norm is strictly convex, so a farthest point must be a vertex. Any such orientation is sufficient. Each maximizing remaining half-gap in (3) contributes one pair of opposite farthest vertices, and the pairs are distinct because no vertex of \(T\) or \(-T\) belongs to \(P\). There are three maximizing half-gaps for the trine and two in the strict isosceles branch. For the trine the side opposite \(n_i\) lies on \(x\cdot n_i=-1/2\), so \(P\) is its in-plane intersection of strips \(|x\cdot n_i|\le 1/2\). This yields the stated orientation condition. All displayed solutions have \(D<2\), while any antipodal case has \(D=2\) and cannot optimize (2). Substitution of \(D/2=\sin C=\sqrt{1-u}\) proves Theorem 1.

For \(I_4/4\), the sign and retained state are independent of label. Every decoder therefore has error \(1/3\). For a fixed pure-perfect triple, linearity and nonnegativity give a lower bound \((1-\eta)/3\) on the error for \(\rho_\eta\), and a pure-perfect decoder attains it. Equation (2) gives a strict advantage if and only if \(\eta>D/2\). Theorem 1 minimizes \(D\) over the stated class, proving Corollary 2. The optimization is conditional on pure perfect exclusion and does not treat triples with positive pure-probe error.

# Relation to the pinned baseline

The repository's pure-entanglement exclusion manuscript provides the qualitative pure-state result, explicit triples with positive separable error, and a sufficient robustness bound. It credits Manna for the qubit construction and asks about optimal noise tolerance. The results here determine the optimal gap and threshold for a specified pure two-qubit probe with uniform prior and three binary rank-one projective tests, conditional on pure perfect exclusion. The comparison is to the pinned repository version in the accompanying source record.
