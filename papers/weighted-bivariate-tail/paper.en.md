---
title: "Sharp weighted bivariate tails under leave-one-out mean constraints"
fontsize: 11pt
geometry: margin=1.1in
abstract: |
  We determine the largest rejection probability of a weighted sum of two nonnegative variables when each variable has a conditional mean bound given the other. The sharp tail equals the independent extremal value even under these weaker joint-law restrictions. Three elementary laws attain the candidate values, and bounded explicit multipliers certify a matching bound over the continuum. Above the sum of the mean budgets, every extremal law is a mixture of the active candidates. For equal budgets, the result locates an exact transition between the one-spike and independent two-spike laws.
---

## 1. The sharp tail and the extremal laws

Let \(X,Y\) be nonnegative random variables on a common probability space. Suppose
\[
\mathbb E[X\mid Y]\le a,\qquad \mathbb E[Y\mid X]\le b
\tag{1}
\]
almost surely. We first normalize the rejection event to \(\{X+Y\ge1\}\). Assume \(a,b>0\) and \(a+b<1\). Write
\[
S=a+b-ab,\qquad W=1-b,\qquad Z=1-a,\qquad
A=\max\{S,\ a/W,\ b/Z\}.
\tag{2}
\]

**Theorem 1.** Over all joint laws satisfying (1), the maximum probability of \(X+Y\ge1\) is \(A\). The complete set of maximizers is the convex hull of the following laws whose displayed value equals \(A\).

| Law | Rejection probability |
|---|---:|
| Independent \(X,Y\) supported on \(\{0,1\}\), with means \(a,b\) | \(S\) |
| \(Y=b\) surely, and \(X\in\{0,W\}\) with mean \(a\) | \(a/W\) |
| \(X=a\) surely, and \(Y\in\{0,Z\}\) with mean \(b\) | \(b/Z\) |

These laws satisfy (1) at equality. Convex mixtures retain feasibility because the conditional inequalities can be written as linear expectation inequalities against nonnegative functions of the conditioning coordinate. They also retain the exhibited probability where the active values tie.

For a weighted sum \(w_1 U+w_2 V\) at threshold \(t>0\), under unit leave-one-out bounds for \(U,V\), use \(X=w_1U/t,\ Y=w_2V/t\) and \(a=w_1/t,\ b=w_2/t\). When \(a+b\ge1\), the sharp value is one by taking constant coordinates at their budgets. When one budget vanishes, its variable vanishes almost surely and the sharp value is the one-coordinate Markov bound, capped at one. In particular, with two unit budgets and an unweighted sum at \(t>2\), (2) reads
\[
\max\left\{\frac2t-\frac1{t^2},\ \frac1{t-1}\right\}.
\tag{3}
\]
The second expression dominates for \(2<t<(3+\sqrt5)/2\), the first for \(t>(3+\sqrt5)/2\), and they agree at the boundary. The formulas identify the exact rejection-size calibration for the two-coordinate linear rule.

The pinned leave-one-out duality analysis [1] proves existence of arbitrarily accurate general certificates and computes an exact maximum-coordinate tail. Here the sum couples the two coordinates, and we give an explicit optimal certificate and classify equality. The independent extremal candidates are the two-coordinate families of the classical Samuels problem [2]. The new scope is the bound for every joint law obeying (1), with a characterization of all maximizing joint laws.

## 2. A bounded continuum certificate

We can replace \(X,Y\) by \(X\wedge1,Y\wedge1\). This preserves the event and (1). For instance, conditional expectation of \(X\wedge1\) given \(Y\wedge1\) is bounded by \(\mathbb E[X\mid Y\wedge1]\le a\) by the tower property. A pointwise inequality on \([0,1]^2\) of the form
\[
A+u(y)(x-a)+v(x)(y-b)\ge \mathbf 1_{\{x+y\ge1\}},
\qquad u,v\ge0,
\tag{4}
\]
therefore proves the upper bound if the multipliers are bounded and measurable. Conditional expectation makes both multiplier terms nonpositive on average.

Put \(T=1-a-b\), so \(W=T+a\) and \(Z=T+b\). Define
\[
u_0=\frac{A}{S}(1-b/2),\qquad v_0=\frac{A}{S}(1-a/2);
\qquad a u_0+b v_0=A .
\tag{5}
\]
For \(y\le b\) set \(u(y)=u_0+v_0y/a\). For \(y>b\) put \(w=y-b\) and define
\[
u_N(w)=\frac{A+v_0 w}{a}.
\tag{6}
\]
If \(0<w\le T\), set \(u(y)=u_N(w)\). If \(T<w\le W\), set
\[
u(y)=\min\{u_N(w),u_R(w)\},\qquad
u_R(w)=\frac A b-\frac{u_0 w}{b}
+\frac{A Z/b-1}{w-T}.
\tag{7}
\]
Use the symmetric definitions for \(v(x)\), swapping \(a\) and \(b\), \(u_0\) and \(v_0\), \(W\) and \(Z\). Formulas (5)–(6) match at \(y=b\) with \(u_N(0)=A/a\). We will show that \(u_R\) is strictly positive on its domain. Thus the minimum in (7) gives a strictly positive bounded Borel function even when the rational branch diverges at \(T\).

### 2.1. A bound for the rejection branch

For \(T<w\le W\) we claim
\[
w u_R(w)\ge (1-A)\frac{W}{2Z}.
\tag{8}
\]
Equality can hold only at \(w=W\) with \(A=S\). This also proves positivity, since \(A<1\) in the assumed interior parameter range.

At \(w=W\), the expression \(u_R(W)\) equals \((A-1+v_0W)/a\). With \(A=S\) and the corresponding \(v_0=1-a/2\), this is \(W/2\), giving equality in (8) since \(1-S=WZ\). Holding \(a,b\) fixed, \(u_R(W)\) increases strictly with \(A\) and the claimed bound decreases strictly. This proves the endpoint inequality and its equality condition.

Let \(q(w)=w(A-u_0w)/b\), a strictly concave quadratic. Then
\[
w u_R(w)=q(w)+(AZ/b-1)\frac{w}{w-T},
\tag{9}
\]
with \(AZ/b-1\ge0\) from (2). If \(q(T)\ge q(W)\), the right side is at least its endpoint value at \(W\), because \(q(w)\ge q(W)\) and \(w/(w-T)\) is decreasing. For \(T<w<W\), strict concavity gives \(q(w)>q(W)\).

If \(q(T)<q(W)\), the difference of the quadratics gives \(A>u_0(T+W)\), so that \(q(T)>Tu_0W/b\). Since \(1-A\le T/\max(W,Z)\), it suffices to show
\[
2u_0\max(W,Z)Z\ge b.
\tag{10}
\]
In fact (10) implies \(q(T)>(1-A)W/(2Z)\), and concavity gives \(q(w)\ge q(T)\) on the interval. To verify (10), consider two cases.

- For \(a\ge b\), \(W\ge Z\) and \(A\ge a/W\), so (10) follows from \((2-b)a(1-a)\ge bS\). For fixed \(b\), the difference is concave in \(a\) on \([b,1-b]\). The endpoint differences are \(b(2-5b+2b^2)\) and \(b(1-2b)\), nonnegative since \(b<1/2\).
- For \(a\le b\), \(Z\ge W\) and \(A\ge b/Z\), so it suffices that \((2-b)(1-a)\ge S\). The difference is \(2-2b-3a+2ab\), decreasing in \(a\). At the largest possible \(a=\min(b,1-b)\), it equals \(2-5b+2b^2\) for \(b\le1/2\) and \((2b-1)(1-b)\) for \(b\ge1/2\), both nonnegative.

This proves (8). The analogous inequality for the other rejection branch is
\[
z v_R(z)\ge (1-A)\frac{Z}{2W},\qquad T<z\le Z,
\tag{11}
\]
with equality only at \(z=Z\) and \(A=S\).

### 2.2. Proof of the pointwise inequality

If \(x\le a,\ y\le b\), the event is false. The left side of (4) equals \((u_0/b+v_0/a)xy\), which is nonnegative and vanishes exactly when \(xy=0\).

Consider \(x<a,\ y>b\), writing \(w=y-b\). For a fixed \(y\), the bound on \(u(y)\) required by (4) is
\[
\frac{A+(v_0+u_0 x/b)w-\mathbf 1_{\{x+y\ge1\}}}{a-x}.
\tag{12}
\]
On the nonrejecting interval, this function is strictly increasing in \(x\), with derivative numerator \(Ay/b>0\). The bound \(u_N(w)\) is its value at \(x=0\) with the indicator set to zero. On the rejecting interval with \(x<a\), we must have \(y>Z\), and the derivative numerator is \(Ay/b-1>0\) because \(A\ge b/Z\). The minimum is at \(x=1-y\). Substituting gives \(u_R(w)\) in (7). Thus the selected multiplier meets all requirements. Equality in this mixed region requires \(x=0\) for nonrejection, or \(x=1-y\) for rejection. At \(x=a,\ y>b\), the original left side in (4) equals \(A y/b\). It is adequate for rejection since then \(y\ge Z\). It is tight there only at \(y=Z\) and \(A=b/Z\). The case \(x>a,\ y\le b\) follows by interchanging the coordinates.

For \(x>a,\ y>b\), put \(z=x-a>0,\ w=y-b>0\). In nonrejection the left side is strictly positive. Consider rejection, equivalent to \(z+w\ge T\).

- If both \(z,w\le T\), the two multipliers use their \(N\) branches. Since \(A T/\max(a,b)\ge 1-A\), we have
  \[
  u_N(w) z+v_N(z)w>A(z/a+w/b)\ge 1-A.
  \]
  Strictness follows from the positive linear slopes and \(z,w>0\).
- If \(w\le T,\ z\ge T\), then \(u_N(w)z>AT/a\ge1-A\). If \(z\le T,\ w\ge T\), use the other multiplier. The same single-term argument works when \(z,w>T\) and at least one actual multiplier takes its \(N\) value.
- If both \(z,w>T\) and both actual multipliers take their \(R\) values, (8)–(11) give
  \[
  u_R(w) z+v_R(z)w
  \ge \frac{1-A}{2}\left(\frac{Wz}{Zw}+\frac{Zw}{Wz}\right)
  \ge 1-A.
  \]
  Equality requires \(w=W,\ z=Z\) and \(A=S\), hence \(x=y=1\). At this point both multipliers are indeed on their \(R\) branches and the inequality is tight.

These cases prove (4). Taking expectations yields probability at most \(A\), and the explicit laws in Theorem 1 attain it.

## 3. All least favorable laws

Let an extremizer first be clipped to \([0,1]^2\). Since the pointwise slack in (4) is nonnegative and the expected multiplier corrections are nonpositive, equality of the total bound forces zero slack almost surely. Both multipliers are strictly positive. Hence (1) holds at equality almost surely for the clipped law, and in particular \(\mathbb E[X\wedge1]=a\), \(\mathbb E[Y\wedge1]=b\). The original means are at most those budgets, which forces \(X=X\wedge1,\ Y=Y\wedge1\) almost surely. We may proceed with this bounded law.

For \(Y>b\), the tight points with \(X\ge a\) can only be \((a,Z)\) when \(A=b/Z\), or \((1,1)\) when \(A=S\). On any other such \(Y\), all tight points have \(X<a\), incompatible with \(\mathbb E[X\mid Y]=a\). More formally, on that event every fiber would have strictly positive conditional expectation of \(a-X\). Thus \(Y>b\) is supported on the allowed members of \(\{Z,1\}\). At \(Y=Z\), conditional equality gives \(X=a\) surely, since no allowed point in this fiber has \(X>a\). At \(Y=1\), only \(X=0\) or \(X=1\) can be tight. In the mixed portion \(X<a\) this follows from the rejection equality \(X=1-Y\); the boundary \(X=a\) is strict there. By symmetry \(X>a\) is supported on the allowed members of \(\{W,1\}\).

If \(0<Y<b\), the only tight point with \(X\le a\) has \(X=0\). The permitted high values \(X=W,1\) cannot contribute a tight mixed point at this \(Y\). For \(X=W\) the point is nonrejecting and tightness would require \(Y=0\). For \(X=1\) the point is rejecting and tightness again requires \(Y=0\). Thus \(\mathbb E[X\mid Y]=a>0\) excludes \(0<Y<b\). The symmetric argument excludes \(0<X<a\).

The possible support is now contained in the binary rectangle \(\{0,1\}^2\) and the two disjoint pieces \(\{(0,b),(W,b)\}\), \(\{(a,0),(a,Z)\}\) for the active branches. The point \((a,b)\) is strict in the low-low rule. A nonzero piece at \(Y=b\) requires the \(a/W\) branch and its weights are in the proportion specified by \(\mathbb E[X\mid Y=b]=a\). The piece at \(X=a\) is symmetric. In the binary rectangle, the equations at \(Y=0\) and \(X=0\) are unaffected by the respective points \((a,0)\) and \((0,b)\), which are already at the conditional budget. Writing \(p_{ij}\) for the mass at binary point \((i,j)\), the two equations are \((1-a)p_{10}=a p_{00}\) and \((1-b)p_{01}=b p_{00}\). The balance at \(Y=1\) gives \((1-a)p_{11}=a p_{01}\). This determines the normalized binary weights as the independent Bernoulli law, including vanishing of the whole binary piece if \(p_{00}=0\). If the \(S\) branch is inactive then \((1,1)\) is strict, so the binary piece vanishes. This proves the complete convex-hull description.

## 4. Scope and references

The certificate controls all joint laws satisfying the pair of conditional mean bounds, including dependent ones. It applies to a weighted linear rejection boundary in two coordinates. The direct proof gives explicit bounded multipliers and equality. Higher-dimensional sums and arbitrary rejection regions have distinct certificate problems.

1. *Sharp leave-one-out duality for nonparametric mean tests*, earlier research manuscript, fixed commit 2dd25784f49b. General bounded-reward duality, finite-grid approximation, and sharp maximum-coordinate example. The source manifest gives the exact path and blob.
2. S. M. Samuels. *On a Chebyshev-type inequality for sums of independent random variables*. Annals of Mathematical Statistics 37 (1966), 248–259. Background on the independent extremal problem.
