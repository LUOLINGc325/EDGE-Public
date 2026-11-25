---
title: "Optimal log-concave density confidence bands with exact or binned observations"
lang: en
---

# Abstract

We determine the smooth interior width of log-concave density confidence bands when observations are exact or available only as bin indices. For exact data, the original order-statistic spacing relaxation of Walther, Ali, Shen and Boyd has supremum width \(O_P((\log n/n)^{2/5})\) under local \(C^2\) regularity of the true log density. A certified outward construction preserves this rate and reduces its knot calculations to monotone scalar problems. Any band honest over a fixed strictly curved class must have at least this order at one fixed Gaussian truth. With only equal-width bins of width \(h\), a band based on multiscale bin counts is honest over all univariate log-concave densities and has width \(O_P((\log n/n)^{2/5}\vee h^2)\) under the same local smoothness. Both terms are necessary at the same Gaussian. On locally log-affine regions the binned construction retains a near-parametric rate as \(h\to 0\).

# 1. Model and exact-sample results

Let \(X_1,\ldots,X_n\) be independent with a log-concave density \(f\) on \(\mathbb R\), represented by its upper semicontinuous version. Write \(\varphi=\log f\) on the positive interior of its support. Fix a confidence error \(\alpha\in(0,1)\). The exact-observation band in Sections 2–5 is the construction of Walther–Ali–Shen–Boyd [WASB], equations (4)–(9) and Section 2.4, with **all** the design points in their equation (4). Its coordinate optimization is global.

We allow the feasible set to be empty. In that event the reported confidence set is empty and its positive-part width is defined to be zero. This convention records infeasibility; it does not report a successful confidence statement. On a nonempty feasible set use the extended-real lower and upper endpoints. The empty branch may be represented by the reversed density pair \([1,0]\) at every point. Thus

\[
\mathcal W_n(I)=\sup_{x\in I}[\widehat u_n(x)-\widehat l_n(x)]_+
\tag{1.1}
\]

is the width of the density band. No assertion that the feasible set is nonempty with probability tending to one is needed.

**Theorem 1 (smooth width of the original relaxation).** Suppose \(J\) is an open interval inside the positive support of \(f\), \(\varphi\in C^2(J)\), and \(I\) is a compact interval contained in \(J\). Then

\[
\mathcal W_n(I)=O_P\!\left\{(\log n/n)^{2/5}\right\}.
\tag{1.2}
\]

The original finite-sample simultaneous coverage, at least \(1-\alpha\), is retained. The upper-rate constants can be chosen uniformly when fixed nested compact neighborhoods of \(I\) have common bounds

\[
0<m_0\le f\le M_0,\qquad |\varphi'|\le G,
\qquad -K\le\varphi''\le0,
\tag{1.3}
\]

and the neighborhood margins are bounded below by a positive constant. The common positive lower bound is required on an outer compact buffer as well, so that the inner buffer has a uniform positive probability margin on both sides.

**Theorem 2 (matching honest-band lower bound).** Let \(I\) be a nondegenerate compact interval and \(0<\alpha<1/2\). There is a constant \(c_I>0\) such that every sequence of measurable bands honest at level \(1-\alpha\) over the fixed class of positive \(C^2\) densities satisfying

\[
-5/2\le (\log f)''\le-3/2\quad\text{on }\mathbb R
\tag{1.4}
\]

obeys, at the single fixed density \(f_0(x)=\pi^{-1/2}e^{-x^2}\),

\[
\liminf_{n\to\infty}P_{f_0}^n\!\left\{
\mathcal W_n(I)\ge c_I(\log n/n)^{2/5}\right\}
\ge1-2\alpha.
\tag{1.5}
\]

Honesty over all log-concave densities implies the required honesty over this subclass. The lower bound concerns simultaneous bands, not pointwise intervals. It does not preclude faster widths at log-affine densities.

The main new conclusion is (1.2) for the **original finite-dimensional outer relaxation**. The rate exponent and the spatial-mixture lower-bound method are established statistical ideas. Our deterministic proof develops the supporting-line and concavity mechanism used in [WASB, Appendix 7.2, Lemma 2], with an explicit local affine-defect budget and shrinking intervals. We do not claim that mechanism, the construction of the confidence band, or the known log-affine rate as new.

The \(C^2\) result treats the smooth second-order regime of the published conjecture. Theorem 2 applies even at an analytic Gaussian truth. Section 7 gives an outward-certified scalar construction for exact observations. Section 8 treats observations available only as bin counts and quantifies the loss of spatial resolution. The analysis uses fixed interior intervals and fixed confidence levels.

# 2. The original finite-dimensional constraints

Set

\[
N=n+1,\quad s=\lceil\log_2\log n\rceil,\quad q=2^s,
\quad m=\lfloor(n-1)/q\rfloor+1,
\quad x_i=X_{(1+(i-1)q)}.
\tag{2.1}
\]

We work with sufficiently large \(n\) that the following scales exist. Define

\[
B_{\max}=\lfloor\log_2(n/8)\rfloor-s,\quad
r_B=q2^B,\quad n_B=\lfloor(n-1)/r_B\rfloor,
\quad p_B=r_B/N.
\tag{2.2}
\]

At scale \(B\), the original blocks are

\[
\mathcal I_B=\{[x_{1+(v-1)2^B},x_{1+v2^B}]:1\le v\le n_B\}.
\tag{2.3}
\]

Let

\[
H_n=\sum_{B=0}^{B_{\max}}\frac1{B+2},\qquad
\delta_B=\frac{\alpha}{2(B+2)n_BH_n}.
\tag{2.4}
\]

The lower and upper mass bounds \(c_B,d_B\) are the \(\delta_B\) and \(1-\delta_B\) quantiles of \(\operatorname{Beta}(r_B,N-r_B)\). These are the source's exact beta quantiles, not concentration-bound replacements.

For real vectors \(\ell=(\ell_1,\ldots,\ell_m)\) and \(g=(g_2,\ldots,g_{m-1})\), require

\[
\ell_j\le\ell_i+g_i(x_j-x_i),
\qquad 2\le i\le m-1,\ j\in\{i-1,i+1\}.
\tag{2.5}
\]

Put \(h_i=x_{i+1}-x_i\), \(s_i=(\ell_{i+1}-\ell_i)/h_i\). Let \(\psi\) be the piecewise affine interpolant of the \(\ell_i\). Define the exact cell integrals

\[
L_i=\int_{x_i}^{x_{i+1}}e^{\ell_i+s_i(t-x_i)}\,dt.
\tag{2.6}
\]

On interior cells the source uses

\[
U_i=\int_{x_i}^{x_{i+1}}
e^{\ell_{i+1}+g_{i+1}(t-x_{i+1})}\,dt\quad(i\le m-2),
\tag{2.7}
\]

\[
V_i=\int_{x_i}^{x_{i+1}}
e^{\ell_i+g_i(t-x_i)}\,dt\quad(i\ge2).
\tag{2.8}
\]

At the two exceptional cells, \(U_{m-1}\) uses the left support at \(x_{m-1}\), and \(V_1\) uses the right support at \(x_2\). These conventions are part of the original construction and remain in force. Every integral equals the source's formula using \(E(z)=\int_0^1e^{zt}\,dt\).

For each \([x_j,x_k]\in\mathcal I_B\), impose the three separate constraints

\[
c_B\le\sum_{i=j}^{k-1}U_i,\qquad
c_B\le\sum_{i=j}^{k-1}V_i,\qquad
\sum_{i=j}^{k-1}L_i\le d_B.
\tag{2.9}
\]

Write \(\mathcal V_n\) for this real-vector feasible set. There is no normalization constraint on \(e^\psi\). This is exactly the vector optimization specified by (5)–(9) of [WASB]. If one additionally requires that the nodal values extend to a normalized density, the resulting set is smaller and the width upper bound still applies.

For a nonempty set define the global coordinate endpoints

\[
a_i=\inf_{(\ell,g)\in\mathcal V_n}\ell_i,
\qquad b_i=\sup_{(\ell,g)\in\mathcal V_n}\ell_i.
\tag{2.10}
\]

These endpoints may lie in \(a_i\in[-\infty,\infty)\) and \(b_i\in(-\infty,\infty]\); local finiteness is a proved high-probability property, not an assumption. We neither assume that these extrema are attained nor that the vector \((a_i)_i\) is itself feasible. On interior cells the original lower log band is the linear interpolation of the \(a_i\). Its upper log band is

\[
\widehat b(t)=\min\{b_i+S_i^-(t-x_i),
b_{i+1}+S_{i+1}^+(t-x_{i+1})\},
\tag{2.11}
\]

where

\[
S_i^-=\min_{j<i}\frac{b_i-a_j}{x_i-x_j},\qquad
S_i^+=\max_{j>i}\frac{a_j-b_i}{x_j-x_i}.
\tag{2.12}
\]

At the data boundaries use the one-sided extrapolants of [WASB, Section 2.4]; the lower log band is \(-\infty\) outside the design range. The density band is \(\widehat l=e^{\widehat a}\), \(\widehat u=e^{\widehat b}\). Only the interior formula (2.11) is needed for (1.2). Knot values are assigned directly. On an open cell a lower interpolant with an endpoint \(-\infty\) is \(-\infty\). Upper extrapolants can equivalently be written \((1+t)b_i-ta_j\), with \(t>0\), or their right-sided counterpart. These forms have no undefined subtraction of opposite infinities: an infinite \(b_i\) or \(-a_j\) gives \(+\infty\). The infimum over an empty family is \(+\infty\).

All subsequent upper bounds are deterministic on the stated sample events. Measurability can be made explicit. On the open set of strictly ordered data the finite constraint graph is Borel, since its functions are continuous. Projecting this graph with a coordinate inequality gives analytic sets, so its extrema and nonemptiness event have universally measurable versions. Interpolations and finite extrapolation envelopes preserve universal measurability. Their supremum on a compact interval is a countable supremum over a fixed dense rational set together with the finitely many knots and interval endpoints, using piecewise continuity on open cells. Thus completed-probability interpretations are available; outer-probability bounds hold without choosing versions. Data ties have probability zero in the assumed density model and are assigned the uninformative band.

**Coverage.** For a true log-concave density, choose a supergradient of \(\varphi\) at each interior knot. Its nodal values satisfy (2.5), and its true cell masses lie between \(L_i\) and both appropriate supporting-line upper integrals. The probability content of every scale-\(B\) block is \(\operatorname{Beta}(r_B,N-r_B)\). The union bound gives probability at least

\[
1-\sum_B2n_B\delta_B=1-\alpha
\tag{2.13}
\]

that all true block masses lie between \(c_B,d_B\). On that event the true nodal vector is feasible. Concavity places the true log density above the interpolated lower endpoints and below every valid extrapolant in (2.11)–(2.12). This proves simultaneous coverage, including under the empty-set convention.

# 3. A deterministic affine-comparison bound

This section concerns arbitrary deterministic grids and real feasible vectors. Its usefulness is that a feasible candidate may have very large curvature or highly unequal spacings.

**Lemma 3 (ordered slopes).** Under (2.5),

\[
s_{i-1}\ge g_i\ge s_i,\qquad
g_i\ge g_{i+1}.
\tag{3.1}
\]

Consequently \(\psi\) is concave. For any affine \(A(t)=a+bt\), the residual \(u(t)=\psi(t)-A(t)\) is concave and \(g_i-b\) is nonincreasing.

*Proof.* Divide the two inequalities in (2.5) by the positive adjacent lengths, reversing the inequality for the negative left displacement. This gives the first pair. Inserting \(s_i\) between \(g_i\) and \(g_{i+1}\) gives the second. Nonincreasing consecutive slopes characterize concavity of a continuous piecewise affine function. \(\square\)

An **interior block** is \(B=[x_j,x_k]\) with \(2\le j<k\le m-1\). Write

\[
W(B)=\int_Be^{A(t)}\,dt>0.
\tag{3.2}
\]

**Lemma 4 (a usable block contains a high node).** Suppose the two original lower constraints on an interior block have a positive bound \(c\). If the block does not satisfy \(g_j>b>g_k\), it has a node \(x_v\) such that

\[
u(x_v)\ge\log\{c/W(B)\}.
\tag{3.3}
\]

Among any two ordered blocks with disjoint interiors, at most one satisfies \(g_j>b>g_k\).

*Proof.* If \(g_k\ge b\), then every right supporting-line integrand on the block is at most \(e^{A(t)+M_B}\), where \(M_B=\max_{j\le v\le k}u(x_v)\): indeed

\[
\ell_{i+1}+g_{i+1}(t-x_{i+1})-A(t)
=u(x_{i+1})+(g_{i+1}-b)(t-x_{i+1})\le M_B.
\]

Thus \(c\le\sum U_i\le e^{M_B}W(B)\). If instead \(g_j\le b\), use \(t-x_i\ge0\) and the left supporting lines to obtain \(c\le\sum V_i\le e^{M_B}W(B)\). These cases cover failure of \(g_j>b>g_k\), including equalities. Taking logarithms proves (3.3).

For ordered blocks with \(k\le j'\), two strict crossings would give \(b>g_k\ge g_{j'}>b\), a contradiction. \(\square\)

**Theorem 5 (five-block comparison).** Fix a point \(x\) in the grid range, \(h>0\), and an affine \(A\). Choose two ordered interior blocks in each of

\[
[x-8h,x-2h],\qquad [x+2h,x+8h],
\tag{3.4}
\]

with disjoint interiors on each side. Let their positive lower bounds be \(c_D\). Choose an interior central block \(C\subset[x-h,x+h]\) having the original upper bound \(L(C)=\sum_C L_i\le d_C\), where \(d_C>0\). Set

\[
\lambda=\min_D\log\{c_D/W(D)\},\qquad
\nu=\log\{d_C/W(C)\}.
\tag{3.5}
\]

Then every vector obeying these constraints satisfies

\[
\boxed{\lambda\le\psi(x)-A(x)\le2\nu-\lambda.}
\tag{3.6}
\]

*Proof.* Lemma 4 selects one high node on each side, say \(y_-\le x-2h\) and \(y_+\ge x+2h\), with \(u(y_\pm)\ge\lambda\). The chosen block can depend on the candidate vector; the minimum in (3.5) is over all four fixed blocks, so the bound is uniform over vectors. Concavity gives \(u(x)\ge\lambda\).

For \(t\in C\) to the left of \(x\), write \(t=(1-\theta)x+\theta y_-\), where \(0\le\theta\le1/2\). Then

\[
u(t)\ge(1-\theta)u(x)+\theta\lambda
\ge\{u(x)+\lambda\}/2.
\tag{3.7}
\]

Use \(y_+\) on the right. Integration over \(C\) now gives

\[
d_C\ge\int_Ce^{\psi(t)}dt
\ge e^{\{u(x)+\lambda\}/2}W(C).
\]

Taking logarithms proves (3.6). The central block need not be symmetric about \(x\), and \(x\) need not be a grid node. \(\square\)

**Two restrictions that matter.** The proof uses interior blocks, so it never applies a right-support formula to the exceptional last cell or a left-support formula to the exceptional first cell. Nor does it replace (2.9) by \(c\le\sum\min(U_i,V_i)\). The latter replacement is false. For six equally spaced nodes take

\[
\ell=(-2M,-M,0,0,0,-M),\quad (g_2,g_3,g_4,g_5)=(M,M,0,-M),\quad M>0.
\]

On the original dyadic block \([x_3,x_5]\), \(U=(1,E(M))\), \(V=(E(M),1)\), and \(L=(1,1)\). The two original lower constraints can hold for \(2<c\le1+E(M)\), although \(\sum\min(U_i,V_i)=2<c\). This refutes the local substitution, not full feasibility under every scale constraint. It is a crossing block; Lemma 4 avoids it.

**Corollary 6 (local affine-defect oracle).** Let \(\varphi\) be a true concave log density on \([x-8h,x+8h]\), and choose a supporting affine function \(A\) with \(A(x)=\varphi(x)\). Define

\[
\omega_f(x,h;A)=\sup_{|t-x|\le8h}\{A(t)-\varphi(t)\}.
\tag{3.8}
\]

Suppose the four flanking bounds obey \(c_D\ge(1-\varepsilon)P_f(D)\), the central bound obeys \(d_C\le(1+\varepsilon)P_f(C)\), and \(0\le\varepsilon\le1/2\). Every feasible vector then obeys

\[
\log(1-\varepsilon)-\omega_f
\le\psi(x)-\varphi(x)
\le2\log(1+\varepsilon)-\log(1-\varepsilon)+\omega_f.
\tag{3.9}
\]

Its pointwise log diameter is at most

\[
2\log\frac{1+\varepsilon}{1-\varepsilon}+2\omega_f,
\tag{3.10}
\]

and \(|\psi(x)-\varphi(x)|\le4\varepsilon+\omega_f\).

*Proof.* The supporting-line property gives \(e^{-\omega_f}W(D)\le P_f(D)\le W(D)\). Therefore \(\lambda\ge\log(1-\varepsilon)-\omega_f\) and \(\nu\le\log(1+\varepsilon)\). Apply (3.6), then use \(\log(1+\varepsilon)\le\varepsilon\) and \(-\log(1-\varepsilon)\le2\varepsilon\). \(\square\)

For \(-K\le\varphi''\le0\), its tangent has

\[
\omega_f(x,h)\le32Kh^2.
\tag{3.11}
\]

Only the **true** log density appears in this curvature condition.

# 4. Simultaneous control of the exact beta constraints

**Lemma 7 (a sufficient beta concentration bound).** If \(Z\sim\operatorname{Beta}(r,N-r)\), \(1\le r<N\), \(p=r/N\), \(t\ge1\), and \(N\ge64t\), then

\[
P\{|Z-p|>D(p,t)\}\le4e^{-t},\qquad
D(p,t)=8\sqrt{pt/N}+8t/N.
\tag{4.1}
\]

*Proof.* Represent \(Z=S_r/S_N\), where \(S_j\) sums \(j\) independent mean-one exponential variables. For an integer \(j\), its centered logarithmic moment generating function is

\[
\log E e^{\lambda(S_j-j)}=j\{-\log(1-\lambda)-\lambda\}.
\]

For \(0\le\lambda<1\), the expression in braces is at most \(\lambda^2/[2(1-\lambda)]\); this follows by comparing power-series coefficients. The corresponding negative-\(\lambda\) bound is at most \(\lambda^2/2\). The Chernoff argument gives, in particular, the looser convenient bound

\[
P\{|S_j-j|>2\sqrt{jt}+2t\}\le2e^{-t}.
\tag{4.2}
\]

Apply it to \(j=r,N\). On the joint event \(S_N\ge N/2\), since \(2\sqrt{t/N}+2t/N\le9/32\). Therefore

\[
\left|\frac{S_r}{S_N}-p\right|
\le\frac2N\{2\sqrt{rt}+2t+p(2\sqrt{Nt}+2t)\}
\le8\sqrt{pt/N}+8t/N,
\]

where \(p\le\sqrt p\). The union bound proves (4.1). No independence of \(S_r\) and \(S_N\) was used. \(\square\)

Fix \(0<\eta<1\) and put

\[
T_B=\log\frac{8(B+2)n_BH_n}{\alpha\eta},\qquad
D_B=8\sqrt{p_BT_B/N}+8T_B/N.
\tag{4.3}
\]

For all sufficiently large \(n\), Lemma 7 applies at every scale. Since \(4e^{-T_B}=\eta\delta_B\le\delta_B\), continuity of the beta distribution implies

\[
c_B\ge p_B-D_B,\qquad d_B\le p_B+D_B.
\tag{4.4}
\]

For the true spacings it also implies a simultaneous event \(\mathcal E_{n,\eta}\), of probability at least \(1-\alpha\eta/2\), on which

\[
|P_f(D)-p_B|\le D_B
\quad\text{for all }B\text{ and }D\in\mathcal I_B.
\tag{4.5}
\]

Indeed, summing \(4n_Be^{-T_B}\) gives \(\alpha\eta/2\). Whenever \(D_B\le p_B/8\), define

\[
\varepsilon_B=4D_B/p_B\le1/2.
\tag{4.6}
\]

Then (4.4)–(4.5) give simultaneously

\[
c_B\ge(1-\varepsilon_B)P_f(D),\qquad
d_B\le(1+\varepsilon_B)P_f(D).
\tag{4.7}
\]

For example, \((p_B+D_B)/(p_B-D_B)\le1+4D_B/p_B\). This event is distinct from the coverage event: it does not require the true density to satisfy all exact confidence constraints.

# 5. Grid geometry, upper rate and continuous extension

## 5.1. The truncated last block

Choose a compact \(J_0\) inside \(J\), containing a fixed neighborhood of \(I\), with \(f\ge m_0>0\) on \(J_0\). At scale \(B\) the last endpoint is \(X_{(e_B)}\), where \(e_B=1+n_Br_B\). It need not equal \(x_m\). Its missing-tail rank

\[
R_B=N-e_B=n-n_Br_B\in\{1,\ldots,r_B\}
\]

gives

\[
1-F(X_{(e_B)})\sim\operatorname{Beta}(R_B,N-R_B),
\quad E[1-F(X_{(e_B)})]\le p_B.
\tag{5.1}
\]

Also \(E F(X_{(1)})=1/N\). Thus for any deterministic scale sequence with \(p_B\to0\), Markov's inequality proves that its partition covers \(J_0\) with probability tending to one.

For an oracle simultaneous over several scales, choose \(p_*>0\) below one quarter of both tail probabilities at the endpoints of \(J_0\). Beta variance is at most \(1/[4(N+1)]\); hence each scale with \(p_B\le p_*\) fails to have tail mass below \(2p_*\) with probability at most \(1/[4(N+1)p_*^2]\). A union over \(O(\log n)\) scales still tends to zero. The left extreme is handled by \(P(F(X_{(1)})>2p_*)=(1-2p_*)^n\).

## 5.2. Selecting the five actual blocks

For an admissible scale put

\[
h_B=16p_B/m_0.
\tag{5.2}
\]

Suppose its partition covers \([x-9h_B,x+9h_B]\subset J_0\), (4.5) holds, and \(D_B\le p_B/8\). A block intersecting \([x-8h_B,x+8h_B]\) cannot have an endpoint outside \([x-9h_B,x+9h_B]\): it would contain an interval of length \(h_B\) with probability at least \(m_0h_B=16p_B\), contradicting its probability at most \(9p_B/8\). Consequently its physical length is at most

\[
\frac{9p_B}{8m_0}<h_B/8.
\tag{5.3}
\]

The block containing \(x\) is therefore a permissible central block. Each of the four windows

\[
[x-7h_B,x-6h_B],\ [x-4h_B,x-3h_B],
\ [x+3h_B,x+4h_B],\ [x+6h_B,x+7h_B]
\tag{5.4}
\]

contains a whole partition block: the first partition endpoint after its left edge is within one maximal block length, and the next endpoint is within two. All five blocks are strictly interior, satisfy the original constraints, and meet Theorem 5. This argument applies simultaneously to every \(x\) whose buffered window lies in \(J_0\).

Combining Corollary 6 with (4.7) proves the explicit oracle

\[
|\psi(x)-\varphi(x)|
\le\inf_{B\ \mathrm{admissible}}
\{4\varepsilon_B+\omega_f(x,h_B;A_x)\}.
\tag{5.5}
\]

The same sample event works for all feasible candidates and all admissible scales. The affine reference and scale in this bound are analytical choices; the band itself is unchanged.

## 5.3. Smooth rate at all local knots

Let \(a_n=(\log n/n)^{1/5}\). For large \(n\), dyadic scales include a deterministic \(B_n\) with

\[
p_{B_n}\in[m_0a_n/16,m_0a_n/8).
\tag{5.6}
\]

This follows because their smallest mass is \(\Theta(\log n/n)\), their largest mass is bounded below by a positive constant, and successive masses double. Thus \(h_{B_n}\asymp a_n\), \(T_{B_n}=O(\log n)\), and

\[
\varepsilon_{B_n}
=O\!\left(\sqrt{\frac{\log n}{na_n}}+
\frac{\log n}{na_n}\right)=O(a_n^2).
\tag{5.7}
\]

In particular the admissibility inequality \(D_B\le p_B/8\) eventually holds. The partition covers the required fixed neighborhood with probability tending to one by (5.1). Its physical window fits inside \(J_0\) uniformly over a smaller compact buffer \(J_1\) around \(I\). On \(\mathcal E_{n,\eta}\), (3.11) and (5.5) give

\[
\sup_{x\in J_1}|\psi(x)-\varphi(x)|\le C_\eta a_n^2
\quad\text{for every feasible candidate.}
\tag{5.8}
\]

Letting \(\eta\) be arbitrarily small gives the asserted stochastic order. Neither the event that the truth is feasible nor a smoothness assumption on a candidate was used.

The finest-grid mass bound \(p_0+D_0=O(\log n/n)\), together with \(f\ge m_0\) on a buffer, similarly gives the maximum local mesh

\[
\Delta_n=O_P(\log n/n)=o_P(a_n^2).
\tag{5.9}
\]

A finest cell meeting \(J_1\) cannot leave its fixed buffer for large \(n\), because crossing that buffer would require a fixed positive probability mass.

## 5.4. Passing to the published continuous band

On a nonempty feasible set, take infima and suprema in (5.8). For every local knot,

\[
|a_i-\varphi(x_i)|\le E_n,\qquad
|b_i-\varphi(x_i)|\le E_n,
\quad E_n=C_\eta a_n^2.
\tag{5.10}
\]

No common extremizing vector is needed. The lower log interpolation satisfies

\[
\widehat a(t)\ge\varphi(t)-E_n-K\Delta_n^2/8.
\tag{5.11}
\]

To bound the upper formula, choose a fixed \(d>0\) small enough that for all knots in the relevant cells there are knots \(x_j<x_i\) at distance between \(d\) and \(2d\), inside \(J_1\). Such knots exist once \(\Delta_n<d/2\). One allowed term in the minimum defining \(S_i^-\) gives

\[
S_i^-\le G+2E_n/d.
\]

For \(t\in[x_i,x_{i+1}]\), (2.11) is no larger than its left extrapolant, so

\[
\widehat b(t)\le\varphi(t)+E_n+2G\Delta_n+2E_n\Delta_n/d.
\tag{5.12}
\]

The finitely many local endpoint quantities involved are finite by (5.10). Remote terms in the original minimum can only decrease this upper bound. For a nonempty feasible set, the extension covers every feasible concave polygon, so the lower log band does not exceed the upper log band in the interval considered. Since \(f\) is bounded there, exponentiating (5.11)–(5.12) gives

\[
\sup_{t\in I}(\widehat u(t)-\widehat l(t))
\le C\{E_n+\Delta_n\}=O_P(a_n^2).
\]

An empty band has zero positive-part width by definition. This proves Theorem 1.

If one restricts \(\mathcal V_n\) further, each \(a_i\) increases and each \(b_i\) decreases. Every upper extrapolant in (2.11) is nondecreasing in all the \(b_i\) it uses and nonincreasing in all the \(a_j\) it uses. The upper band therefore decreases, and the lower interpolation increases. The larger vector relaxation is sufficient to bound the density-normalized interpretation as well.

## 5.5. Adaptation consequences and their scope

If the supporting-line defect is bounded by \(C|t-x|^\beta\) uniformly locally, with \(1<\beta\le2\), (5.5) gives the upper rate

\[
O_P\!\left\{(\log n/n)^{\beta/(2\beta+1)}\right\}
\tag{5.13}
\]

by taking \(h\asymp(\log n/n)^{1/(2\beta+1)}\). We make no matching-lower-bound claim for every such class.

If \(\varphi\) is affine on a fixed neighborhood, take an admissible fixed-order positive mass scale. Then \(n_B=O(1)\), \(B=\Theta(\log n)\), and \(H_n=\Theta(\log\log n)\). Hence \(T_B=O(\log\log n)\) and the same oracle gives \(O_P(\sqrt{\log\log n/n})\). This recovers the adaptation already proved in [WASB]; it is an internal consistency check, not another new theorem claim.

# 6. A direct matching lower bound

We prove Theorem 2 with explicit perturbations. The method also shows why an analytic true density alone cannot force a faster rate for a band required to be honest over a larger shape-constrained class.

## 6.1. A compactly supported zero-mass bump

Define

\[
\zeta(u)=
\begin{cases}
(1-4u^2)^3(1-36u^2),&|u|\le1/2,\\
0,&|u|>1/2.
\end{cases}
\tag{6.1}
\]

This is \(C^2(\mathbb R)\), since the polynomial has a third-order zero at either endpoint. Direct polynomial integration gives

\[
\zeta(0)=1,\qquad \int\zeta=0,\qquad
B_\zeta:=\int\zeta^2=\frac{65536}{255255}.
\tag{6.2}
\]

Its expansion is \(2304u^8-1792u^6+480u^4-48u^2+1\). Safe bounds are

\[
B_0=\|\zeta\|_\infty=1,\quad
B_1=\|\zeta'\|_\infty\le96,\quad
B_2=\|\zeta''\|_\infty\le3456.
\tag{6.3}
\]

For the first bound put \(z=4u^2\in[0,1]\): \((1-z)^3(1-9z)\) has maximum 1 and minimum \(-16/27\). The derivatives factor as

\[
\zeta'(u)=96u(2u-1)^2(2u+1)^2(12u^2-1),
\]

\[
\zeta''(u)=96(2u-1)(2u+1)(336u^4-56u^2+1).
\]

The displayed coarse derivative bounds follow on \(|u|\le1/2\). The accompanying rational certificate independently verifies the identities, endpoint matching, integrals and safe bounds. It is a certificate for these polynomial facts, not a proof of the statistical theorem.

## 6.2. Fixed smooth strictly concave class

Choose \(I_0=[a_0,b_0]\subset\operatorname{int}I\), with length \(\ell>0\), and put

\[
R=\max(|a_0|,|b_0|),\quad
m_* =\inf_{I_0}f_0>0,\quad
C_1=B_1+2RB_0,
\quad C_2=B_2+4RB_1+(2+4R^2)B_0.
\]

Fix a positive amplitude

\[
A\le\min\{m_*/(2B_0),\ m_*/(8C_2),\ m_*/(4C_1)\}.
\tag{6.4}
\]

For \(0<h\le1\), let \(M=\lfloor\ell/h\rfloor\), take centers \(t_j=a_0+(j-1/2)h\), and define

\[
f_j(x)=f_0(x)+Ah^2\zeta((x-t_j)/h),\qquad 1\le j\le M.
\tag{6.5}
\]

The perturbations have disjoint interiors of support. By (6.2), every \(f_j\) integrates to exactly one; no normalization correction changes it elsewhere.

On a perturbation support write \(f_j=f_0(1+v_j)\). Since \(f_0^{-1}=\sqrt\pi e^{x^2}\), differentiating gives

\[
\|v_j\|_\infty\le AB_0/m_*,\quad
\|v_j'\|_\infty\le AC_1/m_*,\quad
\|v_j''\|_\infty\le AC_2/m_*.
\tag{6.6}
\]

The factors of \(h\) in the last two derivatives are at most one. Thus \(1+v_j\ge1/2\), and

\[
|\{\log(1+v_j)\}''|
\le2\|v_j''\|_\infty+4\|v_j'\|_\infty^2\le1/2.
\]

It follows that \(-5/2\le(\log f_j)''\le-3/2\). Outside the bump, the curvature is exactly \(-2\). The matching derivatives at support endpoints make each density globally positive and \(C^2\). All alternatives and \(f_0\) belong to the one fixed class (1.4), independently of \(n\) and \(h\). At the own center,

\[
f_j(t_j)-f_0(t_j)=Ah^2.
\tag{6.7}
\]

## 6.3. Mixture indistinguishability

Let \(P_j\) have density \(f_j\) and let

\[
Q_n=M^{-1}\sum_{j=1}^MP_j^{\otimes n}.
\tag{6.8}
\]

One common index is selected for the entire sample. This is not the product of the one-observation mixture.

Zero mass and disjoint support imply, for \(j\ne k\),

\[
\int\frac{f_jf_k}{f_0}=1.
\tag{6.9}
\]

For a diagonal term put

\[
V_j=\int\frac{(f_j-f_0)^2}{f_0}
\le\frac{A^2B_\zeta}{m_*}h^5=:C_0h^5.
\tag{6.10}
\]

Expanding the square of the sample-mixture likelihood ratio gives the exact identity and bound

\[
\chi^2(Q_n,P_0^{\otimes n})
=\frac1{M^2}\sum_{j=1}^M\{(1+V_j)^n-1\}
\le\frac{e^{nC_0h^5}-1}{M}.
\tag{6.11}
\]

Choose \(h=h_n=(\gamma\log n/n)^{1/5}\) with \(C_0\gamma<1/5\), for example \(\gamma=(20C_0)^{-1}\). Then \(M\asymp h_n^{-1}\) and (6.11) tends to zero. Cauchy–Schwarz yields

\[
\|Q_n-P_0^{\otimes n}\|_{\rm TV}
\le\tfrac12\sqrt{\chi^2(Q_n,P_0^{\otimes n})}=o(1).
\tag{6.12}
\]

## 6.4. From honesty to width at the fixed truth

Let \(A_0\) be the event that the band covers \(f_0\) throughout \(I\); let \(A_j\) be the corresponding event for \(f_j\), and \(A=\bigcup_{j=1}^M A_j\). Honesty gives \(P_0^n(A_0)\ge1-\alpha\) and

\[
Q_n(A)\ge M^{-1}\sum_jP_j^n(A_j)\ge1-\alpha.
\]

Consequently

\[
P_0^n(A_0\cap A)\ge1-2\alpha-\|Q_n-P_0^n\|_{\rm TV}.
\tag{6.13}
\]

On this event the band contains \(f_0\) and at least one \(f_j\), so its width at \(t_j\) is at least \(Ah_n^2\). In particular the finite-sample inequality is

\[
P_0^n\{\mathcal W_n(I)\ge Ah_n^2\}
\ge1-2\alpha-\frac12
\sqrt{\frac{e^{nC_0h_n^5}-1}{\lfloor\ell/h_n\rfloor}}.
\tag{6.14}
\]

Taking \(c_I=A\gamma^{2/5}\) proves Theorem 2. The proof works for empty bands as well: an empty band belongs to none of the coverage events used in (6.13).

# 7. A globally certified scalar construction

The original global extrema remain the object of Theorem 1. We now construct a second band which contains those extrema at the knots, retains their smooth rate, and needs only monotone scalar equations. Its endpoints need not equal the original extrema. The new result is an outward certificate for the original relaxation, rather than a convergence theorem for its nonconvex numerical solver.

## 7.1. One root optimizes both endpoints

The outer radius \(8h\) in Theorem 5 was used only to bound the approximation defect. Its proof remains valid with any fixed outer radius \(Rh\), \(R\ge2\). Here use the stricter separation

\[
D_{L,1},D_{L,2}\subset[x-12h,x-3h],\quad
D_{R,1},D_{R,2}\subset[x+3h,x+12h],\quad C\subset[x-h,x+h].
\tag{7.1}
\]

Blocks on each side are ordered with disjoint interiors; all five are interior original blocks. Define

\[
W_D(b)=\int_D e^{b(t-x)}\,dt,\quad
\lambda_L(b)=\min_{D\text{ left}}\log\frac{c_D}{W_D(b)},\quad
\lambda_R(b)=\min_{D\text{ right}}\log\frac{c_D}{W_D(b)},
\tag{7.2}
\]

\[
\lambda(b)=\min\{\lambda_L(b),\lambda_R(b)\},\quad
\nu(b)=\log\frac{d_C}{W_C(b)},\quad F(b)=2\nu(b)-\lambda(b).
\tag{7.3}
\]

These functions are finite and continuous for real \(b\). Theorem 5 with \(A(t)=b(t-x)\) gives, for every feasible vector and every \(b\),

\[
\lambda(b)\le\psi(x)\le F(b).
\tag{7.4}
\]

**Theorem 8 (common scalar optimizer and finite certificates).** The function \(H=\lambda_L-\lambda_R\) has a unique zero \(b_*\), which uniquely maximizes \(\lambda\) and uniquely minimizes \(F\) globally. For \(\Delta=b_2-b_1\ge0\),

\[
6h\Delta\le H(b_2)-H(b_1)\le24h\Delta.
\tag{7.5}
\]

If \(b_-\le b_*\le b_+\), set

\[
\begin{split}
L_{\mathrm{cert}}&=\max\{\lambda_L(b_-),\lambda_R(b_+)\},\\
U_{\mathrm{cert}}&=\min\{2\nu(b_-)-\lambda_L(b_-),
                         2\nu(b_+)-\lambda_R(b_+)\}.
\end{split}
\tag{7.6}
\]

Then

\[
L_{\mathrm{cert}}\le\lambda(b_*)\le\psi(x)
 \le F(b_*)\le U_{\mathrm{cert}},
\tag{7.7}
\]

and, for \(w=b_+-b_-\),

\[
0\le\lambda(b_*)-L_{\mathrm{cert}}\le12hw,\qquad
0\le U_{\mathrm{cert}}-F(b_*)\le14hw.
\tag{7.8}
\]

*Proof.* Differentiation under the integral on a finite interval \(D=[a,d]\) gives

\[
\frac{d}{db}\log W_D(b)
=\frac{\int_D(t-x)e^{b(t-x)}\,dt}{\int_D e^{b(t-x)}\,dt}
\in[a-x,d-x].
\tag{7.9}
\]

Each left constituent of \(\lambda_L\) has increments in \([3h\Delta,12h\Delta]\), and each right constituent of \(\lambda_R\) has increments in \([-12h\Delta,-3h\Delta]\). A minimum of functions with common increment bounds inherits those bounds: use a minimizing index at \(b_1\) for the upper inequality and one at \(b_2\) for the lower inequality. This proves (7.5), including at active-block switches. The continuous function \(H\) is strictly increasing, tends to opposite infinities, and has exactly one zero.

Before the zero, \(\lambda=\lambda_L\) strictly increases; afterward, \(\lambda=\lambda_R\) strictly decreases. Put \(F_L=2\nu-\lambda_L\), \(F_R=2\nu-\lambda_R\). Each is the maximum over its two blocks of

\[
2\log d_C-\log c_D+\log W_D-2\log W_C.
\]

By (7.9), left constituents have increments in \([-14h\Delta,-h\Delta]\), and right constituents have increments in \([h\Delta,14h\Delta]\). Their maxima inherit these bounds. Since \(F=\max(F_L,F_R)\) and \(F_L-F_R=-H\), the same crossing uniquely minimizes \(F\). Branch monotonicity proves (7.7), and the Lipschitz bounds prove (7.8). No differentiability of a minimum envelope is required. \(\square\)

If \(M\ge |H(0)|\), an explicit starting bracket is

\[
[-M/(6h),M/(6h)].
\tag{7.10}
\]

If a certified midpoint evaluation gives \(H(b_m)\in[L,U]\) with \(L\le0\le U\), strong monotonicity gives the replacement bracket

\[
[b_m-U/(6h),\,b_m-L/(6h)]
\tag{7.11}
\]

intersected with the old bracket. Otherwise use ordinary sign bisection. Refined interval precision makes (7.11) arbitrarily short even at an exact root, so equality causes no infinite sign-decision loop. For log-endpoint error at most \(\rho>0\), make \(14hw\) and endpoint evaluation errors at most suitable fractions of \(\rho\). Bisection uses \(O(1+\log(1+M/\rho))\) arithmetic queries with refined accuracy. This is not a uniform bit complexity bound for arbitrary rational data.

There is also a robust fallback: any finite set of slopes \(\mathcal B\) yields valid endpoints

\[
\max_{b\in\mathcal B}\lambda(b),\qquad
\min_{b\in\mathcal B}F(b).
\tag{7.12}
\]

Thus premature termination can preserve validity while explicitly declining the requested tightness certificate.

## 7.2. An observable multiscale rule

For each knot \(x_i\) and original scale \(B\), select its containing block \(C=D_v\), using the right block at an internal partition endpoint and the last block at the final endpoint. Skip the scale if the knot lies outside its completed partition. Set

\[
h=2|D_v|,\qquad
(D_{L,1},D_{L,2},D_{R,1},D_{R,2})
=(D_{v-16},D_{v-8},D_{v+8},D_{v+16}).
\tag{7.13}
\]

Use the scale only if all five blocks exist, are interior, and satisfy the observed geometric checks (7.1). This rule uses no unknown curvature, density lower bound or tuning bandwidth. Compute the certified endpoints of Theorem 8 at each usable scale. Let \(\widetilde a_i\) be the maximum lower log endpoint and \(\widetilde b_i\) the minimum upper log endpoint over usable scales. If none is usable, set \((\widetilde a_i,\widetilde b_i)=(-\infty,+\infty)\).

These intervals contain every coordinate projection of \(\mathcal V_n\). If any nodal interval is reversed, report an empty certificate band; this detects incompatibility and is never a coverage success. Otherwise apply (2.11)–(2.12) to the new endpoints. Use lower density zero and upper density \(+\infty\) outside the grid when a finite one-sided certificate is unavailable. At any point where the extended endpoints cross, the set-valued interval is empty with positive-part width zero. On the beta-coverage event all nodal and continuous intervals contain the truth, so no crossing occurs.

**Theorem 9 (honesty, width and computational reduction).** This band has simultaneous coverage at least \(1-\alpha\) for all univariate log-concave densities. Under Theorem 1's assumptions, its compact-interior supremum width is

\[
O_P\{(\log n/n)^{2/5}\}.
\tag{7.14}
\]

This holds for exact root endpoints and outward numerical endpoints with additional log errors at most \(\rho_n=n^{-1}\). On a log-affine neighborhood the width is \(O_P(\sqrt{\log\log n/n})\). With all source knots, there are at most

\[
m(B_{\max}+1)=O(n)
\tag{7.15}
\]

scalar root problems, following sorting and \(O(\log n)\) beta-quantile calibrations. This does not count their bit cost or the full continuous envelope: direct evaluation on a requested cell may inspect \(O(m)\) supporting slopes.

*Proof.* Every scale certificate contains all original feasible nodal values. Intersecting data-dependent usable scales preserves this because all original mass constraints are simultaneously valid on the same event (2.13). Concavity proves continuous coverage. No further multiplicity allocation is needed.

For the width, choose a deterministic dyadic scale \(p_B\asymp a_n=(\log n/n)^{1/5}\). On \(\mathcal E_{n,\eta}\), block masses equal \(p_B(1+o(1))\) uniformly, since \(D_B/p_B\to0\). The completed partition covers a fixed compact buffer around \(I\) with probability tending to one. Positive density on a larger buffer ensures that all 33 blocks \(v-16,\ldots,v+16\), for every central block meeting the smaller buffer, lie in that larger buffer eventually. Their total probability is at most \(34(p_B+D_B)\), whereas exiting would cross a fixed positive-probability interval. Their total physical length is therefore \(O(p_B)\), uniformly.

Uniform continuity and positivity of \(f\) imply that their average densities are \(f(x_i)(1+o(1))\), uniformly. Dividing comparable masses by these averages gives

\[
|D_{v+j}|/|D_v|=1+o(1),\qquad |j|\le16.
\tag{7.16}
\]

Ratios in \([7/8,9/8]\) suffice for the checks. The nearest flank is at least seven intervening block lengths from an edge of \(C\), so its distance is at least \(7(7/8)|C|>6|C|=3h\). The farthest endpoint is at most \(17(9/8)|C|<24|C|=12h\) away. Also \(C\subset[x_i-h,x_i+h]\). Thus the rule is usable simultaneously at all buffered knots.

Here \(h\asymp p_B\). Evaluate (7.4) at the true tangent slope. Because the reference \(b(t-x_i)\) has intercept zero, translating Corollary 6 by \(\varphi(x_i)\), with outer radius \(12h\), gives

\[
\lambda(b_*)\ge\varphi(x_i)-E_n,\qquad
F(b_*)\le\varphi(x_i)+E_n,\qquad
E_n=4\varepsilon_B+72Kh^2=O(a_n^2).
\tag{7.17}
\]

Optimization improves the respective one-sided tangent bounds. We do not claim that an optimized endpoint lies on the correct side of the truth off the coverage event. Intersecting other scales keeps the lower inequality for \(\widetilde a_i\) and the upper inequality for \(\widetilde b_i\); outward numerical error adds at most \(\rho_n=o(a_n^2)\). These one-sided inequalities suffice for Section 5's continuous argument: the lower interpolation is at least \(\varphi-E_n-O(\Delta^2)\), while a chosen upper extrapolant is at most \(\varphi+E_n+O(\Delta)+O(E_n\Delta)\), where \(\Delta=O_P(\log n/n)\). A globally empty band has width zero; otherwise the same bound controls positive-part widths at crossed intervals. This proves (7.14).

On a log-affine neighborhood, select a sufficiently small fixed positive-mass scale. Density variation across its 33-block window can then be made uniformly small on a compact buffer. Mass relative errors tend to zero, so length ratios eventually belong to \([7/8,9/8]\); convergence to one is not claimed at a fixed scale. The affine defect is zero and Section 5 gives \(\varepsilon_B=O(\sqrt{\log\log n/n})\). Finally, \(q=\Theta(\log n)\), \(m=O(n/\log n)\), and \(B_{\max}+1=O(\log n)\), proving (7.15). \(\square\)

Theorem 2 applies to this new honest band, providing a matching order benchmark at the strictly curved Gaussian truth.

## 7.3. Outward arithmetic and its boundary

For rational \(z\in[0,1]\) and integer beta parameters, exact rational bisection is possible through

\[
P\{\operatorname{Beta}(r,N-r)\le z\}
=\sum_{k=r}^{N-1}\binom{N-1}{k}z^k(1-z)^{N-1-k}.
\tag{7.18}
\]

Using \(0<\underline c_B\le c_B\) and \(\overline d_B\ge d_B\) preserves coverage and the enclosure of the original relaxation. Refine an initially zero lower enclosure until it is positive, or skip that scale with an uninformative certificate; zero is never passed to a logarithm or denominator. Absolute quantile error at most \(n^{-3}\) is negligible in the rate proof: on its selected scale \(c_B,d_B\asymp p_B\), so the added relative error is \(O(n^{-3}/p_B)\). Since \(p_B\ge q/N=\Theta(\log n/n)\), this is at most \(O(n^{-2}/\log n)\).

Certified interval evaluation of \(W_D\), logarithms and the root bracket gives (7.7). At zero slope \(W_D(0)=|D|\); otherwise use its exponential difference formula with outward bounds and adaptive precision. No floating-point sign is treated as a certificate. At any chosen slope, a lower enclosure of \(\min_D c_D/W_D(b)\) provides a density lower bound, and an upper enclosure of

\[
\frac{\{d_C/W_C(b)\}^2}{\min_D c_D/W_D(b)}
\tag{7.19}
\]

provides a density upper bound. Rational exponential series with proved tail majorants and convergent logarithm series supply such enclosures.

The reference implementation accepts exact rational knots and certifies those supplied values. It is not a statistical justification for silently rounding continuous observations; interval-valued observation uncertainty would require additional enclosure logic. The mathematical real-sample theorem and the executable rational-input certificate are distinct statements. The reference implementation prioritizes auditability. Naive evaluation of (7.18) is not claimed to be fast for large \(n\); the \(O(n)\) count is only for the number of scalar problems. The code documentation and results distinguish its supported local solver, calibration and stencil functions from full-band rendering or performance benchmarks. If a stopping limit is reached before the requested error is certified, it is reported explicitly: (7.12) can retain validity, but an unmet tolerance cannot establish the numerical-rate claim.

Two flanking blocks per side matter for this relaxation because one can straddle the reference slope. For an ideal set of genuine densities, averaging actual interval masses already supplies a high point from one block per side. The distinctive computational claim is therefore the certified reduction for the larger separate-\(U/V\) relaxation together with its optimal rate, not bisection alone.


# 8. Honest bands from bin counts

In this section the observation is only the bin index of each sample. The bins are half-open intervals of common width \(h>0\) with a known common origin. Take a nondegenerate compact interval \(I\) in the interior of a fixed bounded measurement interval \(J\). Write \(\mathcal W_{n,h}(I)\) for the positive-part supremum width as in (1.1), with width zero on an empty band.

**Theorem 10 (optimal bin resolution and affine adaptation).** For each \(n\ge1\), \(h>0\) and fixed \(0<\alpha<1\), there is a band based only on bin counts with simultaneous coverage at least \(1-\alpha\) on \(I\) for every univariate log-concave density. If \(h=h_n\to0\) and the true log density is \(C^2\) on a neighborhood of \(I\) in the interior of its support, then

\[
\mathcal W_{n,h}(I)=O_P\!\left( (\log n/n)^{2/5}\vee h^2\right).
\tag{8.1}
\]

The uniform upper-rate assumptions may be taken as in (1.3) on compact buffers within \(J\). If the true log density is affine on a neighborhood of \(I\), the same band has width \(O_P(\sqrt{\log n/n})\) for every such sequence \(h_n\). Conversely, for \(0<\alpha<1/2\) and \(h=h_n\to0\), any measurable band based on bin counts and honest over (1.4) has, at the same fixed Gaussian \(f_0\) as in Theorem 2,

\[
\liminf_{n\to\infty} P_{f_0}^n\!\left\{
\mathcal W_{n,h}(I)\ge c_I\big((\log n/n)^{2/5}\vee h^2\big)
\right\}\ge1-2\alpha
\tag{8.2}
\]

for a positive constant \(c_I\). The lower bound permits asymptotic uniform honesty. In the curved class, the order from exact observations is therefore retained for \(h=O((\log n/n)^{1/5})\).

## 8.1. The feasible band and simultaneous mass comparisons

Let \(H_0=h\max\{1,\lceil1/(nh)\rceil\}\). For each \(H=2^jH_0\), \(j\ge0\), \(H\le |J|\), take all whole half-open bins of width \(H\) aligned to the known origin and contained in \(J\). Each is a union of observed bins. Write \(M\) for the number of these intervals. Since \(H_0\ge1/n\), summing the number \(\le |J|/(2^jH_0)\) per layer gives \(M\le 2|J|n\). If \(M=0\), use no constraints. Otherwise set \(t=\log(2Mn/\alpha)\). For each coarse bin, let \(\widehat p\) be its observed sample frequency. A candidate density passes when every coarse bin's mass \(p\) satisfies

\[
 |\widehat p-p|\le \sqrt{2pt/n}+2t/(3n).
\tag{8.3}
\]

The endpoints at each point are the infimum and supremum over passing log-concave densities, using their upper semicontinuous versions. An empty feasible set reports the reversed pair \([1,0]\) and width zero. For fixed \(n,h,J\) all endpoints and simultaneous events are measurable: the finite count vector takes finitely many values and each value determines a fixed band. The definition uses finite data and inequalities. Computing the extrema over all log-concave densities is a separate optimization problem.

Bernstein's inequality for the binomial count and the union bound show that the true density passes with probability at least \(1-\alpha/n\). On that same event, write \(p\) for a true mass and \(q\) for any passing mass in the same bin. With \(a=t/n\) and \(u=|p-q|\), the two instances of (8.3), \(q\le p+u\), and subadditivity of the square root give

\[
 u\le2\sqrt{2pa}+\sqrt{2au}+4a/3
 \le 2\sqrt{2pa}+u/2+7a/3.
\]

It follows that \(u\le4\sqrt{2pa}+14a/3\). In a region where the true density is bounded above and bounded away from zero, each length-\(H\) bin has \(p\asymp H\). When \(nH/t\) is sufficiently large, all these masses are strictly positive, \(q/p\in[1/2,3/2]\), and

\[
 |\log(q/p)|\le C\sqrt{t/(nH)}.
\tag{8.4}
\]

## 8.2. A local affine bound and the upper rates

Fix \(x\in I\) and a scale \(H\) with \(x\) in coarse bin \(i\). Require bins \(i-5,\ldots,i+3\) to lie wholly in a buffered region inside \(J\) where the true density has positive finite bounds. For any passing candidate \(g\), its positive masses in the outside bins \(i-5\) and \(i+3\) place the three bins \(i-4,i-2,i+2\) in the interior of its support. On those bins \(g/f\) is continuous and the weighted mean with weight \(f\) is the ratio of the bin masses. In the closures of these three bins choose points \(y_1,y_2,y_3\) realizing these ratios. Each falls in \([x-5H,x+3H]\); \(y_1<y_2<x<y_3\), \(y_2-y_1\ge H\), and \(x-y_2\le3H\).

Let \(L\) be affine and suppose \(|\log f-L|\le D\) on \([x-5H,x+3H]\). By (8.4), all three \(|\log g(y_j)-L(y_j)|\) are at most \(E=D+C\sqrt{t/(nH)}\). The chord between \(y_2,y_3\) bounds \(\log g(x)\) below by \(L(x)-E\). The secant through \(y_1,y_2\) extended to \(x\) bounds it above by \(L(x)+7E\), since the absolute sum of the affine coefficients is \(1+2(x-y_2)/(y_2-y_1)\le7\). Thus all feasible values at \(x\) have log width at most \(8E\). The bound holds for every allowed scale and line, which are choices in the proof.

For the \(C^2\) claim take the true tangent at \(x\) and use the curvature bound to get \(D\le C'H^2\). Choose the first scale \(H\ge(\log n/n)^{1/5}\), taking \(H=H_0\) if it already exceeds the threshold. Since \(H_0\le h+1/n\), the selected scale satisfies \(H\asymp h\vee(\log n/n)^{1/5}\). For sufficiently large \(n\) it fits the local buffer simultaneously for all \(x\), and since \(t=O(\log n)\), (8.4) applies. Exponentiating the bounds costs only a fixed factor because the true density is bounded on the buffer and \(E\to0\). This proves (8.1).

In an affine region, choose a fixed positive \(H_*\) small enough that every \(H\in[H_*,2H_*]\) fits each buffer. Since \(H_0\to0\), such a coarse scale exists for all sufficiently large \(n\). Here \(D=0\), hence the rate is \(\sqrt{\log n/n}\), even if the fine bins are larger than \((\log n/n)^{1/5}\). The same feasibility and honesty conditions apply.

## 8.3. Bin indistinguishability and the lower rate

Choose a whole bin of width \(h\) contained in a fixed nondegenerate compact interval inside \(I\), with center \(x_h\). Such a bin exists for all sufficiently small \(h\), with no requirement on the relative grid offset. Use (6.1) to set \(f_1(x)=f_0(x)+A h^2\zeta((x-x_h)/h)\). Choose \(A>0\) uniformly small using the positive lower bound for \(f_0\) on this compact interval as in (6.4)–(6.6). Then \(f_1\) is a density in (1.4). All bin probabilities match exactly: the perturbation is supported in the chosen bin and integrates to zero there. The two models therefore give the same observations at every sample size. The value at the center differs by \(A h^2\), so the intersection of the two coverage events forces \(\mathcal W_{n,h}(I)\ge A h^2\), with probability at least \(1-2\alpha\) under finite-sample honesty and with the same liminf under uniform asymptotic honesty.

Any binned procedure is also an exact-sample procedure after deterministically binning its inputs. Theorem 2 therefore forces the order \((\log n/n)^{2/5}\) at the same \(f_0\). Choose the smaller of the two constants. On indices where the bin term dominates, apply the bin indistinguishability bound. On the other indices, apply Theorem 2. This gives (8.2) on the entire sequence.

A check for the secant factor in §8.2 sets \(H=1,i=0\) and uses the closed ranges \(x\in[0,1],y_1\in[-4,-3],y_2\in[-2,-1]\). On the step-\(1/8\) grid the largest sum of absolute coefficients is 7 at \((1,-3,-2)\), in agreement with the analytic estimate.

# 9. Verification and computational scope

The exact-data proof includes the finite-grid affine comparison, beta-spacing calibration and continuous extension, and the honest-band lower bound. The binned proof uses a different observation channel and a finite family of observable constraints. Its feasible density optimization is defined by pointwise infima and suprema, with no implementation guarantee.

The standard-library rational bump certificate verifies the identities, safe derivative bounds and normalization used in both lower bounds. The exact-rational scalar code supplies outward arithmetic for the original random-grid relaxation at rational knots. Its use of rational arithmetic certifies supplied inputs, whereas Section 8 models statistical uncertainty from losing the precise observations. The exact-source penalty convex–concave routine produces critical points; its output requires a global bounding certificate to inherit the theorem. [Bump identities](evidence/code/exact_bump_certificate.py) · [Scalar code and reproducibility](evidence/README.md)

The private historical status records partial Lean progress. The proof obligations for the exact-data and binned results are listed independently of those historical checks. Historical proof coverage

# 10. Literature boundary

[WASB] proves finite-sample coverage and near-parametric adaptation on log-affine pieces, and explicitly proposes the smooth-width question. Its Appendix 7.2 supplies the closest proof mechanism. General multiscale shape-constrained confidence bands, including Dümbgen [D03], provide important methodological predecessors; they do not, by themselves, analyze the particular random-grid outer relaxation (2.5)–(2.9). Lewis and coauthors [LFRXS] study score estimation and score confidence bands under shape constraints; the target and confidence construction differ from the density band analyzed here.

The censored-data method of Dümbgen, Rufibach and Schuhmacher [DRS] includes fixed bins in its observation model, characterizes log-concave maximum-likelihood estimators and studies their consistency. Section 8 instead bounds simultaneous confidence widths by inverting observable multiscale bin-mass constraints and proves the exact sample-versus-bin resolution transition at a common Gaussian truth. Its proof attributes the mass concentration and secant geometry to standard Bernstein and concavity arguments. The literature comparison includes the original authors' 2026 JSM abstract, whose scope is the log-affine result. The binned result treats deterministic, equal-width bins and the exact-sample scalar implementation treats rational knots; these are distinct procedures.

## References

- **[WASB]** G. Walther, A. Ali, X. Shen and S. Boyd. *Confidence Bands for a Log-Concave Density*. Journal of Computational and Graphical Statistics 31(4), 1426–1438 (2022). DOI: [10.1080/10618600.2022.2076688](https://doi.org/10.1080/10618600.2022.2076688). [Author-hosted final PDF](https://web.stanford.edu/~boyd/papers/pdf/conf_bands_log_concave.pdf). [arXiv:2011.03668v3, including proof appendix](https://arxiv.org/abs/2011.03668v3).
- **[D03]** L. Dümbgen. *Optimal confidence bands for shape-restricted curves*. Bernoulli 9(3), 423–449 (2003). DOI: [10.3150/bj/1065444812](https://doi.org/10.3150/bj/1065444812). [Corrected reprint, arXiv:1312.6466](https://arxiv.org/abs/1312.6466).
- **[LFRXS]** R. M. Lewis, O. Y. Feng, H. W. J. Reeve, M. Xu and R. J. Samworth. *Learning the score under shape constraints*. [arXiv:2512.14624v1](https://arxiv.org/abs/2512.14624v1), 2025. The checked score-band construction is in Section 3.1.
- **[JSM26]** G. Walther. *Finite sample confidence bands for a log-concave density*. JSM 2026, 3 August 2026. [Official abstract](https://ww2.amstat.org/meetings/jsm/2026/onlineprogram/abstract.cfm?sid=5395&tid=5396).
- **[DRS]** L. Dümbgen, K. Rufibach and D. Schuhmacher. *Maximum-Likelihood Estimation of a Log-Concave Density Based on Censored Data*. The model includes binned observations in §1, MLE existence is Theorem 2.1, and §5 addresses consistency. [arXiv:1311.6403v3](https://arxiv.org/abs/1311.6403).
