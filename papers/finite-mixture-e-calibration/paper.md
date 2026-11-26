# Sharp finite-mixture calibration in natural exponential families

## Abstract

For a fixed integer \(m\ge2\), we determine the sharp cost of replacing an interval-supported null mixture by at most \(m\) components in a one-parameter natural exponential family. The base statistic can have arbitrary support, provided it has an exponential moment around zero and is either bounded below with no upper bound, or unbounded in both directions. On the first support type, the optimal worst-null calibration excess has order \(s^{4m-3}\) at natural-parameter width \(s\), with a Gauss–Radau limit. On the second it has order \(s^{4m-4}\), with a Gauss–Lobatto limit. We give the constants and identify the local gap of every asymptotically optimal mixture. The proof uses ordinary orthogonal polynomials of the base statistic and the mixing law. In the two-sided case a chi-square term survives at the same order as the local gap. The theorem includes discrete and continuous laws, including families whose variance is not quadratic in the mean.

## Reading guide

The denominator of a likelihood ratio can be chosen as a mixture of null laws. An unrestricted distribution over the null parameter allows exact calibration in this problem. Finite denominators are easier to compute, but some null law may then give expected evidence larger than one. We ask how small this excess can be with a fixed budget of at least two components when the mixing interval is short.

The answer depends on which tails the null family can emphasize. Each unbounded tail requires at least one node at or beyond the corresponding endpoint of the mixing interval for finite calibration. In the sharp limiting rules, the constrained nodes are at the endpoints. One constrained endpoint gives Gauss–Radau quadrature, and two give Gauss–Lobatto quadrature. The proof covers candidates outside the shrinking interval and explains why a different limiting rule cannot achieve the sharp constant. Section 7 gives discrete and continuous examples and the Gamma case.

## 1. Experiment and sharp constants

Let \(Q_0\) be a probability law on the real line with \(E_0e^{c|T|}\lt \infty\) for some \(c>0\). Write
\[
 f_\theta(t)=\frac{dQ_\theta}{dQ_0}(t)=e^{\theta t-K(\theta)},
 \qquad K(\theta)=\log E_0e^{\theta T}.
\]
The legal natural parameter set \(\Theta\) is the interior of the finiteness domain of \(K\). We consider two types of support. In the one-sided case the support has infimum zero and no finite supremum. A finite lower endpoint can be shifted to zero. In the two-sided case there is no finite support endpoint on either side. We assume no density, lattice span, or variance-function condition.

For \(s>0\) small let \(\nu_s\) be a full-support probability law on \([0,1]\), with weak limit \(\nu\) of full support. The alternative statistic has density \(p_s(t)=\int f_{-sv}(t)d\nu_s(v)\) with respect to \(Q_0\). The competitors are all finite probability mixtures \(q=\sum_j w_jf_{\theta_j}\) with positive weights and at most \(m\) distinct nodes anywhere in \(\Theta\). Set
\[
 \mathcal B_q(\theta)=E_\theta[p_s(T)/q(T)],\qquad
 C(q)=\sup_{\theta\in\Theta}\mathcal B_q(\theta),\qquad
 C_m(s)=\inf_{q:\,\#\operatorname{supp}q\le m} C(q).
\]
The support count denotes the number of mixing parameters. In a joint experiment with a common null conditional law given \(T\), the same criterion holds for the joint likelihood ratio when the alternative is absolutely continuous with respect to the base joint law and its marginal of \(T\) is \(p_s\,dQ_0\). Conditional expectation under the common null kernel reduces the ratio to the displayed statistic ratio.

Fix \(m\ge2\) and let \(\pi\) be the monic polynomial of degree \(m-1\) orthogonal for \(\nu\). Put \(J=\int\pi^2d\nu>0\). Define the endpoint moment deficit \(I>0\), and the integers \(L,k\), as follows:
\[
\begin{array}{lll}
\text{one-sided:}& L=2m-1,\quad k=L-1,&
 I=\min_{\phi\ {\rm monic},\,\deg\phi=m-1}\int v\phi(v)^2d\nu(v),\\
\text{two-sided:}& L=2m-2,\quad k=L,&
 I=\min_{\phi\ {\rm monic},\,\deg\phi=m-2}\int v(1-v)\phi(v)^2d\nu(v).
\end{array}
\]
The degree-zero monic polynomial is the constant one. Let \(P_j\) be the monic polynomial of degree \(j\) orthogonal for \(Q_0\), and \(h_j=E_0 P_j(T)^2\). Such polynomials exist and \(h_j>0\) because the support is infinite. In the one-sided case set
\[
 A_*=-\frac{P_L(0)}{P_{L-1}(0)}>0,\qquad
 \kappa=\frac{I A_* h_{L-1}}{L!(L-1)!}.
\]
In the two-sided case set \(\kappa=I h_L/(L!)^2\).

**Theorem 1.** The exact leading minimax calibration excess is
\[
 C_m(s)-1\ \sim\
 \begin{cases}
  \kappa J\,s^{4m-3},&\text{one-sided},\\
  \kappa(I+J)\,s^{4m-4},&\text{two-sided}.
 \end{cases}                                                       \tag{1}
\]
The asymptotic upper bounds are attained by positive \(m\)-node rules in \([-s,0]\). They use the endpoint \(0\) in the one-sided case and both endpoints in the two-sided case. Every asymptotically optimal family eventually has \(m\) distinct positive-weight nodes. In the scaled parameter \(-\theta/s\), its ordered nodes and weights converge to the corresponding endpoint quadrature for \(\nu\), Gauss–Radau on the one-sided support and Gauss–Lobatto on the two-sided support. Its gap \(G_s(\theta)=C(q_s)-\mathcal B_{q_s}(\theta)\) satisfies
\[
 \frac{G_s(sy)}{s^{L+k}}\ \longrightarrow\ \kappa\pi(-y)^2          \tag{2}
\]
locally uniformly for \(y\in\mathbb R\). In the two-sided case the chi-square discrepancy divided by \(s^{2L}\) tends to \(\kappa I\) along every such family. In the one-sided case it is \(O(s^{2L})\).

Finite calibration requires a candidate node \(\theta\ge0\) and, in the two-sided case, a candidate node \(\theta\le-s\). These conditions suffice. On \(t\ge0\), retaining one node at or above zero bounds \(p_s/q\) uniformly. On \(t\le0\) use the node at or below \(-s\). If no node is at or above zero, the full support of \(\nu_s\) gives \(p_s(t)/q(t)\ge c_1e^{c_2t}\) for \(t\ge0\), by restricting the target integral to a compact natural interval strictly above the candidate nodes. If the upper natural boundary \(b\) is finite, choose legal \(\theta>b-c_2\). The \(Q_\theta\) expectation of \(e^{c_2T}\mathbf 1_{\{T\ge0\}}\) is infinite, since \(\theta+c_2>b\). If \(b=\infty\), \(Q_\theta(T\ge M)\to1\) as \(\theta\to\infty\) for every fixed \(M\), by tilting against a fixed positive-mass interval above \(M\). The supremum of that exponential expectation is again infinite. The lower condition is necessary in the two-sided case by applying this argument to \(-T\).

For any candidate of finite calibration set \(\delta=C(q)-1\) and \(G(\theta)=C(q)-\mathcal B_q(\theta)\ge0\). The mixture of the \(Q_{-sv}\) under \(\nu_s\) is \(p_s\,dQ_0\), so
\[
 \delta=\chi^2(p_s\,dQ_0\Vert q\,dQ_0)+\int G(-sv)d\nu_s(v),
 \qquad
 \int|p_s-q|dQ_0\le\sqrt{\delta}.                                   \tag{3}
\]
The first identity averages the null expectation under this mixing law and uses \(\int p_s^2/q\,dQ_0=1+\chi^2\). The second follows by Cauchy–Schwarz. The exact matching mixture has \(C=1\).

## 2. Two facts about orthogonal polynomials

For a positive measure \(\mu\) with sufficiently many support points and finite exponential moments near zero, let \(R_j\) be its monic orthogonal polynomial of degree \(j\). Its zeros are simple and in the interior of the convex hull of the support. If there were fewer than \(j\) interior sign changes, multiplying \(R_j\) by the product of the corresponding linear factors would give a constant-sign function of nonzero integral, in conflict with orthogonality. For each real \(\theta\ne0\) for which the integral exists, the sign of
\[
 \int R_j(t)e^{\theta t}d\mu(t)
\]
is the sign of \(\theta^j\). Indeed interpolate \(e^{\theta t}\) at the \(j\) roots of \(R_j\). The degree-\((j-1)\) interpolant contributes zero by orthogonality, and the remainder at every nonroot is \(\theta^j e^{\theta\zeta}R_j(t)/j!\) by the interpolation error formula. Multiplying by \(R_j\) proves strictness after integration. The same proof applies at a finite natural boundary whenever the degree-\(j\) absolute moment under the unnormalized tilt is finite.

In the one-sided case the roots of \(P_L,P_{L-1}\) are positive. Since \(L\) is odd, \(P_L(0)\lt 0\lt P_{L-1}(0)\). Thus \(A_*>0\), and
\[
 P_L(t)+A_*P_{L-1}(t)=t R(t),                                      \tag{4}
\]
where \(R\) is the monic polynomial of degree \(L-1\) orthogonal for \(t\,dQ_0(t)\). The root at zero gives the factorization, and orthogonality against degrees at most \(L-2\) identifies \(R\). By the preceding sign rule the tilt expectation of (4) is positive for every \(\theta\ne0\) in the legal domain. Also \(E_\theta P_{L-1}>0\) there. These expectations are mean-zero at \(\theta=0\). For \(\theta\to-\infty\), any polynomial expectation tends to its value at zero. Indeed the numerator on \(T\ge\epsilon\) of the tilted expectation of a polynomial's absolute value is at most a constant times \(e^{\theta\epsilon}\), while the denominator is at least \(Q_0([0,\epsilon/2]) e^{\theta\epsilon/2}>0\).

We also need bounded probes that detect moments of arbitrary legal nodes. Choose a compact interval \(J_0\) whose restriction of \(Q_0\) has at least \(L+1\) distinct support points. Let \(R_j^c\) be the monic orthogonal polynomials for the probability measure proportional to that restriction, with norms \(h_j^c=\int (R_j^c)^2dQ_0(\cdot\mid J_0)>0\). Write \(\omega(\theta)=Q_\theta(J_0)>0\) and
\[
 g_j(\theta)=(-1)^j\frac{j!}{h_j^c}
              E_\theta[R_j^c(T)\mid T\in J_0],\qquad 0\le j\le L.
\]
The quantities \(\omega g_j\) are expectations of bounded functions supported on \(J_0\). Also \(g_0=1\). Expansion at zero gives \(g_j(\theta)=(-\theta)^j(1+O(|\theta|))\) for \(j\ge1\), by orthogonality and monicity. The preceding sign rule gives a nonzero value with the sign of \((-\theta)^j\) at every \(\theta\ne0\). As \(\theta\to\pm\infty\), the tilted restricted law concentrates at the corresponding endpoint of its compact support. Each endpoint value of \(R_j^c\) is nonzero because all roots are interior. The same positive-mass interval argument as above gives this concentration. Hence for constants \(0\lt c_j\lt C_j\lt \infty\) and \(j\ge1\),
\[
 c_j\min(|\theta|^j,1)\ \le\ |g_j(\theta)|\ \le\
 C_j\min(|\theta|^j,1).                                             \tag{5}
\]
Here \(g_j\) is defined by the normalized compact integral for all real \(\theta\), and (5) in particular holds on the entire legal domain. These probes require no assumptions on densities, translations, or consecutive lattice sites.

## 3. The endpoint quadrature and its local coordinates

Use \(E(v)=v\) in the one-sided case and \(E(v)=v(v-1)\) in the two-sided case. Let \(\phi_\lambda\) be the monic polynomial of the stated degree orthogonal for \(|E|\,d\lambda\), for a full-support law \(\lambda\) on \([0,1]\). Write \(I_\lambda=\int|E|\phi_\lambda^2d\lambda\). The positive interpolatory quadrature \(R_\lambda\) uses the roots of \(\phi_\lambda\), node zero, and also node one in the two-sided case. Dividing a polynomial of degree at most \(L-1\) by \(E\phi_\lambda\) leaves a remainder of degree at most \(m-1\) and a multiple of integral zero by orthogonality. Thus the rule is exact through degree \(L-1\), and the degree-\(L\) discrepancy is
\[
 \lambda(v^L)-R_\lambda(v^L)=\sigma I_\lambda,\qquad
 \sigma=1\text{ on the one-sided support},\quad
 \sigma=-1\text{ on the two-sided support}.                          \tag{6}
\]
For this identity subtract the monic polynomial \(E\phi_\lambda^2\) of degree \(L\), which vanishes on all the nodes.

For the left endpoint weight integrate \((\phi_\lambda/\phi_\lambda(0))^2\) in the one-sided case. In the two-sided case integrate \((1-v)(\phi_\lambda/\phi_\lambda(0))^2\) and \(v(\phi_\lambda/\phi_\lambda(1))^2\) for the respective endpoint weights. For an interior node \(u\) integrate
\[
 \frac{|E(v)|}{|E(u)|}
       \left(\frac{\phi_\lambda(v)}{(v-u)\phi_\lambda'(u)}\right)^2 .
\]
Each nonnegative polynomial is within the exact degree, equals one at its chosen node, and is zero at the others. The weights are positive and each endpoint weight is strictly larger than the corresponding atom of \(\lambda\), by interval support. Hermite interpolation with values at all nodes and derivatives at interior nodes gives
\[
 F(v)-H(v)=F^{(L)}(\zeta_v)E(v)\phi_\lambda(v)^2/L!
\]
off the nodes for any \(F\in C^L[0,1]\). The interpolant \(H\) has degree at most \(L-1\), so \(R_\lambda(F)-\lambda(F)=\lambda(H-F)\). This gives a signed bound whenever \(F^{(L)}\) has a fixed sign, with magnitude at least \(bI_\lambda/L!\) when its absolute value is bounded below by \(b\). These quadrature facts are classical [1].

The first \(L-1\) moments are smooth local coordinates near \(R_\nu\) on positive rules with fixed endpoints. The \(m-1\) free weights and the interior locations give \(L-1\) parameters. A dependence among rows of the moment Jacobian yields a polynomial \(P(v)\) of degree at most \(L-1\) with no constant term. Weight variations force zeros at all nodes and position variations force double zeros at each interior node. The resulting multiplicity is \(L\), so the polynomial is zero. The inverse function theorem yields the local coordinate map. By positive definiteness of the weighted moment matrix at the limit, \(\phi_\lambda\), its simple roots, and the corresponding interpolatory weights are continuous as \(\lambda\Rightarrow\nu\). Thus \(R_\lambda\) is given by this same local map at its moment vector.

For bounded \(d=(d_1,\ldots,d_{L-1})\) let \(W(s,d;\lambda)\) have moments
\[
 W(s,d;\lambda)(v^j)-\lambda(v^j)=s^{L-j}d_j,\qquad 1\le j\lt L.       \tag{7}
\]
Use the local map with \(\lambda\) near \(\nu\). The nodes and weights of \(W\) move by \(O(s)\) from \(R_\lambda\), locally uniformly, and their first derivatives in \(d\) are \(O(s)\) by (7).

## 4. Construction and global calibration

Let \(V_j(t)\) be the coefficient of \(u^j\) in \(f_{-u}(t)\). It has degree \(j\) with leading coefficient \((-1)^j/j!\) and \(E_0 V_j=0\) for \(j\ge1\). Define \(B(s,\theta,d;\lambda)\) as \(s^{-L}\) times the null expectation of the ratio of the \(\lambda\)- and \(W(s,d;\lambda)\)-mixture densities minus one. Its expansion is
\[
 B(s,\theta,d;\lambda)
 =E_\theta\left[\sigma I_\lambda V_L(T)
                  -\sum_{j=1}^{L-1}d_j V_j(T)\right]+O(s).          \tag{8}
\]
Here the error is uniform on compact natural-parameter intervals, including up to \(L\) natural derivatives there and one control derivative. On a one-sided support the function estimate also holds uniformly for all \(\theta\le0\). Indeed, Taylor expansion of \(e^{-svt-K(-sv)}\) through order \(L\) has error bounded by \(C s^{L+1}(1+|t|)^M e^{Cs|t|}\), also after one \(v\)-derivative. Equations (6)–(7) give the normalized ratio minus one as the polynomial inside (8) plus an error bounded by \(Cs(1+|t|)^M e^{Cs|t|}\), for possibly a larger fixed \(M\). The denominator has the positive weight of the fixed node zero, and its difference from one is bounded by \(Cs(1+|t|)^M e^{Cs|t|}\). The moment coordinates and their derivative bounds give the same error after one control derivative. Interior tilts have a locally uniform exponential moment and each natural derivative adds bounded-coefficient polynomial factors in \(t\). On the one-sided support the expectation of the error envelope is at most its expectation at zero for \(\theta\le0\), by monotonicity of increasing functions under exponential tilting.

Put \(\Pi(y)=\pi(-y)^2=\sum_{j=0}^k c_j y^j\). It is monic of even degree \(k\), and has roots in \((-1,0)\). Use the spanning property of \(V_1,\ldots,V_{L-1}\) for the zero-mean polynomials of degree at most \(L-1\) to choose a central control \(d^*\) as follows. On the one-sided support select it so the polynomial inside the expectation in (8) is
\[
 -\frac{I_\lambda}{L!}
       \bigl[P_L+(A_*+\sqrt{s})P_{L-1}\bigr].
\]
On the two-sided support select it so the polynomial is \(-I_\lambda P_L/L!\). Both have the needed leading coefficient \(\sigma I_\lambda(-1)^L/L!=-I_\lambda/L!\) and are mean zero. Define \(\kappa_\lambda\) by the formula for \(\kappa\) with \(I_\lambda\) in place of \(I\), and with \(A_*+\sqrt{s}\) in place of \(A_*\) in the one-sided case. Fix the last control in the one-sided case to \(d^*_{L-1}\). Use all the other controls in both cases to prescribe
\[
 \partial_\theta^j B(s,0,d;\lambda)
            =-\kappa_\lambda j!c_j s^{k-j},\qquad 1\le j\lt k.       \tag{9}
\]
The fixed derivative map \(R\mapsto (\partial_\theta^jE_\theta R|_{\theta=0})_{1\le j\lt k}\) on zero-mean polynomials of degree at most \(k-1\) is invertible. A kernel vector would be orthogonal to every polynomial of degree at most \(k-1\) because derivatives of \(f_\theta\) at zero are monic polynomials of the corresponding degrees. The freely varying \(V_j\) span that space. The central controls have residual \(O(s)\) in (9), since the relevant derivatives of the displayed central polynomials vanish by orthogonality. Equation (8) gives the fixed invertible derivative matrix plus \(O(s)\). Subtracting the residual times its fixed inverse gives a contraction with Lipschitz constant \(O(s)\) on a sufficiently large \(O(s)\)-radius ball about \(d^*\). This supplies a control \(d=d^*+O(s)\) for each sufficiently small \(s\), uniformly with \(\lambda=\nu_s\), without differentiating \(\nu_s\).

Write \(B_s(\theta)=B(s,\theta,d;\nu_s)\) for this rule, \(q_s\) for its mixture and \(b_s(t)=s^{-L}(p_s(t)/q_s(t)-1)\). By (8) and (4), \(B_s\lt 0\) on each fixed compact natural interval away from zero, for sufficiently small \(s\). In the one-sided case this extends to all \(\theta\le-\eta\) at any fixed \(\eta>0\): the expectation of \(P_L+A_*P_{L-1}\) is nonnegative, and \(E_\theta P_{L-1}\) has a positive lower bound there, by the sign rule and its limit \(P_{L-1}(0)>0\) as \(\theta\to-\infty\). The \(\sqrt{s}\) term then dominates the \(O(s)\) error. The derivative \(\partial_\theta^k B_s\) is strictly negative in a fixed neighborhood of zero, by (8) and the derivative identities at zero. Its value at zero tends to \(-\kappa k!\), using \(E_0[P_j(T) T^j]=h_j\). Taylor's theorem through degree \(k-1\) and (9) give
\[
 B_s(t)-B_s(0)\le \sum_{j=1}^{k-1} C_j s^{k-j}|t|^j-c|t|^k
\]
on that neighborhood, since \(k\) is even. It follows that the supremum in the neighborhood occurs within distance \(M s\) of zero, for a fixed \(M>1\), and
\[
 s^{-k}[B_s(sy)-B_s(0)]\longrightarrow-\kappa[\Pi(y)-\Pi(0)]       \tag{10}
\]
locally uniformly.

It remains to exclude the tails of the natural parameter. First, the constructed mixture dominates the target pointwise on all sufficiently large positive \(t\), and also on sufficiently negative \(t\) in the two-sided case. For \(s|t|\le1\) and \(|t|\) large on these tails, the \(L\)-th \(v\)-derivative of \(F(v)=e^{-svt-K(-sv)}\) has magnitude at least \(c s^L |t|^L\) and sign opposite to \(E(v)\) on the interior. Its leading term is \((-st)^L F(v)\), and the others are bounded by \(C s^L(1+|t|^{L-1})F(v)\). Hermite interpolation gives \(R_{\nu_s}(F)-\nu_s(F)\ge c' s^L |t|^L\). Changing \(R_{\nu_s}\) to \(W(s,d;\nu_s)\) changes the evaluation of the Taylor polynomial of \(F\) through degree \(L-1\) by at most \(Cs^L(1+|t|^{L-1})\), by (7). Its remainder and first derivative are bounded by \(Cs^L(1+|t|)^L\), and the \(O(s)\) movement in nodes and weights contributes at most \(Cs^{L+1}(1+|t|)^L\) on that remainder. The quadrature advantage dominates for large \(|t|\) and small \(s\).

For \(st\ge1\), set \(z=st\). On compact \(z\)-intervals in \([1,\infty)\) the difference of the two integrals tends uniformly to \(R_\nu(e^{-zv})-\nu(e^{-zv})>0\) by the signed interpolation error. Uniformity uses equicontinuity of the integrands in \(z\) there and weak convergence. For large \(z\) use \(w_0(R_\nu)>\nu(\{0\})\). Choose \(h>0\) so \(\nu([0,h])\) lies strictly below \(w_0(R_\nu)\). The target integral is at most \((1+O(s))(\nu_s([0,h])+e^{-zh})\), while the atom of \(W\) at zero tends to \(w_0(R_\nu)\). The weak upper bound on the mass of the closed interval proves domination uniformly for large \(z\). For \(st\le-1\) in the two-sided case divide both integrals by \(e^{s|t|}\), use \(e^{-s|t|(1-v)}\), and apply the same argument at endpoint one.

The functions \(b_s\) therefore are nonpositive on the indicated statistic tails, beyond a fixed threshold. They tend uniformly on bounded intervals to the corresponding central polynomial with \(I_\lambda=I\) and the buffer removed. Denote the limit by \(H\); it has negative leading coefficient. At a finite upper natural boundary \(b>0\), the tilted integral of \(H\) is strictly negative when finite, by the sign rule of Section 2 and (4). If the right tail integral diverges, it diverges to \(-\infty\) because \(H\) is eventually negative with degree \(L\); the compact region and the opposite tail are integrable. Consequently on a sufficiently large bounded interval the integral of \(H(t)e^{bt}\) is strictly negative. Continuity and compact convergence give the same sign for \(b_s\) at all \(\theta\) in a fixed left neighborhood of \(b\), and the omitted tails are nonpositive. At an infinite upper natural boundary, choose a positive-mass bounded interval strictly beyond the possible positive region of \(b_s\), on which \(H\le-1\). For a large fixed \(\theta_1\), its negative tilted contribution exceeds the whole possible positive contribution, by the strict separation in \(t\). The comparison then holds for \(b_s\) by compact convergence, and for every \(\theta\ge\theta_1\) by further increasing the tilt. On a two-sided support the same argument applied to \(-T\) controls the lower natural boundary. This excludes every null outside the neighborhood used in (10).

By the envelope of (8), \(\chi^2(p_s\,dQ_0\Vert q_s\,dQ_0)=s^{2L}E_0[q_s b_s^2]=O(s^{2L})\). In the two-sided case dominated convergence gives \(E_0[q_sb_s^2]\to I^2 h_L/(L!)^2=\kappa I\), since \(q_s\to1\) and \(b_s\to-I P_L/L!\). In the one-sided case \(\chi^2/s^{L+k}\to0\). Denote the limit of \(\chi^2/s^{L+k}\) by \(\chi_*\). Averaging \(B_s(-sv)\) under \(\nu_s\) gives \(\chi^2/s^L\) by (3). Together with (10) this gives
\[
 s^{-k} B_s(sy)\longrightarrow\chi_*+\kappa[J-\Pi(y)]
\]
locally uniformly. The maximum of the right side on \([-M,M]\) is \(\chi_*+\kappa J>0\). The bounds away from this interval show that the same limit holds for the normalized supremum over all legal \(\theta\). This proves the upper bounds of Theorem 1.

## 5. Unrestricted mixtures and escaping nodes

Let \(W\) be any candidate parameter law with \(\delta=O(s^{L+k})\) along a sequence. This condition holds for suitable approximations to the infimum. Pass to a subsequence with a fixed number of distinct positive-weight nodes. From (3) and the bounded tests of Section 2, for every \(0\le j\le L\),
\[
 \int \omega(\theta)g_j(\theta)dW(\theta)
   -\int \omega(-sv)g_j(-sv)d\nu_s(v)=O(\sqrt{\delta}).            \tag{11}
\]
At a scaled node \(u=-\theta/s\) with bounded \(u\), \(g_j(\theta)/s^j=u^j+o(1)\) and \(\omega(\theta)\to\omega(0)\). At an escaping node \(|\theta|/s\to\infty\), the contribution to degree \(j\) after normalization is negligible whenever the normalized nonnegative probe at even degree \(e>j\) is bounded. Indeed (5) bounds the contribution by a constant times the even probe contribution times \([s/\min(|\theta|,1)]^{e-j}\). For \(j=0\) use \(g_0=1\). The target moments under normalized probes converge to \(\omega(0)\int v^j d\nu(v)\). Pass to subsequences so that each \(u\) has an extended real limit and its weighted mass \(w\omega(\theta)\) has a limit.

On the one-sided support, \(e=L-1\) is even and \(O(\sqrt\delta)=O(s^{L-1/2})\). Equation (11) gives a bounded normalized degree-\(e\) test and exact limiting lower moments through \(L-2\) for the finite-node part. Its moment matrix of indices \(0,\ldots,m-2\) is positive definite, so at least \(m-1\) distinct finite nodes of positive limiting mass are needed. Thus at most one node can escape. If none escape, the degree-\((L-1)\) moment also matches, and its larger positive definite moment matrix forces exactly \(m\) distinct nodes with positive limiting weights. The limiting probability law \(W^0\) of the scaled nodes matches \(\nu\) through degree \(L-1\). Its least node \(v_0\) is at most zero. With the other \(m-1\) nodes the roots of a monic polynomial \(R\), the missing degree-\(L\) moment is
\[
 I(W^0)=\nu(v^L)-W^0(v^L)=\int(v-v_0)R(v)^2d\nu(v)\ge I.          \tag{12}
\]
Subtract the monic polynomial that vanishes at all candidate nodes for the identity, and use \(v_0\le0\) and the weighted orthogonal minimum for the inequality. Equality requires \(v_0=0\) and \(R=\phi_\nu\).

If one node escapes, the \(m-1\) other nodes integrate through degree \(L-2=2m-3\) in the limit. Their monic root polynomial is orthogonal to all polynomials of degree at most \(m-2\), so this is the ordinary Gaussian quadrature for \(\nu\). Its nodes are all interior. The escaping node must provide the endpoint condition, so \(\theta_e\ge0\). The degree-\((L-1)\) moment deficit of the finite nodes is the strictly positive squared norm of their monic root polynomial. Equations (11) and (5) now give
\[
 w_e\omega(\theta_e)g_{L-1}(\theta_e)\asymp s^{L-1},
 \qquad
 w_e\omega(\theta_e)|g_L(\theta_e)|=O(s^{L-1/2}),
\]
where the other contribution at degree \(L\) is \(O(s^L)\). Dividing and using (5) forces \(\theta_e=O(\sqrt{s})\). Set \(r_s=\theta_e\), which has \(r_s/s\to\infty\) and \(w_e r_s^{L-1}\asymp s^{L-1}\).

On the two-sided support, the even degree \(e=L\) is bounded after normalization since \(O(\sqrt{\delta})=O(s^L)\). The finite part matches all moments through \(L-1=2m-3\) and requires at least \(m-1\) distinct positive finite nodes by the same moment matrix. If it had exactly \(m-1\), they would be the interior ordinary Gaussian quadrature just described. Both endpoint inequalities would then require two additional distinct positions among the candidates, even if their limiting masses vanished. This exceeds \(m\). Thus all \(m\) nodes have finite distinct limits and positive weights. Their probability law \(W^0\) matches \(\nu\) through \(L-1\), and its extrema satisfy \(v_0\le0\) and \(v_+\ge1\). Let \(R\) have as roots the other \(m-2\) nodes. Then
\[
 I(W^0)=W^0(v^L)-\nu(v^L)=\int(v-v_0)(v_+-v)R(v)^2d\nu(v)
       \ge I,                                                     \tag{13}
\]
with equality only at \(v_0=0,v_+=1,R=\phi_\nu\). This uses the same vanishing-polynomial argument and the weighted orthogonality minimum.

Write \(M_j^*=s^j\nu_s(v^j)\), \(M_j=W((-\theta)^j)\), and \(\Delta_j=M_j^*-M_j\). Set \(a_s=s^L\) if no node escapes and \(a_s=s^{L-1}r_s\) in the remaining one-sided escape case. Then \(\Delta_j=o(s^j)\) and the absolute moment of order \(j\) is \(O(s^j)\) for \(1\le j\lt L\). Indeed all candidate parameters now approach zero, \(g_j(\theta)=(-\theta)^j(1+o(1))\) and \(\omega(\theta)=\omega(0)+o(1)\) there. In the escape case the order-\((L-1)\) estimate controls each lower absolute moment because \(r_s\gg s\). At degree \(L\) the absolute moments are \(O(a_s)\). With no escape, \(\sigma\Delta_L/s^L\to I(W^0)\); with escape, \(\Delta_L\asymp a_s>0\) because the odd signed moment of the negative scaled node dominates the localized terms. At degree \(L+1\) the absolute moments are \(o(a_s)\) because all parameter shifts tend to zero.

Let \(h_s\) bound these absolute parameter shifts, so \(h_s\to0\). Taylor expansion gives \(p_s,q\) as their moment polynomials \(\sum_{j=0}^L M_j^*V_j,\sum_{j=0}^L M_j V_j\), up to \(o(a_s)(1+|t|)^M e^{Ch_s|t|}\). The denominator is bounded below by \(e^{-Ch_s-h_s|t|}\), and \(q-1=O(s)(1+|t|)^M e^{Ch_s|t|}\) by the first absolute moment. In \((p_s-q)/q\), expand \(1/q=\sum_{j=0}^L(-z)^j+(-z)^{L+1}/q\), \(z=q-1\). Keep products of moment indices of total at most \(L\). Each discarded product is \(O(s^{L+1})\) if its indices are below \(L\), and \(O(sa_s)\) otherwise, with the same type of envelope. The geometric remainder is \(O(s^{L+2})\) with this envelope. We obtain a polynomial \(H_s(t)\) of degree at most \(L\) with
\[
 \frac{p_s(t)}{q(t)}-1
   =H_s(t)+o(a_s)(1+|t|)^{M'}e^{C'h_s|t|},\qquad
 [t^L]H_s=(-1)^L\Delta_L/L!+o(a_s).                                \tag{14}
\]
The error denotes a uniform absolute bound. Products at total index \(L\) besides the single degree-\(L\) term contain a discrepancy \(\Delta_j=o(s^j)\) of lower degree, which proves the asserted leading coefficient. The envelope remains integrable after any fixed number of natural derivatives on every compact interior interval.

For a general base law \(E_\theta H_s\) is not a polynomial in \(\theta\). The following bound supplies the needed control. Define \(b_s=\max(a_s,\|H_s\|_{\rm coeff})\) in any fixed coefficient norm. Equation (14) and \(\delta=O(s^{L+k})\le O(a_s)\) bound \(G^{(L)}\) by \(O(b_s)\) near zero. Taylor expansion through order \(L-1\) on \([-s,0]\) therefore has an error \(O(b_s s^L)\). The mean absolute value of its Taylor polynomial under the law of \(-V_s\) in the coordinate \(y=\theta/s\) is \(O(\delta+b_s s^L)\), by (3) and \(G\ge0\). This integral norm uniformly controls all coefficients. Otherwise a unit coefficient-norm subsequence would converge to a nonzero polynomial vanishing almost everywhere under the reflected full-support limit. Hence
\[
 |G^{(j)}(0)|\le C s^{-j}(\delta+b_s s^L),\qquad 0\le j\lt L.
\]
A polynomial of degree at most \(L\) is determined by its leading coefficient and the derivatives of its tilt expectation at zero of orders zero through \(L-1\). This is an invertible linear map, since a kernel vector is a polynomial of degree at most \(L-1\) orthogonal to all those degrees. By (14), the leading coefficient is \(O(a_s)\), and the expectation derivatives differ from those of \(\delta-G\) by \(o(a_s)\). This bounds
\[
 b_s\le C\bigl(a_s+\delta/s^{L-1}+s b_s\bigr).
\]
Here \(\delta/s^{L-1}=O(s^L)\) on both supports. Absorbing \(s b_s\) proves
\[
 b_s=O(a_s),\qquad
 |G^{(j)}(0)|=O\bigl(s^{-j}(\delta+a_s s^L)\bigr),\qquad 0\le j\lt L.  \tag{15}
\]

If the one-sided node escaped then \(a_s/s^L\to\infty\), so all the derivatives in (15) are \(o(a_s)\). Pass to a subsequence on which \(H_s/a_s\) converges. Its leading coefficient is strictly negative by (14), and its expectation derivatives of orders zero through \(L-1\) vanish in the limit. Thus the limit is \(-cP_L\) for a positive \(c\). At any fixed negative legal \(\theta\), equation (14) would give \(G(\theta)/a_s\to cE_\theta P_L\lt 0\) by the odd-degree sign rule. This contradicts \(G\ge0\) and excludes escape.

## 6. Lower coefficients, uniqueness and growth

It remains to treat the subsequences with bounded scaled nodes, so \(a_s=s^L\). Write \(I_0=I(W^0)\ge I\). In either case \(H_s/s^L\) has bounded coefficients and limiting leading coefficient \(-I_0/L!\). Take a converging subsequence. On the two-sided support the derivatives of \(G\) through order \(L-1\) are \(o(s^L)\) by (15). Thus \(H_s/s^L\to -I_0P_L/L!\) by (14) and orthogonality. The quotient envelope in (14) gives by dominated convergence
\[
 s^{-2L}\chi^2(p_s\,dQ_0\Vert q\,dQ_0)
       \longrightarrow I_0^2 h_L/(L!)^2.                          \tag{16}
\]
The same reasoning yields an \(O(s^{2L})\) upper bound for this discrepancy on the one-sided support, where \(H_s/s^L\) still has bounded coefficients. In both cases \(q\to1\) pointwise and all factors are dominated by polynomial-exponential integrable envelopes at \(Q_0\).

On the one-sided support the derivatives through order \(L-2\) are \(o(s^L)\). Therefore the limit polynomial is \(-I_0 P_L/L!-c P_{L-1}\) for a real \(c\). At each fixed \(\theta\lt 0\), the nonnegative gap and (14) give
\[
 0\le\lim G(\theta)/s^L
        =(I_0/L!)E_\theta P_L+cE_\theta P_{L-1}.
\]
Let \(\theta\to-\infty\). The polynomial-expectation limit at the lower statistic endpoint gives \(c\ge I_0 A_*/L!\).

Taylor expansion on the local scale and (15) give subsequential locally uniform limits \(P(y)=\lim s^{-(L+k)}G(sy)\) that are nonnegative on all of \(\mathbb R\). On the one-sided support the coefficient of \(y^k\), \(k=L-1\), is \(c h_{L-1}/(L-1)!\). The contribution of \(P_L\) to the derivative of order \(L-1\) vanishes by orthogonality. The Taylor error of order \(L\) is \(O(s^{2L})=o(s^{L+k})\). Hence the leading coefficient \(g_k\) is at least \((I_0/I)\kappa\). On the two-sided support use (14) and the convergence to \(-I_0P_L/L!\) to see that \(s^{-L}G^{(L)}(\theta)\) tends uniformly near zero to the corresponding expectation derivative. Taylor with this derivative shows that the coefficient of \(y^k\), now \(k=L\), is \(g_k=I_0 h_L/(L!)^2=(I_0/I)\kappa\). Explicitly, in the scaled Taylor integral the arguments are \(O(s)\), so the limiting derivative is its value at zero. The other coefficients through degree \(L-1\) are bounded under the scaling by (15).

Every nonnegative real polynomial of degree \(k=2(m-1)\) with leading coefficient \(g_k>0\) is \(g_k(F^2+H^2)\), with \(F\) real monic of degree \(m-1\) and \(H\) of smaller degree. Split each even real-root multiplicity in half and select one root of each conjugate pair to form a monic complex polynomial, then take its real and imaginary parts. Because \((-1)^{m-1} F(-v)\) is monic, orthogonality gives
\[
 \int P(-v)d\nu(v)\ge g_k J,
\]
with equality only when \(P(y)=g_k\pi(-y)^2\). By (3) and local uniform convergence, any limiting value of \(\delta/s^{L+k}\) is at least this integral plus the scaled chi-square limit. The one-sided bound is therefore at least \((I_0/I)\kappa J\ge \kappa J\). The two-sided bound is at least \(I_0^2 h_L/(L!)^2+(I_0/I)\kappa J\ge \kappa(I+J)\).

For the infimum take a sequence approaching the liminf and choose mixtures within \(s^{L+k+1}\) of the infimum. They satisfy the initial bound on \(\delta\) by Section 4. This proves (1). For an asymptotically optimal sequence all the lower inequalities are equalities. Then (12) or (13) fixes the limiting nodes and their positive weights are determined by the first \(m-1\) moments. The leading coefficient is \(\kappa\) and equality in the polynomial bound fixes \(P(y)=\kappa\pi(-y)^2\). The subsequence argument applies to every sequence, so these are full-family convergences, including eventual \(m\) distinct positive-weight nodes and (2).

For the joint experiment described in Section 1, let \(q_*\) be the exact matching mixture and \(p\) the alternative joint density. Its likelihood ratio \(e_*=p/q_*\) has null expectation one for every parameter. It is growth-optimal because for any e-variable \(e\), \(E_P(e/e_*)\le1\) follows by averaging its validity under the matching mixture, and Jensen gives \(E_P\log(e/e_*)\le0\). When \(E_P\log e_*\) is finite, the finite mixture calibrated by \(C(q)\) has expected log-growth loss
\[
 \log C(q)-D_{\rm KL}(p_s\,dQ_0\Vert q\,dQ_0)
\]
relative to \(e_*\), by the common null conditional kernel. Along any asymptotically calibration-optimal family this loss has coefficient \(\kappa J\) at order \(s^{4m-3}\) on the one-sided support, and \(\kappa(J+I/2)\) at order \(s^{4m-4}\) on the two-sided support. For the former use \(D_{\rm KL}\le\chi^2=O(s^{2L})\). For the latter write \(p_s/q=1+e_s\), subtract the integral of \(q e_s\), which is zero, and use
\(0\le (1+e)\log(1+e)-e\le e^2\) for \(e>-1\), with ratio to \(e^2\) tending to \(1/2\) as \(e\to0\). The domination in (16) gives the KL coefficient \(\kappa I/2\). This evaluates calibration-optimal denominators.

## 7. Examples and the earlier Gamma comparison

### Five familiar families

Write \(x(\theta)=K'(\theta)\), \(x_0=x(0)\), and \(\beta=K''(0)\). For a quadratic variance function \(\mathcal V(x)=a_2x^2+a_1x+a_0\) with \(a_2\ge0\), let \(\gamma_j=\prod_{i=0}^{j-1}(1+i a_2)\). The recurrence \(E_{\theta(x)} T^{j+1}=xE_{\theta(x)}T^j+\mathcal V(x)\partial_x E_{\theta(x)}T^j\) makes the \(j\)th moment a polynomial of degree \(j\) in \(x\), with leading coefficient \(\gamma_j\). Orthogonality at \(\theta=0\) consequently gives \(E_{\theta(x)}P_j=\gamma_j(x-x_0)^j\), since its first \(j-1\) derivatives vanish and \(x'(0)=\beta>0\). Comparing the order-\(j\) derivative also gives \(h_j=\gamma_j j!\beta^j\). On the one-sided support, \(A_*=x_0\gamma_L/\gamma_{L-1}\) by the lower endpoint limit. Thus \(\kappa=I\gamma_L x_0\beta^{L-1}/L!\) on the one-sided support and \(I\gamma_L\beta^L/L!\) on the two-sided support.

These formulas apply to Gamma, negative binomial, and Poisson on the one-sided support, and generalized hyperbolic secant and Gaussian location on the two-sided support. Their variance functions are, respectively, \(x^2/A\), \(x+x^2/A\), \(x\), \(A+x^2/A\), and a fixed \(\sigma^2\) [2,3]. The generalized hyperbolic secant family has cumulant \(A\log(\cos\eta_0/\cos(\eta_0+\theta))\), where \(-\pi/2\lt \eta_0+\theta\lt \pi/2\). Its base family at \(\eta_0=0\) has positive density \(2^{A-2}|\Gamma((A+it)/2)|^2/(\pi\Gamma(A))\) on the real line, as follows from the Fourier transform of \((\cosh z)^{-A}\) by Euler's beta integral.

In the heterogeneous Gamma, negative-binomial, and generalized-hyperbolic-secant product experiments, let \(\alpha_i>0\) be the known shapes, \(A=\sum_i\alpha_i\), and choose relative natural parameters \(-sd_i\) with \(\min_i d_i=0,\max_i d_i=1\). The total \(T\) is sufficient under the common-parameter null. In the three cases the individual transforms have the form
\[
 [1-u t]^{-\alpha_i},\qquad
 [1-u(e^t-1)]^{-\alpha_i},\qquad
 [\cos t-u\sin t]^{-\alpha_i},
\]
respectively, where \(u(\theta)\) is the Gamma scale, negative-binomial mean per unit shape, or \(\tan(\eta_0+\theta)\). All are smooth and strictly increasing \(u(\theta)\). For \(D\) Dirichlet with shapes \((\alpha_i)_i\), the identity \(E(\sum D_i z_i)^{-A}=\prod z_i^{-\alpha_i}\) for positive \(z_i\) follows by passing from independent Gamma variables to total and proportions. The brackets above are affine in \(u\), so the alternative total is exactly the mixture of null totals with mixing parameter \(u=\sum D_i u(-sd_i)\). Natural inversion and \(u'(0)>0\) give \(V_s=-u^{-1}(\sum_i D_i u(-sd_i))/s=\sum_i D_i d_i+O(s)\) uniformly. Each law and its limit have full support on \([0,1]\). Thus the theorem applies directly to the heterogeneous product likelihood ratios. The corresponding fixed heterogeneous Poisson and Gaussian-location products have a single matching null total. Their nontrivial examples use mixed alternatives, such as a Poisson total with a mixed mean and different conditional count proportions, or a Gaussian total with a mixed mean and a different conditional residual mean vector.

For \(m=2\), two equal shape-one observations at positions zero and one have uniform limiting \(\nu\). Then \(J=1/12\), and \(I=1/36\) on the one-sided support or \(I=1/6\) on the two-sided support. The Gamma model at base rate one gives coefficient \(1/108\) at order \(s^5\). Negative binomial at base failure probability \(1/2\) gives \(1/27\) at the same order. Generalized hyperbolic secant at base tilt zero instead gives coefficient \(1/8\) at order \(s^4\), and the unit-variance Gaussian location with uniform mixing gives \(1/48\) at order \(s^4\).

### Two examples beyond quadratic variance

Take \(Q_0\) to be an equal mixture of exponentials of rates one and two, on the positive half-line. Then \(x(\theta)=-1/(4/3-\theta)+1/(1-\theta)+1/(2-\theta)\). As \(\theta\to-\infty\), \(x(\theta)\to0\) and \(x'(\theta)/x(\theta)^2\to1\), which would force a quadratic variance function to be \(x^2\). At zero \(x_0=3/4\) and \(x'(0)=11/16\), so this is impossible. The cumulant's domain has a finite upper endpoint. For \(m=2\) and uniform mixing, \(E_0T^j=j!(1+2^{-j})/2\). The degree-two and degree-three orthogonal polynomials give \(h_2=28/11\), \(A_*=40293/13888\), and thus \(\kappa J=407/285696\) at order \(s^5\).

On the two-sided support take the equal mixture of \(N(0,1)\) and \(N(0,4)\) as \(Q_0\). Then \(K''(\theta)\to4\) as \(|\theta|\to\infty\) while the mean is unbounded in each direction. A quadratic variance function with these limits would be the constant four, whereas \(K''(0)=5/2\). Here \(P_2(t)=t^2-5/2\) and \(h_2=77/4\). With \(m=2\) and uniform mixing the coefficient \(\kappa(I+J)\) is \(77/384\) at order \(s^4\).

### Gamma scope and the ordinary endpoint rule

For the original Gamma rate setup with base rate one and known shapes, let \(\lambda_i=1+sd_i\), \(A=\sum_i\alpha_i\), and let \(\nu\) be the law of the Dirichlet mean \(\sum_iD_i d_i\). Conditional proportions under the rate-one null are Dirichlet. Thus the alternative total density relative to the rate-one total is \(F(s)\int e^{-svt}d\nu(v)\), where \(F(s)=\prod_i(1+sd_i)^{\alpha_i}\). It follows that the exact mixing law on the scaled Gamma rates is \(d\nu_s=F(s)(1+sv)^{-A}d\nu\). The variance recurrence gives \(x_0=\beta=A\), \(\gamma_L=(A)_L/A^L\), and the sharp constant in (1) is \(D_m J\) with \(D_m=(A)_L I/L!\) and \(L=2m-1\), on the full positive legal Gamma rate domain.

The common conditional proportions law also gives the reverse information projection by the KL chain rule. For any probability law \(W\) on the entire rate domain \((0,\infty)\), the KL divergence from the alternative to the null mixture with mixing law \(W\) is the common conditional divergence plus the divergence between the totals. The matching mixture attains the minimum. Averaging the calibration expectations over that matching mixture gives \(1+\chi^2\) between the total marginals, as in (3), by Tonelli. Hence equality of the total marginals is necessary for either minimum. It is also sufficient, since conditioning gives null expectation one for a matching total.

These totals identify the mixing law among all probability laws on positive rates. For a law \(W\), the Lebesgue density of its Gamma total is \(t^{A-1}/\Gamma(A)\) times
\[
 M_W(t)=\int_0^\infty \lambda^A e^{-t\lambda}\,dW(\lambda),\qquad t>0 .
\]
This transform is finite and continuous on \((0,\infty)\) because on a compact interval \(t\ge\epsilon>0\) the integrand is bounded by the bounded function \(\lambda^A e^{-\epsilon\lambda}\). Thus equality of the total densities almost everywhere gives equality of the transforms at all positive \(t\). Weight \(W\) by \(\lambda^A e^{-\lambda}\) and push this finite measure forward by \(u=e^{-\lambda}\), viewed as a measure on \([0,1]\). Its moment of degree \(j\ge0\) is \(M_W(j+1)\). These moments determine the measure by polynomial approximation on the compact interval. Rates may approach zero or grow without bound, and the image measure assigns zero mass to both endpoints because every legal rate maps into \((0,1)\). On this open interval the map is a Borel bijection, and after pulling back, integration against the reciprocal positive weight recovers \(W\). Thus the matching law is unique without a bound on the rates or a rate-moment assumption.

The matching law has interval support for every fixed positive width. Consequently every finite denominator has strictly larger KL divergence and calibration factor strictly above one. If only finite convex combinations are admitted in the reverse projection problem, discrete approximations to the target mixing law on \([0,1]\) yield the same infimum. Their total densities relative to the base are bounded between \(e^{-st}\) and \((1+s)^A\), so the logarithms converge under the alternative by domination.

The ordinary endpoint construction integrates \(e^{-svt}\) with \(R_\nu\), multiplies by \(F(s)\), and normalizes the resulting mixture by its mass
\[
 M_s=F(s)R_\nu((1+sv)^{-A}).
\]
Its rate atoms are \(1+sv_j\), with positive weights proportional to the quadrature weights times \((1+sv_j)^{-A}\). The unnormalized density is a pointwise upper envelope by the odd derivative of \(e^{-svt}\) and the interpolation sign in Section 3. Its ratio to the target tends to one as \(t\downarrow0\) by constant exactness. Letting the null Gamma rate tend to infinity therefore shows that the worst-null factor of the normalized mixture is exactly \(M_s\). Applying (6) to the first unmatched term of \((1+sv)^{-A}\) proves \(M_s-1=D_m s^{2m-1}+O(s^{2m})\). In the two-exponential case with \(m=2\), the nodes \(0,2/3\) have weights \(1/4,3/4\), and
\[
 M_s-1=(1+s)\left[\frac{1}{4}+\frac{3}{4(1+2s/3)^2}\right]-1
       =\frac{s^3}{(3+2s)^2}.
\]
Thus the ordinary comparison survives, along with the sharper \(s^5/108\) finite-mixture optimum, for the same experiment.

For two Gaussian observations with a common known mean and possibly different variances, the centered squares have Gamma shape \(1/2\) and respective rates \(1/(2\sigma_i^2)\). The conditional signs are identical independent fair signs under all hypotheses, so all likelihood ratios and calibration factors are preserved. In units with least inverse-variance rate one, \(A=1\), \(\nu=\mathrm{Beta}(1/2,1/2)\), and at \(m=2\), \(I=1/32,J=1/8\). This gives the sharp \(s^5/256\) coefficient in the relative inverse-variance width. This is a known-mean variance experiment. For Pareto observations with known common minimum \(v_*\), the transformation \(Y=\log(X/v_*)\) gives an exponential of rate equal to the Pareto tail shape, preserving all calibration factors [4, Section 4].

## 8. Relation to earlier results

In the printed Section 5.2 of Hao, Grünwald, Lardy, Long and Adams [4], the text describes minimizing the worst-null expectation among two-component ratios, while the Table 2 caption describes KL minimization. The near-one entries are numerical calibration diagnostics. The classical Dirichlet identity already identifies a continuous matching Gamma mixture for distinct rates. Equality in (3) requires matching the statistic exactly, and Section 7 identifies the Gamma mixing law among all probability mixtures on positive rates by tilted integer Laplace moments. Thus no finite mixture has exact calibration there, answering the qualitative conjecture in those experiments. The Gamma comparison of Section 7 quantifies the near-one phenomenon. The quantitative theorem extends it to unbounded one- and two-sided statistic supports without assuming a quadratic variance function, a density, or a consecutive lattice.

General theory identifies a growth-optimal e-variable through the reverse information projection [5,6]. Lardy, Grünwald and Harremoës [5, Theorem 6 and Example 3] relate calibration to likelihood-ratio norms under additional conditions and show failure of KL approximation alone. Hao and Grünwald [7, Sections 3.2 and 4.2] analyze continuous-prior and conditional expected log-power as the number of blocks increases. Our criterion optimizes uniform one-block calibration over a finite number of atoms as the parameter width shrinks. The two-sided constant retains the contribution of chi-square error and the minimum of a nonnegative local gap jointly.

The moment methods of Ma, Wu and Yang [8] concern approximation in distributional metrics, and Heinrich and Kahn [9] use local moment matching in statistical estimation of mixing laws. Classical endpoint quadrature [1] supplies the sign of a pointwise error. Morris [2] and Kunisky [3, Appendix A.1] give the quadratic variance and likelihood-ratio polynomial structure for the named kernels. The present proof uses ordinary base-law orthogonality and compactly restricted bounded tests to treat general unbounded supports. The statistic endpoint forces a particular nonnegative global tilt curve via (4); the local gap then has its own orthogonal-polynomial minimum determined by the alternative mixing law. The theorem fixes \(m\), uses a single sufficient statistic, and gives a shrinking-width asymptotic. Joint large-\(m\) behavior, bounded statistic supports, and multivariate null parameters remain outside its scope.

## References

1. W. Gautschi, *Gauss–Radau formulae for Jacobi and Laguerre weight functions*. Mathematics and Computers in Simulation 54, 403–412 (2000). [DOI 10.1016/S0378-4754(00)00179-8](https://doi.org/10.1016/S0378-4754(00)00179-8). J. Kautsky, *Gauss quadratures: An inverse problem*. SIAM Journal on Matrix Analysis and Applications 13(1), 402–417 (1992). [DOI 10.1137/0613027](https://doi.org/10.1137/0613027)
2. C. N. Morris, *Natural exponential families with quadratic variance functions*. Annals of Statistics 10(1), 65–80 (1982). [DOI 10.1214/aos/1176345690](https://doi.org/10.1214/aos/1176345690). See also *Statistical theory*, Annals of Statistics 11(2), 515–529 (1983). [DOI 10.1214/aos/1176346158](https://doi.org/10.1214/aos/1176346158)
3. D. Kunisky, *Hypothesis testing with low-degree polynomials in the Morris class of exponential families*. Proceedings of the 34th Conference on Learning Theory, PMLR 134, 2822–2848 (2021). [Proceedings](https://proceedings.mlr.press/v134/kunisky21a.html)
4. Y. Hao, P. Grünwald, T. Lardy, L. Long and R. Adams, *E-values for k-sample tests with exponential families*. Sankhyā A 86, 596–636 (2024). [DOI 10.1007/s13171-024-00339-9](https://ir.cwi.nl/pub/33862/33862.pdf)
5. T. Lardy, P. Grünwald and P. Harremoës, *Reverse information projections and optimal e-statistics*. IEEE Transactions on Information Theory 70(11), 7616–7631 (2024). [DOI 10.1109/TIT.2024.3444458](https://ir.cwi.nl/pub/34397/2306.16646v3-4-.pdf)
6. M. Larsson, A. Ramdas and J. Ruf, *The numeraire e-variable and reverse information projection*. Annals of Statistics 53(3), 1015–1043 (2025). [DOI 10.1214/24-AOS2487](https://doi.org/10.1214/24-AOS2487)
7. Y. Hao and P. Grünwald, *E-values for exponential families: The general case*. Bernoulli 32(4), 3113–3142 (2026). [DOI 10.3150/26-BEJ1981](https://doi.org/10.3150/26-BEJ1981), [author version used](https://arxiv.org/html/2409.11134v2)
8. Y. Ma, Y. Wu and P. Yang, *On the best approximation by finite Gaussian mixtures*. IEEE Transactions on Information Theory 71(7), 5469–5492 (2025). [DOI 10.1109/TIT.2025.3558841](https://doi.org/10.1109/TIT.2025.3558841), [author version used](https://arxiv.org/html/2404.08913v2)
9. P. Heinrich and J. Kahn, *Strong identifiability and optimal minimax rates for finite mixture estimation*. Annals of Statistics 46(6A), 2844–2870 (2018). [DOI 10.1214/17-AOS1641](https://doi.org/10.1214/17-AOS1641), [author version used](https://arxiv.org/abs/1504.03506)
