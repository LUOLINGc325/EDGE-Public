---
title: "The trivariate Gaussian Simes inequality uniformly near level one"
subtitle: "Perfect-correlation boundary layers and the complete equality cases"
lang: en
geometry: margin=1in
fontsize: 11pt
---

## Abstract

For three centered Gaussian coordinates of unit variance, we prove that the two-sided Simes test controls its level in a fixed neighborhood of one, uniformly over every correlation matrix, including singular matrices. This removes the previous requirement of a correlation cap strictly below one. Equality holds precisely at independence, at a perfectly correlated or anticorrelated pair independent of the remaining coordinate, and when all three absolute values are identical. Uniform control at degeneracy follows by comparing the gain from splitting near-zero strips with the loss from crossing the other acceptance thresholds. We also give the joint endpoint profiles when a perfect pair or a rank-one covariance is approached at the scale of the smallest threshold.

## 1. Statement and setup

Write \(\Phi,\phi\) for the standard normal distribution function and density. Let \(Z\) be a centered Gaussian vector with a positive semidefinite \(3\times3\) correlation matrix \(\Sigma=(\rho_{ij})\). The two-sided \(p\)-values are \(P_i=2[1-\Phi(|Z_i|)]\). At level \(q\), Simes rejects if \(P_{(j)}\le jq/3\) for some \(j\in\{1,2,3\}\). Write \(F_\Sigma(q)\) for its rejection probability.

**Theorem 1.** One has \(F_\Sigma(q)\le q\) for every correlation matrix \(\Sigma\) whenever \(1-10^{-80}\le q<1\). In this interval, equality holds precisely at the following correlation matrices, allowing permutations and sign changes of the coordinates:

1. The identity.
2. One perfectly correlated pair independent of the third coordinate.
3. A rank-one correlation matrix.

Each of these equality matrices gives \(F_\Sigma(q)=q\) at every \(q\in(0,1)\). The explicit endpoint interval in Section 5 is conservative.

The archived predecessor proves the same inequality near one under any fixed pairwise correlation cap strictly below one. Its cutoff shrinks as that cap grows to one. The theorem combines that result with estimates in two neighborhoods of perfect correlations. The question of all levels for arbitrary covariances is broader than the endpoint interval considered here. Fixed predecessor, Theorem and §5

Write \(h=1-q\) and
\[
A=\Phi^{-1}(1-q/6),\qquad B=\Phi^{-1}(1-q/3),\qquad C=\Phi^{-1}(1-q/2).
\]
The endpoint limits of \(A,B\) are \(A_0=\Phi^{-1}(5/6)\) and \(B_0=\Phi^{-1}(2/3)\). The nonrejection event \(\mathcal N\) is the union over \(i\) of
\[
E_i=\{|Z_i|<C,\ \max_{j\ne i}|Z_j|<A,\ \min_{j\ne i}|Z_j|<B\}.
\]
Each single-coordinate boundary has probability zero, even for singular \(\Sigma\). Throughout take \(q\ge9/10\) and \(C\le1/10\). In particular
\[
A_0>4/5,\quad B_0>2/5,\quad A<2,\quad C/2\le h\le C.
\]
For the lower quantile bounds use \(\phi(x)<2/5\), for \(A<2\) use the normal tail bound \(\Pr(|Z_i|\ge2)\le1/4<q/3\), and for \(h\) use \(h=2\int_0^C\phi(x)\,dx\). Put \(\kappa=1/100\).

## 2. A perfect pair and its perturbed acceptance probability

We first establish a baseline for the pair collapsed exactly. For a bivariate standard Gaussian \((X,Y)\) of correlation \(r\), let
\[
\mathcal N_0=\{|X|<C,\ C\le|Y|<A\}\ \cup\ \{|Y|<C,\ |X|<B\}.
\]
This is the nonrejection event for \((X,X,Y)\). Fix \(v>0\) and assume \(\sqrt{1-r^2}\ge v\). Then for sufficiently small \(C\), uniformly in \(r\) in this range,
\[
\Pr(\mathcal N_0)\ge h[1+a r^2],\qquad a=(2/5)\phi(3)>0. \qquad\text{(1)}
\]
To prove it, let \(s_r=\sqrt{1-r^2}\), and let \(G_T(r,x)=\Pr(|N(rx,s_r^2)|<T)\). Exchangeability of \((X,Y)\) makes the left side of (1) equal to
\[
\int_{-C}^C\phi(x)[G_A(r,x)+G_B(r,x)-G_C(r,x)]\,dx .
\]
At \(r=0\) the bracket is \(1\), by the definitions of the thresholds. At either \(T=A\) or \(T=B\), the gain at \(x=0\) is
\[
2[\Phi(T/s_r)-\Phi(T)]\ \ge\ 2\phi(3)(Tr^2/2)\ \ge\ a r^2.
\]
Here \(T/s_r\ge T+Tr^2/2\) and \(T+Tr^2/2\le3\), so the comparison uses only a fixed bounded interval of the density. The conditional mean shift loses at most \(r^2 C^2/v^2\). Indeed \(G_T(r,x)=\Phi((T-rx)/s_r)+\Phi((T+rx)/s_r)-1\), and \(|\phi'|\le1\). For \(T=C\), unimodality bounds \(G_C(r,x)\) above by \(G_C(r,0)\), whose excess over its standard-normal value is at most \(Cr^2/v\). Here \(1/s_r-1=r^2/[s_r(1+s_r)]\). Thus the bracket exceeds or equals \(1+r^2(2a-2C^2/v^2-C/v)\), which implies (1) for \(C\le v a/8\).

Now align signs so \(\rho_{12}\ge0\), and write \(s=\sqrt{1-\rho_{12}^2}\). Assume both \(|\rho_{13}|,|\rho_{23}|\le\sqrt{1-v^2}\). We show that for \(C\) and \(s\) sufficiently small, with cutoffs depending only on \(v\),
\[
\Pr_\Sigma(\mathcal N)
\ \ge\ h[1+a\rho_{13}^2]+\tfrac12 k(v)\min(C,s), \qquad\text{(2)}
\]
where \(k(v)>0\) is specified below.

Use the two disjoint baseline events for the actual pair \((X,Y)=(Z_1,Z_3)\). From the first baseline event, remove cases with \(|Z_2|\ge B\); the remaining cases are nonrejections. From the second event remove cases with \(|Z_2|\ge B\), again leaving only nonrejections. In addition the following event is a nonrejection disjoint from both baseline events:
\[
J=\{|Z_2|<C\le|Z_1|<B,\quad C\le |Z_3|<A\}.
\]
It follows that
\[
\Pr_\Sigma(\mathcal N)\ge \Pr(\mathcal N_0)+\Pr(J)-L_1-L_2,\qquad\text{(3)}
\]
where
\[
L_1=\Pr(|Z_1|<C,\ |Z_2|\ge B),\qquad
L_2=\Pr(|Z_3|<C,\ |Z_1|<B\le|Z_2|).
\]

**The gain.** Suppose \(s>0\). Realize
\[
Z_2=U,\qquad Z_1=\rho_{12}U+sV,\qquad
Z_3=\rho_{23}U+\beta V+\gamma W
\]
with independent standard normals \(U,V,W\), \(\gamma\ge0\), and \(\beta^2+\gamma^2=1-\rho_{23}^2\ge v^2\). This representation includes \(\gamma=0\). Let \(\Delta=\min(C/2,s/40)\), and restrict \(U\in(C-\Delta,C)\), \(V\in[1/10,1/5]\). For \(s,C\le1/10\), \(Z_1>C\) follows from \(1-\rho_{12}\le s^2\) and \(\Delta+s^2C<s/10\). Also \(Z_1\le C+s/5<B\).

For \(C\le v/1000\), the condition \(C<|Z_3|<A\) has a uniform positive probability on these intervals. If \(|\beta|\ge v/2\), take \(|W|\le v/100\). The term \(\beta V\) then has magnitude at least \(v/20\) and the other terms together have magnitude at most \(C+v/100\). The sum has magnitude less than \(1/5+C+v/100<A\). If \(|\beta|<v/2\), then \(\gamma\ge\sqrt{3}v/2\). Take \(1/4\le |W|\le1/3\) and the same sign as \(\beta\), choosing the positive sign if \(\beta=0\). The magnitude of the sum is at least \(\gamma/4-C>C\) and at most \(1/5+1/3+C<A\). Since the density of \(U\) on its interval exceeds \(1/4\), this gives \(\Pr(J)\ge k(v)\min(C,s)\), where
\[
k_*=\frac{\Phi(1/5)-\Phi(1/10)}{160},\qquad
k(v)=k_*\min\{2\Phi(v/100)-1,\ \Phi(1/3)-\Phi(1/4)\}. \qquad\text{(4)}
\]

**The losses.** Conditioning on \(Z_1=x\) in its strip gives
\[
L_1\le 2h\exp(-\kappa/s^2), \qquad\text{(5)}
\]
with zero loss when \(s=0\), since \(B-C\ge 3/10\). To estimate \(L_2\), put \(D=Z_2-Z_1\), which has variance \(2(1-\rho_{12})\le2s^2\). Regress \(D\) onto the orthogonal Gaussian variables \(Z_3\) and \(Z_1-\rho_{13}Z_3\):
\[
D=aZ_3+b(Z_1-\rho_{13}Z_3)+\tau G,\qquad
|a|\le\sqrt2 s,\quad |b|\le\sqrt2 s/v,\quad 0\le\tau\le\sqrt2 s.
\]
Here \(G\) is standard normal independent of \((Z_1,Z_3)\), also possible if \(\tau=0\). The coefficient bounds follow by Cauchy–Schwarz and \(\operatorname{Var}(Z_1-\rho_{13}Z_3)\ge v^2\). On \(|Z_3|<C\), \(|Z_1|<B\), this gives \(|D|\le (4\sqrt2/v)s(1+|G|)\). If \(L_2\) occurs, \(B-|Z_1|\le |D|\). Conditional on \((Z_3,G)\), this confines \(Z_1\) to the portions of \((-B,B)\) within the displayed distance of \(\pm B\). The density of \(Z_1\) there is bounded by \(1/(v\sqrt{2\pi})\). Integrate this bound over both intervals, then over \(G\) and \(|Z_3|<C\), to obtain
\[
L_2\le K(v)hs,\qquad K(v)=16/v^2. \qquad\text{(6)}
\]
The same reasoning applies after exchanging indices \(1,2\).

Because \(h\le C\), (5) divided by \(\min(C,s)\) is at most \(2(1+s^{-1})\exp(-\kappa/s^2)\). This tends to zero as \(s\downarrow0\). Likewise (6) divided by \(\min(C,s)\) is at most \(K(v)\max(C,s)\). For sufficiently small \(C,s\), each loss is at most \(k(v)\min(C,s)/4\). Equations (1) and (3) now imply (2). If \(s=0\) the pair is identical and (1) applies directly. In the pair neighborhood, strictness holds unless \(s=0\) and \(\rho_{13}=0\).

## 3. Three near-perfect pairs

Let \(d=\max_{i<j}\sqrt{1-\rho_{ij}^2}\) and suppose \(d\) is small. Write \(S_i=\{|Z_i|<C\}\). For the pair that attains \(d>0\), the \(U,V\) strips in the gain argument, with signs aligned on that pair, give
\[
\Pr\Big(\bigcup_i S_i\Big)\ge h+k_*\min(C,d).
\]
Specifically one whole strip has probability \(h\), and choosing \(U\in(C-\min(C/2,d/40),C)\) and \(V\in[1/10,1/5]\) puts \(U\) in its strip and the other coordinate outside that other's strip. These two events are disjoint.

When all magnitudes are below \(B\), every point in the strip union is a nonrejection. A loss therefore requires \(|Z_i|<C\) and \(|Z_j|\ge B\) for some ordered distinct pair. Each such probability is bounded by \(2h\exp(-\kappa/d^2)\) by the same one-coordinate conditioning as (5), including zero conditional variance. Consequently
\[
1-F_\Sigma(q)\ge h+k_*\min(C,d)-12h\exp(-\kappa/d^2).
\]
For \(d>0\) sufficiently small, the loss is at most \(k_*\min(C,d)/2\), uniformly for \(C\le1/10\). Thus the inequality is strict. If \(d=0\), all absolute values agree almost surely and nonrejection has exactly probability \(h\) at every level.

## 4. Boundary-layer limits

The preceding estimates suffice for a uniform theorem. The following limits describe how the endpoint slope changes on the shrinking-correlation scale.

**Theorem 2 (one near-perfect pair).** Suppose \(q\uparrow1\), \(s\to0\), with the representation in Section 2 and \((\rho_{23},\beta,\gamma)\to(r,\beta_0,\gamma_0)\), where \(|r|<1\). If \(s/C\to\ell\in[0,\infty]\), then
\[
\frac{1-F_\Sigma(q)}{h}\ \longrightarrow\
2G_{A_0}(r,0)+G_{B_0}(r,0)
-\mathbb E\!\left[(1-\ell|V|/2)_+\,\mathbf1_{\{|\beta_0 V+\gamma_0 W|<A_0\}}\right]. \qquad\text{(7)}
\]
The factor is interpreted as zero almost surely when \(\ell=\infty\). At \(\ell=0\), the limit is the collapsed-pair coefficient \(G_{A_0}(r,0)+G_{B_0}(r,0)\). For \(\ell>0\) it is strictly larger than that coefficient.

Indeed, the probability of \(E_1\cup E_2\) differs from that of \((S_1\cup S_2)\cap\{|Z_3|<A\}\) by at most the sum of the pair-strip losses (5) in both directions. To see this, the events agree whenever a pair strip occurs and the other member of that pair is below \(B\). The probability of \(E_3\) differs from that of \(S_3\cap\{|Z_1|<B\}\) by at most the two crossing bounds (6). The overlap of this third strip and the pair strips is \(O(h^2)\) since both cross-correlations are bounded away from absolute one, so their bivariate densities are bounded. These errors are \(o(h)\). By conditional normals the two single pair-strip terms each tend after division by \(h\) to \(G_{A_0}(r,0)\). The third term tends to \(G_{B_0}(r,0)\).

The pair intersection is treated by conditioning on \(U=Cx\), \(-1<x<1\). The remaining pair-strip condition is \(|\rho_{12}x+(s/C)V|<1\), while the \(Z_3\) condition tends to \(|\beta_0V+\gamma_0W|<A_0\). Use dominated convergence and \(h/C\to2\phi(0)\). For fixed \(V\) and finite \(\ell\), the fraction of the interval \([-1,1]\) retained by the shifted strip is \((1-\ell|V|/2)_+\). The limiting boundaries have zero measure, including when \(\gamma_0=0\), because \(\beta_0^2+\gamma_0^2=1-r^2>0\). If \(\ell=\infty\), the retained event forces \(|V|\le2C/s\), giving a vanishing coefficient. This proves (7). The strict increase above the collapsed coefficient for \(\ell>0\) follows because \(|V|>0\) almost surely on an event of positive probability where \(|\beta_0 V+\gamma_0 W|<A_0\).

**Theorem 3 (three merging absolute values).** Suppose \(q\uparrow1\) and \(d\to0\). Align signs with \(Z_1=U\), and write \(Z_i=r_i U+CY_i\), with \(Y_1=0\) and \(r_1=1\). The centered Gaussian vector \(Y\) is independent of \(U\). If its covariance matrices converge to some finite covariance \(T\), let \(Y^\infty\) be centered Gaussian with covariance \(T\). Then
\[
\frac{1-F_\Sigma(q)}h\ \longrightarrow\
\frac12\,\mathbb E\!\left[\operatorname{length}
\left(\bigcup_{i=1}^3[-1-Y_i^\infty,\,1-Y_i^\infty]\right)\right]. \qquad\text{(8)}
\]
The limit lies in \([1,3]\), and equals one precisely when \(Y^\infty=0\) almost surely.

By Section 3, the difference between \(\Pr(\mathcal N)\) and the whole strip union is at most \(12h\exp(-\kappa/d^2)=o(h)\). Conditional on \(Y\), the strip union after writing \(U=Cx\) is a union of three intervals with endpoints \((-1-Y_i)/r_i\) and \((1-Y_i)/r_i\); here \(r_i\to1\) and are positive for all sufficiently small \(d\). The conditional integral has weight \(C\phi(Cx)\). One can couple \(Y\) to \(Y^\infty\) by applying the converging positive semidefinite square roots of their covariance matrices to the same standard Gaussian vector. For each draw the interval endpoints then converge and the weighted integrals divided by \(h\) converge to half the limiting union length. They are uniformly bounded since the sum of interval lengths is at most \(6/\min r_i\) and \(C/h\) is bounded. Dominated convergence proves (8). A union of intervals of common positive length two containing \([-1,1]\) has length two only if all its intervals coincide. This proves the last claim.

There is also a subsequential description when some ratios \(s_{ij}/C\) diverge, where \(s_{ij}=\sqrt{1-\rho_{ij}^2}\). Pass to a subsequence on which each of these ratios has a limit in \([0,\infty]\). After sign alignment, \(s_{ij}\) is asymptotically equivalent to \(\|Z_i-Z_j\|_2\). By the triangle inequality, pairs with a finite limiting ratio form equivalence classes of coordinates. Within each class, apply the interval formula using a member as representative. The covariance in that formula converges: if \(b\) is the representative and the limiting ratios are \(\ell_{ij}\), the limiting covariance between residuals \(i,j\) is \((\ell_{ib}^2+\ell_{jb}^2-\ell_{ij}^2)/2\). This follows by polarization for the scaled differences from \(Z_b\), whose difference from the scaled conditional residual tends to zero in \(L^2\). A singleton contributes one. For different classes, the two-strip overlap is \(O(C^2/s_{ij})=o(h)\) by the bivariate Gaussian density bound. Class contributions therefore add. In particular, three diverging ratios give the coefficient three. If just one pair has a finite limiting ratio \(\ell\), the coefficient is \(3-\mathbb E[(1-\ell|V|/2)_+]\).

## 5. One cutoff for every covariance

Here are explicit choices. Set
\[
d_*=\min\{1/10,(k_*\kappa^2/96)^{1/3}\},\qquad
r_0=\sqrt{1-d_*^2/4},\qquad r=(1+r_0)/2,\qquad v=\sqrt{1-r^2}.
\]
Then the triple loss in Section 3 is at most half its gain for \(0<d\le d_*\), using \(e^{-x}\le2/x^2\) for \(x>0\). Choose strictly positive parameters
\[
\begin{aligned}
s_* &= \min\{d_*/2,\ (r-r_0)/2,\ k(v)/(8K(v)),\ (k(v)\kappa^2/32)^{1/3}\},\\
C_* &= \min\{1/10,\ v/1000,\ va/8,\ k(v)/(8K(v))\}.
\end{aligned}
\]
For \(0<s\le s_*\), the ratio bound for (5) is at most \(8s^3/\kappa^2\le k(v)/4\) by the same exponential inequality. The ratio bound for (6) is at most \(k(v)/8\) when \(C\le C_*\).

Set \(h_*=\min\{1/10,\ 2\Phi(C_*)-1,\ 10^{-60}s_*\}\) and \(q_*=1-h_*\). If every correlation is bounded in absolute value by \(\sqrt{1-s_*^2}\), the archived capped theorem applies for \(h\le h_*\), and gives strictness except at independence. Otherwise relabel to have a pair \(1,2\) with \(s<s_*\), and align its signs so \(\rho_{12}\ge0\). If both cross-correlations have magnitude greater than \(r_0\), then all three pair residual deviations are at most \(d_*\); Section 3 applies. If one cross-correlation has magnitude at most \(r_0\), the other is bounded by \(r\) because
\[
|\rho_{13}-\rho_{23}|
\le \sqrt{\operatorname{Var}(Z_1-Z_2)}
\le \sqrt2\,s \le r-r_0.
\]
Thus the assumptions of Section 2 hold. This covers every covariance with one cutoff.

For a simpler stated cutoff, one can take \(h_*\ge10^{-80}\). Indeed \(\phi>1/4\) on \([0,1/3]\), hence \(k_*>1/6400\) and \(d_*>1/2000\). The definitions give \(v>d_*/4>1/8000\), \((r-r_0)/2\ge d_*^2/32\), \(k(v)>v/(1280000)\), and \(a>(2/5)/1000\). These bounds give
\[
\frac{k(v)}{8K(v)}>\frac{1}{83886080000000000000}>10^{-20}.
\]
The other terms defining \(s_*\) and \(C_*\) exceed \(10^{-20}\) by the same lower bounds. Since \(2\Phi(C_*)-1\ge C_*/2\), each term defining \(h_*\) is at least \(10^{-80}\).

At the identity, Simes has exact level by the independence identity. For a perfect pair independent of the third the collapsed formula reduces to independence of \((X,Y)\), and the two event probabilities sum to \(h[(1-q/3)+(1-2q/3)-h]=h\) for every \(q\). The rank-one equality was proved in Section 3. All other cases are strict by the bounds above. This proves Theorem 1.

## 6. Source and verification scope

Xianyang Zhang, *Exact Simes inequalities for two-sided Gaussian tests*, arXiv:2611.02513v1. Its archived introduction asks for arbitrary Gaussian covariance. Its low-level and trivariate level-near-\(0.05\) results are separate from the high-level endpoint considered here. [Primary source recorded in the archive](https://arxiv.org/abs/2611.02513v1)

The quantitative theorem under a fixed cap, its near-independence analysis, and the explicit recognition of the simultaneous perfect-correlation endpoint gap belong to the fixed predecessor. This paper closes that endpoint gap, classifies equality and resolves the two joint limiting profiles above. Source comparison is limited to the fixed source archive and its documented checks. The proof received independent mathematical review. Lean verification is tracked separately.
