---
title: "Finite-size nonmonotone submodular correlation gaps"
subtitle: "Exact small-cap and four-element profiles"
date: "25 November 2026"
geometry: margin=0.9in
---

## Abstract

The sharp nonmonotone submodular correlation gap under a marginal cap \(p\) is \(1-e^{-(1-p)}\) when the ground-set size can grow. We determine the exact finite-size coefficient for every size \(n\) when \(p\le1/n\), and for every cap when \(n\le4\). A blocker with equal positive marginals attains the bound. We classify all equality cases in the exact regimes for \(n\ge3\). For arbitrary finite \(n\) and \(p\in(0,1)\), we prove attainment and a strict quantitative separation from the dimension-free constant. A pointwise comparison strengthens that constant when the positive marginals have a known minimum. The proofs use symmetrization in the small-cap range, a constructive cone decomposition in three dimensions, and exact rational certificates in four dimensions.

## 1. Setting and statements

Let \(N\) have \(n\) elements. A function \(f:2^N\to\mathbb R_{\ge0}\) is submodular if its marginal increments decrease with the conditioning set. We assume \(f(\varnothing)=0\). For \(x\in[0,1]^N\), let \(R(x)\) include the elements independently with probabilities \(x_i\), and write
\[
 F(x)=\mathbb E f(R(x)),\qquad
 f^+(x)=\max_{\mathcal L(S):\,\Pr(i\in S)=x_i}\mathbb E f(S).
\]
The maximum is attained because the feasible laws form a finite polytope. For \(p\in(0,1)\), define \(\Gamma_n(p)\) to be the infimum of \(F(x)/f^+(x)\) over these functions and vectors with \(\max_i x_i\le p\) and \(f^+(x)>0\). A parallel coefficient \(\Gamma_{n,=}(p)\) requires \(\max_i x_i=p\).

Chekuri and Livanos [1] gave the one-blocker obstruction and posed the sharp nonmonotone correlation-gap question. The pinned precursor [2] proved the dimension-free coefficient \(1-e^{-(1-p)}\), and in §7 explicitly left the coefficient at fixed cardinality undetermined. We treat that finite-size problem.

**Theorem 1.** If \(n\ge2\), put \(m=n-1\) and \(a=\min\{p,(1-p)/m\}\). Then
\[
 \Gamma_n(p)=\Gamma_{n,=}(p)
 =(1-p)\frac{1-(1-a)^m}{ma}
 \qquad\text{(1)}
\]
whenever \(p\le1/n\) or \(n\in\{2,3,4\}\). Both infima are attained. For every \(n\ge2\) and \(p\in(0,1)\), the right side of (1) is an upper bound for both coefficients. At \(n=1\), they equal one. The equality cases for \(n\ge3\) in the exact regimes are as follows. When \(n=3,4\) and \(p>1/n\), there is a unique blocker of marginal \(p\), all other marginals equal \(a\), and \(f\) is a positive multiple of the one-blocker function in Section 2. When \(p\le1/n\), all marginals equal \(p\) and \(f\) is a nonzero nonnegative combination of the one-blocker functions.

**Theorem 2.** Let \(x\ne0\), \(p_x=\max_i x_i<1\), \(b=\min_{i:x_i>0}x_i\), and \(c_b=-\log(1-b)/b\). Even without normalization,
\[
 F(x)\ \ge\
 \bigl(1-e^{-c_b(1-p_x)}\bigr) f^+(x)
 +(1-p_x)e^{-c_b(1-p_x)}f(\varnothing).
 \qquad\text{(2)}
\]
For each finite \(n\) and \(0<p<1\), the normalized cap and exact-cap infima are attained whenever \(n\ge2\), and are both strictly above \(1-e^{-(1-p)}\). More explicitly, put
\[
 A=1-p,\quad g=1-e^{-A},\quad
 \kappa=Ae^{-A}/4,\quad a_0=\min(p,A).
\]
Then both coefficients are at least
\[
 g+\frac{\kappa a_0}{2}\left(\frac{\kappa}{2n}\right)^n .
 \qquad\text{(3)}
\]
The minimum defining \(b\) may be restricted to indices with \(f(\{i\})>f(\varnothing)\) if that restricted set of positive marginals is nonempty. At \(x=0\) the two extensions both equal \(f(\varnothing)\).

## 2. The sharp constructions and the full small-cap range

Let \(b_0\) be one blocker and let the other \(m\) elements be positive. Put
\[
 f(S)=\mathbf1_{\{b_0\notin S,\ S\setminus\{b_0\}\ne\varnothing\}}.
\]
Adding a positive element can help only before any positive or the blocker is present. Adding the blocker has effect zero before a positive and minus one afterwards. These marginals satisfy diminishing returns. Take \(x_{b_0}=p\) and each positive marginal equal to \(a\) in (1). Since \(p+ma\le1\), the law on the corresponding singletons, with remaining mass at the empty set, attains \(f^+(x)=ma\). No law can exceed the sum of the positive marginals. The independent value is \((1-p)[1-(1-a)^m]\).

We also need a pointwise lower bound for this family over all capped vectors. Let \(u=1-x_{b_0}\), \(s=\sum_{i\ne b_0}x_i\), and \(H_m(s)=1-(1-s/m)^m\) on \(0\le s\le m\). The arithmetic-geometric mean inequality gives \(F(x)\ge uH_m(s)\). Also \(f^+(x)\le\min(u,s)\). For \(s\le u\), \(H_m(s)/s\) is decreasing by concavity. For \(s\ge u\), \(H_m(s)\) is increasing. Thus the least lower bound for \(s\le mp\) occurs at \(s=\min(u,mp)\). Its value increases as \(H_m(u)\) below \(mp\) and as a positive linear function of \(u\) above \(mp\). Therefore \(u\ge1-p\) gives exactly the right side of (1).

When \(p\le1/n\), for every \(x\le p\) one can realize all marginals by a law on the singletons and the empty set. By subadditivity for normalized submodular functions, this law is optimal and
\(f^+(x)=\sum_i x_i f(\{i\})\).
Both \(F(x)\) and the latter expression are multi-affine, so to prove the lower bound it suffices to consider vertices \(x=p\,\mathbf1_T\) of the cap box. Let \(r=|T|\). If \(r=0\) or \(r=1\) the claim is immediate. Otherwise symmetrize the restriction of \(f\) to \(T\) over all permutations, preserving the two sides to compare. Write \(v_j\) for its value on size \(j\). Submodularity makes \(v_j\) concave on the integer sequence, and nonnegativity gives \(v_r\ge0\). Thus \(v_j\ge v_1(r-j)/(r-1)\) for \(1\le j\le r\). With \(X\sim\operatorname{Bin}(r,p)\) and \(u=1-p\),
\(\mathbb E[(r-X)\mathbf1_{X\ge1}]=r u-r u^r\).
Dividing the resultant bound by \(rpv_1\) when it is positive yields
\[
 u\frac{1-u^{r-1}}{(r-1)p}
 =\frac{u}{r-1}\sum_{j=0}^{r-2}u^j.
\]
This is nonincreasing in \(r\le n\), so the bound for \(r=n\) proves (1). Zero denominators require only nonnegativity of \(F\). This calculation also supplies the vertex bound for every \(p\) against the linear singleton comparison, though it is the exact sharp expression only in the stated small-cap range.

For \(n\ge3\), equality in the small-cap range is rigid. The vertex comparison is strict at every support of size less than \(n\) with positive singleton sum because the averages of geometric powers strictly decrease, and the size-one ratio is one. Since \(f^+(x)>0\), some positive-marginal element \(i\) has \(f(\{i\})>0\). In the independent interpolation over cap-box vertices, a positive-probability support containing \(i\) cannot omit any other coordinate. Therefore every \(x_j=p\) for \(j\ne i\), and the full-support vertex has positive probability. At that vertex equality forces \(v_n=0\) and the cardinality sequence \(v_j\) to be affine for \(j\ge1\). For every nonempty base the adjacent submodularity slack has mean zero under symmetrization, and the original slacks are nonnegative. Thus they all vanish. It follows that each element's marginal increment \(d_i\) is constant over nonempty bases excluding it, since those bases are connected by additions and deletions that leave them nonempty. Pair values give \(f(\{i\})-d_i\) independent of \(i\). Hence for every nonempty \(S\), \(f(S)=-\sum_{i\notin S} d_i\), by \(f(N)=0\). The coefficients \(-d_i=f(N\setminus\{i\})\) are nonnegative, exactly the mixture of blocker functions. Such a nonzero mixture has at least \(n-1\) positive singleton values. A second positive singleton therefore forces \(x_i=p\) as well. The singleton law attains the ratio for every such mixture.

## 3. Two and three elements

We use the fact that if \(f=\sum_j c_j f_j\) with \(c_j\ge0\), then \(F=\sum_j c_j F_j\) and \(f^+(x)\le\sum_j c_j f_j^+(x)\). A uniform comparison for the generators thus passes to the whole cone.

On two elements, write \(a_i=f(\{i\})\) and \(e=a_1+a_2-f(N)\). Submodularity and nonnegativity give \(0\le e\le a_1+a_2\). Assign mass \(e\) to the two singletons' budgets \(a_1,a_2\). Each part is a coefficient of the directed function \(\mathbf1_{\{i\in S,j\notin S\}}\); unused mass multiplies the modular \(\mathbf1_{\{i\in S\}}\). A directed function has ratio at least \(1-p\), since \(F=x_i(1-x_j)\) and \(f^+\le x_i\). This matches the construction.

On three elements, put \(a_i=f(\{i\})\), \(e_{ij}=a_i+a_j-f(\{i,j\})\) and
\[
 t=f(N)-\sum_i a_i+\sum_{i<j}e_{ij}.
\]
Submodularity is \(e_{ij}\ge0\) and \(t\le e_{ij}\). Nonnegativity is \(a_i\ge0\), \(e_{ij}\le a_i+a_j\) and \(\sum e_{ij}-t\le\sum a_i\). The cone has the following four generator types.

1. The modular singleton.
2. The two-element directed function above.
3. A singleton that pays only if two other elements are not both present.
4. The one-blocker function on two positive elements.

Here is a direct decomposition. When \(t\le0\), assign each edge budget \(e_{ij}\) to its two endpoint budgets \(a_i,a_j\), using fractional amounts. The inequalities for each edge and for the total are exactly the feasibility conditions for this assignment by a two-sided flow test. Indeed any set of multiple distinct edges touches all three vertices. The assignments specify directed functions. The remaining singleton budget is at least \(-t\), which can be assigned to type 3, whose \(t\)-coordinate is minus one and whose \(e\)-coordinates vanish. The rest gives modular singletons.

When \(t>0\), subtract \(t\) mass of type 4 distributed among blockers with weights \(\lambda_i\). Choose these weights to sum to \(t\) with
\[
 \max(0,t-a_i)\le\lambda_i\le a_j+a_k-e_{jk},\qquad \{i,j,k\}=N.
\]
The lower endpoint is at most the upper because \(\sum a\ge\sum e-t\ge e_{jk}+t\). For two positive lower endpoints use \(a_i+a_j\ge e_{ij}\ge t\), and for three use \(\sum a_i\ge2t\), to bound their sum by \(t\). A single positive lower endpoint is itself at most \(t\). The sum of the upper endpoints is \(2\sum a-\sum e\ge\sum e-2t\ge t\). Thus the required weights exist. After subtraction the new Möbius coordinates are \(t'=0\), \(e'_{ij}=e_{ij}-t\), \(a'_i=a_i-t+\lambda_i\). The stated bounds on \(\lambda_i\) ensure \(a'_i\ge0\) and \(a'_i+a'_j\ge e'_{ij}\). The value of \(f(N)\) stays nonnegative. The preceding edge allocation finishes the decomposition.

The modular type has ratio one and type 3 has ratio at least \(1-p^2\), since \(F=x_i(1-x_jx_k)\) and \(f^+\le x_i\). The directed type has ratio at least \(1-p\). The one-blocker lower bound of Section 2 is no larger than these and equals (1) for \(n=3\).

## 4. Four elements

Only caps \(p\ge1/4\) remain. Write \(q=1-p\) and \(h(q)=q-q^2/3+q^3/27\), the value in (1) in this range.

The fifteen variables \(f(S)\), \(S\ne\varnothing\), satisfy fifteen nonnegativity inequalities and the twenty-four adjacent submodularity inequalities
\[
 f(S\cup i)+f(S\cup j)-f(S)-f(S\cup\{i,j\})\ge0,
 \qquad \{i,j\}\cap S=\varnothing.
\]
This cone has full dimension, as witnessed by a positive strictly concave cardinality function. The primary verification enumerates the extreme rays exactly by double description, starting from the positive orthant. At each new halfspace, it keeps the nonnegative rays and intersects the cut hyperplane with each adjacent pair of opposite signs. The pair is adjacent exactly when its common tight face contains no third extreme ray. This follows because the smallest face of a polyhedral cone containing two rays is given by their common tight rows, and a pointed two-dimensional cone has exactly two extreme rays. Intersecting a cone by a halfspace creates a ray only in a two-dimensional face crossing the cut, which follows by considering the dimension of the minimal old face and its hyperplane intersection. Fixed integer cut orders used by the two reproductions give 218 rays and 20 orbits under coordinate permutations.

For a representative \(f\), any affine majorant \(L_j(x)\) with \(L_j(\mathbf1_S)\ge f(S)\) for every \(S\) bounds \(f^+(x)\) by expectation. The verifier builds valid majorants by testing the sixteen inequalities after solving five independent cube vertex equations in rational arithmetic. Completeness of this majorant list as a description of \(f^+\) is unnecessary. To prove the lower bound, it suffices to check \(F(x)\ge h(1-p)\min_j L_j(x)\). We can assume some \(x_i=p\). If the original cap is larger than \(\max x_i\), the desired right side coefficient is smaller since \(h\) is increasing in \(q\); caps at most \(1/4\) were handled already.

On each of the four maximum-coordinate faces, the other three coordinates and \(p\) are four variables. Partition each face by which \(L_j\) has the smallest value. Each closed region is a bounded rational polytope. Its vertices are found by all four-row intersections and exact feasibility. Pulling from a vertex and coning over boundary facets that omit it gives a simplicial cover. The procedure recurses in the facets, deleting degenerate simplices; any intersections of smaller dimension are covered by closure of the full-dimensional pieces. The domain itself is the closure of its interior, so the inequalities extend by continuity to cells of smaller dimension.

The verifier proves the stronger three-element coefficient for each of the 19 non-blocker orbits. For \(p\le1/3\), the three-element target is \((1-p)(1-p/2)\). The singleton modular bound \(L(x)=\sum_i x_i f(\{i\})\) is an affine majorant. The difference from this target times \(L\) is multi-affine for a fixed \(p\), so check \(x=p\mathbf1_T\) for all nonempty \(T\). The polynomials along these 285 segments, including all 19 representatives, are verified on \(0\le p\le1/3\).

For \(p\ge1/3\), the three-element target is \(1-p-(1-p)^2/4\). Use the maximum-coordinate faces and the subdivision above with lower endpoint \(1/3\). On each simplex, let \(z_i\) be the homogeneous numerators of the four marginal values, \(D\) the common denominator, and \(Q=D-z_i\) for the active index. If \(L(x)=L_{\mathrm{num}}(x,1)/d_L\) with positive \(d_L\), the polynomial
\[
 4d_L\sum_{S\subseteq N} f(S)\prod_{j\in S}z_j\prod_{j\notin S}(D-z_j)
 -
 L_{\mathrm{num}}(z,D)\, QD(4D-Q)
 \qquad\text{(4)}
\]
is homogeneous of degree four and has the sign of \(F(x)-[1-p-(1-p)^2/4]L(x)\). On a low-cap segment use \(2d_L\) in the first term and \(QD(2D-z_i)\) in the correction. For each multiset of four simplex vertices, the alternating subset sum of the homogeneous polynomial at sums of those vertices is \(4!\) times its symmetric polarization. Its sign is the sign of the corresponding ordinary monomial coefficient in barycentric coordinates. All coefficients were checked nonnegative using integer arithmetic, on the 285 segments and 2,961 full-dimensional simplices. Any original cap larger than the actual maximum only lowers the target. The previous reduction to an active cap applies with this three-element target too.

The three-element coefficient is strictly greater than the four-element formula for \(0<p<1\). For \(p\le1/4\) this follows from the averages of geometric powers in Section 2. For \(1/4<p\le1/3\), divide the difference by \(1-p\) to obtain \(-p/2+(1-p)/3-(1-p)^2/27\), positive at \(1/3\) and decreasing in \(p\) on that interval. Above \(1/3\) the difference is \((1-p)^2(1/12-(1-p)/27)>0\). The one-blocker orbit gives the required four-element bound by Section 2. Nonnegative sums of rays preserve the inequality. The construction in Section 2 attains it, and Appendix A gives an independent verification directly at the four-element target.

### Equality in three and four elements

For a single one-blocker function with \(m\ge2\), equality in Section 2 requires \(x_{b_0}=p\) and \(s=\min(1-p,mp)\) by the strict monotonicities there. The arithmetic-geometric mean equality requires that all its positive marginals are equal to \(a>0\). The other ray types in three dimensions lie strictly above the target when their denominators are positive, as do the 19 other ray orbits in four dimensions.

Suppose equality holds for a nonnegative sum of rays. Subadditivity of \(f^+\) in \(f\) and nonnegativity of every coefficient in the sum imply that every positive-denominator summand satisfies equality. At least one such summand exists. That summand is a blocker function, so all marginal coordinates are in \((0,1)\). Every nonzero nonnegative normalized submodular function then has positive independent value, and hence positive denominator, because every subset has positive probability. Thus all summands are blocker functions. If \(p>1/n\), then \(a<p\), so only the single maximal coordinate can be the blocker. If \(p\le1/n\), \(a=p\) and the law on the singletons realizes the value for all blocker functions simultaneously. This proves exactly the stated classification.

## 5. A bound using the positive marginal floor

We give the details of (2). Two standard submodular inequalities are useful. If \(g\ge0\) is submodular and all probabilities of an independent random set \(T\) are at most \(a\), then
\(\mathbb E g(T)\ge(1-a)g(\varnothing)\).
To see this, the minimum over the probability box is attained at a vertex by multi-affinity. On any fixed support the extension along the common-probability segment is concave by the nonpositive cross-derivatives, so its value at \(a\) is at least \((1-a)g(\varnothing)+a g(\text{support})\). Also for any \(S\) and \(y\) the gain \(F(y\vee\mathbf1_S)-F(y)\) is at most \(\sum_{i\in S}(1-y_i)\partial_iF(y)\), by adding the coordinates one at a time and diminishing returns.

Set \(v_i=-\log(1-x_i)\), \(c=c_b\), and \(w_i=v_i-cx_i\). The function \(-\log(1-u)/u\) is increasing for \(u>0\) by its power series. With the unrestricted minimum it gives \(w_i\ge0\). With the restricted minimum, an index with \(w_i<0\) must satisfy \(f(\{i\})\le f(\varnothing)\). By diminishing returns, \(\partial_iF\le f(\{i\})-f(\varnothing)\le0\), so its contribution to the derivative is nonnegative and can be discarded. By convexity of \(-\log(1-u)-cu\) and its value zero at zero, the maximum of the \(w_i\) equals \(V-cp_x\) with \(V=\max v_i\). Use the interpolating path \(y_i(s)=1-e^{-s v_i}\) for \(0\le s\le1\) and let \(H(s)=F(y(s))\).

For an optimal correlated law of \(S\), the tangent bound and the independent-addition lower bound give
\[
 \sum_i x_i(1-y_i)\partial_iF(y)
 \ \ge\ e^{-sV} f^+(x)-H(s).
\]
For the nonnegative part of the \(w\)-direction, take independent additions with probabilities \(1-e^{-(w_i)_+\,ds}\), union them with the current independent set, and use the same lower bound pointwise given the current set. Differentiating at \(ds=0\) gives
\(\sum_i w_i(1-y_i)\partial_iF(y)\ge-(\max w_i)H(s)\).
Hence
\[
 H'(s)+(V+c(1-p_x))H(s)\ge c e^{-sV} f^+(x).
\]
Integrating from \(0\) to \(1\), using \(H(0)=f(\varnothing)\) and \(e^{-V}=1-p_x\), proves (2). This path ends at the exact product marginals. When the blocker construction has all positive marginals \(a\le p\) with \(ma=1-p\), it attains (2) on its normalized part, since \(e^{-c_a(1-p)}=(1-a)^m\).

## 6. Finite attainment and a uniform finite-size separation

To prove attainment for \(n\ge3\), the pointed polyhedral cone of normalized nonnegative submodular functions has finitely many extreme rays. Its generators suffice for the infimum by the same sum comparison as in Section 3. Fix one ray along a minimizing sequence after taking a subsequence, and pass to a limit of its marginal vectors in the compact cap box. The exact-cap restriction is closed as well. Continuity of \(f^+(x)\) follows by changing each coordinate of a law with the conditional probability needed for its new marginal. The union bound makes the total probability of change at most the \(\ell_1\) marginal distance. The difference in expected values is bounded by that probability times the maximum of the fixed \(f\).

If the limiting denominator is positive, the infimum is attained. Otherwise the product value also tends to zero. Write \(R\) for the elements whose limiting marginals vanish and \(K=N\setminus R\). Since \(p<1\), every subset of \(K\) has positive limiting product probability, so \(f\) vanishes on the whole power set of \(K\). Submodularity then gives
\[
 f^+(x)\le\sum_{i\in R}x_i f(\{i\}).
\]
The independent event with exactly one element \(i\) of \(R\), and any independent additions in \(K\), gives
\[
 F(x)\ge (1-p)\sum_{i\in R}x_i f(\{i\})
                         \prod_{j\in R\setminus\{i\}}(1-x_j).
\]
Because the rare marginals tend to zero, the limiting lower ratio is at least \(1-p\). This contradicts the one-blocker upper bound when \(n\ge3\) and \(p>0\), since \(1-(1-a)^{n-1}<(n-1)a\). Thus a positive-denominator minimizer exists. The two-element case has already been attained explicitly. Applying (2) to a minimizer proves strict separation.

For a nonasymptotic bound, use the constants of Theorem 2, put \(\rho=\kappa/(2n)\), and let \(a_j=a_0\rho^j\) for \(0\le j\le n+1\). At least one band \((a_{j+1},a_j]\), \(0\le j\le n\), contains no coordinate. Split the elements into \(K\) with probabilities above \(a_j\) and \(R\) with probabilities at most \(a_{j+1}\). Let \(C_K\) be the concave closure of the restriction to \(K\) at \(x_K\) and let \(W=\sum_{i\in R}x_i f(\{i\})\). Then \(f^+(x)\le C_K+W\) by submodularity. Counting events with zero or one occurrence in \(R\), and using the independent-addition bound for \(K\), gives
\[
 F(x)\ge P_0\bigl(F_K(x_K)+A W\bigr),
 \qquad P_0=\prod_{i\in R}(1-x_i)\ge1-n a_{j+1}.
\]
If \(K\) is empty the first term is zero. Otherwise apply (2) to \(K\). The series \(c_{a_j}\ge1+a_j/2\) gives
\(1-e^{-A c_{a_j}}\ge g+\kappa a_j\).
Also \(A-g=\int_0^A (1-e^{-t})\,dt\ge A^2/4\), so \(A\ge g+\kappa a_j\) since \(a_j\le A\). Both contributions are therefore multiplied by at least \(g+\kappa a_j\). As that number is at most one, the product with \(P_0\) is at least \(g+\kappa a_j-na_{j+1}=g+\kappa a_j/2\). This implies (3).

The one-blocker upper bound tends to the dimension-free coefficient from above at order \(1/n\) for fixed \(p>0\) [2, §7]. Formula (3) is a quantitative separation for each finite size. For \(n\ge5\) and \(p>1/n\), the general sharp finite-size profile beyond the bounds above remains open.

## Appendix A. A second four-element verification

For this verification the bound is \(h(q)=q-q^2/3+q^3/27\) on \(q=1-p\in[0,3/4]\). The exact enumeration sorts representatives lexicographically on subset masks \(1,\ldots,15\). Denote their indices by \(1,\ldots,20\). Thirteen representatives can use the singleton majorant alone. At a cap-box vertex \(x=p\mathbf1_T\), put \(a_T=\sum_{i\in T} f(\{i\})\). If \(a_T>0\), divide the difference from the desired bound by \(pa_T\). The result is
\[
 P_T(q)=\sum_{\varnothing\ne S\subseteq T}
 \frac{f(S)}{a_T}(1-q)^{|S|-1}q^{|T|-|S|}-h(q).
\]
It is a cubic. For its power coefficients \(c_j\), the Bernstein coefficients on \([0,3/4]\) are \(\sum_{j=0}^k c_j(3/4)^j\binom{k}{j}/\binom3j\). The second exact verifier confirms that all are nonnegative for the following representatives.

| Representatives | Minimum of each Bernstein coefficient over \(T\) |
| --- | --- |
| 1, 7 | \(0,0,1/16,11/64\) |
| 2 | \(0,1/4,3/8,23/64\) |
| 3 | \(0,1/2,1/2,13/32\) |
| 4 | \(1,3/4,9/16,27/64\) |
| 5, 10, 11 | \(0,1/8,5/16,43/128\) |
| 8 | \(0,0,5/32,31/128\) |
| 9 | \(0,0,1/4,5/16\) |
| 13, 18, 20 | \(0,0,1/64,35/256\) |

Representatives 6 and 14 are the one-blocker functions with two and three positive elements. For two positives even ignoring the upper limit on their sum gives at least \(1-(1-q/2)^2\ge h(q)\), by the same ratio argument in Section 2. Representative 17 is one blocker times the uniform rank-two function on three positive elements. Writing \(u\) for the blocker absence probability and \(s=x+y+z\) for the positive marginals' sum, it has \(F=u(s-xyz)\) and \(f^+\le\min(2u,s)\). Replacing \(xyz\) by \(s^3/27\), the ratio lower bound decreases until \(s=2u\) and increases thereafter. Therefore it is at least \(u(1-4u^2/27)\ge q(1-4q^2/27)\ge h(q)\).

For representative 12, let \(x,y\) be the two positive marginals and \(q\le u\le v\) the blocker absence probabilities. Its table of values yields
\[
 F=(u+v-uv)(x+y-xy)+uvy,\qquad f^+\le x+y+\min(y,u).
\]
For example, on the event that the second positive is present the payoff is the number of absent blockers, bounded by one plus the indicator that both are absent. The ratio with this upper denominator is increasing in \(v\), so set \(v=u\). It remains increasing in \(u\). When \(u\ge y\) the denominator is constant. For \(u\le y\), set \(K=x(1-y)\), \(M=x+y\), and differentiate \([2u(y+K)-u^2K]/(M+u)\). Its derivative has the sign of \(2M[y+(1-u)K]-u^2K\ge0\) since \(u\le y\). Set \(u=q\). The difference between \(F/q\) and the upper denominator times \(w=h(q)/q\) is affine in \(x\) and piecewise affine in \(y\), with knot at \(y=q\). At \(x=0\) or \(y=0\) it is nonnegative. At \(x=p,y=q\) for \(q\le1/2\), it equals \(1/9+4r/27+74r^2/27+28r^3/27\) with \(r=1/2-q\). At \(x=y=p\) it equals \(q(45-92q+28q^2)/27\) for \(q\le1/2\), or \(p(27q-10q^2-9)/9\) for \(q\ge1/2\). Both quadratics are positive on the indicated intervals.

For representatives 15 and 16, let \(u\) be the blocker absence probability and \(x,y,z\) the other marginals. Pointwise the payoff is at most two times the indicator of the third positive, plus the indicator of an absent blocker and at least one of the first two positives. Thus \(f^+\le2z+M\) with \(M=\min(u,x+y)\). With the third positive absent the independent value is \(u(x+y-xy)\ge h(q)M\). With it present, the respective values are \(1+u+uy(1-x)-(1-u)xy\) and \(2-(1-u)(x+y)\). Each is at least \(1+u-(1-u)p^2\). Subtracting \(h(q)(2+u)\) gives an increasing function of \(u\). At \(u=q\) its difference is \(q(2-10q/3+34q^2/27-q^3/27)\), nonnegative since the bracket decreases to \(37/192\) at \(q=3/4\). Combining the conditional values yields \(F\ge h(q)(2z+M)\).

For representative 19, keep the notation \(u,x,y,z\). Now
\[
 F=ux+(1-x)(y+z-(1-u)yz),\qquad f^+\le y+z+\min(u,x).
\]
The difference from \(h(q)\) times this upper denominator is increasing in \(u\), because when \(u<x\) its slope is at least \(x-h(q)\ge0\), and when \(u\ge x\) there is no subtraction in the slope. At \(u=q\) use \(yz\le p(y+z)/2\) and let \(s=y+z\). The resulting lower difference is affine in \(s\) and piecewise affine in \(x\) with a possible knot at \(q\). Its constant term in \(s\) is nonnegative. At \(x=0\) its \(s\)-coefficient is nonnegative because \(1-p^2/2\ge q\). At \(x=q\le p\) this coefficient is nonnegative because \(p(1-p^2/2)\ge7/16>h(1/2)\ge h(q)\). At \(x=p,s=2p\) the difference after division by \(q\) is \(p(3-p^2)-w[2p+\min(p,q)]\). It equals the corresponding nonnegative expressions for the corner \(x=y=p\) of representative 12. Every case follows.

## References

[1] Chandra Chekuri and Vasilis Livanos. *On submodular prophet inequalities and correlation gap*, Theoretical Computer Science 1019, 114814 (2024), especially Appendix A.2. <https://doi.org/10.1016/j.tcs.2024.114814>.

[2] earlier research manuscript. *The sharp marginal-cap correlation gap for nonnegative submodular functions*. Fixed archive bb30fe2, especially §7.
