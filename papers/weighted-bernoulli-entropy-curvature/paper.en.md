---
title: "Entropy curvature for weighted Bernoulli sums: collision certificates and replicated patterns"
lang: en
---

## Abstract

Let independent Bernoulli variables have a common parameter, and project the Boolean cube by a weighted sum. We prove strict concavity of the output Shannon entropy for every vector of nonzero real weights whose subset-sum fibers have cardinality at most two. Intersecting relation supports are allowed. For positive weights, the output entropy minus one binary entropy is concave on the whole closed parameter interval. A pointwise lower bound for the second derivative of each binary collision loss combines with an exact posterior-covariance identity to give an explicit weight-dependent curvature estimate. Independently, for positive weights we prove that every two-monomial collision loss has its minimum second derivative at the fair parameter, which yields a second proof and an exact comparison of output curvature with its central value. We also identify the full heterogeneous Hessian at the fair point, state a product extension, and give exact obstructions to extending the binary decomposition unchanged to larger fibers.

For arbitrary same-layer fibers, a Bernstein condition gives an explicit curvature certificate. For every fixed positive integer weight pattern the common-bias sum of sufficiently many independent copies has strictly concave entropy on the full bias interval. The proof controls differentiated Gaussian estimates at high expected count, strict compound-Poisson entropy curvature at fixed count scale, and the Fisher information of a nonzero output at the extreme edge. The replication threshold depends on the pattern. The original single-copy conjecture remains open.

## Problem, prior work, and principal conclusion

For positive integer weights containing 1, the exact target is whether

\[
H_w(p)=H\left(\sum_{i=1}^n w_iB_i\right),\qquad
B_i\text{ independent with }\Pr(B_i=1)=p,
\]

is concave for all \(p\in[0,1]\), all lengths, and all weights. This is the finite weighted-sum form of Conjecture 3.1 in [1]. In the source recursion, the weights are 1 and the positive successive increments of the increasing integer sequence; a translation and the substitution \(p\mapsto1-p\) do not affect concavity. This formulation is already present in [2] and is not a contribution of this paper. The original problem's requirement of a weight equal to 1 is retained in the research reservation. Our restricted-class theorem is proved directly for a larger real-weight domain; no continuity argument across changing collision patterns is used.

The Shepp-Olkin theorem [3] concerns an unweighted sum and arbitrary individual Bernoulli parameters. Replacing one weighted Bernoulli variable with independent copies changes the probability model, so that result does not immediately establish the weighted conjecture. The elementary entropy and logarithmic-mean inequalities used below are also classical [4]. Our candidate contribution is their application to complementary Bernoulli monomials, the exact use of additive translation closure, and the resulting all-parameter covariance transfer. Fixed-parameter Sperner and majorization comparisons [5] are related background, but do not by themselves control the parameter's second derivative.

**Principal theorem.** Suppose \(n\ge1\), \(w_i\ne0\) for every \(i\), and every fiber of \(x\mapsto w\cdot x\) on \(\{0,1\}^n\) contains at most two points. Put \(W=\sum_iw_i\), \(Q=\sum_iw_i^2\), and let \(h(p)=-p\log p-(1-p)\log(1-p)\). Then

\[
H_w''(p)\le-
\frac{\log2+(1-\log2)W^2/Q}{p(1-p)}<0
\qquad(0<p<1).
\tag{M}
\]

For positive weights, \(W^2\ge Q\), so \(H_w-h\) is concave on \([0,1]\). For arbitrary nonzero signed weights, the coefficient in (M) is still positive. The full-parameter proof is in Section 5; Sections 1 and 2 first expose the combinatorics and the exact central Hessian. Section 6 proves a different, sharp scalar inequality and the central-curvature comparison. The fiber hypothesis is essential to the present method, rather than an assertion that larger fibers violate the original conjecture.

Throughout, \(n\ge1\). All logarithms are natural. Write

\[
F(\mathbf p)=H\!\left(\sum_{i=1}^n w_iB_i\right),\qquad
B_i\sim\operatorname{Bernoulli}(p_i)\ \text{independently}.
\]

For the original problem the weights are positive integers and one weight is 1. Sections 1–8 treat the binary-fiber case. Sections 9–10 treat same-layer and replicated patterns, respectively.

## 1. A center theorem with intersecting collision relations

**Theorem.** Suppose every fiber

\[
\mathcal F_s=\{x\in\{0,1\}^n:\langle w,x\rangle=s\}
\]

has cardinality at most two. At the point \(\mathbf p_*=(1/2,\ldots,1/2)\), let \(\varepsilon_i=2B_i-1\), let \(T=\sum_iw_i\varepsilon_i\), and define

\[
m(T)=\mathbb E[\varepsilon\mid T],\qquad
M=\operatorname{Cov}(m(T))=\mathbb E[m(T)m(T)^\top].
\]

Then

\[
\boxed{\quad
\nabla^2 F(\mathbf p_*)
=-4\bigl[(\log2)\operatorname{Diag}(M)
 +(1-\log2)M\bigr].\quad}
\tag{T.1}
\]

Here \(\operatorname{Diag}(M)\) is the diagonal matrix with the same diagonal as \(M\). Consequently, this full Hessian is negative definite when all weights are nonzero. In particular, the common-parameter entropy is strictly concave at its center.

This does not require collision relations to have disjoint coordinate supports.

### 1.1 Translation closure and exact conditional-entropy decomposition

Let \(\mathcal D\) contain one representative from each pair \(\{d,-d\}\), where

\[
d\in\{-1,0,1\}^n\setminus\{0\},\qquad \langle w,d\rangle=0.
\]

For \(d\in\mathcal D\), put \(I_+(d)=\{i:d_i=1\}\), \(I_-(d)=\{i:d_i=-1\}\), \(I(d)=I_+(d)\cup I_-(d)\), and \(r_d=|I(d)|\).

The two configurations on \(I(d)\), respectively equal to \(1_{I_+(d)}\) and \(1_{I_-(d)}\), have the same weighted sum. For every assignment of the other \(n-r_d\) coordinates they therefore yield a collision pair. Because all fibers have at most two points, every such pair is an entire fiber, and collision pairs coming from distinct relations or distinct external assignments are disjoint. Conversely, every nonsingleton fiber arises uniquely in this fashion.

Set

\[
a_d(\mathbf p)=\prod_{i\in I_+}p_i\prod_{i\in I_-}(1-p_i),
\qquad
b_d(\mathbf p)=\prod_{i\in I_+}(1-p_i)\prod_{i\in I_-}p_i.
\]

For \(a,b>0\), write

\[
\ell(a,b)=(a+b)\log(a+b)-a\log a-b\log b.
\]

The conditional entropy lost under the weighted-sum map is exactly

\[
L(\mathbf p):=H(B_1,\ldots,B_n\mid \textstyle\sum_i w_iB_i)
=\sum_{d\in\mathcal D}\ell(a_d(\mathbf p),b_d(\mathbf p)).
\tag{T.2}
\]

Indeed, for each fixed external assignment its probability multiplies both masses in the pair, and \(\ell\) is homogeneous of degree one. Summing external probabilities gives one. This is precisely where the translation closure of actual additive fibers is used; an arbitrary antichain partition does not supply (T.2).

### 1.2 Hessian of one collision contribution at the center

Use centered input coordinates \(t_i=2p_i-1\). Write \(\widetilde L_d(t)=\ell(a_d((1+t)/2),b_d((1+t)/2))\). For coordinates in \(I(d)\),

\[
a_d(t)=2^{-r_d}\prod_{i\in I(d)}(1+d_it_i),\qquad
b_d(t)=2^{-r_d}\prod_{i\in I(d)}(1-d_it_i).
\]

At zero, \(a_d=b_d=2^{-r_d}\). If \(c_d=2^{1-r_d}\) and \(D_d=\operatorname{diag}(d_i^2)\), direct differentiation gives

\[
\nabla_t^2\widetilde L_d(0)
=c_d\bigl[(\log2-1)dd^\top-(\log2)D_d\bigr].
\tag{T.3}
\]

For completeness, the diagonal entries are \(-c_d\) on \(I(d)\), and the distinct-coordinate entries are \(c_d(\log2-1)d_id_j\). The latter use

\[
\ell_a=\ell_b=\log2,\quad
\ell_{aa}=\ell_{bb}=-2^{r_d-1},\quad
\ell_{ab}=2^{r_d-1}
\]

at \(a=b=2^{-r_d}\).

### 1.3 The covariance identity amortizes overlapping supports

At the fair input law, a two-point fiber associated with \(d\) has conditional covariance matrix \(dd^\top\) for \(\varepsilon\). It has probability \(2^{1-n}\), and there are \(2^{n-r_d}\) external assignments. Hence

\[
V:=\mathbb E\operatorname{Cov}(\varepsilon\mid T)
=\sum_{d\in\mathcal D}c_d dd^\top.
\tag{T.4}
\]

The total-covariance identity and \(\operatorname{Cov}(\varepsilon)=I_n\) imply

\[
V+M=I_n,\qquad 0\preceq V\preceq I_n.
\tag{T.5}
\]

Summing (T.3) therefore yields

\[
\nabla_t^2L(0)=(\log2-1)V-(\log2)\operatorname{Diag}(V).
\]

The independent input entropy \(\sum_i h((1+t_i)/2)\) has Hessian \(-I_n\) at zero. Subtracting \(L\), inserting \(V=I_n-M\), and converting \(t\)-derivatives to \(p\)-derivatives proves (T.1).

Both matrices on the right of (T.1) are positive semidefinite, and both coefficients are positive. Thus the full Hessian is negative semidefinite, with no attempt to give each individual mixed derivative a sign.

### 1.4 Strictness and quantitative bounds

Let \(Q=\sum_iw_i^2>0\). Projection onto the sigma-field generated by \(T\) is stronger than linear projection onto \(T\), so

\[
M\succeq \frac{ww^\top}{Q}.
\tag{T.6}
\]

One direct verification is to take any \(v\in\mathbb R^n\): since \(\mathbb E[(v^\top m(T))T]=v^\top w\) and \(\mathbb E T^2=Q\), Cauchy--Schwarz gives \(v^\top Mv\ge(v^\top w)^2/Q\).

In particular \(M_{ii}\ge w_i^2/Q>0\), proving negative definiteness of (T.1). More quantitatively,

\[
\nabla^2 F(\mathbf p_*)
\preceq-\frac4Q\left[
(\log2)\operatorname{diag}(w_i^2)
 +(1-\log2)ww^\top\right].
\tag{T.7}
\]

For the common-parameter path, with \(W=\sum_iw_i\),

\[
\left.\frac{d^2}{dp^2}H\!\left(\sum_iw_iB_i(p)\right)\right|_{p=1/2}
\le-4\left[\log2+(1-\log2)\frac{W^2}{Q}\right].
\tag{T.8}
\]

For positive weights \(W^2/Q\ge1\), so (T.8) in particular gives the uniform bound \(H''(1/2)\le-4\). Continuity then supplies a neighborhood of strict concavity for every fixed admissible vector; no explicit uniform neighborhood radius is claimed here.

## 2. An explicit intersecting-relations example

For \(w=(1,1,2)\), every fiber has size at most two. There are two relation types:

\[
d_1=(1,-1,0),\quad c_1=1/2;
\qquad d_2=(1,1,-1),\quad c_2=1/4.
\]

Their coordinate supports intersect. From (T.4),

\[
V=\tfrac12d_1d_1^\top+\tfrac14d_2d_2^\top,
\qquad
M=\begin{pmatrix}
1/4&1/4&1/4\\
1/4&1/4&1/4\\
1/4&1/4&3/4
\end{pmatrix}.
\]

Thus \(\operatorname{tr}M=5/4\) and \(\mathbf1^\top M\mathbf1=11/4\), so

\[
H''(1/2)=-11+6\log2<0.
\]

This agrees with the independently checkable entropy identity

\[
H=3h(p)-2p(1-p)\log2-p(1-p)h(p).
\]

## 3. Failed routes and precise restrictions

1. **Pointwise signs of mixed derivatives fail even at the center.** With \(w=(1,10,11)\), the mixed derivative corresponding to the weights 1 and 10 is \(1-\log2>0\) at the fair point. The complete matrix is nevertheless negative definite by (T.1). Relations must be amortized, not assigned a separate sign for each pair of coordinates.

2. **An arbitrary bistochastic image of a binomial law is not enough.** For \(n=2\), mixing the two endpoint probabilities of \(\operatorname{Bin}(2,p)\) produces the vector \(((1-2p(1-p))/2,2p(1-p),(1-2p(1-p))/2)\), whose entropy has second derivative \(4\log2>0\) at the center. Such a channel is not a positive weighted-sum fiber map.

3. **No general-fiber extension of (T.1) is claimed.** For a general additive fiber, the number of alternate preimages can vary with the external assignment. Formula (T.2) is then false as a sum over all pair relations: a fiber with three or more points would be overcounted. Both the entropy decomposition and the covariance coefficients change. The unrestricted sign problem therefore remains substantial.

## 4. General center identity for further work (identity only)

For arbitrary finite fibers, put \(C(T)=|\mathcal F_T|\) in the centered-sign representation and keep \(M=\mathbb E[m(T)m(T)^\top]\). Define a symmetric matrix \(R\) by \(R_{ii}=0\) and

\[
R_{ij}=\mathbb E[\varepsilon_i\varepsilon_j\log C(T)]\quad(i\ne j).
\]

Then direct differentiation gives

\[
\nabla^2F(\mathbf p_*)=-4(M+R).
\tag{T.9}
\]

In the two-point-fiber case, the proof above identifies \(R=(\log2)(\operatorname{Diag}(M)-M)\). A general positive-semidefinite decomposition of \(M+R\) is not proved. Merely stating (T.9) is not a resolution of the conjecture.

## 5. A pointwise loss bound and full-parameter covariance theorem

The following proof is independent of a claim that each loss has its most negative second derivative at the center. It controls every collision by its posterior covariance at the actual parameter.

### 5.1 Pointwise binary-collision inequality

**Lemma.** Let integers \(a,b\ge0\) satisfy \(m=a+b\ge2\). Put \(d=a-b\), \(q=1-p\),

\[
u=p^a q^b,\qquad v=p^b q^a,\qquad
\rho=\frac{uv}{u+v},\qquad L(p)=\ell(u,v).
\]

Then, for every \(0<p<1\),

\[
\boxed{\quad L''(p)\ge
-\frac{\rho}{p^2q^2}
\left[(\log2)m+(1-\log2)d^2\right].\quad}
\tag{T.10}
\]

**Proof.** Symmetry under \(p\leftrightarrow q\) and \(a\leftrightarrow b\) permits \(p\le1/2\) and \(d\ge0\). Write \(c=q-p\),

\[
A=u\log\frac{u+v}{u},\qquad
B=v\log\frac{u+v}{v},\qquad
\Delta=A-B,\qquad L=A+B.
\]

Differentiating \(\ell\) gives

\[
4p^2q^2L''
=(L-4\rho)d^2-Lm+Lc^2m(m-1)
 +2c\Delta d(m-1).
\tag{T.11}
\]

Thus (T.10) is equivalent to the nonnegativity of

\[
N=(L-4\rho\log2)(d^2-m)
 +Lc^2m(m-1)+2c\Delta d(m-1).
\tag{T.12}
\]

Three elementary facts control this expression.

First, the classical binary-entropy bounds (the lower bound is Topsøe [4], Theorem 1.2)

\[
4x(1-x)\log2\le h(x)\le\log2
\tag{T.13}
\]

imply \(L\ge4\rho\log2\). To see the lower bound without importing an extra theorem, set \(z=2x-1\) and use

\[
h((1+z)/2)=\log2-
\sum_{k\ge1}\frac{z^{2k}}{2k(2k-1)},\qquad
\sum_{k\ge1}\frac1{2k(2k-1)}=\log2.
\]

Since \(z^{2k}\le z^2\) for \(|z|\le1\), (T.13) follows.

Second, \(u\le v\) implies \(\Delta\ge0\). Indeed, for \(z=v/u\ge1\),

\[
\Delta/u=\log(1+z)-z\log(1+1/z).
\]

This is zero at \(z=1\), and its derivative is

\[
\frac2{1+z}-\log(1+1/z)
\ge\frac2{1+z}-\frac1z\ge0.
\]

Thus the last term of (T.12) is nonnegative.

Third, let \(\eta=(v-u)/(v+u)\). The upper bound in (T.13) yields

\[
0\le L-4\rho\log2\le L\eta^2.
\tag{T.14}
\]

Also \(\eta=\tanh(d\operatorname{arctanh}c)\). If \(d=0\), then \(\eta=0\). If the integer \(d\ge1\), concavity of \(\tanh\) on the nonnegative real axis gives

\[
\eta\le d\tanh(\operatorname{arctanh}c)=dc.
\tag{T.15}
\]

If \(d^2\ge m\), every term in (T.12) is already nonnegative. If \(d^2<m\), (T.14)--(T.15) instead give

\[
N\ge Lc^2\bigl[m(m-1)-d^2(m-d^2)\bigr]\ge0,
\]

because \(d^2(m-d^2)\le m^2/4\le m(m-1)\) for \(m\ge2\). This proves the lemma. Equality in (T.10) holds at \(p=1/2\).

### 5.2 Exact variance budget for intersecting binary fibers

Retain the fiber-size-at-most-two hypothesis of Section 1, now at arbitrary common \(p\). For each relation vector \(d^{(r)}\in\mathcal D\), let \(u_r,v_r\) be its two local pattern probabilities and let \(\rho_r=u_rv_r/(u_r+v_r)\). Then

\[
V_p:=\mathbb E\operatorname{Cov}(B\mid S)
=\sum_{r\in\mathcal D}\rho_r d^{(r)}(d^{(r)})^\top.
\tag{T.16}
\]

To verify (T.16), a pair with local masses \(u_r,v_r\) has conditional covariance \(u_rv_r/(u_r+v_r)^2\) times \(d^{(r)}(d^{(r)})^\top\). Multiplication by the fiber probability and summation over all external assignments produce \(\rho_r\).

Set

\[
M_p=\operatorname{Cov}(\mathbb E[B\mid S]).
\]

Since the input coordinates are independent Bernoulli variables,

\[
V_p+M_p=pqI_n.
\tag{T.17}
\]

Apply (T.10) to every term of the exact loss decomposition (T.2). For each relation, its support size is \(\|d^{(r)}\|_2^2\), and its cardinality imbalance is \(\mathbf1^\top d^{(r)}\). Consequently,

\[
L''(p)\ge-
\frac{(\log2)\operatorname{tr}V_p
 +(1-\log2)\mathbf1^\top V_p\mathbf1}{p^2q^2}.
\]

Subtracting this from the input-entropy curvature \(-n/(pq)\) and using (T.17) proves the full-parameter inequality

\[
\boxed{\quad H''(p)\le-
\frac{(\log2)\operatorname{tr}M_p
 +(1-\log2)\mathbf1^\top M_p\mathbf1}{p^2q^2}.
\quad}
\tag{T.18}
\]

No disjoint-support assumption has been used: intersecting collision relations are handled by the single total-covariance budget.

### 5.3 Strict quantitative consequence for every common parameter

Linear projection onto \(S\) gives

\[
M_p\succeq\frac{pq}{Q}ww^\top.
\]

Thus (T.18) implies

\[
\boxed{\quad
H''(p)\le-
\frac{\log2+(1-\log2)W^2/Q}{p(1-p)}.
\quad}
\tag{T.19}
\]

For positive weights, \(W^2/Q\ge1\); therefore \(H-h\) is concave throughout \([0,1]\), and \(H\) is strictly concave in the interior. Endpoint extension uses continuity of entropy for a finite alphabet.

For signed nonzero weights the coefficient in (T.19) is still at least \(\log2>0\), so strict concavity of \(H\) itself also follows. This signed extension is a theorem only under the same two-point-fiber hypothesis.

The unresolved issue for larger fibers is not the covariance identity itself, which always holds. It is the lack of a non-overcounting entropy-loss decomposition into the pair terms controlled by (T.10).

## 6. Sharp location of the minimum collision curvature

For integers \(a,b\ge1\), set \(m=a+b\), \(k=|a-b|\), \(q=1-p\), and
\[
L_{a,b}(p)=
(p^aq^b+p^bq^a)
h\!\left(\frac{p^aq^b}{p^aq^b+p^bq^a}\right),
\]
where \(h(x)=-x\log x-(1-x)\log(1-x)\).

**Theorem 6.1.** For all \(0<p<1\),
\[
\boxed{
L_{a,b}''(p)\ge L_{a,b}''(1/2)
=-2^{3-m}\left[m\log2+(1-\log2)k^2\right].
}
\tag{F.A}
\]
Thus the second derivative attains its global minimum at \(p=1/2\). No uniqueness of the minimizer is claimed; for \(a=b=1\) it is constant.

### 6.1 The classical logarithmic-mean inequality

For \(0<x<1\), define
\[
M(x)=\frac{1-x}{-\log x}=\int_0^1x^u\,du.
\]
The concavity of this logarithmic mean is classical; see Topsøe [4], Section 2. For every fixed \(u\in[0,1]\), \(x\mapsto x^u\) is concave on \((0,1)\). Integrating its defining concavity inequality shows that \(M\) is concave; no differentiation under the integral is required. Hence
\[
M(x)+M(1-x)\le 2M(1/2)=\frac1{\log2}.
\tag{F.1}
\]

Let
\[
\alpha=\frac{-\log x}{1-x},\qquad
\beta=\frac{-\log(1-x)}x.
\]
These are positive, with \(1/\alpha=M(x)\) and \(1/\beta=M(1-x)\). For any nonnegative \(p,q\) with \(p+q=1\), Cauchy-Schwarz gives
\[
(\alpha q^2+\beta p^2)(1/\alpha+1/\beta)
\ge(p+q)^2=1.
\]
Together with (F.1),
\[
\boxed{
q^2\frac{-\log x}{1-x}
+p^2\frac{-\log(1-x)}x\ge\log2.
}
\tag{F.2}
\]
Equality holds at \(p=q=x=1/2\).

### 6.2 Auxiliary binary entropy and its monotonicity

Put \(r=\min(a,b)\ge1\), so \(m=2r+k\), and let \(t=pq\). Then
\[
L_{a,b}=t^rJ_k,
\qquad
J_k=(p^k+q^k)\log(p^k+q^k)
-k(p^k\log p+q^k\log q).
\]
For \(k=0\), \(J_0=2\log2\), and \(J_1=h(p)\).

For \(k\ge1\),
\[
J_k'=k\{p^{k-1}\log(1+(q/p)^k)
-q^{k-1}\log(1+(p/q)^k)\}.
\]
The elementary inequality
\[
\log(1+u)\le u\log(1+1/u),\qquad0<u\le1,
\tag{F.3}
\]
can be proved as follows. The difference
\(f(u)=u\log(1+1/u)-\log(1+u)\) satisfies
\(f(0)=f(1)=0\) by continuous extension and
\(f''(u)=(u-1)/(u(1+u)^2)\le0\). Thus \(f\ge0\).

For \(p\le q\), take \(v=p/q\le1\). Applying (F.3) to \(u=v^k\) and then using \(v^k\le v^{k-1}\) gives \(J_k'\ge0\). Symmetry therefore yields
\[
(1-2p)J_k'\ge0,\qquad
0\le J_k(p)\le2^{1-k}\log2.
\tag{F.4}
\]

### 6.3 The improved curvature bound for \(J_k\)

For \(k\ge2\), set \(A=p^k+q^k\), \(x=p^k/A\), and
\[
F=\frac{k^2(pq)^{k-2}}A.
\]
Twice differentiating homogeneous binary entropy gives the exact formula
\[
J_k''=
k(k-1)\left[
p^{k-2}\log\frac A{p^k}
+q^{k-2}\log\frac A{q^k}
\right]-F.
\tag{F.5}
\]
Call the nonnegative bracketed contribution, including its prefactor, \(P\). Its ratio to \(F\) is
\[
\begin{aligned}
\frac PF
&=\frac{k-1}k A
\left[q^{2-k}\log\frac A{p^k}
+p^{2-k}\log\frac A{q^k}\right]\\
&=\frac{k-1}k\left[
q^2\frac{-\log x}{1-x}
+p^2\frac{-\log(1-x)}x\right]\\
&\ge\frac{k-1}k\log2,
\end{aligned}
\tag{F.6}
\]
by (F.2). Consequently
\[
J_k''\ge-\left(1-\log2+\frac{\log2}k\right)
\frac{k^2t^{k-2}}{p^k+q^k}.
\tag{F.7}
\]

### 6.4 Multiplication by \(t^r\) and the endpoint cases in \(k\)

The exact expansion is
\[
\begin{aligned}
L_{a,b}''
={}&t^rJ_k''
+2rt^{r-1}(1-2p)J_k'\\
&+r(r-1)t^{r-2}(1-2p)^2J_k
-2rt^{r-1}J_k.
\end{aligned}
\tag{F.8}
\]
The middle two terms are nonnegative by (F.4).

For \(k\ge2\), combine (F.4), (F.7), \(t\le1/4\), and
\(p^k+q^k\ge2^{1-k}\). All exponents used to bound \(t\) here are nonnegative, since \(r+k-2\ge1\) and \(r-1\ge0\). This gives
\[
\begin{aligned}
L_{a,b}''
&\ge-
\left(1-\log2+\frac{\log2}k\right)
\frac{k^2t^{r+k-2}}{p^k+q^k}
-2rt^{r-1}2^{1-k}\log2\\
&\ge-
4^{1-r}2^{1-k}
\left[(1-\log2)k^2+(k+2r)\log2\right]\\
&=-2^{3-m}
\left[(1-\log2)k^2+m\log2\right].
\end{aligned}
\tag{F.9}
\]
Every inequality in this chain is an equality at \(p=1/2\): both omitted terms vanish, (F.2) is an equality, and the extrema of \(t,A,J_k\) used above have their stated values there.

If \(k=0\), \(L=2t^r\log2\), so
\[
L''\ge-4rt^{r-1}\log2
\ge-4r4^{1-r}\log2
=-2^{3-2r}(2r\log2),
\]
with equality at \(p=1/2\).

If \(k=1\), \(J_1''=-1/t\), so
\[
L''\ge-t^{r-1}(1+2r\log2)
\ge-4^{1-r}(1+2r\log2).
\]
Since \(m=2r+1\), this equals
\(-2^{3-m}[m\log2+(1-\log2)]\), again attained at \(1/2\).
This proves Theorem 6.1. \(\square\)


### 6.5 Consequence: central curvature is maximal for positive binary fibers

Use the exact loss decomposition (T.2) on the common-parameter line. Positivity of the weights forces both sides of every nonzero relation to be nonempty, so Theorem 6.1 applies to each loss. Therefore

\[
H_w''(p)\le H_w''(1/2)-n\left(\frac1{p(1-p)}-4\right).
\tag{F.10}
\]

Indeed, \(H_w''=-n/[p(1-p)]-\sum L_{a,b}''\), and Theorem 6.1 bounds each term by its fair value. The central Hessian in (T.1) is strictly negative definite, so (F.10) gives a second proof of strict concavity. The inequality is an equality at the center. We do not claim a unique minimizer for each scalar loss: for \(a=b=1\), its second derivative is constant. This argument is stated for positive weights; the broader signed-weight result follows instead from Section 5.

## 7. Product extension and an interacting example

Partition the coordinates into \(r\ge1\) nonempty blocks. Suppose each block's subset-sum fibers have size at most two, and addition is injective on the Cartesian product of the blocks' full output supports. The output sum then determines the tuple of block outputs. Independence and invariance of entropy under an injective relabeling imply

\[
H_{\mathrm{total}}(p)=\sum_{j=1}^r H_j(p).
\]

For positive weights, \(H_{\mathrm{total}}-r h\) is consequently concave. Fibers of the whole map are products of block fibers and can have size up to \(2^r\). The single-relation and disjoint-relation results from the first research round are included in this product construction. This is an additivity corollary, not a separate claim of deep novelty.

For \(w=(1,2,3,4)\), all fibers have size at most two, but the three relation supports intersect. Representatives are

\[
(1,1,-1,0),\qquad(1,0,1,-1),\qquad(1,-1,-1,1).
\]

The exact entropy is

\[
H_w(p)=4h(p)-2p(1-p)h(p)-2p^2(1-p)^2\log2.
\]

This illustrates why the second-round theorem strictly broadens the first-round disjoint-support mechanism. The theorem is not established by enumerating this example; it follows for all dimensions from the previous proofs.

## 8. Exact boundaries of the method

### 8.1 Three-point fibers cannot be counted as independent pairs

For \(w=(1,1,1)\), the actual loss is \(L(p)=3p(1-p)\log3\). Summing the three relation-pair losses would instead give \(6p(1-p)\log2\). These are unequal. At the fair point the true loss curvature is \(-6\log3\). Directly reusing the binary covariance coefficient would require it to be at least \(-8\log2\), which is false because \(3^6>2^8\).

More generally, define

\[
\Psi_3(x,y,z)=(x+y+z)\log(x+y+z)-x\log x-y\log y-z\log z.
\]

There are no constants \(c_{12},c_{13},c_{23}\) making \(\Psi_3=\sum_{i<j}c_{ij}\ell(x_i,x_j)\) for every positive triple. Letting one mass tend to zero forces each coefficient to be 1, while equal masses would then require \(3\log3=6\log2\). An exact merge tree introduces \(\ell(x+y,z)\), whose first argument is a sum of monomials. The scalar lemmas here do not control that new form. The original conjecture remains valid in the binomial example, so this obstruction is to the proof mechanism, not a counterexample to the target.

### 8.2 Arbitrary antichain partitions are insufficient

On the eight-dimensional cube, merge all 70 rank-four vertices and keep every other vertex separate. The resulting entropy is

\[
8h(p)-70p^4(1-p)^4\log70.
\]

Its second derivative at one half is \((35/4)\log70-32>0\). Such a partition has an antichain as its only nontrivial fiber and is invariant under complement, but cannot be the fiber partition of a positive linear form: equality of all rank-four sums forces all weights equal and then merges all rank layers. Additive translation closure, not only the antichain property, is needed.

### 8.3 A conditional-rank proof split fails

Let \(K=\sum_iB_i\). The identity
\(H(S)=\mathbb E[H(S\mid K)]+I(K;S)\) does not split the target into two automatically concave functions. For \(w=(1,1,1,3,4)\),

\[
\left.\frac{d^2}{dp^2}I(K;S)\right|_{p=1/2}
=17\log2-3\log3+5\log5-\frac{33}2
>0.
\]

An exact rational logarithm-series enclosure in the package certifies this sign. The total output curvature at the same point is \(-33/2+7\log2+3\log3<0\). Thus the counterexample invalidates an auxiliary lemma, not common-parameter concavity. A second failed induction claim is that adding the largest weight always gives a concave entropy increment: even \([H(\mathrm{Bin}(4,p))-H(\mathrm{Bin}(3,p))]''_{p=1/2}=6\log2-4>0\).

### 8.4 Joint concavity fails away from the fair point

For \(w=(1,1,2)\), vary the parameter vector as \((p+t,p-t,p)\). Direct differentiation at \(t=0\) gives

\[
\frac{d^2}{dt^2}F(p+t,p-t,p)\Big|_{t=0}
=-2p\log(1-p)-2(1-p)\log p-4\log2.
\]

At \(p=1/10\), this equals
\(\frac15\log[10^{10}/(9\,2^{20})]>0\). Thus the full Hessian's negative definiteness at the fair point cannot be extended to every point of the common-parameter diagonal. The common direction itself remains strictly concave by (M). The stronger weighted joint-concavity claim was already known to fail at a different parameter point in [2]; this calculation supplies a nearby explicit boundary for our central theorem.

## 9. A Bernstein certificate for same-layer fibers

Suppose all configurations in each fiber have the same number of ones. Let \(m_s\) be the size of the fiber of \(s\), and \(a_k\) the average of \(\log m_s\) over all \(k\)-element subsets, with each subset counted once. Write \(\Delta^2 a_{k-1}=a_{k-1}-2a_k+a_{k+1}\).

**Theorem.** If \(n+k(n-k)\Delta^2a_{k-1}>0\) for every \(1\le k<n\), then \(H_w\) is strictly concave on \([0,1]\). This condition is independent of the maximal fiber size.

Given a sum \(s\), all configurations in its fiber have equal probability. Thus with the degree-\(n\) Bernstein polynomial \(B_{n,k}(p)=\binom nk p^k(1-p)^{n-k}\),
\[
 H_w(p)=nh(p)-\sum_{k=0}^n a_k B_{n,k}(p).
\]
Differentiate twice and multiply by \(-p(1-p)\), using \(p(1-p)n(n-1)B_{n-2,k-1}=k(n-k)B_{n,k}\). This gives
\[
 -p(1-p)H_w''(p)
 =n+\sum_{k=1}^{n-1} k(n-k)\Delta^2a_{k-1} B_{n,k}(p).
\]
Express the constant in the same Bernstein basis. The two endpoint coefficients are \(n\), so positivity of all coefficients proves the claim. The minimum coefficient is a global lower bound for the left side.

For \(w=(100,101,\ldots,107)\), different cardinalities have disjoint sum intervals, and some fibers have eight preimages. Enumeration of \(2^8\) subsets verifies that all stated coefficients exceed \(19/10\). For a positive integer multiplicity \(b\), let \(z=(b-1)/(b+1)\). The expansion
\[
 \log b=2\sum_{j=0}^{49}\frac{z^{2j+1}}{2j+1}+r,\qquad
 0\le r\le\frac{2z^{101}}{101(1-z^2)}
\]
gives an exact rational lower bound for each coefficient. If a weight one is required, double the original weights and add the independent weight one Bernoulli input. Parity recovers the extra bit, and the entropy is the original entropy plus \(h(p)\).

## 10. Eventual concavity for any positive integer pattern

**Theorem (eventual strict concavity).** Fix any nonempty list of positive integer weights \(w_1,\ldots,w_d\). Make \(m\) independent copies of each Bernoulli input, all with common success probability \(p\). Write \(S=\sum_iw_i N_i\), \(N_i\) independent \({\rm Bin}(m,p)\). There exists \(m_0(w)<\infty\) such that for every \(m\ge m_0(w)\) the Shannon entropy \(H_m(p)=H(S)\) is strictly concave on \([0,1]\). The threshold is uniform in \(p\). For the pattern \((1,2)\) the fiber at sum \(2j\), for example, combines every feasible count pair \(N_1=2j-2h,N_2=h\), with multiplicities \(\binom m{2j-2h}\binom mh\). These span linearly many distinct Hamming layers for central \(j\) and exponentially many configurations. The proof permits unrestricted cross-layer collisions and overlapping sums of the replicated blocks.

We give details of the uniformity, since differentiating an entropy central limit theorem without derivative control would not prove the assertion. Scale out the gcd and work with lattice span one. Reflection of every bit reduces matters to \(0<p\le1/2\). Write \(q=1-p,\ D=pq\,\partial_p,\ V=mpq\sum_iw_i^2,\ \mu=mp\sum_iw_i\). All constants below may depend on the fixed pattern.

### 10.1. Differentiated lattice Gaussian estimate

 As \(V\to\infty\), uniformly in \(0<p\le1/2\),
\[
 D^j[H_m(p)-\tfrac12\log(2\pi e V)]=o(1),\qquad j=0,1,2 .
 \tag{R1}
\]
Here are the estimates proving (R1). Write \(P_s=\Pr(S=s)\), \(K=\sum N_i\), \(t=mp\), so \(V\asymp t\). For every feasible \(s\), any realizing count vector with total \(k\le s\) gives
\[
 -\log P_s\le 2dt+k\log_+(k/t)
\]
from \(\binom m{j}\ge(m/j)^j\) and \(q^{dm}\ge e^{-2dt}\). For \(j=1,2\), the coefficients \(D^jP_s\) are expectations on \(\{S=s\}\) of \(K-dmp\) and \((K-dmp)^2-dmpq\), respectively. Also \((DP_s)^2/P_s\le\mathbb E[(K-dmp)^2;S=s]\). Therefore the contribution of \(|s-\mu|>C\sqrt{V\log V}\) to each of the first two differentiated entropy sums, or to the entropy, is \(O(V^{-A})\) for any prescribed \(A\) if \(C\) is sufficiently large. Indeed Bernstein's inequality for the independent bounded summands gives probability \(O(V^{-B})\) for arbitrarily large \(B\) by enlarging \(C\). Cauchy–Schwarz absorbs the indicated polynomial weights in \(V,K,S\), whose fixed moments grow polynomially in \(V\), since \(S\le(\max w_i)K\) and \(K\) is binomial. Holes in the support are identically zero and are omitted.

For clarity we detail the arbitrary-order local expansion used in the central window. At every fixed order \(J\) Fourier inversion gives, with \(x=(s-\mu)/\sqrt V\) and \(\varphi\) standard normal density,
\[
 P_s=V^{-1/2}\varphi(x)
 \left[1+\sum_{r=1}^J V^{-r/2}Q_r(x,p)\right]+\mathcal R_J(s).
 \tag{R2}
\]
Each \(Q_r\) is a fixed-degree polynomial in \(x\) with uniformly bounded coefficients and first two \(D\)-derivatives of its coefficients. On \(|x|\le C\sqrt{\log V}\), \(|D^j\mathcal R_J|\le O_J(V^{-(J+2)/2+j}(1+\log V)^{c_J})\) for \(j\le2\), with \(D\) at fixed integer \(s\). To verify this form, near zero the centered log characteristic function is
\(m\sum_i[\log(1+p(e^{iw_i\theta}-1))-ipw_i\theta]\). Its Taylor coefficients of every order \(\ge2\), and their first two \(D\)-derivatives, are \(O_J(V)\): the analytic logarithm on a fixed small complex disk is \(O(p)\) there, also after one or two \(D\)-derivatives. The quadratic term is \(-V\theta^2/2\). Set \(\theta=z/\sqrt V\) and truncate Taylor above degree \(J+2\). Exponentiating terms beyond the quadratic by ordinary Taylor expansion and collecting orders \(V^{-r/2}\) gives polynomials in \(z\) times \(e^{-z^2/2}\). On \(|z|\le L\sqrt{\log V}\) the omitted part is bounded by \(O_J(V^{-(J+1)/2}(1+\log V)^{c_J})\) times a Gaussian, by Taylor's remainder, and the same bound holds under two coefficient differentiations. The inversion multiplier \(e^{-izx}\), change of variables and endpoints cost at most \(O(V^j(1+\log V)^{c_J})\) under \(D^j\) in the central window; here \(D\mu=O(V),\ D^jV=O(V)\) for \(j=1,2\). In the remaining integration region
\[
 |\Phi(\theta)|\le\exp[-2mpq\sum_i\sin^2(w_i\theta/2)] .
\]
The sine sum is bounded below by a positive multiple of \(\theta^2\) on \([-\pi,\pi]\), by gcd one. In differentiating the product directly one may remove at most two factors and pay a polynomial in \(V\) (a differentiated Bernoulli factor costs \(O(p)\)); the remaining \(m-2\) whole blocks retain the same Gaussian decay up to a constant. Taking \(L\) large relative to \(J\) makes these tails, and boundary terms from moving the cutoff, smaller than the stated remainder. Inverting each polynomial times a Gaussian gives (R2) and the coefficient claims by elementary Gaussian differentiation.

Fix the preceding \(C\). The Gaussian factor is bounded below by a fixed inverse power of \(V\) in this window. By choosing \(J\) sufficiently large, (R2) and its two fixed-\(s\) derivatives have arbitrarily small inverse-power *absolute* errors there; the relative errors against \(V^{-1/2}\varphi(x)\) also have this property upon increasing \(J\). Consequently the true central masses are positive for sufficiently large \(V\). The relative correction inside the bracket is \(O(V^{-1/2}(1+\log V)^{c_J})\). Expand \(-P_s\log P_s\) using \(\log(1+y)\) on this bracket, to any fixed high order. This remains valid after two derivatives: each fixed-\(s\) derivative of any term can lose at most one power of \(V\) times a log-polynomial through \(x\). Thus taking, for example, the logarithmic series past degree ten, and \(J\) large enough for the desired absolute interpolation error before division by the Gaussian, gives summable \(o(1)\) remainder for the entropy and both derivatives. Explicitly a logarithm remainder of degree \(k\) and its two derivatives are bounded by a constant times \(|y|^{k-1}(|y|^2+|Dy|^2+|yD^2y|)\), using \(|y|<1/2\); \(Dy,D^2y\) have bounds \(V^{j-1/2}\) times log-polynomials. The leading entropy term is the Gaussian entropy summand; every other retained summand is \(V^{-1/2}\varphi(x)\) times a polynomial in \(x\), a positive power of \(V^{-1/2}\), and at most a factor \(O(1+\log V)\). Such sums and their differentiated sums may be extended over the full lattice, with negligible Gaussian tails (the finite polynomial factors cost log-powers at the cutoff, while at most two differentiation losses cost \(V^2\)). By Poisson summation they equal their Gaussian integrals up to exponentially small errors, also after two differentiations, since the nonzero Fourier modes are polynomials times \(e^{-2\pi^2V k^2}\) and \(D\mu=O(V)\). Each correction integral and its first two derivatives is \(O(V^{-1/2}(1+\log V))\). The leading integral is \(\frac12\log(2\pi e V)\). These are estimates on differentiated summands at each parameter; no derivatives of a discontinuous lattice-window indicator are taken. This proves (R1).

It follows that \((pq)^2 H_m''(p)=-(p^2+q^2)/2+o(1)\) whenever \(mp\to\infty\), by subtracting \((1-2p)D\) from \(D^2\). In particular the sign is eventually strictly negative on every such sequence.

### 10.2. The Poisson edge and small expected count

 Put \(t=mp\), and now differentiate with respect to \(t\). On compact subintervals of \(0<t<\infty\) the first two derivatives of \(H_m(t/m)\) converge to those of the entropy of \(Z_t=\sum_iw_i Y_i\) for independent Poisson\((t)\) counts. For each fixed count vector its binomial probability and two derivatives converge to their Poisson limits. In the differentiated entropy formula the log bound above grows at most \(O(1+s\log(2+s))\), uniformly on a compact \(t\)-interval. In the likelihood derivatives the first score is \(K/t-(dm-K)/(m-t)\), and the absolute second probability derivative divided by the configuration probability is bounded by \(O(1+K^2)\) there. Conditional Cauchy–Schwarz applies to the squared-score term. The uniformly bounded exponential moments of \(K\) give summable tails uniformly, proving the derivative convergence also along moving \(t\) in a compact interval.

The Poisson limit has strictly negative second entropy derivative at every \(t>0\). Let \(P\) be the law of \(Z_t\), \(P^w_s=P_{s-w}\). Its evolution is \(\partial_tP=\sum_i(P^{w_i}-P)\). Differentiation gives \(H'(t)=\sum_i D_{\rm KL}(P^{w_i}\|P)\), using equality of the entropies of \(P\) and its shifts. Both compared measures follow the same shift semigroup. For \(R_s=P^w_s/P_s\) on the support of \(P\), its relative entropy dissipation is
\[
 -\partial_t D_{\rm KL}(P^w\|P)=
 \sum_{j,s:P_s>0}P_s [R_s\log(R_s/R_{s+w_j})-R_s+R_{s+w_j}].
\]
This follows by shifting indices in the differentiated sum; at \(R_s=0\) the bracket equals \(R_{s+w_j}\). Nonzero \(R_s\) implies the denominator there is positive, by closure of the support under each jump. The operations are justified by factorial tails and the preceding configuration/log bounds, or by truncating the differentiated sums. For example \(R_s=\mathbb E[Y_i\mid Z_t=s]/t\) for \(w=w_i\); if \(P_{s-w}>0\), its log inverse grows at most \(O((s+1)\log(s+2))\) on compact \(t\)-intervals. All terms are nonnegative. For \(w=w_i\), at \(s=0,j=i\) the bracket is strictly positive: \(R_0=0,\ P_0>0,\ R_w>0\). This proves strictness without a log-concavity assumption on the compound Poisson mass function.

Finally if \(t\to0\), writing dots for \(t\)-derivatives gives \(H''=-\sum\dot P_s^2/P_s-\sum\ddot P_s\log P_s\). The first sum is at least the Fisher information of the binary event \(S>0\), whose probability \(1-(1-t/m)^{dm}\) gives \(d/t+O(1)\) uniformly. The second sum in absolute value is \(O(1+|\log t|)\): per count vector the absolute second derivative divided by its probability is bounded by \(K(K-1)/t^2+C(K/t+1)\) using the product rule for \(p^Kq^{dm-K}\). Multiply by the log bound above with this realizing count \(k=K\). The expectations of \(K\) times fixed powers of \(K+1\) are \(O(t)\) and those of \(K(K-1)\) times such powers are \(O(t^2)\), by binomial factorial moments. This yields the claimed order even at \(K=0\). Hence the sign is strictly negative near this endpoint as well. Any sequence \(m\to\infty\) of failures has a subsequence in one of the three regimes \(mp\to0\), \(mp\to t\in(0,\infty)\), or \(mp\to\infty\), all excluded. Finite-support continuity extends strict concavity to the closed interval.

## 11. Computational evidence and reproducibility

The exploratory search evaluated 7,954 distinct admissible weight multisets at 29 common-parameter values, totaling 230,666 evaluations. It included every multiset of length at most eight with weights at most eight and containing 1, plus structured larger families. The implementation propagated probabilities and their first and second derivatives by direct convolution, without finite differences or FFT. Independent itemwise recurrence and exact integer collision counts supplied cross-checks. The maximum mass-second-derivative residual was approximately \(2.75\times10^{-15}\).

No sampled violation of the original concavity inequality, the stronger bound \(H_w''\le-1/[p(1-p)]\), or the binomial-curvature comparison was found. An additional 262-case rank diagnostic and a 265-case dense central-Hessian probe targeted specific proof risks. None of these finite searches proves a universal assertion. In particular, the binomial comparison and the general-fiber central Hessian sign remain unproved here. The certified positive conditional-rank example uses exact rational arithmetic and an explicit logarithm-series remainder, and is recorded separately from floating-point reconnaissance.

The historical reproduction record lists commands, model cases and observed outputs. [Reproduction](evidence/README.md) Source files and raw results are retained; overlapping exploratory batches are not added together as new independent cases. Third-party articles and shared toolchain caches are not included in the deliverable.

For the example in §9, exact rational log enclosures verify the finite positivity certificate. These calculations complement the proof. The replicated-pattern theorem in §10 follows from uniform analytic estimates rather than scanning parameter values.

## 12. Prior work and scope

Neunhäuserer [1, Conjecture 3.1] treats strictly increasing integer sequences with \(a_1=2\). After differences of adjacent weights and the translation/reflection in the introduction, it is the weighted common-parameter entropy concavity question with one weight one. Hillion–Johnson [3] establish the Shepp–Olkin result for ordinary independent Bernoulli sums with heterogeneous probabilities. The curvature comparison (M) treats a weighted model with small output fibers. Section 9 permits arbitrarily many configurations within a Hamming layer under a directly calculable Bernstein condition. Section 10 goes beyond the same-layer and binary assumptions after replication.

Gavalakis–Kontoyiannis [6, Theorems 1.1–1.2] prove discrete entropic central limit theorems for fixed iid lattice laws, using both entropy and relative entropy comparisons. Section 10.1 needs uniform control of two bias derivatives for a changing Bernoulli law, including vanishing bias. Johnson–Kontoyiannis–Madiman [7] study compound-Poisson maximum entropy and related semigroups. Section 10.2 uses classical relative-entropy contraction under a common jump generator, with strictness at a transition from an atom on the boundary of support. Its role is to connect the vanishing-bias scale to the large-count derivative estimate. Replication strict concavity is an existence theorem for each fixed pattern. The smallest sufficient number of copies and the single-copy general conjecture remain open. The full mathematical formalization is a separate deliverable.

## References

1. J. Neunhäuserer. *Recursive overlap Bernoulli distributions and an entropy concavity conjecture*. arXiv:2609.05546v2, 22 September 2026, Conjecture 3.1. <https://arxiv.org/html/2609.05546v2>.
2. Original question and subsequent mathematical discussion. *A recursive overlap construction of finite Bernoulli-sum laws and an entropy-concavity conjecture*. MathOverflow, question 514729 / answer 515134. <https://mathoverflow.net/questions/514729/a-recursive-overlap-construction-of-finite-bernoulli-sum-laws-and-an-entropy-con/515134>. Informal source; detailed formulas used here were independently derived.
3. E. Hillion and O. Johnson. *A proof of the Shepp-Olkin entropy concavity conjecture*. Bernoulli 23(4B), 3638-3649, 2017. DOI: 10.3150/16-BEJ860. <https://arxiv.org/abs/1503.01570>.
4. F. Topsøe. *Bounds for Entropy and Divergence for Distributions over a Two-Element Set*. Journal of Inequalities in Pure and Applied Mathematics 2(2), Article 25, 2001. Theorem 1.2 and Section 2. <https://ftp5.gwdg.de/pub/EMIS/journals/JIPAM/images/044_00_JIPAM/044_00_www.pdf>.
5. M. Madiman, L. Wang, and J. O. Woo. *Majorization and Rényi Entropy Inequalities via Sperner Theory*. Discrete Mathematics 342(10), 2911-2923, 2019. DOI: 10.1016/j.disc.2019.03.002. <https://arxiv.org/abs/1712.00913>.

6. L. Gavalakis and I. Kontoyiannis. *Entropy and the discrete central limit theorem*. Theorems 1.1–1.2. [Author preprint](https://arxiv.org/pdf/2106.00514).
7. O. Johnson, I. Kontoyiannis, and M. Madiman. *On the entropy and log-concavity of compound Poisson measures*. [Author preprint](https://arxiv.org/pdf/0805.4112).
